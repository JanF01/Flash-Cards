<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");


if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['id'])){

        if(validateJWT($data['jwt'])){ 
       
  
                $sql = "DELETE FROM card WHERE id=:id";

                
                    try{
                        $stmt = $db_connection->prepare($sql);
                        
                        $result =  $stmt->execute(array(
                            "id" => $data['id'],
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