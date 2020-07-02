<cfcomponent>

	<cffunction name="generateAllLetterData" access="public">
		
		<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
		<cfargument name="letterType" type="string" required="true">
		<cfargument name="tracking" type="string" required="false" default="">
		<cfargument name="idDebtHolder" required="false" default="">
		<cfargument name="flDate" required="false" default="">
		<cfargument name="client1" required="false" default="">
		<cfargument name="client2" required="false" default="">
		<cfargument name="dlDate" required="false" default="">
		
		<cfargument name="finalLetter" required="false" default="0">

<cfsavecontent variable="letterData">
[letterType]<cfoutput>#arguments.letterType#</cfoutput>
[clientsName]<@@CLIENTNAME@@>
[userName]<@@USERNAME@@>
[actualDate]<@@DATE@@>
[clientAddress]<@@CLIENTADDRESS@@>
[clientCity]<@@CLIENTCITY@@>
[clientState]<@@CLIENTSTATE@@>
[clientZip]<@@CLIENTZIP@@>
[clientHomePhone]<@@CLIENTHOMEPHONE@@>
[clientCellPhone]<@@CLIENTCELLPHONE@@>
[clientMail]<@@CLIENTEMAIL@@>
[clientAccountNumber]<@@CLIENTACCOUNTNUMBER@@>
[clientPayment]<@@CLIENTMPAYMENT@@>
[clientNumber]<@@CLIENTRNUMBER@@>
[clientFIDate]<@@CLIENTFIDATE@@>
[clientAccountHolderName]<@@CLIENTACCOUNTHOLDERNAME@@>
[clientTotalRetainerFee]<@@CLIENTTOTALRETAINERFEE@@>
[traking]<@@TRACKING@@>
[flDate]<@@FLDATE@@>
[debtHolderName]<@@DEBTHOLDERNAME@@>
[debtHolderAccountNumber]<@@DEBTHOLDERACCOUNTNUMBER@@>
[debtHolderBalance]<@@DEBTHOLDERBALANCE@@>
[debtHolderAddress]<@@DEBTHOLDERADDRESS@@>
[debtHolderCity]<@@DEBTHOLDERCITY@@>
[debtHolderState]<@@DEBTHOLDERSTATE@@>
[debtHolderZip]<@@DEBTHOLDERZIP@@>
[dlDate]<@@DLDATE@@>
[saveIn]<@@SAVEIN@@>
</cfsavecontent>

		<!--- Replace content --->
		<cfinvoke component="components.letters" method="repaceContent" returnVariable="thisLetter">
			<cfinvokeargument name="content" value="#letterData#">
			<cfinvokeargument name="tracking" value="#arguments.tracking#">
			<cfinvokeargument name="idDebtHolder" value="#arguments.idDebtHolder#">
			<cfinvokeargument name="flDate" value="#arguments.flDate#">
			<cfinvokeargument name="client1" value="#arguments.client1#">
			<cfinvokeargument name="client2" value="#arguments.client2#">
			<cfinvokeargument name="dlDate" value="#arguments.dlDate#">
		</cfinvoke>
		
		
		<cfif NOT isDefined("SESSION.allLetters")>		
			<cfset SESSION.allLetters = "">
		</cfif>
		
		<cfset SESSION.allLetters = SESSION.allLetters&thisLetter>
		
		<cfif ARGUMENTS.finalLetter EQ 1>
			<!--- Write file --->
			<cfset letterFileName = "CDLGLetter-#arguments.idFile#-#dateFormat(now(), 'yyyymmdd')##timeFormat(now(), 'hhmmss')#-allLetters.cdlg">
			<cffile action="write" file="#APPLICATION.localPath#/lettersSaved/#letterFileName#" output="#SESSION.allLetters#">
			<cfset SESSION.allLetters = "">
			<!--- Save creation information --->
			<cfquery name="saveLetterQuery" dataSource="#APPLICATION.db#">
				INSERT INTO letter
					(idFile, letterFileName, letterType, idDebtHolder, tracking)
				VALUES
					(
					#arguments.idFile#, 
					'#letterFileName#', 
					'All Letters', 
					NULL, 
					NULL
					)
			</cfquery>
		</cfif>

	</cffunction>



	<!------------------------------------------------------------------>


	<cffunction name="generateLetterData" access="public">
		
		<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
		<cfargument name="letterType" type="string" required="true">
		<cfargument name="tracking" type="string" required="false" default="">
		<cfargument name="idDebtHolder" required="false" default="">
		<cfargument name="flDate" required="false" default="">
		<cfargument name="client1" required="false" default="">
		<cfargument name="client2" required="false" default="">
		<cfargument name="dlDate" required="false" default="">

