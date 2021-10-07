-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 04 Eyl 2021, 21:35:31
-- Sunucu sürümü: 10.4.20-MariaDB
-- PHP Sürümü: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `depo_project`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `serach` (IN `searchData` VARCHAR(50))  BEGIN
	SELECT * FROM customer where customer.cu_name or customer.cu_surname; 

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `id` int(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nameSurname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`id`, `email`, `password`, `nameSurname`) VALUES
(1, 'ig@mail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'İlayda Güler');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `box`
--

CREATE TABLE `box` (
  `b_id` int(11) NOT NULL,
  `b_bno` int(11) NOT NULL,
  `b_count` varchar(255) DEFAULT NULL,
  `b_customer_id` int(11) NOT NULL,
  `b_product_id` int(11) NOT NULL,
  `product_p_id` int(11) DEFAULT NULL,
  `b_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `box`
--

INSERT INTO `box` (`b_id`, `b_bno`, `b_count`, `b_customer_id`, `b_product_id`, `product_p_id`, `b_status`) VALUES
(10, 3, '1', 13, 2, NULL, 1),
(12, 7, '2', 15, 2, NULL, 1),
(13, 7, '1', 15, 2, NULL, 1),
(18, 7, '2', 15, 4, NULL, 0),
(20, 9, '2', 2, 2, NULL, 1),
(21, 6, '7', 12, 2, NULL, 1),
(22, 2, '1', 3, 5, NULL, 1),
(23, 10, '2', 19, 7, NULL, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `boxcustomerproduct`
--

CREATE TABLE `boxcustomerproduct` (
  `b_id` int(11) NOT NULL,
  `cu_name` varchar(255) DEFAULT NULL,
  `b_bno` int(11) NOT NULL,
  `b_count` int(11) NOT NULL,
  `cu_surname` varchar(255) DEFAULT NULL,
  `p_title` varchar(255) DEFAULT NULL,
  `p_sales_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customer`
--

CREATE TABLE `customer` (
  `cu_id` int(11) NOT NULL,
  `cu_address` varchar(500) DEFAULT NULL,
  `cu_code` bigint(20) NOT NULL,
  `cu_company_title` varchar(255) DEFAULT NULL,
  `cu_email` varchar(500) DEFAULT NULL,
  `cu_mobile` varchar(255) DEFAULT NULL,
  `cu_name` varchar(255) DEFAULT NULL,
  `cu_password` varchar(32) DEFAULT NULL,
  `cu_phone` varchar(255) DEFAULT NULL,
  `cu_status` int(11) NOT NULL,
  `cu_surname` varchar(255) DEFAULT NULL,
  `cu_tax_administration` varchar(255) DEFAULT NULL,
  `cu_tax_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `customer`
--

INSERT INTO `customer` (`cu_id`, `cu_address`, `cu_code`, `cu_company_title`, `cu_email`, `cu_mobile`, `cu_name`, `cu_password`, `cu_phone`, `cu_status`, `cu_surname`, `cu_tax_administration`, `cu_tax_number`) VALUES
(2, '', 379718765, '', '', '654653236', 'Erkan', '', '', 1, 'Bilsin', '', 123453121),
(3, '', 442547485, '', '', '12332463', 'Ediz', '', '', 1, 'tunca', '', 2135465),
(12, 'İstoç 2. ada no: 82 bağcılar/istanbul', 460638744, '', 'iguler98@gmail.com', '05365555354', 'İlayda', '', '', 1, 'Güler', '', 8965432),
(13, 'Bayrampaşa', 460987202, 'Kadir Has', '', '89745621', 'Ezgi', '', '', 2, 'Kemer', 'İstanbul', 852323),
(15, 'Maslak', 1784836, 'Company Y', 'ali@mail.com', '03648961234', 'Ali', '', '', 1, 'Bilmem', 'İstanbul', 7892156),
(19, '', 783839443, 'Company A', '', '652326', 'Defne', '', '', 1, 'Güler', '', 878);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payin`
--

CREATE TABLE `payin` (
  `pay_id` int(11) NOT NULL,
  `pay_bno` int(11) NOT NULL,
  `pay_customer_id` int(11) NOT NULL,
  `pay_detail` varchar(255) DEFAULT NULL,
  `pay_price` int(11) NOT NULL,
  `date` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payin`
--

INSERT INTO `payin` (`pay_id`, `pay_bno`, `pay_customer_id`, `pay_detail`, `pay_price`, `date`) VALUES
(1, 4, 2, NULL, 7500, NULL),
(2, 3, 12, NULL, 7500, NULL),
(4, 14, 15, NULL, 24000, '2021-09-03'),
(6, 0, 12, NULL, 0, NULL),
(7, 3, 12, NULL, 16000, NULL),
(8, 0, 12, NULL, 0, NULL),
(9, 0, 12, NULL, 0, NULL),
(10, 2, 3, NULL, 8000, NULL),
(11, 0, 3, NULL, 0, NULL),
(12, 9, 2, NULL, 16000, NULL),
(13, 0, 12, NULL, 0, NULL),
(14, 6, 12, NULL, 56000, NULL),
(15, 2, 3, NULL, 750, NULL),
(16, 10, 19, NULL, 5000, NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payout`
--

CREATE TABLE `payout` (
  `po_id` int(11) NOT NULL,
  `po_detail` varchar(255) DEFAULT NULL,
  `po_title` varchar(255) DEFAULT NULL,
  `po_total` int(11) NOT NULL,
  `po_type` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payout`
--

INSERT INTO `payout` (`po_id`, `po_detail`, `po_title`, `po_total`, `po_type`, `date`) VALUES
(3, 'tamamlandı', 'fatura', 1000, '1', NULL),
(4, 'son', 'İnternet', 200, '1', NULL),
(5, '6', 'Su', 6, '0', NULL),
(6, '', 'İnternet', 100, '3', NULL),
(7, '', 'Fatıura', 200, '1', NULL),
(8, 'tamamlandı', 'Elektrik', 200, '2', NULL),
(9, 'elektrik arızası', 'Arıza', 500, '0', NULL),
(10, 'tamamlandı', 'Su', 22, '1', NULL),
(11, 'son', 'İnternet', 200, '3', NULL),
(12, 'elektrik arızası', 'Elektrik', 200, '2', NULL),
(13, 'Eylül', 'Kira', 2000, '2', NULL),
(14, 'mutfak ', 'Gıda', 300, '1', NULL),
(15, 'son', 'Elektrik', 200, '0', NULL);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product`
--

CREATE TABLE `product` (
  `p_id` int(11) NOT NULL,
  `p_KDV` int(11) NOT NULL,
  `p_amount` int(11) NOT NULL,
  `p_code` int(11) NOT NULL,
  `p_detail` varchar(500) DEFAULT NULL,
  `p_purchase_price` int(11) NOT NULL,
  `p_sales_price` int(11) NOT NULL,
  `p_title` varchar(255) DEFAULT NULL,
  `p_unit` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `product`
--

INSERT INTO `product` (`p_id`, `p_KDV`, `p_amount`, `p_code`, `p_detail`, `p_purchase_price`, `p_sales_price`, `p_title`, `p_unit`) VALUES
(2, 2, 20, 927252179, 'Arçelik', 5000, 8000, 'Buzdolabı', '1'),
(3, 2, 30, 7378170, 'Samsung', 5000, 7500, 'Televizyon', '1'),
(4, 1, 10, 666858279, 'HP', 75000, 10000, 'bilgisayar', '1'),
(7, 2, 20, 783785768, 'teşil', 2000, 2500, 'Koltuk', '1');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `box`
--
ALTER TABLE `box`
  ADD PRIMARY KEY (`b_id`),
  ADD KEY `FKte5y043o8hbqu6klrs7jncvc0` (`product_p_id`);

--
-- Tablo için indeksler `boxcustomerproduct`
--
ALTER TABLE `boxcustomerproduct`
  ADD PRIMARY KEY (`b_id`);

--
-- Tablo için indeksler `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cu_id`);

--
-- Tablo için indeksler `payin`
--
ALTER TABLE `payin`
  ADD PRIMARY KEY (`pay_id`);

--
-- Tablo için indeksler `payout`
--
ALTER TABLE `payout`
  ADD PRIMARY KEY (`po_id`);

--
-- Tablo için indeksler `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`p_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `box`
--
ALTER TABLE `box`
  MODIFY `b_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Tablo için AUTO_INCREMENT değeri `customer`
--
ALTER TABLE `customer`
  MODIFY `cu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Tablo için AUTO_INCREMENT değeri `payin`
--
ALTER TABLE `payin`
  MODIFY `pay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `payout`
--
ALTER TABLE `payout`
  MODIFY `po_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `product`
--
ALTER TABLE `product`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `box`
--
ALTER TABLE `box`
  ADD CONSTRAINT `FKte5y043o8hbqu6klrs7jncvc0` FOREIGN KEY (`product_p_id`) REFERENCES `product` (`p_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
