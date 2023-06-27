<?php
require_once('../classes/payrollruns.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$payrollruns = new PayrollRuns();
$errMsg = null;
$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $prRunDate = getParam("runDate");
  if (isset($prRunDate)):
    $res = $payrollruns->getByDate($prRunDate);
    $response = $res;
  else:
    $id = getId();
    if ($id):
      $res = $payrollruns->getById($id);
      $response = array( "data" => $res );
    else:
      $res = $payrollruns->getAll();
      $response = array( "data" => $res );
    endif;
  endif;
elseif ($requestMethod == 'POST'):  
  $res = $payrollruns->add(getBody());
  if ($res):
    $response = array( 'res' => 'New payrollrun added', 'payrollrun' => $res );
  else:
    $errMsg = 'Unable to add payrollrun';
  endif;  
elseif ($requestMethod == 'PUT'):
  $res = $payrollruns->update(getBody());
  $id  = $res[0]['payrollrunid'];
  if ($res):
    $response = array( 'res' => $okMsg, 'payrollrun' => $res );
  else:
    $errMsg = 'Unable to update PayrollRun id [ ' . $id . ' ]';
  endif;
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $payrollruns->delete($id, -1);
    if ($res):
      $response = array("res" => "payrollruns {$id} deleted", "status" => $res);
    else:
      $errMsg = "Unable to delete payrollruns {$id}";
    endif;
  else:
    $errMsg = "No payrollruns id";
  endif;
endif;

if (isset($errMsg)):
  Response::error($errMsg);
else:
  Response::success($response);
endif;  
