<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");

if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['id']) && isset($data['front']) && isset($data['back']) && isset($data['importance']) && isset($data['one_sided'])){
        if(validateJWT($data['jwt'])){ 

          if((strlen($data['front'])<1 && strlen($data['back'])<1 && $data['one_sided']) || ((strlen($data['front'])<1 || strlen($data['back'])<1) && !$data['one_sided'])){
            echo json_encode("empty card");
            exit;
        }else{

        $sql = "UPDATE card SET front=:front, back=:back, importance=:importance, one_sided=:one_sided WHERE id=:card_id";

        try{
           $stmt = $db_connection->prepare($sql);
           
             $result =  $stmt->execute(array(
                 "front" => $data['front'],
                 "back" => $data['back'],
                 "importance" => $data['importance'],
                 "one_sided" => $data['one_sided'],
                 "card_id" => $data['id']
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
 }

 ?>