//ver1.9

var benefitPage1Limit = 28;
var benefitPage2Limit = 50;

var gData;

var WBRider = false;
var WB30Rider = false;
var WBi6 = false;
var WBd10 = false;
var EduWB = false;

var colType;

var AddRow = 0;

function getLADesc(row) {
	if (gdata.SI[0].QuotationLang == "Malay") {
		return row.LADescM;
	} else {
		return row.LADesc;
	}
}

function initializePage() {  	
	var LAData = gdata.SI[0].SI_Temp_trad_LA.data;		
	var male, female;
	var yes, no;
	if (gdata.SI[0].QuotationLang == "Malay") {
		male = "Lelaki";
		female = "Perempuan";
		yes = "Ya";
		no = "Tidak";
	} else {
		male = "Male";
		female = "Female";
		yes = "Yes";
		no = "No";
	}
	
	if(LAData.length == 1){
		var row = LAData[0];
		
		$('.LADesc').html(getLADesc(row));
		$('.LAName').html(row.Name);
		$('.LAAge').html(row.Age);
		
		if (row.Sex.substring(0, 1) == 'M'){	  
			$('.LASex').html(male);
		}
		else{
			$('.LASex').html(female);
		}
		if (row.Smoker == 'Y'){
			$('.LASmoker').html(yes);
		}
		else{
			$('.LASmoker').html(no);
		}
	}
	else if(LAData.length == 2){ //got 2nd life assured
		var row = LAData[0];
		var row2 = LAData[1];
		if (row2.PTypeCode == 'LA') {
			$('.LADesc').html(getLADesc(row) + '<br/>' + getLADesc(row2) + '<br/>');
			$('.LAName').html(row.Name + '<br/>' + row2.Name)  ;
			$('.LAAge').html(row.Age + '<br/>' + row2.Age);
			if (row.Sex.substring(0,1) == 'M' && row2.Sex.substring(0,1) == 'M'){
				$('.LASex').html(male + '<br/>' + male );
			}
			else if(row.Sex.substring(0,1) == 'M' && row2.Sex.substring(0,1) == 'F'){
				$('.LASex').html(male + '<br/>' + female );
			}
			else if(row.Sex.substring(0,1) == 'F' && row2.Sex.substring(0,1) == 'M'){
				$('.LASex').html(female + '<br/>' + male );
			}
			else{
				$('.LASex').html(female + '<br/>' + female );
			}
						   
			if (row.Smoker == 'Y' && row2.Smoker == 'Y' ){
				$('.LASmoker').html(yes + '<br/>' + yes  );
			}
			else if (row.Smoker == 'Y' && row2.Smoker == 'N' ){
				$('.LASmoker').html(yes + '<br/>' + no  );
			}
			else if (row.Smoker == 'N' && row2.Smoker == 'Y' ){
				$('.LASmoker').html(no + '<br/>' + yes  );
			}
			else{
				$('.LASmoker').html(no + '<br/>' + no );
			}
		}
		else{ // got payor
			$('.LADesc').html(getLADesc(row) + '<br/>' + getLADesc(row2) + '<br/>');
			$('.LAName').html(row.Name + '<br/>' + row2.Name)  ;
			$('.LAAge').html(row.Age + '<br/>' + row2.Age);
			if (row.Sex.substring(0, 1) == 'M' && row2.Sex.substring(0, 1) == 'M'){
				$('.LASex').html(male + '<br/>' + male );
			}
			else if(row.Sex.substring(0, 1) == 'M' && row2.Sex.substring(0, 1) == 'F'){
				$('.LASex').html(male + '<br/>' + female );
			}
			else if(row.Sex.substring(0, 1) == 'F' && row2.Sex.substring(0, 1) == 'M'){
				$('.LASex').html(female + '<br/>' + male );
			}
			else if(row.Sex.substring(0, 1) == 'F' && row2.Sex.substring(0, 1) == 'F'){
				$('.LASex').html(female + '<br/>' + female );
			}
			else {
				if(row2.Sex.substring(0, 1) == 'F'){
					$('.LASex').html('' + '<br/>' + female );
				}
				else
				{
					$('.LASex').html('' + '<br/>' + male );
				}
			}
						
			if (row.Smoker == 'Y' && row2.Smoker == 'Y' ){
				$('.LASmoker').html(yes + '<br/>' + yes  );
			}
			else if (row.Smoker == 'Y' && row2.Smoker == 'N' ){
				$('.LASmoker').html(yes + '<br/>' + no  );
			}
			else if (row.Smoker == 'N' && row2.Smoker == 'Y' ){
				$('.LASmoker').html(no + '<br/>' + yes  );
			}
			else if (row.Smoker == 'N' && row2.Smoker == 'N' ){
				$('.LASmoker').html(no + '<br/>' + no  );
			}
			else{
				if(row2.Smoker == 'N'){
					$('.LASmoker').html('' + '<br/>' + no );
				}
				else
				{
					$('.LASmoker').html('' + '<br/>' + yes );
				}
			}
		}
	}
}

function showDashOrValue(type,value,calTotal)
{
    
    var lessThan = 0;
    var returnVal = null;
    if(type=="a")
    {
        lessThan = 300;
    }else
    if(type=="s")
    {
        lessThan = 200;
    }else
    if(type=="q")
    {
        lessThan = 150;
    }else
    if(type=="m")
    {
        lessThan = 50;
    }
    
    if(calTotal<lessThan)
    {
        returnVal = "-";
    }else
    {
        returnVal = value;
    }
    
    
    return returnVal;
        
}

function writeGST() {
	var htmlLang = "";
	if (gdata.SI[0].QuotationLang == "Malay") {
		htmlLang = "mly";
	} else {
		htmlLang = "eng";
	}
	$.ajax({
		url: "SI/gst/gst_"+htmlLang+"_Page1.html",
		async: false,
		dataType: 'html',
		success: function (data) {
			$("#gstPage").html(data);
		}
	});
}

function setPage() {
    
    var planName = gdata.SI[0].PlanName;
    var planCode = gdata.SI[0].PlanCode;
    var planDesc = null;
    var planDescRid = null;
    var star = null;
    
    if(planCode=="HLACP")
    {
        planDesc = "Participating Endowment Plan with Guaranteed Yearly Income and Limited 6 Years Premium Payment Term&nbsp;&nbsp;&nbsp;";
        planDescRid = "Participating Endowment Plan with Guaranteed Yearly Income and Limited 6 Years Premium Payment Term&nbsp;&nbsp;&nbsp;";
        star = "* This is the Guaranteed Yearly Income amount purchased.";
    }else if(planCode=="L100")
    {
        if (gdata.SI[0].QuotationLang == "Malay")
        {
            planDesc = "Pelan Sepanjang Hayat Tanpa Penyertaan<br/>(Pembayaran Premium untuk Sepanjang Tempoh Polisi)";
            planDescRid ="(Pembayaran Premium untuk Sepanjang Tempoh Polisi)";
            star = "";
        }else
        {
            planDesc = "Non-Participating Whole Life Plan<br/>(Premium Payable for Whole Policy Term)";
            planDescRid ="(Premium Payable for Whole Policy Term)";
            star = "";
        }
    }
    
    
    $('.star').html(planDesc);
    /*
    $('.TotPremPaide').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid1));
    $('.TotPremPaidAll').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid2));
    $('.guaranteedMaturityValue').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[0].col2));
    $('.basicSumAssured').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Details.data[0].col2));
//     $('.premiumPayments').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col3);
    
    $('.rptVersion').html('i-M Solutions Version 1.5 (Agency) - Last Updated 09 October 2014 - E&amp;OE-'); //set version info
    $('.dateModified').html(gdata.SI[0].DateModified);
    $('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.planName').html(planName);
    $('.planDesc').html(planDesc);
    $('.paymentDesc').html(planDescRid);
    $('.SICode').html(gdata.SI[0].SINo);
    $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages
    $('.planName').html(gdata.SI[0].PlanName);
    $('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);
    $('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
    $('.OCCPClass').html('(Class '+gdata.SI[0].OCCPClass+')');
    $('.PremiumPaymentOption').html(gdata.SI[0].Trad_Details.data[0].PremiumPaymentOption);
    
    if(gdata.SI[0].PlanCode=="HLAWP"){
        $('.HLAWPBasicTerm').html(gdata.SI[0].Trad_Details.data[0].PolicyTerm);
        if(parseInt(gdata.SI[0].Trad_Details.data[0].PolicyTerm) == 30){
                $('.HLAWP_Page30').html('150%');
            }
            else{
                $('.HLAWP_Page30').html('250%');
        }
    }
    */
    
    $('.BasicSA').html(CurrencyNoCents(gdata.SI[0].BasicSA));	
    $('.BasicPrem').html(CurrencyNoCents(gdata.SI[0].SI_Store_Premium.data[0].PremiumWithoutHLoading));
    $('.SICode').html(gdata.SI[0].SINo);
    $('.totalPages').html(gdata.SI[0].TotalPages); 
    $.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
    	$("#" + row.PageDesc + " .currentPage").html(row.PageNum);
    });
}

function validateAndAddSpace(str) {
	var tempstr = str;
	if (str.indexOf("-") == 0) {
		tempstr = "&nbsp;&nbsp;" + tempstr;
	}
	return tempstr;
}

function reformatTradDetailsData() {
	var newData = new Array();
	var temp;
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		if (row.col0_1.indexOf('-') < 0) {
			temp = new Object();
			temp.col0_1 = row.col0_1;
			temp.col0_2 = row.col0_2;
			temp.col1 = row.col1;
			temp.col2 = row.col2;
			temp.RiderCode = row.RiderCode;
			temp.col3 = row.col3;
			temp.col4 = row.col4;
			temp.col5 = row.col5;
			temp.col6 = row.col6;
			temp.col7 = row.col7;
			temp.col8 = row.col8;
			temp.col9 = row.col9;
			temp.col10 = row.col10;
			temp.col11 = row.col11;
			newData[newData.length] = temp;
		} else {
			if (row.col0_1.indexOf('-Annually') == 0) {
				temp.col5 = row.col5;
			} else if (row.col0_1.indexOf('-Semi-annually') == 0) {
				temp.col6 = row.col6;
			} else if (row.col0_1.indexOf('-Quarterly') == 0) {
				temp.col7 = row.col7;
			} else if (row.col0_1.indexOf('-Monthly') == 0) {
				temp.col8 = row.col8;
			}
		}
	});
	return newData;
}
	
