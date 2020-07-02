<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Affiliates') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>

	
	function deleteAffiliate(affiliateCompanyId){
		ColdFusion.Window.create(
		'deleteAffiliate'+affiliateCompanyId,
		'Delete',
		'affiliateDelete.cfm?affiliateCompanyId='+affiliateCompanyId,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			height: 230
		}
		);
	}


	function editAffiliate(affiliateCompanyId){
		ColdFusion.Window.create(
		'editAffiliate'+affiliateCompanyId,
		'Edit',
		'affiliateEdit.cfm?affiliateCompanyId='+affiliateCompanyId,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 430
		}
		);
	}


</script>


<!------  Content ----->
<cfdiv id="affiliateFormDiv" bind="url:affiliateForm.cfm">
</cfdiv>


<cfform name="affiliateGridForm">
	<cfgrid 
		name="affiliateGrid"
		bindOnLoad="true" 
		bind="cfc:components.affiliates.getAffiliatesForGrid({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="285" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="affiliateCompanyName" header="Affiliate Name" width="300">
			<!---
			<cfgridcolumn name="adminFullUserName" header="Administrator" width="300">
			--->
			<cfgridcolumn name="affiliateCreationDate" header="Creation Date" width="100">
			<cfgridcolumn name="actions" header="Actions" width="90" dataAlign="Center">

	</cfgrid>
</cfform>


<cfinclude template="template/footer.cfm">