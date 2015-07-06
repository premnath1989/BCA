//
//  ProspectListing.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditProspect.h"
#import "ProspectViewController.h"
#import "GroupClass.h"
#import "ClientProfileListingSortBy.h"
#import "CustomAlertBox.h"

@interface ProspectListing : UIViewController<EditProspectDelegate, ProspectViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,GroupDelegate, ClientProfileListingDelegate,CustomAlertBoxDelegate, UITabBarDelegate>
{
    NSString *databasePath;
    sqlite3 *contactDB;
    EditProspect *_EditProspect;
    ProspectViewController *_ProspectViewController;
    GroupClass *_GroupList;
    UIPopoverController *_GroupPopover;
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
    ClientProfileListingSortBy *_SortBy;
    UIPopoverController *_Popover;
	
	UIActivityIndicatorView *spinner;
 
}

@property (nonatomic, retain) ClientProfileListingSortBy *SortBy;
@property (nonatomic, retain) UIPopoverController *Popover;

@property (nonatomic, retain) EditProspect *EditProspect;
@property (nonatomic, retain) ProspectViewController *ProspectViewController;
@property (nonatomic, strong) GroupClass *GroupList;
@property (nonatomic, strong) UIPopoverController *GroupPopover;
@property (strong, nonatomic) NSMutableArray* ProspectTableData;
@property (strong, nonatomic) NSMutableArray* FilteredProspectTableData;
@property (strong, nonatomic) NSMutableArray* dataMobile;
@property (strong, nonatomic) NSMutableArray* dataPrefix;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) BOOL noMoreResultsAvail;
@property (nonatomic) BOOL loading;

@property (nonatomic, assign) bool isFiltered;
//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UITextField *nametxt;
@property (strong, nonatomic) IBOutlet UITextField *txtIDTypeNo;
@property (strong, nonatomic) IBOutlet UIButton *btnGroup;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UILabel *idTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletOrder;
@property (strong, nonatomic) IBOutlet UIButton *btnSortBy;
@property (nonatomic, copy) NSString *OrderBy;

- (IBAction)ActionGroup:(id)sender;
- (IBAction)searchPressed:(id)sender;
- (IBAction)resetPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)editPressed:(id)sender;
- (IBAction)btnAddNew:(id)sender;
- (IBAction)btnSortBy:(id)sender;
- (IBAction)segOrderBy:(id)sender;

-(void) ReloadTableData;
-(void) Clear;
 

@end
