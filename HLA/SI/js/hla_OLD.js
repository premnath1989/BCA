//ver1.9
function setPage(){
	$('.rptVersion').html('iMP (Trad) Version 1.1 (Agency) - Last Updated 15 May 2013 - E&amp;OE-'); //set version info
	
	$('.dateModified').html(gdata.SI[0].DateModified);
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.SICode').html(gdata.SI[0].SINo);
    $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages
    
    
    
	//$('#TotPremPaid').html(formatCurrency(row.TotPremPaid));
	//$('#SurrenderValueHigh').html(formatCurrency(row.SurrenderValueHigh));
	//$('#SurrenderValueLow').html(formatCurrency(row.SurrenderValueLow));
	//$('#TotalYearlyIncome').html(formatCurrency(row.TotalYearlyIncome));
	//$('#SICode').html(row.SINo);
	//siNo = row.SINo;
	
	$('.planName').html(gdata.SI[0].PlanName);
	
	
	//planName = row.PlanName;
	//planCode = row.PlanCode;
	
	//alert(gdata.SI[0].PlanName)
	//alert(gdata.SI[0].SI_Temp_trad_LA.data[0].Name)
	$('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);
	
	
	//cashPaymentD = row.CashPaymentD;
	//mcashPaymentD = row.MCashPaymentD;
    
    
    $('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    //$('.GYIPurchased').html(gdata.SI[0].Trad_Details.data[0].CashPayment_PO);
    

    
    
    
    
    //var sPath = window.location.pathname;
	//var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
	//alert(sPage)

        //db.transaction(function(transaction) {
        //    transaction.executeSql('select count(*) as pCount from SI_Temp_Pages', [], function(transaction, result) {
        //        if (result != null && result.rows != null) {
        //            var row = result.rows.item(0); 
        //            $('.totalPages').html(row.pCount);
        //        }
        //    },errorHandler);
        //},errorHandler,nullHandler);

	//var sPath = window.location.pathname;
	//var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);

   //     db.transaction(function(transaction) {
   //         transaction.executeSql("Select PageNum from SI_Temp_Pages where htmlName = '" + sPage + "'", [], function(transaction, result) {
   //             if (result != null && result.rows != null) {
   //                 var row = result.rows.item(0); 
   //                 $('.currentPage').html(row.PageNum);
   //             }
   //         },errorHandler);
   //     },errorHandler,nullHandler);
        
        //db.transaction(function(transaction) {
        //    transaction.executeSql("Select agentName,agentCode from agent_profile LIMIT 1", [], function(transaction, result) {
        //        if (result != null && result.rows != null) {
        //            var row = result.rows.item(0); 
        //            $('#agentName').html(row.agentName);
        //            $('#agentCode').html(row.agentCode);
        //        }
        //    },errorHandler);
        //},errorHandler,nullHandler);

$.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
	$("#" + row.PageDesc + " .currentPage").html(row.PageNum);
});

}

