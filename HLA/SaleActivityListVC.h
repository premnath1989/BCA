//
//  SaleActivityListVC.h
//  iMobile Planner
//
//  Created by Emi on 13/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SaleActivityListVC : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
    NSString *databasePath;
    sqlite3 *contactDB;
}


@property (weak, nonatomic) IBOutlet UITableView *ActListingTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;
@property (weak, nonatomic) IBOutlet UILabel *lblNIP;
@property (weak, nonatomic) IBOutlet UILabel *lblNama;
@property (weak, nonatomic) IBOutlet UILabel *lblview;
@property (weak, nonatomic) IBOutlet UILabel *lblAct;

@property (weak, nonatomic) IBOutlet UILabel *lblDateTime;
- (IBAction)ActionReffer:(id)sender;
- (IBAction)ActionActLog:(id)sender;

- (IBAction)btnHome:(id)sender;
- (IBAction)ActionAddNew:(id)sender;
- (IBAction)toActLog:(id)sender;

@property (strong, nonatomic) NSUserDefaults *UDSalesAct;

@property (strong, nonatomic) NSMutableArray *itemInArray;
@property (strong, nonatomic) NSMutableArray *arrCountSA;
@property (strong, nonatomic) NSMutableArray* FilteredTableData;
@property (nonatomic, assign) bool isFiltered;

- (NSString *)calculateAge: (NSString *)DOB;

@end
