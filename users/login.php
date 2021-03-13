<?php

   require_once("../connections/connection.php");
   require_once("../models/user.php");
   require_once("../helpers/createJWT.php");
   require_once("../helpers/updateLastLogin.php");

  if($json = file_get_contents("php://input")){

     $data = json_decode($json,true);
   
     if(isset($data['password']) && isset($data['username'])){

          if(strlen($data['password'])<1 || strlen($data['username'])<1){
             echo json_encode("Niepoprawna data");
             exit;
          }
            
            $sql = "SELECT id, username, password FROM users WHERE username = :user_name";

            try{
               $stmt = $db_connection->prepare($sql);
               if($stmt){
                 $result =  $stmt->execute(array(
                     "user_name" => $data['username']
                  ));
                  if($result){
                     $user_for_check = $stmt->fetch();

                     if(!$user_for_check){
                        echo json_encode("Brak użytkownika");
                        exit;
                     }

                     $hashed_password = $user_for_check['password'];
                     $last_login = date("Y-m-d H:i:s");

                     if(password_verify($data['password'],$hashed_password)){

                         $user = new User($user_for_check['id'],$user_for_check['username'],
                        $last_login);

                         updateLastLogin($user->username,$user->last_login);

                         $jwt = createJWT($user->id, $user->username,$user->last_login);
 
                         $response = array('token' => $jwt);
                         echo json_encode($response);

                     }else{
                        echo json_encode("Błędne hasło"); 
                     }

                  }else{
                     $error = $stmt->errorInfo();
                     echo json_encode("Błąd podczas wykonywania zapytania: ".$error);
                  }
               }
            }catch(PDOException $e){
                 echo json_encode("Wystąpił błąd z pobieraniem danych z bazy InkWho");
            }
     }

  }else{
     echo json_encode("Wypełnij formularz");
  }




?>