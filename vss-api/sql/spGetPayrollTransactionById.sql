DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollTransactionById
$$

CREATE PROCEDURE spGetPayrollTransactionById (
  pPayrollTransactionId INT
)
/***********************************************************
 *  Procedure: spGetPayrollTransactionById
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
  SELECT PayrollTransactionId  as payrolltransactionid
        ,PayRollRunId          as payrollrunid
        ,EmployeeId            as employeeid
        ,DeductionId           as deductionid
    FROM PayrollTransactions
   WHERE PayrollTransactionId = pPayrollTransactionId;
END
$$
DELIMITER ;