function loadL100Page1_2()
{
	var result = gdata.SI[0].SI_Temp_trad_LA.data;
		
	var row;
	var rowCol1, rowCol2, rowCol3, rowCol4, rowCol5, rowCol6, rowCol7, rowCol8, rowCol9, rowCol10, rowCol11, rowCol12;
	var col5Total, col6Total, col7Total, col8Total;
	col5Total = 0.00;
	col6Total = 0.00;
	col7Total = 0.00;
	col8Total = 0.00;

	var showHLoading = false;
	var showOccLoading = false;

	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		if(parseInt(index) > 15){
			if(row.col9 == '' || row.col9 == '0.00' ){

			} else{
				showHLoading = true;
			}

			if(row.col10 == '' || row.col10 == '0.00'){

			} else{
				showOccLoading = true;
			}	  
		}

	});
  
	var col5Total1=0;
	var col6Total1=0;
	var col7Total1=0;
	var col8Total1=0;

	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		col5Total1 = parseFloat(col5Total1) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total1 = parseFloat(col6Total1) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total1 = parseFloat(col7Total1) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total1 = parseFloat(col8Total1) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
	});
			
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		i = 0;
		col5Total = parseFloat(col5Total) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total = parseFloat(col6Total) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total = parseFloat(col7Total) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total = parseFloat(col8Total) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
		 
		if(parseInt(index) > 13){            
			if(showHLoading == false){
				if(showOccLoading == false){
					document.getElementById('hLoading2').innerHTML = ('');
					document.getElementById('occLoading2').innerHTML = ('');
					document.getElementById('dynamic2').setAttribute('colspan', '6');
				
					if(result.length == 1){
						if(row.col0_1 == 'HLA Cash Promise'){
							$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
								'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + 
								replaceChar(row.col1) + '</td>' + '<td>' + formatCurrency(row.col2) + '*</td>'  +
								'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
								'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
								showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
								'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '</tr>');
						} else {
							$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
								'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + 
								replaceChar(row.col1) + '</td>' + '<td>' + formatCurrency(row.col2) + '</td>'  +
								'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
								'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
								showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
								'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '</tr>');
						}
					} else {
						if(row.col0_1 == 'HLA Cash Promise'){
							$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
								'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' +
								replaceChar(row.col1) + '</td>' + '<td>' + formatCurrency(row.col2) + ' *</td>'  +
								'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
								'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
								showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
								'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '</tr>');  
						} else{
							$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
								'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' +
								replaceChar(row.col1) + '</td>' + '<td>' + formatCurrency(row.col2) + '  </td>'  +
								'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
								'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' +
								showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
								'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td><td>&nbsp;</td>' + '</tr>');
						}
					}
				} else {
					document.getElementById('hLoading2').innerHTML = ('');
					document.getElementById('dynamic2').setAttribute('colspan', '6');
					if(result.length == 1){
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + 
							replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
							'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
							showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
							'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td></td>' + '<td>' + row.col10 + '</td>' + '</tr>');
					} else{
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' +
							replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
							'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' +
							showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
							'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td>&nbsp;</td>' + '<td>' + row.col10 + '</td>' + '</tr>');
					}
				}
			} else{
				var HL;
			
				if(parseInt(row.col9) > 0){
					if(row.col9 % 1 == 0){
						HL = parseInt(row.col9);
					} else {
						HL = row.col9;
					}
				} else {
					HL = "";
				}  
			
				if(showOccLoading == false){
					document.getElementById('occLoading2').innerHTML = ('');
					document.getElementById('dynamic2').setAttribute('colspan', '6');
					if(result.length == 1){
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' +
							replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
							'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
							showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
							'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td>' + HL + '</td>' + '</tr>');
					} else {
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' +
							replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
							'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' +
							showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
							'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td>' + HL + '</td>' + '</tr>');
					}
				} else {
					document.getElementById('dynamic2').setAttribute('colspan', '6');
					if(result.length == 1){ 
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 5px;">' +
							replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
										'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
										'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' +
										showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
										'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td>' + HL + '</td><td>' + row.col10 + '</td>' + '</tr>');
					} else{
						$('#table-dataPage2 > tbody').append('<tr>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + returnMalayOrEng(row.col0_1) + '</td>' +
							'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + replaceChar(row.col0_2) + '</td>' + '<td style="text-align:left;padding: 0px 0px 0px 0px;">' +
								replaceChar(row.col1) + '</td>' + '<td>' + isIncomeRider(formatCurrency(row.col2),row.col0_1) + '</td>'  +
								'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' + '<td><span id=row' + i + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
								'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + '<td id=row1col7>' + 
								showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
								'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + '<td>' + HL + '</td><td>' + row.col10 + '</td>' + '</tr>');
					}
				}
			}
		}
		i++;
	});
	
	if(showHLoading == false){	
		if(showOccLoading == false){
			$('#table-dataPage2 > tfoot').append('<tr><td colspan ="12"><hr/></td></tr><tr>' + '<td></td>' + '<td></td>' + '<td></td>'  + '<td></td>' +
				'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + returnMalayOrEng('Total Premium') + '</b></td>' +
				'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td><b>' + 
				showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
				'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + '<td><b>' +
				showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
				'</tr><tr><td colspan ="12"><hr/></td></tr>');                                
		} else {
			$('#table-dataPage2 > tfoot').append('</tr><tr><td colspan ="12"><hr/></td></tr><tr>' + '<td></td>' + '<td></td>' + '<td></td>'  + '<td></td>' +
				'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + returnMalayOrEng('Total Premium') + '</b></td>' +
				'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
				'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + '<td><b>' +
				showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
				'<td>&nbsp;</td>' + '</tr><tr><td colspan ="12"><hr/></td></tr>');
		}
	} else {
		if(showOccLoading == false){
			$('#table-dataPage2 > tfoot').append('</tr><tr><td colspan ="12"><hr/></td></tr><tr>' + '<td></td>' + '<td></td>' + '<td></td>'  + '<td></td>' +
				'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + returnMalayOrEng('Total Premium') + '</b></td>' +
				'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
				'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + '<td><b>' +
				showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
				'<td>&nbsp;</td>' + '</tr><tr><td colspan ="12"><hr/></td></tr>');    
		} else {
			$('#table-dataPage2 > tfoot').append('</tr><tr><td colspan ="12"><hr/></td></tr><tr>' + '<td></td>' + '<td></td>' + '<td></td>'  + '<td></td>' +
				'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + returnMalayOrEng('Total Premium') + '</b></td>' +
				'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + '<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
				'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + '<td><b>' +
				showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
				'<td>&nbsp;</td><td>&nbsp;</td>' + '</tr><tr><td colspan ="12"><hr/></td></tr>');    
		}
	}
}
  
function returnMalayOrEng(temp){
    
    if(gdata.SI[0].QuotationLang == "Malay"){
        if(temp == '-Annual'){
            return '-Tahunan';
        }
        else if(temp == '-Semi-annual'){
            return '-Setengah Tahun';
        }
        else if(temp == '-Quarterly'){
            return '-Suku Tahun';
        }
        else if(temp == '-Monthly'){
            return '-Bulanan';
        }
        else if(temp == 'Total Premium'){
            return 'Jumlah Bayaran Premium';
        }
        else
        {
            return temp;    
        }    
    }
    else{
            return temp;    
    }
}
  
function replaceChar(char){
	var temp, returnVal;
	if (char == "0")
		returnVal = "-"
	else if (char == "")
		returnVal = "-"
	else
		returnVal = char;
	return returnVal;
}

function isIncomeRider(amt,rider){	
	var temp;
	temp = $.trim(rider);

	if (temp == "HLA Wealth Plan" || temp == "Income 20 Rider" || temp == "Income 30 Rider" || temp == "Income 40 Rider" ||
		temp == "Income D-20 Rider" || temp == "Income D-30 Rider" || temp == "Income D-40 Rider" ||
		temp == "Income E-20 Rider" || temp == "Income E-30 Rider"){

		return amt + " *";
	}
	else
		return amt + "&nbsp;&nbsp;";
}

function writeSummary()
{
	writeSummary1_HLCP();
	
	//writeSummary2_HLCP();
}


function ReturnYESNO_ByLang(input){
     if(gdata.SI[0].QuotationLang == "Malay"){
        if(input == 'Yes'){
            return 'Ya';
        }
        else if(input == 'No'){
            return 'Tidak';
        }
        else if(input == 'per year upon CI/TPD'){
            return 'setahun ketika CI/TPD';
        }
        else if(input == 'per year upon TPD'){
            return 'setahun ketika TPD';
        }
        else if(input == 'Hospitalisation Income'){
            return 'Pendapatan Hospital';
        }
        else if(input == 'Medical Plan'){
            return 'Pelan Perubatan';
        }
        else{
            return '';
        }
     }
     else{
        return input;
     }
}

function needItalic(ridername){
		
		var temp;
		temp = $.trim(ridername)
		
        if (ridername.indexOf('i6') != -1){
        	return "Wealth Booster-<i>i6</i> Rider (30 year term)";
        }
	else if (ridername.indexOf('d10') != -1){
        	return "Wealth Booster-<i>d10</i> Rider (30 year term)";
        }
        else
        	return ridername
}

function loadBenefitPage() {
    
    var WaiverRider = [];
    
    if(gdata.SI[0].SI_Temp_Trad_Details.data.length > 1){
        if(gdata.SI[0].QuotationLang == "Malay"){
            $('.Benefit1Title').html('Ringkasan Faedah bagi Pelan Asas dan Rider dilampirkan');
        }
        else
        {
            $('.Benefit1Title').html('Summary of Benefits for Basic Plan and attached Riders');    
        }        
    }
    else
    {
        $('.Benefit1Title').html('Summary of Benefits for Basic Plan'); 
    }
    
    var tempPage;
    var title;
    
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {       
		if(row.RiderCode == 'WB30R' || row.RiderCode == 'WB50R' ){
			AddRow = parseInt(AddRow) + 6;
			WBRider = true;
			if(row.RiderCode == 'WB30R'){
				WB30Rider = true;
            }
        }
        else if(row.RiderCode == 'WBI6R30'){
            AddRow = parseInt(AddRow) + 6;
		    WBi6 = true;
        }
        else if(row.RiderCode == 'WBD10R30' ){
            AddRow = parseInt(AddRow) + 6;
		    WBd10 = true;
        }
        else if(row.RiderCode == 'EDUWR'){
            AddRow = parseInt(AddRow) + 6;
	    	EduWB = true;
        }
        else if (row.RiderCode == 'TPDYLA') {
            AddRow = parseInt(AddRow) + 3;
        }
        else if (row.RiderCode == 'ICR' || row.RiderCode == 'CCTR' || row.RiderCode == 'HMM' || row.RiderCode == 'CPA' ||
        	row.RiderCode == 'WP30R'|| row.RiderCode == "WP50R" || row.RiderCode == 'WPTPD30R'|| row.RiderCode == "WPTPD50R" ) {
            AddRow = parseInt(AddRow) + 2;
        } 
        else if (row.col0_1.indexOf("-") == -1 && 
        	((row.RiderCode == 'CIWP') || (row.RiderCode == 'PR') || (row.RiderCode == 'SP_PRE') || (row.RiderCode == 'SP_STD') || (row.RiderCode == 'LCWP'))) {
            AddRow = parseInt(AddRow) + 4;
        }
        else {
            AddRow = parseInt(AddRow) + 1;
        }
        if(parseInt(AddRow) < benefitPage1Limit){
            tempPage  = 'table-Benefit1';
        }
        else if(parseInt(AddRow) < benefitPage2Limit){
            tempPage  = 'table-Benefit2';
        }
        else
        {
            tempPage  = 'table-Benefit3';
        }
        
		if (row.col0_1.indexOf("-") == 0) {
			title = "&nbsp;&nbsp;"+row.col0_1;
		} else {
			title = row.col0_1;
		}
        
        if(row.RiderCode == 'EDUWR'|| row.RiderCode == "WB30R" || row.RiderCode == "WBI6R30" || row.RiderCode == "WBD10R30" || row.RiderCode == "WB50R"){
            
            var tempGYCC;
            
            if(row.RiderCode == 'EDUWR'){
                tempGYCC = formatCurrency( row.col2) + "<sup><span class='fnPage2_EDU' style='font-size: 5px;vertical-align: super'></sup></span>"
            }
            else{
                tempGYCC = formatCurrency( row.col2) + "<sup><span class='fnPage2_GYCC' style='font-size: 5px;vertical-align: super'></sup></span>"    
            }
            
       		var WPRider;
			if(gdata.SI[0].QuotationLang == "Malay"){
				WPRider = "100% jumlah premium yang  dibayar untuk Rider ini<sup><span class='fnPage2_PremiumPaid' style='font-size: 5px;vertical-align: super'></sup></span>";
			}
			else
			{
				WPRider = "100% of total premium paid for this Rider<sup><span class='fnPage2_PremiumPaid' style='font-size: 5px;vertical-align: super'></sup></span>";    
			}
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + needItalic(title) + '</td><td colspan="1" > ' + '-' +
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + WPRider + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + tempGYCC + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') +
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + '</td></tr>');
        }
        else if(row.RiderCode == 'HLAWP' ){
            var temp;
            if(parseInt(row.col3) == 30){
                if(gdata.SI[0].QuotationLang == "Malay"){
                    temp = '150%<br/>jumlah premium Pelan Asas dibayar<sup><span class="fnPage2_PremiumPaid" style="font-size: 5px;vertical-align: super"></span></sup>';
                }
                else
                {
                    temp = '150%<br/>of total Basic premium Paid<sup><span class="fnPage2_PremiumPaid" style="font-size: 5px;vertical-align: super"></span></sup>';    
                }                
            }
            else{
                if(gdata.SI[0].QuotationLang == "Malay"){
                    temp = '250%<br/>jumlah premium Pelan Asas dibayar<sup><span class="fnPage2_PremiumPaid" style="font-size: 5px;vertical-align: super"></span></sup>';    
                }
                else
                {
                    temp = '250%<br/>of total Basic premium Paid<sup><span class="fnPage2_PremiumPaid" style="font-size: 5px;vertical-align: super"></span></sup>';
                }                
            }
            
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' +
            	' </td><td colspan="1" >' +  '-' + '</td><td colspan="1">' + temp + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + temp + '</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' +
            	ReturnYESNO_ByLang('Yes') + '</td></tr>');
        } else if (row.RiderCode == 'S100' ) {        
//             $('.fnPage2_PremiumPaid').html("aaa");
           document.getElementById('fnPage2_PremiumPaid').style.display= "none";
           
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' +
            	' </td><td colspan="1" >' +  '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + 
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'WP30R'|| row.RiderCode == "WP50R" ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' +
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' +
            	ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'WPTPD30R'|| row.RiderCode == "WPTPD50R" ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' +  title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'ACIR' || row.RiderCode == 'ACIR_MPP' || row.RiderCode == "CIR" ){
            var temp;
            if(row.RiderCode == 'ACIR' || row.RiderCode == 'ACIR_MPP'){
                temp = formatCurrency(row.col2) + "<sup><span class='fnPage2_ACIR' style='font-size: 5px;vertical-align: top;'></span></sup>";
            }
            else{
                temp = formatCurrency(row.col2);    
            }
            
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + temp + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + 
            	ReturnYESNO_ByLang('No') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'LCPR'){
            var temp;
            
            temp = formatCurrency(row.col2) + "<sup><span class='fnPage2_LCPR' style='font-size: 5px'></span></sup>";    
            
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + formatCurrency(row.col2)  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + 
            	'<sup><span class="fnPage2_LCPR" style="font-size: 5px;vertical-align: top"></span></sup></td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + 
            	ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == "PLCP" ){
            var temp;
            
            temp = formatCurrency(row.col2) + "<sup><span class='fnPage2_PLCP' style='font-size: 5px;vertical-align: top'></span></sup>";    
            
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + formatCurrency(row.col2)  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + 
            	'<sup><span class="fnPage2_PLCP" style="font-size: 5px;vertical-align: top"></span></sup></td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + 
            	ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'CCTR'|| row.RiderCode == "PTR" ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + formatCurrency(row.col2)  + '</td><td colspan="1">' + '-' +
				'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
				'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
				'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
				'</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'HMM'|| row.RiderCode == "MG_IV" || row.RiderCode == 'MG_II' ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + (row.col0_2) + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('Medical Plan') +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') +
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'HSP_II' ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + (row.col0_2) + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('Medical Plan') +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + 
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'HB' ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title +
            	'</td><td colspan="1" > ' + '-' + ' </td><td colspan="1" >' +  row.col1 + '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('Hospitalisation Income') +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') +
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'C+' ){
        	mBenefit = '-';
        	if (row.col0_2 == "Option 3" || row.col0_2 == "Option 4") {
        		mBenefit = formatCurrency( row.col2)+"<sup><span class='fnPage2_GCP' style='font-size: 5px;vertical-align: top'></sup></span>";
        	}
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + row.col0_2 + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + mBenefit + '</td><td colspan="1">' + ReturnYESNO_ByLang('Yes') + 
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'CPA'|| row.RiderCode == "PA" ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + formatCurrency(row.col2) + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + 
            	'</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'ICR' ){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + 
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + '<br/>' + ReturnYESNO_ByLang('per year upon CI/TPD') +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td><td colspan="1">' +
            	ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == "TPDYLA"){
            $('#' + tempPage + ' > tbody').append(
            	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + title + '</td><td colspan="1" > ' + '-' + 
            	' </td><td colspan="1" >' +  '-' +  '</td><td colspan="1">' + '-'  + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + formatCurrency(row.col2) + '<br/>' + ReturnYESNO_ByLang('per year upon TPD') +
            	'</td><td colspan="1">' + '-' + '</td><td colspan="1">' + '-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td><td colspan="1">' +
            	ReturnYESNO_ByLang('No') + '</td></tr>');
        }
        else if(row.RiderCode == 'CIWP' || row.col11 == 'CIWP'  || row.RiderCode == 'PR' || row.col11 == 'PR'|| row.RiderCode == 'LCWP' || row.col11 == 'LCWP' || 
        	row.RiderCode == 'SP_PRE' || row.col11 == 'SP_PRE' || row.RiderCode == 'SP_STD' || row.col11 == 'SP_STD'  ){
            WaiverRider.push(row);
        }         
    });
        
    if(WaiverRider.length > 0){
        var Annual;
        var Semi;
        var Quarterly;
        var Monthly;
        
        var payOptStr;
        if(gdata.SI[0].QuotationLang == "Malay"){
        	payOptStr = '<br/>&nbsp;&nbsp;- Tahunan<br/>&nbsp;&nbsp;- Setengah Tahun<br/>&nbsp;&nbsp;- Suku Tahun<br/>&nbsp;&nbsp;- Bulanan';
        } else {
        	payOptStr = '<br/>&nbsp;&nbsp;- Annually<br/>&nbsp;&nbsp;- Semi-annually<br/>&nbsp;&nbsp;- Quarterly<br/>&nbsp;&nbsp;- Monthly';
        }
        $('#' + tempPage + '> tbody').append('<tr><td colspan="16" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" ><b>Waiver of Premium Riders</b></td>' + '</tr>');
        
        for (var x = 0; x < WaiverRider.length; x = x + 5){
            
            if(WaiverRider[x].RiderCode == 'CIWP'  ){
                Annual = formatCurrency(WaiverRider[x + 1].col2);
                Semi = formatCurrency(WaiverRider[x + 2].col2) ;
                Quarterly = formatCurrency(WaiverRider[x + 3].col2);
                Monthly = formatCurrency(WaiverRider[x + 4].col2); 
                $('#' + tempPage + '> tbody').append(
                	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 0px 2px; width: 12%;vertical-align: top" >' + WaiverRider[x].col0_1 + 
                	payOptStr + '</td><td colspan="1" > ' +
                	'<br/><br/>-<br/>-<br/>-<br/>-' + ' </td><td colspan="1" >' +  '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-'  + 
                	'</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + 
                	'</td><td colspan="1"><br/><br/>' + Annual + '<br/>' + Semi + '<br/>' + Quarterly + '<br/>' + Monthly +
                	'</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' +
                	'<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-'  + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + 
                	'</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1"><br/>' + ReturnYESNO_ByLang('No') + '</td><td colspan="1"><br/>' +
                	ReturnYESNO_ByLang('No') + '</td></tr>');
            }
            else if(WaiverRider[x].RiderCode == 'SP_STD' ||  WaiverRider[x].RiderCode == 'PR'   ){
                Annual = formatCurrency(WaiverRider[x + 1].col2);
                Semi = formatCurrency(WaiverRider[x + 2].col2) ;
                Quarterly = formatCurrency(WaiverRider[x + 3].col2);
                Monthly = formatCurrency(WaiverRider[x + 4].col2);        
                 
                $('#' + tempPage + '> tbody').append(
                	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + WaiverRider[x].col0_1 + 
                	payOptStr + '</td><td colspan="1" > ' +
                	'<br/>-<br/>-<br/>-<br/>-' + ' </td><td colspan="1" >' +  '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ''  + '<br/>' +
                	Annual + '<br/>' + Semi + '<br/>' + Quarterly + '<br/>' + Monthly  + '</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' +
                	'<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ''  + '<br/>-' + '<br/>-' + '<br/>-' + '<br/>-' +
                	'</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + 
                	'<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-'  + '</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + 
                	'</td><td colspan="1">' + '<br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td><td colspan="1">' +
                	ReturnYESNO_ByLang('No') + '</td></tr>');
                
            }
            else if(WaiverRider[x].RiderCode == 'LCWP' ||  WaiverRider[x].RiderCode == 'SP_PRE' ){
                Annual = formatCurrency(WaiverRider[x + 1].col2);
                Semi = formatCurrency(WaiverRider[x + 2].col2) ;
                Quarterly = formatCurrency(WaiverRider[x + 3].col2);
                Monthly = formatCurrency(WaiverRider[x + 4].col2);        
                 
                $('#' + tempPage + '> tbody').append(
                	'<tr><td colspan="1" style="text-align:left;padding: 2px 2px 2px 2px; width: 12%;vertical-align: top" >' + WaiverRider[x].col0_1 +
                	payOptStr + '</td><td colspan="1" > ' +
                	'<br/><br/>-<br/>-<br/>-<br/>-' + ' </td><td colspan="1" >' +  '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ''  + '<br/><br/>' +
                	Annual + '<br/>' + Semi + '<br/>' + Quarterly + '<br/>' + Monthly  + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' +
                	'<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ''  + '<br/><br/>' +
                	Annual + '<br/>' + Semi + '<br/>' + Quarterly + '<br/>' + Monthly +
                	'</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' +
                	'<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-'  + '</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + 
                	'</td><td colspan="1">' + '<br/><br/>-<br/>-<br/>-<br/>-' + '</td><td colspan="1">' + ReturnYESNO_ByLang('No') + '</td><td colspan="1">' +
                	ReturnYESNO_ByLang('No') + '</td></tr>');                
            }
        }
    }    
}

