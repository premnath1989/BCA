
//
//  pending.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "submittedVC.h"
#import "FMResultSet.h"
#import "DataClass.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "ColorHexCode.h"
#import "AFXMLRequestOperation.h"
#import "SIUtilities.h"
#import "NSStringAdditions.h"
#import "MBProgressHUD.h"
#import "eAppReport.h"
#import "UIDevice+IdentifierAddition.h"
#import <dlfcn.h>
#import <mach/port.h>
#import <mach/kern_return.h>
#import <AdSupport/ASIdentifierManager.h>
#import "ClearData.h"


//#import "WSESub.h"



@interface submittedVC ()
{
    NSMutableArray *dataArrayM;
    NSMutableArray *submittedRecordsArrayM;
    NSString *databasePath;
    NSMutableArray *selectedItems;
    NSMutableArray *selectedRecords;
    
    BOOL isSearching;
    sqlite3 *updateDB;
    
    BOOL CustomersBool,PolBool,RefBool,ErrorBool,IsErrorBool,ErrorRefBool,errorcodeBool,errordescBool,createdBool;
    
    NSMutableArray *resultArray,*refArray,*isErrorArray,*errorRefArray,*errorCodeArray,*errorDescArray,*errorCreatedArray;
    
    NSString *resString,*errorString,*refString;
    
    DataClass *obj;
    
    
    //  WSESub *ws;
}
@property (retain, nonatomic) NSMutableArray *POName;
@property (retain, nonatomic) NSMutableArray *IDNo;
@property (retain, nonatomic) NSMutableArray *OtherIDNo;
@property (retain, nonatomic) NSMutableArray *ProposalNo;
@property (retain, nonatomic) NSMutableArray *LastUpdated;

@property (retain, nonatomic) NSMutableArray *planName;

@property (retain, nonatomic) NSMutableArray *PolicyNo;

@property (retain, nonatomic) NSMutableArray *Status;
@property (retain, nonatomic) NSMutableArray *SIVersion;
@property (retain, nonatomic) NSMutableArray *eAppVersionM;

@property (retain, nonatomic) NSMutableArray *isDeleted;

@property (retain, nonatomic) NSMutableArray *PONameSearch;
@property (retain, nonatomic) NSMutableArray *ClientNameSearch;

@property (retain, nonatomic) NSMutableArray *IDNoSearch;
@property (retain, nonatomic) NSMutableArray *OtherIDNoSearch;
@property (retain, nonatomic) NSMutableArray *SINoSearch;

@property (retain, nonatomic) NSMutableArray *SINo;
@property (retain, nonatomic) NSMutableArray *ClientName;


@property (retain, nonatomic) NSMutableArray *ProposalNoSearch;
@property (retain, nonatomic) NSMutableArray *LastUpdatedSearch;
@property (retain, nonatomic) NSMutableArray *PolicyNoSearch;
@property (retain, nonatomic) NSMutableArray *StatusSearch;
@property (retain, nonatomic) NSMutableArray *eAppVersionSearchM;
@property (retain, nonatomic) NSMutableArray *SIVersionSearch;
@property (retain, nonatomic) NSMutableArray *eAppVersionMSearch;
@property (retain, nonatomic) NSMutableArray *isDeletedSearch;



//@property (retain, nonatomic) NSMutableArray *SINoSearch;
//@property (retain, nonatomic) NSMutableArray *ClientName;
//@property (retain, nonatomic) NSMutableArray *planName;


//@synthesize errorRefNo = _errorRefNo;
//@synthesize errorCode = _errorCode;
//@synthesize errorDesc = _errorDesc;
//@synthesize createdDate = _createdDate;


@end

