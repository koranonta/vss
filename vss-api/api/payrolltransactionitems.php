<?php
require_once('../classes/payrolltransactionitems.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrolltransactionitem = new PayrollTransactionItems();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET') {
  $id = getId();
  if ($id) {
    $res = $payrolltransactionitem->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  } else {
    $res = $payrolltransactionitem->getAll( -1);
    $response = array( "data" => $res );
    Response::success($response);
  }
} else if ($requestMethod == 'POST') {
  $body = getBody();
  $res = $payrolltransactionitem->add($body);
  if ($res) {
    $response = array(
      "res" => "Post new payrolltransactionitem", "body" => $body, "status" => $res
    );
    Response::success($response);
  } else {
    Response::error("Unable to add payrolltransactionitem");
  }
} else if ($requestMethod == 'PUT') {
  $id = getId();
  if ($id) {
    $body = getBody();
    $body += ["payrolltransactionitemid" => $id];
    $res = $payrolltransactionitem->update($body);
    if ($res) {
      $response = array("res" => "payrolltransactionitem {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to update payrolltransactionitem {$id}");
    }
  } else {
    Response::error("No payrolltransactionitem id");
  }
} else if ($requestMethod == 'DELETE') {
  $id = getId();
  if ($id) {
    $res = $payrolltransactionitem->delete($id);
    if ($res) {
      $response = array("res" => "payrolltransactionitem {$id} deleted", "status" => $res);
      Response::success($response);
    } else {
      Response::error("Unable to delete payrolltransactionitem {$id}");
    }
  } else {
    Response::error("No payrolltransactionitem id");
  }
}
