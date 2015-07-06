//ver1.9
function setPage(){
	$('.rptVersion').html('iMP Version 1.2 (Agency) - Last Updated 31 Aug 2014 - E&amp;OE-'); //set version info
	
	$('.dateModified').html(gdata.SI[0].DateModified);
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.SICode').html(gdata.SI[0].SINo);
    $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages
    $('.ComDate').html(gdata.SI[0].ComDate);
    $('.BasicSA').html(formatCurrency(gdata.SI[0].BasicSA));
    $('.CovPeriod').html(gdata.SI[0].CovPeriod);
    $('.PremiumPaymentTerm').html(gdata.SI[0].CovPeriod);
    $('.AnnualTarget').html(formatCurrency(parseFloat(gdata.SI[0].ATPrem)));
    $('.AnnualLoading').html('0.00');
    $('.TotalPremiumPayable').html(formatCurrency(parseFloat(gdata.SI[0].ATPrem)));
    $('.PlanName').html(gdata.SI[0].PlanName);
    $('.TotalBasicPremium').html('<b>Jumlah Premium Akaun Asas' + formatCurrency(parseFloat(gdata.SI[0].ATPrem) + parseFloat(gdata.SI[0].ATU) ) + '</b>');
	if(gdata.SI[0].BumpMode == 'A'){
		$('.Page1PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Tahunan (RM)</b>' );
		$('.Page1LoadingLabel').html('<b>Amaun Tambahan Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'S'){
		$('.Page1PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Setengah Tahunan (RM)</b>' );
		$('.Page1LoadingLabel').html('<b>Amaun Tambahan Setengah Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'Q'){
		$('.Page1PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Suku Tahunan (RM)</b>' );
		$('.Page1LoadingLabel').html('<b>Amaun Tambahan Suku Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'M'){
		$('.Page1PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Bulanan (RM)</b>' );
		$('.Page1LoadingLabel').html('<b>Amaun Tambahan Bulanan (RM)</b>' );
	}
	
	if(parseInt(gdata.SI[0].ATU) !=  '0'){
		$('#Page1Basic > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; "></td>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; ">Premium Berkala Tambahan</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; ">&nbsp;</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; "></td>'  +
			'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; "></td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; ">' + gdata.SI[0].CovPeriod + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; ">' + gdata.SI[0].CovPeriod + '</td>' +
			'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; ">' + formatCurrency(gdata.SI[0].ATU) + '</td>' +
			'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; "></td>' +
			'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; ">' + formatCurrency(gdata.SI[0].ATU) + '</td>' + '</tr>'
		);
			
	}
	
	//$('.planName').html(gdata.SI[0].PlanName);
	
	
	//planName = row.PlanName;
	//planCode = row.PlanCode;
	
	//alert(gdata.SI[0].PlanName)
	//alert(gdata.SI[0].SI_Temp_trad_LA.data[0].Name)
	$('.LAName1').html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
	
    
    
    //$('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
	
	$.each(gdata.SI[0].UL_Temp_Pages.data, function(index, row) {
		$("#" + row.PageDesc + " .currentPage").html(row.PageNum);
	});
	
}

var gIndexRiders = false;

function Page2_UV()
{
	var value1, value2, value3, value4;
	if(gdata.SI[0].HLoad == '(null)' || gdata.SI[0].HLoad == '' ){
		value1 = '0.00';
	}
	else
	{
		value1 = formatCurrency(gdata.SI[0].HLoad);
	}
	
	if(gdata.SI[0].HLoadTerm == '(null)'){
		value2 = '0';
	}
	else
	{
		value2 = gdata.SI[0].HLoadTerm;
	}
	if(gdata.SI[0].HLoadPct == '(null)' || gdata.SI[0].HLoadPct == '' ){
		value3 = '0';
	}
	else
	{
		value3 = gdata.SI[0].HLoadPct;
	}
	if(gdata.SI[0].HLoadPctTerm == '(null)'){
		value4 = '0';
	}
	else
	{
		value4 = gdata.SI[0].HLoadPctTerm;
	}
	
	var tempPlanCode;
	if(gdata.SI[0].PlanCode == 'UV'){
		tempPlanCode = 'HLA EverLife Plus';
	}
	else
	{
		tempPlanCode = 'HLA EverGain Plus';
	}
	
	
	$('#TablePage2 > tbody').append('<tr>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempPlanCode + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">   ' + gdata.SI[0].OccpClass  + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + ((gdata.SI[0].OccpLoading) == 'STD' ? 'STD' : formatCurrency(gdata.SI[0].OccpLoading)) + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value1 + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value2 + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value3 + '</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value4 + '</td></tr>');
	
	
	$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {			
		if(row.RiderHLoading == '(null)' || row.RiderHLoading == '' ){
			value1 = '0';
		}
		else
		{
			value1 = row.RiderHLoading;
		}
		
		if(row.RiderHLoadingPct == '(null)' || row.RiderHLoadingPct == '' ){
			value2 = '0';
		}
		else
		{
			value2 = row.RiderHLoadingPct;
		}
		
		var tempOccpClass;
		var tempOccpLoading;
		
		if(row.RiderCode == 'LCWP' || row.RiderCode == 'PR'){
			if(row.PTypeCode == 'LA')
			{
				tempOccpClass =	'Kelas ' + (gdata.SI[0].UL_Temp_trad_LA.data[1].OccpClass == '5' ? 'D' : gdata.SI[0].UL_Temp_trad_LA.data[1].OccpClass) ;
			
				tempOccpLoading = gdata.SI[0].UL_Temp_trad_LA.data[1].OccpLoadingTL;			
			}
			else{
				
				if(gdata.SI[0].UL_Temp_trad_LA.data.length > 2){
					tempOccpClass =	'Kelas ' + (gdata.SI[0].UL_Temp_trad_LA.data[1].OccpClass == '5' ? 'D' : gdata.SI[0].UL_Temp_trad_LA.data[2].OccpClass) ;
			
					tempOccpLoading = gdata.SI[0].UL_Temp_trad_LA.data[2].OccpLoadingTL;				
				}
				else
				{
					tempOccpClass =	'Kelas ' + (gdata.SI[0].UL_Temp_trad_LA.data[1].OccpClass == '5' ? 'D' : gdata.SI[0].UL_Temp_trad_LA.data[1].OccpClass) ;
			
					tempOccpLoading = gdata.SI[0].UL_Temp_trad_LA.data[1].OccpLoadingTL;				
				}
				
			}
		}
		else{
			if(row.RiderCode == 'CIWP' || row.RiderCode == 'ACIR' || row.RiderCode == 'CIRD' || row.RiderCode == 'DCA' || row.RiderCode == 'DHI' || row.RiderCode == 'HMM' || row.RiderCode == 'MR' || row.RiderCode == 'PA'
			   || row.RiderCode == 'TPDMLA' || row.RiderCode == 'TPDYLA' || row.RiderCode == 'DHI' || row.RiderCode == 'WI' || row.RiderCode == 'MG_IV'){
				tempOccpLoading = '0.00';
			}
			else{
				tempOccpLoading = formatCurrency(gdata.SI[0].OccpLoadingTL);
			}
			
			tempOccpClass =	gdata.SI[0].OccpClass;
			
		}
			
		
	      var tempDesc;
	      var tempReinvestOrPayout;
	      
	      if(row.RiderCode == 'ECAR' || row.RiderCode == 'ECAR6' || row.RiderCode == 'ECAR60' ){
		//tempReinvestOrPayout = row.ReinvestGYI;
		tempDesc = row.RiderDesc;
		
	      }
	      else if(row.RiderCode == 'HMM'){
		tempDesc = row.RiderDesc.substring(0, row.RiderDesc.indexOf("("));
	      }
	      else if(row.RiderCode == 'MG_IV'){
		tempDesc = row.RiderDesc.substring(0, row.RiderDesc.indexOf("("));
	      }
	      else{
		tempDesc = row.RiderDesc;
	      }
	      
	      /*
		if(tempReinvestOrPayout == 'Yes'){
			$('.PayoutOrReinvest').html('(Dilaburkan)');		
		}
		else{
			$('.PayoutOrReinvest').html('(Dibayar)');		
		}
		*/
			
		if(row.RiderCode == 'ACIR'){
			$('#TablePage2 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempDesc + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempOccpClass  + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' +   formatCurrency(tempOccpLoading) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value1 + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingTerm + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value2 + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingPctTerm + '</td></tr>');
			
		}
		else if (row.RiderCode == 'CCR' || row.RiderCode == 'TCCR' || row.RiderCode == 'JCCR' || row.RiderCode == 'MDSR1' || row.RiderCode == 'MDSR2' || row.RiderCode == 'MSR' || row.RiderCode == 'LDYR'){
			
			$('#TablePage2 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">'  +  tempDesc + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempOccpClass  + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' +  (parseInt(tempOccpLoading) == 0 ? 'STD' : formatCurrency(tempOccpLoading)) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value1 + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingTerm + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value2 + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingPctTerm + '</td></tr>');
			
			gIndexRiders = true;
		}
		else{
			$('#TablePage2 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempDesc + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempOccpClass  + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' +  (parseInt(tempOccpLoading) == 0 ? 'STD' : formatCurrency(tempOccpLoading)) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value1 + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingTerm + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + value2 + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + row.RiderHLoadingPctTerm + '</td></tr>');
		}
	});
	
}

function round2Decimal(num){
	return Math.round(num * 100)/100;
}

function Page16()
{
	 
	 if(gdata.SI[0].BumpMode == 'A'){
		$('.Page16PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Tahunan (RM)</b>' );
		$('.Page16LoadingLabel').html('<b>Amaun Tambahan Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'S'){
		$('.Page16PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Setengah Tahunan (RM)</b>' );
		$('.Page16LoadingLabel').html('<b>Amaun Tambahan Setengah Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'Q'){
		$('.Page16PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Suku Tahunan (RM)</b>' );
		$('.Page16LoadingLabel').html('<b>Amaun Tambahan Suku Tahunan (RM)</b>' );
	}
	else if(gdata.SI[0].BumpMode == 'M'){
		$('.Page16PaymentModeLabel').html('<b>Premium Sasaran Perlu Dibayar Bulanan (RM)</b>' );
		$('.Page16LoadingLabel').html('<b>Amaun Tambahan Bulanan (RM)</b>' );
	}
	   
	var totalRiderPremium = 0.00;
	
	var ALW = [];
	var OT = [];
	var ALW2 = [];
	var OT2 = [];
	var PCB = [];
	var BBB = [];
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			if(row.RiderCode == 'MDSR1-ALW' ){
				ALW.push(row);
			}
			else if(row.RiderCode == 'MDSR1-OT' ){
				OT.push(row);
			}
			else if(row.RiderCode == 'MDSR2-ALW' ){
				ALW2.push(row);
			}
			else if(row.RiderCode == 'MDSR2-OT' ){
				OT2.push(row);
			}
			else if(row.RiderCode == 'LDYR-PCB' ){
				PCB.push(row);
			}
			else if(row.RiderCode == 'LDYR-BBB' ){
				BBB.push(row);
			}
		});	
		
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
		
			var tempSA;
			var tempDesc;
			
			if(row.RiderCode == 'ECAR' || row.RiderCode == 'ECAR6' ){
				tempSA =  formatCurrency(row.SumAssured) + '<br/>' + '(Tahunan)';
				tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'ECAR60' ){
			  tempSA =  formatCurrency(row.SumAssured) + '<br/>' + '(Tahunan)';
			  tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'HMM'){
			  tempSA = row.PlanOption + '(Penolakan RM' + row.Deductible + ')';
			  tempDesc = row.RiderDesc.substring(0, row.RiderDesc.indexOf("("));
			}
			else if(row.RiderCode == 'TPDWP' || row.RiderCode == 'LCWP' || row.RiderCode == 'CIWP' || row.RiderCode == 'PR' ){
			  tempSA = formatCurrency(row.SumAssured) + '<br/>' + '(Tahunan)';
			  tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'DHI' ){
			  tempSA = formatCurrency(row.SumAssured) + '<br/>' + '(Harian)';
			  tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'WI' ){
			  tempSA = formatCurrency(row.SumAssured) + '<br/>' + '(Mingguan)';
			  tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'TPDMLA' ){
			  tempSA = formatCurrency(row.SumAssured) + '<br/>' + '(Tahunan)';
			  tempDesc = row.RiderDesc;
			}
			else if(row.RiderCode == 'MG_IV'){
			  tempSA = row.PlanOption;
			  tempDesc = row.RiderDesc.substring(0, row.RiderDesc.indexOf("("));
			}
			else{
			  tempSA = formatCurrency(row.SumAssured);
			  tempDesc = row.RiderDesc;
			}
		      
			var tempRiderLoading = row.RiderLoadingPremium == '(null)' ? 0 : row.RiderLoadingPremium;
		      
			var desc;
			desc = index == '0' ? '<b>Rider-rider</b>' : '&nbsp;';
			
			if(row.RiderCode == 'MDSR1' ){
				
				if(ALW.length > 0 && OT.length > 0 ){
					var tempRiderLoading2 = ALW[0].RiderLoadingPremium == '(null)' ? 0 : ALW[0].RiderLoadingPremium;
					var tempRiderLoading3 = OT[0].RiderLoadingPremium == '(null)' ? 0 : OT[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; "> ' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + ALW[0].RiderDesc + '<br/>' + OT[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + ALW[0].CovPeriod + '<br/>' + OT[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + ALW[0].PaymentTerm + '<br/>' + OT[0].PaymentTerm +  '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(ALW[0].AnnualTarget) - parseFloat(ALW[0].RiderLoadingPremium))) + '<br/>' +
						formatCurrency((parseFloat(OT[0].AnnualTarget) - parseFloat(OT[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '<br/>' +  formatCurrency(tempRiderLoading3)   + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(ALW[0].TotalPremium) + '<br/>' + formatCurrency(OT[0].TotalPremium) +  '</td>' + '</tr>');		 
				}
				else if(ALW.length > 0 && OT.length == 0 )
				{
					var tempRiderLoading2 = ALW[0].RiderLoadingPremium == '(null)' ? 0 : ALW[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + ALW[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + ALW[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + ALW[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(ALW[0].AnnualTarget) - parseFloat(ALW[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(ALW[0].TotalPremium) + '</td>' + '</tr>');		 
				}
				else if(ALW.length == 0 && OT.length > 0 )
				{
					var tempRiderLoading2 = OT[0].RiderLoadingPremium == '(null)' ? 0 : OT[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + OT[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + OT[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + OT[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(OT[0].AnnualTarget) - parseFloat(OT[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(OT[0].TotalPremium) + '</td>' + '</tr>');		
				}
				else
				{
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '</td>' + '</tr>');		
				}
				
				$('.fnPage2_IndexRidersNotes').html('<span class="fnPage2_IndexRiders"></span> Premium Illustrated is initial premium');
				
			}
			else if(row.RiderCode == 'MDSR2' ){
				
				if(ALW2.length > 0 && OT2.length > 0 ){
					var tempRiderLoading2 = ALW2[0].RiderLoadingPremium == '(null)' ? 0 : ALW2[0].RiderLoadingPremium;
					var tempRiderLoading3 = OT2[0].RiderLoadingPremium == '(null)' ? 0 : OT2[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + ALW2[0].RiderDesc + '<br/>' + OT2[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + ALW2[0].CovPeriod + '<br/>' + OT2[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + ALW2[0].PaymentTerm + '<br/>' + OT2[0].PaymentTerm +  '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(ALW2[0].AnnualTarget) - parseFloat(ALW2[0].RiderLoadingPremium))) + '<br/>' +
						formatCurrency((parseFloat(OT2[0].AnnualTarget) - parseFloat(OT2[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '<br/>' +  formatCurrency(tempRiderLoading3)   + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(ALW2[0].TotalPremium) + '<br/>' + formatCurrency(OT2[0].TotalPremium) +  '</td>' + '</tr>');		 
				}
				else if(ALW2.length > 0 && OT2.length == 0 )
				{
					var tempRiderLoading2 = ALW2[0].RiderLoadingPremium == '(null)' ? 0 : ALW2[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + ALW2[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + ALW2[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + ALW2[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(ALW2[0].AnnualTarget) - parseFloat(ALW2[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(ALW2[0].TotalPremium) + '</td>' + '</tr>');		 
				}
				else if(ALW2.length == 0 && OT2.length > 0 )
				{
					var tempRiderLoading2 = OT2[0].RiderLoadingPremium == '(null)' ? 0 : OT2[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + OT2[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + OT2[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + OT2[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(OT2[0].AnnualTarget) - parseFloat(OT2[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(OT2[0].TotalPremium) + '</td>' + '</tr>');		
				}
				else
				{
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '</td>' + '</tr>');		
				}
				
				$('.fnPage2_IndexRidersNotes').html('<span class="fnPage2_IndexRiders"></span> Premium Illustrated is initial premium');
				
			}
			else if(row.RiderCode == 'LDYR' ){
				
				if(PCB.length > 0 && BBB.length > 0 ){
					var tempRiderLoading2 = PCB[0].RiderLoadingPremium == '(null)' ? 0 : PCB[0].RiderLoadingPremium;
					var tempRiderLoading3 = BBB[0].RiderLoadingPremium == '(null)' ? 0 : BBB[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + PCB[0].RiderDesc + '<br/>' + BBB[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + PCB[0].CovPeriod + '<br/>' + BBB[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + PCB[0].PaymentTerm + '<br/>' + BBB[0].PaymentTerm +  '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(PCB[0].AnnualTarget) - parseFloat(PCB[0].RiderLoadingPremium))) + '<br/>' +
						formatCurrency((parseFloat(BBB[0].AnnualTarget) - parseFloat(BBB[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '<br/>' +  formatCurrency(tempRiderLoading3)   + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(PCB[0].TotalPremium) + '<br/>' + formatCurrency(BBB[0].TotalPremium) +  '</td>' + '</tr>');		 
				}
				else if(PCB.length > 0 && BBB.length == 0 )
				{
					var tempRiderLoading2 = PCB[0].RiderLoadingPremium == '(null)' ? 0 : PCB[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + PCB[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + PCB[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + PCB[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(PCB[0].AnnualTarget) - parseFloat(PCB[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(PCB[0].TotalPremium) + '</td>' + '</tr>');		 
				}
				else if(PCB.length == 0 && BBB.length > 0 )
				{
					var tempRiderLoading2 = BBB[0].RiderLoadingPremium == '(null)' ? 0 : BBB[0].RiderLoadingPremium;
					
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '<br/>' + BBB[0].RiderDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '<br/>' + BBB[0].CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '<br/>' + BBB[0].PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '<br/>' +
						formatCurrency((parseFloat(BBB[0].AnnualTarget) - parseFloat(BBB[0].RiderLoadingPremium))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '<br/>' + formatCurrency(tempRiderLoading2) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '<br/>' + formatCurrency(BBB[0].TotalPremium) + '</td>' + '</tr>');		
				}
				else
				{
					$('#table-data16 > tbody').append('<tr>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
					'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '</td>' +
					'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '</td>' +
					'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '</td>' + '</tr>');		
				}
				
				$('.fnPage2_IndexRidersNotes').html('<span class="fnPage2_IndexRiders"></span> Premium Illustrated is initial premium');
				
			}
			else if(row.RiderCode == 'MDSR1-ALW' || row.RiderCode == 'MDSR1-OT' || row.RiderCode == 'MDSR2-ALW' || row.RiderCode == 'MDSR2-OT' || row.RiderCode == 'LDYR-PCB' || row.RiderCode == 'LDYR-BBB'  ){
				
			}
			else if (row.RiderCode == 'MSR' || row.RiderCode == 'CCR' || row.RiderCode == 'TCCR' || row.RiderCode == 'JCCR' ){
				$('#table-data16 > tbody').append('<tr>' +
				'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
				'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;"><sup><span class="fnPage16_IndexRiders"></span></sup>' + tempDesc + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '</td>' + '</tr>');
				
				$('.fnPage2_IndexRidersNotes').html('<span class="fnPage16_IndexRiders"></span> Premium Illustrated is initial premium');
			}
			else{
				$('#table-data16 > tbody').append('<tr>' +
				'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 5%; ">' + desc  + ' </td>' +
				'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black; width: 19%;">' + tempDesc + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 6%;">&nbsp;</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.InsuredLives + '</td>'  +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + tempSA + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.CovPeriod + '</td>' +
				'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + row.PaymentTerm + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency((parseFloat(row.AnnualTarget) - parseFloat(tempRiderLoading))) + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(tempRiderLoading) + '</td>' +
				'<td style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black; width: 10%;">' + formatCurrency(row.TotalPremium) + '</td>' + '</tr>');	
			}
			
			
			  totalRiderPremium = parseFloat(totalRiderPremium) +  parseFloat(row.TotalPremium);
					  
		});
		      
		$('#table-data16 > tfoot').append('<tr><td colspan="10" style="text-align:right;padding: 2px 2px 2px 2px;border: 1px solid black;"><b>Jumlah Premium Rider ' + formatCurrency(totalRiderPremium) + '</b></br></td></tr>' ); 
	}
	      
	      
	if(gdata.SI[0].BumpMode == 'A'){
		$('.TotalOverAllPremium16').html('<b>Jumlah Premium Perlu Dibayar (Tahunan) ' + formatCurrency(parseFloat(gdata.SI[0].ATPrem) + parseFloat(totalRiderPremium)) + '</b>' );
	    }
	    else if(gdata.SI[0].BumpMode == 'S'){
		$('.TotalOverAllPremium16').html('<b>Jumlah Premium Perlu Dibayar (Setengah-Tahun) ' + formatCurrency(parseFloat(gdata.SI[0].ATPrem) + parseFloat(totalRiderPremium)) + '</b>' );
	    }
	    else if(gdata.SI[0].BumpMode == 'Q'){
		$('.TotalOverAllPremium16').html('<b>Jumlah Premium Perlu Dibayar (Suku Tahunan)' + formatCurrency(parseFloat(gdata.SI[0].ATPrem) + parseFloat(totalRiderPremium)) + '</b>' );
	    }
	    else if(gdata.SI[0].BumpMode == 'M'){
		$('.TotalOverAllPremium16').html('<b>Jumlah Premium Perlu Dibayar (Bulanan) ' + formatCurrency(parseFloat(gdata.SI[0].ATPrem) + parseFloat(totalRiderPremium)) + '</b>' );
	    }
	
	    
}


function Page3_UV()
{	/*
	if( gdata.SI[0].UL_Page3.data[0].VU2023 != "0"){
		$('#TablePage3_1 > tbody').append('<tr>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">Tarikh Permulaan sehingga 25/11/2023</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2023  + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2025 + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2028 + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2030 + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2035 + '</td>'+
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VUDana + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VURet + '</td>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VUCash + '</td></tr>');		
	}
	*/

	if(gdata.SI[0].PlanCode == 'UV'){
		$('.Page3ShowOnEverLife').html(' sehingga umur 100');
		$('.Page3ShowOnEverLife1').html('<sup><span class="fnPage3_1"></span></sup> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Caj insurans anda (yang tidak terjamin dan ditolak berikutnya daripada nilai dana) akan meningkat seiring dengan peningkatan usia anda. Nilai dana mungkin tidak mencukupi untuk membayar caj insurans dan yuran polisi pada tahun-tahun' +
		  'berikutnya disebabkan oleh keadaan-keadaan seperti pulangan dana yang tidak memuaskan, cuti premium atau pengeluaran yang menyebabkan polisi anda menjadi lupus sebelum mencapai umur 100 tahun. ');
		
	}
	else{
		$('.Page3ShowOnEverLife').html('');
		$('.Page3ShowOnEverLife1').html('');
	}

	if( gdata.SI[0].UL_Page3.data[0].VU2025 != "0"){
		if(gdata.SI[0].UL_Page3.data[0].VU2023 == "0"){
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">Tarikh Permulaan sehingga 25/11/2025</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + gdata.SI[0].UL_Page3.data[0].VU2023  + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2025) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2028) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2030) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2035) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUVenture) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUDana) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VURet) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUCash) + '</td></tr>');		
		}
		else{
			
			var tempTotal = parseInt(gdata.SI[0].UL_Page3.data[0].VU2025)  + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture);
			
			var tempA = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2025)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempB = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempC = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2030)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempD = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2035)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempE = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempF = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + (parseInt(gdata.SI[0].UL_Page3.data[0].VURet)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VU2023)));
			var tempG = parseInt(gdata.SI[0].UL_Page3.data[0].VUCash);
			var temph = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) * parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture)));
			
			if(parseFloat(tempA) + parseFloat(tempB) + parseFloat(tempC) + parseFloat(tempD) + parseFloat(tempE)+ parseFloat(tempF)+ parseFloat(tempG) + parseFloat(tempH) != '100') {
				tempA = 100 - parseFloat(tempB) - parseFloat(tempC) - parseFloat(tempD) - parseFloat(tempE) - parseFloat(tempF) - parseFloat(tempG) - parseFloat(tempH);
				tempA = round2Decimal(tempA);
			}
			
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">26/11/2023 to 25/11/2025</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' +  formatCurrency(tempA) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempB) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempC) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempD) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempH) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempE) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempF) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempG) + '</td></tr>');
		}
	}
	
	if( gdata.SI[0].UL_Page3.data[0].VU2028 != "0"){
		if(gdata.SI[0].UL_Page3.data[0].VU2023 == "0" && gdata.SI[0].UL_Page3.data[0].VU2025 == "0" ){
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">Tarikh Permulaan sehingga 25/11/2028</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2028) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2030) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2035) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUVenture) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUDana) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VURet) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUCash) + '</td></tr>');		
		}
		else {
			
			var tempTotal = parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture);
			
			var tempA = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) +
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))));
			var tempB = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) +
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2030)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))));
			var tempC = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) +
				   (parseInt(gdata.SI[0].UL_Page3.data[0].VU2035)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))))
			var tempD = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) +
				   (parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))));
			var tempE = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VURet) +
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VURet)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))));
			var tempF = parseInt(gdata.SI[0].UL_Page3.data[0].VUCash);
			var tempG = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture) +
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture)/parseInt(tempTotal) * (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025))));
			
			
			if(parseFloat(tempA) + parseFloat(tempB) + parseFloat(tempC) + parseFloat(tempD) + parseFloat(tempE)+ parseFloat(tempF) + parseFloat(tempG) != '100') {
				tempA = 100 - parseFloat(tempB) - parseFloat(tempC) - parseFloat(tempD) - parseFloat(tempE) - parseFloat(tempF) -  parseFloat(tempG) ;
				tempA = round2Decimal(tempA);
			}
			
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">26/11/2025 to 25/11/2028</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempA) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempB) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempC) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempG) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempD) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempE) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempF) + '</td></tr>');
		}
	}
	
	if( gdata.SI[0].UL_Page3.data[0].VU2030 != "0"){
		if(gdata.SI[0].UL_Page3.data[0].VU2023 == "0" && gdata.SI[0].UL_Page3.data[0].VU2025 == "0" && gdata.SI[0].UL_Page3.data[0].VU2028 == "0" ){
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">Tarikh Permulaan sehingga 25/11/2030</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2030) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2035) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUVenture) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUDana) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VURet) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUCash) + '</td></tr>');		
		}
		else {
			var tempTotal = parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture);
			
			var tempA = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2030)/parseInt(tempTotal) *
				     (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028))));
			var tempB = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2035)/parseInt(tempTotal) *
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028))));
			var tempC = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) *
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028))));
			var tempD = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + (parseInt(gdata.SI[0].UL_Page3.data[0].VURet)/parseInt(tempTotal) *
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028))));
			var tempE = parseInt(gdata.SI[0].UL_Page3.data[0].VUCash);
			var tempF = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture)/parseInt(tempTotal) *
				    (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028))));
			
			
			if(parseFloat(tempA) + parseFloat(tempB) + parseFloat(tempC) + parseFloat(tempD) + parseFloat(tempE) + parseFloat(tempF) != '100') {
				tempA = 100 - parseFloat(tempB) - parseFloat(tempC) - parseFloat(tempD) - parseFloat(tempE) - parseFloat(tempF);
				tempA = round2Decimal(tempA);
			}
			
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">26/11/2028 to 25/11/2030</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempA) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempB) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempF) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempC) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempD) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempE) + '</td></tr>');
		}
	}
	
	if( gdata.SI[0].UL_Page3.data[0].VU2035 != "0"){
		if(gdata.SI[0].UL_Page3.data[0].VU2023 == "0" && gdata.SI[0].UL_Page3.data[0].VU2025 == "0" && gdata.SI[0].UL_Page3.data[0].VU2028 == "0" && gdata.SI[0].UL_Page3.data[0].VU2030 == "0" ){
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">Tarikh Permulaan sehingga 25/11/2035</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VU2035) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUVenture) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUDana) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VURet) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(gdata.SI[0].UL_Page3.data[0].VUCash) + '</td></tr>');		
		}
		else {
			var tempTotal = parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) + parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) +
					parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture);
			
			var tempA = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) + (parseInt(gdata.SI[0].UL_Page3.data[0].VU2035)/parseInt(tempTotal) *
				     (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030))));
			var tempB = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) *
				     (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030))));
			var tempC = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + (parseInt(gdata.SI[0].UL_Page3.data[0].VURet)/parseInt(tempTotal) *
				     (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030))));
			var tempD = parseInt(gdata.SI[0].UL_Page3.data[0].VUCash);
			var tempE = round2Decimal(parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture) + (parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture)/parseInt(tempTotal) *
				     (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030))));
			
			if(parseFloat(tempA) + parseFloat(tempB) + parseFloat(tempC) + parseFloat(tempD) + parseFloat(tempE) != '100') {
				tempA = 100 - parseFloat(tempB) - parseFloat(tempC) - parseFloat(tempD) - parseFloat(tempE);
				tempA = round2Decimal(tempA);
			}
			
			$('#TablePage3_1 > tbody').append('<tr>' +
			'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">26/11/2030 to 25/11/2035</td>' +
			//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempA) + '</td>'+
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempE) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempB) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempC) + '</td>' +
			'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempD) + '</td></tr>');
		}
	}
	
	
	var tempFund;
	if(gdata.SI[0].UL_Page3.data[0].VUCashOpt != '0'){
		
		
		if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) != 0){
			tempFund = '26/11/2035 to Policy Maturity Date';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) != 0){
			tempFund = '26/11/2030 to Policy Maturity Date';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) != 0){
			tempFund = '26/11/2028 to Policy Maturity Date';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) != 0){
			tempFund = '26/11/2025 to Policy Maturity Date';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) != 0){
			tempFund = '26/11/2023 to Policy Maturity Date';
		}
		
		$('#TablePage3_1 > tbody').append('<tr>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempFund + '</td>' +
		//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VUVentureOpt)) + '</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VUDanaOpt)) + '</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VURetOpt)) + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VUCashOpt)) + '</td></tr>');	
	}
	else{
		var tempTotal = parseInt(gdata.SI[0].UL_Page3.data[0].VURet) + parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) + parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture) ;
		
		var tempA = formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture) +
				(parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture)/parseInt(tempTotal) *
				 (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035))));
		var tempB = formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana) +
				(parseInt(gdata.SI[0].UL_Page3.data[0].VUDana)/parseInt(tempTotal) *
				 (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035))));
		var tempC = formatCurrency(parseInt(gdata.SI[0].UL_Page3.data[0].VURet) +
				(parseInt(gdata.SI[0].UL_Page3.data[0].VURet)/parseInt(tempTotal) *
				 (parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2028)+ parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) + parseInt(gdata.SI[0].UL_Page3.data[0].VU2035))));
		var tempD = formatCurrency(gdata.SI[0].UL_Page3.data[0].VUCash);
		
		if(parseFloat(tempA) + parseFloat(tempB) + parseFloat(tempC) + parseFloat(tempD) != '100') {
			tempA = 100 - parseFloat(tempB) - parseFloat(tempC) - parseFloat(tempD);
			tempA = round2Decimal(tempA);
			
		}
		
		if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2035) != 0){
			tempFund = '26/11/2035 sehingga Tarikh Kematangan Polisi';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2030) != 0){
			tempFund = '26/11/2030 sehingga Tarikh Kematangan Polisi';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2028) != 0){
			tempFund = '26/11/2028 sehingga Tarikh Kematangan Polisi';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2025) != 0){
			tempFund = '26/11/2025 sehingga Tarikh Kematangan Polisi';
		}
		else if(parseInt(gdata.SI[0].UL_Page3.data[0].VU2023) != 0){
			tempFund = '26/11/2023 sehingga Tarikh Kematangan Polisi';
		}
		
		$('#TablePage3_1 > tbody').append('<tr>' +
		'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">' + tempFund + ' </td>' +
		//'<td style="text-align:left;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">0.00</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempA)  + '</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempB)  + '</td>'+
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempC)  + '</td>' +
		'<td style="text-align:center;padding: 2px 2px 2px 2px;border: 1px solid black;">' + formatCurrency(tempD)  + '</td></tr>');		
	}
	
	
	
	//$('.yeardiff2023').html(round2Decimal(parseFloat(gdata.SI[0].UL_Page3.data[0].YearDiff2023)) + ' years');
	$('.yeardiff2025').html(round2Decimal(gdata.SI[0].UL_Page3.data[0].YearDiff2025) + ' years');
	$('.yeardiff2028').html(round2Decimal(gdata.SI[0].UL_Page3.data[0].YearDiff2028) + ' years');
	$('.yeardiff2030').html(round2Decimal(gdata.SI[0].UL_Page3.data[0].YearDiff2030) + ' years');
	$('.yeardiff2035').html(round2Decimal(gdata.SI[0].UL_Page3.data[0].YearDiff2035) + ' years');

}

