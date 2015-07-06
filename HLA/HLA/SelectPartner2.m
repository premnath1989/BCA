//
//  SelectPartner2.m
//  iMobile Planner
//
//  Created by Erza on 1/2/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SelectPartner2.h"
#import "DataClass.h"
#import "FMDatabase.h"

@interface SelectPartner2 ()

@end

@implementation SelectPartner2 {
    DataClass *obj;
    
    NSMutableArray *clientProfileName;
    NSMutableArray *clientProfileID;
    NSMutableArray *clientProfileIndex;
    NSMutableArray *clientOtherID;
    
    NSMutableArray *filteredClientProfileName;
    NSMutableArray *filteredClientProfileID;
    NSMutableArray *filteredClientProfileIndex;
    NSMutableArray *filteredClientOtherID;
    
    NSArray *clientProfileNameResults;
    NSArray *clientProfileIDResults;
    
    NSString *dbStr;
    int dbInt;
    
    NSString *arrayData;
    
    int selectedClientProfileIndex;
    NSString *selectedClientProfileName;
    NSString *selectedClientProfileID;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    clientProfileName = [[NSMutableArray alloc] init];
    clientProfileID = [[NSMutableArray alloc] init];
    clientProfileIndex = [[NSMutableArray alloc] init];
    clientOtherID = [[NSMutableArray alloc] init];
    
    filteredClientProfileName = [NSMutableArray array];
    filteredClientProfileID = [NSMutableArray array];
    filteredClientProfileIndex = [NSMutableArray array];
    filteredClientOtherID = [NSMutableArray array];
    
    obj = [DataClass getInstance];
    
    //NSLog(@"%@",dbPath);
    FMDatabase *db  = [[FMDatabase alloc] initWithPath:dbPath];
    
    [db open];
    // bug 2751
    FMResultSet *fResult= [db executeQuery:@"SELECT IndexNo, ProspectName, IDTypeNo, OtherIDTypeNo from prospect_profile where QQFlag = 'false' AND IndexNo != ?", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"], nil];
    
    
    
    while([fResult next])
	{
        dbStr = [fResult stringForColumn:@"ProspectName"];
        [clientProfileName addObject:dbStr];
        dbStr = [fResult stringForColumn:@"IDTypeNo"];
        if (dbStr == NULL){
            dbStr = @"";
        }
        [clientProfileID addObject:dbStr];
        dbStr = [fResult stringForColumn:@"IndexNo"];
        [clientProfileIndex addObject:dbStr];
        [clientOtherID addObject:[fResult objectForColumnName:@"OtherIDTypeNo"]];
        NSLog(@"The data is %@=",dbStr);
        
        
	}
    
    [db close];
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
    return [clientProfileName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"clientProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    arrayData = [clientProfileName objectAtIndex:indexPath.row];
    cell.textLabel.text  = arrayData;
    arrayData = [clientProfileID objectAtIndex:indexPath.row];
    NSString *arrayData2 = [clientOtherID objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", arrayData, arrayData2];
    if ([arrayData isEqualToString:@""]) {
        cell.detailTextLabel.text = arrayData2;
    }
    cell.detailTextLabel.numberOfLines = 2;
    cell.tag = [[clientProfileIndex objectAtIndex:indexPath.row] intValue];
    
    //NSLog(@"WWWW%d",cell.tag);
    
    
    
    //eData = [clientProfileID objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = eData;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58.0;
}
@end
