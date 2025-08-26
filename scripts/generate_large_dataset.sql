-- Gerador de dados em massa (aproximado). Ajuste conforme necessidade.
-- Esse script gera 500 profissionais, 50 locations e vincula aleatoriamente a planos existentes.
-- Use com cuidado em ambiente de testes.

-- Gera locations
do $$
declare i int;
begin
  for i in 1..50 loop
    insert into location (id, city, uf, region)
    values (uuid_generate_v4(), 'City_'||i, (array['SP','RJ','MG','BA','PE'])[1 + (i % 5)], 'Region_'||(1 + (i % 5)))
    on conflict do nothing;
  end loop;
end$$;

-- Gera profissionais
do $$
declare i int;
begin
  for i in 1..500 loop
    insert into professional (id, full_name, public_display_name, external_ids)
    values (uuid_generate_v4(), 'Profissional '||i, 'Prof '||i, jsonb_build_object('crm', 'CRM'||i))
    on conflict do nothing;
  end loop;
end$$;

-- Vincula profissionais a locais e a alguns planos
do $$
declare p_id uuid;
begin
  for p_id in (select id from professional) loop
    insert into professional_location (id, professional_id, location_id, active)
    values (uuid_generate_v4(), p_id, (select id from location order by random() limit 1), true)
    on conflict do nothing;

    -- link to random plans (0..3)
    for i in 1..(floor(random()*4)) loop
      insert into professional_plan (id, professional_id, plan_id, acceptance_status, updated_by, created_at, updated_at)
      values (uuid_generate_v4(), p_id, (select id from plan order by random() limit 1), 'accepted', 'seed_bulk', now(), now())
      on conflict do nothing;
    end loop;
  end loop;
end$$;
