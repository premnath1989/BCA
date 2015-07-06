//
//  ExistingSavingAndInvestmentPlans.h
//  iMobile Planner
//
//  Created by Juliana on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"//bug 2609

@interface ExistingSavingAndInvestmentPlans : UITableViewController<UITextFieldDelegate, SIDateDelegate>

- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *PolicyOwner;
@property (weak, nonatomic) IBOutlet UITextField *Company;
@property (weak, nonatomic) IBOutlet UITextField *TypeOfPlan;

@property (weak, nonatomic) IBOutlet UITextView *Purpose;

@property (weak, nonatomic) IBOutlet UITextField *Premium;
//@property (weak, nonatomic) IBOutlet UITextField *CommDate;
@property (weak, nonatomic) IBOutlet UITextField *AmountMaturity;

@property(nonatomic, assign) int rowToUpdate;

- (IBAction)doPremium:(id)sender;
- (IBAction)doAmountMaturity:(id)sender;

//fixed bug 2609 start
@property (strong, nonatomic) IBOutlet UITextField *CommDate;
- (IBAction)actionForCommDate:(id)sender;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
//fixed bug 2609 end


- (IBAction)doDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;

@end
