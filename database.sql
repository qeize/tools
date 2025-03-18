-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 20, 2024 at 07:11 PM
-- Server version: 10.6.18-MariaDB-cll-lve
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kincai77fun_DEMO`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_admin`
--

CREATE TABLE `tb_admin` (
  `cuid` int(11) NOT NULL,
  `min_depo` int(11) NOT NULL,
  `min_wd` int(11) NOT NULL,
  `com_ref` text NOT NULL,
  `rabat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_admin`
--

INSERT INTO `tb_admin` (`cuid`, `min_depo`, `min_wd`, `com_ref`, `rabat`) VALUES
(1, 20000, 50000, '0', '0.5');

-- --------------------------------------------------------

--
-- Table structure for table `tb_backup`
--

CREATE TABLE `tb_backup` (
  `cuid` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_banner`
--

CREATE TABLE `tb_banner` (
  `cuid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `status` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_banner`
--

INSERT INTO `tb_banner` (`cuid`, `image`, `content`, `status`) VALUES
(1, 'brand_spiderman_20240618092129.png', 'kincai77', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `tb_gamelist`
--

CREATE TABLE `tb_gamelist` (
  `cuid` int(255) NOT NULL,
  `provider` text NOT NULL,
  `image` text NOT NULL,
  `gameid` text NOT NULL,
  `gamename` text NOT NULL,
  `category` text NOT NULL,
  `datatype` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tb_gamelist`
--

INSERT INTO `tb_gamelist` (`cuid`, `provider`, `image`, `gameid`, `gamename`, `category`, `datatype`) VALUES
(1, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243mwarrior.png', 'vs243mwarrior', 'Monkey Warrior', 'slot', 'SL'),
(2, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20doghouse.png', 'vs20doghouse', 'The Dog House', 'slot', 'SL'),
(3, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40pirate.png', 'vs40pirate', 'Pirate Gold', 'slot', 'SL'),
(4, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20rhino.png', 'vs20rhino', 'Great Rhino', 'slot', 'SL'),
(5, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25pandagold.png', 'vs25pandagold', 'Panda Fortune', 'slot', 'SL'),
(6, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs4096bufking.png', 'vs4096bufking', 'Buffalo King', 'slot', 'SL'),
(7, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25pyramid.png', 'vs25pyramid', 'Pyramid King', 'slot', 'SL'),
(8, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5ultrab.png', 'vs5ultrab', 'Ultra Burn', 'slot', 'SL'),
(9, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5ultra.png', 'vs5ultra', 'Ultra Hold and Spin', 'slot', 'SL'),
(10, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25jokerking.png', 'vs25jokerking', 'Joker King', 'slot', 'SL'),
(11, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10returndead.png', 'vs10returndead', 'Return of the Dead', 'slot', 'SL'),
(12, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10madame.png', 'vs10madame', 'Madame Destiny', 'slot', 'SL'),
(13, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs15diamond.png', 'vs15diamond', 'Diamond Strike', 'slot', 'SL'),
(14, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25aztecking.png', 'vs25aztecking', 'Aztec King', 'slot', 'SL'),
(15, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25wildspells.png', 'vs25wildspells', 'Wild Spells', 'slot', 'SL'),
(16, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbbonanza.png', 'vs10bbbonanza', 'Big Bass Bonanza', 'slot', 'SL'),
(17, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10cowgold.png', 'vs10cowgold', 'Cowboys Gold', 'slot', 'SL'),
(18, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25tigerwar.png', 'vs25tigerwar', 'The Tiger Warrior', 'slot', 'SL'),
(19, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25mustang.png', 'vs25mustang', 'Mustang Gold', 'slot', 'SL'),
(20, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25hotfiesta.png', 'vs25hotfiesta', 'Hotfiesta', 'slot', 'SL'),
(21, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243dancingpar.png', 'vs243dancingpar', 'Dance Party', 'slot', 'SL'),
(22, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs576treasures.png', 'vs576treasures', 'Wild Wild Riches', 'slot', 'SL'),
(23, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20hburnhs.png', 'vs20hburnhs', 'Hot to Burn Hold and Spin', 'slot', 'SL'),
(24, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20emptybank.png', 'vs20emptybank', 'Empty the Bank', 'slot', 'SL'),
(25, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20midas.png', 'vs20midas', 'The Hand of Midas', 'slot', 'SL'),
(26, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20olympgate.png', 'vs20olympgate', 'Gates of Olympus', 'slot', 'SL'),
(27, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayslight.png', 'vswayslight', 'Lucky Lightning', 'slot', 'SL'),
(28, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20vegasmagic.png', 'vs20vegasmagic', 'Vegas Magic', 'slot', 'SL'),
(29, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20fruitparty.png', 'vs20fruitparty', 'Fruit Party', 'slot', 'SL'),
(30, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20fparty2.png', 'vs20fparty2', 'Fruit Party 2', 'slot', 'SL'),
(31, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysdogs.png', 'vswaysdogs', 'The Dog House Megaways', 'slot', 'SL'),
(32, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50juicyfr.png', 'vs50juicyfr', 'Juicy Fruits', 'slot', 'SL'),
(33, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25pandatemple.png', 'vs25pandatemple', 'Panda Fortune 2', 'slot', 'SL'),
(34, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbufking.png', 'vswaysbufking', 'Buffalo King Megaways', 'slot', 'SL'),
(35, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40wildwest.png', 'vs40wildwest', 'Wild West Gold', 'slot', 'SL'),
(36, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20chickdrop.png', 'vs20chickdrop', 'Chicken Drop', 'slot', 'SL'),
(37, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40spartaking.png', 'vs40spartaking', 'Spartan King', 'slot', 'SL'),
(38, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysrhino.png', 'vswaysrhino', 'Great Rhino Megaways', 'slot', 'SL'),
(39, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sbxmas.png', 'vs20sbxmas', 'Sweet Bonanza Xmas', 'slot', 'SL'),
(40, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10fruity2.png', 'vs10fruity2', 'Extra Juicy', 'slot', 'SL'),
(41, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10egypt.png', 'vs10egypt', 'Ancient Egypt', 'slot', 'SL'),
(42, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5drhs.png', 'vs5drhs', 'Dragon Hot Hold and Spin', 'slot', 'SL'),
(43, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs12bbb.png', 'vs12bbb', 'Bigger Bass Bonanza', 'slot', 'SL'),
(44, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20tweethouse.png', 'vs20tweethouse', 'The Tweety House', 'slot', 'SL'),
(45, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayslions.png', 'vswayslions', '5 Lions Megaways', 'slot', 'SL'),
(46, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayssamurai.png', 'vswayssamurai', 'Rise of Samurai Megaways', 'slot', 'SL'),
(47, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50pixie.png', 'vs50pixie', 'Pixie Wings', 'slot', 'SL'),
(48, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10floatdrg.png', 'vs10floatdrg', 'Floating Dragon', 'slot', 'SL'),
(49, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20fruitsw.png', 'vs20fruitsw', 'Sweet Bonanza', 'slot', 'SL'),
(50, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20rhinoluxe.png', 'vs20rhinoluxe', 'Great Rhino Deluxe', 'slot', 'SL'),
(51, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs432congocash.png', 'vs432congocash', 'Congo Cash', 'slot', 'SL'),
(52, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysmadame.png', 'vswaysmadame', 'Madame Destiny Megaways', 'slot', 'SL'),
(53, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024temuj.png', 'vs1024temuj', 'Temujin Treasures', 'slot', 'SL'),
(54, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40pirgold.png', 'vs40pirgold', 'Pirate Gold Deluxe', 'slot', 'SL'),
(55, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25mmouse.png', 'vs25mmouse', 'Money Mouse', 'slot', 'SL'),
(56, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10threestar.png', 'vs10threestar', 'Three Star Fortune', 'slot', 'SL'),
(57, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1ball.png', 'vs1ball', 'Lucky Dragon Ball', 'slot', 'SL'),
(58, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243lionsgold.png', 'vs243lionsgold', '5 Lions', 'slot', 'SL'),
(59, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10egyptcls.png', 'vs10egyptcls', 'Ancient Egypt Classic', 'slot', 'SL'),
(60, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25davinci.png', 'vs25davinci', 'Da Vinci Treasure', 'slot', 'SL'),
(61, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs7776secrets.png', 'vs7776secrets', 'Aztec Treasure', 'slot', 'SL'),
(62, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25wolfgold.png', 'vs25wolfgold', 'Wolf Gold', 'slot', 'SL'),
(63, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50safariking.png', 'vs50safariking', 'Safari King', 'slot', 'SL'),
(64, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25peking.png', 'vs25peking', 'Peking Luck', 'slot', 'SL'),
(65, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25asgard.png', 'vs25asgard', 'Asgard', 'slot', 'SL'),
(66, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25vegas.png', 'vs25vegas', 'Vegas Nights', 'slot', 'SL'),
(67, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs75empress.png', 'vs75empress', 'Golden Beauty', 'slot', 'SL'),
(68, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25scarabqueen.png', 'vs25scarabqueen', 'John Hunter and the Tomb of the Scarab Queen', 'slot', 'SL'),
(69, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20starlight.png', 'vs20starlight', 'Starlight Princess', 'slot', 'SL'),
(70, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bookoftut.png', 'vs10bookoftut', 'John Hunter and the Book of Tut', 'slot', 'SL'),
(71, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9piggybank.png', 'vs9piggybank', 'Piggy Bank Bills', 'slot', 'SL'),
(72, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5drmystery.png', 'vs5drmystery', 'Dragon Kingdom Mystery', 'slot', 'SL'),
(73, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20eightdragons.png', 'vs20eightdragons', 'Eight Dragons', 'slot', 'SL'),
(74, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024lionsd.png', 'vs1024lionsd', '5 Lions Dance', 'slot', 'SL'),
(75, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25rio.png', 'vs25rio', 'Heart of Rio', 'slot', 'SL'),
(76, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10nudgeit.png', 'vs10nudgeit', 'Rise of Giza PowerNudge', 'slot', 'SL'),
(77, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bxmasbnza.png', 'vs10bxmasbnza', 'Christmas Big Bass Bonanza', 'slot', 'SL'),
(78, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20santawonder.png', 'vs20santawonder', 'Santa&apos;s Wonderland', 'slot', 'SL'),
(79, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20terrorv.png', 'vs20terrorv', 'Cash Elevator', 'slot', 'SL'),
(80, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bblpop.png', 'vs10bblpop', 'Bubble Pop', 'slot', 'SL'),
(81, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25btygold.png', 'vs25btygold', 'Bounty Gold', 'slot', 'SL'),
(82, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs88hockattack.png', 'vs88hockattack', 'Hockey Attackâ„¢', 'slot', 'SL'),
(83, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbbb.png', 'vswaysbbb', 'Big Bass Bonanza Megawaysâ„¢', 'slot', 'SL'),
(84, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bookfallen.png', 'vs10bookfallen', 'Book of the Fallen', 'slot', 'SL'),
(85, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40bigjuan.png', 'vs40bigjuan', 'Big Juan', 'slot', 'SL'),
(86, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bermuda.png', 'vs20bermuda', 'John Hunter and the Quest for Bermuda Riches', 'slot', 'SL'),
(87, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10starpirate.png', 'vs10starpirate', 'Star Pirates Code', 'slot', 'SL'),
(88, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswest.png', 'vswayswest', 'Mystic Chief', 'slot', 'SL'),
(89, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20daydead.png', 'vs20daydead', 'Day of Dead', 'slot', 'SL'),
(90, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20candvil.png', 'vs20candvil', 'Candy Village', 'slot', 'SL'),
(91, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20wildboost.png', 'vs20wildboost', 'Wild Booster', 'slot', 'SL'),
(92, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayshammthor.png', 'vswayshammthor', 'Power of Thor Megaways', 'slot', 'SL'),
(93, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243lions.png', 'vs243lions', '5 Lions', 'slot', 'SL'),
(94, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5super7.png', 'vs5super7', 'Super 7s', 'slot', 'SL'),
(95, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1masterjoker.png', 'vs1masterjoker', 'Master Joker', 'slot', 'SL'),
(96, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20kraken.png', 'vs20kraken', 'Release the Kraken', 'slot', 'SL'),
(97, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10firestrike.png', 'vs10firestrike', 'Fire Strike', 'slot', 'SL'),
(98, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243fortune.png', 'vs243fortune', 'Caishen&apos;s Gold', 'slot', 'SL'),
(99, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs4096mystery.png', 'vs4096mystery', 'Mysterious', 'slot', 'SL'),
(100, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20aladdinsorc.png', 'vs20aladdinsorc', 'Aladdin and the Sorcerrer', 'slot', 'SL'),
(101, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243fortseren.png', 'vs243fortseren', 'Greek Gods', 'slot', 'SL'),
(102, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25chilli.png', 'vs25chilli', 'Chilli Heat', 'slot', 'SL'),
(103, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs8magicjourn.png', 'vs8magicjourn', 'Magic Journey', 'slot', 'SL'),
(104, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs25pantherqueen.png', 'vs25pantherqueen', 'Panther Queen', 'slot', 'SL'),
(105, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20leprexmas.png', 'vs20leprexmas', 'Leprechaun Carol', 'slot', 'SL'),
(106, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs7pigs.png', 'vs7pigs', '7 Piggies', 'slot', 'SL'),
(107, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243caishien.png', 'vs243caishien', 'Caishen&apos;s Cash', 'slot', 'SL'),
(108, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5joker.png', 'vs5joker', 'Joker&apos;s Jewels', 'slot', 'SL'),
(109, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25gladiator.png', 'vs25gladiator', 'Wild Gladiator', 'slot', 'SL'),
(110, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25goldpig.png', 'vs25goldpig', 'Golden Pig', 'slot', 'SL'),
(111, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25goldrush.png', 'vs25goldrush', 'Gold Rush', 'slot', 'SL'),
(112, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25dragonkingdom.png', 'vs25dragonkingdom', 'Dragon Kingdom', 'slot', 'SL'),
(113, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25kingdoms.png', 'vs25kingdoms', '3 Kingdoms - Battle of Red Cliffs', 'slot', 'SL'),
(114, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1dragon8.png', 'vs1dragon8', '888 Dragons', 'slot', 'SL'),
(115, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5aztecgems.png', 'vs5aztecgems', 'Aztec Gems', 'slot', 'SL'),
(116, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20hercpeg.png', 'vs20hercpeg', 'Hercules and Pegasus', 'slot', 'SL'),
(117, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs7fire88.png', 'vs7fire88', 'Fire 88', 'slot', 'SL'),
(118, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20honey.png', 'vs20honey', 'Honey Honey Honey', 'slot', 'SL'),
(119, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25safari.png', 'vs25safari', 'Hot Safari', 'slot', 'SL'),
(120, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25journey.png', 'vs25journey', 'Journey to the West', 'slot', 'SL'),
(121, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20chicken.png', 'vs20chicken', 'The Great Chicken Escape', 'slot', 'SL'),
(122, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1fortunetree.png', 'vs1fortunetree', 'Tree of Riches', 'slot', 'SL'),
(123, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20wildpix.png', 'vs20wildpix', 'Wild Pixies', 'slot', 'SL'),
(124, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs15fairytale.png', 'vs15fairytale', 'Fairytale Fortune', 'slot', 'SL'),
(125, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20santa.png', 'vs20santa', 'Santa', 'slot', 'SL'),
(126, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10vampwolf.png', 'vs10vampwolf', 'Vampires vs Wolves', 'slot', 'SL'),
(127, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50aladdin.png', 'vs50aladdin', '3 Genie Wishes', 'slot', 'SL'),
(128, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50hercules.png', 'vs50hercules', 'Hercules Son of Zeus', 'slot', 'SL'),
(129, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs7776aztec.png', 'vs7776aztec', 'Aztec Bonanza', 'slot', 'SL'),
(130, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5trdragons.png', 'vs5trdragons', 'Triple Dragons', 'slot', 'SL'),
(131, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40madwheel.png', 'vs40madwheel', 'The Wild Machine', 'slot', 'SL'),
(132, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25newyear.png', 'vs25newyear', 'Lucky New Year', 'slot', 'SL'),
(133, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40frrainbow.png', 'vs40frrainbow', 'Fruit Rainbow', 'slot', 'SL'),
(134, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50kingkong.png', 'vs50kingkong', 'Mighty Kong', 'slot', 'SL'),
(135, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20godiva.png', 'vs20godiva', 'Lady Godiva', 'slot', 'SL'),
(136, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9madmonkey.png', 'vs9madmonkey', 'Monkey Madness', 'slot', 'SL'),
(137, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1tigers.png', 'vs1tigers', 'Triple Tigers', 'slot', 'SL'),
(138, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9chen.png', 'vs9chen', 'Master Chen&apos;s Fortune', 'slot', 'SL'),
(139, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5hotburn.png', 'vs5hotburn', 'Hot to burn', 'slot', 'SL'),
(140, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25dwarves_new.png', 'vs25dwarves_new', 'Dwarven Gold Deluxe', 'slot', 'SL'),
(141, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024butterfly.png', 'vs1024butterfly', 'Jade Butterfly', 'slot', 'SL'),
(142, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25sea.png', 'vs25sea', 'Great Reef', 'slot', 'SL'),
(143, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20leprechaun.png', 'vs20leprechaun', 'Leprechaun Song', 'slot', 'SL'),
(144, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs7monkeys.png', 'vs7monkeys', '7 Monkeys', 'slot', 'SL'),
(145, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50chinesecharms.png', 'vs50chinesecharms', 'Lucky Dragons', 'slot', 'SL'),
(146, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs18mashang.png', 'vs18mashang', 'Treasure Horse', 'slot', 'SL'),
(147, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5spjoker.png', 'vs5spjoker', 'Super Joker', 'slot', 'SL'),
(148, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20egypttrs.png', 'vs20egypttrs', 'Egyptian Fortunes', 'slot', 'SL'),
(149, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25queenofgold.png', 'vs25queenofgold', 'Queen of Gold', 'slot', 'SL'),
(150, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9hotroll.png', 'vs9hotroll', 'Hot Chilli', 'slot', 'SL'),
(151, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs4096jurassic.png', 'vs4096jurassic', 'Jurassic Giants', 'slot', 'SL'),
(152, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs3train.png', 'vs3train', 'Gold Train', 'slot', 'SL'),
(153, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs40beowulf.png', 'vs40beowulf', 'Beowulf', 'slot', 'SL'),
(154, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs1024atlantis.png', 'vs1024atlantis', 'Queen of Atlantis', 'slot', 'SL'),
(155, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bl.png', 'vs20bl', 'Busy Bees', 'slot', 'SL'),
(156, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs25champ.png', 'vs25champ', 'The Champions', 'slot', 'SL'),
(157, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs13g.png', 'vs13g', 'Devil&apos;s 13', 'slot', 'SL'),
(158, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs243crystalcave.png', 'vs243crystalcave', 'Magic Crystals', 'slot', 'SL'),
(159, 'PRAGMATIC', 'https://solawins-sg0.pragmaticplay.net/game_pic/rec/325/vs5trjokers.png', 'vs5trjokers', 'Triple Jokers', 'slot', 'SL'),
(160, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1money.png', 'vs1money', 'Money Money Money', 'slot', 'SL'),
(161, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs75bronco.png', 'vs75bronco', 'Bronco Spirit', 'slot', 'SL'),
(162, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1600drago.png', 'vs1600drago', 'Drago - Jewels of Fortune', 'slot', 'SL'),
(163, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1fufufu.png', 'vs1fufufu', 'Fu Fu Fu', 'slot', 'SL'),
(164, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40streetracer.png', 'vs40streetracer', 'Street Racer', 'slot', 'SL'),
(165, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9aztecgemsdx.png', 'vs9aztecgemsdx', 'Aztec Gems Deluxe', 'slot', 'SL'),
(166, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gorilla.png', 'vs20gorilla', 'Jungle Gorilla', 'slot', 'SL'),
(167, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswerewolf.png', 'vswayswerewolf', 'Curse of the Werewolf Megaways', 'slot', 'SL'),
(168, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayshive.png', 'vswayshive', 'Star Bounty', 'slot', 'SL'),
(169, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25samurai.png', 'vs25samurai', 'Rise of Samurai', 'slot', 'SL'),
(170, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25walker.png', 'vs25walker', 'Wild Walker', 'slot', 'SL'),
(171, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20goldfever.png', 'vs20goldfever', 'Gems Bonanza', 'slot', 'SL'),
(172, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25bkofkngdm.png', 'vs25bkofkngdm', 'Book of Kingdoms', 'slot', 'SL'),
(173, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10goldfish.png', 'vs10goldfish', 'Fishin Reels', 'slot', 'SL'),
(174, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024dtiger.png', 'vs1024dtiger', 'The Dragon Tiger', 'slot', 'SL'),
(175, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20eking.png', 'vs20eking', 'Emerald King', 'slot', 'SL'),
(176, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20xmascarol.png', 'vs20xmascarol', 'Christmas Carol Megaways', 'slot', 'SL'),
(177, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10mayangods.png', 'vs10mayangods', 'John Hunter and the Mayan Gods', 'slot', 'SL'),
(178, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bonzgold.png', 'vs20bonzgold', 'Bonanza Gold', 'slot', 'SL'),
(179, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40voodoo.png', 'vs40voodoo', 'Voodoo Magic', 'slot', 'SL'),
(180, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25gldox.png', 'vs25gldox', 'Golden Ox', 'slot', 'SL'),
(181, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10wildtut.png', 'vs10wildtut', 'Mysterious Egypt', 'slot', 'SL'),
(182, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20ekingrr.png', 'vs20ekingrr', 'Emerald King Rainbow Road', 'slot', 'SL'),
(183, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10eyestorm.png', 'vs10eyestorm', 'Eye of the Storm', 'slot', 'SL'),
(184, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs117649starz.png', 'vs117649starz', 'Starz Megaways', 'slot', 'SL'),
(185, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10amm.png', 'vs10amm', 'The Amazing Money Machine', 'slot', 'SL'),
(186, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20magicpot.png', 'vs20magicpot', 'The Magic Cauldron - Enchanted Brew', 'slot', 'SL'),
(187, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysyumyum.png', 'vswaysyumyum', 'Yum Yum Powerways', 'slot', 'SL'),
(188, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayselements.png', 'vswayselements', 'Elemental Gems Megaways', 'slot', 'SL'),
(189, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayschilheat.png', 'vswayschilheat', 'Chilli Heat Megaways', 'slot', 'SL'),
(190, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10luckcharm.png', 'vs10luckcharm', 'Lucky Grace And Charm', 'slot', 'SL'),
(191, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysaztecking.png', 'vswaysaztecking', 'Aztec King Megaways', 'slot', 'SL'),
(192, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20phoenixf.png', 'vs20phoenixf', 'Phoenix Forge', 'slot', 'SL'),
(193, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs576hokkwolf.png', 'vs576hokkwolf', 'Hokkaido Wolf', 'slot', 'SL'),
(194, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20trsbox.png', 'vs20trsbox', 'Treasure Wild', 'slot', 'SL'),
(195, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243chargebull.png', 'vs243chargebull', 'Raging Bull', 'slot', 'SL'),
(196, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbankbonz.png', 'vswaysbankbonz', 'Cash Bonanza', 'slot', 'SL'),
(197, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20pbonanza.png', 'vs20pbonanza', 'Pyramid Bonanza', 'slot', 'SL'),
(198, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243empcaishen.png', 'vs243empcaishen', 'Emperor Caishen', 'slot', 'SL'),
(199, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25tigeryear.png', 'vs25tigeryear', 'New Year Tiger Treasures â„¢', 'slot', 'SL'),
(200, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20amuleteg.png', 'vs20amuleteg', 'Fortune of Gizaâ„¢', 'slot', 'SL'),
(201, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10runes.png', 'vs10runes', 'Gates of Valhallaâ„¢', 'slot', 'SL'),
(202, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25goldparty.png', 'vs25goldparty', 'Gold PartyÂ®', 'slot', 'SL'),
(203, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysxjuicy.png', 'vswaysxjuicy', 'Extra Juicy Megawaysâ„¢', 'slot', 'SL'),
(204, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40wanderw.png', 'vs40wanderw', 'Wild Depthsâ„¢', 'slot', 'SL'),
(205, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs4096magician.png', 'vs4096magician', 'Magician&apos;s Secretsâ„¢', 'slot', 'SL'),
(206, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20smugcove.png', 'vs20smugcove', 'Smugglers Coveâ„¢', 'slot', 'SL'),
(207, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayscryscav.png', 'vswayscryscav', 'Crystal Caverns Megawaysâ„¢', 'slot', 'SL'),
(208, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20superx.png', 'vs20superx', 'Super Xâ„¢', 'slot', 'SL'),
(209, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20rockvegas.png', 'vs20rockvegas', 'Rock Vegas Mega Hold & Spin', 'slot', 'SL'),
(210, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25copsrobbers.png', 'vs25copsrobbers', 'Cash Patrol', 'slot', 'SL'),
(211, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20colcashzone.png', 'vs20colcashzone', 'Colossal Cash Zone', 'slot', 'SL'),
(212, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20ultim5.png', 'vs20ultim5', 'The Ultimate 5', 'slot', 'SL'),
(213, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bchprty.png', 'vs20bchprty', 'Wild Beach Party', 'slot', 'SL'),
(214, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bookazteck.png', 'vs10bookazteck', 'Book of Aztec King', 'slot', 'SL'),
(215, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10snakeladd.png', 'vs10snakeladd', 'Snakes and Ladders Megadice', 'slot', 'SL'),
(216, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50mightra.png', 'vs50mightra', 'Might of Ra', 'slot', 'SL'),
(217, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25bullfiesta.png', 'vs25bullfiesta', 'Bull Fiesta', 'slot', 'SL'),
(218, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20rainbowg.png', 'vs20rainbowg', 'Rainbow Gold', 'slot', 'SL'),
(219, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10tictac.png', 'vs10tictac', 'Tic Tac Take', 'slot', 'SL'),
(220, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243discolady.png', 'vs243discolady', 'Disco Lady', 'slot', 'SL'),
(221, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243queenie.png', 'vs243queenie', 'Queenie', 'slot', 'SL'),
(222, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20farmfest.png', 'vs20farmfest', 'Barn Festival', 'slot', 'SL'),
(223, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10chkchase.png', 'vs10chkchase', 'Chicken Chase', 'slot', 'SL'),
(224, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswildwest.png', 'vswayswildwest', 'Wild West Gold Megaways', 'slot', 'SL'),
(225, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mustanggld2.png', 'vs20mustanggld2', 'Clover Gold', 'slot', 'SL'),
(226, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20drtgold.png', 'vs20drtgold', 'Drill That Gold', 'slot', 'SL'),
(227, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10spiritadv.png', 'vs10spiritadv', 'Spirit of Adventure', 'slot', 'SL'),
(228, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10firestrike2.png', 'vs10firestrike2', 'Fire Strike 2', 'slot', 'SL'),
(229, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40cleoeye.png', 'vs40cleoeye', 'Eye of Cleopatra', 'slot', 'SL'),
(230, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gobnudge.png', 'vs20gobnudge', 'Goblin Heist Powernudge', 'slot', 'SL'),
(231, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20stickysymbol.png', 'vs20stickysymbol', 'The Great Stick-up', 'slot', 'SL'),
(232, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayszombcarn.png', 'vswayszombcarn', 'Zombie Carnival', 'slot', 'SL'),
(233, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50northgard.png', 'vs50northgard', 'North Guardians', 'slot', 'SL'),
(234, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sugarrush.png', 'vs20sugarrush', 'Sugar Rush', 'slot', 'SL'),
(235, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20cleocatra.png', 'vs20cleocatra', 'Cleocatra', 'slot', 'SL'),
(236, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5littlegem.png', 'vs5littlegem', 'Little Gem Hold and Spin', 'slot', 'SL'),
(237, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10egrich.png', 'vs10egrich', 'Queen of Gods', 'slot', 'SL'),
(238, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243koipond.png', 'vs243koipond', 'Koi Pond', 'slot', 'SL'),
(239, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40samurai3.png', 'vs40samurai3', 'Rise of Samurai 3', 'slot', 'SL'),
(240, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40cosmiccash.png', 'vs40cosmiccash', 'Cosmic Cash', 'slot', 'SL'),
(241, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25bomb.png', 'vs25bomb', 'Bomb Bonanza', 'slot', 'SL'),
(242, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024mahjpanda.png', 'vs1024mahjpanda', 'Mahjong Panda', 'slot', 'SL'),
(243, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10coffee.png', 'vs10coffee', 'Coffee Wild', 'slot', 'SL'),
(244, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs100sh.png', 'vs100sh', 'Shining Hot 100', 'slot', 'SL'),
(245, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sh.png', 'vs20sh', 'Shining Hot 20', 'slot', 'SL'),
(246, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40sh.png', 'vs40sh', 'Shining Hot 40', 'slot', 'SL'),
(247, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5sh.png', 'vs5sh', 'Shining Hot 5', 'slot', 'SL'),
(248, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysjkrdrop.png', 'vswaysjkrdrop', 'Tropical Tiki', 'slot', 'SL'),
(249, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243ckemp.png', 'vs243ckemp', 'Cheeky Emperor', 'slot', 'SL'),
(250, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40hotburnx.png', 'vs40hotburnx', 'Hot To Burn Extreme', 'slot', 'SL'),
(251, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024gmayhem.png', 'vs1024gmayhem', 'Gorilla Mayhem', 'slot', 'SL'),
(252, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20octobeer.png', 'vs20octobeer', 'Octobeer Fortunes', 'slot', 'SL'),
(253, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10txbigbass.png', 'vs10txbigbass', 'Big Bass Splash', 'slot', 'SL'),
(254, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs100firehot.png', 'vs100firehot', 'Fire Hot 100', 'slot', 'SL'),
(255, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20fh.png', 'vs20fh', 'Fire Hot 20', 'slot', 'SL'),
(256, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40firehot.png', 'vs40firehot', 'Fire Hot 40', 'slot', 'SL'),
(257, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5firehot.png', 'vs5firehot', 'Fire Hot 5', 'slot', 'SL'),
(258, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20wolfie.png', 'vs20wolfie', 'Greedy Wolf', 'slot', 'SL'),
(259, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20underground.png', 'vs20underground', 'Down the Rails', 'slot', 'SL'),
(260, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10mmm.png', 'vs10mmm', 'Magic Money Maze', 'slot', 'SL'),
(261, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfltdrg.png', 'vswaysfltdrg', 'Floating Dragon Hold & Spin Megaways', 'slot', 'SL'),
(262, 'PRAGMATIC', 'https://api-sg57.ppgames.net/game_pic/rec/325/vs20wildman.png', 'vs20wildman', 'Wildman Super Bonanza', 'slot', 'SL'),
(263, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20trswild2.png', 'vs20trswild2', 'Black Bull', 'slot', 'SL'),
(264, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysstrwild.png', 'vswaysstrwild', 'Candy Stars', 'slot', 'SL'),
(265, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10crownfire.png', 'vs10crownfire', 'Crown of Fire', 'slot', 'SL'),
(266, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20muertos.png', 'vs20muertos', 'Muertos Multiplier Megaways', 'slot', 'SL'),
(267, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayslofhero.png', 'vswayslofhero', 'Legend of Heroes', 'slot', 'SL'),
(268, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5strh.png', 'vs5strh', 'Striking Hot 5', 'slot', 'SL'),
(269, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10snakeeyes.png', 'vs10snakeeyes', 'Snakes & Ladders - Snake Eyes', 'slot', 'SL'),
(270, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbook.png', 'vswaysbook', 'Book of Golden Sands', 'slot', 'SL'),
(271, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mparty.png', 'vs20mparty', 'Wild Hop and Drop', 'slot', 'SL'),
(272, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20swordofares.png', 'vs20swordofares', 'Sword of Ares', 'slot', 'SL'),
(273, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfrywld.png', 'vswaysfrywld', 'Spin & Score Megaways', 'slot', 'SL'),
(274, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10tut.png', 'vs10tut', 'Book of Tut Respin', 'slot', 'SL'),
(275, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20porbs.png', 'vs20porbs', 'Santa&apos;s Great Gifts', 'slot', 'SL'),
(276, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs12bbbxmas.png', 'vs12bbbxmas', 'Bigger Bass Blizzaro', 'slot', 'SL'),
(277, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20asgard.png', 'vs20asgard', 'Kingdom of Asgardâ„¢', 'slot', 'SL'),
(278, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25kfruit.png', 'vs25kfruit', 'Aztec Blaze', 'slot', 'SL'),
(279, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20kraken2.png', 'vs20kraken2', 'Release the Kraken 2â„¢', 'slot', 'SL'),
(280, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysconcoll.png', 'vswaysconcoll', 'Sweet PowerNudgeâ„¢', 'slot', 'SL'),
(281, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20schristmas.png', 'vs20schristmas', 'Starlight Chrismas', 'slot', 'SL'),
(282, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20theights.png', 'vs20theights', 'Towering Fortunesâ„¢', 'slot', 'SL'),
(283, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gatotgates.png', 'vs20gatotgates', 'Gates of Gatotkacaâ„¢', 'slot', 'SL'),
(284, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20lcount.png', 'vs20lcount', 'Gems of Serengetiâ„¢', 'slot', 'SL'),
(285, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mtreasure.png', 'vs20mtreasure', 'Pirate Golden Ageâ„¢', 'slot', 'SL'),
(286, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sparta.png', 'vs20sparta', 'Shield of Sparta', 'slot', 'SL'),
(287, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbkir.png', 'vs10bbkir', 'Big Bass Bonanza Keeping it Reel', 'slot', 'SL'),
(288, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysluckyfish.png', 'vswaysluckyfish', 'Lucky Fishing Megawaysâ„¢', 'slot', 'SL'),
(289, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysrabbits.png', 'vswaysrabbits', '5 Rabbits Megawaysâ„¢', 'slot', 'SL'),
(290, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20drgbless.png', 'vs20drgbless', 'Dragon Hero', 'slot', 'SL'),
(291, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayspizza.png', 'vswayspizza', 'Pizza Pizza Pizza', 'slot', 'SL'),
(292, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25rlbank.png', 'vs25rlbank', 'Reel Banksâ„¢', 'slot', 'SL'),
(293, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20aztecgates.png', 'vs20aztecgates', 'Gates of Aztecâ„¢', 'slot', 'SL'),
(294, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20dugems.png', 'vs20dugems', 'Hot Pepperâ„¢\r\n', 'slot', 'SL'),
(295, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20clspwrndg.png', 'vs20clspwrndg', 'Sweet PowerNudge', 'slot', 'SL'),
(296, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfuryodin.png', 'vswaysfuryodin', 'Fury of Odin Megawaysâ„¢', 'slot', 'SL'),
(297, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20ltng.png', 'vs20ltng', 'Pinup Girls', 'slot', 'SL'),
(298, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs12tropicana.png', 'vs12tropicana', 'Club Tropicana', 'slot', 'SL'),
(299, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gatotfury.png', 'vs20gatotfury', 'Gatot Kaca&apos;s Fury', 'slot', 'SL'),
(300, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20superlanche.png', 'vs20superlanche', 'Monster Superlanche', 'slot', 'SL'),
(301, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25archer.png', 'vs25archer', 'Fire Archer', 'slot', 'SL'),
(302, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25spgldways.png', 'vs25spgldways', 'Secret City Gold', 'slot', 'SL'),
(303, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswwhex.png', 'vswayswwhex', 'Wild Wild Bananas', 'slot', 'SL'),
(304, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mochimon.png', 'vs20mochimon', 'Mochimon', 'slot', 'SL'),
(305, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20pistols.png', 'vs20pistols', 'Wild West Duels', 'slot', 'SL'),
(306, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysmorient.png', 'vswaysmorient', 'Mystery of the Orient', 'slot', 'SL'),
(307, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10powerlines.png', 'vs10powerlines', 'Peak Power', 'slot', 'SL'),
(308, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20goldclust.png', 'vs20goldclust', 'Rabbit Garden', 'slot', 'SL'),
(309, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10fisheye.png', 'vs10fisheye', 'Fish Eye', 'slot', 'SL'),
(310, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20doghousemh.png', 'vs20doghousemh', 'The Dog House Multihold', 'slot', 'SL'),
(311, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mammoth.png', 'vs20mammoth', 'Mammoth Gold Megaways', 'slot', 'SL'),
(312, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswwriches.png', 'vswayswwriches', 'Wild Wild Riches Megaways', 'slot', 'SL'),
(313, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20framazon.png', 'vs20framazon', 'Fruits of the Amazonâ„¢', 'slot', 'SL'),
(314, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sknights.png', 'vs20sknights', 'The Knight Kingâ„¢', 'slot', 'SL'),
(315, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbhas.png', 'vs10bbhas', 'Big Bass - Hold & Spinnerâ„¢', 'slot', 'SL'),
(316, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysredqueen.png', 'vswaysredqueen', 'The Red Queenâ„¢', 'slot', 'SL'),
(317, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysmonkey.png', 'vswaysmonkey', '3 Dancing Monkeys', 'slot', 'SL'),
(318, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20hotzone.png', 'vs20hotzone', 'African Elephant', 'slot', 'SL'),
(319, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysrsm.png', 'vswaysrsm', 'Wild Celebrity Bus Megaways', 'slot', 'SL'),
(320, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10gizagods.png', 'vs10gizagods', 'Gods of Giza', 'slot', 'SL'),
(321, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024moonsh.png', 'vs1024moonsh', 'Moonshot', 'slot', 'SL'),
(322, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10jnmntzma.png', 'vs10jnmntzma', 'Jane Hunter and the Mask of Montezuma', 'slot', 'SL'),
(323, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysultrcoin.png', 'vswaysultrcoin', '	Cowboy Coins', 'slot', 'SL'),
(324, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mvwild.png', 'vs20mvwild', 'Jasmine Dreams', 'slot', 'SL'),
(325, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10kingofdth.png', 'vs10kingofdth', 'Kingdom of the Dead', 'slot', 'SL'),
(326, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayseternity.png', 'vswayseternity', 'Diamonds of Egypt', 'slot', 'SL'),
(327, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25holiday.png', 'vs25holiday', 'Holiday Ride', 'slot', 'SL'),
(328, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20excalibur.png', 'vs20excalibur', 'Excalibur Unleashed', 'slot', 'SL'),
(329, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20stickywild.png', 'vs20stickywild', 'Wild Bison Charge', 'slot', 'SL'),
(330, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25spotz.png', 'vs25spotz', 'Knight Hot Spotz', 'slot', 'SL'),
(331, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs15godsofwar.png', 'vs15godsofwar', 'Zeus vs Hades - Gods of War', 'slot', 'SL'),
(332, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20clustwild.png', 'vs20clustwild', 'Sticky Bees', 'slot', 'SL'),
(333, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10fdrasbf.png', 'vs10fdrasbf', 'Floating Dragon - Dragon Boat Festival', 'slot', 'SL'),
(334, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs4096robber.png', 'vs4096robber', 'Robber Strike', 'slot', 'SL'),
(335, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfrbugs.png', 'vswaysfrbugs', 'Frogs & Bugs', 'slot', 'SL'),
(336, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20lampinf.png', 'vs20lampinf', 'Lamp Of Infinity', 'slot', 'SL'),
(337, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20jewelparty.png', 'vs20jewelparty', 'Jewel Rush', 'slot', 'SL'),
(338, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs9outlaw.png', 'vs9outlaw', 'Pirates Pub', 'slot', 'SL'),
(339, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20beefed.png', 'vs20beefed', 'Fat Panda', 'slot', 'SL'),
(340, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20procount.png', 'vs20procount', 'Wisdom of Athena', 'slot', 'SL'),
(341, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbextreme.png', 'vs10bbextreme', 'Big Bass Amazon Xtreme', 'slot', 'SL'),
(342, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20hstgldngt.png', 'vs20hstgldngt', 'Heist for the Golden Nuggets', 'slot', 'SL'),
(343, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243nudge4gold.png', 'vs243nudge4gold', 'Hellvis Wild', 'slot', 'SL'),
(344, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25jokrace.png', 'vs25jokrace', 'Joker Race', 'slot', 'SL'),
(345, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20cashmachine.png', 'vs20cashmachine', 'Cash Box', 'slot', 'SL'),
(346, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50jucier.png', 'vs50jucier', 'Sky Bounty', 'slot', 'SL'),
(347, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayspowzeus.png', 'vswayspowzeus', 'Power of Merlin Megaways', 'slot', 'SL'),
(348, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20splmystery.png', 'vs20splmystery', 'Spellbinding Mystery', 'slot', 'SL'),
(349, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20starlightx.png', 'vs20starlightx', 'Starlight Princess 1000', 'slot', 'SL'),
(350, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20wildparty.png', 'vs20wildparty', '3 Buzzing Wilds', 'slot', 'SL'),
(351, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50dmdcascade.png', 'vs50dmdcascade', 'Diamond Cascade', 'slot', 'SL'),
(352, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20supermania.png', 'vs20supermania', 'Supermania', 'slot', 'SL'),
(353, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20lobcrab.png', 'vs20lobcrab', 'Lobster Bob&apos;s Crazy Crab Shack', 'slot', 'SL'),
(354, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/cs5triple8gold.png', 'cs5triple8gold', '888 Gold', 'slot', 'SL'),
(355, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/sc7piggiesai.png', 'sc7piggiesai', '7 Piggies 25.000', 'slot', 'SL'),
(356, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scpandai.png', 'scpandai', 'Panda Gold 50.000', 'slot', 'SL'),
(357, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scsafariai.png', 'scsafariai', 'Hot Safari 75.000', 'slot', 'SL'),
(358, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scqogai.png', 'scqogai', 'Queen of Gold 100.000', 'slot', 'SL'),
(359, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scdiamondai.png', 'scdiamondai', 'Diamond Strike 250.000', 'slot', 'SL'),
(360, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scgoldrushai.png', 'scgoldrushai', 'Gold Rush 500.000', 'slot', 'SL'),
(361, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/scwolfgoldai.png', 'scwolfgoldai', 'Wolf Gold 1.000.000', 'slot', 'SL'),
(362, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10trail.png', 'vs10trail', 'Mustang Trail', 'slot', 'SL'),
(363, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysrockblst.png', 'vswaysrockblst', 'Rocket Blast Megaways', 'slot', 'SL'),
(364, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20piggybank.png', 'vs20piggybank', 'Piggy Bankers', 'slot', 'SL'),
(365, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20lvlup.png', 'vs20lvlup', 'Pub Kings', 'slot', 'SL'),
(366, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20forge.png', 'vs20forge', 'Forge of Olympus', 'slot', 'SL'),
(367, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024mahjwins.png', 'vs1024mahjwins', 'Mahjong Wins', 'slot', 'SL'),
(368, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20earthquake.png', 'vs20earthquake', 'Cyclops Smash', 'slot', 'SL'),
(369, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20saiman.png', 'vs20saiman', 'Saiyan Mania', 'slot', 'SL'),
(370, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbbhas.png', 'vswaysbbhas', 'Big Bass Hold & Spinner Megaways', 'slot', 'SL'),
(371, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs20yisunshin.png', 'vs20yisunshin', 'Yi Sun Shin', 'slot', 'SL'),
(372, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysincwnd.png', 'vswaysincwnd', 'Gold Oasis', 'slot', 'SL'),
(373, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysftropics.png', 'vswaysftropics', 'Frozen Tropics', 'slot', 'SL'),
(374, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10gdchalleng.png', 'vs10gdchalleng', '8 Golden Dragon Challenge', 'slot', 'SL'),
(375, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaystut.png', 'vswaystut', 'Book of Tut Megaways', 'slot', 'SL'),
(376, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gravity.png', 'vs20gravity', 'Gravity Bonanza', 'slot', 'SL'),
(377, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40infwild.png', 'vs40infwild', 'Infective Wild', 'slot', 'SL'),
(378, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20candyblitz.png', 'vs20candyblitz', 'Candy Blitz', 'slot', 'SL'),
(379, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysstrlght.png', 'vswaysstrlght', 'Fortunes of Aztec', 'slot', 'SL');
INSERT INTO `tb_gamelist` (`cuid`, `provider`, `image`, `gameid`, `gamename`, `category`, `datatype`) VALUES
(380, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20maskgame.png', 'vs20maskgame', 'Cash Chips', 'slot', 'SL'),
(381, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5gemstone.png', 'vs5gemstone', 'Gemstone', 'slot', 'SL'),
(382, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysraghex.png', 'vswaysraghex', 'Tundra&apos;s Fortune', 'slot', 'SL'),
(383, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40rainbowr.png', 'vs40rainbowr', 'Rainbow Reels', 'slot', 'SL'),
(384, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bnnzdice.png', 'vs20bnnzdice', 'Sweet Bonanza Dice', 'slot', 'SL'),
(385, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs10bhallbnza.png', 'vs10bhallbnza', 'Big Bass Halloween', 'slot', 'SL'),
(386, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20dhcluster.png', 'vs20dhcluster', 'Twilight Princess', 'slot', 'SL'),
(387, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs40demonpots.png', 'vs40demonpots', 'Demon Pots ', 'slot', 'SL'),
(388, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs243goldfor.png', 'vs243goldfor', '888 Bonanza', 'slot', 'SL'),
(389, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysmoneyman.png', 'vswaysmoneyman', 'The Money Men Megaways', 'slot', 'SL'),
(390, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20olympgrace.png', 'vs20olympgrace', 'Grace of Ebisu', 'slot', 'SL'),
(391, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20rujakbnz.png', 'vs20rujakbnz', 'Rujak Bonanza', 'slot', 'SL'),
(392, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sugarcoins.png', 'vs20sugarcoins', 'Viking Forge', 'slot', 'SL'),
(393, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sugarnudge.png', 'vs20sugarnudge', 'Sugar Supreme Powernudge', 'slot', 'SL'),
(394, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayscfglory.png', 'vswayscfglory', 'Chase For Glory', 'slot', 'SL'),
(395, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5jokerdice.png', 'vs5jokerdice', 'Joker&apos;s Jewel Dice', 'slot', 'SL'),
(396, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaystimber.png', 'vswaystimber', 'Timber Stacks', 'slot', 'SL'),
(397, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbsplxmas.png', 'vs10bbsplxmas', 'Big Bass Christmas Bash', 'slot', 'SL'),
(398, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mahjxbnz.png', 'vs20mahjxbnz', 'Mahjong X', 'slot', 'SL'),
(399, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20nilefort.png', 'vs20nilefort', 'Nile Fortune', 'slot', 'SL'),
(400, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs20sugrux.png', 'vs20sugrux', 'Sugar Rush Xmas', 'slot', 'SL'),
(401, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayscharms.png', 'vswayscharms', '5 Frozen Charms Megaways', 'slot', 'SL'),
(402, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10ddcbells.png', 'vs10ddcbells', 'Ding Dong Christmas Bells', 'slot', 'SL'),
(403, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20dhdice.png', 'vs20dhdice', 'The Dog House Dice Show', 'slot', 'SL'),
(404, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs20cjcluster.png', 'vs20cjcluster', 'Candy Jar Clusters', 'slot', 'SL'),
(405, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vswaysseastory.png', 'vswaysseastory', 'Sea Fantasy', 'slot', 'SL'),
(406, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysstampede.png', 'vswaysstampede', 'Fire Stampede', 'slot', 'SL'),
(407, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20olympx.png', 'vs20olympx', 'Gates of Olympus 1000', 'slot', 'SL'),
(408, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayswildgang.png', 'vswayswildgang', 'The Wild Gang', 'slot', 'SL'),
(409, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs50jfmulthold.png', 'vs50jfmulthold', 'Juicy Fruits Multihold', 'slot', 'SL'),
(410, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfltdrgny.png', 'vswaysfltdrgny', 'Floating Dragon New Year Festival Ultra Megaways Hold & Spin', 'slot', 'SL'),
(411, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs20laughluck.png', 'vs20laughluck', 'Happy Fortune', 'slot', 'SL'),
(412, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20yotdk.png', 'vs20yotdk', 'Year Of The Dragon King', 'slot', 'SL'),
(413, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10luckfort.png', 'vs10luckfort', 'Good Luck & Good Fortune', 'slot', 'SL'),
(414, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysexpandng.png', 'vswaysexpandng', 'Castle of Fire', 'slot', 'SL'),
(415, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs243fdragon.png', 'vs243fdragon', 'Fortune Dragon', 'slot', 'SL'),
(416, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20bigdawgs.png', 'vs20bigdawgs', 'The Big Dawgs', 'slot', 'SL'),
(417, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mergedwndw.png', 'vs20mergedwndw', 'Blade & Fangs', 'slot', 'SL'),
(418, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20loksriches.png', 'vs20loksriches', 'Loki&apos;s Riches', 'slot', 'SL'),
(419, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024mjwinbns.png', 'vs1024mjwinbns', 'Mahjong Wins Bonus', 'slot', 'SL'),
(420, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20treesot.png', 'vs20treesot', 'Trees of Treasure', 'slot', 'SL'),
(421, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysfirewmw.png', 'vswaysfirewmw', 'Blazing Wilds Megaways', 'slot', 'SL'),
(422, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs1024fortune.png', 'vs1024fortune', 'Fortune Ace', 'slot', 'SL'),
(423, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs25lagoon.png', 'vs25lagoon', 'Great Lagoon', 'slot', 'SL'),
(424, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbfloats.png', 'vs10bbfloats', 'Big Bass Floats my Boat', 'slot', 'SL'),
(425, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysalterego.png', 'vswaysalterego', 'The Alter Ego', 'slot', 'SL'),
(426, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs5balidragon.png', 'vs5balidragon', 'Bali Dragon', 'slot', 'SL'),
(427, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20multiup.png', 'vs20multiup', 'Wheel O&apos;Gold', 'slot', 'SL'),
(428, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysmegareel.png', 'vswaysmegareel', 'Pompeii Megareels Megaways', 'slot', 'SL'),
(429, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20mmmelon.png', 'vs20mmmelon', 'Mighty Munching Melons', 'slot', 'SL'),
(430, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10strawberry.png', 'vs10strawberry', 'Strawberry Cocktail', 'slot', 'SL'),
(431, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs15seoultrain.png', 'vs15seoultrain', 'Train to Seoul', 'slot', 'SL'),
(432, 'PRAGMATIC', 'https://static.uniongame.org/public/images/pragmatic/vs20ninjapower.png', 'vs20ninjapower', 'Power of Ninja', 'slot', 'SL'),
(433, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20olympdice.png', 'vs20olympdice', 'Gates of Olympus Dice', 'slot', 'SL'),
(434, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20clustext.png', 'vs20clustext', 'Gears of Horus', 'slot', 'SL'),
(435, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswayscheist.png', 'vswayscheist', 'Casino Heist Megaways', 'slot', 'SL'),
(436, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20gatotx.png', 'vs20gatotx', 'Gates of Gatot Kaca 1000', 'slot', 'SL'),
(437, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vswaysbewaretd.png', 'vswaysbewaretd', 'Beware The Deep Megaways', 'slot', 'SL'),
(438, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bbbnz.png', 'vs10bbbnz', 'Big Bass Day at the Races', 'slot', 'SL'),
(439, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20stckwldsc.png', 'vs20stckwldsc', 'Pot of Fortune', 'slot', 'SL'),
(440, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs15samurai4.png', 'vs15samurai4', 'Rise of Samurai 4', 'slot', 'SL'),
(441, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20portals.png', 'vs20portals', 'Fire Portals', 'slot', 'SL'),
(442, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20sugarrushx.png', 'vs20sugarrushx', 'Sugar Rush 1000', 'slot', 'SL'),
(443, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20cbrhst.png', 'vs20cbrhst', 'Cyber Heist', 'slot', 'SL'),
(444, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs20doghouse2.png', 'vs20doghouse2', 'The Dog House - Dog or Alive', 'slot', 'SL'),
(445, 'PRAGMATIC', 'https://assets.tigridy.com/game_pic/rec/325/vs10bburger.png', 'vs10bburger', 'Big Burger Load it up with Xtra Cheese', 'slot', 'SL'),
(446, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/diaochan.png', 'diaochan', 'Honey Trap of Diao Chan', 'slot', 'SL'),
(447, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/gem-saviour.png', 'gem-saviour', 'Gem Saviour', 'slot', 'SL'),
(448, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-gods.png', 'fortune-gods', 'Fortune Gods', 'slot', 'SL'),
(449, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/medusa2.png', 'medusa2', 'Medusa II', 'slot', 'SL'),
(450, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/medusa.png', 'medusa', 'Medusa', 'slot', 'SL'),
(451, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/hood-wolf.png', 'hood-wolf', 'hotpot', 'slot', 'SL'),
(452, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/reel-love.png', 'reel-love', 'Reel Love', 'slot', 'SL'),
(453, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/win-win-won.png', 'win-win-won', 'Win Win Won', 'slot', 'SL'),
(454, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/plushie-frenzy.png', 'plushie-frenzy', 'Plushie Frenzy', 'slot', 'SL'),
(455, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-tree.png', 'fortune-tree', 'Tree of Fortune', 'slot', 'SL'),
(456, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/hotpot.png', 'hotpot', 'Hotpot', 'slot', 'SL'),
(457, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dragon-legend.png', 'dragon-legend', 'Dragon Legend', 'slot', 'SL'),
(458, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/hip-hop-panda.png', 'hip-hop-panda', 'Hip Hop Panda', 'slot', 'SL'),
(459, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/legend-of-hou-yi.png', 'legend-of-hou-yi', 'Legend of Hou Yi', 'slot', 'SL'),
(460, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mr-hallow-win.png', 'mr-hallow-win', 'Mr. Hallow-Win', 'slot', 'SL'),
(461, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/prosperity-lion.png', 'prosperity-lion', 'Prosperity Lion', 'slot', 'SL'),
(462, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/santas-gift-rush.png', 'santas-gift-rush', 'Santa&apos;s Gift Rush', 'slot', 'SL'),
(463, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/gem-saviour-sword.png', 'gem-saviour-sword', 'Gem Saviour Sword', 'slot', 'SL'),
(464, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/piggy-gold.png', 'piggy-gold', 'Piggy Gold', 'slot', 'SL'),
(465, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/jungle-delight.png', 'jungle-delight', 'Jungle Delight', 'slot', 'SL'),
(466, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/symbols-of-egypt.png', 'symbols-of-egypt', 'Symbols of Egypt', 'slot', 'SL'),
(467, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/ganesha-gold.png', 'ganesha-gold', 'Ganesha Gold', 'slot', 'SL'),
(468, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/emperors-favour.png', 'emperors-favour', 'Emperor&apos;s Favour', 'slot', 'SL'),
(469, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/double-fortune.png', 'double-fortune', 'Double Fortune', 'slot', 'SL'),
(470, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/journey-to-the-wealth.png', 'journey-to-the-wealth', 'Journey to the Wealth', 'slot', 'SL'),
(471, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/the-great-icescape.png', 'the-great-icescape', 'The Great Icescape', 'slot', 'SL'),
(472, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/captains-bounty.png', 'captains-bounty', 'Captain&apos;s Bounty', 'slot', 'SL'),
(473, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dragon-hatch.png', 'dragon-hatch', 'Dragon Hatch', 'slot', 'SL'),
(474, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/vampires-charm.png', 'vampires-charm', 'Vampire&apos;s Charm', 'slot', 'SL'),
(475, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/ninja-vs-samurai.png', 'ninja-vs-samurai', 'Ninja vs Samurai', 'slot', 'SL'),
(476, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/leprechaun-riches.png', 'leprechaun-riches', 'Leprechaun Riches', 'slot', 'SL'),
(477, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/flirting-scholar.png', 'flirting-scholar', 'Flirting Scholar', 'slot', 'SL'),
(478, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/gem-saviour-conquest.png', 'gem-saviour-conquest', 'Gem Saviour Conquest', 'slot', 'SL'),
(479, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dragon-tiger-luck.png', 'dragon-tiger-luck', 'Dragon Tiger Luck', 'slot', 'SL'),
(480, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/muay-thai-champion.png', 'muay-thai-champion', 'Muay Thai Champion', 'slot', 'SL'),
(481, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mahjong-ways.png', 'mahjong-ways', 'Mahjong Ways', 'slot', 'SL'),
(482, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/shaolin-soccer.png', 'shaolin-soccer', 'Shaolin Soccer', 'slot', 'SL'),
(483, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-mouse.png', 'fortune-mouse', 'Fortune Mouse', 'slot', 'SL'),
(484, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/bikini-paradise.png', 'bikini-paradise', 'Bikini Paradise ', 'slot', 'SL'),
(485, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/candy-burst.png', 'candy-burst', 'Candy Burst', 'slot', 'SL'),
(486, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/cai-shen-wins.png', 'cai-shen-wins', 'Cai shen Wins', 'slot', 'SL'),
(487, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/egypts-book-mystery.png', 'egypts-book-mystery', 'Egypt&apos;s Book of Mystery', 'slot', 'SL'),
(488, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mahjong-ways2.png', 'mahjong-ways2', 'mahjong-ways2', 'slot', 'SL'),
(489, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/ganesha-fortune.png', 'ganesha-fortune', 'Ganesha Fortune', 'slot', 'SL'),
(490, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dreams-of-macau.png', 'dreams-of-macau', 'Dreams of Macau', 'slot', 'SL'),
(491, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/circus-delight.png', 'circus-delight', 'Circus Delight', 'slot', 'SL'),
(492, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/phoenix-rises.png', 'phoenix-rises', 'Phoenix Rises', 'slot', 'SL'),
(493, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/wild-fireworks.png', 'wild-fireworks', 'Wild Fireworks', 'slot', 'SL'),
(494, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/queen-bounty.png', 'queen-bounty', 'Queen of Bounty ', 'slot', 'SL'),
(495, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/genies-wishes.png', 'genies-wishes', 'Genie&apos;s 3 Wishes', 'slot', 'SL'),
(496, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/galactic-gems.png', 'galactic-gems', 'Galactic Gems', 'slot', 'SL'),
(497, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/treasures-aztec.png', 'treasures-aztec', 'Treasures of Aztec', 'slot', 'SL'),
(498, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/jewels-prosper.png', 'jewels-prosper', 'Jewels of Prosperity', 'slot', 'SL'),
(499, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/lucky-neko.png', 'lucky-neko', 'Lucky Neko', 'slot', 'SL'),
(500, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/sct-cleopatra.png', 'sct-cleopatra', 'Secrets of Cleopatra', 'slot', 'SL'),
(501, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/gdn-ice-fire.png', 'gdn-ice-fire', 'Guardians of Ice and Fire', 'slot', 'SL'),
(502, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/thai-river.png', 'thai-river', 'Thai River Wonders', 'slot', 'SL'),
(503, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/opera-dynasty.png', 'opera-dynasty', 'Opera Dynasty', 'slot', 'SL'),
(504, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/bali-vacation.png', 'bali-vacation', 'Bali Vacation', 'slot', 'SL'),
(505, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/majestic-ts.png', 'majestic-ts', 'Majestic Treasures', 'slot', 'SL'),
(506, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/jack-frosts.png', 'jack-frosts', 'Jack Frost&apos;s Winter', 'slot', 'SL'),
(507, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-ox.png', 'fortune-ox', 'Fortune Ox', 'slot', 'SL'),
(508, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/candy-bonanza.png', 'candy-bonanza', 'Candy Bonanza', 'slot', 'SL'),
(509, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/rise-of-apollo.png', 'rise-of-apollo', 'Rise of Apollo', 'slot', 'SL'),
(510, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mermaid-riches.png', 'mermaid-riches', 'Mermaid Riches', 'slot', 'SL'),
(511, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/crypto-gold.png', 'crypto-gold', 'Crypto Gold', 'slot', 'SL'),
(512, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/wild-bandito.png', 'wild-bandito', 'Wild Bandito', 'slot', 'SL'),
(513, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/heist-stakes.png', 'heist-stakes', 'Heist  Stakes', 'slot', 'SL'),
(514, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/ways-of-qilin.png', 'ways-of-qilin', 'Ways of the Qilin', 'slot', 'SL'),
(515, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/lgd-monkey-kg.png', 'lgd-monkey-kg', 'Legendary Monkey King', 'slot', 'SL'),
(516, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/buffalo-win.png', 'buffalo-win', 'Buffalo Win', 'slot', 'SL'),
(517, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/jurassic-kdm.png', 'jurassic-kdm', 'Jurassic Kingdom', 'slot', 'SL'),
(518, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/oriental-pros.png', 'oriental-pros', 'Oriental Prosperity', 'slot', 'SL'),
(519, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/crypt-fortune.png', 'crypt-fortune', 'Raider Jane&apos;s Crypt of Fortune', 'slot', 'SL'),
(520, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/emoji-riches.png', 'emoji-riches', 'Emoji Riches', 'slot', 'SL'),
(521, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/sprmkt-spree.png', 'sprmkt-spree', 'Supermarket Spree', 'slot', 'SL'),
(522, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/cocktail-nite.png', 'cocktail-nite', 'Cocktail Nights', 'slot', 'SL'),
(523, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mask-carnival.png', 'mask-carnival', 'Mask Carnival', 'slot', 'SL'),
(524, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/spirit-wonder.png', 'spirit-wonder', 'Spirited Wonders', 'slot', 'SL'),
(525, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/queen-banquet.png', 'queen-banquet', 'The Queen&apos;s Banquet', 'slot', 'SL'),
(526, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dest-sun-moon.png', 'dest-sun-moon', 'Destiny of Sun & Moon', 'slot', 'SL'),
(527, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/garuda-gems.png', 'garuda-gems', 'Garuda Gems', 'slot', 'SL'),
(528, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/rooster-rbl.png', 'rooster-rbl', 'Rooster Rumble', 'slot', 'SL'),
(529, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/battleground.png', 'battleground', 'Battleground Royale', 'slot', 'SL'),
(530, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/btrfly-blossom.png', 'btrfly-blossom', 'Butterfly Blossom', 'slot', 'SL'),
(531, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-tiger.png', 'fortune-tiger', 'Fortune Tiger', 'slot', 'SL'),
(532, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/speed-winner.png', 'speed-winner', 'Speed Winner', 'slot', 'SL'),
(533, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/legend-perseus.png', 'legend-perseus', 'Legend of Perseus', 'slot', 'SL'),
(534, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/win-win-fpc.png', 'win-win-fpc', 'Win Win Fish Prawn Crab', 'slot', 'SL'),
(535, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/lucky-piggy.png', 'lucky-piggy', 'Lucky Piggy', 'slot', 'SL'),
(536, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/wild-coaster.png', 'wild-coaster', 'Wild Coaster', 'slot', 'SL'),
(537, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/wild-bounty-sd.png', 'wild-bounty-sd', 'Wild Bounty Showdown', 'slot', 'SL'),
(538, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/prosper-ftree.png', 'prosper-ftree', 'Prosperity Fortune Tree', 'slot', 'SL'),
(539, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/totem-wonders.png', 'totem-wonders', 'Totem Wonders', 'slot', 'SL'),
(540, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/asgardian-rs.png', 'asgardian-rs', 'Asgardian Rising', 'slot', 'SL'),
(541, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/alchemy-gold.png', 'alchemy-gold', 'Alchemy Gold', 'slot', 'SL'),
(542, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/diner-delights.png', 'diner-delights', 'Diner Delights', 'slot', 'SL'),
(543, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/hawaiian-tiki.png', 'hawaiian-tiki', 'Hawaiian Tiki', 'slot', 'SL'),
(544, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fruity-candy.png', 'fruity-candy', 'Fruity Candy', 'slot', 'SL'),
(545, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/midas-fortune.png', 'midas-fortune', 'Midas Fortune', 'slot', 'SL'),
(546, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/bakery-bonanza.png', 'bakery-bonanza', 'Bakery Bonanza', 'slot', 'SL'),
(547, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/rave-party-fvr.png', 'rave-party-fvr', 'Rave Party Fever', 'slot', 'SL'),
(548, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/myst-spirits.png', 'myst-spirits', 'Mystical Spirits', 'slot', 'SL'),
(549, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/songkran-spl.png', 'songkran-spl', 'Songkran Splash', 'slot', 'SL'),
(550, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/dragon-hatch2.png', 'dragon-hatch2', 'Dragon Hatch2', 'slot', 'SL'),
(551, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/cruise-royale.png', 'cruise-royale', 'Cruise Royale', 'slot', 'SL'),
(552, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/ult-striker.png', 'ult-striker', 'Ultimate Striker', 'slot', 'SL'),
(553, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/spr-golf-drive.png', 'spr-golf-drive', 'Super Golf Drive', 'slot', 'SL'),
(554, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/fortune-rabbit.png', 'fortune-rabbit', 'Fortune Rabbit', 'slot', 'SL'),
(555, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/wild-heist-co.jpg', 'wild-heist-co', 'Wild Heist Cashout', 'slot', 'SL'),
(556, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/mafia-mayhem.png', 'mafia-mayhem', 'Mafia Mayhem', 'slot', 'SL'),
(557, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/safari-wilds.png', 'safari-wilds', 'Safari Wilds', 'slot', 'SL'),
(558, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/lucky-clover.png', 'lucky-clover', 'Lucky Clover Lady', 'slot', 'SL'),
(559, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/werewolf-hunt.png', 'werewolf-hunt', 'Werewolf&apos;s Hunt', 'slot', 'SL'),
(560, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/tsar-treasures.png', 'tsar-treasures', 'Tsar Treasures', 'slot', 'SL'),
(561, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/gemstones-gold.png', 'gemstones-gold', 'Gemstones Gold', 'slot', 'SL'),
(562, 'PGSOFT', 'https://assets.tigridy.com/public/images/pgsoft/1695365.jpg', 'fortrune-dragon', 'Fortune Dragon', 'slot', 'SL');

-- --------------------------------------------------------

--
-- Table structure for table `tb_konfirmasi`
--

CREATE TABLE `tb_konfirmasi` (
  `cuid` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `paymentID` varchar(25) NOT NULL,
  `kd_transaksi` varchar(25) NOT NULL,
  `image` varchar(255) NOT NULL,
  `tanggal` datetime NOT NULL,
  `bank_tujuan` text NOT NULL,
  `total` int(11) NOT NULL,
  `metode` varchar(25) NOT NULL DEFAULT 'transfer',
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_livechat`
--

CREATE TABLE `tb_livechat` (
  `cuid` int(255) NOT NULL,
  `lc_js` text NOT NULL,
  `lc_mobile` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_livechat`
--

INSERT INTO `tb_livechat` (`cuid`, `lc_js`, `lc_mobile`) VALUES
(1, '+62123123123', '123123123');

-- --------------------------------------------------------

--
-- Table structure for table `tb_notif`
--

CREATE TABLE `tb_notif` (
  `cuid` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `note` text NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_page`
--

CREATE TABLE `tb_page` (
  `cuid` int(11) NOT NULL,
  `slug` text NOT NULL,
  `nama_page` text NOT NULL,
  `content` longtext NOT NULL,
  `image` varchar(255) NOT NULL,
  `video` varchar(255) NOT NULL,
  `created_date` date NOT NULL,
  `last_update` date NOT NULL,
  `user` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_page`
--

INSERT INTO `tb_page` (`cuid`, `slug`, `nama_page`, `content`, `image`, `video`, `created_date`, `last_update`, `user`) VALUES
(5, 'kebijakan-privasi', 'Kebijakan Privasi', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master'),
(3, 'deposit', 'Deposit', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master'),
(2, 'withdraw', 'Withdraw', 'Edit', '', '', '0000-00-00', '2022-12-15', 'master'),
(1, 'tentang-kami', 'Tentang Kami', '<p>Selamat datang di situs kincai77, situs permainan online terlengkap dan terpercaya. Pada halaman ini anda dapat memilih kategori permainan yang anda ingin mainkan saat ini. Bagi anda yang belum memiliki akun, silahkan membuat akun dengan mengklik â€œDaftarâ€ dan dapatkan bonus pemain baru di situs kami. Rasakan keseruan yang telah dirasakan oleh pemain lainnya. Jangan ketinggalan permainan terbaru yang seru di situs kami. Kami hanya memiliki permainan-permainan terbaik agar anda tidak bingung saat memilih permainan.<span style=\"color: rgb(255, 255, 255); font-family: \" nunito=\"\" sans\",=\"\" sans-serif;=\"\" font-size:=\"\" 12px;=\"\" background-color:=\"\" rgb(49,=\"\" 21,=\"\" 64);\"=\"\"></span></p>', '', '', '0000-00-00', '2024-06-18', 'spiderman'),
(4, 'syarat-ketentuan', 'Syarat & Ketentuan', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master'),
(10, 'responsibe-gaming', 'Responsible Gaming', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master'),
(11, 'referral-syarat-ketentuan', 'Referral Syarat & Ketentuan', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master'),
(12, 'pengaduan-konsumen', 'Pengaduan Konsumen', 'Edit', '', '', '0000-00-00', '2022-04-23', 'master');

-- --------------------------------------------------------

--
-- Table structure for table `tb_playerapi`
--

CREATE TABLE `tb_playerapi` (
  `cuid` int(255) NOT NULL,
  `extplayer` text NOT NULL,
  `ops` text NOT NULL,
  `status` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_popup`
--

CREATE TABLE `tb_popup` (
  `cuid` int(11) NOT NULL,
  `ip` text NOT NULL,
  `date` date NOT NULL,
  `status` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_popup`
--

INSERT INTO `tb_popup` (`cuid`, `ip`, `date`, `status`) VALUES
(1, '127.0.0.1', '2023-05-06', '0');

-- --------------------------------------------------------

--
-- Table structure for table `tb_post`
--

CREATE TABLE `tb_post` (
  `cuid` int(11) NOT NULL,
  `slug` text NOT NULL,
  `title` text NOT NULL,
  `persen` text NOT NULL,
  `min_to` text NOT NULL,
  `satuan` int(2) NOT NULL,
  `max_bonus` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `author` text NOT NULL,
  `kategori` text NOT NULL,
  `created_date` date NOT NULL,
  `last_update` date NOT NULL,
  `user` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_post`
--

INSERT INTO `tb_post` (`cuid`, `slug`, `title`, `persen`, `min_to`, `satuan`, `max_bonus`, `image`, `content`, `author`, `kategori`, `created_date`, `last_update`, `user`, `status`) VALUES
(13, 'extra-bonus-petir', 'EXTRA BONUS PETIR', '0', '10', 0, 0, 'blog_spiderman_20241806092550.png', '<p>EXTRA BONUS PETIR<br></p><p><br></p><p><br></p><p>BET Â Â  1.000Â Â Â  4.000Â Â  Â 10.000<br></p><hr><p>PETIRx50Â Â  Â 25.000Â Â  Â 40.000Â Â  Â 100.000<br></p><hr><p>PETIRx100Â Â  Â 50.000Â Â  Â 100.000Â Â  Â 150.000<br></p><hr><p>PETIRx250Â Â  Â 100.000Â Â  Â 200.000Â Â  Â 300.000<br></p><hr><p>PETIRx500Â Â Â  150.000Â Â Â  300.000Â Â Â  500.000<br></p><hr><p><br><br>Syarat dan ketentuan :<br><br>1. Event Ini berlaku untuk semua member KAWAI55<br><br>2. Promo ini tidak dapat digabung dengan PROMO/EVENT lain!<br><br>3. (KHUSUS DALAM PERKALIAN BUYSPIN - TIDAK BERLAKU DI LUAR PERKALIAN FREESPIN) <br><br>4. Event ini hanya berlaku di permainan GATES OF OLYMPUS ,STARLIGHT PRINCESSÂ  & GATES OF GATOTKACA Pada PRAGMATIC PLAY<br><br>5. Claim hanya bisa di lakukan pada hari yang sama. ( Statement hari sebelumnya tidak berlaku di hari berikutnya ). Reset pada jam 12 : 00 WIB.<br><br>6. Untuk dapat Claim, Setiap pemain wajib melakukan screenshoot dan Hub Live Chat<br></p><p><br>7. Apabila lanjut spin setelah mendapatkan hasil freespin maka di anggap HANGUS<br><br>8. Batas Maksimal Per claim adalah 3 x dalam 1 hari.<br><br>9. Syarat dan ketentuan dapat berubah sewaktu waktu<br><br>10. Pihak KAWAI55 berhak membatalkan bonus apabila terjadi kecurangan<br><br>11. Segala keputusan KAWAI55 adalah mutlak dan tidak bisa di ganggu gugat<br><br>NB : HANYA DI HITUNG STAKE AWAL ( TIDAK DI HITUNG STAKE TAMBAHAN FITUR DOUBLE CHANCE) <br><br>NB : RESET JAM 12.00 WIB (SIANG HARI)</p>', 'SPIDERMAN', '0', '2024-05-18', '2024-06-18', 'spiderman', 1),
(14, 'extra-bonus-event-scatter-murni', 'EXTRA BONUS EVENT SCATTER MURNI', '0', '10', 0, 0, 'blog_spiderman_20241806092701.png', '<p><br></p><p>EXTRA BONUS EVENT SCATTER MURNI<br></p><p><br></p><p align=\"left\"><br>SCATTERÂ Â Â  BET 600Â Â Â  BET 1.000Â Â Â  BET 2.760Â Â Â  BET 5.000Â Â Â  BET 10.000</p><p><br></p><hr><p><br></p><p>4 SCATTERÂ Â  Â 10.000Â Â  Â 20.000Â Â  Â 35.000Â Â  Â 50.000Â Â  Â 100.000<br></p><p><br></p><hr><p><br></p><p>5 SCATTERÂ Â  Â 15.000Â Â  Â 30.000Â Â  Â 60.000Â Â  Â 100.000Â Â  Â 170.000<br></p><p><br></p><hr><p><br></p><p>6 SCATTERÂ Â  Â 20.000Â Â  Â 100.000Â Â  Â 150.000Â Â  Â 180.000Â Â  Â 250.000<br></p><p><br></p><hr><p><br></p><p>Syarat dan Ketentuan :<br>Minimal BET 600 Stake di lihat sesuai jumlah normal/ tanpa (Fitur Ganda)<br><br>1.Event Ini Berlaku Untuk Semua Member KAWAI55 Yang Tidak Mengambil Bonus Apapun<br><br>2.Event Ini Bisa Di Gabung Dengan Event Bonus Freespin Murni 20%<br><br>3.Event Ini Hanya Berlaku Untuk Games Provider PragmaticPlay : <br><br>â–ªï¸- Sweet Bonanza<br><br>â–ªï¸- Sweet Bonanza Xmas<br><br>â–ªï¸- Bonanza Gold<br><br>â–ªï¸- Great Rhino megaways<br><br>â–ªï¸- Gates of Olympus<br><br>â–ªï¸- Bufallo megaways<br><br>â–ªï¸- Chrismas Carol megaways<br><br>â–ªï¸- Dan masih banyak game lainnya yang memiliki scatter<br><br>4.Wajib\r\n Di Dapat Di Freespin Murni Tidak Berlaku Untuk BUYSPIN. Wajib di \r\nscrenshot SCATER nya . Jika tidak terkena screenshot dianggap tidak SAH.\r\n Tidak berlaku di history / Replay<br><br>5.Setiap User ID hanya Bisa \r\nKlaim Global event slot yang ada di MEGAJP Sebanyak 3X Setiap Hari. Jika\r\n claim Scater & freespin murni 30% terhitung 1 x claim. Reset event \r\nSetiap Jam 12.00 WIB <br><br>6.Bonus Wajib Di Claim Setelah \r\nMenyelesaikan putaran Freespin Dan Di Screenshot. Jika Dimainkan Lagi \r\nBaru Claim Maka Akan Dianggap Tidak Sah <br><br>7. Claim Fresspin disini\r\n akan masuk ke hitungan event FREE/BUYSPIN 30% (Contoh claim freespin \r\ndisini 1x maka kuota untuk claim di event buy/freespin 30% sisa 2x)<br><br>8.Jika Bonus Belum Di Masukan Lalu Di Mainkan Lagi Maka Bonus Otomatis Hangus<br><br><br>#SCATEKAWAI55<br><br>#DOUBLECLAIMKAWAI55<br><br>11.Bonus\r\n Akan Di Berikan Setelah Keluar Win Lose Dari Provider. (Mohon Sabar \r\nMenunggu Dan Tidak Perlu Spam Hadiah Pasti Di Proses).<br><br>12.Promo Ini Dapat Berubah Kapan Saja Tanpa Pemberitahuan Terlebih Dahulu<br><br>13.Apabila bentuk kecurangan apaun baik disengaja maupun tidak Maka Bonus Ditarik dan Kredit Dihanguskan<br><br>14.Semua keputusan KAWAI55 Adalah Mutlak Dan Tidak Bisa Di Ganggu Gugat.<br><br>NB : BOLEH DENGAN DC/FITUR GANDA ON<br><br><br><br><br></p><p><br></p>', 'SPIDERMAN', '0', '2024-05-18', '2024-06-18', 'spiderman', 1),
(12, 'bonus-100--new-member', 'BONUS 100% NEW MEMBER', '0', '5', 0, 0, 'blog_spiderman_20241806092404.jpg', '<p>BONUS NEW MEMBER 100%<br><br>Â <br><br><br>SYARAT DAN KETENTUAN<br><br>1. â€‹Promo Bonus ini hanya berlaku dan di berikan pada deposit pertama untuk semua permainan SLOT<br>2. Minimal deposit untuk ikut serta dalam promo ini adalah sebesar Rp. 25.000,-.<br>3. Maksimal bonus sebesar Rp. 300.000,-.<br>4. Bonus New Member 100% hanya bisa diklaim sebelum bermain, apabila credit sudah dimainkan, maka tidak dapat di proseskan.<br>5. Syarat Withdraw adalah 5 x TurnOver dari Deposit + Bonus<br>contoh : TO x 5 Dikali (Depo 50rb + Bonus 50rb) , Maka minimal TurnOver yang harus di capai Rp 500.000,-.<br>6. Withdraw hanya bisa di lakukan apabila telah memenuhi Syarat TurnOver.<br>7. Jika member terdeteksi menggantung FREESPIN & SCATTER / BONUS maka Account akan kami suspended.<br>8. Promo dapat berubah sewaktu-waktu tanpa ada pemberitahuan terlebih dahulu.<br>9. Untuk claim bonus wajib deposit via bank atau e - wallet<br>10. Keputusan Management KAWAI55 adalah Mutlak dan tidak dapat di ganggu gugat.<br></p>', 'SPIDERMAN', '0', '2024-05-18', '2024-06-18', 'spiderman', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_ppplayer`
--

CREATE TABLE `tb_ppplayer` (
  `cuid` int(255) NOT NULL,
  `userID` int(255) NOT NULL,
  `externalPlayerId` text NOT NULL,
  `playerid` text NOT NULL,
  `token` text NOT NULL,
  `provider` text NOT NULL,
  `balance` int(11) NOT NULL,
  `status` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_rekening_deposit`
--

CREATE TABLE `tb_rekening_deposit` (
  `cuid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `akun` text NOT NULL,
  `pemilik` text NOT NULL,
  `no_rek` text NOT NULL,
  `status` int(2) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_rekening_deposit`
--

INSERT INTO `tb_rekening_deposit` (`cuid`, `image`, `akun`, `pemilik`, `no_rek`, `status`, `userID`) VALUES
(1, '', 'BANK BCA', 'rico santoso', '2154652251', 1, 2303),
(2, '', 'BANK BCA', 'Administrator', '081322000000', 1, 2304),
(14, '', 'BANK BCA', 'kolio', '1158589977', 1, 3),
(5, 'rekening_mimintop_20241806144440.png', 'BNI', 'Administrator', '081222222222', 1, 1),
(6, 'rekening_mimintop_20241806144457.png', 'BRI', 'Administrator', '081222222222', 1, 1),
(7, 'rekening_mimintop_20241806144514.png', 'BSI', 'Administrator', '081222222222', 1, 1),
(8, 'rekening_mimintop_20241806144549.png', 'MANDIRI', 'Administrator', '081222222222', 1, 1),
(9, 'rekening_mimintop_20241806144607.png', 'DANA', 'Administrator', '081222222222', 1, 1),
(10, 'rekening_mimintop_20241806144623.png', 'GOPAY', 'Administrator', '081222222222', 1, 1),
(11, 'rekening_mimintop_20241806144652.png', 'OVO', 'Administrator', '081222222222', 1, 1),
(12, 'rekening_mimintop_20241806144707.png', 'LINKAJA', 'Administrator', '081222222222', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_saldo_member`
--

CREATE TABLE `tb_saldo_member` (
  `cuid` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `active` text NOT NULL,
  `pending` text NOT NULL,
  `transfer` text NOT NULL,
  `payout` text NOT NULL,
  `created_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_saldo_member`
--

INSERT INTO `tb_saldo_member` (`cuid`, `userID`, `active`, `pending`, `transfer`, `payout`, `created_date`) VALUES
(1, 1, '100000', '0', '0', '0', '2024-06-18 01:52:51'),
(2, 2, '18560', '0', '120000', '0', '2024-06-18 03:39:27'),
(3, 3, '0', '0', '0', '0', '2024-06-18 08:10:10'),
(4, 4, '0', '0', '0', '0', '2024-06-18 16:24:58'),
(5, 5, '0', '0', '0', '0', '2024-06-18 16:26:50'),
(6, 6, '0', '0', '0', '0', '2024-06-18 16:27:37'),
(7, 7, '0', '0', '0', '0', '2024-06-18 16:28:15'),
(8, 8, '0', '0', '0', '0', '2024-06-18 16:28:46');

-- --------------------------------------------------------

--
-- Table structure for table `tb_seo`
--

CREATE TABLE `tb_seo` (
  `cuid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'logo.png',
  `instansi` text NOT NULL,
  `keyword` text NOT NULL,
  `deskripsi` text NOT NULL,
  `news` text NOT NULL,
  `gtask` text NOT NULL,
  `footer` longtext NOT NULL,
  `onoff` int(2) NOT NULL DEFAULT 0,
  `urlweb` text NOT NULL,
  `user` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_seo`
--

INSERT INTO `tb_seo` (`cuid`, `image`, `instansi`, `keyword`, `deskripsi`, `news`, `gtask`, `footer`, `onoff`, `urlweb`, `user`, `date`) VALUES
(1, 'logo_spiderman_20241706171126.png', 'kincai77', '', '', '', '', '', 0, 'https://demo.kincai77.fun', 'adminmaster', '2020-01-10 20:55:37');

-- --------------------------------------------------------

--
-- Table structure for table `tb_slide`
--

CREATE TABLE `tb_slide` (
  `cuid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `sort` int(11) NOT NULL,
  `user` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_slide`
--

INSERT INTO `tb_slide` (`cuid`, `image`, `deskripsi`, `sort`, `user`, `status`) VALUES
(12, 'slide_panelmaster_20240424203617.png', '', 6, 'panelmaster', 1),
(13, 'slide_panelmaster_20240424203632.png', '', 5, 'panelmaster', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_social`
--

CREATE TABLE `tb_social` (
  `cuid` int(11) NOT NULL,
  `facebook` text NOT NULL,
  `twitter` text NOT NULL,
  `googleplus` text NOT NULL,
  `instagram` text NOT NULL,
  `linkedin` text NOT NULL,
  `youtube` text NOT NULL,
  `date` datetime NOT NULL,
  `user` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_social`
--

INSERT INTO `tb_social` (`cuid`, `facebook`, `twitter`, `googleplus`, `instagram`, `linkedin`, `youtube`, `date`, `user`) VALUES
(1, '#', '#', '#', '#', '#', '#', '0000-00-00 00:00:00', 'master');

-- --------------------------------------------------------

--
-- Table structure for table `tb_stat`
--

CREATE TABLE `tb_stat` (
  `cuid` int(11) NOT NULL,
  `ip` text NOT NULL,
  `date` date NOT NULL,
  `hits` int(11) NOT NULL,
  `page` text NOT NULL,
  `user` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_stat`
--

INSERT INTO `tb_stat` (`cuid`, `ip`, `date`, `hits`, `page`, `user`) VALUES
(1, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(2, '103.208.206.68', '2024-06-17', 1, 'Masuk Akun', 'adminmaster'),
(3, '171.67.70.238', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(4, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(5, '51.158.37.210', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(6, '103.208.206.68', '2024-06-17', 1, 'Lotto', 'adminmaster'),
(7, '51.159.214.65', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(8, '87.236.176.96', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(9, '123.60.68.42', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(10, '87.98.153.11', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(11, '176.53.219.118', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(12, '176.53.222.74', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(13, '87.236.176.219', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(14, '43.133.38.182', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(15, '45.135.36.127', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(16, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(17, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(18, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(19, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(20, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(21, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(22, '212.192.60.192', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(23, '129.226.147.7', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(24, '129.226.147.7', '2024-06-17', 1, 'Lupa Password', 'adminmaster'),
(25, '129.226.147.7', '2024-06-17', 1, 'Poker', 'adminmaster'),
(26, '129.226.147.7', '2024-06-17', 1, 'Register', 'adminmaster'),
(27, '129.226.147.7', '2024-06-17', 1, 'Slot', 'adminmaster'),
(28, '3.82.28.40', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(29, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(30, '104.28.215.132', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(31, '18.213.107.7', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(32, '104.166.80.60', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(33, '123.60.68.42', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(34, '18.208.212.24', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(35, '50.19.129.227', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(36, '18.208.181.225', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(37, '54.145.77.120', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(38, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(39, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(40, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(41, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(42, '162.19.25.94', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(43, '192.87.174.28', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(44, '192.87.174.28', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(45, '82.146.44.21', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(46, '82.146.44.21', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(47, '43.135.129.233', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(48, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(49, '103.208.206.68', '2024-06-17', 1, 'Lotto', 'adminmaster'),
(50, '92.114.62.4', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(51, '161.129.174.168', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(52, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(53, '20.105.137.134', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(54, '123.60.68.42', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(55, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(56, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(57, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(58, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(59, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(60, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(61, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(62, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(63, '103.208.206.68', '2024-06-17', 1, 'Sports+', 'adminmaster'),
(64, '103.208.206.68', '2024-06-17', 1, 'Casino', 'adminmaster'),
(65, '103.208.206.68', '2024-06-17', 1, 'Fishing', 'adminmaster'),
(66, '103.208.206.68', '2024-06-17', 1, 'Lotto', 'adminmaster'),
(67, '103.208.206.68', '2024-06-17', 1, 'Arcade', 'adminmaster'),
(68, '103.208.206.68', '2024-06-17', 1, 'Promosi', 'adminmaster'),
(69, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(70, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(71, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(72, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(73, '103.208.206.68', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(74, '103.208.206.68', '2024-06-17', 1, 'Register', 'adminmaster'),
(75, '103.208.206.68', '2024-06-17', 1, 'Slot', 'adminmaster'),
(76, '104.166.80.70', '2024-06-17', 1, 'Beranda', 'adminmaster'),
(77, '49.51.179.103', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(78, '104.166.80.30', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(79, '43.131.248.209', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(80, '135.148.100.196', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(81, '35.159.128.92', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(82, '149.40.50.71', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(83, '104.152.222.44', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(84, '104.152.222.44', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(85, '104.152.222.44', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(86, '38.95.13.133', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(87, '171.67.70.233', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(88, '43.133.66.151', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(89, '195.211.77.140', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(90, '195.211.77.142', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(91, '18.209.238.188', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(92, '13.95.133.245', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(93, '51.158.37.210', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(94, '123.60.68.42', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(95, '176.53.221.57', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(96, '103.179.223.235', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(97, '43.159.128.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(98, '51.15.66.158', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(99, '89.104.100.251', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(100, '95.108.213.105', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(101, '5.255.231.174', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(102, '213.180.203.47', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(103, '15.204.182.106', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(104, '213.180.203.128', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(105, '170.106.82.193', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(106, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(107, '95.177.180.85', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(108, '95.177.180.85', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(109, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(110, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(111, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(112, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(113, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(114, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(115, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(116, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(117, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(118, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(119, '8.41.221.49', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(120, '8.41.221.49', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(121, '43.133.77.230', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(122, '15.204.182.106', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(123, '65.108.186.46', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(124, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(125, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(126, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(127, '20.229.51.198', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(128, '103.208.206.68', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(129, '103.208.206.68', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(130, '103.208.206.68', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(131, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(132, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(133, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(134, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(135, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(136, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(137, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(138, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(139, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(140, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(141, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(142, '5.164.29.116', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(143, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(144, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(145, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(146, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(147, '192.87.174.28', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(148, '192.87.174.28', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(149, '23.172.112.231', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(150, '58.211.23.183', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(151, '58.211.23.183', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(152, '58.211.23.183', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(153, '58.211.23.183', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(154, '87.236.176.163', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(155, '188.64.149.112', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(156, '188.64.149.112', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(157, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(158, '178.33.107.250', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(159, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(160, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(161, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(162, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(163, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(164, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(165, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(166, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(167, '43.128.100.206', '2024-06-18', 1, 'Poker', 'adminmaster'),
(168, '43.128.100.206', '2024-06-18', 1, 'Slot', 'adminmaster'),
(169, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(170, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(171, '43.128.100.206', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(172, '43.128.100.206', '2024-06-18', 1, 'Register', 'adminmaster'),
(173, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(174, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(175, '43.128.100.206', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(176, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(177, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(178, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(179, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(180, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(181, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(182, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(183, '43.163.6.35', '2024-06-18', 1, 'Casino', 'adminmaster'),
(184, '103.208.206.68', '2024-06-18', 1, 'Poker', 'adminmaster'),
(185, '103.208.206.68', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(186, '43.163.6.35', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(187, '43.163.6.35', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(188, '103.208.206.68', '2024-06-18', 1, 'Poker', 'adminmaster'),
(189, '43.163.6.35', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(190, '43.134.190.89', '2024-06-18', 1, 'Arcade', 'adminmaster'),
(191, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(192, '103.208.206.68', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(193, '103.208.206.68', '2024-06-18', 1, 'Poker', 'adminmaster'),
(194, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(195, '103.208.206.68', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(196, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(197, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(198, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(199, '103.208.206.68', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(200, '103.208.206.68', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(201, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(202, '103.208.206.68', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(203, '103.208.206.68', '2024-06-18', 1, 'Poker', 'adminmaster'),
(204, '103.208.206.68', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(205, '103.208.206.68', '2024-06-18', 1, 'Arcade', 'adminmaster'),
(206, '103.208.206.68', '2024-06-18', 1, 'Arcade', 'adminmaster'),
(207, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(208, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(209, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(210, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(211, '180.136.232.21', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(212, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(213, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(214, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(215, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(216, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(217, '176.53.217.17', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(218, '43.133.72.69', '2024-06-18', 1, 'Lupa Password', 'adminmaster'),
(219, '43.134.170.46', '2024-06-18', 1, 'Register', 'adminmaster'),
(220, '43.163.0.99', '2024-06-18', 1, 'Slot', 'adminmaster'),
(221, '43.155.183.138', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(222, '43.163.0.99', '2024-06-18', 1, 'Poker', 'adminmaster'),
(223, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(224, '14.194.11.238', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(225, '46.191.188.179', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(226, '198.13.62.122', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(227, '57.128.81.210', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(228, '51.81.46.212', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(229, '92.118.39.143', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(230, '124.156.193.7', '2024-06-18', 1, 'Lupa Password', 'adminmaster'),
(231, '124.156.193.7', '2024-06-18', 1, 'Register', 'adminmaster'),
(232, '43.134.190.89', '2024-06-18', 1, 'Poker', 'adminmaster'),
(233, '124.156.193.7', '2024-06-18', 1, 'Slot', 'adminmaster'),
(234, '150.109.16.20', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(235, '43.155.136.16', '2024-06-18', 1, 'Slot', 'adminmaster'),
(236, '43.155.136.16', '2024-06-18', 1, 'Poker', 'adminmaster'),
(237, '222.249.228.245', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(238, '43.155.166.202', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(239, '43.155.166.202', '2024-06-18', 1, 'Lupa Password', 'adminmaster'),
(240, '43.155.166.202', '2024-06-18', 1, 'Register', 'adminmaster'),
(241, '183.160.194.212', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(242, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(243, '54.38.211.230', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(244, '54.38.211.230', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(245, '43.159.63.75', '2024-06-18', 1, 'Lupa Password', 'adminmaster'),
(246, '43.155.138.79', '2024-06-18', 1, 'Slot', 'adminmaster'),
(247, '43.155.138.79', '2024-06-18', 1, 'Poker', 'adminmaster'),
(248, '43.155.183.138', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(249, '43.155.183.138', '2024-06-18', 1, 'Register', 'adminmaster'),
(250, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(251, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(252, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(253, '104.166.80.224', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(254, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(255, '122.180.189.122', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(256, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(257, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(258, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(259, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(260, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(261, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(262, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(263, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(264, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(265, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(266, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(267, '43.134.66.205', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(268, '129.226.147.7', '2024-06-18', 1, 'Lupa Password', 'adminmaster'),
(269, '150.109.13.194', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(270, '150.109.13.194', '2024-06-18', 1, 'Arcade', 'adminmaster'),
(271, '150.109.13.194', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(272, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(273, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(274, '171.67.70.238', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(275, '170.64.173.151', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(276, '170.64.173.151', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(277, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(278, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(279, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(280, '43.155.183.138', '2024-06-18', 1, 'Referral', 'adminmaster'),
(281, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(282, '150.109.253.34', '2024-06-18', 1, 'Tentang Kami', 'adminmaster'),
(283, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(284, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(285, '43.163.0.99', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(286, '150.109.253.34', '2024-06-18', 1, 'Deposit', 'adminmaster'),
(287, '43.163.0.99', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(288, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(289, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(290, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(291, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(292, '119.160.185.225', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(293, '119.160.185.225', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(294, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(295, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(296, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(297, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(298, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(299, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(300, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(301, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(302, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(303, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(304, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(305, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(306, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(307, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(308, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(309, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(310, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(311, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(312, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(313, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(314, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(315, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(316, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(317, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(318, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(319, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(320, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(321, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(322, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(323, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(324, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(325, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(326, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(327, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(328, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(329, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(330, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(331, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(332, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(333, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(334, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(335, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(336, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(337, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(338, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(339, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(340, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(341, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(342, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(343, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(344, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(345, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(346, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(347, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(348, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(349, '149.56.160.180', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(350, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(351, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(352, '149.56.160.180', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(353, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(354, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(355, '149.56.160.180', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(356, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(357, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(358, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(359, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(360, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(361, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(362, '144.217.135.145', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(363, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(364, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(365, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(366, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(367, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(368, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(369, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(370, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(371, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(372, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(373, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(374, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(375, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(376, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(377, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(378, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(379, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(380, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(381, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(382, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(383, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(384, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(385, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(386, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(387, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(388, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(389, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(390, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(391, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(392, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(393, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(394, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(395, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(396, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(397, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(398, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(399, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(400, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(401, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(402, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(403, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(404, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(405, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(406, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(407, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(408, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(409, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(410, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(411, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(412, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(413, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(414, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(415, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(416, '149.154.161.197', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(417, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(418, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(419, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(420, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(421, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(422, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(423, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(424, '96.9.79.172', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(425, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(426, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(427, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(428, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(429, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(430, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(431, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(432, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(433, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(434, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(435, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(436, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(437, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(438, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(439, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(440, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(441, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(442, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(443, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(444, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(445, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(446, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(447, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(448, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(449, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(450, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(451, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(452, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(453, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(454, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(455, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(456, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(457, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(458, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(459, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(460, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(461, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(462, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(463, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(464, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(465, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(466, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(467, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(468, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(469, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(470, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(471, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(472, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(473, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(474, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(475, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(476, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(477, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(478, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(479, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(480, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(481, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(482, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(483, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(484, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(485, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(486, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(487, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(488, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(489, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(490, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(491, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(492, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(493, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(494, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(495, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(496, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(497, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(498, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(499, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(500, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(501, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(502, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(503, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(504, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(505, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(506, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(507, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(508, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(509, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(510, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(511, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(512, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(513, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(514, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(515, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(516, '159.65.7.128', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(517, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(518, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(519, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(520, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(521, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(522, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(523, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(524, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(525, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(526, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(527, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(528, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(529, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(530, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(531, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(532, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(533, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(534, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(535, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(536, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(537, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(538, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(539, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(540, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(541, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(542, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(543, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(544, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(545, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(546, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(547, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(548, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(549, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(550, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(551, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(552, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(553, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(554, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(555, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(556, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(557, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(558, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(559, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(560, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(561, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(562, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(563, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(564, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(565, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(566, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(567, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(568, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(569, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(570, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(571, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(572, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(573, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(574, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(575, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(576, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(577, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(578, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(579, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(580, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(581, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(582, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(583, '103.208.206.68', '2024-06-18', 1, 'Poker', 'adminmaster'),
(584, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(585, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(586, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(587, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(588, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(589, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(590, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(591, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(592, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(593, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(594, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(595, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(596, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(597, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(598, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(599, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(600, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(601, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(602, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(603, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(604, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(605, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(606, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(607, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(608, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(609, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(610, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(611, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(612, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(613, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(614, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(615, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(616, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(617, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(618, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(619, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(620, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(621, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(622, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(623, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(624, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(625, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(626, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(627, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(628, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(629, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(630, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(631, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(632, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(633, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(634, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(635, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(636, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(637, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(638, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(639, '209.127.108.99', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(640, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(641, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(642, '209.127.108.115', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(643, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(644, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(645, '209.127.253.61', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(646, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(647, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(648, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(649, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(650, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(651, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(652, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(653, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(654, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(655, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(656, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(657, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(658, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(659, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(660, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(661, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(662, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(663, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(664, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(665, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(666, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(667, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(668, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(669, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(670, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(671, '96.9.79.172', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(672, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(673, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(674, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(675, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(676, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(677, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(678, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(679, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(680, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(681, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(682, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(683, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(684, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(685, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(686, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(687, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(688, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(689, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(690, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(691, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(692, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(693, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(694, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(695, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(696, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(697, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(698, '96.9.79.172', '2024-06-18', 1, 'Register', 'adminmaster'),
(699, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(700, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(701, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(702, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(703, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(704, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(705, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(706, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(707, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(708, '96.9.79.172', '2024-06-18', 1, 'Poker', 'adminmaster'),
(709, '96.9.79.172', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(710, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(711, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(712, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(713, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(714, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(715, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(716, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(717, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(718, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(719, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(720, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(721, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(722, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(723, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(724, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(725, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(726, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(727, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(728, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(729, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(730, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(731, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(732, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(733, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(734, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(735, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(736, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(737, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(738, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(739, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(740, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(741, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(742, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(743, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(744, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(745, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster');
INSERT INTO `tb_stat` (`cuid`, `ip`, `date`, `hits`, `page`, `user`) VALUES
(746, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(747, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(748, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(749, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(750, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(751, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(752, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(753, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(754, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(755, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(756, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(757, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(758, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(759, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(760, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(761, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(762, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(763, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(764, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(765, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(766, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(767, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(768, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(769, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(770, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(771, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(772, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(773, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(774, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(775, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(776, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(777, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(778, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(779, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(780, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(781, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(782, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(783, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(784, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(785, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(786, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(787, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(788, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(789, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(790, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(791, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(792, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(793, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(794, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(795, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(796, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(797, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(798, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(799, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(800, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(801, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(802, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(803, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(804, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(805, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(806, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(807, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(808, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(809, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(810, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(811, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(812, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(813, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(814, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(815, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(816, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(817, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(818, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(819, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(820, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(821, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(822, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(823, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(824, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(825, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(826, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(827, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(828, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(829, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(830, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(831, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(832, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(833, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(834, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(835, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(836, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(837, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(838, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(839, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(840, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(841, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(842, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(843, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(844, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(845, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(846, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(847, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(848, '96.9.79.172', '2024-06-18', 1, 'RTP', 'adminmaster'),
(849, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(850, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(851, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(852, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(853, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(854, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(855, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(856, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(857, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(858, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(859, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(860, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(861, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(862, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(863, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(864, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(865, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(866, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(867, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(868, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(869, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(870, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(871, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(872, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(873, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(874, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(875, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(876, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(877, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(878, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(879, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(880, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(881, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(882, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(883, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(884, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(885, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(886, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(887, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(888, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(889, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(890, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(891, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(892, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(893, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(894, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(895, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(896, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(897, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(898, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(899, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(900, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(901, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(902, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(903, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(904, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(905, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(906, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(907, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(908, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(909, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(910, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(911, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(912, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(913, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(914, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(915, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(916, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(917, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(918, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(919, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(920, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(921, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(922, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(923, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(924, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(925, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(926, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(927, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(928, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(929, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(930, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(931, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(932, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(933, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(934, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(935, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(936, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(937, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(938, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(939, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(940, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(941, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(942, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(943, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(944, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(945, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(946, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(947, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(948, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(949, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(950, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(951, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(952, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(953, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(954, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(955, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(956, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(957, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(958, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(959, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(960, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(961, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(962, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(963, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(964, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(965, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(966, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(967, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(968, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(969, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(970, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(971, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(972, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(973, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(974, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(975, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(976, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(977, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(978, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(979, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(980, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(981, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(982, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(983, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(984, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(985, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(986, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(987, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(988, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(989, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(990, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(991, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(992, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(993, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(994, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(995, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(996, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(997, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(998, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(999, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1000, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1001, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1002, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1003, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1004, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1005, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1006, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1007, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1008, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1009, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1010, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1011, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1012, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1013, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1014, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1015, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1016, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1017, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1018, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1019, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1020, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1021, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1022, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1023, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1024, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1025, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1026, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1027, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1028, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1029, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1030, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1031, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1032, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1033, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1034, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1035, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1036, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1037, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1038, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1039, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1040, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1041, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1042, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1043, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1044, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1045, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1046, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1047, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1048, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1049, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1050, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1051, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1052, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1053, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1054, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1055, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1056, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1057, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1058, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1059, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1060, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1061, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1062, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1063, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1064, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1065, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1066, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1067, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1068, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1069, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1070, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1071, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1072, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1073, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1074, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1075, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1076, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1077, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1078, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1079, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1080, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1081, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1082, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1083, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1084, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1085, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1086, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1087, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1088, '103.208.206.68', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(1089, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1090, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1091, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1092, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1093, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1094, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1095, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1096, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1097, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1098, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1099, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1100, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1101, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1102, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1103, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1104, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1105, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1106, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1107, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1108, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1109, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1110, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1111, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1112, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1113, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1114, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1115, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1116, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1117, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1118, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1119, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1120, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1121, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1122, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1123, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1124, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1125, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1126, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1127, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1128, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1129, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1130, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1131, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1132, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1133, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1134, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1135, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1136, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1137, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1138, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1139, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1140, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1141, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1142, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1143, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1144, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1145, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1146, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1147, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1148, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1149, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1150, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1151, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1152, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1153, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1154, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1155, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1156, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1157, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1158, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1159, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1160, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1161, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1162, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1163, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1164, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1165, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1166, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1167, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1168, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1169, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1170, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1171, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1172, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1173, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1174, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1175, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1176, '43.155.169.133', '2024-06-18', 1, 'Referral', 'adminmaster'),
(1177, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1178, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1179, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1180, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1181, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1182, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1183, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1184, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1185, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1186, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1187, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1188, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1189, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1190, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1191, '43.163.6.124', '2024-06-18', 1, 'Tentang Kami', 'adminmaster'),
(1192, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1193, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1194, '43.155.169.133', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1195, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1196, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1197, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1198, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1199, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1200, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1201, '43.163.6.124', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1202, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1203, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1204, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1205, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1206, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1207, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1208, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1209, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1210, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1211, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1212, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1213, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1214, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1215, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1216, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1217, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1218, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1219, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1220, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1221, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1222, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1223, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1224, '150.109.253.34', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(1225, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1226, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1227, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1228, '96.9.79.172', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(1229, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1230, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1231, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1232, '43.159.63.75', '2024-06-18', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1233, '43.159.63.75', '2024-06-18', 1, 'Kebijakan Privasi', 'adminmaster'),
(1234, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1235, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1236, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1237, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1238, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1239, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1240, '103.208.206.68', '2024-06-18', 1, 'RTP', 'adminmaster'),
(1241, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1242, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1243, '124.156.193.7', '2024-06-18', 1, 'Deposit', 'adminmaster'),
(1244, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1245, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1246, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1247, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1248, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1249, '124.156.193.7', '2024-06-18', 1, 'Withdraw', 'adminmaster'),
(1250, '96.9.79.172', '2024-06-18', 1, 'Fishing', 'adminmaster'),
(1251, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1252, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1253, '124.156.193.7', '2024-06-18', 1, 'Responsible Gaming', 'adminmaster'),
(1254, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1255, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1256, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1257, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1258, '209.127.110.123', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1259, '209.127.104.215', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1260, '209.127.109.108', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1261, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1262, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1263, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1264, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1265, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1266, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1267, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1268, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1269, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1270, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1271, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1272, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1273, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1274, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1275, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1276, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1277, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1278, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1279, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1280, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1281, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1282, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1283, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1284, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1285, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1286, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1287, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1288, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1289, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1290, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1291, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1292, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1293, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1294, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1295, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1296, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1297, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1298, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1299, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1300, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1301, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1302, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1303, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1304, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1305, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1306, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1307, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1308, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1309, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1310, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1311, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1312, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1313, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1314, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1315, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1316, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1317, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1318, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1319, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1320, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1321, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1322, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1323, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1324, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1325, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1326, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1327, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1328, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1329, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1330, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1331, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1332, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1333, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1334, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1335, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1336, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1337, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1338, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1339, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1340, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1341, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1342, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1343, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1344, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1345, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1346, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1347, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1348, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1349, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1350, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1351, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1352, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1353, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1354, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1355, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1356, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1357, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1358, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1359, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1360, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1361, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1362, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1363, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1364, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1365, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1366, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1367, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1368, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1369, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1370, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1371, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1372, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1373, '66.102.8.162', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1374, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1375, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1376, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1377, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1378, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1379, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1380, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1381, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1382, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1383, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1384, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1385, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1386, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1387, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1388, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1389, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1390, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1391, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1392, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1393, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1394, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1395, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1396, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1397, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1398, '103.208.206.68', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1399, '72.44.41.245', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1400, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1401, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1402, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1403, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1404, '131.202.14.152', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1405, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1406, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1407, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1408, '103.208.206.68', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1409, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1410, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1411, '96.9.79.172', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1412, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1413, '223.113.128.180', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1414, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1415, '52.81.33.66', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1416, '129.226.147.7', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(1417, '129.226.147.7', '2024-06-18', 1, 'Referral', 'adminmaster'),
(1418, '43.131.243.208', '2024-06-18', 1, 'Tentang Kami', 'adminmaster'),
(1419, '129.226.147.7', '2024-06-18', 1, 'Kontak', 'adminmaster'),
(1420, '43.128.100.220', '2024-06-18', 1, 'Deposit', 'adminmaster'),
(1421, '52.112.125.8', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1422, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1423, '203.80.167.49', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1424, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1425, '103.208.206.68', '2024-06-18', 1, 'Register', 'adminmaster'),
(1426, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1427, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1428, '103.208.206.68', '2024-06-18', 1, 'Masuk Akun', 'adminmaster'),
(1429, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1430, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1431, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1432, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1433, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1434, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1435, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1436, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1437, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1438, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1439, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1440, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1441, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1442, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1443, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1444, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1445, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1446, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1447, '203.80.167.49', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1448, '203.80.167.49', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1449, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1450, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1451, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1452, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1453, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1454, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1455, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1456, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1457, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1458, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1459, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1460, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1461, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1462, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1463, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1464, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1465, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1466, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1467, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1468, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1469, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1470, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1471, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1472, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1473, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster');
INSERT INTO `tb_stat` (`cuid`, `ip`, `date`, `hits`, `page`, `user`) VALUES
(1474, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1475, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1476, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1477, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1478, '103.208.206.68', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1479, '103.208.206.68', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(1480, '89.104.101.242', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1481, '177.191.118.6', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1482, '45.90.60.190', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1483, '43.135.181.13', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1484, '34.94.123.57', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1485, '34.94.123.57', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1486, '159.65.45.113', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1487, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1488, '54.195.35.11', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1489, '103.208.206.68', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1490, '103.208.206.68', '2024-06-18', 1, 'Referral', 'adminmaster'),
(1491, '194.226.187.37', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1492, '104.166.80.81', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1493, '103.208.206.68', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1494, '34.72.176.129', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1495, '65.155.30.101', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1496, '65.154.226.169', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1497, '34.122.147.229', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1498, '205.169.39.104', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1499, '205.169.39.104', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1500, '34.122.147.229', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1501, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1502, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1503, '96.9.79.172', '2024-06-18', 1, 'Promosi', 'adminmaster'),
(1504, '180.249.148.125', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1505, '180.249.148.125', '2024-06-18', 1, 'Sports+', 'adminmaster'),
(1506, '180.249.148.125', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1507, '180.249.148.125', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1508, '180.249.148.125', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1509, '96.9.79.172', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1510, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1511, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1512, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1513, '96.9.79.172', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1514, '206.189.231.200', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1515, '180.249.148.125', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1516, '202.160.41.26', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1517, '180.249.148.125', '2024-06-18', 1, 'Lotto', 'adminmaster'),
(1518, '180.249.148.125', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1519, '202.160.41.26', '2024-06-18', 1, 'Slot', 'adminmaster'),
(1520, '202.160.41.26', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1521, '123.60.68.42', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1522, '192.87.174.28', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1523, '192.87.174.28', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1524, '192.87.174.28', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1525, '62.109.24.243', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1526, '62.109.24.243', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1527, '170.106.104.42', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1528, '43.131.243.208', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1529, '43.163.8.148', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1530, '43.131.249.153', '2024-06-18', 1, 'Referral Syarat & Ketentuan', 'adminmaster'),
(1531, '43.163.0.99', '2024-06-18', 1, 'Casino', 'adminmaster'),
(1532, '43.163.0.99', '2024-06-18', 1, 'Pengaduan Konsumen', 'adminmaster'),
(1533, '128.140.115.160', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1534, '128.140.115.160', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1535, '170.64.173.144', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1536, '170.64.173.144', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1537, '137.184.113.33', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1538, '137.184.113.33', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1539, '213.180.203.185', '2024-06-18', 1, 'Beranda', 'adminmaster'),
(1540, '43.155.138.79', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1541, '43.131.249.153', '2024-06-19', 1, 'Lupa Password', 'adminmaster'),
(1542, '43.155.138.79', '2024-06-19', 1, 'Poker', 'adminmaster'),
(1543, '43.131.249.153', '2024-06-19', 1, 'Register', 'adminmaster'),
(1544, '150.109.16.20', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1545, '43.159.128.68', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1546, '5.75.249.226', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1547, '45.90.61.155', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1548, '199.45.155.106', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1549, '114.160.71.84', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1550, '43.155.136.16', '2024-06-19', 1, 'Poker', 'adminmaster'),
(1551, '43.155.160.173', '2024-06-19', 1, 'Lupa Password', 'adminmaster'),
(1552, '43.155.160.173', '2024-06-19', 1, 'Register', 'adminmaster'),
(1553, '43.163.0.99', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1554, '43.134.142.8', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1555, '121.5.231.252', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1556, '35.163.238.88', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1557, '159.138.11.130', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1558, '43.163.6.124', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1559, '43.155.183.138', '2024-06-19', 1, 'Arcade', 'adminmaster'),
(1560, '150.109.13.194', '2024-06-19', 1, 'Fishing', 'adminmaster'),
(1561, '43.134.170.46', '2024-06-19', 1, 'Casino', 'adminmaster'),
(1562, '43.131.249.153', '2024-06-19', 1, 'Lotto', 'adminmaster'),
(1563, '51.15.66.158', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1564, '43.134.66.205', '2024-06-19', 1, 'Register', 'adminmaster'),
(1565, '43.163.3.58', '2024-06-19', 1, 'Poker', 'adminmaster'),
(1566, '43.134.66.205', '2024-06-19', 1, 'Promosi', 'adminmaster'),
(1567, '43.134.142.8', '2024-06-19', 1, 'Lupa Password', 'adminmaster'),
(1568, '150.109.253.34', '2024-06-19', 1, 'Referral', 'adminmaster'),
(1569, '43.155.183.138', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1570, '191.96.227.244', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1571, '43.155.138.79', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1572, '43.133.72.69', '2024-06-19', 1, 'Casino', 'adminmaster'),
(1573, '43.128.110.17', '2024-06-19', 1, 'Lotto', 'adminmaster'),
(1574, '43.133.72.69', '2024-06-19', 1, 'Fishing', 'adminmaster'),
(1575, '43.163.6.35', '2024-06-19', 1, 'Arcade', 'adminmaster'),
(1576, '23.111.114.116', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1577, '128.140.124.229', '2024-06-19', 1, 'Poker', 'adminmaster'),
(1578, '162.55.35.231', '2024-06-19', 1, 'Referral', 'adminmaster'),
(1579, '54.38.211.230', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1580, '128.140.61.238', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1581, '49.13.20.5', '2024-06-19', 1, 'Lotto', 'adminmaster'),
(1582, '212.102.57.97', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1583, '66.115.182.139', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1584, '37.120.233.27', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1585, '157.90.245.150', '2024-06-19', 1, 'Promosi', 'adminmaster'),
(1586, '170.64.173.144', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1587, '34.78.49.210', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1588, '49.12.247.31', '2024-06-19', 1, 'Lupa Password', 'adminmaster'),
(1589, '172.174.142.174', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1590, '168.119.181.72', '2024-06-19', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1591, '49.13.83.176', '2024-06-19', 1, 'Tentang Kami', 'adminmaster'),
(1592, '43.135.166.178', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1593, '206.168.34.122', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1594, '195.201.41.238', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1595, '49.13.141.66', '2024-06-19', 1, 'Deposit', 'adminmaster'),
(1596, '3.145.59.66', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1597, '43.163.8.36', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1598, '49.12.110.197', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1599, '49.13.120.62', '2024-06-19', 1, 'Withdraw', 'adminmaster'),
(1600, '111.47.230.65', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1601, '34.122.147.229', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1602, '150.109.253.34', '2024-06-19', 1, 'Kontak', 'adminmaster'),
(1603, '43.131.249.153', '2024-06-19', 1, 'Promosi', 'adminmaster'),
(1604, '43.155.166.202', '2024-06-19', 1, 'Tentang Kami', 'adminmaster'),
(1605, '205.169.39.64', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1606, '43.163.6.124', '2024-06-19', 1, 'Deposit', 'adminmaster'),
(1607, '43.159.63.75', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1608, '134.122.44.212', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1609, '65.154.226.168', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1610, '91.107.193.67', '2024-06-19', 1, 'Kontak', 'adminmaster'),
(1611, '142.132.228.230', '2024-06-19', 1, 'Kebijakan Privasi', 'adminmaster'),
(1612, '8.41.221.61', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1613, '8.41.221.61', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1614, '5.75.241.183', '2024-06-19', 1, 'Pengaduan Konsumen', 'adminmaster'),
(1615, '111.207.155.211', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1616, '49.13.12.216', '2024-06-19', 1, 'RTP', 'adminmaster'),
(1617, '17.241.75.125', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1618, '95.177.180.82', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1619, '43.128.110.17', '2024-06-19', 1, 'Withdraw', 'adminmaster'),
(1620, '43.128.110.17', '2024-06-19', 1, 'Deposit', 'adminmaster'),
(1621, '43.134.190.89', '2024-06-19', 1, 'Promosi', 'adminmaster'),
(1622, '43.155.169.133', '2024-06-19', 1, 'Tentang Kami', 'adminmaster'),
(1623, '43.163.3.58', '2024-06-19', 1, 'Kontak', 'adminmaster'),
(1624, '49.51.179.103', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1625, '66.249.65.38', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1626, '66.249.65.37', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1627, '66.249.65.37', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1628, '43.133.77.230', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1629, '66.249.65.36', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1630, '66.249.73.97', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1631, '66.249.73.97', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1632, '66.249.73.97', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1633, '66.249.73.97', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1634, '198.105.100.143', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1635, '164.52.25.199', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1636, '164.52.25.199', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1637, '164.52.25.199', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1638, '118.193.58.20', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1639, '118.193.58.20', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1640, '167.235.205.105', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1641, '178.33.107.250', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1642, '34.72.176.129', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1643, '58.211.23.183', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1644, '58.211.23.183', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1645, '17.241.227.181', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1646, '58.211.23.183', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1647, '23.111.114.116', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1648, '191.101.31.65', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1649, '23.172.112.234', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1650, '68.183.245.101', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1651, '138.201.190.209', '2024-06-19', 1, 'Referral Syarat & Ketentuan', 'adminmaster'),
(1652, '124.156.193.7', '2024-06-19', 1, 'Deposit', 'adminmaster'),
(1653, '43.163.6.35', '2024-06-19', 1, 'Withdraw', 'adminmaster'),
(1654, '43.163.6.35', '2024-06-19', 1, 'Tentang Kami', 'adminmaster'),
(1655, '43.163.6.35', '2024-06-19', 1, 'Kontak', 'adminmaster'),
(1656, '129.226.147.7', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1657, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1658, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1659, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1660, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1661, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1662, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1663, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1664, '203.80.167.49', '2024-06-19', 1, 'Poker', 'adminmaster'),
(1665, '203.80.167.49', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1666, '203.80.167.49', '2024-06-19', 1, 'Sports+', 'adminmaster'),
(1667, '203.80.167.49', '2024-06-19', 1, 'Casino', 'adminmaster'),
(1668, '203.80.167.49', '2024-06-19', 1, 'Fishing', 'adminmaster'),
(1669, '203.80.167.49', '2024-06-19', 1, 'Lotto', 'adminmaster'),
(1670, '203.80.167.49', '2024-06-19', 1, 'Arcade', 'adminmaster'),
(1671, '203.80.167.49', '2024-06-19', 1, 'Arcade', 'adminmaster'),
(1672, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1673, '203.80.167.49', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1674, '185.241.208.86', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1675, '44.203.182.106', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1676, '44.213.247.231', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1677, '43.131.243.208', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1678, '35.202.72.83', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1679, '150.109.253.34', '2024-06-19', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1680, '150.109.253.34', '2024-06-19', 1, 'Kebijakan Privasi', 'adminmaster'),
(1681, '43.133.72.69', '2024-06-19', 1, 'Withdraw', 'adminmaster'),
(1682, '122.176.197.226', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1683, '54.212.241.115', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1684, '104.166.80.211', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1685, '17.241.75.209', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1686, '185.196.0.14', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1687, '185.196.0.14', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1688, '206.232.112.221', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1689, '18.234.109.170', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1690, '54.236.243.100', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1691, '103.208.206.68', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1692, '185.241.208.86', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1693, '185.241.208.86', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1694, '178.62.219.65', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1695, '5.196.160.191', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1696, '5.196.160.191', '2024-06-19', 1, 'Kontak', 'adminmaster'),
(1697, '43.163.1.85', '2024-06-19', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1698, '43.163.1.85', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1699, '43.163.8.148', '2024-06-19', 1, 'Kebijakan Privasi', 'adminmaster'),
(1700, '80.255.7.120', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1701, '96.9.79.172', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1702, '123.60.68.42', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1703, '124.156.193.7', '2024-06-19', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1704, '43.134.142.8', '2024-06-19', 1, 'Kebijakan Privasi', 'adminmaster'),
(1705, '43.131.249.153', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1706, '43.163.3.58', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1707, '153.246.135.238', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1708, '43.163.3.58', '2024-06-19', 1, 'Masuk Akun', 'adminmaster'),
(1709, '43.155.169.133', '2024-06-19', 1, 'RTP', 'adminmaster'),
(1710, '198.44.128.124', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1711, '87.98.140.71', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1712, '43.128.110.17', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1713, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1714, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1715, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1716, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1717, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1718, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1719, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1720, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1721, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1722, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1723, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1724, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1725, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1726, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1727, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1728, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1729, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1730, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1731, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1732, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1733, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1734, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1735, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1736, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1737, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1738, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1739, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1740, '128.1.131.7', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1741, '198.44.128.124', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1742, '165.154.23.208', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1743, '137.184.113.33', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1744, '137.184.113.33', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1745, '17.241.75.244', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1746, '43.159.63.75', '2024-06-19', 1, 'Kebijakan Privasi', 'adminmaster'),
(1747, '43.159.63.75', '2024-06-19', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1748, '43.163.6.35', '2024-06-19', 1, 'Responsible Gaming', 'adminmaster'),
(1749, '13.95.133.245', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1750, '220.197.51.2', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1751, '54.214.202.247', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1752, '180.249.148.125', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1753, '180.249.148.125', '2024-06-19', 1, 'Slot', 'adminmaster'),
(1754, '101.44.69.160', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1755, '223.113.128.137', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1756, '206.204.59.133', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1757, '116.212.190.94', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1758, '46.4.33.48', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1759, '43.130.47.136', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1760, '101.128.120.59', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1761, '96.9.79.172', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1762, '96.9.79.172', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1763, '96.9.79.172', '2024-06-19', 1, 'Promosi', 'adminmaster'),
(1764, '223.113.128.182', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1765, '223.113.128.137', '2024-06-19', 1, 'Beranda', 'adminmaster'),
(1766, '104.166.80.40', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1767, '103.208.206.68', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1768, '43.163.0.99', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1769, '107.22.111.190', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1770, '111.231.10.88', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1771, '51.15.66.158', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1772, '23.111.114.116', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1773, '43.131.243.208', '2024-06-20', 1, 'Tentang Kami', 'adminmaster'),
(1774, '43.163.0.99', '2024-06-20', 1, 'Sports+', 'adminmaster'),
(1775, '43.128.110.17', '2024-06-20', 1, 'Referral', 'adminmaster'),
(1776, '43.128.110.17', '2024-06-20', 1, 'Promosi', 'adminmaster'),
(1777, '43.133.72.69', '2024-06-20', 1, 'Kontak', 'adminmaster'),
(1778, '20.105.137.134', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1779, '159.138.9.92', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1780, '43.130.47.136', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1781, '180.248.201.173', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1782, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1783, '180.248.201.173', '2024-06-20', 1, 'Poker', 'adminmaster'),
(1784, '180.248.201.173', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1785, '43.159.63.75', '2024-06-20', 1, 'Responsible Gaming', 'adminmaster'),
(1786, '43.155.160.173', '2024-06-20', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1787, '150.109.16.20', '2024-06-20', 1, 'Kebijakan Privasi', 'adminmaster'),
(1788, '43.153.216.189', '2024-06-20', 1, 'Deposit', 'adminmaster'),
(1789, '43.153.216.189', '2024-06-20', 1, 'Withdraw', 'adminmaster'),
(1790, '188.166.220.38', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1791, '188.166.220.38', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1792, '194.195.243.80', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1793, '139.162.135.250', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1794, '89.248.168.222', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1795, '40.113.118.83', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1796, '43.159.128.172', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1797, '43.128.100.220', '2024-06-20', 1, 'Masuk Akun', 'adminmaster'),
(1798, '43.128.100.220', '2024-06-20', 1, 'RTP', 'adminmaster'),
(1799, '181.214.153.37', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1800, '103.208.206.68', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1801, '103.208.206.68', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1802, '137.184.113.33', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1803, '137.184.113.33', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1804, '34.123.170.104', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1805, '205.169.39.171', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1806, '205.169.39.171', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1807, '65.154.226.169', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1808, '170.64.173.144', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1809, '170.64.173.144', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1810, '65.154.226.167', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1811, '188.64.149.112', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1812, '188.64.149.112', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1813, '95.177.180.85', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1814, '43.153.110.177', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1815, '176.53.219.226', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1816, '43.153.110.177', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1817, '207.154.236.241', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1818, '213.180.203.104', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1819, '150.158.45.24', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1820, '176.53.216.181', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1821, '180.248.201.173', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1822, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1823, '129.211.14.160', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1824, '54.38.211.230', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1825, '195.191.219.133', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1826, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1827, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1828, '45.154.228.49', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1829, '178.255.148.167', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1830, '178.255.148.167', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1831, '96.9.79.172', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1832, '114.122.39.140', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1833, '114.122.39.140', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1834, '96.9.79.172', '2024-06-20', 1, 'Promosi', 'adminmaster'),
(1835, '96.9.79.172', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1836, '96.9.79.172', '2024-06-20', 1, 'Masuk Akun', 'adminmaster'),
(1837, '96.9.79.172', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1838, '96.9.79.172', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1839, '96.9.79.172', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1840, '58.211.23.183', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1841, '96.9.79.172', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1842, '96.9.79.172', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1843, '123.60.68.42', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1844, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1845, '103.208.206.66', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1846, '110.50.81.198', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1847, '103.208.206.66', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1848, '103.208.206.66', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1849, '110.50.81.197', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1850, '103.208.206.66', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1851, '103.208.206.66', '2024-06-20', 1, 'Promosi', 'adminmaster'),
(1852, '103.208.206.66', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1853, '170.187.184.242', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1854, '118.103.248.80', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1855, '74.125.215.1', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1856, '66.249.82.226', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1857, '114.5.111.203', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1858, '118.103.248.80', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1859, '118.103.248.80', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1860, '118.103.248.80', '2024-06-20', 1, 'Poker', 'adminmaster'),
(1861, '118.103.248.80', '2024-06-20', 1, 'Poker', 'adminmaster'),
(1862, '170.106.159.160', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1863, '206.204.7.198', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1864, '91.132.185.106', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1865, '52.16.245.145', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1866, '52.16.245.145', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1867, '52.16.245.145', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1868, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1869, '180.248.201.173', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1870, '83.36.25.67', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1871, '114.5.111.203', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1872, '65.108.46.72', '2024-06-20', 1, 'Arcade', 'adminmaster'),
(1873, '65.108.46.72', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1874, '65.108.46.72', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1875, '65.108.46.72', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1876, '65.108.46.72', '2024-06-20', 1, 'Casino', 'adminmaster'),
(1877, '65.108.46.72', '2024-06-20', 1, 'Fishing', 'adminmaster'),
(1878, '65.108.46.72', '2024-06-20', 1, 'Lupa Password', 'adminmaster'),
(1879, '65.108.46.72', '2024-06-20', 1, 'Kontak', 'adminmaster'),
(1880, '65.108.46.72', '2024-06-20', 1, 'Masuk Akun', 'adminmaster'),
(1881, '65.108.46.72', '2024-06-20', 1, 'Lotto', 'adminmaster'),
(1882, '65.108.46.72', '2024-06-20', 1, 'Deposit', 'adminmaster'),
(1883, '65.108.46.72', '2024-06-20', 1, 'Kebijakan Privasi', 'adminmaster'),
(1884, '65.108.46.72', '2024-06-20', 1, 'Pengaduan Konsumen', 'adminmaster'),
(1885, '65.108.46.72', '2024-06-20', 1, 'Referral Syarat & Ketentuan', 'adminmaster'),
(1886, '65.108.46.72', '2024-06-20', 1, 'Responsible Gaming', 'adminmaster'),
(1887, '65.108.46.72', '2024-06-20', 1, 'Syarat & Ketentuan', 'adminmaster'),
(1888, '65.108.46.72', '2024-06-20', 1, 'Tentang Kami', 'adminmaster'),
(1889, '65.108.46.72', '2024-06-20', 1, 'Withdraw', 'adminmaster'),
(1890, '65.108.46.72', '2024-06-20', 1, 'Poker', 'adminmaster'),
(1891, '65.108.46.72', '2024-06-20', 1, 'Promosi', 'adminmaster'),
(1892, '65.108.46.72', '2024-06-20', 1, 'Referral', 'adminmaster'),
(1893, '65.108.46.72', '2024-06-20', 1, 'Register', 'adminmaster'),
(1894, '65.108.46.72', '2024-06-20', 1, 'RTP', 'adminmaster'),
(1895, '65.108.46.72', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1896, '65.108.46.72', '2024-06-20', 1, 'Sports+', 'adminmaster'),
(1897, '180.242.6.197', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1898, '180.242.6.197', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1899, '96.9.79.172', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1900, '83.68.137.168', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1901, '58.211.23.183', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1902, '58.211.23.183', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1903, '103.208.206.66', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1904, '43.128.100.206', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1905, '118.103.248.80', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1906, '118.103.248.80', '2024-06-20', 1, 'Beranda', 'adminmaster'),
(1907, '209.131.254.132', '2024-06-20', 1, 'Masuk Akun', 'adminmaster'),
(1908, '118.103.248.80', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1909, '118.103.248.80', '2024-06-20', 1, 'Slot', 'adminmaster'),
(1910, '110.50.81.200', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1911, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1912, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1913, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1914, '18.234.236.223', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1915, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1916, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1917, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1918, '44.192.110.136', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1919, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1920, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1921, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1922, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1923, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1924, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1925, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1926, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1927, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1928, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1929, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1930, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1931, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1932, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1933, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1934, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1935, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1936, '52.23.198.160', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1937, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1938, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1939, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1940, '35.171.193.22', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1941, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1942, '119.160.185.225', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1943, '207.241.235.164', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1944, '124.221.186.26', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1945, '103.208.206.66', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1946, '45.79.77.29', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1947, '199.167.28.20', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1948, '43.130.31.48', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1949, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1950, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1951, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1952, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1953, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1954, '34.248.137.227', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1955, '104.166.80.175', '2024-06-21', 1, 'Beranda', 'adminmaster'),
(1956, '104.166.80.151', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1957, '104.166.80.228', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1958, '104.166.80.228', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1959, '104.166.80.38', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1960, '104.166.80.38', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1961, '82.146.44.21', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1962, '47.242.224.70', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1963, '104.166.80.62', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1964, '104.166.80.239', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1965, '62.109.24.243', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1966, '62.109.24.243', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1967, '171.244.43.14', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1968, '104.166.80.85', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1969, '104.166.80.85', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1970, '34.229.124.111', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1971, '44.210.96.95', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1972, '54.227.2.54', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1973, '52.23.198.160', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1974, '34.200.222.13', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1975, '209.58.162.217', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1976, '93.174.93.114', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1977, '80.82.70.198', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1978, '104.166.80.96', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1979, '104.166.80.177', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1980, '104.199.31.214', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1981, '34.77.127.183', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1982, '179.61.245.30', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1983, '194.32.120.26', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1984, '156.146.57.188', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1985, '104.255.169.110', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1986, '185.232.22.211', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1987, '82.102.25.214', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1988, '156.146.57.188', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1989, '156.146.57.188', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1990, '156.146.57.188', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1991, '106.154.141.163', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1992, '49.97.27.202', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1993, '37.120.213.174', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1994, '156.146.57.188', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1995, '68.183.245.101', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1996, '157.230.195.44', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1997, '106.154.144.229', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1998, '106.154.141.163', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(1999, '104.166.80.49', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2000, '104.166.80.49', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2001, '49.96.11.246', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2002, '49.96.11.246', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2003, '104.166.80.72', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2004, '104.166.80.72', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2005, '145.14.142.230', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2006, '104.164.195.231', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2007, '63.246.149.33', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2008, '47.242.224.70', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2009, '80.82.70.198', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2010, '82.146.44.21', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2011, '82.146.44.21', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2012, '104.166.80.149', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2013, '104.166.80.132', '2024-06-22', 1, 'Beranda', 'adminmaster'),
(2014, '104.166.80.132', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2015, '104.166.80.126', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2016, '64.226.109.137', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2017, '64.226.109.137', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2018, '80.82.70.198', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2019, '94.102.63.27', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2020, '61.16.68.14', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2021, '209.58.162.215', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2022, '104.165.199.66', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2023, '167.250.111.242', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2024, '104.166.80.192', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2025, '104.166.80.60', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2026, '192.158.226.21', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2027, '138.199.24.8', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2028, '74.80.181.155', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2029, '82.102.25.59', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2030, '116.70.228.250', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2031, '116.70.228.250', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2032, '142.11.219.102', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2033, '192.158.226.21', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2034, '192.158.226.21', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2035, '164.90.241.135', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2036, '161.35.246.138', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2037, '149.102.239.72', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2038, '1.73.136.216', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2039, '106.155.0.79', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2040, '223.223.99.74', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2041, '223.223.99.74', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2042, '34.16.119.221', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2043, '34.45.213.162', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2044, '165.231.182.64', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2045, '157.245.1.158', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2046, '157.245.1.158', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2047, '62.109.24.243', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2048, '80.82.70.198', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2049, '93.174.93.114', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2050, '104.166.80.32', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2051, '104.166.80.224', '2024-06-23', 1, 'Beranda', 'adminmaster'),
(2052, '104.166.80.6', '2024-06-24', 1, 'Beranda', 'adminmaster'),
(2053, '104.166.80.166', '2024-06-24', 1, 'Beranda', 'adminmaster'),
(2054, '104.166.80.177', '2024-06-24', 1, 'Beranda', 'adminmaster'),
(2055, '104.166.80.15', '2024-06-24', 1, 'Beranda', 'adminmaster'),
(2056, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2057, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2058, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2059, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2060, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2061, '110.137.38.184', '2024-07-20', 1, 'Sports+', 'adminmaster'),
(2062, '110.137.38.184', '2024-07-20', 1, 'Slot', 'adminmaster'),
(2063, '110.137.38.184', '2024-07-20', 1, 'Slot', 'adminmaster'),
(2064, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2065, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2066, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2067, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2068, '110.137.38.184', '2024-07-20', 1, 'Beranda', 'adminmaster'),
(2069, '110.137.38.184', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2070, '110.137.38.184', '2024-07-21', 1, 'Slot', 'adminmaster'),
(2071, '110.137.38.184', '2024-07-21', 1, 'RTP', 'adminmaster'),
(2072, '110.137.38.184', '2024-07-21', 1, 'Register', 'adminmaster'),
(2073, '110.137.38.184', '2024-07-21', 1, 'Referral', 'adminmaster'),
(2074, '110.137.38.184', '2024-07-21', 1, 'Promosi', 'adminmaster'),
(2075, '110.137.38.184', '2024-07-21', 1, 'Poker', 'adminmaster'),
(2076, '110.137.38.184', '2024-07-21', 1, 'Masuk Akun', 'adminmaster'),
(2077, '172.71.10.232', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2078, '172.69.135.96', '2024-07-21', 1, 'Slot', 'adminmaster'),
(2079, '172.69.135.96', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2080, '172.69.135.96', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2081, '172.69.135.96', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2082, '172.69.135.96', '2024-07-21', 1, 'Referral', 'adminmaster'),
(2083, '172.69.135.96', '2024-07-21', 1, 'Referral', 'adminmaster'),
(2084, '172.69.135.96', '2024-07-21', 1, 'Promosi', 'adminmaster'),
(2085, '172.69.135.96', '2024-07-21', 1, 'Arcade', 'adminmaster'),
(2086, '172.69.135.96', '2024-07-21', 1, 'Fishing', 'adminmaster'),
(2087, '172.69.135.96', '2024-07-21', 1, 'Casino', 'adminmaster'),
(2088, '172.69.135.96', '2024-07-21', 1, 'Casino', 'adminmaster'),
(2089, '172.69.135.96', '2024-07-21', 1, 'Casino', 'adminmaster'),
(2090, '172.69.135.96', '2024-07-21', 1, 'Slot', 'adminmaster'),
(2091, '172.69.135.96', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2092, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2093, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2094, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2095, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2096, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2097, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2098, '172.69.135.95', '2024-07-21', 1, 'Slot', 'adminmaster'),
(2099, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2100, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2101, '172.69.135.95', '2024-07-21', 1, 'Promosi', 'adminmaster'),
(2102, '172.69.135.95', '2024-07-21', 1, 'Beranda', 'adminmaster'),
(2103, '162.158.163.146', '2024-07-21', 1, 'Beranda', 'adminmaster');

-- --------------------------------------------------------

--
-- Table structure for table `tb_taruhan`
--

CREATE TABLE `tb_taruhan` (
  `cuid` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `gameid` text NOT NULL,
  `code` text NOT NULL,
  `periode` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `tebak` text NOT NULL,
  `posisi` text NOT NULL,
  `nominal` int(11) NOT NULL,
  `menang` text NOT NULL,
  `diskon` text NOT NULL,
  `bayar` text NOT NULL,
  `jumlah` text NOT NULL,
  `keterangan` text NOT NULL,
  `jenis` text NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_testi`
--

CREATE TABLE `tb_testi` (
  `cuid` int(11) NOT NULL,
  `kd_transaksi` text NOT NULL,
  `produkID` int(11) NOT NULL,
  `full_name` text NOT NULL,
  `content` mediumtext NOT NULL,
  `date` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_token`
--

CREATE TABLE `tb_token` (
  `cuid` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_token`
--

INSERT INTO `tb_token` (`cuid`, `token`) VALUES
(1, '99b1e78eb20e937beae9b48b68a12af3'),
(2, '7e99e926b03979340264a74eedb2b529'),
(3, '470e188c464c35d71721b20081d260bf'),
(4, '23e956122b89d6cdaf574e2442a2e632'),
(5, '04fd0d3c7030f3b85ef58e76781bd36d'),
(6, 'abfbdfa5577ad3c63e2aa58692ec3aab'),
(7, '17f746fa79c1f3c1f43dbd1f7b0ca987'),
(8, 'f77c74eac79343286f0e26751686b4e8'),
(9, '64deeb1306379fc121a8d9b6fd25546c'),
(10, 'f501312a89c1159ea546e9aa0f2b62ed'),
(11, '458394f22ed38d683a38263eacf2f203'),
(12, 'e7b830da6e23596f1d5a84384cc622d3'),
(13, '5aea49f1646c8285f5047808789f20a2'),
(14, '700c0772b3e37c3a82f3ad71825cd314'),
(15, 'e61e60d25f8b66ad0a7da452e5bb5ac8'),
(16, '78de725ed6f81cb5128ef0f79d623816'),
(17, '5eec0da53d6868cbc16489b3c0b0b78c'),
(18, '0f55cddc33565485cc5400bdfbea3d09'),
(19, '0d0dd63b3295b7d5c165140a0d3370cc'),
(20, '6db6b7e9930778e003856ea7a0080f7e'),
(21, 'a6c3eac46bba5aeccd1b370687caffaf'),
(22, '0e4d38c3a8f347c0219a1d52d982e22d'),
(23, '9897efa706634a69b7bc7f2f70b03a9e'),
(24, 'ddc5ba069ff442387906dccd7b8d68be'),
(25, '9e667f3ad2ced1586efd68bae04badd2'),
(26, 'b92f9012e0d34582d1992504e71291a4'),
(27, '28afb3e390e9dca85f6f73f64dc4b062'),
(28, '5c7e41d1762a9ebad9ce5682ccda41c5'),
(29, '4970440d7041333f8d855525989b9dc4'),
(30, '84f15435b01201322a997ffeef19c713'),
(31, 'f7c360c42b6e55fd00ffc772b3f526af'),
(32, '96d505da3e7d8d63d52cc59be5323d4a'),
(33, 'ef6c72109a1ba6ce9bf97cba34db0525'),
(34, 'a521bab2d699d537088641e273876abd'),
(35, 'cafc08d83a0c53575314aec50b137830'),
(36, '82f439199c322997a5d9331f257e2f93'),
(37, '12ad0fa9d63b3c33afd805a7b17349de'),
(38, '720ebd8dcf7ea51a069e1335bff366db');

-- --------------------------------------------------------

--
-- Table structure for table `tb_transaksi`
--

CREATE TABLE `tb_transaksi` (
  `cuid` int(11) NOT NULL,
  `kd_transaksi` text NOT NULL,
  `date` datetime NOT NULL,
  `transaksi` text NOT NULL,
  `total` int(11) NOT NULL,
  `saldo` int(11) NOT NULL,
  `note` text NOT NULL,
  `gameid` text NOT NULL,
  `providerID` int(2) NOT NULL,
  `jenis` text NOT NULL COMMENT '1:Deposit,2:Withdraw,3:Refferal,4:Rabate,5:Transfer,6:TransferBack',
  `metode` text NOT NULL,
  `pay_from` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_transaksi`
--

INSERT INTO `tb_transaksi` (`cuid`, `kd_transaksi`, `date`, `transaksi`, `total`, `saldo`, `note`, `gameid`, `providerID`, `jenis`, `metode`, `pay_from`, `userID`, `status`) VALUES
(1, '202406180190', '2024-06-18 14:57:01', 'Top Up', 100000, 0, 'asd', '', 0, '1', '8', 0, 1, 1),
(2, '2024061808289', '2024-06-18 14:57:08', 'Refferal', 0, 0, 'Bonus Refferal', '', 0, '3', '0', 1, 1, 1),
(3, '202406182545', '2024-06-18 17:02:25', 'Top Up', 20000, 0, '', '', 0, '1', '5', 0, 2, 1),
(4, '2024061847936', '2024-06-18 17:02:47', 'Refferal', 0, 0, 'Bonus Refferal', '', 0, '3', '0', 2, 1, 1),
(5, '20240618430832', '2024-06-18 17:06:43', 'Transfer', 20000, 0, 'Transfer to PragmaticPlay', 'vs9chen', 1, '5', '0', 0, 2, 1),
(6, '20240618292082', '2024-06-18 17:09:29', 'Transfer', 20000, 0, 'PragmaticPlay Transfer Back ', '', 1, '6', '0', 1, 2, 1),
(7, '20240618368492', '2024-06-18 17:09:36', 'Transfer', 20000, 0, 'Transfer to PragmaticPlay', 'vs20kraken2', 1, '5', '0', 0, 2, 1),
(8, '20240618585412', '2024-06-18 17:09:58', 'Transfer', 20000, 0, 'PragmaticPlay Transfer Back ', '', 1, '6', '0', 1, 2, 1),
(9, '20240618475392', '2024-06-18 17:10:47', 'Transfer', 20000, 0, 'Transfer to PGSoft', 'win-win-won', 2, '5', '0', 0, 2, 1),
(10, '20240618211582', '2024-06-18 17:11:21', 'Transfer', 20000, 0, 'PGSoft Transfer Back ', '', 2, '6', '0', 2, 2, 1),
(11, '20240618550392', '2024-06-18 17:11:55', 'Transfer', 20000, 0, 'Transfer to PragmaticPlay', 'vs25jokerking', 1, '5', '0', 0, 2, 1),
(12, '20240618268312', '2024-06-18 17:12:26', 'Transfer', 20000, 0, 'PragmaticPlay Transfer Back ', '', 1, '6', '0', 1, 2, 1),
(13, '20240620241422', '2024-06-20 15:17:24', 'Transfer', 20000, 0, 'Transfer to PragmaticPlay', 'vs7monkeys', 1, '5', '0', 0, 2, 1),
(14, '20240620443292', '2024-06-20 15:17:44', 'Transfer', 20000, 0, 'PragmaticPlay Transfer Back ', '', 1, '6', '0', 1, 2, 1),
(15, '20240620129842', '2024-06-20 22:32:12', 'Transfer', 20000, 0, 'Transfer to PragmaticPlay', 'vs20olympgate', 1, '5', '0', 0, 2, 1),
(16, '20240621257252', '2024-06-21 21:10:25', 'Transfer', 18560, 0, 'PragmaticPlay Transfer Back ', '', 1, '6', '0', 1, 2, 1),
(17, '202407205016', '2024-07-20 23:50:50', 'Top Up', 70000, 0, '', '12', 0, '1', '12', 0, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_tripayapi`
--

CREATE TABLE `tb_tripayapi` (
  `cuid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `providerCode` text NOT NULL,
  `provider` text NOT NULL,
  `providerName` text NOT NULL,
  `status` int(2) NOT NULL,
  `jenis` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tb_tripayapi`
--

INSERT INTO `tb_tripayapi` (`cuid`, `image`, `providerCode`, `provider`, `providerName`, `status`, `jenis`) VALUES
(1, 'pragmatic.png', 'PRAGMATIC', 'PRAGMATIC', 'PragmaticPlay', 0, '1'),
(2, 'pgsoft.png', 'PGSOFT', 'PGSOFT', 'PGSoft', 0, '1');

-- --------------------------------------------------------

--
-- Table structure for table `tb_turnover`
--

CREATE TABLE `tb_turnover` (
  `cuid` int(255) NOT NULL,
  `userID` int(255) NOT NULL,
  `trxID` text NOT NULL,
  `depo` int(25) NOT NULL,
  `bonus` int(25) NOT NULL,
  `jmlh_to` int(3) NOT NULL,
  `total_to` int(11) NOT NULL,
  `sisa_to` int(11) NOT NULL,
  `status` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tb_turnover`
--

INSERT INTO `tb_turnover` (`cuid`, `userID`, `trxID`, `depo`, `bonus`, `jmlh_to`, `total_to`, `sisa_to`, `status`) VALUES
(1, 1, '202407205016', 70000, 0, 5, 350000, 350000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `cuid` int(11) NOT NULL,
  `userid` text NOT NULL,
  `extplayer` text NOT NULL,
  `user` text NOT NULL,
  `pass` varchar(100) NOT NULL,
  `token_id` int(11) DEFAULT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'avatar5.png',
  `full_name` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `no_hp` text NOT NULL,
  `level` text NOT NULL,
  `pinTrx` varchar(255) NOT NULL,
  `reff` int(11) NOT NULL,
  `uplineID` int(255) NOT NULL,
  `ongame` int(2) NOT NULL,
  `join_date` datetime NOT NULL,
  `last_login` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`cuid`, `userid`, `extplayer`, `user`, `pass`, `token_id`, `image`, `full_name`, `email`, `no_hp`, `level`, `pinTrx`, `reff`, `uplineID`, `ongame`, `join_date`, `last_login`, `status`) VALUES
(2, '0', 'abpercobaan', 'percobaan', '$2y$10$prgpJDX1FIei5p/VAFrxiOXeTYWXvj3F1OODhE8KbXf.aUU1r9jIa', 34, 'avatar5.png', 'Syahrul', 'admin@kincai77.com', '08122558877', 'user', '', 0, 1, 1, '2024-06-18 01:52:51', '2024-06-21 21:10:23', 1),
(1, '0', '', 'mimintop', '$2y$10$ppV5yLNZGtP79SHYmbDsHOg1El5TrByjZkeXwEfkzNuiA3l4KPgNi', 38, 'avatar5.png', 'Administrator', 'admin@kincai77.fun', '081322000000', 'superadmin', '', 1, 1, 1, '2024-06-18 03:39:27', '2024-07-20 23:36:45', 1),
(3, '0', 'ablontong99', 'lontong99', '$2y$10$9wH.VmqZqFhTuRMvt1Cmn.FU2rPlbFR8R..k4G0vhk0wwm/W7XT8i', 28, 'avatar5.png', 'kolio', 'kolui@gmail.com', '089578993566', 'user', '', 0, 1, 1, '2024-06-18 08:10:10', '2024-06-20 14:20:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_whitelist`
--

CREATE TABLE `tb_whitelist` (
  `cuid` int(255) NOT NULL,
  `ip_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_withdraw`
--

CREATE TABLE `tb_withdraw` (
  `cuid` int(255) NOT NULL,
  `user` text NOT NULL,
  `amount` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_backup`
--
ALTER TABLE `tb_backup`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_banner`
--
ALTER TABLE `tb_banner`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_gamelist`
--
ALTER TABLE `tb_gamelist`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_konfirmasi`
--
ALTER TABLE `tb_konfirmasi`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_livechat`
--
ALTER TABLE `tb_livechat`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_notif`
--
ALTER TABLE `tb_notif`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_page`
--
ALTER TABLE `tb_page`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_playerapi`
--
ALTER TABLE `tb_playerapi`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_popup`
--
ALTER TABLE `tb_popup`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_post`
--
ALTER TABLE `tb_post`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_ppplayer`
--
ALTER TABLE `tb_ppplayer`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_rekening_deposit`
--
ALTER TABLE `tb_rekening_deposit`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_saldo_member`
--
ALTER TABLE `tb_saldo_member`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_seo`
--
ALTER TABLE `tb_seo`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_slide`
--
ALTER TABLE `tb_slide`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_social`
--
ALTER TABLE `tb_social`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_stat`
--
ALTER TABLE `tb_stat`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_taruhan`
--
ALTER TABLE `tb_taruhan`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_testi`
--
ALTER TABLE `tb_testi`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_token`
--
ALTER TABLE `tb_token`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_tripayapi`
--
ALTER TABLE `tb_tripayapi`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_turnover`
--
ALTER TABLE `tb_turnover`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_whitelist`
--
ALTER TABLE `tb_whitelist`
  ADD PRIMARY KEY (`cuid`);

--
-- Indexes for table `tb_withdraw`
--
ALTER TABLE `tb_withdraw`
  ADD PRIMARY KEY (`cuid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_admin`
--
ALTER TABLE `tb_admin`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_backup`
--
ALTER TABLE `tb_backup`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_banner`
--
ALTER TABLE `tb_banner`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_gamelist`
--
ALTER TABLE `tb_gamelist`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=563;

--
-- AUTO_INCREMENT for table `tb_konfirmasi`
--
ALTER TABLE `tb_konfirmasi`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_livechat`
--
ALTER TABLE `tb_livechat`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_notif`
--
ALTER TABLE `tb_notif`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_page`
--
ALTER TABLE `tb_page`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tb_playerapi`
--
ALTER TABLE `tb_playerapi`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_popup`
--
ALTER TABLE `tb_popup`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_post`
--
ALTER TABLE `tb_post`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tb_ppplayer`
--
ALTER TABLE `tb_ppplayer`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_rekening_deposit`
--
ALTER TABLE `tb_rekening_deposit`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tb_saldo_member`
--
ALTER TABLE `tb_saldo_member`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_seo`
--
ALTER TABLE `tb_seo`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tb_slide`
--
ALTER TABLE `tb_slide`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tb_social`
--
ALTER TABLE `tb_social`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_stat`
--
ALTER TABLE `tb_stat`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2104;

--
-- AUTO_INCREMENT for table `tb_taruhan`
--
ALTER TABLE `tb_taruhan`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_testi`
--
ALTER TABLE `tb_testi`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_token`
--
ALTER TABLE `tb_token`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tb_tripayapi`
--
ALTER TABLE `tb_tripayapi`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_turnover`
--
ALTER TABLE `tb_turnover`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `cuid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_whitelist`
--
ALTER TABLE `tb_whitelist`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_withdraw`
--
ALTER TABLE `tb_withdraw`
  MODIFY `cuid` int(255) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
