DELIMITER $$
DROP PROCEDURE IF EXISTS spAddAddresse
$$

CREATE PROCEDURE spAddAddresse (
  pEmployeeId  INT
 ,pAddress     VARCHAR(100)
 ,pSubDistrict VARCHAR(100)
 ,pDistrict    VARCHAR(100)
 ,pStreet      VARCHAR(255)
 ,pProvince    VARCHAR(100)
 ,pCity        VARCHAR(100)
 ,pPostCode    VARCHAR(20)
 ,pCountry     VARCHAR(100)
 ,pLoginId     INT
 ,OUT oAddressIdINT
)
/***********************************************************
 *  Procedure: spAddAddresse
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
  INSERT INTO Addresses (EmployeeId, Address, SubDistrict, District, Street, Province, City, PostCode, Country, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pEmployeeId, pAddress, pSubDistrict, pDistrict, pStreet, pProvince, pCity, pPostCode, pCountry, Now(), Now(), pLoginId, pLoginId);
  SET oAddressId = LAST_INSERT_ID();
END
$$
DELIMITER ;

