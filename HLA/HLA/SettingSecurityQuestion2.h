//
//  SettingSecurityQuestion.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "SecurityQuesTbViewController.h"

@interface SettingSecurityQuestion2 : UIViewController<UITextFieldDelegate,SecurityQuesTbViewControllerDelegate, UIAlertViewDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    UIPopoverController *popOverConroller;
    
    BOOL selectOne;
    BOOL selectTwo;
    BOOL selectThree;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *outletQues1;
@property (weak, nonatomic) IBOutlet UIButton *outletQues3;
@property (weak, nonatomic) IBOutlet UIButton *outletQues2;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswer1;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswer2;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswer3;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

//from popover
@property (nonatomic,copy) NSString *questOneCode;
@property (nonatomic,copy) NSString *questTwoCode;
@property (nonatomic,copy) NSString *questThreeCode;
@property (nonatomic,strong) UIPopoverController *popOverConroller;

@property (nonatomic) BOOL hideCloseButton;

- (IBAction)btnQues1:(id)sender;
- (IBAction)btnQues2:(id)sender;

- (IBAction)btnQues3:(id)sender;

- (IBAction)ActionClose:(id)sender;
- (IBAction)doSave:(id)sender;

@end
