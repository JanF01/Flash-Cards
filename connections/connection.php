<?php

$dbhost = "127.0.0.1";
$dbname = "flashcards";
$dbuser = "root";
$dbpassword = "zonetoit";

try{
$db_connection = new PDO("mysql:host=".$dbhost.";dbname=".$dbname, $dbuser, $dbpassword);
}
catch(PDOException $e){
   echo "Błąd podczas łączenia się z bazą danych";
}

?>