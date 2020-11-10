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
-- Table `mydb`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profile` (
  `profile_id` INT NOT NULL AUTO_INCREMENT,
  `bio` VARCHAR(45) NOT NULL,
  `profile_image` BLOB NULL,
  `cover_image` BLOB NULL,
  PRIMARY KEY (`profile_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_fname` VARCHAR(45) NOT NULL,
  `user_lname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `birthdate` DATETIME NOT NULL,
  `location_id` INT NOT NULL,
  `profile_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_location_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_user_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `mydb`.`location` (`location_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `mydb`.`profile` (`profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notification` (
  `noti_id` INT NOT NULL AUTO_INCREMENT,
  `notificationFor` INT NOT NULL,
  `notificationFrom` INT NOT NULL,
  `is_post` INT NULL,
  `type` ENUM('like', 'share', 'mention', 'tag', 'comment', 'request') NULL,
  `time` DATETIME NOT NULL,
  `status` TINYINT NULL,
  PRIMARY KEY (`noti_id`),
  INDEX `fk_notification_user1_idx` (`notificationFor` ASC) VISIBLE,
  INDEX `fk_notification_user2_idx` (`notificationFrom` ASC) VISIBLE,
  CONSTRAINT `fk_notification_user1`
    FOREIGN KEY (`notificationFor`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_notification_user2`
    FOREIGN KEY (`notificationFrom`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `message_id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(255) NOT NULL,
  `messageTo` INT NOT NULL,
  `messageFrom` INT NOT NULL,
  `messageOn` DATETIME NOT NULL,
  `status` TINYINT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `fk_message_user1_idx` (`messageTo` ASC) VISIBLE,
  INDEX `fk_message_user2_idx` (`messageFrom` ASC) VISIBLE,
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`messageTo`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`messageFrom`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`relationship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`relationship` (
  `relationship_id` INT NOT NULL AUTO_INCREMENT,
  `user_one_id` INT NOT NULL,
  `user_two_id` INT NOT NULL,
  `status` TINYINT NOT NULL,
  `action_user_id` INT NOT NULL,
  PRIMARY KEY (`relationship_id`),
  INDEX `fk_relationship_user2_idx` (`user_two_id` ASC) VISIBLE,
  INDEX `fk_relationship_user3_idx` (`action_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_relationship_user1`
    FOREIGN KEY (`user_one_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_user2`
    FOREIGN KEY (`user_two_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_relationship_user3`
    FOREIGN KEY (`action_user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`post` (
  `post_id` INT NOT NULL AUTO_INCREMENT,
  `post_title` VARCHAR(45) NULL,
  `post_body` VARCHAR(45) NULL,
  `post_date` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `comment` VARCHAR(255) NOT NULL,
  `post_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `date` DATE NOT NULL,
  `reply_to_com` INT NOT NULL,
  `image` BLOB NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comment_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_comment_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_comment1_idx` (`reply_to_com` ASC) VISIBLE,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`post` (`post_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_comment1`
    FOREIGN KEY (`reply_to_com`)
    REFERENCES `mydb`.`comment` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mention`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mention` (
  `mention_id` INT NOT NULL AUTO_INCREMENT,
  `comment_id` INT NOT NULL,
  `mention_user_id` INT NOT NULL,
  `mention_date` DATE NOT NULL,
  PRIMARY KEY (`mention_id`),
  INDEX `fk_mention_comment1_idx` (`comment_id` ASC) VISIBLE,
  INDEX `fk_mention_user1_idx` (`mention_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_mention_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `mydb`.`comment` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mention_user1`
    FOREIGN KEY (`mention_user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`post_image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`post_image` (
  `p_image_id` INT NOT NULL AUTO_INCREMENT,
  `img_vid` BLOB NULL,
  `post_id` INT NOT NULL,
  PRIMARY KEY (`p_image_id`),
  INDEX `fk_post_image_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_image_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`post` (`post_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `tag_date` DATE NOT NULL,
  PRIMARY KEY (`tag_id`),
  INDEX `fk_tag_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_tag_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_tag_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reaction` (
  `react_id` INT NOT NULL AUTO_INCREMENT,
  `post_comment` ENUM('post', 'comment') NOT NULL,
  `react_on` INT NOT NULL,
  `reaction_type` ENUM('like', 'love', 'angry', 'care', 'haha') NOT NULL,
  `react_by` INT NOT NULL,
  PRIMARY KEY (`react_id`),
  INDEX `fk_reaction_user1_idx` (`react_by` ASC) VISIBLE,
  INDEX `fk_reaction_comment1_idx` (`react_on` ASC) VISIBLE,
  CONSTRAINT `fk_reaction_user1`
    FOREIGN KEY (`react_by`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reaction_comment1`
    FOREIGN KEY (`react_on`)
    REFERENCES `mydb`.`comment` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reaction_post1`
    FOREIGN KEY (`react_on`)
    REFERENCES `mydb`.`post` (`post_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`share`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`share` (
  `share_id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `share_by` INT NOT NULL,
  `share_date` DATE NOT NULL,
  PRIMARY KEY (`share_id`),
  INDEX `fk_share_user1_idx` (`share_by` ASC) VISIBLE,
  INDEX `fk_share_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_share_user1`
    FOREIGN KEY (`share_by`)
    REFERENCES `mydb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_share_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `mydb`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
