
CREATE DATABASE IF NOT EXISTS `helpoutdb`;
USE `helpoutdb`;


#############################
#
#  T A B L E S
#
#############################

#
# Table structure for table 'events'
#

CREATE TABLE `events` (
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
# Table structure for table 'hosts'
#


CREATE TABLE `hosts` (
  `hid` INTEGER NOT NULL AUTO_INCREMENT,
  `host organization` VARCHAR(100),
  `email` VARCHAR(50),
  INDEX (`hid`),
  PRIMARY KEY (`hid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'skills'
#


CREATE TABLE `skills` (
  `sid` INTEGER AUTO_INCREMENT,
  `skillname` VARCHAR(50),
  `skilldescription` VARCHAR(255),
  INDEX (`sid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'users'
#


CREATE TABLE `users` (
  `uid` INTEGER NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(20),
  `lastname` VARCHAR(25),
  `email` VARCHAR(50),
  `lattitude` DOUBLE NULL DEFAULT 0,
  `longitude` DOUBLE NULL DEFAULT 0,
  `usertype` VARCHAR(50),
  PRIMARY KEY (`uid`),
  INDEX (`uid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;



#############################
#
#  Q u e r i e s
#
#############################

#
# Query #1 for For 'View Volunteer Event' (Gets all events)
#

SELECT `eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`
FROM `events`;


#
# Query #2 for For 'View Volunteer Event' (Gets user selected event)
#

SELECT `eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`
FROM `events` WHERE `eid` = ? ;





#############################
#
#  S a m p l e    D a t a
#
#############################

#
# Data for table 'events'
#

INSERT INTO `events` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (1, 1, '2017-11-25 00:00:00', 'East bank river clean-up', 'We are going clean up the east bank of the river from OMSI to the Hawthorne bridge.', 'Meet underneath the Hawthorne Bridge on the east side of the river', 0, 0);
INSERT INTO `events` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (2, 5, '2017-12-12 00:00:00', 'Painting benches at Alberta park', 'Seven park benches have been vandalized and need a new coat of paint', 'Meet at the corner of 19th and Killingsworth', 0, 0);
INSERT INTO `events` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES (3, 1, '2017-12-01 00:00:00', 'Ross Island beach clean-up', 'We will clean up the shores of Ross Island after the heavy rain', 'Clean-up crew departs from Willamette Park boat ramp at 9am sharp', 0, 0);
# 3 records

#
# Data for table 'hosts'
#

INSERT INTO `hosts` (`hid`, `host organization`, `email`) VALUES (1, 'Willamette River Keepers', 'cleanrivers@gmail.com');
INSERT INTO `hosts` (`hid`, `host organization`, `email`) VALUES (2, 'Red Cross Portland', 'events@redcross.org');
INSERT INTO `hosts` (`hid`, `host organization`, `email`) VALUES (3, 'Sisters of the Road', 'kitchen@sistersoftheroad.org');
INSERT INTO `hosts` (`hid`, `host organization`, `email`) VALUES (4, 'Portland Youth Soccer', 'kickit@portlandyouth.net');
INSERT INTO `hosts` (`hid`, `host organization`, `email`) VALUES (5, 'Alberta Neighborhood Association', 'goodneighbors@alberta.org');
# 5 records

#
# Data for table 'skills'
#

INSERT INTO `skills` (`sid`, `skillname`, `skilldescription`) VALUES (1, 'Painting - general', 'Be able to wield a brush on uncomplicated tasks and not make a giant mess');
INSERT INTO `skills` (`sid`, `skillname`, `skilldescription`) VALUES (2, 'Painting - interiors', 'Ability to prep, mask and paint interior projects including cabinetry and trim');
INSERT INTO `skills` (`sid`, `skillname`, `skilldescription`) VALUES (3, 'Carpentry - structural', 'Framing and structural construction execution');
INSERT INTO `skills` (`sid`, `skillname`, `skilldescription`) VALUES (4, 'Carpentry - joinery', 'Complex joinery requried for cabinetry, furniture-making or other');
# 4 records

#
# Data for table 'users'
#

INSERT INTO `users` (`uid`, `firstname`, `lastname`, `email`, `lattitude`, `longitude`, `usertype`) VALUES (1, 'Fred', 'Flintstone', 'fred@rockville.net', 0, 0, 'volunteer');
# 1 records

