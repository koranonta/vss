DELIMITER $$
DROP PROCEDURE IF EXISTS spGetAddressesByEmployeeId
$$

CREATE PROCEDURE spGetAddressesByEmployeeId (
  pEmployeeId INT
)
/***********************************************************
 *  Procedure: spGetAddressesByEmployeeId
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-08
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT AddressId      as addressid
        ,EmployeeId     as employeeid
        ,Address        as address
        ,SubDistrict    as subdistrict
        ,District       as district
        ,Street         as street
        ,City           as city
        ,Province       as province
        ,Country        as country
        ,PostCode       as postcode
    FROM Addresses
   WHERE DateDeleted IS NULL
     AND (EmployeeId = pEmployeeId);
END
$$
DELIMITER ;

