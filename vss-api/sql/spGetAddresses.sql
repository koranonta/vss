DELIMITER $$
DROP PROCEDURE IF EXISTS spGetAddresses
$$

CREATE PROCEDURE spGetAddresses ()
/***********************************************************
 *  Procedure: spGetAddresses
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
    FROM Addresses;
END
$$
DELIMITER ;

