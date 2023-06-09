DELIMITER $$

DROP PROCEDURE IF EXISTS spAddOrder$$
CREATE PROCEDURE spAddOrder (
  pClientId    INT, 
  pTotalItems  INT, 
  pTotalAmount FLOAT, 
  pLoginId     INT, 
  OUT oOrderId INT
)
/***********************************************************
 *  Procedure: spAddOrder
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Orders (ClientId, OrderDate, StatusId, TotalItems, TotalAmount, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pClientId, Now(), 1, pTotalItems, pTotalAmount, Now(), Now(), pLoginId, pLoginId);
  SET oOrderId = LAST_INSERT_ID();
END$$

DROP PROCEDURE IF EXISTS spAddOrderItem$$
CREATE PROCEDURE spAddOrderItem (
  pOrderId   INT, 
  pProductId INT, 
  pQuantity  INT, 
  pPrice     FLOAT, 
  pLoginId   INT
)
/***********************************************************
 *  Procedure: spAddOrderItem
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pOrderId, pProductId, pQuantity, pPrice, Now(), Now(), pLoginId, pLoginId);
END$$

DROP PROCEDURE IF EXISTS spAddProduct$$
CREATE PROCEDURE spAddProduct (
  pCategoryId  INT, 
  pTitle       VARCHAR(100), 
  pDescription VARCHAR(500), 
  pUnit        VARCHAR(100), 
  pImage       VARCHAR(100), 
  pPrice       FLOAT, 
  pStartDate   DATETIME, 
  pLoginId     INT, 
  OUT oProdId  INT
)
/***********************************************************
 *  Procedure: spAddProduct
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);  
  START TRANSACTION;
    INSERT INTO Products (CategoryId, Title, Description, Unit, Image, DateCreated, DateModified, CreatedBy, ModifiedBy)
      VALUES(pCategoryId, pTitle, pDescription, pUnit, pImage, Now(), Now(), pLoginId, pLoginId);
    SET oProdId = LAST_INSERT_ID();	 	  
    INSERT INTO ProductPrices (ProductId, Price, StartDate, EndDate, DateCreated, DateModified, CreatedBy, ModifiedBy)
      VALUES(oProdId, pPrice, pStartDate, '2099-12-31 23:59:59', Now(), Now(), pLoginId, pLoginId);
  COMMIT;
END$$


DROP PROCEDURE IF EXISTS spAddUser$$
CREATE PROCEDURE spAddUser (
  pName       VARCHAR(100), 
  pPassword   VARCHAR(100), 
  pEmail      VARCHAR(100), 
  pPhone      VARCHAR(100), 
  pRoleId     INT, 
  pImage      VARCHAR(100), 
  pLoginId    INT, 
  OUT oUserId INT
)   
/***********************************************************
 *  Procedure: spAddUser
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Users (Name, Password, Email, Phone, RoleId, Image, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pName, pPassword, pEmail, pPhone, pRoleId, pImage, Now(), Now(), pLoginId, pLoginId);
  SET oUserId = LAST_INSERT_ID();    
END$$

DROP PROCEDURE IF EXISTS spDeleteOrder$$
CREATE PROCEDURE spDeleteOrder (
  pOrderId INT
 ,pLoginId INT
)   
/***********************************************************
 *  Procedure: spDeleteOrder
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/  
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Orders
    SET DateDeleted = GetDate()
	   ,DeletedBy   = pLoginId    
   WHERE OrderId = pOrderId;
END$$


DROP PROCEDURE IF EXISTS spDeleteOrderItem$$
CREATE PROCEDURE spDeleteOrderItem (
  pOrderId INT
 ,pLoginId     INT
)   
 /***********************************************************
 *  Procedure: spDeleteOrderItem
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/  
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE OrderItems
     SET DateDeleted = GetDate()
	    ,DeletedBy   = pLoginId
   WHERE OrderId = pOrderId;
END$$

DROP PROCEDURE IF EXISTS spGetOrderItemsByOrderId$$
CREATE PROCEDURE spGetOrderItemsByOrderId (
  pOrderId INT
)
 /***********************************************************
 *  Procedure: spGetOrderItemsByOrderId
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/  
BEGIN
  SELECT 
    o.OrderId            as orderid
   ,o.OrderItemId        as orderitemid
   ,o.ProductId          as productid
   ,p.Title              as productname
   ,p.Image              as image
   ,o.Quantity           as quantity
   ,o.Price              as price
   ,o.Quantity * o.Price as amount
  FROM OrderItems o
  INNER JOIN Products p 
     ON o.ProductId = p.ProductId
  WHERE OrderId = pOrderId;
END$$

DROP PROCEDURE IF EXISTS spGetOrders$$
CREATE PROCEDURE spGetOrders (
  pStatusId INT
)
 /***********************************************************
 *  Procedure: spGetOrders
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT 
    o.OrderId     as orderid
   ,o.ClientId    as clientid
   ,u.Name        as clientname
   ,o.OrderDate   as orderdate
   ,o.StatusId    as statusid
   ,os.StatusName as statusname
   ,o.TotalItems  as totalitems
   ,o.TotalAmount as totalamount
  FROM Orders o
  LEFT JOIN Users u
    ON o.ClientId = u.UserId
  LEFT JOIN OrderStatus os
    ON o.StatusId = os.StatusId
  WHERE o.StatusId = pStatusId
     OR IF(pStatusId <= 0 , 1, 0) = 1
  ORDER BY o.OrderDate DESC;
END$$


DROP PROCEDURE IF EXISTS spGetOrdersByClientId$$
CREATE PROCEDURE spGetOrdersByClientId (
  pClientId INT
)   
 /***********************************************************
 *  Procedure: spGetOrdersByClientId
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT 
     o.OrderId     as orderid
    ,o.ClientId    as clientid
    ,u.Name        as clientname
    ,o.OrderDate   as orderdate
    ,o.StatusId    as statusid
    ,os.StatusName as statusname    
    ,o.TotalItems  as totalitems
    ,o.TotalAmount as totalamount
  FROM Orders o
  LEFT JOIN Users u
    ON o.ClientId = u.UserId
  LEFT JOIN OrderStatus os
    ON o.StatusId = os.StatusId    
  WHERE o.ClientId = pClientId
  ORDER BY o.OrderDate DESC;
END$$

DROP PROCEDURE IF EXISTS spGetProductById$$
CREATE PROCEDURE spGetProductById (
  pProductId INT
)   
 /***********************************************************
 *  Procedure: spGetProductById
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT
    c.CategoryName as categoryname
   ,p.Title        as title
   ,p.Description  as description
   ,p.Unit         as unit
   ,pp.Price       as price
   ,p.Image        as image
   ,p.ProductId    as productid
   ,p.CategoryId   as categoryid
  FROM Products p
  LEFT JOIN ProductPrices pp ON p.ProductId = pp.ProductId
  LEFT JOIN Categories c ON p.CategoryId = c.CategoryId
  WHERE p.DateDeleted  IS NULL
    AND pp.DateDeleted IS NULL
    AND p.ProductId = pProductId;
END$$


DROP PROCEDURE IF EXISTS spGetProducts$$
CREATE PROCEDURE spGetProducts ()   
 /***********************************************************
 *  Procedure: spGetProducts
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT
    c.CategoryName as categoryname
   ,p.Title        as title
   ,p.Description  as description
   ,p.Unit         as unit
   ,pp.Price       as price
   ,p.Image        as image
   ,p.ProductId    as productid
   ,p.CategoryId   as categoryid
   FROM Products p
   LEFT JOIN ProductPrices pp ON p.ProductId = pp.ProductId
   LEFT JOIN Categories c ON p.CategoryId = c.CategoryId
  WHERE p.DateDeleted  IS NULL
    AND pp.DateDeleted IS NULL
  ORDER BY p.ProductId;
END$$

DROP PROCEDURE IF EXISTS spGetUserById$$
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
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT u.UserId    as userid
        ,u.Name      as name
        ,u.Password  as password
        ,u.Email     as email
        ,u.Phone     as phone
        ,u.Image     as image
        ,u.PushToken as pushtoken		
        ,u.RoleId    as roleid		
        ,r.RoleType  as roletype
    FROM Users u
    LEFT JOIN Roles r
      ON u.RoleId = r.RoleId
   WHERE u.UserId = pUserId
     AND u.DateDeleted IS NULL;
END$$


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
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT u.UserId    as userid
        ,u.Name      as name
        ,u.Password  as password
        ,u.Email     as email
        ,u.Phone     as phone
        ,u.Image     as image
		,u.PushToken as pushtoken		
        ,u.RoleId    as roleid
        ,r.RoleType  as roletype
    FROM Users u
    LEFT JOIN Roles r
      ON u.RoleId = r.RoleId
   WHERE u.DateDeleted IS NULL
     AND u.Name = pIdentifier;
     /*AND (u.Name = pIdentifier OR u.Email = pIdentifier OR u.Phone = pIdentifier) */
