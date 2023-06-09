<?php
require_once('db.classes.php');

class PayrollTransactions extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetPayrollTransactions()';
    return $this->runQuery($query);
  }

  function getById(( $payrolltransactionid ))
  {
    $query = 'CALL spGetPayrollTransactionById( $payrolltransactionid )';
    return $this->runQuery($query);
  }

  function delete( $payrolltransactionid )
  {
    $query = 'CALL spDeletePayrollTransaction( :payrolltransactionid )';
    $stmt->bindParam(':payrolltransactionid', payrolltransactionid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $payrolltransaction )
  {
    $query = 'CALL spUpdatePayrollTransaction( :payrollrunid, :employeeid, :deductionid, :loginid )';
    $stmt->bindParam(':payrollrunid', $payrolltransaction['payrollrunid']);
    $stmt->bindParam(':employeeid', $payrolltransaction['employeeid']);
    $stmt->bindParam(':deductionid', $payrolltransaction['deductionid']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $payrolltransaction )
  {
    $query = 'CALL spAddPayrollTransaction( :payrollrunid, :employeeid, :deductionid, :loginid, @newId )';
    $stmt->bindParam(':payrollrunid', $payrolltransaction['payrollrunid']);
    $stmt->bindParam(':employeeid', $payrolltransaction['employeeid']);
    $stmt->bindParam(':deductionid', $payrolltransaction['deductionid']);
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
