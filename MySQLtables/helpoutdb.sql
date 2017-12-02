
CREATE DATABASE IF NOT EXISTS `helpoutdb`;
USE `helpoutdb`;


#############################
#
#  T A B L E S
#
#############################

#
# Table structure for 'category'
#

CREATE TABLE `category` (
  `cid` INTEGER NOT NULL AUTO_INCREMENT,
  `categoryname` VARCHAR(50),
  INDEX (`cid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;



#
# Table structure for table 'event'
#

CREATE TABLE `event` (
  `eid` INTEGER NOT NULL AUTO_INCREMENT,
  `hid` INTEGER NOT NULL,
  `eventdate` DATETIME,
  `eventname` VARCHAR(50),
  `eventdescription` VARCHAR(255),
  `eventmeetdetails` VARCHAR(255),
  `eventlatitude` DOUBLE NULL DEFAULT 0,
  `eventlongitude` DOUBLE NULL DEFAULT 0,
  INDEX (`eid`),
  INDEX (`hid`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`hid`)
  REFERENCES `host` (`hid`) ON UPDATE CASCADE ON DELETE SET NULL,
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
  `cid` INTEGER NOT NULL,
  INDEX (`hid`),
  INDEX (`cid`),
  CONSTRAINT `host_ibfk_1` FOREIGN KEY (`cid`)
  REFERENCES `category` (`cid`) ON UPDATE CASCADE ON DELETE SET NULL,
  PRIMARY KEY (`hid`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;


#
# Table structure for table 'skill'
#


CREATE TABLE `skill` (
  `sid` INTEGER NOT NULL AUTO_INCREMENT,
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
  UNIQUE KEY (`email`),
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


INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(1, 1, '2017-12-27 00:00:00', 'East bank river clean-up', 'We are going clean up the east bank of the river from OMSI to the Hawthorne bridge.', 'Meet underneath the Hawthorne Bridge on the east side of the river', 45.51251597870104, -122.66822218894957);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(2, 5, '2017-12-12 00:00:00', 'Painting benches at Alberta park', 'Seven park benches have been vandalized and need a new coat of paint', 'Meet at the corner of 19th and Killingsworth', 45.56276443144316, -122.64597058296204);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(3, 1, '2017-12-01 00:00:00', 'Ross Island beach clean-up', 'We will clean up the shores of Ross Island after the heavy rain', 'Clean-up crew departs from Willamette Park boat ramp at 9am sharp', 45.47557036440473, -122.66932725906372);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(4, 6, '2017-12-20 00:00:00', 'Potluck in the Park Dessert Service', 'Special theme for Potluck in the Park this month - we are serving desserts', 'Dress warm, ages 16+ welcome', 45.54012756252958, -122.62942671775816);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(5, 7, '2017-12-18 00:00:00', 'Fresh Food Sorting & Repacking at OFB', 'Food bank needs helps organizing donations.', 'Come by and help if you are good with your hands! Ages 16+', 45.580211060077175, -122.6317548751831);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(6, 8, '2017-12-16 00:00:00', 'Sell Christmas Trees ', 'Christmas fundraiser for the Boy Scouts - we need helpers!', 'Serve our visitors cider and cookies as they shop for trees', 45.519338, -122.690682);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(7, 9, '2017-12-13 00:00:00', 'Shop for Seniors in Hollywood', 'Do you like to grocery shop? Would you enjoy helping seniors and people with disabilities maintain their independence? Join us to grocery shop for those who are homebound.', 'Volunteer grocery shoppers receive a client’s grocery list and walk about the store finding each item.', 45.532995774464865, -122.63485550880432);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(8, 10, '2017-12-23 00:00:00', 'Get Books to Children at Childrens Book Bank ', 'Join us at Sellwood public library and lend a hand as we spruce-up community donated books which will later be distributed to low-income preschool children in the Portland area!  Every gently-used donated book is inspected and cleaned by volunteers. ', 'Tasks include wiping covers, taping torn pages, erasing scribbles, covering inscriptions, and reinforcing worn spines.', 45.46768925855662, -122.65277802944183);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(9, 9, '2017-12-28 00:00:00', 'Grocery Shop for Seniors in Beaverton', 'Do you like to grocery shop? Would you enjoy helping seniors and people with disabilities maintain their independence? Join us to grocery shop for those who are homebound.', 'Volunteer grocery shoppers receive a client’s grocery list and walk about the store finding each item.', 45.48544746379536, -122.75590896606445);
INSERT INTO `event` (`eid`, `hid`, `eventdate`, `eventname`, `eventdescription`, `eventmeetdetails`, `eventlatitude`, `eventlongitude`) VALUES(10, 1, '2017-12-31 00:00:00', 'Eco Crew at Tryon Creek', 'Join a long tradition of community lead park stewardship', 'Volunteer tasks alternate between trail maintenance and invasive plant removal (like mulching, brush clearing, and pulling ivy.) ', 45.436116, -122.676759);
# 10 records

#
# Data for table 'host'
#

INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(1, 'Willamette River Keepers', 'cleanrivers@gmail.com');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(2, 'Red Cross Portland', 'events@redcross.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(3, 'Sisters of the Road', 'kitchen@sistersoftheroad.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(4, 'Portland Youth Soccer', 'kickit@portlandyouth.net');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(5, 'Alberta Neighborhood Association', 'goodneighbors@alberta.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(6, 'Potluck in the Park', 'potlucks@inpdx.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(7, 'Oregon Food Bank', 'pantry@feedoregon.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(8, 'Boy Scouts', 'troop45@scouts.or.us');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(9, 'Store to Door', 'shop@forseniors.org');
INSERT INTO `host` (`hid`, `hostorg`, `email`) VALUES(10, 'Childrens Book Bank', 'books@childrensbank.org');
# 10 records
#
# Data for table 'category'
#

INSERT INTO `category` (`categoryname`) VALUES ('Environmental');
INSERT INTO `category` (`categoryname`) VALUES ('Relief - disaster');
INSERT INTO `category` (`categoryname`) VALUES ('Relief - hunger');
INSERT INTO `category` (`categoryname`) VALUES ('Sports - youth');
INSERT INTO `category` (`categoryname`) VALUES ('Community');
# 5 records

#
# Data for table 'skill'
#

INSERT INTO `skill` (`skillname`, `skilldescription`) VALUES ('Painting - general', 'Be able to wield a brush on uncomplicated tasks and not make a giant mess');
INSERT INTO `skill` (`skillname`, `skilldescription`) VALUES ('Painting - interiors', 'Ability to prep, mask and paint interior projects including cabinetry and trim');
INSERT INTO `skill` (`skillname`, `skilldescription`) VALUES ('Carpentry - structural', 'Framing and structural construction execution');
INSERT INTO `skill` (`skillname`, `skilldescription`) VALUES ('Carpentry - joinery', 'Complex joinery requried for cabinetry, furniture-making or other');
# 4 records

#
# Data for table 'volunteer'
#

INSERT INTO `volunteer` (`firstname`, `lastname`, `email`, `latitude`, `longitude`, `usertype`) VALUES ('Fred', 'Flintstone', 'fred@rockville.net', 45.64514324557451, -122.65740752220154, 'volunteer');
INSERT INTO `volunteer` (`firstname`, `lastname`, `email`, `latitude`, `longitude`, `usertype`) VALUES ('Donald', 'Duck', 'donald@easystreet.com', 46.12567886977839, -122.93576717376708, 'volunteer');
#
# 2 records

#
# Data for table `volunteer_skill`
#

INSERT INTO `volunteer_skill` (`vid`, `sid`) VALUES
(1, 1),
(1, 2);

#
# Data for tabe `volunteer_event`
#

INSERT INTO `volunteer_event` (`vid`, `eid`) VALUES
(1, 1),
(1, 2);

##########################################################
#
#  EDIT DATA (These should not be run manually)
#
##########################################################

INSERT INTO `volunteer` (`email`) VALUES (`emailInput`);
INSERT INTO `volunteer_event` (`vid`, `sid`) VALUES (`vidInput, sidInput`);
