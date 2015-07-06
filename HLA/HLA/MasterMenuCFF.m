//
//  MasterMenuCFF.m
//  iMobile Planner
//
//  Created for test on 6/28/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MasterMenuCFF.h"
#import "DataClass.h"
#import "textFields.h"
#import "Utility.h"
#import "DataClass.h"
#import "FNAProtection.h"
#import "FNAEducation.h"
#import "FNARetirement.h"
#import "FNASavings.h"
#import "UIAlertView+Blocks.h"

@interface MasterMenuCFF (){
    NSString *alertMsg;
    DataClass *obj;
    NSString *tableNamePrefix;
    NSMutableArray *alertStack;
    NSIndexPath *specialIndex;
    //int fistLoad;
    NSString *secFPass;
    bool eAppIsUpdate;
	BOOL pressSaveAll;
	BOOL hasConfirmed;
	BOOL hasPOSign;
	BOOL hasFailed;
	BOOL hasReceived;
	BOOL checkedSecF;
    // int lastId;
    // NSString *commDate;
	sqlite3 *contactDB;
    
    BOOL checkEappAlertDone;
	BOOL noAlert;
    
    BOOL RecordSavedAlert;
    BOOL RecordSavedAlertGen;
    BOOL RcrdSvForCFF;
    BOOL ChangesMade;
	int toCheck1;
	int toCheck2;
	int toCheck3;
	int toCheck4;
    NSCondition*  condition;
    
    int mainresult;
}

@end

@implementation MasterMenuCFF

int firstLoad = 0;

@synthesize DisclosureVC = _DisclosureVC;
@synthesize CustomerVC = _CustomerVC;
@synthesize CustomerDataVC = _CustomerDataVC;
@synthesize PotentialVC = _PotentialVC;
@synthesize PreferenceVC = _PreferenceVC;
@synthesize FinancialVC = _FinancialVC;
@synthesize FNAProtectionVC = _FNAProtectionVC;
@synthesize FNARetirementVC = _FNARetirementVC;
@synthesize FNAEducationVC = _FNAEducationVC;
@synthesize FNASavingsVC = _FNASavingsVC;


@synthesize RetirementVC = _RetirementVC;
@synthesize RecordVC = _RecordVC;
@synthesize DeclareCFFVC = _DeclareCFFVC;
@synthesize ConfirmCFFVC = _ConfirmCFFVC;
@synthesize ListOfSubMenu,myTableView,RightView,FromStandalone,FromEap;

@synthesize eApp;

int SecFEnable = 0;			//ENS Enable = 1, disable = 0


-(void)createAction:(id)sender {
    //[self removeFromSuperView];
    [self doDone:nil];
}

-(void)deleteAction:(id)sender {
    UIAlertView *alert;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    NSString *CFFID = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
    //    FMResultSet *result = [db executeQuery:@"select * from eProposal_CFF_Master where ID = ?", CFFID];
	FMResultSet *result = [db executeQuery:@"SELECT * FROM eProposal_CFF_Master as A, eApp_listing as B where A.eProposalNo = B.ProposalNo AND A.ID = ? and B.status in (2,3)", CFFID];
	
    if ([result next]) {
        alert = [[UIAlertView alloc]
                 initWithTitle: NSLocalizedString(@" ",nil)
                 message: NSLocalizedString(@"There are pending eApp cases for this client. Should you wish to proceed, system will auto-delete all the pending eApp cases and you are required to recreate the eApps case should you wish to submit for the same client",nil)
                 delegate: self
                 cancelButtonTitle: NSLocalizedString(@"No",nil)
                 otherButtonTitles: NSLocalizedString(@"Yes",nil), nil];
    }
    else {
        alert = [[UIAlertView alloc]
                 initWithTitle: NSLocalizedString(@" ",nil)
                 message: NSLocalizedString(@"Are you sure you want to delete this CFF?",nil)
                 delegate: self
                 cancelButtonTitle: NSLocalizedString(@"No",nil)
                 otherButtonTitles: NSLocalizedString(@"Yes",nil), nil];
    }
    [result close];
    [db close];
    
    alert.tag = 444;
    [alert show];
    alert = nil;
}

-(void)listingAction:(id)sender {
    [self doCancel:nil];
}

-(void)eAppChecklistAction:(id)sender {
	if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFSave"] isEqualToString:@"1"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"Do you want to save?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        [alert setTag:8888];
        [alert show];
        alert = Nil;
        
        //[Utility showAllert:@"Please save."];
    }
    else{
        specialIndex = NULL;
        [self validSecHSpecial:NULL];
        //[self dismissViewControllerAnimated:TRUE completion:nil];
    }
	
    //[self dismissViewControllerAnimated:TRUE completion:nil];
}
-(void)eAppDoneAction:(id)sender {
    //[self saveCreateCFF:0];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *CFFID = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
    //    NSString *ProspectName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
	NSString *ProspectName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectName"];
    NSString *poICNO=[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POIC"];
    NSString *poOtherID=[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POOtherID"];
    NSString *poOtherIDType=[[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
    if([poICNO isEqualToString:@"(null)"])
        poICNO = @"";
    if([poOtherID isEqualToString:@"(null)"])
        poOtherID = @"";
    if([poOtherIDType isEqualToString:@"(null)"])
        poOtherIDType = @"";
    bool related = FALSE;
    bool ownCFF = FALSE;
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    //  NSString *sql1 = [NSString stringWithFormat:@"select count(*) as count from CFF_Personal_Details where Name = '%@' and (NewICNo = '%@' or (OtherIDType = '%@' AND OtherID = '%@')",ProspectName,poICNO,poOtherID,poOtherIDType, nil];
    NSString *sql1 = [NSString stringWithFormat:@"select count(*) as count from CFF_Personal_Details where CFFID = '%@' and (NewICNo = '%@' or (OtherIDType = '%@' AND OtherID = '%@') or Name = '%@') ", CFFID,poICNO,poOtherID,poOtherIDType,ProspectName,nil];
    //NSLog(@"CFFPD SQL: %@", sql1);
    FMResultSet *results1 = [database executeQuery:sql1];
    while ([results1 next]) {
        if ([results1 intForColumn:@"count"] != 0) {
            ownCFF = TRUE;
            related = TRUE;
        }
        
    }
    if (ownCFF == FALSE) {
        NSString *sql2 = [NSString stringWithFormat:@"select * from eProposal_CFF_Family_Details where Name = '%@' and CFFID = '%@'", ProspectName, CFFID, nil];
        //NSLog(@"CFFPD22 SQL: %@", sql2);
        FMResultSet *results = [database executeQuery:sql2];
        
        int testcount = 0;
        while ([results next]) {
            //			//testcount = [results intForColumn:@"count"];
            //			NSLog(@"count %d", testcount);
            //            if (testcount > 0) {
            //                related = TRUE;
            //
            //			}
            //			else {
            //                related = FALSE;
            //			}
			testcount = testcount + 1;
        }
        
        if (testcount>0){
            related = TRUE;
        }
        else {
            related = FALSE;
        }
        
    }
    else{
        
        related = TRUE;
	}
    
    [database close];
	ClearData *ClData =[[ClearData alloc]init];
	[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

	
	//change as related, if add PO as in customer personal data :Emi 05/07/2014
	if (!related) {
        if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]])
            related = TRUE;
        else if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]])
            related = TRUE;
        else if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"]])
            related = TRUE;
        else if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"]])
            related = TRUE;
        else if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"]])
            related = TRUE;
        else if ([ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"]])
            related = TRUE;
	}
	
	//remove related if user remove relation/delete PO in relation
	if (!ownCFF && related) {
		if ((![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"]]) && (![ProspectName isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"]]))
			related = FALSE;
	}
	
	
    if(!related) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Policy Owner must appear in CFF (either in Customer, Partner/Spouse or Children and Dependents’ column)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    if ([self doDoneEApp]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle: @" "
                              
                              message:@"CFF selected successfully."
                              
                              delegate: self
                              
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 999;
        
        [alert show];
        alert = Nil;
    }
    
}

-(void)functionDelete :(NSString *)delete1
{
    FromStandalone = @"deleteAll";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkedSecF = TRUE;
    ChangesMade = YES;
    RecordSavedAlert = YES;
    RecordSavedAlertGen = YES;
    RcrdSvForCFF = YES;
    alertMsg = @"New CFF created sucessfully";
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    self.myTableView.scrollEnabled = NO;
	
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Disclosure of\nIntermediary Status", @"Customer's Choice", @"Customer's Personal Data", @"Potential Areas for\nDiscussion", @"Preference", @"Financial Needs Analysis", @"Record of Advice", @"Declaration and\nAcknowledgement", @"Confirmation of Advice\nGiven to", nil ];
    myTableView.rowHeight = 57;
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    if (!eApp) {
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete CFF" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
        
        UIBarButtonItem *listingButton = [[UIBarButtonItem alloc] initWithTitle:@"CFF Listing"
                                                                          style:UIBarButtonItemStyleDone target:self action:@selector(listingAction:)];
        
        UIBarButtonItem *createNewBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save All" style:UIBarButtonItemStyleDone target:self action:@selector(createAction:)];
        
        
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:listingButton, nil];
        
        
        if ([_fLoad isEqualToString:@"1"])
            item.leftBarButtonItems = myButtonArray;
        else if ([_fLoad isEqualToString:@"0"]){
            item.leftBarButtonItem = listingButton;
        }
        
        
        
        item.rightBarButtonItem = createNewBtn;
        item.hidesBackButton = YES;
        [_myBar pushNavigationItem:item animated:NO];
        
        tableNamePrefix = @"";
		[[obj.CFFData objectForKey:@"CFF"] setValue:@"N" forKey:@"isEAPP"];
    }
    else {
        UIBarButtonItem *checklistButton = [[UIBarButtonItem alloc] initWithTitle:@"e-Application Checklist"
                                                                            style:UIBarButtonItemStyleDone target:self action:@selector(eAppChecklistAction:)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(eAppDoneAction:)];
        item.leftBarButtonItem = checklistButton;
        item.rightBarButtonItem = doneButton;
        [_myBar pushNavigationItem:item animated:NO];
        
        tableNamePrefix = @"eProposal_";
        
		obj=[DataClass getInstance];
		NSString *proposalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProposalStatus"];
		
		if ([proposalStatus isEqualToString:@"Confirmed"] || [proposalStatus isEqualToString:@"3"]) {
			doneButton.enabled = FALSE;
		}
        
        [self loadDBData];
		[[obj.CFFData objectForKey:@"CFF"] setValue:@"Y" forKey:@"isEAPP"];
    }
    
    //self.navigationItem.rightBarButtonItems = myButtonArray;
    
    
    //selectedPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //[self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    /*
     UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
     
     
     self.CustomerDataVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustDetailsView"];
     //self.CustomerDataVC.wantsFullScreenLayout = FALSE;
     //self.RightView.frame = CGRectMake(0, 10, 0, 20)
     [self addChildViewController:self.CustomerDataVC];
     [self.RightView addSubview:self.CustomerDataVC.view];
     //self.RightView.frame = CGRectMake(self.RightView.frame.origin.x, self.RightView.frame.origin.y, self.RightView.frame.size.width - 200, self.RightView.frame.size.height);
     
     //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
     //[myTableView.delegate tableView:myTableView didSelectRowAtIndexPath:indexPath];
     */
    //[myTableView reloadData];
    
    obj=[DataClass getInstance];
	
	//**ENS
    if ([textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientName"]] == NULL) {
		//*ENS Note: From eAppChecklist
		_CFFTitle.text = [NSString stringWithFormat:@"%@%@%@", _CFFTitle.text, @" for ", [textFields trimWhiteSpaces:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"]]];
	}
	else {
		//*ENS Note: From SelectCFF
		_CFFTitle.text = [NSString stringWithFormat:@"%@%@%@", _CFFTitle.text, @" for ", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientName"]]];
	}
    
    //_SecFViewTab.backgroundColor =
    //[_SecFViewTab setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    alertStack = [NSMutableArray array];
    
}


#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return ListOfSubMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //select the 2nd row
    //if (firstLoad == 0){
    /*if ([_fLoad isEqualToString:@"0"]){
     NSIndexPath *indexPathq = [NSIndexPath indexPathForRow:1 inSection:0];
     [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPathq];
     [self.myTableView selectRowAtIndexPath:indexPathq animated:NO scrollPosition:UITableViewScrollPositionNone];
     selectedPath = indexPathq;
     }
     else if ([_fLoad isEqualToString:@"1"]){*/
    NSIndexPath *indexPathq = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPathq];
    [self.myTableView selectRowAtIndexPath:indexPathq animated:NO scrollPosition:UITableViewScrollPositionNone];
    selectedPath = indexPathq;
    //}
    
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil || indexPath.row == 7) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.tag = indexPath.row;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imgIcon2;
    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    imgIcon2.hidden = true;
    //imgIcon2.tag = 3000+indexPath.row;
    //if (indexPath.row == 0){
    //    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    //}
    //else{
    //    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
    //}
    imgIcon2.frame = CGRectMake(230, 22, 16, 16);
    imgIcon2.tag = 3000+indexPath.row;
    [cell.contentView addSubview:imgIcon2];
    if (indexPath.row == 0){
        if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            if ([_fLoad isEqualToString:@"0"]){
                imgIcon2.hidden = TRUE;
            }
            else {
                imgIcon2.hidden = false;
            }
        }
    }
    else if (indexPath.row == 1){
        if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 2){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 3){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 4){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        if ([[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 5){
        
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"])
        {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        
        if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"])
        {
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
			SecFEnable = 0;
            
            FNAProtection *viewController = [[FNAProtection alloc]init];
            [viewController ActionEventForButton1];
            
            FNAEducation *viewController1 = [[FNAEducation alloc]init];
            [viewController1 ActionEventForButton1];
            
            FNARetirement *viewController2 = [[FNARetirement alloc]init];
            [viewController2 ActionEventForButton1];
            
            FNASavings *viewController3 = [[FNASavings alloc]init];
            [viewController3 ActionEventForButton1];
            
        }
        
        
        
        //else if (!self.CustomerVC.checkboxButton3.selected && !self.CustomerVC.checkboxButton2.selected && !self.CustomerVC.checkboxButton1.selected){
        //    cell.textLabel.textColor = [UIColor grayColor];
        //    cell.userInteractionEnabled = NO;
        //NSLog(@"RRR%d",self.CustomerVC.checkboxButton3.selected);
        //}
        
        
        
        
        
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.userInteractionEnabled = YES;
            SecFEnable = 1;
            /*
             MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
             UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
             cell.textLabel.textColor = [UIColor grayColor];
             cell.userInteractionEnabled = NO;
             parent = nil;
             */
            //NSLog(@"QQQ%d",self.CustomerVC.checkboxButton3.selected);
        }
        //else{
        //    cell.textLabel.textColor = [UIColor grayColor];
        //    cell.userInteractionEnabled = NO;
        //}
        
        
        //[[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
        
        
        /*if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
         if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
         cell.textLabel.textColor = [UIColor whiteColor];
         cell.userInteractionEnabled = YES;
         }
         else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
         cell.textLabel.textColor = [UIColor whiteColor];
         cell.userInteractionEnabled = YES;
         }
         else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
         cell.textLabel.textColor = [UIColor grayColor];
         cell.userInteractionEnabled = NO;
         }
         
         }*/
        
    }
    else if (indexPath.row == 6){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 7){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
        else {
            imgIcon2.hidden = TRUE;
        }
    }
    else if (indexPath.row == 8){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            //cell.textLabel.textColor = [UIColor grayColor];
            //cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	pressSaveAll = FALSE;
    [self.view endEditing:YES];
    
    selectedPath = indexPath;
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    if (indexPath.row == 0)     //disclosure
    {
        //firstLoad = 1;
        self.RightView.hidden = FALSE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.RightView.subviews containsObject:self.DisclosureVC.view];
        if (!doesContain){
            self.DisclosureVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DisclosureView2"];
            [self addChildViewController:self.DisclosureVC];
            [self.RightView addSubview:self.DisclosureVC.view];
            
        }
    }
    
    else if (indexPath.row == 1)     //customer choice
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = FALSE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecB" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecBView.subviews containsObject:self.CustomerVC.view];
        if (!doesContain){
            self.CustomerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerChoiceView"];
            [self addChildViewController:self.CustomerVC];
            [self.SecBView addSubview:self.CustomerVC.view];
        }
    }
    
    else if (indexPath.row == 2)     //customer data
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = FALSE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecC" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecCView.subviews containsObject:self.CustomerDataVC.view];
        if (!doesContain){
            self.CustomerDataVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustDetailsView"];
            [self addChildViewController:self.CustomerDataVC];
            [self.SecCView addSubview:self.CustomerDataVC.view];
        }
    }
    
    else if (indexPath.row == 3)     //potential area
    {
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"]);
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = FALSE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecD" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecDView.subviews containsObject:self.PotentialVC.view];
        if (!doesContain){
            self.PotentialVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PotentialAreasView"];
            [self addChildViewController:self.PotentialVC];
            [self.SecDView addSubview:self.PotentialVC.view];
        }
    }
    
    else if (indexPath.row == 4)     //preference
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = FALSE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecE" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecEView.subviews containsObject:self.PreferenceVC.view];
        if (!doesContain){
            self.PreferenceVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PreferenceView"];
            [self addChildViewController:self.PreferenceVC];
            [self.SecEView addSubview:self.PreferenceVC.view];
        }
    }
    
    else if (indexPath.row == 5 && ![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"])     //financial analysis
    {
        /*if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete Potential Areas for Discussion before proceeding." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag = 3002;
         [alert show];
         alert = nil;
         return;
         }*/
		
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;//this one
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
        
        
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        
        
        _secFTab.selectedSegmentIndex = 0;
        
        UIFont *font = [UIFont systemFontOfSize:16.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:UITextAttributeFont];
        [_secFTab setTitleTextAttributes:attributes
                                forState:UIControlStateNormal];
        
        [_secFTab setTitle:@"Protection" forSegmentAtIndex:0];
        [_secFTab setTitle:@"Retirement" forSegmentAtIndex:1];
        [_secFTab setTitle:@"Education Cost Planning" forSegmentAtIndex:2];
        [_secFTab setTitle:@"Savings & Investment Plan" forSegmentAtIndex:3];
        
        
        int priority1 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] intValue];
        int priority2 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] intValue];
        int priority3 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] intValue];
        int priority4 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] intValue];
        int priority5 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] intValue];
        
        if (priority4-priority5 <= -1 && priority4 != 0) {
            if (priority1 > priority5) {
                priority1-=1;
            }
            if (priority2 > priority5) {
                priority2-=1;
            }
            if (priority3 > priority5) {
                priority3-=1;
            }
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority4] forSegmentAtIndex:3];
        }
        else if (priority4-priority5 >= 1 && priority5 != 0) {
            if (priority1 > priority4) {
                priority1-=1;
            }
            if (priority2 > priority4) {
                priority2-=1;
            }
            if (priority3 > priority4) {
                priority3-=1;
            }
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority5] forSegmentAtIndex:3];
        }
        
        if (priority1 != 0) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Protection (%d)", priority1] forSegmentAtIndex:0];
        }
        if (priority2 != 0) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Retirement (%d)", priority2] forSegmentAtIndex:1];
        }
        if (priority3 != 0) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Education Cost Planning (%d)", priority3] forSegmentAtIndex:2];
        }
        if (priority4 == 0 && priority5 != 0) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority5] forSegmentAtIndex:3];
        }
        else if (priority5 == 0 && priority4 != 0) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority4] forSegmentAtIndex:3];
        }
        else if (priority4 < priority5) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority4] forSegmentAtIndex:3];
        }
        else if (priority4 > priority5) {
            [_secFTab setTitle:[NSString stringWithFormat:@"Savings & Investment Plan (%d)", priority5] forSegmentAtIndex:3];
        }
        
        [_secFTab setWidth:120.0 forSegmentAtIndex:0];
        [_secFTab setWidth:130.0 forSegmentAtIndex:1];
        //tab protection start
        /*if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] isEqualToString:@""] && [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"]){
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Protection (4)" forSegmentAtIndex:0];
         }
         else{
         [_secFTab setTitle:[NSString stringWithFormat:@"Protection (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"]] forSegmentAtIndex:0];
         }
         }
         else{
         [_secFTab setTitle:@"Protection" forSegmentAtIndex:0];
         }
         //tab protection end
         
         //tab retirement start
         if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] isEqualToString:@""] && [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"]){
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Retirement (4)" forSegmentAtIndex:1];
         }
         else{
         [_secFTab setTitle:[NSString stringWithFormat:@"Retirement (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"]] forSegmentAtIndex:1];
         }
         }
         else{
         [_secFTab setTitle:@"Retirement" forSegmentAtIndex:1];
         }
         //tab retirement end
         
         //tab education start
         if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@""] && [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"]){
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Education (4)" forSegmentAtIndex:2];
         }
         else{
         [_secFTab setTitle:[NSString stringWithFormat:@"Education (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"]] forSegmentAtIndex:2];
         }
         }
         else{
         [_secFTab setTitle:@"Education" forSegmentAtIndex:2];
         }
         //tab education end
         
         //tab savings (savings) start
         if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] isEqualToString:@""] && [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"]){
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Savings (4)" forSegmentAtIndex:3];
         }
         else{
         [_secFTab setTitle:[NSString stringWithFormat:@"Savings (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"]] forSegmentAtIndex:3];
         }
         }
         else{
         [_secFTab setTitle:@"Savings" forSegmentAtIndex:3];
         }
         //tab savings (savings) end
         
         //tab savings (investment) start
         if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] isEqualToString:@""] && [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"]){
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Savings (4)" forSegmentAtIndex:3];
         }
         else{
         [_secFTab setTitle:[NSString stringWithFormat:@"Savings (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"]] forSegmentAtIndex:3];
         }
         }
         else{
         [_secFTab setTitle:@"Savings" forSegmentAtIndex:3];
         }
         //tab savings (investment) end
         */
        
        
        /*
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"1"]){
         [_secFTab setTitle:@"Protection (1)" forSegmentAtIndex:0];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"2"]){
         [_secFTab setTitle:@"Retirement (1)" forSegmentAtIndex:1];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"3"]){
         [_secFTab setTitle:@"Education (1)" forSegmentAtIndex:2];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"4"]){
         [_secFTab setTitle:@"Savings (1)" forSegmentAtIndex:3];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Savings (1)" forSegmentAtIndex:3];
         }
         */
        
        //[segmentedControl setTitle:<YourLocalizedString> forSegmentAtIndex:0];
        
        
        //BOOL doesContain = [self.SecFViewProtection.subviews containsObject:self.FNAProtectionVC.view];
        //if (!doesContain){
        self.FNAProtectionVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialProtectionView"];
        [self addChildViewController:self.FNAProtectionVC];
        [self.SecFViewProtection addSubview:self.FNAProtectionVC.view];
        //}
        //else{
        //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        //}
        
        //        BOOL doesContainRetirement = [self.SecFViewRetirement.subviews containsObject:self.FNARetirementVC.view];
        //        if (!doesContainRetirement){
        self.FNARetirementVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialRetirementView"];
        [self addChildViewController:self.FNARetirementVC];
        [self.SecFViewRetirement addSubview:self.FNARetirementVC.view];
        //        }
        
        //        BOOL doesContainEducation = [self.SecFViewEducation.subviews containsObject:self.FNAEducationVC.view];
        //        if (!doesContainEducation){
        self.FNAEducationVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialEducationView"];
        [self addChildViewController:self.FNAEducationVC];
        [self.SecFViewEducation addSubview:self.FNAEducationVC.view];
        //        }
        //        else {
        [self.FNAEducationVC.myTableView reloadData];
        //        }
        
        if (_FNAEducationVC.hasChildren == FALSE && [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]) {
            NSLog(@"DidSelect F Hack");
            [_FNAEducationVC hasChildBtn:_FNAEducationVC.hasChild];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
        }
        
        //        BOOL doesContainSavings = [self.SecFViewSavings.subviews containsObject:self.FNASavingsVC.view];
        //        if (!doesContainSavings){
        self.FNASavingsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialSavingsView"];
        [self addChildViewController:self.FNASavingsVC];
        [self.SecFViewSavings addSubview:self.FNASavingsVC.view];
        //        }
    }
    
    else if (indexPath.row == 6)     //record
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = FALSE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecG" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecGView.subviews containsObject:self.RecordVC.view];
        if (!doesContain){
            self.RecordVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RecordofAdvice"];
            [self addChildViewController:self.RecordVC];
            [self.SecGView addSubview:self.RecordVC.view];
        }
    }
    
    else if (indexPath.row == 7)     //declare
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = FALSE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecH" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecHView.subviews containsObject:self.DeclareCFFVC.view];
        if (!doesContain){
            self.DeclareCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DeclareView"];
            [self addChildViewController:self.DeclareCFFVC];
            [self.SecHView addSubview:self.DeclareCFFVC.view];
        }
    }
    
    else if (indexPath.row == 8)     //confirmation
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = FALSE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        if([FromStandalone isEqualToString:@"deleteAll"])
        {
            ExistingProductRecommended *viewController = [[ExistingProductRecommended alloc]
                                                          init];
            [viewController functionDelete1:@"DeleteAll"];
            
        }
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecI" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecIView.subviews containsObject:self.ConfirmCFFVC.view];
        if (!doesContain){
            self.ConfirmCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConfirmationView"];
            [self addChildViewController:self.ConfirmCFFVC];
            [self.SecIView addSubview:self.ConfirmCFFVC.view];
        }
    }
}

