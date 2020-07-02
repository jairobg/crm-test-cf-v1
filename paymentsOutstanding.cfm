<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Payment') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 


<cfform name="affiliateOutstandingGridForm">
	<cfoutput>
	<input type="hidden" name="paymentType" value="#URL.type#" />
	</cfoutput>
	<fieldset>
		<legend>Payments <cfoutput>#URL.type#</cfoutput></legend>
	</fieldset>
	<cfgrid 
		name="affiliateOutstandingGrid" 
		format="html" 
		width="790"
		height="285" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="10"
		bindOnLoad="true" 
		bind="cfc:components.payments.getOutstandingPaymentsClients({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{paymentType})"
		selectMode="row" sort="yes">
			<cfgridcolumn name="idFile" header="File ID" width="100" />
			<cfgridcolumn name="firstName" header="First Name" width="100" />
			<cfgridcolumn name="lastName" header="Last Name" width="100" />
			<cfgridcolumn name="itkFirstInstallmentDate" header="Down Payment Date" width="100" dataAlign="Right" />
			<cfgridcolumn name="itkDownPayment" header="Down Payment" width="100" dataAlign="Right" />
			<cfgridcolumn name="itkRecurrentPaymentDate" header="Monthly Payment Date" width="100" dataAlign="Right"/>
			<cfgridcolumn name="itkMontlyPayment" header="Monthly Payment" width="100" dataAlign="Right" />
			<cfgridcolumn name="edit" header="Actions" width="80" dataAlign="Center" />
	</cfgrid>
</cfform>


<script type="text/javascript">

 	function submitPaymentForm(thisForm) { 
 		disableDoubleClick();
        ColdFusion.Ajax.submitForm(thisForm, 'php/paymentGenerator.php', callback, 
            errorHandler); 
    } 
     
    function callback(text) 
    { 
        alert(text);
        window.location = "paymentsOutstanding.cfm";
    } 
     
    function errorHandler(code, msg) 
    { 
        alert("Error!!! " + code + ": " + msg); 
    } 

</script>

<cfinclude template="template/footer.cfm">