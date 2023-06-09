DELIMITER $$
DROP PROCEDURE IF EXISTS spGetRefTableById
$$

CREATE PROCEDURE spGetRefTableById (
  pRefId INT
)
/***********************************************************
 *  Procedure: spGetRefTableById
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
  SELECT RefId        as refid
        ,RefTypeKind  as reftypekind
        ,RefTypeName  as reftypename
    FROM RefTable
   WHERE RefId = pRefId;
END
$$
DELIMITER ;

