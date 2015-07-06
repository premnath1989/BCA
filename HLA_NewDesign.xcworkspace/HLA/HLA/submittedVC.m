//
//  pending.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "submittedVC.h"

@interface submittedVC ()

@end

@implementation submittedVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        //[selectedIndexes addObject:[NSNumber numberWithInt:indexPath.row]];
    } else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        //[selectedIndexes removeObject:[NSNumber numberWithInt:indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}


- (IBAction)doRefresh:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"iMobile Planner"
                          message: @"Record(s) refresh completed. Please check Proposal Status and Policy No.."
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert setTag:1003];
    [alert show];
    alert = Nil;
}
@end
