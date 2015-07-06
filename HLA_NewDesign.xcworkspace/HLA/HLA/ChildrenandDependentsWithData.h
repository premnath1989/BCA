//
//  ChildrenandDependents.h
//  iMobile Planner
//
//  Created by Juliana on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelationshipPopoverViewController.h"

@interface ChildrenandDependentsWithData : UITableViewController <RelationshipPopoverViewControllerDelegate>

- (IBAction)doDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
- (IBAction)clickBtn1:(id)sender;

@property (nonatomic, strong) RelationshipPopoverViewController *RshipTypePicker;
@property (nonatomic, strong) UIPopoverController *RshipTypePickerPopover;

@property (weak, nonatomic) IBOutlet UITextField *relationship;
- (IBAction)doRelationship:(id)sender;

@end
