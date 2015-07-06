//
//  SQLHandler.m
//  SQLHandler
//
//  Created by Danial D. Moghaddam on 4/25/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "SQLHandler.h"
#include "FMDB.h"
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@implementation SQLHandler
-(NSString *)getNationalityByCode:(NSString *)nationalityCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT NationDesc FROM eProposal_Nationality WHERE NationCode='%@'",nationalityCode]];
    
}
-(NSString *)getReligionByCode:(NSString *)reliogionCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT ReligionDesc FROM eProposal_Religion  WHERE ReligionCode='%@'",reliogionCode]];
}
-(NSString *)getOccupationByCode:(NSString *)occupationCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp WHERE OccpCode='%@'",occupationCode]];
}
-(NSString *)getRelationByCode:(NSString *)relationCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT RelDesc FROM eProposal_Relation WHERE RelCode='%@'",relationCode]];
}
-(NSString *)getCountryByCode:(NSString *)countryCode
{
     return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode='%@'",countryCode]];
}
-(NSString *)getStateByCode:(NSString *)stateCode
{
     return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT StateDesc FROM eProposal_State WHERE StateCode='%@'",stateCode]];
}

-(NSString *)sQLQueryHandler:(NSString *)query
{
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"hladb" ofType:@"sqlite"];
    NSString *dbPath = self.dbPath;
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return @"Error";
    }
    FMResultSet *rs = [db executeQuery:query];
    NSString *result=@"";
    while ([rs next]) {
        result = [rs stringForColumnIndex:0];
    }
    return result;
}
-(void)loadSQLFileWithPath:(NSString *)path
{
    self.dbPath = [[NSString alloc]initWithString:path];
}
@end
