/*
SQLyog Enterprise - MySQL GUI v8.18 
MySQL - 5.1.61-0ubuntu0.10.10.1 : Database - twitter_evaluation
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `relationships` */

DROP TABLE IF EXISTS `relationships`;

CREATE TABLE `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `following_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `relationships` */

insert  into `relationships`(`id`,`user_id`,`following_id`) values (1,1,2),(2,1,3),(3,1,5),(4,1,9),(5,1,10),(6,6,7),(7,7,6),(8,5,1),(9,5,2),(10,5,10),(11,9,1),(12,9,2),(13,9,3),(14,9,4),(15,9,5),(16,9,6),(17,9,7),(18,9,8),(19,9,10);

/*Table structure for table `tweets` */

DROP TABLE IF EXISTS `tweets`;

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(140) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `tweets` */

insert  into `tweets`(`id`,`user_id`,`content`,`type`,`created_at`) values (1,1,'My first ever tweet.',NULL,'2012-08-07 12:52:11'),(2,2,'Test tweet.',NULL,'2012-08-07 12:52:38'),(3,2,'Hello there',NULL,'2012-08-07 12:52:46'),(4,1,'lorem ipsum',NULL,'2012-08-07 12:53:01'),(5,10,'Lets test this...',NULL,'2012-08-07 12:53:18'),(6,5,'I am at vinsol',NULL,'2012-08-07 12:53:59'),(7,9,'Nokis is a nice mobile company',NULL,'2012-08-07 12:54:20'),(8,6,'Its Nokia not Nokis',NULL,'2012-08-07 12:54:36'),(9,9,'Thanks for letting me know',NULL,'2012-08-07 12:54:51'),(10,2,'Stop playing twitter twitter, focus on your job',NULL,'2012-08-07 12:55:46'),(11,7,'Ops.. you caught us',NULL,'2012-08-07 12:57:15'),(12,7,'Btw, what is the score',NULL,'2012-08-07 12:57:27'),(13,1,'Its raining',NULL,'2012-08-07 12:57:43'),(14,4,'really?',NULL,'2012-08-07 12:57:56'),(15,8,'I think we now have enough deta to write queries.',NULL,'2012-08-07 12:58:48');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`id`,`name`) values (1,'Akhil'),(2,'Manik'),(3,'Amit'),(4,'Rahul'),(5,'Kapil'),(6,'John'),(7,'Ryan'),(8,'Sunil'),(9,'Ankur'),(10,'Suman');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
