DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollRunItems
$$

CREATE PROCEDURE spGetPayrollRunItems (
  pRunDate DATETIME
)
/***********************************************************
 *  Procedure: spGetPayrollRunItems
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spGetPayrollRunItems('2023-05-01');
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-09
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT pr.PayrollRunId              as runid
        ,pr.PayrollRunDate            as rundate 
        ,pt.PayrollTransactionId      as transactionid
        ,pt.EmployeeId                as employeeid
        ,pt.DeductionId               as deductionid
        ,pti.PayrollTransactionItemId as transactionitemid
        ,pti.PropertyTypeId           as propertytypeid
        ,pti.Amount                   as amount
    FROM PayrollRuns pr
   LEFT JOIN PayrollTransactions pt
      ON pr.PayrollRunId = pt.PayrollRunId
   LEFT JOIN PayrollTransactionItems pti
      ON pt.PayrollTransactionId = pti.PayrollTransactionItemId
  WHERE pr.DateDeleted IS NULL
    AND pt.DateDeleted IS NULL
    AND pti.DateDeleted IS NULL
    AND pr.PayrollRunDate = pRunDate;
END
$$
DELIMITER ;
    

  