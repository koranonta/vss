<?php
require_once('../classes/payrolltransactionitems.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrolltransactionitems = new PayrollTransactionItems();
$errMsg = null;
$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $payrolltransactionitems->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  else:
    $res = $payrolltransactionitems->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  endif;
elseif ($requestMethod == 'POST'):
  $res    = $payrolltransactionitems->add(getBody());  
  if ($res):
    $response = array( 'res' => 'New payrolltransactionitem added', 'payrolltransactionitem' => $res );  
  else:
    $errMsg = 'Unable to add payrolltransactionitem';
  endif;
elseif ($requestMethod == 'PUT'):
  $res    = $payrolltransactionitems->update(getBody());
  $id  = $res[0]['payrolltransactionitemid'];
  if ($res):
    $response = array( 'res' => $okMsg, 'payrolltransactionitem' => $res );
  else:
    $errMsg = 'Unable to update PayrollTransactionItem id [ ' . $id . ' ]';
  endif;
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $payrolltransactionitems->delete($id, -1);
    if ($res):
      $response = array("res" => "payrolltransactionitems {$id} deleted", "status" => $res);
    else:
      $errMsg = "Unable to delete payrolltransactionitems {$id}";
    endif;
  else:
    $errMsg = "No payrolltransactionitems id";
  endif;
endif;

if (isset($errMsg)):
  Response::error($errMsg);
else:
  Response::success($response);
endif;  
