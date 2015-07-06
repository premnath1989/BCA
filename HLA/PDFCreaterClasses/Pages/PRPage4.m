//
//  PRPage4.m
//  PDF
//
//  Created by Travel Chu on 3/18/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage4.h"
#import "PRHtmlHandler.h"

@implementation PRPage4
+(NSString*)prPage4WithDictionary:(NSDictionary*)dicttionary{
    NSString *page4=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page4" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *extPol2 = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns3a"];
    if ([extPol2 isEqualToString:@"Y"]) {
            page4=[page4 stringByReplacingString:@"##part4.2a.1##" withString:@"◼︎"];
    }else
    {
            page4=[page4 stringByReplacingString:@"##part4.2a.2##" withString:@"◼︎"];
    }
    
    NSString *extPol3 = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns3b"];
    if ([extPol3 isEqualToString:@"Y"]) {
        page4=[page4 stringByReplacingString:@"##part4.2b.1##" withString:@"◼︎"];
    }else if ([extPol3 isEqualToString:@"N"])
    {
        page4=[page4 stringByReplacingString:@"##part4.2b.2##" withString:@"◼︎"];
    }
    
    NSString *extPol4 = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns3c"];
    if ([extPol4 isEqualToString:@"Y"]) {
        page4=[page4 stringByReplacingString:@"##part4.2c.1##" withString:@"◼︎"];
    }else if ([extPol4 isEqualToString:@"N"])
    {
        page4=[page4 stringByReplacingString:@"##part4.2c.2##" withString:@"◼︎"];
    }
    
    NSString *extPol5 = dicttionary[@"ExistingPolInfo"][@"ExistingPolAns3d"];
    if ([extPol5 isEqualToString:@"Y"]) {
        page4=[page4 stringByReplacingString:@"##part4.2d.1##" withString:@"◼︎"];
    }else if ([extPol5 isEqualToString:@"N"])
    {
        page4=[page4 stringByReplacingString:@"##part4.2d.2##" withString:@"◼︎"];
    }
    
    NSString *cashDividend = dicttionary[@"DividendInfo"][@"CashDividendOption"];
    if ([cashDividend isEqualToString:@"DIV001"]) {
        page4=[page4 stringByReplacingString:@"##part4.3.1##" withString:@"◼︎"];
    }else if ([cashDividend isEqualToString:@"DIV002"])
    {
        page4=[page4 stringByReplacingString:@"##part4.3.2##" withString:@"◼︎"];
    }

    NSArray *array=nil;
    if ([dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"] isKindOfClass:[NSDictionary class]]) {
        array=[NSArray arrayWithObject:dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"]];
    }else if ([dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"] isKindOfClass:[NSArray class]]){
        array=dicttionary[@"DividendInfo"][@"CashPaymentOptionType"][@"Options"];
    }
    if (array) {
        for (NSDictionary *dict in array) {
            NSString *optionType = dict[@"OptionType"];
            if ([optionType isEqualToString:@"SUR_PAY_01"]) {
//                NSString *str=[NSString stringWithFormat:@"##percent%@##",dict[@"ID"]];
                NSString *str=[NSString stringWithFormat:@"##percent1##"];
                page4=[page4 stringByReplacingString:str withString:dict[@"Percentage"]];
            }else{
                NSString *str=[NSString stringWithFormat:@"##percent2##"];
                page4=[page4 stringByReplacingString:str withString:dict[@"Percentage"]];
            }
        }
    }
    
    
    NSString *backDateFlag=dicttionary[@"SubmissionInfo"][@"BackDate"];
    if ([backDateFlag isEqualToString:@"True"]) {
        page4=[page4 stringByReplacingString:@"##part4.5.1##" withString:@"◼︎"];
        page4=[page4 stringByReplacingString:@"##part4.5date##" withString:dicttionary[@"SubmissionInfo"][@"Backdating"]];
    }
    
    
    page4=[page4 stringByReplacingString:@"##guardian.name##" withString:dicttionary[@"iMobileExtraInfo"][@"Guardian"][@"GuardianName"]];
    page4=[page4 stringByReplacingString:@"##guardian.NRIC##" withString:dicttionary[@"iMobileExtraInfo"][@"Guardian"][@"GuardianNewIC"]];
    
    
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    
    page4 = [page4 stringByReplacingString:@"##husbandFatherName##"
                              withString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesName"]];
    page4 = [page4 stringByReplacingString:@"##yearlyIncome##"
                              withString:[fmt stringFromNumber:[fmt numberFromString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesMthlyIncome"]]]];
    
    NSDictionary *addOccp=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesOccpCode"]];
    page4 = [page4 stringByReplacingString:@"##addques.occupation##"
                              withString:addOccp];
    NSString *isInsured = dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesInsured"];
    if ([isInsured isEqualToString:@"True"]) {
        page4 = [page4 stringByReplacingString:@"##addques.insured.Yes##"
                                  withString:@"◼︎"];}
    else if ([isInsured isEqualToString:@"False"]){
        page4 = [page4 stringByReplacingString:@"##addques.insured.No##"
                                  withString:@"◼︎"];}
    
    
    page4 = [page4 stringByReplacingString:@"##addques.reason##"
                              withString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesReason"]];
    
    // Testing with existing policies method start//
    
//    NSArray *array = nil;
    NSArray *array2 = nil;
    if ([dicttionary[@"AddQuesDetailsInfo"]
         isKindOfClass:[NSDictionary class]]) {
        array = [NSArray arrayWithObject:dicttionary[@"AddQuesDetailsInfo"]];
        
    } else if ([dicttionary[@"AddQuesDetailsInfo"]
                isKindOfClass:[NSArray class]]) {
        array = dicttionary[@"AddQuesDetailsInfo"];
    }
    
    NSString *part6Table =
    @"<div style=\"position:absolute;left:25.75px;top:608.45px;\" class=\"cls_007\">\n<table style=\"font-size: 1.1em;width:536.8px\">\n\
    <tr>\
    <td width=\"150px\" align=\"center\"><span class=\"cls_012\">Company</span><br/><span class=\"cls_005\">Syarikat </span></td>\
    <td width=\"200px\" align=\"center\"><span class=\"cls_012\">Amount Insured</span><span class=\"cls_005\"> / Jumlah Diinsuranskan</span><br><span class=\"cls_012\">Life / Accident / Critical Illness </span><span class=\"cls_005\"> / Hayat / Kemalangan / Penyakit Kritikal</span></td>\
    <td width=\"75px\" align=\"center\"><span class=\"cls_012\">Year Issued</span><br/><span class=\"cls_005\">Tahun Keluaran</span></td>\
    </tr>";
    
    part6Table = [part6Table stringByAppendingFormat:@"<div "
                  @"style=\"position:absolute;left:25.75px;top:"
                  @"750.20px;\" class=\"cls_007\">\n<table "
                  @"style=\"font-size: 1em;width:536.8px\">\n"];
    
    int AddQuesLength=650;
    int AddQuesLength2;
    NSDictionary* AddQuesDic=array[0];
    int AddQuesDetailsCount=[[AddQuesDic valueForKey:@"AddQuesDetailsCount"] intValue];
    for (int i = 0; i <AddQuesDetailsCount; i++) {
        NSString *data1 = @"";
        NSString *data2 = @"";
        NSString *data3 = @"";
        NSString *data4 = @"";
        NSDictionary* tempAddQuesDetails=nil;
        if (AddQuesDetailsCount==1) {
            
            tempAddQuesDetails=[AddQuesDic valueForKey:@"AddQuesDetails"];
        }
        else
            tempAddQuesDetails=[AddQuesDic valueForKey:@"AddQuesDetails"][i];
        
        data1 = tempAddQuesDetails[@"AddQuesCompany"];
        if (tempAddQuesDetails[@"AddQuesAmountInsured"])
            //            data2 = tempAddQuesDetails[@"AddQuesAmountInsured"];
            data2 = [fmt stringFromNumber:[fmt numberFromString:tempAddQuesDetails[@"AddQuesAmountInsured"]]];
        
        if (tempAddQuesDetails[@"AddQuesLifeAccidentDisease"])
            data3 = tempAddQuesDetails[@"AddQuesLifeAccidentDisease"];
        if (tempAddQuesDetails[@"AddQuesYrIssued"])
            data4 = tempAddQuesDetails[@"AddQuesYrIssued"];
        
        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - &nbsp; %@</td>\
                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
                      </tr>",
                      data1, data2, data3, data4];
        AddQuesLength = AddQuesLength+8;
    }
    
    if (!array.count) {
        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
                      <td width=\"150px\"  background=\"AdditionalQLine.png\">&nbsp;%@</td>\
                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
                      </tr>",
                      @" ", @" ", @" ", @" "];
        
        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
                      </tr>",
                      @" ", @" ", @" ", @" "];
        AddQuesLength = AddQuesLength+16;
    }
    else if(AddQuesDetailsCount==0) {
        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
                      </tr>",
                      @" ", @" ", @" ", @" "];
        
        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
                      </tr>",
                      @" ", @" ", @" ", @" "];
        AddQuesLength = AddQuesLength+16;
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
        part6Table = [part6Table
                      stringByReplacingString:@"**ridertop**"
                      withString:[NSString stringWithFormat:@"%f", 841.8 + 20]];
        [pgDict setValue:[NSString stringWithFormat:@"%f", 842 + 841.8]
                  forKey:@"page3height"];
        
        [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
        page4 =
        [[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page4];
        part6Table = [@"##watermark##" stringByAppendingString:part6Table];
        [PRHtmlHandler sharedPRHtmlHandler].top += 842.0;
    } else {
        part6Table = [part6Table
                      stringByReplacingString:@"**ridertop**"
                      withString:[NSString stringWithFormat:@"%0.2f", 550.20]];
        [pgDict setValue:[NSString stringWithFormat:@"%f", 842.0 + 20 * array.count]
                  forKey:@"page3height"];
    }
    
    [PRHtmlHandler sharedPRHtmlHandler].pageTopDict = pgDict;
    
    part6Table = [part6Table stringByAppendingString:@"</table></div>"];
    page4 = [page4 stringByReplacingString:@"##part6Table##" withString:part6Table];
    page4=[page4 stringByReplacingString:@"##top6.1##" withString:[NSString stringWithFormat:@"%d",AddQuesLength+12]];
    page4=[page4 stringByReplacingString:@"##top6.3##" withString:[NSString stringWithFormat:@"%d",AddQuesLength+6]];
    AddQuesLength2=AddQuesLength+20;
    page4=[page4 stringByReplacingString:@"##top6.2##" withString:[NSString stringWithFormat:@"%d",AddQuesLength2]];
    
    
    
    
    
    
    
    
    
    
    
    
    page4=[page4 stringByReplacingString:@"##part4.2a.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2a.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2b.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2b.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2c.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2c.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2d.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.2d.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##percent1##" withString:@""];
    page4=[page4 stringByReplacingString:@"##part4.4.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##percent2##" withString:@""];
    page4=[page4 stringByReplacingString:@"##part4.4.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.3.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.3.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.5.1##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.5date##" withString:@""];
    page4=[page4 stringByReplacingString:@"##part4.5.2##" withString:@"◻︎"];
    page4=[page4 stringByReplacingString:@"##part4.5sum##" withString:@""];
    page4=[page4 stringByReplacingString:@"##part4.5policyno##" withString:@""];
    
    page4=[page4 stringByReplacingString:@"##guardian.name##" withString:@""];
    page4=[page4 stringByReplacingString:@"##guardian.NRIC##" withString:@""];
    
    page4 = [page4 stringByReplacingString:@"##husbandFatherName##" withString:@""];
    page4 = [page4 stringByReplacingString:@"##yearlyIncome##" withString:@""];
    page4 = [page4 stringByReplacingString:@"##addques.occupation##" withString:@""];
    page4 = [page4 stringByReplacingString:@"##addques.insured.Yes##" withString:@"◻︎"];
    page4 = [page4 stringByReplacingString:@"##addques.insured.No##" withString:@"◻︎"];
    page4 = [page4 stringByReplacingString:@"##addques.reason##" withString:@""];
    
    
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page4=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page4];
    return page4;
}
@end
