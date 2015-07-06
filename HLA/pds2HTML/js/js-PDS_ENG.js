//for hardcoded info, search for 'function loadXXX()' , with XXX being the name of the data to be set, like an example SINo would be loadSINo().

function loadProductIntro ()
{
    var arrNoOne = new Array();
    var showEcar60 = false;
    
    for(var y=0; y<gdata.SI[0].UL_Temp_trad_Details.data.length; y++)
    {
        if(gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="ECAR60")
        {
            showEcar60 = true;
        }
    }
    
    arrNoOne[0] = "What is this product about?";
    
    if(gdata.SI[0].PlanCode == 'UV'){
       arrNoOne[1] = "This is a regular premium investment-linked plan up to age 100^.";
       $('.PlanName').html('HLA EverLife Plus');
    }
    else{
        arrNoOne[1] = "This is a regular premium investment-linked plan. ";
        $('.PlanName').html('HLA EverGain Plus');
    } 
    arrNoOne[2] = "Insurance protections provided are Death/ Total and Permanent Disability prior to attaining age 65 (TPD)/ Old Age Disablement after attaining age 65 (OAD); whichever occurs first.";
    if(gdata.SI[0].PlanCode == 'UV'){
        var temp = 70 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
            
        arrNoOne[3] = "HLA EverLife Plus also provides Policy Owner the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from 3rd up to " + iteration(temp.toString()) + " policy anniversary date provided " +
                        "that the fund  value is sufficient to pay for the one time charge. Once converted to a Reduced Paid Up Policy, the Basic Plan will be guaranteed in force up to the end of policy year immediately after Life Assured attains age 75.";
                        
        if(showEcar60)
        {   arrNoOne.push("The  policy values of this policy vary directly with the performance of the unit funds.");
            arrNoOne.push("EverCash 60 Rider is a deferred annuity rider. By paying an additional premium until age 60, you will receive a stream of Guaranteed Monthly Income starting" +
                          "from end of the policy year when you attain age 60 and every month thereafter until the first occurrence of either death, TPD or expiry of this rider at age 100. " +
                          "</br>Please refer to Section B of Question 2 for benefit descriptions of any other attaching rider.<br/><br/>" +
                          "^ Your insurance charge (which is not guaranteed and deducted from the fund value) will increase as you get older. It is possible that the fund value may be insufficient to pay for the high insurance charge and " +
                      "policy fee in later years due to circumstances such as poor fund returns, premium holiday or withdrawals causing your policy to lapse before attaining the age of 100. In such event you may need to top up your premium to ensure continuous coverage<br/>" +
                      "Note: TPD refers to Total & Permanent Disability prior to attaining age 65 and OAD refers to Old Age Disablement after attaining age 65. These definitions apply consistently across all marketing collaterals.");
        }
        else{
            arrNoOne.push("The  policy values of this policy vary directly with the performance of the unit funds.<br/><br/>" +
                          "^ Your insurance charge (which is not guaranteed and deducted from the fund value) will increase as you get older. It is possible that the fund value may be insufficient to pay for the high insurance charge and " +
                      "policy fee in later years due to circumstances such as poor fund returns, premium holiday or withdrawals causing your policy to lapse before attaining the age of 100. In such event you may need to top up your premium to ensure continuous coverage<br/>" +
                      "Note: TPD refers to Total & Permanent Disability prior to attaining age 65 and OAD refers to Old Age Disablement after attaining age 65. These definitions apply consistently across all marketing collaterals.");
        }
    }
    else{
        arrNoOne[3] = "HLA EverGain Plus also provides Policy Owner the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from 3rd up to last policy anniversary date provided that the " +
                        "fund  value is sufficient to pay for the one time charge. Once converted to a Reduced Paid Up Policy, the Basic Plan will be guaranteed in force until maturity.";
                        
        if(showEcar60)
        {   arrNoOne.push("The  policy values of this policy vary directly with the performance of the unit funds.");
            arrNoOne.push("EverCash 60 Rider is a deferred annuity rider. By paying an additional premium until age 60, you will receive a stream of Guaranteed Monthly Income starting" +
                          "from end of the policy year when you attain age 60 and every month thereafter until the first occurrence of either death, TPD or expiry of this rider at age 100. " +
                          "</br>Please refer to Section B of Question 2 for benefit descriptions of any other attaching rider.<br/><br/>" +
                      "Note: TPD refers to Total & Permanent Disability prior to attaining age 65 and OAD refers to Old Age Disablement after attaining age 65. These definitions apply consistently across all marketing collaterals.");
        }
        else{
            arrNoOne.push("The  policy values of this policy vary directly with the performance of the unit funds.<br/>" +
                          "Note: TPD refers to Total & Permanent Disability prior to attaining age 65 and OAD refers to Old Age Disablement after attaining age 65. These definitions apply consistently across all marketing collaterals.");
        }                
    }
    
    
    
    
    
    /*
    if(showEcar60)
    {
        arrNoOne.push("EverCash 60 Rider is a deferred annuity rider. By paying an additional premium until age 60, you will receive a stream of Guaranteed Monthly Income starting from end of the policy year when you attain age 60 and every month thereafter until the first occurrence of either death, TPD or expiry of this rider at age 100. </br>Please refer to Section B of Question 2 for benefit descriptions of any other attaching rider.");
    }
    
    
    

    
    
    arrNoOne.push("^ Your insurance charge (which is not guaranteed and deducted from the fund value) will increase as you get older. It is possible that the fund value may be insufficient to pay for the high insurance charge and " +
                  "policy fee in later years due to circumstances such as poor fund returns, premium holiday or withdrawals causing your policy to lapse before attaining the age of 100. In such event you may need to top<br/><br/>" +
                  "Note: TPD refers to Total & Permanent Disability prior to attaining age 65 and OAD refers to Old Age Disablement after attaining age 65. These definitions apply consistently across all marketing collaterals.");
    */
    
    
    var tableOne  = document.getElementById('tableOne');
    
    for (i = 1 ;i<=arrNoOne.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        
        if (i == 1)
        {
            td.innerHTML = "1.";
            td.setAttribute("class", "numbering");
            
            td2.setAttribute("class", "bold");
            
            
        }
        else{
            td.setAttribute("style", "vertical-align: top");
            td.innerHTML = "-";
        }
        td2.innerHTML = arrNoOne[i-1];
        tr.appendChild(td);
        tr.appendChild(td2);
        tableOne.appendChild(tr);
    }
    //tableOne.appendChild(lineBreak());
    
}

function iteration(input){
	if(input.substr(input.length - 1) == '1'){
		return(input + 'st');	
	}
	else if(input.substr(input.length - 1) == '2'){
		return(input + 'nd');	
	}
	else if(input.substr(input.length - 1) == '3'){
		return(input + 'rd');	
	}
	else {
		return(input + 'th');	
	}
}

