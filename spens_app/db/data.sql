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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$600000$A8gqzMTtFnahBcEq7yTEmB$w+BKq0nTeoDFK49bhl8BT/VjXp1Ex229dCdg/BGN/mg=','2025-03-02 07:32:39.775306',1,'admin','','','alden.roxy@gmail.com',1,1,'2025-03-02 06:06:33.040007');
insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (4,'pbkdf2_sha256$720000$vNDl5BpUDeeUhXPKOTOEVw$YZs3xBNn80I1i+hLaHzJ6UbLi/58LuYoyUsg8bHZk6w=','2025-03-03 07:49:04.331115',0,'user01','Alden','Quinones','user01@gmail.com',0,1,'2025-03-02 07:09:29.309544');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (3,'auth','group');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (2,'auth','permission');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (4,'auth','user');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (5,'contenttypes','contenttype');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (10,'main_app','barangay');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (7,'main_app','employeeprofile');
insert  into `django_content_type`(`id`,`app_label`,`model`) values (8,'main_app','municipality');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

/*Table structure for table `django_session` */

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('695mqcp6wbdool4i1r9jtzukn1mnn59l','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tp03d:p0nSpIJ3g3ltQEpp1JNelA6x9Og9MHy8u-HKQa-by0A','2025-03-03 07:47:45.998684');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('gnpaj16ijlpj1uesjzzhbq7em5zjrd2o','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toyLB:xrfGa7yIfu4Efx_jwrQwAMx4y1ZhpR7cYwPJVHx60mg','2025-03-03 05:57:45.631810');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('ifh6jdqw1bpigzw0igo5dbs770640f43','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1tp0Xw:9dyN2McKswS-jhOd86QT-tqtL9xKwyaK0Zm0aAHjmkI','2025-03-03 08:19:04.332068');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('n045hddxli0am5o24wsilmlgnp5n2kau','e30:1toch5:H_ppj6XRg0_EopeBQp4wGxYd3mh5DZypmd8LdlYe2GQ','2025-03-16 06:20:55.882064');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('riffp63hp10ilrllymrrv07eq9xuq1lu','e30:1todSR:C77rdbaZTEswSTqbscPS4SrPyObSxPaYm_pvVmAVKYM','2025-03-02 07:39:51.225051');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('tm2ab916lfdhohz1i8aess5fw2ego6nw','e30:1todJs:pGbnEINh-sQuWN7IVrBa6UDyKqqGzvhFevgeqxvyspg','2025-03-02 07:31:00.006507');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('vnihjqfq6vpzjorxer63hya6vzkazke7','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toza7:yN0hIwtN8w3j76BbTzLOAMWnnwnzxJgt2AVnk-yLsE0','2025-03-03 07:17:15.240254');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('vskeioigsq8wbexxzr4qqhkcm901wgxo','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toxro:HsOwTDvlYv8FX2oYEbnlUTDWhF5kKhpY5VmelmMGlVw','2025-03-03 05:27:24.539320');
insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('wzwi6jyd2ewr8jb810fo4wr3j1gaqrox','.eJxVjEEOwiAQRe_C2hBgpkBduvcMZIBBqoYmpV0Z765NutDtf-_9lwi0rTVsnZcwZXEWKE6_W6T04LaDfKd2m2Wa27pMUe6KPGiX1znz83K4fweVev3WNOBgHERjLaaMbjSFGJXSXJT26AyPniECaW8joHKkMgBaDbZQKiDeH79-NwM:1toypc:_tVX0WDyITccTq2LOJgmfXhbCCphukDKQFiVmb4qR9Y','2025-03-03 06:29:12.487227');

/*Table structure for table `tbl_barangay` */

CREATE TABLE `tbl_barangay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(20) NOT NULL,
  `municipality_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tbl_barangay_code_785652b0_uniq` (`code`),
  KEY `main_app_barangay_municipality_id_bb01e0da_fk_tbl_munic` (`municipality_id`),
  CONSTRAINT `main_app_barangay_municipality_id_bb01e0da_fk_tbl_munic` FOREIGN KEY (`municipality_id`) REFERENCES `tbl_municipality` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153617144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_barangay` */

insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701001,'ALAMADA','124701001',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701002,'ALAMADA','124701002',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701003,'ALAMADA','124701003',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701004,'ALAMADA','124701004',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701005,'ALAMADA','124701005',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701006,'ALAMADA','124701006',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701007,'ALAMADA','124701007',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701008,'ALAMADA','124701008',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701009,'ALAMADA','124701009',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701010,'ALAMADA','124701010',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701011,'ALAMADA','124701011',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701012,'ALAMADA','124701012',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701013,'ALAMADA','124701013',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701014,'ALAMADA','124701014',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701015,'ALAMADA','124701015',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701016,'ALAMADA','124701016',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124701017,'ALAMADA','124701017',124701);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702001,'CARMEN','124702001',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702003,'CARMEN','124702003',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702005,'CARMEN','124702005',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702007,'CARMEN','124702007',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702008,'CARMEN','124702008',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702010,'CARMEN','124702010',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702011,'CARMEN','124702011',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702012,'CARMEN','124702012',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702013,'CARMEN','124702013',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702014,'CARMEN','124702014',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702015,'CARMEN','124702015',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702016,'CARMEN','124702016',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702017,'CARMEN','124702017',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702019,'CARMEN','124702019',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702020,'CARMEN','124702020',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702021,'CARMEN','124702021',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702022,'CARMEN','124702022',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702024,'CARMEN','124702024',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702025,'CARMEN','124702025',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702027,'CARMEN','124702027',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702028,'CARMEN','124702028',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702030,'CARMEN','124702030',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702032,'CARMEN','124702032',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702034,'CARMEN','124702034',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702035,'CARMEN','124702035',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702036,'CARMEN','124702036',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702037,'CARMEN','124702037',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124702039,'CARMEN','124702039',124702);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703001,'KABACAN','124703001',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703002,'KABACAN','124703002',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703003,'KABACAN','124703003',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703004,'KABACAN','124703004',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703005,'KABACAN','124703005',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703006,'KABACAN','124703006',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703007,'KABACAN','124703007',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703008,'KABACAN','124703008',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703009,'KABACAN','124703009',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703010,'KABACAN','124703010',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703011,'KABACAN','124703011',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703012,'KABACAN','124703012',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703013,'KABACAN','124703013',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703014,'KABACAN','124703014',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703015,'KABACAN','124703015',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703016,'KABACAN','124703016',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703017,'KABACAN','124703017',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703018,'KABACAN','124703018',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703019,'KABACAN','124703019',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703020,'KABACAN','124703020',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703021,'KABACAN','124703021',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703022,'KABACAN','124703022',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703023,'KABACAN','124703023',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124703024,'KABACAN','124703024',124703);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704001,'CITY OF KIDAPAWAN (Capital)','124704001',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704002,'CITY OF KIDAPAWAN (Capital)','124704002',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704003,'CITY OF KIDAPAWAN (Capital)','124704003',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704004,'CITY OF KIDAPAWAN (Capital)','124704004',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704005,'CITY OF KIDAPAWAN (Capital)','124704005',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704006,'CITY OF KIDAPAWAN (Capital)','124704006',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704007,'CITY OF KIDAPAWAN (Capital)','124704007',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704008,'CITY OF KIDAPAWAN (Capital)','124704008',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704009,'CITY OF KIDAPAWAN (Capital)','124704009',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704010,'CITY OF KIDAPAWAN (Capital)','124704010',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704011,'CITY OF KIDAPAWAN (Capital)','124704011',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704012,'CITY OF KIDAPAWAN (Capital)','124704012',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704013,'CITY OF KIDAPAWAN (Capital)','124704013',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704014,'CITY OF KIDAPAWAN (Capital)','124704014',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704015,'CITY OF KIDAPAWAN (Capital)','124704015',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704016,'CITY OF KIDAPAWAN (Capital)','124704016',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704017,'CITY OF KIDAPAWAN (Capital)','124704017',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704018,'CITY OF KIDAPAWAN (Capital)','124704018',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704020,'CITY OF KIDAPAWAN (Capital)','124704020',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704021,'CITY OF KIDAPAWAN (Capital)','124704021',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704022,'CITY OF KIDAPAWAN (Capital)','124704022',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704023,'CITY OF KIDAPAWAN (Capital)','124704023',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704024,'CITY OF KIDAPAWAN (Capital)','124704024',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704025,'CITY OF KIDAPAWAN (Capital)','124704025',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704026,'CITY OF KIDAPAWAN (Capital)','124704026',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704027,'CITY OF KIDAPAWAN (Capital)','124704027',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704028,'CITY OF KIDAPAWAN (Capital)','124704028',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704029,'CITY OF KIDAPAWAN (Capital)','124704029',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704030,'CITY OF KIDAPAWAN (Capital)','124704030',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704031,'CITY OF KIDAPAWAN (Capital)','124704031',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704032,'CITY OF KIDAPAWAN (Capital)','124704032',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704033,'CITY OF KIDAPAWAN (Capital)','124704033',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704034,'CITY OF KIDAPAWAN (Capital)','124704034',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704035,'CITY OF KIDAPAWAN (Capital)','124704035',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704036,'CITY OF KIDAPAWAN (Capital)','124704036',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704037,'CITY OF KIDAPAWAN (Capital)','124704037',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704038,'CITY OF KIDAPAWAN (Capital)','124704038',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704039,'CITY OF KIDAPAWAN (Capital)','124704039',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704040,'CITY OF KIDAPAWAN (Capital)','124704040',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124704041,'CITY OF KIDAPAWAN (Capital)','124704041',124704);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705001,'LIBUNGAN','124705001',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705003,'LIBUNGAN','124705003',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705004,'LIBUNGAN','124705004',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705005,'LIBUNGAN','124705005',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705006,'LIBUNGAN','124705006',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705007,'LIBUNGAN','124705007',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705010,'LIBUNGAN','124705010',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705011,'LIBUNGAN','124705011',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705013,'LIBUNGAN','124705013',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705014,'LIBUNGAN','124705014',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705015,'LIBUNGAN','124705015',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705017,'LIBUNGAN','124705017',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705019,'LIBUNGAN','124705019',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705023,'LIBUNGAN','124705023',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705024,'LIBUNGAN','124705024',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705025,'LIBUNGAN','124705025',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705029,'LIBUNGAN','124705029',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705032,'LIBUNGAN','124705032',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705033,'LIBUNGAN','124705033',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124705034,'LIBUNGAN','124705034',124705);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706001,'MAGPET','124706001',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706005,'MAGPET','124706005',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706006,'MAGPET','124706006',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706007,'MAGPET','124706007',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706008,'MAGPET','124706008',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706009,'MAGPET','124706009',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706010,'MAGPET','124706010',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706014,'MAGPET','124706014',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706015,'MAGPET','124706015',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706016,'MAGPET','124706016',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706021,'MAGPET','124706021',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706022,'MAGPET','124706022',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706023,'MAGPET','124706023',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706024,'MAGPET','124706024',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706026,'MAGPET','124706026',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706027,'MAGPET','124706027',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706029,'MAGPET','124706029',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706030,'MAGPET','124706030',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706033,'MAGPET','124706033',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706037,'MAGPET','124706037',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706038,'MAGPET','124706038',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706039,'MAGPET','124706039',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706040,'MAGPET','124706040',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706042,'MAGPET','124706042',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706043,'MAGPET','124706043',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706044,'MAGPET','124706044',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706048,'MAGPET','124706048',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706049,'MAGPET','124706049',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706050,'MAGPET','124706050',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706051,'MAGPET','124706051',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706052,'MAGPET','124706052',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124706053,'MAGPET','124706053',124706);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707001,'MAKILALA','124707001',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707002,'MAKILALA','124707002',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707003,'MAKILALA','124707003',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707004,'MAKILALA','124707004',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707005,'MAKILALA','124707005',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707006,'MAKILALA','124707006',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707007,'MAKILALA','124707007',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707008,'MAKILALA','124707008',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707009,'MAKILALA','124707009',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707010,'MAKILALA','124707010',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707011,'MAKILALA','124707011',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707012,'MAKILALA','124707012',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707013,'MAKILALA','124707013',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707014,'MAKILALA','124707014',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707015,'MAKILALA','124707015',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707016,'MAKILALA','124707016',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707017,'MAKILALA','124707017',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707018,'MAKILALA','124707018',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707019,'MAKILALA','124707019',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707020,'MAKILALA','124707020',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707021,'MAKILALA','124707021',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707022,'MAKILALA','124707022',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707023,'MAKILALA','124707023',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707024,'MAKILALA','124707024',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707025,'MAKILALA','124707025',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707026,'MAKILALA','124707026',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707027,'MAKILALA','124707027',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707028,'MAKILALA','124707028',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707029,'MAKILALA','124707029',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707030,'MAKILALA','124707030',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707031,'MAKILALA','124707031',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707032,'MAKILALA','124707032',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707033,'MAKILALA','124707033',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707034,'MAKILALA','124707034',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707035,'MAKILALA','124707035',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707036,'MAKILALA','124707036',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707037,'MAKILALA','124707037',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124707038,'MAKILALA','124707038',124707);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708001,'MATALAM','124708001',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708003,'MATALAM','124708003',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708004,'MATALAM','124708004',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708005,'MATALAM','124708005',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708006,'MATALAM','124708006',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708007,'MATALAM','124708007',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708008,'MATALAM','124708008',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708009,'MATALAM','124708009',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708010,'MATALAM','124708010',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708012,'MATALAM','124708012',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708013,'MATALAM','124708013',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708014,'MATALAM','124708014',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708015,'MATALAM','124708015',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708017,'MATALAM','124708017',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708018,'MATALAM','124708018',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708019,'MATALAM','124708019',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708020,'MATALAM','124708020',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708025,'MATALAM','124708025',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708026,'MATALAM','124708026',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708027,'MATALAM','124708027',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708028,'MATALAM','124708028',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708029,'MATALAM','124708029',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708030,'MATALAM','124708030',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708031,'MATALAM','124708031',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708033,'MATALAM','124708033',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708034,'MATALAM','124708034',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708035,'MATALAM','124708035',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708036,'MATALAM','124708036',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708037,'MATALAM','124708037',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708038,'MATALAM','124708038',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708039,'MATALAM','124708039',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708040,'MATALAM','124708040',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708041,'MATALAM','124708041',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124708042,'MATALAM','124708042',124708);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709002,'MIDSAYAP','124709002',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709003,'MIDSAYAP','124709003',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709004,'MIDSAYAP','124709004',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709005,'MIDSAYAP','124709005',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709006,'MIDSAYAP','124709006',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709007,'MIDSAYAP','124709007',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709008,'MIDSAYAP','124709008',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709009,'MIDSAYAP','124709009',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709010,'MIDSAYAP','124709010',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709011,'MIDSAYAP','124709011',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709012,'MIDSAYAP','124709012',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709013,'MIDSAYAP','124709013',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709014,'MIDSAYAP','124709014',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709015,'MIDSAYAP','124709015',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709016,'MIDSAYAP','124709016',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709017,'MIDSAYAP','124709017',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709018,'MIDSAYAP','124709018',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709019,'MIDSAYAP','124709019',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709020,'MIDSAYAP','124709020',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709021,'MIDSAYAP','124709021',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709022,'MIDSAYAP','124709022',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709023,'MIDSAYAP','124709023',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709024,'MIDSAYAP','124709024',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709025,'MIDSAYAP','124709025',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709026,'MIDSAYAP','124709026',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709027,'MIDSAYAP','124709027',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709028,'MIDSAYAP','124709028',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709029,'MIDSAYAP','124709029',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709030,'MIDSAYAP','124709030',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709031,'MIDSAYAP','124709031',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709032,'MIDSAYAP','124709032',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709033,'MIDSAYAP','124709033',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709034,'MIDSAYAP','124709034',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709035,'MIDSAYAP','124709035',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709036,'MIDSAYAP','124709036',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709037,'MIDSAYAP','124709037',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709038,'MIDSAYAP','124709038',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709039,'MIDSAYAP','124709039',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709040,'MIDSAYAP','124709040',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709041,'MIDSAYAP','124709041',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709042,'MIDSAYAP','124709042',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709043,'MIDSAYAP','124709043',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709044,'MIDSAYAP','124709044',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709045,'MIDSAYAP','124709045',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709046,'MIDSAYAP','124709046',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709047,'MIDSAYAP','124709047',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709048,'MIDSAYAP','124709048',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709049,'MIDSAYAP','124709049',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709050,'MIDSAYAP','124709050',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709051,'MIDSAYAP','124709051',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709052,'MIDSAYAP','124709052',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709053,'MIDSAYAP','124709053',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709054,'MIDSAYAP','124709054',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709055,'MIDSAYAP','124709055',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709056,'MIDSAYAP','124709056',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709057,'MIDSAYAP','124709057',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124709058,'MIDSAYAP','124709058',124709);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710001,'MLANG','124710001',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710002,'MLANG','124710002',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710003,'MLANG','124710003',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710004,'MLANG','124710004',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710005,'MLANG','124710005',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710006,'MLANG','124710006',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710007,'MLANG','124710007',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710008,'MLANG','124710008',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710009,'MLANG','124710009',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710010,'MLANG','124710010',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710011,'MLANG','124710011',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710012,'MLANG','124710012',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710013,'MLANG','124710013',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710014,'MLANG','124710014',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710015,'MLANG','124710015',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710016,'MLANG','124710016',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710018,'MLANG','124710018',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710019,'MLANG','124710019',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710020,'MLANG','124710020',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710021,'MLANG','124710021',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710022,'MLANG','124710022',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710024,'MLANG','124710024',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710025,'MLANG','124710025',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710026,'MLANG','124710026',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710027,'MLANG','124710027',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710028,'MLANG','124710028',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710029,'MLANG','124710029',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710030,'MLANG','124710030',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710031,'MLANG','124710031',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710032,'MLANG','124710032',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710033,'MLANG','124710033',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710034,'MLANG','124710034',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710035,'MLANG','124710035',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710036,'MLANG','124710036',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710037,'MLANG','124710037',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124710038,'MLANG','124710038',124710);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711001,'PIGKAWAYAN','124711001',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711002,'PIGKAWAYAN','124711002',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711003,'PIGKAWAYAN','124711003',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711004,'PIGKAWAYAN','124711004',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711006,'PIGKAWAYAN','124711006',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711007,'PIGKAWAYAN','124711007',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711008,'PIGKAWAYAN','124711008',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711009,'PIGKAWAYAN','124711009',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711010,'PIGKAWAYAN','124711010',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711011,'PIGKAWAYAN','124711011',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711012,'PIGKAWAYAN','124711012',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711013,'PIGKAWAYAN','124711013',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711014,'PIGKAWAYAN','124711014',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711015,'PIGKAWAYAN','124711015',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711016,'PIGKAWAYAN','124711016',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711017,'PIGKAWAYAN','124711017',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711018,'PIGKAWAYAN','124711018',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711019,'PIGKAWAYAN','124711019',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711020,'PIGKAWAYAN','124711020',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711021,'PIGKAWAYAN','124711021',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711022,'PIGKAWAYAN','124711022',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711023,'PIGKAWAYAN','124711023',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711024,'PIGKAWAYAN','124711024',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711025,'PIGKAWAYAN','124711025',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711026,'PIGKAWAYAN','124711026',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711027,'PIGKAWAYAN','124711027',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711028,'PIGKAWAYAN','124711028',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711029,'PIGKAWAYAN','124711029',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711030,'PIGKAWAYAN','124711030',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711031,'PIGKAWAYAN','124711031',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711032,'PIGKAWAYAN','124711032',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711033,'PIGKAWAYAN','124711033',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711034,'PIGKAWAYAN','124711034',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711035,'PIGKAWAYAN','124711035',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711036,'PIGKAWAYAN','124711036',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711037,'PIGKAWAYAN','124711037',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711038,'PIGKAWAYAN','124711038',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711039,'PIGKAWAYAN','124711039',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711040,'PIGKAWAYAN','124711040',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124711041,'PIGKAWAYAN','124711041',124711);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712001,'PIKIT','124712001',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712003,'PIKIT','124712003',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712004,'PIKIT','124712004',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712005,'PIKIT','124712005',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712006,'PIKIT','124712006',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712007,'PIKIT','124712007',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712008,'PIKIT','124712008',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712009,'PIKIT','124712009',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712010,'PIKIT','124712010',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712011,'PIKIT','124712011',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712012,'PIKIT','124712012',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712013,'PIKIT','124712013',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712015,'PIKIT','124712015',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712016,'PIKIT','124712016',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712019,'PIKIT','124712019',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712020,'PIKIT','124712020',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712021,'PIKIT','124712021',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712022,'PIKIT','124712022',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712023,'PIKIT','124712023',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712024,'PIKIT','124712024',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712025,'PIKIT','124712025',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712026,'PIKIT','124712026',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712028,'PIKIT','124712028',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712029,'PIKIT','124712029',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712030,'PIKIT','124712030',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712031,'PIKIT','124712031',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712034,'PIKIT','124712034',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712035,'PIKIT','124712035',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712037,'PIKIT','124712037',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712040,'PIKIT','124712040',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712041,'PIKIT','124712041',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712044,'PIKIT','124712044',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712046,'PIKIT','124712046',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712048,'PIKIT','124712048',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712050,'PIKIT','124712050',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712051,'PIKIT','124712051',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712052,'PIKIT','124712052',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712055,'PIKIT','124712055',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712056,'PIKIT','124712056',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712057,'PIKIT','124712057',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712060,'PIKIT','124712060',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124712062,'PIKIT','124712062',124712);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713001,'PRESIDENT ROXAS','124713001',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713002,'PRESIDENT ROXAS','124713002',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713003,'PRESIDENT ROXAS','124713003',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713005,'PRESIDENT ROXAS','124713005',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713006,'PRESIDENT ROXAS','124713006',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713007,'PRESIDENT ROXAS','124713007',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713008,'PRESIDENT ROXAS','124713008',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713009,'PRESIDENT ROXAS','124713009',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713011,'PRESIDENT ROXAS','124713011',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713012,'PRESIDENT ROXAS','124713012',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713013,'PRESIDENT ROXAS','124713013',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713014,'PRESIDENT ROXAS','124713014',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713016,'PRESIDENT ROXAS','124713016',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713022,'PRESIDENT ROXAS','124713022',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713024,'PRESIDENT ROXAS','124713024',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713026,'PRESIDENT ROXAS','124713026',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713027,'PRESIDENT ROXAS','124713027',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713028,'PRESIDENT ROXAS','124713028',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713029,'PRESIDENT ROXAS','124713029',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713030,'PRESIDENT ROXAS','124713030',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713031,'PRESIDENT ROXAS','124713031',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713032,'PRESIDENT ROXAS','124713032',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713033,'PRESIDENT ROXAS','124713033',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713034,'PRESIDENT ROXAS','124713034',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124713035,'PRESIDENT ROXAS','124713035',124713);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714001,'TULUNAN','124714001',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714002,'TULUNAN','124714002',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714003,'TULUNAN','124714003',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714004,'TULUNAN','124714004',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714005,'TULUNAN','124714005',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714006,'TULUNAN','124714006',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714007,'TULUNAN','124714007',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714008,'TULUNAN','124714008',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714009,'TULUNAN','124714009',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714010,'TULUNAN','124714010',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714011,'TULUNAN','124714011',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714012,'TULUNAN','124714012',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714013,'TULUNAN','124714013',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714014,'TULUNAN','124714014',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714015,'TULUNAN','124714015',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714016,'TULUNAN','124714016',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714017,'TULUNAN','124714017',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714018,'TULUNAN','124714018',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714019,'TULUNAN','124714019',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714020,'TULUNAN','124714020',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714021,'TULUNAN','124714021',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714022,'TULUNAN','124714022',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714023,'TULUNAN','124714023',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714024,'TULUNAN','124714024',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714026,'TULUNAN','124714026',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714027,'TULUNAN','124714027',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714028,'TULUNAN','124714028',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714029,'TULUNAN','124714029',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124714030,'TULUNAN','124714030',124714);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715001,'ANTIPAS','124715001',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715002,'ANTIPAS','124715002',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715003,'ANTIPAS','124715003',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715004,'ANTIPAS','124715004',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715005,'ANTIPAS','124715005',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715006,'ANTIPAS','124715006',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715007,'ANTIPAS','124715007',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715008,'ANTIPAS','124715008',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715009,'ANTIPAS','124715009',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715010,'ANTIPAS','124715010',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715011,'ANTIPAS','124715011',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715012,'ANTIPAS','124715012',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124715013,'ANTIPAS','124715013',124715);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716001,'BANISILAN','124716001',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716002,'BANISILAN','124716002',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716003,'BANISILAN','124716003',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716004,'BANISILAN','124716004',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716005,'BANISILAN','124716005',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716006,'BANISILAN','124716006',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716007,'BANISILAN','124716007',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716008,'BANISILAN','124716008',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716009,'BANISILAN','124716009',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716010,'BANISILAN','124716010',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716011,'BANISILAN','124716011',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716012,'BANISILAN','124716012',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716013,'BANISILAN','124716013',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716014,'BANISILAN','124716014',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716015,'BANISILAN','124716015',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716016,'BANISILAN','124716016',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716017,'BANISILAN','124716017',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716018,'BANISILAN','124716018',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716019,'BANISILAN','124716019',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124716020,'BANISILAN','124716020',124716);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717001,'ALEOSAN','124717001',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717002,'ALEOSAN','124717002',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717003,'ALEOSAN','124717003',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717004,'ALEOSAN','124717004',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717005,'ALEOSAN','124717005',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717006,'ALEOSAN','124717006',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717007,'ALEOSAN','124717007',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717008,'ALEOSAN','124717008',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717009,'ALEOSAN','124717009',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717010,'ALEOSAN','124717010',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717011,'ALEOSAN','124717011',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717012,'ALEOSAN','124717012',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717013,'ALEOSAN','124717013',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717014,'ALEOSAN','124717014',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717015,'ALEOSAN','124717015',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717016,'ALEOSAN','124717016',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717017,'ALEOSAN','124717017',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717018,'ALEOSAN','124717018',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124717019,'ALEOSAN','124717019',124717);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718001,'ARAKAN','124718001',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718002,'ARAKAN','124718002',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718003,'ARAKAN','124718003',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718004,'ARAKAN','124718004',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718005,'ARAKAN','124718005',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718006,'ARAKAN','124718006',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718007,'ARAKAN','124718007',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718008,'ARAKAN','124718008',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718009,'ARAKAN','124718009',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718010,'ARAKAN','124718010',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718011,'ARAKAN','124718011',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718012,'ARAKAN','124718012',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718013,'ARAKAN','124718013',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718014,'ARAKAN','124718014',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718015,'ARAKAN','124718015',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718016,'ARAKAN','124718016',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718017,'ARAKAN','124718017',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718018,'ARAKAN','124718018',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718019,'ARAKAN','124718019',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718020,'ARAKAN','124718020',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718021,'ARAKAN','124718021',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718022,'ARAKAN','124718022',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718023,'ARAKAN','124718023',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718024,'ARAKAN','124718024',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718025,'ARAKAN','124718025',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718026,'ARAKAN','124718026',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718027,'ARAKAN','124718027',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (124718028,'ARAKAN','124718028',124718);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302002,'BANGA','126302002',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302003,'BANGA','126302003',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302004,'BANGA','126302004',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302005,'BANGA','126302005',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302006,'BANGA','126302006',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302007,'BANGA','126302007',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302008,'BANGA','126302008',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302009,'BANGA','126302009',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302010,'BANGA','126302010',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302011,'BANGA','126302011',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302012,'BANGA','126302012',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302013,'BANGA','126302013',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302014,'BANGA','126302014',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302015,'BANGA','126302015',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302016,'BANGA','126302016',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302017,'BANGA','126302017',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302018,'BANGA','126302018',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302019,'BANGA','126302019',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302020,'BANGA','126302020',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302021,'BANGA','126302021',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302022,'BANGA','126302022',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126302024,'BANGA','126302024',126302);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303003,'GENERAL SANTOS CITY (DADIANGAS)','126303003',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303004,'GENERAL SANTOS CITY (DADIANGAS)','126303004',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303005,'GENERAL SANTOS CITY (DADIANGAS)','126303005',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303006,'GENERAL SANTOS CITY (DADIANGAS)','126303006',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303007,'GENERAL SANTOS CITY (DADIANGAS)','126303007',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303009,'GENERAL SANTOS CITY (DADIANGAS)','126303009',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303011,'GENERAL SANTOS CITY (DADIANGAS)','126303011',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303012,'GENERAL SANTOS CITY (DADIANGAS)','126303012',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303015,'GENERAL SANTOS CITY (DADIANGAS)','126303015',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303016,'GENERAL SANTOS CITY (DADIANGAS)','126303016',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303023,'GENERAL SANTOS CITY (DADIANGAS)','126303023',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303024,'GENERAL SANTOS CITY (DADIANGAS)','126303024',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303026,'GENERAL SANTOS CITY (DADIANGAS)','126303026',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303027,'GENERAL SANTOS CITY (DADIANGAS)','126303027',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303028,'GENERAL SANTOS CITY (DADIANGAS)','126303028',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303029,'GENERAL SANTOS CITY (DADIANGAS)','126303029',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303030,'GENERAL SANTOS CITY (DADIANGAS)','126303030',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303031,'GENERAL SANTOS CITY (DADIANGAS)','126303031',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303032,'GENERAL SANTOS CITY (DADIANGAS)','126303032',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303033,'GENERAL SANTOS CITY (DADIANGAS)','126303033',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303034,'GENERAL SANTOS CITY (DADIANGAS)','126303034',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303035,'GENERAL SANTOS CITY (DADIANGAS)','126303035',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303036,'GENERAL SANTOS CITY (DADIANGAS)','126303036',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303037,'GENERAL SANTOS CITY (DADIANGAS)','126303037',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303038,'GENERAL SANTOS CITY (DADIANGAS)','126303038',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126303039,'GENERAL SANTOS CITY (DADIANGAS)','126303039',126303);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306001,'CITY OF KORONADAL (Capital)','126306001',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306003,'CITY OF KORONADAL (Capital)','126306003',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306005,'CITY OF KORONADAL (Capital)','126306005',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306006,'CITY OF KORONADAL (Capital)','126306006',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306007,'CITY OF KORONADAL (Capital)','126306007',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306008,'CITY OF KORONADAL (Capital)','126306008',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306009,'CITY OF KORONADAL (Capital)','126306009',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306010,'CITY OF KORONADAL (Capital)','126306010',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306011,'CITY OF KORONADAL (Capital)','126306011',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306012,'CITY OF KORONADAL (Capital)','126306012',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306013,'CITY OF KORONADAL (Capital)','126306013',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306014,'CITY OF KORONADAL (Capital)','126306014',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306015,'CITY OF KORONADAL (Capital)','126306015',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306016,'CITY OF KORONADAL (Capital)','126306016',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306017,'CITY OF KORONADAL (Capital)','126306017',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306018,'CITY OF KORONADAL (Capital)','126306018',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306019,'CITY OF KORONADAL (Capital)','126306019',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306020,'CITY OF KORONADAL (Capital)','126306020',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306021,'CITY OF KORONADAL (Capital)','126306021',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306022,'CITY OF KORONADAL (Capital)','126306022',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306023,'CITY OF KORONADAL (Capital)','126306023',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306024,'CITY OF KORONADAL (Capital)','126306024',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306025,'CITY OF KORONADAL (Capital)','126306025',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306026,'CITY OF KORONADAL (Capital)','126306026',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126306027,'CITY OF KORONADAL (Capital)','126306027',126306);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311002,'NORALA','126311002',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311003,'NORALA','126311003',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311006,'NORALA','126311006',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311007,'NORALA','126311007',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311008,'NORALA','126311008',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311009,'NORALA','126311009',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311011,'NORALA','126311011',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311013,'NORALA','126311013',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311014,'NORALA','126311014',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311016,'NORALA','126311016',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311017,'NORALA','126311017',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311020,'NORALA','126311020',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311021,'NORALA','126311021',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126311022,'NORALA','126311022',126311);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312001,'POLOMOLOK','126312001',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312002,'POLOMOLOK','126312002',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312003,'POLOMOLOK','126312003',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312004,'POLOMOLOK','126312004',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312005,'POLOMOLOK','126312005',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312006,'POLOMOLOK','126312006',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312007,'POLOMOLOK','126312007',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312008,'POLOMOLOK','126312008',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312009,'POLOMOLOK','126312009',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312011,'POLOMOLOK','126312011',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312013,'POLOMOLOK','126312013',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312014,'POLOMOLOK','126312014',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312015,'POLOMOLOK','126312015',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312016,'POLOMOLOK','126312016',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312017,'POLOMOLOK','126312017',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312018,'POLOMOLOK','126312018',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312019,'POLOMOLOK','126312019',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312020,'POLOMOLOK','126312020',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312021,'POLOMOLOK','126312021',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312022,'POLOMOLOK','126312022',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312023,'POLOMOLOK','126312023',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312024,'POLOMOLOK','126312024',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126312025,'POLOMOLOK','126312025',126312);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313002,'SURALLAH','126313002',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313003,'SURALLAH','126313003',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313004,'SURALLAH','126313004',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313005,'SURALLAH','126313005',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313006,'SURALLAH','126313006',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313008,'SURALLAH','126313008',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313014,'SURALLAH','126313014',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313017,'SURALLAH','126313017',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313018,'SURALLAH','126313018',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313019,'SURALLAH','126313019',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313020,'SURALLAH','126313020',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313023,'SURALLAH','126313023',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313024,'SURALLAH','126313024',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313028,'SURALLAH','126313028',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313030,'SURALLAH','126313030',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313031,'SURALLAH','126313031',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126313032,'SURALLAH','126313032',126313);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314001,'TAMPAKAN','126314001',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314002,'TAMPAKAN','126314002',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314003,'TAMPAKAN','126314003',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314004,'TAMPAKAN','126314004',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314005,'TAMPAKAN','126314005',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314006,'TAMPAKAN','126314006',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314007,'TAMPAKAN','126314007',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314008,'TAMPAKAN','126314008',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314009,'TAMPAKAN','126314009',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314010,'TAMPAKAN','126314010',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314011,'TAMPAKAN','126314011',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314012,'TAMPAKAN','126314012',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314013,'TAMPAKAN','126314013',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126314014,'TAMPAKAN','126314014',126314);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315001,'TANTANGAN','126315001',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315002,'TANTANGAN','126315002',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315003,'TANTANGAN','126315003',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315004,'TANTANGAN','126315004',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315005,'TANTANGAN','126315005',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315006,'TANTANGAN','126315006',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315007,'TANTANGAN','126315007',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315008,'TANTANGAN','126315008',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315009,'TANTANGAN','126315009',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315010,'TANTANGAN','126315010',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315011,'TANTANGAN','126315011',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315012,'TANTANGAN','126315012',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126315013,'TANTANGAN','126315013',126315);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316001,'T`BOLI','126316001',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316002,'T`BOLI','126316002',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316004,'T`BOLI','126316004',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316005,'T`BOLI','126316005',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316008,'T`BOLI','126316008',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316011,'T`BOLI','126316011',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316012,'T`BOLI','126316012',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316014,'T`BOLI','126316014',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316016,'T`BOLI','126316016',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316017,'T`BOLI','126316017',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316018,'T`BOLI','126316018',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316019,'T`BOLI','126316019',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316020,'T`BOLI','126316020',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316021,'T`BOLI','126316021',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316022,'T`BOLI','126316022',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316023,'T`BOLI','126316023',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316024,'T`BOLI','126316024',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316025,'T`BOLI','126316025',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316026,'T`BOLI','126316026',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316027,'T`BOLI','126316027',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316028,'T`BOLI','126316028',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316029,'T`BOLI','126316029',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316030,'T`BOLI','126316030',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316031,'T`BOLI','126316031',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126316032,'T`BOLI','126316032',126316);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317001,'TUPI','126317001',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317002,'TUPI','126317002',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317003,'TUPI','126317003',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317004,'TUPI','126317004',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317005,'TUPI','126317005',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317006,'TUPI','126317006',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317007,'TUPI','126317007',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317009,'TUPI','126317009',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317010,'TUPI','126317010',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317011,'TUPI','126317011',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317012,'TUPI','126317012',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317013,'TUPI','126317013',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317014,'TUPI','126317014',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317015,'TUPI','126317015',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126317016,'TUPI','126317016',126317);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318001,'SANTO NIÑO','126318001',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318002,'SANTO NIÑO','126318002',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318003,'SANTO NIÑO','126318003',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318004,'SANTO NIÑO','126318004',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318005,'SANTO NIÑO','126318005',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318006,'SANTO NIÑO','126318006',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318007,'SANTO NIÑO','126318007',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318008,'SANTO NIÑO','126318008',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318009,'SANTO NIÑO','126318009',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126318010,'SANTO NIÑO','126318010',126318);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319001,'LAKE SEBU','126319001',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319002,'LAKE SEBU','126319002',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319003,'LAKE SEBU','126319003',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319004,'LAKE SEBU','126319004',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319005,'LAKE SEBU','126319005',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319006,'LAKE SEBU','126319006',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319007,'LAKE SEBU','126319007',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319008,'LAKE SEBU','126319008',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319009,'LAKE SEBU','126319009',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319010,'LAKE SEBU','126319010',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319011,'LAKE SEBU','126319011',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319012,'LAKE SEBU','126319012',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319013,'LAKE SEBU','126319013',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319014,'LAKE SEBU','126319014',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319015,'LAKE SEBU','126319015',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319016,'LAKE SEBU','126319016',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319017,'LAKE SEBU','126319017',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319018,'LAKE SEBU','126319018',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126319019,'LAKE SEBU','126319019',126319);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501001,'BAGUMBAYAN','126501001',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501002,'BAGUMBAYAN','126501002',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501003,'BAGUMBAYAN','126501003',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501004,'BAGUMBAYAN','126501004',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501005,'BAGUMBAYAN','126501005',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501006,'BAGUMBAYAN','126501006',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501008,'BAGUMBAYAN','126501008',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501009,'BAGUMBAYAN','126501009',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501010,'BAGUMBAYAN','126501010',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501011,'BAGUMBAYAN','126501011',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501012,'BAGUMBAYAN','126501012',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501013,'BAGUMBAYAN','126501013',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501014,'BAGUMBAYAN','126501014',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501015,'BAGUMBAYAN','126501015',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501016,'BAGUMBAYAN','126501016',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501017,'BAGUMBAYAN','126501017',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501018,'BAGUMBAYAN','126501018',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501019,'BAGUMBAYAN','126501019',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126501020,'BAGUMBAYAN','126501020',126501);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502002,'COLUMBIO','126502002',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502009,'COLUMBIO','126502009',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502010,'COLUMBIO','126502010',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502011,'COLUMBIO','126502011',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502015,'COLUMBIO','126502015',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502016,'COLUMBIO','126502016',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502017,'COLUMBIO','126502017',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502019,'COLUMBIO','126502019',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502021,'COLUMBIO','126502021',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502022,'COLUMBIO','126502022',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502023,'COLUMBIO','126502023',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502024,'COLUMBIO','126502024',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502027,'COLUMBIO','126502027',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502028,'COLUMBIO','126502028',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502030,'COLUMBIO','126502030',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126502032,'COLUMBIO','126502032',126502);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503001,'ESPERANZA','126503001',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503003,'ESPERANZA','126503003',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503005,'ESPERANZA','126503005',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503007,'ESPERANZA','126503007',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503008,'ESPERANZA','126503008',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503011,'ESPERANZA','126503011',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503016,'ESPERANZA','126503016',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503018,'ESPERANZA','126503018',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503020,'ESPERANZA','126503020',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503021,'ESPERANZA','126503021',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503022,'ESPERANZA','126503022',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503023,'ESPERANZA','126503023',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503024,'ESPERANZA','126503024',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503032,'ESPERANZA','126503032',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503033,'ESPERANZA','126503033',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503034,'ESPERANZA','126503034',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503035,'ESPERANZA','126503035',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503036,'ESPERANZA','126503036',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126503037,'ESPERANZA','126503037',126503);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504003,'ISULAN (Capital)','126504003',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504005,'ISULAN (Capital)','126504005',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504007,'ISULAN (Capital)','126504007',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504009,'ISULAN (Capital)','126504009',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504010,'ISULAN (Capital)','126504010',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504011,'ISULAN (Capital)','126504011',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504012,'ISULAN (Capital)','126504012',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504013,'ISULAN (Capital)','126504013',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504016,'ISULAN (Capital)','126504016',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504018,'ISULAN (Capital)','126504018',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504019,'ISULAN (Capital)','126504019',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504020,'ISULAN (Capital)','126504020',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504021,'ISULAN (Capital)','126504021',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504022,'ISULAN (Capital)','126504022',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504024,'ISULAN (Capital)','126504024',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504026,'ISULAN (Capital)','126504026',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126504028,'ISULAN (Capital)','126504028',126504);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505001,'KALAMANSIG','126505001',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505004,'KALAMANSIG','126505004',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505006,'KALAMANSIG','126505006',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505007,'KALAMANSIG','126505007',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505011,'KALAMANSIG','126505011',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505013,'KALAMANSIG','126505013',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505014,'KALAMANSIG','126505014',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505015,'KALAMANSIG','126505015',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505016,'KALAMANSIG','126505016',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505017,'KALAMANSIG','126505017',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505018,'KALAMANSIG','126505018',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505019,'KALAMANSIG','126505019',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505020,'KALAMANSIG','126505020',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505021,'KALAMANSIG','126505021',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126505022,'KALAMANSIG','126505022',126505);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506001,'LEBAK','126506001',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506003,'LEBAK','126506003',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506004,'LEBAK','126506004',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506005,'LEBAK','126506005',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506006,'LEBAK','126506006',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506007,'LEBAK','126506007',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506008,'LEBAK','126506008',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506009,'LEBAK','126506009',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506010,'LEBAK','126506010',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506012,'LEBAK','126506012',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506013,'LEBAK','126506013',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506014,'LEBAK','126506014',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506015,'LEBAK','126506015',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506016,'LEBAK','126506016',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506017,'LEBAK','126506017',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506018,'LEBAK','126506018',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506019,'LEBAK','126506019',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506020,'LEBAK','126506020',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506021,'LEBAK','126506021',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506022,'LEBAK','126506022',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506023,'LEBAK','126506023',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506024,'LEBAK','126506024',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506025,'LEBAK','126506025',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506026,'LEBAK','126506026',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506027,'LEBAK','126506027',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506028,'LEBAK','126506028',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126506029,'LEBAK','126506029',126506);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507001,'LUTAYAN','126507001',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507002,'LUTAYAN','126507002',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507003,'LUTAYAN','126507003',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507004,'LUTAYAN','126507004',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507005,'LUTAYAN','126507005',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507006,'LUTAYAN','126507006',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507007,'LUTAYAN','126507007',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507008,'LUTAYAN','126507008',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507009,'LUTAYAN','126507009',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507010,'LUTAYAN','126507010',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126507011,'LUTAYAN','126507011',126507);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508001,'LAMBAYONG (MARIANO MARCOS)','126508001',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508002,'LAMBAYONG (MARIANO MARCOS)','126508002',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508004,'LAMBAYONG (MARIANO MARCOS)','126508004',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508005,'LAMBAYONG (MARIANO MARCOS)','126508005',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508006,'LAMBAYONG (MARIANO MARCOS)','126508006',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508007,'LAMBAYONG (MARIANO MARCOS)','126508007',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508008,'LAMBAYONG (MARIANO MARCOS)','126508008',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508009,'LAMBAYONG (MARIANO MARCOS)','126508009',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508010,'LAMBAYONG (MARIANO MARCOS)','126508010',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508011,'LAMBAYONG (MARIANO MARCOS)','126508011',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508012,'LAMBAYONG (MARIANO MARCOS)','126508012',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508013,'LAMBAYONG (MARIANO MARCOS)','126508013',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508014,'LAMBAYONG (MARIANO MARCOS)','126508014',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508015,'LAMBAYONG (MARIANO MARCOS)','126508015',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508016,'LAMBAYONG (MARIANO MARCOS)','126508016',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508017,'LAMBAYONG (MARIANO MARCOS)','126508017',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508018,'LAMBAYONG (MARIANO MARCOS)','126508018',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508019,'LAMBAYONG (MARIANO MARCOS)','126508019',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508020,'LAMBAYONG (MARIANO MARCOS)','126508020',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508021,'LAMBAYONG (MARIANO MARCOS)','126508021',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508022,'LAMBAYONG (MARIANO MARCOS)','126508022',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508023,'LAMBAYONG (MARIANO MARCOS)','126508023',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508024,'LAMBAYONG (MARIANO MARCOS)','126508024',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508025,'LAMBAYONG (MARIANO MARCOS)','126508025',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508027,'LAMBAYONG (MARIANO MARCOS)','126508027',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126508028,'LAMBAYONG (MARIANO MARCOS)','126508028',126508);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509001,'PALIMBANG','126509001',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509002,'PALIMBANG','126509002',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509003,'PALIMBANG','126509003',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509004,'PALIMBANG','126509004',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509005,'PALIMBANG','126509005',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509006,'PALIMBANG','126509006',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509007,'PALIMBANG','126509007',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509009,'PALIMBANG','126509009',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509010,'PALIMBANG','126509010',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509011,'PALIMBANG','126509011',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509013,'PALIMBANG','126509013',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509014,'PALIMBANG','126509014',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509015,'PALIMBANG','126509015',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509016,'PALIMBANG','126509016',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509017,'PALIMBANG','126509017',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509018,'PALIMBANG','126509018',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509020,'PALIMBANG','126509020',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509021,'PALIMBANG','126509021',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509022,'PALIMBANG','126509022',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509023,'PALIMBANG','126509023',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509024,'PALIMBANG','126509024',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509025,'PALIMBANG','126509025',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509026,'PALIMBANG','126509026',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509027,'PALIMBANG','126509027',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509028,'PALIMBANG','126509028',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509029,'PALIMBANG','126509029',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509030,'PALIMBANG','126509030',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509031,'PALIMBANG','126509031',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509032,'PALIMBANG','126509032',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509033,'PALIMBANG','126509033',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509034,'PALIMBANG','126509034',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509035,'PALIMBANG','126509035',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509036,'PALIMBANG','126509036',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509038,'PALIMBANG','126509038',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509039,'PALIMBANG','126509039',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509040,'PALIMBANG','126509040',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509041,'PALIMBANG','126509041',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509042,'PALIMBANG','126509042',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509043,'PALIMBANG','126509043',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126509044,'PALIMBANG','126509044',126509);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510001,'PRESIDENT QUIRINO','126510001',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510003,'PRESIDENT QUIRINO','126510003',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510004,'PRESIDENT QUIRINO','126510004',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510005,'PRESIDENT QUIRINO','126510005',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510007,'PRESIDENT QUIRINO','126510007',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510008,'PRESIDENT QUIRINO','126510008',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510009,'PRESIDENT QUIRINO','126510009',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510012,'PRESIDENT QUIRINO','126510012',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510013,'PRESIDENT QUIRINO','126510013',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510014,'PRESIDENT QUIRINO','126510014',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510015,'PRESIDENT QUIRINO','126510015',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510016,'PRESIDENT QUIRINO','126510016',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510018,'PRESIDENT QUIRINO','126510018',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510020,'PRESIDENT QUIRINO','126510020',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510021,'PRESIDENT QUIRINO','126510021',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510022,'PRESIDENT QUIRINO','126510022',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510023,'PRESIDENT QUIRINO','126510023',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510025,'PRESIDENT QUIRINO','126510025',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126510026,'PRESIDENT QUIRINO','126510026',126510);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511001,'CITY OF TACURONG','126511001',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511002,'CITY OF TACURONG','126511002',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511003,'CITY OF TACURONG','126511003',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511004,'CITY OF TACURONG','126511004',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511005,'CITY OF TACURONG','126511005',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511006,'CITY OF TACURONG','126511006',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511007,'CITY OF TACURONG','126511007',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511008,'CITY OF TACURONG','126511008',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511010,'CITY OF TACURONG','126511010',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511011,'CITY OF TACURONG','126511011',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511012,'CITY OF TACURONG','126511012',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511013,'CITY OF TACURONG','126511013',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511014,'CITY OF TACURONG','126511014',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511015,'CITY OF TACURONG','126511015',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511016,'CITY OF TACURONG','126511016',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511019,'CITY OF TACURONG','126511019',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511020,'CITY OF TACURONG','126511020',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511021,'CITY OF TACURONG','126511021',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511022,'CITY OF TACURONG','126511022',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126511023,'CITY OF TACURONG','126511023',126511);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512001,'SEN. NINOY AQUINO','126512001',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512002,'SEN. NINOY AQUINO','126512002',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512003,'SEN. NINOY AQUINO','126512003',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512004,'SEN. NINOY AQUINO','126512004',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512005,'SEN. NINOY AQUINO','126512005',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512006,'SEN. NINOY AQUINO','126512006',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512007,'SEN. NINOY AQUINO','126512007',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512008,'SEN. NINOY AQUINO','126512008',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512009,'SEN. NINOY AQUINO','126512009',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512010,'SEN. NINOY AQUINO','126512010',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512011,'SEN. NINOY AQUINO','126512011',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512012,'SEN. NINOY AQUINO','126512012',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512013,'SEN. NINOY AQUINO','126512013',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512014,'SEN. NINOY AQUINO','126512014',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512015,'SEN. NINOY AQUINO','126512015',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512016,'SEN. NINOY AQUINO','126512016',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512017,'SEN. NINOY AQUINO','126512017',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512018,'SEN. NINOY AQUINO','126512018',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512019,'SEN. NINOY AQUINO','126512019',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (126512020,'SEN. NINOY AQUINO','126512020',126512);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001001,'ALABEL (Capital)','128001001',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001002,'ALABEL (Capital)','128001002',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001003,'ALABEL (Capital)','128001003',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001004,'ALABEL (Capital)','128001004',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001005,'ALABEL (Capital)','128001005',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001006,'ALABEL (Capital)','128001006',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001007,'ALABEL (Capital)','128001007',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001008,'ALABEL (Capital)','128001008',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001009,'ALABEL (Capital)','128001009',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001010,'ALABEL (Capital)','128001010',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001011,'ALABEL (Capital)','128001011',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001012,'ALABEL (Capital)','128001012',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128001013,'ALABEL (Capital)','128001013',128001);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002001,'GLAN','128002001',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002002,'GLAN','128002002',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002003,'GLAN','128002003',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002004,'GLAN','128002004',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002005,'GLAN','128002005',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002006,'GLAN','128002006',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002007,'GLAN','128002007',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002008,'GLAN','128002008',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002009,'GLAN','128002009',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002010,'GLAN','128002010',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002011,'GLAN','128002011',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002012,'GLAN','128002012',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002013,'GLAN','128002013',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002014,'GLAN','128002014',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002015,'GLAN','128002015',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002016,'GLAN','128002016',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002017,'GLAN','128002017',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002018,'GLAN','128002018',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002019,'GLAN','128002019',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002020,'GLAN','128002020',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002021,'GLAN','128002021',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002022,'GLAN','128002022',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002023,'GLAN','128002023',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002024,'GLAN','128002024',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002025,'GLAN','128002025',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002026,'GLAN','128002026',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002027,'GLAN','128002027',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002028,'GLAN','128002028',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002029,'GLAN','128002029',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002030,'GLAN','128002030',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128002031,'GLAN','128002031',128002);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003001,'KIAMBA','128003001',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003002,'KIAMBA','128003002',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003003,'KIAMBA','128003003',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003004,'KIAMBA','128003004',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003005,'KIAMBA','128003005',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003006,'KIAMBA','128003006',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003007,'KIAMBA','128003007',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003008,'KIAMBA','128003008',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003009,'KIAMBA','128003009',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003010,'KIAMBA','128003010',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003011,'KIAMBA','128003011',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003012,'KIAMBA','128003012',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003013,'KIAMBA','128003013',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003014,'KIAMBA','128003014',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003015,'KIAMBA','128003015',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003016,'KIAMBA','128003016',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003017,'KIAMBA','128003017',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003018,'KIAMBA','128003018',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128003019,'KIAMBA','128003019',128003);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004001,'MAASIM','128004001',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004002,'MAASIM','128004002',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004003,'MAASIM','128004003',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004004,'MAASIM','128004004',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004005,'MAASIM','128004005',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004006,'MAASIM','128004006',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004007,'MAASIM','128004007',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004008,'MAASIM','128004008',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004009,'MAASIM','128004009',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004010,'MAASIM','128004010',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004011,'MAASIM','128004011',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004012,'MAASIM','128004012',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004013,'MAASIM','128004013',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004014,'MAASIM','128004014',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004015,'MAASIM','128004015',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128004016,'MAASIM','128004016',128004);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005001,'MAITUM','128005001',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005002,'MAITUM','128005002',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005003,'MAITUM','128005003',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005004,'MAITUM','128005004',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005005,'MAITUM','128005005',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005006,'MAITUM','128005006',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005007,'MAITUM','128005007',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005008,'MAITUM','128005008',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005009,'MAITUM','128005009',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005010,'MAITUM','128005010',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005011,'MAITUM','128005011',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005012,'MAITUM','128005012',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005013,'MAITUM','128005013',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005014,'MAITUM','128005014',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005015,'MAITUM','128005015',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005016,'MAITUM','128005016',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005017,'MAITUM','128005017',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005018,'MAITUM','128005018',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128005019,'MAITUM','128005019',128005);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006001,'MALAPATAN','128006001',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006002,'MALAPATAN','128006002',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006003,'MALAPATAN','128006003',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006004,'MALAPATAN','128006004',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006005,'MALAPATAN','128006005',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006006,'MALAPATAN','128006006',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006007,'MALAPATAN','128006007',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006008,'MALAPATAN','128006008',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006009,'MALAPATAN','128006009',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006010,'MALAPATAN','128006010',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006011,'MALAPATAN','128006011',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128006012,'MALAPATAN','128006012',128006);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007001,'MALUNGON','128007001',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007002,'MALUNGON','128007002',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007003,'MALUNGON','128007003',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007004,'MALUNGON','128007004',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007005,'MALUNGON','128007005',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007006,'MALUNGON','128007006',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007007,'MALUNGON','128007007',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007008,'MALUNGON','128007008',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007009,'MALUNGON','128007009',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007010,'MALUNGON','128007010',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007011,'MALUNGON','128007011',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007012,'MALUNGON','128007012',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007013,'MALUNGON','128007013',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007014,'MALUNGON','128007014',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007015,'MALUNGON','128007015',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007016,'MALUNGON','128007016',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007017,'MALUNGON','128007017',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007018,'MALUNGON','128007018',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007019,'MALUNGON','128007019',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007020,'MALUNGON','128007020',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007021,'MALUNGON','128007021',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007022,'MALUNGON','128007022',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007023,'MALUNGON','128007023',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007024,'MALUNGON','128007024',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007025,'MALUNGON','128007025',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007026,'MALUNGON','128007026',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007027,'MALUNGON','128007027',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007028,'MALUNGON','128007028',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007029,'MALUNGON','128007029',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007030,'MALUNGON','128007030',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (128007031,'MALUNGON','128007031',128007);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804001,'COTABATO CITY','129804001',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804002,'COTABATO CITY','129804002',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804003,'COTABATO CITY','129804003',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804004,'COTABATO CITY','129804004',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804005,'COTABATO CITY','129804005',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804006,'COTABATO CITY','129804006',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804007,'COTABATO CITY','129804007',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804008,'COTABATO CITY','129804008',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804009,'COTABATO CITY','129804009',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804010,'COTABATO CITY','129804010',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804011,'COTABATO CITY','129804011',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804012,'COTABATO CITY','129804012',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804013,'COTABATO CITY','129804013',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804014,'COTABATO CITY','129804014',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804015,'COTABATO CITY','129804015',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804016,'COTABATO CITY','129804016',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804017,'COTABATO CITY','129804017',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804018,'COTABATO CITY','129804018',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804019,'COTABATO CITY','129804019',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804020,'COTABATO CITY','129804020',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804021,'COTABATO CITY','129804021',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804022,'COTABATO CITY','129804022',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804023,'COTABATO CITY','129804023',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804024,'COTABATO CITY','129804024',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804025,'COTABATO CITY','129804025',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804026,'COTABATO CITY','129804026',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804027,'COTABATO CITY','129804027',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804028,'COTABATO CITY','129804028',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804029,'COTABATO CITY','129804029',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804030,'COTABATO CITY','129804030',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804031,'COTABATO CITY','129804031',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804032,'COTABATO CITY','129804032',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804033,'COTABATO CITY','129804033',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804034,'COTABATO CITY','129804034',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804035,'COTABATO CITY','129804035',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804036,'COTABATO CITY','129804036',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (129804037,'COTABATO CITY','129804037',129804);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617001,'MARAWI CITY (Capital)','153617001',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617003,'MARAWI CITY (Capital)','153617003',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617006,'MARAWI CITY (Capital)','153617006',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617007,'MARAWI CITY (Capital)','153617007',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617008,'MARAWI CITY (Capital)','153617008',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617009,'MARAWI CITY (Capital)','153617009',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617010,'MARAWI CITY (Capital)','153617010',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617012,'MARAWI CITY (Capital)','153617012',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617013,'MARAWI CITY (Capital)','153617013',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617014,'MARAWI CITY (Capital)','153617014',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617015,'MARAWI CITY (Capital)','153617015',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617016,'MARAWI CITY (Capital)','153617016',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617017,'MARAWI CITY (Capital)','153617017',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617019,'MARAWI CITY (Capital)','153617019',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617021,'MARAWI CITY (Capital)','153617021',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617022,'MARAWI CITY (Capital)','153617022',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617023,'MARAWI CITY (Capital)','153617023',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617024,'MARAWI CITY (Capital)','153617024',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617025,'MARAWI CITY (Capital)','153617025',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617026,'MARAWI CITY (Capital)','153617026',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617027,'MARAWI CITY (Capital)','153617027',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617029,'MARAWI CITY (Capital)','153617029',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617030,'MARAWI CITY (Capital)','153617030',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617032,'MARAWI CITY (Capital)','153617032',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617033,'MARAWI CITY (Capital)','153617033',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617035,'MARAWI CITY (Capital)','153617035',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617036,'MARAWI CITY (Capital)','153617036',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617037,'MARAWI CITY (Capital)','153617037',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617039,'MARAWI CITY (Capital)','153617039',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617040,'MARAWI CITY (Capital)','153617040',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617042,'MARAWI CITY (Capital)','153617042',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617043,'MARAWI CITY (Capital)','153617043',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617044,'MARAWI CITY (Capital)','153617044',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617045,'MARAWI CITY (Capital)','153617045',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617046,'MARAWI CITY (Capital)','153617046',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617048,'MARAWI CITY (Capital)','153617048',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617049,'MARAWI CITY (Capital)','153617049',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617051,'MARAWI CITY (Capital)','153617051',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617052,'MARAWI CITY (Capital)','153617052',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617057,'MARAWI CITY (Capital)','153617057',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617058,'MARAWI CITY (Capital)','153617058',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617060,'MARAWI CITY (Capital)','153617060',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617062,'MARAWI CITY (Capital)','153617062',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617063,'MARAWI CITY (Capital)','153617063',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617064,'MARAWI CITY (Capital)','153617064',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617065,'MARAWI CITY (Capital)','153617065',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617066,'MARAWI CITY (Capital)','153617066',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617068,'MARAWI CITY (Capital)','153617068',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617069,'MARAWI CITY (Capital)','153617069',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617070,'MARAWI CITY (Capital)','153617070',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617071,'MARAWI CITY (Capital)','153617071',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617072,'MARAWI CITY (Capital)','153617072',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617074,'MARAWI CITY (Capital)','153617074',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617075,'MARAWI CITY (Capital)','153617075',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617076,'MARAWI CITY (Capital)','153617076',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617077,'MARAWI CITY (Capital)','153617077',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617079,'MARAWI CITY (Capital)','153617079',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617080,'MARAWI CITY (Capital)','153617080',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617083,'MARAWI CITY (Capital)','153617083',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617085,'MARAWI CITY (Capital)','153617085',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617086,'MARAWI CITY (Capital)','153617086',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617089,'MARAWI CITY (Capital)','153617089',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617090,'MARAWI CITY (Capital)','153617090',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617097,'MARAWI CITY (Capital)','153617097',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617098,'MARAWI CITY (Capital)','153617098',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617099,'MARAWI CITY (Capital)','153617099',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617101,'MARAWI CITY (Capital)','153617101',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617103,'MARAWI CITY (Capital)','153617103',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617105,'MARAWI CITY (Capital)','153617105',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617107,'MARAWI CITY (Capital)','153617107',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617109,'MARAWI CITY (Capital)','153617109',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617110,'MARAWI CITY (Capital)','153617110',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617111,'MARAWI CITY (Capital)','153617111',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617112,'MARAWI CITY (Capital)','153617112',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617113,'MARAWI CITY (Capital)','153617113',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617116,'MARAWI CITY (Capital)','153617116',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617117,'MARAWI CITY (Capital)','153617117',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617118,'MARAWI CITY (Capital)','153617118',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617119,'MARAWI CITY (Capital)','153617119',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617120,'MARAWI CITY (Capital)','153617120',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617123,'MARAWI CITY (Capital)','153617123',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617124,'MARAWI CITY (Capital)','153617124',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617125,'MARAWI CITY (Capital)','153617125',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617126,'MARAWI CITY (Capital)','153617126',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617127,'MARAWI CITY (Capital)','153617127',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617129,'MARAWI CITY (Capital)','153617129',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617131,'MARAWI CITY (Capital)','153617131',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617133,'MARAWI CITY (Capital)','153617133',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617134,'MARAWI CITY (Capital)','153617134',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617136,'MARAWI CITY (Capital)','153617136',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617137,'MARAWI CITY (Capital)','153617137',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617138,'MARAWI CITY (Capital)','153617138',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617139,'MARAWI CITY (Capital)','153617139',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617141,'MARAWI CITY (Capital)','153617141',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617142,'MARAWI CITY (Capital)','153617142',153617);
insert  into `tbl_barangay`(`id`,`name`,`code`,`municipality_id`) values (153617143,'MARAWI CITY (Capital)','153617143',153617);

