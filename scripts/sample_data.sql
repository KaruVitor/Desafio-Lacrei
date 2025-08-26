
-- Dados fictícios para testes (PostgreSQL)
insert into operator (id, name, ans_code, aliases, active)
values
  (uuid_generate_v4(), 'SaudeViva', '00123', '["Saúde Viva","SV Saúde"]'::jsonb, true),
  (uuid_generate_v4(), 'BemMais', '00456', '["Bem+","Bem Mais Saúde"]'::jsonb, true);

insert into plan_network_type (name, description)
values
  ('AMBULATORIAL','Cobertura ambulatorial'),
  ('HOSPITALAR','Cobertura hospitalar'),
  ('ODONTO','Cobertura odontológica')
on conflict do nothing;

with ops as (
  select id, name from operator where name in ('SaudeViva','BemMais')
)
insert into plan (id, operator_id, product_code, product_name, network_type, coverage_level, active, metadata)
select uuid_generate_v4(), o.id,
       p.product_code, p.product_name,
       p.network_type, p.coverage_level, true,
       p.metadata::jsonb
from ops o
join (
  values
   ('SaudeViva','SV100','Viva Essencial','AMBULATORIAL', 'ambulatorial','{"telemedicina": true, "carencia": {"consulta": "30 dias"}}'),
   ('SaudeViva','SV200','Viva Total','HOSPITALAR', 'hospitalar','{"telemedicina": true, "quarto": "individual"}'),
   ('BemMais','BM500','Bem Ouro','AMBULATORIAL', 'ambulatorial','{"telemedicina": false}'),
   ('BemMais','BM900','Bem Diamante','MISTO', 'misto','{"carencia": {"exame": "45 dias"}}')
) as p(op_name, product_code, product_name, network_type, coverage_level, metadata)
  on o.name = p.op_name;

insert into location (id, city, uf, region) values
  (uuid_generate_v4(), 'São Paulo', 'SP', 'Sudeste'),
  (uuid_generate_v4(), 'Rio de Janeiro', 'RJ', 'Sudeste'),
  (uuid_generate_v4(), 'Belo Horizonte', 'MG', 'Sudeste')
on conflict do nothing;

insert into professional (id, full_name, public_display_name, external_ids)
values
  (uuid_generate_v4(), 'Carla Souza', 'Dra. Carla Souza', '{"crm":"12345-SP"}'::jsonb),
  (uuid_generate_v4(), 'Marcos Lima', 'Dr. Marcos Lima', '{"crm":"67890-RJ"}'::jsonb),
  (uuid_generate_v4(), 'Alex Ribeiro', 'Alex Ribeiro', '{"crp":"445566-MG"}'::jsonb);

insert into professional_location (id, professional_id, location_id, active)
select uuid_generate_v4(), p.id, l.id, true
from professional p
cross join lateral (select id from location limit 1) l
on conflict do nothing;

with pls as (select id from plan order by created_at limit 2),
     pros as (select id from professional)
insert into professional_plan (id, professional_id, plan_id, acceptance_status, updated_by, created_at, updated_at)
select uuid_generate_v4(), pros.id, pls.id, 'accepted', 'seed', now(), now()
from pros, pls;
