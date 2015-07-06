var maxRowCount = 13;

function onBodyLoad() {
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
			
			var page;
			for(j=0;j<data.SI[0].SI_Temp_Pages.data.length;j++)
			{
				row = gdata.SI[0].SI_Temp_Pages.data[j];
				page = row.htmlName;
				
				if(page=='eng_HLAWP_PageWPRiders_1.html' || page=='eng_HLAWP_PageWPRiders_2.html')
				{
					page = page + '?rider=' + row.riders;
				}
				
				$.ajax({
					url: "SI/" + page,
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

function loadDataToTable() {	
	var col1str;
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
	
	var LACount = gdata.SI[0].SI_Temp_trad_LA.data.length;
	
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		if(row.col9 == '' || row.col9 ==  '0.00'){
		}
		else{
			showHLoading = true;
		}
	
		if(row.col10 == ''){
		}
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
	
	var tableName = "table-data";
	var hLoading = "hLoading";
	var occLoading = "occLoading";
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		col5Total = parseFloat(col5Total) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total = parseFloat(col6Total) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total = parseFloat(col7Total) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total = parseFloat(col8Total) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));		
		col1str = validateAndAddSpace(row.col0_1);
		if(index == maxRowCount){
			tableName = "table-dataPage2";
			hLoading = "hLoading2";
			occLoading = "occLoading2";
		}
		
		if(showHLoading == false){
			if(showOccLoading == false){
				addPlanRowNoHLNoOccL(index, row, hLoading, occLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount);
			} else{ 
				addPlanRowNoHL(index, row, hLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount);
			}
		} else{		
			if(showOccLoading == false){
				addPlanRowNoOccL(index, row, occLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount);
			} else{
				addPlanRow (index, row, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount);
			}
		}
	});
	
	$('#' + tableName + '> tfoot').append('<tr><td colspan ="9"><hr/></td></tr>' +
	'<tr>' + 
	'<td></td>' +
	'<td colspan="2" style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText +'</b></td>' +
	'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' + 
	'<td><b>' + showDashOrValue("s",formatCurrency(col6Total.toFixed(2)),col6Total1) + '</b></td>' +
	'<td><b>' + showDashOrValue("q",formatCurrency(col7Total.toFixed(2)),col7Total1) + '</b></td>' +
	'<td><b>' + showDashOrValue("m",formatCurrency(col8Total.toFixed(2)),col8Total1) + '</b></td>' +
	'<td colspan="2"></td>' +
	'</tr><tr><td colspan ="9"><hr/></td></tr>');
}


function addPlanRowNoHLNoOccL (index, row, hLoading, occLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount) {
	document.getElementById(hLoading).innerHTML = "";
	document.getElementById(hLoading).style.width = "5px";
	document.getElementById(occLoading).innerHTML = "";
	document.getElementById(occLoading).style.width = "5px";
	if(LACount == 1){
		if(row.col0_1 == 'HLA Wealth Plan'){
			$('#' + tableName + '> tbody').append('<tr>' + 
			'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + row.col0_1 + '</td>' +
			'<td>' + row.col3 + '</td>' +
			'<td>' + row.col4 + '</td>' +
			'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
			'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
			'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
			'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
			'<td></td>' +
			'<td></td>' +
			'</tr>');
		} else {							
			$('#' + tableName + '> tbody').append('<tr>' + 
			'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(col1str) + '</td>' +
			'<td>' + row.col3 + '</td>' +
			'<td>' + row.col4 + '</td>' +
			'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
			'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
			'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
			'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
			'<td></td>' +
			'<td></td>' +
			'</tr>');
		}
	} else{
		if(row.col0_1 == 'HLA Wealth Plan'){
			$('#' + tableName + '> tbody').append('<tr>' + 
			'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + row.col0_1 + '</td>' +
			'<td>' + row.col3 + '</td>' +
			'<td>' + row.col4 + '</td>' +
			'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
			'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
			'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
			'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
			'<td></td>' +
			'<td></td>' +
			'</tr>');
		} else{
			$('#' + tableName + '> tbody').append('<tr>' + 
			'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(col1str) + '</td>' +
			'<td>' + row.col3 + '</td>' +
			'<td>' + row.col4 + '</td>' +
			'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
			'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
			'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
			'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
			'<td></td>' +
			'<td></td>' +
			'</tr>');
		}						    
	}
}