<cfsavecontent variable="letterData">


<style>
	.pContract{
		text-indent: 30px;
	}
    	
</style>

<cfswitch expression="#arguments.letterType#">
	
	<!-------------------- AcceptanceLetter ---------------------->
	<cfcase value="AcceptanceLetter">
		<cfinclude template="../letterTemplates/acceptanceLetter.html">
	</cfcase>
	
	<!-------------------- BankruptcyLetter ---------------------->
	<cfcase value="BankruptcyLetter">
		<cfinclude template="../letterTemplates/bankruptcyLetter.html">
	</cfcase>
	
	<!-------------------- CeaseDesist ---------------------->
	<cfcase value="CeaseDesist">
		<cfinclude template="../letterTemplates/ceaseDesistLetter.html">
	</cfcase>
	
	<!-------------------- DeclinationLetter ---------------------->
	<cfcase value="DeclinationLetter">
		<cfinclude template="../letterTemplates/declinationLetter.html">
	</cfcase>
	
	<!-------------------- NonResponsiveClientLetter ---------------------->
	<cfcase value="NonResponsiveClientLetter">
		<cfinclude template="../letterTemplates/NonResponsiveClientLetter.html">
	</cfcase>
	
	<!-------------------- NonResponsiveClientLetterSpanish ---------------------->
	<cfcase value="NonResponsiveClientLetterSpanish">
		<cfinclude template="../letterTemplates/NonResponsiveClientLetterSpanish.html">
	</cfcase>
	
	<!-------------------- SecondDisputeLetterResponseToFirst ---------------------->
	<cfcase value="SecondDisputeLetterResponseToFirst">
		<cfinclude template="../letterTemplates/secondDisputeLetterResponseToFirstTemplate.html">
	</cfcase>
	
	<!-------------------- SecondDisputeLetterNoResponseToFirst ---------------------->
	<cfcase value="SecondDisputeLetterNoResponseToFirst">
		<cfinclude template="../letterTemplates/secondDisputeLetterNoResponseToFirstTemplate.html">
	</cfcase>

	<!-------------------- VerificationLetter ---------------------->
	<cfcase value="VerificationLetter">	
		<cfinclude template="../letterTemplates/verificationLetter.html">
	</cfcase>

	<!-------------------- CRALetter ---------------------->
	<cfcase value="CRALetter">	
		<cfinclude template="#APPLICATION.localPath#/letterTemplates/acceptanceLetter.html">
	</cfcase>


	<!-------------------- Dispute letter ---------------------->
	<cfcase value="DisputeLetter">
		<cfinclude template="../letterTemplates/disputeLetterTemplate.html">
	</cfcase>	
	
	<!-------------------- Dispute letter no phone ---------------------->
	<cfcase value="DisputeLetterNoPhone">
		<cfinclude template="../letterTemplates/disputeLetterNoPhonetemplate.html">
	</cfcase>	


	<!-------------------- Verification Dispute letter ---------------------->
	<cfcase value="verificationDisputeLetter">
		<cfinclude template="../letterTemplates/VerificationDisputeLettertemplate.html">
	</cfcase>	
	
	<!-------------------- Verification Dispute letter no phone ---------------------->
	<cfcase value="verificationDisputeLetterNoPhone">
		<cfinclude template="../letterTemplates/VerificationDisputeLetterNoPhonetemplate.html">
	</cfcase>	

	<!-------------------- Generic Letter ---------------------->
	<cfcase value="genericLetter">
		<cfinclude template="#APPLICATION.localPath#/letterTemplates/acceptanceLetter.html">
	</cfcase>	


	<!-------------------- Briefing Letter ---------------------->
	<cfcase value="briefingLetter">
		<cfinclude template="#APPLICATION.localPath#/letterTemplates/acceptanceLetter.html">
	</cfcase>	

	
</cfswitch>

</body>
</html>


