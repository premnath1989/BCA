
//
//  Login.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Reachability.h"

@protocol LoginDelegate
- (void)Dismiss: (NSString *)ViewToBePresented;
@end

static const int XML_TYPE_GET_AGENT_INFO = 100; //to check on login when the device is online
static const int XML_TYPE_VALIDATE_AGENT = 101; //check on registering device
static const int XML_TYPE_GET_APP_INFO = 102; //check app info

static NSString* KEY_BAD_ATTEMPTS = @"badAttempts";
static NSString* KEY_AGENT_STATUS = @"agentStatus";
static NSString* KEY_AGENT_CODE = @"agentCode";
static NSString* KEY_LAST_SYNC_DATE = @"lastSyncDate";
static NSString* KEY_LAST_CHECK_DEVICE_DATE = @"lastCheckDeviceDate";
static NSString* KEY_DEVICE_STATUS = @"deviceStatus";

static NSString* APP_TYPE_IRECRUIT = @"IRECRUIT";
static NSString* APP_TYPE_ISALES = @"ISALES";
static NSString* APP_TYPE_IM_SOLUTIONS = @"IPAD";
static NSString* APP_TYPE_HLA_FAST = @"HLA_FAST";

static NSString* DATE_FORMAT = @"yyyy-MM-dd";


@interface Login : UIViewController<NSXMLParserDelegate, UITextFieldDelegate>
{
    NSString *databasePath;
    NSString *RatesDatabasePath;
	NSString *UL_RatesDatabasePath;
    NSString *CommDatabasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
	id<LoginDelegate> _delegate;
	Reachability *internetReachableFoo;
	BOOL isFirstDevice;
    NSString *status;
    NSInteger badAttempts;
    NSString *error;
    NSString *agentInfo;
    
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
    
    NSString *statusDesc;
    NSString *loginDate;
    NSString *deviceStatus;
    
    NSString *currentVers;
    NSString *lastUpdateDate;
    NSString *obsoleteVersNo;
    NSString *obsoleteDate;
    NSString *licenseStatus;
        
    int xmlType;
    
    BOOL showLogout;
}



@property (nonatomic, strong) id<LoginDelegate> delegate;

@property (nonatomic, assign) int statusLogin;
@property (nonatomic, assign) int indexNo;
@property (nonatomic, copy) NSString *agentID;
@property (nonatomic, copy) NSString *agentPortalLoginID;
@property (nonatomic, copy) NSString *agentPortalPassword;
@property (nonatomic, copy) NSString *agentCode;
@property (nonatomic, copy) NSString *msg;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblForgotPwd;
@property (strong, nonatomic) IBOutlet UILabel *labelVersion;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdated;
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

- (IBAction)btnLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletLogin;

-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;
- (IBAction)btnReset:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletReset;

+(NSString *)getLabelVersion;

-(void)doOnceADayCheck:(BOOL)debugF;


+(bool)forSMPD_Acturial:(NSString*) password;


+(void)setFirstDevice;

@end
