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
//  credential api service proxy classes and soapclient
include("api/CredentialService.php");
// transaction api service proxy classes and soapclient
include("api/APIService.php");
// redirect to setup page if we aren't logged in
loginCheck("../login.php");

function extractInitials($firstname, $lastname) {
    $retval = "";
    if ($firstname <> null && strlen($firstname) > 0) {
        $retval = $retval . substr($firstname, 0, 1);
    }
    if ($lastname <> null && strlen($lastname) > 0) {
        $retval = $retval . substr($lastname, 0, 1);
    }
    return $retval;
}

function curPageURL() {
    $pageURL = 'http';
    if (isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"] == "on") {
        $pageURL .= "s";
    }
    $pageURL .= "://";
    if ($_SERVER["SERVER_PORT"] != "80") {
        $pageURL .= $_SERVER["SERVER_NAME"] . ":" . $_SERVER["SERVER_PORT"] . $_SERVER["REQUEST_URI"];
    } else {
        $pageURL .= $_SERVER["SERVER_NAME"] . $_SERVER["REQUEST_URI"];
    }
    return $pageURL;
}

function getCallbackURL($callbackPage) {
    $urlbase = curPageURL();
    $urlbase = substr($urlbase, 0, strrpos($urlbase, '/'));
    $urlbase = $urlbase . "/" . $callbackPage;
    return $urlbase;
}

function makeRecipient() {

    // this is the signer
    $Recipient = new Recipient();
    $Recipient->Email = $_SESSION["email"];
    $Recipient->UserName = $_SESSION["name1"];
    $Recipient->ID = "1";
    $Recipient->RoleName = "Client 1";
    $Recipient->Type = "Signer";
    $Recipient->RoutingOrder = "1";
    $Recipient->RoutingOrderSpecified = true;
    $Recipient->AutoNavigation = "true";
    $Recipient->RequireIDLookup = false;
    if (isset($_POST["embeddedSigning"]) && $_POST["embeddedSigning"] == true) {
        $Recipient->CaptiveInfo->ClientUserId = "1";
        $Recipient->SignatureInfo->SignatureName = $_SESSION["name1"];
        //TODO: Sacar nombres aparte de apellidos
        $Recipient->SignatureInfo->SignatureInitials = extractInitials($_SESSION["name1"], $_SESSION["name1"]);
        //$Recipient->SignatureInfo->SignatureInitials = extractInitials($_POST["firstName"], $_POST["lastName"]);
        $Recipient->SignatureInfo->FontStyle = "Mistral";
    }

    return $Recipient;
}


function makeRecipient2() {

    // this is the signer
    $Recipient = new Recipient();
    $Recipient->Email = $_SESSION["scEmail"];
    $Recipient->UserName = $_SESSION["name2"];
    $Recipient->ID = "2";
    $Recipient->RoleName = "Client 2";
    $Recipient->Type = "Signer";
    $Recipient->RoutingOrder = "1";
    $Recipient->RoutingOrderSpecified = true;
    $Recipient->AutoNavigation = "true";
    $Recipient->RequireIDLookup = false;
    if (isset($_POST["embeddedSigning"]) && $_POST["embeddedSigning"] == true) {
        $Recipient->CaptiveInfo->ClientUserId = "2";
        $Recipient->SignatureInfo->SignatureName = $_SESSION["name2"];
        //TODO: Sacar nombres aparte de apellidos
        $Recipient->SignatureInfo->SignatureInitials = extractInitials($_SESSION["name2"], $_SESSION["name2"]);
        //$Recipient->SignatureInfo->SignatureInitials = extractInitials($_POST["firstName"], $_POST["lastName"]);
        $Recipient->SignatureInfo->FontStyle = "Mistral";
    }
    return $Recipient;
}


function makeTemplateReference() {
    // build our template request.
    $TemplateRef = new TemplateReference();
    $TemplateRef->Template = $_SESSION["TemplateID"];
    $TemplateRef->TemplateLocation = "Server";
    $TemplateRef->Sequence = "1";
    return $TemplateRef;
}

