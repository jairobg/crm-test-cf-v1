<cfif listlast(cgi.script_name,'/') NEQ "index.cfm" AND NOT isDefined("SESSION.permission")>
	<cflocation url="index.cfm" addToken="no">
</cfif>
<!------ AJAX libraries ----->
<cfajaximport tags="cfgrid,cfdiv,cfform,cfwindow,cfinput-datefield,cflayout-tab,cfinput-autosuggest">

<!---Get the page name--->
<cfset currentPageName ="">
<cfswitch expression="#listlast(cgi.script_name,'/')#">
	<cfcase value="search.cfm" >
		<cfset currentPageName = "search">
	</cfcase>
	<cfcase value="fileEditForm.cfm" >
		<cfset currentPageName = "clients">
	</cfcase>
    <cfcase value="properties.cfm" >
		<cfset currentPageName = "properties">
	</cfcase>	
	<cfcase value="creditors.cfm" >
		<cfset currentPageName = "creditors">
	</cfcase>
	<cfcase value="intakeForm.cfm" >
		<cfset currentPageName = "intake">
	</cfcase>
	<cfcase value="lawsuit.cfm" >
		<cfset currentPageName = "lawsuits">
	</cfcase>
	<cfcase value="settlement.cfm" >
		<cfset currentPageName = "settlements">
	</cfcase>
	<cfcase value="history.cfm" >
		<cfset currentPageName = "notes">
	</cfcase>
	<cfcase value="legalMatters.cfm" >
		<cfset currentPageName = "legal-matters">
	</cfcase>
    <cfcase value="payments.cfm" >
		<cfset currentPageName = "payments">
	</cfcase>
    <cfcase value="paymentsImport.cfm" >
		<cfset currentPageName = "paymentsImport">
	</cfcase>
    <cfcase value="archive.cfm" >
		<cfset currentPageName = "archive">
	</cfcase>
    <cfcase value="user.cfm" >
		<cfset currentPageName = "user">
	</cfcase>
</cfswitch>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en" class="no-js"> 
<!--<![endif]-->
<head>
	<meta charset="UTF-8">
	
	<title>RLG - CMRLex</title>
	
	<meta name="description" content="CRMLEX">
	<meta name="author" content="NYXENT www.nyxent.com">
	
	<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->
	<!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
	
	<link rel="shortcut icon" href="<cfoutput>#application.template_path#</cfoutput>/favicon.ico">
	<link rel="apple-touch-icon" href="<cfoutput>#application.template_path#</cfoutput>/apple-touch-icon.png">
	
	<link rel="stylesheet" href="<cfoutput>#application.template_path#</cfoutput>/css/cf-ui-reset.css">
	<link rel="stylesheet" href="<cfoutput>#application.template_path#</cfoutput>/css/reset.css">
	<link rel="stylesheet" href="<cfoutput>#application.template_path#</cfoutput>/css/style.css?v=2">
	<link rel="stylesheet" href="<cfoutput>#application.template_path#</cfoutput>/css/cf-ui-reset.css">

	<script src="<cfoutput>#application.template_path#</cfoutput>/js/libs/modernizr-1.6.min.js"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
	<script src="<cfoutput>#application.template_path#</cfoutput>/js/jquery.infieldlabel.min.js" type="text/javascript" charset="utf-8"></script>
	
    <!--- JQuery Validation --->    
    <cfoutput>
    <script type="text/javascript" src="#application.template_path#js/validate/jquery.validate.js"></script> 
    <script type="text/javascript" src="#application.template_path#js/validate/jquery.maskedinput.js"></script> 

<!---
	<script type="text/javascript" src="#application.template_path#js/validate/forms/mkDates.js"></script>
--->
	</cfoutput>	
</head>

<script type="text/javascript">

	<!---

		Lleva a la pagina de busqueda cuando se busca desde el header

	--->

	function goToSearch(e){
		if(e.keyCode == 13) {
			var thisPreSearch = document.getElementById('searchedWordHeader').value;
			window.location = 'search.cfm?preSearch='+thisPreSearch;
		}
	}


	function showLastClientSubmit(){
		document.getElementById('submitLastClient').style.display = 'inline';
	}

