
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+07:00";


-- -----------------------------------------------------
-- Schema humanresource for mySQL
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table `humanresource`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ADMINS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id`)
) 
ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `humanresource`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENT` (
  `Client_id` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(20) NULL DEFAULT NULL,
  `Phone_num` INT NULL DEFAULT NULL,
  `Birth_day` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Client_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- -----------------------------------------------------
-- Table `humanresource`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EMPLOYEE` (
  `Ssn` INT NOT NULL AUTO_INCREMENT,
  `F_name` VARCHAR(20) NULL DEFAULT NULL,
  `M_name` VARCHAR(20) NULL DEFAULT NULL,
  `L_name` VARCHAR(20) NULL DEFAULT NULL,
  `Birth_day` DATE NULL DEFAULT NULL,
  `Salary` INT NULL DEFAULT NULL,
  `Gender` VARCHAR(20) NULL DEFAULT NULL,
  `Super_ssn` INT NULL DEFAULT NULL,
  `Dp_id` INT NULL DEFAULT NULL,
  `Db_admin` INT DEFAULT NULL,
  PRIMARY KEY (`Ssn`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter


-- -----------------------------------------------------
-- Table `humanresource`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DEPARTMENT` (
  `Dp_id` INT NOT NULL AUTO_INCREMENT,
  `Dp_name` VARCHAR(20) NULL DEFAULT NULL,
  `Dp_type` VARCHAR(20) NULL DEFAULT NULL,
  `Dp_location` VARCHAR(20) NULL DEFAULT NULL,
  `Dp_manager` INT NULL,
  PRIMARY KEY (`Dp_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter


-- -----------------------------------------------------
-- Table `humanresource`.`CLIENT_PROJECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENT_PROJECT` (
  `Work_id` INT NOT NULL AUTO_INCREMENT,
  `Started_day` DATE NULL DEFAULT NULL,
  `Delivery_day` DATE NULL DEFAULT NULL,
  `Dnumber` INT NULL DEFAULT NULL,
  `C_no` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Work_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter




-- -----------------------------------------------------
-- Table `humanresource`.`DEPENDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DEPENDENT` (
  `Essn` INT NOT NULL AUTO_INCREMENT,
  `Dependent_name` VARCHAR(20) NOT NULL,
  `Gender` VARCHAR(20) NULL DEFAULT NULL,
  `Birth_day` DATE NULL DEFAULT NULL,
  `Relationship` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Essn`, `Dependent_name`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter


-- -----------------------------------------------------
-- Table `humanresource`.`TRAIN_COURSE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TRAIN_COURSE` (
  `Train_id` INT NOT NULL,
  `Hour` INT NULL DEFAULT NULL,
  `Course_type` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Train_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- no alter


-- -----------------------------------------------------
-- Table `humanresource`.`HAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HAS` (
  `Essn` INT NOT NULL AUTO_INCREMENT,
  `Cno` INT NOT NULL,
  `Cno2` INT NOT NULL,
  PRIMARY KEY (`Essn`, `Cno`, `Cno2`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter




-- -----------------------------------------------------
-- Table `humanresource`.`PROJECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT` (
  `Work_id` INT NOT NULL,
  `Hour` INT NULL DEFAULT NULL,
  `Type` VARCHAR(20) NULL DEFAULT NULL,
  `Dnum` INT NULL DEFAULT NULL,
  `DEPARTMENT_Dp_id` INT NOT NULL,
  PRIMARY KEY (`Work_id`, `DEPARTMENT_Dp_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter




-- -----------------------------------------------------
-- Table `humanresource`.`RELEASE_TIME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RELEASE_TIME` (
  `Em_ssn` INT NOT NULL AUTO_INCREMENT,
  `R_date` DATE NOT NULL,
  `Day_count` INT NULL DEFAULT NULL,
  `Type` VARCHAR(20) NULL DEFAULT NULL,
  `employee_Ssn` INT NOT NULL,
  PRIMARY KEY (`Em_ssn`, `R_date`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter



-- -----------------------------------------------------
-- Table `humanresource`.`WORKS_ON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WORKS_ON` (
  `Essn` INT NOT NULL AUTO_INCREMENT,
  `Pno` INT NOT NULL,
  `Hour` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Essn`, `Pno`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- done alter



-- -----------------------------------------------------
-- Table `humanresource`.`WORKED`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `WORKED` (
  `employee_Ssn` INT NOT NULL,
  `client_project_Work_id` INT NOT NULL,
  PRIMARY KEY (`employee_Ssn`, `client_project_Work_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- -----------------------------------------------------
-- Table `humanresource`.`DepartmentLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DepartmentLocation` (
  `Dp_location` VARCHAR(32) NOT NULL,
  `Dp_id` INT NOT NULL,
  PRIMARY KEY (`Dp_location`, `Dp_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `EMPLOYEE` 
    ADD (CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`Super_ssn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION,  
        CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`Dp_id`) REFERENCES `DEPARTMENT` (`Dp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION);   

ALTER TABLE `EMPLOYEE` 
    ADD (CONSTRAINT `em_db_manager` FOREIGN KEY (`Db_admin`) REFERENCES `ADMINS` (`id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);    

ALTER TABLE `DEPARTMENT` 
    ADD (CONSTRAINT `employee_manager` FOREIGN KEY (`Dp_manager`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `dp_location` FOREIGN KEY (`Dp_location`) REFERENCES `DepartmentLocation` (`Dp_location`)  ON DELETE NO ACTION ON UPDATE NO ACTION);

ALTER TABLE `CLIENT_PROJECT` 
    ADD (CONSTRAINT `client_project_ibfk_1` FOREIGN KEY (`Dnumber`) REFERENCES `DEPARTMENT` (`Dp_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION,  
        CONSTRAINT `client_project_ibfk_3` FOREIGN KEY (`C_no`) REFERENCES `CLIENT` (`Client_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);     


ALTER TABLE `DEPENDENT` 
    ADD (CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION);    

ALTER TABLE `HAS` 
    ADD (CONSTRAINT `has_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION,  
        CONSTRAINT `has_ibfk_2` FOREIGN KEY (`Cno2`) REFERENCES `TRAIN_COURSE` (`Train_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);     

ALTER TABLE `PROJECT` 
    ADD (CONSTRAINT `fk_PROJECT_DEPARTMENT1` FOREIGN KEY (`DEPARTMENT_Dp_id`) REFERENCES `DEPARTMENT` (`Dp_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);    

ALTER TABLE `RELEASE_TIME` 
    ADD (CONSTRAINT `fk_release_time_employee1` FOREIGN KEY (`employee_Ssn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION);    

ALTER TABLE `WORKS_ON`
    ADD (CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION,  
        CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`Pno`) REFERENCES `PROJECT` (`Work_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);     


ALTER TABLE `WORKED`
    ADD (CONSTRAINT `fk_employee_has_client_project_employee1` FOREIGN KEY (`employee_Ssn`) REFERENCES `EMPLOYEE` (`Ssn`)  ON DELETE NO ACTION ON UPDATE NO ACTION,  
        CONSTRAINT `fk_employee_has_client_project_client_project1` FOREIGN KEY (`client_project_Work_id`) REFERENCES `CLIENT_PROJECT` (`Work_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);     


-- ALTER TABLE `DepartmentLocation` 
--     ADD (CONSTRAINT `dp_multilocation` FOREIGN KEY (`Dp_id`) REFERENCES `DEPARTMENT` (`Dp_id`)  ON DELETE NO ACTION ON UPDATE NO ACTION);    
