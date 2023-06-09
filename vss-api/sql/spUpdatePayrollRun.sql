DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdatePayrollRun
$$

CREATE PROCEDURE spUpdatePayrollRun (
  pPayrollRunId   INT
 ,pPayrollRunDate DATETIME
 ,pLoginId        INT
)
/***********************************************************
 *  Procedure: spUpdatePayrollRun
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
  UPDATE PayrollRuns
     SET PayrollRunId    = pPayrollRunId
        ,PayrollRunDate  = pPayrollRunDate
        ,DateModified    = Now()
        ,ModifiedBy      = pLoginId
   WHERE PayrollRunId = pPayrollRunId
END
$$
DELIMITER ;

