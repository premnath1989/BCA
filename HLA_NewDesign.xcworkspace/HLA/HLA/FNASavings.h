//
//  FNASavings.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavingsPlans.h"

@interface FNASavings : UITableViewController<UITextFieldDelegate,SavingsPlansDelegate>{
    bool hasSavings;
}

@property (weak, nonatomic) IBOutlet UIButton *SavingPlans;
@property(nonatomic, assign) BOOL SavingsSelected;
- (IBAction)SavingsPlansBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *plan1;
@property (weak, nonatomic) IBOutlet UILabel *plan2;
@property (weak, nonatomic) IBOutlet UILabel *plan3;


@property (weak, nonatomic) IBOutlet UITextField *current1;
- (IBAction)current1Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *required1;
- (IBAction)required1Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *difference1;
@property (weak, nonatomic) IBOutlet UITextField *customerAlloc;
- (IBAction)customerAllocAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


-(void)CalcualeDifference;

@end
