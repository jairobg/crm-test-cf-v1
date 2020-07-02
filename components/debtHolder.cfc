<cfcomponent>

<!------------------------------------------------------------------------------>

<cffunction name="getHolder" access="public" returnType="query">

	<cfargument name="thisType" required="false" type="string" default="" hint="CREDITOR, COLLECTOR, Si no llega o llega en blanco devuelve todos">
	
	<cfquery name="getHolderQuery" dataSource="#APPLICATION.db#">
		SELECT
			idDebtHolder,
			name,
			accountNumber,
			balance,
			notes,
			type,
			CONCAT(name,'-',accountNumber) AS nameAccount
		FROM
			debtHolder
		WHERE
			<cfif arguments.thisType NEQ "">
			type = '#arguments.thisType#'
			AND
			</cfif>
			idFile = #SESSION.idFile#
	</cfquery>

	<cfreturn getHolderQuery>
	
</cffunction>


<!------------------------------------------------------------------------------>

<cffunction name="getHolderCreditorForGrid" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfquery name="getHolderCreditorForGrid" dataSource="#APPLICATION.db#">
		SELECT
			ref,
			name,
			accountNumber,
			balance,
			CONCAT('$',FORMAT(balance,2)) AS formatedBalance,
			notes,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editCreditor(\'',CAST(idDebtHolder AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete"  src="/template/images/delete-icon.png" onclick="deleteDebtHolder(\'',CAST(idDebtHolder AS CHAR),'\',\'',CAST(name AS CHAR),'\',\'Creditor\');">') AS Edit
		FROM
			debtHolder
		WHERE
			type = 'CREDITOR'
			AND
			idFile = #SESSION.idFile#
		
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
			
	</cfquery>

	<cfreturn queryconvertforgrid(getHolderCreditorForGrid,page,pagesize)/>
	
</cffunction>


<!------------------------------------------------------------------------------>

<cffunction name="getHolderCollectorForGrid" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">
	
	<cfquery name="getHolderCollectorForGridQuery" dataSource="#APPLICATION.db#">
		SELECT
			ref,
			name,
			accountNumber,
			balance,
			CONCAT('$',FORMAT(balance,2)) AS formatedBalance,
			notes,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editCollector(\'',CAST(idDebtHolder AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteDebtHolder(\'',CAST(idDebtHolder AS CHAR),'\',\'',CAST(name AS CHAR),'\',\'Collector\');">') AS Edit	
		FROM
			debtHolder
		WHERE
			type = 'COLLECTOR'
			AND
			idFile = #SESSION.idFile#
		
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
			
	</cfquery>

	<cfreturn queryconvertforgrid(getHolderCollectorForGridQuery,page,pagesize)/>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="getHolderById" access="public" returnType="query">

	<cfargument name="idDebtHolder" required="true" type="numeric">

	<cfquery name="getHolderByIdQuery" dataSource="#APPLICATION.db#">
		SELECT
			debtHolder.ref,
			debtHolder.idDebtHolder,
			debtHolder.idFile,
			debtHolder.name,
			debtHolder.accountNumber,
			debtHolder.balance,
			debtHolder.notes,
			debtHolder.type,
			debtHolder.address,
			debtHolder.city,
			debtHolder.zip,
			IFNULL(debtHolder.idState,0) AS idState,
			state.name AS debtHolderState,
			debtHolder.typeOfDebt
		FROM
			debtHolder LEFT JOIN state ON debtHolder.idState = state.idState
		WHERE
			idDebtHolder = '#arguments.idDebtHolder#'
	</cfquery>

	<cfreturn getHolderByIdQuery>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="addHolder" access="public" returnType="string">
	
	<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
	<cfargument name="name" type="string" required="true">
	<cfargument name="accountNumber" type="string" required="true">
	<cfargument name="balance" type="string" required="true">
	<cfargument name="notes" type="string" required="false" default="">
	<cfargument name="type" type="string" required="true">
	<cfargument name="address" type="string" required="false" default="">
	<cfargument name="city" type="string" required="false" default="">
	<cfargument name="zip" type="string" required="false" default="">
	<cfargument name="idState" required="false" default="">
	<cfargument name="typeOfDebt" required="false" default="">
	
	<cfset message = "">
	
	 
	<cfquery name="addHolderQuery" dataSource="#APPLICATION.db#">
		INSERT INTO
			debtHolder
		(
		idFile,
		name,
		accountNumber,
		balance,
		notes,
		type,
		address,
		city,
		zip,
		idState,
		typeOfDebt,
		ref
		)
		VALUES
		(
		#arguments.idFile#,
		'#arguments.name#',
		'#arguments.accountNumber#',
		#rereplace(arguments.balance, "[^0-9|.]", "", "all")#,
		'#arguments.notes#',
		'#arguments.type#',
		'#arguments.address#',
		'#arguments.city#',
		'#arguments.zip#',
		<cfif arguments.idState EQ "">NULL<cfelse>#arguments.idState#</cfif>,
		'#arguments.typeOfDebt#',
		'#arguments.ref#'
		)
	</cfquery>
		
	<cfreturn message>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="editHolder" access="public" returnType="string">
	
	<cfargument name="idDebtHolder" required="true" type="numeric">
	<cfargument name="name" type="string" required="true">
	<cfargument name="accountNumber" type="string" required="true">
	<cfargument name="balance" type="string" required="true">
	<cfargument name="notes" type="string" required="false" default="">
	<cfargument name="address" type="string" required="false" default="">
	<cfargument name="city" type="string" required="false" default="">
	<cfargument name="zip" type="string" required="false" default="">
	<cfargument name="idState" required="false" default="">
	<cfset message = "">
	
	 
	<cfquery name="editHolderQuery" dataSource="#APPLICATION.db#">
		UPDATE 
			debtHolder
		SET
			ref = '#arguments.ref#',		
			name = '#arguments.name#',
			accountNumber = '#arguments.accountNumber#',
			balance = #rereplace(arguments.balance, "[^0-9|.]", "", "all")#,
			notes = '#arguments.notes#',
			address = '#arguments.address#',
			city = '#arguments.city#',
			zip = '#arguments.zip#',
			idState = <cfif arguments.idState EQ "">NULL<cfelse>#arguments.idState#</cfif>,
			typeOfDebt = '#arguments.typeOfDebt#'
		WHERE
			idDebtHolder = #arguments.idDebtHolder#
	</cfquery>
		
	<cfreturn message>
	
</cffunction>


<!------------------------------------------------------------------------------>

<cffunction name="deleteDebtHolder" access="public" returnType="string">
	
	<cfargument name="idDebtHolder" required="true" type="numeric">
		 
	<cfquery name="deleteDebtHolderQuery" dataSource="#APPLICATION.db#">
		DELETE FROM 
			debtHolder
		WHERE
			idDebtHolder = #arguments.idDebtHolder#
	</cfquery>
		
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="getHolderForLegalMatter" access="public" returnType="query">
	
	<cfquery name="getHolderForLegalMatterQuery" dataSource="#APPLICATION.db#">
		SELECT
			ref,
			idDebtHolder,
			name,
			accountNumber,
			balance,
			notes,
			CONCAT(name, ' ', accountNumber) AS fullName
		FROM
			debtHolder
		WHERE
			idFile = #SESSION.idFile#
	</cfquery>

	<cfreturn getHolderForLegalMatterQuery>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="getHolderForSettlement" access="public" returnType="query">
	
	<cfquery name="getHolderForSettlementQuery" dataSource="#APPLICATION.db#">
		SELECT
			ref,
			idDebtHolder,
			name,
			accountNumber,
			balance,
			notes,
			CONCAT(name, ' ', accountNumber, ' - $', CAST(balance AS CHAR)) AS fullName
		FROM
			debtHolder
		WHERE
			type = 'CREDITOR'
			AND
			idFile = #SESSION.idFile#
	</cfquery>

	<cfreturn getHolderForSettlementQuery>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="findDebthHolderByName" access="remote" returnType="string">

	<cfargument name="search" type="any" required="false" default="">
	
	<cfquery name="findDebthHolderByNameQuery" dataSource="#APPLICATION.db#">
		SELECT
			name
		FROM
			debtHolder
		WHERE
			name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(arguments.search)#%" />
			AND
			address <> ""
			AND
			city <> ""
			AND
			zip <> ""
		GROUP BY
			name
	</cfquery>
	
	<cfreturn valueList(findDebthHolderByNameQuery.name)>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="findDebHolderAddressByName" access="remote" returnType="string">

	<cfargument name="search" type="any" required="false" default="">
	
	<cfquery name="findDebHolderAddressByNameQuery" dataSource="#APPLICATION.db#">
		SELECT
			address
		FROM
			debtHolder
		WHERE
			name = '#arguments.search#'
			AND
			address <> ""
			AND
			city <> ""
			AND
			zip <> ""
	</cfquery>
	
	<cfreturn findDebHolderAddressByNameQuery.address>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="findDebHolderCityByName" access="remote" returnType="string">

	<cfargument name="search" type="any" required="false" default="">
	
	<cfquery name="findDebHolderAddressByNameQuery" dataSource="#APPLICATION.db#">
		SELECT
			city
		FROM
			debtHolder
		WHERE
			name = '#arguments.search#'
			AND
			address <> ""
			AND
			city <> ""
			AND
			zip <> ""
	</cfquery>
	
	<cfreturn findDebHolderAddressByNameQuery.city>
	
</cffunction>

<!------------------------------------------------------------------------------>

<cffunction name="findDebHolderZipByName" access="remote" returnType="string">

	<cfargument name="search" type="any" required="false" default="">
	
	<cfquery name="findDebHolderZipByNameQuery" dataSource="#APPLICATION.db#">
		SELECT
			zip
		FROM
			debtHolder
		WHERE
			name = '#arguments.search#'
			AND
			address <> ""
			AND
			city <> ""
			AND
			zip <> ""
	</cfquery>
	
	<cfreturn findDebHolderZipByNameQuery.zip>
	
</cffunction>



<!------------------------------------------------------------------------------>

<cffunction name="findDebHolderIdStateByName" access="remote" returnType="string">

	<cfargument name="search" type="any" required="false" default="">
	
	<cfquery name="findDebHolderIdStateByNameQuery" dataSource="#APPLICATION.db#">
		SELECT
			idState
		FROM
			debtHolder
		WHERE
			name = '#arguments.search#'
			AND
			address <> ""
			AND
			city <> ""
			AND
			zip <> ""
	</cfquery>
	
	<cfreturn findDebHolderIdStateByNameQuery.idState>
	
</cffunction>
<!------------------------------------------------------------------------------>

<cffunction name="getHolderBalanceById" access="remote" returnType="string">

	<cfargument name="idDebtHolder" required="true" type="numeric">

	<cfquery name="getHolderBalanceByIdQuery" dataSource="#APPLICATION.db#">
		SELECT
			debtHolder.balance
		FROM
			debtHolder
		WHERE
			idDebtHolder = '#arguments.idDebtHolder#'
	</cfquery>
	<cfif arguments.idDebtHolder EQ "">
		<cfreturn "">
	<cfelse>
		<cfreturn getHolderBalanceByIdQuery.balance>
	</cfif>
</cffunction>

</cfcomponent>