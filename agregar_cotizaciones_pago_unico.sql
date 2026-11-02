-- Servicios de pago único en las cotizaciones (ej: creación de empresa, inicio de actividades).
-- Correr una vez en Supabase → SQL Editor del proyecto de Cobranza.
alter table public.cotizaciones add column if not exists cobros_unicos jsonb not null default '[]'::jsonb;

-- que la app vea la columna nueva de inmediato
notify pgrst, 'reload schema';
