CREATE TABLE `dbadmins` (
  `dbAdminID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ipAddress` varchar(20) NOT NULL,
  `acctCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dbAdminID`),
  UNIQUE KEY `username` (`username`)
);