# Roadmap (sugestões de evolução)

1. Implementar tabela de historização (audit log) para mudanças em `professional_plan`.
2. Adicionar view materializada para busca rápida de profissionais por plano/UF (refresh diário).
3. Implementar procedures para validação e normalização de `plan.metadata` ao ingestão.
4. Criar painel de métricas (PowerBI/Metabase) com KPIs: número de profissionais por operadora, cobertura por UF, aceites por mês.
5. Testes de carga: gerar 100k+ registros e validar índices/planos de particionamento por UF/ano.
6. Automatizar deploy de migrations com Flyway ou sqitch.