function Page5_UV(){
	var tempAge1;
	var tempAge2;
	var tempAge3;
	var tempTotal1;
	var tempTotal2;
	var tempTotal3;
	var tempTotalMDSRFirst1 = 0.00;
	var tempTotalMDSRFirst2 = 0.00;
	var tempTotalMDSRFirst3 = 0.00;
	var tempTotalMDSRSecond1 = 0.00;
	var tempTotalMDSRSecond2 = 0.00;
	var tempTotalMDSRSecond3 = 0.00;
	
	for(var i = 0; i < gdata.SI[0].UL_Temp_trad_Details.data.length; i++ ){
		if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'CCR'){
			document.getElementById('Page5CCR').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >15){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 4);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 14);
				tempAge3 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 15 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5CCR > thead').append('<tr><td "text-align: center;">Rider Year 1 Sehingga 5<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 Sehingga 15<br/>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td "text-align: center;">Rider Year 16 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5CCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >5){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 4);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5CCR > thead').append('<tr><td>Rider Year 1 Sehingga 5<br/>LA Age(EOY)' + tempAge1  + '</td><td>Rider Year 6 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge2  + '</td><td></td></tr>');
				
				$('#Page5CCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5CCR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge1  + '</td><td></td><td></td></tr>');
				
				$('#Page5CCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotal1 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotal2 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotal3 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('#Page5CCR > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotal1) + '</td><td>' + formatCurrency(tempTotal2) + '</td><td>'+ formatCurrency(tempTotal3) +  '</td></tr>');
			$('.CCRNotes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
			
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'TCCR'){
			document.getElementById('Page5TCCR').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >15){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 4);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 14);
				tempAge3 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 15 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5TCCR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 Sehingga 5<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 Sehingga 15<br/>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year 16 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5TCCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >5){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 4);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5 + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5TCCR > thead').append('<tr><td>Rider Year 1 Sehingga 5<br/>LA Age(EOY)' + tempAge1  + '</td><td>Rider Year 6 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge2  + '</td><td></td></tr>');
				
				$('#Page5TCCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' Sehingga ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5TCCR > thead').append('<tr><td>Rider Year 1 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge1  + '</td><td></td><td></td></tr>');
				
				$('#Page5TCCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotal1 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotal2 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotal3 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('#Page5TCCR > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotal1) + '</td><td>' + formatCurrency(tempTotal2) + '</td><td>'+ formatCurrency(tempTotal3) +  '</td></tr>');
			$('.TCCRNotes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'JCCR'){
			document.getElementById('Page5JCCR').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >15){
				tempPol1 = 1 + ' To ' + (16 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				tempAge1 = (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1) + ' To ' + 16;
				tempPol2 = 17 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)  + ' To ' + (30 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				tempAge2 = 17 + ' To ' + 30;
				tempPol3 = 31 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)  + ' To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ;
				tempAge3 = 31 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));

				
				$('#Page5JCCR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 Sehingga 5<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 Sehingga 15<br/>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year 16 Sehingga ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5JCCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >5){
				tempPol1 = 1 + ' To ' + (16 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				tempAge1 = (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1) + ' To ' + 16;
				tempPol2 = (17 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age))  + ' To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod;
				tempAge2 = 17 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				
				$('#Page5JCCR > thead').append('<tr><td style = "text-align: center;">Rider Year ' + tempPol1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY) ' + tempAge1  + '</td>' +
							       '<td style = "text-align: center;">Rider Year ' + tempPol2  + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY) ' + tempAge2  + '</td>' + 
							       '<td> - <td/><tr/>');
				
				$('#Page5JCCR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5JCCR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td></td><td></td></tr>');
				$('#Page5JCCR > tbody').append('<tr><td >' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotal1 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotal2 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotal3 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('#Page5JCCR > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotal1) + '</td><td>' + formatCurrency(tempTotal2) + '</td><td>'+ formatCurrency(tempTotal3) +  '</td></tr>');
			$('.JCCRNotes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
			
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'LDYR'){
			document.getElementById('Page5LDYR').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >15){
				tempAge1 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 6 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 15);
				tempAge3 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 16 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5LDYR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To 5<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 To 15<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year 16 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5LDYR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >5){
				tempAge1 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1+ ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 6 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5LDYR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To 5<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  + '</td><td></td></tr>');
				
				$('#Page5LDYR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5LDYR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td></td><td></td></tr>');
				
				$('#Page5LDYR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotal1 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotal2 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotal3 = parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('#Page5LDYR > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotal1) + '</td><td>' + formatCurrency(tempTotal2) + '</td><td>'+ formatCurrency(tempTotal3) +  '</td></tr>');
			$('.LDYRNotes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MSR'){
			document.getElementById('Page5MSR').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >15){
				tempAge1 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 6 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 15);
				tempAge3 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 16 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5MSR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To 5<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 To 15<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year 16 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5MSR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td>' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td>' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td>' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) >5){
				tempAge1 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 1 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 5);
				tempAge2 = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + 6 + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5MSR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To 5<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year 6 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  + '</td><td></td></tr>');
				
				$('#Page5MSR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + (parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod));
				
				$('#Page5MSR > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td></td><td></td></tr>');
				
				$('#Page5MSR > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotal1 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotal2 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotal3 =  parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('#Page5MSR > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotal1) + '</td><td>' + formatCurrency(tempTotal2) + '</td><td>'+ formatCurrency(tempTotal3) +  '</td></tr>');
			$('.MSRNotes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR1'){
			document.getElementById('Page5MDSR1').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				$('#Page5MDSR1 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year ' + temp3 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				$('#Page5MDSR1 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;"> - </td></tr>');
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				$('#Page5MDSR1 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;"> - </td>' +
								  '<td style = "text-align: center;"> - </td></tr>');
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('.MDSR1Notes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR1-ALW'){
			document.getElementById('Page5MDSR1').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR1-OT'){
			document.getElementById('Page5MDSR1').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				
				$('#Page5MDSR1 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;" - </td></tr>');
			}
			
			tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR2'){
			document.getElementById('Page5MDSR2').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				$('#Page5MDSR2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;">Rider Year ' + temp3 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge3  + '</td></tr>');
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				$('#Page5MDSR2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge2  +'</td>' +
								  '<td style = "text-align: center;"> - </td></tr>');
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				$('#Page5MDSR2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/><sup><span class="fnPage5_Age"></span></sup>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;"> - </td>' +
								  '<td style = "text-align: center;"> - </td></tr>');
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotalMDSRSecond1 = parseFloat(tempTotalMDSRSecond1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRSecond2 = parseFloat(tempTotalMDSRSecond2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRSecond3 = parseFloat(tempTotalMDSRSecond3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
			
			$('.MSDR2Notes').html('<span class="fnPage5_Age"></span> Life Assured Age at the end of year');
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR2-ALW'){
			document.getElementById('Page5MDSR2').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotalMDSRSecond1 = parseFloat(tempTotalMDSRSecond1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRSecond2 = parseFloat(tempTotalMDSRSecond2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRSecond3 = parseFloat(tempTotalMDSRSecond3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
		}
		else if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'MDSR2-OT'){
			document.getElementById('Page5MDSR2').style.display = "";
			if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				tempAge3 = '81 To 100';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3) + '</td></tr>');
			}
			else if(parseInt(gdata.SI[0].UL_Temp_trad_Details.data[i].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				tempAge2 = '61 To 80';
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2) +'</td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			else
			{
				tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
				
				temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
				
				
				
				$('#Page5MDSR2 > tbody').append('<tr><td>' + gdata.SI[0].UL_Temp_trad_Details.data[i].RiderDesc  + '</td>' +
								'<td style = "text-align: center;">' + formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget)  + '</td>' +
								'<td style = "text-align: center;"> - </td>' +
								'<td style = "text-align: center;"> - </td></tr>');
			}
			
			tempTotalMDSRSecond1 = parseFloat(tempTotalMDSRSecond1) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].AnnualTarget);
			tempTotalMDSRSecond2 = parseFloat(tempTotalMDSRSecond2) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium2);
			tempTotalMDSRSecond3 = parseFloat(tempTotalMDSRSecond3) + parseFloat(gdata.SI[0].UL_Temp_trad_Details.data[i].Premium3);
		}
		else{
		}
		
		
	}
	
	$('#Page5MDSR1 > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotalMDSRFirst1) + '</td><td>' + formatCurrency(tempTotalMDSRFirst2) + '</td><td>'+ formatCurrency(tempTotalMDSRFirst3) +  '</td></tr>');
	$('#Page5MDSR2 > tfoot').append('<tr><td></td><td> ' + formatCurrency(tempTotalMDSRSecond1) + '</td><td>' + formatCurrency(tempTotalMDSRSecond2) + '</td><td>'+ formatCurrency(tempTotalMDSRSecond3) +  '</td></tr>');
	
	
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		var lastValueCol1;
		var ArrayPolYearStart = [];
		//var ArrayPolYearEnd = [];
		var ArrayAge = [];
		var ArrayPrem = [];
		
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {
			if(parseFloat(lastValueCol1) != parseFloat(row.col1)){
				ArrayAge.push(row.col0_2);
				ArrayPrem.push(row.col1);
				ArrayPolYearStart.push(row.col0_1);
			}
			
			lastValueCol1 = row.col1;
			
		});
		
		ArrayAge.push(gdata.SI[0].UL_Temp_Summary.data[gdata.SI[0].UL_Temp_Summary.data.length - 1 ].col0_2);
		ArrayPolYearStart.push(gdata.SI[0].UL_Temp_Summary.data[gdata.SI[0].UL_Temp_Summary.data.length - 1].col0_1);
		
		var next ;
		var text1;
		var text2;
		var text3;
		
		for(var i = 0; i < ArrayPrem.length; i++){
			next = parseInt(i + 1);
			if(i == ArrayPrem.length - 1){
				text1 = ArrayPolYearStart[i] +  ' Sehingga '  + (parseInt(ArrayPolYearStart[next]) );
				text2 = (ArrayAge[i]) +  ' Sehingga ' + (parseInt(ArrayAge[next]));
			}
			else{
				text1 = ArrayPolYearStart[i] +  ' Sehingga '  + (parseInt(ArrayPolYearStart[next]) - 1);
				text2 = (ArrayAge[i]) +  ' Sehingga ' + (parseInt(ArrayAge[next]) - 1);
			}
			
			text3 = formatCurrency(ArrayPrem[i]);
			
			$('#Page5Total > tbody').append('<tr><td>' + text1 + '</td><td>'  + text2 + '</td><td>'  + text3 + '</td></tr>');
		}
		
		
	}
	
}

