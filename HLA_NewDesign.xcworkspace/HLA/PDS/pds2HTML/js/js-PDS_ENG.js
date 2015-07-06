function loadProductIntro ()
{
    var arrNoOne = new Array();
    arrNoOne[0] = "What is this product about?";
    arrNoOne[1] = "This is a regular premium investment-linked plan up to age 100";
    arrNoOne[2] = "Insurance protections provided are Death/ Total and Permanent Disability prior to attaining age 65 (TPD)/ Old Age Disablement after attaining age 65 (OAD); whichever occurs first.";
    arrNoOne[3] = "HLA EverLife Plus also provides Policy Owner the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from 3rd up to  7th policy anniversary date provided that the fund  value is sufficient to pay for the one time charge. Once converted to a Reduced Paid Up Policy, the Basic Plan will be guaranteed in force up to the end of policy year immediately after Life Assured attains age 75.";
    arrNoOne[4] = "The  policy values of this policy vary directly with the performance of the unit funds."
    arrNoOne[5] = "Your  insurance charge (which is not guaranteed and deducted from the fund value) will increase as you get older. It is possible that the fund value may be insufficient to pay for the insurance charge and policy";
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
            td.innerHTML = "-";
        }
        td2.innerHTML = arrNoOne[i-1];
        tr.appendChild(td);
        tr.appendChild(td2);
        tableOne.appendChild(tr);
    }
    tableOne.appendChild(lineBreak());
    
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
    id.appendChild(lineBreak());
    
}//table One in section 2

