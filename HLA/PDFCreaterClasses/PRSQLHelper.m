//
//  SQLHandler.m
//  SQLHandler
//
//  Created by Danial D. Moghaddam on 4/25/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "PRSQLHelper.h"
#include "FMDB.h"
#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

@implementation PRSQLHelper
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

-(NSString *)getBankByCode:(NSString *)bankCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT CompanyName FROM eProposal_Credit_Card_Bank WHERE CompanyCode='%@'",bankCode]];
}

-(NSString *)getTitleByCode:(NSString *)titleCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT TitleDesc FROM eproposalTitle WHERE TitleCode='%@'",titleCode]];
}

-(NSString *)getQuestionByCode:(NSString *)QuestionCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT QuestionNo FROM eproposal_Question WHERE QnID='%@'",QuestionCode]];
}


-(NSString *)getNationalityByDesc:(NSString *)nationalityDesc
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT NationCode FROM eProposal_Nationality WHERE NationDesc='%@'",nationalityDesc]];
}

-(NSString *)getPlanByCode:(NSString *)planCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT PlanName FROM Trad_Sys_Profile WHERE PlanCode='%@'",planCode]];
}

-(NSString *)getRiderByCode:(NSString *)riderCode
{
    return [self sQLQueryHandler:[NSString stringWithFormat:@"SELECT RiderDesc FROM Trad_Sys_Rider_Profile WHERE RiderCode='%@'",riderCode]];
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
    NSString *result=@"Not Found";
    result=@"";
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
