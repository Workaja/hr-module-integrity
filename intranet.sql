-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 03, 2017 at 05:53 
-- Server version: 10.1.19-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `intranet`
--

-- --------------------------------------------------------

--
-- Table structure for table `claim_kesehatan`
--

CREATE TABLE `claim_kesehatan` (
  `id` int(11) NOT NULL,
  `no_claim` varchar(9) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `tgl_claim` date DEFAULT NULL,
  `total_biaya` int(11) DEFAULT NULL,
  `diajukan_oleh` varchar(30) DEFAULT NULL,
  `diajukan_tgl` date DEFAULT NULL,
  `disetujui_oleh` varchar(30) DEFAULT NULL,
  `disetujui_tgl` date DEFAULT NULL,
  `dibayar_oleh` varchar(30) DEFAULT NULL,
  `dibayar_tgl` date DEFAULT NULL,
  `ditolak_oleh` varchar(30) DEFAULT NULL,
  `ditolak_tgl` date DEFAULT NULL,
  `ditolak_note` varchar(255) DEFAULT NULL,
  `status_dok` enum('DRAFT','APPROVED','REJECTED','PAID') DEFAULT 'DRAFT',
  `dokumen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `claim_kesehatan`
--

INSERT INTO `claim_kesehatan` (`id`, `no_claim`, `username`, `tgl_claim`, `total_biaya`, `diajukan_oleh`, `diajukan_tgl`, `disetujui_oleh`, `disetujui_tgl`, `dibayar_oleh`, `dibayar_tgl`, `ditolak_oleh`, `ditolak_tgl`, `ditolak_note`, `status_dok`, `dokumen`) VALUES
(1, 'KS-160000', 'core', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'KS-160002', 'hans', '2016-10-19', 85000, 'hans', '2016-10-19', 'Nancy', NULL, 'Kurniawati', NULL, 'nancy', '2016-12-25', NULL, 'REJECTED', NULL),
(4, 'KS-160003', 'rizki', '2016-10-20', 350000, 'rizki', '2016-10-20', 'nancy', '2016-12-25', '', '2016-12-25', NULL, NULL, NULL, 'PAID', 'media/docs/KS-160003_1476925927.pdf'),
(5, 'KS-160004', 'hans', '2016-10-20', 70000, 'hans', '2016-10-20', 'nancy', '2016-12-25', '', '2016-12-25', NULL, NULL, NULL, 'PAID', NULL),
(6, 'KS-160005', 'rizki', '2016-12-13', 3000, 'rizki', '2016-12-13', 'Nancy', NULL, 'Kurniawati', NULL, 'nancy', '2016-12-25', NULL, 'REJECTED', NULL),
(10, 'KS-160006', 'nancy', '2016-12-25', 7500, 'nancy', '2016-12-25', 'nancy', '2016-12-25', '', '2016-12-25', NULL, NULL, NULL, 'PAID', 'claimdocs/nancy/Selection_002.png'),
(11, 'KS-160007', 'nancy', '2016-12-27', 1500000, 'nancy', '2016-12-27', 'nancy', NULL, 'nia', NULL, NULL, NULL, NULL, 'DRAFT', 'claimdocs/nancy/unnamed.jpg');

--
-- Triggers `claim_kesehatan`
--
DELIMITER $$
CREATE TRIGGER `delete claim` AFTER DELETE ON `claim_kesehatan` FOR EACH ROW DELETE FROM claim_kesehatan_detail 
WHERE claim_kesehatan_detail.no_claim =
old.no_claim
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `claim_kesehatan_detail`
--

CREATE TABLE `claim_kesehatan_detail` (
  `id` int(11) NOT NULL,
  `no_claim` varchar(9) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `jenis_biaya` varchar(250) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `bon` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `claim_kesehatan_detail`
--

INSERT INTO `claim_kesehatan_detail` (`id`, `no_claim`, `tgl`, `jenis_biaya`, `jumlah`, `bon`) VALUES
(3, 'KS-160002', '2016-10-19', 'Makan siang', 85000, 'N'),
(4, 'KS-160003', '2016-10-20', 'Lensa Esilor min 100', 175000, 'Y'),
(5, 'KS-160003', '2016-10-20', 'Lensa Esilor min 95', 175000, 'Y'),
(6, 'KS-160004', '2016-10-20', 'Grab car Office - Sudirman', 70000, 'N'),
(7, 'KS-160005', '2016-12-14', 'Biskuit Sikut Marmut', 3000, 'Y'),
(20, 'KS-160006', '2016-12-21', 'Paramex', 4000, 'N'),
(21, 'KS-160006', '2016-12-22', 'Inzana', 3500, 'Y'),
(22, 'KS-160007', '2016-12-28', 'Periksa + Bolongin Kaca Mata', 1500000, 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `cuti_jenis`
--

CREATE TABLE `cuti_jenis` (
  `id` int(11) NOT NULL,
  `periode` int(11) NOT NULL,
  `jenis_cuti` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cuti_jenis`
--

INSERT INTO `cuti_jenis` (`id`, `periode`, `jenis_cuti`) VALUES
(1, 2016, 'Sisa Ijin Masuk Kerja Tahun 2015'),
(2, 2016, 'Ijin Masuk Kerja Tahun 2016'),
(3, 2016, 'Sisa Cuti Tahun 2015'),
(4, 2016, 'Cuti Tahun 2016'),
(5, 2016, 'Cuti Sakit'),
(6, 2016, 'Cuti Menikah'),
(7, 2016, 'Cuti Menikahkan Anak'),
(8, 2016, 'Cuti Mengkhitankan/Membaptiskan Anak'),
(9, 2016, 'Cuti Melahirkan'),
(10, 2016, 'Cuti Anggota Keluarga Meninggal Dunia (suami/istri, orang tua, anak)'),
(11, 2016, 'Cuti Anggota Keluarga Serumah Meninggal Dunia');

-- --------------------------------------------------------

--
-- Table structure for table `cuti_log`
--

CREATE TABLE `cuti_log` (
  `id` int(11) NOT NULL,
  `no_claim` varchar(9) NOT NULL,
  `user` varchar(255) NOT NULL,
  `tgl_input` datetime NOT NULL,
  `totaldate` float NOT NULL,
  `tgl_cuti_from` date NOT NULL,
  `tgl_cuti_to` date NOT NULL,
  `tgl_list_used` varchar(5000) NOT NULL,
  `periode` int(11) NOT NULL,
  `jenis_cuti` varchar(64) NOT NULL,
  `emergency` varchar(18) NOT NULL,
  `note` varchar(255) NOT NULL,
  `escalated_to` varchar(64) DEFAULT NULL,
  `approved_by` varchar(64) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `rejected_by` varchar(64) DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `claim_note` varchar(255) DEFAULT NULL,
  `status` enum('DRAFT','APPROVED','REJECTED') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cuti_log`
--

INSERT INTO `cuti_log` (`id`, `no_claim`, `user`, `tgl_input`, `totaldate`, `tgl_cuti_from`, `tgl_cuti_to`, `tgl_list_used`, `periode`, `jenis_cuti`, `emergency`, `note`, `escalated_to`, `approved_by`, `approved_date`, `rejected_by`, `rejected_date`, `claim_note`, `status`) VALUES
(1, 'KC-000000', 'core', '2016-10-24 00:00:00', 2, '2016-11-10', '2016-11-10', '', 2016, '999', '123456', 'n/a', 'hans', NULL, NULL, NULL, NULL, NULL, 'DRAFT'),
(72, 'KC-160002', 'hans', '2016-11-30 08:20:44', 7.5, '2016-02-22', '2016-03-02', '2016-02-22,2016-02-23,2016-02-24,2016-02-25,2016-02-26,2016-02-29,2016-03-01,2016-03-02,', 2016, '4', '10101010', '12', 'edouard', NULL, NULL, NULL, NULL, NULL, 'DRAFT'),
(75, 'KC-160003', 'hans', '2016-11-30 08:26:51', 3, '2016-01-12', '2016-01-18', '2016-01-12,2016-01-13,2016-01-14,', 2016, '4', '10101010', '1', 'edouard', NULL, NULL, NULL, NULL, NULL, 'APPROVED'),
(80, 'KC-160004', 'rizki', '2016-12-01 19:16:43', 7, '2016-11-01', '2016-11-09', '2016-11-01,2016-11-02,2016-11-03,2016-11-04,2016-11-07,2016-11-08,2016-11-09,', 2016, '4', '10101010', '111', 'hans', NULL, NULL, NULL, NULL, NULL, 'APPROVED'),
(81, 'KC-160005', 'rizki', '2016-12-13 22:35:16', 3.5, '2016-12-13', '2016-12-16', '2016-12-13,2016-12-14,2016-12-15,', 2016, '4', '1', '1', 'hans', 'hans', '2016-12-13', NULL, NULL, 'oke', 'APPROVED'),
(82, 'KC-160006', 'rizki', '2016-12-13 22:35:34', 1.5, '2016-12-14', '2016-12-15', '2016-12-14,2016-12-15,', 2016, '4', '1', '1', 'hans', NULL, NULL, NULL, NULL, NULL, 'REJECTED'),
(83, 'KC-160007', 'rustam', '2016-12-13 22:37:01', 2, '2017-01-03', '2017-01-05', '2017-01-06,2017-01-09,', 2017, '7', '2', '2', 'edouard', 'edouard', NULL, NULL, NULL, NULL, 'APPROVED'),
(84, 'KC-160007', 'faisal', '2016-12-13 22:37:01', 2, '2016-12-23', '2016-12-26', '2017-01-06,2017-01-09,', 2016, '6', '2', '2', 'edouard', 'edouard', NULL, NULL, NULL, NULL, 'APPROVED'),
(87, 'KC-160010', 'indri', '2016-12-26 13:51:26', 3, '2016-12-29', '2017-01-02', '', 2016, '5', '021', '123', 'nancy', 'nancy', '2016-12-26', NULL, NULL, NULL, 'APPROVED'),
(89, 'KC-160011', 'rustam', '2016-12-26 18:27:06', 2, '2016-12-29', '2016-12-30', '', 2016, '5', '123', '123', 'soetarno', 'soetarno', '2016-12-26', NULL, NULL, NULL, 'APPROVED'),
(90, 'KC-160012', 'nancy', '2016-12-27 12:26:10', 0.5, '2016-12-28', '2016-12-28', '', 2016, '1', '021', '123456', 'edouard', 'edouard', '2016-12-27', NULL, NULL, NULL, 'APPROVED'),
(91, 'KC-160013', 'nancy', '2016-12-27 14:50:55', 1.5, '2016-12-22', '2016-12-23', '', 2016, '1', '123456', '123456', 'edouard', 'edouard', '2016-12-27', NULL, NULL, NULL, 'APPROVED'),
(92, 'KC-160014', 'indri', '2016-12-27 15:11:08', 2, '2016-12-28', '2016-12-29', '', 2016, '1', '4546', '646464', 'nancy', 'nancy', '2016-12-27', NULL, NULL, NULL, 'APPROVED');

-- --------------------------------------------------------

--
-- Table structure for table `cuti_periode`
--

CREATE TABLE `cuti_periode` (
  `id` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  `periode_start` date NOT NULL,
  `periode_end` date NOT NULL,
  `aktif` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cuti_quota`
--

CREATE TABLE `cuti_quota` (
  `id` int(11) NOT NULL,
  `nik` varchar(6) NOT NULL,
  `user` varchar(255) NOT NULL,
  `periode` int(11) NOT NULL DEFAULT '0',
  `quota_cuti` float NOT NULL DEFAULT '0',
  `cuti_terpakai` float NOT NULL DEFAULT '0',
  `quota_remainbefore` float DEFAULT '2',
  `quota_nonworkday` float DEFAULT '2',
  `quota_nonworkdaybefore` float DEFAULT '2',
  `quota_sick` float DEFAULT '2',
  `quota_wedding` float DEFAULT '2',
  `quota_wedding2` float DEFAULT '2',
  `quota_kidbless` float DEFAULT '2',
  `quota_maternity` float DEFAULT '2',
  `quota_internaldecease` float DEFAULT '2',
  `quota_onehomedecease` float DEFAULT '2'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cuti_quota`
--

INSERT INTO `cuti_quota` (`id`, `nik`, `user`, `periode`, `quota_cuti`, `cuti_terpakai`, `quota_remainbefore`, `quota_nonworkday`, `quota_nonworkdaybefore`, `quota_sick`, `quota_wedding`, `quota_wedding2`, `quota_kidbless`, `quota_maternity`, `quota_internaldecease`, `quota_onehomedecease`) VALUES
(1, 'INT131', 'rizki', 2016, 15, 3, 4, 7, 2, 0, 0, 0, 0, 0, 0, 0),
(2, 'INT070', 'nancy', 2016, 30, 0, 2, 2, 2, 1, 0, 6, 3, 3, 0, 0),
(3, 'INT147', 'hans', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(4, 'INT118', 'nia', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(5, 'INT001', 'edouard', 2016, 30, 0, 5, 5, 5, 1, 2, 3, 4, 5, 6, 7),
(6, 'INT004', 'rustam', 2016, 15, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0),
(7, 'INT005', 'faisal', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(8, 'INT006', 'andi', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(9, 'INT008', 'ngadimun', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(10, 'INT010', 'adiawan', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(11, 'INT014', 'chrismas', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(12, 'INT015', 'polycarpus', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(13, 'INT016', 'rahmad', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(14, 'INT017', 'weddy', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(15, 'INT022', 'niken', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(16, 'INT023', 'ghali', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(17, 'INT025', 'josep', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(18, 'INT026', 'siti', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(19, 'INT033', 'athar', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(20, 'INT034', 'imam', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(21, 'INT036', 'sri', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(22, 'INT038', 'marias', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(23, 'INT041', 'boy', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(24, 'INT043', 'misbakhudin', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(25, 'INT045', 'muchlis', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(26, 'INT047', 'marathur', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(27, 'INT048', 'rolus', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(28, 'INT050', 'nurwidi', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(29, 'INT053', 'nursalim', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(30, 'INT064', 'arif', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(31, 'INT067', 'haryoto', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(32, 'INT068', 'dipta', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(33, 'INT069', 'tri', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(34, 'INT077', 'agus', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(35, 'INT086', 'annisa', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(36, 'INT087', 'soetarno', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(37, 'INT088', 'loementa', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(38, 'INT089', 'essy', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(39, 'INT093', 'azhara', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(40, 'INT094', 'iskah', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(41, 'INT095', 'fizardin', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(42, 'INT099', 'ade', 2016, 15, 0, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0),
(43, 'INT100', 'sekar', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(44, 'INT102', 'ivan', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(45, 'INT103', 'indri', 2016, 15, 0, 2, 2, 2, 3, 0, 0, 0, 66, 0, 0),
(46, 'INT111', 'wartanto', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(47, 'INT109', 'rio', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(48, 'INT114', 'alimudin', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(49, 'INT120', 'dimas', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(50, 'INT123', 'halimah', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(51, 'INT124', 'agnes', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(52, 'INT125', 'djohan', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(53, 'INT126', 'eka', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(54, 'INT128', 'sauri', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(55, 'INT129', 'puteri', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(56, 'INT134', 'damanhuri', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(57, 'INT135', 'sohibu', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(58, 'INT136', 'nisma', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(59, 'INT137', 'dede', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(60, 'INT138', 'yanuar', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(61, 'INT139', 'tua', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(62, 'INT140', 'jodya', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(63, 'INT141', 'dillon', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(64, 'INT142', 'fira', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(65, 'INT143', 'lucky', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(66, 'INT146', 'sabta', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(67, 'INT148', 'hirson', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(68, 'INT149', 'stasya', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(69, 'INT150', 'ramses', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(70, 'INT151', 'rina', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(71, 'INT153', 'danang', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(72, 'INT154', 'ardy', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0),
(73, 'INT155', 'ariyanto', 2016, 15, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `daily_dollar`
--

CREATE TABLE `daily_dollar` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `konversi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `daily_dollar`
--

INSERT INTO `daily_dollar` (`id`, `tanggal`, `konversi`) VALUES
(1, '2016-12-26', 13000),
(3, '2016-12-27', 14000),
(4, '2017-01-10', 12000),
(5, '2017-01-11', 13000),
(6, '2017-01-12', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `email_list`
--

CREATE TABLE `email_list` (
  `nik` varchar(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0;1;'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `email_list`
--

INSERT INTO `email_list` (`nik`, `username`, `email`, `status`) VALUES
('INT001', 'edouard', 'edouard_notrealemail@integrity-asia.com', 1),
('INT004', 'rustam', 'rustam_notrealemail@integrity-asia.com', 1),
('INT005', 'faisal', 'faisal_notrealemail@integrity-asia.com', 1),
('INT006', 'andi', 'andi_notrealemail@integrity-asia.com', 1),
('INT008', 'ngadimun', 'ngadimun_notrealemail@integrity-asia.com', 1),
('INT010', 'adiawan', 'adiawan_notrealemail@integrity-asia.com', 1),
('INT014', 'chrismas', 'chrismas_notrealemail@integrity-asia.com', 1),
('INT015', 'polycarpus', 'polycarpus_notrealemail@integrity-asia.com', 1),
('INT016', 'rahmad', 'rahmad_notrealemail@integrity-asia.com', 1),
('INT017', 'weddy', 'weddy_notrealemail@integrity-asia.com', 1),
('INT022', 'niken', 'niken_notrealemail@integrity-asia.com', 1),
('INT023', 'ghali', 'ghali_notrealemail@integrity-asia.com', 1),
('INT025', 'josep', 'josep_notrealemail@integrity-asia.com', 1),
('INT026', 'siti', 'siti_notrealemail@integrity-asia.com', 1),
('INT033', 'athar', 'athar_notrealemail@integrity-asia.com', 1),
('INT034', 'imam', 'imam_notrealemail@integrity-asia.com', 1),
('INT036', 'sri', 'sri_notrealemail@integrity-asia.com', 1),
('INT038', 'marias', 'marias_notrealemail@integrity-asia.com', 1),
('INT041', 'boy', 'boy_notrealemail@integrity-asia.com', 1),
('INT043', 'misbakhudin', 'misbakhudin_notrealemail@integrity-asia.com', 1),
('INT045', 'muchlis', 'muchlis_notrealemail@integrity-asia.com', 1),
('INT047', 'marathur', 'marathur_notrealemail@integrity-asia.com', 1),
('INT048', 'rolus', 'rolus_notrealemail@integrity-asia.com', 1),
('INT050', 'nurwidi', 'nurwidi_notrealemail@integrity-asia.com', 1),
('INT053', 'nursalim', 'nursalim_notrealemail@integrity-asia.com', 1),
('INT064', 'arif', 'arif_notrealemail@integrity-asia.com', 1),
('INT067', 'haryoto', 'haryoto_notrealemail@integrity-asia.com', 1),
('INT068', 'dipta', 'dipta_notrealemail@integrity-asia.com', 1),
('INT069', 'tri', 'tri_notrealemail@integrity-asia.com', 1),
('INT070', 'nancy', 'nancy_notrealemail@integrity-asia.com', 1),
('INT077', 'agus', 'agus.supriyanto@integrity-indonesia.com', 1),
('INT086', 'annisa', 'annisa_notrealemail@integrity-asia.com', 1),
('INT087', 'soetarno', 'soetarno_notrealemail@integrity-asia.com', 1),
('INT088', 'loementa', 'loementa_notrealemail@integrity-asia.com', 1),
('INT089', 'essy', 'essy_notrealemail@integrity-asia.com', 1),
('INT093', 'azhara', 'azhara_notrealemail@integrity-asia.com', 1),
('INT094', 'iskah', 'iskah_notrealemail@integrity-asia.com', 1),
('INT095', 'fizardin', 'fizardin_notrealemail@integrity-asia.com', 1),
('INT099', 'ade', 'ade_notrealemail@integrity-asia.com', 1),
('INT100', 'sekar', 'sekar_notrealemail@integrity-asia.com', 1),
('INT102', 'ivan', 'ivan_notrealemail@integrity-asia.com', 1),
('INT103', 'indri', 'indri_notrealemail@integrity-asia.com', 1),
('INT109', 'rio', 'rio_notrealemail@integrity-asia.com', 1),
('INT111', 'wartanto', 'wartanto_notrealemail@integrity-asia.com', 1),
('INT114', 'alimudin', 'alimudin_notrealemail@integrity-asia.com', 1),
('INT118', 'nia', 'nia_notrealemail@integrity-asia.com', 1),
('INT120', 'dimas', 'dimas_notrealemail@integrity-asia.com', 1),
('INT123', 'halimah', 'halimah_notrealemail@integrity-asia.com', 1),
('INT124', 'agnes', 'agnes_notrealemail@integrity-asia.com', 1),
('INT125', 'djohan', 'djohan_notrealemail@integrity-asia.com', 1),
('INT126', 'eka', 'eka_notrealemail@integrity-asia.com', 1),
('INT128', 'sauri', 'sauri_notrealemail@integrity-asia.com', 1),
('INT129', 'puteri', 'puteri_notrealemail@integrity-asia.com', 1),
('INT131', 'rizki', 'muhammad.rizkiansyah@integrity-asia.com', 1),
('INT134', 'damanhuri', 'damanhuri_notrealemail@integrity-asia.com', 1),
('INT135', 'sohibu', 'sohibu_notrealemail@integrity-asia.com', 1),
('INT136', 'nisma', 'nisma_notrealemail@integrity-asia.com', 1),
('INT137', 'dede', 'dede_notrealemail@integrity-asia.com', 1),
('INT138', 'yanuar', 'yanuar_notrealemail@integrity-asia.com', 1),
('INT139', 'tua', 'tua_notrealemail@integrity-asia.com', 1),
('INT140', 'jodya', 'jodya_notrealemail@integrity-asia.com', 1),
('INT141', 'dillon', 'dillon_notrealemail@integrity-asia.com', 1),
('INT142', 'fira', 'fira_notrealemail@integrity-asia.com', 1),
('INT143', 'lucky', 'lucky_notrealemail@integrity-asia.com', 1),
('INT146', 'sabta', 'sabta_notrealemail@integrity-asia.com', 1),
('INT147', 'hans', 'hans_notrealemail@integrity-asia.com', 1),
('INT148', 'hirson', 'hirson_notrealemail@integrity-asia.com', 1),
('INT149', 'stasya', 'stasya_notrealemail@integrity-asia.com', 1),
('INT150', 'ramses', 'ramses_notrealemail@integrity-asia.com', 1),
('INT151', 'rina', 'rina_notrealemail@integrity-asia.com', 1),
('INT152', 'hendro', 'hendro_notrealemail@integrity-asia.com', 1),
('INT153', 'danang', 'danang_notrealemail@integrity-asia.com', 1),
('INT154', 'ardy', 'ardy_notrealemail@integrity-asia.com', 1),
('INT155', 'ariyanto', 'ariyanto_notrealemail@integrity-asia.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `extension_list`
--

CREATE TABLE `extension_list` (
  `nik` varchar(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `extension` varchar(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `extension_list`
--

INSERT INTO `extension_list` (`nik`, `username`, `extension`, `status`) VALUES
('INT001', 'edouard', '6000', 1),
('INT004', 'rustam', '-', 1),
('INT005', 'faisal', '-', 1),
('INT006', 'andi', '-', 1),
('INT008', 'ngadimun', '-', 1),
('INT010', 'adiawan', '-', 1),
('INT014', 'chrismas', '-', 1),
('INT015', 'polycarpus', '-', 1),
('INT016', 'rahmad', '-', 1),
('INT017', 'weddy', '-', 1),
('INT022', 'niken', '6034', 1),
('INT023', 'ghali', '-', 1),
('INT025', 'josep', '-', 1),
('INT026', 'siti', '-', 1),
('INT033', 'athar', '-', 1),
('INT034', 'imam', '-', 1),
('INT036', 'sri', '-', 1),
('INT038', 'marias', '-', 1),
('INT041', 'boy', '-', 1),
('INT043', 'misbakhudin', '-', 1),
('INT045', 'muchlis', '-', 1),
('INT047', 'marathur', '-', 1),
('INT048', 'rolus', '-', 1),
('INT050', 'nurwidi', '-', 1),
('INT053', 'nursalim', '-', 1),
('INT064', 'arif', '-', 1),
('INT067', 'haryoto', '-', 1),
('INT068', 'dipta', '6032', 1),
('INT069', 'tri', '-', 1),
('INT070', 'nancy', '6003', 1),
('INT077', 'agus', '6015', 1),
('INT086', 'annisa', '6019', 1),
('INT087', 'soetarno', '-', 1),
('INT088', 'loementa', '-', 1),
('INT089', 'essy', '6035', 1),
('INT093', 'azhara', '6129', 1),
('INT094', 'iskah', '-', 1),
('INT095', 'fizardin', '-', 1),
('INT099', 'ade', '-', 1),
('INT100', 'sekar', '6196', 1),
('INT102', 'ivan', '6033', 1),
('INT103', 'indri', '6161', 1),
('INT109', 'rio', '-', 1),
('INT111', 'wartanto', '-', 1),
('INT114', 'alimudin', '-', 1),
('INT118', 'nia', '6160', 1),
('INT120', 'dimas', '-', 1),
('INT123', 'halimah', '6124', 1),
('INT124', 'agnes', '-', 1),
('INT125', 'djohan', '-', 1),
('INT128', 'sauri', '6195', 1),
('INT129', 'puteri', '6128', 1),
('INT131', 'rizki', '9999', 1),
('INT134', 'damanhuri', '6030', 1),
('INT135', 'sohibu', '-', 1),
('INT136', 'nisma', '6001', 1),
('INT137', 'dede', '6123', 1),
('INT138', 'yanuar', '6036', 1),
('INT139', 'tua', '6031', 1),
('INT140', 'jodya', '-', 1),
('INT141', 'dillon', '-', 1),
('INT142', 'fira', '-', 1),
('INT143', 'lucky', '-', 1),
('INT146', 'sabta', '6007', 1),
('INT147', 'hans', '6012', 1),
('INT148', 'hirson', '6125', 1),
('INT149', 'stasya', '6121', 1),
('INT150', 'ramses', '6162', 1),
('INT151', 'rina', '6122', 1),
('INT152', 'hendro', '6037', 1),
('INT153', 'danang', '6120', 1),
('INT154', 'ardy', '-', 1),
('INT155', 'ariyanto', '6171', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inlieuoff_log`
--

CREATE TABLE `inlieuoff_log` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL,
  `inputdate` date NOT NULL,
  `type` varchar(4) NOT NULL,
  `startfrom` date NOT NULL,
  `untilto` date NOT NULL,
  `totaldate` smallint(6) NOT NULL,
  `escalateto` varchar(64) NOT NULL,
  `approved_date` date NOT NULL,
  `rejected_date` date NOT NULL,
  `status` enum('DRAFT','APPROVED','REJECTED') NOT NULL DEFAULT 'DRAFT'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inlieuoff_log`
--

INSERT INTO `inlieuoff_log` (`id`, `username`, `inputdate`, `type`, `startfrom`, `untilto`, `totaldate`, `escalateto`, `approved_date`, `rejected_date`, `status`) VALUES
(4, 'nancy', '2016-12-19', 'sick', '2016-12-20', '2016-12-20', 1, 'edouard', '2016-12-25', '0000-00-00', 'APPROVED'),
(5, 'nancy', '2016-12-19', 'wed2', '2016-12-22', '2016-12-29', 6, 'edouard', '2016-12-25', '0000-00-00', 'APPROVED'),
(6, 'nancy', '2016-12-20', 'bles', '2016-12-21', '2016-12-23', 3, 'edouard', '2016-12-25', '0000-00-00', 'APPROVED'),
(7, 'indri', '2016-12-20', 'sick', '2016-12-13', '2016-12-15', 3, 'nancy', '2016-12-20', '0000-00-00', 'APPROVED'),
(8, 'nia', '2016-12-25', 'sick', '2016-12-22', '2016-12-28', 5, 'edouard', '0000-00-00', '2016-12-25', 'REJECTED'),
(9, 'nia', '2016-12-25', 'sick', '2016-12-22', '2016-12-28', 5, 'edouard', '0000-00-00', '2016-12-25', 'REJECTED'),
(10, 'nia', '2016-12-25', 'sick', '2016-12-22', '2016-12-28', 5, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(11, 'nancy', '2016-12-25', '', '2016-12-22', '2016-12-30', 7, 'edouard', '2016-12-25', '0000-00-00', 'APPROVED'),
(12, 'nancy', '2016-12-25', 'mate', '2016-12-22', '2016-12-30', 7, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(13, 'nancy', '2016-12-25', 'mate', '2016-12-22', '2016-12-30', 7, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(14, 'nancy', '2016-12-25', 'mate', '2016-12-22', '2016-12-30', 7, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(15, 'nancy', '2016-12-25', 'mate', '2016-12-22', '2016-12-30', 7, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(16, 'nancy', '2016-12-25', 'wed2', '2016-12-01', '2016-12-31', 22, 'edouard', '0000-00-00', '0000-00-00', 'DRAFT'),
(17, 'indri', '2016-12-25', 'mate', '2017-01-02', '2017-04-03', 66, 'nancy', '2016-12-25', '0000-00-00', 'APPROVED'),
(18, 'rustam', '2016-12-26', 'sick', '2016-12-29', '2016-12-30', 2, 'soetarno', '2016-12-26', '0000-00-00', 'APPROVED'),
(19, 'nancy', '2016-12-27', 'mate', '2016-12-28', '2016-12-30', 3, 'edouard', '2016-12-27', '0000-00-00', 'APPROVED');

-- --------------------------------------------------------

--
-- Table structure for table `kalender`
--

CREATE TABLE `kalender` (
  `tanggal` date NOT NULL,
  `merah` enum('Y','N') DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `periode` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kalender`
--

INSERT INTO `kalender` (`tanggal`, `merah`, `keterangan`, `periode`) VALUES
('2016-01-01', 'N', NULL, NULL),
('2016-01-02', 'Y', NULL, NULL),
('2016-01-03', 'Y', NULL, NULL),
('2016-01-04', 'N', NULL, NULL),
('2016-01-05', 'N', NULL, NULL),
('2016-01-06', 'N', NULL, NULL),
('2016-01-07', 'N', NULL, NULL),
('2016-01-08', 'N', NULL, NULL),
('2016-01-09', 'Y', NULL, NULL),
('2016-01-10', 'Y', NULL, NULL),
('2016-01-11', 'N', NULL, NULL),
('2016-01-12', 'N', NULL, NULL),
('2016-01-13', 'N', NULL, NULL),
('2016-01-14', 'N', NULL, NULL),
('2016-01-15', 'N', NULL, NULL),
('2016-01-16', 'Y', NULL, NULL),
('2016-01-17', 'Y', NULL, NULL),
('2016-01-18', 'N', NULL, NULL),
('2016-01-19', 'N', NULL, NULL),
('2016-01-20', 'N', NULL, NULL),
('2016-01-21', 'N', NULL, NULL),
('2016-01-22', 'N', NULL, NULL),
('2016-01-23', 'Y', NULL, NULL),
('2016-01-24', 'Y', NULL, NULL),
('2016-01-25', 'N', NULL, NULL),
('2016-01-26', 'N', NULL, NULL),
('2016-01-27', 'N', NULL, NULL),
('2016-01-28', 'N', NULL, NULL),
('2016-01-29', 'N', NULL, NULL),
('2016-01-30', 'Y', NULL, NULL),
('2016-01-31', 'Y', NULL, NULL),
('2016-02-01', 'N', NULL, NULL),
('2016-02-02', 'N', NULL, NULL),
('2016-02-03', 'N', NULL, NULL),
('2016-02-04', 'N', NULL, NULL),
('2016-02-05', 'N', NULL, NULL),
('2016-02-06', 'Y', NULL, NULL),
('2016-02-07', 'Y', NULL, NULL),
('2016-02-08', 'N', NULL, NULL),
('2016-02-09', 'N', NULL, NULL),
('2016-02-10', 'N', NULL, NULL),
('2016-02-11', 'N', NULL, NULL),
('2016-02-12', 'N', NULL, NULL),
('2016-02-13', 'Y', NULL, NULL),
('2016-02-14', 'Y', NULL, NULL),
('2016-02-15', 'N', NULL, NULL),
('2016-02-16', 'N', NULL, NULL),
('2016-02-17', 'N', NULL, NULL),
('2016-02-18', 'N', NULL, NULL),
('2016-02-19', 'N', NULL, NULL),
('2016-02-20', 'Y', NULL, NULL),
('2016-02-21', 'Y', NULL, NULL),
('2016-02-22', 'N', NULL, NULL),
('2016-02-23', 'N', NULL, NULL),
('2016-02-24', 'N', NULL, NULL),
('2016-02-25', 'N', NULL, NULL),
('2016-02-26', 'N', NULL, NULL),
('2016-02-27', 'Y', NULL, NULL),
('2016-02-28', 'Y', NULL, NULL),
('2016-02-29', 'N', NULL, NULL),
('2016-03-01', 'N', NULL, NULL),
('2016-03-02', 'N', NULL, NULL),
('2016-03-03', 'N', NULL, NULL),
('2016-03-04', 'N', NULL, NULL),
('2016-03-05', 'Y', NULL, NULL),
('2016-03-06', 'Y', NULL, NULL),
('2016-03-07', 'N', NULL, NULL),
('2016-03-08', 'N', NULL, NULL),
('2016-03-09', 'N', NULL, NULL),
('2016-03-10', 'N', NULL, NULL),
('2016-03-11', 'N', NULL, NULL),
('2016-03-12', 'Y', NULL, NULL),
('2016-03-13', 'Y', NULL, NULL),
('2016-03-14', 'N', NULL, NULL),
('2016-03-15', 'N', NULL, NULL),
('2016-03-16', 'N', NULL, NULL),
('2016-03-17', 'N', NULL, NULL),
('2016-03-18', 'N', NULL, NULL),
('2016-03-19', 'Y', NULL, NULL),
('2016-03-20', 'Y', NULL, NULL),
('2016-03-21', 'N', NULL, NULL),
('2016-03-22', 'N', NULL, NULL),
('2016-03-23', 'N', NULL, NULL),
('2016-03-24', 'N', NULL, NULL),
('2016-03-25', 'N', NULL, NULL),
('2016-03-26', 'Y', NULL, NULL),
('2016-03-27', 'Y', NULL, NULL),
('2016-03-28', 'N', NULL, NULL),
('2016-03-29', 'N', NULL, NULL),
('2016-03-30', 'N', NULL, NULL),
('2016-03-31', 'N', NULL, NULL),
('2016-04-01', 'N', NULL, NULL),
('2016-04-02', 'Y', NULL, NULL),
('2016-04-03', 'Y', NULL, NULL),
('2016-04-04', 'N', NULL, NULL),
('2016-04-05', 'N', NULL, NULL),
('2016-04-06', 'N', NULL, NULL),
('2016-04-07', 'N', NULL, NULL),
('2016-04-08', 'N', NULL, NULL),
('2016-04-09', 'Y', NULL, NULL),
('2016-04-10', 'Y', NULL, NULL),
('2016-04-11', 'N', NULL, NULL),
('2016-04-12', 'N', NULL, NULL),
('2016-04-13', 'N', NULL, NULL),
('2016-04-14', 'N', NULL, NULL),
('2016-04-15', 'N', NULL, NULL),
('2016-04-16', 'Y', NULL, NULL),
('2016-04-17', 'Y', NULL, NULL),
('2016-04-18', 'N', NULL, NULL),
('2016-04-19', 'N', NULL, NULL),
('2016-04-20', 'N', NULL, NULL),
('2016-04-21', 'N', NULL, NULL),
('2016-04-22', 'N', NULL, NULL),
('2016-04-23', 'Y', NULL, NULL),
('2016-04-24', 'Y', NULL, NULL),
('2016-04-25', 'N', NULL, NULL),
('2016-04-26', 'N', NULL, NULL),
('2016-04-27', 'N', NULL, NULL),
('2016-04-28', 'N', NULL, NULL),
('2016-04-29', 'N', NULL, NULL),
('2016-04-30', 'Y', NULL, NULL),
('2016-05-01', 'Y', NULL, NULL),
('2016-05-02', 'N', NULL, NULL),
('2016-05-03', 'N', NULL, NULL),
('2016-05-04', 'N', NULL, NULL),
('2016-05-05', 'N', NULL, NULL),
('2016-05-06', 'N', NULL, NULL),
('2016-05-07', 'Y', NULL, NULL),
('2016-05-08', 'Y', NULL, NULL),
('2016-05-09', 'N', NULL, NULL),
('2016-05-10', 'N', NULL, NULL),
('2016-05-11', 'N', NULL, NULL),
('2016-05-12', 'N', NULL, NULL),
('2016-05-13', 'N', NULL, NULL),
('2016-05-14', 'Y', NULL, NULL),
('2016-05-15', 'Y', NULL, NULL),
('2016-05-16', 'N', NULL, NULL),
('2016-05-17', 'N', NULL, NULL),
('2016-05-18', 'N', NULL, NULL),
('2016-05-19', 'N', NULL, NULL),
('2016-05-20', 'N', NULL, NULL),
('2016-05-21', 'Y', NULL, NULL),
('2016-05-22', 'Y', NULL, NULL),
('2016-05-23', 'N', NULL, NULL),
('2016-05-24', 'N', NULL, NULL),
('2016-05-25', 'N', NULL, NULL),
('2016-05-26', 'N', NULL, NULL),
('2016-05-27', 'N', NULL, NULL),
('2016-05-28', 'Y', NULL, NULL),
('2016-05-29', 'Y', NULL, NULL),
('2016-05-30', 'N', NULL, NULL),
('2016-05-31', 'N', NULL, NULL),
('2016-06-01', 'N', NULL, NULL),
('2016-06-02', 'N', NULL, NULL),
('2016-06-03', 'N', NULL, NULL),
('2016-06-04', 'Y', NULL, NULL),
('2016-06-05', 'Y', NULL, NULL),
('2016-06-06', 'N', NULL, NULL),
('2016-06-07', 'N', NULL, NULL),
('2016-06-08', 'N', NULL, NULL),
('2016-06-09', 'N', NULL, NULL),
('2016-06-10', 'N', NULL, NULL),
('2016-06-11', 'Y', NULL, NULL),
('2016-06-12', 'Y', NULL, NULL),
('2016-06-13', 'N', NULL, NULL),
('2016-06-14', 'N', NULL, NULL),
('2016-06-15', 'N', NULL, NULL),
('2016-06-16', 'N', NULL, NULL),
('2016-06-17', 'N', NULL, NULL),
('2016-06-18', 'Y', NULL, NULL),
('2016-06-19', 'Y', NULL, NULL),
('2016-06-20', 'N', NULL, NULL),
('2016-06-21', 'N', NULL, NULL),
('2016-06-22', 'N', NULL, NULL),
('2016-06-23', 'N', NULL, NULL),
('2016-06-24', 'N', NULL, NULL),
('2016-06-25', 'Y', NULL, NULL),
('2016-06-26', 'Y', NULL, NULL),
('2016-06-27', 'N', NULL, NULL),
('2016-06-28', 'N', NULL, NULL),
('2016-06-29', 'N', NULL, NULL),
('2016-06-30', 'N', NULL, NULL),
('2016-07-01', 'N', NULL, NULL),
('2016-07-02', 'Y', NULL, NULL),
('2016-07-03', 'Y', NULL, NULL),
('2016-07-04', 'N', NULL, NULL),
('2016-07-05', 'N', NULL, NULL),
('2016-07-06', 'N', NULL, NULL),
('2016-07-07', 'N', NULL, NULL),
('2016-07-08', 'N', NULL, NULL),
('2016-07-09', 'Y', NULL, NULL),
('2016-07-10', 'Y', NULL, NULL),
('2016-07-11', 'N', NULL, NULL),
('2016-07-12', 'N', NULL, NULL),
('2016-07-13', 'N', NULL, NULL),
('2016-07-14', 'N', NULL, NULL),
('2016-07-15', 'N', NULL, NULL),
('2016-07-16', 'Y', NULL, NULL),
('2016-07-17', 'Y', NULL, NULL),
('2016-07-18', 'N', NULL, NULL),
('2016-07-19', 'N', NULL, NULL),
('2016-07-20', 'N', NULL, NULL),
('2016-07-21', 'N', NULL, NULL),
('2016-07-22', 'N', NULL, NULL),
('2016-07-23', 'Y', NULL, NULL),
('2016-07-24', 'Y', NULL, NULL),
('2016-07-25', 'N', NULL, NULL),
('2016-07-26', 'N', NULL, NULL),
('2016-07-27', 'N', NULL, NULL),
('2016-07-28', 'N', NULL, NULL),
('2016-07-29', 'N', NULL, NULL),
('2016-07-30', 'Y', NULL, NULL),
('2016-07-31', 'Y', NULL, NULL),
('2016-08-01', 'N', NULL, NULL),
('2016-08-02', 'N', NULL, NULL),
('2016-08-03', 'N', NULL, NULL),
('2016-08-04', 'N', NULL, NULL),
('2016-08-05', 'N', NULL, NULL),
('2016-08-06', 'Y', NULL, NULL),
('2016-08-07', 'Y', NULL, NULL),
('2016-08-08', 'N', NULL, NULL),
('2016-08-09', 'N', NULL, NULL),
('2016-08-10', 'N', NULL, NULL),
('2016-08-11', 'N', NULL, NULL),
('2016-08-12', 'N', NULL, NULL),
('2016-08-13', 'Y', NULL, NULL),
('2016-08-14', 'Y', NULL, NULL),
('2016-08-15', 'N', NULL, NULL),
('2016-08-16', 'N', NULL, NULL),
('2016-08-17', 'N', NULL, NULL),
('2016-08-18', 'N', NULL, NULL),
('2016-08-19', 'N', NULL, NULL),
('2016-08-20', 'Y', NULL, NULL),
('2016-08-21', 'Y', NULL, NULL),
('2016-08-22', 'N', NULL, NULL),
('2016-08-23', 'N', NULL, NULL),
('2016-08-24', 'N', NULL, NULL),
('2016-08-25', 'N', NULL, NULL),
('2016-08-26', 'N', NULL, NULL),
('2016-08-27', 'Y', NULL, NULL),
('2016-08-28', 'Y', NULL, NULL),
('2016-08-29', 'N', NULL, NULL),
('2016-08-30', 'N', NULL, NULL),
('2016-08-31', 'N', NULL, NULL),
('2016-09-01', 'N', NULL, NULL),
('2016-09-02', 'N', NULL, NULL),
('2016-09-03', 'Y', NULL, NULL),
('2016-09-04', 'Y', NULL, NULL),
('2016-09-05', 'N', NULL, NULL),
('2016-09-06', 'N', NULL, NULL),
('2016-09-07', 'N', NULL, NULL),
('2016-09-08', 'N', NULL, NULL),
('2016-09-09', 'N', NULL, NULL),
('2016-09-10', 'Y', NULL, NULL),
('2016-09-11', 'Y', NULL, NULL),
('2016-09-12', 'N', NULL, NULL),
('2016-09-13', 'N', NULL, NULL),
('2016-09-14', 'N', NULL, NULL),
('2016-09-15', 'N', NULL, NULL),
('2016-09-16', 'N', NULL, NULL),
('2016-09-17', 'Y', NULL, NULL),
('2016-09-18', 'Y', NULL, NULL),
('2016-09-19', 'N', NULL, NULL),
('2016-09-20', 'N', NULL, NULL),
('2016-09-21', 'N', NULL, NULL),
('2016-09-22', 'N', NULL, NULL),
('2016-09-23', 'N', NULL, NULL),
('2016-09-24', 'Y', NULL, NULL),
('2016-09-25', 'Y', NULL, NULL),
('2016-09-26', 'N', NULL, NULL),
('2016-09-27', 'N', NULL, NULL),
('2016-09-28', 'N', NULL, NULL),
('2016-09-29', 'N', NULL, NULL),
('2016-09-30', 'N', NULL, NULL),
('2016-10-01', 'Y', NULL, NULL),
('2016-10-02', 'Y', NULL, NULL),
('2016-10-03', 'N', NULL, NULL),
('2016-10-04', 'N', NULL, NULL),
('2016-10-05', 'N', NULL, NULL),
('2016-10-06', 'N', NULL, NULL),
('2016-10-07', 'N', NULL, NULL),
('2016-10-08', 'Y', NULL, NULL),
('2016-10-09', 'Y', NULL, NULL),
('2016-10-10', 'N', NULL, NULL),
('2016-10-11', 'N', NULL, NULL),
('2016-10-12', 'N', NULL, NULL),
('2016-10-13', 'N', NULL, NULL),
('2016-10-14', 'N', NULL, NULL),
('2016-10-15', 'Y', NULL, NULL),
('2016-10-16', 'Y', NULL, NULL),
('2016-10-17', 'N', NULL, NULL),
('2016-10-18', 'N', NULL, NULL),
('2016-10-19', 'N', NULL, NULL),
('2016-10-20', 'N', NULL, NULL),
('2016-10-21', 'N', NULL, NULL),
('2016-10-22', 'Y', NULL, NULL),
('2016-10-23', 'Y', NULL, NULL),
('2016-10-24', 'N', NULL, NULL),
('2016-10-25', 'N', NULL, NULL),
('2016-10-26', 'N', NULL, NULL),
('2016-10-27', 'N', NULL, NULL),
('2016-10-28', 'N', NULL, NULL),
('2016-10-29', 'Y', NULL, NULL),
('2016-10-30', 'Y', NULL, NULL),
('2016-10-31', 'N', NULL, NULL),
('2016-11-01', 'N', NULL, NULL),
('2016-11-02', 'N', NULL, NULL),
('2016-11-03', 'N', NULL, NULL),
('2016-11-04', 'N', NULL, NULL),
('2016-11-05', 'Y', NULL, NULL),
('2016-11-06', 'Y', NULL, NULL),
('2016-11-07', 'N', NULL, NULL),
('2016-11-08', 'N', NULL, NULL),
('2016-11-09', 'N', NULL, NULL),
('2016-11-10', 'N', NULL, NULL),
('2016-11-11', 'N', NULL, NULL),
('2016-11-12', 'Y', NULL, NULL),
('2016-11-13', 'Y', NULL, NULL),
('2016-11-14', 'N', NULL, NULL),
('2016-11-15', 'N', NULL, NULL),
('2016-11-16', 'N', NULL, NULL),
('2016-11-17', 'N', NULL, NULL),
('2016-11-18', 'N', NULL, NULL),
('2016-11-19', 'Y', NULL, NULL),
('2016-11-20', 'Y', NULL, NULL),
('2016-11-21', 'N', NULL, NULL),
('2016-11-22', 'N', NULL, NULL),
('2016-11-23', 'N', NULL, NULL),
('2016-11-24', 'N', NULL, NULL),
('2016-11-25', 'N', NULL, NULL),
('2016-11-26', 'Y', NULL, NULL),
('2016-11-27', 'Y', NULL, NULL),
('2016-11-28', 'N', NULL, NULL),
('2016-11-29', 'N', NULL, NULL),
('2016-11-30', 'N', NULL, NULL),
('2016-12-01', 'N', NULL, NULL),
('2016-12-02', 'N', NULL, NULL),
('2016-12-03', 'Y', NULL, NULL),
('2016-12-04', 'Y', NULL, NULL),
('2016-12-05', 'N', NULL, NULL),
('2016-12-06', 'N', NULL, NULL),
('2016-12-07', 'N', NULL, NULL),
('2016-12-08', 'N', NULL, NULL),
('2016-12-09', 'N', NULL, NULL),
('2016-12-10', 'Y', NULL, NULL),
('2016-12-11', 'Y', NULL, NULL),
('2016-12-12', 'N', NULL, NULL),
('2016-12-13', 'N', NULL, NULL),
('2016-12-14', 'N', NULL, NULL),
('2016-12-15', 'N', NULL, NULL),
('2016-12-16', 'N', NULL, NULL),
('2016-12-17', 'Y', NULL, NULL),
('2016-12-18', 'Y', NULL, NULL),
('2016-12-19', 'N', NULL, NULL),
('2016-12-20', 'N', NULL, NULL),
('2016-12-21', 'N', NULL, NULL),
('2016-12-22', 'N', NULL, NULL),
('2016-12-23', 'N', NULL, NULL),
('2016-12-24', 'Y', NULL, NULL),
('2016-12-25', 'Y', NULL, NULL),
('2016-12-26', 'N', NULL, NULL),
('2016-12-27', 'N', NULL, NULL),
('2016-12-28', 'N', NULL, NULL),
('2016-12-29', 'N', NULL, NULL),
('2016-12-30', 'N', NULL, NULL),
('2016-12-31', 'Y', NULL, NULL),
('2017-01-01', 'Y', NULL, NULL),
('2017-01-02', 'N', NULL, NULL),
('2017-01-03', 'N', NULL, NULL),
('2017-01-04', 'N', NULL, NULL),
('2017-01-05', 'N', NULL, NULL),
('2017-01-06', 'N', NULL, NULL),
('2017-01-07', 'Y', NULL, NULL),
('2017-01-08', 'Y', NULL, NULL),
('2017-01-09', 'N', NULL, NULL),
('2017-01-10', 'N', NULL, NULL),
('2017-01-11', 'N', NULL, NULL),
('2017-01-12', 'N', NULL, NULL),
('2017-01-13', 'N', NULL, NULL),
('2017-01-14', 'Y', NULL, NULL),
('2017-01-15', 'Y', NULL, NULL),
('2017-01-16', 'N', NULL, NULL),
('2017-01-17', 'N', NULL, NULL),
('2017-01-18', 'N', NULL, NULL),
('2017-01-19', 'N', NULL, NULL),
('2017-01-20', 'N', NULL, NULL),
('2017-01-21', 'Y', NULL, NULL),
('2017-01-22', 'Y', NULL, NULL),
('2017-01-23', 'N', NULL, NULL),
('2017-01-24', 'N', NULL, NULL),
('2017-01-25', 'N', NULL, NULL),
('2017-01-26', 'N', NULL, NULL),
('2017-01-27', 'N', NULL, NULL),
('2017-01-28', 'Y', NULL, NULL),
('2017-01-29', 'Y', NULL, NULL),
('2017-01-30', 'N', NULL, NULL),
('2017-01-31', 'N', NULL, NULL),
('2017-02-01', 'N', NULL, NULL),
('2017-02-02', 'N', NULL, NULL),
('2017-02-03', 'N', NULL, NULL),
('2017-02-04', 'Y', NULL, NULL),
('2017-02-05', 'Y', NULL, NULL),
('2017-02-06', 'N', NULL, NULL),
('2017-02-07', 'N', NULL, NULL),
('2017-02-08', 'N', NULL, NULL),
('2017-02-09', 'N', NULL, NULL),
('2017-02-10', 'N', NULL, NULL),
('2017-02-11', 'Y', NULL, NULL),
('2017-02-12', 'Y', NULL, NULL),
('2017-02-13', 'N', NULL, NULL),
('2017-02-14', 'N', NULL, NULL),
('2017-02-15', 'N', NULL, NULL),
('2017-02-16', 'N', NULL, NULL),
('2017-02-17', 'N', NULL, NULL),
('2017-02-18', 'Y', NULL, NULL),
('2017-02-19', 'Y', NULL, NULL),
('2017-02-20', 'N', NULL, NULL),
('2017-02-21', 'N', NULL, NULL),
('2017-02-22', 'N', NULL, NULL),
('2017-02-23', 'N', NULL, NULL),
('2017-02-24', 'N', NULL, NULL),
('2017-02-25', 'Y', NULL, NULL),
('2017-02-26', 'Y', NULL, NULL),
('2017-02-27', 'N', NULL, NULL),
('2017-02-28', 'N', NULL, NULL),
('2017-03-01', 'N', NULL, NULL),
('2017-03-02', 'N', NULL, NULL),
('2017-03-03', 'N', NULL, NULL),
('2017-03-04', 'Y', NULL, NULL),
('2017-03-05', 'Y', NULL, NULL),
('2017-03-06', 'N', NULL, NULL),
('2017-03-07', 'N', NULL, NULL),
('2017-03-08', 'N', NULL, NULL),
('2017-03-09', 'N', NULL, NULL),
('2017-03-10', 'N', NULL, NULL),
('2017-03-11', 'Y', NULL, NULL),
('2017-03-12', 'Y', NULL, NULL),
('2017-03-13', 'N', NULL, NULL),
('2017-03-14', 'N', NULL, NULL),
('2017-03-15', 'N', NULL, NULL),
('2017-03-16', 'N', NULL, NULL),
('2017-03-17', 'N', NULL, NULL),
('2017-03-18', 'Y', NULL, NULL),
('2017-03-19', 'Y', NULL, NULL),
('2017-03-20', 'N', NULL, NULL),
('2017-03-21', 'N', NULL, NULL),
('2017-03-22', 'N', NULL, NULL),
('2017-03-23', 'N', NULL, NULL),
('2017-03-24', 'N', NULL, NULL),
('2017-03-25', 'Y', NULL, NULL),
('2017-03-26', 'Y', NULL, NULL),
('2017-03-27', 'N', NULL, NULL),
('2017-03-28', 'N', NULL, NULL),
('2017-03-29', 'N', NULL, NULL),
('2017-03-30', 'N', NULL, NULL),
('2017-03-31', 'N', NULL, NULL),
('2017-04-01', 'Y', NULL, NULL),
('2017-04-02', 'Y', NULL, NULL),
('2017-04-03', 'N', NULL, NULL),
('2017-04-04', 'N', NULL, NULL),
('2017-04-05', 'N', NULL, NULL),
('2017-04-06', 'N', NULL, NULL),
('2017-04-07', 'N', NULL, NULL),
('2017-04-08', 'Y', NULL, NULL),
('2017-04-09', 'Y', NULL, NULL),
('2017-04-10', 'N', NULL, NULL),
('2017-04-11', 'N', NULL, NULL),
('2017-04-12', 'N', NULL, NULL),
('2017-04-13', 'N', NULL, NULL),
('2017-04-14', 'N', NULL, NULL),
('2017-04-15', 'Y', NULL, NULL),
('2017-04-16', 'Y', NULL, NULL),
('2017-04-17', 'N', NULL, NULL),
('2017-04-18', 'N', NULL, NULL),
('2017-04-19', 'N', NULL, NULL),
('2017-04-20', 'N', NULL, NULL),
('2017-04-21', 'N', NULL, NULL),
('2017-04-22', 'Y', NULL, NULL),
('2017-04-23', 'Y', NULL, NULL),
('2017-04-24', 'N', NULL, NULL),
('2017-04-25', 'N', NULL, NULL),
('2017-04-26', 'N', NULL, NULL),
('2017-04-27', 'N', NULL, NULL),
('2017-04-28', 'N', NULL, NULL),
('2017-04-29', 'Y', NULL, NULL),
('2017-04-30', 'Y', NULL, NULL),
('2017-05-01', 'N', NULL, NULL),
('2017-05-02', 'N', NULL, NULL),
('2017-05-03', 'N', NULL, NULL),
('2017-05-04', 'N', NULL, NULL),
('2017-05-05', 'N', NULL, NULL),
('2017-05-06', 'Y', NULL, NULL),
('2017-05-07', 'Y', NULL, NULL),
('2017-05-08', 'N', NULL, NULL),
('2017-05-09', 'N', NULL, NULL),
('2017-05-10', 'N', NULL, NULL),
('2017-05-11', 'N', NULL, NULL),
('2017-05-12', 'N', NULL, NULL),
('2017-05-13', 'Y', NULL, NULL),
('2017-05-14', 'Y', NULL, NULL),
('2017-05-15', 'N', NULL, NULL),
('2017-05-16', 'N', NULL, NULL),
('2017-05-17', 'N', NULL, NULL),
('2017-05-18', 'N', NULL, NULL),
('2017-05-19', 'N', NULL, NULL),
('2017-05-20', 'Y', NULL, NULL),
('2017-05-21', 'Y', NULL, NULL),
('2017-05-22', 'N', NULL, NULL),
('2017-05-23', 'N', NULL, NULL),
('2017-05-24', 'N', NULL, NULL),
('2017-05-25', 'N', NULL, NULL),
('2017-05-26', 'N', NULL, NULL),
('2017-05-27', 'Y', NULL, NULL),
('2017-05-28', 'Y', NULL, NULL),
('2017-05-29', 'N', NULL, NULL),
('2017-05-30', 'N', NULL, NULL),
('2017-05-31', 'N', NULL, NULL),
('2017-06-01', 'N', NULL, NULL),
('2017-06-02', 'N', NULL, NULL),
('2017-06-03', 'Y', NULL, NULL),
('2017-06-04', 'Y', NULL, NULL),
('2017-06-05', 'N', NULL, NULL),
('2017-06-06', 'N', NULL, NULL),
('2017-06-07', 'N', NULL, NULL),
('2017-06-08', 'N', NULL, NULL),
('2017-06-09', 'N', NULL, NULL),
('2017-06-10', 'Y', NULL, NULL),
('2017-06-11', 'Y', NULL, NULL),
('2017-06-12', 'N', NULL, NULL),
('2017-06-13', 'N', NULL, NULL),
('2017-06-14', 'N', NULL, NULL),
('2017-06-15', 'N', NULL, NULL),
('2017-06-16', 'N', NULL, NULL),
('2017-06-17', 'Y', NULL, NULL),
('2017-06-18', 'Y', NULL, NULL),
('2017-06-19', 'N', NULL, NULL),
('2017-06-20', 'N', NULL, NULL),
('2017-06-21', 'N', NULL, NULL),
('2017-06-22', 'N', NULL, NULL),
('2017-06-23', 'N', NULL, NULL),
('2017-06-24', 'Y', NULL, NULL),
('2017-06-25', 'Y', NULL, NULL),
('2017-06-26', 'N', NULL, NULL),
('2017-06-27', 'N', NULL, NULL),
('2017-06-28', 'N', NULL, NULL),
('2017-06-29', 'N', NULL, NULL),
('2017-06-30', 'N', NULL, NULL),
('2017-07-01', 'Y', NULL, NULL),
('2017-07-02', 'Y', NULL, NULL),
('2017-07-03', 'N', NULL, NULL),
('2017-07-04', 'N', NULL, NULL),
('2017-07-05', 'N', NULL, NULL),
('2017-07-06', 'N', NULL, NULL),
('2017-07-07', 'N', NULL, NULL),
('2017-07-08', 'Y', NULL, NULL),
('2017-07-09', 'Y', NULL, NULL),
('2017-07-10', 'N', NULL, NULL),
('2017-07-11', 'N', NULL, NULL),
('2017-07-12', 'N', NULL, NULL),
('2017-07-13', 'N', NULL, NULL),
('2017-07-14', 'N', NULL, NULL),
('2017-07-15', 'Y', NULL, NULL),
('2017-07-16', 'Y', NULL, NULL),
('2017-07-17', 'N', NULL, NULL),
('2017-07-18', 'N', NULL, NULL),
('2017-07-19', 'N', NULL, NULL),
('2017-07-20', 'N', NULL, NULL),
('2017-07-21', 'N', NULL, NULL),
('2017-07-22', 'Y', NULL, NULL),
('2017-07-23', 'Y', NULL, NULL),
('2017-07-24', 'N', NULL, NULL),
('2017-07-25', 'N', NULL, NULL),
('2017-07-26', 'N', NULL, NULL),
('2017-07-27', 'N', NULL, NULL),
('2017-07-28', 'N', NULL, NULL),
('2017-07-29', 'Y', NULL, NULL),
('2017-07-30', 'Y', NULL, NULL),
('2017-07-31', 'N', NULL, NULL),
('2017-08-01', 'N', NULL, NULL),
('2017-08-02', 'N', NULL, NULL),
('2017-08-03', 'N', NULL, NULL),
('2017-08-04', 'N', NULL, NULL),
('2017-08-05', 'Y', NULL, NULL),
('2017-08-06', 'Y', NULL, NULL),
('2017-08-07', 'N', NULL, NULL),
('2017-08-08', 'N', NULL, NULL),
('2017-08-09', 'N', NULL, NULL),
('2017-08-10', 'N', NULL, NULL),
('2017-08-11', 'N', NULL, NULL),
('2017-08-12', 'Y', NULL, NULL),
('2017-08-13', 'Y', NULL, NULL),
('2017-08-14', 'N', NULL, NULL),
('2017-08-15', 'N', NULL, NULL),
('2017-08-16', 'N', NULL, NULL),
('2017-08-17', 'N', NULL, NULL),
('2017-08-18', 'N', NULL, NULL),
('2017-08-19', 'Y', NULL, NULL),
('2017-08-20', 'Y', NULL, NULL),
('2017-08-21', 'N', NULL, NULL),
('2017-08-22', 'N', NULL, NULL),
('2017-08-23', 'N', NULL, NULL),
('2017-08-24', 'N', NULL, NULL),
('2017-08-25', 'N', NULL, NULL),
('2017-08-26', 'Y', NULL, NULL),
('2017-08-27', 'Y', NULL, NULL),
('2017-08-28', 'N', NULL, NULL),
('2017-08-29', 'N', NULL, NULL),
('2017-08-30', 'N', NULL, NULL),
('2017-08-31', 'N', NULL, NULL),
('2017-09-01', 'N', NULL, NULL),
('2017-09-02', 'Y', NULL, NULL),
('2017-09-03', 'Y', NULL, NULL),
('2017-09-04', 'N', NULL, NULL),
('2017-09-05', 'N', NULL, NULL),
('2017-09-06', 'N', NULL, NULL),
('2017-09-07', 'N', NULL, NULL),
('2017-09-08', 'N', NULL, NULL),
('2017-09-09', 'Y', NULL, NULL),
('2017-09-10', 'Y', NULL, NULL),
('2017-09-11', 'N', NULL, NULL),
('2017-09-12', 'N', NULL, NULL),
('2017-09-13', 'N', NULL, NULL),
('2017-09-14', 'N', NULL, NULL),
('2017-09-15', 'N', NULL, NULL),
('2017-09-16', 'Y', NULL, NULL),
('2017-09-17', 'Y', NULL, NULL),
('2017-09-18', 'N', NULL, NULL),
('2017-09-19', 'N', NULL, NULL),
('2017-09-20', 'N', NULL, NULL),
('2017-09-21', 'N', NULL, NULL),
('2017-09-22', 'N', NULL, NULL),
('2017-09-23', 'Y', NULL, NULL),
('2017-09-24', 'Y', NULL, NULL),
('2017-09-25', 'N', NULL, NULL),
('2017-09-26', 'N', NULL, NULL),
('2017-09-27', 'N', NULL, NULL),
('2017-09-28', 'N', NULL, NULL),
('2017-09-29', 'N', NULL, NULL),
('2017-09-30', 'Y', NULL, NULL),
('2017-10-01', 'Y', NULL, NULL),
('2017-10-02', 'N', NULL, NULL),
('2017-10-03', 'N', NULL, NULL),
('2017-10-04', 'N', NULL, NULL),
('2017-10-05', 'N', NULL, NULL),
('2017-10-06', 'N', NULL, NULL),
('2017-10-07', 'Y', NULL, NULL),
('2017-10-08', 'Y', NULL, NULL),
('2017-10-09', 'N', NULL, NULL),
('2017-10-10', 'N', NULL, NULL),
('2017-10-11', 'N', NULL, NULL),
('2017-10-12', 'N', NULL, NULL),
('2017-10-13', 'N', NULL, NULL),
('2017-10-14', 'Y', NULL, NULL),
('2017-10-15', 'Y', NULL, NULL),
('2017-10-16', 'N', NULL, NULL),
('2017-10-17', 'N', NULL, NULL),
('2017-10-18', 'N', NULL, NULL),
('2017-10-19', 'N', NULL, NULL),
('2017-10-20', 'N', NULL, NULL),
('2017-10-21', 'Y', NULL, NULL),
('2017-10-22', 'Y', NULL, NULL),
('2017-10-23', 'N', NULL, NULL),
('2017-10-24', 'N', NULL, NULL),
('2017-10-25', 'N', NULL, NULL),
('2017-10-26', 'N', NULL, NULL),
('2017-10-27', 'N', NULL, NULL),
('2017-10-28', 'Y', NULL, NULL),
('2017-10-29', 'Y', NULL, NULL),
('2017-10-30', 'N', NULL, NULL),
('2017-10-31', 'N', NULL, NULL),
('2017-11-01', 'N', NULL, NULL),
('2017-11-02', 'N', NULL, NULL),
('2017-11-03', 'N', NULL, NULL),
('2017-11-04', 'Y', NULL, NULL),
('2017-11-05', 'Y', NULL, NULL),
('2017-11-06', 'N', NULL, NULL),
('2017-11-07', 'N', NULL, NULL),
('2017-11-08', 'N', NULL, NULL),
('2017-11-09', 'N', NULL, NULL),
('2017-11-10', 'N', NULL, NULL),
('2017-11-11', 'Y', NULL, NULL),
('2017-11-12', 'Y', NULL, NULL),
('2017-11-13', 'N', NULL, NULL),
('2017-11-14', 'N', NULL, NULL),
('2017-11-15', 'N', NULL, NULL),
('2017-11-16', 'N', NULL, NULL),
('2017-11-17', 'N', NULL, NULL),
('2017-11-18', 'Y', NULL, NULL),
('2017-11-19', 'Y', NULL, NULL),
('2017-11-20', 'N', NULL, NULL),
('2017-11-21', 'N', NULL, NULL),
('2017-11-22', 'N', NULL, NULL),
('2017-11-23', 'N', NULL, NULL),
('2017-11-24', 'N', NULL, NULL),
('2017-11-25', 'Y', NULL, NULL),
('2017-11-26', 'Y', NULL, NULL),
('2017-11-27', 'N', NULL, NULL),
('2017-11-28', 'N', NULL, NULL),
('2017-11-29', 'N', NULL, NULL),
('2017-11-30', 'N', NULL, NULL),
('2017-12-01', 'N', NULL, NULL),
('2017-12-02', 'Y', NULL, NULL),
('2017-12-03', 'Y', NULL, NULL),
('2017-12-04', 'N', NULL, NULL),
('2017-12-05', 'N', NULL, NULL),
('2017-12-06', 'N', NULL, NULL),
('2017-12-07', 'N', NULL, NULL),
('2017-12-08', 'N', NULL, NULL),
('2017-12-09', 'Y', NULL, NULL),
('2017-12-10', 'Y', NULL, NULL),
('2017-12-11', 'N', NULL, NULL),
('2017-12-12', 'N', NULL, NULL),
('2017-12-13', 'N', NULL, NULL),
('2017-12-14', 'N', NULL, NULL),
('2017-12-15', 'N', NULL, NULL),
('2017-12-16', 'Y', NULL, NULL),
('2017-12-17', 'Y', NULL, NULL),
('2017-12-18', 'N', NULL, NULL),
('2017-12-19', 'N', NULL, NULL),
('2017-12-20', 'N', NULL, NULL),
('2017-12-21', 'N', NULL, NULL),
('2017-12-22', 'N', NULL, NULL),
('2017-12-23', 'Y', NULL, NULL),
('2017-12-24', 'Y', NULL, NULL),
('2017-12-25', 'N', NULL, NULL),
('2017-12-26', 'N', NULL, NULL),
('2017-12-27', 'N', NULL, NULL),
('2017-12-28', 'N', NULL, NULL),
('2017-12-29', 'N', NULL, NULL),
('2017-12-30', 'Y', NULL, NULL),
('2017-12-31', 'Y', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `konfigurasi`
--

CREATE TABLE `konfigurasi` (
  `conf_id` int(11) NOT NULL,
  `officemgr` int(11) DEFAULT NULL,
  `hrmanager` int(11) DEFAULT NULL,
  `activeyear` int(11) NOT NULL,
  `claimbudget` int(11) DEFAULT NULL,
  `leave_start` date DEFAULT NULL,
  `leave_end` date DEFAULT NULL,
  `leave_taker1` varchar(24) DEFAULT NULL,
  `leave_taker2` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='untuk konfigurasi aplikasi';

--
-- Dumping data for table `konfigurasi`
--

INSERT INTO `konfigurasi` (`conf_id`, `officemgr`, `hrmanager`, `activeyear`, `claimbudget`, `leave_start`, `leave_end`, `leave_taker1`, `leave_taker2`) VALUES
(1, 3, 4, 2016, 155000000, '2016-01-01', '2017-06-30', 'indri', 'nancy');

-- --------------------------------------------------------

--
-- Table structure for table `lembur_jenis`
--

CREATE TABLE `lembur_jenis` (
  `id` int(11) NOT NULL,
  `periode` int(11) NOT NULL,
  `jenis_lembur` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lembur_jenis`
--

INSERT INTO `lembur_jenis` (`id`, `periode`, `jenis_lembur`) VALUES
(1, 2016, 'Harian'),
(2, 2016, 'Luar Kota'),
(3, 2016, 'Luar Negeri'),
(4, 2016, 'Weekend'),
(5, 2016, '2 Shift'),
(6, 2016, 'Shift Malam (3)');

-- --------------------------------------------------------

--
-- Table structure for table `lembur_log`
--

CREATE TABLE `lembur_log` (
  `id` int(11) NOT NULL,
  `no_claim` varchar(9) NOT NULL,
  `user` varchar(32) NOT NULL,
  `input_by` varchar(32) DEFAULT NULL,
  `tgl_input` date NOT NULL,
  `tgl_start` date NOT NULL,
  `tgl_end` date NOT NULL,
  `total_date` int(11) NOT NULL,
  `tgl_list` varchar(5000) NOT NULL,
  `dollar` int(11) DEFAULT NULL,
  `periode` int(11) NOT NULL,
  `jenis_lembur` varchar(16) NOT NULL,
  `escalated_to` varchar(32) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `approved_by` varchar(32) DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `rejected_by` varchar(32) DEFAULT NULL,
  `status` enum('DRAFT','APPROVED','REJECT') CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT 'DRAFT'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lembur_log`
--

INSERT INTO `lembur_log` (`id`, `no_claim`, `user`, `input_by`, `tgl_input`, `tgl_start`, `tgl_end`, `total_date`, `tgl_list`, `dollar`, `periode`, `jenis_lembur`, `escalated_to`, `approved_date`, `approved_by`, `rejected_date`, `rejected_by`, `status`) VALUES
(21, 'KO-160001', 'rizki', 'hans', '2016-12-26', '2016-12-27', '2016-12-30', 4, '2016-12-27:2016-12-28:2016-12-29:2016-12-30:', 13000, 0, 'luarnegeri', 'hans', NULL, NULL, '2016-12-26', 'nancy', 'REJECT'),
(22, 'KO-160002', 'indri', 'nancy', '2016-12-26', '2017-01-03', '2017-01-12', 10, '2017-01-03:2017-01-04:2017-01-05:2017-01-06:2017-01-07:2017-01-08:2017-01-09:2017-01-10:2017-01-11:2017-01-12:', NULL, 0, 'luarkota', 'nancy', '2016-12-26', 'nancy', NULL, NULL, 'APPROVED'),
(24, 'KO-160006', 'rustam', 'nancy', '2016-12-27', '2017-01-13', '2017-01-15', 3, '2017-01-13:2017-01-14:2017-01-15:', 10000, 0, 'luarnegeri', 'soetarno', '2016-12-26', 'nancy', NULL, NULL, 'APPROVED'),
(25, 'KO-160004', 'indri', 'nancy', '2016-12-27', '2016-12-28', '2016-12-30', 3, '2016-12-28:2016-12-29:2016-12-30:', NULL, 0, 'luarkota', 'nancy', '2016-12-27', 'nancy', NULL, NULL, 'APPROVED'),
(26, 'KO-160005', 'rustam', 'soetarno', '2016-12-27', '2016-12-28', '2016-12-30', 2, '2016-12-28:2016-12-29:2016-12-30:', NULL, 0, 'luarkota', 'soetarno', NULL, NULL, NULL, NULL, 'APPROVED'),
(27, 'KO-160006', 'rustam', 'nancy', '2016-12-28', '2017-01-18', '2017-01-20', 3, '2017-01-18:2017-01-19:2017-01-20:', 12000, 0, 'luarnegeri', 'soetarno', '2016-12-29', 'nancy', NULL, NULL, 'APPROVED'),
(28, 'KO-160007', 'rustam', 'nancy', '2016-12-27', '2017-01-11', '2017-01-14', 3, '2017-01-11:2017-01-12:2017-01-13:2017-01-14:', NULL, 0, 'luarkota', 'soetarno', '2016-12-27', 'nancy', NULL, NULL, 'APPROVED'),
(29, 'KO-160008', 'edouard', 'nancy', '2016-12-27', '2017-01-15', '2017-01-16', 1, '2017-01-15:2017-01-16:', NULL, 0, 'luarkota', '', NULL, NULL, NULL, NULL, 'DRAFT'),
(30, 'KO-160009', 'rustam', 'nancy', '2016-12-27', '2017-01-15', '2017-01-16', 1, '2017-01-15:2017-01-16:', NULL, 0, 'luarkota', 'soetarno', NULL, NULL, NULL, NULL, 'APPROVED'),
(31, 'KO-160010', 'indri', 'nancy', '2016-12-27', '2016-12-29', '2016-12-30', 1, '2016-12-29:2016-12-30:', 15000, 0, 'luarnegeri', 'nancy', NULL, NULL, NULL, NULL, 'DRAFT');

-- --------------------------------------------------------

--
-- Table structure for table `lembur_payment`
--

CREATE TABLE `lembur_payment` (
  `harian` int(11) DEFAULT NULL,
  `luarkota` int(11) DEFAULT NULL,
  `luarnegeri` int(11) DEFAULT NULL,
  `weekend_sooh` int(11) DEFAULT NULL,
  `weekend_igfs` int(11) DEFAULT NULL,
  `doubleshift` int(11) DEFAULT NULL,
  `nightshift` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lembur_payment`
--

INSERT INTO `lembur_payment` (`harian`, `luarkota`, `luarnegeri`, `weekend_sooh`, `weekend_igfs`, `doubleshift`, `nightshift`) VALUES
(50000, 125000, 25, 150000, 50000, 100000, 150000);

-- --------------------------------------------------------

--
-- Table structure for table `limit`
--

CREATE TABLE `limit` (
  `nik` varchar(10) NOT NULL,
  `username` varchar(30) NOT NULL,
  `user_status` int(1) NOT NULL COMMENT '0:pkwt,1:perm,2:freelance',
  `health` int(11) DEFAULT NULL,
  `health_used` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `limit`
--

INSERT INTO `limit` (`nik`, `username`, `user_status`, `health`, `health_used`) VALUES
('INT004', 'rustam', 1, 2000000, 0),
('INT005', 'faisal', 1, 2000000, 0),
('INT006', 'andi', 1, 2000000, 0),
('INT008', 'ngadimun', 1, 3000000, 0),
('INT010', 'adiawan', 1, 2000000, 0),
('INT014', 'chrismas', 1, 2000000, 0),
('INT015', 'polycarpus', 1, 2000000, 0),
('INT016', 'rahmad', 1, 2000000, 0),
('INT017', 'weddy', 1, 2000000, 0),
('INT022', 'niken', 1, 2000000, 0),
('INT023', 'ghali', 1, 2000000, 0),
('INT025', 'josep', 1, 2000000, 0),
('INT026', 'siti', 1, 2000000, 0),
('INT033', 'athar', 1, 2000000, 0),
('INT034', 'imam', 1, 2000000, 0),
('INT036', 'sri', 1, 2000000, 0),
('INT038', 'marias', 1, 2000000, 0),
('INT041', 'boy', 1, 2000000, 0),
('INT043', 'misbakhudin', 1, 2000000, 0),
('INT045', 'muchlis', 1, 2000000, 0),
('INT047', 'marathur', 1, 2000000, 0),
('INT048', 'rolus', 1, 2000000, 0),
('INT050', 'nurwidi', 1, 2000000, 0),
('INT053', 'nursalim', 1, 2000000, 0),
('INT064', 'arif', 1, 2000000, 0),
('INT067', 'haryoto', 1, 2000000, 0),
('INT068', 'dipta', 1, 2000000, 0),
('INT069', 'tri', 1, 2000000, 0),
('INT070', 'nancy', 1, 2000000, 0),
('INT077', 'agus', 1, 2000000, 0),
('INT086', 'annisa', 1, 2000000, 0),
('INT087', 'soetarno', 1, 2000000, 0),
('INT088', 'loementa', 1, 2000000, 0),
('INT089', 'essy', 1, 2000000, 0),
('INT093', 'azhara', 1, 2000000, 0),
('INT094', 'iskah', 1, 2000000, 0),
('INT095', 'fizardin', 1, 2000000, 0),
('INT099', 'ade', 1, 2000000, 0),
('INT100', 'sekar', 1, 2000000, 0),
('INT102', 'ivan', 1, 2000000, 0),
('INT103', 'indri', 1, 2000000, 159880),
('INT109', 'rio', 1, 2000000, 0),
('INT111', 'wartanto', 1, 2000000, 0),
('INT114', 'alimudin', 1, 2000000, 0),
('INT118', 'nia', 1, 2000000, 0),
('INT120', 'dimas', 1, 2000000, 0),
('INT123', 'halimah', 1, 2000000, 0),
('INT124', 'agnes', 1, 2000000, 0),
('INT125', 'djohan', 1, 2000000, 0),
('INT126', 'eka', 1, 2000000, 0),
('INT128', 'sauri', 1, 2000000, 0),
('INT129', 'puteri', 1, 2000000, 0),
('INT131', 'rizki', 1, 2000000, 0),
('INT134', 'damanhuri', 1, 2000000, 0),
('INT135', 'sohibu', 1, 2000000, 0),
('INT136', 'nisma', 1, 2000000, 0),
('INT137', 'dede', 1, 2000000, 0),
('INT138', 'yanuar', 1, 2000000, 0),
('INT139', 'tua', 1, 2000000, 0),
('INT140', 'jodya', 1, 2000000, 0),
('INT141', 'dillon', 1, 2000000, 0),
('INT142', 'fira', 0, 2000000, 0),
('INT143', 'lucky', 0, 2000000, 0),
('INT146', 'sabta', 0, 2000000, 0),
('INT147', 'hans', 0, 2000000, 0),
('INT148', 'hirson', 0, 2000000, 0),
('INT149', 'stasya', 0, 2000000, 0),
('INT150', 'ramses', 0, 2000000, 0),
('INT151', 'rina', 0, 2000000, 0),
('INT153', 'danang', 0, 2000000, 0),
('INT154', 'ardy', 0, 2000000, 0),
('INT155', 'ariyanto', 0, 2000000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `masterlogs`
--

CREATE TABLE `masterlogs` (
  `id` int(11) NOT NULL,
  `user` varchar(64) NOT NULL,
  `jobs` varchar(64) NOT NULL,
  `reg_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `masterlogs`
--

INSERT INTO `masterlogs` (`id`, `user`, `jobs`, `reg_date`) VALUES
(1, 'rizki', 'reset kalender', '2016-10-13 13:29:27'),
(2, 'rizki', 'reset kalender', '2016-10-13 13:30:22'),
(3, 'nancy', 'add date start:2016-10-21 end:2016-10-22 ', '2016-10-13 14:09:48'),
(4, 'nancy', 'add date start:2016-10-21 end:2016-10-22 ', '2016-10-13 14:09:48'),
(5, 'nancy', 'add date:2016-10-13', '2016-10-13 14:11:39'),
(6, 'nancy', 'add date:2016-10-14', '2016-10-13 14:11:39'),
(7, 'nancy', 'add date:2016-10-15', '2016-10-13 14:11:39'),
(8, 'nancy', 'add date:2016-10-16', '2016-10-13 14:11:39'),
(9, 'nancy', 'add date:2016-10-17', '2016-10-13 14:11:39'),
(10, 'nancy', 'add date:2016-10-18', '2016-10-13 14:11:39'),
(11, 'nancy', 'add date:2016-10-19', '2016-10-13 14:11:39'),
(12, 'nancy', 'add date:2016-10-20', '2016-10-13 14:11:39'),
(13, 'nancy', 'add date:2016-10-21', '2016-10-13 14:11:39'),
(14, 'nancy', 'reset kalender', '2016-10-13 14:12:26'),
(15, 'rizki', 'add date:2016-10-13', '2016-10-13 15:37:09'),
(16, 'rizki', 'add date:2016-10-14', '2016-10-13 15:37:09'),
(17, 'rizki', 'add date:2016-10-15', '2016-10-13 15:37:09'),
(18, 'rizki', 'add date:2016-10-16', '2016-10-13 15:37:09'),
(19, 'rizki', 'add date:2016-10-17', '2016-10-13 15:37:09'),
(20, 'rizki', 'add date:2016-10-18', '2016-10-13 15:37:09'),
(21, 'rizki', 'add date:2016-10-19', '2016-10-13 15:37:09'),
(22, 'rizki', 'add date:2016-10-20', '2016-10-13 15:37:09'),
(23, 'rizki', 'add date:2016-10-21', '2016-10-13 15:37:09'),
(24, 'rizki', 'add date:2016-10-22', '2016-10-13 15:37:09'),
(25, 'rizki', 'add date:2016-10-23', '2016-10-13 15:37:09'),
(26, 'rizki', 'add date:2016-10-24', '2016-10-13 15:37:09'),
(27, 'rizki', 'add date:2016-10-25', '2016-10-13 15:37:09'),
(28, 'rizki', 'add date:2016-10-26', '2016-10-13 15:37:10'),
(29, 'rizki', 'add date:2016-10-27', '2016-10-13 15:37:10'),
(30, 'rizki', 'add date:2016-10-28', '2016-10-13 15:37:10'),
(31, 'rizki', 'add date:2016-10-29', '2016-10-13 15:37:10'),
(32, 'rizki', 'add date:2016-10-30', '2016-10-13 15:37:10'),
(33, 'rizki', 'add date:2016-10-31', '2016-10-13 15:37:10'),
(34, 'rizki', 'add date:2016-11-01', '2016-10-13 15:37:10'),
(35, 'rizki', 'add date:2016-11-02', '2016-10-13 15:37:10'),
(36, 'rizki', 'add date:2016-11-03', '2016-10-13 15:37:10'),
(37, 'rizki', 'add date:2016-11-04', '2016-10-13 15:37:10'),
(38, 'rizki', 'add date:2016-11-05', '2016-10-13 15:37:10'),
(39, 'rizki', 'add date:2016-11-06', '2016-10-13 15:37:10'),
(40, 'rizki', 'add date:2016-11-07', '2016-10-13 15:37:10'),
(41, 'rizki', 'add date:2016-11-08', '2016-10-13 15:37:10'),
(42, 'rizki', 'add date:2016-11-09', '2016-10-13 15:37:11'),
(43, 'rizki', 'add date:2016-11-10', '2016-10-13 15:37:11'),
(44, 'rizki', 'add date:2016-11-11', '2016-10-13 15:37:11'),
(45, 'rizki', 'add date:2016-11-12', '2016-10-13 15:37:11'),
(46, 'rizki', 'add date:2016-11-13', '2016-10-13 15:37:11'),
(47, 'rizki', 'add date:2016-11-14', '2016-10-13 15:37:11'),
(48, 'rizki', 'add date:2016-11-15', '2016-10-13 15:37:11'),
(49, 'rizki', 'add date:2016-11-16', '2016-10-13 15:37:11'),
(50, 'rizki', 'add date:2016-11-17', '2016-10-13 15:37:11'),
(51, 'rizki', 'add date:2016-11-18', '2016-10-13 15:37:11'),
(52, 'rizki', 'add date:2016-11-19', '2016-10-13 15:37:11'),
(53, 'rizki', 'add date:2016-11-20', '2016-10-13 15:37:11'),
(54, 'rizki', 'add date:2016-11-21', '2016-10-13 15:37:11'),
(55, 'rizki', 'add date:2016-11-22', '2016-10-13 15:37:11'),
(56, 'rizki', 'add date:2016-11-23', '2016-10-13 15:37:11'),
(57, 'rizki', 'add date:2016-11-24', '2016-10-13 15:37:12'),
(58, 'rizki', 'add date:2016-11-25', '2016-10-13 15:37:12'),
(59, 'rizki', 'add date:2016-11-26', '2016-10-13 15:37:12'),
(60, 'rizki', 'add date:2016-11-27', '2016-10-13 15:37:12'),
(61, 'rizki', 'add date:2016-11-28', '2016-10-13 15:37:12'),
(62, 'rizki', 'add date:2016-11-29', '2016-10-13 15:37:12'),
(63, 'rizki', 'add date:2016-11-30', '2016-10-13 15:37:12'),
(64, 'nancy', 'add date:2017-01-01', '2016-10-18 15:14:53'),
(65, 'nancy', 'add date:2017-01-02', '2016-10-18 15:14:53'),
(66, 'nancy', 'add date:2017-01-03', '2016-10-18 15:14:53'),
(67, 'nancy', 'add date:2017-01-04', '2016-10-18 15:14:53'),
(68, 'nancy', 'add date:2017-01-05', '2016-10-18 15:14:53'),
(69, 'nancy', 'add date:2017-01-06', '2016-10-18 15:14:53'),
(70, 'nancy', 'add date:2017-01-07', '2016-10-18 15:14:53'),
(71, 'nancy', 'add date:2017-01-08', '2016-10-18 15:14:54'),
(72, 'nancy', 'add date:2017-01-09', '2016-10-18 15:14:54'),
(73, 'nancy', 'add date:2017-01-10', '2016-10-18 15:14:54'),
(74, 'nancy', 'add date:2017-01-11', '2016-10-18 15:14:54'),
(75, 'nancy', 'add date:2017-01-12', '2016-10-18 15:14:54'),
(76, 'nancy', 'add date:2017-01-13', '2016-10-18 15:14:54'),
(77, 'nancy', 'add date:2017-01-14', '2016-10-18 15:14:54'),
(78, 'nancy', 'add date:2017-01-15', '2016-10-18 15:14:54'),
(79, 'nancy', 'add date:2017-01-16', '2016-10-18 15:14:54'),
(80, 'nancy', 'add date:2017-01-17', '2016-10-18 15:14:54'),
(81, 'nancy', 'add date:2017-01-18', '2016-10-18 15:14:54'),
(82, 'nancy', 'add date:2017-01-19', '2016-10-18 15:14:54'),
(83, 'nancy', 'add date:2017-01-20', '2016-10-18 15:14:54'),
(84, 'nancy', 'add date:2017-01-21', '2016-10-18 15:14:55'),
(85, 'nancy', 'add date:2017-01-22', '2016-10-18 15:14:55'),
(86, 'nancy', 'add date:2017-01-23', '2016-10-18 15:14:55'),
(87, 'nancy', 'add date:2017-01-24', '2016-10-18 15:14:55'),
(88, 'nancy', 'add date:2017-01-25', '2016-10-18 15:14:55'),
(89, 'nancy', 'add date:2017-01-26', '2016-10-18 15:14:55'),
(90, 'nancy', 'add date:2017-01-27', '2016-10-18 15:14:55'),
(91, 'nancy', 'add date:2017-01-28', '2016-10-18 15:14:55'),
(92, 'nancy', 'add date:2017-01-29', '2016-10-18 15:14:55'),
(93, 'nancy', 'add date:2017-01-30', '2016-10-18 15:14:55'),
(94, 'nancy', 'add date:2017-01-31', '2016-10-18 15:14:55'),
(95, 'nancy', 'add date:2017-02-01', '2016-10-18 15:14:55'),
(96, 'nancy', 'add date:2017-02-02', '2016-10-18 15:14:55'),
(97, 'nancy', 'add date:2017-02-03', '2016-10-18 15:14:55'),
(98, 'nancy', 'add date:2017-02-04', '2016-10-18 15:14:55'),
(99, 'nancy', 'add date:2017-02-05', '2016-10-18 15:14:55'),
(100, 'nancy', 'add date:2017-02-06', '2016-10-18 15:14:56'),
(101, 'nancy', 'add date:2017-02-07', '2016-10-18 15:14:56'),
(102, 'nancy', 'add date:2017-02-08', '2016-10-18 15:14:56'),
(103, 'nancy', 'add date:2017-02-09', '2016-10-18 15:14:56'),
(104, 'nancy', 'add date:2017-02-10', '2016-10-18 15:14:56'),
(105, 'nancy', 'add date:2017-02-11', '2016-10-18 15:14:56'),
(106, 'nancy', 'add date:2017-02-12', '2016-10-18 15:14:56'),
(107, 'nancy', 'add date:2017-02-13', '2016-10-18 15:14:56'),
(108, 'nancy', 'add date:2017-02-14', '2016-10-18 15:14:56'),
(109, 'nancy', 'add date:2017-02-15', '2016-10-18 15:14:56'),
(110, 'nancy', 'add date:2017-02-16', '2016-10-18 15:14:56'),
(111, 'nancy', 'add date:2017-02-17', '2016-10-18 15:14:56'),
(112, 'nancy', 'add date:2017-02-18', '2016-10-18 15:14:56'),
(113, 'nancy', 'add date:2017-02-19', '2016-10-18 15:14:56'),
(114, 'nancy', 'add date:2017-02-20', '2016-10-18 15:14:56'),
(115, 'nancy', 'add date:2017-02-21', '2016-10-18 15:14:57'),
(116, 'nancy', 'add date:2017-02-22', '2016-10-18 15:14:57'),
(117, 'nancy', 'add date:2017-02-23', '2016-10-18 15:14:57'),
(118, 'nancy', 'add date:2017-02-24', '2016-10-18 15:14:57'),
(119, 'nancy', 'add date:2017-02-25', '2016-10-18 15:14:57'),
(120, 'nancy', 'add date:2017-02-26', '2016-10-18 15:14:57'),
(121, 'nancy', 'add date:2017-02-27', '2016-10-18 15:14:57'),
(122, 'nancy', 'add date:2017-02-28', '2016-10-18 15:14:57'),
(123, 'nancy', 'add date:2017-03-01', '2016-10-18 15:14:57'),
(124, 'nancy', 'add date:2017-03-02', '2016-10-18 15:14:57'),
(125, 'nancy', 'add date:2017-03-03', '2016-10-18 15:14:57'),
(126, 'nancy', 'add date:2017-03-04', '2016-10-18 15:14:57'),
(127, 'nancy', 'add date:2017-03-05', '2016-10-18 15:14:57'),
(128, 'nancy', 'add date:2017-03-06', '2016-10-18 15:14:57'),
(129, 'nancy', 'add date:2017-03-07', '2016-10-18 15:14:58'),
(130, 'nancy', 'add date:2017-03-08', '2016-10-18 15:14:58'),
(131, 'nancy', 'add date:2017-03-09', '2016-10-18 15:14:58'),
(132, 'nancy', 'add date:2017-03-10', '2016-10-18 15:14:58'),
(133, 'nancy', 'add date:2017-03-11', '2016-10-18 15:14:58'),
(134, 'nancy', 'add date:2017-03-12', '2016-10-18 15:14:58'),
(135, 'nancy', 'add date:2017-03-13', '2016-10-18 15:14:58'),
(136, 'nancy', 'add date:2017-03-14', '2016-10-18 15:14:58'),
(137, 'nancy', 'add date:2017-03-15', '2016-10-18 15:14:58'),
(138, 'nancy', 'add date:2017-03-16', '2016-10-18 15:14:58'),
(139, 'nancy', 'add date:2017-03-17', '2016-10-18 15:14:58'),
(140, 'nancy', 'add date:2017-03-18', '2016-10-18 15:14:58'),
(141, 'nancy', 'add date:2017-03-19', '2016-10-18 15:14:58'),
(142, 'nancy', 'add date:2017-03-20', '2016-10-18 15:14:58'),
(143, 'nancy', 'add date:2017-03-21', '2016-10-18 15:14:59'),
(144, 'nancy', 'add date:2017-03-22', '2016-10-18 15:14:59'),
(145, 'nancy', 'add date:2017-03-23', '2016-10-18 15:14:59'),
(146, 'nancy', 'add date:2017-03-24', '2016-10-18 15:14:59'),
(147, 'nancy', 'add date:2017-03-25', '2016-10-18 15:14:59'),
(148, 'nancy', 'add date:2017-03-26', '2016-10-18 15:14:59'),
(149, 'nancy', 'add date:2017-03-27', '2016-10-18 15:14:59'),
(150, 'nancy', 'add date:2017-03-28', '2016-10-18 15:14:59'),
(151, 'nancy', 'add date:2017-03-29', '2016-10-18 15:14:59'),
(152, 'nancy', 'add date:2017-03-30', '2016-10-18 15:14:59'),
(153, 'nancy', 'add date:2017-03-31', '2016-10-18 15:14:59'),
(154, 'nancy', 'add date:2017-04-01', '2016-10-18 15:14:59'),
(155, 'nancy', 'add date:2017-04-02', '2016-10-18 15:14:59'),
(156, 'nancy', 'add date:2017-04-03', '2016-10-18 15:14:59'),
(157, 'nancy', 'add date:2017-04-04', '2016-10-18 15:14:59'),
(158, 'nancy', 'add date:2017-04-05', '2016-10-18 15:15:00'),
(159, 'nancy', 'add date:2017-04-06', '2016-10-18 15:15:00'),
(160, 'nancy', 'add date:2017-04-07', '2016-10-18 15:15:00'),
(161, 'nancy', 'add date:2017-04-08', '2016-10-18 15:15:00'),
(162, 'nancy', 'add date:2017-04-09', '2016-10-18 15:15:00'),
(163, 'nancy', 'add date:2017-04-10', '2016-10-18 15:15:00'),
(164, 'nancy', 'add date:2017-04-11', '2016-10-18 15:15:00'),
(165, 'nancy', 'add date:2017-04-12', '2016-10-18 15:15:00'),
(166, 'nancy', 'add date:2017-04-13', '2016-10-18 15:15:00'),
(167, 'nancy', 'add date:2017-04-14', '2016-10-18 15:15:00'),
(168, 'nancy', 'add date:2017-04-15', '2016-10-18 15:15:00'),
(169, 'nancy', 'add date:2017-04-16', '2016-10-18 15:15:00'),
(170, 'nancy', 'add date:2017-04-17', '2016-10-18 15:15:00'),
(171, 'nancy', 'add date:2017-04-18', '2016-10-18 15:15:00'),
(172, 'nancy', 'add date:2017-04-19', '2016-10-18 15:15:00'),
(173, 'nancy', 'add date:2017-04-20', '2016-10-18 15:15:01'),
(174, 'nancy', 'add date:2017-04-21', '2016-10-18 15:15:01'),
(175, 'nancy', 'add date:2017-04-22', '2016-10-18 15:15:01'),
(176, 'nancy', 'add date:2017-04-23', '2016-10-18 15:15:01'),
(177, 'nancy', 'add date:2017-04-24', '2016-10-18 15:15:01'),
(178, 'nancy', 'add date:2017-04-25', '2016-10-18 15:15:01'),
(179, 'nancy', 'add date:2017-04-26', '2016-10-18 15:15:01'),
(180, 'nancy', 'add date:2017-04-27', '2016-10-18 15:15:01'),
(181, 'nancy', 'add date:2017-04-28', '2016-10-18 15:15:01'),
(182, 'nancy', 'add date:2017-04-29', '2016-10-18 15:15:01'),
(183, 'nancy', 'add date:2017-04-30', '2016-10-18 15:15:01'),
(184, 'nancy', 'add date:2017-05-01', '2016-10-18 15:15:01'),
(185, 'nancy', 'add date:2017-05-02', '2016-10-18 15:15:01'),
(186, 'nancy', 'add date:2017-05-03', '2016-10-18 15:15:01'),
(187, 'nancy', 'add date:2017-05-04', '2016-10-18 15:15:01'),
(188, 'nancy', 'add date:2017-05-05', '2016-10-18 15:15:02'),
(189, 'nancy', 'add date:2017-05-06', '2016-10-18 15:15:02'),
(190, 'nancy', 'add date:2017-05-07', '2016-10-18 15:15:02'),
(191, 'nancy', 'add date:2017-05-08', '2016-10-18 15:15:02'),
(192, 'nancy', 'add date:2017-05-09', '2016-10-18 15:15:02'),
(193, 'nancy', 'add date:2017-05-10', '2016-10-18 15:15:02'),
(194, 'nancy', 'add date:2017-05-11', '2016-10-18 15:15:02'),
(195, 'nancy', 'add date:2017-05-12', '2016-10-18 15:15:02'),
(196, 'nancy', 'add date:2017-05-13', '2016-10-18 15:15:02'),
(197, 'nancy', 'add date:2017-05-14', '2016-10-18 15:15:02'),
(198, 'nancy', 'add date:2017-05-15', '2016-10-18 15:15:02'),
(199, 'nancy', 'add date:2017-05-16', '2016-10-18 15:15:02'),
(200, 'nancy', 'add date:2017-05-17', '2016-10-18 15:15:02'),
(201, 'nancy', 'add date:2017-05-18', '2016-10-18 15:15:02'),
(202, 'nancy', 'add date:2017-05-19', '2016-10-18 15:15:02'),
(203, 'nancy', 'add date:2017-05-20', '2016-10-18 15:15:03'),
(204, 'nancy', 'add date:2017-05-21', '2016-10-18 15:15:03'),
(205, 'nancy', 'add date:2017-05-22', '2016-10-18 15:15:03'),
(206, 'nancy', 'add date:2017-05-23', '2016-10-18 15:15:03'),
(207, 'nancy', 'add date:2017-05-24', '2016-10-18 15:15:03'),
(208, 'nancy', 'add date:2017-05-25', '2016-10-18 15:15:03'),
(209, 'nancy', 'add date:2017-05-26', '2016-10-18 15:15:03'),
(210, 'nancy', 'add date:2017-05-27', '2016-10-18 15:15:03'),
(211, 'nancy', 'add date:2017-05-28', '2016-10-18 15:15:03'),
(212, 'nancy', 'add date:2017-05-29', '2016-10-18 15:15:03'),
(213, 'nancy', 'add date:2017-05-30', '2016-10-18 15:15:03'),
(214, 'nancy', 'add date:2017-05-31', '2016-10-18 15:15:03'),
(215, 'nancy', 'add date:2017-06-01', '2016-10-18 15:15:03'),
(216, 'nancy', 'add date:2017-06-02', '2016-10-18 15:15:03'),
(217, 'nancy', 'add date:2017-06-03', '2016-10-18 15:15:04'),
(218, 'nancy', 'add date:2017-06-04', '2016-10-18 15:15:04'),
(219, 'nancy', 'add date:2017-06-05', '2016-10-18 15:15:04'),
(220, 'nancy', 'add date:2017-06-06', '2016-10-18 15:15:04'),
(221, 'nancy', 'add date:2017-06-07', '2016-10-18 15:15:04'),
(222, 'nancy', 'add date:2017-06-08', '2016-10-18 15:15:04'),
(223, 'nancy', 'add date:2017-06-09', '2016-10-18 15:15:04'),
(224, 'nancy', 'add date:2017-06-10', '2016-10-18 15:15:04'),
(225, 'nancy', 'add date:2017-06-11', '2016-10-18 15:15:04'),
(226, 'nancy', 'add date:2017-06-12', '2016-10-18 15:15:04'),
(227, 'nancy', 'add date:2017-06-13', '2016-10-18 15:15:04'),
(228, 'nancy', 'add date:2017-06-14', '2016-10-18 15:15:04'),
(229, 'nancy', 'add date:2017-06-15', '2016-10-18 15:15:04'),
(230, 'nancy', 'add date:2017-06-16', '2016-10-18 15:15:04'),
(231, 'nancy', 'add date:2017-06-17', '2016-10-18 15:15:05'),
(232, 'nancy', 'add date:2017-06-18', '2016-10-18 15:15:05'),
(233, 'nancy', 'add date:2017-06-19', '2016-10-18 15:15:05'),
(234, 'nancy', 'add date:2017-06-20', '2016-10-18 15:15:05'),
(235, 'nancy', 'add date:2017-06-21', '2016-10-18 15:15:05'),
(236, 'nancy', 'add date:2017-06-22', '2016-10-18 15:15:05'),
(237, 'nancy', 'add date:2017-06-23', '2016-10-18 15:15:05'),
(238, 'nancy', 'add date:2017-06-24', '2016-10-18 15:15:05'),
(239, 'nancy', 'add date:2017-06-25', '2016-10-18 15:15:05'),
(240, 'nancy', 'add date:2017-06-26', '2016-10-18 15:15:05'),
(241, 'nancy', 'add date:2017-06-27', '2016-10-18 15:15:05'),
(242, 'nancy', 'add date:2017-06-28', '2016-10-18 15:15:05'),
(243, 'nancy', 'add date:2017-06-29', '2016-10-18 15:15:05'),
(244, 'nancy', 'add date:2017-06-30', '2016-10-18 15:15:05'),
(245, 'nancy', 'add date:2017-07-01', '2016-10-18 15:15:06'),
(246, 'nancy', 'add date:2017-07-02', '2016-10-18 15:15:06'),
(247, 'nancy', 'add date:2017-07-03', '2016-10-18 15:15:06'),
(248, 'nancy', 'add date:2017-07-04', '2016-10-18 15:15:06'),
(249, 'nancy', 'add date:2017-07-05', '2016-10-18 15:15:06'),
(250, 'nancy', 'add date:2017-07-06', '2016-10-18 15:15:06'),
(251, 'nancy', 'add date:2017-07-07', '2016-10-18 15:15:06'),
(252, 'nancy', 'add date:2017-07-08', '2016-10-18 15:15:06'),
(253, 'nancy', 'add date:2017-07-09', '2016-10-18 15:15:06'),
(254, 'nancy', 'add date:2017-07-10', '2016-10-18 15:15:06'),
(255, 'nancy', 'add date:2017-07-11', '2016-10-18 15:15:06'),
(256, 'nancy', 'add date:2017-07-12', '2016-10-18 15:15:06'),
(257, 'nancy', 'add date:2017-07-13', '2016-10-18 15:15:06'),
(258, 'nancy', 'add date:2017-07-14', '2016-10-18 15:15:06'),
(259, 'nancy', 'add date:2017-07-15', '2016-10-18 15:15:07'),
(260, 'nancy', 'add date:2017-07-16', '2016-10-18 15:15:07'),
(261, 'nancy', 'add date:2017-07-17', '2016-10-18 15:15:07'),
(262, 'nancy', 'add date:2017-07-18', '2016-10-18 15:15:07'),
(263, 'nancy', 'add date:2017-07-19', '2016-10-18 15:15:07'),
(264, 'nancy', 'add date:2017-07-20', '2016-10-18 15:15:07'),
(265, 'nancy', 'add date:2017-07-21', '2016-10-18 15:15:07'),
(266, 'nancy', 'add date:2017-07-22', '2016-10-18 15:15:07'),
(267, 'nancy', 'add date:2017-07-23', '2016-10-18 15:15:07'),
(268, 'nancy', 'add date:2017-07-24', '2016-10-18 15:15:07'),
(269, 'nancy', 'add date:2017-07-25', '2016-10-18 15:15:07'),
(270, 'nancy', 'add date:2017-07-26', '2016-10-18 15:15:07'),
(271, 'nancy', 'add date:2017-07-27', '2016-10-18 15:15:07'),
(272, 'nancy', 'add date:2017-07-28', '2016-10-18 15:15:07'),
(273, 'nancy', 'add date:2017-07-29', '2016-10-18 15:15:07'),
(274, 'nancy', 'add date:2017-07-30', '2016-10-18 15:15:08'),
(275, 'nancy', 'add date:2017-07-31', '2016-10-18 15:15:08'),
(276, 'nancy', 'add date:2017-08-01', '2016-10-18 15:15:08'),
(277, 'nancy', 'add date:2017-08-02', '2016-10-18 15:15:08'),
(278, 'nancy', 'add date:2017-08-03', '2016-10-18 15:15:08'),
(279, 'nancy', 'add date:2017-08-04', '2016-10-18 15:15:08'),
(280, 'nancy', 'add date:2017-08-05', '2016-10-18 15:15:08'),
(281, 'nancy', 'add date:2017-08-06', '2016-10-18 15:15:08'),
(282, 'nancy', 'add date:2017-08-07', '2016-10-18 15:15:08'),
(283, 'nancy', 'add date:2017-08-08', '2016-10-18 15:15:08'),
(284, 'nancy', 'add date:2017-08-09', '2016-10-18 15:15:08'),
(285, 'nancy', 'add date:2017-08-10', '2016-10-18 15:15:08'),
(286, 'nancy', 'add date:2017-08-11', '2016-10-18 15:15:08'),
(287, 'nancy', 'add date:2017-08-12', '2016-10-18 15:15:08'),
(288, 'nancy', 'add date:2017-08-13', '2016-10-18 15:15:08'),
(289, 'nancy', 'add date:2017-08-14', '2016-10-18 15:15:09'),
(290, 'nancy', 'add date:2017-08-15', '2016-10-18 15:15:09'),
(291, 'nancy', 'add date:2017-08-16', '2016-10-18 15:15:09'),
(292, 'nancy', 'add date:2017-08-17', '2016-10-18 15:15:09'),
(293, 'nancy', 'add date:2017-08-18', '2016-10-18 15:15:09'),
(294, 'nancy', 'add date:2017-08-19', '2016-10-18 15:15:09'),
(295, 'nancy', 'add date:2017-08-20', '2016-10-18 15:15:09'),
(296, 'nancy', 'add date:2017-08-21', '2016-10-18 15:15:09'),
(297, 'nancy', 'add date:2017-08-22', '2016-10-18 15:15:09'),
(298, 'nancy', 'add date:2017-08-23', '2016-10-18 15:15:09'),
(299, 'nancy', 'add date:2017-08-24', '2016-10-18 15:15:09'),
(300, 'nancy', 'add date:2017-08-25', '2016-10-18 15:15:09'),
(301, 'nancy', 'add date:2017-08-26', '2016-10-18 15:15:09'),
(302, 'nancy', 'add date:2017-08-27', '2016-10-18 15:15:09'),
(303, 'nancy', 'add date:2017-08-28', '2016-10-18 15:15:10'),
(304, 'nancy', 'add date:2017-08-29', '2016-10-18 15:15:10'),
(305, 'nancy', 'add date:2017-08-30', '2016-10-18 15:15:10'),
(306, 'nancy', 'add date:2017-08-31', '2016-10-18 15:15:10'),
(307, 'nancy', 'add date:2017-09-01', '2016-10-18 15:15:10'),
(308, 'nancy', 'add date:2017-09-02', '2016-10-18 15:15:10'),
(309, 'nancy', 'add date:2017-09-03', '2016-10-18 15:15:10'),
(310, 'nancy', 'add date:2017-09-04', '2016-10-18 15:15:10'),
(311, 'nancy', 'add date:2017-09-05', '2016-10-18 15:15:10'),
(312, 'nancy', 'add date:2017-09-06', '2016-10-18 15:15:10'),
(313, 'nancy', 'add date:2017-09-07', '2016-10-18 15:15:10'),
(314, 'nancy', 'add date:2017-09-08', '2016-10-18 15:15:10'),
(315, 'nancy', 'add date:2017-09-09', '2016-10-18 15:15:10'),
(316, 'nancy', 'add date:2017-09-10', '2016-10-18 15:15:10'),
(317, 'nancy', 'add date:2017-09-11', '2016-10-18 15:15:10'),
(318, 'nancy', 'add date:2017-09-12', '2016-10-18 15:15:11'),
(319, 'nancy', 'add date:2017-09-13', '2016-10-18 15:15:11'),
(320, 'nancy', 'add date:2017-09-14', '2016-10-18 15:15:11'),
(321, 'nancy', 'add date:2017-09-15', '2016-10-18 15:15:11'),
(322, 'nancy', 'add date:2017-09-16', '2016-10-18 15:15:11'),
(323, 'nancy', 'add date:2017-09-17', '2016-10-18 15:15:11'),
(324, 'nancy', 'add date:2017-09-18', '2016-10-18 15:15:11'),
(325, 'nancy', 'add date:2017-09-19', '2016-10-18 15:15:11'),
(326, 'nancy', 'add date:2017-09-20', '2016-10-18 15:15:11'),
(327, 'nancy', 'add date:2017-09-21', '2016-10-18 15:15:11'),
(328, 'nancy', 'add date:2017-09-22', '2016-10-18 15:15:11'),
(329, 'nancy', 'add date:2017-09-23', '2016-10-18 15:15:11'),
(330, 'nancy', 'add date:2017-09-24', '2016-10-18 15:15:11'),
(331, 'nancy', 'add date:2017-09-25', '2016-10-18 15:15:11'),
(332, 'nancy', 'add date:2017-09-26', '2016-10-18 15:15:12'),
(333, 'nancy', 'add date:2017-09-27', '2016-10-18 15:15:12'),
(334, 'nancy', 'add date:2017-09-28', '2016-10-18 15:15:12'),
(335, 'nancy', 'add date:2017-09-29', '2016-10-18 15:15:12'),
(336, 'nancy', 'add date:2017-09-30', '2016-10-18 15:15:12'),
(337, 'nancy', 'add date:2017-10-01', '2016-10-18 15:15:12'),
(338, 'nancy', 'add date:2017-10-02', '2016-10-18 15:15:12'),
(339, 'nancy', 'add date:2017-10-03', '2016-10-18 15:15:12'),
(340, 'nancy', 'add date:2017-10-04', '2016-10-18 15:15:12'),
(341, 'nancy', 'add date:2017-10-05', '2016-10-18 15:15:12'),
(342, 'nancy', 'add date:2017-10-06', '2016-10-18 15:15:12'),
(343, 'nancy', 'add date:2017-10-07', '2016-10-18 15:15:12'),
(344, 'nancy', 'add date:2017-10-08', '2016-10-18 15:15:12'),
(345, 'nancy', 'add date:2017-10-09', '2016-10-18 15:15:12'),
(346, 'nancy', 'add date:2017-10-10', '2016-10-18 15:15:12'),
(347, 'nancy', 'add date:2017-10-11', '2016-10-18 15:15:13'),
(348, 'nancy', 'add date:2017-10-12', '2016-10-18 15:15:13'),
(349, 'nancy', 'add date:2017-10-13', '2016-10-18 15:15:13'),
(350, 'nancy', 'add date:2017-10-14', '2016-10-18 15:15:13'),
(351, 'nancy', 'add date:2017-10-15', '2016-10-18 15:15:13'),
(352, 'nancy', 'add date:2017-10-16', '2016-10-18 15:15:13'),
(353, 'nancy', 'add date:2017-10-17', '2016-10-18 15:15:13'),
(354, 'nancy', 'add date:2017-10-18', '2016-10-18 15:15:13'),
(355, 'nancy', 'add date:2017-10-19', '2016-10-18 15:15:13'),
(356, 'nancy', 'add date:2017-10-20', '2016-10-18 15:15:13'),
(357, 'nancy', 'add date:2017-10-21', '2016-10-18 15:15:13'),
(358, 'nancy', 'add date:2017-10-22', '2016-10-18 15:15:13'),
(359, 'nancy', 'add date:2017-10-23', '2016-10-18 15:15:13'),
(360, 'nancy', 'add date:2017-10-24', '2016-10-18 15:15:13'),
(361, 'nancy', 'add date:2017-10-25', '2016-10-18 15:15:14'),
(362, 'nancy', 'add date:2017-10-26', '2016-10-18 15:15:14'),
(363, 'nancy', 'add date:2017-10-27', '2016-10-18 15:15:14'),
(364, 'nancy', 'add date:2017-10-28', '2016-10-18 15:15:14'),
(365, 'nancy', 'add date:2017-10-29', '2016-10-18 15:15:14'),
(366, 'nancy', 'add date:2017-10-30', '2016-10-18 15:15:14'),
(367, 'nancy', 'add date:2017-10-31', '2016-10-18 15:15:14'),
(368, 'nancy', 'add date:2017-11-01', '2016-10-18 15:15:14'),
(369, 'nancy', 'add date:2017-11-02', '2016-10-18 15:15:14'),
(370, 'nancy', 'add date:2017-11-03', '2016-10-18 15:15:14'),
(371, 'nancy', 'add date:2017-11-04', '2016-10-18 15:15:14'),
(372, 'nancy', 'add date:2017-11-05', '2016-10-18 15:15:14'),
(373, 'nancy', 'add date:2017-11-06', '2016-10-18 15:15:14'),
(374, 'nancy', 'add date:2017-11-07', '2016-10-18 15:15:15'),
(375, 'nancy', 'add date:2017-11-08', '2016-10-18 15:15:15'),
(376, 'nancy', 'add date:2017-11-09', '2016-10-18 15:15:15'),
(377, 'nancy', 'add date:2017-11-10', '2016-10-18 15:15:15'),
(378, 'nancy', 'add date:2017-11-11', '2016-10-18 15:15:15'),
(379, 'nancy', 'add date:2017-11-12', '2016-10-18 15:15:15'),
(380, 'nancy', 'add date:2017-11-13', '2016-10-18 15:15:15'),
(381, 'nancy', 'add date:2017-11-14', '2016-10-18 15:15:15'),
(382, 'nancy', 'add date:2017-11-15', '2016-10-18 15:15:15'),
(383, 'nancy', 'add date:2017-11-16', '2016-10-18 15:15:15'),
(384, 'nancy', 'add date:2017-11-17', '2016-10-18 15:15:15'),
(385, 'nancy', 'add date:2017-11-18', '2016-10-18 15:15:15'),
(386, 'nancy', 'add date:2017-11-19', '2016-10-18 15:15:15'),
(387, 'nancy', 'add date:2017-11-20', '2016-10-18 15:15:15'),
(388, 'nancy', 'add date:2017-11-21', '2016-10-18 15:15:15'),
(389, 'nancy', 'add date:2017-11-22', '2016-10-18 15:15:16'),
(390, 'nancy', 'add date:2017-11-23', '2016-10-18 15:15:16'),
(391, 'nancy', 'add date:2017-11-24', '2016-10-18 15:15:16'),
(392, 'nancy', 'add date:2017-11-25', '2016-10-18 15:15:16'),
(393, 'nancy', 'add date:2017-11-26', '2016-10-18 15:15:16'),
(394, 'nancy', 'add date:2017-11-27', '2016-10-18 15:15:16'),
(395, 'nancy', 'add date:2017-11-28', '2016-10-18 15:15:16'),
(396, 'nancy', 'add date:2017-11-29', '2016-10-18 15:15:16'),
(397, 'nancy', 'add date:2017-11-30', '2016-10-18 15:15:16'),
(398, 'nancy', 'add date:2017-12-01', '2016-10-18 15:15:16'),
(399, 'nancy', 'add date:2017-12-02', '2016-10-18 15:15:16'),
(400, 'nancy', 'add date:2017-12-03', '2016-10-18 15:15:16'),
(401, 'nancy', 'add date:2017-12-04', '2016-10-18 15:15:16'),
(402, 'nancy', 'add date:2017-12-05', '2016-10-18 15:15:16'),
(403, 'nancy', 'add date:2017-12-06', '2016-10-18 15:15:16'),
(404, 'nancy', 'add date:2017-12-07', '2016-10-18 15:15:17'),
(405, 'nancy', 'add date:2017-12-08', '2016-10-18 15:15:17'),
(406, 'nancy', 'add date:2017-12-09', '2016-10-18 15:15:17'),
(407, 'nancy', 'add date:2017-12-10', '2016-10-18 15:15:17'),
(408, 'nancy', 'add date:2017-12-11', '2016-10-18 15:15:17'),
(409, 'nancy', 'add date:2017-12-12', '2016-10-18 15:15:17'),
(410, 'nancy', 'add date:2017-12-13', '2016-10-18 15:15:17'),
(411, 'nancy', 'add date:2017-12-14', '2016-10-18 15:15:17'),
(412, 'nancy', 'add date:2017-12-15', '2016-10-18 15:15:17'),
(413, 'nancy', 'add date:2017-12-16', '2016-10-18 15:15:17'),
(414, 'nancy', 'add date:2017-12-17', '2016-10-18 15:15:17'),
(415, 'nancy', 'add date:2017-12-18', '2016-10-18 15:15:17'),
(416, 'nancy', 'add date:2017-12-19', '2016-10-18 15:15:17'),
(417, 'nancy', 'add date:2017-12-20', '2016-10-18 15:15:17'),
(418, 'nancy', 'add date:2017-12-21', '2016-10-18 15:15:17'),
(419, 'nancy', 'add date:2017-12-22', '2016-10-18 15:15:18'),
(420, 'nancy', 'add date:2017-12-23', '2016-10-18 15:15:18'),
(421, 'nancy', 'add date:2017-12-24', '2016-10-18 15:15:18'),
(422, 'nancy', 'add date:2017-12-25', '2016-10-18 15:15:18'),
(423, 'nancy', 'add date:2017-12-26', '2016-10-18 15:15:18'),
(424, 'nancy', 'add date:2017-12-27', '2016-10-18 15:15:18'),
(425, 'nancy', 'add date:2017-12-28', '2016-10-18 15:15:18'),
(426, 'nancy', 'add date:2017-12-29', '2016-10-18 15:15:18'),
(427, 'nancy', 'add date:2017-12-30', '2016-10-18 15:15:18'),
(428, 'nancy', 'add date:2017-12-31', '2016-10-18 15:15:18'),
(429, 'hans', 'add date:2016-12-01', '2016-11-15 08:50:06'),
(430, 'hans', 'add date:2016-12-02', '2016-11-15 08:50:06'),
(431, 'hans', 'add date:2016-12-03', '2016-11-15 08:50:06'),
(432, 'hans', 'add date:2016-12-04', '2016-11-15 08:50:06'),
(433, 'hans', 'add date:2016-12-05', '2016-11-15 08:50:06'),
(434, 'hans', 'add date:2016-12-06', '2016-11-15 08:50:06'),
(435, 'hans', 'add date:2016-12-07', '2016-11-15 08:50:06'),
(436, 'hans', 'add date:2016-12-08', '2016-11-15 08:50:07'),
(437, 'hans', 'add date:2016-12-09', '2016-11-15 08:50:07'),
(438, 'hans', 'add date:2016-12-10', '2016-11-15 08:50:07'),
(439, 'hans', 'add date:2016-12-11', '2016-11-15 08:50:07'),
(440, 'hans', 'add date:2016-12-12', '2016-11-15 08:50:07'),
(441, 'hans', 'add date:2016-12-13', '2016-11-15 08:50:07'),
(442, 'hans', 'add date:2016-12-14', '2016-11-15 08:50:07'),
(443, 'hans', 'add date:2016-12-15', '2016-11-15 08:50:07'),
(444, 'hans', 'add date:2016-12-16', '2016-11-15 08:50:07'),
(445, 'hans', 'add date:2016-12-17', '2016-11-15 08:50:07'),
(446, 'hans', 'add date:2016-12-18', '2016-11-15 08:50:07'),
(447, 'hans', 'add date:2016-12-19', '2016-11-15 08:50:07'),
(448, 'hans', 'add date:2016-12-20', '2016-11-15 08:50:07'),
(449, 'hans', 'add date:2016-12-21', '2016-11-15 08:50:07'),
(450, 'hans', 'add date:2016-12-22', '2016-11-15 08:50:07'),
(451, 'hans', 'add date:2016-12-23', '2016-11-15 08:50:07'),
(452, 'hans', 'add date:2016-12-24', '2016-11-15 08:50:07'),
(453, 'hans', 'add date:2016-12-25', '2016-11-15 08:50:08'),
(454, 'hans', 'add date:2016-12-26', '2016-11-15 08:50:08'),
(455, 'hans', 'add date:2016-12-27', '2016-11-15 08:50:08'),
(456, 'hans', 'add date:2016-12-28', '2016-11-15 08:50:08'),
(457, 'hans', 'add date:2016-12-29', '2016-11-15 08:50:08'),
(458, 'hans', 'add date:2016-12-30', '2016-11-15 08:50:08'),
(459, 'hans', 'add date:2016-12-31', '2016-11-15 08:50:08'),
(460, 'hans', 'add date:2016-05-01', '2016-11-30 07:59:01'),
(461, 'hans', 'add date:2016-05-02', '2016-11-30 07:59:01'),
(462, 'hans', 'add date:2016-05-03', '2016-11-30 07:59:01'),
(463, 'hans', 'add date:2016-05-04', '2016-11-30 07:59:01'),
(464, 'hans', 'add date:2016-05-05', '2016-11-30 07:59:01'),
(465, 'hans', 'add date:2016-05-06', '2016-11-30 07:59:02'),
(466, 'hans', 'add date:2016-05-07', '2016-11-30 07:59:02'),
(467, 'hans', 'add date:2016-05-08', '2016-11-30 07:59:02'),
(468, 'hans', 'add date:2016-05-09', '2016-11-30 07:59:02'),
(469, 'hans', 'add date:2016-05-10', '2016-11-30 07:59:02'),
(470, 'hans', 'add date:2016-05-11', '2016-11-30 07:59:02'),
(471, 'hans', 'add date:2016-05-12', '2016-11-30 07:59:02'),
(472, 'hans', 'add date:2016-05-13', '2016-11-30 07:59:02'),
(473, 'hans', 'add date:2016-05-14', '2016-11-30 07:59:02'),
(474, 'hans', 'add date:2016-05-15', '2016-11-30 07:59:02'),
(475, 'hans', 'add date:2016-05-16', '2016-11-30 07:59:02'),
(476, 'hans', 'add date:2016-05-17', '2016-11-30 07:59:02'),
(477, 'hans', 'add date:2016-05-18', '2016-11-30 07:59:02'),
(478, 'hans', 'add date:2016-05-19', '2016-11-30 07:59:02'),
(479, 'hans', 'add date:2016-05-20', '2016-11-30 07:59:02'),
(480, 'hans', 'add date:2016-05-21', '2016-11-30 07:59:02'),
(481, 'hans', 'add date:2016-05-22', '2016-11-30 07:59:02'),
(482, 'hans', 'add date:2016-05-23', '2016-11-30 07:59:02'),
(483, 'hans', 'add date:2016-05-24', '2016-11-30 07:59:02'),
(484, 'hans', 'add date:2016-05-25', '2016-11-30 07:59:02'),
(485, 'hans', 'add date:2016-05-26', '2016-11-30 07:59:02'),
(486, 'hans', 'add date:2016-05-27', '2016-11-30 07:59:02'),
(487, 'hans', 'add date:2016-05-28', '2016-11-30 07:59:02'),
(488, 'hans', 'add date:2016-05-29', '2016-11-30 07:59:02'),
(489, 'hans', 'add date:2016-05-30', '2016-11-30 07:59:02'),
(490, 'hans', 'add date:2016-05-31', '2016-11-30 07:59:02'),
(491, 'hans', 'add date:2016-06-01', '2016-11-30 07:59:43'),
(492, 'hans', 'add date:2016-06-02', '2016-11-30 07:59:43'),
(493, 'hans', 'add date:2016-06-03', '2016-11-30 07:59:43'),
(494, 'hans', 'add date:2016-06-04', '2016-11-30 07:59:43'),
(495, 'hans', 'add date:2016-06-05', '2016-11-30 07:59:43'),
(496, 'hans', 'add date:2016-06-06', '2016-11-30 07:59:43'),
(497, 'hans', 'add date:2016-06-07', '2016-11-30 07:59:43'),
(498, 'hans', 'add date:2016-06-08', '2016-11-30 07:59:43'),
(499, 'hans', 'add date:2016-06-09', '2016-11-30 07:59:43'),
(500, 'hans', 'add date:2016-06-10', '2016-11-30 07:59:44'),
(501, 'hans', 'add date:2016-06-11', '2016-11-30 07:59:44'),
(502, 'hans', 'add date:2016-06-12', '2016-11-30 07:59:44'),
(503, 'hans', 'add date:2016-06-13', '2016-11-30 07:59:44'),
(504, 'hans', 'add date:2016-06-14', '2016-11-30 07:59:44'),
(505, 'hans', 'add date:2016-06-15', '2016-11-30 07:59:44'),
(506, 'hans', 'add date:2016-06-16', '2016-11-30 07:59:44'),
(507, 'hans', 'add date:2016-06-17', '2016-11-30 07:59:44'),
(508, 'hans', 'add date:2016-06-18', '2016-11-30 07:59:44'),
(509, 'hans', 'add date:2016-06-19', '2016-11-30 07:59:44'),
(510, 'hans', 'add date:2016-06-20', '2016-11-30 07:59:44'),
(511, 'hans', 'add date:2016-06-21', '2016-11-30 07:59:44'),
(512, 'hans', 'add date:2016-06-22', '2016-11-30 07:59:44'),
(513, 'hans', 'add date:2016-06-23', '2016-11-30 07:59:44'),
(514, 'hans', 'add date:2016-06-24', '2016-11-30 07:59:44'),
(515, 'hans', 'add date:2016-06-25', '2016-11-30 07:59:44'),
(516, 'hans', 'add date:2016-06-26', '2016-11-30 07:59:44'),
(517, 'hans', 'add date:2016-06-27', '2016-11-30 07:59:44'),
(518, 'hans', 'add date:2016-06-28', '2016-11-30 07:59:44'),
(519, 'hans', 'add date:2016-06-29', '2016-11-30 07:59:45'),
(520, 'hans', 'add date:2016-06-30', '2016-11-30 07:59:45'),
(521, 'hans', 'add date:2016-07-01', '2016-11-30 07:59:45'),
(522, 'hans', 'add date:2016-07-02', '2016-11-30 07:59:45'),
(523, 'hans', 'add date:2016-07-03', '2016-11-30 07:59:45'),
(524, 'hans', 'add date:2016-07-04', '2016-11-30 07:59:45'),
(525, 'hans', 'add date:2016-07-05', '2016-11-30 07:59:45'),
(526, 'hans', 'add date:2016-07-06', '2016-11-30 07:59:45'),
(527, 'hans', 'add date:2016-07-07', '2016-11-30 07:59:45'),
(528, 'hans', 'add date:2016-07-08', '2016-11-30 07:59:45'),
(529, 'hans', 'add date:2016-07-09', '2016-11-30 07:59:45'),
(530, 'hans', 'add date:2016-07-10', '2016-11-30 07:59:45'),
(531, 'hans', 'add date:2016-07-11', '2016-11-30 07:59:45'),
(532, 'hans', 'add date:2016-07-12', '2016-11-30 07:59:45'),
(533, 'hans', 'add date:2016-07-13', '2016-11-30 07:59:45'),
(534, 'hans', 'add date:2016-07-14', '2016-11-30 07:59:45'),
(535, 'hans', 'add date:2016-07-15', '2016-11-30 07:59:45'),
(536, 'hans', 'add date:2016-07-16', '2016-11-30 07:59:45'),
(537, 'hans', 'add date:2016-07-17', '2016-11-30 07:59:45'),
(538, 'hans', 'add date:2016-07-18', '2016-11-30 07:59:45'),
(539, 'hans', 'add date:2016-07-19', '2016-11-30 07:59:45'),
(540, 'hans', 'add date:2016-07-20', '2016-11-30 07:59:45'),
(541, 'hans', 'add date:2016-07-21', '2016-11-30 07:59:46'),
(542, 'hans', 'add date:2016-07-22', '2016-11-30 07:59:46'),
(543, 'hans', 'add date:2016-07-23', '2016-11-30 07:59:46'),
(544, 'hans', 'add date:2016-07-24', '2016-11-30 07:59:46'),
(545, 'hans', 'add date:2016-07-25', '2016-11-30 07:59:46'),
(546, 'hans', 'add date:2016-07-26', '2016-11-30 07:59:46'),
(547, 'hans', 'add date:2016-07-27', '2016-11-30 07:59:46'),
(548, 'hans', 'add date:2016-07-28', '2016-11-30 07:59:46'),
(549, 'hans', 'add date:2016-07-29', '2016-11-30 07:59:46'),
(550, 'hans', 'add date:2016-07-30', '2016-11-30 07:59:46'),
(551, 'hans', 'add date:2016-07-31', '2016-11-30 07:59:46'),
(552, 'hans', 'add date:2016-01-01', '2016-11-30 08:19:38'),
(553, 'hans', 'add date:2016-01-02', '2016-11-30 08:19:38'),
(554, 'hans', 'add date:2016-01-03', '2016-11-30 08:19:38'),
(555, 'hans', 'add date:2016-01-04', '2016-11-30 08:19:38'),
(556, 'hans', 'add date:2016-01-05', '2016-11-30 08:19:38'),
(557, 'hans', 'add date:2016-01-06', '2016-11-30 08:19:38'),
(558, 'hans', 'add date:2016-01-07', '2016-11-30 08:19:38'),
(559, 'hans', 'add date:2016-01-08', '2016-11-30 08:19:38'),
(560, 'hans', 'add date:2016-01-09', '2016-11-30 08:19:38'),
(561, 'hans', 'add date:2016-01-10', '2016-11-30 08:19:38'),
(562, 'hans', 'add date:2016-01-11', '2016-11-30 08:19:38'),
(563, 'hans', 'add date:2016-01-12', '2016-11-30 08:19:38'),
(564, 'hans', 'add date:2016-01-13', '2016-11-30 08:19:38'),
(565, 'hans', 'add date:2016-01-14', '2016-11-30 08:19:38'),
(566, 'hans', 'add date:2016-01-15', '2016-11-30 08:19:38'),
(567, 'hans', 'add date:2016-01-16', '2016-11-30 08:19:38'),
(568, 'hans', 'add date:2016-01-17', '2016-11-30 08:19:38'),
(569, 'hans', 'add date:2016-01-18', '2016-11-30 08:19:39'),
(570, 'hans', 'add date:2016-01-19', '2016-11-30 08:19:39'),
(571, 'hans', 'add date:2016-01-20', '2016-11-30 08:19:39'),
(572, 'hans', 'add date:2016-01-21', '2016-11-30 08:19:39'),
(573, 'hans', 'add date:2016-01-22', '2016-11-30 08:19:39'),
(574, 'hans', 'add date:2016-01-23', '2016-11-30 08:19:39'),
(575, 'hans', 'add date:2016-01-24', '2016-11-30 08:19:39'),
(576, 'hans', 'add date:2016-01-25', '2016-11-30 08:19:39'),
(577, 'hans', 'add date:2016-01-26', '2016-11-30 08:19:39'),
(578, 'hans', 'add date:2016-01-27', '2016-11-30 08:19:39'),
(579, 'hans', 'add date:2016-01-28', '2016-11-30 08:19:39'),
(580, 'hans', 'add date:2016-01-29', '2016-11-30 08:19:39'),
(581, 'hans', 'add date:2016-01-30', '2016-11-30 08:19:39'),
(582, 'hans', 'add date:2016-01-31', '2016-11-30 08:19:39'),
(583, 'hans', 'add date:2016-02-01', '2016-11-30 08:19:40'),
(584, 'hans', 'add date:2016-02-02', '2016-11-30 08:19:40'),
(585, 'hans', 'add date:2016-02-03', '2016-11-30 08:19:40'),
(586, 'hans', 'add date:2016-02-04', '2016-11-30 08:19:40'),
(587, 'hans', 'add date:2016-02-05', '2016-11-30 08:19:40'),
(588, 'hans', 'add date:2016-02-06', '2016-11-30 08:19:40'),
(589, 'hans', 'add date:2016-02-07', '2016-11-30 08:19:40'),
(590, 'hans', 'add date:2016-02-08', '2016-11-30 08:19:40'),
(591, 'hans', 'add date:2016-02-09', '2016-11-30 08:19:40'),
(592, 'hans', 'add date:2016-02-10', '2016-11-30 08:19:40'),
(593, 'hans', 'add date:2016-02-11', '2016-11-30 08:19:40'),
(594, 'hans', 'add date:2016-02-12', '2016-11-30 08:19:40'),
(595, 'hans', 'add date:2016-02-13', '2016-11-30 08:19:40'),
(596, 'hans', 'add date:2016-02-14', '2016-11-30 08:19:40'),
(597, 'hans', 'add date:2016-02-15', '2016-11-30 08:19:40'),
(598, 'hans', 'add date:2016-02-16', '2016-11-30 08:19:40'),
(599, 'hans', 'add date:2016-02-17', '2016-11-30 08:19:40'),
(600, 'hans', 'add date:2016-02-18', '2016-11-30 08:19:40'),
(601, 'hans', 'add date:2016-02-19', '2016-11-30 08:19:40'),
(602, 'hans', 'add date:2016-02-20', '2016-11-30 08:19:40'),
(603, 'hans', 'add date:2016-02-21', '2016-11-30 08:19:40'),
(604, 'hans', 'add date:2016-02-22', '2016-11-30 08:19:41'),
(605, 'hans', 'add date:2016-02-23', '2016-11-30 08:19:41'),
(606, 'hans', 'add date:2016-02-24', '2016-11-30 08:19:41'),
(607, 'hans', 'add date:2016-02-25', '2016-11-30 08:19:41'),
(608, 'hans', 'add date:2016-02-26', '2016-11-30 08:19:41'),
(609, 'hans', 'add date:2016-02-27', '2016-11-30 08:19:41'),
(610, 'hans', 'add date:2016-02-28', '2016-11-30 08:19:41'),
(611, 'hans', 'add date:2016-02-29', '2016-11-30 08:19:41'),
(612, 'hans', 'add date:2016-03-01', '2016-11-30 08:19:41'),
(613, 'hans', 'add date:2016-03-02', '2016-11-30 08:19:41'),
(614, 'hans', 'add date:2016-03-03', '2016-11-30 08:19:41'),
(615, 'hans', 'add date:2016-03-04', '2016-11-30 08:19:41'),
(616, 'hans', 'add date:2016-03-05', '2016-11-30 08:19:41'),
(617, 'hans', 'add date:2016-03-06', '2016-11-30 08:19:41'),
(618, 'hans', 'add date:2016-03-07', '2016-11-30 08:19:41'),
(619, 'hans', 'add date:2016-03-08', '2016-11-30 08:19:41'),
(620, 'hans', 'add date:2016-03-09', '2016-11-30 08:19:41'),
(621, 'hans', 'add date:2016-03-10', '2016-11-30 08:19:41'),
(622, 'hans', 'add date:2016-03-11', '2016-11-30 08:19:41'),
(623, 'hans', 'add date:2016-03-12', '2016-11-30 08:19:41'),
(624, 'hans', 'add date:2016-03-13', '2016-11-30 08:19:41'),
(625, 'hans', 'add date:2016-03-14', '2016-11-30 08:19:41'),
(626, 'hans', 'add date:2016-03-15', '2016-11-30 08:19:41'),
(627, 'hans', 'add date:2016-03-16', '2016-11-30 08:19:41'),
(628, 'hans', 'add date:2016-03-17', '2016-11-30 08:19:41'),
(629, 'hans', 'add date:2016-03-18', '2016-11-30 08:19:42'),
(630, 'hans', 'add date:2016-03-19', '2016-11-30 08:19:42'),
(631, 'hans', 'add date:2016-03-20', '2016-11-30 08:19:42'),
(632, 'hans', 'add date:2016-03-21', '2016-11-30 08:19:42'),
(633, 'hans', 'add date:2016-03-22', '2016-11-30 08:19:42'),
(634, 'hans', 'add date:2016-03-23', '2016-11-30 08:19:42'),
(635, 'hans', 'add date:2016-03-24', '2016-11-30 08:19:42'),
(636, 'hans', 'add date:2016-03-25', '2016-11-30 08:19:42'),
(637, 'hans', 'add date:2016-03-26', '2016-11-30 08:19:42'),
(638, 'hans', 'add date:2016-03-27', '2016-11-30 08:19:42'),
(639, 'hans', 'add date:2016-03-28', '2016-11-30 08:19:42'),
(640, 'hans', 'add date:2016-03-29', '2016-11-30 08:19:42'),
(641, 'hans', 'add date:2016-03-30', '2016-11-30 08:19:42'),
(642, 'hans', 'add date:2016-03-31', '2016-11-30 08:19:42'),
(643, 'hans', 'add date:2016-04-01', '2016-11-30 08:19:42'),
(644, 'hans', 'add date:2016-04-02', '2016-11-30 08:19:42'),
(645, 'hans', 'add date:2016-04-03', '2016-11-30 08:19:42'),
(646, 'hans', 'add date:2016-04-04', '2016-11-30 08:19:42'),
(647, 'hans', 'add date:2016-04-05', '2016-11-30 08:19:42'),
(648, 'hans', 'add date:2016-04-06', '2016-11-30 08:19:42'),
(649, 'hans', 'add date:2016-04-07', '2016-11-30 08:19:42'),
(650, 'hans', 'add date:2016-04-08', '2016-11-30 08:19:42'),
(651, 'hans', 'add date:2016-04-09', '2016-11-30 08:19:42'),
(652, 'hans', 'add date:2016-04-10', '2016-11-30 08:19:42'),
(653, 'hans', 'add date:2016-04-11', '2016-11-30 08:19:43'),
(654, 'hans', 'add date:2016-04-12', '2016-11-30 08:19:43'),
(655, 'hans', 'add date:2016-04-13', '2016-11-30 08:19:43'),
(656, 'hans', 'add date:2016-04-14', '2016-11-30 08:19:43'),
(657, 'hans', 'add date:2016-04-15', '2016-11-30 08:19:43'),
(658, 'hans', 'add date:2016-04-16', '2016-11-30 08:19:43'),
(659, 'hans', 'add date:2016-04-17', '2016-11-30 08:19:43'),
(660, 'hans', 'add date:2016-04-18', '2016-11-30 08:19:43'),
(661, 'hans', 'add date:2016-04-19', '2016-11-30 08:19:43'),
(662, 'hans', 'add date:2016-04-20', '2016-11-30 08:19:43'),
(663, 'hans', 'add date:2016-04-21', '2016-11-30 08:19:43'),
(664, 'hans', 'add date:2016-04-22', '2016-11-30 08:19:43'),
(665, 'hans', 'add date:2016-04-23', '2016-11-30 08:19:43'),
(666, 'hans', 'add date:2016-04-24', '2016-11-30 08:19:43'),
(667, 'hans', 'add date:2016-04-25', '2016-11-30 08:19:43'),
(668, 'hans', 'add date:2016-04-26', '2016-11-30 08:19:43'),
(669, 'hans', 'add date:2016-04-27', '2016-11-30 08:19:43'),
(670, 'hans', 'add date:2016-04-28', '2016-11-30 08:19:43'),
(671, 'hans', 'add date:2016-04-29', '2016-11-30 08:19:43'),
(672, 'hans', 'add date:2016-04-30', '2016-11-30 08:19:43'),
(673, 'hans', 'add date:2016-05-01', '2016-11-30 08:19:43'),
(674, 'hans', 'add date:2016-05-02', '2016-11-30 08:19:44'),
(675, 'hans', 'add date:2016-05-03', '2016-11-30 08:19:44'),
(676, 'hans', 'add date:2016-05-04', '2016-11-30 08:19:44'),
(677, 'hans', 'add date:2016-05-05', '2016-11-30 08:19:44'),
(678, 'hans', 'add date:2016-05-06', '2016-11-30 08:19:44'),
(679, 'hans', 'add date:2016-05-07', '2016-11-30 08:19:44'),
(680, 'hans', 'add date:2016-05-08', '2016-11-30 08:19:44'),
(681, 'hans', 'add date:2016-05-09', '2016-11-30 08:19:44'),
(682, 'hans', 'add date:2016-05-10', '2016-11-30 08:19:44'),
(683, 'hans', 'add date:2016-05-11', '2016-11-30 08:19:44'),
(684, 'hans', 'add date:2016-05-12', '2016-11-30 08:19:44'),
(685, 'hans', 'add date:2016-05-13', '2016-11-30 08:19:44'),
(686, 'hans', 'add date:2016-05-14', '2016-11-30 08:19:44'),
(687, 'hans', 'add date:2016-05-15', '2016-11-30 08:19:44'),
(688, 'hans', 'add date:2016-05-16', '2016-11-30 08:19:44'),
(689, 'hans', 'add date:2016-05-17', '2016-11-30 08:19:44'),
(690, 'hans', 'add date:2016-05-18', '2016-11-30 08:19:44'),
(691, 'hans', 'add date:2016-05-19', '2016-11-30 08:19:45'),
(692, 'hans', 'add date:2016-05-20', '2016-11-30 08:19:45'),
(693, 'hans', 'add date:2016-05-21', '2016-11-30 08:19:45'),
(694, 'hans', 'add date:2016-05-22', '2016-11-30 08:19:45'),
(695, 'hans', 'add date:2016-05-23', '2016-11-30 08:19:45'),
(696, 'hans', 'add date:2016-05-24', '2016-11-30 08:19:45'),
(697, 'hans', 'add date:2016-05-25', '2016-11-30 08:19:45'),
(698, 'hans', 'add date:2016-05-26', '2016-11-30 08:19:45'),
(699, 'hans', 'add date:2016-05-27', '2016-11-30 08:19:45'),
(700, 'hans', 'add date:2016-05-28', '2016-11-30 08:19:45'),
(701, 'hans', 'add date:2016-05-29', '2016-11-30 08:19:45'),
(702, 'hans', 'add date:2016-05-30', '2016-11-30 08:19:45'),
(703, 'hans', 'add date:2016-05-31', '2016-11-30 08:19:45'),
(704, 'hans', 'add date:2016-06-01', '2016-11-30 08:19:45'),
(705, 'hans', 'add date:2016-06-02', '2016-11-30 08:19:45'),
(706, 'hans', 'add date:2016-06-03', '2016-11-30 08:19:45'),
(707, 'hans', 'add date:2016-06-04', '2016-11-30 08:19:45'),
(708, 'hans', 'add date:2016-06-05', '2016-11-30 08:19:45'),
(709, 'hans', 'add date:2016-06-06', '2016-11-30 08:19:45'),
(710, 'hans', 'add date:2016-06-07', '2016-11-30 08:19:45'),
(711, 'hans', 'add date:2016-06-08', '2016-11-30 08:19:45'),
(712, 'hans', 'add date:2016-06-09', '2016-11-30 08:19:45'),
(713, 'hans', 'add date:2016-06-10', '2016-11-30 08:19:45'),
(714, 'hans', 'add date:2016-06-11', '2016-11-30 08:19:46'),
(715, 'hans', 'add date:2016-06-12', '2016-11-30 08:19:46'),
(716, 'hans', 'add date:2016-06-13', '2016-11-30 08:19:46'),
(717, 'hans', 'add date:2016-06-14', '2016-11-30 08:19:46'),
(718, 'hans', 'add date:2016-06-15', '2016-11-30 08:19:46'),
(719, 'hans', 'add date:2016-06-16', '2016-11-30 08:19:46'),
(720, 'hans', 'add date:2016-06-17', '2016-11-30 08:19:46'),
(721, 'hans', 'add date:2016-06-18', '2016-11-30 08:19:46'),
(722, 'hans', 'add date:2016-06-19', '2016-11-30 08:19:46'),
(723, 'hans', 'add date:2016-06-20', '2016-11-30 08:19:46'),
(724, 'hans', 'add date:2016-06-21', '2016-11-30 08:19:46'),
(725, 'hans', 'add date:2016-06-22', '2016-11-30 08:19:46'),
(726, 'hans', 'add date:2016-06-23', '2016-11-30 08:19:47'),
(727, 'hans', 'add date:2016-06-24', '2016-11-30 08:19:47'),
(728, 'hans', 'add date:2016-06-25', '2016-11-30 08:19:47'),
(729, 'hans', 'add date:2016-06-26', '2016-11-30 08:19:47'),
(730, 'hans', 'add date:2016-06-27', '2016-11-30 08:19:47'),
(731, 'hans', 'add date:2016-06-28', '2016-11-30 08:19:47'),
(732, 'hans', 'add date:2016-06-29', '2016-11-30 08:19:47'),
(733, 'hans', 'add date:2016-06-30', '2016-11-30 08:19:47'),
(734, 'hans', 'add date:2016-07-01', '2016-11-30 08:19:47'),
(735, 'hans', 'add date:2016-07-02', '2016-11-30 08:19:47'),
(736, 'hans', 'add date:2016-07-03', '2016-11-30 08:19:47'),
(737, 'hans', 'add date:2016-07-04', '2016-11-30 08:19:47'),
(738, 'hans', 'add date:2016-07-05', '2016-11-30 08:19:47'),
(739, 'hans', 'add date:2016-07-06', '2016-11-30 08:19:47'),
(740, 'hans', 'add date:2016-07-07', '2016-11-30 08:19:47'),
(741, 'hans', 'add date:2016-07-08', '2016-11-30 08:19:47'),
(742, 'hans', 'add date:2016-07-09', '2016-11-30 08:19:47'),
(743, 'hans', 'add date:2016-07-10', '2016-11-30 08:19:47'),
(744, 'hans', 'add date:2016-07-11', '2016-11-30 08:19:47'),
(745, 'hans', 'add date:2016-07-12', '2016-11-30 08:19:47'),
(746, 'hans', 'add date:2016-07-13', '2016-11-30 08:19:48'),
(747, 'hans', 'add date:2016-07-14', '2016-11-30 08:19:48'),
(748, 'hans', 'add date:2016-07-15', '2016-11-30 08:19:48'),
(749, 'hans', 'add date:2016-07-16', '2016-11-30 08:19:48'),
(750, 'hans', 'add date:2016-07-17', '2016-11-30 08:19:48'),
(751, 'hans', 'add date:2016-07-18', '2016-11-30 08:19:48'),
(752, 'hans', 'add date:2016-07-19', '2016-11-30 08:19:48'),
(753, 'hans', 'add date:2016-07-20', '2016-11-30 08:19:48'),
(754, 'hans', 'add date:2016-07-21', '2016-11-30 08:19:48'),
(755, 'hans', 'add date:2016-07-22', '2016-11-30 08:19:48'),
(756, 'hans', 'add date:2016-07-23', '2016-11-30 08:19:48'),
(757, 'hans', 'add date:2016-07-24', '2016-11-30 08:19:48'),
(758, 'hans', 'add date:2016-07-25', '2016-11-30 08:19:48'),
(759, 'hans', 'add date:2016-07-26', '2016-11-30 08:19:48'),
(760, 'hans', 'add date:2016-07-27', '2016-11-30 08:19:48'),
(761, 'hans', 'add date:2016-07-28', '2016-11-30 08:19:48'),
(762, 'hans', 'add date:2016-07-29', '2016-11-30 08:19:48'),
(763, 'hans', 'add date:2016-07-30', '2016-11-30 08:19:48'),
(764, 'hans', 'add date:2016-07-31', '2016-11-30 08:19:48'),
(765, 'hans', 'add date:2016-08-01', '2016-11-30 08:19:48'),
(766, 'hans', 'add date:2016-08-02', '2016-11-30 08:19:48'),
(767, 'hans', 'add date:2016-08-03', '2016-11-30 08:19:49'),
(768, 'hans', 'add date:2016-08-04', '2016-11-30 08:19:49'),
(769, 'hans', 'add date:2016-08-05', '2016-11-30 08:19:49'),
(770, 'hans', 'add date:2016-08-06', '2016-11-30 08:19:49'),
(771, 'hans', 'add date:2016-08-07', '2016-11-30 08:19:49'),
(772, 'hans', 'add date:2016-08-08', '2016-11-30 08:19:49'),
(773, 'hans', 'add date:2016-08-09', '2016-11-30 08:19:49'),
(774, 'hans', 'add date:2016-08-10', '2016-11-30 08:19:49'),
(775, 'hans', 'add date:2016-08-11', '2016-11-30 08:19:49'),
(776, 'hans', 'add date:2016-08-12', '2016-11-30 08:19:49'),
(777, 'hans', 'add date:2016-08-13', '2016-11-30 08:19:49'),
(778, 'hans', 'add date:2016-08-14', '2016-11-30 08:19:49'),
(779, 'hans', 'add date:2016-08-15', '2016-11-30 08:19:49'),
(780, 'hans', 'add date:2016-08-16', '2016-11-30 08:19:49'),
(781, 'hans', 'add date:2016-08-17', '2016-11-30 08:19:49'),
(782, 'hans', 'add date:2016-08-18', '2016-11-30 08:19:49'),
(783, 'hans', 'add date:2016-08-19', '2016-11-30 08:19:49'),
(784, 'hans', 'add date:2016-08-20', '2016-11-30 08:19:50'),
(785, 'hans', 'add date:2016-08-21', '2016-11-30 08:19:50'),
(786, 'hans', 'add date:2016-08-22', '2016-11-30 08:19:50'),
(787, 'hans', 'add date:2016-08-23', '2016-11-30 08:19:50'),
(788, 'hans', 'add date:2016-08-24', '2016-11-30 08:19:50'),
(789, 'hans', 'add date:2016-08-25', '2016-11-30 08:19:50'),
(790, 'hans', 'add date:2016-08-26', '2016-11-30 08:19:50'),
(791, 'hans', 'add date:2016-08-27', '2016-11-30 08:19:50'),
(792, 'hans', 'add date:2016-08-28', '2016-11-30 08:19:50'),
(793, 'hans', 'add date:2016-08-29', '2016-11-30 08:19:50'),
(794, 'hans', 'add date:2016-08-30', '2016-11-30 08:19:50'),
(795, 'hans', 'add date:2016-08-31', '2016-11-30 08:19:50'),
(796, 'hans', 'add date:2016-09-01', '2016-11-30 08:19:50'),
(797, 'hans', 'add date:2016-09-02', '2016-11-30 08:19:50'),
(798, 'hans', 'add date:2016-09-03', '2016-11-30 08:19:50'),
(799, 'hans', 'add date:2016-09-04', '2016-11-30 08:19:50'),
(800, 'hans', 'add date:2016-09-05', '2016-11-30 08:19:50'),
(801, 'hans', 'add date:2016-09-06', '2016-11-30 08:19:51'),
(802, 'hans', 'add date:2016-09-07', '2016-11-30 08:19:51'),
(803, 'hans', 'add date:2016-09-08', '2016-11-30 08:19:51'),
(804, 'hans', 'add date:2016-09-09', '2016-11-30 08:19:51'),
(805, 'hans', 'add date:2016-09-10', '2016-11-30 08:19:51'),
(806, 'hans', 'add date:2016-09-11', '2016-11-30 08:19:51'),
(807, 'hans', 'add date:2016-09-12', '2016-11-30 08:19:51'),
(808, 'hans', 'add date:2016-09-13', '2016-11-30 08:19:51'),
(809, 'hans', 'add date:2016-09-14', '2016-11-30 08:19:51'),
(810, 'hans', 'add date:2016-09-15', '2016-11-30 08:19:51'),
(811, 'hans', 'add date:2016-09-16', '2016-11-30 08:19:51'),
(812, 'hans', 'add date:2016-09-17', '2016-11-30 08:19:51'),
(813, 'hans', 'add date:2016-09-18', '2016-11-30 08:19:51'),
(814, 'hans', 'add date:2016-09-19', '2016-11-30 08:19:51'),
(815, 'hans', 'add date:2016-09-20', '2016-11-30 08:19:51'),
(816, 'hans', 'add date:2016-09-21', '2016-11-30 08:19:51'),
(817, 'hans', 'add date:2016-09-22', '2016-11-30 08:19:51'),
(818, 'hans', 'add date:2016-09-23', '2016-11-30 08:19:51'),
(819, 'hans', 'add date:2016-09-24', '2016-11-30 08:19:51'),
(820, 'hans', 'add date:2016-09-25', '2016-11-30 08:19:52'),
(821, 'hans', 'add date:2016-09-26', '2016-11-30 08:19:52'),
(822, 'hans', 'add date:2016-09-27', '2016-11-30 08:19:52'),
(823, 'hans', 'add date:2016-09-28', '2016-11-30 08:19:52'),
(824, 'hans', 'add date:2016-09-29', '2016-11-30 08:19:52'),
(825, 'hans', 'add date:2016-09-30', '2016-11-30 08:19:52'),
(826, 'hans', 'add date:2016-10-01', '2016-11-30 08:19:52'),
(827, 'hans', 'add date:2016-10-02', '2016-11-30 08:19:52'),
(828, 'hans', 'add date:2016-10-03', '2016-11-30 08:19:52'),
(829, 'hans', 'add date:2016-10-04', '2016-11-30 08:19:52'),
(830, 'hans', 'add date:2016-10-05', '2016-11-30 08:19:52'),
(831, 'hans', 'add date:2016-10-06', '2016-11-30 08:19:52'),
(832, 'hans', 'add date:2016-10-07', '2016-11-30 08:19:52'),
(833, 'hans', 'add date:2016-10-08', '2016-11-30 08:19:52'),
(834, 'hans', 'add date:2016-10-09', '2016-11-30 08:19:52'),
(835, 'hans', 'add date:2016-10-10', '2016-11-30 08:19:52'),
(836, 'hans', 'add date:2016-10-11', '2016-11-30 08:19:53'),
(837, 'hans', 'add date:2016-10-12', '2016-11-30 08:19:53'),
(838, 'hans', 'add date:2016-10-13', '2016-11-30 08:19:53'),
(839, 'hans', 'add date:2016-10-14', '2016-11-30 08:19:53'),
(840, 'hans', 'add date:2016-10-15', '2016-11-30 08:19:53');
INSERT INTO `masterlogs` (`id`, `user`, `jobs`, `reg_date`) VALUES
(841, 'hans', 'add date:2016-10-16', '2016-11-30 08:19:53'),
(842, 'hans', 'add date:2016-10-17', '2016-11-30 08:19:53'),
(843, 'hans', 'add date:2016-10-18', '2016-11-30 08:19:53'),
(844, 'hans', 'add date:2016-10-19', '2016-11-30 08:19:53'),
(845, 'hans', 'add date:2016-10-20', '2016-11-30 08:19:53'),
(846, 'hans', 'add date:2016-10-21', '2016-11-30 08:19:53'),
(847, 'hans', 'add date:2016-10-22', '2016-11-30 08:19:53'),
(848, 'hans', 'add date:2016-10-23', '2016-11-30 08:19:53'),
(849, 'hans', 'add date:2016-10-24', '2016-11-30 08:19:53'),
(850, 'hans', 'add date:2016-10-25', '2016-11-30 08:19:53'),
(851, 'hans', 'add date:2016-10-26', '2016-11-30 08:19:53'),
(852, 'hans', 'add date:2016-10-27', '2016-11-30 08:19:53'),
(853, 'hans', 'add date:2016-10-28', '2016-11-30 08:19:53'),
(854, 'hans', 'add date:2016-10-29', '2016-11-30 08:19:53'),
(855, 'hans', 'add date:2016-10-30', '2016-11-30 08:19:54'),
(856, 'hans', 'add date:2016-10-31', '2016-11-30 08:19:54'),
(857, 'hans', 'add date:2016-11-01', '2016-11-30 08:19:54'),
(858, 'hans', 'add date:2016-11-02', '2016-11-30 08:19:54'),
(859, 'hans', 'add date:2016-11-03', '2016-11-30 08:19:54'),
(860, 'hans', 'add date:2016-11-04', '2016-11-30 08:19:54'),
(861, 'hans', 'add date:2016-11-05', '2016-11-30 08:19:54'),
(862, 'hans', 'add date:2016-11-06', '2016-11-30 08:19:54'),
(863, 'hans', 'add date:2016-11-07', '2016-11-30 08:19:54'),
(864, 'hans', 'add date:2016-11-08', '2016-11-30 08:19:54'),
(865, 'hans', 'add date:2016-11-09', '2016-11-30 08:19:54'),
(866, 'hans', 'add date:2016-11-10', '2016-11-30 08:19:54'),
(867, 'hans', 'add date:2016-11-11', '2016-11-30 08:19:54'),
(868, 'hans', 'add date:2016-11-12', '2016-11-30 08:19:54'),
(869, 'hans', 'add date:2016-11-13', '2016-11-30 08:19:54'),
(870, 'hans', 'add date:2016-11-14', '2016-11-30 08:19:54'),
(871, 'hans', 'add date:2016-11-15', '2016-11-30 08:19:55'),
(872, 'hans', 'add date:2016-11-16', '2016-11-30 08:19:55'),
(873, 'hans', 'add date:2016-11-17', '2016-11-30 08:19:55'),
(874, 'hans', 'add date:2016-11-18', '2016-11-30 08:19:55'),
(875, 'hans', 'add date:2016-11-19', '2016-11-30 08:19:55'),
(876, 'hans', 'add date:2016-11-20', '2016-11-30 08:19:55'),
(877, 'hans', 'add date:2016-11-21', '2016-11-30 08:19:55'),
(878, 'hans', 'add date:2016-11-22', '2016-11-30 08:19:55'),
(879, 'hans', 'add date:2016-11-23', '2016-11-30 08:19:55'),
(880, 'hans', 'add date:2016-11-24', '2016-11-30 08:19:56'),
(881, 'hans', 'add date:2016-11-25', '2016-11-30 08:19:56'),
(882, 'hans', 'add date:2016-11-26', '2016-11-30 08:19:56'),
(883, 'hans', 'add date:2016-11-27', '2016-11-30 08:19:56'),
(884, 'hans', 'add date:2016-11-28', '2016-11-30 08:19:56'),
(885, 'hans', 'add date:2016-11-29', '2016-11-30 08:19:56'),
(886, 'hans', 'add date:2016-11-30', '2016-11-30 08:19:56'),
(887, 'hans', 'add date:2016-12-01', '2016-11-30 08:19:56'),
(888, 'hans', 'add date:2016-12-02', '2016-11-30 08:19:56'),
(889, 'hans', 'add date:2016-12-03', '2016-11-30 08:19:56'),
(890, 'hans', 'add date:2016-12-04', '2016-11-30 08:19:56'),
(891, 'hans', 'add date:2016-12-05', '2016-11-30 08:19:56'),
(892, 'hans', 'add date:2016-12-06', '2016-11-30 08:19:56'),
(893, 'hans', 'add date:2016-12-07', '2016-11-30 08:19:56'),
(894, 'hans', 'add date:2016-12-08', '2016-11-30 08:19:56'),
(895, 'hans', 'add date:2016-12-09', '2016-11-30 08:19:56'),
(896, 'hans', 'add date:2016-12-10', '2016-11-30 08:19:57'),
(897, 'hans', 'add date:2016-12-11', '2016-11-30 08:19:57'),
(898, 'hans', 'add date:2016-12-12', '2016-11-30 08:19:57'),
(899, 'hans', 'add date:2016-12-13', '2016-11-30 08:19:57'),
(900, 'hans', 'add date:2016-12-14', '2016-11-30 08:19:57'),
(901, 'hans', 'add date:2016-12-15', '2016-11-30 08:19:57'),
(902, 'hans', 'add date:2016-12-16', '2016-11-30 08:19:57'),
(903, 'hans', 'add date:2016-12-17', '2016-11-30 08:19:57'),
(904, 'hans', 'add date:2016-12-18', '2016-11-30 08:19:57'),
(905, 'hans', 'add date:2016-12-19', '2016-11-30 08:19:57'),
(906, 'hans', 'add date:2016-12-20', '2016-11-30 08:19:57'),
(907, 'hans', 'add date:2016-12-21', '2016-11-30 08:19:57'),
(908, 'hans', 'add date:2016-12-22', '2016-11-30 08:19:57'),
(909, 'hans', 'add date:2016-12-23', '2016-11-30 08:19:57'),
(910, 'hans', 'add date:2016-12-24', '2016-11-30 08:19:57'),
(911, 'hans', 'add date:2016-12-25', '2016-11-30 08:19:57'),
(912, 'hans', 'add date:2016-12-26', '2016-11-30 08:19:57'),
(913, 'hans', 'add date:2016-12-27', '2016-11-30 08:19:57'),
(914, 'hans', 'add date:2016-12-28', '2016-11-30 08:19:57'),
(915, 'hans', 'add date:2016-12-29', '2016-11-30 08:19:57'),
(916, 'hans', 'add date:2016-12-30', '2016-11-30 08:19:57'),
(917, 'hans', 'add date:2016-12-31', '2016-11-30 08:19:58'),
(918, 'hans', 'add date:2017-01-01', '2016-12-02 07:41:57'),
(919, 'hans', 'add date:2017-01-02', '2016-12-02 07:41:57'),
(920, 'hans', 'add date:2017-01-03', '2016-12-02 07:41:57'),
(921, 'hans', 'add date:2017-01-04', '2016-12-02 07:41:58'),
(922, 'hans', 'add date:2017-01-05', '2016-12-02 07:41:58'),
(923, 'hans', 'add date:2017-01-06', '2016-12-02 07:41:58'),
(924, 'hans', 'add date:2017-01-07', '2016-12-02 07:41:58'),
(925, 'hans', 'add date:2017-01-08', '2016-12-02 07:41:58'),
(926, 'hans', 'add date:2017-01-09', '2016-12-02 07:41:58'),
(927, 'hans', 'add date:2017-01-10', '2016-12-02 07:41:58'),
(928, 'hans', 'add date:2017-01-11', '2016-12-02 07:41:58'),
(929, 'hans', 'add date:2017-01-12', '2016-12-02 07:41:58'),
(930, 'hans', 'add date:2017-01-13', '2016-12-02 07:41:58'),
(931, 'hans', 'add date:2017-01-14', '2016-12-02 07:41:58'),
(932, 'hans', 'add date:2017-01-15', '2016-12-02 07:41:58'),
(933, 'hans', 'add date:2017-01-16', '2016-12-02 07:41:58'),
(934, 'hans', 'add date:2017-01-17', '2016-12-02 07:41:58'),
(935, 'hans', 'add date:2017-01-18', '2016-12-02 07:41:58'),
(936, 'hans', 'add date:2017-01-19', '2016-12-02 07:41:58'),
(937, 'hans', 'add date:2017-01-20', '2016-12-02 07:41:58'),
(938, 'hans', 'add date:2017-01-21', '2016-12-02 07:41:58'),
(939, 'hans', 'add date:2017-01-22', '2016-12-02 07:41:58'),
(940, 'hans', 'add date:2017-01-23', '2016-12-02 07:41:59'),
(941, 'hans', 'add date:2017-01-24', '2016-12-02 07:41:59'),
(942, 'hans', 'add date:2017-01-25', '2016-12-02 07:41:59'),
(943, 'hans', 'add date:2017-01-26', '2016-12-02 07:41:59'),
(944, 'hans', 'add date:2017-01-27', '2016-12-02 07:41:59'),
(945, 'hans', 'add date:2017-01-28', '2016-12-02 07:41:59'),
(946, 'hans', 'add date:2017-01-29', '2016-12-02 07:41:59'),
(947, 'hans', 'add date:2017-01-30', '2016-12-02 07:41:59'),
(948, 'hans', 'add date:2017-01-31', '2016-12-02 07:41:59'),
(949, 'hans', 'add date:2017-02-01', '2016-12-02 07:41:59'),
(950, 'hans', 'add date:2017-02-02', '2016-12-02 07:41:59'),
(951, 'hans', 'add date:2017-02-03', '2016-12-02 07:41:59'),
(952, 'hans', 'add date:2017-02-04', '2016-12-02 07:41:59'),
(953, 'hans', 'add date:2017-02-05', '2016-12-02 07:41:59'),
(954, 'hans', 'add date:2017-02-06', '2016-12-02 07:41:59'),
(955, 'hans', 'add date:2017-02-07', '2016-12-02 07:41:59'),
(956, 'hans', 'add date:2017-02-08', '2016-12-02 07:41:59'),
(957, 'hans', 'add date:2017-02-09', '2016-12-02 07:41:59'),
(958, 'hans', 'add date:2017-02-10', '2016-12-02 07:41:59'),
(959, 'hans', 'add date:2017-02-11', '2016-12-02 07:41:59'),
(960, 'hans', 'add date:2017-02-12', '2016-12-02 07:42:00'),
(961, 'hans', 'add date:2017-02-13', '2016-12-02 07:42:00'),
(962, 'hans', 'add date:2017-02-14', '2016-12-02 07:42:00'),
(963, 'hans', 'add date:2017-02-15', '2016-12-02 07:42:00'),
(964, 'hans', 'add date:2017-02-16', '2016-12-02 07:42:00'),
(965, 'hans', 'add date:2017-02-17', '2016-12-02 07:42:00'),
(966, 'hans', 'add date:2017-02-18', '2016-12-02 07:42:00'),
(967, 'hans', 'add date:2017-02-19', '2016-12-02 07:42:00'),
(968, 'hans', 'add date:2017-02-20', '2016-12-02 07:42:00'),
(969, 'hans', 'add date:2017-02-21', '2016-12-02 07:42:00'),
(970, 'hans', 'add date:2017-02-22', '2016-12-02 07:42:00'),
(971, 'hans', 'add date:2017-02-23', '2016-12-02 07:42:00'),
(972, 'hans', 'add date:2017-02-24', '2016-12-02 07:42:00'),
(973, 'hans', 'add date:2017-02-25', '2016-12-02 07:42:00'),
(974, 'hans', 'add date:2017-02-26', '2016-12-02 07:42:01'),
(975, 'hans', 'add date:2017-02-27', '2016-12-02 07:42:01'),
(976, 'hans', 'add date:2017-02-28', '2016-12-02 07:42:01'),
(977, 'hans', 'add date:2017-03-01', '2016-12-02 07:42:01'),
(978, 'hans', 'add date:2017-03-02', '2016-12-02 07:42:01'),
(979, 'hans', 'add date:2017-03-03', '2016-12-02 07:42:01'),
(980, 'hans', 'add date:2017-03-04', '2016-12-02 07:42:01'),
(981, 'hans', 'add date:2017-03-05', '2016-12-02 07:42:01'),
(982, 'hans', 'add date:2017-03-06', '2016-12-02 07:42:01'),
(983, 'hans', 'add date:2017-03-07', '2016-12-02 07:42:01'),
(984, 'hans', 'add date:2017-03-08', '2016-12-02 07:42:01'),
(985, 'hans', 'add date:2017-03-09', '2016-12-02 07:42:01'),
(986, 'hans', 'add date:2017-03-10', '2016-12-02 07:42:01'),
(987, 'hans', 'add date:2017-03-11', '2016-12-02 07:42:02'),
(988, 'hans', 'add date:2017-03-12', '2016-12-02 07:42:02'),
(989, 'hans', 'add date:2017-03-13', '2016-12-02 07:42:02'),
(990, 'hans', 'add date:2017-03-14', '2016-12-02 07:42:02'),
(991, 'hans', 'add date:2017-03-15', '2016-12-02 07:42:02'),
(992, 'hans', 'add date:2017-03-16', '2016-12-02 07:42:02'),
(993, 'hans', 'add date:2017-03-17', '2016-12-02 07:42:02'),
(994, 'hans', 'add date:2017-03-18', '2016-12-02 07:42:02'),
(995, 'hans', 'add date:2017-03-19', '2016-12-02 07:42:02'),
(996, 'hans', 'add date:2017-03-20', '2016-12-02 07:42:02'),
(997, 'hans', 'add date:2017-03-21', '2016-12-02 07:42:02'),
(998, 'hans', 'add date:2017-03-22', '2016-12-02 07:42:02'),
(999, 'hans', 'add date:2017-03-23', '2016-12-02 07:42:02'),
(1000, 'hans', 'add date:2017-03-24', '2016-12-02 07:42:02'),
(1001, 'hans', 'add date:2017-03-25', '2016-12-02 07:42:02'),
(1002, 'hans', 'add date:2017-03-26', '2016-12-02 07:42:03'),
(1003, 'hans', 'add date:2017-03-27', '2016-12-02 07:42:03'),
(1004, 'hans', 'add date:2017-03-28', '2016-12-02 07:42:03'),
(1005, 'hans', 'add date:2017-03-29', '2016-12-02 07:42:03'),
(1006, 'hans', 'add date:2017-03-30', '2016-12-02 07:42:03'),
(1007, 'hans', 'add date:2017-03-31', '2016-12-02 07:42:03'),
(1008, 'hans', 'add date:2017-04-01', '2016-12-02 07:42:03'),
(1009, 'hans', 'add date:2017-04-02', '2016-12-02 07:42:03'),
(1010, 'hans', 'add date:2017-04-03', '2016-12-02 07:42:03'),
(1011, 'hans', 'add date:2017-04-04', '2016-12-02 07:42:03'),
(1012, 'hans', 'add date:2017-04-05', '2016-12-02 07:42:03'),
(1013, 'hans', 'add date:2017-04-06', '2016-12-02 07:42:03'),
(1014, 'hans', 'add date:2017-04-07', '2016-12-02 07:42:03'),
(1015, 'hans', 'add date:2017-04-08', '2016-12-02 07:42:03'),
(1016, 'hans', 'add date:2017-04-09', '2016-12-02 07:42:04'),
(1017, 'hans', 'add date:2017-04-10', '2016-12-02 07:42:04'),
(1018, 'hans', 'add date:2017-04-11', '2016-12-02 07:42:04'),
(1019, 'hans', 'add date:2017-04-12', '2016-12-02 07:42:04'),
(1020, 'hans', 'add date:2017-04-13', '2016-12-02 07:42:04'),
(1021, 'hans', 'add date:2017-04-14', '2016-12-02 07:42:04'),
(1022, 'hans', 'add date:2017-04-15', '2016-12-02 07:42:04'),
(1023, 'hans', 'add date:2017-04-16', '2016-12-02 07:42:04'),
(1024, 'hans', 'add date:2017-04-17', '2016-12-02 07:42:04'),
(1025, 'hans', 'add date:2017-04-18', '2016-12-02 07:42:04'),
(1026, 'hans', 'add date:2017-04-19', '2016-12-02 07:42:04'),
(1027, 'hans', 'add date:2017-04-20', '2016-12-02 07:42:04'),
(1028, 'hans', 'add date:2017-04-21', '2016-12-02 07:42:04'),
(1029, 'hans', 'add date:2017-04-22', '2016-12-02 07:42:04'),
(1030, 'hans', 'add date:2017-04-23', '2016-12-02 07:42:04'),
(1031, 'hans', 'add date:2017-04-24', '2016-12-02 07:42:04'),
(1032, 'hans', 'add date:2017-04-25', '2016-12-02 07:42:04'),
(1033, 'hans', 'add date:2017-04-26', '2016-12-02 07:42:04'),
(1034, 'hans', 'add date:2017-04-27', '2016-12-02 07:42:04'),
(1035, 'hans', 'add date:2017-04-28', '2016-12-02 07:42:04'),
(1036, 'hans', 'add date:2017-04-29', '2016-12-02 07:42:04'),
(1037, 'hans', 'add date:2017-04-30', '2016-12-02 07:42:04'),
(1038, 'hans', 'add date:2017-05-01', '2016-12-02 07:42:04'),
(1039, 'hans', 'add date:2017-05-02', '2016-12-02 07:42:04'),
(1040, 'hans', 'add date:2017-05-03', '2016-12-02 07:42:04'),
(1041, 'hans', 'add date:2017-05-04', '2016-12-02 07:42:04'),
(1042, 'hans', 'add date:2017-05-05', '2016-12-02 07:42:05'),
(1043, 'hans', 'add date:2017-05-06', '2016-12-02 07:42:05'),
(1044, 'hans', 'add date:2017-05-07', '2016-12-02 07:42:05'),
(1045, 'hans', 'add date:2017-05-08', '2016-12-02 07:42:05'),
(1046, 'hans', 'add date:2017-05-09', '2016-12-02 07:42:05'),
(1047, 'hans', 'add date:2017-05-10', '2016-12-02 07:42:05'),
(1048, 'hans', 'add date:2017-05-11', '2016-12-02 07:42:05'),
(1049, 'hans', 'add date:2017-05-12', '2016-12-02 07:42:05'),
(1050, 'hans', 'add date:2017-05-13', '2016-12-02 07:42:05'),
(1051, 'hans', 'add date:2017-05-14', '2016-12-02 07:42:05'),
(1052, 'hans', 'add date:2017-05-15', '2016-12-02 07:42:05'),
(1053, 'hans', 'add date:2017-05-16', '2016-12-02 07:42:05'),
(1054, 'hans', 'add date:2017-05-17', '2016-12-02 07:42:06'),
(1055, 'hans', 'add date:2017-05-18', '2016-12-02 07:42:06'),
(1056, 'hans', 'add date:2017-05-19', '2016-12-02 07:42:06'),
(1057, 'hans', 'add date:2017-05-20', '2016-12-02 07:42:06'),
(1058, 'hans', 'add date:2017-05-21', '2016-12-02 07:42:06'),
(1059, 'hans', 'add date:2017-05-22', '2016-12-02 07:42:06'),
(1060, 'hans', 'add date:2017-05-23', '2016-12-02 07:42:06'),
(1061, 'hans', 'add date:2017-05-24', '2016-12-02 07:42:06'),
(1062, 'hans', 'add date:2017-05-25', '2016-12-02 07:42:06'),
(1063, 'hans', 'add date:2017-05-26', '2016-12-02 07:42:06'),
(1064, 'hans', 'add date:2017-05-27', '2016-12-02 07:42:06'),
(1065, 'hans', 'add date:2017-05-28', '2016-12-02 07:42:06'),
(1066, 'hans', 'add date:2017-05-29', '2016-12-02 07:42:06'),
(1067, 'hans', 'add date:2017-05-30', '2016-12-02 07:42:06'),
(1068, 'hans', 'add date:2017-05-31', '2016-12-02 07:42:06'),
(1069, 'hans', 'add date:2017-06-01', '2016-12-02 07:42:06'),
(1070, 'hans', 'add date:2017-06-02', '2016-12-02 07:42:06'),
(1071, 'hans', 'add date:2017-06-03', '2016-12-02 07:42:07'),
(1072, 'hans', 'add date:2017-06-04', '2016-12-02 07:42:07'),
(1073, 'hans', 'add date:2017-06-05', '2016-12-02 07:42:07'),
(1074, 'hans', 'add date:2017-06-06', '2016-12-02 07:42:07'),
(1075, 'hans', 'add date:2017-06-07', '2016-12-02 07:42:07'),
(1076, 'hans', 'add date:2017-06-08', '2016-12-02 07:42:07'),
(1077, 'hans', 'add date:2017-06-09', '2016-12-02 07:42:07'),
(1078, 'hans', 'add date:2017-06-10', '2016-12-02 07:42:07'),
(1079, 'hans', 'add date:2017-06-11', '2016-12-02 07:42:07'),
(1080, 'hans', 'add date:2017-06-12', '2016-12-02 07:42:07'),
(1081, 'hans', 'add date:2017-06-13', '2016-12-02 07:42:07'),
(1082, 'hans', 'add date:2017-06-14', '2016-12-02 07:42:07'),
(1083, 'hans', 'add date:2017-06-15', '2016-12-02 07:42:08'),
(1084, 'hans', 'add date:2017-06-16', '2016-12-02 07:42:08'),
(1085, 'hans', 'add date:2017-06-17', '2016-12-02 07:42:08'),
(1086, 'hans', 'add date:2017-06-18', '2016-12-02 07:42:08'),
(1087, 'hans', 'add date:2017-06-19', '2016-12-02 07:42:08'),
(1088, 'hans', 'add date:2017-06-20', '2016-12-02 07:42:08'),
(1089, 'hans', 'add date:2017-06-21', '2016-12-02 07:42:08'),
(1090, 'hans', 'add date:2017-06-22', '2016-12-02 07:42:08'),
(1091, 'hans', 'add date:2017-06-23', '2016-12-02 07:42:08'),
(1092, 'hans', 'add date:2017-06-24', '2016-12-02 07:42:08'),
(1093, 'hans', 'add date:2017-06-25', '2016-12-02 07:42:08'),
(1094, 'hans', 'add date:2017-06-26', '2016-12-02 07:42:09'),
(1095, 'hans', 'add date:2017-06-27', '2016-12-02 07:42:09'),
(1096, 'hans', 'add date:2017-06-28', '2016-12-02 07:42:09'),
(1097, 'hans', 'add date:2017-06-29', '2016-12-02 07:42:09'),
(1098, 'hans', 'add date:2017-06-30', '2016-12-02 07:42:09'),
(1099, 'hans', 'add date:2017-07-01', '2016-12-02 07:42:09'),
(1100, 'hans', 'add date:2017-07-02', '2016-12-02 07:42:09'),
(1101, 'hans', 'add date:2017-07-03', '2016-12-02 07:42:09'),
(1102, 'hans', 'add date:2017-07-04', '2016-12-02 07:42:09'),
(1103, 'hans', 'add date:2017-07-05', '2016-12-02 07:42:09'),
(1104, 'hans', 'add date:2017-07-06', '2016-12-02 07:42:09'),
(1105, 'hans', 'add date:2017-07-07', '2016-12-02 07:42:09'),
(1106, 'hans', 'add date:2017-07-08', '2016-12-02 07:42:09'),
(1107, 'hans', 'add date:2017-07-09', '2016-12-02 07:42:10'),
(1108, 'hans', 'add date:2017-07-10', '2016-12-02 07:42:10'),
(1109, 'hans', 'add date:2017-07-11', '2016-12-02 07:42:10'),
(1110, 'hans', 'add date:2017-07-12', '2016-12-02 07:42:10'),
(1111, 'hans', 'add date:2017-07-13', '2016-12-02 07:42:10'),
(1112, 'hans', 'add date:2017-07-14', '2016-12-02 07:42:10'),
(1113, 'hans', 'add date:2017-07-15', '2016-12-02 07:42:10'),
(1114, 'hans', 'add date:2017-07-16', '2016-12-02 07:42:10'),
(1115, 'hans', 'add date:2017-07-17', '2016-12-02 07:42:10'),
(1116, 'hans', 'add date:2017-07-18', '2016-12-02 07:42:10'),
(1117, 'hans', 'add date:2017-07-19', '2016-12-02 07:42:10'),
(1118, 'hans', 'add date:2017-07-20', '2016-12-02 07:42:10'),
(1119, 'hans', 'add date:2017-07-21', '2016-12-02 07:42:11'),
(1120, 'hans', 'add date:2017-07-22', '2016-12-02 07:42:11'),
(1121, 'hans', 'add date:2017-07-23', '2016-12-02 07:42:11'),
(1122, 'hans', 'add date:2017-07-24', '2016-12-02 07:42:11'),
(1123, 'hans', 'add date:2017-07-25', '2016-12-02 07:42:11'),
(1124, 'hans', 'add date:2017-07-26', '2016-12-02 07:42:11'),
(1125, 'hans', 'add date:2017-07-27', '2016-12-02 07:42:11'),
(1126, 'hans', 'add date:2017-07-28', '2016-12-02 07:42:11'),
(1127, 'hans', 'add date:2017-07-29', '2016-12-02 07:42:11'),
(1128, 'hans', 'add date:2017-07-30', '2016-12-02 07:42:11'),
(1129, 'hans', 'add date:2017-07-31', '2016-12-02 07:42:11'),
(1130, 'hans', 'add date:2017-08-01', '2016-12-02 07:42:11'),
(1131, 'hans', 'add date:2017-08-02', '2016-12-02 07:42:11'),
(1132, 'hans', 'add date:2017-08-03', '2016-12-02 07:42:12'),
(1133, 'hans', 'add date:2017-08-04', '2016-12-02 07:42:12'),
(1134, 'hans', 'add date:2017-08-05', '2016-12-02 07:42:12'),
(1135, 'hans', 'add date:2017-08-06', '2016-12-02 07:42:12'),
(1136, 'hans', 'add date:2017-08-07', '2016-12-02 07:42:12'),
(1137, 'hans', 'add date:2017-08-08', '2016-12-02 07:42:12'),
(1138, 'hans', 'add date:2017-08-09', '2016-12-02 07:42:12'),
(1139, 'hans', 'add date:2017-08-10', '2016-12-02 07:42:12'),
(1140, 'hans', 'add date:2017-08-11', '2016-12-02 07:42:12'),
(1141, 'hans', 'add date:2017-08-12', '2016-12-02 07:42:12'),
(1142, 'hans', 'add date:2017-08-13', '2016-12-02 07:42:12'),
(1143, 'hans', 'add date:2017-08-14', '2016-12-02 07:42:13'),
(1144, 'hans', 'add date:2017-08-15', '2016-12-02 07:42:13'),
(1145, 'hans', 'add date:2017-08-16', '2016-12-02 07:42:13'),
(1146, 'hans', 'add date:2017-08-17', '2016-12-02 07:42:13'),
(1147, 'hans', 'add date:2017-08-18', '2016-12-02 07:42:13'),
(1148, 'hans', 'add date:2017-08-19', '2016-12-02 07:42:13'),
(1149, 'hans', 'add date:2017-08-20', '2016-12-02 07:42:13'),
(1150, 'hans', 'add date:2017-08-21', '2016-12-02 07:42:13'),
(1151, 'hans', 'add date:2017-08-22', '2016-12-02 07:42:13'),
(1152, 'hans', 'add date:2017-08-23', '2016-12-02 07:42:13'),
(1153, 'hans', 'add date:2017-08-24', '2016-12-02 07:42:13'),
(1154, 'hans', 'add date:2017-08-25', '2016-12-02 07:42:13'),
(1155, 'hans', 'add date:2017-08-26', '2016-12-02 07:42:13'),
(1156, 'hans', 'add date:2017-08-27', '2016-12-02 07:42:14'),
(1157, 'hans', 'add date:2017-08-28', '2016-12-02 07:42:14'),
(1158, 'hans', 'add date:2017-08-29', '2016-12-02 07:42:14'),
(1159, 'hans', 'add date:2017-08-30', '2016-12-02 07:42:14'),
(1160, 'hans', 'add date:2017-08-31', '2016-12-02 07:42:14'),
(1161, 'hans', 'add date:2017-09-01', '2016-12-02 07:42:14'),
(1162, 'hans', 'add date:2017-09-02', '2016-12-02 07:42:14'),
(1163, 'hans', 'add date:2017-09-03', '2016-12-02 07:42:14'),
(1164, 'hans', 'add date:2017-09-04', '2016-12-02 07:42:14'),
(1165, 'hans', 'add date:2017-09-05', '2016-12-02 07:42:14'),
(1166, 'hans', 'add date:2017-09-06', '2016-12-02 07:42:14'),
(1167, 'hans', 'add date:2017-09-07', '2016-12-02 07:42:14'),
(1168, 'hans', 'add date:2017-09-08', '2016-12-02 07:42:14'),
(1169, 'hans', 'add date:2017-09-09', '2016-12-02 07:42:14'),
(1170, 'hans', 'add date:2017-09-10', '2016-12-02 07:42:14'),
(1171, 'hans', 'add date:2017-09-11', '2016-12-02 07:42:14'),
(1172, 'hans', 'add date:2017-09-12', '2016-12-02 07:42:15'),
(1173, 'hans', 'add date:2017-09-13', '2016-12-02 07:42:15'),
(1174, 'hans', 'add date:2017-09-14', '2016-12-02 07:42:15'),
(1175, 'hans', 'add date:2017-09-15', '2016-12-02 07:42:15'),
(1176, 'hans', 'add date:2017-09-16', '2016-12-02 07:42:15'),
(1177, 'hans', 'add date:2017-09-17', '2016-12-02 07:42:15'),
(1178, 'hans', 'add date:2017-09-18', '2016-12-02 07:42:15'),
(1179, 'hans', 'add date:2017-09-19', '2016-12-02 07:42:15'),
(1180, 'hans', 'add date:2017-09-20', '2016-12-02 07:42:15'),
(1181, 'hans', 'add date:2017-09-21', '2016-12-02 07:42:15'),
(1182, 'hans', 'add date:2017-09-22', '2016-12-02 07:42:15'),
(1183, 'hans', 'add date:2017-09-23', '2016-12-02 07:42:15'),
(1184, 'hans', 'add date:2017-09-24', '2016-12-02 07:42:15'),
(1185, 'hans', 'add date:2017-09-25', '2016-12-02 07:42:16'),
(1186, 'hans', 'add date:2017-09-26', '2016-12-02 07:42:16'),
(1187, 'hans', 'add date:2017-09-27', '2016-12-02 07:42:16'),
(1188, 'hans', 'add date:2017-09-28', '2016-12-02 07:42:16'),
(1189, 'hans', 'add date:2017-09-29', '2016-12-02 07:42:16'),
(1190, 'hans', 'add date:2017-09-30', '2016-12-02 07:42:16'),
(1191, 'hans', 'add date:2017-10-01', '2016-12-02 07:42:16'),
(1192, 'hans', 'add date:2017-10-02', '2016-12-02 07:42:16'),
(1193, 'hans', 'add date:2017-10-03', '2016-12-02 07:42:16'),
(1194, 'hans', 'add date:2017-10-04', '2016-12-02 07:42:16'),
(1195, 'hans', 'add date:2017-10-05', '2016-12-02 07:42:16'),
(1196, 'hans', 'add date:2017-10-06', '2016-12-02 07:42:16'),
(1197, 'hans', 'add date:2017-10-07', '2016-12-02 07:42:16'),
(1198, 'hans', 'add date:2017-10-08', '2016-12-02 07:42:16'),
(1199, 'hans', 'add date:2017-10-09', '2016-12-02 07:42:16'),
(1200, 'hans', 'add date:2017-10-10', '2016-12-02 07:42:16'),
(1201, 'hans', 'add date:2017-10-11', '2016-12-02 07:42:16'),
(1202, 'hans', 'add date:2017-10-12', '2016-12-02 07:42:16'),
(1203, 'hans', 'add date:2017-10-13', '2016-12-02 07:42:16'),
(1204, 'hans', 'add date:2017-10-14', '2016-12-02 07:42:16'),
(1205, 'hans', 'add date:2017-10-15', '2016-12-02 07:42:16'),
(1206, 'hans', 'add date:2017-10-16', '2016-12-02 07:42:16'),
(1207, 'hans', 'add date:2017-10-17', '2016-12-02 07:42:16'),
(1208, 'hans', 'add date:2017-10-18', '2016-12-02 07:42:16'),
(1209, 'hans', 'add date:2017-10-19', '2016-12-02 07:42:16'),
(1210, 'hans', 'add date:2017-10-20', '2016-12-02 07:42:16'),
(1211, 'hans', 'add date:2017-10-21', '2016-12-02 07:42:17'),
(1212, 'hans', 'add date:2017-10-22', '2016-12-02 07:42:17'),
(1213, 'hans', 'add date:2017-10-23', '2016-12-02 07:42:17'),
(1214, 'hans', 'add date:2017-10-24', '2016-12-02 07:42:17'),
(1215, 'hans', 'add date:2017-10-25', '2016-12-02 07:42:17'),
(1216, 'hans', 'add date:2017-10-26', '2016-12-02 07:42:17'),
(1217, 'hans', 'add date:2017-10-27', '2016-12-02 07:42:17'),
(1218, 'hans', 'add date:2017-10-28', '2016-12-02 07:42:17'),
(1219, 'hans', 'add date:2017-10-29', '2016-12-02 07:42:17'),
(1220, 'hans', 'add date:2017-10-30', '2016-12-02 07:42:17'),
(1221, 'hans', 'add date:2017-10-31', '2016-12-02 07:42:17'),
(1222, 'hans', 'add date:2017-11-01', '2016-12-02 07:42:17'),
(1223, 'hans', 'add date:2017-11-02', '2016-12-02 07:42:17'),
(1224, 'hans', 'add date:2017-11-03', '2016-12-02 07:42:17'),
(1225, 'hans', 'add date:2017-11-04', '2016-12-02 07:42:17'),
(1226, 'hans', 'add date:2017-11-05', '2016-12-02 07:42:17'),
(1227, 'hans', 'add date:2017-11-06', '2016-12-02 07:42:17'),
(1228, 'hans', 'add date:2017-11-07', '2016-12-02 07:42:17'),
(1229, 'hans', 'add date:2017-11-08', '2016-12-02 07:42:17'),
(1230, 'hans', 'add date:2017-11-09', '2016-12-02 07:42:17'),
(1231, 'hans', 'add date:2017-11-10', '2016-12-02 07:42:17'),
(1232, 'hans', 'add date:2017-11-11', '2016-12-02 07:42:17'),
(1233, 'hans', 'add date:2017-11-12', '2016-12-02 07:42:17'),
(1234, 'hans', 'add date:2017-11-13', '2016-12-02 07:42:17'),
(1235, 'hans', 'add date:2017-11-14', '2016-12-02 07:42:17'),
(1236, 'hans', 'add date:2017-11-15', '2016-12-02 07:42:17'),
(1237, 'hans', 'add date:2017-11-16', '2016-12-02 07:42:18'),
(1238, 'hans', 'add date:2017-11-17', '2016-12-02 07:42:18'),
(1239, 'hans', 'add date:2017-11-18', '2016-12-02 07:42:18'),
(1240, 'hans', 'add date:2017-11-19', '2016-12-02 07:42:18'),
(1241, 'hans', 'add date:2017-11-20', '2016-12-02 07:42:18'),
(1242, 'hans', 'add date:2017-11-21', '2016-12-02 07:42:18'),
(1243, 'hans', 'add date:2017-11-22', '2016-12-02 07:42:18'),
(1244, 'hans', 'add date:2017-11-23', '2016-12-02 07:42:18'),
(1245, 'hans', 'add date:2017-11-24', '2016-12-02 07:42:18'),
(1246, 'hans', 'add date:2017-11-25', '2016-12-02 07:42:18'),
(1247, 'hans', 'add date:2017-11-26', '2016-12-02 07:42:18'),
(1248, 'hans', 'add date:2017-11-27', '2016-12-02 07:42:18'),
(1249, 'hans', 'add date:2017-11-28', '2016-12-02 07:42:18'),
(1250, 'hans', 'add date:2017-11-29', '2016-12-02 07:42:18'),
(1251, 'hans', 'add date:2017-11-30', '2016-12-02 07:42:18'),
(1252, 'hans', 'add date:2017-12-01', '2016-12-02 07:42:18'),
(1253, 'hans', 'add date:2017-12-02', '2016-12-02 07:42:18'),
(1254, 'hans', 'add date:2017-12-03', '2016-12-02 07:42:18'),
(1255, 'hans', 'add date:2017-12-04', '2016-12-02 07:42:18'),
(1256, 'hans', 'add date:2017-12-05', '2016-12-02 07:42:18'),
(1257, 'hans', 'add date:2017-12-06', '2016-12-02 07:42:18'),
(1258, 'hans', 'add date:2017-12-07', '2016-12-02 07:42:18'),
(1259, 'hans', 'add date:2017-12-08', '2016-12-02 07:42:18'),
(1260, 'hans', 'add date:2017-12-09', '2016-12-02 07:42:18'),
(1261, 'hans', 'add date:2017-12-10', '2016-12-02 07:42:18'),
(1262, 'hans', 'add date:2017-12-11', '2016-12-02 07:42:18'),
(1263, 'hans', 'add date:2017-12-12', '2016-12-02 07:42:18'),
(1264, 'hans', 'add date:2017-12-13', '2016-12-02 07:42:19'),
(1265, 'hans', 'add date:2017-12-14', '2016-12-02 07:42:19'),
(1266, 'hans', 'add date:2017-12-15', '2016-12-02 07:42:19'),
(1267, 'hans', 'add date:2017-12-16', '2016-12-02 07:42:19'),
(1268, 'hans', 'add date:2017-12-17', '2016-12-02 07:42:19'),
(1269, 'hans', 'add date:2017-12-18', '2016-12-02 07:42:19'),
(1270, 'hans', 'add date:2017-12-19', '2016-12-02 07:42:19'),
(1271, 'hans', 'add date:2017-12-20', '2016-12-02 07:42:19'),
(1272, 'hans', 'add date:2017-12-21', '2016-12-02 07:42:19'),
(1273, 'hans', 'add date:2017-12-22', '2016-12-02 07:42:19'),
(1274, 'hans', 'add date:2017-12-23', '2016-12-02 07:42:19'),
(1275, 'hans', 'add date:2017-12-24', '2016-12-02 07:42:19'),
(1276, 'hans', 'add date:2017-12-25', '2016-12-02 07:42:19'),
(1277, 'hans', 'add date:2017-12-26', '2016-12-02 07:42:19'),
(1278, 'hans', 'add date:2017-12-27', '2016-12-02 07:42:19'),
(1279, 'hans', 'add date:2017-12-28', '2016-12-02 07:42:19'),
(1280, 'hans', 'add date:2017-12-29', '2016-12-02 07:42:19'),
(1281, 'hans', 'add date:2017-12-30', '2016-12-02 07:42:19'),
(1282, 'hans', 'add date:2017-12-31', '2016-12-02 07:42:20');

-- --------------------------------------------------------

--
-- Table structure for table `mr_book`
--

CREATE TABLE `mr_book` (
  `id` int(11) NOT NULL,
  `request_by` varchar(30) NOT NULL,
  `request_date` date NOT NULL,
  `xreq_date` date NOT NULL,
  `start_hour` int(11) NOT NULL,
  `end_hour` int(11) NOT NULL,
  `mr` varchar(10) NOT NULL,
  `tipe` varchar(10) NOT NULL,
  `attendant` varchar(20) NOT NULL,
  `laptop` varchar(1) NOT NULL,
  `proyektor` varchar(1) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `reqstatus` enum('aktif','nonaktiv') NOT NULL DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mr_book`
--

INSERT INTO `mr_book` (`id`, `request_by`, `request_date`, `xreq_date`, `start_hour`, `end_hour`, `mr`, `tipe`, `attendant`, `laptop`, `proyektor`, `description`, `reqstatus`) VALUES
(1, 'hans', '2016-11-08', '0000-00-00', 10, 12, 'APPLE', 'INTERNAL', '>4', '', '', 'percobaan saja', 'aktif'),
(2, 'hans', '2016-11-08', '0000-00-00', 10, 12, 'BERRY', 'INTERNAL', '>4', '', '', 'percobaan saja', 'aktif'),
(15, 'hans', '2016-11-10', '0000-00-00', 8, 9, 'APPLE', 'INTERNAL', '<=4', '', '', '', 'aktif'),
(17, 'rizki', '2016-11-09', '0000-00-00', 13, 14, 'APPLE', 'INTERNAL', '<=4', '', '', '                    \r\n                ', 'aktif'),
(18, 'rizki', '2016-11-11', '0000-00-00', 9, 12, 'APPLE', 'INTERNAL', '<=4', '', '', '', 'aktif'),
(19, 'nancy', '2016-11-11', '0000-00-00', 13, 16, 'BERRY', 'EXTERNAL', '>4', '', '', 'egrebh', 'aktif'),
(20, 'rizki', '0000-00-00', '2016-11-17', 8, 10, 'APPLE', 'INTERNAL', '<=4', '', '', '', 'nonaktiv'),
(28, 'hans', '2016-11-29', '0000-00-00', 8, 9, 'APPLE', 'INTERNAL', '<=4', '', 'y', '', 'aktif'),
(29, 'nia', '2016-11-18', '0000-00-00', 15, 16, 'APPLE', 'EXTERNAL', '<=4', '', 'y', '', 'aktif'),
(31, 'rizki', '0000-00-00', '2016-11-26', 8, 9, 'BERRY', 'INTERNAL', '<=4', '', '', '', 'nonaktiv'),
(32, 'rizki', '2016-11-17', '0000-00-00', 8, 9, 'APPLE', 'INTERNAL', '<=4', 'y', '', '', 'aktif'),
(33, 'rizki', '2016-11-17', '0000-00-00', 10, 11, 'APPLE', 'INTERNAL', '<=4', 'y', 'y', '', 'aktif'),
(34, 'rizki', '2016-11-19', '0000-00-00', 8, 9, 'APPLE', 'INTERNAL', '<=4', 'y', '', '', 'aktif'),
(35, 'rizki', '0000-00-00', '2016-11-23', 8, 9, 'BERRY', 'INTERNAL', '<=4', '', 'y', '', 'nonaktiv'),
(36, 'rizki', '2016-11-21', '0000-00-00', 15, 18, 'BERRY', 'INTERNAL', '<=4', 'y', 'y', '', 'aktif'),
(37, 'rizki', '2016-11-17', '0000-00-00', 11, 12, 'APPLE', 'INTERNAL', '<=4', 'y', '', '', 'aktif'),
(38, 'rizki', '0000-00-00', '2016-11-17', 12, 15, 'APPLE', 'INTERNAL', '<=4', 'y', 'y', '', 'nonaktiv'),
(39, 'rizki', '2016-11-17', '0000-00-00', 16, 17, 'APPLE', 'EXTERNAL', '<=4', '', 'y', '', 'aktif'),
(40, 'rizki', '0000-00-00', '2016-11-29', 11, 12, 'APPLE', 'INTERNAL', '<=4', '', '', '', 'nonaktiv'),
(41, 'rizki', '2016-11-29', '0000-00-00', 9, 10, 'APPLE', 'INTERNAL', '>4', '', 'y', '', 'aktif'),
(42, 'nancy', '2016-11-29', '0000-00-00', 10, 12, 'APPLE', 'INTERNAL', '<=4', '', '', '', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `mr_book_request`
--

CREATE TABLE `mr_book_request` (
  `id` int(11) NOT NULL,
  `reqby` varchar(30) NOT NULL,
  `mr_id` int(11) NOT NULL,
  `urgency` int(11) NOT NULL DEFAULT '1' COMMENT '1:high,2:ultra;3:legendary',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1:post,2:reject'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mr_book_request`
--

INSERT INTO `mr_book_request` (`id`, `reqby`, `mr_id`, `urgency`, `status`) VALUES
(1, 'nancy', 1, 1, 1),
(2, 'nancy', 1, 1, 1),
(3, 'nancy', 2, 1, 1),
(4, 'nancy', 15, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `staffoff_log`
--

CREATE TABLE `staffoff_log` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `off_type` int(11) NOT NULL,
  `input_date` datetime DEFAULT NULL,
  `input_by` varchar(64) DEFAULT NULL,
  `cancel_date` datetime DEFAULT NULL,
  `cancel_by` varchar(64) DEFAULT NULL,
  `status` enum('OFF','CANCEL') NOT NULL DEFAULT 'OFF'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staffoff_log`
--

INSERT INTO `staffoff_log` (`id`, `user`, `date`, `off_type`, `input_date`, `input_by`, `cancel_date`, `cancel_by`, `status`) VALUES
(1, 6, '2016-12-16 00:00:00', 1, '2016-12-15 10:59:35', 'nancy', '2016-12-15 11:42:41', 'nancy', 'CANCEL'),
(2, 6, '2016-12-16 00:00:00', 1, '2016-12-15 11:00:14', 'nancy', NULL, NULL, 'OFF');

-- --------------------------------------------------------

--
-- Table structure for table `usdcvrate`
--

CREATE TABLE `usdcvrate` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `torp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usdcvrate`
--

INSERT INTO `usdcvrate` (`id`, `date`, `torp`) VALUES
(4, '2016-12-21', 15000),
(5, '2016-12-22', 15500);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) NOT NULL,
  `nik` varchar(10) NOT NULL,
  `occupation` varchar(30) NOT NULL,
  `level` varchar(15) NOT NULL,
  `department` varchar(30) NOT NULL,
  `joindate` date NOT NULL,
  `direct_acc` varchar(30) NOT NULL,
  `escalate_to` varchar(30) NOT NULL,
  `picture` varchar(255) NOT NULL,
  `privileges` int(11) NOT NULL,
  `status` enum('active','nonactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `nik`, `occupation`, `level`, `department`, `joindate`, `direct_acc`, `escalate_to`, `picture`, `privileges`, `status`) VALUES
(1, 'hans', '*875C5CB2B23148D3C30BDB7E3CD05E91D2864572', 'Hans Wiriya Tsai', 'INT147', 'IT Manager', 'Manager', 'IT', '0000-00-00', 'edouard', 'nancy', '', 4, 'active'),
(2, 'rizki', '*759EBCD17CD487BB52ED791CB7FE3850426B4C41', 'Muhammad Rizkiansyah', 'INT131', 'IT Support Staff', 'Manager', 'IT', '2016-03-05', 'hans', 'nancy', 'profile_pic/mee.jpg', 0, 'active'),
(3, 'nia', '*8D8CBAB0FCDA6E32D87061578BF4756BD79995BC', 'Kurniawati', 'INT118', 'Office Manager', 'Manager', 'GA', '0000-00-00', 'edouard', 'nancy', '', 3, 'active'),
(4, 'nancy', '*D7A6DEF41982646DC95F4E8A718436E4F0415D27', 'Nancy Triana Desianti', 'INT070', 'HR Manager', 'Manager', 'HR', '0000-00-00', 'edouard', 'nancy', '', 5, 'active'),
(5, 'edouard', '*AC13A257807009175FD79A57D59D7DE848459934', 'Edouard Helfand', 'INT001', 'Managing Director', 'Director', 'All', '2008-01-17', 'edouard', 'nancy', '', 99, 'active'),
(6, 'rustam', '*F8DEACF58432624BDB6D461FBC2E9C5043B41390', 'Rustam Efendi', 'INT004', 'KO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(7, 'faisal', '*FA9E82FA2DFEAD6B7CA02C73FCA537E79C5C48A2', 'M. Faisal', 'INT005', 'KO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(8, 'andi', '*E7317DE59058E53CBBC194814A474148BEB1FD8E', 'Andi Agus Muliadi', 'INT006', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(9, 'ngadimun', '*40AAC841D8C2C7E8B49EED85D560BCE8F9D79894', 'Ngadimun', 'INT008', 'Office Helper', 'Staff', 'GA', '0000-00-00', 'nia', 'nancy', 'profile_pic/Selection_003.png', 0, 'active'),
(10, 'adiawan', '*F1ADECB2DE0E4CC49E2F1BD50FA4194769AC3554', 'Adiawan Triko Laksono ', 'INT010', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(11, 'chrismas', '*4131D1C21BD6D5F03A74FC4F02AC07222FEE1961', 'Chrismas Putra Siringo Ringo', 'INT014', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(12, 'polycarpus', '*C81A2E86DC886092BF35D81604F6B64770F595DE', 'Polycarpus Agnes Febian', 'INT015', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(13, 'rahmad', '*C14DAD555F7A2CC511C5ED39BD006D21020C90DC', 'Rahmad Purwanto', 'INT016', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(14, 'weddy', '*6D228950E2874463A1DCDF610B5F5FB5B935220D', 'Weddy Mallyan', 'INT017', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(15, 'niken', '*1262F44EFDE092141DBD0D4A04A3CCDE7CCCD7B4', 'Niken Dwi Ismoyowati', 'INT022', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(16, 'ghali', '*4FFE3241704FE9FA5073359DEC171FD385EA3316', 'Ghali', 'INT023', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(17, 'josep', '*DF2A7489EE6FC76818EFE4959F46EA750F732824', 'Josep Hasudungan Sihombing', 'INT025', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(18, 'siti', '*15E6DD508037B4F5FB2711D3C7DFEBBA52BCA072', 'Siti Fadillah', 'INT026', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(19, 'athar', '*81FF5F880C614238F7426A0298C62D9FEC7F0DC0', 'Athar Muhammad Dien', 'INT033', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(20, 'imam', '*AB48FF7FA07E1A7992F5A5BC33731A1C79291FC0', 'Imam Munawir', 'INT034', 'IGLK', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(21, 'sri', '*1ECD07FC7CB47203F59A902D045100AA36AB4EA4', 'Sri Damayanti', 'INT036', 'IGLK', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(22, 'marias', '*6405746C3562D4859271E21313019EB5548E5ACE', 'Maria Stefani', 'INT038', 'IGLK', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(23, 'boy', '*61106F01F8AF0EA8B25CD53E642EDE98EAC86886', 'Ignatius Chau Boy Fong', 'INT041', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(24, 'misbakhudin', '*771342EA8D8431ECC76C61BD84CBA8125986E476', 'Misbakhudin', 'INT043', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(25, 'muchlis', '*95E5C9D76CF73D9F51E7592674A7386F56B87314', 'Muhamad Muchlis', 'INT045', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(26, 'marathur', '*1E032784D7D9F1DCFED0FFE3E82AA837A9BD620A', 'Marathur Nicholas Lubis', 'INT047', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(27, 'rolus', '*4BEBEE3DCFF43BBE5D335C512A00146656BCCE8E', 'Fransisko Rolus S.', 'INT048', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(28, 'nurwidi', '*E575F119B50F50F96ED71A83A742E1D41E042FD7', 'Nur Widi Atmaka', 'INT050', 'IGLK', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(29, 'nursalim', '*DEA8F9D37A16403FF6FC52C53BEAC84DB8B8F484', 'Nur Salim', 'INT053', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(30, 'arif', '*1216FAD9FAA1CB583F6BB97E93C02003895EE2F7', 'Arif Setiawan', 'INT064', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(31, 'haryoto', '*FB9797E024BB44A07A41F76DEF3BEB52A8462B52', 'Haryoto', 'INT067', 'Office Helper', 'Staff', 'GA', '0000-00-00', 'nia', 'nancy', '', 0, 'active'),
(32, 'dipta', '*6D83B2C08DC7133401346E86CAEE13C8FC4F5FA7', 'Apsari Tathyapradipta', 'INT068', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(33, 'tri', '*74391658D8FC96F83EEFEB87D0530224CD7C6CF4', 'Tri Mardiyanto', 'INT069', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(34, 'agus', '*D78E5B251824E7A0281E7BBD93F840E98078D04D', 'Agus Supriyanto', 'INT077', 'Accounting Manager', 'Manager', 'Management', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(35, 'annisa', '*3115A838710074AB776571F1676BEDFB29759936', 'Annisa Hidayat', 'INT086', 'Screener Manager', 'Manager', 'PES', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(36, 'soetarno', '*8084108666BDBFC38DC217E5F9FABA30C089E5E3', 'Soetarno', 'INT087', 'Field Supervisor', 'Supervisor', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 1, 'active'),
(37, 'loementa', '*CA986CA7E7EFCDD64F62ECC20A53A8EDD266787B', 'Loementa Franata Gultom', 'INT088', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(38, 'essy', '*0A2F4B19FBC7D198CBFFFD8F0135FE43C9FD95AB', 'Essy Adelina', 'INT089', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(39, 'azhara', '*565DA6B53EB927F59BCCC1256C518C2E600B81F9', 'Azhara Khayati', 'INT093', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(40, 'iskah', '*A91D26ED687205D7A446934E1B1AA631D99F2969', 'M. Iskah Hatiab', 'INT094', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(41, 'fizardin', '*B1DBBC4E441439C991A9676757F7C88E3899B996', 'Muhamad Fizardin Hasri', 'INT095', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(42, 'ade', '*27355480E8E95D29D56488CD6FDE2C4CDA062DAE', 'Ade Kurniawan', 'INT099', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(43, 'sekar', '*6D52CC7DA61BC44146B60EA0E254492FCF2FE981', 'Sekar Ayu Saraswati', 'INT100', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(44, 'ivan', '*1663B6E71C0DA886BFF05515D362909F6C212B0D', 'Ivan Hanjaya', 'INT102', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(45, 'indri', '*9C8A20C2919F1F2BCE6C0053FBA4C9A6165C0B98', 'Indri Pohan', 'INT103', 'HR Supervisor', 'Supervisor', 'HR', '0000-00-00', 'nancy', 'nancy', '', 6, 'active'),
(46, 'wartanto', '*A0A5E89881C58FB608DC758D316220134E011122', 'Wartanto', 'INT111', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(47, 'rio', '*A08F7BD5ECF1E9002C2C531F662909B0E66974DF', 'Rio Octovian', 'INT109', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(48, 'alimudin', '*49EF91C7508DFB4FDAE3FA0EE1B0D6ED20ADCF91', 'Alimudin', 'INT114', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(49, 'dimas', '*A0E34560A4BE27FB4D7F3C2A225474C5DDBA5E13', 'Dimas Ramdhani', 'INT120', 'SO', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(50, 'halimah', '*E09DA5603A1E89C4C876B7EC8C676E0194520B56', 'Halimah Fatah Riyani', 'INT123', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(51, 'agnes', '*4BE34DCD1DC1D9EC8E48B94CA41DA150B07814E5', 'Agnessia Gabriella Cu', 'INT124', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(52, 'djohan', '*08CD39E8E523CBBCE339516CE9765D451A3B4776', 'Djohan Maruli Sitanggang', 'INT125', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(53, 'eka', '*53509907AA99985AD370AA2913A6CFAFC2FFA393', 'Eka Sari', 'INT126', 'Office Staff', 'Staff', 'GA', '0000-00-00', 'nia', 'nancy', '', 0, 'active'),
(54, 'sauri', '*5E3500901DA7B1ED60D792005CA17A6039950C4D', 'Sauri Susanto', 'INT128', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(55, 'puteri', '*87EB10E344003C2882CD57ECE2B33CFDD8C303ED', 'Hasmiranti Puteri Sophiansari', 'INT129', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(56, 'damanhuri', '*A5BF74D98F90CB27D243A77D14A04B1F66402E2F', 'Damanhuri Irawan', 'INT134', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(57, 'sohibu', '*11A84344179FE5F674EA344E042EB31159A27783', 'Rio Sohibu Nur', 'INT135', 'Office Helper', 'Staff', 'GA', '0000-00-00', 'nia', 'nancy', '', 0, 'active'),
(58, 'nisma', '*1BAF7B549D08A277A08F566FE2EDFC79AA532B53', 'Nisma Mediyanti', 'INT136', 'Account Manager', 'Manager', 'Management', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(59, 'dede', '*220D625DA5AF79D43F2BF817829A4A894FBCA892', 'Dede Setiowati', 'INT137', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(60, 'yanuar', '*FDB520F0E038B1FC9FC7228BCDDBDBD671BEC8B3', 'Yanuar Permadi', 'INT138', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(61, 'tua', '*6A6BB55B89EA7E5A7F0494E3753C42129E815A4D', 'Tua Maratur Naibaho', 'INT139', 'Project Manager', 'Manager', 'PM', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(62, 'jodya', '*2C990E01DDF07A492AE8F5D4D5D43C9690EF0E84', 'Jodya Bintang Herwidianto', 'INT140', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(63, 'dillon', '*2ED87517DE34F4C5639C4E3A5CBF3F50A5ED28EB', 'Dillon Kassandra Iskandar', 'INT141', 'IGLK', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(64, 'fira', '*A046C314149CDA86E2916C6EB1ADAB8A4B87A45B', 'Fira Sarah Wikristina', 'INT142', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(65, 'lucky', '*EF3AF4DEFAEF86E6C7D352CE4078BD7A386B6A18', 'Lucky Maulida Setiawan', 'INT143', 'PES', 'Staff', 'IGSOFS', '0000-00-00', 'soetarno', 'nancy', '', 0, 'active'),
(66, 'sabta', '*7FED6A2BDE0A566991A6E01052D089DD5E230B8D', 'Sabta Elisa', 'INT146', 'Business Development Manager', 'Manager', 'Management', '0000-00-00', 'edouard', 'nancy', '', 2, 'active'),
(67, 'hirson', '*AFA20D474509E6114A088569737CE9742389D5FA', 'Hirson Kurnia', 'INT148', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(68, 'stasya', '*0DA83AE319AA7E251EA3007A908A3BBBA9E395BD', 'Stasya Desnafira', 'INT149', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(69, 'ramses', '*856575A1E2D2F571D0D8027DA249AF32DD9F2438', 'Ramses Bano', 'INT150', 'IGJKT', 'Manager', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(70, 'rina', '*EEB81B663DFB5ED734BA6EB006215E8E8C5C9D23', 'Rina Maryanti', 'INT151', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(71, 'danang', '*3E2A30AC146B152C4627363CF2E29793C026312A', 'Danang Pudjo Setiawan', 'INT153', 'Screener', 'Staff', 'PES', '0000-00-00', 'annisa', 'nancy', '', 0, 'active'),
(72, 'ardy', '*8916AF3ECBB2675FE677070A3B262D1AE45690D7', 'Ardy Pradana Putra', 'INT154', 'IGJKT', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(73, 'ariyanto', '*21A50D5ADFADD090DED1B6D84B133F3DEBDB3B52', 'Ariyanto', 'INT155', 'IT Digital Forensic', 'Staff', 'IGSOFS', '0000-00-00', 'edouard', 'nancy', '', 0, 'active'),
(74, 'jokowi', '*5CC5811FFC4CF42C2FABEAB3F2D2EED42642325C', 'Joko Widagdo', 'INT156', 'IT Senior', 'Staff', 'IT', '2017-01-16', 'edouard', 'nancy', 'profile_pic/jokowi.jpg', 0, 'active'),
(75, 'yudono', '*017C8E51509D020863DE0A0DDAD6D362EA1E065E', 'Anak Pepo Youdoyouknow', 'INT157', 'IT Junior', 'Staff', 'IT', '2017-01-17', 'hans', 'nancy', '', 0, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `wikiboard`
--

CREATE TABLE `wikiboard` (
  `id` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `author` varchar(64) NOT NULL,
  `postdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifdate` timestamp NULL DEFAULT NULL,
  `title` text NOT NULL,
  `story` longtext NOT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wikiboard`
--

INSERT INTO `wikiboard` (`id`, `category`, `tags`, `author`, `postdate`, `modifdate`, `title`, `story`, `status`) VALUES
(12, 'IT', 'news, update, tutorial, funny', 'Muhammad Rizkiansyah', '2016-10-19 01:49:22', '2016-10-19 01:49:22', 'Akun BBM DPR Dibajak, Pengamat: Harusnya Gampang Dilacak', '<p>Waw</p><h1>Judul</h1>', 'ACTIVE'),
(14, 'IT', 'tutorial', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'test cerita', '<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa <strong>aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa a</strong>ja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja ap<em>a aja apa aja apa aj</em>a apa aja apa aja apa aja apa aja ($%(%%)</p>\r\n<p>&nbsp;</p>\r\n<p>(#)##)##()*)*</p>\r\n<p>&nbsp;</p>', 'ACTIVE'),
(16, 'IT', 'news, update', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'Akun BBM DPR Dibajak, Pengamat: Harusnya Gampang Dilacak', '<p>Waw</p>', 'ACTIVE'),
(17, 'IT', 'induction', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'DPT Viewer (1.0.0 and 1.1.0)', '', 'ACTIVE'),
(18, 'IT', 'tutorial', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'test cerita', '<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa <strong>aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa a</strong>ja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja ap<em>a aja apa aja apa aj</em>a apa aja apa aja apa aja apa aja ($%(%%)</p>\r\n<p>&nbsp;</p>\r\n<p>(#)##)##()*)*</p>\r\n<p>&nbsp;</p>', 'ACTIVE'),
(23, 'HR', 'news, update', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'Akun BBM DPR Dibajak, Pengamat: Harusnya Gampang Dilacak', '<p>Waw</p>', 'ACTIVE'),
(24, 'HR', 'induction', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'DPT Viewer (1.0.0 and 1.1.0)', '', 'ACTIVE'),
(25, 'IT', 'tutorial', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'test cerita', '<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa <strong>aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa a</strong>ja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja ap<em>a aja apa aja apa aj</em>a apa aja apa aja apa aja apa aja ($%(%%)</p>\r\n<p>&nbsp;</p>\r\n<p>(#)##)##()*)*</p>\r\n<p>&nbsp;</p>', 'ACTIVE'),
(26, 'HR', 'info', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'ga bisa?', '<p>gagal</p>', 'ACTIVE'),
(27, 'IT', 'news, update', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'Akun BBM DPR Dibajak, Pengamat: Harusnya Gampang Dilacak', '<p>Waw</p>', 'ACTIVE'),
(28, 'IT', 'induction', 'Muhammad Rizkiansyah', '2016-10-18 02:28:53', NULL, 'DPT Viewer (1.0.0 and 1.1.0)', '', 'ACTIVE'),
(29, 'IT', 'tutorial', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'test cerita', '<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa <strong>aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa a</strong>ja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja apa aja ap<em>a aja apa aja apa aj</em>a apa aja apa aja apa aja apa aja ($%(%%)</p>\r\n<p>&nbsp;</p>\r\n<p>(#)##)##()*)*</p>\r\n<p>&nbsp;</p>', 'ACTIVE'),
(30, 'IT', 'news', 'Hans Wiriya Tsai', '2016-10-18 02:28:53', NULL, 'ga bisa?', '<p>gagal</p>', 'ACTIVE');

-- --------------------------------------------------------

--
-- Table structure for table `__chpw_log`
--

CREATE TABLE `__chpw_log` (
  `id` int(11) NOT NULL,
  `username` int(64) NOT NULL,
  `pwd` varchar(1000) NOT NULL COMMENT 'n:64NEW_o:64OLD',
  `reg_time` datetime NOT NULL,
  `ip_address` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `__chpw_log`
--

INSERT INTO `__chpw_log` (`id`, `username`, `pwd`, `reg_time`, `ip_address`) VALUES
(1, 0, 'rizki', '2017-01-02 18:32:55', '127.0.1.1'),
(2, 0, 'n:cml6a2ky_o:cml6a2k=', '2017-01-02 18:37:31', '127.0.1.1');

-- --------------------------------------------------------

--
-- Table structure for table `__login_log`
--

CREATE TABLE `__login_log` (
  `id` int(11) NOT NULL,
  `username` varchar(64) NOT NULL,
  `state` int(11) NOT NULL COMMENT '[login] 1: success, 0: failed [logout] 2: logout',
  `reg_time` datetime NOT NULL,
  `ip_address` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `__login_log`
--

INSERT INTO `__login_log` (`id`, `username`, `state`, `reg_time`, `ip_address`) VALUES
(1, 'rizki', 2, '2017-01-02 18:25:12', '127.0.1.1'),
(2, 'rizki', 0, '2017-01-02 18:25:29', '127.0.1.1'),
(3, 'rizki', 1, '2017-01-02 18:25:42', '127.0.1.1'),
(4, 'rizki', 2, '2017-01-02 18:26:00', '127.0.1.1'),
(5, 'rizki', 1, '2017-01-02 18:31:51', '127.0.1.1'),
(6, 'rizki', 2, '2017-01-02 18:44:09', '127.0.1.1'),
(7, 'nancy', 1, '2017-01-03 08:30:27', '127.0.1.1'),
(8, 'nancy', 2, '2017-01-03 08:30:32', '127.0.1.1'),
(9, 'rizki', 0, '2017-01-03 08:30:38', '127.0.1.1'),
(10, 'rizki', 0, '2017-01-03 08:30:47', '127.0.1.1'),
(11, 'rizki', 0, '2017-01-03 08:30:54', '127.0.1.1'),
(12, 'nancy', 1, '2017-01-03 08:31:00', '127.0.1.1'),
(13, 'nancy', 2, '2017-01-03 09:00:26', '127.0.1.1'),
(14, 'indri', 1, '2017-01-03 09:00:32', '127.0.1.1'),
(15, 'indri', 2, '2017-01-03 09:01:07', '127.0.1.1'),
(16, 'nancy', 1, '2017-01-03 09:01:14', '127.0.1.1'),
(17, 'nancy', 2, '2017-01-03 09:01:50', '127.0.1.1'),
(18, 'indri', 1, '2017-01-03 09:01:57', '127.0.1.1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claim_kesehatan`
--
ALTER TABLE `claim_kesehatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `no_claim` (`no_claim`);

--
-- Indexes for table `claim_kesehatan_detail`
--
ALTER TABLE `claim_kesehatan_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `no_claim` (`no_claim`);

--
-- Indexes for table `cuti_jenis`
--
ALTER TABLE `cuti_jenis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuti_log`
--
ALTER TABLE `cuti_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuti_periode`
--
ALTER TABLE `cuti_periode`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuti_quota`
--
ALTER TABLE `cuti_quota`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `daily_dollar`
--
ALTER TABLE `daily_dollar`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tanggal` (`tanggal`);

--
-- Indexes for table `email_list`
--
ALTER TABLE `email_list`
  ADD UNIQUE KEY `nik` (`nik`);

--
-- Indexes for table `extension_list`
--
ALTER TABLE `extension_list`
  ADD UNIQUE KEY `nik` (`nik`);

--
-- Indexes for table `inlieuoff_log`
--
ALTER TABLE `inlieuoff_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kalender`
--
ALTER TABLE `kalender`
  ADD PRIMARY KEY (`tanggal`),
  ADD KEY `tanggal` (`tanggal`);

--
-- Indexes for table `konfigurasi`
--
ALTER TABLE `konfigurasi`
  ADD PRIMARY KEY (`conf_id`);

--
-- Indexes for table `lembur_jenis`
--
ALTER TABLE `lembur_jenis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lembur_log`
--
ALTER TABLE `lembur_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `limit`
--
ALTER TABLE `limit`
  ADD PRIMARY KEY (`nik`);

--
-- Indexes for table `masterlogs`
--
ALTER TABLE `masterlogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mr_book`
--
ALTER TABLE `mr_book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mr_book_request`
--
ALTER TABLE `mr_book_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staffoff_log`
--
ALTER TABLE `staffoff_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `usdcvrate`
--
ALTER TABLE `usdcvrate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wikiboard`
--
ALTER TABLE `wikiboard`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `__chpw_log`
--
ALTER TABLE `__chpw_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `__login_log`
--
ALTER TABLE `__login_log`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claim_kesehatan`
--
ALTER TABLE `claim_kesehatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `claim_kesehatan_detail`
--
ALTER TABLE `claim_kesehatan_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `cuti_jenis`
--
ALTER TABLE `cuti_jenis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `cuti_log`
--
ALTER TABLE `cuti_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;
--
-- AUTO_INCREMENT for table `cuti_periode`
--
ALTER TABLE `cuti_periode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cuti_quota`
--
ALTER TABLE `cuti_quota`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `daily_dollar`
--
ALTER TABLE `daily_dollar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `inlieuoff_log`
--
ALTER TABLE `inlieuoff_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `lembur_jenis`
--
ALTER TABLE `lembur_jenis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `lembur_log`
--
ALTER TABLE `lembur_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `masterlogs`
--
ALTER TABLE `masterlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1283;
--
-- AUTO_INCREMENT for table `mr_book`
--
ALTER TABLE `mr_book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `mr_book_request`
--
ALTER TABLE `mr_book_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `staffoff_log`
--
ALTER TABLE `staffoff_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usdcvrate`
--
ALTER TABLE `usdcvrate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `wikiboard`
--
ALTER TABLE `wikiboard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `__chpw_log`
--
ALTER TABLE `__chpw_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `__login_log`
--
ALTER TABLE `__login_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `daily_dollar`
--
ALTER TABLE `daily_dollar`
  ADD CONSTRAINT `daily_dollar_ibfk_1` FOREIGN KEY (`tanggal`) REFERENCES `kalender` (`tanggal`);

--
-- Constraints for table `staffoff_log`
--
ALTER TABLE `staffoff_log`
  ADD CONSTRAINT `staffoff_log_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
