DELIMITER $$
DROP PROCEDURE IF EXISTS spGetEmplyees
$$

CREATE PROCEDURE spGetEmplyees ()
/***********************************************************
 *  Procedure: spGetEmplyees
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
    FROM Emplyees;
END
$$
DELIMITER ;

