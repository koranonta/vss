<?php

class ImageHandler {
  function __construct($imagePath) { 
	  $this->imagePath = $imagePath;
  }	
  
  function saveImage($img) {
	try {
	  
      //print_r($img);
      $allow = array('jpg', 'jpeg', 'png');
      $extension = explode(".", $img['name']);
      $fileActExt = strtolower(end($extension));
      $filePath = $_SERVER['DOCUMENT_ROOT'] . $this->imagePath . $img['name'];
	  //echo $filePath;
	  
      if (in_array($fileActExt, $allow)) {
        if ($img['size'] > 0 && $img['error'] == 0) {
          if (move_uploaded_file($img['tmp_name'], $filePath)) {
            return true;
          }
        }
      }
	}
	catch(Exception $e) {
	  echo "Unable to save image: " . $e->getMessage();
	}
	return false;
  }	
}
