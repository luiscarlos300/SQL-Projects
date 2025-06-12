WITH conexoes AS (
    SELECT
        ac.id AS codigo_conexao,
        ac.contract_id AS codigo_contrato,
        ac.service_product_id,
        ac."user" as codigo,
        ac.state AS uf,
        ac.city AS cidade,
        ac.neighborhood as bairro,
        ac.street as rua,
        ac.complement as complemento,
        ac.address_complement as complementoll,
        ac.postal_code AS cep,
        ac.created AS data_ativacao, 
        ac.activation_date as data_ativacao_original,
        ac.erp_code,
        NULL AS data_cancelamento
    FROM
        authentication_contracts ac
    WHERE ac.active = true
    UNION
    SELECT 
        ((authentication_data::jsonb)->>'id')::BIGINT AS codigo_conexao,
        ((authentication_data::jsonb)->>'contract_id')::BIGINT AS codigo_contrato,
        ((authentication_data::jsonb)->>'service_product_id')::BIGINT AS service_product_id,
        (authentication_data::jsonb)->>'user' AS codigo,
        (authentication_data::jsonb)->>'state' AS uf,
        (authentication_data::jsonb)->>'city' AS cidade,
        (authentication_data::jsonb)->>'neighborhood' AS bairro,
        (authentication_data::jsonb)->>'street' AS rua,
        (authentication_data::jsonb)->>'complement' AS complemento,
        (authentication_data::jsonb)->>'address_complement' AS complementoll,
        (authentication_data::jsonb)->>'postal_code' AS cep,
        ((authentication_data::jsonb)->>'created')::TIMESTAMP AS data_ativacao,
        ((authentication_data::jsonb)->>'activation_date')::TIMESTAMP AS data_ativacao_original,
        (authentication_data::jsonb)->>'erp_code' AS erp_code,
        acco.created AS data_cancelamento
    FROM 
        authentication_contract_connection_occurrences acco
    WHERE 
        acco.authentication_data IS NOT NULL
), 
produtos_novos AS (
	SELECT DISTINCT
        cx.codigo_contrato AS codigo_contrato,
        CASE
            WHEN sp.title ILIKE '%banda%' THEN 'Banda Larga'
            WHEN sp.title ILIKE '%dedicado%' THEN 'Dedicado'
            WHEN sp.title ILIKE '%ponto%' THEN 'Ponto a Ponto'
            WHEN sp.title ILIKE '%telefone%' THEN 'STFC'
            WHEN sp.title ILIKE '%sva%' THEN 'SVA'
            ELSE 'Outro'
        END AS categoria
    FROM conexoes cx
    LEFT JOIN erp.service_products sp ON cx.service_product_id = sp.id
),
categorias_contratadas AS (
SELECT
    codigo_contrato,
    STRING_AGG(categoria, ', ' ORDER BY categoria) AS categorias_contratadas
FROM produtos_novos
GROUP BY codigo_contrato
)
SELECT
    cx.codigo_conexao,
    cx.codigo_contrato,
    cx.codigo AS "conta",
    sp.title AS produto,
    CASE 
        WHEN sp.title ILIKE '%RN%' THEN 'Rede Neutra'
        ELSE 'Rede Própria'
    END AS tipo_rede,
    CASE
        WHEN sp.title ILIKE '%banda%' THEN 'Banda Larga'
        WHEN sp.title ILIKE '%dedicado%' THEN 'Dedicado'
        WHEN sp.title ILIKE '%ponto%' THEN 'Ponto a Ponto'
        WHEN sp.title ILIKE '%telefone%' THEN 'STFC'
        WHEN sp.title ILIKE '%sva%' THEN 'SVA'
        ELSE 'Outro'
    END AS categoria_servico,
    con.categorias_contratadas,
    cx.data_ativacao, 
    cx.data_ativacao_original,
    cx.data_cancelamento,
    c.client_id AS id_cliente,
    c.contract_number AS numero_contrato,
    c.description AS descricao,
    c.date AS data_cadastro_contrato,
    c.months_duration AS duracao_contrato,
    c.final_date AS data_final_contrato,
    c.billing_beginning_date AS faturar_de_contrato,
    c.billing_final_date AS faturar_ate_contrato,
    c.billing_day AS data_cobranca_contrato,
    c.cancellation_date AS data_cancelamento_contrato,
    c.v_status AS status_contrato,
    c.status_date,
    c.amount AS valor_contrato,
    p.id AS id_cliente,
    p.tx_id AS documento,
    p.name AS nome_razao_social,
    p.email,
    p."email_NFE" AS email2,
    p.neighborhood as bairro_cliente,
    p.city as cidade_cliente,
    p.state as estado_cliente,
    p.postal_code AS cep_cliente,
    p.cell_phone_1 AS celular,
    cx.uf,
    cx.cidade,
   	cx.cep,
    cx.bairro,
    cx.rua
FROM 
    conexoes cx
LEFT JOIN contracts c ON
    cx.codigo_contrato = c.id
LEFT JOIN people p ON
    c.client_id = p.id
LEFT JOIN erp.service_products sp ON 
    cx.service_product_id = sp.id
LEFT JOIN categorias_contratadas con ON
	cx.codigo_contrato = con.codigo_contrato
ORDER BY cx.codigo_conexao ASC;