//
//  siListingSortBy.m
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "siListingSortBy.h"



@interface siListingSortBy ()

@end

@implementation siListingSortBy
@synthesize SortBy = _SortBy;
@synthesize lastIndexPath;
@synthesize delegate = _delegate;
@synthesize SelectedSortBy;

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
    self.SortBy = [NSMutableArray array];
    [_SortBy addObject:@"SI NO"];
    [_SortBy addObject:@"Name"];
    [_SortBy addObject:@"Plan Name"];
    [_SortBy addObject:@"Sum Assured/ Benefit"];
    [_SortBy addObject:@"Date Created"];
    SelectedSortBy = [[NSMutableArray alloc] init ];
    
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.textLabel.text = [_SortBy objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;   
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    
    
    
    for (UITableViewCell *zzz in tableView.visibleCells) {
        NSIndexPath *IndexpathItem = [tableView indexPathForCell:zzz];
        if (zzz.selected == TRUE) {
            if (zzz.accessoryType == UITableViewCellAccessoryCheckmark) {
                [SelectedSortBy removeObject:[_SortBy objectAtIndex:IndexpathItem.row]];
            }
            else {
                [SelectedSortBy addObject: [_SortBy objectAtIndex:IndexpathItem.row ] ];
                
            }
        }
        /*
        else {
            if (!zzz.accessoryType == UITableViewCellAccessoryCheckmark) {
                [SelectedSortBy removeObject:[_SortBy objectAtIndex:IndexpathItem.row]];
            }
            
        }
         */
    }
    
    UITableViewCell *zzz = [tableView cellForRowAtIndexPath:indexPath];
    if (zzz.accessoryType == UITableViewCellAccessoryCheckmark) {
        zzz.accessoryType = UITableViewCellAccessoryNone;
    } 
    else {
        zzz.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    //NSLog(@"%d", SelectedSortBy.count);
    
    if (_delegate != nil) {
        
        [_delegate SortBySelected:SelectedSortBy];
    }
}

@end
