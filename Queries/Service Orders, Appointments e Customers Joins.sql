SELECT
	os.type as 'type os',
    os.status as 'status os',
    os.product_catalog_id,
    os.associated_document,
    os.closed_at,
	p.work_order_id as 'sa',
    p.status as 'status sa',
    c.name,
    c.document,
    c.subscriber_id
FROM
	equatorial_api.service_orders AS os
INNER JOIN
	equatorial_api.appointments AS p ON os.associated_document = p.associated_document
INNER JOIN
	equatorial_api.customers AS c ON os.customer_id = c.id
WHERE subscriber_id = 'EQ0000000000004';