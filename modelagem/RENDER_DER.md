# Exportando DER (Mermaid) para PNG/SVG

Você pode renderizar os arquivos `DER_*.md` usando o **Mermaid CLI**.

## Opção A — Docker
```bash
docker run --rm -v $PWD/modelagem:/data minlag/mermaid-cli mmdc   -i /data/DER_Proposta_A.md -o /data/DER_Proposta_A.png
docker run --rm -v $PWD/modelagem:/data minlag/mermaid-cli mmdc   -i /data/DER_Proposta_B.md -o /data/DER_Proposta_B.png
```

## Opção B — Node + npx
```bash
npm i -g @mermaid-js/mermaid-cli
mmdc -i modelagem/DER_Proposta_A.md -o modelagem/DER_Proposta_A.png
mmdc -i modelagem/DER_Proposta_B.md -o modelagem/DER_Proposta_B.png
```

> Dica: gere também em **SVG** trocando a extensão do arquivo de saída para `.svg`.
