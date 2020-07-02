<cfinclude template="template/header.cfm">

<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<cfinvoke component="components.properties" method="getAllPropertiesByFileId" returnvariable="allProperties">

<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="thisDebtHoldersQuery">

<cfinvoke component="components.affiliates" method="getSuperAffiliate" returnVariable="thisSuperAffiliate">

<!--- Poner el Owner al cliente si no existe --->
<cfif SESSION.thisProfile EQ "Affiliates">
	<cfinvoke  component="components.file" method="saveFileOwner">
	</cfinvoke>
</cfif>



<!---- VALIDATIONS --->

<cfset validationMessage = "">

<cfset fullName = thisFileQuery.firstName&thisFileQuery.initial&thisFileQuery.lastName>
<cfif fullName EQ "">
	<cfset validationMessage = validationMessage & "<br />The client Name is missing">
</cfif>

<cfset allPhones = thisFileQuery.homePhone&thisFileQuery.businessPhone&thisFileQuery.cellPhone>
<cfif allPhones EQ "">
	<cfset validationMessage = validationMessage & "<br />The client Phone is missing">
</cfif>

<cfif thisFileQuery.email EQ "">
	<cfset validationMessage = validationMessage & "<br />The client E-mail is missing">
</cfif>
<cfif thisFileQuery.itkTotalRetainerFee EQ "">
	<cfset validationMessage = validationMessage & "<br />The client Total retainer fee is missing">
</cfif>
<cfif thisFileQuery.itkDownPayment EQ "">
	<cfset validationMessage = validationMessage & "<br />The client Down payment is missing">
</cfif>

<cfif thisFileQuery.itkMontlyPayment EQ "">
	<cfset validationMessage = validationMessage & "<br />The client Monthly payment is missing">
</cfif>

<cfif IsNull(thisFileQuery.itkFirstInstallmentDate)>
	<cfset validationMessage = validationMessage & "<br />The client First installment date is missing">
</cfif>
<cfif IsNull(thisFileQuery.itkRecurrentPaymentDate)>
	<cfset validationMessage = validationMessage & "<br />The client Recurrent Payment date is missing">
</cfif>
<cfif thisFileQuery.itkMonthlyRetainer EQ "">
	<cfset validationMessage = validationMessage & "<br />The client monthly retainer is missing">
</cfif>

<cfif IsNull(thisFileQuery.state1)>
	<cfset validationMessage = validationMessage & "<br />The client Address State is missing">
</cfif>

<cfif thisDebtHoldersQuery.recordCount EQ 0>
	<cfset validationMessage = validationMessage & "<br />The client must have at least one data in Creditors">
</cfif>

