-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 19, 2025 at 02:23 PM
-- Server version: 10.5.26-MariaDB-ubu2004
-- PHP Version: 7.4.3-4ubuntu2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `belize_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_requests`
--

CREATE TABLE `account_requests` (
  `id` int(11) NOT NULL,
  `school_name` varchar(255) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `school_address` varchar(255) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `school_phone` varchar(50) DEFAULT NULL,
  `school_email` varchar(255) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `requested_at` datetime DEFAULT current_timestamp(),
  `reviewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `computerRoom`
--

CREATE TABLE `computerRoom` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `wired_for_lab` tinyint(1) DEFAULT NULL,
  `electrical` tinyint(1) DEFAULT NULL,
  `electrical_ground` tinyint(1) DEFAULT NULL,
  `electrical_outlets` int(11) DEFAULT NULL,
  `air_condition` int(11) DEFAULT NULL,
  `num_of_doors` int(11) DEFAULT NULL,
  `num_of_doors_secure` int(11) DEFAULT NULL,
  `partition_security` tinyint(1) DEFAULT NULL,
  `ceiling_secure` tinyint(1) DEFAULT NULL,
  `windows_secure` tinyint(1) DEFAULT NULL,
  `lighting` tinyint(1) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  `location_floor` tinyint(1) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `curriculum`
--

CREATE TABLE `curriculum` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `keyboarding` tinyint(1) DEFAULT NULL,
  `computer_literacy` tinyint(1) DEFAULT NULL,
  `word` tinyint(1) DEFAULT NULL,
  `spread_sheet` tinyint(1) DEFAULT NULL,
  `data_base` tinyint(1) DEFAULT NULL,
  `slide_show` tinyint(1) DEFAULT NULL,
  `google_workspace` tinyint(1) DEFAULT NULL,
  `software_suite` varchar(50) DEFAULT NULL,
  `cloud_based_learning_tools` tinyint(1) DEFAULT NULL,
  `graphics_design` tinyint(1) DEFAULT NULL,
  `graphics_animation` tinyint(1) DEFAULT NULL,
  `graphics_cad_program` tinyint(1) DEFAULT NULL,
  `robotics` tinyint(1) DEFAULT NULL,
  `code_dot_org` tinyint(1) DEFAULT NULL,
  `khan_accadamy` tinyint(1) DEFAULT NULL,
  `edpm` tinyint(1) DEFAULT NULL,
  `other_online_local_education_tools` varchar(50) DEFAULT NULL,
  `formal_curriculum` varchar(50) DEFAULT NULL,
  `local_curriculum` varchar(50) DEFAULT NULL,
  `rachel_server` tinyint(1) DEFAULT NULL,
  `other` varchar(250) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `demographics`
--

CREATE TABLE `demographics` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `principals_name` varchar(50) DEFAULT NULL,
  `principals_telephone` varchar(50) DEFAULT NULL,
  `principals_email` varchar(50) DEFAULT NULL,
  `schools_email` varchar(50) DEFAULT NULL,
  `principals_computer` tinyint(1) DEFAULT NULL,
  `number_of_students` int(11) DEFAULT NULL,
  `number_of_teachers` int(11) DEFAULT NULL,
  `largest_class_size` int(11) DEFAULT NULL,
  `number_of_buildings` int(11) DEFAULT NULL,
  `number_of_classrooms` int(11) DEFAULT NULL,
  `number_of_computer_labs` int(11) DEFAULT NULL,
  `minutes_drive_from_road` int(11) DEFAULT NULL,
  `power_stability` int(11) DEFAULT NULL,
  `has_pta` tinyint(1) DEFAULT NULL,
  `has_internet` tinyint(1) DEFAULT NULL,
  `number_of_classrooms_with_internet` int(11) DEFAULT NULL,
  `internet_provider` varchar(50) DEFAULT NULL,
  `internet_speed` enum('Don’t know','10 to 49 Mbps','50 to 99 Mbps','100 to 249 Mbps','250 to 500 Mbps') DEFAULT NULL,
  `connection_method` varchar(50) DEFAULT NULL,
  `internet_stability` enum('Very stable','Mostly OK','Comes in and out','Unstable') DEFAULT NULL,
  `number_of_teachers_that_have_laptops` int(11) DEFAULT NULL,
  `number_of_full_time_IT_teachers` int(11) DEFAULT NULL,
  `number_of_teachers_that_also_teach_IT` int(11) DEFAULT NULL,
  `primary_IT_teacher_name` varchar(50) DEFAULT NULL,
  `primary_IT_teacher_phone` varchar(50) DEFAULT NULL,
  `primary_IT_teacher_email` varchar(50) DEFAULT NULL,
  `percentage_of_students_who_have_personal_computers` int(11) DEFAULT NULL,
  `students_computers_outside_school` int(11) DEFAULT NULL,
  `students__phones_for_school_work` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moe_code_org`
--

CREATE TABLE `moe_code_org` (
  `code` varchar(10) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email_alt1` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `telephone_alt1` varchar(20) DEFAULT NULL,
  `telephone_alt2` varchar(20) DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moe_giga_connected`
--

CREATE TABLE `moe_giga_connected` (
  `name` varchar(80) NOT NULL,
  `address` varchar(80) DEFAULT NULL,
  `district` enum('Belize','Cayo','Corozal','Orange Walk','Stann Creek','Toledo') DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `contact_person_alt1` varchar(50) DEFAULT NULL,
  `telephone_alt1` varchar(20) DEFAULT NULL,
  `email_alt1` varchar(50) DEFAULT NULL,
  `email_alt2` varchar(50) DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moe_school_info`
--

CREATE TABLE `moe_school_info` (
  `name` varchar(80) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `address` varchar(80) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `telephone_alt1` varchar(20) DEFAULT NULL,
  `telephone_alt2` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `year_opened` int(11) DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `district` enum('Belize','Cayo','Corozal','Orange Walk','Stann Creek','Toledo') DEFAULT NULL,
  `locality` enum('Rural','Urban') DEFAULT NULL,
  `type` enum('Preschool','Primary','Secondary','Tertiary','Vocational','Adult and Continuing','University') DEFAULT NULL,
  `ownership` varchar(50) DEFAULT NULL,
  `sector` enum('Government','Government Aided','Private','Specially Assisted') DEFAULT NULL,
  `school_Administrator_1` varchar(50) DEFAULT NULL,
  `school_Administrator_2` varchar(50) DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moe_school_info`
--

INSERT INTO `moe_school_info` (`name`, `code`, `address`, `contact_person`, `telephone`, `telephone_alt1`, `telephone_alt2`, `email`, `website`, `year_opened`, `longitude`, `latitude`, `district`, `locality`, `type`, `ownership`, `sector`, `school_Administrator_1`, `school_Administrator_2`, `admin_comments`, `created_at`, `updated_at`) VALUES
('0Karl College Test 1', 'T1006', 'Calcutta Village', 'Rojer Acosta', '423-0068', '111-1111', '222-2222', 'dougkarl10@gmail.com', 'www.bajc.edu.bz', 2008, -88.4361, 18.3652, 'Belize', 'Rural', 'Tertiary', 'Adventist Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Karl College Test 2', 'T1007', 'San Roman Village', 'Hugo Gonzalez', '423-3132', '111-1111', '222-2222', 'dougkarl10@gmail.com', '', 2014, -88.5087, 18.3048, 'Cayo', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Karl College Test 3', 'T1008', 'San Andres Rd.', 'Marlon Brown', '422-3062', '111-1111', '222-2222', 'dougkarl10@gmail.com', 'www.cjc.edu.bz', 2005, -88.4033, 18.3951, 'Corozal', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Karl College Test 4', 'T1009', 'Savannah Road  Independence Village  Stann Creek District', 'Marie Young', '523-2566', '111-1111', '222-2222', 'dougkarl10@gmail.com', '', 2007, -88.4263, 16.5373, 'Stann Creek', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Karl College Test 5', 'T1010', '', '', '', '', '', 'dougkarl10@gmail.com', '', 0, 0, 0, 'Toledo', 'Rural', 'Tertiary', '', 'Government', '', '', NULL, NULL, NULL),
('0Skon College Test 1', 'T1011', 'Calcutta Village', 'Rojer Acosta', '423-0068', '111-1111', '222-2222', 'skonjp@kenyon.edu', 'www.bajc.edu.bz', 2008, -88.4361, 18.3652, 'Belize', 'Rural', 'Tertiary', 'Adventist Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Skon College Test 2', 'T1012', 'San Roman Village', 'Hugo Gonzalez', '423-3132', '111-1111', '222-2222', 'skonjp@kenyon.edu', '', 2014, -88.5087, 18.3048, 'Cayo', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Skon College Test 3', 'T1013', 'San Andres Rd.', 'Marlon Brown', '422-3062', '111-1111', '222-2222', 'skonjp@kenyon.edu', 'www.cjc.edu.bz', 2005, -88.4033, 18.3951, 'Corozal', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Skon College Test 4', 'T1014', 'Savannah Road  Independence Village  Stann Creek District', 'Marie Young', '523-2566', '111-1111', '222-2222', 'skonjp@kenyon.edu', '', 2007, -88.4263, 16.5373, 'Stann Creek', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Skon College Test 5', 'T1015', '', '', '', '', '', 'skonjp@kenyon.edu', '', 0, 0, 0, 'Toledo', 'Rural', 'Tertiary', '', 'Government', '', '', NULL, NULL, NULL),
('0Wisdom College Test 1', 'T1001', 'Calcutta Village', 'Rojer Acosta', '423-0068', '111-1111', '222-2222', 'wakanwe@gmail.com', 'www.bajc.edu.bz', 2008, -88.4361, 18.3652, 'Belize', 'Rural', 'Tertiary', 'Adventist Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Wisdom College Test 2', 'T1002', 'San Roman Village', 'Hugo Gonzalez', '423-3132', '111-1111', '222-2222', 'wakanwe@gmail.com', '', 2014, -88.5087, 18.3048, 'Cayo', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Wisdom College Test 3', 'T1003', 'San Andres Rd.', 'Marlon Brown', '422-3062', '111-1111', '222-2222', 'wakanwe@gmail.com', 'www.cjc.edu.bz', 2005, -88.4033, 18.3951, 'Corozal', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Wisdom College Test 4', 'T1004', 'Savannah Road  Independence Village  Stann Creek District', 'Marie Young', '523-2566', '111-1111', '222-2222', 'wakanwe@gmail.com', '', 2007, -88.4263, 16.5373, 'Stann Creek', 'Rural', 'Tertiary', 'Government Schools', 'Government', 'Admin 1', 'Admin 2', NULL, NULL, NULL),
('0Wisdom College Test 5', 'T1005', '', '', '', '111-1111', '', 'wakanwe@gmail.com', '', 0, 0, 0, 'Toledo', 'Rural', 'Tertiary', '', 'Government', '', '', NULL, NULL, NULL),
('A to Z Learning Tree Preschool', 'K21011', '2 Mount Mossey, Belmopan', 'Michelle Cano', '610-0270', '', '', 'a2zlearningtreepresch@gmail.com', '', 2010, -88.7616, 17.2588, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Michelle Cano (Principal)', 'Danielle Cano', NULL, NULL, NULL),
('ABC Preschool', 'K11002', 'San Pedro Town, Lion Street, Airstrip Area 1 Angel Lane', 'Wilfredo L Alamilla Jr', '226-3070', '', '', 'abcpreschoolsp@hotmail.com', '', 1979, -87.9654, 17.9175, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Wilfredo L Alamilla Jr', 'Faride Salinas', NULL, NULL, NULL),
('Agriculture and Natural Resource Institute - ANRI', 'S50102', 'Canada Hill Road, Stann Creek', 'Stanley Murillo', '532-2085', '', '', 'anrischool@yahoo.com', '', 2008, -88.353, 16.9779, 'Stann Creek', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Aguacate RC Primary', 'P61101', 'Aguacate Village', 'Louis Cucul', '653-0756', '', '', 'aguacaterc@gmail.com', '', 1950, -89.092, 16.1616, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Louis Cucul', 'Jenella Pop', NULL, NULL, NULL),
('Alexia Nolberto PreSchool', 'K50001', 'Wagie\'le   Benguche Extension  Dangriga Town', 'Phidalia Castillo', '627-3396', '', '', 'phideliaramos@yahoo.com', '', 1984, -88.2296, 16.9771, 'Stann Creek', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Phidalia Castillo', '', NULL, NULL, NULL),
('All God\'s Children Preschool1', 'K44101', 'San Lazaro Village  Orange Walk District', 'Elsie Cordova', '342-9030', '665-9851', '666-5387', 'elsiecordova@gmail.com', '', 1972, -88.6604, 18.0381, 'Orange Walk', 'Rural', 'Preschool', 'Assemblies Of God Schools', 'Government Aided', 'Elsie Cordova', 'Ahira Cordova', NULL, NULL, NULL),
('All God\'s Children Preschool2', 'K24105', 'Another World  Roaring Creek', 'Esther Elizabeth Smith', '623-0840', '', '', 'esmith_elshaddai@yahoo.com', '', 2006, -88.7989, 17.2632, 'Cayo', 'Rural', 'Preschool', 'U.E.C.B Schools', 'Government Aided', 'Esther Smith (Head teacher)', 'Lisa Elizabeth Gordon', NULL, NULL, NULL),
('All Saints Anglican Primary School', 'P12001', 'First & Dunn Street, Kings Park', 'Collin Estrada', '223-1390', '203-0273', '', 'allsaintsschool@live.com', 'https://www.allsaintsschool.edu.bz/', 1958, -88.1934, 17.5066, 'Belize', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Collin Estrada', 'Ines Berry', NULL, NULL, NULL),
('Alvin L. Young Nazarene High School', 'S29101', 'San Jose Succotz', 'Bay Rivas', '671-8382', '612-9886', '', 'principal@alynhs.edu.bz', '', 2008, -89.1236, 17.0777, 'Cayo', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Alvin L. Young Nazarene High School Evening Division', 'A27101', 'San Jose Succotz', 'Bay Rivers', '', '', '', '', '', 2025, 0, 0, 'Cayo', 'Rural', 'Adult and Continuing', 'Nazarene Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Ambergris Caye Elementary Primary', 'P17010', '1 Turtle Street, San Pedro Town', 'Amanda Burgos', '226-2226', '', '', 'officeadmins@aces.edu.bz', 'aces.edu.bz', 2010, -87.9772, 17.9061, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Amanda Burgos', 'Jovani Grajalez', NULL, NULL, NULL),
('Angela Casey Preschool', 'K22001', 'Independence Park Area  Belmopan', 'Angela T. Casey', '802-2623', '', '', 'bmpcompresch@yahoo.com', '', 1983, -88.7669, 17.2503, 'Cayo', 'Urban', 'Preschool', 'Community Schools', 'Specially Assisted', 'Angela Casey', 'Gayner Humes/ Karen  Castillo', NULL, NULL, NULL),
('Anglican Cathedral College', 'S12001', '71 Regent Street', 'Paulett Gentle', '227-2098', '', '', 'angcolbelize@yahoo.com', '', 1982, -88.1877, 17.4891, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Anglican Diocesan Preschool', 'K14002', '12 Gabourel Lane', 'Francisca Thomas', '207-0639', ' 615-2099', '', 'anglicandiocesanpreschool@yahoo.com', '', 2006, -88.1843, 17.4956, 'Belize', 'Urban', 'Preschool', 'Anglican Schools', 'Government Aided', 'Francisca Thomas, Principal', 'Zydah Cayetano Teacher', NULL, NULL, NULL),
('Armenia Development Preschool', 'K24109', '46 miles Hummingbird Highway, Armenia Village', 'Clementina Romero', '615-5252', '', '', 'armeniagovsch@gmail.com', '', 2013, -88.7452, 17.1554, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Erminda Pop', '', NULL, NULL, NULL),
('Armenia Government Primary School', 'P20401', 'Mile 46 Hummingbird Highway', 'Clementina Romero', '615-5252', '', '', 'armeniagovschl@gmail.com', '', 1993, -88.745, 17.1555, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Clementina Romero', 'Marin Rosado', NULL, NULL, NULL),
('Arms of Love Preschool2', 'K23003', 'Kontiki Area, San Ignacio', 'Yvonne Javier', '667-3590', '660-1627', '', 'rachelisejuan@hotmail.com', '', 2009, -89.0782, 17.1444, 'Cayo', 'Urban', 'Preschool', 'Evangelical Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Arms of Love Primary', 'P29002', 'Kontiki Area', 'Chantel Petzold', '', '', '', 'principal.armsofloveprimary@gmail.com', '', 2014, -89.0782, 17.1442, 'Cayo', 'Urban', 'Primary', 'U.E.C.B Schools', 'Government Aided', 'Iris Cano (Principal)', '', NULL, NULL, NULL),
('August Pine Ridge Preschool', 'K44104', 'August Pine Ridge Village', 'Blanca E. Torres', '303-3288', '', '', '', '', 2014, -88.7269, 17.9728, 'Orange Walk', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('August Pine Ridge RC Primary', 'P41401', 'August Pine Ridge', 'Blanca Estela Torres', '666-2939', '303-3288', '', 'bestorres@gmail.com', '', 2014, -88.7268, 17.9732, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Baptist School of Adult Continuing Education', 'A29001', 'Banana Bank Area', 'Janice Willacey', '822-2437', '', '', 'janicewillacey@hotmail.com', '', 2013, -88.7889, 17.2698, 'Cayo', 'Urban', 'Adult and Continuing', 'Baptist Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Belize Adventist College', 'S34101', 'Calcutta Village  Corozal District', 'Pamela Heron', '423-0080', '423-0044', '', 'bzadvcol@yahoo.com', '', 2014, -88.4361, 18.3652, 'Corozal', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Belize Adventist Jr. College', 'J34101', 'Calcutta Village', 'Rojer Acosta', '423-0068', '', '', 'dean@bajc.edu.bz', 'www.bajc.edu.bz', 2008, -88.4361, 18.3652, 'Corozal', 'Rural', 'Tertiary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Belize Christian Academy High School', 'S29100', 'Mile 44 1', 'Minerva Blancaneaux', '822-3048', '', '', 'information@belizechristianacademy.com', '', 2014, -88.7837, 17.2774, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Belize Christian Academy Preschool', 'K21103', '47 1/2 Mls Western Highway, Banana Bank Road', 'Carolyn Hulse', '822-3048', '615-1231', '', 'chulse@belizechristianacademy.com', 'www.belizechristianacademy.com', 2008, -88.7837, 17.2774, 'Cayo', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Carolyn Hulse', 'Nadini Vasquez', NULL, NULL, NULL),
('Belize Christian Academy Primary', 'P27401', 'Mile 47 George Price Highway', 'Carolyn Hulse', '822-3048', '', '', 'information@belizechristianacademy.com', 'www.belizechristianacademy.com', 2008, -88.7837, 17.2774, 'Cayo', 'Rural', 'Primary', 'Private Schools', 'Private', 'Carolyn Hulse,Minerva Blancaneaux', 'Sherlee Camal,Jomaira Martinez', NULL, NULL, NULL),
('Belize Elementary Preschool', 'K11001', 'Princess Margaret Drive', 'Majiba Sharp', '223-5765', '', '', 'pto@bes.edu.bz', 'www.bes.edu.bz', 1988, -88.1973, 17.5069, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Majiba Sharp', '', NULL, NULL, NULL),
('Belize Elementary Primary School', 'P17001', 'Princess Margaret Drive, Belize City', 'Majiba Sharp', '223-5765', '', '', 'bes@btl.net', 'www.bes.edu.bz', 1988, -88.1973, 17.5069, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Majiba Sharp', 'Iris Tewes', NULL, NULL, NULL),
('Belize High School', 'S17004', 'Mercy Lane, Belize City', 'Majiba Sharp', '223-5765', '', '', 'info@belizehighschool.edu.bz', '', 2014, -88.1981, 17.5062, 'Belize', 'Urban', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Belize High School of Agriculture', 'S40101', 'San Lazaro/Trinidad', 'Abel Celiz', '621-7847', '', '', 'bhsa1984@yahoo.com', '', 2014, -88.673, 18.0305, 'Orange Walk', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Belize Rural High School', 'S10101', 'Double Head Cabbage,  Belize District', 'Hubert Pascual', '621-6036', '611-0894', '', 'principal@brhs.edu.bz', '', 1983, -88.5557, 17.5517, 'Belize', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Belize Rural Primary School', 'P10302', 'Double Head, Flowers Bank, Rancho, Bermudian Landing', 'Ardeth McFadzean Kelly - VP', '615-8395', '', '', 'bzerps@yahoo.com', '', 2011, -88.5554, 17.5532, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', 'Juliet Roca', '', NULL, NULL, NULL),
('Bella Vista Government Secondary School', 'S60103', 'Bella Vista Village', 'Juanita Lucas', '601-7903', '615-3403', '', 'principal.bvgss@gmail.com', '', 2021, -88.5174, 16.5036, 'Toledo', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Bella Vista Preschool', 'K60104', 'Bella Vista Village, Toledo District', 'Arlette Serano', '652-9946', '', '', 'arletteserano@gmail.com', '', 2021, -88.5173, 16.5031, 'Toledo', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Belmopan Baptist High School', 'S28001', 'Banana Bank Area, Belmopan', 'Maureen Arnold', '822-2437', '', '', 'bbhs_accts@yahoo.com', '', 1998, -88.7888, 17.2701, 'Cayo', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Belmopan Comprehensive School', 'S20001', 'George Price Blvd.', 'Shirley Vaughan', '822-2253', '', '', 'comprebz@yahoo.com', '', 1970, -88.7689, 17.2455, 'Cayo', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Belmopan Methodist High School', 'S23001', 'Ring Road, Belmopan', 'Indira Bowden', '822-2153', '', '', 'bmpmethodist.hs@gmail.com', '', 2013, -88.7625, 17.2474, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Benque Viejo Community Preschool', 'K22002', 'Corner Baron Bliss & Church St', 'Flor Velasquez', '803-2110', '', '', 'benquecommunitypreschool@gmail.com', '', 1981, -89.1349, 17.0728, 'Cayo', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Flor Velasquez (Principal)', 'Elsa Gonzalez (Teacher)', NULL, NULL, NULL),
('Bernice Yorke Institute of Learning Preschool', 'K11003', '27 Corner St. Thomas & Sixth Street', 'Sherry Ali', '223-1876', '626-7873', '', 'info@byi.bz', 'www.byi.bz', 2014, -88.2334, 17.5173, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Malaika Yorke, Owner/Technology Director', 'Tanya Barrow, Owner/Technology Director', NULL, NULL, NULL),
('Bernice Yorke Institute of Learning Primary', 'P17005', '#27 Corner St. Thomas & 6th Street', 'Sherry Ali', '223-1876', '626-7873', '', 'info@byi.bz', 'www.byi.bz', 1966, -88.2334, 17.5173, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Malaika Yorke, Owner/Technology Director', 'Tanya Barrow, Owner/Technology Director', NULL, NULL, NULL),
('Bethany Baptist Preschool', 'K14003', 'Corner Cemetery Road & Central American Blvd', 'Sheryl Zetina', '602-0205', '', '', 'zetsher14@gmail.com', '', 1977, -88.1997, 17.4957, 'Belize', 'Urban', 'Preschool', 'Baptist Schools', 'Specially Assisted', 'Karen Lewis, Head Teacher', '', NULL, NULL, NULL),
('Bethel SDA Primary', 'P64001', 'Indianville Area Extension  Punta Gorda Town  Toledo District', 'Simon Acosta', '662-1628', '629-1720', '', 'bethel.sda.pg@gmail.com', '', 1990, -88.8205, 16.1051, 'Toledo', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Rose Odinga', 'Kimberly Tyndall Warrior', NULL, NULL, NULL),
('Big Falls RC Preschool', 'K64101', 'Big Falls Village', 'Gregorio Chee', '604-7467', '614-8620', '', 'bigfallsrc@gmail.com', '', 2014, -88.8838, 16.2581, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Gregorio Chee', 'Orpha Garcia', NULL, NULL, NULL),
('Big Falls RC Primary', 'P61401', 'Big Falls Village', 'Gregorio Chee', '604-7467', '', '', 'bigfallsschool@gmail.com', '', 2013, -88.8836, 16.2581, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Gregorio Chee', 'Orpha Garcia', NULL, NULL, NULL),
('Billy White Government Preschool', 'K20104', 'Spanish Lookout, Cayo District', 'Maria del Carmen Terrelonge', '6323941', '', '', 'billywhitegovpreschool@yahoo.com', '', 2016, -89.0515, 17.2093, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Maria del Carmen Terrelonge', '', NULL, NULL, NULL),
('Billy White SDA Primary', 'P24450', 'Billy White, Spanish Lookout Area', 'Esrom Landero', '607-2616', '', '', 'billywhitesda6072616@gmail.com', '', 1994, -89.0496, 17.2139, 'Cayo', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Esrom Landero', 'Neptalie Canan', NULL, NULL, NULL),
('Biscayne Government Primary', 'P10401', '26 Miles Philip Goldson Highway  Biscayne Village  Belize District', 'Imam Neal', '615-7950', '', '', 'biscaynegovschool@gmail.com', '', 2014, -88.4525, 17.7133, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', 'Dorla Wade', '', NULL, NULL, NULL),
('Bishop Martin High School', 'S41002', '1/2  mile San Lorenzo Road', 'Angel Leiva', '322-3469', '', '', 'office@bmhsow.edu.bz', '', 2002, -88.5739, 18.098, 'Orange Walk', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Bishop O.P. Martin RC Primary', 'P21009', 'Bullet Tree Road, San Ignacio Town', 'Abimael Waight', '614-1413', '', '', 'bishopmartin2001@gmail.com', '', 2001, -89.0835, 17.1593, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Abimael Waight', 'Erington Neal', NULL, NULL, NULL),
('Blue Creek Mennonite Primary', 'P68470', 'Blue Creek Village, Punta Gorda, Toledo District', 'Mervin Amstutz/Daniel Sullivan', '670-4689', '603-1287', '', 'jordanmennoniteschool@gmail.com', '', 2014, -89.0439, 16.1999, 'Toledo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Mervin Amstutz', 'Daniel Sullivan', NULL, NULL, NULL),
('Blue Creek RC Preschool', 'K64113', 'Blue Creek Village', 'Carlos Chee', '654-3096', '', '', 'gcarlos33@gmail.com', '', 2014, -89.0457, 16.1991, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Carlos Chee', 'Nelita Chee', NULL, NULL, NULL),
('Blue Creek RC Primary', 'P61201', 'Blue Creek Village', 'Aurelio Palma', '625-8809', '', '', 'lelito79@yahoo.com', '', 2014, -89.0459, 16.199, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Carlos Chee', '', NULL, NULL, NULL),
('Bright Horizon Preschool', 'K11102', '8 Miles Community', 'Tarsha Lamb', '', '', '', 'tarshalamb@gmail.com', '', 2023, -88.299, 17.4745, 'Belize', 'Rural', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Bright Star Preschool', 'K64102', 'Forest Home Village, Toledo', 'Deborah Borland', '672-1151', '', '', 'dorita_ranguy@yahoo.com', '', 2014, -88.8291, 16.1351, 'Toledo', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', 'Deborah Borland', 'Dorita Ranguy', NULL, NULL, NULL),
('Brighter Tomorrow Preschool', 'K11018', 'Collin Clerk Subdivision, San Pedro Town', 'Ariani Y Gongora', '661-6127', '', '', 'btomorrow2007@gmail.com', '', 2007, -87.9707, 17.9171, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Ariani Y Gongora', '', NULL, NULL, NULL),
('Buena Vista Government Primary', 'P20201', 'Buena Vista Village, Spanish Lookout', 'Ewart Caballero', '636-3336', '', '', 'buenavista.govschool@gmail.com', '', 2014, -88.9424, 17.2501, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Ewart Caballero', 'Carmencita Blanco', NULL, NULL, NULL),
('Buena Vista Preschool', 'K34116', 'Buena Vista Village', 'Fernando Bobadilla', '661-7618', '', '', 'czlbuenavistarcs@gmail.com', '', 2008, -88.5255, 18.2343, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Buena Vista RC Primary School', 'P31402', 'Buena Vista Village', 'Fernando Bobadilla', '661-7618', '', '', 'czlbuenavistarcs@gmail.com', '', 1963, -88.5255, 18.2343, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Building Block Preschool', 'K11004', '1 Racoon Street', 'Denise Trapp', '651-3623', '', '', 'buildingblockpreschool@yahoo.com', '', 1990, -88.1938, 17.4914, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Denise Trapp, Principal', 'Delone Bailey, Teacher/Admin', NULL, NULL, NULL),
('Bullet Tree Community Preschool', 'K22101', 'Bullet Tree Fall, Cayo District', 'Natalie Arnold', '666-8665', '', '', 'babynats_30@yahoo.com', '', 1993, -89.1123, 17.1728, 'Cayo', 'Rural', 'Preschool', 'Community Schools', 'Government', 'Natalie Arnold (Principal)', '', NULL, NULL, NULL),
('Bullet Tree SDA Primary', 'P24401', 'Bullet Tree Falls Village', 'Clarita Ortega Valdez', '669-8932', '', '', 'claritaortega06@yahoo.com', '', 1991, -89.1123, 17.1671, 'Cayo', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Clarita Valdez (Principal)', 'Delmie Hernandez (Teacher)', NULL, NULL, NULL),
('Burrell Boom Methodist Primary', 'P13401', 'Main Avenue  Burrell Boom Village', 'Kevin Brooks', '225-9024', '', '', 'bbmmss2010@yahoo.com', '', 2014, -88.4034, 17.5688, 'Belize', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Buttonwood Bay Nazarene Primary School', 'P15001', '4649 Coney Drive, Buttonwood Bay, Belize City', 'Amelia Bencomo', '223-1847', '631-7132', '', 'bttnwdbynz@gmail.com', '', 1993, -88.2104, 17.512, 'Belize', 'Urban', 'Primary', 'Nazarene Schools', 'Government Aided', 'Amelia Bencomo', 'Avril Budd', NULL, NULL, NULL),
('Calcutta Government Preschool', 'K30101', 'Calcutta Village', 'Annaese Mendez', '663-8519', '', '', '', '', 2004, -88.4321, 18.3631, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Calcutta Government Primary School', 'P30401', 'Calcutta Village', 'Annaese Mendez', '665-6563', '', '', 'calcuttagovernment2013@gmail.com', '', 1980, -88.4321, 18.3631, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Calcutta SDA Primary School', 'P34401', 'Mile 81 Phillip Goldson Highway', 'Miguel Hernandez', '665-1897', '', '', 'calcuttasdaschool@gmail.com', '', 1935, -88.4386, 18.3627, 'Corozal', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Caledonia RC Preschool', 'K34101', 'Caledonia Village', 'Sebastian Vargas', '663-6300', '', '', 'caledonia.rcschool@gmail.com', '', 2014, -88.474, 18.2295, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Caledonia RC Primary School', 'P31403', 'Caledonia Village    Corozal District', 'Sebastian Vargas', '667-2874', '', '', 'caledonia.rcschool@gmail.com', 'caledoniaschool.edu.bz.', 1890, -88.474, 18.2295, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Calvary Temple Primary School', 'P19002', '60 Regent Street West, Belize City', 'Georgett Bartley', '227-1676', '', '', 'calvarytempleschool60@gmail.com', '', 1952, -88.1898, 17.4972, 'Belize', 'Urban', 'Primary', 'Calvary Temple Primary School', 'Government Aided', '', '', NULL, NULL, NULL),
('Canaan SDA High School', 'S14001', '1508 Buttonwood Bay, Coney Drive, P.O. Box 1690', 'Jaime Roberts', '223-2297', '', '', 'chsprincipal@chs.edu.bz', '', 1988, -88.2094, 17.5116, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Carmelita Government Preschool', 'K42102', 'Carmelita Village', 'Keith Augustine/B. Codd', '302-1438', '632-0750', '', 'bonniebug1@yahoo.com', '', 2005, -88.5432, 18.0137, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Keith Augustine', 'Bernadette Codd', NULL, NULL, NULL),
('Carmelita Government Primary School', 'P40401', 'Carmelita Village, Orange Walk District', 'Keith Augustine', '665-5106', '302-1438', '', 'carmgov@yahoo.com', '', 2014, -88.5432, 18.0137, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Carmen\'s Preschool', 'K41001', '5 Palmetto Ave, Louisiana Area', 'Carmita Guiterrez', '627-9188', '', '', 'carmitagutierrez65@gmail.com', '', 2014, -88.5634, 18.0703, 'Orange Walk', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Carmen Gutierrez', '', NULL, NULL, NULL),
('Casey Community Preschool', 'K41103', 'PO Box 37, Belize City, Gallon Jug', 'Ozem Briceno', '626-1152', '', '', '', '', 2014, -89.0464, 17.5607, 'Orange Walk', 'Rural', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Casey Community Primary School', 'P47401', 'PO Box 37, Belize City, Gallon Jug', 'Ozem Briceno', '626-1152', '', '', 'ozembriceno17@gmail.com', '', 2014, -89.0464, 17.5607, 'Orange Walk', 'Rural', 'Primary', 'Private Schools', 'Private', 'Ozem Briceno', 'Zamily Castillo', NULL, NULL, NULL),
('Caye Caulker RC Primary', 'P11201', 'Avenida Pueblo Nuevo, Caye Caulker', 'Beatriz Chan', '226-0164', '668-2985', '', 'ckrrcs@gmail.com', '', 1965, -88.0264, 17.7388, 'Belize', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Beatriz Chan', 'Teisy Ek', NULL, NULL, NULL),
('Cayo Christian Academy High School', 'S27103', 'Ontario Village  P.O. Box 636  Belmopan, Belize', 'Nazle Banner', '672-2009', '', '', 'ccabelize@gmail.com', '', 2014, -88.8856, 17.2262, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Cayo Deaf Institute', 'P27101', 'Central Farm  Cayo District', 'Peter Neufeld', '', '', '', '', '', 2024, 0, 0, 'Cayo', 'Rural', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Central Christian Preschool', 'K14006', '116 Freetown Road, Belize City', 'Kenesha Perry', '224-5674', '', '', 'centralchristianschoolag@gmail.com', '', 2014, -88.1945, 17.5039, 'Belize', 'Urban', 'Preschool', 'Assemblies Of God Schools', 'Government Aided', 'Kennisha Perry', '', NULL, NULL, NULL),
('Central Christian Primary', 'P16001', '166 Freetown Road, Belize City', 'Kenesha Perry', '224-5674', '', '', 'centralchristianschoolag@gmail.com', 'none', 1978, -88.1945, 17.5039, 'Belize', 'Urban', 'Primary', 'Assemblies Of God Schools', 'Government Aided', 'Helen Parker', 'Kenesha Perry', NULL, NULL, NULL),
('Centro Escolar Mexico Jr. College', 'J30101', 'San Roman Village', 'Hugo Gonzalez', '423-3132', '', '', 'cemjc07@yahoo.com', '', 2014, -88.5087, 18.3048, 'Corozal', 'Rural', 'Tertiary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Chan Chen Government Primary School', 'P30402', 'Chan Chen Village  Corozal District  Belize C.A.', 'Carlos Itzab', '665-9221', '', '', 'chanchengov@gmail.com', '', 1972, -88.4279, 18.4403, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Chan Chen Preschool', 'K30105', 'Chan Chen Village', 'Carlos Itzab', '665-9221', '', '', 'chanchengov@gmail.com', '', 2006, -88.4279, 18.4403, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Chan Pine Ridge Government Primary', 'P40402', 'Chan Pine Ridge Village', 'Rubiceli Varela', '631-3991', '', '', 'victorpadron@yahoo.com', '', 2014, -88.5831, 18.0345, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', 'Victor Padron', 'Lorena Padron', NULL, NULL, NULL),
('Chan Pine Ridge Preschool', 'K40102', 'Chan Pine Ridge Village', 'Victor Padron', '604-5977', '', '', '', '', 2013, -88.5831, 18.0345, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Chapel Primary School', 'P49001', 'Tate Street, Orange Walk Town', 'Heidi Tejada', '637-6344', '', '', 'chapelschool2018@gmail.com', '', 1969, -88.5612, 18.0866, 'Orange Walk', 'Urban', 'Primary', 'U.E.C.B Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Christ the King Anglican Primary', 'P52001', '2 Rest House Alley, Dangriga Town', 'Nancy Flores- Cruz', '502-2462', '615-7539', '614-5564', 'ctkas16@gmail.com', '', 2014, -88.2206, 16.9713, 'Stann Creek', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Nancy Flores-Cruz', '', NULL, NULL, NULL),
('Christian Assemblies Of God Preschool', 'K34119', 'Santa Rita Layout', 'Jesus Catzim', '667-8824', '', '', 'santaritasembliesofgod@gmail.com', '', 2014, -88.3952, 18.4032, 'Corozal', 'Urban', 'Preschool', 'Assemblies Of God Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Christiline Gill SDA Preschool', 'K34021', 'Pot Saul Area', 'Ever Lucas', '402-2909', '', '', 'csgsdapreschool@gmail.com', '', 2012, -88.3928, 18.3962, 'Corozal', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Christiline Gill SDA Primary School', 'P34001', 'Port Saul Area', 'Ever Alfredo Lucas', '402-2909', '', '', 'cgsda1945@gmail.com', '', 1945, -88.3928, 18.3962, 'Corozal', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Chunox RC Preschool', 'K34102', 'Chunox Village', 'Octaviano Mesh', '653-0083', '', '', 'octavianomesh@hotmail.com', '', 1993, -88.3586, 18.2933, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Chunox RC Primary School', 'P31102', 'Chunox Village,  Corozal District,  Belize.', 'Mario Mesh', '650-9754', '', '', 'chunoxrc2020@gmail.com', '', 1931, -88.3586, 18.2933, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Chunox Saint Viator Vocational High School', 'S30102', '1.5 miles Chunox-Sarteneja Road  P.O. Box 330  Corozal Town', 'Marconie  Moh', '433-6031', '669-3452', '621-4341', 'chunox_stv@hotmail.com', '', 2004, -88.3299, 18.3047, 'Corozal', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Chunox SDA Primary School', 'P34101', 'Chunox Village', 'Daniel Montalvo', '665-9652', '', '', 'chunox.sda00@gmail.com', '', 2000, -88.3549, 18.2931, 'Corozal', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Church of Christ Children Centre', 'K54108', '281 Happy Avenue, Independence Village', 'Kaniesha Pandy', '6341835', '', '', 'cocps05@gmail.com', '', 1998, -88.4139, 16.5315, 'Stann Creek', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Phyllis Garbutt', 'Linden Garbutt', NULL, NULL, NULL),
('Church of Christ Preschool', 'K14004', '1 Elston Kerr Street, Belize City', 'Kiesha Williams', '621-3482', '', '', 'nashka_naeisha@yahoo.com', '', 2014, -88.2003, 17.4961, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Church of Christ Primary', 'P59101', 'Independence Village', 'Kennishia Pandy', '634-1835', '', '', 'cocps05@gmail.com', '', 2005, -88.4139, 16.5315, 'Stann Creek', 'Rural', 'Primary', 'Private Schools', 'Private', 'Phyllis Garbutt', '', NULL, NULL, NULL),
('Cinderella Preschool', 'K23001', '3rd Street San Ignacio Cayo', 'Shakira Cho', '610-4948', '', '', 'cinderella.pre@gmail.com', '', 1993, -89.0736, 17.1602, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Shakira Cho', 'Amancia Obando', NULL, NULL, NULL),
('City Early Childhood Education Centre', 'K11005', '5759 Corner Meighan & Goldson Ave, Kings Park', 'Maria Requena', '600-7463', '', '', 'cecec1973@gmail.com', '', 2014, -88.1954, 17.511, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Maria Requena', 'Michelle Sanchez, Teacher', NULL, NULL, NULL),
('Claver College Extension ACE', 'A60001', 'Jose Maria Nunez Street', 'Dave Forman', '606-3079', '', '', 'clavercollege@gmail.com', '', 1999, -88.8055, 16.0975, 'Toledo', 'Urban', 'Adult and Continuing', 'Community Schools', 'Specially Assisted', 'Dave Forman', '', NULL, NULL, NULL),
('Coastal Education Center', 'P57102', 'Main Street  Placencia', 'Tanya Edwards', '', '', '', 'coastaleducationcenter.bz@gmail.com', 'https://www.coastaleducationcenter.bz/', 2023, -88.3667, 16.5139, 'Stann Creek', 'Rural', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Coastland Community Preschool', 'K52001', '1596 Teddy Cat Street, Dangriga', 'Clarabelle Martinez', '608-1461', '624-4734', '', 'mpetra47@gmail.com', '', 1992, -88.2244, 16.9645, 'Stann Creek', 'Urban', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Coastland Education Institute Primary', 'P57002', '1596 Teddy Cas Street, Dangriga Town / AB Ogaldez Street Dangriga Town', 'Clarabelle Martinez', '608-1461', '624-4734', '', 'mpetra47@yahoo.com', '', 2014, -88.2244, 16.9645, 'Stann Creek', 'Urban', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Compassion UECB Primary School', 'P49402', 'Yo Creek Village', 'Manuel Rejon', '342-7110', '628-0400', '', 'compassionschool89@gmail.com', '', 2014, -88.6403, 18.0918, 'Orange Walk', 'Rural', 'Primary', 'U.E.C.B Schools', 'Government Aided', 'Manuel Rejon', '', NULL, NULL, NULL),
('Concepcion Presbyterian Preschool', 'K34117', 'Concepcion Village', 'Christian E. Cobos', '423-0332', '', '', 'presbyconcepcion.preschool@gmail.com', '', 1997, -88.4668, 18.3225, 'Corozal', 'Rural', 'Preschool', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Concepcion Presbyterian Primary School', 'P39402', 'Concepcion Village', 'Christian E. Cobos', '423-0332', '610-6952', '', 'concepcionpresbschool@gmail.com', '', 1997, -88.4668, 18.3225, 'Corozal', 'Rural', 'Primary', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Concepcion RC Preschool', 'K34114', 'Conception Village', 'Deyfi Perez', '621-7223', '', '', 'concepcion.preschool@gmail.com', '', 2014, -88.467, 18.324, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Concepcion RC Primary School', 'P31404', 'Concepcion Village', 'Deyfi Perez', '621-7223', '', '', 'concepcion.rcschool@gmail.com', '', 1945, -88.467, 18.324, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Copper Bank RC Preschool', 'K34118', 'Copper Bank', 'Normando Santoya', '651-4670', '622-1795', '', '', '', 2009, -88.3564, 18.3201, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Copper Bank RC Primary School', 'P31101', 'Copper Bank', 'Juanita Tzul', '637-1979', '', '', 'copperbankschool@gmail.com', '', 1960, -88.3564, 18.3201, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Corazon Creek RC Primary', 'P61104', 'Corazon Creek Village', 'Julio Kal', '650-9938', '', '', 'cal_julio@yahoo.com', '', 2014, -89.1224, 16.0535, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Julio Kal', '', NULL, NULL, NULL),
('Corazon Creek Technical High', 'S60102', 'Carzon Creek Village, Toledo', 'Roberto Mai', '615-3914', '', '', 'ccths2009@gmail.com', '', 2009, -89.1197, 16.0534, 'Toledo', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Cornerstone Christian School', 'P48104', 'Camp #5   PO Box 209  Shipyard   Orange Walk', 'John Friesen', '661-1776', '', '', '', '', 2017, -88.6813, 17.9499, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Cornerstone Presbyterian High School', 'S37101', 'Box 232  Mile 74 1/2 Philip Goldson Highway  Corozal District', 'Yadira Quintanilla', '670-9374', '', '', 'therockjesus@gmail.com', '', 2003, -88.4913, 18.3207, 'Corozal', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Church of Christ Preschool', 'K39001', 'Santa Maria Street  Hall\'s Layout,   Corozal Town', 'Jose Chan', '6704979', '', '', '', '', 2008, -88.3977, 18.3921, 'Corozal', 'Urban', 'Preschool', 'Corozal Church of Christ Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Church of Christ Primary School', 'P39001', 'Santa Maria Street  Hall\'s Layout,   Corozal Town', 'Jose Chan', '670-4979', '', '', 'chanjose6462@yahoo.com', '', 1991, -88.3977, 18.3921, 'Corozal', 'Urban', 'Primary', 'Corozal Church of Christ Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Community College', 'S39001', 'P.O. Box 63  San Andres  Corozal District', 'Matias Casanova', '422-2541', '', '', 'principal@ccc.edu.bz', '', 1978, -88.4058, 18.3942, 'Corozal', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Community College ACE', 'A30001', 'San Andres Road', 'Ravey Vellos', '422-3806', '', '', 'ravey.vellos@gmail.com', '', 0, -88.4058, 18.3942, 'Corozal', 'Urban', 'Adult and Continuing', 'Community Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Corozal Jr. College', 'J39001', 'San Andres Rd.', 'Marlon Brown', '422-3062', '', '', 'mbrown@cjc.edu.bz', 'www.cjc.edu.bz', 2005, -88.4033, 18.3951, 'Corozal', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Methodist Primary School', 'P33001', '57 1st Avenue,  Town', 'Steven Peña', '422-2839', '', '', 'cormethsch@gmail.com', '', 1859, -88.3847, 18.3914, 'Corozal', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Corozal Nazarene Preschool', 'K34004', 'Corozal District', 'Valentine Gonzalez', '600-7471', '', '', 'corozalnazareneschool@gmail.com', '', 2020, -88.3894, 18.3901, 'Corozal', 'Urban', 'Preschool', 'Nazarene Schools', 'Government Aided', 'Valentine Gonzalez', '', NULL, NULL, NULL),
('Corozal Nazarene Primary School', 'P35001', '5 Fifth Avenue,  Corozal Town', 'Alice Sierra', '600-7471', '', '', 'corozalnazareneschool@gmail.com', '', 2014, -88.3894, 18.3901, 'Corozal', 'Urban', 'Primary', 'Nazarene Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Crique Jute Government Primary', 'P60102', 'Crique Jute Village', 'Maria Bejerano', '630-1922', '', '', 'criquejutegovtschool@gmail.com', '', 1979, -89.0161, 16.2724, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Maria Bejerano', '', NULL, NULL, NULL),
('Cristo Rey RC Preschool', 'K24102', 'Cristo Rey Village', 'Arcelia Pech', '636-3270', '', '', 'Lovearc2004@yahoo.com', '', 2005, -89.0549, 17.1324, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Ronnie Ulloa', 'Arcelia Pech', NULL, NULL, NULL),
('Cristo Rey RC Primary School', 'P31405', 'Cristo Rey Village  Corozal Distict  Belize C.A.', 'Carmita C Chan', '662-5251', '', '', 'cristoreyr.c@gmail.com', '', 2014, -88.4962, 18.3481, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Carmita Chan', '', NULL, NULL, NULL),
('Cristo Rey RC Primary School-CYO', 'P21201', 'Cristo Rey, Cayo', 'Ronnie Ulloa', '621-4584', '', '', 'cristoreyrcschool@gmail.com', '', 2013, -89.0549, 17.1324, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Ronnie Ulloa', 'Arcelia Pech', NULL, NULL, NULL),
('Crooked Tree Government Primary', 'P10301', 'Crooked Tree Village', 'Vero Lauriano', '600-7335', '', '', 'crookedtreegovtschool@yahoo.com', '', 1951, -88.5362, 17.7763, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', 'Winnie GIllett', 'Kathie Gillett', NULL, NULL, NULL),
('Crooked Tree Preschool', 'K10101', 'Crooked Tree Village', 'Winnie Gillett', '245-7061', '', '', 'crookedtreegovtschool@yahoo.com', '', 2004, -88.5362, 17.7763, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Winnie GIllett', 'Kathie Gillett', NULL, NULL, NULL),
('Dangriga Adult Education Program', 'A57001', 'Dangriga Town', 'Francis Flores', '661-2913', '', '', '', '', 0, -88.2199, 16.9703, 'Stann Creek', 'Urban', 'Adult and Continuing', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Delille Academy High', 'S51002', '2nd New Site, Dangriga Town, PO Box 262', 'Dina Villafranco', '522-3917', '522-0601', '', 'delilleacademy@yahoo.com', '', 2014, -88.2327, 16.9666, 'Stann Creek', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('DePickni Place Preschool', 'K23101', 'Community Dr., Roaring Creek', 'Esther Wade', '610-6545', '', '', 'cruzinwkuch@gmail.com', '', 1991, -88.7966, 17.2606, 'Cayo', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Ellis Cruz', 'Melissa Cruz', NULL, NULL, NULL),
('Destiny Preschool', 'K51003', '2334 Teachers street,2 New site area    16.963501 Lat  -88.235247 Long', 'Yadira Diego', '622-9756', '634-6887', '', 'destinydaycarepreschool@hotmail.com', '', 2011, -88.2359, 16.9632, 'Stann Creek', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Yadira Diego', 'Laurel Diego', NULL, NULL, NULL),
('Ebanks Preschool', 'K11006', '5 Vernon Street, Belize City', 'Grace Ebanks', '227-4302', '', '', '', '', 2014, -88.1973, 17.4978, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Grace Ebanks', 'Shantel Tillett', NULL, NULL, NULL),
('Ebenezer Methodist Primary School', 'P13002', '117 Barrack Road, Belize City', 'Gaynor Munnings', '224-4558', '627-5113', '', 'ebenezerschool.meth1856@gmail.com', '', 1856, -88.1862, 17.5007, 'Belize', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Gaynor Munnings', 'Nelma Sampson Belisle', NULL, NULL, NULL),
('Ecumenical Adult Continuing Education', 'A50001', 'Ecumenical Drive, Dangriga Town', 'Ray Lawrence', '522-2114', '', '', 'scec@btl.net', '', 0, -88.2266, 16.9627, 'Stann Creek', 'Urban', 'Adult and Continuing', 'Community Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Eden Preschool', 'K44008', 'Tate Street, Orange Walk Town', 'Julian Chi Sr.', '622-4210', '', '', 'nextime61@gmail.com', '', 2014, -88.5612, 18.0866, 'Orange Walk', 'Urban', 'Preschool', 'U.E.C.B Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Eden SDA High School', 'S24001', 'Eden Drive, Santa Elena, Cayo District', 'Francisco Ottoniel Pivaral', '824-2966', '', '', 'principal@eden.edu.bz', '', 1987, -89.0533, 17.1653, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Eden SDA Preschool', 'K24008', 'Red Creek, Santa Elena', 'Sharon Carr-Lopez', '671-0525', '', '', 'sharonllopez2021@gmail.com', '', 2023, -89.0622, 17.1631, 'Cayo', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Eden SDA Primary', 'P24001', 'Cor. Carmen & Salazar St., Santa Elena', 'Sharon Lopez', '671-4952', '671-0525', '', 'edensdaprimary15@gmail.com', '', 2014, -89.0545, 17.1635, 'Cayo', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Tharine Gabourel', 'Aurora Hernandez', NULL, NULL, NULL),
('Edenthal Kleinegemeinde School', 'P47102', 'Quatro Leguas  Orange Walk District', 'Gerald Kornelsen', '', '', '', 'edenthalkleingemeindeschool@gmail.com', '', 1978, -88.9795, 17.9306, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Isaac Bergen', 'Dennis Kornelsen', NULL, NULL, NULL),
('Edward P. Yorke High School', 'S10001', 'Princess Margaret Drive, Belize City', 'Karen Canto', '224-4554', '', '', 'epyorke@yahoo.com', '', 1969, -88.1996, 17.5087, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('El Progresso Community Primary School', 'P20104', '7 Miles Mountain Pine Ridge Rd', 'Brian Watson', '663-1537', '', '', 'elprogressocommunityschool@gmail.com', '', 2014, -88.9535, 17.1002, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Brian Watson', 'Jose Medina', NULL, NULL, NULL),
('El Shaddai SDA Preschool', 'K24005', '1 Macal Street, Belmopan', 'Esmi Correra', '620-1288', '', '', 'elshaddaistaff@btl.net', '', 2016, -88.767, 17.2577, 'Cayo', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', 'Esmi Correa', '', NULL, NULL, NULL),
('El Shaddai SDA Primary', 'P24002', '1 Macal Street, Belmopan', 'Esmi Correa', '802-0391', '', '', 'elshaddaistaff@btl.net', '', 1998, -88.767, 17.2577, 'Cayo', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Esmi Correa', '', NULL, NULL, NULL),
('Emmanuel Presbyterian Preschool', 'K44106', 'San Pablo Village', 'Cira Novelo,   Mellissa Pech', '607-5986', '627-2516', '', 'novelocira@gmail.com', '', 2014, -88.5661, 18.208, 'Orange Walk', 'Rural', 'Preschool', 'Presbyterian Schools', 'Government Aided', 'Cira Novelo', '', NULL, NULL, NULL),
('Ephesus SDA Primary', 'P14002', '1 Wilson Street, Belize City', 'Carol Collins', '623-9997', '', '', 'ephesusprimaryschool@gmail.com', '', 1992, -88.1899, 17.5029, 'Belize', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Velda Jesse', '', NULL, NULL, NULL),
('Epworth Methodist Preschool', 'K54001', '119 Cor Commerce St. & Dr. Alley, Dangriga', 'Felisha Zuniga', '615-3047', '', '', 'epworthmethodist55@gmail.com', '', 2014, -88.222, 16.9693, 'Stann Creek', 'Urban', 'Preschool', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Epworth Methodist Primary', 'P53001', '119 Corner Commerce & Dr. Alley', 'Felisha Zuniga', '615-3047', '', '', 'epworthmethodist55@gmail.com', '', 2014, -88.222, 16.9693, 'Stann Creek', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Gilda Wagner', 'Patricia Usher', NULL, NULL, NULL),
('Escuela Secundaria Tecnica Mexico', 'S30101', 'San Roman Village  Corozal District  Belize', 'Oscar Santana', '423-3140', '', '', 'estm83@estm.edu.bz', '', 1983, -88.5098, 18.3038, 'Corozal', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Escuela Secundaria Tecnica Mexico ACE', 'A30101', 'San Roman Village  Corozal District  Belize', 'Melba Rosalez', '423-3140', '', '', 'mrosalez@estm.edu.bz', '', 1983, -88.5098, 18.3038, 'Corozal', 'Rural', 'Adult and Continuing', 'Government Schools', 'Government', 'Melva Rosalez', '', NULL, NULL, NULL),
('Esperanza Community Preschool', 'K20101', 'Esperanza Village,  Cayo District', 'Wayne Casey', '601-1052', '', '', 'esperanzacommunitypreschool@gmail.com', '', 1991, -89.0458, 17.1778, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Criselda Gladden', 'Wayne Casey (Teacher)', NULL, NULL, NULL),
('Eternal Light Preschool', 'K12101', 'Burrel Boom Village', 'Martha Leal', '600-6440', '', '', '', '', 1985, -88.4034, 17.5688, 'Belize', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', 'Martha Leal', '', NULL, NULL, NULL),
('Ethel Vargas Community Preschool', 'K10002', '18B Pinks Alley, Belize City', 'Barbara Elijio', '615-4052', '', '', 'ethelvargaspreschool@yahoo.com', '', 1942, -88.1853, 17.4963, 'Belize', 'Urban', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Evangelical Holiness Preschool', 'K29301', 'Santa Familia Village', 'Nuria Aguirre', '665-5134', '', '', 'holinesspreschool@gmail.com', '', 2014, 0, 0, 'Cayo', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Elias Moh', 'Maria Cano', NULL, NULL, NULL),
('Evangelical Mennonite Mission Church Preschool', 'K21106', 'Spanish Lookout', 'Shannel Tejeda', '622-4847', '', '', 'kameletejeda@gmail.com', '', 2015, -89.0352, 17.2666, 'Cayo', 'Rural', 'Preschool', 'Mennonite Schools - Spanish Lookout', 'Private', 'Shannel Tejeda', '', NULL, NULL, NULL),
('Evangelical Mennonite Mission Church School', 'P28104', 'Spanish Lookout', 'Dayna Wutke', '615-3547', '', '', 'emmcschoolprincipal@gmail.com', '', 2007, -89.0352, 17.2666, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Shannel Tejeda', '', NULL, NULL, NULL),
('Evangelical Mennonite Mission Church Secondary School', '', 'Spanish Lookout', 'Dayna Wutke', '', '', '', '', '', 2021, 0, 0, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Evershine Preschool', 'K54002', '15 Magoon St, Dangriga', 'Lydia Chuc', '502-3431', '627-4946', '', 'evershinebaptistpreschool@gmail.com', 'http://evershine.edu.bz', 1999, -88.2203, 16.9668, 'Stann Creek', 'Urban', 'Preschool', 'Baptist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Excelsior High School', 'S10005', 'Fabers Road, Belize City', 'Dawn Watters', '227-0044', '', '', 'dwnwatters@yahoo.com', '', 2007, -88.1993, 17.4881, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Fabian Cayetano RC Preschool', 'K64118', 'Bladen Village, Toledo District', 'Hilaria Ramos', '665-2588', '613-2505', '', 'FabianCayetanoRC@gmail.com', '', 2014, -88.6224, 16.4738, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Hilaria Ramos', 'Trisha Lofter', NULL, NULL, NULL),
('Fabian Cayetano RC Primary', 'P61407', 'Bladen Village, Toledo District', 'Hilaria Ramos', '665-2588', '613-2505', '', 'FabianCayetanoRC@gmail.com', '', 2013, -88.6224, 16.4738, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Mrs. Hilaria Ramos', 'Ms. Trishia Lofter', NULL, NULL, NULL),
('Faith Nazarene Primary', 'P25002', '4 George Street, San Ignacio Town', 'Lavern Flowers', '804-3320', '', '', 'faithnazcyo@gmail.com', '', 1993, -89.0718, 17.1593, 'Cayo', 'Urban', 'Primary', 'Nazarene Schools', 'Government Aided', 'Maria Ruiz (Principal)', 'Shelan Humes (Vice Principal)', NULL, NULL, NULL),
('Fel Briceno Academy Pre-primary', 'K44009', 'San Lorenzo  Orange Walk District', '', '', '', '', '', '', 2022, -88.5771, 18.0997, 'Orange Walk', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Fel Briceno Academy Primary', 'P41005', 'San Lorenzo  Orange Walk District', '', '', '', '', '', '', 2022, -88.5771, 18.0997, 'Orange Walk', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL);
INSERT INTO `moe_school_info` (`name`, `code`, `address`, `contact_person`, `telephone`, `telephone_alt1`, `telephone_alt2`, `email`, `website`, `year_opened`, `longitude`, `latitude`, `district`, `locality`, `type`, `ownership`, `sector`, `school_Administrator_1`, `school_Administrator_2`, `admin_comments`, `created_at`, `updated_at`) VALUES
('Fire Burn Government Primary', 'P40104', 'Fireburn Village', 'Rubiceli Varela', '629-6237', '', '', 'fireburngov@gmail.com', '', 2014, -88.3882, 17.9711, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Fire Burn RC Primary School', 'P31499', 'Fire Burn Community', 'Luis Ack', '625-6458', '', '', 'fireburn.rc@gmail.com', '', 2001, -88.4308, 18.3877, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Forest Home Methodist Primary', 'P63401', 'Forest Home Village', 'Deborah Borland', '654-2268', '', '', 'foresthomemeth@gmail.com', '', 2014, -88.8291, 16.1351, 'Toledo', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Deborah Borland', 'Dorita Ranguy', NULL, NULL, NULL),
('Frank\'s Eddy Government Primary', 'P20301', '37 1', 'Brenda Guillen', '601-2323', '', '', 'frankseddygovernmentschool@yahoo.com', '', 1985, -88.6346, 17.2557, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Brenda Guillen', 'Kendra Arnold', NULL, NULL, NULL),
('Friends Boys School', 'P19095', 'Central American Boulevard, Belize City', 'Frank Tench', '227-0449', '', '', 'friendsboysschool@btl.net', '', 1993, -88.1917, 17.491, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Gales Point Child Stimulation Centre', 'K10105', 'Gales Point Manatee Village', 'Shelmadine Samuels', '655-2562', '', '', 'galespointgovbz@gmail.com', '', 2014, -88.3306, 17.1757, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Glenford Palacio', 'Bernadette Gordon', NULL, NULL, NULL),
('Gales Point Government Primary', 'P10101', 'Main Street, Gales Point Village', 'Shermadine Samuels', '655-2562', '', '', 'galespointsgovbz@gmail.com', '', 2014, -88.3307, 17.176, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', 'Lenford Palacio', 'Shermadine Samuels', NULL, NULL, NULL),
('Garden City Preschool', 'K20003', 'Hummingbird Avenue, Belmopan', 'Kevin Hall', '822-3791', '', '', 'gardencity_primaryschool@yahoo.com', '', 2012, -88.7689, 17.2414, 'Cayo', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Kevin Hall', 'Paul Chun', NULL, NULL, NULL),
('Garden City Primary', 'P20003', 'Hummingbird Avenue, Mountain View Area', 'Kevin Hall', '822-3791', '615-0523', '628-0523', 'gardencity_primaryschool@yahoo.com', '', 2008, -88.7689, 17.2414, 'Cayo', 'Urban', 'Primary', 'Government Schools', 'Government', 'Kevin Hall', 'Paul Chun', NULL, NULL, NULL),
('Garden Valley Mennonite School', 'P28203', 'Springfield Community  PO Box 123, Belmopan', 'Ivan martin / Andrew Beiler', '', '', '', '', '', 2014, -88.8152, 17.144, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Ivan Martin', 'Andrew Beiler', NULL, NULL, NULL),
('Georgetown Technical High School', 'S50301', '29 Miles Southern Highway, Stann Creek District', 'Ervin Casimiro', '671-9827', '671-9806', '', 'principal@gttech.edu.bz', '', 2007, -88.4924, 16.6407, 'Stann Creek', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Golden Star Government Preschool', 'K60101', 'Golden Stream Village', 'Doret Gabutt', '615-0764', '', '', 'debbyrodriguez92@gmail.com', '', 2014, -88.7992, 16.351, 'Toledo', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Golden Stream Government Primary', 'P60104', 'Golden Stream Village', 'Doret Garbutt', '621-6702', '', '', 'goldenstreamgovschool@gmail.com', '', 2014, -88.7992, 16.351, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Doret Garbutt', 'Lawrence Usher', NULL, NULL, NULL),
('Grace Instrument Christian Academy', 'S27102', 'Duck Run 3, Spanish Lookout', 'Rachael Adegbami', '610-8678', '', '', 'graceinstrumentacademy@gmail.com', '', 2020, -89.0392, 17.2672, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Grace Primary School', 'P19003', '14 Amara Avenue', 'Dyann Garnett', '227-3430', '227-5657', '', 'graceprimary07@yahoo.com', '', 1950, -88.1918, 17.4943, 'Belize', 'Urban', 'Primary', 'Christian Brethren', 'Government Aided', 'Morna Gillett Sheppard', 'Ruby Perriott', NULL, NULL, NULL),
('Graham Creek Government Primary School', 'P60106', 'Graham Creek Village', 'Jose Cuc', '661-1719', '', '', 'grahamcreekgov@gmail.com', '', 2001, -89.1279, 15.9317, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Arci Cal', '', NULL, NULL, NULL),
('Green Hills Mennonite Primary', 'P28105', 'Green Hills Community', 'Peter Penner', '', '', '', '', '', 2014, -88.9755, 17.0978, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Guadalupe RC Primary', 'P11402', 'Sandhill Village, 17.5 miles Phillip Goldson Highway', 'Esther Nal Requena', '614-9048', '', '', 'guadalupercschool@hotmail.com', '', 2014, -88.3689, 17.6284, 'Belize', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Esther Requena', 'Melanie Torres', NULL, NULL, NULL),
('Guardian Angel Preschool', 'K44108', 'Guinea Grass Village', 'Elver Medina', '323-1028', '', '', '', '', 2014, -88.5974, 17.9668, 'Orange Walk', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Guinea Grass Pentecostal Preschool', 'K44107', 'Guinea Grass Village', 'Noel Lopez', '303-1031', '', '', '', '', 2007, -88.5976, 17.9653, 'Orange Walk', 'Rural', 'Preschool', 'Pentecostal Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Guinea Grass Pentecostal Primary', 'P49403', 'Guinea Grass Village  Orange Walk District', 'Noe Lopez', '303-1031', '660-6536', '', 'noelopz74@gmail.com', '', 1999, -88.5976, 17.9653, 'Orange Walk', 'Rural', 'Primary', 'Guinea Grass Pentecoastal Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Guinea Grass Roman Catholic Primary School', 'P41402', 'Guinea Grass Village', 'Angela Jimenez', '303-1028', '', '', 'guineagrass20@gmail.com', '', 2014, -88.5974, 17.9668, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Gulisi Community Preschool', 'K53001', 'Monument Area, Dangriga Town', 'Karol Ellis', '613-8963', '', '', 'gulisicommunityprimaryschool07@gmail.com', '', 2007, -88.2413, 16.962, 'Stann Creek', 'Urban', 'Preschool', 'Community Schools', 'Government Aided', 'Venancia Flores', 'Marsha Mejia', NULL, NULL, NULL),
('Gulisi Community Primary', 'P50001', 'Monument Site, Dangriga Town', 'Karol Ellis', '613-8963', '', '', 'junall057@gmail.com', '', 2007, -88.2413, 16.962, 'Stann Creek', 'Urban', 'Primary', 'Community Schools', 'Government Aided', 'Venancia Flores', 'Marsha Mejia', NULL, NULL, NULL),
('Gwen Lizarraga Evening Division', 'A10001', '18 Antelope Street P.O. Box 702', 'Lorna McKay', '227-7144', '', '', 'Lornamckay120@gmail.com', '', 0, -88.2002, 17.4945, 'Belize', 'Urban', 'Adult and Continuing', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Gwen Lizarraga High School', 'S10002', '18 Antelope Street  Belize City', 'Louis Mortis', '227-7144', '', '', 'principal.glhs@gmail.com', '', 2014, -88.2002, 17.4945, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Hand in Hand Ministries Preschool', 'K14010', '1 1/2 Mile George Price Highway', 'Geraldine Reneau', '633-3964', '', '', 'geraldinereneau2@gmail.com', 'www.myhandinhand.org', 2007, -88.2115, 17.501, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Nadia Armstrong', '', NULL, NULL, NULL),
('Happy Home Preschool', 'K64001', 'Front Street, Punta Gorda Town', 'Florence Ramclam', '702-2610', '', '', 'pgms@gmail.com', '', 2014, -88.8013, 16.1016, 'Toledo', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', 'Florence Ramclam', 'Ovetta Fuentes', NULL, NULL, NULL),
('Harmony Preschool', 'K12102', 'Bermundian Landing', 'Paulette Martinez', '610-8748', '', '', 'paulettemartinez830@yahoo.com', '', 2001, -88.5391, 17.5563, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Hattieville Government Preschool', 'K10102', '115 Sylvester Blvd., Hattieville Village', 'Gwendolyn Usher', '225-6014', '', '', 'hattievillegovernment@yahoo.com', '', 2014, -88.3935, 17.4486, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Hattieville Government Primary', 'P10402', '115 Sylvestre Blvd, Hattieville Village', 'Gwendolyn Usher', '225-6127', '225-6014', '', 'hattievillegovernment@yahoo.com', '', 2014, -88.3935, 17.4486, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Hattieville SDA Primary', 'P14450', 'Hattieville Village', 'Sharlette Belisle-Jacobs', '630-5823', '', '', 'hattievillesdaschool@gmail.com', 'https://www.facebook.com/hattieville.sda', 1989, -88.3926, 17.4623, 'Belize', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Helping Hands Preschool', 'K14102', 'B68, Section Q, Mahagony Heights', 'Elizabeth Pinelo', '626-0804', '', '', 'Helpinghandspreschool2020@gmail.com', '', 2022, -88.5675, 17.3384, 'Belize', 'Rural', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Hidden Paradise Government Primary', 'P20105', 'Duck Run 3, Spanish Lookout Area', 'Noemi Pott Gonzalez', '613-0189', '', '', 'hiddenparadisegovernment@gmail.com', '', 2003, -89.0343, 17.2613, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Noemi Gonzalez', '', NULL, NULL, NULL),
('Hill Top Primary School', 'P28207', 'Lower Barton Creek', 'Henry Reddicopp', '', '', '', '', '', 2014, -88.9307, 17.1535, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Hills of Promise Primary', 'P24003', 'Corner George Price Blvd & Said Musa Street', 'Thiffany Salas', '670-3766', '', '', 'hillsofpromisesda@yahoo.com', '', 2014, -89.1331, 17.0751, 'Cayo', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Thiffany Salas', 'Delmy Rosales', NULL, NULL, NULL),
('Holland Mennonite Primary School', 'P28206', 'P.O. Box 21 San Ignacio, Cayo District, Belize  Holland Community', 'Abraham Lowen', '', '', '', '', '', 2014, -89.0181, 17.2774, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Abraham Lowen', '', NULL, NULL, NULL),
('Holy Angels Preschool', 'K54101', '12 milesSC Valley Rd, Pomona Village', 'Esan Gutierrez', '502-3202', '', '', 'holyangelspom@gmail.com', '', 2014, -88.3754, 16.9931, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Sadie Asevedo', 'Ercelia Wagner', NULL, NULL, NULL),
('Holy Angels RC Primary', 'P51401', '12 miles SC Valley Road, Pomona', 'Esan Gutierrez', '502-3202', '', '', 'holyangelspom@gmail.com', '', 2014, -88.3754, 16.9931, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Sadie Asevedo', 'Esan Gutierrez', NULL, NULL, NULL),
('Holy Cross Anglican Preschool', 'K14013', 'San Mateo, San Pedro', 'Olivia Tasher', '226-3456', '', '', 'lvtasher@yahoo.com', '', 2011, -87.958, 17.9321, 'Belize', 'Urban', 'Preschool', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Holy Cross Anglican Primary School', 'P12009', 'San Mateo, Ambergris Caye', 'Rodney Griffith', '226-3456', '', '', 'holycrossschool@hcmail.bz', '', 2007, -87.958, 17.9321, 'Belize', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Holy Cross RC Primary', 'P21102', 'Calla Creek Village', 'Aide Herrera', '620-3590', '', '', 'holycrosscallacreek@yahoo.com', '', 2014, -89.1338, 17.1251, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Aide Herrera', 'Marian Noble', NULL, NULL, NULL),
('Holy Family Preschool', 'K54109', 'Hopkins Village', 'Barbara Nunez', '607-6094', '613-9919', '', 'holyfamily518@gmail.com', '', 2014, -88.2838, 16.8587, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Holy Family RC Primary', 'P51303', 'Hopkins Village, SC District', 'Barbara Nunez', '607-6094', '613-9919', '', 'holyfamily518@gmail.com', '', 1997, -88.2838, 16.8587, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Natasha Acosta', 'Hilton Rodriguez', NULL, NULL, NULL),
('Holy Ghost Preschool', 'K54005', 'Commerce Bight Road, Dangriga Town', 'Dora Sabal', '615-7517', '', '', 'holyghostdangriga@gmail.com', '', 2013, -88.2204, 16.9583, 'Stann Creek', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', 'Juliette Williams', 'Ercelia Wagner', NULL, NULL, NULL),
('Holy Ghost RC Primary', 'P51002', 'Rail Way Pier Road, Dangriga', 'Dora Sabal', '615-7517', '', '', 'holyghostdangriga@gmail.com', '', 2014, -88.2204, 16.9583, 'Stann Creek', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Dushinka lopez', 'Ercelia Wagner', NULL, NULL, NULL),
('Holy Redeemer RC Primary', 'P11001', '144 North Front Street    P.O. Box 616    Belize City, Belize', 'Leticia Waight', '227-0959', '', '', 'hrpschool@yahoo.com', '', 2009, -88.1873, 17.4967, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Leticia Waight', 'Marixa Guerra', NULL, NULL, NULL),
('Hope Creek Methodist Preschool', 'K50401', 'Hope Creek Village', 'Patricia Usher', '542-2010', ' 635-6565', '', 'hopecreekmethodistschool@yahoo.com', '', 2014, -88.3135, 17.0027, 'Stann Creek', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', 'Gladys Jackson', '', NULL, NULL, NULL),
('Hope Creek Methodist Primary', 'P53401', 'Hope Creek Methodist School    Hope Creek Village  7 Miles Stann Creek Valley Ro', 'Patricia Usher', '542-2010', '', '', 'hopecreekmethodistschool@yahoo.com', '', 2014, -88.3135, 17.0027, 'Stann Creek', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Gladys Jackson', 'Sandra Zuniga', NULL, NULL, NULL),
('Hope Presbyterian Preschool', 'K24002', 'La Loma Luz Blvd, Santa Elena', 'Ruth Sierra', '605-5131', '', '', '', '', 2005, -89.0601, 17.1724, 'Cayo', 'Urban', 'Preschool', 'Presbyterian Schools', 'Government Aided', 'Ruth Sierra', '', NULL, NULL, NULL),
('Horizon Academy Preschool', 'K17401', '3 miles Phillip Goldson Highway', 'Dian Maheia', '223-2765', '', '', 'principal@horizonacademy.edu.bz', 'https://horizonacademy.edu.bz/', 2009, -88.2291, 17.5174, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Dian Meheia', '', NULL, NULL, NULL),
('Horizon Academy Primary', 'P17401', '3 miles Phillip Goldson Highway', 'Victoria Burgos Peres', '223-2765', '', '', 'principal@horizonacademy.edu.bz', 'https://horizonacademy.edu.bz/', 2009, -88.2291, 17.5174, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Dian Meheia', '', NULL, NULL, NULL),
('Howard Smith Nazarene Preschool', 'K24004', 'Juanito Gongora St., Benque Viejo', 'Ardulfa Velasquez', '803-3202', '', '', 'howardsmithnazarene@yahoo.com', '', 2008, -89.1338, 17.0733, 'Cayo', 'Urban', 'Preschool', 'Nazarene Schools', 'Government Aided', 'Ardulfa Velasquez', 'Mauda Cunil', NULL, NULL, NULL),
('Howard Smith Nazarene Primary', 'P25001', 'Juanito Gongora Street', 'Marconi Cano', '803-3202', '600-3361', '', 'howardsmithnazarene@yahoo.com', '', 1995, -89.1338, 17.0733, 'Cayo', 'Urban', 'Primary', 'Nazarene Schools', 'Government Aided', 'Marconi Cano ( Principal)', '', NULL, NULL, NULL),
('Hummingbird Christian Mennonite High', 'S57101', 'Hummingbird highway  Stann Creek District', 'Jason Kropf', '668-9664', '', '', 'jmk28bz@gmail.com', '', 2015, -88.5382, 17.0486, 'Stann Creek', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Hummingbird Christian Mennonite Primary', 'P58450', '25.5 miles Hummingbird Highway', 'Jason Kelp', '615-7659', '', '', 'jmk28bz@gmail.com', '', 2014, -88.5382, 17.0486, 'Stann Creek', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Jason Kropf', '', NULL, NULL, NULL),
('Hummingbird Elementary Preschool', 'K17009', '24 Newtown Barracks', 'Jamuna Vasquez', '224-5383', '', '', 'hummingbirdes@gmail.com', 'hummingbirdelementarybelize.com', 1983, -88.1882, 17.5091, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Cindy Cain', '', NULL, NULL, NULL),
('Hummingbird Elementary Primary', 'P17009', '24 Newtown Barrack, Belize City', 'Jamuna Vasquez', '224-5383', '', '', 'jamunavasquez@hotmail.com', 'hummingbirdelementarybelize.com', 1983, -88.1882, 17.5091, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Cindy Cain', '', NULL, NULL, NULL),
('Iguana Creek Government Primary', 'P20101', 'Selena Village', 'Melissa Harris/Marion Watson', '622-8142', '', '', 'iguanacreek97@gmail.com', '', 1985, -88.9889, 17.2934, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Immaculate Conception RC Primary', 'P21401', 'Bullet Tree Falls Village', 'Victor Daniel Pott', '844-4060', '', '', 'immaculateconception604@gmail.com', '', 2014, -89.1118, 17.1703, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Victor Daniel Pott', 'Lloyd Martinez', NULL, NULL, NULL),
('Independence High School', 'S50101', 'Savannah Road, Independence Village', 'Omar Longsworth', '523-2220', '', '', 'ind_highschool@yahoo.com', '', 2014, -88.4242, 16.5367, 'Stann Creek', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Independence High School ACE', 'A50101', 'Savannah Road, Independence Village', 'Omar Longsworth', '523-2220', '672-9497', '', 'ind_highschool@yahoo.com', '', 2014, -88.4242, 16.5367, 'Stann Creek', 'Rural', 'Adult and Continuing', 'Government Schools', 'Government', 'Omar Longsworth', '', NULL, NULL, NULL),
('Independence Jr. College', 'J50101', 'Savannah Road  Independence Village  Stann Creek District', 'Marie Young', '523-2566', '', '', 'ind_juniorcollege@yahoo.com', '', 2007, -88.4263, 16.5373, 'Stann Creek', 'Rural', 'Tertiary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Independence Primary', 'P50103', 'Independence Village, SC District', 'Clint Foreman', '523-2506', '', '', 'independenceprimaryschool@gmail.com', '', 1993, -88.415, 16.5348, 'Stann Creek', 'Rural', 'Primary', 'Government Schools', 'Government', 'Clint Coleman', 'Jose Funez', NULL, NULL, NULL),
('Indian Church Government Primary', 'P40101', 'Indian Church Village,  Orange Walk District', 'Ms. Sonia Tun', '663-8668', '', '', 'indianchurchgovsch@gmail.com', '', 2014, -88.6584, 17.7531, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', 'Eutemio Magania', 'Sonia Tun (663-8668)', NULL, NULL, NULL),
('Indian Creek Mennonite Community Primary', 'P48101', 'P.O Box 45  Indian Creek', 'Johan Thiessem', '', '', '', '', '', 2014, -88.6571, 17.7531, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Johan Thiessen', 'Wilhelm Harder', NULL, NULL, NULL),
('Indian Creek RC Primary', 'P61202', 'Indian Creek Village', 'Primotivo Co', '605-3633', '', '', 'indiancreekrc79@gmail.com', '', 2014, -88.8322, 16.3128, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Ms. Miguelina Mendez', '', NULL, NULL, NULL),
('Isabella Harmony Primary', 'P18450', 'PO Box 596 Belize City/ Isabella Bank', 'Justin Goff', '622-6711', '', '', 'isabella.schrock@gmail.com', '', 2014, -88.5382, 17.5794, 'Belize', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', '', '', NULL, NULL, NULL),
('Itz’at STEAM Academy', '', 'Corner Simon Lamb and Freetown Road', 'Christine Coc', '615-7406', '', '', '', '', 2022, -88.1924, 17.5044, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Jalacte RC Primary', 'P61107', 'Jalacte Village', 'Omar Requena', '629-9181', '', '', 'jalacterc@gmail.com', '', 1983, -89.2021, 16.204, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Floriano Chun', '', NULL, NULL, NULL),
('James Garbutt SDA Preschool', 'K14014', '21 Albert Street West', 'Maren Moralez', '207-2769', '', '', 'jamesgarbuttsda@yahoo.com', '', 2010, -88.1886, 17.4893, 'Belize', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', 'Sandra Carr', 'Claudia Baptist', NULL, NULL, NULL),
('James Garbutt SDA Primary', 'P14001', '21 Albert Street West, Belize City', 'Maren Moralez', '207-2769', '', '', 'jamesgarbuttsda@yahoo.com', '', 1954, -88.1886, 17.4893, 'Belize', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Mrs. Sandra Carr', 'Sofia Tosta', NULL, NULL, NULL),
('Jireh Fundamental Education', 'P28301', 'Spanish Lookout', 'Tina Perez / Katie Salazar', '671-0477', '671-1986', '', 'jirehfe@yahoo.com', '', 2001, -89.0026, 17.2144, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Spanish Lookout', 'Private', 'Tina Perez', 'katie Salazar', NULL, NULL, NULL),
('Jireh Fundamental High School', 'S28101', 'Spanish Lookout', 'Tina Perez', '671-0477', '', '', 'jirehfe@yahoo.com', '', 2014, -89.0026, 17.2144, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Jireh Fundamental Preschool', 'K28301', 'Spanish Lookout, Cayo District', 'Tina Perez', '671-0477', '', '', 'jirehfe@yahoo.com', '', 2016, -89.0026, 17.2144, 'Cayo', 'Rural', 'Preschool', 'Mennonite Schools - Spanish Lookout', 'Private', 'Tina Perez', 'Katie Salazar', NULL, NULL, NULL),
('John Paul the Great College', 'J21002', '58 Churchill St., Benque Viejo', 'David N. Ruiz', '665-1934', '', '', 'david_ruiz@hotmail.com', '', 2013, -89.1289, 17.0658, 'Cayo', 'Urban', 'Tertiary', 'Catholic Schools', 'Private', '', '', NULL, NULL, NULL),
('Jordan Mennonite Primary', 'P68460', 'Jordan Village /PO Box 35, Punta Gorda', 'Howard Kropf', '603-1287', '', '', 'belizehomefeeling@gmail.com', '', 2014, -89.0165, 16.1519, 'Toledo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Mervin Amstutz', '', NULL, NULL, NULL),
('Judy Diego Government Preschool', 'K20004', 'Hillview, Las Flores  Belmopan', 'Gaudy Acevedo', '636-8501', '', '', 'yaniratzalam@yahoo.com', '', 2020, -88.7798, 17.2346, 'Cayo', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Gaudy Acevedo', '', NULL, NULL, NULL),
('Julian Cho Technical High School', 'S60101', '14.5 miles PG/San Antonio Rd, PO Box 171', 'Kent Leo Arzu', '613-4159', '', '', 'principaljctech@gmail.com', '', 2000, -88.9358, 16.2284, 'Toledo', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Kiddies\' Campus Preschool', 'K11010', '1736 Coney Drive', 'Adela Pilgrim', '601-8765', '', '', 'adelapilgrim13@gmail.com', '', 2023, 0, 0, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Kiddie’s Care Learning Center', 'K24106', 'Ontario Village', 'Abelina Valdez', '802-2951', '', '', 'ontariochristianschool92@yahoo.com', '', 2014, -88.8899, 17.2266, 'Cayo', 'Rural', 'Preschool', 'Ontario Christian', 'Private', 'Alfa Ramos (Secretary)', 'Gina Jones (Head Teacher)', NULL, NULL, NULL),
('Kiddy Kinder Preschool', 'K31003', '2nd Street South, Corozal Dist', 'Elda Babb', '600-9781', '', '', 'kiddykinderpreschool@gmail.com', '', 2010, -88.3885, 18.3917, 'Corozal', 'Urban', 'Preschool', 'Private Schools', 'Specially Assisted', 'Elda Babb', '', NULL, NULL, NULL),
('Kids First Child Development Center Preschool', 'K51001', '7 Rice St. Dangaria', 'Carla Thompson', '502-0272', '', '', 'kidscdc1st@gmail.com', '', 2000, -88.2238, 16.9726, 'Stann Creek', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Mrs Felicia Caliz', 'Mrs Carla Thompson', NULL, NULL, NULL),
('Kids First Child Development Center Primary', 'P57001', '7 Rice Street  Dangriga', 'Carla Thompson', '502-0272', '', '', 'kidsfirst82@yahoo.com', '', 2000, -88.2238, 16.9726, 'Stann Creek', 'Urban', 'Primary', 'Private Schools', 'Private', 'Carla Thompson', '', NULL, NULL, NULL),
('King\'s College', 'S17101', '31.5 miles Old Northern Highway.   P. O. Box 290 Belize City', 'Pedro Reyes', '232-7501', '', '', 'kingscollegebz@gmail.com', '', 1967, -88.3118, 17.7918, 'Belize', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Kuxlin Ha Gov\'t Preschool', 'K20103', 'Masaan St., Maya Mopan, Belmopan', 'Maria Ramos', '626-1698', '', '', '', '', 2007, -88.7509, 17.2451, 'Cayo', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Sherlene Wilshire', 'Gaudy Tzalam', NULL, NULL, NULL),
('Kuxlin Ha Government Primary', 'P20004', 'Masaan St.  Maya Mopan  Belmopan', 'Shirline Wiltshire', '663-6142', '', '', 'kuxlinha@gmail.com', '', 2007, -88.7509, 17.2451, 'Cayo', 'Urban', 'Primary', 'Government Schools', 'Government', 'Gilberto Chulin Jr. (Vice-Principal)', 'Marlin Muslar (Vice-Principal)', NULL, NULL, NULL),
('La Gracia Government Primary', 'P20404', 'La Gracia Village, Yalbac Area,Cayo', 'Noemi Westby', '660-8563', '660-9696', '', 'lagraciagovtschool@gmail.com', '', 1993, -88.9337, 17.3539, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Noemi Westby', 'Ismael Meighan', NULL, NULL, NULL),
('La Inmaculada Preschool', 'K44003', '3 Church St', 'Lenny Umana', '322-3450', '', '', 'lainmacualadarcschool@yahoo.com', '', 2014, -88.5588, 18.0797, 'Orange Walk', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('La Inmaculada RC Primary', 'P41003', '3 Church St., Orange Walk Town', 'Lenny Umana', '322-3450', '', '', 'lainmacualadarcschool@yahoo.com', '', 2013, -88.5588, 18.0797, 'Orange Walk', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('La Inmaculada RC Primary-CYO', 'P21101', 'Arenal Village', 'Oscar Rene Guerra', '621-8200', '', '', 'lainmaculada1967@gmail.com', '', 1964, -89.1486, 17.023, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Oscar Guerra (Principal)', '', NULL, NULL, NULL),
('La Inmaculada Roman Catholic Preschool', 'K24113', 'Arenal Village, Cayo District', 'Celia Usher - General Manager', '', '', '', '', '', 2022, -89.1486, 17.023, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('La Isla Bonita Elementary Primary', 'P17002', 'Cormorant Street, San Pedro', 'Hector Trejo', '226-3754', '', '', 'teacherhectorteaches2020@gmail.com', 'IslaBonitaElementarySchool.com', 2000, -87.9604, 17.9245, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('La Isla Carinosa Academy Primary', 'P17201', '46 Travellers Palm Street  Caye Caulker', 'Alberto August / Valerie August', '607-4114', '', '', 'principal@licaacademy.com', '', 2015, -88.0262, 17.7398, 'Belize', 'Rural', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Ladyville Evangelical Primary', 'P19401', '10  1/4  Miles Phillip Goldson Highway', 'Elia Lucia Chi', '225-2223', '', '', 'ladyvillevangelical@yahoo.com', '', 1965, -88.3102, 17.556, 'Belize', 'Rural', 'Primary', 'U.E.C.B Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Ladyville SDA Primary', 'P14451', 'Corner Mamie & Perez St., Ladyville', 'Idelfonso Acosta', '205-2409', '613-5886', '', 'ladyvillesdasch.adm@gmail.com', '', 2014, -88.2957, 17.5512, 'Belize', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Gloria Alvarez', '', NULL, NULL, NULL),
('Ladyville Technical High School', 'S10102', '9 3/4 Mls Philip Goldson Highway  Ladyville Village  Belize District', 'Diane Wesby', '225-3499', '', '', 'ladyvilletech@yahoo.com', '', 1999, -88.3061, 17.5494, 'Belize', 'Rural', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Laguna Government Primary', 'P60201', 'Laguna Village', 'Belinda Ann Coleman', '654-2526', '', '', 'lagunagovtsch@gmail.com', '', 2014, -88.9389, 16.1663, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Belinda Ann Coleman', 'Marisela Requena', NULL, NULL, NULL),
('Leta Webb Preschool', 'K24110', 'Valley of Peace, Cayo District', 'Brittney Cal', '667-8824', '', '', 'jcatzim@yahoo.com', '', 2014, -88.8348, 17.3326, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Norma Bonilla', 'Edras Navarro', NULL, NULL, NULL),
('Libertad Methodist Preschool', 'K34104', 'Libertad, Corozal Town', 'Marie Nunez', '403-0204', '', '', '', '', 1975, -88.4557, 18.305, 'Corozal', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Libertad Methodist Primary School', 'P33401', 'Libertad Village', 'Marie Nunez', '667-9232', '', '', 'libertadmethodist@gmail.com', '', 1954, -88.4557, 18.305, 'Corozal', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Libertad RC Primary School', 'P31406', 'Libertad Village', 'Esteban Pasos', '600-5118', '', '', 'libertadrcs@gmail.com', '', 1930, -88.4548, 18.3057, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Libertad SDA Primary School', 'P34402', 'Libertad Village', 'Anjony Canul', '634-4982', '', '', 'adilibskul@gmail.com', '', 2014, -88.4546, 18.3051, 'Corozal', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Liberty Community Preschool', 'K13102', 'Stork Street, Ladyville Village', 'Gerla Godoy', '225-2158', '', '', 'libertyladyville@gmail.com', '', 2006, -88.2914, 17.5529, 'Belize', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Yolanda Wallace', '', NULL, NULL, NULL),
('Light of the Valley Baptist Preschool', 'K54114', '18 _ miles Valley Road, Valley Community', 'Desiree Pascual', '606-8397', '', '', 'schoolleader@lotvbs.edu.bz', '', 2014, -88.4501, 17.0026, 'Stann Creek', 'Rural', 'Preschool', 'Baptist Schools', 'Government Aided', 'Olive Hyde', '', NULL, NULL, NULL),
('Light of the Valley Baptist Primary', 'P59401', '18.5 miles Stann Creek Valley Road', 'Desiree Pascual', '606-8397', '', '', 'schoolleader@lotvbs.edu.bz', '', 2014, -88.4501, 17.0026, 'Stann Creek', 'Rural', 'Primary', 'Baptist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Lighthouse Mennonite Primary School', 'P48402', 'San Antonio Road  Orange Walk', 'Mary LaRochelle', '668-2912', '', '', 'dkm1995@gmail.com', '', 2014, -88.5733, 18.0805, 'Orange Walk', 'Urban', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Jon Stutzman', 'Mary LaRochelle', NULL, NULL, NULL),
('Linda Vista High School', 'S47101', 'Blue Creek, P.O. Box 2', 'Nancy Rempel', '666-7947', '615-0039', '', 'lvsbluecreek@gmail.com', '', 2014, -88.8997, 17.8973, 'Orange Walk', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Linda Vista Preschool', 'K41101', 'Blue Creek', 'Nancy Rampel', '615-0039', '', '', 'lindavista_school@yahoo.com', 'https://lindavistaschool.wixsite.com/belize', 2014, -88.8997, 17.8979, 'Orange Walk', 'Rural', 'Preschool', 'Mennonite Schools - Church Group', 'Private', 'Nancy Rempel', '', NULL, NULL, NULL),
('Linda Vista Primary', 'P47101', 'Linda Vista, PO Box 2, OW Town', 'Nancy Rempel', '323-0204', '670-6590', '', 'lvsbluecreek@gmail.com', 'https://lindavistaschool.wixsite.com/belize', 2014, -88.9007, 17.8979, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Nancy Rempel', '', NULL, NULL, NULL),
('Little Angel\'s Preschool', 'K11013', 'Ambergris St, San Pedro', 'Marina Kay', '627-8868', '', '', 'littleangelsps@hotmail.com', '', 1996, -87.9629, 17.9204, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Marina Kay', '', NULL, NULL, NULL),
('Little Belize Mennonity Community Primary', 'P38401', '-', 'Wilhelm Thiessen', '655-5699', '', '', '', '', 2014, -88.4047, 18.209, 'Corozal', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Little Flower RC Primary', 'P61403', 'Forest Home Village', 'Mateo Palma', '613-3776', '', '', 'littleflowerrc2020@gmail.com', '', 2014, -88.8229, 16.1352, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Julieta Paquiul', '', NULL, NULL, NULL),
('Little Haven Preschool', 'K64112', 'Indian Creek Village', 'Primitivo Co', '626-6830', '', '', 'littlehavenpreschool@gmail.com', '', 2014, -88.8322, 16.3128, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Primitivo Co', 'Gregoria Shol', NULL, NULL, NULL),
('Little Haven SDA Preschool', 'K44007', 'Palmar Boundary Road', 'Sheryl Distan', '668-7846', '', '', '', '', 2009, -88.5706, 18.067, 'Orange Walk', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Little Paradise Preschool', 'K34120', 'Chunox Village, Corozal', 'Cynthia Espinoza', '665-9652', '', '', '', '', 2012, -88.355, 18.2933, 'Corozal', 'Rural', 'Preschool', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Little Star Preschool', 'K11019', 'Avenida Mangle, Caye Caulker', 'Myrna Vanina Sosa', '604-5011', '', '', 'vanina_s@yahoo.com', '', 2007, -88.0264, 17.7418, 'Belize', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Myrna Vanina Sosa', '', NULL, NULL, NULL),
('Living Hope Preparatory School', 'P17007', '7088 Maskall Street, Racoon Street Extension', 'Rev. Natalie Dawn Bowen', '207-0139', '', '', 'livinghopesch@yahoo.com', '', 2003, -88.2023, 17.4929, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Terri Westby', '', NULL, NULL, NULL),
('Living Word Primary', 'P60401', 'Boom Creek Village, PO Box 90, PG', 'Omar Selgado', '632-7820', '', '', 'livingwordgovtschool@gmail.com', '', 2014, -88.9106, 16.0761, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Ruth Coleman', 'Alice Mangar', NULL, NULL, NULL),
('Lloyd Coffin Government Preschool', 'K12001', 'Mahogany St. Lake I Comm. Centre', 'Gwendolyn Jones', '202-4325', '', '', 'lloydcoffinpreschool82@yahoo.com', '', 1982, -88.2012, 17.501, 'Belize', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Gwendolyn Jones', '', NULL, NULL, NULL),
('Los Tambos Government Primary', 'P20102', 'Los Tambos Village', 'Demetria Lilia Reyes', '650-9998', '', '', 'lilsreyes@yahoo.com', '', 2014, -89.0089, 17.3274, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Demetria Lilia Reyes', 'Steven Zuniga', NULL, NULL, NULL),
('Louisiana Government Preschool', 'K40001', 'Corner Flamboyant & Zericote Street', 'Deborah Palacio', '322-2684', '', '', 'selinabaeza@gmail.com', '', 2014, -88.5628, 18.073, 'Orange Walk', 'Urban', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Louisiana Government Primary', 'P40001', 'Corner Zericote & Flamboyant Street', 'Deborah Palacio', '322-2684', '', '', 'palaciodeborah@yahoo.com', '', 1988, -88.5628, 18.073, 'Orange Walk', 'Urban', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Louisville RC Preschool', 'K34115', 'Louisville Village', 'Lorena Coba', '620-7386', '', '', 'louisvillercschool@gmail.com', '', 2004, -88.5096, 18.32, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Lorena Coba', '', NULL, NULL, NULL),
('Louisville RC Primary School', 'P31407', 'Louisville Village', '', '602-0415', '', '', 'louisvillercschool@gmail.com', '', 1954, -88.5096, 18.32, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Lower Barton Creek Primary', 'P28205', 'Lower Barton Creek', 'Henry Thiessen', '', '', '', '', '', 2014, -88.9329, 17.1564, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Henry Reddicopp', '', NULL, NULL, NULL),
('Lucky Strike Government Primary', 'P10201', '30.5 miles Old Northern Highway', 'Janeen St. Benard', '615-5342', '', '', 'luckystrikegovernment@gmail.com', '', 1939, -88.3202, 17.7819, 'Belize', 'Rural', 'Primary', 'Government Schools', 'Government', 'Janeen St. Bernard', '', NULL, NULL, NULL),
('Mabil Ha Government Primary', 'P60205', 'Mabilha Village', 'Arci Cal', '620-7944', '', '', 'mabilhagov20@gmail.com', '', 2014, -89.0881, 16.1019, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Jose Cuc', '', NULL, NULL, NULL),
('Machakilha RC Primary', 'P61109', 'Machakilha Village', 'Desiderius Bol', '6307700', '', '', 'desbol983@gmail.com', '', 2014, -89.1906, 15.9415, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Desiderius Bol', '', NULL, NULL, NULL),
('Mafredi Methodist Primary', 'P63402', 'Mafredi Village', 'Nolberto Rodriguez', '608-0709', '', '', 'mafredimeth@gmail.com', '', 2014, -88.9925, 16.2444, 'Toledo', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Mr. Nolberto Rodriguez', 'Mr. Leon Coc', NULL, NULL, NULL),
('Mafredi Vo-Tech School', 'S67101', '1 mile Manfredi-Blue Creek Road, PO Box 35', 'Daniel Sullivan', '631-6367', '', '', 'mafredivotech@gmail.com', '', 2014, -88.9898, 16.2326, 'Toledo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Mary Hill RC Preschool', 'K34001', 'San Andres Road, Corozal Town', 'Herminia Escalante', '402-2567', '', '', 'maryhillrc@gmail.com', '', 2014, -88.4021, 18.3895, 'Corozal', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Mary Hill RC Primary School', 'P31003', 'San Andres Road,  Town', 'Guillermo Pech', '402-2567', '', '', 'maryhillrc@gmail.com', '', 1977, -88.4021, 18.3895, 'Corozal', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Maud Williams High School', 'S10003', 'Corner Dolphin and Racoon Sts., P.O. Box 1990, Belize City', 'Deborah Domingo', '227-6717', '', '', 'admin@mwhs.edu.bz', '', 2000, -88.1945, 17.4919, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Maya Mopan Government Primary', 'P50301', 'Maya Mopan Village  Stann Creek District', 'Magnolia Pop', '635-8611', '', '', 'mopanprimay@gmail.com', '', 2000, -88.5208, 16.661, 'Stann Creek', 'Rural', 'Primary', 'Government Schools', 'Government', 'Ewart Caballero', '', NULL, NULL, NULL),
('Maya Mopan Preschool', 'K50102', 'Maya Mopan Village  Stann creek District', 'Magnolia Pop', '635-8611', '', '', 'mopanprimay@gmail.com', '', 2005, -88.5208, 16.661, 'Stann Creek', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Medina Bank Government Primary', 'P60203', '36 miles Southern Highway, Medina Bank', 'Augustine Lara', '631-9997', '662-9821', '', 'medinabk.gov@gmail.com', '', 2014, -88.7439, 16.4421, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Howard Reyes', '', NULL, NULL, NULL),
('Mennoniten Gemeinde Indian Creek School', 'P48103', 'Camp 57  Indian Creek', 'Lisa Friesen', '666-6721', '', '', '', '', 2017, -88.7206, 17.7412, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Midway Government Preschool', 'K60102', 'Midway Village, Toledo', '', '625-4090', '', '', 'midwaygovernment@gmail.com', '', 2007, -88.9553, 16.0617, 'Toledo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Vicente Bolon', 'Andreia saki Cal', NULL, NULL, NULL),
('Midway Government Primary', 'P60103', 'Midway Village', 'Primo Tush', '625-4090', '', '', 'cousintush@gmail.com', '', 2014, -88.9553, 16.0617, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Vicente Bolon', '', NULL, NULL, NULL),
('Miracle Angels Preschool', 'K24108', 'Cotton Tree Village, Cayo District', 'Shanelli Martinez', '623-9268', '', '', 'miracleangelsnazarene@gmail.com', '', 2011, -88.7186, 17.2753, 'Cayo', 'Rural', 'Preschool', 'Nazarene Schools', 'Specially Assisted', 'Shanelli Martinez (Head Teacher)', '', NULL, NULL, NULL),
('Missionary Outreach Volunteer Evangelism', 'A47101', 'Old Northern Highway  Miles 3  Carmelita Village', 'Keila E. Valenzula', '', '', '', '', '', 2015, 0, 0, 'Orange Walk', 'Rural', 'Adult and Continuing', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Monrad S. Metzgen Preschool', 'K20106', 'El Progresso Village, Cayo District', '', '628-8055', '', '', '', '', 2021, -88.9533, 17.1004, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Brian Watson', '', NULL, NULL, NULL),
('Mopan Technical High School', 'S20002', 'Said Musa St., New Area, Benque Viejo del Carmen', 'Katie Isabel Jones', '823-2028', '632-0842', '', 'mopantech@mths.edu.bz', '', 2014, -89.1287, 17.076, 'Cayo', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('More Tomorrow Government Primary', 'P20103', 'More Tomorrow Village    Cayo District', 'Dominina Pop', '615-5017', '662-6347', '', '', '', 2014, -88.6952, 17.3487, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Sara Cobb', '', NULL, NULL, NULL),
('Moriah Learning Center', 'K51102', 'Flamboyant Ave.  Independence Village  Stann Creek District', 'Melva McDonald', '610-9649', '', '', 'marthann40@yahoo.com', 'moriah learning center.org', 2014, -88.4173, 16.5328, 'Stann Creek', 'Rural', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Moriah Learning Center Primary', 'P57003', 'Independence Village  Stann Creek District', 'Melva McDonald', '610-9649', '', '', 'marthann40@yahoo.com', '', 2024, -88.4173, 16.5328, 'Stann Creek', 'Rural', 'Primary', 'Private Schools', 'Private', 'Melva McDonald', '', NULL, NULL, NULL),
('Mother of Mercy Montessori Primary School', 'P17011', '2 1/2 Miles Philip Goldson Highway', '', '223-7073', '', '', 'mercymontessoribz@gmail.com', '', 2021, -88.2186, 17.5132, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Private', '', '', NULL, NULL, NULL),
('Mount Carmel Preschool', 'K24006', 'Benque Viejo', 'Melvin Manzanero', '823-3103', '', '', '', '', 2019, -89.1379, 17.074, 'Cayo', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', 'Melvin Manzanero', '', NULL, NULL, NULL),
('Mount Carmel Primary', 'P21002', '10 Diaz St., Benque Viejo del Carmen', 'Melvin Manzanero', '8233103', '', '', 'mountcarmelprimary@yahoo.com', '', 1963, -89.1379, 17.074, 'Cayo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Melvin Manzanero (Principal)', 'Cordelia Cooch (Secretary)', NULL, NULL, NULL),
('Mountain View Mennonite Primary School', 'P28103', 'Bird Walk Community', 'Samuel Cal & David Penner', '', '', '', '', '', 2014, -89.0803, 17.1525, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Samuel Kal', '', NULL, NULL, NULL),
('Muffles College', 'S41001', 'Orange Walk Town, PO Box 64', 'Maria Johnston', '322-2033', '322-0302', '', 'principal@mufflescollege.com', '', 2014, -88.5619, 18.086, 'Orange Walk', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Muffles Jr. College', 'J41001', '1.3 miles San Estevan Rd.', 'Adrian Leiva', '322-1016', '', '', 'mjc@btl.net', '', 2008, -88.5406, 18.0951, 'Orange Walk', 'Urban', 'Tertiary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Muslim Community Primary', 'P19004', 'Corner Central American Blvd & Faber\'s Rood  Belize City  Belize', 'Martha Sacasa', '227-5589', '', '', 'muslimschoolprincipal@gmail.com', '', 1978, -88.2006, 17.4888, 'Belize', 'Urban', 'Primary', 'Sister Clara Muhammed', 'Government Aided', '', '', NULL, NULL, NULL),
('Mustard Seed Preschool', 'K12104', '6 Mamie Rd, Ladyville, Belize', 'Sian August', '620-4496', '', '', 'mustardseedladyville@gmail.com', '', 2000, -88.2959, 17.5503, 'Belize', 'Rural', 'Preschool', 'Baptist Schools', 'Government Aided', 'Cheryl Henry', '', NULL, NULL, NULL),
('Myrtle Banner Preschool', 'K20105', 'Camalote Village, Cayo District', 'Araceli Badillo', '607-7590', '', '', 'myrtlebannerpreschool@gmail.com', '', 2021, -88.8161, 17.2504, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Araceli Badillo', '', NULL, NULL, NULL),
('Na Luum Ca Government Primary School', 'P60101', 'Na Luum Ca Village', 'Abelino Oh', '651-0819', '', '', 'naluumcagovernmentschool@gmail.com', '', 2014, -89.0807, 16.2864, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Primo Tush', '', NULL, NULL, NULL),
('Nazarene Bright Start Preschool', 'K54004', '1 Magoon St, Dangriga Town', 'Bernadina Coc', '608-0797', '', '', 'coc_bernadine@yahoo.com', '', 2014, -88.2206, 16.9682, 'Stann Creek', 'Urban', 'Preschool', 'Nazarene Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Nazarene High School', 'S15001', '31 Princess Margaret Drive, Belize City', 'Elisa Seguro', '203-2248', '613-1342', '', 'nhs@nazarenehighbz.org', '', 1964, -88.1981, 17.5079, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Nazarene Preschool', 'K54103', 'Aubrey Gorbon St. Independence Village', 'Claudette Saragosa', '502-3202', '', '', '', '', 2014, -88.4168, 16.537, 'Stann Creek', 'Rural', 'Preschool', 'Nazarene Schools', 'Government Aided', 'Cordelia Rudon', '', NULL, NULL, NULL),
('Neuland Mennonite Community Primary', 'P48202', '', '', '', '', '', '', '', 2014, -88.2424, 18.0589, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('New Hope High School', 'S47001', 'Rear Stadium Street, Orange Walk Town', 'Eugenia Gongora', '322-3389', '', '', 'nhhs.owbze@gmail.com', '', 2002, -88.5756, 18.0842, 'Orange Walk', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('New Horizon SDA Primary School', 'P14003', 'Escalante Subdivision  San Pedro Town  Belize C.A', 'Elizabeth Sansores', '2062552', '', '', 'newhorizonsanpedro@gmail.com', '', 1997, -87.9788, 17.903, 'Belize', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('New Life Government Primary-CYO', 'P20106', 'Duck Run 1 Village  Spanish Lookout  Cayo District', 'Benedicto Mengibar', '601-7802', '', '', 'newlifegov2004@gmail.com', '', 2004, -89.0196, 17.2195, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Ben Menjibar', '', NULL, NULL, NULL),
('New Life Presbyterian Preschool', 'K44001', 'Holy Trinity & Tate St', 'Ruth Ku', '610-6019', '', '', 'newlifepresbyterianpreschool@gmail.com', 'https://new-life-presbyterian-preschool.business.s', 2014, -88.5627, 18.0928, 'Orange Walk', 'Urban', 'Preschool', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('New Life Presbyterian Primary', 'P49003', 'Holy Trinity & Tate Street', 'Ruth Ku', '610-6019', '', '', 'newlifeschool8@gmail.com', '', 2014, -88.5627, 18.0928, 'Orange Walk', 'Urban', 'Primary', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Nuevo San Juan RC Primary', 'P41403', 'Nuevo San Juan Village', 'Isaias Blanco', '624-3782', '', '', 'elisagrisalamilla@gmail.com', '', 2013, -88.5783, 18.2264, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Isaias Blanco', '', NULL, NULL, NULL),
('Ocean Academy High School', 'S17003', 'Ocean Academy Drive, Caye Caulker', 'Noemi Zaiden', '226-0321', '613-0276', '', 'keme.rubiceli@oaseatide.com', '', 2008, -88.0299, 17.7367, 'Belize', 'Rural', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Ontario Christian Primary', 'P29401', '56 miles George Price Highway', 'Sandra Escalante', '802-2951', '671-0971', '', 'ontariochristianschool92@yahoo.com', '', 1981, -88.8899, 17.2266, 'Cayo', 'Rural', 'Primary', 'Ontario Christian', 'Government Aided', 'Abelinda Valdez', 'Alpha Ramos', NULL, NULL, NULL),
('Orange Walk Technical High School', 'S40001', 'Stadium Street, PO Box 126', 'Julian Polanco', '322-2540', '', '', 'julianpolanco2003@yahoo.com', '', 1983, -88.5726, 18.0856, 'Orange Walk', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Our Lady of Bella Vista RC Preschool', 'K64111', 'Bella Vista Village', 'Vincent Nunez', '665-8156', '', '', 'ladyvista2020@gmail.com', '', 2014, -88.5341, 16.5093, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Saira Gutierrez', 'Alicia Ack', NULL, NULL, NULL),
('Our Lady of Bella Vista RC Primary', 'P61301', 'Bella Vista Village', 'Vincent Nunez', '670-3258', '', '', 'ladyvista2020@gmail.com', '', 1996, -88.5341, 16.5093, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Saira Gutierrez', 'Nehemiah Chub', NULL, NULL, NULL),
('Our Lady of Fatima RC Primary', 'P41201', 'Douglas Village', 'Gilgardo Arcurio', '6316482', '', '', 'e.fabianrodriguez36@gmail.com', '', 2014, -88.5672, 18.0822, 'Orange Walk', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Our Lady of Fatima RC Primary-CYO', 'P21405', 'Roaring Creek Village', 'Marlenia Herrera', '802-0513', '', '', 'rcfatima52@yahoo.com', '', 1952, -88.7923, 17.2596, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Marlenia Herrera', 'Ana Valladarez', NULL, NULL, NULL),
('Our Lady of Guadalupe RC High School', 'S21004', 'George Price Boulevard  P. O. Box 479  City of Belmopan', 'Judith Lopez', '822-2806', '', '', 'ologh@ologh.edu.bz', '', 2003, -88.7651, 17.2675, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Our Lady of Guadalupe RC Preschool', 'K34121', 'Altamira, Corozal', 'Emmanuel J. gonzalez', '605-7561', '', '', 'guadalupercschool@gmail.com', '', 2016, -88.3835, 18.4022, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Our Lady of Guadalupe RC Primary School', 'P31401', 'Altamira, Corozal Town', 'Emmanuel J. Gonzalez', '605-7561', '', '', 'guadalupercschool@gmail.com', '', 1989, -88.3835, 18.4022, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Emmanuel Gonzalez', '', NULL, NULL, NULL),
('Our Lady of Guadalupe RC Primary-CYO', 'P21008', 'East Ring Road', 'Teresita Sosa', '822-0781', '615-9199', '', 'info@ologrcprimary.edu.bz', '', 1998, -88.7637, 17.2493, 'Cayo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Mrs. Margarita Martinez', 'Mrs. Teresita Sosa', NULL, NULL, NULL),
('Our Lady of Lourdes Preschool', 'K12103', 'Maskall Village, Belize District', 'German Ramirez', '636-3359', '', '', 'olls_maskall@yahoo.com', '', 2014, -88.3131, 17.882, 'Belize', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'German Ramirez', '', NULL, NULL, NULL);
INSERT INTO `moe_school_info` (`name`, `code`, `address`, `contact_person`, `telephone`, `telephone_alt1`, `telephone_alt2`, `email`, `website`, `year_opened`, `longitude`, `latitude`, `district`, `locality`, `type`, `ownership`, `sector`, `school_Administrator_1`, `school_Administrator_2`, `admin_comments`, `created_at`, `updated_at`) VALUES
('Our Lady of Lourdes RC Primary', 'P11202', 'Maskall Village', 'German A. Ramirez', '613-3128', '', '', 'olls_maskall@yahoo.com', '', 2014, -88.3131, 17.882, 'Belize', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Our lady of Mount Carmel High School', 'S21002', 'Cors. Jose Marti Street/Mount Carmel Lane  Benque Viejo del Carmen Town', 'Anselma Rosado', '823-2024', '670-2535', '', 'secretary@mchs.edu.bz', '', 1990, -89.1351, 17.0724, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Our Lady of Sorrows R.C Primary', 'P61106', 'Dolores Village', 'Pablo Xi', '661-0015', '', '', 'pablootoxha@gmail.com', '', 1980, -89.2116, 15.9896, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Miguel Pan', 'Hermelinda Tush', NULL, NULL, NULL),
('Our Lady of the Way Primary', 'P11403', '9 1/4 Miles Phillip Goldson Highway  Ladyville, Belize District', 'Denise Neal', '637-8087', '', '', 'olowrc@hotmail.com', '', 1942, -88.298, 17.5485, 'Belize', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Denise Neal', 'Doreth Alvarez', NULL, NULL, NULL),
('Pallotti High School', 'S11001', 'Princess Margaret Drive', 'Rushawn Reynolds Bowman', '224-4886', '', '', 'admin@pallottibz.org', '', 2014, -88.1971, 17.505, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Pancotto Primary', 'P19402', 'Sand Hill Village  Belize District', 'Yolanda Davis', '225-5143', '', '', 'pancottoprimarybz@gmail.com', '', 1954, -88.3686, 17.6308, 'Belize', 'Rural', 'Primary', 'Methodist Protestant Schools', 'Government Aided', 'Yolanda Davis', '', NULL, NULL, NULL),
('Paraiso Government Primary School', 'P30403', 'Paraiso Village', 'Mr. Joel Valdez', '678-2741', '', '', 'paraiso.government.school@gmail.com', '', 1985, -88.3946, 18.4099, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Patchakan RC Preschool', 'K34111', 'Patchakan Village, Corozal Dist', 'Teobalda Ruiz', '403-5029', '', '', '', '', 1984, -88.473, 18.402, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Teobalda Ruiz', '', NULL, NULL, NULL),
('Patchakan RC Primary School', 'P31408', 'Patchakan Village', 'Teobalda Ruiz', '605-0740', '666-7459', '', 'patchakanrc@gmail.com', '', 2013, -88.473, 18.402, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Teobalda Ruiz', 'Erlwin Quan', NULL, NULL, NULL),
('Pete Lizarraga Preschool', 'K42101', 'San Estevan', 'Senaida Blanco', '634-6519', '', '', 'senaida.blanco@yahoo.com', '', 1982, -88.5122, 18.1563, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Senaida Blanco', '', NULL, NULL, NULL),
('Pilgrim Fellowship Mennonite Preschool', 'K14101', 'Hattieville, 16 miles George Price Hwy', 'Louis Ysaguirre', '611-6011', '', '', 'pilgrimfms23@gmail.com', '', 1992, -88.3977, 17.452, 'Belize', 'Rural', 'Preschool', 'Mennonite Schools - Church Group', 'Private', 'Sheradale Neal', 'Lydia Esquiliano', NULL, NULL, NULL),
('Pilgrim Fellowship Mennonite Primary', 'P18460', '16 miles George Price Highway, Hattieville', 'Arlette Mossiah', '611-6011', '', '', 'pilgrimfms23@gmail.com', '', 1974, -88.3977, 17.452, 'Belize', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Louis Ysaguirre', '', NULL, NULL, NULL),
('Pine Hill Mennonite Community', 'P68401', 'Pine Hill Mennonite Community  Toledo District', 'Abraham Penner', '', '', '', '', '', 2006, -88.8311, 16.247, 'Toledo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'David Wall', '', NULL, NULL, NULL),
('Pine Street Community Preschool', 'K12003', '2 Pine Street, Belize City', 'Tyvon Baiza', '668-7990', '', '', 'pinestreetcommunitypreschool@gmail.com', '', 2022, -88.1986, 17.4972, 'Belize', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Gena Palacio Panton', '', NULL, NULL, NULL),
('Placencia Elementary Ltd. Preschool', 'K58201', 'Sunset Point  Placencia Village', 'Lorette Logan', '523-3828', '628-4635', '', 'llogan@peninsulacademy.net', '', 2013, -88.368, 16.5131, 'Stann Creek', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Loretta Logan', 'Loretta Logan', NULL, NULL, NULL),
('Placencia Elementary Ltd. Primary', 'P57201', 'Sunset Point  Placencia Village  SC District', 'Lorette Logan', '523-3828', '628-4635', '', 'llogan@peninsulaacademy.net', '', 2013, -88.368, 16.5131, 'Stann Creek', 'Rural', 'Primary', 'Private Schools', 'Private', 'Loretta Logan', 'Loretta Logan', NULL, NULL, NULL),
('Play World Methodist Preschool', 'K34002', '57-1 st Ave, Corozal Town', 'Steven Peña', '422-2839', '', '', '', '', 1988, -88.3847, 18.3914, 'Corozal', 'Urban', 'Preschool', 'Methodist Schools', 'Government Aided', 'Michael Williams', '', NULL, NULL, NULL),
('Pomona Hope Preschool', 'K51101', 'New Sites, 11 miles, Pomona Valley', 'Melloney Meighan', '631-1870', '', '', 'mellony_meighan@yahoo.com', '', 2014, -88.3496, 16.9937, 'Stann Creek', 'Rural', 'Preschool', 'Baptist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Port Loyola Community Preschool', 'K12004', 'Corner Central American Blvd & Fabers Rd', 'Ersella Griffith', '610-6802', '', '', 'portloyolacps@gmail.com', '', 2014, -88.2, 17.4884, 'Belize', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Elizabeth Pott, Principal', 'Shanda Thompson, Teacher', NULL, NULL, NULL),
('Presbyterian Day Preschool', 'K31004', 'Cristo Rey Village', 'Ditmar Ruiz', '667-8406', '', '', '', '', 2014, -88.4961, 18.3498, 'Corozal', 'Rural', 'Preschool', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Presbyterian Day Primary School', 'P39450', 'Cristo Rey Village /PO Box 274', '', '620-4591', '', '', 'trinbeth76@gmail.com', '', 1976, -88.4961, 18.3498, 'Corozal', 'Rural', 'Primary', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Progressive Early Learning Center', 'K61002', 'Olivia Sentino Street Indianville Area', 'Shanon Sharlett Rodney', '607-2238', '', '', 'progressive@gmail.com', '', 2004, -88.8095, 16.1028, 'Toledo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Shannon Sharlet Rodney', '', NULL, NULL, NULL),
('Progresso RC Primary School', 'P31103', 'Progresso Village', 'Blanca Cowo', '665-3360', '', '', 'progresorc@yahoo.com', '', 2014, -88.4095, 18.236, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Blanca Cowo', 'Carolina Duran', NULL, NULL, NULL),
('Progresso Rising Star Preschool', 'K30104', 'Progresso Village', 'Anirdy Cruz', '624-1392', '', '', 'anirdycruz84@hotmail.com', '', 2014, -88.4109, 18.2287, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Anirdy Cruz', '', NULL, NULL, NULL),
('Progresso Zills SDA Primary', 'P34403', 'Progresso Village, Corozal District', 'Wilbert Tamay', '630-3500', '625-7548', '', 'zillssdaschool@gmail.com', '', 1973, -88.405, 18.2356, 'Corozal', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Julio Contreras', '', NULL, NULL, NULL),
('Providence SDA High School', 'S64101', 'San Antonio Village', 'Carlos Enrique Cima', '613-7585', '', '', 'providencesda21@gmail.com', '', 2025, -89.0163, 16.2486, 'Toledo', 'Rural', 'Secondary', '', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Pueblo Viejo RC Preschool', 'K64116', 'Pueblo Viejo Village,   Toledo District', 'Stephen Sho', '661-5993', '', '', 'sasteve79@yahoo.com', '', 2011, -89.1394, 16.2078, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Mr. Stephen Sho', 'Ms. Dalia C. Sho', NULL, NULL, NULL),
('Punta Gorda Methodist Primary', 'P63001', 'Front Street, Punta Gorda Town', 'Florence Ramclam', '702-2463', '', '', 'pgms2011@yahoo.com', '', 2014, -88.8013, 16.1016, 'Toledo', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Florence Ramclam', 'Doris Lopez', NULL, NULL, NULL),
('QSI International School of Belize', 'P27002', '11/13 Dean Crescent  University Heights  Belmopan', 'Linda Souders', '832-2666', '', '', 'linda-souders@qsi.org', 'www.qsi.org', 2011, -88.7614, 17.2373, 'Cayo', 'Urban', 'Primary', 'Private Schools', 'Private', 'Linda Souders', '', NULL, NULL, NULL),
('Queen Square Anglican Primary', 'P12004', '1 Armadillo Street, Belize City', 'Bernadine Conorquie', '227-2478', '', '', 'queensquare@btl.net', '', 1967, -88.1944, 17.4905, 'Belize', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Bernadine Conorquie', 'Josephine Gabourel', NULL, NULL, NULL),
('Queen Street Baptist Primary School', 'P19005', '# 1 Corner Eve & Queen Street, Belize City', 'Patricia Wade', '227-7626', '632-5687', '', 'qsbs2020@gmail.com', '', 1828, -88.1839, 17.4978, 'Belize', 'Urban', 'Primary', 'Baptist Schools', 'Government Aided', 'Lavern Gillett', 'Karema Roca', NULL, NULL, NULL),
('Ranchito Government Primary School', 'P30404', 'Ranchito Village  Corozal District', 'Yesenia Tun', '638-4645', '', '', 'ranchitogovt@gmail.com', '', 1972, -88.4122, 18.3797, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Ranchito Little Star Preschool', 'K30103', 'Ranchito Village', 'Yesenia Tun', '402-2555', '', '', 'ranchitogovt@gmail.com', '', 2004, -88.4122, 18.3797, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Raymond Sheppard Nazarene Primary School', 'P25401', 'Roaring Creek Village', 'Anna Serano', '802-2947', '615-3768', '', 'raymondsheppardnazarene72@gmail.com', '', 2013, -88.7915, 17.2585, 'Cayo', 'Rural', 'Primary', 'Nazarene Schools', 'Government Aided', 'Anna Arana', 'Brandon Lopez', NULL, NULL, NULL),
('Red Bank Christian Preschool', 'K54111', 'Red Bank Village  Stann Creek', 'Ofelia Chiac', '655-0481', '', '', 'redbankchristianpreschool2019@gmail.com', '', 2004, -88.5601, 16.6196, 'Stann Creek', 'Rural', 'Preschool', 'Assemblies Of God Schools', 'Government Aided', 'Ofelia Chiac', 'Maria Acal', NULL, NULL, NULL),
('Red Bank Christian School', 'P56302', 'Red Bank Village  Stann Creek District    Belize', 'Ofelia Chaic', '655-0481', '', '', 'redbankchristian@gmail.com', '', 1983, -88.5601, 16.6196, 'Stann Creek', 'Rural', 'Primary', 'Assemblies Of God Schools', 'Government Aided', 'ofelia chiac', 'Alberto Coc', NULL, NULL, NULL),
('Red Creek Mennonite High School', 'S28401', 'Esperanza Village  Cayo District', 'Jeffrey Mullet', '671-4460', '', '', 'redcreekprivateschool@gmail.com', '', 2015, -89.0498, 17.1738, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Red Creek Mennonite Preschool', 'K28401', 'Esperanza Village  Cayo District', 'Jonathan Yoder', '671-4660', '', '', 'redcreekprivateschool@gmail.com', '', 2014, -89.0498, 17.1738, 'Cayo', 'Rural', 'Preschool', 'Mennonite Schools - Church Group', 'Private', 'Jonathan Yoder', 'Arlen Lapp', NULL, NULL, NULL),
('Red Creek Mennonite Primary School', 'P28401', 'Esperanza Village  Red Creek   Cayo   Belize', 'Jonathan D Yoder', '671-4460', '', '', 'redcreekprivateschool@gmail.com', '', 2014, -89.0498, 17.1738, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'JD Yoder', '', NULL, NULL, NULL),
('Redeemer Presbyterian Preschool', 'K34109', 'San Narciso Village', 'Leydi  Carias (Patt)', '423-3104', ' 604-6222', '', 'dayana0700@yahoo.com', '', 2006, -88.4427, 18.3489, 'Corozal', 'Rural', 'Preschool', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('RHK\'s Preparatory Preschool', 'K41105', '11 Seagull Street  Trial Farm  Orange walk', 'Rebecca Hernandez', '623-2162', '', '', 'beckynandez51@gmail.com', '', 2022, -88.5667, 18.1019, 'Orange Walk', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Rebecca Hernandez', '', NULL, NULL, NULL),
('Richard Quinn RC Preschool', 'K54113', 'Georgetown Village', 'Desmond Ramirez', '614-5811', '', '', 'richardquinnrcschool@gmail.com', '', 2014, -88.5095, 16.6526, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Adette Garcia', 'Rosalyn Lucas', NULL, NULL, NULL),
('Richard Quinn RC Primary School', 'P51302', 'Georgetown Village', 'Desmond Ramirez', '614-5811', '', '', 'richardquinnrc@gmail.com', '', 1995, -88.5095, 16.6526, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Adette Garcia', '', NULL, NULL, NULL),
('Riverside Primary School', 'P28208', 'Lower Barton Creek', 'Henry Reddicopp', '', '', '', '', '', 2014, -88.9296, 17.1487, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Rosado\'s Preschool', 'K21010', '8th St. San Ignacio', 'Arleni Gomez', '607-8609', '', '', 'arleniegomez@gmail.com', '', 2014, -89.0781, 17.1579, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Yolda Rosado', '', NULL, NULL, NULL),
('Rose Glen Preschool', 'K21107', 'Spanish Lookout', 'Betty Thiessen', '672-0325', '', '', 'roseglenschool@gmail.com', '', 2019, -89.0116, 17.2727, 'Cayo', 'Rural', 'Preschool', 'Mennonite Schools - Spanish Lookout', 'Private', 'Betty Thiessen', '', NULL, NULL, NULL),
('Rose Glen Primary School', 'P28102', 'Route #40  Spanish Lookout  Cayo District', 'Betty Thiessen', '650-0248', '', '', 'roseglenschool@gmail.com', '', 2000, -89.0116, 17.2727, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Spanish Lookout', 'Private', 'Betty Thiessen', '', NULL, NULL, NULL),
('Rose Glen Secondary School', 'S28102', 'Route 40 West  Spanish Lookout  Cayo District', 'Betty Thiessen', '672-0325', '', '', 'roseglenschool@gmail.com', '', 2000, -89.0116, 17.2727, 'Cayo', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Rose Ville Community', 'P58402', 'Rose Ville Community', 'Mr. harder', '', '', '', '', '', 2013, -88.5927, 16.639, 'Stann Creek', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Mr. Harder', '', NULL, NULL, NULL),
('Sacred Heart College', 'S21001', 'Joseph Andrew Drive, PO Box 163', 'Mrs. Rocio Carballo', '824-2102', '', '', 'president@shc.edu.bz', '', 1960, -89.075, 17.1611, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Sacred Heart Jr. College', 'J21001', '3 Joseph Andrews Dr.', 'Fermin Magana', '824-2102', '', '', 'jcinfo@shc.edu.bz', 'www.shc.edu.bz', 2008, -89.0758, 17.1619, 'Cayo', 'Urban', 'Tertiary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Sacred Heart Preschool', 'K64110', 'Crique Sarco Village', 'Victor Teul', '6342719', '', '', 'sacredsarco@gmail.com', '', 2007, -89.1056, 15.984, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Victor Teul', 'Marjorie Akal', NULL, NULL, NULL),
('Sacred Heart RC Primary School', 'P51004', '77 Sisters Of Holy Family Avenue', 'Loretta Lucas', '522-3907', '', '', 'sacredheartschool1898@gmail.com', '', 1989, -88.2227, 16.9726, 'Stann Creek', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Philippa Hulett', 'Venice Lambey', NULL, NULL, NULL),
('Sacred Heart RC Primary School-CYO', 'P21005', 'Church Street, San Ignacio Town', 'Catherine Welch', '824-2183', '620-1028', '', 'sacredheartprimary@yahoo.com', '', 2014, -89.0721, 17.1572, 'Cayo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Catherine Welch', 'Brenda Chiac', NULL, NULL, NULL),
('Sadie Vernon Technical High School', 'S10004', 'Cor. Morning Glory St. and  Amandala Drive', 'Deborah Martin', '222-5683', '615-9477', '', 'sadietech@yahoo.com', '', 1964, -88.2005, 17.5014, 'Belize', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Saint Agnes Anglican Preschool', 'K10103', 'La Democracia Village', 'Stephen Whyte', '621-9528', '', '', 'stagnesanglicanschool@gmail.com', '', 2010, -88.5514, 17.3432, 'Belize', 'Rural', 'Preschool', 'Anglican Schools', 'Government Aided', 'Michelle Turton', 'Dorla Antonio', NULL, NULL, NULL),
('Saint Agnes Anglican Primary School', 'P12304', 'La Democracia/Mahogany Heights', 'Stephen White', '613-5845', '', '', 'stagnesanglicanschool@gmail.com', '', 1969, -88.5509, 17.3434, 'Belize', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Michelle Turton', '', NULL, NULL, NULL),
('Saint Alphonsus Preschool', 'K54106', 'Seine Bight', 'Lorris Moreira', '665-3852', '', '', 'stalphonsusrc51201@gmail.com', '', 2013, -88.3666, 16.5661, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Lorris Moreira', 'Carla Flores', NULL, NULL, NULL),
('Saint Alphonsus RC Primary', 'P51201', 'Seine Bight Village', 'Lorris Moreira', '665-3852', '', '', 'stalphonsusrc51201@gmail.com', '', 2013, -88.3666, 16.5661, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Loris  Moreira', 'Monique Guzman', NULL, NULL, NULL),
('Saint Andrew Anglican Primary School', 'P22001', '72 West Street, San Ignacio', 'Sharee Gutierrez', '824-2991', '601-4942', '', 'st.andrews_anglican@yahoo.com', '', 2014, -89.0719, 17.1626, 'Cayo', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Sharee Gutierrez', '', NULL, NULL, NULL),
('Saint Andrew\'s Anglican Preschool', 'K24007', 'San Ignacio, Cayo District', 'Dr. Jeremy Cayetano - General Manager', '824-2991', '', '', 'elisharee@yahoo.com', '', 2022, -89.0717, 17.1626, 'Cayo', 'Urban', 'Preschool', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Ann\'s Anglican Primary School', 'P22002', 'Independence Park Area, Belmopan', 'Alexander Locario', '802-0445', '638-8786', '', 'st.anna2017@gmail.com', '', 2008, -88.7687, 17.2498, 'Cayo', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Lizette James', 'Chantel Petzold', NULL, NULL, NULL),
('Saint Augustine Preschool', 'K54112', '23 Mile Hummingbird Highway, Middlesex', 'Ernestine Jackson', '602-6054', '', '', 'staugustine231@gmail.com', '', 2014, -88.5121, 17.0271, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Ernestine Jackson', 'Nikki Campbell', NULL, NULL, NULL),
('Saint Augustine RC Primary School', 'P51404', '23 miles Hummingbird Highway', 'Ellorine Jackson', '614-6054', '', '', 'staugustine231@gmail.com', '', 2014, -88.5121, 17.0271, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Ernestine Jackosn', 'Lolrena Cruz', NULL, NULL, NULL),
('Saint Barnabas Anglican Primary School', 'P22402', 'Central Farm', 'Joyce Jones Hall', '650-4668', '601-9647', '804-2726', 'stbarnabasanglican65@gmail.com', '', 1948, -89.0014, 17.1865, 'Cayo', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Joyce Hall', 'Nichelle Logan', NULL, NULL, NULL),
('Saint Benedict RC Primary', 'P61003', 'Toledo Hope/Indianville, Punta Gorda Town', 'Raymond Coleman', '670-6471', '', '', 'school_st.benedict@yahoo.com', '', 2004, -88.8176, 16.1043, 'Toledo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Claret Jacobs', 'Zita Wewe Pate', NULL, NULL, NULL),
('Saint Catherine Academy', 'S11002', '6 Hutson St., Belize City', 'Salome Terry-Tillett', '223-4908', '223-1758', '', 'administration@sca.edu.bz', '', 1883, -88.1827, 17.4965, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Cuthberts Primary School', 'P60105', 'Punta Negra Village', 'Joel Coc', '663-5194', '', '', 'st.cuthbertgs@gmail.com', '', 2014, -88.5445, 16.2729, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Joel Coc', '', NULL, NULL, NULL),
('Saint Edmund Campion Primary School', 'P21407', 'Teakettle Village', 'Gilbert Middleton', '633-6406', '633-0426', '', 'stedmundcampion51@gmail.com', '', 1951, -88.8572, 17.225, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Esmeralda Can', 'Shalina Castana', NULL, NULL, NULL),
('Saint Francis Xavier Preschool', 'K34003', 'Corner 1st Street North and 4 Avenue', 'Eloisa Middleton/Yareni Smith', '402-2521', '', '', '', '', 2011, -88.3858, 18.3909, 'Corozal', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Francis Xavier Primary School', 'P31002', 'Corner 4th Avenue & 1st St. North', 'Mr. Jesus Babb/ Mr. Nestor Yam', '422-2521', '', '', 'st.francisxavierschoolczl@gmail.com', '', 2014, -88.3858, 18.3909, 'Corozal', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Francis Xavier RC Primary School-CYO', 'P21408', 'Esperanza Village,', 'Diana Askari', '824-3155', '601-1116', '', 'stfrancisxaviercayo@gmail.com', '', 1950, -89.036, 17.1806, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Diana Askari (Principal)', '', NULL, NULL, NULL),
('Saint Hilda\'s Anglican Preschool', 'K24114', 'Georgeville Village, Cayo District', 'Dr. Jeremy Cayetano', '', '', '', '', '', 2022, -88.9792, 17.1935, 'Cayo', 'Rural', 'Preschool', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Hilda\'s Anglican Primary School', 'P22401', 'Georgeville Village', 'Jane Martinez', '631-8724', '804-4444', '', 'sthildasanglican@gmail.com', '', 1996, -88.9792, 17.1935, 'Cayo', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Jane Martinez', 'Indira Spain', NULL, NULL, NULL),
('Saint Ignatius High School', 'S21003', '#2A George Price Avenue,  Santa Elena Town,   Cayo District', 'Jeaneane Neal', '824-3294', '', '', 'principal@sihs.edu.bz', '', 2001, -89.0665, 17.1579, 'Cayo', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Ignatius HS Evening Division', 'A21001', '22A George Price Avenue, Santa Elena', 'Jeaneane Vanessa Neal', '824-3294', '', '', 'saintignatiushighschool@yahoo.com', '', 2001, -89.0665, 17.1579, 'Cayo', 'Urban', 'Adult and Continuing', 'Catholic Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Saint Ignatius RC Primary School', 'P11007', '75 Euphrates Avenue, Belize City', 'Lureen Ciego', '227-0058', '', '', 'nashusschool@gmail.com', '', 1925, -88.1923, 17.4918, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Oren Romero', 'Lureen Ciego', NULL, NULL, NULL),
('Saint John the Baptist RC Primary School', 'P61103', 'Conejo Creek Village', 'Anthony Fuentes', '629-2440', '', '', 'anthonyfuentes01@gmail.com', '', 2014, -89.0014, 16.0479, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Daniel Ishim', '', NULL, NULL, NULL),
('Saint John Vianney Primay School', 'P11008', '289 Fabers Road, Belize City', 'Ruth Usher', '227-4844', '', '', 'stjohnvianneyrcschool@gmail.com', '', 1984, -88.1985, 17.4876, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Ruth Usher', 'Felix Sutherland', NULL, NULL, NULL),
('Saint John\'s Anglican Primary School', 'P12006', '1 Amara Avenue', 'Darlene Belgrave', '227-3410', '', '', 'stjohnsanglicanprimary@btl.net', '', 1900, -88.1924, 17.4889, 'Belize', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Darlene Belgrave', 'Claudette Reyes', NULL, NULL, NULL),
('Saint John\'s College', 'S11003', 'Princess Margaret Drive', 'Fidel Pol', '223-3733', '', '', 'headmaster@hs.sjc.edu.bz', '', 1887, -88.1992, 17.5123, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint John\'s Jr. College', 'J11001', 'Princess Margaret Dr.', 'Solangel Alvarado', '223-3732', '', '', 'dean@jc.sjc.edu.bz', 'www.sjc.edu.bz', 2008, -88.1982, 17.5123, 'Belize', 'Urban', 'Tertiary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint John\'s Memorial Anglican Preschool', 'K52101', 'Placencia Village', 'Marita Rowland', '523-3170', '', '', 'st.johnsmemorial@gmail.com', '', 2014, -88.3703, 16.5212, 'Stann Creek', 'Rural', 'Preschool', 'Anglican Schools', 'Government Aided', 'Stephen Whyte', 'Marita Rowland', NULL, NULL, NULL),
('Saint John\'s Memorial Anglican Primary School', 'P52201', 'Placencia Village', 'Marita Rowland', '523-3170', '610-6502', '', 'st.johnsmemorial@gmail.com', '', 2014, -88.3703, 16.5212, 'Stann Creek', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Stephen Whyte', 'Marita Rowland', NULL, NULL, NULL),
('Saint Joseph Anglican Preschool', 'K64002', '30 George Price Street  Punta Gorda Town  Toledo District', 'Emely Ramirez', '631-6330', '', '', 'ramirez.emily19@yahoo.com', '', 2014, -88.803, 16.1003, 'Toledo', 'Urban', 'Preschool', 'Anglican Schools', 'Government Aided', 'Emily Ramirez', 'Cliffara Cacho', NULL, NULL, NULL),
('Saint Joseph Preschool-Succotz', 'K24103', 'San Jose Succotz Village', 'Angelita Mai', '', '', '', 'yureida_amarely@yahoo.com', '', 2016, -89.127, 17.084, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Sonia Valdez (Head Teacher)', '', NULL, NULL, NULL),
('Saint Joseph RC - Cotton Tree', 'P21403', 'Cotton Tree Village, Cayo District', 'Joycelyn Coleman', '627-8928', '630-1428', '802-0252', 'stjosephrc.school@gmail.com', '', 2013, -88.7111, 17.2762, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Joycelyn Coleman', 'Carolina Martinez', NULL, NULL, NULL),
('Saint Joseph RC Primary', 'P11011', '3 St. Joseph & Simon Lamb Streets', 'Claudia Avilez', '223-1772', '', '', 'stjosephrcschool@yahoo.com', '', 2014, -88.192, 17.5041, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Joseph RC Primary School', 'P61102', 'Barranco Village', 'Loma Rodriguez', '608-9165', '', '', 'lomarodriguez@yahoo.com', '', 1943, -88.9185, 15.9993, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Loma Rodriguez', '', NULL, NULL, NULL),
('Saint Joseph RC-Duck Run 2', 'P21103', 'Duck Run 2, Spanish Lookout', 'David Cabb Jr.', '620-8869', '', '', 'stjosephdr2@yahoo.com', '', 1984, -89.0237, 17.2421, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'David Cabb Jr.', '', NULL, NULL, NULL),
('Saint Jude RC Preschool', 'K54116', 'Maya Center', 'Sadie Coleman', '635-6561', '', '', 'st.judercprimary@gmail.com', '', 2012, -88.3815, 16.7983, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Liberato Saqui', 'Victoria Bolon', NULL, NULL, NULL),
('Saint Jude RC Primary School', 'P51403', 'Maya Center Village  15 Miles, southern Highway  Stann Creek', 'Sadie Coleman', '635-6561', '', '', 'stjude.mayacenter@gmail.com', '', 2014, -88.3815, 16.7983, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Liberato Saqui', 'Edwardo Pop', NULL, NULL, NULL),
('Saint Jude RC Primary School-CYO', 'P21402', 'Camalote Village', 'Shevon Ramirez', '614-9707', '', '', 'st.juderc.school@gmail.com', '', 1992, -88.8249, 17.2436, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Shevon Ramirez', 'Salamarie Longsworth', NULL, NULL, NULL),
('Saint Luke Methodist Primary', 'P13004', 'Mahogany Street, Belize City', 'Jacqueline Linch', '222-4301', '', '', 'stlukebz@yahoo.com', '', 2014, -88.2001, 17.501, 'Belize', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Mrs. Jacqueline Lynch', '', NULL, NULL, NULL),
('Saint Margaret Mary RC Preschool', 'K24111', 'St. Margaret Village, Miles 32 Hummingbird Highway', 'Patricia Perez', '622-3692', '', '', 'stmargaretmaryrcschool@gmail.com', '', 2015, -88.6125, 17.0898, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Patricia Perez', 'Yolanda Salam', NULL, NULL, NULL),
('Saint Margaret Mary RC Primary School', 'P21406', 'St. Margaret Village, Mile 32 Hummingbird Highway, Cayo Dist', 'Mrs. Patricia Perez', '636-6641', '', '', 'stmargaretmaryrcschool@gmail.com', '', 1991, -88.6125, 17.0898, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Patricia Perez', 'Marcos Ad', NULL, NULL, NULL),
('Saint Margaret\'s Christian Day Primary', 'P28402', 'St. Margaret Village,  Cayo District', 'Victor Barrera', '635-5249', '', '', 'septemberof2012@gmail.com', '', 2021, -88.6117, 17.089, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Laban Kropf', 'Benjamin Schrock', NULL, NULL, NULL),
('Saint Mark\'s RC Primary School', 'P61110', 'Otoxha Village', 'Olario Ical', '', '', '', 'stmarks1960@gmail.com', '', 2014, -89.1804, 16.0224, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Martin de Porres Primary School', 'P11012', 'Partridge Street, Belize City', 'Dawn Wade', '675-4457', '', '', 'st.martindeporresschool@gmail.com', '', 1966, -88.201, 17.4993, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Anne Palacio', 'Teresita Tillett', NULL, NULL, NULL),
('Saint Martin De Porres RC Primary School-CYO', 'P21409', 'Blackman Eddy Village', 'Sandra Cocom', '676-9585', '', '', 'stmartindeporrc@yahoo.com', '', 2014, -88.9126, 17.2251, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Bartolo Tuyub', 'Sandra Cocom', NULL, NULL, NULL),
('Saint Martin\'s Government Primary School', 'P20402', 'Cemetery Road, Salvapan  City of Belmopan', 'Mrs. Margaret Enriquez', '822-1017', '', '', 'stmartinsgov@btl.net', '', 1985, -88.7587, 17.2514, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Margaret Enriquez', 'Pedro Cano', NULL, NULL, NULL),
('Saint Martins Preschool', 'K14001', 'Corner Oleander St & Rose Lane', 'Dawn Wade', '675-4457', '', '', 'st.martindeporresschool@gmail.com', '', 2014, -88.2015, 17.4998, 'Belize', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', 'Coretta Hernandez', '', NULL, NULL, NULL),
('Saint Mary\'s Anglican Primary School', 'P12008', '1 Angel Lane, Belize City', 'Rae Elizabeth Garay', '207-3352', '', '', 'stmarys329@gmail.com', '', 1994, -88.1843, 17.4956, 'Belize', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Rae Garay (Principal)', 'Carol Flowers (VP)', NULL, NULL, NULL),
('Saint Matthew\'s Anglican Preschool', 'K54117', 'Pomona  Stann Creek District', 'Anna Mae Ferguson', '502-3589', '', '', 'stmatthew.anglican3589@gmail.com', '', 2017, -88.3668, 16.9956, 'Stann Creek', 'Rural', 'Preschool', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Matthew\'s Anglican Primary School', 'P52402', 'Pomona Village', 'Anna Mae Ferguson', '502-3589', '', '', 'stmatthew.anglican3589@gmail.com', '', 2014, -88.3668, 16.9956, 'Stann Creek', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Annamay Ferguson', 'Alexander Gonzales', NULL, NULL, NULL),
('Saint Matthew\'s Government Preschool', 'K20102', 'St. Matthews Village', 'Delfina Escobar', '610-9234', '605-7889', '636-2292', 'smgovtschool@yahoo.com', '', 2014, -88.6461, 17.2766, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Shakeyra Berry', 'Delfina Escobar', NULL, NULL, NULL),
('Saint Matthew\'s Government Primary School', 'P20403', '38 miles George Price Highway', 'Shakeyra Berry', '610-9234', '636-2292', '', 'smgovtschool@yahoo.com', '', 2014, -88.6461, 17.2766, 'Cayo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Michelle  Murray', 'Shakeyra Berrry', NULL, NULL, NULL),
('Saint Michael RC Preschool', 'K44103', 'San Felipe Village', 'Marisol Tun', '661-3570', '', '', 'tun_marisol21@hotmail.com', '', 2005, -88.773, 17.8729, 'Orange Walk', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Michael RC Primary', 'P21404', 'Monja Blanca St.,   Las Flores  Belmopan', 'Joan Sanchez', '662-4369', '629-2540', '', 'stmichaelrc85@gmail.com', '', 1985, -88.7794, 17.2346, 'Cayo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Joan Sanchez', 'Maria Elsa Reyes Cruz', NULL, NULL, NULL),
('Saint Oscar Romero Preschool', 'K24112', 'Valley of Peace Village  PO Box #190, Belmopan', 'Johnny Valencia', '670-2799', '', '', 'monsignorromerorc@gmail.com', '', 2017, -88.8348, 17.3364, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Jhony Valencia', 'Janeth Dwenos', NULL, NULL, NULL),
('Saint Oscar Romero RC Primary School', 'P21106', 'Valley of Peace Village', 'Judith Melgar', '665-7701', '809-2009', '', 'monsignorromerorc@gmail.com', '', 1982, -88.8348, 17.3364, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Mr. Johnny H. Valencia', 'Miss Judith Melgar', NULL, NULL, NULL),
('Saint Paul\'s Anglican Primary School', 'P32001', 'Corner 4th Avenue & 5th St. South', 'Nancy Z Aguilar', '610-2194', '', '', 'stpaulsanglicanschool@gmail.com', '', 2015, -88.3889, 18.3888, 'Corozal', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Paul\'s RC Primary School', 'P61408', 'San Pablo Village, Toledo District', 'Pablo Acal', '674-5857', '', '', 'stpaulrcsp@gmail.com', '', 2014, -88.5799, 16.6118, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Juan Sho', 'Cristino Acal', NULL, NULL, NULL),
('Saint Peter Claver Preschool', 'K64003', 'George Price Street,Punta Gorda Town', 'Telesforo Paquiul', '702-2027', '', '', 'peterclaverschool@yahoo.com', '', 2014, -88.806, 16.0978, 'Toledo', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', 'Telesforo Paquiul', 'Graciela Ticas', NULL, NULL, NULL),
('Saint Peter Claver Primary School', 'P61002', '60 Main Street, Punta Gorda Town', 'Sharon Lucas', '702-2027', '', '', 'peterclaverschool@yahoo.com', '', 1862, -88.8057, 16.0976, 'Toledo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Telesforo Paquiul', 'Cindy Martinez', NULL, NULL, NULL),
('Saint Peter\'s Anglican Preschool', 'K42001', '9 St. Peter\'s Street  Orange Walk Town  Orange Walk District, Belize', 'Rossana Briceno', '322-3083', '', '', 'stpeteranglicanschool@gmail.com', '', 2014, -88.562, 18.0821, 'Orange Walk', 'Urban', 'Preschool', 'Anglican Schools', 'Government Aided', 'Mrs. Francelia Cantun', '', NULL, NULL, NULL),
('Saint Peter\'s Anglican Primary School', 'P42001', '9 St. Peter\'s Street, OW Town', 'Rossana Brieno', '322-2160', '', '', 'stpeteranglicanschool@gmail.com', '', 2014, -88.562, 18.0821, 'Orange Walk', 'Urban', 'Primary', 'Anglican Schools', 'Government Aided', 'Rossana Briceno', 'Francelia Cantun', NULL, NULL, NULL),
('Saint Stephen\'s Anglican Preschool', 'K64120', 'Monkey River Village', 'Kasia Gordon', '662-1117', '636-0436', '', 'ststephensanglican8@gmail.com', '', 2014, -88.4855, 16.3623, 'Toledo', 'Rural', 'Preschool', 'Anglican Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Saint Stephen\'s Anglican Primary School', 'P62102', 'Monkey River Village', 'Kasia Gordon', '662-1117', '636-0436', '', 'ststephensanglican8@gmail.com', '', 2014, -88.4855, 16.3623, 'Toledo', 'Rural', 'Primary', 'Anglican Schools', 'Government Aided', 'Kasia Gordon', 'Keely Flowers', NULL, NULL, NULL),
('Saint Therese RC Primary School', 'P11404', 'Burrell Boom Village', 'Marika Baizer', '615-0818', '', '', 'st.thereseromancatholic@gmail.com', '', 2006, -88.4015, 17.5688, 'Belize', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Evadney Young', 'Marika Baizar', NULL, NULL, NULL),
('Saint Vincent Pallotti RC  Primary School', 'P21411', 'Unitedville Village  Cayo District', 'Luis Oliva', '671-4315', '670-4543', '', 'stvincent.pallotti@yahoo.com', '', 2014, -88.9425, 17.2093, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Luis Oliva (Principal)', 'Yesenia Altamirano', NULL, NULL, NULL),
('Saint Vincent Pallotti Roman Catholic Preschool', 'K24115', 'United Ville, Cayo District', 'Celia Usher - General Manager', '', '', '', '', '', 2022, -88.9428, 17.2089, 'Cayo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Antonio Christian Preschool', 'K64107', 'San Antiono Village', 'Mr. Louis Chub', '636-6902', '', '', 'louischub@yahoo.com', '', 2014, -89.0259, 16.2438, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Mr. Louis Chub', 'Mrs. Eruperantia Cus', NULL, NULL, NULL),
('San Antonio Community Preschool', 'K22102', 'San Antonio Village', 'Nancy Jimenez', '634-1001', '', '', 'nancyjimenezr80@gmail.com', 'sanantoniocommunitypreschool2019@yahoo.com', 2008, -89.0238, 17.0794, 'Cayo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Adelaida Coc', 'Nancy Jimenez', NULL, NULL, NULL),
('San Antonio Government Preschool', 'K30107', 'San Antonio Village', 'Nicasio Gonzalez', '604-6277', '', '', '', '', 2008, -88.3995, 18.4024, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('San Antonio Government Primary School', 'P30405', 'San Antonio Village', 'Nicasio Gonzalez', '604-6277', '', '', 'sanantonio.gov.school@gmail.com', '', 2014, -88.3995, 18.4024, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', 'Nicasio Gonzalez', '', NULL, NULL, NULL),
('San Antonio RC Primary School', 'P41202', 'San Antonio Rio Hondo', 'Anita Colindres', '660-4411', '6343651', '', 'sanantonioriohondorc20@gmail.com', '', 1935, -88.6757, 18.1315, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Antonio RC Primary School-CYO', 'P21202', 'San Antonio Village', 'Ismael G. Mai', '650-6846', '', '', 'sanantoniorc16@gmail.com', '', 1950, -89.0213, 17.0789, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Ismael Mai (Principal)', 'Clifford Coc (Teacher)', NULL, NULL, NULL),
('San Antonio United Pentecostal Primary School', 'P29201', 'San Antonio Village', 'Arcelito Mai', '661-8106', '', '', 'unitedpentecostalschool@yahoo.com', 'www.ups.edu.bz', 1992, -89.0249, 17.0814, 'Cayo', 'Rural', 'Primary', 'United Pentecostal Schools', 'Government Aided', 'Arcelito Mai (Principal)', 'Carlos Cisneros (VPrincipal)', NULL, NULL, NULL),
('San Benito Poite Preschool', 'K64109', 'San Benito Polite Village', 'Domingo Teck', '661-6817', '', '', 'dmng_teck@yahoo.com', '', 2014, -89.1931, 16.1128, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Domingo Teck', 'Annita Teck', NULL, NULL, NULL),
('San Benito Poite RC Primary', 'P61111', 'San Benito Poite Village', 'Manuel Canti', '635-2656', '', '', 'sanbenitopoitercs@gmail.com', '', 1973, -89.1931, 16.1128, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Domingo Teck', '', NULL, NULL, NULL),
('San Carlos Government Primary', 'P40105', 'San Carlos Village', 'Romelio Can', '669-0487', '', '', 'sancarlosgovt@gmail.com', '', 1992, -88.6546, 17.7182, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('San Estevan RC Primary', 'P41404', 'San Estevan Village', 'Leticia Perez', '323-4095', '', '', 'sanestevanrcs@gmail.com', '', 2014, -88.5112, 18.1499, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Leticia Perez', 'Jorge Gutierrez', NULL, NULL, NULL),
('San Felipe Government Primary', 'P60202', 'San Felipe Village', 'Everaldo Garcia', '632-2343', '', '', 'sanfelipeschool@gmail.com', '', 2014, -88.9085, 16.1322, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Everaldo Garcia', 'Caida Nunez', NULL, NULL, NULL),
('San Francisco de Jeronimo Primary', 'P61203', 'Pueblo Viejo Village  Toledo District  Belize Central America', 'Stephen Anthony Sho', '661-5993', '', '', 'sanfranciscodjrcs@gmail.com', '', 1952, -89.1394, 16.2078, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Stephen Anthony Sho', '', NULL, NULL, NULL),
('San Francisco Preschool', 'K44006', 'Price Avenue, Orange Walk Town', 'Teodora Senaida Toledano', '302-2374', '', '', '', '', 2014, -88.5668, 18.0822, 'Orange Walk', 'Urban', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Francisco RC Primary', 'P41004', '8 Price Avenue  Orange Walk Town', 'Mrs. Teodora Senaida Toledano', '302-2374', '', '', 'sanfranrc@hotmail.com', '', 1979, -88.5668, 18.0822, 'Orange Walk', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Ignacio Preschool', 'K21008', '9 West St., San Ignacio', 'Lisa Usher', '600-6358', '', '', 'sanignaciopreschool@gmail.com', '', 1988, -89.0709, 17.1601, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Lisa Usher (Principal)', '', NULL, NULL, NULL),
('San Isidro Government Preschool', 'K64119', 'San Isidro Village', 'Jose Funez', '628-8400', '', '', 'sanisidroprimary@gmail.com', '', 2012, -88.544, 16.508, 'Toledo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Anselma Wollery', 'Tanisha Torres', NULL, NULL, NULL),
('San Isidro Government Primary', 'P60109', 'San Isidro Village', 'Jose Funez', '628-8400', '', '', 'sanisidroprimary@gmail.com', '', 2012, -88.544, 16.508, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Mrs. Anselma Woolery', 'Mr. Abel Pop', NULL, NULL, NULL),
('San Joaquin Preschool', 'K34106', 'San Joaquin Village', 'Humberto Juarez', '423-0057', '', '', '', '', 1954, -88.4427, 18.3488, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Joaquin RC Primary School', 'P31409', 'San Joaquin Village, Ml. 79 Phillip Goldson Highway', 'Dianira Escalante Moh', '423-0057', '621-0085', '', 'sanjaoquinrcs@gmail.com', '', 2014, -88.4427, 18.3488, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Jose Government Preschool', 'K40104', 'San Jose Village  Orange Walk', 'Omar Cabrera', '614-9291', '', '', 'sanjosegov@gmail.com', '', 2016, -88.5692, 18.1969, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Omar Cabrera', 'Bertha Cantun', NULL, NULL, NULL),
('San Jose Government Primary', 'P40403', 'San Jose Village', 'Omar Cabrera', '637-9290', '614-9291', '', 'sanjosegov@gmail.com', '--', 2014, -88.5692, 18.1969, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('San Jose Nuevo Palmar RC Preschool', 'K44102', 'San Jose Nueovo Palmar', 'Rosita Desideria Canul', '322-0192', '', '', '', '', 2014, -88.5668, 18.0605, 'Orange Walk', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Jose Nuevo Palmar RC Primary', 'P41405', 'San Jose Nuevo, Palmar', 'Carmen Vioney  Guerra', '322-0192', '', '', 'vioneyguerra@gmail.com', '', 2014, -88.5668, 18.0605, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Carmen Vioney Guerra', 'Laura Cantun', NULL, NULL, NULL),
('San Jose RC Preschool', 'K64103', 'San Jose Village', 'Midonio Cal', '650-7921', '', '', 'cal.madz@yahoo.com', '', 2014, -89.0949, 16.2658, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Midonio Cal', 'Fausta Cho', NULL, NULL, NULL),
('San Jose RC Primary', 'P61112', 'San Jose Village', 'Midonio Cal', '650-7921', '', '', 'sanjosercschool@gmail.com', '', 1954, -89.0949, 16.2658, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Midonio Cal', 'Richard Peck', NULL, NULL, NULL),
('San Jose Succotz RC Primary', 'P21410', 'San Jose Succotz Village  San Jose Succotz  Cayo District  Belize, C.A.', 'Jenri Castanaza', '626-5167', '', '', 'mayololu@yahoo.com', '', 2001, -89.127, 17.084, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Teodora Teul (Principal)', 'Jorge Ayala (V- Principal)', NULL, NULL, NULL),
('San Juan Bautista ACE', 'A47001', '136 San Andres Street, Orange Walk Town', 'Manuel Bautista', '635-3150', '', '', 'sjbhs1621@yahoo.com', '', 0, -88.5674, 18.0869, 'Orange Walk', 'Urban', 'Adult and Continuing', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('San Juan Bosco Preschool', 'K51301', 'Suan Juan Bosco Village', 'Victor Juarez', '614-4290', '', '', 'sjboscorc@gmail.com', '', 2014, -88.5226, 16.5691, 'Stann Creek', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Terri Westby Langford', 'Jane Palacio', NULL, NULL, NULL),
('San Juan Bosco Primary School', 'P51301', 'Cow Pen/San Juan Village', 'Victor Juarez', '614-4290', '', '', 'sjboscorc@gmail.com', '', 2014, -88.5226, 16.5691, 'Stann Creek', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Terri Wesby Langford', 'Zabdiel Martinez', NULL, NULL, NULL),
('San Lazaro Methodist Primary', 'P49401', 'San Lazaro Village', 'Heidi Mohuel Heredia', '631-3267', '', '', 'richiewicab39@gmail.com', '', 2014, -88.6604, 18.0381, 'Orange Walk', 'Rural', 'Primary', 'Methodist Protestant Schools', 'Government Aided', 'Elsie Cordova', 'Porfirio Mai', NULL, NULL, NULL),
('San Lazaro RC Primary', 'P41406', 'San Lazaro Village', 'Dalia Gonzalez', '650-4693', '', '', 'dalmargonzalez@yahoo.com', '', 2014, -88.6616, 18.0389, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Lucas RC Primary', 'P61119', 'San Lucas Village  Toledo District', 'Berrisford Cal', '613-0040', '', '', 'sanlucasrcschool@gmail.com', '', 1996, -89.0989, 16.079, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Nestor Assi', '', NULL, NULL, NULL),
('San Luis RC Primary', 'P41407', 'San Luis Village', 'Sergio Chi', '671-8700', '', '', 'chisergio00@gmail.com', '', 2014, -88.6034, 18.1956, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Sergio Chi', 'Marianela Uk', NULL, NULL, NULL),
('San Luis Rey RC Primary', 'P61404', 'San Antonio Village', 'Louis Chun', '636-6902', '', '', 'louischub@yahoo.com', '', 1949, -89.0259, 16.2438, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Mr.Louis Chub', 'Zita Arzu', NULL, NULL, NULL),
('San Marcos RC Primary', 'P61113', 'Toledo', 'Estevan Ico', '606-1768', '', '', 'icoestevan@gmail.com', '', 2014, -88.9039, 16.2158, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Estevan Ico', 'Licela Cho', NULL, NULL, NULL),
('San Marcos RC Primary-CYO', 'P21107', 'San Marcos, Spanish Lookout', 'Immanuel Cabb', '669-6848', '', '', 'sanmarcoscyo@gmail.com', '', 2000, -88.9795, 17.2644, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Adan Barrera (Principal)', 'Diana Chinchilla', NULL, NULL, NULL),
('San Miguel Preschool', 'K64106', 'San Miguel Village', 'Leonardo Cal', '6154937', '', '', 'sanmiguelrcschool20@gmail.com', '', 2014, -88.9338, 16.2939, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Leonard Cal', 'Bernadita Kus', NULL, NULL, NULL),
('San Miguel RC Primary', 'P61405', 'San Miguel Village  Toledo', 'Leonardo Cal', '615-4937', '', '', 'sanmiguelrcschool20@gmail.com', '', 2014, -88.9338, 16.2939, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Leonard Cal', '', NULL, NULL, NULL),
('San Narciso RC Preschool', 'K34112', 'San Narciso Village', 'Leticia Moralez (Ag. Princpal)', '403-3810', '', '', 'san.narciso.rc@gmail.com', '', 2013, -88.5246, 18.3016, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Narciso RC Primary', 'P31410', 'San Narciso Village', 'Gregorio Moralez', '403-3810', '622-8748', '', 'san.narciso.rc@gmail.com', '', 1954, -88.5246, 18.3016, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Leticia Moralez', '', NULL, NULL, NULL),
('San Pablo Government Primary', 'P40406', 'San Pablo Village', 'Jose Moralez', '634-4853', '', '', 'jdmlz71@yahoo.com', '', 1995, -88.5662, 18.2129, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', 'Jose Moralez', '', NULL, NULL, NULL),
('San Pablo RC Primary', 'P41408', 'San Pablo Village', 'Flor Blanco', '651-2607', '', '', 'blancoflor47@gmail.com', '', 2014, -88.5672, 18.2064, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Flor Blanco', 'Melanie Stevenson', NULL, NULL, NULL),
('San Pedro Columbia RC Preschool', 'K64104', 'San Pedro Columbia', 'Daniel Palma', '631-7909', '', '', 'sanpedrocolumbiarc@gmail.com', '', 2014, -88.9575, 16.2715, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Floriano Chun', 'Paula Requena', NULL, NULL, NULL),
('San Pedro Columbia RC Primary', 'P61406', 'San Pedro Columbia Village', 'Daniel Palma', '611-8435', '', '', 'sanpedrocolumbiarc@gmail.com', '', 2014, -88.9575, 16.2715, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Floriano Chun', 'Daniel Palma', NULL, NULL, NULL),
('San Pedro Evening Division', 'A10002', 'P. O Box 23  Lagoon Street  San Pedro Town', 'Paul Kelly', '226-2045', '', '', 'pkelly110_rk@hotmail.com', '', 2014, -87.9594, 17.9247, 'Belize', 'Urban', 'Adult and Continuing', 'Community Schools', 'Specially Assisted', '', '', NULL, NULL, NULL),
('San Pedro Government Preschool', 'K30106', 'San Pedro Village', 'AbnerBobadilla', '652-4538', '', '', '', '', 2010, -88.4941, 18.3388, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('San Pedro Government Primary', 'P30406', 'San Pedro Village', 'Abner Bobadilla', '652-4538', '', '', 'sanpedro_gov09@yahoo.com', '', 1972, -88.4941, 18.3388, 'Corozal', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('San Pedro High School', 'S19002', 'P.0. Box 23,  San Pedro Town, A.C.  Belize, District', 'Emil R. Vasquez', '226-2045', '', '', 'sphs@btl.net', '', 1971, -87.9594, 17.9247, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('San Pedro Jr. College', 'J19001', 'Lagoon St.', 'Paul Kelly', '226-4691', '', '', 'pkelly@spjc.edu.bz', '', 2014, -87.9594, 17.9247, 'Belize', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Pedro Preschool', 'K11014', 'Ambergris Street, San Pedro Town', 'Rosela Guerrero', '602-1733', '', '', 'sanpedro_preschool@hotmail.com', '', 1996, -87.963, 17.9205, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Rosela Guerrero', 'Isaura Nunez', NULL, NULL, NULL),
('San Pedro RC Primary', 'P11004', 'Corner Barrier Reef Drive & Tarpon Street', 'Roxani Kay', '226-2550', '', '', 'sanpedrorcschool@yahoo.com', '', 1964, -87.9634, 17.9175, 'Belize', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL);
INSERT INTO `moe_school_info` (`name`, `code`, `address`, `contact_person`, `telephone`, `telephone_alt1`, `telephone_alt2`, `email`, `website`, `year_opened`, `longitude`, `latitude`, `district`, `locality`, `type`, `ownership`, `sector`, `school_Administrator_1`, `school_Administrator_2`, `admin_comments`, `created_at`, `updated_at`) VALUES
('San Pedro Shining Stars Preschool', 'K11021', 'Rosewood street, Escalante Subdivision, San Pedro Town, Belize District', 'Avelina Heredia', '226-3541', '', '', 'spshiningstars@gmail.com', '', 2014, -87.9778, 17.9017, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('San Roman RC Primary', 'P41204', 'San Roman Rio Hondo', 'Nellie Toledano (principal), Shahira Lara (vice-pr', '606-4392', '', '', 'sanromanrcs.ow@gmail.com', 'https://www.facebook.com/SanRomanRCSchool', 2014, -88.6412, 18.192, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Vicente RC Primary', 'P61114', 'San Vicente Village', 'Ricardo Coc', '601-9057', '', '', 'sanvicentercschool@gmail.com', '', 2014, -89.2, 16.2396, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Ricardo Coc', '', NULL, NULL, NULL),
('San Victor RC Preschool', 'K34110', 'San Victor Village', 'Ramiro Castillo', '', '', '', '', '', 2007, -88.5757, 18.261, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('San Victor RC Primary', 'P31411', 'San Victor Village', 'Romiro Arthuro Castillo', '664-1045', '', '', 'svictorrcschool2@gmail.com', '', 1965, -88.5757, 18.261, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Sandhill Community Preschool', 'K10104', '18 miles Phillip Goldson Highway, Sandhill Village', 'Patricia Jones', '610-8965', '', '', 'patriciacantonjones43@gmail.com', '', 2014, -88.3726, 17.6374, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Patricia Jones', 'Grace Young', NULL, NULL, NULL),
('Sandy Creek Academy Preschool', 'K51104', 'Mile 7, Southern Highway  Silk Grass Village  Stann Creek District', 'Dr. Henry Canton', '', '', '', 'sandycreekelementary@silkgrassfarms.com', '', 2023, -88.3378, 16.8887, 'Stann Creek', 'Rural', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Sandy Creek Academy Primary', 'P57101', 'Mile 7, Southern Highway  Silk Grass  Stann Creek', 'Dr. Henry Canton', '', '', '', '', '', 2023, -88.3378, 16.8887, 'Stann Creek', 'Rural', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Santa Ana Government School', 'P60204', 'Santa Anna Village', 'Howard Reyes', '655-3310', '', '', 'santaanagovernment@gmail.com', '', 2014, -88.9533, 16.1092, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Howard Reyes', '', NULL, NULL, NULL),
('Santa Clara Baptist Preschool', 'K34107', 'PO Box 264, Santa Clara Village', 'Carmita Canul', '634-8005', '', '', 'carmitacanul@yahoo.com', '', 1986, -88.5093, 18.2912, 'Corozal', 'Rural', 'Preschool', 'Baptist Schools', 'Government Aided', 'Carmita Canul', '', NULL, NULL, NULL),
('Santa Clara SDA Primary School', 'P34410', 'Santa Clara Village', 'Urbano Yah', '674-5800', '', '', 'santaclarasdaschool19@gmail.com', '', 1950, -88.5094, 18.2951, 'Corozal', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Alvaro Tzul', '', NULL, NULL, NULL),
('Santa Clara/San Roman RC Primary', 'P31412', 'Santa Clara/San Roman Villages', 'Humberto Juarez', '620-0775', '', '', 'scsr1952@gmail.com', '', 1952, -88.5088, 18.2967, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Santa Cruz Government Preschool', 'K50103', 'Santa Cruz Village  Stann Creek District', 'Giselle Serano Gamboa', '613-4499', '672-2175', '', 'santacruzgovernment2020@gmail.com', '', 2017, -88.4285, 16.7, 'Stann Creek', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Chloe Crawford', '', NULL, NULL, NULL),
('Santa Cruz Government Primary', 'P40102', 'Santa Cruz Village', 'Yolanda Novelo', '624-9222', '660-7148', '', 'santacruzgov79@gmail.com', '', 2014, -88.7087, 18.1139, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Santa Cruz Government Primary School', 'P50105', 'Santa Cruz Village  Stann Creek', 'Giselle Serano Gamboa', '613-4499', '672-2175', '', 'santacruzgovernment2020@gmail.com', '', 2017, -88.4285, 16.7, 'Stann Creek', 'Rural', 'Primary', 'Government Schools', 'Government', 'Chloe Crawford', '', NULL, NULL, NULL),
('Santa Cruz RC Primary', 'P61115', 'Santa Cruz Village', 'Zita Sho-Bol', '635-9513', '', '', 'santacruzrc2013@gmail.com', '', 2014, -89.0771, 16.2336, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Zita Sho-Bol', 'Locario Che', NULL, NULL, NULL),
('Santa Elena Baptist Preschool', 'K24003', 'Corner Carillo Puerto & George Price Ave', 'Lela Cowo', '624-5722', '', '', 'vani88_b@yahoo.com', '', 2014, -89.0629, 17.1621, 'Cayo', 'Urban', 'Preschool', 'Baptist Schools', 'Government Aided', 'Lela Cowo (Principal)', '', NULL, NULL, NULL),
('Santa Elena Baptist Primary', 'P29003', 'Bradley Bank, Santa Elena', 'Maria Martinez', '613-0580', '', '', 'baptistprimary2013@gmail.com', '', 2013, -89.0629, 17.1621, 'Cayo', 'Urban', 'Primary', 'Baptist Schools', 'Government Aided', 'Ana Hulse', 'Michel Hyde', NULL, NULL, NULL),
('Santa Elena RC Primary', 'P61116', 'Santa Elena Village', 'Diane Teul', '613-6222', '', '', 'dianeteul16@gmail.com', '', 2014, -89.1082, 16.2298, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Diane Teul', '', NULL, NULL, NULL),
('Santa Elena RC Primary-CYO', 'P21007', 'Perez Street, Santa Elena', 'Andrea Guerra', '824-2919', '', '', 'santaelenaschool@yahoo.com', '', 2014, -89.0592, 17.1659, 'Cayo', 'Urban', 'Primary', 'Catholic Schools', 'Government Aided', 'Manuel Medina', 'Elizabeth Shol', NULL, NULL, NULL),
('Santa Familia RC Primary', 'P21301', 'Santa Familia Village', 'Estevan Donicio Escobar', '650-5942', '662-7140', '', 'santafamiliaschool72@hotmail.com', '', 1958, -89.0709, 17.1896, 'Cayo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Estevan Escobar (Principal),Estevan Escobar (Princ', 'Wendell (Wardell) Pook (Teacher),Wendell (Wardell)', NULL, NULL, NULL),
('Santa Martha Government Preschool', 'K40103', 'Santa Martha Village', 'Alejandro Hernandez', '669-8262', '', '', '', '', 2014, -88.502, 18.0156, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Alejandro Hernandez', 'Berta Chi Acuna', NULL, NULL, NULL),
('Santa Martha Government Primary', 'P40103', 'Santa Martha Village', 'Seleni Grajales', '605-7513', '', '', 'selenigrajales@gmail.com', '', 2014, -88.502, 18.0156, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Santa Rita Christian Primary', 'P36401', 'Santa Rita Layout', 'Rangel Tzul', '636-4911', '', '', 'santaritasembliesofgod@gmail.coom', '', 1982, -88.3952, 18.4032, 'Corozal', 'Urban', 'Primary', 'Assemblies Of God Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Santa Teresa Preschool', 'K41003', '26 Dunn Street', 'Irianna Emelia Leiva', '661-6729', '', '', 'maria_thompson55@hotmail.com', '', 2005, -88.564, 18.0836, 'Orange Walk', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Irianna Emelia Leiva', '', NULL, NULL, NULL),
('Santa Teresa RC Preschool', 'K64114', 'Santa Teresa', 'Juan Chub', '661-5869', '601-1541', '', 'santateresarc2021@gmail.com', '', 2014, -89.0534, 16.136, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Juan Chub', 'Severina Rash', NULL, NULL, NULL),
('Santa Teresa RC Primary', 'P61117', 'Santa Teresa Village', 'Juan Chub', '661-5869', '601-1541', '', 'santateresarc2021@gmail.com', '', 2014, -89.0534, 16.136, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Juan Chub', '', NULL, NULL, NULL),
('Santiago Juan Community Preschool', 'K20002', '17 Cabbage Bark Street, Santiago Juan Layout', 'Yadira Aldana', '622-7174', '', '', 'santiagojuanpreschool@gmail.com', '', 2013, -89.0843, 17.1547, 'Cayo', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Yadira Aldana', 'Gina Escobar (Teacher)', NULL, NULL, NULL),
('Sarteneja Baptist High School', 'S37102', 'Sarteneja Village', 'Areli Canul', '628-8420', '423-2143', '', 'ccasarteneja@yahoo.com', '', 2002, -88.1406, 18.3549, 'Corozal', 'Rural', 'Secondary', '', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Sarteneja Community Preschool', 'K32102', 'Sarteneja Village', 'Sara Cobb', '625-1851', '', '', 'sarisusan72@gmail.com', '', 1988, -88.1479, 18.3542, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Sarteneja La Inmaculada RC  Preschool', 'K34122', 'Primitivo Aragon Avenue,  Sarteneja Village,  Corozal District,  Belize', 'Evelio Tzul', '633-1371', '', '', 'sarteneja.inmaculada@gmail.com', '', 2023, -88.1382, 18.3541, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Sarteneja La Inmaculada RC Primary School', 'P31104', 'Primitivo Aragon Avenue,  Sarteneja Village,  Corozal District,  Belize', 'Evelio Tzul', '633-1371', '', '', 'sarteneja.inmaculada@gmail.com', '', 1948, -88.1382, 18.3541, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Sarteneja Nazarene Preschool', 'K34105', 'Sarteneja Village', 'Mario Mora', '615-5221', '', '', '', '', 2005, -88.1418, 18.3552, 'Corozal', 'Rural', 'Preschool', 'Nazarene Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Sarteneja Nazarene Primary', 'P35101', 'Sarteneja Village  Corozal District', 'Mario Mora Jr', '615-5221', '', '', 'sartenejanazarene@gmail.com', '', 1987, -88.1418, 18.3552, 'Corozal', 'Rural', 'Primary', 'Nazarene Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Seven Miles Christian School', 'P28106', '7 Miles Mountain Pine Ridge Rd', 'James Eicher', '660-8821', '', '', 'bmctdev@gmail.com', '', 2015, -88.9553, 17.1064, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Stephen Schrock', 'James Eicher', NULL, NULL, NULL),
('Shalom Mennonite High School', 'S48101', 'Carmelita Village, Orange Walk', 'David Steinhaver', '630-7022', '', '', 'davystein3@yahoo.com', '', 2014, -88.542, 18.0119, 'Orange Walk', 'Rural', 'Secondary', '', 'Private', '', '', NULL, NULL, NULL),
('Shalom Mennonite Preschool', 'K41102', 'Carmelita Village, Orange Walk', 'David Steinhaver', '630-7022', '', '', 'davystein3@yahoo.com', '', 2014, -88.542, 18.0119, 'Orange Walk', 'Rural', 'Preschool', 'Mennonite Schools - Church Group', 'Private', '', '', NULL, NULL, NULL),
('Shalom Mennonite Primary School', 'P48401', 'Carmelita Village, Orange Walk', 'David Steinhaver', '630-7022', '', '', 'shalomschoolbz@gmail.com', '', 2014, -88.542, 18.0119, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', '', '', NULL, NULL, NULL),
('Shanna M. Banner Preschool', 'K21015', '25 Trio Street  Belmopan', 'Shanna Banner', '', '', '', '', '', 2024, 0, 0, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Shiloh SDA Primary School', 'P54101', 'Hercules Ave., Independence Village', 'Nordia Diego', '667-8808', '638-8808', '', 'shilohadventistscd@gmail.com', '', 1989, -88.4159, 16.5374, 'Stann Creek', 'Rural', 'Primary', 'Adventist Schools', 'Government Aided', 'Marva Bennett Awardo', 'Shaina  Burgess', NULL, NULL, NULL),
('Shipyard Mennonite Community Primary School', 'P48201', '', '', '', '', '', '', '', 2014, -88.6762, 17.9183, 'Orange Walk', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Silk Grass Methodist Preschool', 'K54107', 'Silk Grass Village, Stann Creek', 'Terrence Salam', '672-4868', '', '', 'silkgrassmethodistschool@gmail.com', '', 2014, -88.3381, 16.886, 'Stann Creek', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Silk Grass Methodist Primary School', 'P53402', 'Silk Grass Village', 'Terrence Salam', '672-4868', '', '', 'silkgrassmethodistschool@gmail.com', '', 2014, -88.3381, 16.886, 'Stann Creek', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Kevin Brooks', 'Luis Perez', NULL, NULL, NULL),
('Silver Creek RC  Preschool', 'K64105', 'Silver Creek Village', 'Luis Cal', '631-1765', '639-8312', '', 'Luis.alvin.cal@gmail.com', '', 2014, -88.8905, 16.2791, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Luis Cal', 'Consuela Choco', NULL, NULL, NULL),
('Silver Creek RC Primary School', 'P61205', 'Silver Creek Village', 'Luis Alvin Cal', '631-1765', '', '', 'silvercreekrc@gmail.com', '', 2014, -88.8905, 16.2791, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Luis Alvin Cal', 'Consuela Choco', NULL, NULL, NULL),
('Sittee River Methodist Preschool', 'K54105', 'Sittee River Village', 'Stacy Andrews', '614-8965', '', '', 'sitteerivermethodistschool@gmail.com', '', 2014, -88.3207, 16.8219, 'Stann Creek', 'Rural', 'Preschool', 'Methodist Schools', 'Government Aided', 'Sylvia Sabal', 'Neckesha Pratt', NULL, NULL, NULL),
('Sittee River Methodist Primary', 'P53201', 'Sittee River Village', 'Stacy Andrews', '614-8965', '', '', 'sitteerivermethodistschool@gmail.com', '', 2014, -88.3207, 16.8219, 'Stann Creek', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Sylvia Sabal', 'Neckesha Pratt', NULL, NULL, NULL),
('Small World Preschool', 'K14007', '2 G St. Kings Park, Belize City', 'Teresita Wade', '635-1380', '', '', 'smallworldpresschool.1@gmail.com', '', 1979, -88.1918, 17.5088, 'Belize', 'Urban', 'Preschool', 'Baptist Schools', 'Government Aided', 'Lisa Arnold, Teacher', 'Theresita Wade, Head Teacher', NULL, NULL, NULL),
('Solid Rock Christian Academy', 'P56001', 'Rivas Estate, Dangriga', 'Mrs.Ysela Aleman', '522-0776', '', '', 'sradga@yahoo.com', '', 1999, -88.2286, 16.9586, 'Stann Creek', 'Urban', 'Primary', 'Assemblies Of God Schools', 'Government Aided', 'Mrs. Shannon Martinez,Mrs. Shannon Martinez', 'Ms. Danelly Nah,Ms. Danelly Nah', NULL, NULL, NULL),
('Solid Rock Christian Academy Preschool', 'K54003', 'Rivas Estate, PO Box 40, Dangriga', 'Ysela Aleman', '522-0776', '604-4033', '', 'sradga@yahoo.com', '', 1984, -88.2286, 16.9586, 'Stann Creek', 'Urban', 'Preschool', 'Assemblies Of God Schools', 'Government Aided', 'Shanon Martinez', 'Patricia Evans', NULL, NULL, NULL),
('Solomon\'s SDA Primary', 'P44001', 'Palmar Boundary Road', 'Sheryl Distan', '668-7846', '', '', 'solomonssdaprincipal@gmail.com', '', 2014, -88.5706, 18.067, 'Orange Walk', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Spanish Lookout Mission Preschool', 'K28101', 'Spanish Lookout', 'Calvin Reimer', '670-3172', '', '', 'birderric@gmail.com', '', 2014, -89.0126, 17.2884, 'Cayo', 'Rural', 'Preschool', 'Mennonite Schools - Spanish Lookout', 'Private', 'Calvin Reimer', 'Ricky Reimer', NULL, NULL, NULL),
('Spanish Lookout Mission Primary School', 'P28101', 'Spanish Lookout', 'Marvin Plett', '670-5323', '670-3172', '675-9090', 'calvin@diversetrades.com', '', 2013, -89.0134, 17.2888, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Spanish Lookout', 'Private', 'Calvin Reimer', 'Ricky Reimer', NULL, NULL, NULL),
('Stann Creek Ecumenical College', 'S59001', 'P.O. Box 84, Dangriga', 'Ray Lawrence', '522-2114', '', '', 'ecuhighschool@gmail.com', '', 2014, -88.2279, 16.963, 'Stann Creek', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Stann Creek Ecumenical Jr. College', 'J59001', 'Ecumenical Drive', 'Karen Martinez', '522-2654', '', '', 'ecumenicaljuniorcollege@yahoo.com', 'http://ejc.edu.bz/main/welcome/', 2008, -88.2265, 16.9632, 'Stann Creek', 'Urban', 'Tertiary', 'Community Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Star Brite Preschool', 'K12105', 'Poinsettia St., Mitchelle Estate, Ladyville', 'Lucy Hutchinson', '225-2531', '', '', 'starbriteladyvlle@gmail.com', '', 1991, -88.2931, 17.5483, 'Belize', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Stella Maris Special Education and Life Skills Learning Center', 'P10001', 'Princess Margaret Drive, Belize City', 'Francelia  Cantun', '224-4564', '', '', 'stellamarisbz@yahoo.com', '', 1958, -88.196, 17.5053, 'Belize', 'Urban', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Stepping Stones Preschool', 'K10001', '# 36 Corner Albert Hoy & Guava St.  Belama Phase 2', 'Eichill Alamalia', '620-2540', '', '', 'steppingstonepreschoolbze@gmail.com', '', 2005, -88.22, 17.5107, 'Belize', 'Urban', 'Preschool', 'Government Schools', 'Government', 'Beverly Pook, Principal', '', NULL, NULL, NULL),
('Sun Flower Preschool', 'K11016', '#4 Wood Street St. Belize City', 'Desiree Myvette', '227-5920', '', '', '', '', 2014, -88.1931, 17.4957, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Desiree Myvett', '', NULL, NULL, NULL),
('Sunday Wood RC Primary School', 'P61118', 'Sunday Wood Village', 'Daniel Ishim', '661-9695', '626-0870', '', 'sundaywoodrc@gmail.com', '', 2014, -89.0333, 16.0388, 'Toledo', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', 'Anthony Fuentes', '', NULL, NULL, NULL),
('Sunday Wood Sunrise Preschool', 'K64115', 'Sunday Wood Village', 'Daniel Ishim', '661-9695', '', '', 'sundaywoodrc@gmail.com', '', 2014, -89.0333, 16.0388, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Mr. Anthony Fuentes', 'Dionie Rodriguez', NULL, NULL, NULL),
('Sunlight Christian Education', 'P28201', 'Across from FTC  P.O. Box 401  Spanish Lookout  Cayo District', 'Steven Braun', '615-2531', '', '', 'sceprimary@gmail.com', '', 1958, -89.0017, 17.2522, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Spanish Lookout', 'Private', 'John Lowen', 'Orlando Braun', NULL, NULL, NULL),
('Sunrise View School', 'P58403', '14 miles Pomona Village Stann Creek', '', '', '', '', '', '', 2023, 0, 0, 'Stann Creek', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', '', '', NULL, NULL, NULL),
('Sunshine Preschool', 'K11017', '86 Regent St', 'Mireille Tillett', '636-9569', '', '', 'sunshine1preschool123@gmail.com', '', 1992, -88.188, 17.4883, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Karina Jones', 'Jenine Young', NULL, NULL, NULL),
('Sunshine Preschool- Paraiso GOB', 'K30102', 'Paraiso Village', 'Marvilla Lawrence', '402-3255', '', '', '', '', 2004, -88.3946, 18.4099, 'Corozal', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Sunshine Valley Primary School', 'P28204', 'Upper Barton Creek', 'Mr. Monroe Penner', '', '', '', '', '', 2024, -88.7581, 17.9682, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Monroe Penner', '', NULL, NULL, NULL),
('The Island Academy Primary School', 'P17004', 'Mahogany Bay, PO Box 137, San Pedro Town', 'Lady Dixie W. Bowen', '226-3642', '', '', 'islandacad@gmail.com', 'www.theislandacademy.com', 1995, -87.9672, 17.9142, 'Belize', 'Urban', 'Primary', 'Private Schools', 'Private', 'Lady Dixie W. Bowen', 'Wilema Gonzalez', NULL, NULL, NULL),
('The Salvation Army Primary School', 'P19006', '12 Cemetery Road, Belize City', 'Carol Martin', '207-2156', '636-4711', '628-3365', 'thesalvationarmy.sch@gmail.com', '', 2014, -88.1901, 17.4949, 'Belize', 'Urban', 'Primary', 'Salvation Army Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('The Shepherds Academy Preschool', 'K21012', 'Rivera Road, Belmopan', 'Carla Marin', '824-2113', '615-4279', '', 'theshepherdsacademy@gmail.com', '', 2022, -88.7865, 17.2502, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Diana Giesbrecht', 'Pastor Jose Marin', NULL, NULL, NULL),
('The Shepherds Academy Primary', 'P27001', 'Riviera Road, Belmopan', 'Carla Marin/ Pastor Jose Marin - Diana Giesbrecht', '842-2113', '615-6030', '610-4279', 'theshepherdsacademy@gmail.com', 'theshepherdsacademy.com', 2008, -88.7865, 17.2502, 'Cayo', 'Urban', 'Primary', 'Private Schools', 'Private', 'Diana Giesbrecht', 'Pastor Jose Marin', NULL, NULL, NULL),
('Tiny Tots SDA Preschool', 'K64004', 'Indianville Extention  Punta Gorda Town  Toledo District', 'Rose Locario', '636-2547', '', '', 'roselocario@gmail.com', '', 2011, -88.8205, 16.1051, 'Toledo', 'Urban', 'Preschool', 'Adventist Schools', 'Government Aided', 'Rose Odinga', 'Rose Locario', NULL, NULL, NULL),
('Toledo Christian Academy Preschool', 'K61101', '8.5 Miles San Antonio Road,   Yemeri Grove  Toledo', 'Edwardo Chub', '722-0266', '', '', 'tcaprincipal7@gmail.com', '', 2014, -88.8891, 16.1621, 'Toledo', 'Rural', 'Preschool', 'Private Schools', 'Private', 'Edwardo Chub', '', NULL, NULL, NULL),
('Toledo Christian Academy Primary School', 'P67401', '8.5 miles San Antonio Road, Yemeri Grove', 'Charlston Fisher', '722-0256', '663-0102', '', 'toledochristianacademy@gmail.com', '', 1994, -88.8891, 16.1621, 'Toledo', 'Rural', 'Primary', 'Private Schools', 'Private', 'Edwardo Chub', '', NULL, NULL, NULL),
('Toledo Community College', 'S69001', 'New City Area  PO Box 41  Punta Gorda Town', 'Shaunna Sanchez', '722-2101', '', '', 'prinicpal@tcc.edu.bz', '', 1983, -88.8064, 16.1051, 'Toledo', 'Urban', 'Secondary', '', 'Government', '', '', NULL, NULL, NULL),
('Toledo Learning Center', 'P67101', '9.5 Miles Old San Antonio Road', 'Alma Zuniga', '', '', '', '', '', 2022, -89.0304, 16.2468, 'Toledo', 'Rural', 'Primary', 'Private Schools', 'Private', '', '', NULL, NULL, NULL),
('Trial Farm Government Primary School', 'P40405', 'Orange Walk', 'Nazira Romero', '322-2481', '', '', 'trialfarmgovtsch@gmail.com', '', 1984, -88.5632, 18.0981, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', 'Nazira Romero', 'Susana Nicholson', NULL, NULL, NULL),
('Trial Farm Preschool', 'K40101', 'San Isidro Street, Trial Farm Village', 'Nazira Romero', '322-2481', '', '', '', '', 2014, -88.5632, 18.0981, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Trinidad Government Primary', 'P40404', 'Trinidad Village', 'Victoria Carrilo', '661-5747', '', '', 'trinidadgovschool@gmail.com', '', 2014, -88.5634, 18.0983, 'Orange Walk', 'Rural', 'Primary', 'Government Schools', 'Government', '', '', NULL, NULL, NULL),
('Trinity Methodist Primary School', 'P13005', '5 G Street, King\'s Park, Belize City', 'Jamael Campbell', '223-1096', '', '', 'trinitymethodistschool@gmail.com', 'https://www.facebook.com/Trinity-Methodist-School-', 1989, -88.1917, 17.5099, 'Belize', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Brendalee Enriquez', 'Alice Middleton', NULL, NULL, NULL),
('Trio Government Preschool', 'K60103', 'Trio Village, Toledo District', 'Anselma Woolery', '673-9525', '', '', 'triogovernment2001@gmail.com', '', 2015, -88.6363, 16.5157, 'Toledo', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Adon Arzu', 'Eric Gutierrez', NULL, NULL, NULL),
('Trio Government Primary School', 'P60107', 'Trio Village, Toledo District', 'Anselma Woolery', '673-9525', '671-3426', '', 'triogovernment2001@gmail.com', '', 2001, -88.6363, 16.5157, 'Toledo', 'Rural', 'Primary', 'Government Schools', 'Government', 'Adon arzu', 'Eric Gutierrez', NULL, NULL, NULL),
('Tumul K’in Center of Learning', 'S67102', 'Blue Creek Village  Toledo District', 'Filberto Rash', '613-6651', '', '', 'tumulkincenteroflearning@gmail.com', '', 2015, -89.0478, 16.1943, 'Toledo', 'Rural', 'Secondary', '', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Twinkle Star Preschool', 'K61107', 'Jalacte Village', 'Floriano Chun', '607-4406', '', '', 'jalactercschool88@yahoo.com', '', 2008, -89.2021, 16.204, 'Toledo', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', 'Floriano Chun', 'Aleida Velasquez', NULL, NULL, NULL),
('UB Academy Pre-Primary School', 'K23002', 'George Price Blvd  San Martin', 'Katheline Zuniga', '601-1404', '', '', 'kzuniga@ub.edu.bz', '', 2024, 0, 0, 'Cayo', 'Urban', 'Preschool', 'Private Schools', 'Government Aided', 'Kathleen Zuniga', 'Patricia Tzul', NULL, NULL, NULL),
('UB Academy Primary School', 'P29004', 'Belmopan', 'Thisbe Lucas-Usher', '', '', '', '', '', 2024, 0, 0, 'Cayo', 'Urban', 'Primary', 'University of Belize', 'Government Aided', '', '', NULL, NULL, NULL),
('United Christian Mennonite Primary School', 'P28001', 'New Santa Cruz Area, Santa Elena', 'Louis H. Ysaguirre', '654-4927', '', '', 'unitedchristianschoolbz@gmail.com', '', 2014, -89.0544, 17.1624, 'Cayo', 'Urban', 'Primary', 'Mennonite Schools - Church Group', 'Private', 'Craig Steiner (Principal)', 'Jansen Overholt (Teacher)', NULL, NULL, NULL),
('United Community Preschool', 'K52102', '26 1/2 miles Southern Highway', 'Sylvia Ogaldez', '662-1770', '', '', 'unitedcommunity.primary@gmail.com', '', 2014, -88.4707, 16.6574, 'Stann Creek', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Anthony Zuniga', 'Delia Cardona', NULL, NULL, NULL),
('United Community Primary', 'P50104', 'Mile 26 1/2 Southern Highway  Santa Rosa/ San Roman Village', 'Sylvia Ogaldez', '662-1770', '', '', 'unitedcommunity.primary@gmail.com', '', 2014, -88.4707, 16.6574, 'Stann Creek', 'Rural', 'Primary', 'Government Schools', 'Government', 'Anthony A. Zuniga', 'Delia Cardona', NULL, NULL, NULL),
('United Evergreen Primary', 'P20002', 'Ambergris Caye  Belmopan', 'Mrs. Rosalie Witty', '822-2288', '', '', 'unitedevergreenpr@yahoo.com', '', 2014, -88.7667, 17.2524, 'Cayo', 'Urban', 'Primary', 'Government Schools', 'Government', 'Rosalie Witty', 'Joel Flores', NULL, NULL, NULL),
('Unity Presbyterian Primary', 'P19007', '109 A Antelope Extension', 'Dalila Makhwani', '606-6543', '615-7804', '', 'unitypresbyterian71@yahoo.com', '', 2007, -88.2066, 17.497, 'Belize', 'Urban', 'Primary', 'Presbyterian Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Unity Star Child Preschool', 'K14011', '109 A Antelope Extension', 'Carolyn Betson', '671-4151', '630-3070', '', 'cbetson92@gmail.com', '', 2007, -88.2066, 17.497, 'Belize', 'Urban', 'Preschool', 'Presbyterian Schools', 'Government Aided', 'Carolyn Betson', '', NULL, NULL, NULL),
('Valley of Peace Christian Primary School', 'P26101', 'PO Box 501, Belmopan/Valley of Peace', 'Jesus Catzim', '651-5686', '', '', 'valleychristian.ag@gmail.com', '', 1986, -88.8348, 17.3326, 'Cayo', 'Rural', 'Primary', 'Assemblies Of God Schools', 'Government Aided', 'Modesto Duenas', 'Edras Navarro', NULL, NULL, NULL),
('Valley of Peace SDA Academy', 'S24101', 'Valley of Peace', 'Justine Shanice Myvette', '653-5697', '', '', 'valleyofpeaceacademy@yahoo.com', '', 2006, -88.8439, 17.3294, 'Cayo', 'Rural', 'Secondary', '', 'Specially Assisted', '', '', NULL, NULL, NULL),
('Victorious Nazarene Preschool', 'K24104', 'San Jose Succotz Village', 'Shirley Humes', '660-5689', '627-3084', '', 'principal@vns.edu.bz', '', 2014, -89.1242, 17.0787, 'Cayo', 'Rural', 'Preschool', 'Nazarene Schools', 'Government Aided', 'Shirley Humes', 'Reynelda Vasquez', NULL, NULL, NULL),
('Victorious Nazarene Primary School', 'P25402', 'SanJose Succotz', 'Shirley Humes', '627-3084', '660-5689', '', 'principal@vns.edu.bz', 'vns.edu.bz', 2002, -89.1242, 17.0787, 'Cayo', 'Rural', 'Primary', 'Nazarene Schools', 'Government Aided', 'Shirley Humes', '', NULL, NULL, NULL),
('Wesley College', 'S13001', '34 Yarborough Road, Belize City', 'Roxanne Cleland', '227-7127', '', '', 'wesley.college.bz@gmail.com', '', 1882, -88.1903, 17.4873, 'Belize', 'Urban', 'Secondary', '', 'Government Aided', '', '', NULL, NULL, NULL),
('Wesley Jr. College', 'J13001', '34 Yarborough Rd', 'Eleanor Gillett', '227-0333', '', '', 'wesleyjuniorcollege@yahoo.com', '', 2014, -88.19, 17.4875, 'Belize', 'Urban', 'Tertiary', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Wesley Junior College', 'A13001', '34 Yarborough Rd.', 'Eleanor Gillett', '227-0333', '', '', 'wesleyjuniorcollege@yahoo.com', '', 2000, -88.19, 17.4875, 'Belize', 'Urban', 'Adult and Continuing', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Wesley Lower Primary School', 'P13006', '38 Albert Street, Belize City', 'Natalie Phillips', '227-3931', '227-3288', '631-0765', 'wesleylower1913@gmail.com', '', 1913, -88.1877, 17.4911, 'Belize', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Darlene Lozano', '', NULL, NULL, NULL),
('Wesley Preschool', 'K14009', '1 Chapel Lane', 'Zydah Cayetano', '227-4809', '', '', 'wesleypreschoolbz20@yahoo.com', 'https://www.facebook.com/wesleypreschoolbze/', 1967, -88.1877, 17.4911, 'Belize', 'Urban', 'Preschool', 'Methodist Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Wesley Upper Primary School', 'P13008', '44 Dolphin Street, Belize City', 'Nicole Welch Middleton', '227-2921', '672-2789', '', 'wesleyupperschool@gmail.com', '', 1913, -88.1948, 17.4903, 'Belize', 'Urban', 'Primary', 'Methodist Schools', 'Government Aided', 'Nicole Welch Middleton', '', NULL, NULL, NULL),
('Wispering Pines Mennonite Primary', 'P28202', 'Springfield   Cayo District', '', '', '', '', '', '', 2014, -88.8086, 17.1445, 'Cayo', 'Rural', 'Primary', 'Mennonite Schools - H&B', 'Private', 'Ivan Martin', 'Andrew Beiler', NULL, NULL, NULL),
('Xaibe Preschool', 'K34108', 'Xaibe Village', 'Mrs. Margaret Carr', '403-5226', '', '', '', '', 2005, -88.4304, 18.3877, 'Corozal', 'Rural', 'Preschool', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Xaibe RC Primary School', 'P31413', 'Xaibe Village', 'Margaret Carr', '623-6396', '403-5226', '', 'xaibercs@gmail.com', '', 1930, -88.4304, 18.3877, 'Corozal', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Yo Creek Community Preschool', 'K42103', 'Yo Creek Village', 'Claudia Smith', '668-9941', '', '', 'smithclaudia35@yahoo.com', '', 1992, -88.638, 18.0908, 'Orange Walk', 'Rural', 'Preschool', 'Government Schools', 'Government', 'Claudia Smith', '', NULL, NULL, NULL),
('Yo Creek Sacred Heart RC Primary School', 'P41409', 'Yo Creek Village', 'Maria Antonita Novelo', '323-2076', '', '', 'novelopechmaria@gmail.com', '', 1910, -88.6368, 18.0909, 'Orange Walk', 'Rural', 'Primary', 'Catholic Schools', 'Government Aided', '', '', NULL, NULL, NULL),
('Young Women\'s Christian Association Preschool', 'K13001', '119 Corner Freetown Rd & St Thomas Street', 'Sharie Pook', '223-4971', '', '', 'bzeywca@gmail.com', '', 1960, -88.1952, 17.5048, 'Belize', 'Urban', 'Preschool', 'Private Schools', 'Private', 'Nadine Harris', '', NULL, NULL, NULL),
('Zion Park Methodist Primary School', 'P13202', 'Santana Village, Belize District', 'Erminda Reid', '613-5809', '', '', 'zpms52@gmail.com', '', 1952, -88.3099, 17.8148, 'Belize', 'Rural', 'Primary', 'Methodist Schools', 'Government Aided', 'Erminda Reid', '', NULL, NULL, NULL),
('Zion SDA Primary School', 'P54001', '90 St. Vincent Street, Dangriga Town', 'Emilia Montejo', '502-2741', '614-3092', '', 'zsdaschool2014@gmail.com', '', 1972, -88.2207, 16.9647, 'Stann Creek', 'Urban', 'Primary', 'Adventist Schools', 'Government Aided', 'Emilia Montejo', 'Mario Bull', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `file_url` varchar(50) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `approved_for_adver` tinyint(1) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requiredfields`
--

CREATE TABLE `requiredfields` (
  `tablename` varchar(50) NOT NULL,
  `required` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `number_seats` int(11) DEFAULT NULL,
  `desktop_working` int(11) DEFAULT NULL,
  `desktop_not_working` int(11) DEFAULT NULL,
  `desktop_age` int(11) DEFAULT NULL,
  `desktop_ownership` int(11) DEFAULT NULL,
  `desktop_monitors` int(11) DEFAULT NULL,
  `desktop_keyboards` int(11) DEFAULT NULL,
  `desktop_mice` int(11) DEFAULT NULL,
  `desktop_comments` varchar(250) DEFAULT NULL,
  `chromebooks_working` int(11) DEFAULT NULL,
  `chromebooks_broken` int(11) DEFAULT NULL,
  `chromebooks_lost` int(11) DEFAULT NULL,
  `chromebooks_comments` varchar(250) DEFAULT NULL,
  `tablets_working` int(11) DEFAULT NULL,
  `tablets_broken` int(11) DEFAULT NULL,
  `tablets_lost` int(11) DEFAULT NULL,
  `tablets_comments` varchar(250) DEFAULT NULL,
  `old_computers_work` varchar(50) DEFAULT NULL,
  `old_computers_broken` varchar(50) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school`
--

CREATE TABLE `school` (
  `id` int(11) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `answered_filled_out` tinyint(1) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_grant_status`
--

CREATE TABLE `school_grant_status` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `status` enum('more info needed','pending_phone_call','pending site visit','pending final approval','approved for advertising','granted','pending shipment','pending installation','installed') DEFAULT NULL,
  `number_of_computers` int(11) DEFAULT NULL,
  `type_of_computers` varchar(50) DEFAULT NULL,
  `number_of_ethernet_switches` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_info`
--

CREATE TABLE `school_info` (
  `id` int(11) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `moe_name` varchar(80) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `address` varchar(80) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `telephone_alt1` varchar(20) DEFAULT NULL,
  `telephone_alt2` varchar(20) DEFAULT NULL,
  `moe_email` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `email_alt` varchar(50) DEFAULT NULL,
  `website` varchar(50) DEFAULT NULL,
  `year_opened` int(11) DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `district` enum('Belize','Cayo','Corozal','Orange Walk','Stann Creek','Toledo') DEFAULT NULL,
  `locality` enum('Rural','Urban') DEFAULT NULL,
  `type` enum('Preschool','Primary','Secondary','Tertiary','Vocational','Adult and Continuing','University') DEFAULT NULL,
  `ownership` varchar(50) DEFAULT NULL,
  `sector` enum('Government','Government Aided','Private','Specially Assisted') DEFAULT NULL,
  `school_administrator_1` varchar(50) DEFAULT NULL,
  `School_administrator_2` varchar(50) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `admin_comments` text DEFAULT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_requests`
--
ALTER TABLE `account_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `computerRoom`
--
ALTER TABLE `computerRoom`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- Indexes for table `curriculum`
--
ALTER TABLE `curriculum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- Indexes for table `demographics`
--
ALTER TABLE `demographics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- Indexes for table `moe_code_org`
--
ALTER TABLE `moe_code_org`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `moe_giga_connected`
--
ALTER TABLE `moe_giga_connected`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `moe_school_info`
--
ALTER TABLE `moe_school_info`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requiredfields`
--
ALTER TABLE `requiredfields`
  ADD PRIMARY KEY (`tablename`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- Indexes for table `school`
--
ALTER TABLE `school`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_grant_status`
--
ALTER TABLE `school_grant_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- Indexes for table `school_info`
--
ALTER TABLE `school_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `school_id` (`school_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_requests`
--
ALTER TABLE `account_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `computerRoom`
--
ALTER TABLE `computerRoom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `curriculum`
--
ALTER TABLE `curriculum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `demographics`
--
ALTER TABLE `demographics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school`
--
ALTER TABLE `school`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_grant_status`
--
ALTER TABLE `school_grant_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_info`
--
ALTER TABLE `school_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `computerRoom`
--
ALTER TABLE `computerRoom`
  ADD CONSTRAINT `computerRoom_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);

--
-- Constraints for table `curriculum`
--
ALTER TABLE `curriculum`
  ADD CONSTRAINT `curriculum_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);

--
-- Constraints for table `demographics`
--
ALTER TABLE `demographics`
  ADD CONSTRAINT `demographics_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);

--
-- Constraints for table `resources`
--
ALTER TABLE `resources`
  ADD CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);

--
-- Constraints for table `school_grant_status`
--
ALTER TABLE `school_grant_status`
  ADD CONSTRAINT `school_grant_status_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);

--
-- Constraints for table `school_info`
--
ALTER TABLE `school_info`
  ADD CONSTRAINT `school_info_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
