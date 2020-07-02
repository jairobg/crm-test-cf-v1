<cfcomponent>

	<!--------------------------------------------------------------------------------------------------->
	<!--- Agregar nuevo file --->
	
	<cffunction name="addFile" access="public">
	
		<cfargument name="firstName" required="true" type="string">
		<cfargument name="initial" required="false" type="string" default="">
		<cfargument name="lastName" required="true" type="string">
		<cfargument name="homePhone" required="false" type="string" default="">
		<cfargument name="businessPhone" required="false" type="string" default="">
		<cfargument name="cellPhone" required="false" type="string" default="">
		<cfargument name="email" required="false" type="string">
		<cfargument name="dateBirth" required="false" type="string" default="">
		<cfargument name="socialSecurity" required="false" type="string" default="" >
		<cfargument name="address" required="false" type="string" default="">
		<cfargument name="city" required="false" type="string" default="">
		<cfargument name="idState" required="false" type="string" default="">
		<cfargument name="zip" required="false" type="string">
		<cfargument name="idFileStatus" required="true" type="numeric">
		<cfargument name="scFirstName" required="false" type="string" default="">
		<cfargument name="scInitial" required="false" type="string" default="">
		<cfargument name="scLastName" required="false" type="string">
		<cfargument name="scHomePhone" required="false" type="string" default="">
		<cfargument name="scDateBirth" required="false" type="string" default="">
		<cfargument name="scSocialSecurity" required="false" type="string">
		<cfargument name="scAddress" required="false" type="string" default="">
		<cfargument name="scCity" required="false" type="string" default="">
		<cfargument name="scState" required="false" type="string">
		<cfargument name="scZip" required="false" type="string">

		<!--- Encriptar socialsecurity numbers --->
        <cfif arguments.socialSecurity NEQ "" >
			<cfscript>
                encryptedSS = encrypt(arguments.socialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
            </cfscript>
        <cfelse>
        	<cfscript>
                encryptedSS = "";
            </cfscript>
        </cfif>
         
        <cfif arguments.scSocialSecurity NEQ "" >  
        	<cfscript>
                encryptedScSS = encrypt(arguments.scSocialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
            </cfscript>
        <cfelse>
        	<cfscript>
                encryptedScSS = "";
            </cfscript>
        </cfif>
        
		<cfset encryptedSS = #replace(encryptedSS, "\", "\\", "all")#>
		<cfset encryptedScSS = #replace(encryptedScSS, "\", "\\", "all")#>        
        
		<cfquery name="addFileQuery" dataSource="#APPLICATION.db#" result="addFileQueryResult">
		
        
        <!--- iniciar transaction --->
        
        <!--- BEGIN TRANSACTION  --->
        
		INSERT INTO file
			(
			firstName,
			initial,
			lastName,
			homePhone,
			businessPhone,
			cellPhone,
			email,
			dateBirth,
			socialSecurity,
			address,
			city,
			idState,
			zip,
			idFileStatus,
			scFirstName,
			scInitial,
			scLastName,
			scHomePhone,
			scDateBirth,
			scSocialSecurity,
			scAddress,
			scCity,
			scState,
			scZip,
			idUser,
			maritalStatus,
			scMaritalStatus,
			scEmail,
			scBusinessPhone,
			scCellPhone,
			
			affiliateCompanyId
			)
		VALUES
			(
			'#arguments.firstName#',
			'#arguments.initial#',
			'#arguments.lastName#',
			'#arguments.homePhone#',
			'#arguments.businessPhone#',
			'#arguments.cellPhone#',
			'#arguments.email#',
			<cfif arguments.dateBirth EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.dateBirth, "yyyy/mm/dd")#'</cfif>,
			<!---<cfqueryparam value="#encryptedSS#" CFSQLType="CF_SQL_VARCHAR">,--->
			<cfqueryparam value="#arguments.socialSecurity#" CFSQLType="CF_SQL_VARCHAR">,
			'#arguments.address#',
			'#arguments.city#',
			<cfif arguments.idState EQ "">NULL<cfelse>'#arguments.idState#'</cfif>,
			'#arguments.zip#',
			<!--- '#arguments.idFileStatus#',  Reemplazado por el valor por defecto del Status nuevo (1) en tabla fileStatus--->
            <cfif SESSION.userIdProfile EQ 7>13<cfelse>1</cfif>,
			'#arguments.scFirstName#',
			'#arguments.scInitial#',
			'#arguments.scLastName#',
			'#arguments.scHomePhone#',
			<cfif arguments.scDateBirth EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.scDateBirth, "yyyy/mm/dd")#'</cfif>,
			<!---<cfqueryparam value="#encryptedScSS#" CFSQLType="CF_SQL_VARCHAR">,--->
			<cfqueryparam value="#arguments.scSocialSecurity#" CFSQLType="CF_SQL_VARCHAR">,
			'#arguments.scAddress#',
			'#arguments.scCity#',
			<cfif arguments.scState EQ "">NULL<cfelse>'#arguments.scState#'</cfif>,
			'#arguments.scZip#',
			#SESSION.userId#,
			'#arguments.maritalStatus#',
			'#arguments.scMaritalStatus#',
			'#arguments.scEmail#',
			'#arguments.scBusinessPhone#',
			'#arguments.scCellPhone#',
			#SESSION.affiliateCompanyId#
			 )
                         
		</cfquery>
	
		<cfset thisIdFile = addFileQueryResult.generatedKey >
		
        <cfquery name="addFileLogQuery" datasource="#APPLICATION.db#" >
        	 <!--- agregar FileLog --->
             INSERT INTO fileLog (idFile, idUser, idFileStatus)
			      VALUES (
						#thisIdFile#,
						'#SESSION.userid#',
						<cfif SESSION.userIdProfile EQ 7>13<cfelse>1</cfif>
						)			 		 		        
        </cfquery>
        
        <!---- Update session, selected user and send to edit user --->
		<cfset SESSION.idFile = #thisIdFile#>
  	
	</cffunction>


	<!--------------------------------------------------------------------------------------------------->
	<!--- Editar file --->


	<cffunction name="editFile" access="public">
	
		<cfargument name="firstName" required="true" type="string">
		<cfargument name="initial" required="false" type="string" default="">
		<cfargument name="lastName" required="true" type="string">
		<cfargument name="homePhone" required="false" type="string" default="">
		<cfargument name="businessPhone" required="false" type="string" default="">
		<cfargument name="cellPhone" required="false" type="string" default="">
		<cfargument name="email" required="false" type="string">
		<cfargument name="dateBirth" required="false" type="string" default="">
		<cfargument name="socialSecurity" required="false" type="string">
		<cfargument name="address" required="false" type="string" default="">
		<cfargument name="city" required="false" type="string" default="">
		<cfargument name="idState" required="false" type="string">
		<cfargument name="zip" required="false" type="string">
		<cfargument name="scFirstName" required="false" type="string" default="">
		<cfargument name="scInitial" required="false" type="string" default="">
		<cfargument name="scLastName" required="false" type="string">
		<cfargument name="scHomePhone" required="false" type="string" default="">
		<cfargument name="scDateBirth" required="false" type="string" default="">
		<cfargument name="scSocialSecurity" required="false" type="string">
		<cfargument name="scAddress" required="false" type="string" default="">
		<cfargument name="scCity" required="false" type="string" default="">
		<cfargument name="scState" required="false" type="string">
		<cfargument name="scZip" required="false" type="string">



		<!--- Encriptar socialsecurity numbers --->
		<!---
        <cfif arguments.socialSecurity NEQ "" >
			<cfscript>
                encryptedSS = encrypt(arguments.socialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
            </cfscript>
        <cfelse>
        	<cfscript>
                encryptedSS = "";
            </cfscript>
        </cfif>
         
        <cfif arguments.scSocialSecurity NEQ "" >  
        	<cfscript>
                encryptedScSS = encrypt(arguments.scSocialSecurity,APPLICATION.codeKey,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
            </cfscript>
        <cfelse>
        	<cfscript>
                encryptedScSS = "";
            </cfscript>
        </cfif>
		
		<cfset encryptedSS = #replace(encryptedSS, "\", "\\", "all")#>
		<cfset encryptedScSS = #replace(encryptedScSS, "\", "\\", "all")#>
		--->
		
		
		<cfquery name="editFileQuery" dataSource="#APPLICATION.db#">
		
		UPDATE file
		SET
			firstName = '#arguments.firstName#',
			initial = '#arguments.initial#',
			lastName = '#arguments.lastName#',
			homePhone = '#arguments.homePhone#',
			businessPhone = '#arguments.businessPhone#',
			cellPhone = '#arguments.cellPhone#',
			email = '#arguments.email#',
			dateBirth = <cfif arguments.dateBirth EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.dateBirth, "yyyy/mm/dd")#'</cfif>,
			socialSecurity = '#arguments.socialSecurity#',
			address = '#arguments.address#',
			city = '#arguments.city#',
			idState = <cfif arguments.idState EQ "">NULL<cfelse>'#arguments.idState#'</cfif>,
			zip = '#arguments.zip#',
			scFirstName = '#arguments.scFirstName#',
			scInitial = '#arguments.scInitial#',
			scLastName = '#arguments.scLastName#',
			scHomePhone = '#arguments.scHomePhone#',
			scDateBirth = <cfif arguments.scDateBirth EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.scDateBirth, "yyyy/mm/dd")#'</cfif>,
			scSocialSecurity = '#arguments.scSocialSecurity#',
			scAddress = '#arguments.scAddress#',
			scCity = '#arguments.scCity#',
			scState = <cfif arguments.scState EQ "">NULL<cfelse>'#arguments.scState#'</cfif>,
			scZip = '#arguments.scZip#',
			maritalStatus = '#arguments.maritalStatus#',
			scMaritalStatus = '#arguments.scMaritalStatus#',
			scEmail = '#arguments.scEmail#',
			scBusinessPhone = '#arguments.scBusinessPhone#',
			scCellPhone = '#arguments.scCellPhone#',
			<cfif arguments.clientStatus EQ "Working">
			fileOwner = #SESSION.userId#,			
			</cfif>
			debtorId = '#arguments.debtorId#',
			clientStatus = '#arguments.clientStatus#',
			retainerStatus = '#arguments.retainerStatus#'			
		WHERE
		
			idFile = #SESSION.idFile#	
		 
			  		
		</cfquery>
	
		
		<!--- SET date for closed deals --->
		<cfif arguments.clientStatus EQ "Won">
			<cfquery name="setClosedDealDateQuery" dataSource="#APPLICATION.db#">
				UPDATE file SET closedDealDate = IF(ISNULL(closedDealDate),NOW(),NULL)
				WHERE
				idFile = #SESSION.idFile#
			</cfquery>		
		</cfif>
	
	</cffunction>


	<!--------------------------------------------------------------------------------------------------->
	<!--- Borrar file --->


	<cffunction name="deleteFile" access="public">
	
		<cfargument name="idFile" required="true" type="numeric">
		
		<cfquery name="deleteFileQuery" dataSource="#APPLICATION.db#">
			DELETE FROM file
			WHERE
				idFile = #arguments.idFile#
		</cfquery>
		
	
	</cffunction>
    
    
    <!-------------------------------------------------------------------------------------------------->
	
    <cffunction name="fileExists" access="public" returntype="numeric">
    	<cfargument name="idFile" type="numeric" required="yes">
        
    	<cfquery name="fileExistsQuery" datasource="#APPLICATION.db#" > 
        	SELECT * 
              FROM file
             WHERE IdFile = #arguments.idFile#
        </cfquery>
        
        <cfif fileExistsQuery.recordCount GT 0 >
		    <cfset exists = 1 >
		<cfelse>
	        <cfset exists = 0 >	
		</cfif>
		
        <cfreturn exists >

    </cffunction>


	<!--------------------------------------------------------------------------------------------------->

	<cffunction name="getFileById" access="public" returnType="query">
	
		<cfargument name="idFile" required="true" type="numeric">
		
		<cfquery name="getFileByIdQuery" dataSource="#APPLICATION.db#">
			SELECT *, state.name AS state1, s.name AS state2
			FROM 
				file LEFT JOIN state ON file.idState = state.idState
					LEFT JOIN state s ON file.scstate = s.idState
			WHERE
				idFile = #arguments.idFile#
		</cfquery>
		
		<cfreturn getFileByIdQuery>
	
	</cffunction>
    
	<!--------------------------------------------------------------------------------------------------->

	<cffunction name="getAllFileStatus" access="public" returnType="query">
	
		<cfquery name="getAllFileStatusQuery" dataSource="#APPLICATION.db#">
			SELECT *
			FROM fileStatus
			WHERE
				1=1
				<cfif SESSION.userIdProfile EQ 7>
				AND
				idFileStatus IN (13,14)
				</cfif>
		</cfquery>
		
		<cfreturn getAllFileStatusQuery>
	
	</cffunction>
    
	<!--------------------------------------------------------------------------------------------------->

	<cffunction name="changeFileStatus" access="public" returnType="string">
	
		<cfargument name="flowControlSelect" type="numeric" required="true">
		<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
		<cfargument name="idUser" type="numeric" required="false" default="#SESSION.userId#">
	
		<cfset datatime = CREATEODBCDATETIME( Now() ) />
	
		<cfquery name="changeFileStatusQuery" dataSource="#APPLICATION.db#">
			UPDATE file
			SET
				idFileStatus = #arguments.flowControlSelect#
				<cfif arguments.flowControlSelect EQ 15>
					, cancelDate = <cfqueryparam value="#datatime#" cfsqltype="cf_sql_timestamp">
				</cfif>
			WHERE
				idFile = #arguments.idFile#	
		</cfquery>
		
		
		<!--- Crear log de la transaction --->
		
		<cfquery name="changeFileStatusLogQuery" datasource="#APPLICATION.db#" >
        	 <!--- agregar FileLog --->
             INSERT INTO fileLog (idFile, idUser, idFileStatus)
			      VALUES (
						#arguments.idFile#,
						'#arguments.idUser#',
						#arguments.flowControlSelect#
						)			 		 		        
        </cfquery>
        
        <!---- Crear history note --->
        <cfquery name="getNewStatus" dataSource="#APPLICATION.db#">
        	SELECT 
        		name
        	FROM 
        		fileStatus
        	WHERE
        		idFileStatus = #arguments.flowControlSelect#
        </cfquery>
        
        
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
			49,
			'Flow Change to #getNewStatus.name#',
			'Flow change to #getNewStatus.name#',
			#arguments.idUser#
			)
	
		</cfquery>
		
	</cffunction>


	<!--------------------------------------------------------------------------------------------------->

	<cffunction name="getFileCompany" access="public" returnType="query">
	
		<cfargument name="idFile" required="true" type="numeric">
		
		<cfquery name="getFileCompanyQuery" dataSource="#APPLICATION.db#">
			SELECT affiliateCompany.affiliateCompanyName
			FROM 
				affiliateCompany 
				LEFT JOIN file 
					ON file.affiliateCompanyId = affiliateCompany.affiliateCompanyId
			WHERE
				file.idFile = #arguments.idFile#
		</cfquery>
		
		<cfreturn getFileCompanyQuery>
	
	</cffunction>
    
    
	<!--------------------------------------------------------------------------------------------------->

	<cffunction name="saveFileOwner" access="public" returnType="any" description="Cuando no se a guardado al enviar el retainer">
	
		<cfquery name="saveFileOwnerQuery" dataSource="#APPLICATION.db#">
			UPDATE file SET fileOwner = IF(fileOwner = 0,#SESSION.userId#,fileOwner)
			WHERE idFile = #SESSION.idFile#
		</cfquery>
			
		<cfquery name="setClosedDealDateQuery" dataSource="#APPLICATION.db#">
			UPDATE file SET closedDealDate = IF(ISNULL(closedDealDate),NOW(),NULL)
			WHERE
			idFile = #SESSION.idFile#
		</cfquery>		

	</cffunction>    



</cfcomponent>