# Explicação Comparativa — Propostas A e B

## Resumo rápido
- **Proposta A (Relacional 3FN)**: Tabelas normalizadas, domínios para catálogos (ex.: plan_network_type). Ideal para governança, BI e consultas com joins previsíveis.
- **Proposta B (Híbrida com JSONB)**: Núcleo relacional com colunas `jsonb` para atributos voláteis. Ideal para ingestão rápida e esquemas heterogêneos.

## Justificativa sobre `specialty`
- Na **Proposta A** incluímos a tabela `specialty` (e a junction `professional_specialty`) porque espera-se que a plataforma mantenha um catálogo relativamente estável de especialidades médicas, necessário para filtros e para corresponder pacientes a profissionais.
- Inicialmente a **Proposta B** priorizava flexibilidade e, por isso, não listava `specialty`. Para **consistência e comparabilidade**, incluímos a tabela `specialty` também na Proposta B neste repositório. Em cenários onde especialidades são altamente variáveis por profissional e não são usadas para filtros analíticos, poder-se-ia optar por modelar especialidades dentro de `jsonb` (trade-off: perda de integridade e performance em filtros).

## Enum vs Tabela de domínio
- **Enum (Postgres)**: Use para valores fechados e raramente alterados (ex.: `acceptance_status`). Ótimo para performance e validação a nível de tipo. Alterações exigem DDL/migração.
- **Tabela de domínio**: Use para catálogos mutáveis (ex.: tipos de rede, categorias de cobertura) — permite CRUD sem DDL, internacionalização e soft-delete.

## Unicidade em `plan_attribute`
- Foi adicionada a constraint `UNIQUE (plan_id, key)` para evitar atributos duplicados por plano. Isso garante que cada chave seja única dentro do escopo do plano.

## `professional_plan` e NULL handling
- Para evitar duplicidade indevida (mesmo plano atribuído duas vezes com `location_id = NULL` vs `location_id = NULL`), migramos a constraint única original para usar **`NULLS NOT DISTINCT`** (Postgres 15+), garantindo unicidade mesmo quando `location_id` é NULL.

## Triggers `updated_at`
- Incluímos uma função trigger `update_updated_at_column()` e aplicamos triggers `BEFORE UPDATE` nas tabelas mutáveis (professional, operator, plan, professional_plan, professional_location, specialty). Isso garante atualização automática de `updated_at` sem depender da aplicação.

## Observações finais
- A Proposta A prioriza integridade e previsibilidade; a Proposta B prioriza flexibilidade e velocidade de evolução. Ambos os modelos co-existem neste repositório com scripts e índices apropriados.
