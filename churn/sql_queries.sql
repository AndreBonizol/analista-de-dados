/*
Projeto: Análise de Churn - App de Delivery
Autor: Andre Bonizol
Data: Abril 2025
Descrição: Consultas SQL para verificação da estrutura das tabelas, extração, transformação e limpeza dos dados de churn.
Fonte: Banco de dados da Preditiva Analytics
*/

-- ============ VERIFICAÇÃO DA ESTRUTURA DAS TABELAS ============

-- Verifica colunas e tipos da tabela fato_churn
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_schema = 'db_churn' 
  AND table_name = 'fato_churn';

-- Verifica colunas e tipos da tabela dim_clientes
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_schema = 'db_churn' 
  AND table_name = 'dim_clientes';



-- ============ TRANSFORMAÇÃO E LIMPEZA DOS DADOS ============

WITH dados_limpos AS (
    SELECT 
        f."ClientId",
        f."DataUltimaTransacao",
        c."DataExtracao",
        c."Score_Credito",
        -- Ajuste de formatação para evitar problemas com acentos
        REPLACE(c."Estado", 'São Paulo', 'Sao Paulo') AS "Estado_",
        REPLACE(c."Gênero", 'Gênero', 'Genero') AS "Genero_",
        c."Idade",
        c."Tempo_Cliente",
        -- Ajuste da formatação de valores numéricos para compatibilidade com o Excel
        REPLACE(TO_CHAR(ROUND(c."Limite_Credito_Mercado"::NUMERIC, 2), 'FM999999990.00'), '.', ',') AS "Limite_Credito_Mercado_",
        REPLACE(TO_CHAR(ROUND(c."Sum_Pedidos_Acumulados"::NUMERIC, 2), 'FM999999990.00'), '.', ',') AS "Sum_Pedidos_Acumulados_",
        c."Qte_Categorias",
        c."Usa_Cartao_Credito",
        c."Programa_Fidelidade",
        -- Criação da flag de churn: 1 se última transação foi há mais de 30 dias
        CASE 
            WHEN ('2019-10-30' - f."DataUltimaTransacao") > 30 THEN 1 
            ELSE 0 
        END AS "Churn_Flag"
    FROM 
        db_churn.fato_churn AS f
    INNER JOIN 
        db_churn.dim_clientes AS c
    ON 
        f."ClientId" = c."ClientId"
)

-- ============ FILTRAGEM FINAL E REMOÇÃO DE DUPLICATAS ============

SELECT *
FROM dados_limpos
WHERE 
    "ClientId" IS NOT NULL                 -- Garante que o ID do cliente não seja nulo
    AND "DataUltimaTransacao" IS NOT NULL  -- Verifica se há datas faltando
    AND "Estado_" <> ''                    -- Evita valores vazios na coluna Estado
    AND "Genero_" <> ''                    -- Evita valores vazios na coluna Gênero
    AND "Limite_Credito_Mercado_" ~ '^[0-9]+,[0-9]{2}$'  -- Valida formato dos valores monetários
    AND "Sum_Pedidos_Acumulados_" ~ '^[0-9]+,[0-9]{2}$'
-- Agrupa para remover duplicatas
GROUP BY 
    "ClientId", "DataUltimaTransacao", "DataExtracao", "Score_Credito", 
    "Estado_", "Genero_", "Idade", "Tempo_Cliente", 
    "Limite_Credito_Mercado_", "Sum_Pedidos_Acumulados_", "Qte_Categorias", 
    "Usa_Cartao_Credito", "Programa_Fidelidade", "Churn_Flag"
HAVING COUNT(*) = 1;  -- Mantém apenas registros únicos
