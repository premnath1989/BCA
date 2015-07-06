//
//  PRPage12.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage12.h"
#import "PRHtmlHandler.h"

@implementation PRPage12
+(NSString*)prPage12WithDictionary:(NSDictionary*)dicttionary{
    NSString *page12=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page12" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    
        NSString *PC = dicttionary[@"FATCAInfo"][@"FATCA"][@"PersonChoice"];
        
        if ([PC isEqualToString:@"1"]) {
            page12=[page12 stringByReplacingString:@"##PersonChoice.1##" withString:@"◼︎"];
        }
        else if ([PC isEqualToString:@"2"]) {
            page12=[page12 stringByReplacingString:@"##PersonChoice.2##" withString:@"◼︎"];
        }
        else if ([PC isEqualToString:@"3"]) {
            page12=[page12 stringByReplacingString:@"##PersonChoice.3##" withString:@"◼︎"];
        }
    
    
    
    page12=[page12 stringByReplacingString:@"##PersonChoice.1##" withString:@"◻︎"];
    page12=[page12 stringByReplacingString:@"##PersonChoice.2##" withString:@"◻︎"];
    page12=[page12 stringByReplacingString:@"##PersonChoice.3##" withString:@"◻︎"];

    
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page12=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page12];
    return page12;
}
@end
