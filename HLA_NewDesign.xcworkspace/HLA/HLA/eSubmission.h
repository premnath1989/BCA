//
//  eSubmission.h
//  iMobile Planner
//
//  Created by shawal sapuan on 5/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "eAppsListing.h"
#import "eAppStatusList.h"
#import "IDTypeViewController.h"
#import "eAppMenu.h"
#import <sqlite3.h>

 

@interface eSubmission : UIViewController <UITableViewDelegate,UITableViewDataSource,SIDateDelegate,eAppStatusListDelegate,IDTypeDelegate>{
    SIDate *_SIDate;
    eAppStatusList *_statusVC;
    IDTypeViewController *_IDTypeVC;
    eAppMenu *_eAppMenu;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_statusPopover;
    UIPopoverController *_IDTypePopover;
    eAppsListing *_eAppsVC;
	NSString *databasePath;
    sqlite3 *contactDB;
	BOOL isSearching;
    FMDatabase *database2;
    
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
   
}

@property (strong, nonatomic) IBOutlet UILabel *idTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *policyNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIButton *btnDate;
@property (strong, nonatomic) IBOutlet UIButton *btnIDType;
@property (strong, nonatomic) IBOutlet UIButton *btnStatus;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;

@property (strong, nonatomic) NSMutableArray *clientData;
@property (nonatomic, retain) eAppsListing *eAppsVC;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) eAppStatusList *statusVC;
@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, strong) eAppMenu *eAppMenu;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) UIPopoverController *statusPopover;

@property (retain, nonatomic) NSMutableArray *POName;
@property (retain, nonatomic) NSMutableArray *IDNo;
@property (retain, nonatomic) NSMutableArray *ProposalNo;
@property (retain, nonatomic) NSMutableArray *LastUpdated;
@property (retain, nonatomic) NSMutableArray *Status;
@property (retain, nonatomic) NSMutableArray *PONameSearch;
@property (retain, nonatomic) NSMutableArray *IDNoSearch;
@property (retain, nonatomic) NSMutableArray *ProposalNoSearch;
@property (retain, nonatomic) NSMutableArray *LastUpdatedSearch;
@property (retain, nonatomic) NSMutableArray *StatusSearch;

@property (retain, nonatomic) NSMutableArray *SINo;
@property (retain, nonatomic) NSMutableArray *ClientName;
@property (retain, nonatomic) NSMutableArray *planName;
@property (retain, nonatomic) NSMutableArray *SIVersion;


@property (strong, nonatomic) IBOutlet UITextField *policyOwnerNameTF;
@property (strong, nonatomic) IBOutlet UITextField *idNoTF;
@property (strong, nonatomic) IBOutlet UILabel *statusLbl;


- (IBAction)btnDatePressed:(id)sender;
- (IBAction)btnDeletePressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;
- (IBAction)btnResetPressed:(id)sender;


- (IBAction)addNew:(id)sender;
- (IBAction)ActionIDType:(id)sender;
- (IBAction)ActionStatus:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doESubmission;
- (IBAction)doEsubmissionBtn:(id)sender;
- (IBAction)searchProposalList:(id)sender;

@end
