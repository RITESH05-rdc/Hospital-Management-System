-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2024 at 12:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dotor`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `aemail` varchar(255) NOT NULL,
  `apassword` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`aemail`, `apassword`) VALUES
('admin@dotor.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appoid` int(11) NOT NULL,
  `Pid` int(11) NOT NULL,
  `Did` int(11) NOT NULL,
  `ScheduleID` int(11) NOT NULL,
  `Appodate` date NOT NULL,
  `Appotime` time NOT NULL,
  `Appostatus` varchar(100) NOT NULL,
  `Appono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appoid`, `Pid`, `Did`, `ScheduleID`, `Appodate`, `Appotime`, `Appostatus`, `Appono`) VALUES
(24, 5, 6, 6, '2024-10-25', '09:45:00', 'Pending', 1),
(25, 4, 5, 5, '2024-10-24', '15:30:00', 'Pending', 1),
(26, 5, 5, 5, '2024-10-24', '15:30:00', 'Pending', 2),
(28, 4, 4, 4, '2024-10-23', '10:00:00', 'Completed', 1),
(29, 4, 4, 15, '2024-10-25', '16:30:00', 'Confirmed', 1),
(30, 5, 4, 4, '2024-10-23', '10:00:00', 'Pending', 2);

--
-- Triggers `appointment`
--
DELIMITER $$
CREATE TRIGGER `after_appointment_update` AFTER UPDATE ON `appointment` FOR EACH ROW BEGIN
    INSERT INTO appointment_audit (Appoid, OldStatus, NewStatus, ChangeDate)
    VALUES (OLD.Appoid, OLD.Appostatus, NEW.Appostatus, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_audit`
--

CREATE TABLE `appointment_audit` (
  `AuditID` int(11) NOT NULL,
  `Appoid` int(11) NOT NULL,
  `OldStatus` varchar(50) DEFAULT NULL,
  `NewStatus` varchar(50) DEFAULT NULL,
  `ChangeDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Deptno` int(11) NOT NULL,
  `Dname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Deptno`, `Dname`) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Name` varchar(100) DEFAULT NULL,
  `Did` int(11) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(50) NOT NULL,
  `Gender` char(6) NOT NULL,
  `Deptno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Name`, `Did`, `Email`, `Password`, `Gender`, `Deptno`) VALUES
('Dr. John Doe', 4, 'johndoe@example.com', '123', 'Male', 1),
('Dr. Jane Smith', 5, 'janesmith@example.com', 'password456', 'Female', 2),
('Dr. David Lee', 6, 'davidlee@example.com', 'password789', 'Male', 3),
(' RITESH CHARI', 9, 'chariritesh6@gmail.com', '123', 'Male', 2),
('rohit', 10, 'doc@dotor.com', '123', 'Male', 1);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_images`
--

CREATE TABLE `doctor_images` (
  `Did` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor_images`
--

INSERT INTO `doctor_images` (`Did`, `image_url`, `uploaded_at`) VALUES
(4, 'doctor_4.webp', '2024-10-28 02:17:03');

-- --------------------------------------------------------

