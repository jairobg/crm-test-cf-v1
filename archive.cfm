<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Archive') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<cfset importMessage = "">


<cfif isDefined("FORM.archive")>
	<cfinvoke component="components.archive" method="addArchive" argumentCollection="#FORM#">
</cfif>

<cfoutput>#importMessage#</cfoutput>


<cfform name="inportArchive" enctype="multipart/form-data">
	<fieldset>
		<legend>Upload file</legend>
		<ul class="">
			<li><label for="archive">Select archive</label><cfinput type="file" name="archive" required="yes" message="You must select the file to import"></li>
			<li><label for="archiveName">Name</label><input type="text" name="archiveName"></li>
			<li><label for="archiveType">Type</label>
				<cfselect name="archiveType">
					<option value=""> -Select Type- </option>
					<option value="Retainer">Retainer</option>
					<option value="Credit Report/Statements">Credit Report/Statements</option>
					<option value="Compliance reporting">Compliance reporting</option>
					<option value="Other">Other</option>
				</cfselect>
			</li>
		</ul>
	</fieldset>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Upload">
	</fieldset>
</cfform>


<script>
	function editArchive(idArchive){
		ColdFusion.Window.create(
		'editArchive'+idArchive,
		'Edit Archive',
		'archiveEdit.cfm?idArchive='+idArchive,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 340,
			height: 340
		}
		);
	}

	function deleteArchive(idArchive){
		ColdFusion.Window.create(
		'deleteArchive'+idArchive,
		'Delete Archive',
		'archiveDelete.cfm?idArchive='+idArchive,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 340,
			height: 340
		}
		);
	}
</script>

<fieldset>
	<legend>Recorded Documents</legend>
</fieldset>

<cfform name="archiveGridForm">
	<cfgrid 
		name="archiveGrid"
		bindOnLoad="true" 
		bind="cfc:components.archive.getArchiveByFileId({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">


			
			<cfgridcolumn name="archiveName" header="Archive Name" width="225">
			<cfgridcolumn name="archiveType" header="Archive Type" width="225">
			<cfgridcolumn name="thisArcheveDate" header="Date" width="200" dataAlign="Right">
			<cfgridcolumn name="Edit" header="Actions" width="100" dataAlign="Center">

	</cfgrid>
</cfform>


<cfinclude template="template/footer.cfm">