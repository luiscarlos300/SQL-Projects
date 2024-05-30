SELECT
	p.work_order_id,
    COUNT(p.work_order_id) as 'repetidas'
FROM
	equatorial_api.appointments AS p
GROUP BY work_order_id
having repetidas > 1;