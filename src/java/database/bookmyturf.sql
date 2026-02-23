-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: turf_booking
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `turf_id` int NOT NULL,
  `slot_id` int NOT NULL,
  `booking_date` date NOT NULL,
  `status` enum('BOOKED','CANCELLED') DEFAULT 'BOOKED',
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `turf_id` (`turf_id`),
  KEY `slot_id` (`slot_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`turf_id`) REFERENCES `turf_registration` (`turf_id`),
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`slot_id`) REFERENCES `turf_slots` (`slot_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'USR001',8,1,'2025-12-24','BOOKED'),(2,'USR001',8,1,'2025-12-21','CANCELLED'),(3,'USR001',8,1,'2025-12-22','BOOKED'),(4,'USR001',10,15,'2025-12-22','BOOKED'),(5,'USR001',8,6,'2025-12-24','BOOKED'),(6,'USR001',8,2,'2025-12-24','BOOKED'),(7,'USR002',8,3,'2025-12-24','BOOKED');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turf_images`
--

DROP TABLE IF EXISTS `turf_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turf_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `turf_id` int NOT NULL,
  `image_type` enum('turf_photo','ownership_proof','business_certificate') NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`image_id`),
  KEY `fk_turf` (`turf_id`),
  CONSTRAINT `fk_turf` FOREIGN KEY (`turf_id`) REFERENCES `turf_registration` (`turf_id`) ON DELETE CASCADE,
  CONSTRAINT `turf_images_ibfk_1` FOREIGN KEY (`turf_id`) REFERENCES `turf_registration` (`turf_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turf_images`
--

LOCK TABLES `turf_images` WRITE;
/*!40000 ALTER TABLE `turf_images` DISABLE KEYS */;
INSERT INTO `turf_images` VALUES (2,8,'turf_photo','me.jpg','2025-10-21 06:53:34'),(3,8,'ownership_proof','Ro.jpg','2025-10-21 06:53:34'),(4,8,'business_certificate','MessiImg.jpg','2025-10-21 06:53:34'),(7,10,'turf_photo','std.jpg','2025-10-25 07:06:37'),(8,10,'ownership_proof','Maaz Ahmad Photo.jpg','2025-10-25 07:06:37'),(9,10,'business_certificate','ZIYAD AADHAR.jpg','2025-10-25 07:06:37');
/*!40000 ALTER TABLE `turf_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turf_registration`
--

DROP TABLE IF EXISTS `turf_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turf_registration` (
  `turf_id` int NOT NULL AUTO_INCREMENT,
  `turf_user_id` varchar(100) DEFAULT NULL,
  `owner_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `turf_name` varchar(100) NOT NULL,
  `turf_address` varchar(255) NOT NULL,
  `turf_phone` varchar(15) NOT NULL,
  `price_per_hour` decimal(10,2) NOT NULL,
  `upi_id` varchar(100) NOT NULL,
  `account_number` varchar(30) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `ifsc_code` varchar(15) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `approval_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  PRIMARY KEY (`turf_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `turf_user_id` (`turf_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turf_registration`
--

LOCK TABLES `turf_registration` WRITE;
/*!40000 ALTER TABLE `turf_registration` DISABLE KEYS */;
INSERT INTO `turf_registration` VALUES (8,'abcturf2026','ziyad','ziyadahmad0371@gmail.com','pass123','xyzTurf','Plot no 58 Geeta society ,Utthan nagar , Nagpur, Maharashtra 440013','9865646464',1200.00,'@upi','98654554','union','io0000000','2025-10-21 06:53:34','Approved'),(10,'abcturf1026','ahmad','ziyad@gmail.com','0000','abcturf','Plot no 58 Geeta society ,Utthan nagar , Nagpur, Maharashtra 440013','9865646464',1500.00,'abcupi','98654554','SBI','SBI100000111','2025-10-25 07:06:37','Approved');
/*!40000 ALTER TABLE `turf_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turf_slots`
--

DROP TABLE IF EXISTS `turf_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turf_slots` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `turf_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`slot_id`),
  KEY `turf_id` (`turf_id`),
  CONSTRAINT `turf_slots_ibfk_1` FOREIGN KEY (`turf_id`) REFERENCES `turf_registration` (`turf_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turf_slots`
--

LOCK TABLES `turf_slots` WRITE;
/*!40000 ALTER TABLE `turf_slots` DISABLE KEYS */;
INSERT INTO `turf_slots` VALUES (1,8,'06:00:00','07:00:00'),(2,8,'07:00:00','08:00:00'),(3,8,'08:00:00','09:00:00'),(4,8,'09:00:00','10:00:00'),(5,8,'10:00:00','11:00:00'),(6,8,'11:00:00','12:00:00'),(7,8,'17:00:00','18:00:00'),(8,8,'18:00:00','19:00:00'),(9,8,'19:00:00','20:00:00'),(10,10,'06:00:00','07:00:00'),(11,10,'07:00:00','08:00:00'),(12,10,'08:00:00','09:00:00'),(13,10,'09:00:00','10:00:00'),(14,10,'17:00:00','18:00:00'),(15,10,'18:00:00','19:00:00'),(16,10,'19:00:00','20:00:00');
/*!40000 ALTER TABLE `turf_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `sr_no` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sr_no`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'USR001','ziyad','ziyad@email','8605379504','ziyad00','Male','2025-12-04 16:07:14'),(2,'USR002','ahmad','ahmad@mail','8605379504','ahmad','Male','2025-12-04 16:10:14');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-23 13:26:42
