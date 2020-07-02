<?php
/**
 * @copyright Copyright (C) DocuSign, Inc.  All rights reserved.
 *
 * This source code is intended only as a supplement to DocuSign SDK
 * and/or on-line documentation.
 * This sample is designed to demonstrate DocuSign features and is not intended
 * for production use. Code and policy for a production application must be
 * developed to meet the specific data and security requirements of the
 * application.
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 */

// start session and some helper functions
include("include/session.php");
// credential service proxy classes and soapclient
include("api/CredentialService.php");
// api service proxy classes and soapclient
include("api/APIService.php");
// redirect to setup page if we aren't logged in
loginCheck("../login.php");

// get Integrator Key from credentials.ini
$ini_array = parse_ini_file("integrator.php");
$IntegratorsKey = $ini_array["IntegratorsKey"];
if (!isset($IntegratorsKey) || $IntegratorsKey == "") {
    $_SESSION["errorMessage"] = "Please make sure integrator key is set (in integrator.php).";
    header("Location: error.php");
    die();
}

// setup api connection
$api_endpoint="https://www.docusign.net/api/3.0/api.asmx";
$api_wsdl = "api/APIService.wsdl";
$api_options =  array('location'=>$api_endpoint,'trace'=>true,'features' => SOAP_SINGLE_ELEMENT_ARRAYS);
$api = new APIService($api_wsdl, $api_options);
// set credentials on the api object - if we have an integrator key then we prepend that to the UserID
$api->setCredentials("[" . $IntegratorsKey . "]" . $_SESSION["UserID"], $_SESSION["Password"]);

$envFoud = false;
if (isset($_SESSION["EnvelopeID"]) && $_SESSION["EnvelopeID"] != '') {
    $envFound = true;
    $RequestStatusParams = new RequestStatus();
    $RequestStatusParams->EnvelopeID = $_SESSION["EnvelopeID"];

    try{
    	$RequestStatusResponse = $api->RequestStatus($RequestStatusParams);
    	addToLog("API Call - RequestStatus Request", '<pre>' . xmlpp($api->_lastRequest,true) . '</pre>');
    	addToLog("API Call - RequestStatus Response", '<pre>' . xmlpp($api->__getlastResponse(),true) . '</pre>');

    } catch (SoapFault $fault){
    	$_SESSION["errorMessage"] = $fault;
    	$_SESSION["lastRequest"] = $api->_lastRequest;
    	header("Location: error.php");
    	die();
    }
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Debt Retainer</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></meta>
        <script type="text/javascript" src="scripts/jquery-1.4.1.min.js"></script>
        <script type="text/javascript" src="scripts/webservice-status.js"></script>
        <link rel="stylesheet" type="text/css" href="css/style.css"></link>
    </head><body style=" font-family:Lucida Grande, Helvetica, Helvetica Neue, Arial;">
        <div class="header" style="background-repeat:repeat-x; background-position:top">
            <div class="floatLeft" style="background-color: #3FA9F5;" >
                <img src="../../template/images/cdlg-logo.png" alt="CRMLEX - Consumer Debt Legal Group" />
            </div>
            <div class="userBox">
                <table cellspacing="0" border="0">
                    <tr style="border-bottom: 2px; solid #000000">
                        <td>Username:</td>
                        <td><?php echo($_SESSION["UserName"]) ?></td>
                        <td>Account:</td>
                        <td><?php echo($_SESSION["AccountName"]) ?></td>
                    </tr>
                    <tr>

                        <td colspan="4" align="right">
                            <img id="ws3_0_img" src="images/spinner.gif" /><span style="font-size: 0.75em;">(WS3_0 webservice)</span>
                            <img id="credential_img" src="images/spinner.gif" /><span style="font-size: 0.75em;">(Credential webservice)</span>
                            <a href="sessionlog.php" target="_blank"><img src="images/script.png" style="border: 0px;" /><span style="font-size: 0.75em;">View Event Log</span></a>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <!--     
        <div class="gutter"></div>

        <div class="sidebar">
            <h1>What we offer?</h1>

            <div id="navcontainer">
                <ul id="navlist">
                    <li><a href="index.php">Products</a></li>
                    <li><a href="home.php">My Account Home</a></li>
                    <li><a href="autoAppStatus.php">&nbsp;&nbsp;- Application Status</a></li>
                    <li><a href="logout.php">&nbsp;&nbsp;- Log Out</a></li>
                </ul>
            </div>
        </div> -->

        <div>
            <span class="col1">
                <h1>CRMLEX - Debt Retainer Status</h1>
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th align="left">Envelope Id</th>
                            <th align="left">Application Type</th>
                            <th align="left">Application Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        	<?php
                        	    if ($envFound == true) {
                        	        echo("<td align='left'>" . $RequestStatusResponse->RequestStatusResult->EnvelopeID . "</td>");
                        	        echo("<td align='left'>Debt Retainer</td>");
                        	        echo("<td align='left'>" . $RequestStatusResponse->RequestStatusResult->Status . "</td>");
                        	    }
                        	    else {
                        	        echo("<td align='left' colspan=3>No Retainer Sent</td>");
                        	    }
                        	?>
                       </tr>

                   </tbody>
                </table>
            </span>
        </div>
    </body></html>