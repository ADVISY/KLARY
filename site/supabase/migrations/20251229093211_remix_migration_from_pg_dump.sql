CREATE EXTENSION IF NOT EXISTS "citext" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "plpgsql" WITH SCHEMA "pg_catalog";
CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";
BEGIN;

--
-- PostgreSQL database dump
--


-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--



--
-- Name: app_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.app_role AS ENUM (
    'admin',
    'client',
    'partner',
    'manager',
    'agent',
    'backoffice',
    'compta'
);


--
-- Name: can_access_client(uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.can_access_client(client_id uuid) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT 
    -- Admin, backoffice, compta peuvent tout voir
    has_role(auth.uid(), 'admin'::app_role)
    OR has_role(auth.uid(), 'backoffice'::app_role)
    OR has_role(auth.uid(), 'compta'::app_role)
    OR
    -- Le client lui-même
    EXISTS (
      SELECT 1 FROM clients c 
      WHERE c.id = client_id AND c.user_id = auth.uid()
    )
    OR
    -- Agent/Partner/Manager assigné au client
    EXISTS (
      SELECT 1 FROM clients agent 
      WHERE agent.user_id = auth.uid()
      AND EXISTS (
        SELECT 1 FROM clients target 
        WHERE target.id = client_id 
        AND (target.assigned_agent_id = agent.id OR target.manager_id = agent.id)
      )
    )
$$;


--
-- Name: can_view_financial_data(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.can_view_financial_data() RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT public.has_role(auth.uid(), 'admin') OR public.has_role(auth.uid(), 'compta')
$$;


--
-- Name: cleanup_rate_limits(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cleanup_rate_limits() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  DELETE FROM public.ai_rate_limits 
  WHERE window_start < now() - interval '1 hour';
END;
$$;


--
-- Name: create_audit_log(uuid, text, text, uuid, jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_audit_log(p_user_id uuid, p_action text, p_entity text, p_entity_id uuid, p_metadata jsonb DEFAULT NULL::jsonb) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_log_id BIGINT;
BEGIN
  INSERT INTO public.audit_logs (user_id, action, entity, entity_id, metadata)
  VALUES (p_user_id, p_action, p_entity, p_entity_id, p_metadata)
  RETURNING id INTO v_log_id;
  
  RETURN v_log_id;
END;
$$;


--
-- Name: get_partner_policies(uuid, text, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_partner_policies(p_partner_id uuid, p_status text DEFAULT NULL::text, p_limit integer DEFAULT 25, p_offset integer DEFAULT 0) RETURNS TABLE(id uuid, client_id uuid, client_name text, product_id uuid, product_name text, company_name text, policy_number text, status text, start_date date, end_date date, premium_monthly numeric, premium_yearly numeric, created_at timestamp with time zone)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    c.id AS client_id,
    COALESCE(c.company_name, pr.full_name) AS client_name,
    prod.id AS product_id,
    prod.name AS product_name,
    ic.name AS company_name,
    p.policy_number,
    p.status,
    p.start_date,
    p.end_date,
    p.premium_monthly,
    p.premium_yearly,
    p.created_at
  FROM public.policies p
  JOIN public.clients c ON p.client_id = c.id
  LEFT JOIN public.profiles pr ON c.user_id = pr.id
  JOIN public.insurance_products prod ON p.product_id = prod.id
  JOIN public.insurance_companies ic ON prod.company_id = ic.id
  WHERE p.partner_id = p_partner_id
    AND (p_status IS NULL OR p.status = p_status)
  ORDER BY p.created_at DESC
  LIMIT p_limit
  OFFSET p_offset;
END;
$$;


--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, first_name, last_name)
  VALUES (
    new.id,
    new.email,
    new.raw_user_meta_data->>'first_name',
    new.raw_user_meta_data->>'last_name'
  );
  
  -- Assign default 'client' role to new users
  INSERT INTO public.user_roles (user_id, role)
  VALUES (new.id, 'client');
  
  RETURN new;
END;
$$;


--
-- Name: handle_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.handle_updated_at() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


--
-- Name: has_role(uuid, public.app_role); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.has_role(_user_id uuid, _role public.app_role) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id
      AND role = _role
  )
$$;


--
-- Name: update_ai_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_ai_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


SET default_table_access_method = heap;

--
-- Name: ai_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_conversations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id text NOT NULL,
    user_type text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ai_conversations_user_type_check CHECK ((user_type = ANY (ARRAY['client'::text, 'conseiller'::text, 'unknown'::text])))
);


--
-- Name: ai_leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_leads (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    nom text,
    prenom text,
    email text,
    telephone text,
    canton text,
    situation_familiale text,
    notes text,
    status text DEFAULT 'nouveau'::text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ai_leads_status_check CHECK ((status = ANY (ARRAY['nouveau'::text, 'contacte'::text, 'converti'::text, 'archive'::text])))
);


--
-- Name: ai_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conversation_id uuid NOT NULL,
    role text NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ai_messages_role_check CHECK ((role = ANY (ARRAY['user'::text, 'assistant'::text, 'system'::text])))
);


--
-- Name: ai_rate_limits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ai_rate_limits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    session_id text NOT NULL,
    ip_address text,
    request_count integer DEFAULT 1,
    window_start timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    user_id uuid,
    action text NOT NULL,
    entity text,
    entity_id uuid,
    metadata jsonb,
    ip_address inet,
    user_agent text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: claim_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.claim_documents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    claim_id uuid NOT NULL,
    document_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: claims; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.claims (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    policy_id uuid,
    claim_type text NOT NULL,
    incident_date date NOT NULL,
    description text NOT NULL,
    status text DEFAULT 'submitted'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    external_ref text,
    birthdate date,
    company_name text,
    is_company boolean DEFAULT false,
    phone text,
    address text,
    city text,
    postal_code text,
    country text DEFAULT 'CH'::text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    iban text,
    assigned_agent_id uuid,
    first_name text,
    last_name text,
    zip_code text,
    mobile text,
    status text DEFAULT 'prospect'::text,
    tags text[],
    email text,
    type_adresse text DEFAULT 'client'::text NOT NULL,
    civil_status text,
    permit_type text,
    nationality text,
    profession text,
    employer text,
    bank_name text,
    commission_rate numeric DEFAULT 0,
    fixed_salary numeric DEFAULT 0,
    bonus_rate numeric DEFAULT 0,
    contract_type text DEFAULT 'cdi'::text,
    work_percentage numeric DEFAULT 100,
    hire_date date,
    commission_rate_lca numeric DEFAULT 0,
    commission_rate_vie numeric DEFAULT 0,
    manager_id uuid,
    manager_commission_rate_lca numeric DEFAULT 0,
    manager_commission_rate_vie numeric DEFAULT 0,
    reserve_rate numeric DEFAULT 0,
    canton text,
    CONSTRAINT clients_civil_status_check CHECK ((civil_status = ANY (ARRAY['célibataire'::text, 'marié'::text, 'divorcé'::text, 'séparé'::text, 'veuf'::text]))),
    CONSTRAINT clients_permit_type_check CHECK ((permit_type = ANY (ARRAY['B'::text, 'C'::text, 'G'::text, 'L'::text, 'Autre'::text]))),
    CONSTRAINT clients_status_check CHECK ((status = ANY (ARRAY['prospect'::text, 'actif'::text, 'résilié'::text, 'dormant'::text]))),
    CONSTRAINT clients_type_adresse_check CHECK ((type_adresse = ANY (ARRAY['client'::text, 'collaborateur'::text, 'partenaire'::text])))
);


--
-- Name: clients_safe; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.clients_safe WITH (security_invoker='on') AS
 SELECT id,
    user_id,
    birthdate,
    is_company,
    created_at,
    updated_at,
    assigned_agent_id,
        CASE
            WHEN public.can_view_financial_data() THEN commission_rate
            ELSE NULL::numeric
        END AS commission_rate,
        CASE
            WHEN public.can_view_financial_data() THEN fixed_salary
            ELSE NULL::numeric
        END AS fixed_salary,
        CASE
            WHEN public.can_view_financial_data() THEN bonus_rate
            ELSE NULL::numeric
        END AS bonus_rate,
    work_percentage,
    hire_date,
        CASE
            WHEN public.can_view_financial_data() THEN commission_rate_lca
            ELSE NULL::numeric
        END AS commission_rate_lca,
        CASE
            WHEN public.can_view_financial_data() THEN commission_rate_vie
            ELSE NULL::numeric
        END AS commission_rate_vie,
    manager_id,
        CASE
            WHEN public.can_view_financial_data() THEN manager_commission_rate_lca
            ELSE NULL::numeric
        END AS manager_commission_rate_lca,
        CASE
            WHEN public.can_view_financial_data() THEN manager_commission_rate_vie
            ELSE NULL::numeric
        END AS manager_commission_rate_vie,
        CASE
            WHEN public.can_view_financial_data() THEN reserve_rate
            ELSE NULL::numeric
        END AS reserve_rate,
    external_ref,
    company_name,
    phone,
    address,
    city,
    postal_code,
    country,
        CASE
            WHEN public.can_view_financial_data() THEN iban
            ELSE '****'::text
        END AS iban,
    first_name,
    last_name,
    zip_code,
    mobile,
    status,
    tags,
    email,
    type_adresse,
    civil_status,
    permit_type,
    nationality,
    profession,
    employer,
        CASE
            WHEN public.can_view_financial_data() THEN bank_name
            ELSE NULL::text
        END AS bank_name,
    contract_type,
    canton
   FROM public.clients;


--
-- Name: collaborator_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collaborator_permissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    collaborator_id uuid NOT NULL,
    module text NOT NULL,
    can_read boolean DEFAULT false NOT NULL,
    can_create boolean DEFAULT false NOT NULL,
    can_update boolean DEFAULT false NOT NULL,
    can_delete boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: commission_part_agent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commission_part_agent (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    commission_id uuid NOT NULL,
    agent_id uuid NOT NULL,
    rate numeric NOT NULL,
    amount numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commissions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    policy_id uuid NOT NULL,
    partner_id uuid,
    amount numeric(12,2) NOT NULL,
    status text DEFAULT 'due'::text NOT NULL,
    period_month integer,
    period_year integer,
    paid_at timestamp with time zone,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    type text DEFAULT 'acquisition'::text,
    total_amount numeric,
    date date DEFAULT CURRENT_DATE,
    CONSTRAINT commissions_period_month_check CHECK (((period_month >= 1) AND (period_month <= 12))),
    CONSTRAINT commissions_period_year_check CHECK (((period_year >= 2000) AND (period_year <= 2100))),
    CONSTRAINT commissions_status_check CHECK ((status = ANY (ARRAY['paid'::text, 'due'::text, 'pending'::text]))),
    CONSTRAINT commissions_type_check CHECK ((type = ANY (ARRAY['acquisition'::text, 'renewal'::text, 'bonus'::text, 'gestion'::text])))
);


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contracts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    policy_id uuid NOT NULL,
    signature_status text DEFAULT 'pending'::text NOT NULL,
    signature_provider text,
    signed_at timestamp with time zone,
    canceled_at timestamp with time zone,
    renewal_date date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT contracts_signature_status_check CHECK ((signature_status = ANY (ARRAY['signed'::text, 'pending'::text, 'refused'::text])))
);


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    owner_type text NOT NULL,
    owner_id uuid NOT NULL,
    file_name text NOT NULL,
    file_key text NOT NULL,
    mime_type text,
    size_bytes bigint,
    doc_kind text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT documents_owner_type_check CHECK ((owner_type = ANY (ARRAY['client'::text, 'policy'::text, 'contract'::text, 'partner'::text])))
);


