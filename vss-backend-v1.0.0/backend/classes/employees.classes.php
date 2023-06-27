<?php
require_once('db.classes.php');

class Employees extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetEmployees(-1)";
    return $this->runQuery($query);
  }

  function getById( $employeeid )
  {
    $query = "CALL spGetEmployees( ${employeeid} )";
    return $this->runQuery($query);
  }

  function add( $employee )
  {
    try {
      $query = "CALL spAddEmployee( :employeetypeid, :accountid, :genderid, :firstname, :lastname, :identificationcardid, :birthdate, :joindate, :image, :salary, :positionsalary, :loginid, @newId )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':employeetypeid', $employee['employeetypeid']);
      $stmt->bindParam(':accountid', $employee['accountid']);
      $stmt->bindParam(':genderid', $employee['genderid']);
      $stmt->bindParam(':firstname', $employee['firstname']);
      $stmt->bindParam(':lastname', $employee['lastname']);
      $stmt->bindParam(':identificationcardid', $employee['identificationcardid']);
      $stmt->bindParam(':birthdate', $employee['birthdate']);
      $stmt->bindParam(':joindate', $employee['joindate']);
      $stmt->bindParam(':image', $employee['image']);
      $stmt->bindParam(':salary', $employee['salary']);
      $stmt->bindParam(':positionsalary', $employee['positionsalary']);
      $stmt->bindParam(':loginid', $employee['loginid']);
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
  function update( $employee )
  {
    try {
      $query = "CALL spUpdateEmployee( :employeeid, :employeetypeid, :accountid, :genderid, :firstname, :lastname, :identificationcardid, :birthdate, :joindate, :image, :salary, :positionsalary, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':employeeid', $employee['employeeid']);
      $stmt->bindParam(':employeetypeid', $employee['employeetypeid']);
      $stmt->bindParam(':accountid', $employee['accountid']);
      $stmt->bindParam(':genderid', $employee['genderid']);
      $stmt->bindParam(':firstname', $employee['firstname']);
      $stmt->bindParam(':lastname', $employee['lastname']);
      $stmt->bindParam(':identificationcardid', $employee['identificationcardid']);
      $stmt->bindParam(':birthdate', $employee['birthdate']);
      $stmt->bindParam(':joindate', $employee['joindate']);
      $stmt->bindParam(':image', $employee['image']);
      $stmt->bindParam(':salary', $employee['salary']);
      $stmt->bindParam(':positionsalary', $employee['positionsalary']);
      $stmt->bindParam(':loginid', $employee['loginid']);
      if ($stmt->execute()):
        return $this->getById($employee['employeeid']);
      endif;
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }
  }

  function delete( $employeeid, $loginid )
  {
    try {
      $query = "CALL spDeleteEmployee( :employeeid, :loginid )";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':employeeid', $employeeid);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }

}
