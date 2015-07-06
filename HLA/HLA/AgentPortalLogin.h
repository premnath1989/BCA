//
//  AgentPortalLogin.h
//  iMobile Planner
//
//  Created by Edwin Fong on 11/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AgentPortalLogin : UIViewController<NSXMLParserDelegate>
{
    Reachability *internetReachableFoo;
    
    NSInteger badAttempts;
    NSString *error;
    NSString *agentInfo;
    NSString *status;
    NSString *agentLogin;
    NSString *agentCode;
    NSString *agentName;
    NSString *icNo;
    NSString *contractDate;
    NSString *email;
    NSString *address1;
    NSString *address2;
    NSString *address3;
    NSString *postalCode;
    NSString *stateCode;
    NSString *countryCode;
    NSString *agentStatus;
    NSString *leaderCode;
    NSString *leaderName;
}

@property (weak, nonatomic) IBOutlet UITextField *txtAgentPortalId;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentPortalPassword;
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNext;

- (IBAction) btnLogin:(id)sender;

@end

