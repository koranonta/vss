DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateUser
$$

CREATE PROCEDURE spUpdateUser (
  pUserId       INT
 ,pName         VARCHAR(100)
 ,pPassword     VARCHAR(255)
 ,pEmail        VARCHAR(100)
 ,pPhone        VARCHAR(100)
 ,pUserTypeId   INT
 ,pImage        VARCHAR(100)
 ,pLoginId      INT
)
/***********************************************************
 *  Procedure: spUpdateUser
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
  UPDATE Users
     SET UserId        = pUserId
        ,Name          = pName
        ,Password      = pPassword
        ,Email         = pEmail
        ,Phone         = pPhone
        ,UserTypeId    = pUserTypeId
        ,Image         = pImage
        ,DateModified  = Now()
        ,ModifiedBy    = pLoginId
   WHERE UserId = pUserId
END
$$
DELIMITER ;

