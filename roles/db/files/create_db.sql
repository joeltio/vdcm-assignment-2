/****** Create Movie Database Script ******/
CREATE DATABASE IF NOT EXISTS DataGreenDB;

/****** Create Movie Table Script ******/

USE DataGreenDB;

/****** Object: Table [dbo].[Employee] Script Date: 1/15/2021 9:58:41 AM ******/
-- The following statement has been commented out because MySql has ANSI_NULLS
-- always on. You cannot turn it off.
-- SET ANSI_NULLS ON

SET sql_mode='ANSI_QUOTES';

CREATE TABLE IF NOT EXISTS `Employee` (
    `EmployeeID`  INT             NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `FullName`    NVARCHAR(60)    NOT NULL,
    `Age`         INT             NOT NULL,
    `Address`     NVARCHAR(21845) NULL,
    `Salary`      REAL            NOT NULL,
    `Description` NVARCHAR(21845) NULL
);

/****** Add records to Employee Table Script ******/
-- This has been modified for idempotence
INSERT INTO `Employee` (`EmployeeID`, `FullName`, `Age`, `Address`, `Salary`, `Description`)
    SELECT * FROM (SELECT 1, N'Tester Lee', 50, N'123 Clementi Road', 2000, N'Ha ha ') AS tmp
    WHERE NOT EXISTS (
        SELECT `EmployeeID` FROM `Employee` WHERE `EmployeeID` = 1
    ) LIMIT 1;
