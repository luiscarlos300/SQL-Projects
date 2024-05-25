SELECT
	-- a.id AS id_sa,
    -- a.customer_id AS customer_id_sa,
    -- s.id AS id_os,
    c.subscriber_id AS EQ,
    a.work_order_id AS sa,
    a.status AS status_sa,
    s.associated_document AS os,
    s.type AS type_os,
    s.status AS status_os,
    a.schedule_start,
    a.schedule_finish,
    c.name,
    c.document
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
HAVING a.status = 'Concluido com sucesso'
ORDER BY s.created_at DESC
LIMIT 30000;