--
-- Name: family_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.family_members (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    birth_date date,
    relation_type text NOT NULL,
    permit_type text,
    nationality text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT family_members_permit_type_check CHECK ((permit_type = ANY (ARRAY['B'::text, 'C'::text, 'G'::text, 'L'::text, 'Autre'::text]))),
    CONSTRAINT family_members_relation_type_check CHECK ((relation_type = ANY (ARRAY['conjoint'::text, 'enfant'::text, 'autre'::text])))
);


--
-- Name: insurance_companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.insurance_companies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    logo_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: insurance_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.insurance_products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT insurance_products_category_check CHECK ((category = ANY (ARRAY['auto'::text, 'home'::text, 'health'::text, 'life'::text, 'rcpro'::text, 'multirisque'::text, 'legal'::text, 'third_pillar'::text])))
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    thread_key text NOT NULL,
    sender_user_id uuid,
    body text,
    has_attachments boolean DEFAULT false,
    read_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages_clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages_clients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    direction text NOT NULL,
    channel text NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT messages_channel_check CHECK ((channel = ANY (ARRAY['email'::text, 'whatsapp'::text, 'sms'::text, 'autre'::text]))),
    CONSTRAINT messages_direction_check CHECK ((direction = ANY (ARRAY['entrant'::text, 'sortant'::text])))
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    kind text NOT NULL,
    title text NOT NULL,
    message text,
    payload jsonb,
    read_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: partners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partners (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    code text,
    manager_partner_id uuid,
    phone text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    product_id uuid NOT NULL,
    partner_id uuid,
    policy_number text,
    status text DEFAULT 'pending'::text NOT NULL,
    start_date date NOT NULL,
    end_date date,
    premium_monthly numeric(12,2),
    premium_yearly numeric(12,2),
    deductible numeric(12,2),
    currency text DEFAULT 'CHF'::text NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    company_name text,
    product_type text,
    products_data jsonb DEFAULT '[]'::jsonb,
    CONSTRAINT policies_status_check CHECK ((status = ANY (ARRAY['active'::text, 'pending'::text, 'suspended'::text, 'cancelled'::text, 'expired'::text])))
);


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text NOT NULL,
    first_name text,
    last_name text,
    phone text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true
);


