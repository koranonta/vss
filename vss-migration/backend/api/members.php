<?php
require_once('../classes/members.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$members = new Members();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $res = $members->getAll();
  $response = array( "data" => $res );
  Response::success($response);
elseif ($requestMethod == 'POST'):
  echo ("Member post");
endif;