function returnMalayWord(temp){
    
    if(temp == '-Annually'){
        return '-Tahunan';
    }
    else if(temp == '-Semi-annually'){
        return '-Setengah Tahunan';
    }
    else if(temp == '-Quarterly'){
        return '-Suku Tahunan';
    }
    else if(temp == '-Monthly'){
        return '-Bulanan';
    }
    else
    {
        return temp;    
    }    
}

function writeWP_GYIRiders()
{
    if(gdata.SI[0].PlanCode=="HLAWP")
    {
        $.each(gdata.SI[0].SI_Temp_Trad_Riderillus.riders, function(index, gaga) {
               
            $.each(gaga.data, function(index, row) {
                  
                    if(row.DataType == 'WB30R' || row.DataType == 'WB50R' ){
                        WBRider = true;
                        
                        if(row.DataType == 'WB30R'){
                            WB30Rider = true;
                        }
                    }
                    else if(row.DataType == 'WBI6R30'){
                        WBi6 = true;
                    }
                    else if(row.DataType == 'WBD10R30' ){
                        WBd10 = true;
                    }
                    else if(row.DataType == 'EDUWR'){
                        EduWB = true;
                    }
                  
                    var temp = row.RiderDesc.toString().indexOf('(');
                  
                    if(temp == -1){
                        temp = row.RiderDesc.toString().length;
                    }
                  
                      if(gdata.SI[0].QuotationLang == "Malay"){
                        
                        if(row.DataType == 'WBI6R30'){
                            $('.illustrationOf_'+row.DataType).html('Illustrasi Wealth Booster-<i>i6</i> Rider' );
                        }
                        else if(row.DataType == 'WBD10R30'){
                            $('.illustrationOf_'+row.DataType).html('Illustrasi Wealth Booster-<i>d10</i> Rider ');
                        }
                        else{
                            $('.illustrationOf_'+row.DataType).html('Illustrasi ' + row.RiderDesc.substring(0, parseInt(temp) ));    
                        }
                        
                        
                      }
                      else{
                        if(row.DataType == 'WBI6R30'){
                            $('.illustrationOf_'+row.DataType).html('Illustrasi of Wealth Booster-<i>i6</i> Rider' );
                        }
                        else if(row.DataType == 'WBD10R30'){
                            $('.illustrationOf_'+row.DataType).html('Illustrasi of Wealth Booster-<i>d10</i> Rider ');
                        }
                        else{
                            $('.illustrationOf_'+row.DataType).html('Illustration of ' + row.RiderDesc.substring(0, parseInt(temp) ));    
                        }
                        
                      }
                      
                    $('#table-SummaryGYI_Riders1_'+row.DataType+' > tbody').append('<tr><td colspan="1" >' +
                                                                                     row.col0_1 + '</td><td colspan="1" >' +
                                                                                     row.col0_2 + '</td><td colspan="1" >' +
                                                                                     formatCurrency(row.col1) + '</td><td colspan="1">' +
                                                                                     formatCurrency(row.col2) + '</td><td colspan="1">' +
                                                                                     formatCurrency(row.col3) + '</td><td colspan="1">' +
                                                                                     formatCurrency(row.col4) + '</td><td colspan="1">' +
                                                                                     formatCurrency(row.col5) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col6) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col7) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col8) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col9) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col10) + '</td><td colspan="1">' +
                                                                                     CurrencyNoCents(row.col11) + '</td></tr>');
                      
                    if (colType == 1) { // CD: ACC, GYI : Payout
                        $('#table-SummaryGYI_Riders2_'+row.DataType+' > tbody').append('<tr><td>' +
                                                                                     row.col0_1 + '</td><td>' +
                                                                                     row.col0_2 + '</td><td>' +
                                                                                     CurrencyNoCents(row.col12) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col13) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col14) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col15) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col18) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col19) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col20) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col21) + '</td></tr>');
                        
                    }
                    else if (colType == 2) { // CD: ACC, GYI : ACC
                         $('#table-SummaryGYI_Riders2_'+row.DataType+' > tbody').append('<tr><td>' +
                                                                                     row.col0_1 + '</td><td>' +
                                                                                     row.col0_2 + '</td><td>' +
                                                                                     CurrencyNoCents(row.col12) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col13) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col14) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col15) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col16) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col17) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col18) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col19) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col20) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col21) + '</td></tr>');
                    }
                    else if (colType == 3) { // CD: Payout, GYI : Payout
                         $('#table-SummaryGYI_Riders2_'+row.DataType+' > tbody').append('<tr><td>' +
                                                                                     row.col0_1 + '</td><td>' +
                                                                                     row.col0_2 + '</td><td>' +
                                                                                     CurrencyNoCents(row.col12) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col13) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col18) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col19) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col20) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col21) + '</td></tr>');
                    }
                    else if (colType == 4) {  // CD: Payout, GYI : ACC
                         $('#table-SummaryGYI_Riders2_'+row.DataType+' > tbody').append('<tr><td>' +
                                                                                     row.col0_1 + '</td><td>' +
                                                                                     row.col0_2 + '</td><td>' +
                                                                                     CurrencyNoCents(row.col12) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col13) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col16) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col17) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col18) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col19) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col20) + '</td><td>' +
                                                                                     CurrencyNoCents(row.col21) + '</td></tr>');
                    }                      
                }                  
            );               
        });
    }
}