function loadTPD(id)
{
    var arrNoTwoB = new Array();
    arrNoTwoB[0] = "II) Total Permanent Disability (TPD) Benefit";
    arrNoTwoB[1] = "In  the event of TPD of the Life Assured (any causes), the amount payable shall be the SUM of:";
    arrNoTwoB[2] =  new Array("Sum Assured; and","Fund Value at the Next Valuation Date immediately following the date of admission of TPD claim. Juvenile Lien as shown in Table (I) above shall apply.");;
    arrNoTwoB[3] = "TPD  Benefit will be paid in accordance to TPD provision as below:";
    arrNoTwoB[4] = "table of total TPD";
    arrNoTwoB[5] = "Total  TPD Benefits payable per Life under all policies insuring the Life Assured shall not exceed the TPD Benefit Limit per Life stated above. The Total TPD Benefit payable per Life refers to by TPD coverage  of all in-force policies for  each Life Assured at the point of claim event after application of Juvenile Lien.";
    
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
    var arrNoTwoD = new Array();
    arrNoTwoD[0] = "IV) Reduced Paid Up Option";
    arrNoTwoD[1] = "The  Policy Owner has the rights to convert the plan to a Reduced Paid Up Policy at any policy anniversary date starting from 3rd up to 7th policy anniversary date, provided that the fund value is sufficient to pay for the one time charge. Upon Reduced Paid Up, the one time charge shall be deducted from the fund value to pay for the monthly policy fee and insurance charges of the Basic Plan for a tenure up to the end of policy year immediately after Life Assured attains age 75. The premium, insurance charge and monthly policy fee of the Basic Plan shall cease during the tenure.";
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
    var arr = new Array("Age at Occurence","0.1","2","3","4","Reduced Sum Assured After factoring in Juvenile Lien","20%","40%","60%","80%");
    
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
    var arr = new Array("Attained Age upon TPD","Less Than 7","7 to less than 15","15 to less than 65","TPD Benefit Limit per Life","RM 100,000","RM 500,000","RM 3500,000");
    
    var table = document.createElement('table');
    table.setAttribute('class','normalTable');
    table.style.width = "95%";

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


//============================================ 2B. attaching rider List ======================================



function loadTableAR_CIR()//Critical Illness Rider
{
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Critical Illness WP Rider","3,000.00 </br>(Annual)","5","Life Assured",loadTableAR_CIR_desc());
    
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
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrContent = new Array ("Accelerated Critical Illness","10,000.00","10","Life Assured",loadTableAR_ACIR_desc());
    
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
function loadTableAR()//acc death & Compassionate Allowance Rider
{
    var riderNo = new Array("0","1","2");
    
    var arrTitle = new Array("Rider(s)","Sum Assured/Benefit","Coverage Period","Insured Lives","Description of Benefit");
    var arrADCAR = new Array("Acc Death &Compassionate Allowance Rider","10,000.00","5","Life Assured","In the event of accidental Death of the Life Assured, the Accidental Death Benefit payable shall be RM10,000.00. Compassionate Allowance ofRM10,000 will be payable in addition to Accidental Death Benefit.");
    var arrADHI = new Array("Acc.Daily Hospitalisation Income","50.00</br>(Daily)","5","Life Assured","In the event that the Life Assured is hospitalised in an approved hospital for a minimum of 6 continuous hours per admission as the result of an");
    var arrE1R = new Array("EverCash 1 Rider","600.00</br>(Annual)","20","Life Assured","This rider will provide a Guaranteed Yearly Income of RM600.00 starting from end of 1st year up to the expiry of this Rider. Upon death/ TPD (prior toattaining age 65), 100% of the outstanding Guaranteed Yearly Income shall be payable. Upon Accidental TPD, the additional amount payable shall be300% of outstanding Guaranteed Yearly Income.");
    var arrER = new Array("EverCash Rider","600</br>(Annual)","20","Life Assured","This rider will provide a Guaranteed Yearly Income of RM600.00 starting from end of 1st year up to the expiry of this Rider. Upon death/ TPD (prior toattaining age 65), 100% of the outstanding Guaranteed Yearly Income shall be payable. Upon Accidental TPD, the additional amount payable shall be300% of outstanding Guaranteed Yearly Income.");
    var arrLR = new Array("LifeShield Rider","20000.00","37","Life Assured","In the event of Death or TPD (prior to attaining age 65) of Life Assured, the Death/ TPD benefit equivalent to RM20,000.00 shall bepayable.TPD benefit will be paid in accordance to TPD provision.Juvenile LIEN rule shall apply.");
    var arrAMRR = new Array("Acc. Medical Reimbursement Rider","1,000.00","5","Life Assured","In the event of accident, medical and surgical expenses such as inpatient and outpatient treatment incurred by Life Assured will be reimbursed up to RM1,000.00 per accident.");
    var arrPAR = new Array("Personal Accident Rider","10,000.00","5","Life Assured","n the event of accidental Death of the Life Assured, the Accidental Death Benefit payable shall be RM10,000.00. In the event of accidental Partial/Total & Permanent Disability of the Life Assured, Accidental Partial/ Total & Permanent Disability Benefit payable shall be in accordance to Scheduleof Indemnities. The Accidental Partial/ Total & Permanent Disability Benefit payable shall be accelerated from the Rider Sum Assured.");
    var arrATPDMLAR = new Array("Acc. TPD Monthly Living Allowance Rider","500.00</br>(Monthly)","5","Life Assured","In the event that the Life Assured suffers any of the following loss or disability as the result of an accident within 365 days from the date ofoccurrence; a Monthly Living Allowance equivalent to RM500.00 will be payable up to maximum of 180 months during the lifetime of the Life Assured:" + loadDetailsAR(["-","-","-","-","-","-","-","-","-"],["Total Permanent Disability;","permanent total loss of sight of both eyes;","permanent total loss of sight of one eye;","permanent total loss of speech and hearing;","loss of or the permanent loss of use of two limbs;","loss of or the permanent loss of use of one limb;","permanent and incurable insanity; or","permanent total paralysis."]));
    //var tempATPDMLAR = "In the event that the Life Assured suffers any of the following loss or disability as the result of an accident within 365 days from the date ofoccurrence; a Monthly Living Allowance equivalent to RM500.00 will be payable up to maximum of 180 months during the lifetime of the Life Assured: </br>-&nbsp&nbsp Total Permanent Disability;</br>-&nbsp&nbsp permanent total loss of sight of both eyes;</br>-&nbsp&nbsp permanent total loss of sight of one eye;</br>-&nbsp&nbsp permanent total loss of speech and hearing;</br>-&nbsp&nbsp loss of or the permanent loss of use of two limbs;</br>-&nbsp&nbsp loss of or the permanent loss of use of one limb;</br>-&nbsp&nbsp permanent and incurable insanity; or</br>-&nbsp&nbsp permanent total paralysis.";
    
    var arrTPDWPR = new Array("TPD Waiver of Premium Rider","13,921.54</br>(Annual)","4","Life Assured","The rider Sum Assured will be paid to reduce future premium up to expiry date of the rider upon the first occurrence of TPD (prior to attaining age 65)/OAD (after attaining age 65) of the life assured during the coverage period. Premium is guaranteed and on level basis.");
    var arrAWIR = new Array("Acc.Weekly Indemnity","100.00</br>(Weekly)","5","Life Assured","In the event of accidental Temporary Total Disability of the Life Assured, weekly indemnity equivalent to RM100.00 will be payable. In the event ofaccidental Temporary Partial Disability of the Life Assured, weekly indemnity equivalent to RM25.00 will be payable. Maximum duration payable foraccidental Temporary Total Disability and accidental Temporary Partial Disability is up to 104 weeks per accident.");
    
    
    var arrAllRiderToDisplay = new Array();
    for (i = 0 ; i< riderNo.length ; i++)
    {
        switch (parseInt(riderNo[i])){
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
                td.setAttribute('class','tdVerticalAlign textAlignCenter');
                
            }
            tr.appendChild(td);
        }
        
        table.appendChild(tr);
    }
    
    return table;
    
}
function loadTableAR_ACIR_desc()//accelerated Critical Illness Rider desc
{
    
    var arrPoints = new Array ("Stroke","Heart Attack","End Stage Kidly Failure","Cancer","Coronary Artery By-Pass Surgery","Other Serious Coronary Artery Disease","Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease*","End Stage Liver Failure","Fulminant Viral Hepatitis","Coma","Benign Brain Tumor","Paralysis / Paraplegia","Blindness / Total Loss Of Sight","Deafness / Total Loss Of Hearing","Major Burns","End Stage Lung Disease","Encephalitis","Major Organ / Bone Marrow Transplant","Loss Of Speech","Brain Surgery","Heart Valve Surgery","Terminal Illness","HIV Due To Blood Transfusion","Bacterial Meningitis","Major Head Trauma","Chronic Aplastic Anemia","Motor Neuron Disease","Parkinson's Disease","Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders","Muscular Dystrophy","Surgery to Aorta","Multiple Sclerosis","Primary Pulmonary Arterial Hypertension","Medullary Cystuc Disease","Severe Cardiomyopathy","Systemic Lupus Erythematosus with Lupus Nephritis");
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
            td.innerHTML = "RM 10,000.00 is payable upon diagnosis of any of the 36 critical illness of the Life Assured during the coverage term.</br>Upon payment of the ACIR Sum Assured, the Basic Sum Assured will be reduced accordingly.</br>The Following 36 critical illness are covered:";
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
function loadTableAR_CIR_desc()// Critical Illness Rider desc
{
    
    var arrCIRDetailsPoint = new Array ("Stroke","Heart Attack","End Stage Kidly Failure","Cancer","Coronary Artery By-Pass Surgery","Other Serious Coronary Artery Disease","Angioplasty And Other Invasive Treatments For Major Coronary Artery Disease*","End Stage Liver Failure","Fulminant Viral Hepatitis","Coma","Benign Brain Tumor","Paralysis / Paraplegia","Blindness / Total Loss Of Sight","Deafness / Total Loss Of Hearing","Major Burns","End Stage Lung Disease","Encephalitis","Major Organ / Bone Marrow Transplant","Loss Of Speech","Brain Surgery","Heart Valve Surgery","Terminal Illness","HIV Due To Blood Transfusion","Bacterial Meningitis","Major Head Trauma","Chronic Aplastic Anemia","Motor Neuron Disease","Parkinson's Disease","Alzheimer's Disease/Irreversible Organic Degenerative Brain Disorders","Muscular Dystrophy","Surgery to Aorta","Multiple Sclerosis","Primary Pulmonary Arterial Hypertension","Medullary Cystuc Disease","Severe Cardiomyopathy","Systemic Lupus Erythematosus with Lupus Nephritis");
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
            td.innerHTML = "The  rider Sum Assured will be paid to reduce future premium up to expiry date of the rider upon diagnosis of any of the 36 critical illnesses covered of the life assured during the coverage period. Premium is guaranteed and on level basis. The  following 36 critical illnesses are covered:";
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
//============================================ END 2B. attaching rider List ======================================
function loadSectionTwo (id)
{
    var arrNoTwo = new Array();
    arrNoTwo[0] = "What are the covers / benefits provided?";
    arrNoTwo[1] = "A) Basic Plan";
    arrNoTwo[2] = "The  Sum Assured for this plan is RM <span class='BasicSA'>{BasicSA}</span> and the duration of the coverage is 37 years or upon termination, whichever occurs first.";
    
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
    id.appendChild(lineBreak());
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
    
    td.innerHTML = "&nbsp";
    if (load2BRider == "ACIR")
    {
        td2.appendChild(loadTableAR_ACIR());
        
    }
    else if (load2BRider == "CIR")
    {
        td2.appendChild(loadTableAR_CIR());
        
    }
    else if (load2BRider == "OTHERS")
    {
        td2.appendChild(loadTableAR());
        
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
    
    // var arrTitle = new Array("Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?","Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?");
    var arrFund = new Array("Fund","HLA EverGreen 2023","HLA EverGreen 2025","HLA EverGreen 2028","HLA EverGreen 2030");
    var arrFundAlloc = new Array("Fund Allocation (%)","0%","0%","0%","0%");
    var arrMGUPAFMA = new Array("Minimum Guaranteed Unit Price at Fund Maturity applicable?","Yes","Yes","Yes","Yes");
    
    var arrFund2 = new Array("Fund","HLA EverGreen 2035","HLA Dana Suria","HLA Secure Fund","HLA Cash Fund");
    var arrFundAlloc2 = new Array("Fund Allocation (%)","40%","0%","40%","20%");
    var arrMGUPAFMA2 = new Array("Minimum Guaranteed Unit Price at Fund Maturity applicable?","Yes","No","No","No");
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
                    td.innerHTML = arrFund[i];
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

function loadPremiumPay()
{
    var arrProdArr = getArrPlanSplit(getProdList());
    // var arrTitle = new Array("Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?","Fund","Fund Allocation (%)","Minimum Guaranteed Unit Price at Fund Maturity applicable?");
    /*var arrPlanRider = new Array("HLA Everlife Plus","Critical Illness Waiver of Premium Rider","Acc. Weekly Indemnity Rider","TPD Waiver of Premium rider","Acc. TPD Monthly Living Allowance Rider","Personal Accident Rider","Acc. Medical Reimbursement rider","MedGLOBAL IV Plus","LifeShield Rider","Acc. Daily Hospitalisation Income Rider","Acc. Death & Compassionate Allowance Rider","Accelerated Critical Illness","HLA Major Medi","Critical Illness Waiver of Premium Rider");
     var arrType = new Array("Basic Plan","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider","Rider");
     var arrInsuredLives = new Array("Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured","Life Assured");
     var arrInitialPremiumAnn = new Array("3,000,00","506.10","19.60","143.29","143.29","143.29","143.29","143.29","143.29","143.29","143.29","143.29","143.29","143.29","143.29");*/
    var arrWidthPortion = new Array("35%","10%","20%","35%");
    
    var str ="<tr style='font-weight: bold;'><td rowspan='2'>Plan / Rider</td><td rowspan='2' style='text-align: center;'>Type</td><td rowspan='2' style='text-align: center;'>Insured Lives</td><td style='text-align: center;'>Initial Premium</td></tr><tr style='font-weight: bold;'><td style='text-align: center;'>Annually (RM)</td></tr>";
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
        var trTemp = document.createElement('tr');
        
        var row = "<td colspan='2'>Total</td><td></td><td style='text-align:center'>3506.10</td>";
        trTemp.innerHTML = row;
        table.appendChild(trTemp);
        

    }
       return table;
}

function loadPremiumDuration()
{
    
    var arrProdArr = getProdList();
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
    
    for (i = 0;i<arrRider.length;i++)
    {
        var tr = document.createElement('tr');
        
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.setAttribute('class','alignTop normalTableTD');
        td2.setAttribute('class','normalTableTD');
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
function loadAttachRider_ADHIRDesc()
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
    
    var tdHead = "<tr class='bold'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
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
function loadAttachRider_CIRDetail()//critical illness wp rider details
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
    
    
    
    var tdHead = "<tr class='bold'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
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
    
    var tdHead = "<tr class='bold'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
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
    
    
    
    var tdHead = "<tr class='bold'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
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
    
    
    
    var tdHead = "<tr class='bold'><td colspan='2'>This rider does not cover the following occurrences:</td></tr>";
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
    if(arr.length >2)
    {
        
        appendPage('page9','PDS/pds2HTML/PDSTwo_ENG_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR1";
        var page9ContentATemp = document.getElementById('page9ContentA');
        page9ContentATemp.id = "page9ContentATemp";
        
        
        var page9ContentBTemp = document.getElementById('page9ContentB');
        page9ContentBTemp.id = "page9ContentBTemp";
        page9ContentBTemp.style.display = "none";
        
        appendPage('page9b','PDS/pds2HTML/PDSTwo_ENG_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR2";
        document.getElementById("page9ContentA").style.display = "none";
    }
    else{
        appendPage('page9','PDS/pds2HTML/PDSTwo_ENG_Page9.html');
        
    }
    
    
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
    
    tb.border = "0";
    
    tb.style.height='906px';//906 is estimate of ipad full height
    tb.setAttribute('class','tableMain');
    tr1.style.height = '90%';
    tr2.style.height = '10%';
    tb.style.width = '100%';
    td1.setAttribute('id',pageNo);
    td2.innerHTML ="<table border ='0' style=' font-family:Arial;font-size:12px;font-weight:normal'><tr><td colspan='3'><span>This product disclosure sheet consists of<span>7</span>pages and each page forms an integral part of the sales illustration. A prospective policy owner is advised to read and understand the information printed on each and every page.</br><b>Win MP (Ever & EverLove Plus Series) Version 3.8 (Agency) Last Updated 30 May 2013 - E&OE-</b></span></td></tr><tr><td style='width: 60%'>Level 3, Tower B, PJ City Development, No. 15A Jalan 219, Seksyen 51A, 46100 Petaling Jaya, Selangor. Tel: 03-7650 1818 Fax: 03-7650 1991 Website: www.hla.com.my</td><td style='width: 10%' >page <span id='currPageID'>{currPageNo}</span> of <span class='totalPageNoClass'>{Pages}</span></td><td style='width: 10%;text-align: right'>ref: 12345678910-1234</td></tr></table>";

    
    
    

    tb.style.margin = '0px';
    tr1.appendChild(td1);
    tr2.appendChild(td2);
    tb.appendChild(tr1);
    tb.appendChild(tr2);
    return tb;
    
}

function loadPageNo()
{
    var tempPage = document.getElementById('currPageID');
    tempPage.id = "currPageID"+currPageNo;
    tempPage.setAttribute('class',"currPageClass"+currPageNo);
    $(".currPageClass"+currPageNo).html(currPageNo);
    $(".totalPageNoClass").html(currPageNo);
    
}
function appendPage(pageNo,path)
{
    document.getElementById('page').appendChild(createPage(pageNo));
    appendChildExt(path,document.getElementById(pageNo));
    loadPageNo();
}

//=======================================page 5 split page base on rider==========================
function needSplitPageForPlan()//page 5 split page base on rider
{
    
    
    isNeedSplit = "NO";//split data
    appendPage('page5','PDS/pds2HTML/PDSTwo_ENG_Page5.html');
    isNeedSplit = "YES";
    appendPage('page5b','PDS/pds2HTML/PDSTwo_ENG_Page5b.html');
    loadInterfacePage();//to check to hide some division
    
    
}
function loadInterfacePage() //page 5 method
{
    var x =  document.getElementById('premiumDurationTR');
    x.style.display = "none";
    
    if (getProdList().length <= splitCount)
    {
        var y =  document.getElementById('premiumPayTwoTR');
        y.style.display = "none";
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
function getProdList()//get prod list for page 5
{
    
    var arrPlan = new Array();
    
    var plan = new productPlan();
    plan.prodName = "HLA Everlife Plus";
    plan.prodType = "Basic Plan";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "1,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Critical Illness Waiver of Premium Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "2,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Acc. Weekly Indemnity Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "3,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "TPD Waiver of Premium rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "4,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. TPD Monthly Living Allowance Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "5,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Personal Accident Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "6,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. Medical Reimbursement rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "7,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "MedGLOBAL IV Plus";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "8,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "LifeShield Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "9,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Acc. Daily Hospitalisation Income Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "10,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. Death & Compassionate Allowance Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "11,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "HLA Major Medi";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Accelerated Critical Illness";
    plan.prodInitPremAnn = "12,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Critical Illness Waiver of Premium Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Life Assured";
    plan.prodInitPremAnn = "13,000,00";
    arrPlan.push(plan);
    
    return arrPlan;
}
//=======================================page 5 split page base on rider==========================

function getRiderList()//rider data for 6B
{
    var arrRider = new Array();
    
    var rd = new Rider();
    rd.riderName = "Accelerated Critical Illness Rider";
    rd.riderCode = "ACIR";
    rd.riderDetailTitle = "The critical illness provision does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_CIRDetail();//add this one..tempprary use cir
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Critical Illness Wp Rider";
    rd.riderCode = "CIR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_CIRDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Death & Compasionate Allowance Rider";
    rd.riderCode = "ADCAR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Daily Hospitalisation Income Rider";
    rd.riderCode = "ADHIR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADHIRDesc();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash 1 Rider";
    rd.riderCode = "EC1R";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash Rider";
    rd.riderCode = "ECR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "LifeShield Rider";
    rd.riderCode = "LSR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Medical Reimbursement Rider";
    rd.riderCode = "AMRR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADHIRDesc();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Personal Accident Rider";
    rd.riderCode = "PAR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. TPD Monthly Living Allowance Rider";
    rd.riderCode = "ATPDMLAR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "TPD Waiver of Premium Rider";
    rd.riderCode = "TPDWPR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_TPDWPR();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Weekly Indemnity Rider";
    rd.riderCode = "AWIR";
    rd.riderDetailTitle = "This rider does not cover the following occurrences:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    return arrRider;
}

function getRiderList_7B()
{
    var arrRider = new Array();
    var rd = new Rider();
    rd.riderName = "Accelerated Critical Illness";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    
    var rd = new Rider();
    rd.riderName = "Critical Illness Waiver of Premium Rider";
    rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Death & Compassionate Allowance Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Daily Hospitalisation Income Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash 1 Rider";
    rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash Rider";
    rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "LifeShield Rider";
    rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Medical Reimbursement Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Personal Accident Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. TPD Monthly Living Allowance Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "TPD Waiver of Premium Rider";
    rd.riderDesc = "If you terminate this rider prematurely, you may get less than the amount you have paid in.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Weekly Indemnity Rider";
    rd.riderDesc = "If you terminate this rider prematurely the termination of coverage will be effected on the next monthly anniversary following the notification of cancellation. Fundvalue of the Rider Unit Account will be payable upon surrender of the policy.";
    arrRider.push(rd);
    
    return arrRider;
    
    
}

function needSplitPageForRider_2B()
{
    
    var arrRiderForTwoB = new Array("ACIR","CIR","EC1R");//riders to display in 2B
    
    var a = 1;
    for (x in arrRiderForTwoB)
    {
        if (arrRiderForTwoB[a-1] == "ACIR")
        {
            currPage = 'page4Content-'+a;
            load2BRider = "ACIR";
            appendPage('page4-'+a,'PDS/pds2HTML/PDSTwo_ENG_Page4.html');
            
        }
        else if (arrRiderForTwoB[a-1]=="CIR")
        {
            currPage = 'page4Content-'+a;
            load2BRider = "CIR";
            appendPage('page4-'+a,'PDS/pds2HTML/PDSTwo_ENG_Page4.html');
            
        }
        else if (arrRiderForTwoB[a-1] == "EC1R")
        {
            currPage = 'page4Content-'+a;
            load2BRider = "OTHERS";
            appendPage('page4-'+a,'PDS/pds2HTML/PDSTwo_ENG_Page4.html');
            break;
            
        }
        a=a+1;
    }
}
var PAGE_ALLOCATED = 8;//change this to have different page

function needSplitPageForRider_6B()//page8 - 6 B rider
{
    
    var arrTempRider = getRiderList();
    
    var arrPageEightRider = new Array();
    
    for (i = 0; i < PAGE_ALLOCATED;i++)//no of pages
    {
        var pageRider = new pageEightRider();
        pageRider.pageName = "page8-"+ (i+1);
        pageRider.isPageNeedToShow = "NO";
        arrPageEightRider.push(pageRider);
    }
    
    for (i = 0;i < arrTempRider.length;i++)
    {
        
        
        if (arrTempRider[i].riderCode == "ACIR" || arrTempRider[i].riderCode == "CIR")
        {
            var page1;
            if (!page1)
            {
                page1 = arrPageEightRider[0];
                page1.riderList = new Array();
            }
            page1.isPageNeedToShow = "YES";
            page1.riderList.push(arrTempRider[i]);
        }
        else if (arrTempRider[i].riderCode == "ADCAR")
        {
            var page2;
            if (!page2)
            {
                page2 = arrPageEightRider[1];
                page2.riderList = new Array();
            }
            page2.isPageNeedToShow = "YES";
            page2.riderList.push(arrTempRider[i]);
        }
        
        else if (arrTempRider[i].riderCode == "ADHIR")
        {
            var page3;
            if (!page3)
            {
                page3 = arrPageEightRider[2];
                page3.riderList = new Array();
            }
            page3.isPageNeedToShow = "YES";
            page3.riderList.push(arrTempRider[i]);
            
        }
        else if (arrTempRider[i].riderCode == "EC1R" || arrTempRider[i].riderCode == "ECR" ||arrTempRider[i].riderCode == "LSR")
        {
            var page4;
            if (!page4)
            {
                page4 = arrPageEightRider[3];
                page4.riderList = new Array();
            }
            page4.isPageNeedToShow = "YES";
            page4.riderList.push(arrTempRider[i]);
            
        }
        else if (arrTempRider[i].riderCode == "AMRR")
        {
            var page5;
            if (!page5)
            {
                page5 = arrPageEightRider[4];
                page5.riderList = new Array();
            }
            page5.isPageNeedToShow = "YES";
            page5.riderList.push(arrTempRider[i]);
            
        }
        else if (arrTempRider[i].riderCode == "PAR")
        {
            var page6;
            if (!page6)
            {
                page6 = arrPageEightRider[5];
                page6.riderList = new Array();
            }
            page6.isPageNeedToShow = "YES";
            page6.riderList.push(arrTempRider[i]);
            
        }
        else if (arrTempRider[i].riderCode == "ATPDMLAR")
        {
            var page7;
            if (!page7)
            {
                page7 = arrPageEightRider[6];
                page7.riderList = new Array();
            }
            page7.isPageNeedToShow = "YES";
            page7.riderList.push(arrTempRider[i]);
            
        }
        else if (arrTempRider[i].riderCode == "TPDWPR" || arrTempRider[i].riderCode == "AWIR")
        {
            var page8;
            if (!page8)
            {
                page8 = arrPageEightRider[7];
                page8.riderList = new Array();
            }
            page8.isPageNeedToShow = "YES";
            page8.riderList.push(arrTempRider[i]);
            
        }
        
        
    }
    var a = 1;
    for(x in arrPageEightRider)
    {
        currPage = 'page8Content-'+ a;
        arrLoadRider = arrPageEightRider[a-1].riderList;
        appendPage('page8-'+ a,'PDS/pds2HTML/PDSTwo_ENG_Page8.html');
        a++;
    }
    // currPage = 'page8Content-'+2;
    //arrLoadRider = arrPageEightRider[4].riderList;
    //
    // appendPage('page8-'+2,'PDSTwoPage8.html');
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
//=====object ======
function Rider(riderName,RiderDesc)
{
    this.riderName;
    this.riderDesc;
    this.arrDetails;
    this.riderDetailTitle;//wording before points
    this.riderCode;
    
}
function productPlan()
{
    this.prodName;
    this.prodType;
    this.prodInsuredLives;
    this.prodInitPremAnn;
    
}
function pageEightRider()
{
    this.pageName;
    this.riderList;
    this.isPageNeedToShow;
    
}
//=====object ======

//declare variable for array rider
var isNeedSplit = "NO";
var splitCount = 6;
var arrLoadRider = new Array();
