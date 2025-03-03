/*
SQLyog Ultimate v8.55 
MySQL - 5.5.5-10.4.32-MariaDB : Database - db_pantawid
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `alembic_version` */

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbl_dedupe_results` */

CREATE TABLE `tbl_dedupe_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `entry_id` int(11) NOT NULL,
  `duplicate_id` int(11) NOT NULL,
  `similarity_score` float NOT NULL,
  `dob_score` decimal(5,2) NOT NULL,
  `address_score` decimal(5,2) NOT NULL,
  `final_score` decimal(5,2) NOT NULL,
  `tag` enum('validated_duplicate','high-possibility','low-possibility','no-match') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_task_entry` (`task_id`,`entry_id`),
  KEY `entry_id` (`entry_id`),
  CONSTRAINT `tbl_dedupe_results_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tbl_dedupe_tasks` (`task_id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_dedupe_results_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `tbl_roster` (`entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbl_dedupe_tasks` */

CREATE TABLE `tbl_dedupe_tasks` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_started` datetime NOT NULL,
  `date_complete` datetime DEFAULT NULL,
  `number_of_rows` int(11) NOT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbl_roster` */

CREATE TABLE `tbl_roster` (
  `ï»¿SORT_ORDER` int(11) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `municipality` varchar(255) DEFAULT NULL,
  `barangay` varchar(255) DEFAULT NULL,
  `geocode` int(11) DEFAULT NULL,
  `hh_id` varchar(255) DEFAULT NULL,
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `ext_name` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `age_on_health` int(11) DEFAULT NULL,
  `age_on_educ` int(11) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `client_status` varchar(255) DEFAULT NULL,
  `cs_code` int(11) DEFAULT NULL,
  `member_status` varchar(255) DEFAULT NULL,
  `ms_code` int(11) DEFAULT NULL,
  `relation_to_hh_head` varchar(255) DEFAULT NULL,
  `rel_hh_id` int(11) DEFAULT NULL,
  `civil_status` varchar(255) DEFAULT NULL,
  `grantee` varchar(255) DEFAULT NULL,
  `registration_status` varchar(255) DEFAULT NULL,
  `hh_set` varchar(255) DEFAULT NULL,
  `solo_parent` varchar(255) DEFAULT NULL,
  `ip_affiliation` varchar(255) DEFAULT NULL,
  `pcn` varchar(255) DEFAULT NULL,
  `pcn_remarks` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `pregnancy_status` varchar(255) DEFAULT NULL,
  `health_faci_code` int(11) DEFAULT NULL,
  `health_facility` varchar(255) DEFAULT NULL,
  `monitored_health` varchar(255) DEFAULT NULL,
  `archived_health_faci` varchar(255) DEFAULT NULL,
  `health_faci_remarks` varchar(255) DEFAULT NULL,
  `reason_for_not_attending_health` varchar(255) DEFAULT NULL,
  `date_reason_health` varchar(255) DEFAULT NULL,
  `child_bene` varchar(255) DEFAULT NULL,
  `grade_level` varchar(255) DEFAULT NULL,
  `strands` varchar(255) DEFAULT NULL,
  `tracks` varchar(255) DEFAULT NULL,
  `attend_school` varchar(255) DEFAULT NULL,
  `school_code` int(11) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `monitored_educ` varchar(255) DEFAULT NULL,
  `archived_educ_faci` varchar(255) DEFAULT NULL,
  `school_remarks` varchar(255) DEFAULT NULL,
  `reason_for_not_attending_educ` varchar(255) DEFAULT NULL,
  `date_reason_educ` varchar(255) DEFAULT NULL,
  `lrn` float DEFAULT NULL,
  `lrn_remarks` varchar(255) DEFAULT NULL,
  `disability_remarks` varchar(255) DEFAULT NULL,
  `final_disability` varchar(255) DEFAULT NULL,
  `cct_type` varchar(255) DEFAULT NULL,
  `disability` varchar(255) DEFAULT NULL,
  `mcctcategory` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12115687 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Table structure for table `tbl_test` */

CREATE TABLE `tbl_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `dt` date DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
