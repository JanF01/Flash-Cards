<?php

require_once("../connections/connection.php");

require_once("../helpers/validateJWT.php");


if($json = file_get_contents("php://input")){

    $data = json_decode($json,true);
  
    if(isset($data['jwt']) && isset($data['group']) && isset($data['front']) && isset($data['back']) && isset($data['importance']) && isset($data['one_sided'])){

        if(validateJWT($data['jwt'])){   

        if((strlen($data['front'])<1 && strlen($data['back'])<1 && $data['one_sided']) || ((strlen($data['front'])<1 || strlen($data['back'])<1) && !$data['one_sided'])){
            echo json_encode("empty card");
            exit;
        }else{

        $sql = "INSERT INTO card VALUES (null,:front,:back,:importance,:last_check,:one_sided,:card_group, 0)";

        try{
           $stmt = $db_connection->prepare($sql);
           if($stmt){
             $result =  $stmt->execute(array(
                 "front" => $data['front'],
                 "back" => $data['back'],
                 "importance" => $data['importance'],
                 "last_check" => date("Y-m-d H:i:s"),
                 "one_sided" => $data['one_sided'],
                 "card_group" => $data['group']
              ));
              if($result){

                $sql = "UPDATE card_group SET amount=amount+1 WHERE id=:group";
                $stmt = $db_connection->prepare($sql);
                $stmt->execute(array(
                    "group" => $data['group'],
                 ));
              
                echo json_encode("success");

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