<cfparam name="addHolderMessage" default="">

<cfif isDefined("FORM.name")>
	<cfinvoke component="components.debtHolder" method="addHolder" returnVariable="addHolderMessage" argumentCollection="#FORM#">
	<cfif addHolderMessage EQ "">
		<script>
			ColdFusion.Grid.refresh('creditorsGrid', true);
			ColdFusion.Window.destroy('addCreditor',true);
		</script>
	</cfif>
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<div><cfoutput>#addHolderMessage#</cfoutput></div>

<cfform name="creditorsAddForm">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div> 

<cfinput type="hidden" name="type" value="CREDITOR">
<fieldset class="col1">
	<legend>Add Creditor</legend>
	<ul>
		<li><label for="ref">Ref</label><cfinput name="ref" type="text" value=""></li>	
		<li><label for="name">Name</label><cfinput name="name" type="text" value="" required="yes" message="The field Name is required" placeholder="Required" autosuggest="cfc:components.debtHolder.findDebthHolderByName({cfautosuggestvalue})" autosuggestminlength="1" maxresultsdisplayed="10" onBlur="changeState();"><br><br></li>
		<li><label for="address">Address</label><cfinput name="address" type="text" value="" bind="cfc:components.debtHolder.findDebHolderAddressByName({name})"></li>
		<li><label for="city">City</label><cfinput name="city" type="text" value="" bind="cfc:components.debtHolder.findDebHolderCityByName({name})"></li>
		<li><label for="idState">State</label>
		<cfinput type="hidden" name="idStateValue" bind="cfc:components.debtHolder.findDebHolderIdStateByName({name})">
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" >
			<option value=""> -Select State- </option> 
		</cfselect></li>
		<li><label for="zip">Zip</label><cfinput name="zip" type="text" value="" bind="cfc:components.debtHolder.findDebHolderZipByName({name})"></li>
		<li><label for="accountNumber">Account Number</label><cfinput name="accountNumber" type="text" value="" required="yes" message="The field Account Number is required" placeholder="Required" ></li>
		<li class="inputCurrency"><label for="balance">Balance</label><cfinput name="balance" type="text" value="" required="yes" validate="numeric" message="The field Balance is required with a numeric value" placeholder="Required" ></li>
	</ul>
</fieldset>

<fieldset class="col2">
	<legend>Type of Debt</legend>
	<ul>
		<li class="inputRadio">
			<label><cfinput type="radio" name="typeOfDebt" value="DEBT" checked="True"> Debt</label>
		</li>
		
		<li class="inputRadio">
			<label><cfinput type="radio" name="typeOfDebt" value="BANKRUPTCY"> Bankruptcy</label>
		</li>

		<li class="inputRadio">
			<label><cfinput type="radio" name="typeOfDebt" value="PRIVATE_STUDENT_LOANS"> Private student loans</label>
		</li>

<!---
		<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGELM"> Mortgage - Loan Modification</label></li>
		<li class="inputRadio"><label><cfinput type="radio" name="typeOfDebt" value="MORTGAGEFD"> Mortgage - Foreclosure defense</label></li>
--->
		<li class="inputNotes"><label for="notes">Notes</label><cftextarea name="notes" rows="4" cols="25"></cftextarea></li>
	</ul>
</fieldset>


<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>
</cfform>