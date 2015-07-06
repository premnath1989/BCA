//
//  AgentProfile.h
//  iMobile Planner
//
//  Created by Edwin Fong on 12/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreVarFirstTimeReg.h"

@interface AgentProfile : UIViewController<NSXMLParserDelegate>
{
    NSString *deviceId;
    NSString *deviceName;
    NSString *iosVers;
    StoreVarFirstTimeReg *storeVar;
    NSString *activateStatus;
    NSString *deviceIdPassed;
    NSString *result;
    int xmlType;
}

@property (nonatomic, assign) BOOL isValidated;

@property (weak, nonatomic) IBOutlet UITextField *agentCode;
@property (weak, nonatomic) IBOutlet UITextField *agentName;
@property (weak, nonatomic) IBOutlet UITextField *leaderCode;

@property (weak, nonatomic) IBOutlet UITextField *leaderName;
@property (weak, nonatomic) IBOutlet UITextField *icNo;
@property (weak, nonatomic) IBOutlet UITextField *contractDate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnConfirm;

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

- (NSString *) getDeviceSerialNo;


@end