function addPlanRowNoHL (index, row, hLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount) {
	document.getElementById(hLoading).innerHTML = "";
	document.getElementById(hLoading).style.width = "5px";
	if(LACount == 1){
		$('#' + tableName + '> tbody').append(
		'<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' +
		'<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td></td>' +
		'<td>' + row.col10 + '</td>' + 
		'</tr>');
	} else{
		$('#' + tableName + '> tbody').append('<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' +
		'<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td></td>' +
		'<td>' + row.col10 + '</td>' +
		'</tr>');
	}
}

function addPlanRowNoOccL (index, row, occLoading, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount) {
	var HL;
	if(parseInt(row.col9) > 0){
		if(row.col9 % 1 == 0){
			HL = parseInt(row.col9);
		} else {
			HL = row.col9;
		}
	} else{
		HL = "";
	}
			
	document.getElementById(occLoading).innerHTML = "";
	document.getElementById(occLoading).style.width = "5px";
	if(LACount == 1){
		$('#' + tableName + '> tbody').append('<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' +
		'<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td>' + 
		'<td></td>' +
		'</tr>');
	} else{
		$('#' + tableName + '> tbody').append('<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' +
		'<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td>' + 
		'<td></td>' +
		'</tr>');
	}
}

function addPlanRow (index, row, tableName, col6Total1, col7Total1, col8Total1, col1str, LACount) {
	var HL;
	if(parseInt(row.col9) > 0){
		if(row.col9 % 1 == 0){
			HL = parseInt(row.col9);
		} else {
			HL = row.col9;
		}
	} else{
		HL = "";
	}

	if(LACount == 1){ 
		$('#' + tableName + '> tbody').append('<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td><td>' + row.col10 + '</td>' + 
		'</tr>');
	} else{
		$('#' + tableName + '> tbody').append('<tr>' + 
		'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(col1str) + '</td>' +
		'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' +
		'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
		'<td id=row1col6>' + showDashOrValue("s",formatCurrency(row.col6),col6Total1) + '</td>' +
		'<td id=row1col7>' + showDashOrValue("q",formatCurrency(row.col7),col7Total1) + '</td>' +
		'<td id=row1col8>' + showDashOrValue("m",formatCurrency(row.col8),col8Total1) + '</td>' +
		'<td>' + HL + '</td><td>' + row.col10 + '</td>' + 
		'</tr>');
	}
}

