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
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        //NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpCode, OccpDesc FROM Adm_Occp where status = 1"];
		NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpCode, OccpDesc, Class FROM Adm_Occp_Loading_Penta where status = 'A'"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OccpCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                [_OccupDesc addObject:OccpDesc];
                [_OccupCode addObject:OccpCode];
                [_OccupClass addObject:OccpClass];
            }
        }
    
        sqlite3_close(contactDB);
    }
    
    UISearchBar *zzz = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    zzz.opaque = false;
    zzz.delegate = (id) self;
    self.tableView.tableHeaderView = zzz;
    CGRect searchbarFrame = zzz.frame;
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (isFiltered == false) {
        NSString *OccuDesc = [_OccupDesc objectAtIndex:indexPath.row];
        NSString *OccuClass = [_OccupClass objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", OccuDesc, OccuClass];

        // comment out display for class in row
        /*
        UILabel *strClass = [[UILabel alloc] initWithFrame:CGRectMake(620.0, 18.0, 50.0, 13.0)];
        [strClass setTextAlignment:UITextAlignmentRight];
        strClass.font = [UIFont fontWithName:@"TreBuchet MS" size:14 ];
        strClass.text = OccuClass;
        [cell.contentView addSubview:strClass];
        */
        
        if (OccuDesc == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        } 
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    else {
        
        //cell.textLabel.text = [FilteredData objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [FilteredData objectAtIndex:indexPath.row], [FilteredClass objectAtIndex:indexPath.row]];
        
        // comment out display for class in row
        /*
        UILabel *strClass = [[UILabel alloc] initWithFrame:CGRectMake(620.0, 18.0, 50.0, 13.0)];
        [strClass setTextAlignment:UITextAlignmentRight];
        strClass.font = [UIFont fontWithName:@"TreBuchet MS" size:14 ];
        strClass.text = [FilteredClass objectAtIndex:indexPath.row];
        [cell.contentView addSubview:strClass];
         */
        
        if ([FilteredData objectAtIndex:indexPath.row] == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        } 
        else
        {
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
        
    }
    else {
        isFiltered = true;
        FilteredData = [[NSMutableArray alloc] init ];
        FilteredCode = [[NSMutableArray alloc] init ];
        FilteredClass = [[NSMutableArray alloc] init ];
        
        for (int a =0; a<_OccupDesc.count; a++ ) {
            NSRange Occu = [[_OccupDesc objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
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
        
        if (isFiltered == false) {
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            NSString *OccuDesc = [_OccupDesc objectAtIndex:indexPath.row];
            [_delegate OccupDescSelected:OccuDesc];
            
            NSString *occupCode = [_OccupCode objectAtIndex:indexPath.row];
            [_delegate OccupCodeSelected:occupCode];
            
            NSString *occupClass = [_OccupClass objectAtIndex:indexPath.row];
            [_delegate OccupClassSelected:occupClass];
            
            SelectedString = [_OccupDesc objectAtIndex:indexPath.row ];
    
        } 
        else {
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            NSString *OccuDesc = [FilteredData objectAtIndex:indexPath.row];
            [_delegate OccupDescSelected:OccuDesc];
            
            NSString *occupCode = [FilteredCode objectAtIndex:indexPath.row];
            [_delegate OccupCodeSelected:occupCode];
            
            NSString *occupClass = [FilteredClass objectAtIndex:indexPath.row];
            [_delegate OccupClassSelected:occupClass];
            
            SelectedString = [FilteredData objectAtIndex:indexPath.row];
            
        }
    }
    
    [tableView reloadData];
}

@end
