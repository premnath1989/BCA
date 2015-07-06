//
//  SelectCFF.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SelectCFF.h"

#import "DataClass.h"

#import "MasterMenuCFFeApp.h"
#import "MasterMenuCFF.h"
#import "PersonalDataViewController.h"

@interface SelectCFF (){
    NSMutableArray *clientProfile;
    NSMutableArray *clientProfileID;
    NSArray *clientProfileResults;
    NSArray *clientProfileIDResults;
    
    DataClass *obj;
}

@end

@implementation SelectCFF

@synthesize clientData;
@synthesize arrName;
@synthesize arrIdNo;
@synthesize arrDate;
@synthesize arrStatus;
@synthesize arrCFFID;
@synthesize arrClientProfileID;
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    clientProfile = [NSArray arrayWithObjects:@"Santhiya Sree", nil];
    //clientProfileID = [NSArray arrayWithObjects:@"790620145681", @"Andy Phan Seng", @"Roslinda Rosli", @"Foong Kit Leong", @"Shawal Sapuan", nil];
    clientProfileID = [NSArray arrayWithObjects:@"Updated on: 10/07/2013", nil];
    
    [clientData removeAllObjects];
    [arrName removeAllObjects];
    [arrCFFID removeAllObjects];
    [arrIdNo removeAllObjects];
    [arrStatus removeAllObjects];
    [arrDate removeAllObjects];
    [arrClientProfileID removeAllObjects];
    
    
    
    clientData = [[NSMutableArray alloc] init];
    arrName = [[NSMutableArray alloc] init];
    arrCFFID = [[NSMutableArray alloc] init];
    arrIdNo = [[NSMutableArray alloc] init];
    arrStatus = [[NSMutableArray alloc] init];
    arrDate = [[NSMutableArray alloc] init];
    arrClientProfileID = [[NSMutableArray alloc] init];
    
    obj = [DataClass getInstance];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *results1;
    
    NSString *sqlQuery = @"";
    
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POIDTypeNo"] != NULL) {
        sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo = %@ ", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POIDTypeNo"]];
    }
    else {
        sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE OtherIDTypeNo = %@ ", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POOtherIDTypeNo"]];
    }
    NSLog(@"sql1: %@", sqlQuery);
    
    results1 = [database executeQuery:sqlQuery];
    NSString *indexNo;
    if ([results1 next]) {
        indexNo = [results1 objectForColumnName:@"IndexNo"];
    }
    
    sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM CFF_Master WHERE CFFType='Master' AND ClientProfileID = %@", indexNo];
    NSLog(@"sql: %@", sqlQuery);
    results= [database executeQuery:sqlQuery];
    
    
    
    [clientData addObject:arrName];
    [clientData addObject:arrIdNo];
    [clientData addObject:arrDate];
    [clientData addObject:arrStatus];
    [clientData addObject:arrCFFID];
    [clientData addObject:arrClientProfileID];
    
    while([results next])
	{
        //NSLog(@"dasd");
		/* taking results from database to a string "eleData" */
		//eleData = [fResult stringForColumn:@"desc"];
		/* adding data from the string object to Array */
		//[aElephant addObject:eleData];
		/* Checking weather data has come or not */
		//NSLog(@"The data is %@=",eleData);
        results1= [database executeQuery:@"SELECT * FROM prospect_profile WHERE IndexNo=?",[results stringForColumn:@"ClientProfileID"]];
        
        while([results1 next]){
            [arrName addObject:[results1 stringForColumn:@"ProspectName"]];
            [arrIdNo addObject:[results1 stringForColumn:@"IDTypeNo"]];
        }
        
        
        [arrDate addObject:[results stringForColumn:@"LastUpdatedAt"]];
        [arrStatus addObject:[results stringForColumn:@"Status"]];
        [arrCFFID addObject:[results stringForColumn:@"ID"]];
        [arrClientProfileID addObject:[results stringForColumn:@"ClientProfileID"]];
        
        [clientData addObject:arrName];
        [clientData addObject:arrIdNo];
        [clientData addObject:arrDate];
        [clientData addObject:arrStatus];
        [clientData addObject:arrCFFID];
        [clientData addObject:arrClientProfileID];
        
        //[arr addObject:[results1 stringForColumn:@"ProspectName"]];
        
        
	}
    [database close];
    
    obj = [DataClass getInstance];
    
    NSString *poName;
    for (NSDictionary *details in [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"]) {
        if ([[details objectForKey:@"POFlag"]isEqualToString:@"Y"]) {
            poName = [details objectForKey:@"LAName"];
            break;
        }
    }
    
    self.naviBar.topItem.title = [[NSString alloc] initWithFormat:@"CFF for %@", poName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doAdd:(id)sender {
    
//    obj=[DataClass getInstance];
//    NSMutableDictionary *data = [NSMutableDictionary dictionary];
//    obj.CFFData = [NSMutableDictionary dictionary];
//    [obj.CFFData setObject:data forKey:@"Sections"];
//    [obj.CFFData setObject:data forKey:@"SecA"];
//    [obj.CFFData setObject:data forKey:@"SecB"];
//    [obj.CFFData setObject:data forKey:@"SecC"];
//    [obj.CFFData setObject:data forKey:@"SecD"];
//    [obj.CFFData setObject:data forKey:@"SecE"];
//    [obj.CFFData setObject:data forKey:@"SecF"];
//    [obj.CFFData setObject:data forKey:@"SecG"];
//    [obj.CFFData setObject:data forKey:@"SecH"];
//    [obj.CFFData setObject:data forKey:@"SecI"];
//    
//    [[obj.CFFData objectForKey:@"SecA"] setValue:@"Disclosure of Intermediary Status" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecB"] setValue:@"Customer's Choice" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecC"] setValue:@"Customer's Personal Data" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecD"] setValue:@"Potential Areas for Discussion" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecE"] setValue:@"Preference" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecF"] setValue:@"Financial Needs Analysis" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Record of Advice" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecH"] setValue:@"Declaration & Acknowledgement" forKey:@"Title"];
//    [[obj.CFFData objectForKey:@"SecI"] setValue:@"Confirmation of Advice Given to" forKey:@"Title"];
//    
//    [[obj.CFFData objectForKey:@"Sections"] setValue:@"Sec" forKey:@"CurrentSection"];
    
    //[[obj.CFFData objectForKey:@"Sections"] setValue:@"Sec" forKey:@"gigjdgio"];
    
    //[[obj.CFFData objectForKey:@"Sections1"] setValue:@"Sec" forKey:@"display"];
    
    
    
    /*
     PersonalDetialsViewController
     UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
     UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
     vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
     [self presentViewController:vc animated:YES completion:^{}];
     */
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
//    PersonalDetialsViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PersonalDetialsViewController"];
//    //vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
//    vc.delegate = self;
//    [self presentViewController:vc animated:YES completion:nil];
    [self DisplayNewCFF:23 clientName:@"yeap yew sin" clientID:@"840928085454"];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)viewDidUnload {
    [self setNaviBar:nil];
    [self setSearchBar:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [clientProfileResults count];
        
    } else {
        return [[clientData objectAtIndex:0] count];;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"clientProfileCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [clientProfileResults objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [clientProfileID objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [[clientData objectAtIndex:0]objectAtIndex:indexPath.row];
        cell.detailTextLabel.text =[[NSString alloc] initWithFormat:@"Updated on: %@", [[clientData objectAtIndex:2]objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.row == 0){
    //[[obj.eAppData objectForKey:@"CFF"] setValue:[clientProfile objectAtIndex:indexPath.row] forKey:@"CustomerCFF"];
    //[self.delegate displayCFF];
    //}
    [self loadDBData:[[[clientData objectAtIndex:5]objectAtIndex:indexPath.row] intValue] clientName:[[clientData objectAtIndex:0]objectAtIndex:indexPath.row] clientID:[[clientData objectAtIndex:1]objectAtIndex:indexPath.row] CFFID:[[clientData objectAtIndex:4]objectAtIndex:indexPath.row]];
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    MasterMenuCFF *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;
    
    // Setting the selected cff data
    vc.name = [[clientData objectAtIndex:0] objectAtIndex:indexPath.row];
    vc.idNo = [[clientData objectAtIndex:1] objectAtIndex:indexPath.row];
    vc.date = [[clientData objectAtIndex:2] objectAtIndex:indexPath.row];
    vc.status = [[clientData objectAtIndex:3] objectAtIndex:indexPath.row];
    vc.cffID = [[clientData objectAtIndex:4] objectAtIndex:indexPath.row];
    vc.clientProfileID = [[clientData objectAtIndex:5] objectAtIndex:indexPath.row];
    vc.delegate = self;
    
    vc.fLoad = @"1";
    vc.eApp = TRUE;

    UIViewController *presentingViewController = self.presentingViewController;
    [self dismissViewControllerAnimated:YES completion:^{
        [presentingViewController presentViewController:vc animated:YES completion:nil];
    }];
    //[self presentViewController:vc animated:YES completion:^{}];
}

-(void)selectedCFF{
    [self.delegate updateChecklistCFF];
}

-(void)loadDBData:(int)indexNo clientName:(NSString *)clientName clientID:(NSString *)clientID CFFID:(NSString *)CFFID{
    NSLog(@"XXXX%@",CFFID);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *eAppResults;
    
    
    obj=[DataClass getInstance];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    obj.CFFData = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"CFF"];
    [data removeAllObjects];
    
    
    [obj.CFFData setObject:data forKey:@"Sections"];
    [data removeAllObjects];
    
    [obj.CFFData setObject:data forKey:@"SecA"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecB"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecC"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecD"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecE"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecF"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFProtection"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFRetirement"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFEducation"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFSavings"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecG"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecH"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecI"];
    
    //default settings for CFF
    [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientName forKey:@"CFFClientName"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientID forKey:@"CFFClientID"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"CFFClientIndex"];
    
    //globals status
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"]; //to show do you want to save
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"SecChange"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFCreate"]; //set to 0, dont create
    [[obj.CFFData objectForKey:@"CFF"] setValue:CFFID forKey:@"lastId"];
    
    
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"]; //to validate CFF section
    
    //default for the rest of sections
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Completed"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Completed"];
    
    results= [database executeQuery:@"SELECT * FROM CFF_Master WHERE ID=?",CFFID];
    eAppResults = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=?", CFFID];
    
    bool eAppIsMoreUpdate = false;
    
    while([results next])
	{
        bool eApp = [eAppResults next];
        if (eApp) {
            NSLog(@"eApp available");
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MM/yyyy"];
            NSDate *standalone = [format dateFromString:[results stringForColumn:@"lastUpdatedAt"]];
            NSDate *eAppDate = [format dateFromString:[eAppResults stringForColumn:@"lastUpdatedAt"]];
            if (![eAppDate laterDate:standalone]) {
                eAppIsMoreUpdate = true;
            }
            
        }
        NSLog(@"Done");
        if (!eAppIsMoreUpdate) {
            //completed status
            [[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"SecBCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SecCCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"SecDCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecE"] setValue:[results stringForColumn:@"SecECompleted"] forKey:@"Completed"];
            
            
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:[results stringForColumn:@"SecFProtectionCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:[results stringForColumn:@"SecFRetirementCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:[results stringForColumn:@"SecFEducationCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:[results stringForColumn:@"SecFSavingsCompleted"] forKey:@"Completed"];
            
            if ([[results stringForColumn:@"ClientChoice"] isEqualToString:@"1"]){
                if ([[results stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            else if ([[results stringForColumn:@"ClientChoice"] isEqualToString:@"2"]){
                if ([[results stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            
            
            [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SecGCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"SecHCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SecICompleted"] forKey:@"Completed"];
            
            //SecA
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[results stringForColumn:@"IntermediaryStatus"] forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[results stringForColumn:@"BrokerName"] forKey:@"BrokerName"];
            
            //SecB
            [[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
            
            //SecC
            if ([[results stringForColumn:@"PartnerClientProfileID"] length] == 0){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
            }
            else{
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PartnerClientProfileID"] forKey:@"PartnerProfileID"];
            }
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerReadOnly"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerReadOnly"];
            
            //SecD
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Ans1"] forKey:@"NeedsQ1_Ans1"];
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"]);
            //NSLog(@"QQQ%@",[results stringForColumn:@"NeedsQ1_Ans1"]);
            
            
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Ans2"] forKey:@"NeedsQ1_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Priority"] forKey:@"NeedsQ1_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Ans1"] forKey:@"NeedsQ2_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Ans2"] forKey:@"NeedsQ2_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Priority"] forKey:@"NeedsQ2_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Ans1"] forKey:@"NeedsQ3_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Ans2"] forKey:@"NeedsQ3_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Priority"] forKey:@"NeedsQ3_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Ans1"] forKey:@"NeedsQ4_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Ans2"] forKey:@"NeedsQ4_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Priority"] forKey:@"NeedsQ4_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Ans1"] forKey:@"NeedsQ5_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Ans2"] forKey:@"NeedsQ5_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Priority"] forKey:@"NeedsQ5_Priority"];
            
            //SecE
            [[obj.CFFData objectForKey:@"SecE"] setValue:[results stringForColumn:@"RiskReturnProfile"] forKey:@"Preference"];
            
            //Sec H
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryCode"] forKey:@"IntermediaryCode"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryName"] forKey:@"NameOfIntermediary"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryNRIC"] forKey:@"IntermediaryNRIC"];
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryContractDate"] forKey:@"IntermediaryCodeContractDate"];
            
            NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"]);
            
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress1"] forKey:@"IntermediaryAddress1"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress2"] forKey:@"IntermediaryAddress2"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress3"] forKey:@"IntermediaryAddress3"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress4"] forKey:@"IntermediaryAddress4"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryManagerName"] forKey:@"NameOfManager"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"ClientAck"] forKey:@"CustomerAcknowledgement"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"ClientComments"] forKey:@"AdditionalComment"];
            
            
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"CustomerAcknowledgement"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"AdditionalComment"];
        } else if(eAppIsMoreUpdate) {
            //completed status
            [[obj.CFFData objectForKey:@"SecB"] setValue:[eAppResults stringForColumn:@"SecBCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[eAppResults stringForColumn:@"SecCCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"SecDCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecE"] setValue:[eAppResults stringForColumn:@"SecECompleted"] forKey:@"Completed"];
            
            
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:[eAppResults stringForColumn:@"SecFProtectionCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:[eAppResults stringForColumn:@"SecFRetirementCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:[eAppResults stringForColumn:@"SecFEducationCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:[eAppResults stringForColumn:@"SecFSavingsCompleted"] forKey:@"Completed"];
            
            if ([[eAppResults stringForColumn:@"ClientChoice"] isEqualToString:@"1"]){
                if ([[eAppResults stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] && [[eAppResults stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] && [[eAppResults stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            else if ([[eAppResults stringForColumn:@"ClientChoice"] isEqualToString:@"2"]){
                if ([[eAppResults stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] || [[eAppResults stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] || [[eAppResults stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            
            
            [[obj.CFFData objectForKey:@"SecG"] setValue:[eAppResults stringForColumn:@"SecGCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"SecHCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[eAppResults stringForColumn:@"SecICompleted"] forKey:@"Completed"];
            
            //SecA
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[eAppResults stringForColumn:@"IntermediaryStatus"] forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[eAppResults stringForColumn:@"BrokerName"] forKey:@"BrokerName"];
            
            //SecB
            [[obj.CFFData objectForKey:@"SecB"] setValue:[eAppResults stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
            
            //SecC
            if ([[eAppResults stringForColumn:@"PartnerClientProfileID"] length] == 0){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
            }
            else{
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[eAppResults stringForColumn:@"PartnerClientProfileID"] forKey:@"PartnerProfileID"];
            }
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerReadOnly"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerReadOnly"];
            
            //SecD
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Ans1"] forKey:@"NeedsQ1_Ans1"];
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"]);
            //NSLog(@"QQQ%@",[results stringForColumn:@"NeedsQ1_Ans1"]);
            
            
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Ans2"] forKey:@"NeedsQ1_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Priority"] forKey:@"NeedsQ1_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Ans1"] forKey:@"NeedsQ2_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Ans2"] forKey:@"NeedsQ2_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Priority"] forKey:@"NeedsQ2_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Ans1"] forKey:@"NeedsQ3_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Ans2"] forKey:@"NeedsQ3_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Priority"] forKey:@"NeedsQ3_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Ans1"] forKey:@"NeedsQ4_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Ans2"] forKey:@"NeedsQ4_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Priority"] forKey:@"NeedsQ4_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Ans1"] forKey:@"NeedsQ5_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Ans2"] forKey:@"NeedsQ5_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Priority"] forKey:@"NeedsQ5_Priority"];
            
            //SecE
            [[obj.CFFData objectForKey:@"SecE"] setValue:[eAppResults stringForColumn:@"RiskReturnProfile"] forKey:@"Preference"];
            
            //Sec H
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryCode"] forKey:@"IntermediaryCode"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryName"] forKey:@"NameOfIntermediary"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryNRIC"] forKey:@"IntermediaryNRIC"];
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryContractDate"] forKey:@"IntermediaryCodeContractDate"];
            
            NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"]);
            
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress1"] forKey:@"IntermediaryAddress1"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress2"] forKey:@"IntermediaryAddress2"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress3"] forKey:@"IntermediaryAddress3"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress4"] forKey:@"IntermediaryAddress4"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryManagerName"] forKey:@"NameOfManager"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"ClientAck"] forKey:@"CustomerAcknowledgement"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"ClientComments"] forKey:@"AdditionalComment"];
            
            
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"CustomerAcknowledgement"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"AdditionalComment"];
        }
        
        
        
        
        
    }
    
    //SecC Customer
    results = Nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d", indexNo]];
	
	//fix for bug 2494 start
    FMResultSet *cont6 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT006"];
	FMResultSet *cont7 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT007"];
	//fix for bug 2646 start
	FMResultSet *cont8 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT008"];
	//fix for bug 2646 end
	FMResultSet *cont9 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT009"];
    //results = [database executeQuery:@"select * from prospect_profile where IndexNo = 3333"];
    
    while([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingCustomer"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"CustomerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"CustomerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"CustomerNRIC"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDType"] forKey:@"CustomerOtherIDType"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDTypeNo"] forKey:@"CustomerOtherID"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Race"] forKey:@"CustomerRace"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Religion"] forKey:@"CustomerReligion"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Nationality"] forKey:@"CustomerNationality"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"CustomerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"CustomerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"CustomerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerAge"]; //auto calculate
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MaritalStatus"] forKey:@"CustomerMaritalStatus"]; //not yet
		
		if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MALAYSIA"]) {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
		}
		else {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
		}
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"CustomerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"CustomerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"CustomerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"CustomerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"CustomerMailingAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"CustomerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"CustomerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"Email"];
		
    }
	
	while ([cont6 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"Prefix"] forKey:@"ResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"ContactNo"] forKey:@"ResidenceTel"];
	}
	
	while ([cont7 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"Prefix"] forKey:@"OfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"ContactNo"] forKey:@"OfficeTel"];
	}
	//fix for bug 2646 start
	while ([cont8 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"Prefix"] forKey:@"MobileTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"ContactNo"] forKey:@"MobileTel"];
	}
	//fix for bug 2646 end
	while ([cont9 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"Prefix"] forKey:@"FaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"ContactNo"] forKey:@"FaxTel"];
	}
	//fix for bug 2494 end
    
    //SecC Partner
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        results = Nil;
        results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]];
        while([results next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"PartnerTitle"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"PartnerName"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"PartnerNRIC"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"CHINESE" forKey:@"PartnerRace"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Non Muslim" forKey:@"PartnerReligion"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"MALAYSIA" forKey:@"PartnerNationality"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"PartnerSex"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"PartnerSmoker"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"PartnerDOB"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Married" forKey:@"PartnerMaritalStatus"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerMailingAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerMailingAddress3"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"53300" forKey:@"PartnerMailingPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"KUALA LUMPUR" forKey:@"PartnerMailingAddressTown"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerMailingAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerMailingAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
        }
    }
    else{ //SecC no Partner
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNRIC"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerRace"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerReligion"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNationality"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMaritalStatus"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
    }
    
    //SecC Children
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden4"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden5"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen1RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen2RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen3RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen4RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen5RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Support"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select count(*) as cnt from CFF_Family_Details where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID = ?", CFFID, nil];
    }
    int gotChild = 0;
    int gotChildCount = 0;
    while ([results next]) {
        if ([results intForColumn:@"cnt"] > 0){
            gotChild = 1;
        }
    }
    if (gotChild == 1){
        results = Nil;
        if (!eAppIsMoreUpdate) {
            results = [database executeQuery:@"select * from CFF_Family_Details where CFFID = ? order by ID asc",CFFID,Nil];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_Family_Details where CFFID = ? order by ID asc",CFFID,Nil];
        }
        while ([results next]) {
            gotChildCount++;
            if (gotChildCount == 1){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden1"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen1Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen1Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen1DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen1Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen1Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen1RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen1Support"];
            }
            else if (gotChildCount == 2){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden2"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen2Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen2Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen2DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen2Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen2Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen2RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen2Support"];
            }
            else if (gotChildCount == 3){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden3"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen3Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen3Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen3DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen3Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen3Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen3RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen3Support"];
            }
            else if (gotChildCount == 4){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden4"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen4Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen4Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen4DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen4Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen4Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen4RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen4Support"];
            }
            else if (gotChildCount == 5){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden5"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen5Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen5Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen5DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen5Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen5Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen5RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen5Support"];
            }
        }
    }
    
    //Section F Retirement
    //section F Protection
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasProtection"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection3"];
    
    
    
    //section F Protection
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Protection where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Protection where CFFID = ?",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasProtection"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_CurrentAmt"] forKey:@"ProtectionCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_RequiredAmt"] forKey:@"ProtectionRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_SurplusShortFall"] forKey:@"ProtectionDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_CurrentAmt"] forKey:@"ProtectionCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_RequiredAmt"] forKey:@"ProtectionRequired2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_SurplusShortFall"] forKey:@"ProtectionDifference2"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_CurrentAmt"] forKey:@"ProtectionCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_RequiredAmt"] forKey:@"ProtectionRequired3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_SurplusShortFall"] forKey:@"ProtectionDifference3"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalPA_CurrentAmt"] forKey:@"ProtectionCurrent4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalPA_RequiredAmt"] forKey:@"ProtectionRequired4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_SurplusShortFall"] forKey:@"ProtectionDifference4"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"ProtectionCustomerAlloc"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_2"] forKey:@"ProtectionPartnerAlloc"];
        
        
    }
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3MaturityDate"];
    
    //section F Protection Details
    results = Nil;
    int protectionCount;
    protectionCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Protection_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    else  {
        results = [database executeQuery:@"select * from eProposal_CFF_Protection_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    while ([results next]) {
        protectionCount++;
        if (protectionCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection1TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection1LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection1DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection1DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection1CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection1OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection1PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection1Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection1MaturityDate"];
        }
        else if (protectionCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection2LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection2DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection2DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection2CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection2OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection2PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection2Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection2MaturityDate"];
        }
        else if (protectionCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection3LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection3DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection3DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection3CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection3OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection3PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection3Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection1MaturityDate"];
        }
    }
    
    //section F Retirement
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasRetirement"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement3"];
    
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Retirement where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Retirement where CFFID = ?",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasRetirement"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt"] forKey:@"RetirementCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt"] forKey:@"RetirementRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt"] forKey:@"RetirementDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"RetirementCustomerAlloc"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_2"] forKey:@"RetirementPartnerAlloc"];
        
        //NSLog(@"TTT%@",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"]);
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"OtherIncome_1"] forKey:@"RetirementCustomerRely"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"OtherIncome_2"] forKey:@"RetirementPartnerRely"];
    }
    
    //section F Retirement Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3AdditionalBenefit"];
    
    results = Nil;
    int retirementCount;
    retirementCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Retirement_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Retirement_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    while ([results next]) {
        retirementCount++;
        if (retirementCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement1Company"];
            
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement1TypeOfPlan"];
            //NSLog(@"DDDD%@",[results stringForColumn:@"PlanType"]);
            
            
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement1Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement1StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement1MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement1SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement1IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement1AdditionalBenefit"];
        }
        else if (retirementCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement2Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement2StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement2MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement2SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement2IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement2AdditionalBenefit"];
            
        }
        else if (retirementCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement3Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement3StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement3MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement3SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement3IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement3AdditionalBenefit"];
        }
    }
    
    //Section F education
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducationChild"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationRowToHide"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation4"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Education where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Education where CFFID = ?",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasEducation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoChild"] forKey:@"HasEducationChild"];
        
        if ([[results stringForColumn:@"NoChild"] isEqualToString:@"-1"]){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"2" forKey:@"EducationRowToHide"]; //special
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"EducationRowToHide"];
        }
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_1"] forKey:@"EducationCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_1"] forKey:@"EducationRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_1"] forKey:@"EducationDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_2"] forKey:@"EducationCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_2"] forKey:@"EducationRequired2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_2"] forKey:@"EducationDifference2"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_3"] forKey:@"EducationCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_3"] forKey:@"EducationRequired3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_3"] forKey:@"EducationDifference3"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_4"] forKey:@"EducationCurrent4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_4"] forKey:@"EducationRequired4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_4"] forKey:@"EducationDifference4"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"EducationCustomerAlloc"];
    }
    
    //Sec F Education Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ValueMaturity"];
    
    results = Nil;
    int educationCount;
    educationCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Education_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Education_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    while ([results next]) {
        educationCount++;
        if (educationCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation1ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation1Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation1StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation1MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation1ValueMaturity"];
        }
        else if (educationCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation2ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation2Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation2StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation2MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation1ValueMaturity"];
        }
        else if (educationCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation3ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation3Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation3StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation3MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation3ValueMaturity"];
        }
        else if (educationCount == 4){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation4"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation4ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation4Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation4Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation4Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation4StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation4MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation4ValueMaturity"];
        }
    }
    
    //Sec F Savings
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasSavings"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings3"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_SavingsInvest where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest where CFFID = ?",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasSavings"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt"] forKey:@"SavingsCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt"] forKey:@"SavingsRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt"] forKey:@"SavingsDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"SavingsCustomerAlloc"];
    }
    
    //Sec F Savings Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Purpose"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1CommDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1AmountMaturity"];
    
    results = Nil;
    int savingsCount;
    savingsCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_SavingsInvest_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest_Details where CFFID = ? order by SeqNo asc",CFFID,Nil];
    }
    while ([results next]) {
        savingsCount++;
        if (savingsCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings1TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings1Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings1CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings1AmountMaturity"];
        }
        else if (savingsCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings2Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings2CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings2AmountMaturity"];
        }
        else if (savingsCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings3Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings3CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings3AmountMaturity"];
        }
    }
    
    //Section G
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"FollowSI"];//selected
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ActionP1"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"ValidateP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP2"];
    
    //Section G Priority 1
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '1'",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = ? and Priority = '1'",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"FollowSI"];//selected
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"PlanType"] forKey:@"TypeOfPlanP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"Term"] forKey:@"TermP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssuredP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsuredP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ReasonRecommend"] forKey:@"ReasonP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ActionRemark"] forKey:@"ActionP1"];
    }
    
    //Section G Priority 1 Riders
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '1' order by Seq asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '1' order by Seq asc",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"RiderName"] forKey:@"AdditionalP1"]; //special
    }
    
    //Section G Priority 2
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '2'",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = ? and Priority = '2'",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"PlanType"] forKey:@"TypeOfPlanP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"Term"] forKey:@"TermP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssuredP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsuredP2"];
        
        //[[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP2"]; //special
        
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ReasonRecommend"] forKey:@"ReasonP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ActionRemark"] forKey:@"ActionP2"];
    }
    
    //Section G Priority 2 Riders
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '2' order by Seq asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '2' order by Seq asc",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"RiderName"] forKey:@"AdditionalP2"]; //special
    }
    
    //section H
    results = Nil;
    results = [database executeQuery:@"select * from Agent_profile"];
    while([results next]) {
        NSString *IntermediaryCode = [results stringForColumn:@"AgentCode"];
        NSString *NameOfIntermediary  = [results stringForColumn:@"AgentName"];
        NSString *IntermediaryNRIC  = [results stringForColumn:@"AgentNRIC"];
        
        NSString *IntermediaryAddress1  = [results stringForColumn:@"AgentAddr1"];
        NSString *IntermediaryAddress2  = [results stringForColumn:@"AgentAddr2"];
        NSString *IntermediaryAddress3  = [results stringForColumn:@"AgentAddr3"];
        NSString *IntermediaryAddress4  = [results stringForColumn:@"AgentAddr4"];
        NSString *IntermediaryCodeContractDate  = [results stringForColumn:@"AgentContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCodeContractDate forKey:@"IntermediaryCodeContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
    }
    
    //section I
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice6"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Advice6Others"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended5"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_CA where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA where CFFID = ?",CFFID,Nil];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice1"] forKey:@"Advice1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice2"] forKey:@"Advice2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice3"] forKey:@"Advice3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice4"] forKey:@"Advice4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice5"] forKey:@"Advice5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice6"] forKey:@"Advice6"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choices6Desc"] forKey:@"Advice6Others"];
    }
    
    //section I recommended
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"RecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductTypeSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"TermSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"PremiumSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"FrequencySI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefitSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"BroughtSI"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Brought1"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Brought2"];
    
    results = Nil;
    int recommendCount;
    recommendCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_CA_Recommendation where CFFID = ? order by Seq asc",CFFID,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation where CFFID = ? order by Seq asc",CFFID,Nil];
    }
    while ([results next]) {
        recommendCount++;
        if (recommendCount == 1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured1"];
            //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought1"];
        }
        else if (recommendCount == 2){
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
            //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought2"];
        }
    }
    
}

