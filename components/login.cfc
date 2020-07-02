<cfcomponent>

<cffunction name="login" access="public" returnType="string">

	<cfargument name="userName" type="string" required="true">
	<cfargument name="password" type="string" required="true">
	
	<cfset messageCDLG = "">

	<cfquery name="loginQuery" dataSource="#APPLICATION.db#">
		SELECT *
		FROM
			user
		WHERE
			userName = '#arguments.userName#'
	</cfquery>

	<cfif loginQuery.recordCount NEQ 0>
		
		<!--- Si la cuenta es de google --->
		<cfif loginQuery.isGoogleAccount EQ 1>
		
			<!--- Verificar autenticacion en google --->
			<cftry>
			
			<cfinvoke component="components.google" method="authenticate">
				<cfinvokeargument name="username" value="#arguments.userName#">
				<cfinvokeargument name="password" value="#arguments.password#">
			</cfinvoke>
			
			<cfcatch type="Any">
				<cfset messageCDLG = "Invalid user name or password.<br>#cfcatch.message#">
			</cfcatch>		
				
			</cftry>
		
			<cfif messageCDLG EQ "">
			
				<!--- Guardar el password del usuario en la base de datos --->
				<!--- El key especifico de cada usuario para encriptar es el userName --->
				<cfscript>
					encryptedPassword = encrypt(arguments.password,arguments.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
				</cfscript>
				<cfset encryptedPassword = #replace(encryptedPassword, "\", "\\", "all")#>
	
				
				<cfquery name="saveUserPassword" dataSource="#APPLICATION.db#">
					UPDATE user 
					SET
						password = <cfqueryparam value="#encryptedPassword#" CFSQLType="CF_SQL_VARCHAR">
					WHERE
						userName = '#arguments.userName#'
				</cfquery>
		
		
				<!---- Verifica si tiene el idCalendar del Calendarion CRMLEX de Google si no lo crea --->
				<cfif loginQuery.idCalendar EQ "">
					<!--- Conectarse a google--->
					<cfset gCal = createObject("components.GoogleCalendar").init(arguments.userName,arguments.password,-5)>
					
					<cfset calendars = gCal.getCalendars()>
		
					<cfquery name="searchCalendarId" dbtype="query">
						SELECT ID
						FROM calendars
						WHERE Title = 'CRMLEX'
					</cfquery>
					
					<cfif searchCalendarId.recordCount NEQ 0>
						<cfset thisCalendarId = "#searchCalendarId.ID#">
					<cfelse>
						<cfset newCalendar = gCal.addCalendar(title = "CRMLEX", description = "CRMLEX Calendar")>
						
						<cfset calendars = gCal.getCalendars()>
			
						<cfquery name="searchCalendarId2" dbtype="query">
							SELECT ID
							FROM calendars
							WHERE Title = 'CRMLEX'
						</cfquery>
		
						<cfset thisCalendarId = '#searchCalendarId2.ID#'>
						
					</cfif>
					
					<!--- Guardar Calendar Id --->
					<cfquery name="saveCalendarId" dataSource="#APPLICATION.db#">
						UPDATE user 
						SET
							idCalendar = '#thisCalendarId#'
						WHERE
							idUser = #loginQuery.idUser#
					</cfquery>
					
				</cfif>
			</cfif>
	
		<!--- Si la cuenta no es de google --->
		<cfelse>
		
			<cfif arguments.password NEQ loginQuery.password>
				<cfset messageCDLG = "Invalid password.">	
			</cfif>
		
		</cfif>

		
		<!--- Crea la session --->
		<cfif messageCDLG EQ "">
			<cfset SESSION.userName = "#loginQuery.firstName# #loginQuery.middleName# #loginQuery.lastName#">
			<cfset SESSION.userId = #loginQuery.idUser#>
			<cfset SESSION.userIdProfile = #loginQuery.idProfile#>
			<cfset SESSION.userEmail = #loginQuery.userName#>
			<cfset SESSION.isGoogleAccount = #loginQuery.isGoogleAccount#>

			<cfset SESSION.idFile = 0>
			<cfset SESSION.fileName = "None">
			<cfset SESSION.idFileStatus = 0>
			

			<!--- Se verifica la empresa del Affiliate y administrador --->
			<cfif loginQuery.idProfile EQ 7>
				<cfquery name="getAffiliateCompanyIdQuery" dataSource="#APPLICATION.db#">
					SELECT affiliateCompanyId FROM userAffiliateCompany
					WHERE idUser = #loginQuery.idUser#	
				</cfquery>
				
				<cfset SESSION.affiliateCompanyId = #getAffiliateCompanyIdQuery.affiliateCompanyId#>
				
				
				<!--- Verifica que sea administrador --->


				<cfquery name="getAffiliateCompanyUserAdmin" dataSource="#APPLICATION.db#" result="getAffiliateCompanyUserAdminResult">
					SELECT affiliateCompanyAdmin FROM userAffiliateCompany
					WHERE idUser = #SESSION.userId#
				</cfquery>
				
				<cfif getAffiliateCompanyUserAdminResult.RecordCount EQ 0>
					<cfset SESSION.affiliateCompanyAdmin = 0>
				<cfelse>
					<cfset SESSION.affiliateCompanyAdmin = #getAffiliateCompanyUserAdmin.affiliateCompanyAdmin#>				
				</cfif>



				<!---

				<cfquery name="getAffiliateCompanyUserAdmin" dataSource="#APPLICATION.db#" result="getAffiliateCompanyUserAdminResult">
					SELECT idUser FROM userAffiliateCompany
					WHERE idUser IN (SELECT idUser FROM userAffiliateCompany WHERE affiliateCompanyId = #getAffiliateCompanyIdQuery.affiliateCompanyId#)
				</cfquery>
				<cfif getAffiliateCompanyUserAdminResult.RecordCount NEQ 0>
					<cfset SESSION.affiliateCompanyAdmin = 1>
				<cfelse>
					<cfset SESSION.affiliateCompanyAdmin = 0>				
				</cfif>
				--->
				
			<cfelse>
				<cfset SESSION.affiliateCompanyId = 0>
				<cfset SESSION.affiliateCompanyAdmin = 0>
			</cfif>

			<cfinvoke component="components.login" method="profileDefiniton">
				<cfinvokeargument name="idProfile" value="#loginQuery.idProfile#">
			</cfinvoke>
		</cfif>



	
	<!--- Si no encuentra el registro de usuario en la db --->		
	<cfelse>
		<cfset messageCDLG = "User not registered or misspelled">
	</cfif>
	

	<cfreturn messageCDLG>

</cffunction>

<!-------------------------------------------------------------------------------------------------------->

<cffunction name="profileDefiniton" access="public">

	<cfargument name="idProfile" type="numeric" required="true">
	
	<cfquery name="profileDefinitonQuery" dataSource="#APPLICATION.db#">
		SELECT 
			idProfile,
			name
		FROM
			profile
		WHERE
			idProfile = #arguments.idProfile#
	</cfquery>
	
	<cfset SESSION.permission = ArrayNew(1)>
	
	<cfswitch expression="#profileDefinitonQuery.idProfile#">
		
		<cfcase value="1">
			<cfset thisProfile = "Administrator">			
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Payment")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Archive")>
			<cfset ArrayAppend(SESSION.permission, "Users")>
			<cfset ArrayAppend(SESSION.permission, "Affiliates")>
			<cfset ArrayAppend(SESSION.permission, "Reports")>
		</cfcase>
	
		<cfcase value="2">
			<cfset thisProfile = "Staff">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Archive")>
		</cfcase>
		
		<cfcase value="4">
			<cfset thisProfile = "Attorneys">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Archive")>			
		</cfcase>

		<cfcase value="6">
			<cfset thisProfile = "Billing">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Payment")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Archive")>			
		</cfcase>
		
		<cfcase value="7">
			<cfset thisProfile = "Affiliates">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>			
			<cfset ArrayAppend(SESSION.permission, "Archive")>
		</cfcase>
		
		<cfcase value="8">
			<cfset thisProfile = "Super Affiliates">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>			
			<cfset ArrayAppend(SESSION.permission, "Archive")>
		</cfcase>

		<cfcase value="11">
			<cfset thisProfile = "Off Councel">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>	
			<cfset ArrayAppend(SESSION.permission, "Archive")>
		</cfcase>
		
		<cfcase value="12">
			<cfset thisProfile = "Staff2">
			<cfset ArrayAppend(SESSION.permission, "Search")>
			<cfset ArrayAppend(SESSION.permission, "Client")>
			<cfset ArrayAppend(SESSION.permission, "Creditor")>
			<cfset ArrayAppend(SESSION.permission, "Intake")>
			<cfset ArrayAppend(SESSION.permission, "Lawsuits")>
			<cfset ArrayAppend(SESSION.permission, "Settlements")>
			<cfset ArrayAppend(SESSION.permission, "History")>
			<cfset ArrayAppend(SESSION.permission, "LegalMatters")>
			<cfset ArrayAppend(SESSION.permission, "Documents")>
			<cfset ArrayAppend(SESSION.permission, "Tasks")>
			<cfset ArrayAppend(SESSION.permission, "Archive")>
		</cfcase>
		
		
	</cfswitch>
	
	<cfset SESSION.thisProfile = #thisProfile#>
	
	<!--- Redirecciona al search --->
	
	<cflocation url="search.cfm" addToken="no">

</cffunction>

<!-------------------------------------------------------------------------------------------------------->

<cffunction name="logOut" access="public">

	<cfset structClear(SESSION)>
	<cflocation url="index.cfm" addToken="no">

</cffunction>


<!-------------------------------------------------------------------------------------------------------->


</cfcomponent>