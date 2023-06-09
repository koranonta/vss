DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateRefTable
$$

CREATE PROCEDURE spUpdateRefTable (
  pRefId       INT
 ,pRefTypeKind VARCHAR(10)
 ,pRefTypeName VARCHAR(100)
 ,pLoginId     INT
)
/***********************************************************
 *  Procedure: spUpdateRefTable
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
  UPDATE RefTable
     SET RefId        = pRefId
        ,RefTypeKind  = pRefTypeKind
        ,RefTypeName  = pRefTypeName
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
   WHERE RefId = pRefId
END
$$
DELIMITER ;

