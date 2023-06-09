DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollRunById
$$

CREATE PROCEDURE spGetPayrollRunById (
  pPayrollRunId INT
)
/***********************************************************
 *  Procedure: spGetPayrollRunById
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
  SELECT PayrollRunId    as payrollrunid
        ,PayrollRunDate  as payrollrundate
    FROM PayrollRuns
   WHERE PayrollRunId = pPayrollRunId;
END
$$
DELIMITER ;

