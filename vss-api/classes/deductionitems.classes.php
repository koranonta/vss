<?php
require_once('db.classes.php');

class DeductionItems extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetDeductionItems()';
    return $this->runQuery($query);
  }

  function getById(( $deductionitemid ))
  {
    $query = 'CALL spGetDeductionItemById( $deductionitemid )';
    return $this->runQuery($query);
  }

  function delete( $deductionitemid )
  {
    $query = 'CALL spDeleteDeductionItem( :deductionitemid )';
    $stmt->bindParam(':deductionitemid', deductionitemid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $deductionitem )
  {
    $query = 'CALL spUpdateDeductionItem( :deductionid, :deductionname, :deductionthainame, :value, :loginid )';
    $stmt->bindParam(':deductionid', $deductionitem['deductionid']);
    $stmt->bindParam(':deductionname', $deductionitem['deductionname']);
    $stmt->bindParam(':deductionthainame', $deductionitem['deductionthainame']);
    $stmt->bindParam(':value', $deductionitem['value']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $deductionitem )
  {
    $query = 'CALL spAddDeductionItem( :deductionid, :deductionname, :deductionthainame, :value, :loginid, @newId )';
    $stmt->bindParam(':deductionid', $deductionitem['deductionid']);
    $stmt->bindParam(':deductionname', $deductionitem['deductionname']);
    $stmt->bindParam(':deductionthainame', $deductionitem['deductionthainame']);
    $stmt->bindParam(':value', $deductionitem['value']);
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
