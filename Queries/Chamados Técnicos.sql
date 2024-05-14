SELECT * FROM trouble_tickets ORDER BY id DESC; -- Tem os chamados técnicos
SELECT * FROM appointments; -- Tem SA

SELECT
	t.status,
    t.code,
    t.external_id,
    t.created_at,
    t.closed_at,
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
    ad.city,
    ad.state,
    ad.postcode,
    ad.complements,
    a.work_order_id,
    a.status as appointment_status,
    a.schedule_start,
    a.schedule_finish
FROM
	trouble_tickets as t
LEFT JOIN customers as c 
ON t.customer_id = c.id
LEFT JOIN addresses as ad
ON t.address_id = ad.id
LEFT JOIN appointments AS a
ON t.associated_document = a.associated_document;