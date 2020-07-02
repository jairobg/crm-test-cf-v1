<cfoutput>
	<cfif isDefined("FORM.idDebtHolder")>
		<cfinvoke component="components.debtHolder" method="deleteDebtHolder">
			<cfinvokeargument name="idDebtHolder" value="#FORM.idDebtHolder#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('creditorsGrid', true);
			ColdFusion.Grid.refresh('collectorsGrid', true);
			ColdFusion.Window.destroy('deleteDebtHolder#FORM.idDebtHolder#',true);
		</script>
		<cfexit>
	</cfif>
	
	<cfform name="debtHolderDelete">
	<fieldset>
		<legend>Delete #URL.type#</legend>	
		<cfinput type="hidden" name="idDebtHolder" value="#URL.idDebtHolder#">
		<ul>
			<li class="alert">Do you really want to delete #URL.type# #URL.name#?</li>
		</ul>

	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteDebtHolder#URL.idDebtHolder#',true);">Cancel</button>

</cfoutput>