-- INSTALLATION SUPABASE POUR LE PHARE NUMERIQUE
--
-- A lancer dans Supabase > SQL Editor.
-- Ensuite, cree un utilisateur admin dans Authentication > Users.
-- Recommandation : desactive les inscriptions publiques dans Authentication > Providers > Email.

create extension if not exists pgcrypto;

create table if not exists public.app_settings (
  id text primary key default 'main',
  lighthouse_on boolean not null default true,
  updated_at timestamptz not null default now(),
  constraint app_settings_single_row check (id = 'main')
);

create table if not exists public.presence_days (
  date date primary key,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.visits (
  id uuid primary key default gen_random_uuid(),
  date date not null references public.presence_days(date) on delete cascade,
  name text not null,
  people_count integer not null check (people_count between 1 and 20),
  visit_type text not null,
  arrival_time time,
  message text,
  created_at timestamptz not null default now()
);

alter table public.visits
add column if not exists message text;

alter table public.visits
add column if not exists arrival_time time;

insert into public.app_settings (id, lighthouse_on)
values ('main', true)
on conflict (id) do nothing;

alter table public.app_settings enable row level security;
alter table public.presence_days enable row level security;
alter table public.visits enable row level security;

drop policy if exists "Public can read app settings" on public.app_settings;
create policy "Public can read app settings"
on public.app_settings for select
to anon, authenticated
using (true);

drop policy if exists "Admin can update app settings" on public.app_settings;
create policy "Admin can update app settings"
on public.app_settings for update
to authenticated
using (true)
with check (id = 'main');

drop policy if exists "Public can read presence days" on public.presence_days;
create policy "Public can read presence days"
on public.presence_days for select
to anon, authenticated
using (true);

drop policy if exists "Admin can manage presence days" on public.presence_days;
create policy "Admin can manage presence days"
on public.presence_days for all
to authenticated
using (true)
with check (true);

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

drop policy if exists "Admin can read visits" on public.visits;
create policy "Admin can read visits"
on public.visits for select
to authenticated
using (true);

drop policy if exists "Admin can delete visits" on public.visits;
create policy "Admin can delete visits"
on public.visits for delete
to authenticated
using (true);
