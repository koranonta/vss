DELIMITER $$

-- spAddPropertyType.sql
DROP PROCEDURE IF EXISTS spGetPropertyTypeByGroups
$$
CREATE PROCEDURE spGetPropertyTypeByGroups(
  pPropertyTypeGroupId INT 
)
/***********************************************************
 *  Procedure: spGetPropertyTypeByGroupId
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spGetPropertyTypeByGroups( -1 );
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-03
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT pt.PropertyTypeGroupId       as propertytypegroupid
        ,pg.PropertyTypeGroupName     as propertytypegroupname
        ,pg.PropertyTypeGroupThaiName as propertytypeGroupthainame
        ,pt.PropertyTypeId            as propertytypeid
        ,pt.PropertyTypeName          as propertytypename
        ,pt.PropertyTypeThaiName      as propertytypethainame
        ,pt.Alias                     as alias
        ,pt.AllowableValues           as allowablevalues
    FROM PropertyTypes pt
   INNER JOIN PropertyTypeGroups pg
      ON pt.PropertyTypeGroupId = pg.PropertyTypeGroupId
   WHERE pt.DateDeleted IS NULL
     AND pg.DateDeleted IS NULL
     AND (pt.PropertyTypeGroupId = pPropertyTypeGroupId OR IF( pPropertyTypeGroupId <= 0, 1, 0) = 1);
END
$$
DELIMITER ;
