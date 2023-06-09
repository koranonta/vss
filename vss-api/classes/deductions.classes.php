<?php
require_once('db.classes.php');

class Deductions extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetDeductions()';
    return $this->runQuery($query);
  }

  function getById(( $deductionid ))
  {
    $query = 'CALL spGetDeductionById( $deductionid )';
    return $this->runQuery($query);
  }

  function delete( $deductionid )
  {
    $query = 'CALL spDeleteDeduction( :deductionid )';
    $stmt->bindParam(':deductionid', deductionid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $deduction )
  {
    $query = 'CALL spUpdateDeduction( :deductiontypeid, :deductionname, :loginid )';
    $stmt->bindParam(':deductiontypeid', $deduction['deductiontypeid']);
    $stmt->bindParam(':deductionname', $deduction['deductionname']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $deduction )
  {
    $query = 'CALL spAddDeduction( :deductiontypeid, :deductionname, :loginid, @newId )';
    $stmt->bindParam(':deductiontypeid', $deduction['deductiontypeid']);
    $stmt->bindParam(':deductionname', $deduction['deductionname']);
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