- (NSIndexPath *)tableView: (UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	pressSaveAll = FALSE;
    if (selectedPath.row == indexPath.row){//when trying to select the same row
        return nil;
    }
    
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        /*if (self.DisclosureVC.checkButton.selected){
         [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
         [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
         }
         else if (self.DisclosureVC.checkButton2.selected){
         //bool returnVal = [textFields validateEmpty:self.DisclosureVC.textDisclosure.text];
         if ([self.DisclosureVC.textDisclosure.text length] == 0){
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @" "
         message:@"Name of life insurance broker/financial adviser is required."
         delegate: self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [self.DisclosureVC.textDisclosure becomeFirstResponder];
         [alert show];
         alert = Nil;
         //return nil;
         }
         [[obj.CFFData objectForKey:@"SecA"] setValue:@"2" forKey:@"Disclosure"];
         [[obj.CFFData objectForKey:@"SecA"] setValue:self.DisclosureVC.textDisclosure.text forKey:@"BrokerName"];
         [self.DisclosureVC.textDisclosure resignFirstResponder];
         }*/
        if (![self validSecA]) {
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = TRUE;
            imageView = nil;
            return nil;
        }
        else {
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if (![self validSecB]){
            //return nil;
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = TRUE;
            imageView = nil;
            return nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    //section B end
    
    //section C start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]) {
        if (![self validSecC]){
            //return nil;
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = TRUE;
            imageView = nil;
            return nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
        }
    }
    //section C end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecD]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecE]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section E end
    
    //section F start (default protection)
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if (!secFPass) {
            secFPass = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"];
        }
        NSLog(@"%@, %@, %@, %d", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] ,
			  [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] ,
			  [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"],
			  ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]));
		
		if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
			if (![self validSecF]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = FALSE;
					imageView = nil;
				}
            }
			
		}
		
        else if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] || ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]) || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Validate"] isEqualToString:@"1"]){
            if (![self validSecF]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                    imageView.hidden = FALSE;
                    imageView = nil;
				}
            }
        }
    }
    //section F end (default protection)
    //section F Retirement start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]) {
        if (!secFPass) {
            secFPass = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"];
        }
		
		if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
			if (![self validSecF]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = FALSE;
					imageView = nil;
				}
            }
			
		}
        else if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] || ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]) || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Validate"] isEqualToString:@"1"]) {
            if (![self validSecF]) {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                    imageView.hidden = FALSE;
                    imageView = nil;
				}
            }
        }
    }
    //section F Retirement end
    //section F Education start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]) {
        if (!secFPass) {
            secFPass = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"];
        }
		if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
			if (![self validSecF]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = FALSE;
					imageView = nil;
				}
            }
			
		}
        else if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] || ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"] || [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"]) || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Validate"] isEqualToString:@"1"]) {
            if (![self validSecF]) {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                    imageView.hidden = FALSE;
                    imageView = nil;
				}
            }
        }
    }
    //section F Education end
    //section F Savings start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]) {
        if (!secFPass) {
            secFPass = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"];
        }
        if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
			if (![self validSecF]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = FALSE;
					imageView = nil;
				}
            }
			
		}
		else if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] ||  ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"] || [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"]) || [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Validate"] isEqualToString:@"1"]) {
            if (![self validSecF]) {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
				if (checkedSecF) {
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                    imageView.hidden = FALSE;
                    imageView = nil;
				}
            }
        }
    }
    //section F Savings end
    //section G start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecG]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section G end
    
    //section H start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecH]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
        else {
            [self validSecHSpecial:indexPath];
            return nil;
        }
    }
    //section H end
    
    //section I start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecI]){
                //return nil;
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
                imageView.hidden = TRUE;
                imageView = nil;
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section I end
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];//no need to validate since user not yet make any changes
    
    // special validation for FNA where secD must be completed before can access.
    if (indexPath.row == 5) {
        if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]) {
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Validate"] isEqualToString:@"1"]){
                if (![self validSecD]){
                    //return nil;
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                    imageView.hidden = TRUE;
                    imageView = nil;
                    return nil;
                }
                else{
                    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                    imageView.hidden = FALSE;
                    imageView = nil;
                    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
                    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Validate"];
                }
            }
        }
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete Potential Areas for Discussion before proceeding." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3002;
            [alert show];
            alert = nil;
            return nil;
        }
        /*else {
         [self validSecHSpecial:indexPath];
         return nil;
         }*/
        
        if([FromStandalone isEqualToString:@"deleteAll"])
        {
            ExistingProductRecommended *viewController = [[ExistingProductRecommended alloc]
                                                          init];
            [viewController functionDelete1:@"DeleteAll"];
            
        }
        
    }
    
    return indexPath;
    
    
}

#pragma mark - delegate action

-(void)swipeToRetirement
{
    self.RetirementVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RetirementView"];
    [self addChildViewController:self.RetirementVC];
    [self.RightView addSubview:self.RetirementVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setRightView:nil];
    [self setMyTableView:nil];
    [self setMyTableView:nil];
    [self setRightView:nil];
    [self setMyTableView:nil];
    [self setRightView:nil];
    [self setCFFTitle:nil];
    [self setSecFViewTab:nil];
    [self setSecFViewProtection:nil];
    [self setSecFViewRetirement:nil];
    [self setSecFViewEducation:nil];
    [self setSecFViewSavings:nil];
    [self setSecFTab:nil];
    [self setMyBar:nil];
	SecFEnable = 0;
    [super viewDidUnload];
}
- (IBAction)doCancel:(id)sender {
    ChangesMade=NO;
    if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFSave"] isEqualToString:@"1"]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"Do you want to save?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        //  [alert setTag:8001];
        // [alert show];
        alert = Nil;
        
        
        
        [[[UIAlertView alloc] initWithTitle:@" "
                                    message:NSLocalizedString(@"Do you want to save?",nil)
                           cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
            // Handle "Cancel"
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-2 inSection:-2]];
            NSLog(@"after special");
            if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
                if ([self validSecA])
                {
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
                if ([self validSecC]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
                if ([self validSecD]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
                if ([self validSecE]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
                if ([self validSecG]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
                if ([self validSecH]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
                if ([self validSecI]){
                    [self saveCreateCFF:1];
                }
            }
            
            
        }]
                           otherButtonItems:[RIButtonItem itemWithLabel:@"NO" action:^{
            // Handle "Delete"
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-3 inSection:-3]];
            
            
            
        }], nil] show];
        
        
        
        //[Utility showAllert:@"Please save."];
    }
    else{
        specialIndex = NULL;
        [self validSecHSpecial:NULL];
        //[self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (IBAction)doDone:(id)sender {
    [self.view endEditing:YES];
    pressSaveAll = TRUE;
    //if (![[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
    //    [self saveCreateCFF:0];
    //    [Utility showAllert:@"Record Saved Successfully."];
    //    return;
    //}
    
    
    
    //section A start
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        if ([self validSecA]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section A end
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if ([self validSecB]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section B end
    
    //section C start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
        if ([self validSecC]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section C end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        if ([self validSecD]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }}
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([self validSecE]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section E end
    
    //section SecFProtection start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
			if (checkedSecF) {
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
				imageView.hidden = FALSE;
				imageView = nil;
			}
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    
    //section SecFRetirement start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
			if (checkedSecF) {
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
				imageView.hidden = FALSE;
				imageView = nil;
			}
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section SecFRetirement end
    
    //section SecFEducation start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
			if (checkedSecF) {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = FALSE;
                imageView = nil;
			}
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    //section SecFEducation end
    
    //section SecFSavings start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
			if (checkedSecF) {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = FALSE;
                imageView = nil;
			}
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([self validSecG]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        if ([self validSecH]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([self validSecI]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
        }
        else {
            return;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]) {
        if ([[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData  objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
            if ([self validSecF]) {
                [self saveCreateCFF:0];
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = FALSE;
                imageView = nil;
            }
            else {
                return;
            }
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"] length] == 0 && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"] length] != 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9011;
            [alert show];
            alert = nil;
            return;
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"] length] == 0 && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"] length] != 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 91161;
            [alert show];
            alert = nil;
            return;
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"] length] == 0 && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"] length] != 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 911621;
            [alert show];
            alert = nil;
            return;
        }
        else {
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-1 inSection:-1]];
            //[Utility showAllert:@"Record saved successfully"];
        }
    }
    else {
        [self validSecHSpecial:[NSIndexPath indexPathForRow:-1 inSection:-1]];
        //[Utility showAllert:@"Record saved successfully"];
    }
    
    //section SecFSavings end
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    //NSLog(@"alertStack count: %d", alertStack.count);
    //if (alertStack.count != 0) {
    //    UIAlertView *alert = [alertStack objectAtIndex:alertStack.count-1];
    //    [alert show];
    //    alert = nil;
    //    [alertStack removeObjectAtIndex:alertStack.count-1];
    //}
    //else {
    //    [Utility showAllert:@"Record saved successfully."];
    //}
	
    
}

- (BOOL)doDoneEApp {
    [self.view endEditing:YES];
    
    //if (![[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
    //    [self saveCreateCFF:0];
    //    [Utility showAllert:@"Record Saved Successfully."];
    //    return;
    //}
    
    //section A start
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        if ([self validSecA]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section A end
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if ([self validSecB]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section B end
    
    //section C start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
        if ([self validSecC]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section C end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        if ([self validSecD]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([self validSecE]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section E end
    
    //section SecFProtection start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if ([self validSecF]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    //section SecFRetirement start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
        if ([self validSecF]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFRetirement end
    
    //section SecFEducation start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
        if ([self validSecF]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFEducation end
    
    //section SecFSavings start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
        if ([self validSecF]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([self validSecG]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        if ([self validSecH]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([self validSecI]){
            //[self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFSavings end
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    return FALSE;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //    if (alertView.tag == 99999) {
    //        if (buttonIndex  !=alertView.cancelButtonIndex) {
    //			noAlert = YES;
    //            mainresult=1;
    //            checkEappAlertDone=YES;
    //
    //        }else
    //        {
    //			noAlert = NO;
    //            checkEappAlertDone=YES;
    //            mainresult=2;
    //
    //            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
    //
    //        }
    //	}
    
    
    if (alertView.tag == 8001){ //eCFF listing
        if (buttonIndex == 0){
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-2 inSection:-2]];
            NSLog(@"after special");
            if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
                if ([self validSecA])
                {
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
                if ([self validSecC]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
                if ([self validSecD]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
                if ([self validSecE]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
                if ([self validSecG]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
                if ([self validSecH]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
                if ([self validSecI]){
                    [self saveCreateCFF:1];
                }
            }
        }
        else if (buttonIndex == 1){
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-3 inSection:-3]];
            //[self dismissViewControllerAnimated:TRUE completion:nil];
        }
    }
    
    
    
    else if (alertView.tag == 8002){ //eCFF listing
        if (buttonIndex == 0){
            if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
                if ([self validSecA]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
        }
    }
    
    //Section A
    else if (alertView.tag == 1001) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DisclosureVC.textDisclosure becomeFirstResponder];
    }
    
    // Section B
    else if (alertView.tag == 2001) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    
    // Section D
    else if(alertView.tag == 3001) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    else if(alertView.tag == 3002) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    
    // Section E
    else if (alertView.tag == 4001) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    
    //Section F Protection
    else if (alertView.tag == 9000){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
    }
    
    else if (alertView.tag == 9001){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9002){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9003){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9023){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current2 becomeFirstResponder];
    }
    else if (alertView.tag == 9004){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9024){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current3 becomeFirstResponder];
    }
    else if (alertView.tag == 9005){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required4 becomeFirstResponder];
    }
    else if (alertView.tag == 9025){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current4 becomeFirstResponder];
    }
    else if (alertView.tag == 9006){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.customerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9010){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.partnerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9011){
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.partnerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9007){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9032){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9033){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9034){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9035){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required4 becomeFirstResponder];
    }
    else if (alertView.tag == 6001) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
    }
    
    //section F Retirement
    else if (alertView.tag == 9100){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
    }
    
    else if (alertView.tag == 9101){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.current1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9102){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9107){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9106){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerAlloc becomeFirstResponder];
    }
    
    else if (alertView.tag == 91161) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerAlloc becomeFirstResponder];
    }
    
    else if (alertView.tag == 9116){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerAlloc becomeFirstResponder];
    }
    
    else if (alertView.tag == 91162) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 911621) {
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 9117){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 9118){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 9141){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9142){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9146){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9147){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerAlloc becomeFirstResponder];
    }
    
    // Section F Education
    else if (alertView.tag == 9200){
        
        if (![[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
            
            [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
        }
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
    }
    else if (alertView.tag == 9201){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9202){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9203){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9204){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9205){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required4 becomeFirstResponder];
    }
    else if (alertView.tag == 9206){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.customerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9207) {
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.current2 becomeFirstResponder];
    }
    else if (alertView.tag == 9208) {
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.current3 becomeFirstResponder];
    }
    else if (alertView.tag == 9209) {
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.current4 becomeFirstResponder];
    }
    else if (alertView.tag == 5001) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
    }
    
    //section F Savings
    else if (alertView.tag == 9300){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
    }
    else if (alertView.tag == 9301){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9302){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9304){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.customerAlloc becomeFirstResponder];
    }
    
    // Section G
    else if (alertView.tag == 10001){
        //[myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        //[myTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        //[myTableView setContentOffset:CGPointZero animated:YES];
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        [self.RecordVC.ReasonP1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 100011) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.ActionP1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 10002){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.TypeOfPlanP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10003){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.TermP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10004){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.SumAssuredP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10005){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.NameofInsuredP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10006){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.ReasonP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10007) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        //[self.RecordVC.ReasonP1 becomeFirstResponder];
        
        [self.RecordVC.NameofInsuredP2 becomeFirstResponder];
    }
    
    // Section H
    else if (alertView.tag == 20001){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.IntermediaryCodeContractDate becomeFirstResponder];
    }
    
    else if (alertView.tag == 20012) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.IntermediaryCode becomeFirstResponder];
    }
    
    else if (alertView.tag == 20013) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.NameOfIntermediary becomeFirstResponder];
    }
    
    else if (alertView.tag == 20014) {
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.IntermediaryNRIC becomeFirstResponder];
    }
    
    else if (alertView.tag == 20002){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.IntermediaryAddress1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 20003){
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.IntermediaryCodeContractDate becomeFirstResponder];
    }
    else if (alertView.tag == 20009){
        
        if (![[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        }
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
        
        [self.DeclareCFFVC.NameOfManager becomeFirstResponder];
    }
    else if (alertView.tag == 20010) {
        if (buttonIndex == 0) {
            self.DeclareCFFVC.NameOfManager.text = @"";
            [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
            if (specialIndex != NULL) {
                if (specialIndex.section == -1 && specialIndex.row == -1) {
                    [self saveCreateCFF:0];
                    [Utility showAllert:@"Record saved successfully."];
                    return;
                }
                else if (specialIndex.section == -1 && specialIndex.row == -2) {
                    [self saveCreateCFF:0];
                    [Utility showAllert:@"Record saved successfully."];
                    [self dismissModalViewControllerAnimated:YES];
                    return;
                }
                else if (specialIndex.section == -2 && specialIndex.row == -2) {
                    [self saveCreateCFF:0];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 20011;
                    [alert show];
                    alert = nil;
                    return;
                }
                else if (specialIndex.section == -3 && specialIndex.row == -3) {
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
                    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
                    [db open];
                    NSString *lastId = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
                    bool success = [db executeUpdate:@"UPDATE CFF_Master SET IntermediaryManagerName = ? WHERE ID = ?", @"", lastId, nil];
                    [self dismissModalViewControllerAnimated:YES];
                    if (success) {
                        NSLog(@"Name of manager updated");
                        self.DeclareCFFVC.NameOfManager.text = @"";
                        [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
                    }
                    else {
                        NSLog(@"Error at 20010: %@", [db lastErrorMessage]);
                    }
                    [db close];
                }
                else {
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
                    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
                    [db open];
                    NSString *lastId = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
                    bool success = [db executeUpdate:@"UPDATE CFF_Master SET IntermediaryManagerName = ? WHERE ID = ?", @"", lastId, nil];
                    if (success) {
                        NSLog(@"Name of manager updated 3");
                        self.DeclareCFFVC.NameOfManager.text = @"";
                        [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
                    }
                    else {
                        NSLog(@"Error at 20010: %@", [db lastErrorMessage]);
                    }
                    [db close];
                    [self.myTableView selectRowAtIndexPath:specialIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
                    [self tableView:self.myTableView didSelectRowAtIndexPath:specialIndex];
                }
            }
            else if (specialIndex == NULL) {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
                FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
                [db open];
                NSString *lastId = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
                bool success = [db executeUpdate:@"UPDATE CFF_Master SET IntermediaryManagerName = ? WHERE ID = ?", @"", lastId, nil];
                [self dismissModalViewControllerAnimated:YES];
                if (success) {
                    NSLog(@"Name of manager updated 2");
                    self.DeclareCFFVC.NameOfManager.text = @"";
                    [[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
                }
                else {
                    NSLog(@"Error at 20010 2: %@", [db lastErrorMessage]);
                }
                [db close];
                [self dismissModalViewControllerAnimated:YES];
            }
        }
    }
    else if (alertView.tag == 20011) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else if (alertView.tag == 21003) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:7 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    // Section I
    else if (alertView.tag == 30001) {
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:8 inSection:0];
        //[self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        //[self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPath];
    }
    else if (alertView.tag == 30002) {
        [self.ConfirmCFFVC.othersField becomeFirstResponder];
    }
    
    else if (alertView.tag == 444){
        if (buttonIndex == 1){
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *db = [FMDatabase databaseWithPath:path];
            [db open];
            NSString *CFFID = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
            
            [db executeUpdate:@"DELETE FROM CFF_Master WHERE ID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Protection WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Retirement WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Education WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Education_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_SavingsInvest WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Family_Datails WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_CA WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_CA_Recommendation WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Recommendation_Rider WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_RecordOfAdvice WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_RecordOFAdvice_Rider WHERE CFFID = ?", CFFID];
            //[db executeUpdate:@"DELETE FROM CFF_Personal_Details WHERE CFFID = ?", CFFID];
            FMResultSet *result = [db executeQuery:@"select * from eProposal_CFF_Master where ID = ?", CFFID];
            while ([result next]) {
                NSString *eProposalNo = [result objectForColumnName:@"eProposalNo"];
                [self deleteEApp:eProposalNo database:db];
            }
            [db close];
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
    }
	else if (alertView.tag == 8888){ //eApplication-listing, saving CFF
        if (buttonIndex == 0){
            [self eAppDoneAction:nil];
		}
        else if (buttonIndex == 1){
            [self validSecHSpecial:[NSIndexPath indexPathForRow:-3 inSection:-3]];
            //[self dismissViewControllerAnimated:TRUE completion:nil];
        }
    }
    if (alertView.tag == 999) {
        if (buttonIndex == 0) {
            RcrdSvForCFF = NO;
            [self saveCreateCFF:0];
            if ([obj.eAppData objectForKey:@"CFF"] == NULL) {
                [obj.eAppData setObject:[[NSMutableDictionary alloc] init] forKey:@"CFF"];
            }
            [[obj.eAppData objectForKey:@"CFF"] setValue:self.cffID forKey:@"CustomerCFF"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"CFFSelected"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.name forKey:@"CFFName"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.idNo forKey:@"CFFIDNo"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.date forKey:@"CFFDate"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.status forKey:@"CFFStatus"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.cffID forKey:@"CFFID"];
            
            [[obj.eAppData objectForKey:@"EAPP"] setValue:self.clientProfileID forKey:@"CFFClientProfileID"];
            
            [self.delegate selectedCFF];
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
        else if(buttonIndex==1)
        {
            [self dismissViewControllerAnimated:TRUE completion:nil];
            //do nothing
        }
    }
	
	
    
    
    /*
     if (alertView.tag == 2000 && buttonIndex == 0)
     {
     [self.view endEditing:YES];
     }
     else if (alertView.tag == 2001 && buttonIndex == 0)
     {
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2002 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2003 && buttonIndex == 0)
     {
     //UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
     //imageView.hidden = FALSE;
     //alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2004 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2005 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     */
}

-(void)deleteEApp:(NSString *)proposal database:(FMDatabase *)db {
    
    //Delete eApp_Listing
	NSLog(@"Delete Proposal %@", proposal);
	
	
	//ADD BY EMI: Delete only for status created and Confirmed
	FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"Select * from eApp_listing where status in (2,3) and eProposalNo = '%@'", proposal]];
    while ([result next]) {
        if (![db executeUpdate:@"Delete from eApp_Listing where ProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - CFF eApp_Listing");
		}
		
		//Delete eProposal_LA_Details
		if (![db executeUpdate:@"Delete from eProposal_LA_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_LA_Details");
		}
		
		//Delete eProposal
		if (![db executeUpdate:@"Delete from eProposal where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal");
		}
		
		//Delete eProposal_Existing_Policy_1
		if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
		}
		
		//Delete eProposal_Existing_Policy_2
		if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
		}
		
		//Delete eProposal_NM_Details
		if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_NM_Details");
		}
		
		//Delete eProposal_Trustee_Details
		if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
		}
		
		//Delete eProposal_QuestionAns
		if (![db executeUpdate:@"Delete from eProposal_QuestionAns where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
		}
		
		//Delete eProposal_Additional_Questions_1
		if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
		}
		
		//Delete eProposal_Additional_Questions_2
		if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
		}
		
		//DELETE CFF START
		
		//Delete eProposal_CFF_Master
		if (![db executeUpdate:@"Delete from eProposal_CFF_Master where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
		}
		
		//Delete eProposal_CFF_CA
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
		}
		
		//Delete eProposal_CFF_CA_Recommendation
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
		}
		
		//Delete eProposal_CFF_CA_Recommendation_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
		}
		
		//Delete eProposal_CFF_Education
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
		}
		
		//Delete eProposal_CFF_Education_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
		}
		
		//Delete eProposal_CFF_Family_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Family_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
		}
		
		//Delete eProposal_CFF_Personal_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
		}
		
		//Delete eProposal_CFF_Protection
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
		}
		
		//Delete eProposal_CFF_Protection_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
		}
		
		//Delete eProposal_CFF_Retirement
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
		}
		
		//Delete eProposal_CFF_Retirement_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		//DELETE CFF END
	}
}

