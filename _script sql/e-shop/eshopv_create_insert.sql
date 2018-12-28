-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eshopv
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eshopv
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS `eshopv` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `eshopv` ;

-- -----------------------------------------------------
-- Table `eshopv`.`ACCOUNT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`ACCOUNT` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(40) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `display_name` VARCHAR(40) NOT NULL,
  `address` VARCHAR(200) NULL,
  `tel` VARCHAR(11) NULL,
  `email` VARCHAR(40) NULL,
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `avartar_url` VARCHAR(100) NULL,
  `account_type` SMALLINT NOT NULL DEFAULT 1 COMMENT '0: admin, 1: khách hàng',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `DisplayName_UNIQUE` (`display_name` ASC),
  UNIQUE INDEX `UserName_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshopv`.`ORDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`ORDERS` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `account_id` INT ZEROFILL NOT NULL,
  `date_create` DATETIME NOT NULL COMMENT 'ngày lập',
  `date_delivery` DATETIME NOT NULL COMMENT 'ngày giao',
  `total_pay` BIGINT NOT NULL COMMENT 'tổng tiền phải trả',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `status` SMALLINT NOT NULL COMMENT '0: chua giao, 1: da giao',
  `recipient_name` VARCHAR(40) NULL COMMENT 'tên người nhận',
  `recipient_tel` VARCHAR(11) NULL COMMENT 'SDT người nhận',
  `address_number` VARCHAR(20) NULL COMMENT 'số nhà',
  `street` VARCHAR(20) NULL COMMENT 'tên đường',
  `ward` VARCHAR(20) NULL COMMENT 'phường, xã',
  `district` VARCHAR(20) NULL COMMENT 'quận, huyện',
  `province` VARCHAR(20) NULL COMMENT 'tỉnh, thành phố',
  PRIMARY KEY (`id`),
  INDEX `fk_AccountID_idx` (`account_id` ASC),
  CONSTRAINT `fk_AccounID_O`
    FOREIGN KEY (`account_id`)
    REFERENCES `eshopv`.`ACCOUNT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshopv`.`PRODUCT_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`PRODUCT_TYPE` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'tên nhà sản xuất',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ProductTypeName_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshopv`.`MANUFACTURER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`MANUFACTURER` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'tên nhà sản xuất',
  `logo_url` VARCHAR(100) NULL,
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ManufactureName_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshopv`.`PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`PRODUCT` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `image_url` VARCHAR(100) NULL,
  `price` INT NULL DEFAULT 40,
  `origin` VARCHAR(40) NULL COMMENT 'xuất xứ',
  `date_added` DATETIME NULL COMMENT 'ngày nhập',
  `inventory` INT NULL DEFAULT 20 COMMENT 'Số lượng tồn',
  `solds` INT NULL DEFAULT 0 COMMENT 'số lượng bán',
  `views` INT NULL DEFAULT 0 COMMENT 'số lượt xem',
  `descreibe` TEXT NULL COMMENT 'mô tả',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `product_type_id` INT ZEROFILL NOT NULL,
  `manufacturer_id` INT ZEROFILL NOT NULL,
  `sale` INT NULL COMMENT 'giảm giá',
  PRIMARY KEY (`id`),
  INDEX `fk_ProductTypeID_idx` (`product_type_id` ASC),
  INDEX `fk_ManufacturerID_idx` (`manufacturer_id` ASC),
  CONSTRAINT `fk_ProductTypeID`
    FOREIGN KEY (`product_type_id`)
    REFERENCES `eshopv`.`PRODUCT_TYPE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ManufacturerID`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `eshopv`.`MANUFACTURER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eshopv`.`ORDER_DETAIL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eshopv`.`ORDER_DETAIL` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL COMMENT 'số lượng đặt',
  `price` INT NOT NULL COMMENT 'đơn giá',
  `order_id` INT ZEROFILL NOT NULL,
  `product_id` INT ZEROFILL NOT NULL,
  `deleted` SMALLINT NOT NULL DEFAULT 1 COMMENT '0: chưa xóa, 1: bị xóa',
  PRIMARY KEY (`id`),
  INDEX `fk_ProductID_O_idx` (`product_id` ASC),
  INDEX `fk_ProductOrderID_O_idx` (`order_id` ASC),
  CONSTRAINT `fk_ProductOrderID_O`
    FOREIGN KEY (`order_id`)
    REFERENCES `eshopv`.`ORDERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductID_O`
    FOREIGN KEY (`product_id`)
    REFERENCES `eshopv`.`PRODUCT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- INSERT
