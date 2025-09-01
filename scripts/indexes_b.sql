
create index if not exists idx_plan_attr_key on plan_attribute(key) where searchable;
create index if not exists idx_plan_attr_value_gin on plan_attribute using gin (value);
create unique index if not exists uq_plan_attribute_plan_key on plan_attribute(plan_id, key);
