//
//  PRPage6.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage6.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation PRPage6
+(NSString*)prPage6WithDictionary:(NSDictionary*)dicttionary{
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page6" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString *proposalNo= dicttionary[@"AssuredInfo"][@"eProposalNo"];
    
    
    
    NSArray *array=nil;
    if ([dicttionary[@"QuestionaireInfo"][@"Questionaire"] isKindOfClass:[NSDictionary class]]) {
        array=[NSArray arrayWithObject:dicttionary[@"QuestionaireInfo"][@"Questionaire"]];
    }else if ([dicttionary[@"QuestionaireInfo"][@"Questionaire"] isKindOfClass:[NSArray class]]){
        array=dicttionary[@"QuestionaireInfo"][@"Questionaire"];
    }
    if (array) {
        for (NSDictionary *dict in array) {
            NSArray *questions=dict[@"Questions"];
            for (NSDictionary *question in questions) {
                NSString *answer=@"2";
                if (question[@"Answer"] && [question[@"Answer"] isEqualToString:@"Y"]) {
                    answer=@"1";
                }
                
//                if ([question[@"QnID"] isEqualToString:@"Q1018"]) {
//                    NSString *str=[NSString stringWithFormat:@"##Q1018.%@_%@##",answer,dict[@"Seq"]];
//                    page=[page stringByReplacingString:str withString:@"◼︎"];
//                }
//                if ([question[@"QnID"] isEqualToString:@"Q1019"]) {
//                    NSString *str=[NSString stringWithFormat:@"##Q1019.%@_%@##",answer,dict[@"Seq"]];
//                    page=[page stringByReplacingString:str withString:@"◼︎"];
//                }
                
                if ([question[@"QnID"] isEqualToString:@"Q1034"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1034.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1035"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1035.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1023"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1023.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1024"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1024.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1025"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1025.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1026"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1026.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1029"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1029.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1025"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1025.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1031"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1031.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                
                if ([question[@"QnID"] isEqualToString:@"Q1027"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1027.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    
                    NSString *getQ1027Reason;
                    NSString *LAType;
                    if ([dict[@"Seq"] isEqualToString:@"1"]) {
                        LAType = @"LA1";
                    }else
                    {
                        LAType = @"PO";
                    }
                    
                    FMResultSet *getQ1027 = [database executeQuery:@"select * from eProposal_QuestionAns where eProposalNo = ? and QnID = 'Q1027' and LAType = ?",proposalNo,LAType];
                    while ([getQ1027 next]) {
                        getQ1027Reason=[getQ1027 objectForColumnName:@"Reason"];
                    }
                    NSArray *tmpArray3=[getQ1027Reason componentsSeparatedByString:@" "];
//                    NSArray *tmpArray3=[question[@"Reason"] componentsSeparatedByString:@";"];
                    if (tmpArray3.count==2) {
                        NSString *str=[NSString stringWithFormat:@"##Q1027.%@.reason1##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray3[0]];
                        str=[NSString stringWithFormat:@"##Q1027.%@.reason2##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray3[1]];
                    }                    
                }
                if ([question[@"QnID"] isEqualToString:@"Q1028"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1028.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1032"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1032.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    
                    NSArray *tmpArray=[question[@"Reason"] componentsSeparatedByString:@";"];
                    if (tmpArray.count==2) {
                        NSString *str=[NSString stringWithFormat:@"##Q1032.%@.reason1##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[0]];
                        str=[NSString stringWithFormat:@"##Q1032.%@.reason2##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[1]];
                    }
                    
                }
            }
        }
    }
    page=[page stringByReplacingString:@"##Q1028##" withString:@""];
    page=[page stringByReplacingString:@"##Q1032##" withString:@""];
    for (int i=1; i<3; i++) {
        NSString *str=[NSString stringWithFormat:@"##Q1034.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1034.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1035.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1035.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1023.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1023.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1024.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1024.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1025.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1025.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1026.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1026.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1027.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1027.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1027.%d.reason1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1027.%d.reason2##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##Q1028.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1028.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1029.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1029.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1025.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1025.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1031.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1031.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1032.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1032.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        
        str=[NSString stringWithFormat:@"##Q1032.%d.reason1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1032.%d.reason2##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##Q1017.1_%d##",i];
    }
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
}
@end
