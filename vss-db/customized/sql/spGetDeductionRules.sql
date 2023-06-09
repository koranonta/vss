DELIMITER $$
DROP PROCEDURE IF EXISTS spGetDeductionRules
$$

CREATE PROCEDURE spGetDeductionRules(
  pDeductionId INT
)
/***********************************************************
 *  Procedure: spGetDeductionRules
 *
 *  Purpose:
 *    
 *
 *  Usage:  CALL spGetDeductionRules(-1);
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-04
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT dh.DeductionId          as deductionid
        ,dh.DeductionName        as deductionname
        ,dh.DeductionThaiName    as deductionthainame
        ,di.DeductionItemId      as deductionitemid
        ,di.PropertyTypeId       as propertytypeid
        ,pt.PropertyTypeGroupId  as propertytypegroupid
        ,pt.PropertyTypeName     as propertytypename
        ,pt.PropertyTypeThaiName as propertytypethainame
        ,pt.Alias                as alias
        ,pt.AllowableValues      as allowablevalues
    FROM DeductionItems di
   INNER JOIN Deductions dh
      ON di.DeductionId = dh.DeductionId
   INNER JOIN PropertyTypes pt
      ON di.PropertyTypeId = pt.PropertyTypeId
   WHERE di.DateDeleted IS NULL
     AND dh.DateDeleted IS NULL
     AND (di.DeductionId = pDeductionId OR IF( pDeductionId <= 0, 1, 0) = 1);
END
$$
DELIMITER ;

