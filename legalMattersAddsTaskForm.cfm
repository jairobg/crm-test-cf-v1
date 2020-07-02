<cfparam name="addLegalMatterResponse" default="">

<cfif isDefined("FORM.title")>
	<cfinvoke component="components.legalMatters" method="addLegalMatterTask" argumentCollection="#FORM#" returnVariable="addLegalMatterResponse">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('legalMatterTaskGrid', true);
	</script>
    </cfoutput>
     <cfset URL.idLegalMatter = FORM.idLegalMatter />
</cfif>


<cfinvoke component="components.user" method="getUsersForTask" returnVariable="getUsersQuery">

<cfform name="legalMattersAddsTaskForm">

	<cfinput type="hidden" name="idLegalMatter" value="#URL.idLegalMatter#">

	<fieldset>
	<span><cfoutput>#addLegalMatterResponse#</cfoutput></span>
	<legend>Add task</legend>
		<ul class="col1">
			<li><label for="idUser">Assigned to</label>
				<cfselect name="idUser" query="getUsersQuery" display="fullName" value="idUser" queryPosition="below" required="Yes" message="The field Assigned to is required">
					<option value=""> -Select User- </option>
				</cfselect>
			</li>
			
			<li><label for="preSetTask">Pre-set task</label>
				<cfselect name="preSetTask">
					<option value=""> -Select pre task- </option>
					<option value="Litigation review requested">Litigation review requested</option>
					<option value="Verifications due">Verifications due</option>
					<option value="Retention work out requested">Retention work out requested</option>
					<option value="Bk review">Bk review</option>
					<option value="Loan mod opportuity">Loan mod opportuity</option>
					<option value="Foreclosure review">Foreclosure review</option>
					<option value="Settlement call">Settlement call</option>
				</cfselect>
			</li>						
			<li><label for="title">Title</label><cfinput size="40" name="title" type="text" value="" required="yes" message="The field title is required" placeholder="Required"></li>
			<li><label for="taskWhere">Where</label><cfinput size="40" name="taskWhere" type="text" value=""></li>
			<li><label for="description">Description</label><cftextarea name="description" rows="4" cols="43"></cftextarea></li>
		</ul>


		<ul class="col2">
			<li class="inputDateTime"><label for="taskStart">Start</label>
				<cfinput size="8" name="taskStart" type="datefield" value="" required="yes" mask="mm/dd/yyyy"  validate="date" message="Start date should be 'mm/dd/yyyy'" >
			</li>
			<li class="inputTime">
				<cfselect name="taskStartHour" required="Yes" message="The start hour field is required">
					<option value="">Time:</option>
			        <cfloop index="i" from="1" to="24">
			        	<cfoutput>
			            <option value="#i#">#i#:00</option>
			            </cfoutput>
			        </cfloop>
				</cfselect>
			</li>
			<li class="inputDateTime"><label for="taskEnd">End</label>
				<cfinput size="8" name="taskEnd" type="datefield" value="" bind="{taskStart}"  mask="mm/dd/yyyy" validate="date" message="End date should be 'mm/dd/yyyy'">
			</li>
			<li class="inputTime">
				<cfselect name="taskEndHour" required="Yes" message="The end hour field is required">
					<option value="">Time:</option>
			        <cfloop index="i" from="1" to="24">
			        	<cfoutput>
			            <option value="#i#">#i#:00</option>
			            </cfoutput>
			        </cfloop>
				</cfselect>	
			</li>

		</ul>
		<div class="clearfix"></div>
	</fieldset>

	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save">
	</fieldset>
</cfform>

<div class="clearfix"></div>