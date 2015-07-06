//
//  ExistingChildrenEducationPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"//bug 2608

@interface ExistingChildrenEducationPlans : UITableViewController<UITextFieldDelegate, SIDateDelegate>
- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *ChildName;
@property (weak, nonatomic) IBOutlet UITextField *Company;
@property (weak, nonatomic) IBOutlet UITextField *Premium;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Frequency;
//@property (weak, nonatomic) IBOutlet UITextField *StartDate;
//@property (weak, nonatomic) IBOutlet UITextField *MaturityDate;
@property (weak, nonatomic) IBOutlet UITextField *ProjectedValue;

@property(nonatomic, assign) int rowToUpdate;

//fixed bug 2608 start
@property (strong, nonatomic) IBOutlet UITextField *startDateLbl;
@property (strong, nonatomic) IBOutlet UITextField *maturityDateLbl;
//@property (strong, nonatomic) IBOutlet UILabel *startDateLbl;
//@property (strong, nonatomic) IBOutlet UILabel *maturityDateLbl;
- (IBAction)actionForStartDate:(id)sender;
- (IBAction)actionForMaturityDate:(id)sender;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) SIDate *SIDate2;
@property (nonatomic, retain) UIPopoverController *SIDatePopover2;
@property int btn;
//fixed bug 2608 end


- (IBAction)PremiumAction:(id)sender;
- (IBAction)ProjectedValueAction:(id)sender;


- (IBAction)doDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;

@end
