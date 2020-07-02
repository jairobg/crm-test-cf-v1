<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif isDefined("SESSION.permission")>
	<cfif  listFind(arrayToList(SESSION.permission), 'Search') EQ 0>
		<cflocation url="index.cfm" addToken="no">
	</cfif> 
<cfelse>
	<cflocation url="index.cfm" addToken="no">
</cfif>

<cfparam name="preSearch" default="">



<!------ Content  ------>
<cfoutput>
<fieldset>
	<input type="text" name="searchedWord" id="searchedWord" placeholder="enter keyword"  value="#preSearch#">
	<select name="clientStatus" id="clientStatus">
		<option value="">- Select Status -</option>
		<option value="New">New</option>
		<option value="Working">Working</option>
		<option value="Lost">Lost</option>
		<option value="Won">Won</option>
		<option value="WEB lead">WEB lead</option>
	</select>
</fieldset>
</cfoutput>

<!--- Total de resultados en el grid --->
<!---
<script type="text/javascript" src="http://extjs-public.googlecode.com/svn/tags/ext-3.3.1/release/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="http://extjs-public.googlecode.com/svn/tags/ext-3.3.1/release/ext-all.js"></script>

		<script>
			var gridRender = function()
			{
				grid = ColdFusion.Grid.getGridObject('searchResultGrid');
				var bbar = Ext.DomHelper.overwrite(grid.bbar,{tag:'div',id:Ext.id()},true);
				gbbar = new Ext.PagingToolbar({
				renderTo:bbar,
				store: grid.store, 
		        pageSize: 10,
		        displayInfo: true,
		        displayMsg: '<b>Showing {0} - {1} out of {2}</b>',
		        emptyMsg: "<b>No Record</b>"
			    });
			};		
		</script>
--->




<cfform name="searchResultGridForm">
	<cfgrid 
		name="searchResultGrid"
		bindOnLoad="true" 
		bind="cfc:components.search.search({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchedWord},{clientStatus})" 
		format="html"
		selectMode="Row"
		selectOnLoad="false"
		width="790"
		height="290" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="10">
			<cfgridcolumn name="fileColor" header="$" dataalign="center" width="50">
			<cfgridcolumn name="idFile" header="ID" width="75">
			<cfif SESSION.userIdProfile EQ 7 OR SESSION.userIdProfile EQ 1>
			<cfgridcolumn name="clientStatus" header="Status" width="75">
			</cfif>
			<cfgridcolumn name="firstName" header="First Name" width="100">
			<!---
			<cfgridcolumn name="initial" header="Initial" width="40">
			--->
			<cfgridcolumn name="lastName" header="Last Name" width="100">
			<cfgridcolumn name="email" header="Email" width="100">
			<cfgridcolumn name="thisState" header="State" width="50">
			<cfgridcolumn name="totalCreditors" header="Accounts Enrolled" width="40">
			<cfgridcolumn name="statusName" header="Status" width="100">
			<!---
			<cfgridcolumn name="historyLastInsert" header="Last Note" width="100">
			--->
			<cfgridcolumn name="edit" header="Actions" width="100" dataAlign="Center">

	</cfgrid>
</cfform>

<!--- <cfset ajaxOnLoad("gridRender")> --->


<fieldset class="action-buttons">
	<button onclick="addNewFile();">Add new client</button>
</fieldset>

<cfif SESSION.userIdProfile NEQ 7>
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

			<cfgridcolumn name="title" header="Title" width="200">
			<cfgridcolumn name="description" header="Description" width="300">
			<cfgridcolumn name="taskStart" header="Date" width="200">
			
	</cfgrid>
</cfform>

<!---------------------  Legal Matters ---------->
<!---
<cfform name="allLegalMattersGridForm">
	<fieldset>
		<legend>Legal Matters</legend><br>
		<input type="text" name="lmSearchedWord" id="lmSearchedWord" placeholder="enter keyword" value="">
	</fieldset>
	<cfgrid 
		name="allLegalMattersGrid"
		bindOnLoad="true" 
		bind="cfc:components.legalMatters.getAllLegalMatters({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{lmSearchedWord})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="165" 
		colHeaderAlign="Center"
		stripeRows="true"
		pagesize="5">
			<cfgridcolumn name="legalMatterColor" header="Status">
			<cfgridcolumn name="idFile" display="no">
			<cfgridcolumn name="idDebtHolder" display="no">
			<cfgridcolumn name="idLegalMatter" display="no">
			<cfgridcolumn name="relatedAccount" header="Related Account" width="200">
			<cfgridcolumn name="description" header="Description" width="150">
			<cfgridcolumn name="assignedTo" header="Assigned to" width="200">
			<cfgridcolumn name="thisLegalMatterStatus" header="Status" width="100">
			<cfgridcolumn name="edit" header="Actions" width="85" dataAlign="Center">

	</cfgrid>
</cfform>

--->
</cfif>


<cfinclude template="template/footer.cfm">