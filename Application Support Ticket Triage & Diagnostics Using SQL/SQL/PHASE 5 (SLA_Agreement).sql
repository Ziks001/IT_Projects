-- PHASE 5 (Service Level Agreement & Resolution Performance)

SELECT
	ROUND(AVG(TIMESTAMPDIFF(HOUR, logged_at, resolved_at)), 2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL;

SELECT
	ticket_id,
    product_name,
    assigned_to,
    priority,
    TIMESTAMPDIFF(HOUR, logged_at, resolved_at) AS resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL
ORDER BY resolution_hours DESC;

SELECT
    priority,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, logged_at, resolved_at)),2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY priority
ORDER BY
CASE priority
    WHEN 'critical' THEN 1
    WHEN 'high' THEN 2
    WHEN 'medium' THEN 3
    WHEN 'low' THEN 4
END;

SELECT
    product_name,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, logged_at, resolved_at)),2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY product_name
ORDER BY avg_resolution_hours DESC;

SELECT
    assigned_to,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, logged_at, resolved_at)),2) AS avg_resolution_hours
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY assigned_to
ORDER BY avg_resolution_hours;

SELECT
    ticket_id, product_name, priority, assigned_to,
    status
FROM tickets
WHERE resolved_at IS NULL
ORDER BY
CASE priority
    WHEN 'critical' THEN 1
    WHEN 'high' THEN 2
    WHEN 'medium' THEN 3
    WHEN 'Low' THEN 4
END;

SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) AS resolved_tickets,
    ROUND(
        (SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2) AS resolution_rate_percent
FROM tickets;

SELECT
    ticket_id,
    product_name,
    assigned_to,
    TIMESTAMPDIFF(HOUR, logged_at, resolved_at) AS resolution_hours
FROM tickets
WHERE priority = 'critical'
  AND resolved_at IS NOT NULL
  AND TIMESTAMPDIFF(HOUR, logged_at, resolved_at) > 4;