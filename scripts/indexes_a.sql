
-- Índices Proposta A
create index if not exists idx_prof_loc_prof on professional_location(professional_id);
create index if not exists idx_prof_loc_loc on professional_location(location_id);

create index if not exists idx_plan_operator on plan(operator_id);
create index if not exists idx_plan_product_code on plan(product_code);
create index if not exists idx_plan_active on plan(active);

create index if not exists idx_prof_plan_prof on professional_plan(professional_id);
create index if not exists idx_prof_plan_plan on professional_plan(plan_id);
create index if not exists idx_prof_plan_status on professional_plan(acceptance_status);
create index if not exists idx_prof_plan_location on professional_plan(location_id);

create index if not exists idx_operator_aliases_gin on operator using gin (aliases);
create index if not exists idx_plan_metadata_gin on plan using gin (metadata);
create index if not exists idx_prof_plan_req_gin on professional_plan using gin (requirements);
