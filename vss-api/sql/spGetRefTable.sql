DELIMITER $$
DROP PROCEDURE IF EXISTS spGetRefTable
$$

CREATE PROCEDURE spGetRefTable ()
/***********************************************************
 *  Procedure: spGetRefTable
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
    FROM RefTable;
END
$$
DELIMITER ;

