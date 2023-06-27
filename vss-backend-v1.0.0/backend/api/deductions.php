<?php
require_once('../classes/deductions.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$deductions = new Deductions();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $deductions->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  else:
    $res = $deductions->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  endif;
elseif ($requestMethod == 'POST'):
  $body = getBody();
  $res = $deductions->add($body);
  if ($res):
    $response = array(
      "res" => "Post new deductions", "body" => $body, "status" => $res
    );
    Response::success($response);
  else:
    Response::error("Unable to add deductions");
  endif;
elseif ($requestMethod == 'PUT'):
  $id = getId();
  if ($id):
    $body = getBody();
    $body += ["deductionid" => $id];
    $res = $deductions->update($body);
    if ($res):
      $response = array("res" => "deductions {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to update deductions {$id}");
    endif;
  else:
    Response::error("No deductions id");
  endif;
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $deductions->delete($id, -1);
    if ($res):
      $response = array("res" => "deductions {$id} deleted", "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to delete deductions {$id}");
    endif;
  else:
    Response::error("No deductions id");
  endif;
endif;
