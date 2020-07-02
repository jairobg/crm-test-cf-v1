<cfcomponent>

<cffunction name="list" access="public" returnType="query">

	<cfquery name="listQuery" dataSource="#APPLICATION.db#">
		SELECT *
		  FROM profile
	</cfquery>
	
	<cfreturn listQuery>

</cffunction>


</cfcomponent>