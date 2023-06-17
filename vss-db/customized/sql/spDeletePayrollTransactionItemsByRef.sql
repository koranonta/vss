DELIMITER $$
DROP PROCEDURE IF EXISTS spDeletePayrollTransactionItemsByRef
$$

CREATE PROCEDURE spDeletePayrollTransactionItemsByRef (
  pPayrollTransactionId INT
)
/***********************************************************
 *  Procedure: spDeletePayrollTransactionItemsByRef
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-15
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId;     
END
$$
DELIMITER ;

