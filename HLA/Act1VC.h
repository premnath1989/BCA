//
//  Act1VC.h
//  iMobile Planner
//
//  Created by Emi on 17/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Act1VC : UIViewController



@property (weak, nonatomic) IBOutlet UINavigationItem *BarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnReject;
@property (weak, nonatomic) IBOutlet UIButton *btnSchedule;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UIButton *Act1;
@property (weak, nonatomic) IBOutlet UIButton *Act2;
@property (weak, nonatomic) IBOutlet UIButton *Act3;
@property (weak, nonatomic) IBOutlet UIButton *Act4;
@property (weak, nonatomic) IBOutlet UIButton *Act5;

@property (weak, nonatomic) IBOutlet UILabel *descLbl;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnSave:(id)sender;
- (IBAction)btnNext:(id)sender;
- (IBAction)btnSchedule:(id)sender;
- (IBAction)btnReject:(id)sender;

-(void)ChangeState;

@end
