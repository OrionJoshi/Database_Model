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
-- Table `mydb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie` (
  `mov_id` INT NOT NULL AUTO_INCREMENT,
  `mov_title` VARCHAR(45) NOT NULL,
  `mov_year` DATETIME NOT NULL,
  `mov_time` DATETIME NOT NULL,
  `mov_lang` VARCHAR(45) NOT NULL,
  `mov_dt_rel` DATETIME NOT NULL,
  `mov_rel_country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mov_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`actor` (
  `act_id` INT NOT NULL AUTO_INCREMENT,
  `act_fname` VARCHAR(45) NOT NULL,
  `act_lname` VARCHAR(45) NOT NULL,
  `act_gender` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`act_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie_cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie_cast` (
  `act_id` INT NOT NULL,
  `mov_id` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`act_id`, `mov_id`),
  INDEX `mov_id_idx` (`mov_id` ASC) VISIBLE,
  CONSTRAINT `mov_id`
    FOREIGN KEY (`mov_id`)
    REFERENCES `mydb`.`movie` (`mov_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `act_id`
    FOREIGN KEY (`act_id`)
    REFERENCES `mydb`.`actor` (`act_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`director` (
  `dir_id` INT NOT NULL AUTO_INCREMENT,
  `dir_fname` VARCHAR(45) NOT NULL,
  `dir_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dir_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie_direction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie_direction` (
  `dir_id` INT NOT NULL,
  `mov_id` INT NOT NULL,
  PRIMARY KEY (`dir_id`, `mov_id`),
  INDEX `mov_id_idx` (`mov_id` ASC) VISIBLE,
  CONSTRAINT `dir_id`
    FOREIGN KEY (`dir_id`)
    REFERENCES `mydb`.`director` (`dir_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mov_id1`
    FOREIGN KEY (`mov_id`)
    REFERENCES `mydb`.`movie` (`mov_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reviewer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reviewer` (
  `rev_id` INT NOT NULL AUTO_INCREMENT,
  `rev_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rev_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rating` (
  `mov_id` INT NOT NULL,
  `rev_id` INT NOT NULL,
  `rev_star` INT NOT NULL,
  `num_o_rating` INT NOT NULL,
  PRIMARY KEY (`mov_id`, `rev_id`),
  INDEX `rev_id_idx` (`rev_id` ASC) VISIBLE,
  CONSTRAINT `mov_id2`
    FOREIGN KEY (`mov_id`)
    REFERENCES `mydb`.`movie` (`mov_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `rev_id`
    FOREIGN KEY (`rev_id`)
    REFERENCES `mydb`.`reviewer` (`rev_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `cat_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie_category` (
  `mov_id` INT NOT NULL,
  `cat_id` INT NOT NULL,
  PRIMARY KEY (`mov_id`, `cat_id`),
  INDEX `cat_id_idx` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `mov_id3`
    FOREIGN KEY (`mov_id`)
    REFERENCES `mydb`.`movie` (`mov_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cat_id`
    FOREIGN KEY (`cat_id`)
    REFERENCES `mydb`.`category` (`cat_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
