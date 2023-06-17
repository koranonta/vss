DELIMITER $$
DROP PROCEDURE IF EXISTS spDeletePayrollTransactionItem
$$

CREATE PROCEDURE spDeletePayrollTransactionItem (
  pPayrollTransactionItemId INT
 ,pLoginId                  INT
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
 *  Created:   KNN     2023-06-15
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  UPDATE PayrollTransactionItems
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId;     
END
$$
DELIMITER ;

