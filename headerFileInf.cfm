<cfparam name="URL.idFile" default="">
<cfif URL.idFile NEQ "">

	<cfif URL.idFile NEQ "0">
		<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
			<cfinvokeargument name="idFile" value="#URL.idFile#">
		</cfinvoke>		
		<cfset SESSION.idFile = #thisFileQuery.idFile#>
		<cfset SESSION.fileName = "#thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#">
		<cfset SESSION.idFileStatus = #thisFileQuery.idFileStatus#>
		<cfset SESSION.fileColor = #thisFileQuery.fileColor#>
		<cfset SESSION.source = #thisFileQuery.source#>
		<cfset SESSION.affiliateCompanyId = #thisFileQuery.affiliateCompanyId#>		
	<cfelse>
		<cfset SESSION.idFile = 0>
		<cfset SESSION.fileName = "None">
		<cfset SESSION.idFileStatus = 0>
		<cfset SESSION.fileColor = "">
		<cfset SESSION.source = "">
	</cfif>

	<!---
		Guardar historia de seleccionar usuario
	--->
	<cfinvoke component="components.fileUserHistory" method="saveFileSelectionHistory" returnvariable="last10Clients">


	<script>
		ColdFusion.navigate('flowControl.cfm','flowControlDiv');
	</script>
	
</cfif>

<div id="client-info">
	<cfoutput>
		<h2>current client</h2>
		<cfif #SESSION.idFile# EQ 0>
			<h3 id="select-client">please select a Client from the list</h3>
		<cfelse>
			<h3 id="current-client">
			<cfif SESSION.source NEQ "">
			#SESSION.source# - 
			</cfif>
			<cfinvoke component="components.file" method="getFileCompany" returnVariable="thisFileCompany">
				<cfinvokeargument name="idFile" value="#SESSION.idFile#">
			</cfinvoke>
			#SESSION.idFile# - #SESSION.fileName#
			<cfif thisFileCompany.recordcount NEQ 0>
			<cfloop query="thisFileCompany">
			(From: #affiliateCompanyName#)
			</cfloop>
			</cfif>
			</h3>
		</cfif>
	</cfoutput>
</div>

<script type="text/javascript">
	ColdFusion.navigate('lastTenClients.cfm','lastTenClientsDiv');
</script>

<fieldset>
	<input type="text" name="searchedWordHeader" id="searchedWordHeader" placeholder="enter keyword" value="" onkeypress="return goToSearch(event);">
</fieldset>