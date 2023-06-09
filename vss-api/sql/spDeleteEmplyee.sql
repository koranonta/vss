DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteEmplyee
$$

CREATE PROCEDURE spDeleteEmplyee (
  pEmployeeId INT
)
/***********************************************************
 *  Procedure: spDeleteEmplyee
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
  DELETE FROM Emplyees WHERE EmployeeId = pEmployeeId;
END
$$
DELIMITER ;

