<cfcomponent>
	

	<cffunction name="legalMattersSearch" access="remote" returnType="any">
	
		
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		<cfargument name="seachedWord" required="false" type="string" default="">
		<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
		
		
		<cfquery name="getLeggalMattersByIdFileQuery" dataSource="#APPLICATION.db#">
		
			SELECT
				legalMatter.ref, 
				legalMatter.idLegalMatter,
				legalMatter.idFile,
				legalMatter.idUser,
				legalMatter.idDebtHolder,
				legalMatter.description,
				legalMatter.openDate,
				legalMatter.closeDate,
				legalMatter.idLegalMatterStatus,
				CONCAT(debtHolder.name, ' ', debtHolder.accountNumber) AS relatedAccount,
				CONCAT(user.firstName, ' ', user.lastName) AS assignedTo,
				legalMatterStatus.name AS thisLegalMatterStatus,
				CASE legalMatter.idLegalMatterStatus
					WHEN 1
						THEN '<img class="fileColor" src="/template/images/file-blue.png">'
					WHEN 2
						THEN '<img class="fileColor" src="/template/images/file-green.png">'
					WHEN 3
						THEN '<img class="fileColor" src="/template/images/file-yellow.png">'
					WHEN 4
						THEN '<img class="fileColor" src="/template/images/file-red.png">'
					WHEN 5
						THEN '<img class="fileColor" src="/template/images/file-black.png">'
				END AS legalMatterColor,
				CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="legalMatterControl(',CAST(idLegalMatter AS CHAR),');">') AS Edit
	
			FROM
				legalMatter, user, debtHolder, legalMatterStatus
			WHERE
				legalMatter.idUser = user.idUser
				AND
				legalMatter.idDebtHolder = debtHolder.idDebtHolder
				AND
				legalMatter.idLegalMatterStatus = legalMatterStatus.idLegalMatterStatus
				AND
				legalMatter.idFile = #arguments.idFile#
				AND
					(
					legalMatter.description LIKE '%#arguments.seachedWord#%'
					OR
					CONCAT(debtHolder.name, ' ', debtHolder.accountNumber) LIKE '%#arguments.seachedWord#%'
					OR
					legalMatterStatus.name LIKE '%#arguments.seachedWord#%'
					OR
					CONCAT(user.firstName, ' ', user.lastName) LIKE '%#arguments.seachedWord#%'
					)
	
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	
		</cfquery>
	
		<cfreturn queryconvertforgrid(getLeggalMattersByIdFileQuery,page,pagesize)/>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->

	<cffunction name="getAllLegalMatters" access="remote" returnType="any">
	
		
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		<cfargument name="lmSearchedWord" required="false" type="string" default="">
		
		<cfquery name="getAllLegalMattersQuery" dataSource="#APPLICATION.db#">
		
			SELECT
				legalMatter.ref, 
				legalMatter.idLegalMatter,
				legalMatter.idFile,
				legalMatter.idUser,
				legalMatter.idDebtHolder,
				legalMatter.description,
				legalMatter.openDate,
				legalMatter.closeDate,
				legalMatter.idLegalMatterStatus,
				CONCAT(debtHolder.name, ' ', debtHolder.accountNumber) AS relatedAccount,
				CONCAT(user.firstName, ' ', user.lastName) AS assignedTo,
				legalMatterStatus.name AS thisLegalMatterStatus,
				CASE legalMatter.idLegalMatterStatus
					WHEN 1
						THEN '<img class="fileColor" src="/template/images/file-blue.png">'
					WHEN 2
						THEN '<img class="fileColor" src="/template/images/file-green.png">'
					WHEN 3
						THEN '<img class="fileColor" src="/template/images/file-yellow.png">'
					WHEN 4
						THEN '<img class="fileColor" src="/template/images/file-red.png">'
					WHEN 5
						THEN '<img class="fileColor" src="/template/images/file-black.png">'
				END AS legalMatterColor,
				CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="selectFile(',CAST(legalMatter.idFile AS CHAR),',1);">') AS Edit
	
			FROM
				legalMatter, user, debtHolder, legalMatterStatus, file
			WHERE
				legalMatter.idUser = user.idUser
				AND
				legalMatter.idDebtHolder = debtHolder.idDebtHolder
				AND
				legalMatter.idLegalMatterStatus = legalMatterStatus.idLegalMatterStatus
				AND
				legalMatter.idFile = file.idFile
				<!--- not cancelled files --->
				AND
				file.idFileStatus <> 15
				AND
					(
					legalMatter.description LIKE '%#arguments.lmSearchedWord#%'
					OR
					CONCAT(debtHolder.name, ' ', debtHolder.accountNumber) LIKE '%#arguments.lmSearchedWord#%'
					OR
					legalMatterStatus.name LIKE '%#arguments.lmSearchedWord#%'
					OR
					CONCAT(user.firstName, ' ', user.lastName) LIKE '%#arguments.lmSearchedWord#%'
					)
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	
		</cfquery>
	
		<cfreturn queryconvertforgrid(getAllLegalMattersQuery,page,pagesize)/>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getLegalMattersStatus" access="public" returnType="query">
	
		<cfquery name="getLegalMattersStatusQuery" dataSource="#APPLICATION.db#">
			SELECT
				*
			FROM
				legalMatterStatus
		</cfquery>
		
		<cfreturn getLegalMattersStatusQuery>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addLegalMatter" access="public" returnType="string">
	
		<cfargument name="planiff" type="string" required="false">
		<cfargument name="defender" type="string" required="false">
		<cfargument name="idFile" type="numeric" default="#SESSION.idFile#">
		<cfargument name="idUser" type="numeric" required="true">
		<cfargument name="openDate" type="string" required="false">
		<cfargument name="closeDate" type="string" required="false">
		<cfargument name="idLegalMatterStatus" type="numeric" required="true">
		<cfargument name="idDebtHolder" type="numeric" required="true">
		<cfargument name="description" type="string" required="false">
		<cfargument name="lmJurisdiction" type="string" required="false">
		<cfargument name="lmAddress" type="string" required="false">
		<cfargument name="lmCity" type="string" required="false">
		<cfargument name="lmZip" type="string" required="false">
		<cfargument name="idState" type="string" required="false" default="">
		<cfargument name="lmName" type="string" required="false" default="">
		<cfargument name="lmLawFirm" type="string" required="false" default="">
		<cfargument name="lmEmail" type="string" required="false" default="">
		<cfargument name="lmPhone" type="string" required="false" default="">
		<cfargument name="lmFax" type="string" required="false" default="">
		
		
		<cfquery name="addLegalMatterQuery" dataSource="#APPLICATION.db#">
		INSERT INTO
			legalMatter
			(
			ref,
			idFile,
			idUser,
			idDebtHolder,
			description,
			openDate,
			closeDate,
			idLegalMatterStatus,
			plantiff,
			defender,
			lmJurisdiction,
			lmAddress,
			lmCity,
			lmZip,
			idState,
			lmName,
			lmLawFirm,
			lmEmail,
			lmPhone,
			lmFax
			)
			VALUES
			(
			'#arguments.ref#',
			#arguments.idFile#,
			#arguments.idUser#,
			#arguments.idDebtHolder#,
			'#arguments.description#',
			<cfif arguments.openDate EQ "">"#dateFormat(now(), 'yyyy/mm/dd')#"<cfelse>'#dateFormat(arguments.openDate, "yyyy/mm/dd")#'</cfif>,
			<cfif arguments.closeDate EQ "">"#dateFormat(now(), 'yyyy/mm/dd')#"<cfelse>'#dateFormat(arguments.closeDate, "yyyy/mm/dd")#'</cfif>,
			#arguments.idLegalMatterStatus#,
			'#arguments.plantiff#',
			'#arguments.defender#',		
			'#arguments.lmJurisdiction#',
			'#arguments.lmAddress#',
			'#arguments.lmCity#',
			'#arguments.lmZip#',
			<cfif arguments.idState EQ "">NULL<cfelse>'#arguments.idState#'</cfif>,
			'#arguments.lmName#',
			'#arguments.lmLawFirm#',
			'#arguments.lmEmail#',
			'#arguments.lmPhone#',
			'#arguments.lmFax#'
			)
		</cfquery>
		
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getLegalMatterById" access="public" returntype="query" >
		
	    <cfargument name="idLegalMatter" required="yes"  type="numeric">
	    
	    <cfquery name="getLegalMatterByIdQuery" datasource="#APPLICATION.db#">
	    	
	        SELECT * FROM legalMatter
	                WHERE idLegalMatter = #arguments.idLegalMatter#
	    	
	    </cfquery>
		
	    <cfreturn getLegalMatterByIdQuery >
	    
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="editLegalMatter" access="public" returnType="string">
	
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    <cfargument name="planiff" type="string" required="false">
		<cfargument name="defender" type="string" required="false">
		<cfargument name="idUser" type="numeric" required="true">
		<cfargument name="openDate" type="string" required="false">
		<cfargument name="closeDate" type="string" required="false">
		<cfargument name="idLegalMatterStatus" type="numeric" required="true">
		<cfargument name="idDebtHolder" type="numeric" required="true">
		<cfargument name="description" type="string" required="false">
		<cfargument name="lmJurisdiction" type="string" required="false">
		<cfargument name="lmAddress" type="string" required="false">
		<cfargument name="lmCity" type="string" required="false">
		<cfargument name="lmZip" type="string" required="false">
		<cfargument name="idState" type="string" required="false" default="">
		<cfargument name="lmName" type="string" required="false" default="">
		<cfargument name="lmLawFirm" type="string" required="false" default="">
		<cfargument name="lmEmail" type="string" required="false" default="">
		<cfargument name="lmPhone" type="string" required="false" default="">
		<cfargument name="lmFax" type="string" required="false" default="">		
		
		
		<cfquery name="editLegalMatterQuery" dataSource="#APPLICATION.db#">
		UPDATE legalMatter SET
			ref = '#arguments.ref#',
			idUser = #arguments.idUser#,
			idDebtHolder = #arguments.idDebtHolder#,
			description = '#arguments.description#',
			openDate = <cfif arguments.openDate EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.openDate, "yyyy/mm/dd")#'</cfif>,
			closeDate = <cfif arguments.closeDate EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.closeDate, "yyyy/mm/dd")#'</cfif>,
			idLegalMatterStatus = #arguments.idLegalMatterStatus#,
			plantiff = '#arguments.plantiff#',
			defender = '#arguments.defender#',
			lmJurisdiction = '#arguments.lmJurisdiction#',
			lmAddress = '#arguments.lmAddress#',
			lmCity = '#arguments.lmCity#',
			lmZip = '#arguments.lmZip#',
			idState = <cfif arguments.idState EQ "">NULL<cfelse>'#arguments.idState#'</cfif>,
			lmName = '#arguments.lmName#',
			lmLawFirm = '#arguments.lmLawFirm#',
			lmEmail = '#arguments.lmEmail#',
			lmPhone = '#arguments.lmPhone#',
			lmFax = '#arguments.lmFax#'
	    WHERE
	    	idLegalMatter = #arguments.idLegalMatter#		
		</cfquery>
		
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	<!--------------------  Legal Matter Notes  ----------------------------->
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="addLegalMatterNote" access="public" returntype="string">
	
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    <cfargument name="note" type="string" required="yes">
	    <cfargument name="idUser" type="numeric" default="#SESSION.userId#">
	    <cfargument name="addToHistory" default="0">
	    
	    <cfquery name="addLegalMatterNoteQuery" datasource="#APPLICATION.db#">
	    	INSERT INTO
	        	legalMatterNote
	            (idLegalMatter, idUser, note)
	            VALUES
	            (
	            #arguments.idLegalMatter#,
	            #arguments.idUser#,
	            '#arguments.note#'
	            )
	    </cfquery>
	    <cfif arguments.addToHistory EQ 1>
	    	<cfinvoke component="components.history" method="addNote">
	    		<cfinvokeargument name="idHistoryType" value="50">
	    		<cfinvokeargument name="title" value="Note from legal matter">
	    		<cfinvokeargument name="detail" value="#arguments.note#">
	    	</cfinvoke>
	    </cfif>	
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="getNoteByIdLegalMatter" access="remote" returntype="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		<cfargument name="idLegalMatter" type="string" required="yes">
	    
	    <cfquery name="getNoteByIdLegalMatterQuery" datasource="#APPLICATION.db#">
	    	SELECT 
	    		legalMatterNote.idLegalMatterNote, 
	    		legalMatterNote.idLegalMatter, 
	    		CONCAT(user.firstName, ' ', user.lastName) AS thisUserName, 
	    		note, 
	    		DATE_FORMAT(timestamp,'%m/%d/%Y') AS thisDate,
				CONCAT('<img class="btnInfo" src="/template/images/info-icon.png" onclick="infoLegalMatterNote(',CAST(legalMatterNote.idLegalMatterNote AS CHAR),');">','&nbsp;&nbsp;<img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteLegalMatterNote(',CAST(legalMatterNote.idLegalMatterNote AS CHAR),',',CAST(legalMatterNote.idLegalMatter AS CHAR),');">') AS actions
	     	FROM
	        	legalMatterNote, user
	        WHERE
	        	legalMatterNote.idUser = user.idUser
	        	AND
	        	legalMatterNote.idLegalMatter = #arguments.idLegalMatter# 
	
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	        	
	    </cfquery>
	    
		<cfreturn queryconvertforgrid(getNoteByIdLegalMatterQuery,page,pagesize)/>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="deleteNoteById" access="public" >
	
		<cfargument name="idLegalMatterNote" type="numeric" required="yes">
	    
	    <cfquery name="deleteNoteByIdQuery" datasource="#APPLICATION.db#">
	    	DELETE FROM
	        	legalMatterNote
	        WHERE
	        	idLegalMatterNote = #arguments.idLegalMatterNote# 
	    </cfquery> 
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getNoteById" access="public" returnType="query">
	
		<cfargument name="idLegalMatterNote" type="numeric" required="yes">
	    
	    <cfquery name="getNoteByIdQuery" datasource="#APPLICATION.db#">
	    	SELECT *
	    	FROM
	        	legalMatterNote
	        WHERE
	        	idLegalMatterNote = #arguments.idLegalMatterNote# 
	    </cfquery> 
	
		<cfreturn getNoteByIdQuery>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	<!-----------------  Legal Matter Comunication  ------------------------->
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="editLegalMatterComunication" access="public" returntype="string">
	
	    <cfargument name="comunicationInOut" type="string" required="yes">
	    <cfargument name="dateTime" type="string" default="">
	    <cfargument name="type" type="string" required="true">
	    <cfargument name="subject" type="string" required="true">
	    <cfargument name="body" type="string" required="true">
		<cfargument name="idComunication" type="numeric" required="true">    
	    
	    <cfquery name="editLegalMatterComunicationQuery" datasource="#APPLICATION.db#">
	    	UPDATE
	        	comunication
	        SET            
				comunicationInOut = '#arguments.comunicationInOut#',
	            dateTime = <cfif arguments.dateTime EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.dateTime, "yyyy/mm/dd")#'</cfif>,
	            type = '#arguments.type#',
	            subject = '#arguments.subject#',
	            body = '#arguments.body#'
			WHERE
				idComunication = #arguments.idComunication#
		</cfquery>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="addLegalMatterComunication" access="public" returntype="string">
	
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    <cfargument name="comunicationInOut" type="string" required="yes">
	    <cfargument name="idUser" type="numeric" default="#SESSION.userId#">
	    <cfargument name="dateTime" type="string" default="">
	    <cfargument name="type" type="string" required="true">
	    <cfargument name="subject" type="string" required="true">
	    <cfargument name="body" type="string" required="true">
	    
	    
	    <cfquery name="addLegalMatterComunicationQuery" datasource="#APPLICATION.db#">
	    	INSERT INTO
	        	comunication
	            (comunicationInOut, dateTime, idUser, type, subject, body, idLegalMatter)
	            VALUES
	            (            
	            '#arguments.comunicationInOut#',
	            <cfif arguments.dateTime EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.dateTime, "yyyy/mm/dd")#'</cfif>,
	            #arguments.idUser#,
	            '#arguments.type#',
	            '#arguments.subject#',
	            '#arguments.body#',
	            #arguments.idLegalMatter#
	            )
	    </cfquery>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="getComunicationByIdLegalMatter" access="remote" returntype="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    
	    <cfquery name="getComunicationByIdLegalMatterQuery" datasource="#APPLICATION.db#">
	    	SELECT 
	    		comunication.idComunication, 
	    		comunication.idLegalMatter, 
	    		comunication.idUser,
	    		comunication.comunicationInOut,
	    		DATE_FORMAT(comunication.dateTime,'%m/%d/%Y') AS dateTime,
	    		CONCAT(user.firstName, ' ', user.lastName) AS thisUser,
	    		comunication.subject, 
	    		comunication.body,
	        	CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="editLegalMatterComunication(',CAST(comunication.idComunication AS CHAR),');">'<cfif SESSION.userIdProfile NEQ 2>,'&nbsp;&nbsp;<img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteLegalMatterComunication(',CAST(comunication.idComunication AS CHAR),');">'</cfif>) AS actions
	        FROM
	        	comunication, user
	        WHERE
	        	comunication.idUser = user.idUser
	        	AND
	        	idLegalMatter = #arguments.idLegalMatter# 
	        	
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	
	        	
	    </cfquery>
	    
		<cfreturn queryconvertforgrid(getComunicationByIdLegalMatterQuery,page,pagesize)/>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="deleteComunicationById" access="public" >
	
		<cfargument name="idComunication" type="numeric" required="yes">
	    
	    <cfquery name="deleteComunicationByIdQuery" datasource="#APPLICATION.db#">
	    	DELETE FROM
	        	comunication
	        WHERE
	        	idComunication = #arguments.idComunication# 
	    </cfquery> 
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getLegalMatterComunicationsById" access="public" returnType="query">
	
		<cfargument name="idComunication" type="numeric" required="yes">
	    
	    <cfquery name="getLegalMatterComunicationsByIdQuery" datasource="#APPLICATION.db#">
	    	SELECT *
	    	
	    	FROM
	        	comunication
	        WHERE
	        	idComunication = #arguments.idComunication# 
	    </cfquery> 
	
		<cfreturn getLegalMatterComunicationsByIdQuery>
		
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	<!-----------------  Legal Matter Violations  --------------------------->
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="addLegalMatterViolation" access="public" returntype="string">
	
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    <cfargument name="legalMatterViolationDate" type="string" required="yes">
	    <cfargument name="idLegalMatterViolationList" type="numeric" default="">
	    <cfargument name="legalMatterViolationComment" type="string" default="">
	    <cfargument name="legalMatterViolationAddByUser" type="numeric" default="#SESSION.userId#">
	    
	    <cfquery name="addLegalMatterViolationQuery" datasource="#APPLICATION.db#">
	    	INSERT INTO
	        	legalMatterViolation
	            (
	            idLegalMatter,
	            legalMatterViolationDate,
	            idLegalMatterViolationList,
	            legalMatterViolationComment,
	           	legalMatterViolationAddByUser
				)
	            VALUES
	            (
	            #arguments.idLegalMatter#,
	            <cfif arguments.legalMatterViolationDate EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.legalMatterViolationDate, "yyyy/mm/dd")#'</cfif>,
				#arguments.idLegalMatterViolationList#,
	            '#arguments.legalMatterViolationComment#',
	            #arguments.legalMatterViolationAddByUser#
	            )
	    </cfquery>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="editLegalMatterViolation" access="public" returntype="string">
	
	    <cfargument name="legalMatterViolationDate" type="string" required="yes">
	    <cfargument name="idLegalMatterViolationList" type="numeric" default="">
	    <cfargument name="legalMatterViolationComment" type="string" default="">
	    <cfargument name="legalMatterViolationAddByUser" type="numeric" default="#SESSION.userId#">
		<cfargument name="idLegalMatterViolation" type="numeric" required="true">
		    
	    <cfquery name="editLegalMatterViolationQuery" datasource="#APPLICATION.db#">
	    	UPDATE
	        	legalMatterViolation
	        SET
	            legalMatterViolationDate = <cfif arguments.legalMatterViolationDate EQ "">'#dateFormat(now(), 'yyyy/mm/dd')#'<cfelse>'#dateFormat(arguments.legalMatterViolationDate, "yyyy/mm/dd")#'</cfif>,
				idLegalMatterViolationList = #arguments.idLegalMatterViolationList#,
	            legalMatterViolationComment = '#arguments.legalMatterViolationComment#',
	            legalMatterViolationAddByUser = #arguments.legalMatterViolationAddByUser#
			WHERE
				idLegalMatterViolation = #arguments.idLegalMatterViolation#
	
	    </cfquery>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="getViolationByIdLegalMatter" access="remote" returntype="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
		
		<cfargument name="idLegalMatter" type="numeric" required="yes">
	    
	    <cfquery name="getViolationByIdLegalMatterQuery" datasource="#APPLICATION.db#">
	    	SELECT 
	    		legalMatterViolation.idLegalMatterViolation, 
	    		legalMatterViolation.idLegalMatter, 
	    		IFNULL(legalMatterViolationList.legalMatterViolationListName,'none') AS thisViolationName,
	    		DATE_FORMAT(legalMatterViolation.legalMatterViolationDate,'%m/%d/%Y') AS thisDate,
	    		legalMatterViolation.legalMatterViolationComment,
	    		CONCAT(user.firstName, ' ', user.lastName) AS thisUser,
	        	CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="editLegalMatterViolation(',CAST(legalMatterViolation.idLegalMatterViolation AS CHAR),');">'<cfif SESSION.userIdProfile NEQ 2>,'&nbsp;&nbsp;<img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteLegalMatterViolation(',CAST(legalMatterViolation.idLegalMatterViolation AS CHAR),');">'</cfif>) AS actions    		
	        FROM
	        	legalMatterViolation LEFT JOIN legalMatterViolationList ON legalMatterViolation.idLegalMatterViolationList = legalMatterViolationList.idLegalMatterViolationList
	        	INNER JOIN user ON legalMatterViolation.legalMatterViolationAddByUser = user.idUser
	        WHERE
	        	idLegalMatter = #arguments.idLegalMatter# 
	 
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>	 
	    </cfquery>

		<cfreturn queryconvertforgrid(getViolationByIdLegalMatterQuery,page,pagesize)/>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getLegalMatterViolationsList" access="public" returnType="query">
	
		<cfquery name="getLegalMatterViolationsListQuery" dataSource="#APPLICATION.db#">
			SELECT * FROM legalMatterViolationList
		</cfquery>
	
		<cfreturn getLegalMatterViolationsListQuery>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getLegalMatterViolationById" access="public" returnType="query">
	
		<cfquery name="getLegalMatterViolationByIdQuery" dataSource="#APPLICATION.db#">
			SELECT * FROM legalMatterViolation
		</cfquery>
	
		<cfreturn getLegalMatterViolationByIdQuery>
	
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="deleteLegalMatterViolation" access="public">
	
		<cfquery name="deleteLegalMatterViolationQuery" dataSource="#APPLICATION.db#">
			DELETE FROM legalMatterViolation
			WHERE 
				idLegalMatterViolation = #arguments.idLegalMatterViolation#
		</cfquery>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	<!---------------------  Legal Matter Task  ----------------------------->
	<!----------------------------------------------------------------------->
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="addLegalMatterTask" access="public" returntype="string">
	
		<cfargument name="idLegalMatter" type="any" required="false" default="">
	    <cfargument name="idUser" type="numeric" required="yes">
		<cfargument name="title" type="string" required="yes">
		<cfargument name="description" type="string" required="yes">
		<cfargument name="authorName" type="string" required="no" default="#SESSION.userName#">
		<cfargument name="authorEmail" type="string" required="no" default="#SESSION.userEmail#">
		<cfargument name="taskWhere" type="string" required="yes">
		<cfargument name="taskStart" type="string" required="yes">
		<cfargument name="taskStartHour" type="string" required="true">
		<cfargument name="taskEnd" type="string" required="yes">
		<cfargument name="taskEndHour" type="string" required="true">
	    
	    <cfset arguments.title = "#SESSION.idFile# - #SESSION.fileName# - #arguments.title#">
	    
	    <cfif arguments.taskStart EQ "">
	    	<cfset thisTaskStart = "#dateFormat(now(), 'yyyy/mm/dd')#">
	    <cfelse>
	    	<cfset thisTaskStart = "#dateFormat(arguments.taskStart, 'yyyy/mm/dd')# #arguments.taskStartHour#:00:00">
	    </cfif>
	    
	    <cfif arguments.taskEnd EQ "">
	    	<cfset thisTaskEnd = "#dateFormat(now(), 'yyyy/mm/dd')#">
	    <cfelse>
	    	<cfset thisTaskEnd = "#dateFormat(arguments.taskEnd, 'yyyy/mm/dd')# #arguments.taskEndHour#:00:00">
	    </cfif>
	    
	    
	    <!--- SE QUITA LA INTEGRACION CON GOOGLE CALENDAR 
	    
	    
	    <!--- Check if the user to assign the task have a google account --->
	    
	    <cfquery name="userAccountTypeQuery" dataSource="#APPLICATION.db#">
			SELECT isGoogleAccount
			FROM
				user
			WHERE
			idUser = '#arguments.idUser#'
		</cfquery>

	    
	    
	    <!---- Enviar a google calendar --->
	    
	    <cfif userAccountTypeQuery.isGoogleAccount EQ "1">
		    
		    <cfinvoke component="components.googleCalAdmin" method="addTaskToCDGLCalendar" returnVariable="newTaskResponseGoogle">
		    	<cfinvokeargument name="idUser" value="#arguments.idUser#">
				<cfinvokeargument name="title" value="#arguments.title#">
				<cfinvokeargument name="description" value="#arguments.description#">
				<cfinvokeargument name="authorname" value="#arguments.authorName#">
				<cfinvokeargument name="authoremail" value="#arguments.authorEmail#">
				<cfinvokeargument name="where" value="#arguments.taskWhere#">
				<cfinvokeargument name="start" value="#thisTaskStart#">
				<cfinvokeargument name="end" value="#thisTaskEnd#">
			</cfinvoke>
		
			<cfif newTaskResponseGoogle.Statuscode EQ "201 Created">
				<cfset thisXmlReturn = XmlParse(newTaskResponseGoogle.fileContent)>
				<cfset thisTaskGoogleId = thisXmlReturn.entry.id.XmlText>
			<cfelse>
				<cfreturn "The task didn't save. The synchronization with Google Calendar failed">
			</cfif>
		
		<cfelse>

			<cfset thisXmlReturn = "">
			<cfset thisTaskGoogleId = "">

		</cfif>
		--->
		<cfset thisXmlReturn = "">
		<cfset thisTaskGoogleId = "">
		
			
	    <cfquery name="addLegalMatterTaskQuery" datasource="#APPLICATION.db#">
	    	INSERT INTO task
				(
				idUser,
				title,
				description,
				authorName,
				authorEmail,
				taskWhere,
				taskStart,
				taskEnd,
				idGoogleTask,
				idLegalMatter
				)
				VALUES
				(
				#arguments.idUser#,
				'#arguments.title#',
				'#arguments.description#',
				'#arguments.authorName#',
				'#arguments.authorEmail#',
				'#arguments.taskWhere#',
				'#thisTaskStart#',
				'#thisTaskEnd#',
				'#thisTaskGoogleId#',
				<cfif arguments.idLegalMatter EQ "">NULL<cfelse>#arguments.idLegalMatter#</cfif>
				)
	    </cfquery>

		<cfreturn "">   
	    
	    
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	
	
	<cffunction name="editLegalMatterTask" access="public" returntype="string">
	
		<cfargument name="idTask" type="numeric" required="true">
	    <cfargument name="idUser" type="numeric" required="yes">
		<cfargument name="title" type="string" required="yes">
		<cfargument name="description" type="string" required="yes">
		<cfargument name="authorName" type="string" required="no" default="#SESSION.userName#">
		<cfargument name="authorEmail" type="string" required="no" default="#SESSION.userEmail#">
		<cfargument name="taskWhere" type="string" required="yes">
		<cfargument name="taskStart" type="string" required="yes">
		<cfargument name="taskStartHour" type="string" required="true">
		<cfargument name="taskEnd" type="string" required="yes">
		<cfargument name="taskEndHour" type="string" required="true">
		<cfargument name="idGoogleTask" type="string" required="true">
	    
	    <cfif arguments.taskStart EQ "">
	    	<cfset thisTaskStart = "#dateFormat(now(), 'yyyy/mm/dd')#">
	    <cfelse>
	    	<cfset thisTaskStart = "#dateFormat(arguments.taskStart, 'yyyy/mm/dd')# #arguments.taskStartHour#:00:00">
	    </cfif>
	    
	    <cfif arguments.taskEnd EQ "">
	    	<cfset thisTaskEnd = "#dateFormat(now(), 'yyyy/mm/dd')#">
	    <cfelse>
	    	<cfset thisTaskEnd = "#dateFormat(arguments.taskEnd, 'yyyy/mm/dd')# #arguments.taskEndHour#:00:00">
	    </cfif>
	    
	    
	    <!--- Get saved task to check if user was changed --->
	    <cfinvoke component="components.legalMatters" method="getTaskById" returnVariable="thisOldTask">
	    	<cfinvokeargument name="idTask" value="#arguments.idTask#">
	    </cfinvoke>    

	    <!---check if the OLD user is google account --->
	    <cfquery name="oldUserAccountTypeQuery" dataSource="#APPLICATION.db#">
			SELECT isGoogleAccount
			FROM
				user, task
			WHERE
				user.idUser = task.idUser
				AND
				task.idUser = '#thisOldTask.idUser#'
		</cfquery>
		
		<!--- check if user was changed --->
		<cfif thisOldTask.idUser NEQ arguments.idUser>


		    <!---check if the NEW user is google account --->
		    <cfquery name="newUserAccountTypeQuery" dataSource="#APPLICATION.db#">
				SELECT isGoogleAccount
				FROM
					user, task
				WHERE
					user.idUser = task.idUser
					AND
					task.idUser = '#arguments.idTask#'
			</cfquery>

			
			<cfif oldUserAccountTypeQuery.isGoogleAccount EQ "1">
				<!--- delete google task for old user --->
				<cfinvoke component="components.googleCalAdmin" method="deleteTaskToCDGLCalendar">
					<cfinvokeargument name="idEvent" value="#thisOldTask.idGoogleTask#">
					<cfinvokeargument name="idUser" value="#thisOldTask.idUser#"> 
				</cfinvoke>
			</cfif>
	
			<cfif newUserAccountTypeQuery.isGoogleAccount EQ "1">
				<!--- CREATE task in google cal to new user --->
			    <cfinvoke component="components.googleCalAdmin" method="addTaskToCDGLCalendar" returnVariable="newTaskResponseGoogle">
			    	<cfinvokeargument name="idUser" value="#arguments.idUser#">
					<cfinvokeargument name="title" value="#arguments.title#">
					<cfinvokeargument name="description" value="#arguments.description#">
					<cfinvokeargument name="authorname" value="#arguments.authorName#">
					<cfinvokeargument name="authoremail" value="#arguments.authorEmail#">
					<cfinvokeargument name="where" value="#arguments.taskWhere#">
					<cfinvokeargument name="start" value="#thisTaskStart#">
					<cfinvokeargument name="end" value="#thisTaskEnd#">
				</cfinvoke>
				<!--- Check google response and create the task on the sistem --->
				<cfset thisXmlReturn = XmlParse(newTaskResponseGoogle.fileContent)>
				<cfset thisTaskGoogleId = thisXmlReturn.entry.id.XmlText>
			<cfelse>
				<cfset thisXmlReturn = "">
				<cfset thisTaskGoogleId = "">			
			</cfif>
				
		
		<cfelse>
		
			<cfif oldUserAccountTypeQuery.isGoogleAccount EQ "1">
			    <!---- Enviar a update google calendar --->
			    <cfinvoke component="components.googleCalAdmin" method="editTaskToCDGLCalendar" returnVariable="editTaskResponseGoogle">
			    	<cfinvokeargument name="idUser" value="#arguments.idUser#">
					<cfinvokeargument name="title" value="#arguments.title#">
					<cfinvokeargument name="description" value="#arguments.description#">
					<cfinvokeargument name="authorname" value="#arguments.authorName#">
					<cfinvokeargument name="authoremail" value="#arguments.authorEmail#">
					<cfinvokeargument name="where" value="#arguments.taskWhere#">
					<cfinvokeargument name="start" value="#thisTaskStart#">
					<cfinvokeargument name="end" value="#thisTaskEnd#">
					<cfinvokeargument name="idGoogleTask" value="#arguments.idGoogleTask#">
				</cfinvoke>
				<!--- Check google response and create the task on the sistem --->
				<cfset thisXmlReturn = XmlParse(editTaskResponseGoogle.fileContent)>
				<cfset thisTaskGoogleId = thisXmlReturn.entry.id.XmlText>
			<cfelse>
				<cfset thisXmlReturn = "">
				<cfset thisTaskGoogleId = "">			
			</cfif>
	    
	    </cfif>
	
	
	    <cfquery name="editLegalMatterTaskQuery" datasource="#APPLICATION.db#">
	    	UPDATE task
	    	SET
				idUser = #arguments.idUser#,
				title = '#arguments.title#',
				description = '#arguments.description#',
				authorName = '#arguments.authorName#',
				authorEmail = '#arguments.authorEmail#',
				taskWhere = '#arguments.taskWhere#',
				taskStart = '#thisTaskStart#',
				taskEnd = '#thisTaskEnd#',
				idGoogleTask = '#thisTaskGoogleId#'
			WHERE
				idTask = #arguments.idTask#
	    </cfquery>
	    
	</cffunction>
	
	<!----------------------------------------------------------------------->
	
	
	<cffunction name="getTaskByIdLegalMatter" access="remote" returntype="any">
	
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
	
		<cfargument name="idLegalMatter" type="string" required="no" default="#SESSION.idLegalMatter#">
		
	    <cfquery name="getTaskByIdLegalMatterQuery" datasource="#APPLICATION.db#">
	    	SELECT 
	    		task.idTask, 
	    		task.idLegalMatter, 
	    		task.idUser, 
	    		task.title,
	    		task.description, 
	    		DATE_FORMAT(task.taskStart,'%m/%d/%Y') AS taskStart, 
	    		DATE_FORMAT(task.taskEnd,'%m/%d/%Y') AS taskEnd,
	    		CONCAT(user.firstName, ' ', user.lastName) AS responsible,
	        	CONCAT('<img class="btnEdit" src="/template/images/edit-icon.png" onclick="editLegalMatterTask(',CAST(task.idTask AS CHAR),');">'<cfif SESSION.userIdProfile NEQ 2>,'&nbsp;&nbsp;<img class="btnDelete" src="/template/images/delete-icon.png" onclick="deleteLegalMatterTask(',CAST(task.idTask AS CHAR),');">'</cfif>) AS actions    		
	        FROM
	        	task, user
	        WHERE
	        	task.iduser = user.iduser
	        	AND
	        	idLegalMatter = #arguments.idLegalMatter# 
	
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	        	
	        	
	    </cfquery>
	    
		<cfoutput>#serializeJSON(queryconvertforgrid(getTaskByIdLegalMatterQuery,page,pagesize))#</cfoutput>
	
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="deleteTaskById" access="public" >
	
		<cfargument name="idTask" type="numeric" required="yes">
	    
	    <!---check if the user is google account --->
	    <cfquery name="userAccountTypeQuery" dataSource="#APPLICATION.db#">
			SELECT isGoogleAccount
			FROM
				user, task
			WHERE
				user.idUser = task.idUser
				AND
				task.idTask = '#arguments.idTask#'
		</cfquery>
	    
	    <cfif userAccountTypeQuery.isGoogleAccount EQ "1">
		    <!--- Get task information --->
		    <cfinvoke component="components.legalMatters" method="getTaskById" returnVariable="thisTaskInf">
		    	<cfinvokeargument name="idTask" value="#arguments.idTask#">
		    </cfinvoke>    
	
			<!--- Borrar de google Calendar --->
			<cfinvoke component="components.googleCalAdmin" method="deleteTaskToCDGLCalendar">
				<cfinvokeargument name="idEvent" value="#thisTaskInf.idGoogleTask#"> 
				<cfinvokeargument name="idUser" value="#thisTaskInf.idUser#"> 
			</cfinvoke>
		</cfif>
		
		<!--- Borrar de la base de datos --->
	    <cfquery name="deleteTaskByIdQuery" datasource="#APPLICATION.db#">
	    	DELETE FROM
	        	task
	        WHERE
	        	idTask = #arguments.idTask# 
	    </cfquery> 
	
		
	</cffunction>
	
	
	<!----------------------------------------------------------------------->
	
	<cffunction name="getTaskById" access="public" returnType="query">
	
		<cfargument name="idTask" type="numeric" required="yes">
	    
	    <cfquery name="getTaskByIdQuery" datasource="#APPLICATION.db#">
	    	SELECT *
	    	FROM
	        	task
	        WHERE
	        	idTask = #arguments.idTask# 
	    </cfquery> 
		
		<cfreturn getTaskByIdQuery>
		
	</cffunction>

</cfcomponent>
