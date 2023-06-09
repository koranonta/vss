<?php
require_once('../classes/users.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$user = new Users();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $user->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $user->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $user->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new user", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add user");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["userid" => $id];
    $res = $user->update($body);
    if ($res) {
      $response = array("res" => "user {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update user {$id}");
    }
  } else {
    Response::error("No user id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $user->delete($id, -1);
    if ($res) {
      $response = array("res" => "user {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete user {$id}");
    }
  } else {
    Response::error("No user id");
  }
}
