<cfcomponent>

	<cffunction name="addTaskToCDGLCalendar" access="public" returnType="any">
			
		<cfargument name="idUser" required="true" type="numeric">
		<cfargument name="title" required="true" type="string">
		<cfargument name="description" required="true" type="string">
		<cfargument name="authorname" required="true" type="string">
		<cfargument name="authoremail" required="true" type="string">
		<cfargument name="where" required="true" type="string">
		<cfargument name="start" required="true" type="string">
		<cfargument name="end" required="true" type="string">
		
		<!--- Get User Data --->
		<cfinvoke component="components.user" method="getUsersById" returnVariable="thisIserInf">
			<cfinvokeargument name="idUser" value="#arguments.idUser#">
		</cfinvoke>
		<cfscript>
			decryptedPassword = decrypt(thisIserInf.password,thisIserInf.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
		</cfscript>
	
		<!--- Conectarse a google--->
		<cfset gCal = createObject("components.GoogleCalendar").init(thisIserInf.userName,decryptedPassword,-5)>

		<cfinvoke component="#gcal#" method="addEvent" returnVariable="result">
			<cfinvokeargument name="title" value="#arguments.title#">
			<cfinvokeargument name="description" value="#arguments.description#">
			<cfinvokeargument name="authorname" value="#arguments.authorname#">
			<cfinvokeargument name="authormemail" value="#arguments.authoremail#">
			<cfinvokeargument name="where" value="#arguments.where#">
			<cfinvokeargument name="start" value="#arguments.start#">
			<cfinvokeargument name="end" value="#arguments.end#">
			<cfinvokeargument name="calendarid" value="#thisIserInf.idCalendar#">
		</cfinvoke>
		
		<cfreturn result>
		
	</cffunction>

	<!------------------------------------------------------------------------------------------------------------->
	
	
	<cffunction name="deleteTaskToCDGLCalendar" access="public" returnType="any">
			
		<cfargument name="idEvent" required="true" type="string">
		<cfargument name="idUser" required="true" type="numeric">
		
		<!--- Get User Data --->
		<cfinvoke component="components.user" method="getUsersById" returnVariable="thisIserInf">
			<cfinvokeargument name="idUser" value="#arguments.idUser#">
		</cfinvoke>
		<cfscript>
			decryptedPassword = decrypt(thisIserInf.password,thisIserInf.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
		</cfscript>
	
		<!--- Conectarse a google--->
		<cfset gCal = createObject("components.GoogleCalendar").init(thisIserInf.userName,decryptedPassword,-5)>

		<cfset gCal.deleteEvent(arguments.idEvent)>
		
	</cffunction>

	<!------------------------------------------------------------------------------------------------------------->

	<cffunction name="editTaskToCDGLCalendar" access="public" returnType="any">
			
		<cfargument name="idUser" required="true" type="numeric">
		<cfargument name="title" required="true" type="string">
		<cfargument name="description" required="true" type="string">
		<cfargument name="authorname" required="true" type="string" default="">
		<cfargument name="authoremail" required="true" type="string" default="">
		<cfargument name="where" required="true" type="string">
		<cfargument name="start" required="true" type="string">
		<cfargument name="end" required="true" type="string">
		<cfargument name="idGoogleTask" required="true" type="string">
		
		<!--- Get User Data --->
		<cfinvoke component="components.user" method="getUsersById" returnVariable="thisIserInf">
			<cfinvokeargument name="idUser" value="#arguments.idUser#">
		</cfinvoke>
		<cfscript>
			decryptedPassword = decrypt(thisIserInf.password,thisIserInf.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
		</cfscript>
	
		<!--- Conectarse a google--->
		<cfset gCal = createObject("components.GoogleCalendar").init(thisIserInf.userName,decryptedPassword,-5)>

		<cfinvoke component="#gcal#" method="updateEvent" returnVariable="result">
			<cfinvokeargument name="title" value="#arguments.title#">
			<cfinvokeargument name="description" value="#arguments.description#">
			<cfinvokeargument name="authorname" value="#arguments.authorname#">
			<cfinvokeargument name="authormemail" value="#arguments.authoremail#">
			<cfinvokeargument name="where" value="#arguments.where#">
			<cfinvokeargument name="start" value="#arguments.start#">
			<cfinvokeargument name="end" value="#arguments.end#">
			<cfinvokeargument name="calID" value="#thisIserInf.idCalendar#">
			<cfinvokeargument name="eventID" value="#arguments.idGoogleTask#">
		</cfinvoke>
		
		<cfreturn result>
		
	</cffunction>

</cfcomponent>