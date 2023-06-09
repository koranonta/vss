<?php
require_once('../classes/reftable.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$reftable = new RefTable();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $reftable->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $reftable->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $reftable->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new reftable", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add reftable");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["reftableid" => $id];
    $res = $reftable->update($body);
    if ($res) {
      $response = array("res" => "reftable {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update reftable {$id}");
    }
  } else {
    Response::error("No reftable id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $reftable->delete($id);
    if ($res) {
      $response = array("res" => "reftable {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete reftable {$id}");
    }
  } else {
    Response::error("No reftable id");
  }
}
