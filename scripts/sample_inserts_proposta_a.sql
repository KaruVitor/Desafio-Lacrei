-- Sample Inserts Proposta A (operators, plans, locations, professionals)
\i create_proposta_a.sql
\i indexes_a.sql

-- Insert operators
insert into operator (id, name, ans_code, aliases, active) values
  (uuid_generate_v4(), 'Operadora A', '1001', '["OpA","OperA"]'::jsonb, true),
  (uuid_generate_v4(), 'Operadora B', '1002', '["OpB"]'::jsonb, true);

-- network types
insert into plan_network_type (name, description) values ('AMBULATORIAL',''), ('HOSPITALAR','') on conflict do nothing;
