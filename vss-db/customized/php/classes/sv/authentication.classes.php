<?php
require_once('users.classes.php');

class Authentication extends Users {
  function __construct() {
    parent::__construct();
  }
  
  function authenticate ($body) {
    
    $action = $body['action'];
    if ($action == 1):
      return $this->login($body);    
    elseif($action == 2):
      return $this->register($body);
    elseif($action == 3):
      return $this->changePwd($body);
    endif;
  }

  function login ($body) {
    $user = $this->getByIdentifier($body['name']);        
    if (empty($user) || $body['password'] != $user[0]['password']):
      return array ("valid" => false, "errMsg" => "Invalid user or password");
    else:
      return array_merge( ["valid" => true], ["user" => $user[0]] );
    endif;
  }
  
  function register($body) {
    $user = $this->getByIdentifier($body['name']); 
    if (empty($user)):
      $newUser = $this->add($body);
      if (!empty($newUser)):
        return array_merge( ["valid" => true], ["user" => $newUser[0]]);      
      else:
        return array ( "valid" => false, "errMsg" => "Unable to add user [ {$body['name']} ] already exist");
      endif;
    else:
      return array ( "valid" => false, "errMsg" => "User [ {$body['name']} ] already exist");
    endif;
  }

  function changePwd($body) {
    $user = $this->getByIdentifier($body['name']); 
    //var_dump($user);
    if (empty($user)):
      return array( "valid" => false, "errMsg" => "User [ ${body['name']} ] does not exist");
    else:    
      $userid = $user[0]['userid'];
      $newUser = $this->changePassword($userid, $body['newpassword'], $body['loginid']);
      return array_merge( ["valid" => true], ["user" => $newUser[0]]);
    endif;
  }
}
