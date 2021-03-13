<?php

require_once("../connections/connection.php");


require_once("../helpers/validateJWT.php");

    if( isset($_GET['jwt']) && isset($_GET['user_id'])){

        if(validateJWT($_GET['jwt'])){ 

            $soonest_cards = array();

            try{

            $sql = "SELECT card_group_id FROM user_has_card_group WHERE user_id=:user_id";

            $stmt = $db_connection->prepare($sql);
           
             $result = $stmt->execute(array(
                "user_id" => $_GET['user_id'],
             ));

             if($result){
                 $groups = $stmt->fetchAll();
                 for($i=0;$i<count($groups);$i++){
                    $sql = "SELECT last_check, seconds, card_group_id FROM card WHERE card_group_id=:group";

                    $stmt = $db_connection->prepare($sql);

                    $stmt->execute(array(
                        "group" => $groups[$i]['card_group_id'],
                     ));

                     $cards = $stmt->fetchAll();

                     $soonest = 1000000000;
                     $soonest_card = null;
                     $current_seconds = time();

                     for($y=0;$y<count($cards);$y++){
                         $timestamp = strtotime(str_replace("-","/",$cards[$y]['last_check']));
                         $supposed_time = $timestamp+$cards[$y]['seconds'];
                         $time_to = $supposed_time-$current_seconds;
                         if($time_to<$soonest){
                            $soonest = $time_to;
                            $soonest_card = $cards[$y];
                         }
                     }

                     array_push($soonest_cards,$soonest_card);
                
                }

                echo json_encode($soonest_cards);
             }

            }catch(PDOException $e){
                echo json_encode("Błąd");
            }

    }
}
 





?>