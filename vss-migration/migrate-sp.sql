-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 09, 2023 at 04:03 PM
-- Server version: 8.0.32
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


DELIMITER $$
--
-- Procedures
--
CREATE PROCEDURE `spAddaddress` (`pEmployeeId` INT, `pAddress` VARCHAR(100), `pSubDistrict` VARCHAR(100), `pDistrict` VARCHAR(100), `pStreet` VARCHAR(255), `pCity` VARCHAR(100), `pProvince` VARCHAR(100), `pCountry` VARCHAR(100), `pPostCode` VARCHAR(20), `pLoginId` INT, OUT `oAddressId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Addresses (EmployeeId, Address, SubDistrict, District, Street, City, Province, Country, PostCode, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeId, pAddress, pSubDistrict, pDistrict, pStreet, pCity, pProvince, pCountry, pPostCode, Now(), Now(), pLoginId, pLoginId);
  SET oAddressId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddDeduction` (`pDeductionTypeId` INT, `pDeductionName` VARCHAR(100), `pDeductionThaiName` VARCHAR(100), `pLoginId` INT, OUT `oDeductionId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Deductions (DeductionTypeId, DeductionName, DeductionThaiName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionTypeId, pDeductionName, pDeductionThaiName, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddDeductionItem` (`pDeductionId` INT, `pPropertyTypeId` INT, `pLoginId` INT, OUT `oDeductionItemId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO DeductionItems (DeductionId, PropertyTypeId, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionId, pPropertyTypeId, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionItemId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddemployee` (`pEmployeeTypeId` INT, `pAccountId` VARCHAR(50), `pGenderId` INT, `pFirstName` VARCHAR(50), `pLastName` VARCHAR(50), `pIdentificationCardId` VARCHAR(50), `pBirthDate` DATE, `pJoinDate` DATE, `pImage` VARCHAR(100), `pSalary` FLOAT, `pPositionSalary` FLOAT, `pLoginId` INT, OUT `oEmployeeId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Employees (EmployeeTypeId, AccountId, GenderId, FirstName, LastName, IdentificationCardId, BirthDate, JoinDate, Image, Salary, PositionSalary, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeTypeId, pAccountId, pGenderId, pFirstName, pLastName, pIdentificationCardId, pBirthDate, pJoinDate, pImage, pSalary, pPositionSalary, Now(), Now(), pLoginId, pLoginId);
  SET oEmployeeId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddPayrollRun` (`pPayrollRunDate` DATETIME, `pLoginId` INT, OUT `oPayrollRunId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PayrollRuns (PayrollRunDate, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollRunDate, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollRunId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddPayrollTransaction` (`pPayRollRunId` INT, `pEmployeeId` INT, `pDeductionId` INT, `pLoginId` INT, OUT `oPayrollTransactionId` INT)   BEGIN  
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

CREATE PROCEDURE `spAddPayrollTransactionItem` (`pPayrollTransactionId` INT, `pPropertyTypeId` INT, `pAmount` FLOAT, `pLoginId` INT, OUT `oPayrollTransactionItemId` INT)   BEGIN  
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId
     AND PropertyTypeId       = pPropertyTypeId;

  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PayrollTransactionItems (PayrollTransactionId, PropertyTypeId, Amount, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollTransactionId, pPropertyTypeId, pAmount, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionItemId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddPropertyType` (`pPropertyTypeGroupId` INT, `pPropertyTypeName` VARCHAR(100), `pPropertyTypeThaiName` VARCHAR(100), `pAlias` VARCHAR(100), `pAllowableValues` VARCHAR(100), `pLoginId` INT, OUT `oPropertyTypeId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PropertyTypes (PropertyTypeGroupId, PropertyTypeName, PropertyTypeThaiName, Alias, AllowableValues, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPropertyTypeGroupId, pPropertyTypeName, pPropertyTypeThaiName, pAlias, pAllowableValues, Now(), Now(), pLoginId, pLoginId);
  SET oPropertyTypeId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddPropertyTypeGroup` (`pPropertyTypeGroupName` VARCHAR(100), `pPropertyTypeGroupThaiName` VARCHAR(100), `pLoginId` INT, OUT `oPropertyTypeGroupId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PropertyTypeGroups (PropertyTypeGroupName, PropertyTypeGroupThaiName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPropertyTypeGroupName, pPropertyTypeGroupThaiName, Now(), Now(), pLoginId, pLoginId);
  SET oPropertyTypeGroupId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddRefTable` (`pRefTypeKind` VARCHAR(10), `pRefTypeName` VARCHAR(100), `pLoginId` INT, OUT `oRefId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO RefTable (RefTypeKind, RefTypeName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pRefTypeKind, pRefTypeName, Now(), Now(), pLoginId, pLoginId);
  SET oRefId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spAddUser` (`pName` VARCHAR(100), `pPassword` VARCHAR(255), `pEmail` VARCHAR(100), `pPhone` VARCHAR(100), `pRoleId` INT, `pImage` VARCHAR(100), `pLoginId` INT, OUT `oUserId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Users (Name, Password, Email, Phone, RoleId, Image, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pName, pPassword, pEmail, pPhone, pRoleId, pImage, Now(), Now(), pLoginId, pLoginId);
  SET oUserId = LAST_INSERT_ID();
END$$

CREATE PROCEDURE `spChangeUserPassword` (`pUserId` INT, `pNewPassword` VARCHAR(255), `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET Password          = pNewPassword
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE UserId = pUserId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spDeleteAddress` (`pEmplyeeId` INT, `pLoginId` INT)   BEGIN
  UPDATE Addresses
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE EmployeeId = pEmplyeeId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spDeleteDeduction` (`pDeductionId` INT)   BEGIN
  DELETE FROM Deductions WHERE DeductionId = pDeductionId;
END$$

CREATE PROCEDURE `spDeleteDeductionItem` (`pDeductionItemId` INT)   BEGIN
  DELETE FROM DeductionItems WHERE DeductionItemId = pDeductionItemId;
END$$

CREATE PROCEDURE `spDeleteEmployee` (`pEmployeeId` INT, `pLoginId` INT)   BEGIN
  UPDATE Employees
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE EmployeeId = pEmployeeId;     
END$$

CREATE PROCEDURE `spDeletePayrollRun` (`pPayrollRunId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollRuns
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollRunId = pPayrollRunId;     
END$$

CREATE PROCEDURE `spDeletePayrollTransaction` (`pPayrollTransactionId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollTransactions
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollTransactionId = pPayrollTransactionId;     
END$$

CREATE PROCEDURE `spDeletePayrollTransactionItem` (`pPayrollTransactionItemId` INT, `pLoginId` INT)   BEGIN
  UPDATE PayrollTransactionItems
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId;     
END$$

CREATE PROCEDURE `spDeletePayrollTransactionItemsByRef` (`pPayrollTransactionId` INT)   BEGIN
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId;     
END$$

CREATE PROCEDURE `spDeletePropertyType` (`pPropertyTypeId` INT)   BEGIN
  DELETE FROM PropertyTypes WHERE PropertyTypeId = pPropertyTypeId;
END$$

CREATE PROCEDURE `spDeletePropertyTypeGroup` (`pPropertyTypeGroupId` INT)   BEGIN
  DELETE FROM PropertyTypeGroups WHERE PropertyTypeGroupId = pPropertyTypeGroupId;
END$$

CREATE PROCEDURE `spDeleteuser` (`pUserId` INT, `pLoginId` INT)   BEGIN
  UPDATE Users
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE UserId = pUserId;     
END$$

CREATE PROCEDURE `spGetAddresses` (`pAddressId` INT)   BEGIN
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

CREATE PROCEDURE `spGetAddressesByEmployeeId` (`pEmployeeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetDeductionById` (`pDeductionId` INT)   BEGIN
  SELECT DeductionId            as deductionid
        ,DeductionTypeId        as deductiontypeid
        ,DeductionName          as deductionname
        ,DeductionThaiName      as deductionthainame
    FROM Deductions
   WHERE DeductionId = pDeductionId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spGetDeductionItemById` (`pDeductionItemId` INT)   BEGIN
  SELECT DeductionItemId      as deductionitemid
        ,DeductionId          as deductionid
        ,PropertyTypeId       as propertytypeid
    FROM DeductionItems
   WHERE DeductionItemId = pDeductionItemId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spGetDeductionItems` (`pDeductionItemId` INT)   BEGIN
  SELECT DeductionItemId      as deductionitemid
        ,DeductionId          as deductionid
        ,PropertyTypeId       as propertytypeid
    FROM DeductionItems
   WHERE DateDeleted IS NULL
     AND (DeductionItemId = pDeductionItemId OR IF( pDeductionItemId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetDeductionRules` (`pDeductionId` INT)   BEGIN
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

CREATE PROCEDURE `spGetDeductions` (`pDeductionId` INT)   BEGIN
  SELECT DeductionId            as deductionid
        ,DeductionTypeId        as deductiontypeid
        ,DeductionName          as deductionname
        ,DeductionThaiName      as deductionthainame
    FROM Deductions
   WHERE DateDeleted IS NULL
     AND (DeductionId = pDeductionId OR IF( pDeductionId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetEmployeeById` (`pEmployeeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetEmployees` (`pEmployeeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetEmplyeeById` (`pEmployeeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetMembers` (`pEmployeeId` INT)   BEGIN
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
     AND (e.EmployeeId = pEmployeeId OR IF( pEmployeeId <= 0, 1, 0) = 1)
     AND e.CoopMember = 1;
END$$

CREATE PROCEDURE `spGetPayrollRunByDate` (`pRunDate` DATETIME)   BEGIN
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

CREATE PROCEDURE `spGetPayrollRunItems` (`pRunDate` DATETIME)   BEGIN
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

CREATE PROCEDURE `spGetPayrollRuns` (`pPayrollRunId` INT)   BEGIN
  SELECT PayrollRunId      as payrollrunid
        ,PayrollRunDate    as payrollrundate
    FROM PayrollRuns
   WHERE DateDeleted IS NULL
     AND (PayrollRunId = pPayrollRunId OR IF( pPayrollRunId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetPayrollTransactionItems` (`pPayrollTransactionItemId` INT)   BEGIN
  SELECT PayrollTransactionItemId      as payrolltransactionitemid
        ,PayrollTransactionId          as payrolltransactionid
        ,PropertyTypeId                as propertytypeid
        ,Amount                        as amount
    FROM PayrollTransactionItems
   WHERE DateDeleted IS NULL
     AND (PayrollTransactionItemId = pPayrollTransactionItemId OR IF( pPayrollTransactionItemId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetPayrollTransactionItemsByRunId` (`pPayRollRunId` INT)   BEGIN
  
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

CREATE PROCEDURE `spGetPayrollTransactions` (`pPayrollTransactionId` INT)   BEGIN
  SELECT PayrollTransactionId      as payrolltransactionid
        ,PayRollRunId              as payrollrunid
        ,EmployeeId                as employeeid
        ,DeductionId               as deductionid
    FROM PayrollTransactions
   WHERE DateDeleted IS NULL
     AND (PayrollTransactionId = pPayrollTransactionId OR IF( pPayrollTransactionId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetPropertyTypeByGroupId` (`pGroupId` INT)   BEGIN
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

CREATE PROCEDURE `spGetPropertyTypeByGroups` (`pPropertyTypeGroupId` INT)   BEGIN
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

CREATE PROCEDURE `spGetPropertyTypeById` (`pPropertyTypeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetPropertyTypeGroupById` (`pPropertyTypeGroupId` INT)   BEGIN
  SELECT PropertyTypeGroupId            as propertytypegroupid
        ,PropertyTypeGroupName          as propertytypegroupname
        ,PropertyTypeGroupThaiName      as propertytypegroupthainame
    FROM PropertyTypeGroups
   WHERE PropertyTypeGroupId = pPropertyTypeGroupId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spGetPropertyTypeGroups` (`pPropertyTypeGroupId` INT)   BEGIN
  SELECT PropertyTypeGroupId            as propertytypegroupid
        ,PropertyTypeGroupName          as propertytypegroupname
        ,PropertyTypeGroupThaiName      as propertytypegroupthainame
    FROM PropertyTypeGroups
   WHERE DateDeleted IS NULL
     AND (PropertyTypeGroupId = pPropertyTypeGroupId OR IF( pPropertyTypeGroupId <= 0, 1, 0) = 1);
END$$

CREATE PROCEDURE `spGetPropertyTypes` (`pPropertyTypeId` INT)   BEGIN
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

CREATE PROCEDURE `spGetUserById` (`pUserId` INT)   BEGIN
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

CREATE PROCEDURE `spGetUserByIdentifier` (`pIdentifier` VARCHAR(100))   BEGIN
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

CREATE PROCEDURE `spGetUsers` (`pUserId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdateaddress` (`pAddressId` INT, `pEmployeeId` INT, `pAddress` VARCHAR(100), `pSubDistrict` VARCHAR(100), `pDistrict` VARCHAR(100), `pStreet` VARCHAR(255), `pCity` VARCHAR(100), `pProvince` VARCHAR(100), `pCountry` VARCHAR(100), `pPostCode` VARCHAR(20), `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdateDeduction` (`pDeductionId` INT, `pDeductionTypeId` INT, `pDeductionName` VARCHAR(100), `pDeductionThaiName` VARCHAR(100), `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdateDeductionItem` (`pDeductionItemId` INT, `pDeductionId` INT, `pPropertyTypeId` INT, `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdateEmployee` (`pEmployeeId` INT, `pEmployeeTypeId` INT, `pAccountId` VARCHAR(50), `pGenderId` INT, `pFirstName` VARCHAR(50), `pLastName` VARCHAR(50), `pIdentificationCardId` VARCHAR(50), `pBirthDate` DATE, `pJoinDate` DATE, `pImage` VARCHAR(100), `pSalary` FLOAT, `pPositionSalary` FLOAT, `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdatePayrollRun` (`pPayrollRunId` INT, `pPayrollRunDate` DATETIME, `pLoginId` INT)   BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PayrollRuns
     SET PayrollRunId      = pPayrollRunId
        ,PayrollRunDate    = pPayrollRunDate
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE PayrollRunId = pPayrollRunId
     AND DateDeleted IS NULL;
END$$

CREATE PROCEDURE `spUpdatePayrollTransaction` (`pPayrollTransactionId` INT, `pPayRollRunId` INT, `pEmployeeId` INT, `pDeductionId` INT, `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdatePayrollTransactionItem` (`pPayrollTransactionItemId` INT, `pPayrollTransactionId` INT, `pPropertyTypeId` INT, `pAmount` FLOAT, `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdatePropertyType` (`pPropertyTypeId` INT, `pPropertyTypeGroupId` INT, `pPropertyTypeName` VARCHAR(100), `pPropertyTypeThaiName` VARCHAR(100), `pAlias` VARCHAR(100), `pAllowableValues` VARCHAR(100), `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdatePropertyTypeGroup` (`pPropertyTypeGroupId` INT, `pPropertyTypeGroupName` VARCHAR(100), `pPropertyTypeGroupThaiName` VARCHAR(100), `pLoginId` INT)   BEGIN
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

CREATE PROCEDURE `spUpdateUser` (`pUserId` INT, `pName` VARCHAR(100), `pPassword` VARCHAR(255), `pEmail` VARCHAR(100), `pPhone` VARCHAR(100), `pRoleId` INT, `pImage` VARCHAR(100), `pLoginId` INT)   BEGIN
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

COMMIT;
