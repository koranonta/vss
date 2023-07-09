<?php
require_once('db.classes.php');

class Users extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetUsers(-1)";
    return $this->runQuery($query);
  }

  function getById( $userid )
  {
    $query = "CALL spGetUsers( ${userid} )";
    return $this->runQuery($query);
  }
  
  function getByIdentifier($identifier) {    
    $query = "CALL spGetUserByIdentifier ('{$identifier}')";
    return $this->runQuery($query);
  }  
  
  function changePassword($userid, $newpassword, $loginid) {    
    try {
      //$password_hash=password_hash($newpassword,PASSWORD_DEFAULT);
      $password_hash = $newpassword;
      $query = "CALL spChangeUserPassword(:userid, :password, :loginid)";
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':userid',   $userid);
      $stmt->bindParam(':password', $password_hash);
      $stmt->bindParam(':loginid',  $loginid);
      if ($stmt->execute()) {
        return $this->getById($userid);
      }
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }     
  }
  
  function add($user) {
    try {
      //$password_hash=password_hash($user['password'],PASSWORD_DEFAULT);
      $password_hash = $user['password'];
      $query = 'CALL spAddUser (:name, :password, :email, :phone, :roleid, :image, :loginid, @newId)';
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':name', $user['name']);
      $stmt->bindParam(':password', $password_hash);
      $stmt->bindParam(':email', $user['email']);
      $stmt->bindParam(':phone', $user['phone']);
      $stmt->bindParam(':image', $user['image']);
      $stmt->bindParam(':roleid', $user['roleid']);
      $stmt->bindParam(':loginid', $prod['loginid']);    
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

  function update($user)
  {
    //print_r($user);
    //$info = "<br/>In update user " . $user['userid'];
    //echo $info;
    try {
      //$password_hash=password_hash($user['password'],PASSWORD_DEFAULT);
      $password_hash=$user['password'];
      $query = 'CALL spUpdateUser (:userid, :name, :password, :email, :phone, :roleid, :image, :loginid)';
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':userid', $user['userid']);
      $stmt->bindParam(':name', $user['name']);
      $stmt->bindParam(':password', $password_hash);
      $stmt->bindParam(':email', $user['email']);
      $stmt->bindParam(':phone', $user['phone']);
      $stmt->bindParam(':roleid', $user['roleid']);
      $stmt->bindParam(':image', $user['image']);
      $stmt->bindParam(':loginid', $user['loginid']);
      if ($stmt->execute()) {
        return $this->getById($user['userid']);
      }
      return array();
    } catch (Exception $e) {
      echo $e->getMessage();
      return array();
    }    
  }    
    
  function delete($id, $loginid)
  {
    try {
      $query = 'CALL spDeleteUser(:id, :loginid)';
      $stmt = $this->pdo->prepare($query);
      $stmt->bindParam(':id', $id);
      $stmt->bindParam(':loginid', $loginid);
      if ($stmt->execute()) return 1;
      return 0;
    } catch (Exception $e) {
      echo $e->getMessage();
    }
    return 0;
  }  

}
