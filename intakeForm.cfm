<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Intake') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<!----- Functionality ---->

<cfif isDefined("FORM.itkTotalDeb")>
	<cfinvoke component="components.intake" method="updateIntake" argumentCollection="#FORM#">
</cfif>

<cfinvoke component="components.file" method="getFileById" returnVariable="thisIntake">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<cfinvoke  component="components.intake" method="getTotalDebt" returnVariable="thisTotalDebt" />

<cfinvoke  component="components.intake" method="getAffiliatePercent" returnVariable="thisAffiliatePercent">
	<cfinvokeargument name="affiliateCompanyId" value="#thisIntake.affiliateCompanyId#">
</cfinvoke>

<cfinvoke component="components.intake" method="seachStudentLoanDebt" returnVariable="privateStudentLoan">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<!------ Content ----->
<cfoutput>
<script type="text/javascript" src="#APPLICATION.template_path#js/validate/forms/mkIntake.js"></script>
</cfoutput>

<cfform name="intakeForm">

<cfinput type="hidden" name="thisAffiliatePercent" value="#thisAffiliatePercent#" />
<cfinput type="hidden" name="fieldTotalDebt" value="#thisTotalDebt#" />

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div>         


<fieldset class="action-buttons">
	<cfinput type="submit" name="saveIntake" id="saveIntake1" value="Save all changes" >
</fieldset>


<fieldset>
	<legend>Debt</legend>
	<ul class="col1">
		
		<cfif privateStudentLoan>
			<li>
				<label for="studentLoanPercent">Student Loan Debt Percent:</label>
				<cfselect name="studentLoanPercent">
					<option value="1" <cfif NumberFormat(thisIntake.studentLoanPercent, "9.99") EQ 1>selected="selected"</cfif>>None</option>
					<option value="0.33" <cfif NumberFormat(thisIntake.studentLoanPercent, "9.99") EQ 0.33>selected="selected"</cfif>>33%</option>
					<option value="0.40" <cfif NumberFormat(thisIntake.studentLoanPercent, "9.99") EQ 0.40>selected="selected"</cfif>>40%</option>
					<option value="0.50" <cfif NumberFormat(thisIntake.studentLoanPercent, "9.99") EQ 0.50>selected="selected"</cfif>>50%</option>
				</cfselect>
			</li>
		<hr />
		<cfelse>
			<cfinput type="hidden" name="studentLoanPercent" value="1">
		</cfif>
		
		<li class="inputCurrency">
			<label for="itkTotalDeb">Total Debt:</label> 
			<cfinput name="itkTotalDeb" type="text" value="#thisIntake.itkTotalDeb#" class="number">
		</li>

		<li class="inputCurrency">
			<label for="itkDownPayment">Down Payment:</label> 
			<cfinput name="itkDownPayment" type="text" value="#thisIntake.itkDownPayment#" class="number">
		</li>

		<li class="inputCurrency">
			<label for="itkLitigationFee">Litigation fee:</label> 
			<cfinput name="itkLitigationFee" type="text" value="59.99" class="number" disabled="disabled">
		</li>

		<li class="inputCurrency">
			<label for="itkMonthlyProcessingFee">Monthly Processing Fee:</label> 
			<cfinput name="itkMonthlyProcessingFee" type="text" value="6.00" class="number" disabled="disabled">
		</li>
		
		<li>
			<label for="itkProgramLenght">Program Lenght:</label> 
			<cfif thisIntake.itkProgramLenght EQ "" OR thisIntake.itkProgramLenght EQ 0>
				<cfset thisIntake.itkProgramLenght = 24>
			</cfif>	
			<!---
			<cfselect name="itkProgramLenght">
				<option value="3" <cfif thisIntake.itkProgramLenght EQ 3>selected="selected"</cfif>>3</option>
				<option value="6" <cfif thisIntake.itkProgramLenght EQ 6>selected="selected"</cfif>>6</option>
				<option value="9" <cfif thisIntake.itkProgramLenght EQ 9>selected="selected"</cfif>>9</option>
				<option value="12" <cfif thisIntake.itkProgramLenght EQ 12>selected="selected"</cfif>>12</option>
				<option value="15" <cfif thisIntake.itkProgramLenght EQ 15>selected="selected"</cfif>>15</option>
				<option value="18" <cfif thisIntake.itkProgramLenght EQ 18>selected="selected"</cfif>>18</option>
				<option value="21" <cfif thisIntake.itkProgramLenght EQ 21>selected="selected"</cfif>>21</option>
				<option value="24" <cfif thisIntake.itkProgramLenght EQ 24>selected="selected"</cfif>>24</option>
				<option value="27" <cfif thisIntake.itkProgramLenght EQ 27>selected="selected"</cfif>>27</option>
				<option value="30" <cfif thisIntake.itkProgramLenght EQ 30>selected="selected"</cfif>>30</option>
				<option value="33" <cfif thisIntake.itkProgramLenght EQ 33>selected="selected"</cfif>>33</option>
				<option value="36" <cfif thisIntake.itkProgramLenght EQ 36>selected="selected"</cfif>>36</option>
			</cfselect>
			--->
			<cfinput name="itkProgramLenght" type="text" value="#thisIntake.itkProgramLenght#" class="number" validate="numeric" message="Program lenght must be a number">
		</li>
		
		<li class="inputCurrency">
			<label for="itkTotalRetainerFee">Total Retainer Fee:</label> 
			<cfinput name="itkTotalRetainerFee" type="text" value="#thisIntake.itkTotalRetainerFee#" class="number">
		</li>
		
		<li class="inputCurrency">
			<label for="itkMonthlyRetainer">Monthly Retainer:</label> 
			<cfinput name="itkMonthlyRetainer" type="text" value="#thisIntake.itkMonthlyRetainer#" class="number">
		</li>

		<li class="inputCurrency">
			<label for="itkMontlyPayment">Monthly Payment:</label> 
			<cfinput name="itkMontlyPayment" type="text" value="#thisIntake.itkMontlyPayment#" class="number">
		</li>
		
	</ul>
	
	<ul class="col2">
		
		<li class="inputDate">
			<label for="itkFirstInstallmentDate">First Installment Date:</label> 
			<cfinput name="itkFirstInstallmentDate" type="datefield" value="#thisIntake.itkFirstInstallmentDate#" mask="mm/dd/yyyy"  validate="date" message="First installment date should be 'mm/dd/yyyy'">
		</li>
		
		<div class="clearfix"></div>
		
		<li>
			<label for="itkAccountHolderName">Account Holder Name:</label> 
			<cfinput name="itkAccountHolderName" value="#thisIntake.itkAccountHolderName#" type="text">
		</li>
		
		<li>
			<label for="itkRoutingNumber">Routing Number:</label> 
			<cfinput name="itkRoutingNumber" type="text" value="#thisIntake.itkRoutingNumber#">
		</li>

		<li>
			<label for="itkBankName">Bank Name:</label> 
			<cfinput 
				name="itkBankName" 
				type="text" 
				value="#thisIntake.itkBankName#" 
				bind="cfc:components.intake.findBankNameByRoutingNumber({itkRoutingNumber})">
		</li>
				
		<li>
			<label for="itkAccountNumber">Account Number:</label> 
			<cfinput name="itkAccountNumber" type="text" value="#thisIntake.itkAccountNumber#">
		</li>

		<li class="inputDate">
			<label for="itkRecurrentPaymentDate">Recurrent Payment Date:</label> 
			<cfinput name="itkRecurrentPaymentDate" type="datefield" value="#thisIntake.itkRecurrentPaymentDate#" mask="mm/dd/yyyy"  validate="date" message="Recurrent Payment Date should be 'mm/dd/yyyy'">
		</li>
		
		<div class="clearfix"></div>
				
	</ul>
	