-(void)Clear_EAppProposal_Value:(NSString *)proposal database:(FMDatabase *)db {
	
	
	NSString *query = @"";
	query = [NSString stringWithFormat:@"UPDATE eProposal SET ProposalCompleted = 'N', COMandatoryFlag = '', PolicyDetailsMandatoryFlag = '', QuestionnaireMandatoryFlag = '', NomineesMandatoryFlag = '', AdditionalQuestionsMandatoryFlag = 'N', DeclarationMandatoryFlag = '', DeclarationAuthorization = '', COTitle = '', COSex = '', COName = '', COPhoneNo = '', CONewICNo = '', COMobileNo = '', CODOB = '', COEmailAddress = '', CONationality = '', COOccupation = '', CONameOfEmployer = '', COExactNatureOfWork = '', COOtherIDType = '', COOtherID = '', CORelationship = '', COSameAddressPO = '', COAddress1 = '', COAddress2 = '', COAddress3 = '', COPostcode = '', COTown = '', COState = '', COCountry = '', COCRAddress1 = '', COCRAddress2 = '', COCRAddress3 = '', COCRPostcode = '', COCRTown = '', COCRState = '', COCRCountry = '', LAMandatoryFlag = 'N', COForeignAddressFlag = '', COCRForeignAddressFlag = '', PaymentMode = '', BasicPlanTerm = '', BasicPlanSA = '', BasicPlanModalPremium ='', TotalModalPremium ='', FirstTimePayment = '', PaymentUponFinalAcceptance = '' ,EPP='', RecurringPayment = '', SecondAgentCode = '', SecondAgentContactNo = '', SecondAgentName = '', PTypeCode = '', CreditCardBank = '', CreditCardType = '', CardMemberAccountNo = '', CardExpiredDate = '', CardMemberName = '', CardMemberSex = '', CardMemberDOB = '', CardMemberNewICNo = '', CardMemberOtherIDType = '', CardMemberOtherID = '', CardMemberContactNo = '', CardMemberRelationship = '', FTPTypeCode = '', FTCreditCardBank = '', FTCreditCardType = '', FTCardMemberAccountNo = '', FTCardExpiredDate = '', FTCardMemberName = '', FTCardMemberSex = '', FTCardMemberDOB = '', FTCardMemberNewICNo = '', FTCardMemberOtherIDType = '', FTCardMemberOtherID = '', FTCardMemberContactNo = '', FTCardMemberRelationship = '', SameAsFT = '', FullyPaidUpOption = '', FullyPaidUpTerm = '', RevisedSA = '', AmtRevised = '', PolicyDetailsMandatoryFlag = '', LIEN = '', ExistingPoliciesMandatoryFlag = 'N' WHERE eProposalNo = '%@'", proposal, nil];
	[db executeUpdate:query];
	
	
	
	
    //	//Delete eApp_Listing
    //	if (![db executeUpdate:@"Delete from eApp_Listing where ProposalNo = ?", proposal, nil]) {
    //		NSLog(@"Error in Delete Statement - CFF eApp_Listing");
    //	}
	
    //	//Delete eProposal_LA_Details
    //	if (![db executeUpdate:@"Delete from eProposal_LA_Details where eProposalNo = ?", proposal, nil]) {
    //		NSLog(@"Error in Delete Statement - eProposal_LA_Details");
    //	}
	
    //	//Delete eProposal
    //	if (![db executeUpdate:@"Delete from eProposal where eProposalNo = ?", proposal, nil]) {
    //		NSLog(@"Error in Delete Statement - eProposal");
    //	}
	
	//Delete eProposal_Existing_Policy_1
	if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
	}
	
	//Delete eProposal_Existing_Policy_2
	if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
	}
	
	//Delete eProposal_NM_Details
	if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_NM_Details");
	}
	
	//Delete eProposal_Trustee_Details
	if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
	}
	
	//Delete eProposal_QuestionAns
	if (![db executeUpdate:@"Delete from eProposal_QuestionAns where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
	}
	
	//Delete eProposal_Additional_Questions_1
	if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
	}
	
	//Delete eProposal_Additional_Questions_2
	if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
	}
    
}

-(void)DeleteEAppCFF:(NSString *)proposal database:(FMDatabase *)db {
    
    //Delete eApp_Listing
	NSLog(@"Delete eAPP_CFF %@", proposal);
	
	NSString *status;
	//ADD BY EMI: Delete only for status created and Confirmed
	FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"Select status from eApp_listing where ProposalNo = '%@'", proposal]];
	
    while ([result next]) {
		status = [result objectForColumnName:@"status"];
	}
	
    
	if ([status isEqualToString:@"2"]) {
        //DELETE CFF START
        
		//Delete eProposal_CFF_Master
		if (![db executeUpdate:@"Delete from eProposal_CFF_Master where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
		}
		
		//Delete eProposal_CFF_CA
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
		}
		
		//Delete eProposal_CFF_CA_Recommendation
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
		}
		
		//Delete eProposal_CFF_CA_Recommendation_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
		}
		
		//Delete eProposal_CFF_Education
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
		}
		
		//Delete eProposal_CFF_Education_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
		}
		
		//Delete eProposal_CFF_Family_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Family_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
		}
		
		//Delete eProposal_CFF_Personal_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
		}
		
		//Delete eProposal_CFF_Protection
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
		}
		
		//Delete eProposal_CFF_Protection_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
		}
		
		//Delete eProposal_CFF_Retirement
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
		}
		
		//Delete eProposal_CFF_Retirement_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		//DELETE CFF END
	}
	
}

-(void)logger{
    //NSLog(@"sadasdas");
}


