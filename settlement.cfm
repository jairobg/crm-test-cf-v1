<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Settlements') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>



	function deleteSettlement(idSettlement, financialInstitution){
		ColdFusion.Window.create(
		'deleteSettlement'+idSettlement,
		'Delete',
		'settlementDelete.cfm?idSettlement='+idSettlement+'&financialInstitution='+financialInstitution,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			height: 220
		}
		);
	}


	function editSettlement(idSettlement){
		ColdFusion.Window.create(
		'editSettlement'+idSettlement,
		'Edit',
		'settlementEdit.cfm?idSettlement='+idSettlement,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 800,
			height: 450
		}
		);
	}

</script>


<!----- Content ----->
<cfdiv id="settlementFormDiv" bind="url:settlementForm.cfm" style="height:420px">
</cfdiv>


<cfform name="settlementGridForm">
	<cfgrid 
		name="settlementGrid"
		bindOnLoad="true" 
		bind="cfc:components.settlement.getSettlementByIdFile({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="idSettlement" display="no">
			<cfgridcolumn name="financialInstitution" header="Financial Institution" width="185">
			<cfgridcolumn name="routingNumber" header="Routing Number" width="100">
			<cfgridcolumn name="address" header="Address" width="100">
			<cfgridcolumn name="city" header="City" width="50">
			<cfgridcolumn name="zip" header="Zip" width="100">
			<cfgridcolumn name="name" header="State" width="100">
			<cfgridcolumn name="Actions" header="Actions" width="50" dataAlign="Center">
			
	</cfgrid>
</cfform>

<cfinclude template="template/footer.cfm">