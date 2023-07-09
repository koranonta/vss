<?php
require_once('db.classes.php');

class PropertyTypeGroups extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetPropertyTypeGroups(-1)";
    return $this->runQuery($query);
  }

  function getById( $propertytypegroupid )
  {
    $query = "CALL spGetPropertyTypeGroups( ${propertytypegroupid} )";
    return $this->runQuery($query);
  }

  function add( $propertytypegroup )
  {
    try {
      $query = "CALL spAddPropertyTypeGroup( :propertytypegroupname, :propertytypegroupthainame, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':propertytypegroupname', $propertytypegroup['propertytypegroupname']);
      $stmt->bindParam(':propertytypegroupthainame', $propertytypegroup['propertytypegroupthainame']);
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
  function update( $propertytypegroup )
  {
    try {
      $query = "CALL spUpdatePropertyTypeGroup( :propertytypegroupid, :propertytypegroupname, :propertytypegroupthainame, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':propertytypegroupid', $propertytypegroup['propertytypegroupid']);
      $stmt->bindParam(':propertytypegroupname', $propertytypegroup['propertytypegroupname']);
      $stmt->bindParam(':propertytypegroupthainame', $propertytypegroup['propertytypegroupthainame']);
      $stmt->bindParam(':loginid', loginid);
      if ($stmt->execute()):
        return  $this->getById(['propertytypegroupid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $propertytypegroupid, $loginid )
  {
    try {
      $query = "CALL spDeletePropertyTypeGroup( :propertytypegroupid, :loginid )";
      $stmt->bindParam(':propertytypegroupid', $propertytypegroupid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
