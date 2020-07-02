
<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileForRetainer">
	<cfinvokeargument name="idFile" value="#SESSION.idFile#">
</cfinvoke>

<cfif thisFileForRetainer.retainerStatus EQ "" OR thisFileForRetainer.retainerStatus EQ "voided">

	<nav id="general-nav">
		<li id="item6">
			<a href="generateRetainer.cfm">Generate Retainer</a>
		</li>
	</nav>

<cfelse>
	
	<div id="retStatus">
		<div id="retStatusTitle">
			<h4><cfoutput>#reReplace(thisFileForRetainer.retainerStatus,"(^[a-z])","\U\1","ALL")#</cfoutput></h4>
		</div>
		<cfif thisFileForRetainer.retainerStatusClient1 NEQ "">
			<div class="retStatusSigner">
			<cfoutput>
				Sign status for #thisFileForRetainer.firstName# #thisFileForRetainer.lastName# (#thisFileForRetainer.email#):<br />
				<strong>#reReplace(thisFileForRetainer.retainerStatusClient1,"(^[a-z])","\U\1","ALL")#</strong>
			</cfoutput>
			</div>
		</cfif>
		<cfif thisFileForRetainer.retainerStatusClient2 NEQ "">
			<div class="retStatusSigner">
			<cfoutput>
				Sign status for #thisFileForRetainer.scFirstName# #thisFileForRetainer.scLastName# (#thisFileForRetainer.scEmail#):<br />
				<strong>#reReplace(thisFileForRetainer.retainerStatusClient2,"(^[a-z])","\U\1","ALL")#</strong>
			</cfoutput>
			</div>
		</cfif>
		<cfif thisFileForRetainer.retainerStatusAttorney NEQ "">
			<div class="retStatusSigner">
			<cfoutput>
				Sign status for Attorney:<br />
				<strong>#reReplace(thisFileForRetainer.retainerStatusAttorney,"(^[a-z])","\U\1","ALL")#</strong>
			</cfoutput>
			</div>
		</cfif>
		<div id="retStatusLeft">
			<cfform name="retainerStatusForm">
				<cfinput type="hidden" name="idFile" value="#SESSION.idFile#">
				<cfinput type="hidden" name="retainerStatus" value="#thisFileForRetainer.retainerStatus#">
				<cfinput type="hidden" name="retainerEnvelopeID" value="#thisFileForRetainer.retainerEnvelopeID#">
				<cfinput type="submit" name="submit" value="Refresh" onMouseUp="return disableDoubleClick()" onclick="submitFormUpdateR()">
			</cfform>
		</div>
		<div id="retStatusRight">
			<cfform name="retainerCancelForm">
				<cfinput type="hidden" name="idFile" value="#SESSION.idFile#">
				<cfinput type="hidden" name="retainerStatus" value="#thisFileForRetainer.retainerStatus#">
				<cfinput type="hidden" name="retainerEnvelopeID" value="#thisFileForRetainer.retainerEnvelopeID#">
				<cfinput type="submit" name="submit" value="Void" onMouseUp="return disableDoubleClick()" onclick="submitFormCancelR()">
			</cfform>
		</div>
	</div>
	<div class="clearfix"></div>
</cfif>

