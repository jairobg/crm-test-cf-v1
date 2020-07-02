<cfcomponent>


<cffunction name="editSettlement" access="public">

	<cfargument name="idSettlement" required="true" type="numeric">
	<cfargument name="financialInstitution" required="false" type="string">
	<cfargument name="routingNumber" required="false" type="string">
	<cfargument name="address" required="false" type="string">
	<cfargument name="city" required="false" type="string">
	<cfargument name="zip" required="false" type="string">
	<cfargument name="currentBalance" required="false" type="string">
	<cfargument name="idState" required="true" type="numeric">

	
	<cfquery name="editSettlementQuery" dataSource="#APPLICATION.db#">
	
		UPDATE
			settlement
		SET
			financialInstitution = '#arguments.financialInstitution#',
			routingNumber = '#arguments.routingNumber#',
			address = '#arguments.address#',
			city = '#arguments.city#',
			zip = '#arguments.zip#',
			idState = #arguments.idState#,
			offerFor = '#arguments.offerFor#',
			offerFrom = '#arguments.offerFrom#',
			offerAmount = '#arguments.offerAmount#',
			offerPercentage = '#arguments.offerPercentage#',
			dateOfferLetter = <cfif arguments.dateOfferLetter EQ "">NULL<cfelse>'#dateFormat(arguments.dateOfferLetter, "yyyy/mm/dd")#'</cfif>,
			dateOfferDue = <cfif arguments.dateOfferDue EQ "">NULL<cfelse>'#dateFormat(arguments.dateOfferDue, "yyyy/mm/dd")#'</cfif>,
			idDebtHolder = #arguments.idDebtHolder#,
			accept = #arguments.accept#
		WHERE
			idSettlement = #arguments.idSettlement#
			
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="addSettlement" access="public">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	<cfargument name="financialInstitution" required="false" type="string">
	<cfargument name="routingNumber" required="false" type="string">
	<cfargument name="address" required="false" type="string">
	<cfargument name="city" required="false" type="string">
	<cfargument name="zip" required="false" type="string">
	<cfargument name="idState" required="true" type="numeric">

	
	<cfquery name="addSettlementQuery" dataSource="#APPLICATION.db#">
	
		INSERT INTO
			settlement
			(
			idFile,
			financialInstitution,
			routingNumber,
			address,
			city,
			zip,
			idState,
			offerFor,
			offerFrom,
			offerAmount,
			offerPercentage,
			dateOfferLetter,
			dateOfferDue,
			idDebtHolder,
			accept
			)
		VALUES
			(
			#arguments.idFile#,
			'#arguments.financialInstitution#',
			'#arguments.routingNumber#',
			'#arguments.address#',
			'#arguments.city#',
			'#arguments.zip#',
			#arguments.idState#,
			'#arguments.offerFor#',
			'#arguments.offerFrom#',
			'#arguments.offerAmount#',
			'#arguments.offerPercentage#',
			<cfif arguments.dateOfferLetter EQ "">NULL<cfelse>'#dateFormat(arguments.dateOfferLetter, "yyyy/mm/dd")#'</cfif>,
			<cfif arguments.dateOfferDue EQ "">NULL<cfelse>'#dateFormat(arguments.dateOfferDue, "yyyy/mm/dd")#'</cfif>,
			#arguments.idDebtHolder#,
			#arguments.accept#
			)
	
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getSettlementByIdFile" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	
	<cfquery name="getSettlementByIdFileQuery" dataSource="#APPLICATION.db#">
	
		SELECT
			settlement.idSettlement,
			settlement.financialInstitution,
			settlement.routingNumber,
			settlement.address,
			settlement.city,
			settlement.zip,
			settlement.currentBalance,
			settlement.idState,
			state.name,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editSettlement(\'',CAST(idSettlement AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteSettlement(\'',CAST(idSettlement AS CHAR),'\',\'',CAST(financialInstitution AS CHAR),'\');">') AS Actions	

		FROM
			settlement, state
		WHERE
			settlement.idState = state.idState
			AND
			idFile = #arguments.idFile#
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
			
	
	</cfquery>

	<cfreturn queryconvertforgrid(getSettlementByIdFileQuery,page,pagesize)/>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="deleteSettlement" access="public">

	<cfargument name="idSettlement" type="numeric" required="true">
	
	<cfquery name="deleteSettlementQuery" dataSource="#APPLICATION.db#">
		DELETE
		FROM 
			settlement
		WHERE
			idSettlement = #arguments.idSettlement#
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getSettlementById" access="public" returnType="query">

	<cfargument name="idSettlement" type="numeric" required="true">
	
	<cfquery name="getSettlementByIdQuery" dataSource="#APPLICATION.db#">
		SELECT 
			*
		FROM 
			settlement
		WHERE
			idSettlement = #arguments.idSettlement#
	</cfquery>

	<cfreturn getSettlementByIdQuery>

</cffunction>

</cfcomponent>