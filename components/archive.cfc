<cfcomponent>

<!------------------------------------------------------------------>

<cffunction name="getArchiveByFileId" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	
	<cfquery name="getArchiveByFileIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			idArchive,
			archiveName,
			archiveType,
			DATE_FORMAT(archiveDate,'%m/%d/%Y') AS thisArcheveDate,
			CONCAT('<a href="archive/#SESSION.idFile#/',CAST(archiveFileName AS CHAR),'" target="_blank"><img class="btnDownload" title="Download" src="/template/images/download-icon.png"></a>&nbsp;&nbsp;<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editArchive(\'',CAST(idArchive AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteArchive(\'',CAST(idArchive AS CHAR),'\');">') AS Edit	
		FROM
			archive
		WHERE
			idFile = #arguments.idFile#
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>

	
	</cfquery>

	<cfreturn queryconvertforgrid(getArchiveByFileIdQuery,page,pagesize)/>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="addArchive" access="public">

	<cfargument name="archiveName" default="">
	<cfargument name="archiveDate" default="">
	<cfargument name="archiveType" default="">
	
	<!--- Create file folder --->
	<cfset thisFileDirectory = "#APPLICATION.localPath#/archive/#SESSION.idFile#">
	<cfif NOT DirectoryExists(thisFileDirectory)>
		<cfdirectory action="create" directory="#thisFileDirectory#">
	</cfif>
	
	<!--- Save file --->
	<cffile action="upload" fileField="archive" destination="#thisFileDirectory#/" nameconflict="makeunique">
    <cfset archiveFileName = "#file.serverFile#">
			
	<!--- Save Data --->
	
	<cfquery name="addArchiveQuery" dataSource="#APPLICATION.db#">
		INSERT INTO
			archive 
		(
			idFile,
			archiveName,
			archiveType,
			archiveFileName			
		)
		VALUES
		(
			#SESSION.idFile#,
			"#arguments.archiveName#",
			"#arguments.archiveType#",
			"#archiveFileName#"
		)
	</cfquery>
			
</cffunction>

<!------------------------------------------------------------------>

<cffunction name="editArchive" access="public">

	<cfargument name="archiveName" default="">
	<cfargument name="archiveType" default="">	
	<cfargument name="idArchive" required="true">
	
	<!--- Update Data --->
	
	<cfquery name="editArchiveQuery" dataSource="#APPLICATION.db#">
		UPDATE
			archive 
		SET
			archiveName = "#arguments.archiveName#",
			archiveType = "#arguments.archiveType#"	
		WHERE
			idArchive = #ARGUMENTS.idArchive#	
	</cfquery>
			
</cffunction>

<!------------------------------------------------------------------>

<cffunction name="deleteArchive" access="public">

	<cfargument name="idArchive" required="true">

	<cfquery name="getArchiveFileNameQuery" dataSource="#APPLICATION.db#">
		SELECT archiveFileName
		FROM archive 
		WHERE idArchive = #ARGUMENTS.idArchive#
	</cfquery>

	<!--- Delete file --->
	<cfset thisFileDirectory = "#APPLICATION.localPath#/archive/#SESSION.idFile#">
	<cffile action="delete" file="#thisFileDirectory#/#getArchiveFileNameQuery.archiveFileName#">
	
	<!--- Delete Data --->	
	<cfquery name="deleteArchiveQuery" dataSource="#APPLICATION.db#">
		DELETE FROM
			archive 
		WHERE
			idArchive = #ARGUMENTS.idArchive#	
	</cfquery>
			
</cffunction>


<!------------------------------------------------------------------>

<cffunction name="getArchiveById" access="public" returnType="query">

	<cfargument name="idArchive" required="true">
	
	<cfquery name="getArchiveByIdQuery" dataSource="#APPLICATION.db#">
		SELECT *
		FROM archive 
		WHERE idArchive = #ARGUMENTS.idArchive#
	</cfquery>
	
	<cfreturn getArchiveByIdQuery>
			
</cffunction>

<!------------------------------------------------------------------>

</cfcomponent>