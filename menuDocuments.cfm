<!--- Permission verification --->
<cfif SESSION.idFile NEQ 0 AND listFind(arrayToList(SESSION.permission), 'Documents')>
	<li class="spacer"><hr></li>
	<li id="item4"><a href="generateLetters.cfm">Generate Letters</a></li>
	<li id="item5"><a href="generateLabels.cfm" target="_blank">Generate Labels</a></li>
</cfif>
