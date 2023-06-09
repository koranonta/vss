DELIMITER $$
DROP PROCEDURE IF EXISTS spGetEmployees
$$

CREATE PROCEDURE spGetEmployees (
  pEmployeeId INT
)
/***********************************************************
 *  Procedure: spGetEmployees
 *
 *  Purpose:
 *    
 *
 *  Usage:  CALL spGetEmployees(-1);
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-04
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
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
END
$$
DELIMITER ;

