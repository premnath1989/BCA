//
//  SIUtilities.h
//  iMobile Planner
//
//  Created by shawal sapuan on 5/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"


@interface SIUtilities : NSObject

+(BOOL)makeDBCopy:(NSString *)path;
+(BOOL)addColumnTable:(NSString *)table column:(NSString *)columnName type:(NSString *)columnType dbpath:(NSString *)path;
+(BOOL)updateTable:(NSString *)table set:(NSString *)column value:(NSString *)val where:(NSString *)param equal:(NSString *)val2 dbpath:(NSString *)path;
+(BOOL)createTableCFF:(NSString *)path;
+(BOOL)createTableeApp:(NSString *)path;
+(BOOL)UPDATETrad_Sys_Medical_Comb:(NSString *)path;
+(BOOL)InstallUpdate:(NSString *)path;
+(NSString *)WSLogin;

@end
