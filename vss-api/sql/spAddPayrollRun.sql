DELIMITER $$
DROP PROCEDURE IF EXISTS spAddPayrollRun
$$

CREATE PROCEDURE spAddPayrollRun (
  pPayrollRunDate DATETIME
 ,pLoginId        INT
 ,OUT oPayrollRunIdINT
)
/***********************************************************
 *  Procedure: spAddPayrollRun
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
  INSERT INTO PayrollRuns (PayrollRunDate, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollRunDate, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollRunId = LAST_INSERT_ID();
END
$$
DELIMITER ;

