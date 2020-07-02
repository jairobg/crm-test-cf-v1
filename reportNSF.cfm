<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
    <cflocation url="search.cfm" addToken="no">
</cfif> 


<cfquery name="NSFReportQuery" datasource="#APPLICATION.db#">
    SELECT 
        <!--- Client --->
        file.idFile,
        CONCAT(file.firstName,' ',file.lastName) AS clientName,
        file.fileCreationDate,
        IFNULL(file.itkMontlyPayment,0) AS itkMontlyPayment,
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
        file.itkTotalDeb IS NOT NULL
</cfquery>

<!---
<cfdump var="#NSFReportQuery#" expand="true">
--->
<cfreport 
    format = "PDF" 
    template = "#APPLICATION.localPath#reports/NSFReport.cfr" 
    query = "#NSFReportQuery#">        
</cfreport> 