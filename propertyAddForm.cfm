<cfif isDefined("FORM.address")>
	<cfinvoke component="components.properties" method="addProperty" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('propertiesGrid', true);
	</script>
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfform name="addPropertyForm">

<fieldset>
	<legend>Property </legend>
	<ul class="col1">
		<li><label for="propertyInForeclosure">Property in foreclosure?</label>
	        <cfselect name="propertyInForeclosure" >
        	    <option value="0" selected="selected">No</option>
            	<option value="1">Yes</option>
          	</cfselect>
          	<div class="clearfix"></div>
        </li>
		<li class="inputDate">
			<label for="saleDate">Sale Date (if scheduled)</label>
			<cfinput type="datefield" class="" name="saleDate" value="" validate="date" message="Sale date should be 'mm/dd/yyyy'">
			<div class="clearfix"></div>
		</li>
        <li class=""><label for="address">Address</label><cfinput type="text" name="address" value=""></li>
    </ul>

	<ul class="col2">
        <li class=""><label for="city">City</label><cfinput type="text" name="city" value=""></li>
        <li><label for="idState">State</label>
            <cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" required="yes" message="You must select the state">
                <option value="">- Select State -</option> 
            </cfselect>
        </li>
        <li class=""><label for="zip">Zip</label><cfinput type="text" name="zip" value=""></li>
	</ul>
</fieldset>

<div class="clearfix"></div>

<br>

<fieldset class="">	
	<ul class="fullwidth">
        <li class=""><label for="loanModificationWithLender">Have You Every Applied For A Loan Modification With Your Lender (Whether Verbally or in Writing)?</label>
        	<cfselect name="loanModificationWithLender" >
        	    <option value="0" selected="selected">No</option>
            	<option value="1">Yes</option>
          	</cfselect>
        </li>
        <li class="inputDate"><label for="dateForLoanMod">What Date Did You Apply For a Loan Modification?</label><cfinput type="datefield" class="" name="dateForLoanMod" value="" validate="date" message="Loan modification date should be 'mm/dd/yyyy'">
        	<div class="clearfix"></div>
        </li>  
        <li class=""><label for="governmentHAMP">Have You Ever Defaulted on a Government HAMP (MHA) Loan Modification?</label>
        	<cfselect name="governmentHAMP" >
        	    <option value="0" selected="selected">No</option>
            	<option value="1">Yes</option>
          	</cfselect>
        </li> 
        <li class=""><label for="repaymentHAMP">Have You Ever Defaulted on a Re-Payment Plan, HAMP or In-House Loan Modification? </label>
        	<cfselect name="repaymentHAMP" >
        	    <option value="0" selected="selected">No</option>
            	<option value="1">Yes</option>
          	</cfselect>
        </li>
        <li><label for="monthlyRetainer">Monthly retainer</label><cfinput type="text" name="monthlyRetainer" value="" required="yes"  validate="numeric" message="Monthly retainer is required and must be a numeric"></li>
	</ul>
</fieldset>

<br>

<div class="clearfix"></div>

<fieldset class="col1">
	<legend>First Mortgage </legend>
	<ul class="">
		<li><label for="firstMortgageCompany">Mortgage Company</label><cfinput type="text" name="firstMortgageCompany" value=""></li>
        <li><label for="firstLoanNumber">Loan number</label><cfinput type="text" name="firstLoanNumber" value=""></li>
        <li><label for="firstBalance">Principal Balance Owed</label><cfinput type="text" name="firstBalance" value=""  validate="numeric" message="Balance must be a numeric"></li>
        <li><label for="firstMontlyPayment">Monthly Payment </label><cfinput type="text" name="firstMontlyPayment" value=""  validate="numeric" message="Payment must be a numeric"></li>
        <li><label for="firstInterestRate">Interest Rate </label><cfinput type="text" name="firstInterestRate" value="" validate="numeric" message="Rate must be a numeric"></li>
        <li><label for="firstTaxes">T/I </label><cfinput type="text" name="firstTaxes" value=""  validate="numeric" message="T/I must be a numeric"></li>
        <li><label for="firstPaymentsBehind">Number of Payments Behind</label><cfinput type="text" name="firstPaymentsBehind" value="" validate="numeric" message="Payments behind must be a numeric"></li>
		<li class="inputDate"><label for="firstDateLoanOpened">Date loan opened </label><cfinput type="datefield" name="firstDateLoanOpened" value="" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
		<li class="inputDate"><label for="firstDateLastPayment">Date of Last payment </label><cfinput type="datefield" name="firstDateLastPayment" value="" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>

</fieldset>


<fieldset class="col2">
	<legend>Second Mortgage </legend>
	<ul class="">
		<li><label for="secondMortgageCompany">Mortgage Company</label><cfinput type="text" name="secondMortgageCompany" value=""></li>
        <li><label for="secondLoanNumber">Loan number</label><cfinput type="text" name="secondLoanNumber" value="" ></li>
        <li><label for="secondBalance">Principal Balance Owed</label><cfinput type="text" name="secondBalance" value=""  validate="numeric" message="Balance must be a numeric"></li>
        <li><label for="secondMontlyPayment">Monthly Payment </label><cfinput type="text" name="secondMontlyPayment" value=""  validate="numeric" message="Payment must be a numeric"></li>
        <li><label for="secondInterestRate">Interest Rate </label><cfinput type="text" name="secondInterestRate" value="" validate="numeric" message="Rate must be a numeric"></li>
        <li><label for="secondTaxes">T/I </label><cfinput type="text" name="secondTaxes" value="" validate="numeric" message="T/I must be a numeric"></li>
        <li><label for="secondPaymentsBehind">Number of Payments Behind</label><cfinput type="text" name="secondPaymentsBehind" value="" validate="numeric" message="Payments behind must be a numeric"></li>
		<li class="inputDate"><label for="secondDateLoanOpened">Date loan opened </label><cfinput type="datefield" name="secondDateLoanOpened" value="" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
		<li class="inputDate"><label for="secondDateLastPayment">Date of Last payment </label><cfinput type="datefield" name="secondDateLastPayment" value="" validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>
</cfform>