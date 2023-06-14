DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteAddress
$$

CREATE PROCEDURE spDeleteAddress (
  pEmplyeeId INT
 ,pLoginId   INT
)
/***********************************************************
 *  Procedure: spDeleteAddress
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-09
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  UPDATE Addresses
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE EmployeeId = pEmplyeeId
     AND DateDeleted IS NULL;
END
$$
DELIMITER ;

