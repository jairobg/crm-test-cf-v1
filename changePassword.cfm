<cfinclude template="template/header.cfm">
<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Client') EQ 0>
	<cflocation url="search.cfm" addToken="no">
</cfif> 

<!------ Functionality ----->

<cfif isDefined("FORM.actualPassword")>
	<cfinvoke component="components.user" method="changePassword" returnVariable="changePasswordResult" argumentCollection="#FORM#"> 
</cfif> 


<cfform name="changePasswordForm" onsubmit="return checkNewPass(this);">

<!--- FORM error message --->
<div class="error"> 
	<span></span>
</div> 
                            

<fieldset class="col1">
	<legend>Actual Password</legend>
	<ul class="">
		<li>
			<label for="actualPassword">Actual Password</label> 
			<cfinput name="actualPassword" type="text" required="yes" placeholder="OLD PASSWORD" value="" message="You must enter your password" autocomplete="off">
		</li>				
	</ul>
</fieldset>


<fieldset class="col2">	
	<legend>New Password</legend>
	<ul class="">	
		<li>
			<label for="newPassword">New Password</label> 
			<cfinput name="newPassword" type="password" required="yes" placeholder="NEW PASSWORD" value="" message="You must enter your new password" autocomplete="off">
		</li>
		
		<li>
			<label for="newPassword2">Repeat new Password</label> 
			<cfinput name="newPassword2" type="password" required="yes" placeholder="NEW PASSWORD" value="" message="You must repeat your new password" autocomplete="off">
		</li>
	</ul>

</fieldset>

<cfif isDefined("FORM.actualPassword")>
	<center>
	<cfoutput><strong>#changePasswordResult#</strong></cfoutput>
	</center>
</cfif>

<fieldset class="action-buttons">
	<cfinput type="submit" name="submit" value="Change">
</fieldset>

</cfform>


<script type="text/javascript" language="JavaScript">
function checkNewPass(theForm) {
    if (theForm.newPassword.value != theForm.newPassword2.value)
    {
        alert('The new password don\'t match!');
        return false;
    } else {
        return true;
    }
}
</script> 

<cfinclude template="template/footer.cfm">