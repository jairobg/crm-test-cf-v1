<cfoutput>
	<cfif isDefined("FORM.idUser")>
		<cfinvoke component="components.user" method="deleteUser">
			<cfinvokeargument name="idUser" value="#FORM.idUser#">
		</cfinvoke>
		<script>
			ColdFusion.Grid.refresh('userGrid', true);
			ColdFusion.Window.destroy('deleteUser#FORM.idUser#',true);
		</script>
		<cfexit>
	</cfif>
	
	<cfform name="userDeleteForm">
	<fieldset>
		<legend>Delete user</legend>
	
		<cfinput type="hidden" name="idUser" value="#URL.idUser#">
		<ul>
			<li class="alert">Do you really want to delete this User?</li>
		</ul>
	</fieldset>
	
	<fieldset class="action-buttons">
		<cfinput type="submit" name="submit" value="Delete">
	</fieldset>	
	</cfform>
	
	<button class="cancelButton" onclick="ColdFusion.Window.destroy('deleteUser#URL.idUser#',true);">Cancel</button>

</cfoutput>