<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'LegalMatters') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>
	
	<!---- Load page and show needed divs ----->
	function legalMatterControl(idLegalMatter){
		<!--- save actual ilLegalMatter for adds edit --->
		document.getElementById('idLegalMatter').value = idLegalMatter;
		var URLPageToGo = 'legalMatterEditForm.cfm?idLegalMatter='+idLegalMatter;
		ColdFusion.navigate(URLPageToGo, 'legalMatterForm');
	}
	
	
	<!---- idLegalMater for adds grids send as parameter --->
	function getIdLegalMatter(){
    	var thisIdLegalMatter =  ColdFusion.getElementValue('idlegalMatter');
    	return thisIdLegalMatter; 
	}



	<!-------------------------------------->
	<!---------------- TASKS --------------->
	<!-------------------------------------->

	<!---- Edit Task --->
	function editLegalMatterTask(idTask){
		ColdFusion.Window.create(
		'legalMatterTaskEdit'+idTask,
		'Edit Task',
		'legalMattersAddsTasksEdit.cfm?idTask='+idTask,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 780,
			height: 400
		}
		);
	}


	<!---- Delete Task  --->
	function deleteLegalMatterTask(idTask){
		ColdFusion.Window.create(
		'legalMatterTaskDelete'+idTask,
		'Delete Task',
		'legalMattersAddsTasksDelete.cfm?idTask='+idTask,
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



	<!-------------------------------------->
	<!------------ VIOLATIONS -------------->
	<!-------------------------------------->

	<!---- Edit violations --->
	function editLegalMatterViolation(idLegalMatterViolation){
		ColdFusion.Window.create(
		'legalMatterViolationsEdit'+idLegalMatterViolation,
		'Edit Violation',
		'legalMattersAddsViolationsEdit.cfm?idLegalMatterViolation='+idLegalMatterViolation,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 780,
			height: 330
		}
		);
	}


	<!---- Delete violations  --->
	function deleteLegalMatterViolation(idLegalMatterViolation){
		ColdFusion.Window.create(
		'legalMatterViolationsDelete'+idLegalMatterViolation,
		'Delete Violation',
		'legalMattersAddsViolationsDelete.cfm?idLegalMatterViolation='+idLegalMatterViolation,
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



	<!-------------------------------------->
	<!------------ NOTES  ------------------>
	<!-------------------------------------->

	<!---- Show note description --->
	function infoLegalMatterNote(idLegalMatterNote){
		ColdFusion.Window.create(
		'legalMatterNotesInfo'+idLegalMatterNote,
		'Note Information',
		'legalMattersAddsNotesInfo.cfm?idLegalMatterNote='+idLegalMatterNote,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true
		}
		);
	}


	<!---- Delete note  --->
	function deleteLegalMatterNote(idLegalMatterNote){
		ColdFusion.Window.create(
		'legalMatterNoteDelete'+idLegalMatterNote,
		'Delete Note',
		'legalMattersAddsNotesDelete.cfm?idLegalMatterNote='+idLegalMatterNote,
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

	<!-------------------------------------->
	<!------------ COMMUNICATION  ---------->
	<!-------------------------------------->


	<!---- Edit communication  --->
	function editLegalMatterComunication(idComunication){
		ColdFusion.Window.create(
		'legalMatterComunicationsEdit'+idComunication,
		'Edit Comunication',
		'legalMattersAddsComunicationsEdit.cfm?idComunication='+idComunication,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 800,
			height: 300
			
		}
		);
	}

	<!---- Delete communication  --->
	function deleteLegalMatterComunication(idComunication){
		ColdFusion.Window.create(
		'legalMatterComunicationDelete'+idComunication,
		'Delete Comunication',
		'legalMattersAddsComunicationsDelete.cfm?idComunication='+idComunication,
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


<!---------------------  Grid ---------->

<fieldset>
	<input type="text" name="searchedWord" id="searchedWord" placeholder="enter keyword" value="">
</fieldset>

<cfform name="legalMattersGridForm">
	<cfgrid 
		name="legalMattersGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.legalMattersSearch({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchedWord})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5">
			<cfgridcolumn name="legalMatterColor" header="Status">
			<cfgridcolumn name="ref" header="Ref" width="50">
			<cfgridcolumn name="relatedAccount" header="Related Account" width="100">
			<cfgridcolumn name="description" header="Description" width="125">
			<cfgridcolumn name="assignedTo" header="Assigned to" width="200">
			<cfgridcolumn name="thisLegalMatterStatus" header="Status" width="100">
			<cfgridcolumn name="edit" header="Actions" width="85" dataAlign="Center">

	</cfgrid>
</cfform>

<!--- idLegalmater for adds grids --->
<cfform name="idLegalMatterForm">
	<cfinput name="idLegalMatter" type="hidden" value="0">
</cfform>


<cfif SESSION.userIdProfile NEQ 2>
	<fieldset class="action-buttons">
		<button onclick="ColdFusion.navigate('legalMatterAddForm.cfm', 'legalMatterForm');">Add new Legal Matter</button>
	</fieldset>

	<!------------------- Forms ------------------->
	<cfdiv id="legalMatterForm" bind="url:legalMatterAddForm.cfm">
	</cfdiv>
	
	<cfelse>
	
	<cfdiv id="legalMatterForm">
	</cfdiv>

</cfif>


<cfinclude template="template/footer.cfm">