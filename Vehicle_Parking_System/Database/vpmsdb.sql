CREATE DATABASE vpmsdb;
USE vpmsdb;

CREATE TABLE `membership_card` (
  `member_id` int(11) NOT NULL,
  `member_name` varchar(100) NOT NULL,
  `membership_card_number` varchar(20) NOT NULL,
  `membership_expiry` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membership_card`
--

INSERT INTO `membership_card` (`member_id`, `member_name`, `membership_card_number`, `membership_expiry`) VALUES
(1, 'Raghu Vamsi', '1234-5678-9012', '2025-12-19');

-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

CREATE TABLE `tbladmin` (
  `ID` int(11) NOT NULL,
  `AdminName` varchar(120) DEFAULT NULL,
  `UserName` varchar(120) DEFAULT NULL,
  `MobileNumber` bigint(20) DEFAULT NULL,
  `Email` varchar(200) DEFAULT NULL,
  `Password` varchar(120) DEFAULT NULL,
  `adminregdate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`ID`, `AdminName`, `UserName`, `MobileNumber`, `Email`, `Password`, `adminregdate`) VALUES
(1, 'Vinay Reddy', 'admin', 908765432, 'admin@gmail.com', 'admin123', '2024-12-14 09:44:09');

-- --------------------------------------------------------

--
-- Table structure for table `tblcategory`
--

CREATE TABLE `tblcategory` (
  `ID` int(11) NOT NULL,
  `VehicleCat` varchar(120) DEFAULT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblcategory`
--

INSERT INTO `tblcategory` (`ID`, `VehicleCat`, `CreationDate`) VALUES
(1, 'Six Wheeler Vehicles', '2025-01-22 15:01:49'),
(2, 'Four Wheeler Vehicle', '2025-01-22 15:02:10'),
(3, 'Two Wheeler Vehicle', '2025-01-22 15:02:22'),
(4, 'Three Wheeler Vehicle', '2025-01-22 15:02:22'),
(5, 'Bicycles', '2025-01-22 15:02:39');

-- --------------------------------------------------------

--
-- Table structure for table `tblparkingseatcapacity`
--

CREATE TABLE `tblparkingseatcapacity` (
  `parking_seat` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblparkingseatcapacity`
--

INSERT INTO `tblparkingseatcapacity` (`parking_seat`) VALUES
(25);

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(400) DEFAULT NULL,
  `uname` varchar(45) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`id`, `fullname`, `mobile`, `email`, `address`, `uname`, `password`) VALUES
(1, 'Raghu Vamsi', '7276763516', 'raghu@gmail.com', 'Hyderabad,Telangana', 'raghu', 'user123'),
(2, 'Patidhar', '7278487576', 'patidhar@gmail.com', 'Anantapur,Andhra Pradesh', 'patidhar', 'user123'),
(3, 'Arun', '8275684132', 'arun@gmail.com', 'Chennai, TamilNadu', 'arun', 'user123'),
(5, 'Govind', '9856321478', 'govind@gmail.com', 'Ooty, Kerala.', 'govind', 'user123'),
(6, 'Kohli', '8855223369', 'kohli@gmail.com', 'Banglore,Karnataka', 'kohli', 'user123');

-- --------------------------------------------------------

--
-- Table structure for table `tblvehicle`
--

CREATE TABLE `tblvehicle` (
  `ID` int(11) NOT NULL,
  `ParkingNumber` varchar(120) DEFAULT NULL,
  `VehicleCategory` varchar(120) NOT NULL,
  `VehicleCompanyname` varchar(120) DEFAULT NULL,
  `RegistrationNumber` varchar(120) DEFAULT NULL,
  `OwnerName` varchar(120) DEFAULT NULL,
  `OwnerContactNumber` bigint(20) DEFAULT NULL,
  `InTime` timestamp NULL DEFAULT current_timestamp(),
  `OutTime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `parkingcharge` varchar(120) DEFAULT NULL,
  `remark` mediumtext DEFAULT NULL,
  `status` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tblvehicle`
--

INSERT INTO `tblvehicle` (`ID`, `ParkingNumber`, `VehicleCategory`, `VehicleCompanyname`, `RegistrationNumber`, `OwnerName`, `OwnerContactNumber`, `InTime`, `OutTime`, `parkingcharge`, `remark`, `status`) VALUES
(1, '9523521', 'Bicycles', 'Atlas', 'AT-255266', 'Raghu Vamsi', 9404308673, '2025-01-23 14:10:33', '2025-01-28 05:52:54', '12', 'NA', 'Out'),
(2, '7100365', 'Four Wheeler Vehicle', 'Innova', 'INO-256347', 'Patidhar', 7276763516, '2025-01-23 14:12:59', '2025-01-25 05:53:11', '120', 'NA', 'Out'),
(3, '1648760', 'Bicycles', 'Activa', 'AC-255288', 'Arun', 8258631478, '2025-01-23 02:15:00', '2025-01-23 05:53:22', '12', 'NA', 'Out'),
(5, '4285240', 'Two Wheeler Vehicle', 'Activa', 'AC-585263', 'Govind', 7456893516, '2025-01-24 03:03:17', '2025-02-03 05:53:31', '45', 'NA', 'Out'),
(7, '7460074', 'Six Wheeler Vehicles', 'Hero Honda', 'HR-252369', 'Kohli', 8258631478, '2025-01-24 09:51:37', '2025-03-02 05:53:41', '150', 'NA', 'Out'),
(10, '1377145', 'Four Wheeler Vehicle', 'TATA', 'TA-258698', 'Arvind', 9874563210, '2025-01-09 01:17:43', '2025-01-09 05:53:52', '30', 'NA', 'Out'),
(11, '4665807', 'Six Wheeler Vehicles', 'tata', 'ap27bj4112', 'vasantha rao', 9182249086, '2024-12-02 07:37:30', NULL, NULL, NULL, ''),
(12, '3235059', 'Six Wheeler Vehicles', 'range rver', 'ap27bj4112', 'Raghu Vamsi', 7276763516, '2024-12-11 03:45:13', NULL, NULL, NULL, ''),
(13, '2393742', 'Six Wheeler Vehicles', 'range rver', 'ap27bj4112', 'Raghu Vamsi', 7276763516, '2024-12-11 16:59:42', NULL, NULL, NULL, '');