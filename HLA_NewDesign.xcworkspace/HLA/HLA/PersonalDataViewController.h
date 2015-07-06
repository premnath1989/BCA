//
//  PersonalDataViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PersonalDetialsViewController.h"
#import "CustomerViewController.h"
//#import "ChildrenViewController.h"
#import "ChildrenandDependents.h"
#import "SelectPartner.h"
#import "PartnerClientProfile.h"
#import "ChildrenDependents.h"


@interface PersonalDataViewController : UITableViewController <PersonalDetialsViewControllerDelegate,SelectPartnerDelegate,PartnerClientProfileDelegate,ChildrenDependentsDelegate>{
    int showCustomer;
    int showSpouse;
    int showChildren;
}




@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *spouseName;


@property (weak, nonatomic) IBOutlet UILabel *addSpouseTitle;
@property (weak, nonatomic) IBOutlet UILabel *addCustomerTitle;



@property (weak, nonatomic) IBOutlet UILabel *child1;
@property (weak, nonatomic) IBOutlet UILabel *child2;
@property (weak, nonatomic) IBOutlet UILabel *child3;
@property (weak, nonatomic) IBOutlet UILabel *child4;
@property (weak, nonatomic) IBOutlet UILabel *child5;




@property (weak, nonatomic) IBOutlet UIView *addCustomerView;

@property (weak, nonatomic) IBOutlet UIView *addedCustomerView;

@property (weak, nonatomic) IBOutlet UIView *addSpouseView;
@property (weak, nonatomic) IBOutlet UIView *addedSpouseView;
@property (weak, nonatomic) IBOutlet UIView *addedChildrenView;

@property (weak, nonatomic) IBOutlet UIView *addChildrenView;


@property (weak, nonatomic) IBOutlet UILabel *AddCustomer;
@property (weak, nonatomic) IBOutlet UILabel *addPartner;

@property (weak, nonatomic) IBOutlet UILabel *addChildren1;
//@property (weak, nonatomic) IBOutlet UILabel *addChildren2;
//@property (weak, nonatomic) IBOutlet UILabel *addChildren3;
//@property (weak, nonatomic) IBOutlet UILabel *addChildren4;
//@property (weak, nonatomic) IBOutlet UILabel *addChildren5;
@end
