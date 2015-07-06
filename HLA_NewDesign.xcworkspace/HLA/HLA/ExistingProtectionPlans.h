//
//  ExistingProtectionPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataClass.h"

@class ExistingProtectionPlans;

@protocol ExistingProtectionPlansDelegate <NSObject>
//-(void)ExistingProtectionPlansDelete:(ExistingProtectionPlans *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface ExistingProtectionPlans : UITableViewController<UITextFieldDelegate>
//- (IBAction)doDone:(id)sender;
//- (IBAction)doCancel:(id)sender;

@property (nonatomic, weak) id <ExistingProtectionPlansDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *PolicyOwner;
@property (weak, nonatomic) IBOutlet UITextField *Company;
@property (weak, nonatomic) IBOutlet UITextField *TypeOfPlan;
@property (weak, nonatomic) IBOutlet UITextField *LifrAssured;
@property (weak, nonatomic) IBOutlet UITextField *DeathBenefit;
@property (weak, nonatomic) IBOutlet UITextField *DisabledBenefit;
@property (weak, nonatomic) IBOutlet UITextField *CriticalIllnessBenefit;
@property (weak, nonatomic) IBOutlet UITextField *OtherBenefit;
@property (weak, nonatomic) IBOutlet UITextField *PremiumContribution;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Mode;
@property (weak, nonatomic) IBOutlet UITextField *MaturityDate;

@property(nonatomic, assign) int rowToUpdate;


- (IBAction)doDeathBenefit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *doDisabilityBenefit;
- (IBAction)doDisabilityBenefit1:(id)sender;
- (IBAction)doCriticalIllnessBenefit:(id)sender;
- (IBAction)doOtherBenefit:(id)sender;
- (IBAction)doPremiumContribution:(id)sender;


- (IBAction)doDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;


@end
