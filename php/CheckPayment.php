<?php

	$client = new SoapClient("https://www.securpaycardportal.com/proxy/proxy.incoming/eftservice.asmx?wsdl", 
	    array(
	        'style'         => SOAP_RPC,
	        'use'           => SOAP_ENCODED,
	        'soap_version'  => SOAP_1_2,
	        'authentication'=> SOAP_AUTHENTICATION_DIGEST,
	        'ssl'           => array(
	            'ciphers'=> "SHA1",
	            'verify_peer' => false, 
	            'allow_self_signed' => true
	        ),
	        'https' => array(
	            'curl_verify_ssl_peer'  => false,
	            'curl_verify_ssl_host'  => false
	        ),
	        'cache_wsdl'    => WSDL_CACHE_NONE,
	        'cache_ttl'     => 86400,
	        'trace'         => true,
	        'exceptions' => false,
	        'location' => "https://www.securpaycardportal.com/proxy/proxy.incoming/eftservice.asmx",
	        'uri'=>"https://www.securpaycardportal.com/proxy/proxy.incoming/eftservice.asmx"
	));
	$user="----------";
	$pass = "---------------------------------------";
	$dateAux= "1900-01-01";
	$link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{');
    mysql_select_db('crmlexco_rlg');
	$query = "SELECT idFile FROM file WHERE paymentProcess = 1;";
	//$query = "SELECT idFile FROM file WHERE paymentProcess = 1 AND idFile IN (835313, 835311, 304492);";
	$result = mysql_query($query);
	if($result){
		while ($row = mysql_fetch_row($result)){
			//var_dump($row);
			$idFile = $row[0];
			$parametros = array(
		        "UserName"=> $user,
		        "PassWord"=> $pass,
		        "CardHolderID"=>$idFile
		    );
		    $ready = $client->__soapCall('FindEftByID', array($parametros));   
		    sleep(0.5);
	    	if (is_soap_fault($ready)) {
			    trigger_error("SOAP Fault: (faultcode: {$ready->faultcode}, faultstring: {$ready->faultstring})", E_USER_ERROR);
			    return false;
			}	
			else
	    	{   	
		        $value = new stdClass();
		        $value=$ready;
				if ($value->FindEftByIDResult->Message == "Success")
				{

					//echo "+++++++++++++++++++++++++++++".$idFile."+++++++++++++++++++++++++++++";
						$FeeList= new stdClass();
						$FeeList= $value->FindEftByIDResult->EFTList;
						//var_dump($FeeList);
						if(count($FeeList->EFTTransactionDetail)==1)
						{
				    		//var_dump($FeeList->EFTTransactionDetail[$i]->EftDate);
				    		if($FeeList->EFTTransactionDetail->StatusCode=="Settled")
				    		{
				    			echo "Este ". $idFile. " Pago ". $FeeList->EFTTransactionDetail->EftDate." <br> \n";
				    			$date = date("Y-m-d", strtotime($FeeList->EFTTransactionDetail->EftDate));
				    			if($dateAux< $date)
				    			{
				    				$dateAux=$date;
				    			}
				    		}
				    	}else if (count($FeeList->EFTTransactionDetail)>1)
				    	{
							for ($i=0; $i<count($FeeList->EFTTransactionDetail); $i++)
				    		{
				    			
				    			if($FeeList->EFTTransactionDetail[$i]->StatusCode=="Settled"){

				    				echo "Este ". $idFile. " Pago ". $FeeList->EFTTransactionDetail[$i]->EftDate." <br> \n";
				    				$date = date("Y-m-d", strtotime($FeeList->EFTTransactionDetail[$i]->EftDate));
				    				if($dateAux< $date)
				    				{
				    					$dateAux=$date;
				    				}
				    			}
				    		}				    		
				    	}

				    	echo "------------- y el ultimo pago de este ".$idFile." fue ". $dateAux. "<br> \n";
				    	$query = "UPDATE file SET lastPaymentDate = '".$dateAux."' WHERE idFile = ".$idFile;
					    mysql_query($query);
					    $dateAux = "1900-01-01"; //Init Date
			    }
				else
				{
				    echo $ready->Message."\n";
				    return false;
				} 
			}
			
		}
		echo "We have updated the state of Payments";
	}
    mysql_close($link);
 
?>