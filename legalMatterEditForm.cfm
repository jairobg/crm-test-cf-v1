<cfif isDefined("FORM.Description")>
	<cfinvoke component="components.legalMatters" method="editLegalMatter" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('legalMattersGrid', true);
	</script>
</cfif>
<!---

<cfif isDefined("URL.idLegalMatter")>
	<cfset SESSION.idLegalMatter = URL.idLegalMatter>
</cfif>

--->
<cfinvoke component="components.legalMatters" method="getLegalMatterById" returnvariable="legalMatterByIdQuery" >
	<cfinvokeargument name="idLegalMatter" value="#URL.idLegalMatter#" >
</cfinvoke>

<cfinvoke component="components.debtHolder" method="getHolderForLegalMatter" returnVariable="allHolderQuery">

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfinvoke component="components.user" method="getUsers" returnVariable="getUsersQuery">

<cfinvoke component="components.legalMatters" method="getLegalMattersStatus" returnVariable="legalMattersStatusQuery">

<cfform name="legalMatterEditForm">
	<cfinput type="hidden" name="idlegalMatter" value="#URL.idLegalMatter#">
	<fieldset>
	<legend>Edit legal Matter</legend>
		<ul class="col1">
			<li><label for="idDebtHolder">Related Account</label>
				<cfselect name="idDebtHolder" query="allHolderQuery" display="fullName" value="idDebtHolder" queryPosition="below" selected="#legalMatterByIdQuery.idDebtHolder#" required="Yes" message="You must select a Related Account">
					<option value=""> -Select Holder- </option>
				</cfselect>
			</li>
			<li><label for="idUser">Assigned to</label>
				<cfselect name="idUser" query="getUsersQuery" display="fullName" value="idUser" queryPosition="below" selected="#legalMatterByIdQuery.idUser#" required="Yes"  message="You must select a User">
					<option value=""> -Select User- </option>
				</cfselect>
			</li>
			<li><label for="plantiff">Plantiff</label><cfinput name="plantiff" type="text" value="#legalMatterByIdQuery.plantiff#"></li>
			<li><label for="defender">Defender</label><cfinput name="defender" type="text" value="#legalMatterByIdQuery.defender#"></li>
			<li><label for="idUser">Status</label>
				<cfselect name="idLegalMatterStatus" query="legalMattersStatusQuery" display="name" value="idLegalMatterStatus" queryPosition="below" selected="#legalMatterByIdQuery.idLegalMatterStatus#">
					<option value="0"> -Select Status- </option>
				</cfselect>
			</li>
		<li><label for="ref">Ref</label><cfinput name="ref" type="text" value="#legalMatterByIdQuery.ref#"></li>			
		</ul>
		<ul class="col2">
			<li class="inputDate"><label for="openDate">Open Date</label><cfinput name="openDate" type="datefield" value="#dateformat(legalMatterByIdQuery.openDate, 'mm/dd/yyyy')#" mask="mm/dd/yyyy"  validate="date" message="Open date should be 'mm/dd/yyyy'"></li>
			<li class="inputDate"><label for="closeDate">Close Date</label><cfinput name="closeDate" type="datefield" value="#dateformat(legalMatterByIdQuery.closeDate, 'mm/dd/yyyy')#" mask="mm/dd/yyyy"  validate="date" message="Close date should be 'mm/dd/yyyy'"></li>
			<li><label for="description">Description</label><cftextarea name="description" rows="4" cols="25"><cfoutput>#legalMatterByIdQuery.description#</cfoutput></cftextarea></li>
		
		</ul>
		<legend>Opposing Counsel</legend>
		<ul class="col1">
			<li><label for="lmName">Name</label> <cfinput name="lmName" type="text" value="#legalMatterByIdQuery.lmName#" ></li>
			<li><label for="lmLawFirm">Law Firm</label> <cfinput name="lmLawFirm" type="text" value="#legalMatterByIdQuery.lmLawFirm#" ></li>
			<li><label for="lmAddress">Address</label> <cfinput name="lmAddress" type="text" value="#legalMatterByIdQuery.lmAddress#" ></li>
			<li><label for="lmCity">City</label> <cfinput name="lmCity" type="text" value="#legalMatterByIdQuery.lmCity#" ></li>
			<li><label for="idState">State</label>
			<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below" selected="#legalMatterByIdQuery.idState#">
				<option value="">Select State:</option> 
			</cfselect></li>
			<li><label for="lmZip">ZIP:</label> <cfinput name="lmZip" type="text" value="#legalMatterByIdQuery.lmZip#"></li>		
		</ul>
		<ul class="col2">
			<li><label for="address">Jurisdiction</label> <cfinput name="lmJurisdiction" type="text" value="#legalMatterByIdQuery.lmJurisdiction#" ></li>
			<li><label for="lmEmail">E-mail:</label> <cfinput name="lmEmail" type="text" value="#legalMatterByIdQuery.lmEmail#"></li>
			<li><label for="lmPhone">Phone:</label> <cfinput name="lmPhone" type="text" value="#legalMatterByIdQuery.lmPhone#"></li>
			<li><label for="lmFax">Fax:</label> <cfinput name="lmFax" type="text" value="#legalMatterByIdQuery.lmFax#"></li>		
		</ul>				
	</fieldset>

<cfif SESSION.userIdProfile NEQ 2>	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Save Changes">
	</fieldset>
</cfif>
</cfform>


<cflayout name="listsCategories" type="tab" height="500">

	<cflayoutarea name="legalMattersTasks" title="Tasks" source="legalMattersAddsTasks.cfm?idLegalMatter=#URL.idLegalMatter#">
	</cflayoutarea>  

    <cflayoutarea name="legalMattersNotes" title="Notes" source="legalMattersAddsNotes.cfm?idLegalMatter=#URL.idLegalMatter#"> 
    </cflayoutarea>  

    <cflayoutarea name="legalMattersComunications" title="Comunications" source="legalMattersAddsComunications.cfm?idLegalMatter=#URL.idLegalMatter#">  
    </cflayoutarea>

    <cflayoutarea name="legalMattersViolations" title="Violations" source="legalMattersAddsViolations.cfm?idLegalMatter=#URL.idLegalMatter#">  
    </cflayoutarea>

</cflayout>  