@implementation submittedVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadTableData) name:@"ReloadSubmittedVC" object:nil];
	
    obj=[DataClass getInstance];
    selectedRecords=[[NSMutableArray alloc]init];
    
    self.submitTableView.backgroundView = nil;
    self.submitTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    CGRect frame = self.view.frame;
    frame.size.width = 1024;
    frame.size.height = 768;
    self.view.frame = frame;
    [self ReloadTableData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _btnDelete.hidden = TRUE;
    _btnDelete.enabled = FALSE;
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
    
//    CGRect frame1 = CGRectMake(0, 0, 400, 44);
//    UILabel *label = [[UILabel alloc] initWithFrame:frame1];
//    label.backgroundColor = [UIColor clearColor];
////    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
//    label.font = [UIFont boldSystemFontOfSize:20];
//    label.textAlignment = UITextAlignmentCenter;
//    label.textColor = [UIColor blueColor];
//    //    label.shadowColor = [UIColor grayColor];
//    //    label.shadowOffset = CGSizeMake(0, -1);
//    label.text = @"e-Application : Submitted Cases Listing";
//    self.navigationItem.titleView = label;
    
    
    
    [self resetTheScreen];
    
    
}
- (void) ReloadTableData
{
    
    //fmdb start
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_POName = [[NSMutableArray alloc] init];
	_IDNo = [[NSMutableArray alloc] init];
	_OtherIDNo = [[NSMutableArray alloc] init];
	_ProposalNo = [[NSMutableArray alloc] init];
	_LastUpdated = [[NSMutableArray alloc] init];
    _PolicyNo = [[NSMutableArray alloc] init];
    
	_Status = [[NSMutableArray alloc] init];
    //    _ClientName = [[NSMutableArray alloc] init];
    //    _SINo = [[NSMutableArray alloc] init];
    _planName = [[NSMutableArray alloc] init];
    _SIVersion = [[NSMutableArray alloc] init];
	_eAppVersionM = [[NSMutableArray alloc] init];
	_isDeleted = [[NSMutableArray alloc] init];
    //	FMResultSet *results = [database executeQuery:@"select POName,IDNumber,ProposalNo, DateCreated, status from eApp_Listing"];
    
    
//    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.OtherIDNo ,A.ProposalNo, A.DateCreated, A.DateUpdated, B.eAppVersion, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND A.status in (4,6,7) order by A.SubmitDate DESC, A.DateCreated DESC"];
	
	    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.OtherIDNo ,A.ProposalNo, A.DateCreated, A.DateUpdated, A.isDeleted, B.eAppVersion, D.status,B.SINo, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.status = D.StatusCode AND A.status in (4,6,7) order by A.SubmitDate DESC, A.DateCreated DESC"];
    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *OtherIDNo = [results stringForColumn:@"OtherIDNo"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
        NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
        
        NSString *lastupdated = [results stringForColumn:@"DateUpdated"];
        
        if ([lastupdated isEqualToString:@""]||lastupdated==Nil)
        {
            lastupdated = [results stringForColumn:@"DateCreated"];
        }

        NSString *isDeleted = [results stringForColumn:@"isDeleted"];
		if  ((NSNull *) isDeleted == [NSNull null] || isDeleted == nil)
            isDeleted = @"";
		
		//NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
        NSString *policyno;
        
        FMResultSet *resultsPOL = [database executeQuery:@"select PolicyNo from eProposal WHERE eProposalNo = ?",proposalno,nil];
        while ([resultsPOL next]) {
            NSString *policyno = [resultsPOL stringForColumn:@"PolicyNo"];
            if(policyno == nil)
                policyno = @"";
            [_PolicyNo addObject:policyno];
        }
        
        //        NSString *clientname = [results stringForColumn:@"ProspectName"];
        //		NSString *sino = [results stringForColumn:@"SINo"];
        //		NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
        NSString *eappVersion = [results stringForColumn:@"eAppVersion"];
        if (eappVersion == nil) {
            eappVersion = @"";
        }
        //        NSString *planname;
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        if  ((NSNull *) poname == [NSNull null])
            poname = @"";
        if  ((NSNull *) idno == [NSNull null])
            idno = @"";
        
        if(idno == nil)
            idno = @"";
		if  ((NSNull *) OtherIDNo == [NSNull null])
            OtherIDNo = @"";
        if(OtherIDNo == nil)
            OtherIDNo = @"";
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_OtherIDNo addObject:OtherIDNo];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        //        [_ClientName addObject:clientname];
        //        [_SINo addObject:sino];
        [_planName addObject:plancode];
        [_SIVersion addObject:siversion];
        [_eAppVersionM addObject:eappVersion];
		[_isDeleted addObject:isDeleted];
	}
    
	[database close];
	[self.submitTableView reloadData];
    
	//fmdb end
    //	isSearching = FALSE;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource Methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        
        return self.ProposalNoSearch.count;
    }
    else{
        return self.ProposalNo.count;
    }
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    PendingVCCell *cell = (PendingVCCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PendingVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    cell.nameLabel.textColor = [UIColor blackColor];
    UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(-30, 0, 30, 60)];
    [cell.contentView addSubview:custom];
    cell.idNOLabel.textColor = [UIColor blackColor];
    cell.siNOLabel.textColor = [UIColor blackColor];
    cell.proposalNOLabel.textColor = [UIColor blackColor];
    cell.creationDateLabel.textColor = [UIColor blackColor];
    cell.policyNo.textColor = [UIColor blackColor];
    cell.siVersionLabel.textColor = [UIColor blackColor];
    cell.eAppVersionLabel.textColor = [UIColor blackColor];
    cell.agentCodeLabel.textColor = [UIColor blackColor];
	
	NSString *IDNo, *otheridno;
    NSString *isDelete = @"N";

    
    if (isSearching) {
        cell.nameLabel.text = [self.PONameSearch objectAtIndex:indexPath.row];
        //cell.idNOLabel.text = [self.IDNoSearch objectAtIndex:indexPath.row];
		IDNo = [self.IDNoSearch objectAtIndex:indexPath.row];
		otheridno = [self.OtherIDNoSearch objectAtIndex:indexPath.row];
        //    cell.siNOLabel.text = [self.SINo objectAtIndex:indexPath.row];
        cell.proposalNOLabel.text = [self.ProposalNoSearch objectAtIndex:indexPath.row];
        //    cell.agentCodeLabel.text = @"A88888888";
        cell.creationDateLabel.text = [self.LastUpdatedSearch objectAtIndex:indexPath.row];
        //cell.policyNo.text = [resultArray objectAtIndex:indexPath.row];
        cell.policyNo.text = [self.PolicyNoSearch objectAtIndex:indexPath.row];
        //    cell.siVersionLabel.text = [self.SIVersion objectAtIndex:indexPath.row];
        cell.eAppVersionLabel.text = @"78788";
        cell.siVersionLabel.text = [self.SIVersionSearch objectAtIndex:indexPath.row];
        cell.siNOLabel.text = [self.StatusSearch objectAtIndex:indexPath.row];
		isDelete = [self.isDeletedSearch objectAtIndex:indexPath.row];
    }
    else{
        cell.nameLabel.text = [self.POName objectAtIndex:indexPath.row];
        //cell.idNOLabel.text = [self.IDNo objectAtIndex:indexPath.row];
		IDNo = [self.IDNo objectAtIndex:indexPath.row];
		otheridno = [self.OtherIDNo objectAtIndex:indexPath.row];
        //    cell.siNOLabel.text = [self.SINo objectAtIndex:indexPath.row];
        cell.proposalNOLabel.text = [self.ProposalNo objectAtIndex:indexPath.row];
        //    cell.agentCodeLabel.text = @"A88888888";
        cell.creationDateLabel.text = [self.LastUpdated objectAtIndex:indexPath.row];
        //cell.policyNo.text = [resultArray objectAtIndex:0];
        cell.policyNo.text = [self.PolicyNo objectAtIndex:indexPath.row];
        
        //  cell.policyNo.text = [self.PolicyNo objectAtIndex:indexPath.row];
        ////    cell.siVersionLabel.text = [self.SIVersion objectAtIndex:indexPath.row];
        cell.eAppVersionLabel.text = [self.eAppVersionM objectAtIndex:indexPath.row];
        cell.siVersionLabel.text = [self.SIVersion objectAtIndex:indexPath.row];
        cell.siNOLabel.text = [self.Status objectAtIndex:indexPath.row];
		isDelete = [self.isDeleted objectAtIndex:indexPath.row];
        
    }
	
    cell.toViewButton1.tag=indexPath.row;
    [cell.toViewButton1 addTarget:self action:@selector(toViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	
	if([cell.siNOLabel.text isEqualToString:@"Received"]) {
		cell.toViewButton1.hidden = TRUE;
	}
	else if([cell.siNOLabel.text isEqualToString:@"Submitted"] || [cell.siNOLabel.text isEqualToString:@"Failed"]) {
		cell.toViewButton1.hidden = FALSE;
		if ([isDelete isEqualToString:@"Y"]) {
			cell.toViewButton1.hidden = TRUE;
		}
	}
	
	if(![otheridno isEqualToString:@""] && ![IDNo isEqualToString:@""])
    {
        [cell.idNOLabel setNumberOfLines:2];
        cell.idNOLabel.text = [NSString stringWithFormat:@"%@\n%@", IDNo, otheridno];
    }
    else if(![IDNo isEqualToString:@""])
    {
        [cell.idNOLabel setNumberOfLines:1];
        cell.idNOLabel.text = IDNo ;
    }
    else if(![otheridno isEqualToString:@""])
    {
        [cell.idNOLabel setNumberOfLines:1];
        cell.idNOLabel.text= otheridno ;
    }
	
	
	
    if (indexPath.row%2)
    {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        custom.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
    }
    
    
    else
    {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        custom.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
    }
	
	
	
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *clt;
    int RecCount = 0;
    //If is for deletion purpose
    if ([self.submitTableView isEditing] == TRUE ) {
        
        BOOL gotRowSelected = FALSE;
        
        
        
        for (UITableViewCell *zzz in [self.submitTableView visibleCells])
            
        {
            
            if (zzz.selected  == TRUE) {
                
                gotRowSelected = TRUE;
                
                break;
                
            }
            
        }
        
        
        
        if (!gotRowSelected) {
            
            [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            
            _btnDelete.enabled = FALSE;
            
        }
        
        else {
            
            [_btnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            _btnDelete.enabled = TRUE;
            
        }
        
        
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        
        [ItemToBeDeleted addObject:zzz];
        
        [indexPaths addObject:indexPath];
        
    }
    
    //else is for checking status
    
    else {
        
        for (UITableViewCell *cell in [self.submitTableView visibleCells])
        {
            if (cell.selected == TRUE) {
                NSIndexPath *selectedIndexPath = [self.submitTableView indexPathForCell:cell];
                NSString *PONAME=nil;
                NSString *Status=nil;
                if (isSearching) {
                    PONAME= [_PONameSearch objectAtIndex:selectedIndexPath.row];
                    Status= [_StatusSearch objectAtIndex:selectedIndexPath.row];
                }
                else{
                    PONAME= [_POName objectAtIndex:selectedIndexPath.row];
                    Status= [_Status objectAtIndex:selectedIndexPath.row];
                }
                
                
                
                //**E
                if ([Status isEqualToString: @"Submitted"]) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @" "
                                          message: @"The confirmed proposal has been submitted to HLA, pending for Policy Number creation."
                                          delegate: self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    
                    [alert show];
                    
                }
                else if ([Status isEqualToString: @"Received"])
                {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle: @" "
                                          message: @"The submitted proposal has been successfully received and Policy Number is created."
                                          delegate: self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                    
                    [alert show];
                    
                }
                else if ([Status isEqualToString: @"Failed"])
                {
                    self.refreshButton.enabled = YES;
                    self.refreshButton.alpha = 1.0;
                    
                    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
                    self.errorVc = [nextStoryboard instantiateViewControllerWithIdentifier:@"ErrorViewController"];
                    
                    if (isSearching) {
                        self.errorVc.proposalNumber =[self.ProposalNoSearch objectAtIndex:indexPath.row];
                    }
                    else{
                        self.errorVc.proposalNumber=[self.ProposalNo objectAtIndex:indexPath.row];
                    }
                    //   // [self addChildViewController:self.errorDescVC];
                    //[self.view addSubview:self.errorDescVC.view];
                    NSLog(@"Selected pro.NO==%@",self.errorVc.proposalNumber);
                    //ErrorDescVC *mntVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"ErrorDescVC"];
                    self.errorVc.modalPresentationStyle = UIModalPresentationFormSheet;
                    [self presentModalViewController:self.errorVc animated:YES];
                    
                    if([selectedRecords containsObject:indexPath])
                    {
                        [selectedRecords removeObject:indexPath];
                    }
                    else
                    {
                        [selectedRecords addObject:indexPath];
                    }
                    
                }
				
				
                if (RecCount == 0) {
                    clt = PONAME;
                }
                
                RecCount = RecCount + 1;
                
                if (RecCount > 1) {
                    break;
                }
                //}
                
                
            }
        }
    }
}



-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *selectedIndexPaths = [tableView indexPathsForSelectedRows];
    if (!selectedIndexPaths) {
        self.refreshButton.enabled = YES;
        self.refreshButton.alpha = 1.0;
    }
    
    if([selectedRecords containsObject:indexPath])
    {
        [selectedRecords removeObject:indexPath];
    }
    
}

- (IBAction)doRefresh:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @" "
                          message: @"Record(s) refresh completed. Please check Proposal Status and Policy No.."
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert setTag:1003];
    [alert show];
    alert = Nil;
	
	self.refreshButton.enabled = YES;
	self.refreshButton.alpha = 1.0;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (IBAction)searchButtonClicked:(id)sender {
    [self.view endEditing:YES];
    if ([self.policyOwnerNameField.text length] == 0 && [self.idNoField.text length] == 0 && [self.selectField.text isEqualToString:@"- Select -"]){
		
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle: @" "
							  message:@"Search criteria is required. Please key in one of the criteria."
							  delegate: self
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
		alert = Nil;
		return;
        
    }
    
    else {
        isSearching = TRUE;
		int count = 0;
        
        FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
        [database open];
        
        _PONameSearch = [[NSMutableArray alloc] init];
        _IDNoSearch = [[NSMutableArray alloc] init];
		_OtherIDNoSearch = [[NSMutableArray alloc] init];
        _StatusSearch = [[NSMutableArray alloc] init];
        _ProposalNoSearch = [[NSMutableArray alloc] init];
        _LastUpdatedSearch = [[NSMutableArray alloc] init];
        _eAppVersionSearchM = [[NSMutableArray alloc]init];
        _SIVersionSearch = [[NSMutableArray alloc]init];
		_PolicyNoSearch = [[NSMutableArray alloc] init];
		_isDeletedSearch = [[NSMutableArray alloc] init];
		
        NSString *search_poname;
        NSString *search_idno;
        if (self.policyOwnerNameField.text)
            search_poname = [NSString stringWithFormat:@"%%%@%%", self.policyOwnerNameField.text];
        else
            search_poname = @"%%";
        
        if(self.idNoField.text)
            search_idno = [NSString stringWithFormat:@"%%%@%%", self.idNoField.text];
        else
            search_idno = @"%%";
        NSString *search_status;
        NSString *status_code;
        
        if([self.selectField.text isEqualToString:@"Created"])
            status_code = @"2";
        else if([self.selectField.text isEqualToString:@"Confirmed"])
            status_code = @"3";
        else if([self.selectField.text isEqualToString:@"Submitted"])
            status_code = @"4";
        else if([self.selectField.text isEqualToString:@"Received"])
            status_code = @"7";
        else if([self.selectField.text isEqualToString:@"Failed"])
            status_code = @"6";
		else if([self.selectField.text isEqualToString:@"- Select -"])
			status_code = @"4,6,7";
        
        if ([self.selectField.text caseInsensitiveCompare:@"-select-"] == NSOrderedSame) {
            search_status = @"%%%%";
        }
        else {
            search_status = [NSString stringWithFormat:@"%%%@%%", status_code];
        }
//        NSString *query = [NSString stringWithFormat:@"select A.POName, A.IDNumber, A.OtherIDNo, A.ProposalNo, A.DateCreated, A.DateUpdated, B.eAppVersion, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND A.status in (4,6,7) and A.POName like '%@' and (A.IDNumber like '%@' OR A.OtherIDNo like '%@') and A.status in (%@)",search_poname,search_idno,search_idno,status_code];
		
		NSString *query = [NSString stringWithFormat:@"select distinct A.POName, A.IDNumber, A.OtherIDNo, A.ProposalNo, A.DateCreated, A.DateUpdated, A.isDeleted, B.eAppVersion, D.status,B.SINo, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.status = D.StatusCode AND A.status in (4,6,7) and A.POName like '%@' and (A.IDNumber like '%@' OR A.OtherIDNo like '%@') and A.status in (%@)",search_poname,search_idno,search_idno,status_code];
        
        FMResultSet *results = [database executeQuery:query];
        NSString *str_search;
		
        results = nil;
        
        NSLog(@"%@", str_search);
        if (str_search == nil) {
            str_search = @"";
        }
        
        results = [database executeQuery:query];
        
        
        while([results next]) {
			count = count + 1;
            NSString *poname = [results stringForColumn:@"poname"];
            if (poname == nil) {
                poname = @"";
            }
            NSString *idno = [results stringForColumn:@"idnumber"];
            if (idno == nil) {
                idno = @"";
            }
			NSString *otherIDNo = [results stringForColumn:@"OtherIDNo"];
            if (otherIDNo == nil) {
                otherIDNo = @"";
            }
            NSString *proposalno = [results stringForColumn:@"proposalno"];
            if (proposalno == nil) {
                proposalno = @"";
            }
            
            NSString *lastupdated = [results stringForColumn:@"DateUpdated"];
            
            if ([lastupdated isEqualToString:@""]||lastupdated==Nil)
            {
                lastupdated = [results stringForColumn:@"DateCreated"];
            }
            
			NSString *isDeleted = [results stringForColumn:@"isDeleted"];
			if  ((NSNull *) isDeleted == [NSNull null] || isDeleted == nil)
				isDeleted = @"";
            
        //    NSString *lastupdated = [results stringForColumn:@"DateCreated"];
            if (lastupdated == nil) {
                lastupdated = @"";
            }
            NSString *status = [results stringForColumn:@"status"];
            if (status == nil) {
                status = @"";
            }
            NSString *eappVersionStr = [results stringForColumn:@"eAppVersion"];
            if (eappVersionStr == nil) {
                eappVersionStr = @"";
            }
            NSString *siVersion = [results stringForColumn:@"SIVersion"];
            if (siVersion == nil) {
                siVersion = @"";
            }
			
			NSString *policyno;
			
			FMResultSet *resultsPOL = [database executeQuery:@"select PolicyNo from eProposal WHERE eProposalNo = ?",proposalno,nil];
			while ([resultsPOL next]) {
				policyno = [resultsPOL stringForColumn:@"PolicyNo"];
				if(policyno == nil)
					policyno = @"";
				[_PolicyNoSearch addObject:policyno];
			}
            
            if([status isEqualToString:@"2"])
                status = @"Created";
            else  if([status isEqualToString:@"3"])
                status = @"Confirmed";
            else  if([status isEqualToString:@"4"])
                status = @"Submitted";
            else  if([status isEqualToString:@"7"])
                status = @"Received";
            else  if([status isEqualToString:@"6"])
                status = @"Failed";
            
            if(!str_search)
                str_search = @"";
            
            
            [_PONameSearch addObject:poname];
            [_IDNoSearch addObject:idno];
			[_OtherIDNoSearch addObject:otherIDNo];
            [_ProposalNoSearch addObject:proposalno];
            [_LastUpdatedSearch addObject:lastupdated];
            [_StatusSearch addObject:status];
            [_eAppVersionSearchM addObject:eappVersionStr];
            [_SIVersionSearch addObject:siVersion];
			[_isDeletedSearch addObject:isDeleted];
            
        }
        [database close];
        [self.submitTableView reloadData];
		
		if (count == 0)
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"No record found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			
			[alert show];
			alert = nil;
			//return;
		}
	}
}

