-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: support_ticket_dashboard
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `logged_at` datetime DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `ticket_description` text,
  `priority` enum('Low','Medium','High','Critical') DEFAULT NULL,
  `status` enum('Open','In Progress','Pending','Closed') DEFAULT NULL,
  `assigned_to` varchar(100) DEFAULT NULL,
  `ticket_report` text,
  `problem_category` enum('Bug','API Issue','Network Error','Configuration Issue','User Error') DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'2025-06-01 09:00:00','Ngozi Adeyemi','Payroll System','system crashes when processing bulk salary payments','Critical','In Progress','James Okafor',NULL,'Bug',NULL),(2,'2025-06-03 14:15:00','Tunde Bello','Leave Management System','calendar view does not load on Internet Explorer','Low','Open','Amaka Obi',NULL,'Bug',NULL),(3,'2025-06-05 11:30:00','Fatima Musa','Expense Tracker','submitted expense reports are not triggering email notifications to managers','Medium','Pending','James Okafor',NULL,'API Issue',NULL),(4,'2025-06-07 08:45:00','Emeka Eze','Payroll System','tax deduction calculations are producing incorrect figures for contract staff','High','Closed','Amaka Obi',NULL,'Bug','2025-06-07 15:30:00'),(5,'2025-06-08 10:00:00','Chidi Okonkwo','Payroll System','all employee payslips are showing zero net pay after the latest system update','Critical','Closed','James Okafor',NULL,'Bug','2025-06-08 13:45:00'),(6,'2025-06-09 15:00:00','Amaka Obi','HR Software','employee onboarding form throws a 404 error when submitting new hire documents','Medium','In Progress','James Okafor',NULL,'Bug',NULL),(7,'2025-06-10 09:20:00','Ngozi Adeyemi','Expense Tracker','currency conversion rates are not updating automatically from the external exchange rate API','Low','Open','Amaka Obi',NULL,'API Issue',NULL),(8,'2025-06-10 11:00:00','Tunde Bello','Leave Management System','annual leave balances are not resetting at the start of the new financial year','High','Closed','James Okafor',NULL,'Configuration Issue','2025-06-11 10:15:00'),(9,'2025-06-11 14:30:00','Fatima Musa','HR Software','user profile photos are not saving after upload. The page refreshes and reverts to the default avatar','Medium','Pending','Amaka Obi',NULL,'Bug',NULL),(10,'2025-06-12 08:00:00','Emeka Eze','Expense Tracker','user attempted to submit a receipt but the file upload button is unresponsive on Safari browser','Low','Open','James Okafor',NULL,'Bug',NULL),(11,'2025-06-12 09:45:00','Chidi Okonkwo','Payroll System','the system is timing out when generating end-of-month reports for departments with more than 100 staff','Critical','In Progress','James Okafor',NULL,'Bug',NULL),(12,'2025-06-13 13:00:00','Ngozi Adeyemi','HR Software','the performance review module is sending duplicate email notifications to line managers. Each manager is receiving the same alert three times','High','Closed','Amaka Obi',NULL,'API Issue','2025-06-14 11:00:00'),(13,'2025-06-14 10:30:00','Tunde Bello','Leave Management System','users in the Lagos branch are unable to log in. Authentication is failing despite correct credentials','Medium','Closed','James Okafor',NULL,'Network Error','2025-06-14 14:00:00'),(14,'2025-06-15 15:45:00','Fatima Musa','Expense Tracker','the PDF export function is generating blank pages instead of the expense summary report','Low','Open','Amaka Obi',NULL,'Bug',NULL),(15,'2025-06-16 09:00:00','Amaka Obi','Payroll System','bank account details for 12 employees were not saved correctly after the last data migration. Payments risk going to wrong accounts','High','Closed','James Okafor',NULL,'Configuration Issue','2025-06-16 12:30:00'),(16,'2025-06-17 11:15:00','Chidi Okonkwo','HR Software','the org chart visualisation is not rendering correctly when the company hierarchy exceeds four levels','Medium','In Progress','Amaka Obi',NULL,'Bug',NULL),(17,'2025-06-18 08:30:00','Ngozi Adeyemi','Payroll System','the system is rejecting all pension deduction entries with a validation error. No pension contributions can be processed','Critical','Closed','James Okafor',NULL,'Bug','2025-06-18 11:00:00'),(18,'2025-06-19 14:00:00','Emeka Eze','Leave Management System','the mobile app version of the leave request form is displaying incorrectly on Android devices running version 13 and above','Low','Open','Amaka Obi',NULL,'Bug',NULL),(19,'2025-06-20 10:00:00','Tunde Bello','HR Software','bulk user import via CSV is failing silently. No error message is shown but none of the imported users appear in the system','High','Closed','James Okafor',NULL,'Configuration Issue','2025-06-20 16:15:00'),(20,'2025-06-21 09:15:00','Fatima Musa','Payroll System','the entire payroll module is inaccessible after a failed overnight system update. All users are getting a 503 Service Unavailable error','Critical','In Progress','James Okafor',NULL,'Bug',NULL);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-16 18:02:19