function writeSummary1_HLCP()
{
	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {		
	//	$('#table-Summary1 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col1 + '</td><td>' + SI_Temp_Trad_Basic.col2 + '</td><td>' + SI_Temp_Trad_Basic.col3 + '</td><td>' + SI_Temp_Trad_Basic.col4 + '</td><td>' + SI_Temp_Trad_Basic.col5 + '</td><td>' + SI_Temp_Trad_Basic.col6 + '</td><td>' + SI_Temp_Trad_Basic.col7 + '</td><td>' + SI_Temp_Trad_Basic.col8 + '</td><td>' + SI_Temp_Trad_Basic.col9 + '</td><td>' + SI_Temp_Trad_Basic.col10 + '</td><td>' + SI_Temp_Trad_Basic.col11 + '</td><td>' + SI_Temp_Trad_Basic.col12 + '</td></tr>');
	//change col22
	$('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
	formatCurrency(row.col2) + '</td><td>' + formatCurrency(row.col22) + '</td><td>' + formatCurrency(row.col23) + '</td><td>' +
	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) +
	'</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' +
	CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) +
	'</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + formatCurrency(row.col11) + '</td></tr>');	
	});
	
	//total premium paid
	$('.TotPremPaid').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].TotPremPaid));
	$('.SurrenderValueHigh').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].SurrenderValueHigh));
    $('.SurrenderValueLow').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].SurrenderValueLow));
    $('.TotalYearlyIncome').html(formatCurrency(gdata.SI[0].SI_Temp_Trad.data[0].TotalYearlylncome));
	
	//entire policy (including all riders)
	$('.TotPremPaid1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid1));
	$('.SurrenderValueHigh1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh1));
    $('.SurrenderValueLow1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow1));
    $('.TotalYearlyIncome1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome1));
    
    //advanced yearly income
	if (parseInt(gdata.SI[0].Trad_Details.data[0].AdvanceYearlyIncome) == 0){ //Cash promise. Only 1 title
		$('.advanceYearlyIncome').html('Illustration of HLA Cash Promise Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi Pelan HLA Cash Promise</i>');
	}
	
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC')//payment description
	{
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
			    
		if (parseInt(gdata.SI[0].Trad_Details.data[0].PartialPayout) == 100)
		{	
			$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)');
			$('.tpdBenefit').html('(7)=(4B)+(10)+(12)');
			$('.accumulationYearlyIncome').hide(); //# description. Cash Promise
		}
		else
		{
			$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)+(12)');
			$('.tpdBenefit').html('(7)=(4B)+(10)+(11)+(13)');
			$('.cashPayment1').html('#');
			 $('.cashPayment2').html('#');
		}
	}
	else if (gdata.SI[0].Trad_Details.data[0].CashDividend == 'POF')
	{
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)&nbsp;<i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
		
		//if (parseInt(gdata.SI[0].Trad_Details.data[0].CashPayment_PO) == 100)
		if (parseInt(gdata.SI[0].Trad_Details.data[0].PartialPayout) == 100)
		{
			$('.totalSurrenderValue').html('(6)=(3)+(10)');
			$('.tpdBenefit').html('(7)=(4B)+(11)');
			$('.accumulationYearlyIncome').hide(); //# description. Cash Promise
		}
		else
		{
			$('.totalSurrenderValue').html('(6)=(3)+(10)+(11)');
			$('.tpdBenefit').html('(7)=(4B)+(10)+(12)');
			$('.cashPayment1').html('#');
			$('.cashPayment2').html('#');
		}
	}

}

