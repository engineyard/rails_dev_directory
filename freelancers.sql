-- MySQL dump 10.13  Distrib 5.1.41, for apple-darwin9.5.0 (i386)
--
-- Host: localhost    Database: freelancers_development
-- ------------------------------------------------------
-- Server version	5.1.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `text` varchar(255) DEFAULT NULL,
  `correct` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auditable_type` varchar(255) DEFAULT NULL,
  `auditable_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `auditable_index` (`auditable_type`,`action`),
  KEY `auditable_object` (`auditable_type`,`auditable_id`),
  KEY `auditable_user_index` (`user_id`,`auditable_type`),
  KEY `index_audits_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
INSERT INTO `audits` VALUES (1,'Provider',1,'create',NULL,'2009-11-04 17:23:32','2009-11-04 17:23:32'),(2,'Provider',1,'update',NULL,'2009-11-04 17:23:32','2009-11-04 17:23:32'),(3,'Provider',1,'update',NULL,'2009-11-04 17:37:20','2009-11-04 17:37:20'),(4,'Provider',1,'update',NULL,'2009-11-04 17:38:21','2009-11-04 17:38:21'),(5,'Endorsement',1,'create',NULL,'2009-11-04 17:54:08','2009-11-04 17:54:08'),(6,'Provider',1,'update',NULL,'2009-11-04 17:54:09','2009-11-04 17:54:09'),(7,'Endorsement',1,'update',NULL,'2009-11-04 17:56:59','2009-11-04 17:56:59'),(8,'Provider',1,'update',NULL,'2009-11-04 17:56:59','2009-11-04 17:56:59'),(9,'Provider',1,'update',NULL,'2009-11-04 17:59:50','2009-11-04 17:59:50'),(10,'Provider',2,'create',NULL,'2009-11-04 19:02:33','2009-11-04 19:02:33'),(11,'Provider',2,'update',NULL,'2009-11-04 19:02:33','2009-11-04 19:02:33'),(12,'Provider',1,'update',NULL,'2009-11-11 16:05:29','2009-11-11 16:05:29'),(13,'Feedback',1,'create',NULL,'2009-11-11 16:16:22','2009-11-11 16:16:22'),(14,'Feedback',1,'update',NULL,'2009-11-11 16:28:40','2009-11-11 16:28:40');
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `behavior_configs`
--

DROP TABLE IF EXISTS `behavior_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `behavior_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_behavior_configs_on_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `behavior_configs`
--

LOCK TABLES `behavior_configs` WRITE;
/*!40000 ALTER TABLE `behavior_configs` DISABLE KEYS */;
/*!40000 ALTER TABLE `behavior_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_samples`
--

DROP TABLE IF EXISTS `code_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` text COLLATE utf8_unicode_ci,
  `provider_id` int(11) DEFAULT NULL,
  `aasm_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_samples`
--

LOCK TABLES `code_samples` WRITE;
/*!40000 ALTER TABLE `code_samples` DISABLE KEYS */;
INSERT INTO `code_samples` VALUES (1,'Here we go','some code',1,'show',NULL,'2009-12-09 21:21:48','2009-12-09 22:10:26');
/*!40000 ALTER TABLE `code_samples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endorsement_requests`
--

DROP TABLE IF EXISTS `endorsement_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endorsement_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `recipients` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endorsement_requests`
--

LOCK TABLES `endorsement_requests` WRITE;
/*!40000 ALTER TABLE `endorsement_requests` DISABLE KEYS */;
INSERT INTO `endorsement_requests` VALUES (2,1,'Please endorse me!','2009-11-04 17:52:19','2009-11-04 17:52:19',NULL),(3,1,'Hi Nick,\r\n\r\nI\'m desperate for work. Could you make up some shit about me?\r\n\r\nCheers,\r\n\r\nPaul','2009-11-04 19:14:00','2009-11-04 19:14:00',NULL),(4,1,'please?','2009-11-04 19:18:32','2009-11-04 19:18:32',NULL);
/*!40000 ALTER TABLE `endorsement_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endorsements`
--

DROP TABLE IF EXISTS `endorsements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endorsements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `year_hired` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `endorsement` text,
  `aasm_state` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `endorser_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_recommendations_on_aasm_state` (`aasm_state`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endorsements`
--

LOCK TABLES `endorsements` WRITE;
/*!40000 ALTER TABLE `endorsements` DISABLE KEYS */;
INSERT INTO `endorsements` VALUES (1,'Paul Campbell','Rushed Sunlight','paul+endorse@rslw.com','http://rslw.com',1,'2009-11-04 17:54:08','2009-11-04 17:56:59','2009','CEO','Nice work Paul!','approved',NULL,2);
/*!40000 ALTER TABLE `endorsements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endorsers`
--

DROP TABLE IF EXISTS `endorsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endorsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `endorsement_request_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `validation_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endorsers`
--

LOCK TABLES `endorsers` WRITE;
/*!40000 ALTER TABLE `endorsers` DISABLE KEYS */;
INSERT INTO `endorsers` VALUES (2,2,'paul+endorse@rslw.com','XvSkHWUj-OG3G4TJzNAJ'),(3,3,'nfrench@engineyard.com','q_KYI7V3RNTW3ReguzC3'),(4,4,'paul+another-endorsement@rslw.com','ub0HkMgDSBynPWulYAUX');
/*!40000 ALTER TABLE `endorsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `year_hired` varchar(255) DEFAULT NULL,
  `project` varchar(255) DEFAULT NULL,
  `message` text,
  `aasm_state` varchar(255) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (1,'Joe Drumgoole','joe@putplace.com','Putplace','CEO','2009','Putplace','Paul Was Awesome','accepted',1,'2009-11-11 16:16:22','2009-11-11 16:28:40');
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homepages`
--

DROP TABLE IF EXISTS `homepages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `homepages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homepages`
--

LOCK TABLES `homepages` WRITE;
/*!40000 ALTER TABLE `homepages` DISABLE KEYS */;
/*!40000 ALTER TABLE `homepages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `keywords` text,
  `description` text,
  `content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolio_items`
--

DROP TABLE IF EXISTS `portfolio_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolio_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` text,
  `year_completed` varchar(255) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolio_items`
--

LOCK TABLES `portfolio_items` WRITE;
/*!40000 ALTER TABLE `portfolio_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `portfolio_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provided_services`
--

DROP TABLE IF EXISTS `provided_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provided_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `proficiency` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provided_services`
--

LOCK TABLES `provided_services` WRITE;
/*!40000 ALTER TABLE `provided_services` DISABLE KEYS */;
INSERT INTO `provided_services` VALUES (13,1,1,'2009-11-04 17:59:50','2009-11-04 17:59:50',NULL),(14,6,1,'2009-11-04 17:59:50','2009-11-04 17:59:50',NULL),(15,7,1,'2009-11-04 17:59:50','2009-11-04 17:59:50',NULL),(16,9,1,'2009-11-04 17:59:50','2009-11-04 17:59:50',3),(17,10,1,'2009-11-04 17:59:50','2009-11-04 17:59:50',2),(18,1,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',NULL),(19,2,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',1),(20,9,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',1),(21,10,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',1),(22,11,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',1),(23,2,2,'2009-11-04 19:02:33','2009-11-04 19:02:33',NULL),(24,16,1,'2009-11-11 16:05:29','2009-11-11 16:05:29',NULL),(25,15,1,'2009-11-11 16:05:29','2009-11-11 16:05:29',NULL),(26,3,1,'2009-11-11 16:05:29','2009-11-11 16:05:29',2),(27,2,1,'2009-11-11 16:05:29','2009-11-11 16:05:29',3);
/*!40000 ALTER TABLE `provided_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `company_size` int(11) DEFAULT NULL,
  `logo_file_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `hourly_rate` decimal(10,2) DEFAULT '0.00',
  `min_budget` decimal(10,2) DEFAULT '0.00',
  `aasm_state` varchar(255) DEFAULT NULL,
  `further_street_address` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `company_url` varchar(255) DEFAULT NULL,
  `marketing_description` text,
  `endorsements_count` int(11) DEFAULT '0',
  `min_hours` int(11) DEFAULT NULL,
  `max_hours` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_providers_on_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'Paul Campbell','28 Malahide Road','Dublin','NA','Dublin 3','IE','087-9148162','paul@rushedsunlight.com',NULL,NULL,'2009-11-04 17:23:32','2009-11-04 17:56:59','100.00','1000.00','inactive','28 Malahide Road',1,'paul-campbell','http://rushedsunlight.com','I\'m awesome',1,1,1000),(2,'Engine Yard','500 Third Street','San Francisco','CA','94107','US','415-722-5148','info@engineyard.com',NULL,NULL,'2009-11-04 19:02:33','2009-11-04 19:02:33','100.00','3000.00','inactive','',2,'engine-yard','http://www.engineyard.com','',0,0,20);
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quiz_id` int(11) DEFAULT NULL,
  `text` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_result_answers`
--

DROP TABLE IF EXISTS `quiz_result_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_result_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quiz_result_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `correct` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_result_answers`
--

LOCK TABLES `quiz_result_answers` WRITE;
/*!40000 ALTER TABLE `quiz_result_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_result_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_results`
--

DROP TABLE IF EXISTS `quiz_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) DEFAULT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `passed` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_results`
--

LOCK TABLES `quiz_results` WRITE;
/*!40000 ALTER TABLE `quiz_results` DISABLE KEYS */;
INSERT INTO `quiz_results` VALUES (1,1,1,NULL,'2009-11-11 15:48:11','2009-11-11 15:48:11'),(2,1,1,NULL,'2009-11-11 15:57:13','2009-11-11 15:57:13'),(3,2,1,NULL,'2009-12-07 21:22:50','2009-12-07 21:22:50');
/*!40000 ALTER TABLE `quiz_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (1,'Paul\'s Really Hard Rails Quiz','2009-11-04 18:01:53','2009-11-04 18:01:53');
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_requests`
--

DROP TABLE IF EXISTS `reference_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `message` text,
  `validation_token` varchar(255) DEFAULT NULL,
  `endorsement_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_requests`
--

LOCK TABLES `reference_requests` WRITE;
/*!40000 ALTER TABLE `reference_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `references`
--

DROP TABLE IF EXISTS `references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `reference_request_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `references`
--

LOCK TABLES `references` WRITE;
/*!40000 ALTER TABLE `references` DISABLE KEYS */;
/*!40000 ALTER TABLE `references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requested_services`
--

DROP TABLE IF EXISTS `requested_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requested_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfp_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requested_services`
--

LOCK TABLES `requested_services` WRITE;
/*!40000 ALTER TABLE `requested_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `requested_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfp_id` int(11) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `unread` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `index_requests_on_provider_id` (`provider_id`),
  KEY `index_requests_on_rfp_id` (`rfp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rfps`
--

DROP TABLE IF EXISTS `rfps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rfps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `nda_required` tinyint(1) DEFAULT NULL,
  `project_description` text,
  `platform_requirements` text,
  `budget` int(11) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `time_zone` varchar(255) DEFAULT NULL,
  `office_location` varchar(255) DEFAULT NULL,
  `general_liability_insurance` tinyint(1) DEFAULT NULL,
  `professional_liability_insurance` tinyint(1) DEFAULT NULL,
  `additional_services` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `shortcode_url` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `duration` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rfps`
--

LOCK TABLES `rfps` WRITE;
/*!40000 ALTER TABLE `rfps` DISABLE KEYS */;
/*!40000 ALTER TABLE `rfps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090520234311'),('20090521001034'),('20090523012012'),('20090523013700'),('20090523015421'),('20090523015630'),('20090523020040'),('20090523142627'),('20090523193059'),('20090524175136'),('20090526230734'),('20090526231325'),('20090526235449'),('20090527001010'),('20090527215235'),('20090601180132'),('20090601180320'),('20090601193333'),('20090603200757'),('20090603204159'),('20090603212140'),('20090606182540'),('20090606193434'),('20090608180233'),('20090609101539'),('20090609143326'),('20090609180300'),('20090609193407'),('20090610202909'),('20090611195617'),('20090614124256'),('20090616174053'),('20090616175443'),('20090616203005'),('20090616213630'),('20090616214503'),('20090620182148'),('20090620183333'),('20090620183458'),('20090622185858'),('20090622215055'),('20090625181813'),('20090710145305'),('20090710163745'),('20090715182232'),('20090715182842'),('20090717180026'),('20090729200532'),('20090729204102'),('20090923225131'),('20091006142645'),('20091028112016'),('20091028114523'),('20091028115010'),('20091028142901'),('20091028143542'),('20091029120013'),('20091029172840'),('20091030102245'),('20091030121952'),('20091030135121'),('20091030163709'),('20091103093719'),('20091103135702'),('20091103144800'),('20091103144829'),('20091103144906'),('20091104113027'),('20091104144127'),('20091105132805'),('20091106141312'),('20091106150556'),('20091209190516'),('20091210164854'),('20091210190840');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `proficiency` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
INSERT INTO `service_categories` VALUES (1,'Toolkit','2009-11-04 17:30:54','2009-11-04 17:30:54',4,1),(2,'Programming Languages','2009-11-04 17:31:13','2009-11-04 17:31:13',2,1),(3,'Methodologies','2009-11-04 17:31:25','2009-11-04 17:31:31',5,1),(4,'Spoken Languages','2009-11-04 17:31:45','2009-11-04 17:31:45',6,1),(5,'Accepted Payment Methods','2009-11-04 17:31:59','2009-11-04 17:31:59',7,0),(6,'Rails Stack','2009-11-04 17:38:59','2009-11-04 17:39:05',3,1),(7,'General','2009-12-10 18:59:59','2009-12-10 18:59:59',1,0);
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT '0',
  `service_category_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_services_on_service_category_id` (`service_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Credit Card',2,'2009-11-04 17:32:21','2009-12-10 19:21:25',0,5,3),(2,'Ruby',3,'2009-11-04 17:32:37','2009-11-04 17:32:37',1,2,2),(3,'PHP',2,'2009-11-04 17:32:46','2009-11-04 17:32:46',0,2,2),(4,'C++',1,'2009-11-04 17:32:57','2009-12-10 19:18:28',0,2,2),(5,'Java',4,'2009-11-04 17:33:09','2009-11-04 17:33:09',0,2,2),(6,'Paypal',1,'2009-11-04 17:33:20','2009-12-10 19:21:21',0,5,3),(7,'Bank Transfer',3,'2009-11-04 17:33:30','2009-12-10 19:21:28',0,5,3),(8,'Behaviour Driven Development',1,'2009-11-04 17:34:37','2009-11-04 17:34:37',0,3,2),(9,'English',2,'2009-11-04 17:35:00','2009-12-10 19:21:03',0,4,1),(10,'French',1,'2009-11-04 17:35:50','2009-12-10 19:21:01',0,4,1),(11,'Ruby on Rails',3,'2009-11-04 17:36:01','2009-11-04 17:36:01',0,1,2),(12,'Cucumber',1,'2009-11-04 17:36:09','2009-11-04 17:36:09',0,1,2),(13,'RSpec',2,'2009-11-04 17:36:15','2009-11-04 17:36:15',0,1,2),(15,'nginx',2,'2009-11-04 17:39:26','2009-11-04 17:39:26',0,6,2),(16,'Phusion Passenger',1,'2009-11-04 17:39:40','2009-11-04 17:39:40',0,6,2),(18,'AJAX / Javascript Coding',1,'2009-12-10 19:01:57','2009-12-10 19:18:20',0,7,2);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_blocks`
--

DROP TABLE IF EXISTS `time_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_blocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) DEFAULT NULL,
  `start` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_blocks`
--

LOCK TABLES `time_blocks` WRITE;
/*!40000 ALTER TABLE `time_blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `crypted_password` varchar(255) DEFAULT NULL,
  `password_salt` varchar(255) DEFAULT NULL,
  `persistence_token` varchar(255) DEFAULT NULL,
  `login_count` int(11) NOT NULL DEFAULT '0',
  `last_request_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `current_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL,
  `current_login_ip` varchar(255) DEFAULT NULL,
  `perishable_token` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `index_users_on_perishable_token` (`perishable_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'paul@rslw.com','2009-11-04 17:23:32','2009-12-10 19:27:53',1,'Paul','Campbell',1,'7f2a32c6c98d69a15aefa796c2504328c49619536661d38bc7f631adbcac5fa4b11e329770cdec326680a6fc524cc7b108786f59d52202eabdcc33084b1f0a69','Xdk52-dm7YoB8KSr2CqV','636bc2e31b7a47905d21e8579cf4004122ba986ef47f15cfd17064917932db0f5e78979ea7c5fea139c85457cb59fc72b43249b63f6fd5e8f37dc1f8207b5bf3',6,'2009-12-10 19:27:53','2009-11-11 16:28:12','2009-12-10 17:03:21','89.100.39.244','127.0.0.1','9xNP3SoRe0e2vst-kbM6'),(2,'nfrench@engineyard.com','2009-11-04 19:02:33','2009-12-07 23:32:16',2,'Nick','French',1,'7590eee7150f074ea6d1bad0f0beaac4f70d072f5777cf8048b7ea9599742f54b8ee1f6a1908192e38d047091407d3c9b51bd321f7e101dd7fdcc5ac7829afa7','ZSmgjtznIsytl5-bYeOh','b88dd202ab55cc7aa7dc119ab3b54be859e911cc8e95d644b3ed3f0abbd22dd9b9565d86c850b7bfa1a9ad846f3b81ce00ca0c7b4aaeb72b76fc5f5503bff37c',4,'2009-12-07 23:32:16','2009-12-02 01:08:59','2009-12-07 21:08:55','74.217.192.114','74.217.192.114','KiN-65RqaWzAKFLKbaq5');
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

-- Dump completed on 2009-12-10 19:37:56
