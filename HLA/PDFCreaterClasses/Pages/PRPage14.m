//
//  PRPage14.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage14.h"
#import "PRHtmlHandler.h"

@implementation PRPage14
+(NSString*)prPage14WithDictionary:(NSDictionary*)dicttionary{
    NSString *page14=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page14" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *BC = dicttionary[@"FATCAInfo"][@"FATCA"][@"BizCategoryChoice"];
    
    if ([BC isEqualToString:@"1"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.1##" withString:@"◼︎"];
    }
    else if ([BC isEqualToString:@"2"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.2##" withString:@"◼︎"];
    }
    else if ([BC isEqualToString:@"3"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.3##" withString:@"◼︎"];
    }
    else if ([BC isEqualToString:@"4"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.4##" withString:@"◼︎"];
        NSString *FATCAClassification = dicttionary[@"FATCAInfo"][@"FATCA"][@"FATCAClassification"];
        NSString *GIIN = dicttionary[@"FATCAInfo"][@"FATCA"][@"GIIN"];
        page14=[page14 stringByReplacingString:@"##FATCAClassification##" withString:FATCAClassification];
        page14=[page14 stringByReplacingString:@"##GIIN##" withString:GIIN];                
    }
    else if ([BC isEqualToString:@"5"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.5##" withString:@"◼︎"];
        NSString *ET = dicttionary[@"FATCAInfo"][@"FATCA"][@"EntityType"];
        if ([ET isEqualToString:@"1"]) {
            page14=[page14 stringByReplacingString:@"##EntityType.1##" withString:@"◼︎"];
        }
        else if ([ET isEqualToString:@"2"])
        {
            page14=[page14 stringByReplacingString:@"##EntityType.2##" withString:@"◼︎"];
        }
        
    }
    else if ([BC isEqualToString:@"6"]) {
        page14=[page14 stringByReplacingString:@"##BizCategoryChoice.6##" withString:@"◼︎"];
    }
    
    
    
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.1##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.2##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.3##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.4##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.5##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##BizCategoryChoice.6##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##EntityType.1##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##EntityType.2##" withString:@"◻︎"];
    page14=[page14 stringByReplacingString:@"##FATCAClassification##" withString:@""];
    page14=[page14 stringByReplacingString:@"##GIIN##" withString:@""];    
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page14=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page14];
    return page14;
}
@end
