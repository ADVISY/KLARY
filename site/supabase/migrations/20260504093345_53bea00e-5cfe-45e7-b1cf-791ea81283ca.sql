-- Table des candidatures
CREATE TABLE public.recruitment_applications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL DEFAULT 'nouveau',

  -- Identité
  first_name text NOT NULL,
  last_name text NOT NULL,
  birth_date date,
  nationality text,
  permit_type text,
  civil_status text,
  address text,
  postal_code text,
  city text,
  canton text,

  -- Contact
  email text NOT NULL,
  phone text,
  mobile text,

  -- Profil pro
  position_sought text,
  finma_status text,
  finma_number text,
  years_experience text,
  current_employer text,
  availability text,
  salary_expectation text,

  -- Formation & langues
  highest_diploma text,
  languages jsonb DEFAULT '[]'::jsonb,

  -- Mobilité
  driving_license boolean DEFAULT false,
  has_vehicle boolean DEFAULT false,
  cantons_covered text[],

  -- Déclarations
  criminal_record_clean boolean DEFAULT false,
  debt_record_clean boolean DEFAULT false,
  afa_up_to_date boolean DEFAULT false,

  -- Motivation
  why_advisy text,
  message text,

  -- Documents (chemins dans le bucket recruitment-docs)
  documents jsonb DEFAULT '[]'::jsonb,

  -- RGPD
  consent_given boolean NOT NULL DEFAULT false
);

ALTER TABLE public.recruitment_applications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit applications"
ON public.recruitment_applications FOR INSERT
WITH CHECK (true);

CREATE POLICY "Admins can view applications"
ON public.recruitment_applications FOR SELECT
USING (has_role(auth.uid(), 'admin'::app_role));

CREATE POLICY "Admins can update applications"
ON public.recruitment_applications FOR UPDATE
USING (has_role(auth.uid(), 'admin'::app_role));

CREATE POLICY "Admins can delete applications"
ON public.recruitment_applications FOR DELETE
USING (has_role(auth.uid(), 'admin'::app_role));

CREATE TRIGGER trg_recruitment_applications_updated_at
BEFORE UPDATE ON public.recruitment_applications
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Bucket privé pour les documents
INSERT INTO storage.buckets (id, name, public)
VALUES ('recruitment-docs', 'recruitment-docs', false)
ON CONFLICT (id) DO NOTHING;

-- Upload public (formulaire ouvert)
CREATE POLICY "Anyone can upload recruitment docs"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'recruitment-docs');

-- Lecture/gestion réservée aux admins
CREATE POLICY "Admins can read recruitment docs"
ON storage.objects FOR SELECT
USING (bucket_id = 'recruitment-docs' AND has_role(auth.uid(), 'admin'::app_role));

CREATE POLICY "Admins can update recruitment docs"
ON storage.objects FOR UPDATE
USING (bucket_id = 'recruitment-docs' AND has_role(auth.uid(), 'admin'::app_role));

CREATE POLICY "Admins can delete recruitment docs"
ON storage.objects FOR DELETE
USING (bucket_id = 'recruitment-docs' AND has_role(auth.uid(), 'admin'::app_role));