-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 25, 2021 at 06:41 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentist`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `AppID` int(200) NOT NULL,
  `Time` time NOT NULL,
  `AppDate` date NOT NULL,
  `followUp` tinyint(1) NOT NULL,
  `PatientID` int(11) NOT NULL,
  `lateCancellation` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`AppID`, `Time`, `AppDate`, `followUp`, `PatientID`, `lateCancellation`) VALUES
(1, '08:20:00', '2021-01-09', 0, 8, 0),
(2, '09:00:00', '2021-01-09', 1, 1, 0),
(3, '10:00:37', '2021-04-22', 0, 9, 0),
(4, '11:00:00', '2021-04-22', 0, 6, 0),
(5, '12:00:00', '2021-04-22', 1, 3, 0),
(6, '13:00:00', '2021-04-22', 0, 2, 0),
(7, '16:00:00', '2021-04-22', 0, 5, 0),
(8, '10:00:00', '2021-04-23', 0, 9, 0),
(9, '11:00:00', '2021-04-23', 0, 7, 0),
(10, '10:00:00', '2021-04-26', 1, 4, 0),
(11, '11:00:00', '2021-04-26', 0, 1, 0),
(12, '12:00:00', '2021-04-26', 0, 13, 0),
(13, '09:00:00', '2021-04-21', 1, 8, 0),
(14, '10:00:00', '2021-04-21', 0, 6, 1),
(15, '12:00:00', '2021-04-21', 0, 3, 0),
(16, '14:00:00', '2021-04-21', 0, 12, 0),
(17, '15:00:00', '2021-04-21', 0, 4, 0),
(18, '09:00:00', '2021-04-26', 0, 13, 0),
(19, '10:00:00', '2021-04-26', 0, 2, 0),
(20, '11:00:00', '2021-04-26', 0, 11, 0),
(21, '09:00:00', '2021-04-29', 0, 1, 1),
(22, '10:00:00', '2021-04-26', 0, 2, 0),
(24, '15:00:00', '2021-04-28', 0, 2, 1),
(25, '11:01:50', '2020-12-05', 0, 9, 0),
(26, '09:00:00', '2021-04-30', 0, 12, 0);

--
-- Triggers `appointment`
--
DELIMITER $$
CREATE TRIGGER `Latecancel` AFTER UPDATE ON `appointment` FOR EACH ROW BEGIN 

IF NEW.lateCancellation = 1 THEN

INSERT INTO Bill( `Paid`, `Total`, `AppID`, `PatientID`) VALUES ( 0, 10.00, OLD.AppID, OLD.PatientID); 

END IF;

 END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointmentdet`
--

CREATE TABLE `appointmentdet` (
  `TreatmentName` varchar(200) NOT NULL,
  `AppNo` int(200) NOT NULL,
  `Details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointmentdet`
--

INSERT INTO `appointmentdet` (`TreatmentName`, `AppNo`, `Details`) VALUES
('Braces', 1, 'Braces checked and adjusted\r\n'),
('Checkup', 2, 'General checkup\r\n'),
('Checkup', 3, 'General checkup'),
('Checkup', 4, 'CANCELLED'),
('Checkup', 5, 'General checkup'),
('Checkup', 8, 'General checkup'),
('Checkup', 11, 'General checkup'),
('Checkup', 13, 'General checkup. Possible root canal required. Follow up recorded'),
('Checkup', 14, 'General checkup'),
('Clean', 6, NULL),
('Clean', 9, NULL),
('Clean', 12, NULL),
('Filling', 2, 'Small Filling'),
('Filling', 3, '2 Fillings required'),
('Filling', 12, '3 Fillings required for patient'),
('Referral for Gum Transplant', 5, 'Referral and follow up required'),
('Referral for Jaw Protrusion Surgery', 8, 'Examination showed a class 2 occlusion that may need attention'),
('Root Canal', 10, 'Root canal procedure necessary. Follow up required');

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `BillNo` int(1) NOT NULL,
  `Paid` tinyint(1) NOT NULL DEFAULT 0,
  `Total` decimal(6,2) NOT NULL,
  `AppID` int(11) DEFAULT NULL,
  `PatientID` int(11) DEFAULT NULL,
  `largebill` tinyint(4) DEFAULT 0,
  `overdue` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`BillNo`, `Paid`, `Total`, `AppID`, `PatientID`, `largebill`, `overdue`) VALUES
