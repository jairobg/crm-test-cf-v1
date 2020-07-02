<cfif isDefined("FORM.letterType")>
	<cfinvoke component="components.letters" method="generateLetterData" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('lettersGrid', true);
		ColdFusion.Window.destroy('generateLetter#FORM.letterType#',true);
	</script>
	<cfexit>
	</cfoutput>
</cfif>

<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="debtHolderQuery">

<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>


<cfform name="generateDocumentForm">
<cfinput type="hidden" name="letterType" value="#URL.letterType#">

<fieldset>
	<legend>Generate Letter Confirmation</legend>
	<ul>

	<cfswitch expression="#URL.letterType#">
	
	<!-------------------- AcceptanceLetter ---------------------->
	<cfcase value="AcceptanceLetter">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- BankruptcyLetter ---------------------->
	<cfcase value="BankruptcyLetter">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- CeaseDesist ---------------------->
	<cfcase value="CeaseDesist">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- DeclinationLetter ---------------------->
	<cfcase value="DeclinationLetter">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- NonResponsiveClientLetter ---------------------->
	<cfcase value="NonResponsiveClientLetter">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>	
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- NonResponsiveClientLetterSpanish ---------------------->
	<cfcase value="NonResponsiveClientLetterSpanish">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- SecondDisputeLetterResponseToFirst ---------------------->
	<cfcase value="SecondDisputeLetterResponseToFirst">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>	
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Enter Date of dispute letter</li>
		<li><label for="dlDate">Date</label><cfinput type="datefield" name="dlDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>
	
	<!-------------------- SecondDisputeLetterNoResponseToFirst ---------------------->
	<cfcase value="SecondDisputeLetterNoResponseToFirst">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>	
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	

	</cfcase>

	<!-------------------- VerificationLetter ---------------------->
	<cfcase value="VerificationLetter">	
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>

	<!-------------------- CRALetter ---------------------->
	<cfcase value="CRALetter">	
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</cfcase>


	<!-------------------- Dispute letter ---------------------->
	<cfcase value="DisputeLetter">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	
	
	<!-------------------- Dispute letter no phone ---------------------->
	<cfcase value="DisputeLetterNoPhone">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	


	<!-------------------- Verification Dispute letter ---------------------->
	<cfcase value="verificationDisputeLetter">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	
	
	<!-------------------- Verification Dispute letter no phone ---------------------->
	<cfcase value="verificationDisputeLetterNoPhone">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	

	<!-------------------- Generic Letter ---------------------->
	<cfcase value="genericLetter">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	


	<!-------------------- Briefing Letter ---------------------->
	<cfcase value="briefingLetter">
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="idDebtHolder">Debt Holder</label>
		<cfselect name="idDebtHolder" query="debtHolderQuery" value="idDebtHolder" display="nameAccount" queryPosition="below">
			<option value=""> -Select Debt Holder- </option>
		</cfselect>
		</li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client1"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
	</cfcase>	

	
	</cfswitch>


	</ul>
</fieldset>

<fieldset class="action-buttons">
	<input type="submit" name="submit" value="Generate">
</fieldset>
			
</cfform>