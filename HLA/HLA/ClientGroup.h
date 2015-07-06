//
//  ClientGroup.h
//  iMobile Planner
//
//  Created by Emi on 9/12/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupClass.h"

@class ClientGroup;
@protocol ClientGroupDelegate

@end

@interface ClientGroup : UIViewController <UITableViewDelegate,UITableViewDataSource, GroupDelegate>

{
	GroupClass *_GroupList;
	UIPopoverController *_GroupPopover;
	id <ClientGroupDelegate> _delegate;
	
}

@property (nonatomic,strong) id <ClientGroupDelegate> delegate;

@property (nonatomic, retain) GroupClass *GroupList;

@property (strong, nonatomic) NSMutableArray* GroupTableData;
@property (strong, nonatomic) NSMutableArray *itemToBeDeleted;
@property (strong, nonatomic) NSMutableArray *indexPaths;

@property (nonatomic, retain) UIPopoverController *groupPopover;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Backbtn;

@property (weak, nonatomic) IBOutlet UILabel *LblTitle;
@property (strong, nonatomic) IBOutlet UIButton *BtnAddNew;
@property (strong, nonatomic) IBOutlet UIButton *BtnDelete;
@property (strong, nonatomic) IBOutlet UIButton *BtnCancel;
@property (strong, nonatomic) IBOutlet UIButton *BtnNewGroup;
@property (strong, nonatomic) IBOutlet UIButton *BtnSelectGroup;


@property (strong, nonatomic) IBOutlet UITextField *GroupName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewGroup;
@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) NSString *lbltitleGroup;
@property (strong, nonatomic) NSUserDefaults *UDGroup;



- (IBAction)donePressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)AddNewPress:(id)sender;
- (IBAction)DeletePressed:(id)sender;
- (IBAction)CancelPressed:(id)sender;
- (IBAction)NewGroupPressed:(id)sender;
- (IBAction)SelectGroupPressed:(id)sender;

@end



