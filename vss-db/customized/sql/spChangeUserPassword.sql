DELIMITER $$
DROP PROCEDURE IF EXISTS spUserChangePassword
$$

CREATE PROCEDURE spUserChangePassword (
  pUserId      INT
 ,pNewPassword VARCHAR(255)
 ,pLoginId     INT
)
/***********************************************************
 *  Procedure: spUserChangePassword
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