(1, 1, '100.00', 1, 8, 0, 1),
(2, 0, '50.00', 2, 1, 0, 1),
(3, 0, '100.00', 3, 9, 0, 0),
(4, 0, '10.00', 4, 6, 0, 0),
(5, 0, '40.00', 5, 3, 0, 0),
(6, 0, '40.00', 6, 2, 0, 0),
(7, 0, '40.00', 7, 5, 0, 0),
(8, 0, '20.00', 8, 9, 0, 0),
(9, 0, '40.00', 9, 7, 0, 0),
(10, 0, '150.00', 12, 13, 0, 0),
(11, 0, '40.00', 14, 6, 0, 0),
(12, 0, '240.00', 10, 4, 1, 0),
(32, 0, '10.00', 21, 1, 0, 0),
(33, 0, '10.00', 14, 6, 0, 0),
(34, 0, '100.00', 18, 2, 0, 0),
(35, 0, '40.00', 25, 9, 0, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `followups`
-- (See below for the actual view)
--
CREATE TABLE `followups` (
`AppID` int(200)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `galway_patients`
-- (See below for the actual view)
--
CREATE TABLE `galway_patients` (
`PatientID` int(25)
,`fName` varchar(20)
,`lName` varchar(20)
,`Address` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `large_bills`
-- (See below for the actual view)
--
CREATE TABLE `large_bills` (
`BillNo` int(1)
,`AppID` int(200)
,`PatientID` int(11)
,`Total` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `overdue_payments`
-- (See below for the actual view)
--
CREATE TABLE `overdue_payments` (
`BillNo` int(1)
,`AppID` int(200)
,`PatientID` int(11)
,`AppDate` date
);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` int(25) NOT NULL,
  `fName` varchar(20) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Tel` int(11) DEFAULT NULL,
  `Email` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `fName`, `lName`, `DOB`, `Address`, `Tel`, `Email`) VALUES
(1, 'Vladimir', 'Lenin', '1995-09-04', '245 Bolshevik Avenue, Galway', 894453332, 'bolshevik1@revo'),
(2, 'Josef', 'Stalin', '1999-08-22', '456 Fake St Galway', 774443222, 'jstalin@gmail.c'),
(3, 'Leon', 'Trotsky', '1994-09-23', '123 Fake St Cork', 887799787, 'trotsk420@gmail'),
(4, 'Fidel ', 'Castro', '1980-05-23', '123 Fake St Ennis', 887799787, 'bayofpigs@gmail'),
(5, 'Aleksandr', 'Ulyanov', '1984-09-23', '123 Fake St Cork', 9984432, 'alek4lyf@gmail.'),
(6, 'Aleksandr', 'Nikolayevich,', '1954-06-23', '1453 Fake St Cork', 893342211, '`king3@gmail.co'),
(7, 'Peter', 'Kropotkin', '1999-09-23', '666 Devils Rd, Galway', 887794447, 'kropotkin0@gmai'),
(8, 'Mikhail', 'Bakunin', '1988-12-23', '999 Nine St, Co Galway', 833799787, 'anarchist420@gm'),
(9, 'Britney', 'Spears', '1955-09-23', '123 Fake St Cork', 844599787, 'itsbritney@gmai'),
(10, 'Leo', 'Varadkar', '1955-05-03', '56 Fake St Cork', 887000787, 'leov@gmail.com'),
(11, 'Christina', 'Agulera', '1993-09-23', '55 Fake St Cork', 887700997, 'ciggyaggy@gmail'),
(12, 'Noam', 'Chomsky', '1988-09-12', '23 Fake St Cork', 89988787, 'noamc@gmail.com'),
(13, 'Homer', 'Simpson', '1994-09-23', '1123 Fake St Cork', 88009907, 'homersimpson@gm');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentNo` int(100) NOT NULL,
  `BillNo` int(11) DEFAULT NULL,
  `PaymentType` varchar(100) NOT NULL,
  `Amount` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentNo`, `BillNo`, `PaymentType`, `Amount`) VALUES
(1, 1, 'Debit Card', '40.00'),
(2, 2, 'Cash', '25.00'),
(3, 3, 'Debit Card', '40.00'),
(5, 6, 'Debit Card', '25.00'),
(6, 9, 'Debit Card', '25.00'),
(7, 10, 'Cash', '25.00'),
(8, 8, 'Post', '20.00');

--
-- Triggers `payment`
--
DELIMITER $$
CREATE TRIGGER `payment_subtraction` AFTER INSERT ON `payment` FOR EACH ROW BEGIN
update `bill` 
set `Total` = `Total` - new.Amount where `BillNo` = new.BillNo;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `specialist`
--

CREATE TABLE `specialist` (
  `ClinicID` int(200) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Tel` int(11) NOT NULL,
  `Address` text NOT NULL,
  `SpecialTreat` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `specialist`
--

INSERT INTO `specialist` (`ClinicID`, `Email`, `Tel`, `Address`, `SpecialTreat`) VALUES
(1, 'orthospec@gmail.com', 2134567, '321 Dentist rd, Cork City, Cork', 'Crown Extraction'),
(2, 'dentistcork@gmail.com', 2155467, '789 Dentist rd, Cork City, Cork', 'Gum Transplant'),
(3, 'odento@gmail.com', 3566547, '321 Real st, Cork City, Cork', 'Jaw Protrusion Surgery'),
(4, 'dentorb@gmail.com', 2144444, '999 Dentist rd, Cork City, Cork', 'Periodontics surgery'),
(5, 'budgetteeth@gmail.com', 2133567, '321 Montenotti Cork City, Cork', 'Prosthodontics'),
(6, 'gnarburgers@gmail.com', 2134567, '666 Devil rd, Cork City, Cork', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `specialist_treatment`
--

CREATE TABLE `specialist_treatment` (
  `SpecialTreat` varchar(200) NOT NULL,
  `ClinicID` int(200) NOT NULL,
  `SpecialDet` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `specialist_treatment`
--

INSERT INTO `specialist_treatment` (`SpecialTreat`, `ClinicID`, `SpecialDet`) VALUES
('Crown Extraction', 1, 'Crown Extraction'),
('Gum Transplant', 2, 'Gum is transplanted from unhealthy to healthy part'),
('Jaw Protrusion Surgery', 3, 'Jaw is surgically protruded'),
('Periodontics surgery', 4, 'Periodontics (maintenance or treatment of the gums)'),
('Prosthodontics', 5, 'Prosthodontics (prosthetic dentistry)');

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `TreatmentName` varchar(200) NOT NULL,
  `Price` decimal(6,2) NOT NULL,
  `SpecialTreat` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `treatment`
--

INSERT INTO `treatment` (`TreatmentName`, `Price`, `SpecialTreat`) VALUES
('Braces', '200.00', NULL),
('Checkup', '40.00', NULL),
('Clean', '40.00', NULL),
('Filling', '50.00', NULL),
('Referral for Crown Extraction', '40.00', 'Crown Extraction'),
('Referral for Gum Transplant', '40.00', 'Gum Transplant'),
('Referral for Jaw Protrusion Surgery', '40.00', 'Jaw Protrusion Surgery'),
('Referral for Periodontics Surgery', '40.00', 'Periodontics surgery'),
('Referral for Prosthodontics', '40.00', 'Prosthodontics'),
('Root Canal', '200.00', NULL),
('Whitening', '75.00', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `upcoming_appointments`
-- (See below for the actual view)
--
CREATE TABLE `upcoming_appointments` (
`AppID` int(200)
,`Time` time
,`AppDate` date
,`PatientID` int(11)
,`lateCancellation` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `upcoming_treatments`
-- (See below for the actual view)
--
CREATE TABLE `upcoming_treatments` (
`TreatmentName` varchar(200)
,`AppID` int(200)
,`AppDate` date
);

-- --------------------------------------------------------

--
-- Structure for view `followups`
--
DROP TABLE IF EXISTS `followups`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `followups`  AS SELECT `appointment`.`AppID` AS `AppID` FROM `appointment` WHERE `appointment`.`followUp` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `galway_patients`
--
DROP TABLE IF EXISTS `galway_patients`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `galway_patients`  AS SELECT `patient`.`PatientID` AS `PatientID`, `patient`.`fName` AS `fName`, `patient`.`lName` AS `lName`, `patient`.`Address` AS `Address` FROM `patient` WHERE `patient`.`Address` like '%Galway%' ;

-- --------------------------------------------------------

--
-- Structure for view `large_bills`
--
DROP TABLE IF EXISTS `large_bills`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `large_bills`  AS SELECT `bill`.`BillNo` AS `BillNo`, `appointment`.`AppID` AS `AppID`, `appointment`.`PatientID` AS `PatientID`, `bill`.`Total` AS `Total` FROM (`bill` join `appointment` on(`bill`.`AppID` = `appointment`.`AppID`)) WHERE `bill`.`Total` > 200 ;

-- --------------------------------------------------------

--
-- Structure for view `overdue_payments`
--
DROP TABLE IF EXISTS `overdue_payments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `overdue_payments`  AS SELECT `bill`.`BillNo` AS `BillNo`, `appointment`.`AppID` AS `AppID`, `appointment`.`PatientID` AS `PatientID`, `appointment`.`AppDate` AS `AppDate` FROM (`bill` join `appointment` on(`bill`.`AppID` = `appointment`.`AppID`)) WHERE to_days(curdate()) - to_days(`appointment`.`AppDate`) > 30 ;

-- --------------------------------------------------------

--
-- Structure for view `upcoming_appointments`
--
DROP TABLE IF EXISTS `upcoming_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `upcoming_appointments`  AS SELECT `appointment`.`AppID` AS `AppID`, `appointment`.`Time` AS `Time`, `appointment`.`AppDate` AS `AppDate`, `appointment`.`PatientID` AS `PatientID`, `appointment`.`lateCancellation` AS `lateCancellation` FROM `appointment` WHERE to_days(curdate()) - to_days(`appointment`.`AppDate`) < 0 ;

-- --------------------------------------------------------

--
-- Structure for view `upcoming_treatments`
--
DROP TABLE IF EXISTS `upcoming_treatments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `upcoming_treatments`  AS SELECT `appointmentdet`.`TreatmentName` AS `TreatmentName`, `appointment`.`AppID` AS `AppID`, `appointment`.`AppDate` AS `AppDate` FROM (`appointmentdet` join `appointment` on(`appointmentdet`.`AppNo` = `appointment`.`AppID`)) WHERE to_days(curdate()) - to_days(`appointment`.`AppDate`) < 30 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`AppID`),
  ADD KEY `PatientID` (`PatientID`);

--
-- Indexes for table `appointmentdet`
--
ALTER TABLE `appointmentdet`
  ADD PRIMARY KEY (`TreatmentName`,`AppNo`),
  ADD KEY `AppNo` (`AppNo`);

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`BillNo`),
  ADD KEY `PatientID` (`PatientID`),
  ADD KEY `AppID` (`AppID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentNo`),
  ADD KEY `BillNo` (`BillNo`);

--
-- Indexes for table `specialist`
--
ALTER TABLE `specialist`
  ADD PRIMARY KEY (`ClinicID`),
  ADD KEY `SpecialTreat` (`SpecialTreat`);

--
-- Indexes for table `specialist_treatment`
--
ALTER TABLE `specialist_treatment`
  ADD PRIMARY KEY (`SpecialTreat`),
  ADD KEY `ClinicID` (`ClinicID`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`TreatmentName`),
  ADD KEY `SpecialTreat` (`SpecialTreat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `AppID` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `bill`
--
ALTER TABLE `bill`
  MODIFY `BillNo` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `PatientID` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `specialist`
--
ALTER TABLE `specialist`
  MODIFY `ClinicID` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);

--
-- Constraints for table `appointmentdet`
--
ALTER TABLE `appointmentdet`
  ADD CONSTRAINT `appointmentdet_ibfk_1` FOREIGN KEY (`AppNo`) REFERENCES `appointment` (`AppID`),
  ADD CONSTRAINT `appointmentdet_ibfk_2` FOREIGN KEY (`TreatmentName`) REFERENCES `treatment` (`TreatmentName`),
  ADD CONSTRAINT `fk_TreatmentName` FOREIGN KEY (`TreatmentName`) REFERENCES `treatment` (`TreatmentName`);

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`),
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`AppID`) REFERENCES `appointment` (`AppID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`BillNo`) REFERENCES `bill` (`BillNo`);

--
-- Constraints for table `specialist`
--
ALTER TABLE `specialist`
  ADD CONSTRAINT `specialist_ibfk_1` FOREIGN KEY (`SpecialTreat`) REFERENCES `specialist_treatment` (`SpecialTreat`);

--
-- Constraints for table `specialist_treatment`
--
ALTER TABLE `specialist_treatment`
  ADD CONSTRAINT `specialist_treatment_ibfk_1` FOREIGN KEY (`ClinicID`) REFERENCES `specialist` (`ClinicID`);

--
-- Constraints for table `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`SpecialTreat`) REFERENCES `specialist_treatment` (`SpecialTreat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
