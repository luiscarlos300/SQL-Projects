-- Qual cliente teve o maior saldo médio no mês 11? 

SELECT TOP 1
    c.NM_CLIENTE,
    AVG(CASE 
        WHEN t.CD_TRANSACAO IN (000, 110) THEN t.VR_TRANSACAO
        WHEN t.CD_TRANSACAO = 220 THEN -t.VR_TRANSACAO
    END) AS SALDO_MEDIO
FROM 
    TbTransacoes t
JOIN 
    TbCliente c ON t.CD_CLIENTE = c.CD_CLIENTE
WHERE 
    MONTH(t.DT_TRANSACAO) = 11
GROUP BY 
    c.NM_CLIENTE
ORDER BY 
    SALDO_MEDIO DESC;




--Qual é o saldo de cada cliente?

SELECT 
    c.NM_CLIENTE,
    SUM(CASE 
        WHEN t.CD_TRANSACAO IN (000, 110) THEN t.VR_TRANSACAO
        WHEN t.CD_TRANSACAO = 220 THEN -t.VR_TRANSACAO         
    END) AS SALDO
FROM 
    TbCliente c
LEFT JOIN 
    TbTransacoes t ON c.CD_CLIENTE = t.CD_CLIENTE
GROUP BY 
    c.CD_CLIENTE, c.NM_CLIENTE;


--Qual é o saldo médio de clientes que receberam CashBack?


SELECT 
    AVG(SALDO_TOTAL) AS SALDO_MEDIO
FROM (
    SELECT 
        c.CD_CLIENTE,
        SUM(CASE 
            WHEN t.CD_TRANSACAO IN (000, 110) THEN t.VR_TRANSACAO
            WHEN t.CD_TRANSACAO = 220 THEN -t.VR_TRANSACAO         
        END) AS SALDO_TOTAL
    FROM 
        TbCliente c
    LEFT JOIN 
        TbTransacoes t ON c.CD_CLIENTE = t.CD_CLIENTE
    GROUP BY 
        c.CD_CLIENTE
    HAVING 
        SUM(CASE WHEN t.CD_TRANSACAO = 000 THEN t.VR_TRANSACAO ELSE 0 END) > 0
) AS SALDO_CLIENTES;


--Qual o ticket médio das quatro últimas movimentações dos usuários?

WITH ULTIMAS_MOV AS (
    SELECT 
        CD_CLIENTE,
        VR_TRANSACAO,
        ROW_NUMBER() OVER (PARTITION BY CD_CLIENTE ORDER BY DT_TRANSACAO DESC) AS RN
    FROM 
        TbTransacoes
)

SELECT 
    AVG(VR_TRANSACAO) AS TICKET_MEDIO
FROM 
    ULTIMAS_MOV
WHERE 
    RN <= 4;


--Qual é a proporção entre Cash In/Out mensal?

SELECT 
    MONTH(DT_TRANSACAO) AS MES,
    SUM(CASE WHEN CD_TRANSACAO = 110 THEN VR_TRANSACAO ELSE 0 END) AS TOTAL_CASHIN,
    SUM(CASE WHEN CD_TRANSACAO = 220 THEN VR_TRANSACAO ELSE 0 END) AS TOTALCASHOUT,
    CASE 
        WHEN SUM(CASE WHEN CD_TRANSACAO = 220 THEN VR_TRANSACAO ELSE 0 END) = 0 THEN NULL
        ELSE SUM(CASE WHEN CD_TRANSACAO = 110 THEN VR_TRANSACAO ELSE 0 END) * 1.0 / 
             SUM(CASE WHEN CD_TRANSACAO = 220 THEN VR_TRANSACAO ELSE 0 END)
    END AS PROPORCAO_CASHINOUT
FROM 
    TbTransacoes
GROUP BY 
    MONTH(DT_TRANSACAO)
ORDER BY 
    MES;


--Qual a última transação de cada tipo para cada usuário?

WITH ULTIMAS_TRANSACOES AS (
    SELECT 
        NM_CLIENTE,
        CD_TRANSACAO,
        VR_TRANSACAO,
        DT_TRANSACAO,
        ROW_NUMBER() OVER (PARTITION BY NM_CLIENTE, CD_TRANSACAO ORDER BY DT_TRANSACAO DESC) AS RN
    FROM 
        TbTransacoes as t
	JOIN TbCliente as c
		ON t.CD_CLIENTE = c.CD_CLIENTE
);

SELECT 
    NM_CLIENTE,
    CD_TRANSACAO,
    VR_TRANSACAO,
    DT_TRANSACAO
FROM 
    ULTIMAS_TRANSACOES
WHERE 
    RN = 1;


--Qual a última transação de cada tipo para cada usuário por mês?

WITH ULTIMAS_TRANSACOAES_MES AS (
    SELECT 
        NM_CLIENTE,
        CD_TRANSACAO,
        VR_TRANSACAO,
        DT_TRANSACAO,
        MONTH(DT_TRANSACAO) AS Mes,
        ROW_NUMBER() OVER (PARTITION BY NM_CLIENTE, CD_TRANSACAO, MONTH(DT_TRANSACAO) ORDER BY DT_TRANSACAO DESC) AS RN
    FROM 
        TbTransacoes as t
	JOIN TbCliente as c
	ON t.CD_CLIENTE = c.CD_CLIENTE
)

