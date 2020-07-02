<cfif isDefined("FORM.title")>
	<cfinvoke component="components.history" method="addNote" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('historyGrid', true);
	</script>
</cfif>


<cfinvoke component="components.history" method="getHistoryType" returnVariable="historyNoteTypeQuery">

<cfform name="addHistoryNoteForm">
<fieldset>
	<legend>Notes</legend>
	<ul class="">
		<li><label for="idHistoryType">Note type</label>
			<cfselect name="idHistoryType" query="historyNoteTypeQuery" display="name" value="idHistoryType" queryPosition="below" required="Yes" message="The Note type field is required">
				<option value=""> -Select Type- </option>
			</cfselect>
		</li>
		<li><label for="title">Title</label></li><cfinput size="70" type="text" name="title" value="" required="yes" message="The Title field is required" placeholder="Required"></li>
		<li><label for="detail">Detail</label></li><cftextarea name="detail" required="yes" rows="8" cols="72" message="The Detail field is required" placeholder="Required"></cftextarea></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fielset>
</cfform>