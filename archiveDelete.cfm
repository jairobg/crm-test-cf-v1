<cfoutput>
	<cfif isDefined("FORM.idArchive")>
		<cfinvoke component="components.archive" method="deleteArchive">
			<cfinvokeargument name="idArchive" value="#FORM.idArchive#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('archiveGrid', true);
			ColdFusion.Window.destroy('deleteArchive#FORM.idArchive#',true);
		</script>
		<cfexit >
	</cfif>
	
	<cfform name="archiveDeleteForm">
	<fieldset>
		<legend>Delete archive #URL.idArchive#</legend>
	
		<cfinput type="hidden" name="idArchive" value="#URL.idArchive#">
		<ul>
			<li class="alert">Do you really want to delete this archive?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteArchive#URL.idArchive#',true);">Cancel</button>

</cfoutput>