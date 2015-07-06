//
//  PayorHandler.m
//  HLA Ipad
//
//  Created by shawal sapuan on 12/22/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PayorHandler.h"

@implementation PayorHandler

@synthesize storedIndexNo,storedSmoker,storedSex,storedDOB,storedAge,storedOccpCode;

-(id)initWithIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode
{
    self = [super init];
    if(self) {
        self.storedIndexNo = aaIndexNo;
        self.storedSmoker = aaSmoker;
        self.storedSex = aaSex;
        self.storedDOB = aaDOB;
        self.storedAge = aaAge;
        self.storedOccpCode = aaOccpCode;
    }
    return self;
}



@end
