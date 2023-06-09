DELIMITER $$
DROP PROCEDURE IF EXISTS spAddDeductionItem
$$

CREATE PROCEDURE spAddDeductionItem (
  pDeductionId         INT
 ,pDeductionName       VARCHAR(50)
 ,pDeductionThaiName   VARCHAR(50)
 ,pValue               VARCHAR(50)
 ,pLoginId             INT
 ,OUT oDeductionItemId INT
)
/***********************************************************
 *  Procedure: spAddDeductionItem
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
  INSERT INTO DeductionItems (DeductionId, DeductionName, DeductionThaiName, Value, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pDeductionId, pDeductionName, pDeductionThaiName, pValue, Now(), Now(), pLoginId, pLoginId);
  SET oDeductionItemId = LAST_INSERT_ID();
END
$$
DELIMITER ;