END$$

DROP PROCEDURE IF EXISTS spGetUsers$$
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
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT u.UserId    as userid
        ,u.Name      as name
        ,u.Password  as password
        ,u.Email     as email
        ,u.Phone     as phone
        ,u.Image     as image
		,u.PushToken as pushtoken		
        ,u.RoleId    as roleid
        ,r.RoleType  as roletype
    FROM Users u
    LEFT JOIN Roles r
      ON u.RoleId = r.RoleId
   WHERE u.DateDeleted IS NULL;
END$$

DROP PROCEDURE IF EXISTS spSetUserPushToken$$
CREATE PROCEDURE spSetUserPushToken (
  pUserId INT, 
  pPushToken VARCHAR(255), 
  pLoginId INT
)   
 /***********************************************************
 *  Procedure: spSetUserPushToken
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET PushToken    = pPushToken
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
   WHERE UserId = pUserId;
END$$

DROP PROCEDURE IF EXISTS spUpdateOrderStatus$$
CREATE PROCEDURE spUpdateOrderStatus (
  pOrderId  INT, 
  pStatusId INT, 
  pLoginId  INT
)   
 /***********************************************************
 *  Procedure: spUpdateOrderStatus
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 

BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Orders
     SET StatusId     = pStatusId
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
   WHERE OrderId = pOrderId;
END$$

DROP PROCEDURE IF EXISTS spUpdateOrderItem$$
CREATE PROCEDURE spUpdateOrderItem (
  pOrderItemId INT, 
  pProductId INT, 
  pQuantity INT, 
  pPrice FLOAT, 
  pLoginId INT
)
 /***********************************************************
 *  Procedure: spUpdateOrderItem
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE OrderItems
     SET ProductId    = pProductId
        ,Quantity     = pQuantity
        ,Price        = pPrice
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
  WHERE OrderItemId   = pOrderItemId;
END$$

DROP PROCEDURE IF EXISTS spUpdateProductProperties$$
CREATE PROCEDURE spUpdateProductProperties (
  pProductId      INT, 
  pPropertyTypeId INT, 
  pLoginId        INT
)
 /***********************************************************
 *  Procedure: spUpdateProductProperties
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  DECLARE ProductPropertyId INT;
  SET pLoginId = IFNULL(pLoginId, -1);
  
  DELETE FROM ProductProperties 
   WHERE ProductId = pProductId;
   
  IF pPropertyTypeId <> -1 THEN
	INSERT INTO ProductProperties (ProductId, PropertyTypeId, PropertyValue, DateCreated, DateModified, CreatedBy, ModifiedBy) 
	  VALUES (pProductId, pPropertyTypeId, 'T', Now(), Now(), pLoginId, pLoginId);
  END IF;	  
END$$

DROP PROCEDURE IF EXISTS spUpdateUser$$
CREATE PROCEDURE spUpdateUser (
  pUserId   INT, 
  pName     VARCHAR(100), 
  pPassword VARCHAR(100), 
  pEmail    VARCHAR(100), 
  pPhone    VARCHAR(100), 
  pRoleId   INT, 
  pImage    VARCHAR(100), 
  pLoginId  INT
) 
 /***********************************************************
 *  Procedure: spUpdateUser
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Users
     SET UserId       = pUserId
        ,Name         = pName
        ,Password     = pPassword
        ,Email        = pEmail
        ,Phone        = pPhone
        ,RoleId       = pRoleId
        ,Image        = pImage
        ,DateModified = Now()
        ,ModifiedBy   = pLoginId
   WHERE UserId = pUserId;
END$$

DROP PROCEDURE IF EXISTS spGetProductProperties$$
CREATE PROCEDURE spGetProductProperties (
  pProductId INT
)
 /***********************************************************
 *  Procedure: spGetProductProperties
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/    
BEGIN
  SELECT
    ProductPropertyId as productpropertyid,
	ProductId         as productid,
	PropertyTypeId    as propertytypeid,
	PropertyValue     as propertyvalue
  FROM ProductProperties
 WHERE DateDeleted IS NULL
   AND (ProductId = pProductId OR IF(pProductId <= 0 , 1, 0) = 1);
END
$$



DROP PROCEDURE IF EXISTS spGetAddressByUserId$$
CREATE PROCEDURE spGetAddressByUserId (
  pUserId        INT
 ,pAddressTypeId INT
)
 /***********************************************************
 *  Procedure: spGetAddressByUserId
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/ 
BEGIN
  SELECT Street1        as street1
        ,Street2        as street2
        ,District       as district
        ,City           as city
        ,PostCode       as postcode
        ,Country        as country
    FROM Addresses
   WHERE UserId = pUserId
     AND AddressTypeId = pAddressTypeId
     AND DateDeleted IS NULL;
END$$

DROP PROCEDURE IF EXISTS spAddAddress$$
CREATE PROCEDURE spAddAddress (
  pUserId        INT
 ,pAddressTypeId INT 
 ,pStreet1       VARCHAR(255)
 ,pStreet2       VARCHAR(255)
 ,pDistrict      VARCHAR(255)
 ,pCity          VARCHAR(100)
 ,pPostCode      VARCHAR(20)
 ,pCountry       VARCHAR(100)
 ,pLoginId       INT
 ,OUT oAddressId INT
)
/***********************************************************
 *  Procedure: spAddAddress
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO Addresses (UserId, AddressTypeId, Street1, Street2, District, City, PostCode, Country, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pUserId, pAddressTypeId, pStreet1, pStreet2, pDistrict, pCity, pPostCode, pCountry, Now(), Now(), pLoginId, pLoginId);
  SET oAddressId = LAST_INSERT_ID();    
END
$$


DROP PROCEDURE IF EXISTS spUpdateAddress$$
CREATE PROCEDURE spUpdateAddress (
  pUserId        INT
 ,pAddressTypeId INT 
 ,pStreet1       VARCHAR(255)
 ,pStreet2       VARCHAR(255)
 ,pDistrict      VARCHAR(255)
 ,pCity          VARCHAR(100)
 ,pPostCode      VARCHAR(20)
 ,pCountry       VARCHAR(100) 
 ,pLoginId       INT
)
/***********************************************************
 *  Procedure: spUpdateAddress
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Addresses
     SET AddressTypeId = pAddressTypeId
        ,Street1       = pStreet1
        ,Street2       = pStreet2
        ,District      = pDistrict
        ,City          = pCity
        ,PostCode      = pPostCode
        ,Country       = pCountry
        ,DateModified  = Now()
        ,ModifiedBy    = pLoginId
  WHERE UserId = pUserId
    AND AddressTypeId = pAddressTypeId;  
END
$$


DROP PROCEDURE IF EXISTS spDeleteAddress$$
CREATE PROCEDURE spDeleteAddress (
  pUserId        INT
 ,pAddressTypeId INT 
 ,pLoginId       INT
)
/***********************************************************
 *  Procedure: spDeleteAddress
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-04-13
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SET pLoginId = IFNULL(pLoginId, -1);
  UPDATE Addresses
     SET DateDeleted = Now()
        ,DeletedBy   = pLoginId
  WHERE UserId = pUserId
    AND AddressTypeId = pAddressTypeId;  
END
$$

DELIMITER ;

