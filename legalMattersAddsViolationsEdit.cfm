<cfif isDefined("FORM.idLegalMatterViolationList")>
	<cfinvoke component="components.legalMatters" method="editLegalMatterViolation" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('legalMatterViolationsGrid', true);
		ColdFusion.Window.destroy('legalMatterViolationsEdit#FORM.idLegalMatterViolation#',true);
	</script>
    </cfoutput>
</cfif>

<cfinvoke component="components.legalMatters" method="getLegalMatterViolationsList" returnVariable="legalMatterViolationsListQuery">

<cfinvoke component="components.legalMatters" method="getLegalMatterViolationById" returnVariable="thisLegalMatterViolationQuery">
	<cfinvokeargument name="idLegalMatterViolation" value="#URL.idLegalMatterViolation#">
</cfinvoke>

<cfform name="editLegalMattersAddsViolationsForm">
	<cfinput type="hidden" name="idLegalMatterViolation" value="#URL.idLegalMatterViolation#">
	<fieldset>
	<legend>Edit Violation</legend>
		<ul class="col1">
			<li class="inputDate"><label for="legalMatterViolationDate">Date</label><cfinput name="legalMatterViolationDate" type="datefield" value="#dateFormat(thisLegalMatterViolationQuery.legalMatterViolationDate, 'mm/dd/yyyy')#" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
			<li><label for="legalMatterViolationComment">Comment</label><cftextarea name="legalMatterViolationComment" rows="4" cols="25"><cfoutput>#thisLegalMatterViolationQuery.legalMatterViolationComment#</cfoutput></cftextarea></li>			
		</ul>
		<ul class="col2">
			<li><!--some fields--></li>
		</ul>
		<div class="clearfix"></div>
		<ul>
			<li><!---<label for="idLegalMatterViolationList">Violation</label>--->
				<cfselect 
					name="idLegalMatterViolationList"
					query="legalMatterViolationsListQuery" 
					display="legalMatterViolationListName" 
					value="idLegalMatterViolationList" 
					required="true" 
					message="The field violation is required"
					queryPosition="below"
					selected="#thisLegalMatterViolationQuery.idLegalMatterViolationList#">
					<option value=""> -Select Violation- </option>
				</cfselect>
			</li>
		</ul>
	</fieldset>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save Changes">
	</fielset>
</cfform>