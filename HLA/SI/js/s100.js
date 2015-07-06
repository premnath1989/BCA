var maxRowCount = 14;

function onBodyLoad(){
	$.ajaxSetup({ cache: false });		
	$.ajax({
		url: 'SI.json',
		async: false,
		dataType: 'json',
		success: function (data) {
			gdata = data;
			
			for(j=0;j<data.SI[0].SI_Temp_Pages.data.length;j++)
			{
				row = gdata.SI[0].SI_Temp_Pages.data[j];
				if (row.PageDesc != "Page1")
				{
					if (row.PageDesc == "Page2")
						htmlPages = '<div id="' + row.PageDesc + '" style="margin-top:900px;padding: 15px 0px 0px 0px;"></div>';
					else
						htmlPages = '<div id="' + row.PageDesc + '" style="margin-top:900px;padding: 15px 0px 0px 0px;"></div>';
					$(htmlPages).appendTo('#externalPages');
				}
			}  		
	
			for(j=0;j<data.SI[0].SI_Temp_Pages.data.length;j++)
			{
				row = gdata.SI[0].SI_Temp_Pages.data[j];
				$.ajax({
					url: "SI/" + row.htmlName,
					async: false,
					dataType: 'html',
					success: function (data) {
						$("#" + row.PageDesc).html(data);
					}
				});
			}
	
			loadJson();
		}
	});	
}
	
function setRiderText()
{
	if (document.getElementById('Page2withRiders') != null) {
   		document.getElementById('Page1withRiders').style.display= "none";
		document.getElementById('Page1Figures').style.display= "none";
		document.getElementById('Page1SubjectTo').style.display= "none";
	} else {
		if ( gdata.SI[0].Trad_Rider_Details.data.length == 0 )
		{
   			document.getElementById('Page1withRiders').style.display= "none";
		}
	}
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

function loadDataToTable() {
	var col5Total = 0.00;
	var col6Total = 0.00;
	var col7Total = 0.00;
	var col8Total = 0.00;	
	var col5Total1 = 0;
	var col6Total1 = 0;
	var col7Total1 = 0;
	var col8Total1 = 0;

	var showHLoading = false;
	var showOccLoading = false;
	
	var totalPremiumText;
	if (gdata.SI[0].QuotationLang == "Malay") {
		totalPremiumText = "Jumlah Bayaran Premium";
	} else {
		totalPremiumText = "Total Premium";
	}
	
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		if(row.col9 == '' || row.col9 == '0.00'){}
		else{
			showHLoading = true;
		}
	
		if(row.col10 == '' || row.col10 == '0.00'){}
		else{
			showOccLoading = true;
		}
	});
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		col5Total1 = parseFloat(col5Total1) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total1 = parseFloat(col6Total1) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total1 = parseFloat(col7Total1) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total1 = parseFloat(col8Total1) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
	});
	
	var title;
	//     var data = reformatTradDetailsData();
	var data = gdata.SI[0].SI_Temp_Trad_Details.data;
	var tableName = "table-data";
	var hLoading = "hLoading";
	var occLoading = "occLoading";
	var rowCount = 1;
	var isSecondPage = false;
	$.each(data, function(index, row) {
		col5Total = parseFloat(col5Total) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total = parseFloat(col6Total) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total = parseFloat(col7Total) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total = parseFloat(col8Total) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
		title = validateAndAddSpace(row.col0_1);		
		rowCount++;
		if (title.length > 32) {
			rowCount = rowCount++;
		}
		
		if(!isSecondPage && rowCount >= maxRowCount){
			tableName = "table-dataPage2";
			hLoading = "hLoading2";
			occLoading = "occLoading2";
			isSecondPage = true;
		}
		if(!showHLoading){
			if(!showOccLoading){
				addPlanRowNoHLNoOccL(index, row, hLoading, occLoading, tableName, title, col6Total1, col7Total1, col8Total1);
			}
			else{
				addPlanRowNoHL(index, row, hLoading, tableName, title, col6Total1, col7Total1, col8Total1);
			}
		} else {			
			if(showOccLoading == false){
				addPlanRowNoOccL(index, row, occLoading, tableName, title, col6Total1, col7Total1, col8Total1);
			} else {
				addPlanRow (index, row, tableName, title, col6Total1, col7Total1, col8Total1);
			}
		}
	});
	
	$('#' + tableName + '> tfoot').append(
		'<tr>' + 
		'<td colspan ="12"><hr/></td>' + 
		'</tr>' +
		'<tr>' + 
		'<td colspan="4"></td>' + 
		'<td colspan="2" style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
		'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' +
		'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
		'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' +
		'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total1) + '</b></td>' +
		'<td></td>' + 
		'<td></td>' + 
		'</tr>' +
		'<tr>' + 
		'<td colspan ="12"><hr/></td>' + 
		'</tr>');
}

