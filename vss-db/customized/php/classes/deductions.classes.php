<?php
require_once('db.classes.php');

class Deductions extends Db
{
  function __construct() {
    parent::__construct();
  }
  
  function getDeductionRules() {
    $query = "CALL spGetDeductionRules( -1 )";
    return $this->runQuery($query);    
  }

  function getAll()
  {
    $query = "CALL spGetDeductions(-1)";
    return $this->runQuery($query);
  }

  function getById( $deductionid )
  {
    $query = "CALL spGetDeductions( ${deductionid} )";
    return $this->runQuery($query);
  }

  function add( $deduction )
  {
    try {
      $query = "CALL spAddDeduction( :deductiontypeid, :deductionname, :deductionthainame, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':deductiontypeid', $deduction['deductiontypeid']);
      $stmt->bindParam(':deductionname', $deduction['deductionname']);
      $stmt->bindParam(':deductionthainame', $deduction['deductionthainame']);
      $stmt->bindParam(':loginid', loginid);
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
  function update( $deduction )
  {
    try {
      $query = "CALL spUpdateDeduction( :deductionid, :deductiontypeid, :deductionname, :deductionthainame, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':deductionid', $deduction['deductionid']);
      $stmt->bindParam(':deductiontypeid', $deduction['deductiontypeid']);
      $stmt->bindParam(':deductionname', $deduction['deductionname']);
      $stmt->bindParam(':deductionthainame', $deduction['deductionthainame']);
      $stmt->bindParam(':loginid', loginid);
      if ($stmt->execute()):
        return  $this->getById(['deductionid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $deductionid, $loginid )
  {
    try {
      $query = "CALL spDeleteDeduction( :deductionid, :loginid )";
      $stmt->bindParam(':deductionid', $deductionid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
