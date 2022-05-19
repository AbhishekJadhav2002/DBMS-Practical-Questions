/*creating Book table*/
CREATE TABLE `practical_q3`.`book` (
  `book_no` VARCHAR(20) NOT NULL,
  `book_name` VARCHAR(100) NOT NULL,
  `author_name` VARCHAR(100) NOT NULL,
  `cost` INT NOT NULL,
  `category` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`book_no`))
COMMENT = 'Table of book containing attributes of a book and having many-to-many relation with member entity';

/*creating Member table*/
CREATE TABLE `practical_q3`.`member` (
  `M_Id` VARCHAR(20) NOT NULL,
  `M_Name` VARCHAR(100) NOT NULL,
  `Mship_type` VARCHAR(20) NOT NULL,
  `fees_paid` INT NOT NULL,
  `Max_Books_Allowed` INT NOT NULL,
  `Penalty_Amount` INT NOT NULL DEFAULT 100,
  PRIMARY KEY (`M_Id`))
COMMENT = 'Table having attributes of members and having many-to-many relation with book table';

/*creating Issue table*/
CREATE TABLE `practical_q3`.`issue` (
  `Lib_Issue_Id` VARCHAR(50) NOT NULL,
  `book_no` VARCHAR(20) NOT NULL,
  `M_Id` VARCHAR(20) NOT NULL,
  `Issue_Date` DATE NOT NULL,
  `Return_Date` DATE NULL,
  PRIMARY KEY (`Lib_Issue_Id`),
  INDEX `fk_book_no_from_Book_idx` (`book_no` ASC) VISIBLE,
  INDEX `fk_M_Id_from_member_idx` (`M_Id` ASC) VISIBLE,
  CONSTRAINT `fk_book_no_from_Book`
    FOREIGN KEY (`book_no`)
    REFERENCES `practical_q3`.`book` (`book_no`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_M_Id_from_member`
    FOREIGN KEY (`M_Id`)
    REFERENCES `practical_q3`.`member` (`M_Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing dates for book issue and return and having foreign keys from book and member for maintaining many-to-many relation';

/*filling Book table*/
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-1', 'Physics', 'Scott Urman', '500', 'Science');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-2', 'Chemistry', 'VK Jaiswal', '300', 'Science');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-3', 'Half Girlfriend', 'Chetan Bhagat', '301', 'Story');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-4', 'Do Epic Shit', 'Ankur', '200', 'Philosophy');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-5', 'Math', 'S. Chand', '301', 'Sceince');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-6', 'Processor Architecture', 'Danny Causay', '500', 'Science');
INSERT INTO `practical_q3`.`book` (`book_no`, `book_name`, `author_name`, `cost`, `category`) VALUES ('Book-7', 'Python', 'Scott Urman', '500', 'Technology');

/*filling Member table*/
INSERT INTO `practical_q3`.`member` (`M_Id`, `M_Name`, `Mship_type`, `fees_paid`, `Max_Books_Allowed`) VALUES ('23231', 'Abhijeet Ingle', 'Annual', '100', '15',  '100');
INSERT INTO `practical_q3`.`member` (`M_Id`, `M_Name`, `Mship_type`, `fees_paid`, `Max_Books_Allowed`) VALUES ('23232', 'Abhishek Jadhav', 'Annual', '100', '15', '100');
INSERT INTO `practical_q3`.`member` (`M_Id`, `M_Name`, `Mship_type`, `fees_paid`, `Max_Books_Allowed`) VALUES ('23241', 'Atharva Kinikar', 'Monthly', '50', '5', '150');
INSERT INTO `practical_q3`.`member` (`M_Id`, `M_Name`, `Mship_type`, `fees_paid`, `Max_Books_Allowed`) VALUES ('23229', 'Shlok Hinge', 'Monthly', '50', '5', '150');
INSERT INTO `practical_q3`.`member` (`M_Id`, `M_Name`, `Mship_type`, `fees_paid`, `Max_Books_Allowed`, `Penalty_Amount`) VALUES ('23225', 'Pratik Gabhale', 'Annual', '100', '15', '100');

/*filling Issue table*/
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-1', 'Book-1', '23232', '2022-05-15', '2022-05-31');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-2', 'Book-2', '23231', '2022-05-14', '2022-05-30');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-3', 'Book-3', '23232', '2022-04-04', '2022-04-20');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-4', 'Book-1', '23231', '2022-06-01', '2022-06-16');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-5', 'Book-5', '23229', '2022-05-10', '2022-05-26');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-6', 'Book-6', '23241', '2022-04-07', '2022-04-23');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-7', 'Book-4', '23229', '2022-05-10', '2022-05-26');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-8', 'Book-2', '23232', '2022-04-03', '2022-04-19');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-9', 'Book-1', '23241', '2022-02-12', '2022-02-28');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-10', 'Book-3', '23231', '2022-03-06', '2022-03-22');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-11', 'Book-2', '23231', '2021-12-14', '2021-12-30');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-12', 'Book-1', '23232', '2021-11-04', '2021-11-20');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-13', 'Book-2', '23225', '2022-01-06', '2022-01-22');
INSERT INTO `practical_q3`.`issue` (`Lib_Issue_Id`, `book_no`, `M_Id`, `Issue_Date`, `Return_Date`) VALUES ('Issue-14', 'Book-1', '23225', '2022-06-14', '2022-06-30');

/*Questin 1 answer*/

/*Question 2 answer*/
SELECT member.M_Name, book.book_name, book.cost FROM Issue INNER JOIN member ON Issue.M_Id=member.M_Id INNER JOIN Book ON Book.book_no=issue.book_no WHERE book.author_name="scott Urman" and book.cost > 300;

/*Question 3 answer*/
SELECT book.category, COUNT(*) AS `No of Books by category` FROM Issue INNER JOIN Book ON Issue.book_no=Book.book_no GROUP BY Book.category;