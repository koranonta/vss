DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollRunByDate
$$

CREATE PROCEDURE spGetPayrollRunByDate (
  pRunDate DATETIME
)
/***********************************************************
 *  Procedure: spGetPayrollRunByDate
 *
 *  Purpose:
 *    
 *
 *  Usage:  CALL spGetPayrollRunByDate('2023-06-01');
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-09
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  DECLARE runid INT;
  SELECT pr.PayrollRunId INTO runid
            FROM PayrollRuns pr
           WHERE pr.DateDeleted IS NULL
             AND pr.PayrollRunDate = pRunDate;

  IF ISNULL(runid) THEN
    CALL spAddPayrollRun (pRunDate, -1, @NewId);    
    SELECT @NewId as runid;
  ELSE
    SELECT runid;
  END IF;

END
$$
DELIMITER ;
    
