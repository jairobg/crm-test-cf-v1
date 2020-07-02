<cfoutput>
	<cfif isDefined("FORM.idProperty")>
		<cfinvoke component="components.Properties" method="deleteProperty">
			<cfinvokeargument name="idProperty" value="#FORM.idProperty#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('propertiesGrid', true);
			ColdFusion.Window.destroy('deleteProperty#FORM.idProperty#',true);
		</script>
	</cfif>
	
	<cfform name="PropertyDeleteForm">
	<fieldset>
		<legend>Delete Property</legend>
	
		<cfinput type="hidden" name="idProperty" value="#URL.idProperty#">
		<ul>
			<li class="alert">Do you really want to delete this property?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteProperty#URL.idProperty#',true);">Cancel</button>

</cfoutput>