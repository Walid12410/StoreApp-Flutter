-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 15, 2024 at 08:22 PM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21712835_supermarke`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `city` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `phone_number`, `city`, `street`) VALUES
(17, '3758828', 'beirut', 'criss'),
(18, '35235', 'BEIRUT', 'WAD'),
(19, '12342', 'ja', 'awd'),
(20, '3251512', 'beirut', 'salim,slim'),
(21, '54656456', 'walid123579', 'w12'),
(22, '3125412', 'barja', 'aboali'),
(23, '125125', 'be', 'be'),
(24, '88990088', 'beirut', 's1'),
(25, '88990088', 'beirut', 's1');

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`CategoryID`, `CategoryName`) VALUES
(1, 'drinks'),
(2, 'milk & cheese'),
(3, 'canned products'),
(4, 'vagtables & friuts'),
(5, 'meats & chicken');

-- --------------------------------------------------------

--
-- Table structure for table `Items`
--

CREATE TABLE `Items` (
  `ItemID` int(11) NOT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `ItemName` varchar(255) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `CategoryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Items`
--

INSERT INTO `Items` (`ItemID`, `ImageURL`, `ItemName`, `Quantity`, `Price`, `CategoryID`) VALUES
(101, 'https://media.istockphoto.com/id/950630302/photo/realistic-3d-render-of-brussels-sprouts.webp?b=1&s=170667a&w=0&k=20&c=ptO_QixBOxbuQ77XmFF_OGaHNq58NDBMDzy4m7o7OUQ=', 'Cabbage', 100, 3.00, 4),
(102, 'https://media.istockphoto.com/id/1371559171/photo/romaine-lettuce-or-cos-lettuce-closeup-lactuca-sativa-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=adj6bZjYpZ9JWOM86lGbjBjtVwPBDOI8MLBVWzRvNfk=', 'lettuce', 100, 1.00, 4),
(103, 'https://media.istockphoto.com/id/1814497434/photo/orange-tomatto-from-the-garden.webp?b=1&s=170667a&w=0&k=20&c=Xc4H165GAG1_QASQqaStqdbAkvLKDF27KPj-GbK64Ko=', 'tomato', 100, 1.00, 4),
(104, 'https://media.istockphoto.com/id/1400280322/photo/cucumbers-at-the-weekly-market.webp?b=1&s=170667a&w=0&k=20&c=eqZhgVSH74VObkXLKKrLzXH-RokhmRyYYNAdOWp7IUI=', 'cucumber', 100, 2.00, 4),
(105, 'https://media.istockphoto.com/id/1364035705/photo/fresh-broccoli-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=TJZ_7CrjQigGSrZ_AwsUREy7MF0luYSNmKAt7bfcU0M=', 'broccoli', 100, 2.00, 4),
(106, 'https://media.istockphoto.com/id/1495108380/photo/a-plate-of-fresh-watermelon.webp?b=1&s=170667a&w=0&k=20&c=lzSrd0ez3a7RY0QNxpcffJfoC2JJXKN8VFZ9ridtheA=', 'watermelon', 100, 5.00, 4),
(107, 'https://media.istockphoto.com/id/184136023/photo/fresh-organic-strawberries.webp?b=1&s=170667a&w=0&k=20&c=SmMNnLRda9bfkLca3E8B-Bm76NQKN4daFLby7920XRY=', 'strawberry', 100, 6.00, 4),
(108, 'https://media.istockphoto.com/id/1335171979/photo/texture-background-from-a-large-number-of-raspberries.webp?b=1&s=170667a&w=0&k=20&c=D7glueSYhrq40SMP87_TFT0hH_jmSkjInd6YoWYsppk=', 'raspberry', 100, 3.00, 4),
(109, 'https://media.istockphoto.com/id/92033245/photo/pile-of-nectarines.webp?b=1&s=170667a&w=0&k=20&c=Kyneq-8CnMNpU6n04oZxMwh_7r8pm2AsGZSdraoL_7A=', 'nectarine', 100, 4.00, 4),
(110, 'https://media.istockphoto.com/id/482078328/photo/orange-background.webp?b=1&s=170667a&w=0&k=20&c=giCU3Op92iLgxX4FcI52QS25gSCLeyzSNVvi6e1MmBM=', 'orange', 100, 2.00, 4),
(111, 'https://media.istockphoto.com/id/183819782/photo/glass-of-milk-isolated.webp?b=1&s=170667a&w=0&k=20&c=9mzreCWtU-fe7vBjifMgSLZvlrJuaPJnrFiNmREZO-U=', 'milk', 100, 2.00, 2),
(112, 'https://media.istockphoto.com/id/1088692316/photo/piece-of-hard-orange-cheddar-cheese-close-up.jpg?s=612x612&w=0&k=20&c=aiCVpzR8FNtZ6eIw2sjYUe_ZqTD1gDZGtIq4Q6vpiQs=', 'mozzorella', 100, 5.00, 2),
(113, 'https://media.istockphoto.com/id/479095932/photo/greek-feta-cheese-block-isolated-on-white.webp?b=1&s=170667a&w=0&k=20&c=Aee1Z2TvRW32ObAtcbKxSOmvv-PgpO4DYa0fig-croY=', 'feta', 100, 3.00, 2),
(114, 'https://media.istockphoto.com/id/148985963/photo/camembert-cheese.webp?b=1&s=170667a&w=0&k=20&c=QkK0yNaeqovmAudA8wVhxd81iHnY0JQ5tV-T2EUgqZM=', 'brie', 100, 4.00, 2),
(116, 'https://media.istockphoto.com/id/1171137533/photo/preparing-stuffed-turkey-for-holidays-in-domestic-kitchen.webp?b=1&s=170667a&w=0&k=20&c=GIMaZSZfioBsJmORQFSGcaaxhKtFRItImQEhWfEhIqo=', 'turkey', 100, 15.00, 5),
(117, 'https://media.istockphoto.com/id/1135916785/photo/times-fat.webp?b=1&s=170667a&w=0&k=20&c=iZnwWahNLZaet7k-bJS645qUTpCuQTWQasmPEKsnMEs=', 'duck', 100, 12.00, 5),
(118, 'https://media.istockphoto.com/id/1226983928/photo/christmas-eve-feast-on-dining-table.webp?b=1&s=170667a&w=0&k=20&c=1P1j9RQLU8lQMeNleaaZgJ5FlVpIaDLFb6I9D-i_Wl8=', 'goose', 100, 11.00, 5),
(119, 'https://media.istockphoto.com/id/1362359766/photo/fiorentina-t-bone-steak-cut-on-rectangular-wooden-chopping-board-and-vegetables.webp?b=1&s=170667a&w=0&k=20&c=ASOHvTJ-fmU2SBpYsuedGoP6sCMs9OO99t_g7xKlmwY=', 'bison meat', 100, 14.00, 5),
(120, 'https://media.istockphoto.com/id/1219390464/photo/raw-lamb-on-wood.webp?b=1&s=170667a&w=0&k=20&c=nCCIOjlX0xz1Sfm5EhNPTv4pmhoFlPcG9LvAdL2NsG8=', 'mutton', 100, 16.00, 5),
(121, 'https://media.istockphoto.com/id/182695901/photo/very-raw-looking-venison-steak.webp?b=1&s=170667a&w=0&k=20&c=VyPcZKy5Za48-tGxVoi3NaGAWEZQfG6WZ4xsiR8FkZc=', 'venison', 100, 18.00, 5),
(122, 'https://images.unsplash.com/photo-1629203851122-3726ecdf080e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVwc2l8ZW58MHx8MHx8fDA%3D', 'pepsi', 100, 2.00, 1),
(123, 'https://images.unsplash.com/photo-1570526427001-9d80d114054d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cmVkYnVsbHxlbnwwfHwwfHx8MA%3D%3D', 'redbull', 100, 3.00, 1),
(124, 'https://images.unsplash.com/photo-1622766815178-641bef2b4630?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8N3VwfGVufDB8fDB8fHww', '7up', 100, 2.00, 1),
(126, 'https://media.istockphoto.com/id/155159214/photo/canned-tuna-chunks-in-a-bowl-garnished-with-tomatoes.webp?b=1&s=170667a&w=0&k=20&c=hWWppVzJKWZhiYWmMYfjDlVi0tvn7CbcC1Cui5u4yKs=', 'tuna', 100, 3.00, 3),
(127, 'https://media.istockphoto.com/id/1227562909/photo/coconut-milk-in-an-open-can.webp?b=1&s=170667a&w=0&k=20&c=A2PpsLQDGDfjNB0ML5RGA9qR5ZECSuhHqXnDmqZPKok=', 'coconut milk', 100, 3.00, 3),
(129, 'https://media.istockphoto.com/id/1168900649/photo/preparing-homemade-tomato-sauce.webp?b=1&s=170667a&w=0&k=20&c=Xez3coTq6k1H3oKXiQpt78ZkPTHwUzhsOjE6yg0yuz0=', 'enchilada sauce', 100, 7.00, 3),
(130, 'https://media.istockphoto.com/id/513650251/photo/pate-in-open-can.webp?b=1&s=170667a&w=0&k=20&c=fHVZSqLPEbgtiQ3kP8fym_20v_LrE-iW-2YdCXAHMek=', 'foie gras', 100, 8.00, 3),
(131, 'https://media.istockphoto.com/id/519309790/photo/pile-of-raw-basmati-rice-with-a-spoon.webp?b=1&s=170667a&w=0&k=20&c=xsVbDBBJaxAYv8Hmcsw7kPiXHIfuSaXbUCwPibJ6wxY=', 'rice', 100, 2.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(20) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `Name`, `Username`, `Password`) VALUES
(1, '0', 'awd', 'awd12'),
(2, '0', 'w13', 'w123'),
(3, '0', 'walid', 'walid12'),
(4, '0', 'walid', 'walid12'),
(5, '0', 'mohammad12', 'mohammad123'),
(6, '0', 'jallad102', 'wj10'),
(7, '0', 'hatoum', 'test'),
(8, '0', 'ousama', 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`ItemID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Items`
--
ALTER TABLE `Items`
  ADD CONSTRAINT `Items_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
