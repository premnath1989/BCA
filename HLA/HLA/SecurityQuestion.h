//
//  SecurityQuestion.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "SecurityQuesTbViewController.h"

@interface SecurityQuestion : UIViewController<UITextFieldDelegate,SecurityQuesTbViewControllerDelegate, UIAlertViewDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    UIPopoverController *popOverConroller;
    
    BOOL selectOne;
    BOOL selectTwo;
    BOOL selectThree;
}
@property (nonatomic, assign,readwrite) int userID;
@property (nonatomic, assign,readwrite) int FirstTimeLogin;

@property (weak, nonatomic) IBOutlet UILabel *lblQuesOne;
@property (weak, nonatomic) IBOutlet UILabel *lblQuesTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestThree;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswerQ1;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswerQ2;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswerQ3;

//from popover
@property (nonatomic,copy) NSString *questOneCode;
@property (nonatomic,copy) NSString *questTwoCode;
@property (nonatomic,copy) NSString *questThreeCode;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnCancel:(id)sender;

@property (nonatomic,strong) UIPopoverController *popOverConroller;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletCancel;
@property (weak, nonatomic) IBOutlet UIButton *outletSave;
- (IBAction)btnQues1:(id)sender;
- (IBAction)btnQues2:(id)sender;
- (IBAction)btnQues3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletQues1;
@property (weak, nonatomic) IBOutlet UIButton *outletQues2;
@property (weak, nonatomic) IBOutlet UIButton *outletQues3;


@end
