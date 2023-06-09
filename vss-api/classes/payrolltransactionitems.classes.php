<?php
require_once('db.classes.php');

class PayrollTransactionItems extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetPayrollTransactionItems()';
    return $this->runQuery($query);
  }

  function getById(( $payrolltransactionitemid ))
  {
    $query = 'CALL spGetPayrollTransactionItemById( $payrolltransactionitemid )';
    return $this->runQuery($query);
  }

  function delete( $payrolltransactionitemid )
  {
    $query = 'CALL spDeletePayrollTransactionItem( :payrolltransactionitemid )';
    $stmt->bindParam(':payrolltransactionitemid', payrolltransactionitemid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $payrolltransactionitem )
  {
    $query = 'CALL spUpdatePayrollTransactionItem( :payrolltransactionid, :deductionitemid, :amount, :loginid )';
    $stmt->bindParam(':payrolltransactionid', $payrolltransactionitem['payrolltransactionid']);
    $stmt->bindParam(':deductionitemid', $payrolltransactionitem['deductionitemid']);
    $stmt->bindParam(':amount', $payrolltransactionitem['amount']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $payrolltransactionitem )
  {
    $query = 'CALL spAddPayrollTransactionItem( :payrolltransactionid, :deductionitemid, :amount, :loginid, @newId )';
    $stmt->bindParam(':payrolltransactionid', $payrolltransactionitem['payrolltransactionid']);
    $stmt->bindParam(':deductionitemid', $payrolltransactionitem['deductionitemid']);
    $stmt->bindParam(':amount', $payrolltransactionitem['amount']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) {
      $stmt->closeCursor();
      $row = $this->pdo->query("SELECT @newId as newId")->fetch(PDO::FETCH_ASSOC);
      echo $row;
      if ($row) 
        return $row !== false ? $row['newId'] : null;
      return null;
    }
    else return 0;
  }
}
