/*
SQLyog Ultimate v8.55 
MySQL - 5.5.5-10.4.32-MariaDB : Database - imt_spens
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`imt_spens` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `imt_spens`;

/*Table structure for table `audit_trail` */

CREATE TABLE `audit_trail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `old_value` longtext DEFAULT NULL,
  `new_value` longtext DEFAULT NULL,
  `changed_at` datetime(6) NOT NULL,
  `beneficiary_id` bigint(20) NOT NULL,
  `changed_by_id` int(11) DEFAULT NULL,
  `changed_field` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audit_trail_beneficiary_id_65c7862e_fk_tbl_beneficiaries_id` (`beneficiary_id`),
  KEY `audit_trail_changed_by_id_f2931899_fk_auth_user_id` (`changed_by_id`),
  CONSTRAINT `audit_trail_beneficiary_id_65c7862e_fk_tbl_beneficiaries_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `tbl_beneficiaries` (`id`),
  CONSTRAINT `audit_trail_changed_by_id_f2931899_fk_auth_user_id` FOREIGN KEY (`changed_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `audit_trail` */

insert  into `audit_trail`(`id`,`old_value`,`new_value`,`changed_at`,`beneficiary_id`,`changed_by_id`,`changed_field`) values (1,'alden1213','alden1213333','2025-03-05 03:57:52.427826',1,1,'first_name');

