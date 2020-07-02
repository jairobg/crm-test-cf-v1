<cfinvoke component="components.history" method="getHistoryType" returnVariable="historyNoteTypeQuery">

<cfinvoke component="components.history" method="getHistoryById" returnVariable="thisHistoryQuery">
	<cfinvokeargument name="idHistory" value="#URL.idHistory#">
</cfinvoke>

<cfform name="addHistoryNoteForm">
<fieldset>
	<legend>History Info</legend>
	<ul class="">
		<li><label for="idHistoryType">Note type</label>
			<cfselect name="idHistoryType" query="historyNoteTypeQuery" display="name" disabled="true" value="idHistoryType" queryPosition="below" selected="#thisHistoryQuery.idHistoryType#">
				<option value=""> -Select Type- </option>
			</cfselect>
		</li>
		<li><label for="title">Title</label></li><cfinput size="70" type="text" name="title" value="#thisHistoryQuery.title#" readonly="true"></li>
		<li><label for="detail">Detail</label></li><cftextarea name="detail" required="yes" rows="8" cols="72" readonly="true"><cfoutput>#thisHistoryQuery.detail#</cfoutput></cftextarea></li>
	</ul>
</fieldset>
</cfform>
<cfoutput>
<fieldset class="action-buttons">
	<button onclick="ColdFusion.Window.destroy('infoHistory#URL.idHistory#',true);">Close</button>
</fielset>
</cfoutput>