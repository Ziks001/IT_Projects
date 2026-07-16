-- PHASE 2 (ENGINEERS' WORKLOAD)
USE support_ticket_dashboard;
SELECT 
	assigned_to at,
COUNT(*) AS total_assigned
FROM tickets
GROUP BY at;

SELECT
	assigned_to,
COUNT(*) AS active_tickets
FROM tickets
WHERE status <> 'closed'
GROUP BY assigned_to;

SELECT
	assigned_to,
COUNT(*) AS critical_tickets
FROM tickets
WHERE Priority = 'critical'
GROUP BY assigned_to;

SELECT
	assigned_to,
COUNT(*) AS open_tickets
FROM tickets
WHERE status = 'open'
GROUP BY assigned_to;

SELECT
	assigned_to,
COUNT(*) AS closed_tickets
FROM tickets
WHERE status = 'closed'
GROUP BY assigned_to;