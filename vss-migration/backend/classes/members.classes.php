<?php
require_once('db.classes.php');

class Members extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = "CALL spGetMembers(-1)";
    return $this->runQuery($query);
  }

}
