<cfcomponent>

<cffunction name="editProperty" access="public">

	<cfargument name="idProperty" required="true" type="numeric">
		
	<cfquery name="editPropertyQuery" dataSource="#APPLICATION.db#">
	
		UPDATE
			property
		SET
          propertyInForeclosure = #arguments.propertyInForeclosure#,
          saleDate = <cfif arguments.saleDate EQ "">NULL<cfelse>'#dateFormat(arguments.saleDate, "yyyy/mm/dd")#'</cfif>,
          address = '#arguments.address#',
          city = '#arguments.city#',
          zip = '#arguments.zip#',
          idState = #arguments.idState#,
          loanModificationWithLender = #arguments.loanModificationWithLender#,
          dateForLoanMod = <cfif arguments.dateForLoanMod EQ "">NULL<cfelse>'#dateFormat(arguments.dateForLoanMod, "yyyy/mm/dd")#'</cfif>,
          governmentHAMP = #arguments.governmentHAMP#,
          repaymentHAMP = #arguments.repaymentHAMP#,
          monthlyRetainer = <cfif arguments.monthlyRetainer EQ "">0<cfelse>#rereplace(arguments.monthlyRetainer, "[^0-9|.]", "", "all")#</cfif>,
          firstMortgageCompany = '#arguments.firstMortgageCompany#',
          firstLoanNumber = '#arguments.firstLoanNumber#',
          firstBalance = <cfif arguments.firstBalance EQ "">0<cfelse>#rereplace(arguments.firstBalance, "[^0-9|.]", "", "all")#</cfif>,
          firstMontlyPayment = <cfif arguments.firstMontlyPayment EQ "">0<cfelse>#rereplace(arguments.firstMontlyPayment, "[^0-9|.]", "", "all")#</cfif>,
          firstInterestRate = <cfif arguments.firstInterestRate EQ "">0<cfelse>#rereplace(arguments.firstInterestRate, "[^0-9|.]", "", "all")#</cfif>,
          firstTaxes = <cfif arguments.firstTaxes EQ "">0<cfelse>#rereplace(arguments.firstTaxes, "[^0-9|.]", "", "all")#</cfif>,
          firstPaymentsBehind = <cfif arguments.firstPaymentsBehind EQ "">0<cfelse>#rereplace(arguments.firstPaymentsBehind, "[^0-9|.]", "", "all")#</cfif>,
          firstDateLoanOpened = <cfif arguments.firstDateLoanOpened EQ "">NULL<cfelse>'#dateFormat(arguments.firstDateLoanOpened, "yyyy/mm/dd")#'</cfif>,
          firstDateLastPayment = <cfif arguments.firstDateLastPayment EQ "">NULL<cfelse>'#dateFormat(arguments.firstDateLastPayment, "yyyy/mm/dd")#'</cfif>,
          secondMortgageCompany = '#arguments.secondMortgageCompany#',
          secondLoanNumber = '#arguments.secondLoanNumber#',
          secondBalance = <cfif arguments.secondBalance EQ "">0<cfelse>#rereplace(arguments.secondBalance, "[^0-9|.]", "", "all")#</cfif>,
          secondMontlyPayment = <cfif arguments.secondMontlyPayment EQ "">0<cfelse>#rereplace(arguments.secondMontlyPayment, "[^0-9|.]", "", "all")#</cfif>,
          secondInterestRate = <cfif arguments.secondInterestRate EQ "">0<cfelse>#rereplace(arguments.secondInterestRate, "[^0-9|.]", "", "all")#</cfif>,
          secondTaxes = <cfif arguments.secondTaxes EQ "">0<cfelse>#rereplace(arguments.secondTaxes, "[^0-9|.]", "", "all")#</cfif>,
          secondPaymentsBehind = <cfif arguments.secondPaymentsBehind EQ "">0<cfelse>#rereplace(arguments.secondPaymentsBehind, "[^0-9|.]", "", "all")#</cfif>,
          secondDateLoanOpened = <cfif arguments.secondDateLoanOpened EQ "">NULL<cfelse>'#dateFormat(arguments.secondDateLoanOpened, "yyyy/mm/dd")#'</cfif>,
          secondDateLastPayment  = <cfif arguments.secondDateLastPayment EQ "">NULL<cfelse>'#dateFormat(arguments.secondDateLastPayment, "yyyy/mm/dd")#'</cfif> 
		WHERE
			idProperty = #arguments.idProperty#
			
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="addProperty" access="public">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
		
	<cfquery name="addLawsuitQuery" dataSource="#APPLICATION.db#">
	
		INSERT INTO
			property(
            	  idFile,
                  propertyInForeclosure,
                  saleDate,
                  address,
                  city,
                  zip,
                  idState,
                  loanModificationWithLender,
                  dateForLoanMod,
                  governmentHAMP,
                  repaymentHAMP,
                  monthlyRetainer,
                  firstMortgageCompany,
                  firstLoanNumber,
                  firstBalance,
                  firstMontlyPayment,
                  firstInterestRate,
                  firstTaxes,
                  firstPaymentsBehind,
                  firstDateLoanOpened,
                  firstDateLastPayment,
                  secondMortgageCompany,
                  secondLoanNumber,
                  secondBalance,
                  secondMontlyPayment,
                  secondInterestRate,
                  secondTaxes,
                  secondPaymentsBehind,
                  secondDateLoanOpened,
                  secondDateLastPayment      
            )
		VALUES
			(
	  		  #arguments.idFile#,
              #arguments.propertyInForeclosure#,
              <cfif arguments.saleDate EQ "">NULL<cfelse>'#dateFormat(arguments.saleDate, "yyyy/mm/dd")#'</cfif>,
              '#arguments.address#',
              '#arguments.city#',
              '#arguments.zip#',
              #arguments.idState#,
              #arguments.loanModificationWithLender#,
              <cfif arguments.dateForLoanMod EQ "">NULL<cfelse>'#dateFormat(arguments.dateForLoanMod, "yyyy/mm/dd")#'</cfif>,
              #arguments.governmentHAMP#,
              #arguments.repaymentHAMP#,
              <cfif arguments.monthlyRetainer EQ "">0<cfelse>#rereplace(arguments.monthlyRetainer, "[^0-9|.]", "", "all")#</cfif>,
              '#arguments.firstMortgageCompany#',
              '#arguments.firstLoanNumber#',
              <cfif arguments.firstBalance EQ "">0<cfelse>#rereplace(arguments.firstBalance, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.firstMontlyPayment EQ "">0<cfelse>#rereplace(arguments.firstMontlyPayment, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.firstInterestRate EQ "">0<cfelse>#rereplace(arguments.firstInterestRate, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.firstTaxes EQ "">0<cfelse>#rereplace(arguments.firstTaxes, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.firstPaymentsBehind EQ "">0<cfelse>#rereplace(arguments.firstPaymentsBehind, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.firstDateLoanOpened EQ "">NULL<cfelse>'#dateFormat(arguments.firstDateLoanOpened, "yyyy/mm/dd")#'</cfif>,
              <cfif arguments.firstDateLastPayment EQ "">NULL<cfelse>'#dateFormat(arguments.firstDateLastPayment, "yyyy/mm/dd")#'</cfif>,
              '#arguments.secondMortgageCompany#',
              '#arguments.secondLoanNumber#',
              <cfif arguments.secondBalance EQ "">0<cfelse>#rereplace(arguments.secondBalance, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.secondMontlyPayment EQ "">0<cfelse>#rereplace(arguments.secondMontlyPayment, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.secondInterestRate EQ "">0<cfelse>#rereplace(arguments.secondInterestRate, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.secondTaxes EQ "">0<cfelse>#rereplace(arguments.secondTaxes, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.secondPaymentsBehind EQ "">0<cfelse>#rereplace(arguments.secondPaymentsBehind, "[^0-9|.]", "", "all")#</cfif>,
              <cfif arguments.secondDateLoanOpened EQ "">NULL<cfelse>'#dateFormat(arguments.secondDateLoanOpened, "yyyy/mm/dd")#'</cfif>,
          	  <cfif arguments.secondDateLastPayment EQ "">NULL<cfelse>'#dateFormat(arguments.secondDateLastPayment, "yyyy/mm/dd")#'</cfif> 
			)
	
	</cfquery>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getPropertyByFileId" access="remote" returnType="any">

	<cfargument name="page" required="true">
	<cfargument name="pageSize" required="true">
	<cfargument name="gridsortcolumn" required="true">
	<cfargument name="gridsortdirection" required="true">

	<cfargument name="idFile" required="false" type="numeric" default="#SESSION.idFile#">
	
	<cfquery name="getPropertyByFileIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
        	idProperty,
			address,
			CONCAT('<img class="btnEdit" title="Edit" src="/template/images/edit-icon.png" onclick="editProperty(\'',CAST(idProperty AS CHAR),'\');">','&nbsp;&nbsp;<img class="btnDelete" title="Delete" src="/template/images/delete-icon.png" onclick="deleteProperty(\'',CAST(idProperty AS CHAR),'\');">') AS Edit	
		FROM
			property
		WHERE
			idFile = #arguments.idFile#
			
		<cfif gridsortcolumn NEQ "" AND gridsortdirection NEQ "">
      		ORDER BY #gridsortcolumn# #gridsortdirection#
      	</cfif>

	
	</cfquery>

	<cfreturn queryconvertforgrid(getPropertyByFileIdQuery,page,pagesize)/>

