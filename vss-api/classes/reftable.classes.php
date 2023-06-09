<?php
require_once('db.classes.php');

class RefTable extends Db
{
  function __construct() {
    parent::__construct();
  }

  function getAll()
  {
    $query = 'CALL spGetRefTable()';
    return $this->runQuery($query);
  }

  function getById(( $refid ))
  {
    $query = 'CALL spGetRefTableById( $refid )';
    return $this->runQuery($query);
  }

  function delete( $refid )
  {
    $query = 'CALL spDeleteRefTable( :refid )';
    $stmt->bindParam(':refid', refid);
    if ($stmt->execute()) return 1;
    return 0
  }

  function update( $reftable )
  {
    $query = 'CALL spUpdateRefTable( :reftypekind, :reftypename, :loginid )';
    $stmt->bindParam(':reftypekind', $reftable['reftypekind']);
    $stmt->bindParam(':reftypename', $reftable['reftypename']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) return 1;
    return 0;
  }

  function add( $reftable )
  {
    $query = 'CALL spAddRefTable( :reftypekind, :reftypename, :loginid, @newId )';
    $stmt->bindParam(':reftypekind', $reftable['reftypekind']);
    $stmt->bindParam(':reftypename', $reftable['reftypename']);
    $stmt->bindParam(':loginid', loginid);
    if ($stmt->execute()) {
      $stmt->closeCursor();
      $row = $this->pdo->query("SELECT @newId as newId")->fetch(PDO::FETCH_ASSOC);
      echo $row;
      if ($row) 
        return $row !== false ? $row['newId'] : null;
      return null;
    }
    else return 0;
  }
}
