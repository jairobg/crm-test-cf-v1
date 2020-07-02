<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Payment') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<!doctype html>

<html lang="en">
<head>
	<meta charset="utf-8">

	<title>CRMLex RLG Payment</title>
 
	<link href="http://rlg-dev.crmlex.com/template//css/cf-ui-reset.css" rel="stylesheet">
	<link href="http://rlg-dev.crmlex.com/template//css/reset.css" rel="stylesheet">
	<link href="http://rlg-dev.crmlex.com/template//css/style.css?v=2" rel="stylesheet">
	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>

<style type="text/css">
label {
    width: 190px !important;}
</style>

<body>
<cfajaximport tags="cfgrid,cfdiv,cfform,cfwindow,cfinput-datefield,cflayout-tab,cfinput-autosuggest">

<cfinvoke  component="components.payments" method="getOutstandingPaymentsClientInfo" returnVariable="thisOutstandingPaymentsClientInfo">
	<cfinvokeargument name="idFile" value="#URL.idFile#" />		
</cfinvoke>

<!--------------------------------------------------------->
<!------- Payment info ------------------------------------>
<!--------------------------------------------------------->
<cfoutput query="thisOutstandingPaymentsClientInfo">

<cfform name="paymentInfoForm">
<fieldset>
	<legend style="font-size: 2em;padding-bottom: 0.5em;padding-left: 1em;">Payment</legend>
</fieldset>

<fieldset class="col1">

	<ul style="padding-left:2em;">

		<li>
			<label for="idFile">File ID</label>
			<cfinput disabled="true" type="text" name="idFile" value="#idFile#">
		</li>
		<hr />
		<li>
			<label for="firstName">First Name</label>
			<cfinput disabled="true" type="text" name="firstName" value="#firstName#">
		</li>
		<hr />
		<li>
			<label for="lastName">Last Name</label>
			<cfinput disabled="true" type="text" name="lastName" value="#lastName#">
		</li>
		<hr />
		<li>
			<label for="dateBirth">Date Birth</label>
			<cfinput disabled="true" type="text" name="dateBirth" value="#dateBirth#">
		</li>
		<hr />
		<li>
			<label for="socialSecurity">Social Security Number</label>
			<cfinput disabled="true" type="text" name="socialSecurity" value="#socialSecurity#">
		</li>
		<hr />
		<li>
			<label for="address">Address</label>
			<cfinput disabled="true" type="text" name="address" value="#address#">
		</li>
		<hr />
		<li>
			<label for="city">City</label>
			<cfinput disabled="true" type="text" name="city" value="#city#">
		</li>
		<hr />
		<li>
			<label for="abbreviation">State</label>
			<cfinput disabled="true" type="text" name="abbreviation" value="#abbreviation#">
		</li>
		<hr />
		<li>
			<label for="zip">Zip Code</label>
			<cfinput disabled="true" type="text" name="zip" value="#zip#">
		</li>
		<hr />
		<li>
			<label for="homePhone">Home Phone</label>
			<cfinput disabled="true" type="text" name="homePhone" value="#homePhone#">
		</li>
		<hr />
		<li>
			<label for="email">e-mail</label>
			<cfinput disabled="true" type="text" name="email" value="#email#">
		</li>
		<hr />
		<li>
			<label for="affiliateCompanyName">Affiliate Company</label>
			<cfinput type="text" name="affiliateCompanyName" value="#affiliateCompanyName#" />
		</li>
		<hr />
		<li>
			<label for="itkFirstInstallmentDate">First Installment Date</label>
			<cfinput type="text" name="itkFirstInstallmentDate" value="#itkFirstInstallmentDate#" />
		</li>
		<hr />



	</ul>

</fieldset>



