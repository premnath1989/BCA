//
//  PRHtmlHandler.h
//  PDF
//
//  Created by Travel Chu on 3/12/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRSQLHelper.h"


@interface PRHtmlHandler : NSObject
@property (strong,nonatomic) NSString *htmlStr;
@property (nonatomic, strong) NSMutableDictionary *pageTopDict;
@property (nonatomic, strong) NSData *siXMLata;
@property (nonatomic) int pageCount;
@property (nonatomic) int currentPage;
@property (nonatomic) float top;
@property (nonatomic, strong) PRSQLHelper *sqlHandler;

-(NSString*)htmlStringWithDictionary:(NSDictionary*)dict;
-(NSURL*)baseURL;
-(NSString*)increasePositoinWithHeight:(float)height forString:(NSString*)str;
-(NSString*)handleWatermarkForString:(NSString*)page;
+(PRHtmlHandler*)sharedPRHtmlHandler;
@end
