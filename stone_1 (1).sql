-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2021 at 09:34 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stone`
--

-- --------------------------------------------------------

--
-- Table structure for table `addcards`
--

CREATE TABLE `addcards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'own',
  `delivery_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_cost` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addcards`
--

INSERT INTO `addcards` (`id`, `user_id`, `product_id`, `quantity`, `delivery_type`, `delivery_status`, `delivery_cost`, `created_at`, `updated_at`) VALUES
(1, '12', '11', '123123', 'Own', NULL, NULL, '2021-04-05 13:22:33', '2021-04-05 13:22:33'),
(2, '12', '6', '123123', 'own', NULL, NULL, '2021-04-08 16:13:23', '2021-04-08 16:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(4, 'one', '2021-03-25 12:32:41', '2021-03-25 12:32:41'),
(5, 'two', '2021-03-25 14:28:05', '2021-03-25 14:28:05'),
(7, 'new', '2021-03-30 02:54:34', '2021-03-30 02:54:34'),
(8, 'test store', '2021-03-30 02:55:29', '2021-04-25 18:22:08');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nidFont` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nidBack` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `license` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `engineNo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chasisNo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `image`, `nidFont`, `nidBack`, `license`, `address`, `phone`, `engineNo`, `chasisNo`, `created_at`, `updated_at`) VALUES
(4, 'Oi jais eidt', '/uploads/1619394442.jpg', '/uploads/1619394585.jpg', '/uploads/1618340751.jpg', '1231237777777', 'address112', '12312313', '1231312121', '12414', '2021-04-13 18:08:28', '2021-04-25 17:49:52'),
(5, 'new one edit', '/uploads/1619394457.png', '/uploads/1619394461.png', '/uploads/1619394465.png', '123123', 'Address', '0123123', '1231231', '23123123123', '2021-04-25 17:48:06', '2021-04-25 17:48:14');

-- --------------------------------------------------------

--
-- Table structure for table `drivertras`
--

CREATE TABLE `drivertras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivertras`
--

INSERT INTO `drivertras` (`id`, `driver_id`, `total`, `paid`, `due`, `created_at`, `updated_at`) VALUES
(1, 4, 100, '10', '90', '2021-04-13 19:29:12', '2021-04-13 19:29:12'),
(2, 4, 90, '10', '80', '2021-04-13 19:53:49', '2021-04-13 19:53:49');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(5, '2019_05_03_000001_create_customer_columns', 2),
(6, '2019_05_03_000002_create_subscriptions_table', 2),
(7, '2019_05_03_000003_create_subscription_items_table', 2),
(8, '2021_03_24_195442_create_drivers_table', 2),
(9, '2021_03_24_212938_create_categories_table', 3),
(10, '2021_03_24_214035_create_sub_categories_table', 4),
(11, '2021_03_24_224511_create_vendors_table', 5),
(12, '2021_03_25_195126_create_products_table', 6),
(13, '2021_03_25_200305_create_product_images_table', 6),
(14, '2021_04_03_155534_create_orders_table', 7),
(15, '2021_04_04_032619_create_addcards_table', 8),
(16, '2021_04_09_003515_create_orders_table', 9),
(17, '2021_04_13_195008_create_drivertras_table', 10),
(18, '2021_04_16_055533_create_vendortras_table', 11);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subTotal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_cost` int(11) DEFAULT NULL,
  `orderStatus` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `firstName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paymentType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `quantity`, `price`, `subTotal`, `delivery_type`, `delivery_status`, `delivery_cost`, `orderStatus`, `firstName`, `lastName`, `address`, `phone`, `paymentType`, `created_at`, `updated_at`) VALUES