--
-- Name: propositions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.propositions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    agent_id uuid,
    company_name text,
    product_type text,
    monthly_premium numeric,
    yearly_premium numeric,
    status text DEFAULT 'brouillon'::text,
    start_date date,
    end_date date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT propositions_status_check CHECK ((status = ANY (ARRAY['brouillon'::text, 'envoyée'::text, 'signée'::text, 'refusée'::text])))
);


--
-- Name: suivis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suivis (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    client_id uuid NOT NULL,
    assigned_agent_id uuid,
    type text,
    status text DEFAULT 'ouvert'::text,
    title text NOT NULL,
    description text,
    reminder_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT suivis_status_check CHECK ((status = ANY (ARRAY['ouvert'::text, 'en_cours'::text, 'fermé'::text])))
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role public.app_role NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: ai_conversations ai_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_conversations
    ADD CONSTRAINT ai_conversations_pkey PRIMARY KEY (id);


--
-- Name: ai_leads ai_leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_leads
    ADD CONSTRAINT ai_leads_pkey PRIMARY KEY (id);


--
-- Name: ai_messages ai_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_messages
    ADD CONSTRAINT ai_messages_pkey PRIMARY KEY (id);


--
-- Name: ai_rate_limits ai_rate_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_rate_limits
    ADD CONSTRAINT ai_rate_limits_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: claim_documents claim_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_documents
    ADD CONSTRAINT claim_documents_pkey PRIMARY KEY (id);


--
-- Name: claims claims_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clients clients_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_user_id_key UNIQUE (user_id);


--
-- Name: collaborator_permissions collaborator_permissions_collaborator_id_module_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collaborator_permissions
    ADD CONSTRAINT collaborator_permissions_collaborator_id_module_key UNIQUE (collaborator_id, module);


--
-- Name: collaborator_permissions collaborator_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collaborator_permissions
    ADD CONSTRAINT collaborator_permissions_pkey PRIMARY KEY (id);


--
-- Name: commission_part_agent commission_part_agent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commission_part_agent
    ADD CONSTRAINT commission_part_agent_pkey PRIMARY KEY (id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (id);


--
-- Name: insurance_companies insurance_companies_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_companies
    ADD CONSTRAINT insurance_companies_name_key UNIQUE (name);


--
-- Name: insurance_companies insurance_companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_companies
    ADD CONSTRAINT insurance_companies_pkey PRIMARY KEY (id);


--
-- Name: insurance_products insurance_products_company_id_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_products
    ADD CONSTRAINT insurance_products_company_id_name_key UNIQUE (company_id, name);


--
-- Name: insurance_products insurance_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_products
    ADD CONSTRAINT insurance_products_pkey PRIMARY KEY (id);


--
-- Name: messages_clients messages_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages_clients
    ADD CONSTRAINT messages_clients_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: partners partners_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_code_key UNIQUE (code);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: partners partners_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_user_id_key UNIQUE (user_id);


--
-- Name: policies policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: propositions propositions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propositions
    ADD CONSTRAINT propositions_pkey PRIMARY KEY (id);


--
-- Name: suivis suivis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suivis
    ADD CONSTRAINT suivis_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_user_id_role_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_role_key UNIQUE (user_id, role);


--
-- Name: idx_ai_leads_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_leads_conversation_id ON public.ai_leads USING btree (conversation_id);


--
-- Name: idx_ai_leads_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_leads_status ON public.ai_leads USING btree (status);


--
-- Name: idx_ai_messages_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_messages_conversation_id ON public.ai_messages USING btree (conversation_id);


--
-- Name: idx_ai_messages_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_messages_created_at ON public.ai_messages USING btree (created_at);


--
-- Name: idx_ai_rate_limits_ip; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_rate_limits_ip ON public.ai_rate_limits USING btree (ip_address, window_start);


--
-- Name: idx_ai_rate_limits_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ai_rate_limits_session ON public.ai_rate_limits USING btree (session_id, window_start);


--
-- Name: idx_audit_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_action ON public.audit_logs USING btree (action);


--
-- Name: idx_audit_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_entity ON public.audit_logs USING btree (entity, entity_id);


--
-- Name: idx_audit_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_user ON public.audit_logs USING btree (user_id, created_at);


--
-- Name: idx_clients_assigned_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_assigned_agent ON public.clients USING btree (assigned_agent_id);


--
-- Name: idx_clients_company; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_company ON public.clients USING btree (is_company);


--
-- Name: idx_clients_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_email ON public.clients USING btree (email);


--
-- Name: idx_clients_manager_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_manager_id ON public.clients USING btree (manager_id);


--
-- Name: idx_clients_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_status ON public.clients USING btree (status);


--
-- Name: idx_clients_type_adresse; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_type_adresse ON public.clients USING btree (type_adresse);


--
-- Name: idx_clients_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clients_user ON public.clients USING btree (user_id);


--
-- Name: idx_collaborator_permissions_collaborator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_collaborator_permissions_collaborator ON public.collaborator_permissions USING btree (collaborator_id);


--
-- Name: idx_collaborator_permissions_module; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_collaborator_permissions_module ON public.collaborator_permissions USING btree (module);


--
-- Name: idx_commission_part_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commission_part_agent ON public.commission_part_agent USING btree (agent_id);


--
-- Name: idx_commissions_partner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commissions_partner ON public.commissions USING btree (partner_id, status);


--
-- Name: idx_commissions_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commissions_period ON public.commissions USING btree (period_year, period_month);


--
-- Name: idx_commissions_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commissions_policy ON public.commissions USING btree (policy_id);


--
-- Name: idx_contracts_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contracts_policy ON public.contracts USING btree (policy_id);


--
-- Name: idx_contracts_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_contracts_status ON public.contracts USING btree (signature_status);


--
-- Name: idx_documents_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_kind ON public.documents USING btree (doc_kind);


--
-- Name: idx_documents_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_owner ON public.documents USING btree (owner_type, owner_id);


--
-- Name: idx_family_members_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_family_members_client_id ON public.family_members USING btree (client_id);


--
-- Name: idx_messages_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_client ON public.messages_clients USING btree (client_id);


--
-- Name: idx_messages_sender; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_sender ON public.messages USING btree (sender_user_id);


--
-- Name: idx_messages_thread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_thread ON public.messages USING btree (thread_key, created_at);


--
-- Name: idx_notifications_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_kind ON public.notifications USING btree (kind);


--
-- Name: idx_notifications_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id, read_at);


--
-- Name: idx_partners_manager; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partners_manager ON public.partners USING btree (manager_partner_id);


--
-- Name: idx_policies_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_policies_client ON public.policies USING btree (client_id);


--
-- Name: idx_policies_dates; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_policies_dates ON public.policies USING btree (start_date, end_date);


--
-- Name: idx_policies_partner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_policies_partner ON public.policies USING btree (partner_id);


--
-- Name: idx_policies_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_policies_status ON public.policies USING btree (status);


--
-- Name: idx_products_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_category ON public.insurance_products USING btree (category);


--
-- Name: idx_products_company; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_products_company ON public.insurance_products USING btree (company_id);


--
-- Name: idx_propositions_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_propositions_agent ON public.propositions USING btree (agent_id);


--
-- Name: idx_propositions_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_propositions_client ON public.propositions USING btree (client_id);


--
-- Name: idx_suivis_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suivis_agent ON public.suivis USING btree (assigned_agent_id);


--
-- Name: idx_suivis_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suivis_client ON public.suivis USING btree (client_id);


--
-- Name: profiles on_profiles_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_profiles_updated BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: ai_conversations update_ai_conversations_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ai_conversations_updated_at BEFORE UPDATE ON public.ai_conversations FOR EACH ROW EXECUTE FUNCTION public.update_ai_updated_at_column();


--
-- Name: ai_leads update_ai_leads_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_ai_leads_updated_at BEFORE UPDATE ON public.ai_leads FOR EACH ROW EXECUTE FUNCTION public.update_ai_updated_at_column();


--
-- Name: claims update_claims_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_claims_updated_at BEFORE UPDATE ON public.claims FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: clients update_clients_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_clients_updated_at BEFORE UPDATE ON public.clients FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: collaborator_permissions update_collaborator_permissions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_collaborator_permissions_updated_at BEFORE UPDATE ON public.collaborator_permissions FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: commissions update_commissions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_commissions_updated_at BEFORE UPDATE ON public.commissions FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: contracts update_contracts_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_contracts_updated_at BEFORE UPDATE ON public.contracts FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: family_members update_family_members_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_family_members_updated_at BEFORE UPDATE ON public.family_members FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: partners update_partners_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_partners_updated_at BEFORE UPDATE ON public.partners FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: policies update_policies_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_policies_updated_at BEFORE UPDATE ON public.policies FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();


--
-- Name: propositions update_propositions_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_propositions_updated_at BEFORE UPDATE ON public.propositions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: suivis update_suivis_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_suivis_updated_at BEFORE UPDATE ON public.suivis FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: ai_leads ai_leads_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_leads
    ADD CONSTRAINT ai_leads_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.ai_conversations(id) ON DELETE CASCADE;


--
-- Name: ai_messages ai_messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ai_messages
    ADD CONSTRAINT ai_messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.ai_conversations(id) ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: claim_documents claim_documents_claim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_documents
    ADD CONSTRAINT claim_documents_claim_id_fkey FOREIGN KEY (claim_id) REFERENCES public.claims(id) ON DELETE CASCADE;


--
-- Name: claim_documents claim_documents_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_documents
    ADD CONSTRAINT claim_documents_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE CASCADE;


--
-- Name: claims claims_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: claims claims_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claims
    ADD CONSTRAINT claims_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(id) ON DELETE SET NULL;


--
-- Name: clients clients_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.clients(id) ON DELETE SET NULL;


--
-- Name: clients clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL;


--
-- Name: collaborator_permissions collaborator_permissions_collaborator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collaborator_permissions
    ADD CONSTRAINT collaborator_permissions_collaborator_id_fkey FOREIGN KEY (collaborator_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: commission_part_agent commission_part_agent_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commission_part_agent
    ADD CONSTRAINT commission_part_agent_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: commission_part_agent commission_part_agent_commission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commission_part_agent
    ADD CONSTRAINT commission_part_agent_commission_id_fkey FOREIGN KEY (commission_id) REFERENCES public.commissions(id) ON DELETE CASCADE;


--
-- Name: commissions commissions_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: commissions commissions_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(id) ON DELETE CASCADE;


--
-- Name: contracts contracts_policy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_policy_id_fkey FOREIGN KEY (policy_id) REFERENCES public.policies(id) ON DELETE CASCADE;


--
-- Name: documents documents_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- Name: family_members family_members_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: clients fk_clients_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_clients_user_id FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: insurance_products insurance_products_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.insurance_products
    ADD CONSTRAINT insurance_products_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.insurance_companies(id) ON DELETE CASCADE;


--
-- Name: messages_clients messages_clients_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages_clients
    ADD CONSTRAINT messages_clients_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: messages messages_sender_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_user_id_fkey FOREIGN KEY (sender_user_id) REFERENCES auth.users(id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: partners partners_manager_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_manager_partner_id_fkey FOREIGN KEY (manager_partner_id) REFERENCES public.partners(id);


--
-- Name: partners partners_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: policies policies_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: policies policies_partner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: policies policies_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policies
    ADD CONSTRAINT policies_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.insurance_products(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: propositions propositions_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propositions
    ADD CONSTRAINT propositions_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.profiles(id);


--
-- Name: propositions propositions_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.propositions
    ADD CONSTRAINT propositions_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: suivis suivis_assigned_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suivis
    ADD CONSTRAINT suivis_assigned_agent_id_fkey FOREIGN KEY (assigned_agent_id) REFERENCES public.profiles(id);


--
-- Name: suivis suivis_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suivis
    ADD CONSTRAINT suivis_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: claims Admin can delete claims; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admin can delete claims" ON public.claims FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: profiles Admins and agents can view all profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins and agents can view all profiles" ON public.profiles FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role)));


--
-- Name: user_roles Admins and agents can view all roles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins and agents can view all roles" ON public.user_roles FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role)));


--
-- Name: commission_part_agent Admins and compta can manage commission parts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins and compta can manage commission parts" ON public.commission_part_agent FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'compta'::public.app_role)));


--
-- Name: commission_part_agent Admins and compta can update commission parts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins and compta can update commission parts" ON public.commission_part_agent FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'compta'::public.app_role)));


--
-- Name: commission_part_agent Admins can delete commission parts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can delete commission parts" ON public.commission_part_agent FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: family_members Admins can delete family members; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can delete family members" ON public.family_members FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: messages_clients Admins can delete messages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can delete messages" ON public.messages_clients FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: propositions Admins can delete propositions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can delete propositions" ON public.propositions FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: suivis Admins can delete suivis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can delete suivis" ON public.suivis FOR DELETE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: commissions Admins can manage all commissions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all commissions" ON public.commissions USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: documents Admins can manage all documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all documents" ON public.documents USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: family_members Admins can manage all family members; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all family members" ON public.family_members USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: partners Admins can manage all partners; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all partners" ON public.partners USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: collaborator_permissions Admins can manage all permissions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all permissions" ON public.collaborator_permissions USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: policies Admins can manage all policies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage all policies" ON public.policies USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: insurance_companies Admins can manage insurance companies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage insurance companies" ON public.insurance_companies USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: insurance_products Admins can manage insurance products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can manage insurance products" ON public.insurance_products USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: ai_conversations Admins can update conversations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can update conversations" ON public.ai_conversations FOR UPDATE USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: audit_logs Admins can view audit logs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins can view audit logs" ON public.audit_logs FOR SELECT USING (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: clients Admins have full access; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Admins have full access" ON public.clients USING (public.has_role(auth.uid(), 'admin'::public.app_role)) WITH CHECK (public.has_role(auth.uid(), 'admin'::public.app_role));


--
-- Name: propositions Agents can create propositions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Agents can create propositions" ON public.propositions FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role)));


--
-- Name: suivis Agents can create suivis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Agents can create suivis" ON public.suivis FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role)));


--
-- Name: propositions Agents can update their propositions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Agents can update their propositions" ON public.propositions FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (agent_id = auth.uid())));


--
-- Name: suivis Agents can update their suivis; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Agents can update their suivis" ON public.suivis FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (assigned_agent_id = auth.uid())));


--
-- Name: ai_leads Anyone can submit leads; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anyone can submit leads" ON public.ai_leads FOR INSERT WITH CHECK (true);


--
-- Name: insurance_companies Anyone can view insurance companies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anyone can view insurance companies" ON public.insurance_companies FOR SELECT USING (true);


--
-- Name: insurance_products Anyone can view insurance products; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Anyone can view insurance products" ON public.insurance_products FOR SELECT USING (true);


--
-- Name: profiles Block unauthenticated access to profiles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Block unauthenticated access to profiles" ON public.profiles FOR SELECT USING ((auth.uid() IS NOT NULL));


--
-- Name: claims Clients can create their own claims; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Clients can create their own claims" ON public.claims FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM public.clients c
  WHERE ((c.id = claims.client_id) AND (c.user_id = auth.uid())))) OR public.has_role(auth.uid(), 'admin'::public.app_role)));


