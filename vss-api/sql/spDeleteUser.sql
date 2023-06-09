DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteUser
$$

CREATE PROCEDURE spDeleteUser (
  pUserId INT
)
/***********************************************************
 *  Procedure: spDeleteUser
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   @@AUTHOR@@     2023-05-27
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  DELETE FROM Users WHERE UserId = pUserId;
END
$$
DELIMITER ;

