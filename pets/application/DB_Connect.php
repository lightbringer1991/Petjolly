<?php
 
class DB_Connect {
 
    // constructor
    function __construct() 
    {
         
    }
 
    // destructor
    function __destruct() 
    {
        // $this->close();
    }
 
    // Connecting to database
    public function connect() 
    {
        require_once 'Config.php';
     
        $con = new PDO('mysql:host=localhost;dbname=srinione_sun;charset=utf8', "srinione_sun", "sun1234#");
        $con->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
 
        // return database handler
        return $con;
    }
 
    // Closing database connection
    public function close() 
    {
        // mysql_close();
    }
 
}
 
?>