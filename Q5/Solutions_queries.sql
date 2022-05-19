/*creating dept table*/
CREATE TABLE `practical_q5`.`dept` (
  `dept-no` INT NOT NULL,
  `dname` VARCHAR(100) NOT NULL,
  `LOC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`dept-no`))
COMMENT = 'tabler containing details of employee and having one-to-many relation between emp entity';

/*creating project table*/
CREATE TABLE `practical_q5`.`project` (
  `proj-no` INT NOT NULL,
  `proj-name` VARCHAR(20) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`proj-no`))
COMMENT = 'table containing details of projects and having one-to-many relation between emp';

/*creating emp table*/
CREATE TABLE `practical_q5`.`emp` (
  `emp-no` INT NOT NULL,
  `ename` VARCHAR(100) NOT NULL,
  `designation` VARCHAR(20) NOT NULL,
  `sal` INT NOT NULL,
  `dept-no` INT NOT NULL,
  `proj-no` INT NOT NULL,
  PRIMARY KEY (`emp-no`),
  INDEX `fk_dept-no_from_dept_idx` (`dept-no` ASC) VISIBLE,
  INDEX `fk_project-no_from_project_idx` (`proj-no` ASC) VISIBLE,
  CONSTRAINT `fk_dept-no_from_dept`
    FOREIGN KEY (`dept-no`)
    REFERENCES `practical_q5`.`dept` (`dept-no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project-no_from_project`
    FOREIGN KEY (`proj-no`)
    REFERENCES `practical_q5`.`project` (`proj-no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'table containing details of employee and having many-to-one rations with dept and project';

/*filling dept table*/
INSERT INTO `practical_q5`.`dept` (`dept-no`, `dname`, `LOC`) VALUES ('1', 'MARKETING', 'Pune');
INSERT INTO `practical_q5`.`dept` (`dept-no`, `dname`, `LOC`) VALUES ('2', 'CS', 'Nashik');
INSERT INTO `practical_q5`.`dept` (`dept-no`, `dname`, `LOC`) VALUES ('3', 'INVENTARY', 'Pune');
INSERT INTO `practical_q5`.`dept` (`dept-no`, `dname`, `LOC`) VALUES ('10', 'DEVELOPEMENT', 'US');
INSERT INTO `practical_q5`.`dept` (`dept-no`, `dname`, `LOC`) VALUES ('20', 'FINANCE', 'US');

/*filling project table*/
INSERT INTO `practical_q5`.`project` (`proj-no`, `proj-name`, `status`) VALUES ('1', 'Blood Bank', '0');
INSERT INTO `practical_q5`.`project` (`proj-no`, `proj-name`, `status`) VALUES ('2', 'Donation Portal', '1');
INSERT INTO `practical_q5`.`project` (`proj-no`, `proj-name`, `status`) VALUES ('3', 'Help Desk', '1');
INSERT INTO `practical_q5`.`project` (`proj-no`, `proj-name`, `status`) VALUES ('4', 'Security', '0');

/*filling emp table*/
INSERT INTO `practical_q5`.`emp` (`emp-no`, `ename`, `designation`, `sal`, `dept-no`, `proj-no`) VALUES ('101', 'Abhishek', 'Manager', '120000', '1', '2');
INSERT INTO `practical_q5`.`emp` (`emp-no`, `ename`, `designation`, `sal`, `dept-no`, `proj-no`) VALUES ('102', 'Abhijeet', 'Manager', '120000', '3', '1');
INSERT INTO `practical_q5`.`emp` (`emp-no`, `ename`, `designation`, `sal`, `dept-no`, `proj-no`) VALUES ('103', 'Bezos', 'Clerk', '50000', '10', '3');
INSERT INTO `practical_q5`.`emp` (`emp-no`, `ename`, `designation`, `sal`, `dept-no`, `proj-no`) VALUES ('104', 'Pratik', 'Manager', '120000', '20', '4');

/*Question 1 answer*/
SELECT emp.* FROM emp JOIN dept ON dept.`dept-no`=emp.`dept-no` WHERE dept.dname="INVENTARY" AND dept.LOC="Pune";

/*Question 2 answer*/
SELECT emp.ename, project.`proj-name` FROM emp JOIN project ON project.`proj-no`=emp.`dept-no` WHERE project.`proj-name`="Blood Bank";

/*Question 3 answer*/
SELECT emp.ename, dept.dname, emp.designation FROM emp JOIN dept ON dept.`dept-no`=emp.`dept-no` WHERE dept.dname="MARKETING" AND emp.designation="Manager";

/*Question 4 answer*/
SELECT * FROM emp INNER JOIN project ON project.`proj-no`=emp.`proj-no` WHERE project.status=0;

/*Question 5 answer*/
DELIMITER $$
USE `practical_q5`$$
CREATE DEFINER=`Abhishek_Jadhav`@`%` PROCEDURE `details_of_employee`(IN empNo INT)
BEGIN
	SELECT emp.*, dept.dname, dept.LOC, project.`proj-name`, project.status FROM emp INNER JOIN project ON emp.`proj-no`=project.`proj-no` INNER JOIN dept ON dept.`dept-no`=emp.`dept-no` WHERE emp.`emp-no`=empNo;
END$$

DELIMITER ;
;
CALL details_of_employee(101);

/*Question 6 answer*/
DELIMITER $$
USE `practical_q5`$$
CREATE DEFINER=`Abhishek_Jadhav`@`%` PROCEDURE `q5_6th_query_procedure`()
BEGIN
UPDATE emp SET
	sal = IF(emp.designation = "Clerk", 1.2*emp.sal, emp.sal),
    sal = IF(emp.designation = "Manager", 1.1*emp.sal, emp.sal),
    sal = IF((emp.designation != "Manager") OR (emp.designation != "Clerk"), 1.1*emp.sal, 1.1*emp.sal)
WHERE emp.`emp-no`=emp.`emp-no`;
END$$

DELIMITER ;
;
CALL q5_6th_query_procedure();