function Page6_UV()
{
	var CIRDExist = false;
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		for(var i = 0; i < gdata.SI[0].UL_Temp_trad_Details.data.length; i++ ){
			if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'CIRD'){
				CIRDExist = true;
				break;
			}	
		}
		
		if(CIRDExist == true){
			$('.Page6ServiceCharge').html('RM8 bulanan bagi 10 tahun pertama, RM5 bulanan bagi tahun yang tertinggal');
		}
		else{
			$('.Page6ServiceCharge').html('RM5 bulanan');
		}
		
	}
	else
	{
		$('.Page6ServiceCharge').html('RM5 bulanan');
	}
	
		
	
	if(gdata.SI[0].TopupStart == '-'){
		$('.BUA').html('-');
		$('.BUAAmount').html('-');
	}
	else{
		$('.BUA').html(gdata.SI[0].TopupStart + ' to ' + gdata.SI[0].TopupEnd );
		$('.BUAAmount').html(round2Decimal(parseFloat(gdata.SI[0].TopupAmount)));
	}
	
	if(gdata.SI[0].RRTUOFrom == '-'){
		$('.RUA').html('-');
		$('.RUAAmount').html('-');
	}
	else{
		$('.RUA').html(gdata.SI[0].RRTUOFrom + ' to ' + gdata.SI[0].RRTUOTo );
		$('.RUAAmount').html(round2Decimal(parseFloat(gdata.SI[0].RRTUOAmount)));
	}
	
	if(gdata.SI[0].MCFRFrom == '-'){
		$('.MCFRUA').html('-');
		$('.MCFRAmount').html('-');
	}
	else{
		$('.MCFRUA').html(gdata.SI[0].MCFRFrom + ' to ' + gdata.SI[0].MCFRTo );
		$('.MCFRAmount').html(round2Decimal(parseFloat(gdata.SI[0].MCFRAmount)));
	}
	
	if(gdata.SI[0].WithdrawAgeFrom == '-'){
		$('.WithdrawStart').html('-');
		$('.WithdrawAmount').html('-');
		$('.WithdrawInterval').html('-');
	}
	else{
		$('.WithdrawStart').html(gdata.SI[0].WithdrawAgeFrom + ' to ' + gdata.SI[0].WithdrawAgeTo);
		$('.WithdrawAmount').html(formatCurrency(gdata.SI[0].WithdrawAmount));
		$('.WithdrawInterval').html(gdata.SI[0].WithdrawInterval);
	}
	
}

function Page13_UV(){
	$('.AnnuityPremPct').html(formatCurrency(gdata.SI[0].Annuity));
	var temp = parseFloat(100.00) - parseFloat(gdata.SI[0].Annuity);
	$('.NonAnnuityPremPct').html(formatCurrency(temp));
	var temp1 = parseFloat(gdata.SI[0].AnnuityPrem) * parseFloat(gdata.SI[0].Annuity)/100.00 ;
	var temp2 = parseFloat(gdata.SI[0].AnnuityPrem) * parseFloat(temp)/100.00;
	
	$('.AnnuityAmount').html(formatCurrency(AnnualisedValue2(temp1)));
	$('.NonAnnuityAmount').html(formatCurrency(AnnualisedValue2(temp2)));
	
}

