<?php
require_once('db.classes.php');

class PayrollTransactions extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetPayrollTransactions(-1)";
    return $this->runQuery($query);
  }

  function getById( $payrolltransactionid )
  {
    $query = "CALL spGetPayrollTransactions( ${payrolltransactionid} )";
    return $this->runQuery($query);
  }

  function add( $payrolltransaction )
  {
    try {
      $query = "CALL spAddPayrollTransaction( :payrollrunid, :employeeid, :deductionid, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrollrunid', $payrolltransaction['payrollrunid']);
      $stmt->bindParam(':employeeid', $payrolltransaction['employeeid']);
      $stmt->bindParam(':deductionid', $payrolltransaction['deductionid']);
      $stmt->bindParam(':loginid', $payrolltransaction['loginid']);
      $stmt->execute();
      $stmt->closeCursor();
      $row = $this->pdo->query("SELECT @newId as newId")->fetch(PDO::FETCH_ASSOC);
	    if (isset($row['newId'])):
	      return $this->getById($row['newId']);
	    endif;
	    return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }
  function update( $payrolltransaction )
  {
    try {
      $query = "CALL spUpdatePayrollTransaction( :payrolltransactionid, :payrollrunid, :employeeid, :deductionid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrolltransactionid', $payrolltransaction['payrolltransactionid']);
      $stmt->bindParam(':payrollrunid', $payrolltransaction['payrollrunid']);
      $stmt->bindParam(':employeeid', $payrolltransaction['employeeid']);
      $stmt->bindParam(':deductionid', $payrolltransaction['deductionid']);
      $stmt->bindParam(':loginid', $payrolltransaction['loginid']);
      if ($stmt->execute()):
        return $this->getById($payrolltransaction['payrolltransactionid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $payrolltransactionid, $loginid )
  {
    try {
      $query = "CALL spDeletePayrollTransaction( :payrolltransactionid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrolltransactionid', $payrolltransactionid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
