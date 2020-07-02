<?php

    $email = "-----------------";
    $password = "--------";
    $integratorKey = "--------------------------";
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
     $envelopeId = $_REQUEST['retainerEnvelopeID'];
    $url = $baseUrl."/envelopes/".$envelopeId;
    curl_close($curl);


    $data = array("status" => "voided", "voidedReason" => "test");
    $data_string = json_encode($data);    

    $curl = curl_init($url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_POSTFIELDS,$data_string);                                                                  
    curl_setopt($curl, CURLOPT_HTTPHEADER, array(                                                                          
        'Content-Type: application/json',                                                                                
        'Content-Length: ' . strlen($data_string),
        "X-DocuSign-Authentication: $header" )                                                                       
    );
  


    $json_response = curl_exec($curl);
    $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    if ( $status != 200 ) {
        echo "error calling webservice, status is:" . $status . "\nerror text is --> ";
        var_dump($json_response); echo "\n";
        exit(-1);
    }  
    $response = json_decode($json_response, true);
    //$status = $response["status"];
    if($_REQUEST['retainerStatus']!="voided"){
        $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
        mysql_select_db('crmlexco_rlg') or die('No se pudo seleccionar la base de datos');
        $query = "UPDATE file SET retainerStatus = 'Voided' WHERE idFile = ".$_REQUEST['idFile'];
        $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());
        mysql_close($link);
    }
    var_dump($response);
?>