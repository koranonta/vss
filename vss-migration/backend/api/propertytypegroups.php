<?php
require_once('../classes/propertytypegroups.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$propertytypegroup = new PropertyTypeGroups();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $propertytypegroup->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $propertytypegroup->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $propertytypegroup->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new propertytypegroup", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add propertytypegroup");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["propertytypegroupid" => $id];
    $res = $propertytypegroup->update($body);
    if ($res) {
      $response = array("res" => "propertytypegroup {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update propertytypegroup {$id}");
    }
  } else {
    Response::error("No propertytypegroup id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $propertytypegroup->delete($id, -1);
    if ($res) {
      $response = array("res" => "propertytypegroup {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete propertytypegroup {$id}");
    }
  } else {
    Response::error("No propertytypegroup id");
  }
}
