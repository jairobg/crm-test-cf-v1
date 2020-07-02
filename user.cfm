<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Users') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<script>

	
	function deleteUser(idUser){
		ColdFusion.Window.create(
		'deleteUser'+idUser,
		'Delete',
		'userDelete.cfm?idUser='+idUser,
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


	function editUser(idUser){
		ColdFusion.Window.create(
		'editUser'+idUser,
		'Edit',
		'userEdit.cfm?idUser='+idUser,
		{
		 	center:true,
		    modal:true,
			draggable:false,
			resizable:false,
			initshow:true,
			width: 690,
			height: 280
		}
		);
	}


	function showHidePasswordField() {
        if (document.getElementById('isGoogleAccount').checked) {
        	document.getElementById('passwordField').style.display = 'none';
        } else {
        	document.getElementById('passwordField').style.display = 'block';
        }
    }
    
    
    function showHideAffiliateCompany(){
    	var e = document.getElementById("idProfile");
		var thisUserProfile = e.options[e.selectedIndex].value;
		
        if (thisUserProfile != 7) {
        	document.getElementById('affiliateField').style.display = 'none';
        	document.getElementById('affiliateCompanyId').style.display = 'none';
        } else {
        	document.getElementById('affiliateField').style.display = 'block';
        	document.getElementById('affiliateCompanyId').style.display = 'block';
        }	    
    }
    
</script>


<!------  Content ----->
<cfdiv id="userFormDiv" bind="url:userForm.cfm">
</cfdiv>


<cfform name="userGridForm">
	<cfgrid 
		name="userGrid"
		bindOnLoad="true" 
		bind="cfc:components.user.getUsersForGrid({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
		format="html"
		selectMode="Row"
		width="790" 
		height="285" 
		stripeRows="true"
		pagesize="10">

			<cfgridcolumn name="userName" header="e-mail" width="185">
			<cfgridcolumn name="firstName" header="firstName" width="100">
			<cfgridcolumn name="middleName" header="middleName" width="100">
			<cfgridcolumn name="lastName" header="lastName" width="100">
			<cfgridcolumn name="name" header="Profile" width="100">
			<cfgridcolumn name="Edit" header="Actions" width="100" dataAlign="Center">

	</cfgrid>
</cfform>


<cfinclude template="template/footer.cfm">