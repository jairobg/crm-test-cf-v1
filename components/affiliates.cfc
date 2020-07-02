<cfcomponent>

	<!-------------------------------------------------------------------------------------> 

	<cffunction name="getAllAdminByCompanyIdList" access="public" returntype="any">
	
		<cfargument name="affiliateCompanyId" required="yes">

		<cfquery name="getAllAdminByCompanyIdQuery" dataSource="#APPLICATION.db#">
			SELECT idUser FROM userAffiliateCompany 
			WHERE 
				affiliateCompanyId = #arguments.affiliateCompanyId#
				AND affiliateCompanyAdmin = 1
		</cfquery>
	
		<cfset adminList = ValueList(getAllAdminByCompanyIdQuery.idUser)>
		
	<cfreturn adminList>
	
    </cffunction>
    
	<!-------------------------------------------------------------------------------------> 


	<cffunction name="getAvailableAdminList" access="public" returntype="query">
		
		<cfquery name="getAvailableAdminListQuery" dataSource="#APPLICATION.db#">
			SELECT *, CONCAT(firstName, ' ', lastName) AS fullUserName 
			FROM user INNER JOIN userAffiliateCompany ON user.idUser = userAffiliateCompany.idUser
			WHERE 
				userAffiliateCompany.affiliateCompanyId = #arguments.affiliateCompanyId#
		</cfquery>
	
	<cfreturn getAvailableAdminListQuery>
	
    </cffunction>

	<!-------------------------------------------------------------------------------------> 


	<cffunction name="getSuperAffiliate" access="public" returntype="any">
		
		<cfquery name="getSuperAffiliateQuery" dataSource="#APPLICATION.db#">
			SELECT IFNULL(userName, 'none') AS userName
			FROM user INNER JOIN affiliateCompany ON user.idUser = affiliateCompany.superAffiliateId
			WHERE 
				affiliateCompany.affiliateCompanyId = #SESSION.affiliateCompanyId#
		</cfquery>
	
	<cfreturn getSuperAffiliateQuery.userName>
	
    </cffunction>


    
	<!-------------------------------------------------------------------------------------> 



	<cffunction name="getAvailableSuperAffiliateList" access="public" returntype="query">
		
		<cfquery name="getAvailableSuperAffiliateListQuery" dataSource="#APPLICATION.db#">
			SELECT *, CONCAT(firstName, ' ', lastName) AS fullUserName 
			FROM user
			WHERE 
				idProfile = 8
		</cfquery>
	
	<cfreturn getAvailableSuperAffiliateListQuery>
	
    </cffunction>
    
	<!-------------------------------------------------------------------------------------> 

	<cffunction name="getAffiliatesForGrid" access="remote" returnType="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		
		<cfquery name="getAffiliatesForGridQuery" dataSource="#APPLICATION.db#">
			SELECT
				affiliateCompanyId,
				affiliateCompanyName,
				DATE_FORMAT(affiliateCompanyCreationDate,'%m/%d/%Y') AS affiliateCreationDate,
				CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editAffiliate(',CAST(affiliateCompanyId AS CHAR),');"> <img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteAffiliate(',CAST(affiliateCompanyId AS CHAR),');">') AS actions    		
			FROM 
				affiliateCompany
				
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
				
		</cfquery>
	
		<cfreturn queryconvertforgrid(getAffiliatesForGridQuery,page,pagesize)/>
	
	</cffunction> 


	<!-------------------------------------------------------------------------------------> 


	<cffunction name="saveAffiliateCompany" access="public">
	
		<cfargument name="affiliateCompanyName" type="string" required="true">
		
		<cfquery name="saveAffiliateCompanyQuery" dataSource="#APPLICATION.db#" result="saveAffiliateCompanyQueryResult">
			INSERT INTO affiliateCompany
				(affiliateCompanyName)
				VALUES
				(
				"#arguments.affiliateCompanyName#"
				)
		</cfquery>

		<cfset thisAffiliateCompanyId = saveAffiliateCompanyQueryResult.GENERATED_KEY>
		
	</cffunction>

		
	<!-------------------------------------------------------------------------------------> 


	<cffunction name="updateAffiliateCompany" access="public">
	
		<cfargument name="affiliateCompanyName" type="string" required="true">
		<cfargument name="affiliateCompanyUserAdmin" required="true">
		<cfargument name="affiliateCompanyId" type="numeric" required="true">
		
		
		<cfquery name="updateAffiliateCompanyQuery" dataSource="#APPLICATION.db#">
			UPDATE affiliateCompany
			SET
				affiliateCompanyName = "#arguments.affiliateCompanyName#",
				affiliateCompanyPercent = #arguments.affiliateCompanyPercent#,
				payToId = "#arguments.payToId#",
				totalBrokersFeeToRick = #arguments.totalBrokersFeeToRick#,
				totalBrokersFeeToLawSupport = #arguments.totalBrokersFeeToLawSupport#,
				ramsaranFee = #arguments.ramsaranFee#,
				monthlyMaintenanceAffiliate = #arguments.monthlyMaintenanceAffiliate#,
				monthlyMaintenanceRick = #arguments.monthlyMaintenanceRick#,
				monthlyMaintenanceLawSupport = #arguments.monthlyMaintenanceLawSupport#,
				ramsaranMonthly = #arguments.ramsaranMonthly#,
				superAffiliateId = #arguments.superAffiliateId#
			WHERE
				affiliateCompanyId = #arguments.affiliateCompanyId#
		</cfquery>
		
		<!--- Administrators ADMIN --->
		<cfquery name="cleanAdministratorsQuery" dataSource="#APPLICATION.db#">
			UPDATE userAffiliateCompany SET affiliateCompanyAdmin = 0
			WHERE affiliateCompanyId = #arguments.affiliateCompanyId#
		</cfquery>
		
		<cfloop list="#arguments.affiliateCompanyUserAdmin#" index="thisAdmin">
			<cfquery name="changeAdministratorsQuery" dataSource="#APPLICATION.db#">
				UPDATE userAffiliateCompany SET affiliateCompanyAdmin = 1
				WHERE idUser = #thisAdmin#
			</cfquery>
		</cfloop>
		

	</cffunction>

		
	<!-------------------------------------------------------------------------------------> 


	<cffunction name="deleteAffiliateCompany" access="public">
	
		<cfargument name="affiliateCompanyId" type="numeric" required="true">

		<cfquery name="deleteAffiliateCompanyQuery" dataSource="#APPLICATION.db#">
			DELETE FROM affiliateCompany
			WHERE
				affiliateCompanyId = #arguments.affiliateCompanyId#
		</cfquery>


	</cffunction>

	<!-------------------------------------------------------------------------------------> 


	<cffunction name="getAffiliateCompanyById" access="public" returnType="query">
	
		<cfargument name="affiliateCompanyId" type="numeric" required="true">

		<cfquery name="getAffiliateCompanyByIdQuery" dataSource="#APPLICATION.db#">
			SELECT *
			FROM affiliateCompany
			WHERE
				affiliateCompanyId = #arguments.affiliateCompanyId#
		</cfquery>

		<cfreturn getAffiliateCompanyByIdQuery>
		
	</cffunction>


	<!-------------------------------------------------------------------------------------> 


	<cffunction name="getAffiliateCompanies" access="public" returnType="query">
	
		<cfquery name="getAffiliateCompaniesQuery" dataSource="#APPLICATION.db#">
			SELECT
				affiliateCompanyId,
				affiliateCompanyName
			FROM 
				affiliateCompany
			ORDER BY affiliateCompanyName
		</cfquery>
		
		<cfreturn getAffiliateCompaniesQuery>

	</cffunction>


	<!-------------------------------------------------------------------------------------> 



</cfcomponent>			 