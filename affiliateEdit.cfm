<cfif isDefined("FORM.affiliateCompanyName")>
	<cfinvoke component="components.affiliates" method="updateAffiliateCompany" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('affiliateGrid', true);
		ColdFusion.navigate('affiliateForm.cfm','affiliateFormDiv');
		ColdFusion.Window.destroy('editAffiliate#FORM.affiliateCompanyId#',true);
	</script>
	</cfoutput>
	<cfexit>
</cfif>


<cfinvoke component="components.affiliates" method="getAvailableAdminList" returnVariable="availableAdminList" argumentCollection="#URL#">

<cfinvoke component="components.affiliates" method="getAvailableSuperAffiliateList" returnVariable="availableSuperAffiliateList" argumentCollection="#URL#">

<cfinvoke component="components.affiliates" method="getAllAdminByCompanyIdList" returnVariable="thisAffiliateAdministrators" argumentCollection="#URL#">

<cfinvoke component="components.affiliates" method="getAffiliateCompanyById" returnVariable="thisAffiliate">
	<cfinvokeargument name="affiliateCompanyId" value="#URL.affiliateCompanyId#">
</cfinvoke>

<cfform name="editArchiveForm">
<cfinput type="hidden" name="affiliateCompanyId" value="#URL.affiliateCompanyId#">
<fieldset>
	<legend>Affiliate Form</legend>
</fieldset>

<fieldset class="col1">
	<ul class="">

	    <li>
	    	<label for="affiliateCompanyName">Company name</label> 
	    	<cfinput name="affiliateCompanyName" type="text" required="yes" message="The field Company Name is required" value="#thisAffiliate.affiliateCompanyName#">
	    </li>

	    <li>
	        <label for="affiliateCompanyUserAdmin">Select Administrators</label>
			<cfselect name="affiliateCompanyUserAdmin" query="availableAdminList" selected="#thisAffiliateAdministrators#" display="fullUserName" value="idUser" queryPosition="below" required="Yes" message="The field Affiliate Admin is required" multiple="yes">
			</cfselect>
		</li>

	    <li>
	        <label for="superAffiliateId">Select Super Affiliate</label>
			<cfselect name="superAffiliateId" query="availableSuperAffiliateList" selected="#thisAffiliate.superAffiliateId#" display="fullUserName" value="idUser" queryPosition="below" required="no">
				<option value="0">- Select Super Affiliate -</option>
			</cfselect>
		</li>

	    <li>
	    	<label for="payToId">Pay To ID</label> 
	    	<cfinput name="payToId" type="text" value="#thisAffiliate.payToId#">
	    </li>

		<hr />
				
		<li>
			<label for="affiliateCompanyName">Affiliates % of the Fee</label> 
	    	<cfinput name="affiliateCompanyPercent" type="text" value="#thisAffiliate.affiliateCompanyPercent#" validate="numeric" message="The Affiliates % of the Fee must be a numeric value">
		</li>
		<hr />

		<li>
			<label for="affiliateCompanyName">Total Brokers % of the Fee to Rick Graff Inc.</label> 
	    	<cfinput name="totalBrokersFeeToRick" type="text" value="#thisAffiliate.totalBrokersFeeToRick#" validate="numeric" message="The Total Brokers % of the Fee to Rick Graff Inc. must be a numeric value">
		</li>


	</ul>
</fieldset>

<fieldset class="col2">	
	<ul class="">

		<li>
			<label for="affiliateCompanyName">Total Master Brokers % of the Fee to Law Support & Consultants</label> 
	    	<cfinput name="totalBrokersFeeToLawSupport" type="text" value="#thisAffiliate.totalBrokersFeeToLawSupport#" validate="numeric" message="The Total Master Brokers % of the Fee to Law Support & Consultants must be a numeric value">
		</li>
		<div class="clearfix"></div>
		<li>
			<label for="affiliateCompanyName">Ramsaran Fee %</label> 
	    	<cfinput name="ramsaranFee" type="text" value="#thisAffiliate.ramsaranFee#" validate="numeric" message="The Ramsaran Fee % must be a numeric value">
		</li>
		<hr />

		<li>
			<label for="affiliateCompanyName">Affiliate $ amount of Monthly Maintenance Fee</label> 
	    	<cfinput name="monthlyMaintenanceAffiliate" type="text" value="#thisAffiliate.monthlyMaintenanceAffiliate#" validate="numeric" message="The Affiliate $ amount of Monthly Maintenance Fee must be a numeric value">
		</li>
		<hr />

		<li>
			<label for="affiliateCompanyName">Monthly Maintenance Fee to Rick Graff Inc.</label> 
	    	<cfinput name="monthlyMaintenanceRick" type="text" value="#thisAffiliate.monthlyMaintenanceRick#" validate="numeric" message="The Monthly Maintenance Fee to Rick Graff Inc. must be a numeric value">
		</li>
		<hr />

		<li>
			<label for="affiliateCompanyName">Monthly Maintenance Fee to Law Support & Consultants</label> 
	    	<cfinput name="monthlyMaintenanceLawSupport" type="text" value="#thisAffiliate.monthlyMaintenanceLawSupport#" validate="numeric" message="The Monthly Maintenance Fee to Law Support & Consultants must be a numeric value">
		</li>
		<hr />

		<li>
			<label for="affiliateCompanyName">Ramsaran Monthly $</label> 
	    	<cfinput name="ramsaranMonthly" type="text" value="#thisAffiliate.ramsaranMonthly#" validate="numeric" message="The Ramsaran Monthly $ must be a numeric value">
		</li>


	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>