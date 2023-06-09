<?php
require_once('../classes/addresses.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$addresse = new Addresses();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $addresse->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $addresse->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $addresse->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new addresse", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add addresse");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["addresseid" => $id];
    $res = $addresse->update($body);
    if ($res) {
      $response = array("res" => "addresse {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update addresse {$id}");
    }
  } else {
    Response::error("No addresse id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $addresse->delete($id);
    if ($res) {
      $response = array("res" => "addresse {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete addresse {$id}");
    }
  } else {
    Response::error("No addresse id");
  }
}
