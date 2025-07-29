/* Query Service_Orders - A tabela com as OS e status de cada uma. */
SELECT 
	id,
    customer_id,
    type,
    external_id,
    associated_document AS 'os',
    created_at,
    closed_at
FROM service_orders
WHERE type NOT IN('Instalacao', 'Retirada')
LIMIT 10;

SELECT * FROM service_orders 
ORDER BY created_at DESC
LIMIT 10;

SELECT
	COUNT(*) as qtd_os,
	type
FROM
	service_orders
GROUP BY
	type;

/* Query Customers - EQ está nessa tabela cada EQ está vinculada a um cliente. 
Consigo jogar essa tabela pra appointmens e service orders*/
SELECT 
	id,
    subscriber_id AS EQ,
    name,
    document
FROM customers LIMIT 10;

SELECT DISTINCT(COUNT(subscriber_id)) AS EQ FROM customers;

/* Query Appointments - Nessa tabela estão as SA e as OS vinculadas*/
SELECT
	id,
    customer_id,
    status,
    work_order_id,
    associated_document
FROM appointments LIMIT 10;

SELECT * FROM appointments LIMIT 10;


SELECT 
	COUNT(status),
    status
FROM
	appointments
GROUP BY status;

/* Para saber as OS para cada SA e seu STATUS faço um JOIN pelo associated_document(OS) */

SELECT 
	*
FROM 
	appointments AS a
JOIN service_orders AS s ON
a.associated_document = s.associated_document
LIMIT 10;

/* Trazendo apenas as colunas importantes */

SELECT
	a.id AS id_sa,
    a.customer_id AS customer_id_sa,
    a.status AS status_sa,
    a.work_order_id AS sa,
    s.associated_document AS os,
    s.type AS type_os,
    s.status AS status_os,
    s.created_at,
    s.closed_at
FROM 
	appointments AS a
LEFT JOIN service_orders AS s ON
a.associated_document = s.associated_document
WHERE s.type = 'Retirada'
LIMIT 10;

/* Trazendo a customers */

SELECT
	a.id AS id_sa,
    a.customer_id AS customer_id_sa,
    s.id AS id_os,
    c.subscriber_id AS EQ,
    a.work_order_id AS sa,
    a.status AS status_sa,
    s.associated_document AS os,
    s.type AS type_os,
    s.status AS status_os,
    s.created_at,
    s.closed_at,
    c.name
FROM 
	appointments AS a
JOIN customers AS c ON
a.customer_id = c.id
JOIN service_orders AS s ON
a.associated_document = s.associated_document
LIMIT 10;

/* Retornar o MAX(id_sa) para fazer o join na conta principal GROUP BY EQ */
SELECT
	MAX(a.id) AS id_sa,
    c.subscriber_id AS EQ
FROM 
	appointments AS a
JOIN customers AS c ON
a.customer_id = c.id
JOIN service_orders AS s ON
a.associated_document = s.associated_document
WHERE c.subscriber_id = 'EQ0000000011500'
GROUP BY EQ;

/* Fazendo um JOIN com a consulta principal para retornar somente o MAX id ou seja o status final para cada EQ */

SELECT
	a.id AS id_sa,
    a.customer_id AS customer_id_sa,
    s.id AS id_os,
    c.subscriber_id AS EQ,
    a.work_order_id AS sa,
    a.status AS status_sa,
    s.associated_document AS os,
    s.type AS type_os,
    s.status AS status_os,
    s.created_at,
    s.closed_at,
    c.name
FROM 
	appointments AS a
JOIN customers AS c ON
a.customer_id = c.id
JOIN service_orders AS s ON
a.associated_document = s.associated_document
INNER JOIN 
	(SELECT
		MAX(a.id) AS id_sa,
		c.subscriber_id AS EQ
	FROM 
		appointments AS a
	JOIN customers AS c ON
	a.customer_id = c.id
	JOIN service_orders AS s ON
	a.associated_document = s.associated_document
	GROUP BY EQ) AS id_max ON
a.id = id_max.id_sa
ORDER BY s.created_at DESC;

/* As OS que não são de instalação n tem uma SA vinculada, as OS de bloqueio e retirada estão vinculadas ao EQ*/

/* A OS de retirada/bloqueio está vinculada a EQ, preciso para cada EQ retornar o status recente e após isso
preciso fazer um join com minha consulta de instalados para retornar o status atual do cliente comparando as datas
das duas consultas */