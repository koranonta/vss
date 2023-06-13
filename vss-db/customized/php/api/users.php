<?php
require_once('../classes/users.classes.php');
require_once('../classes/response.classes.php');
require_once '../classes/imagehandler.classes.php';
include_once('./apiutil.php');

$users = new Users();
$imgHandler = new ImageHandler("/app/vss/backend/assets/images/avatars/");

$requestMethod = $_SERVER["REQUEST_METHOD"];

// get ("/users")
// get ("/users?identifier=<identifier")
// get ("/users?id=<id>")
if ($requestMethod == 'GET'):  
  $identifier = getParam("identifier");  
  $id = getId();  
  if ($identifier):
    $res = $users->getByIdentifier($identifier);  
  elseif ($id):
    $res = $users->getById($id);
  else:
    $res = $users->getAll();
  endif;
  if ($res):
    $response = array( "data" => $res );
    Response::success($response);
  else:
     Response::error("User not found");
  endif;  
  
// post("/users", <body>)  
elseif ($requestMethod == 'POST'):
  $img = $_FILES["imgInput"];
  $imgName = isset($img) ? $img['name'] : $_POST['image'];
  $user = array (
    "name"     => $_POST['name'],
    "email"    => $_POST['email'],
    "password" => $_POST['password'],
    "phone"    => $_POST['phone'],
    "roleid"   => $_POST['roleid'],
    "image"    => $imgName,
    "loginid"  => -1    
  );
  
  $id = $_POST['userid'];
  $userId = -1;
  if (isset($id)):
    $user["userid"] = $id;
    $userId = $id;
    $res    = $users->update($user);
	  $okMsg  = "User id [ " . $id . " ] updated";
	  $errMsg = "Unable to update user id [ " . $id . " ]";
  else:
    $res    = $users->add($user);
	  $okMsg  = "New user added";
	  $errMsg = "Unable to add user";	
    $userId = $res[0]['userid'];
  endif;
  //  Save user image
  if (isset($img['name']) && $img['error'] == 0):
    $imgHandler->saveImage($img);
  endif;   
  
  if ($res):      
    $response = array( "res" => $okMsg, "user" => $res );
    Response::success($response);
  else:
    Response::error($errMsg);
  endif;  
  
// put("/users?id=<userId>", <body>)  
elseif ($requestMethod == 'PUT'):
  $id = getId();
  if ($id):
    $body = getBody();
    $body += ["userid" => $id];
    $res = $users->update($body);
    if ($res) {
      $response = array("res" => "user {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update user {$id}");
    }
  else:
    Response::error("No user id");
  endif;
  
// delete("/users?id=<userid>")  
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $users->delete($id, -1);
    if ($res):
      $response = array("res" => "user {$id} deleted", "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to delete user {$id}");
    endif;
  else:
    Response::error("No user id");
  endif;
endif;
