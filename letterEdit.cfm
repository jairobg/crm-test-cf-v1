<cfif isDefined("FORM.idLetter")>
	<cfinvoke component="components.letters" method="editLetter" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('lettersGrid', true);
		ColdFusion.Window.destroy('editLetter#FORM.idLetter#',true);
	</script>
	</cfoutput>
	<cfexit>
</cfif>

<cfinvoke component="components.letters" method="getLetterById" returnVariable="thisLetterQuery">
	<cfinvokeargument name="idLetter" value="#URL.idLetter#">
</cfinvoke>

<cfform name="editLetterForm">
<cfinput type="hidden" name="idLetter" value="#URL.idLetter#">
<fieldset>
	<legend>Edit <cfoutput>#thisLetterQuery.letterType#</cfoutput></legend>
	<ul class="">
		<li><label for="tracking">Tracking</label><cftextarea name="tracking" rows="1" cols="45"><cfoutput>#thisLetterQuery.tracking#</cfoutput></cftextarea></li>
	</ul>

</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>