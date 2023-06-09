<?php
// Allow from any origin
if(isset($_SERVER["HTTP_ORIGIN"])):
    // You can decide if the origin in $_SERVER['HTTP_ORIGIN'] is something you want to allow, or as we do here, just allow all
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
else:
    //No HTTP_ORIGIN set, so we allow any. You can disallow if needed here
    header("Access-Control-Allow-Origin: *");
endif;

header("Access-Control-Allow-Credentials: true");
header("Access-Control-Max-Age: 600");    // cache for 10 minutes

if($_SERVER["REQUEST_METHOD"] == "OPTIONS"):

    if (isset($_SERVER["HTTP_ACCESS_CONTROL_REQUEST_METHOD"]))
        header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); //Make sure you remove those you do not want to support

    if (isset($_SERVER["HTTP_ACCESS_CONTROL_REQUEST_HEADERS"]))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    //Just exit with 200 OK with the above headers for OPTIONS method
    exit(0);
endif;

//From here, handle the request as it is ok

function getId()
{
  if (isset($_GET['id']) && !empty($_GET['id'])) return $_GET['id'];
  return null;
}

function getParam($name) {
  return (isset($_GET[$name]) && !empty($_GET[$name])) ?  $_GET[$name] : null;
}

function getBody()
{
  $data = file_get_contents("php://input");
  if ($data) return json_decode($data, true);
  return null;
}

function getRoute() {
  $routeInfo = array();
  $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
  $route = explode( '/', $uri );
  //print_r($route);
  if (sizeof($route) >= 4):
    $routeInfo += ["resource" => $route[4]];
    if (sizeof($route) > 5 && sizeof(trim($route[5]))>0):
      $routeInfo += ["param" => $route[5]];
    endif;
  endif;
  return $routeInfo;
}