/*Table structure for table `tbl_employee` */

CREATE TABLE `tbl_employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `emp_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `name_exit` varchar(100) DEFAULT NULL,
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

/*Table structure for table `tbl_municipality` */

CREATE TABLE `tbl_municipality` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(20) NOT NULL,
  `province_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `tbl_municipality_province_id_2a378538_fk_tbl_province_id` (`province_id`),
  CONSTRAINT `tbl_municipality_province_id_2a378538_fk_tbl_province_id` FOREIGN KEY (`province_id`) REFERENCES `tbl_province` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153618 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_municipality` */

insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124701,'ALAMADA','124701000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124702,'CARMEN','124702000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124703,'KABACAN','124703000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124704,'CITY OF KIDAPAWAN (Capital)','124704000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124705,'LIBUNGAN','124705000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124706,'MAGPET','124706000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124707,'MAKILALA','124707000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124708,'MATALAM','124708000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124709,'MIDSAYAP','124709000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124710,'MLANG','124710000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124711,'PIGKAWAYAN','124711000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124712,'PIKIT','124712000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124713,'PRESIDENT ROXAS','124713000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124714,'TULUNAN','124714000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124715,'ANTIPAS','124715000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124716,'BANISILAN','124716000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124717,'ALEOSAN','124717000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (124718,'ARAKAN','124718000',1247);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126302,'BANGA','126302000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126303,'GENERAL SANTOS CITY (DADIANGAS)','126303000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126306,'CITY OF KORONADAL (Capital)','126306000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126311,'NORALA','126311000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126312,'POLOMOLOK','126312000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126313,'SURALLAH','126313000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126314,'TAMPAKAN','126314000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126315,'TANTANGAN','126315000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126316,'T`BOLI','126316000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126317,'TUPI','126317000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126318,'SANTO NIÑO','126318000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126319,'LAKE SEBU','126319000',1263);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126501,'BAGUMBAYAN','126501000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126502,'COLUMBIO','126502000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126503,'ESPERANZA','126503000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126504,'ISULAN (Capital)','126504000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126505,'KALAMANSIG','126505000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126506,'LEBAK','126506000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126507,'LUTAYAN','126507000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126508,'LAMBAYONG (MARIANO MARCOS)','126508000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126509,'PALIMBANG','126509000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126510,'PRESIDENT QUIRINO','126510000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126511,'CITY OF TACURONG','126511000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (126512,'SEN. NINOY AQUINO','126512000',1265);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128001,'ALABEL (Capital)','128001000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128002,'GLAN','128002000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128003,'KIAMBA','128003000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128004,'MAASIM','128004000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128005,'MAITUM','128005000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128006,'MALAPATAN','128006000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (128007,'MALUNGON','128007000',1280);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (129804,'COTABATO CITY','129804000',1298);
insert  into `tbl_municipality`(`id`,`name`,`code`,`province_id`) values (153617,'MARAWI CITY (Capital)','153617000',1536);

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
  `name` varchar(255) NOT NULL,
  `code` varchar(20) NOT NULL,
  `region_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`),
  KEY `tbl_province_region_id_7012f71a_fk_tbl_region_id` (`region_id`),
  CONSTRAINT `tbl_province_region_id_7012f71a_fk_tbl_region_id` FOREIGN KEY (`region_id`) REFERENCES `tbl_region` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_province` */

insert  into `tbl_province`(`id`,`name`,`code`,`region_id`) values (1247,'COTABATO (NORTH COTABATO)','124700000',12);
insert  into `tbl_province`(`id`,`name`,`code`,`region_id`) values (1263,'SOUTH COTABATO','126300000',12);
insert  into `tbl_province`(`id`,`name`,`code`,`region_id`) values (1265,'SULTAN KUDARAT','126500000',12);
insert  into `tbl_province`(`id`,`name`,`code`,`region_id`) values (1280,'SARANGANI','128000000',12);

/*Table structure for table `tbl_region` */

CREATE TABLE `tbl_region` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tbl_region` */

insert  into `tbl_region`(`id`,`name`,`code`) values (12,'REGION XII [Soccsksargen]','120000000');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
