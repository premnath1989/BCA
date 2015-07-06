//
//  UserProfile.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DateViewController.h"

@interface UserProfile : UIViewController <DateViewControllerDelegate, NSXMLParserDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    DateViewController *_DatePicker;
    UIPopoverController *_datePopover;
}
@property (nonatomic,strong) id idRequest;
@property (nonatomic, assign) int indexNo;
@property (nonatomic, assign,readwrite) int FirstTimeLogin;
@property (nonatomic,strong) id ChangePwdUsername;
@property (nonatomic,strong) id ChangePwdPassword;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentCode;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentName;
@property (weak, nonatomic) IBOutlet UITextField *txtAgentContactNo;
@property (weak, nonatomic) IBOutlet UITextField *txtLeaderCode;
@property (weak, nonatomic) IBOutlet UITextField *txtLeaderName;
@property (weak, nonatomic) IBOutlet UITextField *txtBizRegNo;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *contactNo;
@property (nonatomic, copy) NSString *leaderCode;
@property (nonatomic, copy) NSString *leaderName;
@property (nonatomic, copy) NSString *registerNo;
@property (nonatomic, copy) NSString *email;
@property (weak, nonatomic) IBOutlet UILabel *lblAgentLoginID;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletCancel;
@property (weak, nonatomic) IBOutlet UIButton *outletSave;

//--bob
@property (strong, nonatomic) IBOutlet UITextField *txtICNo;
@property (strong, nonatomic) IBOutlet UIButton *btnContractDate;
- (IBAction)btnContractDatePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr1;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr2;
@property (strong, nonatomic) IBOutlet UITextField *txtAddr3;

@property (nonatomic, retain) DateViewController *DatePicker;
@property (nonatomic, retain) UIPopoverController *datePopover;
@property (nonatomic, copy) NSString *contDate;
@property (nonatomic, copy) NSString *ICNo;
@property (nonatomic, copy) NSString *Addr1;
@property (nonatomic, copy) NSString *Addr2;
@property (nonatomic, copy) NSString *Addr3;

//--end

@property (weak, nonatomic) IBOutlet UITextField *txtAgencyPortalLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtAgencyPortalPwd;


@end
