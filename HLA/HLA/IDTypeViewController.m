//
//  IDTypeViewController.m
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "IDTypeViewController.h"
NSString *SelectedString;

@interface IDTypeViewController ()

@end

@implementation IDTypeViewController
@synthesize IDTypeCode = _IDTypeCode;
@synthesize IDTypeDesc = _IDTypeDesc;
@synthesize lastIndexPath;
@synthesize delegate = _delegate;
NSUInteger selectedIndex;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    [self getDesc];
	
	self.clearsSelectionOnViewWillAppear = NO;
    
    NSInteger rowsCount = [_IDTypeDesc count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                           heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    
    CGFloat largestLabelWidth = 0;
    for (NSString *IDType in _IDTypeDesc) {
        //Checks size of text using the default font for UITableViewCell's textLabel.
        CGSize labelSize = [IDType sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - db
-(void)getDesc
{
    _IDTypeCode = [[NSMutableArray alloc] init];
    _IDTypeDesc = [[NSMutableArray alloc] init];
    
	[_IDTypeDesc addObject:@"- SELECT -"];
	[_IDTypeCode addObject:@""];
	
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT IdentityCode, IdentityDesc from eProposal_Identification where status = 'A' and IdentityCode <> 'EDD' and IdentityCode <> 'CR'  and IdentityCode <> 'NRIC' order by IdentityDesc"];
		
		if ([[self.requestType description] isEqualToString:@"CO"]) {
			querySQL = [NSString stringWithFormat: @"SELECT IdentityCode, IdentityDesc from eProposal_Identification where status = 'A' and IdentityCode <> 'NRIC' order by IdentityDesc"];
		}
		
		else if ([[self.requestType description] isEqualToString:@"COEdit"]) {
			querySQL = [NSString stringWithFormat: @"SELECT IdentityCode, IdentityDesc from eProposal_Identification where status = 'A' and IdentityCode in ('BC','PP','OLDIC') order by IdentityDesc"];
		}
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [_IDTypeCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [_IDTypeDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
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
    return [_IDTypeCode count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	
	NSString *IDTypeDesc = [_IDTypeDesc objectAtIndex:indexPath.row];
    cell.textLabel.text = IDTypeDesc;
  
    if ([SelectedString isEqualToString:@""] || (SelectedString == NULL)) {
		SelectedString = [self.IDSelect description];
	}
	
	  
    if ([IDTypeDesc isEqualToString:SelectedString]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
   // NSLog(@"TextLabel: %@, Row: %d, string: %@", cell.textLabel.text, indexPath.row, SelectedString);
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate != nil) {
        
        
		[self resignFirstResponder];
		[self.view endEditing:TRUE];
		
		NSString *IDTypeDesc = [_IDTypeDesc objectAtIndex:indexPath.row];
		[_delegate IDTypeDescSelected:IDTypeDesc];
		
		NSString *IDTypeCode = [_IDTypeCode objectAtIndex:indexPath.row];
		[_delegate IDTypeCodeSelected:IDTypeCode];
		
		SelectedString = [_IDTypeDesc objectAtIndex:indexPath.row ];
	}
    
    [tableView reloadData];
}

-(void) setTitle:(NSString *)title
{
    SelectedString = title;
    [self.tableView reloadData];
}

#pragma mark - memory
- (void)viewDidUnload
{
    [self setIDTypeCode:nil];
    [self setIDTypeDesc:nil];
    [self setDelegate:nil];
    [super viewDidUnload];
}



@end
