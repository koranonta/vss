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
        ,pt.AllowableValues      as allowablevalues
        ,pti.Amount              as amount
    FROM PayrollTransactions prt
   INNER JOIN PayrollTransactionItems pti
      ON prt.PayrollTransactionId = pti.PayrollTransactionId
   INNER JOIN PropertyTypes pt
      ON pti.PropertyTypeId = pt.PropertyTypeId
   WHERE prt.PayrollRunId = pPayrollRunId
     AND prt.DateDeleted IS NULL
     AND pti.DateDeleted IS NULL;
END
$$
DELIMITER ;

