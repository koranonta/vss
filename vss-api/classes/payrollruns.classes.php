<?php
require_once('db.classes.php');

class PayrollRuns extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetPayrollRuns()';
    return $this->runQuery($query);
  }

  function getById(( $payrollrunid ))
  {
    $query = 'CALL spGetPayrollRunById( $payrollrunid )';
    return $this->runQuery($query);
  }

  function delete( $payrollrunid )
  {
    $query = 'CALL spDeletePayrollRun( :payrollrunid )';
    $stmt->bindParam(':payrollrunid', payrollrunid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $payrollrun )
  {
    $query = 'CALL spUpdatePayrollRun( :payrollrundate, :loginid )';
    $stmt->bindParam(':payrollrundate', $payrollrun['payrollrundate']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $payrollrun )
  {
    $query = 'CALL spAddPayrollRun( :payrollrundate, :loginid, @newId )';
    $stmt->bindParam(':payrollrundate', $payrollrun['payrollrundate']);
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
