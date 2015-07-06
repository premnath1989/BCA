//
//  PRPage1.m
//  PDF
//
//  Created by Travel Chu on 3/13/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage1.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface PRPage1()
@end

@implementation PRPage1
+(NSString*)prPage1WithDictionary:(NSDictionary*)dicttionary{
    NSString *page1=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page1" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    page1=[page1 stringByReplacingString:@"##eProposalNo##" withString:dicttionary[@"AssuredInfo"][@"eProposalNo"]];
    NSString *getChannel = dicttionary[@"ChannelInfo"][@"Channel"];
    if ([getChannel isEqualToString:@"AGT"]) {
        page1=[page1 stringByReplacingString:@"##agency##" withString:@"◼︎"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString *agentName;
    
    
    if ([dicttionary[@"AgentInfo"][@"AgentCount"] isEqualToString:@"1"]) {

        FMResultSet *getAgent = [database executeQuery:@"select * from Agent_profile where AgentCode = ?",dicttionary[@"AgentInfo"][@"Agent"][@"AgentCode"]];
        while ([getAgent next]) {
            agentName = [getAgent objectForColumnName:@"AgentName"];
        
        }
        
        page1=[page1 stringByReplacingString:@"##AgentCode##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"AgentCode"]];
        page1=[page1 stringByReplacingString:@"##LeaderCode##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"LeaderCode"]];
        page1=[page1 stringByReplacingString:@"##LeaderName##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"LeaderName"]];
        page1=[page1 stringByReplacingString:@"##AgentContactNo##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"AgentContactNo"]];
        page1=[page1 stringByReplacingString:@"##ISONo##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"ISONo"]];
        page1=[page1 stringByReplacingString:@"##BRClosed##" withString:dicttionary[@"AgentInfo"][@"Agent"][@"BRClosed"]];
        page1=[page1 stringByReplacingString:@"##IntermediaryName##" withString:agentName];
        
        page1=[page1 stringByReplacingString:@"##AgentCode2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##LeaderCode2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##LeaderName2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##AgentContactNo2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##ISONo2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##BRClosed2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##IntermediaryName2##" withString:@""];
        page1=[page1 stringByReplacingString:@"##shareAgent##" withString:@"◻︎"];
    }else{
        for (NSDictionary *dict in dicttionary[@"AgentInfo"][@"Agent"]) {
            if ([dict[@"ID"] isEqualToString:@"1"]) {
                page1=[page1 stringByReplacingString:@"##AgentCode##" withString:dict[@"AgentCode"]];
                page1=[page1 stringByReplacingString:@"##LeaderCode##" withString:dict[@"LeaderCode"]];
                page1=[page1 stringByReplacingString:@"##LeaderName##" withString:dict[@"LeaderName"]];
                page1=[page1 stringByReplacingString:@"##AgentContactNo##" withString:dict[@"AgentContactNo"]];
                page1=[page1 stringByReplacingString:@"##ISONo##" withString:dict[@"ISONo"]];
                page1=[page1 stringByReplacingString:@"##BRClosed##" withString:dict[@"BRClosed"]];
                page1=[page1 stringByReplacingString:@"##IntermediaryName##" withString:dicttionary[@"eCFFInfo"][@"IntermediaryName"]];
            }else{
                page1=[page1 stringByReplacingString:@"##AgentCode2##" withString:dict[@"AgentCode"]];
                page1=[page1 stringByReplacingString:@"##LeaderCode2##" withString:dict[@"LeaderCode"]];
                page1=[page1 stringByReplacingString:@"##LeaderName2##" withString:dict[@"LeaderName"]];
                page1=[page1 stringByReplacingString:@"##AgentContactNo2##" withString:dict[@"AgentContactNo"]];
                page1=[page1 stringByReplacingString:@"##ISONo2##" withString:dict[@"ISONo"]];
                page1=[page1 stringByReplacingString:@"##BRClosed2##" withString:dict[@"BRClosed"]];
                page1=[page1 stringByReplacingString:@"##IntermediaryName2##" withString:dict[@"iAgentName"]];
                page1=[page1 stringByReplacingString:@"##shareAgent##" withString:@"◼︎"];
            }
        }
    }
    
    
    page1=[page1 stringByReplacingString:@"##agency##" withString:@"◻︎"];
    page1=[page1 stringByReplacingString:@"##policyNo##" withString:@""];
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page1=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page1];
    return page1;
}
@end
