<cfif isDefined("FORM.idUser")>
	<cfinvoke component="components.user" method="editUser" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('userGrid', true);
		ColdFusion.Window.destroy('editUser#FORM.idUser#',true);
	</script>
	</cfoutput>
	<cfexit>
</cfif>

<cfinvoke component="components.user" method="getUserById" returnVariable="thisUserQuery">
	<cfinvokeargument name="idUser" value="#URL.idUser#">
</cfinvoke>
<cfinvoke component="components.profile" method="list" returnVariable="profileQuery">
<cfinvoke component="components.affiliates" method="getAffiliateCompanies" returnvariable="affiliateCompanies">

<cfform name="editUserForm">
<cfinput type="hidden" name="idUser" value="#URL.idUser#">
<fieldset class="col1">
	<legend>User Form</legend>
	<ul class="">
	
	    <li>
	    	<label for="userName">E-mail</label> <cfinput name="userName" type="text" required="yes" value="#thisUserQuery.userName#" message="The field E-mail is required with a valid e-mail address">
	    </li>
	    
	    <li>
	    	<label for="idProfile">Profile</label>
			<cfselect name="idProfile" query="profileQuery" display="name" value="idProfile" queryPosition="below" required="Yes" message="The field Profile is required" selected="#thisUserQuery.idProfile#">
				<option value="">- Select Profile -</option> 
			</cfselect>
		</li>
						
		<li>
	    	<label for="affiliateCompanyId">Affiliate Company</label></li>
			<cfselect name="affiliateCompanyId" query="affiliateCompanies" display="affiliateCompanyName" value="affiliateCompanyId" queryPosition="below" selected="#thisUserQuery.affiliateCompanyId#">
				<option value="0">- Select Affiliate Company -</option> 
			</cfselect>
		</li>		
		
	</ul>
</fieldset>

<fieldset class="col2">	

	<legend></legend>
	
	<ul class="">
	    <li><label for="firstName">First Name</label> <cfinput name="firstName" type="text" value="#thisUserQuery.firstName#"></li>
		<li><label for="middleName">Middle Name</label> <cfinput name="middleName" type="text" value="#thisUserQuery.middleName#"></li>
		<li><label for="lastName">Last Name</label> <cfinput name="lastName" type="text" value="#thisUserQuery.lastName#"></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>