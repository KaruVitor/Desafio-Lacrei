
create table if not exists plan_attribute (
  id uuid primary key default uuid_generate_v4(),
  plan_id uuid not null references plan(id),
  key text not null,
  value jsonb not null,
  searchable boolean not null default false,
  unique (plan_id, key)
);

create table if not exists specialty (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique
);

create table if not exists professional_specialty (
  id uuid primary key default uuid_generate_v4(),
  professional_id uuid not null references professional(id),
  specialty_id uuid not null references specialty(id),
  unique (professional_id, specialty_id)
);
