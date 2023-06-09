<?php
require_once('../classes/payrolltransactions.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrolltransaction = new PayrollTransactions();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $payrolltransaction->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $payrolltransaction->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $payrolltransaction->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new payrolltransaction", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add payrolltransaction");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["payrolltransactionid" => $id];
    $res = $payrolltransaction->update($body);
    if ($res) {
      $response = array("res" => "payrolltransaction {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update payrolltransaction {$id}");
    }
  } else {
    Response::error("No payrolltransaction id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $payrolltransaction->delete($id);
    if ($res) {
      $response = array("res" => "payrolltransaction {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete payrolltransaction {$id}");
    }
  } else {
    Response::error("No payrolltransaction id");
  }
}
