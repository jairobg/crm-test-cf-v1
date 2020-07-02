<cfparam name="editHolderMessage" default="">

<cfif isDefined("FORM.name")>
	<cfinvoke component="components.debtHolder" method="editHolder" returnVariable="editHolderMessage" argumentCollection="#FORM#">
	<cfif editHolderMessage EQ "">
		<script>
			ColdFusion.Grid.refresh('creditorsGrid', true);
			<cfoutput>
				ColdFusion.Window.destroy('editCreditor#FORM.idDebtHolder#',true);
			</cfoutput>	
		</script>
		<cfexit>
	</cfif>
</cfif>

<cfinvoke component="components.debtHolder" method="getHolderById" returnVariable="thisHolder">
	<cfinvokeargument name="idDebtHolder" value="#URL.idDebtHolder#">
</cfinvoke>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<div><cfoutput>#editHolderMessage#</cfoutput></div>

<cfform name="creditorsEditForm">
<fieldset class="col1">
	<legend>Edit Creditor</legend>

	<cfinput type="hidden" name="idDebtHolder" value="#URL.idDebtHolder#">
	<ul>
		<li><label for="ref">Ref</label><cfinput name="ref" type="text" value="#thisHolder.ref#"></li>	
		<li><label for="name">Name</label><cfinput name="name" type="text" value="#thisHolder.name#" required="yes" message="The field Name is required" placeholder="Required" autosuggest="cfc:components.debtHolder.findDebthHolderByName({cfautosuggestvalue})" autosuggestminlength="1" maxresultsdisplayed="10" onBlur="changeState();"><br><br></li>
		<li><label for="address">Address</label><cfinput name="address" type="text" value="#thisHolder.address#" bind="cfc:components.debtHolder.findDebHolderAddressByName({name})"></li>
		<li><label for="city">City</label><cfinput name="city" type="text" value="#thisHolder.city#" bind="cfc:components.debtHolder.findDebHolderCityByName({name})"></li>
		<li><label for="idState">State</label>
		<cfinput type="hidden" name="idStateValue" bind="cfc:components.debtHolder.findDebHolderIdStateByName({name})">
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" selected="#thisHolder.idState#">
			<option value="">Select State:</option> 
		</cfselect></li>
		<li><label for="zip">Zip</label><cfinput name="zip" type="text" value="#thisHolder.zip#" bind="cfc:components.debtHolder.findDebHolderZipByName({name})"></li>
		<li><label for="accountNumber">Account Number</label><cfinput name="accountNumber" type="text" value="#thisHolder.accountNumber#" required="yes" message="The field Account Number is required" placeholder="Required" ></li>
		<li class="inputCurrency"><label for="balance">Balance</label><cfinput name="balance" type="text" value="#thisHolder.balance#" required="yes" validate="numeric" message="The field Balance is required with a numeric value" placeholder="Required" ></li>
	</ul>
</fieldset>

<fieldset class="col2">
	<legend>Type of Debt</legend>
	<ul>
		<cfif thisHolder.typeOfDebt EQ "DEBT">
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="DEBT" checked="True"> Debt</label></li>
		<cfelse>
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="DEBT"> Debt</label></li>
		</cfif>
		
		<cfif thisHolder.typeOfDebt EQ "BANKRUPTCY">
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="BANKRUPTCY" checked="True"> Bankruptcy</label></li>
		<cfelse>
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="BANKRUPTCY"> Bankruptcy</label></li>
		</cfif>

		<cfif thisHolder.typeOfDebt EQ "PRIVATE_STUDENT_LOANS">
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="PRIVATE_STUDENT_LOANS" checked="True"> Private student loans</label></li>
		<cfelse>
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="PRIVATE_STUDENT_LOANS"> Private student loans</label></li>
		</cfif>


<!---
		<cfif thisHolder.typeOfDebt EQ "MORTGAGELM">
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGELM" checked="True"> Mortgage - Loan Modification</label></li>
		<cfelse>
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGELM"> Mortgage - Loan Modification</label></li>
		</cfif>
		
		<cfif thisHolder.typeOfDebt EQ "MORTGAGEFD">
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGEFD" checked="True"> Mortgage - Foreclosure defense</label></li>
		<cfelse>
			<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGEFD"> Mortgage - Foreclosure defense</label></li>
		</cfif>
--->
		


		<li class="inputNotes"><label for="notes">Notes</label> <cftextarea name="notes" rows="7" cols="30"><cfoutput>#thisHolder.notes#</cfoutput></cftextarea></li>
	</ul>
</fieldset>



<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save changes">
</fieldset>

</cfform>