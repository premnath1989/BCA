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
#import "SelectCFFCell.h"
#import "ColorHexCode.h"

@interface SelectCFF (){
    NSMutableArray *clientProfile;
    NSMutableArray *clientProfileID;
    NSArray *clientProfileResults;
    NSArray *clientProfileIDResults;
    NSMutableArray *clientOtherID;
    DataClass *obj;
    
    bool eAppIsUpdate;
    
    NSString *poICNO;
    NSString *poOtherID;
    NSString *poOtherIDType;
    NSString *poName;
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

 NSString *poName;

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
    clientOtherID = [NSMutableArray array];
    
    obj = [DataClass getInstance];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *results1;
    
    NSString *sqlQuery = @"";
	NSLog(@"ID1: %@ ID2: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POIDTypeNo"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POOtherIDTypeNo"]);
    
    results = [database executeQuery:@"select LANewICNo, LAOtherID, LAOtherIDType, LAName from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], Nil];
    NSLog(@"%@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]);
	
    while ([results next]) {
        if ([results stringForColumn:@"LANewICNo"].length != 0) {
            sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo = '%@' ", [results stringForColumn:@"LANewICNo"]];
			
			poICNO = [results stringForColumn:@"LANewICNo"];
            poOtherID = [results stringForColumn:@"LAOtherID"];
            poOtherIDType = [results stringForColumn:@"LAOtherIDType"];
            poName = [results stringForColumn:@"LAName"];
        }
        else if ([results stringForColumn:@"LAOtherID"].length != 0) {
            sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE OtherIDTypeNo = '%@' ", [results stringForColumn:@"LAOtherID"]];
            
            poICNO = [results stringForColumn:@"LANewICNo"];
            poOtherID = [results stringForColumn:@"LAOtherID"];
            poOtherIDType = [results stringForColumn:@"LAOtherIDType"];
            poName = [results stringForColumn:@"LAName"];
        }
    }
    
    //if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POIDTypeNo"] != NULL) {
	
	
    NSLog(@"sql1: %@", sqlQuery);
    
    results1 = [database executeQuery:sqlQuery];
    NSString *indexNo;
   
    if ([results1 next]) {
        indexNo = [results1 objectForColumnName:@"IndexNo"];
        poName = [results1 objectForColumnName:@"ProspectName"];
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
    [clientData addObject:clientOtherID];
    
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
            [clientOtherID addObject:[results1 stringForColumn:@"OtherIDTypeNo"]];
        }
        
        
        [arrDate addObject:[results stringForColumn:@"LastUpdatedAt"]];
		//[arrStatus addObject:[results stringForColumn:@"Status"]];
		//**E
		NSString *cffStatus = [results stringForColumn:@"Status"];
		NSLog(@"status: %@",cffStatus);
		if ([cffStatus isEqualToString:@"1"]) {
			[arrStatus addObject: @"Completed"];
		}
		else {
			[arrStatus addObject: @"Incomplete"];
		}
        [arrCFFID addObject:[results stringForColumn:@"ID"]];
        [arrClientProfileID addObject:[results stringForColumn:@"ClientProfileID"]];
        
        [clientData addObject:arrName];
        [clientData addObject:arrIdNo];
        [clientData addObject:arrDate];
        [clientData addObject:arrStatus];
        [clientData addObject:arrCFFID];
        [clientData addObject:arrClientProfileID];
        [clientData addObject:clientOtherID];
        
        //[arr addObject:[results1 stringForColumn:@"ProspectName"]];
        
        
	}
    [database close];
    
    obj = [DataClass getInstance];
    
    
    /*for (NSDictionary *details in [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"]) {
        if ([[details objectForKey:@"POFlag"]isEqualToString:@"Y"]) {
            poName = [details objectForKey:@"LAName"];
            break;
        }
    }*/
//    NSString* TitleCFFS = @"Please select jbvbsvasgvwpgcisc svwsv svsvs savcwc jsbsbdcdsmnbv l  vscds";
//    self.naviBar.topItem.title = [[NSString alloc] initWithFormat:@"CFF for %@", TitleCFFS];
    //self.naviBar.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    //UIViewAutoresizingFlexibleHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard{
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        if (clientProfileResults.count==0)
        {
            return 5;
        }
        else
        return [clientProfileResults count];
        
    } else {
        if ([[clientData objectAtIndex:0] count]==0)
        {
            return 5;
        }
        else
        return [[clientData objectAtIndex:0] count];
        
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
   /* int status = [[[clientData objectAtIndex:3] objectAtIndex:indexPath.row] intValue];
    if (status == 0) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    else if (status == 1) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    } */
	//**E
    NSString *status=@"";
    if ([[clientData objectAtIndex:3]  count]>0)
	status = [NSString stringWithFormat:@"%@",[[clientData objectAtIndex:3] objectAtIndex:indexPath.row]];
    else
        status=@"";
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	NSLog(@"Status: %@", status);
	if ([status isEqualToString:@"Incomplete"]) {
	 //cell.contentView.backgroundColor = [UIColor redColor];
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"e98294"];
	 }
	 else if ([status isEqualToString:@"Completed"]) {
	 cell.contentView.backgroundColor = [UIColor whiteColor];
	 }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"clientProfileCell";
    
    SelectCFFCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SelectCFFCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
       // cell.userInteractionEnabled =NO;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if(clientProfileResults.count>0){
        cell.nameLbl.text = [clientProfileResults objectAtIndex:indexPath.row];
        cell.idNoLbl.text = [[clientData objectAtIndex:6]objectAtIndex:indexPath.row];
        }//[clientProfileID objectAtIndex:indexPath.row];
        else{
            if (indexPath.row==2) {
                cell.nameLbl.text =@"                                               No Results";
                cell.idNoLbl.text=@"";
                cell.userInteractionEnabled =NO;
            }
            else{
             cell.nameLbl.text =@"";
            cell.idNoLbl.text=@"";
                cell.userInteractionEnabled =NO;
            }
        }
    } else {
          if([[clientData objectAtIndex:0] count]>0){
        cell.nameLbl.text = [[clientData objectAtIndex:0]objectAtIndex:indexPath.row];
        cell.dateLbl.text = [[NSString alloc] initWithFormat:@"Last Updated: %@", [[clientData objectAtIndex:2]objectAtIndex:indexPath.row]];
		cell.dateLbl.textColor = [UIColor blackColor];
        cell.idNoLbl.text = [NSString stringWithFormat:@"%@\n%@",[[clientData objectAtIndex:1] objectAtIndex:indexPath.row], [[clientData objectAtIndex:6]objectAtIndex:indexPath.row]];
        cell.idNoLbl.numberOfLines = 2;
        cell.statusLbl.text = [[NSString alloc] initWithFormat:@"Status: %@", [[clientData objectAtIndex:3]objectAtIndex:indexPath.row]];
		cell.statusLbl.textColor = [UIColor blackColor];
          }
          else{
              if (indexPath.row==2) {
                  cell.nameLbl.text =@"                                             No Results";
                  cell.idNoLbl.text=@"";
                  cell.dateLbl.text=@"";
                  cell.statusLbl.text=@"";
                  cell.userInteractionEnabled =NO;
              }
              else{
                  cell.nameLbl.text =@"";
                  cell.idNoLbl.text=@"";
                  cell.dateLbl.text=@"";
                  cell.statusLbl.text=@"";
                  cell.userInteractionEnabled =NO;
              }
              
          }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.row == 0){
    //[[obj.eAppData objectForKey:@"CFF"] setValue:[clientProfile objectAtIndex:indexPath.row] forKey:@"CustomerCFF"];
    //[self.delegate displayCFF];
    //}
	//**E
	//int status = [[[clientData objectAtIndex:3] objectAtIndex:indexPath.row] intValue];
	NSString *status = [NSString stringWithFormat:@"%@",[[clientData objectAtIndex:3] objectAtIndex:indexPath.row]];
    if ([status isEqualToString:@"Incomplete"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"The selected CFF is incomplete. Please reselect the complete CFF or proceed to update the complete information in CFF standalone module." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    else if ([status isEqualToString:@"Completed"]) {
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *docsPath = [paths objectAtIndex:0];
//        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
//        
//        FMDatabase *database = [FMDatabase databaseWithPath:path];
//        [database open];
		
//		NSString *sql = [NSString stringWithFormat:@"select count(*) as count from CFF_Personal_Details where CFFID = %@ and (NewICNo = '%@' or (OtherIDType = '%@' AND OtherID = '%@') or Name = '%@')", [[clientData objectAtIndex:4]objectAtIndex:indexPath.row], poICNO, poOtherIDType, poOtherID, poName, nil];
//		
//		NSLog(@"CFFPD SQL: %@", sql);
//        FMResultSet *results = [database executeQuery:sql];
//        bool related = FALSE;
//        while ([results next]) {
//            if ([results intForColumn:@"count"] != 0) {
//                related = TRUE;
//            }
//            else {
//                related = FALSE;
//            }
//        }
//        [database close];
        
//        if (!related) {
//            [database open];
//			sql = [NSString stringWithFormat:@"select count(*) as count from CFF_Family_Details where CFFID = '%@' and Name = '%@'", [[clientData objectAtIndex:4]objectAtIndex:indexPath.row], poName];
//            results = [database executeQuery:sql];
//			NSLog(@"CFFPD2 SQL: %@", sql);
//            while ([results next]) {
//                if ([results intForColumn:@"count"] != 0) {
//                    related = TRUE;
//                }
//                else {
//                    related = FALSE;
//                }
//            }
//            [database close];
//        }
        
//        if(!related) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Policy Owner information must appear in eCFF either in customer column, spouse/partner or children/dependents column." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            alert = nil;
//            return;
//        }
        
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
    eAppResults = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=? and eProposalNo=?", CFFID,[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
    
    bool eAppIsMoreUpdate = false;
    NSString *createdAt;
    NSString *lastUpdatedAt;
    while([results next])
	{
        bool eApp = [eAppResults next];
        if (eApp) {
            NSLog(@"eApp available");
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MM/yyyy"];
            NSDate *standalone = [format dateFromString:[results stringForColumn:@"LastUpdatedAt"]];
            NSDate *eAppDate = [format dateFromString:[eAppResults stringForColumn:@"LastUpdatedAt"]];

            if (![eAppDate laterDate:standalone]) {
                eAppIsMoreUpdate = true;
                eAppIsUpdate = true;
            }
            else {
                eAppIsMoreUpdate = FALSE;
                eAppIsUpdate = FALSE;
            }
            
        }
        NSLog(@"Done");
        if (!eAppIsMoreUpdate) {
            createdAt = [results stringForColumn:@"CreatedAt"];
            lastUpdatedAt = [results stringForColumn:@"LastUpdatedAt"];
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
            else if ([[results stringForColumn:@"ClientChoice"] isEqualToString:@"3"]) {
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
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
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrPostcode"]  forKey:@"IntermediaryPostcode"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrTown"] forKey:@"IntermediaryTown"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrState"] forKey:@"IntermediaryState"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[self getCountryDesc:[results stringForColumn:@"IntermediaryAddrCountry"]] forKey:@"IntermediaryCountry"];
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
            else if ([[eAppResults stringForColumn:@"ClientChoice"] isEqualToString:@"3"]) {
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
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
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrPostcode"]  forKey:@"IntermediaryPostcode"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrTown"] forKey:@"IntermediaryTown"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrState"] forKey:@"IntermediaryState"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[self getCountryDesc:[results stringForColumn:@"IntermediaryAddrCountry"]] forKey:@"IntermediaryCountry"];
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
	[[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"customerIndexNo"];
    
    NSDate *prospectProfileDate;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
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
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"customerIndexNo"];
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
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectOccupationCode"] forKey:@"CustomerOccupationCode"];
        FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
        while ([results2 next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"OccpDesc"] forKey:@"CustomerOccupation"];
        }
		
		if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
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
        
		
		//REMARK BY EMI
//        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
//            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
//        }
//        else {
//            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerPermanentAddressForeign"];
//        }
//        
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"CustomerPermanentAddress1"];
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"CustomerPermanentAddress2"];
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"CustomerPermanentAddress3"];
//        
//        
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"CustomerPermanentPostcode"];
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"CustomerPermanentAddressTown"];
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"CustomerPermanentAddressState"];
//        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"CustomerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"Email"];
        
        prospectProfileDate = [format dateFromString:[results stringForColumn:@"DateModified"]];
		
    }
    
    results = nil;
    results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", CFFID, @"1"];
    while ([results next]) {
        NSDate *theDate = [format dateFromString:[results stringForColumn:@"LastUpdated"]];
        if ([theDate compare:prospectProfileDate] == NSOrderedDescending || prospectProfileDate == NULL) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress1"] forKey:@"CustomerMailingAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress2"] forKey:@"CustomerMailingAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress3"] forKey:@"CustomerMailingAddress3"];
            
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingPostCode"] forKey:@"CustomerMailingPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingTown"] forKey:@"CustomerMailingAddressTown"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingState"] forKey:@"CustomerMailingAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self getCountryDesc:[results stringForColumn:@"MailingCountry"]] forKey:@"CustomerMailingAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingForeignAddressFlag"] forKey:@"CustomerMailingAddressForeign"];
        }
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"AddFromCFF"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddNewPayor"] forKey:@"AddNewPayor"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"SameAsPO"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"PTypeCode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PYFlag"] forKey:@"PYFlag"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddressSameAsPO"] forKey:@"MailingAddressSameAsPO"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddressSameAsPO"] forKey:@"PermanentAddressSameAsPO"];
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
        
        FMResultSet *cont6 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"], @"CONT006"];
        FMResultSet *cont7 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"], @"CONT007"];
        FMResultSet *cont8 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"], @"CONT008"];
        FMResultSet *cont9 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"], @"CONT009"];
        
        while([results next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"PartnerTitle"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"PartnerName"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"PartnerNRIC"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDType"] forKey:@"PartnerOtherIDType"]; //not yet
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDTypeNo"] forKey:@"PartnerOtherID"]; //not yet
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Race"] forKey:@"PartnerRace"]; //not yet
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Religion"] forKey:@"PartnerReligion"]; //not yet
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Nationality"] forKey:@"PartnerNationality"]; //not yet
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"PartnerSex"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"PartnerSmoker"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"PartnerDOB"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"]; //auto calculate
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MaritalStatus"] forKey:@"PartnerMaritalStatus"]; //not yet
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectOccupationCode"] forKey:@"PartnerOccupationCode"];
            FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
            while ([results2 next]) {
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"OccpDesc"] forKey:@"PartnerOccupation"];
            }
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
            }
            else {
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerMailingAddressForeign"];
            }
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerMailingAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerMailingAddress3"];
            
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"PartnerMailingPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"PartnerMailingAddressTown"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerMailingAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerMailingAddressCountry"];
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
            }
            else {
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerPermanentAddressForeign"];
            }
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerPermanentAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerPermanentAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerPermanentAddress3"];
            
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"PartnerPermanentPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"PartnerPermanentAddressTown"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerPermanentAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerPermanentAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"PartnerEmail"];
        }
        
        while ([cont6 next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"Prefix"] forKey:@"PartnerResidenceTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"ContactNo"] forKey:@"PartnerResidenceTel"];
        }
        
        while ([cont7 next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"Prefix"] forKey:@"PartnerOfficeTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"ContactNo"] forKey:@"PartnerOfficeTel"];
        }
        //fix for bug 2646 start
        while ([cont8 next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"Prefix"] forKey:@"PartnerMobileTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"ContactNo"] forKey:@"PartnerMobileTel"];
        }
        //fix for bug 2646 end
        while ([cont9 next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"Prefix"] forKey:@"PartnerFaxTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"ContactNo"] forKey:@"PartnerFaxTel"];
        }
        
        results = nil;
        results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", CFFID, @"2"];
        while ([results next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress1"] forKey:@"PartnerMailingAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress2"] forKey:@"PartnerMailingAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress3"] forKey:@"PartnerMailingAddress3"];
            
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingPostCode"] forKey:@"PartnerMailingPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingTown"] forKey:@"PartnerMailingAddressTown"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingState"] forKey:@"PartnerMailingAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingCountry"] forKey:@"PartnerMailingAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingForeignAddressFlag"] forKey:@"PartnerMailingAddressForeign"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"PartnerAddFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddNewPayor"] forKey:@"PartnerAddNewPayor"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"PartnerSameAsPO"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"PartnerPTypeCode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PYFlag"] forKey:@"PartnerPYFlag"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddressSameAsPO"] forKey:@"PartnerMailingAddressSameAsPO"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddressSameAsPO"] forKey:@"PartnerPermanentAddressSameAsPO"];
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
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerEmail"];
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
        results = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], nil];
        
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
            results = [database executeQuery:@"select * from eProposal_CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], nil];
        }
        while ([results next]) {
            gotChildCount++;
            if (gotChildCount == 1){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden1"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen1Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen1Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen1DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen1Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[self getRelationshipDesc:[results stringForColumn:@"Relationship"]] forKey:@"Childen1Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen1RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen1Support"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"Childen1AddFromCFF"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"Childen1SameAsPO"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"Childen1PTypeCode"];
            }
            else if (gotChildCount == 2){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden2"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen2Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen2Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen2DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen2Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[self getRelationshipDesc:[results stringForColumn:@"Relationship"]] forKey:@"Childen2Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen2RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen2Support"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"Childen2AddFromCFF"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"Childen2SameAsPO"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"Childen2PTypeCode"];
            }
            else if (gotChildCount == 3){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden3"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen3Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen3Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen3DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen3Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[self getRelationshipDesc:[results stringForColumn:@"Relationship"]] forKey:@"Childen3Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen3RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen3Support"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"Childen3AddFromCFF"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"Childen3SameAsPO"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"Childen3PTypeCode"];
            }
            else if (gotChildCount == 4){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden4"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen4Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen4Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen4DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen4Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[self getRelationshipDesc:[results stringForColumn:@"Relationship"]] forKey:@"Childen4Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen4RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen4Support"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"Childen4AddFromCFF"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"Childen4SameAsPO"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"Childen4PTypeCode"];
            }
            else if (gotChildCount == 5){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden5"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen5Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen5Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen5DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen5Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[self getRelationshipDesc:[results stringForColumn:@"Relationship"]] forKey:@"Childen5Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen5RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen5Support"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"Childen5AddFromCFF"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"Childen5SameAsPO"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"Childen5PTypeCode"];
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
        results = [database executeQuery:@"select * from eProposal_CFF_Protection where CFFID = ? and eProposalNo=?", CFFID,[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], Nil];
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
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalPA_SurplusShortFall"] forKey:@"ProtectionDifference4"];
        
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
        results = [database executeQuery:@"select * from eProposal_CFF_Retirement where CFFID = ? and eProposalNo = ?", CFFID,[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_Retirement_Details where CFFID = ? and eProposalNo = ? order by SeqNo asc",CFFID,[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
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
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation2ValueMaturity"];
        }
        else if (educationCount == 3){
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
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest where CFFID = ? and eProposalNo=? ",CFFID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest_Details where CFFID = ? and eProposalNo = ? order by SeqNo asc",CFFID, [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], Nil];
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
        NSString *IntermediaryNRIC  = [results stringForColumn:@"AgentICNo"];
        
        NSString *IntermediaryAddress1  = [results stringForColumn:@"AgentAddr1"];
        NSString *IntermediaryAddress2  = [results stringForColumn:@"AgentAddr2"];
        NSString *IntermediaryAddress3  = [results stringForColumn:@"AgentAddr3"];
        NSString *IntermediaryAddress4  = [results stringForColumn:@"AgentAddr4"];
		NSString *IntermediaryPostcode  = [results stringForColumn:@"AgentAddrPostcode"];
        NSString *IntermediaryCodeContractDate  = [results stringForColumn:@"AgentContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCodeContractDate forKey:@"IntermediaryCodeContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
		[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryPostcode forKey:@"IntermediaryPostcode"];
    }
	results = nil;
    results = [database executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryPostcode"]];
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecH"] setValue:[results objectForColumnName:@"Town"] forKey:@"IntermediaryTown"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:[results objectForColumnName:@"StateDesc"] forKey:@"IntermediaryState"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:@"MALAYSIA" forKey:@"IntermediaryCountry"];
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
            if (![[results stringForColumn:@"InsuredName"] isEqualToString:@""]) {
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
        }
        else if (recommendCount == 2){
            if (![[results stringForColumn:@"InsuredName"] isEqualToString:@""]) {
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
        else if (recommendCount == 3){
            if (![[results stringForColumn:@"InsuredName"] isEqualToString:@""]) {
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured3"];
                //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought3"];
            }
        }
        else if (recommendCount == 4){
            if (![[results stringForColumn:@"InsuredName"] isEqualToString:@""]) {
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured4"];
                //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought4"];
            }
        }
        else if (recommendCount == 5){
            if (![[results stringForColumn:@"InsuredName"] isEqualToString:@""]) {
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured5"];
                //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought5"];
            }
        }
    }
    //[self storeXMLData:CFFID];
    //insert into xml object
    /*NSDictionary *confirmationOfAdviceGivenTo = @{@"Choice1" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],
                                                  @"Choice2" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],
                                                  @"Choice3" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],
                                                  @"Choice4" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],
                                                  @"Choice5" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],
                                                  @"Choice6" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],
                                                  @"Choice6_desc" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],
                                                  };*/
    
    /*NSDictionary *productRecommended = @{@"RecCount" : @"2",
                                         @"RecommendationInfo ID=\"1\"" :
                                             @{@"Seq" : @"1",
                                               @"InsuredName" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured1"],
                                               @"PlanType" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType1"],
                                               @"Term" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term1"],
                                               @"Premium" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium1"],
                                               @"Frequency" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"],
                                               @"SA" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured1"],
                                               @"BoughtOpt" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"],
                                               @"AddNew" : @"False",
                                               @"AdditionalBenefits" :
                                                   @{
                                                     },
                                               },
                                         @"RecommendationInfo ID=\"2\"" :
                                             @{@"Seq" : @"2",
                                               @"InsuredName" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured2"],
                                               @"PlanType" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType2"],
                                               @"Term" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term2"],
                                               @"Premium" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium2"],
                                               @"Frequency" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"],
                                               @"SA" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured2"],
                                               @"BoughtOpt" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"],
                                               @"AddNew" : @"False",
                                               @"AdditionalBenefits" :
                                                   @{
                                                       },
                                               },
                                         @"RecommendationInfo ID=\"3\"" :
                                             @{@"Seq" : @"3",
                                               @"InsuredName" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured3"],
                                               @"PlanType" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType3"],
                                               @"Term" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term3"],
                                               @"Premium" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium3"],
                                               @"Frequency" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"],
                                               @"SA" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured3"],
                                               @"BoughtOpt" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"],
                                               @"AddNew" : @"False",
                                               @"AdditionalBenefits" :
                                                   @{
                                                       },
                                               },
                                         @"RecommendationInfo ID=\"4\"" :
                                             @{@"Seq" : @"4",
                                               @"InsuredName" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured4"],
                                               @"PlanType" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType4"],
                                               @"Term" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term4"],
                                               @"Premium" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium4"],
                                               @"Frequency" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"],
                                               @"SA" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured4"],
                                               @"BoughtOpt" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"],
                                               @"AddNew" : @"False",
                                               @"AdditionalBenefits" :
                                                   @{
                                                       },
                                               },
                                         @"RecommendationInfo ID=\"5\"" :
                                             @{@"Seq" : @"5",
                                               @"InsuredName" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured5"],
                                               @"PlanType" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType5"],
                                               @"Term" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term5"],
                                               @"Premium" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium5"],
                                               @"Frequency" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"],
                                               @"SA" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured5"],
                                               @"BoughtOpt" : [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"],
                                               @"AddNew" : @"False",
                                               @"AdditionalBenefits" :
                                                   @{
                                                       },
                                               },
                                         
                                         };*/
    
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
		[[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"customerIndexNo"];
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
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MA"]) {
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
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerEmail"];
    
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
        NSString *IntermediaryNRIC  = [results stringForColumn:@"AgentICNo"];
        
        NSString *IntermediaryAddress1  = [results stringForColumn:@"AgentAddr1"];
        NSString *IntermediaryAddress2  = [results stringForColumn:@"AgentAddr2"];
        NSString *IntermediaryAddress3  = [results stringForColumn:@"AgentAddr3"];
        NSString *IntermediaryAddress4  = [results stringForColumn:@"AgentAddr4"];
		NSString *IntermediaryPostcode  = [results stringForColumn:@"AgentAddrPostcode"];
        NSString *IntermediaryCodeContractDate  = [results stringForColumn:@"AgentContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCodeContractDate forKey:@"IntermediaryCodeContractDate"];
        
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
		[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryPostcode forKey:@"IntermediaryPostcode"];
    }
    results = nil;
    results = [database executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryPostcode"]];
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecH"] setValue:[results objectForColumnName:@"Town"] forKey:@"IntermediaryTown"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:[results objectForColumnName:@"StateDesc"] forKey:@"IntermediaryState"];
        [[obj.CFFData objectForKey:@"SecH"] setValue:@"MALAYSIA" forKey:@"IntermediaryCountry"];
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

#pragma mark - XML

-(void) storeXMLData:(NSString *) cffId {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    //cff info
    if (eAppIsUpdate) {
        results = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE eProposalNo=?", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
    }
    else {
        results= [database executeQuery:@"SELECT * FROM CFF_Master WHERE ID=?",cffId];
    }
    
    NSString *createdAt;
    NSString *lastUpdatedAt;
    NSString *intermediaryStatus;
    NSString *brokerName;
    NSString *clientChoice;
    NSString *riskReturnProfile;
    NSString *q1ans1;
    NSString *q1ans2;
    NSString *q1priority;
    NSString *q2ans1;
    NSString *q2ans2;
    NSString *q2priority;
    NSString *q3ans1;
    NSString *q3ans2;
    NSString *q3priority;
    NSString *q4ans1;
    NSString *q4ans2;
    NSString *q4priority;
    NSString *q5ans1;
    NSString *q5ans2;
    NSString *q5priority;
    NSString *intermediaryCode;
    NSString *intermediaryName;
    NSString *intermediaryNRIC;
    NSString *intermediaryContractDate;
    NSString *intermediaryAddress1;
    NSString *intermediaryAddress2;
    NSString *intermediaryAddress3;
    NSString *intermediaryAddress4;
    NSString *intermediaryPostcode;
    NSString *intermediaryTown;
    NSString *intermediaryState;
    NSString *intermediaryCountry;
    NSString *intermediaryManagerName;
    NSString *clientAck;
    NSString *clientComments;
    
    while ([results next]) {
        createdAt = [results stringForColumn:@"createdAt"];
        lastUpdatedAt = [results stringForColumn:@"LastUpdatedAt"];
        intermediaryStatus = [results stringForColumn:@"IntermediaryStatus"];
        brokerName = [results stringForColumn:@"BrokerName"];
        clientChoice = [results stringForColumn:@"ClientChoice"];
        riskReturnProfile = [results stringForColumn:@"RiskReturnProfile"];
        
        q1ans1 = [results stringForColumn:@"NeedsQ1_Ans1"];
        q1ans2 = [results stringForColumn:@"NeedsQ1_Ans2"];
        q1priority = [results stringForColumn:@"NeedsQ1_Priority"];
        q2ans1 = [results stringForColumn:@"NeedsQ2_Ans1"];
        q2ans2 = [results stringForColumn:@"NeedsQ2_Ans2"];
        q2priority = [results stringForColumn:@"NeedsQ2_Priority"];
        q3ans1 = [results stringForColumn:@"NeedsQ3_Ans1"];
        q3ans2 = [results stringForColumn:@"NeedsQ3_Ans2"];
        q3priority = [results stringForColumn:@"NeedsQ3_Priority"];
        q4ans1 = [results stringForColumn:@"NeedsQ4_Ans1"];
        q4ans2 = [results stringForColumn:@"NeedsQ4_Ans2"];
        q4priority = [results stringForColumn:@"NeedsQ4_Priority"];
        q5ans1 = [results stringForColumn:@"NeedsQ5_Ans1"];
        q5ans2 = [results stringForColumn:@"NeedsQ5_Ans2"];
        q5priority = [results stringForColumn:@"NeedsQ5_Priority"];
        
        intermediaryCode = [results stringForColumn:@"IntermediaryCode"];
        intermediaryName = [results stringForColumn:@"IntermediaryName"];
        intermediaryNRIC = [results stringForColumn:@"IntermediaryNRIC"];
        intermediaryContractDate = [results stringForColumn:@"IntermediaryContractDate"];
        intermediaryAddress1 = [results stringForColumn:@"IntermediaryAddress1"];
        intermediaryAddress2 = [results stringForColumn:@"IntermediaryAddress2"];
        intermediaryAddress3 = [results stringForColumn:@"IntermediaryAddress3"];
        intermediaryAddress4 = [results stringForColumn:@"IntermediaryAddress4"];
        
        intermediaryPostcode = [results stringForColumn:@"IntermediaryAddrPostcode"];
        intermediaryTown = [results stringForColumn:@"IntermediaryAddrTown"];
        intermediaryState = [results stringForColumn:@"IntermediaryAddrState"];
        intermediaryCountry = [results stringForColumn:@"IntermediaryAddrCountry"];
        
        intermediaryManagerName = [results stringForColumn:@"IntermediaryManagerName"];
        clientAck = [results stringForColumn:@"ClientAck"];
        clientComments = [results stringForColumn:@"ClientComments"];
    }
    
    
    NSDictionary *eCFFInfo = @{@"CreatedAt" : createdAt,
                               @"LastUpdatedAt" : lastUpdatedAt,
                               @"IntermediaryStatus" : intermediaryStatus,
                               @"BrokerName" : brokerName,
                               @"ClientChoice" : clientChoice,
                               @"RiskReturnProfile" : riskReturnProfile,
                               @"NeedsQ1_Ans1" : q1ans1,
                               @"NeedsQ1_Ans2" : q1ans2,
                               @"NeedsQ1_Priority" : q1priority,
                               @"NeedsQ2_Ans1" : q2ans1,
                               @"NeedsQ2_Ans2" : q2ans2,
                               @"NeedsQ2_Priority" : q2priority,
                               @"NeedsQ3_Ans1" : q3ans1,
                               @"NeedsQ3_Ans2" : q3ans2,
                               @"NeedsQ3_Priority" : q3priority,
                               @"NeedsQ4_Ans1" : q4ans1,
                               @"NeedsQ4_Ans2" : q4ans2,
                               @"NeedsQ4_Priority" : q4priority,
                               @"NeedsQ5_Ans1" : q5ans1,
                               @"NeedsQ5_Ans2" : q5ans2,
                               @"NeedsQ5_Priority" : q5priority,
                               @"IntermediaryCode" : intermediaryCode,
                               @"IntermediaryName" : intermediaryName,
                               @"IntermediaryNRIC" : intermediaryNRIC,
                               @"IntermediaryContractDate" : intermediaryContractDate,
                               @"IntermediaryAddress1" : intermediaryAddress1,
                               @"IntermediaryAddress2" : intermediaryAddress2,
                               @"IntermediaryAddress3" : intermediaryAddress3,
                               @"IntermediaryAddress4" : intermediaryAddress4,
                               @"IntermediaryManagerName" : intermediaryManagerName,
                               @"ClientAck" : clientAck,
                               @"ClientComments" : clientComments,
                               };
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:eCFFInfo forKey:@"eCFFInfo"];
    
    //personal info for cff payor
    NSString *addFromCFF = @"";
    NSString *addNewPayor = @"";
    NSString *sameAsPO = @"";
    NSString *PTypeCode = @"";
    NSString *PYFlag = @"";
    NSString *title;
    NSString *name;
    NSString *newICNo;
    NSString *otherIDType;
    NSString *otherID;
    NSString *nationality;
    NSString *race;
    NSString *religion;
    NSString *sex;
    NSString *smoker;
    NSString *dob;
    NSString *age;
    NSString *maritalStatus;
    NSString *occupation;
    NSString *residenceNo;
    NSString *officePhoneNo;
    NSString *mobilePhoneNo;
    NSString *faxPhoneNo;
    NSString *emailAddress;
    NSString *addressSameAsPO;
    NSString *address1;
    NSString *address2;
    NSString *address3;
    NSString *town;
    NSString *state;
    NSString *postcode;
    NSString *country;
    NSString *foreignAddress;
    NSString *permanentAddressSameAsPO;
    NSString *permanentAddress1;
    NSString *permanentAddress2;
    NSString *permanentAddress3;
    NSString *permanentTown;
    NSString *permanentState;
    NSString *permanentPostcode;
    NSString *permanentCountry;
    NSString *permanentForeignAddress;
    
    results = nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]]];
    
    NSDate *prospectProfileDate;
    
    while ([results next]) {
        title = [results stringForColumn:@"ProspectTitle"];
        name = [results stringForColumn:@"ProspectName"];
        newICNo = [results stringForColumn:@"IDTypeNo"];
        if (newICNo == NULL) {
            newICNo = @"";
        }
        otherIDType = [results stringForColumn:@"OtherIDType"];
        if (otherIDType == NULL) {
            otherIDType = @"";
        }
        otherID = [results stringForColumn:@"OtherIDTypeNo"];
        if (otherID == NULL) {
            otherID = @"";
        }
        nationality = [results stringForColumn:@"Nationality"];
        race = [results stringForColumn:@"Race"];
        religion = [results stringForColumn:@"Religion"];
        sex = [results stringForColumn:@"ProspectGender"];
        smoker = [results stringForColumn:@"Smoker"];
        dob = [results stringForColumn:@"ProspectDOB"];
        age = @"0";
        maritalStatus = [results stringForColumn:@"MaritalStatus"];
        
        FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
        while ([results2 next]) {
            occupation = [results2 stringForColumn:@"OccpDesc"];
        }
        
        emailAddress = [results stringForColumn:@"ProspectEmail"];
        
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
			foreignAddress = @"0";
		}
		else {
			foreignAddress = @"1";
		}
        
        address1 = [results stringForColumn:@"ResidenceAddress1"];
        address2 = [results stringForColumn:@"ResidenceAddress2"];
        address3 = [results stringForColumn:@"ResidenceAddress3"];
        town = [results stringForColumn:@"ResidenceAddressTown"];
        state = [results stringForColumn:@"ResidenceAddressState"];
        postcode = [results stringForColumn:@"ResidenceAddressPostCode"];
        country = [results stringForColumn:@"ResidenceAddressCountry"];
        
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
			permanentForeignAddress = @"0";
		}
		else {
			permanentForeignAddress = @"1";
		}
        
        permanentAddress1 = [results stringForColumn:@"ResidenceAddress1"];
        permanentAddress2 = [results stringForColumn:@"ResidenceAddress2"];
        permanentAddress3 = [results stringForColumn:@"ResidenceAddress3"];
        permanentTown = [results stringForColumn:@"ResidenceAddressTown"];
        permanentState = [results stringForColumn:@"ResidenceAddressState"];
        permanentPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
        permanentCountry = [results stringForColumn:@"ResidenceAddressCountry"];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        prospectProfileDate = [format dateFromString:[results stringForColumn:@"DateModified"]];
        
        results = nil;
        results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", cffId, @"1"];
        while ([results next]) {
            NSDate *theDate = [format dateFromString:[results stringForColumn:@"LastUpdated"]];
            if ([theDate compare:prospectProfileDate] == NSOrderedDescending || prospectProfileDate == NULL) {
                
                if ([[results stringForColumn:@"MailingCountry"] isEqualToString:@"MAL"]) {
                    foreignAddress = @"0";
                }
                else {
                    foreignAddress = @"1";
                }
                
                address1 = [results stringForColumn:@"MailingAddress1"];
                address2 = [results stringForColumn:@"MailingAddress2"];
                address3 = [results stringForColumn:@"MailingAddress3"];
                town = [results stringForColumn:@"MailingTown"];
                state = [results stringForColumn:@"MailingState"];
                postcode = [results stringForColumn:@"MailingPostCode"];
                country = [results stringForColumn:@"MailingCountry"];
            }
            
            addFromCFF = [results stringForColumn:@"AddFromCFF"];
            addNewPayor = [results stringForColumn:@"AddNewPayor"];
            sameAsPO = [results stringForColumn:@"SameAsPO"];
            PTypeCode = [results stringForColumn:@"PTypeCode"];
            PYFlag = [results stringForColumn:@"PYFlag"];
            addressSameAsPO = [results stringForColumn:@"MailingAddressSameAsPO"];
            permanentAddressSameAsPO = [results stringForColumn:@"PermanentAddressSameAsPO"];
        }
        
        if (addFromCFF == NULL) {
            addFromCFF = @"";
        }
        if (addNewPayor == NULL) {
            addNewPayor = @"";
        }
        if (sameAsPO == NULL) {
            sameAsPO = @"";
        }
        if (PTypeCode == NULL) {
            PTypeCode = @"";
        }
        if (PYFlag == NULL) {
            PYFlag = @"";
        }
        if (addressSameAsPO == NULL) {
            addressSameAsPO = @"";
        }
        if (permanentAddressSameAsPO == NULL) {
            permanentAddressSameAsPO = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT006"];
        while ([results next]) {
            residenceNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (residenceNo == NULL) {
            residenceNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT007"];
        while ([results next]) {
            officePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (officePhoneNo == NULL) {
            officePhoneNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT008"];
        while ([results next]) {
            mobilePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (mobilePhoneNo == NULL) {
            mobilePhoneNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT009"];
        while ([results next]) {
            faxPhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (faxPhoneNo == NULL) {
            faxPhoneNo = @"";
        }
    }
    
    NSDictionary *personalInfo = @{@"CFFParty ID=\"1\"" :
                                       @{@"AddFromCFF" : addFromCFF,
                                         @"AddNewPayor" : addNewPayor,
                                         @"SameAsPO" : sameAsPO,
                                         @"PTypeCode" : PTypeCode,
                                         @"PYFlag" : PYFlag,
                                         @"Title" : title,
                                         @"Name" : name,
                                         @"NewICNo" : newICNo,
                                         @"OtherIDType" : otherIDType,
                                         @"OtherID" : otherID,
                                         @"Nationality" : nationality,
                                         @"Race" : race,
                                         @"Religion" : religion,
                                         @"Sex" : sex,
                                         @"Smoker" : smoker,
                                         @"DOB" : dob,
                                         @"Age" : age,
                                         @"MaritalStatus" : maritalStatus,
                                         @"Occupation" : occupation,
                                         @"ResidencePhoneNo" : residenceNo,
                                         @"OfficePhoneNo" : officePhoneNo,
                                         @"MobilePhoneNo" : mobilePhoneNo,
                                         @"FaxPhoneNo" : faxPhoneNo,
                                         @"EmailAddress" : emailAddress,
                                         @"CFFAddresses" :
                                             @{@"CFFAddress Type=\"Mailing\"" :
                                                   @{@"AddressSameAsPO":sameAsPO,
                                                     @"Address1":address1,
                                                     @"Address2":address2,
                                                     @"Address3":address3,
                                                     @"Town": town,
                                                     @"State":state,
                                                     @"Postcode":postcode,
                                                     @"Country":country,
                                                     @"ForeignAddress":foreignAddress,
                                                     },
                                               @"CFFAddress Type=\"Permanent\"" :
                                                   @{@"AddressSameAsPO":permanentAddressSameAsPO,
                                                     @"Address1":permanentAddress1,
                                                     @"Address2":permanentAddress2,
                                                     @"Address3":permanentAddress3,
                                                     @"Town":permanentTown,
                                                     @"State":permanentState,
                                                     @"Postcode":permanentPostcode,
                                                     @"Country":permanentCountry,
                                                     @"ForeignAddress":permanentForeignAddress,
                                                     },
                                               },
                                         },
                                   };
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:personalInfo forKey:@"eCFFPersonalInfo"];
    
    //personal info for cff partner
    NSString *partnerAddFromCFF = @"";
    NSString *partnerAddNewPayor = @"";
    NSString *partnerSameAsPO = @"";
    NSString *partnerPTypeCode = @"";
    NSString *partnerPYFlag = @"";
    NSString *partnerTitle;
    NSString *partnerName;
    NSString *partnerNewICNo;
    NSString *partnerOtherIDType;
    NSString *partnerOtherID;
    NSString *partnerNationality;
    NSString *partnerRace;
    NSString *partnerReligion;
    NSString *partnerSex;
    NSString *partnerSmoker;
    NSString *partnerDob;
    NSString *partnerAge;
    NSString *partnerMaritalStatus;
    NSString *partnerOccupation;
    NSString *partnerResidenceNo;
    NSString *partnerOfficePhoneNo;
    NSString *partnerMobilePhoneNo;
    NSString *partnerFaxPhoneNo;
    NSString *partnerEmailAddress;
    NSString *partnerAddressSameAsPO;
    NSString *partnerAddress1;
    NSString *partnerAddress2;
    NSString *partnerAddress3;
    NSString *partnerTown;
    NSString *partnerState;
    NSString *partnerPostcode;
    NSString *partnerCountry;
    NSString *partnerForeignAddress;
    NSString *partnerPermanentAddressSameAsPO;
    NSString *partnerPermanentAddress1;
    NSString *partnerPermanentAddress2;
    NSString *partnerPermanentAddress3;
    NSString *partnerPermanentTown;
    NSString *partnerPermanentState;
    NSString *partnerPermanentPostcode;
    NSString *partnerPermanentCountry;
    NSString *partnerPermanentForeignAddress;
    
    results = nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]]];
    NSLog(@"existing partner: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
    NSLog(@"partnerid: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]);
    while ([results next]) {
        partnerTitle = [results stringForColumn:@"ProspectTitle"];
        partnerName = [results stringForColumn:@"ProspectName"];
        partnerNewICNo = [results stringForColumn:@"IDTypeNo"];
        if (partnerNewICNo == NULL) {
            partnerNewICNo = @"";
        }
        partnerOtherIDType = [results stringForColumn:@"OtherIDType"];
        if (partnerOtherIDType == NULL) {
            partnerOtherIDType = @"";
        }
        partnerOtherID = [results stringForColumn:@"OtherIDTypeNo"];
        if (partnerOtherID == NULL) {
            partnerOtherID = @"";
        }
        partnerNationality = [results stringForColumn:@"Nationality"];
        partnerRace = [results stringForColumn:@"Race"];
        partnerReligion = [results stringForColumn:@"Religion"];
        partnerSex = [results stringForColumn:@"ProspectGender"];
        partnerSmoker = [results stringForColumn:@"Smoker"];
        partnerDob = [results stringForColumn:@"ProspectDOB"];
        partnerAge = @"0";
        partnerMaritalStatus = [results stringForColumn:@"MaritalStatus"];
        
        FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
        while ([results2 next]) {
            partnerOccupation = [results2 stringForColumn:@"OccpDesc"];
        }
        
        partnerEmailAddress = [results stringForColumn:@"ProspectEmail"];
        
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
			partnerForeignAddress = @"0";
		}
		else {
			partnerForeignAddress = @"1";
		}
        
        partnerAddress1 = [results stringForColumn:@"ResidenceAddress1"];
        partnerAddress2 = [results stringForColumn:@"ResidenceAddress2"];
        partnerAddress3 = [results stringForColumn:@"ResidenceAddress3"];
        partnerTown = [results stringForColumn:@"ResidenceAddressTown"];
        partnerState = [results stringForColumn:@"ResidenceAddressState"];
        partnerPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
        partnerCountry = [results stringForColumn:@"ResidenceAddressCountry"];
        
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
			partnerPermanentForeignAddress = @"0";
		}
		else {
			partnerPermanentForeignAddress = @"1";
		}
        
        partnerPermanentAddress1 = [results stringForColumn:@"ResidenceAddress1"];
        partnerPermanentAddress2 = [results stringForColumn:@"ResidenceAddress2"];
        partnerPermanentAddress3 = [results stringForColumn:@"ResidenceAddress3"];
        partnerPermanentTown = [results stringForColumn:@"ResidenceAddressTown"];
        partnerPermanentState = [results stringForColumn:@"ResidenceAddressState"];
        partnerPermanentPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
        partnerPermanentCountry = [results stringForColumn:@"ResidenceAddressCountry"];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        prospectProfileDate = [format dateFromString:[results stringForColumn:@"DateModified"]];
        
        results = nil;
        results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", cffId, @"1"];
        while ([results next]) {
            NSDate *theDate = [format dateFromString:[results stringForColumn:@"LastUpdated"]];
            if ([theDate compare:prospectProfileDate] == NSOrderedDescending || prospectProfileDate == NULL) {
                
                if ([[results stringForColumn:@"MailingCountry"] isEqualToString:@"MAL"]) {
                    partnerForeignAddress = @"0";
                }
                else {
                    partnerForeignAddress = @"1";
                }
                
                partnerAddress1 = [results stringForColumn:@"MailingAddress1"];
                partnerAddress2 = [results stringForColumn:@"MailingAddress2"];
                partnerAddress3 = [results stringForColumn:@"MailingAddress3"];
                partnerTown = [results stringForColumn:@"MailingTown"];
                partnerState = [results stringForColumn:@"MailingState"];
                partnerPostcode = [results stringForColumn:@"MailingPostCode"];
                partnerCountry = [results stringForColumn:@"MailingCountry"];
            }
            
            partnerAddFromCFF = [results stringForColumn:@"AddFromCFF"];
            partnerAddNewPayor = [results stringForColumn:@"AddNewPayor"];
            partnerSameAsPO = [results stringForColumn:@"SameAsPO"];
            partnerPTypeCode = [results stringForColumn:@"PTypeCode"];
            partnerPYFlag = [results stringForColumn:@"PYFlag"];
            partnerAddressSameAsPO = [results stringForColumn:@"MailingAddressSameAsPO"];
            partnerPermanentAddressSameAsPO = [results stringForColumn:@"PermanentAddressSameAsPO"];
        }
        
        if (partnerAddFromCFF == NULL) {
            partnerAddFromCFF = @"";
        }
        if (partnerAddNewPayor == NULL) {
            partnerAddNewPayor = @"";
        }
        if (partnerAddressSameAsPO == NULL) {
            partnerAddressSameAsPO = @"";
        }
        if (partnerPTypeCode == NULL) {
            partnerPTypeCode = @"";
        }
        if (partnerPYFlag == NULL) {
            partnerPYFlag = @"";
        }
        if (partnerSameAsPO == NULL) {
            partnerSameAsPO = @"";
        }
        if (partnerPermanentAddressSameAsPO == NULL) {
            partnerPermanentAddressSameAsPO = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT006"];
        while ([results next]) {
            partnerResidenceNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (partnerResidenceNo == NULL) {
            partnerResidenceNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT007"];
        while ([results next]) {
            partnerOfficePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (partnerOfficePhoneNo == NULL) {
            partnerOfficePhoneNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT008"];
        while ([results next]) {
            partnerMobilePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (partnerMobilePhoneNo == NULL) {
            partnerMobilePhoneNo = @"";
        }
        
        results = nil;
        results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT009"];
        while ([results next]) {
            partnerFaxPhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
        }
        if (partnerFaxPhoneNo == NULL) {
            partnerFaxPhoneNo = @"";
        }
    }
    if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        partnerAddFromCFF = @"";
        partnerAddNewPayor = @"";
        partnerSameAsPO = @"";
        partnerPTypeCode = @"";
        partnerPYFlag = @"";
        partnerTitle = @"";
        partnerName= @"";
        partnerNewICNo = @"";
        partnerOtherIDType = @"";
        partnerOtherID = @"";
        partnerNationality = @"";
        partnerRace = @"";
        partnerReligion = @"";
        partnerSex = @"";
        partnerSmoker = @"";
        partnerDob = @"";
        partnerAge = @"";
        partnerMaritalStatus = @"";
        partnerOccupation = @"";
        partnerResidenceNo = @"";
        partnerOfficePhoneNo = @"";
        partnerMobilePhoneNo = @"";
        partnerFaxPhoneNo = @"";
        partnerEmailAddress = @"";
        partnerAddressSameAsPO = @"";
        partnerAddress1 = @"";
        partnerAddress2 = @"";
        partnerAddress3 = @"";
        partnerTown = @"";
        partnerState = @"";
        partnerPostcode = @"";
        partnerCountry = @"";
        partnerForeignAddress = @"";
        partnerPermanentAddressSameAsPO = @"";
        partnerPermanentAddress1 = @"";
        partnerPermanentAddress2 = @"";
        partnerPermanentAddress3 = @"";
        partnerPermanentTown = @"";
        partnerPermanentState = @"";
        partnerPermanentPostcode = @"";
        partnerPermanentCountry = @"";
        partnerPermanentForeignAddress = @"";
    }
    NSDictionary *partnerInfo = @{@"CFFParty ID=\"2\"" :
    @{@"AddFromCFF" : partnerAddFromCFF,
      @"AddNewPayor" : partnerAddNewPayor,
      @"SameAsPO" : partnerSameAsPO,
      @"PTypeCode" : partnerPTypeCode,
      @"PYFlag" : partnerPYFlag,
      @"Title" : partnerTitle,
      @"Name" : partnerName,
      @"NewICNo" : partnerNewICNo,
      @"OtherIDType" : partnerOtherID,
      @"OtherID" : partnerOtherID,
      @"Nationality" : partnerNationality,
      @"Race" : partnerRace,
      @"Religion" : partnerReligion,
      @"Sex" : partnerSex,
      @"Smoker" : partnerSmoker,
      @"DOB" : partnerDob,
      @"Age" : partnerAge,
      @"MaritalStatus" : partnerMaritalStatus,
      @"Occupation" : partnerOccupation,
      @"ResidencePhoneNo" : partnerResidenceNo,
      @"OfficePhoneNo" : partnerOfficePhoneNo,
      @"MobilePhoneNo" : partnerMobilePhoneNo,
      @"FaxPhoneNo" : partnerFaxPhoneNo,
      @"EmailAddress" : partnerEmailAddress,
      @"CFFAddresses" :
          @{@"CFFAddress Type=\"Mailing\"" :
                @{@"AddressSameAsPO":partnerAddressSameAsPO,
                  @"Address1":partnerAddress1,
                  @"Address2":partnerAddress2,
                  @"Address3":partnerAddress3,
                  @"Town":partnerTown,
                  @"State":partnerState,
                  @"Postcode":partnerPostcode,
                  @"Country":partnerCountry,
                  @"ForeignAddress":partnerForeignAddress,
                  },
            @"CFFAddress Type=\"Permanent\"" :
                @{@"AddressSameAsPO":partnerPermanentAddressSameAsPO,
                  @"Address1":partnerPermanentAddress1,
                  @"Address2":partnerPermanentAddress2,
                  @"Address3":partnerPermanentAddress3,
                  @"Town":partnerPermanentTown,
                  @"State":partnerPermanentState,
                  @"Postcode":partnerPermanentPostcode,
                  @"Country":partnerPermanentCountry,
                  @"ForeignAddress":partnerPermanentForeignAddress,
                  },
            },
        },
    };
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:partnerInfo forKey:@"eCFFPartnerInfo"];
    }
    
    // child info
    results = nil;
    if (eAppIsUpdate) {
        results = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"], nil];
    }
    else {
       results = [database executeQuery:@"select count(*) as cnt from CFF_Family_Details where CFFID = ?",cffId,Nil];
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
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_Family_Details where CFFID = ? order by ID asc",cffId,Nil];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_Family_Details where eProposalNo = ? order by ID asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        NSString *addFromCFF;
        NSString *sameAsPO;
        NSString *PTypeCode;
        NSString *name;
        NSString *relationship;
        NSString *dob;
        NSString *age;
        NSString *sex;
        NSString *support;
        
        NSMutableArray *childsInfo = [NSMutableArray array];
        while ([results next]) {
            gotChildCount++;
            addFromCFF = [results stringForColumn:@"AddFromCFF"];
            sameAsPO = [results stringForColumn:@"SameAsPO"];
            PTypeCode = [results stringForColumn:@"PTypeCode"];
            name = [results stringForColumn:@"Name"];
            relationship = [results stringForColumn:@"Relationship"];
            dob = [results stringForColumn:@"DOB"];
            age = [results stringForColumn:@"Age"];
            sex = [results stringForColumn:@"Sex"];
            support = [results stringForColumn:@"YearsToSupport"];
            NSString *idno = [NSString stringWithFormat:@"%d", gotChildCount];
            
            NSDictionary *childInfo = @{[NSString stringWithFormat: @"ChildParty ID=\"%@\"", idno] :
                                            @{@"AddFromCFF":addFromCFF,
                                              @"SameAsPO":sameAsPO,
                                              @"PTypeCode":PTypeCode,
                                              @"Name":name,
                                              @"Relationship":relationship,
                                              @"DOB":dob,
                                              @"Age":age,
                                              @"Sex":sex,
                                              @"YearsToSupport":support,
                                              },
                                        
                                        };
            [childsInfo addObject:childInfo];
            
        }
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:childsInfo forKey:@"eCFFChildInfo"];
    }
    
    //protection info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Protection where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    
    NSString *allocateIncome1;
    NSString *allocateIncome2;
    NSString *totalSACurAmt;
    NSString *totalSAReqAmt;
    NSString *totalSASurAmt;
    NSString *totalCISACurAmt;
    NSString *totalCISAReqAmt;
    NSString *totalCISASurAmt;
    NSString *totalHBCurAmt;
    NSString *totalHBReqAmt;
    NSString *totalHBSurAmt;
    NSString *totalPACurAmt;
    NSString *totalPAReqAmt;
    NSString *totalPASurAmt;
    NSString *hasProtection = @"True";
    bool gotProtection = FALSE;
    while ([results next]) {
        gotProtection = TRUE;
        hasProtection = [results stringForColumn:@"NoExstingPlan"] != NULL ? [results stringForColumn:@"NoExstingPlan"] : @"";
        if ([hasProtection isEqualToString:@"0"]) {
            hasProtection=@"False";
        }
        allocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"0.00";
        allocateIncome2 = [results stringForColumn:@"AllocateIncome_2"] != NULL ? [results stringForColumn:@"AllocateIncome_2"] : @"0.00";
        totalSACurAmt = [results stringForColumn:@"TotalSA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalSA_CurrentAmt"] : @"0.00";
        totalSAReqAmt = [results stringForColumn:@"TotalSA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalSA_RequiredAmt"] : @"0.00";
        totalSASurAmt = [results stringForColumn:@"TotalSA_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalSA_SurplusShortFall"] : @"0.00";
        totalCISACurAmt = [results stringForColumn:@"TotalCISA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalCISA_CurrentAmt"] : @"0.00";
        totalCISAReqAmt = [results stringForColumn:@"TotalCISA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalCISA_RequiredAmt"] : @"0.00";
        totalCISASurAmt = [results stringForColumn:@"TotalCISA_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalCISA_SurplusShortFall"] : @"0.00";
        totalHBCurAmt = [results stringForColumn:@"TotalHB_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalHB_CurrentAmt"] : @"0.00";
        totalHBReqAmt = [results stringForColumn:@"TotalHB_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalHB_RequiredAmt"] : @"0.00";
        totalHBSurAmt = [results stringForColumn:@"TotalHB_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalHB_SurplusShortFall"] : @"0.00";
        totalPACurAmt = [results stringForColumn:@"TotalPA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalPA_CurrentAmt"] : @"0.00";
        totalPAReqAmt = [results stringForColumn:@"TotalPA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalPA_RequiredAmt"] : @"0.00";
        totalPASurAmt = [results stringForColumn:@"TotalHB_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalHB_SurplusShortFall"] : @"0.00";
    }
    
    if (gotProtection) {
        NSDictionary *protectionInfo = @{@"NoExistingPlan" : hasProtection,
                                         @"AllocateIncome_1" : allocateIncome1,
                                         @"AllocateIncome_2" : allocateIncome2,
                                         @"TotalSA_CurAmt" : totalSACurAmt,
                                         @"TotalSA_ReqAmt" : totalSAReqAmt,
                                         @"TotalSA_SurAmt" : totalSASurAmt,
                                         @"TotalCISA_CurAmt" : totalCISACurAmt,
                                         @"TotalCISA_ReqAmt" : totalCISAReqAmt,
                                         @"TotalCISA_SurAmt" : totalCISASurAmt,
                                         @"TotalHB_CurAmt" : totalHBCurAmt,
                                         @"TotalHB_ReqAmt" : totalHBReqAmt,
                                         @"TotalHB_SurAmt" : totalHBSurAmt,
                                         @"TotalPA_CurAmt" : totalPACurAmt,
                                         @"TotalPA_ReqAmt" : totalPAReqAmt,
                                         @"TotalPA_SurAmt" : totalPASurAmt,
                                         };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionInfo forKey:@"eCFFProtectionInfo"];
    }

    //protection details
    results = Nil;
    int protectionCount;
    protectionCount = 0;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_Protection_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    else  {
        results = [database executeQuery:@"select * from eProposal_CFF_Protection_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    
    NSMutableArray *protectionsDetails = [NSMutableArray array];
    while ([results next]) {
        
        NSString *poName;
        NSString *company;
        NSString *planType;
        NSString *laName;
        NSString *benefit1;
        NSString *benefit2;
        NSString *benefit3;
        NSString *benefit4;
        NSString *premium;
        NSString *mode;
        NSString *maturityDate;
        
        protectionCount++;
        poName = [results stringForColumn:@"POName"];
        company = [results stringForColumn:@"CompanyName"];
        planType = [results stringForColumn:@"PlanType"];
        laName = [results stringForColumn:@"LifeAssuredName"];
        benefit1 = [results stringForColumn:@"Benefit1"];
        benefit2 = [results stringForColumn:@"Benefit2"];
        benefit3 = [results stringForColumn:@"Benefit3"];
        benefit4 = [results stringForColumn:@"Benefit4"];
        premium = [results stringForColumn:@"Premium"];
        mode = [results stringForColumn:@"Mode"];
        maturityDate = [results stringForColumn:@"MaturityDate"];
        
        NSDictionary *protectionDetails = @{[NSString stringWithFormat:@"ProtectionPlanInfo ID=\"%d\"", protectionCount] :
                                                @{@"POName":poName,
                                                  @"Company":company,
                                                  @"PlanType":planType,
                                                  @"LAName":laName,
                                                  @"Benefit1":benefit1,
                                                  @"Benefit2":benefit2,
                                                  @"Benefit3":benefit3,
                                                  @"Benefit4":benefit4,
                                                  @"Premium":premium,
                                                  @"Mode":mode,
                                                  @"MaturityDate":maturityDate,
                                                  },
                                            };
        [protectionsDetails addObject:protectionDetails];
    }
    
    if ([protectionsDetails count] > 0) {
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionsDetails forKey:@"eCFFProtectionDetails"];
    }
    
    //retirement info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    
    NSString *retirementAllocateIncome1;
    NSString *retirementAllocateIncome2;
    NSString *incomeSource1;
    NSString *incomeSource2;
    NSString *curAmt;
    NSString *reqAmt;
    NSString *surAmt;
    NSString *noExistingPlan=@"True";
    bool gotRetirementPlan = FALSE;
    while ([results next]) {
        gotRetirementPlan = TRUE;
        retirementAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"0.00";
        retirementAllocateIncome2 = [results stringForColumn:@"AllocateIncome_2"] != NULL ? [results stringForColumn:@"AllocateIncome_2"] : @"0.00";
        incomeSource1 = [results stringForColumn:@"OtherIncome_1"] != NULL ? [results stringForColumn:@"OtherIncome_1"] : @"";
        incomeSource2 = [results stringForColumn:@"OtherIncome_2"] != NULL ? [results stringForColumn:@"OtherIncome_2"] : @"";
        curAmt = [results stringForColumn:@"CurrentAmt"] != NULL ? [results stringForColumn:@"CurrentAmt"] : @"0.00";
        reqAmt = [results stringForColumn:@"RequiredAmt"] != NULL ? [results stringForColumn:@"RequiredAmt"] : @"";
        surAmt = [results stringForColumn:@"SurplusShortFallAmt"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt"] : @"";
        noExistingPlan = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
        if ([noExistingPlan isEqualToString:@"0"]) {
            noExistingPlan=@"False";
        }
    }
    
    if (gotRetirementPlan) {
        NSDictionary *retirementInfo = @{@"NoExistingPlan" : noExistingPlan,
                                         @"AllocateIncome_1" : retirementAllocateIncome1,
                                         @"AllocateIncome_2" : retirementAllocateIncome2,
                                         @"IncomeSource_1" : incomeSource1,
                                         @"IncomeSource_2" : incomeSource2,
                                         @"CurAmt" : curAmt,
                                         @"ReqAmt" : reqAmt,
                                         @"SurAmt" : surAmt
                                         };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementInfo forKey:@"eCFFRetirementInfo"];
    }
    
    results = Nil;
    int retirementCount;
    retirementCount = 0;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement_Details where CFFID = '%@' order by SeqNo asc",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement_Details where eProposalNo = '%@' order by SeqNo asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    NSMutableArray *retirementsDetails = [NSMutableArray array];
    while ([results next]) {
        retirementCount++;
        
        NSString *poName = [results stringForColumn:@"POName"];
        NSString *company = [results stringForColumn:@"CompanyName"];
        NSString *planType = [results stringForColumn:@"PlanType"];
        NSString *premium = [results stringForColumn:@"Premium"];
        NSString *frequency = [results stringForColumn:@"Frequency"];
        NSString *startDate = [results stringForColumn:@"StartDate"];
        NSString *endDate = [results stringForColumn:@"MaturityDate"];
        NSString *LSMaturityAmt = [results stringForColumn:@"ProjectedLumSum"];
        NSString *AIMaturityAmt = [results stringForColumn:@"ProjectedAnnualIncome"];
        NSString *benefits = [results stringForColumn:@"AdditionalBenefits"];
        
        NSDictionary *retirementDetails = @{[NSString stringWithFormat:@"RetirementPlanInfo ID=\"%d\"", retirementCount] :
        @{@"POName" : poName,
          @"Company" : company,
          @"PlanType" : planType,
          @"Premium" : premium,
          @"Frequency" : frequency,
          @"StartDate" : startDate,
          @"EndDate" : endDate,
          @"LSMaturityAmt" : LSMaturityAmt,
          @"AIMaturityAmt" : AIMaturityAmt,
          @"Benefits" : benefits,
          },
        };
        [retirementsDetails addObject:retirementDetails];
    }
    
    if ([retirementsDetails count] > 0) {
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementsDetails forKey:@"eCFFRetirementDetails"];
    }
    
    //education info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    
    NSString *educationAllocateIncome1;
    NSString *curAmtC1;
    NSString *reqAmtC1;
    NSString *surAmtC1;
    NSString *curAmtC2;
    NSString *reqAmtC2;
    NSString *surAmtC2;
    NSString *curAmtC3;
    NSString *reqAmtC3;
    NSString *surAmtC3;
    NSString *curAmtC4;
    NSString *reqAmtC4;
    NSString *surAmtC4;
    NSString *educationNoExistingPlan=@"True";
    bool gotEducation = FALSE;
    while ([results next]) {
        gotEducation = TRUE;
        educationAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"];
        curAmtC1 = [results stringForColumn:@"CurrentAmt_Child_1"];
        reqAmtC1 = [results stringForColumn:@"RequiredAmt_Child_1"];
        surAmtC1 = [results stringForColumn:@"SurplusShortFallAmt_Child_1"];
        curAmtC2 = [results stringForColumn:@"CurrentAmt_Child_2"];
        reqAmtC2 = [results stringForColumn:@"RequiredAmt_Child_2"];
        surAmtC2 = [results stringForColumn:@"SurplusShortFallAmt_Child_2"];
        curAmtC3 = [results stringForColumn:@"CurrentAmt_Child_3"];
        reqAmtC3 = [results stringForColumn:@"RequiredAmt_Child_3"];
        surAmtC3 = [results stringForColumn:@"SurplusShortFallAmt_Child_3"];
        curAmtC4 = [results stringForColumn:@"CurrentAmt_Child_4"];
        reqAmtC4 = [results stringForColumn:@"RequiredAmt_Child_4"];
        surAmtC4 = [results stringForColumn:@"SurplusShortFallAmt_Child_4"];
        educationNoExistingPlan = [results stringForColumn:@"NoExistingPlan"];
        if ([educationNoExistingPlan isEqualToString:@"0"]) {
            educationNoExistingPlan=@"False";
        }
    }
    
    if (gotEducation) {
        NSDictionary *educationInfo = @{@"NoExistingPlan" : educationNoExistingPlan,
                                        @"AllocateIncome_1" : educationAllocateIncome1,
                                        @"CurAmt_C1" : curAmtC1,
                                        @"ReqAmt_C1" : reqAmtC1,
                                        @"SurAmt_C1" : surAmtC1,
                                        @"CurAmt_C2" : curAmtC2,
                                        @"ReqAmt_C2" : reqAmtC2,
                                        @"SurAmt_C2" : surAmtC2,
                                        @"CurAmt_C3" : curAmtC3,
                                        @"ReqAmt_C3" : reqAmtC3,
                                        @"SurAmt_C3" : surAmtC3,
                                        @"CurAmt_C4" : curAmtC4,
                                        @"ReqAmt_C4" : reqAmtC4,
                                        @"SurAmt_C4" : surAmtC4,
                                        };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationInfo forKey:@"eCFFEducationInfo"];
    }
    
    //education details
    results = Nil;
    int educationCount;
    educationCount = 0;
    NSMutableArray *educationsDetails = [NSMutableArray array];
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education_Details where CFFID = '%@' order by SeqNo asc",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education_Details where eProposalNo = '%@' order by SeqNo asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    while ([results next]) {
        educationCount++;
        
        NSString *name = [results stringForColumn:@"Name"];
        NSString *company = [results stringForColumn:@"CompanyName"];
        NSString *premium = [results stringForColumn:@"Premium"];
        NSString *frequency = [results stringForColumn:@"Frequency"];
        NSString *startDate = [results stringForColumn:@"StartDate"];
        NSString *endDate = [results stringForColumn:@"MaturityDate"];
        NSString *maturityAmt = [results stringForColumn:@"ProjectedValueAtMaturity"];
        
        NSDictionary *educationDetails = @{[NSString stringWithFormat:@"EducPlanInfo ID=\"%d\"",educationCount] :
                                               @{@"Name" : name,
                                                 @"Company" : company,
                                                 @"Premium" : premium,
                                                 @"Frequency" : frequency,
                                                 @"StartDate" : startDate,
                                                 @"EndDate" : endDate,
                                                 @"MaturityAmt" : maturityAmt,
                                                 },

                                           };
        [educationsDetails addObject:educationDetails];
    }
    if ([educationsDetails count] > 0) {
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationsDetails forKey:@"eCFFEducationDetails"];
    }
    
    //savings info
    NSString *savingsAllocateIncome1;
    NSString *savingsCurAmt;
    NSString *savingsReqAmt;
    NSString *savingsSurAmt;
    NSString *savingsNoExistingPlan=@"True";
    bool gotSavings = FALSE;
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_SavingsInvest where CFFID = ?",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        gotSavings = TRUE;
        savingsAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"";
        savingsCurAmt = [results stringForColumn:@"CurrentAmt"] != NULL ? [results stringForColumn:@"CurrentAmt"] : @"";
        savingsReqAmt = [results stringForColumn:@"RequiredAmt"] != NULL ? [results stringForColumn:@"RequiredAmt"] : @"";
        savingsSurAmt = [results stringForColumn:@"SurplusShortFallAmt"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt"] : @"";
        savingsNoExistingPlan = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
        if ([savingsNoExistingPlan isEqualToString:@"0"]) {
            savingsNoExistingPlan=@"False";
        }
    }
    
    if (gotSavings) {
        NSDictionary *savingInfo = @{@"NoExistingPlan" : savingsNoExistingPlan,
                                     @"AllocateIncome_1" : savingsAllocateIncome1,
                                     @"CurAmt" : savingsCurAmt,
                                     @"ReqAmt" : savingsReqAmt,
                                     @"SurAmt" : savingsSurAmt,
                                     };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingInfo forKey:@"eCFFSavingInfo"];

    }
    
    //savings details
    results = Nil;
    int savingsCount;
    savingsCount = 0;
    NSMutableArray *savingsDetails = [NSMutableArray array];
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest_Details where CFFID = '%@' order by SeqNo asc",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest_Details where eProposalNo = '%@' order by SeqNo asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
    }
    
    while ([results next]) {
        savingsCount++;
        NSString *poName = [results stringForColumn:@"POName"] != NULL ? [results stringForColumn:@"POName"] : @"";
        NSString *company = [results stringForColumn:@"CompanyName"] != NULL ? [results stringForColumn:@"CompanyName"] : @"";
        NSString *type = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";
        NSString *purpose = [results stringForColumn:@"Purpose"] != NULL ? [results stringForColumn:@"Purpose"] : @"";
        NSString *premium = [results stringForColumn:@"Premium"] != NULL ? [results stringForColumn:@"Premium"] : @"";
        NSString *comDate = [results stringForColumn:@"CommDate"] != NULL ? [results stringForColumn:@"CommDate"] : @"";
        NSString *maturityAmt = [results stringForColumn:@"MaturityAmt"] != NULL ? [results stringForColumn:@"MaturityAmt"] : @"";
        NSDictionary *savingDetails = @{[NSString stringWithFormat:@"SavingPlanInfo ID=\"%d\"", savingsCount] :
                                            @{@"POName" : poName,
                                              @"Company" : company,
                                              @"Type" : type,
                                              @"Purpose" : purpose,
                                              @"Premium" : premium,
                                              @"ComDate" : comDate,
                                              @"MaturityAmt" : maturityAmt,
                                              }
                                        };
        [savingsDetails addObject:savingDetails];
    }
    
    if ([savingsDetails count] > 0) {
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingsDetails forKey:@"eCFFSavingsDetails"];
    }
    
    
    //section G
    NSString *gSameAsQuotation = @"";
    NSString *gPlanType = @"";
    NSString *gTerm = @"";
    NSString *gInsurerName = @"";
    NSString *gInsuredName = @"";
    NSString *gSA = @"";
    NSString *gReason = @"";
    NSString *gAction = @"";
    NSString *gRecoredOfAdviceBenefits = @"";
    
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '1'",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '1'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        gSameAsQuotation = @"1";
        gPlanType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";
        gTerm = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
        gInsurerName = @"Hong Leong Assurance Berhad";
        gInsuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
        gSA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
        gSA = [gSA stringByReplacingOccurrencesOfString:@"," withString:@""];
        gReason = [results stringForColumn:@"ReasonRecommend"] != NULL ? [results stringForColumn:@"ReasonRecommend"] : @"";
        gAction = [results stringForColumn:@"ActionRemark"] != NULL ? [results stringForColumn:@"ActionRemark"] : @"";
        
    }
    
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '1' order by Seq asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '1' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        gRecoredOfAdviceBenefits = [results stringForColumn:@"RiderName"] != NULL ? [results stringForColumn:@"RiderName"] : @"";
    }
    NSDictionary *recordOfAdviceP1 = @{@"Priority ID=\"1\"" :
                                         @{@"Seq" : @"1",
                                           @"SameAsQuotation" : gSameAsQuotation,
                                           @"PlanType" : gPlanType,
                                           @"Term" : gTerm,
                                           @"InsurerName" : gInsurerName,
                                           @"InsuredName" : gInsuredName,
                                           @"SA" : gSA,
                                           @"Reason" : gReason,
                                           @"Action" : gAction,
                                           @"RecordOfAdviceBenefits" : gRecoredOfAdviceBenefits
                                           }
                                     };
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recordOfAdviceP1 forKey:@"eCFFRecordOfAdviceP1"];
    
    NSString *g2SameAsQuotation = @"";
    NSString *g2PlanType = @"";
    NSString *g2Term = @"";
    NSString *g2InsurerName = @"";
    NSString *g2InsuredName = @"";
    NSString *g2SA = @"";
    NSString *g2Reason = @"";
    NSString *g2Action = @"";
    NSString *g2RecoredOfAdviceBenefits = @"";
    bool gotP2 = FALSE;
    results = nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '2'",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '2'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        gotP2 = TRUE;
        g2SameAsQuotation = @"1";
        g2PlanType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";
        g2Term = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
        g2InsurerName = @"Hong Leong Assurance Berhad";
        g2InsuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
        g2SA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
        g2SA = [g2SA stringByReplacingOccurrencesOfString:@"," withString:@""];
        g2Reason = [results stringForColumn:@"ReasonRecommend"] != NULL ? [results stringForColumn:@"ReasonRecommend"] : @"";
        g2Action = [results stringForColumn:@"ActionRemark"] != NULL ? [results stringForColumn:@"ActionRemark"] : @"";
        
    }
    
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '2' order by Seq asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '2' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        g2RecoredOfAdviceBenefits = [results stringForColumn:@"RiderName"] != NULL ? [results stringForColumn:@"RiderName"] : @"";
    }
    
    if (gotP2) {
        NSDictionary *recordOfAdviceP2 = @{@"Priority ID=\"2\"" :
                                               @{@"Seq" : @"2",
                                                 @"SameAsQuotation" : g2SameAsQuotation,
                                                 @"PlanType" : g2PlanType,
                                                 @"Term" : g2Term,
                                                 @"InsurerName" : g2InsurerName,
                                                 @"InsuredName" : g2InsuredName,
                                                 @"SA" : g2SA,
                                                 @"Reason" : g2Reason,
                                                 @"Action" : g2Action,
                                                 @"RecordOfAdviceBenefits" : g2RecoredOfAdviceBenefits
                                                 },
                                           };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recordOfAdviceP2 forKey:@"eCFFRecoredOfAdviceP2"];
    }
    
    //Section I
    NSString *choice1;
    NSString *choice2;
    NSString *choice3;
    NSString *choice4;
    NSString *choice5;
    NSString *choice6;
    NSString *choice6Desc;
    
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_CA where CFFID = ?",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    
    while ([results next]) {
        choice1 = [results stringForColumn:@"Choice1"] != NULL ? [results stringForColumn:@"Choice1"] : @"";
        choice2 = [results stringForColumn:@"Choice2"] != NULL ? [results stringForColumn:@"Choice2"] : @"";
        choice3 = [results stringForColumn:@"Choice3"] != NULL ? [results stringForColumn:@"Choice3"] : @"";
      choice5 = [results stringForColumn:@"Choice5"] != NULL ? [results stringForColumn:@"Choice5"] : @"";
        choice6 = [results stringForColumn:@"Choice6"] != NULL ? [results stringForColumn:@"Choice6"] : @"";
        choice6Desc = [results stringForColumn:@"Choices6Desc"] != NULL ? [results stringForColumn:@"Choices6Desc"] : @"";
    }
    
    NSDictionary *confirmationOfAdviceGivenTo = @{@"Choice1" : ![choice1 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice2" : ![choice2 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice3" : ![choice3 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice4" : ![choice4 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice5" : ![choice5 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice6" : ![choice6 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                  @"Choice6_desc" : choice6Desc,
                                                  };
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:confirmationOfAdviceGivenTo forKey:@"eCFFConfirmationAdviceGivenTo"];
    
    results = Nil;
    int recommendCount;
    recommendCount = 0;
    NSMutableArray *recommendedProducts = [NSMutableArray array];
    NSString *siNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    NSString *insuredName;
    NSString *planType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
    NSString *term;
    NSString *premium;
    NSString *frequency = @"12";
    NSString *SA;
    NSString *boughtOption = @"Y";
    NSString *addNew = @"";
    NSString *additionalBenefits = @"";
    if ([planType isEqualToString:@"HLACP"] || [planType isEqualToString:@"L100"] || [planType isEqualToString:@"HLAWP"]) {
        results = [database executeQuery:@"select b.name from Trad_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.sequence = '1'", siNo, Nil];
        while ([results next]) {
            insuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
        }
        
        results = Nil;
        results = [database executeQuery:@"select PolicyTerm, BasicSA from Trad_Details where SINo = ?", siNo];
        while ([results next]) {
            term = [results stringForColumn:@"PolicyTerm"] != NULL ? [results stringForColumn:@"PolicyTerm"] : @"";
            SA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
        }
        
        results = Nil;
        results = [database executeQuery:@"select Annually from SI_Store_premium where SINo = ? and Type = 'B'", siNo, Nil];
        while ([results next]) {
            premium = [results stringForColumn:@"Annually"] != NULL ? [results stringForColumn:@"Annually"] : @"";
        }
        
        results = Nil;
        results = [database executeQuery:@"select riderCode from Trad_Rider_Details where SINo = ?", siNo, Nil];
        while ([results next]) {
            additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
        }
        
        NSDictionary *productRecommended = @{[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"", 1] :
                                                 @{@"Seq" : [NSString stringWithFormat:@"%d", 1],
                                                   @"InsuredName" : insuredName,
                                                   @"PlanType" : planType,
                                                   @"Term" : term,
                                                   @"Premium" : premium,
                                                   @"Frequency" : frequency,
                                                   @"SA" : SA,
                                                   @"BoughtOpt" : boughtOption,
                                                   @"AddNew" : addNew,
                                                   @"AdditionalBenefits" : additionalBenefits,
                                                   }
                                             };
        [recommendedProducts addObject:productRecommended];
    }
    else if ([planType isEqualToString:@"UV"] || [planType isEqualToString:@"UP"]) {
        results = [database executeQuery:@"select b.name from UL_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.seq = '1'", siNo, Nil];
        while ([results next]) {
            insuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
        }
        
        results = Nil;
        results = [database executeQuery:@"select ATPrem, BasicSA, CovPeriod from UL_Details where SINo = ?", siNo];
        while ([results next]) {
            term = [results stringForColumn:@"CovPeriod"] != NULL ? [results stringForColumn:@"CovPeriod"] : @"";
            SA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
            premium = [results stringForColumn:@"ATPrem"] != NULL ? [results stringForColumn:@"ATPrem"] : @"";
        }
        
        results = Nil;
        results = [database executeQuery:@"select riderCode from UL_Rider_Details where SINo = ?", siNo, Nil];
        while ([results next]) {
            additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
        }
        
        NSDictionary *productRecommended = @{[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"", 1] :
                                                 @{@"Seq" : [NSString stringWithFormat:@"%d", 1],
                                                   @"InsuredName" : insuredName,
                                                   @"PlanType" : planType,
                                                   @"Term" : term,
                                                   @"Premium" : premium,
                                                   @"Frequency" : frequency,
                                                   @"SA" : SA,
                                                   @"BoughtOpt" : boughtOption,
                                                   @"AddNew" : addNew,
                                                   @"AdditionalBenefits" : additionalBenefits,
                                                   }
                                             };
        [recommendedProducts addObject:productRecommended];

    }
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_CA_Recommendation where CFFID = ? order by Seq asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation where eProposalNo = ? order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
    }
    while ([results next]) {
        recommendCount++;
        NSString *insuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
        NSString *planType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] :@"";
        NSString *term = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
        NSString *premium = [results stringForColumn:@"Premium"] != NULL ? [results stringForColumn:@"Premium"] : @"";
        NSString *frequency = [results stringForColumn:@"Frequency"] != NULL ? [results stringForColumn:@"Frequency"] : @"";
        NSString *SA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
        NSString *boughtOption = [results stringForColumn:@"BoughtOption"] != NULL ? [results stringForColumn:@"BoughtOption"] : @"";
        NSString *addNew = [results stringForColumn:@"AddNew"] != NULL ? [results stringForColumn:@"AddNew"] : @"";
        NSString *additionalBenefits = [results stringForColumn:@"AddNew"] != NULL ? [results stringForColumn:@"AddNew"] : @"";
        NSDictionary *productRecommended = @{[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"", recommendCount] :
                                                 @{@"Seq" : [NSString stringWithFormat:@"%d", recommendCount],
                                                   @"InsuredName" : insuredName,
                                                   @"PlanType" : planType,
                                                   @"Term" : term,
                                                   @"Premium" : premium,
                                                   @"Frequency" : frequency,
                                                   @"SA" : SA,
                                                   @"BoughtOpt" : boughtOption,
                                                   @"AddNew" : addNew,
                                                   @"AdditionalBenefits" : additionalBenefits,
                                                   }
                                             };
        [recommendedProducts addObject:productRecommended];
    }
    
    if ([recommendedProducts count] > 0) {
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recommendedProducts forKey:@"eCFFRecommendedProducts"];
    }
}

