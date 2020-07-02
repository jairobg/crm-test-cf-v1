<cfinclude template="template/header.cfm">

<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<cfinvoke component="components.properties" method="getAllPropertiesByFileId" returnvariable="allProperties">

<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="thisDebtHoldersQuery">

<!--- Des-Encriptar socialsecurity numbers --->
<cfif thisFileQuery.socialSecurity NEQ "" >
	<cfscript>
        decryptedSS = decrypt(thisFileQuery.socialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
    </cfscript>
<cfelse>
	<cfscript>
        decryptedSS = "";
    </cfscript>
</cfif>
 
<cfif thisFileQuery.scSocialSecurity NEQ "" >  
	<cfscript>
        decryptedScSS = decrypt(thisFileQuery.scSocialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
    </cfscript>
<cfelse>
	<cfscript>
        decryptedScSS = "";
    </cfscript>
</cfif>

<!---
<cfform name="test" action="#APPLICATION.website_url#/php/insuranceco/login.php" method="post" target="_blank">
<cfform name="test" action="#APPLICATION.website_url#/php/test.php" method="post" target="_blank">

--->

<!---
<cfif isDefined("FORM")>
	<cfdump var="#FORM#">
</cfif>
--->

<cfif isDefined("FORM.name1")>
	<cfmail to="beatriz.botero@nyxent.com" cc="andy.montoya@nyxent.com" bcc="jairo.botero@nyxent.com" subject="Retainer for client #SESSION.idFile#" from="rlg@crmlex.com" type="html">

		Created for: #SESSION.username#<br />
		User email: #SESSION.useremail#
		<br />
		<hr />
		<strong>Client</strong>
		<br />

		<cfdump var="#FORM#">
	</cfmail>
	<p>Retainer created, we will create the document</p>
</cfif>

<cfform name="test">

	<!--- client --->
	<cfinput type="hidden" name="name1" value="#thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#">
	<cfinput type="hidden" name="name2" value="#thisFileQuery.scfirstName# #thisFileQuery.scinitial# #thisFileQuery.sclastName#">
	<cfinput type="hidden" name="address" value="#thisFileQuery.address#">
	<cfinput type="hidden" name="city" value="#thisFileQuery.city#">
	<cfinput type="hidden" name="state" value="#thisFileQuery.state1#">
	<cfinput type="hidden" name="zip" value="#thisFileQuery.zip#">
	<cfinput type="hidden" name="homePhone" value="#thisFileQuery.homePhone#">
	<cfinput type="hidden" name="businessPhone" value="#thisFileQuery.businessPhone#">
	<cfinput type="hidden" name="cellPhone" value="#thisFileQuery.cellPhone#">
	<cfinput type="hidden" name="email" value="#thisFileQuery.email#">

	<cfinput type="hidden" name="scHomePhone" value="#thisFileQuery.scHomePhone#">
	<cfinput type="hidden" name="scDateBirth" value="#dateFormat(thisFileQuery.scDateBirth, 'mm/dd/yyyy')#">
	<cfinput type="hidden" name="scSocialSecurity" value="#decryptedScSS#">
	<cfinput type="hidden" name="scAddress" value="#thisFileQuery.scAddress#">
	<cfinput type="hidden" name="scCity" value="#thisFileQuery.scCity#">
	<cfinput type="hidden" name="scState" value="#thisFileQuery.state2#">
	<cfinput type="hidden" name="scZip" value="#thisFileQuery.scZip#">
	<cfinput type="hidden" name="scMaritalStatus" value="#thisFileQuery.scMaritalStatus#">
	<cfinput type="hidden" name="scEmail" value="#thisFileQuery.scEmail#">
	<cfinput type="hidden" name="scBusinessPhone" value="#thisFileQuery.scBusinessPhone#">
	<cfinput type="hidden" name="scCellPhone" value="#thisFileQuery.scCellPhone#">
	
	<!--- intake --->
	<cfinput type="hidden" name="itkTotalRetainerFee" value="#thisFileQuery.itkTotalRetainerFee#">
	<cfinput type="hidden" name="itkDownPayment" value="#thisFileQuery.itkDownPayment#">
	<cfinput type="hidden" name="itkMontlyPayment" value="#thisFileQuery.itkMontlyPayment#">
	<cfinput type="hidden" name="itkProgramLenght" value="#thisFileQuery.itkProgramLenght#">
	<cfinput type="hidden" name="itkLitigationFee" value="#thisFileQuery.itkLitigationFee#">
	<cfinput type="hidden" name="itkMonthlyProcessingFee" value="#thisFileQuery.itkMonthlyProcessingFee#">
	<cfinput type="hidden" name="itkMonthlyRetainer" value="#thisFileQuery.itkMonthlyRetainer#">
	<cfinput type="hidden" name="itkRoutingNumber" value="#thisFileQuery.itkRoutingNumber#">
	<cfinput type="hidden" name="itkAccountNumber" value="#thisFileQuery.itkAccountNumber#">
	<cfinput type="hidden" name="itkBankName" value="#thisFileQuery.itkBankName#">
	<cfinput type="hidden" name="itkFirstInstallmentDate" value="#dateFormat(thisFileQuery.itkFirstInstallmentDate, 'mm/dd/yyyy')#">
	<cfif thisFileQuery.itkFirstInstallmentDate NEQ "">
		<cfinput type="hidden" name="itkFirstInstallmentDateDay" value="#Day(thisFileQuery.itkFirstInstallmentDate)#">
	</cfif>
	<cfinput type="hidden" name="itkAccountHolderName" value="#thisFileQuery.itkAccountHolderName#">
	<!--- intake tablas de pagos --->
	<!--- El dato se manda como itkMontlyPayment pero realmente es el itkMonthlyRetainer se deja asi para no cambiar la plantilla en docusign --->
	<cfloop from="1" to="36" index="i">
		<cfinput type="hidden" name="itkFirstInstallmentDate#i#" value="">
		<cfinput type="hidden" name="itkMontlyPayment#i#" value="">
	</cfloop>
	<cfset paymentDate = #dateFormat(thisFileQuery.itkFirstInstallmentDate, 'mm/dd/yyyy')#>
	<cfset paymentValue = #NumberFormat(thisFileQuery.itkMonthlyRetainer, "9.99")#>
	<cfif thisFileQuery.itkProgramLenght NEQ "">
		<cfset paymentsNumber = #thisFileQuery.itkProgramLenght#>
	<cfelse>
		<cfset paymentsNumber = 0>
	</cfif>
	<cfloop from="1" to="#paymentsNumber#" index="ii">
		<cfinput type="hidden" name="itkFirstInstallmentDate#ii#" value="#dateFormat(paymentDate, 'mm/dd/yyyy')#">
		<cfinput type="hidden" name="itkMontlyPayment#ii#" value="#paymentValue#">
		<cfset paymentDate = DateAdd("m", 1, paymentDate)>
	</cfloop>
	



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
	<br><br>
    <fieldset>
    	<legend>Debt Retainer</legend>
	<fieldset>
        <ul>
        <li><label for="retainerDebtType">Type</label>
            <cfselect name="retainerDebtType" enabled="no">
                <option value="normal">Normal</option>    
                <!---
                <option value="existingUser">Existing User</option>
                <option value="Florida">Florida</option>
                <option value="Arizona">Arizona</option>
                <option value="California">California</option> 
                --->  
            </cfselect>
        </li>
        </ul>	
	</fieldset>
	
	
	<cfif isDefined("FORM.name1") EQ FALSE>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Generate Debt Retainer">
	</fieldset>
	</cfif>
	
</cfform>


<cfinclude template="template/footer.cfm">