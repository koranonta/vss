DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteDeductionItem
$$

CREATE PROCEDURE spDeleteDeductionItem (
  pDeductionItemId INT
)
/***********************************************************
 *  Procedure: spDeleteDeductionItem
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
  DELETE FROM DeductionItems WHERE DeductionItemId = pDeductionItemId;
END
$$
DELIMITER ;

