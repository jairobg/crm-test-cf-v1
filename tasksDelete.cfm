<cfoutput>
<cfif isDefined("FORM.idTask")>
	<cfinvoke component="components.legalMatters" method="deleteTaskById">
		<cfinvokeargument name="idTask" value="#FORM.idTask#">
	</cfinvoke>
	<script>
		ColdFusion.Grid.refresh('taskGrid', true);
		ColdFusion.Window.destroy('taskDelete#FORM.idTask#',true);
	</script>
	<cfexit>
</cfif>

<cfform name="legalMatterTaskDeleteForm">
<fieldset>
	<legend>Delete Task</legend>

	<cfinput type="hidden" name="idTask" value="#URL.idTask#">
	<ul>
		<li class="alert">Do you really want to delete this task?</li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Delete">
</fieldset>	
</cfform>
<button class="cancelButton" onclick="ColdFusion.Window.destroy('taskDelete#URL.idTask#',true);">Cancel</button>	
</cfoutput>