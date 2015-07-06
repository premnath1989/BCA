//
//  PRPage13.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage13.h"
#import "PRHtmlHandler.h"

@implementation PRPage13
+(NSString*)prPage13WithDictionary:(NSDictionary*)dicttionary{
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page13" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
//    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
//    [fmt setMaximumFractionDigits:2];
//    [fmt setPositiveFormat:@"#,##0.00"];
//    
//    
//    page = [page stringByReplacingString:@"##husbandFatherName##"
//                              withString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesName"]];
//    page = [page stringByReplacingString:@"##yearlyIncome##"
//                              withString:[fmt stringFromNumber:[fmt numberFromString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesMthlyIncome"]]]];
//    
//    NSDictionary *addOccp=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesOccpCode"]];
//    page = [page stringByReplacingString:@"##addques.occupation##"
//                              withString:addOccp];
//    NSString *isInsured = dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesInsured"];
//    if ([isInsured isEqualToString:@"True"]) {
//        page = [page stringByReplacingString:@"##addques.insured.Yes##"
//                                  withString:@"◼︎"];}
//    else if ([isInsured isEqualToString:@"False"]){
//        page = [page stringByReplacingString:@"##addques.insured.No##"
//                                  withString:@"◼︎"];}
//    
//    
//    page = [page stringByReplacingString:@"##addques.reason##"
//                              withString:dicttionary[@"AddQuesInfo"][@"AddQues"][@"AddQuesReason"]];
//    
//    // Testing with existing policies method start//
//    
//    NSArray *array = nil;
//    NSArray *array2 = nil;
//    if ([dicttionary[@"AddQuesDetailsInfo"]
//         isKindOfClass:[NSDictionary class]]) {
//        array = [NSArray arrayWithObject:dicttionary[@"AddQuesDetailsInfo"]];
//        
//    } else if ([dicttionary[@"AddQuesDetailsInfo"]
//                isKindOfClass:[NSArray class]]) {
//        array = dicttionary[@"AddQuesDetailsInfo"];
//    }
//
//    NSString *part6Table =
//                  @"<div style=\"position:absolute;left:25.75px;top:158.45px;\" class=\"cls_007\">\n<table style=\"font-size: 1.1em;width:536.8px\">\n\
//                  <tr>\
//                  <td width=\"150px\" align=\"center\"><span class=\"cls_012\">Company</span><br/><span class=\"cls_005\">Syarikat </span></td>\
//                  <td width=\"200px\" align=\"center\"><span class=\"cls_012\">Amount Insured</span><span class=\"cls_005\"> / Jumlah Diinsuranskan</span><br><span class=\"cls_012\">Life / Accident / Critical Illness </span><span class=\"cls_005\"> / Hayat / Kemalangan / Penyakit Kritikal</span></td>\
//                  <td width=\"75px\" align=\"center\"><span class=\"cls_012\">Year Issued</span><br/><span class=\"cls_005\">Tahun Keluaran</span></td>\
//                  </tr>";
//    
//    part6Table = [part6Table stringByAppendingFormat:@"<div "
//                  @"style=\"position:absolute;left:25.75px;top:"
//                  @"300.20px;\" class=\"cls_007\">\n<table "
//                  @"style=\"font-size: 1em;width:536.8px\">\n"];
//
//    int AddQuesLength=200;
//    int AddQuesLength2;
//    NSDictionary* AddQuesDic=array[0];
//    int AddQuesDetailsCount=[[AddQuesDic valueForKey:@"AddQuesDetailsCount"] intValue];
//    for (int i = 0; i <AddQuesDetailsCount; i++) {
//        NSString *data1 = @"";
//        NSString *data2 = @"";
//        NSString *data3 = @"";
//        NSString *data4 = @"";
//        NSDictionary* tempAddQuesDetails=nil;
//        if (AddQuesDetailsCount==1) {
//            
//            tempAddQuesDetails=[AddQuesDic valueForKey:@"AddQuesDetails"];
//        }
//        else
//            tempAddQuesDetails=[AddQuesDic valueForKey:@"AddQuesDetails"][i];
//        
//        data1 = tempAddQuesDetails[@"AddQuesCompany"];
//        if (tempAddQuesDetails[@"AddQuesAmountInsured"])
////            data2 = tempAddQuesDetails[@"AddQuesAmountInsured"];
//            data2 = [fmt stringFromNumber:[fmt numberFromString:tempAddQuesDetails[@"AddQuesAmountInsured"]]];
//        
//        if (tempAddQuesDetails[@"AddQuesLifeAccidentDisease"])
//            data3 = tempAddQuesDetails[@"AddQuesLifeAccidentDisease"];
//        if (tempAddQuesDetails[@"AddQuesYrIssued"])
//            data4 = tempAddQuesDetails[@"AddQuesYrIssued"];
//
//        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
//                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
//                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - &nbsp; %@</td>\
//                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
//                      </tr>",
//                      data1, data2, data3, data4];
//        AddQuesLength = AddQuesLength+8;
//    }
//
//    if (!array.count) {
//        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
//                      <td width=\"150px\"  background=\"AdditionalQLine.png\">&nbsp;%@</td>\
//                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
//                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
//                      </tr>",
//                      @" ", @" ", @" ", @" "];
//
//        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
//                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
//                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
//                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
//                      </tr>",
//                      @" ", @" ", @" ", @" "];
//        AddQuesLength = AddQuesLength+16;
//    }
//    else if(AddQuesDetailsCount==0) {
//        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
//                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
//                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
//                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
//                      </tr>",
//                      @" ", @" ", @" ", @" "];
//        
//        part6Table = [part6Table stringByAppendingFormat:@"<tr>\
//                      <td width=\"150px\" background=\"AdditionalQLine.png\">&nbsp;%@</td>\
//                      <td width=\"200px\" background=\"AdditionalQLine2.png\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@</td>\
//                      <td width=\"75px\" align=\"center\" background=\"AdditionalQLine3.png\">%@</td>\
//                      </tr>",
//                      @" ", @" ", @" ", @" "];
//        AddQuesLength = AddQuesLength+16;
//    }
//    
//    
//    
//    
//    NSMutableDictionary *pgDict =
//    [[PRHtmlHandler sharedPRHtmlHandler].pageTopDict mutableCopy];
//    if (array.count > 3) {
//        [PRHtmlHandler sharedPRHtmlHandler].pageCount++;
//        for (int i = 4; i < 14; i++) {
//            NSString *key = [NSString stringWithFormat:@"page%d", i];
//            float value = [pgDict[key] floatValue] + 852;
//            [pgDict setValue:[NSString stringWithFormat:@"%0.2f", value] forKey:key];
//        }
//        part6Table = [part6Table
//                      stringByReplacingString:@"**ridertop**"
//                      withString:[NSString stringWithFormat:@"%f", 841.8 + 20]];
//        [pgDict setValue:[NSString stringWithFormat:@"%f", 842 + 841.8]
//                  forKey:@"page3height"];
//        
//        [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
//        page =
//        [[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
//        part6Table = [@"##watermark##" stringByAppendingString:part6Table];
//        [PRHtmlHandler sharedPRHtmlHandler].top += 842.0;
//    } else {
//        part6Table = [part6Table
//                      stringByReplacingString:@"**ridertop**"
//                      withString:[NSString stringWithFormat:@"%0.2f", 550.20]];
//        [pgDict setValue:[NSString stringWithFormat:@"%f", 842.0 + 20 * array.count]
//                  forKey:@"page3height"];
//    }
//    
//    [PRHtmlHandler sharedPRHtmlHandler].pageTopDict = pgDict;
//    
//    part6Table = [part6Table stringByAppendingString:@"</table></div>"];
//    page = [page stringByReplacingString:@"##part6Table##" withString:part6Table];
//    page=[page stringByReplacingString:@"##top6.1##" withString:[NSString stringWithFormat:@"%d",AddQuesLength]];
//    AddQuesLength2=AddQuesLength+16;
//    page=[page stringByReplacingString:@"##top6.2##" withString:[NSString stringWithFormat:@"%d",AddQuesLength2]];

    
    
    // Testing with existing policies method end //
    
    
    // caluculation of the row number.
    
    
    NSString *page7_1=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page7_1" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
//    int length=2200;
    int adjustedlength=20;
//    NSString *adjustedlengthset;
//    if (length>6700) {
//        [PRHtmlHandler sharedPRHtmlHandler].pageCount++;
//        [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
//        page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
//        NSMutableDictionary *pgDict=[[PRHtmlHandler sharedPRHtmlHandler].pageTopDict mutableCopy];
//        for (int i=8; i<14; i++) {
//            NSString *key=[NSString stringWithFormat:@"page%d",i];
//            float value=[pgDict[key] floatValue]+852;
//            [pgDict setValue:[NSString stringWithFormat:@"%0.2f",value] forKey:key];
//        }
//        [pgDict setValue:[NSString stringWithFormat:@"%f",842+841.8] forKey:@"page7height"];
//        [PRHtmlHandler sharedPRHtmlHandler].pageTopDict=pgDict;
//        page7_1=[page7_1 stringByReplacingString:@"##top##" withString:[NSString stringWithFormat:@"%d",842+20]];
//        page7_1=[@"##watermark##" stringByAppendingString:page7_1];
//        [PRHtmlHandler sharedPRHtmlHandler].top+=842.0;
//    }else{
//        //        adjustedlength=[NSString stringWithFormat:@"%d",135+(length/195+1)*10];
//        adjustedlength=135+(length/195+1)*10;
//        if (adjustedlength<170) {
//            adjustedlengthset = @"180";
//        }else
//        {
//            adjustedlengthset=[NSString stringWithFormat:@"%d",135+(length/195+1)*10];
//        }
//        page7_1=[page7_1 stringByReplacingString:@"##top##" withString:adjustedlengthset];
//    }
    page7_1=[page7_1 stringByReplacingString:@"##top##" withString:[NSString stringWithFormat:@"%d",adjustedlength]];
    
//    page = [page stringByReplacingString:@"##husbandFatherName##" withString:@""];
//    page = [page stringByReplacingString:@"##yearlyIncome##" withString:@""];
//    page = [page stringByReplacingString:@"##addques.occupation##" withString:@""];
//    page = [page stringByReplacingString:@"##addques.insured.Yes##" withString:@"◻︎"];
//    page = [page stringByReplacingString:@"##addques.insured.No##" withString:@"◻︎"];
//    page = [page stringByReplacingString:@"##addques.reason##" withString:@""];
    
    
    page=[page stringByReplacingString:@"##page7.1##" withString:page7_1];
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
    
    //    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    //    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    //    return page;
    
    
    
    
}
@end
