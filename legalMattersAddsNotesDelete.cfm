<cfoutput>
<cfif isDefined("FORM.idLegalMatterNote")>
	<cfinvoke component="components.legalMatters" method="deleteNoteById">
		<cfinvokeargument name="idLegalMatterNote" value="#FORM.idLegalMatterNote#">
	</cfinvoke>
	<script>
		ColdFusion.Grid.refresh('legalMatterNotesGrid', true);
		ColdFusion.Window.destroy('legalMatterNoteDelete#FORM.idLegalMatterNote#',true);
	</script>
	<cfexit>
</cfif>

<cfform name="legalMatterNoteDeleteForm">
<fieldset>
	<legend>Delete Note</legend>

	<cfinput type="hidden" name="idLegalMatterNote" value="#URL.idLegalMatterNote#">
	<ul>
		<li class="alert">Do you really want to delete this note?</li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Delete">
</fieldset>	
</cfform>
<button class="cancelButton" onclick="ColdFusion.Window.destroy('legalMatterNoteDelete#URL.idLegalMatterNote#',true);">Cancel</button>	
</cfoutput>