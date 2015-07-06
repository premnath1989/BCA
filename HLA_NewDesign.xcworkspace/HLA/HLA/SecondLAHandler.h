//
//  SecondLAHandler.h
//  HLA Ipad
//
//  Created by shawal sapuan on 12/23/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondLAHandler : NSObject

@property (nonatomic ,assign ,readwrite) int storedIndexNo;
@property (nonatomic, retain) NSString *storedSmoker;
@property (nonatomic, retain) NSString *storedSex;
@property (nonatomic, retain) NSString *storedDOB;
@property (nonatomic ,assign ,readwrite) int storedAge;
@property (nonatomic, retain) NSString *storedOccpCode;

-(id) initWithIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode;

@end
