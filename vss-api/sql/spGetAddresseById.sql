DELIMITER $$
DROP PROCEDURE IF EXISTS spGetAddresseById
$$

CREATE PROCEDURE spGetAddresseById (
  pAddressId INT
)
/***********************************************************
 *  Procedure: spGetAddresseById
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
  SELECT AddressId    as addressid
        ,EmployeeId   as employeeid
        ,Address      as address
        ,SubDistrict  as subdistrict
        ,District     as district
        ,Street       as street
        ,Province     as province
        ,City         as city
        ,PostCode     as postcode
        ,Country      as country
    FROM Addresses
   WHERE AddressId = pAddressId;
END
$$
DELIMITER ;

