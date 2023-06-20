DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollTransactionItemsByRunId
$$

CREATE PROCEDURE spGetPayrollTransactionItemsByRunId (
  pPayRollRunId  INT
)
/***********************************************************
 *  Procedure: spGetPayrollTransactionItemsByRunId
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spGetPayrollTransactionItemsByRunId( 2 );
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-15
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  
  SELECT prt.PayrollRunId        as payrollrunid
        ,prt.EmployeeId          as employeeid
        ,prt.DeductionId         as deductionid
        ,pti.PropertyTypeId      as propertytypeid
        ,pt.PropertyTypeName     as propertytypename
        ,pt.PropertyTypeThaiName as propertytypethainame
        ,di.CalculationRule      as calculationrule
        ,di.MaximumValue         as maximumvalue
        ,pti.Amount              as amount
    FROM PayrollTransactions prt
   INNER JOIN PayrollTransactionItems pti
      ON prt.PayrollTransactionId = pti.PayrollTransactionId
   INNER JOIN DeductionItems di
      ON prt.DeductionId = di.DeductionId 
     AND pti.PropertyTypeId = di.PropertyTypeId        
   INNER JOIN PropertyTypes pt
      ON pti.PropertyTypeId = pt.PropertyTypeId
   WHERE prt.PayrollRunId = pPayrollRunId
     AND prt.DateDeleted IS NULL
     AND pti.DateDeleted IS NULL
   ORDER BY prt.EmployeeId, di.DeductionItemId;
END
$$
DELIMITER ;
