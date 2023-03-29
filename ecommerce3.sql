-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 29 مارس 2023 الساعة 20:47
-- إصدار الخادم: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce3`
--

-- --------------------------------------------------------

--
-- بنية الجدول `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_role_id` bigint(20) NOT NULL DEFAULT 2,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `admins`
--

INSERT INTO `admins` (`id`, `name`, `phone`, `admin_role_id`, `image`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Edraak software', '0597051897', 1, 'def.png', 'edraaksoft@gmail.com', NULL, '$2y$10$HZOdH3CyLPrDgAo1pTJk1ec09ST0kNrLH79PneyxfeMNDyEIgp6e6', '2KQrAfoMryN9MKOl7kbGMEeamCUbUnytPp9Ug2l8DHuJ4UM828YSscEwHrqa', '2022-12-28 22:45:04', '2022-12-28 22:45:04', 1);

-- --------------------------------------------------------

--
-- بنية الجدول `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module_access` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `module_access`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Master Admin', NULL, 1, NULL, NULL),
(2, 'admin', '[\"dashboard\",\"order_management\",\"product_management\",\"promotion_management\",\"support_section\",\"report\",\"user_section\",\"system_settings\"]', 1, '2023-03-23 18:35:33', '2023-03-23 18:35:33');

-- --------------------------------------------------------

--
-- بنية الجدول `admin_wallets`
--

CREATE TABLE `admin_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `inhouse_earning` double NOT NULL DEFAULT 0,
  `withdrawn` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `commission_earned` double(8,2) NOT NULL DEFAULT 0.00,
  `delivery_charge_earned` double(8,2) NOT NULL DEFAULT 0.00,
  `pending_amount` double(8,2) NOT NULL DEFAULT 0.00,
  `total_tax_collected` double(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `admin_wallets`
--

INSERT INTO `admin_wallets` (`id`, `admin_id`, `inhouse_earning`, `withdrawn`, `created_at`, `updated_at`, `commission_earned`, `delivery_charge_earned`, `pending_amount`, `total_tax_collected`) VALUES
(1, 1, 0, 0, NULL, NULL, 0.00, 0.00, 0.00, 0.00),
(2, 1, 0, 0, '2022-12-28 22:45:04', '2022-12-28 22:45:04', 0.00, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- بنية الجدول `admin_wallet_histories`
--

CREATE TABLE `admin_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `payment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'received',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `advertis`
--

CREATE TABLE `advertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`image`)),
  `career_sector_id` bigint(20) UNSIGNED NOT NULL,
  `job_title_id` bigint(20) UNSIGNED NOT NULL,
  `advertise_type_id` bigint(20) UNSIGNED NOT NULL,
  `education_degree_id` bigint(20) UNSIGNED NOT NULL,
  `type_contract_id` bigint(20) UNSIGNED NOT NULL,
  `work_day_id` bigint(20) UNSIGNED NOT NULL,
  `type_work_hour_id` bigint(20) UNSIGNED NOT NULL,
  `salary_id` bigint(20) UNSIGNED DEFAULT NULL,
  `experience_id` bigint(20) UNSIGNED NOT NULL,
  `nationality_id` bigint(20) UNSIGNED NOT NULL,
  `city_advertis_id` bigint(20) UNSIGNED NOT NULL,
  `state_advertis_id` bigint(20) UNSIGNED NOT NULL,
  `work_from_home` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `job_requires_vehicle` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `Require_driver_license` enum('Yes','No') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `expected_salary` double(8,2) UNSIGNED DEFAULT NULL,
  `gender` enum('male','female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male',
  `governorates_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('Active','InActive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'InActive',
  `actor_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actor_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertis`
--

INSERT INTO `advertis` (`id`, `name`, `description`, `image`, `career_sector_id`, `job_title_id`, `advertise_type_id`, `education_degree_id`, `type_contract_id`, `work_day_id`, `type_work_hour_id`, `salary_id`, `experience_id`, `nationality_id`, `city_advertis_id`, `state_advertis_id`, `work_from_home`, `job_requires_vehicle`, `Require_driver_license`, `expected_salary`, `gender`, `governorates_id`, `created_at`, `updated_at`, `status`, `actor_type`, `actor_id`) VALUES
(7, 'sad', '<p>xczzxc</p>', '[\"FzNnvN9woTzYbMMetD1Xl5pvWKqoFlK18RHurHgd.png\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 33.00, 'male', 1, '2023-01-02 20:35:03', '2023-03-17 00:14:05', 'InActive', 'App\\Model\\Admin', 1),
(8, 'xzczxc', '<p>xcvxcvcxvxcv</p>', '[\"pGadSO7ufq3itjAbGJxLhxjqDCrfyjn9rxGNtjqQ.png\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 22.00, 'male', 1, '2023-01-02 20:37:08', '2023-03-16 18:57:09', 'InActive', 'App\\Model\\Admin', 1),
(26, 'cxvxcvbbbbbbbbb', '<p>cxvxcvbbbbbbbbb</p>', '[\"4qnNDLy1yj81dFrRVWX7yXg5jukNDNsey5HEXMXM.png\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 88.00, 'male', 1, '2023-02-10 23:58:10', '2023-03-16 18:57:10', 'InActive', 'App\\Model\\Admin', 1),
(24, 'xczxczxc', '<p>zxczxcxzc</p>', '[\"GvA6aSJTkgyTfeIfNxqXPVb8sqsf4yMyHUvxcyDj.png\"]', 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 11.00, 'female', 1, '2023-02-10 23:20:05', '2023-03-16 18:57:09', 'InActive', 'App\\Model\\Admin', 1),
(25, 'yyyyyyyyyyyyy', '<p>yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy</p>', '[\"ZuxyxPdCwwhPoiiQ5HoWxuJ4nQY7bJMzrs83LNrl.png\",\"oXlOoc1ubwQ4QEUw5q8qw6DTKrFiRsz9CTwP7KOL.png\"]', 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 4848.00, 'male', 1, '2023-02-10 23:30:02', '2023-03-15 16:31:14', 'InActive', 'App\\Model\\User', 3),
(22, 'xczc', '<p>asdasda</p>', NULL, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'No', 'Yes', 'Yes', 88.00, 'male', 1, '2023-02-10 22:43:57', '2023-02-10 22:43:57', 'InActive', 'App\\Model\\User', 3),
(23, 'bbbbbbbbbbbvvvvvvvvv', '<p><strong>bbbbbbbbbbbvvvvvvvvv</strong></p>', NULL, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 788.00, 'male', 1, '2023-02-10 23:17:20', '2023-02-10 23:21:28', 'InActive', 'App\\Model\\Admin', 1),
(17, 'mahmoud', '<p>mahmoudmahmoudmahmoud</p>', '[\"sD26ayYflACeOYpjloRgZi6fTdjiqpPaMS21Sgn9.jpg\", \"umMe6FTulFQVuX2o4AMcdHBxj9Q7M8Ii9uWF91ys.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 22.00, 'male', 1, '2023-01-19 14:26:16', '2023-03-15 16:31:12', 'InActive', 'App\\Model\\User', 1),
(27, 'مبرمج', '<p>laravel</p>', '[\"AKNCEoWpRZuLrmUnhte6yQnQB9FfTdvpqKyg44xD.webp\"]', 3, 2, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', 1, '2023-02-11 00:47:09', '2023-03-15 16:31:15', 'InActive', 'App\\Model\\User', 3),
(28, 'saddddddddddddddddddddddd', '<p>sadddddddddddddddddddddddsaddddddddddddddddddddddd</p>', '[\"pTcIFwHp4WjYhEDD57LXKyXAIPxRX0z1ZXXfGznt.webp\"]', 3, 2, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', NULL, '2023-02-11 01:12:31', '2023-02-11 01:12:31', 'InActive', 'App\\Model\\User', 3),
(104, 'note 10', '<p>note 10</p>', '[\"r5YUWk1TTiAcYVvlCdLpfwSf9iGhpjFMGZ4H4cFO.png\"]', 5, 6, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', NULL, '2023-03-28 17:48:30', '2023-03-28 17:48:45', 'Active', 'App\\Model\\Admin', 1),
(31, 'مبرمج 22222', 'قوووووة', NULL, 2, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, '', '', '', 1.00, 'male', 1, '2023-03-12 23:41:37', '2023-03-12 23:41:37', 'InActive', 'App\\Model\\User', 4),
(32, 'مبرمج 22222', 'قوووووة', NULL, 2, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, '', '', '', 1.00, 'male', 1, '2023-03-12 23:42:40', '2023-03-12 23:42:40', 'InActive', 'App\\Model\\User', 4),
(35, 'IT_TEST', 'قوووووة', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-12 23:56:13', '2023-03-15 16:31:31', 'InActive', 'App\\Model\\User', 4),
(36, 'اعلان تجريبي', '<p>اعلان تجريبي&nbsp;</p>', '[\"MFsK0GQZ2Aj6aVkSdS0f3tqSCzssO8MQL5rORLMs.jpg\",\"UVxcUX8sC6m6jr80rUIYRtRHoQcVl1o0ZPpG2Tjb.jpg\"]', 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', NULL, '2023-03-15 14:08:11', '2023-03-15 16:31:31', 'InActive', 'App\\Model\\User', 4),
(60, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', 1, '2023-03-16 18:38:32', '2023-03-16 18:38:32', 'InActive', 'App\\Model\\User', 4),
(43, 'IS_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-15 15:26:23', '2023-03-15 16:31:33', 'InActive', 'App\\Model\\User', 4),
(44, 'تجريبي 5', '<p>تجريبي 5</p>', '[\"uj1W7iLxdnuuwjrjkunwKjb6FBCrBN1GA39NTrDW.jpg\",\"FmD5F0Fff8bETDSwFecDMs4w3r3SmYUS0YjVzKBK.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 20000.00, 'male', 1, '2023-03-15 15:41:42', '2023-03-16 17:47:56', 'InActive', 'App\\Model\\User', 4),
(61, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', 1, '2023-03-16 18:42:08', '2023-03-16 18:42:08', 'InActive', 'App\\Model\\User', 4),
(56, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-16 18:02:16', '2023-03-16 18:02:16', 'InActive', 'App\\Model\\User', 4),
(57, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-16 18:11:28', '2023-03-16 18:11:28', 'InActive', 'App\\Model\\User', 4),
(58, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-16 18:37:52', '2023-03-16 18:37:52', 'InActive', 'App\\Model\\User', 4),
(59, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', 1, '2023-03-16 18:38:11', '2023-03-16 18:38:11', 'InActive', 'App\\Model\\User', 4),
(55, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 1.00, 'male', 1, '2023-03-16 17:49:26', '2023-03-16 18:58:52', 'InActive', 'App\\Model\\User', 4),
(62, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', NULL, '2023-03-16 18:42:23', '2023-03-24 02:06:58', 'Active', 'App\\Model\\User', 4),
(63, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', NULL, '2023-03-16 18:46:00', '2023-03-16 21:16:54', 'InActive', 'App\\Model\\User', 4),
(64, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 10000, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 2.00, 'male', NULL, '2023-03-16 19:03:34', '2023-03-16 19:03:34', 'InActive', 'App\\Model\\User', 4),
(65, 'cs_TEST', 'TEST', NULL, 20, 1, 1, 1, 1, 1, 1, 10000, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 2.00, 'male', NULL, '2023-03-16 19:03:53', '2023-03-16 19:03:53', 'InActive', 'App\\Model\\User', 4),
(66, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 10000, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 2.00, 'male', NULL, '2023-03-16 19:04:18', '2023-03-16 21:16:53', 'InActive', 'App\\Model\\User', 4),
(67, 'تجريبي ادمن', '<p>تجريبي ادمن</p>', '[\"gFDwNP6IsqFhanvQjfA26aGfounbPBfApp0btfdq.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'male', 1, '2023-03-16 19:12:09', '2023-03-16 19:13:12', 'InActive', 'App\\Model\\Admin', 1),
(68, 'تجريبي ادمن2', '<p>تجريبي ادمن2</p>', '[\"r170JPVgkAHLpGH2f3r6Vpi6lk3BSYh9C6cVT7EK.jpg\"]', 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'No', 'No', NULL, 'male', NULL, '2023-03-16 19:14:51', '2023-03-16 21:16:35', 'InActive', 'App\\Model\\Admin', 1),
(69, 'تجريبي ادمن3', '<p>تجريبي ادمن3</p>', '[\"p9O7nhkAzfZ3iwsQNOepU7R4B7kTZYp62V3RSRBj.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'No', 'No', 'No', 12000.00, 'male', 1, '2023-03-16 19:18:24', '2023-03-16 21:20:34', 'InActive', 'App\\Model\\Admin', 1),
(70, 'cs_TEST', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 10000, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 2.00, 'male', NULL, '2023-03-16 19:19:57', '2023-03-16 19:19:57', 'InActive', 'App\\Model\\User', 4),
(71, 'cs_TEST', 'TEST', NULL, 20, 1, 1, 1, 1, 1, 1, 10000, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 2.00, 'male', NULL, '2023-03-16 19:21:07', '2023-03-16 19:21:07', 'InActive', 'App\\Model\\User', 4),
(72, 'admin Advertisment', '<p>admin Advertisment&nbsp;</p>', '[\"846jd3FFvMWdyDu2sjY4gUt1rZj5bBRMBdENDUUU.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 15000.00, 'male', 1, '2023-03-16 21:19:31', '2023-03-16 23:13:13', 'InActive', 'App\\Model\\Admin', 1),
(73, 'customer', 'customer_TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 21:25:01', '2023-03-16 23:13:34', 'InActive', 'App\\Model\\User', 4),
(74, 'customer', 'customer_TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:08:52', '2023-03-16 23:08:52', 'InActive', 'App\\Model\\User', 4),
(75, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:09:42', '2023-03-16 23:24:01', 'InActive', 'App\\Model\\User', 4),
(76, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:18:06', '2023-03-24 02:09:39', 'Active', 'App\\Model\\User', 4),
(77, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:22:04', '2023-03-24 02:14:41', 'Active', 'App\\Model\\User', 4),
(78, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:22:47', '2023-03-16 23:22:47', 'InActive', 'App\\Model\\User', 4),
(79, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:23:14', '2023-03-16 23:23:14', 'InActive', 'App\\Model\\User', 4),
(80, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:23:30', '2023-03-16 23:23:30', 'InActive', 'App\\Model\\User', 4),
(81, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:23:41', '2023-03-16 23:25:24', 'InActive', 'App\\Model\\User', 4),
(82, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:24:48', '2023-03-16 23:24:48', 'InActive', 'App\\Model\\User', 4),
(83, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:25:19', '2023-03-16 23:27:43', 'InActive', 'App\\Model\\User', 4),
(84, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:27:36', '2023-03-16 23:28:37', 'InActive', 'App\\Model\\User', 4),
(85, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:28:30', '2023-03-16 23:30:01', 'InActive', 'App\\Model\\User', 4),
(86, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:29:50', '2023-03-16 23:30:55', 'InActive', 'App\\Model\\User', 4),
(87, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:30:38', '2023-03-16 23:33:03', 'InActive', 'App\\Model\\User', 4),
(88, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:32:22', '2023-03-16 23:32:22', 'InActive', 'App\\Model\\User', 4),
(89, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:32:45', '2023-03-16 23:32:45', 'InActive', 'App\\Model\\User', 4),
(90, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:33:10', '2023-03-16 23:37:22', 'InActive', 'App\\Model\\User', 4),
(91, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:34:42', '2023-03-16 23:34:42', 'InActive', 'App\\Model\\User', 4),
(92, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:35:10', '2023-03-16 23:35:10', 'InActive', 'App\\Model\\User', 4),
(93, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:36:12', '2023-03-16 23:36:12', 'InActive', 'App\\Model\\User', 4),
(94, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:36:46', '2023-03-16 23:36:46', 'InActive', 'App\\Model\\User', 4),
(95, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:36:58', '2023-03-16 23:38:32', 'InActive', 'App\\Model\\User', 4),
(96, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-16 23:38:28', '2023-03-16 23:39:51', 'InActive', 'App\\Model\\User', 4),
(97, 'kim', '<p>kim</p>', '[\"gFQWfVkrmpkUXrNxiAQpeduMGklnbRYFD0ZHwCDH.jpg\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', NULL, 'female', 1, '2023-03-17 00:13:44', '2023-03-17 21:40:40', 'Active', 'App\\Model\\Admin', 1),
(98, 'مطور انظمة', '<p>مطور انظمة للعمل لدى شركة برمجيات ال.....</p>', '[\"O5aB4eY1LuLOiYyfQfzU4mtEMHcwVIl3e0avZOaH.jpg\"]', 2, 1, 1, 1, 1, 1, 1, NULL, 1, 1, 1, 1, 'Yes', 'No', 'No', NULL, 'male', 1, '2023-03-17 18:40:47', '2023-03-17 18:43:53', 'Active', 'App\\Model\\User', 4),
(99, 'مبرمج ويب سيرفس', '<p>خبرة في api</p>\r\n\r\n<p>خبرة في postman</p>', '[\"66ElEVGfKIaBW4XBjU26MtTJP2hOfCMQTfLYOi4s.png\",\"7r7yquMMXI6l5cK5zYWPFieIU1iBJgyxDaZ2YCnB.png\"]', 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'No', 'No', 'No', 100000.00, 'male', 1, '2023-03-23 19:32:17', '2023-03-23 19:32:55', 'Active', 'App\\Model\\User', 4),
(100, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-24 01:24:39', '2023-03-24 01:24:39', 'InActive', 'App\\Model\\User', 4),
(101, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-26 15:58:06', '2023-03-26 15:58:06', 'InActive', 'App\\Model\\User', 4),
(102, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-26 15:59:39', '2023-03-26 15:59:39', 'InActive', 'App\\Model\\User', 4),
(103, 'customer', 'TEST', NULL, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'Yes', 'Yes', 'Yes', 200000.00, 'male', NULL, '2023-03-26 16:07:45', '2023-03-26 16:07:45', 'InActive', 'App\\Model\\User', 4);

-- --------------------------------------------------------

--
-- بنية الجدول `advertise_types`
--

CREATE TABLE `advertise_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertise_types`
--

INSERT INTO `advertise_types` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'شركة', NULL, '2023-01-01 19:46:59', '2023-03-13 19:56:18'),
(2, 'organized', NULL, '2023-03-17 17:59:45', '2023-03-17 17:59:45');

-- --------------------------------------------------------

--
-- بنية الجدول `advertis_extra_benefit`
--

CREATE TABLE `advertis_extra_benefit` (
  `advertis_id` bigint(20) UNSIGNED NOT NULL,
  `extra_benefit_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertis_extra_benefit`
--

INSERT INTO `advertis_extra_benefit` (`advertis_id`, `extra_benefit_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(2, 1, NULL, NULL),
(3, 1, NULL, NULL),
(4, 1, NULL, NULL),
(5, 1, NULL, NULL),
(6, 1, NULL, NULL),
(7, 1, NULL, NULL),
(8, 1, NULL, NULL),
(9, 1, NULL, NULL),
(10, 1, NULL, NULL),
(11, 1, NULL, NULL),
(12, 1, NULL, NULL),
(13, 1, NULL, NULL),
(14, 1, NULL, NULL),
(15, 1, NULL, NULL),
(16, 1, NULL, NULL),
(17, 1, NULL, NULL),
(18, 1, NULL, NULL),
(19, 1, NULL, NULL),
(20, 1, NULL, NULL),
(21, 1, NULL, NULL),
(22, 1, NULL, NULL),
(23, 1, NULL, NULL),
(24, 1, NULL, NULL),
(25, 1, NULL, NULL),
(26, 1, NULL, NULL),
(27, 1, NULL, NULL),
(28, 1, NULL, NULL),
(29, 1, NULL, NULL),
(30, 1, NULL, NULL),
(31, 1, NULL, NULL),
(32, 1, NULL, NULL),
(33, 1, NULL, NULL),
(34, 1, NULL, NULL),
(35, 1, NULL, NULL),
(36, 1, NULL, NULL),
(44, 1, NULL, NULL),
(67, 1, NULL, NULL),
(68, 1, NULL, NULL),
(69, 1, NULL, NULL),
(72, 1, NULL, NULL),
(95, 1, NULL, NULL),
(96, 1, NULL, NULL),
(97, 1, NULL, NULL),
(98, 1, NULL, NULL),
(99, 1, NULL, NULL),
(100, 1, NULL, NULL),
(101, 1, NULL, NULL),
(102, 1, NULL, NULL),
(103, 1, NULL, NULL),
(104, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `advertis_language`
--

CREATE TABLE `advertis_language` (
  `advertis_id` bigint(20) UNSIGNED NOT NULL,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertis_language`
--

INSERT INTO `advertis_language` (`advertis_id`, `language_id`, `created_at`, `updated_at`) VALUES
(9, 1, NULL, NULL),
(10, 1, NULL, NULL),
(11, 1, NULL, NULL),
(12, 1, NULL, NULL),
(13, 1, NULL, NULL),
(14, 1, NULL, NULL),
(15, 1, NULL, NULL),
(16, 1, NULL, NULL),
(17, 1, NULL, NULL),
(18, 1, NULL, NULL),
(19, 1, NULL, NULL),
(20, 1, NULL, NULL),
(21, 1, NULL, NULL),
(22, 1, NULL, NULL),
(23, 1, NULL, NULL),
(24, 1, NULL, NULL),
(25, 1, NULL, NULL),
(26, 1, NULL, NULL),
(29, 1, NULL, NULL),
(30, 1, NULL, NULL),
(31, 1, NULL, NULL),
(32, 1, NULL, NULL),
(33, 1, NULL, NULL),
(34, 1, NULL, NULL),
(35, 1, NULL, NULL),
(36, 1, NULL, NULL),
(44, 1, NULL, NULL),
(67, 1, NULL, NULL),
(68, 1, NULL, NULL),
(68, 2, NULL, NULL),
(69, 1, NULL, NULL),
(69, 2, NULL, NULL),
(72, 1, NULL, NULL),
(72, 2, NULL, NULL),
(96, 1, NULL, NULL),
(97, 1, NULL, NULL),
(98, 1, NULL, NULL),
(99, 1, NULL, NULL),
(100, 1, NULL, NULL),
(101, 1, NULL, NULL),
(102, 1, NULL, NULL),
(103, 1, NULL, NULL),
(104, 1, NULL, NULL),
(104, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `advertis_license`
--

CREATE TABLE `advertis_license` (
  `advertis_id` bigint(20) UNSIGNED NOT NULL,
  `license_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertis_license`
--

INSERT INTO `advertis_license` (`advertis_id`, `license_id`, `created_at`, `updated_at`) VALUES
(9, 1, NULL, NULL),
(10, 1, NULL, NULL),
(11, 1, NULL, NULL),
(12, 1, NULL, NULL),
(13, 1, NULL, NULL),
(14, 1, NULL, NULL),
(15, 1, NULL, NULL),
(16, 1, NULL, NULL),
(17, 1, NULL, NULL),
(18, 1, NULL, NULL),
(19, 1, NULL, NULL),
(20, 1, NULL, NULL),
(21, 1, NULL, NULL),
(22, 1, NULL, NULL),
(23, 1, NULL, NULL),
(24, 1, NULL, NULL),
(25, 1, NULL, NULL),
(26, 1, NULL, NULL),
(29, 1, NULL, NULL),
(30, 1, NULL, NULL),
(31, 1, NULL, NULL),
(32, 1, NULL, NULL),
(33, 1, NULL, NULL),
(34, 1, NULL, NULL),
(35, 1, NULL, NULL),
(36, 1, NULL, NULL),
(44, 1, NULL, NULL),
(67, 1, NULL, NULL),
(68, 1, NULL, NULL),
(69, 1, NULL, NULL),
(72, 1, NULL, NULL),
(95, 1, NULL, NULL),
(96, 1, NULL, NULL),
(99, 1, NULL, NULL),
(100, 1, NULL, NULL),
(101, 1, NULL, NULL),
(102, 1, NULL, NULL),
(103, 1, NULL, NULL),
(104, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `advertis_skill`
--

CREATE TABLE `advertis_skill` (
  `advertis_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `advertis_skill`
--

INSERT INTO `advertis_skill` (`advertis_id`, `skill_id`, `created_at`, `updated_at`) VALUES
(9, 1, NULL, NULL),
(10, 1, NULL, NULL),
(11, 1, NULL, NULL),
(12, 1, NULL, NULL),
(13, 1, NULL, NULL),
(14, 1, NULL, NULL),
(15, 1, NULL, NULL),
(16, 1, NULL, NULL),
(17, 1, NULL, NULL),
(18, 1, NULL, NULL),
(19, 1, NULL, NULL),
(20, 1, NULL, NULL),
(21, 1, NULL, NULL),
(22, 1, NULL, NULL),
(23, 1, NULL, NULL),
(24, 1, NULL, NULL),
(25, 1, NULL, NULL),
(26, 1, NULL, NULL),
(29, 1, NULL, NULL),
(30, 1, NULL, NULL),
(31, 1, NULL, NULL),
(32, 1, NULL, NULL),
(33, 1, NULL, NULL),
(34, 1, NULL, NULL),
(35, 1, NULL, NULL),
(36, 1, NULL, NULL),
(44, 1, NULL, NULL),
(72, 1, NULL, NULL),
(85, 1, NULL, NULL),
(89, 1, NULL, NULL),
(90, 1, NULL, NULL),
(91, 1, NULL, NULL),
(95, 1, NULL, NULL),
(96, 1, NULL, NULL),
(97, 1, NULL, NULL),
(99, 1, NULL, NULL),
(99, 2, NULL, NULL),
(100, 1, NULL, NULL),
(101, 1, NULL, NULL),
(102, 1, NULL, NULL),
(103, 1, NULL, NULL),
(104, 1, NULL, NULL),
(104, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `banners`
--

CREATE TABLE `banners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `banners`
--

INSERT INTO `banners` (`id`, `photo`, `banner_type`, `published`, `created_at`, `updated_at`, `url`, `resource_type`, `resource_id`) VALUES
(1, '2023-03-23-641cc18edd6db.png', 'Main Banner', 1, '2023-03-23 18:15:58', '2023-03-23 18:26:58', 'http://localhost:8080/ecommerce3/shopView/1', 'shop', 1);

-- --------------------------------------------------------

--
-- بنية الجدول `billing_addresses`
--

CREATE TABLE `billing_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contact_person_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` int(10) UNSIGNED DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `brands`
--

INSERT INTO `brands` (`id`, `name`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'scoda', '2023-01-04-63b5b6febff2a.png', 1, '2023-01-04 21:27:26', '2023-01-04 21:27:26');

-- --------------------------------------------------------

--
-- بنية الجدول `business_settings`
--

CREATE TABLE `business_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `business_settings`
--

INSERT INTO `business_settings` (`id`, `type`, `value`, `created_at`, `updated_at`) VALUES
(1, 'system_default_currency', '1', '2020-10-11 07:43:44', '2021-06-04 18:25:29'),
(2, 'language', '[{\"id\":\"1\",\"name\":\"english\",\"direction\":\"ltr\",\"code\":\"en\",\"status\":1,\"default\":true},{\"id\":3,\"name\":\"Arabic\",\"direction\":\"rtl\",\"code\":\"ye\",\"status\":1,\"default\":false}]', '2020-10-11 07:53:02', '2023-01-19 13:46:47'),
(3, 'mail_config', '{\"status\":0,\"name\":\"demo\",\"host\":\"mail.demo.com\",\"driver\":\"SMTP\",\"port\":\"587\",\"username\":\"info@demo.com\",\"email_id\":\"info@demo.com\",\"encryption\":\"TLS\",\"password\":\"demo\"}', '2020-10-12 10:29:18', '2021-07-06 12:32:01'),
(4, 'cash_on_delivery', '{\"status\":\"1\"}', NULL, '2021-05-25 21:21:15'),
(6, 'ssl_commerz_payment', '{\"status\":\"0\",\"environment\":\"sandbox\",\"store_id\":\"\",\"store_password\":\"\"}', '2020-11-09 08:36:51', '2022-12-28 23:18:11'),
(7, 'paypal', '{\"status\":\"0\",\"environment\":\"sandbox\",\"paypal_client_id\":\"\",\"paypal_secret\":\"\"}', '2020-11-09 08:51:39', '2022-12-28 23:18:11'),
(8, 'stripe', '{\"status\":\"0\",\"api_key\":null,\"published_key\":null}', '2020-11-09 09:01:47', '2021-07-06 12:30:05'),
(10, 'company_phone', '776539779', NULL, '2020-12-08 14:15:01'),
(11, 'company_name', 'Edraak software', NULL, '2021-02-27 18:11:53'),
(12, 'company_web_logo', '2021-05-25-60ad1b313a9d4.png', NULL, '2021-05-25 21:43:45'),
(13, 'company_mobile_logo', '2021-02-20-6030c88c91911.png', NULL, '2021-02-20 14:30:04'),
(14, 'terms_condition', '<p>terms and conditions</p>', NULL, '2021-06-11 01:51:36'),
(15, 'about_us', '<p>this is about us page. hello and hi from about page description..</p>', NULL, '2021-06-11 01:42:53'),
(16, 'sms_nexmo', '{\"status\":\"0\",\"nexmo_key\":\"custo5cc042f7abf4c\",\"nexmo_secret\":\"custo5cc042f7abf4c@ssl\"}', NULL, NULL),
(17, 'company_email', 'wev707wkim@gmail.com', NULL, '2021-03-15 12:29:51'),
(18, 'colors', '{\"primary\":\"#1b7fed\",\"secondary\":\"#000000\"}', '2020-10-11 13:53:02', '2023-03-14 01:11:30'),
(19, 'company_footer_logo', '2021-02-20-6030c8a02a5f9.png', NULL, '2021-02-20 14:30:24'),
(20, 'company_copyright_text', 'CopyRight Edraak Soft@2023', NULL, '2021-03-15 12:30:47'),
(21, 'download_app_apple_stroe', '{\"status\":\"1\",\"link\":\"https:\\/\\/www.target.com\\/s\\/apple+store++now?ref=tgt_adv_XS000000&AFID=msn&fndsrc=tgtao&DFA=71700000012505188&CPNG=Electronics_Portable+Computers&adgroup=Portable+Computers&LID=700000001176246&LNM=apple+store+near+me+now&MT=b&network=s&device=c&location=12&targetid=kwd-81913773633608:loc-12&ds_rl=1246978&ds_rl=1248099&gclsrc=ds\"}', NULL, '2020-12-08 12:54:53'),
(22, 'download_app_google_stroe', '{\"status\":\"1\",\"link\":\"https:\\/\\/play.google.com\\/store?hl=en_US&gl=US\"}', NULL, '2020-12-08 12:54:48'),
(23, 'company_fav_icon', '2021-03-02-603df1634614f.png', '2020-10-11 13:53:02', '2021-03-02 14:03:48'),
(24, 'fcm_topic', '', NULL, NULL),
(25, 'fcm_project_id', '', NULL, NULL),
(26, 'push_notification_key', 'Put your firebase server key here.', NULL, NULL),
(27, 'order_pending_message', '{\"status\":\"1\",\"message\":\"order pen message\"}', NULL, NULL),
(28, 'order_confirmation_msg', '{\"status\":\"1\",\"message\":\"Order con Message\"}', NULL, NULL),
(29, 'order_processing_message', '{\"status\":\"1\",\"message\":\"Order pro Message\"}', NULL, NULL),
(30, 'out_for_delivery_message', '{\"status\":\"1\",\"message\":\"Order ouut Message\"}', NULL, NULL),
(31, 'order_delivered_message', '{\"status\":\"1\",\"message\":\"Order del Message\"}', NULL, NULL),
(32, 'razor_pay', '{\"status\":\"0\",\"razor_key\":null,\"razor_secret\":null}', NULL, '2021-07-06 12:30:14'),
(33, 'sales_commission', '5', NULL, '2023-03-23 17:37:07'),
(34, 'seller_registration', '1', NULL, '2021-06-04 21:02:48'),
(35, 'pnc_language', '[\"en\",\"ye\"]', NULL, NULL),
(36, 'order_returned_message', '{\"status\":\"1\",\"message\":\"Order hh Message\"}', NULL, NULL),
(37, 'order_failed_message', '{\"status\":null,\"message\":\"Order fa Message\"}', NULL, NULL),
(40, 'delivery_boy_assign_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(41, 'delivery_boy_start_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(42, 'delivery_boy_delivered_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(43, 'terms_and_conditions', '', NULL, NULL),
(44, 'minimum_order_value', '1', NULL, NULL),
(45, 'privacy_policy', '<p>my privacy policy</p>\r\n\r\n<p>&nbsp;</p>', NULL, '2021-07-06 11:09:07'),
(46, 'paystack', '{\"status\":\"0\",\"publicKey\":null,\"secretKey\":null,\"paymentUrl\":\"https:\\/\\/api.paystack.co\",\"merchantEmail\":null}', NULL, '2021-07-06 12:30:35'),
(47, 'senang_pay', '{\"status\":\"0\",\"secret_key\":null,\"merchant_id\":null}', NULL, '2021-07-06 12:30:23'),
(48, 'currency_model', 'multi_currency', NULL, NULL),
(49, 'social_login', '[{\"login_medium\":\"google\",\"client_id\":\"\",\"client_secret\":\"\",\"status\":\"\"},{\"login_medium\":\"facebook\",\"client_id\":\"\",\"client_secret\":\"\",\"status\":\"\"}]', NULL, NULL),
(50, 'digital_payment', '{\"status\":\"1\"}', NULL, NULL),
(51, 'phone_verification', '0', NULL, NULL),
(52, 'email_verification', '0', NULL, NULL),
(53, 'order_verification', '0', NULL, NULL),
(54, 'country_code', 'YE', NULL, NULL),
(55, 'pagination_limit', '10', NULL, NULL),
(56, 'shipping_method', 'inhouse_shipping', NULL, NULL),
(57, 'paymob_accept', '{\"status\":\"0\",\"api_key\":\"\",\"iframe_id\":\"\",\"integration_id\":\"\",\"hmac\":\"\"}', NULL, NULL),
(58, 'bkash', '{\"status\":\"0\",\"environment\":\"sandbox\",\"api_key\":\"\",\"api_secret\":\"\",\"username\":\"\",\"password\":\"\"}', NULL, '2022-12-28 23:18:11'),
(59, 'forgot_password_verification', 'email', NULL, NULL),
(60, 'paytabs', '{\"status\":0,\"profile_id\":\"\",\"server_key\":\"\",\"base_url\":\"https:\\/\\/secure-egypt.paytabs.com\\/\"}', NULL, '2021-11-21 03:01:40'),
(61, 'stock_limit', '10', NULL, NULL),
(62, 'flutterwave', '{\"status\":1,\"public_key\":\"\",\"secret_key\":\"\",\"hash\":\"\"}', NULL, NULL),
(63, 'mercadopago', '{\"status\":1,\"public_key\":\"\",\"access_token\":\"\"}', NULL, NULL),
(64, 'announcement', '{\"status\":\"1\",\"color\":\"#c9b84a\",\"text_color\":\"#ffffff\",\"announcement\":\"\\u0634\\u0643\\u0631\\u0627\\u064b \\u0644\\u0643\\u0645 \\u0644\\u0632\\u064a\\u0627\\u0631\\u0629 \\u0645\\u062a\\u062c\\u0631\\u0646\\u0627. \\u062d\\u0645\\u0644 \\u0627\\u0644\\u062a\\u0637\\u0628\\u064a\\u0642\\u0627\\u062a \\u0648\\u0627\\u0633\\u062a\\u0645\\u062a\\u0639 \\u0628\\u062e\\u0635\\u0648\\u0645\\u0627\\u062a \\u0648\\u0643\\u0648\\u0628\\u0648\\u0646\\u0627\\u062a\"}', NULL, NULL),
(65, 'fawry_pay', '{\"status\":0,\"merchant_code\":\"\",\"security_key\":\"\"}', NULL, '2022-01-18 09:46:30'),
(66, 'recaptcha', '{\"status\":0,\"site_key\":\"\",\"secret_key\":\"\"}', NULL, '2022-01-18 09:46:30'),
(67, 'seller_pos', '0', NULL, NULL),
(68, 'liqpay', '{\"status\":0,\"public_key\":\"\",\"private_key\":\"\"}', NULL, NULL),
(69, 'paytm', '{\"status\":0,\"environment\":\"sandbox\",\"paytm_merchant_key\":\"\",\"paytm_merchant_mid\":\"\",\"paytm_merchant_website\":\"\",\"paytm_refund_url\":\"\"}', NULL, '2022-12-28 23:18:11'),
(70, 'refund_day_limit', '3', NULL, NULL),
(71, 'business_mode', 'multi', NULL, NULL),
(72, 'mail_config_sendgrid', '{\"status\":0,\"name\":\"\",\"host\":\"\",\"driver\":\"\",\"port\":\"\",\"username\":\"\",\"email_id\":\"\",\"encryption\":\"\",\"password\":\"\"}', NULL, NULL),
(73, 'decimal_point_settings', '2', NULL, NULL),
(74, 'shop_address', 'صنعاء', NULL, NULL),
(75, 'billing_input_by_customer', '1', NULL, NULL),
(76, 'wallet_status', '1', NULL, NULL),
(77, 'loyalty_point_status', '1', NULL, NULL),
(78, 'wallet_add_refund', '1', NULL, NULL),
(79, 'loyalty_point_exchange_rate', '1', NULL, NULL),
(80, 'loyalty_point_item_purchase_point', '0', NULL, NULL),
(81, 'loyalty_point_minimum_point', '0', NULL, NULL),
(82, 'minimum_order_limit', '1', NULL, NULL),
(83, 'product_brand', '1', NULL, NULL),
(84, 'digital_product', '1', NULL, NULL),
(85, 'delivery_boy_expected_delivery_date_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(86, 'order_canceled', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(87, 'timezone', 'UTC', NULL, NULL),
(88, 'default_location', '{\"lat\":null,\"lng\":null}', NULL, NULL),
(89, 'delivery_country_restriction', '0', NULL, '2023-03-13 19:16:13'),
(90, 'shop_banner', '2023-03-23-641cd1c453d37.png', NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `career_sectors`
--

CREATE TABLE `career_sectors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `career_sectors`
--

INSERT INTO `career_sectors` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(2, 'مطور انظمة', NULL, '2023-01-01 19:35:22', '2023-03-13 19:55:20'),
(3, 'sc', NULL, '2023-02-07 23:23:17', '2023-02-07 23:23:17'),
(4, 'IS', NULL, '2023-03-17 23:39:22', '2023-03-17 23:39:22'),
(5, 'محاسبة', NULL, '2023-03-17 23:39:39', '2023-03-17 23:39:39'),
(6, 'ميكانيك', NULL, '2023-03-17 23:40:19', '2023-03-17 23:40:19'),
(7, 'كهرباء', NULL, '2023-03-17 23:40:31', '2023-03-17 23:40:31'),
(8, 'نجار', NULL, '2023-03-17 23:40:42', '2023-03-17 23:40:42'),
(9, 'سباك', NULL, '2023-03-17 23:41:08', '2023-03-17 23:41:08'),
(10, 'طباخ', NULL, '2023-03-17 23:41:28', '2023-03-17 23:41:28'),
(11, 'مهندس معماري', NULL, '2023-03-17 23:41:48', '2023-03-17 23:41:48'),
(12, 'مهندس نفط', NULL, '2023-03-17 23:42:14', '2023-03-17 23:42:14');

-- --------------------------------------------------------

--
-- بنية الجدول `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `cart_group_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `product_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'physical',
  `digital_product_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choices` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variations` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` double NOT NULL DEFAULT 1,
  `tax` double NOT NULL DEFAULT 1,
  `discount` double NOT NULL DEFAULT 1,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shop_info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_cost` double(8,2) DEFAULT NULL,
  `shipping_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `cart_shippings`
--

CREATE TABLE `cart_shippings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cart_group_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method_id` bigint(20) DEFAULT NULL,
  `shipping_cost` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `cart_shippings`
--

INSERT INTO `cart_shippings` (`id`, `cart_group_id`, `shipping_method_id`, `shipping_cost`, `created_at`, `updated_at`) VALUES
(1, '2-yGtdE-1673198916', 2, 5.00, '2023-01-08 21:30:23', '2023-01-08 21:30:23');

-- --------------------------------------------------------

--
-- بنية الجدول `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `home_status` tinyint(1) NOT NULL DEFAULT 0,
  `priority` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `icon`, `parent_id`, `position`, `created_at`, `updated_at`, `home_status`, `priority`) VALUES
(1, 'cars', 'cars', '2023-01-04-63b5b6be327f9.png', 0, 0, '2023-01-04 21:26:22', '2023-01-04 21:26:32', 1, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `category_shipping_costs`
--

CREATE TABLE `category_shipping_costs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `cost` double(8,2) DEFAULT NULL,
  `multiply_qty` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `category_shipping_costs`
--

INSERT INTO `category_shipping_costs` (`id`, `seller_id`, `category_id`, `cost`, `multiply_qty`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 0.00, NULL, '2023-03-13 19:13:55', '2023-03-13 19:13:55');

-- --------------------------------------------------------

--
-- بنية الجدول `chattings`
--

CREATE TABLE `chattings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `delivery_man_id` bigint(20) DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_by_customer` tinyint(1) NOT NULL DEFAULT 0,
  `sent_by_seller` tinyint(1) NOT NULL DEFAULT 0,
  `sent_by_admin` tinyint(1) DEFAULT NULL,
  `sent_by_delivery_man` tinyint(1) DEFAULT NULL,
  `seen_by_customer` tinyint(1) NOT NULL DEFAULT 1,
  `seen_by_seller` tinyint(1) NOT NULL DEFAULT 1,
  `seen_by_admin` tinyint(1) DEFAULT NULL,
  `seen_by_delivery_man` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `city_advertis`
--

CREATE TABLE `city_advertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_advertis_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `city_advertis`
--

INSERT INTO `city_advertis` (`id`, `name`, `description`, `state_advertis_id`, `created_at`, `updated_at`) VALUES
(1, 'صنعاء', NULL, 1, '2023-01-01 20:49:20', '2023-03-13 20:06:35');

-- --------------------------------------------------------

--
-- بنية الجدول `colors`
--

CREATE TABLE `colors` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `colors`
--

INSERT INTO `colors` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, 'IndianRed', '#CD5C5C', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(2, 'LightCoral', '#F08080', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(3, 'Salmon', '#FA8072', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(4, 'DarkSalmon', '#E9967A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(5, 'LightSalmon', '#FFA07A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(6, 'Crimson', '#DC143C', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(7, 'Red', '#FF0000', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(8, 'FireBrick', '#B22222', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(9, 'DarkRed', '#8B0000', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(10, 'Pink', '#FFC0CB', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(11, 'LightPink', '#FFB6C1', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(12, 'HotPink', '#FF69B4', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(13, 'DeepPink', '#FF1493', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(14, 'MediumVioletRed', '#C71585', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(15, 'PaleVioletRed', '#DB7093', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(16, 'LightSalmon', '#FFA07A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(17, 'Coral', '#FF7F50', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(18, 'Tomato', '#FF6347', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(19, 'OrangeRed', '#FF4500', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(20, 'DarkOrange', '#FF8C00', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(21, 'Orange', '#FFA500', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(22, 'Gold', '#FFD700', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(23, 'Yellow', '#FFFF00', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(24, 'LightYellow', '#FFFFE0', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(25, 'LemonChiffon', '#FFFACD', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(26, 'LightGoldenrodYellow', '#FAFAD2', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(27, 'PapayaWhip', '#FFEFD5', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(28, 'Moccasin', '#FFE4B5', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(29, 'PeachPuff', '#FFDAB9', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(30, 'PaleGoldenrod', '#EEE8AA', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(31, 'Khaki', '#F0E68C', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(32, 'DarkKhaki', '#BDB76B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(33, 'Lavender', '#E6E6FA', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(34, 'Thistle', '#D8BFD8', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(35, 'Plum', '#DDA0DD', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(36, 'Violet', '#EE82EE', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(37, 'Orchid', '#DA70D6', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(38, 'Fuchsia', '#FF00FF', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(39, 'Magenta', '#FF00FF', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(40, 'MediumOrchid', '#BA55D3', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(41, 'MediumPurple', '#9370DB', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(42, 'Amethyst', '#9966CC', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(43, 'BlueViolet', '#8A2BE2', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(44, 'DarkViolet', '#9400D3', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(45, 'DarkOrchid', '#9932CC', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(46, 'DarkMagenta', '#8B008B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(47, 'Purple', '#800080', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(48, 'Indigo', '#4B0082', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(49, 'SlateBlue', '#6A5ACD', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(50, 'DarkSlateBlue', '#483D8B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(51, 'MediumSlateBlue', '#7B68EE', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(52, 'GreenYellow', '#ADFF2F', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(53, 'Chartreuse', '#7FFF00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(54, 'LawnGreen', '#7CFC00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(55, 'Lime', '#00FF00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(56, 'LimeGreen', '#32CD32', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(57, 'PaleGreen', '#98FB98', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(58, 'LightGreen', '#90EE90', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(59, 'MediumSpringGreen', '#00FA9A', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(60, 'SpringGreen', '#00FF7F', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(61, 'MediumSeaGreen', '#3CB371', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(62, 'SeaGreen', '#2E8B57', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(63, 'ForestGreen', '#228B22', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(64, 'Green', '#008000', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(65, 'DarkGreen', '#006400', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(66, 'YellowGreen', '#9ACD32', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(67, 'OliveDrab', '#6B8E23', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(68, 'Olive', '#808000', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(69, 'DarkOliveGreen', '#556B2F', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(70, 'MediumAquamarine', '#66CDAA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(71, 'DarkSeaGreen', '#8FBC8F', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(72, 'LightSeaGreen', '#20B2AA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(73, 'DarkCyan', '#008B8B', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(74, 'Teal', '#008080', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(75, 'Aqua', '#00FFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(77, 'LightCyan', '#E0FFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(78, 'PaleTurquoise', '#AFEEEE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(79, 'Aquamarine', '#7FFFD4', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(80, 'Turquoise', '#40E0D0', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(81, 'MediumTurquoise', '#48D1CC', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(82, 'DarkTurquoise', '#00CED1', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(83, 'CadetBlue', '#5F9EA0', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(84, 'SteelBlue', '#4682B4', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(85, 'LightSteelBlue', '#B0C4DE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(86, 'PowderBlue', '#B0E0E6', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(87, 'LightBlue', '#ADD8E6', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(88, 'SkyBlue', '#87CEEB', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(89, 'LightSkyBlue', '#87CEFA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(90, 'DeepSkyBlue', '#00BFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(91, 'DodgerBlue', '#1E90FF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(92, 'CornflowerBlue', '#6495ED', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(93, 'MediumSlateBlue', '#7B68EE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(94, 'RoyalBlue', '#4169E1', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(95, 'Blue', '#0000FF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(96, 'MediumBlue', '#0000CD', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(97, 'DarkBlue', '#00008B', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(98, 'Navy', '#000080', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(99, 'MidnightBlue', '#191970', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(100, 'Cornsilk', '#FFF8DC', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(101, 'BlanchedAlmond', '#FFEBCD', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(102, 'Bisque', '#FFE4C4', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(103, 'NavajoWhite', '#FFDEAD', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(104, 'Wheat', '#F5DEB3', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(105, 'BurlyWood', '#DEB887', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(106, 'Tan', '#D2B48C', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(107, 'RosyBrown', '#BC8F8F', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(108, 'SandyBrown', '#F4A460', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(109, 'Goldenrod', '#DAA520', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(110, 'DarkGoldenrod', '#B8860B', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(111, 'Peru', '#CD853F', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(112, 'Chocolate', '#D2691E', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(113, 'SaddleBrown', '#8B4513', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(114, 'Sienna', '#A0522D', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(115, 'Brown', '#A52A2A', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(116, 'Maroon', '#800000', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(117, 'White', '#FFFFFF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(118, 'Snow', '#FFFAFA', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(119, 'Honeydew', '#F0FFF0', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(120, 'MintCream', '#F5FFFA', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(121, 'Azure', '#F0FFFF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(122, 'AliceBlue', '#F0F8FF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(123, 'GhostWhite', '#F8F8FF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(124, 'WhiteSmoke', '#F5F5F5', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(125, 'Seashell', '#FFF5EE', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(126, 'Beige', '#F5F5DC', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(127, 'OldLace', '#FDF5E6', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(128, 'FloralWhite', '#FFFAF0', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(129, 'Ivory', '#FFFFF0', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(130, 'AntiqueWhite', '#FAEBD7', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(131, 'Linen', '#FAF0E6', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(132, 'LavenderBlush', '#FFF0F5', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(133, 'MistyRose', '#FFE4E1', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(134, 'Gainsboro', '#DCDCDC', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(135, 'LightGrey', '#D3D3D3', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(136, 'Silver', '#C0C0C0', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(137, 'DarkGray', '#A9A9A9', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(138, 'Gray', '#808080', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(139, 'DimGray', '#696969', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(140, 'LightSlateGray', '#778899', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(141, 'SlateGray', '#708090', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(142, 'DarkSlateGray', '#2F4F4F', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(143, 'Black', '#000000', '2018-11-05 02:12:30', '2018-11-05 02:12:30');

-- --------------------------------------------------------

--
-- بنية الجدول `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT 0,
  `feedback` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reply` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `coupon_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `min_purchase` decimal(8,2) NOT NULL DEFAULT 0.00,
  `max_discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `limit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `symbol`, `code`, `exchange_rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USD', '$', 'USD', '1', 1, NULL, '2021-06-27 13:39:37'),
(2, 'BDT', '৳', 'BDT', '84', 1, NULL, '2021-07-06 11:52:58'),
(3, 'Indian Rupi', '₹', 'INR', '60', 1, '2020-10-15 17:23:04', '2021-06-04 18:26:38'),
(4, 'Euro', '€', 'EUR', '100', 1, '2021-05-25 21:00:23', '2021-06-04 18:25:29'),
(5, 'YEN', '¥', 'JPY', '110', 1, '2021-06-10 22:08:31', '2021-06-26 14:21:10'),
(6, 'Ringgit', 'RM', 'MYR', '4.16', 1, '2021-07-03 11:08:33', '2021-07-03 11:10:37'),
(7, 'Rand', 'R', 'ZAR', '14.26', 1, '2021-07-03 11:12:38', '2021-07-03 11:12:42');

-- --------------------------------------------------------

--
-- بنية الجدول `customer_wallets`
--

CREATE TABLE `customer_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `balance` decimal(8,2) NOT NULL DEFAULT 0.00,
  `royality_points` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `customer_wallet_histories`
--

CREATE TABLE `customer_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `transaction_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `transaction_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_method` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `deal_of_the_days`
--

CREATE TABLE `deal_of_the_days` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'amount',
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `deliveryman_notifications`
--

CREATE TABLE `deliveryman_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `deliveryman_wallets`
--

CREATE TABLE `deliveryman_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) NOT NULL,
  `current_balance` decimal(50,2) NOT NULL DEFAULT 0.00,
  `cash_in_hand` decimal(50,2) NOT NULL DEFAULT 0.00,
  `pending_withdraw` decimal(50,2) NOT NULL DEFAULT 0.00,
  `total_withdraw` decimal(50,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_country_codes`
--

CREATE TABLE `delivery_country_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_histories`
--

CREATE TABLE `delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `deliveryman_id` bigint(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_man_transactions`
--

CREATE TABLE `delivery_man_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debit` decimal(50,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(50,2) NOT NULL DEFAULT 0.00,
  `transaction_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_men`
--

CREATE TABLE `delivery_men` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `f_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_number` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_online` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `auth_token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '6yIRXJRRfp78qJsAoKZZ6TTqhzuNJ3TcdvPBmk6n',
  `fcm_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `delivery_zip_codes`
--

CREATE TABLE `delivery_zip_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `zipcode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `education_degrees`
--

CREATE TABLE `education_degrees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `education_degrees`
--

INSERT INTO `education_degrees` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'بكالوريوس', NULL, '2023-01-01 20:37:20', '2023-03-13 20:02:41');

-- --------------------------------------------------------

--
-- بنية الجدول `emergency_contacts`
--

CREATE TABLE `emergency_contacts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `experiences`
--

CREATE TABLE `experiences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `experiences_level` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `experiences`
--

INSERT INTO `experiences` (`id`, `experiences_level`, `description`, `created_at`, `updated_at`) VALUES
(1, 'خبرة من 3-5', NULL, '2023-01-01 20:38:16', '2023-03-13 20:03:28');

-- --------------------------------------------------------

--
-- بنية الجدول `extra_benefits`
--

CREATE TABLE `extra_benefits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `extra_benefits`
--

INSERT INTO `extra_benefits` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'مهارة في استخدام الحاسوب', NULL, '2023-01-01 20:35:39', '2023-03-13 20:01:40');

-- --------------------------------------------------------

--
-- بنية الجدول `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `feature_deals`
--

CREATE TABLE `feature_deals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `flash_deals`
--

CREATE TABLE `flash_deals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `deal_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `flash_deal_products`
--

CREATE TABLE `flash_deal_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `flash_deal_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `governorates`
--

CREATE TABLE `governorates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_advertis_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `governorates`
--

INSERT INTO `governorates` (`id`, `name`, `description`, `city_advertis_id`, `created_at`, `updated_at`) VALUES
(1, 'الحصبة', NULL, 1, '2023-01-01 20:50:44', '2023-03-13 20:07:15');

-- --------------------------------------------------------

--
-- بنية الجدول `help_topics`
--

CREATE TABLE `help_topics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ranking` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `job_titles`
--

CREATE TABLE `job_titles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `career_sector_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `job_titles`
--

INSERT INTO `job_titles` (`id`, `name`, `description`, `career_sector_id`, `created_at`, `updated_at`) VALUES
(1, 'مبرمج اوراكل', NULL, 2, '2023-01-01 19:41:59', '2023-03-13 19:55:53'),
(2, 'Full stack', NULL, 3, '2023-02-07 23:23:35', '2023-02-07 23:23:35'),
(3, 'mobile developer', NULL, 2, '2023-03-17 17:56:39', '2023-03-17 17:56:39'),
(4, 'db', NULL, 2, '2023-03-18 02:45:56', '2023-03-18 02:45:56'),
(5, 'web developer', NULL, 2, '2023-03-18 02:46:17', '2023-03-18 02:46:17'),
(6, 'محاسب قانوني', NULL, 5, '2023-03-18 02:47:04', '2023-03-18 02:47:04'),
(7, 'نجار دواليب', NULL, 8, '2023-03-18 02:47:27', '2023-03-18 02:47:27'),
(8, 'مهندس داخلي', NULL, 11, '2023-03-18 02:47:51', '2023-03-18 02:47:51'),
(9, 'محلل نظم', NULL, 4, '2023-03-18 02:48:19', '2023-03-18 02:48:19'),
(10, 'محلل نظم', NULL, 4, '2023-03-18 02:48:24', '2023-03-18 02:48:24'),
(11, 'مصمم واجهات', NULL, 2, '2023-03-18 02:48:41', '2023-03-18 02:48:41'),
(12, 'web developer 2', NULL, 2, '2023-03-20 17:16:14', '2023-03-20 17:16:14');

-- --------------------------------------------------------

--
-- بنية الجدول `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `languages`
--

INSERT INTO `languages` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'لغة انجليزي', NULL, '2023-01-01 20:41:20', '2023-03-13 20:04:38'),
(2, 'لغة فرنسية', NULL, '2023-03-15 16:32:13', '2023-03-15 16:32:13');

-- --------------------------------------------------------

--
-- بنية الجدول `licenses`
--

CREATE TABLE `licenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `licenses`
--

INSERT INTO `licenses` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'رخصة مركبة', NULL, '2023-01-01 20:39:46', '2023-03-13 20:04:00');

-- --------------------------------------------------------

--
-- بنية الجدول `loyalty_point_transactions`
--

CREATE TABLE `loyalty_point_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `debit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `balance` decimal(24,3) NOT NULL DEFAULT 0.000,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_09_08_105159_create_admins_table', 1),
(5, '2020_09_08_111837_create_admin_roles_table', 1),
(6, '2020_09_16_142451_create_categories_table', 2),
(7, '2020_09_16_181753_create_categories_table', 3),
(8, '2020_09_17_134238_create_brands_table', 4),
(9, '2020_09_17_203054_create_attributes_table', 5),
(10, '2020_09_19_112509_create_coupons_table', 6),
(11, '2020_09_19_161802_create_curriencies_table', 7),
(12, '2020_09_20_114509_create_sellers_table', 8),
(13, '2020_09_23_113454_create_shops_table', 9),
(14, '2020_09_23_115615_create_shops_table', 10),
(15, '2020_09_23_153822_create_shops_table', 11),
(16, '2020_09_21_122817_create_products_table', 12),
(17, '2020_09_22_140800_create_colors_table', 12),
(18, '2020_09_28_175020_create_products_table', 13),
(19, '2020_09_28_180311_create_products_table', 14),
(20, '2020_10_04_105041_create_search_functions_table', 15),
(21, '2020_10_05_150730_create_customers_table', 15),
(22, '2020_10_08_133548_create_wishlists_table', 16),
(23, '2016_06_01_000001_create_oauth_auth_codes_table', 17),
(24, '2016_06_01_000002_create_oauth_access_tokens_table', 17),
(25, '2016_06_01_000003_create_oauth_refresh_tokens_table', 17),
(26, '2016_06_01_000004_create_oauth_clients_table', 17),
(27, '2016_06_01_000005_create_oauth_personal_access_clients_table', 17),
(28, '2020_10_06_133710_create_product_stocks_table', 17),
(29, '2020_10_06_134636_create_flash_deals_table', 17),
(30, '2020_10_06_134719_create_flash_deal_products_table', 17),
(31, '2020_10_08_115439_create_orders_table', 17),
(32, '2020_10_08_115453_create_order_details_table', 17),
(33, '2020_10_08_121135_create_shipping_addresses_table', 17),
(34, '2020_10_10_171722_create_business_settings_table', 17),
(35, '2020_09_19_161802_create_currencies_table', 18),
(36, '2020_10_12_152350_create_reviews_table', 18),
(37, '2020_10_12_161834_create_reviews_table', 19),
(38, '2020_10_12_180510_create_support_tickets_table', 20),
(39, '2020_10_14_140130_create_transactions_table', 21),
(40, '2020_10_14_143553_create_customer_wallets_table', 21),
(41, '2020_10_14_143607_create_customer_wallet_histories_table', 21),
(42, '2020_10_22_142212_create_support_ticket_convs_table', 21),
(43, '2020_10_24_234813_create_banners_table', 22),
(44, '2020_10_27_111557_create_shipping_methods_table', 23),
(45, '2020_10_27_114154_add_url_to_banners_table', 24),
(46, '2020_10_28_170308_add_shipping_id_to_order_details', 25),
(47, '2020_11_02_140528_add_discount_to_order_table', 26),
(48, '2020_11_03_162723_add_column_to_order_details', 27),
(49, '2020_11_08_202351_add_url_to_banners_table', 28),
(50, '2020_11_10_112713_create_help_topic', 29),
(51, '2020_11_10_141513_create_contacts_table', 29),
(52, '2020_11_15_180036_add_address_column_user_table', 30),
(53, '2020_11_18_170209_add_status_column_to_product_table', 31),
(54, '2020_11_19_115453_add_featured_status_product', 32),
(55, '2020_11_21_133302_create_deal_of_the_days_table', 33),
(56, '2020_11_20_172332_add_product_id_to_products', 34),
(57, '2020_11_27_234439_add__state_to_shipping_addresses', 34),
(58, '2020_11_28_091929_create_chattings_table', 35),
(59, '2020_12_02_011815_add_bank_info_to_sellers', 36),
(60, '2020_12_08_193234_create_social_medias_table', 37),
(61, '2020_12_13_122649_shop_id_to_chattings', 37),
(62, '2020_12_14_145116_create_seller_wallet_histories_table', 38),
(63, '2020_12_14_145127_create_seller_wallets_table', 38),
(64, '2020_12_15_174804_create_admin_wallets_table', 39),
(65, '2020_12_15_174821_create_admin_wallet_histories_table', 39),
(66, '2020_12_15_214312_create_feature_deals_table', 40),
(67, '2020_12_17_205712_create_withdraw_requests_table', 41),
(68, '2021_02_22_161510_create_notifications_table', 42),
(69, '2021_02_24_154706_add_deal_type_to_flash_deals', 43),
(70, '2021_03_03_204349_add_cm_firebase_token_to_users', 44),
(71, '2021_04_17_134848_add_column_to_order_details_stock', 45),
(72, '2021_05_12_155401_add_auth_token_seller', 46),
(73, '2021_06_03_104531_ex_rate_update', 47),
(74, '2021_06_03_222413_amount_withdraw_req', 48),
(75, '2021_06_04_154501_seller_wallet_withdraw_bal', 49),
(76, '2021_06_04_195853_product_dis_tax', 50),
(77, '2021_05_27_103505_create_product_translations_table', 51),
(78, '2021_06_17_054551_create_soft_credentials_table', 51),
(79, '2021_06_29_212549_add_active_col_user_table', 52),
(80, '2021_06_30_212619_add_col_to_contact', 53),
(81, '2021_07_01_160828_add_col_daily_needs_products', 54),
(82, '2021_07_04_182331_add_col_seller_sales_commission', 55),
(83, '2021_08_07_190655_add_seo_columns_to_products', 56),
(84, '2021_08_07_205913_add_col_to_category_table', 56),
(85, '2021_08_07_210808_add_col_to_shops_table', 56),
(86, '2021_08_14_205216_change_product_price_col_type', 56),
(87, '2021_08_16_201505_change_order_price_col', 56),
(88, '2021_08_16_201552_change_order_details_price_col', 56),
(89, '2019_09_29_154000_create_payment_cards_table', 57),
(90, '2021_08_17_213934_change_col_type_seller_earning_history', 57),
(91, '2021_08_17_214109_change_col_type_admin_earning_history', 57),
(92, '2021_08_17_214232_change_col_type_admin_wallet', 57),
(93, '2021_08_17_214405_change_col_type_seller_wallet', 57),
(94, '2021_08_22_184834_add_publish_to_products_table', 57),
(95, '2021_09_08_211832_add_social_column_to_users_table', 57),
(96, '2021_09_13_165535_add_col_to_user', 57),
(97, '2021_09_19_061647_add_limit_to_coupons_table', 57),
(98, '2021_09_20_020716_add_coupon_code_to_orders_table', 57),
(99, '2021_09_23_003059_add_gst_to_sellers_table', 57),
(100, '2021_09_28_025411_create_order_transactions_table', 57),
(101, '2021_10_02_185124_create_carts_table', 57),
(102, '2021_10_02_190207_create_cart_shippings_table', 57),
(103, '2021_10_03_194334_add_col_order_table', 57),
(104, '2021_10_03_200536_add_shipping_cost', 57),
(105, '2021_10_04_153201_add_col_to_order_table', 57),
(106, '2021_10_07_172701_add_col_cart_shop_info', 57),
(107, '2021_10_07_184442_create_phone_or_email_verifications_table', 57),
(108, '2021_10_07_185416_add_user_table_email_verified', 57),
(109, '2021_10_11_192739_add_transaction_amount_table', 57),
(110, '2021_10_11_200850_add_order_verification_code', 57),
(111, '2021_10_12_083241_add_col_to_order_transaction', 57),
(112, '2021_10_12_084440_add_seller_id_to_order', 57),
(113, '2021_10_12_102853_change_col_type', 57),
(114, '2021_10_12_110434_add_col_to_admin_wallet', 57),
(115, '2021_10_12_110829_add_col_to_seller_wallet', 57),
(116, '2021_10_13_091801_add_col_to_admin_wallets', 57),
(117, '2021_10_13_092000_add_col_to_seller_wallets_tax', 57),
(118, '2021_10_13_165947_rename_and_remove_col_seller_wallet', 57),
(119, '2021_10_13_170258_rename_and_remove_col_admin_wallet', 57),
(120, '2021_10_14_061603_column_update_order_transaction', 57),
(121, '2021_10_15_103339_remove_col_from_seller_wallet', 57),
(122, '2021_10_15_104419_add_id_col_order_tran', 57),
(123, '2021_10_15_213454_update_string_limit', 57),
(124, '2021_10_16_234037_change_col_type_translation', 57),
(125, '2021_10_16_234329_change_col_type_translation_1', 57),
(126, '2021_10_27_091250_add_shipping_address_in_order', 58),
(127, '2021_01_24_205114_create_paytabs_invoices_table', 59),
(128, '2021_11_20_043814_change_pass_reset_email_col', 59),
(129, '2021_11_25_043109_create_delivery_men_table', 60),
(130, '2021_11_25_062242_add_auth_token_delivery_man', 60),
(131, '2021_11_27_043405_add_deliveryman_in_order_table', 60),
(132, '2021_11_27_051432_create_delivery_histories_table', 60),
(133, '2021_11_27_051512_add_fcm_col_for_delivery_man', 60),
(134, '2021_12_15_123216_add_columns_to_banner', 60),
(135, '2022_01_04_100543_add_order_note_to_orders_table', 60),
(136, '2022_01_10_034952_add_lat_long_to_shipping_addresses_table', 60),
(137, '2022_01_10_045517_create_billing_addresses_table', 60),
(138, '2022_01_11_040755_add_is_billing_to_shipping_addresses_table', 60),
(139, '2022_01_11_053404_add_billing_to_orders_table', 60),
(140, '2022_01_11_234310_add_firebase_toke_to_sellers_table', 60),
(141, '2022_01_16_121801_change_colu_type', 60),
(142, '2022_01_22_101601_change_cart_col_type', 61),
(143, '2022_01_23_031359_add_column_to_orders_table', 61),
(144, '2022_01_28_235054_add_status_to_admins_table', 61),
(145, '2022_02_01_214654_add_pos_status_to_sellers_table', 61),
(146, '2019_12_14_000001_create_personal_access_tokens_table', 62),
(147, '2022_02_11_225355_add_checked_to_orders_table', 62),
(148, '2022_02_14_114359_create_refund_requests_table', 62),
(149, '2022_02_14_115757_add_refund_request_to_order_details_table', 62),
(150, '2022_02_15_092604_add_order_details_id_to_transactions_table', 62),
(151, '2022_02_15_121410_create_refund_transactions_table', 62),
(152, '2022_02_24_091236_add_multiple_column_to_refund_requests_table', 62),
(153, '2022_02_24_103827_create_refund_statuses_table', 62),
(154, '2022_03_01_121420_add_refund_id_to_refund_transactions_table', 62),
(155, '2022_03_10_091943_add_priority_to_categories_table', 63),
(156, '2022_03_13_111914_create_shipping_types_table', 63),
(157, '2022_03_13_121514_create_category_shipping_costs_table', 63),
(158, '2022_03_14_074413_add_four_column_to_products_table', 63),
(159, '2022_03_15_105838_add_shipping_to_carts_table', 63),
(160, '2022_03_16_070327_add_shipping_type_to_orders_table', 63),
(161, '2022_03_17_070200_add_delivery_info_to_orders_table', 63),
(162, '2022_03_18_143339_add_shipping_type_to_carts_table', 63),
(163, '2022_04_06_020313_create_subscriptions_table', 64),
(164, '2022_04_12_233704_change_column_to_products_table', 64),
(165, '2022_04_19_095926_create_jobs_table', 64),
(166, '2022_05_12_104247_create_wallet_transactions_table', 65),
(167, '2022_05_12_104511_add_two_column_to_users_table', 65),
(168, '2022_05_14_063309_create_loyalty_point_transactions_table', 65),
(169, '2022_05_26_044016_add_user_type_to_password_resets_table', 65),
(170, '2022_04_15_235820_add_provider', 66),
(171, '2022_07_21_101659_add_code_to_products_table', 66),
(172, '2022_07_26_103744_add_notification_count_to_notifications_table', 66),
(173, '2022_07_31_031541_add_minimum_order_qty_to_products_table', 66),
(174, '2022_08_11_172839_add_product_type_and_digital_product_type_and_digital_file_ready_to_products', 67),
(175, '2022_08_11_173941_add_product_type_and_digital_product_type_and_digital_file_to_order_details', 67),
(176, '2022_08_20_094225_add_product_type_and_digital_product_type_and_digital_file_ready_to_carts_table', 67),
(177, '2022_10_04_160234_add_banking_columns_to_delivery_men_table', 68),
(178, '2022_10_04_161339_create_deliveryman_wallets_table', 68),
(179, '2022_10_04_184506_add_deliverymanid_column_to_withdraw_requests_table', 68),
(180, '2022_10_11_103011_add_deliverymans_columns_to_chattings_table', 68),
(181, '2022_10_11_144902_add_deliverman_id_cloumn_to_reviews_table', 68),
(182, '2022_10_17_114744_create_order_status_histories_table', 68),
(183, '2022_10_17_120840_create_order_expected_delivery_histories_table', 68),
(184, '2022_10_18_084245_add_deliveryman_charge_and_expected_delivery_date', 68),
(185, '2022_10_18_130938_create_delivery_zip_codes_table', 68),
(186, '2022_10_18_130956_create_delivery_country_codes_table', 68),
(187, '2022_10_20_164712_create_delivery_man_transactions_table', 68),
(188, '2022_10_27_145604_create_emergency_contacts_table', 68),
(189, '2022_10_29_182930_add_is_pause_cause_to_orders_table', 68),
(190, '2022_10_31_150604_add_address_phone_country_code_column_to_delivery_men_table', 68),
(191, '2022_11_05_185726_add_order_id_to_reviews_table', 68),
(192, '2022_11_07_190749_create_deliveryman_notifications_table', 68),
(193, '2022_11_08_132745_change_transaction_note_type_to_withdraw_requests_table', 68),
(194, '2022_11_10_193747_chenge_order_amount_seller_amount_admin_commission_delivery_charge_tax_toorder_transactions_table', 68),
(250, '2022_12_29_193531_create_career_sectors_table', 69),
(251, '2022_12_29_193924_create_job_titles_table', 69),
(252, '2022_12_29_194228_create_advertise_types_table', 69),
(253, '2022_12_29_194543_create_type_contracts_table', 69),
(254, '2022_12_29_194746_create_work_days_table', 69),
(255, '2022_12_29_195005_create_type_work_hours_table', 69),
(256, '2022_12_29_195145_create_salaries_table', 69),
(257, '2022_12_29_195648_create_education_degrees_table', 69),
(258, '2022_12_29_195933_create_experiences_table', 69),
(259, '2022_12_29_200122_create_licenses_table', 69),
(260, '2022_12_29_200250_create_languages_table', 69),
(261, '2022_12_29_200425_create_nationalities_table', 69),
(262, '2022_12_29_200627_create_skills_table', 69),
(263, '2022_12_29_200830_create_state_advertis_table', 69),
(264, '2022_12_29_200831_create_city_advertis_table', 69),
(265, '2022_12_29_201159_create_governorates_table', 69),
(273, '2022_12_29_201342_create_advertis_table', 70),
(274, '2022_12_29_205214_create_extra_benefits_table', 71),
(275, '2022_12_29_205215_create_advertis_extra_benefit_table', 72),
(276, '2023_01_01_165824_add_status_to_advertis_table', 72),
(277, '2023_01_01_170039_add_created_by_to_advertis_table', 72),
(279, '2023_01_02_230017_create_advertis_skill_table', 74),
(280, '2023_01_02_230214_create_advertis_license_table', 75),
(281, '2023_01_02_230256_create_advertis_language_table', 76);

-- --------------------------------------------------------

--
-- بنية الجدول `nationalities`
--

CREATE TABLE `nationalities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `nationalities`
--

INSERT INTO `nationalities` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'يمني', NULL, '2023-01-01 20:42:45', '2023-03-13 20:05:09');

-- --------------------------------------------------------

--
-- بنية الجدول `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_count` int(11) NOT NULL DEFAULT 0,
  `image` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `notifications`
--

INSERT INTO `notifications` (`id`, `title`, `description`, `notification_count`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'hi kimo', 'اعلان تجريبي', 1, '2023-03-23-641cb1a14e05d.png', 1, '2023-03-23 17:08:01', '2023-03-23 17:08:01');

-- --------------------------------------------------------

--
-- بنية الجدول `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('00071aa0419469911f838181aa7716211478cb0e208e3ce0a57cb2d0504b10bfc77128f18a8a6237', 4, 1, 'LaravelAuthApp', '[]', 0, '2023-03-22 21:00:28', '2023-03-22 21:00:28', '2024-03-23 00:00:28'),
('6840b7d4ed685bf2e0dc593affa0bd3b968065f47cc226d39ab09f1422b5a1d9666601f3f60a79c1', 98, 1, 'LaravelAuthApp', '[]', 1, '2021-07-05 09:25:41', '2021-07-05 09:25:41', '2022-07-05 15:25:41'),
('694a5fb5c72a26781ecbdd5214109ad9b665d2e224cb121f42efb47b6bb94e53ce36df15a659e28d', 4, 1, 'LaravelAuthApp', '[]', 0, '2023-03-23 22:57:18', '2023-03-23 22:57:18', '2024-03-24 01:57:18'),
('c42cdd5ae652b8b2cbac4f2f4b496e889e1a803b08672954c8bbe06722b54160e71dce3e02331544', 98, 1, 'LaravelAuthApp', '[]', 1, '2021-07-05 09:24:36', '2021-07-05 09:24:36', '2022-07-05 15:24:36'),
('e84a31d596ab6140c921ec63596012e987573d20bb4fe559c96824b1c1633b9ed15063027a202196', 4, 1, 'LaravelAuthApp', '[]', 0, '2023-02-12 00:20:58', '2023-02-12 00:20:58', '2024-02-12 03:20:58'),
('f693dd829980c1ad7488434fe7402f35f44a887b16be4bf3e753bac21891420efb9238e17bd93deb', 4, 1, 'LaravelAuthApp', '[]', 0, '2023-03-23 17:50:15', '2023-03-23 17:50:15', '2024-03-23 20:50:15');

-- --------------------------------------------------------

--
-- بنية الجدول `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`, `provider`) VALUES
(1, NULL, '6amtech', 'GEUx5tqkviM6AAQcz4oi1dcm1KtRdJPgw41lj0eI', 'http://localhost', 1, 0, 0, '2020-10-21 18:27:22', '2020-10-21 18:27:22', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-10-21 18:27:23', '2020-10-21 18:27:23');

-- --------------------------------------------------------

--
-- بنية الجدول `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `order_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_ref` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_amount` double NOT NULL DEFAULT 0,
  `is_pause` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `cause` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `discount_amount` double NOT NULL DEFAULT 0,
  `discount_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method_id` bigint(20) NOT NULL DEFAULT 0,
  `shipping_cost` double(8,2) NOT NULL DEFAULT 0.00,
  `order_group_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def-order-group',
  `verification_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_man_id` bigint(20) DEFAULT NULL,
  `deliveryman_charge` double NOT NULL DEFAULT 0,
  `expected_delivery_date` date DEFAULT NULL,
  `order_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address` bigint(20) UNSIGNED DEFAULT NULL,
  `billing_address_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_type',
  `extra_discount` double(8,2) NOT NULL DEFAULT 0.00,
  `extra_discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_service_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `third_party_delivery_tracking_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `customer_type`, `payment_status`, `order_status`, `payment_method`, `transaction_ref`, `order_amount`, `is_pause`, `cause`, `shipping_address`, `created_at`, `updated_at`, `discount_amount`, `discount_type`, `coupon_code`, `shipping_method_id`, `shipping_cost`, `order_group_id`, `verification_code`, `seller_id`, `seller_is`, `shipping_address_data`, `delivery_man_id`, `deliveryman_charge`, `expected_delivery_date`, `order_note`, `billing_address`, `billing_address_data`, `order_type`, `extra_discount`, `extra_discount_type`, `checked`, `shipping_type`, `delivery_type`, `delivery_service_name`, `third_party_delivery_tracking_id`) VALUES
(100001, '2', 'customer', 'unpaid', 'pending', 'cash_on_delivery', '', 55, '0', NULL, '2', '2023-01-04 21:36:52', '2023-01-04 21:37:08', 0, NULL, '0', 2, 5.00, '6730-SEL1o-1672853812', '941663', 1, 'admin', '{\"id\":2,\"customer_id\":2,\"contact_person_name\":\"mahmooud AL_batran\",\"address_type\":\"home\",\"address\":\"Bureij-Martyrs\' Roundabout\",\"city\":\"Gaza\",\"zip\":\"8540400\",\"phone\":\"0597051897\",\"created_at\":\"2023-01-04T17:36:33.000000Z\",\"updated_at\":\"2023-01-04T17:36:33.000000Z\",\"state\":null,\"country\":\"Afghanistan\",\"latitude\":\"0\",\"longitude\":\"0\",\"is_billing\":0}', NULL, 0, NULL, 'asdasd', NULL, NULL, 'default_type', 0.00, NULL, 1, 'order_wise', NULL, NULL, NULL),
(100002, '4', 'customer', 'unpaid', 'pending', 'cash_on_delivery', '', 280, '0', NULL, '3', '2023-03-17 19:08:57', '2023-03-17 19:09:37', 0, NULL, '0', 2, 5.00, '3270-pJlhE-1679090937', '247255', 1, 'admin', '{\"id\":3,\"customer_id\":4,\"contact_person_name\":\"Abdulkreem Ali Alqabali\",\"address_type\":\"home\",\"address\":\"\\u0627\\u0644\\u062f\\u0627\\u0626\\u0631\\u064a - \\u062c\\u0648\\u0627\\u0631 \\u0627\\u0644\\u0634\\u0627\\u0645\\u0644 \\u0633\\u064a\\u062a\\u064a\\r\\n\\u0627\\u0644\\u062f\\u0627\\u0626\\u0631\\u064a - \\u0627\\u0645\\u0627\\u0645 \\u0633\\u064a\\u062a\\u064a \\u0645\\u0627\\u0631\\u062a\",\"city\":\"\\u0635\\u0646\\u0639\\u0627\\u0621\",\"zip\":\"001\",\"phone\":\"0776539779\",\"created_at\":\"2023-03-17T22:00:04.000000Z\",\"updated_at\":\"2023-03-17T22:00:04.000000Z\",\"state\":null,\"country\":\"Yemen\",\"latitude\":\"\",\"longitude\":\"\",\"is_billing\":0}', NULL, 0, NULL, NULL, NULL, NULL, 'default_type', 0.00, NULL, 1, 'order_wise', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `digital_file_after_sell` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `tax` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `delivery_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shipping_method_id` bigint(20) DEFAULT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_stock_decreased` tinyint(1) NOT NULL DEFAULT 1,
  `refund_request` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `digital_file_after_sell`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`, `refund_request`) VALUES
(1, 100001, 1, 1, NULL, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"web\",\"slug\":\"web-ZwgTVK\",\"product_type\":\"physical\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1}]\",\"brand_id\":1,\"unit\":\"pc\",\"min_qty\":1,\"refundable\":1,\"digital_product_type\":null,\"digital_file_ready\":null,\"images\":\"[\\\"2023-01-04-63b5b7cdec7fd.png\\\",\\\"2023-01-04-63b5b7cdf1cda.png\\\"]\",\"thumbnail\":\"2023-01-04-63b5b7cdf24a4.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":50,\"purchase_price\":2,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":10,\"minimum_order_qty\":1,\"details\":\"<p>web&nbsp;web<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2023-01-04T17:30:53.000000Z\",\"updated_at\":\"2023-01-04T17:30:53.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":null,\"meta_description\":null,\"meta_image\":\"def.png\",\"request_status\":1,\"denied_note\":null,\"shipping_cost\":40,\"multiply_qty\":0,\"temp_shipping_cost\":null,\"is_shipping_cost_updated\":null,\"code\":\"144814\",\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 50, 0, 0, 'pending', 'unpaid', '2023-01-04 21:36:52', '2023-01-04 21:36:52', NULL, '', '[]', 'discount_on_product', 1, 0),
(2, 100002, 2, 1, NULL, '{\"id\":2,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"sotewsa\",\"slug\":\"sotewsa-LW3QZG\",\"product_type\":\"physical\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"digital_product_type\":null,\"digital_file_ready\":null,\"images\":\"[\\\"2023-01-08-63bafcd6e9d70.png\\\"]\",\"thumbnail\":\"2023-01-08-63bafcd6eabbc.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":50,\"purchase_price\":40,\"tax\":10,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":100,\"minimum_order_qty\":1,\"details\":\"<p>asdasd<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2023-01-09T00:26:46.000000Z\",\"updated_at\":\"2023-01-09T00:26:46.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":null,\"meta_description\":null,\"meta_image\":\"def.png\",\"request_status\":1,\"denied_note\":null,\"shipping_cost\":40,\"multiply_qty\":0,\"temp_shipping_cost\":null,\"is_shipping_cost_updated\":null,\"code\":\"144351315\",\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 5, 50, 25, 0, 'pending', 'unpaid', '2023-03-17 19:08:57', '2023-03-17 19:08:57', NULL, '', '[]', 'discount_on_product', 1, 0);

-- --------------------------------------------------------

--
-- بنية الجدول `order_expected_delivery_histories`
--

CREATE TABLE `order_expected_delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expected_delivery_date` date NOT NULL,
  `cause` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `order_status_histories`
--

CREATE TABLE `order_status_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cause` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `order_status_histories`
--

INSERT INTO `order_status_histories` (`id`, `order_id`, `user_id`, `user_type`, `status`, `cause`, `created_at`, `updated_at`) VALUES
(1, 100001, 2, 'customer', 'pending', NULL, '2023-01-04 21:36:52', '2023-01-04 21:36:52'),
(2, 100002, 4, 'customer', 'pending', NULL, '2023-03-17 19:08:57', '2023-03-17 19:08:57');

-- --------------------------------------------------------

--
-- بنية الجدول `order_transactions`
--

CREATE TABLE `order_transactions` (
  `seller_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `order_amount` decimal(50,2) NOT NULL DEFAULT 0.00,
  `seller_amount` decimal(50,2) NOT NULL DEFAULT 0.00,
  `admin_commission` decimal(50,2) NOT NULL DEFAULT 0.00,
  `received_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_charge` decimal(50,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(50,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `password_resets`
--

CREATE TABLE `password_resets` (
  `identity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `user_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `paytabs_invoices`
--

CREATE TABLE `paytabs_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `result` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `response_code` int(10) UNSIGNED NOT NULL,
  `pt_invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(8,2) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_first_six_digits` int(10) UNSIGNED DEFAULT NULL,
  `card_last_four_digits` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `phone_or_email_verifications`
--

CREATE TABLE `phone_or_email_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone_or_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `added_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'physical',
  `category_ids` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_qty` int(11) NOT NULL DEFAULT 1,
  `refundable` tinyint(1) NOT NULL DEFAULT 1,
  `digital_product_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digital_file_ready` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flash_deal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_provider` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colors` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_product` tinyint(1) NOT NULL DEFAULT 0,
  `attributes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choice_options` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variation` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `unit_price` double NOT NULL DEFAULT 0,
  `purchase_price` double NOT NULL DEFAULT 0,
  `tax` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `tax_type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `discount_type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_stock` int(11) DEFAULT NULL,
  `minimum_order_qty` int(11) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `featured_status` tinyint(1) NOT NULL DEFAULT 1,
  `meta_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_status` tinyint(1) NOT NULL DEFAULT 0,
  `denied_note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_cost` double(8,2) DEFAULT NULL,
  `multiply_qty` tinyint(1) DEFAULT NULL,
  `temp_shipping_cost` double(8,2) DEFAULT NULL,
  `is_shipping_cost_updated` tinyint(1) DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `products`
--

INSERT INTO `products` (`id`, `added_by`, `user_id`, `name`, `slug`, `product_type`, `category_ids`, `brand_id`, `unit`, `min_qty`, `refundable`, `digital_product_type`, `digital_file_ready`, `images`, `thumbnail`, `featured`, `flash_deal`, `video_provider`, `video_url`, `colors`, `variant_product`, `attributes`, `choice_options`, `variation`, `published`, `unit_price`, `purchase_price`, `tax`, `tax_type`, `discount`, `discount_type`, `current_stock`, `minimum_order_qty`, `details`, `free_shipping`, `attachment`, `created_at`, `updated_at`, `status`, `featured_status`, `meta_title`, `meta_description`, `meta_image`, `request_status`, `denied_note`, `shipping_cost`, `multiply_qty`, `temp_shipping_cost`, `is_shipping_cost_updated`, `code`) VALUES
(1, 'admin', 1, 'web', 'web-ZwgTVK', 'physical', '[{\"id\":\"1\",\"position\":1}]', 1, 'pc', 1, 1, NULL, NULL, '[\"2023-01-04-63b5b7cdec7fd.png\",\"2023-01-04-63b5b7cdf1cda.png\"]', '2023-01-04-63b5b7cdf24a4.png', NULL, NULL, 'youtube', NULL, '[]', 0, 'null', '[]', '[]', 0, 50, 2, '0', 'percent', '0', 'flat', 9, 1, '<p>web&nbsp;web</p>', 0, NULL, '2023-01-04 21:30:53', '2023-01-04 21:36:52', 1, 1, NULL, NULL, 'def.png', 1, NULL, 40.00, 0, NULL, NULL, '144814'),
(2, 'admin', 1, 'phone', 'sotewsa-LW3QZG', 'physical', '[{\"id\":\"1\",\"position\":1}]', 1, 'kg', 1, 1, NULL, NULL, '[\"2023-01-08-63bafcd6e9d70.png\"]', '2023-01-08-63bafcd6eabbc.png', NULL, NULL, 'youtube', NULL, '[]', 0, 'null', '[]', '[]', 0, 50, 40, '10', 'percent', '10', 'flat', 95, 1, '<p>asdasd</p>', 0, NULL, '2023-01-08 21:26:46', '2023-03-23 19:57:00', 1, 1, NULL, NULL, 'def.png', 1, NULL, 40.00, 0, NULL, NULL, '144351315');

-- --------------------------------------------------------

--
-- بنية الجدول `product_stocks`
--

CREATE TABLE `product_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT 0.00,
  `qty` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `refund_requests`
--

CREATE TABLE `refund_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_details_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `refund_reason` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `images` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `approved_note` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rejected_note` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_info` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `refund_statuses`
--

CREATE TABLE `refund_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refund_request_id` bigint(20) UNSIGNED DEFAULT NULL,
  `change_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `change_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `refund_transactions`
--

CREATE TABLE `refund_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_for` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_receiver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_to` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(8,2) DEFAULT NULL,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_details_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `refund_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `delivery_man_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `comment` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `is_saved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `salaries`
--

CREATE TABLE `salaries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `salaries`
--

INSERT INTO `salaries` (`id`, `type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'ريال يمني', NULL, '2023-01-01 20:33:18', '2023-03-13 19:59:17');

-- --------------------------------------------------------

--
-- بنية الجدول `save_advertis`
--

CREATE TABLE `save_advertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `advertis_id` bigint(20) UNSIGNED NOT NULL,
  `users_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `save_advertis`
--

INSERT INTO `save_advertis` (`id`, `advertis_id`, `users_id`, `created_at`, `updated_at`) VALUES
(7, 11, 3, '2023-01-25 21:39:35', '2023-01-25 21:39:35'),
(9, 14, 3, '2023-01-25 21:39:44', '2023-01-25 21:39:44'),
(18, 19, 3, '2023-02-07 17:11:58', '2023-02-07 17:11:58'),
(21, 20, 3, '2023-02-10 11:32:01', '2023-02-10 11:32:01'),
(46, 17, 3, '2023-02-11 00:26:54', '2023-02-11 00:26:54'),
(47, 7, 3, '2023-02-11 00:29:20', '2023-02-11 00:29:20'),
(48, 8, 3, '2023-02-11 00:32:31', '2023-02-11 00:32:31'),
(49, 26, 3, '2023-02-11 00:32:37', '2023-02-11 00:32:37'),
(56, 8, 4, '2023-03-12 22:33:31', '2023-03-12 22:33:31'),
(57, 7, 4, '2023-03-15 15:50:51', '2023-03-15 15:50:51'),
(59, 27, 4, '2023-03-23 23:31:55', '2023-03-23 23:31:55'),
(84, 99, 4, '2023-03-25 21:12:35', '2023-03-25 21:12:35'),
(87, 98, 4, '2023-03-25 21:13:46', '2023-03-25 21:13:46'),
(90, 66, 4, '2023-03-26 23:58:05', '2023-03-26 23:58:05');

-- --------------------------------------------------------

--
-- بنية الجدول `search_functions`
--

CREATE TABLE `search_functions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visible_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `search_functions`
--

INSERT INTO `search_functions` (`id`, `key`, `url`, `visible_for`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'admin/dashboard', 'admin', NULL, NULL),
(2, 'Order All', 'admin/orders/list/all', 'admin', NULL, NULL),
(3, 'Order Pending', 'admin/orders/list/pending', 'admin', NULL, NULL),
(4, 'Order Processed', 'admin/orders/list/processed', 'admin', NULL, NULL),
(5, 'Order Delivered', 'admin/orders/list/delivered', 'admin', NULL, NULL),
(6, 'Order Returned', 'admin/orders/list/returned', 'admin', NULL, NULL),
(7, 'Order Failed', 'admin/orders/list/failed', 'admin', NULL, NULL),
(8, 'Brand Add', 'admin/brand/add-new', 'admin', NULL, NULL),
(9, 'Brand List', 'admin/brand/list', 'admin', NULL, NULL),
(10, 'Banner', 'admin/banner/list', 'admin', NULL, NULL),
(11, 'Category', 'admin/category/view', 'admin', NULL, NULL),
(12, 'Sub Category', 'admin/category/sub-category/view', 'admin', NULL, NULL),
(13, 'Sub sub category', 'admin/category/sub-sub-category/view', 'admin', NULL, NULL),
(14, 'Attribute', 'admin/attribute/view', 'admin', NULL, NULL),
(15, 'Product', 'admin/product/list', 'admin', NULL, NULL),
(16, 'Coupon', 'admin/coupon/add-new', 'admin', NULL, NULL),
(17, 'Custom Role', 'admin/custom-role/create', 'admin', NULL, NULL),
(18, 'Employee', 'admin/employee/add-new', 'admin', NULL, NULL),
(19, 'Seller', 'admin/sellers/seller-list', 'admin', NULL, NULL),
(20, 'Contacts', 'admin/contact/list', 'admin', NULL, NULL),
(21, 'Flash Deal', 'admin/deal/flash', 'admin', NULL, NULL),
(22, 'Deal of the day', 'admin/deal/day', 'admin', NULL, NULL),
(23, 'Language', 'admin/business-settings/language', 'admin', NULL, NULL),
(24, 'Mail', 'admin/business-settings/mail', 'admin', NULL, NULL),
(25, 'Shipping method', 'admin/business-settings/shipping-method/add', 'admin', NULL, NULL),
(26, 'Currency', 'admin/currency/view', 'admin', NULL, NULL),
(27, 'Payment method', 'admin/business-settings/payment-method', 'admin', NULL, NULL),
(28, 'SMS Gateway', 'admin/business-settings/sms-gateway', 'admin', NULL, NULL),
(29, 'Support Ticket', 'admin/support-ticket/view', 'admin', NULL, NULL),
(30, 'FAQ', 'admin/helpTopic/list', 'admin', NULL, NULL),
(31, 'About Us', 'admin/business-settings/about-us', 'admin', NULL, NULL),
(32, 'Terms and Conditions', 'admin/business-settings/terms-condition', 'admin', NULL, NULL),
(33, 'Web Config', 'admin/business-settings/web-config', 'admin', NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `sellers`
--

CREATE TABLE `sellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_commission_percentage` double(8,2) DEFAULT NULL,
  `gst` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cm_firebase_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pos_status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `sellers`
--

INSERT INTO `sellers` (`id`, `f_name`, `l_name`, `phone`, `image`, `email`, `password`, `status`, `remember_token`, `created_at`, `updated_at`, `bank_name`, `branch`, `account_no`, `holder_name`, `auth_token`, `sales_commission_percentage`, `gst`, `cm_firebase_token`, `pos_status`) VALUES
(1, 'mahmooud', 'AL_batran', '0597051897', '2023-01-05-63b5bfdfae736.png', 'mahmod.albatran.20@gmail.com', '$2y$10$PhVTydGSDD//pN67OpDzMeM..8dttHXY75m4OG6VRBbV.qw7ENO1W', 'approved', '9Cbey3mWG0fMX5ZcWGTHORDWM7wdPruhY0SJDRrO7P92fxIEnoWxpG84rEwG', '2023-01-04 22:05:19', '2023-01-04 22:07:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(3, 'asd', 'asd', '55125454', '2023-01-09-63bc41022dca3.png', 'asd@gmail.com', '$2y$10$1tLtA7CGZiPj.RtOenYzn.QmAsCFEoUeD1FkDxdd09ZHDYfoLB3ca', 'approved', NULL, '2023-01-09 20:29:54', '2023-01-09 20:29:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- بنية الجدول `seller_wallets`
--

CREATE TABLE `seller_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `total_earning` double NOT NULL DEFAULT 0,
  `withdrawn` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `commission_given` double(8,2) NOT NULL DEFAULT 0.00,
  `pending_withdraw` double(8,2) NOT NULL DEFAULT 0.00,
  `delivery_charge_earned` double(8,2) NOT NULL DEFAULT 0.00,
  `collected_cash` double(8,2) NOT NULL DEFAULT 0.00,
  `total_tax_collected` double(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `seller_wallets`
--

INSERT INTO `seller_wallets` (`id`, `seller_id`, `total_earning`, `withdrawn`, `created_at`, `updated_at`, `commission_given`, `pending_withdraw`, `delivery_charge_earned`, `collected_cash`, `total_tax_collected`) VALUES
(1, 1, 0, 0, '2023-01-04 22:05:19', '2023-01-04 22:05:19', 0.00, 0.00, 0.00, 0.00, 0.00),
(2, 2, 0, 0, '2023-01-08 21:14:03', '2023-01-08 21:14:03', 0.00, 0.00, 0.00, 0.00, 0.00),
(3, 3, 0, 0, '2023-01-09 20:29:54', '2023-01-09 20:29:54', 0.00, 0.00, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- بنية الجدول `seller_wallet_histories`
--

CREATE TABLE `seller_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `payment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'received',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `shipping_addresses`
--

CREATE TABLE `shipping_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_billing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `shipping_addresses`
--

INSERT INTO `shipping_addresses` (`id`, `customer_id`, `contact_person_name`, `address_type`, `address`, `city`, `zip`, `phone`, `created_at`, `updated_at`, `state`, `country`, `latitude`, `longitude`, `is_billing`) VALUES
(1, '2', 'mahmooud AL_batran', 'home', 'Bureij-Martyrs\' Roundabout', 'Gaza', '8540400', '0597051897', '2023-01-04 21:36:22', '2023-01-04 21:36:22', NULL, 'Afghanistan', '0', '0', 0),
(2, '2', 'mahmooud AL_batran', 'home', 'Bureij-Martyrs\' Roundabout', 'Gaza', '8540400', '0597051897', '2023-01-04 21:36:33', '2023-01-04 21:36:33', NULL, 'Afghanistan', '0', '0', 0),
(3, '4', 'Abdulkreem Ali Alqabali', 'home', 'الدائري - جوار الشامل سيتي\r\nالدائري - امام سيتي مارت', 'صنعاء', '001', '0776539779', '2023-03-17 19:00:04', '2023-03-17 19:00:04', NULL, 'Yemen', '', '', 0);

-- --------------------------------------------------------

--
-- بنية الجدول `shipping_methods`
--

CREATE TABLE `shipping_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `duration` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `shipping_methods`
--

INSERT INTO `shipping_methods` (`id`, `creator_id`, `creator_type`, `title`, `cost`, `duration`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 'admin', 'Company Vehicle', '5.00', '2 Week', 1, '2021-05-25 20:57:04', '2021-05-25 20:57:04');

-- --------------------------------------------------------

--
-- بنية الجدول `shipping_types`
--

CREATE TABLE `shipping_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shipping_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `shops`
--

CREATE TABLE `shops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `banner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `shops`
--

INSERT INTO `shops` (`id`, `seller_id`, `name`, `address`, `contact`, `image`, `created_at`, `updated_at`, `banner`) VALUES
(1, 1, 'store', 'aLborag', '0597051897', '2023-01-05-63b5bfdfbf1a4.png', '2023-01-04 22:05:19', '2023-01-04 22:05:19', '2023-01-05-63b5bfdfbf719.png'),
(2, 2, 'store', 'aLborag', '0594648645', '2023-01-08-63baf9dbd9c8e.png', '2023-01-08 21:14:03', '2023-01-08 21:14:03', '2023-01-08-63baf9dbda0c2.png'),
(3, 3, 'storess', 'aLboragasd', '55125454', '2023-01-09-63bc410267351.png', '2023-01-09 20:29:54', '2023-01-09 20:29:54', '2023-01-09-63bc410267bba.png');

-- --------------------------------------------------------

--
-- بنية الجدول `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `skills`
--

INSERT INTO `skills` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'التواصل مع الاخرين', NULL, '2023-01-01 20:43:57', '2023-03-13 20:05:46'),
(2, 'العمل ضمن فريق', NULL, '2023-03-17 01:31:08', '2023-03-17 01:31:08');

-- --------------------------------------------------------

--
-- بنية الجدول `social_medias`
--

CREATE TABLE `social_medias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `social_medias`
--

INSERT INTO `social_medias` (`id`, `name`, `link`, `icon`, `active_status`, `status`, `created_at`, `updated_at`) VALUES
(1, 'twitter', 'https://www.w3schools.com/howto/howto_css_table_responsive.asp', 'fa fa-twitter', 1, 1, '2020-12-31 21:18:03', '2020-12-31 21:18:25'),
(2, 'linkedin', 'https://dev.6amtech.com/', 'fa fa-linkedin', 1, 1, '2021-02-27 16:23:01', '2021-02-27 16:23:05'),
(3, 'google-plus', 'https://dev.6amtech.com/', 'fa fa-google-plus-square', 1, 1, '2021-02-27 16:23:30', '2021-02-27 16:23:33'),
(4, 'pinterest', 'https://dev.6amtech.com/', 'fa fa-pinterest', 1, 1, '2021-02-27 16:24:14', '2021-02-27 16:24:26'),
(5, 'instagram', 'https://dev.6amtech.com/', 'fa fa-instagram', 1, 1, '2021-02-27 16:24:36', '2021-02-27 16:24:41'),
(6, 'facebook', 'facebook.com', 'fa fa-facebook', 1, 1, '2021-02-27 19:19:42', '2021-06-11 17:41:59');

-- --------------------------------------------------------

--
-- بنية الجدول `soft_credentials`
--

CREATE TABLE `soft_credentials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `state_advertis`
--

CREATE TABLE `state_advertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `state_advertis`
--

INSERT INTO `state_advertis` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'اليمن', NULL, '2023-01-01 20:48:06', '2023-03-13 20:06:11');

-- --------------------------------------------------------

--
-- بنية الجدول `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `subject` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `support_ticket_convs`
--

CREATE TABLE `support_ticket_convs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `customer_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `transactions`
--

CREATE TABLE `transactions` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `payment_for` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_id` bigint(20) DEFAULT NULL,
  `payment_receiver_id` bigint(20) DEFAULT NULL,
  `paid_by` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_to` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `amount` double(8,2) NOT NULL DEFAULT 0.00,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_details_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `translations`
--

CREATE TABLE `translations` (
  `translationable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `translationable_id` bigint(20) UNSIGNED NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `translations`
--

INSERT INTO `translations` (`translationable_type`, `translationable_id`, `locale`, `key`, `value`, `id`) VALUES
('App\\Model\\Advertis', 23, 'ye', 'name', 'xczczxcxz', 1),
('App\\Model\\Advertis', 23, 'ye', 'description', '<p>zxczxczxczc</p>', 2),
('App\\Model\\Advertis', 24, 'ye', 'name', 'dasdsadasd', 3),
('App\\Model\\Advertis', 24, 'ye', 'description', '<p>asdasdasdad</p>', 4),
('App\\Model\\Advertis', 26, 'ye', 'name', 'cxvxcvbbbbbbbbb', 5),
('App\\Model\\Advertis', 26, 'ye', 'description', '<p>cxvxcvbbbbbbbbb</p>', 6),
('App\\Model\\Advertis', 67, 'ye', 'name', 'تجريبي ادمن', 7),
('App\\Model\\Advertis', 67, 'ye', 'description', '<p>تجريبي ادمن</p>', 8),
('App\\Model\\Advertis', 68, 'ye', 'name', 'تجريبي ادمن2', 9),
('App\\Model\\Advertis', 68, 'ye', 'description', '<p>تجريبي ادمن2</p>', 10),
('App\\Model\\Advertis', 69, 'ye', 'name', 'تجريبي ادمن3', 11),
('App\\Model\\Advertis', 69, 'ye', 'description', '<p>تجريبي ادمن3</p>', 12),
('App\\Model\\Advertis', 72, 'ye', 'name', 'admin Advertisment', 13),
('App\\Model\\Advertis', 72, 'ye', 'description', '<p>admin Advertisment&nbsp;</p>', 14),
('App\\Model\\Advertis', 97, 'ye', 'name', 'كيم', 15),
('App\\Model\\Advertis', 97, 'ye', 'description', 'كيم', 16),
('App\\Model\\JobTitle', 3, 'ye', 'name', 'مطور تطبيقات', 17),
('App\\Model\\AdvertiseType', 2, 'ye', 'name', 'منظمة', 18),
('App\\Model\\Product', 2, 'ye', 'name', 'صنف عربي', 19),
('App\\Model\\Product', 2, 'ye', 'description', '<p>صنف عربي</p>', 20),
('App\\Model\\Category', 1, 'ye', 'name', 'سيارات', 21),
('App\\Model\\CareerSector', 4, 'ye', 'name', 'نظم معلومات ادارية', 22),
('App\\Model\\JobTitle', 12, 'ye', 'name', 'مطور ويب 2', 23),
('App\\Model\\Advertis', 104, 'ye', 'name', 'note 10', 24),
('App\\Model\\Advertis', 104, 'ye', 'description', '<p>note 10</p>', 25);

-- --------------------------------------------------------

--
-- بنية الجدول `type_contracts`
--

CREATE TABLE `type_contracts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `type_contracts`
--

INSERT INTO `type_contracts` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, '3 سنوات قابل للتجديد', NULL, '2023-01-01 19:53:39', '2023-03-13 19:56:58'),
(2, 'عقد خمس سنوات', NULL, '2023-03-17 18:03:05', '2023-03-17 18:03:05');

-- --------------------------------------------------------

--
-- بنية الجدول `type_work_hours`
--

CREATE TABLE `type_work_hours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `type_work_hours`
--

INSERT INTO `type_work_hours` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, '40 ساعة بالاسبوع', NULL, '2023-01-01 19:59:40', '2023-03-17 18:07:29'),
(2, '7 ساعات باليوم', NULL, '2023-03-17 18:07:10', '2023-03-17 18:07:10');

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `f_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `street_address` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `house_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apartment_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cm_firebase_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `payment_card_last_four` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_card_fawry_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `login_medium` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_phone_verified` tinyint(1) NOT NULL DEFAULT 0,
  `temporary_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `wallet_balance` double(8,2) DEFAULT NULL,
  `loyalty_point` double(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `f_name`, `l_name`, `phone`, `image`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `street_address`, `country`, `city`, `zip`, `house_no`, `apartment_no`, `cm_firebase_token`, `is_active`, `payment_card_last_four`, `payment_card_brand`, `payment_card_fawry_token`, `login_medium`, `social_id`, `is_phone_verified`, `temporary_token`, `is_email_verified`, `wallet_balance`, `loyalty_point`) VALUES
(0, 'walking customer', 'walking', 'customer', '000000000000', 'def.png', 'walking@customer.com', NULL, '', NULL, NULL, '2022-02-03 03:46:01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL),
(1, 'ali', 'ali', 'ali', '597051897', 'def.png', 'alboraj@gmail.com', NULL, '$2y$10$TNReAP2KMlMGgbAERcygxeuhzOKlcXzbjApvWDdQNQLyfkfy68byK', 'RP5p0XmEyIwRMOt67iJNTGkqkIcRZSTjxyDugc4tcRWpZRs0AcgpIOLzBDCK', '2023-01-02 22:10:42', '2023-01-25 19:00:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL),
(2, NULL, 'mah', 'albatr', '1234578', 'def.png', 'mah@gmail.com', NULL, '$2y$10$TNReAP2KMlMGgbAERcygxeuhzOKlcXzbjApvWDdQNQLyfkfy68byK', 'MbkuBvI4ybRlCiY22AJwbuTFuWRnY3aWYz9ieYvsE7oq3Iw6szmIRCzWGR3q', '2023-01-03 02:15:55', '2023-01-03 02:15:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL),
(3, NULL, 'mahmood', 'albatran', '0597051897', 'def.png', 'mahmod.albatran.20@gmail.com', NULL, '$2y$10$C7LQQZYpWhCvB4W4pxE9KOj1se8m98okl4gv9VX6j20IEnOIiS9i2', 'mJJN0u5B5sRmasWM4wUku7Hi6SUs5tZVtSS44CCW3O4sYgdID3SNgsRIJDJn', '2023-01-25 19:05:28', '2023-01-25 19:05:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL),
(4, NULL, 'Abdulkreem', 'Alqabali', '0776539779', 'def.png', 'wev707wkim@gmail.com', NULL, '$2y$10$3ePMDzAu/D0wdQ.zyych8OeFmVoGvuYVVouIYDJiZmGDYuNVXjbuS', 'l6JVr1IcLjp7XnFpXaG8D31u7N3WiZ1FaNI1qO0SXjzjnsi5IaPSPbRDiOfn', '2023-02-11 23:34:39', '2023-03-23 22:57:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, 'JBSBn3Rf22TGDawYcNDHMdFiCYmUNRrHUQZJBj4E', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `debit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `admin_bonus` decimal(24,3) NOT NULL DEFAULT 0.000,
  `balance` decimal(24,3) NOT NULL DEFAULT 0.000,
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `wishlists`
--

INSERT INTO `wishlists` (`id`, `customer_id`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '2023-01-09 20:55:10', '2023-01-09 20:55:10'),
(2, 1, 2, '2023-01-10 00:58:51', '2023-01-10 00:58:51'),
(3, 1, 8, '2023-01-25 17:20:18', '2023-01-25 17:20:18'),
(4, 3, 2, '2023-01-25 20:22:25', '2023-01-25 20:22:25'),
(5, 3, 1, '2023-02-07 23:27:21', '2023-02-07 23:27:21'),
(6, 4, 1, '2023-03-23 23:32:35', '2023-03-23 23:32:35');

-- --------------------------------------------------------

--
-- بنية الجدول `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `delivery_man_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `transaction_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `work_days`
--

CREATE TABLE `work_days` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `workDays` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `work_days`
--

INSERT INTO `work_days` (`id`, `workDays`, `description`, `created_at`, `updated_at`) VALUES
(1, 5, NULL, '2023-01-01 19:58:12', '2023-03-13 19:57:21'),
(2, 6, NULL, '2023-03-17 18:04:47', '2023-03-17 18:04:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_wallets`
--
ALTER TABLE `admin_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_wallet_histories`
--
ALTER TABLE `admin_wallet_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `advertis`
--
ALTER TABLE `advertis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `advertis_career_sector_id_foreign` (`career_sector_id`),
  ADD KEY `advertis_job_title_id_foreign` (`job_title_id`),
  ADD KEY `advertis_advertise_type_id_foreign` (`advertise_type_id`),
  ADD KEY `advertis_education_degree_id_foreign` (`education_degree_id`),
  ADD KEY `advertis_type_contract_id_foreign` (`type_contract_id`),
  ADD KEY `advertis_work_day_id_foreign` (`work_day_id`),
  ADD KEY `advertis_type_work_hour_id_foreign` (`type_work_hour_id`),
  ADD KEY `advertis_salary_id_foreign` (`salary_id`),
  ADD KEY `advertis_experience_id_foreign` (`experience_id`),
  ADD KEY `advertis_nationality_id_foreign` (`nationality_id`),
  ADD KEY `advertis_city_advertis_id_foreign` (`city_advertis_id`),
  ADD KEY `advertis_state_advertis_id_foreign` (`state_advertis_id`),
  ADD KEY `advertis_governorates_id_foreign` (`governorates_id`),
  ADD KEY `advertis_actor_type_actor_id_index` (`actor_type`,`actor_id`);

--
-- Indexes for table `advertise_types`
--
ALTER TABLE `advertise_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `advertis_extra_benefit`
--
ALTER TABLE `advertis_extra_benefit`
  ADD PRIMARY KEY (`advertis_id`,`extra_benefit_id`),
  ADD KEY `advertis_extra_benefit_extra_benefit_id_foreign` (`extra_benefit_id`);

--
-- Indexes for table `advertis_language`
--
ALTER TABLE `advertis_language`
  ADD PRIMARY KEY (`advertis_id`,`language_id`),
  ADD KEY `advertis_language_language_id_foreign` (`language_id`);

--
-- Indexes for table `advertis_license`
--
ALTER TABLE `advertis_license`
  ADD PRIMARY KEY (`advertis_id`,`license_id`),
  ADD KEY `advertis_license_license_id_foreign` (`license_id`);

--
-- Indexes for table `advertis_skill`
--
ALTER TABLE `advertis_skill`
  ADD PRIMARY KEY (`advertis_id`,`skill_id`),
  ADD KEY `advertis_skill_skill_id_foreign` (`skill_id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billing_addresses`
--
ALTER TABLE `billing_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_settings`
--
ALTER TABLE `business_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `career_sectors`
--
ALTER TABLE `career_sectors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart_shippings`
--
ALTER TABLE `cart_shippings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_shipping_costs`
--
ALTER TABLE `category_shipping_costs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chattings`
--
ALTER TABLE `chattings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `city_advertis`
--
ALTER TABLE `city_advertis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_advertis_state_advertis_id_foreign` (`state_advertis_id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_wallets`
--
ALTER TABLE `customer_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_wallet_histories`
--
ALTER TABLE `customer_wallet_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deal_of_the_days`
--
ALTER TABLE `deal_of_the_days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveryman_notifications`
--
ALTER TABLE `deliveryman_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveryman_wallets`
--
ALTER TABLE `deliveryman_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_country_codes`
--
ALTER TABLE `delivery_country_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_man_transactions`
--
ALTER TABLE `delivery_man_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_men`
--
ALTER TABLE `delivery_men`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_zip_codes`
--
ALTER TABLE `delivery_zip_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `education_degrees`
--
ALTER TABLE `education_degrees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extra_benefits`
--
ALTER TABLE `extra_benefits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_deals`
--
ALTER TABLE `feature_deals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flash_deals`
--
ALTER TABLE `flash_deals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flash_deal_products`
--
ALTER TABLE `flash_deal_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `governorates`
--
ALTER TABLE `governorates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `governorates_city_advertis_id_foreign` (`city_advertis_id`);

--
-- Indexes for table `help_topics`
--
ALTER TABLE `help_topics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_titles`
--
ALTER TABLE `job_titles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_titles_career_sector_id_foreign` (`career_sector_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loyalty_point_transactions`
--
ALTER TABLE `loyalty_point_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nationalities`
--
ALTER TABLE `nationalities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_expected_delivery_histories`
--
ALTER TABLE `order_expected_delivery_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_transactions`
--
ALTER TABLE `order_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`identity`);

--
-- Indexes for table `paytabs_invoices`
--
ALTER TABLE `paytabs_invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `phone_or_email_verifications`
--
ALTER TABLE `phone_or_email_verifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stocks`
--
ALTER TABLE `product_stocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refund_requests`
--
ALTER TABLE `refund_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refund_statuses`
--
ALTER TABLE `refund_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refund_transactions`
--
ALTER TABLE `refund_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `save_advertis`
--
ALTER TABLE `save_advertis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `search_functions`
--
ALTER TABLE `search_functions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sellers_email_unique` (`email`);

--
-- Indexes for table `seller_wallets`
--
ALTER TABLE `seller_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_wallet_histories`
--
ALTER TABLE `seller_wallet_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_types`
--
ALTER TABLE `shipping_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_medias`
--
ALTER TABLE `social_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soft_credentials`
--
ALTER TABLE `soft_credentials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `state_advertis`
--
ALTER TABLE `state_advertis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_ticket_convs`
--
ALTER TABLE `support_ticket_convs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD UNIQUE KEY `transactions_id_unique` (`id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `translations_translationable_id_index` (`translationable_id`),
  ADD KEY `translations_locale_index` (`locale`);

--
-- Indexes for table `type_contracts`
--
ALTER TABLE `type_contracts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `type_work_hours`
--
ALTER TABLE `type_work_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_days`
--
ALTER TABLE `work_days`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_wallets`
--
ALTER TABLE `admin_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_wallet_histories`
--
ALTER TABLE `admin_wallet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `advertis`
--
ALTER TABLE `advertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `advertise_types`
--
ALTER TABLE `advertise_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `billing_addresses`
--
ALTER TABLE `billing_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `business_settings`
--
ALTER TABLE `business_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `career_sectors`
--
ALTER TABLE `career_sectors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_shippings`
--
ALTER TABLE `cart_shippings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category_shipping_costs`
--
ALTER TABLE `category_shipping_costs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chattings`
--
ALTER TABLE `chattings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city_advertis`
--
ALTER TABLE `city_advertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `customer_wallets`
--
ALTER TABLE `customer_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_wallet_histories`
--
ALTER TABLE `customer_wallet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deal_of_the_days`
--
ALTER TABLE `deal_of_the_days`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveryman_notifications`
--
ALTER TABLE `deliveryman_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveryman_wallets`
--
ALTER TABLE `deliveryman_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_country_codes`
--
ALTER TABLE `delivery_country_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_man_transactions`
--
ALTER TABLE `delivery_man_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_men`
--
ALTER TABLE `delivery_men`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_zip_codes`
--
ALTER TABLE `delivery_zip_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `education_degrees`
--
ALTER TABLE `education_degrees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `emergency_contacts`
--
ALTER TABLE `emergency_contacts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `extra_benefits`
--
ALTER TABLE `extra_benefits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feature_deals`
--
ALTER TABLE `feature_deals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_deals`
--
ALTER TABLE `flash_deals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_deal_products`
--
ALTER TABLE `flash_deal_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `governorates`
--
ALTER TABLE `governorates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `help_topics`
--
ALTER TABLE `help_topics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_titles`
--
ALTER TABLE `job_titles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `licenses`
--
ALTER TABLE `licenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loyalty_point_transactions`
--
ALTER TABLE `loyalty_point_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=283;

--
-- AUTO_INCREMENT for table `nationalities`
--
ALTER TABLE `nationalities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100003;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_expected_delivery_histories`
--
ALTER TABLE `order_expected_delivery_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_histories`
--
ALTER TABLE `order_status_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_transactions`
--
ALTER TABLE `order_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paytabs_invoices`
--
ALTER TABLE `paytabs_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_or_email_verifications`
--
ALTER TABLE `phone_or_email_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_stocks`
--
ALTER TABLE `product_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refund_requests`
--
ALTER TABLE `refund_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refund_statuses`
--
ALTER TABLE `refund_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refund_transactions`
--
ALTER TABLE `refund_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salaries`
--
ALTER TABLE `salaries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `save_advertis`
--
ALTER TABLE `save_advertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `search_functions`
--
ALTER TABLE `search_functions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `seller_wallets`
--
ALTER TABLE `seller_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `seller_wallet_histories`
--
ALTER TABLE `seller_wallet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `shipping_types`
--
ALTER TABLE `shipping_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `social_medias`
--
ALTER TABLE `social_medias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `soft_credentials`
--
ALTER TABLE `soft_credentials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `state_advertis`
--
ALTER TABLE `state_advertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_ticket_convs`
--
ALTER TABLE `support_ticket_convs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `type_contracts`
--
ALTER TABLE `type_contracts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `type_work_hours`
--
ALTER TABLE `type_work_hours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_days`
--
ALTER TABLE `work_days`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- قيود الجداول المحفوظة
--

--
-- القيود للجدول `city_advertis`
--
ALTER TABLE `city_advertis`
  ADD CONSTRAINT `city_advertis_state_advertis_id_foreign` FOREIGN KEY (`state_advertis_id`) REFERENCES `state_advertis` (`id`) ON DELETE CASCADE;

--
-- القيود للجدول `governorates`
--
ALTER TABLE `governorates`
  ADD CONSTRAINT `governorates_city_advertis_id_foreign` FOREIGN KEY (`city_advertis_id`) REFERENCES `city_advertis` (`id`) ON DELETE CASCADE;

--
-- القيود للجدول `job_titles`
--
ALTER TABLE `job_titles`
  ADD CONSTRAINT `job_titles_career_sector_id_foreign` FOREIGN KEY (`career_sector_id`) REFERENCES `career_sectors` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
