//
//  SelectPartner.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SelectPartner.h"
#import "DataClass.h"
#import "textFields.h"

@interface SelectPartner () {
    DataClass *obj;
    UISearchDisplayController *searchDisplayController;
}

@end

@implementation SelectPartner{
    NSMutableArray *clientProfileName;
    NSMutableArray *clientProfileID;
    NSMutableArray *clientProfileIndex;
    NSMutableArray *clientOtherID;
    NSMutableArray *clientOtherIDType;
    NSMutableArray *clientDOB;
    
    NSMutableArray *filteredClientProfileName;
    NSMutableArray *filteredClientProfileID;
    NSMutableArray *filteredClientProfileIndex;
    NSMutableArray *filteredClientOtherID;
    NSMutableArray *filteredClientOtherType;
    NSMutableArray *filteredClientDOB;
    
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
    
    self.controller = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.controller.searchResultsDataSource = self.clientProfileTableView.dataSource;
    self.controller.searchResultsDelegate = self.clientProfileTableView.delegate;
    self.searchBar.delegate = self;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    clientProfileName = [[NSMutableArray alloc] init];
    clientProfileID = [[NSMutableArray alloc] init];
    clientProfileIndex = [[NSMutableArray alloc] init];
    clientOtherID = [[NSMutableArray alloc] init];
    clientOtherIDType = [[NSMutableArray alloc] init];
    clientDOB = [[NSMutableArray alloc] init];
    
    filteredClientProfileName = [NSMutableArray array];
    filteredClientProfileID = [NSMutableArray array];
    filteredClientProfileIndex = [NSMutableArray array];
    filteredClientOtherID = [NSMutableArray array];
    filteredClientOtherType = [NSMutableArray array];
    filteredClientDOB = [NSMutableArray array];
    
    obj = [DataClass getInstance];
    
    //NSLog(@"%@",dbPath);
    FMDatabase *db  = [[FMDatabase alloc] initWithPath:dbPath];
    
    [db open];
    // bug 2751
    FMResultSet *fResult= [db executeQuery:@"SELECT IndexNo, ProspectName, IDTypeNo, OtherIDTypeNo, OtherIDType, ProspectDOB from prospect_profile where QQFlag = 'false' ORDER BY LOWER(ProspectName) ASC", nil];
    
    
    
    while([fResult next])
	{
        dbStr = [fResult stringForColumn:@"ProspectName"];
        [clientProfileName addObject:dbStr];
        dbStr = [fResult stringForColumn:@"IDTypeNo"];
        if (dbStr == NULL){
            dbStr = @"";
        }
		if ([[fResult stringForColumn:@"OtherIDType"] isEqualToString:@"EDD"]) {
			dbStr = [fResult stringForColumn:@"ProspectDOB"];
		}
        [clientProfileID addObject:dbStr];
        dbStr = [fResult stringForColumn:@"IndexNo"];
        [clientProfileIndex addObject:dbStr];
        [clientOtherID addObject:[fResult objectForColumnName:@"OtherIDTypeNo"]];
        //NSLog(@"The data is %@=",dbStr);
        [clientOtherIDType addObject:[fResult objectForColumnName:@"OtherIDType"]];
        [clientDOB addObject:[fResult objectForColumnName:@"ProspectDOB"]];
        
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
    /*[self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];*/
    if (searchString.length != 0) {
        [self searchTextFiltering:searchString];
    }
    
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        [self searchTextFiltering:searchText];
    }
}