function writeSummary1_HLCP() {
    
    if(gdata.SI[0].PlanCode=="HLACP")
    {
        $.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
        	$('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col1) + '</td><td>' +
        	formatCurrency(row.col2) + '</td><td>' + formatCurrency(row.col22) + '</td><td>' + formatCurrency(row.col23) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + 
        	CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) + '</td><td>' +
        	CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + formatCurrency(row.col11) + '</td></tr>');
        });
    } else if(gdata.SI[0].PlanCode=="L100") {
       	if(gdata.SI[0].SI_Temp_Trad_Basic.data.length <= 30){
           $('#table-Summary1_2 > thead').hide();
           document.getElementById('FootnoteForPage2_2').style.display= "none";
       	}
		var number;       
       	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
       		if(index < 30) {
       			number = row.col2;
       			row.col2 = number | 0;       			
				$('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td></tr>');
       		} else {
				number = row.col2;
				row.col2 = number | 0;
				$('#table-Summary1_2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td></tr>'); 
            }            
        });
    } else if (gdata.SI[0].PlanCode=="S100") {
       	if(gdata.SI[0].SI_Temp_Trad_Basic.data.length <= 30){
           $('#table-Summary1_2 > thead').hide();
           document.getElementById('FootnoteForPage2_2').style.display= "none";
       	}
		var number;       
       	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
       		if(index < 30) {
       			number = row.col2;
       			row.col2 = number | 0;       			
				$('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td></tr>');
       		} else {
				number = row.col2;
				row.col2 = number | 0;
				$('#table-Summary1_2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td></tr>'); 
            }            
        });
    } else if(gdata.SI[0].PlanCode=="HLAWP")
    {
    	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {    	
    		$('#table-Summary1 > tbody').append('<tr><td colspan="2" >' + row.col0_1 + '</td><td colspan="2" >' + row.col0_2 + '</td><td colspan="2" >' +
    		formatCurrency(row.col1) + '</td><td colspan="2">' + CurrencyNoCents(row.col2) + '</td><td colspan="2">' + CurrencyNoCents(row.col3) + '</td><td colspan="2">' +
    		CurrencyNoCents(row.col4) + '</td><td colspan="2">' +                                            
    		CurrencyNoCents(row.col5) + '</td><td colspan="2">' + CurrencyNoCents(row.col6) + '</td><td colspan="2">' +
    		CurrencyNoCents(row.col7) + '</td><td colspan="2">' + formatCurrency(row.col11) + '</td></tr>');
    	});
    }
	else if(gdata.SI[0].PlanCode=="BCALH") {
       	
		var number;       
       	$.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
       		if(index < 30) {
       			number = row.col2;
       			row.col2 = number | 0;       			
				$('#table-Summary1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' +
				CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) + '</td></tr>');
       		} else {
				number = row.col2;
				row.col2 = number | 0;
				$('#table-Summary1_2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' +
				CurrencyNoCents(row.col2) + '</td><td>' + CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td></tr>'); 
            }            
        });
    }
    
      
}

