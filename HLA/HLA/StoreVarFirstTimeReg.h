//
//  StoreVar.h
//  iMobile Planner
//
//  Created by Edwin Fong on 12/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreVarFirstTimeReg : NSObject

//agentCode,agentName,leaderCode,leaderName,icNo,contractDate;
@property (nonatomic) NSString *agentLogin;
@property (nonatomic) NSString *agentCode;
@property (nonatomic) NSString *agentName;
@property (nonatomic) NSString *icNo;
@property (nonatomic) NSString *contractDate;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *address1;
@property (nonatomic) NSString *address2;
@property (nonatomic) NSString *address3;
@property (nonatomic) NSString *postalCode;
@property (nonatomic) NSString *stateCode;
@property (nonatomic) NSString *countryCode;
@property (nonatomic) NSString *agentStatus;
@property (nonatomic) NSString *leaderCode;
@property (nonatomic) NSString *leaderName;
@property (nonatomic) NSString *agentContactNumber;

+(id)sharedInstance;

@end
