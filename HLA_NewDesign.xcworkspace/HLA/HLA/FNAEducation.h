//
//  FNAEducation.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EducationPlans.h"

@interface FNAEducation : UITableViewController<UITextFieldDelegate,EducationPlansDelegate>{
    bool hasEducation;
    bool hasChildren;
}

@property (weak, nonatomic) IBOutlet UIButton *hasChild;
- (IBAction)hasChildBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *EducationPlans;
@property(nonatomic, assign) BOOL EducationSelected;
@property(nonatomic, assign) BOOL ChildrenSelected;

@property(nonatomic, assign) NSString *rowToHide; //which row to hide

- (IBAction)EducationPlansBtn:(id)sender;




@property (weak, nonatomic) IBOutlet UITextField *current1;
- (IBAction)current1Action:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *current2;
- (IBAction)current2Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current3;
- (IBAction)current3Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *current4;
- (IBAction)current4Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *required1;
- (IBAction)required1Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *required2;
- (IBAction)required2Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *required3;
- (IBAction)required3Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *required4;
- (IBAction)required4Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *difference1;
@property (weak, nonatomic) IBOutlet UITextField *difference2;
@property (weak, nonatomic) IBOutlet UITextField *difference3;
@property (weak, nonatomic) IBOutlet UITextField *difference4;


@property (weak, nonatomic) IBOutlet UITextField *customerAlloc;
- (IBAction)customerAllocAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *plan1;
@property (weak, nonatomic) IBOutlet UILabel *plan2;
@property (weak, nonatomic) IBOutlet UILabel *plan3;
@property (weak, nonatomic) IBOutlet UILabel *plan4;


@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell5;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell6;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell7;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell8;








-(void)CalcualeDifference;






@end
