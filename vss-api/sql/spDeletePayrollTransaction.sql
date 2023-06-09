DELIMITER $$
DROP PROCEDURE IF EXISTS spDeletePayrollTransaction
$$

CREATE PROCEDURE spDeletePayrollTransaction (
  pPayrollTransactionId INT
)
/***********************************************************
 *  Procedure: spDeletePayrollTransaction
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
  DELETE FROM PayrollTransactions WHERE PayrollTransactionId = pPayrollTransactionId;
END
$$
DELIMITER ;

