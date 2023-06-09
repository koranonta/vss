DELIMITER $$
DROP PROCEDURE IF EXISTS spDeleteAddresse
$$

CREATE PROCEDURE spDeleteAddresse (
  pAddressId INT
)
/***********************************************************
 *  Procedure: spDeleteAddresse
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
  DELETE FROM Addresses WHERE AddressId = pAddressId;
END
$$
DELIMITER ;

