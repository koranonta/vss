<?php
require_once('../classes/employees.classes.php');
require_once('../classes/response.classes.php');
include_once('./apiutil.php');
require_once '../classes/imagehandler.classes.php';

$employees = new Employees();
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
elseif ($requestMethod == 'POST'):
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

  $id = $_POST['employeeid'];
  if (isset($id)):
    $employee['employeeid'] = $id
    $res    = $employees->update($employee);
    $okMsg  = 'Employee id [ ' . $id . ' ] updated';
    $errMsg = 'Unable to update Employee id [ ' . $id . ' ]';
  else:
    $res    = $employees->add($employee);
    $okMsg  = 'New employee added';
    $errMsg = 'Unable to add employee';
  endif;

  if ($res):
    $response = array( 'res' => $okMsg, 'employee' => $res );
    Response::success($response);
  else:
    Response::error($errMsg);
  endif;

  //  Save image
  if (isset($img['name']) && $img['error'] == 0):
    $imgHandler->saveImage($img);
  endif;

elseif ($requestMethod == 'DELETE'):
  $id = getId();
  if ($id):
    $res = $employees->delete($id, -1);
    if ($res):
      $response = array("res" => "employees {$id} deleted", "status" => $res);
      Response::success($response);
    else:
      Response::error("Unable to delete employees {$id}");
    endif;
  else:
    Response::error("No employees id");
  endif;
endif;

