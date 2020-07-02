<cfif isDefined("FORM.address")>
	<cfinvoke component="components.properties" method="editProperty" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('propertiesGrid', true);
	</script>
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">
<cfinvoke component="components.properties" method="getPropertyById" returnVariable="thisProperty">
	<cfinvokeargument name="idProperty" value="#URL.idProperty#">
</cfinvoke>

<cfform name="editPropertyForm">
<cfinput type="hidden" name="idProperty" value="#thisProperty.idProperty#" >

<fieldset>
	<legend>Property </legend>
	<ul class="col1">
		<li><label for="propertyInForeclosure">Property in foreclosure?</label>
	        <cfselect name="propertyInForeclosure" >
        	    <option value="0" <cfif thisProperty.propertyInForeclosure EQ 0>selected="selected"</cfif>>No</option>
            	<option value="1" <cfif thisProperty.propertyInForeclosure EQ 1>selected="selected"</cfif>>Yes</option>
          	</cfselect>
          	<div class="clearfix"></div>
        </li>
		<li class="inputDate"><label for="saleDate">Sale Date (if scheduled)</label><cfinput type="datefield" class="date" name="saleDate" value="#thisProperty.saleDate#" validate="date" message="Sale date should be 'mm/dd/yyyy'">
			<div class="clearfix"></div>
		</li>
        <li class=""><label for="address">Address</label><cfinput type="text" name="address" value="#thisProperty.address#"></li>
	</ul>
	
	<ul class="col2">
        <li class=""><label for="city">City</label><cfinput type="text" name="city" value="#thisProperty.city#"></li>
        <li><label for="idState">State</label>
            <cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" required="yes" selected="#thisProperty.idState#" message="You must select the state">
                <option value="">- Select State -</option> 
            </cfselect>
        </li>
        <li class=""><label for="zip">Zip</label><cfinput type="text" name="zip" value="#thisProperty.zip#"></li>
        
    </ul>


<div class="clearfix"></div>

<br>
        
    <ul class="fullwidth">
        <li class=""><label for="loanModificationWithLender">Have You Every Applied For A Loan Modification With Your Lender (Whether Verbally or in Writing)?</label>
        	<cfselect name="loanModificationWithLender" >
        	    <option value="0" <cfif thisProperty.loanModificationWithLender EQ 0>selected="selected"</cfif>>No</option>
            	<option value="1" <cfif thisProperty.loanModificationWithLender EQ 1>selected="selected"</cfif>>Yes</option>
          	</cfselect>
        </li>
        <li class="inputDate"><label for="dateForLoanMod">What Date Did You Apply For a Loan Modification?</label><cfinput type="datefield" class="date" name="dateForLoanMod" value="#thisProperty.dateForLoanMod#" validate="date" message="Loan modification date should be 'mm/dd/yyyy'">
        	<div class="clearfix"></div>
        </li>  
        <li class=""><label for="governmentHAMP">Have You Ever Defaulted on a Government HAMP (MHA) Loan Modification?</label>
        	<cfselect name="governmentHAMP" >
        	    <option value="0" <cfif thisProperty.governmentHAMP EQ 0>selected="selected"</cfif>>No</option>
            	<option value="1" <cfif thisProperty.governmentHAMP EQ 1>selected="selected"</cfif>>Yes</option>
          	</cfselect>
        </li> 
        <li class=""><label for="repaymentHAMP">Have You Ever Defaulted on a Re-Payment Plan, HAMP or In-House Loan Modification? </label>
        	<cfselect name="repaymentHAMP" >
        	    <option value="0" <cfif thisProperty.repaymentHAMP EQ 0>selected="selected"</cfif>>No</option>
            	<option value="1" <cfif thisProperty.repaymentHAMP EQ 1>selected="selected"</cfif>>Yes</option>
          	</cfselect>
        </li>
        <li><label for="monthlyRetainer">Monthly retainer</label><cfinput type="text" name="monthlyRetainer" value="#thisProperty.monthlyRetainer#" required="yes"  validate="numeric" message="Monthly retainer is required and must be a numeric"></li>
	</ul>

