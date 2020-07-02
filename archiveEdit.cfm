<cfif isDefined("FORM.archiveName")>
	<cfinvoke component="components.archive" method="editArchive" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.Grid.refresh('archiveGrid', true);
		ColdFusion.Window.destroy('editArchive#FORM.idArchive#',true);
	</script>
	</cfoutput>
	<cfexit >
</cfif>

<cfinvoke component="components.archive" method="getArchiveById" returnVariable="thisArchive">
	<cfinvokeargument name="idArchive" value="#URL.idArchive#">
</cfinvoke>

<cfform name="editArchiveForm">
<cfinput type="hidden" name="idArchive" value="#URL.idArchive#">
<fieldset>
	<legend>Edit Archive</legend>
		<ul class="">
			<li><label for="archiveName">Name</label><cfinput type="text" name="archiveName" value="#thisArchive.archiveName#"></li>
			<li><label for="archiveType">Type</label>
				<cfselect name="archiveType" selected="#thisArchive.archiveType#">
					<option <cfif thisArchive.archiveType EQ "">selected="selected"</cfif> value=""> -Select Type- </option>
					<option <cfif thisArchive.archiveType EQ "Retainer">selected="selected"</cfif> value="Retainer">Retainer</option>
					<option <cfif thisArchive.archiveType EQ "Credit Report/Statements">selected="selected"</cfif> value="Credit Report/Statements">Credit Report/Statements</option>
					<option <cfif thisArchive.archiveType EQ "Compliance reporting">selected="selected"</cfif> value="Compliance reporting">Compliance reporting</option>
					<option <cfif thisArchive.archiveType EQ "Other">selected="selected"</cfif> value="Other">Other</option>
				</cfselect>
			</li>
		</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save Changes">
</fieldset>
</cfform>