- (IBAction)doSecFTab:(id)sender {
    [self.view endEditing:YES];
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    if (_secFTab.selectedSegmentIndex == 0){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewProtection.subviews containsObject:self.FNAProtectionVC.view];
        if (!doesContain){
            self.FNAProtectionVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialProtectionView"];
            [self addChildViewController:self.FNAProtectionVC];
            [self.SecFViewProtection addSubview:self.FNAProtectionVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 1){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewRetirement.subviews containsObject:self.FNARetirementVC.view];
        if (!doesContain){
            self.FNARetirementVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialRetirementView"];
            [self addChildViewController:self.FNARetirementVC];
            [self.SecFViewRetirement addSubview:self.FNARetirementVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 2){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecFViewEducation.subviews containsObject:self.FNAEducationVC.view];
        if (!doesContain){
            self.FNAEducationVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialEducationView"];
            [self addChildViewController:self.FNAEducationVC];
            [self.SecFViewEducation addSubview:self.FNAEducationVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 3){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewSavings.subviews containsObject:self.FNASavingsVC.view];
        if (!doesContain){
            self.FNASavingsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialSavingsView"];
            [self addChildViewController:self.FNASavingsVC];
            [self.SecFViewSavings addSubview:self.FNASavingsVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
        if (_FNAEducationVC.hasChildren == FALSE && [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]) {
            NSLog(@"doSecF hack");
            [_FNAEducationVC hasChildBtn:_FNAEducationVC.hasChild];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
        }
    }
    
}
-(BOOL)validSecA{
    if (self.DisclosureVC.checkButton.selected){
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
    }
    else if (self.DisclosureVC.checkButton2.selected){
        //NSLog(@"1");
        //[textFields validateString3:[NSString stringWithFormat:@"%@%@", self.DisclosureVC.textDisclosure.text, self.DisclosureVC.txtDisclosure2.text]];
        //NSLog(@"2");
        //bool returnVal = [textFields validateEmpty:self.DisclosureVC.textDisclosure.text];
        if ([self.DisclosureVC.textDisclosure.text length]  == 0 && self.DisclosureVC.txtDisclosure2.text.length == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Name of life insurance broker/financial adviser is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //[self.DisclosureVC.textDisclosure becomeFirstResponder];
            alert.tag = 1001;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if (self.DisclosureVC.textDisclosure.text.length > 70) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Name of company is too long. Maximum 70 characters."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //[self.DisclosureVC.textDisclosure becomeFirstResponder];
            alert.tag = 1001;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([textFields validateString:[NSString stringWithFormat:@"%@%@", self.DisclosureVC.textDisclosure.text, self.DisclosureVC.txtDisclosure2.text]]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid Name format. Same alphabet cannot be repeated for more than 3 times."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //[self.DisclosureVC.textDisclosure becomeFirstResponder];
            alert.tag = 1001;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([textFields validateString3withView: [NSString stringWithFormat:@"%@%@", self.DisclosureVC.textDisclosure.text, self.DisclosureVC.txtDisclosure2.text] view:self.view]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //[self.DisclosureVC.textDisclosure becomeFirstResponder];
            alert.tag = 1001;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if (self.DisclosureVC.textDisclosure.text.length > 0) {
            NSString *rawString = self.DisclosureVC.textDisclosure.text;
            NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
            if ([trimmed length] == 0 && self.DisclosureVC.txtDisclosure2.text.length == 0) {
                // Text was empty or only whitespace.
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Name of life insurance broker/financial adviser is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                //[self.DisclosureVC.textDisclosure becomeFirstResponder];
                alert.tag = 1001;
                [alert show];
                [alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"2" forKey:@"Disclosure"];
        [[obj.CFFData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", self.DisclosureVC.textDisclosure.text, self.DisclosureVC.txtDisclosure2.text] forKey:@"BrokerName"];
        //[self.DisclosureVC.textDisclosure resignFirstResponder];
    }
    return TRUE;
}

-(BOOL)validSecB{
    if (!self.CustomerVC.checkboxButton1.selected && !self.CustomerVC.checkboxButton2.selected && !self.CustomerVC.checkboxButton3.selected){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Customer's Choice is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        alert.tag = 2001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    return TRUE;
}

-(BOOL)validSecC{
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    if (![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
        return TRUE;
    }
    else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]) {
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]) {
            if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"] length] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current Income Allocation for Partner/Spouse is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9011;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]) {
            if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"] length] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current Income Allocation for Partner/Spouse is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9116;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
    }
    return TRUE;
}

-(BOOL)validSecD{
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Completed"];
    
    if (self.PotentialVC.planned1.selectedSegmentIndex == -1 && self.PotentialVC.planned2.selectedSegmentIndex == -1 && self.PotentialVC.planned3.selectedSegmentIndex == -1 && self.PotentialVC.planned4.selectedSegmentIndex == -1 && self.PotentialVC.planned5.selectedSegmentIndex == -1 && self.PotentialVC.discussion1.selectedSegmentIndex == -1 && self.PotentialVC.discussion2.selectedSegmentIndex == -1 && self.PotentialVC.discussion3.selectedSegmentIndex == -1 && self.PotentialVC.discussion4.selectedSegmentIndex == -1 && self.PotentialVC.discussion5.selectedSegmentIndex == -1){
        //[Utility showAllert:@"At least one option of Potential Areas for Discussion is required."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"At least one option of Potential Areas for Discussion is required." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 3001;
        [alert show];
        
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    bool option1Done = FALSE;
    bool option2Done = FALSE;
    bool option3Done = FALSE;
    bool option4Done = FALSE;
    bool option5Done = FALSE;
    
    bool option1Partial = FALSE;
    bool option2Partial = FALSE;
    bool option3Partial = FALSE;
    bool option4Partial = FALSE;
    bool option5Partial = FALSE;
    
    bool inOrder1 = FALSE;
    bool inOrder2 = FALSE;
    bool inOrder3 = FALSE;
    bool inOrder4 = FALSE;
    bool inOrder5 = FALSE;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5",nil];
    
    if (self.PotentialVC.planned1.selectedSegmentIndex != -1 && self.PotentialVC.discussion1.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"N/A"]){
        option1Done = TRUE;
    }
    if (self.PotentialVC.planned2.selectedSegmentIndex != -1 && self.PotentialVC.discussion2.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"N/A"]){
        option2Done = TRUE;
    }
    if (self.PotentialVC.planned3.selectedSegmentIndex != -1 && self.PotentialVC.discussion3.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"N/A"]){
        option3Done = TRUE;
    }
    if (self.PotentialVC.planned4.selectedSegmentIndex != -1 && self.PotentialVC.discussion4.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"N/A"]){
        option4Done = TRUE;
    }
    if (self.PotentialVC.planned5.selectedSegmentIndex != -1 && self.PotentialVC.discussion5.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"N/A"]){
        option5Done = TRUE;
    }
    
    if (self.PotentialVC.planned1.selectedSegmentIndex != -1 || self.PotentialVC.discussion1.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"N/A"]){
        option1Partial = TRUE;
    }
    if (self.PotentialVC.planned2.selectedSegmentIndex != -1 || self.PotentialVC.discussion2.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"N/A"]){
        option2Partial = TRUE;
    }
    if (self.PotentialVC.planned3.selectedSegmentIndex != -1 || self.PotentialVC.discussion3.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"N/A"]){
        option3Partial = TRUE;
    }
    if (self.PotentialVC.planned4.selectedSegmentIndex != -1 || self.PotentialVC.discussion4.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"N/A"]){
        option4Partial = TRUE;
    }
    if (self.PotentialVC.planned5.selectedSegmentIndex != -1 || self.PotentialVC.discussion5.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"N/A"]){
        option5Partial = TRUE;
    }
    
    
    if (option1Done){
        if (!option2Done){
            if (option2Partial){
                //[Utility showAllert:@"Please answer all question for Option 2."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                alert = nil;
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                //[Utility showAllert:@"Please answer all question for Option 3."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                //[Utility showAllert:@"Please answer all question for Option 4."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 4." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                //[Utility showAllert:@"Please answer all question for Option 5."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        //if (![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
        //    [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
        //    return nil;
        //}
    }
    else{
        if (option1Partial){
            //[Utility showAllert:@"Please answer all question for Option 1."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 1." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option2Done){
        if (!option1Done){
            if (option1Partial){
                //[Utility showAllertz@"Please answer all question for Option 1."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 1." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                //[Utility showAllert:@"Please answer all question for Option 3."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                //[Utility showAllert:@"Please answer all question for Option 4."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 4." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                //[Utility showAllert:@"Please answer all question for Option 5."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
    }
    else{
        if (option2Partial){
            //[Utility showAllert:@"Please answer all question for Option 2."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option3Done){
        if (!option1Done){
            if (option1Partial){
                //[Utility showAllert:@"Please answer all question for Option 1."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 1." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                //[Utility showAllert:@"Please answer all question for Option 2."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                //[Utility showAllert:@"Please answer all question for Option 4."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 4." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                //[Utility showAllert:@"Please answer all question for Option 5."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
    }
    else{
        if (option3Partial){
            //[Utility showAllert:@"Please answer all question for Option 3."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option4Done){
        if (!option1Done){
            if (option1Partial){
                //[Utility showAllert:@"Please answer all question for Option 1."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 1." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                //[Utility showAllert:@"Please answer all question for Option 2."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                //[Utility showAllert:@"Please answer all question for Option 3."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                //[Utility showAllert:@"Please answer all question for Option 5."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
    }
    else{
        if (option4Partial){
            //[Utility showAllert:@"Please answer all question for Option 4."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 4." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option5Done){
        if (!option1Done){
            if (option1Partial){
                //[Utility showAllert:@"Please answer all question for Option 1."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option  1." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                //[Utility showAllert:@"Please answer all question for Option 2."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                //[Utility showAllert:@"Please answer all question for Option 3."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                //[Utility showAllert:@"Please answer all question for Option 4."];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 4." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 3001;
                [alert show];
                //[alertStack addObject:alert];
                return FALSE;
            }
        }
    }
    else{
        if (option5Partial){
            //[Utility showAllert:@"Please answer all question for Option 5."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all question for Option 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option1Done && !option2Done && !option3Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority should be 1 if ONLY 1 option being selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option2Done && !option1Done && !option3Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority should be 1 if ONLY 1 option being selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option3Done && !option2Done && !option1Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority should be 1 if ONLY 1 option being selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option4Done && !option3Done && !option2Done && !option1Done && !option5Done){
        if (![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority should be 1 if ONLY 1 option being selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if (option5Done && !option1Done && !option3Done && !option4Done && !option2Done){
        if (![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority should be 1 if ONLY 1 option being selected." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            //[Utility showAllert:@"Priority is not in correct order."];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    for (NSString *order in array) {
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:order] || [self.PotentialVC.Priority2.titleLabel.text isEqualToString:order] || [self.PotentialVC.Priority3.titleLabel.text isEqualToString:order] || [self.PotentialVC.Priority4.titleLabel.text isEqualToString:order] || [self.PotentialVC.Priority5.titleLabel.text isEqualToString:order]) {
            if ([order isEqualToString:@"1"]) {
                inOrder1 = TRUE;
            }
            else if ([order isEqualToString:@"2"]) {
                inOrder2 = TRUE;
            }
            else if ([order isEqualToString:@"3"]) {
                inOrder3 = TRUE;
            }
            else if ([order isEqualToString:@"4"]) {
                inOrder4 = TRUE;
            }
            else if ([order isEqualToString:@"5"]) {
                inOrder5 = TRUE;
            }
        }
    }
    
    if (!inOrder1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 3001;
        [alert show];
        //[alertStack addObject:alert];
        return FALSE;
    }
    if (inOrder1 && !inOrder2) {
        if (inOrder3) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if (inOrder4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if (inOrder5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    else if (inOrder1 && inOrder2 && !inOrder3) {
        if (inOrder4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
        if (inOrder5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    else if (inOrder1 && inOrder2 && inOrder3 && !inOrder4) {
        if (inOrder5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Priority is not in correct order." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3001;
            [alert show];
            //[alertStack addObject:alert];
            return FALSE;
        }
    }
    
    /*
     if (self.PotentialVC.Priority1.titleLabel.text){
     [[obj.CFFData objectForKey:@"SecA"] setValue:@"Disclosure of Intermediary Status" forKey:@"Title"];
     }
     */
    //NSLog(@"OK");
    
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
    
    if (option1Done){
        if (self.PotentialVC.planned1.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ1_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ1_Ans1"];
        }
        
        if (self.PotentialVC.discussion1.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ1_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ1_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority1.titleLabel.text forKey:@"NeedsQ1_Priority"];
    }
    if (option2Done){
        if (self.PotentialVC.planned2.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ2_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ2_Ans1"];
        }
        
        if (self.PotentialVC.discussion2.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ2_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ2_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority2.titleLabel.text forKey:@"NeedsQ2_Priority"];
    }
    if (option3Done){
        if (self.PotentialVC.planned3.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ3_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ3_Ans1"];
        }
        
        if (self.PotentialVC.discussion3.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ3_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ3_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority3.titleLabel.text forKey:@"NeedsQ3_Priority"];
    }
    
    if (option4Done){
        if (self.PotentialVC.planned4.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ4_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ4_Ans1"];
        }
        
        if (self.PotentialVC.discussion4.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ4_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ4_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority4.titleLabel.text forKey:@"NeedsQ4_Priority"];
    }
    
    if (option5Done){
        if (self.PotentialVC.planned5.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ5_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ5_Ans1"];
        }
        
        if (self.PotentialVC.discussion5.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ5_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ5_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority5.titleLabel.text forKey:@"NeedsQ5_Priority"];
    }
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"1" forKey:@"Completed"];
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"] || [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]) {
        UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.userInteractionEnabled = YES;
    }
    return TRUE;
}

-(BOOL)validSecE{
    if ([self.PreferenceVC.sliderValue isEqualToString:@"0"] || !self.PreferenceVC.changed){
        //[Utility showAllert:@"Investment Preference is required. Please select from 1 to 5."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Investment Preference is required. Please select from 1 to 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 4001;
        [alert show];
        //[alertStack addObject:alert];
        return FALSE;
    }
    return TRUE;
}

-(BOOL)validSecF{
    
    //[[obj.CFFData objectForKey:@"SecB"] setValue:@"2" forKey:@"ClientChoice"];
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"]);
    
    [self.view endEditing:YES];
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
        
        //		if ([self RecheckIfEmpty]){
        if (![self validSecFProtection]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = TRUE;
            imageView = nil;
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            return FALSE;
        }
        else {
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
        }
        //		}
        //		else {
        //			[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
        //		}
        //		if ([self RecheckRetirementNeedValidation]) {
        if (![self validSecFRetirement]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = TRUE;
            imageView = nil;
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            return FALSE;
        }
        else {
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
        }
        //		}
        //		else {
        //			[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
        //		}
        //		if ([self RecheckEducationNeedValidation]) {
        if (![self validSecFEducation]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = TRUE;
            imageView = nil;
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            return FALSE;
        }
        else {
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
        }
        //		}
        //		else {
        //			[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
        //		}
        //		if ([self RecheckSavingNeedValidation]) {
        if (![self validSecFSavings]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = TRUE;
            imageView = nil;
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            return FALSE;
        }
        else {
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
        }
        //		}
        //		else {
        //			[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
        //		}
        //		}
		if (self.FNAProtectionVC.customerAlloc.text.length == 0 || self.FNARetirementVC.customerAlloc.text.length == 0 || (self.FNAEducationVC.ChildrenSelected && self.FNAEducationVC.customerAlloc.text.length == 0) || self.FNASavingsVC.customerAlloc.text.length == 0) {
            //			if (pressSaveAll) {
            //				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please enter all categories' income allocation under Financial Needs Analysis." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //				[alert show];
            //				alert.tag = 5001;
            //				[alertStack addObject:alert]; ;
            //				alert = nil;
            //				return  FALSE;
            //			}
            //			else {
            checkedSecF = FALSE;
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = TRUE;
            imageView = nil;
            return TRUE;
            //			}
            
		}
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
        
        /*if (self.FNAProtectionVC.customerAlloc.text.length == 0 && self.FNARetirementVC.customerAlloc.text.length == 0 && self.FNAEducationVC.customerAlloc.text.length == 0 && self.FNASavingsVC.customerAlloc.text.length == 0) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please fill-in at least one section's income allocation under Financial Needs Analysis." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
         alert.tag = 5001;
         [alert show];
         //[alertStack addObject:alert];
         alert = nil;
         return  FALSE;
         }*/
        
        /*if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
         if (![self validSecFEducation]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
         if (![self validSecFSavings]){
         return FALSE;
         }
         }*/
        
        int protection = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] intValue];
        int retirement = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] intValue];
        int education = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] intValue];
        int savings = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] intValue];
        int investment = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] intValue];
        if (protection == 1) {
			if  ([self RecheckIfEmpty] || pressSaveAll) {
				if ([self validSecFProtection]){
					[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
				}
				else {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = TRUE;
					imageView = nil;
					[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
					[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
					checkedSecF = FALSE;
					return FALSE;
				}
			}
			else {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
				checkedSecF = FALSE;
                return TRUE;
            }
            //            else if (![self validSecFProtection]){
            //                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            //                imageView.hidden = TRUE;
            //                imageView = nil;
            //                [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
            //                [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
            //                return FALSE;
            //            }
            //            else {
            //                [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
            //            }
        }
        else if (retirement == 1) {
			if  ([self RecheckIfEmpty] || pressSaveAll) {
				if ([self validSecFRetirement]){
					[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
				}
				else {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = TRUE;
					imageView = nil;
					[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
					[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
					checkedSecF = FALSE;
					return FALSE;
				}
			}
            else {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
                checkedSecF = FALSE;
				return TRUE;
            }
            //            else {
            //                [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
            //            }
        }
        else if (education == 1) {
			if  ([self RecheckIfEmpty] || pressSaveAll) {
				if ([self validSecFEducation]){
					[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
				}
				else {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = TRUE;
					imageView = nil;
					[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
					[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
					checkedSecF = FALSE;
					return FALSE;
				}
			}
            else {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
				checkedSecF = FALSE;
				return TRUE;
            }
            //            else {
            //                [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
            //            }
        }
        else if (savings == 1 || investment == 1) {
			if  ([self RecheckIfEmpty] || pressSaveAll) {
				if ([self validSecFSavings]){
					[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
				}
				else {
					UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
					imageView.hidden = TRUE;
					imageView = nil;
					[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
					[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
					checkedSecF = FALSE;
					return FALSE;
				}
			}
            else {
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = TRUE;
                imageView = nil;
                [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
                [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
				checkedSecF = FALSE;
				return TRUE;
            }
            //            else {
            //                [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
            //            }
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"] && ([self RecheckProtectionNeedValidation] && pressSaveAll)){
            if (![self validSecFProtection]){
                return FALSE;
            }
            else {
                [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
            }
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
            if (![self validSecFRetirement]){
                return FALSE;
            }
            else {
                [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
            }
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"]){
            if (![self validSecFEducation]){
                return FALSE;
            }
            else {
                [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
            }
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]){
            if (![self validSecFSavings]){
                return FALSE;
            }
            else {
                [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
            }
        }
        
        /*
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFEducation]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFSavings]){
         return FALSE;
         }
         }
         }
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFEducation]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFSavings]){
         return FALSE;
         }
         }
         }
         
         */
        
        
        
        /*
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         
         
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         
         
         
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         else{
         
         }
         }
         
         */
        //[[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
        
        
        //if (![self validSecFProtection]){
        //}
        
    }
    
    
    //if (![self validSecFProtection]){
    //    return FALSE;
    //}
    //if (![self validSecFRetirement]){
    //    return FALSE;
    //}
    //if (![self validSecFEducation]){
    //    return FALSE;
    //}
    //if (![self validSecFSavings]){
    //    return FALSE;
    //}
    //[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
    secFPass = @"0";
    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
    imageView.hidden = FALSE;
    imageView = nil;
	checkedSecF = TRUE;
    return TRUE;
}


-(BOOL)validSecFEducation{
    if (!self.FNAEducationVC.ChildrenSelected){
        [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
        return true;
    }
    
    if (self.FNAEducationVC.EducationSelected){
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"0"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Education Cost Planning is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9200;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        //child 1 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current1.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current Amount for Child 1 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9201;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current1.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required1.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 1 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9202;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required1.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9202;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        //child 1 end
        
        //child 2 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                [alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.current2.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current Amount for Child 2 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9207;
                [alert show];
                [alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text length] != 0 && [self.FNAEducationVC.required2.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 2 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required2.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        else if(self.FNAEducationVC.required2.text.length != 0 || self.FNAEducationVC.current2.text.length != 0){
            if ([self.FNAEducationVC.current1.text length] == 0 || [self.FNAEducationVC.required1.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.current2.text.length == 0 && self.FNAEducationVC.required2.text != 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (![self.FNAEducationVC.current2.text isEqualToString:@"0.00"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.required2.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 2 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required2.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        //child 2 end
        
        //child 3 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            if (self.FNAEducationVC.current3.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current amount for Child 3 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9208;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text length] != 0 && [self.FNAEducationVC.required3.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 3 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required3.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        else if (self.FNAEducationVC.current3.text.length != 0 || self.FNAEducationVC.required3.text.length != 0){
            if ([self.FNAEducationVC.current1.text length] == 0 || [self.FNAEducationVC.required1.text length] == 0 || self.FNAEducationVC.current2.text.length == 0 || self.FNAEducationVC.required2.text.length == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.current3.text.length == 0 && self.FNAEducationVC.required3.text != 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (![self.FNAEducationVC.current3.text isEqualToString:@"0.00"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.required3.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 3 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required3.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        //child 3 end
        
        //child 4 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            if (self.FNAEducationVC.current4.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Current amount for Child 4 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9209;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text length] != 0 && [self.FNAEducationVC.required4.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 4 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required4.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        else if(self.FNAEducationVC.required4.text.length != 0 || self.FNAEducationVC.current4.text.length != 0){
            if ([self.FNAEducationVC.current1.text length] == 0 || [self.FNAEducationVC.required1.text length] == 0 || self.FNAEducationVC.current2.text.length == 0 || self.FNAEducationVC.required2.text.length == 0 || self.FNAEducationVC.current3.text.length == 0 || self.FNAEducationVC.required3.text.length == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.current4.text.length == 0 && self.FNAEducationVC.required4.text != 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (![self.FNAEducationVC.current4.text isEqualToString:@"0.00"]) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 5001;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if (self.FNAEducationVC.required4.text.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required Amount for Child 4 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required4.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        //child 4 end
        
        if ((self.FNAEducationVC.current1.text.length != 0 && ![self.FNAEducationVC.current1.text isEqualToString:@"0.00"]) && self.FNAEducationVC.required1.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 1 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ((self.FNAEducationVC.current1.text.length != 0 && ![self.FNAEducationVC.current1.text isEqualToString:@"0.00"]) && [self.FNAEducationVC.required1.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ((self.FNAEducationVC.current2.text.length != 0 && ![self.FNAEducationVC.current2.text isEqualToString:@"0.00"]) && self.FNAEducationVC.required2.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 2 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ((self.FNAEducationVC.current2.text.length != 0 && ![self.FNAEducationVC.current2.text isEqualToString:@"0.00"]) && [self.FNAEducationVC.required2.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ((self.FNAEducationVC.current3.text.length != 0 && ![self.FNAEducationVC.current3.text isEqualToString:@"0.00"]) && self.FNAEducationVC.required3.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 3 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9204;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ((self.FNAEducationVC.current3.text.length != 0 && ![self.FNAEducationVC.current3.text isEqualToString:@"0.00"]) && [self.FNAEducationVC.required3.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9204;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ((self.FNAEducationVC.current4.text.length != 0 && ![self.FNAEducationVC.current4.text isEqualToString:@"0.00"])&& self.FNAEducationVC.required4.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 4 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9205;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ((self.FNAEducationVC.current4.text.length != 0 && ![self.FNAEducationVC.current4.text isEqualToString:@"0.00"]) && [self.FNAEducationVC.required4.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9205;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
    }
    else{
        if ([self.FNAEducationVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if (self.FNAEducationVC.required1.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 1 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAEducationVC.required2.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount must Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        /*else if (self.FNAEducationVC.required2.text.length == 0) {
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @" "
         message:@"Required Amount for Child 2 is required."
         delegate: self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         alert.tag = 9203;
         [alert show];
         //[alertStack addObject:alert];
         alert = Nil;
         return FALSE;
         }*/
        else if ([self.FNAEducationVC.required3.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9204;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        /*else if (self.FNAEducationVC.required3.text.length == 0) {
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @" "
         message:@"Required Amount for Child 3 is required."
         delegate: self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         alert.tag = 9204;
         [alert show];
         //[alertStack addObject:alert];
         alert = Nil;
         return FALSE;
         }*/
        else if ([self.FNAEducationVC.required4.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9205;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        /*else if (self.FNAEducationVC.required4.text.length == 0) {
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle: @" "
         message:@"Required Amount for Child 4 is required."
         delegate: self
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         alert.tag = 9206;
         [alert show];
         //[alertStack addObject:alert];
         alert = Nil;
         return FALSE;
         }*/
        
        if (self.FNAEducationVC.required2.text.length != 0 && self.FNAEducationVC.required1.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 1 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if (self.FNAEducationVC.required3.text.length != 0 && self.FNAEducationVC.required2.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 2 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if (self.FNAEducationVC.required4.text.length != 0 && self.FNAEducationVC.required2.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 2 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if (self.FNAEducationVC.required4.text.length != 0 && self.FNAEducationVC.required3.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount for Child 3 is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9204;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
    }
    
    if ([self.FNAEducationVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Customer is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9206;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    if ([self.FNAEducationVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9206;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    
    /*
     if (self.FNAEducationVC.EducationSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"0"]){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Existing Children's Education Plan is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9200;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (!self.FNAEducationVC.EducationSelected){ //ignore first
     if ([self.FNAEducationVC.current1.text length] != 0 && [self.FNAEducationVC.required1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Required Amount is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9202;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if ([self.FNAEducationVC.customerAlloc.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Current Income allocation is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9205;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     }//ignore first
     
     
     
     else if ([self.FNAEducationVC.current1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Current Amount for Child 1 is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9201;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     else if ([self.FNAEducationVC.current1.text length] != 0 && [self.FNAEducationVC.required1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Required Amount is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9202;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
     
     }
     
     
     
     
     
     
     
     else if (([self.FNAEducationVC.current2.text length] != 0 && [self.FNAEducationVC.required2.text length] == 0) || ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9203;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (([self.FNAEducationVC.current3.text length] != 0 && [self.FNAEducationVC.required3.text length] == 0) || ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9204;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (([self.FNAEducationVC.current4.text length] != 0 && [self.FNAEducationVC.required4.text length] == 0) || ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9204;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     
     
     
     
     
     else if ([self.FNAEducationVC.customerAlloc.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Current Income allocation is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9205;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     */
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFSavings{
    if (self.FNASavingsVC.SavingsSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1"] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Savings and Investment Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9300;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if (!self.FNASavingsVC.SavingsSelected){
        if ([self.FNASavingsVC.required1.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9302;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNASavingsVC.required1.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9302;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNASavingsVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Customer is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9304;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNASavingsVC.customerAlloc.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9304;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
    }
    else if ([self.FNASavingsVC.current1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9301;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.current1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9301;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.current1.text length] != 0 && [self.FNASavingsVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9302;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9302;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Customer is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9304;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9304;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFProtection{
	pressSaveAll = FALSE;
    
    bool child1Current = [self.FNAProtectionVC.current1.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current1.text.length == 0;
    bool child2Current = [self.FNAProtectionVC.current2.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current2.text.length == 0;
    bool child3Current = [self.FNAProtectionVC.current3.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current3.text.length == 0;
    bool child4Current = [self.FNAProtectionVC.current4.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current4.text.length == 0;
    
    //bool child1Required = [self.FNAProtectionVC.required1.text isEqualToString:@"0.00"] || self.FNAProtectionVC.required1.text.length == 0;
    //bool child2Required = [self.FNAProtectionVC.required2.text isEqualToString:@"0.00"] || self.FNAProtectionVC.required2.text.length == 0;
    //bool child3Required = [self.FNAProtectionVC.required3.text isEqualToString:@"0.00"] || self.FNAProtectionVC.required3.text.length == 0;
    //bool child4Required = [self.FNAProtectionVC.required4.text isEqualToString:@"0.00"] || self.FNAProtectionVC.required4.text.length == 0;
	
	
    //    if ((self.FNAProtectionVC.ProtectionSelected) && ((self.FNAProtectionVC.current1.text.length == 0 && self.FNAProtectionVC.current2.text.length == 0 && self.FNAProtectionVC.current3.text.length == 0 && self.FNAProtectionVC.current4.text.length == 0 && self.FNAProtectionVC.required1.text.length == 0 && self.FNAProtectionVC.required2.text.length == 0 && self.FNAProtectionVC.required3.text.length == 0 && self.FNAProtectionVC.required4.text.length == 0))) {
	
	if ((self.FNAProtectionVC.ProtectionSelected) && [self.FNAProtectionVC.plan1.text isEqualToString:@"Add Existing Protection Plan (1)"] && (child1Current && child2Current && child3Current && child4Current)) {
        
        //	NSLog(@"SAVE BTN: %d", pressSaveAll);
        //	if ([self RecheckProtectionNeedValidation] && !pressSaveAll) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Existing Protection Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        
        //alert.tag = 9000;
        alert.tag = 6001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
        
    }
    
    
    if (self.FNAProtectionVC.ProtectionSelected && (child1Current && child2Current && child3Current && child4Current)){
        //        UIAlertView *alert = [[UIAlertView alloc]
        //                              initWithTitle: @" "
        //                              message:@"Please check Existing Protection's coverage."
        //                              delegate: self
        //                              cancelButtonTitle:@"OK"
        //                              otherButtonTitles:nil];
		UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        //alert.tag = 9000;
        alert.tag = 6001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
	
	NSLog(@"%d, %@, %d, %d, %d, %d", self.FNAProtectionVC.ProtectionSelected, self.FNAProtectionVC.plan1.text, child1Current, child2Current, child3Current, child4Current);
	if ((self.FNAProtectionVC.ProtectionSelected) && [self.FNAProtectionVC.plan1.text isEqualToString:@"Add Existing Protection Plan (1)"] && (!child1Current || !child2Current || !child3Current || !child4Current)) {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle: @" "
							  message:@"Existing Protection Plan is Required."
							  delegate: self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		
		[alert show];
		//[alertStack addObject:alert];
		alert = Nil;
		return FALSE;
		
	}
    
    
    /*
     else if ([self.FNAProtectionVC.current1.text isEqualToString:@"0.00"] && !self.FNAProtectionVC.ProtectionSelected){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @" "
     message:@"Please check Existing Protection's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     alert = Nil;
     return FALSE;
     }
     */
    else if (!self.FNAProtectionVC.ProtectionSelected){
        if ([self.FNAProtectionVC.required1.text length] == 0 && [self.FNAProtectionVC.required2.text length] == 0 && [self.FNAProtectionVC.required3.text length] == 0 && [self.FNAProtectionVC.required4.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"At least one Required Amount for Protection Plan is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            
            
            alert.tag = 9007;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9032;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required2.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9033;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required3.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9034;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required4.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9035;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Customer is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9006;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.customerAlloc.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimals points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9006;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.partnerAlloc.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimals points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9010;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9010;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.partnerAlloc.text length] != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Current Income allocation for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 9010;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return  FALSE;
        }
        else if ([self.FNAProtectionVC.partnerAlloc.text isEqualToString:@"0.00"] && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Allocate Income must be a numerical amount greater than 0 and maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 9010;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return  FALSE;
        }
    }
    
	
    else if ([self.FNAProtectionVC.current1.text length] == 0 && [self.FNAProtectionVC.current2.text length] == 0 && [self.FNAProtectionVC.current3.text length] == 0 && [self.FNAProtectionVC.current4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"At least one Current Amount for Protection Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        
        alert.tag = 9001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.current1.text length] != 0 && [self.FNAProtectionVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9002;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9032;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.current2.text length] != 0 && [self.FNAProtectionVC.required2.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9003;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required2.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9033;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required2.text length] != 0 && [self.FNAProtectionVC.current2.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9023;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.current3.text length] != 0 && [self.FNAProtectionVC.required3.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9004;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required3.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9034;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required3.text length] != 0 && [self.FNAProtectionVC.current3.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9024;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.current4.text length] != 0 && [self.FNAProtectionVC.required4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9005;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required4.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9035;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required4.text length] != 0 && [self.FNAProtectionVC.current4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9025;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Customer is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9006;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.customerAlloc.text isEqualToString:@"0.00"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9006;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text isEqualToString:@"0.00"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimals points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Partner/Spouse is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text isEqualToString:@"0.00"] && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text length] != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Current Income allocation for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return  FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text isEqualToString:@"0.00"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    NSLog(@"length: %d, partenr: %@", self.FNAProtectionVC.partnerAlloc.text.length, [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFRetirement{
    if (self.FNARetirementVC.RetirementSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Retirement Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9100;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if (!self.FNARetirementVC.RetirementSelected){
        if ([self.FNARetirementVC.required1.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required Amount is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9107;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9142;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Customer is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9106;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerAlloc.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9146;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Current income allocation for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9116;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.partnerAlloc.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9147;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerRely.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Source of income for Customer is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9117;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        else if ([self.FNARetirementVC.partnerRely.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //for partner --- //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Source of income for Partner/Spouse is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9118;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.partnerAlloc.text length] != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Current Income allocation for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 9116;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if (self.FNARetirementVC.partnerRely.text.length != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Source of Income for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 91162;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
    }
    else if ([self.FNARetirementVC.current1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9101;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.current1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current Amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9141;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.current1.text length] != 0 && [self.FNARetirementVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9102;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Required amount must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9142;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Customer is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9106;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9146;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Current income allocation for Partner/Spouse is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9116;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9147;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.customerRely.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Source of income for Customer is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9117;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.partnerRely.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Source of income for Partner/Spouse is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9118;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerAlloc.text length] != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Current Income allocation for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 9116;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerRely.text length] != 0 && !([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Source of Income for Partner/Spouse is not required as there is no Partner/Spouse attached." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 91162;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}



-(BOOL)validSecG{
    NSString *reasonP1;
    NSString *actionP1;
    
    NSString *additionalP2;
    NSString *reasonP2;
    
    
    
    reasonP1 = self.RecordVC.ReasonP1.text;
    actionP1 = self.RecordVC.ActionP1.text;
    
    additionalP2 = self.RecordVC.AdditionalBenefitsP2.text;
    reasonP2 = self.RecordVC.ReasonP2.text;
    
    if ([reasonP1 isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Reasons for recommending are required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if (reasonP1.length > 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Maximum number of characters for Reason for recommending is 200." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    if (actionP1.length > 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Maximum number of characters for Action taken if different from recommendations and reasons is 200." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 100011;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    
    //P2 needs validation
    if ([self.RecordVC.TypeOfPlanP2.text isEqualToString:@""] && [self.RecordVC.TermP2.text isEqualToString:@""] && ([self.RecordVC.SumAssuredP2.text isEqualToString:@""] || self.RecordVC.SumAssuredP2.text.length == 0) && [self.RecordVC.NameofInsuredP2.text isEqualToString:@""] && [reasonP2 isEqualToString:@""]){
        NSLog(@"assa");
    }
    else{
        if ([self.RecordVC.TypeOfPlanP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Type of Plan is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10002;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        if ([self.RecordVC.TermP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Term is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
		
		if ([textFields trimWhiteSpaces:self.RecordVC.NameofInsuredP2.text].length == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Name of insured is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10005;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if (self.RecordVC.NameofInsuredP2.text.length > 70) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Name of insured is too long. Maximum 70 characters."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10007;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ([textFields validateString:self.RecordVC.NameofInsuredP2.text]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Same alphabet cannot be repeated more than 3 times."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10007;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ([textFields validateString3:self.RecordVC.NameofInsuredP2.text]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10007;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
		
        if ([self.RecordVC.SumAssuredP2.text isEqualToString:@""] || self.RecordVC.SumAssuredP2.text == nil){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Sum Assured is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10004;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([self.RecordVC.SumAssuredP2.text isEqualToString:@"0.00"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Sum Assured must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10004;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        
        if ([reasonP2 isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Reasons for recommending are required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10006;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789,."] invertedSet];
        NSRange rangeofDotSUM = [self.RecordVC.SumAssuredP2.text rangeOfString:@"."];
        NSString *substringSUM = @"";
        if (rangeofDotSUM.location != NSNotFound) {
            substringSUM = [self.RecordVC.SumAssuredP2.text substringFromIndex:rangeofDotSUM.location ];
        }
        if (substringSUM.length > 3) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Sum Assured only allow 2 decimal places." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            alert.tag = 10004;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return  FALSE;
        }
        else if ([self.RecordVC.SumAssuredP2.text rangeOfCharacterFromSet:set].location != NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Sum Assured must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            alert.tag = 10004;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return  FALSE;
        }
    }
    
    //Priority 1
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameOfInsurerP1.text forKey:@"NameOfInsurerP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:reasonP1 forKey:@"ReasonP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:actionP1 forKey:@"ActionP1"];
    
    //Priority 2
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.TypeOfPlanP2.text forKey:@"TypeOfPlanP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.TermP2.text forKey:@"TermP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.SumAssuredP2.text forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameofInsurerP2.text forKey:@"NameOfInsurerP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameofInsuredP2.text forKey:@"NameOfInsuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:additionalP2 forKey:@"AdditionalP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:reasonP2 forKey:@"ReasonP2"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecH{
    if ([self.DeclareCFFVC.IntermediaryCodeContractDate.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Intermediary's Contract Date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *convertedDOB = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
    if (convertedDOB == nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid Date date format."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20003;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    //if (![self.DeclareCFFVC.IntermediaryCodeContractDate.text isEqualToString:@""]){
    if ([self.DeclareCFFVC.NameOfManager.text isEqualToString:@""]){
        NSDate *startDate = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
        NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
        NSDate *endDate = [fmtDate dateFromString:textDate];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        int day = [components day];
        // check if its leap year
        fmtDate = nil;
        fmtDate = [[NSDateFormatter alloc] init];
        [fmtDate setDateFormat:@"YYYY"];
        int currentYear = [[fmtDate stringFromDate:[NSDate date]] intValue];
        
        if (((currentYear % 4 == 0) && (currentYear % 100 != 0)) || (currentYear % 400 == 0)) {
            if (day > 366) {
                // More then 1 year do nothing
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Name of Manager is required for agent's with contract 1 year and below."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 20009;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        else {
            if (day > 365) {
                // more then 1 year do nothing
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Name of Manager is required for agent's with contract 1 year and below."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 20009;
                [alert show];
                //[alertStack addObject:alert];
                alert = Nil;
                return FALSE;
            }
        }
        
        if ([components day] <= 365){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Name of Manager is required for agent's with contract 1 year and below."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 20009;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if(self.DeclareCFFVC.NameOfManager.text.length != 0) {
            self.DeclareCFFVC.NameOfManager.text = @"";
            [self.myTableView reloadData];
        }
    }
    else if (![self.DeclareCFFVC.NameOfManager.text isEqualToString:@""]){
        NSDate *startDate = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
        NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
        NSDate *endDate = [fmtDate dateFromString:textDate];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        if ([components day] > 365){
            self.DeclareCFFVC.NameOfManager.text = @"";
            [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"Completed"];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden= TRUE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Name of Manager will be auro removed as NOT required for contract above 1 year." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 20010;
            //[alert show];
            alert = nil;
            return false;
        }
        else if ([textFields validateString:self.DeclareCFFVC.NameOfManager.text]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Same alphabet cannot be repeated more than 3 times."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 20009;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([textFields validateString3:self.DeclareCFFVC.NameOfManager.text]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 20009;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
        else if ([textFields validateString3:self.DeclareCFFVC.NameOfManager.text]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 20009;
            [alert show];
            //[alertStack addObject:alert];
            alert = Nil;
            return FALSE;
        }
    }
    
    
    //fmtDate = Nil;
    
    if ([self.DeclareCFFVC.IntermediaryCode.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@" "
                              message:@"Intermediary Code is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20012;
        [alert show];
        //[alertStack addObject:alert];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.NameOfIntermediary.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@" "
                              message:@"Name of intermediary is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20013;
        [alert show];
        //[alertStack addObject:alert];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.IntermediaryNRIC.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@" "
                              message:@"NRIC of intermediary is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20014;
        [alert show];
        //[alertStack addObject:alert];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.IntermediaryAddress1.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Address of intermediary is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20002;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.selected isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Customer's acknowledgement is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 21003;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryCodeContractDate.text forKey:@"IntermediaryCodeContractDate"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryCode.text forKey:@"IntermediaryCode"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.NameOfIntermediary.text forKey:@"NameOfIntermediary"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryNRIC.text forKey:@"IntermediaryNRIC"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress1.text forKey:@"IntermediaryAddress1"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress2.text forKey:@"IntermediaryAddress2"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress3.text forKey:@"IntermediaryAddress3"];
    //    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress4.text forKey:@"IntermediaryAddress4"];
	[[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryPostcode.text  forKey:@"IntermediaryPostcode"];
	[[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryTown.text forKey:@"IntermediaryTown"];
	[[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryState.text  forKey:@"IntermediaryState"];
	[[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryCountry.text  forKey:@"IntermediaryCountry"];
    
    NSString *combined_add4;
    combined_add4 = [NSString stringWithFormat:@"%@, %@, %@, %@", [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"]];
    [[obj.CFFData objectForKey:@"SecH"] setValue:combined_add4 forKey:@"IntermediaryAddress4"];
    
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.NameOfManager.text forKey:@"NameOfManager"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.selected forKey:@"CustomerAcknowledgement"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.AdditionalComment.text forKey:@"AdditionalComment"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(void)validSecHSpecial:(NSIndexPath *)indexPath {
    NSString *nameOfManager = self.DeclareCFFVC.NameOfManager.text;
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
    if (startDate == NULL) {
        startDate = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"]];
        nameOfManager = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"];
    }
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    specialIndex = indexPath;
    //
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    //    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    //    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    //    int lastId;
    //    if (![db open]) {
    //        NSLog(@"Could not open db.");
    //    }
    //
    //
    //    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    //    lastId = [[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"] intValue];
    //	NSLog(@"for CFF checked proposalNo:%@, lastID:%d", eProposalNo, lastId);
    //	if (!eApp)
    //		eProposalNo = @"";
    //	if (eProposalNo == NULL)
    //		eProposalNo = @"";
    //	if ([eProposalNo isEqualToString:@"(null)"])
    //		eProposalNo = @"";
    //    NSMutableArray *ProposalCount = [NSMutableArray array];
    //	int i;
    //	int count = 0;
    //    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo) FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and B.status in (2,6) and A.eProposalNo = B.ProposalNo", lastId]];
    //    while ([result next]) {
    //        eProposalNo = [result objectForColumnName:@"eProposalNo"];
    //        [ProposalCount insertObject: eProposalNo atIndex: count];
    //        count = count + 1;
    //    }
    //    count = [ProposalCount count];
    //    for (i = 0; i < count; i++)
    //        NSLog (@"PropsalNO %i = %@", i, [ProposalCount objectAtIndex: i]);
    
    if ([components day] > 365 && nameOfManager.length != 0) {
        NSLog(@"> 365 Alert");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Name of Manager will be auto removed as NOT required for contract above 1 year." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20010;
        [alert show];
        
        alert = nil;
    }
    else if ([components day] <= 365 && nameOfManager.length == 0 && indexPath.row != -3 && indexPath.section != -3 && ![[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"] && [[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Name of Manager is required for agent's with contract 1 year and below."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20009;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return;
    }
    else if (indexPath != NULL){
        
        if (indexPath.row == -1 && indexPath.section == -1) {
            //[Utility showAllert:@"Record saved successfully."];
			/*if (noAlert==NO && mainresult==2){
             confirmStatus=YES;
             [Utility showAllert:@"Changes have been updated successfully."];
             [[NSUserDefaults standardUserDefaults]setBool:confirmStatus forKey:@"confirmed"];
             [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             //[self deleteOldPdfs];
             }
             else if(!noAlert)
             [Utility showAllert:@"Record saved successfully."];*/
            
            //            if (mainresult==1){
            //
            //                confirmStatus=YES;
            //				[Utility showAllert:@"Changes have been updated successfully."];
            //				[[NSUserDefaults standardUserDefaults]setBool:confirmStatus forKey:@"confirmed"];
            //				[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
            //				[[NSUserDefaults standardUserDefaults] synchronize];
            //
            //            }
            //            else if(noAlert)
            //                [Utility showAllert:@"Record saved successfully."];
            
            
            
        }
        else if (indexPath.row == -3 && indexPath.section == -3) {
            [self dismissModalViewControllerAnimated:YES];
        }
        else if (specialIndex.section == -2 && specialIndex.row == -2) {
            // No need to do anything. Let the code to proceed.
            specialIndex = [NSIndexPath indexPathForRow:-4 inSection:-4];
        }
        [self.myTableView selectRowAtIndexPath:specialIndex animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self tableView:self.myTableView didSelectRowAtIndexPath:specialIndex];
    }
    else if (indexPath == NULL) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(BOOL)validSecI{
    
    if ([self.ConfirmCFFVC.Advice1 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice2 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice3 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice4 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice5 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice6 isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Either one of the financial goals is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 30001;
        [alert show];
        //[alertStack addObject:alert];
        alert = Nil;
        return FALSE;
    }
    else if ([self.ConfirmCFFVC.Advice6 isEqualToString:@"-1"] && self.ConfirmCFFVC.othersField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"The description for “Other” financial goal is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 30002;
        [alert show];
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice1 forKey:@"Advice1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice2 forKey:@"Advice2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice3 forKey:@"Advice3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice4 forKey:@"Advice4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice5 forKey:@"Advice5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice6 forKey:@"Advice6"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.othersField.text forKey:@"Advice6Others"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}
//To check the eapp and pop up the alert


-(void)shoeEappAlert{
    
	UIAlertView *alert;
    
	
	if (hasConfirmed){
		alert = [[UIAlertView alloc]initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    }
	else if(hasPOSign && !hasFailed)
	{
		alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        //		[alert show];
	}
	else if(hasPOSign && (!hasReceived))
	{
		alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        //		[alert show];
	}
    
	else if (!hasConfirmed){
        //	alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Changes will be updated to Created eApp cases. Do you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        
        /*  [[[UIAlertView alloc] initWithTitle:@" "
         message:@"Changes will be updated to Created eApp cases. Do you want to proceed?"
         cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
         // Handle "Cancel"
         
         
         
         }]
         otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
         // Handle "Delete"
         }], nil] show];*/
	}
	
	alert.tag = 99999;
    [alert show];
    alert = Nil;
}


//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 99999) {
//        if (buttonIndex  !=alertView.cancelButtonIndex) {
//			noAlert = YES;
//            mainresult=1;
//            checkEappAlertDone=YES;
//
//        }else
//        {
//			noAlert = NO;
//            checkEappAlertDone=YES;
//            mainresult=2;
//
//            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
//
//        }
//	}
//		if (buttonIndex == 0) {
//			checkEappAlertDone=YES;
//            mainresult=2;
//			}
//		else{
//			mainresult=2;
//            checkEappAlertDone=NO;
//		}

// }

//}
//To check the eapp and pop up the alert
-(void)executeInGB{
    checkEappAlertDone = NO;
    mainresult=0;
    // display UIAlertView in a method on main thread with -performSelectorOnMainThread:withObject:waitUntilDone:
    // if (condition==nil)
    // condition = [NSCondition new];
    [self performSelectorOnMainThread:@selector(shoeEappAlert) withObject:nil waitUntilDone:NO];
    //[condition lock];
    // while (! mainresult) [condition wait];
    // checkEappAlertDone = NO;
    // mainresult=0;
    // condition=nil;
    //[condition signal] ;
    // [condition unlock] ;
    // condition=nil;
    // NSLog(@"in bg end %i",mainresult);
    
    
    
    
    
    
}

-(void)saveCreateCFFForAlert:(FMDatabase *)db andtoSave:(int)toSave{
    //####### convert data desc to code
	NSString *Childen1Relationship = [self getRelationshipCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Relationship"]];
	NSString *Childen2Relationship = [self getRelationshipCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Relationship"]];
	NSString *Childen3Relationship = [self getRelationshipCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Relationship"]];
	NSString *Childen4Relationship = [self getRelationshipCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Relationship"]];
	NSString *Childen5Relationship = [self getRelationshipCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Relationship"]];
	
	//###### convert end here
    //To check the eapp and pop up the alert--Ending
    NSLog(@"$$$$$$$$$Data savede to database$$$$$$$$$$");
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"]);
    
    if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFCreate"] isEqualToString:@"1"]){
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@CFF_Master(ClientProfileID,CreatedAt,LastUpdatedAt,Status,CFFType) VALUES(?,?,?,?,?);", tableNamePrefix],[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientIndex"],commDate,commDate,@"0",@"Master",nil];
        
        lastId = [db lastInsertRowId];
        [[obj.CFFData objectForKey:@"CFF"] setValue:[NSString stringWithFormat:@"%d",lastId] forKey:@"lastId"];
        
        
        
        
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryAddrPostcode = '%@', IntermediaryAddrTown = '%@', IntermediaryAddrState = '%@', IntermediaryAddrCountry = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@', LastUpdatedAt = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"],[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], commDate, lastId];
        [db executeUpdate:query];
        
        
        
    }
    
	
    NSString *eProposalNo;
	
	eProposalNo = [[obj.eAppData objectForKey:@"EAPP" ] objectForKey:@"eProposalNo"];
	
    lastId = [[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"] intValue];
	NSLog(@"1) proposalNo:%@, lastID:%d", eProposalNo, lastId);
	if (!eApp)
		eProposalNo = @"";
	if (eProposalNo == NULL)
		eProposalNo = @"";
	if ([eProposalNo isEqualToString:@"(null)"])
		eProposalNo = @"";
	
	//Check when edit CFF, if CFF already used in eApplication, get eProposalNo
    //	if (!eApp) {
    //		FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT eProposalNo FROM eProposal_CFF_MASTER WHERE ID = %d", lastId]];
    //			if ([result next]) {
    //				eProposalNo = [result objectForColumnName:@"eProposalNo"];
    //		}
    //	}
	
	NSLog(@"2) proposalNo:%@, lastID:%d", eProposalNo, lastId);
	
	NSMutableArray *ProposalCount = [NSMutableArray array];
	int i;
	int count = 0;
	//Check when edit CFF, if CFF already used in eApplication, get eProposalNo, get only created/failed proposal only.
	if (!eApp) {
		//FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo) FROM eProposal_CFF_MASTER WHERE ID = %d", lastId]];
        //		FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo) FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and B.status in (2,6) and A.eProposalNo = B.ProposalNo", lastId]];
		FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo) FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and B.status in (2,3) and A.eProposalNo = B.ProposalNo", lastId]];
		while ([result next]) {
			eProposalNo = [result objectForColumnName:@"eProposalNo"];
			[ProposalCount insertObject: eProposalNo atIndex: count];
			count = count + 1;
			ClearData *ClData =[[ClearData alloc]init];
			[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

		}
		count = [ProposalCount count];
		for (i = 0; i < count; i++)
			NSLog (@"PropsalNO %i = %@", i, [ProposalCount objectAtIndex: i]);
	}
	
	if (eApp){
		count = 0;
		eProposalNo = [[obj.eAppData objectForKey:@"EAPP" ] objectForKey:@"eProposalNo"];
		
		NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
		NSDate *currDate = [NSDate date];
		[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
		NSString *dateString = [dateFormatter2 stringFromDate:currDate];
		
		NSString *queryB = @"";
		queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, eProposalNo];
		[db executeUpdate:queryB];
	}
    
    if (eApp) {
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM eProposal_CFF_MASTER WHERE eProposalNo = %@", eProposalNo]];
        if (![result next]) {
            [db executeUpdate:@"INSERT INTO eProposal_CFF_Master(ID, eProposalNo,ClientProfileID,CreatedAt,LastUpdatedAt,Status,CFFType) VALUES(?,?,?,?,?,?,?);", [NSString stringWithFormat:@"%d",lastId],eProposalNo, [[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientIndex"],commDate,commDate,@"0",@"Master",nil];
        }
        
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryAddrPostcode = '%@', IntermediaryAddrTown = '%@', IntermediaryAddrState = '%@', IntermediaryAddrCoutry = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d AND eProposalNo = %@", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId, eProposalNo];
        [db executeUpdate:query];
    }
	else if (!eApp) {
		//Update lastUpdateAt for eProposal_CFF_master when there change in CFF
		
		NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE CFF_Master SET LastUpdatedAt = '%@' where ID = '%@'", commDate, [NSString stringWithFormat:@"%d",lastId]];
		[db executeUpdate:query];
		query = @"";
		if (count>0) {
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET LastUpdatedAt = '%@' where ID = '%@' and eProposalNo = '%@'", commDate, [NSString stringWithFormat:@"%d",lastId],eProposalNo];
				[db executeUpdate:query];
			}
		}
	}
    
    //section A
    if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
		
		NSLog(@"Update %@",tableNamePrefix);
		if (!eApp) {
			query = [NSString stringWithFormat:@"UPDATE CFF_Master SET IntermediaryStatus= '%@', BrokerName = '%@' WHERE ID = %d",  [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"],[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"],lastId];
			[db executeUpdate:query];
			if (count>0) {
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryStatus= '%@', BrokerName = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"],[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"],lastId];
					[db executeUpdate:query];
				}
			}
		}
		if (eApp) {
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryStatus= '%@', BrokerName = '%@' WHERE ID = %d and eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"],[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"],lastId, eProposalNo];
			[db executeUpdate:query];
        }
    }
    
    //section B
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
		if (!eApp) {
            query = [NSString stringWithFormat:@"UPDATE CFF_Master SET ClientChoice= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"],lastId];
            [db executeUpdate:query];
			if (count>0) {
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET ClientChoice= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"],lastId];
					[db executeUpdate:query];
					NSLog(@"%d) proposalNo:%@, lastID:%d",i, eProposalNo, lastId);
				}
			}
			
		}
		if (eApp) {
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET ClientChoice= '%@' WHERE ID = %d and eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"],lastId, eProposalNo];
            [db executeUpdate:query];
		}
    }
    
    //section C
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        //NSLog(@"afasfasf");
		
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Personal_Details WHERE CFFID = %@ AND PTypeCode = %@", [NSString stringWithFormat:@"%d", lastId], @"1"]];
			if (count > 0){
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Personal_Details WHERE CFFID = '%@' AND PTypeCode = '%@' AND eProposalNo = '%@'", [NSString stringWithFormat:@"%d", lastId], @"1", eProposalNo]];
			}
		}
		else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Personal_Details WHERE CFFID = '%@' and eProposalNo = '%@' AND PTypeCode = '%@'", [NSString stringWithFormat:@"%d", lastId], eProposalNo, @"1"]];
		}
		
        if (!eApp) {
            [db executeUpdate:@"INSERT INTO CFF_Personal_Details(CFFID, Title, Name, NewICNo, OtherIDType, OtherID, Nationality, Race, Religion, Sex, Smoker, DOB, Age, MaritalStatus, OccupationCode, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, PermanentForeignAddressFlag, PermanentAddress1, PermanentAddress2, PermanentAddress3, PermanentTown, PermanentState, PermanentPostCode, PermanentCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, PTypeCode, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], [self getTitleCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerAge"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOccupationCode"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"], @"1",nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					
					[db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, eProposalNo, Title, Name, NewICNo, OtherIDType, OtherID, Nationality, Race, Religion, Sex, Smoker, DOB, Age, MaritalStatus, OccupationCode, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, PermanentForeignAddressFlag, PermanentAddress1, PermanentAddress2, PermanentAddress3, PermanentTown, PermanentState, PermanentPostCode, PermanentCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, PTypeCode, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], eProposalNo, [self getTitleCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerAge"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOccupationCode"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"], @"1",nil];
				}
			}
        }
        if (eApp) {
            
            [db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, eProposalNo, Title, Name, NewICNo, OtherIDType, OtherID, Nationality, Race, Religion, Sex, Smoker, DOB, Age, MaritalStatus, OccupationCode, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, PermanentForeignAddressFlag, PermanentAddress1, PermanentAddress2, PermanentAddress3, PermanentTown, PermanentState, PermanentPostCode, PermanentCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, PTypeCode, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], eProposalNo, [self getTitleCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerAge"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOccupationCode"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"], @"1",nil];
        }
        //		if (eApp) {
        //            [db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, Title, Name, NewICNo, OtherIDType, OtherID, Nationality, Race, Religion, Sex, Smoker, DOB, Age, MaritalStatus, OccupationCode, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, PermanentForeignAddressFlag, PermanentAddress1, PermanentAddress2, PermanentAddress3, PermanentTown, PermanentState, PermanentPostCode, PermanentCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, PTypeCode, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerAge"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOccupationCode"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PermanentMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"], @"1",nil];
        //		}
        
        NSLog(@"error: %@", [db lastErrorMessage]);
        
        NSString *query = @"";
		
		if (!eApp) {
            query = [NSString stringWithFormat:@"UPDATE CFF_Master SET PartnerClientProfileID = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"],lastId];
            [db executeUpdate:query];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET PartnerClientProfileID = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"],lastId];
					[db executeUpdate:query];
				}
			}
        }
		if (eApp) {
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET PartnerClientProfileID = '%@' WHERE ID = %d and eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"],lastId, eProposalNo];
            [db executeUpdate:query];
		}
        // insert partner data
		if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@CFF_Personal_Details WHERE CFFID = '%@' AND PTypeCode = %@", tableNamePrefix, [NSString stringWithFormat:@"%d", lastId], @"2"]];
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Personal_Details WHERE CFFID = %@ AND eProposalNo = '%@' AND PTypeCode = %@", [NSString stringWithFormat:@"%d", lastId], eProposalNo, @"2"]];
				}
			}
		}
		if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Personal_Details WHERE CFFID = %@ AND eProposalNo = '%@' AND PTypeCode = %@", [NSString stringWithFormat:@"%d", lastId], eProposalNo, @"2"]];
		}
		
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]) {
            if (!eApp) {
                [db executeUpdate:@"INSERT INTO CFF_Personal_Details(CFFID, PTypeCode, Title, Name, NewICNo, OtherIDType, OtherID, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], @"2", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerTitle"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"] passdb:db],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerEmail"],nil];
                NSLog(@"Error: %@", [db lastErrorMessage]);
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						
						[db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, eProposalNo, PTypeCode, Title, Name, NewICNo, OtherIDType, OtherID, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], eProposalNo, @"2", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerTitle"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"] passdb:db],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerEmail"],nil];
						NSLog(@"Error: %@", [db lastErrorMessage]);
					}
				}
            }
			if (eApp) {
                
                //                [db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, PTypeCode, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId], @"2", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"] passdb:db],nil];
				[db executeUpdate:@"INSERT INTO eProposal_CFF_Personal_Details(CFFID, eProposalNo, PTypeCode, Title, Name, NewICNo, OtherIDType, OtherID, MailingForeignAddressFlag, MailingAddress1, MailingAddress2, MailingAddress3, MailingTown, MailingState, MailingPostCode, MailingCountry, PermanentForeignAddressFlag, PermanentAddress1, PermanentAddress2, PermanentAddress3, PermanentTown, PermanentState, PermanentPostCode, PermanentCountry, ResidencePhoneNoExt, ResidencePhoneNo, OfficePhoneNoExt, OfficePhoneNo, MobilePhoneNoExt, MobilePhoneNo, FaxPhoneNoExt, FaxPhoneNo, EmailAddress, LastUpdated) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,datetime('now', '+8 hour'));", [NSString stringWithFormat:@"%d", lastId],
				 eProposalNo, @"2",
				 [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerTitle"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNRIC"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"] passdb:db], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressForeign"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress1"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress2"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress3"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressTown"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressState"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentPostcode"], [self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressCountry"] passdb:db],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTelExt"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTel"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerEmail"],nil];
                NSLog(@"Error: %@", [db lastErrorMessage]);
                
            }
        }
        
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@CFF_Family_Details WHERE CFFID = '%d'", tableNamePrefix,lastId]];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Family_Details WHERE CFFID = '%d'",lastId]];
				}
			}
		}
		if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Family_Details WHERE CFFID = '%d' and eProposalNo = '%@'",lastId, eProposalNo]];
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport, ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"],Childen1Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1ClientProfileID"], Nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"],Childen1Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1ClientProfileID"], Nil];
					}
				}
            }
            if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"],Childen1Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"], [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1ClientProfileID"], Nil];
            }
            
        }
		
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"], Childen2Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2ClientProfileID"],Nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"], Childen2Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2ClientProfileID"],Nil];
					}
				}
            }
            else if (eApp) {
                //if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"], Childen2Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2ClientProfileID"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"], Childen3Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3ClientProfileID"],Nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"], Childen3Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3ClientProfileID"],Nil];
					}
				}
            }
            else if (eApp) {
                //if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"], Childen3Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3ClientProfileID"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"], Childen4Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4ClientProfileID"],Nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"], Childen4Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4ClientProfileID"],Nil];
					}
				}
            }
            else if (eApp) {
                //if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"], Childen4Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4ClientProfileID"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"], Childen5Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5ClientProfileID"],Nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo,CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"], Childen5Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5ClientProfileID"],Nil];
					}
				}
            }
            else if (eApp) {
                //if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo,CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport,ClientProfileID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5addFromCFF"],@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"], Childen5Relationship,[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5ClientProfileID"],Nil];
            }
            
        }
        
    }
    
	
	if (!eApp) {
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				[self CheckRelationEAPP:eProposalNo database:db];
			}
		}
	}
	
    //section D
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
		
		if (!eApp) {
            NSString *query = @"";
            query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET NeedsQ1_Ans1 = '%@', NeedsQ1_Ans2 = '%@', NeedsQ1_Priority = '%@', NeedsQ2_Ans1 = '%@', NeedsQ2_Ans2 = '%@', NeedsQ2_Priority = '%@', NeedsQ3_Ans1 = '%@', NeedsQ3_Ans2 = '%@', NeedsQ3_Priority = '%@', NeedsQ4_Ans1 = '%@', NeedsQ4_Ans2 = '%@', NeedsQ4_Priority = '%@', NeedsQ5_Ans1 = '%@', NeedsQ5_Ans2 = '%@', NeedsQ5_Priority = '%@' WHERE ID = %d", tableNamePrefix,[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"],[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"], lastId];
            [db executeUpdate:query];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSString *query = @"";
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET NeedsQ1_Ans1 = '%@', NeedsQ1_Ans2 = '%@', NeedsQ1_Priority = '%@', NeedsQ2_Ans1 = '%@', NeedsQ2_Ans2 = '%@', NeedsQ2_Priority = '%@', NeedsQ3_Ans1 = '%@', NeedsQ3_Ans2 = '%@', NeedsQ3_Priority = '%@', NeedsQ4_Ans1 = '%@', NeedsQ4_Ans2 = '%@', NeedsQ4_Priority = '%@', NeedsQ5_Ans1 = '%@', NeedsQ5_Ans2 = '%@', NeedsQ5_Priority = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"],[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"], lastId];
					[db executeUpdate:query];
				}
			}
		}
		else if (eApp) {
            NSString *query = @"";
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET NeedsQ1_Ans1 = '%@', NeedsQ1_Ans2 = '%@', NeedsQ1_Priority = '%@', NeedsQ2_Ans1 = '%@', NeedsQ2_Ans2 = '%@', NeedsQ2_Priority = '%@', NeedsQ3_Ans1 = '%@', NeedsQ3_Ans2 = '%@', NeedsQ3_Priority = '%@', NeedsQ4_Ans1 = '%@', NeedsQ4_Ans2 = '%@', NeedsQ4_Priority = '%@', NeedsQ5_Ans1 = '%@', NeedsQ5_Ans2 = '%@', NeedsQ5_Priority = '%@' WHERE ID = %d and eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"],[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"], lastId, eProposalNo];
            [db executeUpdate:query];
		}
    }
	
	else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"0"]){
		
		if (!eApp) {
			NSString *query = @"";
			query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET NeedsQ1_Ans1 = '', NeedsQ1_Ans2 = '', NeedsQ1_Priority = '', NeedsQ2_Ans1 = '', NeedsQ2_Ans2 = '', NeedsQ2_Priority = '', NeedsQ3_Ans1 = '', NeedsQ3_Ans2 = '', NeedsQ3_Priority = '', NeedsQ4_Ans1 = '', NeedsQ4_Ans2 = '', NeedsQ4_Priority = '', NeedsQ5_Ans1 = '', NeedsQ5_Ans2 = '', NeedsQ5_Priority = '' WHERE ID = %d", tableNamePrefix, lastId];
			[db executeUpdate:query];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSString *query = @"";
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET NeedsQ1_Ans1 = '', NeedsQ1_Ans2 = '', NeedsQ1_Priority = '', NeedsQ2_Ans1 = '', NeedsQ2_Ans2 = '', NeedsQ2_Priority = '', NeedsQ3_Ans1 = '', NeedsQ3_Ans2 = '', NeedsQ3_Priority = '', NeedsQ4_Ans1 = '', NeedsQ4_Ans2 = '', NeedsQ4_Priority = '', NeedsQ5_Ans1 = '', NeedsQ5_Ans2 = '', NeedsQ5_Priority = '' WHERE ID = %d", lastId];
					[db executeUpdate:query];
				}
			}
		}
		else if (eApp) {
			NSString *query = @"";
			query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET NeedsQ1_Ans1 = '', NeedsQ1_Ans2 = '', NeedsQ1_Priority = '', NeedsQ2_Ans1 = '', NeedsQ2_Ans2 = '', NeedsQ2_Priority = '', NeedsQ3_Ans1 = '', NeedsQ3_Ans2 = '', NeedsQ3_Priority = '', NeedsQ4_Ans1 = '', NeedsQ4_Ans2 = '', NeedsQ4_Priority = '', NeedsQ5_Ans1 = '', NeedsQ5_Ans2 = '', NeedsQ5_Priority = '' WHERE ID = %d and eProposalNo = '%@'", lastId, eProposalNo];
			[db executeUpdate:query];
		}
    }
    
    //section E
    if ([[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]){
		if (!eApp) {
			NSString *query = @"";
			query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET RiskReturnProfile = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"],lastId];
			NSLog(@"query: %@", query);
			[db executeUpdate:query];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSString *query = @"";
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET RiskReturnProfile = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"],lastId];
					NSLog(@"query: %@", query);
					[db executeUpdate:query];
				}
			}
		}
		else if (eApp) {
            NSString *query = @"";
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET RiskReturnProfile = '%@' WHERE ID = %d and eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"],lastId, eProposalNo];
            NSLog(@"query: %@", query);
            [db executeUpdate:query];
		}
    }
    
    
    //section F Protection
    NSLog(@"save Protection");
    //if ([[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"]){
    //0 tick
    //-1 not tick
    if (!eApp) {
        [db executeUpdate:@"DELETE FROM CFF_Protection WHERE CFFID = ?", [NSString stringWithFormat:@"%d",lastId]];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection(CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,TotalSA_CurrentAmt,TotalSA_RequiredAmt,TotalSA_SurplusShortFall,TotalCISA_CurrentAmt,TotalCISA_RequiredAmt,TotalCISA_SurplusShortFall,TotalHB_CurrentAmt,TotalHB_RequiredAmt,TotalHB_SurplusShortFall,TotalPA_CurrentAmt,TotalPA_RequiredAmt,TotalPA_SurplusShortFall) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"]];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
		
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				NSLog(@"eApp save Protection");
				NSLog(@"CFFID: %d, eProposalNo: %@", lastId, eProposalNo);
				[db executeUpdate:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?", [NSString stringWithFormat:@"%d",lastId], eProposalNo];
				NSLog(@"protection error1: %@", [db lastErrorMessage]);
				[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,TotalSA_CurrentAmt,TotalSA_RequiredAmt,TotalSA_SurplusShortFall,TotalCISA_CurrentAmt,TotalCISA_RequiredAmt,TotalCISA_SurplusShortFall,TotalHB_CurrentAmt,TotalHB_RequiredAmt,TotalHB_SurplusShortFall,TotalPA_CurrentAmt,TotalPA_RequiredAmt,TotalPA_SurplusShortFall) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"]];
				NSLog(@"protection error2: %@", [db lastErrorMessage]);
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
				NSLog(@"delete1 db error: %@", [db lastErrorMessage]);
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
				NSLog(@"delete2 db error: %@", [db lastErrorMessage]);
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
				NSLog(@"delete3 db error: %@", [db lastErrorMessage]);
			}
		}
    }
    else if (eApp) {
        //if (eApp) {
        NSLog(@"eApp save Protection");
		NSLog(@"CFFID: %d, eProposalNo: %@", lastId, eProposalNo);
        [db executeUpdate:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?", [NSString stringWithFormat:@"%d",lastId], eProposalNo];
        NSLog(@"protection error1: %@", [db lastErrorMessage]);
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,TotalSA_CurrentAmt,TotalSA_RequiredAmt,TotalSA_SurplusShortFall,TotalCISA_CurrentAmt,TotalCISA_RequiredAmt,TotalCISA_SurplusShortFall,TotalHB_CurrentAmt,TotalHB_RequiredAmt,TotalHB_SurplusShortFall,TotalPA_CurrentAmt,TotalPA_RequiredAmt,TotalPA_SurplusShortFall) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"]];
        NSLog(@"protection error2: %@", [db lastErrorMessage]);
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
		NSLog(@"delete1 db error: %@", [db lastErrorMessage]);
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
		NSLog(@"delete2 db error: %@", [db lastErrorMessage]);
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
		NSLog(@"delete3 db error: %@", [db lastErrorMessage]);
    }
    
    
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"]];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID,eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"]];
					NSLog(@"insert eProposal_CFF_Protection_Details error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID,eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"]];
			NSLog(@"insert eProposal_CFF_Protection_Details error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"]];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID,eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"]];
					NSLog(@"insert eProposal_CFF_Protection_Details 2 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID,eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"]];
			NSLog(@"insert eProposal_CFF_Protection_Details 2 error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"]];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID, eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"]];
					NSLog(@"insert eProposal_CFF_Protection_Details 3 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(CFFID, eProposalNo, SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId], eProposalNo, @"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"]];
			NSLog(@"insert eProposal_CFF_Protection_Details 3 error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"] isEqualToString:@"-1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProsolaNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProsolaNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
        
    }
    
    if (self.CustomerVC.checkboxButton3.selected){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d", lastId], eProposalNo];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo, Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo, Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo, Nil];
				}
			}
        }
        //else if (eApp) {
		if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d", lastId], eProposalNo];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo, Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo, Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo, Nil];
        }
        
    }
    
    //}
    
    //if ([[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"]){
    if (!eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement(CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,CurrentAmt,RequiredAmt,SurplusShortFallAmt,OtherIncome_1,OtherIncome_2) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"]];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
		
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement WHERE CFFID = ? and eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
				
				[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,CurrentAmt,RequiredAmt,SurplusShortFallAmt,OtherIncome_1,OtherIncome_2) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"]];
				
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
			}
		}
    }
    else if (eApp) {
        //if (eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,CurrentAmt,RequiredAmt,SurplusShortFallAmt,OtherIncome_1,OtherIncome_2) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"]];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
    }
    
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"],Nil];
					NSLog(@"insert eProposal_CFF_Retirement_Details 1 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"],Nil];
			NSLog(@"insert eProposal_CFF_Retirement_Details 1 error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"], Nil];
					NSLog(@"insert eProposal_CFF_Retirement_Details 2 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"], Nil];
			NSLog(@"insert eProposal_CFF_Retirement_Details 2 error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"],Nil];
					NSLog(@"insert eProposal_CFF_Retirement_Details 3 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"],Nil];
			NSLog(@"insert eProposal_CFF_Retirement_Details 3 error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"] isEqualToString:@"-1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2", eProposalNo, Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3", eProposalNo, Nil];
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2", eProposalNo, Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3", eProposalNo, Nil];
        }
        
    }
    
    if (self.CustomerVC.checkboxButton3.selected){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
        
    }
    //}
    
    //section F Education
    //if ([[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"]){
    if (!eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education(CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"]];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
		
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? and eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
				
				[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"]];
				
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
			}
		}
    }
    else if (eApp) {
        //if (eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? and eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"]];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"],Nil];
					NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
				}
			}
        }
        //else if (eApp) {
		if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"],Nil];
			NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
			
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSLog(@"BBB %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"]);
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"],Nil];
					NSLog(@"eProposal_CFF_Education_Details 2 error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
			NSLog(@"BBB %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"]);
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"],Nil];
			NSLog(@"eProposal_CFF_Education_Details 2 error: %@", [db lastErrorMessage]);
        }
        
    }
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"],Nil];
					NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"],Nil];
			NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"4",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"4",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"],Nil];
					NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
				}
			}
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"4",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"],Nil];
			NSLog(@"eProposal_CFF_Education_Details error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"] isEqualToString:@"-1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"] isEqualToString:@"-1"]){
        
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education(CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],@"0",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
					
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],@"0",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",Nil];
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],@"0",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",Nil];
        }
    }
    
    if (self.CustomerVC.checkboxButton3.selected){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
        }
        
    }
    //}
    
    //if ([[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]){
    if (!eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest(CFFID,NoExistingPlan,CurrentAmt,RequiredAmt,SurplusShortFallAmt,AllocateIncome_1) VALUES(?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCustomerAlloc"],Nil];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
		
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
				
				[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest(eProposalNo,CFFID,NoExistingPlan,CurrentAmt,RequiredAmt,SurplusShortFallAmt,AllocateIncome_1) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCustomerAlloc"],Nil];
				
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
				[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
			}
		}
        
    }
    else if (eApp) {
        //if (eApp) {
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE CFFID = ? and eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
        
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest(eProposalNo,CFFID,NoExistingPlan,CurrentAmt,RequiredAmt,SurplusShortFallAmt,AllocateIncome_1) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCustomerAlloc"],Nil];
        
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
		
    }
    
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"],Nil];
					NSLog(@"eProposal_CFF_SavingsInvest_Details DB error: %@", [db lastErrorMessage]);
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"],Nil];
			NSLog(@"eProposal_CFF_SavingsInvest_Details DB error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"],Nil];
					NSLog(@"eProposal_CFF_SavingsInvest_Details2 DB error: %@", [db lastErrorMessage]);
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"],Nil];
			NSLog(@"eProposal_CFF_SavingsInvest_Details2 DB error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"],Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"],Nil];
					NSLog(@"eProposal_CFF_SavingsInvest_Details 3 DB error: %@", [db lastErrorMessage]);
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"],Nil];
			NSLog(@"eProposal_CFF_SavingsInvest_Details 3 DB error: %@", [db lastErrorMessage]);
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"] isEqualToString:@"-1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
    }
    // PLEASE CHECK HERE LATER. SEEM WEIRD.. SOMETHING MISSING ####EMI-----
    if (self.CustomerVC.checkboxButton3.selected){
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
        [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
    }
    //}
    
    //section G
    if ([[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_RecordOfAdvice WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice(CFFID,SameAsQuotation,Priority,InsurerName,ReasonRecommend,ActionRemark) VALUES(?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"1",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice(CFFID,SameAsQuotation,Priority,PlanType,Term,InsurerName,InsuredName,SumAssured,ReasonRecommend) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"0",@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"],nil];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
					
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,InsurerName,ReasonRecommend,ActionRemark) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"-1",@"1",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"],nil];
					if (![[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"] isEqualToString:@""]) {
                        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,PlanType,Term,InsurerName,InsuredName,SumAssured,ReasonRecommend) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"0",@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"],nil];
                    }
                    
				}
			}
            
        }
        else if (eApp) {
            //if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,InsurerName,ReasonRecommend,ActionRemark) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"-1",@"1",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"],nil];
            
            if (![[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"] isEqualToString:@""]) {
                
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,PlanType,Term,InsurerName,InsuredName,SumAssured,ReasonRecommend) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"0",@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"],nil];
            }
        }
        
        
        if (![[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"] isEqualToString:@""]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_RecordOfAdvice_Rider WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice_Rider(CFFID,Priority,RiderName,Seq) VALUES(?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"],@"1",nil];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice_Rider WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
						[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice_Rider(eProposalNo,CFFID,Priority,RiderName,Seq) VALUES(?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"],@"1",nil];
					}
				}
            }
            else if (eApp) {
                //if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice_Rider WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice_Rider(eProposalNo,CFFID,Priority,RiderName,Seq) VALUES(?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"],@"1",nil];
            }
        }
    }
    
    //section H
    if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]){
		if (!eApp) {
			NSString *query = @"";
			query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryAddrPostcode = '%@', IntermediaryAddrTown = '%@', IntermediaryAddrState = '%@', IntermediaryAddrCountry = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId];
			[db executeUpdate:query];
			
			if (count>0){
				for (i = 0; i < count; i++) {
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSString *query = @"";
					query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@',  IntermediaryAddrPostcode = '%@', IntermediaryAddrTown = '%@', IntermediaryAddrState = '%@', IntermediaryAddrCountry = '%@',  IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"],[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId];
					[db executeUpdate:query];
				}
			}
		}
		else if (eApp) {
			NSString *query = @"";
			query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@',  IntermediaryAddrPostcode = '%@', IntermediaryAddrTown = '%@', IntermediaryAddrState = '%@', IntermediaryAddrCountry = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryPostcode"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryTown"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryState"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryCountry"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId];
			[db executeUpdate:query];
		}
    }
    
    //section I
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
			
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_CA WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_CA(CFFID,Choice1,Choice2,Choice3,Choice4,Choice5,Choice6,Choices6Desc) VALUES(?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_CA_RECOMMENDATION WHERE CFFID = ?"], [NSString stringWithFormat:@"%d", lastId]];
            [db executeUpdate:@"DELETE FROM CFF_CA_RECOMMENDATION WHERE CFFID = ?", [NSString stringWithFormat:@"%d", lastId]];
            
            for (int i = 1; i < 6; i++) {
                NSString *existing = [[NSString alloc] initWithFormat:@"ExistingRecommended%i", i];
                NSString *strId = [[NSString alloc] initWithFormat:@"%d", lastId];
                NSString *insured = [[NSString alloc] initWithFormat:@"NameOfInsured%d", i];
                NSString *plan = [[NSString alloc] initWithFormat:@"ProductType%d", i];
                NSString *term = [[NSString alloc] initWithFormat:@"Term%d", i];
                NSString *premium = [[NSString alloc] initWithFormat:@"Premium%d", i];
                NSString *frequency = [[NSString alloc] initWithFormat:@"Frequency%d", i];
                NSString *sa = [[NSString alloc] initWithFormat:@"SumAssured%d", i];
                NSString *bought = [[NSString alloc] initWithFormat:@"Brought%d", i];
                NSString *benefits = [[NSString alloc] initWithFormat:@"AdditionalBenefit%d", i];
                NSString *seq = [[NSString alloc] initWithFormat:@"%d", i];
                NSString *addNew = @"True";
                
                if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:existing] isEqualToString:@"1"]) {
                    [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_CA_RECOMMENDATION(CFFID, InsuredName, PlanType, Term, Premium, Frequency, SumAssured, BoughtOption, AddNew, Seq) VALUES(?,?,?,?,?,?,?,?,?,?);"], strId, [[obj.CFFData objectForKey:@"SecI"] objectForKey:insured], [[obj.CFFData objectForKey:@"SecI"] objectForKey:plan], [[obj.CFFData objectForKey:@"SecI"] objectForKey:term], [[obj.CFFData objectForKey:@"SecI"] objectForKey:premium], [[obj.CFFData objectForKey:@"SecI"] objectForKey:frequency], [[obj.CFFData objectForKey:@"SecI"] objectForKey:sa], [[obj.CFFData objectForKey:@"SecI"] objectForKey:bought], addNew, seq, nil];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION_RIDER(CFFID, Seq, RiderName) VALUES (?,?,?);", [NSString stringWithFormat:@"%d", lastId], [NSString stringWithFormat:@"%d", i], [[obj.CFFData objectForKey:@"SecI"] objectForKey:benefits]];
                }
            }
			
			if (count>0){
				for (i = 0; i < count; i++){
					eProposalNo = [ProposalCount objectAtIndex: i];
					NSLog(@"SecI ProposalNo %d, %@",i, eProposalNo);
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
					
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA(eProposalNo,CFFID,Choice1,Choice2,Choice3,Choice4,Choice5,Choice6,Choices6Desc) VALUES(?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],nil];
					
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA_RECOMMENDATION WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d", lastId], eProposalNo];
					[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA_RECOMMENDATION_RIDER WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d", lastId], eProposalNo];
					
					for (int i = 1; i < 6; i++) {
						NSString *existing = [[NSString alloc] initWithFormat:@"ExistingRecommended%i", i];
						NSString *strId = [[NSString alloc] initWithFormat:@"%d", lastId];
						NSString *insured = [[NSString alloc] initWithFormat:@"NameOfInsured%d", i];
						NSString *plan = [[NSString alloc] initWithFormat:@"ProductType%d", i];
						NSString *term = [[NSString alloc] initWithFormat:@"Term%d", i];
						NSString *premium = [[NSString alloc] initWithFormat:@"Premium%d", i];
						NSString *frequency = [[NSString alloc] initWithFormat:@"Frequency%d", i];
						NSString *sa = [[NSString alloc] initWithFormat:@"SumAssured%d", i];
						NSString *bought = [[NSString alloc] initWithFormat:@"Brought%d", i];
						NSString *benefits = [[NSString alloc] initWithFormat:@"AdditionalBenefit%d", i];
						NSString *seq = [[NSString alloc] initWithFormat:@"%d", i];
						NSString *addNew = @"True";
						
						if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:existing] isEqualToString:@"1"]) {
							
							[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION(eProposalNo,CFFID, InsuredName, PlanType, Term, Premium, Frequency, SumAssured, BoughtOption, AddNew, seq) VALUES(?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, strId, [[obj.CFFData objectForKey:@"SecI"] objectForKey:insured], [[obj.CFFData objectForKey:@"SecI"] objectForKey:plan], [[obj.CFFData objectForKey:@"SecI"] objectForKey:term], [[obj.CFFData objectForKey:@"SecI"] objectForKey:premium], [[obj.CFFData objectForKey:@"SecI"] objectForKey:frequency], [[obj.CFFData objectForKey:@"SecI"] objectForKey:sa], [[obj.CFFData objectForKey:@"SecI"] objectForKey:bought], addNew, seq, nil];
							NSLog(@"eProposal_CFF_CA_RECOMMENDATION DB error: %@", [db lastErrorMessage]);
							[db executeUpdate:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION_RIDER(eProposalNo, CFFID, Seq, RiderName) VALUES (?,?,?,?);",  eProposalNo, [NSString stringWithFormat:@"%d", lastId], [NSString stringWithFormat:@"%d", i], [[obj.CFFData objectForKey:@"SecI"] objectForKey:benefits]];
							NSLog(@"eProposal_CFF_CA_RECOMMENDATION_RIDER DB error: %@", [db lastErrorMessage]);
						}
					}
				}
			}
        }
        else if (eApp) {
            //if (![eProposalNo isEqualToString:@""]) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA(eProposalNo,CFFID,Choice1,Choice2,Choice3,Choice4,Choice5,Choice6,Choices6Desc) VALUES(?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA_RECOMMENDATION WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d", lastId], eProposalNo];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA_RECOMMENDATION_RIDER WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d", lastId], eProposalNo];
            
            for (int i = 1; i < 6; i++) {
				NSString *existing = [[NSString alloc] initWithFormat:@"ExistingRecommended%i", i];
                NSString *strId = [[NSString alloc] initWithFormat:@"%d", lastId];
                NSString *insured = [[NSString alloc] initWithFormat:@"NameOfInsured%d", i];
                NSString *plan = [[NSString alloc] initWithFormat:@"ProductType%d", i];
                NSString *term = [[NSString alloc] initWithFormat:@"Term%d", i];
                NSString *premium = [[NSString alloc] initWithFormat:@"Premium%d", i];
                NSString *frequency = [[NSString alloc] initWithFormat:@"Frequency%d", i];
                NSString *sa = [[NSString alloc] initWithFormat:@"SumAssured%d", i];
                NSString *bought = [[NSString alloc] initWithFormat:@"Brought%d", i];
                NSString *benefits = [[NSString alloc] initWithFormat:@"AdditionalBenefit%d", i];
				NSString *seq = [[NSString alloc] initWithFormat:@"%d", i];
                NSString *addNew = @"True";
                
				if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:existing] isEqualToString:@"1"]) {
					
					[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION(eProposalNo,CFFID, InsuredName, PlanType, Term, Premium, Frequency, SumAssured, BoughtOption, AddNew, seq) VALUES(?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, strId, [[obj.CFFData objectForKey:@"SecI"] objectForKey:insured], [[obj.CFFData objectForKey:@"SecI"] objectForKey:plan], [[obj.CFFData objectForKey:@"SecI"] objectForKey:term], [[obj.CFFData objectForKey:@"SecI"] objectForKey:premium], [[obj.CFFData objectForKey:@"SecI"] objectForKey:frequency], [[obj.CFFData objectForKey:@"SecI"] objectForKey:sa], [[obj.CFFData objectForKey:@"SecI"] objectForKey:bought], addNew, seq, nil];
					NSLog(@"eProposal_CFF_CA_RECOMMENDATION DB error: %@", [db lastErrorMessage]);
					[db executeUpdate:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION_RIDER(eProposalNo, CFFID, Seq, RiderName) VALUES (?,?,?,?);",  eProposalNo, [NSString stringWithFormat:@"%d", lastId], [NSString stringWithFormat:@"%d", i], [[obj.CFFData objectForKey:@"SecI"] objectForKey:benefits]];
					NSLog(@"eProposal_CFF_CA_RECOMMENDATION_RIDER DB error: %@", [db lastErrorMessage]);
				}
            }
        }
        
        
    }
    
    //CFF Status
	//ENS add, if Finance Analyst Disable
	//NSLog(@"ena: %d, button3: %d, %d", SecFEnable, self.CustomerVC.checkboxButton3.selected, [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]);
	
    //	NSLog(@"secA: %@", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"]);
    //	NSLog(@"secB: %@", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"]);
    //	NSLog(@"secC: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"]);
    //	NSLog(@"secD: %@", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"]);
    //	NSLog(@"secE: %@", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"]);
    //	NSLog(@"if secFenable: secF: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"]);
    //	NSLog(@"secG: %@", [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"]);
    //	NSLog(@"secH: %@", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"]);
    //	NSLog(@"secI: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"]);
    //
    //	NSLog(@"SecFProtection: %@", [[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"]);
    //	NSLog(@"SecFRetirement: %@", [[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"]);
    //	NSLog(@"SecFEducation: %@", [[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"]);
    //	NSLog(@"SecFSavings: %@", [[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"]);
    
	if ((self.CustomerVC.checkboxButton3.selected || [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"])) {
        
        
        if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"] /*&& [[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"] */ && [[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            
            NSString *query = @"";
            if (!eApp) {
                query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '1' WHERE ID = %d",lastId];
            }
            else if (eApp) {
                query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '1' WHERE ID = %d AND eProposalNo = '%@'",lastId, eProposalNo];
            }
            
            [db executeUpdate:query];
            self.status = @"1";
        }
        else{
            NSString *query = @"";
            if (!eApp) {
                query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '0' WHERE ID = %d",lastId];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						//Delete CFF in eApp, since data is Incomplete, and user need to reattach.
						[self DeleteEAppCFF:eProposalNo database:db];
						[self Clear_EAppProposal_Value:eProposalNo database:db];
						ClearData *ClData =[[ClearData alloc]init];
						[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

					}
				}
            }
            else if (eApp) {
                query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '0' WHERE ID = %d AND eProposalNo = %@",lastId, eProposalNo];
				[self DeleteEAppCFF:eProposalNo database:db];
				[self Clear_EAppProposal_Value:eProposalNo database:db];
				ClearData *ClData =[[ClearData alloc]init];
				[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

                
            }
            [db executeUpdate:query];
            self.status = @"0";
			
			
        }
	}
	else if ((self.CustomerVC.checkboxButton1.selected || [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"])) {
		if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]){
			
			NSString *query = @"";
			if (!eApp) {
				query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '1' WHERE ID = %d",lastId];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
					}
				}
			}
			else if (eApp) {
				query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '1' WHERE ID = %d AND eProposalNo = '%@'",lastId, eProposalNo];
			}
			
			[db executeUpdate:query];
			self.status = @"1";
		}
		else{
			NSString *query = @"";
			if (!eApp) {
				query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '0' WHERE ID = %d",lastId];
				
				if (count>0){
					i=0;
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						//Delete CFF in eApp, since data is Incomplete, and user need to reattach.
						NSLog(@"ENS: proposa no : %@", eProposalNo);
						[self DeleteEAppCFF:eProposalNo database:db];
						[self Clear_EAppProposal_Value:eProposalNo database:db];
						ClearData *ClData =[[ClearData alloc]init];
						[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

					}
				}
			}
			else if (eApp) {
				query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '0' WHERE ID = %d AND eProposalNo = %@",lastId, eProposalNo];
				[self DeleteEAppCFF:eProposalNo database:db];
				ClearData *ClData =[[ClearData alloc]init];
				[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
				[self Clear_EAppProposal_Value:eProposalNo database:db];
			}
			[db executeUpdate:query];
			self.status = @"0";
		}
	}
	else if ((self.CustomerVC.checkboxButton2.selected || [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"])) {
		
		BOOL secFPriorityComplete;
		int priority1 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] intValue];
        int priority2 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] intValue];
        int priority3 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] intValue];
        int priority4 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] intValue];
        int priority5 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] intValue];
		
		secFPriorityComplete = FALSE;
		
		if (priority1 == 1 && [[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
			secFPriorityComplete = TRUE;
		}
		else if (priority2 == 1 && [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
			secFPriorityComplete = TRUE;
		}
		else if (priority3 == 1 && [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
			secFPriorityComplete = TRUE;
		}
		else if ((priority4 == 1 || priority5 == 1) && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
			secFPriorityComplete = TRUE;
		}
		
		
		if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]
			&& (secFPriorityComplete)){
			
			NSString *query = @"";
			if (!eApp) {
				query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '1' WHERE ID = %d",lastId];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
					}
				}
			}
			else if (eApp) {
				query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '1' WHERE ID = %d AND eProposalNo = '%@'",lastId, eProposalNo];
			}
			
			[db executeUpdate:query];
			self.status = @"1";
		}
		else{
			NSString *query = @"";
			if (!eApp) {
				query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '0' WHERE ID = %d",lastId];
				
				if (count>0){
					for (i = 0; i < count; i++) {
						eProposalNo = [ProposalCount objectAtIndex: i];
						//Delete CFF in eApp, since data is Incomplete, and user need to reattach.
						[self DeleteEAppCFF:eProposalNo database:db];
						[self Clear_EAppProposal_Value:eProposalNo database:db];
						ClearData *ClData =[[ClearData alloc]init];
						[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

					}
				}
			}
			else if (eApp) {
				query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '0' WHERE ID = %d AND eProposalNo = %@",lastId, eProposalNo];
				[self DeleteEAppCFF:eProposalNo database:db];
				ClearData *ClData =[[ClearData alloc]init];
				[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
				[self Clear_EAppProposal_Value:eProposalNo database:db];
			}
			[db executeUpdate:query];
			self.status = @"0";
		}
	}
    
	
    self.cffID = [[NSString alloc] initWithFormat:@"%d", lastId];
    self.date = commDate;
    [[obj.eAppData objectForKey:@"CFF"] setValue:self.status forKey:@"Completed"];
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"]);
    if (!eApp) {
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecACompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecBCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecCCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecDCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecECompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFProtectionCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFRetirementCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFEducationCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFSavingsCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecGCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecHCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecICompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        [db executeUpdate:[NSString stringWithFormat: @"UPDATE CFF_Master SET ProspectProfileChangesCounter = '%@' WHERE ID = %d", [obj.CFFData objectForKey:@"prospectCounter"], lastId]];
		
		if (count>0){
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
			}
		}
    }
    else if (eApp) {
        //if (eApp) {
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecACompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecBCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecCCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecDCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecECompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFProtectionCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFRetirementCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFEducationCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFSavingsCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecGCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecHCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecICompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
    }
    
    //    [db commit];
    
    if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFSave"] isEqualToString:@"1"] && !eApp) {
        NSLog(@"CFF - Updated Changes Counter");
        FMResultSet *result = [db executeQuery:@"select CFFChangesCounter from CFF_Master where ID = ?", [NSString stringWithFormat:@"%d",lastId]];
        int counter = -1;
        while ([result next]) {
            counter = [result intForColumn:@"CFFChangesCounter"];
        }
        
        if (counter != -1) {
            counter = counter + 1;
            [db executeUpdate:[NSString stringWithFormat:@"UPDATE CFF_Master SET CFFChangesCounter = \"%d\" where ID = \"%d\"",counter, lastId]];
        }
    }
    //else if (eApp) {
	if (eApp) {
        NSLog(@"CFF - Changes Counter is copied");
        FMResultSet *result = [db executeQuery:@"select CFFChangesCounter from CFF_Master where ID = ?", [NSString stringWithFormat:@"%d",lastId]];
        int counter = -1;
        while ([result next]) {
            counter = [result intForColumn:@"CFFChangesCounter"];
        }
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET CFFChangesCounter = \"%d\" where ID = \"%d\" and eProposalNo = \"%@\"",counter, lastId, eProposalNo]];
        
        NSLog(@"CFF - Copy ClientChoice to eProposal");
        bool success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE eProposal SET ClientChoice = \"%@\" where eProposalNo = \"%@\"", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"], eProposalNo]];
        if (success) {
            NSLog(@"copy success");
        }
        else {
            NSLog(@"error: %@", [db lastErrorMessage]);
        }
    }
    
    
	
	//######
	// add by Emi 15/08/2014 delete confirmed eApp when cff standalone ammend.
	sqlite3_stmt *statement;
	
	NSString *DelErrAt = @"";
	
	if (!eApp) {
		if (count>0) {
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM eApp_listing WHERE ProposalNo = '%@' and Status = 3", eProposalNo]];
                
				NSString *proposal;
				while ([result next]) {
					proposal = [result objectForColumnName:@"ProposalNo"];
					//Delete eApp_Listing
					if (![db executeUpdate:@"Delete from eApp_Listing where ProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - CFF eApp_Listing");
					}
					
					//Delete eProposal_LA_Details
					if (![db executeUpdate:@"Delete from eProposal_LA_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_LA_Details");
					}
					
					//Delete eProposal
					if (![db executeUpdate:@"Delete from eProposal where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal");
					}
					
					//Delete eProposal_Existing_Policy_1
					if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
					}
					
					//Delete eProposal_Existing_Policy_2
					if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
					}
					
					//Delete eProposal_NM_Details
					if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_NM_Details");
					}
					
					//Delete eProposal_Trustee_Details
					if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
					}
					
					//Delete eProposal_QuestionAns
					if (![db executeUpdate:@"Delete from eProposal_QuestionAns where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
					}
					
					//Delete eProposal_Additional_Questions_1
					if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
					}
					
					//Delete eProposal_Additional_Questions_2
					if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
					}
					
					//DELETE CFF START
					
					//Delete eProposal_CFF_Master
					if (![db executeUpdate:@"Delete from eProposal_CFF_Master where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
					}
					
					//Delete eProposal_CFF_CA
					if (![db executeUpdate:@"Delete from eProposal_CFF_CA where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
					}
					
					//Delete eProposal_CFF_CA_Recommendation
					if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
					}
					
					//Delete eProposal_CFF_CA_Recommendation_Rider
					if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
					}
					
					//Delete eProposal_CFF_Education
					if (![db executeUpdate:@"Delete from eProposal_CFF_Education where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
					}
					
					//Delete eProposal_CFF_Education_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_Education_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
					}
					
					//Delete eProposal_CFF_Family_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_Family_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
					}
					
					//Delete eProposal_CFF_Personal_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
					}
					
					//Delete eProposal_CFF_Protection
					if (![db executeUpdate:@"Delete from eProposal_CFF_Protection where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
					}
					
					//Delete eProposal_CFF_Protection_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
					}
					
					//Delete eProposal_CFF_RecordOfAdvice
					if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
					}
					
					//Delete eProposal_CFF_RecordOfAdvice_Rider
					if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
					}
					
					//Delete eProposal_CFF_Retirement
					if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
					}
					
					//Delete eProposal_CFF_Retirement_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
					}
					
					//Delete eProposal_CFF_SavingsInvest
					if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
					}
					
					//Delete eProposal_CFF_SavingsInvest_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
					}
					
					//Delete eProposal_CFF_SavingsInvest_Details
					if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
						NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
					}
					//DELETE CFF END
					
				}
			}
			
			
			//if PO_SIGN, delete all
			for (i = 0; i < count; i++) {
				eProposalNo = [ProposalCount objectAtIndex: i];
				NSString *PO_Sign;
				FMResultSet *result_eSign = [db executeQuery:[NSString stringWithFormat:@"SELECT * from eProposal_Signature WHERE eProposalNo = '%@'", eProposalNo]];
				
				NSString *proposal;
				while ([result_eSign next]) {
					proposal = eProposalNo;
					
					PO_Sign = [result_eSign objectForColumnName:@"isPOSign"];
					if  ((NSNull *) PO_Sign == [NSNull null])
						PO_Sign = @"";
					
					if ([PO_Sign isEqualToString:@"YES"]) {
						//Delete eApp_Listing
						if (![db executeUpdate:@"Delete from eApp_Listing where ProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - CFF eApp_Listing");
						}
						
						//Delete eProposal_LA_Details
						if (![db executeUpdate:@"Delete from eProposal_LA_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_LA_Details");
						}
						
						//Delete eProposal
						if (![db executeUpdate:@"Delete from eProposal where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal");
						}
						
						//Delete eProposal_Existing_Policy_1
						if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
						}
						
						//Delete eProposal_Existing_Policy_2
						if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
						}
						
						//Delete eProposal_NM_Details
						if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_NM_Details");
						}
						
						//Delete eProposal_Trustee_Details
						if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
						}
						
						//Delete eProposal_QuestionAns
						if (![db executeUpdate:@"Delete from eProposal_QuestionAns where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
						}
						
						//Delete eProposal_Additional_Questions_1
						if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
						}
						
						//Delete eProposal_Additional_Questions_2
						if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
						}
						
						//DELETE CFF START
						
						//Delete eProposal_CFF_Master
						if (![db executeUpdate:@"Delete from eProposal_CFF_Master where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
						}
						
						//Delete eProposal_CFF_CA
						if (![db executeUpdate:@"Delete from eProposal_CFF_CA where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
						}
						
						//Delete eProposal_CFF_CA_Recommendation
						if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
						}
						
						//Delete eProposal_CFF_CA_Recommendation_Rider
						if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
						}
						
						//Delete eProposal_CFF_Education
						if (![db executeUpdate:@"Delete from eProposal_CFF_Education where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
						}
						
						//Delete eProposal_CFF_Education_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_Education_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
						}
						
						//Delete eProposal_CFF_Family_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_Family_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
						}
						
						//Delete eProposal_CFF_Personal_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
						}
						
						//Delete eProposal_CFF_Protection
						if (![db executeUpdate:@"Delete from eProposal_CFF_Protection where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
						}
						
						//Delete eProposal_CFF_Protection_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
						}
						
						//Delete eProposal_CFF_RecordOfAdvice
						if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
						}
						
						//Delete eProposal_CFF_RecordOfAdvice_Rider
						if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
						}
						
						//Delete eProposal_CFF_Retirement
						if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
						}
						
						//Delete eProposal_CFF_Retirement_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
						}
						
						//Delete eProposal_CFF_SavingsInvest
						if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
						}
						
						//Delete eProposal_CFF_SavingsInvest_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
						}
						
						//Delete eProposal_CFF_SavingsInvest_Details
						if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
						}
						//DELETE CFF END
						
						//delete eSignature
						if (![db executeUpdate:@"Delete from eProposal_Signature where eProposalNo = ?", proposal, nil]) {
							NSLog(@"Error in Delete Statement - eProposal_Signature");
						}
                        
					}
					
				}
			}
		}
		
	}
	
	
	//######
	
	[db close];
	
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFCreate"]; //create new CFF
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFSave"]; //save CFF
    
    if (toSave == 1 && specialIndex.row == -4 && specialIndex.section == -4) {
        //[self dismissViewControllerAnimated:TRUE completion:nil];
        ChangesMade=NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20011;
        [alert show];
        alert = nil;
    }
    
    if (RecordSavedAlert==NO && ChangesMade!=NO){
        
        confirmStatus=YES;
        [Utility showAllert:@"Changes have been updated successfully."];
        [[NSUserDefaults standardUserDefaults]setBool:confirmStatus forKey:@"confirmed"];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if(RecordSavedAlertGen==NO && ChangesMade!=NO && RcrdSvForCFF!=NO)
        [Utility showAllert:@"Record saved successfully."];
    //	if (pressSaveAll && !noAlert) {
    //        //[self dismissViewControllerAnimated:TRUE completion:nil];
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        alert = nil;
    //    }
    ChangesMade=YES;
}

