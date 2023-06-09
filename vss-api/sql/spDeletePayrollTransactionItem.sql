DELIMITER $$
DROP PROCEDURE IF EXISTS spDeletePayrollTransactionItem
$$

CREATE PROCEDURE spDeletePayrollTransactionItem (
  pPayrollTransactionItemId INT
)
/***********************************************************
 *  Procedure: spDeletePayrollTransactionItem
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
  DELETE FROM PayrollTransactionItems WHERE PayrollTransactionItemId = pPayrollTransactionItemId;
END
$$
DELIMITER ;

