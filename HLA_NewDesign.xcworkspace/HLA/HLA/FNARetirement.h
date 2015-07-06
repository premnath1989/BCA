//
//  FNARetirement.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetirementPlans.h"

@interface FNARetirement : UITableViewController<UITextFieldDelegate,RetirementPlansDelegate>{
    bool hasRetirement;
}
@property (weak, nonatomic) IBOutlet UIButton *retirementPlans;
@property(nonatomic, assign) BOOL RetirementSelected;
- (IBAction)retirementPlansBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current1;
@property (strong, nonatomic) IBOutlet UITextField *required1;
@property (weak, nonatomic) IBOutlet UITextField *difference1;
- (IBAction)current1Action:(id)sender;
- (IBAction)required1Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *customerAlloc;
@property (weak, nonatomic) IBOutlet UITextField *partnerAlloc;
- (IBAction)customerAllocAction:(id)sender;
- (IBAction)partnerAllocAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *customerRely;
@property (weak, nonatomic) IBOutlet UITextField *partnerRely;
- (IBAction)customerRelyAction:(id)sender;
- (IBAction)partnerRelyAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *plan1;

@property (weak, nonatomic) IBOutlet UILabel *plan2;

@property (weak, nonatomic) IBOutlet UILabel *plan3;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

-(void)CalcualeDifference;

@end
