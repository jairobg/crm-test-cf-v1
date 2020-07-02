<cfinclude template="template/header.cfm">



<cfform name="reportClientAffiliatesForm">
	
	<fieldset>
		<legend>Clients Affiliate Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reports/clientsAffiliatesReport.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			

<!-------------------------------------------------------------------------->



<cfform name="reportClientAffiliatesTotalsForm">
	
	<fieldset>
		<legend>Clients Affiliate Totals Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reports/clientsAffiliatesReportTotals.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			

<!-------------------------------------------------------------------------->


<cfform name="reportClosedDealsForm">
	
	<fieldset>
		<legend>Closed Deals Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reportClosedDeals.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			

<!-------------------------------------------------------------------------->

<cfform name="reportNSFForm">
	
	<fieldset>
		<legend>NSF Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reportNSF.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			

<!-------------------------------------------------------------------------->

<cfform name="reportClientStatusForm">
	
	<fieldset>
		<legend>Client Status Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reportClientStatus.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			

<!-------------------------------------------------------------------------->

<cfform name="reportClientCancellationForm">
	
	<fieldset>
		<legend>Client Cancellation Report</legend>
	</fieldset>
	
</cfform>

<fieldset class="action-buttons">
	<cfoutput>
	<input 
		type="submit" 
		name="submit" 
		value="Generate" 
		onclick="window.open(
  					'#APPLICATION.website_url#/reportClientCancellation.cfm',
  					'_blank'
	);">
	</cfoutput>
</fieldset>

<hr class="style-four" />			


<cfinclude template="template/footer.cfm">