function loadDeathBenefit (id)
{
    // display No.1 basic plan of PDS reports
    var arrNoTwoA = new Array();
    arrNoTwoA[0] = "I) Death Benefit";
    arrNoTwoA[1] = "In  the event of Death of the Life Assured, the amount payable shall be the SUM of:";
    arrNoTwoA[2] =  new Array("Sum Assured; and","Fund Value at the Next Valuation Date immediately following the date of the notification of Death.");;
    arrNoTwoA[3] =  "Juvenile  Lien shall apply as such: In the event of Death or TPD before age of 5, there will be a reduction to the Sum Assured. As a result, the benefit payable will be the Reduced Sum Assured as shown in Table (I) below  plus   the fund value.";
    arrNoTwoA[4] ="Table (I)";
    
    for (i = 1 ;i<=arrNoTwoA.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        if (i==1)
        {
            
            td2.innerHTML = arrNoTwoA[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else if (i == 5)
        {
            td2.appendChild(loadTableDeathBenefit());
            
        }
        else if (i == 3)
        {
            td2.appendChild(loadDetails(arrNoTwoA[i-1]));
            
        }
        else
        {
            td2.innerHTML = arrNoTwoA[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    //loadTableOne(tableSectionTwo.id);
    //id.appendChild(lineBreak());
    
}//table One in section 2

function loadTPD(id)
{
    var arrNoTwoB = new Array();
    arrNoTwoB[0] = "II) Total & Permanent Disability (TPD) Benefit";
    arrNoTwoB[1] = "In  the event of TPD of the Life Assured (any causes), the amount payable shall be the SUM of:";
    arrNoTwoB[2] =  new Array("Sum Assured; and","Fund Value at the Next Valuation Date immediately following the date of admission of TPD claim.<br/> Juvenile Lien as shown in Table (I) above shall apply.");;
    arrNoTwoB[3] = "TPD  Benefit will be paid in accordance to TPD provision as below:";
    arrNoTwoB[4] = "table of total TPD";
    arrNoTwoB[5] = "Total  TPD Benefits payable per Life under all policies insuring the Life Assured shall not exceed the TPD Benefit Limit per Life stated above. The Total TPD Benefit payable per Life refers to by TPD coverage  of all in-force policies for  <u>each Life Assured</u> at the point of claim event after application of Juvenile Lien.";
    
    for (i = 1 ;i<=arrNoTwoB.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        if (i==1)
        {
            
            td2.innerHTML = arrNoTwoB[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else if (i == 5)
        {
            td2.appendChild(loadTableTPD());
            
        }
        else if (i == 3)
        {
            td2.appendChild(loadDetails(arrNoTwoB[i-1]));
            
        }
        else
        {
            td2.innerHTML = arrNoTwoB[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    
    id.appendChild(lineBreak());
    
}

function loadOAD(id)
{
    var arrNoTwoC = new Array();
    arrNoTwoC[0] = "III) Old Age Disablement (OAD) Benefit";
    arrNoTwoC[1] = "In  the event of OAD of the Life Assured, the amount payable shall be the SUM of:";
    arrNoTwoC[2] =  new Array("Sum Assured; and","Fund Value at the Next Valuation Date immediately following the date of admission of OAD claim.");
    arrNoTwoC[3] = "Total  OAD Benefits payable per Life under all policies insuring the Life Assured shall limit to RM 1,000,000 per life. The Total OAD Benefit payable per Life refers to by OAD coverage of all in-force policies for  <u>each Life Assured </u> at the point of claim event.";
    
    for (i = 1 ;i<=arrNoTwoC.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        if (i==1)
        {
            
            td2.innerHTML = arrNoTwoC[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else if (i == 3)
        {
            td2.appendChild(loadDetails(arrNoTwoC[i-1]));
            
        }
        else
        {
            td2.innerHTML = arrNoTwoC[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
        
        
    }//for loop
    id.appendChild(lineBreak());
    
}
function loadRPUO(id)
{
    
    var temp = 70 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
    
    var arrNoTwoD = new Array();
    arrNoTwoD[0] = "IV) Reduced Paid Up Option";
    arrNoTwoD[1] = "The  Policy Owner has the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from 3rd up to " + iteration(temp.toString()) + " policy anniversary date, provided that the fund value is sufficient to pay for the one time charge. Upon Reduced Paid Up, the one time charge shall be deducted from the fund value to pay for the monthly policy fee and insurance charges of the Basic Plan for a tenure up to the end of policy year immediately after Life Assured attains age 75. The premium, insurance charge and monthly policy fee of the Basic Plan shall cease during the tenure.";
    arrNoTwoD[2] = "</br>Once  converted to a Reduced Paid Up Policy, the Basic Plan will be guaranteed in force throughout the tenure. However, at the end of the tenure, you may be required to pay for the premium, insurance charge and monthly policy fee of the Basic Plan up to the maturity of the policy or you may choose to be on premium holiday which uses your fund value to meet the monthly charges.";
    arrNoTwoD[3] = "</br>Upon  Death/ TPD/ OAD, whichever occurs first, the sum of Reduced Paid Up Sum Assured of Basic Plan plus fund value shall be payable. Fund value is determined by the number of units (balance of units after deduction of one time charge and adding any subsequent Guaranteed Bonus Units credited to the policy) multiplied by the prevailing unit price.";
    arrNoTwoD[4] = "</br>Upon  maturity, the fund value shall be payable. For HLA EverGreen Funds, the Minimum Guaranteed Unit Price at Fund Maturity shall be applicable.";
    
    for (i = 1 ;i<=arrNoTwoD.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        if (i==1)
        {
            
            td2.innerHTML = arrNoTwoD[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else
        {
            td2.innerHTML = arrNoTwoD[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    //tableSectionTwo.appendChild(lineBreak());
    
}
function loadGBU(id)
{
    var arrNoTwoE = new Array();
    arrNoTwoE[0] = "V) Guaranteed Bonus Units";
    arrNoTwoE[1] = "Guaranteed  Bonus Units would be credited to your policy once in every policy year, commencing from the beginning of seventh (7th) policy year as shown below.";
    arrNoTwoE[2] = "table of total GBU";
    
    
    for (i = 1 ;i<=arrNoTwoE.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        if (i==1)
        {
            
            td2.innerHTML = arrNoTwoE[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else if (i == 3)
        {
            td2.appendChild(loadTableGBU());
            
        }
        else
        {
            td2.innerHTML = arrNoTwoE[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    id.appendChild(lineBreak());
}
//maturity benefit
function loadMB(id)
{
    var arrNoTwoE = new Array();
    arrNoTwoE[0] = "VI) Maturity Benefit";
    arrNoTwoE[1] = "Upon  survival of Life Assured at the end of the policy term, a Maturity Benefit equivalent to the fund value shall be payable.";
    
    for (i = 1 ;i<=arrNoTwoE.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        if (i==1)
        {
            td2.innerHTML = arrNoTwoE[0];
            td2.setAttribute("class", "boldUnderLine");
        }
        else
        {
            td2.innerHTML = arrNoTwoE[i-1];
        }
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    id.appendChild(lineBreak());
}
function loadDetails(arr)
{
    var table = document.createElement('table');
    
    for (i = 1; i<= arr.length;i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.style.width = "20px";
        td.innerHTML = "  - ";
        td2.innerHTML = arr[i-1];
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    return table;
}
//table Death benefit in section 2
function loadTableDeathBenefit()
{
    var arr = new Array("Age at Occurrence","0.1","2","3","4","Reduced Sum Assured After factoring in Juvenile Lien<br/>(% of Original Sum Assured)","20%","40%","60%","80%");
    
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    
    for (i = 1; i<= arr.length/2;i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','textAlignCenter');
        td2.setAttribute('class','textAlignCenter');
        td.innerHTML = arr[i-1];
        td2.innerHTML = arr[(arr.length/2)-1+i];
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    return table;
    
}
//table TPD in section 2
function loadTableTPD()
{
    var arr = new Array("Attained Age upon TPD","Less Than 7","7 to less than 15","15 to less than 65","TPD Benefit Limit per Life","RM 100,000","RM 500,000","RM 3,500,000");
    
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    //table.style.width = "95%";

    for (i = 1; i<= arr.length/2;i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','textAlignCenter');
        td2.setAttribute('class','textAlignCenter');
        td.innerHTML = arr[i-1];
        td2.innerHTML = arr[(arr.length/2)-1+i];
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    return table;
    
}//table TPD in No 2
//table GBU in section 2
function loadTableGBU()
{
    var arr = new Array("Beginning of Policy Year","7","8","9","10","11 and onwards","% of Fund Value (applicable to Basic Unit Account and Rider Unit Account)","0.04","0.08","0.12","0.16","0.20");
    
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    
    for (i = 1; i<= arr.length/2;i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','textAlignCenter');
        td2.setAttribute('class','textAlignCenter');
        td.innerHTML = arr[i-1];
        td2.innerHTML = arr[(arr.length/2)-1+i];
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    return table;
    
}//table TPD in No 2


//======================================================= 2B. attaching rider List =====================================================================



function loadTableAR_CIWP()//Critical Illness Rider
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Critical Illness WP Rider",CWIP_sumAssured+" </br>(Annual)",CWIP_coverage,"Life Assured",loadTableAR_CIWP_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_CCR()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("CI Care Rider", CCR_sumAssured+" </br>(Annual)",CCR_coverage,"Life Assured",loadTableAR_CCR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_JCCR()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Junior CI Care Rider", JCCR_sumAssured+" </br>(Annual)",JCCR_coverage,"Life Assured",loadTableAR_JCCR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_TCCR()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Total CI Care Rider", TCCR_sumAssured+" </br>(Annual)",TCCR_coverage,"Life Assured",loadTableAR_TCCR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_MSR()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("MenShield Rider", MSR_sumAssured+" </br>(Annual)",MSR_coverage,"Life Assured",loadTableAR_MSR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_LDYR()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("LadyShield Rider", LDYR_sumAssured+" </br>(Annual)",LDYR_coverage,"Life Assured",loadTableAR_LDYR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_LCWP()
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array (" Living Care Waiver of Premium Rider",LCWP_sumAssured+" </br>(Annual)",LCWP_coverage, LCWP_PayorOrSecond,loadTableAR_LCWP_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_ACIR()//accelerated Critical Illness Rider
{
    //alert("ACIR = " + ACIR_sumAssured);
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Accelerated Critical Illness Rider",ACIR_sumAssured,ACIR_coverage,"Life Assured",loadTableAR_ACIR_desc());
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< 2;i++)
    {
        var tr = document.createElement('tr');
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');            
            td.style.width = arrStyle[j];
            
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            else if (j == 4)
            {
                td.appendChild(arrContent[j]);
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

            }
            else{
                
                td.innerHTML = arrContent[j];
                td.setAttribute('class','tdVerticalAlign textAlignCenter');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}
var riderDisplayNo = new Array("0");
function loadTableAR()//acc death & Compassionate Allowance Rider
{
    //var riderNo = new Array("0","1","2");
    //alert("ok");
    //0
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    //1
    var arrADCAR = new Array("Acc Death &Compassionate Allowance Rider",DCA_sumAssured,DCA_coverage,"Life Assured","In the event of accidental Death of the Life Assured, the Accidental Death Benefit payable shall be RM10,000.00. Compassionate Allowance ofRM10,000 will be payable in addition to Accidental Death Benefit.");
    //2
    var arrADHI = new Array("Acc.Daily Hospitalisation Income Rider",DHI_sumAssured+"</br>(Daily)",DHI_coverage,"Life Assured","In the event that the Life Assured is hospitalised in an approved hospital for a minimum of 6 continuous hours per admission as the result of an");
    //3
    var arrE1R = new Array("EverCash 1 Rider",ECAR_sumAssured+"</br>(Annual)",ECAR_coverage,"Life Assured","This rider will provide a Guaranteed Yearly Income of RM"+ECAR_sumAssured+" starting from end of 1st year up to the expiry of this Rider. Upon death/ TPD (prior to attaining age 65), whichever is earlier, 100% of the outstanding Guaranteed Yearly Income shall be payable. Upon Accidental TPD, the additional amount payable shall be 300% of outstanding Guaranteed Yearly Income.");
    //4
    var arrER = new Array("EverCash Rider",ECAR6_sumAssured+"</br>(Annual)",ECAR6_coverage,"Life Assured","This rider will provide a Guaranteed Yearly Income of RM"+ECAR6_sumAssured+" starting from end of 6th year up to the expiry of this Rider. Upon death/ TPD (prior to attaining age 65), whichever is earlier, 100% of the outstanding Guaranteed Yearly Income shall be payable. Upon Accidental TPD, the additional amount payable shall be 300% of outstanding Guaranteed Yearly Income.");
    //5
    var arrLR = new Array("LifeShield Rider",LSR_sumAssured,LSR_coverage,"Life Assured","In the event of Death or TPD (prior to attaining age 65) of Life Assured, whichever is earlier, the Death/ TPD benefit equivalent to RM"+LSR_sumAssured+" shall be payable.TPD benefit will be paid in accordance to TPD provision. Juvenile LIEN rule shall apply.");
    //6
    var arrAMRR = new Array("Acc. Medical Reimbursement Rider",MR_sumAssured,MR_coverage,"Life Assured","In the event of accident, medical and surgical expenses such as inpatient and outpatient treatment incurred by Life Assured will be reimbursed up to RM"+MR_sumAssured+" per accident.");
    //7
    var arrPAR = new Array("Personal Accident Rider",PA_sumAssured,PA_coverage,"Life Assured","In the event of accidental Death of the Life Assured, the Accidental Death Benefit payable shall be RM"+PA_sumAssured+". In the event of accidental Partial/Total & Permanent Disability of the Life Assured, Accidental Partial/ Total & Permanent Disability Benefit payable shall be in accordance to Schedule of Indemnities. The Accidental Partial/ Total & Permanent Disability Benefit payable shall be accelerated from the Rider Sum Assured.");
    //8
    var arrATPDMLAR = new Array("Acc. TPD Monthly Living Allowance Rider",TPDMLA_sumAssured+"</br>(Monthly)",TPDMLA_coverage,"Life Assured","In the event that the Life Assured suffers any of the following loss or disability as the result of an accident within 365 days from the date of occurrence; a Monthly Living Allowance equivalent to RM"+TPDMLA_sumAssured+" will be payable up to maximum of 180 months during the lifetime of the Life Assured:" + loadDetailsAR(["-","-","-","-","-","-","-","-","-"],["Total Permanent Disability;","permanent total loss of sight of both eyes;","permanent total loss of sight of one eye;","permanent total loss of speech and hearing;","loss of or the permanent loss of use of two limbs;","loss of or the permanent loss of use of one limb;","permanent and incurable insanity; or","permanent total paralysis."]));
    //var tempATPDMLAR = "In the event that the Life Assured suffers any of the following loss or disability as the result of an accident within 365 days from the date ofoccurrence; a Monthly Living Allowance equivalent to RM500.00 will be payable up to maximum of 180 months during the lifetime of the Life Assured: </br>-&nbsp&nbsp Total Permanent Disability;</br>-&nbsp&nbsp permanent total loss of sight of both eyes;</br>-&nbsp&nbsp permanent total loss of sight of one eye;</br>-&nbsp&nbsp permanent total loss of speech and hearing;</br>-&nbsp&nbsp loss of or the permanent loss of use of two limbs;</br>-&nbsp&nbsp loss of or the permanent loss of use of one limb;</br>-&nbsp&nbsp permanent and incurable insanity; or</br>-&nbsp&nbsp permanent total paralysis.";
    //9
    var arrTPDWPR = new Array("TPD Waiver of Premium Rider",TPDWP_sumAssured+"</br>(Annual)",TPDWP_coverage,"Life Assured","The rider Sum Assured will be paid to reduce future premium up to expiry date of the rider upon the first occurrence of TPD (prior to attaining age 65)/OAD (after attaining age 65) of the life assured during the coverage period. Premium is guaranteed and on level basis.");
    //10
    var arrAWIR = new Array("Acc.Weekly Indemnity",WI_sumAssured+"</br>(Weekly)",WI_coverage,"Life Assured","In the event of accidental Temporary Total Disability of the Life Assured, weekly indemnity equivalent to RM"+WI_sumAssured+" will be payable. In the event of accidental Temporary Partial Disability of the Life Assured, weekly indemnity equivalent to RM"+WI_sumAssured*1/4+" will be payable. Maximum duration payable for accidental Temporary Total Disability and accidental Temporary Partial Disability is up to 104 weeks per accident.");
    //11
    var arrER60 = new Array("EverCash 60 Rider",ECAR60_sumAssured+"</br>(Annual)",ECAR60_coverage,"Life Assured","This rider will provide a Guaranteed Monthly Income (GMI) of RM"+ECAR60_sumAssured+" starting from the end of year where Life Assured attains age 60 until the first occurrence of either death, TPD (prior to attaining age 65) or expiry of this rider at age 100. Upon Death/ TPD, the Death/ TPD benefit payable shall be as follows:</br><table border='1'><tr><td>Rider In Force Period</td><td>Death/ TPD benefit payable</td></tr><tr><td>Prior to commencement of GMI  </td><td>Total Annual rider premium* paid for this Rider accumulated at 3.5% per annum as accured on a monthly basis </td></tr><tr><td>Upon commencement of GMI</td><td>At least 50% of Outstanding GMI (50% of outstading GMI or Cash Surrender Value; whichever is higher)</td></tr></table> " +
                            "*The annual premium sum will exclude any loading premium and will be the annual premium sum before any discount");
    
    //12
    var arrCIRD = new Array("Diabetes Wellness Care Rider",CIRD_sumAssured+"</br>(Annual)",CIRD_coverage,"Life Assured","RM"+CIRD_sumAssured+" is payable upon Death or diagnosis/ happening of any one of the Critical Illnesses/ Condition as listed below, whichever occur first. " +
        "1. &nbsp&nbsp&nbsp&nbspStroke </br> " +
        "2. &nbsp&nbsp&nbsp&nbspBlindness </br> " +
        "3. &nbsp&nbsp&nbsp&nbspKidney Failure (End Stage Renal Failure) </br> " +
        "4. &nbsp&nbsp&nbsp&nbspCancer </br> " +
        "5. &nbsp&nbsp&nbsp&nbspLoss of a Single Hand or Foot by Amputation (all causes) ");                 
    //13
    var arrTPDYLA = new Array("TPD Yearly Living Allowance Rider",TPDYLA_sumAssured,TPDYLA_coverage,"Life Assured","Upon TPD of the Life Assured during the coverage term and the Life Assured remained disabled, " +
                              "RM" + TPDYLA_sumAssured + " shall be payable annually up to age 70 or death of the Life Assured, whichever is earlier. The first payment is on the 1st anniversary subsequent to the commencement of TPD.");
        
    //14
    var arrTSER = new Array("TermShield Extra Rider",TSER_sumAssured, TSER_coverage,"Life Assured","In the event of Death, TPD (prior to attaining age 65)/ OAD (after attaining age 65) of Life Assured, " +
                            "whichever is earlier, the Death/ TPD/ OAD benefit equivalent to RM " + TSER_sumAssured + " shall be payable.  TPD/OAD benefit will be paid in accordance to TPD/OAD provision. Juvenile LIEN rule shall apply.");
    
    //15
    var arrTSR = new Array("TermShield Rider",TSR_sumAssured, TSR_coverage, "Life Assured", "In the event of Death or TPD (prior to attaining age 65) of Life Assured, whichever is earlier, the Death/ TPD benefit equivalent " + 
                           "to RM " + TSR_sumAssured +  " shall be payable. TPD benefit will be paid in accordance to TPD provision. Juvenile LIEN rule shall apply.");
    
    //16
    var arrPR = new Array("Waiver of Premium Rider",PR_sumAssured, PR_coverage, PR_PayorOrSecond, "The rider Sum Assured will be paid to reduce future premium up to the expiry date of the rider upon the first occurrence of death or TPD (prior to " + 
                           " attaining age 65)/ OAD (after attaining age 65) of the Policy Owner/2nd life assured during the coverage period. Premium is guaranteed and on level basis.");
    /*
    //17
    var arrCCR = new Array("CI Care Rider",CCR_sumAssured, CCR_coverage, "Life Assured", "The rider Sum Assured will be paid to reduce future premium up to the expiry date of the rider upon the first occurrence of death or TPD (prior to " + 
                           " attaining age 65)/ OAD (after attaining age 65) of the Policy Owner/2nd life assured during the coverage period. Premium is guaranteed and on level basis.");
    
    //18
    var arrJCCR = new Array("Junior CI Care Rider",JCCR_sumAssured, JCCR_coverage, "Life Assured", "The rider Sum Assured will be paid to reduce future premium up to the expiry date of the rider upon the first occurrence of death or TPD (prior to " + 
                           " attaining age 65)/ OAD (after attaining age 65) of the Policy Owner/2nd life assured during the coverage period. Premium is guaranteed and on level basis.");
    
    //19
    var arrTCCR = new Array("Total CI Care Rider",TCCR_sumAssured, TCCR_coverage, "Life Assured", "The rider Sum Assured will be paid to reduce future premium up to the expiry date of the rider upon the first occurrence of death or TPD (prior to " + 
                           " attaining age 65)/ OAD (after attaining age 65) of the Policy Owner/2nd life assured during the coverage period. Premium is guaranteed and on level basis.");
    */
    


    
    var arrAllRiderToDisplay = new Array();
    for (i = 0 ; i< riderDisplayNo.length ; i++)
    {
        //alert("riderDisplayNo[i] = " + riderDisplayNo[i]);
        switch (parseInt(riderDisplayNo[i])){
            case 0:
                arrAllRiderToDisplay[i] = arrTitle;
                break;
            case 1:        arrAllRiderToDisplay[i] = arrADCAR;
                
                break;
            case 2:        arrAllRiderToDisplay[i] = arrADHI;
                
                break;
            case 3:        arrAllRiderToDisplay[i] = arrE1R;
                
                break;
            case 4:        arrAllRiderToDisplay[i] = arrER;
                
                break;
            case 5:        arrAllRiderToDisplay[i] = arrLR;
                
                break;
            case 6:        arrAllRiderToDisplay[i] = arrAMRR;
                
                break;
            case 7:        arrAllRiderToDisplay[i] = arrPAR;
                
                break;
            case 8:        arrAllRiderToDisplay[i] = arrATPDMLAR;
                
                break;
            case 9:        arrAllRiderToDisplay[i] = arrTPDWPR;
                
                break;
            case 10:        arrAllRiderToDisplay[i] = arrAWIR;
                
                break;
            case 11:        arrAllRiderToDisplay[i] = arrER60;
                
                break;
            case 12:        arrAllRiderToDisplay[i] = arrCIRD;
                
                break;
            case 13:        arrAllRiderToDisplay[i] = arrTPDYLA;
                
                break;
            case 14:        arrAllRiderToDisplay[i] = arrTSER;
                
                break;
            case 15:        arrAllRiderToDisplay[i] = arrTSR;
                
                break;
            
            case 16:        arrAllRiderToDisplay[i] = arrPR;
                
                break;
            default:
                break;
        }
        
        
    }
    
    //set the portion of the display table
    var arrStyle = new Array("5%","5%","5%","10%","75%");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border = "1";
    
    for (i = 0; i< arrAllRiderToDisplay.length;i++)
    {
        var tr = document.createElement('tr');
        var arrRider = arrAllRiderToDisplay[i];
        
        for (j = 0; j < arrTitle.length;j++)
        {
            
            var td = document.createElement('td');            
            td.style.width = arrStyle[j];
            
            //td.setAttribute('class','textAlignCenter');
            if (i == 0)
            {
                td.innerHTML = arrTitle[j];
            }
            
            else{
                
                td.innerHTML = arrRider[j];
                //td.setAttribute('class','tdVerticalAlign textAlignCenter');
                td.setAttribute('class','tdVerticalAlign');

                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}
function loadTableAR_ACIR_desc()//accelerated Critical Illness Rider desc
{
    
    var arrPoints = new Array ("Stroke","Heart Attack","End Stage Kidney Failure","Cancer","Coronary Artery By-Pass Surgery","Other Serious Coronary Artery Disease","Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease*","End Stage Liver Failure","Fulminant Viral Hepatitis","Coma","Benign Brain Tumor","Paralysis / Paraplegia","Blindness / Total Loss Of Sight","Deafness / Total Loss Of Hearing","Major Burns","End Stage Lung Disease","Encephalitis","Major Organ / Bone Marrow Transplant","Loss Of Speech","Brain Surgery","Heart Valve Surgery","Terminal Illness","HIV Due To Blood Transfusion","Bacterial Meningitis","Major Head Trauma","Chronic Aplastic Anemia","Motor Neuron Disease","Parkinson's Disease","Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders","Muscular Dystrophy","Surgery to Aorta","Multiple Sclerosis","Primary Pulmonary Arterial Hypertension","Medullary Cystic Disease","Severe Cardiomyopathy","Systemic Lupus Erythematosus with Lupus Nephritis");
    var table = document.createElement('table');
    
    for (i = 0 ; i<20 ; i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tdNo = document.createElement('td');
        var tdNo2 = document.createElement('td');
        if (i == 0)
        {
            td.innerHTML = "RM " + ACIR_sumAssured + " is payable upon diagnosis of any of the 36 critical  illnesses of the Life Assured during the coverage term.</br>Upon payment of the ACIR Sum Assured, the Basic Sum Assured will be reduced accordingly.</br><br/>The following 36 critical illnesses are covered:";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else if (i == 19)
        {
            
            td.innerHTML = "*Benefit  payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000. This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else{
            
            td.innerHTML = arrPoints[i-1];
            td2.innerHTML = arrPoints[(arrPoints.length/2)+i-1];
            tdNo.innerHTML = i + ". ";
            tdNo2.innerHTML = (arrPoints.length/2)+i + ". ";
            tr.appendChild(tdNo);
            tr.appendChild(td);
            tr.appendChild(tdNo2);
            tr.appendChild(td2);
            
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}

function loadTableAR_CCR_desc()
{

     var htmlStr =   "RM" + CCR_sumAssured + " is payable upon diagnosis of any of the 36 critical illnesses of the Life Assured during the coverage term, except for Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease.<br/><br/>" +
                        "The Rider Sum Assured will increase automatically at beginning of Year 6 and 16 at 25% and 50% of initial Rider Sum Assured respectively.<br/><br/>" +
                        
                        "The following 36 critical illnesses are covered :<br/><br/>" +
                        "<table id='illness' class='illness' style='border-collapse:collapse;border: 0px solid black;width: 75%;'>" +
                        "<tr>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>1.</td>" +
                        "<td width='50%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Stroke</td>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>19.</td>" +
                        "<td width='42%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Loss of Speech</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >2.</td>" +
                        "<td >Heart Attack</td>" +
                        "<td >20.</td>" +
                        "<td >Brain Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >3.</td>" +
                        "<td >End Stage Kidney Failure</td>" +
                        "<td >21.</td>" +
                        "<td >Heart Valve Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >4.</td>" +
                        "<td >Cancer</td>" +
                        "<td >22.</td>" +
                        "<td >Terminal Illness</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >5.</td>" +
                        "<td >Coronary Artery By-Pass Surgery</td>" +
                        "<td >23.</td>" +
                        "<td >HIV Due To Blood Transfusion</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >6.</td>" +
                        "<td >Other Serious Coronary Artery Disease</td>" +
                        "<td >24.</td>" +
                        "<td >Bacterial Meningitis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >7.</td>" +
                        "<td >Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease *</td>" +
                        "<td>25.</td>" +
                        "<td >Major Head Trauma</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >8.</td>" +
                        "<td >End Stage Liver Failure</td>" +
                        "<td>26.</td>" +
                        "<td >Chronic Aplastic Anemia</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >9.</td>" +
                        "<td >Fulminant Viral Hepatitis</td>" +
                        "<td >27.</td>" +
                        "<td >Motor Neuron Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >10.</td>" +
                        "<td >Coma</td>" +
                        "<td >28.</td>" +
                        "<td >Parkinson's Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >11.</td>" +
                        "<td >Benign Brain Tumor</td>" +
                        "<td >29.</td>" +
                        "<td >Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>12.</td>" +
                        "<td >Paralysis/Paraplegia</td>" +
                        "<td >30.</td>" +
                        "<td >Muscular Dystrophy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >13.</td>" +
                        "<td >Blindness /Total Loss Of Sight</td>" +
                        "<td>31.</td>" +
                        "<td>Surgery To Aorta</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>14.</td>" +
                        "<td >Deafness/Total Loss Of Hearing</td>" +
                        "<td>32.</td>" +
                        "<td >Multiple Sclerosis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>15.</td>" +
                        "<td >Major Burns</td>" +
                        "<td>33.</td>" +
                        "<td>Primary Pulmonary Arterial Hypertension</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>16.</td>" +
                        "<td>End Stage Lung Disease</td>" +
                        "<td>34.</td>" +
                        "<td >Medullary Cystic Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >17.</td>" +
                        "<td>Encephalitis</td>" +
                        "<td >35.</td>" +
                        "<td>Severe Cardiomyopathy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >18.</td>" +
                        "<td>Major Organ / Bone Marrow Transplant</td>" +
                        "<td >36.</td>" +
                        "<td>Systemic Lupus Erythematosus With Lupus Nephritis</td>" +
                        "</tr>" +
                        "</table>" +
                        "<br/>" +
                        "*Benefit payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000." +
                        "This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.<br/><br/>" +
                        
                        "This critical illness provision does not cover the following occurrences:<br/>" +
                        "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" +
                        "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                        "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/>" +
                        "Please refer to the policy contract for the precise definition of each critical illness.";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadTableAR_JCCR_desc()
{

     var htmlStr =   "RM" + JCCR_sumAssured + " is payable upon diagnosis of any of the 36 critical illnesses of the Life Assured during the coverage term, except for Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease.<br/><br/>" +
                        "The Rider Sum Assured will increase automatically at beginning of Year 6 and 16 at 25% and 50% of initial Rider Sum Assured respectively.<br/><br/>" +
                        
                        "The following 36 critical illnesses are covered :<br/><br/>" +
                        "<table id='illness' class='illness' style='border-collapse:collapse;border: 0px solid black;width: 75%;'>" +
                        "<tr>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>1.</td>" +
                        "<td width='50%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Stroke</td>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>19.</td>" +
                        "<td width='42%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Loss of Speech</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >2.</td>" +
                        "<td >Heart Attack</td>" +
                        "<td >20.</td>" +
                        "<td >Brain Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >3.</td>" +
                        "<td >End Stage Kidney Failure</td>" +
                        "<td >21.</td>" +
                        "<td >Heart Valve Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >4.</td>" +
                        "<td >Cancer</td>" +
                        "<td >22.</td>" +
                        "<td >Terminal Illness</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >5.</td>" +
                        "<td >Coronary Artery By-Pass Surgery</td>" +
                        "<td >23.</td>" +
                        "<td >HIV Due To Blood Transfusion</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >6.</td>" +
                        "<td >Other Serious Coronary Artery Disease</td>" +
                        "<td >24.</td>" +
                        "<td >Bacterial Meningitis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >7.</td>" +
                        "<td >Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease *</td>" +
                        "<td>25.</td>" +
                        "<td >Major Head Trauma</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >8.</td>" +
                        "<td >End Stage Liver Failure</td>" +
                        "<td>26.</td>" +
                        "<td >Chronic Aplastic Anemia</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >9.</td>" +
                        "<td >Fulminant Viral Hepatitis</td>" +
                        "<td >27.</td>" +
                        "<td >Motor Neuron Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >10.</td>" +
                        "<td >Coma</td>" +
                        "<td >28.</td>" +
                        "<td >Parkinson's Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >11.</td>" +
                        "<td >Benign Brain Tumor</td>" +
                        "<td >29.</td>" +
                        "<td >Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>12.</td>" +
                        "<td >Paralysis/Paraplegia</td>" +
                        "<td >30.</td>" +
                        "<td >Muscular Dystrophy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >13.</td>" +
                        "<td >Blindness /Total Loss Of Sight</td>" +
                        "<td>31.</td>" +
                        "<td>Surgery To Aorta</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>14.</td>" +
                        "<td >Deafness/Total Loss Of Hearing</td>" +
                        "<td>32.</td>" +
                        "<td >Multiple Sclerosis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>15.</td>" +
                        "<td >Major Burns</td>" +
                        "<td>33.</td>" +
                        "<td>Primary Pulmonary Arterial Hypertension</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>16.</td>" +
                        "<td>End Stage Lung Disease</td>" +
                        "<td>34.</td>" +
                        "<td >Medullary Cystic Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >17.</td>" +
                        "<td>Encephalitis</td>" +
                        "<td >35.</td>" +
                        "<td>Severe Cardiomyopathy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >18.</td>" +
                        "<td>Major Organ / Bone Marrow Transplant</td>" +
                        "<td >36.</td>" +
                        "<td>Systemic Lupus Erythematosus With Lupus Nephritis</td>" +
                        "</tr>" +
                        "</table>" +
                        "<br/>" +
                        "*Benefit payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000." +
                        "This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.<br/><br/>" +
                        
                        "This critical illness provision does not cover the following occurrences:<br/>" +
                        "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" +
                        "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                        "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/>" +
                        "Please refer to the policy contract for the precise definition of each critical illness.";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadTableAR_TCCR_desc()
{

     var htmlStr =   "RM" + TCCR_sumAssured + " is payable upon diagnosis of any of the 36 critical illnesses of the Life Assured during the coverage term, except for Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease.<br/><br/>" +
                        "The Rider Sum Assured will increase automatically at beginning of Year 6 and 16 at 25% and 50% of initial Rider Sum Assured respectively.<br/><br/>" +
                        
                        "The following 36 critical illnesses are covered :<br/><br/>" +
                        "<table id='illness' class='illness' style='border-collapse:collapse;border: 0px solid black;width: 75%;'>" +
                        "<tr>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>1.</td>" +
                        "<td width='50%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Stroke</td>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>19.</td>" +
                        "<td width='42%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Loss of Speech</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >2.</td>" +
                        "<td >Heart Attack</td>" +
                        "<td >20.</td>" +
                        "<td >Brain Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >3.</td>" +
                        "<td >End Stage Kidney Failure</td>" +
                        "<td >21.</td>" +
                        "<td >Heart Valve Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >4.</td>" +
                        "<td >Cancer</td>" +
                        "<td >22.</td>" +
                        "<td >Terminal Illness</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >5.</td>" +
                        "<td >Coronary Artery By-Pass Surgery</td>" +
                        "<td >23.</td>" +
                        "<td >HIV Due To Blood Transfusion</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >6.</td>" +
                        "<td >Other Serious Coronary Artery Disease</td>" +
                        "<td >24.</td>" +
                        "<td >Bacterial Meningitis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >7.</td>" +
                        "<td >Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease *</td>" +
                        "<td>25.</td>" +
                        "<td >Major Head Trauma</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >8.</td>" +
                        "<td >End Stage Liver Failure</td>" +
                        "<td>26.</td>" +
                        "<td >Chronic Aplastic Anemia</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >9.</td>" +
                        "<td >Fulminant Viral Hepatitis</td>" +
                        "<td >27.</td>" +
                        "<td >Motor Neuron Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >10.</td>" +
                        "<td >Coma</td>" +
                        "<td >28.</td>" +
                        "<td >Parkinson's Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >11.</td>" +
                        "<td >Benign Brain Tumor</td>" +
                        "<td >29.</td>" +
                        "<td >Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>12.</td>" +
                        "<td >Paralysis/Paraplegia</td>" +
                        "<td >30.</td>" +
                        "<td >Muscular Dystrophy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >13.</td>" +
                        "<td >Blindness /Total Loss Of Sight</td>" +
                        "<td>31.</td>" +
                        "<td>Surgery To Aorta</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>14.</td>" +
                        "<td >Deafness/Total Loss Of Hearing</td>" +
                        "<td>32.</td>" +
                        "<td >Multiple Sclerosis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>15.</td>" +
                        "<td >Major Burns</td>" +
                        "<td>33.</td>" +
                        "<td>Primary Pulmonary Arterial Hypertension</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>16.</td>" +
                        "<td>End Stage Lung Disease</td>" +
                        "<td>34.</td>" +
                        "<td >Medullary Cystic Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >17.</td>" +
                        "<td>Encephalitis</td>" +
                        "<td >35.</td>" +
                        "<td>Severe Cardiomyopathy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >18.</td>" +
                        "<td>Major Organ / Bone Marrow Transplant</td>" +
                        "<td >36.</td>" +
                        "<td>Systemic Lupus Erythematosus With Lupus Nephritis</td>" +
                        "</tr>" +
                        "</table>" +
                        "<br/>" +
                        "*Benefit payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000." +
                        "This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.<br/><br/>" +
                        
                        "This critical illness provision does not cover the following occurrences:<br/>" +
                        "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" +
                        "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                        "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/>" +
                        "Please refer to the policy contract for the precise definition of each critical illness.";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadTableAR_LDYR_desc()
{

     var htmlStr =   "RM" + LDYR_sumAssured + " is payable upon diagnosis of any of the 36 critical illnesses of the Life Assured during the coverage term, except for Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease.<br/><br/>" +
                        "The Rider Sum Assured will increase automatically at beginning of Year 6 and 16 at 25% and 50% of initial Rider Sum Assured respectively.<br/><br/>" +
                        
                        "The following 36 critical illnesses are covered :<br/><br/>" +
                        "<table id='illness' class='illness' style='border-collapse:collapse;border: 0px solid black;width: 75%;'>" +
                        "<tr>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>1.</td>" +
                        "<td width='50%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Stroke</td>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>19.</td>" +
                        "<td width='42%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Loss of Speech</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >2.</td>" +
                        "<td >Heart Attack</td>" +
                        "<td >20.</td>" +
                        "<td >Brain Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >3.</td>" +
                        "<td >End Stage Kidney Failure</td>" +
                        "<td >21.</td>" +
                        "<td >Heart Valve Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >4.</td>" +
                        "<td >Cancer</td>" +
                        "<td >22.</td>" +
                        "<td >Terminal Illness</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >5.</td>" +
                        "<td >Coronary Artery By-Pass Surgery</td>" +
                        "<td >23.</td>" +
                        "<td >HIV Due To Blood Transfusion</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >6.</td>" +
                        "<td >Other Serious Coronary Artery Disease</td>" +
                        "<td >24.</td>" +
                        "<td >Bacterial Meningitis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >7.</td>" +
                        "<td >Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease *</td>" +
                        "<td>25.</td>" +
                        "<td >Major Head Trauma</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >8.</td>" +
                        "<td >End Stage Liver Failure</td>" +
                        "<td>26.</td>" +
                        "<td >Chronic Aplastic Anemia</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >9.</td>" +
                        "<td >Fulminant Viral Hepatitis</td>" +
                        "<td >27.</td>" +
                        "<td >Motor Neuron Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >10.</td>" +
                        "<td >Coma</td>" +
                        "<td >28.</td>" +
                        "<td >Parkinson's Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >11.</td>" +
                        "<td >Benign Brain Tumor</td>" +
                        "<td >29.</td>" +
                        "<td >Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>12.</td>" +
                        "<td >Paralysis/Paraplegia</td>" +
                        "<td >30.</td>" +
                        "<td >Muscular Dystrophy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >13.</td>" +
                        "<td >Blindness /Total Loss Of Sight</td>" +
                        "<td>31.</td>" +
                        "<td>Surgery To Aorta</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>14.</td>" +
                        "<td >Deafness/Total Loss Of Hearing</td>" +
                        "<td>32.</td>" +
                        "<td >Multiple Sclerosis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>15.</td>" +
                        "<td >Major Burns</td>" +
                        "<td>33.</td>" +
                        "<td>Primary Pulmonary Arterial Hypertension</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>16.</td>" +
                        "<td>End Stage Lung Disease</td>" +
                        "<td>34.</td>" +
                        "<td >Medullary Cystic Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >17.</td>" +
                        "<td>Encephalitis</td>" +
                        "<td >35.</td>" +
                        "<td>Severe Cardiomyopathy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >18.</td>" +
                        "<td>Major Organ / Bone Marrow Transplant</td>" +
                        "<td >36.</td>" +
                        "<td>Systemic Lupus Erythematosus With Lupus Nephritis</td>" +
                        "</tr>" +
                        "</table>" +
                        "<br/>" +
                        "*Benefit payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000." +
                        "This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.<br/><br/>" +
                        
                        "This critical illness provision does not cover the following occurrences:<br/>" +
                        "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" +
                        "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                        "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/>" +
                        "Please refer to the policy contract for the precise definition of each critical illness.";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadTableAR_MSR_desc()
{

     var htmlStr =   "RM" + MSR_sumAssured + " is payable upon diagnosis of any of the 36 critical illnesses of the Life Assured during the coverage term, except for Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease.<br/><br/>" +
                        "The Rider Sum Assured will increase automatically at beginning of Year 6 and 16 at 25% and 50% of initial Rider Sum Assured respectively.<br/><br/>" +
                        
                        "The following 36 critical illnesses are covered :<br/><br/>" +
                        "<table id='illness' class='illness' style='border-collapse:collapse;border: 0px solid black;width: 75%;'>" +
                        "<tr>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>1.</td>" +
                        "<td width='50%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Stroke</td>" +
                        "<td width='4%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>19.</td>" +
                        "<td width='42%' style='padding: 0px 0px 1px 0px;text-align:left;border: 0px solid black;vertical-align: text-top;'>Loss of Speech</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >2.</td>" +
                        "<td >Heart Attack</td>" +
                        "<td >20.</td>" +
                        "<td >Brain Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >3.</td>" +
                        "<td >End Stage Kidney Failure</td>" +
                        "<td >21.</td>" +
                        "<td >Heart Valve Surgery</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >4.</td>" +
                        "<td >Cancer</td>" +
                        "<td >22.</td>" +
                        "<td >Terminal Illness</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >5.</td>" +
                        "<td >Coronary Artery By-Pass Surgery</td>" +
                        "<td >23.</td>" +
                        "<td >HIV Due To Blood Transfusion</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >6.</td>" +
                        "<td >Other Serious Coronary Artery Disease</td>" +
                        "<td >24.</td>" +
                        "<td >Bacterial Meningitis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >7.</td>" +
                        "<td >Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease *</td>" +
                        "<td>25.</td>" +
                        "<td >Major Head Trauma</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >8.</td>" +
                        "<td >End Stage Liver Failure</td>" +
                        "<td>26.</td>" +
                        "<td >Chronic Aplastic Anemia</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >9.</td>" +
                        "<td >Fulminant Viral Hepatitis</td>" +
                        "<td >27.</td>" +
                        "<td >Motor Neuron Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >10.</td>" +
                        "<td >Coma</td>" +
                        "<td >28.</td>" +
                        "<td >Parkinson's Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >11.</td>" +
                        "<td >Benign Brain Tumor</td>" +
                        "<td >29.</td>" +
                        "<td >Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>12.</td>" +
                        "<td >Paralysis/Paraplegia</td>" +
                        "<td >30.</td>" +
                        "<td >Muscular Dystrophy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >13.</td>" +
                        "<td >Blindness /Total Loss Of Sight</td>" +
                        "<td>31.</td>" +
                        "<td>Surgery To Aorta</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>14.</td>" +
                        "<td >Deafness/Total Loss Of Hearing</td>" +
                        "<td>32.</td>" +
                        "<td >Multiple Sclerosis</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>15.</td>" +
                        "<td >Major Burns</td>" +
                        "<td>33.</td>" +
                        "<td>Primary Pulmonary Arterial Hypertension</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td>16.</td>" +
                        "<td>End Stage Lung Disease</td>" +
                        "<td>34.</td>" +
                        "<td >Medullary Cystic Disease</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >17.</td>" +
                        "<td>Encephalitis</td>" +
                        "<td >35.</td>" +
                        "<td>Severe Cardiomyopathy</td>" +
                        "</tr>" +
                        "<tr>" +
                        "<td >18.</td>" +
                        "<td>Major Organ / Bone Marrow Transplant</td>" +
                        "<td >36.</td>" +
                        "<td>Systemic Lupus Erythematosus With Lupus Nephritis</td>" +
                        "</tr>" +
                        "</table>" +
                        "<br/>" +
                        "*Benefit payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000." +
                        "This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the amount of lump sum payment upon CI.<br/><br/>" +
                        
                        "This critical illness provision does not cover the following occurrences:<br/>" +
                        "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" +
                        "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                        "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/>" +
                        "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/>" +
                        "Please refer to the policy contract for the precise definition of each critical illness.";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadTableAR_CIWP_desc()// Critical Illness Rider desc
{
    
    var arrCIRDetailsPoint = new Array ("Stroke","Heart Attack","End Stage Kidney Failure","Cancer","Coronary Artery By-Pass Surgery","Other Serious Coronary Artery Disease","Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease*","End Stage Liver Failure","Fulminant Viral Hepatitis","Coma","Benign Brain Tumor","Paralysis / Paraplegia","Blindness / Total Loss Of Sight","Deafness / Total Loss Of Hearing","Major Burns","End Stage Lung Disease","Encephalitis","Major Organ / Bone Marrow Transplant","Loss Of Speech","Brain Surgery","Heart Valve Surgery","Terminal Illness","HIV Due To Blood Transfusion","Bacterial Meningitis","Major Head Trauma","Chronic Aplastic Anemia","Motor Neuron Disease","Parkinson's Disease","Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders","Muscular Dystrophy","Surgery to Aorta","Multiple Sclerosis","Primary Pulmonary Arterial Hypertension","Medullary Cystic Disease","Severe Cardiomyopathy","Systemic Lupus Erythematosus with Lupus Nephritis");
    var table = document.createElement('table');
    
    for (i = 0 ; i<20 ; i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tdNo = document.createElement('td');
        var tdNo2 = document.createElement('td');
        if (i == 0)
        {
            td.innerHTML = "The  rider Sum Assured will be paid to reduce future premium up to expiry date of the rider upon diagnosis of any of the 36 critical illnesses covered of the life assured during the coverage period. Premium is guaranteed and on level basis.<br/><br/> The  following 36 critical illnesses are covered:";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else if (i == 19)
        {
            
            td.innerHTML = "*Benefit  payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000. This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the benefit payable upon CI.";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else{
            
            td.innerHTML = arrCIRDetailsPoint[i-1];
            td2.innerHTML = arrCIRDetailsPoint[(arrCIRDetailsPoint.length/2)+i-1];
            tdNo.innerHTML = i + ". ";
            tdNo2.innerHTML = (arrCIRDetailsPoint.length/2)+i + ". ";
            tr.appendChild(tdNo);
            tr.appendChild(td);
            tr.appendChild(tdNo2);
            tr.appendChild(td2);
            
        }
        
        table.appendChild(tr);
    }
    
    return table;
}

function loadTableAR_LCWP_desc()// 
{
    
    var arrLCWPDetailsPoint = new Array ("Stroke","Heart Attack","End Stage Kidney Failure","Cancer","Coronary Artery By-Pass Surgery","Other Serious Coronary Artery Disease","Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease*","End Stage Liver Failure","Fulminant Viral Hepatitis","Coma","Benign Brain Tumor","Paralysis / Paraplegia","Blindness / Total Loss Of Sight","Deafness / Total Loss Of Hearing","Major Burns","End Stage Lung Disease","Encephalitis","Major Organ / Bone Marrow Transplant","Loss Of Speech","Brain Surgery","Heart Valve Surgery","Terminal Illness","HIV Due To Blood Transfusion","Bacterial Meningitis","Major Head Trauma","Chronic Aplastic Anemia","Motor Neuron Disease","Parkinson's Disease","Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders","Muscular Dystrophy","Surgery to Aorta","Multiple Sclerosis","Primary Pulmonary Arterial Hypertension","Medullary Cystic Disease","Severe Cardiomyopathy","Systemic Lupus Erythematosus with Lupus Nephritis");
    var table = document.createElement('table');
    
    for (i = 0 ; i<20 ; i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tdNo = document.createElement('td');
        var tdNo2 = document.createElement('td');
        if (i == 0)
        {
            td.innerHTML = "The rider sum assured will be paid to reduce future premium up to the expiry date of the rider the first occurrence of upon death, TPD (prior to attaining age 65)/ OAD (after attaining age 65) or diagnosis of any of 36 critical illnesses covered of the Policy Owner/2nd life assured during the coverage period. Premium is guaranteed and on level basis. <br/><br/>The following 36 critical illnesses are covered:";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else if (i == 19)
        {
            
            td.innerHTML = "*Benefit  payment under this illness is limited to 10% of the Critical Illness coverage under this plan subject to a maximum of RM 25,000. This benefit is payable once only and shall be deducted from the coverage of this plan, thereby reducing the benefit payable upon CI, Death or TPD..";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else{
            
            td.innerHTML = arrLCWPDetailsPoint[i-1];
            td2.innerHTML = arrLCWPDetailsPoint[(arrLCWPDetailsPoint.length/2)+i-1];
            tdNo.innerHTML = i + ". ";
            tdNo2.innerHTML = (arrLCWPDetailsPoint.length/2)+i + ". ";
            tr.appendChild(tdNo);
            tr.appendChild(td);
            tr.appendChild(tdNo2);
            tr.appendChild(td2);
            
        }
        
        table.appendChild(tr);
    }
    
    return table;
}
//=============================================================== END 2B. attaching rider List ===============================================================

function loadPage1Data()
{
    var coverage = parseInt(gdata.SI[0].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
    var coverage1 = 100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
    $(".BasicSA").html(formatCurrency(gdata.SI[0].BasicSA));
    $(".coverage").html(coverage);
    $(".coverage1").html(coverage1);
}

function loadSectionTwo (id)
{
    var arrNoTwo = new Array();
    arrNoTwo[0] = "What are the covers / benefits provided?";
    arrNoTwo[1] = "A) Basic Plan";
    arrNoTwo[2] = "The  Sum Assured for this plan is RM <span class='BasicSA'>{BasicSA}</span> and the duration of the coverage is <span class='coverage1'>{coverage1}</span> years or upon termination, whichever occurs first.";
    
    for (i = 1 ;i<=arrNoTwo.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        
        if (i == 1)
        {
            td.innerHTML = "2.";
            td.setAttribute("class", "numbering");
            td2.setAttribute("class", "bold");
            td2.innerHTML = arrNoTwo[i-1];
            tr.appendChild(td);
            tr.appendChild(td2);
            
        }
        else if (i == 2)
        {
            td.innerHTML = arrNoTwo[1];
            td.setAttribute("class", "numbering");
            td.colSpan = "2";
            
            td2.setAttribute("class", "bold");
            tr.appendChild(td);
            
        }
        else{
            td.innerHTML = "&nbsp";
            td2.innerHTML = arrNoTwo[i-1];
            tr.appendChild(td);
            tr.appendChild(td2);
        }
        
        id.appendChild(tr);
        
    }
    //id.appendChild(lineBreak());
}

function loadSectionTwoB(id)
{
    // id.id = currPage;
    
    document.getElementById('tableTwo4').id = currPage;
    var tr = document.createElement('tr');
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    
    if (currPage == "page4Content-1")
    {
        document.getElementById('page4Title').id = "page4Title-1";
        document.getElementById('page4Title-1').style.display = "inline";
    }
    //alert(" load2BRider = " + load2BRider);
    td.innerHTML = "&nbsp";
    if (load2BRider == "ACIR")
    {
        td2.appendChild(loadTableAR_ACIR());
        
    }
    //else if (load2BRider == "CIR")
    else if (load2BRider == "CIWP")
    {
        td2.appendChild(loadTableAR_CIWP());
        
    }
    else if (load2BRider == "CCR")
    {
        td2.appendChild(loadTableAR_CCR());
        
    }
    else if (load2BRider == "JCCR")
    {
        td2.appendChild(loadTableAR_JCCR());
        
    }
    else if (load2BRider == "TCCR")
    {
        td2.appendChild(loadTableAR_TCCR());
        
    }
    else if (load2BRider == "LDYR")
    {
        td2.appendChild(loadTableAR_LDYR());
        
    }
    else if (load2BRider == "MSR")
    {
        td2.appendChild(loadTableAR_MSR());
        
    }
    else if (load2BRider == "OTHERS")
    {
        td2.appendChild(loadTableAR());
        
    }
    else if (load2BRider == "LCWP")
    {
        td2.appendChild(loadTableAR_LCWP());
        
    }
    tr.appendChild(td);
    tr.appendChild(td2);
    
    document.getElementById(currPage).appendChild(tr);
}

function lineBreak()
{
    var tempTR = document.createElement('tr');
    var tempTD = document.createElement('td');
    tempTD.innerHTML = "&nbsp";
    tempTR.appendChild(tempTD);
    
    return tempTR;
}

function loadTableFundChosen()
{
    //var VU2023 = gdata.SI[0].UL_Page3.data[0].VU2023; //5
    var VU2025 = parseInt(gdata.SI[0].UL_Page3.data[0].VU2025); //6
    var VU2028 = parseInt(gdata.SI[0].UL_Page3.data[0].VU2028); //7
    var VU2030 = parseInt(gdata.SI[0].UL_Page3.data[0].VU2030); //8
    
    var VU2035 = parseInt(gdata.SI[0].UL_Page3.data[0].VU2035); //9
    var VUDana = parseInt(gdata.SI[0].UL_Page3.data[0].VUDana); //10
    var VURet  = parseInt(gdata.SI[0].UL_Page3.data[0].VURet);  //30
    var VUCash = parseInt(gdata.SI[0].UL_Page3.data[0].VUCash); //25
    var VUVenture = parseInt(gdata.SI[0].UL_Page3.data[0].VUVenture); //25
    
    // var arrTitle = new Array("Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?","Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?");
    var arrFund = new Array("Fund","HLA EverGreen 2025","HLA EverGreen 2028","HLA EverGreen 2030", "HLA EverGreen 2035");
    var arrFundAlloc = new Array("Fund Allocation (%)",VU2025,VU2028,VU2030,VU2035);
    var arrMGUPAFMA = new Array("Minimum Guaranteed Unit Price at Fund Maturity applicable?","Yes","Yes","Yes","Yes");
    
    var arrFund2 = new Array("Fund","HLA Venture Flexi Fund","HLA Dana Suria","HLA Secure Fund","HLA Cash Fund");
    var arrFundAlloc2 = new Array("Fund Allocation (%)",VUVenture, VUDana,VURet,VUCash);
    var arrMGUPAFMA2 = new Array("Minimum Guaranteed Unit Price at Fund Maturity applicable?","No","No","No","No");
    var table = document.createElement('table');
    
    table.setAttribute("class", "normalTable");
    
    table.border = "1";
    for (i = 0 ;i < arrFund.length;i++)
    {
        var tr = document.createElement('tr');
        
        
        for (j = 0; j<6 ; j++)
        {
            var td = document.createElement('td');
            
            
            if (i == 0)
            {
                td.style.textAlign = "left";
            }
            
            td.setAttribute("class", "fundChosenWidth");
            switch (j)
            {
                case 0:
                {
                    td.innerHTML = arrFund[i];
                    
                }
                    break;
                case 1:
                {
                    td.innerHTML = arrFundAlloc[i];
                }
                    break;
                case 2:
                {
                    td.innerHTML = arrMGUPAFMA[i];
                }
                    break;
                case 3:
                {
                    td.innerHTML = arrFund2[i];
                }
                    break;
                case 4:
                {
                    td.innerHTML = arrFundAlloc2[i];
                }
                    break;
                case 5:
                {
                    td.innerHTML = arrMGUPAFMA2[i];
                }
                    break;
                    
                default:
                    break;
            }
            
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
}

function BumpModeDesc(bumpmode, option){
    if(bumpmode == 'A'){
        if(option == 1){
            return "Annually";    
        }
        else{
            return "Annual";
        }
        
    }
    else if(bumpmode == 'S'){
        if(option == 1){
            return "Semi-Annually";    
        }
        else{
            return "Semi-Annual";
        }
        
    }
    else if(bumpmode == 'Q'){
        if(option == 1){
            return "Quarterly";
        }
        else
        {
            return "Quarter";
        }
        
    }
    else{
        if(option == 1){
            return "Monthly";    
        }
        else{
            return "Month";
        }
    }
}

function loadPremiumPay()
{
    var arrProdArr = getProdList("annualPremium");
    var arrWidthPortion = new Array("35%","10%","20%","35%");
    
    var str ="<tr style='font-weight: bold;'><td rowspan='2'>Plan / Rider</td><td rowspan='2' style='text-align: center;'>Type</td><td rowspan='2' style='text-align: center;'>Insured Lives</td><td style='text-align: center;'>Initial Premium</td></tr><tr style='font-weight: bold;'><td style='text-align: center;'>" + BumpModeDesc(gdata.SI[0].BumpMode, 1) + "(RM)</td></tr>";
    var table = document.createElement('table');
    table.innerHTML = str;
    
    table.setAttribute("class", "normalTable");
    table.style.width = "1100px";
    table.border = "1";
    
    for (i = 0 ;i < arrProdArr.length;i++)
    {
        var tr = document.createElement('tr');
        
        for (j=0; j<arrWidthPortion.length ; j++)
        {
            var td = document.createElement('td');
            td.style.width = arrWidthPortion[j];
            
            if (j != 0)
            {
                td.style.textAlign ="center";
            }
            switch (j)
            {
                case 0:
                    td.innerHTML = arrProdArr[i].prodName;
                    break;
                case 1:
                    td.innerHTML = arrProdArr[i].prodType;
                    break;
                case 2:
                    td.innerHTML = arrProdArr[i].prodInsuredLives;
                    break;
                case 3:
                    td.innerHTML = arrProdArr[i].prodInitPremAnn;
                    break;
                default:
                    break;
                    
                    
            }
            tr.appendChild(td);
            
        }
        
        table.appendChild(tr);
        
    }
    if(isNeedSplit == "YES")
    {
        /*
        var trTemp = document.createElement('tr');
        
        var row = "<td colspan='2'>Total</td><td></td><td style='text-align:center'>3506.10</td>";
        trTemp.innerHTML = row;
        table.appendChild(trTemp);
        */

    }
    return table;
}


function loadPremiumDuration()
{
    //alert("isNeedSplit = " + isNeedSplit);
    
    //var arrProdArr = getProdList("premiumDuration");

    if (isNeedSplit == "NO")
    {
        var arrProdArr = getProdList("premiumDuration");
        
    }
    else
    {
        if( ecar60Exist )
        {
            var arrProdArr = getProdList("premiumDuration");
        }else
        {
            if (isNeedSplitFirstPart == "YES")
            {
                var arrProdArr = getProdList("premiumDuration").slice(0,splitCount-3);
            }
            else
            {
                var arrProdArr = getProdList("premiumDuration").slice(splitCount-3,getProdList("premiumDuration").length);
            }
        }
    }

    // var arrTitle = new Array("Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?","Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?");
    /*var arrPlanRider = new Array("HLA Everlife Plus","Critical Illness Waiver of Premium Rider","Acc. Weekly Indemnity Rider","TPD Waiver of Premium rider","Acc. TPD Monthly Living Allowance Rider","Personal Accident Rider","Acc. Medical Reimbursement rider","MedGLOBAL IV Plus","LifeShield Rider","Acc. Daily Hospitalisation Income Rider","Acc. Death & Compassionate Allowance Rider","Accelerated Critical Illness","HLA Major Medi","Critical Illness Waiver of Premium Rider");
     var arrType = new Array("Basic Plan","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider");
     var arrInsuredLives = new Array("Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured");
     
     var arrInitialPremiumAnn = new Array("100","68","68","68","68","68","68","68","68","68","68","68","68","68","68");
     */
    var arrWidthPortion = new Array("35%","10%","20%","35%");
    
    var str = "<tr class='bold'><td>Plan / Rider</td><td style='text-align: center;'>Type</td><td style='text-align: center;'>Insured Lives</td><td style='text-align: center;'>Premium payable until insured life's age</td></tr>";
    var table = document.createElement('table');
    table.innerHTML = str;
    
    table.setAttribute("class", "normalTable");
    table.style.width = "1100px";
    table.border = "1";
    
    for (i = 0 ;i < arrProdArr.length;i++)
    {
        
        var tr = document.createElement('tr');
        
        for (j = 0; j<4 ; j++)
        {
            var td = document.createElement('td');
            td.style.width = arrWidthPortion[j];
            if (j != 0)
            {
                td.style.textAlign ="center";
            }
            switch (j)
            {
                case 0:
                    td.innerHTML = arrProdArr[i].prodName;
                    break;
                case 1:
                    td.innerHTML = arrProdArr[i].prodType;
                    break;
                case 2:
                    td.innerHTML = arrProdArr[i].prodInsuredLives;
                    break;
                case 3:
                    //alert("arrProdArr[i].prodInitPremAnn = " + arrProdArr[i].prodInitPremAnn);
                    td.innerHTML = arrProdArr[i].prodInitPremAnn;
                    break;
                default:
                    break;
                    
            }
            tr.appendChild(td);
            
        }
        
        table.appendChild(tr);
        
    }
    
    return table;
}//loadPremiumDuration

//
function loadAttachRider()//attach rider for 6B
{
    
    //var arrRider = getRiderList().slice(0,2)
    var arrRider = arrLoadRider;
    //var arrRider = getRiderList();
    //var arrExclusions = new Array(loadAttachRider_CIRDetail());
    var ARheader = "<tr class='bold'><td class='normalTableTD'>Rider(s)</td><td class='normalTableTD'>Exclusions</td></tr>";
    
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.innerHTML = ARheader;
    table.style.width = '1130px';
    for (i = 0;i<arrRider.length;i++)
    {
        var tr = document.createElement('tr');
        
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','alignTop normalTableTD');
        td2.setAttribute('class','normalTableTD');
        //alert("arrRider[i].riderName = " + arrRider[i].riderName);
        td.innerHTML = arrRider[i].riderName;
        td2.innerHTML = arrRider[i].arrDetails.outerHTML;
        tr.appendChild(td);
        tr.appendChild(td2);
        
        table.appendChild(tr);
        
    }
    
    return table;
}

function loadAttachRider_ACIRDetail()//accelerated critical illness rider details
{
    
    
}
function loadAttachRider_ADHIRDetail()
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    
    var arrDetails = new Array();
    arrDetails[0] = "Flying or taking part in any aerial activities except where traveling in an aircraft as a fare-paying passenger and not as aircrew nor for the purpose of any trade or technical operation in or on the aircraft;";
    arrDetails[1] = "Self-inflicted Injury, suicide or attempted suicide, provoked murder or assault or being under the influence of drugs/ narcotics/ alcohol of any kind;";
    arrDetails[2] = "Engaging in or taking part in professional or semi-professional sports";
    arrDetails[3] = "Engaging in racing of any kind (other than on foot), mountain or rock climbing necessitating the use of ropes or guides, winter sports, underwater pastimes,water skiing, football, polo, hunting, show jumping, caving, pot-holing, boxing or wrestling;";
    arrDetails[4] = "War, invasion, act of foreign enemy, hostilities or warlike operations (whether war be declared or not), civil war, military or usurped power;";
    arrDetails[5] = "Direct participation in strikes, riots, rebellion, revolution, civil commotion or insurrection;";
    arrDetails[6] = "Active duty in the armed forces (whether voluntary or otherwise);";
    arrDetails[7] = "Sickness or disease of any kind caused by or infected by or in any way attributed to virus, parasite, bacteria or any micro-organism including where the virus, parasite, bacteria or micro-organism is introduced and/ or caused by bites of insects or is sexually transmitted;";
    arrDetails[8] = "Any medical or surgical treatment (except those necessitated by injuries covered by this Rider);";
    arrDetails[9] = "Committing or attempting to commit any unlawful act;";
    arrDetails[10] = "Any disease, sickness or Congenital Conditions;";
    arrDetails[11] = "Any accidental injuries as a result of the mental defect;";
    arrDetails[12] = "Human Immune-deficiency Virus (HIV) and/ or any HIV related illness including AIDS and/ or any mutant derivations or variations thereof;";
    arrDetails[13] = "Pregnancy, childbirth, miscarriage or any complications related to the same;";
    arrDetails[14] = "Any dental treatment unless necessitated by Injury covered under this Rider.";
    
    var tdHead = "<tr class='6BTable'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
    //var div = document.createElement('div');
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    table.innerHTML = tdHead;
    
    
    for (i = 0; i<arrDetails.length ;i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        td.setAttribute('class','alignTop');
        td.innerHTML = arrbulletAlphabet[i];
        td2.innerHTML = arrDetails[i];
        
        
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    
    return table;
    
}
function loadAttachRider_CIRDetail()
{
    
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)");
    var arrDetailsPoints = new Array("Cancer","Coronary artery disease requiring surgery","heart attack","Other serious coronary artery disease");
    
    var arrDetails = new Array();
    arrDetails[0] = "An episode of coronary artery or ischaemic heart disease that occurred before the Issue Date or any reinstatement  date, whichever is later";
    arrDetails[1] = "Diagnosis of the critical illness other than those specified under item (iii) below within 30 days from the Issue Date or any reinstatement  date, whichever is later";
    arrDetails[2] = "Diagnosis of the critical illness specified below within 60 days from the Issue Date or any reinstatement  date, whichever is later: </br>" + loadDetailsAR(arrbulletAlphabet,arrDetailsPoints);
    arrDetails[3] = "Other than the first incidence of the critical illnesses. The exceptions to this clause are coronary artery disease and AIDS.";
    arrDetails[4] = "Death of the life assured within 28 days following the date of diagnosis of any of the critical illness.";
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    
    
    var tdHead = "<tr class='6BTable'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
    //var div = document.createElement('div');
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    table.innerHTML = tdHead;
    
    
    for (i = 0; i<arrDetails.length ;i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        td.setAttribute('class','alignTop');
        td.innerHTML = arrbulletI[i];
        td2.innerHTML = arrDetails[i];
        
        
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    
    return table;
    
    
}

function loadAttachRider_CIRD_Detail()
{
    var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(a) &nbsp&nbsp Critical Illness/ Condition resulting from Acquired Immuno Deficiency Syndrome (AIDS), AIDS-related complex or infection by Human Immuno Deficiency Virus (HIV) unless the condition or disease or infection arose as a result of blood transfusion in accordance with Critical Illness/ Condition definitions of the Rider; or </br> " + 
                    "(b) &nbsp&nbsp Pre-existing Illness (not disclosed at Rider application) which existed before the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is the latest, where Pre-existing Illness shall mean disabilities that the Life Assured has reasonable knowledge of. A Life Assured may be considered to have reasonableknowledge of a pre-existing condition where the condition is one (1) for which: </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (i) &nbsp&nbsp&nbsp&nbsp the Life Assured had received or is receiving treatment;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (ii) &nbsp&nbsp medical advice, diagnosis, care or treatment has been recommended;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (iii) &nbsp clear and distinct symptoms are or were evident;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (iv) &nbsp its existence would have been apparent to a reasonable person in the circumstances.  </br> " + 
                    "(c) &nbsp&nbsp Critical Illness/ Condition occurring within sixty (60) days after the Issue Date, Alteration Effective Date or Reinstatement Date; whichever is the latest; or   </br> " + 
                    "(d) &nbsp&nbsp Critical Illness/ Condition resulting from any self-inflicted injuries while sane or insane; whether Critical Illness/ Condition was caused directly or indirectly   as a result thereof; or " +
                    "(e) Critical Illness/ Condition caused by willful misuse of drugs. ";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}

function loadAttachRider_CCR_Detail()
{
    var htmlStr =   "This critical illness provision does not cover the following occurrences:<br/> " +
                    "i.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; any episode of coronary artery or ischemic heart disease which occurs before the Issue Date or any reinstatement date of the Policy;<br/>" + 
                    "ii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from the Issue Date or any reinstatement date, whichever is later;<br/>" +
                    "iii.&nbsp;&nbsp;&nbsp;&nbsp; Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date or any reinstatement date, whichever is later:<br/>" +
                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Angioplasty and other invasive treatment for coronary artery disease<br/> " + 
                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/> " + 
                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/> " +
                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/> " + 
                    "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/><br/> " + 
                    "Please refer to the policy contract for the precise definition of each critical illness. "; 
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}

function loadAttachRider_TCCR_Detail()
{
    var htmlStr =   "The critical illness provision does not cover the following occurrences:<br/> " +
                    "(i)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;any episode of coronary artery or ischemic heart disease which occurs before the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider;<br/> " +
                    "(ii)&nbsp;&nbsp;&nbsp;&nbsp;Diagnosis of the dread disease other than those specified under item (iii) below within thirty (30) days from Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is the latest;<br/> " +
                    "(iii)&nbsp;&nbsp;&nbsp;&nbsp;Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is the latest:<br/> " +
                    "(a)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cancer<br/> " +
                    "(b)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Coronary artery disease requiring surgery<br/> " +
                    "(c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Heart attack<br/> " +
                    "(d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other serious coronary artery disease<br/> " +
                    "(iv)&nbsp;&nbsp;&nbsp;&nbsp;any incidence of any Critical Illnesses other than the first incidence of any Critical Illnesses from the same severity level of same category.<br/> " +
                    "Please refer to the policy contract for the precise definition of each critical illness.; " 
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}

function loadAttachRider_JCCR_Detail()
{
    var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(i) &nbsp&nbsp any episode of coronary artery or ischemic heart disease which occurs before the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider; </br> " + 
                    "(ii) &nbsp&nbsp Diagnosis of the dread disease other than those specified under item (iv) below within thirty (30) days from Issue Date, Alteration Effective Date or at any Reinstatement Date,  whichever is the latest; </br> " + 
                    "(iii) Diagnosis of the dread disease specified below within sixty (60) days from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is the  latest:" +
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp; Angioplasty and Other Invasive Treatments for Major Coronary Artery Disease  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp Cancer  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp Coronary Artery By-Pass Surgery  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp Heart attack " +
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (e) Other Serious Coronary Artery Disease" +
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (f) Dread disease as per List A  </br> " + 
                    "Please refer to the policy contract for the precise definition of each critical illness. ";
                    
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}

function loadAttachRider_LDYR_Detail()
{
    var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "1. Pre-Cancerous Protection <br/> " +
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a)   any diagnosis of a Carcinoma-in-situ within one hundred and twenty (120) days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider whichever is the later; <br/> " +
                    "(b)   any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named. <br/> " +
                    "(c)   Death of the life assured within seven (7) days following the date of diagnosis of any of the Female Cancer. <br/> " +
                          "Only 1 claim is allowed for this coverage. <br/><br/> " +
                          
                    "2. Intermediate-Cancerous & Female Cancer Protection <br/> " +
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a)   any diagnosis of illness stated above within 60 days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider whichever is the later; <br/> " +
                    "(b)   any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named; <br/> " +
                    "(c)   Death of the Life Assured within seven (7) days following the date of diagnosis of any of the Female Cancer. <br/><br/> " +
                    
                    "3. Specific Female Illness Protection <br/> " +
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a)   any diagnosis of any illness stated above within 60 days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider whichever is the later; <br/> " +
                    "(b)   any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named; <br/> " +
                    "(c)   Death of the Life Assured within thirty (30) days following the date of diagnosis of any of the Specific Female Illness mentioned above. <br/></br> " +
                    
                    "4. Medical Procedure Coverage <br/> " +
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a)   Breast Reconstructive Surgery following a mastectomy within sixty days (60) days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Policy  whichever is the later; <br/> " +
                    "(b)   Facial Re-constructive surgery for face and neck disfigurement due to accident and Skin grafting due to accidental burns occurring before the Issue Date, Alteration <br/> " +
                    "Effective  Date or at any Reinstatement Date of this Rider whichever is the later;  <br/> " +
                    "(c)   any incidence of any of the above stated conditions other than the first incidence; <br/> " +
                    "(d)   Death of the Life Assured within thirty (30) days following the date of Breast Reconstructive Surgery following a mastectomy. <br/></br> " +
                    
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a) Any hospital confinement due to ChildBirth within two years of the Issue Date, Alteration Effective Date or at any Reinstatement Date of this Benefit whichever is the later; <br/> " +
                    "(b) Any hospital confinement due to ChildBirth other than the first two claims admitted under this benefit <br/></br> " +
                    
                    "The following situations, conditions or illnesses are excluded: <br/> " +
                    "(a). A pre-existing condition where the existence of any signs or symptoms for which treatment, medication, consultation, advice or diagnosis has been sought or received by <br/> " +
                    "the Mother or would have caused an ordinary prudent person to seek treatment, diagnosis or cure, prior to the cover start date of the benefit or the date of reinstatement (if any); <br/> " +
                    "(b). Elective termination of pregnancy other than for medical reasons where medical reasons here shall mean a recommendation from a specialist that the pregnancy will endanger the life of the Life Assured (Mother); <br/> " +
                    "(c). Death, which arises as a direct result of an intentional or deliberate act, or omission of the policy owner,  the parents of the foetus or infant, or someone who lives with or supervises the child; <br/> " +
                    "(d). Complications of pregnancy resulting from infertility treatment including In Vitro Fertilisation (IVF); <br/> " +
                    "(e). a deliberate act for example but not limited to, taking intoxicating liquor, drugs or poison, suicide or attempted suicide or intentional self-injury while sane or insane; <br/> " +
                    "(f).  the use of unprescribed drugs where such drugs are required by law to be prescribed by a registered Medical Practitioner; <br/> " +
                    "(g). is caused directly or indirectly by the existence of Acquired Immune Deficiency Syndrome (AIDS) or the presence of any Human Immuno-deficiency Virus (HIV) infection; <br/> " +
                    "(h). any unlawful, criminal or deliberate act or omission, direct participation in riot, strike or civil commotion. <br/> ";
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}

function loadAttachRider_MSR_Detail()
{
    var htmlStr =   "1. <u><b>Pre-Cancerous Protection</b></u></br> " +
                    "The following situations, conditions or illnesses are excluded: </br> " + 
                    "(a) &nbsp&nbsp any diagnosis of a Carcinoma-in-situ within one hundred and twenty (120) days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the  Policy whichever is the later;  </br> " + 
                    "(b) &nbsp&nbsp any incidence of any Carcinoma-in-situ other than the first incidence of any Carcinoma-in-situ; </br> " + 
                    "(c) &nbsp&nbsp any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named.   </br> " + 
                    "(d) &nbsp&nbsp Death of the life assured within seven (7) days following the date of diagnosis of any of the Male Cancer.</br> " +
                    "Only 1 claim is allowed for this coverage</br></br>"  +
                    "2. <u><b>Intermediate-Cancerous & Male Cancer Protection</b></u></br> " +
                    "The following situations, conditions or illnesses are excluded: </br></br> " + 
                    "(a) any diagnosis of illness stated above within 60 days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider whichever is the later;</br>" +
                    "(b) any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named;</br>" +
                    "(c) Death of the life assured within seven (7) days following the date of diagnosis of any of the Male Cancer.</br></br>" + 
                    "3. <u><b>Specific Male Illness Protection</b></u></br> " +
                    "The following situations, conditions or illnesses are excluded: </br> " + 
                    "(a) any diagnosis of any illness stated above within 60 days of the Issue Date, Alteration Effective Date or at any Reinstatement Date of the Rider whichever is the later;</br> " + 
                    "(b) any diagnosis of Acquired Immune Deficiency Syndrome (AIDS) or AIDS Related Complex howsoever this condition or illness may have been acquired or may be named;</br> " + 
                    "(c) Death of the life assured within thirty (30) days following the date of diagnosis of any of the Male Specified Illnesses mentioned above.</br> " +
                    "4. <u><b>Medical Procedure Coverage</b></u></br> " +
                    "The following situations, conditions or illnesses are excluded: </br> " + 
                    "(a) Facial/neck disfigurement as a result of an accident occurring before the Issue Date, Alteration Effective Date or at any Reinstatement Date of this Rider whichever is the later; </br> " +
                    "(b) any incidence of the above stated conditions other than the first incidence.</br></br> ";

    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
}
    
function loadAttachRider_ADCARDetail() // acc.death & compensionate allowance rider // acc. daily hospitalisation income rider
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    
    var arrDetails = new Array();
    arrDetails[0] = "Flying or taking part in any aerial activities except where traveling in an aircraft as a fare-paying passenger and not as aircrew nor for the purpose of any trade or technical operation in or on the aircraft;";
    arrDetails[1] = "Self-inflicted Injury, suicide or attempted suicide, provoked murder or assault or being under the influence of drugs/ narcotics/ alcohol of any kind;";
    arrDetails[2] = "Engaging in or taking part in professional or semi-professional sports";
    arrDetails[3] = "Engaging in racing of any kind (other than on foot), mountain or rock climbing necessitating the use of ropes or guides, winter sports, underwater pastimes,water skiing, football, polo, hunting, show jumping, caving, pot-holing, boxing or wrestling;";
    arrDetails[4] = "War, invasion, act of foreign enemy, hostilities or warlike operations (whether war be declared or not), civil war, military or usurped power;";
    arrDetails[5] = "Direct participation in strikes, riots, rebellion, revolution, civil commotion or insurrection;";
    arrDetails[6] = "Active duty in the armed forces (whether voluntary or otherwise);";
    arrDetails[7] = "Sickness or disease of any kind caused by or infected by or in any way attributed to virus, parasite, bacteria or any micro-organism including where the virus, parasite, bacteria or micro-organism is introduced and/ or caused by bites of insects or is sexually transmitted;";
    arrDetails[8] = "Committing or attempting to commit any unlawful act;";
    arrDetails[9] = "Any accidental injuries as a result of the mental defect;";
    arrDetails[10] = "Miscarriage or any complications related to the same;";
    arrDetails[11] = "Any dental treatment unless necessitated by Injury covered under this Rider.";
    
    var tdHead = "<tr class='6BTable'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
    //var div = document.createElement('div');
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    table.innerHTML = tdHead;
    
    
    for (i = 0; i<arrDetails.length ;i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        td.setAttribute('class','alignTop');
        td.innerHTML = arrbulletAlphabet[i];
        td2.innerHTML = arrDetails[i];
        
        
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    
    return table;
    
}

function loadAttachRider_EC1RDetail()
{
    var arrDetailsPoints = new Array("from any self-inflicted bodily injury while sane or insane;","from any nervous disorder or mental illness;","from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or","from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion");
    
    var arrDetails = new Array();
    arrDetails[0] = "Death of the Life Assured due to suicide during the first 12 months, from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever islatest.";
    arrDetails[1] = "Total and Permanent Disability resulted directly or indirectly:</br>" + loadDetailsAR(["-","-","-","-","-"],arrDetailsPoints);
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    
    
    var tdHead = "<tr class='6BTable'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
    //var div = document.createElement('div');
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    table.innerHTML = tdHead;
    
    
    for (i = 0; i<arrDetails.length ;i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        td.setAttribute('class','alignTop');
        td.innerHTML = arrbulletI[i];
        td2.innerHTML = arrDetails[i];
        
        
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    
    return table;
    
}
function loadAttachRider_TPDWPR()
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    var arrDetailsPoints = new Array("from any self-inflicted bodily injury while sane or insane;","from any nervous disorder or mental illness;","from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or","from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion");
    
    var arrDetails = new Array();
    arrDetails[0] = "Total and Permanent Disability resulted directly or indirectly:</br>" + loadDetailsAR(arrbulletAlphabet,arrDetailsPoints);
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    
    
    var tdHead = "<tr class='6BTable'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
    //var div = document.createElement('div');
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    table.innerHTML = tdHead;
    
    
    for (i = 0; i<arrDetails.length ;i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        td.setAttribute('class','alignTop');
        td.innerHTML = arrbulletI[i];
        td2.innerHTML = arrDetails[i];
        
        
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    
    
    return table;
    
}

function loadAttachRider_TPDYLADetail()
{
    var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "i. Total and Permanent Disability resulted directly or indirectly:<br/>" +
                    "&nbsp&nbsp  (a) from any self-inflicted bodily injury while sane or insane;<br/>" +
                    "&nbsp&nbsp  (b) from any nervous disorder or mental illness;<br/> " +
                    "&nbsp&nbsp  (c) from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or<br/> " +
                    "&nbsp&nbsp  (d) from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion. "
                    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadAttachRider_TSERDetail()
{
   var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(i) &nbsp&nbsp Death of the Life Assured due to suicide during the first 12 months, from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is latest. <br/>" +
                    "(ii) &nbsp&nbsp ii. Total and Permanent Disability resulted directly or indirectly: </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp from any self-inflicted bodily injury while sane or insane;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp from any nervous disorder or mental illness;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion.  </br> " + 
                    "(iii) &nbsp&nbsp Old Age Disablement resulted directly or indirectly:   </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp from any self-inflicted bodily injury while sane or insane;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp from any nervous disorder or mental illness;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion.  </br> ";
                    
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadAttachRider_TSRDetail()
{
   var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(i) &nbsp&nbsp Death of the Life Assured due to suicide during the first 12 months, from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is latest. <br/>" +
                    "(ii) &nbsp&nbsp ii. Total and Permanent Disability resulted directly or indirectly: </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp from any self-inflicted bodily injury while sane or insane;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp from any nervous disorder or mental illness;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion.  </br> "; 
                    
                    
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadAttachRider_PRDetail()
{
   var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(i) &nbsp&nbsp Death of the Life Assured due to suicide during the first 12 months, from the Issue Date, Alteration Effective Date or at any Reinstatement Date, whichever is latest. <br/>" +
                    "(ii) &nbsp&nbsp ii. Total and Permanent Disability resulted directly or indirectly: </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp from any self-inflicted bodily injury while sane or insane;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp from any nervous disorder or mental illness;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion.  </br> "; 
                    
                    
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadAttachRider_LCWPDetail()
{
   var htmlStr =   "This rider does not cover the following occurrences: </br> " + 
                    "(i) &nbsp&nbsp Death of the life assured due to suicide during the first 12 months from the date of issuance or reinstatement date, whichever is later. <br/>" +
                    "(ii) &nbsp&nbsp ii. Total and Permanent Disability resulted directly or indirectly: </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp from any self-inflicted bodily injury while sane or insane;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp from any nervous disorder or mental illness;  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp from flying in an aircraft (except as an aircrew member of, or as an ordinary fare paying passenger, on a regularly scheduled flight of a commercial airline); or  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp from anything whatsoever while as a member of the armed forces, police and paramilitary forces as a result of declared or undeclared war, riots or civil commotion.  </br> " +
                    "(iii) &nbsp&nbsp Diagnosis of the critical illness specified below within 60 days from the Issue Date or any reinstatement date, whichever is later: </br> " +
                    "(iv) &nbsp&nbsp Diagnosis of the critical illness other than those specified under item (iii) below within 30 days from the Issue Date or any reinstatement date, whichever is later </br> " +
                    "(v) &nbsp&nbsp Diagnosis of the critical illness specified below within 60 days from the Issue Date or any reinstatement date, whichever is later: <br/> " +
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (a) &nbsp&nbsp Angioplasty and other invasive treatment for coronary artery disease  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (b) &nbsp&nbsp Cancer  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (c) &nbsp&nbsp Coronary artery disease requiring surgery  </br> " + 
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (d) &nbsp&nbsp Heart attack   </br> " +
                    "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp (e) &nbsp&nbsp Other serious coronary artery disease   </br> " +
                    "(vi) &nbsp&nbsp Other than the first incidence of the dread disease except for dread diseases under Angioplasty and other Invasive Treatments For Major Coronary Artery Disease. </br> ";
                    
                    
                    
    
    var table = document.createElement('table');
    table.setAttribute('class','tableNothing');
    table.border = "0";
    
    var td = document.createElement('td');
    var td2 = document.createElement('td');
    var tr = document.createElement('tr');
    td.setAttribute('class','alignTop');
    td2.innerHTML = htmlStr;
    
    
    tr.appendChild(td);
    tr.appendChild(td2);
    table.appendChild(tr);
    
    return table;
    
}

function loadDetailsAR(arrBullet, arrData)
{
    var table = document.createElement('table');
    table.border = "0";
    table.setAttribute('class','tableNothing');
    for (i = 0; i< arrData.length;i++)
    {
        
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','tdVerticalAlign');
        td.style.width = "20px";
        td.innerHTML = arrBullet[i];
        td2.innerHTML = arrData[i];
        tr.appendChild(td);
        tr.appendChild(td2);
        table.appendChild(tr);
    }
    return table.outerHTML;
}


var arrRider_7B;
var arrRiderDesc_7B;

//=================page 9 - 7B split page method =========================
function loadAttachingRider_7B()
{
    var arr = getRiderList_7B();
    var arrTitle = new Array("Rider(s)","Cancellation Entitlement");
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.border ="1";
    table.appendChild(returnTitleRow(arrTitle));
    
    for (i = 0; i< arr.length ; i++)
    {
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        var tr = document.createElement('tr');
        //td.setAttribute("class","normalTableTD");
        //td2.setAttribute("class","normalTableTD");
        
        td.innerHTML = arr[i].riderName;
        td2.innerHTML = arr[i].riderDesc;
        
        tr.appendChild (td);
        tr.appendChild(td2);
        
        table.appendChild(tr);
        
    }
    return table;
}

function needSplitPageForRider_7B()
{
    var arr = getRiderList_7B();
    
    if(arr.length > parseInt(0))
    {
        
        appendPage('page9','pds2HTML/PDSTwo_ENG_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR1";
        var page9ContentATemp = document.getElementById('page9ContentA');
        page9ContentATemp.id = "page9ContentATemp";
        
        
        var page9ContentBTemp = document.getElementById('page9ContentB');
        page9ContentBTemp.id = "page9ContentBTemp";
        page9ContentBTemp.style.display = "none";
        
        appendPage('page9b','pds2HTML/PDSTwo_ENG_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR2";
        document.getElementById("page9ContentA").style.display = "none";
    }
    else{
        appendPage('page9','pds2HTML/PDSTwo_ENG_Page9.html');
        document.getElementById("7B-AR").style.display = "none";
        
    }
    
     var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
    
    if(dd<10) {
        dd='0'+dd
    } 
    
    if(mm<10) {
        mm='0'+mm
    } 
    
    today = dd+'/'+mm+'/'+yyyy;
    
    $('.getdate').html(today);
    
}



//================= END page 9 - 7B split page method =========================

function returnTitleRow(arr)
{
    var tr = document.createElement('tr');
    
    
    for (i = 0 ; i< arr.length ; i++)
    {
        var td = document.createElement('td');
        // td.setAttribute('class','tableHeaderTD');
        td.innerHTML = arr[i];
        tr.appendChild(td);
    }
    
    return tr;
}
function loadFooter()
{
    var str = "<div><table border='0' style='border-collapse:separate;border:0px solid black;width:100%;'><tr><td width='75%' style='font-family:Arial;font-size:8px;font-weight:normal;padding: 5px 5px 5px 0px;'>This Product Disclosure Sheet consists of <span class='totalPages'>{totalPages}</span> pages and each page forms an integral part of the Product Disclosure Sheet. A prospective policy owner is advised to read and<br/>understand the information printed on each and every page.<br/><b><span id='rptVersion' class='rptVersion'>{rptVersion}</span></b> <br/>Level 3, Tower B, PJ City Development, No. 15A Jalan 219, Seksyen 51A, 46100 Petaling Jaya, Selangor. Tel: 03-7650 1818 Fax: 03-7650 1991 Website: www.hla.com.my<br/></td><td width='10%' align='left' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:10px;font-weight:normal;'>Page <span class='currentPage'>22</span> of <span class='totalPages'>56</span></td><td width='15%' align='right' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:12px;font-weight:normal;'>Ref: <span id=SICode class='SICode'>{SINo}</span></td></tr></table></div>";
    
    var str2 = "<table><tr><td colspan='3'>This product disclosure sheet consists of 7 pages and each page forms an integral part of the sales illustration. A prospective policy owner is advised to read and understand the information printed on each and every page.</td><tr><td><b>Win MP (Ever & EverLove Plus Series) Version 3.8 (Agency) Last Updated 30 May 2013 - E&OE-</b></td><td>page 6 of 7</td><td>Ref: SI20130717-0001</td></table>";
    
    
    return str2;
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
    //td2.innerHTML ="<table border ='0' style=' font-family:Arial;font-size:11px;><tr><td colspan='3'><span>This product asdf disclosure sheet consists of <span class='totalPageNoClass'>{Pages}</span> pages and each page forms an integral part of the sales illustration. A prospective policy owner is advised to read and understand the information printed on each and every page.</br><b>Win MP (Ever & EverLove Plus Series) Version 3.8 (Agency) Last Updated 30 May 2013 - E&OE-</b></span></td></tr><tr><td style='width: 60%'>Level 3, Tower B, PJ City Development, No. 15A Jalan 219, Seksyen 51A, 46100 Petaling Jaya, Selangor. Tel: 03-7650 1818 Fax: 03-7650 1991 Website: www.hla.com.my</td><td style='width: 10%' >page <span id='currPageID'>{currPageNo}</span> of <span class='totalPageNoClass'>{Pages}</span></td><td style='width: 10%;text-align: right'>ref: 12345678910-1234</td></tr></table>";
    
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
        "<td width='9%' align='left' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:10px;'>Page <span id='currPageID'>{currPageNo}</span> of <span class='totalPageNoClass'>{Pages}</span></td>  " +
        "<td width='16%' align='right' valign='bottom' style='padding: 0px 0px 0px 0px;font-family:Arial;font-size:12px;'> ";
    
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
    $('.rptVersion').html('iMP Version 1.2 (Agency) - Last Updated 11 Jun 2014 - E&amp;OE-'); //set version info   
}

function loadSINo()
{
    var SINo = gdata.SI[0].SINo;
    $(".SINo").html(SINo);
}

function appendPage(pageNo,path)
{

    document.getElementById('page').appendChild(createPage(pageNo));
   // alert("ok 22");

    appendChildExt(path,document.getElementById(pageNo));

    loadPageNo();
}


function insertPageDb()
{
    var db;
    
    if (!window.openDatabase) {
        alert('<li>Web SQL Database API is not available in this browser, please try nightly Opera, Webkit or Chrome.</li>' );
        return;
    }else
    {
        //alert('loloooo');
    }
    db = openDatabase('../../hladb.sqlite', '1.0', 'PDS', 1024 * 1024);
    alert("well, fucjk");
    
        db.transaction(function (tx) {
                       //db.exec("INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES('null','lolol',20, 'fug')");
                       try{
                       tx.executeSql("INSERT INTO UL_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES('null','lolol',20, 'fug')");
                       }catch(e)
                       {
                       alert("error = " + e);
                       }
                       //tx.executeSql('CREATE TABLE IF NOT EXISTS tweets (id unique, screen_name, date integer, text)');
                       });
    
    
    alert("successfully inserted?");
}


//=======================================page 5 split page base on rider==========================
function needSplitPageForPlan()//page 5 split page base on rider
{
    
    
    
    if (getProdList("annualPremium").length <= splitCount)
    {
        
        isNeedSplit = "NO";
        
        
        
        if( gdata.SI[0].ReducedPaidUpYear=="(null)" || 
           gdata.SI[0].ReducedPaidUpYear=="null" ||
           gdata.SI[0].ReducedPaidUpYear=="0" )
        {
            if(ecar60Exist){
                
                appendPage('page5c','pds2HTML/PDSTwo_ENG_Page5b_i.html');
                appendPage('page5d','pds2HTML/PDSTwo_ENG_Page5b_ii.html');
            }
            else{
                appendPage('page5a','pds2HTML/PDSTwo_ENG_Page5.html');
                hide2EContent();
            }
            
            
            
        }else
        {
            appendPage('page5a','pds2HTML/PDSTwo_ENG_Page5.html');
            show2EContent();
            appendPage('page5d','pds2HTML/PDSTwo_ENG_Page5_reduced.html');
        }
        Page50_UV();
        
        
        
    }
    else
    {
        
        isNeedSplit = "YES";
        isNeedSplitFirstPart = "YES";
        
        appendPage('page5a','pds2HTML/PDSTwo_ENG_Page5.html');
        
        document.getElementById('premiumPaidOnPage5').style.display= "none";
        
        isNeedSplitFirstPart = "NO";
        //appendPage('page5d','pds2HTML/PDSTwo_BM_Page5b.html');
        
        
        if( gdata.SI[0].ReducedPaidUpYear=="(null)" || 
           gdata.SI[0].ReducedPaidUpYear=="null" ||
           gdata.SI[0].ReducedPaidUpYear=="0" )
        {
            hide2EContent();
        }else
        {
            
            show2EContent();
            appendPage('page5b','pds2HTML/PDSTwo_ENG_Page5_reduced.html');
        }
        
        Page50_UV();
        
        appendPage('page5c','pds2HTML/PDSTwo_ENG_Page5b_i.html');
        
        appendPage('page5d','pds2HTML/PDSTwo_ENG_Page5b_ii.html');
        
        /*
        if( ecar55Exist )
        {
            hidePremDuration();
        }else
        {
            showPremDuration();
        }*/
    }
    
    if(gdata.SI[0].UL_Temp_trad_Details.data.length == 0){
        
        $('.TobeSetAtJsFile').html('B)');
        $('.TobeSetAtJsFile2').html('C)');
    }
    else{
        $('.TobeSetAtJsFile').html('C)');
        $('.TobeSetAtJsFile2').html('D)');
    }
}

function getArrPlanSplit(arr)
{
    if(isNeedSplit == "NO")
    {
        
        return arr.slice(0,splitCount);
    }
    
    return arr.slice(splitCount,arr.length);
    
}
var totalPremium;
var HMMTotalPrem;
var MG4TotalPrem;
var MDSR1TotalPrem;
var MDSR2TotalPrem;
var eca60TotalPrem;
var ecar60Exist = false;
function getProdList(type)//get prod list for page 5
{
    
    var arrPlan = new Array();
    /*
    var plan = new productPlan();
    plan.prodName = "HLA Everlife Plus";
    plan.prodType = "Basic Plan";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "1,000,00";
    arrPlan.push(plan);*/
    
    var laAge;

    
    //basic plan
    //for(var y=0; y<gdata.SI[0].UL_Temp_trad_LA.data.length; y++)
    //{
        var plan = new productPlan();
        if(gdata.SI[0].PlanCode == 'UV'){
            plan.prodName = "HLA EverLife Plus";
        }
        else{
            plan.prodName = "HLA EverGain Plus";
        }
        
        plan.prodType = "Basic Plan";
        plan.prodInsuredLives = "Life Assured"; //gdata.SI[0].UL_Temp_trad_LA.data[y].LADesc;
        
        if(type=="annualPremium")
        {
            eca60Exist = false; //reset it

            plan.prodInitPremAnn = formatCurrency(gdata.SI[0].ATPrem);
            totalPremium = parseFloat(gdata.SI[0].ATPrem);
        }
        else
        if(type=="premiumDuration")
        {
            laAge = parseInt(gdata.SI[0].LAInfo.data[0].ALB,10);
            var duration = laAge + parseInt(gdata.SI[0].CovPeriod,10);
            plan.prodInitPremAnn = duration.toString();
        }
            
        arrPlan.push(plan);
    //}

                       
    //riders
    
    for(var y=0; y<gdata.SI[0].UL_Temp_trad_Details.data.length; y++)
    {
        //alert("riders = " + gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode );
        //arrRiderForTwoB.push( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc );
        
        var plan = new productPlan();
        plan.prodName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
        
        if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="ECAR6" )
        {
            plan.prodName = "EverCash Rider";
        }
        
        else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="HMM" )
        {
            plan.prodName = "HLA Major Medi";
        }
        
        else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR1" )
        {
            plan.prodName = "MediShield Rider (1st Rider)";
        }
        
        else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR2" )
        {
            plan.prodName = "MediShield Rider (2nd Rider)";
        }
        
        plan.prodType = "Rider";
        plan.prodInsuredLives = (gdata.SI[0].UL_Temp_trad_Details.data[y].InsuredLives == '1st Life Assured' ? 'Life Assured' : gdata.SI[0].UL_Temp_trad_Details.data[y].InsuredLives);
        //plan.prodInsuredLives = "Life Assured";
        
        if(type=="annualPremium")
        {
            plan.prodInitPremAnn = gdata.SI[0].UL_Temp_trad_Details.data[y].TotalPremium;
            totalPremium = totalPremium + parseFloat(plan.prodInitPremAnn);
            
            if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="HMM" )
            {
                HMMTotalPrem = parseFloat(plan.prodInitPremAnn);
            }
            
            else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MG_IV" )
            {
                MG4TotalPrem = parseFloat(plan.prodInitPremAnn);
            }
            
            else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="ECAR60" )
            {
                
                ecar60TotalPrem = parseFloat(plan.prodInitPremAnn);
                ecar60Exist = true;
            }
            else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR1" )
            {
                MDSR1TotalPrem = parseFloat(plan.prodInitPremAnn);
            }
            else if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR2" )
            {
                MDSR2TotalPrem = parseFloat(plan.prodInitPremAnn);
            }
            
            plan.prodInitPremAnn = formatCurrency(plan.prodInitPremAnn);
            arrPlan.push(plan);
        }
        else
        if(type=="premiumDuration")
        {
            
            //alert("PaymentTerm = " + gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc + " CovPeriod = " + gdata.SI[0].UL_Temp_trad_Details.data[y].CovPeriod);
            var duration2 = laAge + parseInt(gdata.SI[0].UL_Temp_trad_Details.data[y].PaymentTerm,10);
            
            plan.prodInitPremAnn = duration2.toString();
            //alert("fug");
            
            if( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="HMM" || gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MG_IV" ||
               gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR1" || gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode=="MDSR2" )
            {
                //does not need to show
            }else
            {
                arrPlan.push(plan);   
            }
        }
    }
    
    
    //total for only basic plan
    if(type=="annualPremium")
    {
        var plan = new productPlan();
        plan.prodName = "Total";
        plan.prodType = " ";
        plan.prodInsuredLives = " "; //gdata.SI[0].UL_Temp_trad_LA.data[y].LADesc;
        
        plan.prodInitPremAnn = formatCurrency(parseFloat(totalPremium));
        
        arrPlan.push(plan);
    }
    
    return arrPlan;
}

function setEcar60()
{
    
    if( ecar60Exist )
    {
        var annAmt = formatCurrency(parseFloat(ecar60TotalPrem * 96.7/100).toFixed(2));
        var nonAnnAmt = formatCurrency(parseFloat(ecar60TotalPrem * 3.3/100).toFixed(2));
        
        $(".AnnuityPremPct").html("96.7%");
        $(".AnnuityAmount").html(annAmt);
        $(".NonAnnuityPremPct").html("3.3%");
        $(".NonAnnuityAmount").html(nonAnnAmt);
        showEcar();
    }else
    {
        hideEcar();
    }
    
    //hides load prem duration as it will overlap to the next page
    

}
//=======================================page 5 split page base on rider==========================

function getRiderList()//rider data for 6B
{
    var arrRider = new Array();
    
    for(var y=0; y<gdata.SI[0].UL_Temp_trad_Details.data.length; y++)
    {
        var rd = new Rider();
        rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
        rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
        
        if( rd.riderCode=="ACIR" )
        {
            rd.riderDetailTitle = "The critical illness provision does not cover the following occurrences:";
        }else
        {
            rd.riderDetailTitle = "This rider does not cover the following occurrences:";
        }
        //alert("rd.riderCode = " + rd.riderCode);
        switch (rd.riderCode)
        {
            case "ACIR":
                rd.arrDetails = loadAttachRider_CIRDetail();//add this one..tempprary use cir
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "CIRD":
                rd.arrDetails = loadAttachRider_CIRD_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "CIWP":
                rd.arrDetails = loadAttachRider_CIRDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "CCR":
                rd.arrDetails = loadAttachRider_CCR_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "JCCR":
                rd.arrDetails = loadAttachRider_JCCR_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TCCR":
                rd.arrDetails = loadAttachRider_TCCR_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "MSR":
                rd.arrDetails = loadAttachRider_MSR_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "LDYR":
                rd.arrDetails = loadAttachRider_LDYR_Detail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "DCA":
                rd.arrDetails = loadAttachRider_ADCARDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                
                break;
            case "DHI":
                rd.arrDetails = loadAttachRider_ADHIRDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "ECAR":
                rd.arrDetails = loadAttachRider_EC1RDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "ECAR60":
                rd.arrDetails = loadAttachRider_EC1RDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "ECAR6":
                rd.arrDetails = loadAttachRider_EC1RDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "LSR":
                rd.arrDetails = loadAttachRider_EC1RDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                //arrPage8Riders.push("page2");
                break;
            case "MR":
                rd.arrDetails = loadAttachRider_ADHIRDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "PA":
                rd.arrDetails = loadAttachRider_ADCARDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TPDMLA":
                rd.arrDetails = loadAttachRider_ADCARDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TPDWP":
                rd.arrDetails = loadAttachRider_TPDWPR();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TPDYLA":
                rd.arrDetails = loadAttachRider_TPDYLADetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TSER":
                rd.arrDetails = loadAttachRider_TSERDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "TSR":
                rd.arrDetails = loadAttachRider_TSRDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "WI":
                rd.arrDetails = loadAttachRider_ADCARDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "LCWP":
                rd.arrDetails = loadAttachRider_LCWPDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            case "PR":
                rd.arrDetails = loadAttachRider_PRDetail();
                rd.riderName = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderDesc;
                rd.riderCode = gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode;
                arrRider.push(rd);
                break;
            default:
                break;
        }

    }
    
    return arrRider;
}

function getRiderList_7B()//to do here
{
    var arrRider = new Array();
    var rd = new Rider();
    
    var arrRider = new Array();
    
    for(var y=0; y<gdata.SI[0].UL_Temp_trad_Details.data.length; y++)
    {
        //alert(" gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode = " + gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode );
        switch (gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode)
        {
            case "ACIR":
                var rd = new Rider();
                rd.riderName = "Accelerated Critical Illness Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fund value of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);
                break;
            case "CIRD":
                var rd = new Rider();
                rd.riderName = "Diabetes Wellness Care Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fund value of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);
                break;
            case "CIWP":
                var rd = new Rider();
                rd.riderName = "Critical Illness Waiver of Premium Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "CCR":
                var rd = new Rider();
                rd.riderName = "CI Care Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fund value of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);
                break;
            case "DCA":
                var rd = new Rider();
                rd.riderName = "Acc. Death & Compassionate Allowance Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "DHI":
                var rd = new Rider();
                rd.riderName = "Acc. Daily Hospitalisation Income Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "ECAR":
                var rd = new Rider();
                rd.riderName = "EverCash 1 Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "ECAR60":
                var rd = new Rider();
                rd.riderName = "EverCash 60 Rider";
                rd.riderDesc = "This rider is meant for lifetime annuity benefit. You are not advised to terminate this rider prematurely.";
                arrRider.push(rd);                
                break;
            case "ECAR6":
                var rd = new Rider();
                rd.riderName = "EverCash Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "JCCR":
                var rd = new Rider();
                rd.riderName = "Junior CI Care Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fund value of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);
                break;
            case "LDYR":
                var rd = new Rider();
                rd.riderName = "LadyShield Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "LSR":
                var rd = new Rider();
                rd.riderName = "LifeShield Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "MR":
                var rd = new Rider();
                rd.riderName = "Acc. Medical Reimbursement Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "MSR":
                var rd = new Rider();
                rd.riderName = "MenShield Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "PA":
                var rd = new Rider();
                rd.riderName = "Personal Accident Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "TCCR":
                var rd = new Rider();
                rd.riderName = "Total CI Care Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fund value of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);
                break;
            case "TPDMLA":
                var rd = new Rider();
                rd.riderName = "Acc. TPD Monthly Living Allowance Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
            case "TPDWP":
                var rd = new Rider();
                rd.riderName = "TPD Waiver of Premium Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "TPDYLA":
                var rd = new Rider();
                rd.riderName = "TPD Yearly Living Allowance Rider";
                rd.riderDesc = "If you terminate this rider prematurely, there will be no refund and the termination will take effect from the next premium due date if the Basic Policy remains in force.";
                arrRider.push(rd);                
                break;
            case "TSER":
                var rd = new Rider();
                rd.riderName = "TermShield Extra Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "TSR":
                var rd = new Rider();
                rd.riderName = "TermShield Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "WI":
                var rd = new Rider();
                rd.riderName = "Acc. Weekly Indemnity Rider";
                rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
                arrRider.push(rd);                
                break;
             case "LCWP":
                var rd = new Rider();
                rd.riderName = "Living Care Waiver of Premium Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            case "PR":
                var rd = new Rider();
                rd.riderName = "Waiver of Premium Rider";
                rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
                arrRider.push(rd);                
                break;
            default:    
                break;
        }
    }

    return arrRider;
}

var ACIR_sumAssured;
var ACIR_coverage;
var CCR_sumAssured;
var CCR_coverage;
var JCCR_sumAssured;
var JCCR_coverage;
var TCCR_sumAssured;
var TCCR_coverage;
var MSR_sumAssured;
var MSR_coverage;
var LDYR_sumAssured;
var LDYR_coverage;
var MDSR1_sumAssured;
var MDSR1_coverage;
var MDSR2_sumAssured;
var MDSR2_coverage;
var CWIP_sumAssured;
var CWIP_coverage;
var DCA_sumAssured;
var DCA_coverage;
var DHI_sumAssured;
var DHI_coverage;
var ECAR_sumAssured;
var ECAR_coverage;
var ECAR60_sumAssured;
var ECAR60_coverage;
var LSR_sumAssured;
var LSR_coverage;
var MR_sumAssured;
var MR_coverage;
var PA_sumAssured;
var PA_coverage;
var TPDMLA_sumAssured;
var TPDMLA_coverage;
var TPDWP_sumAssured;
var TPDWP_coverage;
var WI_sumAssured;
var WI_coverage;
var ECAR6_sumAssured;
var ECAR6_coverage;
var CIRD_sumAssured;
var CIRD_coverage;
var TPDYLA_sumAssured;
var TPDYLA_coverage;
var TSER_sumAssured;
var TSER_coverage;
var TSR_sumAssured;
var TSR_coverage;
var LCWP_sumAssured;
var LCWP_coverage;
var LCWP_PayorOrSecond;
var PR_sumAssured;
var PR_coverage;
var PR_PayorOrSecond;

var riderArr;
var additionalRidersArr = new Array();

function needSplitPageForRider_2B()
{

    var arrRiderForTwoB = new Array();
    riderArr = new Array();
    for(var y=0; y<gdata.SI[0].UL_Temp_trad_Details.data.length; y++)
    {
        
        arrRiderForTwoB.push( gdata.SI[0].UL_Temp_trad_Details.data[y].RiderCode );        
    }
    
    
    
    var a = 1;
    var LCWP = [];
    var PR = [];
    for (x in arrRiderForTwoB)
    {
        //alert(" arrRiderForTwoB[a-1] = " + arrRiderForTwoB[a-1]);
        if (arrRiderForTwoB[a-1] == "ACIR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            ACIR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            ACIR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            //ACIR_obj = new ACIR_obj();
            currPage = 'page4Content-'+a;
            load2BRider = "ACIR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');            
        }
        else if (arrRiderForTwoB[a-1] == "CIWP")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            CWIP_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            CWIP_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "CIWP";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        else if (arrRiderForTwoB[a-1] == "LDYR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            LDYR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            LDYR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "LDYR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        else if (arrRiderForTwoB[a-1] == "MSR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            MSR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            MSR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "MSR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        else if (arrRiderForTwoB[a-1] == "CCR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            CCR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            CCR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "CCR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        else if (arrRiderForTwoB[a-1] == "JCCR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            JCCR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            JCCR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "JCCR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        else if (arrRiderForTwoB[a-1] == "TCCR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            TCCR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TCCR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "TCCR";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        
        else if (arrRiderForTwoB[a-1] == "LCWP")
        {
            /*
            riderArr.push(arrRiderForTwoB[a-1]);
            LCWP_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            LCWP_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            LCWP_PayorOrSecond = gdata.SI[0].UL_Temp_trad_Details.data[x].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
            
            currPage = 'page4Content-'+a;
            load2BRider = "LCWP";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
            */
            LCWP.push(gdata.SI[0].UL_Temp_trad_Details.data[x]);
            
        }
        
        else if (arrRiderForTwoB[a-1] == "DCA")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("1");
            DCA_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            DCA_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "DHI")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("2");
            DHI_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            DHI_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "ECAR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("3");
            ECAR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            ECAR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "ECAR60")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("11");
            ECAR60_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            ECAR60_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "ECAR6")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("4");
            ECAR6_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            ECAR6_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "LSR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("5");
            LSR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            LSR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "MR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("6");
            MR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            MR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "PA")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("7");
            PA_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            PA_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "TPDMLA")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("8");
            TPDMLA_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TPDMLA_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "TPDWP")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("9");
            TPDWP_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TPDWP_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "WI")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("10");
            WI_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            WI_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "CIRD")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("12");
            CIRD_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            CIRD_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            //ACIR_obj = new ACIR_obj();
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "TPDYLA")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("13");
            TPDYLA_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TPDYLA_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "TSER")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("14");
            TSER_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TSER_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "TSR")
        {
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("15");
            TSR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            TSR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
        }
        else if (arrRiderForTwoB[a-1] == "PR")
        {
            PR.push(gdata.SI[0].UL_Temp_trad_Details.data[x]);
            /*
            riderArr.push(arrRiderForTwoB[a-1]);
            riderDisplayNo.push("16");
            PR_sumAssured = formatCurrency(gdata.SI[0].UL_Temp_trad_Details.data[x].SumAssured);
            PR_coverage = gdata.SI[0].UL_Temp_trad_Details.data[x].CovPeriod;
            PR_PayorOrSecond = gdata.SI[0].UL_Temp_trad_Details.data[x].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
            */
        }
        else if (arrRiderForTwoB[a-1] == "HMM") //needs to display a huge chunk of pages after everything else
        {
            additionalRidersArr.push("HMM");
            //load2BRider = "OTHERS_ADDITIONAL";
        }
        else if (arrRiderForTwoB[a-1] == "MG_IV") //needs to display a huge chunk of pages after everything else
        {
            additionalRidersArr.push("MG_IV");
            //load2BRider = "OTHERS_ADDITIONAL";
        }
        else if (arrRiderForTwoB[a-1] == "MDSR1") //needs to display a huge chunk of pages after everything else
        {
            additionalRidersArr.push("MDSR1");
            
        }
        else if (arrRiderForTwoB[a-1] == "MDSR2") //needs to display a huge chunk of pages after everything else
        {
            additionalRidersArr.push("MDSR2");
            
        }
        
        
        a=a+1;
    }
    if( riderDisplayNo.length > 1 )
    {
        appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
    }
 
    a=a+1;
 
    if (arrRiderForTwoB.indexOf("LCWP") > -1)
    {
        //riderArr.push(arrRiderForTwoB[a-1]);
        LCWP_sumAssured = formatCurrency(LCWP[0].SumAssured);
        LCWP_coverage = LCWP[0].CovPeriod;
        LCWP_PayorOrSecond = LCWP[0].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
        
        currPage = 'page4Content-'+a;
        load2BRider = "LCWP";
        appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        
        a=a+1;
        
        if(LCWP.length > 1){
            LCWP_sumAssured = formatCurrency(LCWP[1].SumAssured);
            LCWP_coverage = LCWP[1].CovPeriod;
            LCWP_PayorOrSecond = LCWP[1].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
            
            currPage = 'page4Content-'+a;
            load2BRider = "LCWP";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');    
        }
        
        
    }
    
    if (arrRiderForTwoB.indexOf("PR") > -1)
    {
        
        riderDisplayNo.push("16");
        PR_sumAssured = formatCurrency(PR[0].SumAssured);
        PR_coverage = PR[0].CovPeriod;
        PR_PayorOrSecond = PR[0].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
        
        currPage = 'page4Content-'+a;
        load2BRider = "OTHERS";
        appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        
        a=a+1;
        
        if(PR.length > 1){
            riderDisplayNo.push("16");
            PR_sumAssured = formatCurrency(PR[1].SumAssured);
            PR_coverage = PR[1].CovPeriod;
            PR_PayorOrSecond = PR[1].Seq == '1' ? 'Policy Owner' : '2nd Life Assured';
            
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
            appendPage('page4-'+a,'pds2HTML/PDSTwo_ENG_Page4.html');
        }
        
        
    } 

}


var PAGE_ALLOCATED = 8;//change this to have different page
var arrPage8Riders = new Array("0");

function needSplitPageForRider_6B()//page8 - 6 B rider
{
    var serviceTax = parseFloat(6/100 * totalPremium).toFixed(2);
    $('.ServiceTax').html(serviceTax + ' (' + BumpModeDesc(gdata.SI[0].BumpMode, 2)  +' )') ;
    
    var arrTempRider = getRiderList();
    
    var arrPageEightRider = new Array();
    
    for (i = 0; i < PAGE_ALLOCATED;i++)//no of pages
    {
        var pageRider = new pageEightRider();
        pageRider.pageName = "page8-"+ (i+1);
        pageRider.isPageNeedToShow = "NO";
       // alert("pageRider.pageName = " + pageRider.pageName);
        arrPageEightRider.push(pageRider);
    }
    
    for (i = 0;i < arrTempRider.length;i++)
    {
        var page;
        if (!page)
        {
            page = arrPageEightRider[i];
            page.riderList = new Array();
        }
        page.isPageNeedToShow = "YES";
        page.riderList.push(arrTempRider[i]);
    }
    
    var count = 1;
    var pageRider = 1;
    var arrPagingRiders = new Array();
    //alert("arrTempRider.length = " + arrTempRider.length);
    for(x=0; x<arrTempRider.length; x++)
    {
        arrLoadRider.push(arrTempRider[x]);
        
        if(count==2)
        {
            count=0;
            //alert("arrLoadRider.length == " + arrLoadRider.length + " x==" + x);
            currPage = 'page8Content-'+ pageRider;
            appendPage('page8-'+ pageRider,'pds2HTML/PDSTwo_ENG_Page8.html');
            pageRider++;
            arrLoadRider = new Array();
            //alert("lol");
        }else
            if( (x+2) > arrTempRider.length )
            {
                currPage = 'page8Content-'+ pageRider;
                appendPage('page8-'+ pageRider,'pds2HTML/PDSTwo_ENG_Page8.html');
            }
        count++;
        //alert("count == " + count + " x=="+ x);
    }

    /*var a = 1;
    for(x in arrPageEightRider)
    {
        
        currPage = 'page8Content-'+ a;
        arrLoadRider = arrPageEightRider[a-1].riderList;
        //alert(" find arrLoadRider x="+x +" || arrLoadRider = " + arrLoadRider);
        if(!arrLoadRider)
            break;
        appendPage('page8-'+ a,'pds2HTML/PDSTwo_ENG_Page8.html');
        a++;
    }*/
    // currPage = 'page8Content-'+2;
    //arrLoadRider = arrPageEightRider[4].riderList;
    //
    // appendPage('page8-'+2,'pds2HTML/PDSTwoPage8.html');
}
var currPage;

function laod6B_attachRider()
{
    
    document.getElementById('6B-attachRider').id = currPage;
    document.getElementById(currPage).appendChild(loadAttachRider());
    
    if (currPage == "page8Content-"+(PAGE_ALLOCATED))//page 8 table footer note
    {
        var strPageEndNote = "<span><i>Note:  This list is non-exhaustive. Please refer to the policy contract for the full list of exclusions under this policy.</i></span>";
        // HTML string
        var div = document.createElement('div');
        div.innerHTML = strPageEndNote;
        var elements = div.firstChild;
        document.getElementById(currPage).appendChild(elements);
        
    }
    else if (currPage == "page8Content-1")//page 8 title
    {
        document.getElementById('6B-attachRiderTitle').id = "page8Title-1";
        document.getElementById("page8Title-1").style.display = "block";
    }
    
}


function writePDS_HMM()
{
	var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
    
	$('.PrintDate2').html(displayDate);
        $('.InsuredLife').html('Insured Life : ' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name);
    
	$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {

            if (row.RiderCode == "HMM")
            {
                 HMMRiderTerm = row.CovPeriod;
                 HMMRiderHL = row.RiderHLoadingPct; //HLPercentage
                 HMMRiderHLTerm = row.RiderHLoadingPctTerm; //HLPercentageTerm
                 HMMRiderTempHL = row.RiderHLoading; //TempHL1KSA
                 HMMRiderTempHLTerm = row.RiderHLoadingTerm; //TempHL1KSATerm
                      
                 
                $('.HMMRiderTerm').html(row.CovPeriod);
                $('.HMMPlanOption').html(row.PlanOption);
                $('.HMMOption').html(row.PlanOption + " with deductible of RM " + row.Deductible);
                $('.HMMOption_BM').html(row.PlanOption + " dengan penolakan sebanyak RM " + row.Deductible);
                $('.HMMPayableAge').html((parseInt(row.CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)));
      /*
                 $.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
                        //alert("row.Type="+row.Type+" || row.FromAge="+ row.FromAge);
                       // if (row.Type == "HMM" && row.FromAge == "(null)"){
                        $('.HMMValueA').html(row.Annually);
                        $('.HMMValueB').html(row.SemiAnnually);
                        $('.HMMValueC').html(row.Quarterly);
                        $('.HMMValueD').html(row.Monthly);
                        HMMRiderPrem = row.Annually.replace(',', '');
                       // return false;
                        
                        });*/
                 
                 $('.HMMLifeAssured').html("Life Assured");
                 $('.HMMTotalPrem').html(HMMTotalPrem);
               
               
               
                firstAge = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                
                var LAAge;
                var zzz = 0;
                var PremList = new Array();
                for (LAAge = 0;LAAge<7;LAAge++)
                {
                zzz = firstAge + LAAge;
                $.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
                      //if (row.Type == "HMM" && row.FromAge != "(null)")
                      //{
                      if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
                      {
                      //alert("q")
                      PremList[LAAge] = row.Annually;
                      }
                      //}
                      
                      });
                }
                var PolicyTerm;
                if(HMMRiderTerm > 21){
                    PolicyTerm = 20;
                }
                else{
                    PolicyTerm = HMMRiderTerm;
                }
               
    
                j = 1;
                $.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
                      
                      if (row.PolTerm == PolicyTerm)
                      {
                      if(HMMRiderHL && HMMRiderTempHL ){
                      BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HMMRiderHL)/100 ) + 1);
                      }
                      else if(HMMRiderHL && !HMMRiderTempHL){
                      BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(HMMRiderHL)/100) + 1); 
                      }
                      else if(!HMMRiderHL && HMMRiderTempHL){
                      BaseValue = parseFloat(PremList[j - 1])/// (( parseFloat(HMMRiderTempHL)/100) + 1);
                      }
                      else{
                      BaseValue = parseFloat(PremList[j - 1]);
                      }
                      
    
                      if(!HMMRiderHL){
                      PremiumA = 0;
                      }
                      else{
                      if(parseInt(j) <=  parseInt(HMMRiderHLTerm))
                      {
                      PremiumA =  (BaseValue * parseFloat(HMMRiderHL)/100);
                      }
                      else
                      {
                      //actualPremium = (parseFloat(row.Rate)/100 ) * ((parseFloat(CRiderPrem)) - (parseFloat(CRiderSA)/1000 * parseFloat(CRiderHL)));
                      PremiumA = 0;
                      }
                      }
                      if(!HMMRiderTempHL){
                      PremiumB = 0;
                      }
                      else{
                      if(parseInt(i) <=  parseInt(HMMRiderTempHLTerm)){
                      PremiumB =  (BaseValue * parseFloat(HMMRiderTempHL)/100);
                      //alert(PremiumB);
                      }
                      else{
                      PremiumB = 0;
                      }
                      }
                      TotalPremium = parseFloat(BaseValue) + parseFloat(PremiumA) + parseFloat(PremiumB);
                      
                      //alert(TotalPremium)
                      $('#HMMYear'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
                      j++;
                      }
                });
                return false;
            }
        });
	//alert("uuu")
        
    
}


function writePDS_MG4()
{
    var now = new Date();	
	var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
	var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
    
	$('.PrintDate2').html(displayDate);
    
    $.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {

           if (row.RiderCode == "MG_IV")
           {
           MG4RiderTerm = row.CovPeriod;
           MG4RiderHL = row.RiderHLoadingPct; //HLPercentage
           MG4RiderHLTerm = row.RiderHLoadingPctTerm; //HLPercentageTerm
           MG4RiderTempHL = row.RiderHLoading; //TempHL1KSA
           MG4RiderTempHLTerm = row.RiderHLoadingTerm; //TempHL1KSATerm
           
           $('.MG4RiderTerm').html(row.CovPeriod);
           $('.MG4PlanOption').html(row.PlanOption);
           $('.MG4PayableAge').html((parseInt(row.CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)));
           
           $('.MG4LifeAssured').html("Life Assured");
           $('.MG4TotalPrem').html(MG4TotalPrem);

           firstAge = parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                      
           var LAAge;
           var zzz = 0;
           var PremList = new Array();
           
           for (LAAge = 0;LAAge<7;LAAge++)
           {
            zzz = firstAge + LAAge;
            $.each(gdata.SI[0].SI_Store_Premium.data, function(index, row) {
                  //if (row.Type == "MG_IV" && row.FromAge != "(null)")
                  //{
                  if (parseInt(row.FromAge) <= zzz && parseInt(row.ToAge) >= zzz)
                  {
                  PremList[LAAge] = row.Annually;
                  }
                  //}
                  });
           }
           
           var PolicyTerm;
           if(MG4RiderTerm > 21){
            PolicyTerm = 20;
           }
           else{
            PolicyTerm = MG4RiderTerm;
           }

           j = 1;
           $.each(gCommision.Rates[0].Trad_Sys_Commission.data, function(index, row) {
                  //alert("lololol");
                  
                  
                  if (row.PolTerm == PolicyTerm)
                  {
                    if(MG4RiderHL && MG4RiderTempHL ){
                    BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG4RiderHL)/100 ) + 1);
                    }
                    else if(MG4RiderHL && !MG4RiderTempHL){
                    BaseValue = parseFloat(PremList[j - 1])/ (( parseFloat(MG4RiderHL)/100) + 1); 
                    }
                    else if(!MG4RiderHL && MG4RiderTempHL){
                    BaseValue = parseFloat(PremList[j - 1])/// (( parseFloat(HMMRiderTempHL)/100) + 1);
                    }
                    else{
                    BaseValue = parseFloat(PremList[j - 1]);
                    }
                  
                  
                    if(!MG4RiderHL){
                      PremiumA = 0;
                    }
                    else{
                        if(parseInt(j) <=  parseInt(MG4RiderHLTerm))
                        {
                          PremiumA =  (BaseValue * parseFloat(MG4RiderHL)/100);
                        }
                        else
                        {
                          //actualPremium = (parseFloat(row.Rate)/100 ) * ((parseFloat(CRiderPrem)) - (parseFloat(CRiderSA)/1000 * parseFloat(CRiderHL)));
                          PremiumA = 0;
                        }
                    }
                    if(!MG4RiderTempHL){
                        PremiumB = 0;
                    }
                    else{
                        if(parseInt(i) <=  parseInt(MG4RiderTempHLTerm)){
                            PremiumB =  (BaseValue * parseFloat(MG4RiderTempHL)/100);
                            //alert(PremiumB);
                        }
                        else{
                            PremiumB = 0;
                        }
                    }
                    TotalPremium = parseFloat(BaseValue) + parseFloat(PremiumA) + parseFloat(PremiumB);
                  
                  //alert(TotalPremium)
                    $('#MG4Year'+j).html('RM ' +formatCurrency(parseFloat(row.Rate)/100 * parseFloat(TotalPremium)));
                    
                    j++;
                  }
                });
           return false;
           }
           });
}

function writePDS_MDSR1()
{
    var now = new Date();	
    var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
    var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();

    $('.PrintDate2').html(displayDate);
    $('.InsuredLife').html('Insured Life : ' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name);

    var RowALW = [];
    var RowOT = [];
    var RowMCFR = [];
    $.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
        if (row.RiderCode == "MDSR1-ALW"){
            RowALW.push(row);
        }
        else if (row.RiderCode == "MDSR1-OT"){
            RowOT.push(row);
        }
        else if (row.RiderCode == "MCFR"){
            RowMCFR.push(row);
        }
        
    });
    
    var tempRowspan;
    /*
    if(RowALW.length > 0  && RowOT.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver<br/>- Oversea Treatment");
        tempRowspan = "3";
        document.getElementById('MDSR1_ALW').style.display = "";
        document.getElementById('MDSR1_OT').style.display = "";
    }
    else if(RowALW.length > 0  && RowOT.length == 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "2";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Oversea Treatment");
        tempRowspan = "2";
        document.getElementById('MDSR1_OT').style.display = "";
    }
    else{
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)");
        tempRowspan = "1";
    }
    */
    if(RowALW.length > 0  && RowOT.length > 0 && RowMCFR.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver<br/>- Oversea Treatment");
        tempRowspan = "5";
        document.getElementById('MDSR1_ALW').style.display = "";
        document.getElementById('MDSR1_OT').style.display = "";
    }
    else if(RowALW.length > 0  && RowOT.length == 0 && RowMCFR.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "4";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length > 0  && RowOT.length > 0 && RowMCFR.length == 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "3";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length > 0  && RowOT.length == 0 && RowMCFR.length == 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "2";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length > 0 && RowMCFR.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver<br/>- Oversea Treatment");
        tempRowspan = "4";
        document.getElementById('MDSR1_ALW').style.display = "";
        document.getElementById('MDSR1_OT').style.display = "";
    }
    else if(RowALW.length == 0  && RowOT.length == 0 && RowMCFR.length > 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "3";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length > 0 && RowMCFR.length == 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "2";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length == 0 && RowMCFR.length == 0 ){
        $('.tableMDSR1-3-List').html("HLA MediShield Rider (1st Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "1";
        document.getElementById('MDSR1_ALW').style.display = "";
        
    }
    
    
    $.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {

        if (row.RiderCode == "MDSR1")
        {
            MDSR1RiderTerm = row.CovPeriod;
            MDSR1RiderHL = row.RiderHLoadingPct; //HLPercentage
            MDSR1RiderHLTerm = row.RiderHLoadingPctTerm; //HLPercentageTerm
            MDSR1RiderTempHL = row.RiderHLoading; //TempHL1KSA
            MDSR1RiderTempHLTerm = row.RiderHLoadingTerm; //TempHL1KSATerm
            
            $('.MDSR1RiderTerm').html(row.CovPeriod);
            $('.MDSR1PlanOption').html(row.PlanOption);
            $('.MDSR1PreDed').html(row.PreDeductible);
            $('.MDSR1PostDed').html(row.PostDeductible);
            $('.MDSR1PayableAge').html((parseInt(row.CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)));
            
            $('.MDSR1LifeAssured').html("Life Assured");
            $('.MDSR1TotalPrem').html(MDSR1TotalPrem);
            
            var tempTotalMDSRFirst1 = 0.00;
            var tempTotalMDSRFirst2 = 0.00;
            var tempTotalMDSRFirst3 = 0.00;
            
            
            if(parseInt(row.CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    tempAge2 = '61 To 80';
                    tempAge3 = '81 To 100';
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    
                    $('#tableMDSR1-2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/>LA Age(EOY)' + tempAge2  +'</td>' +
                                                      '<td style = "text-align: center;">Rider Year ' + temp3 + '<br/>LA Age(EOY)' + tempAge3  + '</td></tr>');
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td>' + row.RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;" rowspan = ' + tempRowspan + '>Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.Premium3) + '</td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(row.AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(row.Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(row.Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium3) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                    }
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium3) + '</td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td><td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR1-2 > tbody').append('<tr>' +
                                                        '<td style = "text-align: center;">Life Assured</td>' +
                                                        '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                        '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                        '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst2) +'</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst3) + '</b></td></tr>');
                    
                    
                    
            }
            else if(parseInt(row.CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    tempAge2 = '61 To 80';
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    
                    $('#tableMDSR1-2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;">Rider Year ' + temp2 + '<br/>LA Age(EOY)' + tempAge2  +'</td>' +
                                                      '<td style = "text-align: center;"> - </td></tr>');
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td>' + row.RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(row.AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(row.Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(row.Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                        
                    }
                    
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td><td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR1-2 > tbody').append('<tr><td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst2) +'</b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td></tr>');
            }
            else
            {
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    
                    $('#tableMDSR1-2 > thead').append('<tr><td style = "text-align: center;">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;"> - </td>' +
                                                      '<td style = "text-align: center;"> - </td></tr>');
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td>' + row.RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(row.AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(row.AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(row.Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(row.Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                    }
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR1-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td><td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR1-2 > tbody').append('<tr><td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR1-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td></tr>');
            }
            
            
 
 
            
       
            var temp1 = row.AnnualTarget;
            var temp2 = row.Premium2;
            var temp3 = row.Premium3;
            var tempPremAtCurrentYear = 0.00;
            
            j = 1;
            $.each(gdata.SI[0].UL_Temp_MDSR1_Commission.data, function(index, rowComm) {
                 
                 if((parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(rowComm.col2)) > 80 ){
                    tempPremAtCurrentYear = temp3;
                 }
                 else if((parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(rowComm.col2)) > 60  ){
                    tempPremAtCurrentYear = temp2;
                 }
                 else{
                    tempPremAtCurrentYear = temp1;
                 }
                 
                if(MDSR1RiderHL && MDSR1RiderTempHL ){
                    BaseValue = parseFloat(tempPremAtCurrentYear)/ (( parseFloat(MDSR1RiderHL)/100 ) + 1);
                }
                else if(MDSR1RiderHL && !MDSR1RiderTempHL){
                    BaseValue = parseFloat(tempPremAtCurrentYear)/ (( parseFloat(MDSR1RiderHL)/100) + 1); 
                }
                else if(!MDSR1RiderHL && MDSR1RiderTempHL){
                    BaseValue = parseFloat(tempPremAtCurrentYear)
                }
                else{
                    BaseValue = parseFloat(tempPremAtCurrentYear);
                }
              
              
                if(!MDSR1RiderHL){
                    PremiumA = 0;
                }
                else{
                    if(parseInt(j) <=  parseInt(MDSR1RiderHLTerm))
                    {
                        PremiumA =  (BaseValue * parseFloat(MDSR1RiderHL)/100);
                    }
                    else
                    {
                        PremiumA = 0;
                    }
                }
                
                if(!MDSR1RiderTempHL){
                    PremiumB = 0;
                }
                else{
                    if(parseInt(i) <=  parseInt(MDSR1RiderTempHLTerm)){
                        PremiumB =  (BaseValue * parseFloat(MDSR1RiderTempHL)/100);
                        //alert(PremiumB);
                    }
                    else{
                        PremiumB = 0;
                    }
                }
                TotalPremium = parseFloat(BaseValue) + parseFloat(PremiumA) + parseFloat(PremiumB);
              
                $('#MDSR1Year'+j).html('RM ' +formatCurrency(parseFloat(rowComm.col1)/100 * parseFloat(TotalPremium)));
                j++;
                    
                 
             });
            return;
        }
    });
}

function writePDS_MDSR2()
{
    
    var now = new Date();	
    var displayDate = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear();
    var displayDateFull = now.getDate() + '/' + (now.getMonth() + 1) + '/' + now.getFullYear() + ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();

    $('.PrintDate2').html(displayDate);
    $('.InsuredLife').html('Insured Life : ' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name);

    var RowALW = [];
    var RowOT = [];
    var RowMDSR2 = [];
    var RowMCFR = [];
    
    $.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
        if (row.RiderCode == "MDSR2-ALW"){
            RowALW.push(row);
        }
        else if (row.RiderCode == "MDSR2-OT"){
            RowOT.push(row);
        }
        else if (row.RiderCode == "MDSR2"){
            RowMDSR2.push(row);
        }
        /*
        else if (row.RiderCode == "MCFR"){
            RowMCFR.push(row);
        }
        */
    });
    
    var tempRowspan;
    if(RowALW.length > 0  && RowOT.length > 0 && RowMCFR.length > 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver<br/>- Oversea Treatment");
        tempRowspan = "5";
        document.getElementById('MDSR2_ALW').style.display = "";
        document.getElementById('MDSR2_OT').style.display = "";
    }
    else if(RowALW.length > 0  && RowOT.length == 0 && RowMCFR.length > 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "4";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    else if(RowALW.length > 0  && RowOT.length > 0 && RowMCFR.length == 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "3";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    else if(RowALW.length > 0  && RowOT.length == 0 && RowMCFR.length == 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "2";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length > 0 && RowMCFR.length > 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver<br/>- Oversea Treatment");
        tempRowspan = "4";
        document.getElementById('MDSR2_ALW').style.display = "";
        document.getElementById('MDSR2_OT').style.display = "";
    }
    else if(RowALW.length == 0  && RowOT.length == 0 && RowMCFR.length > 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "3";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length > 0 && RowMCFR.length == 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "2";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    else if(RowALW.length == 0  && RowOT.length == 0 && RowMCFR.length == 0 ){
        $('.tableMDSR2-3-List').html("HLA MediShield Rider (2nd Rider)<br/>- Annual Limit Waiver");
        tempRowspan = "1";
        document.getElementById('MDSR2_ALW').style.display = "";
        
    }
    
    
            MDSR2RiderTerm = RowMDSR2[0].CovPeriod;
            MDSR2RiderHL = RowMDSR2[0].RiderHLoadingPct; //HLPercentage
            MDSR2RiderHLTerm = RowMDSR2[0].RiderHLoadingPctTerm; //HLPercentageTerm
            MDSR2RiderTempHL = RowMDSR2[0].RiderHLoading; //TempHL1KSA
            MDSR2RiderTempHLTerm = RowMDSR2[0].RiderHLoadingTerm; //TempHL1KSATerm
            
            $('.MDSR2RiderTerm').html(RowMDSR2[0].CovPeriod);
            $('.MDSR2PlanOption').html(RowMDSR2[0].PlanOption);
            $('.MDSR2PreDed').html(RowMDSR2[0].PreDeductible);
            $('.MDSR2PostDed').html(RowMDSR2[0].PostDeductible);
            $('.MDSR2PayableAge').html((parseInt(RowMDSR2[0].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)));
            
            $('.MDSR2LifeAssured').html("Life Assured");
            $('.MDSR2TotalPrem').html(MDSR2TotalPrem);
            
            var tempTotalMDSRFirst1 = 0.00;
            var tempTotalMDSRFirst2 = 0.00;
            var tempTotalMDSRFirst3 = 0.00;
            
            
            if(parseInt(RowMDSR2[0].CovPeriod ) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 80){
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    tempAge2 = '61 To 80';
                    tempAge3 = '81 To 100';
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    temp3 = (81 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (100 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    
                    $('#tableMDSR2-2 > thead').append('<tr><td style = "text-align: center;width:34%">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;width:33%">Rider Year ' + temp2 + '<br/>LA Age(EOY)' + tempAge2  +'</td>' +
                                                      '<td style = "text-align: center;width:33%">Rider Year ' + temp3 + '<br/>LA Age(EOY)' + tempAge3  + '</td></tr>');
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowMDSR2[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;" rowspan = ' + tempRowspan + '>Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].Premium3) + '</td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMDSR2[0].AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMDSR2[0].Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMDSR2[0].Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium3) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                    }
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium3) + '</td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR2-2 > tbody').append('<tr>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst2) +'</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst3) + '</b></td></tr>');
                    
                    
                    
            }
            else if(parseInt(RowMDSR2[0].CovPeriod) + parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) > 60){
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    tempAge2 = '61 To 80';
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    temp2 = (61 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age)) + ' To ' + (80 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age));
                    
                    $('#tableMDSR2-2 > thead').append('<tr><td style = "text-align: center;width:34%">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;width:33%">Rider Year ' + temp2 + '<br/>LA Age(EOY)' + tempAge2  +'</td>' +
                                                      '<td style = "text-align: center;width:33%"> - </td></tr>');
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowMDSR2[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMDSR2[0].AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMDSR2[0].Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMDSR2[0].Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                        
                    }
                    
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].Premium2) +'</td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR2-2 > tbody').append('<tr>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst2) +'</b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td></tr>');
            }
            else
            {
                    tempAge1 = gdata.SI[0].UL_Temp_trad_LA.data[0].Age + ' To ' + 60;
                    
                    temp1 = 60 - parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age);
                    
                    $('#tableMDSR2-2 > thead').append('<tr><td style = "text-align: center;width:34%">Rider Year 1 To ' + temp1 + '<br/>LA Age(EOY)' + tempAge1  + '</td><td style = "text-align: center;width:33%"> - </td>' +
                                                      '<td style = "text-align: center;width:33%"> - </td></tr>');
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowMDSR2[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMDSR2[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                    
                    tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMDSR2[0].AnnualTarget);
                    tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMDSR2[0].Premium2);
                    tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMDSR2[0].Premium3);
                    
                    if(RowALW.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowALW[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowALW[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowALW[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowALW[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowALW[0].Premium3);
                    }
                    
                    if(RowOT.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td>' + RowOT[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;">Life Assured</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowOT[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;"> - </td>' +
                                                    '<td style = "text-align: center;"> - </td></tr>');
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowOT[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowOT[0].Premium2);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowOT[0].Premium3);
                    }
                    
                    if(RowMCFR.length > 0){
                        $('#tableMDSR2-2 > tbody').append('<tr><td rowspan = "2" >' + RowMCFR[0].RiderDesc  + '</td>' +
                                                    '<td style = "text-align: center;  " colspan="3"> Rider Year ' + RowMCFR[0].RRTUOFromYear  + ' to ' +  (parseInt(RowMCFR[0].RRTUOFromYear) + parseInt(RowMCFR[0].RRTUOYear))  + '</td>' +
                                                    '</tr>');
                        
                        $('#tableMDSR2-2 > tbody').append('<tr>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget)  + '</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) +'</td>' +
                                                    '<td style = "text-align: center;">' + formatCurrency(RowMCFR[0].AnnualTarget) + '</td></tr>');
                        
                        tempTotalMDSRFirst1 = parseFloat(tempTotalMDSRFirst1) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst2 = parseFloat(tempTotalMDSRFirst2) + parseFloat(RowMCFR[0].AnnualTarget);
                        tempTotalMDSRFirst3 = parseFloat(tempTotalMDSRFirst3) + parseFloat(RowMCFR[0].AnnualTarget);
                    }
                    
                    $('#tableMDSR2-2 > tbody').append('<tr><td colspan ="2" style="text-align: right;"><b>Total Premium</b></td>' +
                                                    '<td style = "text-align: center;"><b>' + formatCurrency(tempTotalMDSRFirst1)  + '</b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td>' +
                                                    '<td style = "text-align: center;"><b> - </b></td></tr>');
            }
            
            
            
            
       
            var temp1 = RowMDSR2[0].AnnualTarget;
            var temp2 = RowMDSR2[0].Premium2;
            var temp3 = RowMDSR2[0].Premium3;
            var tempPremAtCurrentYear = 0.00;
            
            j = 1;
            $.each(gdata.SI[0].UL_Temp_MDSR2_Commission.data, function(index, rowComm) {
                 
                 if((parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(rowComm.col2)) > 80 ){
                    tempPremAtCurrentYear = temp3;
                 }
                 else if((parseInt(gdata.SI[0].UL_Temp_trad_LA.data[0].Age) + parseInt(rowComm.col2)) > 60  ){
                    tempPremAtCurrentYear = temp2;
                 }
                 else{
                    tempPremAtCurrentYear = temp1;
                 }
                 
                if(MDSR2RiderHL && MDSR2RiderTempHL ){
                    BaseValue = parseFloat(tempPremAtCurrentYear)/ (( parseFloat(MDSR2RiderHL)/100 ) + 1);
                }
                else if(MDSR2RiderHL && !MDSR2RiderTempHL){
                    BaseValue = parseFloat(tempPremAtCurrentYear)/ (( parseFloat(MDSR2RiderHL)/100) + 1); 
                }
                else if(!MDSR2RiderHL && MDSR2RiderTempHL){
                    BaseValue = parseFloat(tempPremAtCurrentYear)
                }
                else{
                    BaseValue = parseFloat(tempPremAtCurrentYear);
                }
              
              
                if(!MDSR2RiderHL){
                    PremiumA = 0;
                }
                else{
                    if(parseInt(j) <=  parseInt(MDSR2RiderHLTerm))
                    {
                        PremiumA =  (BaseValue * parseFloat(MDSR2RiderHL)/100);
                    }
                    else
                    {
                        PremiumA = 0;
                    }
                }
                
                if(!MDSR2RiderTempHL){
                    PremiumB = 0;
                }
                else{
                    if(parseInt(i) <=  parseInt(MDSR2RiderTempHLTerm)){
                        PremiumB =  (BaseValue * parseFloat(MDSR2RiderTempHL)/100);
                        //alert(PremiumB);
                    }
                    else{
                        PremiumB = 0;
                    }
                }
                TotalPremium = parseFloat(BaseValue) + parseFloat(PremiumA) + parseFloat(PremiumB);
              
                $('#MDSR2Year'+j).html('RM ' +formatCurrency(parseFloat(rowComm.col1)/100 * parseFloat(TotalPremium)));
                j++;
              
                 
             });
            
}

function showAdditionalRiders()//show HMM and/or MedPlus and MDSR1 and MDSR2
{
    //additionalRidersArr.push("MG_IV");
    //alert("additionalRidersArr.length = " + additionalRidersArr.length);
    if(additionalRidersArr.length > 0 )
    {
        for(var y=0; y<additionalRidersArr.length; y++)
        {
            if(additionalRidersArr[y] == "HMM")
            {
                showHmm();
            }
            else if(additionalRidersArr[y] == "MG_IV")
            {
                showMedPlus();
            }
            else if(additionalRidersArr[y] == "MDSR1")
            {
                showMDSR1();
            }
            else if(additionalRidersArr[y] == "MDSR2")
            {
                showMDSR2();
            }
        }
    }
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

function CurrencyNoCents2(num) {
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
			$('.Page50-Desc').html('The Policy Owner has the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from ' + iteration(gdata.SI[0].ReducedPaidUpYear) + ' up to ' + iteration(UpTo.toString()) + ' policy anniversary date, provided that the fund value is sufficient to pay for the one time charge. Upon Reduced Paid Up,<br/>' + 
		'the one time charge shall be deducted from the fund value to pay for the monthly policy fee and insurance charges of the Basic Policy for a tenure up to the end of policy year immediately after Life Assured attains age 75. The premium, insurance charge and<br/>' + 
		'monthly policy fee of the Basic Policy shall cease during the tenure.<br/>' + 
		'Once converted to a Reduced Paid Up Policy, the Basic Policy will be guaranteed in force throughout the tenure. However, at the end of the tenure, you may be required to pay for the premium, insurance charge and monthly policy fee of the Basic Policy up to the<br/>' + 
		'maturity of the policy or you may choose to be on premium holiday which uses your fund value to meet the monthly charges.<br/>' + 
		'Upon Death/ TPD/ OAD, whichever occurs first, the sum of Reduced Paid Up Sum Assured of Basic Plan plus fund value shall be payable. Fund value is determined by the number of units (balance of units after deduction of one time charge and adding any<br/>' + 
		'subsequent Guaranteed Bonus Units credited to the policy) multiplied by the prevailing unit price.<br/>' +
		'Upon maturity, the fund value shall be payable. For HLA EverGreen Funds, the Minimum Guaranteed Unit Price at Fund Maturity shall be applicable.<br/><br/>');
	}
	else
	{
		$('.Page50-Desc').html('The Policy Owner has the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from ' + iteration(gdata.SI[0].ReducedPaidUpYear) + ' up to last policy anniversary date prior to the maturity of the policy, provided that the fund value is sufficient to pay for the one time' + 
		'charge. Upon Reduced Paid Up, the one time charge shall be deducted from the fund value to pay for the monthly policy fee and insurance charges of the Basic Plan for the outstanding tenure. Thereafter, the premium, insurance charge and monthly policy fee of' +
		'the Basic Plan shall cease. ' +
		'Once converted to a Reduced Paid Up Policy, the Basic Plan will be guaranteed in force until maturity. ' +
		'Upon Death/ TPD/ OAD, whichever occurs first, the sum of Reduced Paid Up Sum Assured of Basic Plan plus fund value shall be payable. Fund value is determined by the number of units (balance of units after deduction of one time charge and adding any ' +
		'subsequent Guaranteed Bonus Units credited to the policy) multiplied by the prevailing unit price. ' +
		'Upon maturity, the fund value shall be payable. For HLA EverGreen Funds, the Minimum Guaranteed Unit Price at Fund Maturity shall be applicable. ');
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
		label = 'Basic Plan'
		
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
	$('.Page50-col2').html(CurrencyNoCents2( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear) ));
	$('.Page50-col3').html(CurrencyNoCents2(tempBasicPlanAndECARRider)); 
	$('.Page50-col3-label').html(label);
	
	$('.Page50-col5').html(CurrencyNoCents(gdata.SI[0].BasicSA));
	$('.Page50-col6').html(CurrencyNoCents(gdata.SI[0].ReducedSA));
	$('.Page50-col7').html(CurrencyNoCents(gdata.SI[0].ReducedCharge));
	
	var total1 = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem)) * parseInt(gdata.SI[0].ReducedPaidUpYear);
	var total2 = 0.00;
	
	if(gdata.SI[0].PlanCode == 'UV'){
		total2 = parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * (30 - parseInt(gdata.SI[0].ReducedPaidUpYear)) ;
	}
	else{
		total2 = 0.00;
	}
	
	if(gdata.SI[0].PlanCode == 'UV'){
		$('#Page50-table2 > tbody').append('<tr>' + '<td rowspan="2">' + gdata.SI[0].PlanName +  ' </td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
							  gdata.SI[0].ReducedPaidUpYear + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
							  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
							  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
							  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
							  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
							  formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear)) + '</td><td>' +
							  'Convert to a Reduced Paid Up Policy at ' + gdata.SI[0].ReducedPaidUpYear  + 'th policy anniversary' + '</td></tr>' +
						   '<tr>' + '<td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
							  '25' + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
							  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
							  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
							  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
							  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
							  formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * 25) + '</td><td>' +
							  'Premium continue to be payable immediately after the end of the policy year where Life Assured attains age 75 up to maturity of the policy' + '</td></tr>');	
	}
	else{
		
		$('#Page50-table2 > tbody').append('<tr>' + '<td>HLA EverGain Plus</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  gdata.SI[0].ReducedPaidUpYear + '</td><td>' + formatCurrency(AnnualisedValue(gdata.SI[0].ATPrem))  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  (gdata.SI[0].HLoad == '(null)' ? '0' : gdata.SI[0].HLoad) + '</td><td>' +
						  (gdata.SI[0].HLoadTerm == '(null)' ? '0' : gdata.SI[0].HLoadTerm)  + '</td><td>' +
						  (gdata.SI[0].HLoadPct == '(null)' ? '0' : gdata.SI[0].HLoadPct)  + '</td><td>' +
						  (gdata.SI[0].HLoadPctTerm == '(null)' ? '0' : gdata.SI[0].HLoadPctTerm)  + '</td><td>' +
						  formatCurrency( parseFloat(AnnualisedValue(gdata.SI[0].ATPrem) ) * parseInt(gdata.SI[0].ReducedPaidUpYear)) + '</td><td>' +
						  'Convert to a Reduced Paid Up Policy at ' + gdata.SI[0].ReducedPaidUpYear  + 'th policy anniversary' + '</td></tr>');
	}
	
	
	var totalRTUO = 0.00;
	
	if(parseFloat(tempRTUO) > 0){
		totalRTUO = (parseFloat(tempRTUO) * parseFloat(tempRTUOTerm));
		
		$('#Page50-table2 > tbody').append('<tr>' + '<td>Basic Unit Account<br/>Regular Top up<br/>(Optional)</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  tempRTUOTerm + '</td><td>' + formatCurrency(tempRTUO) + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  gdata.SI[0].HLoad + '</td><td>' + gdata.SI[0].HLoadTerm + '</td><td>' + gdata.SI[0].HLoadPct + '</td><td>' +
						  gdata.SI[0].HLoadPctTerm + '</td><td>' + formatCurrency(totalRTUO) + '</td><td>' +
						  'Basic Unit Account Regular Top Up Premium is payable from ' + iteration(gdata.SI[0].TopupStart) + ' to ' + iteration(gdata.SI[0].TopupEnd) + ' policy anniversary </td></tr>');
		 
	}

	var total3= 0.00;
	var aACIR = [];
	
	if(gdata.SI[0].UL_Temp_trad_Details.data.length > 0){
		
		var temp;
		$.each(gdata.SI[0].UL_Temp_trad_Details.data, function(index, row) {
			
			
			if(row.RiderCode == 'ECAR'){
				temp = 'This is a limited 6 years premium payment term rider'
			}
			else if(row.RiderCode == 'ECAR6'){
				temp = 'This is a limited 6 years premium payment term rider'
			}
			else{
				temp = 'This is a full premium payment term rider';
			}
			
			
			
			total3 = parseFloat(total3) + parseFloat((AnnualisedValue(row.TotalPremium)) * parseInt(row.PaymentTerm));
			
			var tempRiderPrem; 
			
			if(parseInt(row.RiderHLoadingTerm) > 0){
				tempRiderPrem = parseInt(gdata.SI[0].ReducedPaidUpYear) > row.RiderHLoadingTerm ? parseFloat(AnnualisedValue(row.TotalPremium)) - parseFloat(row.RiderLoadingPremium) : row.TotalPremium  ; 
			}
			else{
				tempRiderPrem = AnnualisedValue(row.TotalPremium); 
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
				else{
					$('#Page50-table2 > tbody').append('<tr>' + '<td >' + row.RiderDesc  +  '</td><td>' + gdata.SI[0].UL_Temp_trad_LA.data[0].Name  + '</td><td>' +
						  row.PaymentTerm + '</td><td>' + formatCurrency(tempRiderPrem)  + '</td><td>' + gdata.SI[0].OccpLoading  + '</td><td>' + 
						  row.RiderHLoading + '</td><td>' + row.RiderHLoadingTerm + '</td><td>' + row.RiderHLoadingPct + '</td><td>' +
						  row.RiderHLoadingPctTerm + '</td><td>' + formatCurrency((AnnualisedValue(row.TotalPremium)) * parseInt(row.PaymentTerm)) + '</td><td>' +
						  temp + '</td></tr>');			
				}
				
			//}
			
		});
		
		$('#Page50-table2 > tfoot').append('<tr><td colspan = "11"> <b>Entire policy</b>&nbsp;&nbsp;&nbsp;' + formatCurrency( parseFloat(total1) + parseFloat(total2) + parseFloat(total3) + parseFloat(totalRTUO))  + '</td></tr>' )
		
			if(aACIR.length > 1){
				
				if(parseFloat(aACIR[1]) > parseFloat( gdata.SI[0].ReducedSA) ){
					$('.Page50-ShowACIR').html('Note:' + '<br/>' +'* Accelerated Critical Illness Rider (ACIR) Sum Assured is required to be reduced if the Reduced Paid Up Sum Assured of Basic Plan is less than the ACIR Sum Assured. ' +
							'If the Reduced Paid Up Sum Assured of Basic Plan is less than RM' + formatCurrency(aACIR[1]) + 
							', ACIR would not be allowed. Please complete the Reduced Paid Up form for Ever Series. ');	
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
    
}

function iteration(input){
	if(input.substr(input.length - 1) == '1'){
		return(input + 'st');	
	}
	else if(input.substr(input.length - 1) == '2'){
		return(input + 'nd');	
	}
	else if(input.substr(input.length - 1) == '3'){
		return(input + 'rd');	
	}
	else {
		return(input + 'th');	
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



function showHmm()
{
    appendPage('page10','pds2HTML/PDSTwo_ENG_HMM_1.html');
    appendPage('page11','pds2HTML/PDSTwo_ENG_HMM_2.html');
    appendPage('page12','pds2HTML/PDSTwo_ENG_HMM_3.html');
    appendPage('page13','pds2HTML/PDSTwo_ENG_HMM_4.html');
    writePDS_HMM();

}

function showMedPlus()
{
    appendPage('page14','pds2HTML/PDSTwo_ENG_MG4_1.html');
    appendPage('page15','pds2HTML/PDSTwo_ENG_MG4_2.html');
    appendPage('page16','pds2HTML/PDSTwo_ENG_MG4_3.html');
    appendPage('page17','pds2HTML/PDSTwo_ENG_MG4_4.html');
    writePDS_MG4();
}

function showMDSR1()
{
    appendPage('page10','pds2HTML/PDSTwo_ENG_MDSR1_1.html');
    appendPage('page11','pds2HTML/PDSTwo_ENG_MDSR1_2.html');
    appendPage('page12','pds2HTML/PDSTwo_ENG_MDSR1_3.html');
    appendPage('page13','pds2HTML/PDSTwo_ENG_MDSR1_4.html');
    appendPage('page14','pds2HTML/PDSTwo_ENG_MDSR1_5.html');
    writePDS_MDSR1();

}

function showMDSR2()
{
    appendPage('page15','pds2HTML/PDSTwo_ENG_MDSR2_1.html');
    appendPage('page16','pds2HTML/PDSTwo_ENG_MDSR2_2.html');
    appendPage('page17','pds2HTML/PDSTwo_ENG_MDSR2_3.html');
    appendPage('page18','pds2HTML/PDSTwo_ENG_MDSR2_4.html');
    appendPage('page19','pds2HTML/PDSTwo_ENG_MDSR2_5.html');
    writePDS_MDSR2();

}

//declare variable for array rider
var isNeedSplit = "NO";
var splitCount = 3;
var arrLoadRider = new Array();
