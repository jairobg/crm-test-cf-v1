<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Client') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<!------ Functionality ----->

<cfif isDefined("FORM.firstName")>
	<cfinvoke component="components.file" method="editFile" returnVariable="editFileReturnString" argumentCollection="#FORM#"> 
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<!--- Des-Encriptar socialsecurity numbers --->
<!---
<cfif thisFileQuery.socialSecurity NEQ "" >
	<cfscript>
        decryptedSS = decrypt(thisFileQuery.socialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
    </cfscript>
<cfelse>
	<cfscript>
        decryptedSS = "";
    </cfscript>
</cfif>
 
<cfif thisFileQuery.scSocialSecurity NEQ "" >  
	<cfscript>
        decryptedScSS = decrypt(thisFileQuery.scSocialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
    </cfscript>
<cfelse>
	<cfscript>
        decryptedScSS = "";
    </cfscript>
</cfif>
--->

<!------ Content ---->
<cfoutput>
<script type="text/javascript" src="#APPLICATION.template_path#js/validate/forms/mkFile.js"></script>
</cfoutput>
				 
<cfform name="fileForm">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div> 
                            

<fieldset class="col1">
	<legend>Primary Contact</legend>
	<ul class="">
		<li>
			<label for="firstName">First Name</label> 
			<cfinput name="firstName" type="text" class="required" placeholder="Required" value="#thisFileQuery.firstName#" >
		</li>
		
		<li>
			<label for="initial">Middle</label> 
			<cfinput name="initial" type="text" value="#thisFileQuery.initial#" >
		</li>
		
		<li>
			<label for="lastName">Last Name</label> 
			<cfinput name="lastName" type="text" class="required" placeholder="Required" value="#thisFileQuery.lastName#" >
		</li>
		
		<li>
			<label for="homePhone">Home Phone</label> 
			<cfinput name="homePhone" type="text" class="phone" value="#thisFileQuery.homePhone#" >
		</li>
		
		<li>
			<label for="businessPhone">Business Phone</label> 
			<cfinput name="businessPhone" type="text" class="phone" value="#thisFileQuery.businessPhone#" >
		</li>
		
		<li>
			<label for="cellPhone">Cell Phone</label> 
			<cfinput name="cellPhone" type="text" class="phone" value="#thisFileQuery.cellPhone#" >
		</li>
		
		<li>
			<label for="email">E-mail</label> 
			<cfinput name="email" type="text" class="email" value="#thisFileQuery.email#" >
		</li>
		
		<li class="inputDate">
			<label for="dateBirth">Date birth</label> 
			<cfinput name="dateBirth" type="datefield" class="date" value="#dateFormat(thisFileQuery.dateBirth, 'mm/dd/yyyy')#" validate="date" message="Date birth should be 'mm/dd/yyyy'" >
		</li>
		
		<li>
			<label for="socialSecurity">Social Security</label> 
			<cfinput name="socialSecurity" type="text" value="#thisFileQuery.socialSecurity#" >
		</li>
		
		<li>
			<label for="maritalStatus">Marital Status</label> 
			<cfinput name="maritalStatus" type="text" value="#thisFileQuery.maritalStatus#" >
		</li>
		
		<li>
			<label for="address">Address</label> 
			<cfinput name="address" type="text" value="#thisFileQuery.address#" >
		</li>
		
		<li>
			<label for="city">City</label> 
			<cfinput name="city" type="text" value="#thisFileQuery.city#" >
		</li>
		
		<li>
			<label for="idState">State</label>
			<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" selected="#thisFileQuery.idState#" >
				<option value="">Select State:</option> 
			</cfselect>
		</li>
		
		<li>
			<label for="zip">ZIP:</label> 
			<cfinput name="zip" type="text" value="#thisFileQuery.zip#"  >
		</li>
		
		<hr />

		<li>
			<label for="debtorId">Debtor ID:</label> 
			<cfinput name="debtorId" type="text" value="#thisFileQuery.debtorId#"  >
		</li>
		
		<cfif SESSION.userIdProfile EQ 7 OR SESSION.userIdProfile EQ 1>
		<li>
			<label for="clientStatus">Client Status:</label>
			<cfselect name="clientStatus">
				<option value="New" <cfif thisFileQuery.clientStatus EQ "">selected="selected"</cfif>>-Select Status-</option>
				<option value="New" <cfif thisFileQuery.clientStatus EQ "New">selected="selected"</cfif>>New</option>
				<option value="Working" <cfif thisFileQuery.clientStatus EQ "Working">selected="selected"</cfif>>Working</option>
				<option value="Lost" <cfif thisFileQuery.clientStatus EQ "Lost">selected="selected"</cfif>>Lost</option>
				<option value="Won" <cfif thisFileQuery.clientStatus EQ "Won">selected="selected"</cfif>>Won</option>
				<option value="WEB Lead" <cfif thisFileQuery.clientStatus EQ "WEB Lead">selected="selected"</cfif>>WEB Lead</option>
			</cfselect>
		</li>
		<cfelse>
			<cfinput type="hidden" name="clientStatus" value="#thisFileQuery.clientStatus#" />
		</cfif>

		<!--- Edicion del retainer status --->
		<cfif SESSION.userId EQ 2 OR SESSION.userId EQ 58 OR SESSION.userId EQ 72>
		<li>
			<label for="retainerStatus">Retainer Status:</label>
			<cfselect name="retainerStatus">
				<option value="New" <cfif thisFileQuery.retainerStatus EQ "">selected="selected"</cfif>>-Select Status-</option>
				<option value="Send" <cfif thisFileQuery.retainerStatus EQ "Send">selected="selected"</cfif>>Send</option>
				<option value="Client" <cfif thisFileQuery.retainerStatus EQ "Client">selected="selected"</cfif>>Client</option>
				<option value="Attorney" <cfif thisFileQuery.retainerStatus EQ "Attorney">selected="selected"</cfif>>Attorney</option>
				<option value="Complete" <cfif thisFileQuery.retainerStatus EQ "Complete">selected="selected"</cfif>>Complete</option>
				<option value="Void" <cfif thisFileQuery.retainerStatus EQ "Void">selected="selected"</cfif>>Void</option>
				<option value="Denied" <cfif thisFileQuery.retainerStatus EQ "Denied">selected="selected"</cfif>>Denied</option>
			</cfselect>
		</li>
		<cfelse>
			<cfinput type="hidden" name="retainerStatus" value="#thisFileQuery.retainerStatus#" />
		</cfif>

				
	</ul>
		
	<cfinput type="hidden" name="idFileStatus" value="0">

</fieldset>


<fieldset class="col2">	

	<legend>Secondary Contact</legend>

	<ul class="">	
		<li>
			<label for="scFirstName">First Name</label> 
			<cfinput name="scFirstName" type="text" value="#thisFileQuery.scFirstName#"  >
		</li>
		
		<li>
			<label for="scInitial">Middle</label>
			<cfinput name="scInitial" type="text" value="#thisFileQuery.scInitial#" >
		</li>
		
		<li>
			<label for="scLastName">Last Name</label> 
			<cfinput name="scLastName" type="text" value="#thisFileQuery.scLastName#"  >
		</li>
		
		<li>
			<label for="scHomePhone">Home Phone</label> 
			<cfinput name="scHomePhone" type="text" class="phone" value="#thisFileQuery.scHomePhone#" >
		</li>
		
		<li>
			<label for="scBusinessPhone">Business Phone</label> 
			<cfinput name="scBusinessPhone" type="text" class="phone" value="#thisFileQuery.scBusinessPhone#">
		</li>
		
		<li>
			<label for="scCellPhone">Cell Phone</label>
			<cfinput name="scCellPhone" type="text" class="phone" value="#thisFileQuery.scCellPhone#">
		</li>
		
		<li>
			<label for="scEmail">Email</label>
			<cfinput name="scEmail" type="text" class="email" value="#thisFileQuery.scEmail#" >
		</li>
		
		<li class="inputDate">
			<label for="scDateBirth">Date birth</label>
			<cfinput name="scDateBirth" type="datefield" class="date" value="#dateFormat(thisFileQuery.scDateBirth, 'mm/dd/yyyy')#" validate="date" message="Date birth should be 'mm/dd/yyyy'" >
		</li>
		
		<li>
			<label for="scSocialSecurity">Social Security</label> 
			<cfinput name="scSocialSecurity" type="text" value="#thisFileQuery.scSocialSecurity#"  >
		</li>
		
		<li>
			<label for="scMaritalStatus">Marital Status</label>
			<cfinput name="scMaritalStatus" type="text" value="#thisFileQuery.scMaritalStatus#" >
		</li>
		
		<li>
			<label for="scAddress">Address</label> 
			<cfinput name="scAddress" type="text" value="#thisFileQuery.scAddress#"  >
		</li>
		
		<li>
			<label for="scCity">City</label>
			<cfinput name="scCity" type="text" value="#thisFileQuery.scCity#"  >
		</li>
		
		<li>
			<label for="idState">State</label>
			<cfselect name="scState" query="statesQuery" display="name" value="idState" queryPosition="below" selected="#thisFileQuery.scState#" >
				<option value="">Select State:</option> 
			</cfselect>
		</li>
		
		<li>
			<label for="scZip">ZIP:</label> 
			<cfinput name="scZip" type="text" value="#thisFileQuery.scZip#" >
		</li>

	</ul>

</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>

</cfform>

<cfinclude template="template/footer.cfm">