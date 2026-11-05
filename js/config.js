// Add your Supabase project URL and anon/public key below.
// Never put your service_role key in browser code.
window.LAGOSLIFE_CONFIG = {
  SUPABASE_URL: "https://jwoeynfyjuxpmichjbif.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_c7KAsgmyDAt56GIeWWjnyA_iWSBSE4j"
};
window.supabaseClient = null;
if (window.supabase && !window.LAGOSLIFE_CONFIG.SUPABASE_URL.includes("YOUR-PROJECT")) {
  window.supabaseClient = window.supabase.createClient(
    window.LAGOSLIFE_CONFIG.SUPABASE_URL,
    window.LAGOSLIFE_CONFIG.SUPABASE_ANON_KEY
  );
}