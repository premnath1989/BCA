//
//  OccupationList.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "OccupationList.h"

NSString *SelectedString;
@interface OccupationList ()

@end

@implementation OccupationList
@synthesize OccupCode = _OccupCode;
@synthesize OccupDesc = _OccupDesc;
@synthesize OccupClass = _OccupClass;
@synthesize isFiltered;
@synthesize FilteredData, FilteredCode,FilteredClass;
@synthesize lastIndexPath;
@synthesize delegate = _delegate;

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
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];    
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(700.0, 400.0);
    self.OccupDesc = [NSMutableArray array];
    self.OccupCode = [NSMutableArray array];
    self.OccupClass = [NSMutableArray array];
    
    //Add "-Select-" in first row
    [_OccupDesc addObject:@"- SELECT -"];
    [_OccupCode addObject:@""];
    [_OccupClass addObject:@""];
    
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){        
		NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpCode, OccpDesc, Class FROM Adm_Occp_Loading_Penta where status = 'A' ORDER BY OccpDesc ASC"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSString *OccpCode;
            NSString *OccpDesc;
            NSString *OccpClass;
            while (sqlite3_step(statement) == SQLITE_ROW){
                OccpCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                [_OccupDesc addObject:OccpDesc];
                [_OccupCode addObject:OccpCode];
                [_OccupClass addObject:OccpClass];
            }
        }
    
        sqlite3_close(contactDB);
    }
    
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    searchbar.opaque = false;
    searchbar.delegate = (id) self;
    self.tableView.tableHeaderView = searchbar;
    CGRect searchbarFrame = searchbar.frame;
    [self.tableView scrollRectToVisible:searchbarFrame animated:NO];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFiltered == false) {
        return  [_OccupDesc count ];
    } 
    else {
        return [FilteredData count ];
    }   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    if (isFiltered == false) {
        NSString *OccuDesc = [_OccupDesc objectAtIndex:indexPath.row];
        NSString *OccuClass = [_OccupClass objectAtIndex:indexPath.row];
       
        if([OccuClass isEqualToString:@""]){
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", OccuDesc, OccuClass];
        } else {
            if ([OccuClass isEqualToString:@"99"]) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", OccuDesc, @"D"];
            }
            else{
                cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", OccuDesc, OccuClass];
            }
        }
        
        if (OccuDesc == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }        
    }
    else {
        if([[FilteredClass objectAtIndex:indexPath.row] isEqualToString:@""]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [FilteredData objectAtIndex:indexPath.row],@""];
        } else if ([[FilteredClass objectAtIndex:indexPath.row] isEqualToString:@"99"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [FilteredData objectAtIndex:indexPath.row], @"D"];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [FilteredData objectAtIndex:indexPath.row], [FilteredClass objectAtIndex:indexPath.row]];
        }
        
        if ([FilteredData objectAtIndex:indexPath.row] == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }        
    }    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    return cell;

}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if (text.length == 0) {
        isFiltered = false;        
    } else {
        isFiltered = true;
        FilteredData = [[NSMutableArray alloc] init ];
        FilteredCode = [[NSMutableArray alloc] init ];
        FilteredClass = [[NSMutableArray alloc] init ];
        NSRange Occu;
        for (int a =0; a<_OccupDesc.count; a++ ) {
            Occu = [[_OccupDesc objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (Occu.location != NSNotFound) {
                [FilteredData addObject:[_OccupDesc objectAtIndex:a ] ];
                [FilteredCode addObject:[_OccupCode objectAtIndex:a]];
                [FilteredClass addObject:[_OccupClass objectAtIndex:a]];
            }
        }
    }
    
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate != nil) {
        
        NSString *OccuDesc;
        NSString *occupCode;
        NSString *occupClass;
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        if (!isFiltered) {            
            OccuDesc = [_OccupDesc objectAtIndex:indexPath.row];
            [_delegate OccupDescSelected:OccuDesc];
            
            occupCode = [_OccupCode objectAtIndex:indexPath.row];
            [_delegate OccupCodeSelected:occupCode];
            
            occupClass = [_OccupClass objectAtIndex:indexPath.row];
            [_delegate OccupClassSelected:occupClass];
            
            SelectedString = [_OccupDesc objectAtIndex:indexPath.row ];    
        } 
        else {            
            OccuDesc = [FilteredData objectAtIndex:indexPath.row];
            [_delegate OccupDescSelected:OccuDesc];
            
            occupCode = [FilteredCode objectAtIndex:indexPath.row];
            [_delegate OccupCodeSelected:occupCode];
            
            occupClass = [FilteredClass objectAtIndex:indexPath.row];
            [_delegate OccupClassSelected:occupClass];
            
            SelectedString = [FilteredData objectAtIndex:indexPath.row];            
        }
    }
    
    [tableView reloadData];
}

-(void) setTitle:(NSString *)title
{    
    SelectedString = title;    
    [self.tableView reloadData];
}
@end
