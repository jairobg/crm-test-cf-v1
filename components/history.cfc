<cfcomponent>

<cffunction name="addNote" access="public">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	<cfargument name="idHistoryType" required="true" type="numeric">
	<cfargument name="title" required="true" type="string">
	<cfargument name="detail" required="true" type="string">
	<cfargument name="idUser" required="false" type="numeric" default="#SESSION.userId#">
	
	<cfquery name="addNoteQuery" dataSource="#APPLICATION.db#">
	
		INSERT INTO
			history
			(
			idFile,
			idHistoryType,
			title,
			detail,
			idUser
			)
		VALUES
			(
			#arguments.idFile#,
			#arguments.idHistoryType#,
			'#arguments.title#',
			'#arguments.detail#',
			#arguments.idUser#
			)
	
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getHistoryByFileId" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	
	<cfquery name="getHistoryByUserQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			history.idHistory,
			historyType.name,
			history.title,
			history.detail,
			DATE_FORMAT(history.timestamp,"%m/%d/%Y %k:%i") AS thisDate,
			CONCAT(user.firstName, ' ', lastName) AS thisUserName,
			CONCAT('<img class="btnInfo" title="Info" src="/template/images/info-icon.png" onclick="infoHistory(\'',CAST(idHistory AS CHAR),'\');">') AS Actions				
		FROM
			history, historyType, user
		WHERE
			history.idUser = user.idUser
			AND
			history.idHistoryType = historyType.idHistoryType
			AND
			idFile = #arguments.idFile#

		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
	
	</cfquery>

	<cfreturn queryconvertforgrid(getHistoryByUserQuery,page,pagesize)/>

</cffunction>


<!------------------------------------------------------------------>

<cffunction name="getHistoryType" access="public" returnType="query">
	
	<cfquery name="getHistoryTypeQuery" dataSource="#APPLICATION.db#">
	
		SELECT idHistoryType, name
		FROM
			historyType
		WHERE
			<!--- El id 49 pertenece a flow change que se hace automaticamente y no se debe ingresar manual ---->
			idHistoryType <> 49
	
	</cfquery>

	<cfreturn getHistoryTypeQuery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getHistoryById" access="public" returnType="query">
	
	<cfargument name="idHistory" type="numeric" required="true">
	
	<cfquery name="getHistoryByIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT *
		FROM
			history
		WHERE
			idHistory = #arguments.idHistory#
	
	</cfquery>

	<cfreturn getHistoryByIdQuery>

</cffunction>



</cfcomponent>