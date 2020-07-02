<!--- Permission verification --->
<cfif  listFind(arrayToList(SESSION.permission), 'Reports') EQ 0>
    <cflocation url="search.cfm" addToken="no">
</cfif> 


<cfquery name="closedDealsReportQuery" datasource="#APPLICATION.db#">
    SELECT 
        file.closedDealDate,
        CONCAT(file.firstName,' ',file.lastName) AS clientName,
        file.itkProgramLenght,
        file.itkDownPayment,
        file.itkMontlyPayment,
        file.itkFirstInstallmentDate,
        file.source,
        file.itkTotalDeb AS totalDebt,
        CONCAT(user.firstName,' ',user.lastName) AS ownerName
    FROM
        file
        INNER JOIN user
            ON file.fileOwner = user.idUser 
    WHERE
        file.fileOwner <> 0
        AND
        file.itkDownPayment IS NOT NULL
        AND
        file.itkMontlyPayment IS NOT NULL
        AND
        file.closedDealDate IS NOT NULL
</cfquery>

<cfreport 
    format = "PDF" 
    template = "#APPLICATION.localPath#reports/closedDealsReport.cfr" 
    query = "#closedDealsReportQuery#">        
</cfreport> 