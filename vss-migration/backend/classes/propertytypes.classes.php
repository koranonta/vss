<?php
require_once('db.classes.php');

class PropertyTypes extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    //$query = "CALL spGetPropertyTypes(-1)";
    $query = "CALL spGetPropertyTypeByGroups( -1 )";
    return $this->runQuery($query);
  }

  function getById( $propertytypeid )
  {
    //$query = "CALL spGetPropertyTypes( ${propertytypeid} )";
    $query = "CALL spGetPropertyTypeByGroups( ${propertytypeid} )";
    return $this->runQuery($query);
  }

  function add( $propertytype )
  {
    try {
      $query = "CALL spAddPropertyType( :propertytypegroupid, :propertytypename, :propertytypethainame, :alias, :allowablevalues, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':propertytypegroupid', $propertytype['propertytypegroupid']);
      $stmt->bindParam(':propertytypename', $propertytype['propertytypename']);
      $stmt->bindParam(':propertytypethainame', $propertytype['propertytypethainame']);
      $stmt->bindParam(':alias', $propertytype['alias']);
      $stmt->bindParam(':allowablevalues', $propertytype['allowablevalues']);
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
  function update( $propertytype )
  {
    try {
      $query = "CALL spUpdatePropertyType( :propertytypeid, :propertytypegroupid, :propertytypename, :propertytypethainame, :alias, :allowablevalues, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':propertytypeid', $propertytype['propertytypeid']);
      $stmt->bindParam(':propertytypegroupid', $propertytype['propertytypegroupid']);
      $stmt->bindParam(':propertytypename', $propertytype['propertytypename']);
      $stmt->bindParam(':propertytypethainame', $propertytype['propertytypethainame']);
      $stmt->bindParam(':alias', $propertytype['alias']);
      $stmt->bindParam(':allowablevalues', $propertytype['allowablevalues']);
      $stmt->bindParam(':loginid', loginid);
      if ($stmt->execute()):
        return  $this->getById(['propertytypeid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $propertytypeid, $loginid )
  {
    try {
      $query = "CALL spDeletePropertyType( :propertytypeid, :loginid )";
      $stmt->bindParam(':propertytypeid', $propertytypeid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
