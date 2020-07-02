<cfif isDefined("FORM.comunicationInOut")>
	<cfinvoke component="components.legalMatters" method="editLegalMatterComunication" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('legalMatterComunicationsGrid', true);
		<cfoutput>
		ColdFusion.Window.destroy('legalMatterComunicationsEdit#FORM.idComunication#',true);
		</cfoutput>
	</script>
</cfif>

<cfinvoke component="components.legalMatters" method="getLegalMatterComunicationsById" returnVariable="thisLegalMatterComunicationQuery">
	<cfinvokeargument name="idComunication" value="#URL.idComunication#">
</cfinvoke>

<cfform name="editlegalMattersAddsComunicationsForm">
<cfinput name="idComunication" type="hidden" value="#URL.idComunication#">
	<fieldset>
	<legend>Edit Communication</legend>

	<ul class="col1">
		<li><label for="comunicationInOut">In/Out</label>
			<cfselect name="comunicationInOut">
				<option value="IN" <cfif #thisLegalMatterComunicationQuery.comunicationInOut# EQ 'IN'>selected="selected"</cfif>>In</option>
				<option value="OUT" <cfif #thisLegalMatterComunicationQuery.comunicationInOut# EQ 'OUT'>selected="selected"</cfif>>Out</option>
			</cfselect>	
		</li>
		<li class="inputDate"><label for="dateTime">Date</label><cfinput type="datefield"name="dateTime" value="#dateFormat(thisLegalMatterComunicationQuery.dateTime, 'mm/dd/yyyy')#" mask="mm/dd/yyyy"  validate="date" message="Date should be 'mm/dd/yyyy'"></li>
	</ul>

	<ul class="col2">
		<li><label for="type">Type</label>
			<cfselect name="type">
				<option value="EMAIL" <cfif #thisLegalMatterComunicationQuery.type# EQ 'EMAIL'>selected="selected"</cfif>>E-mail</option>
				<option value="FAX" <cfif #thisLegalMatterComunicationQuery.type# EQ 'FAX'>selected="selected"</cfif>>Fax</option>
				<option value="PHONECALL" <cfif #thisLegalMatterComunicationQuery.type# EQ 'PHONECALL'>selected="selected"</cfif>>Phone Call</option>
				<option value="MAIL" <cfif #thisLegalMatterComunicationQuery.type# EQ 'MAIL'>selected="selected"</cfif>>Mail</option>
				<option value="SMS" <cfif #thisLegalMatterComunicationQuery.type# EQ 'SMS'>selected="selected"</cfif>>SMS</option>
			</cfselect>	
		</li>
		<li><label for="subject">Subject</label><cfinput type="text" name="subject" value="#thisLegalMatterComunicationQuery.subject#"></li>
		<li><label for="body">Body</label><cftextarea name="body" rows="4" cols="25"><cfoutput>#thisLegalMatterComunicationQuery.body#</cfoutput></cftextarea></li>	
	</ul>
	
	</fieldset>	
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save Changes">
	</fieldset>
	
</cfform>