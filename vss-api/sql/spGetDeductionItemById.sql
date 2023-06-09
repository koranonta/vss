DELIMITER $$
DROP PROCEDURE IF EXISTS spGetDeductionItemById
$$

CREATE PROCEDURE spGetDeductionItemById (
  pDeductionId INT
)
/***********************************************************
 *  Procedure: spGetDeductionItemById
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
  SELECT DeductionItemId    as deductionitemid
        ,DeductionId        as deductionid
        ,DeductionName      as deductionname
        ,DeductionThaiName  as deductionthainame
        ,Value              as value
    FROM DeductionItems
   WHERE DeductionId = pDeductionId
     AND DateDeleted IS NULL;
END
$$
DELIMITER ;

