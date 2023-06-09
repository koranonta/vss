DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdatePayrollTransaction
$$

CREATE PROCEDURE spUpdatePayrollTransaction (
  pPayrollTransactionId INT
 ,pPayRollRunId         INT
 ,pEmployeeId           INT
 ,pDeductionId          INT
 ,pLoginId              INT
)
/***********************************************************
 *  Procedure: spUpdatePayrollTransaction
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
  UPDATE PayrollTransactions
     SET PayrollTransactionId  = pPayrollTransactionId
        ,PayRollRunId          = pPayRollRunId
        ,EmployeeId            = pEmployeeId
        ,DeductionId           = pDeductionId
        ,DateModified          = Now()
        ,ModifiedBy            = pLoginId
   WHERE PayrollTransactionId = pPayrollTransactionId
END
$$
DELIMITER ;

