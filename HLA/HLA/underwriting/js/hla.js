//ver1.8

var secondLAPayorRiders = new Array("SP_PRE","SP_STD","LCWP","PLCP","PR","PTR");
var addAnnualWording = new Array("LCWP","PR","SP_PRE","SP_STD");
var totalUnderwritingSecondOrPayor = 0;

var HLAWPBasicTerm;

function setPage(){

	$('.rptVersion').html('i-M Solutions Version 1.5 (Agency) - Last Updated 9 Oct 2014 - E&amp;OE-'); //set version info
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
	
	//var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + strTime;
		    
    $('.dateModified').html(displayDateFull);
    //$('#PrintDate').html(displayDate);
	$('.PrintDate2').html(displayDate);
	
	
	//$('.dateModified').html(gdata.SI[0].DateModified);
	$('.agentName').html(gdata.SI[0].agentName); //set agent name
    $('.agentCode').html(gdata.SI[0].agentCode); //set agent code
    $('.SICode').html(gdata.SI[0].SINo);
//     $('.totalPages').html(gdata.SI[0].TotalPages); //set total pages
    	
	$('.planName').html(gdata.SI[0].PlanName);

	$('.LAName1').html(gdata.SI[0].SI_Temp_trad_LA.data[0].Name);
    
    $('.BasicSA').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
    $('.GYIPurchased').html(formatCurrency(gdata.SI[0].Trad_Details.data[0].BasicSA));
    
    $('.covPeriod').html(gdata.SI[0].SI_Temp_Trad_Details.data[0].col4);
    
    $.each(gdata.SI[0].SI_Underwriting_Pages.data, function(index, row) {
           
        $("#" + row.PageDesc + " .currentPage").html(row.PageNum);
    });
    
//     checkForHLACP();
//     hidePage1SecondLA();
//     hidePage1Payor();
    processTotalPages();
    
    populate();
}


