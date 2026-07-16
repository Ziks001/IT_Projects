-- PHASE 3 (PRODUCT HEALTH ANALYSIS)
SELECT
	product_name,
COUNT(*) AS total_tickets
FROM tickets
GROUP BY product_name
ORDER BY total_tickets DESC;

SELECT
	product_name,
COUNT(*) AS critical_incidents
FROM tickets
WHERE priority = 'critical'
GROUP BY product_name
ORDER BY critical_incidents DESC;

SELECT
	product_name,
COUNT(*) AS open_incidents
FROM tickets
WHERE status != 'closed'
GROUP BY product_name
ORDER BY open_incidents DESC;

SELECT
	product_name,
COUNT(*) AS closed_incidents
FROM tickets
WHERE status = 'closed'
GROUP BY product_name
ORDER BY closed_incidents DESC;

SELECT
	product_name, problem_category,
COUNT(*) AS total
FROM tickets
GROUP BY product_name, problem_category
ORDER BY product_name, total DESC;

SELECT
	product_name,
    MAX(
		CASE priority
			WHEN 'low' THEN 1
            WHEN 'medium' THEN 2
            WHEN 'high' THEN 3
            WHEN 'critical' THEN 4
		END
	) AS highest_priority_level
FROM tickets
GROUP BY product_name;