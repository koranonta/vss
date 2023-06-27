<?php
class Db
{  
  private $host     = "localhost";
  private $user     = "lapatprc_vsskora";
  private $password = "pnpp65";
  private $dbName   = "lapatprc_vssdb";

  protected $pdo;

  function __construct()
  {
    $this->pdo = $this->connect();
  }

  protected function connect()
  {
    try {
      $dsn = "mysql:host={$this->host};dbname={$this->dbName}";
      $pdo = new PDO($dsn, $this->user, $this->password);      
      $pdo->query("SET CHARACTER SET utf8");
      $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $pdo;
    } catch (PDOException $e) {
      echo "Connection fail: " . $e->getMessage();
    }
  }

  protected function runQuery($query)
  {
    $stmt = $this->pdo->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }

  protected function execQuery($query, $params)
  {
    $stmt = $this->pdo->prepare($query);
    $stmt->execute($params);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }
}
