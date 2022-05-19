/*creating remotecentre table*/
CREATE TABLE `practical_q6`.`remotecentre` (
  `centreId` VARCHAR(20) NOT NULL,
  `college` VARCHAR(100) NOT NULL,
  `town` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`centreId`))
COMMENT = 'Table containing only one primary key and is an independent entity';

/*creating person table*/
CREATE TABLE `practical_q6`.`person` (
  `ID` VARCHAR(20) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`ID`))
COMMENT = 'Table containing details of person and is an independent table';

/*creating programme table*/
CREATE TABLE `practical_q6`.`programme` (
  `progId` VARCHAR(20) NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `fromdate` DATE NOT NULL,
  `todate` DATE NOT NULL,
  PRIMARY KEY (`progId`))
COMMENT = 'Table containing details of programmes and is an independent table';

/*creating coordinator table*/
CREATE TABLE `practical_q6`.`coordinator` (
  `ID` VARCHAR(20) NOT NULL,
  `progId` VARCHAR(20) NOT NULL,
  `centreId` VARCHAR(20) NOT NULL,
  INDEX `fk_ID_from_person_idx` (`ID` ASC) VISIBLE,
  INDEX `fk_progId_from_programme_idx` (`progId` ASC) VISIBLE,
  INDEX `fk_centreId_from_remotecentre_idx` (`centreId` ASC) VISIBLE,
  CONSTRAINT `fk_ID_from_person`
    FOREIGN KEY (`ID`)
    REFERENCES `practical_q6`.`person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_progId_from_programme`
    FOREIGN KEY (`progId`)
    REFERENCES `practical_q6`.`programme` (`progId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_centreId_from_remotecentre`
    FOREIGN KEY (`centreId`)
    REFERENCES `practical_q6`.`remotecentre` (`centreId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing foreign keys from all independent table i.e. one-to-one relaton with person and many-to-one relation with remotecentre, programme';

/*creating participant table*/
CREATE TABLE `practical_q6`.`participant` (
  `ID` VARCHAR(20) NOT NULL,
  `centreId` VARCHAR(20) NOT NULL,
  `progId` VARCHAR(20) NOT NULL,
  INDEX `fk_ID_from_person_idx` (`ID` ASC) VISIBLE,
  INDEX `fk_centreId_from_remotecentre_idx` (`centreId` ASC) VISIBLE,
  INDEX `fk_progId_from_programme_idx` (`progId` ASC) VISIBLE,
  CONSTRAINT `fk_ID_from_person_into_participant`
    FOREIGN KEY (`ID`)
    REFERENCES `practical_q6`.`person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_centreId_from_remotecentre_into_participant`
    FOREIGN KEY (`centreId`)
    REFERENCES `practical_q6`.`remotecentre` (`centreId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_progId_from_programme_into_participant`
    FOREIGN KEY (`progId`)
    REFERENCES `practical_q6`.`programme` (`progId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
COMMENT = 'Table containing all primary keys of all independent tables and having one-to-one relation with person and many-to-one relation with remotecentre, programme';
