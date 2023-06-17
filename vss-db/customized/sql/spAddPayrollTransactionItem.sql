DELIMITER $$
DROP PROCEDURE IF EXISTS spAddPayrollTransactionItem
$$

CREATE PROCEDURE spAddPayrollTransactionItem (
  pPayrollTransactionId         INT
 ,pPropertyTypeId               INT
 ,pAmount                       FLOAT
 ,pLoginId                      INT
 ,OUT oPayrollTransactionItemId INT
)
/***********************************************************
 *  Procedure: spAddPayrollTransactionItem
 *
 *  Purpose:
 *    
 *
 *  Usage:
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-15
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN  
  DELETE 
    FROM PayrollTransactionItems
   WHERE PayrollTransactionId = pPayrollTransactionId
     AND PropertyTypeId       = pPropertyTypeId;

  SET pLoginId = IFNULL(pLoginId, -1);
  INSERT INTO PayrollTransactionItems (PayrollTransactionId, PropertyTypeId, Amount, DateCreated, DateModified, CreatedBy, ModifiedBy)
    VALUES(pPayrollTransactionId, pPropertyTypeId, pAmount, Now(), Now(), pLoginId, pLoginId);
  SET oPayrollTransactionItemId = LAST_INSERT_ID();
END
$$
DELIMITER ;
