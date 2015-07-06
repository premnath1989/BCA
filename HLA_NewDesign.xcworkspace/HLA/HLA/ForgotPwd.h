//
//  ForgotPwd.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RetreivePwdTbViewController.h"

@interface ForgotPwd : UIViewController<RetreivePwdTbViewControllerDelegate>{
    UIPopoverController *popOverConroller;
    NSString *databasePath;
    sqlite3 *contactDB;
}
@property (nonatomic,strong) id LoginID;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectQues;
@property (weak, nonatomic) IBOutlet UITextField *txtAnswer;
- (IBAction)btnRetrieve:(id)sender;
- (IBAction)btnCancel:(id)sender;

@property (nonatomic,strong) UIPopoverController *popOverConroller;


//from popover
@property (nonatomic,copy) NSString *questCode;
@property (nonatomic,copy) NSString *questDesc;
@property (nonatomic,copy) NSString *answer;
@property (nonatomic,copy) NSString *password;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusOne;
@property (weak, nonatomic) IBOutlet UILabel *lblStatusTwo;


@end
