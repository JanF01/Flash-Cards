<?php

class User {
    public $id;
    public $username;
    public $last_login;

    public function __construct($id, $username,$last_login){
        $this->id = $id;
        $this->username = $username;
        $this->last_login = $last_login;
    }
}

?>