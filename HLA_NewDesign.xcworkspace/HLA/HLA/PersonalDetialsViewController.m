//
//  PersonalDetialsViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PersonalDetialsViewController.h"
#import "CustomerViewController.h"
#import "ColorHexCode.h"

@interface PersonalDetialsViewController ()
@end

@implementation PersonalDetialsViewController{
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

//@synthesize delegate;
@synthesize existingClient;

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
     //clientProfile = [NSArray arrayWithObjects:@"Santhiya Sree", @"Kumareganesh Govindan", @"Ng Mei Yee", @"Foong Kit Leong", @"Shawal Sapuan", nil];
     //clientProfileID = [NSArray arrayWithObjects:@"790620145681", @"Andy Phan Seng", @"Roslinda Rosli", @"Foong Kit Leong", @"Shawal Sapuan", nil];
     //clientProfileID = [NSArray arrayWithObjects:@"890213095268", @"860909145261", @"781223059866", @"780401146489", @"870129114243", nil];
    
    //UIColor *tintColor = [UIColor colorWithRed:195/255.0f green:212/255.0f blue:255/255.0f alpha:1];
    //[self.navigationController.navigationBar setTintColor:tintColor];
    
    
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    //_formTitle.textColor = [CustomColor colorWithHexString:@"234A7D"];
   
    /*
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Select Client Profile";
    self.navigationItem.titleView = label;
     */
    
	// Do any additional setup after loading the view.

    //NSString *dbPath  = [[NSBundle mainBundle] pathForResource:@"documents/hladb" ofType:@"sqlite"];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    clientProfileName = [[NSMutableArray alloc] init];
    clientProfileID = [[NSMutableArray alloc] init];
    clientProfileIndex = [[NSMutableArray alloc] init];
    
    
    //NSLog(@"%@",dbPath);
    FMDatabase *db  = [[FMDatabase alloc] initWithPath:dbPath];
    
    [db open];
    
    FMResultSet *fResult= [db executeQuery:@"SELECT IndexNo, ProspectName, IDTypeNo from prospect_profile where QQFlag = 'false'"];
    
    
    
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
    
    //NSLog(@"QQQQ%d",[clientProfileName count]);

}


- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
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
    
    // check if selected client already have cff tied to it
    if ([existingClient containsObject:selectedClientProfileID]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"The client selected already have a CFF."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
    
    NSIndexPath*    selection = [_clientProfileTableView indexPathForSelectedRow];
    if (selection) {
        [_clientProfileTableView deselectRowAtIndexPath:selection animated:NO];
    }
    
    
    //if (buttonIndex == 0){
        //[self.delegate DisplayNewCFF:selectedClientProfileIndex];
        [self.delegate DisplayNewCFF:selectedClientProfileIndex clientName:selectedClientProfileName clientID:selectedClientProfileID];
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
            [self.delegate DisplayNewCFF:selectedClientProfileIndex clientName:selectedClientProfileName clientID:selectedClientProfileID];
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

- (IBAction)doCancel:(id)sender {
    
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

- (IBAction)doAdd:(id)sender {
[self dismissViewControllerAnimated:TRUE completion:nil];

}
- (void)viewDidUnload {
    [self setTitle:nil];
    [self setClientProfileTableView:nil];
    [super viewDidUnload];
}
@end
