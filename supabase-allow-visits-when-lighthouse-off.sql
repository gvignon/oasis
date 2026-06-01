-- MIGRATION V4 : AUTORISER LES MESSAGES SUR LES DATES VERTES
--
-- A lancer une seule fois dans Supabase > SQL Editor.
-- Les visiteurs peuvent prevenir de leur venue si la date est ouverte,
-- meme quand le bouton general indique "On est absents".

drop policy if exists "Public can create visits" on public.visits;

create policy "Public can create visits"
on public.visits for insert
to anon, authenticated
with check (
  exists (
    select 1
    from public.presence_days
    where presence_days.date = visits.date
  )
);
