//
//  pending.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "pendingVC.h"

@interface pendingVC ()

@end

@implementation pendingVC

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

- (IBAction)doSubmit:(id)sender {

    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                          message: NSLocalizedString(@"This will submit the selected proposal(s) to HLA.\nPlease ensure Internet connection is available until completion.\nDo you want to submit?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1001];
    [alert show];
    alert = Nil;


}

- (IBAction)doUnconfirmed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                          message: NSLocalizedString(@"This will unconfirmed the selected proposal(s).\nDo you want to continue?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1002];
    [alert show];
    alert = Nil;
}
@end
