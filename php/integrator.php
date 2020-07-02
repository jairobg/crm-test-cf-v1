    <?php 
    class PaytooAccountType
    {  
        var $user_id = null; 
        var $wallet = null; 
        var $currency = null; 
        var $balance = null; 
        var $registered_phone = null; 
        var $sim_phonenumber = null; 
        var $prepaidcard = null; 
        var $email = null; 
        var $password = null; 
        var $gender = null; 
        var $firstname = null; 
        var $middlename = null; 
        var $lastname = null; 
        var $address = null; 
        var $city = null; 
        var $zipcode = null; 
        var $country = null; 
        var $state = null; 
        var $phone = null; 
        var $birthday = null; 
        var $security_code = null; 
        var $question1 = null; 
        var $answer1 = null; 
        var $question2 = null; 
        var $answer2 = null; 
        var $question3 = null; 
        var $answer3 = null; 
        var $citizenship = null; 
        var $id_type = null; 
        var $id_issued_by_country = null; 
        var $id_issued_by_state = null; 
        var $id_number = null; 
        var $id_expiration = null; 
        var $ssn_number = null; 
        var $max_pin = null; 
        var $dist_id = null; 
        var $res_id = null; 
        var $pos_id = null; 
        var $document1 = null; 
        var $document2 = null; 
        var $document3 = null; 
        var $custom_field1 = null; 
        var $custom_field2 = null; 
        var $custom_field3 = null; 
        var $custom_field4 = null; 
        var $custom_field5 = null; 
        var $level = null; 
    }

    class PaytooAccountTypeDistribute
    {
        var $user_id    =   null;
        var $wallet =   null;
        var $currency   =   null;
        var $balance    =   null;
        var $registered_phone   =   null;
        var $max_pin    =   null;
        var $sim_phonenumber    =   null;
        var $prepaidcard    =   null;
        var $email  =   null;
        var $password   =   null;
        var $gender =   null;
        var $firstname  =   null;
        var $middlename =   null;
        var $lastname   =   null;
        var $address    =   null;
        var $city   =   null;
        var $zipcode    =   null;
        var $country    =   null;
        var $state  =   null;
        var $phone  =   null;
        var $birthday   =   null;
        var $security_code  =   null;
        var $question1  =   null;
        var $answer1    =   null;
        var $question2  =   null;
        var $answer2    =   null;
        var $question3  =   null;
        var $answer3    =   null;
        var $citizenship    =   null;
        var $id_type    =   null;
        var $id_issued_by_country   =   null;
        var $id_issued_by_state =   null;
        var $id_number  =   null;
        var $id_expiration  =   null;
        var $dist_id    =   null;
        var $res_id =   null;
        var $document1  =   null;
        var $document2  =   null;
        var $document3  =   null;
        var $custom_field1  =   null;
        var $custom_field2  =   null;
        var $custom_field3  =   null;
        var $custom_field4  =   null;
        var $custom_field5 =  null;
        var $level = null;
    }

    class PaytooBankAccount
    {
        var $bank_id = null; 
        var $bank_type = null; 
        var $bank_currency = null; 
        var $bank_name = null; 
        var $bank_country = null; 
        var $bank_state = null; 
        var $bank_location = null; 
        var $bank_address = null; 
        var $Bank_zip = null; 
        var $bank_phone = null; 
        var $bank_code = null; 
        var $bank_account = null; 
        var $bank_swift = null; 
        var $bank_routing = null; 
        var $bank_status = null; 
        var $bank_status_infos = null; 
        var $bank_creation = null; 
        var $bank_lastupdate = null; 
    }

    function validarfield($field, $characters, $longitud)
    {
        $field=str_replace($characters, "", $field);
        $field=substr($field, 0,$longitud);
        return $field;
    }


    try
    {

        //credentials
        $merchant_id='-----------';
        $api_password='-------------';
        $email_distrib = '-----------------';
        $pass_distrib = '--------------';

        $row=$_REQUEST;
        $row["itkAccountNumber"]=validarfield($row["itkAccountNumber"], array('-',' '), 30);
        $row["itkRoutingNumber"]=validarfield($row["itkRoutingNumber"], array('-',' '), 30);
        $row["cellPhone"]=validarfield($row["cellPhone"], array('(',')','-',' '), 10);
        $w_number="";
        $email= $row["email"];
        $firstname= $row["firstName"];
        $lastname= $row["lastName"];
        $phone= "1".$row["cellPhone"];

        $address=$row["address"];
        $city=$row["city"];
        $zipcode=$row["zip"];
        $country="US";
        $state=$row["abbreviation"];
        $bank_routing=$row["itkRoutingNumber"];
        $bank_account=$row["itkAccountNumber"];
        $initial_amount = 0;
        $amount = 0;
        $currency ="USD";
        $periodicity ="months";
        $cycles="1";                //0 es ilimitado
        $start_date= date("Y-m-d");
        $ref_id = rand(1000, 9999); 
        $description= "Order #".$ref_id." with Paytoo Merchant";
        $bank_name="BANK OF AMERICA N.A.";  //Falta obtener este campo

        $walletAfiliate = "08233227"; // Falta esto
        $walletRick = "08279897"; // Falta esto
        $walletMaster = "08625103"; // Falta esto
        
        ini_set('soap.wsdl_cache_enabled',0);
        $soap_merchant=new SoapClient("https://go.paytoo.com/api/merchant/?wsdl",array("classmap"=>array("PaytooAccountType"=>"PaytooAccountType","PaytooCreditCardType"=>"PaytooCreditCardType")));
        $soap_merchant1 =new SoapClient("https://go.paytoo.com/api/merchant/?wsdl",array("classmap"=>array("PaytooAccountType"=>"PaytooAccountType","PaytooCreditCardType"=>"PaytooCreditCardType")));
        $soap_distrib=new SoapClient("https://www.paytoo.com/api/distributor/?wsdl",   array("classmap"=>array("PaytooAccountType"=>"PaytooAccountType")));
        
        $response= $soap_distrib->auth($email_distrib,$pass_distrib);
        //echo "Auth Dist";
        //var_dump($response);
        $ban_downPayment = false;
        $ban_montlyPayment = false;
        if($response)
        {   

            $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{');
            mysql_select_db('crmlexco_rlg');
            $query = "SELECT * FROM payTooAccounts WHERE email = '".$email."'";
            $result = mysql_query($query);

            mysql_close($link);

            if(mysql_num_rows($result)==0){
                $PayTooAccount= new PaytooAccountTypeDistribute();
                $PayTooAccount->email= $email;
                $PayTooAccount->firstname= $firstname;
                $PayTooAccount->lastname= $lastname;
                $PayTooAccount->registered_phone= $phone;
                $PayTooAccount->security_code= "123456"; // Por Revisar 
                $PayTooAccount->password= "demo123"; // Por Revisar Dato
                $PayTooAccount->city=$city;
                $PayTooAccount->address=$address;
                $PayTooAccount->zipcode=$zipcode;
                $PayTooAccount->country=$country;
                $PayTooAccount->state=$state;  
                try
                {
                    $response = $soap_distrib->CreatePaytooAccount($PayTooAccount);
                    $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
                    mysql_select_db('crmlexco_rlg');
                    $query = 'INSERT into payTooAccounts (email, payTooAccountID, wallet, phoneRegistered) VALUES ("'.$response->email.'","'.$response->user_id.'","'.$response->wallet.'","'.$response->registered_phone.'")';
                    $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());
                    mysql_close($link);
                    $w_number=$response->wallet;
                }
                catch (SoapFault $fault)
                {
                    print("[CreateError] faultcode: {$fault->faultcode}, faultstring:   {$fault->faultstring}\n");
                }
            }else
            {
                $row1 = mysql_fetch_row($result);
                $w_number= $row1[2];
            }

            
            $response=$soap_merchant->auth($merchant_id,$api_password);
            //echo "Mercahn 0";
            //var_dump($response);
            if($response->status=='OK')
            {
                $Account = new PaytooAccountType();
                $Account->email=$email;
                $Account->firstname=$firstname;
                $Account->lastname=$lastname;
                $Account->address=$address;
                $Account->city=$city;
                $Account->zipcode=$zipcode;
                $Account->country=$country;
                $Account->state=$state;

                $PaytooBankAccount= new PaytooBankAccount();
                $PaytooBankAccount->type="Checking";
                $PaytooBankAccount->bank_routing=$bank_routing;
                $PaytooBankAccount->bank_account=$bank_account;
                $PaytooBankAccount->bank_name=$bank_name;
                $PaytooBankAccount->bank_state="Palau";
                //Down Payment
                
                /*if($row["itkDownPayment"]>0)
                {

                    $porcentaje = $row["ramsaranFee"]/100;
                    $prueba = $row["itkDownPayment"];
                    $restante = $prueba; // se divide la transferencia en dos
                    $EFtFee= $restante*$porcentaje;
                     $addinfo = null;
                    $documents = null;
                    //var_dump($PaytooBankAccount);
                    //var_dump($Account);
                    //echo " jjjj ". $row["itkDownPayment"]." ". $currency." ". $ref_id." ". $description." ". $addinfo." ". $documents;
                    $response = $soap_merchant->EcheckSingleTransaction ($PaytooBankAccount, $Account, $row["itkDownPayment"], $currency, $ref_id, $description, $addinfo, $documents);
                    
                    
                    if($response->status=="PENDING")
                    {

                        $ban_downPayment=true;
                        //Se hace los walletLoad
                        $addFee4=$restante*($row["affiliateCompanyPercent"]/100); 
                        $addFee5=$restante*($row["totalBrokersFeeToRick"]/100); 
                        $addFee6=$restante*($row["totalBrokersFeeToLawSupport"]/100);
                        //echo "que hay ".$addFee4." ".$addFee5." ".$addFee6."\n";
                       
                        //$response = $soap_distrib->walletLoad($walletAfiliate, $addFee4, "Transction for ".$row["affiliateCompanyName"]);
                        //var_dump($response);
                        //$response = $soap_distrib->walletLoad($walletRick, $addFee5, "Transction for Rick Graff Inc");
                        //$response = $soap_distrib->walletLoad($walletMaster, $addFee6, "Transction for Master Brokers");

                    }
                    else if ($response->status=="ERROR")
                    {
                        echo "Error in the First Transction: ".$response->msg. " \n";
                    }
                }
                */
                
                //Pagos Recurrentes
                if($row["itkProgramLenght"]>0)
                {

                    $porcentaje = $row["ramsaranFee"]/100;
                    $transferencia = $row["itkMontlyPayment"];
                    $total_transation =   $row["monthlyMaintenanceAffiliate"]+$row["monthlyMaintenanceRick"]+$row["monthlyMaintenanceLawSupport"]+$row["ramsaranMonthly"];
                     // se divide la transferencia en dos $row["itkProgramLenght"]
                    $restante = ($transferencia-$total_transation); 
                    $EFtFee= $row["ramsaranMonthly"]+($restante*$porcentaje);

                    $amount=  $row["itkMontlyPayment"];
                    if($row["itkDownPayment"]>0){
                        $initial_amount = $row["itkDownPayment"];
                    }else{
                        $initial_amount = $row["itkMontlyPayment"];
                    }
                    $start_date=$row["itkRecurrentPaymentDate"];
                    $cycles = $row["itkProgramLenght"];
                    
                    $addinfo = null;
                    $documents = null;

                    $merchant_id='--------';
                    $api_password='-------------';
                    $response=$soap_merchant1->auth($merchant_id,$api_password);
                    //echo "merchan1 ";
                    //var_dump($response);
                    $response = $soap_merchant1->EcheckRecurringTransaction($PaytooBankAccount, $Account, $initial_amount, $amount, $currency, $periodicity, $cycles, $start_date, $ref_id, $description, $addinfo, $documents);
                    
                    if($response->status=="PENDING")
                    {
                        //Se hace los walletLoad
                        $ban_montlyPayment=true;
                        $addFee1=$row["monthlyMaintenanceAffiliate"]; // verificar este Valor si es siempre
                        $addFee2=$row["monthlyMaintenanceRick"]; // verificar este Valor si es siempre
                        $addFee3=$row["monthlyMaintenanceLawSupport"]; // verificar este Valor si es siempre 
                        $addFee4=$restante*($row["affiliateCompanyPercent"]/100); // verificar este porcentaje de donde se saca
                        $addFee5=$restante*($row["totalBrokersFeeToRick"]/100); // verificar este porcentaje de donde se saca   
                        $addFee6=$restante*($row["totalBrokersFeeToLawSupport"]/100); // verificar este porcentaje de donde se saca
        
                        $addFee1 = $addFee1+$addFee4;
                        $addFee2 = $addFee2+$addFee5;
                        $addFee3 = $addFee3+$addFee6;
                
                        //$response = $soap_distrib->walletLoad($walletAfiliate, $addFee1, "Transction for ".$row["affiliateCompanyName"]);
                        //$response = $soap_distrib->walletLoad($walletRick, $addFee2, "Transction for Rick Graff Inc");
                        //$response = $soap_distrib->walletLoad($walletMaster, $addFee3, "Transction for Master Brokers");

                    }
                    else if ($response->status=="ERROR")
                    {
                        echo "Error in the second Transction: ".$response->msg. " \n" ;
                    }
                }   
            }
        }

        //if($ban_downPayment && $ban_montlyPayment)
        if(true && $ban_montlyPayment)
        {
            $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
            mysql_select_db('crmlexco_rlg') or die('No se pudo seleccionar la base de datos');
            $query = "UPDATE file SET paymentProcess = 2 WHERE idFile = ".$row['idFile'];  
            $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());
            mysql_close($link);
            echo "The transaction was successful";
        }else
        {
            echo "Error in the transaction";
        }
        
    }
    catch   (Exception  $e)
    {
        var_export($e);
    }
?>