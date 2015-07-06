//
//  PRPage7.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage7.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation PRPage7
+(NSString*)prPage7WithDictionary:(NSDictionary*)dicttionary{
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page7" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *array=nil;
    if ([dicttionary[@"QuestionaireInfo"][@"Questionaire"] isKindOfClass:[NSDictionary class]]) {
        array=[NSArray arrayWithObject:dicttionary[@"QuestionaireInfo"][@"Questionaire"]];
    }else if ([dicttionary[@"QuestionaireInfo"][@"Questionaire"] isKindOfClass:[NSArray class]]){
        array=dicttionary[@"QuestionaireInfo"][@"Questionaire"];
    }
    NSString *table=@"\
    <div id=\"laTable\" style=\"position:absolute;left:0.75px;top:-1.0px;\" class=\"cls_007\">\n<table style=\"border:1px solid grey;border-collapse:collapse;font-size: 1em;width:536.8px\">\
    <tr>\
    <td style=\"border:1px solid grey;border-collapse:collapse; bgcolor=\"#C0C0C0\"><span class=\"cls_012\">Life Assured's Details </span><span class=\"cls_007\">/ Butir-butir Hayat Diinsuranskan</span></td>\
    </tr>\
    \n##LA##\
    <tr><td>LA.</td></tr>\
    <tr>\
    <td style=\"border:1px solid grey;border-collapse:collapse; bgcolor=\"#C0C0C0\"><span class=\"cls_012\">Policy Owner's Details </span><span class=\"cls_007\">/ Butir-butir Pemunya Polisi</span></td>\
    </tr>##PO##<tr><td>PO.</td></tr>\
    </table></div>";
    NSInteger length=0;
    NSInteger extra=0;
    NSInteger extra2=0;
    if (array) {
        for (NSDictionary *dict in array) {
            NSArray *questions=dict[@"Questions"];
            NSString *reason=@"";
            for (NSDictionary *question in questions) {
                NSString *testQAnswer = question[@"QnID"];
                if (question[@"Answer"] && [question[@"Answer"] isEqualToString:@"Y"]) {
//                    NSString *qnText=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getQuestionByCode:question[@"QnID"]];
                    NSString *qnText;
                                        
                    FMResultSet *getQuestionNo = [database executeQuery:@"SELECT QuestionNo FROM eproposal_Question WHERE QnID = ?",question[@"QnID"]];
                    while ([getQuestionNo next]) {
                        qnText=[getQuestionNo objectForColumnName:@"QuestionNo"];
                    }
                    
                    if ([qnText isEqualToString:@"2"] || [qnText isEqualToString:@"3"] || [qnText isEqualToString:@"4"] || [qnText isEqualToString:@"7(a)"] || [qnText isEqualToString:@"15"] || [qnText isEqualToString:@"14(a)"] || [qnText isEqualToString:@"8"]) {
                    }else
                    {
                        reason=[reason stringByAppendingFormat:@"Question %@ - %@\n\<br>",qnText,question[@"Reason"]];
                        extra=extra+1;
                    }

                }
            }
//            length+=reason.length;
            length=extra*200;
            if ([dict[@"PTypeCode"] isEqualToString:@"LA"] && [dict[@"Seq"] isEqualToString:@"1"]) {
                if (reason.length){
                    table=[table stringByReplacingString:@"<tr><td>LA.</td></tr>" withString:@""];
                    NSString *la=[NSString stringWithFormat:@"<tr>\
                                  <td width=\"500px\" align=\"justify\">%@</td>\
                                  </tr>",reason];
                    table=[table stringByReplacingString:@"##LA##" withString:la];
                }
            }else{
                if (reason.length) {
                    table=[table stringByReplacingString:@"<tr><td>PO.</td></tr>" withString:@""];
                    NSString *la=[NSString stringWithFormat:@"<tr>\
                                  <td width=\"500px\" align=\"justify\">%@</td>\
                                  </tr>",reason];
                    table=[table stringByReplacingString:@"##PO##" withString:la];
                }
            }
        }
        table=[table stringByReplacingString:@"<tr><td>LA.</td></tr>" withString:@"<tr><td>&nbsp;&nbsp;</td></tr>"];
        table=[table stringByReplacingString:@"<tr><td>PO.</td></tr>" withString:@"<tr><td>&nbsp;&nbsp;</td></tr>"];
        table=[table stringByReplacingString:@"##LA##" withString:@""];
        table=[table stringByReplacingString:@"##PO##" withString:@""];
        page=[page stringByReplacingString:@"##LAPOTable##" withString:table];
    }
	
	else
	{
		table=[table stringByReplacingString:@"<tr><td>LA.</td></tr>" withString:@"<tr><td>&nbsp;&nbsp;</td></tr>"];
        table=[table stringByReplacingString:@"<tr><td>PO.</td></tr>" withString:@"<tr><td>&nbsp;&nbsp;</td></tr>"];
        table=[table stringByReplacingString:@"##LA##" withString:@""];
        table=[table stringByReplacingString:@"##PO##" withString:@""];
		
		page=[page stringByReplacingString:@"##LAPOTable##" withString:table];
		//page=[page stringByReplacingString:@"##POTable##" withString:@" "];
		
	}
    
   
    

    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
}
@end
