function loadPageData()
{

    
    var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
		    
                    
                       
    $('.PrintDate2').html(displayDateFull);
    $('.PlanName').html(gdata.SI[0].PlanName);
    $('.BasicSA').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
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

function setPage(){
    //alert("gdata 22 = " + gdata.SI[0].UL_Temp_Pages.data.length);
	$('.rptVersion').html('iMP (Trad) Version 1.2 (Agency) - Last Updated 28 Oct 2013 - E&amp;OE-'); //set version info
	
	var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
    
    $('.dateModified').html(displayDateFull);
    //$('#PrintDate').html(displayDate);
	$('.PrintDate2').html(displayDate);
	//$('.PlanName').html('HLA EverLife');
	
	//$('.dateModified').html(gdata.SI[0].DateModified);
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages
	//$('.planName').html(gdata.SI[0].PlanName);
	
	
	//planName = row.PlanName;
	//planCode = row.PlanCode;
	
	//alert(gdata.SI[0].PlanName)
	//alert(gdata.SI[0].SI_Temp_trad_LA.data[0].Name)
	//$('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);
	
	
	//cashPaymentD = row.CashPaymentD;
	//mcashPaymentD = row.MCashPaymentD;
    
    
    //$('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    //$('.GYIPurchased').html(gdata.SI[0].Trad_Details.data[0].CashPayment_PO);
    

    
    /*$.each(gdata.SI[0].SI_Temp_Pages_PDS.data, function(index, row) {
           $("#" + row.PageDesc + " .currentPage").html(row.PageNum);
           });*/
}