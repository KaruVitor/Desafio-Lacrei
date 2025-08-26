# Como Contribuir

Obrigado por se interessar em contribuir com esta modelagem! Algumas orientações rápidas:

1. Fork este repositório e crie uma branch nomeada `feature/<seu-nome>-<descrição>`.
2. Faça alterações nos arquivos em `/modelagem` e `/scripts` conforme necessário.
3. Atualize o `Dicionario_Proposta_*.csv` se adicionar ou alterar colunas.
4. Teste os scripts localmente (Postgres 15+) antes de abrir PR.
5. Inclua exemplos de uso e testes (SQL) para cobrir mudanças que afetem consultas ou índices.
6. Para mudanças de schema que alterem tipos/enums, adicione um script de migração em `scripts/migrations/`.

Ao abrir um PR, descreva a motivação técnica e o impacto esperado nas consultas/ETL/BI.
