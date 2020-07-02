<cfif isDefined("FORM.plantiff")>
	<cfinvoke component="components.lawsuit" method="editLawsuit" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('lawsuitGrid', true);
		<cfoutput>
		ColdFusion.Window.destroy('editLawsuit#FORM.idLawsuit#',true);
		</cfoutput>
	</script>
</cfif>

<cfinvoke component="components.lawsuit" method="getLawsuitById" returnVariable="thisLawsuit">
	<cfinvokeargument name="idLawsuit" value="#URL.idLawsuit#">
</cfinvoke>

<cfform name="editLawsuitForm">
<cfinput type="hidden" name="idLawsuit" value="#URL.idLawsuit#">
<fieldset class="col1">
	<legend>Edit Lawsuit</legend>
	<ul class="">
		<li><label for="plantiff">Plantiff</label><cfinput type="text" name="plantiff" value="#thisLawsuit.plantiff#" required="yes" message="The field plantiff is required" placeholder="Required"></li>
		<li class="inputDate"><label for="date">Date</label><cfinput type="datefield" name="date" value="#thisLawsuit.date#" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>

</fieldset>

<fieldset class="col2">
	<legend>Status</legend>
	<ul>
		<li class="inputRadio"><label><input type="radio" name="status" value="Summons" <cfif thisLawsuit.status EQ 'Summons'>checked="True"</cfif>> Summons</label></li>
		<li class="inputRadio"><label><input type="radio" name="status" value="Discovery" <cfif thisLawsuit.status EQ 'Discovery'>checked="True"</cfif>> Discovery</label></li>
		<li class="inputRadio"><label><input type="radio" name="status" value="Summary judgment" <cfif thisLawsuit.status EQ 'Summary judgment'>checked="True"</cfif>> Summary judgment</label></li>
		<li class="inputRadio"><label><input type="radio" name="status" value="Final judgment" <cfif thisLawsuit.status EQ 'Final judgment'>checked="True"</cfif>> Final judgment</label></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>