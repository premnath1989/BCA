//
//  StoreVar.m
//  iMobile Planner
//
//  Created by Edwin Fong on 12/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "StoreVarFirstTimeReg.h"

@implementation StoreVarFirstTimeReg

@synthesize agentLogin,agentCode,agentName,leaderCode,leaderName,icNo,contractDate;

static StoreVarFirstTimeReg *myInstance = nil;

+ (StoreVarFirstTimeReg *) sharedInstance{
    
    if(myInstance == nil){
        myInstance = [[[self class] alloc] init];
        myInstance.agentLogin = @"";
        myInstance.agentCode = @"";
        myInstance.agentName = @"";
        myInstance.icNo = @"";
        myInstance.contractDate = @"";  
        myInstance.email = @"";
        myInstance.address1 = @"";
        myInstance.address2 = @"";
        myInstance.address3 = @"";
        myInstance.postalCode = @"";
        myInstance.stateCode = @"";
        myInstance.countryCode = @""; 
        myInstance.agentStatus = @"";  
        myInstance.leaderCode = @"";
        myInstance.leaderName = @"";
        myInstance.agentContactNumber = @"";
    }
    
    return myInstance;
}



@end
