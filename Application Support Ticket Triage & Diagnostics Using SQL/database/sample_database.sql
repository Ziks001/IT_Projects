USE Support_ticket_dashboard;

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Ngozi Adeyemi', '2025-06-01 09:00:00', 'Payroll System', 'system crashes when processing bulk salary payments', 'In Progress', 'James Okafor', 'Bug', 'Critical');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Tunde Bello', '2025-06-03 14:15:00', 'Leave Management System', 'calendar view does not load on Internet Explorer', 'Open', 'Amaka Obi', 'Bug', 'Low');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Fatima Musa', '2025-06-05 11:30:00', 'Expense Tracker', 'submitted expense reports are not triggering email notifications to managers', 'Pending', 'James Okafor', 'API Issue', 'Medium');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Emeka Eze', '2025-06-07 08:45:00', 'Payroll System', 'tax deduction calculations are producing incorrect figures for contract staff', 'Closed', 'Amaka Obi', 'Bug', 'High', '2025-06-07 15:30:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Chidi Okonkwo', '2025-06-08 10:00:00', 'Payroll System', 'all employee payslips are showing zero net pay after the latest system update', 'Closed', 'James Okafor', 'Bug', 'Critical', '2025-06-08 13:45:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Amaka Obi', '2025-06-09 15:00:00', 'HR Software', 'employee onboarding form throws a 404 error when submitting new hire documents', 'In Progress', 'James Okafor', 'Bug', 'Medium');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Ngozi Adeyemi', '2025-06-10 09:20:00', 'Expense Tracker', 'currency conversion rates are not updating automatically from the external exchange rate API', 'Open', 'Amaka Obi', 'API Issue', 'Low');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Tunde Bello', '2025-06-10 11:00:00', 'Leave Management System', 'annual leave balances are not resetting at the start of the new financial year', 'Closed', 'James Okafor', 'Configuration Issue', 'High', '2025-06-11 10:15:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Fatima Musa', '2025-06-11 14:30:00', 'HR Software', 'user profile photos are not saving after upload. The page refreshes and reverts to the default avatar', 'Pending', 'Amaka Obi', 'Bug', 'Medium');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Emeka Eze', '2025-06-12 08:00:00', 'Expense Tracker', 'user attempted to submit a receipt but the file upload button is unresponsive on Safari browser', 'Open', 'James Okafor', 'Bug', 'Low');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Chidi Okonkwo', '2025-06-12 09:45:00', 'Payroll System', 'the system is timing out when generating end-of-month reports for departments with more than 100 staff', 'In Progress', 'James Okafor', 'Bug', 'Critical');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Ngozi Adeyemi', '2025-06-13 13:00:00', 'HR Software', 'the performance review module is sending duplicate email notifications to line managers. Each manager is receiving the same alert three times', 'Closed', 'Amaka Obi', 'API Issue', 'High', '2025-06-14 11:00:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Tunde Bello', '2025-06-14 10:30:00', 'Leave Management System', 'users in the Lagos branch are unable to log in. Authentication is failing despite correct credentials', 'Closed', 'James Okafor', 'Network Error', 'Medium', '2025-06-14 14:00:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Fatima Musa', '2025-06-15 15:45:00', 'Expense Tracker', 'the PDF export function is generating blank pages instead of the expense summary report', 'Open', 'Amaka Obi', 'Bug', 'Low');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Amaka Obi', '2025-06-16 09:00:00', 'Payroll System', 'bank account details for 12 employees were not saved correctly after the last data migration. Payments risk going to wrong accounts', 'Closed', 'James Okafor', 'Configuration Issue', 'High', '2025-06-16 12:30:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Chidi Okonkwo', '2025-06-17 11:15:00', 'HR Software', 'the org chart visualisation is not rendering correctly when the company hierarchy exceeds four levels', 'In Progress', 'Amaka Obi', 'Bug', 'Medium');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Ngozi Adeyemi', '2025-06-18 08:30:00', 'Payroll System', 'the system is rejecting all pension deduction entries with a validation error. No pension contributions can be processed', 'Closed', 'James Okafor', 'Bug', 'Critical', '2025-06-18 11:00:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Emeka Eze', '2025-06-19 14:00:00', 'Leave Management System', 'the mobile app version of the leave request form is displaying incorrectly on Android devices running version 13 and above', 'Open', 'Amaka Obi', 'Bug', 'Low');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority, resolved_at)
VALUES ('Tunde Bello', '2025-06-20 10:00:00', 'HR Software', 'bulk user import via CSV is failing silently. No error message is shown but none of the imported users appear in the system', 'Closed', 'James Okafor', 'Configuration Issue', 'High', '2025-06-20 16:15:00');

INSERT INTO tickets (user_name, logged_at, product_name, ticket_description, status, assigned_to, problem_category, priority)
VALUES ('Fatima Musa', '2025-06-21 09:15:00', 'Payroll System', 'the entire payroll module is inaccessible after a failed overnight system update. All users are getting a 503 Service Unavailable error', 'In Progress', 'James Okafor', 'Bug', 'Critical');