</cffunction>

<!------------------------------------------------------------------>

<cffunction name="getPropertyById" access="public" returnType="query">

	<cfargument name="idProperty" required="true" type="numeric">
	
	<cfquery name="getPropertyByIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT 
			*
		FROM
			property LEFT JOIN state ON property.idState = state.idState
		WHERE
			idProperty = #arguments.idProperty#
	
	</cfquery>

	<cfreturn getPropertyByIdQuery/>

</cffunction>


<!------------------------------------------------------------------>

<cffunction name="deleteProperty" access="public" returnType="string">

	<cfargument name="idProperty" required="true" type="numeric">
	
	<cfquery name="deletePropertyQuery" dataSource="#APPLICATION.db#">
	
		DELETE 
		FROM
			property
		WHERE
			idProperty = #arguments.idProperty#
	
	</cfquery>


</cffunction>


<!------------------------------------------------------------------>



<cffunction name="getAllPropertiesByFileId" access="public" returnType="query">

	<cfargument name="idFile" required="false" default="#SESSION.idFile#">
	
	<cfquery name="getAllPropertiesByFileIdQuery" dataSource="#APPLICATION.db#">
	
		SELECT idProperty, CONCAT(CAST(idProperty AS CHAR),' - ', CAST(address AS CHAR)) as property 
          FROM
			property
		 WHERE
			idFile = #arguments.idFile#
	
	</cfquery>
    
	<cfreturn getAllPropertiesByFileIdQuery >

</cffunction>



</cfcomponent>