function loadHLAWPPage1_2()
{
    var result = gdata.SI[0].SI_Temp_trad_LA.data;
    
	var col5Total, col6Total, col7Total, col8Total;
	col5Total = 0.00;
	col6Total = 0.00;
	col7Total = 0.00;
	col8Total = 0.00;

	var showHLoading = false;
	var showOccLoading = false;
	
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
	  
		if(index  + parseInt(AddRow) > 13){
			if(row.col9 != '' && row.col9 != '0.00'){
				showHLoading = true;
			}
  
			if(row.col10 != '' && row.col10 != '0.00'){
				showOccLoading = true;
			}
		}
	});
	
	var totalPremiumText;
	if (gdata.SI[0].QuotationLang == "Malay")
	{
		totalPremiumText = "Jumlah Bayaran Premium";
	} else {
		totalPremiumText = "Total Premium";
	}
	
	$.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, row) {
		col5Total = parseFloat(col5Total) + parseFloat((row.col5).replace(/,/g,'').replace('-', '0'));
		col6Total = parseFloat(col6Total) + parseFloat((row.col6).replace(/,/g,'').replace('-', '0'));
		col7Total = parseFloat(col7Total) + parseFloat((row.col7).replace(/,/g ,'').replace('-', '0'));
		col8Total = parseFloat(col8Total) + parseFloat((row.col8).replace(/,/g,'').replace('-', '0'));
		
		if(index > maxRowCount){
			if(showHLoading == false){				  
			  if(showOccLoading == false){					
					document.getElementById('hLoading2').innerHTML = "";
					document.getElementById('hLoading2').style.width = "5px";
					document.getElementById('occLoading2').innerHTML = "";
					document.getElementById('occLoading2').style.width = "5px";
				
					if(result.length == 1){
						if(row.col0_1 == 'HLA Wealth Plan'){							  
							$('#table-dataPage2 > tbody').append('<tr>' + 
							'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + row.col0_1 + '</td>' +
							'<td>' + row.col3 + '</td>' +
							'<td>' + row.col4 + '</td>' +
							'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
							'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
							'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
							'<td></td>' + 
							'<td></td>' +
							'</tr>');
						} else{							  
							$('#table-dataPage2 > tbody').append('<tr>' +
							'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(row.col0_1) + '</td>' +
							'<td>' + row.col3 + '</td>' +
							'<td>' + row.col4 + '</td>' +
							'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
							'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
							'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
							'<td></td>' + 
							'<td></td>' +
							'</tr>');
						}							
					} else {							
						if(row.col0_1 == 'HLA Wealth Plan'){
							$('#table-dataPage2 > tbody').append('<tr>' + 
							 '<td style="text-align:left;padding: 0px 0px 0px 0px;">' + row.col0_1 + '</td>' +
							'<td>' + row.col3 + '</td>' +
							'<td>' + row.col4 + '</td>' +
							'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
							'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
							'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
							'<td></td>' +
							'<td></td>' +
							'</tr>');
						} else {
							$('#table-dataPage2 > tbody').append('<tr>' + 
							'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(row.col0_1) + '</td>' +
							'<td>' + row.col3 + '</td>' +
							'<td>' + row.col4 + '</td>' +
							'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
							'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
							'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
							'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
							'<td></td>' +
							'<td></td>' +
							'</tr>');
						}							
					}
			  } else { //occloading == true, hl == false						
					document.getElementById('hLoading2').innerHTML = "";
					document.getElementById('hLoading2').style.width = "5px";
					if(result.length == 1){
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' +
						'<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td></td>' + 
						'<td>' + row.col10 + '</td>' + 
						'</tr>');
					} else {
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' +
						'<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td></td>' +
						'<td>' + row.col10 + '</td>' + 
						'</tr>');
					}
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
					document.getElementById('occLoading2').innerHTML = "";
					document.getElementById('occLoading2').style.width = "5px";
					if(result.length == 1){
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' +
						'<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td>' + HL + '</td>' +
						'<td></td>' + 
						'</tr>');
					} else {
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' +
						'<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td>' + HL + '</td>' +
						'<td></td>' + 
						'</tr>');
					}
				} else {
					if(result.length == 1){ 
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 5px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td>' + HL + '</td>' + 
						'<td>' + row.col10 + '</td>' + 
						'</tr>');
					} else {
						$('#table-dataPage2 > tbody').append('<tr>' + 
						'<td style="text-align:left;padding: 0px 0px 0px 0px;">' + needItalic(row.col0_1) + '</td>' +
						'<td>' + row.col3 + '</td>' + '<td>' + row.col4 + '</td>' +
						'<td><span id=row' + index + 'col5>' + formatCurrency(row.col5) + '</span></td>' +
						'<td id=row1col6>' + formatCurrency(row.col6) + '</td>' +
						'<td id=row1col7>' + formatCurrency(row.col7) + '</td>' +
						'<td id=row1col8>' + formatCurrency(row.col8) + '</td>' +
						'<td>' + HL + '</td>' +
						'<td>' + row.col10 + '</td>' +
						'</tr>');
					}
				}
			}
			i++;
		}
	  
	});
	
	$('#table-dataPage2 > tfoot').append('<tr><td colspan ="9"><hr/></td></tr>' +
	'<tr>' +
	'<td></td>' +
	'<td colspan="2" style="text-align:right;padding: 0px 0px 0px 0px;"><b>' + totalPremiumText + '</b></td>' +
	'<td><b>' + formatCurrency(col5Total.toFixed(2)) + '</b></td>' +
	'<td><b>' + formatCurrency(col6Total.toFixed(2)) + '</b></td>' +
	'<td><b>' + formatCurrency(col7Total.toFixed(2)) + '</b></td>' +
	'<td><b>' + formatCurrency(col8Total.toFixed(2)) + '</b></td>' +
	'<td colspan="2" ></td>' +
	'</tr><tr><td colspan ="9"><hr/></td></tr>');
	
}

