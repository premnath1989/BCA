//
//  PRPage11.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage11.h"
#import "PRHtmlHandler.h"

@implementation PRPage11
+(NSString*)prPage11WithDictionary:(NSDictionary*)dicttionary{
    NSString *page11=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page11" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    
    page11 = [page11 stringByReplacingString:@"##cardAccountNo##" withString:dicttionary[@"CreditCardInfo"][@"CardMemberAccountNo"]];
    page11 = [page11 stringByReplacingString:@"##expireDate##" withString:dicttionary[@"CreditCardInfo"][@"CardExpiredDate"]];
    NSDictionary *testCard=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getBankByCode:dicttionary[@"CreditCardInfo"][@"CreditCardBank"]];
    page11 = [page11 stringByReplacingString:@"##issuedBy##" withString:testCard];
    page11 = [page11 stringByReplacingString:@"##cardmemberName##" withString:dicttionary[@"CreditCardInfo"][@"CardMemberName"]];
    page11 = [page11 stringByReplacingString:@"##cardmemberIC##" withString:dicttionary[@"CreditCardInfo"][@"CardMemberNewICNo"]];
    page11 = [page11 stringByReplacingString:@"##contactNo##" withString:dicttionary[@"CreditCardInfo"][@"CardMemberContactNo"]];
    NSDictionary *cardRelationship=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getRelationByCode:dicttionary[@"CreditCardInfo"][@"CardMemberRelationship"]];
    page11 = [page11 stringByReplacingString:@"##relationship##" withString:cardRelationship];
    page11 = [page11 stringByReplacingString:@"##firsttimePayment##" withString:dicttionary[@"PaymentInfo"][@"FirstTimePayment"]];
    
    NSString *paymentMode = dicttionary[@"PaymentInfo"][@"PaymentMode"];
    if ([paymentMode isEqualToString:@"12"]) {
        page11 = [page11 stringByReplacingString:@"##paymentMode.annual##"
                                    withString:@"◼︎"];}
    else if ([paymentMode isEqualToString:@"06"]){
        page11 = [page11 stringByReplacingString:@"##paymentMode.semiannual##"
                                    withString:@"◼︎"];}
    else if ([paymentMode isEqualToString:@"03"]){
        page11 = [page11 stringByReplacingString:@"##paymentMode.quarterly##"
                                    withString:@"◼︎"];}
    else if ([paymentMode isEqualToString:@"01"]){
        page11 = [page11 stringByReplacingString:@"##paymentMode.monthly##"
                                    withString:@"◼︎"];}
    
    NSString *paymentMethod = dicttionary[@"PaymentInfo"][@"PaymentMethod"];
    NSString *firstTimePayment = dicttionary[@"PaymentInfo"][@"FirstTimePayment"];
    // If First Time Payment = Cash and Recurring Payment = CCSI, then E-Proposal Form should map as “Credit Card Standing Instruction” in Credit Card Details & Source of Payment = Standing Instruction.
    if ([paymentMethod isEqualToString:@"05"] && [firstTimePayment isEqualToString:@"03"]) {
        page11 = [page11 stringByReplacingString:@"##paymentMethod.SI##"
                                    withString:@"◼︎"];
        page11 = [page11 stringByReplacingString:@"##standingInstruction##"
                                    withString:@"◼︎"];}
    
    // If First Time Payment = Credit Card and Recurring Payment = Cash, then E-Proposal Form should map as “Credit Card One Time Payment” in Credit Card Details & Source of Payment = Cash/Cheque.
    if ([paymentMethod isEqualToString:@"03"] && [firstTimePayment isEqualToString:@"05"]) {
        page11 = [page11 stringByReplacingString:@"##paymentMethod.cash##"
                                    withString:@"◼︎"];
        page11 = [page11 stringByReplacingString:@"##oneTimePayment##"
                                    withString:@"◼︎"];}
    
    // If First Time Payment = Credit Card and Recurring Payment = CCSI, then E-Proposal Form should map as “Credit Card One Time Payment & Credit Card Standing Instruction” in Credit Card Details & Source of Payment = Standing Instruction.
    if ([paymentMethod isEqualToString:@"05"] && [firstTimePayment isEqualToString:@"05"]) {
        page11 = [page11 stringByReplacingString:@"##paymentMethod.SI##"
                                    withString:@"◼︎"];
        page11 = [page11 stringByReplacingString:@"##oneTimePayment##"
                                    withString:@"◼︎"];
        page11 = [page11 stringByReplacingString:@"##standingInstruction##"
                                    withString:@"◼︎"];}
    
    // If First Time Payment = Cash and Recurring Payment = Cash, then the Credit Card details will leave as blank & Source of Payment = Cash/Cheque.
    if ([paymentMethod isEqualToString:@"03"] && [firstTimePayment isEqualToString:@"03"]) {
        page11 = [page11 stringByReplacingString:@"##paymentMethod.cash##"
                                    withString:@"◼︎"];}
    
    
    NSString *debitUpon = dicttionary[@"PaymentInfo"][@"PaymentFinalAcceptance"];
    if ([debitUpon isEqualToString:@"Yes"]) {
        page11 = [page11 stringByReplacingString:@"##debit.upon.acceptance##"
                                    withString:@"◼︎"];}
    else if ([debitUpon isEqualToString:@"No"]){
        page11 = [page11 stringByReplacingString:@"##debit.upon.submission##"
                                    withString:@"◼︎"];
    }
    
    NSArray *array1=nil;
    if ([dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"] isKindOfClass:[NSDictionary class]]) {
        array1=[NSArray arrayWithObject:dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"]];
    }else if ([dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"] isKindOfClass:[NSArray class]]){
        array1=dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"];
    }
    if (array1) {
        for (NSDictionary *dict in array1) {
            NSString *optionType = dict[@"OptionType"];
            if ([optionType isEqualToString:@"SUR_PAY_01"]) {
                //                NSString *str=[NSString stringWithFormat:@"##percent%@##",dict[@"ID"]];
                NSString *str=[NSString stringWithFormat:@"##percent1##"];
                page11=[page11 stringByReplacingString:str withString:dict[@"Percentage"]];
            }else{
                NSString *str=[NSString stringWithFormat:@"##percent2##"];
                page11=[page11 stringByReplacingString:str withString:dict[@"Percentage"]];
            }
        }
    }

    
    
    
    page11 = [page11 stringByReplacingString:@"##totalmodalPremium##"
                                withString:dicttionary[@"PaymentInfo"][
                                                                       @"TotalModalPremium"]];
    
    NSArray *array = nil;
    NSArray *array2 = nil;
    if ([dicttionary[@"ExistingPolInfo"][@"ExistingPol"]
         isKindOfClass:[NSDictionary class]]) {
        array = [NSArray arrayWithObject:dicttionary[@"ExistingPolInfo"][@"ExistingPol"]];
        //array2 = [NSArray arrayWithObject:dicttionary[@"ExistingPolInfo"][@"ExistingPol"][@"ExistingPolDetails"]];
        
    } else if ([dicttionary[@"ExistingPolInfo"][@"ExistingPol"]
                isKindOfClass:[NSArray class]]) {
        array = dicttionary[@"ExistingPolInfo"][@"ExistingPol"];
        //array2 = [NSArray arrayWithObject:dicttionary[@"ExistingPolInfo"][@"ExistingPol"][@"ExistingPolDetails"]];
    }
    //    if (array) {
    NSString *part4Table =
    @"<div style=\"position:absolute;left:26.75px;top:**part4top**px;\" class=\"cls_007\">\n\
        <table style=\"width:536.8px;border:1px solid black;border-collapse:collapse;font-size: 1.1em;\" cellpadding=\"1\" cellspacing=\"0\">\n\
    <tr><td colspan=\"7\" style=\"border:1px solid black;\"><span class=\"cls_012\">PART 4. : EXISTING LIFE POLICIES AND/OR LIFE POLICIES BEING APPLIED FOR </span><span class=\"cls_007\">/</span><span class=\"cls_022\"> </span><span class=\"cls_007\"><BR>BAHAGIAN 4. : POLISI INSURANS HAYAT SEDIA ADA DAN/ATAU YANG SEDANG DIPOHON</span></td></tr>";
    
    part4Table = [part4Table
                  stringByAppendingString:
                  @"<tr><td colspan=\"7\"  style=\"border:1px solid black;\"><table style=\"width:536.8px;border:0px solid black;;border-collapse:collapse;font-size: 1.1em;\">\n\
                  <tr><td width=5px><div align=\"top\"><span class=\"cls_012\">1.<BR><BR><BR><BR></span></div></td>\
                  <td width=450px><span class=\"cls_012\"><div align=\"justify\" style=\"width:450px\">Do you have any life, personal accident, hospitalisation and surgical, critical illness or any other types of policies/riders with us or any other insurance companies? (Please indicate the name of Life Assured covered under the insurance)</span>\
                  <span class=\"cls_007\">/ Adakah anda mempunyai sebarang insurans hayat, kemalangan peribadi, hospitalisasi dan pembedahan, penyakit kritikal atau sebarang jenis polisi/rider bersama kami atau syarikat insurans yang lain? (Sila nyatakan nama Hayat Diinsuranskan di bawah insurans tersebut)<BR></span></div>\
                  </td>\
                  <td width=50px><span class=\"cls_015\">##extPolInfo.1##</span><span class=\"cls_012\"> Yes</span><span class=\"cls_015\">&nbsp;&nbsp;##extPolInfo.2##</span><span class=\"cls_003\"> No</span>\
                  <br/>\
                  <span class=\"cls_007\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ya&nbsp;&nbsp;&nbsp;&nbsp;Tidak</span></td>\
                  </tr>\
                  <tr><td width=5px><div align=\"top\"><span class=\"cls_012\">2.<BR><BR><BR><BR><BR><BR></span></div></td>\
                  <td width=450px><span class=\"cls_012\"><div align=\"justify\" style=\"width:450px\">Have you in the past three (3) months applied for any life, personal accident, hospitalisation and surgical, critical illness or any other types of policies/riders with us or any other insurance companies, for which the application(s) is/are currently still pending underwriting, approval or insurance? (Please indicate the name of Life Assured covered under the insurance)</span>\
                  <span class=\"cls_007\">/ Pernahkan anda, di dalam tiga (3) bulan yang lepas, memohon untuk sebarang insurans hayat, kemalangan peribadi, hospitalisasi dan pembedahan, penyakit kritikal atau sebarang jenis polisi/rider bersama kami atau syarikat insurans yang lain, yang mana permohonan tersebut masih lagi belum selesai diunderait, diluluskan atau masih belum dikeluarkan? (Sila nyatakan nama Hayat Diinsuranskan di bawah insurans tersebut)<BR></span></div>\
                  </td>\
                  <td width=50px><span class=\"cls_015\">##extPolInfo.1a##</span><span class=\"cls_012\"> Yes</span><span class=\"cls_015\">&nbsp;&nbsp;##extPolInfo.2a##</span><span class=\"cls_003\"> No</span>\
                  <br/>\
                  <span class=\"cls_007\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ya&nbsp;&nbsp;&nbsp;&nbsp;Tidak</span></td>\
                  </tr>\
                  <tr><td width=5px><div align=\"top\"><span class=\"cls_003\"></span></div></td>\
                  <td width=450px><span class=\"cls_012\"><div align=\"justify\" style=\"width:450px\">If your answer is “YES” to any of the above, please fill up details as listed below</span>\
                  <span class=\"cls_007\">/ Jika jawapan anda adalah “YA” pada mana-mana yang di atas, sila lengkapkan butiran sepertimana yang di bawah:</span></div>\
                  </td>\
                  <td width=50px></td>\
                  </tr>\
                  </table></td></tr>"];
    
    part4Table = [part4Table
                  stringByAppendingString:
                  @"<tr>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" rowspan=\"2\";width=74px>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" rowspan=\"2\";width=74px><div align=\"center\"><span class=\"cls_012\">Company</span><br/><span class=\"cls_007\">Nama Syarikat Insurans</span></div></td>\
                  <td colspan=\"4\" style=\"border:1px solid black;border-collapse:collapse;\"><div align=\"center\"><span class=\"cls_012\">Sum Assured</span><span class=\"cls_007\"> / Jumiah Diinsuranskan</span></div></td>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" rowspan=\"2\" width=74px><div align=\"center\"><span class=\"cls_012\">Date Issued</span><br/><span class=\"cls_007\">Tarikh Keluaran</span></div></td>\
                  </tr>\
                  <tr>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" width=74px><div align=\"center\"><span class=\"cls_012\">Life / Term</span><br/><span class=\"cls_007\">Hayat / Sementara</span></div></td>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" width=74px><div align=\"center\"><span class=\"cls_012\">Accident</span><br/><span class=\"cls_007\">Kemalangan</span></div></td>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" width=74px><div align=\"center\"><span class=\"cls_012\">Daily Hosp. Income</span><br/><span class=\"cls_007\">Pendapatan Hosp. Harian</span></div></td>\
                  <td colspan=\"1\" style=\"border:1px solid black;border-collapse:collapse;\" width=74px><div align=\"center\"><span class=\"cls_012\">Critical Illness</span><br/><span class=\"cls_007\">Penyakit Kritikal</span></div></td>\
                  </tr>"];
    
 
    BOOL LA = NO;
    BOOL PO = NO;
    BOOL FirstLA = YES;
    BOOL FirstPO = YES;
    
    NSDictionary* ExistingPolDetailsDic=array[0];
    int ExistingPolDetailsCount=[[ExistingPolDetailsDic valueForKey:@"ExistingPolDetailsCount"] intValue];
    for (int i = 0; i <ExistingPolDetailsCount; i++) {
        NSString *data1 = @"";
        NSString *data2 = @"";
        NSString *data3 = @"";
        NSString *data4 = @"";
        NSString *data4a = @"";
        NSString *data5 = @"";
        NSString *data6 = @"";
        NSDictionary* tempExistingPolDetails=nil;
        if (ExistingPolDetailsCount==1) {
            
            tempExistingPolDetails=[ExistingPolDetailsDic valueForKey:@"ExistingPolDetails"];
        }
        else
            tempExistingPolDetails=[ExistingPolDetailsDic valueForKey:@"ExistingPolDetails"][i];
        data1 = tempExistingPolDetails[@"iExtPolLA"];
        if ([data1 isEqualToString:@"Payor"] || [data1 isEqualToString:@"2nd Life Assured"]) {
            if (FirstPO) {
                data1 = @"<span class=\"cls_012\">Policy Owner</span><br/><span "
                @"class=\"cls_007\">Pemunya Polisi</span>";
                FirstPO=NO;
            }
            else
            {
                data1= @"";
            }
            
        }else
        {
            if (FirstLA) {
                data1 = @"<span class=\"cls_012\">Life Assured</span><br/><span "
                @"class=\"cls_007\">Hayat Diinsuranskan</span>";
                FirstLA=NO;
            }
            else
            {
                data1= @"";
            }
            
        }
        
        
        data2 = tempExistingPolDetails[@"ExtPolCompany"];
        if (tempExistingPolDetails[@"ExtPolLife"])
            data3 = [fmt stringFromNumber:[fmt numberFromString:tempExistingPolDetails[@"ExtPolLife"]]];
        if (tempExistingPolDetails[@"ExtPolPA"])
            data4 = [fmt stringFromNumber:[fmt numberFromString:tempExistingPolDetails[@"ExtPolPA"]]];
        if (tempExistingPolDetails[@"ExtPolHI"])
            data4a = [fmt stringFromNumber:[fmt numberFromString:tempExistingPolDetails[@"ExtPolHI"]]];
        if (tempExistingPolDetails[@"ExtPolCI"])
            data5 = [fmt stringFromNumber:[fmt numberFromString:tempExistingPolDetails[@"ExtPolCI"]]];
        
        data6 = tempExistingPolDetails[@"ExtPolDateIssued"];
        //data7 = array[i][@"ExistingPolDetails"][@"ID"];
        part4Table = [part4Table stringByAppendingFormat:@"<tr>\
                      <td style=\"border:1px solid black;\" width=74px><span class=\"cls_003\">%@</span></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"><span class=\"cls_003\">%@</span></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"><div align=\"right\"><span class=\"cls_003\">%@</span></div></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\" ><div align=\"center\"><span class=\"cls_003\">%@</span></div></td>\
                      </tr>",
                      data1, data2, data3, data4, data4a,
                      data5, data6];
    }

    if (!array.count) {
        part4Table =
        [part4Table stringByAppendingFormat:@"<tr>\
         <td style=\"border:1px solid black;\" width=74px>%@</td>\
         <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
         <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
         <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
         <td style=\"border:1px solid black;\" width=\"74px\"></td>\
         <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
         <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
         </tr>",
         @"<span class=\"cls_012\">Life Assured</span><br/><span "
         @"class=\"cls_005\">Hayat Diinsuranskan</span>",
         @"", @"", @"", @"", @""];
        part4Table = [part4Table
                      stringByAppendingFormat:@"<tr>\
                      <td style=\"border:1px solid black;\" width=74px>%@</td>\
                      <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
                      <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
                      <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
                      <td style=\"border:1px solid black;\" width=\"74px\"></td>\
                      <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
                      <td style=\"border:1px solid black;\" width=\"74px\">%@</td>\
                      </tr>",
                      @"<span class=\"cls_012\">Policy Owner</span><br/><span "
                      @"class=\"cls_005\">Pemunya Polisi</span>",
                      @"", @"", @"", @"", @""];
    }
    
    NSMutableDictionary *pgDict =
    [[PRHtmlHandler sharedPRHtmlHandler].pageTopDict mutableCopy];
    if (array.count > 3) {
        [PRHtmlHandler sharedPRHtmlHandler].pageCount++;
        for (int i = 4; i < 14; i++) {
            NSString *key = [NSString stringWithFormat:@"page%d", i];
            float value = [pgDict[key] floatValue] + 852;
            [pgDict setValue:[NSString stringWithFormat:@"%0.2f", value] forKey:key];
        }
        part4Table = [part4Table
                      stringByReplacingString:@"**part4top**"
                      withString:[NSString stringWithFormat:@"%f", 841.8 + 20]];
        [pgDict setValue:[NSString stringWithFormat:@"%f", 842 + 841.8]
                  forKey:@"page11height"];
        
        [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
        page11 =
        [[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page11];
        part4Table = [@"##watermark##" stringByAppendingString:part4Table];
        [PRHtmlHandler sharedPRHtmlHandler].top += 842.0;
    } else {
        part4Table = [part4Table
                      stringByReplacingString:@"**part4top**"
                      withString:[NSString stringWithFormat:@"%0.2f", 290.20]];
        [pgDict setValue:[NSString stringWithFormat:@"%f", 842.0 + 20 * array.count]
                  forKey:@"page11height"];
    }
    
    [PRHtmlHandler sharedPRHtmlHandler].pageTopDict = pgDict;
    
    part4Table = [part4Table stringByAppendingString:@"</table></div>"];
    page11 = [page11 stringByReplacingString:@"##part4Table##" withString:part4Table];
    //    
    
    NSString *extPol1 = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns1"];
    if ([extPol1 isEqualToString:@"Y"]) {
        page11=[page11 stringByReplacingString:@"##extPolInfo.1##" withString:@"◼︎"];
    }else
    {
        page11=[page11 stringByReplacingString:@"##extPolInfo.2##" withString:@"◼︎"];
    }
    NSString *extPol1a = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns2"];
    if ([extPol1a isEqualToString:@"Y"]) {
        page11=[page11 stringByReplacingString:@"##extPolInfo.1a##" withString:@"◼︎"];
    }else
    {
        page11=[page11 stringByReplacingString:@"##extPolInfo.2a##" withString:@"◼︎"];
    }
    
    NSString *cashDividend = dicttionary[@"DividendInfo"][@"CashDividendOption"];
    if ([cashDividend isEqualToString:@"DIV001"]) {
        page11=[page11 stringByReplacingString:@"##part4.3.1##" withString:@"◼︎"];
    }else if ([cashDividend isEqualToString:@"DIV002"])
    {
        page11=[page11 stringByReplacingString:@"##part4.3.2##" withString:@"◼︎"];
    }
    
    NSString *backDateFlag=dicttionary[@"SubmissionInfo"][@"BackDate"];
    if ([backDateFlag isEqualToString:@"True"]) {
        page11=[page11 stringByReplacingString:@"##part4.5.1##" withString:@"◼︎"];
        page11=[page11 stringByReplacingString:@"##part4.5date##" withString:dicttionary[@"SubmissionInfo"][@"Backdating"]];
    }
    
    NSString *prefferedLifeFlag=dicttionary[@"SubmissionInfo"][@"PreferredLife"];
    if ([prefferedLifeFlag isEqualToString:@"Y"]) {
        page11=[page11 stringByReplacingString:@"##prefferedLife##" withString:@"◼︎"];
    }


    page11 = [page11 stringByReplacingString:@"##cardAccountNo##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##expireDate##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##issuedBy###" withString:@""];
    page11 = [page11 stringByReplacingString:@"##cardmemberName##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##cardmemberIC##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##oneTimePayment##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##standingInstruction##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##contactNo##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##relationship##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##debit.upon.acceptance##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##debit.upon.submission##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##percent1##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##percent2##" withString:@""];
    page11 = [page11 stringByReplacingString:@"##part4.3.1##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##part4.3.2##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##part4.5date##" withString:@""];
    page11=[page11 stringByReplacingString:@"##part4.5.2##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##part4.5sum##" withString:@""];
    page11=[page11 stringByReplacingString:@"##part4.5policyno##" withString:@""];
    
    
   
    page11=[page11 stringByReplacingString:@"##part4.5.1##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##part4.5date##" withString:@""];
    page11=[page11 stringByReplacingString:@"##part4.5.2##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##part4.5sum##" withString:@""];
    page11=[page11 stringByReplacingString:@"##part4.5policyno##" withString:@""];
    
    //preffered Life checkbox
    
     page11=[page11 stringByReplacingString:@"##part4.5.11##" withString:@"◻︎"];
    
    page11 = [page11 stringByReplacingString:@"##paymentMode.annual##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMode.semiannual##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMode.quarterly##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMode.monthly##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMethod.cash##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMethod.creditcard##" withString:@"◻︎"];
    page11 = [page11 stringByReplacingString:@"##paymentMethod.SI##" withString:@"◻︎"];
    
    page11=[page11 stringByReplacingString:@"##extPolInfo.1##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##extPolInfo.2##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##extPolInfo.1a##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##extPolInfo.2a##" withString:@"◻︎"];
    page11=[page11 stringByReplacingString:@"##prefferedLife##" withString:@"◻︎"];

    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page11=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page11];
    return page11;
}
@end