function writeSummary2_HLCP() {
    
    var input1;
    
    if(EduWB == true && (WBRider == true || WB30Rider == true || WBi6 == true || WBd10 == true)){
        if (gdata.SI[0].QuotationLang == "Malay"){
            input1 = "Kupon Tunai Tahunan & Bayaran Tunai Terkumpul";    
        }
        else
        {
            input1 = "Yearly Cash Coupons & Cash Payments";    
        }
    }
    else if(EduWB == false && (WBRider == true || WB30Rider == true || WBi6 == true || WBd10 == true)){
        if (gdata.SI[0].QuotationLang == "Malay"){
            input1 = "Kupon Tunai Tahunan Terkumpul";
        }
        else
        {
            input1 = "Yearly Cash coupons";
        }
    }
    else if(EduWB == true && WBRider == false && WB30Rider == false && WBi6 == false && WBd10 == false){
        if (gdata.SI[0].QuotationLang == "Malay"){
            input1 = "Bayaran Tunai Tahunan Terkumpul";
        }
        else{
            input1 = "Cash Payments";    
        }
        
    }
    else
    {
        input1 = "";
    }
    
    if (parseInt(gdata.SI[0].Trad_Details.data[0].AdvanceYearlyIncome) == 0) { //Cash promise. Only 1 title
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            if(gdata.SI[0].PlanCode=="HLACP")
            {
                $('.advanceYearlyIncome').html('Ilustrasi Pelan HLA Cash Promise');
            }else
            if(gdata.SI[0].PlanCode=="L100" || gdata.SI[0].PlanCode=="S100")
            {
                $('.advanceYearlyIncome').html('Illustrasi Pelan Asas');  
            }else
            if(gdata.SI[0].PlanCode=="HLAWP")
            {
                $('.advanceYearlyIncome').html('Illustrasi HLA Wealth Plan');  
            }
        } else //English
        {
            if(gdata.SI[0].PlanCode=="HLACP")
            {
                $('.advanceYearlyIncome').html('Illustration of HLA Cash Promise Plan');
            }else
            if(gdata.SI[0].PlanCode=="L100" || gdata.SI[0].PlanCode=="S100")
            {
                $('.advanceYearlyIncome').html('Illustration of Basic Plan');
            }else
            if(gdata.SI[0].PlanCode=="HLAWP")
            {
                $('.advanceYearlyIncome').html('Illustration of HLA Wealth Plan');
            }
        }
    }
    
    if(gdata.SI[0].PlanCode=="HLAWP"){
        if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC')
        {
            
            if (gdata.SI[0].QuotationLang == "Malay") 
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)<br/>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD);
                $('#table-Summary2 #col1').html('Dividen Tunai Terkumpul<br/>(10)');
            } else //English
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD);
                $('#table-Summary2 #col1').html('Accumulated Cash Dividend<br/>('+(10-minusOneForWP)+')');
            }
            
            if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF") { // CD: ACC, GYI : Payout
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    $('#table-Summary2 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col2').hide();
                    $('#table-SummaryGYI_Riders2_WB30R #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WB30R #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col2').hide();
                    $('#table-SummaryGYI_Riders2_WB50R #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WB50R #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').hide();
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').hide();
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').hide();
                    $('#table-SummaryGYI_Riders2_EDUWR #col2A').hide();
                    $('#table-SummaryGYI_Riders2_EDUWR #col2B').hide();
                    
                    $('#table-SummaryHLAWP3 #col1').html('Jumlah Dividen Tunai Terkumpul<br/>(Akhir Tahun)<br/>(8)');
                    $('#table-SummaryHLAWP3 #col3').html('Jumlah Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(9)');
                    $('#table-SummaryHLAWP3 #col4').html('Jumlah Dividen Terminal Istimewa Dibayar atas Kematian/ TPD<br/>(10)');
                    
                    $('#table-SummaryHLAWP3 #col2').hide();
                    $('#table-SummaryHLAWP3 #col2A').hide();
                    $('#table-SummaryHLAWP3 #col2B').hide();
                } else //English
                {
                    $('#table-Summary2 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col2').hide();
                    $('#table-SummaryGYI_Riders2_WB30R #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WB30R #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col2').hide();
                    $('#table-SummaryGYI_Riders2_WB50R #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WB50R #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').hide();
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').hide();
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2A').hide();
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2B').hide();
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').hide();
                    $('#table-SummaryGYI_Riders2_EDUWR #col2A').hide();
                    $('#table-SummaryGYI_Riders2_EDUWR #col2B').hide();
                    
                    $('#table-SummaryHLAWP3 #col1').html('Total Accumulated Cash Dividends <br/>(End of Year)<br/>(8)');
                    $('#table-SummaryHLAWP3 #col3').html('Total Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryHLAWP3 #col4').html('Total Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryHLAWP3 #col2').hide();
                    $('#table-SummaryHLAWP3 #col2A').hide();
                    $('#table-SummaryHLAWP3 #col2B').hide();                    
                }
                colType = 1;
            }
            else {// CD: ACC, GYI : ACC                
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    $('#table-Summary2 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col1').html('Dividen Tunai Terkumpul <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').html('Bayaran Tunai Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(10)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
                    
                    $('#table-SummaryHLAWP3 #col1').html('Jumlah Dividen Tunai Terkumpul<br/>(Akhir Tahun) <br/>(8)');
                    $('#table-SummaryHLAWP3 #col2').html('Jumlah ' + input1 + ' (Terkumpul daripada (2B) dengan Faedah)<br/>(Akhir Tahun) <span class="fnPageWB30R_AYCC" style="font-size: 7px;vertical-align: super"></span> <br/>(9)');    
                    $('#table-SummaryHLAWP3 #col3').html('Jumlah Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(10)');
                    $('#table-SummaryHLAWP3 #col4').html('Jumlah Dividen Terminal Istimewa Dibayar atas Kematian/ TPD<br/>(11)');
                    
                } else //English
                {
                    $('#table-Summary2 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest)  <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest)  <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest)  <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest)  <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col1').html('Accumulated Cash Dividends <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').html('Accumulated<br/>Cash Payments (Cumulative of (2B) With Interest)  <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                    
                    $('#table-SummaryHLAWP3 #col1').html('Total Accumulated Cash Dividends<br/>(End of Year)<br/>(8)');
                    $('#table-SummaryHLAWP3 #col2').html('Total Accumulated<br/>' + input1 + '<br/>(Cumulative of (2B) With Interest)<span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span><br/>(End of Year)<br/>(9)');
                    $('#table-SummaryHLAWP3 #col3').html('Total Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                    $('#table-SummaryHLAWP3 #col4').html('Total Special Terminal Dividend Payable on Death/TPD<br/>(11)');                   
                    
                }
            
                $('.ShowGYI').show();
                colType = 2;
            }
        }
        else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') 
        {
            if (gdata.SI[0].QuotationLang == "Malay") 
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)<br/>');
            } else //English
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)<br/>');
            }
            
            if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF") { // CD: Payout, GYI : Payout
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(8)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(9)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Dividen Terminal Dibayar atas Kematian/ TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Dividen Terminal Dibayar atas Kematian/ TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Dividen Terminal Dibayar atas Kematian/ TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Dividen Terminal Dibayar atas Kematian/ TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Dividen Terminal Dibayar atas Kematian/ TPD<br/>(9)');
                    
                    
                    $('#table-SummaryHLAWP3 #col3').html('Jumlah Dividen Terminal Dibayar atas Penyerahan/ Matang <br/>(8)');
                    $('#table-SummaryHLAWP3 #col4').html('Jumlah Dividen Terminal Istimewa Dibayar atas Kematian/ TPD<br/>(9)');
                } else //English
                {                    
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    
                    $('#table-SummaryHLAWP3 #col3').html('Total Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-SummaryHLAWP3 #col4').html('Total Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                }                    
                
                $('#table-SummaryGYI_Riders2_WB30R #col1').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col1A').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col1B').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col2').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col2A').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col2B').hide();
                
                $('#table-SummaryGYI_Riders2_WB50R #col1').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col1A').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col1B').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col2').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col2A').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col2B').hide();
                
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1A').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1B').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col2').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col2A').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col2B').hide();
                
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1A').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1B').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col2').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col2A').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col2B').hide();
                
                $('#table-SummaryGYI_Riders2_EDUWR #col1').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col1A').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col1B').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col2').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col2A').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col2B').hide();
                
                $('#table-SummaryHLAWP3 #col1').hide();
                    $('#table-SummaryHLAWP3 #col1A').hide();
                    $('#table-SummaryHLAWP3 #col1B').hide();
                $('#table-SummaryHLAWP3 #col2').hide();
                    $('#table-SummaryHLAWP3 #col2A').hide();
                    $('#table-SummaryHLAWP3 #col2B').hide();
                
                $('#table-Summary2 #col1').hide();
                $('#table-Summary2 #col1A').hide();
                $('#table-Summary2 #col1B').hide();
                
                colType = 3;
            } else { // CD: Payout, GYI : ACC
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(8)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(9)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah)<span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah)<span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').html('Kupon Tunai Tahunan Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').html('Bayaran Tunai Terkumpul (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                
                    $('#table-SummaryHLAWP3 #col2').html('Jumlah ' + input1 + ' (Terkumpul daripada (2B) dengan Faedah) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span><br/>(Akhir Tahun)<br/>(8)');
                    $('#table-SummaryHLAWP3 #col3').html('Jumlah Dividen Terminal Dibayar atas Penyerahan/ Matang<br/>(9)');
                    $('#table-SummaryHLAWP3 #col4').html('Jumlah Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(10)');
                
                } else //English
                {                    
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(8)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/>(9)');
                    
                    $('#table-SummaryGYI_Riders2_WB30R #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB30R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB30R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WB50R #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WB50R #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WB50R #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBI6R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col2').html('Accumulated<br/>Yearly Cash coupons (Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_WBD10R30 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                    
                    $('#table-SummaryGYI_Riders2_EDUWR #col2').html('Accumulated<br/>Cash Payments (Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(8)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryGYI_Riders2_EDUWR #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                
                    $('#table-SummaryHLAWP3 #col2').html('Total Accumulated ' + input1 + '<br/>(Cumulative of (2B) With Interest) <span class="fnPageWB30R_AYCC" style="font-size: 5px;vertical-align: super"></span> <br/>(End of Year)<br/>(8)');
                    $('#table-SummaryHLAWP3 #col3').html('Total Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                    $('#table-SummaryHLAWP3 #col4').html('Total Special Terminal Dividend Payable on Death/TPD<br/>(10)');
                }
                
                $('#table-SummaryGYI_Riders2_WB30R #col1').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col1A').hide();
                $('#table-SummaryGYI_Riders2_WB30R #col1B').hide();
                
                $('#table-SummaryGYI_Riders2_WB50R #col1').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col1A').hide();
                $('#table-SummaryGYI_Riders2_WB50R #col1B').hide();
                
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1A').hide();
                $('#table-SummaryGYI_Riders2_WBI6R30 #col1B').hide();
                
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1A').hide();
                $('#table-SummaryGYI_Riders2_WBD10R30 #col1B').hide();
                
                $('#table-SummaryGYI_Riders2_EDUWR #col1').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col1A').hide();
                $('#table-SummaryGYI_Riders2_EDUWR #col1B').hide();
                
                $('#table-SummaryHLAWP3 #col1').hide();
                $('#table-SummaryHLAWP3 #col1A').hide();
                $('#table-SummaryHLAWP3 #col1B').hide();
                
                $('#table-Summary2 #col1').hide();
                $('#table-Summary2 #col1A').hide();
                $('#table-Summary2 #col1B').hide();
                
                $('.ShowGYI').show();
                colType = 4;
            }
        }
    }
    else // other product
    {
        if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') //payment description
        {
            var minusOneForWP = 0;
            
            if(gdata.SI[0].PlanCode=="HLAWP")
            {
                minusOneForWP = 1;
            }else
            {
                minusOneForWP = 0;
            }
            
            if (gdata.SI[0].QuotationLang == "Malay") 
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)<br/>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD);
                $('#table-Summary2 #col1').html('Dividen Tunai Terkumpul<br/>(10)');
            } else //English
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>' + gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD);
                $('#table-Summary2 #col1').html('Accumulated Cash Dividend<br/>('+(10-minusOneForWP)+')');
            }
            
            if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF") {
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)');
                } else //English
                {
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/>(12)');
                }
                $('#table-Summary2 #col4').html('-');
                $('#table-Summary2 #col4A').html('-');
                $('#table-Summary2 #col4B').html('-');
                $('#table-Summary2 #col4').hide();
                $('#table-Summary2 #col4A').hide();
                $('#table-Summary2 #col4B').hide();
                colType = 1;
            }
            else {
                if(gdata.SI[0].PlanCode!="HLAWP") 
                {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#table-Summary2 #col2').html('Pendapatan Tahunan Terkumpul *<br/>('+(11-minusOneForWP)+')');
                        $('#table-Summary2 #col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>('+(12-minusOneForWP)+')');
                        $('#table-Summary2 #col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>('+(13-minusOneForWP)+')');
                    } else //English
                    {
                        $('#table-Summary2 #col2').html('Accumulated Yearly Income *<br/>('+(11-minusOneForWP)+')');
                        $('#table-Summary2 #col3').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>('+(12-minusOneForWP)+')');
                        $('#table-Summary2 #col4').html('Special Terminal Dividend Payable on Death/TPD<br/>('+(13-minusOneForWP)+')');
                    }
                }
                $('.ShowGYI').show();
                colType = 2;
            }
        }
        else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') 
        {
            if (gdata.SI[0].QuotationLang == "Malay") 
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)<br/>');
            } else //English
            {
                $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)<br/>');
            }
            if (gdata.SI[0].Trad_Details.data[0].YearlyIncome == "POF") {
                if (gdata.SI[0].QuotationLang == "Malay") 
                {
                    $('#table-Summary2 #col1').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                    $('#table-Summary2 #col2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(11)');
                } else //English
                {
                    $('#table-Summary2 #col1').html('Terminal Dividend Payable<br/>on Surrender/Maturity<br/>(10)');
                    $('#table-Summary2 #col2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
                }
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
            } else {
                if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                {
                    $('#table-Summary2 #col1').html('Pendapatan Tahunan Terkumpul *<br/>(10)');
                    $('#table-Summary2 #col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                    $('#table-Summary2 #col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian<br/>(12)');
                } else //English
                {
                    $('#table-Summary2 #col1').html('Accumulated Yearly Income *<br/>(10)');
                    $('#table-Summary2 #col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                    $('#table-Summary2 #col3').html('Special Terminal Dividend Payable on Death/TPD<br/><br/>(12)');
                }
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
    }
    
    
    
    if(gdata.SI[0].PlanCode=="HLACP"){
        $.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
        	if (colType == 1) {
        		$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
               		CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + 
               		CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            } else if (colType == 2) {
            	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
            		CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' +
            		CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            } else if (colType == 3) {
               	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
               		CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            } else if (colType == 4) {
               	$('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
               		CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + 
               		CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            }
        });
    }else if(gdata.SI[0].PlanCode=="HLAWP") {
        $.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, row) {
            if (colType == 1) { // CD: ACC, GYI : Payout
               $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
                                                   	CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) +
                                                   	'</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            }
            else if (colType == 2) { // CD: ACC, GYI : ACC
                $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
                                                   	CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) +
                                                   	'</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
            }
            else if (colType == 3) { // CD: Payout, GYI : Payout
                $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
                                                    CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + 
                                                    '</td></tr>');
            }
            else if (colType == 4) {  // CD: Payout, GYI : ACC
                $('#table-Summary2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
                                                    CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + 
                                                    '</td></tr>');
            }
        });
    }
    writeInvestmentScenarios();
}
function writeRiderPage1_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    
    if (gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0) {
        $('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
        $('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
        $('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1);
            $('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1);
            $('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2);
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage1').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage1').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage1').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage1').html(eval('row.col' + j));
                    }
                }
            }
        }
        
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
            $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + 
            CurrencyNoCents(row.col7) + '</td><td>' + CurrencyNoCents(row.col8) + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + 
            CurrencyNoCents(row.col11) + '</td><td>' + formatCurrency(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage2_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0) {
        $('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
        $('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
        $('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1 );
            $('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2 );
        } else //English
        {
            $('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1);
            $('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2);
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage2').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage2').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage2').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage2').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
            $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + 
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage3_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0) {
        $('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
        $('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
        $('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1);
            $('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1 );
            $('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2 );
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage3').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage3').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage3').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage3').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
            $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + 
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage4_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0) {
        $('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
        $('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
        $('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1);
            $('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2);
        } else {
            $('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1);
            $('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2);
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage4').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage4').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage4').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage4').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
            $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' +
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage5_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0) {
        $('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
        $('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
        $('#rider3Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
        
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1);
            $('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1);
            $('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2);
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage5').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage5').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage5').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage5').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
            $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + 
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage6_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0) {
        $('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
        $('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
        $('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
        
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1);
            $('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1);
            $('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2);
        }
        
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage6').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage6').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage6').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage6').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
            $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + 
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage7_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0) {
        $('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
        $('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
        $('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1);
            $('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1);
            $('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2);
        }
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage7').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage7').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage7').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage7').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
            $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' +
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderPage8_HLCP() {
    if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulate)<br/>');
        }
    } else if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'POF') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('.paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
    }
    if (gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0) {
        $('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
        $('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
        $('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1);
            $('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2);
        } else //English
        {
            $('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1);
            $('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2);
        }
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
                row2 = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i + 1];
                if (eval('row.col' + j) == "Guaranteed<br/>Surrender<br/>Value(if no<br/>claim<br/>admitted)") {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage8').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage8').html(eval('row.col' + j));
                    }
                } else {
                    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
                    {
                        $('#col' + j + '_EPage8').html(eval('row2.col' + j));
                    } else //English
                    {
                        $('#col' + j + '_EPage8').html(eval('row.col' + j));
                    }
                }
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
            $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + CurrencyNoCents(row.col2) + '</td><td>' + 
            	CurrencyNoCents(row.col3) + '</td><td>' + CurrencyNoCents(row.col4) + '</td><td>' + formatCurrency(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + row.col7 + '</td><td>' + 
            	row.col8 + '</td><td>' + formatCurrency(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' + CurrencyNoCents(row.col11) + '</td><td>' + CurrencyNoCents(row.col12) + '</td></tr>');
        }
    }
}

function writeRiderDescription_EN() {
    var textExist = false;
    
    $.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
           if (row.riders != "" && row.riders != "(null)") {
           if (row.riders.charAt(row.riders.length - 1) == ";") {
            rider = row.riders.slice(0, -1).split(";");
           }
           else {
            rider = row.riders.split(";");
           }
           for (i = 0; i < rider.length; i++) {
            if (rider[i] == "C+") {
             rider[i] = "C";
            }
            else if (rider[i] == 'tblHeader' && textExist == false) {
             tblHeader = "#" + row.PageDesc + " #riderInPage"
             $(tblHeader).css('display', 'inline');
             textExist = true;
             document.getElementById('onlyShowAtFirstPage').style.display = "";
            }
           tblRider = "#" + row.PageDesc + " #table-design1 tr." + rider[i];
           $(tblRider).css('display', 'table-row');
           if (rider[i] == "C") {
            rider[i] = "C+"
           $("#" + row.PageDesc + " #table-design2Wide tr").css('display', 'table-row');
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "C+") {
                  $("#" + row.PageDesc + " .CRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .cVeryEarly").html('50% of Rider Sum Assured');
                  $("#" + row.PageDesc + " .cEarly").html('150% of Rider Sum Assured');
                  $("#" + row.PageDesc + " .cAdvance").html('250% of Rider Sum Assured');
                  $("#" + row.PageDesc + " .cNursingCareAllowance").html('25% of Rider Sum Assured');
                  $("#" + row.PageDesc + " .cVeryEarly_BM").html('50% daripada Jumlah Rider Diinsuranskan');
                  $("#" + row.PageDesc + " .cEarly_BM").html('150% daripada Jumlah Rider Diinsuranskan');
                  $("#" + row.PageDesc + " .cAdvance_BM").html('250% daripada Jumlah Rider Diinsuranskan');
                  $("#" + row.PageDesc + " .cNursingCareAllowance_BM").html('25% daripada Jumlah Rider Diinsuranskan');

                  if (rowRider.PlanOption == "Level") {
					  $("#" + row.PageDesc + ' .cPlanOption').html('Level Cover');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
					  $("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html('');
					  $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html('');
					  
                  } else if (rowRider.PlanOption == "Increasing") { 
					  $("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover');
					  $("#" + row.PageDesc + ' .cNoClaimBenefit').html('');
					  $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html('');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + 
					  "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " + 
					  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html("<u>Jumlah Diinsuranskan Meningkat Terjamin</u><br/>" + 
					  "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada<br/> " + 
					  "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan peningkatan yang terakhir pada Ulang tahun ke-20 Polisi ini dan kekal sama kemudian dari ini.<br/><br/>");
					  $("#" + row.PageDesc + " .cVeryEarlyTD").html('50% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cEarlyTD").html('150% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cAdvanceTD").html('250% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cNursingCareAllowance").html('25% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cVeryEarlyTD_BM").html('50% daripada Jumlah Rider Diinsuranskan');
					  $("#" + row.PageDesc + " .cEarlyTD_BM").html('150% daripada Jumlah Rider Diinsuranskan');
					  $("#" + row.PageDesc + " .cAdvanceTD_BM").html('250% daripada Jumlah Rider Diinsuranskan');
					  $("#" + row.PageDesc + " .cNursingCareAllowance_BM").html('25% daripada Jumlah Rider Diinsuranskan');
					  
                  } else if (rowRider.PlanOption == "Level_NCB") {
					  $("#" + row.PageDesc + ' .cPlanOption').html('Level Cover with NCB');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html('');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html('');
					  $("#" + row.PageDesc + ' .cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
					  $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html("<u>Faedah Tanpa Tuntutan</u><br/> " + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Selagi Hayat Diinsuranskan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutan yang dimohon sebelum tarikh<br/>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tersebut, Syarikat akan membayar Pemunya Polisi Faedah Tanpa Tuntutan bersamaan dengan RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
                  } else if (rowRider.PlanOption == "Increasing_NCB") {
					  $("#" + row.PageDesc + ' .cPlanOption').html('Increasing Cover with NCB');
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured').html("<u>Guaranteed Increasing Sum Assured</u><br/>" + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Rider's Sum Assured shall increase by 10% every 2 years with the first such increase staring on 2nd Anniversary of the Commencement Date of this<br/> " + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Rider and the last on the 20th Anniversary of this Rider and remains level thereafter.<br/><br/>");
					  $("#" + row.PageDesc + ' .cNoClaimBenefit').html("<u>No Claim Benefit</u><br/> " + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Upon survival of the Life Assured on the Expiry Date of this Rider and provided that no claim has been admitted prior to this date, the company will pay the<br/>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Policy Owner a No Claim benefit equivalent to RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
					  $("#" + row.PageDesc + ' .cGuaranteedIncreasingSumAssured_BM').html("<u>Jumlah Diinsuranskan Meningkat Terjamin</u><br/>" + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jumlah Rider Diinsuranskan akan meningkat bersamaan dengan 10% bagi setiap 2 tahun dengan peningkatan pertama tersebut bermula pada<br/> " + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ulang tahun ke-2 bagi Tarikh Permulaan Polisi ini dan peningkatan yang terakhir pada Ulang tahun ke-20 Polisi ini dan kekal sama kemudian dari ini.<br/><br/>");
					  $("#" + row.PageDesc + ' .cNoClaimBenefit_BM').html("<u>Faedah Tanpa Tuntutan</u><br/> " + "-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Selagi Hayat Diinsuranskan masih hidup pada Tarikh Tamat Tempoh Polisi ini dengan syarat tiada tuntutan yang dimohon sebelum tarikh<br/>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tersebut, Syarikat akan membayar Pemunya Polisi Faedah Tanpa Tuntutan bersamaan dengan RM" + formatCurrency(rowRider.SumAssured) + "<br/><br/>");
					  $("#" + row.PageDesc + " .cVeryEarlyTD").html('50% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cEarlyTD").html('150% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cAdvanceTD").html('250% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cNursingCareAllowance").html('25% of Rider Sum Assured');
					  $("#" + row.PageDesc + " .cVeryEarlyTD_BM").html('50% daripada jumlah diinsuranskan rider');
					  $("#" + row.PageDesc + " .cEarlyTD_BM").html('150% daripada jumlah diinsuranskan rider');
					  $("#" + row.PageDesc + " .cAdvanceTD_BM").html('250% daripada jumlah diinsuranskan rider');
					  $("#" + row.PageDesc + " .cNursingCareAllowance_BM").html('25% daripada Jumlah Rider Diinsuranskan');
                  }
                  }
                  });
           } else if (rider[i] == "ACIR_MPP") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "ACIR_MPP") {
                  $("#" + row.PageDesc + " .ACIR_MPPRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .ACIR_MPPGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "CCTR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "CCTR") {
                  $("#" + row.PageDesc + " .CCTRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .CCTRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           else if (rider[i] == "CIR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "CIR") {
                  $("#" + row.PageDesc + " .CIRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .CIRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "CIWP") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "CIWP") {
                  $("#" + row.PageDesc + " .CIWPRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .CIWPSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "CPA") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "CPA") {
                  $("#" + row.PageDesc + " .CPARiderTerm").html(rowRider.RiderTerm);
                  }
                  });
           } else if (rider[i] == "EDB") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "EDB") {
                  $("#" + row.PageDesc + " .EDBRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .EDBGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           else if (rider[i] == "EDUWR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "EDUWR") {
                  $("#" + row.PageDesc + " .EDUWRTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .EDUWRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           } else if (rider[i] == "TPDYLA") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "TPDYLA") {
                  $("#" + row.PageDesc + " .ETPDRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .ETPDGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           } else if (rider[i] == "ETPDB") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "ETPDB") {
                  $("#" + row.PageDesc + " .ETPDBRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .ETPDBGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "HB") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "HB") {
                  $("#" + row.PageDesc + " .HBRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .HBBenefit").html(formatCurrency(parseInt(rowRider.Units) * 45));
                  }
                  });
           } else if (rider[i] == "HMM") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "HMM") {
                    $("#" + row.PageDesc + " .HMMRiderTerm").html(rowRider.RiderTerm);
                        if(rowRider.PlanOption == 'HMM_1000'){
                             $("#" + row.PageDesc + " .HMMRiderName").html('HLA Major Medi Plus');             
                        }
                        else
                        {
                            $("#" + row.PageDesc + " .HMMRiderName").html('HLA Major Medi');             
                        }
                        
                    $("#" + row.PageDesc + " .HMMRiderDeduc").html(CurrencyNoCents(rowRider.Deductible));
                  }
                  });
           } else if (rider[i] == "HSP_II") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "HSP_II") {
                  $("#" + row.PageDesc + " .HSP_IIRiderTerm").html(rowRider.RiderTerm);
                  }
                  });
           } else if (rider[i] == "ICR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "ICR") {
                  $("#" + row.PageDesc + " .ICRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .ICRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "LCPR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "LCPR") {
                  $("#" + row.PageDesc + " .LCPRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .LCPRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "MG_II") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "MG_II") {
                  $("#" + row.PageDesc + " .MG_IIRiderTerm").html(rowRider.RiderTerm);
                  }
                  });
           } else if (rider[i] == "MG_IV") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "MG_IV") {
                  $("#" + row.PageDesc + " .MG_IVRiderTerm").html(rowRider.RiderTerm);
                  }
                  });
           } else if (rider[i] == "PA") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "PA") {
                  $("#" + row.PageDesc + " .PARiderTerm").html(rowRider.RiderTerm);
                  }
                  });
           }else if (rider[i] == "WA50R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WA50R") {
                  }
                  });
           }else if (rider[i] == "WB30R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WB30R") {
                  $("#" + row.PageDesc + " .WB30RGYCC").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }else if (rider[i] == "WB50R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WB50R") {
                  $("#" + row.PageDesc + " .WB50RGYCC").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }else if (rider[i] == "WBD10R30") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WBD10R30") {
                  $("#" + row.PageDesc + " .WBD10R30GYCC").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }else if (rider[i] == "WBI6R30") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WBI6R30") {
                    $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           }else if (rider[i] == "WE50R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WE50R") {
                  $("#" + row.PageDesc + " .WE50RGYCC").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           else if (rider[i] == "WP30R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WP30R") {
                  $("#" + row.PageDesc + " .WP30RGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           else if (rider[i] == "WP50R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WP50R") {
                  $("#" + row.PageDesc + " .WP50RGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           else if (rider[i] == "WPTPD30R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WPTPD30R") {
                  $("#" + row.PageDesc + " .WPTPD30RGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           }
           else if (rider[i] == "WPTPD50R") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "WPTPD50R") {
                  $("#" + row.PageDesc + " .WPTPD50RGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "SP_PRE") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "SP_PRE") {
                  $("#" + row.PageDesc + " .SP_PRERiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .SP_PRESA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "SP_STD") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "SP_STD") {
                  $("#" + row.PageDesc + " .SP_STDRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .SP_STDSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  }
                  });
           } else if (rider[i] == "LCWP") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "LCWP") {
                  $("#" + row.PageDesc + " .LCWPRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .LCWPSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  //please check the PTypeCode......
                  if (rowRider.PTypeCode == "LA") {
                  $("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Hayat Diinsuranskan ke-2');
                  $("#" + row.PageDesc + " .LCWPInsuredLives").html('2nd Life Assured');
                  } else if (rowRider.PTypeCode == "PY") {
                  $("#" + row.PageDesc + " .LCWPInsuredLives").html('Policy Owner');
                  $("#" + row.PageDesc + " .LCWPInsuredLives_BM").html('Pemunya<br/>Polisi');
                  } else {
                  $("#" + row.PageDesc + " .LCWPInsuredLives").html('Payor');
                  }
                  }
                  });
           } else if (rider[i] == "PLCP") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "PLCP") {
                  $("#" + row.PageDesc + " .PLCPRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + ' #illness tr').css('display', 'table-row');
                  $("#" + row.PageDesc + " .PLCPGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           } else if (rider[i] == "PR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "PR") {
                  $("#" + row.PageDesc + " .PRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .PRSA").html('('+CurrencyNoCents(rowRider.SumAssured)+'%)');
                  if (rowRider.PTypeCode == "LA") {
                  $("#" + row.PageDesc + " .PRInsuredLives").html('2nd Life Assured');
                  } else if (rowRider.PTypeCode == "PY") {
                  $("#" + row.PageDesc + " .PRInsuredLives").html('Policy Owner');
                  $("#" + row.PageDesc + " .PRInsuredLives_BM").html('Pemunya<br/>Polisi');
                  } else {
                  $("#" + row.PageDesc + " .PRInsuredLives").html('Payor');
                  }
                  }
                  });
           } else if (rider[i] == "PTR") {
           $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, rowRider) {
                  if (rowRider.RiderCode == "PTR") {
                  $("#" + row.PageDesc + " .PTRRiderTerm").html(rowRider.RiderTerm);
                  $("#" + row.PageDesc + " .PTRGYI").html(formatCurrency(rowRider.SumAssured) + "");
                  }
                  });
           }
           }
           }
           });
}

