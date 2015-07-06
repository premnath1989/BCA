//
//  PRPage3.m
//  PDF
//
//  Created by Travel Chu on 3/18/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage3.h"
#import "PRHtmlHandler.h"
#import "TBXML+NSDictionary.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation PRPage3
+ (NSString *)prPage3WithDictionary:(NSDictionary *)dicttionary {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    NSString *page3 = [NSString
                       stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page3" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *coTitle=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getTitleByCode:dicttionary[@"ContigentInfo"][@"COTitle"]];
    NSString *part2FullName=[NSString stringWithFormat:@"%@",dicttionary[@"ContigentInfo"][@"COName"]];
    page3=[page3 stringByReplacingString:@"##part2FullName##" withString:part2FullName];
    NSString *fullICStr=dicttionary[@"ContigentInfo"][@"CONewIC"][@"CONewICNo"];
    NSString *ic1=@"";
    NSString *ic2=@"";
    NSString *ic3=@"";
    if (fullICStr.length==12) {
        ic1=[fullICStr substringToIndex:6];
        fullICStr=[fullICStr substringFromIndex:6];
        ic2=[fullICStr substringToIndex:2];
        ic3=[fullICStr substringFromIndex:2];
    }
    page3=[page3 stringByReplacingString:@"##newIC.1##" withString:ic1];
    page3=[page3 stringByReplacingString:@"##newIC.2##" withString:ic2];
    page3=[page3 stringByReplacingString:@"##newIC.3##" withString:ic3];
    NSString *coOtherIDType2=dicttionary[@"ContigentInfo"][@"iCOOtherID"][@"iCOOtherIDType"];
    if ([coOtherIDType2 isEqualToString:@"OLDIC"] || [coOtherIDType2 isEqualToString:@"PP"]) {
        NSString *coOtherID2=dicttionary[@"ContigentInfo"][@"iCOOtherID"][@"iCOOtherIDNo"];
        page3=[page3 stringByReplacingString:@"##coOtherID##" withString:coOtherID2];
    }
    
    NSString *birth=dicttionary[@"ContigentInfo"][@"CODOB"];
    NSArray *bithArray=[birth componentsSeparatedByString:@"/"];
    if (bithArray.count==3) {
        page3=[page3 stringByReplacingString:@"##part2Bith.1##" withString:bithArray[0]];
        page3=[page3 stringByReplacingString:@"##part2Bith.2##" withString:bithArray[1]];
        page3=[page3 stringByReplacingString:@"##part2Bith.3##" withString:bithArray[2]];
    }
    if (dicttionary[@"ContigentInfo"][@"CORelationship"]) {
        NSString *coRelation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getRelationByCode:dicttionary[@"ContigentInfo"][@"CORelationship"]];
        page3=[page3 stringByReplacingString:@"##part2relationship##" withString:coRelation];
    }
    
    for (NSDictionary *dict in dicttionary[@"ContigentInfo"][@"COContacts"][@"COContact"]) {
        NSString *COPhoneNo;
        NSString *COMobileNo;
        NSString *CONationality;
        NSString *CONameOfEmployer;
        NSString *COOccupation;
        NSString *COExactNatureOfWork;

        NSString *COAddress1;
        NSString *COAddress2;
        NSString *COAddress3;
        NSString *COTown;
        NSString *COState;
        NSString *COPostcode;
        NSString *COCountry;
        
        NSString *COCRAddress1;
        NSString *COCRAddress2;
        NSString *COCRAddress3;
        NSString *COCRTown;
        NSString *COCRState;
        NSString *COCRPostcode;
        NSString *COCRCountry;
        
        FMResultSet *getConOwner = [database executeQuery:@"select * from eProposal where eProposalNo = ? ",dicttionary[@"AssuredInfo"][@"eProposalNo"]];
        while ([getConOwner next]) {
            COPhoneNo=[getConOwner objectForColumnName:@"CoPhoneNo"];
            COMobileNo=[getConOwner objectForColumnName:@"CoMobileNo"];
            CONationality=[getConOwner objectForColumnName:@"CONationality"];
            CONameOfEmployer=[getConOwner objectForColumnName:@"CONameOfEmployer"];
            COOccupation=[getConOwner objectForColumnName:@"COOccupation"];
            COExactNatureOfWork=[getConOwner objectForColumnName:@"COExactNatureOfWork"];
            COAddress1=[getConOwner objectForColumnName:@"COAddress1"];
            COAddress2=[getConOwner objectForColumnName:@"COAddress2"];
            COAddress3=[getConOwner objectForColumnName:@"COAddress3"];
            COTown=[getConOwner objectForColumnName:@"COTown"];
            COState=[getConOwner objectForColumnName:@"COState"];
            COPostcode=[getConOwner objectForColumnName:@"COPostcode"];
            COCountry=[getConOwner objectForColumnName:@"COCountry"];
            COCRAddress1=[getConOwner objectForColumnName:@"COCRAddress1"];
            COCRAddress2=[getConOwner objectForColumnName:@"COCRAddress2"];
            COCRAddress3=[getConOwner objectForColumnName:@"COCRAddress3"];
            COCRTown=[getConOwner objectForColumnName:@"COCRTown"];
            COCRState=[getConOwner objectForColumnName:@"COCRState"];
            COCRPostcode=[getConOwner objectForColumnName:@"COCRPostcode"];
            COCRCountry=[getConOwner objectForColumnName:@"COCRCountry"];
        }
        
        if ((NSNull *) CONationality == [NSNull null])
        {
            CONationality=@"";
        }
        
        if ([CONationality isEqualToString:@"MY"]) {
            page3=[page3 stringByReplacingString:@"##part2nationality.malaysian##" withString:@"◼︎"];
        } else if ([CONationality isEqualToString:@""])
        {
            page3=[page3 stringByReplacingString:@"##part2nationality.others##" withString:@"◻︎"];
        }else
        {
            page3=[page3 stringByReplacingString:@"##part2nationality.others##" withString:@"◼︎"];
            page3=[page3 stringByReplacingString:@"##part2nationality.others2##" withString:[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getNationalityByCode:CONationality]];
        }
        
        page3=[page3 stringByReplacingString:@"##part2employer##" withString:CONameOfEmployer];
        if ((NSNull *) COOccupation == [NSNull null])
        {
            page3=[page3 stringByReplacingString:@"##part2occupation##" withString:@""];
        }else
        {
            COOccupation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:COOccupation];
            page3=[page3 stringByReplacingString:@"##part2occupation##" withString:COOccupation];
        }
        
        page3=[page3 stringByReplacingString:@"##part2exactduty##" withString:COExactNatureOfWork];

        // Residential Address
        NSString *coState2=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:COState];
        NSString *COaddr5=[NSString stringWithFormat:@"%@ %@ %@ %@",COAddress1,COAddress2,COAddress3,COTown];
        page3=[page3 stringByReplacingString:@"##part2.5.Addr##" withString:COaddr5];
        page3=[page3 stringByReplacingString:@"##part2.5.state##" withString:coState2];
        if (COPostcode) {
            page3=[page3 stringByReplacingString:@"##part2.5.Postcode##" withString:COPostcode];
        }
        if (COCountry) {
            NSString *country1=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:COCountry];
            page3=[page3 stringByReplacingString:@"##part2.5.country##" withString:country1];
        }
        
        // Conresspondence Address
        if ([dicttionary[@"ContigentInfo"][@"COSameAddressPO"] isEqualToString:@"False"]) {
            page3=[page3 stringByReplacingString:@"##part2.5.N##" withString:@"◼︎"];
            
            NSString *coCRState2=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:COCRState];
            NSString *COCRaddr5=[NSString stringWithFormat:@"%@ %@ %@ %@",COCRAddress1,COCRAddress2,COCRAddress3,COCRTown];
            page3=[page3 stringByReplacingString:@"##part2.5.CRAddr##" withString:COCRaddr5];
            page3=[page3 stringByReplacingString:@"##part2.5.CRstate##" withString:coCRState2];
            if (COCRPostcode) {
                page3=[page3 stringByReplacingString:@"##part2.5.CRPostcode##" withString:COCRPostcode];
            }
            if (COCRCountry) {
                NSString *country2=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:COCRCountry];
                page3=[page3 stringByReplacingString:@"##part2.5.CRcountry##" withString:country2];
            }
            
        }
        else if ([dicttionary[@"ContigentInfo"][@"COSameAddressPO"] isEqualToString:@"True"]) {
            page3=[page3 stringByReplacingString:@"##part2.5.Y##" withString:@"◼︎"];
            NSString *COCRaddr5=[NSString stringWithFormat:@"%@",@"Same address as Policy Owner"];
            page3=[page3 stringByReplacingString:@"##part2.5.CRAddr##" withString:COCRaddr5];            
        }
        else {
            page3=[page3 stringByReplacingString:@"##part2.5.Y##" withString:@"◻︎"];
        }
        
        
        
        if (dict[@"ContactNo"] && dict[@"Type"] && [dict[@"Type"] isEqualToString:@"Residence"]) {
            NSString *num=COPhoneNo;
            NSString *s1;
            NSString *s2;
            NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
            if (contactNoAry.count > 1) {
                s1 = [contactNoAry objectAtIndex:0];
                s2 = [contactNoAry objectAtIndex:1];
            }
            else {
                s1 = [contactNoAry objectAtIndex:0];
            }
            //                NSString *s1=[num substringToIndex:2];
            //                if (![s1 isEqualToString:@"03"]) {
            //                    s1=[num substringToIndex:3];
            //                }
            page3=[page3 stringByReplacingString:@"##part2.5.tel.1##" withString:s1];
            page3=[page3 stringByReplacingString:@"##part2.5.tel.2##" withString:s2];
        }else if (dict[@"ContactNo"] && dict[@"Type"] && [dict[@"Type"] isEqualToString:@"Mobile"]) {
            NSString *num=COMobileNo;
            NSString *s1;
            NSString *s2;
            NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
            if (contactNoAry.count > 1) {
                s1 = [contactNoAry objectAtIndex:0];
                s2 = [contactNoAry objectAtIndex:1];
            }
            else {
                s1 = [contactNoAry objectAtIndex:0];
            }
            
            page3=[page3 stringByReplacingString:@"##part2.5.mob.1##" withString:s1];
            page3=[page3 stringByReplacingString:@"##part2.5.mob.2##" withString:s2];
        }else if (dict[@"ContactNo"] && dict[@"Type"] && [dict[@"Type"] isEqualToString:@"Email"]) {
            page3=[page3 stringByReplacingString:@"##part2.5.email##" withString:dict[@"ContactNo"]];
        }
    }
    
    // PART 3
    
    NSDictionary *siDict=[TBXML dictionaryWithXMLData:[PRHtmlHandler sharedPRHtmlHandler].siXMLata error:nil];
    NSDictionary *basicPlan=siDict[@"eApps"][@"SIDetails"][@"BasicPlan"];
    NSString *PlanDesc=[NSString stringWithFormat:@"%@",[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getPlanByCode:basicPlan[@"PlanCode"]]];
    