/* eshop
thứ tự nhập các bảng
ACCOUNT: TaiKhoan
PRODUCT_TYPE: LoaiSanPham
MANUFACTURER: HangSanXuat
PRODUCT: SanPham
ORDER: DonDatHang	
ORDER_DETAIL: ChiTietDonDatHang

Delete: 1-chưa xóa, 0-đã xóa
AccountType: 0-admin, 1-khách hàng
Status: 0: chưa giao, 1: đã giao
*/

/*
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(40) NOT NULL,
  `password` VARCHAR(40) NOT NULL,
  `display_name` VARCHAR(40) NOT NULL,
  `address` VARCHAR(200) NULL,
  `tel` VARCHAR(11) NULL,
  `email` VARCHAR(40) NULL,
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `avartar_url` VARCHAR(100) NULL,
  `account_type` SMALLINT NOT NULL DEFAULT 1 COMMENT '0: admin, 1: khách hàng',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `DisplayName_UNIQUE` (`display_name` ASC),
  UNIQUE INDEX `UserName_UNIQUE` (`username` ASC))
*/

insert into account(username, password, display_name, address, tel, email, avartar_url, account_type)
values
('admin01', '1256', 'Garen', null, null, null, null, 0),
('admin02', '1256', 'Camllie', null, null, null, null, 0),
('admin03', '1256', 'Ezreal', null, null, null, null, 0),
('admin04', md5('1256'), 'Aatrox', null, null, null, null, 0),

('user01', '1256', 'Lux', null, null, null, null, 1),
('user02', '1256', 'Jinx', null, null, null, null, 1),
('user03', '1256', 'Olaf', null, null, null, null, 1),
('user04', md5('1256'), 'Leona',null, null, null, null, 1);

/*
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'tên nhà sản xuất',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  PRIMARY KEY (`id`),
*/

insert into product_type(name)
values 
('túi xách'),
('áo'),
('giày'),
('quần'),
('đồng hồ');

/*
   `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL COMMENT 'tên nhà sản xuất',
  `logo_url` VARCHAR(100) NULL,
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
*/

insert into manufacturer(name, logo_url)
values 
('adidas', 'adidas_logo01.jpg'),
('an phước', 'anphuoc_logo01.jpg'),
('casio', 'casio_logo01.jpg'),
('levi', 'levi_logo01.jpg'),
('nike', 'nike_logo01.jpg'),
('seiko', 'seiko_logo01.jpg'),
('việt tiến', 'viettien_logo01.jpg');

/*
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `image_url` VARCHAR(100) NULL,
  `price` INT NULL DEFAULT 40,
  `origin` VARCHAR(40) NULL COMMENT 'xuất xứ',
  `date_added` DATETIME NULL COMMENT 'ngày nhập',
  `inventory` INT NULL DEFAULT 20 COMMENT 'Số lượng tồn',
  `sold` INT NULL DEFAULT 0 COMMENT 'số lượng bán',
  `views` INT NULL DEFAULT 0 COMMENT 'số lượt xem',
  `descreibe` TEXT NULL COMMENT 'mô tả',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `product_type_id` INT ZEROFILL NOT NULL,
  `manufacturer_id` INT ZEROFILL NOT NULL,
  `sale` INT NULL COMMENT 'giảm giá',
*/

