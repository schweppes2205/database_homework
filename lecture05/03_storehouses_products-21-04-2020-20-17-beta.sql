-- Generation time: Tue, 21 Apr 2020 20:17:26 +0000
-- Host: mysql.hostinger.ro
-- DB name: u574849695_23
/*!40030 SET NAMES UTF8 */;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `storehouses_products`;
CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` VALUES ('1','9','0','0','1978-04-23 16:36:03','1980-08-03 11:43:46'),
('2','0','4','0','2009-06-05 10:03:54','1976-08-20 17:16:15'),
('3','8','7','0','1983-02-16 04:01:42','1993-08-10 00:15:56'),
('4','8','7','0','1998-09-05 01:05:43','1979-01-28 05:25:11'),
('5','0','4','0','1975-06-28 03:22:29','1978-01-04 12:47:51'),
('6','4','9','0','2017-01-27 12:43:54','2003-08-01 04:33:11'),
('7','0','2','0','1987-05-23 19:51:34','1984-12-26 16:52:00'),
('8','7','1','0','1981-11-04 01:23:33','2005-09-13 10:00:52'),
('9','5','5','0','1981-08-24 22:52:43','1976-01-13 01:21:50'),
('10','5','0','0','1980-08-27 07:37:51','2010-06-09 14:35:39'),
('11','1','2','0','1994-03-12 04:32:08','1985-01-05 13:59:27'),
('12','0','5','699','2013-04-15 05:40:43','2016-03-11 23:14:52'),
('13','5','7','666','2019-05-08 04:41:39','2003-01-18 08:04:58'),
('14','8','1','562','2000-05-21 19:36:25','1980-12-11 08:13:51'),
('15','2','2','169','1979-01-25 01:10:39','1970-01-21 09:57:29'),
('16','3','5','201','2012-05-15 21:25:18','2019-09-23 02:05:40'),
('17','7','2','671','2007-08-08 20:22:28','2002-11-24 07:39:04'),
('18','0','3','389','1973-10-12 00:03:34','1975-05-31 19:00:04'),
('19','4','3','516','2012-02-22 22:07:01','2014-09-25 20:32:44'),
('20','7','6','599','1979-02-02 04:35:44','1990-07-18 10:58:07'),
('21','3','2','765','1987-08-25 08:30:57','1977-07-17 10:18:44'),
('22','6','9','719','2015-12-02 07:43:33','1999-04-12 16:19:28'),
('23','4','6','636','1986-09-28 20:56:46','1975-05-18 06:48:55'),
('24','3','5','359','2001-02-09 09:34:06','1984-05-19 09:00:08'),
('25','9','5','225','2005-12-11 05:36:06','1996-05-25 05:35:35'),
('26','9','0','907','1983-04-06 07:15:56','1985-04-23 14:42:42'),
('27','1','2','110','2019-01-15 22:43:03','1984-11-22 22:20:08'),
('100','8','4','490','1995-09-02 16:10:21','2005-09-11 03:40:54'); 




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

