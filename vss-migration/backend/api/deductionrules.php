<?php
require_once('../classes/deductions.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$deductions = new Deductions();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $res = $deductions->getDeductionRules();
  $response = array( "data" => $res );
  Response::success($response);
endif;
