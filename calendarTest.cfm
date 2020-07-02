<cfset test = 1>
<cfoutput>#test#23</cfoutput>

<!---
<cfoutput>
<cfset value = " 2,345.33">
<cfset value = val(trim(replace(value, ",", "")))>
#val(value)#<br>
--->



<!---
<cfquery name="test" dataSource="cdlg">
	UPDATE history SET detail = <cfqueryparam value="#value#" CFSQLType="CF_SQL_DOUBLE"> WHERE idHistory = 1
</cfquery>
--->

</cfoutput>


<!---


<cfinvoke component="components.user" method="getUsersById" returnVariable="thisIserInf">
	<cfinvokeargument name="idUser" value="12">
</cfinvoke>
Encriptado:<cfdump var="#thisIserInf.password#"><br>
<cfscript>
	decryptedPassword = decrypt(thisIserInf.password,thisIserInf.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
</cfscript>
Pass:
<cfdump var="#decryptedPassword#">
<hr>
<cfform name="test">
User:<cfinput type="text" name="userName" value="natalia@consumerdebtlegalgroup.com"><br>
Pass:<cfinput type="text" name="password" value="barahona1"><br>
<cfinput type="submit" name="submit" value="submit">
</cfform>
<cfif isDefined("FORM.userName")>	

	<cfscript>
		encryptedPassword = encrypt(FORM.password,FORM.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
	</cfscript>
	
	Encriptado:<cfdump var="#encryptedPassword#"><br>
	lastEncriptado: <cfoutput>#Replace(encryptedPassword, '\', '\')#</cfoutput><br>
	<cfscript>
		decryptedPassword = decrypt(encryptedPassword,FORM.userName,APPLICATION.codeAlgorithm,APPLICATION.codeEncoding);
	</cfscript>
	<br>Pass:
	<cfdump var="#decryptedPassword#">

</cfif>

---->




<!--- <cfset gCal = createObject("components.GoogleCalendar").init("natalia@consumerdebtlegalgroup.com","barahona1",-5)> --->
<!---
<cfset newCalendar = application.gCal.addCalendar(title = "testTitle", description = "testDesc", color= "##2952A3")>

<cfdump var="#newCalendar#">

--->



<!---
<cfset calendars = gCal.getCalendars()>

<cfdump var="#calendars#">
--->





<!--- <cfset application.gCal.deleteEvent('http://www.google.com/calendar/feeds/jairo.botero%40gmail.com/private/full/sltkndcnt0l81uc58kag8p25m4')> --->

<!---
<cfset events = gCal.getEvents("consumerdebtlegalgroup.com_77eleqijbdl950i3vgmem1iql8%40group.calendar.google.com")>

<cfdump var="#events#">
--->





<!---
<cfset title = "Test Event">
<cfset description = "This is a test event.">
<cfset authorName = "testJairo">
<cfset authorEmail = "jairo.botero@nyxent.com">
<cfset where = "Mars">
<cfset startTime = createDateTime(2011, 8, 16, 3, 0, 0)>
<cfset endTime = createDateTime(2011, 8, 16, 3, 30, 0)>

<cfinvoke component="#gcal#" method="addEvent" returnVariable="result">
	<cfinvokeargument name="title" value="#title#">
	<cfinvokeargument name="description" value="#description#">
	<cfinvokeargument name="authorname" value="#authorname#">
	<cfinvokeargument name="authormemail" value="#authoremail#">
	<cfinvokeargument name="where" value="#where#">
	<cfinvokeargument name="start" value="#starttime#">
	<cfinvokeargument name="end" value="#endtime#">
</cfinvoke>

<cfset thisXmlReturn = XmlParse(result.fileContent)>

<cfdump var="#thisXmlReturn#">

<cfoutput>#ToString(thisXmlReturn.entry.id.XmlText)#</cfoutput>

--->


<!---- google autenticatio test 


<cfinvoke component="components.google" method="authenticate">
	<cfinvokeargument name="username" value="jairo.botero@nyxent.com">
	<cfinvokeargument name="password" value="4383jbccg">
</cfinvoke>
--->















<!---
<h1>Your Magic numbers</h1>
<p>It will take us a little while to calculate your ten magic numbers. It takes a lot of work to find numbers that truly fit your personality. So relax for a minute or so while we do the hard work for you.</p>
<H2>We are sure you will agree it was worth the short wait!</H2>
<cfflush>

<cfflush interval=10>
--->
<!--- Delay Loop to make it seem harder. --->
<!---
<cfloop index="randomindex" from="1" to="200000" step="1">
    <cfset random=rand()>
</cfloop>
--->

<!--- Now slowly output 10 random numbers. --->
<!---
<cfloop index="Myindex" from="1" to="10" step="1">
    <cfloop index="randomindex" from="1" to="100000" step="1">
        <cfset random=rand()>
    </cfloop>
    <cfoutput>
        Magic number #Myindex# is:&nbsp;&nbsp;#RandRange(100000, 999999)#<br><br>
    </cfoutput>
</cfloop>
--->













<!---


<cfloop list="30,31,32" index="test"><cfoutput>#test#</cfoutput></cfloop>

--->





<!---
<cfset test = '{"SYS_LANG":"en","SYS_SKIN":"green","SYS_SYS":"cdlgweb","APPLICATION":"2466501014e39d6423ebfd5082598076","PROCESS":"5752868654cced9630b71c5001062128","TASK":"6902160644cced9630dbd86089748381","INDEX":"4","USER_LOGGED":"00000000000000000000000000000001","USR_USERNAME":"admin","PIN":"NEMR","CDAIAgentName":"","agentName":"Administrator admin","agentEmail":"admin@processmaker.com","LeadRef":"4e39d642cba33","LeadRefLink":"http:\/\/www.credit-defender.com\/documents.php?thisUser=4e39d642cba33","Language":null,"ddIntakeLenguage":"English","sbttl_PrimaryContactInformation":null,"txIntakeFirstName":"TESTMIGRATION1","txIntakeMiddleInitial":"","txIntakeLastName":"TESTMIGRATION1","txIntakeHomePhone":"123 4567","txIntakeBusinessPhone":"","txIntakeCellPhone":"","txIntakeEmail":"","txIntakeDOB":"","txIntakeSS":"","txIntakeStreet":"testMigration1","txIntakeCity":"testMigration1","ddIntakeStates":"27","ddIntakeStates_label":"Mississippi","txIntakeZip":"12345","sbttlSecondaryContact":null,"txIntakeFirstName2":"","txIntakeMiddle2":"","txIntakeLastName2":"","txIntakeHome2":"","dtIntakeDOB2":"","txIntakeSS2":"","txIntakeStreetAddress2":"","txCity2":"","ddIntakeStates2":"1","ddIntakeStates2_label":"Alabama","txIntakeZip2":"","sbttlCreditors":null,"dgIntakeCreditorList":{"1":{"txIntakeCreditor":"test","txCreditorAccountNumber":"534534","curCreditorBalance":"500","txCreditorNote":"test","hdDocName":"","hdDocDir":""},"2":{"txIntakeCreditor":"test2","txCreditorAccountNumber":"543543","curCreditorBalance":"800","txCreditorNote":"test","hdDocName":"","hdDocDir":""}},"subtitleDebtCollectors":null,"DebtColectorsGrid":{"1":{"txCollectorsCreditor":"","txCollectorsAccountNumber":"","curCollectorBalance":"","txCollectorNote":"","hdDocName":"","hdDocDir":""}},"sbttlIntake":null,"curIntakeTotalDebt":"1300.00","ddIntakeProgramLenght":"6","ddIntakeTotalRetainer":"1500.00","curIntakeMonthlyPayment":"250.00","curIntakeDownPayment":"0","dtIntakeDownPayment":"","dtIntakeFirstInstallment":"","txIntakeBankName":"","txIntakeAccountHoldersName":"","txIntakeRoutingNumber":"","txIntakeAccountNumber":"","sbttlLawsuit":null,"dgIntakeLawSuits":{"1":{"txLawSuitsPlantiff":"","ddLawSuitsStatus":"1","dtLawSuitsDate":""}},"sbttlSettlementCompany":null,"dgIntakeSettlement":{"1":{"txSettlementFinancialInstitution":"","txSettlementRoutingNumber":"","txSettlementStreetAddress":"","txSettlementCity":"","txSettlementState":"","txSettlementZip":"","txSettlementCurrentBalance":""}},"sbttlRelatedFiles":null,"lkImportedDocuments":null,"flIntakeUpload":"","sbttlCompleted":null,"ynIntakeCompleted":"0","hdIntakeAgentEmail":"@@agentEmail","ynIntakeKillLead":"0","ftIntakeChat":"","ddAttorneyCommentType":"","ddAttorneyCommentType_label":"","tfIntakeComment":"","hdState":"","SYS_GRID_AGGREGATE_dgIntakeCreditorList_curCreditorBalance":"1300.00","hiddenIntakeCreditorList":"a:2:{i:1;a:6:{s:16:\"txIntakeCreditor\";s:4:\"test\";s:23:\"txCreditorAccountNumber\";s:6:\"534534\";s:18:\"curCreditorBalance\";s:3:\"500\";s:14:\"txCreditorNote\";s:4:\"test\";s:9:\"hdDocName\";s:0:\"\";s:8:\"hdDocDir\";s:0:\"\";}i:2;a:6:{s:16:\"txIntakeCreditor\";s:5:\"test2\";s:23:\"txCreditorAccountNumber\";s:6:\"543543\";s:18:\"curCreditorBalance\";s:3:\"800\";s:14:\"txCreditorNote\";s:4:\"test\";s:9:\"hdDocName\";s:0:\"\";s:8:\"hdDocDir\";s:0:\"\";}}"}'>
<cfdump var="#test#" expand="yes">
<br><br>
<cfdump var="#DeserializeJSON(test)#" expand="yes">
--->