function writeHLAWP_Summary() {
    
    $('.TotPremPaid2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid2));
    $('.SurrenderValueHigh2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh2));
    $('.SurrenderValueLow2').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow2));
    
    $('.TotPremPaid1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotPremPaid1));
    $('.SurrenderValueHigh1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueHigh1));
    $('.SurrenderValueLow1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].SurrenderValueLow1));
    $('.TotYearlyIncome1').html(formatCurrency(gdata.SI[0].SI_Temp_Trad_Overall.data[0].TotYearlyIncome1));
    
    var tempTitle = "HLA Wealth Plan";
    var tempTitle2;
    var note2;
    
    if(WBRider == true && WBi6 == true && WBd10 ==  true && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){

            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider, Wealth Booster-<i>d10</i> Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai ";
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun), Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }            
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider, Wealth Booster-<i>d10</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years), Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";    
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";    
            }
        }        
    }
    else if(WBRider == true && WBi6 == true && WBd10 ==  true && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Kupon Tunai Tahunan ";
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun), Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years), Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";    
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";    
            }            
        }        
    }
    else if(WBRider == true && WBi6 == true && WBd10 ==  false && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun), Wealth Booster-<i>i6</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }            
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>i6</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years), Wealth Booster-<i>i6</i> Rider at year 30 and EduWealth Rider at year " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider at year 30 and EduWealth Rider at year " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }            
        }        
    }
    else if(WBRider == true && WBi6 == true && WBd10 ==  false && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider dan Wealth Booster-<i>i6</i> Rider ";
            tempTitle2 = "Kupon Tunai Tahunan";
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun) tamat pada tahun 30, Wealth Booster-<i>i6</i> Rider, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider and Wealth Booster-<i>i6</i> Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years), Wealth Booster-<i>i6</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
        }        
    }
    else if(WBRider == true && WBi6 == false && WBd10 ==  true && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>d10</i> Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";    
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun) dan Wealth Booster-<i>d10</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>d10</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider, Wealth Booster-<i>d10</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years), and Wealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
        }        
    }
    else if(WBRider == true && WBi6 == false && WBd10 ==  true && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider dan Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Kupon Tunai Tahunan";    
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun), Wealth Booster-<i>d10</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh Wealth Booster-<i>d10</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider and Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years) and Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";            
            }
            else
            {
                note2 = "Upon expiry of Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";            
            }
        }        
    }
    else if(WBRider == true && WBi6 == false && WBd10 ==  false && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";    
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun) tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "Apabila tempoh EduWealth Rider tamat pada tahun " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years) at year 30 and EduWealth Rider at year " +
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
            else
            {
                note2 = "Upon expiry of EduWealth Rider at year " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
        }        
    }
    else if(WBRider == true && WBi6 == false && WBd10 ==  false && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + " dan Wealth Booster Rider ";
            tempTitle2 = "Kupon Tunai Tahunan";    
            
            if(WB30Rider == true){
                note2 = "Apabila tempoh Wealth Booster Rider (30 tahun), Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else
            {
                note2 = "";
            }            
        }
        else{
            tempTitle = tempTitle + " and Wealth Booster Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            
            if(WB30Rider == true){
                note2 = "Upon expiry of Wealth Booster Rider (30 years) at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }
            else
            {
                note2 = "";
            }
        }        
    }
    else if(WBRider == false && WBi6 == true && WBd10 ==  true && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider, Wealth Booster-<i>d10</i> Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";    
            
            note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Ridertamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";            
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider, Wealth Booster-<i>d10</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " + 
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out."
        }        
    }
    else if(WBRider == false && WBi6 == true && WBd10 == true && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Kupon Tunai Tahunan";    
            
            note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider dan Wealth Booster-<i>d10</i> Ridertamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider and Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == true && WBd10 == false && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider dan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";
            
            note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " + 
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";            
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster-<i>i6</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider at year 30 and EduWealth Rider at year " + 
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == true && WBd10 == false && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + " dan Wealth Booster-<i>i6</i> Rider";
            tempTitle2 = "Kupon Tunai Tahunan";    
         
            note2 = "Apabila tempoh Wealth Booster-<i>i6</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";   
        }
        else{
            tempTitle = tempTitle + " and Wealth Booster-<i>i6</i> Rider ";
            tempTitle2 = "Yearly Cash Coupons";
            note2 = "Upon expiry of Wealth Booster-<i>i6</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == false && WBd10 == true && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + ", Wealth Booster-<i>d10</i> Riderdan EduWealth Rider ";
            tempTitle2 = "Kupon Tunai Tahunan & Bayaran Tunai";
            
            note2 = "Apabila tempoh Wealth Booster-<i>d10</i> Rider tamat pada tahun 30 dan EduWealth Rider tamat pada tahun " +
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            
        }
        else{
            tempTitle = tempTitle + ", Wealth Booster-<i>d10</i> Rider and EduWealth Rider ";
            tempTitle2 = "Yearly Cash Coupons & Cash Payments";
            note2 = "Upon expiry of WWealth Booster-<i>d10</i> Rider at year 30 and EduWealth Rider at year " +
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == false && WBd10 == true && EduWB == false ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + " dan Wealth Booster-<i>d10</i> Rider  ";
            tempTitle2 = "Kupon Tunai Tahunan";    
            
            note2 = "Apabila tempoh Wealth Booster-<i>d10</i> Rider tamat pada tahun 30, Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
        }
        else{
            tempTitle = tempTitle + " and Wealth Booster d10 Rider  ";
            tempTitle2 = "Yearly Cash Coupons";
            note2 = "Upon expiry of Wealth Booster-<i>d10</i> Rider at year 30, the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == false && WBd10 == false && EduWB ==  true ){
        if(gdata.SI[0].QuotationLang == "Malay"){
            tempTitle = tempTitle + " dan EduWealth Rider ";
            tempTitle2 = "Bayaran Tunai";    
            
            note2 = "Apabila tempoh EduWealth Rider tamat pada tahun " +
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
        }
        else{
            tempTitle = tempTitle + " and EduWealth Rider ";
            tempTitle2 = "Cash Payments";
            note2 = "Upon expiry of EduWealth Rider at year " +
            (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
        }        
    }
    else if(WBRider == false && WBi6 == false && WBd10 == false && EduWB == false ){
        
        tempTitle2 = "";
        document.getElementById("Page2_total").style.display = "none";
    }
        
    $('.SummaryTitle').html(tempTitle);
    $('.WPRiderTitle').html(tempTitle2);
    
    if(parseInt(gdata.SI[0].Trad_Details.data[0].PolicyTerm) == 50){
        if(WB30Rider == true || EduWB ==  true || WBd10 || WBi6 ){
            $('.HLAWP_summary_Page3_note2').html('2. ' + note2);    
        }
        else{
            $('.HLAWP_summary_Page3_note2').html('');    
        }
    }
    else{
        if(EduWB ==  true){
            if(gdata.SI[0].QuotationLang == "Malay"){
                note2 = "Apabila tempoh EduWealth Rider tamat pada tahun " + 
                (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + ", Dividen Terminal bagi rider masing-masing dianggap telah dibayar.";
            }
            else{
               note2 = "Upon expiry of EduWealth Rider at year " +
               (21 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age) )  + " , the Terminal Dividend of the respective rider(s) is assumed to be paid out.";
            }            
            $('.HLAWP_summary_Page3_note2').html('2. ' + note2);
        }
        else
        {
            $('.HLAWP_summary_Page3_note2').html('');        
        }        
    }
    
    $.each(gdata.SI[0].SI_Temp_Trad_Summary.data, function(index, row) {
    	$('#table-SummaryHLAWP > tbody').append('<tr><td>' +
    		row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + formatCurrency(row.col1) + '</td><td>' + formatCurrency(row.col2) + '</td><td>' + formatCurrency(row.col3) + '</td><td>' +
    		formatCurrency(row.col4) + '</td><td>' + CurrencyNoCents(row.col5) + '</td><td>' + CurrencyNoCents(row.col6) + '</td><td>' + CurrencyNoCents(row.col7) + '</td><td>' +
    		CurrencyNoCents(row.col8) + '</td><td>' + CurrencyNoCents(row.col9) + '</td><td>' + CurrencyNoCents(row.col10) + '</td><td>' +
    		CurrencyNoCents(row.col11) + '</td></tr>');
            
		if (colType == 1) { // CD: ACC, GYI : Payout
			$('#table-SummaryHLAWP3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
				CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' +
				CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
		}
		else if (colType == 2) { // CD: ACC, GYI : ACC
			$('#table-SummaryHLAWP3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
				CurrencyNoCents(row.col14) + '</td><td>' + CurrencyNoCents(row.col15) + '</td><td>' + CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' +
				CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
		}
		else if (colType == 3) { // CD: Payout, GYI : Payout
			$('#table-SummaryHLAWP3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' +
				CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' + CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');   
		}
		else if (colType == 4) {  // CD: Payout, GYI : ACC
			   $('#table-SummaryHLAWP3 > tbody').append('<tr><td>' + row.col0_1 + '</td><td>' + row.col0_2 + '</td><td>' + CurrencyNoCents(row.col12) + '</td><td>' + CurrencyNoCents(row.col13) + '</td><td>' + 
			   CurrencyNoCents(row.col16) + '</td><td>' + CurrencyNoCents(row.col17) + '</td><td>' + CurrencyNoCents(row.col18) + '</td><td>' + CurrencyNoCents(row.col19) + '</td><td>' +
			   CurrencyNoCents(row.col20) + '</td><td>' + CurrencyNoCents(row.col21) + '</td></tr>');
		}
    });
}


function writeFootnote_HLAWP(){
    var a = 1;
    var fnPage2_GYCC = false;
    var fnPage2_GCP = false;
    var fnPage2_ACIR = false;
    var fnPage2_LCPR = false;
    var fnPage2_PLCP = false;
    var fnPage2_EDU = false;
    
    var fnPage35_GYCC = false;
    var fnPage35_GCP = false;
    var fnPage35_ACIR = false;
    var fnPage35_LCPR = false;
    
    var SecondOrPayorRider = []; 
    
    $('.fnPage2_PremiumPaid').html('[' + a + ']');
    a++;
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) { //for benefit table        
        if(row.RiderCode == 'ACIR'){
            $('.fnPage2_ACIR').html('[' + a + ']');
            a++;
            fnPage2_ACIR = true;
        }
        else if(row.RiderCode == 'C+' && (row.PlanOption.indexOf("_NCB") == row.PlanOption.length - 4)) {
			fnPage2_GCP = true;
			$('.fnPage2_GCP').append('[' + a + ']');
			a++;
        }
        else if(row.RiderCode == 'EDUWR'){
        	fnPage2_EDU = true;
        	$('.fnPage2_EDU').append('[' + a + ']');
        	a++;
        }
        else if(row.RiderCode == 'WB30R' || row.RiderCode == 'WB50R' || row.RiderCode == 'WBI6R30' || row.RiderCode == 'WBD10R30' ){
            if (fnPage2_GYCC == false){
                $('.fnPage2_GYCC').html('[' + a + ']');
                a++;
                fnPage2_GYCC = true;
            }
        }
        else if(row.RiderCode == 'LCPR' ){
            if (fnPage2_LCPR == false){
                $('.fnPage2_LCPR').html('[' + a + ']');
                a++;
                fnPage2_LCPR = true;
            }
        }
        else if(row.RiderCode == 'PLCP' ){
            if (fnPage2_PLCP == false){
                $('.fnPage2_PLCP').html('[' + a + ']');
                a++;
                fnPage2_PLCP = true;
            }
        }
    });
    
    if(AddRow >= benefitPage1Limit) {
        document.getElementById('footnoteDetails1').style.display  = "none";  
        
  	  	if(AddRow >= benefitPage2Limit){
        	document.getElementById('footnoteDetails2').style.display  = "none";  
			if(fnPage2_ACIR){
				document.getElementById('fnPageBenefit3_ACIR').style.display = "";
			}
	
			if(fnPage2_GYCC == true){
				document.getElementById('fnPageBenefit3_GYCC').style.display = "";
			}
	
			if(fnPage2_GCP == true){
				document.getElementById('fnPageBenefit3_GCP').style.display = "";
			}

			if(fnPage2_EDU == true){
				document.getElementById('fnPageBenefit2_EDU').style.display = "";
			}
	
			if(fnPage2_LCPR == true){
				document.getElementById('fnPageBenefit3_LCPR').style.display = "";
			}
	
			if(fnPage2_PLCP == true){
				document.getElementById('fnPageBenefit3_PLCP').style.display = "";
			}
  	  	} else {
			if(fnPage2_ACIR == true){
				document.getElementById('fnPageBenefit2_ACIR').style.display = "";
			}
	
			if(fnPage2_GYCC == true){
				document.getElementById('fnPageBenefit2_GYCC').style.display = "";
			}
	
			if(fnPage2_GCP == true){
				document.getElementById('fnPageBenefit2_GCP').style.display = "";
			}

			if(fnPage2_EDU == true){
				document.getElementById('fnPageBenefit2_EDU').style.display = "";
			}
	
			if(fnPage2_LCPR == true){
				document.getElementById('fnPageBenefit2_LCPR').style.display = "";
			}
	
			if(fnPage2_PLCP == true){
				document.getElementById('fnPageBenefit2_PLCP').style.display = "";
			}
		}
    } else {
		if(fnPage2_ACIR == true){
			document.getElementById('fnPageBenefit1_ACIR').style.display = "";
		}

		if(fnPage2_GYCC == true){
			document.getElementById('fnPageBenefit1_GYCC').style.display = "";
		}

		if(fnPage2_GCP == true){
			document.getElementById('fnPageBenefit1_GCP').style.display = "";
		}

		if(fnPage2_EDU == true){
			document.getElementById('fnPageBenefit1_EDU').style.display = "";
		}

		if(fnPage2_LCPR == true){
			document.getElementById('fnPageBenefit1_LCPR').style.display = "";
		}
	
		if(fnPage2_PLCP == true){
			document.getElementById('fnPageBenefit1_PLCP').style.display = "";
		}
    }
    
    //for basic Page
    $('.fnPageBasic_DB').html('[' + a + ']');
    a++;
    
	if ($.trim(gdata.SI[0].Trad_Details.data[0].CashDividend) == 'ACC') 
	{
		$('.fnPageWB30R_SV').html('[' + a + ']');
		a++;
	} else if (gdata.SI[0].Trad_Details.data[0].CashDividend == 'POF') {
		if (parseInt(gdata.SI[0].Trad_Details.data[0].PartialPayout) != 100) { //CD : Payout GYI : Payout                
			$('.fnPageWB30R_SV').html('[' + a + ']');
			a++;
		}
	}
    //for WB Riders
    if(fnPage2_GYCC == true || fnPage2_GCP == true || fnPage2_EDU == true ){
        $('.fnPageWB30R_AYCC').html('[' + a + ']');
        a++;
    }
    // for other riders desc
    $.each(gdata.SI[0].Trad_Rider_Details.data, function(index, row) {        
        
        if(row.RiderCode == 'ACIR' ){
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
        
	if(SecondOrPayorRider.length > 0){
		if(SecondOrPayorRider[0] == 'LCWP'){
		$('.fnPage35_LCWP').html('[' + a + ']');
		 a++;
		 
		}
		else if(SecondOrPayorRider[0] == 'SP_PRE'){
			$('.fnPage35_SPPRE').html('[' + a + ']');
			 a++;
		}   
	}

	$('.fnPage40_IRR').html('[' + a + ']');
	a++;    
}
	
function setRiderText()
{
	if (document.getElementById('disclaimer_2') != null) {
   		document.getElementById('Page1withRiders').style.display= "none";
// 		document.getElementById('Page1Figures').style.display= "none";
		document.getElementById('disclaimer').style.display = "none";
		document.getElementById('GIRR').style.display = "none";
		document.getElementById('HLAWPMain').style.height="370px";
	}
	
	if(gdata.SI[0].Trad_Details.data[0].GIRR == '1'){
		document.getElementById('GIRR').style.display= "";        
	}
}
