//
//  FNAProtection.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtectionPlans.h"

@interface FNAProtection : UITableViewController<UITextFieldDelegate,ProtectionPlansDelegate>{
    bool hasProtection;
}
@property (weak, nonatomic) IBOutlet UIButton *ProtectionPlans;
@property(nonatomic, assign) BOOL ProtectionSelected;
- (IBAction)ProtectionPlansBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *current1;
@property (strong, nonatomic) IBOutlet UITextField *required1;
@property (weak, nonatomic) IBOutlet UITextField *difference1;
- (IBAction)current1Action:(id)sender;
- (IBAction)required1Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current2;
@property (weak, nonatomic) IBOutlet UITextField *required2;
@property (weak, nonatomic) IBOutlet UITextField *difference2;
- (IBAction)current2Action:(id)sender;
- (IBAction)required2Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current3;
@property (weak, nonatomic) IBOutlet UITextField *required3;
@property (weak, nonatomic) IBOutlet UITextField *difference3;

- (IBAction)current3Action:(id)sender;
- (IBAction)required3Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current4;
@property (weak, nonatomic) IBOutlet UITextField *required4;
@property (weak, nonatomic) IBOutlet UITextField *difference4;
- (IBAction)current4Action:(id)sender;
- (IBAction)required4Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *customerAlloc;
@property (weak, nonatomic) IBOutlet UITextField *partnerAlloc;

- (IBAction)customerAllocAction:(id)sender;
- (IBAction)partnerAllocAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *plan1;

@property (weak, nonatomic) IBOutlet UILabel *plan2;

@property (weak, nonatomic) IBOutlet UILabel *plan3;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


//@property (weak, nonatomic) BOOL *customerAlloc;

-(void)CalcualeDifference;


@end
