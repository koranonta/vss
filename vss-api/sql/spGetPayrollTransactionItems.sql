DELIMITER $$
DROP PROCEDURE IF EXISTS spGetPayrollTransactionItems
$$

CREATE PROCEDURE spGetPayrollTransactionItems ()
/***********************************************************
 *  Procedure: spGetPayrollTransactionItems
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
    FROM PayrollTransactionItems;
END
$$
DELIMITER ;