--
-- Name: clients Clients can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Clients can update their own profile" ON public.clients FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: claims Clients can view their own claims; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Clients can view their own claims" ON public.claims FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.clients c
  WHERE ((c.id = claims.client_id) AND (c.user_id = auth.uid())))) OR public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: policies Clients can view their own policies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Clients can view their own policies" ON public.policies FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = policies.client_id) AND (clients.user_id = auth.uid())))) OR public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.partners
  WHERE ((partners.id = policies.partner_id) AND (partners.user_id = auth.uid()))))));


--
-- Name: clients Partners and admins can create clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners and admins can create clients" ON public.clients FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'partner'::public.app_role)));


--
-- Name: policies Partners can create policies for their clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can create policies for their clients" ON public.policies FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.partners
  WHERE ((partners.id = policies.partner_id) AND (partners.user_id = auth.uid()))))));


--
-- Name: contracts Partners can manage contracts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can manage contracts" ON public.contracts USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM (public.policies p
     JOIN public.partners pt ON ((p.partner_id = pt.id)))
  WHERE ((p.id = contracts.policy_id) AND (pt.user_id = auth.uid()))))));


--
-- Name: clients Partners can update clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can update clients" ON public.clients FOR UPDATE USING ((public.has_role(auth.uid(), 'partner'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: partners Partners can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can update their own profile" ON public.partners FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: policies Partners can update their policies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can update their policies" ON public.policies FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.partners
  WHERE ((partners.id = policies.partner_id) AND (partners.user_id = auth.uid()))))));


