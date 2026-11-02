-- Tabla de prospectos (pestaña "Prospectar" del panel Cotizaciones).
-- Correr una vez en Supabase → SQL Editor.
create table if not exists public.prospectos (
  id uuid primary key default gen_random_uuid(),
  email text not null,
  nombre text,
  empresa text,
  envios integer not null default 0,
  ultimo_envio timestamptz,
  ultimo_envio_por text,
  created_by text,
  created_at timestamptz not null default now()
);

-- un mismo correo no se guarda dos veces (sin importar mayúsculas)
create unique index if not exists prospectos_email_unico on public.prospectos (lower(email));

alter table public.prospectos enable row level security;

drop policy if exists "prospectos_todo" on public.prospectos;
create policy "prospectos_todo" on public.prospectos
  for all to anon, authenticated using (true) with check (true);
