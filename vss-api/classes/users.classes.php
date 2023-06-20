<?php
require_once('db.classes.php');

class Users extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetUsers()';
    return $this->runQuery($query);
  }

  function getById( $userid )
  {
    $query = 'CALL spGetUserById( $userid )';
    return $this->runQuery($query);
  }
  
  function getByIdentifier ( $identifier ) 
  {
    $query = 'CALL spGetUserByIdentifier( $identifier )';
    return $this->runQuery($query);
  }
  
  function updatePassword ( $user ) 
  {
  }

  function delete( $userid )
  {
    $query = 'CALL spDeleteUser( :userid )';
    $stmt->bindParam(':userid', userid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $user )
  {
    $query = 'CALL spUpdateUser( :name, :password, :email, :phone, :usertypeid, :image, :loginid )';
    $stmt->bindParam(':name', $user['name']);
    $stmt->bindParam(':password', $user['password']);
    $stmt->bindParam(':email', $user['email']);
    $stmt->bindParam(':phone', $user['phone']);
    $stmt->bindParam(':usertypeid', $user['usertypeid']);
    $stmt->bindParam(':image', $user['image']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $user )
  {
    $query = 'CALL spAddUser( :name, :password, :email, :phone, :usertypeid, :image, :loginid, @newId )';
    $stmt->bindParam(':name', $user['name']);
    $stmt->bindParam(':password', $user['password']);
    $stmt->bindParam(':email', $user['email']);
    $stmt->bindParam(':phone', $user['phone']);
    $stmt->bindParam(':usertypeid', $user['usertypeid']);
    $stmt->bindParam(':image', $user['image']);
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