</fieldset>

<br>

<div class="clearfix"></div>

<fieldset class="col1">
	<legend>First Mortgage </legend>
	<ul class="">
		<li><label for="firstMortgageCompany">Mortgage Company</label><cfinput type="text" name="firstMortgageCompany" value="#thisProperty.firstMortgageCompany#"></li>
        <li><label for="firstLoanNumber">Loan number</label><cfinput type="text" name="firstLoanNumber" value="#thisProperty.firstLoanNumber#"></li>
        <li><label for="firstBalance">Principal Balance Owed</label><cfinput type="text" name="firstBalance" value="#thisProperty.firstBalance#" validate="numeric" message="Balance must be a numeric"></li>
        <li><label for="firstMontlyPayment">Monthly Payment </label><cfinput type="text" name="firstMontlyPayment" value="#thisProperty.firstMontlyPayment#"  validate="numeric" message="Payment must be a numeric"></li>
        <li><label for="firstInterestRate">Interest Rate </label><cfinput type="text" name="firstInterestRate" value="#thisProperty.firstInterestRate#" validate="numeric" message="Rate must be a numeric"></li>
        <li><label for="firstTaxes">T/I </label><cfinput type="text" name="firstTaxes" value="#thisProperty.firstTaxes#" validate="numeric" message="T/I must be a numeric"></li>
        <li><label for="firstPaymentsBehind">Number of Payments Behind</label><cfinput type="text" name="firstPaymentsBehind" value="#thisProperty.firstPaymentsBehind#" validate="numeric" message="Payments behind must be a numeric"></li>
		<li class="inputDate"><label for="firstDateLoanOpened">Date loan opened </label><cfinput type="datefield" name="firstDateLoanOpened" value="#thisProperty.firstDateLoanOpened#" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
		<li class="inputDate"><label for="firstDateLastPayment">Date of Last payment </label><cfinput type="datefield" name="firstDateLastPayment" value="#thisProperty.firstDateLastPayment#" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>

</fieldset>


<fieldset class="col2">
	<legend>Second Mortgage </legend>
	<ul class="">
		<li><label for="secondMortgageCompany">Mortgage Company</label><cfinput type="text" name="secondMortgageCompany" value="#thisProperty.secondMortgageCompany#"></li>
        <li><label for="secondLoanNumber">Loan number</label><cfinput type="text" name="secondLoanNumber" value="#thisProperty.secondLoanNumber#"></li>
        <li><label for="secondBalance">Principal Balance Owed</label><cfinput type="text" name="secondBalance" value="#thisProperty.secondBalance#" validate="numeric" message="Balance must be a numeric"></li>
        <li><label for="secondMontlyPayment">Monthly Payment </label><cfinput type="text" name="secondMontlyPayment" value="#thisProperty.secondMontlyPayment#"  validate="numeric" message="Payment must be a numeric"></li>
        <li><label for="secondInterestRate">Interest Rate </label><cfinput type="text" name="secondInterestRate" value="#thisProperty.secondInterestRate#" validate="numeric" message="Rate must be a numeric"></li>
        <li><label for="secondTaxes">T/I </label><cfinput type="text" name="secondTaxes" value="#thisProperty.secondTaxes#" validate="numeric" message="T/I must be a numeric"></li>
        <li><label for="secondPaymentsBehind">Number of Payments Behind</label><cfinput type="text" name="secondPaymentsBehind" value="#thisProperty.secondPaymentsBehind#" validate="numeric" message="Payments behind must be a numeric"></li>
		<li class="inputDate"><label for="secondDateLoanOpened">Date loan opened </label><cfinput type="datefield" name="secondDateLoanOpened" value="#thisProperty.secondDateLoanOpened#" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
		<li class="inputDate"><label for="secondDateLastPayment">Date of Last payment </label><cfinput type="datefield" name="secondDateLastPayment" value="#thisProperty.secondDateLastPayment#" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save changes">
</fieldset>
</cfform>