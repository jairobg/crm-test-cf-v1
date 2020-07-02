<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
    <cflocation url="search.cfm" addToken="no">
</cfif> 

<cfquery name="report" datasource="#APPLICATION.db#">
	SELECT
		file.idFile,
		file.firstName,
		file.lastName,
		file.email,
		file.homePhone,
		affiliateCompany.affiliateCompanyName
	FROM file 
		INNER JOIN affiliateCompany
			ON file.affiliateCompanyId = affiliateCompany.affiliateCompanyId
	ORDER BY file.affiliateCompanyId DESC
</cfquery>



<cfsavecontent variable="strExcelData">
<cfoutput>
<table>
    <tr>
        <td>Id</td>
        <td>First Name</td>
        <td>Last Name</td>
        <td>e-mail</td>
        <td>Home Phone</td>
        <td>Affiliate Company</td>
    </tr>
</cfoutput>
<cfoutput query="report">
    <tr>
        <td>#idFile#</td>
        <td>#firstName#</td>
        <td>#lastName#</td>
        <td>#email#</td>
        <td>#homePhone#</td>
        <td>#affiliateCompanyName#</td>
    </tr>
</cfoutput>
<cfoutput>
</table>
</cfoutput>
 
</cfsavecontent>
 
 

<cfheader
    name="Content-Disposition"
    value="attachment; filename=clientsAffiliatesReport.xls"
    />
 
 

    <cfset strFilePath = GetTempFile(
        GetTempDirectory(),
        "excel_"
        ) />
 
    <!--- Write the excel data to the file. --->
    <cffile
        action="WRITE"
        file="#APPLICATION.localPath#reports/reportTemp"
        output="#strExcelData.Trim()#"
        />
 

    <cfcontent
        type="application/msexcel"
        file="#APPLICATION.localPath#reports/reportTemp"
        deletefile="true"
        />
 
 