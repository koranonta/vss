DELIMITER $$
DROP PROCEDURE IF EXISTS spAddPayrollTransaction
$$

CREATE PROCEDURE spAddPayrollTransaction (
  pPayRollRunId         INT
 ,pEmployeeId           INT
 ,pDeductionId          INT
 ,pLoginId              INT
 ,OUT oPayrollTransactionIdINT
)
/***********************************************************
 *  Procedure: spAddPayrollTransaction
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
  INSERT INTO PayrollTransactions (PayRollRunId, EmployeeId, DeductionId, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayRollRunId, pEmployeeId, pDeductionId, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionId = LAST_INSERT_ID();
END
$$
DELIMITER ;

