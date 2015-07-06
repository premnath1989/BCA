//
//  PRSQLHelper.h
//  PDFCreater
//
//  Created by Travel Chu on 4/28/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRSQLHelper : NSObject
-(void)loadSQLFileWithPath:(NSString *)path;
-(NSString *)getNationalityByCode:(NSString *)nationalityCode;
-(NSString *)getReligionByCode:(NSString *)reliogionCode;
-(NSString *)getOccupationByCode:(NSString *)occupationCode;
-(NSString *)getRelationByCode:(NSString *)relationCode;
-(NSString *)getCountryByCode:(NSString *)countryCode;
-(NSString *)getStateByCode:(NSString *)stateCode;
-(NSString *)getBankByCode:(NSString *)stateCode;
-(NSString *)getTitleByCode:(NSString *)titleCode;
-(NSString *)getQuestionByCode:(NSString *)QuestionCode;
-(NSString *)getNationalityByDesc:(NSString *)nationalityDesc;
-(NSString *)getPlanByCode:(NSString *)planCode;
-(NSString *)getRiderByCode:(NSString *)riderCode;
@property (strong,nonatomic) NSString *dbPath;
@end
