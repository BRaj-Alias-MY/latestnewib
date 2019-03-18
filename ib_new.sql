-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2019 at 10:25 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 5.6.39

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ib_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `type` enum('prepaid','partialpaid','discount') NOT NULL,
  `code` varchar(255) NOT NULL,
  `discount` int(11) NOT NULL,
  `expDate` datetime NOT NULL,
  `status` enum('generated','expired','used') NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `maxAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE `domain` (
  `id` int(11) NOT NULL,
  `domainName` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domain`
--

INSERT INTO `domain` (`id`, `domainName`, `createdAt`, `updatedAt`, `status`) VALUES
(1, 'IT', '2019-03-15 12:18:18', '2019-03-15 12:18:18', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exp_level`
--

CREATE TABLE `exp_level` (
  `id` int(11) NOT NULL,
  `experiance` varchar(255) NOT NULL COMMENT '1-2 Years,2-4 Years ',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exp_level`
--

INSERT INTO `exp_level` (`id`, `experiance`, `createdAt`, `updatedAt`, `organizationId`, `userId`) VALUES
(1, '0-2', '2019-03-15 12:18:03', '2019-03-15 12:18:03', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `interview`
--

CREATE TABLE `interview` (
  `id` int(11) NOT NULL,
  `type` enum('async','ff') NOT NULL COMMENT 'ff-face to face',
  `domainId` int(11) NOT NULL,
  `subDomainId` int(11) NOT NULL,
  `expLevelId` int(11) NOT NULL,
  `interviewId` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'duration in minutes',
  `questionCount` int(11) NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `interviewName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview`
--

INSERT INTO `interview` (`id`, `type`, `domainId`, `subDomainId`, `expLevelId`, `interviewId`, `start_date`, `end_date`, `duration`, `questionCount`, `organizationId`, `userId`, `createdAt`, `updatedAt`, `interviewName`) VALUES
(1, 'async', 1, 1, 1, 'AI01001-000001', '2019-03-15 00:00:00', '2019-03-23 00:00:00', 15, 5, 1, 3, '2019-03-15 12:29:33', '2019-03-15 12:29:33', '007');

-- --------------------------------------------------------

--
-- Table structure for table `interview_experts`
--

CREATE TABLE `interview_experts` (
  `id` int(11) NOT NULL,
  `interviewUserId` int(11) NOT NULL,
  `expertId` int(11) NOT NULL,
  `feedback` text,
  `interviewTypeMapChildId` int(11) NOT NULL,
  `status` enum('open','inprogress','completed','cancel') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_experts`
--

INSERT INTO `interview_experts` (`id`, `interviewUserId`, `expertId`, `feedback`, `interviewTypeMapChildId`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 1, 5, NULL, 2, 'open', '2019-03-15 13:37:54', '2019-03-15 13:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `interview_experts_feedback`
--

CREATE TABLE `interview_experts_feedback` (
  `id` int(11) NOT NULL,
  `interviewExpertId` int(11) NOT NULL,
  `interviewUserQuestionId` int(11) NOT NULL,
  `review` text,
  `rating` enum('1','2','3','4','5') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_experts_feedback`
--

INSERT INTO `interview_experts_feedback` (`id`, `interviewExpertId`, `interviewUserQuestionId`, `review`, `rating`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, NULL, NULL, '2019-03-15 13:37:54', '2019-03-15 13:37:54'),
(2, 1, 2, NULL, NULL, '2019-03-15 13:37:54', '2019-03-15 13:37:54'),
(3, 1, 3, NULL, NULL, '2019-03-15 13:37:54', '2019-03-15 13:37:54'),
(4, 1, 4, NULL, NULL, '2019-03-15 13:37:54', '2019-03-15 13:37:54'),
(5, 1, 5, NULL, NULL, '2019-03-15 13:37:54', '2019-03-15 13:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `interview_expert_overall_feedback`
--

CREATE TABLE `interview_expert_overall_feedback` (
  `id` int(11) NOT NULL,
  `reportPerameterId` int(11) NOT NULL,
  `interviewExpertId` int(11) NOT NULL,
  `review` text NOT NULL,
  `rating` int(11) NOT NULL COMMENT 'scale 1-10',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interview_fixed_questions`
--

CREATE TABLE `interview_fixed_questions` (
  `id` int(11) NOT NULL,
  `interviewId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `createdAt` datetime(1) NOT NULL,
  `updatedAt` datetime(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_fixed_questions`
--

INSERT INTO `interview_fixed_questions` (`id`, `interviewId`, `questionId`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, '2019-03-15 12:29:33.0', '2019-03-15 12:29:33.0'),
(2, 1, 2, '2019-03-15 12:29:33.0', '2019-03-15 12:29:33.0');

-- --------------------------------------------------------

--
-- Table structure for table `interview_question_template`
--

CREATE TABLE `interview_question_template` (
  `id` int(11) NOT NULL,
  `domainId` int(11) NOT NULL,
  `subDomainId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `expertLevelId` int(11) NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'in mins',
  `questionCount` int(11) NOT NULL,
  `organizationId` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interview_question_template_fixed_questions`
--

CREATE TABLE `interview_question_template_fixed_questions` (
  `id` int(11) NOT NULL,
  `interviewQuestionTemplateId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interview_types`
--

CREATE TABLE `interview_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_types`
--

INSERT INTO `interview_types` (`id`, `name`, `price`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'Async', '1.00', 'active', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Expert Review', '1.00', 'active', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `interview_type_map`
--

CREATE TABLE `interview_type_map` (
  `id` int(11) NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `interviews` int(11) NOT NULL,
  `days` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `expDate` date NOT NULL,
  `maxInterviews` int(11) NOT NULL COMMENT 'Max Interviews per person',
  `paymentMode` enum('cc','dc','paypal','cheque') NOT NULL,
  `paymentStatus` enum('open','inprogress','sucess','failed') NOT NULL,
  `paymentId` int(11) DEFAULT NULL,
  `couponCode` int(11) DEFAULT NULL,
  `cost` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','active','expired') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_type_map`
--

INSERT INTO `interview_type_map` (`id`, `organizationId`, `userId`, `interviews`, `days`, `startDate`, `expDate`, `maxInterviews`, `paymentMode`, `paymentStatus`, `paymentId`, `couponCode`, `cost`, `total`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 1, NULL, 10, 10, '2019-03-15', '2019-03-25', 3, 'cheque', 'sucess', 1, NULL, '20.00', '20.00', 'active', '2019-03-15 12:27:09', '2019-03-15 12:27:32');

-- --------------------------------------------------------

--
-- Table structure for table `interview_type_map_child`
--

CREATE TABLE `interview_type_map_child` (
  `id` int(11) NOT NULL,
  `interviewTypeMapId` int(11) NOT NULL,
  `interviewTypeId` int(11) NOT NULL,
  `avalbility` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_type_map_child`
--

INSERT INTO `interview_type_map_child` (`id`, `interviewTypeMapId`, `interviewTypeId`, `avalbility`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 9, '2019-03-15 12:27:09', '2019-03-15 12:34:09'),
(2, 1, 2, 10, '2019-03-15 12:27:09', '2019-03-15 12:27:09');

-- --------------------------------------------------------

--
-- Table structure for table `interview_users`
--

CREATE TABLE `interview_users` (
  `id` int(11) NOT NULL,
  `interviewId` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` enum('Available','Verified','Submitted','Completed','Reviewed','expertreview') NOT NULL,
  `paymentstatus` varchar(25) NOT NULL DEFAULT 'Success',
  `link` text NOT NULL,
  `pin` int(11) NOT NULL,
  `interviewTypeMapChildId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_users`
--

INSERT INTO `interview_users` (`id`, `interviewId`, `email`, `status`, `paymentstatus`, `link`, `pin`, `interviewTypeMapChildId`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'demobuddygap@gmail.com', 'expertreview', 'Success', 'none', 83679, 1, '2019-03-15 12:30:02', '2019-03-15 13:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `interview_user_questions`
--

CREATE TABLE `interview_user_questions` (
  `id` int(11) NOT NULL,
  `type` enum('fixed','random') NOT NULL,
  `interviewUserId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `questionTitle` text,
  `answerLink` text NOT NULL COMMENT 'Path to video link',
  `answerText` text NOT NULL COMMENT 'Converted text from audio',
  `ano` int(11) NOT NULL,
  `uid` text NOT NULL,
  `qTime` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0-open,1-submited',
  `maxCount` int(11) NOT NULL,
  `timeTaken` varchar(50) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interview_user_questions`
--

INSERT INTO `interview_user_questions` (`id`, `type`, `interviewUserId`, `questionId`, `questionTitle`, `answerLink`, `answerText`, `ano`, `uid`, `qTime`, `status`, `maxCount`, `timeTaken`, `createdAt`, `updatedAt`) VALUES
(1, 'fixed', 1, 1, 'Can you tell me a little about your  yourself?', '//www.cameratag.com/assets/v-43523f0a-3d6b-4de9-96b5-13a340e4055a/mp4.mp4', '', 1, 'v-43523f0a-3d6b-4de9-96b5-13a340e4055a', 15, 1, 5, ' 7', '2019-03-15 12:30:02', '2019-03-15 12:32:23'),
(2, 'fixed', 1, 2, 'What was your technical and logical experience?', '//www.cameratag.com/assets/v-7ac8a7a9-747d-4aab-87a7-ac9d44e693a4/mp4.mp4', '', 2, 'v-7ac8a7a9-747d-4aab-87a7-ac9d44e693a4', 15, 1, 5, ' 6', '2019-03-15 12:30:02', '2019-03-15 12:32:46'),
(3, 'random', 1, 6, 'Expalian ng-init directive', '//www.cameratag.com/assets/v-d7d446e9-84b8-4dd3-bdf4-0fa86b75c50d/mp4.mp4', '', 3, 'v-d7d446e9-84b8-4dd3-bdf4-0fa86b75c50d', 15, 1, 5, ' 9', '2019-03-15 12:30:02', '2019-03-15 12:33:06'),
(4, 'random', 1, 21, 'explain threads?', '//www.cameratag.com/assets/v-cd7838a3-43c8-48e8-b2fc-4b61dd953157/mp4.mp4', '', 4, 'v-cd7838a3-43c8-48e8-b2fc-4b61dd953157', 15, 1, 5, ' 4', '2019-03-15 12:30:02', '2019-03-15 12:33:34'),
(5, 'random', 1, 24, 'How memory is managed in Python?', '//www.cameratag.com/assets/v-412e1fb0-bd9a-417f-b9c2-795331e226a2/mp4.mp4', '', 5, 'v-412e1fb0-bd9a-417f-b9c2-795331e226a2', 15, 1, 5, ' 0', '2019-03-15 12:30:02', '2019-03-15 12:34:09');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `tableName` varchar(255) NOT NULL,
  `action` enum('insert','update','delete') NOT NULL,
  `remarks` text NOT NULL,
  `respectiveId` varchar(255) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `tableName`, `action`, `remarks`, `respectiveId`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'organization', 'insert', '{\"id\":1,\"name\":\"Gayathri\",\"type\":\"university\",\"url\":\"www.gayathri.org\",\"email\":\"gayathri123456@gmail.com\",\"updatedAt\":\"2019-03-15T12:17:50.174Z\",\"createdAt\":\"2019-03-15T12:17:50.174Z\"}', '1', 2, '2019-03-15 12:17:50', '2019-03-15 12:17:50'),
(2, 'organization_campus', 'insert', '{\"id\":1,\"branchName\":\"Gayathri Womens\",\"organizationId\":1,\"address\":\"Vizag\",\"city\":\"Vizag\",\"pincode\":\"530002\",\"url\":\"www.gayathri.org\",\"contactPerson\":\"Prasanth\",\"contactPersonEmail\":\"gayathri123456@gmail.com\",\"contactPersonPhone\":\"7878787877\",\"contactPersonDesgination\":\"Principal\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:17:50.180Z\",\"createdAt\":\"2019-03-15T12:17:50.180Z\"}', '1', 2, '2019-03-15 12:17:50', '2019-03-15 12:17:50'),
(3, 'exp_level', 'insert', '{\"id\":1,\"experiance\":\"0-2\",\"organizationId\":null,\"userId\":2,\"updatedAt\":\"2019-03-15T12:18:03.305Z\",\"createdAt\":\"2019-03-15T12:18:03.305Z\"}', '1', 2, '2019-03-15 12:18:03', '2019-03-15 12:18:03'),
(4, 'domain', 'insert', '{\"id\":1,\"domainName\":\"IT\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:18:18.968Z\",\"createdAt\":\"2019-03-15T12:18:18.968Z\"}', '1', 2, '2019-03-15 12:18:18', '2019-03-15 12:18:18'),
(5, 'sub_domains', 'insert', '{\"id\":1,\"subDomainName\":\"Angular\",\"domainId\":1,\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:18:18.973Z\",\"createdAt\":\"2019-03-15T12:18:18.973Z\"}', '1', 2, '2019-03-15 12:18:18', '2019-03-15 12:18:18'),
(6, 'users', 'insert', '{\"id\":3,\"fname\":\"Organization\",\"mname\":\"O\",\"lname\":\"O\",\"email\":\"org@test.com\",\"password\":\"34d68f31d650d0e060a1b1760ca01e59\",\"phone\":\"9898989898\",\"gender\":\"male\",\"status\":\"active\",\"roleId\":4,\"organizationId\":1,\"updatedAt\":\"2019-03-15T12:19:28.159Z\",\"createdAt\":\"2019-03-15T12:19:28.159Z\"}', '3', 2, '2019-03-15 12:19:28', '2019-03-15 12:19:28'),
(7, 'questions', 'insert', '{\"validate\":false,\"hooks\":true,\"individualHooks\":false,\"ignoreDuplicates\":false,\"fields\":[\"id\",\"question\",\"answer\",\"expLevelId\",\"time\",\"difficulty\",\"mandatory\",\"global\",\"domainId\",\"subDomainId\",\"keywords\",\"status\",\"organizationId\",\"userId\",\"createdAt\",\"updatedAt\"],\"auth\":2}', '[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]', 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(8, 'interview_type_map', 'insert', '{\"id\":1,\"organizationId\":1,\"days\":10,\"paymentStatus\":\"inprogress\",\"interviews\":\"10\",\"paymentMode\":\"cheque\",\"startDate\":\"2019-03-15\",\"maxInterviews\":\"3\",\"cost\":20,\"total\":20,\"status\":\"pending\",\"expDate\":\"2019-03-25\",\"updatedAt\":\"2019-03-15T12:27:09.206Z\",\"createdAt\":\"2019-03-15T12:27:09.206Z\"}', '1', 2, '2019-03-15 12:27:09', '2019-03-15 12:27:09'),
(9, 'interview_type_map_child', 'insert', '{\"validate\":false,\"hooks\":true,\"individualHooks\":false,\"ignoreDuplicates\":false,\"transaction\":{\"sequelize\":{\"options\":{\"dialect\":\"mysql\",\"dialectModulePath\":null,\"host\":\"127.0.0.1\",\"protocol\":\"tcp\",\"define\":{},\"query\":{},\"sync\":{},\"timezone\":\"+00:00\",\"omitNull\":false,\"native\":false,\"replication\":false,\"pool\":{},\"quoteIdentifiers\":true,\"hooks\":{\"afterCreate\":[null],\"afterUpdate\":[null],\"afterBulkUpdate\":[null],\"afterBulkCreate\":[null],\"beforeBulkDestroy\":[null],\"afterBulkDestroy\":[null]},\"retry\":{\"max\":5,\"match\":[\"SQLITE_BUSY: database is locked\"]},\"transactionType\":\"DEFERRED\",\"isolationLevel\":null,\"databaseVersion\":\"10.1.37-MariaDB\",\"typeValidation\":false,\"benchmark\":false,\"operatorsAliases\":false,\"username\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\"},\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"port\":3306,\"pool\":\"~transaction~sequelize~options~pool\",\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":{\"sequelize\":\"~transaction~sequelize\",\"connectionManager\":{\"sequelize\":\"~transaction~sequelize\",\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"pool\":{\"max\":5,\"min\":0,\"idle\":10000,\"acquire\":10000,\"evict\":10000,\"handleDisconnects\":true},\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":\"~transaction~sequelize~dialect\",\"versionPromise\":null,\"dialectName\":\"mysql\",\"pool\":{\"_events\":{},\"_eventsCount\":0,\"_config\":{\"fifo\":true,\"priorityRange\":1,\"testOnBorrow\":true,\"testOnReturn\":false,\"autostart\":false,\"acquireTimeoutMillis\":10000,\"max\":5,\"min\":0,\"evictionRunIntervalMillis\":10000,\"numTestsPerEvictionRun\":3,\"softIdleTimeoutMillis\":-1,\"idleTimeoutMillis\":10000},\"_factory\":{},\"_draining\":false,\"_started\":true,\"_waitingClientsQueue\":{\"_size\":1,\"_slots\":[{\"_list\":{\"head\":null,\"tail\":null,\"length\":0}}]},\"_factoryCreateOperations\":{},\"_factoryDestroyOperations\":{},\"_availableObjects\":{\"_list\":{\"head\":null,\"tail\":null,\"length\":0}},\"_testOnBorrowResources\":{},\"_testOnReturnResources\":{},\"_validationOperations\":{},\"_allObjects\":{},\"_resourceLoans\":{},\"_evictionIterator\":{\"_list\":\"~transaction~sequelize~dialect~connectionManager~pool~_availableObjects~_list\",\"_direction\":\"next\",\"_startPosition\":\"head\",\"_started\":false,\"_cursor\":null,\"_done\":false},\"_evictor\":{},\"_scheduledEviction\":{\"_idleTimeout\":10000,\"_idlePrev\":{\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"_idlePrev\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"expiry\":2092880,\"id\":-9007199254740613,\"msecs\":10000,\"priorityQueuePosition\":3},\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction~_idlePrev\",\"_idleStart\":2082880,\"_repeat\":null,\"_destroyed\":false}},\"lib\":{\"Types\":{\"DECIMAL\":0,\"TINY\":1,\"SHORT\":2,\"LONG\":3,\"FLOAT\":4,\"DOUBLE\":5,\"NULL\":6,\"TIMESTAMP\":7,\"LONGLONG\":8,\"INT24\":9,\"DATE\":10,\"TIME\":11,\"DATETIME\":12,\"YEAR\":13,\"NEWDATE\":14,\"VARCHAR\":15,\"BIT\":16,\"JSON\":245,\"NEWDECIMAL\":246,\"ENUM\":247,\"SET\":248,\"TINY_BLOB\":249,\"MEDIUM_BLOB\":250,\"LONG_BLOB\":251,\"BLOB\":252,\"VAR_STRING\":253,\"STRING\":254,\"GEOMETRY\":255},\"Charsets\":{\"BIG5_CHINESE_CI\":1,\"LATIN2_CZECH_CS\":2,\"DEC8_SWEDISH_CI\":3,\"CP850_GENERAL_CI\":4,\"LATIN1_GERMAN1_CI\":5,\"HP8_ENGLISH_CI\":6,\"KOI8R_GENERAL_CI\":7,\"LATIN1_SWEDISH_CI\":8,\"LATIN2_GENERAL_CI\":9,\"SWE7_SWEDISH_CI\":10,\"ASCII_GENERAL_CI\":11,\"UJIS_JAPANESE_CI\":12,\"SJIS_JAPANESE_CI\":13,\"CP1251_BULGARIAN_CI\":14,\"LATIN1_DANISH_CI\":15,\"HEBREW_GENERAL_CI\":16,\"TIS620_THAI_CI\":18,\"EUCKR_KOREAN_CI\":19,\"LATIN7_ESTONIAN_CS\":20,\"LATIN2_HUNGARIAN_CI\":21,\"KOI8U_GENERAL_CI\":22,\"CP1251_UKRAINIAN_CI\":23,\"GB2312_CHINESE_CI\":24,\"GREEK_GENERAL_CI\":25,\"CP1250_GENERAL_CI\":26,\"LATIN2_CROATIAN_CI\":27,\"GBK_CHINESE_CI\":28,\"CP1257_LITHUANIAN_CI\":29,\"LATIN5_TURKISH_CI\":30,\"LATIN1_GERMAN2_CI\":31,\"ARMSCII8_GENERAL_CI\":32,\"UTF8_GENERAL_CI\":33,\"CP1250_CZECH_CS\":34,\"UCS2_GENERAL_CI\":35,\"CP866_GENERAL_CI\":36,\"KEYBCS2_GENERAL_CI\":37,\"MACCE_GENERAL_CI\":38,\"MACROMAN_GENERAL_CI\":39,\"CP852_GENERAL_CI\":40,\"LATIN7_GENERAL_CI\":41,\"LATIN7_GENERAL_CS\":42,\"MACCE_BIN\":43,\"CP1250_CROATIAN_CI\":44,\"UTF8MB4_GENERAL_CI\":45,\"UTF8MB4_BIN\":46,\"LATIN1_BIN\":47,\"LATIN1_GENERAL_CI\":48,\"LATIN1_GENERAL_CS\":49,\"CP1251_BIN\":50,\"CP1251_GENERAL_CI\":51,\"CP1251_GENERAL_CS\":52,\"MACROMAN_BIN\":53,\"UTF16_GENERAL_CI\":54,\"UTF16_BIN\":55,\"UTF16LE_GENERAL_CI\":56,\"CP1256_GENERAL_CI\":57,\"CP1257_BIN\":58,\"CP1257_GENERAL_CI\":59,\"UTF32_GENERAL_CI\":60,\"UTF32_BIN\":61,\"UTF16LE_BIN\":62,\"BINARY\":63,\"ARMSCII8_BIN\":64,\"ASCII_BIN\":65,\"CP1250_BIN\":66,\"CP1256_BIN\":67,\"CP866_BIN\":68,\"DEC8_BIN\":69,\"GREEK_BIN\":70,\"HEBREW_BIN\":71,\"HP8_BIN\":72,\"KEYBCS2_BIN\":73,\"KOI8R_BIN\":74,\"KOI8U_BIN\":75,\"UTF8_TOLOWER_CI\":76,\"LATIN2_BIN\":77,\"LATIN5_BIN\":78,\"LATIN7_BIN\":79,\"CP850_BIN\":80,\"CP852_BIN\":81,\"SWE7_BIN\":82,\"UTF8_BIN\":83,\"BIG5_BIN\":84,\"EUCKR_BIN\":85,\"GB2312_BIN\":86,\"GBK_BIN\":87,\"SJIS_BIN\":88,\"TIS620_BIN\":89,\"UCS2_BIN\":90,\"UJIS_BIN\":91,\"GEOSTD8_GENERAL_CI\":92,\"GEOSTD8_BIN\":93,\"LATIN1_SPANISH_CI\":94,\"CP932_JAPANESE_CI\":95,\"CP932_BIN\":96,\"EUCJPMS_JAPANESE_CI\":97,\"EUCJPMS_BIN\":98,\"CP1250_POLISH_CI\":99,\"UTF16_UNICODE_CI\":101,\"UTF16_ICELANDIC_CI\":102,\"UTF16_LATVIAN_CI\":103,\"UTF16_ROMANIAN_CI\":104,\"UTF16_SLOVENIAN_CI\":105,\"UTF16_POLISH_CI\":106,\"UTF16_ESTONIAN_CI\":107,\"UTF16_SPANISH_CI\":108,\"UTF16_SWEDISH_CI\":109,\"UTF16_TURKISH_CI\":110,\"UTF16_CZECH_CI\":111,\"UTF16_DANISH_CI\":112,\"UTF16_LITHUANIAN_CI\":113,\"UTF16_SLOVAK_CI\":114,\"UTF16_SPANISH2_CI\":115,\"UTF16_ROMAN_CI\":116,\"UTF16_PERSIAN_CI\":117,\"UTF16_ESPERANTO_CI\":118,\"UTF16_HUNGARIAN_CI\":119,\"UTF16_SINHALA_CI\":120,\"UTF16_GERMAN2_CI\":121,\"UTF16_CROATIAN_CI\":122,\"UTF16_UNICODE_520_CI\":123,\"UTF16_VIETNAMESE_CI\":124,\"UCS2_UNICODE_CI\":128,\"UCS2_ICELANDIC_CI\":129,\"UCS2_LATVIAN_CI\":130,\"UCS2_ROMANIAN_CI\":131,\"UCS2_SLOVENIAN_CI\":132,\"UCS2_POLISH_CI\":133,\"UCS2_ESTONIAN_CI\":134,\"UCS2_SPANISH_CI\":135,\"UCS2_SWEDISH_CI\":136,\"UCS2_TURKISH_CI\":137,\"UCS2_CZECH_CI\":138,\"UCS2_DANISH_CI\":139,\"UCS2_LITHUANIAN_CI\":140,\"UCS2_SLOVAK_CI\":141,\"UCS2_SPANISH2_CI\":142,\"UCS2_ROMAN_CI\":143,\"UCS2_PERSIAN_CI\":144,\"UCS2_ESPERANTO_CI\":145,\"UCS2_HUNGARIAN_CI\":146,\"UCS2_SINHALA_CI\":147,\"UCS2_GERMAN2_CI\":148,\"UCS2_CROATIAN_CI\":149,\"UCS2_UNICODE_520_CI\":150,\"UCS2_VIETNAMESE_CI\":151,\"UCS2_GENERAL_MYSQL500_CI\":159,\"UTF32_UNICODE_CI\":160,\"UTF32_ICELANDIC_CI\":161,\"UTF32_LATVIAN_CI\":162,\"UTF32_ROMANIAN_CI\":163,\"UTF32_SLOVENIAN_CI\":164,\"UTF32_POLISH_CI\":165,\"UTF32_ESTONIAN_CI\":166,\"UTF32_SPANISH_CI\":167,\"UTF32_SWEDISH_CI\":168,\"UTF32_TURKISH_CI\":169,\"UTF32_CZECH_CI\":170,\"UTF32_DANISH_CI\":171,\"UTF32_LITHUANIAN_CI\":172,\"UTF32_SLOVAK_CI\":173,\"UTF32_SPANISH2_CI\":174,\"UTF32_ROMAN_CI\":175,\"UTF32_PERSIAN_CI\":176,\"UTF32_ESPERANTO_CI\":177,\"UTF32_HUNGARIAN_CI\":178,\"UTF32_SINHALA_CI\":179,\"UTF32_GERMAN2_CI\":180,\"UTF32_CROATIAN_CI\":181,\"UTF32_UNICODE_520_CI\":182,\"UTF32_VIETNAMESE_CI\":183,\"UTF8_UNICODE_CI\":192,\"UTF8_ICELANDIC_CI\":193,\"UTF8_LATVIAN_CI\":194,\"UTF8_ROMANIAN_CI\":195,\"UTF8_SLOVENIAN_CI\":196,\"UTF8_POLISH_CI\":197,\"UTF8_ESTONIAN_CI\":198,\"UTF8_SPANISH_CI\":199,\"UTF8_SWEDISH_CI\":200,\"UTF8_TURKISH_CI\":201,\"UTF8_CZECH_CI\":202,\"UTF8_DANISH_CI\":203,\"UTF8_LITHUANIAN_CI\":204,\"UTF8_SLOVAK_CI\":205,\"UTF8_SPANISH2_CI\":206,\"UTF8_ROMAN_CI\":207,\"UTF8_PERSIAN_CI\":208,\"UTF8_ESPERANTO_CI\":209,\"UTF8_HUNGARIAN_CI\":210,\"UTF8_SINHALA_CI\":211,\"UTF8_GERMAN2_CI\":212,\"UTF8_CROATIAN_CI\":213,\"UTF8_UNICODE_520_CI\":214,\"UTF8_VIETNAMESE_CI\":215,\"UTF8_GENERAL_MYSQL500_CI\":223,\"UTF8MB4_UNICODE_CI\":224,\"UTF8MB4_ICELANDIC_CI\":225,\"UTF8MB4_LATVIAN_CI\":226,\"UTF8MB4_ROMANIAN_CI\":227,\"UTF8MB4_SLOVENIAN_CI\":228,\"UTF8MB4_POLISH_CI\":229,\"UTF8MB4_ESTONIAN_CI\":230,\"UTF8MB4_SPANISH_CI\":231,\"UTF8MB4_SWEDISH_CI\":232,\"UTF8MB4_TURKISH_CI\":233,\"UTF8MB4_CZECH_CI\":234,\"UTF8MB4_DANISH_CI\":235,\"UTF8MB4_LITHUANIAN_CI\":236,\"UTF8MB4_SLOVAK_CI\":237,\"UTF8MB4_SPANISH2_CI\":238,\"UTF8MB4_ROMAN_CI\":239,\"UTF8MB4_PERSIAN_CI\":240,\"UTF8MB4_ESPERANTO_CI\":241,\"UTF8MB4_HUNGARIAN_CI\":242,\"UTF8MB4_SINHALA_CI\":243,\"UTF8MB4_GERMAN2_CI\":244,\"UTF8MB4_CROATIAN_CI\":245,\"UTF8MB4_UNICODE_520_CI\":246,\"UTF8MB4_VIETNAMESE_CI\":247,\"GB18030_CHINESE_CI\":248,\"GB18030_BIN\":249,\"GB18030_UNICODE_520_CI\":250,\"UTF8_GENERAL50_CI\":253,\"UTF8MB4_0900_AI_CI\":255,\"UTF8MB4_CS_0900_AI_CI\":266,\"UTF8MB4_DA_0900_AI_CI\":267,\"UTF8MB4_DE_PB_0900_AI_CI\":256,\"UTF8MB4_EO_0900_AI_CI\":273,\"UTF8MB4_ES_0900_AI_CI\":263,\"UTF8MB4_ES_TRAD_0900_AI_CI\":270,\"UTF8MB4_ET_0900_AI_CI\":262,\"UTF8MB4_HR_0900_AI_CI\":275,\"UTF8MB4_HU_0900_AI_CI\":274,\"UTF8MB4_IS_0900_AI_CI\":257,\"UTF8MB4_LA_0900_AI_CI\":271,\"UTF8MB4_LT_0900_AI_CI\":268,\"UTF8MB4_LV_0900_AI_CI\":258,\"UTF8MB4_PL_0900_AI_CI\":261,\"UTF8MB4_RO_0900_AI_CI\":259,\"UTF8MB4_SK_0900_AI_CI\":269,\"UTF8MB4_SL_0900_AI_CI\":260,\"UTF8MB4_SV_0900_AI_CI\":264,\"UTF8MB4_TR_0900_AI_CI\":265,\"UTF8MB4_VI_0900_AI_CI\":277,\"BIG5\":1,\"DEC8\":3,\"CP850\":4,\"HP8\":6,\"KOI8R\":7,\"LATIN1\":8,\"LATIN2\":9,\"SWE7\":10,\"ASCII\":11,\"UJIS\":12,\"SJIS\":13,\"HEBREW\":16,\"TIS620\":18,\"EUCKR\":19,\"KOI8U\":22,\"GB2312\":24,\"GREEK\":25,\"CP1250\":26,\"GBK\":28,\"LATIN5\":30,\"ARMSCII8\":32,\"UTF8\":33,\"UCS2\":35,\"CP866\":36,\"KEYBCS2\":37,\"MACCE\":38,\"MACROMAN\":39,\"CP852\":40,\"LATIN7\":41,\"UTF8MB4\":45,\"CP1251\":51,\"UTF16\":54,\"UTF16LE\":56,\"CP1256\":57,\"CP1257\":59,\"UTF32\":60,\"CP932\":95,\"EUCJPMS\":97,\"GB18030\":248,\"GEOSTD8\":92},\"CharsetToEncoding\":[\"utf8\",\"big5\",\"latin2\",\"dec8\",\"cp850\",\"latin1\",\"hp8\",\"koi8r\",\"latin1\",\"latin2\",\"swe7\",\"ascii\",\"eucjp\",\"sjis\",\"cp1251\",\"latin1\",\"hebrew\",\"utf8\",\"tis620\",\"euckr\",\"latin7\",\"latin2\",\"koi8u\",\"cp1251\",\"gb2312\",\"greek\",\"cp1250\",\"latin2\",\"gbk\",\"cp1257\",\"latin5\",\"latin1\",\"armscii8\",\"cesu8\",\"cp1250\",\"ucs2\",\"cp866\",\"keybcs2\",\"macintosh\",\"macroman\",\"cp852\",\"latin7\",\"latin7\",\"macintosh\",\"cp1250\",\"utf8\",\"utf8\",\"latin1\",\"latin1\",\"latin1\",\"cp1251\",\"cp1251\",\"cp1251\",\"macroman\",\"utf16\",\"utf16\",\"utf16-le\",\"cp1256\",\"cp1257\",\"cp1257\",\"utf32\",\"utf32\",\"utf16-le\",\"binary\",\"armscii8\",\"ascii\",\"cp1250\",\"cp1256\",\"cp866\",\"dec8\",\"greek\",\"hebrew\",\"hp8\",\"keybcs2\",\"koi8r\",\"koi8u\",\"cesu8\",\"latin2\",\"latin5\",\"latin7\",\"cp850\",\"cp852\",\"swe7\",\"cesu8\",\"big5\",\"euckr\",\"gb2312\",\"gbk\",\"sjis\",\"tis620\",\"ucs2\",\"eucjp\",\"geostd8\",\"geostd8\",\"latin1\",\"cp932\",\"cp932\",\"eucjpms\",\"eucjpms\",\"cp1250\",\"utf8\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"gb18030\",\"gb18030\",\"gb18030\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\"]}},\"QueryGenerator\":{\"dialect\":\"mysql\",\"OperatorMap\":{},\"_templateSettings\":{\"escape\":{},\"evaluate\":{},\"interpolate\":{},\"variable\":\"\",\"imports\":{}},\"options\":\"~transaction~sequelize~options\",\"OperatorsAliasMap\":false,\"_dialect\":\"~transaction~sequelize~dialect\",\"sequelize\":\"~transaction~sequelize\"}},\"queryInterface\":{\"sequelize\":\"~transaction~sequelize\",\"QueryGenerator\":\"~transaction~sequelize~dialect~QueryGenerator\"},\"models\":{},\"modelManager\":{\"models\":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],\"sequelize\":\"~transaction~sequelize\"},\"connectionManager\":\"~transaction~sequelize~dialect~connectionManager\",\"importCache\":{},\"test\":{\"_trackRunningQueries\":false,\"_runningQueries\":0}},\"savepoints\":[],\"_afterCommitHooks\":[],\"options\":{\"autocommit\":null,\"type\":\"DEFERRED\",\"isolationLevel\":null,\"readOnly\":false},\"id\":\"ff05fcec-ef6a-4ca9-8843-db9c33589d38\",\"connection\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":{\"reading\":true,\"onconnection\":null},\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":false,\"endEmitted\":false,\"reading\":true,\"sync\":false,\"needReadable\":true,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":false,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":true,\"_events\":{},\"_eventsCount\":4,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":false,\"needDrain\":false,\"ending\":false,\"ended\":false,\"finished\":false,\"destroyed\":false,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":0,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":true,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":42,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":2,\"compressedSequenceId\":0,\"threadId\":490,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":490,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[37,89,114,82,35,85,99,112]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[44,38,121,83,112,91,87,33,62,86,114,94]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":46,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":490,\"uuid\":\"ff05fcec-ef6a-4ca9-8843-db9c33589d38\"}},\"fields\":[\"id\",\"interviewTypeMapId\",\"interviewTypeId\",\"avalbility\",\"createdAt\",\"updatedAt\"],\"auth\":2}', '[1,2]', 2, '2019-03-15 12:27:09', '2019-03-15 12:27:09'),
(10, 'payments', 'insert', '{\"id\":1,\"mode\":\"cheque\",\"chequeNo\":\"252525\",\"price\":20,\"status\":\"inprogress\",\"bankName\":\"SBI\",\"updatedAt\":\"2019-03-15T12:27:09.503Z\",\"createdAt\":\"2019-03-15T12:27:09.503Z\"}', '1', 2, '2019-03-15 12:27:09', '2019-03-15 12:27:09'),
(11, 'interview_type_map', 'update', '{\"where\":{\"id\":1},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"paymentId\",\"updatedAt\"],\"attributes\":{\"paymentId\":1,\"updatedAt\":\"2019-03-15T12:27:09.510Z\"},\"auth\":2}', '{\"id\":1}', 2, '2019-03-15 12:27:09', '2019-03-15 12:27:09'),
(12, 'payments', 'update', '{\"where\":{\"id\":\"1\"},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"chequeClearedDate\",\"updatedAt\"],\"attributes\":{\"status\":\"sucess\",\"chequeClearedDate\":\"2019-03-15\",\"updatedAt\":\"2019-03-15T12:27:32.435Z\"},\"auth\":2}', '{\"id\":\"1\"}', 2, '2019-03-15 12:27:32', '2019-03-15 12:27:32'),
(13, 'interview_type_map', 'update', '{\"where\":{\"paymentId\":\"1\"},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"paymentStatus\",\"status\",\"updatedAt\"],\"attributes\":{\"paymentStatus\":\"sucess\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:27:32.440Z\"},\"auth\":2}', '{\"paymentId\":\"1\"}', 2, '2019-03-15 12:27:32', '2019-03-15 12:27:32'),
(14, 'report_perameters', 'insert', '{\"id\":1,\"name\":\"Communication\",\"organizationId\":1,\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:28:10.918Z\",\"createdAt\":\"2019-03-15T12:28:10.918Z\"}', '1', 3, '2019-03-15 12:28:10', '2019-03-15 12:28:10'),
(15, 'report_perameters', 'insert', '{\"id\":2,\"name\":\"Attitude\",\"organizationId\":1,\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:28:19.998Z\",\"createdAt\":\"2019-03-15T12:28:19.998Z\"}', '2', 3, '2019-03-15 12:28:20', '2019-03-15 12:28:20'),
(16, 'report_perameters', 'insert', '{\"id\":3,\"name\":\"Soft Skills\",\"organizationId\":1,\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:28:27.791Z\",\"createdAt\":\"2019-03-15T12:28:27.791Z\"}', '3', 3, '2019-03-15 12:28:27', '2019-03-15 12:28:27'),
(17, 'interview', 'insert', '{\"id\":1,\"type\":\"async\",\"domainId\":1,\"interviewId\":\"AI01001-000001\",\"subDomainId\":1,\"expLevelId\":1,\"start_date\":\"2019-03-15T00:00:00.000Z\",\"end_date\":\"2019-03-23T00:00:00.000Z\",\"duration\":\"15\",\"questionCount\":\"5\",\"organizationId\":1,\"userId\":3,\"interviewName\":\"007\",\"updatedAt\":\"2019-03-15T12:29:33.337Z\",\"createdAt\":\"2019-03-15T12:29:33.337Z\"}', '1', 3, '2019-03-15 12:29:33', '2019-03-15 12:29:33'),
(18, 'interview_fixed_questions', 'insert', '{\"validate\":false,\"hooks\":true,\"individualHooks\":false,\"ignoreDuplicates\":false,\"transaction\":{\"sequelize\":{\"options\":{\"dialect\":\"mysql\",\"dialectModulePath\":null,\"host\":\"127.0.0.1\",\"protocol\":\"tcp\",\"define\":{},\"query\":{},\"sync\":{},\"timezone\":\"+00:00\",\"omitNull\":false,\"native\":false,\"replication\":false,\"pool\":{},\"quoteIdentifiers\":true,\"hooks\":{\"afterCreate\":[null],\"afterUpdate\":[null],\"afterBulkUpdate\":[null],\"afterBulkCreate\":[null],\"beforeBulkDestroy\":[null],\"afterBulkDestroy\":[null]},\"retry\":{\"max\":5,\"match\":[\"SQLITE_BUSY: database is locked\"]},\"transactionType\":\"DEFERRED\",\"isolationLevel\":null,\"databaseVersion\":\"10.1.37-MariaDB\",\"typeValidation\":false,\"benchmark\":false,\"operatorsAliases\":false,\"username\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\"},\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"port\":3306,\"pool\":\"~transaction~sequelize~options~pool\",\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":{\"sequelize\":\"~transaction~sequelize\",\"connectionManager\":{\"sequelize\":\"~transaction~sequelize\",\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"pool\":{\"max\":5,\"min\":0,\"idle\":10000,\"acquire\":10000,\"evict\":10000,\"handleDisconnects\":true},\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":\"~transaction~sequelize~dialect\",\"versionPromise\":null,\"dialectName\":\"mysql\",\"pool\":{\"_events\":{},\"_eventsCount\":0,\"_config\":{\"fifo\":true,\"priorityRange\":1,\"testOnBorrow\":true,\"testOnReturn\":false,\"autostart\":false,\"acquireTimeoutMillis\":10000,\"max\":5,\"min\":0,\"evictionRunIntervalMillis\":10000,\"numTestsPerEvictionRun\":3,\"softIdleTimeoutMillis\":-1,\"idleTimeoutMillis\":10000},\"_factory\":{},\"_draining\":false,\"_started\":true,\"_waitingClientsQueue\":{\"_size\":1,\"_slots\":[{\"_list\":{\"head\":null,\"tail\":null,\"length\":0}}]},\"_factoryCreateOperations\":{},\"_factoryDestroyOperations\":{},\"_availableObjects\":{\"_list\":{\"head\":{\"prev\":null,\"next\":null,\"data\":{\"creationTime\":1552652973337,\"lastReturnTime\":1552652973345,\"lastBorrowTime\":1552652973343,\"lastIdleTime\":1552652973345,\"obj\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":{\"reading\":true,\"onconnection\":null},\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":false,\"endEmitted\":false,\"reading\":true,\"sync\":false,\"needReadable\":true,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":false,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":true,\"_events\":{},\"_eventsCount\":4,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":false,\"needDrain\":false,\"ending\":false,\"ended\":false,\"finished\":false,\"destroyed\":false,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":0,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":true,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":53,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":2,\"compressedSequenceId\":0,\"threadId\":501,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":501,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[94,89,34,59,68,36,37,46]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[85,67,48,99,36,38,50,104,54,116,100,122]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":7,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":501},\"state\":\"IDLE\"}},\"tail\":\"~transaction~sequelize~dialect~connectionManager~pool~_availableObjects~_list~head\",\"length\":1}},\"_testOnBorrowResources\":{},\"_testOnReturnResources\":{},\"_validationOperations\":{},\"_allObjects\":{},\"_resourceLoans\":{},\"_evictionIterator\":{\"_list\":\"~transaction~sequelize~dialect~connectionManager~pool~_availableObjects~_list\",\"_direction\":\"next\",\"_startPosition\":\"head\",\"_started\":true,\"_cursor\":{\"prev\":null,\"next\":null,\"data\":{\"creationTime\":1552652910537,\"lastReturnTime\":1552652925950,\"lastBorrowTime\":1552652925949,\"lastIdleTime\":1552652925950,\"obj\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":null,\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":true,\"endEmitted\":true,\"reading\":false,\"sync\":false,\"needReadable\":false,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":true,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":false,\"_events\":{},\"_eventsCount\":5,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":true,\"needDrain\":false,\"ending\":true,\"ended\":true,\"finished\":false,\"destroyed\":true,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":1,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":false,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":49,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":1,\"compressedSequenceId\":0,\"threadId\":497,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":497,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[78,91,95,73,46,76,116,36]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[80,73,90,108,47,69,75,41,43,59,39,82]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":5,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":497,\"_closing\":true},\"state\":\"INVALID\"}},\"_done\":false},\"_evictor\":{},\"_scheduledEviction\":{\"_idleTimeout\":10000,\"_idlePrev\":{\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"_idlePrev\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"expiry\":2242883,\"id\":-9007199254740557,\"msecs\":10000,\"priorityQueuePosition\":3},\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction~_idlePrev\",\"_idleStart\":2232883,\"_repeat\":null,\"_destroyed\":false}},\"lib\":{\"Types\":{\"DECIMAL\":0,\"TINY\":1,\"SHORT\":2,\"LONG\":3,\"FLOAT\":4,\"DOUBLE\":5,\"NULL\":6,\"TIMESTAMP\":7,\"LONGLONG\":8,\"INT24\":9,\"DATE\":10,\"TIME\":11,\"DATETIME\":12,\"YEAR\":13,\"NEWDATE\":14,\"VARCHAR\":15,\"BIT\":16,\"JSON\":245,\"NEWDECIMAL\":246,\"ENUM\":247,\"SET\":248,\"TINY_BLOB\":249,\"MEDIUM_BLOB\":250,\"LONG_BLOB\":251,\"BLOB\":252,\"VAR_STRING\":253,\"STRING\":254,\"GEOMETRY\":255},\"Charsets\":{\"BIG5_CHINESE_CI\":1,\"LATIN2_CZECH_CS\":2,\"DEC8_SWEDISH_CI\":3,\"CP850_GENERAL_CI\":4,\"LATIN1_GERMAN1_CI\":5,\"HP8_ENGLISH_CI\":6,\"KOI8R_GENERAL_CI\":7,\"LATIN1_SWEDISH_CI\":8,\"LATIN2_GENERAL_CI\":9,\"SWE7_SWEDISH_CI\":10,\"ASCII_GENERAL_CI\":11,\"UJIS_JAPANESE_CI\":12,\"SJIS_JAPANESE_CI\":13,\"CP1251_BULGARIAN_CI\":14,\"LATIN1_DANISH_CI\":15,\"HEBREW_GENERAL_CI\":16,\"TIS620_THAI_CI\":18,\"EUCKR_KOREAN_CI\":19,\"LATIN7_ESTONIAN_CS\":20,\"LATIN2_HUNGARIAN_CI\":21,\"KOI8U_GENERAL_CI\":22,\"CP1251_UKRAINIAN_CI\":23,\"GB2312_CHINESE_CI\":24,\"GREEK_GENERAL_CI\":25,\"CP1250_GENERAL_CI\":26,\"LATIN2_CROATIAN_CI\":27,\"GBK_CHINESE_CI\":28,\"CP1257_LITHUANIAN_CI\":29,\"LATIN5_TURKISH_CI\":30,\"LATIN1_GERMAN2_CI\":31,\"ARMSCII8_GENERAL_CI\":32,\"UTF8_GENERAL_CI\":33,\"CP1250_CZECH_CS\":34,\"UCS2_GENERAL_CI\":35,\"CP866_GENERAL_CI\":36,\"KEYBCS2_GENERAL_CI\":37,\"MACCE_GENERAL_CI\":38,\"MACROMAN_GENERAL_CI\":39,\"CP852_GENERAL_CI\":40,\"LATIN7_GENERAL_CI\":41,\"LATIN7_GENERAL_CS\":42,\"MACCE_BIN\":43,\"CP1250_CROATIAN_CI\":44,\"UTF8MB4_GENERAL_CI\":45,\"UTF8MB4_BIN\":46,\"LATIN1_BIN\":47,\"LATIN1_GENERAL_CI\":48,\"LATIN1_GENERAL_CS\":49,\"CP1251_BIN\":50,\"CP1251_GENERAL_CI\":51,\"CP1251_GENERAL_CS\":52,\"MACROMAN_BIN\":53,\"UTF16_GENERAL_CI\":54,\"UTF16_BIN\":55,\"UTF16LE_GENERAL_CI\":56,\"CP1256_GENERAL_CI\":57,\"CP1257_BIN\":58,\"CP1257_GENERAL_CI\":59,\"UTF32_GENERAL_CI\":60,\"UTF32_BIN\":61,\"UTF16LE_BIN\":62,\"BINARY\":63,\"ARMSCII8_BIN\":64,\"ASCII_BIN\":65,\"CP1250_BIN\":66,\"CP1256_BIN\":67,\"CP866_BIN\":68,\"DEC8_BIN\":69,\"GREEK_BIN\":70,\"HEBREW_BIN\":71,\"HP8_BIN\":72,\"KEYBCS2_BIN\":73,\"KOI8R_BIN\":74,\"KOI8U_BIN\":75,\"UTF8_TOLOWER_CI\":76,\"LATIN2_BIN\":77,\"LATIN5_BIN\":78,\"LATIN7_BIN\":79,\"CP850_BIN\":80,\"CP852_BIN\":81,\"SWE7_BIN\":82,\"UTF8_BIN\":83,\"BIG5_BIN\":84,\"EUCKR_BIN\":85,\"GB2312_BIN\":86,\"GBK_BIN\":87,\"SJIS_BIN\":88,\"TIS620_BIN\":89,\"UCS2_BIN\":90,\"UJIS_BIN\":91,\"GEOSTD8_GENERAL_CI\":92,\"GEOSTD8_BIN\":93,\"LATIN1_SPANISH_CI\":94,\"CP932_JAPANESE_CI\":95,\"CP932_BIN\":96,\"EUCJPMS_JAPANESE_CI\":97,\"EUCJPMS_BIN\":98,\"CP1250_POLISH_CI\":99,\"UTF16_UNICODE_CI\":101,\"UTF16_ICELANDIC_CI\":102,\"UTF16_LATVIAN_CI\":103,\"UTF16_ROMANIAN_CI\":104,\"UTF16_SLOVENIAN_CI\":105,\"UTF16_POLISH_CI\":106,\"UTF16_ESTONIAN_CI\":107,\"UTF16_SPANISH_CI\":108,\"UTF16_SWEDISH_CI\":109,\"UTF16_TURKISH_CI\":110,\"UTF16_CZECH_CI\":111,\"UTF16_DANISH_CI\":112,\"UTF16_LITHUANIAN_CI\":113,\"UTF16_SLOVAK_CI\":114,\"UTF16_SPANISH2_CI\":115,\"UTF16_ROMAN_CI\":116,\"UTF16_PERSIAN_CI\":117,\"UTF16_ESPERANTO_CI\":118,\"UTF16_HUNGARIAN_CI\":119,\"UTF16_SINHALA_CI\":120,\"UTF16_GERMAN2_CI\":121,\"UTF16_CROATIAN_CI\":122,\"UTF16_UNICODE_520_CI\":123,\"UTF16_VIETNAMESE_CI\":124,\"UCS2_UNICODE_CI\":128,\"UCS2_ICELANDIC_CI\":129,\"UCS2_LATVIAN_CI\":130,\"UCS2_ROMANIAN_CI\":131,\"UCS2_SLOVENIAN_CI\":132,\"UCS2_POLISH_CI\":133,\"UCS2_ESTONIAN_CI\":134,\"UCS2_SPANISH_CI\":135,\"UCS2_SWEDISH_CI\":136,\"UCS2_TURKISH_CI\":137,\"UCS2_CZECH_CI\":138,\"UCS2_DANISH_CI\":139,\"UCS2_LITHUANIAN_CI\":140,\"UCS2_SLOVAK_CI\":141,\"UCS2_SPANISH2_CI\":142,\"UCS2_ROMAN_CI\":143,\"UCS2_PERSIAN_CI\":144,\"UCS2_ESPERANTO_CI\":145,\"UCS2_HUNGARIAN_CI\":146,\"UCS2_SINHALA_CI\":147,\"UCS2_GERMAN2_CI\":148,\"UCS2_CROATIAN_CI\":149,\"UCS2_UNICODE_520_CI\":150,\"UCS2_VIETNAMESE_CI\":151,\"UCS2_GENERAL_MYSQL500_CI\":159,\"UTF32_UNICODE_CI\":160,\"UTF32_ICELANDIC_CI\":161,\"UTF32_LATVIAN_CI\":162,\"UTF32_ROMANIAN_CI\":163,\"UTF32_SLOVENIAN_CI\":164,\"UTF32_POLISH_CI\":165,\"UTF32_ESTONIAN_CI\":166,\"UTF32_SPANISH_CI\":167,\"UTF32_SWEDISH_CI\":168,\"UTF32_TURKISH_CI\":169,\"UTF32_CZECH_CI\":170,\"UTF32_DANISH_CI\":171,\"UTF32_LITHUANIAN_CI\":172,\"UTF32_SLOVAK_CI\":173,\"UTF32_SPANISH2_CI\":174,\"UTF32_ROMAN_CI\":175,\"UTF32_PERSIAN_CI\":176,\"UTF32_ESPERANTO_CI\":177,\"UTF32_HUNGARIAN_CI\":178,\"UTF32_SINHALA_CI\":179,\"UTF32_GERMAN2_CI\":180,\"UTF32_CROATIAN_CI\":181,\"UTF32_UNICODE_520_CI\":182,\"UTF32_VIETNAMESE_CI\":183,\"UTF8_UNICODE_CI\":192,\"UTF8_ICELANDIC_CI\":193,\"UTF8_LATVIAN_CI\":194,\"UTF8_ROMANIAN_CI\":195,\"UTF8_SLOVENIAN_CI\":196,\"UTF8_POLISH_CI\":197,\"UTF8_ESTONIAN_CI\":198,\"UTF8_SPANISH_CI\":199,\"UTF8_SWEDISH_CI\":200,\"UTF8_TURKISH_CI\":201,\"UTF8_CZECH_CI\":202,\"UTF8_DANISH_CI\":203,\"UTF8_LITHUANIAN_CI\":204,\"UTF8_SLOVAK_CI\":205,\"UTF8_SPANISH2_CI\":206,\"UTF8_ROMAN_CI\":207,\"UTF8_PERSIAN_CI\":208,\"UTF8_ESPERANTO_CI\":209,\"UTF8_HUNGARIAN_CI\":210,\"UTF8_SINHALA_CI\":211,\"UTF8_GERMAN2_CI\":212,\"UTF8_CROATIAN_CI\":213,\"UTF8_UNICODE_520_CI\":214,\"UTF8_VIETNAMESE_CI\":215,\"UTF8_GENERAL_MYSQL500_CI\":223,\"UTF8MB4_UNICODE_CI\":224,\"UTF8MB4_ICELANDIC_CI\":225,\"UTF8MB4_LATVIAN_CI\":226,\"UTF8MB4_ROMANIAN_CI\":227,\"UTF8MB4_SLOVENIAN_CI\":228,\"UTF8MB4_POLISH_CI\":229,\"UTF8MB4_ESTONIAN_CI\":230,\"UTF8MB4_SPANISH_CI\":231,\"UTF8MB4_SWEDISH_CI\":232,\"UTF8MB4_TURKISH_CI\":233,\"UTF8MB4_CZECH_CI\":234,\"UTF8MB4_DANISH_CI\":235,\"UTF8MB4_LITHUANIAN_CI\":236,\"UTF8MB4_SLOVAK_CI\":237,\"UTF8MB4_SPANISH2_CI\":238,\"UTF8MB4_ROMAN_CI\":239,\"UTF8MB4_PERSIAN_CI\":240,\"UTF8MB4_ESPERANTO_CI\":241,\"UTF8MB4_HUNGARIAN_CI\":242,\"UTF8MB4_SINHALA_CI\":243,\"UTF8MB4_GERMAN2_CI\":244,\"UTF8MB4_CROATIAN_CI\":245,\"UTF8MB4_UNICODE_520_CI\":246,\"UTF8MB4_VIETNAMESE_CI\":247,\"GB18030_CHINESE_CI\":248,\"GB18030_BIN\":249,\"GB18030_UNICODE_520_CI\":250,\"UTF8_GENERAL50_CI\":253,\"UTF8MB4_0900_AI_CI\":255,\"UTF8MB4_CS_0900_AI_CI\":266,\"UTF8MB4_DA_0900_AI_CI\":267,\"UTF8MB4_DE_PB_0900_AI_CI\":256,\"UTF8MB4_EO_0900_AI_CI\":273,\"UTF8MB4_ES_0900_AI_CI\":263,\"UTF8MB4_ES_TRAD_0900_AI_CI\":270,\"UTF8MB4_ET_0900_AI_CI\":262,\"UTF8MB4_HR_0900_AI_CI\":275,\"UTF8MB4_HU_0900_AI_CI\":274,\"UTF8MB4_IS_0900_AI_CI\":257,\"UTF8MB4_LA_0900_AI_CI\":271,\"UTF8MB4_LT_0900_AI_CI\":268,\"UTF8MB4_LV_0900_AI_CI\":258,\"UTF8MB4_PL_0900_AI_CI\":261,\"UTF8MB4_RO_0900_AI_CI\":259,\"UTF8MB4_SK_0900_AI_CI\":269,\"UTF8MB4_SL_0900_AI_CI\":260,\"UTF8MB4_SV_0900_AI_CI\":264,\"UTF8MB4_TR_0900_AI_CI\":265,\"UTF8MB4_VI_0900_AI_CI\":277,\"BIG5\":1,\"DEC8\":3,\"CP850\":4,\"HP8\":6,\"KOI8R\":7,\"LATIN1\":8,\"LATIN2\":9,\"SWE7\":10,\"ASCII\":11,\"UJIS\":12,\"SJIS\":13,\"HEBREW\":16,\"TIS620\":18,\"EUCKR\":19,\"KOI8U\":22,\"GB2312\":24,\"GREEK\":25,\"CP1250\":26,\"GBK\":28,\"LATIN5\":30,\"ARMSCII8\":32,\"UTF8\":33,\"UCS2\":35,\"CP866\":36,\"KEYBCS2\":37,\"MACCE\":38,\"MACROMAN\":39,\"CP852\":40,\"LATIN7\":41,\"UTF8MB4\":45,\"CP1251\":51,\"UTF16\":54,\"UTF16LE\":56,\"CP1256\":57,\"CP1257\":59,\"UTF32\":60,\"CP932\":95,\"EUCJPMS\":97,\"GB18030\":248,\"GEOSTD8\":92},\"CharsetToEncoding\":[\"utf8\",\"big5\",\"latin2\",\"dec8\",\"cp850\",\"latin1\",\"hp8\",\"koi8r\",\"latin1\",\"latin2\",\"swe7\",\"ascii\",\"eucjp\",\"sjis\",\"cp1251\",\"latin1\",\"hebrew\",\"utf8\",\"tis620\",\"euckr\",\"latin7\",\"latin2\",\"koi8u\",\"cp1251\",\"gb2312\",\"greek\",\"cp1250\",\"latin2\",\"gbk\",\"cp1257\",\"latin5\",\"latin1\",\"armscii8\",\"cesu8\",\"cp1250\",\"ucs2\",\"cp866\",\"keybcs2\",\"macintosh\",\"macroman\",\"cp852\",\"latin7\",\"latin7\",\"macintosh\",\"cp1250\",\"utf8\",\"utf8\",\"latin1\",\"latin1\",\"latin1\",\"cp1251\",\"cp1251\",\"cp1251\",\"macroman\",\"utf16\",\"utf16\",\"utf16-le\",\"cp1256\",\"cp1257\",\"cp1257\",\"utf32\",\"utf32\",\"utf16-le\",\"binary\",\"armscii8\",\"ascii\",\"cp1250\",\"cp1256\",\"cp866\",\"dec8\",\"greek\",\"hebrew\",\"hp8\",\"keybcs2\",\"koi8r\",\"koi8u\",\"cesu8\",\"latin2\",\"latin5\",\"latin7\",\"cp850\",\"cp852\",\"swe7\",\"cesu8\",\"big5\",\"euckr\",\"gb2312\",\"gbk\",\"sjis\",\"tis620\",\"ucs2\",\"eucjp\",\"geostd8\",\"geostd8\",\"latin1\",\"cp932\",\"cp932\",\"eucjpms\",\"eucjpms\",\"cp1250\",\"utf8\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"gb18030\",\"gb18030\",\"gb18030\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\"]}},\"QueryGenerator\":{\"dialect\":\"mysql\",\"OperatorMap\":{},\"_templateSettings\":{\"escape\":{},\"evaluate\":{},\"interpolate\":{},\"variable\":\"\",\"imports\":{}},\"options\":\"~transaction~sequelize~options\",\"OperatorsAliasMap\":false,\"_dialect\":\"~transaction~sequelize~dialect\",\"sequelize\":\"~transaction~sequelize\"}},\"queryInterface\":{\"sequelize\":\"~transaction~sequelize\",\"QueryGenerator\":\"~transaction~sequelize~dialect~QueryGenerator\"},\"models\":{},\"modelManager\":{\"models\":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],\"sequelize\":\"~transaction~sequelize\"},\"connectionManager\":\"~transaction~sequelize~dialect~connectionManager\",\"importCache\":{},\"test\":{\"_trackRunningQueries\":false,\"_runningQueries\":0}},\"savepoints\":[],\"_afterCommitHooks\":[],\"options\":{\"autocommit\":null,\"type\":\"DEFERRED\",\"isolationLevel\":null,\"readOnly\":false},\"id\":\"6109226e-e59b-4745-bfea-d96e6c4e690f\",\"connection\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":{\"reading\":true,\"onconnection\":null},\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":false,\"endEmitted\":false,\"reading\":true,\"sync\":false,\"needReadable\":true,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":false,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":true,\"_events\":{},\"_eventsCount\":4,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":false,\"needDrain\":false,\"ending\":false,\"ended\":false,\"finished\":false,\"destroyed\":false,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":0,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":true,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":52,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":2,\"compressedSequenceId\":0,\"threadId\":500,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":500,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[70,41,59,43,99,53,125,56]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[60,98,93,42,87,88,54,65,39,60,57,71]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":46,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":500,\"uuid\":\"6109226e-e59b-4745-bfea-d96e6c4e690f\"}},\"fields\":[\"id\",\"interviewId\",\"questionId\",\"createdAt\",\"updatedAt\"],\"auth\":3}', '[1,2]', 3, '2019-03-15 12:29:33', '2019-03-15 12:29:33');
INSERT INTO `logs` (`id`, `tableName`, `action`, `remarks`, `respectiveId`, `userId`, `createdAt`, `updatedAt`) VALUES
(19, 'interview_users', 'insert', '{\"validate\":false,\"hooks\":true,\"individualHooks\":false,\"ignoreDuplicates\":false,\"transaction\":{\"sequelize\":{\"options\":{\"dialect\":\"mysql\",\"dialectModulePath\":null,\"host\":\"127.0.0.1\",\"protocol\":\"tcp\",\"define\":{},\"query\":{},\"sync\":{},\"timezone\":\"+00:00\",\"omitNull\":false,\"native\":false,\"replication\":false,\"pool\":{},\"quoteIdentifiers\":true,\"hooks\":{\"afterCreate\":[null],\"afterUpdate\":[null],\"afterBulkUpdate\":[null],\"afterBulkCreate\":[null],\"beforeBulkDestroy\":[null],\"afterBulkDestroy\":[null]},\"retry\":{\"max\":5,\"match\":[\"SQLITE_BUSY: database is locked\"]},\"transactionType\":\"DEFERRED\",\"isolationLevel\":null,\"databaseVersion\":\"10.1.37-MariaDB\",\"typeValidation\":false,\"benchmark\":false,\"operatorsAliases\":false,\"username\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\"},\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"port\":3306,\"pool\":\"~transaction~sequelize~options~pool\",\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":{\"sequelize\":\"~transaction~sequelize\",\"connectionManager\":{\"sequelize\":\"~transaction~sequelize\",\"config\":{\"database\":\"ib_new\",\"username\":\"root\",\"password\":\"1234\",\"host\":\"127.0.0.1\",\"pool\":{\"max\":5,\"min\":0,\"idle\":10000,\"acquire\":10000,\"evict\":10000,\"handleDisconnects\":true},\"protocol\":\"tcp\",\"native\":false,\"replication\":false,\"dialectModulePath\":null},\"dialect\":\"~transaction~sequelize~dialect\",\"versionPromise\":null,\"dialectName\":\"mysql\",\"pool\":{\"_events\":{},\"_eventsCount\":0,\"_config\":{\"fifo\":true,\"priorityRange\":1,\"testOnBorrow\":true,\"testOnReturn\":false,\"autostart\":false,\"acquireTimeoutMillis\":10000,\"max\":5,\"min\":0,\"evictionRunIntervalMillis\":10000,\"numTestsPerEvictionRun\":3,\"softIdleTimeoutMillis\":-1,\"idleTimeoutMillis\":10000},\"_factory\":{},\"_draining\":false,\"_started\":true,\"_waitingClientsQueue\":{\"_size\":1,\"_slots\":[{\"_list\":{\"head\":null,\"tail\":null,\"length\":0}}]},\"_factoryCreateOperations\":{},\"_factoryDestroyOperations\":{},\"_availableObjects\":{\"_list\":{\"head\":null,\"tail\":null,\"length\":0}},\"_testOnBorrowResources\":{},\"_testOnReturnResources\":{},\"_validationOperations\":{},\"_allObjects\":{},\"_resourceLoans\":{},\"_evictionIterator\":{\"_list\":\"~transaction~sequelize~dialect~connectionManager~pool~_availableObjects~_list\",\"_direction\":\"next\",\"_startPosition\":\"head\",\"_started\":true,\"_cursor\":{\"prev\":null,\"next\":null,\"data\":{\"creationTime\":1552652973337,\"lastReturnTime\":1552652976358,\"lastBorrowTime\":1552652976358,\"lastIdleTime\":1552652976358,\"obj\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":null,\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":true,\"endEmitted\":true,\"reading\":false,\"sync\":false,\"needReadable\":false,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":true,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":false,\"_events\":{},\"_eventsCount\":5,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":true,\"needDrain\":false,\"ending\":true,\"ended\":true,\"finished\":false,\"destroyed\":true,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":1,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":false,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":53,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":1,\"compressedSequenceId\":0,\"threadId\":501,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":501,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[94,89,34,59,68,36,37,46]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[85,67,48,99,36,38,50,104,54,116,100,122]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":5,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":501,\"_closing\":true},\"state\":\"INVALID\"}},\"_done\":false},\"_evictor\":{},\"_scheduledEviction\":{\"_idleTimeout\":10000,\"_idlePrev\":{\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"_idlePrev\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction\",\"expiry\":2272884,\"id\":-9007199254740551,\"msecs\":10000,\"priorityQueuePosition\":3},\"_idleNext\":\"~transaction~sequelize~dialect~connectionManager~pool~_scheduledEviction~_idlePrev\",\"_idleStart\":2262884,\"_repeat\":null,\"_destroyed\":false}},\"lib\":{\"Types\":{\"DECIMAL\":0,\"TINY\":1,\"SHORT\":2,\"LONG\":3,\"FLOAT\":4,\"DOUBLE\":5,\"NULL\":6,\"TIMESTAMP\":7,\"LONGLONG\":8,\"INT24\":9,\"DATE\":10,\"TIME\":11,\"DATETIME\":12,\"YEAR\":13,\"NEWDATE\":14,\"VARCHAR\":15,\"BIT\":16,\"JSON\":245,\"NEWDECIMAL\":246,\"ENUM\":247,\"SET\":248,\"TINY_BLOB\":249,\"MEDIUM_BLOB\":250,\"LONG_BLOB\":251,\"BLOB\":252,\"VAR_STRING\":253,\"STRING\":254,\"GEOMETRY\":255},\"Charsets\":{\"BIG5_CHINESE_CI\":1,\"LATIN2_CZECH_CS\":2,\"DEC8_SWEDISH_CI\":3,\"CP850_GENERAL_CI\":4,\"LATIN1_GERMAN1_CI\":5,\"HP8_ENGLISH_CI\":6,\"KOI8R_GENERAL_CI\":7,\"LATIN1_SWEDISH_CI\":8,\"LATIN2_GENERAL_CI\":9,\"SWE7_SWEDISH_CI\":10,\"ASCII_GENERAL_CI\":11,\"UJIS_JAPANESE_CI\":12,\"SJIS_JAPANESE_CI\":13,\"CP1251_BULGARIAN_CI\":14,\"LATIN1_DANISH_CI\":15,\"HEBREW_GENERAL_CI\":16,\"TIS620_THAI_CI\":18,\"EUCKR_KOREAN_CI\":19,\"LATIN7_ESTONIAN_CS\":20,\"LATIN2_HUNGARIAN_CI\":21,\"KOI8U_GENERAL_CI\":22,\"CP1251_UKRAINIAN_CI\":23,\"GB2312_CHINESE_CI\":24,\"GREEK_GENERAL_CI\":25,\"CP1250_GENERAL_CI\":26,\"LATIN2_CROATIAN_CI\":27,\"GBK_CHINESE_CI\":28,\"CP1257_LITHUANIAN_CI\":29,\"LATIN5_TURKISH_CI\":30,\"LATIN1_GERMAN2_CI\":31,\"ARMSCII8_GENERAL_CI\":32,\"UTF8_GENERAL_CI\":33,\"CP1250_CZECH_CS\":34,\"UCS2_GENERAL_CI\":35,\"CP866_GENERAL_CI\":36,\"KEYBCS2_GENERAL_CI\":37,\"MACCE_GENERAL_CI\":38,\"MACROMAN_GENERAL_CI\":39,\"CP852_GENERAL_CI\":40,\"LATIN7_GENERAL_CI\":41,\"LATIN7_GENERAL_CS\":42,\"MACCE_BIN\":43,\"CP1250_CROATIAN_CI\":44,\"UTF8MB4_GENERAL_CI\":45,\"UTF8MB4_BIN\":46,\"LATIN1_BIN\":47,\"LATIN1_GENERAL_CI\":48,\"LATIN1_GENERAL_CS\":49,\"CP1251_BIN\":50,\"CP1251_GENERAL_CI\":51,\"CP1251_GENERAL_CS\":52,\"MACROMAN_BIN\":53,\"UTF16_GENERAL_CI\":54,\"UTF16_BIN\":55,\"UTF16LE_GENERAL_CI\":56,\"CP1256_GENERAL_CI\":57,\"CP1257_BIN\":58,\"CP1257_GENERAL_CI\":59,\"UTF32_GENERAL_CI\":60,\"UTF32_BIN\":61,\"UTF16LE_BIN\":62,\"BINARY\":63,\"ARMSCII8_BIN\":64,\"ASCII_BIN\":65,\"CP1250_BIN\":66,\"CP1256_BIN\":67,\"CP866_BIN\":68,\"DEC8_BIN\":69,\"GREEK_BIN\":70,\"HEBREW_BIN\":71,\"HP8_BIN\":72,\"KEYBCS2_BIN\":73,\"KOI8R_BIN\":74,\"KOI8U_BIN\":75,\"UTF8_TOLOWER_CI\":76,\"LATIN2_BIN\":77,\"LATIN5_BIN\":78,\"LATIN7_BIN\":79,\"CP850_BIN\":80,\"CP852_BIN\":81,\"SWE7_BIN\":82,\"UTF8_BIN\":83,\"BIG5_BIN\":84,\"EUCKR_BIN\":85,\"GB2312_BIN\":86,\"GBK_BIN\":87,\"SJIS_BIN\":88,\"TIS620_BIN\":89,\"UCS2_BIN\":90,\"UJIS_BIN\":91,\"GEOSTD8_GENERAL_CI\":92,\"GEOSTD8_BIN\":93,\"LATIN1_SPANISH_CI\":94,\"CP932_JAPANESE_CI\":95,\"CP932_BIN\":96,\"EUCJPMS_JAPANESE_CI\":97,\"EUCJPMS_BIN\":98,\"CP1250_POLISH_CI\":99,\"UTF16_UNICODE_CI\":101,\"UTF16_ICELANDIC_CI\":102,\"UTF16_LATVIAN_CI\":103,\"UTF16_ROMANIAN_CI\":104,\"UTF16_SLOVENIAN_CI\":105,\"UTF16_POLISH_CI\":106,\"UTF16_ESTONIAN_CI\":107,\"UTF16_SPANISH_CI\":108,\"UTF16_SWEDISH_CI\":109,\"UTF16_TURKISH_CI\":110,\"UTF16_CZECH_CI\":111,\"UTF16_DANISH_CI\":112,\"UTF16_LITHUANIAN_CI\":113,\"UTF16_SLOVAK_CI\":114,\"UTF16_SPANISH2_CI\":115,\"UTF16_ROMAN_CI\":116,\"UTF16_PERSIAN_CI\":117,\"UTF16_ESPERANTO_CI\":118,\"UTF16_HUNGARIAN_CI\":119,\"UTF16_SINHALA_CI\":120,\"UTF16_GERMAN2_CI\":121,\"UTF16_CROATIAN_CI\":122,\"UTF16_UNICODE_520_CI\":123,\"UTF16_VIETNAMESE_CI\":124,\"UCS2_UNICODE_CI\":128,\"UCS2_ICELANDIC_CI\":129,\"UCS2_LATVIAN_CI\":130,\"UCS2_ROMANIAN_CI\":131,\"UCS2_SLOVENIAN_CI\":132,\"UCS2_POLISH_CI\":133,\"UCS2_ESTONIAN_CI\":134,\"UCS2_SPANISH_CI\":135,\"UCS2_SWEDISH_CI\":136,\"UCS2_TURKISH_CI\":137,\"UCS2_CZECH_CI\":138,\"UCS2_DANISH_CI\":139,\"UCS2_LITHUANIAN_CI\":140,\"UCS2_SLOVAK_CI\":141,\"UCS2_SPANISH2_CI\":142,\"UCS2_ROMAN_CI\":143,\"UCS2_PERSIAN_CI\":144,\"UCS2_ESPERANTO_CI\":145,\"UCS2_HUNGARIAN_CI\":146,\"UCS2_SINHALA_CI\":147,\"UCS2_GERMAN2_CI\":148,\"UCS2_CROATIAN_CI\":149,\"UCS2_UNICODE_520_CI\":150,\"UCS2_VIETNAMESE_CI\":151,\"UCS2_GENERAL_MYSQL500_CI\":159,\"UTF32_UNICODE_CI\":160,\"UTF32_ICELANDIC_CI\":161,\"UTF32_LATVIAN_CI\":162,\"UTF32_ROMANIAN_CI\":163,\"UTF32_SLOVENIAN_CI\":164,\"UTF32_POLISH_CI\":165,\"UTF32_ESTONIAN_CI\":166,\"UTF32_SPANISH_CI\":167,\"UTF32_SWEDISH_CI\":168,\"UTF32_TURKISH_CI\":169,\"UTF32_CZECH_CI\":170,\"UTF32_DANISH_CI\":171,\"UTF32_LITHUANIAN_CI\":172,\"UTF32_SLOVAK_CI\":173,\"UTF32_SPANISH2_CI\":174,\"UTF32_ROMAN_CI\":175,\"UTF32_PERSIAN_CI\":176,\"UTF32_ESPERANTO_CI\":177,\"UTF32_HUNGARIAN_CI\":178,\"UTF32_SINHALA_CI\":179,\"UTF32_GERMAN2_CI\":180,\"UTF32_CROATIAN_CI\":181,\"UTF32_UNICODE_520_CI\":182,\"UTF32_VIETNAMESE_CI\":183,\"UTF8_UNICODE_CI\":192,\"UTF8_ICELANDIC_CI\":193,\"UTF8_LATVIAN_CI\":194,\"UTF8_ROMANIAN_CI\":195,\"UTF8_SLOVENIAN_CI\":196,\"UTF8_POLISH_CI\":197,\"UTF8_ESTONIAN_CI\":198,\"UTF8_SPANISH_CI\":199,\"UTF8_SWEDISH_CI\":200,\"UTF8_TURKISH_CI\":201,\"UTF8_CZECH_CI\":202,\"UTF8_DANISH_CI\":203,\"UTF8_LITHUANIAN_CI\":204,\"UTF8_SLOVAK_CI\":205,\"UTF8_SPANISH2_CI\":206,\"UTF8_ROMAN_CI\":207,\"UTF8_PERSIAN_CI\":208,\"UTF8_ESPERANTO_CI\":209,\"UTF8_HUNGARIAN_CI\":210,\"UTF8_SINHALA_CI\":211,\"UTF8_GERMAN2_CI\":212,\"UTF8_CROATIAN_CI\":213,\"UTF8_UNICODE_520_CI\":214,\"UTF8_VIETNAMESE_CI\":215,\"UTF8_GENERAL_MYSQL500_CI\":223,\"UTF8MB4_UNICODE_CI\":224,\"UTF8MB4_ICELANDIC_CI\":225,\"UTF8MB4_LATVIAN_CI\":226,\"UTF8MB4_ROMANIAN_CI\":227,\"UTF8MB4_SLOVENIAN_CI\":228,\"UTF8MB4_POLISH_CI\":229,\"UTF8MB4_ESTONIAN_CI\":230,\"UTF8MB4_SPANISH_CI\":231,\"UTF8MB4_SWEDISH_CI\":232,\"UTF8MB4_TURKISH_CI\":233,\"UTF8MB4_CZECH_CI\":234,\"UTF8MB4_DANISH_CI\":235,\"UTF8MB4_LITHUANIAN_CI\":236,\"UTF8MB4_SLOVAK_CI\":237,\"UTF8MB4_SPANISH2_CI\":238,\"UTF8MB4_ROMAN_CI\":239,\"UTF8MB4_PERSIAN_CI\":240,\"UTF8MB4_ESPERANTO_CI\":241,\"UTF8MB4_HUNGARIAN_CI\":242,\"UTF8MB4_SINHALA_CI\":243,\"UTF8MB4_GERMAN2_CI\":244,\"UTF8MB4_CROATIAN_CI\":245,\"UTF8MB4_UNICODE_520_CI\":246,\"UTF8MB4_VIETNAMESE_CI\":247,\"GB18030_CHINESE_CI\":248,\"GB18030_BIN\":249,\"GB18030_UNICODE_520_CI\":250,\"UTF8_GENERAL50_CI\":253,\"UTF8MB4_0900_AI_CI\":255,\"UTF8MB4_CS_0900_AI_CI\":266,\"UTF8MB4_DA_0900_AI_CI\":267,\"UTF8MB4_DE_PB_0900_AI_CI\":256,\"UTF8MB4_EO_0900_AI_CI\":273,\"UTF8MB4_ES_0900_AI_CI\":263,\"UTF8MB4_ES_TRAD_0900_AI_CI\":270,\"UTF8MB4_ET_0900_AI_CI\":262,\"UTF8MB4_HR_0900_AI_CI\":275,\"UTF8MB4_HU_0900_AI_CI\":274,\"UTF8MB4_IS_0900_AI_CI\":257,\"UTF8MB4_LA_0900_AI_CI\":271,\"UTF8MB4_LT_0900_AI_CI\":268,\"UTF8MB4_LV_0900_AI_CI\":258,\"UTF8MB4_PL_0900_AI_CI\":261,\"UTF8MB4_RO_0900_AI_CI\":259,\"UTF8MB4_SK_0900_AI_CI\":269,\"UTF8MB4_SL_0900_AI_CI\":260,\"UTF8MB4_SV_0900_AI_CI\":264,\"UTF8MB4_TR_0900_AI_CI\":265,\"UTF8MB4_VI_0900_AI_CI\":277,\"BIG5\":1,\"DEC8\":3,\"CP850\":4,\"HP8\":6,\"KOI8R\":7,\"LATIN1\":8,\"LATIN2\":9,\"SWE7\":10,\"ASCII\":11,\"UJIS\":12,\"SJIS\":13,\"HEBREW\":16,\"TIS620\":18,\"EUCKR\":19,\"KOI8U\":22,\"GB2312\":24,\"GREEK\":25,\"CP1250\":26,\"GBK\":28,\"LATIN5\":30,\"ARMSCII8\":32,\"UTF8\":33,\"UCS2\":35,\"CP866\":36,\"KEYBCS2\":37,\"MACCE\":38,\"MACROMAN\":39,\"CP852\":40,\"LATIN7\":41,\"UTF8MB4\":45,\"CP1251\":51,\"UTF16\":54,\"UTF16LE\":56,\"CP1256\":57,\"CP1257\":59,\"UTF32\":60,\"CP932\":95,\"EUCJPMS\":97,\"GB18030\":248,\"GEOSTD8\":92},\"CharsetToEncoding\":[\"utf8\",\"big5\",\"latin2\",\"dec8\",\"cp850\",\"latin1\",\"hp8\",\"koi8r\",\"latin1\",\"latin2\",\"swe7\",\"ascii\",\"eucjp\",\"sjis\",\"cp1251\",\"latin1\",\"hebrew\",\"utf8\",\"tis620\",\"euckr\",\"latin7\",\"latin2\",\"koi8u\",\"cp1251\",\"gb2312\",\"greek\",\"cp1250\",\"latin2\",\"gbk\",\"cp1257\",\"latin5\",\"latin1\",\"armscii8\",\"cesu8\",\"cp1250\",\"ucs2\",\"cp866\",\"keybcs2\",\"macintosh\",\"macroman\",\"cp852\",\"latin7\",\"latin7\",\"macintosh\",\"cp1250\",\"utf8\",\"utf8\",\"latin1\",\"latin1\",\"latin1\",\"cp1251\",\"cp1251\",\"cp1251\",\"macroman\",\"utf16\",\"utf16\",\"utf16-le\",\"cp1256\",\"cp1257\",\"cp1257\",\"utf32\",\"utf32\",\"utf16-le\",\"binary\",\"armscii8\",\"ascii\",\"cp1250\",\"cp1256\",\"cp866\",\"dec8\",\"greek\",\"hebrew\",\"hp8\",\"keybcs2\",\"koi8r\",\"koi8u\",\"cesu8\",\"latin2\",\"latin5\",\"latin7\",\"cp850\",\"cp852\",\"swe7\",\"cesu8\",\"big5\",\"euckr\",\"gb2312\",\"gbk\",\"sjis\",\"tis620\",\"ucs2\",\"eucjp\",\"geostd8\",\"geostd8\",\"latin1\",\"cp932\",\"cp932\",\"eucjpms\",\"eucjpms\",\"cp1250\",\"utf8\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf16\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"ucs2\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"ucs2\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf32\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"cesu8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"gb18030\",\"gb18030\",\"gb18030\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\",\"utf8\"]}},\"QueryGenerator\":{\"dialect\":\"mysql\",\"OperatorMap\":{},\"_templateSettings\":{\"escape\":{},\"evaluate\":{},\"interpolate\":{},\"variable\":\"\",\"imports\":{}},\"options\":\"~transaction~sequelize~options\",\"OperatorsAliasMap\":false,\"_dialect\":\"~transaction~sequelize~dialect\",\"sequelize\":\"~transaction~sequelize\"}},\"queryInterface\":{\"sequelize\":\"~transaction~sequelize\",\"QueryGenerator\":\"~transaction~sequelize~dialect~QueryGenerator\"},\"models\":{},\"modelManager\":{\"models\":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],\"sequelize\":\"~transaction~sequelize\"},\"connectionManager\":\"~transaction~sequelize~dialect~connectionManager\",\"importCache\":{},\"test\":{\"_trackRunningQueries\":false,\"_runningQueries\":0}},\"savepoints\":[],\"_afterCommitHooks\":[],\"options\":{\"autocommit\":null,\"type\":\"DEFERRED\",\"isolationLevel\":null,\"readOnly\":false},\"id\":\"fa12666f-d83d-4a7a-b82e-86655069fe72\",\"connection\":{\"_events\":{},\"_eventsCount\":1,\"config\":{\"host\":\"127.0.0.1\",\"port\":3306,\"user\":\"root\",\"password\":\"1234\",\"database\":\"ib_new\",\"connectTimeout\":10000,\"insecureAuth\":false,\"supportBigNumbers\":true,\"bigNumberStrings\":false,\"decimalNumbers\":false,\"dateStrings\":false,\"trace\":true,\"stringifyObjects\":false,\"timezone\":\"+00:00\",\"ssl\":false,\"multipleStatements\":false,\"rowsAsArray\":false,\"namedPlaceholders\":false,\"maxPacketSize\":0,\"charsetNumber\":224,\"compress\":false,\"clientFlags\":8582093,\"maxPreparedStatements\":16000},\"stream\":{\"connecting\":false,\"_hadError\":false,\"_handle\":{\"reading\":true,\"onconnection\":null},\"_parent\":null,\"_host\":null,\"_readableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"buffer\":{\"head\":null,\"tail\":null,\"length\":0},\"length\":0,\"pipes\":null,\"pipesCount\":0,\"flowing\":true,\"ended\":false,\"endEmitted\":false,\"reading\":true,\"sync\":false,\"needReadable\":true,\"emittedReadable\":false,\"readableListening\":false,\"resumeScheduled\":false,\"paused\":false,\"emitClose\":false,\"autoDestroy\":false,\"destroyed\":false,\"defaultEncoding\":\"utf8\",\"awaitDrain\":0,\"readingMore\":false,\"decoder\":null,\"encoding\":null},\"readable\":true,\"_events\":{},\"_eventsCount\":4,\"_writableState\":{\"objectMode\":false,\"highWaterMark\":16384,\"finalCalled\":false,\"needDrain\":false,\"ending\":false,\"ended\":false,\"finished\":false,\"destroyed\":false,\"decodeStrings\":false,\"defaultEncoding\":\"utf8\",\"length\":0,\"writing\":false,\"corked\":0,\"sync\":false,\"bufferProcessing\":false,\"writecb\":null,\"writelen\":0,\"bufferedRequest\":null,\"lastBufferedRequest\":null,\"pendingcb\":0,\"prefinished\":false,\"errorEmitted\":false,\"emitClose\":false,\"autoDestroy\":false,\"bufferedRequestCount\":0,\"corkedRequestsFree\":{\"next\":null,\"entry\":null}},\"writable\":true,\"allowHalfOpen\":false,\"_sockname\":null,\"_pendingData\":null,\"_pendingEncoding\":\"\",\"server\":null,\"_server\":null},\"_internalId\":54,\"_commands\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_paused\":false,\"_paused_packets\":{\"_head\":0,\"_tail\":0,\"_capacityMask\":3,\"_list\":[null,null,null,null]},\"_statements\":{},\"serverCapabilityFlags\":2688546815,\"authorized\":true,\"sequenceId\":2,\"compressedSequenceId\":0,\"threadId\":502,\"_handshakePacket\":{\"protocolVersion\":10,\"serverVersion\":\"5.5.5-10.1.37-MariaDB\",\"capabilityFlags\":2688546815,\"connectionId\":502,\"authPluginData1\":{\"type\":\"Buffer\",\"data\":[86,89,60,93,67,115,59,107]},\"authPluginData2\":{\"type\":\"Buffer\",\"data\":[42,43,60,42,91,110,57,112,72,88,94,82]},\"characterSet\":8,\"statusFlags\":2},\"_fatalError\":null,\"_protocolError\":null,\"_outOfOrderPackets\":[],\"clientEncoding\":\"utf8\",\"packetParser\":{\"buffer\":[],\"bufferLength\":0,\"packetHeaderLength\":4,\"headerLen\":0,\"length\":7,\"largePacketParts\":[],\"firstPacketSequenceId\":0},\"serverEncoding\":\"latin1\",\"connectTimeout\":null,\"connectionId\":502,\"uuid\":\"fa12666f-d83d-4a7a-b82e-86655069fe72\"}},\"fields\":[\"id\",\"interviewId\",\"email\",\"status\",\"link\",\"pin\",\"paymentstatus\",\"interviewTypeMapChildId\",\"createdAt\",\"updatedAt\"],\"auth\":3}', '[1]', 3, '2019-03-15 12:30:02', '2019-03-15 12:30:02'),
(20, 'interview_user_questions', 'update', '{\"where\":{\"id\":1},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"uid\",\"answerText\",\"answerLink\",\"status\",\"timeTaken\",\"updatedAt\"],\"attributes\":{\"uid\":\"v-43523f0a-3d6b-4de9-96b5-13a340e4055a\",\"answerText\":\"\",\"answerLink\":\"//www.cameratag.com/assets/v-43523f0a-3d6b-4de9-96b5-13a340e4055a/mp4.mp4\",\"status\":1,\"timeTaken\":\" 7\",\"updatedAt\":\"2019-03-15T12:32:23.176Z\"},\"auth\":4}', '{\"id\":1}', 4, '2019-03-15 12:32:23', '2019-03-15 12:32:23'),
(21, 'interview_user_questions', 'update', '{\"where\":{\"id\":2},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"uid\",\"answerText\",\"answerLink\",\"status\",\"timeTaken\",\"updatedAt\"],\"attributes\":{\"uid\":\"v-7ac8a7a9-747d-4aab-87a7-ac9d44e693a4\",\"answerText\":\"\",\"answerLink\":\"//www.cameratag.com/assets/v-7ac8a7a9-747d-4aab-87a7-ac9d44e693a4/mp4.mp4\",\"status\":1,\"timeTaken\":\" 6\",\"updatedAt\":\"2019-03-15T12:32:46.759Z\"},\"auth\":4}', '{\"id\":2}', 4, '2019-03-15 12:32:46', '2019-03-15 12:32:46'),
(22, 'interview_user_questions', 'update', '{\"where\":{\"id\":3},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"uid\",\"answerText\",\"answerLink\",\"status\",\"timeTaken\",\"updatedAt\"],\"attributes\":{\"uid\":\"v-d7d446e9-84b8-4dd3-bdf4-0fa86b75c50d\",\"answerText\":\"\",\"answerLink\":\"//www.cameratag.com/assets/v-d7d446e9-84b8-4dd3-bdf4-0fa86b75c50d/mp4.mp4\",\"status\":1,\"timeTaken\":\" 9\",\"updatedAt\":\"2019-03-15T12:33:06.875Z\"},\"auth\":4}', '{\"id\":3}', 4, '2019-03-15 12:33:06', '2019-03-15 12:33:06'),
(23, 'interview_user_questions', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"uid\",\"answerText\",\"answerLink\",\"status\",\"timeTaken\",\"updatedAt\"],\"attributes\":{\"uid\":\"v-cd7838a3-43c8-48e8-b2fc-4b61dd953157\",\"answerText\":\"\",\"answerLink\":\"//www.cameratag.com/assets/v-cd7838a3-43c8-48e8-b2fc-4b61dd953157/mp4.mp4\",\"status\":1,\"timeTaken\":\" 4\",\"updatedAt\":\"2019-03-15T12:33:34.429Z\"},\"auth\":4}', '{\"id\":4}', 4, '2019-03-15 12:33:34', '2019-03-15 12:33:34'),
(24, 'interview_user_questions', 'update', '{\"where\":{\"id\":5},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"uid\",\"answerText\",\"answerLink\",\"status\",\"timeTaken\",\"updatedAt\"],\"attributes\":{\"uid\":\"v-412e1fb0-bd9a-417f-b9c2-795331e226a2\",\"answerText\":\"\",\"answerLink\":\"//www.cameratag.com/assets/v-412e1fb0-bd9a-417f-b9c2-795331e226a2/mp4.mp4\",\"status\":1,\"timeTaken\":\" 0\",\"updatedAt\":\"2019-03-15T12:34:09.659Z\"},\"auth\":4}', '{\"id\":5}', 4, '2019-03-15 12:34:09', '2019-03-15 12:34:09'),
(25, 'interview_users', 'update', '{\"where\":{\"pin\":83679,\"email\":\"demobuddygap@gmail.com\"},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"interviewTypeMapChildId\",\"updatedAt\"],\"attributes\":{\"status\":\"Completed\",\"interviewTypeMapChildId\":1,\"updatedAt\":\"2019-03-15T12:34:09.696Z\"},\"auth\":4}', '{\"pin\":83679,\"email\":\"demobuddygap@gmail.com\"}', 4, '2019-03-15 12:34:09', '2019-03-15 12:34:09'),
(26, 'users', 'insert', '{\"id\":5,\"fname\":\"Expert\",\"mname\":\"E\",\"lname\":\"E\",\"email\":\"expert@test.com\",\"password\":\"de9181523be44aef266504ec8d2afba1\",\"phone\":\"9879887987\",\"gender\":\"male\",\"status\":\"active\",\"roleId\":3,\"updatedAt\":\"2019-03-15T12:37:50.894Z\",\"createdAt\":\"2019-03-15T12:37:50.894Z\"}', '5', 2, '2019-03-15 12:37:50', '2019-03-15 12:37:50'),
(27, 'organization', 'insert', '{\"id\":2,\"name\":\"\",\"type\":\"\",\"url\":\"\",\"email\":\"\",\"updatedAt\":\"2019-03-15T12:40:57.467Z\",\"createdAt\":\"2019-03-15T12:40:57.467Z\"}', '2', 2, '2019-03-15 12:40:57', '2019-03-15 12:40:57'),
(28, 'organization_campus', 'insert', '{\"id\":2,\"branchName\":\"fgfhg\",\"organizationId\":2,\"address\":\"tyutuu\",\"city\":\"yuu\",\"pincode\":\"567676\",\"url\":\"hgf.http\",\"contactPerson\":\"yuythjfyh\",\"contactPersonEmail\":\"surya@g.com\",\"contactPersonPhone\":\"8786565435\",\"contactPersonDesgination\":\"kjhgfd\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:40:57.472Z\",\"createdAt\":\"2019-03-15T12:40:57.472Z\"}', '2', 2, '2019-03-15 12:40:57', '2019-03-15 12:40:57'),
(29, 'organization', 'insert', '{\"id\":3,\"name\":\"Surya P\",\"type\":\"corporate\",\"url\":\"\",\"email\":\"thisissurya555@gmail.com\",\"updatedAt\":\"2019-03-15T12:45:52.207Z\",\"createdAt\":\"2019-03-15T12:45:52.207Z\"}', '3', 2, '2019-03-15 12:45:52', '2019-03-15 12:45:52'),
(30, 'organization_campus', 'insert', '{\"id\":3,\"branchName\":\"jkljkdjj\",\"organizationId\":3,\"address\":\"djskytrer\",\"city\":\"htghgkjg\",\"pincode\":\"566756\",\"url\":\"ghg.com\",\"contactPerson\":\"gytyy\",\"contactPersonEmail\":\"suryaa@g.com\",\"contactPersonPhone\":\"8978654567\",\"contactPersonDesgination\":\"jhgfd\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T12:45:52.210Z\",\"createdAt\":\"2019-03-15T12:45:52.210Z\"}', '3', 2, '2019-03-15 12:45:52', '2019-03-15 12:45:52'),
(31, 'organization', 'insert', '{\"id\":4,\"name\":\"Surya P\",\"type\":\"university\",\"url\":\"kfld.org\",\"email\":\"thisissurya555@gmail.com\",\"updatedAt\":\"2019-03-15T13:13:53.959Z\",\"createdAt\":\"2019-03-15T13:13:53.959Z\"}', '4', 2, '2019-03-15 13:13:53', '2019-03-15 13:13:53'),
(32, 'organization_campus', 'insert', '{\"id\":4,\"branchName\":\"surya\",\"organizationId\":4,\"address\":\"egfrht\",\"city\":\"regtr\",\"pincode\":\"546757\",\"url\":\"lkj.org\",\"contactPerson\":\"kumari\",\"contactPersonEmail\":\"kum@g.com\",\"contactPersonPhone\":\"9876546789\",\"contactPersonDesgination\":\"hod\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T13:13:53.965Z\",\"createdAt\":\"2019-03-15T13:13:53.965Z\"}', '4', 2, '2019-03-15 13:13:53', '2019-03-15 13:13:53'),
(33, 'organization', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"name\",\"type\",\"url\",\"email\",\"updatedAt\"],\"attributes\":{\"name\":\"\",\"type\":\"university\",\"url\":\"kfld.org\",\"email\":\"thisissurya555@gmail.com\",\"updatedAt\":\"2019-03-15T13:34:23.202Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:34:23', '2019-03-15 13:34:23'),
(34, 'organization_campus', 'update', '{\"where\":{\"organizationId\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"updatedAt\"],\"attributes\":{\"status\":\"inactive\",\"updatedAt\":\"2019-03-15T13:34:23.214Z\"},\"auth\":2}', '{\"organizationId\":4}', 2, '2019-03-15 13:34:23', '2019-03-15 13:34:23'),
(35, 'organization_campus', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"branchName\",\"address\",\"city\",\"pincode\",\"url\",\"contactPerson\",\"contactPersonEmail\",\"contactPersonPhone\",\"contactPersonDesgination\",\"status\",\"updatedAt\"],\"attributes\":{\"branchName\":\"surya\",\"address\":\"egfrht\",\"city\":\"regtr\",\"pincode\":\"546757\",\"url\":\"lkj.org\",\"contactPerson\":\"kumari\",\"contactPersonEmail\":\"kum@g.com\",\"contactPersonPhone\":\"9876546789\",\"contactPersonDesgination\":\"hod\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T13:34:23.220Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:34:23', '2019-03-15 13:34:23'),
(36, 'organization', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"name\",\"type\",\"url\",\"email\",\"updatedAt\"],\"attributes\":{\"name\":\"\",\"type\":\"university\",\"url\":\"\",\"email\":\"\",\"updatedAt\":\"2019-03-15T13:34:57.172Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:34:57', '2019-03-15 13:34:57'),
(37, 'organization_campus', 'update', '{\"where\":{\"organizationId\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"updatedAt\"],\"attributes\":{\"status\":\"inactive\",\"updatedAt\":\"2019-03-15T13:34:57.180Z\"},\"auth\":2}', '{\"organizationId\":4}', 2, '2019-03-15 13:34:57', '2019-03-15 13:34:57'),
(38, 'organization_campus', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"branchName\",\"address\",\"city\",\"pincode\",\"url\",\"contactPerson\",\"contactPersonEmail\",\"contactPersonPhone\",\"contactPersonDesgination\",\"status\",\"updatedAt\"],\"attributes\":{\"branchName\":\"surya\",\"address\":\"egfrht\",\"city\":\"regtr\",\"pincode\":\"546757\",\"url\":\"lkj.org\",\"contactPerson\":\"kumari\",\"contactPersonEmail\":\"kum@g.com\",\"contactPersonPhone\":\"9876546789\",\"contactPersonDesgination\":\"hod\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T13:34:57.186Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:34:57', '2019-03-15 13:34:57'),
(39, 'organization', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"name\",\"type\",\"url\",\"email\",\"updatedAt\"],\"attributes\":{\"name\":\"Surya P\",\"type\":\"university\",\"url\":\"gtrfd.organization\",\"email\":\"thisissurya555@gmail.com\",\"updatedAt\":\"2019-03-15T13:35:24.659Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:35:24', '2019-03-15 13:35:24'),
(40, 'organization_campus', 'update', '{\"where\":{\"organizationId\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"updatedAt\"],\"attributes\":{\"status\":\"inactive\",\"updatedAt\":\"2019-03-15T13:35:24.666Z\"},\"auth\":2}', '{\"organizationId\":4}', 2, '2019-03-15 13:35:24', '2019-03-15 13:35:24'),
(41, 'organization_campus', 'update', '{\"where\":{\"id\":4},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"branchName\",\"address\",\"city\",\"pincode\",\"url\",\"contactPerson\",\"contactPersonEmail\",\"contactPersonPhone\",\"contactPersonDesgination\",\"status\",\"updatedAt\"],\"attributes\":{\"branchName\":\"surya\",\"address\":\"egfrht\",\"city\":\"regtr\",\"pincode\":\"546757\",\"url\":\"lkj.org\",\"contactPerson\":\"kumari\",\"contactPersonEmail\":\"kum@g.com\",\"contactPersonPhone\":\"9876546789\",\"contactPersonDesgination\":\"hod\",\"status\":\"active\",\"updatedAt\":\"2019-03-15T13:35:24.672Z\"},\"auth\":2}', '{\"id\":4}', 2, '2019-03-15 13:35:24', '2019-03-15 13:35:24'),
(42, 'interview_experts', 'insert', '{\"id\":1,\"interviewUserId\":1,\"expertId\":5,\"status\":\"open\",\"interviewTypeMapChildId\":2,\"updatedAt\":\"2019-03-15T13:37:54.015Z\",\"createdAt\":\"2019-03-15T13:37:54.015Z\"}', '1', 2, '2019-03-15 13:37:54', '2019-03-15 13:37:54'),
(43, 'interview_users', 'update', '{\"where\":{\"id\":1},\"validate\":true,\"hooks\":true,\"individualHooks\":false,\"returning\":false,\"force\":false,\"sideEffects\":true,\"type\":\"BULKUPDATE\",\"fields\":[\"status\",\"updatedAt\"],\"attributes\":{\"status\":\"expertreview\",\"updatedAt\":\"2019-03-15T13:37:54.027Z\"},\"auth\":2}', '{\"id\":1}', 2, '2019-03-15 13:37:54', '2019-03-15 13:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `menu_access_map`
--

CREATE TABLE `menu_access_map` (
  `id` int(11) NOT NULL,
  `menuId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  `addAccess` enum('1','0') NOT NULL,
  `editAccess` enum('1','0') NOT NULL COMMENT '1.Active 0.In-active',
  `gridAccess` enum('1','0') NOT NULL COMMENT '1.Active 0.In-active',
  `viewAccess` enum('1','0') NOT NULL COMMENT '1.Active 0.In-active',
  `deleteAccess` enum('1','0') NOT NULL COMMENT '1.Active 0.In-active',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_access_map`
--

INSERT INTO `menu_access_map` (`id`, `menuId`, `roleId`, `addAccess`, `editAccess`, `gridAccess`, `viewAccess`, `deleteAccess`, `createdAt`, `updatedAt`) VALUES
(2, 3, 1, '1', '1', '1', '0', '1', NULL, '0000-00-00 00:00:00'),
(3, 2, 4, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(4, 4, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(5, 5, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(6, 7, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(7, 6, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(8, 8, 4, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(10, 10, 1, '1', '0', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(11, 10, 4, '1', '0', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(12, 10, 4, '1', '0', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(13, 11, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(14, 12, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(15, 2, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(16, 9, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(17, 13, 3, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(18, 14, 3, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(22, 16, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(23, 17, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(24, 18, 2, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(25, 19, 4, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(26, 12, 4, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(27, 12, 4, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(29, 12, 3, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(30, 17, 4, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(31, 20, 1, '1', '1', '1', '1', '1', NULL, '0000-00-00 00:00:00'),
(33, 3, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(34, 4, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(35, 5, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(36, 7, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(37, 6, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(38, 10, 2, '1', '0', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(39, 11, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(40, 12, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(44, 16, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(45, 17, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(46, 20, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(47, 21, 4, '1', '0', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(48, 11, 4, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(49, 22, 6, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(50, 23, 6, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(51, 24, 2, '1', '1', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(52, 25, 5, '1', '0', '1', '1', '0', NULL, '0000-00-00 00:00:00'),
(53, 26, 6, '1', '0', '1', '1', '0', NULL, '2018-02-28 00:00:00'),
(54, 5, 2, '1', '1', '1', '1', '0', NULL, '2019-03-01 00:00:00'),
(55, 5, 4, '1', '1', '1', '1', '0', NULL, '2019-03-01 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `menu_master`
--

CREATE TABLE `menu_master` (
  `id` int(11) NOT NULL,
  `moduleId` int(11) NOT NULL,
  `menuLevel` int(11) NOT NULL,
  `menuPriority` int(11) NOT NULL,
  `menuTitle` varchar(100) NOT NULL,
  `menuLink` varchar(100) NOT NULL,
  `menuStatus` enum('1','0') NOT NULL DEFAULT '1' COMMENT '1.Active 2.In-Active',
  `menuIcon` varchar(20) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_master`
--

INSERT INTO `menu_master` (`id`, `moduleId`, `menuLevel`, `menuPriority`, `menuTitle`, `menuLink`, `menuStatus`, `menuIcon`, `createdAt`, `updatedAt`) VALUES
(2, 2, 1, 1, 'Review Skills', '/main/reviewskills', '1', '', NULL, '2019-01-25 00:00:00'),
(3, 2, 1, 2, 'Organization', '/main/organization', '1', '', NULL, '2019-01-25 00:00:00'),
(4, 2, 2, 1, 'Upload Questions', '/main/bulkquestions', '1', '', NULL, '0000-00-00 00:00:00'),
(5, 6, 3, 1, 'Upload Users', '/main/bulkuser', '1', '', NULL, '0000-00-00 00:00:00'),
(6, 2, 1, 1, 'Expert Level', '/main/expertlevel', '1', '', NULL, '0000-00-00 00:00:00'),
(7, 2, 1, 1, 'Domain', '/main/domain', '1', '', NULL, '0000-00-00 00:00:00'),
(8, 2, 1, 1, 'User Group', '/main/usergroup', '1', '', NULL, '0000-00-00 00:00:00'),
(9, 2, 1, 1, 'Interview Type', '/main/interviewtype', '1', '', NULL, '0000-00-00 00:00:00'),
(10, 6, 1, 1, 'User Creation', '/main/userdomainmap', '1', '', NULL, '0000-00-00 00:00:00'),
(11, 2, 1, 1, 'Questions', '/main/questions', '1', '', NULL, '0000-00-00 00:00:00'),
(12, 1, 1, 1, 'Main Dashboard', '/main/dashboard', '1', '', NULL, '0000-00-00 00:00:00'),
(13, 3, 1, 1, 'Interviews To Review', '/main/expertview', '1', '', NULL, '0000-00-00 00:00:00'),
(14, 3, 1, 1, 'Expert Review', '/main/expertreview', '0', '', NULL, '0000-00-00 00:00:00'),
(16, 4, 1, 1, 'Coupon Generation', '/main/generate-coupon', '1', '', NULL, '0000-00-00 00:00:00'),
(17, 4, 1, 1, 'Subscription', '/main/paymentmgmt', '1', '', NULL, '0000-00-00 00:00:00'),
(18, 3, 1, 1, 'Assign to Expert', '/main/assign-interview', '1', '', NULL, '0000-00-00 00:00:00'),
(19, 3, 1, 1, 'Process Interview', '/main/process-interview', '1', '', NULL, '0000-00-00 00:00:00'),
(20, 4, 1, 1, 'Cheque Management', '/main/chequemgmt', '1', '', NULL, '0000-00-00 00:00:00'),
(21, 3, 1, 1, 'Create Interview', '/main/create-interview', '1', '', NULL, '0000-00-00 00:00:00'),
(22, 2, 1, 1, 'Questions', '/main/crowdquestions', '1', '', NULL, '0000-00-00 00:00:00'),
(23, 2, 1, 1, 'Qusetions Upload', '/main/crowdbulkquestions', '1', '', NULL, '0000-00-00 00:00:00'),
(24, 2, 1, 1, 'Quality Check', '/main/qualitycheck', '1', '', NULL, '0000-00-00 00:00:00'),
(25, 4, 1, 1, 'Payments', '/examboard/paymentmgmt', '1', '', NULL, '0000-00-00 00:00:00'),
(26, 2, 4, 2, 'Review', '/main/questionsreview', '1', ' ', NULL, '2019-02-28 00:00:00'),
(27, 4, 1, 1, 'Print', '/main/print', '1', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `menu_modules_master`
--

CREATE TABLE `menu_modules_master` (
  `id` int(11) NOT NULL,
  `menuTitle` varchar(100) NOT NULL,
  `menuLink` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL,
  `status` enum('1','0') NOT NULL DEFAULT '1' COMMENT '1. Active 2.In-active',
  `icon` varchar(30) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu_modules_master`
--

INSERT INTO `menu_modules_master` (`id`, `menuTitle`, `menuLink`, `priority`, `status`, `icon`, `createdAt`, `updatedAt`) VALUES
(1, 'Dashboards', '#', 1, '1', '', '2019-01-25 04:13:16', NULL),
(2, 'Masters', '#', 2, '1', '', NULL, NULL),
(3, 'Interview', '#', 4, '1', '', NULL, NULL),
(4, 'Accounts', '#', 5, '1', '', NULL, NULL),
(5, 'Reports', '#', 6, '1', '', NULL, NULL),
(6, 'User Management', '#', 3, '1', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('university','corporate') NOT NULL,
  `url` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`id`, `name`, `type`, `url`, `email`, `createdAt`, `updatedAt`) VALUES
(1, 'Gayathri', 'university', 'www.gayathri.org', 'gayathri123456@gmail.com', '2019-03-15 12:17:50', '2019-03-15 12:17:50'),
(4, 'Surya P', 'university', 'gtrfd.organization', 'thisissurya555@gmail.com', '2019-03-15 13:13:53', '2019-03-15 13:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `organization_campus`
--

CREATE TABLE `organization_campus` (
  `id` int(11) NOT NULL,
  `branchName` varchar(50) NOT NULL,
  `organizationId` int(11) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(255) NOT NULL,
  `pincode` varchar(15) NOT NULL,
  `url` varchar(255) NOT NULL,
  `contactPerson` varchar(45) NOT NULL,
  `contactPersonEmail` varchar(45) NOT NULL,
  `contactPersonPhone` varchar(14) NOT NULL,
  `contactPersonDesgination` varchar(45) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organization_campus`
--

INSERT INTO `organization_campus` (`id`, `branchName`, `organizationId`, `address`, `city`, `pincode`, `url`, `contactPerson`, `contactPersonEmail`, `contactPersonPhone`, `contactPersonDesgination`, `createdAt`, `updatedAt`, `status`) VALUES
(1, 'Gayathri Womens', 1, 'Vizag', 'Vizag', '530002', 'www.gayathri.org', 'Prasanth', 'gayathri123456@gmail.com', '7878787877', 'Principal', '2019-03-15 12:17:50', '2019-03-15 12:17:50', 'active'),
(2, 'fgfhg', 2, 'tyutuu', 'yuu', '567676', 'hgf.http', 'yuythjfyh', 'surya@g.com', '8786565435', 'kjhgfd', '2019-03-15 12:40:57', '2019-03-15 12:40:57', 'active'),
(3, 'jkljkdjj', 3, 'djskytrer', 'htghgkjg', '566756', 'ghg.com', 'gytyy', 'suryaa@g.com', '8978654567', 'jhgfd', '2019-03-15 12:45:52', '2019-03-15 12:45:52', 'active'),
(4, 'surya', 4, 'egfrht', 'regtr', '546757', 'lkj.org', 'kumari', 'kum@g.com', '9876546789', 'hod', '2019-03-15 13:13:53', '2019-03-15 13:35:24', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `mode` enum('cc','dc','paypal','cheque') NOT NULL,
  `chequeNo` varchar(255) DEFAULT NULL,
  `bankName` varchar(255) DEFAULT NULL,
  `chequeImage` varchar(255) DEFAULT NULL,
  `chequeClearedDate` date DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `pgResponse` text,
  `status` enum('open','inprogress','sucess','failed','cancel') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `mode`, `chequeNo`, `bankName`, `chequeImage`, `chequeClearedDate`, `price`, `pgResponse`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'cheque', '252525', 'SBI', NULL, '2019-03-15', '20.00', NULL, 'sucess', '2019-03-15 12:27:09', '2019-03-15 12:27:32');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text,
  `expLevelId` int(11) NOT NULL,
  `difficulty` enum('low','medium','high') NOT NULL,
  `mandatory` int(11) NOT NULL COMMENT '0-not mandatory,1-mandatory',
  `global` int(11) NOT NULL COMMENT '0-private,1-public',
  `time` int(11) NOT NULL COMMENT 'in seconds',
  `domainId` int(11) NOT NULL,
  `subDomainId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `answer`, `expLevelId`, `difficulty`, `mandatory`, `global`, `time`, `domainId`, `subDomainId`, `keywords`, `status`, `organizationId`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, 'Can you tell me a little about your  yourself?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 10, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(2, 'What was your technical and logical experience?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(3, 'how to make an ajax call using angular js?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(4, 'what is service method?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(5, 'what are angular js expression?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(6, 'Expalian ng-init directive', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(7, 'How to validate data in angular js?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(8, 'what is angular and why angular?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(9, 'name the buildindg blocks of angular', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(10, 'what ois transpling in angular?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(11, 'what is view encapsulation?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(12, 'why java is a plat form independent?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'low', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(13, 'what is jdk?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(14, 'what is constructors?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(15, 'what is polymorphism?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(16, 'expalian about interfaces?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(17, 'what is abstract classes', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(18, 'what is method over loading', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(19, 'what is association?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(20, 'what is servelets?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(21, 'explain threads?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(22, 'What is PEP 8?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(23, 'What is pickling and unpickling?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'medium', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(24, 'How memory is managed in Python?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(25, 'What are Python decorators?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(26, 'How Python is interpreted?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(27, 'What is namespace in Python?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(28, 'What is lambda in Python?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(29, 'In Python what are iterators?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08'),
(30, 'What is unittest in Python?', 'This question seems simple, so many people fail to prepare for it, but it\'s crucial. ', 1, 'high', 0, 0, 8, 1, 1, 'simple,specific accomplishments ,experiences', 'active', NULL, 2, '2019-03-15 12:26:08', '2019-03-15 12:26:08');

-- --------------------------------------------------------

--
-- Table structure for table `questions_temp`
--

CREATE TABLE `questions_temp` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text,
  `expLevelId` int(11) NOT NULL,
  `difficulty` enum('low','medium','high') NOT NULL,
  `mandatory` int(11) NOT NULL COMMENT '0-not mandatory,1-mandatory',
  `global` int(11) NOT NULL COMMENT '0-private,1-public',
  `time` int(11) NOT NULL COMMENT 'in seconds',
  `domainId` int(11) NOT NULL,
  `subDomainId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  `status` enum('open','accept','reject') NOT NULL,
  `userId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `question_temp_remarks`
--

CREATE TABLE `question_temp_remarks` (
  `id` int(11) NOT NULL,
  `questionTempId` int(11) NOT NULL,
  `status` enum('correct','wrong') DEFAULT NULL,
  `remarks` text,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `report_perameters`
--

CREATE TABLE `report_perameters` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `organizationId` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `report_perameters`
--

INSERT INTO `report_perameters` (`id`, `name`, `createdAt`, `updatedAt`, `organizationId`, `status`) VALUES
(1, 'Communication', '2019-03-15 12:28:10', '2019-03-15 12:28:10', 1, 'active'),
(2, 'Attitude', '2019-03-15 12:28:19', '2019-03-15 12:28:19', 1, 'active'),
(3, 'Soft Skills', '2019-03-15 12:28:27', '2019-03-15 12:28:27', 1, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `level` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `level`, `createdAt`, `updatedAt`) VALUES
(1, 'Super User', 1, '2019-01-02 00:00:00', '2019-01-02 00:00:00'),
(2, 'Admin', 2, '2019-01-02 00:00:00', '2019-01-02 00:00:00'),
(3, 'Expert', 6, '2019-01-02 00:00:00', '2019-01-02 00:00:00'),
(4, 'Organization', 6, '2019-01-02 00:00:00', '2019-01-02 00:00:00'),
(5, 'User', 10, '2019-01-02 00:00:00', '2019-01-02 00:00:00'),
(6, 'Crowd Sourcing', 6, '2019-02-18 00:00:00', '2019-02-18 00:00:00'),
(7, 'Sub Admin', 3, '2019-03-02 00:00:00', '2019-03-02 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sub_domains`
--

CREATE TABLE `sub_domains` (
  `id` int(11) NOT NULL,
  `domainId` int(11) NOT NULL,
  `subDomainName` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sub_domains`
--

INSERT INTO `sub_domains` (`id`, `domainId`, `subDomainName`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Angular', 'active', '2019-03-15 12:18:18', '2019-03-15 12:18:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(255) DEFAULT NULL COMMENT 'First Name',
  `mname` varchar(255) DEFAULT NULL COMMENT 'Middle Name',
  `lname` varchar(255) DEFAULT NULL COMMENT 'Last Name',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `gender` enum('male','female','others') NOT NULL,
  `organizationId` int(11) DEFAULT NULL,
  `aggrement` enum('0','1') NOT NULL DEFAULT '0',
  `status` enum('active','inactive','suspend','') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `roleId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `mname`, `lname`, `email`, `password`, `phone`, `gender`, `organizationId`, `aggrement`, `status`, `createdAt`, `updatedAt`, `roleId`) VALUES
(1, 'Super', 'User', 'U', 'sudheerkumar121@gmail.com', 'ceb6c970658f31504a901b89dcd3e461', '9898989898', 'male', NULL, '0', 'active', '2019-03-15 12:14:42', '2019-03-15 12:14:42', 1),
(2, 'admin', 'a', 'a', 'admin@test.com', 'ceb6c970658f31504a901b89dcd3e461', '4545454545', 'male', NULL, '1', 'active', '2019-03-15 12:15:53', '2019-03-15 12:16:24', 2),
(3, 'Organization', 'O', 'O', 'org@test.com', 'ceb6c970658f31504a901b89dcd3e461', '9898989898', 'male', 1, '1', 'active', '2019-03-15 12:19:28', '2019-03-15 12:28:00', 4),
(4, 'demo', 'buddy', 'gap', 'demobuddygap@gmail.com', 'ceb6c970658f31504a901b89dcd3e461', '7093740931', 'male', NULL, '1', 'active', '2019-03-15 12:31:21', '2019-03-18 07:57:00', 5),
(5, 'Expert', 'E', 'E', 'expert@test.com', 'ceb6c970658f31504a901b89dcd3e461', '9879887987', 'male', NULL, '1', 'active', '2019-03-15 12:37:50', '2019-03-15 13:40:50', 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL,
  `groupName` varchar(60) NOT NULL,
  `organizationId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_groups_map`
--

CREATE TABLE `user_groups_map` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_login_logs`
--

CREATE TABLE `user_login_logs` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `token` text NOT NULL,
  `agent` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_login_logs`
--

INSERT INTO `user_login_logs` (`id`, `userId`, `token`, `agent`, `createdAt`, `updatedAt`) VALUES
(1, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Miwicm9sZUxldmVsIjoyLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwiaWF0IjoxNTUyNjUyMTgxLCJleHAiOjE1NTI3Mzg1ODF9.i4Z_vq22pToh5nUMc18RA69whM_vuLTpXqIGAH-s92A', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"48\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 12:16:21', '2019-03-15 12:16:21'),
(2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Miwicm9sZUxldmVsIjoyLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwiaWF0IjoxNTUyNjUyMzQ2LCJleHAiOjE1NTI3Mzg3NDZ9.WckcHfupEiy1dRSCYPRkYyLoyg9YRMSDWDdqxgpJV-c', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"48\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-IN,en-GB;q=0.9,en-US;q=0.8,en;q=0.7\"}', '2019-03-15 12:19:06', '2019-03-15 12:19:06'),
(3, 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsIm9yZ2FuaXphdGlvbiI6MSwicm9sZSI6NCwicm9sZUxldmVsIjo2LCJlbWFpbCI6Im9yZ0B0ZXN0LmNvbSIsImlhdCI6MTU1MjY1Mjg3OCwiZXhwIjoxNTUyNzM5Mjc4fQ.z2L0r8EjIsrjvz9zJqkz4Lun9LMYRlux-VXQvo7n584', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"46\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 12:27:58', '2019-03-15 12:27:58'),
(4, 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6NSwicm9sZUxldmVsIjoxMCwiZW1haWwiOiJkZW1vYnVkZHlnYXBAZ21haWwuY29tIiwiaWF0IjoxNTUyNjUzMDk0LCJleHAiOjE1NTI3Mzk0OTR9.iz4zTom2Z-KPapDqyeDtiC9kQi4XrZsM9ai62YQrsB8', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"60\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-US,en;q=0.9\"}', '2019-03-15 12:31:34', '2019-03-15 12:31:34'),
(5, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Miwicm9sZUxldmVsIjoyLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwiaWF0IjoxNTUyNjUzNDIxLCJleHAiOjE1NTI3Mzk4MjF9.-GJpgxuSvLp-kNyuZxgJS3HpGYlr7Gnd7leat5cSVss', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"48\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 12:37:01', '2019-03-15 12:37:01'),
(6, 3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsIm9yZ2FuaXphdGlvbiI6MSwicm9sZSI6NCwicm9sZUxldmVsIjo2LCJlbWFpbCI6Im9yZ0B0ZXN0LmNvbSIsImlhdCI6MTU1MjY1MzUxNSwiZXhwIjoxNTUyNzM5OTE1fQ.za1UQNsBF9bGwwfPGcj7c4IXyn1RpWhJYMfTewqoaiU', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"46\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 12:38:35', '2019-03-15 12:38:35'),
(7, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Miwicm9sZUxldmVsIjoyLCJlbWFpbCI6ImFkbWluQHRlc3QuY29tIiwiaWF0IjoxNTUyNjUzNTQwLCJleHAiOjE1NTI3Mzk5NDB9.m23AlbLxS9b9Rd30hxb2hiDGn2oxouwKjq7oEihMgLI', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"48\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 12:39:00', '2019-03-15 12:39:00'),
(8, 5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Mywicm9sZUxldmVsIjo2LCJlbWFpbCI6ImV4cGVydEB0ZXN0LmNvbSIsImlhdCI6MTU1MjY1NzI0OCwiZXhwIjoxNTUyNzQzNjQ4fQ.GTUWVFnCq4ktYnPIshlR5v2vE8GtjPBTYSj59anO7HY', '{\"host\":\"192.168.0.126:3000\",\"connection\":\"keep-alive\",\"content-length\":\"49\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"en-GB,en-US;q=0.9,en;q=0.8,te;q=0.7\"}', '2019-03-15 13:40:48', '2019-03-15 13:40:48'),
(9, 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6NSwicm9sZUxldmVsIjoxMCwiZW1haWwiOiJkZW1vYnVkZHlnYXBAZ21haWwuY29tIiwiaWF0IjoxNTUyODk1ODE3LCJleHAiOjE1NTI5ODIyMTd9.o2FSr9Vr1ugqMdYtyjza-nh5IRwc4bd98UMH_4SRlIY', '{\"host\":\"localhost:3000\",\"connection\":\"keep-alive\",\"content-length\":\"56\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"en-US,en;q=0.9\"}', '2019-03-18 07:56:57', '2019-03-18 07:56:57'),
(10, 4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjQsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6NSwicm9sZUxldmVsIjoxMCwiZW1haWwiOiJkZW1vYnVkZHlnYXBAZ21haWwuY29tIiwiaWF0IjoxNTUyODk5ODEwLCJleHAiOjE1NTI5ODYyMTB9.QPDfZvBQzZFIR7aEGED3QiXJoWX6Qn3c8vbjUKlvXaE', '{\"host\":\"localhost:3000\",\"connection\":\"keep-alive\",\"content-length\":\"56\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"en-US,en;q=0.9\"}', '2019-03-18 09:03:30', '2019-03-18 09:03:30'),
(11, 5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsIm9yZ2FuaXphdGlvbiI6bnVsbCwicm9sZSI6Mywicm9sZUxldmVsIjo2LCJlbWFpbCI6ImV4cGVydEB0ZXN0LmNvbSIsImlhdCI6MTU1Mjg5OTg2NCwiZXhwIjoxNTUyOTg2MjY0fQ._cgfdMAomZOld-Hycbg6dWi_gx7xCMmtp5YKjIfwmVY', '{\"host\":\"localhost:3000\",\"connection\":\"keep-alive\",\"content-length\":\"49\",\"accept\":\"application/json, text/plain, */*\",\"origin\":\"http://localhost:4200\",\"user-agent\":\"Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36\",\"content-type\":\"application/json\",\"referer\":\"http://localhost:4200/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"en-US,en;q=0.9\"}', '2019-03-18 09:04:24', '2019-03-18 09:04:24');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE `user_profile` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `about` text,
  `adress` text,
  `pincode` varchar(15) DEFAULT NULL,
  `linkedinId` varchar(255) DEFAULT NULL,
  `resume` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `userId`, `about`, `adress`, `pincode`, `linkedinId`, `resume`, `createdAt`, `updatedAt`) VALUES
(2, 4, 'fgfgh', 'fghfgh', 'fghfg', 'hfghfgh', 'C:fakepathCL Tables Analysis1.xls', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile_edu`
--

CREATE TABLE `user_profile_edu` (
  `id` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `education` varchar(255) NOT NULL,
  `university` varchar(255) NOT NULL,
  `courseFrom` date NOT NULL,
  `courseTo` date NOT NULL,
  `specilization` varchar(255) NOT NULL,
  `grade` varchar(10) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_profile_edu`
--

INSERT INTO `user_profile_edu` (`id`, `userProfileId`, `education`, `university`, `courseFrom`, `courseTo`, `specilization`, `grade`, `createdAt`, `updatedAt`) VALUES
(8, 4, 'test333', 'dfgdfg', '2019-03-18', '2019-03-18', 'dfgd', 'fdfgdfgdfg', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 4, 'test333', 'dfgdfg', '2019-03-18', '2019-03-18', 'dfgd', 'fdfgdfgdfg', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile_exp`
--

CREATE TABLE `user_profile_exp` (
  `id` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `organizationName` varchar(255) NOT NULL,
  `desgination` varchar(255) NOT NULL,
  `joinedDate` date NOT NULL,
  `relivedDate` date DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_profile_exp`
--

INSERT INTO `user_profile_exp` (`id`, `userProfileId`, `organizationName`, `desgination`, `joinedDate`, `relivedDate`, `createdAt`, `updatedAt`) VALUES
(1, 4, 'fghfgh', 'fghfghfgh', '2019-03-19', '2019-03-19', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 4, 'fghfgh', 'fghfghfgh', '2019-03-19', '2019-03-19', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile_subdomains`
--

CREATE TABLE `user_profile_subdomains` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `userSkills` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `domain`
--
ALTER TABLE `domain`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exp_level`
--
ALTER TABLE `exp_level`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizationId` (`organizationId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `interview`
--
ALTER TABLE `interview`
  ADD PRIMARY KEY (`id`),
  ADD KEY `domainId` (`domainId`),
  ADD KEY `expertLevelId` (`expLevelId`),
  ADD KEY `instanceId` (`organizationId`),
  ADD KEY `subDomainId` (`subDomainId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `interview_experts`
--
ALTER TABLE `interview_experts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expertId` (`expertId`),
  ADD KEY `interviewUserId` (`interviewUserId`);

--
-- Indexes for table `interview_experts_feedback`
--
ALTER TABLE `interview_experts_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interviewExpertId` (`interviewExpertId`),
  ADD KEY `interviewUserQuestionId` (`interviewUserQuestionId`);

--
-- Indexes for table `interview_expert_overall_feedback`
--
ALTER TABLE `interview_expert_overall_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interviewExpertId` (`interviewExpertId`),
  ADD KEY `reviewskillsId` (`reportPerameterId`);

--
-- Indexes for table `interview_fixed_questions`
--
ALTER TABLE `interview_fixed_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionId` (`questionId`),
  ADD KEY `interview_fixed_questions_ibfk_1` (`interviewId`);

--
-- Indexes for table `interview_question_template`
--
ALTER TABLE `interview_question_template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `domainId` (`domainId`),
  ADD KEY `expertLevelId` (`expertLevelId`),
  ADD KEY `organizationId` (`organizationId`),
  ADD KEY `subDomainId` (`subDomainId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `interview_question_template_fixed_questions`
--
ALTER TABLE `interview_question_template_fixed_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `questionId` (`questionId`),
  ADD KEY `questionTemplateId` (`interviewQuestionTemplateId`);

--
-- Indexes for table `interview_types`
--
ALTER TABLE `interview_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `interview_type_map`
--
ALTER TABLE `interview_type_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instanceId` (`organizationId`),
  ADD KEY `paymentId` (`paymentId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `interview_type_map_child`
--
ALTER TABLE `interview_type_map_child`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interviewTypeId` (`interviewTypeId`),
  ADD KEY `interviewTypeMapId` (`interviewTypeMapId`);

--
-- Indexes for table `interview_users`
--
ALTER TABLE `interview_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interviewId` (`interviewId`);

--
-- Indexes for table `interview_user_questions`
--
ALTER TABLE `interview_user_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `interviewUserId` (`interviewUserId`),
  ADD KEY `questionId` (`questionId`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `menu_access_map`
--
ALTER TABLE `menu_access_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_access_role_id_fk` (`roleId`),
  ADD KEY `menu_access_map_ibfk_1` (`menuId`);

--
-- Indexes for table `menu_master`
--
ALTER TABLE `menu_master`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_master_module_id_fk` (`moduleId`);

--
-- Indexes for table `menu_modules_master`
--
ALTER TABLE `menu_modules_master`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `module_title_unique` (`menuTitle`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organization_campus`
--
ALTER TABLE `organization_campus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expertLevelId` (`expLevelId`),
  ADD KEY `instanceId` (`organizationId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `domainId` (`domainId`),
  ADD KEY `subDomainId` (`subDomainId`);

--
-- Indexes for table `questions_temp`
--
ALTER TABLE `questions_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expertLevelId` (`expLevelId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `domainId` (`domainId`),
  ADD KEY `subDomainId` (`subDomainId`);

--
-- Indexes for table `question_temp_remarks`
--
ALTER TABLE `question_temp_remarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `NewIndex1` (`questionTempId`);

--
-- Indexes for table `report_perameters`
--
ALTER TABLE `report_perameters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizationId` (`organizationId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_domains`
--
ALTER TABLE `sub_domains`
  ADD PRIMARY KEY (`id`),
  ADD KEY `domainId` (`domainId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roleId` (`roleId`),
  ADD KEY `instanceId` (`organizationId`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizationId` (`organizationId`);

--
-- Indexes for table `user_groups_map`
--
ALTER TABLE `user_groups_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `groupId` (`groupId`);

--
-- Indexes for table `user_login_logs`
--
ALTER TABLE `user_login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `user_profile_edu`
--
ALTER TABLE `user_profile_edu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profile_exp`
--
ALTER TABLE `user_profile_exp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profile_subdomains`
--
ALTER TABLE `user_profile_subdomains`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userProfileId` (`userId`),
  ADD KEY `userSkills` (`userSkills`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `domain`
--
ALTER TABLE `domain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `exp_level`
--
ALTER TABLE `exp_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `interview`
--
ALTER TABLE `interview`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `interview_experts`
--
ALTER TABLE `interview_experts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `interview_experts_feedback`
--
ALTER TABLE `interview_experts_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `interview_expert_overall_feedback`
--
ALTER TABLE `interview_expert_overall_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interview_fixed_questions`
--
ALTER TABLE `interview_fixed_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `interview_question_template`
--
ALTER TABLE `interview_question_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interview_question_template_fixed_questions`
--
ALTER TABLE `interview_question_template_fixed_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interview_types`
--
ALTER TABLE `interview_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `interview_type_map`
--
ALTER TABLE `interview_type_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `interview_type_map_child`
--
ALTER TABLE `interview_type_map_child`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `interview_users`
--
ALTER TABLE `interview_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `interview_user_questions`
--
ALTER TABLE `interview_user_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `menu_access_map`
--
ALTER TABLE `menu_access_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `menu_master`
--
ALTER TABLE `menu_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `menu_modules_master`
--
ALTER TABLE `menu_modules_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `organization_campus`
--
ALTER TABLE `organization_campus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `questions_temp`
--
ALTER TABLE `questions_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_temp_remarks`
--
ALTER TABLE `question_temp_remarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_perameters`
--
ALTER TABLE `report_perameters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sub_domains`
--
ALTER TABLE `sub_domains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_groups_map`
--
ALTER TABLE `user_groups_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_login_logs`
--
ALTER TABLE `user_login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_profile`
--
ALTER TABLE `user_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_profile_edu`
--
ALTER TABLE `user_profile_edu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_profile_exp`
--
ALTER TABLE `user_profile_exp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_profile_subdomains`
--
ALTER TABLE `user_profile_subdomains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `coupons`
--
ALTER TABLE `coupons`
  ADD CONSTRAINT `coupons_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `exp_level`
--
ALTER TABLE `exp_level`
  ADD CONSTRAINT `exp_level_ibfk_1` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`),
  ADD CONSTRAINT `exp_level_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `interview`
--
ALTER TABLE `interview`
  ADD CONSTRAINT `interview_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `interview_ibfk_2` FOREIGN KEY (`expLevelId`) REFERENCES `exp_level` (`id`),
  ADD CONSTRAINT `interview_ibfk_3` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`),
  ADD CONSTRAINT `interview_ibfk_4` FOREIGN KEY (`subDomainId`) REFERENCES `sub_domains` (`id`),
  ADD CONSTRAINT `interview_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `interview_experts`
--
ALTER TABLE `interview_experts`
  ADD CONSTRAINT `interview_experts_ibfk_1` FOREIGN KEY (`expertId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `interview_experts_ibfk_2` FOREIGN KEY (`interviewUserId`) REFERENCES `interview_users` (`id`);

--
-- Constraints for table `interview_experts_feedback`
--
ALTER TABLE `interview_experts_feedback`
  ADD CONSTRAINT `interview_experts_feedback_ibfk_1` FOREIGN KEY (`interviewExpertId`) REFERENCES `interview_experts` (`id`),
  ADD CONSTRAINT `interview_experts_feedback_ibfk_2` FOREIGN KEY (`interviewUserQuestionId`) REFERENCES `interview_user_questions` (`id`);

--
-- Constraints for table `interview_expert_overall_feedback`
--
ALTER TABLE `interview_expert_overall_feedback`
  ADD CONSTRAINT `interview_expert_overall_feedback_ibfk_1` FOREIGN KEY (`interviewExpertId`) REFERENCES `interview_experts` (`id`),
  ADD CONSTRAINT `interview_expert_overall_feedback_ibfk_2` FOREIGN KEY (`reportPerameterId`) REFERENCES `report_perameters` (`id`);

--
-- Constraints for table `interview_fixed_questions`
--
ALTER TABLE `interview_fixed_questions`
  ADD CONSTRAINT `interview_fixed_questions_ibfk_1` FOREIGN KEY (`interviewId`) REFERENCES `interview` (`id`),
  ADD CONSTRAINT `interview_fixed_questions_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `questions` (`id`);

--
-- Constraints for table `interview_question_template`
--
ALTER TABLE `interview_question_template`
  ADD CONSTRAINT `interview_question_template_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `interview_question_template_ibfk_2` FOREIGN KEY (`expertLevelId`) REFERENCES `exp_level` (`id`),
  ADD CONSTRAINT `interview_question_template_ibfk_3` FOREIGN KEY (`organizationId`) REFERENCES `interview_type_map` (`id`),
  ADD CONSTRAINT `interview_question_template_ibfk_4` FOREIGN KEY (`subDomainId`) REFERENCES `sub_domains` (`id`),
  ADD CONSTRAINT `interview_question_template_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `interview_question_template_fixed_questions`
--
ALTER TABLE `interview_question_template_fixed_questions`
  ADD CONSTRAINT `interview_question_template_fixed_questions_ibfk_1` FOREIGN KEY (`questionId`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `interview_question_template_fixed_questions_ibfk_2` FOREIGN KEY (`interviewQuestionTemplateId`) REFERENCES `interview_question_template` (`id`);

--
-- Constraints for table `interview_type_map`
--
ALTER TABLE `interview_type_map`
  ADD CONSTRAINT `interview_type_map_ibfk_1` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`),
  ADD CONSTRAINT `interview_type_map_ibfk_2` FOREIGN KEY (`paymentId`) REFERENCES `payments` (`id`),
  ADD CONSTRAINT `interview_type_map_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `interview_type_map_child`
--
ALTER TABLE `interview_type_map_child`
  ADD CONSTRAINT `interview_type_map_child_ibfk_1` FOREIGN KEY (`interviewTypeId`) REFERENCES `interview_types` (`id`),
  ADD CONSTRAINT `interview_type_map_child_ibfk_2` FOREIGN KEY (`interviewTypeMapId`) REFERENCES `interview_type_map` (`id`);

--
-- Constraints for table `interview_users`
--
ALTER TABLE `interview_users`
  ADD CONSTRAINT `interview_users_ibfk_1` FOREIGN KEY (`interviewId`) REFERENCES `interview` (`id`);

--
-- Constraints for table `interview_user_questions`
--
ALTER TABLE `interview_user_questions`
  ADD CONSTRAINT `interview_user_questions_ibfk_1` FOREIGN KEY (`interviewUserId`) REFERENCES `interview_users` (`id`),
  ADD CONSTRAINT `interview_user_questions_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `questions` (`id`);

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `menu_access_map`
--
ALTER TABLE `menu_access_map`
  ADD CONSTRAINT `menu_access_map_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu_master` (`id`),
  ADD CONSTRAINT `menu_access_map_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`);

--
-- Constraints for table `menu_master`
--
ALTER TABLE `menu_master`
  ADD CONSTRAINT `menu_master_ibfk_1` FOREIGN KEY (`moduleId`) REFERENCES `menu_modules_master` (`id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`expLevelId`) REFERENCES `exp_level` (`id`),
  ADD CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`),
  ADD CONSTRAINT `questions_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `questions_ibfk_4` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`),
  ADD CONSTRAINT `questions_ibfk_5` FOREIGN KEY (`subDomainId`) REFERENCES `sub_domains` (`id`);

--
-- Constraints for table `question_temp_remarks`
--
ALTER TABLE `question_temp_remarks`
  ADD CONSTRAINT `FK_question_temp_remarks` FOREIGN KEY (`questionTempId`) REFERENCES `questions_temp` (`id`);

--
-- Constraints for table `report_perameters`
--
ALTER TABLE `report_perameters`
  ADD CONSTRAINT `report_perameters_ibfk_1` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`);

--
-- Constraints for table `sub_domains`
--
ALTER TABLE `sub_domains`
  ADD CONSTRAINT `sub_domains_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`);

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`organizationId`) REFERENCES `organization_campus` (`id`);

--
-- Constraints for table `user_groups_map`
--
ALTER TABLE `user_groups_map`
  ADD CONSTRAINT `user_groups_map_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_groups_map_ibfk_2` FOREIGN KEY (`groupId`) REFERENCES `user_groups` (`id`);

--
-- Constraints for table `user_login_logs`
--
ALTER TABLE `user_login_logs`
  ADD CONSTRAINT `user_login_logs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `user_profile_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_profile_edu`
--
ALTER TABLE `user_profile_edu`
  ADD CONSTRAINT `user_profile_edu_ibfk_1` FOREIGN KEY (`userProfileId`) REFERENCES `user_profile` (`id`);

--
-- Constraints for table `user_profile_exp`
--
ALTER TABLE `user_profile_exp`
  ADD CONSTRAINT `user_profile_exp_ibfk_1` FOREIGN KEY (`userProfileId`) REFERENCES `user_profile` (`id`);

--
-- Constraints for table `user_profile_subdomains`
--
ALTER TABLE `user_profile_subdomains`
  ADD CONSTRAINT `user_profile_subdomains_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_profile_subdomains_ibfk_2` FOREIGN KEY (`userSkills`) REFERENCES `sub_domains` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
