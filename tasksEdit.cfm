<cfif isDefined("FORM.idTask")>
	<cfinvoke component="components.legalMatters" method="editLegalMatterTask" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('taskGrid', true);
		ColdFusion.Window.destroy('taskEdit#FORM.idTask#',true);
	</script>
    </cfoutput>
    <cfexit>
</cfif>


<cfinvoke component="components.user" method="getUsersForTask" returnVariable="getUsersQuery">
<cfinvoke component="components.legalMatters" method="getTaskById" returnVariable="thisTask">
	<cfinvokeargument name="idTask" value="#URL.idTask#">
</cfinvoke>

<cfform name="legalMattersEditTaskForm">

	<cfinput type="hidden" name="idTask" value="#URL.idTask#">
	<cfinput type="hidden" name="idGoogleTask" value="#thisTask.idGoogleTask#">

	<fieldset>
	<legend>Edit task</legend>
		<ul class="col1">
			<li><label for="idUser">Assigned to</label>
				<cfselect name="idUser" query="getUsersQuery" display="fullName" value="idUser" queryPosition="below" required="Yes" message="The field Assigned to is required" selected="#thisTask.idUser#">
					<option value=""> -Select User- </option>
				</cfselect>
			</li>
			<li><label for="title">Title</label><cfinput size="45" name="title" type="text" value="#thisTask.title#" required="yes" message="The field title is required" placeholder="Required"></li>
			
			<li><label for="taskWhere">Where</label><cfinput size="45" name="taskWhere" type="text" value="#thisTask.taskWhere#"></li>
			
			<li><label for="description">Description</label><cftextarea name="description" rows="5" cols="47"><cfoutput>#thisTask.description#</cfoutput></cftextarea></li>
		</ul>


		<ul class="col2">
			<li class="inputDateTime"><label for="taskStart">Start</label>
				<cfinput size="10" name="taskStart" type="datefield" value="#dateFormat(thisTask.taskStart, 'mm/dd/yyyy')#" required="yes" message="The Start field is required" >
			</li>
			<li class="inputTime">
				<cfselect name="taskStartHour">
					<option value="">Time:</option>
			        <cfloop index="i" from="1" to="24">
			        	<cfoutput>
			            <option value="#i#"<cfif i EQ hour(thisTask.taskStart)> selected="selected"</cfif>>#i#:00</option>
			            </cfoutput>
			        </cfloop>
				</cfselect>
			</li>
			<li class="inputDateTime"><label for="taskEnd">End</label>
				<cfinput size="10" name="taskEnd" type="datefield" value="#dateFormat(thisTask.taskEnd, 'mm/dd/yyyy')#" bind="{taskStart}" >
			</li>
			<li class="inputTime">
				<cfselect name="taskEndHour">
					<option value="">Time:</option>
			        <cfloop index="i" from="1" to="24">
			        	<cfoutput>
			            <option value="#i#"<cfif i EQ hour(thisTask.taskEnd)> selected="selected"</cfif>>#i#:00</option>
			            </cfoutput>
			        </cfloop>
				</cfselect>	
			</li>

		</ul>

	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save changes">
	</fieldset>
</cfform>