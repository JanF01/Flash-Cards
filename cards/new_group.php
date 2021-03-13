<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");


if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['user_id']) && isset($data['name']) && isset($data['color']) && isset($data['pos_x']) && isset($data['pos_y'])){

      if(validateJWT($data['jwt'])){   
        if(strlen($data['name'])<1){
            echo json_encode("too short");
            exit;
        }else{

        $sql = "INSERT INTO card_group VALUES (null,:name,:amount,:color)";

        try{
           $stmt = $db_connection->prepare($sql);
           if($stmt){
             $result =  $stmt->execute(array(
                 "name" => $data['name'],
                 "amount" => 0,
                 "color" => $data['color']
              ));
              if($result){

                $id = $db_connection->lastInsertId();

                $sql = "INSERT INTO user_has_card_group VALUES (:user_id,:card_group,:pos_y,:pos_x,:owner)";

                $stmt = $db_connection->prepare($sql);

                $result =  $stmt->execute(array(
                 "user_id" => $data["user_id"],
                 "card_group" => $id,
                 "pos_x" => $data['pos_x'],
                 "pos_y" => $data['pos_y'],
                 "owner" => 1
                ));

                if($result){
              
                echo json_encode("success");
                }

              }

            }


    }catch(PDOException $e){
        echo json_encode("Błąd");
    }

    }
 }
}
}





?>