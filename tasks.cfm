<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Tasks') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 


<cfdiv id="taskFormDiv" bind="url:taskForm.cfm">
</cfdiv>


<script>
	<!---- Edit Task --->
	function editTask(idTask){
		ColdFusion.Window.create(
		'taskEdit'+idTask,
		'Edit Task',
		'tasksEdit.cfm?idTask='+idTask,
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
	function deleteTask(idTask){
		ColdFusion.Window.create(
		'taskDelete'+idTask,
		'Delete Task',
		'tasksDelete.cfm?idTask='+idTask,
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


<cfform name="taskGridForm">
	<fieldset>
		<legend>Taks</legend>
		<span>Show tasks from today</span>
	</fieldset>
	<cfgrid 
		name="taskGrid"
		bindOnLoad="true" 
		bind="cfc:components.search.getUserTasks({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		selectOnLoad="false"
		width="790"
		height="160" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5">

			<cfgridcolumn name="title" header="Title" width="150">
			<cfgridcolumn name="description" header="Description" width="300">
			<cfgridcolumn name="taskStart" header="Date" width="200">
			<cfgridcolumn name="actions" header="Actions" width="140">
			
	</cfgrid>
</cfform>

<cfinclude template="template/footer.cfm">