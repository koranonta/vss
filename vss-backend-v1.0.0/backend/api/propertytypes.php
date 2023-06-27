<?php
require_once('../classes/propertytypes.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$propertytype = new PropertyTypes();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $propertytype->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $propertytype->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $propertytype->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new propertytype", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add propertytype");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["propertytypeid" => $id];
    $res = $propertytype->update($body);
    if ($res) {
      $response = array("res" => "propertytype {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update propertytype {$id}");
    }
  } else {
    Response::error("No propertytype id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $propertytype->delete($id, -1);
    if ($res) {
      $response = array("res" => "propertytype {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete propertytype {$id}");
    }
  } else {
    Response::error("No propertytype id");
  }
}
