//
//  SIListing.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/2/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "siListingSortBy.h"
#import "SIDate.h"


@interface SIListing : UIViewController<UITableViewDelegate, UITableViewDataSource, siListingDelegate, SIDateDelegate>

{
    NSString *databasePath;
    sqlite3 *contactDB;
    Boolean isFilter;
    siListingSortBy *_SortBy;
    UIPopoverController *_Popover;
    SIDate *_SIDate;
    UIPopoverController *_SIDatePopover;
//    NewLAViewController *_NewLAViewController;
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;

}

@property (nonatomic, copy) NSString *TradOrEver;

@property (nonatomic, retain) siListingSortBy *SortBy;
@property (nonatomic, retain) UIPopoverController *Popover;
@property (nonatomic, retain) SIDate *SIDate;

@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, copy) NSString *DBDateFrom;
@property (nonatomic, copy) NSString *DBDateTo;
@property (nonatomic, copy) NSString *OrderBy;
//@property (nonatomic, retain) NewLAViewController *NewLAViewController;
@property (retain, nonatomic) NSMutableArray *SINO;
@property (retain, nonatomic) NSMutableArray *DateCreated;
@property (retain, nonatomic) NSMutableArray *Name;
@property (retain, nonatomic) NSMutableArray *PlanName;
@property (retain, nonatomic) NSMutableArray *BasicSA;
@property (retain, nonatomic) NSMutableArray *SIStatus;
@property (retain, nonatomic) NSMutableArray *CustomerCode;

@property (retain, nonatomic) NSMutableArray *FilteredSINO;
@property (retain, nonatomic) NSMutableArray *FilteredDateCreated;
@property (retain, nonatomic) NSMutableArray *FilteredName;
@property (retain, nonatomic) NSMutableArray *FilteredPlanName;
@property (retain, nonatomic) NSMutableArray *FilteredBasicSA;
@property (retain, nonatomic) NSMutableArray *FilteredSIStatus;
@property (retain, nonatomic) NSMutableArray *FilteredCustomerCode;

@property (weak, nonatomic) IBOutlet UITextField *txtSINO;
@property (weak, nonatomic) IBOutlet UITextField *txtLAName;
- (IBAction)btnDateFrom:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletDateFrom;
@property (weak, nonatomic) IBOutlet UIButton *outletDateTo;
- (IBAction)btnDateTo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSortBy;
- (IBAction)segOrderBy:(id)sender;
- (IBAction)btnSearch:(id)sender;
- (IBAction)btnEdit:(id)sender;
- (IBAction)btnDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIButton *outletDone;
- (IBAction)btnDone:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblSINO;
@property (weak, nonatomic) IBOutlet UILabel *lblDateCreated;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlan;
@property (weak, nonatomic) IBOutlet UILabel *lblBasicSA;
- (IBAction)btnSortBy:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletGender;
@property (weak, nonatomic) IBOutlet UIButton *outletEdit;
- (IBAction)btnReset:(id)sender;

//added for Add New SI Listing button by Juliana
- (IBAction)btnAddNewSI:(id)sender;
-(void)RefreshZZZ;
-(void)SIListingClear;
@end
