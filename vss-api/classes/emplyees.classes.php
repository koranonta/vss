<?php
require_once('db.classes.php');

class Emplyees extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetEmplyees()';
    return $this->runQuery($query);
  }

  function getById(( $employeeid ))
  {
    $query = 'CALL spGetEmplyeeById( $employeeid )';
    return $this->runQuery($query);
  }

  function delete( $employeeid )
  {
    $query = 'CALL spDeleteEmplyee( :employeeid )';
    $stmt->bindParam(':employeeid', employeeid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $emplyee )
  {
    $query = 'CALL spUpdateEmplyee( :employeetypeid, :accountid, :genderid, :firstname, :lastname, :identificationcardid, :birthdate, :image, :salary, :positionsalary, :loginid )';
    $stmt->bindParam(':employeetypeid', $emplyee['employeetypeid']);
    $stmt->bindParam(':accountid', $emplyee['accountid']);
    $stmt->bindParam(':genderid', $emplyee['genderid']);
    $stmt->bindParam(':firstname', $emplyee['firstname']);
    $stmt->bindParam(':lastname', $emplyee['lastname']);
    $stmt->bindParam(':identificationcardid', $emplyee['identificationcardid']);
    $stmt->bindParam(':birthdate', $emplyee['birthdate']);
    $stmt->bindParam(':image', $emplyee['image']);
    $stmt->bindParam(':salary', $emplyee['salary']);
    $stmt->bindParam(':positionsalary', $emplyee['positionsalary']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $emplyee )
  {
    $query = 'CALL spAddEmplyee( :employeetypeid, :accountid, :genderid, :firstname, :lastname, :identificationcardid, :birthdate, :image, :salary, :positionsalary, :loginid, @newId )';
    $stmt->bindParam(':employeetypeid', $emplyee['employeetypeid']);
    $stmt->bindParam(':accountid', $emplyee['accountid']);
    $stmt->bindParam(':genderid', $emplyee['genderid']);
    $stmt->bindParam(':firstname', $emplyee['firstname']);
    $stmt->bindParam(':lastname', $emplyee['lastname']);
    $stmt->bindParam(':identificationcardid', $emplyee['identificationcardid']);
    $stmt->bindParam(':birthdate', $emplyee['birthdate']);
    $stmt->bindParam(':image', $emplyee['image']);
    $stmt->bindParam(':salary', $emplyee['salary']);
    $stmt->bindParam(':positionsalary', $emplyee['positionsalary']);
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
