# Desafio Técnico – Modelagem de Dados · Lacrei Saúde

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue)
![LGPD](https://img.shields.io/badge/LGPD-ready-success)
![Mermaid](https://img.shields.io/badge/Diagrama-Mermaid-informational)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

**Autor:** Vitor Cantanhede Cristino · **Data:** 2025-08-26

Este repo contém **duas propostas de modelagem** para organizar **planos de saúde aceitos por profissionais** na plataforma, com foco em **integridade**, **eficiência**, **flexibilidade** e **LGPD**.

## 📂 Estrutura
- `modelagem/`
  - `DER_Proposta_A.md` · `DER_Proposta_B.md`
  - `Dicionario_Proposta_A.csv` · `Dicionario_Proposta_B.csv`
  - `Explicacao_Comparativa.md`
  - `RENDER_DER.md` (como exportar as imagens)
- `scripts/`
  - `create_proposta_a.sql` · `create_proposta_b.sql`
  - `indexes_a.sql` · `indexes_b.sql`
  - `sample_data.sql` (dados fictícios)
  - `sample_queries.sql`

## 🚀 Como rodar
1. Crie o schema com **uma** das propostas:
   ```sql
   \i scripts/create_proposta_a.sql
   \i scripts/indexes_a.sql
   -- opcional
   \i scripts/sample_data.sql
   -- consultas exemplo
   \i scripts/sample_queries.sql
   ```
2. Para a **Proposta B**, troque para `create_proposta_b.sql` e `indexes_b.sql`.

## 🧠 Decisões-chave
- **Proposta A**: 3FN + tabelas de domínio → governança forte, consultas previsíveis.
- **Proposta B**: núcleo relacional + **jsonb** para atributos mutáveis → flexível e rápido para evoluir.
- **Enum vs Domínio**: enums para estados **estáveis**; domínios para catálogos **mutáveis** gerenciados via CRUD.
- **LGPD**: minimização, auditoria (`created_at`, `updated_at`, `updated_by`), e criptografia em repouso.

## 📸 DER como imagem
Veja `modelagem/RENDER_DER.md` para comandos de exportação (Docker ou Node).

---

💙 **Motivação**  
Quero contribuir com a missão da Lacrei utilizando dados e tecnologia para **acesso ao cuidado com inclusão e segurança**.