/*
1('adidas', null, 1),
2('an phước', null, 1),
3('casio', null, 1),
4('levi', null, 1),
5('nike', null, 1),
6('seiko', null, 1),
7('việt tiến', null, 1);

1('bag', 1),
2('shirt', 1),
3('shoe', 1),
4('pant', 1),
5('watch', 1);
*/

insert into product(name, image_url, price, origin, date_added, descreibe, product_type_id, manufacturer_id, sale)
values 
 -- adidas
('adidas aop national', 'adidas_bags01.jpg', 50, 'USA', date_sub(now(), interval '0:0' hour_minute), null, 1, 1, null),
('adidas school bags', 'adidas_bags02.jpg', 45, 'USA', date_sub(now(), interval '0:0' hour_minute), null, 1, 1, null),
('black adidas duffle', 'adidas_bags03.jpg', 40, 'USA', date_sub(now(), interval '0:0' hour_minute),null, 1, 1, null),
('adidas Adibreak', 'adidas_pants01.jpg', 50, 'USA', date_sub(now(), interval '0:1' hour_minute), null, 4, 1, null),
('adidas women', 'adidas_pants02.jpg', 55, 'USA', date_sub(now(), interval '0:1' hour_minute), null, 4, 1, null),
('adidas dh4558 usa', 'adidas_pants03.jpg', 55, 'USA', date_sub(now(), interval '0:1' hour_minute), null, 4, 1, null),
('adidas white t shirt', 'adidas_shirts01.jpg', 55, 'USA', date_sub(now(), interval '0:2' hour_minute), null, 2, 1, null),
('adidas polo sports', 'adidas_shirts02.jpg', 55, 'USA', date_sub(now(), interval '0:2' hour_minute), null, 2, 1, null),
('adidas - TShirts', 'adidas_shirts03.jpg', 55, 'USA', date_sub(now(), interval '0:2' hour_minute), null, 2, 1, null),
('Adidas Prophere', 'adidas_shoes01.jpg', 45, 'USA', date_sub(now(), interval '0:3' hour_minute), null, 3, 1, null),
('adidas superstar', 'adidas_shoes02.jpg', 120, 'USA', date_sub(now(), interval '0:3' hour_minute), null, 3, 1, null),
('adidas ultra boost', 'adidas_shoes03.jpg', 150, 'USA', date_sub(now(), interval '0:3' hour_minute), null, 3, 1, null),
('adidas R1', 'adidas_shoes04.jpg', 300, 'USA', date_sub(now(), interval '0:3' hour_minute), null, 3, 1, null),
('adidas Marquee Boost Shoes', 'adidas_shoes05.jpg', 150, 'USA', date_sub(now(), interval '0:3' hour_minute), null, 3, 1, null),

 -- an phước
('An phuoc short', 'anphuoc_pant01.jpg', 25, 'Vietnam', date_sub(now(), interval '0:4' hour_minute), null, 4, 2, null),
('Anphuoc ASH000227', 'anphuoc_pant02.jpg', 30, 'Vietnam', date_sub(now(), interval '0:4' hour_minute), null, 4, 2, null),
('An Phuoc ASH000247', 'anphuoc_pant03.jpg', 50, 'Vietnam', date_sub(now(), interval '0:4' hour_minute), null, 4, 2, null),
('An Phuoc Dr. Denim', 'anphuoc_pant04.jpg', 55, 'Vietnam', date_sub(now(), interval '0:4' hour_minute), null, 4, 2, null),
('An Phuoc ASN001500', 'anphuoc_shirts01.jpg', 50, 'Vietnam', date_sub(now(), interval '0:5' hour_minute), null, 2, 2, null),
('An Phuoc ASD000924', 'anphuoc_shirts02.jpg', 55, 'Vietnam', date_sub(now(), interval '0:5' hour_minute), null, 2, 2, null),
('An Phuoc ASN001343', 'anphuoc_shirts03.jpg', 56, 'Vietnam', date_sub(now(), interval '0:5' hour_minute),null, 2, 2, null),
('An Phuoc  ATH000221', 'anphuoc_shirts04.jpg', 55, 'Vietnam', date_sub(now(), interval '0:5' hour_minute), null, 2, 2, null),
('An Phuoc ASDN001113', 'anphuoc_shirts05.jpg', 50, 'Vietnam', date_sub(now(), interval '0:5' hour_minute), null, 2, 2, null),
('An Phuoc ADDN11100', 'anphuoc_shirts06.jpg', 45, 'Vietnam', date_sub(now(), interval '0:5' hour_minute), null, 2, 2, null),

