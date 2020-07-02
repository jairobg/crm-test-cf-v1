<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
    <cflocation url="search.cfm" addToken="no">
</cfif> 


<cfquery name="clientCancellationReportQuery" datasource="#APPLICATION.db#">
    SELECT 
        <!--- Client --->
        file.closedDealDate,
        file.idFile,
        CONCAT(file.firstName,' ',file.lastName) AS clientName,
        file.clientStatus,
        file.fileCreationDate,
        IF(file.paymentProcess = 1, 'TRUE','FALSE') AS paymentProcess,
        file.cancelDate,        
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
        AND
        file.clientStatus = 'Lost'
</cfquery>

<!---
<cfdump var="#clientCancellationReportQuery#" expand="true">
--->
<cfreport 
    format = "PDF" 
    template = "#APPLICATION.localPath#reports/clientCancellationReport.cfr" 
    query = "#clientCancellationReportQuery#">        
</cfreport> 