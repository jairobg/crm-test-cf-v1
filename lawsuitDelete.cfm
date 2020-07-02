<cfoutput>
	<cfif isDefined("FORM.idLawsuit")>
		<cfinvoke component="components.lawsuit" method="deleteLawsuit">
			<cfinvokeargument name="idLawsuit" value="#FORM.idLawsuit#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('lawsuitGrid', true);
			ColdFusion.Window.destroy('deleteLawsuit#FORM.idLawsuit#',true);
		</script>
		<cfexit>
	</cfif>
	<cfform name="lawsuitDeleteForm">
	<fieldset>
		<legend>Delete plantiff #URL.plantiff#</legend>
	
		<cfinput type="hidden" name="idLawsuit" value="#URL.idLawsuit#">
		<ul>
			<li class="alert">Do you really want to delete plantiff #plantiff#?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteLawsuit#URL.idLawsuit#',true);">Cancel</button>

</cfoutput>