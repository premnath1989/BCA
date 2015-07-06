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

@interface SettingSecurityQuestion : UIViewController<UITextFieldDelegate,SecurityQuesTbViewControllerDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    UIPopoverController *popOverConroller;
    
    BOOL selectOne;
    BOOL selectTwo;
    BOOL selectThree;
}

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


- (IBAction)btnQues1:(id)sender;
- (IBAction)btnQues2:(id)sender;

- (IBAction)btnQues3:(id)sender;

- (IBAction)ActionClose:(id)sender;
- (IBAction)doSave:(id)sender;

@end