--
-- Name: commissions Partners can view their own commissions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Partners can view their own commissions" ON public.commissions FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.partners
  WHERE ((partners.id = commissions.partner_id) AND (partners.user_id = auth.uid()))))));


--
-- Name: ai_rate_limits Service role only for rate limits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Service role only for rate limits" ON public.ai_rate_limits USING (false) WITH CHECK (false);


--
-- Name: family_members Staff can create family members; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can create family members" ON public.family_members FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'partner'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: claims Staff can update claims; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can update claims" ON public.claims FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: family_members Staff can update family members; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can update family members" ON public.family_members FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'partner'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: ai_leads Staff can update leads; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can update leads" ON public.ai_leads FOR UPDATE USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: ai_leads Staff can view leads; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can view leads" ON public.ai_leads FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: ai_messages Staff can view messages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can view messages" ON public.ai_messages FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: collaborator_permissions Staff can view permissions; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Staff can view permissions" ON public.collaborator_permissions FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: audit_logs System can create audit logs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "System can create audit logs" ON public.audit_logs FOR INSERT WITH CHECK (true);


--
-- Name: notifications System can create notifications; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "System can create notifications" ON public.notifications FOR INSERT WITH CHECK (true);


--
-- Name: claim_documents Users can create claim documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create claim documents" ON public.claim_documents FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM (public.claims cl
     JOIN public.clients c ON ((cl.client_id = c.id)))
  WHERE ((cl.id = claim_documents.claim_id) AND (c.user_id = auth.uid())))) OR public.has_role(auth.uid(), 'admin'::public.app_role)));


