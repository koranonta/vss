DELIMITER $$
DROP PROCEDURE IF EXISTS spGetUserById
$$

CREATE PROCEDURE spGetUserById (
  pUserId INT
)
/***********************************************************
 *  Procedure: spGetUserById
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
  SELECT UserId        as userid
        ,Name          as name
        ,Password      as password
        ,Email         as email
        ,Phone         as phone
        ,UserTypeId    as usertypeid
        ,Image         as image
    FROM Users
   WHERE UserId = pUserId;
END
$$
DELIMITER ;

