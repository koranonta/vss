DELIMITER $$
DROP PROCEDURE IF EXISTS spGetUsers
$$

CREATE PROCEDURE spGetUsers (
  pUserId INT
)
/***********************************************************
 *  Procedure: spGetUsers
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-06
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT u.UserId                as userid
        ,u.Name                  as name
        ,u.Password              as password
        ,u.Email                 as email
        ,u.Phone                 as phone
        ,u.RoleId                as roleid
        ,pt.PropertyTypeName     as rolename
        ,pt.PropertyTypeThaiName as rolethainame
        ,u.Image                 as image
    FROM Users u
   INNER JOIN PropertyTypes pt
      ON u.RoleId = pt.PropertyTypeId
   WHERE u.DateDeleted IS NULL
     AND (u.UserId = pUserId OR IF( pUserId <= 0, 1, 0) = 1);
END
$$
DELIMITER ;

