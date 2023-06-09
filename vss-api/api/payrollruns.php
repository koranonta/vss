<?php
require_once('../classes/payrollruns.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrollrun = new PayrollRuns();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $payrollrun->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $payrollrun->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $payrollrun->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new payrollrun", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add payrollrun");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["payrollrunid" => $id];
    $res = $payrollrun->update($body);
    if ($res) {
      $response = array("res" => "payrollrun {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update payrollrun {$id}");
    }
  } else {
    Response::error("No payrollrun id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $payrollrun->delete($id);
    if ($res) {
      $response = array("res" => "payrollrun {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete payrollrun {$id}");
    }
  } else {
    Response::error("No payrollrun id");
  }
}