-(void)searchTextFiltering:(NSString *)searchText {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo LIKE \"%%%@%%\" OR OtherIDTypeNO LIKE \"%%%@%%\" OR ProspectName LIKE \"%%%@%%\" AND QQFlag = 'false' ORDER BY LOWER(ProspectName) ASC", searchText, searchText, searchText]];
    
    [filteredClientProfileName removeAllObjects];
    [filteredClientProfileID removeAllObjects];
    [filteredClientProfileIndex removeAllObjects];
    [filteredClientOtherID removeAllObjects];
    [filteredClientOtherType removeAllObjects];
    [filteredClientDOB removeAllObjects];
    
    while([result next])
	{
        dbStr = [result stringForColumn:@"ProspectName"];
        [filteredClientProfileName addObject:dbStr];
        dbStr = [result stringForColumn:@"IDTypeNo"];
        if (dbStr == NULL){
            dbStr = @"";
        }
		if ([[result stringForColumn:@"OtherIDType"] isEqualToString:@"EDD"]) {
			dbStr = [result stringForColumn:@"ProspectDOB"];
		}
        [filteredClientProfileID addObject:dbStr];
        dbStr = [result stringForColumn:@"IndexNo"];
        [filteredClientProfileIndex addObject:dbStr];
        [filteredClientOtherID addObject:[result objectForColumnName:@"OtherIDTypeNo"]];
        [filteredClientOtherType addObject:[result objectForColumnName:@"OtherIDType"]];
        [filteredClientDOB addObject:[result objectForColumnName:@"ProspectDOB"]];

	}
    
    [db close];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
     if (tableView != self.clientProfileTableView) {
     return [filteredClientProfileIndex count];
     
     } else {
     return [clientProfileIndex count];
     
     }
     
    //return [clientProfileName count];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    //NSLog(@"dsa");
    [self.view endEditing:YES];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"clientProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    /*arrayData = [clientProfileName objectAtIndex:indexPath.row];
    cell.textLabel.text  = arrayData;
    arrayData = [clientProfileID objectAtIndex:indexPath.row];
    NSString *arrayData2 = [clientOtherID objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", arrayData, arrayData2];
    if ([arrayData isEqualToString:@""]) {
        cell.detailTextLabel.text = arrayData2;
    }
    cell.detailTextLabel.numberOfLines = 2;
    cell.tag = [[clientProfileIndex objectAtIndex:indexPath.row] intValue];*/
    
    //NSLog(@"WWWW%d",cell.tag);
    
    
    
    //eData = [clientProfileID objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = eData;
    if (tableView != self.clientProfileTableView) {
        arrayData = [filteredClientProfileName objectAtIndex:indexPath.row];
        cell.textLabel.text  = arrayData;
        arrayData = [filteredClientProfileID objectAtIndex:indexPath.row];
        NSString *arrayData2 = [filteredClientOtherID objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@", arrayData, arrayData2];
        if ([arrayData isEqualToString:@""]) {
            cell.detailTextLabel.text = arrayData2;
        }
        cell.detailTextLabel.numberOfLines = 2;
        cell.tag = [[filteredClientProfileIndex objectAtIndex:indexPath.row] intValue];
        if ([[textFields trimWhiteSpaces:[filteredClientOtherType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[filteredClientDOB objectAtIndex:indexPath.row]];
        }
    }
    else {
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
        if ([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[clientDOB objectAtIndex:indexPath.row]];
        }
    }
    
    
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
     initWithTitle: @" "
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
     initWithTitle: NSLocalizedString(@" ",nil)
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
    if (selectedClientProfileIndex == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"] intValue] && !_child) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Partner/Spouse cannot be same as CFF’s customer." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    else if (tableView != _clientProfileTableView) {
        if (([[textFields trimWhiteSpaces:[filteredClientOtherType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame || [[textFields trimWhiteSpaces:[filteredClientOtherType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"CR"] == NSOrderedSame) && !_child) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company cannot be the Partner/Spouse for CFF’s customer." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
        else if (([[textFields trimWhiteSpaces:[filteredClientOtherType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame || [[textFields trimWhiteSpaces:[filteredClientOtherType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame) && !_child) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be the Partner/Spouse for a CFF’s payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
    }
    else if (tableView == _clientProfileTableView) {
        if (([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame || [[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"CR"] == NSOrderedSame) && !_child) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company cannot be the Partner/Spouse for CFF’s customer." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
        else if (([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame || [[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame) && !_child) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be the Partner/Spouse for a CFF’s payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
    }
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
    [self setSearchBar:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}
- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doAdd:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @" "
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
