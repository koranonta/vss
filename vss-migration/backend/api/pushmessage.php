<?php
require_once '../classes/response.classes.php';
require_once 'apiutil.php';

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'POST'):
  //  Get parameters
  $body = getBody();
  //print_r($body);  
  $auth = $body['auth'];
  $to   = $body['to'];
  $msg  = $body['msg'];
  
  //  Validate parameters
  $error = "";
  if (!isset($to))
    $error .= "Message destination is not defined";
  if (!isset($msg))	  
    $error .= strlen($error) > 0 ? "\nMessage content is empty" : "Message content is empty";
  if (strlen($error) > 0):
    Response::error($error);
	return;
  endif;
    
  //  Initialize message content
  $arrayPostData['to'] = $to;
  $arrayPostData['messages'][0]['type'] = "text";
  $arrayPostData['messages'][0]['text'] = $msg;
    
  //print_r($arrayPostData);
  
  $chOne = curl_init(); 
  curl_setopt( $chOne, CURLOPT_URL, "https://api.line.me/v2/bot/message/push"); 
  curl_setopt( $chOne, CURLOPT_SSL_VERIFYHOST, 0); 
  curl_setopt( $chOne, CURLOPT_SSL_VERIFYPEER, 0); 
  curl_setopt( $chOne, CURLOPT_POST, 1); 
  curl_setopt( $chOne, CURLOPT_POSTFIELDS, json_encode( $arrayPostData)); 

  $authorization_bearer = 'Authorization: Bearer 0HU7SPzuPbjJOX0jMZyvfWmhv1XsguJcPMOcTbOZ6T/Uvvg1pNTvKC/d6Z8wtYGd2AosqBoNxsG2nQ9AkyUwEfXr+a3y6qcZkHBo4+6uQEx7LbHrfpYSPvnkAr4Mqwiux0Xo8SHPZGZNOMrbX11TZAdB04t89/1O/w1cDnyilFU=';  
  if (isset($auth)):
    $authorization_bearer = $auth;
  endif;
  
  //  Initialize request header

  $headers = array( 
     'Content-type: application/json', 
      $authorization_bearer
	   );

  curl_setopt($chOne, CURLOPT_HTTPHEADER, $headers); 
  curl_setopt( $chOne, CURLOPT_RETURNTRANSFER, 1); 
  $result = curl_exec( $chOne ); 
  
  //print_r($headers);
  //print_r(json_encode($arrayPostData));

  //Result error 
  if(curl_error($chOne)):
    $res = 'error:' . curl_error($chOne); 
    Response::error("Unable to push message: " . $res);
  else:
    $result_ = json_decode($result, true); 
    $res = "status : ".$result_['status']; echo "message : ". $result_['message'];
    Response::success($res);
  endif;  
  curl_close( $chOne );
endif;
