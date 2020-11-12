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
-- Table `mydb`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`people` (
  `people_id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NOT NULL,
  `l_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATETIME NOT NULL,
  `people_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `people_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `people_sex` VARCHAR(1) NOT NULL COMMENT 'Possible values:\nM = Male\nF = Female',
  PRIMARY KEY (`people_id`),
  INDEX `idx_first` (`f_name` ASC) VISIBLE,
  INDEX `idx_last` (`l_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`company` (
  `company_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  `company_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The timestamp when this record was created.',
  `company_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'The timestamp when this record was modified or updated.',
  PRIMARY KEY (`company_id`),
  INDEX `name` (`company_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`company_has_people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`company_has_people` (
  `company_has_people_id` INT NOT NULL AUTO_INCREMENT,
  `company_company_id` INT NOT NULL,
  `people_people_id` INT NOT NULL,
  PRIMARY KEY (`company_has_people_id`),
  INDEX `fk_company_has_people_company_idx` (`company_company_id` ASC) VISIBLE,
  INDEX `fk_company_has_people_people1_idx` (`people_people_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_has_people_company`
    FOREIGN KEY (`company_company_id`)
    REFERENCES `mydb`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_has_people_people1`
    FOREIGN KEY (`people_people_id`)
    REFERENCES `mydb`.`people` (`people_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_state` VARCHAR(2) NOT NULL,
  `address_city` VARCHAR(45) NOT NULL,
  `address_zip` VARCHAR(45) NOT NULL,
  `address_street` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `idx_zip` (`address_zip` ASC) INVISIBLE,
  INDEX `idx_city` (`address_city` ASC) INVISIBLE,
  INDEX `idx_state` (`address_state` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`company_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`company_has_address` (
  `company_has_address_id` INT NOT NULL AUTO_INCREMENT,
  `address_address_id` INT NOT NULL,
  `company_company_id` INT NOT NULL,
  PRIMARY KEY (`company_has_address_id`),
  INDEX `fk_company_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  INDEX `fk_company_has_address_company1_idx` (`company_company_id` ASC) VISIBLE,
  CONSTRAINT `fk_company_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_company_has_address_company1`
    FOREIGN KEY (`company_company_id`)
    REFERENCES `mydb`.`company` (`company_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`people_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`people_has_address` (
  `people_has_address_id` INT NOT NULL AUTO_INCREMENT,
  `address_address_id` INT NOT NULL,
  `people_people_id` INT NOT NULL,
  PRIMARY KEY (`people_has_address_id`),
  INDEX `fk_people_has_address_address1_idx` (`address_address_id` ASC) VISIBLE,
  INDEX `fk_people_has_address_people1_idx` (`people_people_id` ASC) VISIBLE,
  CONSTRAINT `fk_people_has_address_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_people_has_address_people1`
    FOREIGN KEY (`people_people_id`)
    REFERENCES `mydb`.`people` (`people_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`email` (
  `email_id` INT NOT NULL AUTO_INCREMENT,
  `email_address` VARCHAR(45) NOT NULL,
  `people_people_id` INT NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  INDEX `fk_email_people1_idx` (`people_people_id` ASC) VISIBLE,
  CONSTRAINT `fk_email_people1`
    FOREIGN KEY (`people_people_id`)
    REFERENCES `mydb`.`people` (`people_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