/*Table structure for table `auth_group` */

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (2,'Can change log entry',1,'change_logentry');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (3,'Can delete log entry',1,'delete_logentry');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (4,'Can view log entry',1,'view_logentry');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (5,'Can add permission',2,'add_permission');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (6,'Can change permission',2,'change_permission');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (7,'Can delete permission',2,'delete_permission');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (8,'Can view permission',2,'view_permission');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (9,'Can add group',3,'add_group');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (10,'Can change group',3,'change_group');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (11,'Can delete group',3,'delete_group');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (12,'Can view group',3,'view_group');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (13,'Can add user',4,'add_user');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (14,'Can change user',4,'change_user');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (15,'Can delete user',4,'delete_user');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (16,'Can view user',4,'view_user');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (17,'Can add content type',5,'add_contenttype');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (18,'Can change content type',5,'change_contenttype');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (19,'Can delete content type',5,'delete_contenttype');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (20,'Can view content type',5,'view_contenttype');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (21,'Can add session',6,'add_session');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (22,'Can change session',6,'change_session');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (23,'Can delete session',6,'delete_session');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (24,'Can view session',6,'view_session');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (25,'Can add employee profile',7,'add_employeeprofile');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (26,'Can change employee profile',7,'change_employeeprofile');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (27,'Can delete employee profile',7,'delete_employeeprofile');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (28,'Can view employee profile',7,'view_employeeprofile');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (29,'Can add municipality',8,'add_municipality');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (30,'Can change municipality',8,'change_municipality');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (31,'Can delete municipality',8,'delete_municipality');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (32,'Can view municipality',8,'view_municipality');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (33,'Can add position',9,'add_position');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (34,'Can change position',9,'change_position');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (35,'Can delete position',9,'delete_position');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (36,'Can view position',9,'view_position');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (37,'Can add barangay',10,'add_barangay');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (38,'Can change barangay',10,'change_barangay');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (39,'Can delete barangay',10,'delete_barangay');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (40,'Can view barangay',10,'view_barangay');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (41,'Can add region',11,'add_region');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (42,'Can change region',11,'change_region');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (43,'Can delete region',11,'delete_region');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (44,'Can view region',11,'view_region');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (45,'Can add province',12,'add_province');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (46,'Can change province',12,'change_province');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (47,'Can delete province',12,'delete_province');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (48,'Can view province',12,'view_province');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (49,'Can add beneficiary',13,'add_beneficiary');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (50,'Can change beneficiary',13,'change_beneficiary');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (51,'Can delete beneficiary',13,'delete_beneficiary');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (52,'Can view beneficiary',13,'view_beneficiary');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (53,'Can add payroll detail',14,'add_payrolldetail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (54,'Can change payroll detail',14,'change_payrolldetail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (55,'Can delete payroll detail',14,'delete_payrolldetail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (56,'Can view payroll detail',14,'view_payrolldetail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (57,'Can add payroll',15,'add_payroll');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (58,'Can change payroll',15,'change_payroll');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (59,'Can delete payroll',15,'delete_payroll');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (60,'Can view payroll',15,'view_payroll');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (61,'Can add fund source',16,'add_fundsource');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (62,'Can change fund source',16,'change_fundsource');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (63,'Can delete fund source',16,'delete_fundsource');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (64,'Can view fund source',16,'view_fundsource');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (65,'Can add liquidation',17,'add_liquidation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (66,'Can change liquidation',17,'change_liquidation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (67,'Can delete liquidation',17,'delete_liquidation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (68,'Can view liquidation',17,'view_liquidation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (69,'Can add obligation',18,'add_obligation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (70,'Can change obligation',18,'change_obligation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (71,'Can delete obligation',18,'delete_obligation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (72,'Can view obligation',18,'view_obligation');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (73,'Can add beneficiary change log',19,'add_beneficiarychangelog');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (74,'Can change beneficiary change log',19,'change_beneficiarychangelog');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (75,'Can delete beneficiary change log',19,'delete_beneficiarychangelog');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (76,'Can view beneficiary change log',19,'view_beneficiarychangelog');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (77,'Can add audit trail',20,'add_audittrail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (78,'Can change audit trail',20,'change_audittrail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (79,'Can delete audit trail',20,'delete_audittrail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (80,'Can view audit trail',20,'view_audittrail');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (81,'Can add bene transaction',21,'add_benetransaction');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (82,'Can change bene transaction',21,'change_benetransaction');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (83,'Can delete bene transaction',21,'delete_benetransaction');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (84,'Can view bene transaction',21,'view_benetransaction');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (85,'Can add picture',22,'add_picture');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (86,'Can change picture',22,'change_picture');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (87,'Can delete picture',22,'delete_picture');
insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (88,'Can view picture',22,'view_picture');

/*Table structure for table `auth_user` */

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$720000$VGQtht2Slv3cXCYfbhkuzv$ivVdeb7YCKH5SbBrOO5f0EmnSgvgPt8M1/tMLlBP/cw=','2025-03-05 04:14:53.669952',1,'admin','','','alden.roxy@gmail.com',1,1,'2025-03-02 06:06:33.040007');
insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (4,'pbkdf2_sha256$720000$vNDl5BpUDeeUhXPKOTOEVw$YZs3xBNn80I1i+hLaHzJ6UbLi/58LuYoyUsg8bHZk6w=','2025-03-07 05:13:15.613590',0,'user01','Alden','Quinones','user01@gmail.com',0,1,'2025-03-02 07:09:29.309544');
insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (7,'pbkdf2_sha256$600000$fF3LMk1n42Jrfg5kde3ida$AXq1mMw5LRtBUETWmTopgDn61ysnJroERe8rI/DrNgE=',NULL,0,'user02','','','user02@gmail.com',0,0,'2025-03-02 07:33:47.037666');

/*Table structure for table `auth_user_groups` */

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (1,'2025-03-02 07:02:45.262105','2','user1234',3,'',4,1);
insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (2,'2025-03-02 07:07:55.381417','3','user01',3,'',4,1);
insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (3,'2025-03-02 07:33:14.416799','5','user01',3,'',4,1);
insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (4,'2025-03-02 07:33:14.420355','6','user02',3,'',4,1);

/*Table structure for table `django_content_type` */

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (3,'auth','group');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (2,'auth','permission');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (4,'auth','user');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (5,'contenttypes','contenttype');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (20,'main_app','audittrail');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (10,'main_app','barangay');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (13,'main_app','beneficiary');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (19,'main_app','beneficiarychangelog');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (21,'main_app','benetransaction');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (7,'main_app','employeeprofile');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (16,'main_app','fundsource');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (17,'main_app','liquidation');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (8,'main_app','municipality');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (18,'main_app','obligation');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (15,'main_app','payroll');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (14,'main_app','payrolldetail');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (22,'main_app','picture');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (9,'main_app','position');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (12,'main_app','province');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (11,'main_app','region');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (6,'sessions','session');

/*Table structure for table `django_migrations` */

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2025-03-02 06:05:59.600728');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (2,'auth','0001_initial','2025-03-02 06:05:59.903994');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (3,'admin','0001_initial','2025-03-02 06:05:59.968360');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (4,'admin','0002_logentry_remove_auto_add','2025-03-02 06:05:59.968360');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (5,'admin','0003_logentry_add_action_flag_choices','2025-03-02 06:05:59.984143');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (6,'contenttypes','0002_remove_content_type_name','2025-03-02 06:06:00.031859');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (7,'auth','0002_alter_permission_name_max_length','2025-03-02 06:06:00.063851');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (8,'auth','0003_alter_user_email_max_length','2025-03-02 06:06:00.065828');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (9,'auth','0004_alter_user_username_opts','2025-03-02 06:06:00.095727');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (10,'auth','0005_alter_user_last_login_null','2025-03-02 06:06:00.119796');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (11,'auth','0006_require_contenttypes_0002','2025-03-02 06:06:00.119796');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (12,'auth','0007_alter_validators_add_error_messages','2025-03-02 06:06:00.128024');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (13,'auth','0008_alter_user_username_max_length','2025-03-02 06:06:00.143801');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (14,'auth','0009_alter_user_last_name_max_length','2025-03-02 06:06:00.143801');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (15,'auth','0010_alter_group_name_max_length','2025-03-02 06:06:00.172783');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (16,'auth','0011_update_proxy_permissions','2025-03-02 06:06:00.179261');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (17,'auth','0012_alter_user_first_name_max_length','2025-03-02 06:06:00.191600');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (18,'sessions','0001_initial','2025-03-02 06:06:00.213842');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (19,'main_app','0001_initial','2025-03-03 02:26:47.812634');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (20,'main_app','0002_remove_employeeprofile_code_and_more','2025-03-03 02:31:40.841256');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (21,'main_app','0003_province_region_barangay_municipality_province_and_more','2025-03-03 02:39:07.498434');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (22,'main_app','0004_alter_barangay_table','2025-03-03 02:39:51.471073');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (23,'main_app','0005_alter_barangay_code','2025-03-03 03:35:03.151738');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (24,'main_app','0006_alter_barangay_code_alter_barangay_name','2025-03-03 03:36:26.026851');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (25,'main_app','0007_employeeprofile_sex','2025-03-03 03:45:14.821055');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (26,'main_app','0008_beneficiary','2025-03-04 01:03:40.014158');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (27,'main_app','0009_beneficiary_address_psgc','2025-03-04 01:05:24.191721');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (28,'main_app','0010_payroll_payrolldetail','2025-03-04 01:09:30.508605');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (29,'main_app','0011_fundsource_alter_payroll_status_and_more','2025-03-04 01:14:36.710058');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (30,'main_app','0012_remove_beneficiary_age_beneficiary_biometric_fp_and_more','2025-03-04 01:30:35.269239');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (31,'main_app','0013_beneficiary_email_beneficiary_is_pantawid_and_more','2025-03-04 01:35:47.350710');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (32,'main_app','0014_alter_beneficiary_status','2025-03-04 06:31:54.168278');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (33,'main_app','0015_alter_beneficiary_status','2025-03-04 06:35:02.087760');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (34,'main_app','0016_alter_beneficiary_sex','2025-03-04 06:39:26.755280');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (35,'main_app','0017_beneficiary_last_updated_by_beneficiarychangelog','2025-03-05 02:29:41.064871');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (36,'main_app','0018_audittrail_delete_beneficiarychangelog','2025-03-05 02:34:34.756029');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (37,'main_app','0019_alter_audittrail_options_and_more','2025-03-05 03:09:52.441142');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (38,'main_app','0020_remove_beneficiary_date_registered','2025-03-05 07:09:23.740551');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (39,'main_app','0021_beneficiary_date_registered','2025-03-05 07:09:23.750553');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (40,'main_app','0022_beneficiary_encoded_by_and_more','2025-03-05 07:16:13.870622');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (41,'main_app','0023_rename_date_registered_beneficiary_date_recommended_and_more','2025-03-05 07:19:47.275049');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (42,'main_app','0024_beneficiary_approved_by_beneficiary_date_approved_and_more','2025-03-05 07:22:38.424176');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (43,'main_app','0025_beneficiary_certified_correct_by_and_more','2025-03-05 07:34:44.978798');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (44,'main_app','0026_rename_date_encoded_beneficiary_encoded_dt_and_more','2025-03-05 07:35:31.603583');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (45,'main_app','0027_rename_date_recommended_beneficiary_recommended_dt','2025-03-05 07:36:37.412430');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (46,'main_app','0028_rename_date_approved_beneficiary_approved_dt','2025-03-05 07:37:01.021505');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (47,'main_app','0029_rename_last_updated_beneficiary_last_updated_dt','2025-03-05 07:40:13.184255');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (48,'main_app','0030_remove_beneficiary_encoded_by_and_more','2025-03-05 08:44:27.746430');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (49,'main_app','0031_remove_beneficiary_validated_by_and_more','2025-03-05 08:45:16.679973');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (50,'main_app','0032_remove_beneficiary_approved_by_and_more','2025-03-05 08:47:17.986093');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (51,'main_app','0033_picture','2025-03-06 01:12:34.894992');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (52,'main_app','0034_remove_beneficiary_tras_approval_and_more','2025-03-06 07:08:26.017849');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (53,'main_app','0035_beneficiary_name_exit_and_more','2025-03-06 07:09:40.782861');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (54,'main_app','0036_delete_benetransaction','2025-03-06 07:10:36.649674');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (55,'main_app','0037_rename_name_barangay_barangay_and_more','2025-03-06 07:41:56.654774');
insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (56,'main_app','0038_rename_barangay_barangay_barangay_name_and_more','2025-03-06 07:58:17.132528');

/*Table structure for table `django_session` */

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('25aru9js41v3cc76npv19lzp8a1st1oy','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tqAZQ:GVACurm1bYIkIImOlUC15o48jZhQpfkKJKTb6-wPNOo','2025-03-07 12:43:24.531064');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('2z78zkh1y2tl0shb1g1s1dx3xic73q6z','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpeAy:71BccHv5lIOFVd1pJXPIL6253flThW5irNX09Qv5FcE','2025-03-05 02:38:00.449639');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('4ro07t34qfz77otp374wz0pctfjfmza6','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpzpR:ezpScqv2F30i679YHOGTWCZAzX2WwhdY9gAjZOFD_Zc','2025-03-07 01:15:13.182109');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('695mqcp6wbdool4i1r9jtzukn1mnn59l','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tp03d:p0nSpIJ3g3ltQEpp1JNelA6x9Og9MHy8u-HKQa-by0A','2025-03-03 07:47:45.998684');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('arxrqeoewc9m3q7pgsjo45yrlj9i5694','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpIgr:jqsmMmCAin0SlUXJJnn09OCjcEVij0lyrm4uPj7vJ-8','2025-03-04 03:41:29.260621');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('b4nriamfydd36oyxgye7rhguustch4vm','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpJAG:KH8cOtdAU5Wd3k5X-ErumxExC9O0XNgJGy1XfpyOAqk','2025-03-04 04:11:52.865076');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('c44o7fg9jdjqmyty3p2zurjsgv916bo8','.eJxVjMEOwiAQBf-FsyFQWASP3v0GsrAgVQNJaU_Gf5cmPej1zcx7M4_bWvzW0-JnYhcm2el3Cxifqe6AHljvjcdW12UOfFf4QTu_NUqv6-H-HRTsZdQmTjkDSBJyRA6NyNpomyhLykZpUkgEMLmI1sE5KYlhyEAyKeEssc8X-z44Ww:1tpg9l:oFk6GnYmxHehlffMGAtdqM0Vuicpchp-BaicHBN-ZNI','2025-03-05 04:44:53.675990');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('d838vf0filv806gss8e56u83t1xhhehn','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpLNV:g_JWQGXskfQmq0ErZYJcztuMQEv9-HiTA1yyGZ_BsOY','2025-03-04 06:33:41.360153');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('dvhlxfz5mh5eyesctbos68s6wne4k1nw','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tphhg:8RKL-yXye0BCwZl1gj2EXMr6Xc9z0rdqfiuad7QhEWk','2025-03-05 06:24:00.920629');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('gnpaj16ijlpj1uesjzzhbq7em5zjrd2o','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toyLB:xrfGa7yIfu4Efx_jwrQwAMx4y1ZhpR7cYwPJVHx60mg','2025-03-03 05:57:45.631810');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('hfrj42cskwx4qfspvf9uw1koiv5mczmn','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpGOG:VA5tYojesj9Ky5uXcw8NfpohpBNZhuhxqn3BbHcD9Hc','2025-03-04 01:14:08.785477');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('ifh6jdqw1bpigzw0igo5dbs770640f43','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tp0Xw:9dyN2McKswS-jhOd86QT-tqtL9xKwyaK0Zm0aAHjmkI','2025-03-03 08:19:04.332068');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('j3zahbd1ykitty481cuypxyaeulv4kkk','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tq5PH:EgvL83MvLZlv1I3-LYSu6g6mSKlWidIGDFGu2AJqPgs','2025-03-07 07:12:35.002052');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('lp98zj4ptbtp6na8tdh75ogvi21b2th7','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpgjb:6f6kGWqTwSOYcm3av3MVFGOfSSW9xVqlInzlowjVrv0','2025-03-05 05:21:55.213380');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('n045hddxli0am5o24wsilmlgnp5n2kau','e30:1toch5:H_ppj6XRg0_EopeBQp4wGxYd3mh5DZypmd8LdlYe2GQ','2025-03-16 06:20:55.882064');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('nt1rnx8ouzy0sgehr2qo7mz17u6btu8y','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tphDB:vTfz5tYLKfbjs1V-BL51aR7VyeDSV6RNeS0kyN7tNv4','2025-03-05 05:52:29.124213');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('pvxjlkz6cbzzv78gzbyoztvxi7v19nzz','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpiR9:zXqB-0fBLaLaRnIUnNF1S6p1E9G4h-cC5smG_Z9w1Ss','2025-03-06 06:40:59.712515');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('riffp63hp10ilrllymrrv07eq9xuq1lu','e30:1todSR:C77rdbaZTEswSTqbscPS4SrPyObSxPaYm_pvVmAVKYM','2025-03-02 07:39:51.225051');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('rrzs6u4082ic75lcc3besws2nk1zys88','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tqOFX:IIzG_g5Qh_uZUTELzAtyAY06zJ1kus1GNSQ_OoKyCjk','2025-03-08 03:19:47.719411');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('tl9n98ofpican2a442y3hk17mew4atd9','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tpKuO:bXHIJW1wcHJdy8zhyqXPtqtRtOVbFvtqmXKr5idlW7k','2025-03-04 06:03:36.302540');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('tm2ab916lfdhohz1i8aess5fw2ego6nw','e30:1todJs:pGbnEINh-sQuWN7IVrBa6UDyKqqGzvhFevgeqxvyspg','2025-03-02 07:31:00.006507');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('vnihjqfq6vpzjorxer63hya6vzkazke7','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toza7:yN0hIwtN8w3j76BbTzLOAMWnnwnzxJgt2AVnk-yLsE0','2025-03-03 07:17:15.240254');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('vskeioigsq8wbexxzr4qqhkcm901wgxo','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toxro:HsOwTDvlYv8FX2oYEbnlUTDWhF5kKhpY5VmelmMGlVw','2025-03-03 05:27:24.539320');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('wxkn089dyiks8e5f406yoyocadh1kqqg','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tqQ1L:7aBaLNFJX_CyadcCy7PbUnD51G5ZvI3RKC45qHinGIs','2025-03-08 05:13:15.615590');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('wzwi6jyd2ewr8jb810fo4wr3j1gaqrox','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toypc:_tVX0WDyITccTq2LOJgmfXhbCCphukDKQFiVmb4qR9Y','2025-03-03 06:29:12.487227');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('ybi7hxw7rzm3tsemgc5xp18sfifxghiu','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tq4SG:8Gn5yyi_IuT0vX9E_9LJKbAM2KXmfvpYIZJRSNDdHMU','2025-03-07 06:11:36.311362');

/*Table structure for table `tbl_barangay` */

CREATE TABLE `tbl_barangay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `barangay_name` varchar(255) NOT NULL,
  `brgy_code` varchar(20) NOT NULL,
  `municipality_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tbl_barangay_code_785652b0_uniq` (`brgy_code`),
  KEY `main_app_barangay_municipality_id_bb01e0da_fk_tbl_munic` (`municipality_id`),
  CONSTRAINT `main_app_barangay_municipality_id_bb01e0da_fk_tbl_munic` FOREIGN KEY (`municipality_id`) REFERENCES `tbl_municipality` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153617144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_barangay` */

insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701001,'BAO','124701001',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701002,'BARANGIRAN','124701002',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701003,'CAMANSI','124701003',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701004,'DADO','124701004',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701005,'GUILING','124701005',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701006,'KITACUBONG (POB.)','124701006',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701007,'MACABASA','124701007',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701008,'MALITUBOG','124701008',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701009,'MAPUROK','124701009',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701010,'PACAO','124701010',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701011,'PARUAYAN','124701011',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701012,'PIGCAWARAN','124701012',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701013,'POLAYAGAN','124701013',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701014,'RANGAYEN','124701014',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701015,'LOWER DADO','124701015',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701016,'MIRASOL','124701016',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124701017,'RARADANGAN','124701017',124701);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702001,'AROMAN','124702001',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702003,'BENTANGAN','124702003',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702005,'CADIIS','124702005',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702007,'GENERAL LUNA','124702007',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702008,'KATANAYANAN','124702008',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702010,'KIB-AYAO','124702010',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702011,'KIBENES','124702011',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702012,'KIBUGTONGAN','124702012',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702013,'KILALA','124702013',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702014,'KIMADZIL','124702014',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702015,'KITULAAN','124702015',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702016,'LANGOGAN','124702016',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702017,'LANOON','124702017',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702019,'LILIONGAN','124702019',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702020,'UGALINGAN (LUMAYONG)','124702020',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702021,'MACABENBAN','124702021',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702022,'MALAPAG','124702022',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702024,'MANARAPAN','124702024',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702025,'MANILI','124702025',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702027,'NASAPIAN','124702027',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702028,'PALANGGALAN','124702028',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702030,'PEBPOLOAN','124702030',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702032,'POBLACION','124702032',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702034,'RANZO','124702034',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702035,'TACUPAN','124702035',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702036,'TAMBAD','124702036',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702037,'TONGANON','124702037',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124702039,'TUPIG','124702039',124702);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703001,'ARINGAY','124703001',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703002,'BANGILAN','124703002',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703003,'BANNAWAG','124703003',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703004,'BULUAN','124703004',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703005,'CUYAPON','124703005',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703006,'DAGUPAN','124703006',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703007,'KATIDTUAN','124703007',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703008,'KAYAGA','124703008',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703009,'KILAGASAN','124703009',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703010,'MAGATOS','124703010',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703011,'MALAMOTE','124703011',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703012,'MALANDUAGUE','124703012',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703013,'NANGA-AN','124703013',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703014,'OSIAS','124703014',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703015,'PAATAN LOWER','124703015',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703016,'PAATAN UPPER','124703016',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703017,'PEDTAD','124703017',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703018,'PISAN','124703018',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703019,'POBLACION','124703019',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703020,'SALAPUNGAN','124703020',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703021,'SANGGADONG','124703021',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703022,'SIMBUHAY','124703022',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703023,'SIMONE','124703023',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124703024,'TAMPED','124703024',124703);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704001,'AMAS','124704001',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704002,'AMAZION','124704002',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704003,'BALABAG','124704003',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704004,'BALINDOG','124704004',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704005,'BENOLIGAN','124704005',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704006,'BERADA','124704006',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704007,'GAYOLA','124704007',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704008,'GINATILAN','124704008',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704009,'ILOMAVIS','124704009',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704010,'INDANGAN','124704010',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704011,'JUNCTION','124704011',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704012,'KALAISAN','124704012',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704013,'KALASUYAN','124704013',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704014,'KATIPUNAN','124704014',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704015,'LANAO','124704015',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704016,'LINANGCOB','124704016',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704017,'LUVIMIN','124704017',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704018,'MACABOLIG','124704018',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704020,'MALINAN','124704020',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704021,'MANONGOL','124704021',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704022,'MARBEL (EMBAC)','124704022',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704023,'MATEO','124704023',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704024,'MEOCHAO','124704024',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704025,'MUA-AN','124704025',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704026,'NEW BOHOL','124704026',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704027,'NUANGAN','124704027',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704028,'ONICA','124704028',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704029,'PACO','124704029',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704030,'PATADON (PATADON EAST)','124704030',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704031,'PEREZ','124704031',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704032,'POBLACION','124704032',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704033,'SAN ISIDRO','124704033',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704034,'SAN ROQUE','124704034',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704035,'SANTO NIÑO','124704035',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704036,'SIBAWAN','124704036',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704037,'SIKITAN','124704037',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704038,'SINGAO','124704038',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704039,'SUDAPIN','124704039',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704040,'SUMBAO','124704040',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124704041,'MAGSAYSAY','124704041',124704);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705001,'ABAGA','124705001',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705003,'BAGUER','124705003',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705004,'BARONGIS','124705004',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705005,'BATIOCAN','124705005',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705006,'CABARUYAN','124705006',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705007,'CABPANGI','124705007',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705010,'DEMAPACO','124705010',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705011,'GREBONA','124705011',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705013,'GUMAGA','124705013',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705014,'KAPAYAWI','124705014',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705015,'KILOYAO','124705015',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705017,'KITUBOD','124705017',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705019,'MALENGEN','124705019',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705023,'MONTAY','124705023',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705024,'NICA-AN','124705024',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705025,'PALAO','124705025',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705029,'POBLACION','124705029',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705032,'SINAPANGAN','124705032',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705033,'SINAWINGAN','124705033',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124705034,'ULAMIAN','124705034',124705);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706001,'ALIBAYON','124706001',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706005,'BAGUMBAYAN','124706005',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706006,'BANGKAL','124706006',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706007,'BANTAC','124706007',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706008,'BASAK','124706008',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706009,'BINAY','124706009',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706010,'BONGOLANON','124706010',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706014,'DATU CELO','124706014',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706015,'DEL PILAR','124706015',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706016,'DOLES','124706016',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706021,'GUBATAN','124706021',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706022,'ILIAN','124706022',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706023,'INAC','124706023',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706024,'KAMADA','124706024',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706026,'KAUSWAGAN','124706026',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706027,'KISANDAL','124706027',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706029,'MAGCAALAM','124706029',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706030,'MAHONGCOG','124706030',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706033,'MANOBO','124706033',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706037,'NOA','124706037',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706038,'OWAS','124706038',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706039,'PANGAO-AN','124706039',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706040,'POBLACION','124706040',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706042,'SALLAB','124706042',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706043,'TAGBAC','124706043',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706044,'TEMPORAN','124706044',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706048,'AMABEL','124706048',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706049,'BALETE','124706049',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706050,'DON PANACA','124706050',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706051,'IMAMALING','124706051',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706052,'KINARUM','124706052',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124706053,'MANOBISA','124706053',124706);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707001,'BATASAN','124707001',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707002,'BATO','124707002',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707003,'BIANGAN','124707003',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707004,'BUENA VIDA','124707004',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707005,'BUHAY','124707005',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707006,'BULAKANON','124707006',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707007,'CABILAO','124707007',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707008,'CONCEPCION','124707008',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707009,'DAGUPAN','124707009',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707010,'GARSIKA','124707010',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707011,'GUANGAN','124707011',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707012,'INDANGAN','124707012',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707013,'JOSE RIZAL','124707013',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707014,'KATIPUNAN II','124707014',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707015,'KAWAYANON','124707015',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707016,'KISANTE','124707016',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707017,'LEBOCE','124707017',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707018,'LIBERTAD','124707018',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707019,'LUAYON','124707019',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707020,'LUNA NORTE','124707020',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707021,'LUNA SUR','124707021',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707022,'MALABUAN','124707022',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707023,'MALASILA','124707023',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707024,'MALUNGON','124707024',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707025,'NEW BAGUIO','124707025',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707026,'NEW BULATUKAN','124707026',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707027,'NEW CEBU','124707027',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707028,'OLD BULATUKAN','124707028',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707029,'POBLACION','124707029',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707030,'RODERO','124707030',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707031,'SAGUING','124707031',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707032,'SAN VICENTE','124707032',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707033,'SANTA FELOMINA','124707033',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707034,'SANTO NIÑO','124707034',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707035,'SINKATULAN','124707035',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707036,'TALUNTALUNAN','124707036',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707037,'VILLAFLORES','124707037',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124707038,'NEW ISRAEL','124707038',124707);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708001,'NEW ALIMODIAN','124708001',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708003,'ARAKAN','124708003',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708004,'BANGBANG','124708004',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708005,'BATO','124708005',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708006,'CENTRAL MALAMOTE','124708006',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708007,'DALAPITAN','124708007',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708008,'ESTADO','124708008',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708009,'ILIAN','124708009',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708010,'KABULACAN','124708010',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708012,'KIBIA','124708012',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708013,'KIBUDOC','124708013',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708014,'KIDAMA','124708014',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708015,'KILADA','124708015',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708017,'LAMPAYAN','124708017',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708018,'LATAGAN','124708018',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708019,'LINAO','124708019',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708020,'LOWER MALAMOTE','124708020',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708025,'MANUBUAN','124708025',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708026,'MANUPAL','124708026',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708027,'MARBEL','124708027',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708028,'MINAMAING','124708028',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708029,'NATUTUNGAN','124708029',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708030,'NEW BUGASONG','124708030',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708031,'NEW PANDAN','124708031',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708033,'PATADON WEST','124708033',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708034,'POBLACION','124708034',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708035,'SALVACION','124708035',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708036,'SANTA MARIA','124708036',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708037,'SARAYAN','124708037',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708038,'TACULEN','124708038',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708039,'TAGURANAO','124708039',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708040,'TAMPED (TAMPAD)','124708040',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708041,'NEW ABRA','124708041',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124708042,'PINAMATON','124708042',124708);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709002,'AGRICULTURE','124709002',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709003,'ANONANG','124709003',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709004,'ARIZONA','124709004',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709005,'BAGUMBA','124709005',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709006,'BALIKI','124709006',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709007,'BITOKA','124709007',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709008,'BUAL NORTE','124709008',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709009,'BUAL SUR','124709009',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709010,'CENTRAL BULANAN','124709010',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709011,'DAMATULAN','124709011',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709012,'CENTRAL GLAD','124709012',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709013,'ILBOCEAN','124709013',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709014,'KADIGASAN','124709014',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709015,'KADINGILAN','124709015',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709016,'KAPINPILAN','124709016',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709017,'CENTRAL KATINGAWAN','124709017',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709018,'KIMAGANGO','124709018',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709019,'KUDARANGAN','124709019',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709020,'CENTRAL LABAS','124709020',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709021,'LAGUMBINGAN','124709021',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709022,'LOMOPOG','124709022',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709023,'LOWER GLAD','124709023',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709024,'LOWER KATINGAWAN','124709024',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709025,'MACASENDEG','124709025',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709026,'MALAMOTE','124709026',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709027,'MALINGAO','124709027',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709028,'MILAYA','124709028',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709029,'MUDSENG','124709029',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709030,'NABALAWAG','124709030',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709031,'NALIN','124709031',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709032,'NES','124709032',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709033,'OLANDANG','124709033',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709034,'PATINDEGUEN','124709034',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709035,'BARANGAY POBLACION 1','124709035',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709036,'BARANGAY POBLACION 2','124709036',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709037,'BARANGAY POBLACION 3','124709037',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709038,'BARANGAY POBLACION 4','124709038',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709039,'BARANGAY POBLACION 5','124709039',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709040,'BARANGAY POBLACION 6','124709040',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709041,'BARANGAY POBLACION 7','124709041',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709042,'BARANGAY POBLACION 8','124709042',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709043,'PALONGOGUEN','124709043',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709044,'RANGABAN','124709044',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709045,'SADAAN','124709045',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709046,'SALUNAYAN','124709046',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709047,'SAMBULAWAN','124709047',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709048,'SAN ISIDRO','124709048',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709049,'SANTA CRUZ','124709049',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709050,'TUGAL','124709050',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709051,'TUMBRAS','124709051',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709052,'BULANAN UPPER','124709052',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709053,'UPPER GLAD I','124709053',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709054,'UPPER GLAD II','124709054',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709055,'UPPER LABAS','124709055',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709056,'VILLARICA','124709056',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709057,'KIWANAN','124709057',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124709058,'SAN PEDRO','124709058',124709);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710001,'BAGONTAPAY','124710001',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710002,'BIALONG','124710002',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710003,'BUAYAN','124710003',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710004,'CALUNASAN','124710004',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710005,'DALIPE','124710005',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710006,'DAGONG','124710006',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710007,'DUNGO-AN','124710007',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710008,'GAUNAN','124710008',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710009,'INAS','124710009',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710010,'KATIPUNAN','124710010',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710011,'LA FORTUNA','124710011',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710012,'LA SUERTE','124710012',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710013,'LANGKONG','124710013',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710014,'LEPAGA','124710014',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710015,'LIBOO','124710015',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710016,'LIKA','124710016',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710018,'MAGALLON','124710018',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710019,'MALAYAN','124710019',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710020,'NEW ANTIQUE','124710020',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710021,'NEW BARBAZA','124710021',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710022,'NEW KALIBO','124710022',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710024,'NEW CONSOLACION','124710024',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710025,'NEW ESPERANZA','124710025',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710026,'NEW JANIUAY','124710026',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710027,'NEW LAWA-AN','124710027',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710028,'NEW RIZAL','124710028',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710029,'NUEVA VIDA','124710029',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710030,'PAG-ASA','124710030',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710031,'POBLACION','124710031',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710032,'PULANG-LUPA','124710032',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710033,'SANGAT','124710033',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710034,'TAWANTAWAN','124710034',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710035,'TIBAO','124710035',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710036,'UGPAY','124710036',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710037,'PALMA-PEREZ','124710037',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124710038,'POBLACION B','124710038',124710);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711001,'ANICK (UPPER BALOGO)','124711001',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711002,'UPPER BAGUER (BAGUER)','124711002',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711003,'BALACAYON','124711003',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711004,'BALOGO','124711004',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711006,'BANUCAGON','124711006',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711007,'BULUCAON','124711007',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711008,'BULUAN','124711008',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711009,'BURICAIN','124711009',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711010,'CAPAYURAN','124711010',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711011,'CENTRAL PANATAN','124711011',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711012,'DATU BINASING','124711012',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711013,'DATU MANTIL','124711013',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711014,'KADINGILAN','124711014',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711015,'KIMARAYANG','124711015',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711016,'LIBUNGAN TORRETA','124711016',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711017,'LOWER BAGUER','124711017',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711018,'LOWER PANGANGKALAN','124711018',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711019,'MALAGAKIT','124711019',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711020,'MALUAO','124711020',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711021,'NORTH MANUANGAN','124711021',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711022,'MATILAC','124711022',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711023,'MIDPAPAN I','124711023',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711024,'MULOK','124711024',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711025,'NEW CULASI','124711025',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711026,'NEW IGBARAS','124711026',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711027,'NEW PANAY','124711027',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711028,'UPPER PANGANGKALAN','124711028',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711029,'PATOT','124711029',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711030,'PAYONG-PAYONG','124711030',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711031,'POBLACION I','124711031',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711032,'POBLACION II','124711032',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711033,'POBLACION III','124711033',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711034,'PRESBITERO','124711034',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711035,'RENIBON','124711035',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711036,'SIMSIMAN','124711036',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711037,'SOUTH MANUANGAN','124711037',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711038,'TIGBAWAN','124711038',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711039,'TUBON','124711039',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711040,'MIDPAPAN II','124711040',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124711041,'CABPANGI','124711041',124711);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712001,'BAGOAINGUD (BAGOINGED)','124712001',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712003,'BALABAK','124712003',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712004,'BALATICAN','124712004',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712005,'BALONG','124712005',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712006,'BALUNGIS','124712006',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712007,'BARUNGIS','124712007',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712008,'BATULAWAN','124712008',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712009,'BUALAN','124712009',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712010,'BULIOK','124712010',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712011,'BULOD','124712011',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712012,'BULOL','124712012',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712013,'CALAWAG','124712013',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712015,'DALINGAOEN (LALINGAON)','124712015',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712016,'DAMALASAK','124712016',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712019,'FORT PIKIT','124712019',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712020,'GINATILAN','124712020',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712021,'GLIGLI','124712021',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712022,'GOKOTON (GOKOTAN)','124712022',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712023,'INUG-UG','124712023',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712024,'KABASALAN','124712024',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712025,'KALACACAN','124712025',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712026,'KATILACAN','124712026',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712028,'KOLAMBOG','124712028',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712029,'LADTINGAN','124712029',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712030,'LAGUNDE','124712030',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712031,'LANGAYEN','124712031',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712034,'MACABUAL','124712034',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712035,'MACASENDEG','124712035',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712037,'MANAULANAN','124712037',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712040,'NABUNDAS','124712040',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712041,'NALAPAAN','124712041',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712044,'NUNGUAN','124712044',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712046,'PAIDU PULANGI','124712046',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712048,'PANICUPAN','124712048',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712050,'POBLACION','124712050',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712051,'PUNOL','124712051',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712052,'RAJAH MUDA','124712052',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712055,'SILIK','124712055',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712056,'TAKIPAN','124712056',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712057,'TALITAY','124712057',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712060,'TINUTULAN','124712060',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124712062,'PAMALIAN','124712062',124712);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713001,'ALEGRIA','124713001',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713002,'BATO-BATO','124713002',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713003,'DEL CARMEN','124713003',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713005,'F. CAJELO (NEW MAASIN)','124713005',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713006,'IDAOMAN','124713006',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713007,'ILUSTRE','124713007',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713008,'KAMARAHAN','124713008',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713009,'CAMASI','124713009',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713011,'KISUPAAN','124713011',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713012,'LA ESPERANZA','124713012',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713013,'LABU-O','124713013',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713014,'LAMALAMA','124713014',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713016,'LOMONAY','124713016',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713022,'NEW CEBU','124713022',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713024,'POBLACION','124713024',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713026,'SAGCUNGAN','124713026',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713027,'SALAT','124713027',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713028,'SARAYAN','124713028',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713029,'TUAEL','124713029',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713030,'GREENHILL','124713030',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713031,'CABANGBANGAN','124713031',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713032,'DATU INDANG','124713032',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713033,'DATU SANDONGAN','124713033',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713034,'KIMARUHING','124713034',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124713035,'MABUHAY','124713035',124713);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714001,'BAGUMBAYAN','124714001',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714002,'BANAYAL','124714002',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714003,'BATANG','124714003',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714004,'BITUAN','124714004',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714005,'BUAL','124714005',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714006,'DAIG','124714006',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714007,'DAMAWATO','124714007',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714008,'DUNGOS','124714008',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714009,'KANIBONG','124714009',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714010,'LA ESPERANZA','124714010',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714011,'LAMPAGANG','124714011',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714012,'BUNAWAN','124714012',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714013,'MAGBOK','124714013',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714014,'MAYBULA','124714014',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714015,'MINAPAN','124714015',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714016,'NEW CARIDAD','124714016',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714017,'NEW CULASI','124714017',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714018,'NEW PANAY','124714018',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714019,'PARAISO','124714019',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714020,'POBLACION','124714020',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714021,'POPOYON','124714021',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714022,'SIBSIB','124714022',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714023,'TAMBAC','124714023',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714024,'TUBURAN','124714024',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714026,'F. CAJELO','124714026',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714027,'BACONG','124714027',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714028,'GALIDAN','124714028',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714029,'GENOVEVA BAYNOSA','124714029',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124714030,'NABUNDASAN','124714030',124714);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715001,'CAMUTAN','124715001',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715002,'CANAAN','124715002',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715003,'DOLORES','124715003',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715004,'KIYAAB','124715004',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715005,'LUHONG','124715005',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715006,'MAGSAYSAY','124715006',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715007,'MALANGAG','124715007',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715008,'MALATAD','124715008',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715009,'MALIRE','124715009',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715010,'NEW PONTEVEDRA','124715010',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715011,'POBLACION','124715011',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715012,'B. CADUNGON','124715012',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124715013,'DATU AGOD','124715013',124715);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716001,'BANISILAN POBLACION','124716001',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716002,'BUSAON','124716002',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716003,'CAPAYANGAN','124716003',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716004,'CARUGMANAN','124716004',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716005,'GASTAY','124716005',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716006,'KALAWAIG','124716006',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716007,'KIARING','124716007',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716008,'MALAGAP','124716008',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716009,'MALINAO','124716009',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716010,'MIGUEL MACASARTE','124716010',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716011,'PANTAR','124716011',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716012,'PARADISE','124716012',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716013,'PINAMULAAN','124716013',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716014,'POBLACION II','124716014',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716015,'PUTING-BATO','124716015',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716016,'SOLAMA','124716016',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716017,'THAILAND','124716017',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716018,'TINIMBACAN','124716018',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716019,'TUMBAO-CAMALIG','124716019',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124716020,'WADYA','124716020',124716);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717001,'BAGOLIBAS','124717001',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717002,'CAWILIHAN','124717002',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717003,'DUALING','124717003',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717004,'DUNGUAN','124717004',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717005,'KATALICANAN','124717005',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717006,'LAWILI','124717006',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717007,'LOWER MINGADING','124717007',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717008,'LUANAN','124717008',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717009,'MALAPANG','124717009',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717010,'NEW LEON','124717010',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717011,'NEW PANAY','124717011',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717012,'PAGANGAN','124717012',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717013,'PALACAT','124717013',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717014,'PENTIL','124717014',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717015,'SAN MATEO','124717015',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717016,'SANTA CRUZ','124717016',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717017,'TAPODOC','124717017',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717018,'TOMADO','124717018',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124717019,'UPPER MINGADING','124717019',124717);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718001,'ALLAB','124718001',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718002,'ANAPOLON','124718002',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718003,'BADIANGON','124718003',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718004,'BINOONGAN','124718004',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718005,'DALLAG','124718005',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718006,'DATU LADAYON','124718006',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718007,'DATU MATANGKIL','124718007',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718008,'DOROLUMAN','124718008',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718009,'GAMBODES','124718009',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718010,'GANATAN','124718010',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718011,'GREENFIELD','124718011',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718012,'KABALANTIAN','124718012',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718013,'KATIPUNAN','124718013',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718014,'KINAWAYAN','124718014',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718015,'KULAMAN VALLEY','124718015',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718016,'LANAO KURAN','124718016',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718017,'LIBERTAD','124718017',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718018,'MAKALANGOT','124718018',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718019,'MALIBATUAN','124718019',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718020,'MARIA CARIDAD','124718020',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718021,'MEOCAN','124718021',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718022,'NAJE','124718022',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718023,'NAPALICO','124718023',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718024,'SALASANG','124718024',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718025,'SAN MIGUEL','124718025',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718026,'SANTO NIÑO','124718026',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718027,'SUMALILI','124718027',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (124718028,'TUMANDING','124718028',124718);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302002,'BENITEZ (POB.)','126302002',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302003,'CABUDIAN','126302003',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302004,'CABULING','126302004',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302005,'CINCO (BARRIO 5)','126302005',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302006,'DERILON','126302006',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302007,'EL NONOK','126302007',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302008,'IMPROGO VILLAGE (POB.)','126302008',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302009,'KUSAN (BARRIO 8)','126302009',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302010,'LAM-APOS','126302010',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302011,'LAMBA','126302011',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302012,'LAMBINGI','126302012',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302013,'LAMPARI','126302013',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302014,'LIWANAY (BARRIO 1)','126302014',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302015,'MALAYA (BARRIO 9)','126302015',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302016,'PUNONG GRANDE (BARRIO 2)','126302016',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302017,'RANG-AY (BARRIO 4)','126302017',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302018,'REYES (POB.)','126302018',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302019,'RIZAL (BARRIO 3)','126302019',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302020,'RIZAL POBLACION','126302020',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302021,'SAN JOSE (BARRIO 7)','126302021',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302022,'SAN VICENTE (BARRIO 6)','126302022',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126302024,'YANGCO POBLACION','126302024',126302);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303003,'BALUAN','126303003',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303004,'BUAYAN','126303004',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303005,'BULA','126303005',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303006,'CONEL','126303006',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303007,'DADIANGAS EAST (POB.)','126303007',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303009,'KATANGAWAN','126303009',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303011,'LAGAO (1ST & 3RD)','126303011',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303012,'LABANGAL','126303012',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303015,'LIGAYA','126303015',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303016,'MABUHAY','126303016',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303023,'SAN ISIDRO (LAGAO 2ND)','126303023',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303024,'SAN JOSE','126303024',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303026,'SINAWAL','126303026',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303027,'TAMBLER','126303027',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303028,'TINAGACAN','126303028',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303029,'APOPONG','126303029',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303030,'SIGUEL (BAWING)','126303030',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303031,'UPPER LABAY','126303031',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303032,'BATOMELONG','126303032',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303033,'CALUMPANG','126303033',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303034,'CITY HEIGHTS','126303034',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303035,'DADIANGAS NORTH','126303035',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303036,'DADIANGAS SOUTH','126303036',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303037,'DADIANGAS WEST','126303037',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303038,'FATIMA','126303038',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126303039,'OLYMPOG','126303039',126303);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306001,'ASSUMPTION (BULOL)','126306001',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306003,'CACUB','126306003',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306005,'CARPENTER HILL','126306005',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306006,'CONCEPCION (BO. 6)','126306006',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306007,'ESPERANZA','126306007',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306008,'GENERAL PAULINO SANTOS (BO. 1)','126306008',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306009,'MABINI','126306009',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306010,'MAGSAYSAY','126306010',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306011,'MAMBUCAL','126306011',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306012,'MORALES','126306012',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306013,'NAMNAMA','126306013',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306014,'NEW PANGASINAN (BO. 4)','126306014',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306015,'PARAISO','126306015',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306016,'ZONE I (POB.)','126306016',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306017,'ZONE II (POB.)','126306017',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306018,'ZONE III (POB.)','126306018',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306019,'ZONE IV (POB.)','126306019',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306020,'ROTONDA','126306020',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306021,'SAN ISIDRO','126306021',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306022,'SAN JOSE (BO. 5)','126306022',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306023,'SAN ROQUE','126306023',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306024,'SANTA CRUZ','126306024',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306025,'SANTO NIÑO (BO. 2)','126306025',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306026,'SARABIA (BO. 8)','126306026',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126306027,'ZULUETA (BO. 7)','126306027',126306);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311002,'DUMAGUIL','126311002',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311003,'ESPERANZA','126311003',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311006,'KIBID','126311006',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311007,'LAPUZ','126311007',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311008,'LIBERTY','126311008',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311009,'LOPEZ JAENA','126311009',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311011,'MATAPOL','126311011',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311013,'POBLACION','126311013',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311014,'PUTI','126311014',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311016,'SAN JOSE','126311016',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311017,'SAN MIGUEL','126311017',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311020,'SIMSIMAN','126311020',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311021,'TINAGO','126311021',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126311022,'BENIGNO AQUINO, JR.','126311022',126311);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312001,'BENTUNG','126312001',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312002,'CROSSING PALKAN','126312002',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312003,'GLAMANG','126312003',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312004,'KINILIS','126312004',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312005,'KLINAN 6','126312005',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312006,'KORONADAL PROPER','126312006',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312007,'LAM-CALIAF','126312007',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312008,'LANDAN','126312008',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312009,'LUMAKIL','126312009',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312011,'MALIGO','126312011',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312013,'PALKAN','126312013',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312014,'POBLACION','126312014',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312015,'POLO','126312015',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312016,'MAGSAYSAY','126312016',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312017,'RUBBER','126312017',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312018,'SILWAY 7','126312018',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312019,'SILWAY 8','126312019',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312020,'SULIT','126312020',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312021,'SUMBAKIL','126312021',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312022,'UPPER KLINAN','126312022',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312023,'LAPU','126312023',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312024,'CANNERY SITE','126312024',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126312025,'PAGALUNGAN','126312025',126312);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313002,'BUENAVISTA','126313002',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313003,'CENTRALA','126313003',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313004,'COLONGULO','126313004',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313005,'DAJAY','126313005',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313006,'DUENGAS','126313006',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313008,'CANAHAY (GODWINO)','126313008',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313014,'LAMBONTONG','126313014',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313017,'LAMIAN','126313017',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313018,'LAMSUGOD','126313018',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313019,'LIBERTAD (POB.)','126313019',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313020,'LITTLE BAGUIO','126313020',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313023,'MOLOY','126313023',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313024,'NACI (DOCE)','126313024',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313028,'TALAHIK','126313028',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313030,'TUBIALA','126313030',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313031,'UPPER SEPAKA','126313031',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126313032,'VETERANS','126313032',126313);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314001,'ALBAGAN','126314001',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314002,'KIPALBIG','126314002',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314003,'LAMBAYONG','126314003',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314004,'LIBERTY','126314004',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314005,'MALTANA','126314005',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314006,'POBLACION','126314006',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314007,'TABLU','126314007',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314008,'BUTO','126314008',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314009,'LAMPITAK','126314009',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314010,'PALO','126314010',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314011,'PULA-BATO','126314011',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314012,'DANLAG','126314012',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314013,'SAN ISIDRO','126314013',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126314014,'SANTA CRUZ','126314014',126314);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315001,'BUKAY PAIT','126315001',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315002,'CABULING','126315002',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315003,'DUMADALIG','126315003',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315004,'LIBAS','126315004',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315005,'MAGON','126315005',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315006,'MAIBO','126315006',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315007,'MANGILALA','126315007',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315008,'NEW ILOILO','126315008',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315009,'NEW LAMBUNAO','126315009',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315010,'POBLACION','126315010',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315011,'SAN FELIPE','126315011',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315012,'NEW CUYAPO','126315012',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126315013,'TINONGCOP','126315013',126315);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316001,'BASAG','126316001',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316002,'EDWARDS (POB.)','126316002',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316004,'KEMATU','126316004',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316005,'LACONON','126316005',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316008,'LAMSALOME','126316008',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316011,'NEW DUMANGAS','126316011',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316012,'SINOLON','126316012',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316014,'LAMBANGAN','126316014',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316016,'MAAN','126316016',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316017,'AFUS','126316017',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316018,'LAMBULING','126316018',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316019,'LAMHAKO','126316019',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316020,'POBLACION','126316020',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316021,'TALCON','126316021',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316022,'TALUFO','126316022',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316023,'TUDOK','126316023',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316024,'AFLEK','126316024',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316025,'DATAL BOB','126316025',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316026,'DESAWO','126316026',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316027,'DLANAG','126316027',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316028,'LEMSNOLON','126316028',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316029,'MALUGONG','126316029',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316030,'MONGOCAYO','126316030',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316031,'SALACAFE','126316031',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126316032,'T\'BOLOK','126316032',126316);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317001,'ACMONAN','126317001',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317002,'BOLOLMALA','126317002',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317003,'BUNAO','126317003',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317004,'CEBUANO','126317004',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317005,'CROSSING RUBBER','126317005',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317006,'KABLON','126317006',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317007,'KALKAM','126317007',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317009,'LINAN','126317009',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317010,'LUNEN','126317010',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317011,'MIASONG','126317011',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317012,'PALIAN','126317012',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317013,'POBLACION','126317013',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317014,'POLONULING','126317014',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317015,'SIMBO','126317015',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126317016,'TUBENG','126317016',126317);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318001,'Ambalgan','126318001',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318002,'Guinsang-an','126318002',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318003,'Katipunan','126318003',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318004,'Manuel Roxas','126318004',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318005,'Panay','126318005',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318006,'Poblacion','126318006',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318007,'San Isidro','126318007',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318008,'San Vicente','126318008',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318009,'Teresita','126318009',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126318010,'Sajaneba','126318010',126318);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319001,'BACDULONG','126319001',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319002,'DENLAG','126319002',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319003,'HALILAN','126319003',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319004,'HANOON','126319004',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319005,'KLUBI','126319005',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319006,'LAKE LAHIT','126319006',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319007,'LAMCADE','126319007',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319008,'LAMDALAG','126319008',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319009,'LAMFUGON','126319009',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319010,'LAMLAHAK','126319010',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319011,'LOWER MACULAN','126319011',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319012,'LUHIB','126319012',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319013,'NED','126319013',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319014,'POBLACION','126319014',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319015,'SILUTON','126319015',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319016,'TALISAY','126319016',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319017,'TAKUNEL','126319017',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319018,'UPPER MACULAN','126319018',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126319019,'TASIMAN','126319019',126319);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501001,'BAI SARIFINANG','126501001',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501002,'BIWANG','126501002',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501003,'BUSOK','126501003',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501004,'DAGUMA','126501004',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501005,'KAPAYA','126501005',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501006,'KINAYAO','126501006',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501008,'MASIAG','126501008',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501009,'POBLACION','126501009',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501010,'SOUTH SEPAKA','126501010',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501011,'TUKA','126501011',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501012,'CHUA','126501012',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501013,'DALUGA','126501013',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501014,'KABULANAN','126501014',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501015,'KANULAY','126501015',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501016,'MONTEVERDE','126501016',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501017,'SANTO NIÑO','126501017',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501018,'SUMILIL','126501018',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501019,'TITULOK','126501019',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126501020,'SISON','126501020',126501);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502002,'BANTANGAN (LASAK)','126502002',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502009,'DATABLAO','126502009',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502010,'EDAY','126502010',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502011,'ELBEBE','126502011',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502015,'LIBERTAD','126502015',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502016,'LOMOYON','126502016',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502017,'MAKAT (SUMALI PAS)','126502017',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502019,'MALIGAYA','126502019',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502021,'MAYO','126502021',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502022,'NATIVIDAD','126502022',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502023,'POBLACION','126502023',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502024,'POLOMOLOK','126502024',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502027,'SINAPULAN','126502027',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502028,'SUCOB','126502028',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502030,'TELAFAS','126502030',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126502032,'LASAK','126502032',126502);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503001,'ALA','126503001',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503003,'DALADAP','126503003',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503005,'DUKAY','126503005',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503007,'GUIAMALIA','126503007',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503008,'ILIAN','126503008',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503011,'KANGKONG','126503011',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503016,'MARGUES','126503016',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503018,'NEW PANAY','126503018',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503020,'NUMO','126503020',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503021,'PAMANTINGAN','126503021',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503022,'POBLACION','126503022',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503023,'SAGASA','126503023',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503024,'SALABACA','126503024',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503032,'VILLAMOR','126503032',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503033,'LAGUINDING','126503033',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503034,'MAGSAYSAY','126503034',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503035,'PAITAN','126503035',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503036,'SALIAO','126503036',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126503037,'SALUMPING','126503037',126503);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504003,'BAMBAD','126504003',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504005,'BUAL','126504005',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504007,'D\'LOTILLA','126504007',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504009,'DANSULI','126504009',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504010,'IMPAO','126504010',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504011,'KALAWAG I (POB.)','126504011',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504012,'KALAWAG II (POB.)','126504012',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504013,'KALAWAG III (POB.)','126504013',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504016,'KENRAM','126504016',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504018,'KUDANDING','126504018',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504019,'KOLAMBOG','126504019',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504020,'LAGANDANG','126504020',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504021,'LAGUILAYAN','126504021',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504022,'MAPANTIG','126504022',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504024,'NEW PANGASINAN','126504024',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504026,'SAMPAO','126504026',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126504028,'TAYUGO','126504028',126504);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505001,'BANTOGON (SANTA CLARA)','126505001',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505004,'CADIZ','126505004',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505006,'DUMANGAS NUEVO','126505006',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505007,'HINALAAN','126505007',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505011,'LIMULAN','126505011',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505013,'OBIAL','126505013',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505014,'PARIL','126505014',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505015,'POBLACION','126505015',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505016,'SANGAY','126505016',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505017,'SANTA MARIA','126505017',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505018,'DATU ITO ANDONG','126505018',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505019,'DATU WASAY','126505019',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505020,'NALILIDAN','126505020',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505021,'SABANAL','126505021',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126505022,'PAG-ASA','126505022',126505);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506001,'BARURAO','126506001',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506003,'BASAK','126506003',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506004,'BULULAWAN','126506004',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506005,'CAPILAN','126506005',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506006,'CHRISTIANNUEVO','126506006',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506007,'DATU KARON','126506007',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506008,'KALAMONGOG','126506008',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506009,'KEYTODAC','126506009',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506010,'KINODALAN','126506010',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506012,'NEW CALINOG','126506012',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506013,'NULING','126506013',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506014,'PANSUD','126506014',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506015,'PASANDALAN','126506015',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506016,'POBLACION','126506016',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506017,'POLOY-POLOY','126506017',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506018,'PURIKAY','126506018',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506019,'RAGANDANG','126506019',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506020,'SALAMAN','126506020',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506021,'SALANGSANG','126506021',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506022,'TAGUISA','126506022',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506023,'TIBPUAN','126506023',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506024,'TRAN','126506024',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506025,'VILLAMONTE','126506025',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506026,'BARURAO II','126506026',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506027,'AURELIO F. FREIRES (POBLACION II)','126506027',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506028,'POBLACION III','126506028',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126506029,'BOLEBOK','126506029',126506);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507001,'ANTONG','126507001',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507002,'BAYASONG','126507002',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507003,'BLINGKONG','126507003',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507004,'LUTAYAN PROPER','126507004',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507005,'MAINDANG','126507005',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507006,'MAMALI','126507006',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507007,'MANILI','126507007',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507008,'SAMPAO','126507008',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507009,'SISIMAN','126507009',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507010,'TAMNAG (POB.)','126507010',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126507011,'PALAVILLA','126507011',126507);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508001,'CARIDAD (CUYAPON)','126508001',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508002,'DIDTARAS','126508002',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508004,'GANSING (BILUMEN)','126508004',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508005,'KABULAKAN','126508005',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508006,'KAPINGKONG','126508006',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508007,'KATITISAN','126508007',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508008,'LAGAO','126508008',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508009,'LILIT','126508009',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508010,'MADANDING','126508010',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508011,'MALIGAYA','126508011',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508012,'MAMALI','126508012',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508013,'MATIOMPONG','126508013',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508014,'MIDTAPOK','126508014',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508015,'NEW CEBU','126508015',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508016,'PALUMBI','126508016',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508017,'PIDTIGUIAN','126508017',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508018,'PIMBALAYAN','126508018',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508019,'PINGUIAMAN','126508019',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508020,'POBLACION (LAMBAYONG)','126508020',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508021,'SADSALAN','126508021',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508022,'SENEBEN','126508022',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508023,'SIGAYAN','126508023',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508024,'TAMBAK','126508024',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508025,'TINUMIGUES','126508025',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508027,'TUMIAO (TINAGA)','126508027',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126508028,'UDTONG','126508028',126508);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509001,'AKOL','126509001',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509002,'BADIANGON','126509002',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509003,'BALIANGO','126509003',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509004,'BARANAYAN','126509004',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509005,'BARONGIS','126509005',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509006,'BATANG-BAGLAS','126509006',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509007,'BUTRIL','126509007',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509009,'DOMOLOL','126509009',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509010,'KABULING','126509010',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509011,'KALIBUHAN','126509011',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509013,'KANIPAAN','126509013',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509014,'KISEK','126509014',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509015,'KIDAYAN','126509015',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509016,'KIPONGET','126509016',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509017,'KULONG-KULONG','126509017',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509018,'KRAAN','126509018',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509020,'LANGALI','126509020',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509021,'LIBUA','126509021',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509022,'LUMITAN','126509022',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509023,'MAGANAO','126509023',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509024,'MAGUID','126509024',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509025,'MALATUNENG (MALATUNOL)','126509025',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509026,'MALISBONG','126509026',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509027,'MILBUK','126509027',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509028,'MOLON','126509028',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509029,'NAMAT MASLA','126509029',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509030,'NAPNAPON','126509030',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509031,'POBLACION','126509031',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509032,'SAN ROQUE','126509032',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509033,'COLOBE (TAGADTAL)','126509033',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509034,'TIBUHOL (EAST BADIANGON)','126509034',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509035,'WAL','126509035',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509036,'BAMBANEN','126509036',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509038,'LOPOKEN (LEPOLON)','126509038',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509039,'MINA','126509039',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509040,'MEDOL','126509040',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509041,'WASAG','126509041',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509042,'BALWAN (BULAN)','126509042',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509043,'LIGAO','126509043',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126509044,'DATU MAGUIALES','126509044',126509);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510001,'BAGUMBAYAN','126510001',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510003,'BANNAWAG','126510003',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510004,'BAYAWA','126510004',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510005,'ESTRELLA','126510005',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510007,'KALANAWE I','126510007',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510008,'KALANAWE II','126510008',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510009,'KATICO','126510009',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510012,'MALINGON','126510012',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510013,'MANGALEN','126510013',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510014,'C. MANGILALA','126510014',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510015,'PEDTUBO','126510015',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510016,'POBLACION (SAMBULAWAN)','126510016',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510018,'ROMUALDEZ','126510018',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510020,'SAN JOSE','126510020',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510021,'SINAKULAY','126510021',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510022,'SUBEN','126510022',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510023,'TINAUNGAN','126510023',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510025,'TUAL (LIGUASAN)','126510025',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126510026,'SAN PEDRO (TUATO)','126510026',126510);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511001,'BARAS','126511001',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511002,'BUENAFLOR','126511002',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511003,'CALEAN','126511003',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511004,'CARMEN','126511004',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511005,'D\'LEDESMA','126511005',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511006,'GANSING','126511006',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511007,'KALANDAGAN','126511007',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511008,'LOWER KATUNGAL (E. J. C. Montilla)','126511008',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511010,'NEW ISABELA','126511010',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511011,'NEW LAGAO','126511011',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511012,'NEW PASSI','126511012',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511013,'POBLACION','126511013',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511014,'RAJAH NUDA','126511014',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511015,'SAN ANTONIO','126511015',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511016,'SAN EMMANUEL','126511016',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511019,'SAN PABLO','126511019',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511020,'UPPER KATUNGAL','126511020',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511021,'TINA','126511021',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511022,'SAN RAFAEL','126511022',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126511023,'LANCHETA','126511023',126511);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512001,'BANALI','126512001',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512002,'BASAG','126512002',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512003,'BUENAFLORES','126512003',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512004,'BUGSO','126512004',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512005,'BUKLOD','126512005',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512006,'GAPOK','126512006',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512007,'KADI','126512007',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512008,'KAPATAGAN','126512008',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512009,'KIADSAM','126512009',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512010,'KUDEN','126512010',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512011,'KULAMAN','126512011',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512012,'LAGUBANG','126512012',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512013,'LANGGAL','126512013',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512014,'LIMUHAY','126512014',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512015,'MALEGDEG','126512015',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512016,'MIDTUNGOK','126512016',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512017,'NATI','126512017',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512018,'SEWOD','126512018',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512019,'TACUPIS','126512019',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (126512020,'TINALON','126512020',126512);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001001,'ALEGRIA','128001001',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001002,'BAGACAY','128001002',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001003,'BALUNTAY','128001003',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001004,'DATAL ANGGAS','128001004',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001005,'DOMOLOK','128001005',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001006,'KAWAS','128001006',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001007,'MARIBULAN','128001007',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001008,'PAG-ASA','128001008',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001009,'PARAISO','128001009',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001010,'POBLACION (ALABEL)','128001010',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001011,'SPRING','128001011',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001012,'TOKAWAL','128001012',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128001013,'LADOL','128001013',128001);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002001,'BALITON','128002001',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002002,'BATOTULING','128002002',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002003,'BATULAKI','128002003',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002004,'BIG MARGUS','128002004',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002005,'BURIAS','128002005',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002006,'CABLALAN','128002006',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002007,'CALABANIT','128002007',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002008,'CALPIDONG','128002008',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002009,'CONGAN','128002009',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002010,'CROSS','128002010',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002011,'DATALBUKAY','128002011',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002012,'E. ALEGADO','128002012',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002013,'GLAN PADIDU','128002013',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002014,'GUMASA','128002014',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002015,'ILAYA','128002015',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002016,'KALTUAD','128002016',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002017,'KAPATAN','128002017',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002018,'LAGO','128002018',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002019,'LAGUIMIT','128002019',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002020,'MUDAN','128002020',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002021,'NEW AKLAN','128002021',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002022,'PANGYAN','128002022',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002023,'POBLACION','128002023',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002024,'RIO DEL PILAR','128002024',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002025,'SAN JOSE','128002025',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002026,'SAN VICENTE','128002026',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002027,'SMALL MARGUS','128002027',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002028,'SUFATUBO','128002028',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002029,'TALUYA','128002029',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002030,'TANGO','128002030',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128002031,'TAPON','128002031',128002);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003001,'BADTASAN','128003001',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003002,'DATU DANI','128003002',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003003,'GASI','128003003',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003004,'KAPATE','128003004',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003005,'KATUBAO','128003005',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003006,'KAYUPO','128003006',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003007,'KLING (LUMIT)','128003007',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003008,'LAGUNDI','128003008',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003009,'LEBE','128003009',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003010,'LOMUYON','128003010',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003011,'LUMA','128003011',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003012,'MALIGANG','128003012',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003013,'NALUS','128003013',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003014,'POBLACION','128003014',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003015,'SALAKIT','128003015',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003016,'SULI','128003016',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003017,'TABLAO','128003017',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003018,'TAMADANG','128003018',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128003019,'TAMBILIL','128003019',128003);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004001,'AMSIPIT','128004001',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004002,'BALES','128004002',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004003,'COLON','128004003',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004004,'DALIAO','128004004',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004005,'KABATIOL','128004005',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004006,'KABLACAN','128004006',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004007,'KAMANGA','128004007',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004008,'KANALO','128004008',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004009,'LUMASAL','128004009',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004010,'LUMATIL','128004010',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004011,'MALBANG','128004011',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004012,'NOMOH','128004012',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004013,'PANANAG','128004013',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004014,'POBLACION (MAASIM)','128004014',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004015,'SEVEN HILLS','128004015',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128004016,'TINOTO','128004016',128004);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005001,'BATI-AN','128005001',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005002,'KALANEG','128005002',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005003,'KALAONG','128005003',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005004,'KIAMBING','128005004',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005005,'KIAYAP','128005005',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005006,'MABAY','128005006',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005007,'MAGULING','128005007',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005008,'MALALAG (POB.)','128005008',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005009,'MINDUPOK','128005009',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005010,'NEW LA UNION','128005010',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005011,'OLD POBLACION (MAITUM)','128005011',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005012,'PANGI (LINAO)','128005012',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005013,'PINOL','128005013',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005014,'SISON (EDENTON)','128005014',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005015,'TICULAB','128005015',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005016,'TUANADATU','128005016',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005017,'UPO (LANAO)','128005017',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005018,'WALI (KAMBUHAN)','128005018',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128005019,'ZION','128005019',128005);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006001,'DAAN SUYAN','128006001',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006002,'KIHAN','128006002',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006003,'KINAM','128006003',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006004,'LIBI','128006004',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006005,'LUN MASLA','128006005',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006006,'LUN PADIDU','128006006',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006007,'PATAG','128006007',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006008,'POBLACION (MALAPATAN)','128006008',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006009,'SAPU MASLA','128006009',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006010,'SAPU PADIDU','128006010',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006011,'TUYAN','128006011',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128006012,'UPPER SUYAN','128006012',128006);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007001,'ALKIKAN','128007001',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007002,'AMPON','128007002',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007003,'ATLAE','128007003',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007004,'BANAHAW','128007004',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007005,'BANATE','128007005',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007006,'B\'LAAN','128007006',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007007,'DATAL BATONG','128007007',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007008,'DATAL BILA','128007008',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007009,'DATAL TAMPAL','128007009',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007010,'J.P. LAUREL','128007010',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007011,'KAWAYAN','128007011',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007012,'KIBALA','128007012',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007013,'KIBLAT','128007013',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007014,'KINABALAN','128007014',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007015,'LOWER MAINIT','128007015',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007016,'LUTAY','128007016',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007017,'MALABOD','128007017',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007018,'MALALAG COGON','128007018',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007019,'MALANDAG','128007019',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007020,'MALUNGON GAMAY','128007020',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007021,'NAGPAN','128007021',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007022,'PANAMIN','128007022',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007023,'POBLACION','128007023',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007024,'SAN JUAN','128007024',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007025,'SAN MIGUEL','128007025',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007026,'SAN ROQUE','128007026',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007027,'TALUS','128007027',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007028,'TAMBAN','128007028',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007029,'UPPER BIANGAN','128007029',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007030,'UPPER LUMABAT','128007030',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (128007031,'UPPER MAINIT','128007031',128007);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804001,'BAGUA','129804001',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804002,'KALANGANAN','129804002',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804003,'POBLACION','129804003',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804004,'ROSARY HEIGHTS','129804004',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804005,'TAMONTAKA','129804005',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804006,'BAGUA I','129804006',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804007,'BAGUA II','129804007',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804008,'BAGUA III','129804008',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804009,'KALANGANAN I','129804009',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804010,'KALANGANAN II','129804010',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804011,'POBLACION I','129804011',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804012,'POBLACION II','129804012',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804013,'POBLACION III','129804013',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804014,'POBLACION IV','129804014',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804015,'POBLACION V','129804015',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804016,'POBLACION VI','129804016',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804017,'POBLACION VII','129804017',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804018,'POBLACION VIII','129804018',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804019,'POBLACION IX','129804019',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804020,'ROSARY HEIGHTS I','129804020',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804021,'ROSARY HEIGHTS II','129804021',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804022,'ROSARY HEIGHTS III','129804022',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804023,'ROSARY HEIGHTS IV','129804023',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804024,'ROSARY HEIGHTS V','129804024',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804025,'ROSARY HEIGHTS VI','129804025',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804026,'ROSARY HEIGHTS VII','129804026',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804027,'ROSARY HEIGHTS VIII','129804027',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804028,'ROSARY HEIGHTS IX','129804028',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804029,'ROSARY HEIGHTS X','129804029',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804030,'ROSARY HEIGHTS XI','129804030',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804031,'ROSARY HEIGHTS XII','129804031',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804032,'ROSARY HEIGHTS XIII','129804032',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804033,'TAMONTAKA I','129804033',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804034,'TAMONTAKA II','129804034',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804035,'TAMONTAKA III','129804035',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804036,'TAMONTAKA IV','129804036',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (129804037,'TAMONTAKA V','129804037',129804);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617001,'AMBOLONG','153617001',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617003,'BACOLOD CHICO PROPER','153617003',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617006,'BANGA','153617006',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617007,'BANGCO','153617007',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617008,'BANGGOLO POBLACION','153617008',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617009,'BANGON','153617009',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617010,'BEYABA-DAMAG','153617010',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617012,'BITO BUADI ITOWA','153617012',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617013,'BITO BUADI PARBA','153617013',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617014,'BUBONGA PAGALAMATAN','153617014',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617015,'BUBONGA LILOD MADAYA','153617015',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617016,'BOGANGA','153617016',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617017,'BOTO AMBOLONG','153617017',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617019,'BUBONGA CADAYONAN','153617019',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617021,'BUBONG LUMBAC','153617021',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617022,'BUBONGA MARAWI','153617022',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617023,'BUBONGA PUNOD','153617023',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617024,'CABASARAN','153617024',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617025,'CABINGAN','153617025',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617026,'CADAYONAN','153617026',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617027,'CADAYONAN I','153617027',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617029,'CALOCAN EAST','153617029',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617030,'CALOCAN WEST','153617030',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617032,'KORMATAN MATAMPAY','153617032',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617033,'DAGUDUBAN','153617033',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617035,'DANSALAN','153617035',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617036,'DATU SA DANSALAN','153617036',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617037,'DAYAWAN','153617037',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617039,'DIMALUNA','153617039',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617040,'DULAY','153617040',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617042,'DULAY WEST','153617042',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617043,'EAST BASAK','153617043',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617044,'EMIE PUNUD','153617044',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617045,'FORT','153617045',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617046,'GADONGAN','153617046',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617048,'BUADI SACAYO (GREEN)','153617048',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617049,'GUIMBA (LILOD PROPER)','153617049',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617051,'KAPANTARAN','153617051',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617052,'KILALA','153617052',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617057,'LILOD MADAYA (POB.)','153617057',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617058,'LILOD SADUC','153617058',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617060,'LOMIDONG','153617060',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617062,'LUMBACA MADAYA (POB.)','153617062',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617063,'LUMBAC MARINAUT','153617063',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617064,'LUMBACA TOROS','153617064',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617065,'MALIMONO','153617065',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617066,'BASAK MALUTLUT','153617066',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617068,'GADONGAN MAPANTAO','153617068',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617069,'AMITO MARANTAO','153617069',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617070,'MARINAUT EAST','153617070',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617071,'MARINAUT WEST','153617071',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617072,'MATAMPAY','153617072',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617074,'PANTAON (LANGCAF)','153617074',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617075,'MIPAGA PROPER','153617075',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617076,'MONCADO COLONY','153617076',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617077,'MONCADO KADINGILAN','153617077',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617079,'MORIATAO LOKSADATO','153617079',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617080,'DATU NAGA','153617080',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617083,'NAVARRO (DATU SABER)','153617083',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617085,'OLAWA AMBOLONG','153617085',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617086,'PAGALAMATAN GAMBAI','153617086',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617089,'PAGAYAWAN','153617089',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617090,'PANGGAO SADUC','153617090',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617097,'PAPANDAYAN','153617097',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617098,'PARIDI','153617098',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617099,'PATANI','153617099',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617101,'PINDOLONAN','153617101',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617103,'POONA MARANTAO','153617103',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617105,'PUGAAN','153617105',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617107,'RAPASUN MSU','153617107',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617109,'RAYA MADAYA I','153617109',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617110,'RAYA MADAYA II','153617110',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617111,'RAYA SADUC','153617111',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617112,'ROROGAGUS PROPER','153617112',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617113,'ROROGAGUS EAST','153617113',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617116,'SABALA MANAO','153617116',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617117,'SABALA MANAO PROPER','153617117',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617118,'SADUC PROPER','153617118',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617119,'SAGONSONGAN','153617119',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617120,'SANGCAY DANSALAN','153617120',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617123,'SOMIORANG','153617123',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617124,'SOUTH MADAYA PROPER','153617124',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617125,'SUGOD PROPER','153617125',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617126,'TAMPILONG','153617126',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617127,'TIMBANGALAN','153617127',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617129,'TUCA AMBOLONG','153617129',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617131,'TOLALI','153617131',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617133,'TOROS','153617133',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617134,'TUCA','153617134',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617136,'TUCA MARINAUT','153617136',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617137,'TONGANTONGAN-TUCA TIMBANGALAN','153617137',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617138,'WAWALAYAN CALOCAN','153617138',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617139,'WAWALAYAN MARINAUT','153617139',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617141,'MARAWI POBLACION','153617141',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617142,'NORHAYA VILLAGE','153617142',153617);
insert  into `tbl_barangay`(`id`,`barangay_name`,`brgy_code`,`municipality_id`) values (153617143,'PAPANDAYAN CANIOGAN','153617143',153617);

