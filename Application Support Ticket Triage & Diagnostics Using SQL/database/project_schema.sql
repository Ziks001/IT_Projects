 CREATE DATABASE Support_ticket_dashboard;
  
 USE Support_ticket_dashboard;
 CREATE TABLE tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    logged_at DATETIME,
    user_name VARCHAR(100),
    product_name VARCHAR(100),
    ticket_description TEXT,
    priority ENUM('Low', 'Medium', 'High', 'Critical'),
    status ENUM('Open', 'In Progress', 'Pending', 'Closed'),
    assigned_to VARCHAR(100),
    ticket_report TEXT,
    problem_category ENUM('Bug', 'API Issue', 'Network Error', 'Configuration Issue', 'User Error'),
    resolved_at DATETIME
);