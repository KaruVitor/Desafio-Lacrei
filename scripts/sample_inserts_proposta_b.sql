-- Sample Inserts Proposta B (operators, plans, attributes)
\i create_proposta_b.sql
\i indexes_b.sql

insert into operator (id, name, ans_code, aliases, active) values
  (uuid_generate_v4(), 'Operadora X', '2001', '["OpX"]'::jsonb, true),
  (uuid_generate_v4(), 'Operadora Y', '2002', '["OpY"]'::jsonb, true);

-- Insert plans with metadata
with ops as (select id,name from operator where name in ('Operadora X','Operadora Y'))
insert into plan (id, operator_id, product_code, product_name, coverage_level, active, metadata)
select uuid_generate_v4(), o.id, v.product_code, v.product_name, v.coverage_level, true, v.metadata::jsonb
from ops o
join (values
  ('Operadora X','X100','X Essencial','ambulatorial','{"telemedicina": true}'),
  ('Operadora Y','Y200','Y Plus','hospitalar','{"carencia":{"consulta":"30 dias"}}')
) as v(op_name, product_code, product_name, coverage_level, metadata) on o.name = v.op_name;