- (IBAction)resetButtonClicked:(id)sender {
    self.policyOwnerNameField.text = @"";
    self.idNoField.text = @"";
    
    self.selectField.text = @"- Select -";
    isSearching = NO;
    [self.submitTableView reloadData];
}

- (void)resetTheScreen
{
    self.policyOwnerNameField.text = @"";
    self.idNoField.text = @"";
    
    self.selectField.text = @"- Select -";
    isSearching = NO;
    [self.submitTableView reloadData];
}

- (IBAction)refreshButtonClicked:(UIButton *)sender {
	
	NSString *ipSet = @"192.168.0.140";
	NSString *PONO = @""; 
	NSString *AgentNo = @"emi";
	
	NSUserDefaults *Temp = [NSUserDefaults standardUserDefaults];
	PONO = [Temp objectForKey:@"ProNo"];
	
	if (PONO == nil) {
		PONO = @"RN151106082136572"; 
	}
	
	
	NSString *strXML3 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><RetrievePolicyNumber xmlns='http://tempuri.org/'><agentCode>%@</agentCode><strPolNo>%@</strPolNo></RetrievePolicyNumber></soap:Body></soap:Envelope>", AgentNo, PONO];
	
	NSString *strURL = [NSString stringWithFormat:@"http://%@/AgentWebService/AgentMgmt.asmx?wsdl", ipSet];
	
	NSURL *url = [NSURL URLWithString:strURL];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request addValue:@"http://tempuri.org/RetrievePolicyNumber" forHTTPHeaderField:@"SOAPAction"];
	NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML3 length]];
	[request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[strXML3 dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSData *urlData;
	NSURLResponse *response;
	
	NSError *error;
	urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if(conn) {
		NSLog(@"Connection Successful");
	} else {
		NSLog(@"Connection could not be made");
	}
	
	
	NSString *replyString = [[NSString alloc] initWithBytes:[urlData bytes] length:[urlData length] encoding: NSASCIIStringEncoding];
	
	NSLog(@"reply: %@", replyString);


	NSRange rangeValue1 = [replyString rangeOfString:@"RetrievePolicyNumberResult" options:NSCaseInsensitiveSearch];
	
}



//- (IBAction)refreshButtonClicked:(UIButton *)sender {
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    xmlType = XML_TYPE_FETCH_PRAPOSAL_STATUS2;
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyMMdd"];
//    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
//    
//    ///////AD ID//////
//    
//    NSString *AdID = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    
//    NSLog(@"devideId %@",[[[UIDevice currentDevice] identifierForVendor] UUIDString]);
//    
//   // NSString *fileName = [NSString stringWithFormat:@"%@_%@.xml",date,[self GetUUID]];
//    // NSString *fileName = [NSString stringWithFormat:@"Example11111.xml"];
//    
//    NSString *fileName = [NSString stringWithFormat:@"%@_%@.xml",date,AdID];
//    
//    NSString *docFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [docFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@",fileName]];
//    
//    NSMutableString *xml = [NSMutableString stringWithFormat:@"<NewDataSet>"];
//    for (int rowIndex=0; rowIndex<[self.Status count]; rowIndex++)
//    {
//        if([[self.Status objectAtIndex:rowIndex] isEqualToString:@"Submitted"])
//        {
//            NSString *strProposalNo = [self.ProposalNo objectAtIndex:rowIndex];
//            
//            [xml appendString:[NSString stringWithFormat:@"<Table><eProposalNo>%@</eProposalNo></Table>",strProposalNo]];
//        }
//    }
//    
//    [xml appendString:[NSString stringWithFormat:@"</NewDataSet>"]];
//    
//    NSError *error;
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//    {
//        [xml writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    }
//    else
//    {
//        [[NSFileManager defaultManager] createFileAtPath:filePath
//                                                contents:[xml dataUsingEncoding:NSUTF8StringEncoding]
//                                              attributes:nil];
//    }
//    
//    
//    //convert to byte
//    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
//    // using base64StringFromData method, we are able to convert data to string
//    NSString *stXmlrFile = [NSString base64StringFromData:data length:[data length]];
//    // log the base64 encoded string
//    NSLog(@"Base64 Encoded string is %@",stXmlrFile);
//    
//    NSString *docname = fileName;
//    
//    //webservices
//    
//    NSString *strURL = [NSString stringWithFormat:@"%@esubmissionws/esubmissionxmlservice.asmx?wsdl",[SIUtilities WSLogin]];
//    NSLog(@"%@", strURL);
//    NSString *strXML = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><FetchProposalStatus xmlns='http://tempuri.org/'><docbinaryarray>%@</docbinaryarray><docname>%@</docname></FetchProposalStatus></soap:Body></soap:Envelope>",stXmlrFile,docname];
//    
//    
//    NSLog(@"%@", strXML);
//    
//    NSURL *url = [NSURL URLWithString:strURL];
//    // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url];
//    [request1 addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [request1 addValue:@"http://tempuri.org/FetchProposalStatus" forHTTPHeaderField:@"SOAPAction"];
//    NSString *msgLenght=[NSString stringWithFormat:@"%d",[strXML length]];
//    [request1 addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
//    [request1 setHTTPMethod:@"POST"];
//    [request1 setHTTPBody:[strXML dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Operation
//    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request1 success:^(NSURLRequest *request1, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
//        NSLog(@"FetchproposalStatus");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Status has been refreshed successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];                                                                                               alert.tag = 10;
//        [alert show];
//        alert = Nil;
//		
//		self.refreshButton.enabled = YES;
//		self.refreshButton.alpha = 1.0;
//        // NSDate *today=[NSDate date];
//        
//        NSString *LoginChannel =[NSString stringWithFormat:@"%@",[SIUtilities WSLogin]];
//        NSString *strUrl1=[NSString stringWithFormat:@"%@eSubmissionWS/Download/XMLRequest/",LoginChannel];
//       // NSString *strUrl1=@"http://www.hla.com.my:2880/eSubmissionWS/Download/XMLRequest/";
//        NSString *nameOfFile=fileName;
//        NSString *URL=[NSString stringWithFormat:@"%@%@",strUrl1,nameOfFile];
//        // NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx?wsdl",[SIUtilities WSLogin]];
//        NSURL *URL1 = [NSURL URLWithString:URL];
//        NSURLRequest *request22 = [NSURLRequest requestWithURL:URL1];
//        NSData *data22=[NSData dataWithContentsOfURL:URL1];
//        resultArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        refArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        isErrorArray =[[NSMutableArray alloc]initWithObjects:nil, nil];;
//        errorRefArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        errorCodeArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        errorDescArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        errorCreatedArray = [[NSMutableArray alloc]initWithObjects:nil, nil];
//        
//        // NSData *data = [NSData dataWithContentsOfFile:receivedDataString];
//        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data22];
//        [xmlParser setDelegate:self];
//        [xmlParser parse];
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        //fmdb start
//        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *docsDir = [dirPaths objectAtIndex:0];
//        NSString *status;
//        int i=0;
//        NSString *error_query;
//        NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] init];
//        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
//        sqlite3_stmt *statement;
//        
//        FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
//        [database open];
//        FMResultSet *results;
//        NSString *policyno_Query;
//        //update record status to Received or failure.
//        if (sqlite3_open([databasePath UTF8String], &updateDB) == SQLITE_OK)
//        {
//            
//            // if([status isEqualToString:@"6"]){
//            NSString *updatetSQL1 = [NSString stringWithFormat:@"update eApp_Listing SET Status='6' WHERE ProposalNo='RN140601032457862'",[selectedItems objectAtIndex:0] ] ;
//            //NSString *updatetSQL1 = [NSString stringWithFormat:@"update eApp_Listing SET Status='6' WHERE ProposalNo='%@'",[recordDic objectForKey:@"ProposalNo"]] ;
//            
//            if(sqlite3_prepare_v2(updateDB, [updatetSQL1 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
//                if (sqlite3_step(statement) == SQLITE_DONE) {
//                    NSLog(@"Update eapplisting status success for received");
//                }
//                else {
//                    NSLog(@"Update eapplisting status fail for received");
//                }
//                sqlite3_finalize(statement);
//            }
//            // }
//            // else if ([status isEqualToString:@"7"]){
//            // NSString *updatetSQL2 = [NSString stringWithFormat:@"update eApp_Listing SET Status='7' WHERE ProposalNo='RN140421101939051'",[selectedItems objectAtIndex:0] ] ;
//            //
//            //
//            // if(sqlite3_prepare_v2(updateDB, [updatetSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
//            // if (sqlite3_step(statement) == SQLITE_DONE) {
//            // NSLog(@"Update eapplisting status success for received");
//            //  }
//            // else {
//            // NSLog(@"Update eapplisting status fail for received");
//            //                                                        }
//            //                                                    sqlite3_finalize(statement);
//            //                                                    }
//            //  }
//            sqlite3_close(updateDB);
//        }
//        
//        // Getting policy No added by basvi
//        
//        if (refArray == nil || [refArray count] == 0)
//        {
//            return;
//        }
//        NSString *policyNO=[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:i]];
//        //  NSString *refNO=[NSString stringWithFormat:@"%@",[errorRefArray objectAtIndex:i]];
//        // NSString *isError=[NSString stringWithFormat:@"%@",[isErrorArray objectAtIndex:i]];
//        
//        if  ((NSNull *) policyNO == [NSNull null])
//            policyNO = @"";
//        //       if ([isError isEqualToString:@"Y"])
//        //     {
//        NSLog(@"the policy is number is nill");
//        // insert  error details to DB
//        for(i=0;i<errorRefArray.count;i++){
//            NSString *policyNO=[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:i]];
//            NSString *refNO=[NSString stringWithFormat:@"%@",[errorRefArray objectAtIndex:i]];
//            error_query = [NSString stringWithFormat:@"INSERT INTO eProposal_Error_Listing('RefNo','ErrorCode', 'ErrorDesc','CreateDate') VALUES ('%@','%@','%@','%@')",[errorRefArray objectAtIndex:i],[errorCodeArray objectAtIndex:i] ,[errorDescArray objectAtIndex:i] ,[errorCreatedArray objectAtIndex:i] ,nil];
//            [database executeUpdate:error_query];
//            NSString *updatetSQL1 = [NSString stringWithFormat:@"UPDATE eApp_Listing SET Status='6' WHERE ProposalNo='%@'",refNO,nil] ;
//            [database executeUpdate:updatetSQL1];
//
//            [self ReloadTableData];
//        }
//        
//        //         }
//        //    else     {
//        NSLog(@"the policy is number is not nill");
//        //update policy number no eproposal
//        NSString *policyno_Query1=@"";
//        for(i=0;i<refArray.count;i++)
//        {
//            NSString *policyNO=[NSString stringWithFormat:@"%@",[resultArray objectAtIndex:i]];
//            NSString *refNO=[NSString stringWithFormat:@"%@",[refArray objectAtIndex:i]];
//            policyno_Query1=[NSString stringWithFormat:@"UPDATE eProposal SET PolicyNo = '%@' WHERE eProposalNo = '%@' ",policyNO,refNO,nil];
//            [database executeUpdate:policyno_Query1];
//            if ([policyNO isEqualToString:@"-"]) {
//                NSString *updatetSQL2 = [NSString stringWithFormat:@"UPDATE eApp_Listing SET Status='6' WHERE ProposalNo='%@'",refNO,nil] ;
//                [database executeUpdate:updatetSQL2];
//            }
//            else{
//                NSString *updatetSQL1 = [NSString stringWithFormat:@"UPDATE eApp_Listing SET Status='7' WHERE ProposalNo='%@'",refNO,nil] ;
//                [database executeUpdate:updatetSQL1];
//				
//				//Clean Data when successfully submit
//				
//				ClearData *CleanData =[[ClearData alloc]init];
//				[CleanData SubmitedWipeOff:refNO];
//				
//            }
//            [self ReloadTableData];
//            //      }
//        }
//        [database close];
//    }
//                                                                                           failure:^(NSURLRequest *request1, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
//                                                                                               NSLog(@"Error:%@",[error localizedDescription]);
//                                                                                               NSLog(@"error in calling web service - FetchproposalStatus");
//                                                                                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Error in connecting to Web service. You will now be logged in as offline mode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                                                               alert.tag = 10;
//                                                                                               [alert show];
//                                                                                               alert = Nil;
//                                                                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                                                                           }];
//    [operation start];
//    
//    
//}

- (IBAction)refreshCancelButtonClicked:(UIButton *)sender {
    UIButton *localButton = (UIButton *) sender;
    if ([[localButton titleForState:UIControlStateNormal] isEqualToString:@"Refresh"]) {
        [self.submitTableView setEditing:YES animated:YES];
        [localButton setTitle:@"Cancel" forState:UIControlStateNormal];
        self.refreshButton.hidden = NO;
        self.refreshButton.enabled = NO;
        self.refreshButton.alpha = 0.4;
    }
    else
    {
        [self.submitTableView setEditing:NO animated:YES];
        [localButton setTitle:@"Refresh" forState:UIControlStateNormal];
        self.refreshButton.hidden = YES;
    }
}

- (NSString *)GetUUID
{
    NSString * result;
    //    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    //    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    NSString *udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];//[[UIDevice currentDevice] uniqueIdentifier];
    //CFRelease(theUUID);
    NSLog(@"%@",udid);
    result =[NSString stringWithFormat:@"%@", udid];
    assert(result != nil);
    
    NSLog(@"%@",result);
    return result;
    

}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.selectField) {
        //        [self setEditing:NO animated:YES];
        [self.view endEditing:YES];
        [textField setText:@"-select-"];
        //        btnStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if (_statusVC == Nil) {
            // _statusVC = [[eAppStatusList alloc] initWithStyle:UITableViewStylePlain];
            _statusVC = [[eAppStatusListforSubmitted alloc] initWithStyle:UITableViewStylePlain];
            _statusVC.delegate = self;
            _statusVC.items = [@[@"Submitted",@"Failed",@"Received"] mutableCopy];
            _statusPopover = [[UIPopoverController alloc] initWithContentViewController:_statusVC];
        }
        
        [_statusPopover presentPopoverFromRect:[textField frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
        return NO;
    }
    return YES;
}