function writeRiderDescription2_EN() {
    $.each(gdata.SI[0].SI_Temp_Pages.data, function(index, row) {
           
        if ((row.htmlName == 'Page36_2.html' || row.htmlName == 'Page35_2.html') && row.riders != "" && row.riders != "(null)") {
           
           if (row.riders.charAt(row.riders.length - 1) == ";") {
                rider = row.riders.slice(0, -1).split(";");
           } else {
              rider = row.riders.split(";");
           }
           for (i = 0; i < rider.length; i++) {
            if (rider[i] == "C+") {
                rider[i] = "C";
            }
            
            tblRider = "#" + row.PageDesc + " #table-design1_2 tr." + rider[i];
            
            $(tblRider).css('display', 'table-row');
            
           }
        }
    });
}

function writeSummary2() {
    var colType = 0;
    if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 0) { //title
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.advanceYearlyIncome').html('Ilustrasi HLA Income Builder');
        } else //English
        {
            $('.advanceYearlyIncome').html('Illustration of HLA Income Builder');
        }
        $('.advanceYearlyDesc').hide();
    } else if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 60) {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.advanceYearlyIncome').html('Ilustrasi HLA Income Builder - Pendahuluan Pendapatan Tahunan pada umur 60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
        } else //English
        {
            $('.advanceYearlyIncome').html('Illustration of HLA Income Builder - Advance Yearly Income at age 60&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
        }
    } else if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].AdvanceYearlyIncome) == 75) {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('.advanceYearlyIncome').html('Ilustrasi HLA Income Builder - Pendahuluan Pendapatan Tahunan pada umur 75&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
        } else //English
        {
            $('.advanceYearlyIncome').html('Illustration of HLA Income Builder - Advance Yearly Income at age 75&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
        }
    }
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        var minusOneForWP = 0;
        
        if(gdata.SI[0].PlanCode=="HLAWP")
        {
            minusOneForWP = 1;
        }else
        {
            minusOneForWP = 0;
        }
        
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].MCashPaymentD + '&nbsp;(Dividen Tunai Terkumpul)');
            $('#col1').html('Dividen Tunai Terkumpul<br/>(10)');
        } else { //English
            $('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Accumulation)&nbsp;');
            $('#col1').html('Accumulated Cash Dividend<br/>('+(10-minusOneForWP)+')');
        }
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/(11)');
                $('#col3').html('Special Terminal Dividend Payable on<br/>(12)');
            }
            $('#col4').html('-<br/><br/>-');
            $('#col4A').html('-');
            $('#col4B').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2').html('Pendapatan Tahunan Terkumpul<br/>(11)');
                $('#col3').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(12)');
                $('#col4').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(13)');
            } else //English
            {
                $('#col2').html('Accumulated Yearly Income<br/>(11)');
                $('#col3').html('Terminal Dividend Payable on<br/>(12)');
                $('#col4').html('Special Terminal Dividend Payable on<br/>(13)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].McashPaymentD + '&nbsp;(Dividen Tunai Dibayar)');
        } else //English
        {
            $('#paymentDesc').html(gdata.SI[0].SI_Temp_Trad.data[0].CashPaymentD + '&nbsp;(Cash Dividend Payout)');
        }
        
        if (parseInt(row.CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/><br/>(11)');
            }
            $('#col3').html('-<br/><br/>-');
            $('#col4').html('-<br/><br/>-');
            $('#col3A').html('-');
            $('#col3B').html('-');
            $('#col4A').html('-');
            $('#col4B').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col3').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col1').html('Accumulated Yearly Income<br/>(10)');
                $('#col2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col3').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            $('#col4').html('-<br/><br/>-');
            $('#col4A').html('-');
            $('#col4B').html('-');
            colType = 4;
        }
    }
    $.each(gdata.SI[0].SI_Temp_Trad_Basic.data, function(index, SI_Temp_Trad_Basic) {
    	if (colType == 1) {
    		$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + 
    			SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + 
    			SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' +
    			SI_Temp_Trad_Basic.col22 + '</td></tr>');
        } else if (colType == 2) {
        	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + 
        		SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col15 + '</td><td>' + SI_Temp_Trad_Basic.col16 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + 
        		SI_Temp_Trad_Basic.col18 +  '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + 
        		SI_Temp_Trad_Basic.col22 + '</td></tr>');
        } else if (colType == 3) {
           	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' +
           		SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' + 
           		SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 4) {
           	$('#table-Summary2 > tbody').append('<tr><td>' + SI_Temp_Trad_Basic.col0_1 + '</td><td>' + SI_Temp_Trad_Basic.col0_2 + '</td><td>' + SI_Temp_Trad_Basic.col13 + '</td><td>' + 
           		SI_Temp_Trad_Basic.col14 + '</td><td>' + SI_Temp_Trad_Basic.col17 + '</td><td>' + SI_Temp_Trad_Basic.col18 + '</td><td>' + SI_Temp_Trad_Basic.col19 + '</td><td>' +
           		SI_Temp_Trad_Basic.col20 + '</td><td>' + SI_Temp_Trad_Basic.col21 + '</td><td>' + SI_Temp_Trad_Basic.col22 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
    writeInvestmentScenarios() //page3
}

function writeI20R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
    	$('.titleI20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	$('#table-I20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
    	SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' +
    	SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' +
    	SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
    });
    writeInvestmentScenariosRight();
}

function writeI20R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1I20R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1I20R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3I20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I20R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3I20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4I20R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2I20R2').html('Accumulated Yearly Income<br/>(10)</i>');
                $('#col3I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2I20R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1I20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2I20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3I20R2').html('-<br/><br/>-');
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col3AI20R2').html('-');
            $('#col3BI20R2').html('-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I20R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2I20R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3I20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1I20R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2I20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3I20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I20R2').html('-<br/><br/>-');
            $('#col4AI20R2').html('-');
            $('#col4BI20R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleI20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleI20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I20R[0].data[0].RiderDesc);
    }
    
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	if (colType == 1) {
    		$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeI30R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleI30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc);
    }
    
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	$('#table-I30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
    	SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' +
    	SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
    	SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
    });
    writeInvestmentScenariosRight();
}

function writeI30R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1I30R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1I30R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3I30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I30R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3I30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4I30R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2I30R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2I30R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1I30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2I30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3I30R2').html('-<br/><br/>-');
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col3AI30R2').html('-');
            $('#col3BI30R2').html('-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I30R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2I30R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3I30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1I30R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2I30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3I30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I30R2').html('-<br/><br/>-');
            $('#col4AI30R2').html('-');
            $('#col4BI30R2').html('-');
            colType = 4;
        }
    }
    
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleI30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleI30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I30R[0].data[0].RiderDesc);
    }
    
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	if (colType == 1) {
    		$('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
    		SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
        	$('#table-I30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
        	$('#table-I20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
        	SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeI40R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleI40R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc );
    } else //English
    {
        $('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        $('#table-I40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
        SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + 
        SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
        SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
    });
    writeInvestmentScenariosRight();
}

function writeI40R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1I40R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1I40R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3I40R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2I40R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3I40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4I40R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2I40R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2I40R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1I40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2I40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3I40R2').html('-<br/><br/>-');
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col3AI40R2').html('-');
            $('#col3BI40R2').html('-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1I40R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2I40R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3I40R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1I40R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2I40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3I40R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4I40R2').html('-<br/><br/>-');
            $('#col4AI40R2').html('-');
            $('#col4BI40R2').html('-');
            colType = 4;
        }
    }
    
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleI40R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleI40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.I40R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.I40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        if (colType == 1) {
           	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           	SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           	$('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           	SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           	SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           	SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-I40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeID20R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
           $('#table-ID20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
           });
    writeInvestmentScenariosRight();
}