function Page14_UV(){
	
	if(gdata.SI[0].UL_Temp_Fund.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Fund.data, function(index, row) {
			$('#Page14-table > tbody').append('<tr><td>' + row.Fund +  '</td>' +
			'<td>' +
			  '<table>' +
			    '<tr>' +
				(row.Option == 'ReInvest' ?  '<td class="noBorder" style="text-align: left">Melabur Semula Sepenuhnya</td><td class="noBorder">&nbsp;</td>' : '') +
				(row.Option == 'Partial' ?  '<td class="noBorder" style="text-align: left">Melabur Semula/Pengeluaran Separa</td><td class="noBorder">&nbsp;</td>' : '') +
				(row.Option == 'Withdraw' ?  '<td class="noBorder" style="text-align: left">Pengeluaran Sepenuhnya</td><td class="noBorder">&nbsp;</td>' : '') +
			    '</tr>' +
			    (row.Option == 'Partial' ?  '<tr><td class="noBorder" style="text-align: left">Melabur Semula(% dana matang) :</td><td class="dot" style="vertical-align: bottom">' + row.Partial + '</td></tr>' : '') +
			  '</table>' +
			  (row.Option == 'Withdraw' ?  '<table style="visibility: hidden">' : '<table>') +
			    '<tr>' +
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2023' ? '<td class="dot">HLA EverGreen<br/>2025</td><td class="dot">HLA EverGreen<br/>2028</td><td class="dot">HLA EverGreen<br/>2030</td><td class="dot">HLA EverGreen<br/>2035</td>' : '') +
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2025' ? '<td class="dot">HLA EverGreen<br/>2028</td><td class="dot">HLA EverGreen<br/>2030</td><td class="dot">HLA EverGreen<br/>2035</td>' : '') +
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2028' ? '<td class="dot">HLA EverGreen<br/>2030</td><td class="dot">HLA EverGreen<br/>2035</td>' : '') +
			      (row.Fund.substring(0,18) == 'HLA EverGreen 2030' ?  '<td class="dot">HLA EverGreen<br/>2035</td>' : '') +
			      '<td class="dot">HLA<br/>Venture<br/>Flexi Fund</td>'+
			      '<td class="dot">HLA<br/>Dana Suria</td>'+
			      '<td class="dot">HLA<br/>Secure Fund</td>'+
			      '<td class="dot">HLA<br/>Cash Fund</td>'+
			    '</tr>'+
			    '<tr>'+
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2023' ? '<td class="dot">'+ parseInt(row.Fund2025) +'</td><td class="dot">'+ parseInt(row.Fund2028) +'</td><td class="dot">'+ parseInt(row.Fund2030) +'</td><td class="dot">'+ parseInt(row.Fund2035) +'</td>' : '') +
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2025' ? '<td class="dot">'+ parseInt(row.Fund2028) +'</td><td class="dot">'+ parseInt(row.Fund2030) +'</td><td class="dot">'+ parseInt(row.Fund2035) +'</td>' : '') +
			       (row.Fund.substring(0,18) == 'HLA EverGreen 2028' ? '<td class="dot">'+ parseInt(row.Fund2030) +'</td><td class="dot">'+ parseInt(row.Fund2035) +'</td>' : '') +
			      (row.Fund.substring(0,18) == 'HLA EverGreen 2030' ?  '<td class="dot">'+ parseInt(row.Fund2035) +'</td>' : '') +
			      '<td class="dot">'+ parseInt(row.VentureFund) +'</td>'+
			      '<td class="dot">'+ parseInt(row.DanaFund) +'</td>'+
			      '<td class="dot">'+ parseInt(row.RetireFund) +'</td>'+
			      '<td class="dot">'+ parseInt(row.CashFund) +'</td>'+
			    '</tr>'+
			  '</table>'+
			'</td>'+
			'<td>'+
			  '<table style="width: 90%;alignment-adjust: central">'+
				(row.Option == 'ReInvest' ?  '<tr><td class="dot">Tidak Berkenaan</td></tr>' : '') +
				(row.Option == 'Partial' ?  '<tr><td class="dot">Bull</td><td class="dot">Flat</td><td class="dot">Bear</td></tr><tr><td class="dot">' + CurrencyNoCents(row.WithdrawBull) + '</td><td class="dot">' + CurrencyNoCents(row.WithdrawFlat) + '</td><td class="dot">' + CurrencyNoCents(row.WithdrawBear) + '</td></tr>' : '') +
				(row.Option == 'Withdraw' ? '<tr><td class="dot">Bull</td><td class="dot">Flat</td><td class="dot">Bear</td></tr><tr><td class="dot">' + CurrencyNoCents(row.WithdrawBull) + '</td><td class="dot">' + CurrencyNoCents(row.WithdrawFlat) + '</td><td class="dot">' + CurrencyNoCents(row.WithdrawBear) +'</td></tr>' : '') +
			  '</table>'+
			'</td>'+
			'<td>'+
			  '<table style="width: 90%;alignment-adjust: central">'+
				(row.Option == 'ReInvest' ?  '<tr><td class="dot">Bull</td><td class="dot">Flat</td><td class="dot">Bear</td></tr><tr><td class="dot">'+ CurrencyNoCents(row.ReInvestBull) +'</td><td class="dot">'+ CurrencyNoCents(row.ReInvestFlat) +'</td><td class="dot">'+ CurrencyNoCents(row.ReInvestBear) +'</td></tr>' : '') +
				(row.Option == 'Partial' ?  '<tr><td class="dot">Bull</td><td class="dot">Flat</td><td class="dot">Bear</td></tr><tr><td class="dot">'+ CurrencyNoCents(row.ReInvestBull) +'</td><td class="dot">'+ CurrencyNoCents(row.ReInvestFlat) +'</td><td class="dot">'+ CurrencyNoCents(row.ReInvestBear) +'</td></tr>' : '') +
				(row.Option == 'Withdraw' ? '<tr><td class="dot">Tidak Berkenaan</td></tr>' : '') +
			  '</table>'+
			'</td></tr>');		
		});
		
		
	}
	
	
}
function Page30_UV()
{
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {	
			if(parseInt(index) < 15){
				if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
					$('.Page30-SV').html('Surrender Value<br/>(RM)');
					$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				
				}
				else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
					$('.Page30-SV').html('Surrender Value<br/>(RM)');
					$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
					'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				}
				else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
					$('.Page30-SV').html('Surrender Value<br/>(After Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
					$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
				}
				else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
					$('.Page30-SV').html('Surrender Value<br/>(Ater Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
					$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
					'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				}	
			}
	     
		});
		
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30-MonthlyIncome').style.display = "none";
			document.getElementById('Page30-YearlyIncome').style.display = "none";
			document.getElementById('Page30-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', '5');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			
			document.getElementById('Page30-MonthlyIncome').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', '8');
			
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30-YearlyIncome').style.display = "none";
			document.getElementById('Page30-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 7);
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 9);
		}
		else{
			
		}
		
		
	}
	
}

function Page30_2_UV()
{
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {				
		if(parseInt(index) > 14 && parseInt(index) < 30){
				if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
					$('.Page30-SV').html('Surrender Value<br/>(RM)');
					$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				
				}
				else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
					$('.Page30-SV').html('Surrender Value<br/>(RM)');
					$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
					'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				}
				else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
					$('.Page30-SV').html('Surrender Value<br/>(After Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
					$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
				}
				else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
					(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
					$('.Page30-SV').html('Surrender Value<br/>(Ater Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
					$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
					'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
				}	
			}
	     
		});
		
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30_2-MonthlyIncome').style.display = "none";
			document.getElementById('Page30_2-YearlyIncome').style.display = "none";
			document.getElementById('Page30_2-Add').style.display = "none";
			document.getElementById('Page30_2-AddStart').style.display = "none";
			document.getElementById('Page30_2-AddEnd').style.display = "none";
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', '5');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			
			document.getElementById('Page30_2-MonthlyIncome').style.display = "none";
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', '8');
			
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30_2-YearlyIncome').style.display = "none";
			document.getElementById('Page30_2-Add').style.display = "none";
			document.getElementById('Page30_2-AddStart').style.display = "none";
			document.getElementById('Page30_2-AddEnd').style.display = "none";
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', 7);
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', 9);
		}
		else{
			
		}
		
		
	}
	
}
/*
function Page30_UV()
{
	
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {		
	 
		if(parseInt(index) < 15){
			if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
				$('.Page30-SV').html('Surrender Value<br/>(RM)');
				$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			
			}
			else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
				$('.Page30-SV').html('Surrender Value<br/>(RM)');
				$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
				'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			}
			else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
				$('.Page30-SV').html('Surrender Value<br/>(After Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
				$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
			}
			else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
				$('.Page30-SV').html('Surrender Value<br/>(Ater Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
				$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
				'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			}	
		}
	 
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
			'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
			'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		}
	     
		});
		
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30-MonthlyIncome').style.display = "none";
			document.getElementById('Page30-YearlyIncome').style.display = "none";
			document.getElementById('Page30-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', '5');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			
			document.getElementById('Page30-MonthlyIncome').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', '8');
			
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30-YearlyIncome').style.display = "none";
			document.getElementById('Page30-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 7);
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 9);
		}
		else{
			
		}	
	}
}

function Page30_2_UV()
{
	
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {		
	 			
		if(parseInt(index) > 14 && parseInt(index) < 30){
			if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
				$('.Page30-SV').html('Surrender Value<br/>(RM)');
				$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			
			}
			else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
				$('.Page30-SV').html('Surrender Value<br/>(RM)');
				$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
				'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			}
			else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
				$('.Page30-SV').html('Surrender Value<br/>(After Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
				$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
			}
			else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
				(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
				$('.Page30-SV').html('Surrender Value<br/>(Ater Tax Penalty)<sup><span class="fnPage11_ECAR60SV"></span></sup><br/>(RM)');
				$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
				'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
			}	
		}
	 
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
			'</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			$('#Page30_2-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +
			'</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td></tr>');
		}
	     
		});
		
		if(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30_2-MonthlyIncome').style.display = "none";
			document.getElementById('Page30_2-YearlyIncome').style.display = "none";
			document.getElementById('Page30_2-Add').style.display = "none";
			document.getElementById('Page30_2-AddStart').style.display = "none";
			document.getElementById('Page30_2-AddEnd').style.display = "none";
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', '5');	
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)  ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length == 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ){
			
			document.getElementById('Page30_2-MonthlyIncome').style.display = "none";
			document.getElementById('Page30_2-Guaranteed').setAttribute('colspan', '8');
			
		}
		else if(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			document.getElementById('Page30_2-YearlyIncome').style.display = "none";
			document.getElementById('Page30_2-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 7);
		}
		else if((gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0) ||
			(gdata.SI[0].UL_Temp_ECAR60.data.length != 0 && gdata.SI[0].UL_Temp_ECAR.data.length != 0 && gdata.SI[0].UL_Temp_ECAR6.data.length != 0)){
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', 9);
		}
		else{
			
		}	
	}
}
*/
function Page30_UP()
{
	
	if(gdata.SI[0].UL_Temp_Summary.data.length > 0){
		$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {		
			if(parseInt(index) < 30){
				if(gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
				$('#Page30-table2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
				'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) +  '</td><td>' + CurrencyNoCents(row.col7) +
				'</td><td>' + CurrencyNoCents(row.col8) +  '</td><td>' + CurrencyNoCents(row.col9) +  '</td><td>' + CurrencyNoCents(row.col10) +  '</td><td>' + CurrencyNoCents(row.col11) +  '</td></tr>');
				}
				else
				{
					$('#Page30-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
					'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) +  '</td><td>' + CurrencyNoCents(row.col7) +
					'</td><td>' + CurrencyNoCents(row.col8) +  '</td><td>' + CurrencyNoCents(row.col9) +  '</td></tr>');	
				}
			}
			
		});
		
		if(gdata.SI[0].UL_Temp_ECAR.data.length == 0 && gdata.SI[0].UL_Temp_ECAR6.data.length == 0  ){
			/*
			document.getElementById('Page30-MonthlyIncome').style.display = "none";
			document.getElementById('Page30-YearlyIncome').style.display = "none";
			document.getElementById('Page30-Add').style.display = "none";
			document.getElementById('Page30-AddStart').style.display = "none";
			document.getElementById('Page30-AddEnd').style.display = "none";
			document.getElementById('Page30-Guaranteed').setAttribute('colspan', '5');
			*/
			document.getElementById('Page30-table').style.display = "none";
		}
		else{
			document.getElementById('Page30-table2').style.display = "none";
		}	
	}
}

function Page31_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {		
		if(parseInt(index) < 30){
			$('#Page31-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13)  +
			'</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) +  '</td><td>' + CurrencyNoCents(row.col18) +
			'</td><td>' + CurrencyNoCents(row.col19) +  '</td></tr>');	
		}
		    
	});
	
	
}

function Page31_UP()
{
	
	$.each(gdata.SI[0].UL_Temp_Summary.data, function(index, row) {		
		if(parseInt(index) < 30){
			$('#Page31-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' +
			CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12)  + '</td><td>' +
			CurrencyNoCents(row.col13) + '</td><td>' + CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' +
			CurrencyNoCents(row.col16) +  '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) +  '</td></tr>');	
		}
		
	});
	
	
}

function Page40_UV()
{
	if(gdata.SI[0].PlanCode == 'UV'){
		$('.Page40Prem').html('180');	
	}
	else{
		$('.Page40Prem').html('180');
	}
}

function Page41_UV()
{
	$('.Page41Term').html(gdata.SI[0].CovPeriod);
	if(gdata.SI[0].PlanCode == 'UV'){
		$('.Page41Prem').html('180 - 11,999');	
	}
	else{
		$('.Page41Prem').html('180 - 11,999');
	}
	
	
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		var temp = [];
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			if(row.RiderCode == 'CIRD' || row.RiderCode ==  'DCA' || row.RiderCode == 'ACIR' || row.RiderCode == 'HMM' || row.RiderCode == 'MG_IV' || row.RiderCode == 'WI' || row.RiderCode == 'MR' ||
			   row.RiderCode =='TPDMLA' || row.RiderCode == 'PA' || row.RiderCode == 'DHI' || row.RiderCode == 'TPDYLA'){
				temp.push(row.RiderCode);
			}
			
		});
		
		
		if(temp.length > 0 ){
			document.getElementById('hidePage41').style.display = 'none';	
		}
		
	}
	
}

function Page42_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_Rider.data, function(index, row) {
		
		if(row.col1 != 'ECAR' && row.col1 != 'ECAR60' && row.col1 != 'ECAR6' && row.col1 != 'CIWP ' && row.col1 != 'LCWP' && row.col1 != 'LSR' && row.col1 != 'TPDWP' && row.col1 != 'TSER'
		   && row.col1 != 'TSR'){
			var temp;
			if(row.col2 == 'LA' && row.col3 == '1'){
				temp = ('(Hayat Diinsuranskan)');
			}
			else if(row.col2 == 'LA' && row.col3 == '2'){
				temp = ('(Hayat Diinsuranskan Kedua)');
			}
			else if(row.col2 == 'PY' && row.col3 == '1'){
				temp = ('(Pemunya Polisi)');
			}
			
			$('#Page42-table-design1 > tbody').append('<tr>' +
			'<td rowspan="2">' + row.col1 + ' ' + temp  + '</td>' +
			'<td rowspan="2" style="text-align: center">' + row.col4  + '</td>' +
			'<td style="text-align: center">%</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col5 == '0.00' ? '-' : row.col5) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col6 == '0.00' ? '-' : row.col6) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col7 == '0.00' ? '-' : row.col7) + '</td>'+
			'<td style="text-align: center">'+ formatCurrency(row.col8 == '0.00' ? '-' : row.col8) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col9 == '0.00' ? '-' : row.col9) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col10 == '0.00' ? '-' : row.col10) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col11 == '0.00' ? '-' : row.col11) + '</td>' +
			'</tr>' +
			'<tr>' + 
			'<td style="text-align: center">RM</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col5 == '0.00' ? '-' : parseFloat(row.col5) * 10) + '</td>' +	
			'<td style="text-align: center">'+ formatCurrency(row.col6 == '0.00' ? '-' : parseFloat(row.col6) * 10) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col7 == '0.00' ? '-' : parseFloat(row.col7) * 10) + '</td>'+
			'<td style="text-align: center">'+ formatCurrency(row.col8 == '0.00' ? '-' : parseFloat(row.col8) * 10) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col9 == '0.00' ? '-' : parseFloat(row.col9) * 10) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col10 == '0.00' ? '-' : parseFloat(row.col10) * 10) + '</td>' +
			'<td style="text-align: center">'+ formatCurrency(row.col11 == '0.00' ? '-' : parseFloat(row.col11) * 10) + '</td>' +
			'</tr>'
			
			);	
		}
		
		
	});
	
}

function Page44_UV(){
	
	var tempECAR60Exist = false;
	
	for(var i = 0; i < gdata.SI[0].UL_Temp_trad_Details.data.length; i++ ){
		if(gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode == 'ECAR60'){
			tempECAR60Exist = true;
			break;
		}
	}
	
	if(tempECAR60Exist == true){
		$('.Page44-ECAR60').html( '<b>Penalti Cukai untuk Penyerahan Penuh Awal</b><br/>' +
				'<b>Sejajar dengan objektif persaraan bagi produk Annuiti Tertangguh, anda akan dikenakan penalti cukai atas penyerahan rider ini sebelum umur persaraan minimum di samping caj penyerahan yang dikenakan. Untuk mengillustrasikan,' +
				'8% penalti cukai yang ditolak daripada nilai penyerahan anda adalah seperti berikut:<br/>' +
				'Dengan anggapan bahawa anda menyerahkan EverCash 60 Rider pada umur 50, nilai penyerahan EverCash 60 Rider adalah sebanyak RM50,000. Selepas penolakan penalti cukai sebanyak 8% atas jumlah pelepasan cukai yang dituntut ' +
				'(iaitu RM50,000 X 8/100 = RM4,000, yang dibayar kepada pihak berkuasa percukaian), anda hanya akan menerima RM46,000 (iaitu RM50,000 &dash; RM4,000) sebagai nilai penyerahan anda.</b>')		
	}
	else{
		$('.Page44-ECAR60').html( '&nbsp;');
	}
	
	
		
}