-(void)selectedStatus:(NSString *)theStatus
{
    //    [btnStatus setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", theStatus] forState:UIControlStateNormal];
    [_statusPopover dismissPopoverAnimated:YES];
	self.selectField.text = theStatus;
}

#pragma mark - XML parser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //policybool = NO;
    
    
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
     attributes:(NSDictionary *)attributeDict
{
    
    
    
    if ([elementName isEqualToString:@"Customers"]) {
        CustomersBool = YES;
    }
    
    if ([elementName isEqualToString:@"Refno" ])
    {
        RefBool = YES;
    }
    
    if ([elementName isEqualToString:@"PolicyNo"] ) {
        PolBool = YES;
    }
    if ([elementName isEqualToString:@"IsError"])
    {
        IsErrorBool = YES;
    }
    
    
    if ([elementName isEqualToString:@"RefNo"])
    {
        ErrorRefBool = YES;
    }
    
    if ([elementName isEqualToString:@"ErrorCode" ])
    {
        errorcodeBool = YES;
    }
    if ([elementName isEqualToString:@"ErrorDescription" ])
    {
        errordescBool = YES;
    }
    if ([elementName isEqualToString:@"CreatedAt" ])
    {
        createdBool = YES;
    }
    
    
    
}


- (IBAction)btnCancelPressed:(id)sender
{
    [self resignFirstResponder];
    if ([_submitTableView isEditing]) {
        
        [self.submitTableView setEditing:NO animated:TRUE];
        _btnDelete.hidden = true;
        _btnDelete.enabled = false;
        [_btnCancel setTitle:@"Delete" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        
        [self.submitTableView setEditing:YES animated:TRUE];
        _btnDelete.hidden = FALSE;
        [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [_btnCancel setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
    
    
}

- (IBAction)btnDeletePressed:(id)sender
{
    
    NSString *clt;
    int RecCount = 0;
    for (UITableViewCell *cell in [self.submitTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.submitTableView indexPathForCell:cell];
			NSString *PONAME=nil;
            NSString *Status=nil;
            if (isSearching) {
                PONAME= [_PONameSearch objectAtIndex:selectedIndexPath.row];
                Status= [_StatusSearch objectAtIndex:selectedIndexPath.row];
            }
            else{
                PONAME= [_POName objectAtIndex:selectedIndexPath.row];
                Status= [_Status objectAtIndex:selectedIndexPath.row];
            }
			
			//**E
		   	if ([Status isEqualToString: @"Submitted"]) {
				RecCount = -3;
			}
            if (RecCount == 0) {
                clt = PONAME;
            }
			
            /*	if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
             NSString *SQL = [NSString stringWithFormat:@"select * from trad_lapayor as A, clt_profile as B, prospect_profile as C where A.custcode = B.custcode "
             "and B.indexno = c.indexno AND C.indexNo = '%@' ", pp.ProspectID];
             if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
             if (sqlite3_step(statement) == SQLITE_ROW) {
             CanDelete = FALSE;
             }
             else{
             CanDelete = TRUE;
             }
             sqlite3_finalize(statement);
             }
             sqlite3_close(contactDB);
             }
             */
            //	if (CanDelete == FALSE) {
            //		break;
            //	}
            //	else{
            RecCount = RecCount + 1;
            
            if (RecCount > 1) {
                break;
            }
			//}
            
            
        }
    }
    
	/*if (CanDelete == FALSE) {
     NSString *msg = @"Error, there is SI tie to the prospect";
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
     [alert show];
     
     }
     else{
     */
	//**E
	NSLog(@"RecCount: %d", RecCount);
	
	NSString *msg;
	if (RecCount == 1) {
		//msg = [NSString stringWithFormat:@"Delete %@",clt];
		msg = [NSString stringWithFormat:@"Are you sure you want to delete these eApps(s)?"];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	
	else if (RecCount < 0) {
		NSString *msg = @"The case in Submitted status is pending for policy number returned. Thus, deletion is not allowed.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
		[alert show];
	}
	
	else {
		//msg = @"Are you sure want to delete these Client(s)?";
		msg = [NSString stringWithFormat:@"Are you sure you want to delete these eApps(s)?"];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	//}
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
        // NSLog(@"delete!");
        // NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        
        
        NSLog(@"Before search=%@     after search=%@",_ProposalNo,_ProposalNoSearch);
		NSString *DelErrAt = @"";
        
        if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
        
        NSArray *sorted = [[NSArray alloc] init ];
        sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
            return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
        }];
        
        sqlite3_stmt *statement;
        NSString *proposal;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
			
            for(int a=0; a<sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;
                
                if (isSearching) {
                    proposal = [_ProposalNoSearch objectAtIndex:value];
                }
                else{
                    proposal = [_ProposalNo objectAtIndex:value];
                }
                
                
                //Delete eApp_Listing
                NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from eApp_Listing where ProposalNo = \"%@\"", proposal];
                
                const char *Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
					DelErrAt = @"eApp_Listing";
                    NSLog(@"Error in Delete Statement - eApp_Listing");
                }
                
                //Delete eProposal_LA_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_LA_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_LA_Details");
                }
                
                
                
                
                //Delete eProposal
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal");
                }
                
                
                
                //Delete eProposal_Existing_Policy_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
                }
                
                //Delete eProposal_Existing_Policy_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
                }
                
                
                
                //Delete eProposal_NM_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_NM_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_NM_Details");
                }
                
                
                //Delete eProposal_Trustee_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Trustee_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
                }
                
                
                //Delete eProposal_QuestionAns
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_QuestionAns where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
                }
                
                
                //Delete eProposal_Additional_Questions_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
                }
                
                
                
                //Delete eProposal_Additional_Questions_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
                }
                
                
                //DELETE CFF START
                
                //Delete eProposal_CFF_Master
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Master where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
                }
                
                
                
                
                //Delete eProposal_CFF_CA
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
                }
                
                
                //Delete eProposal_CFF_CA_Recommendation
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
                }
                
                
                //Delete eProposal_CFF_CA_Recommendation_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
                }
                
                
                //Delete eProposal_CFF_Education
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
                }
                
                
                
                //Delete eProposal_CFF_Education_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
                }
                
                
                
                //Delete eProposal_CFF_Family_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Family_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
                }
                
                
                
                
                //Delete eProposal_CFF_Personal_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
                }
                
                
                
                
                //Delete eProposal_CFF_Protection
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
                }
                
                
                
                
                
                //Delete eProposal_CFF_Protection_Details
				
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
                }
                
                
                
                //Delete eProposal_CFF_RecordOfAdvice
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
                }
                
                
                
                //Delete eProposal_CFF_RecordOfAdvice_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
                }
                
                
                
                //Delete eProposal_CFF_Retirement
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
                }
                
                
                //Delete eProposal_CFF_Retirement_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
                }
                
                
                
                //Delete eProposal_CFF_SavingsInvest
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
                }
                
                
                
                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }
                
                
                
                
                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }
                
                
                
                
                
                if (isSearching) {
                    [_ProposalNoSearch removeObjectAtIndex:value];
                }
                else{
                    [_ProposalNo removeObjectAtIndex:value];
                }
                
                
                //DELETE CFF END
                
                
                //  NSLog(@"%@",_ProposalNo);
                
                
                // NSLog(@"%@",_ProposalNo);
            }
            sqlite3_close(contactDB);
        }
        
        // NSLog(@"%@",_ProposalNo);
        [self.submitTableView beginUpdates];
        [self.submitTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.submitTableView endUpdates];
        [self ReloadTableData];
        //[self.submitTableView reloadData];
        
        if (ItemToBeDeleted==nil){
            ItemToBeDeleted = [[NSMutableArray alloc] init];
        }
        else{
            [ItemToBeDeleted removeAllObjects];
        }
        if (indexPaths==nil){
            indexPaths = [[NSMutableArray alloc] init];
        }
        else{
            [indexPaths removeAllObjects];
        }
        
        _btnDelete.enabled = FALSE;
        [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
		
		if ([DelErrAt isEqualToString:@""]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"e-Application case has been successfully deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
    }
}


