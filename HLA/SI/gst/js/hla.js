//ver1.8
function setGSTPage(page)
{
	loadRptVers();
	var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var second = now.getSeconds();
	var ampm = hours >= 12 ? 'PM' : 'AM';
	hours = hours % 12;
	hours = hours ? hours : 12; // the hour '0' should be '12'
	minutes = minutes < 10 ? '0'+minutes : minutes;
	second = second < 10 ? '0'+second : second;
	var strTime = hours + ':' + minutes + ':' + second + ' ' + ampm;
	
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + strTime;
	
    $('.dateModified').html(displayDateFull);
	$('.PrintDate2').html(displayDate);	
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.SICode').html(gdata.SI[0].SINo);
//     $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages    	
	$('.planName').html(gdata.SI[0].PlanName);
	$('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);
    $('.BasicSA').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));    
    $('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));    
    $('.covPeriod').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col4);
    $.each(gdata.SI[0].SI_Temp_Trad_GST.data, function(index, row) {
        $("#gstPage" + (index+1) + " .currentGSTPage").html(index + 1);
    });
     $('.totalGSTPages').html(page);
//  	populate();

}


function populateGST()
{	
	var maxCount = 17;
	var gstStr = "";
	var exemptedStr = "";
	var lang = "";
	if (gdata.SI[0].QuotationLang == "Malay") {
		gstStr = "Kadar Standard";
		exemptedStr = "Dikecualikan";
		lang = "mly";
	} else {
		gstStr = "Standard Rated";
		exemptedStr = "Exempted";
		lang = "eng";
	}
	
	var appendStr = "";
	var style = "";
	var count = 0;
	var page = 1;
	var max = gdata.SI[0].SI_Temp_Trad_GST.data.length;
	var appended = false;
	var temp;
	
	var total = gdata.SI[0].SI_Temp_Trad_GST_Total.data[0];
	
    $.each(gdata.SI[0].SI_Temp_Trad_GST.data, function(index, row) {
		appendStr = '<tr>';
		
		style = ' style="border:1px solid black;" ';
		if (row.col0_1 == 'Wealth Booster-d10 Rider (30 year term)'){
			temp = 'Wealth Booster-<i>d10</i> Rider (30 year term)' 
		}
		else if (row.col0_1 == 'Wealth Booster-i6 Rider (30 year term)'){
			temp = 'Wealth Booster-<i>i6</i> Rider (30 year term)' 
		}
		else
		{
			temp = row.col0_1;
		}
		
		appendStr = appendStr + '<td style="text-align:left;border-width:1px;">'+ temp +'</td>';
		
		appendStr = appendStr +
				'<td'+style+'>'+formatCurrency(row.col3)+'</td>'+
				'<td'+style+'>'+showDashOrValue("s", formatCurrency(row.col4), total.initSemi)+'</td>'+
				'<td'+style+'>'+showDashOrValue("q", formatCurrency(row.col5), total.initQuarter)+'</td>'+
				'<td'+style+'>'+showDashOrValue("m", formatCurrency(row.col6), total.initMonth)+'</td>';
		if (row.col7 == 1) {
			appendStr = appendStr + '<td'+style+'>'+gstStr+'</td>';
		} else {
			appendStr = appendStr + '<td'+style+'>'+exemptedStr+'</td>';
		}	
		
		appendStr = appendStr +
				'<td'+style+'>'+formatCurrency(row.col8)+'</td>'+
				'<td'+style+'>'+showDashOrValue("s", formatCurrency(row.col9), total.initSemi)+'</td>'+
				'<td'+style+'>'+showDashOrValue("q", formatCurrency(row.col10), total.initQuarter)+'</td>'+
				'<td'+style+'>'+showDashOrValue("m", formatCurrency(row.col11), total.initMonth)+'</td>'+
				'<td'+style+'>'+formatCurrency(row.col12)+'</td>'+
				'<td'+style+'>'+showDashOrValue("s", formatCurrency(row.col13), total.totalSemi)+'</td>'+
				'<td'+style+'>'+showDashOrValue("q", formatCurrency(row.col14), total.totalQuarter)+'</td>'+
				'<td'+style+'>'+showDashOrValue("m", formatCurrency(row.col15), total.totalMonth)+'</td>'+
			'</tr>';
		
		count++;
		if (row.col0_1.length > 30) {
			count = count + (row.col0_1.length / 30) - 1;
		} else if ((row.col0_1.length > 17) || (row.col7)) {
			count++; // if it's "standard rated", or the text is too long the text takes 2 lines
		}
		
		if (!appended && count / maxCount > 1) {
			appended = true;
			page++;
			// Note, if there's more than 2 page, make gst_eng_Page3.html etc
			appendNewGSTPage(page, lang);
		}
		$('#table-gst'+page+' > tbody').append(appendStr);
    });
    appendGSTTotal(page);
    return page;
}


function appendNewGSTPage(page, lang) {
	var pageid = "gstPage"+page;
	htmlPages = '<div id="' + pageid + '" style="padding: 15px 0px 0px 0px;"></div>';
	$(htmlPages).appendTo('#externalGSTPages');
	$.ajax({
		url: "SI/gst/gst_"+lang+"_Page" + page +".html",
		async: false,
		dataType: 'html',
		success: function (data) {
			$("#" + pageid).html(data);
		}
	});
}

function appendGSTTotal(page) {
	
	var result = gdata.SI[0].SI_Temp_Trad_GST_Total.data[0];
	
	var appendStr = '<tr>';	
	if (gdata.SI[0].QuotationLang == "Malay") {
		appendStr = appendStr + '<td style="text-align:left"><b>Jumlah</b></td>';
	} else {
		appendStr = appendStr + '<td style="text-align:left"><b>Total</b></td>';
	}
	appendStr = appendStr +
						'<td>'+formatCurrency(result.initAnnual)+'</td>'+
						'<td>'+showDashOrValue("s", formatCurrency(result.initSemi), result.initSemi)+'</td>'+
						'<td>'+showDashOrValue("q", formatCurrency(result.initQuarter), result.initQuarter)+'</td>'+
						'<td>'+showDashOrValue("m", formatCurrency(result.initMonth), result.initMonth)+'</td>'+
						'<td/>'+
						'<td>'+formatCurrency(result.gstAnnual)+'</td>'+
						'<td>'+showDashOrValue("s", formatCurrency(result.gstSemi), result.initSemi)+'</td>'+
						'<td>'+showDashOrValue("q", formatCurrency(result.gstQuarter), result.initQuarter)+'</td>'+
						'<td>'+showDashOrValue("m", formatCurrency(result.gstMonth), result.initMonth)+'</td>'+
						'<td>'+formatCurrency(result.totalAnnual)+'</td>'+
						'<td>'+showDashOrValue("s", formatCurrency(result.totalSemi), result.totalSemi)+'</td>'+
						'<td>'+showDashOrValue("q", formatCurrency(result.totalQuarter), result.totalQuarter)+'</td>'+
						'<td>'+showDashOrValue("m", formatCurrency(result.totalMonth), result.totalMonth)+'</td>'+
					'</tr>';
	$('#table-gst'+page+' > tfoot').append(appendStr);
}


function formatCurrency(num) {
	if (num == "-")
		return "-";
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


function startsWith(str, prefix) {
    return str.lastIndexOf(prefix, 0) == 0;
}

function loadRptVers()
{
    $('.rptVersion').html('i-M Solutions Version 1.5 (Agency) - Last Updated 09 Oct 2014 - E&amp;OE-'); //set version info   
}

function loadSINo()
{
    $(".SINo").html(gdata.SI[0].SINo);
}