function Page50_UV()
{
	if(gdata.SI[0].ReducedPaidUpYear.substr(gdata.SI[0].ReducedPaidUpYear.length - 1) == '1'){
		$('.Page50-col1').html(gdata.SI[0].ReducedPaidUpYear + 'st');	
	}
	else if(gdata.SI[0].ReducedPaidUpYear.substr(gdata.SI[0].ReducedPaidUpYear.length - 1) == '2'){
		$('.Page50-col1').html(gdata.SI[0].ReducedPaidUpYear + 'nd');	
	}
	else if(gdata.SI[0].ReducedPaidUpYear.substr(gdata.SI[0].ReducedPaidUpYear.length - 1) == '3'){
		$('.Page50-col1').html(gdata.SI[0].ReducedPaidUpYear + 'rd');	
	}
	else {
		$('.Page50-col1').html(gdata.SI[0].ReducedPaidUpYear + 'th');	
	}
	
	var UpTo = 70 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);  
	/*
	if(UpTo.toString().substr(UpTo.length - 1) == '1'){
		$('.Page50-UpTo').html(UpTo + 'st');	
	}
	else if(UpTo.toString().substr(UpTo.length - 1) == '2'){
		$('.Page50-UpTo').html(UpTo + 'nd');	
	}
	else if(UpTo.toString().substr(UpTo.length - 1) == '3'){
		$('.Page50-UpTo').html(UpTo + 'rd');	
	}
	else {
		$('.Page50-UpTo').html(UpTo + 'th');	
	}
	*/
	if(gdata.SI[0].PlanCode == 'UV'){
			
			$('.Page50-Desc').html('Pemunya Polisi mempunyai hak untuk menukarkan pelan kepada Polisi Berbayar Terkurang pada sebarang tarikh ulang tahun polisi bermula dari tarikh ulang tahun polisi ke ' + (gdata.SI[0].ReducedPaidUpYear) + ' sehingga tarikh ulang tahun polisi ' + (UpTo.toString()) + ' , sekiranya nilai dana adalah mencukupi untuk<br/>' +
		'membayar caj tunggal. Setelah Berbayar Terkurang, caj tunggal akan ditolak daripada nilai dana untuk membiayai yuran polisi bulanan dan caj insurans bagi Pelan Asas untuk baki tempoh sehingga akhir tahun polisi serta-merta selepas Hayat Diinsuranskan<br/> ' +
		'mencapai umur 75. Premium, caj insurans dan yuran polisi bulanan bagi Pelan Asas akan dihentikan sepanjang tempoh tersebut.<br/> ' +
		'Setelah ditukar ke Polisi Berbayar Terkurang, Pelan Asas akan dijamin berkuat kuasa sepanjang tempoh tersebut. Walau bagaimanapun, anda dikehendaki untuk membayar premium, caj insurans dan yuran polisi bulanan bagi Pelan Asas selepas tempoh tamat<br/> ' +
		'sehingga kematangan polisi atau anda boleh memilih opsyen cuti premium yang menggunakan nilai dana untuk membiayai caj-caj bulanan.<br/> ' +
		'Ketika Kematian/ TPD/ OAD, yang mana berlaku terdahulu, jumlah daripada Jumlah Diinsuranskan Polisi Berbayar Terkurang bagi Pelan Asas tambah nilai dana akan dibayar. Nilai dana ditentukan dengan mendarabkan bilangan unit (baki unit selepas<br/> ' +
		'penolakkan caj tunggal dan rangkuman Unit Bonus Terjamin yang diperuntukkan ke dalam polisi) dengan harga unit semasa.<br/> ' +
		'Semasa kematangan, nilai dana akan dibayar. Untuk HLA EverGreen Fund, Harga Unit Terjamin Minimum pada Kematangan Dana adalah berkenaan.<br/><br/>');
	}
	else
	{
		$('.Page50-Desc').html('Pemunya Polisi mempunyai hak untuk menukarkan pelan kepada Polisi Berbayar Terkurang pada sebarang tarikh ulang tahun polisi bermula dari tarikh ulang tahun polisi ke-' + (gdata.SI[0].ReducedPaidUpYear) + ' sehingga tarikh ulang tahun polisi yang terakhir sebelum kematangan polisi, sekiranya' +
		'nilai dana adalah mencukupi untuk membayar caj tunggal. Setelah Berbayar Terkurang, caj tunggal akan ditolak daripada nilai dana untuk membiayai yuran polisi bulanan dan caj insurans bagi Pelan Asas untuk baki tempoh. Selepas itu, premium, caj insurans ' +
		'dan yuran polisi bulanan bagi Pelan Asas akan dihentikan.' +
		'Setelah ditukar ke Polisi Berbayar Terkurang, Pelan Asas akan dijamin berkuat kuasa sehingga kematangan.' + 
		'Ketika Kematian/ TPD/ OAD, yang mana berlaku terdahulu, jumlah daripada Jumlah Diinsuranskan Polisi Berbayar Terkurang bagi Pelan Asas tambah nilai dana akan dibayar. Nilai dana ditentukan dengan mendarabkan bilangan unit (baki unit selepas' +
		'penolakkan caj tunggal dan rangkuman Unit Bonus Terjamin yang diperuntukkan ke dalam polisi) dengan harga unit semasa.' + 
		'Semasa kematangan, nilai dana akan dibayar. Untuk HLA EverGreen Fund, Harga Unit Terjamin Minimum pada Kematangan Dana adalah berkenaan.');
	}
	
	var tempEntirePolicy = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear);
	var tempBasicPlanAndECARRider = 0.00;
	var tempBasicPlanAndOtherRider = 0.00;
	var ECAR = false;
	var ECAR6 = false;
	var ECAR60 = false;
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			
			tempP = parseInt(row.PaymentTerm) > parseInt(gdata.SI[0].ReducedPaidUpYear) ? gdata.SI[0].ReducedPaidUpYear : row.PaymentTerm;
			//tempEntirePolicy = parseFloat(tempEntirePolicy) + parseFloat((row.TotalPremium) * parseInt(tempP));
			
			if(row.RiderCode == 'ECAR'){
				ECAR = true;
				for(var i = 1; i <= tempP; i++){
					if(i <= row.RiderHLoadingTerm || parseInt(row.RiderHLoadingTerm) == '0'){
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium));		
					}
					else{
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)));		
					}		
				}
			}
			
			if(row.RiderCode == 'ECAR6'){
				ECAR6 = true;
				for(var i = 1; i <= tempP; i++){
					if(i <= row.RiderHLoadingTerm || parseInt(row.RiderHLoadingTerm) == '0'){
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium));		
					}
					else{
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)));		
					}		
				}
			}
			
			if(row.RiderCode == 'ECAR60' ){
				ECAR60 = true;
				for(var i = 1; i <= tempP; i++){
					if(i <= row.RiderHLoadingTerm || parseInt(row.RiderHLoadingTerm) == '0'){
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat((row.TotalPremium));		
					}
					else{
						//tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)) * parseInt(tempP));
						tempBasicPlanAndECARRider = parseFloat(tempBasicPlanAndECARRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)));		
					}		
				}
			}
			
			if(row.RiderCode != 'ECAR' && row.RiderCode != 'ECAR6' && row.RiderCode != 'ECAR60'  ){
				for(var i = 1; i <= tempP; i++){
					if(i <= row.RiderHLoadingTerm || parseInt(row.RiderHLoadingTerm) == '0'){
						tempBasicPlanAndOtherRider = parseFloat(tempBasicPlanAndOtherRider) + parseFloat((row.TotalPremium));		
					}
					else{
						tempBasicPlanAndOtherRider = parseFloat(tempBasicPlanAndOtherRider) + parseFloat(((row.TotalPremium) - (row.RiderLoadingPremium)));		
					}		
				}
			}
			
			tempEntirePolicy = parseFloat(tempEntirePolicy) + parseFloat(AnnualisedValue(tempBasicPlanAndECARRider)) + parseFloat(AnnualisedValue(tempBasicPlanAndOtherRider));
			
			
		});
	}
	
	var label;
	var tempRTUO = 0.00;
	var tempRTUOTerm = 0.00;
	var RTUOStart = 0.00;
	var RTUOEnd = 0.00;
	if(parseFloat(gdata.SI[0].TopupAmount) > 0){
		tempRTUOTerm = parseInt(gdata.SI[0].TopupEnd) - parseInt(gdata.SI[0].TopupStart) + 1;
		RTUOStart = gdata.SI[0].TopupStart;
		RTUOEnd = parseInt(gdata.SI[0].TopupEnd) + parseInt(1);
		
		if(parseInt(gdata.SI[0].ReducedPaidUpYear) >= parseInt(gdata.SI[0].TopupStart)){
			
			if(parseInt(gdata.SI[0].ReducedPaidUpYear) <= parseInt(gdata.SI[0].TopupEnd)){
				tempRTUO = AnnualisedValue(gdata.SI[0].TopupAmount);
				
			}
			else{
				tempRTUO = '0.00';
			}
		}
		else{
			tempRTUO = '0.00';
		}
	}
	
	if(parseFloat(tempBasicPlanAndECARRider) > 0){
		label = 'Pelan Asas'
		
		if(ECAR60 == true){
			label = label + ' + EverCash 60 Rider';
		}
		
		if(ECAR6 == true){
			label = label + ' + EverCash';
		}
		
		if(ECAR == true){
			label = label + ' + EverCash 1';
		}
		
		tempBasicPlanAndECARRider = (parseFloat(AnnualisedValue(tempBasicPlanAndECARRider)) + (parseFloat(AnnualisedValue(gdata.SI[0].ATPrem)) * parseInt(gdata.SI[0].ReducedPaidUpYear)) );
		$('.Page50-col4').html(CurrencyNoCents(parseFloat(tempBasicPlanAndECARRider) + parseFloat(tempRTUO) + parseFloat(tempBasicPlanAndOtherRider)));
	}
	else
	{
		label = '-'
		tempBasicPlanAndECARRider = '-';
		$('.Page50-col4').html(CurrencyNoCents(parseFloat(tempEntirePolicy) + parseFloat(tempRTUO)) );
	}
	
		
	$('.Page50-Rider').html(gdata.SI[0].ReducedPaidUpYear);			
	$('.Page50-col2').html(CurrencyNoCents( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear) ));
	$('.Page50-col3').html(CurrencyNoCents(tempBasicPlanAndECARRider));
	$('.Page50-col3-label').html(label);
	 
	$('.Page50-col5').html(CurrencyNoCents(gdata.SI[0].BasicSA));
	$('.Page50-col6').html(CurrencyNoCents(gdata.SI[0].ReducedSA));
	$('.Page50-col7').html(CurrencyNoCents(gdata.SI[0].ReducedCharge));
	
	var total1 = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear);
	var total2 = 0.00;
	
	if(gdata.SI[0].PlanCode == 'UV'){
		//total2 = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * (30 - parseInt(gdata.SI[0].ReducedPaidUpYear)) ;
		total2 = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * 25 ;
	}
	else{
		total2 = 0.00;
	}
	
	
	if(gdata.SI[0].PlanCode == 'UV'){
		$('#Page50-table2 > tbody').append('<tr>' + '<td rowspan="2">' + gdata.SI[0].PlanName +  '</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  gdata.SI[0].ReducedPaidUpYear + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
						  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
						  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
						  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
						  formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear)) + '</td><td>' +
						  'Penukaran kepada Polisi Berbayar Terkurang pada tarikh ulang tahun ke- ' + gdata.SI[0].ReducedPaidUpYear  + '</td></tr>' +
					   '<tr>' + '<td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  '25' + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
						  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
						  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
						  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
						   formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * 25) + '</td><td>' +
						  'Premium akan terus dibayar serta-merta selepas akhir tahun polisi di mana Hayat Diinsuranskan mencapai umur 75 sehingga kematangan polisi.' + '</td></tr>');
	}
	else{
		$('#Page50-table2 > tbody').append('<tr>' + '<td>HLA EverGain Plus</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  gdata.SI[0].ReducedPaidUpYear + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
						  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
						  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
						  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
						  formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear)) + '</td><td>' +
						  'Penukaran kepada Polisi Berbayar Terkurang pada tarikh ulang tahun ke- ' + gdata.SI[0].ReducedPaidUpYear  + '</td></tr>');
	}
	
	var totalRTUO = 0.00;
	
	if(parseFloat(tempRTUO) > 0){
		totalRTUO = (parseFloat(tempRTUO) * parseFloat(tempRTUOTerm));
		
		$('#Page50-table2 > tbody').append('<tr>' + '<td>Tambahan Berkala Akaun Unit Asas(Opsyenal)</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  tempRTUOTerm + '</td><td>' + formatCurrency(tempRTUO) + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  gdata.SI[0].HLoad + '</td><td>' + gdata.SI[0].HLoadTerm + '</td><td>' + gdata.SI[0].HLoadPct + '</td><td>' +
						  gdata.SI[0].HLoadPctTerm + '</td><td>' + formatCurrency(totalRTUO) + '</td><td>' +
						  'Premium Tambahan Berkala Akaun Unit Asas perlu Dibayar dari ulang tahun ke-' + gdata.SI[0].TopupStart + ' hingga ke-' + gdata.SI[0].TopupEnd + ' </td></tr>');
		
		
		 
	}
	
	var total3= 0.00;
	var aACIR = [];
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		
		var temp;
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			
			
			if(row.RiderCode == 'ECAR'){
				temp = 'Ini merupakan rider dengan tempoh bayaran premium terhad kepada 6 tahun';
			}
			else if(row.RiderCode == 'ECAR6'){
				temp = 'Ini merupakan rider dengan tempoh bayaran premium terhad kepada 6 tahun';
			}
			else{
				temp = 'Ini merupakan rider dengan tempoh bayaran premium penuh';
			}
			
			//total3 = parseFloat(total3) + parseFloat((AnnualisedValue(row.TotalPremium)) * parseInt(row.PaymentTerm));
			total3 = parseFloat(total3) + parseFloat(AnnualisedValue2(row.TotalPremium) * parseInt(row.PaymentTerm));
			
			var tempRiderPrem; 
			
			if(parseInt(row.RiderHLoadingTerm) > 0){
				//tempRiderPrem = parseInt(gdata.SI[0].ReducedPaidUpYear) > row.RiderHLoadingTerm ? parseFloat(AnnualisedValue(row.TotalPremium)) - parseFloat(row.RiderLoadingPremium) : row.TotalPremium  ;
				tempRiderPrem = AnnualisedValue2(row.TotalPremium); 
			}
			else{
				tempRiderPrem = AnnualisedValue2(row.TotalPremium); 
			}
			
			//if(parseInt(row.PaymentTerm) > parseInt(gdata.SI[0].ReducedPaidUpYear) ){
				
				
				if(row.RiderCode == 'ACIR'){
					$('#Page50-table2 > tbody').append('<tr>' + '<td >' + row.RiderDesc  +  ' *</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  row.PaymentTerm + '</td><td>' + formatCurrency(tempRiderPrem)  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  row.RiderHLoading + '</td><td>' + row.RiderHLoadingTerm + '</td><td>' + row.RiderHLoadingPct + '</td><td>' +
						  row.RiderHLoadingPctTerm + '</td><td>' + formatCurrency((AnnualisedValue(row.TotalPremium)) * parseInt(row.PaymentTerm)) + '</td><td>' +
						  temp + '</td></tr>');
					aACIR.push('ACIR');
					aACIR.push(row.SumAssured);
				}
				else
				{
					$('#Page50-table2 > tbody').append('<tr>' + '<td >' + row.RiderDesc  +  '</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  row.PaymentTerm + '</td><td>' + formatCurrency(tempRiderPrem)  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  row.RiderHLoading + '</td><td>' + row.RiderHLoadingTerm + '</td><td>' + row.RiderHLoadingPct + '</td><td>' +
						  row.RiderHLoadingPctTerm + '</td><td>' + formatCurrency(AnnualisedValue2(row.TotalPremium)* parseInt(row.PaymentTerm)) + '</td><td>' +
						  temp + '</td></tr>');
				}
			//}
			
		});
		$('#Page50-table2 > tfoot').append('<tr><td colspan = "11"> <b>Entire policy</b>&nbsp;&nbsp;&nbsp;' + formatCurrency( parseFloat(total1) + parseFloat(total2) + parseFloat(total3) + parseFloat(totalRTUO))  + '</td></tr>' )
		
		if(aACIR.length > 1){
			if(parseFloat(aACIR[1]) > parseFloat( gdata.SI[0].ReducedSA) ){
				$('.Page50-ShowACIR').html('Nota:' + '<br/>' +'* Jumlah Diinsuranskan Accelerated Critical Illness Rider (ACIR) dikehendaki supaya dikurangkan jika Jumlah Diinsuranskan Polisi Berbayar Terkurang bagi Pelan Asas' +
							   'adalah lebih kurang daripada Jumlah Diinsuranskan ACIR. Jika ' +
							   'Jumlah Diinsuranskan Polisi Berbayar Terkurang bagi Pelan Asas lebih kurang daripada RM' + formatCurrency(aACIR[1]) + ', ACIR tidak dibenarkan. Sila lengkapkan borang Berbayar Terkurang bagi Ever Series.');
			}
			else
			{
				$('.Page50-ShowACIR').html('');		
			}
			
		}
		else{
			$('.Page50-ShowACIR').html('');
		}
		
	}	
	else{
		$('#Page50-table2 > tfoot').append('<tr><td colspan = "11"> <b>Entire policy</b>&nbsp;&nbsp;&nbsp;' + formatCurrency( parseFloat(total1) + parseFloat(total2) + parseFloat(totalRTUO))  + '</td></tr>' )		
	}
    
    
	var temp1 = (parseInt(gdata.SI[0].ReducedPaidUpYear) + parseInt(1)) 
	var temp2 =(parseInt(75) - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
	var temp3 = parseInt(temp2) + 1;
	var temp4 = (parseInt(100) - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));    
	
	var arr = new Array();
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		temp1 = parseInt(temp1) - 1;
		arr.push(temp1);
		arr.push(temp2);
		arr.push(temp4);
		
		if(parseInt(RTUOEnd) > parseInt(gdata.SI[0].ReducedPaidUpYear)) { 
				if(arr.indexOf(RTUOEnd) == -1){ 
					arr.push(RTUOEnd);	
				}
		}
		
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			if(parseInt(row.PaymentTerm) > parseInt(gdata.SI[0].ReducedPaidUpYear)) { // if payment term of rider is more than RPU, add in into the array
				if(arr.indexOf(row.PaymentTerm) == -1){
					arr.push(row.PaymentTerm);	
				}
			}
					
		});
		
		arr.sort(compareNumbers);
		
		
		
		for(var i = 0; i < arr.length - 1; i++){
			
			var tempRider = 0.00;
			if(parseInt(RTUOEnd) >= parseInt(arr[i + 1])  ){
					
				tempRider = parseFloat(tempRider) + parseFloat(gdata.SI[0].TopupAmount);
					
			}
			
			$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
				
				if(parseInt(row.PaymentTerm) >= parseInt(arr[i + 1])  ){
					if(parseInt(arr[i + 1]) <= row.RiderHLoadingTerm || parseInt(row.RiderHLoadingTerm) == '0'){
						tempRider = parseFloat(tempRider)+ parseFloat(AnnualisedValue2(row.TotalPremium));				
					}
					else{
						tempRider = parseFloat(tempRider)+ parseFloat(AnnualisedValue2(row.TotalPremium)) - parseFloat(row.RiderLoadingPremium);
					}
					
				}
				
			
			});
			
			if(arr[i] >= temp2){
				tempRider = parseFloat(tempRider) + parseFloat(AnnualisedValue2(gdata.SI[0].ATPrem));
			}
			
			if((parseInt(arr[i]) + 1) < parseInt(gdata.SI[0].CovPeriod) ){
				if((parseInt(arr[i]) + 1) == parseInt(arr[i + 1]) ){
				$('#Page50-table3 > tbody').append('<tr><td>'  + arr[i + 1] + '</td><td>' +  formatCurrency(tempRider)  + '</td></tr>');
			}
			else{
				$('#Page50-table3 > tbody').append('<tr><td>' +  (parseInt(arr[i]) + 1) + '-' + arr[i + 1] + '</td><td>' +  formatCurrency(tempRider)  + '</td></tr>');	
			}
			}
			
			
			
		}
		
		
	}
	else{
		$('#Page50-table3 > tbody').append('<tr><td>' +  temp1 + '-' + temp2 + '</td><td>' + '0.00'  + '</td></tr>' +
					   '<tr><td>' + temp3 + '-' + temp4  + '</td><td>' + formatCurrency((AnnualisedValue2(gdata.SI[0].ATPrem) )) + '</td></tr>');
    	
	}
	
	
	
    
	if(parseInt(gdata.SI[0].ReducedPaidUpYear) > 24){
		//$('.Page50-ShowIllus').html('Please note that you have selcted to convert the Basic Plan to a Reduced Paid Up policy after 24th policy aniversary. Therefore, projected fund value for the Reduced Paid Up Policy is not illustrated here.');	
	}
	else{
		$('.Page50-ShowIllus').html('');	
	}
	
}

