	<cfif isDefined('SESSION.userId')>
			
				</div><!--left-->
				<div class="right">
				
					<section class="toolbox">
						<!------->
						<h3>General</h3>
						<nav id="general-nav">
							
							<!---
							<li id="item1"><a href="https://www.google.com/calendar/" target="_blank">Calendar</a></li>
							--->
							
							<cfif  listFind(arrayToList(SESSION.permission), 'Tasks') NEQ 0>
							<li id="item2"><a href="tasks.cfm">Tasks</a></li>
							</cfif>

							<cfif  listFind(arrayToList(SESSION.permission), 'Archive') NEQ 0>
							<li id="item2"><a href="archive.cfm">Archive</a></li>
							</cfif>
							
							<li id="item1"><a href="#" onclick="clientCalculator();">Retainer Calculator</a></li>

							<!----------------------->
							<!--- Last 10 clients --->
							<!----------------------->
							<cfdiv id="lastTenClientsDiv" bind="url:lastTenClients.cfm">
							</cfdiv>

							
							<cfdiv id="menuDocumentsDiv" bind="url:menuDocuments.cfm">
							</cfdiv>
						</nav>
						
						<!------->
						<cfif SESSION.idFile NEQ 0>
						<h3>Retainer Status</h3>
						<cfdiv id="menuRetainerDiv" bind="url:menuRetainer.cfm"></cfdiv>
						</cfif>
						<!------->
						<h3>Flow Control</h3>
						<cfdiv id="flowControlDiv" bind="url:flowControl.cfm"></cfdiv>
						
						<!------->
						<h3>Administration</h3>
						<nav id="general-nav">
						
						<cfif SESSION.isGoogleAccount NEQ 1>
							<li id="item3">
								<a href="changePassword.cfm">Change Password</a>
							</li>
						</cfif>
						
						<cfif  listFind(arrayToList(SESSION.permission), 'Users') NEQ 0 OR listFind(arrayToList(SESSION.permission), 'Users') NEQ 0>

							<cfif  listFind(arrayToList(SESSION.permission), 'Payment') NEQ 0>
							<li id="item2">
								<a href="paymentsOutstanding.cfm?type=EPPS">Payment EPPS</a>
							</li>
							<li id="item2">
								<a href="paymentsOutstanding.cfm?type=Paytoo">Payment Paytoo</a>
							</li>
							</cfif>

							<cfif  listFind(arrayToList(SESSION.permission), 'Affiliates') NEQ 0>
							<li id="item2"><a href="affiliate.cfm">Affiliates Companies</a></li>
							</cfif>
							
							<cfif  listFind(arrayToList(SESSION.permission), 'Users') NEQ 0>
							<li id="item2"><a href="user.cfm">Users</a></li>
							</cfif>

							<cfif  listFind(arrayToList(SESSION.permission), 'Reports') NEQ 0>
							<li id="item2"><a href="reports.cfm">Reports</a></li>
							</cfif>

							<cfif  listFind(arrayToList(SESSION.permission), 'Reports') NEQ 0>
							<li id="item2"><a href="reportForMailing.cfm">Report Mailing</a></li>
							</cfif>
							
						</nav>
						</cfif>
						
					</section>
				</div><!--right-->
				<div class="clearfix"></div>
				
			</div><!--wrapper-->
			<div class="clearfix"></div>			
		</section><!--#main-->
	</cfif>
	
	
	<footer id="footer">
		<div class="wrapper">
			<div class="left">
				<small>CRMLEX RLG &copy; 2015</small>
			</div>
			<div class="right">
				<!--right content-->
			</div>
			<div class="clearfix"></div>
		</div><!--wrapper-->
	</footer>


<cfif isDefined("SESSION.affiliateCompanyId")>
	<cfinvoke  component="components.intake" method="getAffiliatePercent" returnVariable="thisAffPercent">
		<cfinvokeargument name="affiliateCompanyId" value="#SESSION.affiliateCompanyId#">
	</cfinvoke>
<cfelse>
	<cfset thisAffPercent = 40>
</cfif>


<cfoutput>
<script type="text/javascript">

	function calculatorIntakeValues(){
		
		var totalDeb = document.getElementById('calTotalDeb').value;
		var downPayment = document.getElementById('calDownPayment').value;		
		var programLenght = document.getElementById('calProgramLenght').value;
		var totalRetainerFee;
		var monthlyRetainer;
		var litigationFee = 59.99;
		var monthlyProcessingFee = 5.00;
		var monthlyPayment;
		
		//Calculation
		totalRetainerFee = totalDeb * #thisAffPercent#/100;
		totalRetainerFee = totalRetainerFee.toFixed(2);

		monthlyRetainer = (totalRetainerFee - downPayment) / programLenght;
		monthlyRetainer = monthlyRetainer.toFixed(2);
		
		monthlyPayment = Number(monthlyRetainer) + litigationFee + monthlyProcessingFee;
		monthlyPayment = monthlyPayment.toFixed(2);
		
		//Show result
		document.getElementById('calTotalDeb').value = totalDeb;
		document.getElementById('calTotalRetainerFee').value = totalRetainerFee;
		document.getElementById('calMonthlyRetainer').value = monthlyRetainer;
		document.getElementById('calMonthlyPayment').value = monthlyPayment;
		
	}

	
	function clientCalculator(){
		ColdFusion.Window.create(
		'clientCalculator',
		'Calculator',
		'clientCalculator.cfm',
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			height: 410
		}
		);
	}
	
	
	
	
	

 	function submitFormUpdateR() { 
  
        ColdFusion.Ajax.submitForm('retainerStatusForm', 'php/updateState.php', callback1, 
            errorHandler1); 
    } 

 	function submitFormCancelR() { 
  
	 	var r = confirm("Do you want to void this retainer?");
	 	
	 	if (r == true){
	        ColdFusion.Ajax.submitForm('retainerCancelForm', 'php/canceledRetainer.php', callback1, errorHandler1); 
	 	}

    } 
     
    function callback1(text) 
    { 
        //alert(text);
        ColdFusion.navigate('menuRetainer.cfm','menuRetainerDiv');
    } 
     
    function errorHandler1(code, msg) 
    { 
        alert("Error!!! " + code + ": " + msg); 
    } 

	disableDoubleClick = function() {
        if (typeof(_linkEnabled)=="undefined") _linkEnabled = true;
        setTimeout("blockClick()", 100);
        return _linkEnabled;
    }
    blockClick = function() {
        _linkEnabled = false;
        setTimeout("_linkEnabled=true", 10000);
    }
	
	
</script>
</cfoutput>

	<cfif isDefined("SESSION.userId")>		
		<cfif APPLICATION.website_url EQ "http://rlg-dev.crmlex.com" OR #SESSION.userId# EQ 2>
			<cfdump var="#SESSION#" expand="yes" />
			<cfdump var="#APPLICATION#" expand="yes" />
		</cfif>
	</cfif>

</body>
</html>