(1, 12, 8, 20, '20', '400', 'own', NULL, NULL, 'pending', 'two edit', 'wer edit', 'Modina Market, Sylhet', '123213213', 'cash only', '2021-04-09 13:05:27', '2021-04-09 13:05:27');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `sub_category_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `sub_category_id`, `description`, `price`, `created_at`, `updated_at`) VALUES
(2, 'Product Product name', 4, 2, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 12, '2021-03-27 12:47:05', '2021-03-27 12:47:05'),
(3, 'sf', 4, 2, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 12, '2021-03-27 12:47:31', '2021-03-27 12:47:31'),
(4, 'sf', 4, 3, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 12, '2021-03-27 12:47:52', '2021-03-27 12:47:52'),
(5, 'one', 5, 4, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 12313, '2021-03-27 12:48:52', '2021-03-27 12:48:52'),
(6, 'New', 5, 4, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-27 13:26:58', '2021-03-27 13:26:58'),
(7, 'new', 4, 5, 'description', 1234, '2021-03-28 12:30:55', '2021-03-28 12:30:55'),
(8, 'new', 4, 5, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.\\', 123, '2021-03-30 05:55:18', '2021-03-30 05:55:18'),
(9, 'sdf', 4, 5, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-30 05:58:02', '2021-03-30 05:58:02'),
(10, 'sdf', 7, 5, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-30 06:03:16', '2021-03-30 06:03:16'),
(11, 'sdf', 7, 6, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-30 06:06:41', '2021-03-30 06:06:41'),
(12, 'sdf', 7, 6, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-30 06:08:24', '2021-03-30 06:08:24'),
(13, 'check', 8, 6, 'des', 123, '2021-03-30 06:09:37', '2021-04-16 09:42:06'),
(14, 'sd edit', 8, 7, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123, '2021-03-30 06:45:24', '2021-04-16 09:41:31'),
(15, 'sdf', 8, 8, 'Ullamcor quamal eratfus aduis nuncves nequen elemen teger ies felis. Lus liberom isse musfusce onec nuncsed. Ies lum unc ger erossed egestasm molestie. Aliquam nequeal himena congued estmae liberom proin nulla. Faucibu lectus cursusve nec semmaec sque loreme bibendu quamsusp sit. Sodalesm entum dolorve amet ipsumves felisut. Magnap nunccras lum turpisf laciniai metuscra nequeal. Lla snam nequenu mnulla posuere itor.', 123123, '2021-03-30 06:46:59', '2021-04-02 17:15:29');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 3, '/uploads/1616870666.jpeg', NULL, NULL),
(2, 3, '/uploads/1616870666.jpeg', NULL, NULL),
(3, 4, '/uploads/1616870666.jpeg', NULL, NULL),
(4, 4, '/uploads/1616870666.jpeg', NULL, NULL),
(5, 5, '/uploads/1616870923.jpeg', NULL, NULL),
(7, 6, '/uploads/1616873200.jpeg', NULL, NULL),
(8, 6, '/uploads/1616873188.jpeg', NULL, NULL),
(9, 6, '/uploads/1616873182.jpeg', NULL, NULL),
(10, 7, '/uploads/1616956238.jpeg', NULL, NULL),
(11, 8, '/uploads/1617105313.jpeg', NULL, NULL),
(12, 9, '/uploads/1617105477.jpeg', NULL, NULL),
(13, 9, '/uploads/1617105470.jpeg', NULL, NULL),
(14, 10, '/uploads/1617105793.jpeg', NULL, NULL),
(15, 11, '/uploads/1617105995.png', NULL, NULL),
(16, 11, '/uploads/1616870666.jpeg', NULL, NULL),
(17, 12, '/uploads/1617106099.jpeg', NULL, NULL),
(24, 13, '/uploads/1617106173.jpeg', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_plan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_items`
--

CREATE TABLE `subscription_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_plan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 4, 'sub ca one', NULL, NULL),
(2, 4, 'sub two', NULL, NULL),
(3, 5, 'Sub three', '2021-03-25 09:47:14', '2021-03-25 09:47:14'),
(4, 5, 'one', '2021-03-25 13:08:15', '2021-03-25 13:08:15'),
(5, 7, 'two edit', '2021-03-25 13:08:52', '2021-04-25 18:24:29'),
(6, 7, 'three', '2021-03-25 13:09:18', '2021-03-25 13:09:18'),
(7, 8, 'three sub category', '2021-03-29 11:12:41', '2021-03-29 11:12:41'),
(8, 8, 'hello', '2021-03-30 02:38:15', '2021-03-30 02:38:15'),
(9, 8, 'New subcategory', '2021-04-16 09:39:05', '2021-04-16 09:39:05'),
(10, 8, 'for delete', '2021-04-16 09:39:21', '2021-04-16 09:39:21');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'User',
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `accountActivationCode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inActive',
  `isAdmin` int(255) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `image`, `email`, `phone`, `password`, `userType`, `address`, `email_verified_at`, `accountActivationCode`, `status`, `isAdmin`, `created_at`, `updated_at`, `stripe_id`, `card_brand`, `card_last_four`, `trial_ends_at`) VALUES