--
-- Stand-in structure for view `doctor_schedule`
-- (See below for the actual view)
--
CREATE TABLE `doctor_schedule` (
`ScheduleID` int(11)
,`Scheduledate` date
,`Scheduletime` time
,`DoctorName` varchar(100)
,`DoctorEmail` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `medicalrecords`
--

CREATE TABLE `medicalrecords` (
  `Mid` int(11) NOT NULL,
  `Pid` int(11) DEFAULT NULL,
  `Did` int(11) DEFAULT NULL,
  `MDate` date NOT NULL,
  `Diagnosis` varchar(255) DEFAULT NULL,
  `Treatment` text DEFAULT NULL,
  `Report` text DEFAULT NULL,
  `Prescription` text DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicalrecords`
--

INSERT INTO `medicalrecords` (`Mid`, `Pid`, `Did`, `MDate`, `Diagnosis`, `Treatment`, `Report`, `Prescription`, `Notes`, `file_url`, `created_at`, `updated_at`) VALUES
(6, 4, 4, '2024-08-15', 'Hypertension', 'Prescribed daily exercise and a low-sodium diet', 'Report attached', 'Take medication twice daily', 'Follow-up in two weeks', '67208b0ddd8ef_Week 11 Final.pdf', '2024-10-28 03:39:23', '2024-10-29 07:13:17'),
(7, 4, 4, '2024-09-20', 'Diabetes Type 2', 'Started on insulin therapy', '', 'Inject insulin before meals', 'Monitor blood sugar daily', '67208af60693e_exp09.pdf', '2024-10-28 03:39:23', '2024-10-29 07:12:54'),
(11, 4, 4, '2024-10-18', 'Heart attack in kidney', 'Nimbu pani therapy', 'A+', 'Subah 5 baje utho', 'elvish bhaaaaiiiiii', 'Week 8 Final.pdf', '2024-10-29 07:15:19', '2024-10-29 07:15:19'),
(15, 5, 4, '2024-10-17', 'cancer', 'AB', 'A', 'MMl', '12ckd', 'simple19022024140551.pdf', '2024-10-29 07:21:50', '2024-10-29 07:21:50'),
(16, 5, 4, '2024-10-17', 'cancer', 'AB', 'A', 'MMl', '12ckd', 'simple19022024140551.pdf', '2024-10-29 07:22:16', '2024-10-29 07:22:16'),
(17, 5, 4, '2024-10-24', 'a', 's', 'e', 'edg', 'sddf', NULL, '2024-10-29 07:22:52', '2024-10-29 07:22:52'),
(18, 5, 4, '2024-10-19', 'cd', 'cv', 'dg', 'dd', 'ef', NULL, '2024-10-29 07:23:34', '2024-10-29 07:23:34'),
(20, 5, 4, '2024-10-19', 'Siya', 'chewing gum', 'height too big', 'glucose', 'sussy baka', NULL, '2024-10-29 07:25:25', '2024-10-29 07:25:25');

-- --------------------------------------------------------

--
-- Table structure for table `medical_record`
--

CREATE TABLE `medical_record` (
  `Mid` int(11) NOT NULL,
  `MDate` date NOT NULL,
  `Report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`Report`)),
  `Treatment` varchar(100) DEFAULT NULL,
  `Diagnose` varchar(100) DEFAULT NULL,
  `Pid` int(11) NOT NULL,
  `Did` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `Pid` int(11) NOT NULL,
  `Pname` varchar(50) NOT NULL,
  `pemail` varchar(50) DEFAULT NULL,
  `ppassword` varchar(50) DEFAULT NULL,
  `Gender` char(6) NOT NULL,
  `Age` int(11) NOT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Phone_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`Pid`, `Pname`, `pemail`, `ppassword`, `Gender`, `Age`, `Address`, `Phone_no`) VALUES
(1, 'John Doe', 'johndoe@gmail.com', '123', 'Male', 30, '123 Main St', '1234567890'),
(2, 'Jane Smith', 'janeSmith@gmail.com', '123', 'Female', 25, '456 Elm St', '9876543210'),
(3, 'Alice Johnson', 'alicejohnson@gmail.com', '123', 'Female', 40, '789 Oak St', '5555555555'),
(4, 'Rohit bobli', 'rohitbobli@gmail.com', '123', 'Male', 25, 'Kalay sanguem', '8459907764'),
(5, 'oggyy', 'patient@dotor.com', '123', 'Male', 21, 'Goa', '1234567890');

-- --------------------------------------------------------

