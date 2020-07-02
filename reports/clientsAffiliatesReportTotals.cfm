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
		file.itkTotalRetainerFee,
		file.itkDownPayment,
		file.itkMontlyPayment,
		file.itkFirstInstallmentDate,
		file.itkRecurrentPaymentDate,
        /* Affiliate */
		affiliateCompany.affiliateCompanyName,
        ((file.itkMontlyPayment - 6 - 59.99) * (affiliateCompany.affiliateCompanyPercent/100)) + affiliateCompany.monthlyMaintenanceAffiliate AS totalAffiliateMonthly,
        ((file.itkDownPayment - 6) * (affiliateCompany.affiliateCompanyPercent/100)) AS totalAffiliateRetainer,
        /* Rick Graff */
        ((file.itkMontlyPayment - 6 - 59.99) * (affiliateCompany.totalBrokersFeeToRick/100)) + affiliateCompany.monthlyMaintenanceRick AS totalGraffMonthly,
        ((file.itkDownPayment - 6) * (affiliateCompany.totalBrokersFeeToRick/100)) AS totalGraffRetainer,
        /* Total Brokers */
        ((file.itkMontlyPayment - 6 - 59.99) * (affiliateCompany.totalBrokersFeeToLawSupport/100)) + affiliateCompany.monthlyMaintenanceLawSupport AS totalBrokersMonthly,
        ((file.itkDownPayment - 6) * (affiliateCompany.totalBrokersFeeToLawSupport/100)) AS totalBrokersRetainer,
        /* Ramsaran */
        ((file.itkMontlyPayment - 6 - 59.99) * (affiliateCompany.ramsaranFee/100)) + 24.99 AS totalRamsaranMonthly,
        ((file.itkDownPayment - 6) * (affiliateCompany.ramsaranFee/100)) AS totalRamsaranRetainer


	FROM file 
		INNER JOIN affiliateCompany
			ON file.affiliateCompanyId = affiliateCompany.affiliateCompanyId

    WHERE
        file.idFileStatus NOT IN (13,15)

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
        <td>Total Retainer Fee</td>
        <td>Down Payment</td>
        <td>Monthly payment</td>
        <td>First Installment Date</td>
        <td>Recurrent Payment Date</td>

        <td>Affiliate Company</td>
        <td>Affiliate Retainer</td>
        <td>Affiliate Monthly</td>

        <td>Riff Graff Retainer</td>
        <td>Riff Graff Monthly</td>

        <td>Total Brokers Retainer</td>
        <td>Total Brokers Monthly </td>

        <td>Ramsaran Retainer</td>
        <td>Ramsaran Monthly</td>


        

    </tr>
</cfoutput>
<cfoutput query="report">
    <tr>

        <td>#idFile#</td>
        <td>#firstName#</td>
        <td>#lastName#</td>
        <td>#email#</td>
        <td>#homePhone#</td>
        <td>#itkTotalRetainerFee#</td>
        <td>#itkDownPayment#</td>
        <td>#itkMontlyPayment#</td>
        <td>#dateFormat(itkFirstInstallmentDate,'dd-mm-yyyy')#</td>
        <td>#dateFormat(itkRecurrentPaymentDate,'dd-mm-yyyy')#</td>
        <!--- Affiliate --->
        <td>#affiliateCompanyName#</td>
        <td>#NumberFormat(totalAffiliateRetainer,'9.99')#</td>
        <td>#NumberFormat(totalAffiliateMonthly,'9.99')#</td>
        <!--- Rick Graff --->
        <td>#NumberFormat(totalGraffRetainer,'9.99')#</td>
        <td>#NumberFormat(totalGraffMonthly,'9.99')#</td>
        <!--- Total Brokers --->
        <td>#NumberFormat(totalBrokersRetainer,'9.99')#</td>
        <td>#NumberFormat(totalBrokersMonthly,'9.99')#</td> 
        <!--- Ramsaran --->
        <td>#NumberFormat(totalRamsaranRetainer,'9.99')#</td>
        <td>#NumberFormat(totalRamsaranMonthly,'9.99')#</td> 

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
 
