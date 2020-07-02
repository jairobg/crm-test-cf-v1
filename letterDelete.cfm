<cfoutput>
	<cfif isDefined("FORM.idLetter")>
		<cfinvoke component="components.letters" method="deleteLetter" argumentCollection="#FORM#">
		<script>
			ColdFusion.Grid.refresh('lettersGrid', true);
			ColdFusion.Window.destroy('deleteLetter#FORM.idLetter#',true);
		</script>
		<cfexit>
	</cfif>
	
	<cfform name="letterDelete">
	<fieldset>
		<legend>Delete Letter</legend>	
		<cfinput type="hidden" name="idLetter" value="#URL.idLetter#">
		<ul>
			<li class="alert">Do you really want to delete this letter?</li>
		</ul>

	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteLetter#URL.idLetter#',true);">Cancel</button>

</cfoutput>