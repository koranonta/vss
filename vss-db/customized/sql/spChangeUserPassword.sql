DELIMITER $$
DROP PROCEDURE IF EXISTS spChangeUserPassword
$$

CREATE PROCEDURE spChangeUserPassword (
  pUserId      INT
 ,pNewPassword VARCHAR(255)
 ,pLoginId     INT
)
/***********************************************************
 *  Procedure: spChangeUserPassword
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-20
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET Password          = pNewPassword
        ,DateModified      = Now()
        ,ModifiedBy        = pLoginId
   WHERE UserId = pUserId
     AND DateDeleted IS NULL;
END
$$
DELIMITER ;

