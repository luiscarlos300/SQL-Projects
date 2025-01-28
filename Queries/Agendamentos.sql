SELECT * FROM appointments; -- Tem SA
SELECT * FROM customers; -- Tem EQ subscriber_id
SELECT * FROM service_orders; -- Tem OS e ritm
SELECT * FROM sales_companies; -- Tem a sales_companies
SELECT * FROM service_order_sales_companies; -- Tem as OS e sales_company

SELECT 
	s.type as type,
	s.status as status,
    a.status as status_appointment,
    s.external_id as external,
    s.product as product,
    s.payday as payday,
    s.ritm as ritm,
    s.request_date as request_date,
    s.created_at as created_at,
    s.closed_at as closed_at,
    sc.name as sales_company,
    sc.sap_code as sap_code,
	c.subscriber_id as subscriber_id,
    c.name as name,
    c.email as email,
    c.document as document,
    c.cellphone_number as cellphone_number,
    c.phone_number as phone_number,
    ad.address_id as address_id,
    ad.street as street,
    ad.number as number,
    ad.neighborhood as neighborhood,
    ad.city as city,
    ad.state as state,
    ad.postcode as postcode,
    a.work_order_id as work_order_id,
    a.schedule_start as schedule_start,
	a.schedule_finish as schedule_finish
FROM
	service_orders AS s
LEFT JOIN appointments AS a 
ON s.associated_document = a.associated_document
LEFT JOIN customers AS c 
ON s.customer_id = c.id
LEFT JOIN 
	(SELECT
		sosc.service_order_id,
		sc.name,
        sc.sap_code
	FROM
		service_order_sales_companies AS sosc
	INNER JOIN sales_companies AS sc ON 
	sosc.sales_company_id = sc.id
    ) as sc 
ON s.id = sc.service_order_id
LEFT JOIN addresses as ad
ON s.address_id = ad.id
ORDER BY a.schedule_start DESC
LIMIT 100000;