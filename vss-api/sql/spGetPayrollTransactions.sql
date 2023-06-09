DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollTransactions
$$

CREATE PROCEDURE spGetPayrollTransactions ()
/***********************************************************
 *  Procedure: spGetPayrollTransactions
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
    FROM PayrollTransactions;
END
$$
DELIMITER ;

