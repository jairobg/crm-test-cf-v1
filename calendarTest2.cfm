<!---

<cfquery name="getFiles" dataSource="#APPLICATION.db#">
	SELECT idFile, '' AS totalCreditors FROM file
</cfquery>

<cfloop query="getFiles">
	<cfquery name="countCreditors" dataSource="#APPLICATION.db#">
		SELECT COUNT(*) thisTotal FROM debtHolder WHERE idFile = #idFile# AND type = 'CREDITOR'
	</cfquery>
	<cfset getFiles["totalCreditors"][getFiles.currentRow] = countCreditors.thisTotal>
</cfloop>

<cfdump var="#getFiles#">

--->
<cfset encryptedSS = '+*DT-VZO*VM\''9D( '>
<cfset encryptedSS = #replace(encryptedSS, "\", "\\", "all")#>
<cfoutput>#encryptedSS#</cfoutput>