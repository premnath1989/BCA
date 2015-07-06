//
//  PRPage5.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage5.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation PRPage5
+(NSString*)prPage5WithDictionary:(NSDictionary*)dicttionary{
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page5" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];

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
                if ([question[@"QnID"] isEqualToString:@"Q1001"]) {
                    NSArray *tmpArray=[question[@"Answer"] componentsSeparatedByString:@";"];
                    if (tmpArray.count==2) {
                        NSString *str=[NSString stringWithFormat:@"##weight%@##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[1]];
                        str=[NSString stringWithFormat:@"##height%@##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[0]];
                    }
                }
                
                if ([question[@"QnID"] isEqualToString:@"Q1002"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1002.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1003"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1003.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1004"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1004.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    NSArray *tmpArray=[question[@"Reason"] componentsSeparatedByString:@";"];
                    if (tmpArray.count==3) {
                        NSString *str=[NSString stringWithFormat:@"##Q1004.%@.reason1##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[0]];
                        str=[NSString stringWithFormat:@"##Q1004.%@.reason2##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[1]];
                        str=[NSString stringWithFormat:@"##Q1004.%@.reason3##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray[2]];
                    }
                    
                }
                if ([question[@"QnID"] isEqualToString:@"Q1005"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1005.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    
                    NSString *getQ1005Reason;
                    if ([dict[@"Seq"] isEqualToString:@"1"]) {
                        FMResultSet *getQ1005 = [database executeQuery:@"select * from eProposal_QuestionAns where eProposalNo = ? and QnID = 'Q1005' and LAType = 'LA1'",proposalNo];
                        while ([getQ1005 next]) {
                            getQ1005Reason=[getQ1005 objectForColumnName:@"Reason"];
                        }
                    }
                    else
                    {
                        FMResultSet *getQ1005 = [database executeQuery:@"select * from eProposal_QuestionAns where eProposalNo = ? and QnID = 'Q1005' and (LAType = 'PO' or LAType = 'LA2')",proposalNo];
                        while ([getQ1005 next]) {
                            getQ1005Reason=[getQ1005 objectForColumnName:@"Reason"];
                        }
                    
                    }
                    
                    
                    NSArray *tmpArray2=[getQ1005Reason componentsSeparatedByString:@" "];
                    if (tmpArray2.count==4) {
                        NSString *str=[NSString stringWithFormat:@"##Q1005.%@.reason1##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray2[0]];
                        str=[NSString stringWithFormat:@"##Q1005.%@.reason2##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray2[1]];
                        str=[NSString stringWithFormat:@"##Q1005.%@.reason3##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray2[2]];
                        str=[NSString stringWithFormat:@"##Q1005.%@.reason4##",dict[@"Seq"]];
                        page=[page stringByReplacingString:str withString:tmpArray2[3]];
                    }
                }
                if ([question[@"QnID"] isEqualToString:@"Q1006"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1006.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1007"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1007.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1008"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1008.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                
                if ([question[@"QnID"] isEqualToString:@"Q1010"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1010.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1011"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1011.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1012"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1012.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1013"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1013.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1014"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1014.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1015"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1015.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1016"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1016.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1017"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1017.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1018"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1018.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                if ([question[@"QnID"] isEqualToString:@"Q1033"]) {
                    NSString *str=[NSString stringWithFormat:@"##Q1033.%@_%@##",answer,dict[@"Seq"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }
                
            }
        }
    }
    for (int i=1; i<3; i++) {
        NSString *str=[NSString stringWithFormat:@"##weight%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##height%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1002.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1002.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1003.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1003.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1004.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1004.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];

        str=[NSString stringWithFormat:@"##Q1004.%d.reason1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1004.%d.reason2##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1004.%d.reason3##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1005.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1005.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1005.%d.reason1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1005.%d.reason2##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1005.%d.reason3##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1005.%d.reason4##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Q1006.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1006.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1007.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1007.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1008.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1008.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1010.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1010.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1011.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1011.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1012.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1012.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1013.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1013.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1014.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1014.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1015.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1015.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1016.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1016.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1017.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1017.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1018.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1018.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1033.1_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##Q1033.2_%d##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        
        
    }
    page=[page stringByReplacingString:@"##cardAccountNo##" withString:@""];
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
}
@end
