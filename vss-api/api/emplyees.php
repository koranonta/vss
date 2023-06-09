<?php
require_once('../classes/emplyees.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$emplyee = new Emplyees();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $emplyee->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $emplyee->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $emplyee->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new emplyee", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add emplyee");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["emplyeeid" => $id];
    $res = $emplyee->update($body);
    if ($res) {
      $response = array("res" => "emplyee {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update emplyee {$id}");
    }
  } else {
    Response::error("No emplyee id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $emplyee->delete($id);
    if ($res) {
      $response = array("res" => "emplyee {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete emplyee {$id}");
    }
  } else {
    Response::error("No emplyee id");
  }
}
