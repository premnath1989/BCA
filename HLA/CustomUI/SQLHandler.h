//
//  SQLHandler.h
//  SQLHandler
//
//  Created by Danial D. Moghaddam on 4/25/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLHandler : NSObject
-(void)loadSQLFileWithPath:(NSString *)path;
-(NSString *)getNationalityByCode:(NSString *)nationalityCode;
-(NSString *)getReligionByCode:(NSString *)reliogionCode;
-(NSString *)getOccupationByCode:(NSString *)occupationCode;
-(NSString *)getRelationByCode:(NSString *)relationCode;
-(NSString *)getCountryByCode:(NSString *)countryCode;
-(NSString *)getStateByCode:(NSString *)stateCode;
@property (strong,nonatomic) NSString *dbPath;
@end
