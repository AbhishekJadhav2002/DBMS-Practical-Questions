/*creating  emp table*/
CREATE TABLE `practical_q4`.`emp` (
  `Emp-id` VARCHAR(20) NOT NULL,
  `Ename` VARCHAR(100) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(20) NOT NULL,
  `Salary` INT NOT NULL,
  `Age` INT NOT NULL,
  `Hire_date` DATE NOT NULL,
  PRIMARY KEY (`Emp-id`))
COMMENT = 'Only table containing employee details';

/*filling emp table*/
INSERT INTO `practical_q4`.`emp` (`Emp-id`, `Ename`, `City`, `State`, `Salary`, `Age`, `Hire_date`) VALUES ('emp-1', 'Sanika', 'Nashik', 'maharashtra', '25000', '25', '2022-01-24');
INSERT INTO `practical_q4`.`emp` (`Emp-id`, `Ename`, `City`, `State`, `Salary`, `Age`, `Hire_date`) VALUES ('emp-2', 'Sagar', 'Pune', 'Maharastra', '35500', '31', '2020-08-09');
INSERT INTO `practical_q4`.`emp` (`Emp-id`, `Ename`, `City`, `State`, `Salary`, `Age`, `Hire_date`) VALUES ('emp-3', 'Manish', 'Pune', 'Maharashtra', '40000', '31', '2020-09-17');
INSERT INTO `practical_q4`.`emp` (`Emp-id`, `Ename`, `City`, `State`, `Salary`, `Age`, `Hire_date`) VALUES ('emp-4', 'Abhishek', 'Nashik', 'Maharashtra', '60000', '26', '2021-11-05');
INSERT INTO `practical_q4`.`emp` (`Emp-id`, `Ename`, `City`, `State`, `Salary`, `Age`, `Hire_date`) VALUES ('emp-5', 'Samadhan', 'Abad', 'Maharashtra', '20000', '24', '2020-07-02');

/*Question 1 answer*/
SELECT emp.Ename FROM emp WHERE emp.Ename LIKE "Sa%";

/*Question 2 answer*/
SELECT emp.Ename, emp.Salary FROM emp WHERE emp.Age<40;

/*Question 3 answer*/
SELECT * FROM emp WHERE emp.Salary BETWEEN 20000 AND 30000;

/*Question 4 answer*/
DROP procedure IF EXISTS `practical_q4`.`highest_salary`;
;
DELIMITER $$
USE `practical_q4`$$
CREATE DEFINER=`Abhishek_Jadhav`@`%` PROCEDURE `highest_salary`(IN columnname VARCHAR(200))
BEGIN
SELECT * FROM emp ORDER BY columnname DESC LIMIT 1;
END$$

DELIMITER ;
;
CALL highest_salary('Salary');