//    if([basicPlan[@"PlanCode"] isEqualToString:@"HLAWP"])
//    {
//         page3=[page3 stringByReplacingString:@"##basicPlan##" withString:@"HLA Wealth Plan"];
//    }
//    else
//    {
         page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];
//    }
    
//    page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];
    page3=[page3 stringByReplacingString:@"##term##" withString:basicPlan[@"CoverageTerm"]];
    page3=[page3 stringByReplacingString:@"##sumassured##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"SumAssured"]]]];
    page3=[page3 stringByReplacingString:@"##modalPrem##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"PaymentAmount"]]]];
	
	
	
    
    NSDictionary *party=siDict[@"eApps"][@"SIDetails"][@"Parties"];
    NSString *SINO=siDict[@"eApps"][@"SIDetails"][@"SINo"];
    NSDictionary *laDict=nil;
    NSDictionary *laDictPO=nil;
    if ([party[@"Party"] isKindOfClass:[NSDictionary class]]) {
        if ([party[@"Party"][@"PTypeCode"] isEqualToString:@"LA"] && [party[@"Party"][@"Seq"] isEqualToString:@"1"]) {
            laDict=party[@"Party"];
        }else{
            laDictPO=party[@"Party"];
        }
    }
    else if([party[@"Party"] isKindOfClass:[NSArray class]]){
        for (NSDictionary *dict in party[@"Party"]) {
            if ([dict[@"PTypeCode"] isEqualToString:@"LA"] && [dict[@"Seq"] isEqualToString:@"1"]) {
                laDict=dict;
            }else{
                laDictPO=dict;
            }
        }
    }
    NSArray *riderArray=nil;
    NSArray *riderArrayPO=nil;
    if (laDict) {
        if ([laDict[@"Riders"][@"Rider"] isKindOfClass:[NSDictionary class]]) {
            riderArray=[NSArray arrayWithObject:laDict[@"Riders"][@"Rider"]];
        }else if ([laDict[@"Riders"][@"Rider"] isKindOfClass:[NSArray class]]){
            riderArray=laDict[@"Riders"][@"Rider"];
        }
    }
    if (laDictPO) {
        if ([laDictPO[@"Riders"][@"Rider"] isKindOfClass:[NSDictionary class]]) {
            riderArrayPO=[NSArray arrayWithObject:laDictPO[@"Riders"][@"Rider"]];
        }else if ([laDictPO[@"Riders"][@"Rider"] isKindOfClass:[NSArray class]]){
            riderArrayPO=laDictPO[@"Riders"][@"Rider"];
        }
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"PlanCode" ascending:YES];
    riderArray=[riderArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"PlanCode" ascending:YES];
    riderArrayPO=[riderArrayPO sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort2]];
    
    
    
    if (riderArray || riderArrayPO) {
        NSString *rider=@"<div style=\"position:absolute;left:25.75px;top:355px;\" class=\"cls_007\">\n\
        <table style=\"width:536.8px;border:1px solid black;border-collapse:collapse;font-size: 1.1em;\">\n\
        <tr><td colspan=\"8\" style=\"border:0px black;\"><span class=\"cls_012\">PART 3. : DETAILS OF LIFE ASSURANCE APPLIED FOR </span><span class=\"cls_016\">/</span><span class=\"cls_020\"> </span><span class=\"cls_007\">BAHAGIAN 3. : BUTIR-BUTIR INSURANS HAYAT YANG DIPOHON</span></td></tr>";
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:456.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td  colspan=\"2\" style=\"border:1px solid black;;border-collapse:collapse\"><span class=\"cls_012\">Basic Plan</span><br/><span class=\"cls_007\">Pelan Asas</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_012\">Term (years)</span><br/><span class=\"cls_007\">Tempoh (tahun)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_012\">Sum Assured (RM)</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan (RM)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><span class=\"cls_012\">Modal Premium (RM)</span><br/><span class=\"cls_007\">Premium Modal (RM)</span></td>\
               </tr>\
               <tr>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_003\">##basicPlan##</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><div align=\"center\"><span class=\"cls_003\">##term##</span></div></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><div align=\"right\"><span class=\"cls_003\">##sumassured##</span></div></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><div align=\"right\"><span class=\"cls_003\">##modalPrem##</span></div></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:459.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td colspan=\"6\" style=\"border:1px solid black;\" ><span class=\"cls_012\">Regular Top-Up Option (Basic Unit Account) / </span><br/><span class=\"cls_007\">Opsyen Tambahan Dana Berkala (Unit Akaun Asas)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><div align=\"right\"><span class=\"cls_003\">0.00</span><br/></div></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:459.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td colspan=\"4\" style=\"border:1px solid black;\" width=264px><span class=\"cls_012\">Rider(s) for Life Assured</span><br/><span class=\"cls_007\">Rider untuk Hayat Diinsuranskan</span></td>\
               <td colspan=\"4\" style=\"border:1px solid black;\"><span class=\"cls_012\">Rider(s) for Policy Owner</span><br/><span class=\"cls_007\">Rider untuk Pemunya Polisi</span></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:573.20px;\" class=\"cls_007\">\n\
               <tr>\
               <td style=\"border:1px solid black;\" width=\"92.7px\"><span class=\"cls_012\">Rider Name</span><br/><span class=\"cls_007\">Nama Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"48.5px\"><span class=\"cls_012\">Rider Term</span><br/><span class=\"cls_007\">Tempoh Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"76.5px\"><span class=\"cls_012\">Rider Sum Assured</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan</span></td>\
               <td style=\"border:1px solid black;\" width=\"41px\"><span class=\"cls_012\">Premium</span><br/></td>\
               <td style=\"border:1px solid black;\" width=\"91px\"><span class=\"cls_012\">Rider Name</span><br/><span class=\"cls_007\">Nama Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"51px\"><span class=\"cls_012\">Rider Term</span><br/><span class=\"cls_007\">Tempoh Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"75px\"><span class=\"cls_012\">Rider Sum Assured</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan</span></td>\
               <td style=\"border:1px solid black;\"><span class=\"cls_012\">Premium</span><br/></td>\
               </tr>"];
        NSArray *dataArray=riderArray;
        BOOL poFlag=NO;
        if (riderArrayPO.count>riderArray.count) {
            dataArray=riderArrayPO;
            poFlag=YES;
        }
        
        
        for (int i=0; i<dataArray.count; i++) {
            NSString *data1=@"";
            NSString *data2=@"";
            NSString *data3=@"";
            NSString *data4=@"";
            NSString *data5=@"";
            NSString *data6=@"";
            NSString *data7=@"";
            NSString *data8=@"";
            NSString *WOPAmount;
            NSString *CoverageUnit=@"";
            if (poFlag) {
                CoverageUnit = riderArrayPO[i][@"CoverageUnit"];
                data5 = riderArrayPO[i][@"PlanCode"];
                
                FMResultSet *getRiderDesc = [database executeQuery:@"select * from Trad_Rider_Details where RiderCode = ? and SINO = ?",data5,SINO];
                while ([getRiderDesc next]) {
                    data5=[getRiderDesc objectForColumnName:@"RiderDesc"];
                    
                    if ([data5 isEqualToString:@"Wealth Booster Rider (30 year term)"])
                    {
                        data5 = @"Wealth Booster Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth Booster-d10 Rider (30 year term)"])
                    {
                        data5 = @"Wealth Booster-d10 Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth Booster-i6 Rider (30 year term)"])
                    {
                        data5 = @"Wealth Booster-i6 Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth Booster Rider (50 year term)"])
                    {
                        data5 = @"Wealth Booster Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth Protector Rider (30 year term)"])
                    {
                        data5 = @"Wealth Protector Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth Protector Rider (50 year term)"])
                    {
                        data5 = @"Wealth Protector Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth TPD Protector Rider (30 year term)"])
                    {
                        data5 = @"Wealth TPD Protector Rider";
                    }
                    
                    else if ([data5 isEqualToString:@"Wealth TPD Protector Rider (50 year term)"])
                    {
                        data5 = @"Wealth TPD Protector Rider";
                    }


                }
                
                if (!CoverageUnit==nil) {
                    data5 = [NSString stringWithFormat:@"%@ (%@ Unit(s))",data5,CoverageUnit];
                }
                data6 = riderArrayPO[i][@"CoverageTerm"];
                data7 = [fmt stringFromNumber:[fmt numberFromString:riderArrayPO[i][@"SumAssured"]]];
                WOPAmount = riderArrayPO[i][@"WOPAmount"];
                if (![WOPAmount isEqualToString:@"0.00"]) {
                    data7 = [fmt stringFromNumber:[fmt numberFromString:WOPAmount]];
                }
                data8 = [fmt stringFromNumber:[fmt numberFromString:riderArrayPO[i][@"PaymentAmount"]]];
                
                if (i<riderArray.count) {
                    CoverageUnit = riderArray[i][@"CoverageUnit"];
                    data1 = riderArray[i][@"PlanCode"];
                    
                    FMResultSet *getRiderDesc = [database executeQuery:@"select * from Trad_Rider_Details where RiderCode = ? and SINO = ?",data1,SINO];
                    while ([getRiderDesc next]) {
                        data1=[getRiderDesc objectForColumnName:@"RiderDesc"];
                        
                        if ([data1 isEqualToString:@"Wealth Booster Rider (30 year term)"])
                        {
                            data1 = @"Wealth Booster Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth Booster-d10 Rider (30 year term)"])
                        {
                            data1 = @"Wealth Booster-d10 Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth Booster-i6 Rider (30 year term)"])
                        {
                            data1 = @"Wealth Booster-i6 Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth Booster Rider (50 year term)"])
                        {
                            data1 = @"Wealth Booster Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth Protector Rider (30 year term)"])
                        {
                            data1 = @"Wealth Protector Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth Protector Rider (50 year term)"])
                        {
                            data1 = @"Wealth Protector Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth TPD Protector Rider (30 year term)"])
                        {
                            data1 = @"Wealth TPD Protector Rider";
                        }
                        
                        else if ([data1 isEqualToString:@"Wealth TPD Protector Rider (50 year term)"])
                        {
                            data1 = @"Wealth TPD Protector Rider";
                        }
                        
                       

                    }
                    
                    if (!CoverageUnit==nil) {
                        data1 = [NSString stringWithFormat:@"%@ (%@ Unit(s))",data1,CoverageUnit];
                    }
                    data2 = riderArray[i][@"CoverageTerm"];
                    data3 = [fmt stringFromNumber:[fmt numberFromString:riderArray[i][@"SumAssured"]]];
                    WOPAmount = riderArray[i][@"WOPAmount"];
                    if (![WOPAmount isEqualToString:@"0.00"]) {
                        data3 = [fmt stringFromNumber:[fmt numberFromString:WOPAmount]];
                    }
                    data4 = [fmt stringFromNumber:[fmt numberFromString:riderArray[i][@"PaymentAmount"]]];
                }
            }else{
                CoverageUnit = riderArray[i][@"CoverageUnit"];
                data1 = riderArray[i][@"PlanCode"];
                FMResultSet *getRiderDesc = [database executeQuery:@"select * from Trad_Rider_Details where RiderCode = ? and SINO = ?",data1,SINO];
                while ([getRiderDesc next])
                {
                    data1=[getRiderDesc objectForColumnName:@"RiderDesc"];
                    
                    if ([data1 isEqualToString:@"Wealth Booster Rider (30 year term)"])
                    {
                        data1 = @"Wealth Booster Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth Booster-d10 Rider (30 year term)"])
                    {
                        data1 = @"Wealth Booster-d10 Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth Booster-i6 Rider (30 year term)"])
                    {
                        data1 = @"Wealth Booster-i6 Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth Booster Rider (50 year term)"])
                    {
                        data1 = @"Wealth Booster Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth Protector Rider (30 year term)"])
                    {
                        data1 = @"Wealth Protector Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth Protector Rider (50 year term)"])
                    {
                        data1 = @"Wealth Protector Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth TPD Protector Rider (30 year term)"])
                    {
                        data1 = @"Wealth TPD Protector Rider";
                    }
                    
                    else if ([data1 isEqualToString:@"Wealth TPD Protector Rider (50 year term)"])
                    {
                        data1 = @"Wealth TPD Protector Rider";
                    }
                    
                }
                
                if (!CoverageUnit==nil) {
                    data1 = [NSString stringWithFormat:@"%@ (%@ Unit(s))",data1,CoverageUnit];
                }
                data2 = riderArray[i][@"CoverageTerm"];
                data3 = [fmt stringFromNumber:[fmt numberFromString:riderArray[i][@"SumAssured"]]];
                WOPAmount=riderArray[i][@"WOPAmount"];
                if (![WOPAmount isEqualToString:@"0.00"]) {
                    data3 = [fmt stringFromNumber:[fmt numberFromString:WOPAmount]];
                }
                data4 = [fmt stringFromNumber:[fmt numberFromString:riderArray[i][@"PaymentAmount"]]];
                if (i<riderArrayPO.count) {
                    CoverageUnit = riderArrayPO[i][@"CoverageUnit"];
                    data5 = riderArrayPO[i][@"PlanCode"];
                    FMResultSet *getRiderDesc = [database executeQuery:@"select * from Trad_Rider_Details where RiderCode = ? and SINO = ?",data5,SINO];
                    while ([getRiderDesc next]) {
                        data5=[getRiderDesc objectForColumnName:@"RiderDesc"];
                        
                        if ([data5 isEqualToString:@"Wealth Booster Rider (30 year term)"])
                        {
                            data5 = @"Wealth Booster Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth Booster-d10 Rider (30 year term)"])
                        {
                            data5 = @"Wealth Booster-d10 Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth Booster-i6 Rider (30 year term)"])
                        {
                            data5 = @"Wealth Booster-i6 Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth Booster Rider (50 year term)"])
                        {
                            data5 = @"Wealth Booster Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth Protector Rider (30 year term)"])
                        {
                            data5 = @"Wealth Protector Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth Protector Rider (50 year term)"])
                        {
                            data5 = @"Wealth Protector Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth TPD Protector Rider (30 year term)"])
                        {
                            data5 = @"Wealth TPD Protector Rider";
                        }
                        
                        else if ([data5 isEqualToString:@"Wealth TPD Protector Rider (50 year term)"])
                        {
                            data5 = @"Wealth TPD Protector Rider";
                        }
                        
                    

                    }
                    
                    if (!CoverageUnit==nil) {
                        data5 = [NSString stringWithFormat:@"%@ (%@ Unit(s))",data5,CoverageUnit];
                    }
                    data6 = riderArrayPO[i][@"CoverageTerm"];
                    data7 = [fmt stringFromNumber:[fmt numberFromString:riderArrayPO[i][@"SumAssured"]]];
                    WOPAmount=riderArrayPO[i][@"WOPAmount"];
                    if (![WOPAmount isEqualToString:@"0.00"]) {
                        data7 = [fmt stringFromNumber:[fmt numberFromString:WOPAmount]];
                    }
                    data8 = [fmt stringFromNumber:[fmt numberFromString:riderArrayPO[i][@"PaymentAmount"]]];
                }
            }
            
            rider=[rider stringByAppendingFormat:@"<tr>\
                   <td style=\"border:1px solid black;\" width=\"92.7px\"><span class=\"cls_003\">%@</span></td>\
                   <td style=\"border:1px solid black;\" width=\"48.5px\"><div align=\"center\"><span class=\"cls_003\">%@</span></div></td>\
                   <td style=\"border:1px solid black;\" width=\"76.5px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                   <td style=\"border:1px solid black;\" width=\"41px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                   <td style=\"border:1px solid black;\" width=\"91px\"><span class=\"cls_003\">%@</span></td>\
                   <td style=\"border:1px solid black;\" width=\"51px\"><div align=\"center\"><span class=\"cls_003\">%@</span></div></td>\
                   <td style=\"border:1px solid black;\" width=\"75px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                   <td style=\"border:1px solid black;\" ><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                   </tr>",data1,data2,data3,data4,data5,data6,data7,data8];
        }
		
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		NSString *totalValueGST = [prefs stringForKey:@"totalGstValue"];
		
		NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
		NSString *totalValueOfPayable = [prefs1 stringForKey:@"totalAllValue"];


		NSString *payAmmount =[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"PaymentAmount"]]];
		
		NSString *ttlModalPremium = dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