function AnnualisedValue(input){
	
	if(gdata.SI[0].BumpMode == 'A'){
		return(input);	
	}
	else if(gdata.SI[0].BumpMode == 'S'){
		return(parseFloat((input)/0.5).toFixed(2));	
	}
	else if(gdata.SI[0].BumpMode == 'Q'){
		return(parseFloat((input) / 0.25).toFixed(2));	
	}
	else {
		
		return(parseFloat((input)/0.0833333).toFixed(2));	
	}
}

function AnnualisedValue2(input){
	
	if(gdata.SI[0].BumpMode == 'A'){
		return(input);	
	}
	else if(gdata.SI[0].BumpMode == 'S'){
		return(parseFloat((input)  * 2).toFixed(2));	
	}
	else if(gdata.SI[0].BumpMode == 'Q'){
		return(parseFloat((input) * 4).toFixed(2));	
	}
	else {
		
		return(parseFloat((input) * 12).toFixed(2));	
	}
}

function compareNumbers(a, b)
{
    return a - b;
}

function CheckValue(aaValue){
	if(aaValue == 'N/A'){
		return 0;
	}
	else{
		return aaValue;
	}
		
}

function Page51_UV(){
	
	if(gdata.SI[0].UL_Temp_RPUO.data.length > 0){
		//var tempSum = 0.00;
		$.each(gdata.SI[0].UL_Temp_RPUO.data, function(index, row) {
			if(row.col1 == 'BULL'){
				/*
				tempSum = parseFloat(CheckValue(row.col3)) + parseFloat(CheckValue(row.col4)) + parseFloat(CheckValue(row.col5)) +
				parseFloat(CheckValue(row.col6)) + parseFloat(CheckValue(row.col7)) + parseFloat(row.col8) + parseFloat(row.col9) + parseFloat(row.col10);
				*/
				$('#Page51-table1 > tbody').append('<tr>' + '<td style="height:25px" >' + row.col2  +  '</td><td>' + CurrencyNoCents(row.col3)  + '</td><td>' +
					  CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5)  + '</td><td>' + CurrencyNoCents(row.col6)  + '</td><td>' + 
					  CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) + '</td><td>' +
					  CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');			
			}
			else if(row.col1 == 'FLAT'){
				/*
				tempSum = parseFloat(CheckValue(row.col3)) + parseFloat(CheckValue(row.col4)) + parseFloat(CheckValue(row.col5)) +
				parseFloat(CheckValue(row.col6)) + parseFloat(CheckValue(row.col7)) + parseFloat(row.col8) + parseFloat(row.col9) + parseFloat(row.col10);
				*/
				$('#Page51-table2 > tbody').append('<tr><td style="height:25px">' + row.col2 +  '</td><td>' + CurrencyNoCents(row.col3)   + '</td><td>' +
					  CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5)  + '</td><td>' + CurrencyNoCents(row.col6)  + '</td><td>' +
					  CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) + '</td><td>' +
					  CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');			
			}
			else if(row.col1 == 'BEAR'){
				/*
				tempSum = parseFloat(CheckValue(row.col3)) + parseFloat(CheckValue(row.col4)) + parseFloat(CheckValue(row.col5)) +
				parseFloat(CheckValue(row.col6)) + parseFloat(CheckValue(row.col7)) + parseFloat(row.col8) + parseFloat(row.col9) + parseFloat(row.col10);
				*/
				$('#Page51-table3 > tbody').append('<tr>' + '<td style="height:25px">' + row.col2  +  '</td><td>' + CurrencyNoCents(row.col3)  + '</td><td>' +
					  CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5)  + '</td><td>' + CurrencyNoCents(row.col6)  + '</td><td>' +
					  CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) + '</td><td>' +
					  CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
			}
			else if(row.col1 == 'Details'){
				$('#Page51-details > tbody').append('<tr>' + '<td style="height:25px" >' + row.col2  +  '</td><td>' +
								    formatCurrency(row.col3)  + '</td><td>' +
									row.col4 + '</td><td>' +
									formatCurrency(row.col5)  + '</td></tr>');							
			}
		});
		
	}	

}

