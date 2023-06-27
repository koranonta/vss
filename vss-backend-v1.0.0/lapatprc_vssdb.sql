-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 25, 2023 at 02:13 PM
-- Server version: 8.0.32
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lapatprc_vssdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddaddress` (`pEmployeeId` INT, `pAddress` VARCHAR(100), `pSubDistrict` VARCHAR(100), `pDistrict` VARCHAR(100), `pStreet` VARCHAR(255), `pCity` VARCHAR(100), `pProvince` VARCHAR(100), `pCountry` VARCHAR(100), `pPostCode` VARCHAR(20), `pLoginId` INT, OUT `oAddressId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Addresses (EmployeeId, Address, SubDistrict, District, Street, City, Province, Country, PostCode, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeId, pAddress, pSubDistrict, pDistrict, pStreet, pCity, pProvince, pCountry, pPostCode, Now(), Now(), pLoginId, pLoginId);
  SET oAddressId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddDeduction` (`pDeductionTypeId` INT, `pDeductionName` VARCHAR(100), `pDeductionThaiName` VARCHAR(100), `pLoginId` INT, OUT `oDeductionId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Deductions (DeductionTypeId, DeductionName, DeductionThaiName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionTypeId, pDeductionName, pDeductionThaiName, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddDeductionItem` (`pDeductionId` INT, `pPropertyTypeId` INT, `pLoginId` INT, OUT `oDeductionItemId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO DeductionItems (DeductionId, PropertyTypeId, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionId, pPropertyTypeId, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionItemId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddemployee` (`pEmployeeTypeId` INT, `pAccountId` VARCHAR(50), `pGenderId` INT, `pFirstName` VARCHAR(50), `pLastName` VARCHAR(50), `pIdentificationCardId` VARCHAR(50), `pBirthDate` DATE, `pJoinDate` DATE, `pImage` VARCHAR(100), `pSalary` FLOAT, `pPositionSalary` FLOAT, `pLoginId` INT, OUT `oEmployeeId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Employees (EmployeeTypeId, AccountId, GenderId, FirstName, LastName, IdentificationCardId, BirthDate, JoinDate, Image, Salary, PositionSalary, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeTypeId, pAccountId, pGenderId, pFirstName, pLastName, pIdentificationCardId, pBirthDate, pJoinDate, pImage, pSalary, pPositionSalary, Now(), Now(), pLoginId, pLoginId);
  SET oEmployeeId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddPayrollRun` (`pPayrollRunDate` DATETIME, `pLoginId` INT, OUT `oPayrollRunId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PayrollRuns (PayrollRunDate, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollRunDate, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollRunId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddPayrollTransaction` (`pPayRollRunId` INT, `pEmployeeId` INT, `pDeductionId` INT, `pLoginId` INT, OUT `oPayrollTransactionId` INT)   BEGIN  
  DECLARE transid INT;
  SET pLoginId = IFNULL(pLoginId, -1);
  
  SELECT PayrollTransactionId INTO oPayrollTransactionId
    FROM PayrollTransactions
   WHERE PayrollRunId = pPayrollRunId
     AND EmployeeId   = pEmployeeId
     AND DeductionId  = pDeductionId
     AND DateDeleted IS NULL;
     
  IF ISNULL(oPayrollTransactionId) THEN
    INSERT INTO PayrollTransactions (PayRollRunId, EmployeeId, DeductionId, DateCreated, DateModified, CreatedBy, ModifiedBy)
      VALUES(pPayRollRunId, pEmployeeId, pDeductionId, Now(), Now(), pLoginId, pLoginId);
    SET oPayrollTransactionId = LAST_INSERT_ID();
  END IF;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddPayrollTransactionItem` (`pPayrollTransactionId` INT, `pPropertyTypeId` INT, `pAmount` FLOAT, `pLoginId` INT, OUT `oPayrollTransactionItemId` INT)   BEGIN  
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId
     AND PropertyTypeId       = pPropertyTypeId;

  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PayrollTransactionItems (PayrollTransactionId, PropertyTypeId, Amount, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollTransactionId, pPropertyTypeId, pAmount, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionItemId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddPropertyType` (`pPropertyTypeGroupId` INT, `pPropertyTypeName` VARCHAR(100), `pPropertyTypeThaiName` VARCHAR(100), `pAlias` VARCHAR(100), `pAllowableValues` VARCHAR(100), `pLoginId` INT, OUT `oPropertyTypeId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PropertyTypes (PropertyTypeGroupId, PropertyTypeName, PropertyTypeThaiName, Alias, AllowableValues, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPropertyTypeGroupId, pPropertyTypeName, pPropertyTypeThaiName, pAlias, pAllowableValues, Now(), Now(), pLoginId, pLoginId);
  SET oPropertyTypeId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddPropertyTypeGroup` (`pPropertyTypeGroupName` VARCHAR(100), `pPropertyTypeGroupThaiName` VARCHAR(100), `pLoginId` INT, OUT `oPropertyTypeGroupId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PropertyTypeGroups (PropertyTypeGroupName, PropertyTypeGroupThaiName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPropertyTypeGroupName, pPropertyTypeGroupThaiName, Now(), Now(), pLoginId, pLoginId);
  SET oPropertyTypeGroupId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddRefTable` (`pRefTypeKind` VARCHAR(10), `pRefTypeName` VARCHAR(100), `pLoginId` INT, OUT `oRefId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO RefTable (RefTypeKind, RefTypeName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pRefTypeKind, pRefTypeName, Now(), Now(), pLoginId, pLoginId);
  SET oRefId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spAddUser` (`pName` VARCHAR(100), `pPassword` VARCHAR(255), `pEmail` VARCHAR(100), `pPhone` VARCHAR(100), `pRoleId` INT, `pImage` VARCHAR(100), `pLoginId` INT, OUT `oUserId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Users (Name, Password, Email, Phone, RoleId, Image, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pName, pPassword, pEmail, pPhone, pRoleId, pImage, Now(), Now(), pLoginId, pLoginId);
  SET oUserId = LAST_INSERT_ID();
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spChangeUserPassword` (`pUserId` INT, `pNewPassword` VARCHAR(255), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET Password          = pNewPassword
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE UserId = pUserId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeleteAddress` (`pEmplyeeId` INT, `pLoginId` INT)   BEGIN
  UPDATE Addresses
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE EmployeeId = pEmplyeeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeleteDeduction` (`pDeductionId` INT)   BEGIN
  DELETE FROM Deductions WHERE DeductionId = pDeductionId;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeleteDeductionItem` (`pDeductionItemId` INT)   BEGIN
  DELETE FROM DeductionItems WHERE DeductionItemId = pDeductionItemId;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeleteEmployee` (`pEmployeeId` INT, `pLoginId` INT)   BEGIN
  UPDATE Employees
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE EmployeeId = pEmployeeId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePayrollRun` (`pPayrollRunId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollRuns
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollRunId = pPayrollRunId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePayrollTransaction` (`pPayrollTransactionId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollTransactions
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollTransactionId = pPayrollTransactionId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePayrollTransactionItem` (`pPayrollTransactionItemId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollTransactionItems
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePayrollTransactionItemsByRef` (`pPayrollTransactionId` INT)   BEGIN
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePropertyType` (`pPropertyTypeId` INT)   BEGIN
  DELETE FROM PropertyTypes WHERE PropertyTypeId = pPropertyTypeId;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeletePropertyTypeGroup` (`pPropertyTypeGroupId` INT)   BEGIN
  DELETE FROM PropertyTypeGroups WHERE PropertyTypeGroupId = pPropertyTypeGroupId;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spDeleteuser` (`pUserId` INT, `pLoginId` INT)   BEGIN
  UPDATE Users
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE UserId = pUserId;     
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetAddresses` (`pAddressId` INT)   BEGIN
  SELECT AddressId      as addressid
        ,EmployeeId     as employeeid
        ,Address        as address
        ,SubDistrict    as subdistrict
        ,District       as district
        ,Street         as street
        ,City           as city
        ,Province       as province
        ,Country        as country
        ,PostCode       as postcode
    FROM Addresses
   WHERE DateDeleted IS NULL
     AND (AddressId = pAddressId OR IF( pAddressId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetAddressesByEmployeeId` (`pEmployeeId` INT)   BEGIN
  SELECT AddressId      as addressid
        ,EmployeeId     as employeeid
        ,Address        as address
        ,SubDistrict    as subdistrict
        ,District       as district
        ,Street         as street
        ,City           as city
        ,Province       as province
        ,Country        as country
        ,PostCode       as postcode
    FROM Addresses
   WHERE DateDeleted IS NULL
     AND (EmployeeId = pEmployeeId);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetDeductionById` (`pDeductionId` INT)   BEGIN
  SELECT DeductionId            as deductionid
        ,DeductionTypeId        as deductiontypeid
        ,DeductionName          as deductionname
        ,DeductionThaiName      as deductionthainame
    FROM Deductions
   WHERE DeductionId = pDeductionId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetDeductionItemById` (`pDeductionItemId` INT)   BEGIN
  SELECT DeductionItemId      as deductionitemid
        ,DeductionId          as deductionid
        ,PropertyTypeId       as propertytypeid
    FROM DeductionItems
   WHERE DeductionItemId = pDeductionItemId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetDeductionItems` (`pDeductionItemId` INT)   BEGIN
  SELECT DeductionItemId      as deductionitemid
        ,DeductionId          as deductionid
        ,PropertyTypeId       as propertytypeid
    FROM DeductionItems
   WHERE DateDeleted IS NULL
     AND (DeductionItemId = pDeductionItemId OR IF( pDeductionItemId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetDeductionRules` (`pDeductionId` INT)   BEGIN
  SELECT dh.DeductionId          as deductionid
        ,dh.DeductionName        as deductionname
        ,dh.DeductionThaiName    as deductionthainame
        ,di.DeductionItemId      as deductionitemid
        ,di.PropertyTypeId       as propertytypeid
        ,pt.PropertyTypeGroupId  as propertytypegroupid
        ,pt.PropertyTypeName     as propertytypename
        ,pt.PropertyTypeThaiName as propertytypethainame
        ,pt.Alias                as alias
        ,di.CalculationRule      as calculationrule
        ,di.MaximumValue         as maximumvalue
    FROM DeductionItems di
   INNER JOIN Deductions dh
      ON di.DeductionId = dh.DeductionId
   INNER JOIN PropertyTypes pt
      ON di.PropertyTypeId = pt.PropertyTypeId
   WHERE di.DateDeleted IS NULL
     AND dh.DateDeleted IS NULL
     AND (di.DeductionId = pDeductionId OR IF( pDeductionId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetDeductions` (`pDeductionId` INT)   BEGIN
  SELECT DeductionId            as deductionid
        ,DeductionTypeId        as deductiontypeid
        ,DeductionName          as deductionname
        ,DeductionThaiName      as deductionthainame
    FROM Deductions
   WHERE DateDeleted IS NULL
     AND (DeductionId = pDeductionId OR IF( pDeductionId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetEmployeeById` (`pEmployeeId` INT)   BEGIN
  SELECT EmployeeId                as employeeid
        ,EmployeeTypeId            as employeetypeid
        ,AccountId                 as accountid
        ,GenderId                  as genderid
        ,FirstName                 as firstname
        ,LastName                  as lastname
        ,IdentificationCardId      as identificationcardid
        ,BirthDate                 as birthdate
        ,JoinDate                  as joindate
        ,Image                     as image
        ,Salary                    as salary
        ,PositionSalary            as positionsalary
    FROM Employees
   WHERE EmployeeId = pEmployeeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetEmployees` (`pEmployeeId` INT)   BEGIN
  SELECT e.EmployeeId                as employeeid
        ,e.EmployeeTypeId            as employeetypeid
        ,empRef.PropertyTypeName     as employeetypename
        ,empRef.PropertyTypeThaiName as employeetypethainame
        ,e.AccountId                 as accountid
        ,e.GenderId                  as genderid
        ,pt.PropertyTypeName         as gendereng
        ,pt.PropertyTypeThaiName     as genderthai
        ,e.FirstName                 as firstname
        ,e.LastName                  as lastname
        ,e.IdentificationCardId      as identificationcardid
        ,e.BirthDate                 as birthdate
        ,e.JoinDate                  as joindate
        ,e.Image                     as image
        ,e.Salary                    as salary
        ,e.PositionSalary            as positionsalary
    FROM Employees e
    LEFT JOIN PropertyTypes pt
      ON e.GenderId = pt.PropertyTypeId
    LEFT JOIN PropertyTypes empRef
      ON e.EmployeeTypeId = empRef.PropertyTypeId      
   WHERE e.DateDeleted IS NULL
     AND (e.EmployeeId = pEmployeeId OR IF( pEmployeeId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetEmplyeeById` (`pEmployeeId` INT)   BEGIN
  SELECT EmployeeId                as employeeid
        ,EmployeeTypeId            as employeetypeid
        ,AccountId                 as accountid
        ,GenderId                  as genderid
        ,FirstName                 as firstname
        ,LastName                  as lastname
        ,IdentificationCardId      as identificationcardid
        ,BirthDate                 as birthdate
        ,JoinDate                  as joindate
        ,Image                     as image
        ,Salary                    as salary
        ,PositionSalary            as positionsalary
    FROM Emplyees
   WHERE EmployeeId = pEmployeeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollRunByDate` (`pRunDate` DATETIME)   BEGIN
  DECLARE runid INT;
  SELECT pr.PayrollRunId INTO runid
            FROM PayrollRuns pr
           WHERE pr.DateDeleted IS NULL
             AND pr.PayrollRunDate = pRunDate;

  IF ISNULL(runid) THEN
    CALL spAddPayrollRun (pRunDate, -1, @NewId);    
    SELECT @NewId as runid;
  ELSE
    SELECT runid;
  END IF;

END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollRunItems` (`pRunDate` DATETIME)   BEGIN
  SELECT pr.PayrollRunId              as runid
        ,pr.PayrollRunDate            as rundate 
        ,pt.PayrollTransactionId      as transactionid
        ,pt.EmployeeId                as employeeid
        ,pt.DeductionId               as deductionid
        ,pti.PayrollTransactionItemId as transactionitemid
        ,pti.PropertyTypeId           as propertytypeid
        ,pti.Amount                   as amount
    FROM PayrollRuns pr
   LEFT JOIN PayrollTransactions pt
      ON pr.PayrollRunId = pt.PayrollRunId
   LEFT JOIN PayrollTransactionItems pti
      ON pt.PayrollTransactionId = pti.PayrollTransactionItemId
  WHERE pr.DateDeleted IS NULL
    AND pt.DateDeleted IS NULL
    AND pti.DateDeleted IS NULL
    AND pr.PayrollRunDate = pRunDate;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollRuns` (`pPayrollRunId` INT)   BEGIN
  SELECT PayrollRunId      as payrollrunid
        ,PayrollRunDate    as payrollrundate
    FROM PayrollRuns
   WHERE DateDeleted IS NULL
     AND (PayrollRunId = pPayrollRunId OR IF( pPayrollRunId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollTransactionItems` (`pPayrollTransactionItemId` INT)   BEGIN
  SELECT PayrollTransactionItemId      as payrolltransactionitemid
        ,PayrollTransactionId          as payrolltransactionid
        ,PropertyTypeId                as propertytypeid
        ,Amount                        as amount
    FROM PayrollTransactionItems
   WHERE DateDeleted IS NULL
     AND (PayrollTransactionItemId = pPayrollTransactionItemId OR IF( pPayrollTransactionItemId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollTransactionItemsByRunId` (`pPayRollRunId` INT)   BEGIN
  
  SELECT prt.PayrollRunId        as payrollrunid
        ,prt.EmployeeId          as employeeid
        ,prt.DeductionId         as deductionid
        ,pti.PropertyTypeId      as propertytypeid
        ,pt.PropertyTypeName     as propertytypename
        ,pt.PropertyTypeThaiName as propertytypethainame
        ,di.CalculationRule      as calculationrule
        ,di.MaximumValue         as maximumvalue
        ,pti.Amount              as amount
    FROM PayrollTransactions prt
   INNER JOIN PayrollTransactionItems pti
      ON prt.PayrollTransactionId = pti.PayrollTransactionId
   INNER JOIN DeductionItems di
      ON prt.DeductionId = di.DeductionId 
     AND pti.PropertyTypeId = di.PropertyTypeId        
   INNER JOIN PropertyTypes pt
      ON pti.PropertyTypeId = pt.PropertyTypeId
   WHERE prt.PayrollRunId = pPayrollRunId
     AND prt.DateDeleted IS NULL
     AND pti.DateDeleted IS NULL
   ORDER BY prt.EmployeeId, di.DeductionItemId;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPayrollTransactions` (`pPayrollTransactionId` INT)   BEGIN
  SELECT PayrollTransactionId      as payrolltransactionid
        ,PayRollRunId              as payrollrunid
        ,EmployeeId                as employeeid
        ,DeductionId               as deductionid
    FROM PayrollTransactions
   WHERE DateDeleted IS NULL
     AND (PayrollTransactionId = pPayrollTransactionId OR IF( pPayrollTransactionId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypeByGroupId` (`pGroupId` INT)   BEGIN
  SELECT PropertyTypeId            as propertytypeid
        ,PropertyTypeGroupId       as propertytypegroupid
        ,PropertyTypeName          as propertytypename
        ,PropertyTypeThaiName      as propertytypethainame
        ,Alias                     as alias
        ,AllowableValues           as allowablevalues
    FROM PropertyTypes
   WHERE PropertyTypeGroupId = pGroupId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypeByGroups` (`pPropertyTypeGroupId` INT)   BEGIN
  SELECT pt.PropertyTypeGroupId       as propertytypegroupid
        ,pg.PropertyTypeGroupName     as propertytypegroupname
        ,pg.PropertyTypeGroupThaiName as propertytypeGroupthainame
        ,pt.PropertyTypeId            as propertytypeid
        ,pt.PropertyTypeName          as propertytypename
        ,pt.PropertyTypeThaiName      as propertytypethainame
        ,pt.Alias                     as alias
        ,pt.AllowableValues           as allowablevalues
    FROM PropertyTypes pt
   INNER JOIN PropertyTypeGroups pg
      ON pt.PropertyTypeGroupId = pg.PropertyTypeGroupId
   WHERE pt.DateDeleted IS NULL
     AND pg.DateDeleted IS NULL
     AND (pt.PropertyTypeGroupId = pPropertyTypeGroupId OR IF( pPropertyTypeGroupId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypeById` (`pPropertyTypeId` INT)   BEGIN
  SELECT PropertyTypeId            as propertytypeid
        ,PropertyTypeGroupId       as propertytypegroupid
        ,PropertyTypeName          as propertytypename
        ,PropertyTypeThaiName      as propertytypethainame
        ,Alias                     as alias
        ,AllowableValues           as allowablevalues
    FROM PropertyTypes
   WHERE PropertyTypeId = pPropertyTypeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypeGroupById` (`pPropertyTypeGroupId` INT)   BEGIN
  SELECT PropertyTypeGroupId            as propertytypegroupid
        ,PropertyTypeGroupName          as propertytypegroupname
        ,PropertyTypeGroupThaiName      as propertytypegroupthainame
    FROM PropertyTypeGroups
   WHERE PropertyTypeGroupId = pPropertyTypeGroupId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypeGroups` (`pPropertyTypeGroupId` INT)   BEGIN
  SELECT PropertyTypeGroupId            as propertytypegroupid
        ,PropertyTypeGroupName          as propertytypegroupname
        ,PropertyTypeGroupThaiName      as propertytypegroupthainame
    FROM PropertyTypeGroups
   WHERE DateDeleted IS NULL
     AND (PropertyTypeGroupId = pPropertyTypeGroupId OR IF( pPropertyTypeGroupId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetPropertyTypes` (`pPropertyTypeId` INT)   BEGIN
  SELECT PropertyTypeId            as propertytypeid
        ,PropertyTypeGroupId       as propertytypegroupid
        ,PropertyTypeName          as propertytypename
        ,PropertyTypeThaiName      as propertytypethainame
        ,Alias                     as alias
        ,AllowableValues           as allowablevalues
    FROM PropertyTypes
   WHERE DateDeleted IS NULL
     AND (PropertyTypeId = pPropertyTypeId OR IF( pPropertyTypeId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetUserById` (`pUserId` INT)   BEGIN
  SELECT UserId            as userid
        ,Name              as name
        ,Password          as password
        ,Email             as email
        ,Phone             as phone
        ,RoleId            as roleid
        ,Image             as image
    FROM Users
   WHERE UserId = pUserId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetUserByIdentifier` (`pIdentifier` VARCHAR(100))   BEGIN
  SELECT u.UserId           as userid
        ,u.Name             as name
        ,u.Password         as password
        ,u.Email            as email
        ,u.Phone            as phone
        ,u.Image            as image
        ,u.RoleId           as roleid
        ,p.PropertyTypeName as roletype
    FROM Users u
    LEFT JOIN PropertyTypes p
      ON u.RoleId = p.PropertyTypeId
   WHERE u.DateDeleted IS NULL
     AND (u.Name = pIdentifier OR u.Email = pIdentifier OR u.Phone = pIdentifier); 
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spGetUsers` (`pUserId` INT)   BEGIN
  SELECT u.UserId                as userid
        ,u.Name                  as name
        ,u.Password              as password
        ,u.Email                 as email
        ,u.Phone                 as phone
        ,u.RoleId                as roleid
        ,pt.PropertyTypeName     as rolename
        ,pt.PropertyTypeThaiName as rolethainame
        ,u.Image                 as image
    FROM Users u
   INNER JOIN PropertyTypes pt
      ON u.RoleId = pt.PropertyTypeId
   WHERE u.DateDeleted IS NULL
     AND (u.UserId = pUserId OR IF( pUserId <= 0, 1, 0) = 1);
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdateaddress` (`pAddressId` INT, `pEmployeeId` INT, `pAddress` VARCHAR(100), `pSubDistrict` VARCHAR(100), `pDistrict` VARCHAR(100), `pStreet` VARCHAR(255), `pCity` VARCHAR(100), `pProvince` VARCHAR(100), `pCountry` VARCHAR(100), `pPostCode` VARCHAR(20), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Addresses
     SET AddressId      = pAddressId
        ,EmployeeId     = pEmployeeId
        ,Address        = pAddress
        ,SubDistrict    = pSubDistrict
        ,District       = pDistrict
        ,Street         = pStreet
        ,City           = pCity
        ,Province       = pProvince
        ,Country        = pCountry
        ,PostCode       = pPostCode
        ,DateModified   = Now()
        ,ModifiedBy     = pLoginId
   WHERE AddressId = pAddressId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdateDeduction` (`pDeductionId` INT, `pDeductionTypeId` INT, `pDeductionName` VARCHAR(100), `pDeductionThaiName` VARCHAR(100), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Deductions
     SET DeductionId            = pDeductionId
        ,DeductionTypeId        = pDeductionTypeId
        ,DeductionName          = pDeductionName
        ,DeductionThaiName      = pDeductionThaiName
        ,DateModified           = Now()
        ,ModifiedBy             = pLoginId
   WHERE DeductionId = pDeductionId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdateDeductionItem` (`pDeductionItemId` INT, `pDeductionId` INT, `pPropertyTypeId` INT, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE DeductionItems
     SET DeductionItemId      = pDeductionItemId
        ,DeductionId          = pDeductionId
        ,PropertyTypeId       = pPropertyTypeId
        ,DateModified         = Now()
        ,ModifiedBy           = pLoginId
   WHERE DeductionItemId = pDeductionItemId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdateEmployee` (`pEmployeeId` INT, `pEmployeeTypeId` INT, `pAccountId` VARCHAR(50), `pGenderId` INT, `pFirstName` VARCHAR(50), `pLastName` VARCHAR(50), `pIdentificationCardId` VARCHAR(50), `pBirthDate` DATE, `pJoinDate` DATE, `pImage` VARCHAR(100), `pSalary` FLOAT, `pPositionSalary` FLOAT, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Employees
     SET EmployeeId                = pEmployeeId
        ,EmployeeTypeId            = pEmployeeTypeId
        ,AccountId                 = pAccountId
        ,GenderId                  = pGenderId
        ,FirstName                 = pFirstName
        ,LastName                  = pLastName
        ,IdentificationCardId      = pIdentificationCardId
        ,BirthDate                 = pBirthDate
        ,JoinDate                  = pJoinDate
        ,Image                     = pImage
        ,Salary                    = pSalary
        ,PositionSalary            = pPositionSalary
        ,DateModified              = Now()
        ,ModifiedBy                = pLoginId
   WHERE EmployeeId = pEmployeeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdatePayrollRun` (`pPayrollRunId` INT, `pPayrollRunDate` DATETIME, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PayrollRuns
     SET PayrollRunId      = pPayrollRunId
        ,PayrollRunDate    = pPayrollRunDate
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE PayrollRunId = pPayrollRunId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdatePayrollTransaction` (`pPayrollTransactionId` INT, `pPayRollRunId` INT, `pEmployeeId` INT, `pDeductionId` INT, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PayrollTransactions
     SET PayrollTransactionId      = pPayrollTransactionId
        ,PayRollRunId              = pPayRollRunId
        ,EmployeeId                = pEmployeeId
        ,DeductionId               = pDeductionId
        ,DateModified              = Now()
        ,ModifiedBy                = pLoginId
   WHERE PayrollTransactionId = pPayrollTransactionId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdatePayrollTransactionItem` (`pPayrollTransactionItemId` INT, `pPayrollTransactionId` INT, `pPropertyTypeId` INT, `pAmount` FLOAT, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PayrollTransactionItems
     SET PayrollTransactionItemId      = pPayrollTransactionItemId
        ,PayrollTransactionId          = pPayrollTransactionId
        ,PropertyTypeId                = pPropertyTypeId
        ,Amount                        = pAmount
        ,DateModified                  = Now()
        ,ModifiedBy                    = pLoginId
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdatePropertyType` (`pPropertyTypeId` INT, `pPropertyTypeGroupId` INT, `pPropertyTypeName` VARCHAR(100), `pPropertyTypeThaiName` VARCHAR(100), `pAlias` VARCHAR(100), `pAllowableValues` VARCHAR(100), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PropertyTypes
     SET PropertyTypeId            = pPropertyTypeId
        ,PropertyTypeGroupId       = pPropertyTypeGroupId
        ,PropertyTypeName          = pPropertyTypeName
        ,PropertyTypeThaiName      = pPropertyTypeThaiName
        ,Alias                     = pAlias
        ,AllowableValues           = pAllowableValues
        ,DateModified              = Now()
        ,ModifiedBy                = pLoginId
   WHERE PropertyTypeId = pPropertyTypeId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdatePropertyTypeGroup` (`pPropertyTypeGroupId` INT, `pPropertyTypeGroupName` VARCHAR(100), `pPropertyTypeGroupThaiName` VARCHAR(100), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PropertyTypeGroups
     SET PropertyTypeGroupId            = pPropertyTypeGroupId
        ,PropertyTypeGroupName          = pPropertyTypeGroupName
        ,PropertyTypeGroupThaiName      = pPropertyTypeGroupThaiName
        ,DateModified                   = Now()
        ,ModifiedBy                     = pLoginId
   WHERE PropertyTypeGroupId = pPropertyTypeGroupId
     AND DateDeleted IS NULL;
END$$

CREATE DEFINER=`lapatprc`@`localhost` PROCEDURE `spUpdateUser` (`pUserId` INT, `pName` VARCHAR(100), `pPassword` VARCHAR(255), `pEmail` VARCHAR(100), `pPhone` VARCHAR(100), `pRoleId` INT, `pImage` VARCHAR(100), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET UserId            = pUserId
        ,Name              = pName
        ,Password          = pPassword
        ,Email             = pEmail
        ,Phone             = pPhone
        ,RoleId            = pRoleId
        ,Image             = pImage
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE UserId = pUserId
     AND DateDeleted IS NULL;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Addresses`
--

CREATE TABLE `Addresses` (
  `AddressId` int NOT NULL,
  `EmployeeId` int NOT NULL,
  `Address` varchar(100) NOT NULL,
  `SubDistrict` varchar(100) DEFAULT NULL,
  `District` varchar(100) DEFAULT NULL,
  `Street` varchar(255) DEFAULT NULL,
  `City` varchar(100) NOT NULL,
  `Province` varchar(100) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `PostCode` varchar(20) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `Addresses`
--

INSERT INTO `Addresses` (`AddressId`, `EmployeeId`, `Address`, `SubDistrict`, `District`, `Street`, `City`, `Province`, `Country`, `PostCode`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 1, 'เลขที่ 99 ชั้น 2 ห้อง SB082', 'คูคต', 'ลำลูกกา', 'ถ.พหลโยธิน', 'ปทุมธานี', '', '12130', 'ประเทศไทย', '2023-06-06 12:35:57', '2023-06-06 12:35:57', NULL, -1, -1, NULL),
(2, 2, 'ลขที่ 135/99 ชั้น 2 ห้อง 211-213', 'ศรีราชา', 'ศรีราชา', 'ถ.สุขุมวิท', 'ชลบุรี', '', '20110', 'ประเทศไทย', '2023-06-06 12:35:57', '2023-06-06 12:35:57', NULL, -1, -1, NULL),
(3, 3, 'ลขที่ 7 ชั้น 3 ห้อง 3P57', 'ดินแดง', 'ดินแดง', 'ถ.รัชดาภิเษก', 'กรุงเทพมหานคร', '', '10400', 'ประเทศไทย', '2023-06-06 12:35:57', '2023-06-06 12:35:57', NULL, -1, -1, NULL),
(4, 4, '135/99 อาคารตึกคอมศรีราชาศูนย์การตึกคอม ศรีราชา ห้องเลขที่ 207-210 ชั้น 2', 'ศรีราชา', 'ศรีราชา', 'ถ.สุขุมวิท', 'ชลบุรี', '', '20110', 'ประเทศไทย', '2023-06-06 12:35:57', '2023-06-06 12:35:57', NULL, -1, -1, NULL),
(5, 5, 'เลขที่ 1090 หมู่ 12 ศูนย์การค้าเซ็นทรัลพลาซา บางนา ห้องเลขที่ 405 ชั้น 4', 'บางนา', 'บางนา', 'ถนน ศรีนครินทร์', 'กรุงเทพมหานคร', '', '10400', 'ประเทศไทย', '2023-06-06 12:35:57', '2023-06-06 12:35:57', NULL, -1, -1, NULL),
(14, 176, '75/1 Thongloh 13', 'Wattana', 'Klongtey nuea', 'Sukhumvit soi 55', 'Bangkok', 'Bangkok', 'Thailand', '10110', '2023-06-14 20:26:43', '2023-06-14 20:26:43', '2023-06-14 20:37:52', -1, -1, -1),
(12, 176, '75/1 Accapat alley 4', 'Wattana', 'Klongtey nuea', 'Sukhumvit soi 49', 'Bangkok', 'Bangkok', 'Thailand', '10110', '2023-06-14 20:25:14', '2023-06-14 20:25:14', '2023-06-14 20:37:52', -1, -1, -1),
(13, 155, '635 Carved terrace way', 'Alpha', 'Beta', 'Andromeda', 'Omega', 'Gamma', 'Prime', '80919', '2023-06-14 20:26:08', '2023-06-14 20:26:08', NULL, -1, -1, NULL),
(15, 176, '75/1 Thongloh 13', 'Wattana', 'Klongtey nuea', 'Sukhumvit soi 55', 'Bangkok', 'Bangkok', 'Thailand', '10110', '2023-06-14 20:27:04', '2023-06-14 20:27:04', '2023-06-14 20:37:52', -1, -1, -1),
(16, 151, '', '', '', '', '', '', '', '', '2023-06-14 20:28:34', '2023-06-14 20:28:34', NULL, -1, -1, NULL),
(17, 151, '', '', '', '', '', '', '', '', '2023-06-14 20:29:14', '2023-06-14 20:29:14', NULL, -1, -1, NULL),
(18, 177, '158 West cost', 'OOPS1', 'JAVA', 'Omega drive', 'DELTA', 'GAMMA', 'OMEGA', '15230', '2023-06-14 20:37:11', '2023-06-14 20:37:11', '2023-06-14 20:37:55', -1, -1, -1),
(19, 177, '158 West cost', 'OOPS1', 'JAVA', 'Omega drive', 'DELTA', 'GAMMA', 'OMEGA', '15230', '2023-06-14 20:37:29', '2023-06-14 20:37:29', '2023-06-14 20:37:55', -1, -1, -1),
(20, 177, '158 West cost', 'OOPS1', 'JAVA', 'Omega drive', 'DELTA', 'GAMMA', 'OMEGA', '15230', '2023-06-14 20:37:38', '2023-06-14 20:37:38', '2023-06-14 20:37:55', -1, -1, -1),
(21, 1, 'เลขที่ 99 ชั้น 2 ห้อง SB082', 'คูคต', 'ลำลูกกา', 'ถ.พหลโยธิน', 'ปทุมธานี', '', 'ประเทศไทย', '12130', '2023-06-14 20:50:38', '2023-06-14 20:50:38', NULL, -1, -1, NULL),
(22, 2, 'ลขที่ 135/99 ชั้น 2 ห้อง 211-213', 'ศรีราชา', 'ศรีราชา', 'ถ.สุขุมวิท', 'ชลบุรี', '', 'ประเทศไทย', '20110', '2023-06-14 20:50:47', '2023-06-14 20:50:47', NULL, -1, -1, NULL),
(23, 3, 'ลขที่ 7 ชั้น 3 ห้อง 3P57', 'ดินแดง', 'ดินแดง', 'ถ.รัชดาภิเษก', 'กรุงเทพมหานคร', '', 'ประเทศไทย', '10400', '2023-06-14 20:50:55', '2023-06-14 20:50:55', NULL, -1, -1, NULL),
(24, 4, '135/99 อาคารตึกคอมศรีราชาศูนย์การตึกคอม ศรีราชา ห้องเลขที่ 207-210 ชั้น 2', 'ศรีราชา', 'ศรีราชา', 'ถ.สุขุมวิท', 'ชลบุรี', '', 'ประเทศไทย', '20110', '2023-06-14 20:51:05', '2023-06-14 20:51:05', NULL, -1, -1, NULL),
(25, 5, 'เลขที่ 1090 หมู่ 12 ศูนย์การค้าเซ็นทรัลพลาซา บางนา ห้องเลขที่ 405 ชั้น 4', 'บางนา', 'บางนา', 'ถนน ศรีนครินทร์', 'กรุงเทพมหานคร', '', 'ประเทศไทย', '10401', '2023-06-14 20:51:13', '2023-06-14 20:51:13', NULL, -1, -1, NULL),
(26, 178, '81', '', 'คูหาสวรรค์', 'คูหาสวรรค์', 'สงขลา', 'เมือง', 'ไทย', '93000', '2023-06-15 09:34:31', '2023-06-15 09:34:31', '2023-06-15 09:38:04', -1, -1, -1),
(27, 179, '81', 'undefined', 'undefined', 'คูหาสวรรค์', 'สงขลา', 'เมือง', 'ไทย', '93000', '2023-06-15 09:36:02', '2023-06-15 09:36:02', '2023-06-15 09:38:15', -1, -1, -1),
(28, 179, '81', 'undefined', 'undefined', 'คูหาสวรรค์', 'สงขลา', 'เมือง', 'ไทย', '93000', '2023-06-15 09:36:13', '2023-06-15 09:36:13', '2023-06-15 09:38:15', -1, -1, -1),
(29, 180, 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', 'undefined', '2023-06-18 10:22:16', '2023-06-18 10:22:16', NULL, -1, -1, NULL),
(30, 10, '', '', '', '', '', '', '', '', '2023-06-18 10:22:53', '2023-06-18 10:22:53', NULL, -1, -1, NULL),
(31, 1, 'เลขที่ 99 ชั้น 2 ห้อง SB082', 'คูคต', 'ลำลูกกา', 'ถ.พหลโยธิน', 'ปทุมธานี', '', '12130', 'ประเทศไทย', '2023-06-21 11:13:39', '2023-06-21 11:13:39', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `DeductionItems`
--

CREATE TABLE `DeductionItems` (
  `DeductionItemId` int NOT NULL,
  `DeductionId` int NOT NULL,
  `PropertyTypeId` int NOT NULL,
  `CalculationRule` varchar(100) DEFAULT NULL,
  `MaximumValue` float DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `DeductionItems`
--

INSERT INTO `DeductionItems` (`DeductionItemId`, `DeductionId`, `PropertyTypeId`, `CalculationRule`, `MaximumValue`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 1, 11, '3%', 1200, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(2, 1, 12, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(3, 1, 13, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(4, 1, 14, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(5, 1, 15, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(6, 1, 16, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(7, 1, 17, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(8, 1, 18, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(9, 2, 19, '5%', 750, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(10, 2, 18, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(11, 2, 17, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(12, 2, 20, NULL, NULL, '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Deductions`
--

CREATE TABLE `Deductions` (
  `DeductionId` int NOT NULL,
  `DeductionTypeId` int NOT NULL,
  `DeductionName` varchar(100) NOT NULL,
  `DeductionThaiName` varchar(100) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `Deductions`
--

INSERT INTO `Deductions` (`DeductionId`, `DeductionTypeId`, `DeductionName`, `DeductionThaiName`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 3, 'Teacher salary deduction rules', 'กฏหักเงินเดือนครูบรรจุ', '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL),
(2, 4, 'Staff salary deduction rules', 'กฏหักเงินเดือนลูกจ้าง', '2023-06-04 08:52:37', '2023-06-04 08:52:37', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Employees`
--

CREATE TABLE `Employees` (
  `EmployeeId` int NOT NULL,
  `EmployeeTypeId` int NOT NULL,
  `AccountId` varchar(50) NOT NULL,
  `GenderId` int NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `IdentificationCardId` varchar(50) CHARACTER SET tis620 COLLATE tis620_thai_ci NOT NULL,
  `BirthDate` date NOT NULL,
  `JoinDate` date NOT NULL,
  `Image` varchar(100) DEFAULT NULL,
  `Salary` float NOT NULL DEFAULT '0',
  `PositionSalary` float NOT NULL DEFAULT '0',
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `Employees`
--

INSERT INTO `Employees` (`EmployeeId`, `EmployeeTypeId`, `AccountId`, `GenderId`, `FirstName`, `LastName`, `IdentificationCardId`, `BirthDate`, `JoinDate`, `Image`, `Salary`, `PositionSalary`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 4, '908-3-00245-4', 10, 'ชินภัทร์', 'ปล้องไหม', '123-45548-100', '1983-04-25', '2011-05-26', '', 27284, 0, '2023-06-04 07:46:57', '2023-06-21 11:13:39', NULL, -1, -1, -1),
(2, 4, '957-0-61614-8', 10, 'สุริยัณห์', 'หนูเกลี้ยง', '555-10-3325', '1981-11-11', '2015-11-15', '', 23778, 0, '2023-06-04 07:46:57', '2023-06-14 20:50:47', NULL, -1, -1, NULL),
(3, 4, '957-0-60950-8', 8, 'ธัญญา', 'ลาสอาด', '1120-11242', '1976-02-12', '2014-01-27', '', 29863, 0, '2023-06-04 07:46:57', '2023-06-14 20:50:55', NULL, -1, -1, NULL),
(4, 4, '908-1-19059-8', 9, 'อำนวย', 'เรืองศรี', '', '1976-05-25', '2014-11-03', '', 19121, 0, '2023-06-04 07:46:57', '2023-06-14 20:51:05', NULL, -1, -1, NULL),
(5, 4, '908-3-23594-7', 10, 'โกวิทย์', 'นิ่มมา', '', '1975-11-17', '2014-04-11', '', 14779, 0, '2023-06-04 07:46:57', '2023-06-14 20:51:13', NULL, -1, -1, NULL),
(6, 4, '908-1-23667-9', 8, 'สำรวย', 'วงศ์มุณีวร', '', '1971-03-27', '2013-06-09', '', 29134, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(7, 4, '913-1-07904-0', 9, 'ชูสิน', 'อ่อนคง', '', '1981-02-05', '2011-06-15', '', 28922, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(8, 4, '986-8-00374-1', 9, 'ศศิธร', 'จันทร์ดำ', '', '1977-01-07', '2013-01-05', '', 29882, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(9, 4, '722-0-53570-8', 10, 'นพดล', 'ตุดบัว', '', '1982-07-24', '2016-02-18', '', 16059, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(10, 4, '957-0-18000-5', 9, 'ณัฏฐณิภรณ์', 'แต้มช่วย', '', '1972-07-25', '2018-11-24', '', 17892, 0, '2023-06-04 07:46:57', '2023-06-18 10:22:53', NULL, -1, -1, NULL),
(11, 4, '957-0-50134-0', 10, 'วรรณธัช', 'ขุนกลางวัง', '', '1973-01-22', '2012-01-22', '', 24817, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(12, 4, '957-0-62366-7', 8, 'สุภาภรณ์', 'เม่าน้ำพราย', '', '1979-08-15', '2017-03-13', '', 14076, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(13, 4, '908-0-95762-3', 8, 'ชญานิศ', 'ปล้องไหม', '', '1983-06-09', '2014-09-24', '', 16915, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(14, 4, '957-0-62449-3', 8, 'สุมลรัตน์', 'นกนะ', '', '1973-01-17', '2010-06-20', '', 17151, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(15, 4, '908-3-24904-2', 10, 'กิตติศํกดิ์', 'โรจนรัตน์', '', '1984-01-22', '2018-02-15', '', 21065, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(16, 4, '957-0-49494-8', 8, 'กรรณิการ์', 'สร้อยสุวรรณ', '', '1978-09-13', '2011-10-09', '', 19005, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(17, 4, '902-0-68807-3', 10, 'ณัฐพล', 'ชูไข่หนู', '', '1976-10-13', '2015-02-23', '', 25030, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(18, 4, '957-0-44952-7', 8, 'สุธาธาร', 'หนูมา', '', '1980-02-27', '2011-03-06', '', 13218, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(19, 4, '868-0-18994-4', 8, 'สุพัตรา', 'จงรัตน์', '', '1975-07-13', '2017-11-17', '', 20388, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(20, 4, '908-3-27205-2', 10, 'ชนะ', 'ชูบัวขาว', '', '1973-06-22', '2014-04-06', '', 21732, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(21, 4, '989-8-92746-1', 8, 'อมราพร', 'กัลยาศิริ', '', '1977-05-08', '2012-08-03', '', 28724, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(22, 4, '763-0-65525-8', 10, 'ภูริทัต', 'สงขาว', '', '1979-07-06', '2014-07-04', '', 25717, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(23, 4, '957-0-67514-4', 8, 'พัทธ์ธีรา', 'ไกรราญ', '', '1980-04-01', '2013-09-16', '', 19622, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(24, 4, '908-3-13679-5', 8, 'ณัฐนาถ', 'สงแสง', '', '1976-10-12', '2013-11-13', '', 14403, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(25, 4, '662-5-89834-1', 8, 'สิริมาย', 'ฉ้งเม้ง', '', '1978-09-07', '2015-05-14', '', 19697, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(26, 4, '908-3-13059-2', 8, 'สุชาดา', 'ขันหะ', '', '1972-04-12', '2017-08-22', '', 30484, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(27, 4, '957-0-67512-8', 8, 'อรวรรณ', 'เพชรแก้ว', '', '1978-03-20', '2014-09-01', '', 29035, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(28, 4, '957-0-67504-7', 8, 'เพ็ญพิชชา', 'คงโคก', '', '1973-03-04', '2012-06-20', '', 20130, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(29, 4, '932-3-53881-7', 10, 'เจษฎา', 'ศรีทวี', '', '1977-08-10', '2016-10-15', '', 20462, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(30, 4, '957-0-44152-6', 8, 'สุธินี', 'สังข์เมียน', '', '1983-10-13', '2019-04-09', '', 29497, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(31, 4, '989-9-51739-9', 8, 'ปภัสสร', 'เสาหัด', '', '1971-01-02', '2014-01-05', '', 27708, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(32, 4, '957-0-67711-2', 10, 'สมพงศ์', 'แพ่งเมือง', '', '1978-02-22', '2018-05-03', '', 15274, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(33, 4, '957-0-67712-0', 10, 'ณัฎฐคุณ', 'ปายสาร', '', '1976-04-06', '2011-01-19', '', 21586, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(34, 4, '908-3-03023-7', 8, 'กอบกาญจน์', 'หัสไทยทิพย์', '', '1974-04-22', '2015-01-04', '', 26634, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(35, 4, '921-0-35889-9', 10, 'อนุวัฒน์', 'จันทร์ดอน', '', '1979-06-05', '2013-08-04', '', 30833, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(36, 4, '957-0-63277-1', 10, 'วราเทพ', 'หนูบูรณ์', '', '1975-10-02', '2016-10-06', '', 20557, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(37, 3, '908-0-56414-1', 8, 'อาลิสา', 'อับดุลลาห์', '', '1980-05-10', '2017-09-25', '', 18831, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', '2023-06-19 13:40:43', -1, -1, -1),
(38, 3, '908-1-61130-5', 9, 'นิภา', 'ทองสุข', '', '1975-08-04', '2017-08-25', '', 13130, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(39, 3, '908-0-71985-4', 9, 'วรรณา', 'พรหมแก้ว', '', '1975-04-26', '2017-11-01', '', 18469, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(40, 3, '908-0-77995-4', 8, 'สิริกร', 'ศรีโยธา', '', '1982-01-14', '2018-11-27', '', 20943, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(41, 3, '908-1-92244-0', 9, 'ณาตยา', 'ไชยศรียา', '', '1971-01-12', '2014-03-22', '', 45000, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(42, 3, '908-0-45350-1', 9, 'จรรยา', 'รักสองหมื่น', '', '1975-08-26', '2014-07-04', 'นางจรรยา รักสองหมื่น.png', 42000, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(43, 3, '908-0-61183-2', 8, 'พรรณี', 'สิงหมงคล', '', '1983-07-08', '2018-06-20', '', 13092, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(44, 3, '908-1-82327-2', 9, 'วรรณา', 'เพชรกาศ', '', '1981-11-13', '2013-02-09', '', 20387, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(45, 3, '908-0-54603-8', 10, 'จตุพล', 'บุญปล้อง', '', '1971-04-19', '2019-05-04', '', 17118, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(46, 3, '908-0-32172-9', 8, 'ศศิกาญจน์', 'จันทร์ดำ', '', '1983-02-23', '2018-06-09', '', 19495, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(47, 3, '908-0-28757-1', 10, 'ทวี', 'ดำเอี่ยม', '', '1976-04-19', '2011-06-16', '', 25927, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(48, 3, '908-0-76788-3', 9, 'อภิญญา', 'วรรณรัตน์', '', '1976-06-09', '2019-03-19', '', 21207, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(49, 3, '908-0-76786-7', 9, 'กัลยา', 'วุ่นบุญชู', '', '1981-10-01', '2010-02-27', '', 25789, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(50, 3, '908-0-72630-3', 10, 'คมกริช', 'ด้วงทอง', '', '1981-09-19', '2013-09-15', '', 24308, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(51, 3, '908-0-65754-9', 9, 'อมราวดี', 'เพชรรักษ์', '', '1976-01-12', '2014-02-17', '', 24363, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(52, 3, '908-0-28351-7', 8, 'วัลภา', 'หวังสวัสดิ์', '', '1970-09-25', '2019-02-16', '', 19987, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(53, 3, '908-0-28367-3', 9, 'นงนภัส', 'ไกรดิษฐ์', '', '1983-01-13', '2016-07-08', '', 29663, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(54, 3, '908-0-72643-5', 9, 'ถมยา', 'อัณฑยานนท์', '', '1979-09-01', '2018-07-01', '', 18108, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(55, 3, '908-0-91302-2', 10, 'ศักรินทร์', 'บุญปล้อง', '', '1984-05-03', '2012-09-17', '', 21534, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(56, 3, '908-1-55818-8', 9, 'ยวนตา', 'เกตุเรน', '', '1978-05-12', '2011-02-25', '', 21231, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(57, 3, '908-0-92851-8', 10, 'สมยศ', 'ทองเอียด', '', '1976-05-15', '2013-06-19', '', 28499, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(58, 3, '908-0-94759-8', 10, 'ปิยพงษ์', 'เทพขาว', '', '1972-02-20', '2013-10-19', '', 31883, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(59, 3, '908-0-95978-2', 8, 'ทิพย์อาภา', 'เพชรตีบ', '', '1978-02-13', '2017-04-14', '', 13317, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(60, 3, '908-0-95889-1', 9, 'อรอุรา', 'รักษ์จำรูญ', '', '1977-11-05', '2014-01-26', '', 14449, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(61, 3, '908-0-96515-4', 9, 'หยาดพิรุณ', 'บุญปล้อง', '', '1972-11-04', '2014-03-20', '', 13516, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(62, 3, '908-3-00747-2', 10, 'ธนากรณ์', 'คงฤทธิ์', '', '1970-07-05', '2016-06-16', '', 19499, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(63, 3, '908-3-04639-7', 8, 'รัชนก', 'สันซัง', '', '1973-08-05', '2016-03-14', '', 24918, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(64, 3, '908-3-05742-9', 8, 'อัครวรา', 'สุวรรณจินดา', '', '1971-03-13', '2012-11-16', '', 13087, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(65, 3, '908-0-74308-9', 9, 'ยุพิน', 'บุญสนิท', '', '1976-05-03', '2019-11-08', '', 18723, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(66, 3, '908-0-54197-4', 8, 'ญาณกาญจน์', 'แสงขำ', '', '1978-06-05', '2015-03-19', '', 31907, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(67, 3, '908-3-09109-0', 8, 'อมลวรรณ', 'นวลละออง', '', '1977-05-01', '2011-07-16', '', 13548, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(68, 3, '908-3-09922-9', 9, 'พัฒน์วดี', 'พลายหนู', '', '1984-07-06', '2014-09-07', '', 15621, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(69, 3, '908-3-09921-0', 8, 'นันทวัน', 'พันธุกาล', '', '1981-08-23', '2016-11-15', '', 31353, 0, '2023-06-04 07:46:57', '2023-06-04 07:46:57', NULL, -1, -1, NULL),
(70, 3, '957-0-44243-3', 8, 'พิชารัฐ', 'แกล้วทนงค์', '', '1980-09-08', '2019-06-19', '', 15756, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(71, 3, '908-3-11758-8', 8, 'ศศิธร', 'มุสิกะ', '', '1975-08-05', '2012-05-20', '', 21082, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(72, 3, '678-1-78951-1', 8, 'มลฤดี', 'ศีลบุตร', '', '1972-06-18', '2019-09-19', '', 18270, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(73, 3, '678-2-41698-0', 8, 'ศกลวรรณ', 'แสงศรี', '', '1974-07-13', '2017-01-01', '', 29165, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(74, 3, '957-0-47370-3', 9, 'สุชาดา', 'คงวุ่น', '', '1973-04-24', '2014-11-24', '', 18038, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(75, 3, '957-0-20529-6', 9, 'นิลญา', 'แก้วกลม', '', '1972-02-25', '2011-02-09', '', 23992, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(76, 3, '981-1-83450-4', 10, 'กษิดิศ', 'ศักดาณรงค์', '', '1978-01-06', '2010-10-12', '', 31924, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(77, 3, '908-3-12033-3', 10, 'วชญธร', 'จันทร์เมือง', '', '1976-02-09', '2011-05-25', '', 15491, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(78, 3, '957-0-10677-8', 9, 'จุฑารัตน์', 'สายชล', '', '1979-11-07', '2014-11-08', '', 14912, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(79, 3, '908-3-13849-6', 9, 'เสาวณี', 'อินฉ่ำ', '', '1977-11-08', '2014-08-27', '', 21648, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(80, 3, '908-0-71461-5', 8, 'สุนันทา', 'สงคราม', '', '1983-07-08', '2011-11-14', '', 19154, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(81, 3, '957-0-49845-5', 8, 'นฤมล', 'ทับไซย์', '', '1971-02-02', '2010-01-14', '', 25205, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(82, 3, '908-3-12964-0', 8, 'นีรนุช', 'ศรีทัยแก้ว', '', '1970-09-14', '2019-03-08', '', 30751, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(83, 3, '957-0-47086-0', 8, 'ณัฐณิชา', 'เมืองศรี', '', '1984-06-26', '2012-09-15', '', 28529, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(84, 3, '908-3-15106-9', 8, 'วารุณี', 'วงศ์สิงห์', '', '1984-08-12', '2014-06-17', '', 20823, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(85, 3, '678-5-65552-8', 10, 'วรพล', 'เรืองทอง', '', '1975-01-01', '2013-02-06', '', 29678, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(86, 3, '957-0-50115-4', 8, 'รัชนี', 'แสงมิ่ง', '', '1974-04-03', '2014-11-09', '', 27465, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(87, 3, '908-0-25103-8', 8, 'สาวิตรี', 'ชูสังข์', '', '1981-07-15', '2016-01-21', '', 29356, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(88, 3, '908-0-59285-4', 9, 'นวรัตน์', 'คงฤทธิ์', '', '1983-01-20', '2013-06-09', '', 29606, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(89, 3, '957-0-53459-1', 8, 'วัชราภรณ์', 'ช่วยบำรุง', '', '1983-06-11', '2010-05-18', '', 22582, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(90, 3, '957-0-53612-8', 8, 'ขนิษฐา', 'หนูรอด', '', '1978-05-04', '2019-01-24', '', 29468, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(91, 3, '908-0-54706-9', 9, 'ณัฐกานต์', 'จันทร์เอียด', '', '1973-11-21', '2012-08-09', '', 27638, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(92, 3, '908-0-91721-4', 9, 'ศศิวิมล', 'ศิริอนันต์', '', '1975-09-26', '2013-11-18', '', 23334, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(93, 3, '908-3-13391-5', 8, 'จุไรพร', 'บัวทอง', '', '1979-01-04', '2011-08-20', '', 26562, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(94, 3, '957-0-47753-9', 8, 'กนกวรรณ', 'เกตุนิ่ม', '', '1980-05-21', '2018-08-10', '', 15627, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(95, 3, '679-7-32995-7', 8, 'ธารนภา', 'พุฒสม', '', '1979-06-11', '2017-02-03', '', 25254, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(96, 3, '921-0-09801-3', 8, 'นภาวี', 'ทองเอม', '', '1970-08-05', '2011-01-11', '', 24686, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(97, 3, '679-8-12829-7', 10, 'เอกพงศ์', 'พุฒจอก', '', '1982-10-25', '2011-06-16', '', 27639, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(98, 3, '957-0-53422-2', 9, 'พิกุล', 'บุญปล้อง', '', '1977-07-21', '2019-04-15', '', 13392, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(99, 3, '957-0-24614-6', 8, 'สุกัญญา', 'แก้วหนู', '', '1979-08-10', '2014-04-16', '', 20112, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(100, 3, '957-0-56051-7', 8, 'จุฑาภัคสิณี', 'จีนชาวนา', '', '1981-07-08', '2019-05-02', '', 22191, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(101, 3, '957-0-53391-9', 8, 'ปัทมวรรณ', 'กิ้มแก้ว', '', '1972-10-19', '2012-07-07', '', 14519, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(102, 3, '908-3-15685-0', 8, 'ปัณฑารีย์', 'อ่อนรักษ์', '', '1981-10-04', '2012-02-18', '', 15762, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(103, 3, '660-2-45235-5', 8, 'ธัญรดา', 'เพ็งหนู', '', '1979-08-23', '2014-01-07', '', 13582, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(104, 3, '957-0-56065-7', 10, 'วีระยุทธ', 'หนูแหลม', '', '1971-10-06', '2013-04-13', '', 21740, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(105, 3, '908-3-18030-1', 8, 'เจนจิราพร', 'ต๊ะน้ำอ่าง', '', '1977-04-21', '2014-03-27', '', 17065, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(106, 3, '908-3-19075-7', 8, 'ณฐนันทน์', 'สิงหมงคล', '', '1977-11-13', '2018-11-10', '', 29641, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(107, 3, '908-3-19063-3', 8, 'เจนจิรา', 'คงวัน', '', '1980-08-25', '2014-09-23', '', 29076, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(108, 3, '908-0-27625-1', 8, 'พัชรี', 'จีนเมือง', '', '1979-09-26', '2019-02-04', '', 23897, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(109, 3, '957-0-47129-8', 10, 'อรรถพร', 'พรหมบุญแก้ว', '', '1979-07-26', '2017-06-19', '', 19702, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(110, 3, '660-4-49312-1', 8, 'กมลวรรณ', 'แก้วกระจาย', '', '1984-05-12', '2011-03-22', '', 23735, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(111, 3, '957-0-59642-2', 8, 'สิริกุล', 'คงจร', '', '1981-01-13', '2015-04-06', '', 13976, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(112, 3, '660-5-47675-1', 8, 'ธัญญาทิพย์', 'มากคำ', '', '1972-11-04', '2017-08-03', '', 19111, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(113, 3, '921-0-35522-9', 8, 'ณัฐริกา', 'ชูใหม่', '', '1970-04-23', '2012-11-18', '', 25944, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(114, 3, '908-0-93053-9', 8, 'ปาริชาติ', 'ปานเขียว', '', '1983-02-11', '2018-10-18', '', 23055, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(115, 3, '921-0-30397-0', 8, 'วลัยลักษณ์', 'แก่นจันทร์', '', '1974-03-15', '2014-05-02', '', 14416, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(116, 3, '661-2-68497-6', 10, 'ภราดร', 'พรมเกิด', '', '1981-06-04', '2018-11-04', '', 25106, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(117, 3, '908-3-23003-1', 8, 'ซูไรด้า', 'ระเด่น', '', '1983-02-16', '2010-06-03', '', 28933, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(118, 3, '661-2-72615-6', 8, 'นารีรัตน์', 'หรุดคง', '', '1981-02-22', '2019-03-21', '', 24913, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(119, 3, '908-3-22995-5', 8, 'นัยน์สร', 'ยอมรัญจวน', '', '1982-02-12', '2019-04-14', '', 27581, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(120, 3, '908-3-22980-7', 8, 'ธณัชชา', 'เอียดสุดรักษ์', '', '1974-05-05', '2016-06-22', '', 16920, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(121, 3, '984-1-16240-7', 10, 'นลธวัช', 'เทพแก้ว', '', '1974-11-13', '2010-08-15', '', 24826, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(122, 3, '908-3-23533-5', 8, 'พรน้ำทิพย์', 'หิรัญชาติ', '', '1979-04-07', '2018-01-03', '', 15357, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(123, 3, '957-0-31601-2', 8, 'สาวิตรี', 'ราชเล็ก', '', '1976-11-20', '2016-03-03', '', 27762, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(124, 3, '983-3-74103-7', 8, 'สุดารัตน์', 'พุดปลอด', '', '1981-11-06', '2015-01-10', '', 19571, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(125, 3, '957-0-17683-0', 10, 'ปิยะพงษ์', 'สีทับ', '', '1971-03-15', '2018-05-26', '', 17713, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(126, 3, '908-3-19876-6', 8, 'อัจฉณา', 'จันทร์แป้น', '', '1974-07-27', '2017-11-07', '', 13307, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(127, 3, '957-0-56554-3', 8, 'อัจฉราวดี', 'สุขทอง', '', '1975-05-17', '2011-01-25', '', 31535, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(128, 3, '957-0-61662-8', 8, 'รัชนก', 'พุทธพิทักษ์', '', '1984-03-04', '2014-03-27', '', 24003, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(129, 3, '908-0-46939-4', 8, 'ภัทรวดี', 'ไล่กสิกรรม', '', '1972-11-26', '2010-10-14', '', 26231, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(130, 3, '487-0-42901-2', 8, 'วราภรณ์', 'อินทรบุตร', '', '1975-10-11', '2010-04-04', '', 25364, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(131, 3, '921-0-30788-7', 8, 'เมธิณี', 'เรืองแก้ว', '', '1984-04-16', '2017-06-08', '', 29416, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(132, 3, '957-0-62368-3', 8, 'ชนางรัก', 'นุ่นศรี', '', '1978-07-12', '2016-06-24', '', 24800, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(133, 3, '816-0-75993-2', 10, 'เจตริน', 'ชูหว่าง', '', '1974-10-05', '2016-10-07', '', 16932, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(134, 3, '678-2-78728-8', 8, 'ณัฐวรา', 'คล้ายแก้ว', '', '1975-02-27', '2011-05-04', '', 15271, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(135, 3, '984-8-40974-2', 8, 'สุภาวดี', 'สุขทอง', '', '1983-09-17', '2019-05-13', '', 26758, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(136, 3, '986-2-59475-6', 8, 'สุรางคนา', 'งานว่อง', '', '1977-04-16', '2016-05-17', '', 18188, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(137, 3, '957-0-62403-5', 10, 'อนาวิล', 'มากหนู', '', '1982-08-16', '2016-09-16', '', 17112, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(138, 3, '679-4-12075-5', 8, 'กิรติกา', 'ขาวเผือก', '', '1984-10-20', '2018-02-10', '', 22559, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(139, 3, '986-1-61114-2', 10, 'นรินทร์ทิพย์', 'แสงแก้ว', '', '1977-02-08', '2011-10-11', '', 22574, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(140, 3, '986-6-85193-1', 10, 'ภูวเดช', 'บุญคงแก้ว', '', '1983-06-13', '2011-06-26', '', 24688, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(141, 3, '908-3-24255-2', 8, 'จีรนัน', 'ขวัญทอง', '', '1979-11-05', '2014-03-11', '', 30577, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(142, 3, '908-0-36902-0', 8, 'ธัญญารัตน์', 'ชุมคด', '', '1971-11-03', '2012-07-09', '', 29257, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(143, 3, '913-0-51533-5', 8, 'ธัญญาภรณ์', 'ชายเกลี้ยง', '', '1972-05-21', '2011-02-03', '', 22069, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(144, 3, '957-0-19853-2', 8, 'สุนิษา', 'เกื้อช่วย', '', '1970-10-02', '2018-07-12', '', 30246, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(145, 3, '957-0-64535-0', 8, 'วราภรณ์', 'วรรณะ', '', '1981-03-13', '2014-11-13', '', 14175, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(146, 3, '908-0-81845-3', 8, 'อารีรัตน์', 'มหาพรหมประเสริฐ', '', '1983-06-11', '2012-10-25', '', 14337, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(147, 3, '986-1-86435-0', 8, 'สุภาวดี', 'มากมณี', '', '1974-04-07', '2018-07-14', '', 27679, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(148, 3, '984-8-30692-7', 8, 'ธัญณัฐ', 'คงเรือง', '', '1978-07-09', '2019-02-19', '', 22184, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(149, 3, '868-0-29191-9', 8, 'ธิยายุ', 'ชัยเพชร', '', '1976-01-01', '2011-06-06', '', 25859, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(150, 3, '016-0-53615-4', 8, 'วรางคณา', 'สังข์แก้ว', '', '1974-09-18', '2014-11-26', '', 23338, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(151, 3, '908-3-26505-6', 10, 'วีรพงษ์', 'งามดี', '12-12254-12450-00', '1981-09-08', '2019-11-20', 'doremon14.png', 21695, 0, '2023-06-04 07:46:58', '2023-06-14 20:29:14', NULL, -1, -1, NULL),
(152, 3, '908-3-26445-9', 10, 'นิวัติ', 'มาตชรัตน์', '12364-12554-1', '1979-08-17', '2011-10-15', '', 15226, 0, '2023-06-04 07:46:58', '2023-06-13 19:37:40', NULL, -1, -1, NULL),
(153, 3, '679-8-13698-2', 8, 'ศุภาวรรณ', 'ส่งศรี', '', '1970-10-10', '2010-02-27', '', 13294, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', NULL, -1, -1, NULL),
(154, 3, '678-5-77681-3', 8, 'ปณิชา', 'ณะมณี', '', '1974-01-15', '2017-04-15', '', 28261, 0, '2023-06-04 07:46:58', '2023-06-14 17:33:09', NULL, -1, -1, NULL),
(155, 3, '985-2-17621-8', 8, 'ศรัญญา', 'บุญรัตน์', '', '1972-06-22', '2018-10-16', '', 21380, 0, '2023-06-04 07:46:58', '2023-06-14 20:26:08', NULL, -1, -1, NULL),
(156, 3, '957-0-62431-0', 8, 'นิษฐา', 'ดำแก้ว', '', '1973-02-19', '2012-11-01', '', 27164, 0, '2023-06-04 07:46:58', '2023-06-04 07:46:58', '2023-06-14 17:21:12', -1, -1, -1),
(177, 3, '11236-44544-442', 8, 'Sommana', 'Yodmanee', '2254-4425-150', '2000-01-05', '2022-05-01', 'Deepika-Padukone-Actress.jpg', 15000, 0, '2023-06-14 20:37:11', '2023-06-14 20:37:38', '2023-06-14 20:37:55', -1, -1, -1),
(178, 3, '111111111', 0, 'สุดารัตน์', 'พุดปลอด', '111111111111', '2023-06-04', '2023-06-04', 'undefined', 20000, 0, '2023-06-15 09:34:31', '2023-06-15 09:34:31', '2023-06-15 09:38:04', -1, -1, -1),
(179, 4, '11111', 0, 'สุดารัตน์', 'พุดปลอด', '111111111111', '2023-06-11', '2023-06-18', 'undefined', 18000, 0, '2023-06-15 09:36:02', '2023-06-15 09:36:13', '2023-06-15 09:38:15', -1, -1, -1),
(176, 3, '123-456-789-10', 10, 'kora', 'nonta', '2245-44224-2244', '1966-04-10', '2010-01-01', 'av02.png', 10000, 0, '2023-06-14 20:25:14', '2023-06-14 20:27:04', '2023-06-14 20:37:52', -1, -1, -1),
(180, 4, '222', 0, 'สุดารัตน์ ', 'พุดปลอด ', '22', '2023-05-30', '2023-06-14', 'undefined', 17000, 0, '2023-06-18 10:22:16', '2023-06-18 10:22:16', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `PayrollRuns`
--

CREATE TABLE `PayrollRuns` (
  `PayrollRunId` int NOT NULL,
  `PayrollRunDate` datetime NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `PayrollRuns`
--

INSERT INTO `PayrollRuns` (`PayrollRunId`, `PayrollRunDate`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(8, '2023-08-01 00:00:00', '2023-06-17 09:21:04', '2023-06-17 09:21:04', NULL, -1, -1, NULL),
(2, '2023-06-01 00:00:00', '2023-06-16 21:17:56', '2023-06-16 21:17:56', NULL, -1, -1, NULL),
(3, '2023-07-01 00:00:00', '2023-06-16 21:22:58', '2023-06-16 21:22:58', NULL, -1, -1, NULL),
(4, '2023-05-01 00:00:00', '2023-06-16 21:23:15', '2023-06-16 21:23:15', NULL, -1, -1, NULL),
(11, '2023-09-01 00:00:00', '2023-06-17 13:19:24', '2023-06-17 13:19:24', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `PayrollTransactionItems`
--

CREATE TABLE `PayrollTransactionItems` (
  `PayrollTransactionItemId` int NOT NULL,
  `PayrollTransactionId` int NOT NULL,
  `PropertyTypeId` int NOT NULL,
  `Amount` float DEFAULT '0',
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `PayrollTransactionItems`
--

INSERT INTO `PayrollTransactionItems` (`PayrollTransactionItemId`, `PayrollTransactionId`, `PropertyTypeId`, `Amount`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(55, 10, 19, 1188.9, '2023-06-18 16:48:21', '2023-06-18 16:48:21', NULL, -1, -1, NULL),
(45, 9, 15, 400, '2023-06-17 21:09:43', '2023-06-17 21:09:43', NULL, -1, -1, NULL),
(43, 9, 16, 500, '2023-06-17 21:09:43', '2023-06-17 21:09:43', NULL, -1, -1, NULL),
(40, 9, 13, 200, '2023-06-17 21:09:42', '2023-06-17 21:09:42', NULL, -1, -1, NULL),
(46, 9, 17, 600, '2023-06-17 21:09:43', '2023-06-17 21:09:43', NULL, -1, -1, NULL),
(44, 9, 18, 700, '2023-06-17 21:09:43', '2023-06-17 21:09:43', NULL, -1, -1, NULL),
(41, 9, 12, 300, '2023-06-17 21:09:42', '2023-06-17 21:09:42', NULL, -1, -1, NULL),
(39, 9, 11, 1200, '2023-06-17 21:09:42', '2023-06-17 21:09:42', NULL, -1, -1, NULL),
(42, 9, 14, 300, '2023-06-17 21:09:42', '2023-06-17 21:09:42', NULL, -1, -1, NULL),
(61, 8, 17, 200, '2023-06-21 11:13:58', '2023-06-21 11:13:58', NULL, -1, -1, NULL),
(62, 8, 20, 300, '2023-06-21 11:13:58', '2023-06-21 11:13:58', NULL, -1, -1, NULL),
(60, 8, 18, 100, '2023-06-21 11:13:58', '2023-06-21 11:13:58', NULL, -1, -1, NULL),
(59, 8, 19, 750, '2023-06-21 11:13:58', '2023-06-21 11:13:58', NULL, -1, -1, NULL),
(56, 10, 17, 30, '2023-06-18 16:48:21', '2023-06-18 16:48:21', NULL, -1, -1, NULL),
(57, 10, 18, 150, '2023-06-18 16:48:21', '2023-06-18 16:48:21', NULL, -1, -1, NULL),
(58, 10, 20, 10, '2023-06-18 16:48:21', '2023-06-18 16:48:21', NULL, -1, -1, NULL),
(63, 11, 19, 1493.15, '2023-06-24 18:07:25', '2023-06-24 18:07:25', NULL, -1, -1, NULL),
(64, 11, 18, 50, '2023-06-24 18:07:25', '2023-06-24 18:07:25', NULL, -1, -1, NULL),
(65, 11, 17, 60, '2023-06-24 18:07:25', '2023-06-24 18:07:25', NULL, -1, -1, NULL),
(66, 11, 20, 70, '2023-06-24 18:07:25', '2023-06-24 18:07:25', NULL, -1, -1, NULL),
(67, 12, 19, 1364.2, '2023-06-24 18:52:36', '2023-06-24 18:52:36', NULL, -1, -1, NULL),
(68, 12, 18, 50, '2023-06-24 18:52:36', '2023-06-24 18:52:36', NULL, -1, -1, NULL),
(69, 12, 20, 20, '2023-06-24 18:52:36', '2023-06-24 18:52:36', NULL, -1, -1, NULL),
(70, 12, 17, 10, '2023-06-24 18:52:36', '2023-06-24 18:52:36', NULL, -1, -1, NULL),
(71, 13, 19, 1188.9, '2023-06-24 18:52:51', '2023-06-24 18:52:51', NULL, -1, -1, NULL),
(72, 13, 17, 90, '2023-06-24 18:52:51', '2023-06-24 18:52:51', NULL, -1, -1, NULL),
(73, 13, 20, 50, '2023-06-24 18:52:51', '2023-06-24 18:52:51', NULL, -1, -1, NULL),
(74, 13, 18, 70, '2023-06-24 18:52:51', '2023-06-24 18:52:51', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `PayrollTransactions`
--

CREATE TABLE `PayrollTransactions` (
  `PayrollTransactionId` int NOT NULL,
  `PayRollRunId` int NOT NULL,
  `EmployeeId` int NOT NULL,
  `DeductionId` int NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `PayrollTransactions`
--

INSERT INTO `PayrollTransactions` (`PayrollTransactionId`, `PayRollRunId`, `EmployeeId`, `DeductionId`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(9, 2, 41, 1, '2023-06-17 20:55:45', '2023-06-17 20:55:45', NULL, -1, -1, NULL),
(8, 2, 1, 2, '2023-06-17 20:55:20', '2023-06-17 20:55:20', NULL, -1, -1, NULL),
(10, 2, 2, 2, '2023-06-18 16:48:21', '2023-06-18 16:48:21', NULL, -1, -1, NULL),
(11, 2, 3, 2, '2023-06-24 18:07:25', '2023-06-24 18:07:25', NULL, -1, -1, NULL),
(12, 4, 1, 2, '2023-06-24 18:52:36', '2023-06-24 18:52:36', NULL, -1, -1, NULL),
(13, 4, 2, 2, '2023-06-24 18:52:51', '2023-06-24 18:52:51', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `PropertyTypeGroups`
--

CREATE TABLE `PropertyTypeGroups` (
  `PropertyTypeGroupId` int NOT NULL,
  `PropertyTypeGroupName` varchar(100) NOT NULL,
  `PropertyTypeGroupThaiName` varchar(100) DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `PropertyTypeGroups`
--

INSERT INTO `PropertyTypeGroups` (`PropertyTypeGroupId`, `PropertyTypeGroupName`, `PropertyTypeGroupThaiName`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 'EmployeeTypes', 'ประเภทพนักงาน', '2023-06-03 21:00:09', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(2, 'UserRoles', 'บทบาทของผู้ใช้', '2023-06-03 21:00:09', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(3, 'Genders', '', '2023-06-03 21:00:09', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(4, 'Deductions', 'หัก', '2023-06-03 21:00:10', '2023-06-03 21:00:10', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `PropertyTypes`
--

CREATE TABLE `PropertyTypes` (
  `PropertyTypeId` int NOT NULL,
  `PropertyTypeGroupId` int NOT NULL,
  `PropertyTypeName` varchar(100) NOT NULL,
  `PropertyTypeThaiName` varchar(100) DEFAULT NULL,
  `Alias` varchar(100) DEFAULT NULL,
  `AllowableValues` varchar(100) DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `PropertyTypes`
--

INSERT INTO `PropertyTypes` (`PropertyTypeId`, `PropertyTypeGroupId`, `PropertyTypeName`, `PropertyTypeThaiName`, `Alias`, `AllowableValues`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 1, 'Management', 'ผู้บริหาร', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(2, 1, 'Department head', 'หัวหน้าแผนก', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(3, 1, 'Teacher', 'ครูบรรจุ', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(4, 1, 'Staff', 'ลูกจ้าง', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(5, 2, 'Admin', 'ผู้จัดการระบบ', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(6, 2, 'Management', 'ผู้บริหาร', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(7, 2, 'User', 'ผู้ใช้ทั่วไป', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(8, 3, 'Miss', 'น.ส.', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(9, 3, 'Mrs', 'นาง', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:09', NULL, -1, -1, NULL),
(10, 3, 'Mr', 'นาย', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(11, 4, 'Contribution for teacher', 'เงินสมทบ 3%', NULL, '3%', '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(12, 4, 'CPK/CPS', 'ชพค/ชพส', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(13, 4, 'Cooperative', 'สหกรณ์', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(14, 4, 'OamSinth', 'ออมสิน', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(15, 4, 'GsbLoan', 'เงินกู้ สช.', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(16, 4, 'PrivateLoan', 'เงินกู้ สช.', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(17, 4, 'Other', 'อื่นๆ', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(18, 4, 'Saving', 'ออมทรัพย์', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(19, 4, 'Contribution for staff', 'สปส 5%', NULL, '5%', '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL),
(20, 4, 'Insurance', 'ประกัน', NULL, NULL, '0000-00-00 00:00:00', '2023-06-03 21:00:10', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RefTable`
--

CREATE TABLE `RefTable` (
  `RefId` int NOT NULL,
  `RefTypeKind` varchar(10) NOT NULL,
  `RefTypeName` varchar(100) NOT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `RefTable`
--

INSERT INTO `RefTable` (`RefId`, `RefTypeKind`, `RefTypeName`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 'EMPTYPE', 'ผู้บริหาร', '2023-05-27 10:47:14', '2023-05-27 10:47:14', NULL, -1, -1, NULL),
(2, 'EMPTYPE', 'หัวหน้าแผนก', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(3, 'EMPTYPE', 'ครูบรรจุ', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(4, 'EMPTYPE', 'ลูกจ้าง', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(5, 'USERROLE', 'ผู้จัดการระบบ', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(6, 'USERROLE', 'ผู้บริหาร', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(7, 'USERROLE', 'ผู้ใช้ทั่วไป', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(8, 'GENDER', 'น.ส.', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(9, 'GENDER', 'นาง', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(10, 'GENDER', 'นาย', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(11, 'DEDUCTYPE', 'ครูบรรจุ', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL),
(12, 'DEDUCTYPE', 'ลูกจ้าง', '2023-05-27 10:47:27', '2023-05-27 10:47:27', NULL, -1, -1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `UserId` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(100) DEFAULT NULL,
  `RoleId` int NOT NULL,
  `Image` varchar(100) DEFAULT NULL,
  `DateCreated` datetime NOT NULL,
  `DateModified` datetime NOT NULL,
  `DateDeleted` datetime DEFAULT NULL,
  `CreatedBy` int NOT NULL DEFAULT '-1',
  `ModifiedBy` int NOT NULL DEFAULT '-1',
  `DeletedBy` int DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`UserId`, `Name`, `Password`, `Email`, `Phone`, `RoleId`, `Image`, `DateCreated`, `DateModified`, `DateDeleted`, `CreatedBy`, `ModifiedBy`, `DeletedBy`) VALUES
(1, 'kora', 'knn', 'kora@gmail.com', '0639789149', 5, 'karawith.n.png', '2023-06-03 21:17:46', '2023-06-03 21:17:46', NULL, -1, -1, NULL),
(2, 'moo', 'moo', 'dchaithat@hotmail.com', '0896540599', 5, 'moo.png', '2023-06-03 21:18:02', '2023-06-10 16:59:08', NULL, -1, -1, NULL),
(3, 'dore', 'dore', 'dore@gmail.com', '0635424930', 6, 'doremon02.png\r\n', '2023-06-03 21:18:02', '2023-06-03 21:18:02', NULL, -1, -1, NULL),
(4, 'demo-05', 'demo', 'demo@gmail.com', '0735411521', 7, 'av01.png', '2023-06-03 21:18:02', '2023-06-07 19:39:57', NULL, -1, -1, NULL),
(5, 'tua.knn', 'tua', 'tua.knn@gmail.com', '80858445545', 7, 'doremon06.png', '2023-06-07 19:12:11', '2023-06-07 19:12:11', '2023-06-07 19:51:22', -1, -1, -1),
(28, 'spock', 'stg', 'vulcon@gmail.com', '85544444', 7, NULL, '2023-06-25 13:16:46', '2023-06-25 13:22:51', NULL, -1, -1, NULL),
(27, 'veronika', 'ver05', 'veronika@gmail.com', '125455784', 7, 'taylor_cole.jpg', '2023-06-25 12:48:24', '2023-06-25 13:15:53', '2023-06-25 13:16:07', -1, -1, -1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Addresses`
--
ALTER TABLE `Addresses`
  ADD PRIMARY KEY (`AddressId`),
  ADD KEY `EmployeeId` (`EmployeeId`);

--
-- Indexes for table `DeductionItems`
--
ALTER TABLE `DeductionItems`
  ADD PRIMARY KEY (`DeductionItemId`),
  ADD KEY `DeductionId` (`DeductionId`),
  ADD KEY `PropertyTypeId` (`PropertyTypeId`);

--
-- Indexes for table `Deductions`
--
ALTER TABLE `Deductions`
  ADD PRIMARY KEY (`DeductionId`);

--
-- Indexes for table `Employees`
--
ALTER TABLE `Employees`
  ADD PRIMARY KEY (`EmployeeId`),
  ADD KEY `GenderId` (`GenderId`),
  ADD KEY `EmployeeTypeId` (`EmployeeTypeId`);

--
-- Indexes for table `PayrollRuns`
--
ALTER TABLE `PayrollRuns`
  ADD PRIMARY KEY (`PayrollRunId`);

--
-- Indexes for table `PayrollTransactionItems`
--
ALTER TABLE `PayrollTransactionItems`
  ADD PRIMARY KEY (`PayrollTransactionItemId`),
  ADD KEY `PayrollTransactionId` (`PayrollTransactionId`),
  ADD KEY `PropertyTypeId` (`PropertyTypeId`);

--
-- Indexes for table `PayrollTransactions`
--
ALTER TABLE `PayrollTransactions`
  ADD PRIMARY KEY (`PayrollTransactionId`),
  ADD KEY `EmployeeId` (`EmployeeId`),
  ADD KEY `DeductionId` (`DeductionId`),
  ADD KEY `PayRollRunId` (`PayRollRunId`);

--
-- Indexes for table `PropertyTypeGroups`
--
ALTER TABLE `PropertyTypeGroups`
  ADD PRIMARY KEY (`PropertyTypeGroupId`);

--
-- Indexes for table `PropertyTypes`
--
ALTER TABLE `PropertyTypes`
  ADD PRIMARY KEY (`PropertyTypeId`),
  ADD KEY `PropertyTypeGroupId` (`PropertyTypeGroupId`),
  ADD KEY `PropertyTypesIndex` (`PropertyTypeId`,`PropertyTypeGroupId`);

--
-- Indexes for table `RefTable`
--
ALTER TABLE `RefTable`
  ADD PRIMARY KEY (`RefId`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserId`),
  ADD KEY `RoleId` (`RoleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Addresses`
--
ALTER TABLE `Addresses`
  MODIFY `AddressId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `DeductionItems`
--
ALTER TABLE `DeductionItems`
  MODIFY `DeductionItemId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Deductions`
--
ALTER TABLE `Deductions`
  MODIFY `DeductionId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Employees`
--
ALTER TABLE `Employees`
  MODIFY `EmployeeId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `PayrollRuns`
--
ALTER TABLE `PayrollRuns`
  MODIFY `PayrollRunId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `PayrollTransactionItems`
--
ALTER TABLE `PayrollTransactionItems`
  MODIFY `PayrollTransactionItemId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `PayrollTransactions`
--
ALTER TABLE `PayrollTransactions`
  MODIFY `PayrollTransactionId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `PropertyTypeGroups`
--
ALTER TABLE `PropertyTypeGroups`
  MODIFY `PropertyTypeGroupId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `PropertyTypes`
--
ALTER TABLE `PropertyTypes`
  MODIFY `PropertyTypeId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `RefTable`
--
ALTER TABLE `RefTable`
  MODIFY `RefId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `UserId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
