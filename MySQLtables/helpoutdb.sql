
CREATE DATABASE IF NOT EXISTS `helpoutdb`;
USE `helpoutdb`;


#############################
#
#  T A B L E S
#
#############################

#
# Table structure for table 'event'
#

CREATE TABLE `event` (
  `eid` INTEGER NOT NULL AUTO_INCREMENT,
  `hid` INTEGER DEFAULT 0,
  `eventdate` DATETIME,
  `eventname` VARCHAR(50),
  `eventdescription` VARCHAR(255),
  `eventmeetdetails` VARCHAR(255),
  `eventlatitude` DOUBLE NULL DEFAULT 0,
  `eventlongitude` DOUBLE NULL DEFAULT 0,
  INDEX (`eid`),
  INDEX (`hid`),
  PRIMARY KEY (`eid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'host'
#


CREATE TABLE `host` (
  `hid` INTEGER NOT NULL AUTO_INCREMENT,
  `hostorg` VARCHAR(100),
  `email` VARCHAR(50),
  INDEX (`hid`),
  PRIMARY KEY (`hid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'skill'
#


CREATE TABLE `skill` (
  `sid` INTEGER AUTO_INCREMENT,
  `skillname` VARCHAR(50),
  `skilldescription` VARCHAR(255),
  INDEX (`sid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'volunteer'
#


CREATE TABLE `volunteer` (
  `vid` INTEGER NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(20),
  `lastname` VARCHAR(25),
  `email` VARCHAR(50),
  `latitude` DOUBLE NULL DEFAULT 0,
  `longitude` DOUBLE NULL DEFAULT 0,
  `usertype` VARCHAR(50),
  PRIMARY KEY (`vid`),
  INDEX (`vid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Table structure for table 'volunteer_skill'
#

CREATE TABLE `volunteer_skill`(
  `vid` INTEGER NOT NULL,
  `sid` INTEGER NOT NULL,
  CONSTRAINT `volunteer_skill_ibfk_1` FOREIGN KEY(`vid`)
  REFERENCES `volunteer` (`vid`),
  CONSTRAINT `volunteer_skill_ibfk_2` FOREIGN KEY(`sid`)
  REFERENCES `skill` (`sid`),
  UNIQUE KEY(`vid`, `sid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Table structure for table 'volunteer_event'
#

CREATE TABLE `volunteer_event`(
  `vid` INTEGER NOT NULL,
  `eid` INTEGER NOT NULL,
  CONSTRAINT `volunteer_event_ibfk_1` FOREIGN KEY(`vid`)
  REFERENCES `volunteer` (`vid`),
  CONSTRAINT `volunteer_event_ibfk_2` FOREIGN KEY(`eid`)
  REFERENCES `event` (`eid`),
  UNIQUE KEY(`vid`, `eid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#############################
#
#  Q u e r i e s
#
#############################

#
# Query #1 for 'View Volunteer Event' (Gets all events)
#

SELECT `eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`
FROM `event`;


#
# Query #2 for 'View Volunteer Event' (Gets volunteer selected event)
#

SELECT `eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`
FROM `event` WHERE `eid` = ? ;


#
# Query #3 for 'Select skilled Volunteer' (gets any volunteer with specific skill id)
#

SELECT volunteer.vid, volunteer.firstname, volunteer.lastname, volunteer.email, volunteer.latitude, volunteer.longitude, volunteer.usertype, volunteer_skill.sid
FROM volunteer LEFT JOIN volunteer_skill ON volunteer.vid = volunteer_skill.vid
WHERE volunteer_skill.sid = ? ;

#
# Query #4 for 'Filter by Geography' (returns any event within specific geographic bounds)
#

SELECT `eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`
FROM `event`
WHERE (`eventlatitude`> ?MINLAT? And `eventlatitude` < ?MAXLAT?) AND (`eventlongitude` > ?MINLONG? And `eventlongitude` < ?MAXLONG?);


#############################
#
#  S a m p l e    D a t a
#
#############################

#
# Data for table 'event'
#

INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (1, 1, '2017-11-25 00:00:00', 'East bank river clean-up', 'We are going clean up the east bank of the river from OMSI to the Hawthorne bridge.', 'Meet underneath the Hawthorne Bridge on the east side of the river', 45.51251597870104,  -122.66822218894957);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (2, 5, '2017-12-12 00:00:00', 'Painting benches at Alberta park', 'Seven park benches have been vandalized and need a new coat of paint', 'Meet at the corner of 19th and Killingsworth', 45.56276443144316, -122.64597058296204);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (3, 1, '2017-12-01 00:00:00', 'Ross Island beach clean-up', 'We will clean up the shores of Ross Island after the heavy rain', 'Clean-up crew departs from Willamette Park boat ramp at 9am sharp', 45.47557036440473, -122.66932725906372);
# 3 records

#
# Data for table 'host'
#

INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES (1, 'Willamette River Keepers', 'cleanrivers@gmail.com');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES (2, 'Red Cross Portland', 'events@redcross.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES (3, 'Sisters of the Road', 'kitchen@sistersoftheroad.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES (4, 'Portland Youth Soccer', 'kickit@portlandyouth.net');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES (5, 'Alberta Neighborhood Association', 'goodneighbors@alberta.org');
# 5 records

#
# Data for table 'skill'
#

INSERT INTO `skill` (`sid`, `skillname`, `skilldescription`) VALUES (1, 'Painting - general', 'Be able to wield a brush on uncomplicated tasks and not make a giant mess');
INSERT INTO `skill` (`sid`, `skillname`, `skilldescription`) VALUES (2, 'Painting - interiors', 'Ability to prep, mask and paint interior projects including cabinetry and trim');
INSERT INTO `skill` (`sid`, `skillname`, `skilldescription`) VALUES (3, 'Carpentry - structural', 'Framing and structural construction execution');
INSERT INTO `skill` (`sid`, `skillname`, `skilldescription`) VALUES (4, 'Carpentry - joinery', 'Complex joinery requried for cabinetry, furniture-making or other');
# 4 records

#
# Data for table 'volunteer'
#

INSERT INTO `volunteer` (`vid`, `firstname`, `lastname`, `email`, `latitude`, `longitude`, `usertype`) VALUES (1, 'Fred', 'Flintstone', 'fred@rockville.net', 45.64514324557451, -122.65740752220154, 'volunteer');
INSERT INTO `volunteer` (`vid`, `firstname`, `lastname`, `email`, `latitude`, `longitude`, `usertype`) VALUES (2, 'Donal', 'Duck', 'donald@easystreet.com', 46.12567886977839, -122.93576717376708, 'volunteer');
#
# 1 records

#
# Data for table `volunteer_skill`
#

INSERT INTO `volunteer_skill` (`vid`, `sid`) VALUES
(1, 1),
(1, 2);

##########################################################
#
#  EDIT DATA (These should not be run manually)
#
##########################################################

INSERT INTO `volunteer` (`email`) VALUES (`emailInput`);
INSERT INTO `volunteer_event` (`vid`, `sid`) VALUES (`vidInput, sidInput`);