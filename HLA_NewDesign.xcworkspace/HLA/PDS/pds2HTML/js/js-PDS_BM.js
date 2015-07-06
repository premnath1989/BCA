function loadProductIntro ()
{
    var arrNoOne = new Array();
    arrNoOne[0] = "Apakah produk ini?";
    arrNoOne[1] = "Ini ialah pelan premium berkala berkait pelaburan sehingga umur 100.";
    arrNoOne[2] = "Perlindungan insurans yang disediakan adalah Kematian/ Hilang Upaya Menyeluruh dan Kekal sebelum mencapai umur 65 tahun (TPD)/ Ketidakupayaan Masa Tua selepas mencapai umur 65 tahun (OAD); yang mana berlaku terdahulu.";
    arrNoOne[3] = "HLA EverLife Plus juga memberi hak kepada Pemunya Polisi untuk menukar pelan kepada satu Polisi Berbayar Terkurang pada sebarang tarikh ulang tahun polisi bermula dari tarikh ulang tahun polisi ke-3 hingga ke tarikh ulang tahun polisi yang ke-7 sekiranya nilai dana adalah mencukupi untuk membayar caj tunggal. Setelah ditukar ke Polisi Berbayar Terkurang, Pelan Asas akan dijamin berkuat kuasa sehingga akhir tahun polisi serta-merta selepas Hayat Diinsuranskan mencapai umur 75.";
    arrNoOne[4] = "Nilai polisi bagi polisi ini akan berubah secara langsung dengan prestasi dana-dana unit."
    arrNoOne[5] = "Caj insurans anda (yang tidak terjamin dan ditolak berikutnya daripada nilai dana) akan meningkat seiring dengan peningkatan usia anda. Nilai dana mungkin tidak mencukupi untuk membayar caj insurans dan yuran polisi pada tahun-tahun berikutnya disebabkan oleh keadaan-keadaan seperti pulangan dana yang tidak memuaskan atau pengeluaran yang menyebabkan polisi anda menjadi lupus sebelum mencapai umur 100 tahun. Jika ini berlaku, anda perlu menambah premium anda bagi memastikan perlindungan yang berterusan.";
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
    arrNoTwoA[0] = "I) Faedah Kematian";
    arrNoTwoA[1] = "Jika Hayat Diinsuranskan Meninggal Dunia, amaun yang akan dibayar adalah JUMLAH daripada:";
    arrNoTwoA[2] =  new Array("umlah Diinsuranskan; dan","Nilai Dana pada Tarikh Penilaian Seterusnya serta-merta berikutan tarikh notifikasi Kematian");
    arrNoTwoA[3] =  "Lien Juvenil akan dikenakan seperti berikut: Sekiranya berlaku Kematian atau TPD sebelum umur 5 tahun, Jumlah Diinsuranskan akan dikurangkan. Akibatnya, faedah yang akan dibayar adalah Jumlah Diinsuranskan Terkurang seperti yang ditunjukkan dalam Jadual (I) di bawah tambah nilai dana";
    
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
    id.appendChild(lineBreak());
    
}//table One in section 2
function loadDeathBenefitTwo (id)
{
    // display No.1 basic plan of PDS reports
    var arrNoTwoA = new Array();
    
    arrNoTwoA[0] ="Table (I)";
    
    for (i = 1 ;i<=arrNoTwoA.length;i++)
    {
        var tr = document.createElement('tr');
        var td = document.createElement('td');
        var td2 = document.createElement('td');
        td.innerHTML = "&nbsp";
        
        td2.appendChild(loadTableDeathBenefit());
        
        tr.appendChild(td);
        tr.appendChild(td2);
        id.appendChild(tr);
        
    }//for loop
    
    id.appendChild(lineBreak());
    
}//table One in section 2 two

