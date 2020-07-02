<cfif isDefined("FORM.flowControlSelect")>
	<cfinvoke component="components.file" method="changeFileStatus" argumentCollection="#FORM#">
	<cfoutput>
	<script>
		ColdFusion.navigate('headerFileInf.cfm?idFile=#SESSION.idFile#','headerFileInfDiv');
		
		<!--- Se hace con try porqeu no se sabe si los grid estan en la pagina si no .. el error se captura--->		
		try{
			ColdFusion.Grid.refresh('searchResultGrid', true);
		}
		catch(err){
			error = true;
		}
		
		try{
			ColdFusion.Grid.refresh('historyGrid', true);
		}
		catch(err){
			error = true;
		}
		
		try{
			ColdFusion.Grid.refresh('allLegalMattersGrid', true);
		}
		catch(err){
			error = true;
		}
	</script>
	</cfoutput>
</cfif>

<cfif SESSION.idFileStatus NEQ 0>

	<cfinvoke component="components.file" method="getAllFileStatus" returnVariable="allFileStatusQuery">
	<div id="flowControl">
		<fieldset>
			<cfform name="flowControlForm">
			<cfselect 
				name="flowControlSelect" 
				query="allFileStatusQuery" 
				display="name" 
				value="idFileStatus" 
				selected="#SESSION.idFileStatus#" 
				>
			</cfselect>
			<cfinput name="submit" type="submit" value="Change">
			</cfform>
		</fieldset>
	</div>

<cfelse>
	
	<p class="msg-alert">Please select a Client from the search list</p>

</cfif>