function addPlanRowNoHLNoOccL(index, row, hLoading, occLoading, tableName, title, col6Total1, col7Total1, col8Total1) {
	document.getElementById(hLoading).innerHTML = "";
	document.getElementById(hLoading).style.width = "5px";
	document.getElementById(occLoading).innerHTML = "";
	document.getElementById(occLoading).style.width = "5px";
	$('#' + tableName + '> tbody').append(
		'<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col1) + '</td>' +
		'<td>' + formatCurrency(row.col2) + '</td>'  +
		'<td>' + replaceChar(row.col3) + '</td>' + 
		'<td>' + replaceChar(row.col4) + '</td>' + 
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td></td>' +
		'<td></td>' +
		'</tr>');
}
var a = false;
function addPlanRowNoHL(index, row, hLoading, tableName, title, col6Total1, col7Total1, col8Total1) {
	document.getElementById(hLoading).innerHTML = ('');
	document.getElementById(hLoading).style.width = "5px";
	$('#' + tableName + '> tbody').append(
		'<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col1) + '</td>' +
		'<td>' + formatCurrency(row.col2) + '</td>'  +
		'<td>' + replaceChar(row.col3) + '</td>' + 
		'<td>' + replaceChar(row.col4) + '</td>' + 
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + 
		'<td></td>' +
		'<td>' + row.col10 + '</td>' + 
		'</tr>');
}
	
function addPlanRowNoOccL(index, row, occLoading, tableName, title, col6Total1, col7Total1, col8Total1) {
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
	document.getElementById(occLoading).innerHTML = ('');
	document.getElementById(occLoading).style.width = "5px";
	$('#' + tableName + '> tbody').append(
		'<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col1) + '</td>' +
		'<td>' + formatCurrency(row.col2) + '</td>'  +
		'<td>' + replaceChar(row.col3) + '</td>' + 
		'<td>' + replaceChar(row.col4) + '</td>' + 
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + 
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td>' +
		'<td></td>' +
		'</tr>');
}

function addPlanRow (index, row, tableName, title, col6Total1, col7Total1, col8Total1) {
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
	$('#' + tableName + '> tbody').append(
		'<tr>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col0_2) + '</td>' +
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + replaceChar(row.col1) + '</td>' +
		'<td>' + formatCurrency(row.col2) + '</td>'  +
		'<td>' + replaceChar(row.col3) + '</td>' + 
		'<td>' + replaceChar(row.col4) + '</td>' + 
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + 
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td>' +
		'<td>' + row.col10 + '</td>' + 
		'</tr>');
}