/*Table structure for table `tbl_beneficiaries` */

CREATE TABLE `tbl_beneficiaries` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `beneficiary_id` varchar(20) NOT NULL,
  `philsys_id` varchar(20) DEFAULT NULL,
  `senior_citizen_id` varchar(20) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `sex` varchar(1) NOT NULL,
  `address` longtext NOT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `last_updated_dt` datetime(6) NOT NULL,
  `address_psgc_id` bigint(20) DEFAULT NULL,
  `biometric_fp` varchar(50) DEFAULT NULL,
  `email` varchar(15) DEFAULT NULL,
  `is_pantawid` tinyint(1) NOT NULL,
  `pantawid_hhid` varchar(25) DEFAULT NULL,
  `pantawid_lowb` int(11) DEFAULT NULL,
  `last_updated_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `approved_dt` datetime(6) DEFAULT NULL,
  `certified_correct_by_id` int(11) DEFAULT NULL,
  `certified_correct_dt` datetime(6) DEFAULT NULL,
  `encoded_by_id` int(11) DEFAULT NULL,
  `encoded_dt` datetime(6) NOT NULL,
  `recommended_by_id` int(11) DEFAULT NULL,
  `recommended_dt` datetime(6) DEFAULT NULL,
  `validated_by_id` int(11) DEFAULT NULL,
  `validated_dt` datetime(6) DEFAULT NULL,
  `name_exit` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `beneficiary_id` (`beneficiary_id`),
  UNIQUE KEY `philsys_id` (`philsys_id`),
  UNIQUE KEY `senior_citizen_id` (`senior_citizen_id`),
  KEY `tbl_beneficiaries_address_psgc_id_ab7cf43a_fk_tbl_barangay_id` (`address_psgc_id`),
  KEY `tbl_beneficiaries_last_updated_by_id_2bd83104_fk_auth_user_id` (`last_updated_by_id`),
  KEY `tbl_beneficiaries_approved_by_id_cdf2f3c2_fk_auth_user_id` (`approved_by_id`),
  KEY `tbl_beneficiaries_certified_correct_by_e5f15e4d_fk_auth_user` (`certified_correct_by_id`),
  KEY `tbl_beneficiaries_encoded_by_id_deabc807_fk_auth_user_id` (`encoded_by_id`),
  KEY `tbl_beneficiaries_recommended_by_id_4146a3ad_fk_auth_user_id` (`recommended_by_id`),
  KEY `tbl_beneficiaries_validated_by_id_67954e2f_fk_auth_user_id` (`validated_by_id`),
  CONSTRAINT `tbl_beneficiaries_address_psgc_id_ab7cf43a_fk_tbl_barangay_id` FOREIGN KEY (`address_psgc_id`) REFERENCES `tbl_barangay` (`id`),
  CONSTRAINT `tbl_beneficiaries_approved_by_id_cdf2f3c2_fk_auth_user_id` FOREIGN KEY (`approved_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `tbl_beneficiaries_certified_correct_by_e5f15e4d_fk_auth_user` FOREIGN KEY (`certified_correct_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `tbl_beneficiaries_encoded_by_id_deabc807_fk_auth_user_id` FOREIGN KEY (`encoded_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `tbl_beneficiaries_last_updated_by_id_2bd83104_fk_auth_user_id` FOREIGN KEY (`last_updated_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `tbl_beneficiaries_recommended_by_id_4146a3ad_fk_auth_user_id` FOREIGN KEY (`recommended_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `tbl_beneficiaries_validated_by_id_67954e2f_fk_auth_user_id` FOREIGN KEY (`validated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_beneficiaries` */

insert  into `tbl_beneficiaries`(`id`,`beneficiary_id`,`philsys_id`,`senior_citizen_id`,`first_name`,`middle_name`,`last_name`,`birth_date`,`sex`,`address`,`contact_number`,`status`,`last_updated_dt`,`address_psgc_id`,`biometric_fp`,`email`,`is_pantawid`,`pantawid_hhid`,`pantawid_lowb`,`last_updated_by_id`,`approved_by_id`,`approved_dt`,`certified_correct_by_id`,`certified_correct_dt`,`encoded_by_id`,`encoded_dt`,`recommended_by_id`,`recommended_dt`,`validated_by_id`,`validated_dt`,`name_exit`) values (1,'BNF001','1234567890','SC12345','Jose','P.','Rizal','1981-01-02','M','1234 Sample Street, Sample City','09123456789',1,'2025-03-05 03:57:52.428844',124701008,'fingerprint_data','dcruz@email.com',0,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2025-03-06 07:08:25.943303',NULL,NULL,NULL,NULL,NULL);
insert  into `tbl_beneficiaries`(`id`,`beneficiary_id`,`philsys_id`,`senior_citizen_id`,`first_name`,`middle_name`,`last_name`,`birth_date`,`sex`,`address`,`contact_number`,`status`,`last_updated_dt`,`address_psgc_id`,`biometric_fp`,`email`,`is_pantawid`,`pantawid_hhid`,`pantawid_lowb`,`last_updated_by_id`,`approved_by_id`,`approved_dt`,`certified_correct_by_id`,`certified_correct_dt`,`encoded_by_id`,`encoded_dt`,`recommended_by_id`,`recommended_dt`,`validated_by_id`,`validated_dt`,`name_exit`) values (2,'BNF002','1234567891','SC12346','John','g.','Gult','1984-03-03','F','ADASD',NULL,1,'2025-03-06 00:00:00.000000',124701008,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-03-06 07:08:25.943303',NULL,NULL,NULL,NULL,NULL);
insert  into `tbl_beneficiaries`(`id`,`beneficiary_id`,`philsys_id`,`senior_citizen_id`,`first_name`,`middle_name`,`last_name`,`birth_date`,`sex`,`address`,`contact_number`,`status`,`last_updated_dt`,`address_psgc_id`,`biometric_fp`,`email`,`is_pantawid`,`pantawid_hhid`,`pantawid_lowb`,`last_updated_by_id`,`approved_by_id`,`approved_dt`,`certified_correct_by_id`,`certified_correct_dt`,`encoded_by_id`,`encoded_dt`,`recommended_by_id`,`recommended_dt`,`validated_by_id`,`validated_dt`,`name_exit`) values (3,'BNF003','13132','SC12344','Mr. James','','Bond','0000-00-00','M','123123123',NULL,1,'2025-03-01 00:00:00.000000',124701017,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-03-06 07:08:25.943303',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tbl_employee` */

CREATE TABLE `tbl_employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `name_exit` varchar(5) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `office` varchar(255) DEFAULT NULL,
  `emp_status` varchar(50) NOT NULL,
  `pos_status` varchar(20) NOT NULL,
  `item_number` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `position_id` bigint(20) DEFAULT NULL,
  `area_of_assignment_id` bigint(20) DEFAULT NULL,
  `sex` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emp_id` (`emp_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `item_number` (`item_number`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `tbl_employee_position_id_9d76ed03_fk_tbl_position_id` (`position_id`),
  KEY `tbl_employee_area_of_assignment_i_369dde7e_fk_tbl_munic` (`area_of_assignment_id`),
  CONSTRAINT `tbl_employee_area_of_assignment_i_369dde7e_fk_tbl_munic` FOREIGN KEY (`area_of_assignment_id`) REFERENCES `tbl_municipality` (`id`),
  CONSTRAINT `tbl_employee_position_id_9d76ed03_fk_tbl_position_id` FOREIGN KEY (`position_id`) REFERENCES `tbl_position` (`id`),
  CONSTRAINT `tbl_employee_user_id_5418490f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_employee` */

/*Table structure for table `tbl_fund_sources` */

CREATE TABLE `tbl_fund_sources` (
  `fund_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `fund_name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `balance` decimal(15,2) NOT NULL,
  PRIMARY KEY (`fund_source_id`),
  UNIQUE KEY `fund_name` (`fund_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_fund_sources` */

/*Table structure for table `tbl_liquidations` */

CREATE TABLE `tbl_liquidations` (
  `liquidation_id` int(11) NOT NULL AUTO_INCREMENT,
  `liquidation_date` date NOT NULL,
  `total_liquidated` decimal(15,2) NOT NULL,
  `remarks` longtext DEFAULT NULL,
  `payroll_id` int(11) NOT NULL,
  PRIMARY KEY (`liquidation_id`),
  KEY `tbl_liquidations_payroll_id_e8b51503_fk_tbl_payroll_payroll_id` (`payroll_id`),
  CONSTRAINT `tbl_liquidations_payroll_id_e8b51503_fk_tbl_payroll_payroll_id` FOREIGN KEY (`payroll_id`) REFERENCES `tbl_payroll` (`payroll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_liquidations` */

/*Table structure for table `tbl_municipality` */

CREATE TABLE `tbl_municipality` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `municipality_name` varchar(255) NOT NULL,
  `muni_code` varchar(20) NOT NULL,
  `province_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`municipality_name`),
  UNIQUE KEY `code` (`muni_code`),
  KEY `tbl_municipality_province_id_2a378538_fk_tbl_province_id` (`province_id`),
  CONSTRAINT `tbl_municipality_province_id_2a378538_fk_tbl_province_id` FOREIGN KEY (`province_id`) REFERENCES `tbl_province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153618 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_municipality` */

insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124701,'ALAMADA','124701000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124702,'CARMEN','124702000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124703,'KABACAN','124703000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124704,'CITY OF KIDAPAWAN (Capital)','124704000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124705,'LIBUNGAN','124705000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124706,'MAGPET','124706000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124707,'MAKILALA','124707000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124708,'MATALAM','124708000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124709,'MIDSAYAP','124709000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124710,'MLANG','124710000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124711,'PIGKAWAYAN','124711000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124712,'PIKIT','124712000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124713,'PRESIDENT ROXAS','124713000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124714,'TULUNAN','124714000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124715,'ANTIPAS','124715000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124716,'BANISILAN','124716000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124717,'ALEOSAN','124717000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (124718,'ARAKAN','124718000',1247);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126302,'BANGA','126302000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126303,'GENERAL SANTOS CITY (DADIANGAS)','126303000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126306,'CITY OF KORONADAL (Capital)','126306000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126311,'NORALA','126311000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126312,'POLOMOLOK','126312000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126313,'SURALLAH','126313000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126314,'TAMPAKAN','126314000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126315,'TANTANGAN','126315000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126316,'T`BOLI','126316000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126317,'TUPI','126317000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126318,'SANTO NIÑO','126318000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126319,'LAKE SEBU','126319000',1263);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126501,'BAGUMBAYAN','126501000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126502,'COLUMBIO','126502000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126503,'ESPERANZA','126503000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126504,'ISULAN (Capital)','126504000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126505,'KALAMANSIG','126505000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126506,'LEBAK','126506000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126507,'LUTAYAN','126507000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126508,'LAMBAYONG (MARIANO MARCOS)','126508000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126509,'PALIMBANG','126509000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126510,'PRESIDENT QUIRINO','126510000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126511,'CITY OF TACURONG','126511000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (126512,'SEN. NINOY AQUINO','126512000',1265);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128001,'ALABEL (Capital)','128001000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128002,'GLAN','128002000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128003,'KIAMBA','128003000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128004,'MAASIM','128004000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128005,'MAITUM','128005000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128006,'MALAPATAN','128006000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (128007,'MALUNGON','128007000',1280);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (129804,'COTABATO CITY','129804000',1298);
insert  into `tbl_municipality`(`id`,`municipality_name`,`muni_code`,`province_id`) values (153617,'MARAWI CITY (Capital)','153617000',1536);

/*Table structure for table `tbl_obligations` */

CREATE TABLE `tbl_obligations` (
  `obligation_id` int(11) NOT NULL AUTO_INCREMENT,
  `obligation_date` date NOT NULL,
  `amount_obligated` decimal(15,2) NOT NULL,
  `description` longtext DEFAULT NULL,
  `fund_source_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`obligation_id`),
  KEY `tbl_obligations_fund_source_id_1333c4b6_fk_tbl_fund_` (`fund_source_id`),
  CONSTRAINT `tbl_obligations_fund_source_id_1333c4b6_fk_tbl_fund_` FOREIGN KEY (`fund_source_id`) REFERENCES `tbl_fund_sources` (`fund_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_obligations` */

/*Table structure for table `tbl_payroll` */

CREATE TABLE `tbl_payroll` (
  `payroll_id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_date` date NOT NULL,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `obligation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`payroll_id`),
  KEY `tbl_payroll_obligation_id_6a9f1784_fk_tbl_oblig` (`obligation_id`),
  CONSTRAINT `tbl_payroll_obligation_id_6a9f1784_fk_tbl_oblig` FOREIGN KEY (`obligation_id`) REFERENCES `tbl_obligations` (`obligation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_payroll` */

/*Table structure for table `tbl_payroll_details` */

CREATE TABLE `tbl_payroll_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `beneficiary_id` bigint(20) NOT NULL,
  `payroll_id` int(11) NOT NULL,
  `date_paid` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_payroll_details_beneficiary_id_ed0f2885_fk_tbl_benef` (`beneficiary_id`),
  KEY `tbl_payroll_details_payroll_id_a8369af8_fk_tbl_payro` (`payroll_id`),
  CONSTRAINT `tbl_payroll_details_beneficiary_id_ed0f2885_fk_tbl_benef` FOREIGN KEY (`beneficiary_id`) REFERENCES `tbl_beneficiaries` (`id`),
  CONSTRAINT `tbl_payroll_details_payroll_id_a8369af8_fk_tbl_payro` FOREIGN KEY (`payroll_id`) REFERENCES `tbl_payroll` (`payroll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_payroll_details` */

/*Table structure for table `tbl_pictures` */

CREATE TABLE `tbl_pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `size` int(10) unsigned NOT NULL CHECK (`size` >= 0),
  `mimetype` varchar(50) NOT NULL,
  `format` varchar(10) NOT NULL,
  `beneficiary_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_pictures_beneficiary_id_13c4f98e_fk_tbl_beneficiaries_id` (`beneficiary_id`),
  CONSTRAINT `tbl_pictures_beneficiary_id_13c4f98e_fk_tbl_beneficiaries_id` FOREIGN KEY (`beneficiary_id`) REFERENCES `tbl_beneficiaries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_pictures` */

insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (4,'1.jpg',48838,'image/jpeg','jpeg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (9,'2.jpg',47085,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (10,'2.jpg',47837,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (11,'2.jpg',53727,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (12,'2.jpg',47261,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (13,'2.jpg',51029,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (14,'1.jpg',55262,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (15,'1.jpg',54526,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (16,'2.jpg',52148,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (17,'1.jpg',52148,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (18,'1.jpg',48925,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (19,'1.jpg',47272,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (20,'1.jpg',3,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (21,'1.jpg',76611,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (22,'1.jpg',49363,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (23,'1.jpg',75544,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (24,'1.jpg',72369,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (25,'1.jpg',61278,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (26,'1.jpg',34743,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (27,'1.jpg',47351,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (28,'1.jpg',50131,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (29,'1.jpg',39858,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (30,'1.jpg',85564,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (31,'1.jpg',81943,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (32,'2.jpg',79708,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (33,'1.jpg',15608,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (34,'2.jpg',16740,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (35,'2.jpg',19308,'image/jpg','jpg',2);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (36,'1.jpg',13608,'image/jpg','jpg',1);
insert  into `tbl_pictures`(`id`,`filename`,`size`,`mimetype`,`format`,`beneficiary_id`) values (37,'1.jpg',44931,'image/jpg','jpg',1);

/*Table structure for table `tbl_position` */

CREATE TABLE `tbl_position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_position` */

/*Table structure for table `tbl_province` */

CREATE TABLE `tbl_province` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(255) NOT NULL,
  `prov_code` varchar(20) NOT NULL,
  `region_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`province_name`),
  UNIQUE KEY `code` (`prov_code`),
  KEY `tbl_province_region_id_7012f71a_fk_tbl_region_id` (`region_id`),
  CONSTRAINT `tbl_province_region_id_7012f71a_fk_tbl_region_id` FOREIGN KEY (`region_id`) REFERENCES `tbl_region` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_province` */

insert  into `tbl_province`(`id`,`province_name`,`prov_code`,`region_id`) values (1247,'COTABATO (NORTH COTABATO)','124700000',12);
insert  into `tbl_province`(`id`,`province_name`,`prov_code`,`region_id`) values (1263,'SOUTH COTABATO','126300000',12);
insert  into `tbl_province`(`id`,`province_name`,`prov_code`,`region_id`) values (1265,'SULTAN KUDARAT','126500000',12);
insert  into `tbl_province`(`id`,`province_name`,`prov_code`,`region_id`) values (1280,'SARANGANI','128000000',12);

/*Table structure for table `tbl_region` */

CREATE TABLE `tbl_region` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(255) NOT NULL,
  `reg_code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`region_name`),
  UNIQUE KEY `code` (`reg_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_region` */

insert  into `tbl_region`(`id`,`region_name`,`reg_code`) values (12,'REGION XII [Soccsksargen]','120000000');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
