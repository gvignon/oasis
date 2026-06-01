-- MIGRATION V3 : HEURE APPROXIMATIVE DE PASSAGE
--
-- A lancer une seule fois dans Supabase > SQL Editor
-- si la base existe deja.

alter table public.visits
add column if not exists arrival_time time;
