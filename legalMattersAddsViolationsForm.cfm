<cfif isDefined("FORM.idLegalMatterViolationList")>
	<cfinvoke component="components.legalMatters" method="addLegalMatterViolation" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('legalMatterViolationsGrid', true);
	</script>
    </cfoutput>
     <cfset URL.idLegalMatter = FORM.idLegalMatter />
</cfif>

<cfinvoke component="components.legalMatters" method="getLegalMatterViolationsList" returnVariable="legalMatterViolationsQuery">

<cfform name="legalMattersAddsViolationsForm">
	<cfinput type="hidden" name="idLegalMatter" value="#URL.idLegalMatter#">
	<fieldset>
	<legend>Add Violation</legend>
		<ul class="col1">
			<li class="inputDate"><label for="legalMatterViolationDate">Date</label><cfinput name="legalMatterViolationDate" type="datefield" value="" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
			<li><label for="legalMatterViolationComment">Comment</label><cftextarea name="legalMatterViolationComment" rows="4" cols="25"></cftextarea></li>			
		</ul>
		<ul class="col2">
			<li><!--some fields--></li>
		</ul>
		<div class="clearfix"></div>
		<ul>
			<li><!---<label for="idLegalMatterViolationList">Violation</label>--->
				<cfselect 
					name="idLegalMatterViolationList"
					query="legalMatterViolationsQuery" 
					display="legalMatterViolationListName" 
					value="idLegalMatterViolationList" 
					required="true" 
					message="The field violation is required"
					queryPosition="below">
					<option value="0"> -Select Violation- </option>
				</cfselect>
			</li>
		</ul>
	</fieldset>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save">
	</fielset>
</cfform>