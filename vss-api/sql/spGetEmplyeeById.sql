DELIMITER $$
DROP PROCEDURE IF EXISTS spGetEmplyeeById
$$

CREATE PROCEDURE spGetEmplyeeById (
  pEmployeeId INT
)
/***********************************************************
 *  Procedure: spGetEmplyeeById
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN    2023-05-27
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT EmployeeId            as employeeid
        ,EmployeeTypeId        as employeetypeid
        ,AccountId             as accountid
        ,GenderId              as genderid
        ,FirstName             as firstname
        ,LastName              as lastname
        ,IdentificationCardId  as identificationcardid
        ,BirthDate             as birthdate
        ,Image                 as image
        ,Salary                as salary
        ,PositionSalary        as positionsalary
    FROM Emplyees
   WHERE EmployeeId = pEmployeeId
     AND DateDeleted IS NULL;
END
$$
DELIMITER ;

