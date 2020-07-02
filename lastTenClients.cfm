<!----------------------->
<!--- Last 10 clients --->
<!----------------------->

<cfif isDefined("FORM.lastClientsSelect")>
	<cfoutput>
	<script type="text/javascript">
		selectFile(#FORM.lastClientsSelect#);
	</script>
	</cfoutput>
</cfif>


<cfinvoke component="components.fileUserHistory" method="getLast10Files" returnvariable="last10Clients">

<div id="flowControl">
	<fieldset>
	<h4>Last 10 clients selected:</h4><br>
		<cfform name="lastClientsForm">
		<cfselect onChange="showLastClientSubmit();"
			name="lastClientsSelect" 
			query="last10Clients" 
			display="fullName1" 
			value="idFile"
			selected="#SESSION.idFile#"
			>
		</cfselect>
		<cfinput name="submitLastClient" type="submit" value="Select" style="display:none">
		</cfform>
	</fieldset>
</div>