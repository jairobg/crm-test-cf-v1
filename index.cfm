<cfif isDefined("SESSION.userId")>
	<cflocation url="search.cfm" addToken="no">
</cfif>

<cfinclude template="template/header.cfm">

<cfparam name="loginResult" default="">
<cfif isDefined("FORM.userName")>
	<cfinvoke component="components.login" method="login" argumentCollection="#FORM#" returnVariable="loginResult">
</cfif>

	<section id="main" class="login-section">
		<div class="wrapper">			
			<section id="login-content">
				<cfform name="loginForm">					
					<fieldset>
						<ul>
							<cfif #loginResult# neq "">
								<cfoutput>
									<li><div class="error-login">#loginResult#</div></li>
								</cfoutput>
							</cfif>
							<li><cfinput name="userName" type="text" value=""></li>
							<li><cfinput name="password" type="password" value=""></li>
							<li><cfinput class="btnLogin" name="submit" type="submit" value="Login"></li>
						</ul>
					</fieldset>
				</cfform>
			</section>
			<div class="clearfix"></div>
		</div><!--wrapper-->			
	</section><!--#main-->	
	

<cfinclude template="template/footer.cfm">