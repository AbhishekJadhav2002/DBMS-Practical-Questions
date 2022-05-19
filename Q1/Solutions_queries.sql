CREATE TABLE `practical_q1`.`customer` (
  `cust_id` VARCHAR(50) NOT NULL,
  `cust_name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`cust_id`),
  UNIQUE INDEX `cust_id_UNIQUE` (`cust_id` ASC) VISIBLE)
COMMENT = 'Customer table with primary key as cust_id and has one-to-many relation with Loan entity';
  
CREATE TABLE `practical_q1`.`loan` (
  `loan_id` VARCHAR(50) NOT NULL,
  `loan_type` VARCHAR(20) NOT NULL,
  `amount` INT NOT NULL,
  `cust_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`loan_id`),
  UNIQUE INDEX `loan_id_UNIQUE` (`loan_id` ASC) VISIBLE,
  INDEX `cust_id_idx` (`cust_id` ASC) VISIBLE,
  CONSTRAINT `cust_id_fk`
    FOREIGN KEY (`cust_id`)
    REFERENCES `practical_q1`.`customer` (`cust_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table with primary key as loan_id and having many-to-one relation with customer entity';

CREATE TABLE `practical_q1`.`dependee` (
  `cust_id` VARCHAR(50) NOT NULL,
  `dep_no` INT NOT NULL,
  `relation` VARCHAR(20) NOT NULL,
  `dep_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`cust_id`),
  CONSTRAINT `user_id_as_pk`
    FOREIGN KEY (`cust_id`)
    REFERENCES `practical_q1`.`customer` (`cust_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'table having weak relationship with customer table and having primary key user_id as foreign key from customer table.';

/*filling customer table*/
INSERT INTO `practical_q1`.`customer` (`cust_id`, `cust_name`, `address`) VALUES ('cust-1', 'Abhishekl Jadhav', 'Nashik');
INSERT INTO `practical_q1`.`customer` (`cust_id`, `cust_name`, `address`) VALUES ('cust-2', 'Abhijeet Ingle', 'Abad');
INSERT INTO `practical_q1`.`customer` (`cust_id`, `cust_name`, `address`) VALUES ('cust-3', 'Atharva Kinikar', 'Pune');

/*filling loan table*/
INSERT INTO `practical_q1`.`loan` (`loan_id`, `loan_type`, `amount`, `cust_id`) VALUES ('loan-1', 'Homeloan', '200000', 'cust-1');
INSERT INTO `practical_q1`.`loan` (`loan_id`, `loan_type`, `amount`, `cust_id`) VALUES ('loan-2', 'Carloan', '20000', 'cust-3');
INSERT INTO `practical_q1`.`loan` (`loan_id`, `loan_type`, `amount`, `cust_id`) VALUES ('loan-3', 'Goldloan', '2000', 'cust-1');
INSERT INTO `practical_q1`.`loan` (`loan_id`, `loan_type`, `amount`, `cust_id`) VALUES ('loan-4', 'Carloan', '30000', 'cust-3');
INSERT INTO `practical_q1`.`loan` (`loan_id`, `loan_type`, `amount`, `cust_id`) VALUES ('loan-5', 'Homeloan', '303405', 'cust-2');

/*filling dependee table*/
INSERT INTO `practical_q1`.`dependee` (`cust_id`, `dep_no`, `relation`, `dep_name`) VALUES ('cust-1', '1', 'Children', 'Jr Abhishek');
INSERT INTO `practical_q1`.`dependee` (`cust_id`, `dep_no`, `relation`, `dep_name`) VALUES ('cust-3', '1', 'Mother', 'Jr Atharva');
INSERT INTO `practical_q1`.`dependee` (`cust_id`, `dep_no`, `relation`, `dep_name`) VALUES ('cust-2', '1', 'Cousin', 'Ingle Brothers');
