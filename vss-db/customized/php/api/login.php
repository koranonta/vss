<?php
require_once '../classes/users.classes.php';
require_once '../classes/response.classes.php';
require_once 'apiutil.php';

$users = new Users();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'POST'):
  $body = getBody();
  $identifier = $body['identifier'];
  $password   = $body['password'];
  $login = $users->getByIdentifier($identifier);
  if( sizeof($login) == 0 ):
    Response::error("Invalid user or password");
  else:
    if (array_column($login, 'password')[0] != $password):
      Response::error("Invalid user or password");
  else:
	  $id = array_column($login, 'userid')[0];
	  endif;	
      $res = array( 
        "userid"    => array_column($login, 'userid')[0]
       ,"name"      => array_column($login, 'name')[0]
       ,"email"     => array_column($login, 'email')[0]
       ,"phone"     => array_column($login, 'phone')[0]
       ,"image"     => array_column($login, 'image')[0]
       ,"roleid"    => array_column($login, 'roleid')[0]
       ,"roletype"  => array_column($login, 'roletype')[0]);	 
      Response::success($res);
    endif;
  endif;
endif;
