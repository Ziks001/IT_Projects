-- PHASE 1 (MORNING INCIDENT TRIAGE)
SELECT COUNT(*) AS total_tickets
FROM tickets;

SELECT COUNT(*) AS Unresolved_tickets
FROM tickets
WHERE status <> 'closed'; 

SELECT COUNT(*) AS Critical_tickets
FROM tickets
WHERE priority = 'critical';

SELECT
	ticket_id,
    priority,
    product_name,
    user_name,
    assigned_to,
    status
	FROM tickets
WHERE priority = 'critical'
AND status <> 'closed';

SELECT 
	status,
COUNT(*) AS total
FROM tickets
GROUP BY status;