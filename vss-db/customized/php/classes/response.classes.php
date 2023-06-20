<?php
class Response {
  public static function success($result = [], $message = 'success', $code = 200) {
      $response = array (
        'status' => true,
        'response' => $result,
        'message' => $message
      );
      http_response_code($code);
      echo json_encode($response, \JSON_UNESCAPED_UNICODE);
  }
  
  public static function error($message = 'error', $code = 400) {
      $response = array (
        'status' => false,
        'message' => $message
      );
      http_response_code($code);
      echo json_encode($response, \JSON_UNESCAPED_UNICODE);
  }
}

?>