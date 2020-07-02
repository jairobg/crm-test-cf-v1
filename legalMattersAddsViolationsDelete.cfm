<cfoutput>
<cfif isDefined("FORM.idLegalMatterViolation")>
	<cfinvoke component="components.legalMatters" method="deleteLegalMatterViolation">
		<cfinvokeargument name="idLegalMatterViolation" value="#FORM.idLegalMatterViolation#">
	</cfinvoke>
	<script>
		ColdFusion.Grid.refresh('legalMatterViolationsGrid', true);
		ColdFusion.Window.destroy('legalMatterViolationsDelete#FORM.idLegalMatterViolation#',true);
	</script>
	<cfexit>
</cfif>

<cfform name="legalMatterViolationsDeleteForm">
<fieldset>
	<legend>Delete Violation</legend>

	<cfinput type="hidden" name="idLegalMatterViolation" value="#URL.idLegalMatterViolation#">
	<ul>
		<li class="alert">Do you really want to delete this violation?</li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Delete">
</fieldset>	
</cfform>
<button class="cancelButton" onclick="ColdFusion.Window.destroy('legalMatterViolationsDelete#URL.idLegalMatterViolation#',true);">Cancel</button>
</cfoutput>