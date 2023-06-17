<?php
require_once('../classes/payrolltransactions.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrolltransactions = new PayrollTransactions();
$errMsg = null;
$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $payrolltransactions->getById($id);
    $response = array( "data" => $res );
  else:
    $res = $payrolltransactions->getAll();
    $response = array( "data" => $res );
  endif;
elseif ($requestMethod == 'POST'):
  $res = $payrolltransactions->add(getBody());
  if ($res):
    $response = array( 'res' => $okMsg, 'payrolltransaction' => $res );
  else:
    $errMsg = 'Unable to add payrolltransaction';
  endif;
elseif ($requestMethod == 'PUT'):
  $res = $payrolltransactions->update(getBody());
  $id  = $res[0]['payrolltransactionid'];
  if ($res):
    $response = array( 'res' => $okMsg, 'payrolltransaction' => $res );
  else:
    $errMsg = 'Unable to update PayrollTransaction id [ ' . $id . ' ]';
  endif;
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $payrolltransactions->delete($id, -1);
    if ($res):
      $response = array("res" => "payrolltransactions {$id} deleted", "status" => $res);
    else:
      $errMsg = "Unable to delete payrolltransactions {$id}";
    endif;
  else:
    $errMsg = "No payrolltransactions id";
  endif;
endif;

if (isset($errMsg)):
  Response::error($errMsg);
else:
  Response::success($response);
endif;  
