# Desafio Técnico – Modelagem de Dados (Lacrei Saúde)

Entrega por: **Vitor Cantanhede Cristino**  
Data: **2025-08-25**

## Visão Geral
Este repositório traz **duas propostas de modelagem** para organizar os **planos de saúde aceitos por profissionais** cadastrados na Lacrei Saúde, considerando:
- **Integridade dos dados**
- **Eficiência em consultas**
- **Flexibilidade para expansão**
- **Conformidade com LGPD**
- **Boas práticas de normalização (até 3FN)**

### Propostas
- **Proposta A – Modelo Relacional Normalizado com Domínios**  
  Abordagem clássica 3FN, com tabelas de referência para operadoras e produtos, relacionamento N:N entre profissionais e planos e **tabelas de domínio** (ex.: `plan_network_type`) para maior governança dos dados. Usa **enums** apenas para estados claramente estáveis (ex.: status de aceite).  
- **Proposta B – Modelo Híbrido com JSONB e Enums**  
  Mantém o núcleo relacional (profissionais, operadoras, planos), mas permite **atributos variáveis por plano** (ex.: regras específicas de coparticipação, observações regionais) em colunas **`jsonb`**, e utiliza **enums** para tipificações de baixa cardinalidade estáveis. Mais flexível para ingestão de dados heterogêneos de operadoras.

Cada proposta inclui: **DER (Mermaid)**, **dicionário de dados** e **scripts SQL**.

---

## LGPD e Segurança
- **Minimização de dados**: no escopo deste desafio, evitamos dados pessoais sensíveis; quando necessário, usar **pseudonimização** (ex.: IDs) e restringir acesso a dados PII em outras áreas do schema.
- **Auditoria**: tabelas trazem `created_at`, `updated_at` e `updated_by` (para trilhas de auditoria).
- **Retenção**: aceitar planos é um dado transacional; previsões de expurgo podem ser aplicadas conforme política interna.
- **Criptografia**: recomenda-se **TDE**/criptografia em repouso a nível de infraestrutura e, se necessário, criptografia a nível de coluna para PII.

---

## `jsonb`: quando usar?
**Vantagens**
- Flexibilidade para **atributos semi-estruturados** que mudam por operadora/região (ex.: requisitos específicos, URLs de manuais, notas).
- Melhor **time-to-market** para ingestão de dados heterogêneos, com indexação parcial via **GIN** quando necessário.

**Cautelas**
- **Integridade referencial** limitada; chaves e constraints não se aplicam dentro do JSONB.
- **Consultas** podem ficar mais custosas/complexas; requer índices GIN/expressões.
- **Migrações** podem exigir scripts de backfill/validação.
  
**Guideline prática**
- Use **colunas relacionais** para atributos **de alta seleção/filtragem** e **estáveis** (ex.: `operator_id`, `product_code`, `uf`, `active`).
- Use **`jsonb`** para atributos **voláteis** ou **pouco consultados** (ex.: políticas detalhadas, notas, alias legado).

---

## Pastas
- `/modelagem`
  - `DER_Proposta_A.md` • `DER_Proposta_B.md`
  - `Dicionario_Proposta_A.csv` • `Dicionario_Proposta_B.csv`
  - `Explicacao_Comparativa.md`
- `/scripts`
  - `create_proposta_a.sql` • `create_proposta_b.sql`
  - `indexes_a.sql` • `indexes_b.sql`
  - `sample_queries.sql`

---

## Como usar
1. Importe os scripts de **criação** (A ou B) no PostgreSQL 15+.
2. Em seguida, rode os scripts de **índices** (A ou B).
3. Consulte os exemplos em `sample_queries.sql`.

---

## Por que quero contribuir com a missão da Lacrei?
Acredito que **dados e tecnologia** são ferramentas para **inclusão e acesso ao cuidado**. Quero aplicar meu conhecimento em **Dados e boas práticas** para construir soluções escaláveis que **respeitem a diversidade** e promovam **segurança e acolhimento**.
