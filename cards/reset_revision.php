<?php

require_once("../connections/connection.php");
require_once("../helpers/validateJWT.php");



if($json = file_get_contents("php://input")){

    $data = json_decode($json, true);

    if(isset($data["jwt"]) && isset($data['group_id'])){

        if(validateJWT($data["jwt"])){

            $sql = "UPDATE card SET seconds=:new_seconds WHERE card_group_id=:group_id";

            try{
                $stmt = $db_connection->prepare($sql);

                $result = $stmt->execute(array(
                    "new_seconds" => 0,
                    "group_id" => $data["group_id"]
                ));

                if($result){
                    echo json_encode("success");
                }
                
            }catch(PDOException $e){
                echo json_encode("Błąd");
            }
        }



    }


}





?>