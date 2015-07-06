//
//  UpdateACIRGST.m
//  iMobile Planner
//
//  Created by CK Quek on 6/23/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "UpdateACIRGST.h"

@implementation UpdateACIRGST

+(void)updateACIRMPPGST:(NSString*)databasePath {
    sqlite3_stmt *statement;
    sqlite3 *contactDB = nil;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSLog(@"Checking if ACIR_MPP exists in table Trad_Sys_Rider_Mtn");
        NSString *querySQL = @"SELECT GST FROM Trad_Sys_Rider_Mtn WHERE RiderCode='ACIR_MPP'";
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            [self updateData:contactDB];
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

+(void)updateData:(sqlite3 *)contactDB {
    sqlite3_stmt *statement;
    NSString *querySQL = @"UPDATE Trad_Sys_Rider_Mtn SET GST='1' WHERE RiderCode='ACIR_MPP'";
    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"Successfully updated GST for RiderCode ACIR_MPP");
        } else {
            NSLog(@"Unable to update GST for RiderCode ACIR_MPP");
        }
    }
    sqlite3_finalize(statement);
    
}
@end
