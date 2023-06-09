DELIMITER $$
DROP PROCEDURE IF EXISTS spDeletePayrollRun
$$

CREATE PROCEDURE spDeletePayrollRun (
  pPayrollRunId INT
)
/***********************************************************
 *  Procedure: spDeletePayrollRun
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   @@AUTHOR@@     2023-05-27
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  DELETE FROM PayrollRuns WHERE PayrollRunId = pPayrollRunId;
END
$$
DELIMITER ;

