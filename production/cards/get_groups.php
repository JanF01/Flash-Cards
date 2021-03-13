<?php

require_once("../connections/connection.php");


require_once("../helpers/validateJWT.php");

    if(isset($_GET['jwt']) && isset($_GET['user_id'])){

        if(validateJWT($_GET['jwt'])){ 

        $sql = "SELECT u.position_y as y, u.position_x as x, c.id as id, c.name as name, c.amount as amount, c.color as color,
        u.owner as owner
         FROM user_has_card_group as u INNER JOIN card_group as c ON u.card_group_id=c.id WHERE u.user_id=:user_id";

        try{
           $stmt = $db_connection->prepare($sql);
           
             $result =  $stmt->execute(array(
                 "user_id" => $_GET['user_id'],
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