//
//  FullyReducePaidUpPopover.m
//  iMobile Planner
//
//  Created by Erza on 1/21/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FullyReducePaidUpPopover.h"
#import "DataClass.h"

@interface FullyReducePaidUpPopover () {
	DataClass *obj;
}

@end

@implementation FullyReducePaidUpPopover

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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doDone:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(doCancel:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationController.title = @"Fully/Reduced Paid Up";
    
    _yearTxt.enabled = FALSE;
    obj = [DataClass getInstance];
    if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] objectForKey:_riderCode]) {
    	_paidUpSeg.selectedSegmentIndex = 0;
    	_yearTxt.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] objectForKey:_riderCode];
    	_yearTxt.enabled = TRUE;
    }
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
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)doDone:(id)sender {
	if (_paidUpSeg.selectedSegmentIndex == 0) {
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] setValue:_yearTxt.text forKey:_riderCode];
	}
	NSLog(@"Riders: %@", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"]);
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)doCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setPaidUpSeg:nil];
    [self setYearTxt:nil];
    [super viewDidUnload];
}
- (IBAction)paidUpChg:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _yearTxt.enabled = TRUE;
    }
    else if (sender.selectedSegmentIndex == 1) {
        _yearTxt.enabled = FALSE;
    }
}

// to fix orientation bug
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
