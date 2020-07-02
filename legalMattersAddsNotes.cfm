<cfif isdefined('URL.deleteNote') >
    <cfinvoke component="components.legalMatters" method="deleteNoteById">	
        <cfinvokeargument name="idLegalMatterNote" value="#URL.deleteNote#">
    </cfinvoke>
</cfif>


<cfdiv id="legalMattersAddsNotesFormDiv" bind="url:legalMattersAddsNotesForm.cfm?idLegalMatter=#URL.idLegalMatter#" style="height:230px">
</cfdiv>

<cfform name="legalMatterNotesGridForm">
	
	<cfgrid 
		name="legalMatterNotesGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.getNoteByIdLegalMatter({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},getIdLegalMatter())" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		stripeRows="true"
		pagesize="5">

			
			<cfgridcolumn name="thisDate" header="Date" width="100">
			<cfgridcolumn name="thisUserName" header="By" width="200">
			<cfgridcolumn name="note" header="Note" width="385">
			<cfgridcolumn name="actions" header="Actions" width="100" dataAlign="Center">
			
	</cfgrid>
</cfform>