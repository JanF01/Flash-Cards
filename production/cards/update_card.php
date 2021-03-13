<?php

require_once("../connections/connection.php");
require_once("../helpers/validateJWT.php");



if($json = file_get_contents("php://input")){

    $data = json_decode($json, true);

    if(isset($data["jwt"]) && isset($data['id']) && isset($data['difficulty']) && isset($data['importance']) && isset($data['seconds'])){

        if(validateJWT($data["jwt"])){
            $new_seconds = $data['seconds'];

            if($data['difficulty']==0){
                if($new_seconds<(3600*8)){
                    $new_seconds=(3600*8);
                }
                else{
                    if($new_seconds<(3600*144)){
                         $new_seconds+=round((3600*8)/intval($data['importance']));
                    }
                }
            }
            else if($data['difficulty']==1){
                if($new_seconds<10800){
                    $new_seconds = 10800;
                }else{
                    if($new_seconds<(3600*90)){
                      $new_seconds+=round((10800)/intval($data['importance']));
                    }
                }
            }
            else if($data['difficulty']==2){
                    $new_seconds = 900;
            }

            $sql = "UPDATE card SET last_check=:new_date, seconds=:new_seconds WHERE id=:id";

            try{
                $stmt = $db_connection->prepare($sql);

                $result = $stmt->execute(array(
                    "new_date" => date("Y-m-d H:i:s"),
                    "new_seconds" => $new_seconds,
                    "id" => $data['id']
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