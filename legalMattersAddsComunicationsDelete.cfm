<cfoutput>
<cfif isDefined("FORM.idComunication")>
	<cfinvoke component="components.legalMatters" method="deleteComunicationById">
		<cfinvokeargument name="idComunication" value="#FORM.idComunication#">
	</cfinvoke>
	<script>
		ColdFusion.Grid.refresh('legalMatterComunicationsGrid', true);
		ColdFusion.Window.destroy('legalMatterComunicationDelete#FORM.idComunication#',true);
	</script>
	<cfexit>
</cfif>

<cfform name="legalMatterComunicationDeleteForm">
<fieldset>
	<legend>Delete</legend>

	<cfinput type="hidden" name="idComunication" value="#URL.idComunication#">
	<ul>
		<li class="alert">Do you really want to delete this Comunication?</li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Delete">
</fieldset>	
</cfform>
<button class="cancelButton" onclick="ColdFusion.Window.destroy('legalMatterComunicationDelete#URL.idComunication#',true);">Cancel</button>
</cfoutput>