function populate()
{
    //hide the first page for both 2nd LA and Payor first
    
    var planCode = "";
    var planName = "";
    var planChoice = "";
    var units = "";
    var sumAssured = "";
    var covPeriod = "";
    var PaymentPeriod = "";
    var AnnualPremium = "";
    var underwritingSA = "";
    
    var tempPlanCode = "";
    var tempPlanName = "";
    var tempPlanChoice = "";
    var tempUnits = "";
    var tempSumAssured = "";
    var tempCovPeriod = "";
    var tempUnderwritingSA = "";
    
	var count=0;
    var ciwpCount=0;
    var firstTotalUnderwritingSA = 0;
    
    var upperLimit = 20;
    var lowerLimit = 12;
    // expects the riders to be properly ordered
    var firstLATable = "table-1stLifeAssured";
    $.each(gdata.SI[0].SI_Temp_Trad_Details.data, function(index, SI_Temp_Trad_Details) 
    {
    	if(count > lowerLimit){
			firstLATable = "table-1stLifeAssured2";
		}
		if( SI_Temp_Trad_Details.col11=="(null)" ) // for non waiver Riders
		{  
			planCode = SI_Temp_Trad_Details.RiderCode;
			planName = SI_Temp_Trad_Details.col0_1;
			planChoice = SI_Temp_Trad_Details.col0_2;
			units = SI_Temp_Trad_Details.col1;
			sumAssured = SI_Temp_Trad_Details.col2;
			covPeriod = SI_Temp_Trad_Details.col3;
			PaymentPeriod = SI_Temp_Trad_Details.col4;
			AnnualPremium = SI_Temp_Trad_Details.col5;
			if(planCode == 'HLAWP'){
				HLAWPBasicTerm = covPeriod;
			}
			underwritingSA = getUnderwritingSA(planCode, sumAssured, covPeriod, PaymentPeriod, AnnualPremium.toString().replace(",", ""));
			if (secondLAPayorRiders.indexOf(planCode)>-1) {
				if (gdata.SI[0].SI_Temp_trad_LA.data[1].PTypeCode == "LA") { // Second LA 
					if (count > upperLimit) {
						showPage2SecondLA();
					} else if (count > lowerLimit) {
						showPage2SecondLA2();
					} else {
						showPage1SecondLA();
					}
					populateSecondLA(planCode,planName,sumAssured,covPeriod,underwritingSA);
				} else { // Payor
					if (count > upperLimit) {
						showPage2Payor();
					} else if (count > lowerLimit) {
						showPage2Payor2();
					} else {
						showPage1Payor();
					}
					populatePayor(planCode,planName,sumAssured,covPeriod,underwritingSA);
		 		}
		 	} else {
				$("."+firstLATable+" > tbody").append('<tr><td class="left">' + planName + 
				'</td><td class="right">' + formatPlanChoiceUnits(planChoice) + 
				'</td><td class="right">' + formatPlanChoiceUnits(units) +
				'</td><td class="right">' + addAsterisk(formatCurrency(sumAssured),planCode) + 
				'</td><td class="right">' + covPeriod +
				'</td><td class="right">' + formatCurrency(underwritingSA) + 
				'</td></tr>');
				firstTotalUnderwritingSA = firstTotalUnderwritingSA + parseFloat(underwritingSA);
		 	}
		 	
			count++;
		}
		else
		{
			if(SI_Temp_Trad_Details.col0_1!="-Annually" && SI_Temp_Trad_Details.col0_1!="-Semi-annually" && SI_Temp_Trad_Details.col0_1!="-Quarterly" && SI_Temp_Trad_Details.col0_1!="-Monthly")
			{				
				tempPlanCode = SI_Temp_Trad_Details.RiderCode;
				tempPlanName = SI_Temp_Trad_Details.col0_1;
				tempPlanChoice = SI_Temp_Trad_Details.col0_2;
				tempUnits = SI_Temp_Trad_Details.col1;
				tempSumAssured = SI_Temp_Trad_Details.col2;
				tempCovPeriod = SI_Temp_Trad_Details.col3;
				
			}  
			else if(SI_Temp_Trad_Details.col0_1=="-Annually")
			{		
				tempSumAssured = SI_Temp_Trad_Details.col2.toString().replace(",", "");
				tempUnderwritingSA = getUnderwritingSA(tempPlanCode, tempSumAssured, tempCovPeriod, "", "");
				underwritingSA = tempUnderwritingSA;
				if (secondLAPayorRiders.indexOf(tempPlanCode)>-1) {
					if (gdata.SI[0].SI_Temp_trad_LA.data[1].PTypeCode == "LA") { // Second LA 
						if (count > upperLimit) {
							showPage2SecondLA();
						} else if (count > lowerLimit) {
							showPage2SecondLA2();
						} else {
							showPage1SecondLA();
						}
						populateSecondLA(tempPlanCode,tempPlanName,tempSumAssured,tempCovPeriod,tempUnderwritingSA);
						firstLATable = "table-2ndLifeAssure";
					} else { // Payor
						if (count > upperLimit) {
							showPage2Payor();
						} else if (count > lowerLimit) {
							showPage2Payor2();
						} else {
							showPage1Payor();
						}
						populatePayor(tempPlanCode,tempPlanName,tempSumAssured,tempCovPeriod,tempUnderwritingSA);
						firstLATable = "table-payor";
					} 
				} else {
					$("."+firstLATable+" > tbody").append('<tr><td class="left">' + tempPlanName + 
					'</td><td class="right">' + formatPlanChoiceUnits(tempPlanChoice) + 
					'</td><td class="right">' + formatPlanChoiceUnits(tempUnits) +
					'</td><td class="right">' + addAsterisk(formatCurrency(tempSumAssured),tempPlanCode) + 
					'</td><td class="right">' + tempCovPeriod +
					'</td><td class="right">' + formatCurrency(tempUnderwritingSA) + 
					'</td></tr>');
					firstTotalUnderwritingSA = firstTotalUnderwritingSA + parseFloat(tempUnderwritingSA);
				}
			}			
		}
    });
    
    $('.firstTotalUnderwritingSA').html(formatCurrency(firstTotalUnderwritingSA));    
    $('.secondTotalUnderwritingSA').html(formatCurrency(totalUnderwritingSecondOrPayor));    
    $('.payorTotalUnderwritingSA').html(formatCurrency(totalUnderwritingSecondOrPayor));
}

