<cfif SESSION.userIdProfile NEQ 2>
	<cfdiv id="legalMattersAddsViolationsFormDiv" bind="url:legalMattersAddsViolationsForm.cfm?idLegalMatter=#URL.idLegalMatter#" style="height:300px">
	</cfdiv>
</cfif>

<cfif SESSION.userId EQ 2>	
	<cfinvoke component="components.legalMatters" method="getViolationByIdLegalMatter" returnvariable="test">
		<cfinvokeargument name="idLegalMatter" value="1" />
		<cfinvokeargument name="page" value="1" />
		<cfinvokeargument name="pageSize" value="5" />
		<cfinvokeargument name="gridsortcolumn" value="" />
		<cfinvokeargument name="gridsortdirection" value="ASC" />			
	</cfinvoke>
	<cfdump var="#test#">
</cfif>


<cfform name="legalMatterViolationsGridForm">
	
	<cfgrid 
		name="legalMatterViolationsGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.getViolationByIdLegalMatter({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},getIdLegalMatter())" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		stripeRows="true"
		pagesize="5">

			<cfgridcolumn name="thisDate" header="Date" width="50">
			<cfgridcolumn name="thisUser" header="By" width="100">
			<cfgridcolumn name="legalMatterViolationComment" header="Comment" width="200">
			<cfgridcolumn name="thisViolationName" header="Violation" width="285">
			<cfgridcolumn name="actions" header="Actions" width="100" dataAlign="Center" >
	</cfgrid>
</cfform>