function writeSummary2_HLCP()
{
	var colType = 0;
    if (parseInt(gdata.SI[0].Trad_Details.data[0].AdvanceYearlyIncome) == 0){ //Cash promise. Only 1 title
	$('.advanceYearlyIncome').html('Illustration of HLA Cash Promise Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi Pelan HLA Cash Promise</i>');
    }
	
     if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC')//payment description
    {
        $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
  
        $('#table-Summary2 #col1').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(10)</i>');
                	
        if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF")
        {
        	$('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)</i>');
        	$('#table-Summary2 #col4').html('-');
            $('#table-Summary2 #col4A').html('-');
            $('#table-Summary2 #col4B').html('-');
            
            $('#table-Summary2 #col4').hide();
            $('#table-Summary2 #col4A').hide();
            $('#table-Summary2 #col4B').hide();
         	colType = 1;
        }
        else
        {
        	$('#table-Summary2 #col2').html('Accumulated Yearly Income *<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(12)</i>');
            $('#table-Summary2 #col4').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(13)</i>');
        	$('.ShowGYI').show();
        	colType = 2;
        }
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF')//payment description
    {
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');

    	if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF")
    	{
        	$('#table-Summary2 #col1').html('Terminal Dividend Payable<br/>on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
        	$('#table-Summary2 #col2').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(11)</i>');
        	$('#table-Summary2 #col3').html('--');
        	$('#table-Summary2 #col4').html('--');
        	$('#table-Summary2 #col3A').html('-');
        	$('#table-Summary2 #col3B').html('-');
        	$('#table-Summary2 #col4A').html('-');
        	$('#table-Summary2 #col4B').html('-');
                            
        	$('#table-Summary2 #col3').hide();
        	$('#table-Summary2 #col4').hide();
        	$('#table-Summary2 #col3A').hide();
        	$('#table-Summary2 #col3B').hide();
        	$('#table-Summary2 #col4A').hide();
        	$('#table-Summary2 #col4B').hide();
                            
        	colType = 3;
        }
        else
        {
        	$('#table-Summary2 #col1').html('Accumulated Yearly Income *<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on<br/>Death<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)</i>');
            $('#table-Summary2 #col4').html('-');
            $('#table-Summary2 #col4A').html('-');
            $('#table-Summary2 #col4B').html('-');
                            
            $('#table-Summary2 #col4').hide();
            $('#table-Summary2 #col4A').hide();
            $('#table-Summary2 #col4B').hide();
                            
            $('.ShowGYI').show();
            colType = 4;
        }
    }
    
	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {		
		//$('#table-Summary1 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col1 + '</td><td>' + SI_Temp_Trad_Basic.col2 + '</td><td>' + SI_Temp_Trad_Basic.col3 + '</td><td>' + SI_Temp_Trad_Basic.col4 + '</td><td>' + SI_Temp_Trad_Basic.col5 + '</td><td>' + SI_Temp_Trad_Basic.col6 + '</td><td>' + SI_Temp_Trad_Basic.col7 + '</td><td>' + SI_Temp_Trad_Basic.col8 + '</td><td>' + SI_Temp_Trad_Basic.col9 + '</td><td>' + SI_Temp_Trad_Basic.col10 + '</td><td>' + SI_Temp_Trad_Basic.col11 + '</td><td>' + SI_Temp_Trad_Basic.col12 + '</td></tr>');
	
        if (colType == 1){
        	//$('#table-data > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>' );
            //$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td></tr>');
            $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>' );
        }
        else if (colType == 2){
        	//$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td></tr>');
            $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' +  CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
        }
        else if (colType == 3){
        	//$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
            $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>'  +  CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
        }
        else if (colType == 4){
        	//$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
            $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
        }
	});
    
    writeInvestmentScenarios();
}




function writeRiderPage1_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0){
		$('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
    	$('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
    	$('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
    	
    	$('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage1').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage1').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
        $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage2_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0){
		$('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
    	$('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
    	$('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
    	
    	$('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage2').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage2').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
        $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage3_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0){
		$('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
    	$('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
    	$('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
    	
    	$('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage3').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage3').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
        $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage4_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0){
		$('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
    	$('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
    	$('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
    	
    	$('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
        $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage5_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0){
		$('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
    	$('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
    	$('#rider3Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
    	
    	$('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
        $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage6_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0){
		$('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
    	$('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
    	$('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
    	
    	$('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
        $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage7_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0){
		$('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
    	$('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
    	$('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
    	
    	$('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
        $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}

function writeRiderPage8_HLCP()
{
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulate)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
    }
    else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF'){
		$('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)<br/><i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
	}
	
	if(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0){
		$('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
    	$('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
    	$('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
    	
    	$('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
        	row2 = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
        $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}


function writeRiderDescription_EN()
{
	$.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
		//alert(row.htmlName)
		if (row.riders != "" && row.riders != "(null)"){
			//alert(row.riders)
			//aa = "#" + row.PageDesc + "#table-design1 tr." + 
			//$('#Page3 #table-design1 tr.C').css('display','table-row');
		
		
			if(row.riders.charAt(row.riders.length-1) == ";"){
				rider = row.riders.slice(0, -1).split(";");
            }
        	else{
				rider = row.riders.split(";");
            }
            for (i=0;i<rider.length;i++){
            	if (rider[i] == "C+"){
						rider[i] = "C";
				}
				else if (rider[i] == 'tblHeader'){
					tblHeader = "#" + row.PageDesc + " #riderInPage"
					$(tblHeader).css('display','inline');
				}
				
				tblRider = "#" + row.PageDesc + " #table-design1 tr." + rider[i];
				$(tblRider).css('display','table-row');
				
				if (rider[i] == "C"){
					rider[i] = "C+"
					$("#" + row.PageDesc + " #table-design2Wide tr").css('display','table-row');
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "C+"){
							$("#" + row.PageDesc + " .CRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .cVeryEarly").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 50) / 100));
							$("#" + row.PageDesc + " .cEarly").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 150) / 100));
							$("#" + row.PageDesc + " .cAdvance").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 250) / 100));
							$("#" + row.PageDesc + " .cNursingCareAllowance").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 25) / 100));
							$("#" + row.PageDesc + " .cNursingCareAllowance_BM").html('RM ' + formatCurrency((parseFloat(formatCurrency(rowRider.SumAssured).replace(",","")) * 25) / 100));
						
							if (rowRider.PlanOption == "L"){
//                           if (rowRider.PlanOption == "Level"){
							    $("#" + row.PageDesc + ' .cPlanOption').html('Level Cover');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
							    $("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html('');
							    $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html('');
							}
//							else if (rowRider.PlanOption == "Increasing"){ //wideTable value? nursing care allowance?
                           else if (rowRider.PlanOption == "I"){
							    //alert("aaa")
							    $("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover');
							    $("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
							    $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html('');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + 
								"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " +
								"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");				
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html("<u>Jumlah Diinsuranskan Meningkat Terjamin</u><br/>" + 
								"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada<br/> " +
								"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan peningkatan yang terakhir pada Ulang tahun ke-20 Polisi ini dan kekal sama kemudian dari ini.<br/><br/>");
							}
							else if (rowRider.PlanOption == "B"){
//                           else if (rowRider.PlanOption == "Level_NCB"){
							    $("#" + row.PageDesc + ' .cPlanOption').html('Level Cover with NCB');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html('');
							    $('#cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " +
							    "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" +
							    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");				    
							    $('#cNoClaimBenefit_BM').html("<u>Faedah Tanpa Tuntutan</u><br/> " +
							    "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Selagi Hayat Diinsuranskan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutan yang dimohon sebelum tarikh<br/>" +
							    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tersebut, Syarikat akan membayar Pemunya Polisi Faedah Tanpa Tuntutan bersamaan dengan RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
							    
							}
//							else if (rowRider.PlanOption == "Increasing_NCB"){
                           else if (rowRider.PlanOption == "N"){
							    $("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover with NCB');
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + 
								"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " +
								"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");
							    $('#cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " +
							    "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" +
							    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
							    
							    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html("<u>Jumlah Diinsuranskan Meningkat Terjamin</u><br/>" + 
								"-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada<br/> " +
								"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan peningkatan yang terakhir pada Ulang tahun ke-20 Polisi ini dan kekal sama kemudian dari ini.<br/><br/>");
							    
							    $('#cNoClaimBenefit_BM').html("<u>Faedah Tanpa Tuntutan</u><br/> " +
							    "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Selagi Hayat Diinsuranskan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutan yang dimohon sebelum tarikh<br/>" +
							    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tersebut, Syarikat akan membayar Pemunya Polisi Faedah Tanpa Tuntutan bersamaan dengan RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
							    
							    $("#" + row.PageDesc + " .cVeryEarlyTD").html('50% of Rider Sum Assured');
							    $("#" + row.PageDesc + " .cEarlyTD").html('150% of Rider Sum Assured');
							    $("#" + row.PageDesc + " .cAdvanceTD").html('250% of Rider Sum Assured');
							    $("#" + row.PageDesc + " .cNursingCareAllowance").html('25% of Rider Sum Assured');
							    
							    $("#" + row.PageDesc + " .cVeryEarlyTD_BM").html('50% daripada jumlah diinsuranskan rider');
							    $("#" + row.PageDesc + " .cEarlyTD_BM").html('150% daripada jumlah diinsuranskan rider');
							    $("#" + row.PageDesc + " .cAdvanceTD_BM").html('250% daripada jumlah diinsuranskan rider');
							    $("#" + row.PageDesc + " .cNursingCareAllowance_BM").html('25% daripada Jumlah Rider Diinsurankan');
                            }
						
						
						
						}
					});
				}
				else if (rider[i] == "CCTR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CCTR"){
							$("#" + row.PageDesc + " .CCTRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CCTRGYI").html(formatCurrency(rowRider.SumAssured)+"");					
						}
					});
				}
				else if (rider[i] == "CIR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CIR"){
							$("#" + row.PageDesc + " .CIRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .CIRGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "CIWP"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CIWP"){
							$("#" + row.PageDesc + " .CIWPRiderTerm").html(rowRider.RiderTerm);	
							//$("#" + row.PageDesc + " .CIWPGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "CPA"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "CPA"){
							$("#" + row.PageDesc + " .CPARiderTerm").html(rowRider.RiderTerm);
						}
					});
				}
				else if (rider[i] == "EDB"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "EDB"){
							$("#" + row.PageDesc + " .EDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .EDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "ETPD"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "ETPD"){
							$("#" + row.PageDesc + " .ETPDRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "ETPDB"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "ETPDB"){
							$("#" + row.PageDesc + " .ETPDBRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ETPDBGYI").html(formatCurrency(rowRider.SumAssured)+"");
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							
						}
					});
				}
				else if (rider[i] == "HB"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HB"){
							$("#" + row.PageDesc + " .HBRiderTerm").html(rowRider.RiderTerm);
							$("#" + row.PageDesc + " .HBBenefit").html(parseInt(rowRider.Units) * 45);
						}
					});
				}
				else if (rider[i] == "HMM"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HMM"){
							$("#" + row.PageDesc + " .HMMRiderTerm").html(rowRider.RiderTerm);
						}
					});
				}
				else if (rider[i] == "HSP_II"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "HSP_II"){
							$("#" + row.PageDesc + " .HSP_IIRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "ICR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "ICR"){
							$("#" + row.PageDesc + " .ICRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .ICRGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "LCPR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "LCPR"){
							$("#" + row.PageDesc + " .LCPRRiderTerm").html(rowRider.RiderTerm);	
							$("#" + row.PageDesc + " .LCPRGYI").html(formatCurrency(rowRider.SumAssured)+"");					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "MG_II"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "MG_II"){
							$("#" + row.PageDesc + " .MG_IIRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "MG_IV"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "MG_IV"){
							$("#" + row.PageDesc + " .MG_IVRiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "PA"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PA"){
							$("#" + row.PageDesc + " .PARiderTerm").html(rowRider.RiderTerm);	
						}
					});
				}
				else if (rider[i] == "LCWP"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "LCWP"){
							$("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							
							//please check the PTypeCode......
							if(rowRider.PTypeCode == "LA"){
							    $("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Hayat Diinsuranskan ke-2');
							    $("#" + row.PageDesc + " .LCWPInsuredLives").html('2nd Life Assured');
							}
							else if (rowRider.PTypeCode == "PY"){
								$("#" + row.PageDesc + " .LCWPInsuredLives").html('Policy Owner');
								$("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else{
							    $("#" + row.PageDesc + " .LCWPInsuredLives").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "PLCP"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PLCP"){
							$("#" + row.PageDesc + " .PLCPRiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							$("#" + row.PageDesc + " .PLCPGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				else if (rider[i] == "PR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PR"){
							$("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.RiderTerm);					
							
							if(rowRider.PTypeCode == "LA"){
							    $("#" + row.PageDesc + " .PRInsuredLives").html('2nd Life Assured');
							}
							else if (rowRider.PTypeCode == "PY"){
								$("#" + row.PageDesc + " .PRInsuredLives").html('Policy Owner');
								$("#" + row.PageDesc + " .PRInsuredLives_BM").html('Pemunya<br/>Polisi');
							}
							else{
							    $("#" + row.PageDesc + " .PRInsuredLives").html('Payor');
							}
						}
					});
				}
				else if (rider[i] == "SP_PRE"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "SP_PRE"){
							$("#" + row.PageDesc + " .SP_PRERiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "SP_STD"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "SP_STD"){
							$("#" + row.PageDesc + " .SP_STDRiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
						}
					});
				}
				else if (rider[i] == "PTR"){
					$.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {	
						if (rowRider.RiderCode == "PTR"){
							$("#" + row.PageDesc + " .PTRRiderTerm").html(rowRider.RiderTerm);					
							$("#" + row.PageDesc + " .PTRGYI").html(formatCurrency(rowRider.SumAssured)+"");
						}
					});
				}
				
				
				
				//else if (rider[i] == "C"){
				//	rider[i] = "C+"
				//}
				
				
            	//alert(rider[i])
            	//aa = "#" + row.PageDesc + " #table-design1 tr." + rider[i]
            	//alert(aa)
            }
		}
	});



}







function writeSummary2()
{
	var colType = 0;
    if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 0){ //title
		$('.advanceYearlyIncome').html('Illustration of HLA Income Builder&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi HLA Income Builder</i>');
		$('.advanceYearlyDesc').hide();
	}
	else if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 60){
		$('.advanceYearlyIncome').html('Illustration of HLA Income Builder - Advance Yearly Income at age 60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi HLA Income Builder - Pendahuluan Pendapatan Tahunan pada umur 60</i>');
	}
	else if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 75){
		$('.advanceYearlyIncome').html('Illustration of HLA Income Builder - Advance Yearly Income at age 75&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>Ilustrasi HLA Income Builder - Pendahuluan Pendapatan Tahunan pada umur 75</i>');
	}
	
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
    	$('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Accumulation)&nbsp;<i>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
        $('#col1').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(10)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col3').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(12)</i>');
            $('#col4').html('-<br/><br/>-');
                			
            $('#col4A').html('-');
            $('#col4B').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(11)</i>');
            $('#col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(12)</i>');
            $('#col4').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(13)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {
    	$('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD  + '&nbsp;(Cash Dividend Pay Out)&nbsp;<i>' + gdata.SI[0].SI_Temp_Trad.data[0].McashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');                	    
        	if (parseInt(row.CashPayment) == 0)
            {
            	$('#col1').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
                $('#col2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(11)</i>');
                $('#col3').html('-<br/><br/>-');
                $('#col4').html('-<br/><br/>-');
                $('#col3A').html('-');
                $('#col3B').html('-');
                $('#col4A').html('-');
                $('#col4B').html('-');
                colType = 3;
            }
            else
            {
            	$('#col1').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
                $('#col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
                $('#col3').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(12)</i>');
                $('#col4').html('-<br/><br/>-');
                $('#col4A').html('-');
                $('#col4B').html('-');
                colType = 4;
            }
    }
    
    
    
	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, SI_Temp_Trad_Basic) {		
		//$('#table-Summary1 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col1 + '</td><td>' + SI_Temp_Trad_Basic.col2 + '</td><td>' + SI_Temp_Trad_Basic.col3 + '</td><td>' + SI_Temp_Trad_Basic.col4 + '</td><td>' + SI_Temp_Trad_Basic.col5 + '</td><td>' + SI_Temp_Trad_Basic.col6 + '</td><td>' + SI_Temp_Trad_Basic.col7 + '</td><td>' + SI_Temp_Trad_Basic.col8 + '</td><td>' + SI_Temp_Trad_Basic.col9 + '</td><td>' + SI_Temp_Trad_Basic.col10 + '</td><td>' + SI_Temp_Trad_Basic.col11 + '</td><td>' + SI_Temp_Trad_Basic.col12 + '</td></tr>');
	
                    if (colType == 1){
                    	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td></tr>');
                    }
                    else if (colType == 2){
                    	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td></tr>');
                    }
                    else if (colType == 3){
                    	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
                    }
                    else if (colType == 4){
                    	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
                    }
	});
    writeInvestmentScenarios() //page3
}

function writeI20R_1()
{
	$('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-I20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeI20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1I20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I20R2').html('-<br/><br/>-');
                			
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I20R2').html('-<br/><br/>-');
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col3AI20R2').html('-');
            $('#col3BI20R2').html('-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 4;
        }
    }
    $('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeI30R_1()
{
	$('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-I30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeI30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1I30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I30R2').html('-<br/><br/>-');
                			
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I30R2').html('-<br/><br/>-');
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col3AI30R2').html('-');
            $('#col3BI30R2').html('-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 4;
        }
    }
    $('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeI40R_1()
{
	$('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-I40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeI40R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1I40R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I40R2').html('-<br/><br/>-');
                			
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2I40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3I40R2').html('-<br/><br/>-');
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col3AI40R2').html('-');
            $('#col3BI40R2').html('-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1I40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2I40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 4;
        }
    }
    $('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID20R_1()
{
	$('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-ID20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeID20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID20R2').html('-<br/><br/>-');
                			
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID20R2').html('-<br/><br/>-');
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col3AID20R2').html('-');
            $('#col3BID20R2').html('-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 4;
        }
    }
    $('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID30R_1()
{
	$('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-ID30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeID30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID30R2').html('-<br/><br/>-');
                			
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID30R2').html('-<br/><br/>-');
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col3AID30R2').html('-');
            $('#col3BID30R2').html('-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 4;
        }
    }
    $('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID40R_1()
{
	$('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-ID40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeID40R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1ID40R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID40R2').html('-<br/><br/>-');
                			
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2ID40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3ID40R2').html('-<br/><br/>-');
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col3AID40R2').html('-');
            $('#col3BID40R2').html('-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1ID40R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2ID40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 4;
        }
    }
    $('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeIE20R_1()
{
	$('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeIE20R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1IE20R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE20R2').html('-<br/><br/>-');
                			
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2IE20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3IE20R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE20R2').html('-');
            $('#col3BIE20R2').html('-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1IE20R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2IE20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 4;
        }
    }
    $('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeIE30R_1()
{
	$('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
		$('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11+ '</td></tr>');
	});
	writeInvestmentScenariosRight();
}

function writeIE30R_2()
{
	var colType = 0;
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
        $('#col1IE30R2').html('Accumulated Cash Dividend<br/><br/><i>Dividen Tunai Terkumpul<br/>(9)</i>');

        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col2IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)</i>');
            $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE30R2').html('-<br/><br/>-');
                			
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 1;
        }
        else
        {
        	$('#col2IE30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(10)</i>');
            $('#col3IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)</i>');
            $('#col4IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)</i>');
            colType = 2;
        }
    }
    else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P')
    {       	    
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)</i>');
            $('#col2IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)</i>');
            $('#col3IE30R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE30R2').html('-');
            $('#col3BIE30R2').html('-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 3;
        }
        else
        {
        	$('#col1IE30R2').html('Accumulated Yearly Income<br/><br/><i>Pendapatan Tahunan Terkumpul<br/>(9)</i>');
            $('#col2IE30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/><br/><i>Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)</i>');
            $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/><br/><i>Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)</i>');
            $('#col4IE30R2').html('-<br/><br/>-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 4;
        }
    }
    $('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeSummary3()
{
	var colType = 0;
	
	//formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh1)
	$('.TotPremPaid2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid2));
    $('.SurrenderValueHigh2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh2));
    $('.SurrenderValueLow2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow2));
    $('.TotYearlyIncome2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome2));
	
	
	
	if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A')//payment description
    {
    	//$('#paymentDesc').html(cashPaymentD  + '&nbsp;(Cash Dividend Accumulation)&nbsp;<i>' + mcashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)</i>');
                	
        //totalSurrenderValue
        //tpdBenefit
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');
            //$('#totalSurrenderValue').html('(6)=(3)+(10)+(11)');
            //$('#tpdBenefit').html('(7)=(4B)+(10)+(12)');
            $('.accumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
                			
            $('#col1Summary3').html('Total Accumulated Cash<br/>Dividends (End Of Year)<br/><br/><i>Jumlah Dividend Tunai<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Surrender Value (End<br/>of Year)<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 1;
        }
        else
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada), Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');
            //$('#totalSurrenderValue').html('(6)=(3)+(10)+(11)+(12)');
            //$('#tpdBenefit').html('(7)=(4B)+(10)+(12)+(13)');
            //$('#cashPayment1').html('~');
            //$('#cashPayment2').html('~');
            $('#col1Summary3').html('Total Accumulated Yearly<br/>Income (End Of Year)<br/><br/><i>Jumlah Pendapatan Tahunan<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Accumulated Cash<br/>Dividends (End Of Year)<br/><br/><i>Jumlah Dividend Tunai<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Surrender Value (End<br/>of Year)~<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            colType = 2;
        }
    }


    else if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'P')
    {
    	//$('#paymentDesc').html(cashPaymentD  + '&nbsp;(Cash Dividend Pay Out)&nbsp;<i>' + mcashPaymentD + '&nbsp;(Dividen Tunai Dibayar)</i>');
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0)
        {
        	$('#col1Summary3').html('Total Surrender Value (End<br/>of Year)<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('-<br/><br/>-');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col3ASummary3').html('-');
            $('#col3BSummary3').html('-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            $('.ccumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
            colType = 3;
        }
        else
        {
        	$('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            $('.noteM').html('<i>Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.</i><br/>');

                			
            $('#col1Summary3').html('Total Accumulated Yearly<br/>Income (End Of Year)<br/><br/><i>Jumlah Pendapatan Tahunan<br/>Terkumpul (Akhir Tahun)</i>');
            $('#col2Summary3').html('Total Surrender Value (End<br/>of Year)~<br/><br/><i>Jumlah Nilai Penyerahan<br/>(Akhir Tahun)</i>');
            $('#col3Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~<br/><br/><i>Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)</i>');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 4;
        }
    }
    
    
                        //if (colType == 1){
                        //	$('#table-Summary3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.Col11 + '</td><td>' + row.Col12 + '</td><td>' + row.Col13 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
                    	//}
                    	//else if (colType == 2){
                    	//	$('#table-Summary3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.Col11 + '</td><td>' + row.Col12 + '</td><td>' + row.Col13 + '</td><td>' + row.Col14 + '</td><td>' + row.Col15 + '</td></tr>');
                    	//}
                    	//else if (colType == 3){
                    	//	$('#table-Summary3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 + '</td><td>' + row.Col13 + '</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
                    	//}
                    	//else if (colType == 4){
                    	//	$('#table-Summary3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col12 + '</td><td>' + row.Col13 + '</td><td>' + row.Col14 + '</td><td>' + row.Col15 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
                    	//}
    

	$.each(gdata.SI[0].SI_Temp_Trad_Summary.data, function(index, SI_Temp_Trad_Summary) {
	//$('#table-Summary3 > tbody').append("aaa")
	
	
    	if (colType == 1){
        	$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
        else if (colType == 2){
        	$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>' + SI_Temp_Trad_Summary.col14 + '</td><td>' + SI_Temp_Trad_Summary.col15 + '</td></tr>');
        }
        else if (colType == 3){
        	$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
        else if (colType == 4){
        	$('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' + SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>' + SI_Temp_Trad_Summary.col14 + '</td><td>' + SI_Temp_Trad_Summary.col15 + '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
	
	
	});

}

function writeRiderPage1()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0){

	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
    $('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
    $('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
    
    $('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1);
    $('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2);
    
    $('#col0_1_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1);
    $('#col0_2_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
            $('#col' + j + '_EPage1').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
            $('#col' + j + '_MPage1').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
        $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage2()
{
	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length)
if(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0){
	
	$('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
    $('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
    $('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
    
    $('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1);
    $('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2);
    
    $('#col0_1_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1);
    $('#col0_2_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
            $('#col' + j + '_EPage2').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i+1];
            $('#col' + j + '_MPage2').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
        $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage3()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0){
	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
    $('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
    $('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
    
    $('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1);
    $('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2);
    
    $('#col0_1_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1);
    $('#col0_2_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
            $('#col' + j + '_EPage3').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i+1];
            $('#col' + j + '_MPage3').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
        $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage4()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0){
	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
    $('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
    $('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
    
    $('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1);
    $('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2);
    
    $('#col0_1_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1);
    $('#col0_2_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
            $('#col' + j + '_EPage4').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i+1];
            $('#col' + j + '_MPage4').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
        $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage5()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0){

	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
    $('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
    $('#rider3Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
    
    $('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1);
    $('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2);
    
    $('#col0_1_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1);
    $('#col0_2_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
            $('#col' + j + '_EPage5').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i+1];
            $('#col' + j + '_MPage5').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
        $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage6()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0){

	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
    $('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
    $('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
    
    $('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1);
    $('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2);
    
    $('#col0_1_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1);
    $('#col0_2_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
            $('#col' + j + '_EPage6').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i+1];
            $('#col' + j + '_MPage6').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
        $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage7()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0){

	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
    $('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
    $('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
    
    $('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1);
    $('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2);
    
    $('#col0_1_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1);
    $('#col0_2_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
            $('#col' + j + '_EPage7').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i+1];
            $('#col' + j + '_MPage7').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
        $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage8()
{
if(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0){

	//alert(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
    $('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
    $('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
    
    $('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1);
    $('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2);
    
    $('#col0_1_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1);
    $('#col0_2_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
            $('#col' + j + '_EPage8').html(eval('row.col' + j));
            row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i+1];
            $('#col' + j + '_MPage8').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
    	row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
        $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}


function setPageDesc(page){
	$('#rptVersion').html('Win MP (Trad) Version 6.7 (Agency) - Last Updated 03 Oct 2012 - E&amp;OE-');

        db.transaction(function(transaction) {
            transaction.executeSql('select count(*) as pCount from SI_Temp_Pages', [], function(transaction, result) {
                if (result != null && result.rows != null) {
                    var row = result.rows.item(0); 
                    $('.totalPages').html(row.pCount);
                }
            },errorHandler);
        },errorHandler,nullHandler);

	//var sPath = window.location.pathname;
	//var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
	sPage = page

        db.transaction(function(transaction) {
            transaction.executeSql("Select PageNum from SI_Temp_Pages where htmlName = '" + sPage + "'", [], function(transaction, result) {
                if (result != null && result.rows != null) {
                    var row = result.rows.item(0); 
                    $('.currentPage').html(row.PageNum);
                }
            },errorHandler);
        },errorHandler,nullHandler);
        
        db.transaction(function(transaction) {
            transaction.executeSql("Select agentName,agentCode from agent_profile LIMIT 1", [], function(transaction, result) {
                if (result != null && result.rows != null) {
                    var row = result.rows.item(0); 
                    $('#agentName').html(row.agentName);
                    $('#agentCode').html(row.agentCode);
                }
            },errorHandler);
        },errorHandler,nullHandler);
}

function writeInvestmentScenarios(){
	//alert("aaa")
	$('.investmentScenarios').html('<table id="table-notes"><tr><td width="50%" valign="top">&nbsp;</td><td width="50%" valign="top">The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/><i>Illustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :</i><br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.25% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.25% setiap tahun</i><br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.25% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.25% setiap tahun</i><br/><br/><div style="width:600px;height:30px;border:2px solid black;padding: 5px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment.<br/><i>Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</i></div></td></tr></table>');
}

function writeInvestmentScenariosRight(){
	$('.investmentScenariosRight').html('The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/><i>Illustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :</i><br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.50% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.50% setiap tahun</i><br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.50% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<i>Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.50% setiap tahun</i><br/><br/><div style="width:480px;height:30px;border:2px solid black;padding: 5px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment.<br/><i>Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</i></div>');
}

function formatCurrency(num) {
	if (num == "-")
		return "-"
	num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num)) num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10) cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
    	num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
    return (((sign) ? '' : '-') + '' + num + '.' + cents);
        //document.write (((sign) ? '' : '-') + '' + num + '.' + cents);
}

function CurrencyNoCents(num) {
	if (num == "-")
		return "-"
	num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num)) num = "0";
    	sign = (num == (num = Math.abs(num)));
    	num = num.toString();
    	for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
        	num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3));
		return (((sign) ? '' : '-') + '' + num);
}

function gup(name)
{
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( window.location.href );
    if( results == null )
        return "";
    else
        return results[1];
}