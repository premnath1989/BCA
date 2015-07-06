//
//  PopOverFundViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PopOverFundViewController.h"

@interface PopOverFundViewController ()

@end

@implementation PopOverFundViewController
@synthesize delegate;
@synthesize ListOfFund;

-(id)initWithString:(NSString *)sino {
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	ListOfFund = [[NSMutableArray alloc] init ];
	
	sqlite3_stmt *statement;
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"Select vu2023, vu2025, vu2028, vu2030, vu2035 "
							  "FROM UL_Details where sino = '%@' ", sino ];
		
		//NSLog(@"%@", querySQL);
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW)
			{
				
				if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"0"]) {
					[ListOfFund addObject:@"HLA EverGreen 2023"];
				}
				
				if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"0"]) {
					[ListOfFund addObject:@"HLA EverGreen 2025"];
				}
				
				if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] isEqualToString:@"0"]) {
					[ListOfFund addObject:@"HLA EverGreen 2028"];
				}

				if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] isEqualToString:@"0"]) {
					[ListOfFund addObject:@"HLA EverGreen 2030"];
				}
				
				if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] isEqualToString:@"0"]) {
					[ListOfFund addObject:@"HLA EverGreen 2035"];
				}
				
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	return  self;
}

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
	
	
	//ListOfFund = [[NSMutableArray alloc] initWithObjects:@"HLA EverGreen 2028", @"HLA EverGreen 2035", nil ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ListOfFund count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfFund objectAtIndex:indexPath.row];
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	[delegate Fundlisting:self andDesc:[ListOfFund objectAtIndex:indexPath.row]];
}

@end
