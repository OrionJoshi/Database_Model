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
-- Table `mydb`.`parent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`parent` (
  `parent_id` INT NOT NULL AUTO_INCREMENT,
  `p_fname` VARCHAR(45) NOT NULL,
  `p_lname` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`parent_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`class` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `class` VARCHAR(45) NOT NULL,
  `no_of_stu` INT NOT NULL,
  `class_teacher` INT NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `province` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `municipilty` VARCHAR(45) NOT NULL,
  `ward_no` INT NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `stu_id` INT NOT NULL AUTO_INCREMENT,
  `s_fname` VARCHAR(45) NOT NULL,
  `s_lname` VARCHAR(45) NOT NULL,
  `roll_no` INT NOT NULL,
  `phone_no` INT NOT NULL,
  `parent_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`stu_id`),
  INDEX `fk_student_parent_idx` (`parent_id` ASC) VISIBLE,
  INDEX `fk_student_class1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_student_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `mydb`.`parent` (`parent_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `mydb`.`class` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`attendance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`attendance` (
  `ad_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `per_or_abs` TINYINT NOT NULL,
  `stu_id` INT NOT NULL,
  `class_id` INT NOT NULL,
  PRIMARY KEY (`ad_id`),
  INDEX `fk_attendance_student1_idx` (`stu_id` ASC) VISIBLE,
  INDEX `fk_attendance_class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_attendance_student1`
    FOREIGN KEY (`stu_id`)
    REFERENCES `mydb`.`student` (`stu_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `mydb`.`class` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `staff_fname` VARCHAR(45) NOT NULL,
  `staff_lname` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `salary` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`teacher` (
  `teacher_id` INT NOT NULL AUTO_INCREMENT,
  `t_fname` VARCHAR(45) NOT NULL,
  `t_lname` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `salary` INT NOT NULL,
  `principle_id` INT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`teacher_id`),
  INDEX `fk_teacher_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`class_teach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`class_teach` (
  `teach_id` INT NOT NULL AUTO_INCREMENT,
  `class_id` INT NOT NULL,
  `teacher_id` INT NOT NULL,
  `subject` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teach_id`),
  INDEX `FK_class-teach_class_idx` (`class_id` ASC) VISIBLE,
  INDEX `FK_class-teach_teacher_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `FK_class-teach_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `mydb`.`class` (`class_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_class-teach_teacher`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `mydb`.`teacher` (`teacher_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
