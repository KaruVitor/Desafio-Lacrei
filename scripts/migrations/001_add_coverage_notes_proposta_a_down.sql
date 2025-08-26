-- Migration DOWN: Remove column 'coverage_notes' from plan (Proposta A)
alter table plan drop column if exists coverage_notes;