function writeRiderPage3()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data.length > 0){
	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[0].col1);
	$('#rider2Page3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[0].col5);
	$('#rider3Page3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[0].col9);
	
	$('#col0_1_EPage3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[1].col0_1);
	$('#col0_2_EPage3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[1].col0_2);
	
	$('#col0_1_MPage3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[2].col0_1);
	$('#col0_2_MPage3').html(gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[2].col0_2);
    
	for (var i = 1; i < 2; i++) {
	    for (var j = 1; j < 13; j++) {//row header
		    row = gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[i];
		$('#col' + j + '_EPage3').html(eval('row.col' + j));
		row = gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[i+1];
		$('#col' + j + '_MPage3').html(eval('row.col' + j));
	    }
	}

	for (var i = 2; i < gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data.length; i++) {//row data
	    row = gdata.SI[0].UL_Temp_Trad_Rider.p3[0].data[i];
	    $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' +
						      CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +
						      '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' +
						      CurrencyNoCents(row.col12) +'</td><td>' + CurrencyNoCents(row.col13) + '</td></tr>');
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
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data.length > 0){
		$('#rider1Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col1);
    	$('#rider2Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col5);
    	$('#rider3Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col9);
    	
    	$('#col0_1_EPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i];
        	row2 = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage4').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i];
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
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data.length > 0){
		$('#rider1Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col1);
    	$('#rider2Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col5);
    	$('#rider3Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col9);
    	
    	$('#col0_1_EPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i];
        	row2 = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage5').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i];
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
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data.length > 0){
		$('#rider1Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col1);
    	$('#rider2Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col5);
    	$('#rider3Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col9);
    	
    	$('#col0_1_EPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i];
        	row2 = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage6').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i];
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
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data.length > 0){
		$('#rider1Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col1);
    	$('#rider2Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col5);
    	$('#rider3Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col9);
    	
    	$('#col0_1_EPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i];
        	row2 = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage7').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i];
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
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data.length > 0){
		$('#rider1Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col1);
    	$('#rider2Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col5);
    	$('#rider3Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col9);
    	
    	$('#col0_1_EPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[1].col0_1 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[2].col0_1 + "</i>");
    	$('#col0_2_EPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[1].col0_2 + "<br/><br/><i>" + gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[2].col0_2 + "</i>");
	
	for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i];
        	row2 = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i+1];
        	if(eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)"){
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><i>" + eval('row2.col' + j) + "</i>");
            }
            else{
            	$('#col' + j + '_EPage8').html(eval('row.col' + j) + "<br/><br/><i>" + eval('row2.col' + j) + "</i>");
            }
        }
    }
    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i];
        $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) +'</td></tr>');
    }
    }
}


function writeRiderDescription_EN()
{
	$.each(gdata.SI[0].UL_Temp_Pages.data, function(index, row) {
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
					
				if(rider[i] == 'PR_SECOND' || rider[i] == 'LCWP_SECOND'){
					$("#" + row.PageDesc + " .RiderDescPType").html('Hayat Diinsuranskan kedua');
				}
				else if(rider[i] == 'PR_PAYOR' || rider[i] == 'LCWP_PAYOR'){
					$("#" + row.PageDesc + " .RiderDescPType").html('Pemunya Polisi');
				}
				else{
					$("#" + row.PageDesc + " .RiderDescPType").html('Hayat Diinsuranskan pertama');
				}
				
				
				if(rider[i] == 'LCWP_PAYOR' || rider[i] == 'LCWP_SECOND'){
					tblRider = "#" + row.PageDesc + " #table-design1 tr." + 'LCWP';
				}
				else if(rider[i] == 'PR_PAYOR' || rider[i] == 'PR_SECOND'){
					tblRider = "#" + row.PageDesc + " #table-design1 tr." + 'PR';
				}
				else{
					tblRider = "#" + row.PageDesc + " #table-design1 tr." + rider[i];
				}				
					
				//tblRider = "#" + row.PageDesc + " #table-design1 tr." + rider[i];
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
							
								if (rowRider.PlanOption == "Level"){
								    $("#" + row.PageDesc + ' .cPlanOption').html('Level Cover');
								    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
								    $("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
								    $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html('');
								    $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html('');
								}
								else if (rowRider.PlanOption == "Increasing"){ //wideTable value? nursing care allowance?
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
								else if (rowRider.PlanOption == "Level_NCB"){
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
								else if (rowRider.PlanOption == "Increasing_NCB"){
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
					else if (rider[i] == "ACIR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "ACIR"){
								$("#" + row.PageDesc + " .ACIRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .ACIRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .ACIRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .ACIRRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');							
								
							}
						});
					}
					else if (rider[i] == "CIRD"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "CIRD"){
								$("#" + row.PageDesc + " .CIRDRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .CIRDRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .CIRDRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .CIRDRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "CIWP"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "CIWP"){
								$("#" + row.PageDesc + " .CIWPRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .CIWPRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .CIWPRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .CIWPRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
								
							}
						});
					}
					else if (rider[i] == "DCA"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "DCA"){
								$("#" + row.PageDesc + " .DCARiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .DCARiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .DCARiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .DCARiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "DHI"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "DHI"){
								$("#" + row.PageDesc + " .DHIRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .DHIRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .DHIRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .DHIRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "ECAR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "ECAR"){
								$("#" + row.PageDesc + " .ECARRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .ECARRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .ECARRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .ECARRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "ECAR6"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "ECAR6"){
								$("#" + row.PageDesc + " .ECAR6RiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .ECAR6RiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .ECAR6RiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .ECAR6RiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "ECAR60"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "ECAR60"){
								$("#" + row.PageDesc + " .ECAR60RiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .ECAR60RiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .ECAR60RiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .ECAR60RiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							}
						});
					}
					else if (rider[i] == "TCCR"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "TCCR"){
									$("#" + row.PageDesc + " .TCCRRiderTerm").html(rowRider.CovPeriod);	
									$("#" + row.PageDesc + " .TCCRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .TCCRRiderPlan").html('-'+"");
									$("#" + row.PageDesc + " .TCCRRiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
									$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
								}
							});
					}
					else if (rider[i] == "JCCR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "JCCR"){
								$("#" + row.PageDesc + " .JCCRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .JCCRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .JCCRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .JCCRRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
							}
						});
					}
					else if (rider[i] == "HMM"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "HMM"){
								$("#" + row.PageDesc + " .HMMRiderTerm").html(rowRider.CovPeriod);	
								//$("#" + row.PageDesc + " .HMMRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .HMMRiderSA").html('-'+"");
								$("#" + row.PageDesc + " .HMMRiderPlan").html(rowRider.PlanOption + '<br/>Penolakan<br/>(RM' + rowRider.Deductible + ')' );
								$("#" + row.PageDesc + " .HMMRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "LCWP_SECOND"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "LCWP" && rowRider.PTypeCode == "LA" ){
								
								$("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.CovPeriod);					
								
								$("#" + row.PageDesc + " .LCWPRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .LCWPRiderPlan").html('-');
								$("#" + row.PageDesc + " .LCWPRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
								
							}
							
						});
					}
					else if (rider[i] == "LCWP_PAYOR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "LCWP" && rowRider.PTypeCode == "PY" ){
								$("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.CovPeriod);					
								
								$("#" + row.PageDesc + " .LCWPRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .LCWPRiderPlan").html('-');
								$("#" + row.PageDesc + " .LCWPRiderBenefit").html('-'+"");
								if(gdata.SI[0].UL_Temp_trad_LA.data.length > 1){
									$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[2].Name);	
								}
								else{
									$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);
								}
								$("#" + row.PageDesc + ' #illness tr').css('display','table-row');
								
							}
						});
					}
					else if (rider[i] == "LDYR"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "LDYR"){
									$("#" + row.PageDesc + " .LDYRRiderTerm").html(rowRider.CovPeriod);					
									$("#" + row.PageDesc + " .LDYRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .LDYRRiderPlan").html('-');
									$("#" + row.PageDesc + " .LDYRRiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								}
							});
						}
						else if (rider[i] == "LDYR-PCB"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "LDYR-PCB"){
									$("#" + row.PageDesc + " .LDYR-PCBRiderTerm").html(rowRider.CovPeriod);					
									$("#" + row.PageDesc + " .LDYR-PCBRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .LDYR-PCBRiderPlan").html('-');
									$("#" + row.PageDesc + " .LDYR-PCBRiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								}
							});
						}
						else if (rider[i] == "LDYR-BBB"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "LDYR-BBB"){
									$("#" + row.PageDesc + " .LDYR-BBBRiderTerm").html(rowRider.CovPeriod);					
									$("#" + row.PageDesc + " .LDYR-BBBRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .LDYR-BBBRiderPlan").html('-');
									$("#" + row.PageDesc + " .LDYR-BBBRiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								}
							});
						}
					else if (rider[i] == "LSR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "LSR"){
								$("#" + row.PageDesc + " .LSRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .LSRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .LSRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .LSRRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "MDSR1"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "MDSR1"){
									$("#" + row.PageDesc + " .MDSR1RiderTerm").html(rowRider.CovPeriod);	
									//$("#" + row.PageDesc + " .HMMRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .MDSR1RiderSA").html('-'+"");
									$("#" + row.PageDesc + " .MDSR1RiderPlan").html(rowRider.PlanOption + '<br/>Pre-Retirement Deductible<br/> : RM' + rowRider.PreDeductible + '<br/>Post-Retirement Deductible<br/>(RM' + rowRider.PostDeductible + ')' );
									$("#" + row.PageDesc + " .MDSR1RiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
									$("#" + row.PageDesc + " .MDSR1RiderPreDed").html(rowRider.PreDeductible);
									$("#" + row.PageDesc + " .MDSR1RiderPostDed").html(rowRider.PostDeductible);
								}
								
								if (rowRider.RiderCode == "MDSR1-ALW"){
									document.getElementById('MDSR1ALW').style.display = '';
								}
								
								if (rowRider.RiderCode == "MDSR1-OT"){
									document.getElementById('MDSR1OT').style.display = '';
								}
							});
						}
						else if (rider[i] == "MDSR2"){
							$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
								if (rowRider.RiderCode == "MDSR2"){
									$("#" + row.PageDesc + " .MDSR2RiderTerm").html(rowRider.CovPeriod);	
									//$("#" + row.PageDesc + " .HMMRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
									$("#" + row.PageDesc + " .MDSR2RiderSA").html('-'+"");
									$("#" + row.PageDesc + " .MDSR2RiderPlan").html(rowRider.PlanOption + '<br/>Pre-Deductible<br/>(RM' + rowRider.PreDeductible + ')<br/>Post-Deductible<br/>(RM' + rowRider.PostDeductible + ')' );
									$("#" + row.PageDesc + " .MDSR2RiderBenefit").html('-'+"");
									$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
									$("#" + row.PageDesc + " .MDSR2RiderPreDed").html(rowRider.PreDeductible);
									$("#" + row.PageDesc + " .MDSR2RiderPostDed").html(rowRider.PostDeductible);
									
								}
								
								if (rowRider.RiderCode == "MDSR2-ALW"){
									document.getElementById('MDSR2ALW').style.display = '';
								}
								
								if (rowRider.RiderCode == "MDSR2-OT"){
									document.getElementById('MDSR2OT').style.display = '';
								}
							});
						}
					else if (rider[i] == "MG_IV"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "MG_IV"){
								$("#" + row.PageDesc + " .MG_IVRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .MG_IVRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .MG_IVRiderPlan").html(rowRider.PlanOption);
								$("#" + row.PageDesc + " .MG_IVRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "MR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "MR"){
								$("#" + row.PageDesc + " .MRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .MRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .MRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .MRRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "PA"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "PA"){
								$("#" + row.PageDesc + " .PARiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .PARiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .PARiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .PARiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "PR_PAYOR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "PR" && rowRider.PTypeCode == "PY"){
								$("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .PRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .PRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .PRRiderBenefit").html('-'+"");
								//$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);
								if(gdata.SI[0].UL_Temp_trad_LA.data.length > 1){
									$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[2].Name);	
								}
								else{
									$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);
								}
								
							}
						});
					}
					else if (rider[i] == "PR_SECOND"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "PR" && rowRider.PTypeCode == "LA"){
								$("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .PRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .PRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .PRRiderBenefit").html('-'+"");
								//$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);
								
								$("#" + row.PageDesc + " .SecondLA").html(gdata.SI[0].UL_Temp_trad_LA.data[1].Name);	
								
								
								
							}
						});
					}
					else if (rider[i] == "TSER"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "TSER"){
								$("#" + row.PageDesc + " .TSERRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .TSERRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .TSERRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .TSERRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);		
							}
							
						});
					}
					else if (rider[i] == "TSR"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "TSR"){
								$("#" + row.PageDesc + " .TSRRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .TSRRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .TSRRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .TSRRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
							
							
						});
					}
					/*
					else if (rider[i] == "RRTUO"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "RRTUO"){
								$("#" + row.PageDesc + " .RRTUORiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .RRTUORiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .RRTUORiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .RRTUORiderBenefit").html('-'+"");
								
								
							}
						});
					}
					*/
					else if (rider[i] == "TPDMLA"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "TPDMLA"){
								$("#" + row.PageDesc + " .TPDMLARiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .TPDMLARiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .TPDMLARiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .TPDMLARiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "TPDYLA"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "TPDYLA"){
								$("#" + row.PageDesc + " .TPDYLARiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .TPDYLARiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .TPDYLARiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .TPDYLARiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "TPDWP"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "TPDWP"){
								$("#" + row.PageDesc + " .TPDWPRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .TPDWPRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .TPDWPRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .TPDWPRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
							}
						});
					}
					else if (rider[i] == "WI"){
						$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, rowRider) {	
							if (rowRider.RiderCode == "WI"){
								$("#" + row.PageDesc + " .WIRiderTerm").html(rowRider.CovPeriod);	
								$("#" + row.PageDesc + " .WIRiderSA").html(formatCurrency(rowRider.SumAssured)+"");
								$("#" + row.PageDesc + " .WIRiderPlan").html('-'+"");
								$("#" + row.PageDesc + " .WIRiderBenefit").html('-'+"");
								$("#" + row.PageDesc + " .FirstLA").html(gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
								
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

function writeRiderDescription2_EN()
{
	$.each(gdata.SI[0].UL_Temp_Pages.data, function(index, row) {
		//alert(row.htmlName)
		
		if (row.htmlName == "Page36_2.html" ){
			
			if(row.riders.charAt(row.riders.length-1) == ";"){
				rider = row.riders.slice(0, -1).split(";");
			}
			else{
				rider = row.riders.split(";");
			}
		
			for (i=0;i<rider.length;i++){
				
				tblRider = "#" + row.PageDesc + " #table-design2 tr." + rider[i];
				$(tblRider).css('display','table-row');
					
					
					
					
			}
		}
	});



}

function writeRiderDescription2_BM()
{
	$.each(gdata.SI[0].UL_Temp_Pages.data, function(index, row) {
		//alert(row.htmlName)
		
		if (row.htmlName == "Page35_2.html" ){
			
			if(row.riders.charAt(row.riders.length-1) == ";"){
				rider = row.riders.slice(0, -1).split(";");
			}
			else{
				rider = row.riders.split(";");
			}
		
			for (i=0;i<rider.length;i++){
				
				tblRider = "#" + row.PageDesc + " #table-design2 tr." + rider[i];
				$(tblRider).css('display','table-row');
					
					
					
					
			}
		}
	});



}

function Page7_UV()
{
	var Found1 = false;
	var Found2 = false;
	var FoundValue1;
	var FoundValue2;
	
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic) {		
	
	    if(parseInt(index) < 15){
			$('#table-Summary1 > tbody').append('<tr><td>' + rowBasic.col0_1 + '</td><td>' + rowBasic.col0_2 + '</td><td>' + CurrencyNoCents(rowBasic.col1) + '</td><td>' + formatCurrency(rowBasic.col2) +
			'</td><td>' + CurrencyNoCents(rowBasic.col3) + '</td><td>' + CurrencyNoCents(parseFloat(rowBasic.col4))  + '</td><td>' + CurrencyNoCents(rowBasic.col5)  +
			'</td><td>' + CurrencyNoCents(rowBasic.col6)  + '</td><td>' + CurrencyNoCents(rowBasic.col7)  + '</td><td>' + CurrencyNoCents(rowBasic.col8)  + '</td><td>' + CurrencyNoCents(rowBasic.col9)  +
			'</td><td>' + CurrencyNoCents( rowBasic.col10) + '</td><td>' + CurrencyNoCents( rowBasic.col11) + '</td><td>' + CurrencyNoCents( rowBasic.col12) +
			'</td><td>' + CurrencyNoCents( rowBasic.col13) + '</td></tr>');
			    
			if(parseFloat(rowBasic.col10) > parseFloat(rowBasic.col5) && Found1 == false ) {
				Found1 = true;
				FoundValue1 = parseInt(rowBasic.col0_2)  - 2;
				
			}			
			
			if(parseFloat(rowBasic.col11) > parseFloat(rowBasic.col6) && Found2== false ) {
				Found2 = true;
				FoundValue2 = parseInt(rowBasic.col0_2)  - 2
			}  
		}		  
	});
	
	if(Found1 == true){
		$('#Page8BasicAge').html('Caj-caj insurans bulanan akan melebihi premium yang diperuntukkan bulanan apabila Hayat Diinsuranskan berusia ' + FoundValue1  + '(harijadi lepas).<br/>');
	} else {
		$('#Page8BasicAge').html('');	
	}
	
	if(Found2 == true){
		$('#Page8RiderAge').html('Caj-caj insurans bulanan rider (rider-rider) akan melebihi premium yang diperuntukkan bulanan rider (rider-rider) apabila Hayat Diinsuranskan berusia ' + FoundValue2 + '(harijadi lepas).');
	} else {
		$('#Page8RiderAge').html('');	
	}   
}

function Page7_2_UV()
{
	var Found1 = false;
	var Found2 = false;
	var FoundValue1;
	var FoundValue2;
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic) {	
	
		if(parseInt(index) > 14 && parseInt(index) < 30){
			$('#table-Summary1_2 > tbody').append('<tr><td>' + rowBasic.col0_1 + '</td><td>' + rowBasic.col0_2 + '</td><td>' + CurrencyNoCents(rowBasic.col1) + '</td><td>' + formatCurrency(rowBasic.col2) +
			'</td><td>' + CurrencyNoCents(rowBasic.col3) + '</td><td>' + CurrencyNoCents(parseFloat(rowBasic.col4))  + '</td><td>' + CurrencyNoCents(rowBasic.col5)  +
			'</td><td>' + CurrencyNoCents(rowBasic.col6)  + '</td><td>' + CurrencyNoCents(rowBasic.col7)  + '</td><td>' + CurrencyNoCents(rowBasic.col8)  + '</td><td>' + CurrencyNoCents(rowBasic.col9)  +
			'</td><td>' + CurrencyNoCents( rowBasic.col10) + '</td><td>' + CurrencyNoCents( rowBasic.col11) + '</td><td>' + CurrencyNoCents( rowBasic.col12) +
			'</td><td>' + CurrencyNoCents( rowBasic.col13) + '</td></tr>');
			    
			if(parseFloat(rowBasic.col10) > parseFloat(rowBasic.col5) && Found1 == false ) {
				Found1 = true;
				FoundValue1 = parseInt(rowBasic.col0_2)  - 2;
				
			}			
			
			if(parseFloat(rowBasic.col11) > parseFloat(rowBasic.col6) && Found2== false ) {
				Found2 = true;
				FoundValue2 = parseInt(rowBasic.col0_2)  - 2
			}  
		}		  
	});
	
	if(Found1 == true){
		$('#Page8BasicAge').html('Caj-caj insurans bulanan akan melebihi premium yang diperuntukkan bulanan apabila Hayat Diinsuranskan berusia ' + FoundValue1  + '(harijadi lepas).<br/>');
	} else {
		$('#Page8BasicAge').html('');	
	}
	
	if(Found2 == true){
		$('#Page8RiderAge').html('Caj-caj insurans bulanan rider (rider-rider) akan melebihi premium yang diperuntukkan bulanan rider (rider-rider) apabila Hayat Diinsuranskan berusia ' + FoundValue2 + '(harijadi lepas).');
	} else {
		$('#Page8RiderAge').html('');	
	}   
}

function Page7_UP()
{
	var Found1 = false;
	var Found2 = false;
	var FoundValue1;
	var FoundValue2;
	
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic) {		
	        
		if(parseInt(index) < 30){    
			$('#table-Summary1 > tbody').append('<tr><td>' + rowBasic.col0_1 + '</td><td>' + rowBasic.col0_2 + '</td><td>' + CurrencyNoCents(rowBasic.col1) + '</td><td>' + formatCurrency(rowBasic.col2) +
			'</td><td>' + CurrencyNoCents(rowBasic.col3) + '</td><td>' + CurrencyNoCents(parseFloat(rowBasic.col4))  + '</td><td>' + CurrencyNoCents(rowBasic.col5)  +
			'</td><td>' + CurrencyNoCents(rowBasic.col7)  + 
			'</td><td>' + CurrencyNoCents( rowBasic.col10) + '</td><td>' + CurrencyNoCents( rowBasic.col12) +
			'</td><td>' + CurrencyNoCents( rowBasic.col13) + '</td></tr>');
					
			if(parseFloat(rowBasic.col10) > parseFloat(rowBasic.col5) && Found1 == false ) {
				Found1 = true;
				FoundValue1 = parseInt(rowBasic.col0_2)  - 2;
			
			}
		
		
			if(parseFloat(rowBasic.col11) > parseFloat(rowBasic.col6) && Found2== false ) {
				Found2 = true;
				FoundValue2 = parseInt(rowBasic.col0_2)  - 2
			}    
		}
	});
	
	if(Found1 == true){
		$('#Page8BasicAge').html('Caj-caj insurans bulanan akan melebihi premium yang diperuntukkan bulanan apabila Hayat Diinsuranskan berusia ' + FoundValue1  + '(harijadi lepas).<br/>');
	}
	else
	{
		$('#Page8BasicAge').html('');	
	}
	
	if(Found2 == true){
		$('#Page8RiderAge').html('Caj-caj insurans bulanan rider (rider-rider) akan melebihi premium yang diperuntukkan bulanan rider (rider-rider) apabila Hayat Diinsuranskan berusia ' + FoundValue2 + '(harijadi lepas).');
	}
	else
	{
		$('#Page8RiderAge').html('');	
	}   
}

function Page9_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic2) {
		if(parseInt(index) < 30){
			var t1 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col20) : '-';
			var t2 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col21) : '-';
			var t3 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col22) : '-';
		 
			$('#Page9-table > tbody').append('<tr><td>' + rowBasic2.col0_1 + '</td><td>' + rowBasic2.col0_2 + '</td><td>' + CurrencyNoCents(rowBasic2.col14) + '</td><td>' + CurrencyNoCents(rowBasic2.col15) + '</td><td>' + CurrencyNoCents(rowBasic2.col16)  +
			'</td><td>' + CurrencyNoCents(rowBasic2.col17) + '</td><td>' + CurrencyNoCents(rowBasic2.col18) + '</td><td>' + CurrencyNoCents(rowBasic2.col19) + '</td><td>' +
			t1 + '</td><td>' + t2 + '</td><td>' + t3 + '</td></tr>');
		}
	     
	});
	
	if(parseFloat(gdata.SI[0].WithdrawAmount) > 0.00 ){
				
		$('.Page9Withdrawal').html('<span class="fnPage9_Withdrawal"></span> Jumlah Nilai Penyerahan adalah selepas pengeluaran berkala sebanyak RM' + 
		formatCurrency(gdata.SI[0].WithdrawAmount) + ' setiap ' + gdata.SI[0].WithdrawInterval +
					   ' tahun bermula daripada tahun polisi ' + gdata.SI[0].WithdrawAgeFrom + ' hingga tahun polisi ' + gdata.SI[0].WithdrawAgeTo + '. ');
		
		$('.Page9Label').html('');
	}
	else{
		$('.Page9Label').html('');
		$('.Page9Withdrawal').html('');
	}
	
	if(gdata.SI[0].ECARReinvest == 'Yes' ){
		$('.Page9ECARLabel').html('<br/>(Termasuk Pelaburan Semula GYI/ GMI)');		
	}
	else
	{
		$('.Page9ECARLabel').html('');
	}
    
}