<!---
[letterType]<cfoutput>#arguments.letterType#</cfoutput>
[clientsName]<@@CLIENTNAME@@>
[userName]<@@USERNAME@@>
[actualDate]<@@DATE@@>
[clientAddress]<@@CLIENTADDRESS@@>
[clientCity]<@@CLIENTCITY@@>
[clientState]<@@CLIENTSTATE@@>
[clientZip]<@@CLIENTZIP@@>
[clientHomePhone]<@@CLIENTHOMEPHONE@@>
[clientCellPhone]<@@CLIENTCELLPHONE@@>
[clientMail]<@@CLIENTEMAIL@@>
[clientAccountNumber]<@@CLIENTACCOUNTNUMBER@@>
[clientPayment]<@@CLIENTMPAYMENT@@>
[clientNumber]<@@CLIENTRNUMBER@@>
[clientFIDate]<@@CLIENTFIDATE@@>
[clientAccountHolderName]<@@CLIENTACCOUNTHOLDERNAME@@>
[clientTotalRetainerFee]<@@CLIENTTOTALRETAINERFEE@@>
[traking]<@@TRACKING@@>
[flDate]<@@FLDATE@@>
[debtHolderName]<@@DEBTHOLDERNAME@@>
[debtHolderAccountNumber]<@@DEBTHOLDERACCOUNTNUMBER@@>
[debtHolderBalance]<@@DEBTHOLDERBALANCE@@>
[debtHolderAddress]<@@DEBTHOLDERADDRESS@@>
[debtHolderCity]<@@DEBTHOLDERCITY@@>
[debtHolderState]<@@DEBTHOLDERSTATE@@>
[debtHolderZip]<@@DEBTHOLDERZIP@@>
[dlDate]<@@DLDATE@@>
[saveIn]<@@SAVEIN@@>



