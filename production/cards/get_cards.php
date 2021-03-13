<?php

require_once("../connections/connection.php");


require_once("../helpers/validateJWT.php");

    if( isset($_GET['jwt']) && isset($_GET['group'])){

        if(validateJWT($_GET['jwt'])){ 

        $sql = "SELECT id, front, back, importance, last_check, one_sided, seconds FROM card WHERE card_group_id=:group ";

        try{
           $stmt = $db_connection->prepare($sql);
           
             $result =  $stmt->execute(array(
                 "group" => $_GET['group'],
              ));
              if($result){
                $card_groups = $stmt->fetchAll(PDO::FETCH_ASSOC);

                echo json_encode($card_groups);

              }

            


    }catch(PDOException $e){
        echo json_encode("Błąd");
    }

    }
}
 





?>