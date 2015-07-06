//
//  SettingUserProfile.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DateViewController.h"

@interface SettingUserProfileReg2 : UIViewController <DateViewControllerDelegate, UITextFieldDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    DateViewController *_DatePicker;
    UIPopoverController *_datePopover;
    UIAlertView *rrr;
    BOOL PostcodeCont;
    BOOL isFromFirstTime;
}

@property (nonatomic,strong) id idRequest;
@property (nonatomic, assign) int indexNo;

@property (weak, nonatomic) IBOutlet UILabel *lblAgentLoginID;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentId;

@property (weak, nonatomic) IBOutlet UITextField *txtAgentCode;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentName;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentContactNo;
@property (weak, nonatomic) IBOutlet UITextField *txtLeaderCode;
@property (weak, nonatomic) IBOutlet UITextField *txtLeaderName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtHomePostCode;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeTown;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeState;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeCountry;


@property (weak, nonatomic) IBOutlet UITextField *txtBixRegNo;


@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contactNo;
@property (nonatomic, copy) NSString *leaderCode;
@property (nonatomic, copy) NSString *leaderName;
@property (nonatomic, copy) NSString *registerNo;
@property (nonatomic, copy) NSString *email;
@property (weak, nonatomic) IBOutlet UIButton *outletSave;

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

- (IBAction)btnClose:(id)sender;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnDone:(id)sender;
- (IBAction)btnBack:(id)sender;

//--bob
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtICNo;
@property (strong, nonatomic) IBOutlet UIButton *btnContractDate;
- (IBAction)btnContractDatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr1;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr2;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr3;
@property (weak, nonatomic) IBOutlet UITextField *txtContractDate;

@property (nonatomic, retain) DateViewController *DatePicker;
@property (nonatomic, retain) UIPopoverController *datePopover;
@property (nonatomic, copy) NSString *contDate;
@property (nonatomic, copy) NSString *ICNo;
@property (nonatomic, copy) NSString *Addr1;
@property (nonatomic, copy) NSString *Addr2;
@property (nonatomic, copy) NSString *Addr3;
@property (nonatomic, copy) NSString *AgentPortalLoginID;
@property (nonatomic, copy) NSString *AgentPortalPassword;
@property (nonatomic, copy) NSString *AgentAddrPostcode;
@property (nonatomic, copy) NSString *AgentContactNumber;
@property (nonatomic, copy) NSString *getLatest;
@property (nonatomic, copy) NSString *SelectedStateCode;
//--end

@property (weak, nonatomic) IBOutlet UITextField *txtAgencyPortalLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtAgencyPortalPwd;


@end
