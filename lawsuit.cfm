<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Lawsuits') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>

	
	function deleteLawsuit(idLawsuit, plantiff){
		ColdFusion.Window.create(
		'deleteLawsuit'+idLawsuit,
		'Delete',
		'lawsuitDelete.cfm?idLawsuit='+idLawsuit+'&plantiff='+plantiff,
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


	function editLawsuit(idLawsuit){
		ColdFusion.Window.create(
		'editLawsuit'+idLawsuit,
		'Edit',
		'lawsuitEdit.cfm?idLawsuit='+idLawsuit,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 220
		}
		);
	}


</script>


<!------  Content ----->
<cfdiv id="lawsuitFormDiv" bind="url:lawsuitForm.cfm">
</cfdiv>


<cfform name="lawsuitGridForm">
	<cfgrid 
		name="lawsuitGrid"
		bindOnLoad="true" 
		bind="cfc:components.lawsuit.getLawsuitByFileId({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="idLawsuit" display="no">
			<cfgridcolumn name="plantiff" header="Plantiff" width="385">
			<cfgridcolumn name="status" header="Status" width="200">
			<cfgridcolumn name="thisDate" header="Date" width="100">
			<cfgridcolumn name="Edit" header="Actions" width="100" dataAlign="Center">

	</cfgrid>
</cfform>


<cfinclude template="template/footer.cfm">