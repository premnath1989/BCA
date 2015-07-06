//
//  ListingTbViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/7/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ListingTbViewController.h"

@interface ListingTbViewController ()

@end

@implementation ListingTbViewController
@synthesize NameList = _NameList;
@synthesize indexNo = _indexNo;
@synthesize DOBList = _DOBList;
@synthesize GenderList = _GenderList;
@synthesize OccpCodeList = _OccpCodeList;
@synthesize SmokerList = _SmokerList;
@synthesize delegate = _delegate;
@synthesize FilteredName,FilteredIndex,FilteredDOB,FilteredGender,FilteredOccp,FilteredSmoker,isFiltered;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(500.0, 400.0);
    [self getListing];
    
    UISearchBar *zzz = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    zzz.opaque = false;
    zzz.delegate = (id) self;
    self.tableView.tableHeaderView = zzz;
    CGRect searchbarFrame = zzz.frame;
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
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT IndexNo, ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, Smoker, OtherIDType FROM prospect_profile WHERE QQFlag = 'false' ORDER by ProspectName asc"];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                if (sqlite3_column_text(statement, 6) == NULL || ![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] isEqualToString:@"Company Registration Number"]) {
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
                }  
            }
            sqlite3_finalize(statement);
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
    
    if (isFiltered == false) {
        cell.textLabel.text = [_NameList objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text = [FilteredName objectAtIndex:indexPath.row];
    }
    
    /*
    if (indexPath.row == selectedIndex) {
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    
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
        
        for (int a =0; a<_NameList.count; a++ ) {
            NSRange pp = [[_NameList objectAtIndex:a] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (pp.location != NSNotFound) {
                [FilteredIndex addObject:[_indexNo objectAtIndex:a]];
                [FilteredName addObject:[_NameList objectAtIndex:a]];
                [FilteredDOB addObject:[_DOBList objectAtIndex:a]];
                [FilteredGender addObject:[_GenderList objectAtIndex:a]];
                [FilteredOccp addObject:[_OccpCodeList objectAtIndex:a]];
                [FilteredSmoker addObject:[_SmokerList objectAtIndex:a]];
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
        
        [_delegate listing:self didSelectIndex:[_indexNo objectAtIndex:selectedIndex] andName:[_NameList objectAtIndex:selectedIndex] andDOB:[_DOBList objectAtIndex:selectedIndex] andGender:[_GenderList objectAtIndex:selectedIndex] andOccpCode:[_OccpCodeList objectAtIndex:selectedIndex] andSmoker:[_SmokerList objectAtIndex:selectedIndex]];
    }
    else {
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [_delegate listing:self didSelectIndex:[FilteredIndex objectAtIndex:selectedIndex] andName:[FilteredName objectAtIndex:selectedIndex] andDOB:[FilteredDOB objectAtIndex:selectedIndex] andGender:[FilteredGender objectAtIndex:selectedIndex] andOccpCode:[FilteredOccp objectAtIndex:selectedIndex] andSmoker:[FilteredSmoker objectAtIndex:selectedIndex]];
    }
    
    [tableView reloadData];
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
