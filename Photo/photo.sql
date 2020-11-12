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
-- Table `mydb`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`city_id`))
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
  `country_country_id` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  `state_state_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_country1_idx` (`country_country_id` ASC) VISIBLE,
  INDEX `fk_address_city1_idx` (`city_city_id` ASC) VISIBLE,
  INDEX `fk_address_state1_idx` (`state_state_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_country1`
    FOREIGN KEY (`country_country_id`)
    REFERENCES `mydb`.`country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `mydb`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_address_state1`
    FOREIGN KEY (`state_state_id`)
    REFERENCES `mydb`.`state` (`state_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`member` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone_no` VARCHAR(20) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_member_address_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_address`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location_abbr` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`album` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `view` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`album_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`photo` (
  `photo_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `privacy` VARCHAR(45) NOT NULL,
  `upload_date` DATETIME NOT NULL,
  `view` INT NOT NULL DEFAULT 0,
  `location_location_id` INT NOT NULL,
  `member_member_id` INT NOT NULL,
  `album_album_id` INT NOT NULL,
  PRIMARY KEY (`photo_id`),
  INDEX `fk_photo_location1_idx` (`location_location_id` ASC) VISIBLE,
  INDEX `fk_photo_member1_idx` (`member_member_id` ASC) VISIBLE,
  INDEX `fk_photo_album1_idx` (`album_album_id` ASC) VISIBLE,
  CONSTRAINT `fk_photo_location1`
    FOREIGN KEY (`location_location_id`)
    REFERENCES `mydb`.`location` (`location_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_photo_member1`
    FOREIGN KEY (`member_member_id`)
    REFERENCES `mydb`.`member` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_photo_album1`
    FOREIGN KEY (`album_album_id`)
    REFERENCES `mydb`.`album` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(255) NOT NULL,
  `comment_date` DATETIME NOT NULL,
  `photo_photo_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comment_photo1_idx` (`photo_photo_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_photo1`
    FOREIGN KEY (`photo_photo_id`)
    REFERENCES `mydb`.`photo` (`photo_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tag_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tag_photo` (
  `tag_photo_id` INT NOT NULL AUTO_INCREMENT,
  `photo_photo_id` INT NOT NULL,
  `tag_tag_id` INT NOT NULL,
  PRIMARY KEY (`tag_photo_id`),
  INDEX `fk_tag_photo_photo1_idx` (`photo_photo_id` ASC) VISIBLE,
  INDEX `fk_tag_photo_tag1_idx` (`tag_tag_id` ASC) VISIBLE,
  CONSTRAINT `fk_tag_photo_photo1`
    FOREIGN KEY (`photo_photo_id`)
    REFERENCES `mydb`.`photo` (`photo_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tag_photo_tag1`
    FOREIGN KEY (`tag_tag_id`)
    REFERENCES `mydb`.`tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