--
-- Stand-in structure for view `patient_appointments`
-- (See below for the actual view)
--
CREATE TABLE `patient_appointments` (
`Appoid` int(11)
,`Appodate` date
,`Appotime` time
,`PatientName` varchar(50)
,`DoctorName` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `patient_images`
--

CREATE TABLE `patient_images` (
  `Pid` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_images`
--

INSERT INTO `patient_images` (`Pid`, `image_url`, `uploaded_at`) VALUES
(5, 'nice-chain-v0-h7ov1vujqs4d1.webp', '2024-10-27 08:19:23');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `Payment_id` int(11) NOT NULL,
  `Pid` int(11) NOT NULL,
  `Amount` int(11) DEFAULT NULL,
  `Pstatus` varchar(100) NOT NULL,
  `Payment_mode` varchar(20) NOT NULL,
  `appoid` int(11) DEFAULT NULL,
  `Did` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`Payment_id`, `Pid`, `Amount`, `Pstatus`, `Payment_mode`, `appoid`, `Did`, `created_at`, `updated_at`) VALUES
(1, 4, 1000, 'Pending', '', 28, 4, '2024-10-29 09:13:22', '2024-10-29 09:13:22'),
(2, 4, 2000, 'Paid', 'Debit Card', 29, 4, '2024-10-29 09:13:22', '2024-10-29 09:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `Scheduleid` int(11) NOT NULL,
  `Docid` int(11) NOT NULL,
  `Scheduledate` date NOT NULL,
  `Scheduletime` time NOT NULL,
  `Status` varchar(10) NOT NULL,
  `nop` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`Scheduleid`, `Docid`, `Scheduledate`, `Scheduletime`, `Status`, `nop`, `title`) VALUES
(4, 4, '2024-10-23', '10:00:00', 'Active', 20, 'heart disease'),
(5, 5, '2024-10-24', '15:30:00', 'Active', 50, 'cancer'),
(6, 6, '2024-10-25', '09:45:00', 'Active', 15, 'diabeties'),
(15, 4, '2024-10-25', '16:30:00', 'Inactive', 2, 'cataract'),
(17, 9, '2024-10-31', '08:00:00', 'Active', 10, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(255) NOT NULL,
  `usertype` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `usertype`) VALUES
('admin@dotor.com', 'a'),
('doc@dotor.com', 'd'),
('janeSmith@gmail.com', 'p'),
('johndoe@example.com', 'd'),
('patient@dotor.com', 'p'),
('rohitbobli@gmail.com', 'p');

-- --------------------------------------------------------

--
-- Structure for view `doctor_schedule`
--
DROP TABLE IF EXISTS `doctor_schedule`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doctor_schedule`  AS SELECT `s`.`Scheduleid` AS `ScheduleID`, `s`.`Scheduledate` AS `Scheduledate`, `s`.`Scheduletime` AS `Scheduletime`, `d`.`Name` AS `DoctorName`, `d`.`Email` AS `DoctorEmail` FROM (`schedule` `s` join `doctor` `d` on(`s`.`Docid` = `d`.`Did`)) ;

-- --------------------------------------------------------

--
-- Structure for view `patient_appointments`
--
DROP TABLE IF EXISTS `patient_appointments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `patient_appointments`  AS SELECT `a`.`appoid` AS `Appoid`, `a`.`Appodate` AS `Appodate`, `a`.`Appotime` AS `Appotime`, `p`.`Pname` AS `PatientName`, `d`.`Name` AS `DoctorName` FROM ((`appointment` `a` join `patient` `p` on(`a`.`Pid` = `p`.`Pid`)) join `doctor` `d` on(`a`.`Did` = `d`.`Did`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`aemail`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appoid`);

--
-- Indexes for table `appointment_audit`
--
ALTER TABLE `appointment_audit`
  ADD PRIMARY KEY (`AuditID`),
  ADD KEY `Appoid` (`Appoid`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Deptno`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Did`),
  ADD KEY `Deptno` (`Deptno`);

--
-- Indexes for table `doctor_images`
--
ALTER TABLE `doctor_images`
  ADD PRIMARY KEY (`Did`);

--
-- Indexes for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  ADD PRIMARY KEY (`Mid`),
  ADD KEY `fk_patient` (`Pid`),
  ADD KEY `fk_doctor` (`Did`);

--
-- Indexes for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD PRIMARY KEY (`Mid`),
  ADD KEY `Pid` (`Pid`),
  ADD KEY `Did` (`Did`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`Pid`);

--
-- Indexes for table `patient_images`
--
ALTER TABLE `patient_images`
  ADD PRIMARY KEY (`Pid`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`Payment_id`),
  ADD KEY `Pid` (`Pid`),
  ADD KEY `appoid` (`appoid`),
  ADD KEY `Did` (`Did`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`Scheduleid`),
  ADD KEY `Docid` (`Docid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appoid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `appointment_audit`
--
ALTER TABLE `appointment_audit`
  MODIFY `AuditID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `Deptno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `Did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  MODIFY `Mid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `Pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `Payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `Scheduleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_audit`
--
ALTER TABLE `appointment_audit`
  ADD CONSTRAINT `appointment_audit_ibfk_1` FOREIGN KEY (`Appoid`) REFERENCES `appointment` (`appoid`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`Deptno`) REFERENCES `department` (`Deptno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `doctor_images`
--
ALTER TABLE `doctor_images`
  ADD CONSTRAINT `doctor_images_ibfk_1` FOREIGN KEY (`Did`) REFERENCES `doctor` (`Did`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `medicalrecords`
--
ALTER TABLE `medicalrecords`
  ADD CONSTRAINT `fk_doctor` FOREIGN KEY (`Did`) REFERENCES `doctor` (`Did`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_patient` FOREIGN KEY (`Pid`) REFERENCES `patient` (`Pid`) ON DELETE CASCADE;

--
-- Constraints for table `medical_record`
--
ALTER TABLE `medical_record`
  ADD CONSTRAINT `medical_record_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `patient` (`Pid`),
  ADD CONSTRAINT `medical_record_ibfk_2` FOREIGN KEY (`Did`) REFERENCES `doctor` (`Did`);

--
-- Constraints for table `patient_images`
--
ALTER TABLE `patient_images`
  ADD CONSTRAINT `patient_images_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `patient` (`Pid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `patient` (`Pid`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`appoid`) REFERENCES `appointment` (`appoid`) ON DELETE SET NULL,
  ADD CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`Did`) REFERENCES `doctor` (`Did`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`Docid`) REFERENCES `doctor` (`Did`),
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`Docid`) REFERENCES `doctor` (`Did`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
