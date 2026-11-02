-- Historial de correos enviados a cada prospecto (Prospecto, Seguimiento 1, 2...) con el link al PDF de lo enviado.
-- Correr una vez en Supabase → SQL Editor del proyecto de Cobranza.
alter table public.prospectos add column if not exists envios_detalle jsonb not null default '[]'::jsonb;

-- que la app vea la columna nueva de inmediato
notify pgrst, 'reload schema';
