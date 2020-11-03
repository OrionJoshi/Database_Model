-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sql_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sql_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sql_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema school
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `school` DEFAULT CHARACTER SET utf8 ;
USE `sql_store` ;

-- -----------------------------------------------------
-- Table `sql_store`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `phone` VARCHAR(50) NULL DEFAULT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `points` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`order_item_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`order_item_notes` (
  `note_id` INT NOT NULL,
  `order_Id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `note` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`note_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`order_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`order_statuses` (
  `order_status_id` TINYINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`shippers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`shippers` (
  `shipper_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shipper_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `status` TINYINT NOT NULL DEFAULT '1',
  `comments` VARCHAR(2000) NULL DEFAULT NULL,
  `shipped_date` DATE NULL DEFAULT NULL,
  `shipper_id` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_orders_shippers_idx` (`shipper_id` ASC) VISIBLE,
  INDEX `fk_orders_order_statuses_idx` (`status` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sql_store`.`customers` (`customer_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses`
    FOREIGN KEY (`status`)
    REFERENCES `sql_store`.`order_statuses` (`order_status_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers`
    FOREIGN KEY (`shipper_id`)
    REFERENCES `sql_store`.`shippers` (`shipper_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  `properties` JSON NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sql_store`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sql_store`.`order_items` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_order_items_products_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `sql_store`.`orders` (`order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `sql_store`.`products` (`product_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `school` ;

-- -----------------------------------------------------
-- Table `school`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`instructors` (
  `instructor_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`instructor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `instructor_id` SMALLINT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_Course_instructors1_idx` (`instructor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Course_instructors1`
    FOREIGN KEY (`instructor_id`)
    REFERENCES `school`.`instructors` (`instructor_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`tags` (
  `tags_id` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tags_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`course_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`course_tags` (
  `course_id` INT NOT NULL,
  `tags_id` TINYINT NOT NULL,
  PRIMARY KEY (`course_id`, `tags_id`),
  INDEX `fk_course_tags_Course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_course_tags_table11_idx` (`tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_tags_Course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`course` (`course_id`),
  CONSTRAINT `fk_course_tags_table11`
    FOREIGN KEY (`tags_id`)
    REFERENCES `school`.`tags` (`tags_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `date_register` DATETIME NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `school`.`enrollments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `school`.`enrollments` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `coupon` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `fk_enrollments_students_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_enrollments_Course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollments_Course`
    FOREIGN KEY (`course_id`)
    REFERENCES `school`.`course` (`course_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_enrollments_students`
    FOREIGN KEY (`student_id`)
    REFERENCES `school`.`students` (`student_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
