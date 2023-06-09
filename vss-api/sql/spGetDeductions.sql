DELIMITER $$
DROP PROCEDURE IF EXISTS spGetDeductions
$$

CREATE PROCEDURE spGetDeductions ()
/***********************************************************
 *  Procedure: spGetDeductions
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
    FROM Deductions;
END
$$
DELIMITER ;

