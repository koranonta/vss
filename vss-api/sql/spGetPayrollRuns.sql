DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollRuns
$$

CREATE PROCEDURE spGetPayrollRuns ()
/***********************************************************
 *  Procedure: spGetPayrollRuns
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
    FROM PayrollRuns;
END
$$
DELIMITER ;

