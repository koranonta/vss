<?php
require_once('../classes/employees.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');
require_once '../classes/imagehandler.classes.php';
require_once '../classes/addresses.classes.php';

$employees = new Employees();
$addresses = new Addresses();
$imgHandler = new ImageHandler("/app/vss/backend/assets/images/avatars/");

$requestMethod = $_SERVER["REQUEST_METHOD"];
if ($requestMethod == 'GET'):
  $id = getId();
  if ($id):
    $res = $employees->getById($id);
    $response = array( "data" => $res );
    Response::success($response);
  else:
    $res = $employees->getAll();
    $response = array( "data" => $res );
    Response::success($response);
  endif;
  
//  POST employee  
elseif ($requestMethod == 'POST'):

  //  Handle employee
  $img = $_FILES['imgInput'];
  $imgName = isset($img) ? $img['name'] : $_POST['image'];
  $employee = array(
    'employeetypeid'         => $_POST['employeetypeid']
   ,'accountid'              => $_POST['accountid']
   ,'genderid'               => $_POST['genderid']
   ,'firstname'              => $_POST['firstname']
   ,'lastname'               => $_POST['lastname']
   ,'identificationcardid'   => $_POST['identificationcardid']
   ,'birthdate'              => $_POST['birthdate']
   ,'joindate'               => $_POST['joindate']
   ,'image'                  => $imgName
   ,'salary'                 => $_POST['salary']
   ,'positionsalary'         => $_POST['positionsalary']
   ,'loginid'                => -1
  );
  
  //var_dump($_POST);  
  //return;   
  
  $id = $_POST['employeeid'];
  if (isset($id)):
    $employee['employeeid'] = $id;
    $res    = $employees->update($employee);
    $okMsg  = 'Employee id [ ' . $id . ' ] updated';
    $errMsg = 'Unable to update Employee id [ ' . $id . ' ]';
  else:
    $res    = $employees->add($employee);
    $id     = $res[0]['employeeid'];
    $okMsg  = 'New employee added';
    $errMsg = 'Unable to add employee';
  endif;
  
  $resEmp = $res[0];
  
  if ($res):      
    //  Save image
    if (isset($img['name']) && $img['error'] == 0):
      $imgHandler->saveImage($img);
    endif;
    //  Handle address
    $address = isset($_POST['address']) 
      ? array(
        'addressid'   => $_POST['addressid']
       ,'address'     => $_POST['address']
       ,'street'      => $_POST['street']
       ,'subdistrict' => $_POST['subdistrict']
       ,'district'    => $_POST['district']
       ,'province'    => $_POST['province']
       ,'city'        => $_POST['city']
       ,'country'     => $_POST['country']
       ,'postcode'    => $_POST['postcode']
       ,'loginid'     => -1)
      : array();  
      
    //var_dump($res);      
    //echo "employeeid {$id}";
    
    if (isset($address)):
      $address['employeeid'] = $id;
      if (!isset($address['addressid']) || $address['addressid'] == '-1'):
        $addrRes = $addresses->add($address);
      else:
        $addrRes = $addresses->update($address);
      endif;
      if ($addrRes):
        $resEmp = array_merge($resEmp, $addrRes[0]);
      endif;
    endif; 

    $response = array( 'res' => $okMsg, 'employee' => $resEmp );
    Response::success($response);
  else:
    Response::error($errMsg);        
  endif;
       
elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $employees->delete($id, -1);
    if ($res):
      $response = array("res" => "employees {$id} deleted", "status" => $res);
      //  Delete address
      $addrRes = $addresses->delete($id, -1);
      Response::success($response);
    else:
      Response::error("Unable to delete employees {$id}");
    endif;
  else:
    Response::error("No employees id");
  endif;
endif;

