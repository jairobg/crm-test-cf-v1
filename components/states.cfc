<cfcomponent>

<cffunction name="states" access="public" returnType="query">

	<cfquery name="statesQuery" dataSource="#APPLICATION.db#">
		SELECT *
		  FROM state 
      ORDER BY abbreviation
	</cfquery>
	
	<cfreturn statesQuery>

</cffunction>


</cfcomponent>