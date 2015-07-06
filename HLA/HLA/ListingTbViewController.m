//
//  ListingTbViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/7/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ListingTbViewController.h"
#import "textFields.h"

@interface ListingTbViewController ()
{
 
}

@end

@implementation ListingTbViewController
@synthesize NameList = _NameList;
@synthesize indexNo = _indexNo;
@synthesize DOBList = _DOBList;
@synthesize GenderList = _GenderList;
@synthesize OccpCodeList = _OccpCodeList;
@synthesize SmokerList = _SmokerList;
@synthesize OtherIDList = _OtherIDList;
@synthesize IDList = _IDList;
@synthesize delegate = _delegate;
@synthesize OtherIDTypeList = _OtherIDTypeList;
@synthesize MaritalStatus = _MaritalStatus;
@synthesize FilteredName,FilteredIndex,FilteredDOB,FilteredGender,FilteredOccp,FilteredSmoker,FilteredOtherID,FilteredID,isFiltered, FilteredOtherIDType, FilteredMaritalStatus;
@synthesize SIOrEAPPS;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(500.0, 400.0);
    [self getListing];
    
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    searchbar.opaque = false;
    searchbar.delegate = (id) self;
    self.tableView.tableHeaderView = searchbar;
    CGRect searchbarFrame = searchbar.frame;
    [self.tableView scrollRectToVisible:searchbarFrame animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - handle db
-(void)getListing
{
    self.indexNo = [[NSMutableArray alloc] init];
    self.NameList = [[NSMutableArray alloc] init];
    self.DOBList = [[NSMutableArray alloc] init];
    self.GenderList = [[NSMutableArray alloc] init];
    self.OccpCodeList = [[NSMutableArray alloc] init];
    self.SmokerList = [[NSMutableArray alloc] init];
    self.OtherIDList = [[NSMutableArray alloc] init];
    self.IDList = [[NSMutableArray alloc] init];
    self.OtherIDTypeList = [[NSMutableArray alloc] init];
    self.MaritalStatus = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {   
        NSString *querySQL;
		

        if ([SIOrEAPPS isEqualToString:@"SI"]) {
            if (!_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
                            "Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false' AND OtherIDType <> 'CR' ORDER by LOWER(ProspectName) asc"];
            }
            else if (_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
                            "Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false' AND OtherIDType <> 'CR' and IDTypeNo NOT IN %@ "
                            "ORDER by LOWER(ProspectName) asc", self.blacklistedIndentificationNos];
            }
        }
		else if ([SIOrEAPPS isEqualToString:@"GROUP"]) {
			if (!_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
							"Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false' ORDER by LOWER(ProspectName) asc"];
            }
            else if (_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
							"Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false' AND IndexNo NOT IN (%@) ORDER by LOWER(ProspectName) asc", self.blacklistedIndentificationNos];
            }
		}
        else{
            if (!_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
                            "Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false'  ORDER by LOWER(ProspectName) asc"];
            }
            else if (_needFiltered) {
                querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, "
                            "Smoker, OtherIDType, OtherIDTypeNo, IDTypeNo, MaritalStatus FROM prospect_profile WHERE QQFlag = 'false' and (IDTypeNo NOT IN %@ OR OtherIdType NOT IN %@ OR OtherIDTypeNo NOT IN %@)"
                            "ORDER by LOWER(ProspectName) asc", self.blacklistedIndentificationNos, self.blacklistedOtherIDType, self.blacklistedOtherID];
            }
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                int index = sqlite3_column_int(statement, 0);
                [_indexNo addObject:[[NSString alloc] initWithFormat:@"%d",index]];
                [_NameList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
                [_DOBList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]];
                [_GenderList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)]];
                [_OccpCodeList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)]];
                // Change by Benjamin on 14/10/2013 for bug 2622
                if (sqlite3_column_text(statement, 5) != NULL) {
                    [_SmokerList addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)]];
                }
                else {
                    [_SmokerList addObject:@" "];
                }
                
                if (sqlite3_column_text(statement, 6)) {
                    [_OtherIDTypeList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)]];
                }
                else {
                    [_OtherIDTypeList addObject:@""];
                }
                
                
                if (sqlite3_column_text(statement, 7) != NULL) {
                    [_OtherIDList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)]];
                }
                else{
                    [_OtherIDList addObject:@""];
                }
                
                if (sqlite3_column_text(statement, 8) != NULL) {
                    [_IDList addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)]];
                }
                else{
                    [_IDList addObject:@" "];
                }
            
                if (sqlite3_column_text(statement, 9) != NULL) {
                    [_MaritalStatus addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                }
                else{
                    [_MaritalStatus addObject:@" "];
                }
                
            }  
            sqlite3_finalize(statement);
        }
        else {
            NSLog(@"error msg: %s", sqlite3_errmsg(contactDB));
        }
        sqlite3_close(contactDB);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered == false) {
        return [_indexNo count];
    }
    else {
        return [FilteredIndex count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.detailTextLabel.numberOfLines = 2;
    if (isFiltered == false) {
        cell.textLabel.text = [_NameList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", [_IDList objectAtIndex:indexPath.row], [_OtherIDList objectAtIndex:indexPath.row]];
        if ([[_IDList objectAtIndex:indexPath.row] isEqualToString:@""]) {
            cell.detailTextLabel.text = [_OtherIDList objectAtIndex:indexPath.row];
        }

        if ([[textFields trimWhiteSpaces:[_OtherIDTypeList objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[_DOBList objectAtIndex:indexPath.row]];
        }
    }
    else {
        cell.textLabel.text = [FilteredName objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", [FilteredID objectAtIndex:indexPath.row], [FilteredOtherID objectAtIndex:indexPath.row]];
        if ([[FilteredID objectAtIndex:indexPath.row] isEqualToString:@""]) {
            cell.detailTextLabel.text = [FilteredOtherID objectAtIndex:indexPath.row];
        }
        if ([[textFields trimWhiteSpaces:[FilteredOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[FilteredDOB objectAtIndex:indexPath.row]];
        }

    }
        
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text{
    if (text.length == 0) {
        isFiltered = false;
    }
    else {
        isFiltered = true;
        
        FilteredIndex = [[NSMutableArray alloc] init ];
        FilteredName = [[NSMutableArray alloc] init ];
        FilteredDOB = [[NSMutableArray alloc] init];
        FilteredGender = [[NSMutableArray alloc] init];
        FilteredOccp = [[NSMutableArray alloc] init];
        FilteredSmoker = [[NSMutableArray alloc] init];
        FilteredOtherID = [[NSMutableArray alloc] init];
        FilteredID = [[NSMutableArray alloc] init];
        FilteredOtherIDType = [[NSMutableArray alloc] init];
        FilteredMaritalStatus = [[NSMutableArray alloc] init];
        
        NSRange pp;
        NSRange pp1;
        NSRange pp2;
        NSRange pp3;
        for (int a =0; a<_NameList.count; a++ ) {
            pp = [[_NameList objectAtIndex:a] rangeOfString:text options:NSCaseInsensitiveSearch];
            pp1 = [[_IDList objectAtIndex:a] rangeOfString:text options:NSCaseInsensitiveSearch];
            pp2 = [[_OtherIDList objectAtIndex:a] rangeOfString:text options:NSCaseInsensitiveSearch];
            pp3 = [[_DOBList objectAtIndex:a] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            
            if (pp.location != NSNotFound) {
                [FilteredIndex addObject:[_indexNo objectAtIndex:a]];
                [FilteredName addObject:[_NameList objectAtIndex:a]];
                [FilteredDOB addObject:[_DOBList objectAtIndex:a]];
                [FilteredGender addObject:[_GenderList objectAtIndex:a]];
                [FilteredOccp addObject:[_OccpCodeList objectAtIndex:a]];
                [FilteredSmoker addObject:[_SmokerList objectAtIndex:a]];
                [FilteredOtherID addObject:[_OtherIDList objectAtIndex:a]];
                [FilteredID addObject:[_IDList objectAtIndex:a]];
                [FilteredOtherIDType addObject:[_OtherIDTypeList objectAtIndex:a]];
                [FilteredMaritalStatus addObject:[_MaritalStatus objectAtIndex:a]];
            }
            else if (pp1.location != NSNotFound) {
                [FilteredIndex addObject:[_indexNo objectAtIndex:a]];
                [FilteredName addObject:[_NameList objectAtIndex:a]];
                [FilteredDOB addObject:[_DOBList objectAtIndex:a]];
                [FilteredGender addObject:[_GenderList objectAtIndex:a]];
                [FilteredOccp addObject:[_OccpCodeList objectAtIndex:a]];
                [FilteredSmoker addObject:[_SmokerList objectAtIndex:a]];
                [FilteredOtherID addObject:[_OtherIDList objectAtIndex:a]];
                [FilteredID addObject:[_IDList objectAtIndex:a]];
                [FilteredOtherIDType addObject:[_OtherIDTypeList objectAtIndex:a]];
                [FilteredMaritalStatus addObject:[_MaritalStatus objectAtIndex:a]];
            }
            else if (pp2.location != NSNotFound) {
                [FilteredIndex addObject:[_indexNo objectAtIndex:a]];
                [FilteredName addObject:[_NameList objectAtIndex:a]];
                [FilteredDOB addObject:[_DOBList objectAtIndex:a]];
                [FilteredGender addObject:[_GenderList objectAtIndex:a]];
                [FilteredOccp addObject:[_OccpCodeList objectAtIndex:a]];
                [FilteredSmoker addObject:[_SmokerList objectAtIndex:a]];
                [FilteredOtherID addObject:[_OtherIDList objectAtIndex:a]];
                [FilteredID addObject:[_IDList objectAtIndex:a]];
                [FilteredOtherIDType addObject:[_OtherIDTypeList objectAtIndex:a]];
                [FilteredMaritalStatus addObject:[_MaritalStatus objectAtIndex:a]];
            }

            else if (pp3.location != NSNotFound) {
                [FilteredIndex addObject:[_indexNo objectAtIndex:a]];
                [FilteredName addObject:[_NameList objectAtIndex:a]];
                [FilteredDOB addObject:[_DOBList objectAtIndex:a]];
                [FilteredGender addObject:[_GenderList objectAtIndex:a]];
                [FilteredOccp addObject:[_OccpCodeList objectAtIndex:a]];
                [FilteredSmoker addObject:[_SmokerList objectAtIndex:a]];
                [FilteredOtherID addObject:[_OtherIDList objectAtIndex:a]];
                [FilteredID addObject:[_IDList objectAtIndex:a]];
                [FilteredOtherIDType addObject:[_OtherIDTypeList objectAtIndex:a]];
                [FilteredMaritalStatus addObject:[_MaritalStatus objectAtIndex:a]];
            }


        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    
    if (isFiltered == false) {
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [_delegate listing:self didSelectIndex:[_indexNo objectAtIndex:selectedIndex] andName:[_NameList objectAtIndex:selectedIndex] andDOB:[_DOBList objectAtIndex:selectedIndex] andGender:[_GenderList objectAtIndex:selectedIndex] andOccpCode:[_OccpCodeList objectAtIndex:selectedIndex] andSmoker:[_SmokerList objectAtIndex:selectedIndex] andMaritalStatus:[_MaritalStatus objectAtIndex:selectedIndex]];
    }
    else {
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [_delegate listing:self didSelectIndex:[FilteredIndex objectAtIndex:selectedIndex] andName:[FilteredName objectAtIndex:selectedIndex] andDOB:[FilteredDOB objectAtIndex:selectedIndex] andGender:[FilteredGender objectAtIndex:selectedIndex] andOccpCode:[FilteredOccp objectAtIndex:selectedIndex] andSmoker:[FilteredSmoker objectAtIndex:selectedIndex] andMaritalStatus:[FilteredMaritalStatus objectAtIndex:selectedIndex]];
    }
    
    [tableView reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58.0;
}


#pragma mark - Memory Management
- (void)viewDidUnload
{
    [self setDelegate:nil];
    [self setNameList:nil];
    [self setDOBList:nil];
    [self setGenderList:nil];
    [self setOccpCodeList:nil];
    [self setFilteredIndex:nil];
    [self setFilteredName:nil];
    [self setFilteredGender:nil];
    [self setFilteredDOB:nil];
    [self setFilteredOccp:nil];
    [super viewDidUnload];
}

@end
