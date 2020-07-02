<cfcomponent>


	<cffunction name="getLast10Files" access="public">
	
	<cfquery name="getLast10Files" datasource="#APPLICATION.db#">
		SELECT
			file.idFile,
			CAST(CONCAT(file.idFile, ' - ', file.firstName,  ' ', file.lastName) AS CHAR) AS fullName1
		FROM
			file, fileUserHistory
		WHERE
			file.idFile = fileUserHistory.idFile
			AND
			fileUserHistory.idUser = #SESSION.userId#
		GROUP BY
			file.idFile
		ORDER BY
			fileUserHistoryDateTime DESC
		LIMIT 10
	</cfquery>

	<cfreturn getLast10Files>

	</cffunction>




	<cffunction name="saveFileSelectionHistory" access="public">

		<cfquery name="saveFileSelectionHistory" datasource="#APPLICATION.db#">
			INSERT INTO
				fileUserHistory
			(idUser, idFile)
			VALUES
			(#SESSION.userId#, #SESSION.idFile#)
		</cfquery>

	</cffunction>

</cfcomponent>