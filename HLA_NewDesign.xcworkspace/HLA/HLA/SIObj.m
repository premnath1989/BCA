//
//  SIObj.m
//  iMobile Planner
//
//  Created by ywbeh on 9/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIObj.h"

@implementation SIObj

@synthesize name;
@synthesize smoker;
@synthesize sex;
@synthesize DOB;
@synthesize age;
@synthesize ANB;
@synthesize occupationCode;
@synthesize dateModified;//currentDate
@synthesize indexNo;
@synthesize commDate;//date created
@synthesize idProfile;
@synthesize clientID;

@synthesize policyTerm;
@synthesize basicSA;
@synthesize prePayOption;
@synthesize cashDivident;
@synthesize yearlyIncome;
@synthesize advanceYearlyIncome;
@synthesize hl1kSA;
@synthesize hl1kSATerm;
@synthesize tempHL1kSA;
@synthesize temHL1KSAterm;
@synthesize updatedAt;
@synthesize partialAcc;
@synthesize partialPayout;
@synthesize siNO;
@synthesize custCode;
@synthesize ALB;
@synthesize dateCreated;
@synthesize rowID;
@synthesize ID;

-(id)init
{
    
    self = [super init];
    if (self) {
        
        self.name = nil;
        self.smoker = nil;
        self.sex = nil;
        self.DOB = nil;
        self.age = nil;
        self.ANB = nil;
        self.occupationCode = nil;
        self.dateModified = nil;//currentDate
        self.indexNo = nil;
        self.commDate = nil;//date created
        self.idProfile = nil;
        self.clientID = nil;
        
        self.policyTerm = nil;
        self.basicSA = nil;
        self.prePayOption = nil;
        self.cashDivident = nil;
        self.yearlyIncome = nil;
        self.advanceYearlyIncome = nil;
        self.hl1kSA = nil;
        self.hl1kSATerm = nil;
        self.tempHL1kSA = nil;
        self.temHL1KSAterm = nil;
        self.updatedAt = nil;
        self.partialAcc = nil;
        self.partialPayout = nil;
        self.siNO = nil;
        self.custCode = nil;
        self.ALB = nil;
        self.dateCreated = nil;
        self.rowID = nil;
        self.ID = nil;
    }
    return self;
}
@end