//
//		
//		
//		double valueRMPAnnual = [payAmmount doubleValue];
//		double valeuGSTAnnual = [ttlModalPremium doubleValue];
//		double netPay = valueRMPAnnual + valeuGSTAnnual;
//		NSString *GST_Annual_Net= [NSString stringWithFormat:@"%.2lf", netPay];

		
        NSString *totalModalPremium =dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
		//dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
        NSString *serviceTax = @"";
        for (NSDictionary *dict in dicttionary[@"AssuredInfo"][@"Party"]) {
            if ([dict[@"PTypeCode"] isEqualToString:@"PO"] && [dict[@"iLAOtherID"][@"iLAOtherIDType"] isEqualToString:@"CR"]) {
                NSString *totalModalPremium = dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
                double totalModalPremiumCal = [[totalModalPremium stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
                double totalModalPremiumCal1 = totalModalPremiumCal/1.06;
                //                serviceTax = [NSString stringWithFormat:@"%.2f", (totalModalPremiumCal-totalModalPremiumCal1)];
//                serviceTax = [fmt stringFromNumber:[fmt numberFromString:[NSString stringWithFormat:@"%.2f", (totalModalPremiumCal-totalModalPremiumCal1)]]];
                
                
            }
        }
		
		
		
        totalModalPremium = [fmt stringFromNumber:[fmt numberFromString:totalModalPremium]];
		
		NSString *topup=[NSString stringWithFormat:@"<tr>\
                         <td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Regular Top-Up Option (Rider Unit Account) /&nbsp;</span><span class=\"cls_007\">Opsyen Tambahan Dana Berkala (Unit Akaun Rider)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</span></td></tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Service Tax (if applicable) /&nbsp;</span><span class=\"cls_007\">Cukai Perkhidmatan (sekiranya terpakai)</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;%@</span></span></td></tr>\
						 <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Total GST amount (RM) /&nbsp;</span><span class=\"cls_007\">Jumlah amaun GST (RM)</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</span></td></tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Total Relevant Amount Payable* /&nbsp;</span><span class=\"cls_007\">Jumlah Amaun Relevan Perlu Dibayar*</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp; %@</span></td>\
                         </tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">* Note: Inclusive of any applicable tax and the tax rate is subject to change by the authorities from time to time.If the tax rate changes,the Total Relevant &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Amount Payable shall be adjusted accordingly.<BR></span><span class=\"cls_007\">* Nota: Termasuk apa-apa cukai yang berkaitan dan kadar cukai adalah tertakluk kepada perubahan oleh pihak berkuasa dari semasa ke semasa.Sekiranya kadar &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cukai berubah, Jumlah Amaun Relevan Perlu Dibayar akan diselaraskan dengan sewajarnya.</span></td>\
                         </tr>",serviceTax,totalValueGST,totalValueOfPayable];
		
        rider=[rider stringByAppendingString:topup];
        rider=[rider stringByAppendingString:@"</table></div>"];
        
        page3=[page3 stringByReplacingString:@"##PART3_Rider##" withString:rider];
        
        NSDictionary *basicPlan=siDict[@"eApps"][@"SIDetails"][@"BasicPlan"];
        NSString *PlanDesc=[NSString stringWithFormat:@"%@",[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getPlanByCode:basicPlan[@"PlanCode"]]];
        
//        if([basicPlan[@"PlanCode"] isEqualToString:@"HLAWP"])
//        {
//            page3=[page3 stringByReplacingString:@"##basicPlan##" withString:@"HLA Wealth Plan"];
//        }
//        else
//        {
            page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];
//        }
        
        //    page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];
        page3=[page3 stringByReplacingString:@"##term##" withString:basicPlan[@"CoverageTerm"]];
        
        NSLog(@"apaPlanIni %@",[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc]);
        page3=[page3 stringByReplacingString:@"##sumassured##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"SumAssured"]]]];
        page3=[page3 stringByReplacingString:@"##modalPrem##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"PaymentAmount"]]]];
    }else // if there is no rider
    {
        NSString *rider=@"<div style=\"position:absolute;left:25.75px;top:355px;\" class=\"cls_007\">\n\
        <table style=\"width:536.8px;border:1px solid black;border-collapse:collapse;font-size: 1.1em;\">\n\
        <tr><td colspan=\"8\" style=\"border:0px solid black;\"><span class=\"cls_012\">PART 3 . : DETAILS OF LIFE ASSURANCE APPLIED FOR </span><span class=\"cls_016\">/</span><span class=\"cls_020\"> </span><span class=\"cls_007\">BAHAGIAN 3 . : BUTIR-BUTIR INSURANS HAYAT YANG DIPOHON</span></td></tr>";
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:459.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_012\">Basic Plan</span><br/><span class=\"cls_007\">Pelan Asas</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_012\">Term (years)</span><br/><span class=\"cls_007\">Tempoh (tahun)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_012\">Sum Assured (RM)</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan (RM)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><span class=\"cls_012\">Modal Premium (RM)</span><br/><span class=\"cls_007\">Premium Modal (RM)</span></td>\
               </tr>\
               <tr>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><span class=\"cls_003\">##basicPlan##</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><div align=\"center\"><span class=\"cls_003\">##term##</span></div></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\"><div align=\"right\"><span class=\"cls_003\">##sumassured##</span></div></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><div align=\"right\"><span class=\"cls_003\">##modalPrem##</span></div></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:459.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td colspan=\"6\" style=\"border:1px solid black;\" ><span class=\"cls_012\">Regular Top-Up Option (Basic Unit Account) / </span><br/><span class=\"cls_007\">Opsyen Tambahan Dana Berkala (Unit Akaun Asas)</span></td>\
               <td colspan=\"2\" style=\"border:1px solid black;\" width=137px><div align=\"right\"><span class=\"cls_003\">0.00</span><br/></div></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:459.25px;\" class=\"cls_007\">\n\
               <tr>\
               <td colspan=\"4\" style=\"border:1px solid black;\" width=264px><span class=\"cls_012\">Rider(s) for Life Assured</span><br/><span class=\"cls_007\">Rider untuk Hayat Diinsuranskan</span></td>\
               <td colspan=\"4\" style=\"border:1px solid black;\"><span class=\"cls_012\">Rider(s) for Policy Owner</span><br/><span class=\"cls_007\">Rider untuk Pemunya Polisi</span></td>\
               </tr>"];
        
        rider=[rider stringByAppendingString:@"<div style=\"position:absolute;left:25.75px;top:573.20px;\" class=\"cls_007\">\n\
               <tr>\
               <td style=\"border:1px solid black;\" width=\"92.7px\"><span class=\"cls_012\">Rider Name</span><br/><span class=\"cls_007\">Nama Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"48.5px\"><span class=\"cls_012\">Rider Term</span><br/><span class=\"cls_007\">Tempoh Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"76.5px\"><span class=\"cls_012\">Rider Sum Assured</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan</span></td>\
               <td style=\"border:1px solid black;\" width=\"41px\"><span class=\"cls_012\">Premium</span><br/></td>\
               <td style=\"border:1px solid black;\" width=\"91px\"><span class=\"cls_012\">Rider Name</span><br/><span class=\"cls_007\">Nama Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"51px\"><span class=\"cls_012\">Rider Term</span><br/><span class=\"cls_007\">Tempoh Rider</span></td>\
               <td style=\"border:1px solid black;\" width=\"75px\"><span class=\"cls_012\">Rider Sum Assured</span><br/><span class=\"cls_007\">Jumlah Diinsuranskan</span></td>\
               <td style=\"border:1px solid black;\" ><span class=\"cls_012\">Premium</span><br/></td>\
               </tr>"];
        
        // to include 3 empty row if there is no rider
        rider=[rider stringByAppendingFormat:@"<tr>\
               <td style=\"border:1px solid black;\" width=\"92.7px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"48.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"76.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"41px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"91px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"51px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"75px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\">&nbsp;</td>\
               </tr>"];
        rider=[rider stringByAppendingFormat:@"<tr>\
               <td style=\"border:1px solid black;\" width=\"92.7px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"48.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"76.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"41px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"91px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"51px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"75px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\">&nbsp;</td>\
               </tr>"];
        rider=[rider stringByAppendingFormat:@"<tr>\
               <td style=\"border:1px solid black;\" width=\"92.7px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"48.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"76.5px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"41px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"91px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"51px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\" width=\"75px\">&nbsp;</td>\
               <td style=\"border:1px solid black;\">&nbsp;</td>\
               </tr>"];
        
        
        
        //rider=[rider stringByReplacingString:@"**ridertop**" withString:[NSString stringWithFormat:@"%0.2f",355.00]];
        //        NSString *topup=[NSString stringWithFormat:@"<div style=\"position:absolute;left:25.75px;top:573.20px;\" class=\"cls_007\">\n<table style=\"font-size: 1.1em;width:536.8px;border:1px solid black;border-collapse:collapse;\">\n"];
		
		
		
        NSString *totalModalPremium = dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
        NSString *serviceTax = @"";
        for (NSDictionary *dict in dicttionary[@"AssuredInfo"][@"Party"]) {
            if ([dict[@"PTypeCode"] isEqualToString:@"PO"] && [dict[@"iLAOtherID"][@"iLAOtherIDType"] isEqualToString:@"CR"]) {
                NSString *totalModalPremium = dicttionary[@"PaymentInfo"][@"TotalModalPremium"];
                double totalModalPremiumCal = [[totalModalPremium stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
                double totalModalPremiumCal1 = totalModalPremiumCal/1.06;
                //     serviceTax = [NSString stringWithFormat:@"%.2f", (totalModalPremiumCal-totalModalPremiumCal1)];
//                serviceTax = [fmt stringFromNumber:[fmt numberFromString:[NSString stringWithFormat:@"%.2f", (totalModalPremiumCal-totalModalPremiumCal1)]]];
            }
        }
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		NSString *totalValueGST = [prefs stringForKey:@"totalGstValue"];
		
		NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
		NSString *totalValueOfPayable = [prefs1 stringForKey:@"totalAllValue"];
		
        totalModalPremium = [fmt stringFromNumber:[fmt numberFromString:totalModalPremium]];
        
        NSString *topup=[NSString stringWithFormat:@"<tr>\
                         <td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Regular Top-Up Option (Rider Unit Account) /&nbsp;</span><span class=\"cls_007\">Opsyen Tambahan Dana Berkala (Unit Akaun Rider)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</span></td></tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Service Tax (if applicable) /&nbsp;</span><span class=\"cls_007\">Cukai Perkhidmatan (sekiranya terpakai)</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;%@</span></span></td></tr>\
						 <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Total GST amount (RM) /&nbsp;</span><span class=\"cls_007\">Jumlah amaun GST (RM)</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</span></td></tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">Total Relevant Amount Payable* /&nbsp;</span><span class=\"cls_007\">Jumlah Amaun Relevan Perlu Dibayar*</span><span class=\"cls_003\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp; %@</span></td>\
                         </tr>\
                         <tr><td colspan=\"8\" style=\"border:1px solid black;\"><span class=\"cls_012\">* Note: Inclusive of any applicable tax and the tax rate is subject to change by the authorities from time to time.If the tax rate changes,the Total Relevant &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Amount Payable shall be adjusted accordingly.<BR></span><span class=\"cls_007\">* Nota: Termasuk apa-apa cukai yang berkaitan dan kadar cukai adalah tertakluk kepada perubahan oleh pihak berkuasa dari semasa ke semasa.Sekiranya kadar &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cukai berubah, Jumlah Amaun Relevan Perlu Dibayar akan diselaraskan dengan sewajarnya.</span></td>\
                         </tr>",serviceTax,totalValueGST,totalValueOfPayable];
        
        
        rider=[rider stringByAppendingString:topup];
        rider=[rider stringByAppendingString:@"</table></div>"];
        
        page3=[page3 stringByReplacingString:@"##PART3_Rider##" withString:rider];
        
        NSDictionary *basicPlan=siDict[@"eApps"][@"SIDetails"][@"BasicPlan"];
        NSString *PlanDesc=[NSString stringWithFormat:@"%@",[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getPlanByCode:basicPlan[@"PlanCode"]]];
//        if([basicPlan[@"PlanCode"] isEqualToString:@"HLAWP"])
//        {
//            page3=[page3 stringByReplacingString:@"##basicPlan##" withString:@"HLA Wealth Plan"];
//        }
//        else
//        {
           page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];
//        }
        
        //    page3=[page3 stringByReplacingString:@"##basicPlan##" withString:PlanDesc];

        page3=[page3 stringByReplacingString:@"##term##" withString:basicPlan[@"CoverageTerm"]];
        page3=[page3 stringByReplacingString:@"##sumassured##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"SumAssured"]]]];
        page3=[page3 stringByReplacingString:@"##modalPrem##" withString:[fmt stringFromNumber:[fmt numberFromString:basicPlan[@"PaymentAmount"]]]];
        
    }
    
    
    page3=[page3 stringByReplacingString:@"##part2FullName##" withString:@""];
    page3=[page3 stringByReplacingString:@"##newIC.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##newIC.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##newIC.3##" withString:@""];
    page3=[page3 stringByReplacingString:@"##coOtherID##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2Bith.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2Bith.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2Bith.3##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2relationship##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2nationality.malaysian##" withString:@"◻︎"];
    page3=[page3 stringByReplacingString:@"##part2nationality.others##" withString:@"◻︎"];
    page3=[page3 stringByReplacingString:@"##part2nationality.others2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2employer##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2occupation##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2exactduty##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.Y##" withString:@"◻︎"];
    page3=[page3 stringByReplacingString:@"##part2.5.N##" withString:@"◻︎"];
    
    page3=[page3 stringByReplacingString:@"##part2.5.Addr##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.state##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.Postcode##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.country##" withString:@""];
    
    page3=[page3 stringByReplacingString:@"##part2.5.CRAddr##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.CRstate##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.CRPostcode##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.CRcountry##" withString:@""];
    
    page3=[page3 stringByReplacingString:@"##ContactNoP.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##ContactNoP.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##ContactNoO.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##ContactNoO.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##ContactNoM.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##ContactNoM.2##" withString:@""];
    
    page3=[page3 stringByReplacingString:@"##part2.5.mob.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.mob.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.tel.1##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.tel.2##" withString:@""];
    page3=[page3 stringByReplacingString:@"##part2.5.email##" withString:@""];
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page3 = [[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page3];
    return page3;
}
@end
