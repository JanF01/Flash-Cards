<?php

   require_once("../connections/connection.php");
   require_once("../models/user.php");
   require_once("../helpers/createJWT.php");

  if($json = file_get_contents("php://input")){

     $data = json_decode($json,true);

     if(isset($data['username']) && isset($data['password'])){
            
            $sql = "SELECT username FROM users WHERE username = :user_name";

            try{
               $stmt = $db_connection->prepare($sql);
               if($stmt){
                 $result =  $stmt->execute(array(
                     "user_name" => $data['username']
                  ));
                  if($result){
                     
                    $user_for_check = $stmt->fetch(PDO::FETCH_ASSOC);

                     if($user_for_check){
                        echo json_encode("Nazwa użytkownika zajęta");
                        exit;
                     }

                     createUser($db_connection, $data['username'],$data['password']);

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
     echo json_encode("Wystąpił problem z wysyłaniem danych do serwera");
  }



   function createUser($db_connection, $username,$password){

    $sql = "INSERT INTO users (id, username, password, last_login) VALUES (null,:user_name,:user_password,:last_login)";

    try{
       $stmt = $db_connection->prepare($sql);

       $password = password_hash($password,PASSWORD_DEFAULT);
       $last_login = date("Y-m-d H:i:s");

       if($stmt){
         $result =  $stmt->execute(array(
             "user_name" => $username,
             "user_password" => $password,
             "last_login" => $last_login
          ));

         $id = $db_connection->lastInsertId();
         
          $user = new User(
              $id,
              $username,
              $last_login);

          $jwt = createJWT($user->id, $user->username,$user->last_login);
 
          $response = array('token' => $jwt);
          echo json_encode($response);

          
       }
    }catch(PDOException $e){
         echo json_encode("Wystąpił błąd z insertowaniem danych do bazy flashcards");
    }


   }


  ?>