-- casio
('casio era 600d', 'casio_watches01.jpg', 55, 'Japan', date_sub(now(), interval '0:6' hour_minute), null, 5, 3, null),
('casio men', 'casio_watches02.jpg', 50, 'Japan', date_sub(now(), interval '0:6' hour_minute), null, 5, 3, null),
('casio dw5900 bb', 'casio_watches03.jpg', 45, 'Japan', date_sub(now(), interval '0:6' hour_minute), null, 5, 3, null),

-- levi
('Levi Jeans', 'levi_bags01.jpg', 100, 'USA', date_sub(now(), interval '0:7' hour_minute),null, 1, 4, null),
('Levis small bag', 'levi_bags02.jpg', 140, 'USA', date_sub(now(), interval '0:7' hour_minute), null, 1, 4, null),
('Levi Basic', 'levi_bags03.jpg', 100, 'USA', date_sub(now(), interval '0:7' hour_minute), null, 1, 4, null),

-- nike
('nike taka', 'nike_shirts01.jpg', 25, 'USA', date_sub(now(), interval '0:8' hour_minute), null, 2, 5, null),
('nike cv9888', 'nike_shirts02.jpg', 200, 'USA', date_sub(now(), interval '0:8' hour_minute), null, 2, 5, null),
('nike Notre Dame', 'nike_shirts03.jpg', 100, 'USA', date_sub(now(), interval '0:8' hour_minute), null, 2, 5, null),
('nike homer simpson', 'nike_shirts04.jpg', 100, 'USA', date_sub(now(), interval '0:8' hour_minute), null, 2, 5, null),
('nike t shirt', 'nike_shirts05.jpg', 100, 'USA', date_sub(now(), interval '0:8' hour_minute), null, 2, 5, null),
('nikeair force', 'nike_shoes01.jpg', 140, 'USA', date_sub(now(), interval '0:9' hour_minute), null, 3, 5, null),
('nike air max', 'nike_shoes02.jpg', 150, 'USA', date_sub(now(), interval '0:9' hour_minute), null, 3, 5, null),
('nike air max', 'nike_shoes03.jpg', 100, 'USA', date_sub(now(), interval '0:9' hour_minute), null, 3, 5, null),

-- seiko
('Seiko army', 'seiko_watches01.jpg', 200, 'Japan', date_sub(now(), interval '0:10' hour_minute), null, 5, 6, null),
('Seiko 5', 'seiko_watches02.jpg', 140, 'Japan', date_sub(now(), interval '0:10' hour_minute), null, 5, 6, null),
('Seiko srz469p1', 'seiko_watches03.jpg', 100, 'Japan', date_sub(now(), interval '0:10' hour_minute), null, 5, 6, null),
('Seiko 5 snkk71', 'seiko_watches04.jpg', 100, 'Japan', date_sub(now(), interval '0:10' hour_minute), null, 5, 6, null),
('Seiko szzc42', 'seiko_watches05.jpg', 80, 'Japan', date_sub(now(), interval '0:10' hour_minute), null, 5, 6, null),

