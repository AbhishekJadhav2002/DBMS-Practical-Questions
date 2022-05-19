/*creating Project table*/
CREATE TABLE `practical_q7`.`project` (
  `PNO` VARCHAR(20) NOT NULL,
  `PNAME` VARCHAR(50) NOT NULL,
  `CHIEF` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`PNO`))
COMMENT = 'Table containing attributes of project and having one-to-many relaton with Assigned entity';

/*creating Employee table*/
CREATE TABLE `practical_q7`.`employee` (
  `EMPNO` VARCHAR(20) NOT NULL,
  `EMPNAME` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`EMPNO`))
COMMENT = 'Table containing attributes of employee and having one-to-many relation with Assigned entity';

/*creating Assigned table*/
CREATE TABLE `practical_q7`.`assigned` (
  `PNO` VARCHAR(20) NOT NULL,
  `EMPNO` VARCHAR(20) NOT NULL,
  `primary_key` INT NOT NULL,
PRIMARY KEY (`primary_key`),
  INDEX `fk_PNO_from_project_idx` (`PNO` ASC) VISIBLE,
  INDEX `fk_EMPNO_from_Employee_idx` (`EMPNO` ASC) VISIBLE,
  CONSTRAINT `fk_PNO_from_project`
    FOREIGN KEY (`PNO`)
    REFERENCES `practical_q7`.`project` (`PNO`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EMPNO_from_Employee`
    FOREIGN KEY (`EMPNO`)
    REFERENCES `practical_q7`.`employee` (`EMPNO`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing only foreign keys from independent table and forming mant-to-many relation betweein them';

/*filling Project table*/
INSERT INTO `practical_q7`.`project` (`PNO`, `PNAME`, `CHIEF`) VALUES ('p-1', 'pr002', 'pr002_Chief');
INSERT INTO `practical_q7`.`project` (`PNO`, `PNAME`, `CHIEF`) VALUES ('p-2', 'DBMS', 'DBMS_Chief');
INSERT INTO `practical_q7`.`project` (`PNO`, `PNAME`, `CHIEF`) VALUES ('p-3', 'Project_Alpha', 'Alpha Chief');
INSERT INTO `practical_q7`.`project` (`PNO`, `PNAME`, `CHIEF`) VALUES ('p-4', 'Project_Beta', 'Beta_Chief');

/*filling Employee table*/
INSERT INTO `practical_q7`.`employee` (`EMPNO`, `EMPNAME`) VALUES ('emp-1', 'Abhishek Jadhav');
INSERT INTO `practical_q7`.`employee` (`EMPNO`, `EMPNAME`) VALUES ('emp-2', 'Abhijeet Ingle');
INSERT INTO `practical_q7`.`employee` (`EMPNO`, `EMPNAME`) VALUES ('emp-3', 'Atharva Kinikar');
INSERT INTO `practical_q7`.`employee` (`EMPNO`, `EMPNAME`) VALUES ('emp-4', 'Shlok Hinge');
INSERT INTO `practical_q7`.`employee` (`EMPNO`, `EMPNAME`) VALUES ('emp-5', 'Pratik Gabhale');

/*filling Assigned table*/
INSERT INTO `practical_q7`.`assigned` (`PNO`, `EMPNO`, `primary_key`) VALUES ('p-1', 'emp-1', '1');
INSERT INTO `practical_q7`.`assigned` (`PNO`, `EMPNO`, `primary_key`) VALUES ('p-2', 'emp-3', '3');
INSERT INTO `practical_q7`.`assigned` (`PNO`, `EMPNO`, `primary_key`) VALUES ('p-1', 'emp-4', '2');
INSERT INTO `practical_q7`.`assigned` (`PNO`, `EMPNO`, `primary_key`) VALUES ('p-4', 'emp-1', '5');

/*Question 1 answer*/
SELECT employee.*, project.PNAME FROM assigned INNER JOIN employee ON assigned.EMPNO=employee.EMPNO INNER JOIN project ON assigned.PNO=project.PNO;

/*Question 2 answer*/
SELECT employee.*, project.PNAME FROM assigned INNER JOIN employee ON assigned.EMPNO=employee.EMPNO INNER JOIN project ON assigned.PNO=project.PNO WHERE project.PNAME="pr002";

/*Question 3 answer*/
SELECT employee.*, project.PNAME FROM assigned INNER JOIN employee ON assigned.EMPNO=employee.EMPNO INNER JOIN project ON assigned.PNO=project.PNO WHERE project.PNAME="DBMS";

/*Question 4 answer*/
DELIMITER $$
USE `practical_q7`$$
CREATE DEFINER = CURRENT_USER TRIGGER `practical_q7`.`employee_BEFORE_DELETE_delete_it_from_assigned` BEFORE DELETE ON `employee` FOR EACH ROW
BEGIN
	DELETE FROM assigned WHERE EMPNO=OLD.EMPNO;
END$$
DELIMITER ;

DELETE FROM employee WHERE EMPNO="emp-3";

