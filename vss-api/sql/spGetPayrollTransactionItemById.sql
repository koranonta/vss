DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollTransactionItemById
$$

CREATE PROCEDURE spGetPayrollTransactionItemById (
  pPayrollTransactionItemId INT
)
/***********************************************************
 *  Procedure: spGetPayrollTransactionItemById
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
  SELECT PayrollTransactionItemId  as payrolltransactionitemid
        ,PayrollTransactionId      as payrolltransactionid
        ,DeductionItemId           as deductionitemid
        ,Amount                    as amount
    FROM PayrollTransactionItems
   WHERE PayrollTransactionItemId = pPayrollTransactionItemId;
END
$$
DELIMITER ;

