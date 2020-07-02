<cfif isDefined("FORM.Description")>
	<cfinvoke component="components.legalMatters" method="addLegalMatter" argumentCollection="#FORM#">
	<script>
		ColdFusion.Grid.refresh('legalMattersGrid', true);
	</script>
</cfif>

<cfinvoke component="components.states" method="states" returnVariable="statesQuery">

<cfinvoke component="components.debtHolder" method="getHolderForLegalMatter" returnVariable="allHolderQuery">

<cfinvoke component="components.user" method="getUsers" returnVariable="getUsersQuery">

<cfinvoke component="components.legalMatters" method="getLegalMattersStatus" returnVariable="legalMattersStatusQuery">

<cfform name="legalMatterAddForm">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div> 
       
<fieldset>
	<legend>New legal Matter</legend>
	<ul class="col1">
		<li><label for="idDebtHolder">Related Account</label>
			<cfselect name="idDebtHolder" query="allHolderQuery" display="fullName" value="idDebtHolder" queryPosition="below" required="Yes" message="You must select a Related Account">
				<option value=""> -Select Holder- </option>
			</cfselect>
		</li>
		<li><label for="idUser">Assigned to</label>
			<cfselect name="idUser" query="getUsersQuery" display="fullName" value="idUser" queryPosition="below" required="Yes"  message="You must select a User">
				<option value=""> -Select User- </option>
			</cfselect>
		</li>
		<li><label for="plantiff">Plantiff</label><cfinput name="plantiff" type="text" value=""></li>
		<li><label for="defender">Defender</label><cfinput name="defender" type="text" value=""></li>		
		<li><label for="idUser">Status</label>
			<cfselect name="idLegalMatterStatus" query="legalMattersStatusQuery" display="name" value="idLegalMatterStatus" queryPosition="below" required="Yes" message="You must select an Status">
				<option value=""> -Select Status- </option>
			</cfselect>
		</li>
		<li><label for="ref">Ref</label><cfinput name="ref" type="text" value=""></li>
	</ul>
	<ul class="col2">
		<li  class="inputDate"><label for="openDate">Open Date</label><cfinput name="openDate" type="datefield" value="" mask="mm/dd/yyyy"  validate="date" message="Open date should be 'mm/dd/yyyy'"></li>
		<li  class="inputDate"><label for="closeDate">Close Date</label><cfinput name="closeDate" type="datefield" value="" mask="mm/dd/yyyy"  validate="date" message="Close date should be 'mm/dd/yyyy'"></li>
		<li><label for="description">Description</label><cftextarea name="description" rows="4" cols="25"></cftextarea></li>	
	</ul>
	<legend>Opposing Counsel</legend>
	<ul class="col1">
		<li><label for="lmName">Name</label> <cfinput name="lmName" type="text" value="" ></li>
		<li><label for="lmLawFirm">Law Firm</label> <cfinput name="lmLawFirm" type="text" value="" ></li>
		<li><label for="lmAddress">Address</label> <cfinput name="lmAddress" type="text" value="" ></li>
		<li><label for="lmCity">City</label> <cfinput name="lmCity" type="text" value="" ></li>
		<li><label for="idState">State</label>
		<cfselect name="idState" query="statesQuery" display="name" value="idState" queryPosition="below">
			<option value="">Select State:</option> 
		</cfselect></li>
		<li><label for="lmZip">ZIP:</label> <cfinput name="lmZip" type="text" value=""></li>
	</ul>
	<ul class="col2">
		<li><label for="address">Jurisdiction</label> <cfinput name="lmJurisdiction" type="text" value="" ></li>
		<li><label for="lmEmail">E-mail:</label> <cfinput name="lmEmail" type="text" value="" validate="email" message="You must fill the e-mail field with a valid e-mail format like name@mail.com"></li>
		<li><label for="lmPhone">Phone:</label> <cfinput name="lmPhone" type="text" value="" mask="(999) 999 9999" validate="telephone" message="You must fill the Phone field with a valid phone number"></li>
		<li><label for="lmFax">Fax:</label> <cfinput name="lmFax" type="text" value="" mask="(999) 999 9999" validate="telephone" message="You must fill the Fax field with a valid phone number"></li>		
	</ul>
</fieldset>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Save">
</fieldset>
</cfform>