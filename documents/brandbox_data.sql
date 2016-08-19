-- MySQL dump 10.15  Distrib 10.0.20-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: brandbox
-- ------------------------------------------------------
-- Server version	10.0.20-MariaDB

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
-- Table structure for table `codeTbl`
--

DROP TABLE IF EXISTS `codeTbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codeTbl` (
  `gCode` varchar(50) NOT NULL COMMENT '그룹코드',
  `key` varchar(50) NOT NULL COMMENT '키',
  `sortOrder` int(11) DEFAULT NULL COMMENT '정렬순서',
  `description` varchar(500) DEFAULT NULL COMMENT '설명',
  PRIMARY KEY (`gCode`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='코드테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codeTbl`
--

LOCK TABLES `codeTbl` WRITE;
/*!40000 ALTER TABLE `codeTbl` DISABLE KEYS */;
INSERT INTO `codeTbl` VALUES ('admReq.kind','A',1,'신규'),('admReq.kind','B',2,'변경'),('admReq.result','A',1,'요청중'),('admReq.result','B',2,'검토중'),('admReq.result','C',3,'승인'),('admReq.result','D',4,'반려'),('adType','A',1,'검색'),('adType','B',2,'매칭'),('alarm.openYn','A',1,'네'),('alarm.openYn','B',2,'아니요'),('anal_weight','article',2,'0.5'),('anal_weight','product',1,'0.8'),('anal_weight','query',3,'0.9'),('anal_weight','referer',4,'0.3'),('fill.fillType','A',1,'카드'),('fill.fillType','B',2,'무통장'),('fill.fillYn','N',2,'아니요'),('fill.fillYn','Y',1,'네'),('keyword.status','A',1,'활성'),('keyword.status','B',1,'비활성'),('kw2.kind','A',1,'브랜드'),('kw2.kind','B',2,'분류'),('member.kind','A',1,'광고주'),('member.kind','B',2,'매체'),('member.kind','C',3,'관리자'),('member.status','A',1,'활성'),('member.status','B',2,'비활성'),('pointLog.A','A',1,'카드'),('pointLog.A','B',2,'무통장'),('pointLog.A','C',3,'관리자'),('pointLog.B','A',1,'환불'),('pointLog.B','B',2,'광고집행'),('pointLog.B','C',3,'관리자'),('pointLog.gubun','A',1,'입금'),('pointLog.gubun','B',2,'출금'),('pointLog.kind','A',1,'카드'),('pointLog.kind','B',2,'무통장'),('pointLog.kind','C',3,'보너스'),('pointLog.kind','D',4,'관리자삭감'),('pointSave.saveType','A',1,'카드'),('pointSave.saveType','B',2,'무통장'),('pointSave.saveType','C',3,'관리자'),('pointType','A',1,'예치금'),('pointType','B',2,'보너스');
/*!40000 ALTER TABLE `codeTbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-18 14:15:58
