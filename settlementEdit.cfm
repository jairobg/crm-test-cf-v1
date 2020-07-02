<cfif isDefined("FORM.financialInstitution")>
	<cfinvoke component="components.settlement" method="editSettlement" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('settlementGrid', true);
		<cfoutput>
		ColdFusion.Window.destroy('editSettlement#FORM.idSettlement#',true);
		</cfoutput>
	</script>
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">
<cfinvoke component="components.debtHolder" method="getHolderForSettlement" returnVariable="getHolderForSettlement">

<cfinvoke component="components.settlement" method="getSettlementById" returnVariable="thisSettlementQuery">
	<cfinvokeargument name="idSettlement" value="#URL.idSettlement#">
</cfinvoke>

<cfform name="editSettlementForm">
<cfinput type="hidden" name="idSettlement" value="#URL.idSettlement#">
<fieldset>
	<legend>Settlements</legend>

	<ul>
		<li><label for="idDebtHolder">Related Account</label>
			<cfselect name="idDebtHolder" query="getHolderForSettlement" display="fullName" value="idDebtHolder" queryPosition="below" selected="#thisSettlementQuery.idDebtHolder#">
				<option value="0"> -Select Holder- </option>
			</cfselect>
		</li>
		<li><label for="idDebtHolder">Accept</label>
			<cfselect name="accept">
				<option value="0"<cfif thisSettlementQuery.accept EQ 0> selected="selected"</cfif>>No</option>
				<option value="1"<cfif thisSettlementQuery.accept EQ 1> selected="selected"</cfif>>Yes</option>
			</cfselect>
		</li>
	</ul>

	<ul class="col1">
		<li><label for="financialInstitution">Financial Institution</label><cfinput type="text" name="financialInstitution" value="#thisSettlementQuery.financialInstitution#" required="yes" message="The field Financial Institution is required" placeholder="Required"></li>
		<li><label for="routingNumber">Routing Number</label><cfinput type="text" name="routingNumber" value="#thisSettlementQuery.routingNumber#"></li>
		<!---
		<li class="inputCurrency"><label for="currentBalance">Current Balance</label><cfinput type="text" name="currentBalance" value="#thisSettlementQuery.currentBalance#" validate="numeric" message="Current balance field must contain only numeric characters like 1200.00"></li>
		--->
		
		<li><label for="offerFor">Settlement offer for</label><cfinput type="text" name="offerFor" value="#thisSettlementQuery.offerFor#"></li>
		<li><label for="offerFrom">From</label><cfinput type="text" name="offerFrom" value="#thisSettlementQuery.offerFrom#"></li>
		<li class="inputCurrency"><label for="offerAmount">Settlement offer Amount</label><cfinput type="text" name="offerAmount" value="#thisSettlementQuery.offerAmount#" validate="numeric" message="Offer amount field must contain only numeric characters like 1200.00"></li>

	</ul>

	<ul class="col2">
		<li><label for="idState">State</label>
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" required="Yes" message="The State field is required" selected="#thisSettlementQuery.idState#">
			<option value=""> -Select State- </option>
		</cfselect>
		</li>
		<li><label for="address">Address</label><cfinput type="text" name="address" value="#thisSettlementQuery.address#"></li>
		<li><label for="city">City</label><cfinput type="text" name="city" value="#thisSettlementQuery.city#"></li>
		<li><label for="zip">Zip</label><cfinput type="text" name="zip" value="#thisSettlementQuery.zip#"></li>	

		<li><label for="offerPercentage">% of offer</label><cfinput type="text" name="offerPercentage" value="#thisSettlementQuery.offerPercentage#"></li>	
		<li><label for="dateOfferLetter">Date of letter/offer:</label><cfinput type="datefield" name="dateOfferLetter" value="#thisSettlementQuery.dateOfferLetter#"></li><br><br>
		<li><label for="dateOfferDue">Date offer due:</label><cfinput type="datefield" name="dateOfferDue" value="#thisSettlementQuery.dateOfferDue#"></li><br><br>
		
		
	</ul>
</fieldset>
<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>