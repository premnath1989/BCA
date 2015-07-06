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
#import "textFields.h"

@interface PersonalDetialsViewController ()
@end

@implementation PersonalDetialsViewController{
    NSMutableArray *clientProfileName;
    NSMutableArray *clientProfileID;
    NSMutableArray *clientProfileIndex;
    NSMutableArray *clientOccp;
    NSMutableArray *clientDOB;
    NSMutableArray *clientOtherID;
    NSMutableArray *clientOtherIDType;
    
    NSMutableArray *filteredClientProfileName;
    NSMutableArray *filteredClientProfileID;
    NSMutableArray *filteredClientProfileIndex;
    NSMutableArray *filteredClientOccp;
    NSMutableArray *filteredClientDOB;
    NSMutableArray *filteredClientOtherID;
    NSMutableArray *filteredClientOtherIDType;
    
    NSArray *clientProfileNameResults;
    NSArray *clientProfileIDResults;
    NSArray *blacklistOccp;
    
    NSString *dbStr;
    int dbInt;
    
    NSString *arrayData;
    
    int selectedClientProfileIndex;
    NSString *selectedClientProfileName;
    NSString *selectedClientProfileID;
    
    FMDatabase *db;
}

//@synthesize delegate;
@synthesize existingClient, existingClient2;

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
    clientDOB = [[NSMutableArray alloc] init];
    clientOccp = [[NSMutableArray alloc] init];
    clientOtherID = [[NSMutableArray alloc] init];
    clientOtherIDType = [[NSMutableArray alloc] init];
    
    filteredClientProfileName = [[NSMutableArray alloc] init];
    filteredClientProfileID = [[NSMutableArray alloc] init];
    filteredClientProfileIndex = [[NSMutableArray alloc] init];
    filteredClientDOB = [[NSMutableArray alloc] init];
    filteredClientOccp = [[NSMutableArray alloc] init];
    filteredClientOtherID = [[NSMutableArray alloc] init];
    filteredClientOtherIDType = [[NSMutableArray alloc] init];
    
    //NSLog(@"%@",dbPath);
    db  = [[FMDatabase alloc] initWithPath:dbPath];
    
    [db open];
    
    FMResultSet *fResult= [db executeQuery:@"SELECT IndexNo, ProspectName, IDTypeNo, ProspectOccupationCode, ProspectDOB, OtherIDTypeNo, OtherIDType from prospect_profile where QQFlag = 'false' ORDER BY LOWER(ProspectName) ASC"];
    
    
    
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
        [clientOccp addObject:[fResult objectForColumnName:@"ProspectOccupationCode"]];
        [clientDOB addObject:[fResult objectForColumnName:@"ProspectDOB"]];
        [clientOtherID addObject:[fResult objectForColumnName:@"OtherIDTypeNo"]];
        [clientOtherIDType addObject:[fResult objectForColumnName:@"OtherIDType"]];
        //NSLog(@"The data is %@=",dbStr);


	}
    
    [db close];
    
    blacklistOccp = [[NSArray alloc] initWithObjects:@"OCC02147", @"OCC01179", @"OCC01865", @"OCC02317", @"OCC02229", @"OCC01109" ,nil];
    
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
    /*[self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];*/
    if (searchString.length != 0) {
        [self searchTextFiltering:searchString];
    }
    
    return YES;
}

