<cfcomponent>

<cffunction name="search" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">
	
	<cfargument name="searchedWord" required="false" type="string" default="">
	<cfargument name="clientStatus" required="false" type="string" default="">
	
	

	<cfquery name="searchQuery" dataSource="#APPLICATION.db#">
		SELECT 
			file.idFile,
			file.firstName,
			file.initial,
			file.lastName,
			file.email,
			fileStatus.name AS statusName,
			'' AS totalCreditors,
			state.abbreviation AS thisState,
			file.clientStatus,
			CASE 
				WHEN DATEDIFF(CURDATE(),lastPaymentDate) <= 30
        			THEN '<img src="/template/images/greenDot20.png" width="16">'
				WHEN DATEDIFF(CURDATE(),lastPaymentDate) > 30 AND DATEDIFF(CURDATE(),lastPaymentDate) <= 60
        			THEN '<img src="/template/images/yellowDot20.png" width="16">'
				WHEN DATEDIFF(CURDATE(),lastPaymentDate) > 60 AND DATEDIFF(CURDATE(),lastPaymentDate) <= 4000
					THEN '<img src="/template/images/redDot20.png" width="16">'
        		ELSE '-'
        	END AS fileColor,
        	MAX(DATE_FORMAT(history.timestamp,"%m/%d/%Y %k:%i")) AS historyLastInsert,			
			<cfif SESSION.userIdProfile EQ 7 OR SESSION.userIdProfile EQ 8>
				IF(file.idFileStatus = 13 OR file.idFileStatus = 14, CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="selectFile(',CAST(file.idFile AS CHAR),');">'), '-') AS Edit
			<cfelse>
				CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="selectFile(',CAST(file.idFile AS CHAR),');">') AS Edit
			</cfif>
		FROM file 
			INNER JOIN fileStatus ON file.idFileStatus = fileStatus.idFileStatus
			INNER JOIN fileLog ON file.idFile = fileLog.idFile
			LEFT JOIN state ON file.idState = state.idState 
			LEFT JOIN debtHolder ON debtHolder.idFile = file.idFile
			LEFT JOIN history ON history.idFile = file.idFile
		WHERE
		1=1
		<cfif arguments.clientStatus NEQ "">
		AND
			clientStatus = '#arguments.clientStatus#'
		</cfif>
		
		<cfif arguments.searchedWord NEQ "">
		AND
			(
				firstName LIKE '%#arguments.searchedWord#%'
				OR
				initial LIKE '%#arguments.searchedWord#%'
				OR
				lastName LIKE '%#arguments.searchedWord#%'
				OR
				CONCAT(firstName, ' ', lastName) LIKE '%#arguments.searchedWord#%'
				OR
				file.idFile LIKE '%#arguments.searchedWord#%'
				OR 
				file.email LIKE '%#arguments.searchedWord#%'
				OR
				file.homePhone LIKE '%#arguments.searchedWord#%'
				OR
				file.businessPhone LIKE '%#arguments.searchedWord#%'
				OR
				file.cellPhone LIKE '%#arguments.searchedWord#%'
				
				<!---
				debtHolder.accountNumber LIKE '%#arguments.searchedWord#%'
				OR
				debtHolder.name LIKE '%#arguments.searchedWord#%'
				OR 
				fileStatus.name LIKE '%#arguments.searchedWord#%'
				OR 
				state.name LIKE '%#arguments.searchedWord#%'
				OR 
				state.abbreviation LIKE '%#arguments.searchedWord#%'
				--->
			)
		</cfif>
		<!---- FILTER for Affiliates users ---->
		<cfif SESSION.userIdProfile EQ 7>
		AND
			file.affiliateCompanyId = #SESSION.affiliateCompanyId#

		<cfif SESSION.affiliateCompanyAdmin EQ 0>
		AND 
			(
			file.idFileStatus = 13
			OR 
			file.idFileStatus = 14
			)
		AND
			(
			file.fileOwner = 0
			OR
			file.fileOwner = #SESSION.userId#
			)
		</cfif>
		</cfif>
		
		
		<cfif SESSION.userIdProfile EQ 8>
		AND
			file.affiliateCompanyId IN (SELECT affiliateCompanyId FROM affiliateCompany WHERE superAffiliateId = #SESSION.userId#)	
		</cfif>


		<cfif SESSION.userIdProfile NEQ 1>
		AND	
			file.idFileStatus <> 15
		</cfif>
			GROUP BY file.idFile
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
	</cfquery>
	
	<!--- Count CREDITORS --->
	<cfloop query="searchQuery">
		<cfquery name="countCreditors" dataSource="#APPLICATION.db#">
			SELECT COUNT(*) thisTotal FROM debtHolder WHERE idFile = #idFile# AND type = 'CREDITOR'
		</cfquery>
		<cfset searchQuery["totalCreditors"][searchQuery.currentRow] = countCreditors.thisTotal>
	</cfloop>
	
	<cfreturn queryconvertforgrid(searchQuery,page,pagesize)/>

</cffunction>


<cffunction name="getUserTasks" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">
	
	<cfargument name="thisUser" required="false" default="#SESSION.userId#">
	
	<cfquery name="getUserTasksQuery" dataSource="#APPLICATION.db#">
		SELECT 
			title,
			description,
			DATE_FORMAT(taskStart,'%m/%d/%Y') AS taskStart,
        	CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="editTask(',CAST(task.idTask AS CHAR),');">','&nbsp;&nbsp;<img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteTask(',CAST(task.idTask AS CHAR),');">') AS actions    		
		FROM 
			task
		WHERE
			taskStart >= NOW()
			AND
			idUser = #arguments.thisUser#
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>
			
	</cfquery>

	<cfreturn queryconvertforgrid(getUserTasksQuery,page,pagesize)/>

</cffunction>

</cfcomponent>
