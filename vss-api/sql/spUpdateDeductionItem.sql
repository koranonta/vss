DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateDeductionItem
$$

CREATE PROCEDURE spUpdateDeductionItem (
  pDeductionItemId   INT
 ,pDeductionId       INT
 ,pDeductionName     VARCHAR(50)
 ,pDeductionThaiName VARCHAR(50)
 ,pValue             VARCHAR(50)
 ,pLoginId           INT
)
/***********************************************************
 *  Procedure: spUpdateDeductionItem
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
  UPDATE DeductionItems
     SET DeductionItemId    = pDeductionItemId
        ,DeductionId        = pDeductionId
        ,DeductionName      = pDeductionName
        ,DeductionThaiName  = pDeductionThaiName
        ,Value              = pValue
        ,DateModified       = Now()
        ,ModifiedBy         = pLoginId
   WHERE DeductionItemId = pDeductionItemId
END
$$
DELIMITER ;

