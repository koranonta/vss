DELIMITER $$
DROP PROCEDURE IF EXISTS spAddUser
$$

CREATE PROCEDURE spAddUser (
  pName         VARCHAR(100)
 ,pPassword     VARCHAR(255)
 ,pEmail        VARCHAR(100)
 ,pPhone        VARCHAR(100)
 ,pUserTypeId   INT
 ,pImage        VARCHAR(100)
 ,pLoginId      INT
 ,OUT oUserId   INT
)
/***********************************************************
 *  Procedure: spAddUser
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
  INSERT INTO Users (Name, Password, Email, Phone, UserTypeId, Image, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pName, pPassword, pEmail, pPhone, pUserTypeId, pImage, Now(), Now(), pLoginId, pLoginId);
  SET oUserId = LAST_INSERT_ID();
END
$$
DELIMITER ;

