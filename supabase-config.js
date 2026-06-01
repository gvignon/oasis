/*
  CONFIGURATION SUPABASE

  1. Crée un projet sur https://supabase.com
  2. Lance le fichier supabase-schema.sql dans le SQL Editor Supabase
  3. Copie ici :
     - Project URL
     - anon public key

  Important : la clé "anon public" peut être visible dans un site statique.
  Ne mets jamais la "service_role key" ici.
*/

window.OASIS_SUPABASE = {
  url: "https://zinchmgalrspkgtwjdjl.supabase.co",
  anonKey: "sb_publishable_AXxVVVPJ_IQ-KaX0eklo_w_Xps4Ez6o"
};

window.isOasisSupabaseConfigured = function isOasisSupabaseConfigured() {
  return Boolean(
    window.OASIS_SUPABASE &&
    window.OASIS_SUPABASE.url &&
    window.OASIS_SUPABASE.anonKey
  );
};
