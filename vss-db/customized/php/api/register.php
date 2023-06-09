<?php
require_once '../classes/users.classes.php';
require_once '../classes/response.classes.php';
require_once 'apiutil.php';

const K_CUSTOMER = 3;
$users = new Users();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'POST'):
  $body = getBody();
  
  $user = array (
    "name"     => $body['name']
   ,"password" => $body['password']
   ,"email"    => $body['email']
   ,"phone"    => null
   ,"image"    => null
   ,"roleid"   => K_CUSTOMER
   ,"loginid"  => -1
  );
  
  $res = $users->add($user);
  if ($res):
    $response = array( "res" => "New user successfully registered." );
    Response::success($response);
  else:
    Response::error("Unable to add user");
  endif;
endif;

