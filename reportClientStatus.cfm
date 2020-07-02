<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
    <cflocation url="search.cfm" addToken="no">
</cfif> 


<cfquery name="clientStatusReportQuery" datasource="#APPLICATION.db#">
    SELECT 
        <!--- Client --->
        file.idFile,
        CONCAT(file.firstName,' ',file.lastName) AS clientName,
        file.fileCreationDate,
        file.clientStatus,
        IF(file.paymentProcess = 1, 'TRUE','FALSE') AS paymentProcess,
        file.cancelDate,
        file.closedDealDate,
        <!--- Affiliate --->
        CONCAT(user.firstName,' ',user.lastName,' ',affiliateCompany.affiliateCompanyName) AS affiliateNameAndCompany
    FROM
        file
        INNER JOIN user
            ON file.fileOwner = user.idUser 
        INNER JOIN userAffiliateCompany
            ON file.fileOwner = userAffiliateCompany.idUser 
            INNER JOIN affiliateCompany
                ON userAffiliateCompany.affiliateCompanyId = affiliateCompany.affiliateCompanyId 


    WHERE
        file.fileOwner <> 0
</cfquery>

<!---
<cfdump var="#clientStatusReportQuery#" expand="true">
--->
<cfreport 
    format = "PDF" 
    template = "#APPLICATION.localPath#reports/clientStatusReport.cfr" 
    query = "#clientStatusReportQuery#">        
</cfreport> 