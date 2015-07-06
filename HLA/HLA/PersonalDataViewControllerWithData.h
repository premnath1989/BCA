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


@interface PersonalDataViewControllerWithData : UITableViewController <PersonalDetialsViewControllerDelegate>{
    int showCustomer;
    int showSpouse;
    int showChildren;
}

@property (strong, nonatomic) IBOutlet UILabel *addCustomerTitle;
@property (strong, nonatomic) IBOutlet UILabel *addSpouseTitle;

@property (weak, nonatomic) IBOutlet UILabel *addChildren1;
@property (weak, nonatomic) IBOutlet UILabel *addChildren2;
@property (weak, nonatomic) IBOutlet UILabel *addChildren3;
@property (weak, nonatomic) IBOutlet UILabel *addChildren4;
@property (weak, nonatomic) IBOutlet UILabel *addChildren5;
@end
