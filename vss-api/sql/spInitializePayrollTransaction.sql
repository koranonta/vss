DELIMITER $$
DROP PROCEDURE IF EXISTS spInitializePayrollTransaction
$$

CREATE PROCEDURE spInitializePayrollTransaction (
  pPayRollRunId         INT
 ,pEmployeeId           INT
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
  DECLARE _EmployeeTypeId INT;
  DECLARE _Salary         FLOAT;

  SELECT `EmployeeTypeId`,`Salary` INTO _EmployeeTypeId, _Salary 
    FROM `Employees` 
   WHERE `EmplyeeId`= pEmployeeId; 
     AND `DateDeleted` IS NULL
  
  IF _EmployeeTypeId = 3
  BEGIN
    
  END
  
  
  
  
  
  INSERT INTO PayrollTransactions (PayRollRunId, EmployeeId, DeductionId, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayRollRunId, pEmployeeId, pDeductionId, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionId = LAST_INSERT_ID();
END
$$
DELIMITER ;

