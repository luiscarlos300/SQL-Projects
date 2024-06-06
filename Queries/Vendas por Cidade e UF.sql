SELECT * FROM appointments; -- Tem SA
SELECT * FROM customers; -- Tem EQ subscriber_id
SELECT * FROM service_orders; -- Tem OS e ritm
SELECT * FROM sales_companies; -- Tem a sales_companies
SELECT * FROM service_order_sales_companies; -- Tem as OS e sales_company

SELECT 
	/*s.type as type_os,
	s.status as status_os,
    a.status as status_appointment,
    s.external_id as external_id_os,
    s.product as product_os,
    s.payday as payday_os,
    s.ritm,
    s.request_date,
    s.created_at as created_at_os,
    s.closed_at as closed_at_os,
    sc.name as sales_company,
    sc.sap_code,
	c.subscriber_id,
    c.name,
    c.email,
    c.document,
    c.cellphone_number,
    c.phone_number,
    ad.address_id,
    ad.street,
    ad.number,
    ad.neighborhood,
    ad.state,
    ad.postcode,
    ad.complements,
    a.work_order_id, */
    ad.state as UF,
    ad.city as CIDADE,
    COUNT( DISTINCT(c.subscriber_id)) AS VENDA_APROVADA
    #a.schedule_start,
	#a.schedule_finish
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
WHERE s.type = 'Instalacao' AND s.created_at BETWEEN '2023-08-01 00:00:00' AND '2023-08-31 00:00:00'
GROUP BY ad.city, ad.state
#ORDER BY c.subscriber_id DESC;