//
//  BasicPlanHandler.h
//  HLA Ipad
//
//  Created by shawal sapuan on 10/3/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicPlanHandler : NSObject

@property (nonatomic, retain) NSString *storedSINo;
@property (nonatomic ,assign ,readwrite) int storedAge;
@property (nonatomic, retain) NSString *storedOccpCode;
@property (nonatomic ,assign ,readwrite) int storedCovered;
@property (nonatomic, retain) NSString *storedbasicSA;
@property (nonatomic, retain) NSString *storedbasicHL;
@property (nonatomic ,assign ,readwrite) int storedMOP;
@property (nonatomic, retain) NSString *storedPlanCode;
@property (nonatomic ,assign ,readwrite) int storedAdvance;

-(id) initWithSI:(NSString *)aaSINo andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andCovered:(int)aaCovered andBasicSA:(NSString *)aaBasicSA andBasicHL:(NSString *)aaBasicHL andMOP:(int)aaMOP andPlanCode:(NSString *)aaPlanCode andAdvance:(int)aaAdvance;


@end