function writeID20R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1ID20R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1ID20R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3ID20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID20R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3ID20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4ID20R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2ID20R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2ID20R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1ID20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2ID20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3ID20R2').html('-<br/><br/>-');
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col3AID20R2').html('-');
            $('#col3BID20R2').html('-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID20R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2ID20R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3ID20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1ID20R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2ID20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3ID20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID20R2').html('-<br/><br/>-');
            $('#col4AID20R2').html('-');
            $('#col4BID20R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID20R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	if (colType == 1) {
           $('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           $('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-ID20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeID30R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        $('#table-ID30R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' +         
           SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
    });
    writeInvestmentScenariosRight();
}

function writeID30R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1ID30R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1ID30R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3ID30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID30R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3ID30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4ID30R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2ID30R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2ID30R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1ID30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2ID30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3ID30R2').html('-<br/><br/>-');
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col3AID30R2').html('-');
            $('#col3BID30R2').html('-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID30R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2ID30R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3ID30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1ID30R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2ID30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3ID30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID30R2').html('-<br/><br/>-');
            $('#col4AID30R2').html('-');
            $('#col4BID30R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID30R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        if (colType == 1) {
           $('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           $('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-ID30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeID40R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID40R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
    	$('#table-ID40R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
        });
    writeInvestmentScenariosRight();
}

function writeID40R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1ID40R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1ID40R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3ID40R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2ID40R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3ID40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4ID40R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2ID40R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID40R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2ID40R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1ID40R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2ID40R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3ID40R2').html('-<br/><br/>-');
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col3AID40R2').html('-');
            $('#col3BID40R2').html('-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1ID40R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2ID40R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3ID40R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1ID40R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2ID40R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3ID40R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4ID40R2').html('-<br/><br/>-');
            $('#col4AID40R2').html('-');
            $('#col4BID40R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleID40R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleID40R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.ID40R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.ID40R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        if (colType == 1) {
           $('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           $('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-ID40R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeIE20R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleIE20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        $('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
        });
    writeInvestmentScenariosRight();
}

