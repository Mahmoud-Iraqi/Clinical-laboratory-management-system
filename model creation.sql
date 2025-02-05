-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Patient` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `ID` INT NOT NULL,
  `P_name` VARCHAR(45) NOT NULL,
  `sex` VARCHAR(45) NULL,
  `B_date` DATE NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `ssn` INT NOT NULL,
  `Branch_id` INT NOT NULL,
  `S_name` VARCHAR(45) NULL,
  `S_phone` INT NULL,
  `salary` INT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_staff_Branches1_idx` (`Branch_id` ASC),
  CONSTRAINT `fk_staff_Branches1`
    FOREIGN KEY (`Branch_id`)
    REFERENCES `mydb`.`Branch` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`manager` ;

CREATE TABLE IF NOT EXISTS `mydb`.`manager` (
  `staff_ssn` INT NOT NULL,
  PRIMARY KEY (`staff_ssn`),
  CONSTRAINT `fk_manager_staff1`
    FOREIGN KEY (`staff_ssn`)
    REFERENCES `mydb`.`staff` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Branch` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Branch` (
  `ID` INT NOT NULL,
  `phone` INT NULL,
  `B_address` VARCHAR(45) NULL,
  `manager_staff_ssn` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Branch_manager1_idx` (`manager_staff_ssn` ASC),
  CONSTRAINT `fk_Branch_manager1`
    FOREIGN KEY (`manager_staff_ssn`)
    REFERENCES `mydb`.`manager` (`staff_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`visit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`visit` ;

CREATE TABLE IF NOT EXISTS `mydb`.`visit` (
  `patient_ID` INT NOT NULL,
  `Branch_id` INT NULL,
  `type` VARCHAR(45) NULL,
  `date` DATE NULL,
  PRIMARY KEY (`patient_ID`, `Branch_id`),
  INDEX `fk_Patient_has_Branches_Branches1_idx` (`Branch_id` ASC),
  INDEX `fk_Patient_has_Branches_Patient_idx` (`patient_ID` ASC),
  CONSTRAINT `fk_Patient_has_Branches_Patient`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Branches_Branches1`
    FOREIGN KEY (`Branch_id`)
    REFERENCES `mydb`.`Branch` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`rate` ;

CREATE TABLE IF NOT EXISTS `mydb`.`rate` (
  `patient_ID` INT NOT NULL,
  `Branch_id` INT NOT NULL,
  `Rate` VARCHAR(45) NULL,
  PRIMARY KEY (`patient_ID`, `Branch_id`),
  INDEX `fk_Patient_has_Branches_Branches2_idx` (`Branch_id` ASC),
  INDEX `fk_Patient_has_Branches_Patient1_idx` (`patient_ID` ASC),
  CONSTRAINT `fk_Patient_has_Branches_Patient1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Branches_Branches2`
    FOREIGN KEY (`Branch_id`)
    REFERENCES `mydb`.`Branch` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Order_provider` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Order_provider` (
  `ID` INT NOT NULL,
  `OP_name` VARCHAR(45) NULL,
  `OP_address` VARCHAR(45) NULL,
  `specialist` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`direct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`direct` ;

CREATE TABLE IF NOT EXISTS `mydb`.`direct` (
  `patient_ID` INT NULL,
  `Order_provider_ID` INT NULL,
  `direct_Date` DATE NULL,
  PRIMARY KEY (`patient_ID`, `Order_provider_ID`),
  INDEX `fk_Patient_has_Order_provider_Order_provider1_idx` (`Order_provider_ID` ASC),
  INDEX `fk_Patient_has_Order_provider_Patient1_idx` (`patient_ID` ASC),
  CONSTRAINT `fk_Patient_has_Order_provider_Patient1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Order_provider_Order_provider1`
    FOREIGN KEY (`Order_provider_ID`)
    REFERENCES `mydb`.`Order_provider` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Doctor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  ` specialist` VARCHAR(45) NULL,
  `staff_ssn` INT NOT NULL,
  PRIMARY KEY (`staff_ssn`),
  CONSTRAINT `fk_Doctor_staff1`
    FOREIGN KEY (`staff_ssn`)
    REFERENCES `mydb`.`staff` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sample`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sample` ;

CREATE TABLE IF NOT EXISTS `mydb`.`sample` (
  `ID` INT NOT NULL,
  `S_type` VARCHAR(45) NULL,
  `collecting_date` DATE NULL,
  `patient_ID` INT NOT NULL,
  `Doctor_staff_ssn` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_sample_Patient1_idx` (`patient_ID` ASC),
  INDEX `fk_sample_Doctor1_idx` (`Doctor_staff_ssn` ASC),
  CONSTRAINT `fk_sample_Patient1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_Doctor1`
    FOREIGN KEY (`Doctor_staff_ssn`)
    REFERENCES `mydb`.`Doctor` (`staff_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`test` ;

CREATE TABLE IF NOT EXISTS `mydb`.`test` (
  `T_code` INT NOT NULL,
  `T_name` VARCHAR(45) NULL,
  `T_price` INT NULL,
  `max` INT NULL,
  `min` INT NULL,
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`T_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`t_result`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`t_result` ;

CREATE TABLE IF NOT EXISTS `mydb`.`t_result` (
  `ID` INT NOT NULL,
  `test_T_code` INT NOT NULL,
  `releaseing_date` DATE NULL,
  `actual_value` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_T.result_test1_idx` (`test_T_code` ASC),
  CONSTRAINT `fk_T.result_test1`
    FOREIGN KEY (`test_T_code`)
    REFERENCES `mydb`.`test` (`T_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sceratary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sceratary` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sceratary` (
  `no_of_lang` VARCHAR(45) NULL,
  `staff_ssn` INT NOT NULL,
  PRIMARY KEY (`staff_ssn`),
  CONSTRAINT `fk_Sceratary_staff1`
    FOREIGN KEY (`staff_ssn`)
    REFERENCES `mydb`.`staff` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`report` ;

CREATE TABLE IF NOT EXISTS `mydb`.`report` (
  `result_ID` INT NOT NULL,
  `R_date` VARCHAR(45) NULL,
  `Sceratary_staff_ssn1` INT NOT NULL,
  `Patient_ID` INT NOT NULL,
  `doctor name` VARCHAR(45) NULL,
  `id` VARCHAR(45) NOT NULL,
  INDEX `fk_report_T.result1_idx` (`result_ID` ASC),
  PRIMARY KEY (`result_ID`, `id`),
  INDEX `fk_report_Patient1_idx` (`Patient_ID` ASC),
  INDEX `fk_report_Sceratary1_idx` (`Sceratary_staff_ssn1` ASC),
  CONSTRAINT `fk_report_T.result1`
    FOREIGN KEY (`result_ID`)
    REFERENCES `mydb`.`t_result` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_Patient1`
    FOREIGN KEY (`Patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_Sceratary1`
    FOREIGN KEY (`Sceratary_staff_ssn1`)
    REFERENCES `mydb`.`Sceratary` (`staff_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient order test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`patient order test` ;

CREATE TABLE IF NOT EXISTS `mydb`.`patient order test` (
  `patient_ID` INT NOT NULL,
  `test_T_code` INT NULL,
  PRIMARY KEY (`patient_ID`, `test_T_code`),
  INDEX `fk_Patient_has_test_test1_idx` (`test_T_code` ASC),
  INDEX `fk_Patient_has_test_Patient1_idx` (`patient_ID` ASC),
  CONSTRAINT `fk_Patient_has_test_Patient1`
    FOREIGN KEY (`patient_ID`)
    REFERENCES `mydb`.`Patient` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_test_test1`
    FOREIGN KEY (`test_T_code`)
    REFERENCES `mydb`.`test` (`T_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `mydb`.`Patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1001, 'John Doe', 'Male', '1998-01-06', '123 Main St, City');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1002, 'Jane Smith', 'Female', '1985-10-20', '456 Elm St, Town');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1003, 'Mike Johnson', 'Male', '1978-03-08', '789 Oak St, Village');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1004, 'Emily Brown', 'Female', '1995-12-01', '321 Pine St, County');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1005, 'David Wilson', 'Male', '1982-07-25', '654 Maple St, City');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1006, 'Sarah Davis', 'Female', '1993-09-12', '987 Cedar St, Town');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1007, 'Michael Thompson', 'Male', '1975-06-18', '654 Elm St, Village');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1008, 'Jessica Taylor', 'Female', '1988-11-05', '321 Oak St, County');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1009, 'Robert Harris', 'Male', '1997-02-28', '789 Pine St, City');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1010, 'Olivia Martinez', 'Female', '1991-08-10', '123 Maple St, Town');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1011, 'alaba', 'Male', '1971-08-18', '350 Fifth Avenue, New York');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1012, 'alio diang', 'Male', '1985-09-15', '1600 Pennsylvania Avenue ');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1013, 'ali malol', 'Male', '1995-09-12', '350 Mission Street, San Francisco');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1014, 'nicki minaj', 'Female', '1965-11-10', '5555 Melrose Ave, Los Angeles');
INSERT INTO `mydb`.`Patient` (`ID`, `P_name`, `sex`, `B_date`, `address`) VALUES (1015, 'ter stegen', 'Male', '1999-02-28', '725 5th Ave, New York');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4001, 1, 'John Doe', 1237890, 5000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4002, 2, 'john henry', 2183647, 2000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4003, 3, 'Peter Parker', 2143647, 6450);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4004, 4, 'Mary Jane Watson', 2147478, 8060);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4005, 1, 'Bruce Wayne', 5143647, 7750);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4006, 2, 'Clark Kent', 2183647, 4560);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4007, 3, 'Diana Prince', 2133647, 9510);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4008, 4, 'Arthur Curry', 2187447, 4530);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4009, 1, 'Victor Stone', 1114455, 4865);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4010, 2, 'Barry Allen', 1478690, 4560);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4011, 3, 'emilia clarke', 2137420, 6500);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4012, 4, 'billie eilish', 2137627, 7500);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4013, 1, 'alijandro_balde', 2135891, 7000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4014, 2, 'kounde', 2135892, 8000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4015, 3, 'de jong', 2135893, 9000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4016, 4, 'pablo gavi', 2135894, 9500);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4017, 1, 'lamin yamal', 5143612, 11000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4018, 2, 'joao feleix', 5143634, 11500);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4019, 3, 'ferland mendy', 5143656, 12000);
INSERT INTO `mydb`.`staff` (`ssn`, `Branch_id`, `S_name`, `S_phone`, `salary`) VALUES (4020, 4, 'luka modric', 5143667, 12500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`manager`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`manager` (`staff_ssn`) VALUES (4017);
INSERT INTO `mydb`.`manager` (`staff_ssn`) VALUES (4018);
INSERT INTO `mydb`.`manager` (`staff_ssn`) VALUES (4019);
INSERT INTO `mydb`.`manager` (`staff_ssn`) VALUES (4020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Branch`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Branch` (`ID`, `phone`, `B_address`, `manager_staff_ssn`) VALUES (1, 1234567890, '123 Main Street', 4017);
INSERT INTO `mydb`.`Branch` (`ID`, `phone`, `B_address`, `manager_staff_ssn`) VALUES (2, 2147483647, '456 Elm Street', 4018);
INSERT INTO `mydb`.`Branch` (`ID`, `phone`, `B_address`, `manager_staff_ssn`) VALUES (3, 2147483647, '789 Oak Street', 4019);
INSERT INTO `mydb`.`Branch` (`ID`, `phone`, `B_address`, `manager_staff_ssn`) VALUES (4, 2147483647, '1011 Maple Avenue', 4020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`visit`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1001, 1, 'home visit', '2022-10-12');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1002, 2, 'branch visit', '2022-11-05');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1003, 3, 'home visit', '2022-08-27');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1004, 4, 'branch visit', '2022-04-14');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1005, 1, 'home visit', '2022-06-21');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1006, 2, 'branch visit', '2022-12-19');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1007, 3, 'home visit', '2022-01-08');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1008, 4, 'branch visit', '2022-05-30');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1009, 1, 'home visit', '2022-09-16');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1010, 2, 'branch visit', '2022-03-23');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1011, 1, 'branch visit', '2022-04-05');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1012, 2, 'home visit', '2022-11-30');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1013, 3, 'branch visit', '2022-12-09');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1014, 4, 'home visit', '2022-03-06');
INSERT INTO `mydb`.`visit` (`patient_ID`, `Branch_id`, `type`, `date`) VALUES (1015, 1, 'branch visit', '2022-11-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`rate`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1001, 1, '5');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1002, 2, '8');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1003, 3, '3');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1004, 4, '7');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1005, 1, '10');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1006, 2, '9');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1007, 3, '4');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1008, 4, '8');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1009, 1, '9');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1010, 2, '10');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1011, 1, '8');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1012, 2, '9');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1013, 3, '7');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1014, 4, '2');
INSERT INTO `mydb`.`rate` (`patient_ID`, `Branch_id`, `Rate`) VALUES (1015, 1, '6');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Order_provider`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Order_provider` (`ID`, `OP_name`, `OP_address`, `specialist`) VALUES (11, 'john', '731 fondren,housten', 'Cardiologist');
INSERT INTO `mydb`.`Order_provider` (`ID`, `OP_name`, `OP_address`, `specialist`) VALUES (12, 'rodri', '3321 castle,spring', 'Endocrinologist');
INSERT INTO `mydb`.`Order_provider` (`ID`, `OP_name`, `OP_address`, `specialist`) VALUES (13, 'sane', '291 berry,bellaire', 'Nutritionist');
INSERT INTO `mydb`.`Order_provider` (`ID`, `OP_name`, `OP_address`, `specialist`) VALUES (14, 'araujo', '980 dallas,housten', 'Internist');
INSERT INTO `mydb`.`Order_provider` (`ID`, `OP_name`, `OP_address`, `specialist`) VALUES (15, 'trent-arnold', '1600 Smith St, Houston', 'Nutritionist');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`direct`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1001, 11, '2022-10-01');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1002, 13, '2022-11-01');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1003, 13, '2022-08-08');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1009, 14, '2022-09-03');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1007, 12, '2022-01-07');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1012, 15, '2022-11-27');
INSERT INTO `mydb`.`direct` (`patient_ID`, `Order_provider_ID`, `direct_Date`) VALUES (1015, 15, '2022-10-28');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Doctor`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Pathologist', 4001);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Microbiologist', 4002);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Pathologist', 4003);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Clinical Biochemist', 4004);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Microbiologist', 4005);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Pathologist', 4006);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Microbiologist', 4007);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Clinical Biochemist', 4008);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Pathologist', 4013);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Microbiologist', 4014);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Clinical Biochemist', 4015);
INSERT INTO `mydb`.`Doctor` (` specialist`, `staff_ssn`) VALUES ('Pathologist', 4016);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`sample`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3001, 'Blood Samples', '2022-10-12', 1001, 4001);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3002, 'Urine Samples', '2022-11-05', 1002, 4002);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3003, 'Swab Samples', '2022-08-27', 1003, 4007);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3004, 'Blood Samples', '2022-04-14', 1004, 4008);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3005, 'Urine Samples', '2022-06-21', 1005, 4005);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3006, 'Blood Samples', '2022-12-19', 1006, 4006);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3007, 'Blood Samples', '2022-01-08', 1007, 4003);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3008, 'Blood Samples', '2022-05-30', 1008, 4004);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3009, 'Blood Samples', '2022-09-16', 1009, 4005);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3010, 'Swab Samples', '2022-03-23', 1010, 4002);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3011, 'blood Samples', '2022-11-05', 1002, 4006);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3012, 'Urine Samples', '2022-10-12', 1001, 4005);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3013, 'Urine Samples', '2022-03-23', 1010, 4006);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3014, 'blood Samples', '2022-04-05', 1011, 4013);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3015, 'Urine Samples', '2022-11-30', 1012, 4014);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3016, 'Swab Samples', '2022-12-09', 1013, 4015);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3017, 'blood Samples', '2022-03-06', 1014, 4016);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3018, 'Urine Samples', '2022-11-01', 1015, 4013);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3019, 'Swab Samples', '2022-03-06', 1014, 4004);
INSERT INTO `mydb`.`sample` (`ID`, `S_type`, `collecting_date`, `patient_ID`, `Doctor_staff_ssn`) VALUES (3020, 'Urine Samples', '2022-11-30', 1012, 4006);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`test`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5001, 'Complete Blood Count', 500, 5, 3, 'blood test');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5002, 'Blood Chemistry Panel', 600, 100, 70, 'blood test');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5003, 'Coagulation Tests', 350, 35, 25, 'blood test');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5004, 'Routine Urinalysis', 240, 8, 4, 'Urinalysis');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5005, 'Urine Culture', 420, 100000, 1000, 'Urinalysis');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5006, 'Bacterial Culture and Sensitivity', 625, 30, 15, 'Microbiological Tests');
INSERT INTO `mydb`.`test` (`T_code`, `T_name`, `T_price`, `max`, `min`, `category`) VALUES (5007, 'Fungal Culture', 360, 20, 10, 'Microbiological Tests');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`t_result`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6001, 5001, '2022-10-17', '4', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6002, 5004, '2022-11-12', '9', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6003, 5006, '2022-09-03', '25', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6004, 5002, '2022-04-19', '65', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6005, 5005, '2022-06-27', '900', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6006, 5003, '2022-12-25', '27', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6007, 5001, '2022-01-15', '6', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6008, 5002, '2022-06-07', '85', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6009, 5003, '2022-09-25', '33', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6010, 5007, '2022-03-29', '19', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6011, 5001, '2022-11-11', '6', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6012, 5005, '2022-10-20', '650', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6013, 5004, '2022-04-05', '6', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6014, 5001, '2022-04-11', '4', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6015, 5005, '2022-12-06', '1000', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6016, 5006, '2022-12-15', '23', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6017, 5002, '2022-03-12', '77', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6018, 5005, '2022-11-07', '955', 'abnormal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6019, 5004, '2022-03-12', '5', 'normal');
INSERT INTO `mydb`.`t_result` (`ID`, `test_T_code`, `releaseing_date`, `actual_value`, `status`) VALUES (6020, 5007, '2022-12-06', '21', 'abnormal');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Sceratary`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Sceratary` (`no_of_lang`, `staff_ssn`) VALUES ('1', 4009);
INSERT INTO `mydb`.`Sceratary` (`no_of_lang`, `staff_ssn`) VALUES ('2', 4010);
INSERT INTO `mydb`.`Sceratary` (`no_of_lang`, `staff_ssn`) VALUES ('1', 4011);
INSERT INTO `mydb`.`Sceratary` (`no_of_lang`, `staff_ssn`) VALUES ('3', 4012);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`report`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6001, '2022-10-19', 4009, 1001, 'John Doe', '1');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6002, '2022-11-14', 4010, 1002, 'John henry', '2');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6003, '2022-09-05', 4011, 1003, 'Peter Parker', '3');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6004, '2022-04-21', 4012, 1004, 'Mary Jane Watson', '4');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6005, '2022-06-29', 4009, 1005, 'Bruce Wayne', '5');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6006, '2022-12-27', 4010, 1006, 'Clark Kent', '6');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6007, '2022-01-17', 4011, 1007, 'Diana Prince', '7');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6008, '2022-06-09', 4012, 1008, 'Arthur Curry', '8');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6009, '2022-09-27', 4009, 1009, 'John Doe', '9');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6010, '2022-04-01', 4010, 1010, 'John henry', '10');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6011, '2022-11-13', 4010, 1002, 'Clark Kent', '2');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6012, '2022-10-22', 4009, 1001, 'Bruce Wayne', '1');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6013, '2022-04-07', 4010, 1010, 'Clark Kent', '10');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6014, '2022-04-13', 4009, 1011, 'alejandro_balde', '11');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6015, '2022-12-08', 4010, 1012, 'konde', '12');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6016, '2022-12-17', 4011, 1013, 'de jong', '13');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6017, '2022-03-14', 4012, 1014, 'pablo gavi', '14');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6018, '2022-09-11', 4009, 1015, 'John Doe', '15');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6019, '2022-03-14', 4012, 1014, 'Mary Jane Watson', '14');
INSERT INTO `mydb`.`report` (`result_ID`, `R_date`, `Sceratary_staff_ssn1`, `Patient_ID`, `doctor name`, `id`) VALUES (6020, '2022-12-08', 4010, 1012, 'Clark Kent', '12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`patient order test`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1001, 5001);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1002, 5004);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1003, 5006);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1004, 5002);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1005, 5005);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1006, 5003);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1007, 5001);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1008, 5002);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1009, 5003);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1010, 5007);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1002, 5001);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1001, 5005);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1010, 5004);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1011, 5001);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1012, 5005);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1013, 5006);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1014, 5002);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1015, 5005);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1012, 5004);
INSERT INTO `mydb`.`patient order test` (`patient_ID`, `test_T_code`) VALUES (1014, 5007);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
