<cfif SESSION.userIdProfile NEQ 2>
	<cfdiv id="legalMattersAddsTaskFormDiv" bind="url:legalMattersAddsTaskForm.cfm?idLegalMatter=#URL.idLegalMatter#">
	</cfdiv>
</cfif>


<cfform name="legalMatterTaskGridForm">
	
	<cfgrid 
		name="legalMatterTaskGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.getTaskByIdLegalMatter({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},getIdLegalMatter())" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5">

			
			<cfgridcolumn name="title" header="Title" width="100">
			<cfgridcolumn name="description" header="Description" width="250">
			<cfgridcolumn name="responsible" header="Responsible" width="285">
			<cfgridcolumn name="taskStart" header="Start" width="100">
			<cfgridcolumn name="actions" header="Actions" width="50">
			
	</cfgrid>

<!---

	<cfgrid 
		name="legalMatterTaskGrid"
		bindOnLoad="true" 
		bind="url:components/legalMatters.cfc?method=getTaskByIdLegalMatter&page={cfgridpage}&pagesize={cfgridpagesize}&gridsortcolumn={cfgridsortcolumn}&gridsortdirection={cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5">

			
			<cfgridcolumn name="title" header="Title" width="100">
			<cfgridcolumn name="description" header="Description" width="300">
			<cfgridcolumn name="responsible" header="Responsible" width="285">
			<cfgridcolumn name="taskStart" header="Start" width="100">
			
	</cfgrid>

--->

	
</cfform>

