//
//  ScheduleViewController.h
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *BtnBack;
@property (weak, nonatomic) IBOutlet UITextField *txtTanggal;
@property (weak, nonatomic) IBOutlet UIButton *BtnTanggal;
@property (weak, nonatomic) IBOutlet UITextField *txtWaktu;
@property (weak, nonatomic) IBOutlet UIButton *btnWaktu;
@property (weak, nonatomic) IBOutlet UITextView *txtCatatan;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)actionBack:(id)sender;
- (IBAction)actionTanggal:(id)sender;
- (IBAction)actionWaktu:(id)sender;
- (IBAction)actionSave:(id)sender;





@end
