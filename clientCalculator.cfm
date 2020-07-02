<cfform name="intakeForm">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div>         



<fieldset>
	<legend>Debt</legend>
	<ul class="col1">
		
		<li class="inputCurrency">
			<label for="calTotalDeb">Total Debt:</label> 
			<cfinput name="calTotalDeb" type="text" value="" class="number">
		</li>

		<li class="inputCurrency">
			<label for="calDownPayment">Down Payment:</label> 
			<cfinput name="calDownPayment" type="text" value="" class="number">
		</li>

		<li class="inputCurrency">
			<label for="calLitigationFee">Litigation fee:</label> 
			<cfinput name="calLitigationFee" type="text" value="59.99" class="number" disabled="disabled">
		</li>

		<li class="inputCurrency">
			<label for="calMonthlyProcessingFee">Monthly Processing Fee:</label> 
			<cfinput name="calMonthlyProcessingFee" type="text" value="5.00" class="number" disabled="disabled">
		</li>
		
		<li>
			<label for="calProgramLenght">Program Lenght:</label> 
			<cfselect name="calProgramLenght">
				<option value="3">3</option>
				<option value="6">6</option>
				<option value="9">9</option>
				<option value="12">12</option>
				<option value="15">15</option>
				<option value="18">18</option>
				<option value="21">21</option>
				<option value="24" selected="selected">24</option>
				<option value="27">27</option>
				<option value="30">30</option>
				<option value="33">33</option>
				<option value="36">36</option>
			</cfselect>
		</li>
		
	</ul>


	<ul class="col2">


		<li class="inputCurrency">
			<label for="calTotalRetainerFee">Total Retainer Fee:</label> 
			<cfinput name="calTotalRetainerFee" type="text" value="" class="number">
		</li>
		
		<li class="inputCurrency">
			<label for="calMonthlyRetainer">Monthly Retainer:</label> 
			<cfinput name="calMonthlyRetainer" type="text" value="" class="number">
		</li>

		<li class="inputCurrency">
			<label for="calMonthlyPayment">Monthly Payment:</label> 
			<cfinput name="calMonthlyPayment" type="text" value="" class="number">
		</li>
		

	</ul>
</fieldset>

<fieldset class="action-buttons">
	<input type="button" onclick="calculatorIntakeValues();" value="Recalculate Debt">
</fieldset>



</cfform>