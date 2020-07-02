<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<cfif isDefined("FORM.idState")>
	<cfset statesForQuery = FORM.idState />
<cfelse>
	<cfset statesForQuery = 0 />
</cfif>

<cfquery name="reportDownloadDataQuery" dataSource="#APPLICATION.db#">
	SELECT
		file.firstName,
		file.lastName,
		file.dateBirth,
		file.homePhone,
		file.cellPhone,
		file.email,
		CONCAT(file.address, ' ', file.city, ' ', state.abbreviation, ' ', file.zip) AS clientFullAddress,
		file.address,
		file.city,
		state.abbreviation,
		file.zip,
		
		fileStatus.name AS client_status
	FROM file 
		INNER JOIN fileStatus ON file.idFileStatus = fileStatus.idFileStatus
		LEFT JOIN state ON file.idState = state.idState 
	WHERE
	 	file.idState IN (#statesForQuery#)
	 	AND
	 	file.itkTotalDeb IS NOT NULL
				
</cfquery>


<cfset theFile = "reports/reportForMailing#SESSION.userId#.xls" />

<cfspreadsheet action="write" filename="#theFile#" query="reportDownloadDataQuery" overwrite="true" />

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfform name="reportForMailingForm">
	
	<fieldset>
		<legend>Download Data Report</legend>
	</fieldset>

	<fieldset class="col1">
		<ul class="">
		<li>
			<label for="fromDate">Select State:</label> 
			<cfselect name="idState" query="statesQuery" display="name" value="idState" multiple="Yes" selected="#statesForQuery#" >
			</cfselect>		
		</li>
		</ul>
	</fieldset>

	<fieldset class="col2">
		<ul class="">
		<li>

		</li>
		</ul>
	</fieldset>

	<cfif statesForQuery EQ 0>
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Filter States">
	</fieldset>
	</cfif>
	
</cfform>

<cfif statesForQuery NEQ 0>
<cfoutput>
<fieldset class="action-buttons">
	<a class="submitButton" href="reports/reportForMailing#SESSION.userId#.xls" />
		Download Sales Report
	</a>
</fieldset>
</cfoutput>
</cfif>



<cfinclude template="template/footer.cfm">