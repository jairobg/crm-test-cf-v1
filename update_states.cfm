<cfquery name="getAllFilesQuery" dataSource="#APPLICATION.db#">
	SELECT * FROM file_test
</cfquery>



<cfoutput query="getAllFilesQuery">
	
	<cfquery name="getStateIdQuery" dataSource="#APPLICATION.db#">
		SELECT idState FROM state WHERE abbreviation = '#idState_test#'
	</cfquery>
	UPDATE file_test SET idState = #getStateIdQuery.idState# WHERE idFile = #idFile#<br />
	<cfif getStateIdQuery.idState NEQ "">
		<cfquery name="setStateIdQuery" dataSource="#APPLICATION.db#">
			UPDATE file_test SET idState = #getStateIdQuery.idState# WHERE idFile = #idFile#
		</cfquery>
	<cfelse>
		<cfquery name="setStateIdQuery" dataSource="#APPLICATION.db#">
			UPDATE file_test SET idState = NULL WHERE idFile = #idFile#
		</cfquery>	
	</cfif>
</cfoutput>