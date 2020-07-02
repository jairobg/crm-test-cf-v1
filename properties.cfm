<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Client') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>

	function deleteProperty(idProperty){
		ColdFusion.Window.create(
		'deleteProperty'+idProperty,
		'Delete',
		'propertyDelete.cfm?idProperty='+idProperty,
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


	function editProperty(idProperty){
		ColdFusion.navigate('propertyEditForm.cfm?idProperty='+idProperty,'propertyFormDiv');
	}


</script>


<!------  Content ----->


<cfform name="propertiesGridForm">
	<cfgrid 
		name="propertiesGrid"
		bindOnLoad="true" 
		bind="cfc:components.properties.getPropertyByFileId({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="idProperty" header="Id">
			<cfgridcolumn name="address" header="Address" width="385">
			<cfgridcolumn name="Edit" header="Actions" width="100" dataAlign="Center">

	</cfgrid>
</cfform>

<cfdiv id="propertyFormDiv" bind="url:propertyAddForm.cfm">
</cfdiv>

<cfinclude template="template/footer.cfm">