<cfinclude template="template/header.cfm">

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


	function deleteLetter(idLetter){
		ColdFusion.Window.create(
		'deleteLetter'+idLetter,
		'Edit',
		'letterDelete.cfm?idLetter='+idLetter,
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


	function generateLetter(letterType){
		if (letterType == 'allLetters'){
			ColdFusion.Window.create(
			'generateAllLetters',
			'Generate Letters',
			'generateAllLettersWindow.cfm',
			{
			 	center:true,
			    modal:true,
				draggable:false,
				resizable:false,
				initshow:true,
				width: 490,
				height: 420
			}
			);
		}
		else{
			ColdFusion.Window.create(
			'generateLetter'+letterType,
			'Generate Letter',
			'generateLettersWindow.cfm?letterType='+letterType,
			{
			 	center:true,
			    modal:true,
				draggable:false,
				resizable:false,
				initshow:true,
				width: 490,
				height: 380
			}
			);
		}
	}

	
</script>

<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="debtHolderQuery">

<cfform name="lettersForm">
	
	<fieldset>
		<legend>Letters</legend>
		<ul class="checklist">
			<li><label for="letterType">Generate letter</label>
				<cfselect name="letterType" required="Yes" message="You must select a Letter">
				<option value="">Select Letter:</option>
				<cfif debtHolderQuery.RecordCount NEQ 0>
				<!---<option value="allLetters" disabled="disabled">All Letters</option>--->
				</cfif>
				<option value="AcceptanceLetter">Acceptance Letter</option> 
				<option value="BankruptcyLetter" disabled="disabled">Bankruptcy Letter</option> 
				<option value="CeaseDesist">Cease & Desist</option>
				<option value="DeclinationLetter" disabled="disabled">Declination Letter</option>
				<option value="VerificationLetter" disabled="disabled">Verification Letter</option>
				<!---<option value="CRALetter" disabled="disabled">CRA Letter</option>---> 
				<option value="NonResponsiveClientLetter" disabled="disabled">Non-Responsive Client Letter</option>
				<option value="NonResponsiveClientLetterSpanish" disabled="disabled">Non Responsive Client Letter - Spanish</option>
				<option value="SecondDisputeLetterResponseToFirst">Second Dispute Letter (Incomplete Response to first)</option> 
				<option value="SecondDisputeLetterNoResponseToFirst">Second Dispute Letter (No response to First)</option> 
				<option value="DisputeLetter">Dispute letter</option> 
				<option value="DisputeLetterNoPhone">Dispute letter no phone</option> 
				<option value="verificationDisputeLetter">Verification Dispute letter</option> 
				<option value="verificationDisputeLetterNoPhone">Verification Dispute letter no phone</option>
				<!---<option value="genericLetter" disabled="disabled">Generic Letter</option>--->
				<!---<option value="briefingLetter" disabled="disabled">Briefing Letter</option>--->
			</cfselect></li>
		</ul>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<input type="submit" name="submit" value="Generate" onClick="generateLetter(document.getElementById('letterType').value);">
</fieldset>
			



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