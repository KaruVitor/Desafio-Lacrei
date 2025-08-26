
-- Índices Proposta B
create index if not exists idx_plan_operator on plan(operator_id);
create index if not exists idx_plan_active on plan(active);
create index if not exists idx_plan_attr_key on plan_attribute(key) where searchable;
create index if not exists idx_plan_attr_value_gin on plan_attribute using gin (value);

create index if not exists idx_prof_plan_prof on professional_plan(professional_id);
create index if not exists idx_prof_plan_plan on professional_plan(plan_id);
create index if not exists idx_prof_plan_status on professional_plan(acceptance_status);
create index if not exists idx_prof_plan_loc on professional_plan(location_id);

create index if not exists idx_operator_aliases_gin on operator using gin (aliases);
create index if not exists idx_plan_metadata_gin on plan using gin (metadata);
create index if not exists idx_prof_plan_details_gin on professional_plan using gin (acceptance_details);
