//
//  Cleanup.h
//  iMobile Planner
//
//  Created by CK Quek on 4/15/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"

@interface Cleanup : NSObject

@property (nonatomic, retain) NSString *databasePath;
@property (nonatomic, assign) sqlite3 *contactDB;

-(BOOL)deleteAllSIUsingCustomerID:(NSString*)cid;
-(BOOL)deleteSpecificSIUsingSINo:(NSString*)siNo;
-(BOOL)deleteSIUsingSINo:(NSString*)siNo;
-(BOOL)deleteDataUsingSINo:(NSString*)siNo AndTable:(NSString*)table;
@end