-(void) CheckRelationEAPP:(NSString *)eProposal database:(FMDatabase *)db {
	
	if ([db close])
		[db open];
	
	NSString *PO_Name;
	FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"Select LAName from eProposal_LA_Details where eProposalNo = '%@' AND POFlag = 'Y'", eProposal]];
    while ([result next]) {
		PO_Name = [result objectForColumnName:@"LAName"];
	}
	
	BOOL hasRel = NO;
	
	if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"]]) {
		hasRel = YES;
	}
	
	if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]]) {
		hasRel = YES;
	}
	
	if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
		if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]])
			hasRel = YES;
	}
	
	if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
		if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"]])
			hasRel = YES;
	}
	if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
		if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"]])
			hasRel = YES;
	}
	
	if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
		if ([PO_Name isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"]])
			hasRel = YES;
	}
	
    //	result = [db executeQuery:[NSString stringWithFormat:@"Select name from eProposal_CFF_Personal_Details where eProposalNo = '%@'", eProposal]];
    //    while ([result next]) {
    //		if ([PO_Name isEqualToString:[result objectForColumnName:@"name"]]) {
    //			hasRel = YES;
    //		}
    //	}
    //
    //	result = [db executeQuery:[NSString stringWithFormat:@"Select name from eProposal_CFF_Family_Details where eProposalNo = '%@'", eProposal]];
    //    while ([result next]) {
    //		if ([PO_Name isEqualToString:[result objectForColumnName:@"name"]]) {
    //			hasRel = YES;
    //		}
    //	}
	
	
	if (!hasRel) {
		NSLog(@"No relation with CFF: DELETE eAPP_CFF");
		[self DeleteEAppCFF:eProposal database:db];
		[self Clear_EAppProposal_Value:eProposal database:db];
		ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

	}
    
    
}
-(void)saveCreateCFF:(int)toSave{
    
	
	
	RecordSavedAlertGen=YES;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
	[db open];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    //    [db beginTransaction];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
    commDate = [dateFormatter stringFromDate:[NSDate date]];
    //To check the eapp and pop up the alert--starting
    
    NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    lastId = [[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"] intValue];
    if (!eApp)
		eProposalNo1 = @"";
	if (eProposalNo1 == NULL)
		eProposalNo1 = @"";
	if ([eProposalNo1 isEqualToString:@"(null)"])
		eProposalNo1 = @"";
	
	
	hasPOSign = NO;
	hasFailed = NO;
    //	hasConfirmed = NO;
	hasReceived = NO;
	
    // NSMutableArray *ProposalCount = [NSMutableArray array];
	
    //FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo) FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and B.status in (2,6) and A.eProposalNo = B.ProposalNo", lastId]]
	FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo), B.status FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and A.eProposalNo = B.ProposalNo", lastId]];
    while ([result next]) {
		if ([[result objectForColumnName:@"status"] isEqualToString:@"3"] || [[result objectForColumnName:@"status"] isEqualToString:@"2"])
			eProposalNo1 = [result objectForColumnName:@"eProposalNo"];
		
		if ([[result objectForColumnName:@"status"] isEqualToString:@"3"]) {
			hasConfirmed = TRUE;
		}
		
		eProposalNo1 = [result objectForColumnName:@"eProposalNo"];
		[self CheckPOSigned:eProposalNo1];
		if ([[result objectForColumnName:@"status"] isEqualToString:@"3"]) {
			hasConfirmed = TRUE;
		}
		else if ([[result objectForColumnName:@"status"] isEqualToString:@"7"]) {
			hasReceived = TRUE;
            hasPOSign = NO;
		}
		else if ([[result objectForColumnName:@"status"] isEqualToString:@"6"]) {
			hasFailed = TRUE;
		}
        
    }
	
    //	FMResultSet *result2 = [db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT (eProposalNo), B.status FROM eProposal_CFF_MASTER A, eApp_listing B WHERE A.ID = %d and A.eProposalNo = B.ProposalNo", lastId]];
    //    while ([result next]) {
    //        eProposalNo1 = [result2 objectForColumnName:@"eProposalNo"];
    //
    //		[self CheckPOSigned:eProposalNo1];
    //
    //		if ([[result2 objectForColumnName:@"status"] isEqualToString:@"3"]) {
    //			hasConfirmed = TRUE;
    //		}
    //		else if ([[result2 objectForColumnName:@"status"] isEqualToString:@"7"]) {
    //			hasReceived = TRUE;
    //		}
    //		else if ([[result2 objectForColumnName:@"status"] isEqualToString:@"6"]) {
    //			hasFailed = TRUE;
    //		}
    //    }
	
	
	
	
	
    NSLog(@"eProposal number==%@ and !epp===%i",eProposalNo1,eApp);
    if(eProposalNo1.length!=0 && !eApp)
		
    {
		
        checkEappAlertDone=NO;
        RecordSavedAlert=NO;
        mainresult=0;
        
        UIAlertView *alert;
        
        
        if (hasConfirmed){
            //  alert = [[UIAlertView alloc]initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [[[UIAlertView alloc] initWithTitle:@" "
                                        message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case."
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                // Handle "Cancel"
                checkEappAlertDone=YES;
                
                RecordSavedAlert=NO;
                [self saveCreateCFFForAlert:db andtoSave:toSave];
                
                
            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
                // Handle "Delete"
                
                return;
                
            }], nil] show];
        }
		
        else if(hasPOSign && !hasFailed)
        {
            //  alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [[[UIAlertView alloc] initWithTitle:@" "
                                        message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case."
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                // Handle "Cancel"
                checkEappAlertDone=YES;
                
                RecordSavedAlert=NO;
                [self saveCreateCFFForAlert:db andtoSave:toSave];
                
                
            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
                // Handle "Delete"
                
                return;
                
            }], nil] show];
            //		[alert show];
        }
        else if(hasPOSign && (!hasReceived))
        {
            // alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            
            
            
            [[[UIAlertView alloc] initWithTitle:@" "
                                        message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related eApp cases and you are required to recreate the necessary should you wish to resubmit the case."
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                // Handle "Cancel"
                checkEappAlertDone=YES;
                
                RecordSavedAlert=NO;
                [self saveCreateCFFForAlert:db andtoSave:toSave];
                
                
            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
                // Handle "Delete"
                
                return;
                
            }], nil] show];
            
            
            //		[alert show];
        }
        
        else if (!hasConfirmed){
            
            [[[UIAlertView alloc] initWithTitle:@" "
                                        message:@"Changes will be updated to Created eApp cases. Do you want to proceed?"
                               cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
                // Handle "Cancel"
                checkEappAlertDone=YES;
                
                RecordSavedAlert=NO;
                [self saveCreateCFFForAlert:db andtoSave:toSave];
                
                
            }]
                               otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
                // Handle "Delete"
                
                return;
                
            }], nil] show];
            
        }
        
        //  alert.tag = 99999;
        // [alert show];
        // alert = Nil;
        
        
        //        [[[UIAlertView alloc] initWithTitle:@"Delete This Item?"
        //                                    message:@"Are you sure you want to delete this really important thing?"
        //                           cancelButtonItem:[RIButtonItem itemWithLabel:@"Yes" action:^{
        //            // Handle "Cancel"
        //            checkEappAlertDone=YES;
        //
        //            [self saveCreateCFFForAlert:db andtoSave:toSave];
        //
        //
        //        }]
        //                           otherButtonItems:[RIButtonItem itemWithLabel:@"No" action:^{
        //            // Handle "Delete"
        //
        //             // checkEappAlertDone=YES;
        //            //mainresult=1;
        //            return;
        //
        //        }], nil] show];
        
        /*
         
         //   [self performSelectorInBackground:@selector(executeInGB) withObject:nil];
         while (!checkEappAlertDone) {
         NSDate* timeout = [NSDate dateWithTimeIntervalSinceNow:1.f];
         [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeout];
         
         }
         NSLog(@"#####in main  %i",mainresult);
         if (mainresult==1) {
         return;
         }
         
         */
        
        
        //return;
        
        NSLog(@"Do something else");
    }
    else{
        
        RecordSavedAlertGen=NO;
        [self saveCreateCFFForAlert:db andtoSave:toSave];
    }
    
}



- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(void)loadDBData {
    
    int indexNo;
    NSString *clientName;
    NSString *clientID;
    NSString *CFFID;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *eAppResults;
    
    
    obj=[DataClass getInstance];
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    results = [database executeQuery:@"SELECT ID FROM eProposal_CFF_MASTER WHERE eProposalNo = ?", eProposalNo];
    while ([results next]) {
        CFFID = [results objectForColumnName:@"ID"];
    }
    if (!CFFID) {
        return;
    }
    
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
    
    //To pass to CFF, to check if CFF for eApp or standalone
	if (!eApp){
		[[obj.CFFData objectForKey:@"CFF"] setValue:@"N" forKey:@"isEAPP"];
		NSString *eAppNS = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
		NSLog(@"test %@", eAppNS);
	} else if (eApp){
		[[obj.CFFData objectForKey:@"CFF"] setValue:@"Y" forKey:@"isEAPP"];
		NSString *eAppNS = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
		NSLog(@"test %@", eAppNS);
	}
	
    
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
    eAppResults = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=? AND eProposalNo = ?", CFFID, eProposalNo];
    
    bool eAppIsMoreUpdate = false;
    NSString *createdAt;
    NSString *lastUpdatedAt;
    while([results next])
	{
        indexNo = [results intForColumn:@"ClientProfileID"];
        
        bool eApp1 = [eAppResults next];
        if (eApp1) {
            NSLog(@"eApp available");
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MM/yyyy"];
            NSDate *standalone = [format dateFromString:[results stringForColumn:@"lastUpdatedAt"]];
            NSDate *eAppDate = [format dateFromString:[eAppResults stringForColumn:@"lastUpdatedAt"]];
            if (![eAppDate laterDate:standalone]) {
                eAppIsMoreUpdate = true;
                eAppIsUpdate = TRUE;
                NSLog(@"eApp More Updated");
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
            
			//SecF
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
				
				BOOL secFPriorityComplete;
				int priority1 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] intValue];
				int priority2 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] intValue];
				int priority3 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] intValue];
				int priority4 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] intValue];
				int priority5 = [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] intValue];
				
				secFPriorityComplete = FALSE;
				
				if (priority1 == 1 && [[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
					secFPriorityComplete = TRUE;
				}
				else if (priority2 == 1 && [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
					secFPriorityComplete = TRUE;
				}
				else if (priority3 == 1 && [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
					secFPriorityComplete = TRUE;
				}
				else if ((priority4 == 1 || priority5 == 1) && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
					secFPriorityComplete = TRUE;
				}
                if (secFPriorityComplete){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            
			
			
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
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrCountry"] forKey:@"IntermediaryCountry"];
			
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
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrPostcode"]  forKey:@"IntermediaryPostcode"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrTown"] forKey:@"IntermediaryTown"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrState"] forKey:@"IntermediaryState"];
			[[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddrCountry"] forKey:@"IntermediaryCountry"];
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
        
		//REMOVE BY EMI, for permanent address, for first time, value get from customerMailingAddress
		
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
		
    }
    
    results = nil;
    results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", CFFID, @"1"];
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress1"] forKey:@"CustomerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress2"] forKey:@"CustomerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress3"] forKey:@"CustomerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingPostCode"] forKey:@"CustomerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingTown"] forKey:@"CustomerMailingAddressTown"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingState"] forKey:@"CustomerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingCountry"] forKey:@"CustomerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingForeignAddressFlag"] forKey:@"CustomerMailingAddressForeign"];
		
		//==
		
        //		if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
        //            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
        //        }
        //        else {
        //            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerPermanentAddressForeign"];
        //        }
        //
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress1"] forKey:@"CustomerPermanentAddress1"];
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress2"] forKey:@"CustomerPermanentAddress2"];
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress3"] forKey:@"CustomerPermanentAddress3"];
        //
        //
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentPostCode"] forKey:@"CustomerPermanentPostcode"];
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentTown"] forKey:@"CustomerPermanentAddressTown"];
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentState"] forKey:@"CustomerPermanentAddressState"];
        //        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentCountry"] forKey:@"CustomerPermanentAddressCountry"];
        
        //==
		
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
	
	if (eApp) {
		results = Nil;
		NSString *query = [NSString stringWithFormat:@"select * FROM eProposal_CFF_Personal_Details WHERE CFFID = '%@' AND eProposalNo = '%@' AND PTypeCode = 1", CFFID, eProposalNo];
		NSLog(@"QUERY ENS: %@", query);
		results = [database executeQuery:query];
		while ([results next]) {
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress1"] forKey:@"CustomerMailingAddress1"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress2"] forKey:@"CustomerMailingAddress2"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress3"] forKey:@"CustomerMailingAddress3"];
			
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingPostCode"] forKey:@"CustomerMailingPostcode"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingTown"] forKey:@"CustomerMailingAddressTown"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingState"] forKey:@"CustomerMailingAddressState"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingCountry"] forKey:@"CustomerMailingAddressCountry"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingForeignAddressFlag"] forKey:@"CustomerMailingAddressForeign"];
			
			//==
			
			if ([[results stringForColumn:@"PermanentCountry"] isEqualToString:@"MAL"] || [[results stringForColumn:@"PermanentCountry"] isEqualToString:@"MALAYSIA"]) {
				[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
			}
			else {
				[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerPermanentAddressForeign"];
			}
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress1"] forKey:@"CustomerPermanentAddress1"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress2"] forKey:@"CustomerPermanentAddress2"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress3"] forKey:@"CustomerPermanentAddress3"];
			
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentPostCode"] forKey:@"CustomerPermanentPostcode"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentTown"] forKey:@"CustomerPermanentAddressTown"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentState"] forKey:@"CustomerPermanentAddressState"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentCountry"] forKey:@"CustomerPermanentAddressCountry"];
			
			//==
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddFromCFF"] forKey:@"AddFromCFF"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"AddNewPayor"] forKey:@"AddNewPayor"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SameAsPO"] forKey:@"SameAsPO"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PTypeCode"] forKey:@"PTypeCode"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PYFlag"] forKey:@"PYFlag"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddressSameAsPO"] forKey:@"MailingAddressSameAsPO"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddressSameAsPO"] forKey:@"PermanentAddressSameAsPO"];
			
			//#######
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidencePhoneNoExt"] forKey:@"ResidenceTelExt"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidencePhoneNo"] forKey:@"ResidenceTel"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OfficePhoneNoExt"] forKey:@"OfficeTelExt"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OfficePhoneNo"] forKey:@"OfficeTel"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MobilePhoneNoExt"] forKey:@"MobileTelExt"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MobilePhoneNo"] forKey:@"MobileTel"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"FaxPhoneNoExt"] forKey:@"FaxTelExt"];
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"FaxPhoneNo"] forKey:@"FaxTel"];
			
			[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"EmailAddress"] forKey:@"Email"];
		}
		
	}
    
    
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
            
			
			//REMARK BY EMI
            //            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
            //                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
            //            }
            //            else {
            //                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerPermanentAddressForeign"];
            //            }
            //
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerPermanentAddress1"];
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerPermanentAddress2"];
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerPermanentAddress3"];
            //
            //
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"PartnerPermanentPostcode"];
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"PartnerPermanentAddressTown"];
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerPermanentAddressState"];
            //            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerPermanentAddressCountry"];
            
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
		//Update data from Eapp_cff
		if (eApp) {
			results = Nil;
			NSString *query = [NSString stringWithFormat:@"select * FROM eProposal_CFF_Personal_Details WHERE CFFID = '%@' AND eProposalNo = '%@' AND PTypeCode = 2", CFFID, eProposalNo];
			NSLog(@"QUERY ENS: %@", query);
			results = [database executeQuery:query];
			while ([results next]) {
                
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidencePhoneNoExt"] forKey:@"PartnerResidenceTelExt"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidencePhoneNo"] forKey:@"PartnerResidenceTel"];
                
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OfficePhoneNoExt"] forKey:@"PartnerOfficeTelExt"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OfficePhoneNo"] forKey:@"PartnerOfficeTel"];
                
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MobilePhoneNoExt"] forKey:@"PartnerMobileTelExt"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MobilePhoneNo"] forKey:@"PartnerMobileTel"];
                
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"FaxPhoneNoExt"] forKey:@"PartnerFaxTelExt"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"FaxPhoneNo"] forKey:@"PartnerFaxTel"];
				
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"EmailAddress"] forKey:@"PartnerEmail"];
				
				//mailing
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress1"] forKey:@"PartnerMailingAddress1"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress2"] forKey:@"PartnerMailingAddress2"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingAddress3"] forKey:@"PartnerMailingAddress3"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingPostCode"] forKey:@"PartnerMailingPostcode"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingTown"] forKey:@"PartnerMailingAddressTown"];
				
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingState"] forKey:@"PartnerMailingAddressState"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingCountry"] forKey:@"PartnerMailingAddressCountry"];
				
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MailingForeignAddressFlag"] forKey:@"PartnerMailingAddressForeign"];
				
				//Permanent
				if ([[results stringForColumn:@"PermanentCountry"] isEqualToString:@"MAL"]) {
					[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
				}
				else {
					[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerPermanentAddressForeign"];
				}
				
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress1"] forKey:@"PartnerPermanentAddress1"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress2"] forKey:@"PartnerPermanentAddress2"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentAddress3"] forKey:@"PartnerPermanentAddress3"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentPostCode"] forKey:@"PartnerPermanentPostcode"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentTown"] forKey:@"PartnerPermanentAddressTown"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentState"] forKey:@"PartnerPermanentAddressState"];
				[[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PermanentCountry"] forKey:@"PartnerPermanentAddressCountry"];
                
			}
			
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
        results = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
    }
    int gotChild = 0;
    int gotChildCount = 0;
    while ([results next]) {
        NSLog(@"count %d", [results intForColumn:@"cnt"]);
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
            results = [database executeQuery:@"select * from eProposal_CFF_Family_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ClientProfileID"] forKey:@"Childen1ClientProfileID"];
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
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ClientProfileID"] forKey:@"Childen2ClientProfileID"];
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
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ClientProfileID"] forKey:@"Childen3ClientProfileID"];
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
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ClientProfileID"] forKey:@"Childen4ClientProfileID"];
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
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ClientProfileID"] forKey:@"Childen5ClientProfileID"];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Protection where CFFID = '%@'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:@"select * from eProposal_CFF_Protection_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
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
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection3MaturityDate"];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement where CFFID = '%@'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement_Details where CFFID = '%@' order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
    }
    NSLog(@"before retire details");
    while ([results next]) {
        NSLog(@"loading retire details");
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education where CFFID = '%@'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education_Details where CFFID = '%@' order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest where CFFID = '%@'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest_Details where CFFID = '%@' order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest_Details where eProposalNo = '%@' order by SeqNo asc",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '1'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '1' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '2'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '2' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_CA where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation where eProposalNo = ? order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
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
                FMResultSet *result_getRec = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],@"1"];
                while ([result_getRec next]) {
                    [[obj.CFFData objectForKey:@"SecI"] setValue:[result_getRec stringForColumn:@"RiderName"] forKey:@"AdditionalBenefit1"];
                }
                
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
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency2"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured2"];
                FMResultSet *result_getRec = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],@"2"];
                while ([result_getRec next]) {
                    [[obj.CFFData objectForKey:@"SecI"] setValue:[result_getRec stringForColumn:@"RiderName"] forKey:@"AdditionalBenefit2"];
                }
                
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
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency3"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured3"];
                
                FMResultSet *result_getRec = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],@"3"];
                while ([result_getRec next]) {
                    [[obj.CFFData objectForKey:@"SecI"] setValue:[result_getRec stringForColumn:@"RiderName"] forKey:@"AdditionalBenefit3"];
                }
                
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
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency4"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured4"];
                
                FMResultSet *result_getRec = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],@"4"];
                while ([result_getRec next]) {
                    [[obj.CFFData objectForKey:@"SecI"] setValue:[result_getRec stringForColumn:@"RiderName"] forKey:@"AdditionalBenefit4"];
                }
                
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
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency5"];
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured5"];
                FMResultSet *result_getRec = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],@"5"];
                while ([result_getRec next]) {
                    [[obj.CFFData objectForKey:@"SecI"] setValue:[result_getRec stringForColumn:@"RiderName"] forKey:@"AdditionalBenefit5"];
                }
                [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought5"];
            }
        }
    }
    
    //[self storeXMLData:CFFID];
}

