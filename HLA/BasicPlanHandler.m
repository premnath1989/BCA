//
//  BasicPlanHandler.m
//  HLA Ipad
//
//  Created by shawal sapuan on 10/3/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "BasicPlanHandler.h"

@implementation BasicPlanHandler
@synthesize storedSINo,storedAge,storedOccpCode,storedCovered,storedPlanCode,storedMOP,storedbasicSA,storedbasicHL,storedAdvance;


-(id)initWithSI:(NSString *)aaSINo andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andCovered:(int)aaCovered andBasicSA:(NSString *)aaBasicSA andBasicHL:(NSString *)aaBasicHL andMOP:(int)aaMOP andPlanCode:(NSString *)aaPlanCode andAdvance:(int)aaAdvance
{
    self = [super init];
    if(self) {
        self.storedSINo = aaSINo;
        self.storedAge = aaAge;
        self.storedOccpCode = aaOccpCode;
        self.storedCovered = aaCovered;
        self.storedbasicSA = aaBasicSA;
        self.storedbasicHL = aaBasicHL;
        self.storedMOP = aaMOP;
        self.storedPlanCode = aaPlanCode;
        self.storedAdvance = aaAdvance;
    }
    return self;
}

@end
