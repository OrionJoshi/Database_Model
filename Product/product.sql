-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'inactive',
  `activationCode` VARCHAR(45) NOT NULL,
  `forgetCode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_addresses` (
  `add_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  PRIMARY KEY (`add_id`),
  INDEX `fk_user_addresses_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_addresses_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NOT NULL,
  `category_icon` VARCHAR(255) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sub_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sub_categories` (
  `sub_cat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `categories_category_id` INT NOT NULL,
  PRIMARY KEY (`sub_cat_id`),
  INDEX `fk_sub_categories_categories1_idx` (`categories_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_sub_categories_categories1`
    FOREIGN KEY (`categories_category_id`)
    REFERENCES `mydb`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(255) NOT NULL,
  `productSlug` VARCHAR(255) NOT NULL,
  `category_id` INT NOT NULL,
  `sub_cat_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_products_categories1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_products_sub_categories1_idx` (`sub_cat_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`categories` (`category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_sub_categories1`
    FOREIGN KEY (`sub_cat_id`)
    REFERENCES `mydb`.`sub_categories` (`sub_cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_variations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_variations` (
  `pv_id` INT NOT NULL AUTO_INCREMENT,
  `products_product_id` INT NOT NULL,
  `variation_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pv_id`),
  INDEX `fk_product_variations_products1_idx` (`products_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_variations_products1`
    FOREIGN KEY (`products_product_id`)
    REFERENCES `mydb`.`products` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products_stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products_stocks` (
  `stock_id` INT NOT NULL AUTO_INCREMENT,
  `totalStock` INT NOT NULL,
  `unitPrice` FLOAT NOT NULL,
  `totalPrice` FLOAT NOT NULL,
  PRIMARY KEY (`stock_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products_variations_options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products_variations_options` (
  `opt_id` INT NOT NULL AUTO_INCREMENT,
  `variation_name` VARCHAR(45) NOT NULL,
  `product_variations_pv_id` INT NOT NULL,
  `variation_img` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  `products_stocks_stock_id` INT NOT NULL,
  PRIMARY KEY (`opt_id`),
  INDEX `fk_products_variations_options_product_variations1_idx` (`product_variations_pv_id` ASC) VISIBLE,
  INDEX `fk_products_variations_options_products_stocks1_idx` (`products_stocks_stock_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_variations_options_product_variations1`
    FOREIGN KEY (`product_variations_pv_id`)
    REFERENCES `mydb`.`product_variations` (`pv_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_variations_options_products_stocks1`
    FOREIGN KEY (`products_stocks_stock_id`)
    REFERENCES `mydb`.`products_stocks` (`stock_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
