//
//  pending.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PendingVCCell.h"
#import <sqlite3.h>
#import "MBProgressHUD.h"
#import "ClearData.h"


static const int XML_TYPE_GET_APP_VERSION = 100;
static const int XML_TYPE_GET_SUBMISSION_VALUE = 101;

static const int XML_TYPE_GET_AGENT_INFO = 100; //to check on login when the device is online
static const int XML_TYPE_VALIDATE_AGENT = 101; //check on registering device
static const int XML_TYPE_CHECK_APP_VERS = 102; //check app vers
static const int XML_TYPE_VALIDATE_LOGIN = 103;
static const NSString* KEY_BAD_ATTEMPTS = @"badAttempts";
static const NSString* KEY_AGENT_STATUS = @"agentStatus";
static const NSString* KEY_LAST_SYNC_DATE = @"lastSyncDate";
@interface pendingVC : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    NSString *EncryptedPassPhrase;
    NSString *EncryptedSaltValue;
    NSString *EncryptedHashAlgorithm;
    NSString *EncryptedPasswordIteration;
    NSString *EncryptedInitialationVector;
    NSString *EncryptedKeySize;
    
    NSString *DecryptedPassPhrase;
    NSString *DecryptedSaltValue;
    NSString *DecryptedHashAlgorithm;
    NSString *DecryptedPasswordIteration;
    NSString *DecryptedInitialationVector;
    NSString *DecryptedKeySize;
    
    NSString *LoginErrorDescription;
    NSString *Failedattempts;
    NSString *AgentCode;
    NSString *SuccessString;
    NSString *LocalEappVersion;

    
    int xmlType;
    int xmlTypeVersion;

    MBProgressHUD *HUD;
    
    NSString *ProposalNo;
	BOOL isFirstDevice;
     NSString *stateCode;
    sqlite3 *contactDB;
    
    NSMutableArray *ItemToBeDeleted;
     NSMutableArray *indexPaths;
    
    BOOL lastSelectedIndexPath;
    
    
    
}

@property (nonatomic, assign) int statusLogin;
@property (nonatomic, assign) int indexNo;

@property(nonatomic,strong)NSMutableArray *cellSelected;

//Login View
@property (weak, nonatomic) IBOutlet UITextField *logintextField;
@property (weak, nonatomic) IBOutlet UITextField *ipasswordTextField;
@property (nonatomic, copy) NSString *agentPortalPassword;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *loginOuterView;
@property (weak, nonatomic) IBOutlet UIButton *loginSubmitButton;
@property (weak, nonatomic) IBOutlet UIButton *loginCloseButton;

@property (weak, nonatomic) IBOutlet UITableView *pendingTableVew;

@property (weak, nonatomic) IBOutlet UIButton *submitCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;

@property (weak, nonatomic) IBOutlet UITextField *policyOwnerField;
@property (weak, nonatomic) IBOutlet UITextField *idNoTextField;


@property(strong) NSDictionary *submittedvaluedic;
@property BOOL isSaveDoc;
@property BOOL isSave;
@property(strong) NSDictionary *updateresubdic;

@property(strong) NSString *previousElementName,*LocalEappVersion;
@property(strong) NSString *elementName;
@property(strong) NSDictionary *svdata;
@property(strong) NSDictionary *Logindata;
@property(strong) NSDictionary *sversion;
@property(strong) NSDictionary *fproposaldata;

@property (nonatomic, strong) UILabel *time_display;



- (IBAction)submitCancelButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)resetButtonClicked:(id)sender;

- (IBAction)btnDeletePressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;


-(IBAction)loginSubmit:(id)sender;
-(IBAction)loginViewCancel:(id)sender;
@end
