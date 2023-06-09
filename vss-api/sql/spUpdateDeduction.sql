DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateDeduction
$$

CREATE PROCEDURE spUpdateDeduction (
  pDeductionId     INT
 ,pDeductionTypeId INT
 ,pDeductionName   VARCHAR(100)
 ,pLoginId         INT
)
/***********************************************************
 *  Procedure: spUpdateDeduction
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
  UPDATE Deductions
     SET DeductionId      = pDeductionId
        ,DeductionTypeId  = pDeductionTypeId
        ,DeductionName    = pDeductionName
        ,DateModified     = Now()
        ,ModifiedBy       = pLoginId
   WHERE DeductionId = pDeductionId
END
$$
DELIMITER ;

