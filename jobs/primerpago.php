<?php
require_once('lib/nusoap.php');

$cliente = new nusoap_client('https://www.securpaycardportal.com/proxy/proxy.incoming/eftservice.asmx?wsdl', true);
$cliente->response_timeout = 60; 
$link = mysql_connect('localhost', 'crmlexco_rlg', 'Oi6!Ua_XZEq{') or die('No se pudo conectar: ' . mysql_error());
mysql_select_db('crmlexco_rlg_dev') or die('No se pudo seleccionar la base de datos');

$query = "SELECT f.idFile idfile, f.firstName firstName, f.lastName lastName, f.dateBirth dateBirth, 
f.socialSecurity socialSecurity, s.abbreviation state, f.city city, f.address address, 
f.zip zip, f.email email, f.homePhone homePhone, f.itkMontlyPayment itkMontlyPayment, 
f.itkDownPayment itkDownPayment, f.itkAccountNumber itkAccountNumber, f.itkRoutingNumber itkRoutingNumber, 
a.affiliateCompanyPercent affiliateCompanyPercent
FROM  file f, state s, affiliatecompany a
WHERE  itkFirstInstallmentDate = current_date 
AND f.idState = s.idState
AND f.affiliateCompanyId = a.affiliateCompanyId
AND retainerStatus = 'Complete'";
$result = mysql_query($query) or die('Consulta fallida: ' . mysql_error());

while($row = mysql_fetch_array($result)) 
{
    $parametros = array(
        "UserName"=>"------------",
        "PassWord"=>"--------",
        "CardHolderID"=>$row["idFile"], 
        "FirstName"=>$row["firstName"], 
        "LastName"=>$row["lastName"], 
        "DateOfBirth"=>$row["dateBirth"], 
        "SSN"=>$row["socialSecurity"], 
        "Street"=>$row["address"], 
        "City"=>$row["city"], 
        "State"=>$row["state"], 
        "Zip"=>$row["zip"], 
        "PhoneNumber"=>$row["homePhone"], 
        "EmailAddress"=>$row["email"]
        );
    $respuesta = $cliente->call('AddCardholder', $parametros);
    if ($cliente->fault) 
    {
        echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
        echo "Mensaje: " . $cliente->faultstring;
    } else 
    {
        if($row["itkDownPayment"]>0)
        {

            $porcentaje = $row["affiliateCompanyPercent"]/100;
            echo $porcentaje;
            $transferencia = $row["itkDownPayment"];
                $restante = $transferencia-59.99-5; // se divide la transferencia en dos
                $EFtFee= 24.99+($restante*$porcentaje);
                $parametros = array(
                    "UserName"=>"----------",
                    "PassWord"=>"------------",
                    "CardHolderID"=>$row["idFile"], 
                    "EftDate"=>date("Y-m-d"), 
                    "EFtAmount"=>$row["itkDownPayment"], 
                    "EFtFee"=> $row["itkDownPayment"]*$porcentaje, 
                    "AccountNumber"=>$row["itkAccountNumber"], 
                    "RoutingNumber"=>$row["itkRoutingNumber"], 
                    "AccountType"=>"Savings"
                    );
                $respuesta = $cliente->call('AddEFT', $parametros);
                
                if ($cliente->fault) 
                {
                    echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                    echo "Mensaje: " . $cliente->faultstring;
                } else 
                {
                    $addFee1=15; // verificar este Valor si es siempre
                    $addFee2=10; // verificar este Valor si es siempre
                    $addFee3=10; // verificar este Valor si es siempre
                    $addFee4=$restante*0.4; // verificar este porcentaje de donde se saca
                    $addFee5=$restante*0.1; // verificar este porcentaje de donde se saca
                    $addFee6=$restante*0.1; // verificar este porcentaje de donde se saca
                    $parametros = array(
                        "UserName"=>"----------",
                        "PassWord"=>"------------",
                        "CardHolderID"=>$row["idFile"], 
                        "FeeDate"=>date("Y-m-d"), 
                        "FeeAmount"=>$addFee1, 
                        "FeeType"=> "VendorFee", 
                        "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                        );
                    $respuesta = $cliente->call('AddFee', $parametros);
                    if ($cliente->fault) 
                    {
                        echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                        echo "Mensaje: " . $cliente->faultstring;
                    } else 
                    {

                        $parametros = array(
                            "UserName"=>"----------",
                            "PassWord"=>"------------",
                            "CardHolderID"=>$row["idFile"], 
                            "FeeDate"=>date("Y-m-d"), 
                            "FeeAmount"=>$addFee2, 
                            "FeeType"=> "VendorFee", 
                            "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                            );
                        $respuesta = $cliente->call('AddFee', $parametros);
                        if ($cliente->fault) 
                        {
                            echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                            echo "Mensaje: " . $cliente->faultstring;
                        } else 
                        {

                            $parametros = array(
                                "UserName"=>"----------",
                                "PassWord"=>"------------",
                                "CardHolderID"=>$row["idFile"], 
                                "FeeDate"=>date("Y-m-d"), 
                                "FeeAmount"=>$addFee3, 
                                "FeeType"=> "VendorFee", 
                                "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                                );
                            $respuesta = $cliente->call('AddFee', $parametros);
                            if ($cliente->fault) 
                            {
                                echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                                echo "Mensaje: " . $cliente->faultstring;
                            } else 
                            {
                                $parametros = array(
                                    "UserName"=>"----------",
                                    "PassWord"=>"------------",
                                    "CardHolderID"=>$row["idFile"], 
                                    "FeeDate"=>date("Y-m-d"), 
                                    "FeeAmount"=>$addFee4, 
                                    "FeeType"=> "VendorFee", 
                                    "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                                    );
                                $respuesta = $cliente->call('AddFee', $parametros);
                                if ($cliente->fault) 
                                {
                                    echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                                    echo "Mensaje: " . $cliente->faultstring;
                                } else 
                                {
                                    $parametros = array(
                                        "UserName"=>"----------",
                                        "PassWord"=>"------------",
                                        "CardHolderID"=>$row["idFile"], 
                                        "FeeDate"=>date("Y-m-d"), 
                                        "FeeAmount"=>$addFee5, 
                                        "FeeType"=> "VendorFee", 
                                        "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                                        );
                                    $respuesta = $cliente->call('AddFee', $parametros);
                                    if ($cliente->fault) 
                                    {
                                        echo "FALLO: <p>Codigo: (" . $cliente->faultcode . ")</p>";
                                        echo "Mensaje: " . $cliente->faultstring;
                                    } else 
                                    {
                                        $parametros = array(
                                            "UserName"=>"----------",
                                            "PassWord"=>"------------",
                                            "CardHolderID"=>$row["idFile"], 
                                            "FeeDate"=>date("Y-m-d"), 
                                            "FeeAmount"=>$addFee6, 
                                            "FeeType"=> "VendorFee", 
                                            "PaidToName"=>"Affiliate $ amount of Monthly Maintenance Fe"
                                            );
                                        $respuesta = $cliente->call('AddFee', $parametros);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    mysql_close($link);
?>