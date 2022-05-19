/*Creating Painter table*/
CREATE TABLE `practical_q2`.`painter` (
  `painter_id` VARCHAR(20) NOT NULL,
  `painter_name` VARCHAR(100) NOT NULL,
  `contact_no` VARCHAR(10) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`painter_id`))
COMMENT = 'Table  with painter_cd as primary key and havign one-to-many relation with painting entity';

/*Creating Painting table*/
CREATE TABLE `practical_q2`.`painting` (
  `painting_id` VARCHAR(50) NOT NULL,
  `painting_desc` VARCHAR(100) NOT NULL,
  `painting_theme` VARCHAR(20) NOT NULL,
  `painter_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`painting_id`),
  CONSTRAINT `fk_painter_id_from_painter`
    FOREIGN KEY (`painter_id`)
    REFERENCES `practical_q2`.`painter` (`painter_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'table with attributes of a painting and having many-to-one relation with painter';

/*Creating Gallery table*/
CREATE TABLE `practical_q2`.`gallery` (
  `gallery_no` VARCHAR(20) NOT NULL,
  `galllery_name` VARCHAR(50) NOT NULL,
  `gallery_address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`gallery_no`))
COMMENT = 'Table having galleries and having one-to-many relation with painting entity';

/*Adding gallery_no foreign key to the painting table using alter*/
ALTER TABLE `practical_q2`.`painting` 
ADD COLUMN `gallery_no` VARCHAR(20) NOT NULL AFTER `painter_id`,
ADD INDEX `fk_gallery_no_from_gallery_idx` (`gallery_no` ASC) VISIBLE;
ALTER TABLE `practical_q2`.`painting` 
ADD CONSTRAINT `fk_gallery_no_from_gallery`
  FOREIGN KEY (`gallery_no`)
  REFERENCES `practical_q2`.`gallery` (`gallery_no`)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;
  
/*filling Painter table*/
INSERT INTO `practical_q2`.`painter` (`painter_id`, `painter_name`, `contact_no`, `address`) VALUES ('painter-1', 'Abhishek Jadhav', '7030405299', 'Nashik');
INSERT INTO `practical_q2`.`painter` (`painter_id`, `painter_name`, `contact_no`, `address`) VALUES ('painter-2', 'Abhijeet Ingle', '1234567890', 'Abad');

/*filling Gallery table*/
INSERT INTO `practical_q2`.`gallery` (`gallery_no`, `galllery_name`, `gallery_address`) VALUES ('gallery-1', 'Nashik Art Gallery', 'Nashik');
INSERT INTO `practical_q2`.`gallery` (`gallery_no`, `galllery_name`, `gallery_address`) VALUES ('gallery-2', 'Abad Art Gallery', 'Abad');
INSERT INTO `practical_q2`.`gallery` (`gallery_no`, `galllery_name`, `gallery_address`) VALUES ('gallery-4', 'Greate Indian Gallery', 'Mumbai');
INSERT INTO `practical_q2`.`gallery` (`gallery_no`, `galllery_name`, `gallery_address`) VALUES ('gallery-3', 'Kalidaas Art Gallery', 'Pune');

/*filling Painting table*/
INSERT INTO `practical_q2`.`painting` (`painting_id`, `painting_desc`, `painting_theme`, `painter_id`, `gallery_no`) VALUES ('art-1', 'Awesome sketch', 'Nature landscape', 'painter-1', 'gallery-2');
INSERT INTO `practical_q2`.`painting` (`painting_id`, `painting_desc`, `painting_theme`, `painter_id`, `gallery_no`) VALUES ('art-3', 'Legendary', 'Material Theme', 'painter-2', 'gallery-4');