-(void)searchTextFiltering:(NSString *)searchText {
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo LIKE \"%%%@%%\" OR OtherIDTypeNO LIKE \"%%%@%%\" OR ProspectName LIKE \"%%%@%%\" AND QQFlag = 'false' ORDER BY ProspectName ASC", searchText, searchText, searchText]];
    
    [filteredClientProfileName removeAllObjects];
    [filteredClientProfileID removeAllObjects];
    [filteredClientProfileIndex removeAllObjects];
    [filteredClientDOB removeAllObjects];
    [filteredClientOccp removeAllObjects];
    [filteredClientOtherID removeAllObjects];
    [filteredClientOtherIDType removeAllObjects];
    
    while([result next])
	{
        dbStr = [result stringForColumn:@"ProspectName"];
        [filteredClientProfileName addObject:dbStr];
        dbStr = [result stringForColumn:@"IDTypeNo"];
        if (dbStr == NULL){
            dbStr = @"";
        }
        [filteredClientProfileID addObject:dbStr];
        dbStr = [result stringForColumn:@"IndexNo"];
        [filteredClientProfileIndex addObject:dbStr];
        [filteredClientOccp addObject:[result objectForColumnName:@"ProspectOccupationCode"]];
        [filteredClientDOB addObject:[result objectForColumnName:@"ProspectDOB"]];
        [filteredClientOtherID addObject:[result objectForColumnName:@"OtherIDTypeNo"]];
        [filteredClientOtherIDType addObject:[result objectForColumnName:@"OtherIDType"]];
	}
    
    [db close];
    
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
    if (tableView == self.clientProfileTableView) {
        return [clientProfileName count];
    }
    return [filteredClientProfileIndex count];
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
    
    if (tableView == self.clientProfileTableView) {
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
        if (([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[clientDOB objectAtIndex:indexPath.row]];
        }
    }
    else {
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
        if (([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)) {
            cell.detailTextLabel.text = [textFields trimWhiteSpaces:[filteredClientDOB objectAtIndex:indexPath.row]];
        }
    }
    
    
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
    
    // check if selected client already have cff tied to it
    if (tableView == self.clientProfileTableView) {
        if ([existingClient containsObject:[clientProfileID objectAtIndex:indexPath.row]] && [[clientProfileID objectAtIndex:indexPath.row] length] != 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"The client selected already have a CFF."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        else if ([existingClient2 containsObject:[clientOtherID objectAtIndex:indexPath.row]] && [[clientOtherID objectAtIndex:indexPath.row] length] != 0 && ![[clientOtherID objectAtIndex:indexPath.row] isEqualToString:@"- Select -"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"The client selected already have a CFF."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        else if (([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"CR"] == NSOrderedSame)) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Company cannot be appointed as CFF’s Payor."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        else if (([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EXPECTED DELIVERY DATE"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[clientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be appointed as CFF’s payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/mm/yyyy"];
        NSDate* birthday = [dateFormat dateFromString:[clientDOB objectAtIndex:indexPath.row]];
        
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                           components:NSYearCalendarUnit
                                           fromDate:birthday
                                           toDate:now
                                           options:0];
        NSInteger age = [ageComponents year];
        
        if (age < 18) {
            [db open];
            NSString *group = nil;
            FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", [clientOccp objectAtIndex:indexPath.row], nil];
            while ([result next]) {
                group = [result objectForColumnName:@"OccpCatCode"];
            }
            [db close];
            if ([[textFields trimWhiteSpaces:group] isEqualToString:@"STU"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Student below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"JUV"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Juvenile cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"RET"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Retired below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"UNEMP"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Unemployed below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            /*else if ([group isEqualToString:@"OCC02229"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Temporarily Unemployed below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }*/
        }
        else if (age > 18) {
			
            [db open];
            NSString *group = nil;
            FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", [clientOccp objectAtIndex:indexPath.row], nil];
            while ([result next]) {
                group = [result objectForColumnName:@"OccpCatCode"];
            }
            [db close];
            if ([[textFields trimWhiteSpaces:group] isEqualToString:@"JUV"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Juvenile cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
        }
    }
    else {
        if ([existingClient containsObject:[filteredClientProfileID objectAtIndex:indexPath.row]] && [[filteredClientProfileID objectAtIndex:indexPath.row] length] != 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"The client selected already have a CFF."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        else if ([existingClient2 containsObject:[filteredClientOtherID objectAtIndex:indexPath.row]] && [[filteredClientOtherID objectAtIndex:indexPath.row] length] != 0 && ![[filteredClientOtherID objectAtIndex:indexPath.row] isEqualToString:@"- Select -"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"The client selected already have a CFF."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        if (([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"CR"] == NSOrderedSame)) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Company cannot be appointed as CFF’s Payor."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
		
		else if (([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EXPECTED DELIVERY DATE"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[filteredClientOtherIDType objectAtIndex:indexPath.row]] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be appointed as CFF’s payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
		
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/mm/yyyy"];
        NSDate* birthday = [dateFormat dateFromString:[filteredClientDOB objectAtIndex:indexPath.row]];
        
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                           components:NSYearCalendarUnit
                                           fromDate:birthday
                                           toDate:now
                                           options:0];
        NSInteger age = [ageComponents year];
        
        if (age < 18) {
			
			
			
            [db open];
            NSString *group = nil;
            FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", [filteredClientOccp objectAtIndex:indexPath.row], nil];
            while ([result next]) {
                group = [result objectForColumnName:@"OccpCatCode"];
            }
            [db close];
            if ([[textFields trimWhiteSpaces:group] isEqualToString:@"STU"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Student below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"JUV"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Juvenile cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"RET"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Retired below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            else if ([[textFields trimWhiteSpaces:group] isEqualToString:@"UNEMP"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Unemployed below 18 years old cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
            /*else if ([group isEqualToString:@"OCC02229"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                    initWithTitle: @" "
                    message:@"Temporarily Unemployed below 18 years old cannot be appointed as CFF’s Payor."
                    delegate: self
                    cancelButtonTitle:@"OK"
                    otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
             }*/
        }
        else if (age > 18) {
            [db open];
            NSString *group = nil;
            FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", [filteredClientOccp objectAtIndex:indexPath.row], nil];
            while ([result next]) {
                group = [result objectForColumnName:@"OccpCatCode"];
            }
            [db close];
            if ([[textFields trimWhiteSpaces:group] isEqualToString:@"JUV"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Juvenile cannot be appointed as CFF’s Payor."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return;
            }
        }
    }

    /*if ([blacklistOccp containsObject:[clientOccp objectAtIndex:indexPath.row]]) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Please select other client with Occupation that is not fall under the categories of  'Juvenile', 'Housewife', 'Unemployed', 'Temporarily Unemployed' and 'Student"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
    
    
    
    // executive
    bool whitelistOccp = [[clientOccp objectAtIndex:indexPath.row] isEqualToString:@"OCC00833"];
    NSLog(@"whiltelistOccp: %d, clientOccp: %@", whitelistOccp, [clientOccp objectAtIndex:indexPath.row]);
    if (age < 18 && !whitelistOccp) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Client must be over 18 years old."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }*/
    
    NSIndexPath*    selection = [tableView indexPathForSelectedRow];
    if (selection) {
        [tableView deselectRowAtIndexPath:selection animated:NO];
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
                          initWithTitle: @" "
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
