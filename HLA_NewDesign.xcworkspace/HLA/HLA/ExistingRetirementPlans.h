//
//  ExistingRetirementPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"//bug 2610


@interface ExistingRetirementPlans : UITableViewController<UITextFieldDelegate, SIDateDelegate>
- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;





@property (weak, nonatomic) IBOutlet UITextField *PolicyOwner;
@property (weak, nonatomic) IBOutlet UITextField *Company;
@property (weak, nonatomic) IBOutlet UITextField *TypeOfPlan;
@property (weak, nonatomic) IBOutlet UITextField *Premium;
//@property (weak, nonatomic) IBOutlet UITextField *StartDate;
@property (weak, nonatomic) IBOutlet UITextField *IncomeMaturity;
@property (weak, nonatomic) IBOutlet UITextField *SumMaturity;
@property (weak, nonatomic) IBOutlet UITextField *AdditionalBenefit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Frequency;
//@property (weak, nonatomic) IBOutlet UITextField *MaturityDate;


- (IBAction)doPremium:(id)sender;
- (IBAction)doProjectedLumpSum:(id)sender;
- (IBAction)doIncomeMaturity:(id)sender;


@property(nonatomic, assign) int rowToUpdate;


@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
- (IBAction)doDelete:(id)sender;

//fixed bug 2610 start
@property (strong, nonatomic) IBOutlet UITextField *StartDate;
@property (strong, nonatomic) IBOutlet UITextField *MaturityDate;
- (IBAction)actionForStartDate:(id)sender;
- (IBAction)actionForMaturityDate:(id)sender;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) SIDate *SIDate2;
@property (nonatomic, retain) UIPopoverController *SIDatePopover2;
@property int btn;
//fixed bug 2610 end


@end