--
-- Name: ai_conversations Users can create conversations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create conversations" ON public.ai_conversations FOR INSERT WITH CHECK (true);


--
-- Name: documents Users can create documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create documents" ON public.documents FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'partner'::public.app_role) OR (created_by = auth.uid())));


--
-- Name: ai_messages Users can create messages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create messages" ON public.ai_messages FOR INSERT WITH CHECK (true);


--
-- Name: messages Users can create messages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create messages" ON public.messages FOR INSERT WITH CHECK ((sender_user_id = auth.uid()));


--
-- Name: messages_clients Users can create messages; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can create messages" ON public.messages_clients FOR INSERT WITH CHECK ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: notifications Users can update their own notifications; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own notifications" ON public.notifications FOR UPDATE USING ((user_id = auth.uid()));


--
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- Name: clients Users can view accessible clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view accessible clients" ON public.clients FOR SELECT USING (public.can_access_client(id));


--
-- Name: contracts Users can view contracts for their policies; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view contracts for their policies" ON public.contracts FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM (public.policies p
     JOIN public.clients c ON ((p.client_id = c.id)))
  WHERE ((p.id = contracts.policy_id) AND (c.user_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM (public.policies p
     JOIN public.partners pt ON ((p.partner_id = pt.id)))
  WHERE ((p.id = contracts.policy_id) AND (pt.user_id = auth.uid()))))));


