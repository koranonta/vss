DELIMITER $$
DROP PROCEDURE IF EXISTS spGetDeductionById
$$

CREATE PROCEDURE spGetDeductionById (
  pDeductionId INT
)
/***********************************************************
 *  Procedure: spGetDeductionById
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
  SELECT DeductionId      as deductionid
        ,DeductionTypeId  as deductiontypeid
        ,DeductionName    as deductionname
    FROM Deductions
   WHERE DeductionId = pDeductionId
     AND DateDeleted IS NULL;
END
$$
DELIMITER ;