function Page9_UP()
{
	
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic2) {		
	 
		if(parseInt(index) < 30){
			var t1 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col23) : '0';
			var t2 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col24) : '0';
			var t3 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col25) : '0';
			var t4 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col26) : '0';
			var t5 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col27) : '0';
			var t6 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col28) : '0';
			var t7 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col29) : '0';
			var t8 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col30) : '0';
			var t9 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col31) : '0';
	 
			$('#Page9-table > tbody').append('<tr><td>' + rowBasic2.col0_1 + '</td><td>' + rowBasic2.col0_2 + '</td><td>' +
			CurrencyNoCents(rowBasic2.col14) + '</td><td>' + CurrencyNoCents(rowBasic2.col15) + '</td><td>' + CurrencyNoCents(rowBasic2.col16)  + '</td><td>' +
			 t1 + '</td><td>' + t2 + '</td><td>' + t3 + '</td><td>' + 
			 t4 + '</td><td>' + t5 + '</td><td>' + t6 + '</td><td>' + 
			 t7 + '</td><td>' + t8 + '</td><td>' + t9 + '</td></tr>');
        }
	});
    
	if(parseFloat(gdata.SI[0].WithdrawAmount) > 0.00 ){
				
		$('.Page9Withdrawal').html('# Jumlah Nilai Penyerahan adalah selepas pengeluaran berkala sebanyak RM' + formatCurrency(gdata.SI[0].WithdrawAmount) + ' setiap ' + gdata.SI[0].WithdrawInterval +
					   ' tahun bermula daripada tahun polisi ' + gdata.SI[0].WithdrawAgeFrom + ' hingga tahun polisi ' + gdata.SI[0].WithdrawAgeTo + '. ');
		
		$('.Page9Label').html('#');
	}
	else{
		$('.Page9Label').html('');
		$('.Page9Withdrawal').html('');
	}
	
	if(gdata.SI[0].ECARReinvest == 'Yes' ){
		$('.Page9ECARLabel').html('<br/>(Termasuk Pelaburan Semula GYI/ GMI)');		
	}
	else
	{
		$('.Page9ECARLabel').html('');		
	}
}

function Page10_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_Trad_Basic.data, function(index, rowBasic2) {		
	 /*
		$('#Page10-table > tbody').append('<tr><td>' + rowBasic2.col0_1 + '</td><td>' + rowBasic2.col0_2 + '</td><td>' + CurrencyNoCents(rowBasic2.col23) + '</td><td>' + CurrencyNoCents(rowBasic2.col24) + '</td><td>' + CurrencyNoCents(rowBasic2.col25)  +
		'</td><td>' + CurrencyNoCents(rowBasic2.col26) + '</td><td>' + CurrencyNoCents(rowBasic2.col27) + '</td><td>' + CurrencyNoCents(rowBasic2.col28) + '</td><td>' + CurrencyNoCents(rowBasic2.col29) + '</td><td>' + CurrencyNoCents(rowBasic2.col30) + '</td><td>' + CurrencyNoCents(rowBasic2.col31) + '</td></tr>');
           */
		if(parseInt(index) < 30){
			var t1 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col23) : '-';
			var t2 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col24) : '-';
			var t3 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col25) : '-';
			var t4 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col26) : '-';
			var t5 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col27) : '-';
			var t6 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col28) : '-';
			var t7 = parseInt(rowBasic2.col14) > 0 ? CurrencyNoCents(rowBasic2.col29) : '-';
			var t8 = parseInt(rowBasic2.col15) > 0 ? CurrencyNoCents(rowBasic2.col30) : '-';
			var t9 = parseInt(rowBasic2.col16) > 0 ? CurrencyNoCents(rowBasic2.col31) : '-';
			
			$('#Page10-table > tbody').append('<tr><td>' + rowBasic2.col0_1 + '</td><td>' + rowBasic2.col0_2 + '</td><td>' +
							   t1 + '</td><td>' + t2  + '</td><td>' + t3   +'</td><td>' +
							   t4 + '</td><td>' + t5  + '</td><td>' + t6  + '</td><td>' +
							   t7 + '</td><td>' + t8 + '</td><td>' + t9  + '</td></tr>');
			
		}
	});
		
    
}

function Page11_UV()
{
	$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
		if(row.RiderCode == 'ECAR' || row.RiderCode == 'ECAR6' || row.RiderCode == 'ECAR60' ){
			tempReinvestOrPayout = row.ReinvestGYI;
			if(tempReinvestOrPayout == 'Yes'){
				$('.PayoutOrReinvest').html('(Reinvest)');		
			}
			else{
				$('.PayoutOrReinvest').html('(Pay Out)');		
			}
		}
		
	});
	
	$.each(gdata.SI[0].UL_Temp_ECAR60.data, function(index, rowBasic2) {		
		if(parseInt(index) < 30){
			$('#Page11-table > tbody').append('<tr><td>' + rowBasic2.col0_1 + '</td><td>' +
						  rowBasic2.col0_2 + '</td><td>' +
						  formatCurrency(rowBasic2.col1) + '</td><td>' +
						  CurrencyNoCents(rowBasic2.col2) + '</td><td>' +
						  CurrencyNoCents(rowBasic2.col3)  +'</td><td>' +
						  CurrencyNoCents(rowBasic2.col4) + '</td><td>' +
						  CurrencyNoCents(rowBasic2.col5) + '</td><td>' +
						  CurrencyNoCents(rowBasic2.col6) + '</td><td>' +
						  CurrencyNoCents(rowBasic2.col7) +  '</td></tr>');	
		}
		
                    
	});
    
}

function Page12_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_ECAR.data, function(index, row) {		
		
		if(parseInt(index) < 30){
			$('#Page12-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +  '</td></tr>');	
		}
		
	});
    
}

function Page15_UV()
{
	
	$.each(gdata.SI[0].UL_Temp_ECAR6.data, function(index, row) {		
		if(parseInt(index) < 30){
			$('#Page15-table > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3)  +
			'</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +  '</td><td>' + CurrencyNoCents(row.col8) +  '</td></tr>');	
		}
		
                    
	});
    
}

function writeI20R_1()
{	
	$('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-I20R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeI30R_1()
{
	$('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I30R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-I30R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I30R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeI40R_1()
{
	$('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I40R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-I40R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.I40R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-I40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-I40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-I40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-I40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID20R_1()
{
	$('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-ID20R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID30R_1()
{
	$('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID30R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-ID30R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID30R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeID40R_1()
{
	$('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID40R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-ID40R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.ID40R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-ID40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-ID40R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeIE20R_1()
{
	$('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.IE20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-IE20R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.IE20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-IE20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-IE20R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
	});
}

function writeIE30R_1()
{
	$('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '&nbsp;&nbsp;&nbsp;<i>Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc + '</i>'); 
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.IE20R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
		$('#table-IE20R1 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col3 + '</td><td>' + UL_Temp_Trad_RiderIllus.col4 + '</td><td>' + UL_Temp_Trad_RiderIllus.col5 + '</td><td>' + UL_Temp_Trad_RiderIllus.col6 + '</td><td>' + UL_Temp_Trad_RiderIllus.col7 + '</td><td>' + UL_Temp_Trad_RiderIllus.col8 + '</td><td>' + UL_Temp_Trad_RiderIllus.col9 + '</td><td>' + UL_Temp_Trad_RiderIllus.col10 + '</td><td>' + UL_Temp_Trad_RiderIllus.col11+ '</td></tr>');
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
	$.each(gdata.SI[0].UL_Temp_Trad_RiderIllus.IE30R[0].data, function(index, UL_Temp_Trad_RiderIllus) {		
    	if (colType == 1){
            $('#table-IE30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
    	}
    	else if (colType == 2){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col14 + '</td><td>' + UL_Temp_Trad_RiderIllus.col15 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td></tr>');  	
        }
        else if (colType == 3){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        }
        else if (colType == 4){
        	$('#table-IE30R2 > tbody').append('<tr><td>' + UL_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + UL_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + UL_Temp_Trad_RiderIllus.col12 + '</td><td>' + UL_Temp_Trad_RiderIllus.col13 + '</td><td>' + UL_Temp_Trad_RiderIllus.col16 + '</td><td>' + UL_Temp_Trad_RiderIllus.col17 + '</td><td>' + UL_Temp_Trad_RiderIllus.col18 + '</td><td>' + UL_Temp_Trad_RiderIllus.col19 + '</td><td>' + UL_Temp_Trad_RiderIllus.col20 + '</td><td>' + UL_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
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

function WriteFootnote(){

	var a = 1;
	
	
	
	if(gIndexRiders == true){
		$('.fnPage16_IndexRiders').html('[' + a +  ']');
		a++;
		$('.fnPage5_Age').html('[' + a +  ']');
		a++;
		
	}
	
	if(gdata.SI[0].UL_Temp_ECAR60.data.length > 0){
		$('.fnECAR60').html('[' + a +  ']');
		a++;		
	}
	

	$('.fnPage3_1').html('[' + a + ']');
	a++;
	
	$('.fnPage14').html('[' + a + ']');
	a++;
	
	var temp = false;
	for(var i = 0; i < gdata.SI[0].UL_Temp_trad_Details.data.length; i++){
		var row = gdata.SI[0].UL_Temp_trad_Details.data[i].RiderCode;
		
		if(row == 'ACIR' || row == 'CCR' || row == 'CIWP' ){
			temp = true;
			break;
		}
	}
	
	if(temp == true && gdata.SI[0].UL_Temp_ECAR60.data.length > 0 ){
		$('.fnPage35_CI').html('[' + a + ']');
		a++;
		$('.fnPage35_ECAR60').html('[' + a + ']');
		a++;
		
	}
	else if(temp == true && gdata.SI[0].UL_Temp_ECAR60.data.length == 0 ){
		$('.fnPage35_CI').html('[' + a +  ']');
		a++;
	}
	else if(temp == false && gdata.SI[0].UL_Temp_ECAR60.data.length > 0 ){
		$('.fnPage35_ECAR60').html('[' + a + ']');
		a++;
	}
	else {
		
	}
	
	$('.fnPage9_SV').html('[' + a + ']');
	a++;
	
	if(parseFloat(gdata.SI[0].WithdrawAmount) > 0.00 ){
		$('.fnPage9_Withdrawal').html('[' + a + ']');
		a++;
	}
	
	$('.fnPage10_TPD').html('[' + a + ']');
	a++;
	$('.fnPage10_OAD').html('[' + a + ']');
	a++;
	
	if(gdata.SI[0].UL_Temp_ECAR60.data.length > 0){
		$('.fnPage11_ECAR60SV').html('[' + a +  ']');
		a++;
	}
	
	$('.fnPage46_Net').html('[' + a + ']');
	a++;
	$('.fnPage46_Gross').html('[' + a + ']');
	a++;
	
}

function writeRiderPage1()
{
	
	if(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data.length > 0){
	
		//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
		$('#rider1Page1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[0].col1);
	    $('#rider2Page1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[0].col5);
	    $('#rider3Page1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[0].col9);
	    
	    $('#col0_1_EPage1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col0_1);
	    $('#col0_2_EPage1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col0_2);
	    
	    //$('#col0_1_MPage1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[2].col0_1);
	    //$('#col0_2_MPage1').html(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[2].col0_2);
	    
	    for (var i = 1; i < 2; i++) {
		for (var j = 1; j < 13; j++) {//row header
			row = gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[i];
		    $('#col' + j + '_EPage1').html(eval('row.col' + j));
		    //row = gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[i+1];
		    //$('#col' + j + '_MPage1').html(eval('row.col' + j));
		}
	    }
		
	var lengthToShow = gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data.length > 32 ? 32 : gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data.length;
		
	    for (var i = 2; i < parseInt(lengthToShow); i++) {//row data
		row = gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[i];
		$('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' +
						  CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +
						  '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' +
						  CurrencyNoCents(row.col12) +'</td><td>' + CurrencyNoCents(row.col13) + '</td></tr>');
	    }
	    
	    if(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[0].col0_1 == 'SECOND' ){
		$('.FirstPTypeRider').html('Hayat Diinsuranskan ke-dua');
	    }
	    else if(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[0].col0_1 == 'PAYOR' ){
		$('.FirstPTypeRider').html('Pemunya');
		
	    }
	    else{
		$('.FirstPTypeRider').html('Hayat Diinsuranskan Pertama');
	    }
	}
	
}

function writeRiderPage2()
{
		//alert(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data.length)
	if(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data.length > 0){
		
		$('#rider1Page2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[0].col1);
		$('#rider2Page2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[0].col5);
		$('#rider3Page2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[0].col9);
		
		$('#col0_1_EPage2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[1].col0_1);
		$('#col0_2_EPage2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[1].col0_2);
		
		$('#col0_1_MPage2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[2].col0_1);
		$('#col0_2_MPage2').html(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[2].col0_2);
		
		for (var i = 1; i < 2; i++) {
		    for (var j = 1; j < 13; j++) {//row header
			    row = gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[i];
			$('#col' + j + '_EPage2').html(eval('row.col' + j));
			row = gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[i+1];
			$('#col' + j + '_MPage2').html(eval('row.col' + j));
		    }
		}
	    
	    var lengthToShow = gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data.length > 32 ? 32 : gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data.length;
	    
		for (var i = 2; i < parseInt(lengthToShow); i++) {//row data
		    row = gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[i];
		    //$('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td><td>' + row.col13 +'</td></tr>');
		    $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' +
							      CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) +
							      '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' +
							      CurrencyNoCents(row.col12) +'</td><td>' + CurrencyNoCents(row.col13) + '</td></tr>');
		}
	    
		if(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[0].col0_1 == 'SECOND' ){
			$('.SecondPTypeRider').html('Hayat Diinsuranskan ke-dua');
		}
		else if(gdata.SI[0].UL_Temp_Trad_Rider.p2[0].data[0].col0_1 == 'PAYOR' ){
			$('.SecondPTypeRider').html('Pemunya');
		}
		else{
			$('.SecondPTypeRider').html('Hayat Diinsuranskan Pertama');
		}
	}
}



function writeRiderPage4()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data.length > 0){
	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col1);
    $('#rider2Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col5);
    $('#rider3Page4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[0].col9);
    
    $('#col0_1_EPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[1].col0_1);
    $('#col0_2_EPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[1].col0_2);
    
    $('#col0_1_MPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[2].col0_1);
    $('#col0_2_MPage4').html(gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i];
            $('#col' + j + '_EPage4').html(eval('row.col' + j));
            row = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i+1];
            $('#col' + j + '_MPage4').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p4[0].data[i];
        $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage5()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data.length > 0){

	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col1);
    $('#rider2Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col5);
    $('#rider3Page5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[0].col9);
    
    $('#col0_1_EPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[1].col0_1);
    $('#col0_2_EPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[1].col0_2);
    
    $('#col0_1_MPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[2].col0_1);
    $('#col0_2_MPage5').html(gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i];
            $('#col' + j + '_EPage5').html(eval('row.col' + j));
            row = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i+1];
            $('#col' + j + '_MPage5').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p5[0].data[i];
        $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage6()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data.length > 0){

	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col1);
    $('#rider2Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col5);
    $('#rider3Page6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[0].col9);
    
    $('#col0_1_EPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[1].col0_1);
    $('#col0_2_EPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[1].col0_2);
    
    $('#col0_1_MPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[2].col0_1);
    $('#col0_2_MPage6').html(gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i];
            $('#col' + j + '_EPage6').html(eval('row.col' + j));
            row = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i+1];
            $('#col' + j + '_MPage6').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p6[0].data[i];
        $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage7()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data.length > 0){

	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col1);
    $('#rider2Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col5);
    $('#rider3Page7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[0].col9);
    
    $('#col0_1_EPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[1].col0_1);
    $('#col0_2_EPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[1].col0_2);
    
    $('#col0_1_MPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[2].col0_1);
    $('#col0_2_MPage7').html(gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i];
            $('#col' + j + '_EPage7').html(eval('row.col' + j));
            row = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i+1];
            $('#col' + j + '_MPage7').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p7[0].data[i];
        $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + row.col11 + '</td><td>' + row.col12 +'</td></tr>');
    }
}
}

function writeRiderPage8()
{
if(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data.length > 0){

	//alert(gdata.SI[0].UL_Temp_Trad_Rider.p1[0].data[1].col1)
	$('#rider1Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col1);
    $('#rider2Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col5);
    $('#rider3Page8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[0].col9);
    
    $('#col0_1_EPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[1].col0_1);
    $('#col0_2_EPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[1].col0_2);
    
    $('#col0_1_MPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[2].col0_1);
    $('#col0_2_MPage8').html(gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[2].col0_2);
    
    for (var i = 1; i < 2; i++) {
    	for (var j = 1; j < 13; j++) {//row header
        	row = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i];
            $('#col' + j + '_EPage8').html(eval('row.col' + j));
            row = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i+1];
            $('#col' + j + '_MPage8').html(eval('row.col' + j));
        }
    }

    for (var i = 3; i < gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data.length; i++) {//row data
    	row = gdata.SI[0].UL_Temp_Trad_Rider.p8[0].data[i];
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
		return "-";
	
	if (parseFloat(num) < 0){
		return "-";
	}

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
	
	if (num == "-"){
		return "-";
	}
	
	if (num == "N/A"){
		return "N/A";
	}
	
	if (parseFloat(num) < 0){
		return "-";
	}
	
	num = parseFloat(num).toFixed(0);
	
	num = num.toString().replace(/\$|\,/g, '');
	if (isNaN(num)){
		num = "0";
	}
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