(12, 'two edit', 'wer edit', '/uploads/1616614319.jpeg', 'admin@gmail.com', '123213213', '$2y$10$3hwTezMnx3/v1P5EnQS6O.yfsrRr6k3bgUiuvxmZF8Qfemc5Zkzxy', 'admin', 'Modina Market, Sylhet', NULL, NULL, 'inActive', 0, '2021-03-24 13:32:16', '2021-04-25 18:30:04', NULL, NULL, NULL, NULL),
(13, 'nsdf edit', 'sdfsdf', '/uploads/1617219339.jpeg', 'user@gmail.com', '9999', '$2y$10$t4s9.vuKv4qKxdonuqYqROfVikYNGG2WPDsjuCRXc0lWPrIpdLQcu', 'user', 'Modina Market, Sylhet', NULL, NULL, 'inActive', 0, '2021-03-31 13:36:27', '2021-03-31 13:39:44', NULL, NULL, NULL, NULL),
(14, 'super', 'Admin', '/uploads/1617304318.jpeg', 'shperadmin@gmail.com', '123123123', '$2y$10$yODBb2pw8VGZ.2.utOYITezy6byg85Zhp2XWUSvyxijJAKkQT86GG', 'superAdmin', 'Modina Market, Sylhet', NULL, NULL, 'inActive', 0, '2021-04-01 13:12:21', '2021-04-01 13:12:21', NULL, NULL, NULL, NULL),
(18, 'asd', 'asd', '/uploads/1618000381.jpeg', 'asdasda@gmai.com', '99999', '$2y$10$2ISmTNCjCs8WL4LUVmq9s.NBsGDmwXw.FcIzqe/9inWgFlnOe2J02', 'user', 'areee', NULL, NULL, 'inActive', 0, '2021-04-09 14:36:04', '2021-04-09 14:36:04', NULL, NULL, NULL, NULL),
(19, 'asd', 'asd edit', '/uploads/1618000381.jpeg', 'asdasdeea@gmai.com', '1231', '$2y$10$IHXFuQFsW7cY/ZAZ0ZKMkez1GznjofInD68Dwp2/yUty83GCBjXEW', 'user', 'areee', NULL, NULL, 'inActive', 0, '2021-04-09 14:36:54', '2021-04-15 19:59:41', NULL, NULL, NULL, NULL),
(21, 'asd', 'asd', '/uploads/1618000381.jpeg', 'asdasdeeda@gmai.com2', '123123', '$2y$10$AH9sLSyRY4tDSiSkhunze.S.L8b6jat5fBEuU47ULyoR3tKagdG3a', 'user', 'areee', NULL, NULL, 'active', 0, '2021-04-09 14:39:05', '2021-04-14 17:14:29', NULL, NULL, NULL, NULL),
(22, 'numan', 'hussain', '/uploads/1619396810.png', 'numan@gmail.com', '01790302229', '$2y$10$PfreRFpge9ULOHFFZ/caDulyeBf.2e2kG7ohSJQwp5qTllHWXZKua', 'user', 'address', NULL, '1015', 'active', 0, '2021-04-14 17:08:16', '2021-04-25 18:26:55', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nidFont` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nidBack` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tradeLicense` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `agreement` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bankingAccount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `image`, `nidFont`, `nidBack`, `tradeLicense`, `address`, `phone`, `agreement`, `bankingAccount`, `created_at`, `updated_at`) VALUES
(5, 'new', '/uploads/1618518176.jpg', '/uploads/1619394620.jpg', '/uploads/1618518187.jpg', '1313', 'address', '123123', '123123', '23434', '2021-04-15 19:23:36', '2021-04-25 17:50:26'),
(6, 'new one edit', '/uploads/1619394648.png', '/uploads/1619394685.jpg', '/uploads/1619394643.jpg', '123123123', 'addresss', '017902229', 'This is agreement', '123123123', '2021-04-25 17:51:15', '2021-04-25 17:51:30');

-- --------------------------------------------------------

--
-- Table structure for table `vendortras`
--

CREATE TABLE `vendortras` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendortras`
--

INSERT INTO `vendortras` (`id`, `vendor_id`, `total`, `paid`, `due`, `created_at`, `updated_at`) VALUES
(1, 5, 200, '88', '55', '2021-04-16 05:27:28', '2021-04-16 05:27:28'),
(2, 5, 120, '20', '100', '2021-04-16 05:28:09', '2021-04-16 05:28:09'),
(3, 6, 200, '123', '177', '2021-04-25 17:53:14', '2021-04-25 17:53:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addcards`
--
ALTER TABLE `addcards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `drivertras`
--
ALTER TABLE `drivertras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`);

--
-- Indexes for table `subscription_items`
--
ALTER TABLE `subscription_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscription_items_subscription_id_stripe_plan_unique` (`subscription_id`,`stripe_plan`),
  ADD KEY `subscription_items_stripe_id_index` (`stripe_id`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `users_stripe_id_index` (`stripe_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendortras`
--
ALTER TABLE `vendortras`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addcards`
--
ALTER TABLE `addcards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `drivertras`
--
ALTER TABLE `drivertras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_items`
--
ALTER TABLE `subscription_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vendortras`
--
ALTER TABLE `vendortras`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
