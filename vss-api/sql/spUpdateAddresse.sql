DELIMITER $$
DROP PROCEDURE IF EXISTS spUpdateAddresse
$$

CREATE PROCEDURE spUpdateAddresse (
  pAddressId   INT
 ,pEmployeeId  INT
 ,pAddress     VARCHAR(100)
 ,pSubDistrict VARCHAR(100)
 ,pDistrict    VARCHAR(100)
 ,pStreet      VARCHAR(255)
 ,pProvince    VARCHAR(100)
 ,pCity        VARCHAR(100)
 ,pPostCode    VARCHAR(20)
 ,pCountry     VARCHAR(100)
 ,pLoginId     INT
)
/***********************************************************
 *  Procedure: spUpdateAddresse
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
  UPDATE Addresses
     SET AddressId    = pAddressId
        ,EmployeeId   = pEmployeeId
        ,Address      = pAddress
        ,SubDistrict  = pSubDistrict
        ,District     = pDistrict
        ,Street       = pStreet
        ,Province     = pProvince
        ,City         = pCity
        ,PostCode     = pPostCode
        ,Country      = pCountry
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
   WHERE AddressId = pAddressId
END
$$
DELIMITER ;