function checkForHLACP()
{
    if(gdata.SI[0].SI_Temp_Trad_Details.data[0].RiderCode=="HLACP")
    {
        showHlacpGYI();
    }else
    {
        hideHlacpGYI();
    }
}

function populateSecondLA(planCode,planName,sumAssured,covPeriod,underwritingSA)
{
    $(".table-2ndLifeAssured > tbody").append('<tr><td class="left">' + planName +
    '</td><td class="right">-'+
    '</td><td class="right">-'+
    '</td><td class="right">' + formatCurrency(sumAssured) + 
    '</td><td class="right">' + covPeriod + 
    '</td><td class="right">' + formatCurrency(underwritingSA) + 
    '</td></tr>');
    totalUnderwritingSecondOrPayor = totalUnderwritingSecondOrPayor + parseFloat(underwritingSA);
}

function populatePayor(planCode,planName,sumAssured,covPeriod,underwritingSA)
{
    $(".table-payor > tbody").append('<tr><td class="left">' + planName + 
    '</td><td class="right">-'+
    '</td><td class="right">-'+
    '</td><td class="right">' + formatCurrency(sumAssured) +
    '</td><td class="right">' + covPeriod +
    '</td><td class="right">' + formatCurrency(underwritingSA) + 
    '</td></tr>');
    totalUnderwritingSecondOrPayor = totalUnderwritingSecondOrPayor + parseFloat(underwritingSA);
}

function processTotalPages() {
    var amountOfPages = gdata.SI[0].SI_Underwriting_Pages.amountOfPages;
    $('.totalPages').html(amountOfPages);
    if (amountOfPages!="1") {
   		document.getElementById('page1LAUTotal').style.display= "none";
    }
}

function showHlacpGYI() {
    document.getElementById('hlacpGYI').style.display= "";
}
function hideHlacpGYI() {
    document.getElementById('hlacpGYI').style.display= "none";
}
function showPage1SecondLA() {
    document.getElementById('page1SecondLA').style.display= "";
}
function hidePage1SecondLA() {
    document.getElementById('page1SecondLA').style.display= "none";
}
function showPage1Payor() {
    document.getElementById('page1Payor').style.display= "";
}
function hidePage1Payor() {
    document.getElementById('page1Payor').style.display= "none";
}
function showPage2SecondLA() {
    document.getElementById('page2SecondLA').style.display= "";
}
function hidePage2SecondLA() {
    document.getElementById('page2SecondLA').style.display= "none";
}
function showPage2SecondLA2() {
    document.getElementById('page2SecondLA2').style.display= "";
}
function showPage2Payor() {
    document.getElementById('page2Payor').style.display= "";
}
function hidePage2Payor() {
    document.getElementById('page2Payor').style.display= "none";
}
function showPage2Payor2() {
    document.getElementById('page2Payor2').style.display= "";
}

function formatAnnual(val)
{
    var temp;
    
    temp = val + "</br>(Annually)";
    
    return temp;
}

function addAsterisk(val,planCode) //only applies for HLACP
{
    var temp;
    
    if(planCode=="HLACP")
    {
        temp = val + " *";
    }else
    {
        temp = val;
    }
    
    return temp;
}

function formatPlanChoiceUnits(val)
{
    if(val=="0" || val=="")
    {
        return "-";
    }else
    {
        return val;
    }
}

