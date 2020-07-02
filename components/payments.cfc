<cfcomponent>


	<!------------------------------------------------------------------------------>

	<cffunction name="getOutstandingPaymentsClientInfo" access="public">

		<cfargument name="idFile" required="true">
		
		<cfquery name="getOutstandingPaymentsClientInfoQuery" dataSource="#APPLICATION.db#">
			SELECT
				file.idFile,
				file.firstName,
				file.lastName,
				DATE_FORMAT(file.dateBirth,'%Y-%m-%d') AS dateBirth,
				file.socialSecurity,
				file.address,
				file.city,
				state.abbreviation,
				file.zip,
				file.homePhone,
				file.cellPhone,
				file.email,
				ROUND(file.itkDownPayment, 2) AS itkDownPayment,
				file.itkAccountNumber,
				file.itkRoutingNumber,
				DATE_FORMAT(file.itkFirstInstallmentDate,'%Y-%m-%d') AS itkFirstInstallmentDate,
				ROUND(file.itkMontlyPayment, 2) AS itkMontlyPayment,
				file.itkProgramLenght,
				DATE_FORMAT(file.itkRecurrentPaymentDate,'%Y-%m-%d') AS itkRecurrentPaymentDate,
				affiliateCompany.affiliateCompanyName,
				affiliateCompany.payToId,
				affiliateCompany.affiliateCompanyPercent,
				affiliateCompany.affiliateCompanyPercent,
				affiliateCompany.totalBrokersFeeToRick,
				affiliateCompany.totalBrokersFeeToLawSupport,
				affiliateCompany.ramsaranFee,
				ROUND(affiliateCompany.monthlyMaintenanceAffiliate, 2) AS monthlyMaintenanceAffiliate,
				ROUND(affiliateCompany.monthlyMaintenanceRick, 2) AS monthlyMaintenanceRick,
				ROUND(affiliateCompany.monthlyMaintenanceLawSupport, 2) AS monthlyMaintenanceLawSupport,
				ROUND(affiliateCompany.ramsaranMonthly, 2) AS ramsaranMonthly,
				DATE_FORMAT(affiliateCompany.affiliateCompanyCreationDate,'%Y-%m-%d') AS affiliateCompanyCreationDate


			FROM
				file
				INNER JOIN state
				ON file.idState = state.idState
				INNER JOIN affiliateCompany
				ON file.affiliateCompanyId = affiliateCompany.affiliateCompanyId
			WHERE
				file.idFile = #arguments.idFile#

		</cfquery>
		
		
		<cfreturn getOutstandingPaymentsClientInfoQuery />
		
	</cffunction>	


	<!------------------------------------------------------------------------------>

	<cffunction name="getOutstandingPaymentsClients" access="remote" returnType="any">
	
		<cfargument name="page" required="true">
		<cfargument name="pageSize" required="true">
		<cfargument name="gridsortcolumn" required="true">
		<cfargument name="gridsortdirection" required="true">

		<cfargument name="paymentType" required="true" />
		
		<cfquery name="getOutstandingPaymentsClientsQuery" dataSource="#APPLICATION.db#">
			SELECT
				file.idFile,
				file.firstName,
				file.lastName,
				
				itkFirstInstallmentDate AS itkFirstInstallmentDate2,
				CONCAT("$",FORMAT(file.itkDownPayment,2)) AS itkDownPayment,
				CONCAT("$",FORMAT(file.itkMontlyPayment,2)) AS itkMontlyPayment,
				DATE_FORMAT(file.itkFirstInstallmentDate,'%m/%d/%Y') AS itkFirstInstallmentDate,
				DATE_FORMAT(file.itkRecurrentPaymentDate,'%m/%d/%Y') AS itkRecurrentPaymentDate,

				CONCAT('<a target="_blank" href="paymentPrecess.cfm?type=#arguments.paymentType#&idFile=',file.idFile,'"><img class="btnEdit" title="Pay" src="/template/images/info-icon.png"></a>') AS Edit
			FROM
				file
				INNER JOIN state
				ON file.idState = state.idState
				INNER JOIN affiliateCompany
				ON file.affiliateCompanyId = affiliateCompany.affiliateCompanyId
			WHERE
				file.idFileStatus = 6
				AND
				file.paymentProcess = 0
			
				ORDER BY firstName, itkFirstInstallmentDate2
			<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
	      		 , #gridsortcolumn# #gridsortdirection#
	      	</cfif>
				
		</cfquery>
	
		<cfreturn queryconvertforgrid(getOutstandingPaymentsClientsQuery,page,pagesize)/>
		
	</cffunction>




</cfcomponent>