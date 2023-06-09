DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteRefTable
$$

CREATE PROCEDURE spDeleteRefTable (
  pRefId INT
)
/***********************************************************
 *  Procedure: spDeleteRefTable
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   @@AUTHOR@@     2023-05-27
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  DELETE FROM RefTable WHERE RefId = pRefId;
END
$$
DELIMITER ;

