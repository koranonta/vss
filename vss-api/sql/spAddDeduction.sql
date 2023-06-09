DELIMITER $$
DROP PROCEDURE IF EXISTS spAddDeduction
$$

CREATE PROCEDURE spAddDeduction (
  pDeductionTypeId INT
 ,pDeductionName   VARCHAR(100)
 ,pLoginId         INT
 ,OUT oDeductionId INT
)
/***********************************************************
 *  Procedure: spAddDeduction
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
  INSERT INTO Deductions (DeductionTypeId, DeductionName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionTypeId, pDeductionName, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionId = LAST_INSERT_ID();
END
$$
DELIMITER ;