function loadS100Page1_2()
{		
	var result = gdata.SI[0].SI_Temp_trad_LA.data;

	var col5Total, col6Total, col7Total, col8Total;
	col5Total = 0.00;
	col6Total = 0.00;
	col7Total = 0.00;
	col8Total = 0.00;

	var showHLoading = false;
	var showOccLoading = false;
		
	var totalPremiumText;
	if (gdata.SI[0].QuotationLang == "Malay")
	{
		totalPremiumText = "Jumlah Bayaran Premium";
	} else {
		totalPremiumText = "Total Premium";
	}
	
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		if(parseInt(index) > 13){
			if(row.col9 == '' || row.col9 == '0.00'){}
			else{
				showHLoading = true;
			}
		
			if(row.col10 == '' || row.col10 == '0.00'){}
			else{
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
	var title;
	var data = reformatTradDetailsData();
	$.each(data, function(index, row) {
		col5Total = parseFloat(col5Total) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total = parseFloat(col6Total) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total = parseFloat(col7Total) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total = parseFloat(col8Total) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
		if (row.col0_1.indexOf("-") == 0) {
			title = "&nbsp;&nbsp;"+row.col0_1;
		} else {
			title = row.col0_1;
		}
		if(parseInt(index) > 13){
			if(!showHLoading){
				if(!showOccLoading){
					document.getElementById('hLoading2').innerHTML = ('');						
					document.getElementById('occLoading2').innerHTML = ('');
					document.getElementById('dynamic').setAttribute('colspan', '3');
					$('#table-dataPage2 > tbody').append(
						'<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
						'<td>' + replaceChar(row.col3) + '</td>' + 
						'<td>' + replaceChar(row.col4) + '</td>' + 
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
						'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
						'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
						'</tr>');
				}
				else{
					document.getElementById('hLoading2').innerHTML = ('');
					document.getElementById('dynamic').setAttribute('colspan', '3');
					$('#table-dataPage2 > tbody').append(
						'<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
						'<td>' + replaceChar(row.col3) + '</td>' + 
						'<td>' + replaceChar(row.col4) + '</td>' + 
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
						'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
						'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' + 
						'<td></td>' + 
						'<td>' + row.col10 + '</td>' + 
						'</tr>');
				}
			} else {
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
					document.getElementById('dynamic').setAttribute('colspan', '3');
					$('#table-dataPage2 > tbody').append(
						'<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
						'<td>' + replaceChar(row.col3) + '</td>' + 
						'<td>' + replaceChar(row.col4) + '</td>' + 
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + 
						'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
						'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
						'<td>' + HL + '</td>' +
						'</tr>');
				} else {
					document.getElementById('dynamic').setAttribute('colspan', '3');
					$('#table-dataPage2 > tbody').append(
						'<tr>' +
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + title + '</td>' +
						'<td>' + replaceChar(row.col3) + '</td>' + 
						'<td>' + replaceChar(row.col4) + '</td>' + 
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' + 
						'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
						'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
						'<td>' + HL + '</td>' +
						'<td>' + row.col10 + '</td>' + 
						'</tr>');
				}
			}
		}
		i++;
	});
	
	if(parseInt(gdata.SI[0].SI_Temp_Trad_Details.data.length) > 13){		
		if(showHLoading == false){	
			if(showOccLoading == false){
				$('#table-dataPage2 > tfoot').append(
					'<tr>' + 
					'<td colspan ="9"><hr/></td>' + 
					'</tr>' +
					'<tr>' + 
					'<td></td>' + 
					'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
					'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' +
					'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
					'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' +
					'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
					'</tr>' +
					'<tr>' + 
					'<td colspan ="9"><hr/></td>' + 
					'</tr>');
			} else{
				$('#table-dataPage2 > tfoot').append(
					'</tr>' +
					'<tr>' +  
					'<td colspan ="9"><hr/></td>' + 
					'</tr>' +
					'<tr>' +
					'<td></td>' + 
					'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
					'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' +
					'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
					'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + 
					'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
					'<td>&nbsp;</td>' + 
					'</tr>' +
					'<tr>' + 
					'<td colspan ="9"><hr/></td>' +
					'</tr>');
			}
		} else {
			if(showOccLoading == false){
				$('#table-dataPage2 > tfoot').append(
					'</tr>' +
					'<tr>' + 
					'<td colspan ="8"><hr/></td>' +
					'</tr>' + 
					'<tr>' + 
					'<td></td>' + 
					'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
					'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + 
					'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
					'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + 
					'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
					'<td>&nbsp;</td>' + 
					'</tr>' + 
					'<tr>' +
					'<td colspan ="8"><hr/></td>' + 
					'</tr>');    
			} else{
				$('#table-dataPage2 > tfoot').append(
					'</tr>' +
					'<tr>' + 
					'<td colspan ="8"><hr/></td>' +
					'</tr>' + 
					'<tr>' + 
					'<td></td>' + 
					'<td colspan=2 style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
					'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' +
					'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
					'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' + 
					'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total) + '</b></td>' +
					'<td>&nbsp;</td>' + 
					'<td>&nbsp;</td>' + 
					'</tr>' +
					'<tr>' +
					'<td colspan ="9"><hr/></td>' +
					'</tr>');
			}
		}
	}  
}

function addPlanDesc() {
	// should dynamic check for premium instead of hardcode
	temp = gdata.SI[0].SI_Temp_Trad_Details.data[0].col4;		
	if (gdata.SI[0].QuotationLang == "Malay") {
		if (temp == "10" || temp == "15" || temp == "20") {
			$('.planDetailText').html("Tempoh Pembayaran Premium Terhad "+gdata.SI[0].SI_Temp_Trad_Details.data[0].col4+" Tahun");
		} else {		
			$('.planDetailText').html("Tempoh Pembayaran Premium Sepanjang Tempoh Polisi");
		}
	} else {		
		if (temp == "10" || temp == "15" || temp == "20") {			
			$('.planDetailText').html("Limited "+gdata.SI[0].SI_Temp_Trad_Details.data[0].col4+" Years Premium Payment Term");
		} else {		
			$('.planDetailText').html("Premium Payable for Whole Policy Term");
		}
	}
}

function writeFootnote_S100(){
    var a = 1;
    var fnPage35_ACIR = false;
    var fnPage2_ACIR = false;
    var fnPage2_LCPR = false;
    var fnPage2_GCP = false;
    var SecondOrPayorRider = [];     
    
    // page 2
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {     
        if(row.RiderCode == 'ACIR_MPP' ){  
			$('.fnPage2_ACIR').html('[' + a + ']');
			a++;
        }   
        else if(row.RiderCode == 'C+' && (row.PlanOption.indexOf("_NCB") == row.PlanOption.length - 4)) {
			fnPage2_GCP = true;
			$('.fnPage2_GCP').html('[' + a + ']');
			a++;
        }
        else if(row.RiderCode == 'LCPR'){
        	fnPage2_LCPR = true;
        	$('.fnPage2_LCPR').html('[' + a + ']');
        	a++;
        }
        
    });    
    $('.S100_Page2').html('[' + a + ']');
    a++;
    // page 35
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {      
        if(row.RiderCode == 'ACIR_MPP' ){  
        	fnPage35_ACIR = true;
			$('.fnPage35_ACIR').html('[' + a + ']');
			a++;
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
	
    if(AddRow > benefitPage1Limit) {
        document.getElementById('footnoteDetails1').style.display  = "none";        
        if(fnPage35_ACIR ){
            document.getElementById('fnPageBenefit2_ACIR').style.display  = "";
        }
        
        if(fnPage2_LCPR){
            document.getElementById('fnPageBenefit2_LCPR').style.display = "";
        }    
        
        if (fnPage2_GCP) {
            document.getElementById('fnPageBenefit2_GCP').style.display = "";
        }
    }
    else{        
        if(fnPage35_ACIR){
            document.getElementById('fnPageBenefit1_ACIR').style.display  = "";
        }        
        
        if(fnPage2_LCPR){
            document.getElementById('fnPageBenefit1_LCPR').style.display = "";
        }    
        
        if (fnPage2_GCP) {
            document.getElementById('fnPageBenefit1_GCP').style.display = "";
        }
    }
}
