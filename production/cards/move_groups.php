<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");


if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
   
    if(isset($data['jwt']) && isset($data['groups']) && isset($data['user_id'])){

        if(validateJWT($data['jwt'])){ 

            for($y=0;$y<10;$y++){
            for($i=0;$i<count($data['groups'][$y]);$i++){
                if($data['groups'][$y][$i]){
                $sql = "UPDATE user_has_card_group SET position_x=:pos_x, position_y=:pos_y WHERE user_id=:user_id AND card_group_id=:group_id";

                    try{
                        $stmt = $db_connection->prepare($sql);
    
                        
                            $result =  $stmt->execute(array(
                                "pos_x" => $data['groups'][$y][$i]['x'],
                                "pos_y" => $data['groups'][$y][$i]['y'],
                                "user_id" => $data['user_id'],
                                "group_id" => $data['groups'][$y][$i]['id']
                            ));
                            if(!$result){

                                echo json_encode("error");

                            }

                            


                    }catch(PDOException $e){
                        echo json_encode("Błąd");
                    }
                }
            }
        }
            echo json_encode("success");

        }
    }
 }

 ?>