--
-- Name: family_members Users can view family members for their clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view family members for their clients" ON public.family_members FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'partner'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'manager'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = family_members.client_id) AND ((clients.user_id = auth.uid()) OR (clients.assigned_agent_id = auth.uid())))))));


--
-- Name: messages_clients Users can view messages for their clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view messages for their clients" ON public.messages_clients FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = messages_clients.client_id) AND ((clients.user_id = auth.uid()) OR (clients.assigned_agent_id = auth.uid())))))));


--
-- Name: messages Users can view messages in their threads; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view messages in their threads" ON public.messages FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (sender_user_id = auth.uid()) OR (thread_key ~~ (('%'::text || (auth.uid())::text) || '%'::text))));


--
-- Name: propositions Users can view propositions for their clients; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view propositions for their clients" ON public.propositions FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (agent_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = propositions.client_id) AND ((clients.user_id = auth.uid()) OR (clients.assigned_agent_id = auth.uid())))))));


--
-- Name: suivis Users can view suivis for their clients or assigned to them; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view suivis for their clients or assigned to them" ON public.suivis FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (assigned_agent_id = auth.uid()) OR (EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = suivis.client_id) AND ((clients.user_id = auth.uid()) OR (clients.assigned_agent_id = auth.uid())))))));


--
-- Name: claim_documents Users can view their claim documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their claim documents" ON public.claim_documents FOR SELECT USING (((EXISTS ( SELECT 1
   FROM (public.claims cl
     JOIN public.clients c ON ((cl.client_id = c.id)))
  WHERE ((cl.id = claim_documents.claim_id) AND (c.user_id = auth.uid())))) OR public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role) OR public.has_role(auth.uid(), 'backoffice'::public.app_role)));


