-- Triggers: update updated_at automatically on update for key tables
create or replace function update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Attach triggers to tables commonly updated (idempotent)
do $$
begin
  if (select to_regclass('public.professional')) is not null then
    execute 'drop trigger if exists trg_update_professional on professional';
    execute 'create trigger trg_update_professional before update on professional for each row execute function update_updated_at_column()';
  end if;
  if (select to_regclass('public.operator')) is not null then
    execute 'drop trigger if exists trg_update_operator on operator';
    execute 'create trigger trg_update_operator before update on operator for each row execute function update_updated_at_column()';
  end if;
  if (select to_regclass('public.plan')) is not null then
    execute 'drop trigger if exists trg_update_plan on plan';
    execute 'create trigger trg_update_plan before update on plan for each row execute function update_updated_at_column()';
  end if;
  if (select to_regclass('public.professional_plan')) is not null then
    execute 'drop trigger if exists trg_update_professional_plan on professional_plan';
    execute 'create trigger trg_update_professional_plan before update on professional_plan for each row execute function update_updated_at_column()';
  end if;
  if (select to_regclass('public.professional_location')) is not null then
    execute 'drop trigger if exists trg_update_professional_location on professional_location';
    execute 'create trigger trg_update_professional_location before update on professional_location for each row execute function update_updated_at_column()';
  end if;
  if (select to_regclass('public.specialty')) is not null then
    execute 'drop trigger if exists trg_update_specialty on specialty';
    execute 'create trigger trg_update_specialty before update on specialty for each row execute function update_updated_at_column()';
  end if;
end$$;