function writeIE20R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1IE20R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1IE20R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2IE20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3IE20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2IE20R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3IE20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4IE20R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2IE20R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1IE20R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2IE20R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1IE20R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2IE20R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3IE20R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE20R2').html('-');
            $('#col3BIE20R2').html('-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1IE20R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2IE20R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3IE20R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1IE20R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2IE20R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3IE20R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col4AIE20R2').html('-');
            $('#col4BIE20R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleIE20R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleIE20R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE20R[0].data[0].RiderDesc);
    }
    
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        if (colType == 1) {
           $('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           $('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-IE20R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeIE30R_1() {
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleIE30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE20R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        $('#table-IE20R1 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col1 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col3 + '</td><td>' + SI_Temp_Trad_RiderIllus.col4 + '</td><td>' + SI_Temp_Trad_RiderIllus.col5 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col6 + '</td><td>' + SI_Temp_Trad_RiderIllus.col7 + '</td><td>' + SI_Temp_Trad_RiderIllus.col8 + '</td><td>' + SI_Temp_Trad_RiderIllus.col9 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col10 + '</td><td>' + SI_Temp_Trad_RiderIllus.col11 + '</td></tr>');
    });
    writeInvestmentScenariosRight();
}

function writeIE30R_2() {
    var colType = 0;
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
        {
            $('#col1IE30R2').html('Dividen Tunai Terkumpul<br/>(9)');
        } else //English
        {
            $('#col1IE30R2').html('Accumulated Cash Dividend<br/>(9)');
        }
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2IE30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(10)');
                $('#col3IE30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col2IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(10)');
                $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4IE30R2').html('-<br/><br/>-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 1;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col2IE30R2').html('Pendapatan Tahunan Terkumpul<br/>(10)');
                $('#col3IE30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(11)');
                $('#col4IE30R2').html('Dividen Terminal Istimewa Dibayar atas<br/>Kematian/TPD<br/>(12)');
            } else //English
            {
                $('#col2IE30R2').html('Accumulated Yearly Income<br/>(10)');
                $('#col3IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(11)');
                $('#col4IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(12)');
            }
            colType = 2;
        }
    } else if (gdata.SI[0].SI_Trad_Details.data[0].CashDividend == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1IE30R2').html('Dividen Terminal Dibayar atas<br/>Penyerahan/Matang<br/>(9)');
                $('#col2IE30R2').html('Dividen Terminal Istimewa Dibayar<br/>atas Kematian/TPD<br/>(10)');
            } else //English
            {
                $('#col1IE30R2').html('Terminal Dividend Payable on<br/>Surrender/Maturity<br/>(9)');
                $('#col2IE30R2').html('Special Terminal Dividend Payable on<br/>Death/TPD<br/>(10)');
            }
            $('#col3IE30R2').html('-<br/><br/>-');
            $('#col4IE20R2').html('-<br/><br/>-');
            $('#col3AIE30R2').html('-');
            $('#col3BIE30R2').html('-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1IE30R2').html('Pendapatan Tahunan Terkumpul<br/>(9)');
                $('#col2IE30R2').html('Dividen Terminal Dibayar atas Penyerahan/Matang<br/>(10)');
                $('#col3IE30R2').html('Dividen Terminal Istimewa Dibayar atas Kematian/TPD<br/>(11)');
            } else //English
            {
                $('#col1IE30R2').html('Accumulated Yearly Income<br/>(9)');
                $('#col2IE30R2').html('Terminal Dividend Payable on Surrender/Maturity<br/>(10)');
                $('#col3IE30R2').html('Special Terminal Dividend Payable on Death/TPD<br/>(11)');
            }
            $('#col4IE30R2').html('-<br/><br/>-');
            $('#col4AIE30R2').html('-');
            $('#col4BIE30R2').html('-');
            colType = 4;
        }
    }
    if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
    {
        $('.titleIE30R').html('Illustrasi ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc);
    } else //English
    {
        $('.titleIE30R').html('Illustration of ' + gdata.SI[0].SI_Trad_Rider_Profile.IE30R[0].data[0].RiderDesc);
    }
    $.each(gdata.SI[0].SI_Temp_Trad_RiderIllus.IE30R[0].data, function(index, SI_Temp_Trad_RiderIllus) {
        if (colType == 1) {
           $('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        } else if (colType == 2) {
           $('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' +
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col14 + '</td><td>' + SI_Temp_Trad_RiderIllus.col15 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td><td>' + '-' + '</td><td>' + '</td></tr>');
        } else if (colType == 4) {
           $('#table-IE30R2 > tbody').append('<tr><td>' + SI_Temp_Trad_RiderIllus.col0_1 + '</td><td>' + SI_Temp_Trad_RiderIllus.col0_2 + '</td><td>' + SI_Temp_Trad_RiderIllus.col12 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col13 + '</td><td>' + SI_Temp_Trad_RiderIllus.col16 + '</td><td>' + SI_Temp_Trad_RiderIllus.col17 + '</td><td>' + SI_Temp_Trad_RiderIllus.col18 + '</td><td>' + 
           SI_Temp_Trad_RiderIllus.col19 + '</td><td>' + SI_Temp_Trad_RiderIllus.col20 + '</td><td>' + SI_Temp_Trad_RiderIllus.col21 + '</td><td>' + '-' + '</td><td>' + '-' + '</td></tr>');
        }
    });
}

function writeSummary3() {
    var colType = 0;
    $('.TotPremPaid2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid2));
    $('.SurrenderValueHigh2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh2));
    $('.SurrenderValueLow2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow2));
    $('.TotYearlyIncome2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome2));
    if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'A') //payment description
    {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('.noteM').html('Nota: Anggapan selepas tamat tempoh Income Rider, Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.<br/>');
            } else //English
            {
                $('.note').html('Note: Assumes after the expiry of the Income Rider(s), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            }
            
            $('.accumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1Summary3').html('Jumlah Dividend Tunai<br/>Terkumpul<br/>(Akhir Tahun)');
                $('#col2Summary3').html('Jumlah Nilai Penyerahan<br/>(Akhir Tahun)');
                $('#col3Summary3').html('Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)*^');
            } else //English
            {
                $('#col1Summary3').html('Total Accumulated Cash<br/>Dividends<br/>(End Of Year)');
                $('#col2Summary3').html('Total Surrender Value<br/>(End of Year)');
                $('#col3Summary3').html('Total Death/TPD Benefit<br/>(End of Year)*^');
            }
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 1;
            
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('.noteM').html('Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada), Dividen Tunai Terkumpul (jika ada) dan Dividen Terminal (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.<br/>');
            } else //English
            {
                $('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any), accumulated Cash Dividends (if any) &amp; Terminal Dividend (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            }
            
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1Summary3').html('Jumlah Pendapatan Tahunan<br/>Terkumpul<br/>(Akhir Tahun)');
                $('#col2Summary3').html('Jumlah Dividend Tunai<br/>Terkumpul<br/>(Akhir Tahun)');
                $('#col3Summary3').html('Jumlah Nilai Penyerahan<br/>(Akhir Tahun)~');
            } else //English
            {
                $('#col1Summary3').html('Total Accumulated Yearly<br/>Income<br/>(End Of Year)');
                $('#col2Summary3').html('Total Accumulated Cash<br/>Dividends<br/>(End Of Year)');
                $('#col3Summary3').html('Total Surrender Value<br/>(End of Year)~');
            }
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1Summary3').html('Jumlah Pendapatan Tahunan<br/>Terkumpul<br>(Akhir Tahun)');
                $('#col2Summary3').html('Jumlah Dividend Tunai<br/>Terkumpul<br>(Akhir Tahun)');
                $('#col3Summary3').html('Jumlah Nilai Penyerahan<br/>(Akhir Tahun)~');
            } else //English
            {
                $('#col1Summary3').html('Total Accumulated Yearly<br/>Income<br>(End Of Year)');
                $('#col2Summary3').html('Total Accumulated Cash<br/>Dividends<br>(End Of Year)');
                $('#col3Summary3').html('Total Surrender Value<br>(End of Year)~');
            }
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col4Summary3').html('Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)*^~');
            } else //English
            {
                $('#col4Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~');
            }
            colType = 2;
        }
    } else if ($.trim(gdata.SI[0].SI_Trad_Details.data[0].CashDividend) == 'P') {
        if (parseInt(gdata.SI[0].SI_Trad_Details.data[0].CashPayment) == 0) {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1Summary3').html('Jumlah Nilai Penyerahan<br/>(Akhir Tahun)');
                $('#col2Summary3').html('Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)*^');
            } else //English
            {
                $('#col1Summary3').html('Total Surrender Value (End<br/>of Year)');
                $('#col2Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^');
            }
            $('#col3Summary3').html('-<br/><br/>-');
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col3ASummary3').html('-');
            $('#col3BSummary3').html('-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            $('.ccumulationYearlyIncome').hide(); //~ description
            $('.premiumPaymentOption').hide(); //# description
            colType = 3;
        } else {
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('.noteM').html('Nota: Anggapan selepas tamat tempoh Income Rider, Pendapatan Tahunan Terkumpul (jika ada) rider akan dikumpul hingga akhir tempoh pelan asas.<br/>');
            } else //English
            {
                $('.note').html('Note: Assumes after the expiry of the Income Rider(s),accumulated Yearly Income (if any) of the rider(s) are accumulated till end of the basic plan term.<br/>');
            }
            if (gdata.SI[0].QuotationLang == "Malay") // added by Edwin for language switch 3-9-2013
            {
                $('#col1Summary3').html('Jumlah Pendapatan Tahunan<br/>Terkumpul<br/>(Akhir Tahun)');
                $('#col2Summary3').html('Jumlah Nilai Penyerahan<br/>(Akhir Tahun)~');
                $('#col3Summary3').html('Jumlah Faedah Kematian/TPD<br/>(Akhir Tahun)*^~');
            } else //English
            {
                $('#col1Summary3').html('Total Accumulated Yearly<br/>Income<br/>(End Of Year)');
                $('#col2Summary3').html('Total Surrender Value (End<br/>of Year)~');
                $('#col3Summary3').html('Total Death/TPD Benefit (End<br/>of Year)*^~');
            }
            $('#col4Summary3').html('-<br/><br/>-');
            $('#col4ASummary3').html('-');
            $('#col4BSummary3').html('-');
            colType = 4;
        }
    }
    $.each(gdata.SI[0].SI_Temp_Trad_Summary.data, function(index, SI_Temp_Trad_Summary) {
        if (colType == 1) {
           $('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' +
           SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' +
           SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' +
           SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + 
           '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        } else if (colType == 2) {
           $('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' +
           SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' +
           SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + 
           SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>' +
           SI_Temp_Trad_Summary.col14 + '</td><td>' + SI_Temp_Trad_Summary.col15 + '</td></tr>');
        } else if (colType == 3) {
           $('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' +
           SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + 
           SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col10 + '</td><td>' + SI_Temp_Trad_Summary.col11 + '</td><td>' + 
           SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 +
           '</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        } else if (colType == 4) {
           $('#table-Summary3 > tbody').append('<tr><td>' + SI_Temp_Trad_Summary.col0_1 + '</td><td>' + SI_Temp_Trad_Summary.col0_2 + '</td><td>' + SI_Temp_Trad_Summary.col1 + '</td><td>' + 
           SI_Temp_Trad_Summary.col2 + '</td><td>' + SI_Temp_Trad_Summary.col3 + '</td><td>' + SI_Temp_Trad_Summary.col4 + '</td><td>' + SI_Temp_Trad_Summary.col5 + '</td><td>' + 
           SI_Temp_Trad_Summary.col6 + '</td><td>' + SI_Temp_Trad_Summary.col7 + '</td><td>' + SI_Temp_Trad_Summary.col8 + '</td><td>' + SI_Temp_Trad_Summary.col9 + '</td><td>' + 
           SI_Temp_Trad_Summary.col12 + '</td><td>' + SI_Temp_Trad_Summary.col13 + '</td><td>' + SI_Temp_Trad_Summary.col14 + '</td><td>' + SI_Temp_Trad_Summary.col15 + 
           '</td><td>&nbsp;</td><td>&nbsp;</td></tr>');
        }
    });
}

function writeRiderPage1() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length > 0) {
        $('#rider1Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col1);
        $('#rider2Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col5);
        $('#rider3Page1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[0].col9);
        $('#col0_1_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_1);
        $('#col0_2_EPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[1].col0_2);
        $('#col0_1_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_1);
        $('#col0_2_MPage1').html(gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
                $('#col' + j + '_EPage1').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i + 1];
                $('#col' + j + '_MPage1').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i];
            $('#table-Rider1 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + 
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' +
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage2() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length > 0) {
        $('#rider1Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col1);
        $('#rider2Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col5);
        $('#rider3Page2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[0].col9);
        $('#col0_1_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_1);
        $('#col0_2_EPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[1].col0_2);
        $('#col0_1_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_1);
        $('#col0_2_MPage2').html(gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
                $('#col' + j + '_EPage2').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p1[0].data[i + 1];
                $('#col' + j + '_MPage2').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p2[0].data[i];
            $('#table-Rider2 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' + 
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + 
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage3() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length > 0) {
        $('#rider1Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col1);
        $('#rider2Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col5);
        $('#rider3Page3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[0].col9);
        $('#col0_1_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_1);
        $('#col0_2_EPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[1].col0_2);
        $('#col0_1_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_1);
        $('#col0_2_MPage3').html(gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
                $('#col' + j + '_EPage3').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i + 1];
                $('#col' + j + '_MPage3').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p3[0].data[i];
            $('#table-Rider3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + 
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage4() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length > 0) {
        $('#rider1Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col1);
        $('#rider2Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col5);
        $('#rider3Page4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[0].col9);
        $('#col0_1_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_1);
        $('#col0_2_EPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[1].col0_2);
        $('#col0_1_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_1);
        $('#col0_2_MPage4').html(gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
                $('#col' + j + '_EPage4').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i + 1];
                $('#col' + j + '_MPage4').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p4[0].data[i];
            $('#table-Rider4 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + 
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage5() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length > 0) {
        $('#rider1Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col1);
        $('#rider2Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col5);
        $('#rider3Page5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[0].col9);
        $('#col0_1_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_1);
        $('#col0_2_EPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[1].col0_2);
        $('#col0_1_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_1);
        $('#col0_2_MPage5').html(gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
                $('#col' + j + '_EPage5').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i + 1];
                $('#col' + j + '_MPage5').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p5[0].data[i];
            $('#table-Rider5 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' +
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage6() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length > 0) {
        $('#rider1Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col1);
        $('#rider2Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col5);
        $('#rider3Page6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[0].col9);
        $('#col0_1_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_1);
        $('#col0_2_EPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[1].col0_2);
        $('#col0_1_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_1);
        $('#col0_2_MPage6').html(gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
                $('#col' + j + '_EPage6').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i + 1];
                $('#col' + j + '_MPage6').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p6[0].data[i];
            $('#table-Rider6 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' + 
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage7() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length > 0) {
        $('#rider1Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col1);
        $('#rider2Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col5);
        $('#rider3Page7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[0].col9);
        $('#col0_1_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_1);
        $('#col0_2_EPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[1].col0_2);
        $('#col0_1_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_1);
        $('#col0_2_MPage7').html(gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
                $('#col' + j + '_EPage7').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i + 1];
                $('#col' + j + '_MPage7').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p7[0].data[i];
            $('#table-Rider7 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' +
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writeRiderPage8() {
    if (gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length > 0) {
        $('#rider1Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col1);
        $('#rider2Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col5);
        $('#rider3Page8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[0].col9);
        $('#col0_1_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_1);
        $('#col0_2_EPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[1].col0_2);
        $('#col0_1_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_1);
        $('#col0_2_MPage8').html(gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[2].col0_2);
        for (var i = 1; i < 2; i++) {
            for (var j = 1; j < 13; j++) { //row header
                row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
                $('#col' + j + '_EPage8').html(eval('row.col' + j));
                row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i + 1];
                $('#col' + j + '_MPage8').html(eval('row.col' + j));
            }
        }
        for (var i = 3; i < gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data.length; i++) { //row data
            row = gdata.SI[0].SI_Temp_Trad_Rider.p8[0].data[i];
            $('#table-Rider8 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + row.col1 + '</td><td>' + row.col2 + '</td><td>' + row.col3 + '</td><td>' +
            row.col4 + '</td><td>' + row.col5 + '</td><td>' + row.col6 + '</td><td>' + row.col7 + '</td><td>' + row.col8 + '</td><td>' + row.col9 + '</td><td>' + row.col10 + '</td><td>' +
            row.col11 + '</td><td>' + row.col12 + '</td></tr>');
        }
    }
}

function writePremPayment() {
	text = "";
	if (gdata.SI[0].SI_Temp_Trad_Details.data[0].col4 == "10") {
		if (gdata.SI[0].QuotationLang == "Malay") {
			text = "terhad kepada 10 tahun sahaja";
		} else {
			text = "limited to 10 years only";
		}
	} else if (gdata.SI[0].SI_Temp_Trad_Details.data[0].col4 == "15") {
		if (gdata.SI[0].QuotationLang == "Malay") {
			text = "terhad kepada 15 tahun sahaja";
		} else {
			text = "limited to 15 years only";
		}
	} else if (gdata.SI[0].SI_Temp_Trad_Details.data[0].col4 == "20") {
		if (gdata.SI[0].QuotationLang == "Malay") {
			text = "terhad kepada 20 tahun sahaja";
		} else {
			text = "limited to 20 years only";
		}
	} else {
		if (gdata.SI[0].QuotationLang == "Malay") {
			text = "sehingga umur 100 ";
		} else {
			text = "up to age 100";
		}
	}
	
	$('.premPayTerm').html(text);
}


function writeFootnote_L100(){
    var a = 1;
    var fnPage35_ACIR = false;
    var SecondOrPayorRider = [];     
    
    $('.L100_Page2').html('[' + a + ']');
    a++;
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {        
        
        if(row.RiderCode == 'ACIR_MPP' || row.RiderCode == 'CIR' ){
            if (fnPage35_ACIR == false){
                $('.fnPage35_ACIR').html('[' + a + ']');
                a++;
                fnPage35_ACIR = true;
            }
        }
        else if(row.RiderCode == 'CIR' ){  
			fnPage35_CIR = true;
			$('.fnPage35_CIR').html('[' + a + ']');
			a++;
        }
        else if(row.RiderCode == 'CIWP'){
            $('.fnPage35_CIWP').html('[' + a + ']');
             a++;
        }
        else if(row.RiderCode == 'ICR'){
            $('.fnPage35_ICR').html('[' + a + ']');
             a++;
        }
        else if(row.RiderCode == 'LCPR'){
            $('.fnPage35_LCPR').html('[' + a + ']');
             a++;
        }
        else if(row.RiderCode == 'PLCP'){
            $('.fnPage35_PLCP').html('[' + a + ']');
             a++;
        }
        else if(row.RiderCode == 'LCWP'){
            SecondOrPayorRider.push('LCWP');    
        }
        else if(row.RiderCode == 'SP_PRE'){
             SecondOrPayorRider.push('SP_PRE');
        }
        
    });
    
    if(SecondOrPayorRider[0] == 'LCWP'){
		$('.fnPage35_LCWP').html('[' + a + ']');
		 a++;
		 
	}
	else if(SecondOrPayorRider[0] == 'SP_PRE'){
		$('.fnPage35_SPPRE').html('[' + a + ']');
		 a++;
	}    
}

function setPageDesc(page) {
    $('#rptVersion').html('Win MP (Trad) Version 6.7 (Agency) - Last Updated 03 October 2012 - E&amp;OE-');
    db.transaction(function(transaction) {
    	transaction.executeSql('select count(*) as pCount from SI_Temp_Pages', [], function(transaction, result) {
    		if (result != null && result.rows != null) {
    			var row = result.rows.item(0);
    			$('.totalPages').html(row.pCount);
    		}
    	}, errorHandler);
    }, errorHandler, nullHandler);
                   
    sPage = page
    db.transaction(function(transaction) {
    	transaction.executeSql("Select PageNum from SI_Temp_Pages where htmlName = '" + sPage + "'", [], function(transaction, result) {
    		if (result != null && result.rows != null) {
    			var row = result.rows.item(0);
    			$('.currentPage').html(row.PageNum);
    		}
    	}, errorHandler);
    }, errorHandler, nullHandler);
    
    db.transaction(function(transaction) {
	    transaction.executeSql("Select agentName,agentCode from agent_profile LIMIT 1", [], function(transaction, result) {
	    	if (result != null && result.rows != null) {
	    		var row = result.rows.item(0);
	    		$('#agentName').html(row.agentName);
	    		$('#agentCode').html(row.agentCode);
	    	}
	    }, errorHandler);
	}, errorHandler, nullHandler);
}

function writeInvestmentScenarios() {
    //alert("aaa")
    if (gdata.SI[0].QuotationLang == "Malay") {
        $('.investmentScenarios').html('<table id="table-notes"><tr><td width="50%" valign="top">&nbsp;</td><td width="50%" valign="top">Illustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :<br/>1. Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.75% setiap tahun<br/>2. Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.75% setiap tahun<br/>&nbsp;&nbsp;&nbsp;&nbsp;<br/><div style="width:500px;height:15px;border:2px solid black;padding: 1px 0px 0px 0px">Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</div></td></tr></table>');
    } else // English
    {
        $('.investmentScenarios').html('<table id="table-notes"><tr><td width="50%" valign="top">&nbsp;</td><td width="50%" valign="top">The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.75% every year<br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.75% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/><div style="width:500px;height:15px;border:2px solid black;padding: 1px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment performance.<br/></div></td></tr></table>');
    }
}

function writeInvestmentScenariosRight() {
    if (gdata.SI[0].QuotationLang == "Malay") {
        $('.investmentScenariosRight').html('Illustrasi ini menunjukkan jangkaan tahap faedah berdasarkan dua senario pelaburan :<br/>1. Senario A (Sce. A) = Anggapan dana penyertaan memperolehi 6.50% setiap tahun<br/>2. Senario B (Sce. B) = Anggapan dana penyertaan memperolehi 4.50% setiap tahun<br/>&nbsp;&nbsp;&nbsp;&nbsp;<br/><div style="width:380px;height:20px;border:2px solid black;padding: 5px 0px 0px 5px">Terjamin = Minimum yang akan anda perolehi tanpa bergantung kepada pencapaian pelaburan syarikat.</div>');
    } else // English
    {
        $('.investmentScenariosRight').html('The Illustration show the possible level of benefits you may expect on two investment scenarios :<br/>1. Scenario A (Sce. A) = Assumes the participating fund earns 6.50% every year<br/>2. Scenario B (Sce. B) = Assumes the participating fund earns 4.50% every year<br/>&nbsp;&nbsp;&nbsp;&nbsp;<br/><div style="width:335px;height:20px;border:2px solid black;padding: 5px 0px 0px 5px">Guaranteed = Minimum you will receive regardless of the Company investment performance.</div>');
    }
}

function formatCurrency(num) {
    if (num == "-") return "-"
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
}

function CurrencyNoCents(num) {
    if (num == "-") return "-";
    
    if (typeof num == 'string') {
   	 	val = num.replace(/\$|\,/g, '');
   	 	
   	 	cent = val.indexOf(".");
   	 	if (cent > 0) {
   	 		val = val.substring(0, cent);
   	 	}
   	} else {
   		val = num.toString().replace(/\$|\,/g, '');
   	}
    if (isNaN(val)) val = "0";
    sign = (val == (val = Math.abs(val)));
    val = val.toString();
    for (var i = 0; i < Math.floor((val.length - (1 + i)) / 3); i++) {
    	val = val.substring(0, val.length - (4 * i + 3)) + ',' + val.substring(val.length - (4 * i + 3));
    }
    
    return (((sign) ? '' : '-') + '' + val);
}

function gup(name) {
	name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
	var regexS = "[\\?&]" + name + "=([^&#]*)";
	var regex = new RegExp(regexS);
	var results = regex.exec(window.location.href);
	if (results == null) return "";
	else return results[1];
}