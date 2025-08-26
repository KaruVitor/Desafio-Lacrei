
-- Exemplos de consulta

-- 1) Profissionais que aceitam um plano específico (por código do produto)
select p.public_display_name, o.name as operator, pl.product_code, pl.product_name
from professional p
join professional_plan pp on pp.professional_id = p.id and pp.acceptance_status = 'accepted'
join plan pl on pl.id = pp.plan_id
join operator o on o.id = pl.operator_id
where pl.product_code = :product_code;

-- 2) Planos aceitos em uma UF
select distinct o.name as operator, pl.product_code, pl.product_name
from professional_plan pp
join plan pl on pl.id = pp.plan_id and pl.active
join operator o on o.id = pl.operator_id
join location l on l.id = coalesce(pp.location_id, l.id)
where pp.acceptance_status = 'accepted'
  and l.uf = :uf;

-- 3) Buscar por atributo JSONB (Proposta B) - planos com telemedicina = true
select pl.*
from plan pl
where pl.metadata ->> 'telemedicina' = 'true';

-- 4) GIN: buscar estrutura JSON específica
select pl.*
from plan pl
where pl.metadata @> jsonb_build_object('carencia', jsonb_build_object('consulta','30 dias'));
