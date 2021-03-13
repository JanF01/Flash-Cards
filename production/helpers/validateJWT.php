<?php

 
   function createSignature($header,$payload){
      $signature = hash_hmac('sha256',$header.".".$payload,'onenicesecretCODE',true);
      $base64UrlSignature = str_replace(['+','/','='],['-','_',''],base64_encode($signature));
      return $base64UrlSignature;
    }

   function validateJWT($jwt){

        $tokenParts = explode('.', $jwt);
        $header = base64_decode($tokenParts[0]);
        $payload = base64_decode($tokenParts[1]);
        $signatureProvided = $tokenParts[2];

        $base64UrlHeader = base64_encode($header);
        $base64UrlPayload = base64_encode($payload);

        $base64UrlSignature = createSignature($base64UrlHeader,$base64UrlPayload);
        
        return $base64UrlSignature===$signatureProvided;
   }



?>