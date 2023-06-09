DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdatePayrollTransactionItem
$$

CREATE PROCEDURE spUpdatePayrollTransactionItem (
  pPayrollTransactionItemId INT
 ,pPayrollTransactionId     INT
 ,pDeductionItemId          INT
 ,pAmount                   FLOAT
 ,pLoginId                  INT
)
/***********************************************************
 *  Procedure: spUpdatePayrollTransactionItem
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN    2023-05-27
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE PayrollTransactionItems
     SET PayrollTransactionItemId  = pPayrollTransactionItemId
        ,PayrollTransactionId      = pPayrollTransactionId
        ,DeductionItemId           = pDeductionItemId
        ,Amount                    = pAmount
        ,DateModified              = Now()
        ,ModifiedBy                = pLoginId
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId
END
$$
DELIMITER ;