function loadTPD(id)
{
    var arrNoTwoB = new Array();
    arrNoTwoB[0] = "II) Faedah Hilang Upaya Menyeluruh dan Kekal (TPD)";
    arrNoTwoB[1] = "Jika Hayat Diinsuranskan mengalami TPD, amaun yang akan dibayar adalah JUMLAH daripada:";
    arrNoTwoB[2] =  new Array("Jumlah Diinsuranskan; dan; and","Nilai Dana pada Tarikh Penilaian Seterusnya serta-merta berikutan tarikh tuntutan TPD diterima.Lien Juvenil seperti yang ditunjukkan dalam Jadual (I) di atas akan dikenakan. ");
    arrNoTwoB[3] = "Faedah TPD akan dibayar berdasarkan peruntukan TPD berikut:";
    arrNoTwoB[4] = "table of total TPD";
    arrNoTwoB[5] = "Jumlah Faedah TPD setiap Hayat yang dibayar bagi semua polisi yang menginsuranskan Hayat yang Diinsuranskan tidak akan melebihi Had Faedah TPD setiap Hayat seperti yang dinyatakan di atas. Jumlah Faedah TPD setiap Hayat merujuk kepada perlindungan TPD bagi semua polisi yang berkuat kuasa atas setiap Hayat yang Diinsuranskan ketika tuntutan dibuat selepas Lien Juvenil diaplikasikan.";
    
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
    arrNoTwoC[0] = "III) Faedah Ketidakupayaan Masa Tua (OAD)";
    arrNoTwoC[1] = "Jika hayat Diinsuranskan mengalami OAD, amaun yang akan dibayar adalah JUMLAH daripada:";
    arrNoTwoC[2] =  new Array("Jumlah Diinsuranskan; dan","Nilai Dana pada Tarikh Penilaian Seterusnya serta-merta berikutan tarikh tuntutan OAD diterima.");
    arrNoTwoC[3] = "Jumlah Faedah OAD setiap Hayat yang dibayar bagi semua polisi yang menginsuranskan Hayat yang Diinsuranskan dihad kepada RM1,000,000 setiap Hayat. Jumlah Faedah OAD setiap Hayat merujuk kepada perlindungan OAD bagi semua polisi yang berkuat kuasa atas setiap Hayat yang Diinsuranskan ketika tuntutan dibuat.";
    
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
    arrNoTwoD[0] = "IV) Opsyen Berbayar Terkurang";
    arrNoTwoD[1] = "Pemunya Polisi mempunyai hak untuk menukarkan pelan kepada Polisi Berbayar Terkurang pada sebarang tarikh ulang tahun polisi bermula dari tarikh ulang tahun polisi ke-3 sehingga tarikh ulang tahun polisi ke- 7, sekiranya nilai dana adalah mencukupi untuk membayar caj tunggal. Setelah Berbayar Terkurang, caj tunggal akan ditolak daripada nilai dana untuk membiayai yuran polisi bulanan dan caj insurans bagi Pelan Asas untuk baki tempoh sehingga akhir tahun polisi serta-merta selepas Hayat Diinsuranskan mencapai umur 75.  Premium, caj insurans dan yuran polisi bulanan bagi Pelan Asas akan dihentikan sepanjang tempoh tersebut.";
    arrNoTwoD[2] = "</br>Setelah ditukar ke Polisi Berbayar Terkurang, Pelan Asas akan dijamin berkuat kuasa sepanjang tempoh tersebut. Walau bagaimanapun, anda dikehendaki untuk membayar premium, caj insurans dan yuran polisi bulanan bagi Pelan Asas selepas tempoh tamat sehingga kematangan polisi atau anda boleh memilih opsyen cuti premium yang menggunakan nilai dana untuk membiayai caj-caj bulanan.";
    arrNoTwoD[3] = "</br>Ketika Kematian/ TPD/ OAD, yang mana berlaku terdahulu, jumlah daripada Jumlah Diinsuranskan Polisi Berbayar Terkurang bagi Pelan Asas tambah nilai dana akan dibayar. Nilai dana ditentukan dengan mendarabkan bilangan unit (baki unit selepas penolakkan caj tunggal dan rangkuman Unit Bonus Terjamin yang diperuntukkan ke dalam polisi) dengan harga unit semasa.";
    arrNoTwoD[4] = "</br>Semasa kematangan, nilai dana akan dibayar. Untuk HLA EverGreen Fund, Harga Unit Terjamin Minimum pada Kematangan Dana adalah berkenaan.";
    
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
    arrNoTwoE[0] = "V)	Unit Bonus Terjamin";
    arrNoTwoE[1] = "Unit Bonus Terjamin akan dikreditkan ke dalam polisi anda sekali setiap tahun polisi, bermula dari permulaan tahun polisi ketujuh (ke-7) seperti yang ditunjukkan di bawah.";
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
    arrNoTwoE[0] = "VI) Faedah Kematangan";
    arrNoTwoE[1] = "Jika  Hayat Diinsuranskan  masih hidup pada hujung tempoh polisi, sejumlah Faedah Kematangan bersamaan dengan nilai dana akan dibayar.";
    
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
    var arr = new Array("Umur Ketika Kejadian","0.1","2","3","4","Jumlah Diinsuranskan Terkurang selepas pemfaktoran lien Juvenil(% daripada Jumlah Diinsuranskan Asal)","20%","40%","60%","80%");
    
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
    var arr = new Array("Umur Tercapai ketika Mengalami TPD","Kurang daripada 7","7 sehingga kurang daripada 15","15 sehingga kurang daripada 65","Had Faedah TPD setiap Hayat","RM 100,000","RM 500,000","RM 3500,000");
    
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
    var arr = new Array("Permulaan Tahun Polisi","7","8","9","10","11 dan ke atas","% Nilai Dana (berkenaan Akaun Unit Asas dan Akaun Unit Rider)","0.04","0.08","0.12","0.16","0.20");
    
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
    var arrTitle = new Array("Rider(s)","Jumlah Diinsuranskan/Faedah","Tempoh Perlindungan","Hayat - hayat Diinsuranskan","Huraian Faedah");
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
            
            //td.setAttribute('class','textAlignCenter');
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
    var arrTitle = new Array("Rider(s)","Jumlah Diinsuranskan/Faedah","Tempoh Perlindungan","Hayat - hayat Diinsuranskan","Huraian Faedah");
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
            
            //td.setAttribute('class','textAlignCenter');
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
    var riderNo = new Array("0","1","2","3","4","5");
    
    var arrTitle = new Array("Rider(s)","Jumlah Diinsuranskan/Faedah","Tempoh Perlindungan","Hayat - hayat Diinsuranskan","Huraian Faedah");
    var arrADCAR = new Array("Acc Death &Compassionate Allowance Rider","10,000.00","5","Hayat Diinsuranskan","Ketika  Kematian Hayat Diinsuranskan  yang disebabkan oleh kemalangan, Faedah Kematian akibat Kemalangan sejumlah RM10,000.00 akan dibayar. Elaun Ihsan sejumlah RM10,000 akan dibayar bersampingan  dengan Faedah Kematian akibat Kemalangan.");
    var arrADHI = new Array("Acc. Daily Hospitalisation Income","50.00(Harian)","5","Hayat Diinsuranskan","Ketika  Hayat Diinsuranskan  dimasukkan ke hospital yang lulus bagi tempoh minimum 6 jam yang berterusan setiap kemasukan, PendapatanPenghospitalan  Harian akibat Kemalangan sejumlah RM50.00 akan dibayar sehingga maksimum 730 hari setiap kemalangan.");
    var arrE1R = new Array("EverCash 1 Rider","600.00</br>(Annual)","20","Hayat Diinsuranskan","Rider  ini akan memberikan satu Pendapatan Tahunan Terjamin sebanyak RM600.00 bermula dari hujung tahun pertama sehingga Rider ini tamat. Ketika berlaku kematian /TPD (sebelum mencapai umur 65 tahun), 100% daripada baki Pendapatan Tahunan Terjamin akan dibayar. Jika berlaku TPD akibat kemalangan, amaun tambahan yang akan dibayar adalah 300% daripada Pendapatan Tahunan Terjamin yang belum dibayar.");
    var arrER = new Array("EverCash Rider","600</br>(Annual)","20","Hayat Diinsuranskan","Rider  ini akan memberikan satu Pendapatan Tahunan Terjamin sebanyak RM600.00 bermula dari hujung tahun pertama sehingga Rider ini tamat. Ketika berlaku kematian /TPD (sebelum mencapai umur 65 tahun), 100% daripada baki Pendapatan Tahunan Terjamin akan dibayar. Jika berlaku TPD akibat kemalangan, amaun tambahan yang akan dibayar adalah 300% daripada Pendapatan Tahunan Terjamin yang belum dibayar.");
    var arrLR = new Array("LifeShield Rider","20000.00","37","Hayat Diinsuranskan","Ketika  Hayat Diinsuranskan  meninggal dunia atau mengalami TPD (sebelum mencapai umur 65 tahun), Faedah Kematian/ TPD bersamaan denganRM20,000.00  akan dibayar.Faedah  untuk TPD  akan dibayar berdasarkan kepada peruntukan syarikat. Lien Juvenil akan diaplikasikan.");
    var arrAMRR = new Array("Acc. Medical Reimbursement Rider","1,000.00","5","Hayat Diinsuranskan","Ketika  berlaku kemalangan, perbelanjaan perubatan dan pembedahan seperti rawatan pesakit dalam dan rawatan pesakit luar yang ditanggung olehHayat  Diinsuranskan  akan dibayar sehingga RM1,000.00 setiap kemalangan.");
    var arrPAR = new Array("Personal Accident Rider","10,000.00","5","Hayat Diinsuranskan","Ketika  Kematian Hayat Diinsuranskan  yang disebabkan oleh kemalangan, Faedah Kematian akibat Kemalangan sejumlah RM10,000.00 akan dibayar. Ketika Hayat Diinsuranskan  mengalami Hilang Upaya Kekal dan Separa/ Menyeluruh, faedah akan dibayar berdasarkan kapada Jadual Indemniti. Faedah Hilang Upaya Kekal dan Separa/ Menyeluruh yang dibayar akan ditolak daripada Jumlah Diinsuranskan Rider.");
    var arrATPDMLAR = new Array("Acc. TPD Monthly Living Allowance Rider","500.00</br>(Monthly)","5","Hayat Diinsuranskan","Ketika  Hayat Diinsuranskan  mengalami mana-mana kehilangan atau kekurangupayaan akibat kemalangan dalam 365 hari dari kejadian kemalangan; Elaun Saraan Hidup Bulanan sejumlah RM500.00 akan dibayar sehingga maksimum 180 bulan sepanjang hayat Hayat Diinsuranskan." + loadDetailsAR(["-","-","-","-","-","-","-","-","-"],["Hilang Upaya Kekal dan Menyeluruh;","Kehilangan keseluruhan penglihatan pada kedua-dua belah mata yang kekal;","Kehilangan keseluruhan penglihatan pada sebelah mata yang kekal;","Kehilangan keseluruhan daya pertuturan dan pendengaran yang kekal;","Kehilangan atau hilang daya penggunaan dua anggota badan yang kekal;","Kehilangan atau hilang daya penggunaan satu anggota badan yang kekal;","Ketidaksiuman  yang tidak dapat diubati dan kekal; atau","Kelumpuhan seluruh badan yang kekal"]));
    //var tempATPDMLAR = "In the event that the Life Assured suffers any of the following loss or disability as the result of an accident within 365 days from the date ofoccurrence; a Monthly Living Allowance equivalent to RM500.00 will be payable up to maximum of 180 months during the lifetime of the Life Assured: </br>-&nbsp&nbsp Total Permanent Disability;</br>-&nbsp&nbsp permanent total loss of sight of both eyes;</br>-&nbsp&nbsp permanent total loss of sight of one eye;</br>-&nbsp&nbsp permanent total loss of speech and hearing;</br>-&nbsp&nbsp loss of or the permanent loss of use of two limbs;</br>-&nbsp&nbsp loss of or the permanent loss of use of one limb;</br>-&nbsp&nbsp permanent and incurable insanity; or</br>-&nbsp&nbsp permanent total paralysis.";
    
    var arrTPDWPR = new Array("Jumlah  Rider Diinsuranskan  akan dibayar untuk mengurangkan  premium masa hadapan sehingga tarikh tamat tempoh rider setelah pertama kali hayat diinsuranskan mengalami TPD (sebelum mencapai umur 65 tahun)/ OAD (selepas mencapai umur 65 tahun) dalam tempoh diinsuranskan.  Premium adalah terjamin dan atas dasar premium tetap.");
    var arrAWIR = new Array("Acc.Weekly Indemnity","100.00</br>(Weekly)","5","Life Assured","Ketika  Hayat Diinsuranskan  mengalami Hilang Upaya Menyeluruh Sementara akibat Kemalangan, Indemniti Mingguan sejumlah RM100.00 akan dibayar. Ketika Hayat Diinsuranskan  mengalami Hilang Upaya Separa Sementara akibat Kemalangan, Indemniti Mingguan sejumlah RM25.00 akan dibayar. Tempoh maksimum yang akan dibayar untuk Hilang Upaya Menyeluruh Sementara akibat Kemalangan dan Hilang Upaya Separa Sementara akibat Kemalangan ialah sehingga 104 minggu setiap kemalangan.");
    
    
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
    
    var arrPoints = new Array ("strok","Serangan  Jantung","Kegagalan  Buah Pinggang Tahap Akhir","Kanser ","Pembedahan  Pintasan Arteri Koronari ","6.Penyakit  Arteri Koronari Lain Yang Serius",".Angioplasti  Dan Rawatan Pembedahan Lain Untuk Penyakit Arteri Koronari Utama*","Kegagalan  Hati Tahap Akhir ","Hepatitis  Virus Fulminan ","koma","Tumor Otak Benigna "," Kelumpuhan/   Paraplegia","Kebutaan/Hilang Penglihatan Menyeluruh ","Kepekakan/Hilang Pendengaran Menyeluruh","Melecur  Teruk","Penyakit  Paru-Paru Tahap Akhir","Ensefalitis "," Organ /Pemindahan  Organ Utama/Sumsum  Tulang","Hilang Pertuturan","Pembedahan  Otak","Pembedahan  Injap Jantung","Penyakit Membawa Maut","HIV Akibat Transfusi Darah","Meningitis Bakteria","Trauma Kepala Utama","Anemia Aplastik Kronik"," Penyakit Neuron Motor","Penyakit Parkinson","Penyakit Alzheimer/Gangguan Kemerosotan Otak Organik Tidak Boleh Pulih","Distrofi Otot","Pembedahan  Aorta","Sklerosis Berbilang","Hipertensi Arteri Pulmonari Primer","Penyakit Sista Medulari","Kardiomiopathi Teruk","Lupus Eritematosus Sistematik Dengan Lupus Nephritis");
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
            td.innerHTML = "RM10,000.00  akan dibayar apabila Hayat Diinsuranskan  didiagnos mana-mana satu daripada 36 penyakit kritikal yang dilindungi semasa tempoh perlindungan.</br>Selepasbayaran   Jumlah Diinsuranskan  ACIR, Jumlah Asas Diinsuranskan  akan dikurangkan dengan sepatutnya.";
            td.colSpan = "4";
            tr.appendChild(td);
        }
        else if (i == 19)
        {
            
            td.innerHTML = "*Pembayaran  faedah di bawah penyakit ini terhad kepada 10% daripada perlindungan Penyakit Kritikal di bawah pelan ini tertakluk kepada maksimum RM25,000. Faedah ini akan dibayar sekali sahaja dan akan ditolak daripada pelindungan pelan ini, seterusnya akan mengurangkan  jumlah bayaran sekali gus ketika kejadian Penyakit Kritikal.";
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
    
    var arrPoints = new Array ("strok","Serangan  Jantung","Kegagalan  Buah Pinggang Tahap Akhir","Kanser ","Pembedahan  Pintasan Arteri Koronari ","6.Penyakit  Arteri Koronari Lain Yang Serius",".Angioplasti  Dan Rawatan Pembedahan Lain Untuk Penyakit Arteri Koronari Utama*","Kegagalan  Hati Tahap Akhir ","Hepatitis  Virus Fulminan ","koma","Tumor Otak Benigna "," Kelumpuhan/   Paraplegia","Kebutaan/Hilang Penglihatan Menyeluruh ","Kepekakan/Hilang Pendengaran Menyeluruh","Melecur  Teruk","Penyakit  Paru-Paru Tahap Akhir","Ensefalitis "," Organ /Pemindahan  Organ Utama/Sumsum  Tulang","Hilang Pertuturan","Pembedahan  Otak","Pembedahan  Injap Jantung","Penyakit Membawa Maut","HIV Akibat Transfusi Darah","Meningitis Bakteria","Trauma Kepala Utama","Anemia Aplastik Kronik"," Penyakit Neuron Motor","Penyakit Parkinson","Penyakit Alzheimer/Gangguan Kemerosotan Otak Organik Tidak Boleh Pulih","Distrofi Otot","Pembedahan  Aorta","Sklerosis Berbilang","Hipertensi Arteri Pulmonari Primer","Penyakit Sista Medulari","Kardiomiopathi Teruk","Lupus Eritematosus Sistematik Dengan Lupus Nephritis");

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
            td.innerHTML = "Jumlah  Rider Diinsuranskan  akan dibayar untuk mengurangkan  premium masa hadapan sehingga tarikh tamat tempoh rider setelah didiagnosis dengan mana-mana 36 penyakit kritikal yang melindungi hayat diinsuranskan  dalam tempoh diinsuranskan.  Premium adalah terjamin dan atas dasar premium tetap.";
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

//============================================ END 2B. attaching rider List ======================================
function loadSectionTwo (id)
{
    var arrNoTwo = new Array();
    arrNoTwo[0] = "Apakah perlindungan / faedah yang disediakan?";
    arrNoTwo[1] = "A) Pelan Asas";
    arrNoTwo[2] = "Jumlah Diinsuranskan untuk pelan ini adalah RM 45,000.00 dan tempoh perlindungan ialah 37 tahun atau ketika penamatan, yang mana berlaku dahulu.";
    
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
    var arrFund = new Array("Dana","HLA EverGreen 2023","HLA EverGreen 2025","HLA EverGreen 2028","HLA EverGreen 2030");
    var arrFundAlloc = new Array("Peruntukan Dana (%)","0%","0%","0%","0%");
    var arrMGUPAFMA = new Array("Harga  Unit Terjamin Minimum pada Kematangan Dana berkenaan?","Yes","Yes","Yes","Yes");
    
    var arrFund2 = new Array("Dana","HLA EverGreen 2035","HLA Dana Suria","HLA Secure Fund","HLA Cash Fund");
    var arrFundAlloc2 = new Array("Peruntukan Dana (%)","40%","0%","40%","20%");
    var arrMGUPAFMA2 = new Array("Harga  Unit Terjamin Minimum pada Kematangan Dana berkenaan?","Yes","No","No","No");
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
    
    var str ="<tr style='font-weight: bold;'><td rowspan='2'>Pelan / Rider</td><td rowspan='2' style='text-align: center;'>Jenis</td><td rowspan='2' style='text-align: center;'>Hayat-hayat Diinsuranskan</td><td style='text-align: center;'>Premium Awal</td></tr><tr style='font-weight: bold;'><td style='text-align: center;'>Tahunan (RM)</td></tr>";
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
    
    var str = "<tr class='bold'><td>Pelan / Rider</td><td style='text-align: center;'>Jenis</td><td style='text-align: center;'>Hayat-hayat Diinsuranskan</td><td style='text-align: center;'>Premium akan dibayar sehingga hayat yang diinsuranskan berumur</td></tr>";
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

function loadAttachRider()//attach rider for 6B
{
    //var arrRider = getRiderList().slice(0,2)
    var arrRider = arrLoadRider;
    
    //var arrRider = getRiderList();
    //var arrExclusions = new Array(loadAttachRider_CIRDetail());
    var ARheader = "<tr class='bold'><td class='normalTableTD'>Riders</td><td class='normalTableTD'>Pengecualian</td></tr>";
    
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
//============ rider detail for for exclusion =======
function loadAttachRider_ADHIRDetail()// acc medical reimbursement rider, a
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    
    var arrDetails = new Array();
    arrDetails[0] = "Penerbangan atau mengambil bahagian dalam sebarang aktiviti penerbangan melainkan ketika menerbang dalam pesawat sebagai penumpang yang membayar  tambang dan bukan sebagai anak kapal terbang dan bukan untuk tujuan untuk melakukan sebarang perdagangan atau operasi teknikal dalam atau atas pesawat.";
    arrDetails[1] = "Kecederaan diri yang disengajakan,  membunuh diri atau cuba untuk membunuh diri, pembunuhan atau serangan yang diprovokasi atau bawah pengaruh sebarang dadah/narkotik/alkohol.";
    arrDetails[2] = "Terlibat dalam atau mengambil bahagian dalam sukan professional atau semi-profesional.";
    arrDetails[3] = "Terlibat dalam sebarang perlumbaan (selain daripada perlumbaan yang menggunakan  kaki), pendakian gunung atau batuan yang menggunakan tali atau pemandu jalan, sukan musim sejuk, kegiatan bawah air, ski air, bola sepak, polo, pemburuan, pertandingan lompat kuda, penerokaan gua, penerokaan gua bawah tanah,	peninjuan atau bergusti.";
    arrDetails[4] = "Peperangan, pencerobohan,  tindakan musuh asing, permusuhan atau operasi semacam peperangan (sama ada perang diisytiharkan atau tidak), perang saudara, kegiatan ketenteraan atau rampasan kuasa.";
    arrDetails[5] = "Terlibat langsung dalam mogokan, rusuhan, pemberontakan, revolusi, kegemparan awam atau penderhakaan.";
    arrDetails[6] = "Bertugas dalam Pasukan Bersenjata (sama ada secara sukarela atau sebaliknya).";
    arrDetails[7] = "Sebarang kesakitan atau penyakit yang disebabkan atau dijangkiti oleh atau menerusi sebarang kaedah yang berpunca daripada virus, parasit, bakteria atau sebarang mikro-organisma termasuk virus, parasit, bakteria atau mikro-organisma yang dikenali dan/ atau berpunca daripada gigitan serangga atau transmisi melalui seks.";
    arrDetails[8] = "Sebarang rawatan atau pembedahan (kecuali rawatan yang diperlukan untuk merawati kecederaan yang dilindungi bawah Polisi ini). ";
    arrDetails[9] = "Melakukan atau cuba melakukan sebarang kegiatan yang menyalahi undang-undang.";
    arrDetails[10] = "Sebarang penyakit, kesakitan atau kecacatan congenital.";
    arrDetails[11] = "Sebarang kecederaan akibat kemalangan yang disebabkan kecacatan mental";
    arrDetails[12] = "Human Immune-deficiency Virus (HIV) dan/atau sebarang penyakit yang berkaitan dengan HIV, termasuk AIDS dan/atau sebarang perkembangan mutan atau variasi-variasi darinya.";
    arrDetails[13] = "Kehamilan, kelahiran anak, keguguran atau sebarang komplikasi yang berkaitan dengan yang sama.";
    arrDetails[14] = "Sebarang rawatan gigi melainkan rawatan ini diperlukan untuk merawati kecederaan yang dilindungi bawah Polisi ini.";
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider ini tidak melindungi kejadian berikut:</td></tr>";
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
function loadAttachRider_ACIRDetail()// Accelerated critical illness rider details
{
    
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)");
    var arrDetailsPoints = new Array("Angioplasti dan rawatan untuk penyakit arteri koronori","Kanser","Penyakit arteri koronori yang memerlukan pembedahan","Serangan jantung","Lain-lain penyakit arteri koronori yang tenat");
    
    var arrDetails = new Array();
    arrDetails[0] = "Satu episod arteri koronari atau penyakit jantung ischaemic yang berlaku sebelum Tarikh Penerbitan, Tarikh Pindaan Efektif atau pada sebarang TarikhPengembalian  Semula, yang mana terkemudian;";
    arrDetails[1] = "Diagnosis penyakit kritikal selain daripada yang dispesifikasikan  bawah item (iii) di bawah dalam masa 30 hari dari Tarikh Penerbitan, Tarikh Pindaan Efektif atau  pada sebarang Tarikh Pengembalian  Semula, yang mana terkemudian;";
    arrDetails[2] = "Diagnosis penyakit kritikal seperti yang dispesifikasikan  di bawah dalam masa 60 hari dari Tarikh Penerbitan, Tarikh Pindaan Efektif atau pada sebarangTarikh  Pengembalian  Semula, yang mana terkemudian: </br>" + loadDetailsAR(arrbulletAlphabet,arrDetailsPoints);
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    var tdHead = "<tr class='bold'><td colspan='2'>Peruntukan penyakit kritikal tidak meliputi peristiwa-peristiwa berikut:</td></tr>";
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

function loadAttachRider_CIRDetail()//critical illness wp rider details
{
    
    
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)");
    var arrDetailsPoints = new Array("Angioplasti dan rawatan untuk penyakit arteri koronori","Kanser","Penyakit arteri koronori yang memerlukan pembedahan","Serangan jantung","Lain-lain penyakit arteri koronori yang tenat");
    
    var arrDetails = new Array();
    arrDetails[0] = "Kejadian arteri koronari atau penyakit jantung iskemia yang berlaku sebelum Tarikh Penyertaan atau mana-mana tarikh pengembalian  semula, mengikut mana-mana yang terkemudian";
    arrDetails[1] = "Diagnosis penyakit kritikal yang pertama kali dapat dilihat dengan jelas dalam tempoh 30 hari dari Tarikh Penyertaan atau mana-mana tarikh pengembalian  semula, mengikut mana-mana yang terkemudian";
    arrDetails[2] = "Diagnosis penyakit kritikal seperti yang ditetapkan di bawah dalam tempoh 60 hari dari Tarikh Penyertaan atau mana-mana tarikh pengembalian  semula, mengikut mana-mana yang terkemudian: </br>" + loadDetailsAR(arrbulletAlphabet,arrDetailsPoints);
    arrDetails[3] = "Selain kejadian pertama kali penyakit kritikal. Pengecualian kepada fasal ini ialah penyakit arteri koronari dan AIDS.";
    arrDetails[4] = "Hayat diinsuranskan  meninggal dunia dalam tempoh 28 hari selepas tarikh didiagnosis dengan mana-mana penyakit kritikal.";
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider  ini tidak melindungi kejadian berikut:</td></tr>";
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
function loadAttachRider_ADCARDetail() // acc.death & compensionate allowance rider // acc. daily hospitalisation income rider // acc TPD monthly living allowance Rider
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    
    var arrDetails = new Array();
    arrDetails[0] = "Penerbangan atau mengambil bahagian dalam sebarang aktiviti penerbangan melainkan ketika menerbang dalam pesawat sebagai penumpang yang membayar  tambang dan bukan sebagai anak kapal terbang dan bukan untuk tujuan untuk melakukan sebarang perdagangan atau operasi teknikal dalam atau atas pesawat.";
    arrDetails[1] = "Kecederaan diri yang disengajakan,  membunuh diri atau cuba untuk membunuh diri, pembunuhan atau serangan yang diprovokasi atau bawah pengaruh sebarang     dadah/narkotik/alkohol.";
    arrDetails[2] = "Terlibat dalam atau mengambil bahagian dalam sukan professional atau semi-profesional.";
    arrDetails[3] = "Terlibat dalam sebarang perlumbaan (selain daripada perlumbaan yang menggunakan  kaki), pendakian gunung atau batuan yang menggunakan  tali atau pemandu jalan, sukan musim sejuk, kegiatan bawah air, ski air, bola sepak, polo, pemburuan, pertandingan lompat kuda, penerokaan gua, penerokaan gua bawah tanah, peninjuan atau bergusti.";
    arrDetails[4] = "Peperangan, pencerobohan, tindakan musuh asing, permusuhan atau operasi semacam peperangan (sama ada perang diisytiharkan atau tidak), perang saudara, kegiatan ketenteraan atau rampasan kuasa.";
    arrDetails[5] = "Terlibat langsung dalam mogokan, rusuhan, pemberontakan, revolusi, kegemparan awam atau penderhakaan.";
    arrDetails[6] = "Bertugas dalam Pasukan Bersenjata (sama ada secara sukarela atau sebaliknya).";
    arrDetails[7] = "Sebarang kesakitan atau penyakit yang disebabkan atau dijangkiti oleh atau menerusi sebarang kaedah yang berpunca daripada virus, parasit, bakteria atau   sebarang mikro-organisma termasuk virus, parasit, bakteria atau mikro-organisma yang dikenali dan/ atau berpunca daripada gigitan serangga atau transmisi melalui seks.";
    arrDetails[8] = "Committing or attempting to commit any unlawful act;";
    arrDetails[9] = "Melakukan atau cuba melakukan sebarang kegiatan yang menyalahi undang-undang. ";
    arrDetails[10] = "Sebarang kecederaan akibat kemalangan yang disebabkan kecacatan mental.";
    arrDetails[11] = "Keguguran atau sebarang komplikasi yang berkaitan dengan yang sama.";
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider ini tidak melindungi kejadian berikut:</td></tr>";
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

function loadAttachRider_EC1RDetail()//for evercash 1 rider and ever cash rider,  and life shield rider
{
    var arrDetailsPoints = new Array("daripada sebarang kecederaan anggota badan yang disengajakan ketika siuman atau tidak siuman;","daripada sebarang gangguan saraf atau penyakit mental;","daripada penerbangan di dalam pesawat udara (kecuali sebagai anak kapal, atau sebagai penumpang biasa yang membayar tambang, dalam mana-mana penerbangan komersil berjadual tetap); atau","daripada apa jua perkara ketika berkhidmat dalam angkatan bersenjata, polis dan angkatan separa tentera disebabkan oleh perang yang diisytiharkan atau tidak  diisytiharkan, rusuhan atau kekecohan awam.");
    
    var arrDetails = new Array();
    arrDetails[0] = "Kematian hayat diinsuranskan  kerana membunuh diri dalam tempoh 12 bulan pertama dari Tarikh Penerbitan, Tarikh Pindaan Efektif atau pada sebarangTarikh  Pengembalian  Semula, mengikut mana-mana yang terkemudian";
    arrDetails[1] = "Hilang Upaya Menyeluruh dan Kekal yang berpunca secara langsung atau tidak langsung:</br>" + loadDetailsAR(["-","-","-","-","-"],arrDetailsPoints);
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider ini tidak melindungi kejadian berikut:</td></tr>";
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
    var arrDetailsPoints = new Array("daripada apa-apa kecederaan anggota badan yang disengajakan ketika siuman atau tidak siuman;","daripada apa-apa gangguan saraf atau penyakit mental;","daripada membuat penerbangan di dalam pesawat udara (kecuali sebagai anak kapal, atau sebagai penumpang biasa yang membayar tambang, dalam mana-mana penerbangan komersil berjadual tetap); atau","daripada apa jua perkara ketika berkhidmat dalam angkatan bersenjata, polis dan angkatan separa tentera disebabkan oleh perang yang diisytiharkan atau tidak diisytiharkan, rusuhan atau kekecohan awam.");
    
    var arrDetails = new Array();
    arrDetails[0] = "Hilang Upaya Menyeluruh dan Kekal atau Ketidakupayaan  Masa Tua yang berpunca secara langsung atau tidak langsung: </br>" + loadDetailsAR(arrbulletAlphabet,arrDetailsPoints);
    
    
    var arrbulletI = new Array("i","ii","iii","iv","iv","v","vi","vii","viii","x");
    
    
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider ini tidak melindungi kejadian berikut:</td></tr>";
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
function loadAttachRider_AWIR() // acc weekly indemnity rider
{
    var arrbulletAlphabet = new Array("(a)","(b)","(c)","(d)","(e)","(f)","(g)","(h)","(i)","(j)","(k)","(l)","(m)","(n)","(o)","(p)","(q)","(r)","(s)","(t)","(u)","(v)","(w)","(x)","(y)","(z)");
    
    var arrDetails = new Array();
    arrDetails[0] = "Penerbangan atau mengambil bahagian dalam sebarang aktiviti penerbangan melainkan ketika menerbang dalam pesawat sebagai penumpang yang membayar  tambang dan bukan sebagai anak kapal terbang dan bukan untuk tujuan untuk melakukan sebarang perdagangan atau operasi teknikal dalam atau atas pesawat.";
    arrDetails[1] = "Kecederaan diri yang disengajakan,  membunuh diri atau cuba untuk membunuh diri, pembunuhan atau serangan yang diprovokasi atau bawah pengaruh sebarang     dadah/narkotik/alkohol.";
    arrDetails[2] = "Terlibat dalam atau mengambil bahagian dalam sukan professional atau semi-profesional.";
    arrDetails[3] = "Terlibat dalam sebarang perlumbaan (selain daripada perlumbaan yang menggunakan  kaki), pendakian gunung atau batuan yang menggunakan  tali atau pemandu jalan, sukan musim sejuk, kegiatan bawah air, ski air, bola sepak, polo, pemburuan, pertandingan lompat kuda, penerokaan gua, penerokaan gua bawah tanah, peninjuan atau bergusti.";
    arrDetails[4] = "Peperangan, pencerobohan, tindakan musuh asing, permusuhan atau operasi semacam peperangan (sama ada perang diisytiharkan atau tidak), perang saudara, kegiatan ketenteraan atau rampasan kuasa.";
    arrDetails[5] = "Terlibat langsung dalam mogokan, rusuhan, pemberontakan, revolusi, kegemparan awam atau penderhakaan.";
    arrDetails[6] = "Bertugas dalam Pasukan Bersenjata (sama ada secara sukarela atau sebaliknya).";
    arrDetails[7] = "Sebarang kesakitan atau penyakit yang disebabkan atau dijangkiti oleh atau menerusi sebarang kaedah yang berpunca daripada virus, parasit, bakteria atau   sebarang mikro-organisma termasuk virus, parasit, bakteria atau mikro-organisma yang dikenali dan/ atau berpunca daripada gigitan serangga atau transmisi melalui seks.";
    arrDetails[8] = "Committing or attempting to commit any unlawful act;";
    arrDetails[9] = "Melakukan atau cuba melakukan sebarang kegiatan yang menyalahi undang-undang. ";
    arrDetails[10] = "Sebarang kecederaan akibat kemalangan yang disebabkan kecacatan mental.";
    arrDetails[11] = "Keguguran atau sebarang komplikasi yang berkaitan dengan yang sama.";
    arrDetails[12] = "Sebarang rawatan gigi melainkan rawatan ini diperlukan untuk merawati kecederaan yang dilindungi bawah Polisi ini.";
    
    var tdHead = "<tr class='bold'><td colspan='2'>Rider ini tidak melindungi kejadian berikut:</td></tr>";
    
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
    var arrTitle = new Array("Rider","Hak Pembatalan");
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
        
        appendPage('page9','PDS/pds2HTML/PDSTwo_BM_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR1";
        var page9ContentATemp = document.getElementById('page9ContentA');
        page9ContentATemp.id = "page9ContentATemp";
        
        
        var page9ContentBTemp = document.getElementById('page9ContentB');
        page9ContentBTemp.id = "page9ContentBTemp";
        page9ContentBTemp.style.display = "none";
        
        appendPage('page9b','PDS/pds2HTML/PDSTwo_BM_Page9.html');
        document.getElementById('7B-AR').id = "7B-AR2";
        document.getElementById("page9ContentA").style.display = "none";
    }
    else{
        appendPage('page9','PDS/pds2HTML/PDSTwo_BM_Page9.html');
        
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
    appendPage('page5','PDS/pds2HTML/PDSTwo_BM_Page5.html');
    isNeedSplit = "YES";
    appendPage('page5b','PDS/pds2HTML/PDSTwo_BM_Page5b.html');
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
    plan.prodType = "Pelan Asas";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "1,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Critical Illness Waiver of Premium Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "2,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Acc. Weekly Indemnity Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "3,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "TPD Waiver of Premium rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "4,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. TPD Monthly Living Allowance Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "5,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Personal Accident Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "6,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. Medical Reimbursement rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "7,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "MedGLOBAL IV Plus";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "8,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "LifeShield Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "9,000,00";
    arrPlan.push(plan);
    
    var plan = new productPlan();
    plan.prodName = "Acc. Daily Hospitalisation Income Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "10,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Acc. Death & Compassionate Allowance Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "11,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "HLA Major Medi";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
    plan.prodInitPremAnn = "12,000,00";
    arrPlan.push(plan);
    
    
    var plan = new productPlan();
    plan.prodName = "Critical Illness Waiver of Premium Rider";
    plan.prodType = "Rider";
    plan.prodInsuredLives = "Hayat Diinsuranskan";
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
    //rd.riderDetailTitle = "Peruntukan  penyakit kritikal tidak meliputi peristiwa-peristiwa berikut:";
    rd.arrDetails = loadAttachRider_ACIRDetail();//add this one..tempprary use cir
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Critical Illness Wp Rider";
    rd.riderCode = "CIR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_CIRDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Death & Compasionate Allowance Rider";
    rd.riderCode = "ADCAR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Daily Hospitalisation Income Rider";
    rd.riderCode = "ADHIR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_ADHIRDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash 1 Rider";
    rd.riderCode = "EC1R";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash Rider";
    rd.riderCode = "ECR";
    //rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "LifeShield Rider";
    rd.riderCode = "LSR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_EC1RDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Medical Reimbursement Rider";
    rd.riderCode = "AMRR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_ADHIRDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Personal Accident Rider";
    rd.riderCode = "PAR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. TPD Monthly Living Allowance Rider";
    rd.riderCode = "ATPDMLAR";
    //rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_ADCARDetail();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "TPD Waiver of Premium Rider";
    rd.riderCode = "TPDWPR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_TPDWPR();
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Weekly Indemnity Rider";
    rd.riderCode = "AWIR";
    // rd.riderDetailTitle = "Rider  ini tidak melindungi kejadian berikut:";
    rd.arrDetails = loadAttachRider_AWIR();
    arrRider.push(rd);
    
    return arrRider;
}

function getRiderList_7B()
{
    var arrRider = new Array();
    var rd = new Rider();
    rd.riderName = "Accelerated Critical Illness";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    
    var rd = new Rider();
    rd.riderName = "Critical Illness Waiver of Premium Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Death & Compassionate Allowance Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Daily Hospitalisation Income Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash 1 Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "EverCash Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "LifeShield Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Medical Reimbursement Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Personal Accident Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. TPD Monthly Living Allowance Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "TPD Waiver of Premium Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.";
    arrRider.push(rd);
    
    var rd = new Rider();
    rd.riderName = "Acc. Weekly Indemnity Rider";
    rd.riderDesc = "Jika  anda menamatkan rider ini sebelum tempoh matang, penamatan perlindungan akan berkuat kuasa pada ulang tahun bulan berikutnya selepas pemberitahuan  penamatan diterima. Nilai dana Akaun Unit Rider akan dibayar setelah Polisi ini diserahkan.";
    arrRider.push(rd);
    
    return arrRider;
    
    
}
var load2BRider;
function needSplitPageForRider_2B()
{
    
    var arrRiderForTwoB = new Array("ACIR","CIR","EC1R");//riders to display in 2B
    
    var a = 0;
    for (x in arrRiderForTwoB)
    {
        if (arrRiderForTwoB[a] == "ACIR")
        {
            currPage = 'page4Content-1';
            load2BRider = "ACIR";
            appendPage('page4-1','PDS/pds2HTML/PDSTwo_BM_Page4.html');
            
        }
        else if (arrRiderForTwoB[a]=="CIR")
        {
            currPage = 'page4Content-2';
            load2BRider = "CIR";
            appendPage('page4-2','PDS/pds2HTML/PDSTwo_BM_Page4.html');
            
        }
        else if (arrRiderForTwoB[a] == "EC1R")
        {
            currPage = 'page4Content-3';
            load2BRider = "OTHERS";
            appendPage('page4-3','PDS/pds2HTML/PDSTwo_BM_Page4.html');
            break;
            
        }
        a=a+1;
    }
    
}var PAGE_ALLOCATED = 8;//change this to have different page

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
        appendPage('page8-'+ a,'PDS/pds2HTML/PDSTwo_BM_Page8.html');
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
        var strPageEndNote = "<span><i>Nota:  Senarai ini tidak lengkap. Sila rujuk kontrak polisi untuk mendapatkan terma dan syarat di bawah polisi ini.</i></span>";
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
    
}//=====object ======
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
var splitCount = 5;
var arrLoadRider = new Array();
