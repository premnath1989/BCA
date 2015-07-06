//
//  SelectPartner.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SelectPartner.h"

@interface SelectPartner ()

@end

@implementation SelectPartner{
    NSMutableArray *clientProfileName;
    NSMutableArray *clientProfileID;
    NSMutableArray *clientProfileIndex;
    
    NSArray *clientProfileNameResults;
    NSArray *clientProfileIDResults;
    
    NSString *dbStr;
    int dbInt;
    
    NSString *arrayData;
    
    int selectedClientProfileIndex;
    NSString *selectedClientProfileName;
    NSString *selectedClientProfileID;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    clientProfileName = [[NSMutableArray alloc] init];
    clientProfileID = [[NSMutableArray alloc] init];
    clientProfileIndex = [[NSMutableArray alloc] init];
    
    
    //NSLog(@"%@",dbPath);
    FMDatabase *db  = [[FMDatabase alloc] initWithPath:dbPath];
    
    [db open];
    
    FMResultSet *fResult= [db executeQuery:@"SELECT IndexNo, ProspectName, IDTypeNo from prospect_profile"];
    
    
    
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
        //NSLog(@"The data is %@=",dbStr);
        
        
	}
    
    [db close];

}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    //[ filterUsingPredicate:pred];
    //clientProfileNameResults = [clientProfileName filterUsingPredicate:resultPredicate];
    clientProfileNameResults = [clientProfileName filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
     if (tableView == self.searchDisplayController.searchResultsTableView) {
     return [clientProfileResults count];
     
     } else {
     return [clientProfile count];
     
     }
     */
    return [clientProfileName count];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    //NSLog(@"dsa");
    [self.view endEditing:YES];
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
    cell.detailTextLabel.text = arrayData;
    cell.tag = [[clientProfileIndex objectAtIndex:indexPath.row] intValue];
    
    
    //NSLog(@"WWWW%d",cell.tag);
    
    
    
    //eData = [clientProfileID objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = eData;
    
    /*
     if (tableView == self.searchDisplayController.searchResultsTableView) {
     cell.textLabel.text = [clientProfileResults objectAtIndex:indexPath.row];
     cell.detailTextLabel.text = [clientProfileID objectAtIndex:indexPath.row];
     } else {
     cell.textLabel.text = [clientProfile objectAtIndex:indexPath.row];
     cell.detailTextLabel.text = [clientProfileID objectAtIndex:indexPath.row];;
     }
     */
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     if (indexPath.row == 0){
     [self.delegate CustomerViewDisplay:@"customer"];
     }
     else if (indexPath.row == 1){
     [self.delegate CustomerViewDisplay:@"spouse"];
     }
     
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message: @"Please confirm proposal form before e-Signature"
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert setTag:1003];
     [alert show];
     alert = Nil;
     */
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedClientProfileIndex = selectedCell.tag;
    selectedClientProfileName = selectedCell.textLabel.text;
    selectedClientProfileID = selectedCell.detailTextLabel.text;
    //NSLog(@"%@",selectedCell.textLabel.text);
    
    /*
     NSString *msg;
     
     msg = [NSString stringWithFormat:@"Do you want to create new CFF for %@?", selectedCell.textLabel.text];
     
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
     message: NSLocalizedString(msg,nil)
     delegate: self
     cancelButtonTitle: NSLocalizedString(@"Yes",nil)
     otherButtonTitles: NSLocalizedString(@"No",nil), nil];
     [alert setTag:2001];
     [alert show];
     alert = Nil;
     */
    
    NSIndexPath *selection = [_clientProfileTableView indexPathForSelectedRow];
    if (selection) {
        [_clientProfileTableView deselectRowAtIndexPath:selection animated:NO];
    }
    
    
    //if (buttonIndex == 0){
    //[self.delegate DisplayNewCFF:selectedClientProfileIndex];
    
    //NSLog(@"sacs");
    [self.delegate DisplayPartnerCFF:selectedClientProfileIndex clientName:selectedClientProfileName clientID:selectedClientProfileID];
    
    //[self.delegate di];
    
    
    //}
    //else{
    //}
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2001){
        
        NSIndexPath*    selection = [_clientProfileTableView indexPathForSelectedRow];
        if (selection) {
            [_clientProfileTableView deselectRowAtIndexPath:selection animated:NO];
        }
        
        
        if (buttonIndex == 0){
            //[self.delegate DisplayNewCFF:selectedClientProfileIndex];
            [self.delegate DisplayPartnerCFF:selectedClientProfileIndex clientName:selectedClientProfileName clientID:selectedClientProfileID];
        }
        else{
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setClientProfileTableView:nil];
    [super viewDidUnload];
}
- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doAdd:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"iMobile Planner"
                          message: @"No Implementation"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    
    
    [alert setTag:1001];
    [alert show];
    alert = Nil;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