</fieldset>

<fieldset class="action-buttons">
	<input type="button" onclick="calculateIntakeValues();" value="Recalculate Debt">
</fieldset>

</cfform>

<cfoutput>
<script type="text/javascript">
	function calculateIntakeValues(){
		
		
		var totalDeb = document.getElementById('fieldTotalDebt').value;
		var downPayment = document.getElementById('itkDownPayment').value;		
		var programLenght = document.getElementById('itkProgramLenght').value;
		var totalRetainerFee;
		var monthlyRetainer;
		var litigationFee = document.getElementById('itkLitigationFee').value;
		var monthlyProcessingFee = document.getElementById('itkMonthlyProcessingFee').value;
		var monthlyPayment;
		
		
		/*
			Al ser un credito de estudiante si esta seleccionado algun porcentaje, este reemplaza el porcentaje del afiliado
		*/
		var privateStudentLoan = document.getElementById('studentLoanPercent').value;
		
		var thisAffiliatePercent = document.getElementById('thisAffiliatePercent').value;
		thisAffiliatePercent = thisAffiliatePercent / 100
				
		if (privateStudentLoan != 1){
			thisAffiliatePercent = privateStudentLoan;
		} 
		
		//Calculation
		totalRetainerFee = totalDeb*thisAffiliatePercent;
		totalRetainerFee = totalRetainerFee.toFixed(2);

		monthlyRetainer = (totalRetainerFee-downPayment)/programLenght;
		monthlyRetainer = monthlyRetainer.toFixed(2);
		
		monthlyPayment = Number(monthlyRetainer)+Number(litigationFee)+Number(monthlyProcessingFee);
		monthlyPayment = monthlyPayment.toFixed(2);
		
		
		//Show result
		document.getElementById('itkTotalDeb').value = totalDeb;
		document.getElementById('itkTotalRetainerFee').value = totalRetainerFee;
		document.getElementById('itkMonthlyRetainer').value = monthlyRetainer;
		document.getElementById('itkMontlyPayment').value = monthlyPayment;
		
	}
</script>
</cfoutput>

<cfinclude template="template/footer.cfm">