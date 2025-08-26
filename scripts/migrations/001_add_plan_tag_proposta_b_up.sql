-- Migration UP: Add plan_tag table and index (Proposta B)
create table if not exists plan_tag (
  id uuid primary key default uuid_generate_v4(),
  plan_id uuid not null references plan(id) on delete cascade,
  tag text not null
);
create index if not exists idx_plan_tag_tag on plan_tag(tag);
