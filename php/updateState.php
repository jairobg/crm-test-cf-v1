<?php

     $email = "----------------------";
     $password = "-----------";
     $integratorKey = "-----------------------------";
     $header =  array('Username' => $email, 'Password'=> $password, 'IntegratorKey'=>$integratorKey);
     $header = json_encode($header);
     $url = "https://na2.docusign.net/restapi/v2/login_information?api_password=true&include_account_id_guid=true&login_settings=all";

     $curl = curl_init($url);
     curl_setopt($curl, CURLOPT_HEADER, false);
     curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
     curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
     curl_setopt($curl, CURLOPT_HTTPHEADER, array("X-DocuSign-Authentication: ".$header));
     $json_response = curl_exec($curl);
     $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
     if ( $status != 200 ) {
          echo "error calling webservice, status is:" . $status;
          exit(-1);
     }
     $response = json_decode($json_response, true);
     //var_dump($response);
     
     $baseUrl = $response["loginAccounts"][0]["baseUrl"];
     $url = $baseUrl."/envelopes/".$_REQUEST['retainerEnvelopeID'];
     curl_close($curl);
     
     $curl = curl_init($url);
     curl_setopt($curl, CURLOPT_HEADER, false);
     curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
     curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
     curl_setopt($curl, CURLOPT_HTTPHEADER, array("X-DocuSign-Authentication: ".$header ));
          
      $json_response = curl_exec($curl);
      $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
      if ( $status != 200 ) {
          echo "error calling webservice, status is:" . $status . "\nerror text is --> ";
          print_r($json_response); echo "\n";
          exit(-1);
      }  
      $response = json_decode($json_response, true);
      $statusGeneral = $response["status"];

      
      $url = $url."/recipients";
      curl_close($curl);
     
      $curl = curl_init($url);
      curl_setopt($curl, CURLOPT_HEADER, false);
      curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
      curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
      curl_setopt($curl, CURLOPT_HTTPHEADER, array("X-DocuSign-Authentication: ".$header ));
      
      $json_response = curl_exec($curl);
      $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
      if ( $status != 200 ) {
          echo "error calling webservice, status is:" . $status . "\nerror text is --> ";
          print_r($json_response); echo "\n";
          exit(-1);
      }  
      
     
      
      $retainerStatusClient1 = "";
      $retainerStatusClient2 = "";
      $retainerStatusAttorney = "";  
      $contenedor= json_decode($json_response, true);
      $arre = $contenedor["signers"];


      if(count($arre)==2){
        $retainerStatusClient1=$arre[0]["status"];
        $retainerStatusAttorney=$arre[1]["status"];
      }else if(count($arre)==3){
        $retainerStatusClient1 = $arre[0]["status"];
      $retainerStatusClient2 = $arre[1]["status"];
      $retainerStatusAttorney = $arre[2]["status"]; 
      } 
      

       $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
          mysql_select_db('crmlexco_rlg') or die('No se pudo seleccionar la base de datos');
          $query = "UPDATE file SET retainerStatus = '".$statusGeneral."', retainerStatusClient1 = '".$retainerStatusClient1."', retainerStatusClient2 = '".$retainerStatusClient2."', retainerStatusAttorney = '".$retainerStatusAttorney."' WHERE idFile = ".$_REQUEST['idFile'];
          $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());
          mysql_close($link);
    
      
	  var_dump($json_response);
?>