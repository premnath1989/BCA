//
//  ChangePassword.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PasswordTips.h"

@interface ChangePassword : UIViewController<PasswordTipDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UIPopoverController *_PasswordTipPopover;
    PasswordTips *_PasswordTips;
}

@property (nonatomic, assign,readwrite) int userID;
@property (nonatomic, retain) UIPopoverController *PasswordTipPopover;
@property (nonatomic, retain) PasswordTips *PasswordTips;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPwd;
- (IBAction)btnChange:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletSave;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;


@property (nonatomic, copy) NSString *passwordDB;
@property (weak, nonatomic) IBOutlet UIButton *outletTips;
@property (weak, nonatomic) IBOutlet UILabel *lblTips;


- (IBAction)btnTips:(id)sender;

@end
