<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Client') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<!------ Functionality ----->

<cfif isDefined("FORM.firstName")>

	<cfinvoke component="components.file" method="addFile" returnVariable="addFileReturnString" argumentCollection="#FORM#"> 

	<cflocation url="fileEditForm.cfm?idFile=#SESSION.idFile#" addToken="no">
	
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<!------ Content ---->
<cfoutput>
<script type="text/javascript" src="#APPLICATION.template_path#js/validate/forms/mkFile.js"></script>
</cfoutput>
				 
<cfform name="fileAddForm">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div> 
                            

<fieldset class="col1">
	<legend>Primary Contact</legend>
	<ul class="">
		<li><label for="firstName">First Name</label> <cfinput name="firstName" type="text" class="required" placeholder="Required" ></li>
		<li><label for="initial">Middle</label> <cfinput name="initial" type="text"></li>
		<li><label for="lastName">Last Name</label> <cfinput name="lastName" type="text" class="required" placeholder="Required" ></li>
		<li><label for="homePhone">Home Phone</label> <cfinput name="homePhone" type="text" class="phone"></li>
		<li><label for="businessPhone">Business Phone</label> <cfinput name="businessPhone" type="text" class="phone"></li>
		
		<li>
			<label for="cellPhone">Cell Phone</label>
			<cfinput name="cellPhone" type="text" class="phone" required="yes" message="The cell phone is mandatory" placeholder="Required" />
		</li>
		
		<li><label for="email">E-mail</label> <cfinput name="email" type="text" class="email"></li>
		<li class="inputDate"><label for="dateBirth">Date birth</label> <cfinput name="dateBirth" type="datefield" validate="date" message="Date birth should be 'mm/dd/yyyy'"></li>
		<li><label for="socialSecurity">Social Security</label> <cfinput name="socialSecurity" type="text"></li>
		<li><label for="maritalStatus">Marital Status</label> <cfinput name="maritalStatus" type="text" ></li>
		<li><label for="address">Address</label> <cfinput name="address" type="text" ></li>
		<li><label for="city">City</label> <cfinput name="city" type="text" ></li>
		<li><label for="idState">State</label>
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" >
			<option value="">Select State:</option> 
		</cfselect></li>
		<li><label for="zip">ZIP:</label> <cfinput name="zip" type="text" ></li>
	</ul>	
	<cfinput type="hidden" name="idFileStatus" value="0">
</fieldset>


<fieldset class="col2">	
	<legend>Secondary Contact</legend>
	<ul class="">	
		<li><label for="scFirstName">First Name</label> <cfinput name="scFirstName" type="text" ></li>
		<li><label for="scInitial">Middle</label> <cfinput name="scInitial" type="text"></li>
		<li><label for="scLastName">Last Name</label> <cfinput name="scLastName" type="text" ></li>
		<li><label for="scHomePhone">Home Phone</label> <cfinput name="scHomePhone" type="text" class="phone"></li>
		<li><label for="scBusinessPhone">Business Phone</label> <cfinput name="scBusinessPhone" type="text" class="phone"></li>
		<li><label for="scCellPhone">Cell Phone</label> <cfinput name="scCellPhone" type="text" class="phone"></li>
		<li><label for="scEmail">Email</label> <cfinput name="scEmail" type="text" class="email"></li>
		<li class="inputDate"><label for="scDateBirth">Date birth</label> <cfinput name="scDateBirth" type="datefield" validate="date" message="Date birth should be 'mm/dd/yyyy'"></li>
		<li><label for="scSocialSecurity">Social Security</label> <cfinput name="scSocialSecurity" type="text" ></li>
		<li><label for="scMaritalStatus">Marital Status</label> <cfinput name="scMaritalStatus" type="text" ></li>
		<li><label for="scAddress">Address</label> <cfinput name="scAddress" type="text" ></li>
		<li><label for="scCity">City</label> <cfinput name="scCity" type="text" ></li>
		<li><label for="idState">State</label>
		<cfselect name="scState" query="statesQuery" display="name" value="idState" queryPosition="below">
			<option value="">Select State:</option> 
		</cfselect></li>
		<li><label for="scZip">ZIP:</label> <cfinput name="scZip" type="text" ></li>
	</ul>
</fieldset>


<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>

</cfform>

<cfinclude template="template/footer.cfm">