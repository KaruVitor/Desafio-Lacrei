-- Migration UP: Add column 'coverage_notes' to plan (Proposta A)
alter table plan add column if not exists coverage_notes text;
