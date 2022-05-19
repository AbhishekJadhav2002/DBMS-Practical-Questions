/*creating Employee table*/
CREATE TABLE `practical_q8`.`employee` (
  `emp_no` INT NOT NULL,
  `emp_name` VARCHAR(100) NOT NULL,
  `hiredate` DATE NOT NULL,
  `commission` INT NOT NULL,
  `netsalary` INT NOT NULL,
  `dept_no` INT NOT NULL,
  `designation` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`emp_no`))
COMMENT = 'Table containing details of employee';

/*filling Employee table*/
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('1', 'emp_name_1', '2022-10-05', '1200', '11500', '30', 'Clerk');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('3', 'emp_name_2', '2021-12-28', '30000', '32000', '20', 'Clerk');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('4', 'emp_name_3', '2018-11-05', '110000', '145000', '10', 'Manager');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('2', 'emp_name_4', '2022-01-07', '50000', '48500', '30', 'Clerk');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('6', 'emp_name_5', '2016-10-01', '98450', '112000', '10', 'President');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('7', 'emp_name_6', '2020-10-15', '48000', '64000', '10', 'Clerk');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('10', 'emp_name_7', '2021-04-13', '1500', '20000', '30', 'Clerk');
INSERT INTO `practical_q8`.`employee` (`emp_no`, `emp_name`, `hiredate`, `commission`, `netsalary`, `dept_no`, `designation`) VALUES ('9', 'emp_name_8', '2020-04-10', '15500', '14300', '20', 'Manager');

/*Question 1 answer*/
SELECT * FROM employee WHERE dept_no=30;

/*Question 2 answer*/
SELECT emp_no, emp_name, dept_no FROM employee WHERE designation="Clerk";

/*Question 3 answer*/
SELECT * FROM employee WHERE commission>netsalary;

/*Question 4 answer*/
SELECT * FROM employee WHERE commission>0.6*netsalary;

/*Question 5 answer*/
SELECT emp_name, designation, netsalary FROM employee WHERE dept_no=20 AND netsalary>2000;

/*Question 6 answer*/
SELECT * FROM employee WHERE designation="Clerk" AND dept_no=30 AND netsalary>15000;

/*Question 7 answer*/
SELECT * FROM employee WHERE designation IN ("Clerk", "President");

/*Question 8 answer*/
SELECT * FROM employee WHERE designation="Manager" AND dept_no!=20;

/*Question 9 answer*/
SELECT * FROM employee WHERE dept_no=10 AND designation IN ("Clerk", "Manager");

/*Question 10 answer*/
SELECT * FROM employee WHERE (dept_no=10 AND designation="Manager") OR (dept_no=20 AND designation="Clerk");