<?php
require_once('../classes/deductions.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$deduction = new Deductions();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $deduction->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $deduction->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $deduction->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new deduction", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add deduction");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["deductionid" => $id];
    $res = $deduction->update($body);
    if ($res) {
      $response = array("res" => "deduction {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update deduction {$id}");
    }
  } else {
    Response::error("No deduction id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $deduction->delete($id);
    if ($res) {
      $response = array("res" => "deduction {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete deduction {$id}");
    }
  } else {
    Response::error("No deduction id");
  }
}
