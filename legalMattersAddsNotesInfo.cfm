<cfinvoke component="components.legalMatters" method="getNoteById" returnVariable="thisNoteInfo">
	<cfinvokeargument name="idLegalMatterNote" value="#URL.idLegalMatterNote#">
</cfinvoke>

<cfform name="legalMattersAddsNotesForm">
	<fieldset>
	<legend>Note information</legend>
		<ul class="">
			<li><label for="title">Note</label><cftextarea name="note" rows="4" cols="50" disabled="true"><cfoutput>#thisNoteInfo.note#</cfoutput></cftextarea></li>
		</ul>
	</fieldset>
</cfform>
<cfoutput>
<fieldset class="action-buttons">
	<button onclick="ColdFusion.Window.destroy('legalMatterNotesInfo#URL.idLegalMatterNote#',true);">Close</button>
</fielset>
</cfoutput>