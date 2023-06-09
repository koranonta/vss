DELIMITER $$
DROP PROCEDURE IF EXISTS spGetUsers
$$

CREATE PROCEDURE spGetUsers ()
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
    FROM Users;
END
$$
DELIMITER ;

