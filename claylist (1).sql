-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2020 at 06:00 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `claylist`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Category 1', '2020-06-17 11:29:00', '2020-06-17 14:02:32'),
(10, 'gjhghjx  cxzz', '2020-06-17 18:37:51', '2020-06-17 18:41:01');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2020_06_17_060708_create_categories_table', 1),
(3, '2020_06_17_060812_create_products_table', 1),
(4, '2020_06_17_060847_create_product_images_table', 1),
(5, '2020_06_17_060938_create_wishlists_table', 1),
(6, '2020_06_17_060951_create_comments_table', 1),
(7, '2020_06_17_061010_create_notifications_table', 1),
(8, '2020_06_17_061032_create_messages_table', 1),
(9, '2020_06_17_061054_create_reports_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `userFrom` int(11) NOT NULL,
  `userTo` int(11) NOT NULL,
  `seen` tinyint(1) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` int(11) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `category_id` int(11) NOT NULL,
  `hands` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int(11) NOT NULL,
  `horses_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(50) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `isFeatured` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `description`, `price`, `address`, `city`, `state`, `zip_code`, `status`, `category_id`, `hands`, `color`, `gender`, `age`, `horses_name`, `user_id`, `view_count`, `isFeatured`, `created_at`, `updated_at`) VALUES