function makeTemplateFormFields() {
    // merge POST data into fields
   
    $fields = array();
    $field1 = new TemplateReferenceFieldDataDataValue();
    $field1->TabLabel = "name1";
    $field1->Value = $_SESSION["name1"];
    $fields[0] = $field1;

    $field2 = new TemplateReferenceFieldDataDataValue();
    $field2->TabLabel = "name2";
    $field2->Value = $_SESSION["name2"];
    $fields[1] = $field2;

    $field3 = new TemplateReferenceFieldDataDataValue();
    $field3->TabLabel = "address";
    $field3->Value = $_SESSION["address"];
    $fields[2] = $field3;
    
    $field4 = new TemplateReferenceFieldDataDataValue();
    $field4->TabLabel = "city";
    $field4->Value = $_SESSION["city"];
    $fields[3] = $field4;
    
    $field5 = new TemplateReferenceFieldDataDataValue();
    $field5->TabLabel = "state";
    $field5->Value = $_SESSION["state"];
    $fields[4] = $field5;
    
    $field6 = new TemplateReferenceFieldDataDataValue();
    $field6->TabLabel = "zip";
    $field6->Value = $_SESSION["zip"];
    $fields[5] = $field6;
    
    $field7 = new TemplateReferenceFieldDataDataValue();
    $field7->TabLabel = "homePhone";
    $field7->Value = $_SESSION["homePhone"];
    $fields[6] = $field7;
    
    $field8 = new TemplateReferenceFieldDataDataValue();
    $field8->TabLabel = "businessPhone";
    $field8->Value = $_SESSION["businessPhone"];
    $fields[7] = $field8;
    
    $field9 = new TemplateReferenceFieldDataDataValue();
    $field9->TabLabel = "cellPhone";
    $field9->Value = $_SESSION["cellPhone"];
    $fields[8] = $field9;
    
    
    $field10 = new TemplateReferenceFieldDataDataValue();
    $field10->TabLabel = "email";
    $field10->Value = $_SESSION["email"];
    $fields[9] = $field10;
    
	$field = new TemplateReferenceFieldDataDataValue();
	if($_SESSION['propertyInForeclosure'] == "0"){
		$field->TabLabel = "propertyInForeclosureNO";
		$field->Value = "X";
	}else{
		$field->TabLabel = "propertyInForeclosureYES";
		$field->Value = "X";
		}
	$fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "saleDate";
    $field->Value = $_SESSION['saleDate'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "propertyAddress";
    $field->Value = $_SESSION['propertyAddress'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "propertyCity";
    $field->Value = $_SESSION['propertyCity'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "propertyZip";
    $field->Value = $_SESSION['propertyZip'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "propertyState";
    $field->Value = $_SESSION['propertyState'];
    $fields[] = $field;

	$field = new TemplateReferenceFieldDataDataValue();
	if($_SESSION['loanModificationWithLender'] == "0"){
		$field->TabLabel = "loanModificationWithLenderNO";
		$field->Value = "X";
	}else{
		$field->TabLabel = "loanModificationWithLenderYES";
		$field->Value = "X";
		}
	$fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "dateForLoanMod";
    $field->Value = $_SESSION['dateForLoanMod'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
	if($_SESSION['governmentHAMP'] == "0"){
		$field->TabLabel = "governmentHAMPNO";
		$field->Value = "X";
	}else{
		$field->TabLabel = "governmentHAMPYES";
		$field->Value = "X";
		}
	$fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
	if($_SESSION['repaymentHAMP'] == "0"){
		$field->TabLabel = "repaymentHAMPNO";
		$field->Value = "X";
	}else{
		$field->TabLabel = "repaymentHAMPYES";
		$field->Value = "X";
		}
	$fields[] = $field;

	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstMortgageCompany";
    $field->Value = $_SESSION['firstMortgageCompany'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstLoanNumber";
    $field->Value = $_SESSION['firstLoanNumber'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstBalance";
    $field->Value = $_SESSION['firstBalance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstMontlyPayment";
    $field->Value = $_SESSION['firstMontlyPayment'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstInterestRate";
    $field->Value = $_SESSION['firstInterestRate'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstTaxes";
    $field->Value = $_SESSION['firstTaxes'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "firstPaymentsBehind";
    $field->Value = $_SESSION['firstPaymentsBehind'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondMortgageCompany";
    $field->Value = $_SESSION['secondMortgageCompany'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondLoanNumber";
    $field->Value = $_SESSION['secondLoanNumber'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondBalance";
    $field->Value = $_SESSION['secondBalance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondMontlyPayment";
    $field->Value = $_SESSION['secondMontlyPayment'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondInterestRate";
    $field->Value = $_SESSION['secondInterestRate'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondTaxes";
    $field->Value = $_SESSION['secondTaxes'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "secondPaymentsBehind";
    $field->Value = $_SESSION['secondPaymentsBehind'];
    $fields[] = $field;
	
	//ai

	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiFirstMortgage";
    $field->Value = $_SESSION['aiFirstMortgage'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiSecondMortgage";
    $field->Value = $_SESSION['aiSecondMortgage'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiPropertyTax";
    $field->Value = $_SESSION['aiPropertyTax'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiHomeInsurance";
    $field->Value = $_SESSION['aiHomeInsurance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCarPayment1";
    $field->Value = $_SESSION['aiCarPayment1'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCarPayment2";
    $field->Value = $_SESSION['aiCarPayment2'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCarInsurance";
    $field->Value = $_SESSION['aiCarInsurance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiMonthlyGasUse";
    $field->Value = $_SESSION['aiMonthlyGasUse'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiMonthlyCarRepairs";
    $field->Value = $_SESSION['aiMonthlyCarRepairs'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiElectricBill";
    $field->Value = $_SESSION['aiElectricBill'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCable";
    $field->Value = $_SESSION['aiCable'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiTelephoneBill";
    $field->Value = $_SESSION['aiTelephoneBill'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCellPhoneBill";
    $field->Value = $_SESSION['aiCellPhoneBill'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiGroceries";
    $field->Value = $_SESSION['aiGroceries'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiMisc";
    $field->Value = $_SESSION['aiMisc'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiDoctorBills";
    $field->Value = $_SESSION['aiDoctorBills'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiPrescriptions";
    $field->Value = $_SESSION['aiPrescriptions'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiHealthInsurance";
    $field->Value = $_SESSION['aiHealthInsurance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiLifeInsurance";
    $field->Value = $_SESSION['aiLifeInsurance'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCreditCards";
    $field->Value = $_SESSION['aiCreditCards'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiOther";
    $field->Value = $_SESSION['aiOther'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiInvestmentProperties";
    $field->Value = $_SESSION['aiInvestmentProperties'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiTotalOut";
    $field->Value = $_SESSION['aiTotalOut'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiBorrowerFirstJob";
    $field->Value = $_SESSION['aiBorrowerFirstJob'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiBorrowerSecondJob";
    $field->Value = $_SESSION['aiBorrowerSecondJob'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCoBorrowerFirstJob";
    $field->Value = $_SESSION['aiCoBorrowerFirstJob'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiCoBorrowerSecondJob";
    $field->Value = $_SESSION['aiCoBorrowerSecondJob'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiRentalIncome";
    $field->Value = $_SESSION['aiRentalIncome'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiAlimony";
    $field->Value = $_SESSION['aiAlimony'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiChildSupport";
    $field->Value = $_SESSION['aiChildSupport'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiDisabilityIncome";
    $field->Value = $_SESSION['aiDisabilityIncome'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiSSRI";
    $field->Value = $_SESSION['aiSSRI'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiUnemploymentCompensation";
    $field->Value = $_SESSION['aiUnemploymentCompensation'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiMiscIncome";
    $field->Value = $_SESSION['aiMiscIncome'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiMonthlySupport";
    $field->Value = $_SESSION['aiMonthlySupport'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "aiTotalIn";
    $field->Value = $_SESSION['aiTotalIn'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "now";
    $field->Value = $_SESSION["now"];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "nowDay";
    $field->Value = $_SESSION["nowDay"];
    $fields[] = $field;
    
    $field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "nowMonth";
    $field->Value = $_SESSION["nowMonth"];
    $fields[] = $field;
	
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "socialSecurity";
    $field->Value = $_SESSION['socialSecurity'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "dateBirth";
    $field->Value = $_SESSION['dateBirth'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "maritalStatus";
    $field->Value = $_SESSION['maritalStatus'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkTotalRetainerFeeMortgageLM";
    $field->Value = $_SESSION['itkTotalRetainerFeeMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scHomePhone";
    $field->Value = $_SESSION['scHomePhone'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scBusinessPhone";
    $field->Value = $_SESSION['scBusinessPhone'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scCellPhone";
    $field->Value = $_SESSION['scCellPhone'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scDateBirth";
    $field->Value = $_SESSION['scDateBirth'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scSocialSecurity";
    $field->Value = $_SESSION['scSocialSecurity'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scAddress";
    $field->Value = $_SESSION['scAddress'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scCity";
    $field->Value = $_SESSION['scCity'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scState";
    $field->Value = $_SESSION['scState'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scZip";
    $field->Value = $_SESSION['scZip'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scState";
    $field->Value = $_SESSION['scState'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scMaritalStatus";
    $field->Value = $_SESSION['scMaritalStatus'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "scEmail";
    $field->Value = $_SESSION['scEmail'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkTotalRetainerFeeMortgageLM";
    $field->Value = $_SESSION['itkTotalRetainerFeeMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkTotalRetainerFeeMortgageDateLM";
    $field->Value = $_SESSION['itkTotalRetainerFeeMortgageDateLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkSecondTotalRetainerFeeMortgageLM";
    $field->Value = $_SESSION['itkSecondTotalRetainerFeeMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkSecondTotalRetainerFeeMortgageDateLM";
    $field->Value = $_SESSION['itkSecondTotalRetainerFeeMortgageDateLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkFirstInstallmentDateMortgageLM";
    $field->Value = $_SESSION['itkFirstInstallmentDateMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkBankNameMortgageLM";
    $field->Value = $_SESSION['itkBankNameMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkRoutingNumberMortgageLM";
    $field->Value = $_SESSION['itkRoutingNumberMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "itkAccountNumberMortgageLM";
    $field->Value = $_SESSION['itkAccountNumberMortgageLM'];
    $fields[] = $field;
	
	$field = new TemplateReferenceFieldDataDataValue();
    $field->TabLabel = "clients";
	if(isset($_SESSION['name2']) && $_SESSION['name2'] != "")
	{
		$field->Value = $_SESSION['name1'] . " and ". $_SESSION['name2'];	
	}else{
		$field->Value = $_SESSION['name1'];
	}
    $fields[] = $field;

    return $fields;
}

function makeEnvelopeInfo() {
    $EnvelopeInfo = new EnvelopeInformation();
    $EnvelopeInfo->EmailBlurb = "This envelope was sent from the CRMLEX.";
    $EnvelopeInfo->Subject = "Loan Modification Retainer";
    $EnvelopeInfo->AccountId = $_SESSION["AccountID"];

    return $EnvelopeInfo;
}

function makeRequestRecipientToken($Recipient) {

    $RequestRecipientTokenparam = new RequestRecipientToken();
    $RequestRecipientTokenparam->EnvelopeID = $_SESSION["EnvelopeID"];
    $RequestRecipientTokenparam->ClientUserID = "1";
    $RequestRecipientTokenparam->Username = $Recipient->UserName;
    $RequestRecipientTokenparam->Email = $Recipient->Email;
    $RequestRecipientTokenparam->AuthenticationAssertion->AssertionID = time();
    $m = date("m");
    $d = date("Y") . "-" . $m . "-" . date("d") . "T00:00:00.00";
    $RequestRecipientTokenparam->AuthenticationAssertion->AuthenticationInstant = $d;
    $RequestRecipientTokenparam->AuthenticationAssertion->AuthenticationMethod = "Password";
    $RequestRecipientTokenparam->AuthenticationAssertion->SecurityDomain = $_SERVER['HTTP_HOST'];
    $RequestRecipientTokenparam->ClientURLs->OnViewingComplete = getCallbackURL("pop.html") . "?id=2";
    ;
    $RequestRecipientTokenparam->ClientURLs->OnCancel = getCallbackURL("pop.html") . "?id=3";
    $RequestRecipientTokenparam->ClientURLs->OnDecline = getCallbackURL("pop.html") . "?id=4";
    $RequestRecipientTokenparam->ClientURLs->OnSessionTimeout = getCallbackURL("pop.html") . "?id=5";
    $RequestRecipientTokenparam->ClientURLs->OnTTLExpired = getCallbackURL("pop.html") . "?id=6";
    $RequestRecipientTokenparam->ClientURLs->OnException = getCallbackURL("pop.html") . "?id=7";
    $RequestRecipientTokenparam->ClientURLs->OnAccessCodeFailed = getCallbackURL("pop.html") . "?id=8";
    $RequestRecipientTokenparam->ClientURLs->OnSigningComplete = getCallbackURL("pop.html") . "?id=9";
    $RequestRecipientTokenparam->ClientURLs->OnIdCheckFailed = getCallbackURL("pop.html") . "?id=1";

    return $RequestRecipientTokenparam;
}

function makeCCRecipient($email) {

    $Recipient = new Recipient();
    $Recipient->Email = $email;
    $Recipient->UserName = "Any Signer";
    $Recipient->ID = "2";
    $Recipient->RoleName = "CC";
    $Recipient->Type = "CarbonCopy";
    $Recipient->RequireIDLookup = false;
    return $Recipient;
}

// get Integrator Key from credentials.ini
$ini_array = parse_ini_file("integrator.php");
$IntegratorsKey = $ini_array["IntegratorsKey"];
if (!isset($IntegratorsKey) || $IntegratorsKey == "") {
    $_SESSION["errorMessage"] = "Please make sure integrator key is set (in integrator.php).";
    header("Location: error.php");
    die();
}

// setup api connection
$api_endpoint = "https://www.docusign.net/api/3.0/api.asmx";
//$api_endpoint = "https://demo.docusign.net/api/3.0/api.asmx";
$api_wsdl = "api/APIService.wsdl";
$api_options = array('location' => $api_endpoint, 'trace' => true, 'features' => SOAP_SINGLE_ELEMENT_ARRAYS);
$api = new APIService($api_wsdl, $api_options);
// set credentials on the api object - if we have an integrator key then we prepend that to the UserID
$api->setCredentials("[" . $IntegratorsKey . "]" . $_SESSION["UserID"], $_SESSION["Password"]);


// main page loop
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST["Submit"])) {

        // setup recipient. This varies depending on whether we have selected Embedded Signing or Embedded Sending
        $Recipient = makeRecipient();

        // role assignments - this indicates what Role a recipient will play in a template
        $RoleRef = new TemplateReferenceRoleAssignment();
        $RoleRef->RecipientID = $Recipient->ID;
        $RoleRef->RoleName = $Recipient->RoleName;

        // get our Template Ref - this indicates that we will use a server side template for the signing
        $TemplateReference = makeTemplateReference();
        $TemplateReference->RoleAssignments[0] = $RoleRef;
        // add form fields to bring in the posted data
        //$TemplateReference->FieldData->DataValues = makeTemplateFormFields();
        
		/****************/
		if(isset($_SESSION['scEmail']) && $_SESSION['scEmail']!="") 
		{
			$Recipient2 = makeRecipient2();

			// role assignments - this indicates what Role a recipient will play in a template
			$RoleRef2 = new TemplateReferenceRoleAssignment();
			$RoleRef2->RecipientID = $Recipient2->ID;
			$RoleRef2->RoleName = $Recipient2->RoleName;
	
			// get our Template Ref - this indicates that we will use a server side template for the signing
			$TemplateReference->RoleAssignments[1] = $RoleRef2;
		}
		
		// add form fields to bring in the posted data
        $TemplateReference->FieldData->DataValues = makeTemplateFormFields();
        
		
		/****************/
		// envelope info -
        $EnvelopeInfo = makeEnvelopeInfo();


        //bundle all into params for call
        $TemplateParams = new CreateEnvelopeFromTemplates();
        $TemplateParams->TemplateReferences->TemplateReference[0] = $TemplateReference;
        $TemplateParams->Recipients->Recipient[0] = $Recipient;
		
		if(isset($Recipient2))
			$TemplateParams->Recipients->Recipient[1] = $Recipient2;
        
		$TemplateParams->EnvelopeInformation = $EnvelopeInfo;
        
		
		
		if (isset($_POST["embeddedSending"])) {
            $TemplateParams->ActivateEnvelope = false;
        } else {
            $TemplateParams->ActivateEnvelope = true;
        }
        // do we have a CC Recipient to handled?
        if (isset($_POST["emailDestinationCC"]) && ($_POST["emailDestinationCC"] <> "")) {
            $CCRecipient = makeCCRecipient($_POST["emailDestinationCC"]);
            $TemplateParams->Recipients->Recipient[1] = $CCRecipient;
        }

        // send Envelope
        try {
            $Response = $api->CreateEnvelopeFromTemplates($TemplateParams);
            addToLog("API Call - CreateEnvelopeFromTemplates Request", '<pre>' . xmlpp($api->_lastRequest, true) . '</pre>');
            addToLog("API Call - CreateEnvelopeFromTemplates Response", '<pre>' . xmlpp($api->__getlastResponse(), true) . '</pre>');
            $_SESSION["EnvelopeID"] = $Response->CreateEnvelopeFromTemplatesResult->EnvelopeID;
        } catch (SoapFault $fault) {
            $_SESSION["errorMessage"] = $fault;
            $_SESSION["lastRequest"] = $api->_lastRequest;
            header("Location: error.php");
            die();
        }

        if (isset($_POST["embeddedSigning"])) {
            $RequestRecipientTokenParams = makeRequestRecipientToken($Recipient);
            try {
                $RequestRecipientTokenResponse = $api->RequestRecipientToken($RequestRecipientTokenParams);
                addToLog("API Call - RequestRecipientToken Request", '<pre>' . xmlpp($api->_lastRequest, true) . '</pre>');
                addToLog("API Call - RequestRecipientToken Response", '<pre>' . xmlpp($api->__getlastResponse(), true) . '</pre>');
            } catch (SoapFault $fault) {
                $_SESSION["errorMessage"] = $fault;
                $_SESSION["lastRequest"] = $api->_lastRequest;
                header("Location: error.php");
                die();
            }
            $_SESSION["EmbeddedToken"] = $RequestRecipientTokenResponse->RequestRecipientTokenResult;
            $URL = "embedHost.php";
        } else if (isset($_POST["embeddedSending"])) {
            $RequestSenderTokenParam = new RequestSenderToken();
            $RequestSenderTokenParam->EnvelopeID = $_SESSION["EnvelopeID"];
            $RequestSenderTokenParam->AccountID = $_SESSION["AccountID"];
            $RequestSenderTokenParam->ReturnURL = getCallbackURL("pop.html");

            try {
                $RequestSenderTokenResponse = $api->RequestSenderToken($RequestSenderTokenParam);
                addToLog("API Call - RequestSenderToken Request", '<pre>' . xmlpp($api->_lastRequest, true) . '</pre>');
                addToLog("API Call - RequestSenderToken Response", '<pre>' . xmlpp($api->__getlastResponse(), true) . '</pre>');
                
            } catch (SoapFault $fault) {
                $_SESSION["errorMessage"] = $fault;
                $_SESSION["lastRequest"] = $api->_lastRequest;
                header("Location: error.php");
                die();
            }
            $_SESSION["EmbeddedToken"] = $RequestSenderTokenResponse->RequestSenderTokenResult;
            $URL = "embedHost.php";
        } else {
            $URL = "autoAppStatus.php";
        }

        header("Location: " . $URL);
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
        <script type="text/javascript" src="scripts/util.js"></script>
        <link rel="stylesheet" type="text/css" href="css/style.css"></link>
    </head>
    <body onload="document.getElementById('submit').click();" >
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
                <h1>Loan Modification Retainer Document</h1>

                <form class="applicationForm" id="applicationForm" method="post" action="autoAppApply.php">
                    <fieldset style="display: none">
                        <legend class="heading">Details</legend>

                        <p>Please fill in all fields:</p>

                        <label for="firstName">
                            <input name="firstName"  tabindex="1" size="50" id="firstName" type="text">
                            First Name:                        </label>
                        <label for="lastName">
                            <input name="lastName"  tabindex="2" size="50" id="lastName" type="text">
                            Last Name:                        </label>
                    </fieldset>
                   
                    <fieldset style="display: none">
                        <legend class="heading">Car Details</legend>

                        <p>Please fill in all fields:</p>
                        <label for="carMake">
                            <input name="carMake"  tabindex="3" size="50" id="carMake" type="text">
                            Car Make:                        </label>
                        <label for="carModel">
                            <input name="carModel"  tabindex="4" size="50" id="carModel" type="text">
                            Car Model:                        </label>
                        <label for="carVIN">
                            <input name="carVIN"  tabindex="5" size="50" id="carVIN" type="text">
                            Car VIN #:                        </label>
                        <div id="embeddedSigningFieldSection">
                            <label for="embeddedSigning">
                                <input type="checkbox" onClick="ShowHide()" name="embeddedSigning" tabindex="6" id="embeddedSigning" />
                                <span>Complete Application now? (Embedded Signing)</span>
                            </label>
                        </div>
                        <div id="embeddedSendingFieldSection">

                            <label for="embeddedSending">
                                <input type="checkbox" onClick="ShowHide1()" name="embeddedSending" tabindex="6" id="embeddedSending" />
                                <span>Customize Insurance Application? (Embedded Sending)</span>
                            </label>
                        </div>
                        <div id="emailDestinationFieldSection">
                            <label for="emailDestination">
                                <input name="emailDestination" tabindex="6" id="emailDestination" type="text">
                                <span>What email address should receive the application?</span>
                            </label>
                            <label for="emailDestinationCC">
                                <input type="text" name="emailDestinationCC" tabindex="6" id="emailDestinationCC" value="" />
                                <span>What is the email address of the carbon copied recipient?</span>
                            </label>
                        </div>

                    </fieldset>
                    <fieldset style="display: none">

                        <legend class="heading">Authorization Options</legend>

                        <span>Extra Authentication?</span><br/>
                        <label for="AuthenticationMethod">
                            <input name="AuthenticationMethod" type="radio" class="form" value="None" onClick="togglePhoneNumberInput()" checked="checked" >None</input><br/>
                            <input name="AuthenticationMethod" type="radio" class="form" value="IDLookup" onClick="togglePhoneNumberInput()">IDLookup</input><br/>
                            <input name="AuthenticationMethod" type="radio" class="form" value="Phone" onClick="togglePhoneNumberInput()">Phone</input><br/>
                        </label>

                        <div id="authPhoneNumberContainer" style="display: none;" >
                            <label for="authPhoneNumber">
                                <span>Authentication Phone Number:</span>
                                <input type="text" name="authPhoneNumber" id="authPhoneNumber"/>
                            </label>
                        </div>

                        <label for="accessCode">
                            <input type="text" name="accessCode" tabindex="8" id="accessCode" value="" />
                            <span>Application Access Code</span>
                        </label>
                    </fieldset>
                    <div style="width: 700px; text-align: center;">
                        <img src="./images/loading.gif" />
                    </div>
                    <input name="Submit" id="submit" tabindex="7" value="Submit" type="submit" style="display:none" />
                </form>
            </span>
        </div>
        <script type="text/javascript">
            
            

            function prefillForm() {
                document.getElementById("emailDestination").value = "<?php echo $_SESSION["Email"]; ?>";
                document.getElementById("firstName").value = "test";
                document.getElementById("lastName").value = "docusign";
                document.getElementById("carVIN").value = "VIN-123456";
                document.getElementById("carMake").value = "Ford";
                document.getElementById("carModel").value = "Escort";

                return true;
            }

            function ValidateInput() {
                var msg = "The following fields are required:\n";
                var valid = true;
                if (document.getElementById("firstName").value.length == 0) {
                    msg +="\tFirst Name\n";
                    valid = false;
                }
                if (document.getElementById("lastName").value.length == 0) {
                    msg += "\tLast Name\n";
                    valid = false;
                }
                if (document.getElementById("emailDestination").value.length == 0) {
                    msg += "\tEmail\n";
                    valid = false;
                }
                if (document.getElementById("carMake").value.length == 0) {
                    msg += "\tMake\n";
                    valid = false;
                }
                if (document.getElementById("carModel").value.length == 0) {
                    msg += "\tModel\n";
                    valid = false;
                }
                if (document.getElementById("carVIN").value.length == 0) {
                    msg += "\tVIN\n";
                    valid = false;
                }
                if (document.getElementById("phoneAuthentication").checked == true && document.getElementById("authPhoneNumber").value.search(/\d{3}\-\d{3}\-\d{4}/)==-1) {
                    msg += "\tAuthentication Phone Number (use xxx-xxx-xxxx format)\n";
                    valid = false;
                }


                if(!valid)
                    alert(msg);

                return valid;
            }
            
            document.getElementById("embeddedSending").checked = true;

        </script>
    </body>
</html>