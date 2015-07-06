//
//  ProspectListing_OLD.h
//  iMobile Planner
//
//  Created by infoconnect on 11/6/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditProspect_OLD.h"
#import "ProspectViewController_OLD.h"

@interface ProspectListing_OLD : UITableViewController<EditProspect_OLDDelegate,ProspectViewOLDControllerDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    EditProspect_OLD *_EditProspect_OLD;
    ProspectViewController_OLD *_ProspectViewController_OLD;
}

@property (nonatomic, retain) EditProspect_OLD *EditProspect_OLD;
@property (nonatomic, retain) ProspectViewController_OLD *ProspectViewController_OLD;
@property (strong, nonatomic) NSMutableArray* ProspectTableData;
@property (strong, nonatomic) NSMutableArray* FilteredProspectTableData;
@property (nonatomic, assign) bool isFiltered;
- (IBAction)btnAddNew:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

-(void) ReloadTableData;
-(void) Clear;


@end
