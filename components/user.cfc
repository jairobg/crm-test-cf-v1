<cfcomponent>

	<cffunction name="addUser" access="public" returntype="string">
		<cfargument name="userName" type="string" required="yes">
        <cfargument name="idProfile" type="string" required="yes">
        <cfargument name="firstName" type="string" required="no" default="">
        <cfargument name="middleName" type="string" required="no" default="">
        <cfargument name="lastName" type="string" required="no" default="">
        <cfargument name="isGoogleAccount" type="string" required="no" default="0">
        <cfargument name="password" type="string" required="no" default="">
        <cfargument name="affiliateCompanyId" type="string" required="no" default="0">
        
        <cfset message = "">
   
            <cfquery name="addUserQuery" datasource="#APPLICATION.db#" result="addUserQueryResult">
                INSERT INTO user
                            (userName, idProfile, firstName, middleName, lastName, isGoogleAccount, password)
                     VALUES (
                            '#arguments.userName#',
                            #arguments.idProfile#,
                            '#arguments.firstName#',
                            '#arguments.middleName#',
                            '#arguments.lastName#',
                            #arguments.isGoogleAccount#,
                            '#arguments.password#'
                            )
            </cfquery>
            
            <cfset thisIdUser = addUserQueryResult.GENERATED_KEY>

			<!--- Save Affiliate Company --->
			<cfif arguments.idProfile EQ 7>
				<cfquery name="addUserAffiliateCompanyQuery" dataSource="#APPLICATION.db#">
					INSERT INTO userAffiliateCompany (idUser,affiliateCompanyId)
					VALUES
						(#thisIdUser#,#arguments.affiliateCompanyId#)
				</cfquery>
			</cfif>


        <cfset message = "User Data Saved.">	
		        
        <cfreturn message>
	
    </cffunction>
    
	<!-------------------------------------------------------------------------------------> 

   	<cffunction name="editUser" access="public">
		<cfargument name="userName" type="string" required="yes">
        <cfargument name="idProfile" type="string" required="yes">
        <cfargument name="firstName" type="string" required="no" default="">
        <cfargument name="middleName" type="string" required="no" default="">
        <cfargument name="lastName" type="string" required="no" default="">
        
        <cfargument name="idUser" required="true">
   
            <cfquery name="editUserQuery" datasource="#APPLICATION.db#" >
                UPDATE user
                SET
                    userName = '#arguments.userName#',
                    idProfile = #arguments.idProfile#,
                    firstName = '#arguments.firstName#',
                    middleName = '#arguments.middleName#',
                    lastName = '#arguments.lastName#'
               	WHERE
               		idUser = #arguments.idUser#
                            
            </cfquery>
            
            
        <cfquery name="deleteUserAffiliateCompany" datasource="#APPLICATION.db#" >
        	DELETE FROM userAffiliateCompany
        	WHERE
        		idUser = #arguments.idUser#
        </cfquery>
        
        <cfquery name="editUserAffiliateCompany" datasource="#APPLICATION.db#" >
        	INSERT INTO userAffiliateCompany
        	(
        	affiliateCompanyId,
        	idUser
        	)
        	VALUES
        	(
	        #arguments.affiliateCompanyId#,
	        #arguments.idUser#
        	)
        </cfquery>


       
	
    </cffunction>
    
	<!------------------------------------------------------------------------------------->    
    
    <cffunction name="getUsers" access="public" returnType="query">
    	
    	<cfquery name="getUsersQuery" dataSource="#APPLICATION.db#">
    	
    		SELECT 
    			idUser,
    			firstName,
    			middleName,
    			lastName,
    			CONCAT(firstName, ' ',middleName, ' ', lastName) AS fullName
    		FROM
    			user 
    	
    	</cfquery>
    	
    	<cfreturn getUsersQuery>
    	
    </cffunction>


<!------------------------------------------------------------------>
    
    <cffunction name="getUserById" access="public" returnType="query">
    	
    	<cfargument name="idUser" required="true">
    	
    	<cfquery name="getUserByIdQuery" dataSource="#APPLICATION.db#">
    	
    		SELECT 
    			*
    		FROM
    			user LEFT JOIN userAffiliateCompany ON user.idUser = userAffiliateCompany.idUser
    		WHERE
    			user.idUser = #arguments.idUser#
    	
    	</cfquery>
    	
    	<cfreturn getUserByIdQuery>
    	
    </cffunction>


<!------------------------------------------------------------------>


    <cffunction name="deleteUser" access="public">
    	
    	<cfargument name="idUser" required="true">
    	
    	<cfquery name="deleteUserQuery" dataSource="#APPLICATION.db#">
    	
    		DELETE FROM
    			user 
    		WHERE
    			idUser = #arguments.idUser#
    	
    	</cfquery>
    	    	
    </cffunction>


<!------------------------------------------------------------------>

<cffunction name="getUsersForGrid" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	
	<cfquery name="getUsersForGridQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			userName,
			firstName,
			middleName,
			lastName,
			profile.name,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editUser(\'',CAST(idUser AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteUser(\'',CAST(idUser AS CHAR),'\');">') AS Edit	
		FROM
			user, profile
		WHERE
			user.idProfile = profile.idprofile
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>

	
	</cfquery>

	<cfreturn queryconvertforgrid(getUsersForGridQuery,page,pagesize)/>

</cffunction>


	<!------------------------------------------------------------------------------------->    
    
    <cffunction name="getUsersById" access="public" returnType="query">
    	
    	<cfargument name="idUser" required="true" type="numeric">
    	
    	<cfquery name="getUsersByIdQuery" dataSource="#APPLICATION.db#">
    	
    		SELECT 
    			idUser,
    			firstName,
    			middleName,
    			lastName,
    			userName,
    			password,
    			CONCAT(firstName, ' ',middleName, ' ', lastName) AS fullName,
    			idCalendar
    		FROM
    			user 
    		WHERE
    			idUser = #arguments.idUser#
    	
    	</cfquery>
    	
    	<cfreturn getUsersByIdQuery>
    	
    </cffunction>


	<!------------------------------------------------------------------------------------->    
    
    <cffunction name="getUsersForTask" access="public" returnType="query">
    	
    	<cfquery name="getUsersQuery" dataSource="#APPLICATION.db#">
    	
    		SELECT 
    			idUser,
    			firstName,
    			middleName,
    			lastName,
    			CONCAT(firstName, ' ',IFNULL(middleName,''), ' ', IFNULL(lastName,'')) AS fullName
    		FROM
    			user 
    		WHERE
    			password <> ""
    			AND
    			(idCalendar <> "" OR isGoogleAccount = 0)
    			<cfif SESSION.userIdProfile EQ 7>
    			AND
    			idUser = #SESSION.userId#
    			</cfif>
    	
    	</cfquery>
    	
    	<cfreturn getUsersQuery>
    	
    </cffunction>


	<!------------------------------------------------------------------------------------->    
    
    <cffunction name="changePassword" access="public" returnType="any">
    
    	<cfargument name="actualPassword" required="yes">
    	<cfargument name="newPassword" required="yes">
    	
    	<cfquery name="actualUserQuery" dataSource="#APPLICATION.db#">
			SELECT * FROM user
			WHERE
				idUser = #SESSION.userId#
		</cfquery>
    	
    	
    	<cfif actualUserQuery.password EQ arguments.actualPassword>
    		
    		<cfquery name="updatePasswordQuery" dataSource="#APPLICATION.db#">
    			UPDATE user SET password = '#arguments.newPassword#'
    			WHERE
					idUser = #SESSION.userId#
    		</cfquery>
    		
    		<cfreturn "Password updated">
    		
    	<cfelse>

    		<cfreturn "Actual password don't match!">

    	</cfif>
    
    </cffunction>
   
</cfcomponent>			 