(1, 'demoooo', 'demo table card-table table-bordered table-hover table-vcenter text-nowrap', 123, NULL, 'demo', 'demo', 123, 'Pending', 1, 'demo', 'demo', 'demo', 21, 'demo', NULL, 0, NULL, NULL, NULL),
(2, 'nb', 'bbn', 9, NULL, 'dfsd dfdf', 'hkj', 89, '', 8, 'hjg', 'jhg', 'jhjh', 0, 'hgjh', NULL, NULL, NULL, '2020-06-18 12:37:01', '2020-06-18 12:37:01'),
(3, 'sfdf', 'cvb', 335, NULL, 'df', 'dg', 435, 'Pending', 10, 'dfsd dfdf', 'v', 'dfg', 0, 'df', NULL, NULL, NULL, '2020-06-19 09:58:55', '2020-06-19 09:58:55'),
(4, 'fg', 'dfgfdg', 456, NULL, 'fgf', 'fg', 456, 'Pending', 1, '', 'fg', 'fg', 0, 'fg', NULL, NULL, NULL, '2020-06-21 01:41:15', '2020-06-21 01:41:15'),
(5, 'erwer', 'bgfg', 234, NULL, 'ssddf', 'sdsdf', 43, 'Pending', 10, '', 'sdsfd', 'sdff', 0, 'sdsff', NULL, NULL, NULL, '2020-06-21 03:15:26', '2020-06-21 03:15:26'),
(6, 'er', 'sdf', 234, NULL, 'sdf', 'ss', 234, 'Pending', 1, 'we', 'wr', 'wrer', 23, 'sd', NULL, NULL, NULL, '2020-06-22 09:05:27', '2020-06-22 09:05:27'),
(7, 'er', 'sdf', 234, NULL, 'sdf', 'ss', 234, 'Pending', 1, 'we', 'wr', 'wrer', 23, 'sd', NULL, NULL, NULL, '2020-06-22 09:07:47', '2020-06-22 09:07:47'),
(8, 'dg', 'dg', 32, NULL, 'ddf', 'dgd', 34, 'Pending', 1, 'dfd', 'df', 'dgg', 22, 'ssf', NULL, NULL, NULL, '2020-06-22 09:10:04', '2020-06-22 09:10:04'),
(9, 'dg', 'dg', 32, NULL, 'ddf', 'dgd', 34, 'Pending', 1, 'dfd', 'df', 'dgg', 22, 'ssf', NULL, NULL, NULL, '2020-06-22 09:13:24', '2020-06-22 09:13:24'),
(10, 'sddds', 'sd', 23, NULL, 'sdfd', 'sd', 22, 'Pending', 1, 'sd', '33sdd', 'sdf', 27, 'se', NULL, NULL, NULL, '2020-06-22 09:20:46', '2020-06-22 09:20:46'),
(11, 'dsf', 'fdg', 34, NULL, 'dfd', 'gf', 34, 'Pending', 1, 'fds', 'sf', 'fdg', 42, 'dxff', NULL, NULL, NULL, '2020-06-22 09:29:16', '2020-06-22 09:29:16'),
(12, 'neww', 'sdsd', 22, 'demo', 'demo', 'demo', 121, 'Pending', 1, 'jhjsd', 'sdds', 'sd', 23, 'demooo', NULL, NULL, 0, '2020-06-24 02:18:37', '2020-06-24 02:18:37'),
(13, 'neww product', 'sdf', 22, 'dcsd', 'sdf', 'sdf', 213, 'Pending', 1, 'dsd', 'sd', 'sdf', 21, 'sds', NULL, NULL, 0, '2020-06-24 02:20:49', '2020-06-24 02:20:49'),
(14, 'ert', 'sdf', 34, 'sdf', 'sdf', 'sfd', 22, 'Pending', 1, 'etr', 'erer', 'et', 31, 'wer', NULL, NULL, 0, '2020-06-24 02:26:03', '2020-06-24 02:26:03'),
(15, 'ert', 'sdf', 34, 'sdf', 'sdf', 'sfd', 22, 'Pending', 1, 'etr', 'erer', 'et', 31, 'wer', NULL, NULL, 0, '2020-06-24 02:26:35', '2020-06-24 02:26:35'),
(16, 'df', 'sdf', 23, 'sdf', 'sdf', 'vdf', 32, 'Pending', 1, 'sdf', 'sdf', 'sdf', 3, 'sd', 4, NULL, 0, '2020-06-24 02:27:35', '2020-06-24 02:27:35'),
(17, 'nfsdhhj', 'dn,nlkd', 2332, 'fdg', 'dfg', 'dfg', 444, 'Pending', 10, 'dhgj', 'jhsgdj', 'jhskdj', 32, 'sjhdghj', 4, NULL, 0, '2020-06-25 07:52:01', '2020-06-25 07:52:01'),
(18, 'df', 'ddfdf', 31, 'sdf', 'sdf', 'sdf', 234, 'Pending', 1, 'sdf', 'sd', 'sdf', 34, 'df', 4, NULL, 0, '2020-06-25 09:16:33', '2020-06-25 09:16:33');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `created_at`, `updated_at`) VALUES
(2, 5, '/uploads/1592730830.jpeg', NULL, NULL),
(3, 6, '/uploads/1592838205.jpeg', NULL, NULL),
(4, 7, '/uploads/1592838205.jpeg', NULL, NULL),
(5, 8, '/uploads/1592838586.jpeg', NULL, NULL),
(6, 11, '/uploads/1592839734.jpeg', NULL, NULL),
(7, 12, '/uploads/1592986689.png', NULL, NULL),
(9, 13, '/uploads/1592986839.jpeg', NULL, NULL),
(10, 14, '/uploads/1592987127.png', NULL, NULL),
(11, 16, '/uploads/1592987249.png', NULL, NULL),
(12, 17, '/uploads/1593093094.jpeg', NULL, NULL),
(15, 18, '/uploads/1593098180.jpeg', NULL, NULL),
(16, 18, '/uploads/1593098186.jpeg', NULL, NULL),
(17, 19, '/uploads/1593157987.jpeg', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `reporter_id`, `product_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 4, 18, 'hjgjfhgfhg', '2020-06-28 02:06:34', '2020-06-28 02:06:34'),
(2, 4, 18, 'hjgjfhgfhg', '2020-06-28 02:06:34', '2020-06-28 02:06:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'User',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `userType`, `phone`, `address`, `city`, `state`, `zip_code`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '$2y$10$XZBtXe9V1.bmUq3c2NG9e.VkN6VfMqi6UvwCqWq4bBog2SNl.L76.', 'Admin', '026387332', '', '', '', 0, NULL, '2020-06-19 22:56:57'),
(2, 'New user', 'user@gmail.com', '123456', 'User', '12980982', 'demo1', 'demo1', 'demo1', 123, NULL, NULL),
(3, 'df', 'demo2@gmail.com', '$2y$10$y3dRg38y31kZfIFzZB2XkuoyMQtqS9XgqDYlfJJVPEnpK9JE3k0g2', 'User', '234', 'sdfsdff', 'dsf', 'sdsfdf', 234, '2020-06-20 22:14:55', '2020-06-20 22:14:55'),
(4, 'Peru', 'peru@gmail.com', '$2y$10$6DOe/TCH9SSfnu8xTTk2/e1MaTZmjAaguIJx1tEIElCQgjEAz47.y', 'User', '342525', 'dsfsf bcbv', 'sdf', 'ssdfd', 234, '2020-06-23 09:49:57', '2020-06-24 05:59:41'),
(5, 'new', 'new@gmail.com', '$2y$10$n736BACcwh.z4OWYtDoiR.R8HJEfnL2hJjJVEM8bffem5c4TLHJwi', 'User', '32878932', 'bmsnd', 'dsf', 'df', 323, '2020-06-28 13:04:52', '2020-06-28 13:04:52');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `isTrue` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `product_id`, `isTrue`, `created_at`, `updated_at`) VALUES
(1, 4, 18, 0, '2020-06-25 10:13:50', '2020-06-26 02:04:33'),
(2, 4, 17, 1, '2020-06-25 10:14:32', '2020-06-28 12:59:27'),
(3, 4, 16, 1, '2020-06-26 01:01:35', '2020-06-28 12:59:24'),
(7, 4, 13, 1, '2020-06-26 02:22:36', '2020-06-26 02:22:36'),
(8, 4, 12, 1, '2020-06-26 02:22:47', '2020-06-26 02:22:47'),
(9, 4, 14, 0, '2020-06-28 13:02:42', '2020-06-28 13:02:57'),
(10, 4, 15, 1, '2020-06-28 13:02:55', '2020-06-28 13:02:55'),
(11, 5, 18, 1, '2020-06-28 13:06:09', '2020-06-28 13:06:09'),
(12, 5, 17, 1, '2020-06-28 13:06:12', '2020-06-28 13:06:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
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
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
