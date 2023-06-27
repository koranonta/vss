<?php
require_once('db.classes.php');

class Addresses extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetAddresses(-1)";
    return $this->runQuery($query);
  }

  function getById( $addressid )
  {
    $query = "CALL spGetAddresses( ${addressid} )";
    return $this->runQuery($query);
  }

  function add( $address )
  {
    try {
      $query = "CALL spAddAddress( :employeeid, :address, :subdistrict, :district, :street, :city, :province, :country, :postcode, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':employeeid', $address['employeeid']);
      $stmt->bindParam(':address', $address['address']);
      $stmt->bindParam(':subdistrict', $address['subdistrict']);
      $stmt->bindParam(':district', $address['district']);
      $stmt->bindParam(':street', $address['street']);
      $stmt->bindParam(':city', $address['city']);
      $stmt->bindParam(':province', $address['province']);
      $stmt->bindParam(':country', $address['country']);
      $stmt->bindParam(':postcode', $address['postcode']);
      $stmt->bindParam(':loginid', $address['loginid']);
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
  function update( $address )
  {
    try {
      $query = "CALL spUpdateAddress( :addressid, :employeeid, :address, :subdistrict, :district, :street, :city, :province, :country, :postcode, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':addressid', $address['addressid']);
      $stmt->bindParam(':employeeid', $address['employeeid']);
      $stmt->bindParam(':address', $address['address']);
      $stmt->bindParam(':subdistrict', $address['subdistrict']);
      $stmt->bindParam(':district', $address['district']);
      $stmt->bindParam(':street', $address['street']);
      $stmt->bindParam(':city', $address['city']);
      $stmt->bindParam(':province', $address['province']);
      $stmt->bindParam(':country', $address['country']);
      $stmt->bindParam(':postcode', $address['postcode']);
      $stmt->bindParam(':loginid', $address['loginid']);
      if ($stmt->execute()):
        return $this->getById($address['addressid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $addressid, $loginid )
  {
    try {
      $query = "CALL spDeleteAddress( :addressid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':addressid', $addressid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