function getUnderwritingSA(planCode, SA, ridTerm, aaPaymentPeriod, aaPremium)
{
    var returnVal;
    var intSA = parseFloat(SA);
    //alert(planCode);
    
    if(planCode=="HLACP")
    {
        returnVal = 22 * SA;
    }
    else if(planCode=="L100" || planCode=="S100")
    {
        returnVal = SA;
    }
    else if(planCode=="HLAWP")
    {
	if(parseInt(aaPaymentPeriod) == 6){
	    if(HLAWPBasicTerm == 30){
		returnVal =  4 * SA;			
	    }
	    else{
		returnVal = 9 * SA;
	    }
	}
	else
	{
	    if(HLAWPBasicTerm == 30){
		returnVal = 5 * SA;
	    }
	    else{
		returnVal = 13 * SA;
	    }
	}
        
    }
    else if(planCode=="ACIR_MPP")
    {
        returnVal = 0;
    }
    else if(planCode=="WB30R" || planCode=="WB50R" || planCode=="WBI6R30" || planCode=="WBD10R30" || planCode=="EDUWR" ) 
    {
        //returnVal = aaPremium * aaPaymentPeriod;
	if(parseInt(aaPaymentPeriod) == 6){
	    if(HLAWPBasicTerm == 30){
		returnVal = aaPremium * 2;			
	    }
	    else{
		returnVal = aaPremium * 2;
	    }
	}
	else
	{
	    if(HLAWPBasicTerm == 30){
		returnVal = aaPremium * 3;
	    }
	    else{
		returnVal = aaPremium * 3;
	    }
	}
    }
    else if(planCode=="WPTPD30R" || planCode=="WPTPD50R" )
    {
        returnVal = SA * 0.5
    }
    else if(planCode=="WP30R" || planCode=="WP50R"  )
    {
        returnVal = SA * 1.0
    }
    else if(planCode=="C+")
    {
        returnVal = 0;
    }
    else if(planCode=="CCTR")
    {
        returnVal = SA;
    }
    else if(planCode=="CIR")
    {
        returnVal = SA;
    }
    else if(planCode=="CIWP")
    {
        returnVal = annualRiderLogic(intSA,ridTerm);
        //alert("returnVal = " + returnVal);
    }
    else if(planCode=="CPA")
    {
        returnVal = 0;
    }
    else if(planCode=="HB")
    {
        returnVal = 0;
    }
    else if(planCode=="HMM")
    {
        returnVal = 0;
    }
    else if(planCode=="HSP_II")
    {
        returnVal = 0;
    }
    else if(planCode=="ICR")
    {
        returnVal = 10 * intSA;
    }
    else if(planCode=="LCPR")
    {
        returnVal = intSA;
    }
    else if(planCode=="MG_II")
    {
        returnVal = 0;
    }
    else if(planCode=="MG_IV")
    {
        returnVal = 0;
    }
    else if(planCode=="PA")
    {
        returnVal = 0;
    }
    else if(planCode=="TPDYLA")
    {
        returnVal = annualTPDYLALogic(intSA,ridTerm);
    }
    else if(planCode=="SP_PRE") //spouse rider premier
    {
        returnVal = annualRiderLogic(intSA,ridTerm);
    }
    else if(planCode=="SP_STD") //spouse rider standard
    {
        returnVal = annualRiderLogic(intSA,ridTerm);
    }
    else if(planCode=="LCWP") //Living Care
    {
        returnVal = annualRiderLogic(intSA,ridTerm);
    }
    else if(planCode=="PLCP") //Payor living care
    {
        returnVal = SA;
    }
    else if(planCode=="PR") //Waiver of Premium
    {
        returnVal = annualRiderLogic(intSA,ridTerm);
    }
    else if(planCode=="PTR") //Payor Term Rider
    {
        returnVal = SA;
    }
    else if(planCode=="EDB") //Payor Term Rider
    {
        returnVal = SA;
    }
    else if(planCode=="ETPDB") //Payor Term Rider
    {
        returnVal = 0.5 * intSA;
    }
    
    return returnVal;
}

function annualRiderLogic(sa,term)
{
    var temp;
    if( parseInt(term)<=10 )
    {
        temp = 4 * sa;
    }else
    if( parseInt(term)>10 )
    {
        temp = 8 * sa;
    }
    
    returnVal = temp;
    
    return returnVal;
}

