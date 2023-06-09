DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateEmplyee
$$

CREATE PROCEDURE spUpdateEmplyee (
  pEmployeeId           INT
 ,pEmployeeTypeId       INT
 ,pAccountId            VARCHAR(50)
 ,pGenderId             INT
 ,pFirstName            VARCHAR(50)
 ,pLastName             VARCHAR(50)
 ,pIdentificationCardId VARCHAR(13)
 ,pBirthDate            DATE
 ,pImage                VARCHAR(100)
 ,pSalary               FLOAT
 ,pPositionSalary       FLOAT
 ,pLoginId              INT
)
/***********************************************************
 *  Procedure: spUpdateEmplyee
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
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Emplyees
     SET EmployeeId            = pEmployeeId
        ,EmployeeTypeId        = pEmployeeTypeId
        ,AccountId             = pAccountId
        ,GenderId              = pGenderId
        ,FirstName             = pFirstName
        ,LastName              = pLastName
        ,IdentificationCardId  = pIdentificationCardId
        ,BirthDate             = pBirthDate
        ,Image                 = pImage
        ,Salary                = pSalary
        ,PositionSalary        = pPositionSalary
        ,DateModified          = Now()
        ,ModifiedBy            = pLoginId
   WHERE EmployeeId = pEmployeeId
END
$$
DELIMITER ;

