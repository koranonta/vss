DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteDeduction
$$

CREATE PROCEDURE spDeleteDeduction (
  pDeductionId INT
)
/***********************************************************
 *  Procedure: spDeleteDeduction
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
  DELETE FROM Deductions WHERE DeductionId = pDeductionId;
END
$$
DELIMITER ;