<fieldset class="col2">
	<ul>
		<li>
			<label for="itkDownPayment">Down Payment</label>
			<cfinput disabled="true" type="text" name="itkDownPayment" value="#itkDownPayment#">
		</li>
		<hr />
		<li>
			<label for="itkAccountNumber">Account Number</label>
			<cfinput disabled="true" type="text" name="itkAccountNumber" value="#itkAccountNumber#">
		</li>
		<hr />
		<li>
			<label for="itkRoutingNumber">Routing Number</label>
			<cfinput disabled="true" type="text" name="itkRoutingNumber" value="#itkRoutingNumber#">
		</li>
		<hr />
		<li>
			<label for="itkMontlyPayment">Montly Payment</label>
			<cfinput disabled="true" type="text" name="itkMontlyPayment" value="#itkMontlyPayment#">
		</li>
		<hr />
		<li>
			<label for="itkProgramLenght">Program Lenght</label>
			<cfinput disabled="true" type="text" name="itkProgramLenght" value="#itkProgramLenght#">
		</li>
		<hr />
		<li>
			<label for="itkRecurrentPaymentDate">Recurrent PaymentDate</label>
			<cfinput disabled="true" type="text" name="itkRecurrentPaymentDate" value="#itkRecurrentPaymentDate#">
		</li>
		<hr />
		<li>
			<label for="affiliateCompanyPercent">Affiliate Company Percent</label>
			<cfinput disabled="true" type="text" name="affiliateCompanyPercent" value="#affiliateCompanyPercent#"/>
		</li>
		<hr />
		<li>
			<label for="affiliateCompanyPercent">Affiliates % of the Fee</label>
			<cfinput disabled="true" type="text" name="affiliateCompanyPercent" value="#affiliateCompanyPercent#"/>
		</li>
		<hr />
		<li>
			<label for="totalBrokersFeeToRick">Total Brokers % of the Fee to Rick Graff Inc.</label>
			<cfinput disabled="true" type="text" name="totalBrokersFeeToRick" value="#totalBrokersFeeToRick#"/>
		</li>
		<hr />
		<li>
			<label for="totalBrokersFeeToLawSupport">Total Master Brokers % of the Fee to Law Support & Consultants</label>
			<cfinput disabled="true" type="text" name="totalBrokersFeeToLawSupport" value="#totalBrokersFeeToLawSupport#"/>
		</li>
		<hr />
		<li>
			<label for="ramsaranFee">Ramsaran Fee %</label>
			<cfinput disabled="true" type="text" name="ramsaranFee" value="#ramsaranFee#"/>
		</li>
		<hr />
		<li>
			<label for="monthlyMaintenanceAffiliate">Affiliate $ amount of Monthly Maintenance Fee </label>
			<cfinput disabled="true" type="text" name="monthlyMaintenanceAffiliate" value="#monthlyMaintenanceAffiliate#"/>
		</li>
		<hr />
		<li>
			<label for="monthlyMaintenanceRick">Monthly Maintenance Fee to Rick Graff Inc.</label>
			<cfinput disabled="true" type="text" name="monthlyMaintenanceRick" value="#monthlyMaintenanceRick#"/>
		</li>
		<hr />
		<li>
			<label for="monthlyMaintenanceLawSupport">Monthly Maintenance Fee to Law Support & Consultants</label>
			<cfinput disabled="true" type="text" name="monthlyMaintenanceLawSupport" value="#monthlyMaintenanceLawSupport#"/>
		</li>
		<hr />
		<li>
			<label for="ramsaranMonthly">Ramsaran Monthly $</label>
			<cfinput disabled="true" type="text" name="ramsaranMonthly" value="#ramsaranMonthly#"/>
		</li>
		<hr />
		<li>
			<label for="affiliateCompanyCreationDate">Affiliate Company CreationDate</label>
			<cfinput disabled="true" type="text" name="affiliateCompanyCreationDate" value="#affiliateCompanyCreationDate#"/>
		</li>
		<hr />
	</ul>
</fieldset>



