-- Alaa Deals — تحديث: خانة المكاتب والسماسرة
-- لو كنت شغّلت supabase-schema.sql قبل كده، شغّل الملف ده مرة واحدة بس
-- من Supabase → SQL Editor → New query → Run

create table if not exists public.brokers (
  id          text primary key,
  name        text not null,
  kind        text default 'مكتب عقاري',
  contact     text,
  phone       text,
  area        text,
  rating      numeric,
  split       numeric,
  notes       text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

alter table public.clients add column if not exists broker_id    text references public.brokers(id) on delete set null;
alter table public.units   add column if not exists broker_id    text references public.brokers(id) on delete set null;
alter table public.deals   add column if not exists broker_id    text references public.brokers(id) on delete set null;
alter table public.deals   add column if not exists broker_share numeric;

create index if not exists deals_broker_idx on public.deals(broker_id);

alter table public.brokers enable row level security;
drop policy if exists "signed-in full access" on public.brokers;
create policy "signed-in full access" on public.brokers for all to authenticated using (true) with check (true);

do $$ begin
  alter publication supabase_realtime add table public.brokers;
exception when duplicate_object then null; end $$;
