-- Profissionais que aceitam um plano específico (por código do produto)
select p.public_display_name, o.name as operator, pl.product_code, pl.product_name
from professional p
join professional_plan pp on pp.professional_id = p.id and pp.acceptance_status = 'accepted'
join plan pl on pl.id = pp.plan_id
join operator o on o.id = pl.operator_id
where pl.product_code = :product_code;

-- Planos aceitos em uma UF específica (corrigido para evitar cross join e considerar localizações específicas ou gerais)
select distinct o.name as operator, pl.product_code, pl.product_name
from professional_plan pp
join plan pl on pl.id = pp.plan_id and pl.active
join operator o on o.id = pl.operator_id
left join location l on l.id = pp.location_id
where pp.acceptance_status = 'accepted'
  and (
    (l.uf = :uf)
    OR (pp.location_id IS NULL AND EXISTS (
         select 1
         from professional_location ploc
         join location l2 on l2.id = ploc.location_id
         where ploc.professional_id = pp.professional_id and l2.uf = :uf
    ))
  );

-- Buscar por atributo JSONB (Proposta B) - planos com telemedicina = true
select pl.*
from plan pl
where pl.metadata ->> 'telemedicina' = 'true';