---></cfsavecontent>

		<!--- Replace content --->
		<cfinvoke component="components.letters" method="repaceContent" returnVariable="thisLetter">
			<cfinvokeargument name="content" value="#letterData#">
			<cfinvokeargument name="tracking" value="#arguments.tracking#">
			<cfinvokeargument name="idDebtHolder" value="#arguments.idDebtHolder#">
			<cfinvokeargument name="flDate" value="#arguments.flDate#">
			<cfinvokeargument name="client1" value="#arguments.client1#">
			<cfinvokeargument name="client2" value="#arguments.client2#">
			<cfinvokeargument name="dlDate" value="#arguments.dlDate#">
		</cfinvoke>
		
		
		<!--- Write file --->
		<cfset letterFileName = "letter-#arguments.idFile#-#dateFormat(now(), 'yyyymmdd')##timeFormat(now(), 'hhmmss')#-#arguments.letterType#.pdf">

		<cfdocument filename="#APPLICATION.localPath#/lettersSaved/#letterFileName#" format="pdf" margintop="1" unit="cm">

			<style>
				.headTitle{
					font-size: 18px;
					font-weight: bold;
				}
			
				.headTitle2{
					font-style: italic;
					font-size: 8px;
				}
				
				.headTitle3{
					font-size: 8px;
				}
			
				.hr1 {
					height: 8px;
					margin-left: auto;
					margin-right: auto;
					background-color:black;
					color:black;
					border: 0 none;
					margin-top: 5px;
					margin-bottom:5px;
				}
			
				.hr2{
				}
			</style>

			
			<cfoutput>#thisLetter#</cfoutput>
		
		</cfdocument>

		<!--- Save creation information --->
		<cfquery name="saveLetterQuery" dataSource="#APPLICATION.db#">
			INSERT INTO letter
				(idFile, letterFileName, letterType, idDebtHolder, tracking)
			VALUES
				(
				#arguments.idFile#, 
				'#letterFileName#', 
				'#arguments.letterType#', 
				<cfif arguments.idDebtHolder EQ "">NULL<cfelse>#arguments.idDebtHolder#</cfif>, 
				'#arguments.tracking#'
				)
		</cfquery>


	</cffunction>



	<!------------------------------------------------------------------>
	
	<cffunction name="getLettersByFileId" access="remote" returnType="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">
	
		<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
		
		<cfquery name="getLettersByFileIdQuery" dataSource="#APPLICATION.db#">
		
			SELECT 
				idLetter,
				letterType,
				tracking,
				CONCAT(type, ' ', name, ' <em style="color: ##444; display: block;">', accountNumber, '</em>') AS thisDebtHolder,
				CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editLetter(',CAST(idLetter AS CHAR),');">&nbsp;&nbsp;<a href="lettersSaved/',CAST(letterFileName AS CHAR),'" target="_blank"><img class="btnDownload" title="Download" src="/template/images/download-icon.png"></a>'<cfif SESSION.userIdProfile EQ 1 OR SESSION.userIdProfile EQ 4>,'&nbsp;&nbsp;<img class="btnEdit" title="Delete" src="/template/images/delete-icon.png" onclick="deleteLetter(',CAST(idLetter AS CHAR),');">'</cfif>) AS actions	
			FROM
				letter LEFT JOIN debtHolder ON letter.idDebtHolder = debtHolder.idDebtHolder
			WHERE
				letter.idFile = #arguments.idFile#
				
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		ORDER BY #gridsortcolumn# #gridsortdirection#
	      	</cfif>
	
		
		</cfquery>
	
		<cfreturn queryconvertforgrid(getLettersByFileIdQuery,page,pagesize)/>
	
	</cffunction>



	<!------------------------------------------------------------------>
	
	<cffunction name="getLetterById" access="public" returnType="query">
	
		<cfargument name="idLetter" type="numeric" required="true">
		
		<cfquery name="getLetterByIdQuery" dataSource="#APPLICATION.db#">
		
			SELECT 
				idLetter,
				letterType,
				letterFileName,
				tracking
			FROM
				letter
			WHERE
				idLetter = #arguments.idLetter#

	
		
		</cfquery>
	
		<cfreturn getLetterByIdQuery>
	
	</cffunction>



	<!------------------------------------------------------------------>
	
	<cffunction name="editLetter" access="public">
	
		<cfargument name="idLetter" type="numeric" required="true">
		<cfargument name="tracking" type="string" default="">
		
		<cfquery name="editLetterQuery" dataSource="#APPLICATION.db#">
			UPDATE
				letter
			SET
				tracking = '#arguments.tracking#'
			WHERE
				idLetter = #arguments.idLetter#
		</cfquery>

	</cffunction>


	<!------------------------------------------------------------------>
	
	<cffunction name="deleteLetter" access="public">
	
		<cfargument name="idLetter" type="numeric" required="true">

		<cfquery name="getLetterFile" dataSource="#APPLICATION.db#">
			SELECT letterFileName
			FROM 
				letter
			WHERE
				idLetter = #arguments.idLetter#
		</cfquery>
		
		<cftry>
			<cffile action="delete" file="#APPLICATION.localPath#/lettersSaved/#getLetterFile.letterFileName#">
		<cfcatch type="any"></cfcatch>
		</cftry>
		<cfquery name="editLetterQuery" dataSource="#APPLICATION.db#">
			DELETE FROM
				letter
			WHERE
				idLetter = #arguments.idLetter#
		</cfquery>

	</cffunction>

	<!------------------------------------------------------------------>
	
	<cffunction name="repaceContent" access="public" returnType="string">
	
		<cfargument name="content" type="string" required="true">
		<cfargument name="idDebtHolder" required="false" default="">
		<cfargument name="tracking" required="false" type="string" default="">
		<cfargument name="flDate" required="false" default="">
		<cfargument name="client1" required="false" default="">
		<cfargument name="client2" required="false" default="">
		<cfargument name="dlDate" required="false" default="">
				
		<cfinvoke component="components.file" method="getFileById" returnVariable="thisFileQuery">
			<cfinvokeargument name="idFile" value="#SESSION.idFile#">
		</cfinvoke>

		
		<!--- Client name --->
		<cfset thisClientName = "#thisFileQuery.firstName# #thisFileQuery.initial# #thisFileQuery.lastName#">
		<cfset thisSaveIn = "#thisFileQuery.lastName# #thisFileQuery.firstName#">
		
		<!--- Replace functions --->
		<cfset replacedContet = arguments.content>
			
			<!--- USER --->

			<!--- two users --->
			<cfif arguments.client1 EQ 1 OR arguments.client2 EQ 1>
				<cfset thisBothClients = "">
				<cfif arguments.client1 EQ 1>
					<cfset thisBothClients = thisClientName>
				</cfif>
				<cfif arguments.client2 EQ 1>
					<cfif arguments.client1 EQ 1>
						<cfset thisBothClients = "#thisBothClients# and">
					</cfif>
					<cfset thisBothClients = "#thisBothClients# #thisFileQuery.scFirstName# #thisFileQuery.scInitial# #thisFileQuery.scLastName#">
				</cfif>
				<cfset replacedContet = Replace(replacedContet, "<@@CLIENTNAME@@>", "#thisBothClients#", "all")>

			<cfelse>
				<cfset replacedContet = Replace(replacedContet, "<@@CLIENTNAME@@>", "", "all")>			
			</cfif>
			
			<cfset replacedContet = Replace(replacedContet, "<@@USERNAME@@>", "#SESSION.userName#", "all")>
			
			<cfset replacedContet = Replace(replacedContet, "<@@DATE@@>", "#dateFormat(now(), 'mmmm dd, yyyy')#", "all")>
			<!--- CLIENT --->
			<cfset replacedContet = Replace(replacedContet, "<@@SAVEIN@@>", "#thisSaveIn#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTADDRESS@@>", "#thisFileQuery.address#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTCITY@@>", "#thisFileQuery.city#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTSTATE@@>", "#UCase(thisFileQuery.name)#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTZIP@@>", "#thisFileQuery.zip#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTHOMEPHONE@@>", "#thisFileQuery.homePhone#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTCELLPHONE@@>", "#thisFileQuery.cellPhone#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTEMAIL@@>", "#thisFileQuery.email#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTACCOUNTNUMBER@@>", "#thisFileQuery.itkAccountNumber#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTMPAYMENT@@>", "#dollarFormat(thisFileQuery.itkMontlyPayment)#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTRNUMBER@@>", "#thisFileQuery.itkRoutingNumber#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTFIDATE@@>", "#dateFormat(thisFileQuery.itkFirstInstallmentDate, 'mmmm dd, yyyy')#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTACCOUNTHOLDERNAME@@>", "#thisFileQuery.itkAccountHolderName#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@CLIENTTOTALRETAINERFEE@@>", "#thisFileQuery.itkTotalRetainerFee#", "all")>

			
		<!--- tracking ---->
		<cfif arguments.tracking NEQ "">
			<cfset replacedContet = Replace(replacedContet, "<@@TRACKING@@>", "#arguments.tracking#", "all")>
		<cfelse>
			<cfset replacedContet = Replace(replacedContet, "<@@TRACKING@@>", "", "all")>					
		</cfif>

		<!---- flDate --->
		<cfif arguments.flDate NEQ "">
			<cfset replacedContet = Replace(replacedContet, "<@@FLDATE@@>", "#dateFormat(arguments.flDate, 'mmmm dd, yyyy')#", "all")>					
		<cfelse>
			<cfset replacedContet = Replace(replacedContet, "<@@FLDATE@@>", "", "all")>
		</cfif>

		<!---- dlDate --->
		<cfif arguments.dlDate NEQ "">
			<cfset replacedContet = Replace(replacedContet, "<@@DLDATE@@>", "#dateFormat(arguments.dlDate, 'mmmm dd, yyyy')#", "all")>					
		<cfelse>
			<cfset replacedContet = Replace(replacedContet, "<@@DLDATE@@>", "", "all")>
		</cfif>
		
		<!--- DEBTHOLDER--->	
		<cfif idDebtHolder NEQ "">	
			<cfinvoke component="components.debtHolder" method="getHolderById" returnVariable="thisDebtHolderQuery">
				<cfinvokeargument name="idDebtHolder" value="#arguments.idDebtHolder#">
			</cfinvoke>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERNAME@@>", "#thisDebtHolderQuery.name#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERACCOUNTNUMBER@@>", "#thisDebtHolderQuery.accountNumber#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERBALANCE@@>", "#dollarFormat(thisDebtHolderQuery.balance)#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERADDRESS@@>", "#thisDebtHolderQuery.address#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERCITY@@>", "#thisDebtHolderQuery.city#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERSTATE@@>", "#UCase(thisDebtHolderQuery.debtHolderState)#", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERZIP@@>", "#thisDebtHolderQuery.zip#", "all")>
		<cfelse>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERNAME@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERACCOUNTNUMBER@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERBALANCE@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERADDRESS@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERCITY@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERSTATE@@>", "", "all")>
			<cfset replacedContet = Replace(replacedContet, "<@@DEBTHOLDERZIP@@>", "", "all")>		
		</cfif>
	
		<cfreturn replacedContet>
		
	</cffunction>


</cfcomponent>