SELECT 
    NM_CLIENTE,
    CD_TRANSACAO,
    VR_TRANSACAO,
    DT_TRANSACAO,
    Mes
FROM 
    ULTIMAS_TRANSACOAES_MES
WHERE 
    RN = 1;

--Qual quatidade de usuários que movimentaram a conta?

SELECT 
    COUNT(DISTINCT CD_CLIENTE) AS QTD_USUARIOS
FROM 
    TbTransacoes;


--Qual o balanço do final de 2021?


SELECT 
    SUM(CASE 
        WHEN CD_TRANSACAO IN (110, 000) THEN VR_TRANSACAO  
        WHEN CD_TRANSACAO = 220 THEN -VR_TRANSACAO         
        ELSE 0
    END) AS BANLANÇO_2021
FROM 
    TbTransacoes


--Quantos usuários que receberam CashBack continuaram interagindo com este banco?

WITH USUARIOS_CASHBACK AS (
    SELECT 
        CD_CLIENTE,
        MAX(DT_TRANSACAO) AS ULTIMA_TRANSACAO
    FROM 
        TbTransacoes
    WHERE 
        CD_TRANSACAO = 000
    GROUP BY 
        CD_CLIENTE
)

SELECT 
    COUNT(DISTINCT t.CD_CLIENTE) AS QTD_ATIVOS
FROM 
    TbTransacoes t
JOIN 
    USUARIOS_CASHBACK cb ON t.CD_CLIENTE = cb.CD_CLIENTE
WHERE 
    t.DT_TRANSACAO > cb.ULTIMA_TRANSACAO;


--Qual a primeira e a última movimentação dos usuários com saldo maior que R$100?


WITH SALDO_USUARIOS AS (
    SELECT 
        CD_CLIENTE,
        SUM(CASE 
            WHEN CD_TRANSACAO IN (110, 000) THEN VR_TRANSACAO 
            WHEN CD_TRANSACAO = 220 THEN -VR_TRANSACAO       
            ELSE 0
        END) AS SALDO_TOTAL
    FROM 
        TbTransacoes
    GROUP BY 
        CD_CLIENTE
    HAVING 
        SUM(CASE 
            WHEN CD_TRANSACAO IN (110, 000) THEN VR_TRANSACAO 
            WHEN CD_TRANSACAO = 220 THEN -VR_TRANSACAO 
            ELSE 0
        END) > 100
)


SELECT 
    c.NM_CLIENTE,
	t.CD_CLIENTE,
    MIN(t.DT_TRANSACAO) AS PRIMEIRA_MOV,
    MAX(t.DT_TRANSACAO) AS ULTIMA_MOV
FROM 
    TbTransacoes t
JOIN 
    SALDO_USUARIOS s ON t.CD_CLIENTE = s.CD_CLIENTE
JOIN TbCliente c ON s.CD_CLIENTE = c.CD_CLIENTE
GROUP BY 
    t.CD_CLIENTE, c.NM_CLIENTE;


--Qual o balanço das últimas quatro movimentações de cada usuário?

WITH ULTIMAS_MOV AS (
    SELECT 
        CD_CLIENTE,
        VR_TRANSACAO,
        CD_TRANSACAO,
        ROW_NUMBER() OVER (PARTITION BY CD_CLIENTE ORDER BY DT_TRANSACAO DESC) AS RN
    FROM 
        TbTransacoes
)

SELECT 
	NM_CLIENTE,
    u.CD_CLIENTE,
    SUM(CASE 
        WHEN CD_TRANSACAO IN (110, 000) THEN VR_TRANSACAO
        WHEN CD_TRANSACAO = 220 THEN -VR_TRANSACAO       
        ELSE 0
    END) AS BALANCO_ULTIMAS_MOV
FROM 
    ULTIMAS_MOV u
JOIN TbCliente c 
ON u.CD_CLIENTE = c.CD_CLIENTE
WHERE 
    RN <= 4
GROUP BY 
    u.CD_CLIENTE, c.NM_CLIENTE;


--Qual o ticket médio das últimas quatro movimentações de cada usuário?

WITH ULTIMAS_MOV AS (
    SELECT 
        NM_CLIENTE,
        VR_TRANSACAO,
        ROW_NUMBER() OVER (PARTITION BY NM_CLIENTE ORDER BY DT_TRANSACAO DESC) AS RN
    FROM 
        TbTransacoes t
	JOIN TbCliente c
		ON t.CD_CLIENTE = c.CD_CLIENTE
)

SELECT 
	NM_CLIENTE,
    AVG(VR_TRANSACAO) AS TICKET_MEDIO_ULT_MOV
FROM 
    ULTIMAS_MOV
WHERE 
    RN <= 4 
GROUP BY 
    NM_CLIENTE;