-- việt tiến
('Viettien so 97', 'viettien_pants01.jpg', 25, 'Vietnam', date_sub(now(), interval '0:11' hour_minute), null, 4, 7, null),
('Viettien so 92', 'viettien_pants02.jpg', 35, 'Vietnam', date_sub(now(), interval '0:11' hour_minute), null, 4, 7, null),
('Viettien so 57', 'viettien_pants03.jpg', 45, 'Vietnam', date_sub(now(), interval '0:11' hour_minute), null, 4, 7, null),
('Viettien 8C0037 CT4', 'viettien_shirts01.jpg', 25, 'Vietnam', date_sub(now(), interval '0:12' hour_minute), null, 2, 7, null),
('Viettien 1E0853NT5', 'viettien_shirts02.jpg', 30, 'Vietnam', date_sub(now(), interval '0:12' hour_minute), null, 2, 7, null),
('Viettien 1E1006NT6', 'viettien_shirts03.jpg', 40, 'Vietnam', date_sub(now(), interval '0:12' hour_minute), null, 2, 7, null),
('Viettien 1E0857NK5', 'viettien_shirts04.jpg', 35, 'Vietnam', date_sub(now(), interval '0:12' hour_minute), null, 2, 7, null),
('Viettien1E0854NT5', 'viettien_shirts05.jpg', 44, 'Vietnam', date_sub(now(), interval '0:12' hour_minute), null, 2, 7, null);


/*
   `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `account_id` INT ZEROFILL NOT NULL,
  `date_create` DATETIME NOT NULL COMMENT 'ngày lập',
  `date_delivery` DATETIME NOT NULL COMMENT 'ngày giao',
  `total_pay` BIGINT NOT NULL COMMENT 'tổng tiền phải trả',
  `deleted` SMALLINT NOT NULL DEFAULT 0 COMMENT '0: chưa xóa, 1: bị xóa',
  `status` SMALLINT NOT NULL COMMENT '0: chua giao, 1: da giao',
  `recipient_name` VARCHAR(40) NOT NULL COMMENT 'tên người nhận',
  `recipient_tel` VARCHAR(11) NULL COMMENT 'SDT người nhận',
  `address_number` VARCHAR(20) NOT NULL COMMENT 'số nhà',
  `street` VARCHAR(20) NOT NULL COMMENT 'tên đường',
  `ward` VARCHAR(20) NOT NULL COMMENT 'phường, xã',
  `district` VARCHAR(20) NOT NULL COMMENT 'quận, huyện',
  `province` VARCHAR(20) NOT NULL COMMENT 'tỉnh, thành phố',
*/

insert into orders(account_id, date_create, date_delivery, total_pay, status, 
recipient_name, recipient_tel, address_number, street, ward, district, province)
values  
(5, now(), date_add(now(), interval '2:0' hour_minute), 0, 0, 'Trãi', null, '159', 'Nguyễn Trãi', 'Phường 04', 'Quận 5', 'TP.HCM'),
(6, now(), date_add(now(), interval '2:0' hour_minute), 0, 1, 'Nguyên', null, '2222/5', 'Hàn Hải Nguyên', 'Phường 11', 'Quận 11', 'TP.HCM'),
(7, now(), date_add(now(), interval '2:0' hour_minute), 0, -1, 'Sáu', null, '150A', 'Võ Thị Sáu', 'Tân Kiên', 'Quận 3', 'TP.HCM'),
(8, now(), date_add(now(), interval '2:0' hour_minute), 0, 0, 'Trân', null, '20', 'Tống Văn Trân', 'Tân Kiên', 'Quận 11', 'TP.HCM');


/*
   `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL COMMENT 'số lượng đặt',
  `price` INT NOT NULL COMMENT 'đơn giá',
  `order_id` INT ZEROFILL NOT NULL,
  `product_id` INT ZEROFILL NOT NULL,
*/

insert into order_detail(quantity, price, order_id, product_id)
values 
(6, 0, 1, 22),
(6, 0, 1, 16),
(6, 0, 1, 20),
(6, 0, 2, 4),
(6, 0, 2, 6),
(6, 0, 2, 26),
(6, 0, 3, 12),
(6, 0, 3, 40),
(6, 0, 4, 14),
(6, 0, 4, 11);

