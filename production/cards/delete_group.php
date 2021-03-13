<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");


if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['group_id']) && isset($data['user_id'])){

        if(validateJWT($data['jwt'])){ 
       
  
                $sql = "SELECT owner FROM user_has_card_group WHERE user_id=:user_id";

                
                    try{
                        $stmt = $db_connection->prepare($sql);
                        
                        $result =  $stmt->execute(array(
                            "user_id" => $data['user_id'],
                        ));
                        if($result){
                            $owner = $stmt->fetch()['owner'];

                            $sql = $owner ? "DELETE FROM card_group WHERE id=:group_id" : "DELETE FROM user_has_card_group WHERE card_group_id=:group_id";

        
        

                            try{
                            $stmt = $db_connection->prepare($sql);
                            
                                $result =  $stmt->execute(array(
                                    "group_id" => $data['group_id'],
                                ));
                                if($result){
        
                                    echo json_encode("success");
        
                                }
        
                                
        
        
                        }catch(PDOException $e){
                            echo json_encode("Błąd");
                        }
                        }
            
            
                }catch(PDOException $e){
                    echo json_encode("Błąd");
                }


        }
    }
 }

 ?>