--
-- Name: commission_part_agent Users can view their own commission parts; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own commission parts" ON public.commission_part_agent FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'compta'::public.app_role) OR (agent_id = auth.uid())));


--
-- Name: documents Users can view their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own documents" ON public.documents FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR (created_by = auth.uid()) OR ((owner_type = 'client'::text) AND (EXISTS ( SELECT 1
   FROM public.clients
  WHERE ((clients.id = documents.owner_id) AND (clients.user_id = auth.uid()))))) OR ((owner_type = 'policy'::text) AND (EXISTS ( SELECT 1
   FROM (public.policies p
     JOIN public.clients c ON ((p.client_id = c.id)))
  WHERE ((p.id = documents.owner_id) AND (c.user_id = auth.uid()))))) OR ((owner_type = 'policy'::text) AND (EXISTS ( SELECT 1
   FROM (public.policies p
     JOIN public.partners pt ON ((p.partner_id = pt.id)))
  WHERE ((p.id = documents.owner_id) AND (pt.user_id = auth.uid()))))) OR ((owner_type = 'partner'::text) AND (EXISTS ( SELECT 1
   FROM public.partners
  WHERE ((partners.id = documents.owner_id) AND (partners.user_id = auth.uid())))))));


--
-- Name: notifications Users can view their own notifications; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own notifications" ON public.notifications FOR SELECT USING ((user_id = auth.uid()));


--
-- Name: partners Users can view their own partner profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own partner profile" ON public.partners FOR SELECT USING (((auth.uid() = user_id) OR public.has_role(auth.uid(), 'admin'::public.app_role)));


--
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- Name: user_roles Users can view their own roles; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own roles" ON public.user_roles FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: ai_conversations Users can view their session conversations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their session conversations" ON public.ai_conversations FOR SELECT USING ((public.has_role(auth.uid(), 'admin'::public.app_role) OR public.has_role(auth.uid(), 'agent'::public.app_role)));


--
-- Name: ai_conversations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.ai_conversations ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_leads; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.ai_leads ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_messages; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.ai_messages ENABLE ROW LEVEL SECURITY;

--
-- Name: ai_rate_limits; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.ai_rate_limits ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_logs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: claim_documents; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.claim_documents ENABLE ROW LEVEL SECURITY;

--
-- Name: claims; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.claims ENABLE ROW LEVEL SECURITY;

--
-- Name: clients; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.clients ENABLE ROW LEVEL SECURITY;

--
-- Name: collaborator_permissions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.collaborator_permissions ENABLE ROW LEVEL SECURITY;

--
-- Name: commission_part_agent; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.commission_part_agent ENABLE ROW LEVEL SECURITY;

--
-- Name: commissions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.commissions ENABLE ROW LEVEL SECURITY;

--
-- Name: contracts; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.contracts ENABLE ROW LEVEL SECURITY;

--
-- Name: documents; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;

--
-- Name: family_members; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.family_members ENABLE ROW LEVEL SECURITY;

--
-- Name: insurance_companies; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.insurance_companies ENABLE ROW LEVEL SECURITY;

--
-- Name: insurance_products; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.insurance_products ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: messages_clients; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.messages_clients ENABLE ROW LEVEL SECURITY;

--
-- Name: notifications; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

--
-- Name: partners; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.partners ENABLE ROW LEVEL SECURITY;

--
-- Name: policies; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.policies ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: propositions; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.propositions ENABLE ROW LEVEL SECURITY;

--
-- Name: suivis; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.suivis ENABLE ROW LEVEL SECURITY;

--
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- PostgreSQL database dump complete
--




COMMIT;