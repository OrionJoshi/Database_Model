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
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'inactive',
  `last_login` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`state` (
  `state_id` INT NOT NULL AUTO_INCREMENT,
  `state_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`state_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street_address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `zipcode` VARCHAR(255) NOT NULL,
  `country_country_id` INT NOT NULL,
  `state_state_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_country1_idx` (`country_country_id` ASC) VISIBLE,
  INDEX `fk_address_state1_idx` (`state_state_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `mydb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_address_state1`
    FOREIGN KEY (`state_state_id`)
    REFERENCES `mydb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manufacturer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`manufacturer` (
  `manu_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `logo_url` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `website_url` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`manu_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_manufacturer_address1_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_manufacturer_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shape`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shape` (
  `shape_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`shape_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`size`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`size` (
  `size_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `length` INT NOT NULL,
  `width` INT NOT NULL,
  `height` INT NOT NULL,
  `volume` INT NOT NULL,
  `shape_shape_id` INT NOT NULL,
  PRIMARY KEY (`size_id`),
  INDEX `fk_size_shape1_idx` (`shape_shape_id` ASC) VISIBLE,
  CONSTRAINT `fk_size_shape1`
    FOREIGN KEY (`shape_shape_id`)
    REFERENCES `mydb`.`shape` (`shape_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `users_user_id` INT NOT NULL,
  `manufacturer_manu_id` INT NOT NULL,
  `item_type_type_id` INT NOT NULL,
  `size_size_id` INT NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_item_users_idx` (`users_user_id` ASC) VISIBLE,
  INDEX `fk_item_manufacturer1_idx` (`manufacturer_manu_id` ASC) VISIBLE,
  INDEX `fk_item_item_type1_idx` (`item_type_type_id` ASC) VISIBLE,
  INDEX `fk_item_size1_idx` (`size_size_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_users`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_manufacturer1`
    FOREIGN KEY (`manufacturer_manu_id`)
    REFERENCES `mydb`.`manufacturer` (`manu_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_item_type1`
    FOREIGN KEY (`item_type_type_id`)
    REFERENCES `mydb`.`item_type` (`type_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_size1`
    FOREIGN KEY (`size_size_id`)
    REFERENCES `mydb`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_info` (
  `info_id` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `expiration_date` DATETIME NOT NULL,
  `purchase_location` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `last_used` DATETIME NULL,
  `item_item_id` INT NOT NULL,
  PRIMARY KEY (`info_id`),
  INDEX `fk_item_info_item1_idx` (`item_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_info_item1`
    FOREIGN KEY (`item_item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item_images` (
  `images_id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(255) NOT NULL,
  `item_item_id` INT NOT NULL,
  PRIMARY KEY (`images_id`),
  INDEX `fk_item_images_item1_idx` (`item_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_images_item1`
    FOREIGN KEY (`item_item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`related_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`related_item` (
  `related_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `related_item_id` INT NOT NULL,
  PRIMARY KEY (`related_id`),
  INDEX `fk_related_item_item1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_related_item_item2_idx` (`related_item_id` ASC) VISIBLE,
  CONSTRAINT `fk_related_item_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_related_item_item2`
    FOREIGN KEY (`related_item_id`)
    REFERENCES `mydb`.`item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
