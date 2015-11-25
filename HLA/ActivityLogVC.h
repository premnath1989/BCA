//
//  ActivityLogVC.h
//  iMobile Planner
//
//  Created by Emi on 19/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ActivityLogVC : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
    NSString *databasePath;
    sqlite3 *contactDB;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)actionContact:(id)sender;
- (IBAction)actionReferralList:(id)sender;

- (IBAction)btnBack:(id)sender;

@property (strong, nonatomic) NSUserDefaults *UDSalesAct;

@property (strong, nonatomic) NSMutableArray *itemInArray;
@property (strong, nonatomic) NSMutableArray *arrCountSA;
@property (strong, nonatomic) NSMutableArray* FilteredTableData;
@property (nonatomic, assign) bool isFiltered;

@end
