//
//  GroupVC.h
//  iMobile Planner
//
//  Created by Emi on 21/11/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListingTbViewController.h"
#import "ProspectProfile.h"

@class GroupVC;
@protocol GroupVCDelegate

@end
@interface GroupVC : UIViewController<UITableViewDelegate,UITableViewDataSource, ListingTbViewControllerDelegate>
{
	ListingTbViewController *_ProspectList;
	UIPopoverController *_prospectPopover;
	id <GroupVCDelegate> _delegate;
	
}
@property (strong, nonatomic) ProspectProfile* prospectprofile;
@property (nonatomic,strong) id <GroupVCDelegate> delegate;

@property (nonatomic, retain) ListingTbViewController *ProspectList;
@property (strong, nonatomic) NSMutableArray* ProspectTableData;
@property (strong, nonatomic) NSMutableArray *itemToBeDeleted;
@property (strong, nonatomic) NSMutableArray *indexPaths;

@property (nonatomic, retain) UIPopoverController *prospectPopover;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Backbtn;

@property (weak, nonatomic) IBOutlet UILabel *TitleBar;
@property (strong, nonatomic) IBOutlet UIButton *AddNew;
@property (strong, nonatomic) IBOutlet UIButton *Delete;
@property (strong, nonatomic) IBOutlet UIButton *Cancel;


@property (strong, nonatomic) IBOutlet UITextField *GroupName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) NSString *titleGroup;
@property (strong, nonatomic) NSUserDefaults *UDGroup;


- (IBAction)donePressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)AddNewPress:(id)sender;
- (IBAction)DeletePressed:(id)sender;
- (IBAction)CancelPressed:(id)sender;


@end
