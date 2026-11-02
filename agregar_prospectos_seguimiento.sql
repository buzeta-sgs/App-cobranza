-- Seguimiento de prospectos (pestaña "Prospectar"): cargo, teléfono y contactos.
-- Correr una vez en Supabase → SQL Editor (después de agregar_prospectos.sql).
alter table public.prospectos add column if not exists cargo text;
alter table public.prospectos add column if not exists telefono text;
-- fecha del primer correo enviado (envios / ultimo_envio ya existían)
alter table public.prospectos add column if not exists primer_envio timestamptz;
-- n.º de contactos (0 = sin contactar), fecha del último y la lista de todas las fechas
alter table public.prospectos add column if not exists contactos integer not null default 0;
alter table public.prospectos add column if not exists ultimo_contacto timestamptz;
alter table public.prospectos add column if not exists contactos_fechas jsonb not null default '[]'::jsonb;

-- los que ya tenían correos enviados: el primer envío conocido es el último registrado
update public.prospectos set primer_envio = ultimo_envio
  where primer_envio is null and ultimo_envio is not null and envios = 1;

-- que la app vea las columnas nuevas de inmediato
notify pgrst, 'reload schema';
