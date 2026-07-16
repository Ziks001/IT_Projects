-- PHASE 4 (ROOT CAUSE ANALYSIS)
USE support_ticket_dashboard;
SELECT
	problem_category,
    COUNT(*) AS total_incidents
FROM tickets
GROUP BY problem_category
ORDER BY total_incidents DESC;

SELECT
	problem_category, priority,
    COUNT(*) AS total
FROM tickets
GROUP BY problem_category, priority
ORDER BY problem_category, total DESC;

SELECT
	problem_category,
    COUNT(*) AS unresolved
FROM tickets
WHERE status <> 'closed'
GROUP BY problem_category
ORDER BY unresolved DESC;

SELECT 
	DATE(logged_at) AS ticket_date,
    COUNT(*) AS tickets_logged
FROM tickets
GROUP BY DATE(logged_at)
ORDER BY ticket_date;

SELECT
	DATE(logged_at) AS incident_date,
    COUNT(*) AS critical_incidents
FROM tickets
WHERE priority = 'critical'
GROUP BY DATE(logged_at)
ORDER BY incident_date DESC;

SELECT
	product_name,
    COUNT(*) AS software_defect_count
FROM tickets
WHERE problem_category = 'Bug'
GROUP BY product_name
ORDER BY software_defect_count DESC;

SELECT
	assigned_to,
    COUNT(*) AS software_defect_tickets
FROM tickets
WHERE problem_category = 'Bug'
GROUP BY assigned_to
ORDER BY software_defect_tickets DESC;