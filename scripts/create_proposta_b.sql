
-- Proposta B: Núcleo relacional + JSONB + Enums
create extension if not exists "uuid-ossp";

do $$ begin
  if not exists (select 1 from pg_type where typname = 'acceptance_status') then
    create type acceptance_status as enum ('accepted','not_accepted','restricted','unknown');
  end if;
  if not exists (select 1 from pg_type where typname = 'coverage_level') then
    create type coverage_level as enum ('ambulatorial','hospitalar','odontologico','misto');
  end if;
end $$;

create table if not exists professional (
  id uuid primary key default uuid_generate_v4(),
  full_name text not null,
  public_display_name text not null,
  external_ids jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists location (
  id uuid primary key default uuid_generate_v4(),
  city text not null,
  uf char(2) not null,
  region text,
  unique (city, uf)
);

create table if not exists professional_location (
  id uuid primary key default uuid_generate_v4(),
  professional_id uuid not null references professional(id),
  location_id uuid not null references location(id),
  active boolean not null default true,
  unique (professional_id, location_id)
);

create table if not exists operator (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,
  ans_code text,
  aliases jsonb,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists plan (
  id uuid primary key default uuid_generate_v4(),
  operator_id uuid not null references operator(id),
  product_code text not null,
  product_name text not null,
  coverage_level coverage_level not null,
  active boolean not null default true,
  metadata jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (operator_id, product_code)
);

create table if not exists plan_attribute (
  id uuid primary key default uuid_generate_v4(),
  plan_id uuid not null references plan(id),
  key text not null,
  value jsonb not null,
  searchable boolean not null default false
);

create table if not exists professional_plan (
  id uuid primary key default uuid_generate_v4(),
  professional_id uuid not null references professional(id),
  plan_id uuid not null references plan(id),
  acceptance_status acceptance_status not null default 'unknown',
  location_id uuid references location(id),
  acceptance_details jsonb,
  updated_by text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (professional_id, plan_id, coalesce(location_id, '00000000-0000-0000-0000-000000000000'::uuid))
);
