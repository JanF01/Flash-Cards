<?php

require_once("../connections/connection.php");


require_once("../helpers/validateJWT.php");

if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['id']) && isset($data['name']) && isset($data['amount']) && isset($data['color']) && isset($data['owner'])){

        if(validateJWT($data['jwt']) && $data['owner']){ 


                $sql = "UPDATE card_group SET name=:name, amount=:amount, color=:color WHERE id=:group_id";

                try{
                $stmt = $db_connection->prepare($sql);
                
                    $result =  $stmt->execute(array(
                        "name" => $data['name'],
                        "amount" => $data['amount'],
                        "color" => $data['color'],
                        "group_id" => $data['id']
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