-(BOOL) RecheckIfEmpty {
	
	if (![self RecheckProtectionNeedValidation] && ![self RecheckRetirementNeedValidation] && ![self RecheckEducationNeedValidation] && ![self RecheckSavingNeedValidation]) {
		return FALSE;
	}
	return TRUE;
}

-(BOOL) RecheckProtectionNeedValidation {
    
	//CANCEL VALIDATION CHECKING IF ALL VALUE IS EMPTY
	bool child1Current = [self.FNAProtectionVC.current1.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current1.text.length == 0;
    bool child2Current = [self.FNAProtectionVC.current2.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current2.text.length == 0;
    bool child3Current = [self.FNAProtectionVC.current3.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current3.text.length == 0;
    bool child4Current = [self.FNAProtectionVC.current4.text isEqualToString:@"0.00"] || self.FNAProtectionVC.current4.text.length == 0;
    
	if ((self.FNAProtectionVC.ProtectionSelected) && [self.FNAProtectionVC.plan1.text isEqualToString:@"Add Existing Protection Plan (1)"] && (child1Current && child2Current && child3Current && child4Current)) {
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
		return FALSE;
	}
	return TRUE;
}
-(BOOL) RecheckRetirementNeedValidation {
	
	bool Current1 = [self.FNARetirementVC.current1.text isEqualToString:@"0.00"] || self.FNARetirementVC.current1.text.length == 0;
	BOOL required1 = [self.FNARetirementVC.required1.text isEqualToString:@"0.00"] || self.FNARetirementVC.required1.text.length == 0;
    
	
	if (self.FNARetirementVC.RetirementSelected && [self.FNARetirementVC.plan1.text isEqualToString:@"Add Existing Retirement Plan (1)"] && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"0"] && Current1 && required1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        return FALSE;
    }
	return TRUE;
}
-(BOOL) RecheckEducationNeedValidation {
	
	bool child1Current = [self.FNAEducationVC.current1.text isEqualToString:@"0.00"] || self.FNAEducationVC.current1.text.length == 0;
    bool child2Current = [self.FNAEducationVC.current2.text isEqualToString:@"0.00"] || self.FNAEducationVC.current2.text.length == 0;
    bool child3Current = [self.FNAEducationVC.current3.text isEqualToString:@"0.00"] || self.FNAEducationVC.current3.text.length == 0;
    bool child4Current = [self.FNAEducationVC.current4.text isEqualToString:@"0.00"] || self.FNAEducationVC.current4.text.length == 0;
	
	bool child1Req = [self.FNAEducationVC.required1.text isEqualToString:@"0.00"] || self.FNAEducationVC.required1.text.length == 0;
    bool child2Req = [self.FNAEducationVC.required2.text isEqualToString:@"0.00"] || self.FNAEducationVC.required2.text.length == 0;
    bool child3Req = [self.FNAEducationVC.required3.text isEqualToString:@"0.00"] || self.FNAEducationVC.required3.text.length == 0;
    bool child4Req = [self.FNAEducationVC.required4.text isEqualToString:@"0.00"] || self.FNAEducationVC.required4.text.length == 0;
	
	if (!self.FNAEducationVC.hasChildren) {
		return TRUE;
	}
	
	if ((self.FNAEducationVC.EducationSelected) && [self.FNAEducationVC.plan1.text isEqualToString:@"Add Existing Children’s Education Plan (1)"] && (child1Current && child2Current && child3Current && child4Current) && (child1Req && child2Req && child3Req && child4Req)) {
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        return FALSE;
	}
	return TRUE;
}
-(BOOL) RecheckSavingNeedValidation {
    
	bool Current1 = [self.FNASavingsVC.current1.text isEqualToString:@"0.00"] || self.FNASavingsVC.current1.text.length == 0;
	BOOL required1 = [self.FNASavingsVC.required1.text isEqualToString:@"0.00"] || self.FNASavingsVC.required1.text.length == 0;
	
	
	if (self.FNASavingsVC.SavingsSelected && [self.FNASavingsVC.plan1.text isEqualToString:@"Add Existing Savings and Investment Plan (1)"] && Current1 && required1){
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        return FALSE;
    }
	return TRUE;
}

-(void) CheckPOSigned: (NSString *)eProposalNo {
	//CHECK PO_SIGN
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	NSString *PO_Sign;
    //	NSString *eProposalNo;
    
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
	FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ",eProposalNo];
	
	while ([result_eSign next]) {
		PO_Sign = [result_eSign objectForColumnName:@"isPOSign"];
		if  ((NSNull *) PO_Sign == [NSNull null])
			PO_Sign = @"";
		
		if ([PO_Sign isEqualToString:@"YES"]) {
			hasPOSign = YES;
		}
		
	}
    
}

#pragma mark - XML

-(void) storeXMLData:(NSString *) cffId {
    
    obj = [DataClass getInstance];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    //cff info
    if (eAppIsUpdate) {
        results = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=?", cffId];
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
    NSLog(@"1");
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:eCFFInfo forKey:@"eCFFInfo"];
    
    //personal info for cff payor
    NSString *addFromCFF = @"";
    NSString *addNewPayor = @"";
    NSString *sameAsPO = @"";
    NSString *PTypeCode = @"";
    NSString *PYFlag = @"";
    NSString *title = @"";
    NSString *name = @"";
    NSString *newICNo = @"";
    NSString *otherIDType = @"";
    NSString *otherID = @"";
    NSString *nationality = @"";
    NSString *race = @"";
    NSString *religion = @"";
    NSString *sex = @"";
    NSString *smoker = @"";
    NSString *dob = @"";
    NSString *age = @"";
    NSString *maritalStatus = @"";
    NSString *occupation = @"";
    NSString *residenceNo = @"";
    NSString *officePhoneNo = @"";
    NSString *mobilePhoneNo = @"";
    NSString *faxPhoneNo = @"";
    NSString *emailAddress = @"";
    NSString *addressSameAsPO = @"";
    NSString *address1 = @"";
    NSString *address2 = @"";
    NSString *address3 = @"";
    NSString *town = @"";
    NSString *state = @"";
    NSString *postcode = @"";
    NSString *country = @"";
    NSString *foreignAddress = @"";
    NSString *permanentAddressSameAsPO = @"";
    NSString *permanentAddress1 = @"";
    NSString *permanentAddress2 = @"";
    NSString *permanentAddress3 = @"";
    NSString *permanentTown = @"";
    NSString *permanentState = @"";
    NSString *permanentPostcode = @"";
    NSString *permanentCountry = @"";
    NSString *permanentForeignAddress = @"";
    
    results = nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]]];
    
    NSDate *prospectProfileDate;
    
    NSLog(@"before ehllo");
    while ([results next]) {
        NSLog(@"ehllo");
        title = [self getTitleCode:[results stringForColumn:@"ProspectTitle"] passdb: database];
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
            
            addFromCFF = [results stringForColumn:@"AddFromCFF"] != NULL ? [results stringForColumn:@"AddFromCFF"] : @"";
            addNewPayor = [results stringForColumn:@"AddNewPayor"] != NULL ? [results stringForColumn:@"AddNewPayor"] : @"";
            sameAsPO = [results stringForColumn:@"SameAsPO"] != NULL ? [results stringForColumn:@"SameAsPO"] : @"";
            PTypeCode = [results stringForColumn:@"PTypeCode"] != NULL ? [results stringForColumn:@"PTypeCode"] : @"";
            PYFlag = [results stringForColumn:@"PYFlag"] != NULL ? [results stringForColumn:@"PYFlag"] : @"";
            addressSameAsPO = [results stringForColumn:@"MailingAddressSameAsPO"] != NULL ? [results stringForColumn:@"MailingAddressSameAsPO"] : @"";
            permanentAddressSameAsPO = [results stringForColumn:@"PermanentAddressSameAsPO"] != NULL ? [results stringForColumn:@"PermanentAddressSameAsPO"] : @"";
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
    NSLog(@"1A");
    
    if([foreignAddress isEqualToString:@"0"])
    {
        foreignAddress = @"N";
    }
    if ([foreignAddress isEqualToString:@"1"])
    {
        foreignAddress = @"Y";
        
    }
    if([permanentForeignAddress isEqualToString:@"0"])
    {
        permanentForeignAddress = @"N";
    }
    if ([permanentForeignAddress isEqualToString:@"1"])
    {
        permanentForeignAddress = @"Y";
        
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
    NSLog(@"2");
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:personalInfo forKey:@"eCFFPersonalInfo"];
    NSLog(@"eCFFPersonalInfo :%@", [[obj.eAppData objectForKey:@"EAPPDataSet"]objectForKey:@"eCFFPersonalInfo"]);
    //personal info for cff partner
    NSString *partnerAddFromCFF = @"";
    NSString *partnerAddNewPayor = @"";
    NSString *partnerSameAsPO = @"";
    NSString *partnerPTypeCode = @"";
    NSString *partnerPYFlag = @"";
    NSString *partnerTitle = @"";
    NSString *partnerName = @"";
    NSString *partnerNewICNo = @"";
    NSString *partnerOtherIDType = @"";
    NSString *partnerOtherID = @"";
    NSString *partnerNationality = @"";
    NSString *partnerRace = @"";
    NSString *partnerReligion = @"";
    NSString *partnerSex = @"";
    NSString *partnerSmoker = @"";
    NSString *partnerDob = @"";
    NSString *partnerAge = @"";
    NSString *partnerMaritalStatus = @"";
    NSString *partnerOccupation = @"";
    NSString *partnerResidenceNo = @"";
    NSString *partnerOfficePhoneNo = @"";
    NSString *partnerMobilePhoneNo = @"";
    NSString *partnerFaxPhoneNo = @"";
    NSString *partnerEmailAddress = @"";
    NSString *partnerAddressSameAsPO = @"";
    NSString *partnerAddress1 = @"";
    NSString *partnerAddress2 = @"";
    NSString *partnerAddress3 = @"";
    NSString *partnerTown = @"";
    NSString *partnerState = @"";
    NSString *partnerPostcode = @"";
    NSString *partnerCountry = @"";
    NSString *partnerForeignAddress = @"";
    NSString *partnerPermanentAddressSameAsPO = @"";
    NSString *partnerPermanentAddress1 = @"";
    NSString *partnerPermanentAddress2 = @"";
    NSString *partnerPermanentAddress3 = @"";
    NSString *partnerPermanentTown = @"";
    NSString *partnerPermanentState = @"";
    NSString *partnerPermanentPostcode = @"";
    NSString *partnerPermanentCountry = @"";
    NSString *partnerPermanentForeignAddress = @"";
    
    results = nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]]];
    NSLog(@"existing partner: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
    NSLog(@"partnerid: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]);
    while ([results next]) {
        partnerTitle = [self getTitleCode:[results stringForColumn:@"ProspectTitle"] passdb:database];
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
    
    if([partnerForeignAddress isEqualToString:@"0"])
    {
        partnerForeignAddress = @"N";
    }
    if ([partnerForeignAddress isEqualToString:@"1"])
    {
        partnerForeignAddress = @"Y";
        
    }
    
    if([partnerPermanentForeignAddress isEqualToString:@"0"])
    {
        partnerPermanentForeignAddress = @"N";
    }
    if ([partnerPermanentForeignAddress isEqualToString:@"1"])
    {
        partnerPermanentForeignAddress = @"Y";
        
    }
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
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
        
        NSLog(@"3");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:partnerInfo forKey:@"eCFFPartnerInfo"];
    }
    NSLog(@"3A");
    // child info
    results = nil;
    if (eAppIsUpdate) {
        results = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID = ?", cffId, nil];
    }
    else {
        results = [database executeQuery:@"select count(*) as cnt from CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
            results = [database executeQuery:@"select * from eProposal_CFF_Family_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
        NSLog(@"4");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:childsInfo forKey:@"eCFFChildInfo"];
    }
    NSLog(@"4A");
    //protection info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Protection where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
        hasProtection = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
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
                                         @"TotalPA_SurAmt" : totalPASurAmt
                                         };
        NSLog(@"5");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionInfo forKey:@"eCFFProtectionInfo"];
    }
    NSLog(@"5A");
    //protection details
    results = Nil;
    int protectionCount;
    protectionCount = 0;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_Protection_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    else  {
        results = [database executeQuery:@"select * from eProposal_CFF_Protection_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
        NSLog(@"6");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionsDetails forKey:@"eCFFProtectionDetails"];
    }
    NSLog(@"6A");
    //retirement info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
    }
    
    NSString *retirementAllocateIncome1;
    NSString *retirementAllocateIncome2;
    NSString *incomeSource1;
    NSString *incomeSource2;
    NSString *curAmt;
    NSString *reqAmt;
    NSString *surAmt;
    NSString *noExistingPlan = @"True";
    
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
        NSLog(@"7");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementInfo forKey:@"eCFFRetirementInfo"];
    }
    NSLog(@"7A");
    results = Nil;
    int retirementCount;
    retirementCount = 0;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_Retirement_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Retirement_Details where where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
        NSLog(@"8");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementsDetails forKey:@"eCFFRetirementDetails"];
    }
    NSLog(@"8A");
    //education info
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
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
                                        @"SurAmt_C4" : surAmtC4
                                        };
        NSLog(@"9");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationInfo forKey:@"eCFFEducationInfo"];
    }
    NSLog(@"9A");
    //education details
    results = Nil;
    int educationCount;
    educationCount = 0;
    NSMutableArray *educationsDetails = [NSMutableArray array];
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_Education_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_Education_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
        NSLog(@"10");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationsDetails forKey:@"eCFFEducationDetails"];
    }
    NSLog(@"10A");
    //savings info
    NSString *savingsAllocateIncome1;
    NSString *savingsCurAmt;
    NSString *savingsReqAmt;
    NSString *savingsSurAmt;
    NSString *savingsNoExistingPlan=@"True";
    bool gotSavings = FALSE;
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:[NSString stringWithFormat: @"select * from CFF_SavingsInvest where CFFID = '%@'",cffId]];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
                                     @"SurAmt" : savingsSurAmt
                                     };
        NSLog(@"11");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingInfo forKey:@"eCFFSavingInfo"];
        
    }
    NSLog(@"11A");
    //savings details
    results = Nil;
    int savingsCount;
    savingsCount = 0;
    NSMutableArray *savingsDetails = [NSMutableArray array];
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_SavingsInvest_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
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
        NSLog(@"12");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingsDetails forKey:@"eCFFSavingsDetails"];
    }
    NSLog(@"12A");
    
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = ? and Priority = '1'",cffId,Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '1' order by Seq asc",cffId,Nil];
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
    NSLog(@"13");
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = ? and Priority = '2'",cffId,Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '2' order by Seq asc",cffId,Nil];
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
        NSLog(@"14");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recordOfAdviceP2 forKey:@"eCFFRecoredOfAdviceP2"];
    }
    NSLog(@"14A");
    //Section I
    NSString *choice1 = @"";
    NSString *choice2 = @"";
    NSString *choice3 = @"";
    NSString *choice4 = @"";
    NSString *choice5 = @"";
    NSString *choice6 = @"";
    NSString *choice6Desc = @"";
    
    results = Nil;
    if (!eAppIsUpdate) {
        results = [database executeQuery:@"select * from CFF_CA where CFFID = ?",cffId,Nil];
    }
    else {
        results = [database executeQuery:@"select * from eProposal_CFF_CA where CFFID = ?",cffId,Nil];
    }
    
    while ([results next]) {
        NSLog(@"14B");
        choice1 = [results stringForColumn:@"Choice1"] != NULL ? [results stringForColumn:@"Choice1"] : @"FALSE";
        choice2 = [results stringForColumn:@"Choice2"] != NULL ? [results stringForColumn:@"Choice2"] : @"FALSE";
        choice3 = [results stringForColumn:@"Choice3"] != NULL ? [results stringForColumn:@"Choice3"] : @"FALSE";
        choice4 = [results stringForColumn:@"Choice4"] != NULL ? [results stringForColumn:@"Choice4"] : @"FALSE";
        choice5 = [results stringForColumn:@"Choice5"] != NULL ? [results stringForColumn:@"Choice5"] : @"FALSE";
        choice6 = [results stringForColumn:@"Choice6"] != NULL ? [results stringForColumn:@"Choice6"] : @"FALSE";
        choice6Desc = [results stringForColumn:@"Choices6Desc"] != NULL ? [results stringForColumn:@"Choices6Desc"] : @"";
    }
    
    NSDictionary *confirmationOfAdviceGivenTo = @{@"Choice1" : ![choice1 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice2" : ![choice2 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice3" : ![choice3 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice4" : ![choice4 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice5" : ![choice5 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice6" : ![choice6 isEqualToString:@"FALSE"] ? @"TRUE" : @"FALSE",
                                                  @"Choice6_desc" : choice6Desc,
                                                  };
    NSLog(@"15");
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:confirmationOfAdviceGivenTo forKey:@"eCFFConfirmationAdviceGivenTo"];
    
    results = Nil;
    int recommendCount;
    recommendCount = 0;
    NSMutableArray *recommendedProducts = [NSMutableArray array];
    NSString *siNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    NSString *insuredName;
    NSString *planType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
	NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"]; 
    NSString *term;
    NSString *premium;
    NSString *frequency = @"12";
    NSString *SA;
    NSString *boughtOption = @"Y";
    NSString *addNew = @"";
    NSString *additionalBenefits = @"";
    
    if ([SIType isEqualToString:@"TRAD"]) {
        results = [database executeQuery:@"select b.name from Trad_LAPayor as a, Clt_Profile as b where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.sequence = '1'", siNo, Nil];
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
    else if ([SIType isEqualToString:@"ES"]) {
        results = [database executeQuery:@"select b.name from UL_LAPayor as a, Clt_Profile as b where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.seq = '1'", siNo, Nil];
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
        results = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
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
        NSLog(@"16");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recommendedProducts forKey:@"eCFFRecommendedProducts"];
        
    }
    NSLog(@"16A");
}

#pragma mark - country
-(NSString*) getCountryDesc : (NSString*)country passdb:(FMDatabase*)db
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        
    }
    
    [result close];
    // [db close];
    
    return code;
    
}


-(NSString*) getCountryCode :  (NSString*)country passdb:(FMDatabase*)db
{
    NSLog(@"getCountryCode - country - %@",country);
    NSString *code = @"";
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    
    
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    int count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"CountryCode"];
		count = count + 1;
    }
    
    [result close];
    //  [db close];
    if (count == 0)
		code = country;
    return code;
    
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
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT RelCode FROM eProposal_Relation WHERE RelDesc = ?", relationship];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"RelCode"];
    }
    
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

-(NSString*) getTitleCode : (NSString*)title passdb:(FMDatabase*)db
{
	if ([title isEqualToString:@""] || (title == NULL) || ([title isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", title];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code = [result objectForColumnName:@"TitleCode"];
    }
    
    [result close];
    // [db close];
	
	if (count == 0) {
		code = title;
	}
    
    return code;
    
}


@end//
