<cfcomponent>


<cffunction name="editLawsuit" access="public">

	<cfargument name="idLawsuit" required="true" type="numeric">
	<cfargument name="plantiff" required="true" type="string">
	<cfargument name="date" required="false" type="string">
	<cfargument name="status" required="false" type="string">
		
	<cfquery name="editLawsuitQuery" dataSource="#APPLICATION.db#">
	
		UPDATE
			lawsuit
		SET
			plantiff = '#arguments.plantiff#',
			date = <cfif arguments.date EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.date, "yyyy/mm/dd")#'</cfif>,
			status = '#arguments.status#'
		WHERE
			idLawsuit = #arguments.idLawsuit#
			
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="addLawsuit" access="public">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	<cfargument name="plantiff" required="true" type="string">
	<cfargument name="date" required="false" type="string">
	<cfargument name="status" required="false" type="string">
		
	<cfquery name="addLawsuitQuery" dataSource="#APPLICATION.db#">
	
		INSERT INTO
			lawsuit
			(
			idFile,
			plantiff,
			date,
			status
			)
		VALUES
			(
			#arguments.idFile#,
			'#arguments.plantiff#',
			<cfif arguments.date EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.date, "yyyy/mm/dd")#'</cfif>,
			'#arguments.status#'
			)
	
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getLawsuitByFileId" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	
	<cfquery name="getLawsuitByFileIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			plantiff,
			DATE_FORMAT(date,'%m/%d/%Y') AS thisDate,
			status,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editLawsuit(\'',CAST(idLawsuit AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteLawsuit(\'',CAST(idLawsuit AS CHAR),'\',\'',CAST(plantiff AS CHAR),'\');">') AS Edit	
		FROM
			lawsuit
		WHERE
			idFile = #arguments.idFile#
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>

	
	</cfquery>

	<cfreturn queryconvertforgrid(getLawsuitByFileIdQuery,page,pagesize)/>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getLawsuitById" access="public" returnType="query">

	<cfargument name="idLawsuit" required="true" type="numeric">
	
	<cfquery name="getLawsuitByIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			*
		FROM
			lawsuit
		WHERE
			idLawsuit = #arguments.idLawsuit#
	
	</cfquery>

	<cfreturn getLawsuitByIdQuery/>

</cffunction>


<!------------------------------------------------------------------>

<cffunction name="deleteLawsuit" access="public" returnType="string">

	<cfargument name="idLawsuit" required="true" type="numeric">
	
	<cfquery name="deleteLawsuitQuery" dataSource="#APPLICATION.db#">
	
		DELETE 
		FROM
			lawsuit
		WHERE
			idLawsuit = #arguments.idLawsuit#
	
	</cfquery>


</cffunction>

</cfcomponent>