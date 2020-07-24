-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: project2
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_errorHeadline` text,
  `field_errorText` text,
  `field_optimizedImages` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_redirects`
--

DROP TABLE IF EXISTS `retour_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retour_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT '301',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_redirects_siteId_idx` (`siteId`),
  KEY `retour_redirects_associatedElementId_fk` (`associatedElementId`),
  CONSTRAINT `retour_redirects_associatedElementId_fk` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_static_redirects`
--

DROP TABLE IF EXISTS `retour_static_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retour_static_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT '301',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_static_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_static_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_static_redirects_siteId_idx` (`siteId`),
  CONSTRAINT `retour_static_redirects_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_stats`
--

DROP TABLE IF EXISTS `retour_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retour_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int(11) DEFAULT '0',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `retour_stats_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_stats_siteId_idx` (`siteId`),
  CONSTRAINT `retour_stats_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int(11) DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecacheelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_data_samples`
--

DROP TABLE IF EXISTS `webperf_data_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webperf_data_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `dns` int(11) DEFAULT NULL,
  `connect` int(11) DEFAULT NULL,
  `firstByte` int(11) DEFAULT NULL,
  `firstPaint` int(11) DEFAULT NULL,
  `firstContentfulPaint` int(11) DEFAULT NULL,
  `domInteractive` int(11) DEFAULT NULL,
  `pageLoad` int(11) DEFAULT NULL,
  `countryCode` varchar(2) DEFAULT NULL,
  `device` varchar(50) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `mobile` tinyint(1) DEFAULT NULL,
  `craftTotalMs` int(11) DEFAULT NULL,
  `craftDbMs` int(11) DEFAULT NULL,
  `craftDbCnt` int(11) DEFAULT NULL,
  `craftTwigMs` int(11) DEFAULT NULL,
  `craftTwigCnt` int(11) DEFAULT NULL,
  `craftOtherMs` int(11) DEFAULT NULL,
  `craftOtherCnt` int(11) DEFAULT NULL,
  `craftTotalMemory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_data_samples_url_idx` (`url`),
  KEY `webperf_data_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_data_samples_requestId_idx` (`requestId`),
  KEY `webperf_data_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_data_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_error_samples`
--

DROP TABLE IF EXISTS `webperf_error_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webperf_error_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `type` varchar(16) DEFAULT '',
  `pageErrors` text,
  PRIMARY KEY (`id`),
  KEY `webperf_error_samples_url_idx` (`url`),
  KEY `webperf_error_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_error_samples_requestId_idx` (`requestId`),
  KEY `webperf_error_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_error_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'project2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-24 11:04:09
-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: project2
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-07-23 10:41:46','2020-07-23 10:41:46','d09ca58b-ced0-4904-96ac-0218bdd32299',NULL,NULL,NULL),(2,2,1,'Homepage','2020-07-24 08:36:20','2020-07-24 08:36:21','732e193c-c378-4501-8523-b20790a0f765',NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-07-23 10:41:46','2020-07-23 10:41:46',NULL,'4e4b2c33-9892-42f7-8eda-aea6c43a2817'),(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-07-24 08:36:20','2020-07-24 08:36:21',NULL,'24e6ca9b-1038-4d90-8f1c-0a48ee268392');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-07-23 10:41:46','2020-07-23 10:41:46','fc76e2d2-232a-4fb2-a8a6-f8369d35e4ba'),(2,2,1,'homepage','__home__',1,'2020-07-24 08:36:20','2020-07-24 08:36:20','ea407623-fcd9-402c-9379-9fc66baf21e5');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,2,NULL,2,NULL,'2020-07-24 08:36:00',NULL,NULL,'2020-07-24 08:36:20','2020-07-24 08:36:20','93e5fc7d-8fbe-4225-a952-e7767413fd26');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,NULL,'Errors','errors',1,'Title',NULL,1,'2020-07-24 08:35:07','2020-07-24 08:35:07',NULL,'3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6'),(2,2,NULL,'Homepage','homepage',0,NULL,'{section.name|raw}',1,'2020-07-24 08:36:19','2020-07-24 08:36:19',NULL,'92e0121a-41bf-462d-ba1c-4e8becc82038');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-07-23 10:41:45','2020-07-23 10:41:45','30709f5d-3519-472d-8340-b48451e87427'),(2,'Error','2020-07-24 08:02:41','2020-07-24 08:02:41','1e90d02a-c0c4-4567-b346-020449aecd79'),(3,'Images','2020-07-24 08:49:49','2020-07-24 08:49:49','7970585d-b0d3-473e-b88a-e8a4e1d90dc3');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,2,'Error Headline','errorHeadline','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\"}','2020-07-24 08:07:06','2020-07-24 08:34:10','5aa84d0b-6386-43ee-bdbd-73d9346412c7'),(2,2,'Error Image','errorImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":\"\",\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":true,\"singleUploadLocationSource\":\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\"],\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":\"\",\"viewMode\":\"large\"}','2020-07-24 08:09:34','2020-07-24 08:33:57','936d5c3d-d2fc-41cf-abdb-cc47c121f192'),(3,2,'Error Text','errorText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":\"\"}','2020-07-24 08:09:55','2020-07-24 08:34:24','ce37128e-04a8-4b48-aa20-4cbe4eeca9cf'),(4,3,'Optimized Images','optimizedImages','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2020-07-24 08:51:05','2020-07-24 08:51:05','80573c97-7621-48c7-8d94-3dddfccdca00');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','[]',1,'2020-07-23 18:33:17','2020-07-23 18:33:17','6bbd47c7-b787-4070-b2e6-5c5a160a0ba1'),(2,'Public Schema','[]',1,'2020-07-23 18:36:04','2020-07-23 18:36:04','7f928e11-73a1-4704-8a52-1a81becf861e');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqltokens` VALUES (1,'Public Token','__PUBLIC__',1,NULL,NULL,1,'2020-07-23 18:33:17','2020-07-23 18:33:17','455c7079-1a6f-47a0-9ebe-1b2e427a5413');
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.4.29.1','3.4.11',0,'{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"fields\":\"@config/project.yaml\",\"graphql\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\"}','YwAXGNZ11nCO','2020-07-23 10:41:45','2020-07-24 09:03:47','7bfe3ed5-fba1-4cba-aa3a-63540b3bc74f');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e823fd4d-b148-4df2-b7a2-65c7d60ba53f'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','cafeca2e-ad82-4354-9bcb-db1edb812dd6'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a689f40d-0aa3-4760-9db9-a8af5599b4ed'),(4,NULL,'app','m150403_184533_field_version','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','4f67ab72-be43-4212-a3a8-026ce62036a3'),(5,NULL,'app','m150403_184729_type_columns','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d37f50ef-8433-4056-8203-47653ac17ec1'),(6,NULL,'app','m150403_185142_volumes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7cad616c-24c4-4294-9112-1c513bd2bd6c'),(7,NULL,'app','m150428_231346_userpreferences','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7ac096b2-a898-4808-9a2d-1d9fb500d541'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','8b1220e1-6b3b-4789-857c-5db75ebdb135'),(9,NULL,'app','m150617_213829_update_email_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','67cc1589-bb11-4519-9bcb-f87cffaf68d7'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2e65cff8-d95c-4338-8ff6-c942be151e8d'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','b47e6b2d-96be-41ee-837d-a43660fccc52'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ee05c66c-52ad-4191-9209-2b7c52258824'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','763b5529-0d0f-498d-8574-5a1056a015c9'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0ce19066-fc2d-4ef4-9ebd-7137c6eab959'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','32d6ecef-e830-4704-ac4a-d3549bbf81fc'),(16,NULL,'app','m151209_000000_move_logo','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','dc27d3b8-a20b-43e4-afc2-7b81f6c7b8d6'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','f6e13d3d-6652-4dc1-a184-9c163c06be8d'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','89778aee-c305-4095-9ce1-ccc0a307974a'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ea3a8a2f-d00d-497e-bbf4-b02d2e68eeee'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','3eadee1d-1616-4b30-92ed-646f9abc55fd'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','469e4295-c20a-43fc-9634-ea99834dbdda'),(22,NULL,'app','m160727_194637_column_cleanup','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','9cf18c5b-6e0d-4330-8d17-edd6efb6b132'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2fd79ad5-2fad-46b6-81c9-cca157cee8c6'),(24,NULL,'app','m160807_144858_sites','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','6bb20309-4666-41b1-98b5-affc62d90ecc'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','8ad6c07f-ee7c-426a-b504-568724db74e1'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2c45ac05-fc39-4c84-aa43-32353da9bfea'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','df1c1105-c2a7-4e97-be8d-efd423287d02'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ee91f879-30df-47aa-b14a-64b836a1a39e'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7a40d398-7e39-4a80-9cfa-12ffd0772312'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','44086253-0df6-464a-a892-63588796757e'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','486e8c80-4b85-45ea-861c-b6ebe4ff3dd7'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a67aa5cd-737e-41f2-9965-3df7f0b73b5e'),(33,NULL,'app','m161007_130653_update_email_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a0264f1f-d292-479d-9994-00ab32464fe5'),(34,NULL,'app','m161013_175052_newParentId','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','84bcaa05-d040-46f0-82c9-a026af8cc1e6'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','c0e737cb-157e-41b5-a6a3-b3f7381e761d'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','33e9f5f1-b2fb-41ba-8378-129de50bc04a'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2f09b715-fe0e-43fc-8777-5971be1a1d42'),(38,NULL,'app','m161029_124145_email_message_languages','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a46a8cb4-d447-4f21-a2c9-a17da0a46ddc'),(39,NULL,'app','m161108_000000_new_version_format','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','675b5bf2-0ec0-4267-be42-2e8dd849b34d'),(40,NULL,'app','m161109_000000_index_shuffle','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','bb45aaa5-1aad-4959-94ef-9f6d21b79b7c'),(41,NULL,'app','m161122_185500_no_craft_app','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d9e3ef8c-c570-49ac-b969-f8972dc43843'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','027c21be-e403-46a7-a331-3b6c14441a74'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','bf38381d-fcc8-44b3-80f6-19f7e3addd65'),(44,NULL,'app','m170114_161144_udates_permission','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ea737156-c0ab-4a56-8337-facd1a842af1'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','4d93b3f6-388b-4677-a3f7-fad6a2e6d7b3'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','129b4814-5939-472d-94c0-6e0f6bdf52a4'),(47,NULL,'app','m170206_142126_system_name','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','c6c67412-149c-409b-a943-bafd36e32930'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7cab89a9-86f3-43e4-89f7-b22f718d4265'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','c2033191-210c-4913-b0fb-36bb7a4edbc0'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','3f9d8b06-2a15-4801-a323-b8f09e166b12'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','890f5e5a-d6a4-4d02-a21c-26585b69b228'),(52,NULL,'app','m170228_171113_system_messages','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','172a0427-1bda-445f-b2a8-d70a2e0562fb'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','6c65df74-f003-404a-86f5-c85d7981fd88'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d722390f-5d88-472e-8caa-35a6dc7b712c'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','524f217c-20eb-413a-9c31-6c59eca18ca2'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','9b2b178e-b830-4643-8a03-6b97f6987e59'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a7f1ea66-e18d-4eb0-8109-cf81c5c967cc'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','badcf1c0-09eb-42cb-bdc9-4f3b05e30295'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','75ec001c-5e7e-4b51-9fb4-5b74ab763138'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e7280000-c6a3-453b-a9d1-88f0f3916483'),(61,NULL,'app','m170704_134916_sites_tables','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','77a27602-7b65-427a-9bfe-a773c936ebff'),(62,NULL,'app','m170706_183216_rename_sequences','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7c1f350a-a04e-4b58-8ca0-e40d93d1c392'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','3d8fed6a-6056-47c9-884f-4380891f63b6'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2c0e92a4-0193-4b6e-8d6e-37361d6b60a6'),(65,NULL,'app','m170810_201318_create_queue_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','5e18f619-6e9a-4e40-ad3c-8c330c921c1a'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','3afab08e-15a3-4b5b-8769-d3da89b6bced'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e8e0da8d-de19-44bc-ba27-44c6e2e0e70a'),(68,NULL,'app','m171011_214115_site_groups','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2a255c8a-88b1-486a-ad3e-e0b27bc7b530'),(69,NULL,'app','m171012_151440_primary_site','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d743853f-f966-4f49-914c-622ff39d77f7'),(70,NULL,'app','m171013_142500_transform_interlace','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','677c3963-ae58-42cb-9991-907739ca65c2'),(71,NULL,'app','m171016_092553_drop_position_select','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','edac838f-4b36-4ee1-8cc9-da967bfabd8d'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','4d4f0d7f-d67f-4404-84e0-bd6f59867f01'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a9afd12e-2e84-4d5d-b61a-c79c96fa4f6f'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','24226fce-178a-459f-9da6-0a377c313629'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','18096769-45dd-47fb-addd-cd20a4ada336'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','89c1cc71-db9f-49d8-9236-11bf10d5687c'),(77,NULL,'app','m171202_004225_update_email_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','73914097-d204-4f91-8a27-56b6c5b733d0'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','b09aed2d-22b2-45e0-9eb5-c474d002a12a'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','c5e8cb76-4bae-458b-a4b4-1c41af328b29'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','bfa558b1-68ef-4806-9d77-76651cd31c5c'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','87d950b9-dbf0-4d2d-a3e8-ba4d0f0e2c53'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','66220cf9-3a0e-422b-8afc-3a08587f4d2d'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','10774468-4c21-4152-b81f-907fedb5847e'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e8be6fed-4a68-446f-8fa8-55f5324249c3'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','b4c04f65-a10e-4837-b831-6dd6dac63df1'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','491e9026-2d58-4f9d-8c0c-ba08c87ffae8'),(87,NULL,'app','m180217_172123_tiny_ints','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2261ec9a-8043-49ea-8814-5413ff261c3a'),(88,NULL,'app','m180321_233505_small_ints','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d6e851dd-fae0-4fe2-9ae9-4738a5d16a0f'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','53682b1a-8d30-4953-9fde-efbb1152d4f5'),(90,NULL,'app','m180404_182320_edition_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0e7e5ebd-523c-4dc0-9a8f-35bd806ffc36'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','358fe04b-2e15-496d-83eb-2073d27bd7d7'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','b0f99720-c883-4690-946f-9b856f604371'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ba8498b2-52e2-4bfc-b938-4379e48b0576'),(94,NULL,'app','m180425_203349_searchable_fields','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2dc8897f-c720-41cf-a582-b83c6123e989'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e41e1335-4fca-4ead-ad33-9467148dee2d'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','588964c9-41b0-4265-811c-9c04d2515c83'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','6c11f8c1-bc50-4b57-a47a-b2b3085c0ca7'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','93bb6563-99d5-433d-a681-bd26eae03267'),(99,NULL,'app','m180521_172900_project_config_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','eb0a394d-d19d-437a-9cfe-da8231add8ec'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e5e5ddd9-ca91-40a7-809f-8839879d3a3a'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e32f0f20-0881-46bd-9aff-2bc524df981f'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','4e8ee8b2-820c-4cf9-a14d-7250e4099670'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','1afe66dd-c455-40b3-b000-55f663be12ed'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','5b1b2cc9-bc79-4466-8e1b-d28b5079c1d6'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','cbe0a8f8-0c96-47e4-ab82-f7895df42a6d'),(106,NULL,'app','m180904_112109_permission_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','10ca3032-21c1-4a60-9f05-5c0cf20babc6'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','df793db7-a452-4b55-b64f-c669dfc295c9'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','49279342-6f28-4402-b81e-2a476a18c9ab'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','32b31fcc-954a-451b-a7cb-7219f32d54b8'),(110,NULL,'app','m181017_225222_system_config_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','4b822614-013b-4e01-acbb-dd7fb63fc337'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','6044c457-643f-4d40-b88b-f0e641ee6570'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','fbdfea4d-ab4a-4c05-a88e-6bdfd4b309b0'),(113,NULL,'app','m181112_203955_sequences_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7af308a6-1dd1-4156-8cbe-d39a4a33896c'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a08cef02-2e55-42d9-bf3f-c6e1b130c6ee'),(115,NULL,'app','m181128_193942_fix_project_config','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e19daf3b-e6ed-4204-8865-ce8f586e1eb9'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','42ec32b5-64a4-43f1-9b60-bd6372caa2c1'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','409260d8-da31-423c-a1a2-70e748ec822e'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e5bac400-1335-40f7-a6eb-b93323579153'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d9f6f11e-5c53-4854-a9f1-658cb641a0b7'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7e142b1a-28f4-458d-bb21-234d511462a2'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','54cee31f-e96c-4b14-9f67-a32f73dc684d'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','cdbc5c4e-673b-4c7b-8606-e51567784371'),(123,NULL,'app','m190109_172845_fix_colspan','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','5e53ae44-905e-49e5-ae30-abb8020a80e1'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','087562d0-689a-420c-81ae-da011b8060f4'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','63a756ec-bc61-4975-bf10-3fa660e18922'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','f50acfbf-cba9-4f85-88e5-f139abfeaba0'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','6e1e0376-6b83-4e6f-b631-09e9313690af'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','9ce6c623-3552-45ea-9302-b1a2fd7152ad'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e41ce375-b987-4ebc-96d7-e3692d67e8b7'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d4d77928-0954-4697-9be8-28f518a0b4dc'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','61721159-3abd-470a-be02-3693d5feb174'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','8c522d4d-54ea-4a07-9d62-d60446608892'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e23940d0-81e6-40ba-b8db-d187bab887b3'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','54ee0959-0968-4f2c-9926-19f3feba16e0'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','7a1b82ea-70f5-4b69-adbd-a08f1ba2a672'),(136,NULL,'app','m190312_152740_element_revisions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0f23d1e3-c6d9-4683-ac15-24de9a684b65'),(137,NULL,'app','m190327_235137_propagation_method','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2c7937ce-0721-47a1-b59c-b8107009110e'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ba4a45ca-e7f3-41e7-833d-17a290ad9151'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','fdeb4ec5-b374-474b-b4e4-28d063810d7e'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','75c98c1b-d9ef-4b9a-b40d-9887dbcac887'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0d9d6a95-cb53-4e4f-8878-dc3ec8b50827'),(142,NULL,'app','m190504_150349_preview_targets','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0fec88db-5fc6-434c-9087-95d0189bfadf'),(143,NULL,'app','m190516_184711_job_progress_label','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','1d1aace8-44f1-4d5a-ad79-f5c786d08be6'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','1799b452-ba1c-4738-b556-5bc440267b91'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','438a0160-0cc9-4e84-8cc8-a7c5ab3c9d1e'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','fd1b80a6-597e-4a5b-b7d6-a4fcdb257c59'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','84c89ca2-2796-49f7-bb92-c65bf42b4662'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','641283ae-ac3b-4cef-a882-d32dcf8cef75'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','e7890e5d-6086-494a-8d60-5d2cf60ca887'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d3b5f025-437c-4832-b474-7da562667be9'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0153dafc-3e34-4066-ac75-504e9f6047e1'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d2bf8d7e-fc47-4b8c-bb34-2e48d669c745'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','2eb07e59-f4ce-437e-a137-3c0728768652'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','0f688f6a-9e01-4e1b-8531-a43e75499fc9'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','760279ba-ca8e-4a3d-984c-87d5fabbec02'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ba16166e-6e7c-4a0c-bc3f-1fe138c7df44'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','ef39def4-ecd1-423b-8a73-b820386eb908'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','bda2adfc-5e51-4fae-afc8-a8805d32b0d0'),(159,NULL,'app','m191206_001148_change_tracking','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','5dba90e7-12fb-425a-a415-a8341284ad82'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','3b8a259f-35d0-4210-a685-5fe278911463'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','a9d80c85-e577-4132-89f4-38770400ab6b'),(162,NULL,'app','m200127_172522_queue_channels','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','187293c1-d07c-4c66-9435-738993f405c4'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','5336b599-8d0c-492e-ab94-06d0a28489f2'),(164,NULL,'app','m200213_172522_new_elements_index','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','d59bbdf2-57d7-4674-b28e-dfcbe417f394'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','f4f544b8-14e1-4b35-968b-0b6df8ae20d5'),(166,NULL,'app','m200715_113400_transform_index_error_flag','2020-07-23 10:41:47','2020-07-23 10:41:47','2020-07-23 10:41:47','f78d07dd-2380-4477-8f3b-8e6befd9346a'),(167,3,'plugin','Install','2020-07-23 10:53:49','2020-07-23 10:53:49','2020-07-23 10:53:49','a9fce63f-60d2-4739-be00-df47d63bda8f'),(168,3,'plugin','m180929_165000_remove_storageclass_setting','2020-07-23 10:53:49','2020-07-23 10:53:49','2020-07-23 10:53:49','44c6337a-3f20-4cf4-a08c-97d024c47cb1'),(169,3,'plugin','m190131_214300_cleanup_config','2020-07-23 10:53:49','2020-07-23 10:53:49','2020-07-23 10:53:49','97dbd920-9074-4d6c-8d25-d38b4e806cef'),(170,3,'plugin','m190305_133000_cleanup_expires_config','2020-07-23 10:53:49','2020-07-23 10:53:49','2020-07-23 10:53:49','ec491311-97e1-48d1-895a-44e9c7136932'),(171,7,'plugin','Install','2020-07-23 10:54:07','2020-07-23 10:54:07','2020-07-23 10:54:07','64d65470-28af-4b63-9f45-0f7c38d47f96'),(172,7,'plugin','m181013_122446_add_remote_ip','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','ad8bbb1e-b05c-4aff-967c-87c43a402c59'),(173,7,'plugin','m181013_171315_truncate_match_type','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','a3541d26-8449-4383-a01f-a485074a893b'),(174,7,'plugin','m181013_202455_add_redirect_src_match','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','83b24835-678a-458e-8bdc-6919b1518eb9'),(175,7,'plugin','m181018_123901_add_stats_info','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','6d77228e-84bc-42d1-92ef-80f3b1539962'),(176,7,'plugin','m181018_135656_add_redirect_status','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','272ed5aa-828f-42e0-91d3-697e520091e5'),(177,7,'plugin','m181213_233502_add_site_id','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','95d0eef5-2d16-4ac9-bfad-e7e5392572c2'),(178,7,'plugin','m181216_043222_rebuild_indexes','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','14d52878-b0dc-4c8d-a6d8-c002e90fc6a2'),(179,7,'plugin','m190416_212500_widget_type_update','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','e3f10324-1bbd-419a-acde-04f7a59a4293'),(180,7,'plugin','m200109_144310_add_redirectSrcUrl_index','2020-07-23 10:54:08','2020-07-23 10:54:08','2020-07-23 10:54:08','e4a1d39a-9dad-4f0f-9338-458ffffede1c'),(181,8,'plugin','Install','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','ee4bb348-92da-4503-8de6-445d7494ca68'),(182,8,'plugin','m180314_002755_field_type','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','ca00d15e-7172-4123-a2b9-1e64b759b5c1'),(183,8,'plugin','m180314_002756_base_install','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','12350177-1271-4b3d-86ce-79c6121971fb'),(184,8,'plugin','m180502_202319_remove_field_metabundles','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','2e9acd44-5f16-43db-bf88-adb85867d41f'),(185,8,'plugin','m180711_024947_commerce_products','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','d3d23139-f811-45ce-9b4e-17047917586c'),(186,8,'plugin','m190401_220828_longer_handles','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','21c0f41a-643d-4bb3-a8f1-588f349c62c6'),(187,8,'plugin','m190518_030221_calendar_events','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','2ab9c7e7-7bdf-4598-84a1-0c6f53e536fd'),(188,8,'plugin','m200419_203444_add_type_id','2020-07-23 10:54:20','2020-07-23 10:54:20','2020-07-23 10:54:20','63a3aa51-e891-4073-9234-104b6ff8e3e7'),(189,10,'plugin','Install','2020-07-23 10:54:40','2020-07-23 10:54:40','2020-07-23 10:54:40','dd9fbd54-083f-4e31-9f8c-8ee702591934'),(190,10,'plugin','m190625_151715_add_indexes','2020-07-23 10:54:40','2020-07-23 10:54:40','2020-07-23 10:54:40','84355699-6fcb-4619-b49f-7ec78896d5fd');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'minify','1.2.10','1.0.0','unknown',NULL,'2020-07-23 10:52:40','2020-07-23 10:52:40','2020-07-24 08:46:16','12ec3b02-cf03-4492-be99-65f71e75acf0'),(2,'twigpack','1.2.3','1.0.0','unknown',NULL,'2020-07-23 10:52:51','2020-07-23 10:52:51','2020-07-24 08:46:16','c1926287-b0e0-45e5-8ac2-834526e47f40'),(3,'aws-s3','1.2.9','1.2','unknown',NULL,'2020-07-23 10:53:49','2020-07-23 10:53:49','2020-07-24 08:46:16','e3ae2ccd-6453-4f75-9dec-5243c77c951d'),(4,'async-queue','2.1.1','1.0.0','unknown',NULL,'2020-07-23 10:53:52','2020-07-23 10:53:52','2020-07-24 08:46:16','9d26a0b7-1a75-44e9-b801-f22570b1fc21'),(5,'fastcgi-cache-bust','1.0.9','1.0.0','unknown',NULL,'2020-07-23 10:53:54','2020-07-23 10:53:54','2020-07-24 08:46:16','0f29985f-b1f9-4024-8383-1a1e05730384'),(6,'image-optimize','1.6.14','1.0.0','invalid',NULL,'2020-07-23 10:53:57','2020-07-23 10:53:57','2020-07-24 08:46:16','3ab723eb-0c61-4f90-91f2-84b89f857b62'),(7,'retour','3.1.40','3.0.9','invalid',NULL,'2020-07-23 10:54:07','2020-07-23 10:54:07','2020-07-24 08:46:16','f0131076-8250-46ff-8adf-c7cb76e8d956'),(8,'seomatic','3.3.12','3.0.9','invalid',NULL,'2020-07-23 10:54:19','2020-07-23 10:54:19','2020-07-24 08:46:16','55f29af4-6aeb-4031-9727-59a90905ccde'),(9,'typogrify','1.1.18','1.0.0','unknown',NULL,'2020-07-23 10:54:35','2020-07-23 10:54:35','2020-07-24 08:46:16','c91b5a0a-97d8-4e56-8594-45b7d7d4dbf7'),(10,'webperf','1.0.18','1.0.1','invalid',NULL,'2020-07-23 10:54:39','2020-07-23 10:54:39','2020-07-24 08:46:16','ce9e70b8-83c2-468d-a192-ecd944933e88');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1595580665'),('email.fromEmail','\"bjornar@noenreklame.no\"'),('email.fromName','\"admin\"'),('email.replyToEmail','null'),('email.template','\"\"'),('email.transportSettings.command','\"\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.1e90d02a-c0c4-4567-b346-020449aecd79.name','\"Error\"'),('fieldGroups.30709f5d-3519-472d-8340-b48451e87427.name','\"Common\"'),('fieldGroups.7970585d-b0d3-473e-b88a-e8a4e1d90dc3.name','\"Images\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.contentColumnType','\"text\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.fieldGroup','\"1e90d02a-c0c4-4567-b346-020449aecd79\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.handle','\"errorHeadline\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.instructions','\"\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.name','\"Error Headline\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.searchable','true'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.byteLimit','null'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.charLimit','null'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.code','\"\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.columnType','null'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.initialRows','\"4\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.multiline','\"\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.settings.placeholder','\"\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.translationKeyFormat','null'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.translationMethod','\"none\"'),('fields.5aa84d0b-6386-43ee-bdbd-73d9346412c7.type','\"craft\\\\fields\\\\PlainText\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.contentColumnType','\"text\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.fieldGroup','\"7970585d-b0d3-473e-b88a-e8a4e1d90dc3\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.handle','\"optimizedImages\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.instructions','\"\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.name','\"Optimized Images\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.searchable','false'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.displayDominantColorPalette','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.displayLazyLoadPlaceholderImages','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.displayOptimizedImageVariants','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.0.0','\"width\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.0.1','\"1200\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.1.1','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.2.1','\"16\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.3.1','\"9\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.4.1.0','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.5.0','\"quality\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.5.1','\"82\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.6.0','\"format\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.0.__assoc__.6.1','\"jpg\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.0.0','\"width\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.0.1','\"992\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.1.1','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.2.1','\"16\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.3.1','\"9\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.4.1.0','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.5.0','\"quality\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.5.1','\"82\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.6.0','\"format\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.1.__assoc__.6.1','\"jpg\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.0.0','\"width\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.0.1','\"768\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.1.1','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.2.1','\"4\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.3.1','\"3\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.4.1.0','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.5.0','\"quality\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.5.1','\"60\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.6.0','\"format\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.2.__assoc__.6.1','\"jpg\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.0.0','\"width\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.0.1','\"576\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.1.1','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.2.1','\"4\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.3.1','\"3\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.4.1.0','\"1\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.5.0','\"quality\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.5.1','\"60\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.6.0','\"format\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.settings.variants.3.__assoc__.6.1','\"jpg\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.translationKeyFormat','null'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.translationMethod','\"none\"'),('fields.80573c97-7621-48c7-8d94-3dddfccdca00.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.contentColumnType','\"string\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.fieldGroup','\"1e90d02a-c0c4-4567-b346-020449aecd79\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.handle','\"errorImage\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.instructions','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.name','\"Error Image\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.searchable','true'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.allowedKinds.0','\"image\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.allowSelfRelations','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.defaultUploadLocationSource','\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.defaultUploadLocationSubpath','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.limit','\"1\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.localizeRelations','false'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.restrictFiles','\"1\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.selectionLabel','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.showUnpermittedFiles','false'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.showUnpermittedVolumes','true'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.singleUploadLocationSource','\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.singleUploadLocationSubpath','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.source','null'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.sources.0','\"volume:408f99a3-3b3a-4e7b-9779-088ca5dd6b96\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.targetSiteId','null'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.useSingleFolder','false'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.validateRelatedElements','\"\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.settings.viewMode','\"large\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.translationKeyFormat','null'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.translationMethod','\"site\"'),('fields.936d5c3d-d2fc-41cf-abdb-cc47c121f192.type','\"craft\\\\fields\\\\Assets\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.contentColumnType','\"text\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.fieldGroup','\"1e90d02a-c0c4-4567-b346-020449aecd79\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.handle','\"errorText\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.instructions','\"\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.name','\"Error Text\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.searchable','true'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.byteLimit','null'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.charLimit','null'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.code','\"\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.columnType','null'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.initialRows','\"4\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.multiline','\"1\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.settings.placeholder','\"\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.translationKeyFormat','null'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.translationMethod','\"none\"'),('fields.ce37128e-04a8-4b48-aa20-4cbe4eeca9cf.type','\"craft\\\\fields\\\\PlainText\"'),('graphql.schemas.6bbd47c7-b787-4070-b2e6-5c5a160a0ba1.isPublic','true'),('graphql.schemas.6bbd47c7-b787-4070-b2e6-5c5a160a0ba1.name','\"Public Schema\"'),('graphql.schemas.7f928e11-73a1-4704-8a52-1a81becf861e.isPublic','true'),('graphql.schemas.7f928e11-73a1-4704-8a52-1a81becf861e.name','\"Public Schema\"'),('plugins.async-queue.edition','\"standard\"'),('plugins.async-queue.enabled','true'),('plugins.async-queue.schemaVersion','\"1.0.0\"'),('plugins.aws-s3.edition','\"standard\"'),('plugins.aws-s3.enabled','true'),('plugins.aws-s3.schemaVersion','\"1.2\"'),('plugins.fastcgi-cache-bust.edition','\"standard\"'),('plugins.fastcgi-cache-bust.enabled','true'),('plugins.fastcgi-cache-bust.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.edition','\"standard\"'),('plugins.image-optimize.enabled','true'),('plugins.image-optimize.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.settings.allowUpScaledImageVariants','false'),('plugins.image-optimize.settings.assetVolumeSubFolders','true'),('plugins.image-optimize.settings.autoSharpenScaledImages','true'),('plugins.image-optimize.settings.createColorPalette','true'),('plugins.image-optimize.settings.createPlaceholderSilhouettes','false'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.0','\"nystudio107\\\\imageoptimizeimgix\\\\imagetransforms\\\\ImgixImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.0','\"domain\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.0','\"apiKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.0','\"securityToken\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.0','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.1','\"$SERVERLESS_SHARP_CLOUDFRONT_URL\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.0','\"nystudio107\\\\imageoptimizethumbor\\\\imagetransforms\\\\ThumborImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.0','\"securityKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.0','\"includeBucketPrefix\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.1','\"\"'),('plugins.image-optimize.settings.lowerQualityRetinaImageVariants','false'),('plugins.image-optimize.settings.transformClass','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),('plugins.minify.edition','\"standard\"'),('plugins.minify.enabled','true'),('plugins.minify.schemaVersion','\"1.0.0\"'),('plugins.retour.edition','\"standard\"'),('plugins.retour.enabled','true'),('plugins.retour.schemaVersion','\"3.0.9\"'),('plugins.seomatic.edition','\"standard\"'),('plugins.seomatic.enabled','true'),('plugins.seomatic.schemaVersion','\"3.0.9\"'),('plugins.twigpack.edition','\"standard\"'),('plugins.twigpack.enabled','true'),('plugins.twigpack.schemaVersion','\"1.0.0\"'),('plugins.typogrify.edition','\"standard\"'),('plugins.typogrify.enabled','true'),('plugins.typogrify.schemaVersion','\"1.0.0\"'),('plugins.webperf.edition','\"standard\"'),('plugins.webperf.enabled','true'),('plugins.webperf.schemaVersion','\"1.0.1\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.enableVersioning','false'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.handle','\"errors\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.hasTitleField','true'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.name','\"Errors\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.sortOrder','1'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.titleFormat','null'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.entryTypes.3cef9d16-36bc-4fd9-855e-3d2dbdb3c3c6.titleLabel','\"Title\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.handle','\"errors\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.name','\"Errors\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.propagationMethod','\"all\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.enabledByDefault','true'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.hasUrls','false'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.template','null'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.uriFormat','\"\"'),('sections.5b25bdbf-d19f-4ecd-bae7-db11b349d944.type','\"channel\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.enableVersioning','false'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.handle','\"homepage\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.hasTitleField','false'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.name','\"Homepage\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.sortOrder','1'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.titleFormat','\"{section.name|raw}\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.entryTypes.92e0121a-41bf-462d-ba1c-4e8becc82038.titleLabel','null'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.handle','\"homepage\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.name','\"Homepage\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.propagationMethod','\"all\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.enabledByDefault','true'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.hasUrls','true'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.template','\"index\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.siteSettings.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.uriFormat','\"__home__\"'),('sections.d01dd714-f689-45e1-a9ab-7ef5dfed7f97.type','\"single\"'),('siteGroups.54a200df-d659-4f63-938b-7155675f8629.name','\"Default\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.baseUrl','\"$SITE_URL\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.handle','\"default\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.hasUrls','true'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.language','\"en-GB\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.name','\"Default\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.primary','true'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.siteGroup','\"54a200df-d659-4f63-938b-7155675f8629\"'),('sites.fbb717e7-43b9-470b-9e3c-8a85eee0ccd0.sortOrder','1'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"Craft\"'),('system.schemaVersion','\"3.4.11\"'),('system.timeZone','\"Europe/Berlin\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.handle','\"site\"'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.hasUrls','true'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.name','\"Site\"'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.settings.path','\"@webroot/assets/site\"'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.sortOrder','1'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.type','\"craft\\\\volumes\\\\Local\"'),('volumes.408f99a3-3b3a-4e7b-9779-088ca5dd6b96.url','\"@assetsUrl/assets/site\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('121d450e','@lib/datepicker-i18n'),('16d5b844','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),('17ef1eca','@craft/web/assets/updateswidget/dist'),('1aac3d93','@craft/web/assets/fieldsettings/dist'),('1d2a698','@lib/xregexp'),('1ec04a91','@craft/web/assets/generalsettings/dist'),('20961afb','@craft/web/assets/updater/dist'),('25c2fc0','@nystudio107/webperf/assetbundles/webperf/dist'),('29555ca4','@craft/web/assets/recententries/dist'),('36273aa9','@app/web/assets/plugins/dist'),('4728ce68','@lib/fileupload'),('49bb6db2','@craft/web/assets/sites/dist'),('4eaf726','@craft/web/assets/pluginstore/dist'),('5165efc7','@lib/d3'),('5396d6a','@nystudio107/seomatic/assetbundles/seomatic/dist'),('550c29db','@craft/web/assets/userpermissions/dist'),('5763ff91','@craft/web/assets/utilities/dist'),('5864f354','@lib/jquery-touch-events'),('5ae2f9dd','@lib/prismjs'),('5fc0cf96','@lib/picturefill'),('62d8f841','@lib/garnishjs'),('74ec77ba','@app/web/assets/dashboard/dist'),('775be592','@craft/web/assets/fields/dist'),('7778c4f4','@craft/web/assets/graphiql/dist'),('779e2c7f','@lib/fabric'),('7e751d47','@craft/web/assets/admintable/dist'),('82de2d20','@nystudio107/fastcgicachebust/assetbundles/fastcgicachebust/dist'),('869bdf80','@lib/axios'),('8c4c9fc9','@lib/jquery-ui'),('8f56d587','@craft/web/assets/feed/dist'),('8ff05f79','@craft/web/assets/assetindexes/dist'),('927aa326','@nystudio107/retour/assetbundles/retour/dist'),('92f22e78','@craft/web/assets/plugins/dist'),('94165c15','@app/web/assets/updateswidget/dist'),('942b726a','@craft/web/assets/editsection/dist'),('9a84f0d4','@app/web/assets/craftsupport/dist'),('9cd38ade','@modules/sitemodule/assetbundles/sitemodule/dist'),('a0723568','@craft/awss3/resources'),('a2ed4dac','@nystudio107/imageoptimize/assetbundles/optimizedimagesfield/dist'),('aaac1e7b','@app/web/assets/recententries/dist'),('ab707cf5','@lib/vue'),('acd974dd','@app/web/assets/pluginstore/dist'),('b043e8c3','@craft/web/assets/craftsupport/dist'),('b3df2c88','@app/web/assets/login/dist'),('b7e139f6','@app/web/assets/cp/dist'),('bad4cfcf','@craft/web/assets/dbbackup/dist'),('bbee212','@lib/selectize'),('c2e5046c','@lib/velocity'),('cefa7248','@app/web/assets/feed/dist'),('cfc4ac1a','@craft/web/assets/updates/dist'),('d36af311','@bower/jquery/dist'),('d91c75b','@craft/web/assets/cp/dist'),('dec2ab84','@lib/jquery.payment'),('ed12f03f','@craft/web/assets/edituser/dist'),('f40fcc9d','@nystudio107/webperf/assetbundles/boomerang/dist/js'),('f615f34c','@craft/web/assets/dashboard/dist'),('fcfa58e4','@lib/element-resize-detector');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_redirects`
--

LOCK TABLES `retour_redirects` WRITE;
/*!40000 ALTER TABLE `retour_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_static_redirects`
--

LOCK TABLES `retour_static_redirects` WRITE;
/*!40000 ALTER TABLE `retour_static_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_static_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_stats`
--

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `retour_stats` VALUES (1,'2020-07-23 13:57:17','2020-07-23 14:32:23','9acc7220-6d8e-4c60-8bc7-f09156ffc0eb',1,'/favicon.ico','','192.168.64.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:79.0) Gecko/20100101 Firefox/79.0','Template not found: favicon.ico','/home/ubuntu/sites/project2/vendor/craftcms/cms/src/controllers/TemplatesController.php',90,2,'2020-07-23 14:32:23',0);
/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' bjornar noenreklame no '),(1,'slug',0,1,''),(2,'title',0,1,' homepage '),(2,'slug',0,1,' homepage ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Errors','errors','channel',0,'all',NULL,'2020-07-24 08:35:07','2020-07-24 08:35:07',NULL,'5b25bdbf-d19f-4ecd-bae7-db11b349d944'),(2,NULL,'Homepage','homepage','single',0,'all',NULL,'2020-07-24 08:36:17','2020-07-24 08:36:17',NULL,'d01dd714-f689-45e1-a9ab-7ef5dfed7f97');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,0,NULL,NULL,1,'2020-07-24 08:35:07','2020-07-24 08:35:07','884bc199-45af-4f16-8ce9-3e89bbc55403'),(2,2,1,1,'__home__','index',1,'2020-07-24 08:36:17','2020-07-24 08:36:17','2841f3ec-e79e-456f-b9ac-2db9fda6780f');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2020-07-23 10:54:20','2020-07-23 10:54:20','b642d46e-cc6e-4ede-a794-d8431c6c2d08','1.0.47','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2020-07-23 10:54:19','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"project2\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"nystudio107\",\"genericAlternateName\":\"nys\",\"genericDescription\":\"We do technology-based consulting, branding, design, and development. Making the web better one site at a time, with a focus on performance, usability & SEO\",\"genericUrl\":\"https://nystudio107.com/\",\"genericImage\":\"https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/site/nys_logo_seo.png\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"info@nystudio107.com\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"Webster\",\"genericAddressRegion\":\"NY\",\"genericPostalCode\":\"14580\",\"genericAddressCountry\":\"US\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Andrew Welch, Polly Welch\",\"organizationFoundingDate\":\"2013-05-02\",\"organizationFoundingLocation\":\"Webster, NY\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2020-07-24 08:36:18','2020-07-24 08:36:21','2ffea89d-1536-4c88-8bde-ad78f5ef3eb8','1.0.28','section',2,'Homepage','homepage','single',NULL,'index',1,'{\"1\":{\"id\":\"2\",\"sectionId\":\"2\",\"siteId\":\"1\",\"enabledByDefault\":\"1\",\"hasUrls\":\"1\",\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-gb\"}}','2020-07-24 08:36:21','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{seomatic.site.identity.genericUrl}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Default','2020-07-23 10:41:45','2020-07-24 08:31:08',NULL,'54a200df-d659-4f63-938b-7155675f8629');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Default','default','en-GB',1,'$SITE_URL',1,'2020-07-23 10:41:45','2020-07-24 08:31:26',NULL,'fbb717e7-43b9-470b-9e3c-8a85eee0ccd0');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'bjornar@noenreklame.no','$2y$13$LsTaw/GzGLHURYueCS0MTenPmZZqX/5j3lufWELRugNYD1n4IDq9a',1,0,0,0,'2020-07-24 07:52:23',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-07-23 10:41:46','2020-07-23 10:41:46','2020-07-24 07:52:23','cb7dcc13-2e14-4c14-b61d-b27d972f4524');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Site','','2020-07-24 08:32:26','2020-07-24 08:32:26','7b8cd9de-f4ab-48ec-a35f-a9364ac5490c'),(2,NULL,NULL,'Temporary source',NULL,'2020-07-24 08:45:31','2020-07-24 08:45:31','0ddbc17d-4ada-4c1e-bbda-d26d1d34c013'),(3,2,NULL,'user_1','user_1/','2020-07-24 08:45:31','2020-07-24 08:45:31','44e7e248-d760-41ec-b8b2-19a5973ee240');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Site','site','craft\\volumes\\Local',1,'@assetsUrl/assets/site','{\"path\":\"@webroot/assets/site\"}',1,'2020-07-24 08:32:25','2020-07-24 08:32:25',NULL,'408f99a3-3b3a-4e7b-9779-088ca5dd6b96');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_data_samples`
--

LOCK TABLES `webperf_data_samples` WRITE;
/*!40000 ALTER TABLE `webperf_data_samples` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `webperf_data_samples` VALUES (1,'2020-07-23 11:11:14','2020-07-23 11:11:20','d1748f4d-4676-4b5a-8a52-cb5c7c38c14b',8148648010480430999,1,'&#x1f6a7; project2 |','http://project2.test/',NULL,NULL,NULL,11882,NULL,NULL,12196,12885,'??','Macintosh','Firefox 79.0','OS X Catalina 10.15',0,10398,125,31,0,0,10273,438,6503528),(2,'2020-07-23 11:45:06','2020-07-23 11:45:10','550c1c4c-f464-426a-8f8b-f825a6539edd',3231808235608911444,1,'&#x1f6a7; project2 |','http://project2.test/',NULL,NULL,143,17301,NULL,NULL,18094,19354,'??','Macintosh','Firefox 79.0','OS X Catalina 10.15',0,12922,749,37,0,0,12172,436,6228480),(3,'2020-07-23 13:57:14','2020-07-23 13:57:18','33191cf7-b66c-435a-bc54-90b34103538b',9161391469694171221,1,'&#x1f6a7; project2 |','http://project2.test/',NULL,NULL,NULL,4855,NULL,NULL,5227,8275,'??','Macintosh','Firefox 79.0','OS X Catalina 10.15',0,8756,127,31,0,0,8629,345,7377880),(4,'2020-07-23 14:32:16','2020-07-23 14:32:24','e39f855a-28c2-4885-86f4-e0fcf773231d',3982789444968832517,1,'&#x1f6a7; project2 |','http://project2.test/',NULL,3,9,NULL,NULL,NULL,661,3227,'??','Macintosh','Firefox 79.0','OS X Catalina 10.15',0,2284,186,37,0,0,2098,344,6261416);
/*!40000 ALTER TABLE `webperf_data_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_error_samples`
--

LOCK TABLES `webperf_error_samples` WRITE;
/*!40000 ALTER TABLE `webperf_error_samples` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `webperf_error_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-07-23 10:51:28','2020-07-23 10:51:28','10ccaa47-03ee-41d6-aea0-c215a4dd56db'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-07-23 10:51:28','2020-07-23 10:51:28','80b05f94-82a3-4774-94c0-bb217186f41b'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-07-23 10:51:28','2020-07-23 10:51:28','4efb7cb5-873c-42b2-aefd-65317da2dd4a'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-07-23 10:51:28','2020-07-23 10:51:28','e671b894-3658-4de7-a837-f13e3d6f7f9d');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'project2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-24 11:04:09
