DELIMITER $$

DROP PROCEDURE IF EXISTS spGetUserByIdentifier$$
CREATE PROCEDURE spGetUserByIdentifier (
  pIdentifier VARCHAR(100)
)
 /***********************************************************
 *  Procedure: spGetUserByIdentifier
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spGetUserByIdentifier('kora')
 *         CALL spGetUserByIdentifier('kora@gmail.com')
 *         CALL spGetUserByIdentifier('0639789149')
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT u.UserId           as userid
        ,u.Name             as name
        ,u.Password         as password
        ,u.Email            as email
        ,u.Phone            as phone
        ,u.Image            as image
        ,u.RoleId           as roleid
        ,p.PropertyTypeName as roletype
    FROM Users u
    LEFT JOIN PropertyTypes p
      ON u.RoleId = p.PropertyTypeId
   WHERE u.DateDeleted IS NULL
     AND (u.Name = pIdentifier OR u.Email = pIdentifier OR u.Phone = pIdentifier); 
END$$

DELIMITER ;
