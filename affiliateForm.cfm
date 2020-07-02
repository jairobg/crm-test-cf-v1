<cfif isDefined("FORM.affiliateCompanyName")>
	<cfinvoke component="components.affiliates" method="saveAffiliateCompany" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('affiliateGrid', true);
	</script>
</cfif>



<cfform name="addAffiliateForm">
<fieldset>
	<legend>Affiliate Form</legend>
</fieldset>

<fieldset class="col1">
	<ul class="">
	    <li>
	    	<label for="affiliateCompanyName">Company name</label> 
	    	<cfinput name="affiliateCompanyName" type="text" required="yes" message="The field Company Name is required">
	    </li>
	</ul>
</fieldset>
<!---
<fieldset class="col2">
	<ul class="">
		<li>
			<label for="affiliateCompanyName">Company percent</label> 
	    	<cfinput name="affiliateCompanyPercent" type="text" value="40" validate="numeric" message="The Company Percent must be a numeric value">
		</li>
	</ul>
</fieldset>
--->
<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Create Company Affiliate">
</fieldset>

</cfform>