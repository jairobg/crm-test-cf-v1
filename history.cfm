<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'History') EQ 0 OR SESSION.idFile EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 


<script>
	function infoHistory(idHistory){
		ColdFusion.Window.create(
		'infoHistory'+idHistory,
		'History Information',
		'historyInfo.cfm?idHistory='+idHistory,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 700,
			height:360
		}
		);
	}
</script>


<!------ Contents ----->
<cfdiv id="historyFormDiv" bind="url:historyForm.cfm" style="height:320px">
</cfdiv>

<cfform name="historyGridForm">
	<cfgrid 
		name="historyGrid"
		bindOnLoad="true" 
		bind="cfc:components.history.getHistoryByFileId({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="250" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="idHistory" display="no">
			<cfgridcolumn name="thisDate" header="Date" width="200">
			<cfgridcolumn name="thisUserName" header="By" width="150">
			<cfgridcolumn name="name" header="Note Type" width="200">
			<cfgridcolumn name="title" header="Title" width="180">
			<!---
			<cfgridcolumn name="detail" header="Detail" width="185">
			--->
			<cfgridcolumn name="Actions" header="Actions" width="50" dataAlign="Center">

	</cfgrid>
</cfform>

<cfinclude template="template/footer.cfm">