-(void)toViewButtonAction:(id)sender{
    
    NSString* proposalNUmber;
    NSString* siNumber;
    NSString* siplanename;
    NSString* siversion;
    UIButton* selectedCellButton=(UIButton *)sender;
    //[recordDic setObject:[self.SIVersion objectAtIndex:path.row] forKey:@"SIVersion"];
    
    if (isSearching) {
        proposalNUmber=_ProposalNoSearch[selectedCellButton.tag];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNUmber forKey:@"eProposalNo"];
        siNumber=_SINoSearch[selectedCellButton.tag];
        
    }
    else{
        proposalNUmber=_ProposalNo[selectedCellButton.tag];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNUmber forKey:@"eProposalNo"];
        siNumber=_SINoSearch[selectedCellButton.tag];
        siplanename=_planName[selectedCellButton.tag];
        //siversion=_SIVersionSearch[selectedCellButton.tag];
    }
    
    obj = [DataClass getInstance];
    
    NSLog(@"Eapp dic is ===%@",[obj.eAppData objectForKey:@"EAPP"]);
    if (obj.eAppData==nil) {
        //
        obj.eAppData=[NSMutableDictionary new];
        
        NSMutableDictionary* eappDic=[NSMutableDictionary new];
        [eappDic setObject:proposalNUmber forKey:@"eProposalNo"];
        [eappDic setObject:proposalNUmber forKey:@"SINo"];
        [eappDic setObject:siplanename forKey:@"SIPlanName"];
        //[eappDic setObject:siversion forKey:@"SIVersion"];
        [obj.eAppData setObject:eappDic forKey:@"EAPP"];
        
        // [eappDic objectForKey:@"eProposalNo": forKey:<#(NSString *)#>]
        //
        //        [obj.eAppData setValue:<#(id)#> forKey:<#(NSString *)#>]
    }
    if ([obj.eAppData objectForKey:@"EAPP"]==nil){
        
    }
    NSLog(@"Eapp dic is ===%@",[obj.eAppData objectForKey:@"EAPP"]);
    
    //objectForKey:@"eProposalNo"]
    
    // [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNUmber];
    //[obj.eAppData  setValue:_ProposalNoSearch[selectedCellButton.tag] forKey:@"eA"]
    
    
    
    
    NSLog(@"toview tag=%i and eapp number =%@",selectedCellButton.tag,[[obj.eAppData objectForKey:@"EAPP"] valueForKey:@"eProposalNo"]);
    NSLog(@"toview tag=%i and eapp number =%@",selectedCellButton.tag,_ProposalNo);
    NSLog(@"toview tag=%i and eapp number =%@",selectedCellButton.tag,_ProposalNo[selectedCellButton.tag]);
    
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    AppDelegate*  appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appobject.ViewFromSubmissionBool=YES;
    appobject.ViewDeleteSubmissionBool=YES;
    eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
    
    report.modalPresentationStyle = UIModalPresentationFullScreen;
    report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:report animated:YES completion:NULL];
    report = Nil;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //     string = [string stringByReplacingOccurrencesOfString:@"\n      " withString:@""];
    //     NSString *value= [[[NSString alloc] initWithString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (RefBool) {
        
        [refArray addObject:string];
        NSLog(@"Reference  No is %@",refArray);
    }
    if (PolBool) {
        
        [resultArray addObject:string];
        NSLog(@"Policy No is %@",resultArray);
        //[self.submitTableView reloadData];
    }
    
    if (IsErrorBool) {
        
        [isErrorArray addObject:string];
        NSLog(@"is  Error is %@",isErrorArray);
    }
    
    
    if (ErrorRefBool) {
        
        [errorRefArray addObject:string];
        NSLog(@"Reference  No for Error is %@",errorRefArray);
    }
    
    if (errorcodeBool) {
        
        [errorCodeArray addObject:string];
        NSLog(@"error code  is %@",errorCodeArray);
    }
    if (errordescBool) {
        
        [errorDescArray addObject:string];
        NSLog(@"error description no is %@",errorDescArray);
    }
    if (createdBool) {
        
        [errorCreatedArray addObject:string];
        NSLog(@"error created date is %@",errorCreatedArray);
    }
    
    
    
}







- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"Customers"]) {
        CustomersBool = NO;
    }
    
    if ([elementName isEqualToString:@"Refno"]) {
        RefBool = NO;
    }
    
    if ([elementName isEqualToString:@"PolicyNo"]) {
        PolBool = NO;
    }
    
    
    
    if ([elementName isEqualToString:@"IsError"])
    {
        IsErrorBool = NO;
    }
    
    if ([elementName isEqualToString:@"RefNo"]) {
        ErrorRefBool = NO;
    }
    if ([elementName isEqualToString:@"ErrorCode"]) {
        errorcodeBool = NO;
    }
    
    if ([elementName isEqualToString:@"ErrorDescription"]) {
        errordescBool = NO;
    }
    if ([elementName isEqualToString:@"CreatedAt"]) {
        createdBool = NO;
    }
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}

- (void)viewDidUnload {
    //[self setPolicyno:nil];
    [self setPolicyno:nil];
    [super viewDidUnload];
}
@end
