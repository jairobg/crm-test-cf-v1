<cfcomponent>

	<!--- TODO: Funcion para ingresar los datos del Intake al File --->
	<cffunction name="updateIntake" access="public" >
    
		<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
        <cfargument name="itkTotalDeb" required="false" type="string" default="0">
		<cfargument name="itkProgramLenght" required="false" type="string" default="">
		<cfargument name="itkTotalRetainerFee" required="false" type="string" default="0">
		<cfargument name="itkMontlyPayment" required="false" type="string" default="0">
		<cfargument name="itkDownPayment" required="false" type="string" default="0">
		<cfargument name="itkFirstInstallmentDate" required="false" type="string" default="">
		<cfargument name="itkBankName" required="false" type="string" default="">
		<cfargument name="itkAccountHolderName" required="false" type="string" default="">
		<cfargument name="itkRoutingNumber" required="false" type="string" default="">
		<cfargument name="itkAccountNumber" required="false" type="string" default="">
		<cfargument name="itkLitigationFee" required="false" type="string" default="">
		<cfargument name="itkMonthlyProcessingFee" required="false" type="string" default="">
		<cfargument name="itkMonthlyRetainer" required="false" type="string" default="">

		
        <cfquery name="updateIntakeQuery" datasource="#APPLICATION.db#">
            UPDATE 	file 
               SET 
               		<cfif arguments.itkTotalDeb NEQ "">
                    itkTotalDeb = #rereplace(arguments.itkTotalDeb, "[^0-9|.]", "", "all")#,
                    </cfif>
               		<cfif arguments.itkProgramLenght NEQ "">
                    itkProgramLenght = '#arguments.itkProgramLenght#',
                    </cfif>
               		<cfif arguments.itkTotalRetainerFee NEQ "">
                    itkTotalRetainerFee = #rereplace(arguments.itkTotalRetainerFee, "[^0-9|.]", "", "all")#,
                    </cfif>
                    itkLitigationFee = 59.99,
                    itkMonthlyProcessingFee = 5.00,
               		<cfif arguments.itkMonthlyRetainer NEQ "">
                    itkMonthlyRetainer = #rereplace(arguments.itkMonthlyRetainer, "[^0-9|.]", "", "all")#,
                    </cfif>
					<cfif arguments.itkMontlyPayment NEQ "">
                    itkMontlyPayment = #rereplace(arguments.itkMontlyPayment, "[^0-9|.]", "", "all")#,
                    </cfif>
                    <cfif arguments.itkDownPayment NEQ "">
                    itkDownPayment = #rereplace(arguments.itkDownPayment, "[^0-9|.]", "", "all")#,
                    </cfif>
                    itkFirstInstallmentDate = <cfif arguments.itkFirstInstallmentDate EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.itkFirstInstallmentDate, "yyyy/mm/dd")#'</cfif>,
                    itkRecurrentPaymentDate = <cfif arguments.itkRecurrentPaymentDate EQ "">'#dateFormat(now(), "yyyy/mm/dd")#'<cfelse>'#dateFormat(arguments.itkRecurrentPaymentDate, "yyyy/mm/dd")#'</cfif>,
                    itkBankName = '#arguments.itkBankName#',
                    itkAccountHolderName = '#arguments.itkAccountHolderName#',
                    itkRoutingNumber = '#arguments.itkRoutingNumber#',
                    itkAccountNumber = '#arguments.itkAccountNumber#',
                    studentLoanPercent = #arguments.studentLoanPercent#
                    

                    
            WHERE   idFile = #arguments.idFile#
            
        </cfquery>
        
        
	</cffunction>
    

	<!----------------------------------------------------------------------------------------------------------------------->
    
    <cffunction  name="getTotalDebt" access="public" returnType="string">
    
    	<cfargument name="idFile" type="numeric" required="false" default="#SESSION.idFile#">
    	
    	<cfquery name="getTotalDebtQuery" dataSource="#APPLICATION.db#">
    		SELECT SUM(balance) AS totalDebt
    		FROM debtHolder
    		WHERE
    			type = 'CREDITOR'
    			AND
    			idFile = #arguments.idFile#
    	</cfquery>
    	
    	<cfif getTotalDebtQuery.totalDebt EQ 0>

	    	<cfquery name="getTotalDebtQueryCollector" dataSource="#APPLICATION.db#">
	    		SELECT SUM(balance) AS totalDebt
	    		FROM debtHolder
	    		WHERE
	    			type = 'COLLECTOR'
	    			AND
	    			idFile = #arguments.idFile#
	    	</cfquery>
			
			<cfset thisTotalDebt = #getTotalDebtQueryCollector.totalDebt#>
    	
    	<cfelse>
    	
	    	<cfset thisTotalDebt = #getTotalDebtQuery.totalDebt#>

    	</cfif>
    
    	
    	<cfreturn thisTotalDebt>
    	
    </cffunction>
    
    
    

	<!----------------------------------------------------------------------------------------------------------------------->
    
    <cffunction  name="getAffiliatePercent" access="public" returnType="string">
    
    	<cfargument name="affiliateCompanyId" required="yes">
    	
    	<cfquery name="getAffiliatePercentQuery" dataSource="#APPLICATION.db#">
    		SELECT affiliateCompanyPercent FROM affiliateCompany
    		WHERE affiliateCompanyId = #arguments.affiliateCompanyId#
    	</cfquery>
    	
    	<cfif getAffiliatePercentQuery.RecordCount NEQ 0>
    		<cfset thisAffiliatePercent = getAffiliatePercentQuery.affiliateCompanyPercent>
    	<cfelse>
    		<cfset thisAffiliatePercent = 40>
    	</cfif>
    	
    	<cfreturn thisAffiliatePercent>
    
    </cffunction>
   

	<!------------------------------------------------------------------------------>
	
	<cffunction name="findBankNameByRoutingNumber" access="remote" returnType="string">
	
		<cfargument name="RoutingNumber" type="any" required="false" default="">
		
		<cfquery name="findBankNameByRoutingNumberQuery" dataSource="#APPLICATION.db#">
			SELECT
				bankName
			FROM
				bankRoutingNumbers
			WHERE
				routingNumber = '#arguments.RoutingNumber#'
		</cfquery>
		
		<cfreturn findBankNameByRoutingNumberQuery.bankName>
		
	</cffunction>    
        
        
        
	<!----------------------------------------------------------------------------------------------------------------------->
    
    <cffunction  name="seachStudentLoanDebt" access="public" returnType="any">
    
    	<cfargument name="idFile" type="numeric" required="true" />
    	
    	<cfquery name="getTotalDebtQuery" dataSource="#APPLICATION.db#" result="getTotalDebtQueryResult">
    		SELECT *
    		FROM debtHolder
    		WHERE
    			typeOfDebt = 'PRIVATE_STUDENT_LOANS'
    			AND
    			idFile = #arguments.idFile#
    	</cfquery>
    	
    	<cfif getTotalDebtQueryResult.recordCount EQ 0>
	    	<cfreturn false />
	    <cfelse>
	    	<cfreturn true />
    	</cfif>
    	
    </cffunction>
    
            
</cfcomponent>