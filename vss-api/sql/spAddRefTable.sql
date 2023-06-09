DELIMITER $$
DROP PROCEDURE IF EXISTS spAddRefTable
$$

CREATE PROCEDURE spAddRefTable (
  pRefTypeKind VARCHAR(10)
 ,pRefTypeName VARCHAR(100)
 ,pLoginId     INT
 ,OUT oRefId   INT
)
/***********************************************************
 *  Procedure: spAddRefTable
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
  INSERT INTO RefTable (RefTypeKind, RefTypeName, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pRefTypeKind, pRefTypeName, Now(), Now(), pLoginId, pLoginId);
  SET oRefId = LAST_INSERT_ID();
END
$$
DELIMITER ;

