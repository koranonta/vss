<?php
require_once('../classes/addresses.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');

$addresses = new Addresses();

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $addresses->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  else:
    $res = $addresses->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  endif;
elseif ($requestMethod == 'POST'):

  $address = array(
    'employeeid'  => $_POST['employeeid']
   ,'address'     => $_POST['address']
   ,'subdistrict' => $_POST['subdistrict']
   ,'district'    => $_POST['district']
   ,'street'      => $_POST['street']
   ,'city'        => $_POST['city']
   ,'province'    => $_POST['province']
   ,'country'     => $_POST['country']
   ,'postcode'    => $_POST['postcode']
   ,'loginid'     => -1
  );

  $id = $_POST['addressid'];
  if (isset($id)):
    $address['addressid'] = $id;
    $res    = $addresses->update($address);
    $okMsg  = 'Address id [ ' . $id . ' ] updated';
    $errMsg = 'Unable to update Address id [ ' . $id . ' ]';
  else:
    $res    = $addresses->add($address);
    $okMsg  = 'New address added';
    $errMsg = 'Unable to add address';
  endif;

  if ($res):
    $response = array( 'res' => $okMsg, 'address' => $res );
    Response::success($response);
  else:
    Response::error($errMsg);
  endif;

elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $addresses->delete($id, -1);
    if ($res):
      $response = array("res" => "addresses {$id} deleted", "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to delete addresses {$id}");
    endif;
  else:
    Response::error("No addresses id");
  endif;
endif;

