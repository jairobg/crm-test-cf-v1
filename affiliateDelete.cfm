<cfoutput>
	<cfif isDefined("FORM.affiliateCompanyId")>
		<cfinvoke component="components.affiliates" method="deleteAffiliateCompany">
			<cfinvokeargument name="affiliateCompanyId" value="#FORM.affiliateCompanyId#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('affiliateGrid', true);
			ColdFusion.navigate('affiliateForm.cfm','affiliateFormDiv');
			ColdFusion.Window.destroy('deleteAffiliate#FORM.affiliateCompanyId#',true);
		</script>
		<cfexit>
   	<!--- Crea la historia del usuario que entra al sistema --->
	<cfinvoke component="components.user" method="createUserHistoryNote">
		<cfinvokeargument name="userHistoryAction" value="Delete affiliate company">
	</cfinvoke> 		
	</cfif>
	
	<cfform name="affiliateDeleteForm">
	<fieldset>
		<legend>Delete affiliate</legend>
	
		<cfinput type="hidden" name="affiliateCompanyId" value="#URL.affiliateCompanyId#">
		<ul>
			<li class="alert">Do you really want to delete this affiliate?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteAffiliate#URL.affiliateCompanyId#',true);">Cancel</button>

</cfoutput>