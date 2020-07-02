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

$row=$_REQUEST;

$porcentaje=0;

$transferencia=0;

$restante=0;

$EFtFee=0;

$date = $row["dateBirth"];

$primerpaso = false;

$band= true;

 
if (generate_AddCardholder($row, $client, $date))
{

    if($row["itkDownPayment"]>6)
    {
        $porcentaje = $row["ramsaranFee"]/100;
        $prueba = $row["itkDownPayment"];
        $restante = $prueba-6;
        $EFtFee= $restante*$porcentaje;
        $date1=$row["itkFirstInstallmentDate"];
        $bandera=generate_AddEFT($row,$EFtFee,$prueba,$date1,$client);

        if($bandera)
        {
            $addFee4=$restante*($row["affiliateCompanyPercent"]/100); 
            $addFee5=$restante*($row["totalBrokersFeeToRick"]/100); 
            $addFee6=$restante*($row["totalBrokersFeeToLawSupport"]/100);
            $flag_AddFee=true;
            $nuevafecha = suma_fechas(date("Y-m-d"),'1');
            $bandera=generate_AddFee($row, $addFee4, $date1, $client, $row["affiliateCompanyName"]);

            if($bandera){

                $bandera=generate_AddFee($row, $addFee5, $date1, $client, "Rick Graff Inc");

                if($bandera){

                    $bandera=generate_AddFee($row, $addFee6, $date1, $client, "Master Brokers"); 

                }

            }

            if ($flag_AddFee)

            {

                

                $primerpaso=true;

            }else{

                echo "There was an error with AddFee";

            }
        }
        else
        {

            echo "Transfer not generated";
        }
    }
    else
    {

        echo "Downpayment not generated";

    }


    if($row["itkProgramLenght"]>0)
    {

        $porcentaje = $row["ramsaranFee"]/100;

        $transferencia = $row["itkMontlyPayment"];
        
        $total_transation =   $row["monthlyMaintenanceAffiliate"]+$row["monthlyMaintenanceRick"]+$row["monthlyMaintenanceLawSupport"]+$row["ramsaranMonthly"];

        if($transferencia>$total_transation+6)
        {
            
            $restante = ($transferencia-$total_transation)-6; 

            $EFtFee= $row["ramsaranMonthly"]+($restante*$porcentaje);

            $flag_Program=true;

            for ($i = 0; $i <= $row["itkProgramLenght"]-2; $i++) 
            {   

                $dat=$row["itkRecurrentPaymentDate"];

                $dat= date("Y-m-d", strtotime("$dat +".$i." month"));

                $arr = explode("-", $dat);

                $mes = $arr[1];

                $dia = $arr[2];

                $anio = $arr[0];

                $fecha = $anio."-".$mes."-".$dia;

                

                if(generate_AddEFT($row, $EFtFee, $transferencia,  $fecha, $client))
                {
                    $addFee1=$row["monthlyMaintenanceAffiliate"];

                    $addFee2=$row["monthlyMaintenanceRick"];

                    $addFee3=$row["monthlyMaintenanceLawSupport"];

                    $addFee4=$restante*($row["affiliateCompanyPercent"]/100);

                    $addFee5=$restante*($row["totalBrokersFeeToRick"]/100);

                    $addFee6=$restante*($row["totalBrokersFeeToLawSupport"]/100);

                    $addFee1 = $addFee1+$addFee4;

                    $addFee2 = $addFee2+$addFee5;

                    $addFee3 = $addFee3+$addFee6;

                    generate_AddFee($row, $addFee1, $dat, $client, $row["affiliateCompanyName"]);

                    generate_AddFee($row, $addFee2, $dat, $client, "Rick Graff Inc");

                    generate_AddFee($row, $addFee3, $dat, $client, "Master Brokers");
                }
                else
                {
                    echo "Error with EFT"; 
                }

            }

            if ($flag_Program)

            {

                if ($primerpaso)

                {

                    echo "Down payment and monthly payments scheduled";       

                }else{

                    echo "Payments scheduled"; 

                }
            }
        }
        else
        {
            echo "Unbalanced transfer";
        }  

    }else{

        echo "Monthly payment not scheduled";

    }

    $link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());

    mysql_select_db('crmlexco_rlg') or die('No se pudo seleccionar la base de datos');

    $query = "UPDATE file SET paymentProcess = 1 WHERE idFile = ".$_REQUEST['idFile'];

    $result = mysql_query($query) or die('Ingreso fallido: ' . mysql_error());

    mysql_close($link);
}
else
{
    echo "Cardholder not added";
}



function validarfield($field, $characters, $longitud)
{

    $field=str_replace($characters, "", $field);

    $field=substr($field, 0,$longitud);

    return $field;
}

   

