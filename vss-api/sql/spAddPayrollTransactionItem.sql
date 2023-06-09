DELIMITER $$
DROP PROCEDURE IF EXISTS spAddPayrollTransactionItem
$$

CREATE PROCEDURE spAddPayrollTransactionItem (
  pPayrollTransactionId     INT
 ,pDeductionItemId          INT
 ,pAmount                   FLOAT
 ,pLoginId                  INT
 ,OUT oPayrollTransactionItemIdINT
)
/***********************************************************
 *  Procedure: spAddPayrollTransactionItem
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
  INSERT INTO PayrollTransactionItems (PayrollTransactionId, DeductionItemId, Amount, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollTransactionId, pDeductionItemId, pAmount, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionItemId = LAST_INSERT_ID();
END
$$
DELIMITER ;

