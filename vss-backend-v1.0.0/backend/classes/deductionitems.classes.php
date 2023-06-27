<?php
require_once('db.classes.php');

class DeductionItems extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetDeductionItems(-1)";
    return $this->runQuery($query);
  }

  function getById( $deductionitemid )
  {
    $query = "CALL spGetDeductionItems( ${deductionitemid} )";
    return $this->runQuery($query);
  }

  function add( $deductionitem )
  {
    try {
      $query = "CALL spAddDeductionItem( :deductionid, :propertytypeid, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':deductionid', $deductionitem['deductionid']);
      $stmt->bindParam(':propertytypeid', $deductionitem['propertytypeid']);
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
  function update( $deductionitem )
  {
    try {
      $query = "CALL spUpdateDeductionItem( :deductionitemid, :deductionid, :propertytypeid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':deductionitemid', $deductionitem['deductionitemid']);
      $stmt->bindParam(':deductionid', $deductionitem['deductionid']);
      $stmt->bindParam(':propertytypeid', $deductionitem['propertytypeid']);
      $stmt->bindParam(':loginid', loginid);
      if ($stmt->execute()):
        return  $this->getById(['deductionitemid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $deductionitemid, $loginid )
  {
    try {
      $query = "CALL spDeleteDeductionItem( :deductionitemid, :loginid )";
      $stmt->bindParam(':deductionitemid', $deductionitemid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