- (void)DisplayNewCFF:(int)indexNo clientName:(NSString*)clientName clientID:(NSString*)clientID{
    
    NSLog(@"XXXX%d",indexNo);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    
    obj=[DataClass getInstance];
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    obj.CFFData = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"CFF"];
    [data removeAllObjects];
    [obj.CFFData setObject:data forKey:@"Sections"];
    [data removeAllObjects];
    [obj.CFFData setObject:data forKey:@"SecA"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecB"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecC"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecD"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecE"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecF"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFProtection"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFRetirement"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFEducation"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFSavings"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecG"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecH"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecI"];
    
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"Disclosure of Intermediary Status" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"Customer's Choice" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"Customer's Personal Data" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"Potential Areas for Discussion" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecE"] setValue:@"Preference" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"Financial Needs Analysis" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Record of Advice" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"Declaration & Acknowledgement" forKey:@"Title"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"Confirmation of Advice Given to" forKey:@"Title"];
    
    
    
    //default settings for new CFF
    [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientName forKey:@"CFFClientName"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientID forKey:@"CFFClientID"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"CFFClientIndex"];
    
    //globals status
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"]; //to show do you want to save
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"SecChange"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFCreate"]; //to insert new CFF
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"]; //to validate CFF section
    
    //default setA fields
    //[[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
    //[[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
    
    //default for the rest of sections
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Completed"];
    
    
    
    
    //SecA
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
    
    //SecB
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"0" forKey:@"ClientChoice"];
    
    //SecC
    results = Nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d", indexNo]];
    
    //results = [database executeQuery:@"select * from prospect_profile where IndexNo = 300"];
	
	//fix for bug 2494 start
    FMResultSet *cont6 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT006"];
	FMResultSet *cont7 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT007"];
	FMResultSet *cont8 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT008"];
	FMResultSet *cont9 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT009"];
    
    while([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"CustomerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"CustomerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"CustomerNRIC"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDType"] forKey:@"CustomerOtherIDType"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDTypeNo"] forKey:@"CustomerOtherID"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Race"] forKey:@"CustomerRace"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Religion"] forKey:@"CustomerReligion"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Nationality"] forKey:@"CustomerNationality"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"CustomerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"CustomerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"CustomerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerAge"]; //auto calculate
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MaritalStatus"] forKey:@"CustomerMaritalStatus"]; //not yet
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MALAYSIA"]) {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
		}
		else {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
		}
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"CustomerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"CustomerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"CustomerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"CustomerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"CustomerMailingAddressTown"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"CustomerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"CustomerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressCountry"];
        
		[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"Email"];
    }
	
	while ([cont6 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"Prefix"] forKey:@"ResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"ContactNo"] forKey:@"ResidenceTel"];
	}
	
	while ([cont7 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"Prefix"] forKey:@"OfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"ContactNo"] forKey:@"OfficeTel"];
	}
	//fix for bug 2646 start
	while ([cont8 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"Prefix"] forKey:@"MobileTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"ContactNo"] forKey:@"MobileTel"];
	}
	//fix for bug 2646 end
	while ([cont9 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"Prefix"] forKey:@"FaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"ContactNo"] forKey:@"FaxTel"];
	}
    //fix for bug 2494 end
	
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerTitle"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerName"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNRIC"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerRace"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerReligion"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNationality"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSmoker"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerDOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerAge"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMaritalStatus"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressForeign"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressCountry"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressForeign"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerReadOnly"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerReadOnly"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingCustomer"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden4"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden5"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen1RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen2RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen3RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen4RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen5RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Support"];
    
    //section D
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Priority"];
    
    //Section E
    [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Preference"];
    
    //section F Protection
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasProtection"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3MaturityDate"];
    
    //section F Retirement
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasRetirement"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3AdditionalBenefit"];
    
    //section F education
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducationChild"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationRowToHide"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ValueMaturity"];
    
    //Sec F Savings
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasSavings"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Purpose"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1CommDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1AmountMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Purpose"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2CommDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2AmountMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSabvings3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Purpose"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3CommDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3AmountMaturity"];
    
    
    //section G
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"FollowSI"];//selected
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP1"];
    //NSLog(@"www%@",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"]);
    
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ActionP1"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"ValidateP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP2"];
    
    
    //section H
    results = Nil;
    results = [database executeQuery:@"select * from Agent_profile"];
    while([results next]) {
        NSString *IntermediaryCode = [results stringForColumn:@"AgentCode"];
        NSString *NameOfIntermediary  = [results stringForColumn:@"AgentName"];
        NSString *IntermediaryNRIC  = [results stringForColumn:@"AgentNRIC"];
        
        NSString *IntermediaryAddress1  = [results stringForColumn:@"AgentAddr1"];
        NSString *IntermediaryAddress2  = [results stringForColumn:@"AgentAddr2"];
        NSString *IntermediaryAddress3  = [results stringForColumn:@"AgentAddr3"];
        NSString *IntermediaryAddress4  = [results stringForColumn:@"AgentAddr4"];
        NSString *IntermediaryCodeContractDate  = [results stringForColumn:@"AgentContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCodeContractDate forKey:@"IntermediaryCodeContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];        
    }
    
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"CustomerAcknowledgement"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"AdditionalComment"];
    
    //section I
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice6"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Advice6Others"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended5"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought1"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought2"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought3"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought4"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Brought5"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"RecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductTypeSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"TermSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"PremiumSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"FrequencySI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefitSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"-1" forKey:@"BroughtSI"];
    
    [database close];
    
    
    
    //[self dismissViewControllerAnimated:TRUE completion:^{}];
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    MasterMenuCFF *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;
    
    // Setting the selected cff data
    vc.name = clientName;
    vc.idNo = [[NSString alloc] initWithFormat:@"%d", indexNo];
    vc.clientProfileID = clientID;
    
    vc.fLoad = @"0";
    vc.eApp = TRUE;
    
    UIViewController *presentingView = self.presentingViewController;
    [self dismissViewControllerAnimated:YES completion:^{
        [presentingView presentViewController:vc animated:YES completion:nil];
    }];
    //[self presentViewController:vc animated:YES completion:^{}];
}

