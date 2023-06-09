DELIMITER $$
DROP PROCEDURE IF EXISTS spAddEmplyee
$$

CREATE PROCEDURE spAddEmplyee (
  pEmployeeTypeId       INT
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
 ,OUT oEmployeeId       INT
)
/***********************************************************
 *  Procedure: spAddEmplyee
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
  INSERT INTO Emplyees (EmployeeTypeId, AccountId, GenderId, FirstName, LastName, IdentificationCardId, BirthDate, Image, Salary, PositionSalary, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeTypeId, pAccountId, pGenderId, pFirstName, pLastName, pIdentificationCardId, pBirthDate, pImage, pSalary, pPositionSalary, Now(), Now(), pLoginId, pLoginId);
  SET oEmployeeId = LAST_INSERT_ID();
END
$$
DELIMITER ;

