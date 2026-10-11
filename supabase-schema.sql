-- Alaa Deals — جداول قاعدة البيانات
-- شغّل الملف ده مرة واحدة من Supabase → SQL Editor → New query → Run

create table if not exists public.clients (
  id          text primary key,
  name        text not null,
  phone       text,
  type        text default 'مشتري',
  status      text default 'جديد',
  source      text,
  budget      numeric,
  want        text,
  notes       text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create table if not exists public.units (
  id          text primary key,
  title       text not null,
  type        text default 'شقة',
  area        text,
  size        numeric,
  floor       text,
  price       numeric,
  status      text default 'متاحة',
  owner_id    text references public.clients(id) on delete set null,
  notes       text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create table if not exists public.deals (
  id          text primary key,
  client_id   text references public.clients(id) on delete set null,
  unit_id     text references public.units(id) on delete set null,
  stage       text default 'تواصل أول',
  date        date,
  value       numeric,
  commission  numeric,
  closed_at   date,
  notes       text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists deals_client_idx on public.deals(client_id);
create index if not exists deals_unit_idx   on public.deals(unit_id);
create unique index if not exists clients_phone_uniq on public.clients(phone) where phone is not null and phone <> '';

-- الحماية: محدش يقرا أو يكتب إلا لو مسجّل دخول
alter table public.clients enable row level security;
alter table public.units   enable row level security;
alter table public.deals   enable row level security;

drop policy if exists "signed-in full access" on public.clients;
drop policy if exists "signed-in full access" on public.units;
drop policy if exists "signed-in full access" on public.deals;
create policy "signed-in full access" on public.clients for all to authenticated using (true) with check (true);
create policy "signed-in full access" on public.units   for all to authenticated using (true) with check (true);
create policy "signed-in full access" on public.deals   for all to authenticated using (true) with check (true);

-- التحديث اللحظي بين الأجهزة
alter publication supabase_realtime add table public.clients, public.units, public.deals;
