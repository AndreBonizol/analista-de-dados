  churn/README.md



# Análise de Churn: Retenção de Clientes em um App de Delivery

Projeto de análise de dados sobre o **churn** (cancelamento de clientes) em um aplicativo de delivery, com foco em identificar fatores que influenciam a saída de usuários e propor estratégias para aumentar a retenção.

---

## 🎯 Objetivo

Compreender as causas do churn e segmentar os clientes com maior risco de cancelamento, para orientar decisões estratégicas de retenção.

---

## 🔧 Ferramentas Utilizadas

- **SQL**: Extração e transformação dos dados diretamente do banco da empresa Preditiva
- **Excel**: Limpeza, cálculos e preparação dos dados
- **Power BI**: Visualização dos insights e criação do dashboard executivo
- **Medium**: Publicação do artigo completo com metodologia e recomendações

---

## 📁 Estrutura do Projeto

- `dados.xlsx`: Planilha com os dados brutos e cálculos realizados
- `dashboard.pbix`: Dashboard interativo no Power BI
- `sql_queries.sql`: Consultas SQL utilizadas para extrair e transformar os dados
- `artigo-medium.md`: Link para o post no Medium com análise completa

---

## 🔗 Links

- [Leia o artigo completo no Medium](https://medium.com/@andredepaulabonizol/an%C3%A1lise-de-churn-um-estudo-sobre-reten%C3%A7%C3%A3o-de-clientes-em-um-app-de-delivery-ee45dd0d64f9)

---

## 📊 Principais Insights

- **20% dos clientes deram churn** — 1 a cada 5 deixou o app.
- Clientes que consomem **apenas 1 categoria** têm **3,8x mais chance** de cancelar.
- Clientes com **idade ≥ 48 anos** têm **6,2x mais chances** de churn.
- Clientes de **Minas Gerais** têm **2x mais chance** de cancelar.
- Clientes **fora do programa de fidelidade** têm **27% de churn**, vs 14% dos participantes.
- **Pior perfil de risco**: Idade ≥ 48 anos + não participa do programa → **76% de churn**.

---

## 💡 Ações Recomendadas

- Cupons progressivos por categoria
- Tutoriais simples para usuários mais velhos
- Campanhas regionais para Minas Gerais
- Incentivos para adesão ao programa de fidelidade
- Campanhas de reengajamento segmentadas

---

## 📌 Como usar

1. Baixe a planilha `dados.xlsx` para analisar os cálculos.
2. Abra o `dashboard.pbix` no Power BI Desktop.
3. Leia o artigo no Medium para entender a metodologia completa.
4. Confira o arquivo `sql_queries.sql` para ver como foram extraídos os dados do banco.
