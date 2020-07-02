<cfoutput>
	<cfif isDefined("FORM.idSettlement")>
		<cfinvoke component="components.settlement" method="deleteSettlement">
			<cfinvokeargument name="idSettlement" value="#FORM.idSettlement#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('settlementGrid', true);
			ColdFusion.Window.destroy('deleteSettlement#FORM.idSettlement#',true);
		</script>
		<cfexit>
	</cfif>
	
	<cfform name="settlementDeleteForm">
	<fieldset>
		<legend>Delete settlement with #URL.financialInstitution# financial institution.</legend>
	
		<cfinput type="hidden" name="idSettlement" value="#URL.idSettlement#">
		<ul>
			<li class="alert">Do you really want to delete settlement with #URL.financialInstitution# financial institution?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton"  onclick="ColdFusion.Window.destroy('deleteSettlement#URL.idSettlement#',true);">Cancel</button>
</cfoutput>