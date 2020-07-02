<cfinclude template="template/header.cfm">

<cfif isDefined("FORM.idDebtHolder")>
	<cfinvoke component="components.letters" method="generateLetters" argumentCollection="#FORM#">
</cfif>

<cffile action="read" file="#APPLICATION.localPath#/letters/Addendum.html" variable="SESSION.Addendum">
<cffile action="read" file="#APPLICATION.localPath#/letters/CeaseDesist.html" variable="SESSION.CeaseDesist">
<cffile action="read" file="#APPLICATION.localPath#/letters/BankruptcyLetter.html" variable="SESSION.BankruptcyLetter">
<cffile action="read" file="#APPLICATION.localPath#/letters/DeclinationLetter.html" variable="SESSION.DeclinationLetter">
<cffile action="read" file="#APPLICATION.localPath#/letters/VerificationLetter.html" variable="SESSION.VerificationLetter">
<cffile action="read" file="#APPLICATION.localPath#/letters/NonResponsiveClientLetter.html" variable="SESSION.NonResponsiveClientLetter">
<cffile action="read" file="#APPLICATION.localPath#/letters/NonResponsiveClientLetterSpanish.html" variable="SESSION.NonResponsiveClientLetterSpanish">
<cffile action="read" file="#APPLICATION.localPath#/letters/SecondDisputeLetterResponseToFirst.html" variable="SESSION.SecondDisputeLetterResponseToFirst">
<cffile action="read" file="#APPLICATION.localPath#/letters/SecondDisputeLetterNoResponseToFirst.html" variable="SESSION.SecondDisputeLetterNoResponseToFirst">
<cffile action="read" file="#APPLICATION.localPath#/letters/AcceptanceLetter.html" variable="SESSION.AcceptanceLetter">


<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="debtHolderQuery">

<script>
	function editLetter(idLetter){
		ColdFusion.Window.create(
		'editLetter'+idLetter,
		'Edit',
		'letterEdit.cfm?idLetter='+idLetter,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 220
		}
		);
	}
</script>

<cfform name="lettersForm">
	<fieldset class="col1">
		<legend>Debt Holder</legend>
		<ul class="checklist">
		<cfoutput query="debtHolderQuery">
			<li><label><cfinput type="checkbox" name="idDebtHolder" value="#idDebtHolder#">#type# #name# - <em>#accountNumber#</em></label></li>
		</cfoutput>
		</ul>
	</fieldset>		
	
	<fieldset class="col2">
		<legend>Letters</legend>
		<ul class="checklist">
			<li><label><cfinput type="checkbox" name="AcceptanceLetter" value="1">Acceptance Letter</label></li>
			<li><label><cfinput type="checkbox" name="Addendum" value="1">Addendum</label></li>
			<li><label><cfinput type="checkbox" name="CeaseDesist" value="1">Cease & Desist</label></li>
			<li><label><cfinput type="checkbox" name="BankruptcyLetter" value="1">Bankruptcy Letter</label></li>
			<li><label><cfinput type="checkbox" name="DeclinationLetter" value="1">Declination Letter</label></li>
			<li><label><cfinput type="checkbox" name="VerificationLetter" value="1">Verification Letter</label></li>
			<li><label><cfinput type="checkbox" name="NonResponsiveClientLetter" value="1">Non-Responsive Client Letter</label></li>
			<li><label><cfinput type="checkbox" name="NonResponsiveClientLetterSpanish" value="1">Non Responsive client letter - Spanish</label></li>
			<li><label><cfinput type="checkbox" name="SecondDisputeLetterResponseToFirst" value="1">Second Dispute Letter (Incomplete Response to first)</label></li>
			<li><label><cfinput type="checkbox" name="SecondDisputeLetterNoResponseToFirst" value="1">Second Dispute Letter (No response to First)</label></li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Generate">
	</fieldset>
			
</cfform>


<cfform name="lettersGridForm">
	<cfgrid 
		name="lettersGrid"
		bindOnLoad="true" 
		bind="cfc:components.letters.getLettersByFileId({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">
			
			<cfgridcolumn name="thisDebtHolder" header="Debt Holder" width="200">
			<cfgridcolumn name="letterType" header="Type" width="200">
			<cfgridcolumn name="tracking" header="Traking" width="300">
			<cfgridcolumn name="actions" header="Actions" width="80" dataAlign="Center">

	</cfgrid>
</cfform>
<cfinclude template="template/footer.cfm">