</script>


<!------ Functionality ----->

<cfoutput>
<script>
	function selectFile(idFile){
		ColdFusion.navigate('headerFileInf.cfm?idFile='+idFile,'headerFileInfDiv');
		ColdFusion.navigate('menuDocuments.cfm','menuDocumentsDiv');
		ColdFusion.navigate('lastTenClients.cfm','lastTenClientsDiv');
		setTimeout("goToClient()", 1000);
			
	}


	function goToClient(){
		window.location = '#APPLICATION.website_url#/fileEditForm.cfm';
	}

	
	function goToLM(){
		window.location = '#APPLICATION.website_url#/legalMatters.cfm';	
	}
	
	
	function addNewFile(){
		window.location = '#APPLICATION.website_url#/fileAddForm.cfm?idFile=0';
	}
</script>
</cfoutput>



<body id="<cfoutput>#currentPageName#</cfoutput>">
	<header id="top">
		<div class="wrapper">
		
			<div class="left">
				<div id="logo">
					<a href="<cfoutput>#APPLICATION.website_url#</cfoutput>"><img src="<cfoutput>#application.template_path#</cfoutput>/images/cdlg-logo.png" title="home" alt="Consumer Debt Legal Group" /></a>
				</div>
				
					<cfif isDefined('SESSION.userId')>
						<div id="welcome">
							<h3>welcome</h3>
							<p><cfoutput>#SESSION.userName#</cfoutput></p>	
						</div>	
					<cfelse>
						<div id="left-space">
							<p><!--some content--></p>
						</div>
					</cfif>

			</div><!--left-->

			<div class="right">
			
				<div id="top-info">
					<cfif isDefined('SESSION.userId')>
						<!---Show client info--->
						<!--- change client for url --->
						<cfoutput>
						<cfif isDefined("URL.idFile")>
							<cfset thisIdFile = URL.idFile>
						<cfelse>
							<cfset thisIdFile = "">
						</cfif>
						<cfdiv id="headerFileInfDiv" bind="url:headerFileInf.cfm?idFile=#thisIdFile#"></cfdiv>
						</cfoutput>				
					</cfif>
				</div>
				
				<div id="top-bar">
					<cfif isDefined('SESSION.userId')>
						<!--- Show Admin Nav Bar--->
						<nav id="main-nav">
							<ul>
								<cfif  listFind(arrayToList(SESSION.permission), 'Search') NEQ 0>
									<li id="item1"><a href="search.cfm">Search</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'Client') NEQ 0>
									<li id="item2"><a href="fileEditForm.cfm">Client</a></li>
                                    <!---
                                    <li id="item3"><a href="properties.cfm">Properties</a></li>
                                    --->
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'Creditor') NEQ 0>
									<li id="item4"><a href="creditors.cfm">Accounts Enrolled</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'Intake') NEQ 0>
									<li id="item5"><a href="intakeForm.cfm">Intake</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'Lawsuits') NEQ 0>
									<li id="item6"><a href="lawsuit.cfm">Lawsuits</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'Settlements') NEQ 0>
									<li id="item7"><a href="settlement.cfm">Settlements</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'History') NEQ 0>
									<li id="item8"><a href="history.cfm">Notes</a></li>
								</cfif>
								<cfif  listFind(arrayToList(SESSION.permission), 'LegalMatters') NEQ 0>
									<li id="item9"><a href="legalMatters.cfm">Legal Matters</a></li>
								</cfif>
							</ul>
						</nav>
			
						<nav id="sub-nav">
							<ul>
								<li id="item-logout"><a href="logout.cfm">Logout</a></li>
							</ul>
						</nav>
					<cfelse>					
						<!--- Show Login Title--->
						<div id="login-title">
							<h2>LOGIN</h2>
						</div>
					</cfif>
					<div class="clearfix"></div>	
				</div><!--top-bar-->
				
			</div><!--right-->
			
			<div  class="clearfix"></div>
		</div><!-- wrapper-->
	</header>


	<cfif isDefined('SESSION.userId')>
		<div class="clearfix"></div>
		<section id="main">
			<div class="wrapper">
			
				<!---Show Content Page--->
				<div class="left">
				
	</cfif>	