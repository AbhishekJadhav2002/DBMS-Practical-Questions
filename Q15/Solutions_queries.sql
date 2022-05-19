/*creating Employee table*/
CREATE TABLE `practical_q15`.`employee` (
  `person_name` VARCHAR(100) NOT NULL,
  `street` VARCHAR(50) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`person_name`))
COMMENT = 'This table contains details attributes of employee and is an independent table';

/*creating Company table*/
CREATE TABLE `practical_q15`.`company` (
  `company_name` VARCHAR(100) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`company_name`))
COMMENT = 'Table contain details of company';

/*creating works table*/
CREATE TABLE `practical_q15`.`works` (
  `person_name` VARCHAR(100) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  `salary` INT NOT NULL,
  PRIMARY KEY (`person_name`),
  CONSTRAINT `fk_person_name_from_Employee`
    FOREIGN KEY (`person_name`)
    REFERENCES `practical_q15`.`employee` (`person_name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table assigning companies to the persons and having many-to-one relation with employee';

/*creating Manages table*/
CREATE TABLE `practical_q15`.`manages` (
  `person_name` VARCHAR(100) NOT NULL,
  `manager_name` VARCHAR(100),
  PRIMARY KEY (`person_name`),
  INDEX `fk_person_name_from_Employee_as_person_name_idx` (`person_name` ASC) VISIBLE,
  CONSTRAINT `fk_person_name_from_Employee_as_manager_name`
    FOREIGN KEY (`manager_name`)
    REFERENCES `practical_q15`.`employee` (`person_name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_person_name_from_Employee_as_person_name`
    FOREIGN KEY (`person_name`)
    REFERENCES `practical_q15`.`employee` (`person_name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing manager assignments to the employees and having one-to-one relation between Employee';

/*filling Employee table*/
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Abhi Jadhav', 'College Road', 'Nashik');
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Abhi Ingle', 'Mahajan Road', 'Abad');
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Pratik Gabhale', 'Thane Highway', 'Thane');
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Atharva Kinikar', 'Camp Road', 'Pune');
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Shlok Hinge', 'Hingewadi Road', 'Pune');
INSERT INTO `practical_q15`.`employee` (`person_name`, `street`, `city`) VALUES ('Tanmay Gore', 'College Road', 'Nashik');


/*filling Company table*/
INSERT INTO `practical_q15`.`company` (`company_name`, `city`) VALUES ('First Bank Corporation', 'Nashik');
INSERT INTO `practical_q15`.`company` (`company_name`, `city`) VALUES ('Microsoft', 'Abad');
INSERT INTO `practical_q15`.`company` (`company_name`, `city`) VALUES ('Google', 'Thane');

/*filling works table*/
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Abhi Jadhav', 'First Bank Corporation', '125000');
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Abhi Ingle', 'Microsoft', '120000');
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Pratik Gabhale', 'First Bank Corporation', '100000');
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Atharva Kinikar', 'Microsoft', '150000');
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Shlok Hinge', 'First Bank Corporation', '120000');
INSERT INTO `practical_q15`.`works` (`person_name`, `company_name`, `salary`) VALUES ('Tanmay Gore', 'First Bank Corporation', '100000');

/*filling Manages table*/
INSERT INTO `practical_q15`.`manages` (`person_name`, `manager_name`) VALUES ('Pratik Gabhale', 'Abhi Jadhav');
INSERT INTO `practical_q15`.`manages` (`person_name`, `manager_name`) VALUES ('Shlok Hinge', 'Abhi Jadhav');
INSERT INTO `practical_q15`.`manages` (`person_name`, `manager_name`) VALUES ('Abhi Ingle', 'Atharva Kinikar');
INSERT INTO `practical_q15`.`manages` (`person_name`, `manager_name`) VALUES ('Tanmay Gore', 'Abhi Jadhav');

/*Question 1 answer*/
SELECT employee.* FROM employee INNER JOIN works ON works.person_name=employee.person_name WHERE works.company_name="First Bank Corporation" AND works.salary>100000;

/*Question 2 answer*/
SELECT employee.person_name, employee.city, company.city AS `Company City` FROM works INNER JOIN employee ON employee.person_name=works.person_name INNER JOIN company ON works.company_name=company.company_name WHERE employee.city=company.city;

/*Question 3 answer*/
SELECT emp.person_name FROM works, employee emp, employee manager, company emp_city, company manager_city INNER JOIN employee ON emp.person_name=works.person_name AND manager.person_name=works.manager_name INNER JOIN comapany ON works.company_name=emp_city.company_name AND works.company_name=manager_city.company_name WHERE emp.city=manager.city;
SELECT emp.person_name FROM employee emp, employee manager INNER JOIN works ON emp.person_name=works;

/*Question 4 answer*/
CREATE  OR REPLACE VIEW `manager_details` AS SELECT employee.* FROM works INNER JOIN manages ON manages.manager_name=works.person_name INNER JOIN employee ON works.person_name=employee.person_name;
SELECT DISTINCT employee.* FROM manages INNER JOIN employee ON manages.person_name=employee.person_name INNER JOIN manager_details ON manages.manager_name=manager_details.person_name WHERE employee.city=manager_details.city AND employee.street=manager_details.street;

/*Question 5 answer*/
DELIMITER $$
USE `practical_q15`$$
CREATE DEFINER=`Abhishek_Jadhav`@`%` TRIGGER `works_BEFORE_UPDATE` BEFORE UPDATE ON `works` FOR EACH ROW BEGIN
	IF (SELECT COUNT(*) FROM works INNER JOIN manages ON manages.manager_name=works.person_name) > 1 THEN
		UPDATE manages SET manager_name=null WHERE manages.manager_name=works.person_name;
	ELSE 
		DELETE FROM manages WHERE manages.person_name=works.person_name;
	end if;
END$$
DELIMITER ;

UPDATE works SET company_name="Samsung" WHERE works.person_name="Atharva Kinikar";
UPDATE works SET company_name="Google" WHERE works.person_name="Shlok Hinge";
SELECT * FROM manages;