<cfinput type="hidden" name="idFile" value="#idFile#">
<cfinput type="hidden" name="firstName" value="#firstName#">
<cfinput type="hidden" name="lastName" value="#lastName#">
<cfinput type="hidden" name="dateBirth" value="#dateBirth#">
<cfinput type="hidden" name="socialSecurity" value="#socialSecurity#">
<cfinput type="hidden" name="address" value="#address#">
<cfinput type="hidden" name="city" value="#city#">
<cfinput type="hidden" name="abbreviation" value="#abbreviation#">
<cfinput type="hidden" name="zip" value="#zip#">
<cfinput type="hidden" name="cellPhone" value="#cellPhone#">
<cfinput type="hidden" name="homePhone" value="#homePhone#">
<cfinput type="hidden" name="email" value="#email#">
<cfinput type="hidden" name="itkDownPayment" value="#itkDownPayment#">
<cfinput type="hidden" name="itkAccountNumber" value="#itkAccountNumber#">
<cfinput type="hidden" name="itkRoutingNumber" value="#itkRoutingNumber#">
<cfinput type="hidden" name="itkMontlyPayment" value="#itkMontlyPayment#">
<cfinput type="hidden" name="itkProgramLenght" value="#itkProgramLenght#">
<cfinput type="hidden" name="itkRecurrentPaymentDate" value="#itkRecurrentPaymentDate#">
<cfinput type="hidden" name="affiliateCompanyPercent" value="#affiliateCompanyPercent#"/>
<cfinput type="hidden" name="affiliateCompanyPercent" value="#affiliateCompanyPercent#"/>
<cfinput type="hidden" name="totalBrokersFeeToRick" value="#totalBrokersFeeToRick#"/>
<cfinput type="hidden" name="totalBrokersFeeToLawSupport" value="#totalBrokersFeeToLawSupport#"/>
<cfinput type="hidden" name="ramsaranFee" value="#ramsaranFee#"/>
<cfinput type="hidden" name="monthlyMaintenanceAffiliate" value="#monthlyMaintenanceAffiliate#"/>
<cfinput type="hidden" name="monthlyMaintenanceRick" value="#monthlyMaintenanceRick#"/>
<cfinput type="hidden" name="monthlyMaintenanceLawSupport" value="#monthlyMaintenanceLawSupport#"/>
<cfinput type="hidden" name="ramsaranMonthly" value="#ramsaranMonthly#"/>
<cfinput type="hidden" name="affiliateCompanyCreationDate" value="#affiliateCompanyCreationDate#"/>
<cfinput type="hidden" name="affiliateCompanyName" value="#affiliateCompanyName#" />
<cfinput type="hidden" name="itkFirstInstallmentDate" value="#itkFirstInstallmentDate#" />
<cfinput type="hidden" name="payToId" value="#payToId#" />
	


</cfform>

</cfoutput>
<hr />
<cfif URL.type EQ "EPPS">
<fieldset class="action-buttons">
	<a class="submitButton" id="sendRetainer" href="javascript:submitPaymentForm()" onclick="return disableDoubleClick()">Process EPPS</a> 
	<input id="buttonFlag" type="hidden" value="0">
</fieldset>		
<hr />
</cfif>

<cfif URL.type EQ "Paytoo">
<fieldset class="action-buttons">
	<a class="submitButton" id="sendRetainer" href="javascript:submitPaymentFormPayToo()" onclick="return disableDoubleClick()">Process PayToo</a> 
	<input id="buttonFlag" type="hidden" value="0">
</fieldset>		
<hr />
</cfif>

<script type="text/javascript">

 	function submitPaymentForm() { 
 		if (document.getElementById("buttonFlag").value == "0"){
	 		document.getElementById("buttonFlag").value = "1";
	 		document.getElementById("sendRetainer").innerHTML = "Processing request";
	 		disableDoubleClick();
	       ColdFusion.Ajax.submitForm('paymentInfoForm', 'php/paymentGenerator.php', callback, errorHandler); 
 		}
    } 


 	function submitPaymentFormPayToo() { 
 		if (document.getElementById("buttonFlag").value == "0"){
	 		document.getElementById("buttonFlag").value = "1";
	 		document.getElementById("sendRetainer").innerHTML = "Processing request";
	 		disableDoubleClick();
	       ColdFusion.Ajax.submitForm('paymentInfoForm', 'php/integrator.php', callback, errorHandler); 
 		}
    } 

     
    function callback(text) 
    { 
        alert(text);
        window.close();
    } 
     
    function errorHandler(code, msg) 
    { 
        alert("Error!!! " + code + ": " + msg); 
    } 


	disableDoubleClick = function() {
        if (typeof(_linkEnabled)=="undefined") _linkEnabled = true;
        setTimeout("blockClick()", 100);
        return _linkEnabled;
    }
    blockClick = function() {
        _linkEnabled = false;
        setTimeout("_linkEnabled=true", 10000);
    }
</script>


</body>
</html>
