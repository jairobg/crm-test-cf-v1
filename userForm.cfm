<cfif isDefined("FORM.userName")>
	<cfinvoke component="components.user" method="addUser" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('userGrid', true);
	</script>
</cfif>

<cfinvoke component="components.profile" method="list" returnVariable="profileQuery">
<cfinvoke component="components.affiliates" method="getAffiliateCompanies" returnvariable="affiliateCompanies">

<cfform name="addUserForm">
<cfinput name="isGoogleAccount" type="hidden" value="0">

<fieldset class="col1">
	<legend>User Form</legend>
	<ul class="">
	    <li>
	    	<label for="userName">E-mail</label> <cfinput name="userName" type="text" required="yes" message="The field E-mail is required with a valid e-mail address">
	    </li>
	    
		<li id="passwordField">
			<label for="password">Password</label>
			<cfinput name="password" type="text" value="">
		</li>
		
	    <li>
	    	<label for="idProfile">Profile</label></li>
			<cfselect name="idProfile" query="profileQuery" display="name" value="idProfile" queryPosition="below" required="Yes" message="The field Profile is required" onChange="showHideAffiliateCompany();">
				<option value="">- Select Profile -</option> 
			</cfselect>
		</li>

		<li id="affiliateField" style="display:none;">
	    	<label for="affiliateCompanyId">Affiliate Company</label></li>
			<cfselect name="affiliateCompanyId" query="affiliateCompanies" display="affiliateCompanyName" value="affiliateCompanyId" queryPosition="below" style="display:none;">
				<option value="">- Select Affiliate Company -</option> 
			</cfselect>
		</li>		
		<!---
		<li>
			<label for="isGoogleAccount">It's Google Account</label>
			<cfinput name="isGoogleAccount" type="checkbox" value="0" disabled="true">
		</li>
		--->
		
	</ul>
</fieldset>

<fieldset class="col2">	
	<ul class="">
	    <li><label for="firstName">First Name</label> <cfinput name="firstName" type="text"></li>
		<li><label for="middleName">Middle Name</label> <cfinput name="middleName" type="text"></li>
		<li><label for="lastName">Last Name</label> <cfinput name="lastName" type="text"></li>
	</ul>
		
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Create User">
</fieldset>
</cfform>