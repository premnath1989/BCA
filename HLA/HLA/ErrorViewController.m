//
//  ErrorViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 4/24/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ErrorViewController.h"
#import "submittedVC.h"
#import "FMDatabase.h"
#import "PendingVCCell.h"


@interface ErrorViewController ()
{
    NSString *databasePath;
    
    NSMutableArray *selectedRecords;
    
}
@property (retain, nonatomic) NSMutableArray *ProposalNo;

@end


@implementation ErrorViewController

@synthesize proposalNumber;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.errorTableView.backgroundView = nil;
    self.errorTableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    CGRect frame = self.view.frame;
    frame.size.width = 1024;
    frame.size.height = 768;
    self.view.frame = frame;
    
    
    [self DispalyTableData];
    
    
    
    
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
    return 1;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.errorTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
   // cell.textLabel.text = [self.errorDescriptionArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.errorDescriptionArray objectAtIndex:0];
    cell.detailTextLabel.text = [self.errorDescriptionArray objectAtIndex:1];
    
    NSLog(@"DEtailTextLabel %@",cell.detailTextLabel.text);
    
    cell.textLabel.numberOfLines = 0;
    //cell.textLabel.adjustsFontSizeToFitWidth=YES;
    
    //cell.errorLabel.textColor = [UIColor yellowColor];
    //cell.textLabel.textColor=[UIColor blueColor];
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.errorDescriptionArray objectAtIndex:indexPath.row];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",size.height);
    return size.height + 20;
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
     *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(void)DispalyTableData
{
    //fmdb start
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
	FMResultSet *results;
    NSString *errordesc=@"";
    NSString *errorDateTime=@"";
    
    
    
    _errorDescriptionArray = [[NSMutableArray alloc] init];
    
    //NSString *strProposalNo = [self.ProposalNo objectAtIndex:rowIndex];
    
    // RN140421101939051 proposalNumber
    //results = [db executeQuery:@"select ErrorDesc from eProposal_Error_Listing  WHERE  RefNo = '%@'",proposalNumber];
    //results = [db executeQuery:@"select ErrorDesc from eProposal_Error_Listing  WHERE  RefNo = 'RN140601032457862' order by ID asc"];
    results = [db executeQuery:@"select ErrorDesc,CreateDate from eProposal_Error_Listing  WHERE  RefNo = ? order by ID asc",proposalNumber];
    
    while([results next]) {
		
        errordesc  =[results stringForColumn:@"ErrorDesc"];
        errorDateTime  =[results stringForColumn:@"CreateDate"];
        
                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ:00"];
            NSDate *dateFromString = [[NSDate alloc] init];
            dateFromString = [dateFormatter dateFromString:errorDateTime];
            
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
            NSString *FormatedDate =[formatter stringFromDate:dateFromString];
            
            [_errorDescriptionArray addObject:errordesc];
            [_errorDescriptionArray addObject:FormatedDate];

        
        
        //        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        //        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        //        NSString* str = @"2014-08-07T09:38:54.933+0800:00";   // NOTE -0700 is the only change
        //        NSDate* date = [df dateFromString:str];
        
               
        
    }
    [db close];
    
    [_errorDescriptionArray addObject:@""];
    [_errorDescriptionArray addObject:@""];
    
}
- (IBAction)selectCancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    //[self setPolicyno:nil];
    
    
    [self setErrorLabel1:nil];
    [super viewDidUnload];
}


@end