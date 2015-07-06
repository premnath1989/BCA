//
//  IssuingBankPopoverVC.m
//  iMobile Planner
//
//  Created by Juliana on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "IssuingBankPopoverVC.h"

@interface IssuingBankPopoverVC ()

@end

@implementation IssuingBankPopoverVC

-(id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
		
		databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		
		[self getIssuingBank];
		
		self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [_IssuingBank count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        
        CGFloat largestLabelWidth = 0;
        for (NSString *FPT in _IssuingBank) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [FPT sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    return self;
}

- (void)getIssuingBank {
	
	_IssuingBank = [[NSMutableArray alloc] init];
	dbpath = [databasePath UTF8String];
	if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
		NSString *querySQL = [NSString stringWithFormat:@"SELECT CompanyName FROM eProposal_Credit_Card_Bank"];
		const char *query_stmt = [querySQL UTF8String];
		if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW){
				[_IssuingBank addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}//
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_IssuingBank count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    // Configure the cell...
    cell.textLabel.text = [_IssuingBank objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedIssuingBank = [_IssuingBank objectAtIndex:indexPath.row];
    
    //Notify the delegate if it exists.
    if (_delegate != nil) {
        [_delegate selectedIssuingBank:selectedIssuingBank];
    }
}

@end
