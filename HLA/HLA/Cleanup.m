//
//  Cleanup.m
//  iMobile Planner
//
//  Created by CK Quek on 4/15/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Cleanup.h"

@implementation Cleanup
@synthesize databasePath;
@synthesize contactDB;

-(id)init {    
    self = [super init];    
    if (self) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        NSLog(@"INITIALIZING CLEANUP");
    }
    
    return self;
}

-(void)dealloc {
    databasePath = nil;
}

-(BOOL)deleteAllSIUsingCustomerID:(NSString*)cid {
    BOOL success = NO;
    
    sqlite3_stmt* statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        NSString *searchQuery = [NSString stringWithFormat:@"SELECT SINo FROM Trad_LAPayor WHERE CustCode='%@'", cid];
        if(sqlite3_prepare_v2(contactDB, [searchQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            NSString *SINo;
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                SINo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                success = [self deleteSIUsingSINo:SINo];
            }
            searchQuery = nil;
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
    }
    return success;
    
}

-(BOOL)deleteSpecificSIUsingSINo:(NSString *)siNo {
    BOOL success = NO;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        success = [self deleteSIUsingSINo:siNo];
        sqlite3_close(contactDB);
        
    }
    return success;
}

/** Database must be opened **/
-(BOOL)deleteSIUsingSINo:(NSString *)siNo{
    if ([self deleteDataUsingSINo:siNo AndTable:@"Trad_LAPayor"]) {
        NSLog(@"Removing SI:%@  from Trad_LAPayor",siNo);
        if ([self deleteDataUsingSINo:siNo AndTable:@"Trad_Details"]) {
            NSLog(@"Removing SI:%@  from Trad_Details",siNo);
            if ([self deleteDataUsingSINo:siNo AndTable:@"SI_Store_Premium"]) {
                NSLog(@"Removing SI:%@  from SI_Store_Premium",siNo);
                return YES;
            }
        }
        return NO;
    }
    return NO;
}

/** Database must be opened **/
-(BOOL)deleteDataUsingSINo:(NSString*)siNo AndTable:(NSString*)table{
    BOOL success = NO;
    sqlite3_stmt *statement;
    NSString *sqlQuery = [NSString stringWithFormat:@"DELETE FROM %@ WHERE SINo='%@'", table, siNo];
    if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            success = YES;
        } else {
            NSLog(@"There's some problem deleting SI(%@) from %@", siNo, table);
        }
    } else {
        NSLog(@"Could not find SINo %@ in table %@", siNo, table);
    }
    sqlQuery = nil;
    sqlite3_finalize(statement);
    
    return success;
    
}

@end
