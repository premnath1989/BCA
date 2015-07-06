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

@interface ProspectListing : UIViewController<EditProspectDelegate, ProspectViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,GroupDelegate>
{
    NSString *databasePath;
    sqlite3 *contactDB;
    EditProspect *_EditProspect;
    ProspectViewController *_ProspectViewController;
    GroupClass *_GroupList;
    UIPopoverController *_GroupPopover;
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
 
}


@property (nonatomic, retain) EditProspect *EditProspect;
@property (nonatomic, retain) ProspectViewController *ProspectViewController;
@property (nonatomic, strong) GroupClass *GroupList;
@property (nonatomic, strong) UIPopoverController *GroupPopover;
@property (strong, nonatomic) NSMutableArray* ProspectTableData;
@property (strong, nonatomic) NSMutableArray* FilteredProspectTableData;
@property (strong, nonatomic) NSMutableArray* dataMobile;
@property (strong, nonatomic) NSMutableArray* dataPrefix;
 

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

- (IBAction)ActionGroup:(id)sender;
- (IBAction)searchPressed:(id)sender;
- (IBAction)resetPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)editPressed:(id)sender;
- (IBAction)btnAddNew:(id)sender;

-(void) ReloadTableData;
-(void) Clear;
 

@end
