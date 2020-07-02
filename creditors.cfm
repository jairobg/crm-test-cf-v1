<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Creditor') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>

	function changeState(){
		var y = document.getElementById('idStateValue').value;
		var x = document.getElementById('idState');
		          for (i=1; i< x.options.length; i++)
		          {
		             if(x.options.item(i).value == y)
		             	{
		             	 x.selectedIndex = x.options[i].index;
		          		}
		          }
	}

	
	function deleteDebtHolder(idDebtHolder, name, type){
		ColdFusion.Window.create(
		'deleteDebtHolder'+idDebtHolder,
		'Delete',
		'creditorsDelete.cfm?idDebtHolder='+idDebtHolder+'&type='+type+'&name='+name,
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
</script>



<!--------------------------------------------------------->
<!------- Creditors grid ---------------------------------->
<!--------------------------------------------------------->

<cfform name="creditorsGridForm">
	<fieldset>
		<legend>Creditors</legend>
	</fieldset>
	<cfgrid 
		name="creditorsGrid" 
		format="html" 
		width="790"
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5"
		bindOnLoad="true" 
		bind="cfc:components.debtHolder.getHolderCreditorForGrid({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})"
		selectMode="row" 
		>
			<cfgridcolumn  name="ref" header="Ref" width="50">
			<cfgridcolumn name="name" header="Name" width="150">
			<cfgridcolumn name="accountNumber" header="Account Number" width="150">
			<cfgridcolumn name="formatedBalance" header="Balance" width="150" dataAlign="right" >
			<cfgridcolumn name="notes" header="Notes" width="200">
			<cfgridcolumn name="edit" header="Actions" width="85" dataAlign="Center">
	</cfgrid>
</cfform>

<script>
	function editCreditor(thisHolderId){
		ColdFusion.Window.create(
		'editCreditor'+thisHolderId,
		'Edit Creditor',
		'creditorsCreditorsEditForm.cfm?idDebtHolder='+thisHolderId,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 420
		}
		);
	}
</script>


<!--- Add new holder --->
<fieldset class="action-buttons">
<button onclick="
	ColdFusion.Window.create(
		'addCreditor',
		'Add Creditor',
		'creditorsCreditorsAddForm.cfm',
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 420			
		}
	);
	">
	Add creditor</button>
</fieldset>	

	
<!--------------------------------------------------------->
<!------- Collectors grid ---------------------------------->
<!--------------------------------------------------------->


<cfform name="collectorsGridForm">
	<fieldset>
		<legend>Collectors</legend>
	</fieldset>
	<cfgrid 
		name="collectorsGrid" 
		format="html" 
		width="790"
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5"
		bindOnLoad="true" 
		bind="cfc:components.debtHolder.getHolderCollectorForGrid({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})"
		selectMode="row" 
		>
			<cfgridcolumn  name="ref" header="Ref" width="50">		
			<cfgridcolumn name="name" header="Name" width="150">
			<cfgridcolumn name="accountNumber" header="Account Number" width="150">
			<cfgridcolumn name="formatedBalance" header="Balance" dataAlign="Right" width="150" >
			<cfgridcolumn name="notes" header="Notes" width="200">
			<cfgridcolumn name="edit" header="Actions" width="85" dataAlign="Center">
	</cfgrid>
</cfform>


<script>
	function editCollector(thisHolderId){
		ColdFusion.Window.create(
		'editCollector'+thisHolderId,
		'Edit Collector',
		'creditorsCollectorsEditForm.cfm?idDebtHolder='+thisHolderId,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 420			
		}
		);
	}
</script>

<!--- Add new holder --->
<fieldset class="action-buttons">
<button onclick="
	ColdFusion.Window.create(
	'addCollector',
	'Add Collector',
	'creditorsCollectorsAddForm.cfm',
	{
	 	center:true,
	    modal:true,
		draggable:false,
		resizable:false,
		initshow:true,
		width: 690,
		height: 420
	}
	);
	">
	Add collector</button>
</fieldset>

<cfinclude template="template/footer.cfm">