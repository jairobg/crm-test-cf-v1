<cfif isDefined("FORM.note")>
	<cfinvoke component="components.legalMatters" method="addLegalMatterNote" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('legalMatterNotesGrid', true);
	</script>
    </cfoutput>
    <cfset URL.idLegalMatter = FORM.idLegalMatter />
</cfif>


<cfform name="legalMattersAddsNotesForm">
	<cfinput type="hidden" name="idLegalMatter" value="#URL.idLegalMatter#">
	<fieldset>
	<legend>Add note</legend>
		<ul class="">
			<li><label for="title">Note</label><cftextarea name="note" rows="4" cols="50"></cftextarea></li>
			<li><label for="addToHistory">Add to general notes</label><cfinput type="checkbox" name="addToHistory" value="1"></li>
		</ul>
	</fieldset>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save">
	</fielset>
</cfform>