function generate_AddCardholder($row,$client, $date)
{

    $row["idFile"]=validarfield($row["idFile"], array(' '), 10);

    $row["firstName"]=validarfield($row["firstName"], array('$'), 60);

    $row["lastName"]=validarfield($row["lastName"], array('$'), 60);

    $row["socialSecurity"]=validarfield($row["socialSecurity"], array('-',' '), 9);

    $row["address"]=validarfield($row["address"], array('&'), 50);

    $row["city"]=validarfield($row["city"], array('$'), 50);

    $row["abbreviation"]=validarfield($row["abbreviation"], array('(',')','-',' '), 2);

    $row["zip"]=validarfield($row["zip"], array('(',')','-',' ', '#'), 9);

    $row["homePhone"]=validarfield($row["homePhone"], array('(',')','-',' '), 10);

    $row["EmailAddress"]=validarfield($row["EmailAddress"], array(''), 40);

    $parametros = array(

        "UserName"=>"---------------",

        "PassWord"=>"----------------------------------",

        "CardHolderID"=>$row["idFile"], 

        "FirstName"=>$row["firstName"], 

        "LastName"=>$row["lastName"], 

        "DateOfBirth"=>$date, 

        "SSN"=>$row["socialSecurity"], 

        "Street"=>$row["address"], 

        "City"=>$row["city"], 

        "State"=>$row["abbreviation"], 

        "Zip"=>$row["zip"], 

        "PhoneNumber"=>$row["homePhone"], 

        "EmailAddress"=>$row["email"]   

    );

    

    $ready = $client->__soapCall('AddCardHolder', array($parametros))->AddCardHolderResult;

    if (is_soap_fault($ready)) {

            trigger_error("SOAP Fault: (faultcode: {$ready->faultcode}, faultstring: {$ready->faultstring})", E_USER_ERROR);

            return false;

    }

    else

    {

        

        if ($ready->StatusCode!="Error")

        {

            return true;

        }

        else

        {

            echo $ready->Message."\n";

            return false;

        }

     }
}

function  generate_AddEFT($row, $EFtFee, $EftAmount, $date,  $client)
{

    $EftAmount = number_format($EftAmount,2, '.', '');

    $EFtFee = number_format($EFtFee,2, '.', '');

    $row["idFile"]=validarfield($row["idFile"], array(' '), 10);

    $row["AccountNumber"]=validarfield($row["AccountNumber"], array('-',' '), 30);

    $row["itkRoutingNumber"]=validarfield($row["itkRoutingNumber"], array('-',' '), 30);

    

    $parametros = array(

        "UserName"=>"---------------",

        "PassWord"=>"----------------------------------",

        "CardHolderID"=>$row["idFile"],

        "EftDate"=>$date, 

        "EftAmount"=>$EftAmount, 

        "EftFee"=> $EFtFee, 

        "BankName"=> "",

        "BankCity"=>"",

        "BankState"=>"",

        "AccountNumber"=>$row["itkAccountNumber"],

        "RoutingNumber"=>$row["itkRoutingNumber"], 

        "AccountType"=>"Checking",

        "Memo"=>""

    );    

    $ready = $client->__soapCall('AddEft', array($parametros));   

    if (is_soap_fault($ready)) {

            trigger_error("SOAP Fault: (faultcode: {$ready->faultcode}, faultstring: {$ready->faultstring})", E_USER_ERROR);

            return false;

    }

    else

    {   

        $value = new stdClass();

        $value = $ready->AddEftResult;

        if ($value->StatusCode!="Error")

        {

            return true;

        }

        else

        {

            echo $ready->Message."\n";

            return false;

        }

        

    }
}


function  generate_AddFee($row, $addFee, $date, $client, $from_client)
{   

    $addFee = number_format($addFee,2, '.', '');

    $from_client=validarfield($from_client, array(''), 100);



    $parametros = array(

        "UserName"=>"---------------",

        "PassWord"=>"----------------------------------",

        "CardHolderID"=>$row["idFile"], 

        "FeeDate"=>$date, 

        "FeeAmount"=>$addFee, 

        "Description"=>"",

        "FeeType"=> "SettlementPayment",

        "PaidToName"=>$from_client,

        "PaidToPhone"=>"",

        "PaidToStreet"=>"",

        "PaidToStreet2"=>"",

        "PaidToCity"=>"",

        "PaidToState"=>"",

        "PaidToZip"=>"",

        "ContactName"=>"",

        "PaidToCustomerNumber"=>""





    );

    

    $ready = $client->__soapCall('AddFee', array($parametros));

    if (is_soap_fault($ready)) {

            trigger_error("SOAP Fault: (faultcode: {$ready->faultcode}, faultstring: {$ready->faultstring})", E_USER_ERROR);

            return false;

    }

    else

    {

        $value = new stdClass();

        $value = $ready->AddFeeResult;

        if ($value->StatusCode!="Error")

        {

            return true;

        }

        else

        {

            if($band){

                

                echo "There was a problem creating the fees for ".$row["firstName"]." ".$row["lastName"]." Please contact the administrator.\n";

                $band=false;

                return false;

            }

            

        }

        return true;

    }
}

function suma_fechas($fecha,$ndias)      
{   

      if (preg_match("/[0-9]{1,2}-[0-9]{1,2}-([0-9][0-9]){1,2}/",$fecha))

               list($año,$mes,$dia)=split("-", $fecha);

          

      if (preg_match("/[0-9]{1,2}-[0-9]{1,2}-([0-9][0-9]){1,2}/",$fecha))

             list($año,$mes,$dia)=split("-",$fecha);

        $nueva = mktime(0,0,0, $mes,$dia,$año) + $ndias * 24 * 60 * 60;

        $nuevafecha=date("Y-m-d",$nueva);

          

      return ($nuevafecha); 
}
 
?>