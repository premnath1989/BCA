//
//  LoginVar.h
//  Mobile Login
//
//  Created by Edwin Fong on 4/3/14.
//  Copyright (c) 2014 Hong Leong Assurance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVar : NSObject

@property (nonatomic, strong) NSString *agentCode;
@property (nonatomic, strong) NSString *agentName;
@property (nonatomic, strong) NSString *immediateLeaderCode;
@property (nonatomic, strong) NSString *immediateLeaderName;
@property (nonatomic, strong) NSString *agentEmail;
@property (nonatomic, strong) NSString *agentLoginId;
@property (nonatomic, strong) NSString *agentIcNo;
@property (nonatomic, strong) NSString *agentContractDate;
@property (nonatomic, strong) NSString *agentAddr1;
@property (nonatomic, strong) NSString *agentAddr2;
@property (nonatomic, strong) NSString *agentAddr3;
@property (nonatomic, strong) NSString *agentAddrPostcode;
@property (nonatomic, strong) NSString *agentContactNumber;
@property (nonatomic, strong) NSString *agentPassword;
@property (nonatomic, strong) NSString *lastLogonDate;
@property (nonatomic, strong) NSString *lastLogoutDate;
@property (nonatomic, strong) NSString *channel;

@end
