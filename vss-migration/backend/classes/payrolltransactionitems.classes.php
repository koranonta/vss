<?php
require_once('db.classes.php');

class PayrollTransactionItems extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetPayrollTransactionItems(-1)";
    return $this->runQuery($query);
  }

  function getById( $payrolltransactionitemid )
  {
    $query = "CALL spGetPayrollTransactionItems( ${payrolltransactionitemid} )";
    return $this->runQuery($query);
  }
  
  function getByRunId ( $runid ) {
    $query = "CALL spGetPayrollTransactionItemsByRunId( ${runid} )";
    return $this->runQuery($query);
  }

  function add( $payrolltransactionitem )
  {
    try {
      $query = "CALL spAddPayrollTransactionItem( :payrolltransactionid, :propertytypeid, :amount, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrolltransactionid', $payrolltransactionitem['payrolltransactionid']);
      $stmt->bindParam(':propertytypeid', $payrolltransactionitem['propertytypeid']);
      $stmt->bindParam(':amount', $payrolltransactionitem['amount']);
      $stmt->bindParam(':loginid', $payrolltransactionitem['loginid']);
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
  function update( $payrolltransactionitem )
  {
    try {
      $query = "CALL spUpdatePayrollTransactionItem( :payrolltransactionitemid, :payrolltransactionid, :propertytypeid, :amount, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrolltransactionitemid', $payrolltransactionitem['payrolltransactionitemid']);
      $stmt->bindParam(':payrolltransactionid', $payrolltransactionitem['payrolltransactionid']);
      $stmt->bindParam(':propertytypeid', $payrolltransactionitem['propertytypeid']);
      $stmt->bindParam(':amount', $payrolltransactionitem['amount']);
      $stmt->bindParam(':loginid', $payrolltransactionitem['loginid']);
      if ($stmt->execute()):
        return $this->getById($payrolltransactionitem['payrolltransactionitemid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $payrolltransactionitemid, $loginid )
  {
    try {
      $query = "CALL spDeletePayrollTransactionItem( :payrolltransactionitemid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':payrolltransactionitemid', $payrolltransactionitemid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
