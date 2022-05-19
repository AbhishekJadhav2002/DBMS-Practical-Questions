/*creating Job table*/
CREATE TABLE `practical_q9`.`job` (
  `job_id` VARCHAR(20) NOT NULL,
  `job_title` VARCHAR(50) NOT NULL,
  `min_salary` INT NOT NULL,
  `max_salary` INT NOT NULL,
  PRIMARY KEY (`job_id`))
COMMENT = 'Table containing details of job and is an independent entity having job_id as primary key';

/*creating Location table*/
CREATE TABLE `practical_q9`.`location` (
  `location_id` VARCHAR(20) NOT NULL,
  `street` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  `state` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`location_id`))
COMMENT = 'Table containing details of locations and is an independent entity having location_id as primary key';

/*creating Department table*/
CREATE TABLE `practical_q9`.`department` (
  `department_id` VARCHAR(20) NOT NULL,
  `dept_name` VARCHAR(50) NOT NULL,
  `location_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_location_id_from_location_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_location_id_from_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `practical_q9`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Table containing details of departments and having department_id as primary key and is mant-to-one related to Location entity';

/*creating employees table*/
CREATE TABLE `practical_q9`.`employees` (
  `employee_id` VARCHAR(20) NOT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `ph_no` VARCHAR(10) NOT NULL,
  `hire_date` DATE NOT NULL,
  `job_id` VARCHAR(20) NOT NULL,
  `salary` INT NOT NULL,
  `department_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_job_id_from_job_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_department_id_from_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_job_id_from_job`
    FOREIGN KEY (`job_id`)
    REFERENCES `practical_q9`.`job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_department_id_from_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `practical_q9`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing details of employees and is dependent on department, job entity having employee_id as primary key and in many-to-one relation with department and job enity';

/*creating works table*/
CREATE TABLE `practical_q9`.`works` (
  `employee_id` VARCHAR(20) NOT NULL,
  `manager_id` VARCHAR(20) NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_id_from_employee_as_manager_idx` (`manager_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id_from_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `practical_q9`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_id_from_employee_as_manager`
    FOREIGN KEY (`manager_id`)
    REFERENCES `practical_q9`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing assignment of managers to the employee for works and is dependent on employees and job entity having employee_id as primary key and job_id of managers as assigned manager in meny-to-one relation';

DELIMITER $$
USE `practical_q9`$$
CREATE DEFINER = CURRENT_USER TRIGGER `practical_q9`.`works_BEFORE_INSERT` BEFORE INSERT ON `works` FOR EACH ROW
BEGIN
	IF "Manager" != (SELECT job.job_title FROM job INNER JOIN employees ON job.job_id=employees.employee_id WHERE employees.employee_id=NEW.manager_id) THEN
    SIGNAL SQLSTATE '80000'
	SET MESSAGE_TEXT='Assigned employee_id in Manager_id has job_id which is not mapped with any Manager please check before inserting!';
	END IF;
END$$
DELIMITER ;
DROP TRIGGER IF EXISTS `practical_q9`.`works_BEFORE_UPDATE`;

DELIMITER $$
USE `practical_q9`$$
CREATE DEFINER = CURRENT_USER TRIGGER `practical_q9`.`works_BEFORE_UPDATE` BEFORE UPDATE ON `works` FOR EACH ROW
BEGIN
	IF "Manager" != (SELECT job.job_title FROM job INNER JOIN employees ON job.job_id=employees.employee_id WHERE employees.employee_id=NEW.manager_id) THEN
    SIGNAL SQLSTATE '80000'
	SET MESSAGE_TEXT='Assigned employee_id in Manager_id has job_id which is not mapped with any Manager please check before updating!';
	END IF;
END$$
DELIMITER ;

/*creating job table*/
CREATE TABLE `practical_q9`.`job_history` (
  `employee_id` VARCHAR(20) NOT NULL,
  `leaving_date` DATE NOT NULL,
  `job_id` VARCHAR(20) NOT NULL,
  `department_id` VARCHAR(20) NOT NULL,
  INDEX `fk_employee_id_from_employees_into_job_history_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_job_id_from_job_into_job_history_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_department_id_from_job_into_job_history_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id_from_employees_into_job_history`
    FOREIGN KEY (`employee_id`)
    REFERENCES `practical_q9`.`employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_id_from_job_into_job_history`
    FOREIGN KEY (`job_id`)
    REFERENCES `practical_q9`.`job` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_id_from_job_into_job_history`
    FOREIGN KEY (`department_id`)
    REFERENCES `practical_q9`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Table containing details of job history and is dependent on employees, job, department entities having many-to-one realtion with employees, job, department';

/*creating job_history table*/


/*filling Job table*/
INSERT INTO `practical_q9`.`job` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('job-1', 'Manager', '15000', '25000');
INSERT INTO `practical_q9`.`job` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('job-2', 'Senior Clerk', '10000', '15000');
INSERT INTO `practical_q9`.`job` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('job-3', 'Junior clerk', '4500', '10000');
INSERT INTO `practical_q9`.`job` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('job-4', 'Employee', '4000', '8000');

/*filling Location table*/
INSERT INTO `practical_q9`.`location` (`location_id`, `street`, `city`, `state`, `country`) VALUES ('20', 'MG Road', 'Pune', 'Maharahstra', 'India');
INSERT INTO `practical_q9`.`location` (`location_id`, `street`, `city`, `state`, `country`) VALUES ('30', 'College Road', 'Nashik', 'Maharashtra', 'India');
INSERT INTO `practical_q9`.`location` (`location_id`, `street`, `city`, `state`, `country`) VALUES ('50', 'Times Square', 'New York City', 'New York', 'USA');
INSERT INTO `practical_q9`.`location` (`location_id`, `street`, `city`, `state`, `country`) VALUES ('40', 'Rajpath', 'Delhi', 'Delhi', 'India');

/*filling Department table*/
INSERT INTO `practical_q9`.`department` (`department_id`, `dept_name`, `location_id`) VALUES ('22', 'IT', '30');
INSERT INTO `practical_q9`.`department` (`department_id`, `dept_name`, `location_id`) VALUES ('30', 'Finance', '50');
INSERT INTO `practical_q9`.`department` (`department_id`, `dept_name`, `location_id`) VALUES ('45', 'Foreign Affairs', '20');
INSERT INTO `practical_q9`.`department` (`department_id`, `dept_name`, `location_id`) VALUES ('12', 'Administration', '40');

/*filling Employees table*/
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-1', 'Abhishek', 'Jadhav', 'abhishek@gmail.com', '7030405299', '2006-03-15', 'job-1', '20000', '45');
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-2', 'Abhijeet', 'Ingle', 'abhijeet@gmail.com', '1234567890', '2006-04-15', 'job-2', '12000', '30');
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-3', 'Atharva', 'Kinikar', 'atharva@gmail.com', '1234567890', '2006-05-02', 'job-2', '12000', '22');
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-4', 'Shlok', 'Hinge', 'shlok@gmail.com', '1234567890', '2006-04-15', 'job-3', '8000', '12');
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-5', 'Pratik', 'Gabhale', 'pratik@gmail.com', '1234567890', '2005-04-15', 'job-1', '18000', '30');
INSERT INTO `practical_q9`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `ph_no`, `hire_date`, `job_id`, `salary`, `department_id`) VALUES ('emp-6', 'Tanmay', 'Gore', 'tanmay@gmail.com', '1234567890', '2006-01-12', 'job-4', '7000', '30');

/*filling Works table*/
INSERT INTO `practical_q9`.`works` (`employee_id`, `manager_id`) VALUES ('emp-2', 'emp-1');
INSERT INTO `practical_q9`.`works` (`employee_id`, `manager_id`) VALUES ('emp-4', 'emp-5');
INSERT INTO `practical_q9`.`works` (`employee_id`, `manager_id`) VALUES ('emp-3', 'emp-1');
INSERT INTO `practical_q9`.`works` (`employee_id`) VALUES ('emp-6');

/*filling job_history table*/
INSERT INTO  practical_q9.job_history VALUES("emp-2",'2022-06-15');
INSERT INTO  practical_q9.job_history VALUES("emp-3",'2022-07-05');
INSERT INTO  practical_q9.job_history VALUES("emp-4",'2022-06-1');

/*Question 1 answer*/
SELECT * FROM employees ORDER BY employees.salary DESC;

/*Question 2 answer*/
SELECT employees.employee_id, employees.first_name, employees.last_name, employees.salary, employees.hire_date FROM employees WHERE YEAR(employees.hire_date)='2006' ORDER BY employees.hire_date DESC;

/*Question 3 answer*/
SELECT * FROM department WHERE department.location_id IN (20, 30, 50);

/*Question 4 answer*/
SELECT employees.first_name, employees.last_name FROM employees WHERE employees.first_name LIKE "%s%" OR employees.last_name LIKE "%s%";

/*Question 5 answer*/
SELECT department.*, COUNT(*) AS `Maximum no. of employees` FROM department INNER JOIN employees ON department.department_id=employees.department_id GROUP BY employees.department_id ORDER BY `Maximum no. of employees` DESC LIMIT 1;

/*Question 6 answer*/


/*Question 7 answer*/
CREATE  OR REPLACE VIEW `average_salary_of_empployees_in_each_department` AS SELECT department.*, AVG(employees.salary) AS `Average salary of department employees` FROM department INNER JOIN employees ON department.department_id=employees.department_id WHERE department.department_id=employees.department_id GROUP BY department.department_id;

SELECT * FROM `average_salary_of_empployees_in_each_department` WHERE `Average salary of department employees` > (SELECT AVG(employees.salary) FROM department INNER JOIN employees ON department.department_id=employees.department_id WHERE department.department_id="30");

/*Question 8 answer*/


/*Question 9 answer*/
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `Abhishek_Jadhav`@`%` 
    SQL SECURITY DEFINER
VIEW `min_salary_of_employee_under_a_manager` AS
    SELECT 
        `employees`.`employee_id` AS `employee_id`,
        MIN(`employees`.`salary`) AS `MIN(employees.salary)`
    FROM
        `employees`
        JOIN `works` ON `employees`.`employee_id` = `works`.`employee_id` AND `works`.`manager_id` IS NOT NULL 
    GROUP BY `works`.`manager_id`;
    
SELECT `min_salary_of_employee_under_a_manager`.*, employees.* FROM `min_salary_of_employee_under_a_manager` INNER JOIN employees ON `min_salary_of_employee_under_a_manager`.employee_id=employees.employee_id;

/*Question 10 answer*/
