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
  `address_number` VARCHAR(20) NOT NULL COMMENT 'số nhà',
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
