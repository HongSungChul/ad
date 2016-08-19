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
-- Table structure for table `adInfo`
--

DROP TABLE IF EXISTS `adInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adInfo` (
  `adInfoSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '광고정보번호',
  `memberSq` int(11) DEFAULT NULL COMMENT '회원번호',
  `imgUri` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '이미지 uri',
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '제목',
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '설명',
  `link` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '링크',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`adInfoSq`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adProfit`
--

DROP TABLE IF EXISTS `adProfit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adProfit` (
  `adUnitSq` int(11) NOT NULL COMMENT '광고단위번호',
  `profitDate` varchar(8) COLLATE utf8_unicode_ci NOT NULL COMMENT '날짜',
  `memberSq` int(11) NOT NULL COMMENT '회원코드',
  `point` decimal(10,0) DEFAULT '0' COMMENT '금액',
  `viewCount` int(11) DEFAULT '0' COMMENT '노출수',
  `clickCount` int(11) DEFAULT '0' COMMENT '클릭수',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`adUnitSq`,`profitDate`),
  KEY `index2` (`memberSq`,`profitDate`,`adUnitSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고단위매출';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adUnit`
--

DROP TABLE IF EXISTS `adUnit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adUnit` (
  `adUnitSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '광고단위번호',
  `serviceSq` int(11) NOT NULL COMMENT '서비스번호',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '이름',
  `memberSq` int(11) unsigned NOT NULL COMMENT '회원번호',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `adType` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'AdType(A:pc,B:mobile web)',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '상태(활성/비활성)',
  `viewType` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '보여지기형태(A:이미지형,B:리스트형)',
  PRIMARY KEY (`adUnitSq`),
  UNIQUE KEY `index2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고단위';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adUse`
--

DROP TABLE IF EXISTS `adUse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adUse` (
  `adUseSq` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '광고비사용번호',
  `point` int(11) DEFAULT NULL COMMENT '포인트',
  `pointType` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '출처',
  `memberSq` int(11) DEFAULT NULL COMMENT '광고물생성자',
  `admSq` int(11) DEFAULT NULL COMMENT '광고물',
  `kw1Sq` int(11) DEFAULT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) DEFAULT NULL COMMENT '2차키워드',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`adUseSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고비사용내역';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adm`
--

DROP TABLE IF EXISTS `adm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adm` (
  `admSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '광고물번호',
  `alias` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '별칭',
  `imgUri` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '이미지',
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '제목',
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '설명',
  `link` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '링크',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '상태(활성/비활성)',
  PRIMARY KEY (`admSq`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admCost`
--

DROP TABLE IF EXISTS `admCost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admCost` (
  `admSq` int(11) NOT NULL COMMENT '광고물번호',
  `costDate` varchar(8) COLLATE utf8_unicode_ci NOT NULL COMMENT '날짜',
  `cost` decimal(10,0) DEFAULT NULL COMMENT '비용',
  `viewCount` int(11) DEFAULT NULL COMMENT '노출수',
  `clickCount` int(11) DEFAULT NULL COMMENT '클릭수',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `memberSq` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`admSq`,`costDate`),
  KEY `index2` (`memberSq`,`costDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물집행비용';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admKw`
--

DROP TABLE IF EXISTS `admKw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admKw` (
  `admSq` int(11) NOT NULL COMMENT '광고물일련번호',
  `kw1Sq` int(11) NOT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) NOT NULL COMMENT '2차키워드',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  PRIMARY KEY (`admSq`,`kw1Sq`,`kw2Sq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물요청키워드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admReq`
--

DROP TABLE IF EXISTS `admReq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admReq` (
  `admReqSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '광고물번호',
  `imgUri` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '이미지',
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '제목',
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '설명',
  `link` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT 'f링크',
  `kind` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A' COMMENT '요청구분(adm_req.kind)',
  `result` varchar(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'A' COMMENT '승인결과(adm_req.result)',
  `backWhy` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '반려사유',
  `memberSq` int(11) DEFAULT NULL COMMENT '회원번호',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `admSq` int(11) DEFAULT NULL COMMENT '광고물번호(변경신청시에 필요)',
  PRIMARY KEY (`admReqSq`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물요청';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admReqKw`
--

DROP TABLE IF EXISTS `admReqKw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admReqKw` (
  `admReqSq` int(11) NOT NULL COMMENT '광고물요청일련번호',
  `kw1Sq` int(11) NOT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) NOT NULL COMMENT '2차키워드',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  PRIMARY KEY (`admReqSq`,`kw1Sq`,`kw2Sq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물요청키워드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `advertising`
--

DROP TABLE IF EXISTS `advertising`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advertising` (
  `admSq` int(11) NOT NULL COMMENT '광고물번호',
  `kw1Sq` int(11) NOT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) NOT NULL COMMENT '2차키워드',
  `point` int(11) NOT NULL COMMENT '낙참금액',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `sortOrder` int(11) DEFAULT NULL COMMENT '정열순서',
  `imgUri` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '이미지',
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '제목',
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '설명',
  `link` varchar(200) COLLATE utf8_unicode_ci NOT NULL COMMENT '링크',
  `kw1Name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '1차키워드명',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `kw2Name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '2차키워드명',
  `price` int(11) DEFAULT NULL,
  `kind` varchar(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '광고종류(kw2.kind) 브랜드/분류',
  PRIMARY KEY (`admSq`,`kw1Sq`,`kw2Sq`),
  KEY `index2` (`kw1Name`,`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고집행';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alarm`
--

DROP TABLE IF EXISTS `alarm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alarm` (
  `alarmSq` int(11) NOT NULL COMMENT '알림번호',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `openYn` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'N' COMMENT '조회여부',
  `content` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '내용',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`alarmSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='알림';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bidding`
--

DROP TABLE IF EXISTS `bidding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bidding` (
  `admSq` int(11) NOT NULL COMMENT '광고물번호',
  `kw1Sq` int(11) NOT NULL COMMENT '1차키워드번호',
  `kw2Sq` int(11) NOT NULL COMMENT '2차키워드번호',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `point` int(11) NOT NULL DEFAULT '40' COMMENT '입찰금액',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`admSq`,`kw1Sq`,`kw2Sq`,`memberSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='입찰';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cg1`
--

DROP TABLE IF EXISTS `cg1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cg1` (
  `cg1Sq` int(11) NOT NULL AUTO_INCREMENT COMMENT '고유번호',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '이름',
  `sortOrder` int(11) DEFAULT '0' COMMENT '정열순서',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'B' COMMENT '상태(keyword.status)',
  PRIMARY KEY (`cg1Sq`),
  UNIQUE KEY `index2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='1차카테고리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cg2`
--

DROP TABLE IF EXISTS `cg2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cg2` (
  `cg2Sq` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '상태(keyword.status)',
  `sortOrder` int(11) DEFAULT '0',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'B',
  `cg1Sq` int(11) DEFAULT NULL,
  PRIMARY KEY (`cg2Sq`),
  UNIQUE KEY `index2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `click`
--

DROP TABLE IF EXISTS `click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `click` (
  `clickSq` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '클릭번호',
  `kw1Sq` int(11) DEFAULT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) DEFAULT NULL COMMENT '2차키워드',
  `admSq` int(11) DEFAULT NULL COMMENT '광고물번호',
  `adUnitSq` int(11) DEFAULT NULL COMMENT '광고단위번호',
  `point` int(11) DEFAULT NULL COMMENT '번호',
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '아이피',
  `referer` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '레퍼러',
  `regDate` datetime DEFAULT NULL COMMENT '등록일',
  `check` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '검증(안함/유효/무효)',
  `requestSq` bigint(20) DEFAULT NULL,
  `adUid` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '사용자유니크아이디',
  PRIMARY KEY (`clickSq`),
  KEY `index2` (`admSq`,`kw1Sq`,`kw2Sq`,`ip`,`regDate`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='클릭내역';
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `contentsClick`
--

DROP TABLE IF EXISTS `contentsClick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contentsClick` (
  `contentsClickSq` bigint(20) NOT NULL COMMENT '컨텐츠클릭일련번호',
  `adUid` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '사용자고유번호',
  `title` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '타이틀',
  `url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '상품상세정보/기사내용 url',
  `regDate` datetime DEFAULT NULL,
  `kind` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '기사/상품 - 종류',
  PRIMARY KEY (`contentsClickSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='사용자컨텐츠클릭정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailyAc`
--

DROP TABLE IF EXISTS `dailyAc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailyAc` (
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `collDate` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT '수집일',
  `clickCnt` int(11) unsigned DEFAULT NULL COMMENT '클릭수',
  `validCnt` int(11) unsigned DEFAULT NULL COMMENT '유효클릭수',
  `invalidCnt` int(11) unsigned DEFAULT NULL COMMENT '무효클릭수',
  `reqCnt` int(11) unsigned DEFAULT NULL COMMENT '요청수',
  `viewCnt` int(11) unsigned DEFAULT NULL COMMENT '노출수',
  `avgPrice` int(11) unsigned DEFAULT NULL COMMENT '평단가',
  `sales` int(11) unsigned DEFAULT NULL COMMENT '집행금액',
  `admSq` int(11) NOT NULL COMMENT '광고물번호',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `prevPoint` int(10) unsigned DEFAULT NULL COMMENT '이월금액 - 정확치 않음',
  `point` int(10) unsigned DEFAULT NULL COMMENT '집행금액',
  PRIMARY KEY (`collDate`,`memberSq`,`admSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고물별 일일정산';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailyKw`
--

DROP TABLE IF EXISTS `dailyKw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailyKw` (
  `kw1Sq` int(11) NOT NULL,
  `collDate` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `clickCnt` int(10) unsigned DEFAULT NULL,
  `validCnt` int(10) unsigned DEFAULT NULL,
  `invalidCnt` int(10) unsigned DEFAULT NULL,
  `reqCnt` int(10) unsigned DEFAULT NULL,
  `viewCnt` int(10) unsigned DEFAULT NULL,
  `avgPrice` int(10) unsigned DEFAULT NULL,
  `sales` int(10) unsigned DEFAULT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `advertiserCnt` int(11) DEFAULT NULL COMMENT '광고주수',
  `kw1Name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`kw1Sq`,`collDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='1차키워드별일일정산';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailyMc`
--

DROP TABLE IF EXISTS `dailyMc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailyMc` (
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `collDate` varchar(10) COLLATE utf8_unicode_ci NOT NULL COMMENT '수집일',
  `clickCnt` int(10) unsigned DEFAULT NULL COMMENT '클릭수',
  `validCnt` int(10) unsigned DEFAULT NULL COMMENT '유효수',
  `invalidCnt` int(10) unsigned DEFAULT NULL COMMENT '무효수',
  `reqCnt` int(10) unsigned DEFAULT NULL COMMENT '요청수',
  `viewCnt` int(10) unsigned DEFAULT NULL COMMENT '노출수',
  `avgPrice` int(10) unsigned DEFAULT NULL COMMENT '평단가',
  `sales` int(10) unsigned DEFAULT NULL COMMENT '집행금액',
  `adUnitSq` int(11) NOT NULL COMMENT '광고단위',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `serviceSq` int(11) DEFAULT NULL COMMENT '서비스번호',
  PRIMARY KEY (`collDate`,`memberSq`,`adUnitSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고단위별일일정산';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fillLog`
--

DROP TABLE IF EXISTS `fillLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fillLog` (
  `fillLogSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '충전번호',
  `memberSq` int(11) DEFAULT NULL COMMENT '회원코드',
  `point` int(11) DEFAULT '0' COMMENT '포인트',
  `fillType` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '충전유형(fill.fillType)',
  `description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '설명',
  `fillYn` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'Y' COMMENT '충전여부(fill.fillYn)',
  `cancelDate` datetime DEFAULT NULL COMMENT '최소일',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `fillCd` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '업체충전코드',
  PRIMARY KEY (`fillLogSq`),
  KEY `index2` (`memberSq`,`regDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='충전로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kw1`
--

DROP TABLE IF EXISTS `kw1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kw1` (
  `kw1Sq` int(11) NOT NULL AUTO_INCREMENT COMMENT '1차키워드번호',
  `cg2Sq` int(11) NOT NULL COMMENT '2차카테고리번호',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '이름',
  `sortOrder` int(11) DEFAULT '0' COMMENT '정렬순서',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'B' COMMENT '상태(keyword.status)',
  `minBid` decimal(5,0) DEFAULT '50' COMMENT '최소비딩금액',
  PRIMARY KEY (`kw1Sq`),
  UNIQUE KEY `index2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kw2`
--

DROP TABLE IF EXISTS `kw2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kw2` (
  `kw2Sq` int(11) NOT NULL AUTO_INCREMENT COMMENT '2차키워드번호',
  `kw1Sq` int(11) NOT NULL COMMENT '1차키워드번호',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` int(11) DEFAULT '0',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'B' COMMENT '상태(keyword.status)',
  `kind` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '분류 kw2.kind',
  PRIMARY KEY (`kw2Sq`),
  UNIQUE KEY `index2` (`kw1Sq`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `memberSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '회원번호',
  `userid` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '아이디',
  `passwd` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '패스워드',
  `kind` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '매체타입(member.kind)',
  `phone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '연락처',
  `email` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '이메일',
  `companyName` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '상호',
  `point` decimal(10,0) unsigned DEFAULT '0' COMMENT '적립포인트',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  `profit` int(11) DEFAULT '40' COMMENT '매체수익율',
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '담당자이름',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '활성/ 정지',
  `hp` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '담당자 HP',
  `adPoint` decimal(10,0) unsigned NOT NULL DEFAULT '0' COMMENT '광고집행금액',
  PRIMARY KEY (`memberSq`),
  UNIQUE KEY `index2` (`userid`),
  UNIQUE KEY `memberSq_UNIQUE` (`memberSq`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='회원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monthAc`
--

DROP TABLE IF EXISTS `monthAc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthAc` (
  `memberSq` int(11) NOT NULL COMMENT '회원코드',
  `collDate` varchar(8) COLLATE utf8_unicode_ci NOT NULL COMMENT '수집일',
  `clickCnt` int(10) unsigned DEFAULT NULL COMMENT '클릭수',
  `validCnt` int(10) unsigned DEFAULT NULL COMMENT '유효수',
  `invalidCnt` int(10) unsigned DEFAULT NULL COMMENT '무효수',
  `reqCnt` int(10) unsigned DEFAULT NULL COMMENT '요청수',
  `viewCnt` int(10) unsigned DEFAULT NULL COMMENT '노출수',
  `sales` int(10) unsigned DEFAULT NULL COMMENT '집행금액',
  `prevPoint` int(10) unsigned DEFAULT NULL COMMENT '이월금액',
  `point` int(10) unsigned DEFAULT NULL COMMENT '월포인트',
  `bonus` int(10) unsigned DEFAULT NULL COMMENT '월보너스',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`memberSq`,`collDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고주월별정산';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monthMc`
--

DROP TABLE IF EXISTS `monthMc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monthMc` (
  `memberSq` int(11) NOT NULL COMMENT '회원코드',
  `collDate` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '수집일',
  `clickCnt` int(10) unsigned DEFAULT NULL COMMENT '클릭수',
  `validCnt` int(10) unsigned DEFAULT NULL COMMENT '유효수',
  `invalidCnt` int(10) unsigned DEFAULT NULL COMMENT '무효수',
  `reqCnt` int(10) unsigned DEFAULT NULL COMMENT '요청수',
  `viewCnt` int(10) unsigned DEFAULT NULL COMMENT '노출수',
  `avgPrice` int(10) unsigned DEFAULT NULL COMMENT '평단가',
  `sales` int(10) unsigned DEFAULT NULL COMMENT '집행금액',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  PRIMARY KEY (`memberSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='매체월별정산';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pointLog`
--

DROP TABLE IF EXISTS `pointLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pointLog` (
  `pointLogSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '포인트적립번호',
  `point` int(11) DEFAULT NULL COMMENT '포인트',
  `kind` varchar(1) COLLATE utf8_unicode_ci NOT NULL COMMENT '적립유형',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '설명',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `gubun` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '구분 ( pointLog.kind) 적립/출금',
  PRIMARY KEY (`pointLogSq`),
  KEY `index2` (`memberSq`,`regDate`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='포인트적립내역';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request` (
  `requestSq` bigint(20) NOT NULL AUTO_INCREMENT,
  `query` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admSq` int(11) DEFAULT NULL,
  `adUnitSq` int(11) DEFAULT NULL,
  `sessionId` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kw1Sq` int(11) DEFAULT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '아이피',
  `referer` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '레퍼러',
  `adUid` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '사용자 유니크 광고 아이디 ',
  `originHost` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`requestSq`),
  KEY `index2` (`adUid`,`regDate`)
) ENGINE=InnoDB AUTO_INCREMENT=2378 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고요청로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `serviceSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '서비스번호',
  `point` decimal(14,0) DEFAULT '0' COMMENT '누적적립포인트',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '이름',
  `memberSq` int(11) NOT NULL COMMENT '회원번호',
  `domain` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '도메인',
  `adType` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'A' COMMENT '광고유형-서치/매칭',
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `modDate` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '수정일',
  PRIMARY KEY (`serviceSq`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='서비스';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serviceCategory`
--

DROP TABLE IF EXISTS `serviceCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceCategory` (
  `serviceSq` int(11) NOT NULL,
  `cg1Sq` int(11) NOT NULL,
  `cg2Sq` int(11) NOT NULL,
  `memberSq` int(11) DEFAULT NULL,
  `regDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`serviceSq`,`cg1Sq`,`cg2Sq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='서비스카테고리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `aaa` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `view`
--

DROP TABLE IF EXISTS `view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view` (
  `viewSq` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '노출번호',
  `kw1Sq` int(11) DEFAULT NULL COMMENT '1차키워드',
  `kw2Sq` int(11) DEFAULT NULL COMMENT '2차키워드',
  `admSq` int(11) DEFAULT NULL COMMENT '광고물번호',
  `adUnitSq` int(11) DEFAULT NULL COMMENT '광고단위번호',
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '아이피',
  `referer` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '레퍼러',
  `regDate` datetime DEFAULT NULL COMMENT '등록일',
  `requestSq` bigint(20) DEFAULT NULL,
  `adUid` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '사용자고유아이디',
  PRIMARY KEY (`viewSq`)
) ENGINE=InnoDB AUTO_INCREMENT=2332 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='노출로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordAd`
--

DROP TABLE IF EXISTS `wordAd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordAd` (
  `wordAdSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '일렵ㄴ번호',
  `word` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '광고키워드',
  `status` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `regDate` datetime DEFAULT NULL,
  PRIMARY KEY (`wordAdSq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고키워드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordRelation`
--

DROP TABLE IF EXISTS `wordRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordRelation` (
  `wordAdSq` int(11) NOT NULL DEFAULT '0' COMMENT '광고단어일련번호',
  `word` varchar(45) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '연관던어',
  `sortOrder` int(11) DEFAULT NULL,
  `regDate` datetime DEFAULT NULL COMMENT '등록일',
  PRIMARY KEY (`wordAdSq`,`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='광고연관키워드';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordSite`
--

DROP TABLE IF EXISTS `wordSite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordSite` (
  `wordSiteSq` int(11) NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `domain` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '도메인',
  `word` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '단어',
  `regDate` datetime DEFAULT NULL COMMENT '등록일',
  PRIMARY KEY (`wordSiteSq`),
  KEY `index2` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='사이트대표단어';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordUser`
--

DROP TABLE IF EXISTS `wordUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordUser` (
  `adUid` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '사용자고유번호',
  `word` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT '대표단어',
  `weight` float DEFAULT NULL COMMENT '총점수',
  `regDate` datetime DEFAULT NULL COMMENT '등록일',
  PRIMARY KEY (`adUid`,`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='사용자대표키워드';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-18 14:06:10
