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
-- Table `mydb`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`position` (
  `position_id` INT NOT NULL AUTO_INCREMENT,
  `position_desc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`position_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`soccer_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`soccer_country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NOT NULL,
  `country_abbr` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`player` (
  `player_id` INT NOT NULL AUTO_INCREMENT,
  `player_name` VARCHAR(45) NOT NULL,
  `team_id` INT NOT NULL,
  `dt_of_bir` DATETIME NOT NULL,
  `age` INT NOT NULL,
  `jersey_no` INT NOT NULL,
  `position_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`player_id`),
  INDEX `FK_player_position_idx` (`position_id` ASC) VISIBLE,
  INDEX `FK_player_soccer_country_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `FK_player_position`
    FOREIGN KEY (`position_id`)
    REFERENCES `mydb`.`position` (`position_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_player_soccer_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`soccer_country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`team` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`team_id`),
  INDEX `FK_team_soccercountry_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `FK_team_soccercountry`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`soccer_country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`coach` (
  `coach_id` INT NOT NULL AUTO_INCREMENT,
  `coach_name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  PRIMARY KEY (`coach_id`),
  INDEX `FK_coach_country_idx` (`country_id` ASC) VISIBLE,
  INDEX `FK_coach_team_idx` (`team_id` ASC) VISIBLE,
  CONSTRAINT `FK_coach_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`soccer_country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_coach_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`soccer_city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`soccer_city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `FK_soccer_city_s_country_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `FK_soccer_city_s_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`soccer_country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`soccer_venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`soccer_venue` (
  `venue_id` INT NOT NULL AUTO_INCREMENT,
  `venue_name` VARCHAR(45) NOT NULL,
  `city_id` INT NOT NULL,
  `aud_capcity` INT NOT NULL,
  PRIMARY KEY (`venue_id`),
  INDEX `FK_s_venue_s_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `FK_s_venue_s_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`soccer_city` (`city_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`team_stat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`team_stat` (
  `team_stat_id` INT NOT NULL AUTO_INCREMENT,
  `team_id` INT NOT NULL,
  `match_played` INT NULL DEFAULT 0,
  `won` INT NULL DEFAULT 0,
  `lost` INT NULL DEFAULT 0,
  `draw` INT NULL DEFAULT 0,
  `points` FLOAT NULL DEFAULT 0.00,
  PRIMARY KEY (`team_stat_id`),
  INDEX `FK_tstat_team_idx` (`team_id` ASC) VISIBLE,
  UNIQUE INDEX `team_id_UNIQUE` (`team_id` ASC) VISIBLE,
  CONSTRAINT `FK_tstat_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`referee` (
  `referee_id` INT NOT NULL AUTO_INCREMENT,
  `referee_name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`referee_id`),
  INDEX `FK_referee_scountry_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `FK_referee_scountry`
    FOREIGN KEY (`country_id`)
    REFERENCES `mydb`.`soccer_country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`match` (
  `match_id` INT NOT NULL AUTO_INCREMENT,
  `team1_id` INT NOT NULL,
  `team2_id` INT NOT NULL,
  `venue_id` INT NOT NULL,
  `referee_id` INT NOT NULL,
  `audience_num` INT NULL DEFAULT 0,
  PRIMARY KEY (`match_id`),
  INDEX `FK_match_venue_idx` (`venue_id` ASC) VISIBLE,
  INDEX `FK_match_team_idx` (`team1_id` ASC) VISIBLE,
  INDEX `FK_match_team2_idx` (`team2_id` ASC) VISIBLE,
  CONSTRAINT `FK_match_venue`
    FOREIGN KEY (`venue_id`)
    REFERENCES `mydb`.`soccer_venue` (`venue_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_match_team`
    FOREIGN KEY (`team1_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_match_team2`
    FOREIGN KEY (`team2_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`match_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`match_details` (
  `mat_del_id` INT NOT NULL AUTO_INCREMENT,
  `match_id` INT NOT NULL,
  `won_team_id` INT NOT NULL,
  `lose_team_id` INT NOT NULL,
  PRIMARY KEY (`mat_del_id`),
  UNIQUE INDEX `match_id_UNIQUE` (`match_id` ASC) VISIBLE,
  INDEX `FK_md_team_idx` (`won_team_id` ASC) VISIBLE,
  INDEX `FK_md-team2_idx` (`lose_team_id` ASC) VISIBLE,
  CONSTRAINT `FK_md_match`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`match` (`match_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_md_team`
    FOREIGN KEY (`won_team_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_md-team2`
    FOREIGN KEY (`lose_team_id`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`asst_referee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`asst_referee` (
  `ass_ref_id` INT NOT NULL AUTO_INCREMENT,
  `ass_ref_name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`ass_ref_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`match_asst_ref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`match_asst_ref` (
  `match_id` INT NOT NULL,
  `asst_ref_id` INT NOT NULL,
  PRIMARY KEY (`match_id`, `asst_ref_id`),
  INDEX `FK_m-a-r_a-r_idx` (`asst_ref_id` ASC) VISIBLE,
  CONSTRAINT `FK_m-a-r_match`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`match` (`match_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_m-a-r_a-r`
    FOREIGN KEY (`asst_ref_id`)
    REFERENCES `mydb`.`asst_referee` (`ass_ref_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goal_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`goal_details` (
  `goal_id` INT NOT NULL,
  `match_id` INT NOT NULL,
  `goal_by_team` INT NOT NULL,
  `goal_by` INT NOT NULL,
  `goal_time` DATETIME NOT NULL,
  PRIMARY KEY (`goal_id`),
  INDEX `FK_goal_match_idx` (`match_id` ASC) VISIBLE,
  INDEX `FK_goal-del_team_idx` (`goal_by_team` ASC) VISIBLE,
  INDEX `FK_goal-del_player_idx` (`goal_by` ASC) VISIBLE,
  CONSTRAINT `FK_goal_match`
    FOREIGN KEY (`match_id`)
    REFERENCES `mydb`.`match` (`match_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_goal-del_team`
    FOREIGN KEY (`goal_by_team`)
    REFERENCES `mydb`.`team` (`team_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_goal-del_player`
    FOREIGN KEY (`goal_by`)
    REFERENCES `mydb`.`player` (`player_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
