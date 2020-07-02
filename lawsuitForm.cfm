<cfif isDefined("FORM.plantiff")>
	<cfinvoke component="components.lawsuit" method="addLawsuit" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('lawsuitGrid', true);
	</script>
</cfif>

<cfform name="addLawsuitForm">
<fieldset class="col1">
	<legend>Lawsuit</legend>
	<ul class="">
		<li><label for="plantiff">Plantiff</label><cfinput type="text" name="plantiff" value="" required="yes" message="The field plantiff is required" placeholder="Required"></li>
		<li class="inputDate"><label for="date">Date</label><cfinput type="datefield" name="date" value="" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>

</fieldset>

<fieldset class="col2">
	<legend>Status</legend>
	<ul>
		<li class="inputRadio"><label><cfinput type="radio" name="status" value="Summons" checked="True"> Summons</label></li>
		<li class="inputRadio"><label><cfinput type="radio" name="status" value="Discovery"> Discovery</label></li>
		<li class="inputRadio"><label><cfinput type="radio" name="status" value="Summary judgment"> Summary judgment</label></li>
		<li class="inputRadio"><label><cfinput type="radio" name="status" value="Final judgment"> Final judgment</label></li>
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>
</cfform>