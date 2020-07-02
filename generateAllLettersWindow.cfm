
<!---- This page is a loop when submit the form for the next letter type.  Saving all letter contents --->



<!-----        Actions when submit        ------------->
<cfif isDefined("FORM.letterType")>

	<cfinvoke component="components.letters" method="generateAllLetterData" argumentCollection="#FORM#">

	<!---- SOLO SI LLEGA AL FINAL --->

	<cfif isDefined("FORM.finalLetter")>
		<cfoutput>
		<script>
			ColdFusion.Grid.refresh('lettersGrid', true);
			ColdFusion.Window.destroy('generateAllLetters',true);
		</script>
		</cfoutput>
		<cfexit>
	</cfif>
</cfif>


<cfparam name="FORM.thisLetterType" default="SecondDisputeLetterResponseToFirst">
<cfparam name="FORM.debtHolderRow" default="1">

<cfinvoke component="components.debtHolder" method="getHolder" returnVariable="debtHolderQuery">

<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>


<cfform name="generateDocumentForm">
<cfinput type="hidden" name="letterType" value="#FORM.thisLetterType#">


	
<!-------------------- AcceptanceLetter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "AcceptanceLetter">
	<fieldset>
	<legend>Generate Acceptance Letter</legend>
	<ul>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	

	</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="hidden" name="thisLetterType" value="BankruptcyLetter">
		<input type="submit" name="submit" value="Next">
	</fieldset>
</cfif>
--->

	
<!-------------------- BankruptcyLetter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "BankruptcyLetter">
	<fieldset>
	<legend>Generate Bankruptcy Lette</legend>
	<ul>
	<li>Select client or clients for the letter</li>
	<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
	<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="hidden" name="thisLetterType" value="DeclinationLetter">
		<input type="submit" name="submit" value="Next">
	</fieldset>
</cfif>
--->
	
	
<!-------------------- DeclinationLetter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "DeclinationLetter">
	<fieldset>
	<legend>Generate Declination Letter</legend>
	<ul>
	<li>Select client or clients for the letter</li>
	<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
	<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="hidden" name="thisLetterType" value="VerificationLetter">
		<input type="submit" name="submit" value="Next">
	</fieldset>
</cfif>
--->

<!-------------------- VerificationLetter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "VerificationLetter">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Verification Letter <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="VerificationLetter">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="NonResponsiveClientLetter">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "NonResponsiveClientLetter">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>
--->

	
	<!-------------------- NonResponsiveClientLetter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "NonResponsiveClientLetter">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Non-Responsive Client Letter <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="NonResponsiveClientLetter">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="NonResponsiveClientLetterSpanish">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "NonResponsiveClientLetter">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>
--->

	
<!-------------------- NonResponsiveClientLetterSpanish ---------------------->
<!---
<cfif FORM.thisLetterType EQ "NonResponsiveClientLetterSpanish">
	<fieldset>
	<legend>Generate Non Responsive Client Letter - Spanish</legend>
	<ul>
	<li>Select client or clients for the letter</li>
	<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
	<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
	</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="hidden" name="thisLetterType" value="SecondDisputeLetterResponseToFirst">
		<input type="submit" name="submit" value="Next">
	</fieldset>
</cfif>
--->

	
	<!-------------------- SecondDisputeLetterResponseToFirst ---------------------->
<cfif FORM.thisLetterType EQ "SecondDisputeLetterResponseToFirst">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Second Dispute Letter (Incomplete Response to first) <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Enter Date of dispute letter</li>
		<li><label for="dlDate">Date</label><cfinput type="datefield" name="dlDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="SecondDisputeLetterResponseToFirst">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="SecondDisputeLetterNoResponseToFirst">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "SecondDisputeLetterNoResponseToFirst">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>
	
	
	
<!-------------------- SecondDisputeLetterNoResponseToFirst ---------------------->
<cfif FORM.thisLetterType EQ "SecondDisputeLetterNoResponseToFirst">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Second Dispute Letter (No response to First) <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Enter Date that our Furnisher letter was received</li>
		<li><label for="flDate">Date</label><cfinput type="datefield" name="flDate" value=""><br><br></li>
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>	

		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="SecondDisputeLetterNoResponseToFirst">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="verificationDisputeLetter">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "DisputeLetter">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>


<!-------------------- Dispute letter ---------------------->
<!---
<cfif FORM.thisLetterType EQ "DisputeLetter">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Dispute letter <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="DisputeLetter">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="DisputeLetterNoPhone">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "DisputeLetterNoPhone">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>
--->

	
<!-------------------- Dispute letter no phone ---------------------->
<!---
<cfif FORM.thisLetterType EQ "DisputeLetterNoPhone">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Dispute letter no phone <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="DisputeLetterNoPhone">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="verificationDisputeLetter">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "verificationDisputeLetter">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>
--->



<!-------------------- Verification Dispute letter ---------------------->
<cfif FORM.thisLetterType EQ "verificationDisputeLetter">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Verification Dispute letter <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="verificationDisputeLetter">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<cfinput type="hidden" name="thisLetterType" value="verificationDisputeLetterNoPhone">
				<cfinput type="hidden" name="debtHolderRow" value="1">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<cfset FORM.thisLetterType = "verificationDisputeLetterNoPhone">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>

	
<!-------------------- Verification Dispute letter no phone ---------------------->
<cfif FORM.thisLetterType EQ "verificationDisputeLetterNoPhone">
	<cfif debtHolderQuery.RecordCount GTE FORM.debtHolderRow>
	<cfloop query="debtHolderQuery" startRow="#FORM.debtHolderRow#" endRow="#FORM.debtHolderRow#">
		<fieldset>
		<legend>Generate Verification Dispute letter no phone <cfoutput>#debtHolderQuery.nameAccount#</cfoutput></legend>
		<ul>
		<li><label for="tracking">Tracking</label><cfinput type="text" name="tracking" value="" style="width:250px;"></li>
		<li><label for="nameAccount">Debt Holder</label><cfinput type="text" name="nameAccount" value="#debtHolderQuery.nameAccount#"></li>
		<cfinput type="hidden" name="idDebtHolder" value="#debtHolderQuery.idDebtHolder#">
		<li>Select client or clients for the letter</li>
		<li><cfinput type="checkbox" name="client1" value="1" checked="True"><label for="client1"><cfoutput>Client 1: #thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#</cfoutput></label>	
		<li><cfinput type="checkbox" name="client2" value="1"><label for="client2"><cfoutput>Client 2: #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#</cfoutput></label>			
		</ul>
		</fieldset>
		
		<cfif debtHolderQuery.RecordCount NEQ FORM.debtHolderRow>
		
			<fieldset class="action-buttons">
				<cfset nextDebtHolderRow = FORM.debtHolderRow + 1>
				<cfinput type="hidden" name="thisLetterType" value="verificationDisputeLetterNoPhone">
				<cfinput type="hidden" name="debtHolderRow" value="#nextDebtHolderRow#">
				<input type="submit" name="submit" value="Next">
			</fieldset>
		<cfelse>
			<fieldset class="action-buttons">
				<!--- End of letters sent param to create file and exit --->
				<cfinput type="hidden" name="finalLetter" value="1">
				<input type="submit" name="submit" value="Generate">
			</fieldset>
		</cfif>		
	</cfloop>
	<cfelse>
		<!--- FINAL no va a ningún lado--->
		<cfset FORM.thisLetterType = "DisputeLetter">
		<cfset FORM.debtHolderRow = "1">
	</cfif>
</cfif>



</cfform>