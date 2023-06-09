DELIMITER $$
DROP PROCEDURE IF EXISTS spGetDeductionItems
$$

CREATE PROCEDURE spGetDeductionItems ()
/***********************************************************
 *  Procedure: spGetDeductionItems
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
    FROM DeductionItems;
END
$$
DELIMITER ;

