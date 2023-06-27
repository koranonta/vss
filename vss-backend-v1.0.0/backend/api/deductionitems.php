<?php
require_once('../classes/deductionitems.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$deductionitems = new DeductionItems();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $deductionitems->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  else:
    $res = $deductionitems->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  endif;
elseif ($requestMethod == 'POST'):
  $body = getBody();
  $res = $deductionitems->add($body);
  if ($res):
    $response = array(
      "res" => "Post new deductionitems", "body" => $body, "status" => $res
    );
    Response::success($response);
  else:
    Response::error("Unable to add deductionitems");
  endif;
elseif ($requestMethod == 'PUT'):
  $id = getId();
  if ($id):
    $body = getBody();
    $body += ["deductionitemid" => $id];
    $res = $deductionitems->update($body);
    if ($res):
      $response = array("res" => "deductionitems {$id} updated", "body" => $body, "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to update deductionitems {$id}");
    endif;
  else:
    Response::error("No deductionitems id");
  endif;
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $deductionitems->delete($id, -1);
    if ($res):
      $response = array("res" => "deductionitems {$id} deleted", "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to delete deductionitems {$id}");
    endif;
  else:
    Response::error("No deductionitems id");
  endif;
endif;
