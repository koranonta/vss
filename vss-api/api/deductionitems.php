<?php
require_once('../classes/deductionitems.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$deductionitem = new DeductionItems();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $deductionitem->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $deductionitem->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $deductionitem->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new deductionitem", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add deductionitem");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["deductionitemid" => $id];
    $res = $deductionitem->update($body);
    if ($res) {
      $response = array("res" => "deductionitem {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update deductionitem {$id}");
    }
  } else {
    Response::error("No deductionitem id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $deductionitem->delete($id);
    if ($res) {
      $response = array("res" => "deductionitem {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete deductionitem {$id}");
    }
  } else {
    Response::error("No deductionitem id");
  }
}