function annualTPDYLALogic(sa,term)
{
    var temp;
    var BenefitPaymentTerm = 70 - parseInt(gdata.SI[0].SI_Temp_trad_LA.data[0].Age);
    
    if( parseInt(BenefitPaymentTerm)<=10 )
    {
        temp = 4 * sa;
    }else
    if( parseInt(BenefitPaymentTerm)>10 )
    {
        temp = 8 * sa;
    }
    
    returnVal = temp;
    
    return returnVal;
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

var currPageNo = 0;
function createPage(pageNo)//append each page to the main page
{
    currPageNo +=1;
    var tb = document.createElement('table');
    var tr1 = document.createElement('tr');
    var tr2 = document.createElement('tr');

    var td1 = document.createElement('td');
    var td2 = document.createElement('td');

    tb.border = "0"; //footer table border

    tb.style.height='906px';//906 is estimate of ipad full height
    tb.setAttribute('class','tableMain');
    tr1.style.height = '90%';
    tr2.style.height = '10%';
    tb.style.width = '100%';
    td1.setAttribute('id',pageNo);

    var barcodeStr = "<img src='pds2HTML/img/barcode.png' style='vertical-align:text-top;padding: 0px 0px 0px 0px;' height='70%' height='70%'/><br/>";
    var htmlString = 
    "<table border='0' style='border-collapse:separate;border:0px solid black;width:100%;'>" +
    "<tr>" + 
    "<td width='75%' style='font-family:Arial;font-size:8px;font-weight:normal;padding: 5px 5px 5px 0px;'> " +
    "This Product Disclosure Sheet consists of <span class='totalPageNoClass'>{totalPageNoClass}</span> pages and each page forms an integral part of the Product Disclosure Sheet. A prospective policy owner is advised to read and<br/> " +
    "understand the information printed on each and every page.<br/> " +
    "<b><span id='rptVersion' class='rptVersion'>{rptVersion}</span></b><br/> " +
    "Level 3, Tower B, PJ City Development, No. 15A Jalan 219, Seksyen 51A, 46100 Petaling Jaya, Selangor. Tel: 03-7650 1818 Fax: 03-7650 1991 Website: www.hla.com.my<br/> " +
    "</td> " +
    "<td width='9%' align='left' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:8px;'>Page <span id='currPageID'>{currPageNo}</span> of <span class='totalPageNoClass'>{Pages}</span></td>  " +
    "<td width='16%' align='right' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:8px;'> ";

    if(currPageNo==1)
    {
    htmlString = htmlString + barcodeStr;
    }


    htmlString = htmlString + "Ref: <span id=SINo class='SINo'>{SINo}</span></td>  " +
    "</tr> " +
    "</table>";

    td2.innerHTML = htmlString;


    td1.setAttribute('class','alignTop');
    tb.style.margin = '0px';
    tr1.appendChild(td1);
    tr2.appendChild(td2);
    tb.appendChild(tr1);
    tb.appendChild(tr2);



    //gdata.SI[0].SINo

    return tb;

}

function loadPageNo()
{
    var tempPage = document.getElementById('currPageID');
    tempPage.id = "currPageID"+currPageNo;
    tempPage.setAttribute('class',"currPageClass"+currPageNo);
    $(".currPageClass"+currPageNo).html(currPageNo);
    $(".totalPageNoClass").html(currPageNo);

    loadSINo();
    loadRptVers();
}

function loadRptVers()
{
    $('.rptVersion').html('i-M Solutions Version 1.5 (Agency) - Last Updated 09 Oct 2014 - E&amp;OE-'); //set version info   
}

function loadSINo()
{
    var SINo = gdata.SI[0].SINo;
    $(".SINo").html(SINo);
}


function appendPage(pageNo,path)
{
    document.getElementById('page').appendChild(createPage(pageNo));
    //alert("ok 22");

    appendChildExt(path,document.getElementById(pageNo));

    loadPageNo();
}
                          
function appendChildExt(url,id)
{
jQuery.ajax({
              async: false,
              dataType:'html',
              url: url,
              success: function(result) {
              html = jQuery(result);
              
              //id.innerHTML = html.outerHTML;
              html.appendTo(id);
              },
          });
}

function loadPageNo()
{
    var tempPage = document.getElementById('currPageID');
    tempPage.id = "currPageID"+currPageNo;
    tempPage.setAttribute('class',"currPageClass"+currPageNo);
    $(".currPageClass"+currPageNo).html(currPageNo);
    $(".totalPageNoClass").html(currPageNo);

    loadSINo();
    loadRptVers();
}