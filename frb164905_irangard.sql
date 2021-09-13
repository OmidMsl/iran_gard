-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2021 at 10:20 PM
-- Server version: 5.5.62-cll-lve
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
-- Database: `frb164905_irangard`
--

-- --------------------------------------------------------

--
-- Table structure for table `tour`
--

CREATE TABLE `tour` (
  `id` int(3) NOT NULL,
  `title` varchar(255) COLLATE utf8_persian_ci NOT NULL,
  `subtitle` varchar(1023) COLLATE utf8_persian_ci DEFAULT NULL,
  `startLocation` varchar(511) COLLATE utf8_persian_ci NOT NULL,
  `destination` varchar(511) COLLATE utf8_persian_ci NOT NULL,
  `categories` varchar(2047) COLLATE utf8_persian_ci NOT NULL,
  `capasity` int(3) NOT NULL,
  `registered` int(3) NOT NULL,
  `price` int(10) NOT NULL,
  `images` varchar(2047) COLLATE utf8_persian_ci DEFAULT NULL,
  `channelName` varchar(255) COLLATE utf8_persian_ci NOT NULL,
  `channelImage` varchar(2047) COLLATE utf8_persian_ci DEFAULT NULL,
  `isRegistered` tinyint(1) NOT NULL,
  `necessaryStuff` varchar(2047) COLLATE utf8_persian_ci DEFAULT NULL,
  `lastEvent` varchar(255) COLLATE utf8_persian_ci DEFAULT NULL,
  `date` varchar(31) COLLATE utf8_persian_ci NOT NULL,
  `lastEventTime` varchar(31) COLLATE utf8_persian_ci DEFAULT NULL,
  `numberOfNewEvents` int(3) NOT NULL,
  `duration` varchar(7) COLLATE utf8_persian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `tour`
--

INSERT INTO `tour` (`id`, `title`, `subtitle`, `startLocation`, `destination`, `categories`, `capasity`, `registered`, `price`, `images`, `channelName`, `channelImage`, `isRegistered`, `necessaryStuff`, `lastEvent`, `date`, `lastEventTime`, `numberOfNewEvents`, `duration`) VALUES
(1, 'تور کوه نوردی آبشار شوی', 'لوازم ضروری: کوله و ناهار\\nمدت زمان: 12 ساعت', 'دزفولlt32.362015lt48.409303', 'آبشار شویlt32.362015lt48.409303', 'کوه نوردی,', 30, 10, 200000, '1_shevi_1.jpeg,1_shevi_2.jpeg,1_shevi_3.jpg,1_shevi_4.jpeg,', 'dezful tourism', '1_dezful_tourism.jpg', 1, 'کوله ، ناهار و ابزار کوه نوردی دلخواه', '24 ساعت مانده به شروع حرکت', '1400 7 25 12 30', '1400 6 5 12 30', 3, '0 12'),
(2, 'تور طبیعت گردی دریاچه سد دز', 'لوازم ضروری: شام و ناهار\\nمدت زمان: 8 ساعت', 'دزفولlt32.378181lt48.418573', 'دریاچه پامنارlt32.378181lt48.418573', 'طبیعت گردی,', 30, 0, 150000, '2_shahyoun_1.jpg,2_shahyoun_2.jpg,2_shahyoun_3.jpg,', 'dezful tourism', '2_dezful_tourism.jpg', 0, 'کفش مناسب', 'رضا: سلام', '1400 7 20 12 30', '1400 6 1 16 55', 0, '0 8');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `phoneNumber` varchar(13) COLLATE utf8_persian_ci NOT NULL,
  `id` varchar(127) COLLATE utf8_persian_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_persian_ci NOT NULL,
  `isLeader` tinyint(1) NOT NULL,
  `image` varchar(1023) COLLATE utf8_persian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`phoneNumber`, `id`, `name`, `isLeader`, `image`) VALUES
('+989162541236', 'ali71', 'علی رضایی', 1, '989162541236_user_2.jpeg'),
('+989162698741', 'mmdRza', 'محمدرضا عباسی', 0, '989162698741_user_1.jpeg'),
('+989163214569', 'karimi_farhad', 'farhad karimi', 0, '989163214569_user_4.jpeg'),
('+989352147896', 'mohammmmad', 'محمد رضایی', 1, '989352147896_user_3.jpeg'),
('+989372589632', 'dvd_zrf', 'داوود ظریف', 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tour`
--
ALTER TABLE `tour`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`phoneNumber`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tour`
--
ALTER TABLE `tour`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
