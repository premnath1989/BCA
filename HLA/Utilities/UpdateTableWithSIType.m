//
//  UpdateDatabase.m
//  iMobile Planner
//
//  Created by CK Quek on 6/12/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "UpdateTableWithSIType.h"

@implementation UpdateTableWithSIType


+(void)addSITypeColumn:(NSString*)databasePath {
    sqlite3_stmt *statement;
    sqlite3 *contactDB = nil;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSLog(@"Checking if SIType exists in table Trad_Sys_Profile");
        NSString *querySQL = @"SELECT SIType FROM Trad_Sys_Profile";
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"Column SIType exists in table Trad_Sys_Profile");
            sqlite3_finalize(statement);
        } else {
            querySQL = @"ALTER TABLE Trad_Sys_Profile ADD COLUMN SIType VARCHAR (25)";
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"DONE adding column SIType to table Trad_Sys_Profile");
                    [self populateSITypeColumn:contactDB];
                } else {
                    NSLog(@"FAILED to add column SIType to table Trad_Sys_Profile");
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(contactDB);
    }
}

+(void)populateSITypeColumn:(sqlite3 *)contactDB {
    sqlite3_stmt *statement;
    sqlite3_stmt *updateStatement;
    NSArray *ES_Rider = [[NSArray alloc] initWithObjects:@"UV", @"UP", nil];
    NSString *querySQL = @"SELECT PlanCode FROM Trad_Sys_Profile";
    NSString *updateQuery;
    NSString *planCode;
    NSString *SIType;
    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            planCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            SIType = @"TRAD";
            for (int i=ES_Rider.count; --i>=0; ) {
                if ([planCode isEqualToString:[ES_Rider objectAtIndex:i]]) {
                    SIType = @"ES";
                    break;
                }
            }
            updateQuery = [[NSString alloc] initWithFormat:@"UPDATE Trad_Sys_Profile SET SIType='%@' WHERE PlanCode='%@'", SIType, planCode];
            if (sqlite3_prepare_v2(contactDB, [updateQuery UTF8String], -1, &updateStatement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(updateStatement) == SQLITE_DONE) {
                    NSLog(@"Successfully added SIType %@ for PlanCode %@", SIType, planCode);
                } else {
                    NSLog(@"Unable to update PlanCode %@ with SIType %@", planCode,SIType);
                }
            }
        }
        sqlite3_finalize(statement);
        sqlite3_finalize(updateStatement);
    }
    
}

@end
