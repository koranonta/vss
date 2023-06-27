<?php
require_once('../classes/users.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$users = new Users();
$errMsg = "";
$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'POST'):
  $body = getBody();
  $action = $body['action'];  
  if ($action >= 1 && $action <= 3):
    $user = $users->getByIdentifier($body['name']);
    //  login
    if ($action == 1):
      if (empty($user) || $body['password'] != $user[0]['password']):
        $errMsg = "Invalid user or password";
      endif;              
    //  register
    elseif($action == 2):
      if (empty($user)):
        $user = $users->add($body);
        if (empty($user)):
          $errMsg = "Unable to add new user [ {$body['name']} ]";
        endif;
      else:
        $errMsg = "User [ {$body['name']} ] already exist";
      endif;  
  
    //  change password
    elseif($action == 3):
      if (empty($user)):
        $errMsg = "User [ ${body['name']} ] does not exist";
      else:    
        $userid = $user[0]['userid'];
        $user = $users->changePassword($userid, $body['newpassword'], $body['loginid']);      
      endif;  
    endif;
  else:
    $errMsg = "Invalid request";
  endif;  
  
  if (empty($errMsg)):
    unset($user[0]['password']);
    Response::success($user[0]);
    //http_response_code(200);
    //echo json_encode($user[0], \JSON_UNESCAPED_UNICODE);    
  else:
    //$response = array ('message' => $errMsg);
    //http_response_code(400);
    //echo json_encode($response, \JSON_UNESCAPED_UNICODE);    
    Response::error($errMsg);  
  endif;  
else:
  Response::error("Service not supported");  
endif;
