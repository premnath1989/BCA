//
//  ChildrenandDependents.h
//  iMobile Planner
//
//  Created by Juliana on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelationshipPopoverViewController.h"
#import "SIDate_DOB.h"
#import "ListingTbViewController.h"

@interface ChildrenandDependents : UITableViewController <RelationshipPopoverViewControllerDelegate,SIDateDelegate_DOB,UITextFieldDelegate,ListingTbViewControllerDelegate>

- (IBAction)doDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
- (IBAction)clickBtn1:(id)sender;

@property (nonatomic, strong) RelationshipPopoverViewController *RshipTypePicker;
@property (nonatomic, strong) UIPopoverController *RshipTypePickerPopover;
@property (nonatomic, retain) ListingTbViewController *prospectList;
@property (nonatomic, retain) UIPopoverController *prospectPopover;

@property (weak, nonatomic) IBOutlet UITextField *relationship;
- (IBAction)doRelationship:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *childName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *childGender;
@property (weak, nonatomic) IBOutlet UITextField *childDOB;
@property (weak, nonatomic) IBOutlet UITextField *childAge;
@property (weak, nonatomic) IBOutlet UITextField *childSupport;

@property (nonatomic, retain) SIDate_DOB *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIButton *quickBtn;



- (IBAction)doChildName:(id)sender;
- (IBAction)doChildDOB:(id)sender;
- (IBAction)doChildAge:(id)sender;
- (IBAction)doChildSupport:(id)sender;

@property(nonatomic, assign) int rowToUpdate;



- (IBAction)doDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
- (IBAction)doSelect:(id)sender;
- (IBAction)doQuick:(id)sender;


@end
