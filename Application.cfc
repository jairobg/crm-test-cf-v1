<cfcomponent>

	

	<cfset this.name = "RLG" />
	<cfset this.sessionManagement = "Yes" />
	<cfset this.sessionTimeout = createTimeSpan(0,8,0,0) />
	<cfset this.mappings["/components"]="/home/crmlexco/public_html/rlg/components" />
 
	 <cfsetting requesttimeout="120" showdebugoutput="false" enablecfoutputonly="false" />




   <cffunction
        name="OnSessionStart"
        access="public"
        returntype="void"
        output="false"
        hint="Fires when the session is first created.">
			
  		<cfset APPLICATION.db = "rlg">
		<cfset APPLICATION.website_url = "http://rlg.crmlex.com">
		<cfset APPLICATION.template_path = "#application.website_url#/template/">
		<cfset APPLICATION.localPath = "/home/crmlexco/public_html/rlg/">
  		<cfset APPLICATION.codealgorithm = "CFMX_COMPAT">
  		<cfset APPLICATION.codeencoding = "UU">
  		<cfset APPLICATION.codekey = "CRMLEX">
		
		<cfreturn />
		
	</cffunction>
 
 
 
 
    <cffunction
        name="OnError"
        access="public"
        returntype="void"
        output="true"
        hint="Fires when an exception occures that is not caught by a try/catch block">

        <cfargument name="Exception" type="any" required="true" />
        <cfargument name="EventName" type="string" required="false" default="" />

		We are so sorry. Something went wrong. We are automatically notified and will fix it as soon as possible.

		<cfsavecontent variable="errortext">
	        <cfif StructKeyExists( THIS, "OnRequest" )>
	            <!--- Use label with onrequest. --->
	            <cfdump var="#ARGUMENTS#" label="OnError() - WITH OnRequest()" /> 
	        
	        <cfelse>
	            <!--- Use label withOUT onrequest. --->
	            <cfdump var="#ARGUMENTS#" label="OnError() - WITHOUT OnRequest()" />
	 
	        </cfif>
	        
	        <cfdump var="#SESSION#" label="SESSION">
		</cfsavecontent>
		
		<cfmail to="jairo.botero@nyxent.com" from="CRMLEX@CRMLEX.com" subject="Error on #cgi.server_name#" type="html">
		    #errortext#
		</cfmail>
		
        <cfreturn />
    </cffunction>
	
	
	
	
</cfcomponent>