<?php
require_once('db.classes.php');

class PayrollRuns extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetPayrollRuns(-1)";
    return $this->runQuery($query);
  }

  function getById( $payrollrunid )
  {
    $query = "CALL spGetPayrollRuns( ${payrollrunid} )";
    return $this->runQuery($query);
  }

  function add( $payrollrun )
  {
    try {
      echo ($payrollrun);
      $query = "CALL spAddPayrollRun( :payrollrundate, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrollrundate', $payrollrun['payrollrundate']);
      $stmt->bindParam(':loginid', $payrollrun['loginid']);
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
  function update( $payrollrun )
  {
    try {
      $query = "CALL spUpdatePayrollRun( :payrollrunid, :payrollrundate, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrollrunid', $payrollrun['payrollrunid']);
      $stmt->bindParam(':payrollrundate', $payrollrun['payrollrundate']);
      $stmt->bindParam(':loginid', $payrollrun['loginid']);
      if ($stmt->execute()):
        return $this->getById($payrollrun['payrollrunid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $payrollrunid, $loginid )
  {
    try {
      $query = "CALL spDeletePayrollRun( :payrollrunid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrollrunid', $payrollrunid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