<cfform name="gentRetForm">
	<!--- User --->
	<cfinput type="hidden" name="userEmail" value="#SESSION.userEmail#">
	<cfinput type="hidden" name="userName" value="#SESSION.userName#">
	<!--- client --->
	<cfinput type="hidden" name="idFile" value="#thisFileQuery.idFile#">	
	<cfinput type="hidden" name="name1" value="#thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#">
	<cfinput type="hidden" name="name2" value="#thisFileQuery.scfirstName# #thisFileQuery.scinitial# #thisFileQuery.sclastName#">
	<cfinput type="hidden" name="nameBoth" value="#thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#,  #thisFileQuery.scfirstName# #thisFileQuery.scinitial# #thisFileQuery.sclastName#">	
	<cfinput type="hidden" name="address" value="#thisFileQuery.address#">
	<cfinput type="hidden" name="city" value="#thisFileQuery.city#">
	<cfinput type="hidden" name="state" value="#thisFileQuery.state1#">
	<cfinput type="hidden" name="zip" value="#thisFileQuery.zip#">
	<cfinput type="hidden" name="homePhone" value="#thisFileQuery.homePhone#">
	<cfinput type="hidden" name="businessPhone" value="#thisFileQuery.businessPhone#">
	<cfinput type="hidden" name="cellPhone" value="#thisFileQuery.cellPhone#">
	<cfinput type="hidden" name="email" value="#thisFileQuery.email#">
	<cfinput type="hidden" name="socialSecurity" value="#thisFileQuery.socialSecurity#">
	<cfinput type="hidden" name="dateBirth" value="#dateFormat(thisFileQuery.dateBirth, 'mm/dd/yyyy')#">
	
	<!---
	<cfinput type="hidden" name="clientManualId" value="#thisFileQuery.clientManualId#">
	--->
	<cfinput type="hidden" name="clientManualId" value="#thisFileQuery.debtorId#">

	<cfinput type="hidden" name="scHomePhone" value="#thisFileQuery.scHomePhone#">
	<cfinput type="hidden" name="scDateBirth" value="#dateFormat(thisFileQuery.scDateBirth, 'mm/dd/yyyy')#">
	<cfinput type="hidden" name="scAddress" value="#thisFileQuery.scAddress#">
	<cfinput type="hidden" name="scCity" value="#thisFileQuery.scCity#">
	<cfinput type="hidden" name="scState" value="#thisFileQuery.state2#">
	<cfinput type="hidden" name="scZip" value="#thisFileQuery.scZip#">
	<cfinput type="hidden" name="scMaritalStatus" value="#thisFileQuery.scMaritalStatus#">
	<cfinput type="hidden" name="scEmail" value="#thisFileQuery.scEmail#">
	<cfinput type="hidden" name="scBusinessPhone" value="#thisFileQuery.scBusinessPhone#">
	<cfinput type="hidden" name="scCellPhone" value="#thisFileQuery.scCellPhone#">
	
	<!--- intake --->
	<cfinput type="hidden" name="itkTotalRetainerFee" value="#NumberFormat(thisFileQuery.itkTotalRetainerFee, '9.99')#">
	<cfinput type="hidden" name="itkDownPayment" value="#NumberFormat(thisFileQuery.itkDownPayment, '9.99')#">
	<cfinput type="hidden" name="itkMontlyPayment" value="#NumberFormat(thisFileQuery.itkMontlyPayment, '9.99')#">
	<cfinput type="hidden" name="itkProgramLenght" value="#thisFileQuery.itkProgramLenght#">
	<cfinput type="hidden" name="itkLitigationFee" value="#NumberFormat(thisFileQuery.itkLitigationFee, '9.99')#">
	<cfinput type="hidden" name="itkMonthlyProcessingFee" value="#NumberFormat(thisFileQuery.itkMonthlyProcessingFee, '9.99')#">
	<cfinput type="hidden" name="itkMonthlyRetainer" value="#NumberFormat(thisFileQuery.itkMonthlyRetainer, '9.99')#">
	<cfinput type="hidden" name="itkRoutingNumber" value="#thisFileQuery.itkRoutingNumber#">
	<cfinput type="hidden" name="itkAccountNumber" value="#thisFileQuery.itkAccountNumber#">
	<cfinput type="hidden" name="itkBankName" value="#thisFileQuery.itkBankName#">
	<cfinput type="hidden" name="itkFirstInstallmentDate" value="#dateFormat(thisFileQuery.itkFirstInstallmentDate, 'mm/dd/yyyy')#">
	<cfinput type="hidden" name="itkRecurrentPaymentDate" value="#dateFormat(thisFileQuery.itkRecurrentPaymentDate, 'mm/dd/yyyy')#">
	<cfinput type="hidden" name="itkAccountHolderName" value="#thisFileQuery.itkAccountHolderName#">
	<cfinput type="hidden" name="itkTotalDeb" value="#NumberFormat(thisFileQuery.itkTotalDeb, '9.99')#">
	
	<!--- intake tablas de pagos --->
	<!--- El dato se manda como itkMontlyPayment pero realmente es el itkMonthlyRetainer se deja asi para no cambiar la plantilla en docusign --->
	<cfloop from="1" to="36" index="i">
		<cfinput type="hidden" name="itkRecurrentPaymentDate#i#" value="">
		<cfinput type="hidden" name="itkMontlyPayment#i#" value="">
	</cfloop>
	<cfset paymentDate = #dateFormat(thisFileQuery.itkRecurrentPaymentDate, 'mm/dd/yyyy')#>
	<cfset paymentValue = #NumberFormat(thisFileQuery.itkMonthlyRetainer, "9.99")#>
	<cfif thisFileQuery.itkProgramLenght NEQ "">
		<cfset paymentsNumber = #thisFileQuery.itkProgramLenght#>
	<cfelse>
		<cfset paymentsNumber = 0>
	</cfif>
	<cfset sumTotalMonthlyPayment = 0 />
	<cfloop from="1" to="#paymentsNumber#" index="ii">
		<cfinput type="hidden" name="itkFirstInstallmentDate#ii#" value="#dateFormat(paymentDate, 'mm/dd/yyyy')#">
		<cfinput type="hidden" name="itkMontlyPayment#ii#" value="#dollarFormat(paymentValue)#">
		<cfset paymentDate = DateAdd("m", 1, paymentDate)>
		<cfset sumTotalMonthlyPayment = sumTotalMonthlyPayment + paymentValue />
	</cfloop>
	
	<cfinput type="hidden" name="sumTotalMonthlyPayment" value="#NumberFormat(sumTotalMonthlyPayment, '9.99')#">


	<!--- debtHolder --->
	<cfset debtHolderNumber = 0>
	<cfset debtHolderTotal = "">
	<cfif thisDebtHoldersQuery.recordCount NEQ 0>
		<!--- Get total --->
		<cfquery name="getDebtHolderTotal" dbtype="query">
			SELECT SUM(balance) debtHolderTotal FROM thisDebtHoldersQuery
		</cfquery>
		<cfset debtHolderTotal = getDebtHolderTotal.debtHolderTotal>
		<cfset debtHolderNumber = thisDebtHoldersQuery.recordCount>
		<cfoutput query="thisDebtHoldersQuery">
			<cfinput type="hidden" name="debtHolderName#thisDebtHoldersQuery.currentRow#" value="#thisDebtHoldersQuery.name#">
			<cfinput type="hidden" name="debtHolderAccount#thisDebtHoldersQuery.currentRow#" value="#thisDebtHoldersQuery.accountNumber#">
			<cfinput type="hidden" name="debtHolderBalance#thisDebtHoldersQuery.currentRow#" value="#dollarFormat(thisDebtHoldersQuery.balance)#">
		</cfoutput>		
	</cfif>
	<cfinput type="hidden" name="debtHolderTotal" value="#dollarFormat(debtHolderTotal)#">
	<cfinput type="hidden" name="debtHolderNumber" value="#debtHolderNumber#">
	
	<!---- Others --->
	<cfinput type="hidden" name="now" value="#dateFormat(now(), 'mm/dd/yyyy')#">
	<cfinput type="hidden" name="nowDay" value="#Day(now())#">
	<cfinput type="hidden" name="nowMonth" value="#MonthAsString(Month(now()))#">

	<cfif thisSuperAffiliate EQ "">
		<cfset thisSuperAffiliate = "none" />
	</cfif>
	<cfinput type="hidden" name="superAffiliateEmail" value="#thisSuperAffiliate#">

	
	
	<br><br>
    <fieldset>
    	<legend>Debt Retainer</legend>
	<fieldset>
        <ul>
        <li><label for="retainerTemplate">Type</label>
            <cfselect name="retainerTemplate">
                <option value="simple">Simple</option>    
                <option value="double">Double</option>    
                <!---
                retainerTemplate = simple
                retainerTemplate = double
                <option value="existingUser">Existing User</option>
                <option value="Florida">Florida</option>
                <option value="Arizona">Arizona</option>
                <option value="California">California</option> 
                --->  
            </cfselect>
        </li>
        </ul>	
	</fieldset>

</cfform>



<cfif validationMessage EQ "">
<fieldset class="action-buttons">
	<a class="submitButton" id="sendRetainer" href="javascript:submitForm()" onclick="return disableDoubleClick()">Generate Debt Retainer</a> 
</fieldset>		
<cfelse>
<center>
<p align="center">
	You need fill all required information:<br /><br />
	<cfoutput>#validationMessage#</cfoutput>
</p>
</center>
</cfif>


<script type="text/javascript">

 	 function submitForm() { 
  
        ColdFusion.Ajax.submitForm('gentRetForm', 'php/sendDocuments.php', callback, 
            errorHandler); 
    } 
     
    function callback(text) 
    { 
        alert(text);
        window.location = "fileEditForm.cfm";
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
	


<cfinclude template="template/footer.cfm">