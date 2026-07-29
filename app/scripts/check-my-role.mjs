import { readFileSync, existsSync } from "node:fs";
import { createClient } from "@supabase/supabase-js";

const envPath = new URL("../.env.local", import.meta.url);
if (existsSync(envPath)) {
  for (const line of readFileSync(envPath, "utf8").split("\n")) {
    const m = line.match(/^\s*([A-Z_][A-Z0-9_]*)\s*=\s*(.*)\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2].replace(/^['"]|['"]$/g, "");
  }
}

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  { auth: { persistSession: false } }
);

console.log("═══ TOUS les user_roles (peu importe active) ═══");
const { data: rows } = await supabase
  .from("user_roles")
  .select("*")
  .order("role");
for (const r of rows || []) {
  console.log(
    `  ${r.active ? "✓" : "✗"} role=${r.role.padEnd(8)} · ${(r.first_name || "—").padEnd(10)} ${r.last_name || "—"} · uid=${r.user_id.slice(0, 8)}`
  );
}

console.log("\n═══ auth.users (via admin API) ═══");
const { data: authUsers } = await supabase.auth.admin.listUsers({
  page: 1,
  perPage: 100,
});
for (const u of authUsers?.users || []) {
  console.log(`  ${u.email.padEnd(30)} uid=${u.id.slice(0, 8)}`);
}
