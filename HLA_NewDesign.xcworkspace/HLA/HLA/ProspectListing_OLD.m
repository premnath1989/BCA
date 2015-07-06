//
//  ProspectListing_OLD.m
//  iMobile Planner
//
//  Created by infoconnect on 11/6/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ProspectListing_OLD.h"
#import <sqlite3.h>
#import "ProspectProfile.h"
#import "ProspectViewController_OLD.h"
#import "EditProspect_OLD.h"
#import "AppDelegate.h"
#import "MainScreen.h"
#import "ColorHexCode.h"

@interface ProspectListing_OLD ()

@end

@implementation ProspectListing_OLD
@synthesize searchBar, ProspectTableData, FilteredProspectTableData, isFiltered;
@synthesize EditProspect_OLD = _EditProspect_OLD;
@synthesize ProspectViewController_OLD = _ProspectViewController_OLD;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	AppDelegate *appDel= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	appDel.MhiMessage = Nil;
	appDel = Nil;
	
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    searchBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Prospect Listing";
    self.navigationItem.titleView = label;
    
    searchBar.delegate = (id)self;
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT * from tbl_prospect_profile"];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile order by ProspectName ASC"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
				const char *tempNick = (const char*)sqlite3_column_text(statement, 1);
				NickName = tempNick == NULL ? nil : [[NSString alloc] initWithUTF8String:tempNick];
				
                ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				
				const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
                
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                                  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                              AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                           AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                       AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                                 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                             AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                           AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark
                                                         AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:@""
																		  AndTitle:@"" AndIDTypeNo:@"" AndOtherIDType:@"" AndOtherIDTypeNo:@"" AndSmoker:@"" AndAnnIncome:@""
																	   AndBussType:@"" AndRace:@"" AndMaritalStatus:@"" AndReligion:@"" AndNationality:@"" ]];
                
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, query_stmt = Nil;
    }
    
    CustomColor = Nil, label = Nil, dirPaths = Nil, docsDir = Nil, dbpath = Nil, statement = Nil, statement = Nil;
    ProspectID = Nil;
    NickName = Nil;
    ProspectName = Nil ;
    ProspectDOB = Nil  ;
    ProspectGender = Nil;
    ResidenceAddress1 = Nil;
    ResidenceAddress2 = Nil;
    ResidenceAddress3 = Nil;
    ResidenceAddressTown = Nil;
    ResidenceAddressState = Nil;
    ResidenceAddressPostCode = Nil;
    ResidenceAddressCountry = Nil;
    OfficeAddress1 = Nil;
    OfficeAddress2 = Nil;
    OfficeAddress3 = Nil;
    OfficeAddressTown = Nil;
    OfficeAddressState = Nil;
    OfficeAddressPostCode = Nil;
    OfficeAddressCountry = Nil;
    ProspectEmail = Nil;
    ProspectOccupationCode = Nil;
    ExactDuties = Nil;
    ProspectRemark = Nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(self.isFiltered)
        //rowCount = filteredTableData.count;
        rowCount = FilteredProspectTableData.count;
    else
        //rowCount = allTableData.count;
        rowCount = ProspectTableData.count;
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    //Food* food;
    ProspectProfile* pp;
    if(isFiltered)
        //food = [filteredTableData objectAtIndex:indexPath.row];
        pp = [FilteredProspectTableData objectAtIndex:indexPath.row];
    else
        //food = [allTableData objectAtIndex:indexPath.row];
        pp = [ProspectTableData objectAtIndex:indexPath.row];
    //cell.textLabel.text = food.name;
    //cell.detailTextLabel.text = food.description;
    cell.textLabel.text = pp.ProspectName;
    cell.detailTextLabel.text = pp.NickName;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    return cell;
    pp = Nil;
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        //  filteredTableData = [[NSMutableArray alloc] init];
        FilteredProspectTableData = [[NSMutableArray alloc] init];
        /*
         for (Food* food in allTableData)
         {
         NSRange nameRange = [food.name rangeOfString:text options:NSCaseInsensitiveSearch];
         NSRange descriptionRange = [food.description rangeOfString:text options:NSCaseInsensitiveSearch];
         if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
         {
         [filteredTableData addObject:food];
         }
         }
         */
        
        ProspectProfile* pp;
        for (pp in ProspectTableData)
        {
            NSRange Fullname = [pp.ProspectName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange PreferredName = [pp.NickName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange ResidenceAddressState = [pp.ResidenceAddressState rangeOfString:text options:NSCaseInsensitiveSearch];
            
            
            if (Fullname.location != NSNotFound || PreferredName.location != NSNotFound || ResidenceAddressState.location != NSNotFound) {
                [FilteredProspectTableData addObject:pp];
            }
        }
        pp = Nil;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    EditProspect_OLD* zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect"];
    ProspectProfile* pp;
    
    if(isFiltered)
    {
		
        pp = [FilteredProspectTableData objectAtIndex:indexPath.row];
    }
    else
    {
		
        pp = [ProspectTableData objectAtIndex:indexPath.row];
    }
    
    zzz.pp = pp;
    
    //[self.navigationController pushViewController:zzz animated:true];
    
    if (_EditProspect_OLD == Nil) {
        //self.EditProspect = [[EditProspect alloc] init ];
        self.EditProspect_OLD = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect_OLD"];
        _EditProspect_OLD.delegate = self;
    }
    
    _EditProspect_OLD.pp = pp;
    
    /*
	 _EditProspect.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	 _EditProspect.modalPresentationStyle = UIModalPresentationPageSheet;
	 [self presentModalViewController:_EditProspect animated:YES];
	 _EditProspect.view.superview.frame = CGRectMake(50, 0, 970, 768);
	 */
    
    [self.navigationController pushViewController:_EditProspect_OLD animated:YES];
    _EditProspect_OLD.navigationItem.title = @"Edit Prospect Profile";
    _EditProspect_OLD.navigationItem.rightBarButtonItem = _EditProspect_OLD.outletDone;
    pp = Nil, zzz = Nil;
	
}

- (IBAction)btnAddNew:(id)sender {
    /*
	 ProspectViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
	 pvc.modalPresentationStyle = UIModalPresentationPageSheet;
	 pvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	 [self presentModalViewController:pvc animated:YES];
	 pvc.view.superview.frame = CGRectMake(20, 0, 1000, 768);
	 //[self.navigationController pushViewController:pvc animated:YES ];
     */
    
    /*
	 if (_ProspectViewController == Nil) {
	 self.ProspectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
	 _ProspectViewController.delegate = self;
	 }
	 _ProspectViewController.modalPresentationStyle = UIModalPresentationPageSheet;
	 _ProspectViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	 [self presentModalViewController:_ProspectViewController animated:YES];
	 _ProspectViewController.view.superview.frame = CGRectMake(50, 0, 970, 768);
	 */
    
    if (_ProspectViewController_OLD == Nil) {
        self.ProspectViewController_OLD = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect_OLD"];
        _ProspectViewController_OLD.delegate = self;
    }
    
    [self.navigationController pushViewController:_ProspectViewController_OLD animated:YES];
    _ProspectViewController_OLD.navigationItem.title = @"Prospect Profile";
    _ProspectViewController_OLD.navigationItem.rightBarButtonItem = _ProspectViewController_OLD.outletDone;
    
}
/*
 - (IBAction)btnRefresh:(id)sender {
 //[self.tableView reloadData];
 [self ReloadTableData];
 }
 */
-(void) ReloadTableData{
	
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
	
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile order by ProspectName ASC"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
			
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
				NSString *ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
				const char *tempNick = (const char*)sqlite3_column_text(statement, 1);
				NSString *NickName = tempNick == NULL ? nil : [[NSString alloc] initWithUTF8String:tempNick];
				
				NSString *ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				NSString *ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				NSString *ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				
				const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                NSString *ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                NSString *ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                NSString *ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                NSString *ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                NSString *ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                NSString *ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                NSString *ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                NSString *OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                NSString *OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                NSString *OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                NSString *OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                NSString *OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                NSString *OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                NSString *OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                NSString *ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                NSString * ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                NSString *ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                NSString *ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
				
				//NSString *ProspectContactType = @"2";
				//NSString *ProspectContactNo = @"0128765462";
				
				// NSLog(@"%@", ProspectRemark);
				[ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
																  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
															  AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
														   AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
													   AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
																 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
															 AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
														   AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark
														 AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:@""
																		  AndTitle:@"" AndIDTypeNo:@"" AndOtherIDType:@"" AndOtherIDTypeNo:@"" AndSmoker:@"" AndAnnIncome:@""
																	   AndBussType:@"" AndRace:@"" AndMaritalStatus:@"" AndReligion:@"" AndNationality:@"" ]];
                
                ProspectID = Nil;
                NickName = Nil;
                ProspectName = Nil ;
                ProspectDOB = Nil  ;
                ProspectGender = Nil;
                ResidenceAddress1 = Nil;
                ResidenceAddress2 = Nil;
                ResidenceAddress3 = Nil;
                ResidenceAddressTown = Nil;
                ResidenceAddressState = Nil;
                ResidenceAddressPostCode = Nil;
                ResidenceAddressCountry = Nil;
                OfficeAddress1 = Nil;
                OfficeAddress2 = Nil;
                OfficeAddress3 = Nil;
                OfficeAddressTown = Nil;
                OfficeAddressState = Nil;
                OfficeAddressPostCode = Nil;
                OfficeAddressCountry = Nil;
                ProspectEmail = Nil;
                ProspectOccupationCode = Nil;
                ExactDuties = Nil;
                ProspectRemark = Nil;
            }
            sqlite3_finalize(statement);
			
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, querySQL = Nil;
    }
    [self.tableView reloadData];
    dirPaths = Nil;
    docsDir = Nil;
    dbpath = Nil;
    statement = Nil;
    
}

-(void) FinishEdit{
    isFiltered = FALSE;
    [self ReloadTableData];
    searchBar.text = @"";
    _EditProspect_OLD = Nil;
    
}

-(void) FinishInsert{
    isFiltered = FALSE;
    [self ReloadTableData];
    searchBar.text = @"";
    _ProspectViewController_OLD = nil;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

-(void)Clear{
	ProspectTableData = Nil;
	FilteredProspectTableData = Nil;
	databasePath = Nil;
}



@end
