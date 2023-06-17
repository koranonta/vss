DELIMITER $$
DROP PROCEDURE IF EXISTS spAddPayrollTransaction
$$

CREATE PROCEDURE spAddPayrollTransaction (
  pPayRollRunId             INT
 ,pEmployeeId               INT
 ,pDeductionId              INT
 ,pLoginId                  INT
 ,OUT oPayrollTransactionId INT
)
/***********************************************************
 *  Procedure: spAddPayrollTransaction
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spAddPayrollTransaction(3, 1, 2, -1, @newId);
 *         SELECT @NewId as transid;
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-15
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN  
  DECLARE transid INT;
  SET pLoginId = IFNULL(pLoginId, -1);
  
  SELECT PayrollTransactionId INTO oPayrollTransactionId
    FROM PayrollTransactions
   WHERE PayrollRunId = pPayrollRunId
     AND EmployeeId   = pEmployeeId
     AND DeductionId  = pDeductionId
     AND DateDeleted IS NULL;
     
  IF ISNULL(oPayrollTransactionId) THEN
    INSERT INTO PayrollTransactions (PayRollRunId, EmployeeId, DeductionId, DateCreated, DateModified, CreatedBy, ModifiedBy)
      VALUES(pPayRollRunId, pEmployeeId, pDeductionId, Now(), Now(), pLoginId, pLoginId);
    SET oPayrollTransactionId = LAST_INSERT_ID();
  END IF;
END
$$
DELIMITER ;

