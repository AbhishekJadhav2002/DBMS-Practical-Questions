/*creating Publisher table*/
CREATE TABLE `practical_q16`.`publisher` (
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`name`))
COMMENT = 'Table containing attributes of book publisher and is an independent entity';

/*creating Book table*/
CREATE TABLE `practical_q16`.`book` (
  `book_ISBN` VARCHAR(50) NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `publisher_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`book_ISBN`),
  INDEX `fk_publisher_name_from_publisher_idx` (`publisher_name` ASC) VISIBLE,
  CONSTRAINT `fk_publisher_name_from_publisher`
    FOREIGN KEY (`publisher_name`)
    REFERENCES `practical_q16`.`publisher` (`name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing book details and having many-to-one relation with Publisher entity';

/*creating Book_Author table*/
CREATE TABLE `practical_q16`.`book_author` (
  `Book_ISBN` VARCHAR(50) NOT NULL,
  `Author_Name` VARCHAR(100) NOT NULL,
  CONSTRAINT `fk_Boook_ISBN_from_Book`
    FOREIGN KEY (`Book_ISBN`)
    REFERENCES `practical_q16`.`book` (`book_ISBN`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table mapping the author and book_ISBN';

/*creating Library_Branch table*/
CREATE TABLE `practical_q16`.`library_branch` (
  `branch_id` VARCHAR(20) NOT NULL,
  `Branch` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`branch_id`))
COMMENT = 'Table containing branch details and is an independent table having branch_id as primary key';

/*creating Borrower table*/
CREATE TABLE `practical_q16`.`borrower` (
  `card_num` VARCHAR(20) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(200) NOT NULL,
  `Phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`card_num`))
COMMENT = 'Table containing details of borrower and is an independent entity having card_num as primary key';

/*creating Book_Copies table*/
CREATE TABLE `practical_q16`.`book_copies` (
  `book_ISBN` VARCHAR(50) NOT NULL,
  `branch_id` VARCHAR(20) NOT NULL,
  `Num_copies` INT NULL DEFAULT 0,
  INDEX `fk_branch_id_from_library_branch_idx` (`branch_id` ASC) VISIBLE,
CONSTRAINT `fk_branch_id_from_library_branch`
  FOREIGN KEY (`branch_id`)
  REFERENCES `practical_q16`.`library_branch` (`branch_id`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE,
CONSTRAINT `fk_book_isbn_from_book`
  FOREIGN KEY (`book_ISBN`)
  REFERENCES `practical_q16`.`book` (`book_ISBN`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE)
COMMENT = 'Table containing count of particular book copies in particular branch and having many-to-one relation with Book, Library_branch';

/*creating book_loans table*/
CREATE TABLE `practical_q16`.`book_loans` (
  `book_ISBN` VARCHAR(50) NOT NULL,
  `branch_id` VARCHAR(20) NOT NULL,
  `card_num` VARCHAR(20) NOT NULL,
  `date_out` DATE NOT NULL,
  `date_due` DATE GENERATED ALWAYS AS (DATE_ADD(book_loan.date_out, INTERVAL 15 DAY)) VIRTUAL,
  PRIMARY KEY (`book_ISBN`, `branch_id`, `card_num`),
  INDEX `fk_branch_id_from_library_branch_into_book_loan_idx` (`branch_id` ASC) VISIBLE,
  INDEX `fk_card_num_from_borrower_idx` (`card_num` ASC) VISIBLE,
  CONSTRAINT `fk_book_isbn_from_book_into_book_loan`
    FOREIGN KEY (`book_ISBN`)
    REFERENCES `practical_q16`.`book` (`book_ISBN`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_branch_id_from_library_branch_into_book_loan`
    FOREIGN KEY (`branch_id`)
    REFERENCES `practical_q16`.`library_branch` (`branch_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_card_num_from_borrower`
    FOREIGN KEY (`card_num`)
    REFERENCES `practical_q16`.`borrower` (`card_num`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing check in-out date of particular book from particular brnach by particular borrower having many-to-one relation with branch and borrower and one-to-one relation with book';

/*filling Publisher table*/
INSERT INTO `practical_q16`.`publisher` (`name`, `address`, `phone`) VALUES ('publisher-1', 'ABC, Pune', '1234567890');
INSERT INTO `practical_q16`.`publisher` (`name`, `address`, `phone`) VALUES ('publisher-2', 'Hadapsar, Pune', '1234567890');
INSERT INTO `practical_q16`.`publisher` (`name`, `address`, `phone`) VALUES ('publisher-3', 'Mumbai', '1234567899');

/*filling Book table*/
INSERT INTO `practical_q16`.`book` (`book_ISBN`, `Title`, `publisher_name`) VALUES ('book-1', 'Title-1', 'publisher-2');
INSERT INTO `practical_q16`.`book` (`book_ISBN`, `Title`, `publisher_name`) VALUES ('book-2', 'Title-2', 'publisher-1');
INSERT INTO `practical_q16`.`book` (`book_ISBN`, `Title`, `publisher_name`) VALUES ('book-3', 'Title-3', 'publisher-1');
INSERT INTO `practical_q16`.`book` (`book_ISBN`, `Title`, `publisher_name`) VALUES ('book-4', 'Title-4', 'publisher-3');

/*filling book_author table*/
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-2', 'John Smith');
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-1', 'author-1');
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-3', 'John Smith');
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-4', 'author-4');
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-2', 'Second book-2 author');
INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-1', 'Second book-1 author');

/*filling library_branch table*/
INSERT INTO `practical_q16`.`library_branch` (`branch_id`, `Branch`, `Address`) VALUES ('branch-1', 'Branch One', 'ABC, Pune');
INSERT INTO `practical_q16`.`library_branch` (`branch_id`, `Branch`, `Address`) VALUES ('branch-2', 'Branch Two', 'Hadpasar, Pune');
INSERT INTO `practical_q16`.`library_branch` (`branch_id`, `Branch`, `Address`) VALUES ('branch-4', 'Branch Four', 'Mumbai');

/*filling borrower table*/
INSERT INTO `practical_q16`.`borrower` (`card_num`, `Name`, `Address`, `Phone`) VALUES ('borrower-1', 'Borrower One', 'ABC, Pune', '1234567890');
INSERT INTO `practical_q16`.`borrower` (`card_num`, `Name`, `Address`, `Phone`) VALUES ('borrower-2', 'Borrower Two', 'Hadapaar, Pune', '1234567899');
INSERT INTO `practical_q16`.`borrower` (`card_num`, `Name`, `Address`, `Phone`) VALUES ('borrower-3', 'Borrower Three', 'Mumbai', '1234567898');

/*filling book_copies table*/
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-1', 'branch-1', '2');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-2', 'branch-2', '3');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-3', 'branch-2', '0');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-4', 'branch-1', '2');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-2', 'branch-1', '3');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-3', 'branch-1', '1');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-2', 'branch-4', '2');
INSERT INTO `practical_q16`.`book_copies` (`book_ISBN`, `branch_id`, `Num_copies`) VALUES ('book-4', 'branch-2', '1');

/*filling book_loan table*/
INSERT INTO `practical_q16`.`book_loans` (`book_ISBN`, `branch_id`, `card_num`, `date_out`) VALUES ('book-1', 'branch-1', 'borrower-1', '2014-06-16');
INSERT INTO `practical_q16`.`book_loans` (`book_ISBN`, `branch_id`, `card_num`, `date_out`) VALUES ('book-3', 'branch-1', 'borrower-1', '2014-06-16');
INSERT INTO `practical_q16`.`book_loans` (`book_ISBN`, `branch_id`, `card_num`, `date_out`) VALUES ('book-2', 'branch-2', 'borrower-2', '2015-10-15');
INSERT INTO `practical_q16`.`book_loans` (`book_ISBN`, `branch_id`, `card_num`, `date_out`) VALUES ('book-2', 'branch-4', 'borrower-3', '2015-12-04');

/*Question 1 answer*/
SELECT book.book_ISBN, book.title, book_author.Author_name FROM book INNER JOIN book_author ON book_author.book_ISBN=book.book_ISBN WHERE book_author.Author_name="John Smith";

/*Question 2 answer*/
USE `practical_q16`;
CREATE  OR REPLACE VIEW `COUNT_OF_AUTHORS` AS SELECT COUNT(*) AS `No of Authors`, book_author.book_ISBN FROM book_author GROUP BY book_author.book_ISBN;

SELECT * FROM COUNT_OF_AUTHORS;

/*Question 3 answer*/
USE `practical_q16`;
CREATE  OR REPLACE VIEW `MULTIPLE_BOOK_BORROW` AS SELECT COUNT(*) AS `No of Books`, borrower.*, book_loans.book_ISBN, book_loans.date_out FROM book_loans INNER JOIN borrower ON borrower.card_num=book_loans.card_num WHERE book_loans.date_out="2014-06-16" GROUP BY card_num;

SELECT borrower.*, book_loans.branch_id, book_loans.date_out, COUNT(*) AS `No of Books` FROM borrower INNER JOIN book_loans ON book_loans.card_num=borrower.card_num WHERE borrower.card_num IN (SELECT card_num FROM `MULTIPLE_BOOK_BORROW`) GROUP BY borrower.card_num;

/*Question 4 answer*/


/*Question 5 answer*/
DELIMITER $$
USE `practical_q16`$$
CREATE DEFINER=`Abhishek_Jadhav`@`%` TRIGGER `book_author_BEFORE_INSERT` BEFORE INSERT ON `book_author` FOR EACH ROW BEGIN
	SET NEW.Author_Name = UPPER(NEW.Author_Name);
END$$
DELIMITER ;

INSERT INTO `practical_q16`.`book_author` (`Book_ISBN`, `Author_Name`) VALUES ('book-4', 'Second book-4 author');

