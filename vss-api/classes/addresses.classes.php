<?php
require_once('db.classes.php');

class Addresses extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetAddresses()';
    return $this->runQuery($query);
  }

  function getById(( $addressid ))
  {
    $query = 'CALL spGetAddresseById( $addressid )';
    return $this->runQuery($query);
  }

  function delete( $addressid )
  {
    $query = 'CALL spDeleteAddresse( :addressid )';
    $stmt->bindParam(':addressid', addressid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $addresse )
  {
    $query = 'CALL spUpdateAddresse( :employeeid, :address, :subdistrict, :district, :street, :province, :city, :postcode, :country, :loginid )';
    $stmt->bindParam(':employeeid', $addresse['employeeid']);
    $stmt->bindParam(':address', $addresse['address']);
    $stmt->bindParam(':subdistrict', $addresse['subdistrict']);
    $stmt->bindParam(':district', $addresse['district']);
    $stmt->bindParam(':street', $addresse['street']);
    $stmt->bindParam(':province', $addresse['province']);
    $stmt->bindParam(':city', $addresse['city']);
    $stmt->bindParam(':postcode', $addresse['postcode']);
    $stmt->bindParam(':country', $addresse['country']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $addresse )
  {
    $query = 'CALL spAddAddresse( :employeeid, :address, :subdistrict, :district, :street, :province, :city, :postcode, :country, :loginid, @newId )';
    $stmt->bindParam(':employeeid', $addresse['employeeid']);
    $stmt->bindParam(':address', $addresse['address']);
    $stmt->bindParam(':subdistrict', $addresse['subdistrict']);
    $stmt->bindParam(':district', $addresse['district']);
    $stmt->bindParam(':street', $addresse['street']);
    $stmt->bindParam(':province', $addresse['province']);
    $stmt->bindParam(':city', $addresse['city']);
    $stmt->bindParam(':postcode', $addresse['postcode']);
    $stmt->bindParam(':country', $addresse['country']);
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
