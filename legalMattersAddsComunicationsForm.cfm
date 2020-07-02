<cfif isDefined("FORM.subject")>
	<cfinvoke component="components.legalMatters" method="addLegalMatterComunication" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('legalMatterComunicationsGrid', true);
	</script>
    </cfoutput>
    <cfset URL.idLegalMatter = FORM.idLegalMatter />
</cfif>


<cfform name="legalMattersAddsComunicationsForm">

	<fieldset>
	<legend>Add Communication</legend>
	<cfinput type="hidden" name="idUser" value="#SESSION.userId#">
	<ul class="col1">
		<li><label for="comunicationInOut">In/Out</label>
			<cfselect name="comunicationInOut">
				<option value="IN">In</option>
				<option value="OUT">Out</option>
			</cfselect>	
		</li>

		<li><label for="userName">By</label><cfinput type="text"name="userName" value="#SESSION.userName#" disabled="true"></li>
		<cfinput type="hidden" name="idLegalMatter" value="#URL.idLegalMatter#">
		<li class="inputDate"><label for="dateTime">Date</label><cfinput type="datefield"name="dateTime" value="" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>
	<ul class="col2">
		<li><label for="type">Type</label>
			<cfselect name="type">
				<option value="EMAIL">E-mail</option>
				<option value="FAX">Fax</option>
				<option value="PHONECALL">Phone Call</option>
				<option value="MAIL">Mail</option>
				<option value="SMS">SMS</option>
			</cfselect>	
		</li>
		<li><label for="subject">Subject</label><cfinput type="text" name="subject" value=""></li>
		<li><label for="body">Body</label><cftextarea name="body" rows="4" cols="25"></cftextarea></li>	
	</ul>
	
	</fieldset>	
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save">
	</fieldset>
</cfform>