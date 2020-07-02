<cfif SESSION.userIdProfile NEQ 2>
	<cfdiv id="legalMattersAddsComunicationsFormDiv" bind="url:legalMattersAddsComunicationsForm.cfm?idLegalMatter=#URL.idLegalMatter#" style="height:300px">
	</cfdiv>
</cfif>


<cfform name="legalMatterComunicationsGridForm">
	
	<cfgrid 
		name="legalMatterComunicationsGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.getComunicationByIdLegalMatter({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},getIdLegalMatter())" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		stripeRows="true"
		pagesize="5">

			
			<cfgridcolumn name="comunicationInOut" header="In/Out" width="100">
			<cfgridcolumn name="dateTime" header="Date" width="100">
			<cfgridcolumn name="thisUser" header="By" width="150">
			<cfgridcolumn name="subject" header="Subject" width="150">
			<cfgridcolumn name="body" header="Body" width="200">
			<cfgridcolumn name="actions" header="Actions" width="85" dataAlign="Center">
			
	</cfgrid>
</cfform>