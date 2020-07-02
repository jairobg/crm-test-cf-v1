<?php
    

    // Input your info here:
    $email = "------------";								// your account email (also where this signature request will be sent)
    $password = "----------------";											// your account password
    $integratorKey = "-------------------------------";	// your account integrator key, found on (Preferences -> API page)
    
    
    // construct the authentication header:
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
    $accountId = $response["loginAccounts"][0]["accountId"];
    $baseUrl = $response["loginAccounts"][0]["baseUrl"];
    curl_close($curl);


	$thisTextTabs = array( "textTabs" => array (
        // Cliente 
        array ( "tabLabel" => "name1",          "value" => $_REQUEST["name1"]),
        array ( "tabLabel" => "name1_1",        "value" => $_REQUEST["name1"]),
        array ( "tabLabel" => "name1_2",        "value" => $_REQUEST["name1"]),
        array ( "tabLabel" => "name1_3",        "value" => $_REQUEST["name1"]), 
        array ( "tabLabel" => "name1_4",        "value" => $_REQUEST["name1"]), 
        array ( "tabLabel" => "name1_5",        "value" => $_REQUEST["name1"]),
        array ( "tabLabel" => "nameBoth",        "value" => $_REQUEST["nameBoth"]),
        
        array ( "tabLabel" => "address",        "value" => $_REQUEST["address"]),
        array ( "tabLabel" => "city",           "value" => $_REQUEST["city"]), 
        array ( "tabLabel" => "state",          "value" => $_REQUEST["state"]),
        array ( "tabLabel" => "zip",            "value" => $_REQUEST["zip"]),
        array ( "tabLabel" => "homePhone",      "value" => $_REQUEST["homePhone"]),
        array ( "tabLabel" => "cellPhone",      "value" => $_REQUEST["cellPhone"]),
        array ( "tabLabel" => "businessPhone",  "value" => $_REQUEST["businessPhone"]),
        array ( "tabLabel" => "email",          "value" => $_REQUEST["email"]),
        array ( "tabLabel" => "dateBirth",      "value" => $_REQUEST["dateBirth"]),
        array ( "tabLabel" => "socialSecurity", "value" => $_REQUEST["socialSecurity"]),
        
        array ( "tabLabel" => "clientManualId",   "value" => $_REQUEST["clientManualId"]),
        array ( "tabLabel" => "clientManualId_1", "value" => $_REQUEST["clientManualId"]),
        
        // Cliente Secundario
        array ( "tabLabel" => "name2",  		  "value" => $_REQUEST["name2"]),
        array ( "tabLabel" => "name2_1",		  "value" => $_REQUEST["name2"]),
        array ( "tabLabel" => "scEmail",		  "value" => $_REQUEST["scEmail"]),
        array ( "tabLabel" => "scAddress",        "value" => $_REQUEST["scAddress"]),
        array ( "tabLabel" => "scCity",           "value" => $_REQUEST["scCity"]), 
        array ( "tabLabel" => "scState",          "value" => $_REQUEST["scState"]),
        array ( "tabLabel" => "scZip",            "value" => $_REQUEST["scZip"]),
        array ( "tabLabel" => "scHomePhone",      "value" => $_REQUEST["scHomePhone"]),
        array ( "tabLabel" => "scCellPhone",      "value" => $_REQUEST["scCellPhone"]),
        array ( "tabLabel" => "scBusinessPhone",  "value" => $_REQUEST["scBusinessPhone"]),
        array ( "tabLabel" => "scEmail",          "value" => $_REQUEST["scEmail"]),
        array ( "tabLabel" => "scDateBirth",      "value" => $_REQUEST["scDateBirth"]),
        array ( "tabLabel" => "scSocialSecurity", "value" => $_REQUEST["scSocialSecurity"]),

		// RAM
        // Cliente 
        array ( "tabLabel" => "ram_name1",          "value" => $_REQUEST["name1"]),
        array ( "tabLabel" => "ram_address",        "value" => $_REQUEST["address"]),
        array ( "tabLabel" => "ram_city",           "value" => $_REQUEST["city"]), 
        array ( "tabLabel" => "ram_state",          "value" => $_REQUEST["state"]),
        array ( "tabLabel" => "ram_zip",            "value" => $_REQUEST["zip"]),
        array ( "tabLabel" => "ram_homePhone",      "value" => $_REQUEST["homePhone"]),
        array ( "tabLabel" => "ram_cellPhone",      "value" => $_REQUEST["cellPhone"]),
        array ( "tabLabel" => "ram_businessPhone",  "value" => $_REQUEST["businessPhone"]),
        array ( "tabLabel" => "ram_email",          "value" => $_REQUEST["email"]),
        array ( "tabLabel" => "ram_dateBirth",      "value" => $_REQUEST["dateBirth"]),
        array ( "tabLabel" => "ram_socialSecurity", "value" => $_REQUEST["socialSecurity"]),
        // Cliente Secundario
        array ( "tabLabel" => "ram_name2",  		  "value" => $_REQUEST["name2"]),
        array ( "tabLabel" => "ram_scEmail",		  "value" => $_REQUEST["scEmail"]),
        array ( "tabLabel" => "ram_scAddress",        "value" => $_REQUEST["scAddress"]),
        array ( "tabLabel" => "ram_scCity",           "value" => $_REQUEST["scCity"]), 
        array ( "tabLabel" => "ram_scState",          "value" => $_REQUEST["scState"]),
        array ( "tabLabel" => "ram_scZip",            "value" => $_REQUEST["scZip"]),
        array ( "tabLabel" => "ram_scHomePhone",      "value" => $_REQUEST["scHomePhone"]),
        array ( "tabLabel" => "ram_scCellPhone",      "value" => $_REQUEST["scCellPhone"]),
        array ( "tabLabel" => "ram_scBusinessPhone",  "value" => $_REQUEST["scBusinessPhone"]),
        array ( "tabLabel" => "ram_scEmail",          "value" => $_REQUEST["scEmail"]),
        array ( "tabLabel" => "ram_scDateBirth",      "value" => $_REQUEST["scDateBirth"]),
        array ( "tabLabel" => "ram_scSocialSecurity", "value" => $_REQUEST["scSocialSecurity"]),


        // Intake
        array ( "tabLabel" => "itkBankName",            "value" => $_REQUEST["itkBankName"]),
        array ( "tabLabel" => "itkBankName_1",          "value" => $_REQUEST["itkBankName"]),
        array ( "tabLabel" => "itkAccountHolderName",   "value" => $_REQUEST["itkAccountHolderName"]),
        array ( "tabLabel" => "itkRoutingNumber",       "value" => $_REQUEST["itkRoutingNumber"]),
        array ( "tabLabel" => "itkAccountNumber",       "value" => $_REQUEST["itkAccountNumber"]),
        array ( "tabLabel" => "itkFirstInstallmentDate","value" => $_REQUEST["itkFirstInstallmentDate"]),
        array ( "tabLabel" => "itkRecurrentPaymentDate","value" => $_REQUEST["itkRecurrentPaymentDate"]),
        array ( "tabLabel" => "itkTotalRetainerFee",    "value" => $_REQUEST["itkTotalRetainerFee"]), 
        array ( "tabLabel" => "itkTotalRetainerFee_1",  "value" => $_REQUEST["itkTotalRetainerFee"]), 
        array ( "tabLabel" => "itkMonthlyRetainer",     "value" => $_REQUEST["itkMonthlyRetainer"]),
        array ( "tabLabel" => "itkDownPayment",         "value" => $_REQUEST["itkDownPayment"]), 
        array ( "tabLabel" => "itkDownPayment_1",       "value" => $_REQUEST["itkDownPayment"]), 
        array ( "tabLabel" => "itkProgramLenght",       "value" => $_REQUEST["itkProgramLenght"]),
        array ( "tabLabel" => "itkProgramLenght_1",     "value" => $_REQUEST["itkProgramLenght"]),
        array ( "tabLabel" => "itkMontlyPayment",   "value" => $_REQUEST["itkMontlyPayment"]),
        array ( "tabLabel" => "itkMontlyPayment_1", "value" => $_REQUEST["itkMontlyPayment"]),
        array ( "tabLabel" => "itkLitigationFee",   "value" => $_REQUEST["itkLitigationFee"]),
        array ( "tabLabel" => "itkTotalDeb",   		"value" => $_REQUEST["itkTotalDeb"]),
                                          
        // Intake payments list
        array ( "tabLabel" => "itkMontlyPayment1",  "value" => $_REQUEST["itkMontlyPayment1"]),
        array ( "tabLabel" => "itkMontlyPayment2",  "value" => $_REQUEST["itkMontlyPayment2"]),
        array ( "tabLabel" => "itkMontlyPayment3",  "value" => $_REQUEST["itkMontlyPayment3"]),
        array ( "tabLabel" => "itkMontlyPayment4",  "value" => $_REQUEST["itkMontlyPayment4"]),
        array ( "tabLabel" => "itkMontlyPayment5",  "value" => $_REQUEST["itkMontlyPayment5"]),
        array ( "tabLabel" => "itkMontlyPayment6",  "value" => $_REQUEST["itkMontlyPayment6"]),
        array ( "tabLabel" => "itkMontlyPayment7",  "value" => $_REQUEST["itkMontlyPayment7"]),
        array ( "tabLabel" => "itkMontlyPayment8",  "value" => $_REQUEST["itkMontlyPayment8"]),
        array ( "tabLabel" => "itkMontlyPayment9",  "value" => $_REQUEST["itkMontlyPayment9"]),
        array ( "tabLabel" => "itkMontlyPayment10", "value" => $_REQUEST["itkMontlyPayment10"]),
        array ( "tabLabel" => "itkMontlyPayment11", "value" => $_REQUEST["itkMontlyPayment11"]),
        array ( "tabLabel" => "itkMontlyPayment12", "value" => $_REQUEST["itkMontlyPayment12"]),
        array ( "tabLabel" => "itkMontlyPayment13", "value" => $_REQUEST["itkMontlyPayment13"]),
        array ( "tabLabel" => "itkMontlyPayment14", "value" => $_REQUEST["itkMontlyPayment14"]),
        array ( "tabLabel" => "itkMontlyPayment15", "value" => $_REQUEST["itkMontlyPayment15"]),
        array ( "tabLabel" => "itkMontlyPayment16", "value" => $_REQUEST["itkMontlyPayment16"]),
        array ( "tabLabel" => "itkMontlyPayment17", "value" => $_REQUEST["itkMontlyPayment17"]),
        array ( "tabLabel" => "itkMontlyPayment18", "value" => $_REQUEST["itkMontlyPayment18"]),
        array ( "tabLabel" => "itkMontlyPayment19", "value" => $_REQUEST["itkMontlyPayment19"]),
        array ( "tabLabel" => "itkMontlyPayment20", "value" => $_REQUEST["itkMontlyPayment20"]),
        array ( "tabLabel" => "itkMontlyPayment21", "value" => $_REQUEST["itkMontlyPayment21"]),
        array ( "tabLabel" => "itkMontlyPayment22", "value" => $_REQUEST["itkMontlyPayment22"]),
        array ( "tabLabel" => "itkMontlyPayment23", "value" => $_REQUEST["itkMontlyPayment23"]),
        array ( "tabLabel" => "itkMontlyPayment24", "value" => $_REQUEST["itkMontlyPayment24"]),
        array ( "tabLabel" => "itkMontlyPayment25", "value" => $_REQUEST["itkMontlyPayment25"]),
        array ( "tabLabel" => "itkMontlyPayment26", "value" => $_REQUEST["itkMontlyPayment26"]),
        array ( "tabLabel" => "itkMontlyPayment27", "value" => $_REQUEST["itkMontlyPayment27"]),
        array ( "tabLabel" => "itkMontlyPayment28", "value" => $_REQUEST["itkMontlyPayment28"]),
        array ( "tabLabel" => "itkMontlyPayment29", "value" => $_REQUEST["itkMontlyPayment29"]),
        array ( "tabLabel" => "itkMontlyPayment30", "value" => $_REQUEST["itkMontlyPayment30"]),
        array ( "tabLabel" => "itkMontlyPayment31", "value" => $_REQUEST["itkMontlyPayment31"]),
        array ( "tabLabel" => "itkMontlyPayment32", "value" => $_REQUEST["itkMontlyPayment32"]),
        array ( "tabLabel" => "itkMontlyPayment33", "value" => $_REQUEST["itkMontlyPayment33"]),
        array ( "tabLabel" => "itkMontlyPayment34", "value" => $_REQUEST["itkMontlyPayment34"]),
        array ( "tabLabel" => "itkMontlyPayment35", "value" => $_REQUEST["itkMontlyPayment35"]),
        array ( "tabLabel" => "itkMontlyPayment36", "value" => $_REQUEST["itkMontlyPayment36"]),
                                                
        array ( "tabLabel" => "itkFirstInstallmentDate1",   "value" => $_REQUEST["itkFirstInstallmentDate1"]),
        array ( "tabLabel" => "itkFirstInstallmentDate2",   "value" => $_REQUEST["itkFirstInstallmentDate2"]),
        array ( "tabLabel" => "itkFirstInstallmentDate3",   "value" => $_REQUEST["itkFirstInstallmentDate3"]),
        array ( "tabLabel" => "itkFirstInstallmentDate4",   "value" => $_REQUEST["itkFirstInstallmentDate4"]),
        array ( "tabLabel" => "itkFirstInstallmentDate5",   "value" => $_REQUEST["itkFirstInstallmentDate5"]),
        array ( "tabLabel" => "itkFirstInstallmentDate6",   "value" => $_REQUEST["itkFirstInstallmentDate6"]),
        array ( "tabLabel" => "itkFirstInstallmentDate7",   "value" => $_REQUEST["itkFirstInstallmentDate7"]),
        array ( "tabLabel" => "itkFirstInstallmentDate8",   "value" => $_REQUEST["itkFirstInstallmentDate8"]),
        array ( "tabLabel" => "itkFirstInstallmentDate9",   "value" => $_REQUEST["itkFirstInstallmentDate9"]),
        array ( "tabLabel" => "itkFirstInstallmentDate10",  "value" => $_REQUEST["itkFirstInstallmentDate10"]),
        array ( "tabLabel" => "itkFirstInstallmentDate11",  "value" => $_REQUEST["itkFirstInstallmentDate11"]),
        array ( "tabLabel" => "itkFirstInstallmentDate12",  "value" => $_REQUEST["itkFirstInstallmentDate12"]),
        array ( "tabLabel" => "itkFirstInstallmentDate13",  "value" => $_REQUEST["itkFirstInstallmentDate13"]),
        array ( "tabLabel" => "itkFirstInstallmentDate14",  "value" => $_REQUEST["itkFirstInstallmentDate14"]),
        array ( "tabLabel" => "itkFirstInstallmentDate15",  "value" => $_REQUEST["itkFirstInstallmentDate15"]),
        array ( "tabLabel" => "itkFirstInstallmentDate16",  "value" => $_REQUEST["itkFirstInstallmentDate16"]),
        array ( "tabLabel" => "itkFirstInstallmentDate17",  "value" => $_REQUEST["itkFirstInstallmentDate17"]),
        array ( "tabLabel" => "itkFirstInstallmentDate18",  "value" => $_REQUEST["itkFirstInstallmentDate18"]),
        array ( "tabLabel" => "itkFirstInstallmentDate19",  "value" => $_REQUEST["itkFirstInstallmentDate19"]),
        array ( "tabLabel" => "itkFirstInstallmentDate20",  "value" => $_REQUEST["itkFirstInstallmentDate20"]),
        array ( "tabLabel" => "itkFirstInstallmentDate21",  "value" => $_REQUEST["itkFirstInstallmentDate21"]),
        array ( "tabLabel" => "itkFirstInstallmentDate22",  "value" => $_REQUEST["itkFirstInstallmentDate22"]),
        array ( "tabLabel" => "itkFirstInstallmentDate23",  "value" => $_REQUEST["itkFirstInstallmentDate23"]),
        array ( "tabLabel" => "itkFirstInstallmentDate24",  "value" => $_REQUEST["itkFirstInstallmentDate24"]),
        array ( "tabLabel" => "itkFirstInstallmentDate25",  "value" => $_REQUEST["itkFirstInstallmentDate25"]),
        array ( "tabLabel" => "itkFirstInstallmentDate26",  "value" => $_REQUEST["itkFirstInstallmentDate26"]),
        array ( "tabLabel" => "itkFirstInstallmentDate27",  "value" => $_REQUEST["itkFirstInstallmentDate27"]),
        array ( "tabLabel" => "itkFirstInstallmentDate28",  "value" => $_REQUEST["itkFirstInstallmentDate28"]),
        array ( "tabLabel" => "itkFirstInstallmentDate29",  "value" => $_REQUEST["itkFirstInstallmentDate29"]),
        array ( "tabLabel" => "itkFirstInstallmentDate30",  "value" => $_REQUEST["itkFirstInstallmentDate30"]),
        array ( "tabLabel" => "itkFirstInstallmentDate31",  "value" => $_REQUEST["itkFirstInstallmentDate31"]),
        array ( "tabLabel" => "itkFirstInstallmentDate32",  "value" => $_REQUEST["itkFirstInstallmentDate32"]),
        array ( "tabLabel" => "itkFirstInstallmentDate33",  "value" => $_REQUEST["itkFirstInstallmentDate33"]),
        array ( "tabLabel" => "itkFirstInstallmentDate34",  "value" => $_REQUEST["itkFirstInstallmentDate34"]),
        array ( "tabLabel" => "itkFirstInstallmentDate35",  "value" => $_REQUEST["itkFirstInstallmentDate35"]),
        array ( "tabLabel" => "itkFirstInstallmentDate36",  "value" => $_REQUEST["itkFirstInstallmentDate36"]), 

        array ( "tabLabel" => "sumTotalMonthlyPayment",  "value" => $_REQUEST["sumTotalMonthlyPayment"]), 
                 
        // Debt holder list
        array ( "tabLabel" => "debtHolderName1",    "value" => $_REQUEST["debtHolderName1"]),
        array ( "tabLabel" => "debtHolderAccount1", "value" => $_REQUEST["debtHolderAccount1"]),
        array ( "tabLabel" => "debtHolderBalance1", "value" => $_REQUEST["debtHolderBalance1"]),
        array ( "tabLabel" => "debtHolderName2",    "value" => $_REQUEST["debtHolderName2"]),
        array ( "tabLabel" => "debtHolderAccount2", "value" => $_REQUEST["debtHolderAccount2"]),
        array ( "tabLabel" => "debtHolderBalance2", "value" => $_REQUEST["debtHolderBalance2"]),
        array ( "tabLabel" => "debtHolderName3",    "value" => $_REQUEST["debtHolderName3"]), 
        array ( "tabLabel" => "debtHolderAccount3", "value" => $_REQUEST["debtHolderAccount3"]),
        array ( "tabLabel" => "debtHolderBalance3", "value" => $_REQUEST["debtHolderBalance3"]),
        array ( "tabLabel" => "debtHolderName4",    "value" => $_REQUEST["debtHolderName4"]),   
        array ( "tabLabel" => "debtHolderAccount4", "value" => $_REQUEST["debtHolderAccount4"]),
        array ( "tabLabel" => "debtHolderBalance4", "value" => $_REQUEST["debtHolderBalance4"]),
        array ( "tabLabel" => "debtHolderName5",    "value" => $_REQUEST["debtHolderName5"]),   
        array ( "tabLabel" => "debtHolderAccount5", "value" => $_REQUEST["debtHolderAccount5"]),
        array ( "tabLabel" => "debtHolderBalance5", "value" => $_REQUEST["debtHolderBalance5"]),
        array ( "tabLabel" => "debtHolderName6",    "value" => $_REQUEST["debtHolderName6"]),   
        array ( "tabLabel" => "debtHolderAccount6", "value" => $_REQUEST["debtHolderAccount6"]),
        array ( "tabLabel" => "debtHolderBalance6", "value" => $_REQUEST["debtHolderBalance6"]),
        array ( "tabLabel" => "debtHolderName7",    "value" => $_REQUEST["debtHolderName7"]), 
        array ( "tabLabel" => "debtHolderAccount7", "value" => $_REQUEST["debtHolderAccount7"]), 
        array ( "tabLabel" => "debtHolderBalance7", "value" => $_REQUEST["debtHolderBalance7"]), 
        array ( "tabLabel" => "debtHolderName8",    "value" => $_REQUEST["debtHolderName8"]),   
        array ( "tabLabel" => "debtHolderAccount8", "value" => $_REQUEST["debtHolderAccount8"]),
        array ( "tabLabel" => "debtHolderBalance8", "value" => $_REQUEST["debtHolderBalance8"]),
        array ( "tabLabel" => "debtHolderName9",    "value" => $_REQUEST["debtHolderName9"]),   
        array ( "tabLabel" => "debtHolderAccount9", "value" => $_REQUEST["debtHolderAccount9"]),
        array ( "tabLabel" => "debtHolderBalance9", "value" => $_REQUEST["debtHolderBalance9"]),
        array ( "tabLabel" => "debtHolderName10",   "value" => $_REQUEST["debtHolderName10"]),  
        array ( "tabLabel" => "debtHolderAccount10","value" => $_REQUEST["debtHolderAccount10"]),
        array ( "tabLabel" => "debtHolderBalance10","value" => $_REQUEST["debtHolderBalance10"]),
        array ( "tabLabel" => "debtHolderName11",   "value" => $_REQUEST["debtHolderName11"]),   
        array ( "tabLabel" => "debtHolderAccount11","value" => $_REQUEST["debtHolderAccount11"]),
        array ( "tabLabel" => "debtHolderBalance11","value" => $_REQUEST["debtHolderBalance11"]),
        array ( "tabLabel" => "debtHolderName12",   "value" => $_REQUEST["debtHolderName12"]),   
        array ( "tabLabel" => "debtHolderAccount12","value" => $_REQUEST["debtHolderAccount12"]),
        array ( "tabLabel" => "debtHolderBalance12","value" => $_REQUEST["debtHolderBalance12"]),
        array ( "tabLabel" => "debtHolderName13",   "value" => $_REQUEST["debtHolderName13"]),   
        array ( "tabLabel" => "debtHolderAccount13","value" => $_REQUEST["debtHolderAccount13"]),
        array ( "tabLabel" => "debtHolderBalance13","value" => $_REQUEST["debtHolderBalance13"]),
        array ( "tabLabel" => "debtHolderName14",   "value" => $_REQUEST["debtHolderName14"]),   
        array ( "tabLabel" => "debtHolderAccount14","value" => $_REQUEST["debtHolderAccount14"]),
        array ( "tabLabel" => "debtHolderBalance14","value" => $_REQUEST["debtHolderBalance14"]),
        array ( "tabLabel" => "debtHolderName15",   "value" => $_REQUEST["debtHolderName15"]),   
        array ( "tabLabel" => "debtHolderAccount15","value" => $_REQUEST["debtHolderAccount15"]),
        array ( "tabLabel" => "debtHolderBalance15","value" => $_REQUEST["debtHolderBalance15"]),
        array ( "tabLabel" => "debtHolderName16",   "value" => $_REQUEST["debtHolderName16"]),   
        array ( "tabLabel" => "debtHolderAccount16","value" => $_REQUEST["debtHolderAccount16"]),
        array ( "tabLabel" => "debtHolderBalance16","value" => $_REQUEST["debtHolderBalance16"]),
        array ( "tabLabel" => "debtHolderName17",   "value" => $_REQUEST["debtHolderName17"]),   
        array ( "tabLabel" => "debtHolderAccount17","value" => $_REQUEST["debtHolderAccount17"]),
        array ( "tabLabel" => "debtHolderBalance17","value" => $_REQUEST["debtHolderBalance17"]),
        array ( "tabLabel" => "debtHolderName18",   "value" => $_REQUEST["debtHolderName18"]),   
        array ( "tabLabel" => "debtHolderAccount18","value" => $_REQUEST["debtHolderAccount18"]),
        array ( "tabLabel" => "debtHolderBalance18","value" => $_REQUEST["debtHolderBalance18"]),
        array ( "tabLabel" => "debtHolderName19",   "value" => $_REQUEST["debtHolderName19"]),   
        array ( "tabLabel" => "debtHolderAccount19","value" => $_REQUEST["debtHolderAccount19"]),
        array ( "tabLabel" => "debtHolderBalance19","value" => $_REQUEST["debtHolderBalance19"]),
        array ( "tabLabel" => "debtHolderName20",   "value" => $_REQUEST["debtHolderName20"]),   
        array ( "tabLabel" => "debtHolderAccount20","value" => $_REQUEST["debtHolderAccount20"]),
        array ( "tabLabel" => "debtHolderBalance20","value" => $_REQUEST["debtHolderBalance20"]),
        array ( "tabLabel" => "debtHolderName21",   "value" => $_REQUEST["debtHolderName21"]),   
        array ( "tabLabel" => "debtHolderAccount21","value" => $_REQUEST["debtHolderAccount21"]),
        array ( "tabLabel" => "debtHolderBalance21","value" => $_REQUEST["debtHolderBalance21"]),
        array ( "tabLabel" => "debtHolderName22",   "value" => $_REQUEST["debtHolderName22"]),   
        array ( "tabLabel" => "debtHolderAccount22","value" => $_REQUEST["debtHolderAccount22"]),
        array ( "tabLabel" => "debtHolderBalance22","value" => $_REQUEST["debtHolderBalance22"])                                    
    ));








    if($_REQUEST["retainerTemplate"]=="simple"){

        $templateId = "6839E568-E0A6-469A-9E92-49AAB4B75E24";
        if ($_REQUEST["superAffiliateEmail"]!="none"){
            
            $data = array("accountId" => $accountId, 
            "emailSubject" => "Ramsaran Law Group has sent you a retainer to review and sign", // Asunto
            "emailBlurb" => "Please review and sign the attached retainer via Docusign",
            "customFields" => "",//campo para verificar
            "templateId" => $templateId, //identificador del template
            "templateRoles" => array( 
                                    
                        array( "email" => $_REQUEST["email"], "name" => $_REQUEST["name1"], "roleName" => "Client", "tabs" => $thisTextTabs),
                        array( "email" => "admin@ramsaranlawgroup.com", "name" => "Ramsaran Law Group", "roleName" => "Attorney" ),
                        array( "email" => $_REQUEST["userEmail"], "name" => $_REQUEST["userName"], "roleName" => "Transmitter" ),
                        array( "email" => $_REQUEST["superAffiliateEmail"], "name" => "superAffiliateEmail", "roleName" => "superAffiliate" )
                    ),
                    
            "status" => "sent");                                                                    
        }else{
            $data = array("accountId" => $accountId, 
                "emailSubject" => "Ramsaran Law Group has sent you a retainer to review and sign", // Asunto
                "emailBlurb" => "Please review and sign the attached retainer via Docusign",
                "customFields" => "",//campo para verificar
                "templateId" => $templateId, //identificador del template
                "templateRoles" => array( 
                                        
                            array( "email" => $_REQUEST["email"], "name" => $_REQUEST["name1"], "roleName" => "Client", "tabs" => $thisTextTabs),
                            array( "email" => "admin@ramsaranlawgroup.com", "name" => "Ramsaran Law Group", "roleName" => "Attorney" ),
                            array( "email" => $_REQUEST["userEmail"], "name" => $_REQUEST["userName"], "roleName" => "Transmitter" )
                            //array( "email" => "barcoleon@hotmail.com", "name" => $_REQUEST["name2"], "roleName" => "Client2" )
                        ),
                        
                "status" => "sent");                                                                    
        }
        

    }else if ($_REQUEST["retainerTemplate"]== "double"){

        $templateId = "4EFA79DF-C249-48D5-9B03-297720BE3C81";
        if ($_REQUEST["superAffiliateEmail"]!="none")
        {
            $data = array("accountId" => $accountId, 
            "emailSubject" => "Ramsaran Law Group has sent you a retainer to review and sign", // Asunto
            "emailBlurb" => "Please review and sign the attached retainer via Docusign",
            "customFields" => "",//campo para verificar
            "templateId" => $templateId, //identificador del template
            "templateRoles" => array( 
                        array( "email" => $_REQUEST["email"], "name" => $_REQUEST["name1"], "roleName" => "Client", "tabs" => $thisTextTabs),
                        array( "email" => "admin@ramsaranlawgroup.com", "name" => "Ramsaran Law Group", "roleName" => "Attorney" ),
                        array( "email" => $_REQUEST["scEmail"], "name" => $_REQUEST["name2"], "roleName" => "Client2" ),
                        array( "email" => $_REQUEST["userEmail"], "name" => $_REQUEST["userName"], "roleName" => "Transmitter" ),
                        array( "email" => $_REQUEST["superAffiliateEmail"], "name" => "superAffiliateEmail", "roleName" => "superAffiliate" )
                    ),
                    
            "status" => "sent");
        } 
        else
        {
            $data = array("accountId" => $accountId, 
            "emailSubject" => "Ramsaran Law Group has sent you a retainer to review and sign", // Asunto
            "emailBlurb" => "Please review and sign the attached retainer via Docusign",
            "customFields" => "",//campo para verificar
            "templateId" => $templateId, //identificador del template
            "templateRoles" => array( 
                        array( "email" => $_REQUEST["email"], "name" => $_REQUEST["name1"], "roleName" => "Client", "tabs" => $thisTextTabs),
                        array( "email" => "admin@ramsaranlawgroup.com", "name" => "Ramsaran Law Group", "roleName" => "Attorney" ),
                        array( "email" => $_REQUEST["scEmail"], "name" => $_REQUEST["name2"], "roleName" => "Client2" ),
                        array( "email" => $_REQUEST["userEmail"], "name" => $_REQUEST["userName"], "roleName" => "Transmitter" )
                        
                    ),
                    
            "status" => "sent");
        }
        

    }

    
    $data_string = json_encode($data);  
    $curl = curl_init($baseUrl . "/envelopes" );
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);                                                                  
    curl_setopt($curl, CURLOPT_HTTPHEADER, array(                                                                          
        'Content-Type: application/json',                                                                                
        'Content-Length: ' . strlen($data_string),
        "X-DocuSign-Authentication: $header" )                                                                       
    );
    
    $json_response = curl_exec($curl);
    $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    if ( $status != 201 ) {
        echo "error calling webservice, status is:" . $status . "\nerror text is --> ";
        print_r($json_response); echo "\n";
        exit(-1);
    }
    
    $response = json_decode($json_response, true);
    $envelopeId = $response["envelopeId"];
    $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
    mysql_select_db('crmlexco_rlg') or die('No se pudo seleccionar la base de datos');
    
    $query = "UPDATE file SET retainerEnvelopeID =  '".$envelopeId."', retainerStatus = 'In Process' WHERE idFile = '".$_REQUEST["idFile"]."'";
    $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());
    mysql_close($link);
    
    // --- display results
    echo "Document is sent! Envelope ID = " . $envelopeId . "\n\n"; 
    
?>