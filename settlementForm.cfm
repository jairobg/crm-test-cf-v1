<cfif isDefined("FORM.financialInstitution")>
	<cfinvoke component="components.settlement" method="addSettlement" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('settlementGrid', true);
	</script>
</cfif>

<cfinvoke component="components.debtHolder" method="getHolderForSettlement" returnVariable="debtHoldersQuery">
<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfform name="addSetlementForm">
<fieldset>
	<legend>Settlements</legend>
	<ul>
		<li><label for="idDebtHolder">Related Account</label>
			<cfselect name="idDebtHolder" query="debtHoldersQuery" display="fullName" value="idDebtHolder" queryPosition="below">
				<option value="0"> -Select Holder- </option>
			</cfselect>
		</li>
		<li><label for="idDebtHolder">Accept</label>
			<cfselect name="accept">
				<option value="0">No</option>
				<option value="1">Yes</option>
			</cfselect>
		</li>
	</ul>
	
	<ul class="col1">
		<li><label for="financialInstitution">Financial Institution</label><cfinput type="text" name="financialInstitution" value="" required="yes" message="The field Financial Institution is required" placeholder="Required"></li>
		<li><label for="routingNumber">Routing Number</label><cfinput type="text" name="routingNumber" value=""></li>
		<!---
		<li class="inputCurrency"><label for="currentBalance">Current Balance</label><cfinput type="text" name="currentBalance" value="" validate="numeric" message="Current balance field must contain only numeric characters like 1200.00"></li>
		--->
		
		<li><label for="offerFor">Settlement offer for</label><cfinput type="text" name="offerFor" value=""></li>
		<li><label for="offerFrom">From</label><cfinput type="text" name="offerFrom" value=""></li>
		<li class="inputCurrency"><label for="offerAmount">Settlement offer Amount</label><cfinput type="text" name="offerAmount" value="" validate="numeric" message="Offer amount field must contain only numeric characters like 1200.00"></li>
		
		
	</ul>
	<ul class="col2">
		<li><label for="idState">State</label>
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" required="Yes" message="The State field is required">
			<option value=""> -Select State- </option>
		</cfselect>
		</li>
		<li><label for="address">Address</label><cfinput type="text" name="address" value=""></li>
		<li><label for="city">City</label><cfinput type="text" name="city" value=""></li>
		<li><label for="zip">Zip</label><cfinput type="text" name="zip" value=""></li>	

		<li><label for="offerPercentage">% of offer</label><cfinput type="text" name="offerPercentage" value=""></li>	
		<li><label for="dateOfferLetter">Date of letter/offer:</label><cfinput type="datefield" name="dateOfferLetter" value=""></li><br><br>	
		<li><label for="dateOfferDue">Date offer due:</label><cfinput type="datefield" name="dateOfferDue" value=""></li><br><br>


	</ul>
</fieldset>
<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>
</cfform>