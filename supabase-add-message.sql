-- MIGRATION V2 : MESSAGE DES COPAINS
--
-- A lancer une seule fois dans Supabase > SQL Editor
-- si la base a deja ete creee avant l'ajout du champ message.

alter table public.visits
add column if not exists message text;
