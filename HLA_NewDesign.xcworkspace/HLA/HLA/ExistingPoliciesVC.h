//
//  ExistingPoliciesVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingPoliciesPersonType.h"
#import "ELP1stLifeAssuredVC.h"
#import "ELP2ndLifeAssuredVC.h"
#import "ELPPolicyOwnerVC.h"

@interface ExistingPoliciesVC : UIViewController<EPPersonTypeDelegate, UITableViewDataSource, UITableViewDelegate> {
	ELP1stLifeAssuredVC *Elp1;
	ELP2ndLifeAssuredVC *Elp2;
	ELPPolicyOwnerVC *Elppo;
	
}

//@property (weak, nonatomic) IBOutlet UIScrollView *policyView;
@property (nonatomic, retain) ExistingPoliciesPersonType *PersonTypePicker;
@property (nonatomic, retain) UIPopoverController *PersonTypePopover;
@property (strong, nonatomic) IBOutlet UIView *policyView;
- (IBAction)actionForPersonTypeView:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