-(void)CustomerViewDisplay:(NSString *)type{
    
}

#pragma mark - SearchBar Delegate Method/s


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSString *sqlQuery;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([searchBar.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        // consists only of the digits 0 through 9
        // means search for identification number
        sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo = %@ ", searchBar.text];
        
    }
    else {
        // search for name
        sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE ProspectName LIKE \"%%%@%%\" ", searchBar.text];
    }
    clientProfile = [NSArray arrayWithObjects:@"Santhiya Sree", nil];
    //clientProfileID = [NSArray arrayWithObjects:@"790620145681", @"Andy Phan Seng", @"Roslinda Rosli", @"Foong Kit Leong", @"Shawal Sapuan", nil];
    clientProfileID = [NSArray arrayWithObjects:@"Updated on: 10/07/2013", nil];
    
    [clientData removeAllObjects];
    [arrName removeAllObjects];
    [arrCFFID removeAllObjects];
    [arrIdNo removeAllObjects];
    [arrStatus removeAllObjects];
    [arrDate removeAllObjects];
    [arrClientProfileID removeAllObjects];
    
    
    
    clientData = [[NSMutableArray alloc] init];
    arrName = [[NSMutableArray alloc] init];
    arrCFFID = [[NSMutableArray alloc] init];
    arrIdNo = [[NSMutableArray alloc] init];
    arrStatus = [[NSMutableArray alloc] init];
    arrDate = [[NSMutableArray alloc] init];
    arrClientProfileID = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *results1;
    
    results1 = [database executeQuery:sqlQuery];
    NSString *indexNo = @"(";
    while ([results1 next]) {
        indexNo = [NSString stringWithFormat:@"%@%@,", indexNo, [results1 stringForColumn:@"IndexNo"]];
    }
    indexNo = [NSString stringWithFormat:@"%@-1%s", indexNo, ")"];
    sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM CFF_Master WHERE CFFType='Master' AND ClientProfileID IN %@", indexNo];
    results= [database executeQuery:sqlQuery];
    
    
    
    [clientData addObject:arrName];
    [clientData addObject:arrIdNo];
    [clientData addObject:arrDate];
    [clientData addObject:arrStatus];
    [clientData addObject:arrCFFID];
    [clientData addObject:arrClientProfileID];
    
    while([results next])
    {
        //NSLog(@"dasd");
        /* taking results from database to a string "eleData" */
        //eleData = [fResult stringForColumn:@"desc"];
        /* adding data from the string object to Array */
        //[aElephant addObject:eleData];
        /* Checking weather data has come or not */
        //NSLog(@"The data is %@=",eleData);
        results1= [database executeQuery:@"SELECT * FROM prospect_profile WHERE IndexNo=?",[results stringForColumn:@"ClientProfileID"]];
        
        while([results1 next]){
            [arrName addObject:[results1 stringForColumn:@"ProspectName"]];
            [arrIdNo addObject:[results1 stringForColumn:@"IDTypeNo"]];
        }
        
        
        [arrDate addObject:[results stringForColumn:@"LastUpdatedAt"]];
        [arrStatus addObject:[results stringForColumn:@"Status"]];
        [arrCFFID addObject:[results stringForColumn:@"ID"]];
        [arrClientProfileID addObject:[results stringForColumn:@"ClientProfileID"]];
        
        [clientData addObject:arrName];
        [clientData addObject:arrIdNo];
        [clientData addObject:arrDate];
        [clientData addObject:arrStatus];
        [clientData addObject:arrCFFID];
        [clientData addObject:arrClientProfileID];
        
        //[arr addObject:[results1 stringForColumn:@"ProspectName"]];
        
        
    }
    [database close];
    [self.myTableView reloadData];
}
@end