#pragma mark - SearchBar Delegate Method/s


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searching:searchText];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self searching:searchBar.text];
}

-(void)searching:(NSString *)searchText {
    
    NSString *sqlQuery;
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
	NSLog(@"searchText: %@", searchText);
	
	if ([searchText isEqualToString: @""]){
		searchText = poName;	//set searching like first time load
	}
	
    if ([searchText rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        // consists only of the digits 0 through 9
        // means search for identification number
      sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo LIKE \"%%%@%%\" OR OtherIDTypeNO LIKE \"%%%@%%\" AND QQFlag = 'false' ORDER BY ProspectName ASC",searchText,searchText];
        
        
       // FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo LIKE \"%%%@%%\" OR OtherIDTypeNO LIKE \"%%%@%%\" AND QQFlag = 'false' ORDER BY ProspectName ASC", searchText, searchText, searchText]];

    }
    else {
        // search for name
        //sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE ProspectName LIKE \"%%%@%%\" ", searchText];
        
        sqlQuery = [[NSString alloc] initWithFormat:@"SELECT * FROM prospect_profile WHERE IDTypeNo LIKE \"%%%@%%\" OR OtherIDTypeNO LIKE \"%%%@%%\" OR ProspectName LIKE \"%%%@%%\" ORDER BY ProspectName ASC",searchText,searchText,searchText];
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
    [clientOtherID removeAllObjects];
    
    
    clientData = [[NSMutableArray alloc] init];
    arrName = [[NSMutableArray alloc] init];
    arrCFFID = [[NSMutableArray alloc] init];
    arrIdNo = [[NSMutableArray alloc] init];
    arrStatus = [[NSMutableArray alloc] init];	
    arrDate = [[NSMutableArray alloc] init];
    arrClientProfileID = [[NSMutableArray alloc] init];
    clientOtherID = [NSMutableArray array];
    
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
    [clientData addObject:clientOtherID];
    
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
            [clientOtherID addObject:[results1 stringForColumn:@"OtherIDTypeNo"]];
        }
        
        
        [arrDate addObject:[results stringForColumn:@"LastUpdatedAt"]];
        //[arrStatus addObject:[results stringForColumn:@"Status"]];
		NSString *cffStatus = [results stringForColumn:@"Status"];
		NSLog(@"status: %@",cffStatus);
		if ([cffStatus isEqualToString:@"1"]) {
			[arrStatus addObject: @"Completed"];
		}
		else {
			[arrStatus addObject: @"Incomplete"];
		}
        [arrCFFID addObject:[results stringForColumn:@"ID"]];
        [arrClientProfileID addObject:[results stringForColumn:@"ClientProfileID"]];
        
        [clientData addObject:arrName];
        [clientData addObject:arrIdNo];
        [clientData addObject:arrDate];
        [clientData addObject:arrStatus];
        [clientData addObject:arrCFFID];
        [clientData addObject:arrClientProfileID];
        [clientData addObject:clientOtherID];
        
        //[arr addObject:[results1 stringForColumn:@"ProspectName"]];
        
        
    }
    [database close];
    [self.myTableView reloadData];
}

-(NSString*) getCountryCode : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"CountryCode"];
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getCountryDesc : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        count = count + 1;
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getStateCode : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateCode FROM eProposal_State WHERE StateDesc = ?", state];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"StateCode"];
    }
    
	if (count == 0){
		code = state;
	}
	
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getStateDesc : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *desc;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_State WHERE StateCode = ?", state];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"StateDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = state;
	}
    
    return desc;
    
}

-(NSString*) getRelationshipCode : (NSString*)relationship
{
	if ([relationship isEqualToString:@""] || (relationship == NULL) || ([relationship isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    relationship = [relationship stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT RelCode FROM eProposal_Relation WHERE RelDesc = ?", relationship];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"RelCode"];
    }
    
	//if (code == NULL)
	//code = @"";
	if (count == 0)
		code = relationship;
	
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getRelationshipDesc : (NSString*)relationship
{
	if ([relationship isEqualToString:@""] || (relationship == NULL) || ([relationship isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *desc;
    relationship = [relationship stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT RelDesc FROM eProposal_Relation WHERE RelCode = ?", relationship];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"RelDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = relationship;
	}
    
    return desc;
    
}


@end
