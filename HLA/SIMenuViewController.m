//
//  SIMenuViewController.m
//  HLA Ipad
//
//  Created by shawal sapuan on 10/3/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIMenuViewController.h"
#import "NewLAViewController.h"
#import "BasicPlanViewController.h"
#import "RiderViewController.h"
#import "SecondLAViewController.h"
#import "PayorViewController.h"
#import "PremiumViewController.h"
#import "MainScreen.h"
#import "ReportViewController.h"
#import "BrowserViewController.h"
#import "PDSViewController.h"
#import "CashPromiseViewController.h"
#import "AppDelegate.h"
#import "MaineApp.h"
#import "ColorHexCode.h"
#import "SubDetails.h"
#import "DBController.h"
#import "eAppCheckList.h"
#import "MasterMenuEApp.h"
//#import "PremiumViewController.h"
#import "Cleanup.h"

#define TRAD_PAYOR_FIRSTLA  @"0"
#define TRAD_PAYOR_SECONDLA  @"1"
#define TRAD_PAYOR_PAYOR  @"2"
#define TRAD_DETAILS_BASICPLAN @"3"
#define TRAD_RIDER_DETAILS @"4"

@interface SIMenuViewController ()

@end

@implementation SIMenuViewController
@synthesize myTableView, SIshowQuotation;
@synthesize RightView,EAPPorSI;
@synthesize ListOfSubMenu,SelectedRow;
@synthesize menuBH,menuPH,menuLa2ndH,getCommDate;
@synthesize getAge,getSINo,getOccpCode,getbasicSA;
@synthesize payorCustCode,payorSINo,CustCode2,clientID2,getPayorIndexNo,get2ndLAIndexNo;
@synthesize LAController = _LAController;
@synthesize PayorController = _PayorController;
@synthesize SecondLAController = _SecondLAController;
@synthesize BasicController = _BasicController;
@synthesize getIdPay,getIdProf,getPayAge,getPayDOB,getPayOccp,getPaySex,getPaySmoker;
@synthesize get2ndLAAge,get2ndLADOB,get2ndLAOccp,get2ndLASex,get2ndLASmoker,getOccpClass;
@synthesize getMOP,getbasicHL,getPlanCode,getAdvance,requestSINo2;
@synthesize RiderController = _RiderController;
@synthesize Name2ndLA,NameLA,getLAIndexNo,NamePayor,getSex,getbasicTempHL,getSmoker,getBasicPlan, PDFCreator, riderCode, getPlanName;
@synthesize FS = _FS;   
@synthesize HLController = _HLController;
id RiderCount;
@synthesize isNewSI;
@synthesize dataTable = _dataTable;
@synthesize db = _db;


const NSString * SUM_MSG_HLACP = @"Guaranteed Yearly Income";
const NSString * SUM_MSG_L100 = @"Basic Sum Assured";
int CurrentPath;
- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF
{
    NSLog(@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath);
	BrowserViewController *controller = [[BrowserViewController alloc] initWithFilePath:htmlToPDF.PDFpath PDSorSI:PDSorSI TradOrEver:@"Trad"];
	if([PDSorSI isEqualToString:@"PDS"]){
		controller.title = [NSString stringWithFormat:@"PDS_%@.pdf",self.getSINo];
	}else
    if([PDSorSI isEqualToString:@"UNDERWRITING"]){
		controller.title = [NSString stringWithFormat:@"UNDERWRITING_%@.pdf",self.getSINo];
	}	
	else{
		controller.title = [NSString stringWithFormat:@"%@.pdf",self.getSINo];
	}
	
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    UINavigationController *container = [[UINavigationController alloc] init];
    [container setNavigationBarHidden:YES animated:NO];
    [container setViewControllers:[NSArray arrayWithObject:navController] animated:NO];
    
	
	[spinner_SI stopAnimating ];
	[self.view setUserInteractionEnabled:YES];
	[_FS Reset];
	
	UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
	[v removeFromSuperview];
	v = Nil;
	
	if (previousPath == Nil) {
		previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
	}
	
	[self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	selectedPath = previousPath;
	spinner_SI = Nil;
	
//    [self presentModalViewController:container animated:YES]; // deprecated
    [self presentViewController:container animated:YES completion:nil];
    container = Nil;
	controller= Nil;
}

- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF
{
    NSLog(@"HTMLtoPDF did fail (%@)", htmlToPDF);
}

-(void)loadLAPage
{	
	if(_LAController != Nil)
    {
		_LAController = Nil;
    }
    
	self.LAController = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
	_LAController.delegate = self;
	if(getSINo)
	{
		NSLog(@"with SI");
		
		self.LAController.requestSINo = getSINo;
		self.LAController.EAPPorSI = [self.EAPPorSI description];
		self.LAController.requesteProposalStatus = eProposalStatus;
	}
	else{
		
		self.LAController.requestIndexNo = getLAIndexNo;
		self.LAController.requestLastIDPay = getIdPay;
		self.LAController.requestLastIDProf = getIdProf;
		self.LAController.requestCommDate = getCommDate;
		self.LAController.requestSex = getSex;
		self.LAController.requestSmoker = getSmoker;
		self.LAController.requesteProposalStatus = eProposalStatus;
		
	}
	
	[self addChildViewController:self.LAController];
	[self.RightView addSubview:self.LAController.view];
    
}
-(void)loadSecondLAPage
{
    if(!self.requestSINo)
    {
        isSecondLaNeeded = NO;
    }
    else{
        isSecondLaNeeded = [self requestSecondLA:[self.requestSINo description]];
    }
    if ([self select2ndLA]) {
        
        if (!_SecondLAController) {
            
            self.SecondLAController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondLAView"];
            _SecondLAController.delegate = self;
            self.SecondLAController.requestLAIndexNo = getLAIndexNo;
			self.SecondLAController.EAPPorSI = [self.EAPPorSI description];
            self.SecondLAController.requestCommDate = getCommDate;
            self.SecondLAController.requestSINo = getSINo;
			self.SecondLAController.requesteProposalStatus = eProposalStatus;
            [self addChildViewController:self.SecondLAController];
            [self.RightView addSubview:self.SecondLAController.view];
        }
        else{
            self.SecondLAController.requestSINo = getSINo;
            [self.RightView bringSubviewToFront:self.SecondLAController.view];
            
        }
        previousPath = selectedPath;
        blocked = NO;
        
        [self hideSeparatorLine];
        [myTableView reloadData];		
    }
}
-(void)loadPayorPage
{
    isSecondLaNeeded = NO;
	
	if (!_PayorController) {
		self.PayorController = [self.storyboard instantiateViewControllerWithIdentifier:@"payorView"];
		_PayorController.delegate = self;
		self.PayorController.requestLAIndexNo = getLAIndexNo;
		self.PayorController.EAPPorSI = [self.EAPPorSI description];
		self.PayorController.requestLAAge = getAge;
		self.PayorController.requestCommDate = getCommDate;
		self.PayorController.requestSINo = getSINo;
		self.PayorController.requesteProposalStatus = eProposalStatus;
		[self addChildViewController:self.PayorController];
		[self.RightView addSubview:self.PayorController.view];
	}
	else{
		self.PayorController.requestLAIndexNo = getLAIndexNo;
		self.PayorController.EAPPorSI = [self.EAPPorSI description];
		self.PayorController.requestLAAge = getAge;
		self.PayorController.requestCommDate = getCommDate;
		self.PayorController.requestSINo = getSINo;
		self.PayorController.requesteProposalStatus = eProposalStatus;
		[self.PayorController loadData];
		[self.RightView bringSubviewToFront:self.PayorController.view];
	}
	previousPath = selectedPath;
	blocked = NO;
	
	[self hideSeparatorLine];
	[myTableView reloadData];	
}

-(void)loadBasicPlanPage:(BOOL) loadsView
{
    if([self selectBasicPlan])
    {
        
        if (!_BasicController) {
            self.BasicController = [self.storyboard instantiateViewControllerWithIdentifier:@"BasicPlanView"];
            _BasicController.delegate = self;
            
            self.BasicController.requestAge = getAge;
			self.BasicController.EAPPorSI = [self.EAPPorSI description];
            self.BasicController.requestOccpCode = getOccpCode;
            self.BasicController.requestOccpClass = getOccpClass;
            self.BasicController.requestIDPay = getIdPay;
            self.BasicController.requestIDProf = getIdProf;
            
            self.BasicController.requestIndexPay = getPayorIndexNo;
            self.BasicController.requestSmokerPay = getPaySmoker;
            self.BasicController.requestSexPay = getPaySex;
            self.BasicController.requestDOBPay = getPayDOB;
            self.BasicController.requestAgePay = getPayAge;
            self.BasicController.requestOccpPay = getPayOccp;
            
            self.BasicController.requestIndex2ndLA = get2ndLAIndexNo;
            self.BasicController.requestSmoker2ndLA = get2ndLASmoker;
            self.BasicController.requestSex2ndLA = get2ndLASex;
            self.BasicController.requestDOB2ndLA = get2ndLADOB;
            self.BasicController.requestAge2ndLA = get2ndLAAge;
            self.BasicController.requestOccp2ndLA = get2ndLAOccp;
            
            self.BasicController.requestSINo = getSINo;
            self.BasicController.requesteProposalStatus = eProposalStatus;
            
            self.BasicController.MOP = getMOP;
            self.BasicController.requestEDD = getEDD;
			
            [self.BasicController loadData];
            
            if(loadsView)
            {
                [self addChildViewController:self.BasicController];
                [self.RightView addSubview:self.BasicController.view];
            }            
        }
        else
        {
            self.BasicController.requestAge = getAge;
			self.BasicController.EAPPorSI = [self.EAPPorSI description];
            self.BasicController.requestOccpCode = getOccpCode;
            self.BasicController.requestOccpClass = getOccpClass;
            self.BasicController.requestIDPay = getIdPay;
            self.BasicController.requestIDProf = getIdProf;
            
            self.BasicController.requestIndexPay = getPayorIndexNo;
            self.BasicController.requestSmokerPay = getPaySmoker;
            self.BasicController.requestSexPay = getPaySex;
            self.BasicController.requestDOBPay = getPayDOB;
            self.BasicController.requestAgePay = getPayAge;
            self.BasicController.requestOccpPay = getPayOccp;
            
            self.BasicController.requestIndex2ndLA = get2ndLAIndexNo;
            self.BasicController.requestSmoker2ndLA = get2ndLASmoker;
            self.BasicController.requestSex2ndLA = get2ndLASex;
            self.BasicController.requestDOB2ndLA = get2ndLADOB;
            self.BasicController.requestAge2ndLA = get2ndLAAge;
            self.BasicController.requestOccp2ndLA = get2ndLAOccp;
            
            self.BasicController.requestSINo = getSINo;
			self.BasicController.requesteProposalStatus = eProposalStatus;
            self.BasicController.getPolicyTerm = getTerm;
            
            self.BasicController.MOP = getMOP;
            self.BasicController.requestEDD = getEDD;
            
            [self.BasicController loadData];
            
            if(loadsView) {
                [self.RightView bringSubviewToFront:self.BasicController.view];
            }
        }
        previousPath = selectedPath;
        blocked = NO;
        [self hideSeparatorLine];
        [myTableView reloadData];		
    }	
}

-(void)loadHLPage
{
    if (getAge < 10 && payorSINo.length == 0) {        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        blocked = YES;
    }
    else 
    {
        if (getSINo) {            
            if(!_HLController)
            {
                self.HLController = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthLoadView"];
                _HLController.delegate = self;
                self.HLController.ageClient = getAge;
                self.HLController.EAPPorSI = [self.EAPPorSI description];
                self.HLController.SINo = getSINo;
                self.HLController.planChoose = getBasicPlan;
                self.HLController.getMOP = getMOP;
                self.HLController.requesteProposalStatus = eProposalStatus;
                
                [self addChildViewController:self.HLController];
                [self.RightView addSubview:self.HLController.view];
                
            }
            else{
                self.HLController.ageClient = getAge;
                self.HLController.EAPPorSI = [self.EAPPorSI description];
                self.HLController.SINo = getSINo;
                self.HLController.planChoose = getBasicPlan;
                self.HLController.getMOP = getMOP;
                self.HLController.requesteProposalStatus = eProposalStatus;
                
                [self.HLController loadHL];
                [self.RightView bringSubviewToFront:self.HLController.view];
                
            }
            previousPath = selectedPath;
            blocked = NO;
            [self hideSeparatorLine];
//            [myTableView reloadData];
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please Press On Done Button First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
        }
	}
}

-(BOOL)requestSecondLA:(NSString*)SINo
{
    NSString* custCodeForSecondLa;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT a.SINo, a.CustCode FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo='%@' AND a.PTypeCode='LA' AND a.Sequence=2",SINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {                
                custCodeForSecondLa = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
    return custCodeForSecondLa?YES:NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resignFirstResponder];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    //--for table view
    [self.view addSubview:myTableView];
    [self.view addSubview:RightView];
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Life Assured", @"   2nd Life Assured", @"   Payor", @"Basic Plan", nil ];
    appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    PlanEmpty = YES;
    added = NO;
    saved = YES;
    payorSaved = YES;
    
    LAotherIDType = @"";
    
    myTableView.rowHeight = 44;
    [myTableView reloadData];
        
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    if ([[self.EAPPorSI description] isEqualToString:@"eAPP"]) {
        
        
        CGRect frame = CGRectMake(0, 0, 220, 30);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
        label.font = [UIFont boldSystemFontOfSize:20];
//        label.textAlignment = UITextAlignmentCenter;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
        label.text = @"e-Application";
        [self.view addSubview:label];
        
        CGRect frame2 = CGRectMake(0, 30, 220, 30);
        UILabel *label2 = [[UILabel alloc] initWithFrame:frame2];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:14];
//        label2.textAlignment = UITextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
        label2.text = [self.requestSINo description];
        [self.view addSubview:label2];
        
        label = nil, label2 = nil;
    }
    CustomColor = nil;
    
	[self geteProposalStatus];
    
    if (![[self.EAPPorSI description] isEqualToString:@"eAPP"]){
        if ([eProposalStatus isEqualToString:@"Confirmed"] || [eProposalStatus isEqualToString:@"Submitted"] || [eProposalStatus isEqualToString:@"Received"] || [eProposalStatus isEqualToString:@"Failed"]  ) {
            NSString *msg = @"Amendment on SI is not allowed for eApp status = confirmed, submitted, Received/ Failed";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [alert show];
            alert = Nil;
            [self LoadViewController];
        }
        else if([eProposalStatus isEqualToString:@"Created"]) {
            
            if ([isPOSign isEqualToString:@"YES"]) {
                if (_LAController == nil) {
                    self.LAController = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
                    _LAController.delegate = self;
                }
                self.LAController.requestSINo = [self.requestSINo description];
                self.LAController.requesteProposalStatus = eProposalStatus;
                self.LAController.EAPPorSI = [self.EAPPorSI description];

                [self.RightView addSubview:self.LAController.view];
                
                NSString *msg = @"Please be informed that this SI is attached to a pending eApp case. System will auto delete the eApp case should you wish to amend the SI";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                alert.tag = 601;
                [alert show];
                
            }
            else{
                [self LoadViewController];
                [self SetInitialStatusToFalse];
            }
        }
        else{
            [self LoadViewController];
            [self SetInitialStatusToFalse];
        }

    }
    else{
        [self LoadViewController];
    }
}

-(void)LoadViewController
{
 
     if (_LAController == nil) {
     self.LAController = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
     _LAController.delegate = self;
     }
     self.LAController.requestSINo = [self.requestSINo description];
     self.LAController.requesteProposalStatus = eProposalStatus;
     self.LAController.EAPPorSI = [self.EAPPorSI description];
     [self addChildViewController:self.LAController];
     [self.RightView addSubview:self.LAController.view];
     blocked = NO;
     selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
     previousPath = [NSIndexPath indexPathForRow:0 inSection:0];
     
     if (getAge<= 16) {
     [self loadPayorPage];
     
     }
     else{
     [self loadSecondLAPage];
     }
     [self loadBasicPlanPage:YES];
     
     [self.RightView bringSubviewToFront:self.LAController.view];
     [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)checkNeedPromptMsg
{
	appDel.isNeedPromptSaveMsg = !isNewSI;
	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.view.autoresizesSubviews = NO;
	
    if ([[self.EAPPorSI description] isEqualToString:@"eAPP"]) {
        self.myTableView.frame = CGRectMake(0, 60, 220, 748);
    }
    else {
        self.myTableView.frame = CGRectMake(0, 0, 220, 748);
    }
    
    [self hideSeparatorLine];
    self.RightView.frame = CGRectMake(223, 0, 801, 748);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void)Reset
{
    if ([self.requestSINo isEqualToString:self.requestSINo2] || (self.requestSINo == NULL && self.requestSINo2 == NULL) ) {
        
        PlanEmpty = YES;
        added = NO;
		
		ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Life Assured", @"   2nd Life Assured", @"   Payor", @"Basic Plan", nil];
        
        [self RemovePDS];
        [self clearDataLA];
        [self clearDataPayor];
        [self clearData2ndLA];
        [self clearDataBasic];
        [self hideSeparatorLine];
        eProposalStatus = @"";
        [self.myTableView reloadData];
        
        
        _RiderController = nil;
        
        
        if (_LAController == nil) {
            self.LAController = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
            _LAController.delegate = self;
        }
		
        [self.RightView addSubview:self.LAController.view];
        blocked = NO;
        selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
        previousPath = selectedPath;
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
		
		
		appDel.MhiMessage = Nil;
    }
    else {
        requestSINo2 = self.requestSINo;
    }
}

-(void)toogleView
{
    if (PlanEmpty && added)
    {
        [ListOfSubMenu removeObject:@"Health Loading"];
        [ListOfSubMenu removeObject:@"Rider"];
        [ListOfSubMenu removeObject:@"Premium"];
        
    }
    else if (!PlanEmpty && !added) {
		
        [ListOfSubMenu addObject:@"Health Loading"];
        [ListOfSubMenu addObject:@"Rider"];
        [ListOfSubMenu addObject:@"Premium"];
        [self addRemainingSubmenu];
        
        added = YES;
        
    }
    
    [self CalculateRider];
    [self hideSeparatorLine];
    [self.myTableView reloadData];
}

- (void) addRemainingSubmenu
{
	if (![[self.EAPPorSI description] isEqualToString:@"eAPP"]) {
		[ListOfSubMenu addObject:@"Quotation"];
		//[ListOfSubMenu addObject:@"   Export Quotation"];
		//[ListOfSubMenu addObject:@"Product Disclosure Sheet"];
		//[ListOfSubMenu addObject:@"   Export PDS"];
        //[ListOfSubMenu addObject:@"Underwriting Sum Assured"];

		[ListOfSubMenu addObject:@"Save As New"];
	}
	
    
}

-(void)hideSeparatorLine
{
    CGRect frame = myTableView.frame;
    frame.size.height = MIN(44 * [ListOfSubMenu count], 748);
    myTableView.frame = frame;
}


#pragma mark - action


-(BOOL)select2ndLA
{
    if([EAPPorSI isEqualToString:@"eAPP"]){
        return YES;
    }
        
    NSLog(@"select 2ndLA:: age:%d, occp:%@, SI:%@",getAge,getOccpCode,getSINo);
    if (getAge >= 18 && getAge <=70 && ![getOccpCode isEqualToString:@"(null)"])
    {
        return YES;
    }
    else 
    if (getAge < 16 && getOccpCode.length != 0 && ![getOccpCode isEqualToString:@"(null)"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Life Assured is less than 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        blocked = YES;
        return NO;
    }
    else if ( (getOccpCode.length == 0 || [getOccpCode isEqualToString:@"(null)"]) 
             && ![LAotherIDType isEqualToString:@"EDD"] ) { // skip checking if equal to EDD
        NSLog(@"no where!");
        blocked = YES;
        return NO;
    }
    else {
        NSLog(@"age 16-17");
        if (getSINo.length != 0 && ![getSINo isEqualToString:@"(null)"]) {
            NSLog(@"with SI");
            
            [self checkingPayor];
            if (payorSINo.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Not allowed as Payor/ 2nd LA has been attached" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                blocked = YES;
                return NO;
            }
        }
        else {
            if (getPayorIndexNo != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Not allowed as Payor/ 2nd LA has been attached" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                blocked = YES;
                return NO;
                
            }
        }
        
    }
    return YES;
}

-(BOOL)selectPayor
{
    if([EAPPorSI isEqualToString:@"eAPP"]){
        return YES;
    }    
    NSLog(@"select payor:: age:%d, occp:%@, SI:%@",getAge,getOccpCode,getSINo);
    if (getAge >= 18 && ![getOccpCode isEqualToString:@"(null)"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Life Assured's age must not greater or equal to 18 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        blocked = YES;
        return NO;
    }
    else if (getAge < 18  && getOccpCode.length != 0) {
        
        if ([getSINo isEqualToString:@"(null)"] || getSINo.length == 0) {
            
            return YES;
        }
    }
    else if ( (getOccpCode.length == 0 || [getOccpCode isEqualToString:@"(null)"])
                && ![LAotherIDType isEqualToString:@"EDD"] ) {
        blocked = YES;
        return NO;
    }
    else {
        if (getSINo.length != 0 && ![getSINo isEqualToString:@"(null)"]) {            
            [self checking2ndLA];
            if (CustCode2.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Not allowed as Payor/ 2nd LA has been attached" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                blocked = YES;
                return NO;
            }
            
        }
        else {
            if (get2ndLAIndexNo != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Not allowed as Payor/ 2nd LA has been attached" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                blocked = YES;
                return NO;
            }
			
        }
		
    }
    return YES;
}

-(BOOL)selectBasicPlan
{
//    NSLog(@"select basic:: age:%d, occp:%@, SI:%@",getAge,getOccpCode,getSINo);
    if (getSINo.length != 0 && ![getSINo isEqualToString:@"(null)"]) {
        
        [self checkingPayor];
        if (getAge < 10 && payorSINo.length == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
            return NO;
        }
        else 
        if ( [getBasicPlan isEqualToString:@"HLACP"] && getAge > 63) {//changed to 63 ; by Edwin 8-10-2013
			
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
            return NO;
        }
        else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge>65 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
            return NO;
        }
        
    }
    
    else if (getOccpCode != 0 && getSINo.length == 0) {
        
        if (getAge < 10 && getPayDOB.length == 0) { //edited by heng to solve duplicate record in Trad_Payor
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
            return NO;
            
        }
		
    }
    
    return YES;
}

-(void)calculatedPrem
{
    if (getSINo.length != 0 && getAge <= 70) {
        
        [self checkingPayor];
        if (getAge < 10 && payorSINo.length == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            blocked = YES;
        }
        else {
            [self buildSpinner];
			[self RemovePDS];
            [ListOfSubMenu addObject:@"Health Loading"];
            [ListOfSubMenu addObject:@"Rider"];
            [ListOfSubMenu addObject:@"Premium"];
            [self addRemainingSubmenu];
            
            PremiumViewController *premView = [self.storyboard instantiateViewControllerWithIdentifier:@"premiumView"];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
			
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.executeMHI = @"YES";
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = FALSE;
			[self addChildViewController:premView];
            _delegate = premView;
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
				
				if ([RiderCount intValue ] > 10) {
					sleep(5);
				}
				else{
					sleep(1);
				}
								
				dispatch_async(dispatch_get_main_queue(), ^{
					
					[self.RightView addSubview:premView.view];
					previousPath = selectedPath;
					blocked = NO;
					[self hideSeparatorLine];
                    
                    appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                    if ([appDel.MhiMessage doubleValue] >0) {
                        _BasicController.yearlyIncomeField.text = appDel.MhiMessage;
                    }
                    
					[spinner_SI stopAnimating ];
					[self.view setUserInteractionEnabled:YES];
					[_FS Reset];
					UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
					[v removeFromSuperview];
					v = Nil;
					spinner_SI = nil;
				});
			});
        }
    }
    else if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"]) && getAge > 65) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        blocked = YES;
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        blocked = YES;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"No record selected!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        blocked = YES;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        saved = YES;
        _SecondLAController = nil;
        
//        [self RemovePDS];
        
        [self selectBasicPlan];
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else if (alertView.tag == 1001 && buttonIndex == 1)
    {
        saved = NO;
        blocked = YES;
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    else if (alertView.tag == 2001 && buttonIndex == 0)
    {
        payorSaved = YES;
        _PayorController = nil;
        
        [self RemovePDS];
        [self selectBasicPlan];
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else if (alertView.tag == 2001 && buttonIndex == 1)
    {
        payorSaved = NO;
        blocked = YES;
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    else if (alertView.tag == 1002 && buttonIndex == 0)
    {
        saved = YES;
        
        
        [self RemovePDS];
        
        self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
        _RiderController.delegate = self;
        self.RiderController.requestAge = getAge;
        self.RiderController.requestSex = getSex;
        self.RiderController.requestOccpCode = getOccpCode;
        self.RiderController.requestOccpClass = getOccpClass;
        
        self.RiderController.requestSINo = getSINo;
        self.RiderController.requestPlanCode = getPlanCode;
        self.RiderController.requestCoverTerm = getTerm;
        self.RiderController.requestBasicSA = getbasicSA;
        self.RiderController.requestBasicHL = getbasicHL;
        self.RiderController.requestBasicTempHL = getbasicTempHL;
        self.RiderController.requestMOP = getMOP;
        self.RiderController.requestAdvance = getAdvance;
		self.RiderController.EAPPorSI = [self.EAPPorSI description];
		
        [self addChildViewController:self.RiderController];
        [self.RightView addSubview:self.RiderController.view];
        
        previousPath = selectedPath;
        blocked = NO;
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else if (alertView.tag == 1002 && buttonIndex == 1)
    {
        saved = NO;
        blocked = YES;
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    else if (alertView.tag == 2002 && buttonIndex == 0)
    {
        payorSaved = YES;
        
        
        [self RemovePDS];
        
        self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
        _RiderController.delegate = self;
        self.RiderController.requestAge = getAge;
        self.RiderController.requestSex = getSex;
        self.RiderController.requestOccpCode = getOccpCode;
        self.RiderController.requestOccpClass = getOccpClass;
        
        self.RiderController.requestSINo = getSINo;
        self.RiderController.requestPlanCode = getPlanCode;
        self.RiderController.requestCoverTerm = getTerm;
        self.RiderController.requestBasicSA = getbasicSA;
        self.RiderController.requestBasicHL = getbasicHL;
        self.RiderController.requestBasicTempHL = getbasicTempHL;
        self.RiderController.requestMOP = getMOP;
        self.RiderController.requestAdvance = getAdvance;
		self.RiderController.EAPPorSI = [self.EAPPorSI description];
		
        [self addChildViewController:self.RiderController];
        [self.RightView addSubview:self.RiderController.view];
        
        previousPath = selectedPath;
        blocked = NO;
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else if (alertView.tag == 2002 && buttonIndex == 1)
    {
        payorSaved = NO;
        blocked = YES;
        [myTableView reloadData];
        
        if (blocked) {
            [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else {
            [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    else if (alertView.tag == 3001 && buttonIndex == 0)
    {
//        NSLog(@"save all");
        
        if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
            
            CurrentPath = 0;
            alert.tag = 7001;
            [alert show];
        }
        else{
            if (!PlanEmpty) {
                [self CheckPremAndMHI];
            }
            if([self validateSaveAll])
            {
                if ([eProposalStatus isEqualToString:@"confirmed"] || [eProposalStatus isEqualToString:@"Confirmed"] || [isPOSign isEqualToString:@"Yes"]) {
                    eAppCheckList *PdfDelete =[[eAppCheckList alloc]init];
                    [PdfDelete deleteEAppCase:getSINo];
                }
                appDel.isNeedPromptSaveMsg = NO;
            }
        }
    }
    else if (alertView.tag == 2000001 && buttonIndex == 0)
    {
        
        NSString  *msg = [self SaveAsTemp]?@"New SI No Successful Created":@"SI Save As Fail";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (alertView.tag == 7001)
    {
        if(buttonIndex == 1){
            [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SIMENU_BASIC_PLAN inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            
            self.BasicController.requestAge = getAge;
			self.BasicController.EAPPorSI = [self.EAPPorSI description];
            self.BasicController.requestOccpCode = getOccpCode;
            self.BasicController.requestOccpClass = getOccpClass;
            self.BasicController.requestIDPay = getIdPay;
            self.BasicController.requestIDProf = getIdProf;
            
            self.BasicController.requestIndexPay = getPayorIndexNo;
            self.BasicController.requestSmokerPay = getPaySmoker;
            self.BasicController.requestSexPay = getPaySex;
            self.BasicController.requestDOBPay = getPayDOB;
            self.BasicController.requestAgePay = getPayAge;
            self.BasicController.requestOccpPay = getPayOccp;
            
            self.BasicController.requestIndex2ndLA = get2ndLAIndexNo;
            self.BasicController.requestSmoker2ndLA = get2ndLASmoker;
            self.BasicController.requestSex2ndLA = get2ndLASex;
            self.BasicController.requestDOB2ndLA = get2ndLADOB;
            self.BasicController.requestAge2ndLA = get2ndLAAge;
            self.BasicController.requestOccp2ndLA = get2ndLAOccp;
            
            self.BasicController.requestSINo = getSINo;
			self.BasicController.requesteProposalStatus = eProposalStatus;
            self.BasicController.getPolicyTerm = getTerm;
            
            self.BasicController.MOP = getMOP;
            self.BasicController.requestEDD = getEDD;
            
            [self.BasicController loadData];
            
            [self.RightView bringSubviewToFront:self.BasicController.view];
        }
        else //proceed
        {
            if (CurrentPath == SIMENU_QUOTATION) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    [self showQuotation];
                }
            }
            /*
            else if (CurrentPath == SIMENU_EXP_QUOTATION) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    [self exportQuotation];
                }
            }
            else if (CurrentPath == SIMENU_PRODUCT_DISCLOSURE_SHEET) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    [self showPDS];
                }
            }
            else if (CurrentPath == SIMENU_EXP_PDS) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    [self exportPDS];
                }
            }
            else if (CurrentPath == SIMENU_UNDERWRITING) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    [self showUnderwriting];
                }
            }
             */
            else if (CurrentPath == SIMENU_PDS_SAVE_AS) {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    appDel.isNeedPromptSaveMsg = NO;
                    
                    NSString* msg = [NSString stringWithFormat:@"Create a new SI from %@ (%@)?", getSINo, NameLA];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    alert.tag = 2000001;
                    [alert show];
                }
            }
            else if (CurrentPath == 0){ //from done button
                if([self validateSaveAll])
                {
                    appDel.isNeedPromptSaveMsg = NO;
                }
                else
                {
                    [self CheckPremAndMHI];
                }
            }
            
        }
    }
    else if (alertView.tag == 601){ // this one is for created status with PO signed
        if (buttonIndex == 0) { //means delete the eAPP record
            eAppCheckList*deleteOldPDF=[[eAppCheckList alloc] init];
            [deleteOldPDF deleteEAppCase:self.requestSINo];
            deleteOldPDF = Nil;
            
            MasterMenuEApp *rrr = [[MasterMenuEApp alloc] init];
            [rrr deleteEAppCase:self.requestSINo];
            rrr = Nil;
            
            eProposalStatus = @"Created_Edit";
            [self SetInitialStatusToFalse];
            

        }
        else
        {
            eProposalStatus = @"Created_View";
        }

        //remove the initial VC


        [self.LAController.view removeFromSuperview];
        _LAController = nil;
        
        [self LoadViewController];

    }
    else if (alertView.tag == 8001){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record Saved." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
    }
    
}

-(BOOL)validateSaveAllWithoutPrompt
{
    if (![self savePage:selectedPath.row]) { //to do section save for the current tab user visited
		[self UpdateSIToInvalid];
        return NO;
    }
	
    if(![self.LAController validateSave] && self.LAController)
    {
		[self UpdateSIToInvalid];
        return NO;
    }
	
    if(isSecondLaNeeded && self.SecondLAController)
    {
        
        if (![self.SecondLAController validateSave]) //here
        {
			[self UpdateSIToInvalid];
            return NO;
			
        }
    }
    if(getAge < 10 && payorSINo.length == 0)
    {
        //		[self loadPayorPage];
        if([self.PayorController isPayorSelected])
        {
            if(![self.PayorController validateSave])
            {
				[self UpdateSIToInvalid];
                return NO;
            }
        }else{
			[self UpdateSIToInvalid];
			
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            
            [alert show];
            
            return NO;
        }
    }
    
    if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
		
		[self UpdateSIToInvalid];
        return NO;
    }else
        if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
            
            [self UpdateSIToInvalid];
            return NO;
        }
    
    
	
    [self loadBasicPlanPage:NO];
    [self.BasicController loadData];
    NSString *secondSex = [self.BasicController requestSex2ndLA];
    NSString *firstSex = getSex;
    if([firstSex isEqualToString:@"MALE"])
    {
        firstSex = @"M";
    }else
        if([firstSex isEqualToString:@"FEMALE"])
        {
            firstSex = @"F";
        }
    if( [getBasicPlan isEqualToString:@"L100"] && [secondSex isEqualToString:firstSex] )
    {
        
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Both First Life Assured and 2nd Life Assured cannot have the same sex." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
         
         [alert show];
        [self UpdateSIToInvalid];
         return NO;
    }
    
    if ([self.BasicController validateSave] != 0 && self.BasicController)
    {
        NSLog(@"BasicController  NO PROM");
		[self UpdateSIToInvalid];
        return NO;
		
    }
    if(![self.HLController validateSave] &&self.HLController)
    {
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && [self ValidateRiderL100] == FALSE) {
        [self UpdateSIToInvalid];
        return NO;
    }
    
    if (![self.LAController updateData:getSINo] && self.LAController) {
        NSLog(@"UPDATE LA FAIL");
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    if (isSecondLaNeeded) {
		
        if (![self.SecondLAController performUpdateData] && self.SecondLAController) {
            NSLog(@"UPDATE 2NDLA FAIL");
			[self UpdateSIToInvalid];
            return NO;
            
        }
		
    }
    	
    [self.BasicController checkingExisting]; //added by Edwin 4-10-2013, to get the useExist boolean, else the it will choose to save again instead of update.
    if (![self.BasicController checkingSave:getSex] && self.BasicController) {
        NSLog(@"UPDATE BASIC PLAN FAIL");
		[self UpdateSIToInvalid];
        return NO;
    }else
    {
        [self storeLAValues]; //added by Edwin 8-10-2013; to store the LA data after save for revert
    }
    
    if (![self.HLController updateHL] && self.HLController) {
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
    _RiderController.delegate = self;
    self.RiderController.requestAge = getAge;
    self.RiderController.requestSex = getSex;
    self.RiderController.requestOccpCode = getOccpCode;
    self.RiderController.requestOccpClass = getOccpClass;
    
    self.RiderController.requestSINo = getSINo;
    self.RiderController.requestPlanCode = getPlanCode;
    self.RiderController.requestPlanChoose = getBasicPlan;
    self.RiderController.requestCoverTerm = getTerm;
    self.RiderController.requestBasicSA = getbasicSA;
    self.RiderController.requestBasicHL = getbasicHL;
    self.RiderController.requestBasicTempHL = getbasicTempHL;
    self.RiderController.requestMOP = getMOP;
    self.RiderController.requestAdvance = getAdvance;
    self.RiderController.requesteEDD = getEDD;
    
    self.RiderController.EAPPorSI = [self.EAPPorSI description];
    
    [self addChildViewController:self.RiderController];
    [self.RightView insertSubview:self.RiderController.view belowSubview:self.LAController.view];
//    [self.RightView addSubview:self.RiderController.view];
//    [self.RightView bringSubviewToFront:self.LAController.view];
    
    if(![self.RiderController RoomBoard])
    {
        [self UpdateSIToInvalid];
        return NO;
    }

    PremiumViewController *premView = [[PremiumViewController alloc] init ];
    premView.requestAge = getAge;
    premView.requestOccpClass = getOccpClass;
    premView.requestOccpCode = getOccpCode;
    premView.requestSINo = getSINo;
    premView.requestMOP = getMOP;
    premView.requestTerm = getTerm;
    premView.requestBasicSA = getbasicSA;
    premView.requestBasicHL = getbasicHL;
    premView.requestBasicTempHL = getbasicTempHL;
    premView.requestPlanCode = getPlanCode;
    premView.requestBasicPlan = getBasicPlan;
    premView.sex = getSex;
    premView.EAPPorSI = [self.EAPPorSI description];
    premView.executeMHI = @"YES";
    premView.fromReport = TRUE; // TRUE because to avoid showing "min modal ..." temporarily for now, cant solve the problem
    [self presentViewController:premView animated:NO completion:Nil];
    [premView dismissViewControllerAnimated:NO completion:Nil];
    _delegate = premView;
    premView = Nil;
 
    
    if ([appDel.MhiMessage doubleValue] >0) {
        
        _BasicController.yearlyIncomeField.text = appDel.MhiMessage;
        
        UIAlertView *alert;
        
        if ([getBasicPlan isEqualToString:@"HLAWP"]) {
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Basic Desired Annual Premium will be increased to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.", appDel.MhiMessage] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        else{
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Basic Sum Assured will be increased to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.", appDel.MhiMessage] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        
        [alert show];
        
        getbasicSA = appDel.MhiMessage;
        appDel.MhiMessage = Nil;
        return NO;
    }
    if ([getBasicPlan isEqualToString:@"HLAWP"]) {
		
        if ([self CalcTPDbenefit] > 3500000) {
            [self UpdateSIToInvalid];
            
            return NO;
        }
        
    }
    
    if ([getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) {
		
        if ([self calculateCIBenefit] > 4000000) {
            [self UpdateSIToInvalid];
            
            return NO;
        }
		
    }
    
    
    if ([getBasicPlan isEqualToString:@"HLAWP"] && getEDD == TRUE ) {
		
        double totalPrem = [self returnTotalHLAWPPrem];
        
        if (totalPrem > 15000) {
            [self UpdateSIToInvalid];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"The Maximum allowable total annual premium (inclusive of Wealth Booster, Wealth Booster-i6, Wealth Booster-d10 and EduWealth Riders) for an unborn Child allowable is RM15,000."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
     	
    }
    
    [self UpdateSIToValid];

    return YES;
}

-(BOOL)validateSaveAll
{
    if (![self savePage:selectedPath.row]) { //to do section save for the current tab user visited
		[self UpdateSIToInvalid];
        return NO;
    }
	
    if(![self.LAController validateSave] && self.LAController)
    {
		[self UpdateSIToInvalid];
        return NO;
    }
	
    if(isSecondLaNeeded && self.SecondLAController)
    {        
        if (![self.SecondLAController validateSave]) //here
        {
			[self UpdateSIToInvalid];
            return NO;
			
        }
    }
    if(getAge < 10 && payorSINo.length == 0)
    {
        if([self.PayorController isPayorSelected])
        {
            if(![self.PayorController validateSave])
            {
				[self UpdateSIToInvalid];
                return NO;
            }
        }else{
			[self UpdateSIToInvalid];
			
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            
            [alert show];
            
            return NO;
        }
    }
    
    if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
		
		[self UpdateSIToInvalid];
        return NO;
    }else if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"]||[getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
		
		[self UpdateSIToInvalid];
        return NO;
    }
	
    [self loadBasicPlanPage:NO];
    [self.BasicController loadData];
    NSString *secondSex = [self.BasicController requestSex2ndLA];
    NSString *firstSex = getSex;
    if([firstSex isEqualToString:@"MALE"])
    {
        firstSex = @"M";
    }else
    if([firstSex isEqualToString:@"FEMALE"])
    {
        firstSex = @"F";
    }   
    if(([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && [secondSex isEqualToString:firstSex] )
    {        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Both First Life Assured and 2nd Life Assured cannot have the same sex." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        
        [alert show];
        [self UpdateSIToInvalid];
        return NO;
    }
    
    if ([self.BasicController validateSave] && self.BasicController)
    {
        [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SIMENU_BASIC_PLAN inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if (!_BasicController) {
            [self addChildViewController:self.BasicController];
            [self.RightView addSubview:self.BasicController.view];
        }
        else{
            [self.RightView addSubview:self.BasicController.view];
        }
        
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    [self.HLController loadHL];
    if(![self.HLController validateSave] &&self.HLController)
    {
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    if (![self.LAController updateData:getSINo] && self.LAController) {
		[self UpdateSIToInvalid];
        return NO;
		
    }
    
    if (isSecondLaNeeded) {
        if (self.SecondLAController && ![self.SecondLAController performUpdateData]) {
			[self UpdateSIToInvalid];
            return NO;
        }
    }   
	
    [self.BasicController checkingExisting]; //added by Edwin 4-10-2013, to get the useExist boolean, else the it will choose to save again instead of update.
    if (![self.BasicController checkingSave:getSex] && self.BasicController) {
		[self UpdateSIToInvalid];
        return NO;
    }else
    {
        [self storeLAValues]; //added by Edwin 8-10-2013; to store the LA data after save for revert
    }
    
    if (![self.HLController updateHL] && self.HLController) {
		[self UpdateSIToInvalid];
        return NO;
		
    }
    self.RiderController = nil;
    self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
    _RiderController.delegate = self;
    self.RiderController.requestAge = getAge;
    self.RiderController.requestSex = getSex;
    self.RiderController.requestOccpCode = getOccpCode;
    self.RiderController.requestOccpClass = getOccpClass;
    
    self.RiderController.requestSINo = getSINo;
    self.RiderController.requestPlanCode = getPlanCode;
    self.RiderController.requestPlanChoose = getBasicPlan;
    self.RiderController.requestCoverTerm = getTerm;
    self.RiderController.requestBasicSA = getbasicSA;
    self.RiderController.requestBasicHL = getbasicHL;
    self.RiderController.requestBasicTempHL = getbasicTempHL;
    self.RiderController.requestMOP = getMOP;
    self.RiderController.requestAdvance = getAdvance;
    self.RiderController.requesteEDD = getEDD;
    
    self.RiderController.EAPPorSI = [self.EAPPorSI description];
    
    [self addChildViewController:self.RiderController];
    [self.RightView insertSubview:self.RiderController.view belowSubview:self.LAController.view];
//    [self.RightView addSubview:self.RiderController.view];
    
//    [self.RightView bringSubviewToFront:self.LAController.view];
        
    if(![self.RiderController RoomBoard])
    {
        [self UpdateSIToInvalid];
        return NO;
    }
    
    if (![self CheckPremAndMHI]) {
        [self UpdateSIToInvalid];
        return NO;
    }
    
    if ([getBasicPlan isEqualToString:@"HLAWP"]) {
        if ([self CalcTPDbenefit] > 3500000) {
            [self UpdateSIToInvalid];
            
            return NO;
        } else if (getEDD == TRUE ) {
            double totalPrem = [self returnTotalHLAWPPrem];
            
            if (totalPrem > 15000) {
                [self UpdateSIToInvalid];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"The Maximum allowable total annual premium (inclusive of Wealth Booster, Wealth Booster-i6, Wealth Booster-d10 and EduWealth Riders) for an unborn Child allowable is RM15,000."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return NO;
            }
        }
    } else if ([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"]) {
        if ([self ValidateRiderL100] == FALSE) {
            [self UpdateSIToInvalid];
            return NO;
        } else if ([self calculateCIBenefit] > 4000000) {
            [self UpdateSIToInvalid];
            return NO;
        }
    }

    if ([eProposalStatus isEqualToString:@"Created"] && ![isPOSign isEqualToString:@"YES"]) {
        eAppCheckList *PdfDelete =[[eAppCheckList alloc]init];
        [PdfDelete deleteEAppCase:getSINo];
        PdfDelete = Nil;
        
    }

    [self UpdateSIToValid];

    if([getBasicPlan isEqualToString:@"HLAWP"])
    {
        [self wpGYIRiderExist];
    }
    else if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record Saved." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
    }
    
    return YES;
}

-(BOOL)CheckPremAndMHI{
    PremiumViewController *premView = [[PremiumViewController alloc] init ];
    premView.requestAge = getAge;
    premView.requestOccpClass = getOccpClass;
    premView.requestOccpCode = getOccpCode;
    premView.requestSINo = getSINo;
    premView.requestMOP = getMOP;
    premView.requestTerm = getTerm;
    premView.requestBasicSA = getbasicSA;
    premView.requestBasicHL = getbasicHL;
    premView.requestBasicTempHL = getbasicTempHL;
    premView.requestPlanCode = getPlanCode; // this one is not working
    premView.requestBasicPlan = getBasicPlan; //pass in plancode
    premView.sex = getSex;
    premView.EAPPorSI = [self.EAPPorSI description];
    premView.fromReport = TRUE; // TRUE because to avoid showing "min modal ..." temporarily for now, cant solve the problem
    premView.executeMHI = @"YES";
    [self presentViewController:premView animated:NO completion:Nil];
    [premView dismissViewControllerAnimated:NO completion:Nil];
    _delegate = premView;
//    PremiumViewController *premView = [self buildPremiumViewController:YES];
    premView = Nil;
    
    if ([appDel.MhiMessage doubleValue] >0) {
        
        _BasicController.yearlyIncomeField.text = appDel.MhiMessage;
        
        UIAlertView *alert;
        
        if ([getBasicPlan isEqualToString:@"HLAWP"]) {
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Basic Desired Annual Premium will be increased to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.", appDel.MhiMessage] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        else{
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Basic Sum Assured will be increased to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.", appDel.MhiMessage] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        [alert show];
        
        getbasicSA = appDel.MhiMessage;
        [_RiderController loadRiderData];
        appDel.MhiMessage = Nil;
        
        return NO;
    }
    else{
        return YES;
    }
}

-(BOOL)returnTotalPremVSBenefit{ //for HLAWP only
    sqlite3_stmt *statement;
    double tempBasicPrem = 0.00;
    double tempBasicBenefit = 0.00;
    double tempTotalRiderPrem = 0.00;
    double tempTotalRiderBenefit = 0.00;
//    /double TotalPrem
    BOOL temp = FALSE;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *SelectSQL = [NSString stringWithFormat:@"select basicSA, PremiumPaymentTerm,  policyTerm from trad_details where sino = '%@' ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempBasicBenefit = sqlite3_column_double(statement, 0) * sqlite3_column_double(statement, 1 ) * (sqlite3_column_double(statement, 2) == 30 ? 1.5 : 2.5);
            }

            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:
                                @"select replace(Annually, ',', '') from si_store_premium where sino = '%@' AND Type in ('B') ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempBasicPrem = sqlite3_column_double(statement, 0);
            }
            
            sqlite3_finalize(statement);
        }

        SelectSQL = [NSString stringWithFormat:@"select sumAssured, ridercode from trad_Rider_details where sino = '%@' ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempTotalRiderBenefit = tempTotalRiderBenefit + sqlite3_column_double(statement, 0) * [self RiderBenefitFactor:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
            }

            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:@"select sum(replace(Annually, ',', '')) from si_store_premium where sino = '%@' AND Type in ('EDUWR','WB30R','WB50R','WBI6R30','WBD10R30') ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempTotalRiderPrem = tempTotalRiderPrem + sqlite3_column_double(statement, 0);
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
    if (tempBasicPrem + tempTotalRiderPrem > tempBasicBenefit + tempTotalRiderBenefit) {
        temp = FALSE;
    }
    else{
        temp = TRUE;
    }
    
    return  temp;
}

-(double)RiderBenefitFactor : (NSString *)aaRidercode{
    
    if ([aaRidercode isEqualToString:@"WBI6R30"]) {
        return 165;
    }
    else if ([aaRidercode isEqualToString:@"WB30R"]) {
        return 30;
    }
    else if ([aaRidercode isEqualToString:@"WB50R"]) {
        return 50;
    }
    else if ([aaRidercode isEqualToString:@"WBD10R30"]) {
        return 20;
    }
    else{
        return 0.00;
    }
}


-(double)returnTotalHLAWPPrem{ // to check for EDD case for HLAWP only
    sqlite3_stmt *statement;
    double temp = 0.00;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *SelectSQL = [NSString stringWithFormat:
                               @"select basicSA from trad_details where sino = '%@' ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                temp = sqlite3_column_double(statement, 0);
            }
            else {
            }
            sqlite3_finalize(statement);
        }
        
        NSString *SelectSQL2 = [NSString stringWithFormat:
                                @"select sum(replace(Annually, ',', '')) from si_store_premium where sino = '%@' AND Type in ('EDUWR','WB30R','WB50R','WBI6R30','WBD10R30') ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                temp = temp + sqlite3_column_double(statement, 0);
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
    return  temp;
}

-(BOOL)ValidateRiderL100
{
    BOOL allowedToAdd = TRUE;
    double riderSumAssured = 0;
    int noDeleted = 0;
    int noOfRiders = 0;
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT sumAssured from trad_rider_details where SINO=\"%@\" and RiderCode=\"ACIR_MPP\"",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderSumAssured =  sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        
        querySQL = [NSString stringWithFormat:@"SELECT count(*) from trad_rider_details where SINO=\"%@\" ",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                noOfRiders =  sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        
        if ([getbasicSA doubleValue] == riderSumAssured && noOfRiders > 1) {
            
            querySQL = [NSString stringWithFormat:@"Delete from trad_rider_details where SINO=\"%@\" and RiderCode not in ('ACIR_MPP', 'CIR', 'LCPR', 'ICR', 'SP_PRE', 'SP_STD') AND PTypeCode = 'LA' "
                        "AND seq = 1",getSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    noDeleted = sqlite3_changes(contactDB);
                }
                sqlite3_finalize(statement);
            }
        }
        
        sqlite3_close(contactDB);
    }
    
    if(noDeleted > 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        allowedToAdd = FALSE;
        [self RiderAdded];
    }
    else{
        allowedToAdd = TRUE;
    }
    return allowedToAdd;
}


-(double)calculateCIBenefit{
    
    sqlite3_stmt *statement;
    double CI = 0.00;
    NSMutableArray *ArrayCIRider = [[NSMutableArray alloc] init ];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    NSString *strRiders = @"";
    int count = 0;
    NSString *tempCode;
    
    int tempRiderTerm;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *SelectSQL = [NSString stringWithFormat:
                               @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                               "('ACIR_MPP', 'CIR', 'ICR', 'LCPR','CIWP') and sino = \"%@\" ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
                if([tempCode isEqualToString:@"ACIR_MPP"] || [tempCode isEqualToString:@"CIR"] || [tempCode isEqualToString:@"LCPR"] || [tempCode isEqualToString:@"PLCP"]){
                    CI = CI + sqlite3_column_double(statement, 1);
                    count++;
                }
                else if([tempCode isEqualToString:@"ICR"]){
                    CI = CI +  sqlite3_column_double(statement, 1) * 10;
                    count++;
                }
                else if([tempCode isEqualToString:@"CIWP"] ){
                    [temp setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]
                             forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                    count++;
                }
                
                strRiders = [strRiders stringByAppendingString:[NSString stringWithFormat:@"%d. %@\n", count, tempCode   ]];
                
            }
            
            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:
                     @"select type, WaiverSAAnnual from SI_Store_Premium where Type in "
                     "('CIWP') and sino = \"%@\" ", getSINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"SP_PRE"]){
                    tempRiderTerm = [[temp objectForKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]] intValue];
                    
                    
                    if (tempRiderTerm <= 10) {
                        CI = CI +  sqlite3_column_double(statement, 1) * 4;

                    }
                    else{
                        CI = CI +  sqlite3_column_double(statement, 1) * 8;

                    }                    
                }                
            }
            
            sqlite3_finalize(statement);
        }
        
        if (CI > 4000000 && count > 0) {
        }
        else{
            if (payorSINo.length > 0) {
                temp = [[NSMutableDictionary alloc] init];
                count = 0;
                CI = 0.00;
                ArrayCIRider = [[NSMutableArray alloc] init ];
                strRiders = @"";
                
                SelectSQL = [NSString stringWithFormat:
                             @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                             "('LCWP') and sino = \"%@\" ", getSINo];
                
                if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        
                        if([tempCode isEqualToString:@"LCWP"] ){
                            [temp setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]
                                     forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                            count++;
                        }
                        
                        strRiders = [strRiders stringByAppendingString:[NSString stringWithFormat:@"%d. %@\n", count, tempCode   ]];
                        
                    }
                    
                    sqlite3_finalize(statement);
                }
                
                SelectSQL = [NSString stringWithFormat:
                             @"select type, WaiverSAAnnual from SI_Store_Premium where Type in "
                             "('LCWP') and sino = \"%@\" ", getSINo];
                
                if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"] ||
                           [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"] ||
                           [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"SP_PRE"]){
                            tempRiderTerm = [[temp objectForKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]] intValue];
                            
                            
                            if (tempRiderTerm <= 10) {
                                CI = CI +  sqlite3_column_double(statement, 1) * 4;
                                
                            }
                            else{
                                CI = CI +  sqlite3_column_double(statement, 1) * 8;
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    sqlite3_finalize(statement);
                }
                
            }
            
            if (clientID2 > 0) {
                temp = [[NSMutableDictionary alloc] init];
                count = 0;
                CI = 0.00;
                ArrayCIRider = [[NSMutableArray alloc] init ];
                strRiders = @"";
                
                SelectSQL = [NSString stringWithFormat:
                             @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                             "('SP_PRE') and sino = \"%@\" ", getSINo];
                
                if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                        
                        if([tempCode isEqualToString:@"SP_PRE"]){
                            [temp setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]
                                     forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                            count++;
                        }
                        
                        strRiders = [strRiders stringByAppendingString:[NSString stringWithFormat:@"%d. %@\n", count, tempCode   ]];
                        
                    }
                    
                    sqlite3_finalize(statement);
                }
                
                SelectSQL = [NSString stringWithFormat:
                             @"select type, WaiverSAAnnual from SI_Store_Premium where Type in "
                             "('SP_PRE') and sino = \"%@\" ", getSINo];
                
                if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"] ||
                           [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"] ||
                           [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"SP_PRE"]){
                            tempRiderTerm = [[temp objectForKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]] intValue];                            
                            
                            if (tempRiderTerm <= 10) {
                                CI = CI +  sqlite3_column_double(statement, 1) * 4;
                                
                            }
                            else{
                                CI = CI +  sqlite3_column_double(statement, 1) * 8;
                                
                            }                            
                        }                        
                    }
                    
                    sqlite3_finalize(statement);
                }
            }
        }

        
        sqlite3_close(contactDB);
    }
    
    temp = Nil;
    ArrayCIRider = Nil;
    return CI;
}


-(double)CalcTPDbenefit{
    sqlite3_stmt *statement;
    double tempValue = 0.00;
    int tempPrem = 0;
    double tempPremWithoutLoading = 0;
    NSString *strRiders = @"";
    NSString *tempCode;
    NSMutableDictionary *tempArray = [[NSMutableDictionary alloc] init];
    int count = 1;
    BOOL attachTPDRiders = FALSE;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
        querySQL = [NSString stringWithFormat:@"SELECT Ridercode, sumAssured FROM TRAD_Rider_Details WHERE RiderCode in ('CCTR', 'LCPR', 'WPTPD30R', 'WPTPD50R' ) "
                    "AND SINO = '%@' ", getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {                
                [tempArray setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]
                              forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                
            }
            
            sqlite3_finalize(statement);
        }
        
        
        querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', ''),replace(PremiumWithoutHLoading, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'CCTR', 'EDUWR', 'LCPR', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30', 'WPTPD30R', 'WPTPD50R' ) AND SINO = '%@' ", getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempPrem = sqlite3_column_double(statement, 1);
                tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                tempPremWithoutLoading = sqlite3_column_double(statement, 2);
                
                if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {

                    if (![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD30R"] &&
                        ![[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD50R"]) {
                        strRiders = [strRiders stringByAppendingString:[NSString stringWithFormat:@"%d. %@\n", count, tempCode   ]];
                    }
                    
                    count++;
                }
                
                if (getTerm == 30) {
                    if (getMOP == 6) {
                        
                        if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 9; //9 times basic premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CCTR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"CCTR"] doubleValue]; // 1 time rider sum assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"EDUWR"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total rider premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"LCPR"] doubleValue];
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB30R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB50R"]) {
                            
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBD10R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBI6R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD30R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD30R"] doubleValue];
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD50R"]) {
                            
                        }
                        
                    }
                    else{
                        if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 15; //9 times basic premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CCTR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"CCTR"] doubleValue]; // 1 time rider sum assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"EDUWR"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total rider premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"LCPR"] doubleValue];
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB30R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB50R"]) {
                            
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBD10R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBI6R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD30R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD30R"] doubleValue]; //50% of the Rider Sum Assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD50R"]) {
                            
                        }
                    }
                }
                else{
                    if (getMOP == 6) {
                        if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 15; //15 times basic premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CCTR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"CCTR"] doubleValue]; // 1 time rider sum assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"EDUWR"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total rider premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"LCPR"] doubleValue];
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB30R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB50R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBD10R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBI6R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 6; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD30R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD30R"] doubleValue]; //50% of the Rider Sum Assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD50R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD50R"] doubleValue]; //50% of the Rider Sum Assured
                        }
                    }
                    else{
                        if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 25; //15 times basic premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CCTR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"CCTR"] doubleValue]; // 1 time rider sum assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"EDUWR"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total rider premium payable calculated based on annual mode of payment
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"LCPR"] doubleValue];
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB30R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB50R"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBD10R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBI6R30"]) {
                            tempValue = tempValue + tempPremWithoutLoading * 10; //6 times of total premium payable calculated based on an annual basis
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD30R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD30R"] doubleValue]; //50% of the Rider Sum Assured
                        }
                        else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WPTPD50R"]) {
                            tempValue = tempValue + 1 * [[tempArray valueForKey:@"WPTPD50R"] doubleValue]; //50% of the Rider Sum Assured
                        }
                    }
                }
                
            
            }
        
            sqlite3_finalize(statement);
        }
        
        
        sqlite3_close(contactDB);
    }
    
    
    
    if (tempValue > 3500000 && count > 1 && attachTPDRiders == TRUE ) {
        NSString *msg = [NSString stringWithFormat:@"TPD Benefit Limit per Life for 1st Life Assured has exceeded RM3.5mil. "
                         "Please revise the RSA of Wealth TPD Protector or revise the RSA of the TPD related rider(s) below:\n %@", strRiders];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
        [alert show ];
    }
    else{
        tempValue = 0;
    }
    
    
    
    return tempValue;
}

-(BOOL)DisplayMsgGIRR{
    sqlite3_stmt *statement;
    double tempValue = 0.00;
    double tempValueBenefit = 0.00;
    int tempPrem = 0;
    double tempSA = 0;
    NSString *tempCode;
    BOOL bProceed = FALSE;
 
    if (getAge < 35) {
        return FALSE;
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
        querySQL = [NSString stringWithFormat:@"SELECT Ridercode, sumAssured FROM TRAD_Rider_Details WHERE RiderCode in ('WB30R','WB50R','WBI6R30','WBD10R30') AND SINO = '%@' ", getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempSA = sqlite3_column_double(statement, 1);
                tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
                if (getTerm == 30) {
                    if (getMOP == 6) {
                        
                        if ([tempCode isEqualToString:@"B"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 9;
                        }
                        else if ([tempCode isEqualToString:@"WB30R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 30;
                        }
                        else if ([tempCode isEqualToString:@"WB50R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 50;
                        }
                        else if ([tempCode isEqualToString:@"WBD10R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 20;
                        }
                        else if ([tempCode isEqualToString:@"WBI6R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 165;
                        }
                        
                    }
                    else{
                        if ([tempCode isEqualToString:@"B"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 15;
                        }
                        else if ([tempCode isEqualToString:@"WB30R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 30;
                        }
                        else if ([tempCode isEqualToString:@"WB50R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 50;
                        }
                        else if ([tempCode isEqualToString:@"WBD10R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 20;
                        }
                        else if ([tempCode isEqualToString:@"WBI6R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 165;
                        }
                    }
                }
                else{
                    if (getMOP == 6) {
                        if ([tempCode isEqualToString:@"B"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 15;
                        }
                        else if ([tempCode isEqualToString:@"WB30R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 30;
                        }
                        else if ([tempCode isEqualToString:@"WB50R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 50;
                        }
                        else if ([tempCode isEqualToString:@"WBD10R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 20;
                        }
                        else if ([tempCode isEqualToString:@"WBI6R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 165;
                        }
                    }
                    else{
                        if ([tempCode isEqualToString:@"B"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 25;
                        }
                        else if ([tempCode isEqualToString:@"WB30R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 30;
                        }
                        else if ([tempCode isEqualToString:@"WB50R"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 50;
                        }
                        else if ([tempCode isEqualToString:@"WBD10R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 20;
                        }
                        else if ([tempCode isEqualToString:@"WBI6R30"]) {
                            tempValueBenefit = tempValueBenefit + tempSA * 165;
                        }
                    }
                }

                
            }
            
            sqlite3_finalize(statement);
        }
        
        if (tempValueBenefit == 0) {
            bProceed = FALSE;
        }
        else{
            bProceed = TRUE;
            if (getTerm == 30) {
                if (getMOP == 6) {
                    tempValueBenefit = tempValueBenefit + [getbasicSA doubleValue] * 9;
                }
                else{
                    tempValueBenefit = tempValueBenefit + [getbasicSA doubleValue] * 15;
                }
            }
            else{
                if (getMOP == 6) {
                    tempValueBenefit = tempValueBenefit + [getbasicSA doubleValue] * 15;
                }
                else{
                    tempValueBenefit = tempValueBenefit + [getbasicSA doubleValue] * 25;
                }
            }
            
            querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30') AND SINO = '%@' ", getSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    tempPrem = sqlite3_column_double(statement, 1);
                    tempCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    
                    if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"B"]) {
                        tempValue = tempValue + tempPrem * getMOP * 1.05;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB30R"]) {
                        tempValue = tempValue + tempPrem * getMOP * 1.05;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WB50R"]) {
                        tempValue = tempValue + tempPrem * getMOP * 1.05;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBD10R30"]) {
                        tempValue = tempValue + tempPrem * getMOP * 1.05;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"WBI6R30"]) {
                        tempValue = tempValue + tempPrem * getMOP * 1.05;
                    }
                }
                
                sqlite3_finalize(statement);
            }
        }
        
        sqlite3_close(contactDB);
    }
    
    if (bProceed == FALSE) {
        [self setGIRRFLAG:FALSE];
        return FALSE;
    }
    else{
        if (tempValue >= tempValueBenefit) {
        [self setGIRRFLAG:TRUE];
            return TRUE;
        }
        else{
            [self setGIRRFLAG:FALSE];
            return FALSE;
        }
    }
    
    
}

-(void)setGIRRFLAG :(BOOL)aaTrueOrFalse{
	NSString *querySQL;
	sqlite3_stmt *statement;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"Update Trad_Details SET GIRR = '%d' where sino = '%@' ", aaTrueOrFalse , getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
			{
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
	
}


-(void)UpdateSIToValid{
	NSString *querySQL;
	sqlite3_stmt *statement;
	NSString *AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"Update Trad_Details SET SIStatus = 'VALID', SIVersion = '%@' where sino = '%@' ", AppsVersion, getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
			{
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
    
    SIStatus = @"VALID";
	
}

-(void)UpdateSIToInvalid{
	NSString *querySQL;
	sqlite3_stmt *statement;
	NSString *AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"Update Trad_Details SET SIStatus = 'INVALID', SIVersion = '%@' where sino = '%@' ", AppsVersion , getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
			{
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
    
    SIStatus = @"INVALID";
	
}

-(void)SetInitialStatusToFalse{
	NSString *querySQL;
	sqlite3_stmt *statement;
	NSString *AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"Update Trad_Details SET SIStatus = 'INVALID', SIVersion = '%@' where sino = '%@' ", AppsVersion , getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
			{
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
    
}


#pragma mark - db
-(void)geteProposalStatus
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SIStatus from Trad_Details where sino = '%@'", [self.requestSINo description]];
        
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                SIStatus = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            }
			
            sqlite3_finalize(statement);
        }
        
        querySQL = [NSString stringWithFormat:@"SELECT B.status FROM eProposal as A, eProposal_Status AS B, eAPP_Listing AS C "
							  "WHERE C.Status = B.StatusCode AND A.eProposalNo = C.ProposalNo AND A.SINo=\"%@\"", [self.requestSINo description]];
        		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				const char *temp = (const char *)sqlite3_column_text(statement, 0);
                eProposalStatus = temp == NULL ? @"NotFound" : [[NSString alloc] initWithUTF8String:temp];
				
            }
			else{
				eProposalStatus = @"NotFound";
			}
			
            sqlite3_finalize(statement);
        }
        
        querySQL = [NSString stringWithFormat:@"SELECT eProposalNo FROM eProposal WHERE SINo=\"%@\"", [self.requestSINo description]];
        NSString *eProposalNo;
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				const char *temp = (const char *)sqlite3_column_text(statement, 0);
                eProposalNo = temp == NULL ? @"" : [[NSString alloc] initWithUTF8String:temp];
            }
			
            sqlite3_finalize(statement);
        }
        
        querySQL = [NSString stringWithFormat:@"SELECT isPOSign FROM eProposal_Signature WHERE eproposalNo =\"%@\"", eProposalNo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				const char *temp = (const char *)sqlite3_column_text(statement, 0);
                isPOSign = temp == NULL ? @"No" : [[NSString alloc] initWithUTF8String:temp]; //return value 'YES' if got, empty or NULL if dont have any
            }
			
            sqlite3_finalize(statement);
        }
        
		querySQL = Nil;
		
        sqlite3_close(contactDB);
    }
	
	statement = Nil;
}


-(NSString *)getSINoAndCustCode
{
    NSString * toReturn = nil;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        /*CREATE TEMPORARY TABLE tmp AS SELECT * FROM src;
		 UPDATE tmp SET id = NULL;
		 INSERT INTO src SELECT * FROM tmp;
		 DROP TABLE tmp;
         */
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				
                saveAsSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                saveAsCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                toReturn = saveAsCustCode;
                
                NSLog(@"\n current SINo == %@ \n current cust Code  == %@\n",saveAsSINo,saveAsCustCode);
                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return toReturn;
}

-(NSString *)getSINoAndCustCode2nd
{
    NSString * toReturn = nil;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        /*CREATE TEMPORARY TABLE tmp AS SELECT * FROM src;
		 UPDATE tmp SET id = NULL;
		 INSERT INTO src SELECT * FROM tmp;
		 DROP TABLE tmp;
         */
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				
                saveAsSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                saveAsCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                toReturn = saveAsCustCode;
                
                NSLog(@"current SINo == %@ \n current cust Code  == %@\n",saveAsSINo,saveAsCustCode);
                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return toReturn;
}

-(NSString*)getSINoAndCustCodePY
{
    NSString * toReturn = nil;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        /*CREATE TEMPORARY TABLE tmp AS SELECT * FROM src;
		 UPDATE tmp SET id = NULL;
		 INSERT INTO src SELECT * FROM tmp;
		 DROP TABLE tmp;
         */
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode='PY'",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                saveAsSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                saveAsCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                
                toReturn = saveAsCustCode;
                NSLog(@"current SINo == %@ \n current cust Code  == %@\n",saveAsSINo,saveAsCustCode);
                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return toReturn;
}

-(void)checkingPayor
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id "
							  "FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" "
							  "AND a.PTypeCode=\"PY\" AND a.Sequence=1",getSINo];
        
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                payorSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                payorCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NamePayor = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.ExistPayor = YES;            }
            else {
//                NSLog(@"error access checkingPayor @ SIMenuViewController");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checking2ndLA
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustCode2 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                Name2ndLA = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                clientID2 = sqlite3_column_int(statement, 9);
				
//            } else {
//                NSLog(@"error access checking2ndLA");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//check if wealth plan's GYI rider exist
-(void)wpGYIRiderExist
{
    NSString * msg = @"Yearly Cash Coupons/Cash Payments accumulation and payout option is not applicable as no riders with GYCC or GCP have been selected.";

    sqlite3_stmt *statement;
    int count=-1;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"Select count(*) from trad_rider_details where sino = '%@' and riderCode in ('WB30R', 'WB50R', 'EDUWR', 'WBI6R30', 'WBD10R30')",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                count = sqlite3_column_int(statement, 0);
            } else {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }

    if(count>0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record Saved." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        alert.tag = 8001;
        [alert show];
        alert = Nil;
    }
}

-(void)CalculateRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select count(*) from trad_rider_details where sino = '%@' ", getSINo ];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RiderCount = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
                
            } else {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }    
}

-(void)getLAName
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName, OtherIDType FROM prospect_profile WHERE IndexNo= \"%d\"",getLAIndexNo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NameLA = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
				LAotherIDType = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
            } else {
                NSLog(@"error access getLAName");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)get2ndLAName
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName FROM prospect_profile WHERE IndexNo= \"%d\"",get2ndLAIndexNo];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                Name2ndLA = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSLog(@"name2ndLA:%@",Name2ndLA);
            } else {
                NSLog(@"error access get2ndLAName");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getPayorName
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName FROM prospect_profile WHERE IndexNo= \"%d\"",getPayorIndexNo];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NamePayor = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSLog(@"namePayor:%@",NamePayor);
            } else {
                NSLog(@"error access getPayorName");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
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
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    if (PlanEmpty) {
        
        cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    }
    else {
        if (indexPath.row == 5) {
            cell.textLabel.text = [[ListOfSubMenu objectAtIndex:indexPath.row] stringByAppendingFormat:@"(%@)", RiderCount ]; //change the rider count on the left tab bar
        }
        else {
            cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
        }
    }
        
    //--detail text label
	
    if (indexPath.row == 0) {
        if (NameLA.length != 0) {
            NSString *str = [[NSString alloc] initWithFormat:@"%@",NameLA];
            str = [str substringToIndex:MIN(30, [str length])];
            cell.detailTextLabel.text = str;
        }
        else {
            cell.detailTextLabel.text = @"";
        }
    }
    else if (indexPath.row == 1) {
        if (Name2ndLA.length != 0) {
            NSString *str = [[NSString alloc] initWithFormat:@"%@",Name2ndLA];
            str = [str substringToIndex:MIN(30, [str length])];
			
            cell.detailTextLabel.text = str;
        }
        else {
            cell.detailTextLabel.text = @"";
        }
    }
    else if (indexPath.row == 2) {
        if (NamePayor.length != 0) {
            NSString *str = [[NSString alloc] initWithFormat:@"%@",NamePayor];
            str = [str substringToIndex:MIN(30, [str length])];
            cell.detailTextLabel.text = str;
        }
        else {
            cell.detailTextLabel.text = @"";
        }
    }
    else {
        cell.detailTextLabel.text = @"";
    }
	
    //--
    
    cell.textLabel.textColor = [UIColor whiteColor];
    if (cell.textLabel.text.length > 25) {
        cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    }
//    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:12];
//    cell.detailTextLabel.textAlignment = UITextAlignmentLeft;
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    	
	
	if(self.myTableView.frame.size.height < 400.00 && indexPath.row == 3 ){
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor ];
		cell.contentView.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
	else{
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    
    return cell;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//perform checking before going next page
    blocked = YES;
    if([self validatePage])
    {
        blocked = NO;
		
//        if (previousPath.row == SIMENU_HEALTH_LOADING) {
//            _HLController = nil;
//        }
        
        [self hideKeyboard];
        if (indexPath.row == SIMENU_LIFEASSURED)     //life assured
        {
            NSLog(@"select LA:: age:%d, occp:%@, SI:%@",getAge,getOccpCode,getSINo);
            
            [self loadLAPage];
            selectedPath = indexPath;
            previousPath = selectedPath;
            blocked = NO;
			
        }
		
        else if (indexPath.row == SIMENU_SECOND_LIFE_ASSURED)
        {
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
                
            }
            else 
            if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) 
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
            }
            else 
            if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 )
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
            }
            else{
                [self loadSecondLAPage];
                selectedPath = indexPath;
            }
            
        }
        
        else if (indexPath.row == SIMENU_PAYOR)
        {
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
				
            }
            else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
				
            }
            else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
				
            }
            else{
                if([self selectPayor])
                {
                    [self loadPayorPage];
                    selectedPath = indexPath;
					
                }
                else{
                    blocked = YES;
                }
            }
            
        }
        
        else if (indexPath.row == SIMENU_BASIC_PLAN)
        {
            [_BasicController loadData];
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                blocked = YES;
				
                
            }
            else if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"]) && getAge > 65 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                
				blocked = !isSaveBasicPlan;
                
				
            }
            else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                
				blocked = !isSaveBasicPlan;
                
				
            }
            else{
                if (!saved) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Life Assured has not been saved yet.Leave this page without saving?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
                    [alert setTag:1001];
                    [alert show];
                }
                else if (!payorSaved) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Payor has not been saved yet.Leave this page without saving?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
                    [alert setTag:2001];
                    [alert show];
                }
                else {
                    //[self RemovePDS];
                    [self loadBasicPlanPage:YES];
                    selectedPath = indexPath;
                    
                }
            }            
        }        
        else if (indexPath.row == SIMENU_HEALTH_LOADING)
        {
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                
            }
            else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;				
            }
            else{
                
                [self loadHLPage];
                selectedPath = indexPath;
				
            }            
        }        
        else if (indexPath.row == SIMENU_RIDER)
        {
            /*
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                
            }
            else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else{
                [self checkingPayor];
                if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63) {//changed to 63 ; by Edwin 8-10-2013
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                    blocked = YES;
                }
                else if (getAge < 10 && payorSINo.length == 0) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                    blocked = YES;
                }
                else if (!saved) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Life Assured has not been saved yet.Leave this page without saving?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
                    [alert setTag:1002];
                    [alert show];
                }
                else if (!payorSaved) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Payor has not been saved yet.Leave this page without saving?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
                    [alert setTag:2002];
                    [alert show];
                }
                else {
//                    if (!_RiderController) {
                        self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
                        _RiderController.delegate = self;
                        self.RiderController.requestAge = getAge;
                        self.RiderController.requestSex = getSex;
                        self.RiderController.requestOccpCode = getOccpCode;
                        self.RiderController.requestOccpClass = getOccpClass;
                        
                        self.RiderController.requestSINo = getSINo;
                        self.RiderController.requestPlanCode = getPlanCode;
                        self.RiderController.requestPlanChoose = getBasicPlan;
                        self.RiderController.requestCoverTerm = getTerm;
                        self.RiderController.requestBasicSA = getbasicSA;
                        self.RiderController.requestBasicHL = getbasicHL;
                        self.RiderController.requestBasicTempHL = getbasicTempHL;
                        self.RiderController.requestMOP = getMOP;
                        self.RiderController.requestAdvance = getAdvance;
                        self.RiderController.requesteProposalStatus = eProposalStatus;
                        self.RiderController.requesteEDD = getEDD;
                        
						self.RiderController.EAPPorSI = [self.EAPPorSI description];
                        [self addChildViewController:self.RiderController];
                        [self.RightView addSubview:self.RiderController.view];
//                    }
//                    else{
//                        self.RiderController.requestAge = getAge;
//                        self.RiderController.requestSex = getSex;
//                        self.RiderController.requestOccpCode = getOccpCode;
//                        self.RiderController.requestOccpClass = getOccpClass;
//                        
//                        self.RiderController.requestSINo = getSINo;
//                        self.RiderController.requestPlanCode = getPlanCode;
//                        self.RiderController.requestPlanChoose = getBasicPlan;
//                        self.RiderController.requestCoverTerm = getTerm;
//                        self.RiderController.requestBasicSA = getbasicSA;
//                        self.RiderController.requestBasicHL = getbasicHL;
//                        self.RiderController.requestBasicTempHL = getbasicTempHL;
//                        self.RiderController.requestMOP = getMOP;
//                        self.RiderController.requestAdvance = getAdvance;
//                        self.RiderController.requesteProposalStatus = eProposalStatus;
//                        self.RiderController.requesteEDD = getEDD;
//						
//						self.RiderController.EAPPorSI = [self.EAPPorSI description];
//                        [self.RiderController loadRiderData];
//                        [self.RightView bringSubviewToFront:self.RiderController.view];
//						NSLog(@"bRIDER");
//						
//                    }
                    selectedPath = indexPath;
                    previousPath = selectedPath;
                    blocked = NO;
                    [self hideSeparatorLine];
                    [myTableView reloadData];
                }
            }    
             */
        }        
        else if (indexPath.row == SIMENU_PREMIUM)
        {
            if ([getOccpCode isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
                
            }
            else if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"]) && getAge > 65 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else{
                
                [self CheckPremAndMHI];
				[self calculatedPrem];
				selectedPath = indexPath;                
				[myTableView reloadData];
            }
        }
        else if (indexPath.row == SIMENU_QUOTATION)
        {
            [self hideKeyboard];
            if (getAge < 10 && payorSINo.length == 0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                blocked = YES;
            }
            else if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
             
                CurrentPath = indexPath.row;
                alert.tag = 7001;
                [alert show];
            }
            else
            {
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"] ) && appDel.allowedToShowReport == FALSE) {
                        NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                        [alert show];
                    }
                    else{
                        [self showQuotation];
                    }                    
                }            
            }
        }
        /*
        else if (indexPath.row == SIMENU_EXP_QUOTATION)
        {
            if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                
                CurrentPath = indexPath.row;
                alert.tag = 7001;
                [alert show];
            }
            else{
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    
                    if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"] ) && appDel.allowedToShowReport == FALSE) {
                        NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                        [alert show];
                    }
                    else{
                        [self exportQuotation];
                    }                    
                }
            }
        }        
        else if (indexPath.row == SIMENU_PRODUCT_DISCLOSURE_SHEET) 
        {   
            if (getAge < 10 && payorSINo.length == 0) 
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                blocked = YES;
            }
            else if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                
                CurrentPath = indexPath.row;
                alert.tag = 7001;
                [alert show];
            }
            else 
            {
                
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && appDel.allowedToShowReport == FALSE) {
                        NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                        [alert show];
                    }
                    else{
                        [self getSelectedLanguage];
                        [self showPDS];
                    }                    
                }                
            }
        }
        else if (indexPath.row == SIMENU_EXP_PDS)
        {
            if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && appDel.allowedToShowReport == FALSE) {
                NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                [alert show];
            }
            else{
                [self getSelectedLanguage];
                [self exportPDS];
            }            
        }
        else if (indexPath.row == SIMENU_UNDERWRITING)
        {
            
            if (getAge < 10 && payorSINo.length == 0) 
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                blocked = YES;
            }
            else if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                
                CurrentPath = indexPath.row;
                alert.tag = 7001;
                [alert show];
            }
            else
            {
                
                if([self validateSaveAllWithoutPrompt] == TRUE) {
                    if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && appDel.allowedToShowReport == FALSE) {
                        NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                        [alert show];
                    }
                    else{
                        [self getSelectedLanguage];
                        [self showUnderwriting];
                    }                    
                }                
            }
        }
         */
        else if (indexPath.row == SIMENU_PDS_SAVE_AS)
        {

            if ([getBasicPlan isEqualToString:@"HLAWP"] && [self DisplayMsgGIRR] == TRUE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please note that the Guaranteed Benefit payout for selected plan will be lesser than total premium outlay. You may increase the Basic Desired Annual Premium to increase the Guaranteed Benefit payout.\nChoose OK to proceed.\nChoose CANCEL to increase Basic Desired Annual Premium."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
                
                CurrentPath = indexPath.row;
                alert.tag = 7001;
                [alert show];
            }
            else{
                if([self validateSaveAllWithoutPrompt])
                {
                    if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"]) && appDel.allowedToShowReport == FALSE) {
                        NSString *dialogStr = @"Min modal premium requirement not met. Please increase sum assured for basic plan or rider(s)";
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:dialogStr delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                        [alert show];
                    }
                    else{
                        NSLog(@"update all successful");
                        
                        //*******set the isNeedPromptSaveMsg to NO to prevent further "Do you need to save changes" dialog from popping up ********//
                        appDel.isNeedPromptSaveMsg = NO;
                        
                        NSString* msg = [NSString stringWithFormat:@"Create a new SI from %@ (%@)?", getSINo, NameLA];
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                        alert.tag = 2000001;
                        [alert show];
                    }                    
                }
            }
            NSLog(@"Save As Clicked");            
        }
		
    }
    if (blocked) {
        [tableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        selectedPath = previousPath;
    }
    else {
        [tableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        previousPath = selectedPath;
    }	
}

-(void) getSelectedLanguage
{
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {        
        NSString *QuerySQL = [ NSString stringWithFormat:@"select \"quotationLang\" from Trad_Details as A where A.sino = \"%@\" AND \"seq\" = 1 ", getSINo];
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                lang = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"error access SI_Store_Premium when selecting language");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        
    }
}

- (void)buildSpinner {    
    spinner_SI = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner_SI.center = CGPointMake(400, 350);
    
    spinner_SI.hidesWhenStopped = YES;
    [self.view addSubview:spinner_SI];
    UILabel *spinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 370, 120, 40) ];
    spinnerLabel.text  = @" Please Wait...";
    spinnerLabel.backgroundColor = [UIColor blackColor];
    spinnerLabel.opaque = YES;
    spinnerLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:spinnerLabel];
    [self.view setUserInteractionEnabled:NO];
    [spinner_SI startAnimating];
    
    if (_FS == Nil) {
        self.FS = [FSVerticalTabBarController alloc];
        _FS.delegate = self;
    }
    
    [_FS Test ];
}

- (void) showGST {
    reportType = REPORT_GST;
    [self buildSpinner];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSString *htmlLang;
        if( [lang isEqualToString:@"Malay"] )
        {
            htmlLang = @"mly";
        }else
        {
            htmlLang = @"eng";
        }
                
        dispatch_async(dispatch_get_main_queue(), ^{           
            NSString *htmlPage = nil;
            
            htmlPage = [NSString stringWithFormat:@"gst/gst_%@_Page1", htmlLang];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:htmlPage ofType:@"html"];
            NSURL *pathURL = [NSURL fileURLWithPath:path];
            NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
            NSData* data = [NSData dataWithContentsOfURL:pathURL];
            [data writeToFile:[NSString stringWithFormat:@"%@/gst_Temp.html",documentsDirectory] atomically:YES];
            
            NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"gst_Temp.html"];
            if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                
                NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
                
                // Converting HTML to PDF
                NSString *SIPDFName = [NSString stringWithFormat:@"gst_%@.pdf",self.getSINo];
                self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:targetURL
                                                     pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                       delegate:self
                                                       pageSize:kPaperSizeA4
                                                        margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                
                targetURL = nil, SIPDFName = nil;
            }
            
            path = nil,pathURL = nil,path_forDirectory = nil, documentsDirectory = nil, data = nil, HTMLPath =nil;
        });
    });

}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void) showUnderwriting
{
    reportType = REPORT_UNDERWRITING;
    PDSorSI = @"UNDERWRITING";
    
    if ([getOccpCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] ||[getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];			
    }
    else{        
        if (![appDel.MhiMessage isEqualToString:@""] && appDel.MhiMessage != NULL) {
            NSString *RevisedSumAssured = appDel.MhiMessage;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ will be increase to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.",MHI_MSG_TYPE,RevisedSumAssured]
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            alert = Nil;
            RevisedSumAssured = Nil;
        }        
        [self buildSpinner];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
			
            PremiumViewController *premView = [[PremiumViewController alloc] init ];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = TRUE;
            [self presentViewController:premView animated:NO completion:Nil];
            [premView dismissViewControllerAnimated:NO completion:Nil];
            _delegate = premView;
            AppDelegate *del = (AppDelegate *) [ [UIApplication sharedApplication] delegate ];
            BOOL showReport = false;
            BOOL hasSecondOrPayor = false;
            NSArray *payorOrSecondLA = [NSArray arrayWithObjects: @"SP_PRE",@"SP_STD",@"LCWP",@"PLCP",@"PR",@"PTR",nil];

            int riderCodeCount = [premView.riderCode count];
            for (int p=0; p<riderCodeCount; p++) 
            {
                riderCode = [premView.riderCode objectAtIndex:p];
                
                if([payorOrSecondLA containsObject:riderCode])
                {
                    hasSecondOrPayor = TRUE;
                    break;
                }
            }
            if(riderCodeCount > 14 || (riderCodeCount >= 10 && hasSecondOrPayor))
            {
                need2PagesUnderwriting = true;
            }
            else
            {
                need2PagesUnderwriting = false;
            }
            
            premView = Nil;
            
            if([getBasicPlan isEqualToString:@"HLACP" ])
            {
                showReport = TRUE;
            }
            else
            if([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP" ])
            {
                showReport = del.allowedToShowReport;
            }
            
            if( showReport )
            {
                ReportViewController *ReportPage;
                CashPromiseViewController *CPReportPage;
                
                if([getBasicPlan isEqualToString:@"HLACP"] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]){
                    CPReportPage = [[CashPromiseViewController alloc] init ];
                    CPReportPage.SINo = getSINo;
                    CPReportPage.PDSorSI = @"PDS";
                    CPReportPage.pPlanCode = getBasicPlan;
                    CPReportPage.lang = lang;
                    CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                    CPReportPage.reportType = reportType;
                    CPReportPage.paymentOption = getMOP;
                    [self presentViewController:CPReportPage animated:NO completion:Nil];
                    
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
                    ReportPage.SINo = getSINo;
                    [self presentViewController:ReportPage animated:NO completion:Nil];
                }
                
                if([getBasicPlan isEqualToString:@"HLACP" ] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]){
                    
                    [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    [ReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                
                PDSViewController *PDSPage = [[PDSViewController alloc ] init ];
                PDSPage.SINo = getSINo;
                
                if( [lang isEqualToString:@"Malay"] )
                {
                    PDSPage.PDSLanguage = @"M";
                }else
                {
                    PDSPage.PDSLanguage = @"E";
                }
                
                PDSPage.PDSPlanCode = getBasicPlan;
                
                [self presentViewController:PDSPage animated:NO completion:Nil];
                
                [CPReportPage generateJSON_HLCP:YES];
                [CPReportPage copyReportFolderToDoc:@"underwriting"];
                
                ReportPage = Nil;
                CPReportPage = Nil;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [PDSPage dismissViewControllerAnimated:NO completion:Nil];
                    
                    NSString *htmlPage = nil;
                    
                    if ([lang isEqualToString:@"Malay"]) {
                        htmlPage = @"underwriting/Trad_mly_Page1";
                    } else {
                        htmlPage = @"underwriting/Trad_eng_Page1";
                    }
                        
                    NSString *path = [[NSBundle mainBundle] pathForResource:htmlPage ofType:@"html"];
                    NSURL *pathURL = [NSURL fileURLWithPath:path];
                    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
                    
                    NSData* data = [NSData dataWithContentsOfURL:pathURL];
                    [data writeToFile:[NSString stringWithFormat:@"%@/underwriting_Temp.html",documentsDirectory] atomically:YES];
                    
                    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"underwriting_Temp.html"];
                    if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                        
                        NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
                        
                        // Converting HTML to PDF
                        NSString *SIPDFName = [NSString stringWithFormat:@"underwriting_%@.pdf",self.getSINo];
                        self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:targetURL
                                                             pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                               delegate:self
                                                               pageSize:kPaperSizeA4
                                                                margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                        
                        targetURL = nil, SIPDFName = nil;
                    }
                    
                    path = nil,pathURL = nil,path_forDirectory = nil, documentsDirectory = nil, data = nil, HTMLPath =nil;
                });
                
                PDSPage = Nil;
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Display/dismiss your alert
                    [spinner_SI stopAnimating ];
                    [self.view setUserInteractionEnabled:YES];
                    [_FS Reset];
                    
                    UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                    [v removeFromSuperview];
                    v = Nil;
                    
                    if (previousPath == Nil) {
                        previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                    }
                    
                    [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    selectedPath = previousPath;
                    spinner_SI = Nil;
                    
                    [_delegate showReportCantDisplay:[PremiumViewController getMsgTypeL100] ];                    
                });
            }
        });
    }
    
}

- (void) showPDS
{
    reportType = REPORT_PDS;
    PDSorSI = @"PDS";
    
    if ([getOccpCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else if (([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]) && getAge > 65 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];			
    }
    else{        
        NSString *RevisedSumAssured = appDel.MhiMessage;
        if (![appDel.MhiMessage isEqualToString:@""] && appDel.MhiMessage != NULL) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ will be increase to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.",MHI_MSG_TYPE,RevisedSumAssured]
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            alert = Nil;
            RevisedSumAssured = Nil;
        }
        
        [self buildSpinner];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{			
            PremiumViewController *premView = [[PremiumViewController alloc] init ];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = TRUE;
            [self presentViewController:premView animated:NO completion:Nil];
            [premView dismissViewControllerAnimated:NO completion:Nil];
            _delegate = premView;
            AppDelegate *del = (AppDelegate *) [ [UIApplication sharedApplication] delegate ];
            BOOL showReport = false;
            premView = Nil;
            
            if([getBasicPlan isEqualToString:@"HLACP" ])
            {
                showReport = TRUE;
            }else
            if([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"])
            {
                showReport = del.allowedToShowReport;
            }
            
            if( showReport )
            {
                ReportViewController *ReportPage;
                CashPromiseViewController *CPReportPage;
                
                if([getBasicPlan isEqualToString:@"HLACP"] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]){
                    CPReportPage = [[CashPromiseViewController alloc] init ];
                    CPReportPage.SINo = getSINo;
                    CPReportPage.PDSorSI = @"PDS";
                    CPReportPage.pPlanCode = getBasicPlan;
                    CPReportPage.lang = lang;
                    CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                    CPReportPage.reportType = reportType;
                    CPReportPage.paymentOption = getMOP;
                    [self presentViewController:CPReportPage animated:NO completion:Nil];
                    
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
                    ReportPage.SINo = getSINo;
                    [self presentViewController:ReportPage animated:NO completion:Nil];
                }
                
                if([getBasicPlan isEqualToString:@"HLACP" ] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]){
                    
                    [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    [ReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                
                PDSViewController *PDSPage = [[PDSViewController alloc ] init ];
                PDSPage.SINo = getSINo;
                
                if( [lang isEqualToString:@"Malay"] )
                {
                    PDSPage.PDSLanguage = @"M";
                }else
                {
                    PDSPage.PDSLanguage = @"E";
                }
                PDSPage.PDSPlanCode = getBasicPlan;
                
                [self presentViewController:PDSPage animated:NO completion:Nil];
                
                [CPReportPage generateJSON_HLCP:YES];
                [CPReportPage copyReportFolderToDoc:@"PDS"];
                
                ReportPage = Nil;
                CPReportPage = Nil;
                
                dispatch_async(dispatch_get_main_queue(), ^{                    
                    [PDSPage dismissViewControllerAnimated:NO completion:Nil];
                    NSString *htmlPage = nil;

                    if([getBasicPlan isEqualToString:@"HLACP" ])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_ENG_Page1";
                        }
                    }else
                        if([getBasicPlan isEqualToString:@"S100" ])
                        {
                            if( [lang isEqualToString:@"Malay"] )
                            {
                                htmlPage = @"PDS/PDS_BM_S100_Page1";
                            }else
                            {
                                htmlPage = @"PDS/PDS_ENG_S100_Page1";
                            }
                    }else
                    if([getBasicPlan isEqualToString:@"L100" ])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_L100_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_Eng_L100_Page1";
                        }
                    }else
                    if([getBasicPlan isEqualToString:@"HLAWP" ])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_HLAWP_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_ENG_HLAWP_Page1";
                        }
                    }
                    
                    NSString *path = [[NSBundle mainBundle] pathForResource:htmlPage ofType:@"html"];
                    NSURL *pathURL = [NSURL fileURLWithPath:path];
                    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
                    
                    NSData* data = [NSData dataWithContentsOfURL:pathURL];
                    [data writeToFile:[NSString stringWithFormat:@"%@/PDS_ENG_Temp.html",documentsDirectory] atomically:YES];
                    
                    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"PDS_ENG_Temp.html"];
                    if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                        
                        NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
                        
                        // Converting HTML to PDF
                        NSString *SIPDFName = [NSString stringWithFormat:@"PDS_%@.pdf",self.getSINo];
                        self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:targetURL
                                                             pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                               delegate:self
                                                               pageSize:kPaperSizeA4
                                                                margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                        
                        targetURL = nil, SIPDFName = nil;
                    }
                    
                    path = nil,pathURL = nil,path_forDirectory = nil, documentsDirectory = nil, data = nil, HTMLPath =nil;
                });
                
                PDSPage = Nil;
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Display/dismiss your alert
                    [spinner_SI stopAnimating ];
                    [self.view setUserInteractionEnabled:YES];
                    [_FS Reset];
                    
                    UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                    [v removeFromSuperview];
                    v = Nil;
                    
                    if (previousPath == Nil) {
                        previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                    }
                    
                    [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    selectedPath = previousPath;
                    spinner_SI = Nil;
                    
                    [_delegate showReportCantDisplay:[PremiumViewController getMsgTypeL100] ];
                });
            }            
        });        
    }   
}

//added by Edwin 25-09-2013
- (void) exportPDS
{
    
    PDSorSI = @"PDS";
    
    if ([getOccpCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else{
        if (![appDel.MhiMessage isEqualToString:@""] && appDel.MhiMessage != NULL) {
            NSString *RevisedSumAssured = appDel.MhiMessage;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ will be increase to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.",MHI_MSG_TYPE,RevisedSumAssured]
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            alert = Nil;
            RevisedSumAssured = Nil;
        }
                
        if (_FS == Nil) {
            self.FS = [FSVerticalTabBarController alloc];
            _FS.delegate = self;
        }        
        [_FS Test ];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{			
            PremiumViewController *premView = [[PremiumViewController alloc] init ];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = TRUE;
            [self presentViewController:premView animated:NO completion:Nil];
            [premView dismissViewControllerAnimated:NO completion:Nil];
            _delegate = premView;
            AppDelegate *del = (AppDelegate *) [ [UIApplication sharedApplication] delegate ];
            BOOL showReport = false;
            premView = Nil;
            
            if([getBasicPlan isEqualToString:@"HLACP" ])
            {
                showReport = TRUE;
            }
            else
            if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"])
            {
                showReport = del.allowedToShowReport;
            }
            
            if( showReport )
            {
                ReportViewController *ReportPage;
                CashPromiseViewController *CPReportPage;
                
                if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"]||[getBasicPlan isEqualToString:@"HLACP"] || [getBasicPlan isEqualToString:@"L100"]){
                    CPReportPage = [[CashPromiseViewController alloc] init ];
                    CPReportPage.SINo = getSINo;
                    CPReportPage.PDSorSI = @"PDS";
                    CPReportPage.pPlanCode = getBasicPlan;
                    CPReportPage.lang = lang;
                    CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                    CPReportPage.reportType = reportType;
                    CPReportPage.paymentOption = getMOP;
                    [self presentViewController:CPReportPage animated:NO completion:Nil];
                    
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
                    ReportPage.SINo = getSINo;
                    [self presentViewController:ReportPage animated:NO completion:Nil];
                }
                
                if([getBasicPlan isEqualToString:@"S100"]  || [getBasicPlan isEqualToString:@"HLAWP"]||[getBasicPlan isEqualToString:@"HLACP" ] || [getBasicPlan isEqualToString:@"L100"]){
                    
                    [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                    [ReportPage dismissViewControllerAnimated:NO completion:Nil];
                }
                
                PDSViewController *PDSPage = [[PDSViewController alloc ] init ];
                PDSPage.SINo = getSINo;
                if( [lang isEqualToString:@"Malay"] )
                {
                    PDSPage.PDSLanguage = @"M";
                }
                else{
                    PDSPage.PDSLanguage = @"E";
                }
                
                PDSPage.PDSPlanCode = getBasicPlan;
                
                [self presentViewController:PDSPage animated:NO completion:Nil];
                
                [CPReportPage generateJSON_HLCP:YES];
                [CPReportPage copyReportFolderToDoc:@"PDS"];
                
                ReportPage = Nil;
                CPReportPage = Nil;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [PDSPage dismissViewControllerAnimated:NO completion:Nil];                    
                    NSString *htmlPage = nil;
                    
                    if([getBasicPlan isEqualToString:@"S100"])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_S100_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_Eng_S100_Page1";
                        }
                    }
                    else if([getBasicPlan isEqualToString:@"HLAWP"])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_HLAWP_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_Eng_HLAWP_Page1";
                        }
                    }
                    else if([getBasicPlan isEqualToString:@"HLACP"])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_Eng_Page1";
                        }
                    }
                    else if([getBasicPlan isEqualToString:@"L100"])
                    {
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            htmlPage = @"PDS/PDS_BM_L100_Page1";
                        }else
                        {
                            htmlPage = @"PDS/PDS_Eng_L100_Page1";
                        }
                    }
                    
                    NSString *path = [[NSBundle mainBundle] pathForResource:htmlPage ofType:@"html"];
                    NSURL *pathURL = [NSURL fileURLWithPath:path];
                    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
                    
                    NSData* data = [NSData dataWithContentsOfURL:pathURL];
                    [data writeToFile:[NSString stringWithFormat:@"%@/PDS_Eng_Temp.html",documentsDirectory] atomically:YES];
                    
                    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"PDS_Eng_Temp.html"];
                    //NSLog(@"delete HTML file Path: %@",HTMLPath);
                    if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                        
                        NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
                        //NSLog(@"zzzz%@",targetURL);
                        
                        // Converting HTML to PDF
                        //sleep(2);
                        NSString *SIPDFName = [NSString stringWithFormat:@"PDS_export_%@.pdf",self.getSINo];
                        self.PDFCreator = [NDHTMLtoPDF exportPDFWithURL:targetURL
                                                             pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                               delegate:self
                                                               pageSize:kPaperSizeA4
                                           //                   margins:UIEdgeInsetsMake(20, 5, 90, 5)];
                                                                margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                        message:[@"Created " stringByAppendingPathComponent:SIPDFName]
                                              
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert show];
                        alert = Nil;
                        targetURL = nil, SIPDFName = nil;
                        
                    }
                    
                    [_FS Reset];
                    path = nil,pathURL = nil,path_forDirectory = nil, documentsDirectory = nil, data = nil, HTMLPath =nil;
                });
                
                PDSPage = Nil;
            }else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Display/dismiss your alert
                    [self.view setUserInteractionEnabled:YES];
                    [_FS Reset];
                    
                    UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                    [v removeFromSuperview];
                    v = Nil;
                    
                    if (previousPath == Nil) {
                        previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                    }                    
                    [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    selectedPath = previousPath;
                    
                    [_delegate showReportCantDisplay:[PremiumViewController getMsgTypeL100] ];
                });
            }
        });
    }
}

/**
 Edwin 22-08-2013
 Switch language common function
 */
- (void) showQuotation
{
    reportType = REPORT_SI;
    PDSorSI = @"SI";
    if ([getOccpCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else if (([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"]) && getAge > 65 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 65 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];			
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else{
        /*
        if (![appDel.MhiMessage isEqualToString:@""] && appDel.MhiMessage != NULL  ) {
            NSString *RevisedSumAssured = appDel.MhiMessage;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ will be increase to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.",MHI_MSG_TYPE,RevisedSumAssured]
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            alert = Nil;
            RevisedSumAssured = Nil;
        }
 */
        
        sqlite3_stmt *statement;
        BOOL cont = FALSE;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {            
            NSString *QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
                                  "\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",  \"sex\", \"quotationLang\" from Trad_Details as A, "
                                  "Clt_Profile as B, trad_LaPayor as C where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                                  "A.sino = \"%@\" AND \"seq\" = 1 ", getSINo];
            if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    cont = TRUE;
                    lang = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                } else {
                    cont = FALSE;
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);            
        }
        
        if (_FS == Nil) {
            self.FS = [FSVerticalTabBarController alloc];
            _FS.delegate = self;
        }        
        
        if (cont == TRUE) {
            [self buildSpinner];            
            PremiumViewController *premView = [[PremiumViewController alloc] init ];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = TRUE;
            [self presentViewController:premView animated:NO completion:Nil];
            [premView dismissViewControllerAnimated:NO completion:Nil];
            _delegate = premView;
            AppDelegate *del = (AppDelegate *) [ [UIApplication sharedApplication] delegate ];
            premView = Nil;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                BOOL showReport = false;
                
                if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"] )
                {
                    showReport = del.allowedToShowReport;
                }
                else if([getBasicPlan isEqualToString:@"HLACP" ] || [getBasicPlan isEqualToString:@"BCALH"])
                {
                    showReport = TRUE;
                }
                
                if( showReport )
                {
                    ReportViewController *ReportPage;
                    CashPromiseViewController *CPReportPage;
                    
                    if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"BCALH"])
                    {
                        CPReportPage = [[CashPromiseViewController alloc] init ];
                        CPReportPage.SINo = getSINo;
                        CPReportPage.PDSorSI = @"SI";
                        CPReportPage.pPlanCode = getBasicPlan;
                        CPReportPage.lang = lang;
                        CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                        CPReportPage.reportType = reportType;
                        CPReportPage.paymentOption = getMOP;
                        [self presentViewController:CPReportPage animated:NO completion:Nil];
                    }
                    else if([getBasicPlan isEqualToString:@"HLACP" ])
                    {
                        CPReportPage = [[CashPromiseViewController alloc] init ];
                        CPReportPage.SINo = getSINo;
                        CPReportPage.PDSorSI = @"SI";
                        CPReportPage.pPlanCode = getBasicPlan;
                        CPReportPage.lang = lang;
                        CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                        CPReportPage.reportType = reportType;
                        CPReportPage.paymentOption = getMOP;
                        [self presentViewController:CPReportPage animated:NO completion:Nil];
                    }
                    else if([getBasicPlan isEqualToString:@"HLAIB" ])
                    {
                        ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
                        ReportPage.SINo = getSINo;
                        [self presentViewController:ReportPage animated:NO completion:Nil];
                    }
                    
                    [CPReportPage generateJSON_HLCP:NO];
                    [CPReportPage copyReportFolderToDoc:@"SI"];
                    
                    NSLog(@"Generating report for: %@", getBasicPlan);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"] || [getBasicPlan isEqualToString:@"HLACP"] ||[getBasicPlan isEqualToString:@"L100"])
                        {
                            if (CPReportPage.TotalCI > 4000000){
                                [spinner_SI stopAnimating ];
                                [self.view setUserInteractionEnabled:YES];
                                [_FS Reset];
                                
                                UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                                [v removeFromSuperview];
                                v = Nil;
                                
                                if (previousPath == Nil) {
                                    previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                                }
                                
                                [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                                selectedPath = previousPath;
                                spinner_SI = Nil;
                                
                                NSString *strCIRiders = @"";
                                
                                for (int i = 0; i < CPReportPage.CIRiders.count; i++) {
                                    strCIRiders = [strCIRiders stringByAppendingFormat:@"\n%d. %@", i + 1, [CPReportPage.CIRiders objectAtIndex:i]];
                                }
                                
                                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                message:[ NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. "
                                                                                         "Please revise the RSA of CI related rider(s) below as the CI Benefit Limit per Life across industry for 1st Life Assured"
                                                                                         " has exceeded RM4mil. %@", strCIRiders]
                                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [Alert show];
                                Alert = nil;
                                
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                                
                                return;
                            }
                            else if (CPReportPage.TotalCI2 > 4000000)
                            {
                                [spinner_SI stopAnimating ];
                                [self.view setUserInteractionEnabled:YES];
                                [_FS Reset];
                                
                                UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                                [v removeFromSuperview];
                                v = Nil;
                                
                                if (previousPath == Nil) {
                                    previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                                }
                                
                                [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                                selectedPath = previousPath;
                                spinner_SI = Nil;
                                
                                NSString *strCIRiders2 = @"";
                                
                                for (int i = 0; i < CPReportPage.CIRiders2.count; i++) {
                                    strCIRiders2 = [strCIRiders2 stringByAppendingFormat:@"\n%d. %@", i + 1, [CPReportPage.CIRiders2 objectAtIndex:i]];
                                }
                                
                                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                message:[ NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. "
                                                                                         "Please revise the RSA of CI related rider(s) below as the CI Benefit Limit per Life across industry for 2nd Life Assured"
                                                                                         " has exceeded RM4mil. %@", strCIRiders2]
                                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [Alert show];
                                Alert = nil;
                                
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                                
                                return;
                            }
                            else{
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                            }
                            
                            
                        }
                        else if([getBasicPlan isEqualToString:@"HLAIB" ] ){
                            [ReportPage dismissViewControllerAnimated:NO completion:Nil];
                        }
                        
                        
                        NSString *path = nil;
                        
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            if([getBasicPlan isEqualToString:@"S100"])
                            {
                                    path = [[NSBundle mainBundle] pathForResource:@"SI/mly_S100_Page1" ofType:@"html"];
                            }
                            else if([getBasicPlan isEqualToString:@"HLAWP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_HLAWP_Page1" ofType:@"html"]; 
                            }
                            else if([getBasicPlan isEqualToString:@"HLACP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }
                            else if([getBasicPlan isEqualToString:@"L100"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_L100_Page1" ofType:@"html"];
                            }
                        }else
                        {
                            if([getBasicPlan isEqualToString:@"S100"])
                            {
                                    path = [[NSBundle mainBundle] pathForResource:@"SI/eng_S100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }
                            else if([getBasicPlan isEqualToString:@"HLAWP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_HLAWP_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }
                            else if([getBasicPlan isEqualToString:@"HLACP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }
                            else if([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"BCALH"] )
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_L100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }
                        }
                        
                        NSURL *pathURL = [NSURL fileURLWithPath:path];
                        NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                        NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
                        
                        NSData* data = [NSData dataWithContentsOfURL:pathURL];
                        [data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
                        
                        NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
                        if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                            
                            NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];                            
                            // Converting HTML to PDF
                            NSString *SIPDFName = [NSString stringWithFormat:@"%@.pdf",self.getSINo];
                            self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:targetURL
                                                                 pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                                   delegate:self
                                                                   pageSize:kPaperSizeA4
                                                                    margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                        }                                                
                        
                    });
                    
                    ReportPage = Nil;
                    CPReportPage = Nil;
                }else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Display/dismiss your alert
                        [spinner_SI stopAnimating ];
                        [self.view setUserInteractionEnabled:YES];
                        [_FS Reset];
                        
                        UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                        [v removeFromSuperview];
                        v = Nil;
                        
                        if (previousPath == Nil) {
                            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                        }
                        
                        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                        selectedPath = previousPath;
                        spinner_SI = Nil;

                        [_delegate showReportCantDisplay:[PremiumViewController getMsgTypeL100] ];
                    });
                }
            });            
        }
        else {            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"SI has been deleted" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
            [alert show];
            alert = Nil;            
        }        
        statement = Nil;
    }    
}

//added by Edwin 25-09-2013
- (void) exportQuotation
{    
    PDSorSI = @"SI";
    
    if ([getOccpCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    else if ([getBasicPlan isEqualToString:@"HLACP"] && getAge > 63 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        if (previousPath == Nil) {
            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
        }
        
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else{                
        if (![appDel.MhiMessage isEqualToString:@""] && appDel.MhiMessage != NULL  ) {
            NSString *RevisedSumAssured = appDel.MhiMessage;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ will be increase to RM%@ in accordance to MHI Guideline. The RSA for non-MHI rider(s) (if any) have been increased accordingly as well.",MHI_MSG_TYPE,RevisedSumAssured]
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
            alert = Nil;
            RevisedSumAssured = Nil;
        }
        sqlite3_stmt *statement;
        BOOL cont = FALSE;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {            
            NSString *QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
                                  "\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",  \"sex\", \"quotationLang\" from Trad_Details as A, "
                                  "Clt_Profile as B, trad_LaPayor as C where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                                  "A.sino = \"%@\" AND \"seq\" = 1 ", getSINo];
            
            
            
            if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    cont = TRUE;
                    lang = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                } else {
                    cont = FALSE;
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);            
        }
        
        if (_FS == Nil) {
            self.FS = [FSVerticalTabBarController alloc];
            _FS.delegate = self;
        }        
        
        if (cont == TRUE) {
            [_FS Test ];
            PremiumViewController *premView = [[PremiumViewController alloc] init ];
            premView.requestAge = getAge;
            premView.requestOccpClass = getOccpClass;
            premView.requestOccpCode = getOccpCode;
            premView.requestSINo = getSINo;
            premView.requestMOP = getMOP;
            premView.requestTerm = getTerm;
            premView.requestBasicSA = getbasicSA;
            premView.requestBasicHL = getbasicHL;
            premView.requestBasicTempHL = getbasicTempHL;
            premView.requestPlanCode = getPlanCode;
            premView.requestBasicPlan = getBasicPlan;
            premView.sex = getSex;
            premView.EAPPorSI = [self.EAPPorSI description];
            premView.fromReport = TRUE;
            [self presentViewController:premView animated:NO completion:Nil];
            [premView dismissViewControllerAnimated:NO completion:Nil];
            _delegate = premView;
//            premView = Nil;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                
                AppDelegate *del = (AppDelegate *) [ [UIApplication sharedApplication] delegate ];
                BOOL showReport = false;
                
                if([getBasicPlan isEqualToString:@"HLACP" ])
                {
                    showReport = TRUE;
                }else
                    if([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP"])
                    {
                        showReport = del.allowedToShowReport;
                    }
                
                if( showReport )
                {
                    ReportViewController *ReportPage;
                    CashPromiseViewController *CPReportPage;
                    
                    if([getBasicPlan isEqualToString:@"HLAWP" ] || [getBasicPlan isEqualToString:@"HLACP" ]){
                        CPReportPage = [[CashPromiseViewController alloc] init ];
                        CPReportPage.SINo = getSINo;
                        CPReportPage.PDSorSI = @"SI";
                        CPReportPage.pPlanCode = getBasicPlan;
                        CPReportPage.lang = lang;
                        CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                        CPReportPage.reportType = reportType;
                        CPReportPage.paymentOption = getMOP;
                        [self presentViewController:CPReportPage animated:NO completion:Nil];
                    }
                    else if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"L100"]){
                        CPReportPage = [[CashPromiseViewController alloc] init ];
                        CPReportPage.SINo = getSINo;
                        CPReportPage.PDSorSI = @"SI";
                        CPReportPage.pPlanCode = getBasicPlan;
                        CPReportPage.lang = lang;
                        CPReportPage.need2PagesUnderwriting = need2PagesUnderwriting;
                        CPReportPage.reportType = reportType;
                        CPReportPage.paymentOption = getMOP;
                        [self presentViewController:CPReportPage animated:NO completion:Nil];
                    }
                    else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                        ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
                        ReportPage.SINo = getSINo;
                        [self presentViewController:ReportPage animated:NO completion:Nil];
                    }                    
                    [CPReportPage generateJSON_HLCP:NO];
                    [CPReportPage copyReportFolderToDoc:@"SI"];
                    
                    NSLog(@"Exporting quotation for: %@", getBasicPlan);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if([getBasicPlan isEqualToString:@"S100"] || [getBasicPlan isEqualToString:@"HLAWP" ] || [getBasicPlan isEqualToString:@"HLACP" ] ||[getBasicPlan isEqualToString:@"L100"])
                        {
                            if (CPReportPage.TotalCI > 4000000){
                                [self.view setUserInteractionEnabled:YES];
                                [_FS Reset];
                                
                                UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                                [v removeFromSuperview];
                                v = Nil;
                                
                                if (previousPath == Nil) {
                                    previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                                }
                                
                                [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                                selectedPath = previousPath;
                                
                                NSString *strCIRiders = @"";
                                
                                for (int i = 0; i < CPReportPage.CIRiders.count; i++) {
                                    strCIRiders = [strCIRiders stringByAppendingFormat:@"\n%d. %@", i + 1, [CPReportPage.CIRiders objectAtIndex:i]];
                                }
                                
                                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                message:[ NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. "
                                                                                         "Please revise the RSA of CI related rider(s) below as the CI Benefit Limit per Life across industry for 1st Life Assured"
                                                                                         " has exceeded RM4mil. %@", strCIRiders]
                                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [Alert show];
                                Alert = nil;
                                
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                                
                                return;
                            }
                            else if (CPReportPage.TotalCI2 > 4000000){
                                [spinner_SI stopAnimating ];
                                [self.view setUserInteractionEnabled:YES];
                                [_FS Reset];
                                
                                UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                                [v removeFromSuperview];
                                v = Nil;
                                
                                if (previousPath == Nil) {
                                    previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                                }
                                
                                [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                                selectedPath = previousPath;
                                spinner_SI = Nil;
                                
                                NSString *strCIRiders2 = @"";
                                
                                for (int i = 0; i < CPReportPage.CIRiders2.count; i++) {
                                    strCIRiders2 = [strCIRiders2 stringByAppendingFormat:@"\n%d. %@", i + 1, [CPReportPage.CIRiders2 objectAtIndex:i]];
                                }
                                
                                UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                message:[ NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. "
                                                                                         "Please revise the RSA of CI related rider(s) below as the CI Benefit Limit per Life across industry for 2nd Life Assured"
                                                                                         " has exceeded RM4mil. %@", strCIRiders2]
                                                                               delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [Alert show];
                                Alert = nil;
                                
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                                
                                return;
                            }
                            else{
                                [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
                            }
                            
                            
                        }
                        else if([getBasicPlan isEqualToString:@"HLAIB" ]){
                            [ReportPage dismissViewControllerAnimated:NO completion:Nil];
                        }                        
                        
                        NSString *path = nil;
                        
                        if( [lang isEqualToString:@"Malay"] )
                        {
                            if([getBasicPlan isEqualToString:@"HLACP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"L100"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_L100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"S100"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_S100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"HLAWP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/mly_HLAWP_Page1" ofType:@"html"];
                            }
                        }else
                        {
                            if([getBasicPlan isEqualToString:@"HLACP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"L100"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_L100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"S100"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_S100_Page1" ofType:@"html"]; //changed for language switcher @edwin 4-9-2013
                            }else
                            if([getBasicPlan isEqualToString:@"HLAWP"])
                            {
                                path = [[NSBundle mainBundle] pathForResource:@"SI/eng_HLAWP_Page1" ofType:@"html"]; 
                            }
                        }
                        
                        
                        
                        NSURL *pathURL = [NSURL fileURLWithPath:path];
                        NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                        NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
                        
                        NSData* data = [NSData dataWithContentsOfURL:pathURL];
                        [data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
                        
                        NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
                        if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
                            NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
                            
                            // Converting HTML to PDF
                            NSString *SIPDFName = [NSString stringWithFormat:@"Quotation_export_%@.pdf",self.getSINo];
                            self.PDFCreator = [NDHTMLtoPDF exportPDFWithURL:targetURL
                                                                 pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                                                   delegate:self
                                                                   pageSize:kPaperSizeA4
                                               //                   margins:UIEdgeInsetsMake(20, 5, 90, 5)];
                                                                    margins:UIEdgeInsetsMake(0, 0, 0, 0)];
                            
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                            message:[@"Created " stringByAppendingPathComponent:SIPDFName]                                                  
                                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert show];
                            alert = Nil;
                            [_FS Reset];                            
                        }
                    });
                    
                    ReportPage = Nil;
                    CPReportPage = Nil;
                }else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // Display/dismiss your alert
                        [spinner_SI stopAnimating ];
                        [self.view setUserInteractionEnabled:YES];
                        [_FS Reset];
                        
                        UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                        [v removeFromSuperview];
                        v = Nil;
                        
                        if (previousPath == Nil) {
                            previousPath =	[NSIndexPath indexPathForRow:0 inSection:0];
                        }
                        
                        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                        selectedPath = previousPath;
                        spinner_SI = Nil;
                        
                        [_delegate showReportCantDisplay:[PremiumViewController getMsgTypeL100] ];
                    });
                }
            });
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"SI has been deleted" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
            [alert show];
            alert = Nil;            
        }        
        
        statement = Nil;
    }
}


-(void)setIsSecondLaNeeded:(BOOL)temp
{
    isSecondLaNeeded = temp;
}

-(BOOL)savePage:(int)option//validate then save page
{
    int result;
    switch (option) {
        case SIMENU_LIFEASSURED:
            if ([self.LAController validateSave])
            {
                return[self.LAController performSaveData];
            }
			
            break;
        case SIMENU_SECOND_LIFE_ASSURED:
            if (isSecondLaNeeded) {
				self.SecondLAController.requestSINo = getSINo;
                if ( [self.SecondLAController validateSave])
                {
                    return[self.SecondLAController performUpdateData];
                }
				
            }
            else{
                return YES; //added in to return true if SECOND LA is not added, if not it will continue to stuck at 2nd LA page 
            }
            
            break;
        case SIMENU_PAYOR:
            if(self.PayorController && [self.PayorController isPayorSelected])
            {
                if([self.PayorController validateSave])
                {
                    return[self.PayorController performSavePayor];
                }
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                return NO;
            }
            break;
        case SIMENU_BASIC_PLAN:			
            if(self.BasicController && [self.BasicController isBasicPlanSelected])
            {
                result = [self.BasicController validateSave];
                if(result == 0)
                {
                    if (isSaveBasicPlan) {                        
                        return[self.BasicController checkingSave:getSex];
                    }
                    else{
                        return YES;
                    }
                } else if (result == SIMENU_HEALTH_LOADING) {
                    [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SIMENU_HEALTH_LOADING inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                    
                    selectedPath = [NSIndexPath indexPathForRow:SIMENU_HEALTH_LOADING inSection:0];
                    [self loadHLPage];
                    return NO;
                }
            }
            else{
                return YES;
            }			
            break;            
        case SIMENU_HEALTH_LOADING:
            if ([self.HLController validateSave]) {
                return [self.HLController updateHL];
            } ;            
            break;            
        case SIMENU_RIDER:
        //case SIMENU_GST:
        case SIMENU_PREMIUM:
        case SIMENU_QUOTATION:
        //case SIMENU_PRODUCT_DISCLOSURE_SHEET:
        case SIMENU_PDS_SAVE_AS:
            return YES;
            break;
        default:
            break;
    }	
    return NO;
}

#pragma mark - GET SI AND CUSTCODE
-(void)getRunningSI
{
    sqlite3_stmt *statement;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"SI\" AND LastUpdated like \"%%%@%%\"", dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                SILastNo = sqlite3_column_int(statement, 0);
                
                const char *lastDate = (const char *)sqlite3_column_text(statement, 1);
                SIDateSIMenu = lastDate == NULL ? nil : [[NSString alloc] initWithUTF8String:lastDate];
                
                NSLog(@"LastSINo:%d SIDate:%@",SILastNo,SIDateSIMenu);                
            } else {
                SILastNo = 0;
                SIDateSIMenu = dateString;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }    
    [self updateFirstRunSI];
}

-(void)getRunningCustCode
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"CL\" AND LastUpdated like \"%%%@%%\" ",dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustLastNo = sqlite3_column_int(statement, 0);
                
                const char *lastDate = (const char *)sqlite3_column_text(statement, 1);
                CustDate = lastDate == NULL ? nil : [[NSString alloc] initWithUTF8String:lastDate];
                
                NSLog(@"LastCustNo:%d CustDate:%@",CustLastNo,CustDate);                
            } else {
                CustLastNo = 0;
                CustDate = dateString;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }    
    [self updateFirstRunCust];
}

-(void)updateFirstRunSI
{
    int newLastNo;
    newLastNo = SILastNo + 1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated=\"%@\" WHERE TrnTypeCode=\"SI\"",newLastNo, dateString];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Run SI update!");
                
            } else {
                NSLog(@"Run SI update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateFirstRunCust
{
    int newLastNo;
    newLastNo = CustLastNo + 1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated= \"%@\" WHERE TrnTypeCode=\"CL\"",newLastNo,dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Run Cust update!");
                
            } else {
                NSLog(@"Run Cust update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateSecondRunCust
{
    int newLastNo;
    newLastNo = CustLastNo + 2;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated= \"%@\" WHERE TrnTypeCode=\"CL\"",newLastNo,dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Run second Cust update!");
                
            } else {
                NSLog(@"Run second Cust update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


#pragma mark - Save As
-(BOOL)saveAs
{
    BOOL success = NO;
    
    [self getSINoAndCustCode];
    [self getRunningSI];
    
    //CONTINUE DUPLICATE SI FOR SAVE AS WITH FROM LAPAYOR
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSMutableArray * arrTempLAPayor = [[NSMutableArray alloc]init];
    
    NSString* sqlStatement;
    
    sqlStatement = [NSString stringWithFormat:@"SELECT * from Trad_LAPayor WHERE SINo = '%@'",[self.getSINo description]];
    [self retrieveRowFromDB:sqlStatement arrOfLaPayor:arrTempLAPayor];
    
    [self insertDuplicateSIData:arrTempLAPayor];
    return success;
}

-(void)insertDuplicateSIData:(NSArray*)arr
{
    NSString* sqlStatement;
    NSMutableDictionary* dict;
    for (int i =0; i< [arr count]; i++) {
        sqlStatement = @"INSERT INTO Trad_LAPayor VALUES (";        
        dict = [arr objectAtIndex:i];
        
        for (int j = 0; j<[dict count]; j++) {            
            if(j == [dict count]-1)
            {
                sqlStatement = [NSString stringWithFormat:@"%@ '%@')",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
            }
            else{
                sqlStatement = [NSString stringWithFormat:@"%@ '%@',",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
            }            
        }
    }	
}

-(NSString*) getRunningCust:(NSString*)currentdate
{
    CustLastNo++;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", CustLastNo];
    NSString* custCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    return custCode;
}

-(BOOL)SaveAsTemp{ //save as new SI
	
    NSString * firstCustCode = [self getSINoAndCustCode];
    NSString * secondCustCode = [self getSINoAndCustCode2nd];
    NSString * pYCustCode = [self getSINoAndCustCodePY];
    [self getRunningSI];
    [self getRunningCustCode];
    
    if (secondCustCode.length > 0) { //update clt_profile to prevent duplicate issue by increase CL counter
        [self updateSecondRunCust];
    }
    
    if (pYCustCode.length > 0) {
        [self updateSecondRunCust];
    }

    //generate SINo || CustCode
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoSI = SILastNo + 1;        
    NSString *fooSI = [NSString stringWithFormat:@"%04d", runningNoSI];
    
    getSINo = [[NSString alloc] initWithFormat:@"SI%@-%@",currentdate,fooSI];
    
    
    NSString* currSINo = saveAsSINo;
    NSString* nextSiNo = getSINo ;
    NSString* nextCustCode = nil;
		
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        nextCustCode = [self getRunningCust:currentdate];
        [self create1stLA:currSINo currCustCode:firstCustCode currentdate:currentdate nextSiNo:nextSiNo nextCustCode:nextCustCode];
        [self createCltProfile:nextCustCode currCustCode:firstCustCode];
        
        nextCustCode = [self getRunningCust:currentdate];
        [self create2ndLA:currSINo nextSiNo:nextSiNo currentdate:currentdate nextCustCode:nextCustCode];
        [self createCltProfile:nextCustCode currCustCode:secondCustCode];
        
        [self createPYLA:currSINo nextSiNo:nextSiNo currentdate:currentdate nextCustCode:nextCustCode];
        [self createCltProfile:nextCustCode currCustCode:pYCustCode];
        
        [self createTradDetails:currSINo nextSiNo:nextSiNo];
        
        [self createSIStorePrem:currSINo nextSiNo:nextSiNo];
        
        sqlite3_close(contactDB);
    }
        
    NSMutableArray *ridersArr = nil;    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {  
        ridersArr = [self getRiders:currSINo];
        sqlite3_close(contactDB);
    }
        
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {     
        for (NSString * rider in ridersArr) {
            [self createRiders:rider currSINo:currSINo nextSiNo:nextSiNo];
        }
        
        sqlite3_close(contactDB);
    }
    
    return YES;
}


-(void)createTradDetails:(NSString*) currSINo nextSiNo:(NSString*)nextSiNo
{
    /*CREATE TEMPORARY TABLE tmp AS SELECT * FROM Trad_Details where SINo="SI20130920-0011";
     UPDATE tmp SET SINo = '0';
     INSERT INTO Trad_Details SELECT * FROM tmp;
     DROP TABLE tmp;
     UPDATE Trad_Details SET SINo="SI20130920-0012" WHERE SINo='0'
     */
    NSString * tableName = @"Trad_Details";
    
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\"",tableName,currSINo];
    
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = @"UPDATE tmp SET SINo ='0'";
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\", createdAt = datetime(\"now\", \"+8 hour\") WHERE SINo='0'",tableName,nextSiNo];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }
    
    //==============  end of update trad_details ==================
}


-(void)createSIStorePrem:(NSString*) currSINo nextSiNo:(NSString*)nextSiNo
{
    NSString * tableName = @"SI_Store_premium";
    
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\"",tableName,currSINo];
    
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = @"UPDATE tmp SET SINo ='0'";
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\" WHERE SINo='0'",tableName,nextSiNo];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }    
}

-(void) create1stLA:(NSString*)currSINo currCustCode:(NSString*)currCustCode currentdate:(NSString *)currentdate nextSiNo:(NSString*)nextSiNo nextCustCode:(NSString*)nextCustCode
{
    NSString * tableName = @"Trad_LAPayor";
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\" AND CustCode=\"%@\" LIMIT 1 ",tableName,currSINo,currCustCode];
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = @"UPDATE tmp SET SINo ='0'";
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\", CustCode=\"%@\" WHERE SINo='0'",
                                 tableName,nextSiNo,nextCustCode];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }//end first success statement
    
    //=======duplicate data in Clt_profile with next SINo ===========   
}

-(void) create2ndLA:(NSString *) currSINo nextSiNo:(NSString*)nextSiNo currentdate:(NSString*)currentdate nextCustCode:(NSString*)nextCustCode
{
    //duplicate data in 2ndLA trad_LAPayor with next SINo and CustCode
    
    NSString * tableName = @"Trad_LAPayor";    
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\" AND sequence='2' ",tableName,currSINo];
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = @"UPDATE tmp SET SINo ='0'";
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\", CustCode=\"%@\" WHERE SINo='0'",
                                 tableName,nextSiNo,nextCustCode];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }//end first success statement
    
    //=======duplicate data in 2ndLA Clt_profile with next SINo ===========   
}

-(void) createPYLA:(NSString *) currSINo nextSiNo:(NSString*)nextSiNo currentdate:(NSString*)currentdate nextCustCode:(NSString*)nextCustCode
{
    NSString * tableName = @"Trad_LAPayor";
   
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\" AND PtypeCode='PY' ",tableName,currSINo];
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = @"UPDATE tmp SET SINo ='0'";
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\", CustCode=\"%@\" WHERE SINo='0'",
                                 tableName,nextSiNo,nextCustCode];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }//end first success statement
    
    //=======duplicate data in Payor Clt_profile with next SINo =========== 
}


-(void) createCltProfile:(NSString*)nextCustCode currCustCode:(NSString*)currCustCode
{
    /*CREATE TEMPORARY TABLE tmp AS SELECT * FROM Clt_Profile where CustCode="CL20130920-0011";
     UPDATE tmp SET CustCode ='0' , id = ((Select max(id) from Clt_Profile)+1);
     INSERT INTO Clt_Profile SELECT * FROM tmp;
     DROP TABLE tmp;
     UPDATE Clt_Profile SET CustCode="CL20130920-0012" WHERE CustCode='0'
     
     */
    NSString * tableName = @"Clt_Profile";
    
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where CustCode=\"%@\"",tableName,currCustCode];
    
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = [NSString stringWithFormat:@"UPDATE tmp SET CustCode ='0', id = ((Select max(id) from %@)+1)",tableName];
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET CustCode=\"%@\" WHERE CustCode='0'",tableName,nextCustCode];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }
    
    //=================end duplicate clt profile==============
}

-(void) createRiders:(NSString*) curRider currSINo:(NSString *) currSINo nextSiNo:(NSString*) nextSiNo
{
    int indexNo = [self getLastRunningTradRiderIndex];
    indexNo++;
    
    NSString * tableName = @"Trad_Rider_Details";    
    NSString * createSQL = [NSString stringWithFormat:@"CREATE TEMPORARY TABLE tmp AS SELECT * FROM %@ where SINo=\"%@\" and RiderCode=\"%@\"",tableName,currSINo,curRider];
        
    bool success = [self sqlStatement:createSQL];
    
    if (success)
    {
        createSQL = [NSString stringWithFormat:@"UPDATE tmp SET SINo ='0',indexNo='%d'", indexNo];
        success = [self sqlStatement:createSQL];
        
        if (success)
        {
            createSQL = [NSString stringWithFormat:@"INSERT INTO %@ SELECT * FROM tmp",tableName];
            success = [self sqlStatement:createSQL];
            
            if(success)
            {
                createSQL = @"DROP TABLE tmp";
                [self sqlStatement:createSQL];
                
                if (success) {
                    createSQL = [NSString stringWithFormat:@"UPDATE %@ SET SINo=\"%@\" WHERE SINo='0' and RiderCode=\"%@\"",tableName,nextSiNo,curRider];
                    
                    [self sqlStatement:createSQL];
                }
            }
        }
        
    }   
}

-(int)getLastRunningTradRiderIndex
{
    int toReturn = -1;
    sqlite3_stmt *statement;        
    NSString *querySQL = @"select indexNo from trad_rider_details order by indexNo desc limit 1";
    
    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            toReturn = sqlite3_column_int(statement, 0);
        }
        
        sqlite3_finalize(statement);
    }    
    querySQL = Nil;	
	statement = Nil;
    
    return toReturn;
}


-(NSMutableArray*)getRiders:(NSString*) currSINo
{
    NSMutableArray* temp = [ [NSMutableArray alloc] init];
    sqlite3_stmt *statement;        
    NSString *sqlStmt  = [NSString stringWithFormat:@"SELECT RiderCode FROM Trad_Rider_Details Where SINo = '%@' ORDER BY RiderCode ASC ",currSINo];
            
    if (sqlite3_prepare_v2(contactDB, [sqlStmt UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            NSString * toReturn = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            [temp addObject:toReturn];
        }
        
        sqlite3_finalize(statement);
    }
    
    sqlStmt = Nil;    
	statement = Nil;
    
    return temp;
}


-(BOOL)sqlStatement:(NSString*)querySQL
{
    BOOL success = YES;
    sqlite3_stmt *statement;
    
    int status = sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) ;
	if ( status == SQLITE_OK)
	{
        int errorCode = sqlite3_step(statement);
		if (errorCode == SQLITE_DONE)
		{
			NSLog(@"success!!");
			success = YES;
			
		} else {
			NSLog(@"fails!! || error code = %d",errorCode);
			success = NO;
			
		}
		sqlite3_finalize(statement);
	}
    return  success;
	
}
#pragma mark - Switch page control
-(void)isSaveBasicPlan:(BOOL)temp
{
    isSaveBasicPlan = temp;
}

-(void)deleteSecondLAFromDB
{
    if (_SecondLAController) {
        [self.SecondLAController deleteLA];
    }
}

-(BOOL)validatePage//check for each page validation before change page
{
    // temporary work around (a plan must be selected before any other menu items can be selected).
    
    if (previousPath.row == SIMENU_BASIC_PLAN && self.BasicController.planChoose == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select a plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        alert = Nil;
        return NO;
    }
    
    switch (selectedPath.row) {
        case SIMENU_LIFEASSURED:
            NSLog(@"SIMENU_LIFEASSURED");
            if (self.LAController)
            {
                if ([self.LAController validateSave])
                {
                    if(self.BasicController)
                    {
                        // HACK
                        self.BasicController.ageClient = getAge;
                        [self.BasicController reloadPaymentOption];
                        [self.BasicController checkingSave:getSex];
                    }
                    return[self.LAController performSaveData];
                }
				else{
					[self UpdateSIToInvalid];
				}
            }
            break;
        case SIMENU_SECOND_LIFE_ASSURED:
            NSLog(@"SIMENU_SECOND_LIFE_ASSURED");
            self.SecondLAController.requestSINo = getSINo;
            if (self.SecondLAController) {
                if (isSecondLaNeeded && ![self.SecondLAController.nameField.text isEqualToString:@""]) {
                    if ( [self.SecondLAController validateSave])
                    {
                        return[self.SecondLAController performUpdateData];
                    }
					else{
						[self UpdateSIToInvalid];
					}
                }
                else{
                    
                    UITableViewCell* secondLACell =   [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
					secondLACell.detailTextLabel.text = @"";
                    return YES;
                }
				
            }
            else{
                return YES;
            }
            break;
            
        case SIMENU_PAYOR:
            NSLog(@"SIMENU_PAYOR");
            if (self.PayorController)
            {
                return [self.PayorController performSavePayor];
            }
            else{
                return YES;
            }
            break;
            
        case SIMENU_BASIC_PLAN:
            NSLog(@"SIMENU_BASIC_PLAN");
            if(self.BasicController && [self.BasicController isBasicPlanSelected])
            {
                int validate = [self.BasicController validateSave];
                if(validate == 0)
                {
                    if (isSaveBasicPlan) {
                        [self.HLController loadHL];
                        [self.RiderController clearField];
                        [self.BasicController checkingExisting];
                        return[self.BasicController checkingSave:getSex];
                    }
                    else{
                        return YES;
                    }                    
                } else if (validate == SIMENU_HEALTH_LOADING) {
                    [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SIMENU_HEALTH_LOADING inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                    
                    selectedPath = [NSIndexPath indexPathForRow:SIMENU_HEALTH_LOADING inSection:0];
                    [self loadHLPage];
                    return NO;
                    
                }
				else{
					[self UpdateSIToInvalid];
				}
            }
            else{
                return YES;
            }            
			
            break;
            
        case SIMENU_HEALTH_LOADING:
            NSLog(@"SIMENU_HEALTH_LOADING");
            if ([self.HLController validateSave]) {
				return [self.HLController updateHL];
            }
			else{
				[self UpdateSIToInvalid];
			}
            break;            
        case SIMENU_RIDER:
            NSLog(@"SIMENU_RIDER");
            return YES;
            break;
        case SIMENU_PREMIUM:
        case SIMENU_QUOTATION:
        case SIMENU_PDS_SAVE_AS:			
            return  YES;            
        default:
            break;
    }
    return NO;
}

-(void)saveAll
{    
    NSString* msg = @"Confirm changes?";	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
    [alert setTag:3001];
    [alert show];    
}

#pragma mark - delegate FSVerticalTabBarController

- (void)tabBarController:(FSVerticalTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"FSVerticalTabBarController");
    
}

#pragma mark - handle FSvertical Bar save or revert

-(BOOL)RevertSIStatus // revert SI status back to original IF there are no changes to SI
{
    if (![[self.EAPPorSI description] isEqualToString:@"eAPP"]){
        if ([SIStatus isEqualToString:@"VALID"]) {
            [self UpdateSIToValid];
        }
    }

    return TRUE;
}

-(BOOL)performSaveSI:(BOOL)saveChanges
{
    NSLog(@"perform save SI");
	
    return[self isNeedSaveChanges:saveChanges];
    
}

-(void)revertChages
{
    BOOL isNeedDeleteSecondLA = YES;	
    NSString* tempSINo = [self.requestSINo description];
    NSArray*keys=[dictStoreRevert allKeys];
    int switchNo;
    NSMutableDictionary * dictTemp;
    NSMutableDictionary * dictTempTwo;
    
    NSMutableDictionary * dict;
    NSString * riderName;
    for (int i = 0; i<[dictStoreRevert count]; i++) {
        
        switchNo = [[keys objectAtIndex:i] intValue];		
        dictTemp = [[NSMutableDictionary alloc]init];
        dictTempTwo = [[NSMutableDictionary alloc]init];
		
        switch (switchNo) {
            case 0:
            {
                dictTemp = [dictStoreRevert objectForKey:TRAD_PAYOR_FIRSTLA];//contain data for Trad_LAPayor first LA
                dictTempTwo = [dictStoreRevertTwo objectForKey:TRAD_PAYOR_FIRSTLA];//contain data for Trad_LAPayor first LA
				
                [self revertObjIntoDB:dictTemp table:@"Trad_LAPayor" where:[NSString stringWithFormat:@"SINo = '%@' AND CustCode = '%@' AND PTypeCode = 'LA' AND Sequence = '1'",tempSINo,custCodeForLA]isUpdate:NO];
                [self revertObjIntoDB:dictTempTwo table:@"Clt_Profile" where:[NSString stringWithFormat:@"CustCode = '%@'",custCodeForLA]isUpdate:YES];
            }
                break;
            case 1:
            {
                dictTemp = [dictStoreRevert objectForKey:TRAD_PAYOR_SECONDLA];
                dictTempTwo = [dictStoreRevertTwo objectForKey:TRAD_PAYOR_SECONDLA];//contain data for Trad_LAPayor first LA
				
                [self revertObjIntoDB:dictTemp table:@"Trad_LAPayor" where:[NSString stringWithFormat:@"SINo = '%@' AND CustCode = '%@' AND PTypeCode = 'LA' AND Sequence = '2'",tempSINo,custCodeForLATwo]isUpdate:NO];
                [self revertObjIntoDB:dictTempTwo table:@"Clt_Profile" where:[NSString stringWithFormat:@"CustCode = '%@'",custCodeForLATwo]isUpdate:YES];
                isNeedDeleteSecondLA = NO;
            }
                break;
            case 2:
            {
                dictTemp = [dictStoreRevert objectForKey:TRAD_PAYOR_PAYOR];
                dictTempTwo = [dictStoreRevertTwo objectForKey:TRAD_PAYOR_PAYOR];//contain data for Trad_LAPayor first LA
				
                [self revertObjIntoDB:dictTemp table:@"Trad_LAPayor" where:[NSString stringWithFormat:@"SINo = '%@' AND CustCode = '%@' AND PTypeCode = 'PY'",tempSINo,custCodeForPayor]isUpdate:NO];
                [self revertObjIntoDB:dictTempTwo table:@"Clt_Profile" where:[NSString stringWithFormat:@"CustCode = '%@'",custCodeForPayor]isUpdate:YES];
				
            }
                break;
                
            case 3:
            {
                dictTemp = [dictStoreRevert objectForKey:TRAD_DETAILS_BASICPLAN];
                [self revertObjIntoDB:dictTemp table:@"Trad_Details" where:[NSString stringWithFormat:@"SINo = '%@'",tempSINo]isUpdate:YES];
                break;
            }
            case 4:
            {                
                NSArray *tempArr = [dictStoreRevert objectForKey:TRAD_RIDER_DETAILS];
                if(arrRider && [self performActionOnDB:[NSString stringWithFormat:@"DELETE from %@ WHERE SINo = '%@'",@"Trad_Rider_Details",tempSINo]])
                {
                    for (int i = 0; i< [tempArr count]; i++) {
                        
                        dict = [tempArr objectAtIndex:i];
                        riderName = [arrRider objectAtIndex:i];
                        [self revertObjIntoDB:dict table:@"Trad_Rider_Details" where:[NSString stringWithFormat:@"SINo = '%@' AND RiderCode = '%@'",tempSINo,riderName]isUpdate:NO];
                        
                    }
                }
            }
                break;      
				
            default:
                break;
        }		
    }    
}


-(void)storeLAValues1//to store for revert
{
    dictStoreRevert = [[NSMutableDictionary alloc]initWithCapacity:6];
    dictStoreRevertTwo = [[NSMutableDictionary alloc]init];
    dictLA = [[NSMutableDictionary alloc]init];
    dictLATwo = [[NSMutableDictionary alloc]init];
    dictPayor = [[NSMutableDictionary alloc]init];
    dictLA_CltProfile = [[NSMutableDictionary alloc]init];
    dictLATwo_CltProfile = [[NSMutableDictionary alloc]init];
    dictPayor_CltProfile = [[NSMutableDictionary alloc]init];
    dictBasicPlan = [[NSMutableDictionary alloc]init];
    dictHL = [[NSMutableDictionary alloc]init];
    arrAllRider = [[NSMutableArray alloc]init];
    //=================================LAPayor first life assured ===========================
	
    NSString* sqlQuery = [NSString stringWithFormat: @"SELECT * FROM Trad_LAPayor WHERE SINo = '%@' AND PTypeCode ='LA' AND sequence = '1' ",[self.requestSINo description]];
    NSString* sqlQueryTwo;
    flagForCustomer = @"LA";
	
    if([self storeDBIntoObj:dictLA sqlStatement:sqlQuery])
    {
        [dictStoreRevert setObject:dictLA forKey:TRAD_PAYOR_FIRSTLA];
		
        sqlQueryTwo = [NSString stringWithFormat: @"SELECT * FROM Clt_Profile WHERE CustCode = '%@'",custCodeForLA];
		if([self storeDBIntoObj:dictLA_CltProfile sqlStatement:sqlQueryTwo])
		{
			[dictStoreRevertTwo setObject:dictLA_CltProfile forKey:TRAD_PAYOR_FIRSTLA];
		}
    }
    //================================= LAPayor second life assured ==========================
	
	sqlQuery = [NSString stringWithFormat: @"SELECT * FROM Trad_LAPayor WHERE SINo = '%@' AND PTypeCode ='LA' AND sequence = '2' ",[self.requestSINo description]];
    flagForCustomer = @"secondLA";
	
    if([self storeDBIntoObj:dictLATwo sqlStatement:sqlQuery])
    {
        [dictStoreRevert setObject:dictLATwo forKey:TRAD_PAYOR_SECONDLA];
        
        sqlQueryTwo = [NSString stringWithFormat: @"SELECT * FROM Clt_Profile WHERE CustCode = '%@'",custCodeForLATwo];
        if([self storeDBIntoObj:dictLATwo_CltProfile sqlStatement:sqlQueryTwo])
        {
            [dictStoreRevertTwo setObject:dictLATwo_CltProfile forKey:TRAD_PAYOR_SECONDLA];
        }
		
    }
    //=================================LAPayor payor ==========================================
	
    sqlQuery = [NSString stringWithFormat: @"SELECT * FROM Trad_LAPayor WHERE SINo = '%@' AND PTypeCode ='PY'  ",[self.requestSINo description]];
    
    flagForCustomer = @"payor";
	
    if([self storeDBIntoObj:dictPayor sqlStatement:sqlQuery])
    {
        [dictStoreRevert setObject:dictPayor forKey:TRAD_PAYOR_PAYOR];
        
        sqlQueryTwo = [NSString stringWithFormat: @"SELECT * FROM Clt_Profile WHERE CustCode = '%@'",custCodeForPayor];
        if([self storeDBIntoObj:dictPayor_CltProfile sqlStatement:sqlQueryTwo])
        {
            [dictStoreRevertTwo setObject:dictPayor_CltProfile forKey:TRAD_PAYOR_PAYOR];
        }
		
    }
    //=================================Trad Details ==========================================
    sqlQuery = [NSString stringWithFormat: @"SELECT * FROM Trad_Details WHERE SINo = '%@'",[self.requestSINo description]];
    flagForCustomer = @"trad details";
	
    if([self storeDBIntoObj:dictBasicPlan sqlStatement:sqlQuery])
    {
        [dictStoreRevert setObject:dictBasicPlan forKey:TRAD_DETAILS_BASICPLAN];
    }
	
    //=================================Trad Rider Details ==========================================
    sqlQuery = [NSString stringWithFormat: @"SELECT RiderCode FROM Trad_Rider_Details WHERE SINo = '%@'",[self.requestSINo description]];
    
    flagForCustomer = @"riders";
	
    if([self storeDBIntoObjRider:arrAllRider sqlStatement:sqlQuery])
    {
        [dictStoreRevert setObject:arrAllRider forKey:TRAD_RIDER_DETAILS];
    }
    
    // print the rider details
    NSLog(@"dictStoreRevert count == %d", [dictStoreRevert count]);
    
    NSArray * asd = [dictStoreRevert objectForKey:@"Trad_Rider_Details"];
    NSDictionary * dict;
    for (int i = 0; i< [asd count] ; i++) {
        dict = [asd objectAtIndex:i];
        for (int j = 0; j<[dict count]; j++) {
            NSLog(@"the rider for key %d is == %@",j,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]);
        }
    }
	
}

#pragma mark - copy object from diff tab
-(BOOL)storeDBIntoObj:(NSMutableDictionary*)dict sqlStatement:(NSString*)sqlQuery
{
    BOOL success = NO;
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                if ([flagForCustomer isEqualToString:@"LA"]) {
					custCodeForLA   = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					
                }
                else if([flagForCustomer isEqualToString:@"secondLA"]){
                    custCodeForLATwo   = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					
                }
                else if ([flagForCustomer isEqualToString:@"payor"]){
                    custCodeForPayor   = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					
                }
                
                int rowCount = sqlite3_column_count(statement);
                NSString* obj;
                for (int i = 0; i<rowCount; i++) {
                    if(sqlite3_column_text(statement, i) == nil)
                    {
                        obj = @"";
                        
                    }
                    else {
                        
                        obj = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)];
                    }
                    
                    [dict setObject:obj forKey:[NSString stringWithFormat:@"key%d",i]];
                }
                
                success = YES;
				
            }
            else {
                NSLog(@"error access Clt_Profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return success;
}

-(BOOL)storeDBIntoObjRider:(NSMutableArray*)arr sqlStatement:(NSString*)sqlQuery
{
    BOOL success = NO;
    sqlite3_stmt *statement;
    arrRider = [[ NSMutableArray alloc]init];//diff rider with same sino
    NSMutableDictionary* dictTemp;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                if(sqlite3_column_text(statement, 0))
                {
                    [arrRider addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
					
                }
            }
            
            sqlite3_finalize(statement);
        }
        
        if([arrRider count] == 0)
        {
            return NO;
        }
        else{
            NSString* tempSql;
            for (int i = 0; i < [arrRider count]; i++) {				
                tempSql = [NSString stringWithFormat: @"SELECT * FROM Trad_Rider_Details WHERE SINo = '%@' AND RiderCode = '%@'",[self.requestSINo description],[arrRider objectAtIndex:i]];
                dictTemp = [[NSMutableDictionary alloc]init];
                flagForCustomer = @"riders";
                if([self storeDBIntoObj:dictTemp sqlStatement:tempSql])
                {
                    [arr addObject:dictTemp];
                    NSLog(@"rider == %@",[arr objectAtIndex:i]);
                }                
            }
            success = YES;            
        }		
        
        sqlite3_close(contactDB);
    }
    
    return success;
}

-(BOOL)revertObjIntoDB:(NSMutableDictionary*)dict table:(NSString*)tableName where:(NSString*)strWhere isUpdate:(BOOL)isUPdate{
    BOOL success = NO;
    sqlite3_stmt *statement;
    NSArray * headerArray = [[NSArray alloc]init];
    NSString* strJoin =@"";
	
    headerArray = [self getTableHeader:tableName];
    NSString* insertSQL;
    NSString* str;
	if (isUPdate) {
		for (int i = 0; i< [dict count]; i++) {
			str = [dict objectForKey:[NSString stringWithFormat:@"key%d",i]];
			if([[headerArray objectAtIndex:i] isEqualToString:@"SINo"]||[[headerArray objectAtIndex:i] isEqualToString:@"CustCode"])
			{				
			}
			else if(i == [dict count]-1)
			{
				strJoin = [NSString stringWithFormat:@"%@ %@ = '%@'",strJoin,[headerArray objectAtIndex:i],str];				
			}
			else{
				strJoin = [NSString stringWithFormat:@"%@ %@ = '%@',",strJoin,[headerArray objectAtIndex:i],str];				
			}
		}
		
		insertSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,strJoin,strWhere];		
    }
    else{
        for (int i = 0; i< [dict count]; i++) {            
            str = [dict objectForKey:[NSString stringWithFormat:@"key%d",i]];
            
            if(i == [dict count]-1)
            {
                strJoin = [NSString stringWithFormat:@"%@ '%@')",strJoin,str];
                
            }
            else{
                strJoin = [NSString stringWithFormat:@"%@ '%@',",strJoin,str];
                
            }
        }		
        insertSQL = [NSString stringWithFormat:@"INSERT INTO %@ VALUES (%@ ",tableName,strJoin];
		
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){		
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {			
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = YES;
            }
            else {
                success = NO;				
            }
            sqlite3_finalize(statement);
        }
		
        sqlite3_close(contactDB);		
    }	
    return success;
	
}

-(NSMutableArray*)getTableHeader:(NSString*)tableName
{	
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    NSString *sqlQUERY = [NSString stringWithFormat:@"PRAGMA table_info(%@);",tableName];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){		
        if(sqlite3_prepare_v2(contactDB, [sqlQUERY UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
				
                [arr addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                NSLog(@"the arr object for index is %@",[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]);
				
            }
			
			sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return arr;
}
//still in use =========================================
-(BOOL)performActionOnDB:(NSString*)sqlQuery//sql update delete etc
{
    sqlite3_stmt *statement;
	
    BOOL success = NO;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                success = YES;
            }
            else {
                success = NO;
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
    }
	
    return success;
}
-(BOOL)retrieveRowFromDB:(NSString*)sqlQuery arrOfLaPayor:(NSMutableArray*)array//sql update delete etc
{
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            NSMutableDictionary * dict;
            NSString* obj;
            int i, rowCount;
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                dict = [[NSMutableDictionary alloc]init];				
                rowCount = sqlite3_column_count(statement);
                
                for (i = 0; i<rowCount; i++) {                    
                    if(sqlite3_column_text(statement, i) == nil)
                    {
                        obj = @"";                        
                    }
                    else {                        
                        obj = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)];
                    }                    
                    [dict setObject:obj forKey:[NSString stringWithFormat:@"key%d",i]];
                }
                [array addObject:dict];
            }
			sqlite3_finalize(statement);
			
            
        }
		sqlite3_close(contactDB);
		
    }
    return YES;
}
-(BOOL)retrieveRowFromDBTwo:(NSString*)sqlQuery dictionary:(NSMutableDictionary*)dict//sql update delete etc
{
    sqlite3_stmt *statement;
    
    BOOL success = NO;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){        
        if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
                int rowCount = sqlite3_column_count(statement);                
                NSString* obj;
                for (int i = 0; i<rowCount; i++) {                    
                    if(sqlite3_column_text(statement, i) == nil)
                    {
                        obj = @"";                        
                    }
                    else {                        
                        obj = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)];
                    }                    
                    [dict setObject:obj forKey:[NSString stringWithFormat:@"key%d",i]];
                }
                success = YES;
				
            }
			sqlite3_finalize(statement);
			
        }
        sqlite3_close(contactDB);
    }
    return success;
}

-(BOOL)requestCustCodeFromDB:(NSString*)sqlQuery CustCode:(NSMutableArray*)arrCustomerCodeTemp
{
    sqlite3_stmt* statement;
    BOOL success = NO;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [arrCustomerCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                success = YES;
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
    }
//    NSLog(@"customer code count  == %d",[arrCustomerCode count]);
    return success;
}

-(BOOL)requestRiderCodeFromDB:(NSString*)sqlQuery
{
    arrRiderCode = [[NSMutableArray alloc]init];
    
    sqlite3_stmt* statement;
    BOOL success = NO;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        if(sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [arrRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                success = YES;
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
    }
//    NSLog(@"rider code count  == %d",[arrRiderCode count]);
    return success;
	
}

-(void)storeLAValues//to store for revert
{
    arrTempLA = [[NSMutableArray alloc]init];
    arrTempLATwo = [[NSMutableArray alloc]init];
    dictBP = [[NSMutableDictionary alloc]init];
    arrTempRider = [[NSMutableArray alloc]init];
	
    NSString* sqlStatement;
	
    NSString * tempSINo = [self.getSINo description];
    arrCustomerCode = [[NSMutableArray alloc]init];
    sqlStatement = [NSString stringWithFormat:@"SELECT CustCode from Trad_LAPayor WHERE SINO = '%@'",tempSINo];
	
    [self requestCustCodeFromDB:sqlStatement CustCode:arrCustomerCode];
    
    sqlStatement = [NSString stringWithFormat:@"SELECT * from Trad_LAPayor WHERE SINO = '%@'",tempSINo];
	
    if([self retrieveRowFromDB:sqlStatement arrOfLaPayor:arrTempLA])
    {
    }
    
    NSString* str;
    NSMutableDictionary* dictTempLA;
    for (int i =0; i< [arrCustomerCode count]; i++) {        
        str = [arrCustomerCode objectAtIndex:i];        
        sqlStatement = [NSString stringWithFormat:@"SELECT * from Clt_Profile WHERE CustCode = '%@'",str];
        dictTempLA = [[NSMutableDictionary alloc]init];
		
        if([self retrieveRowFromDBTwo:sqlStatement dictionary:dictTempLA])
        {
            [arrTempLATwo addObject:dictTempLA];
        }		
    }
    sqlStatement = [NSString stringWithFormat:@"SELECT * from Trad_Details WHERE SINo = '%@'",tempSINo];
	
    if([self retrieveRowFromDBTwo:sqlStatement dictionary:dictBP])
    {		
    }
    
    //===================rider===================
    sqlStatement = [NSString stringWithFormat:@"SELECT RiderCode from Trad_Rider_Details WHERE SINO = '%@'",tempSINo];
	
    [self requestRiderCodeFromDB:sqlStatement];    
    for (int i =0; i< [arrRiderCode count]; i++) {        
        str = [arrRiderCode objectAtIndex:i];        
        sqlStatement = [NSString stringWithFormat:@"SELECT * from Trad_Rider_Details WHERE SINo = '%@' AND RiderCode ='%@'",tempSINo,str];
        dictTempLA = [[NSMutableDictionary alloc]init];
        
        if([self retrieveRowFromDBTwo:sqlStatement dictionary:dictTempLA])
        {
            [arrTempRider addObject:dictTempLA];
        }        
    }	
}

-(void)deleteDBData
{
    NSString* tempSINo = [self.getSINo description];
    NSString* sqlStatement = [NSString stringWithFormat:@"DELETE from Trad_LAPayor WHERE SINo = '%@'",tempSINo];
    [self performActionOnDB:sqlStatement];	
    
    if (arrCustomerCode) {        
        for(int i =0; i<[arrCustomerCode count];i++)
        {
            sqlStatement = [NSString stringWithFormat:@"DELETE from Clt_Profile WHERE CustCode = '%@'",[arrCustomerCode objectAtIndex:i]];
            [self performActionOnDB:sqlStatement];
        }
    }    
    
    sqlStatement = [NSString stringWithFormat:@"DELETE from Trad_Details WHERE SINo = '%@'",tempSINo];
    [self performActionOnDB:sqlStatement];
	
    
    sqlStatement = [NSString stringWithFormat:@"DELETE from Trad_Rider_Details WHERE SINo = '%@'",tempSINo];
    [self performActionOnDB:sqlStatement];
    
}

-(void)revertChanges
{
    NSLog(@"Revert changes .... ");
    NSString* sqlStatement;
    NSMutableDictionary* dict;
    for (int i =0; i< [arrTempLA count]; i++) {
        sqlStatement = @"INSERT INTO Trad_LAPayor VALUES (";		
        dict = [arrTempLA objectAtIndex:i];
        
        for (int j = 0; j<[dict count]; j++) {
            
            if(j == [dict count]-1)
            {
                sqlStatement = [NSString stringWithFormat:@"%@ '%@')",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
            }
            else{
                sqlStatement = [NSString stringWithFormat:@"%@ '%@',",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
				
            }
			
		}
		NSLog(@"revertChanges %@",sqlStatement);
        [self performActionOnDB:sqlStatement];
    }	
	
    for (int i =0; i< [arrTempLATwo count]; i++) {
        sqlStatement = @"INSERT INTO Clt_Profile VALUES (";        
        dict = [arrTempLATwo objectAtIndex:i];
        
        for (int j = 0; j<[dict count]; j++) {            
            if(j == [dict count]-1)
            {
                sqlStatement = [NSString stringWithFormat:@"%@ '%@')",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
            }
            else{
                sqlStatement = [NSString stringWithFormat:@"%@ '%@',",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
                
            }
            
        }
        NSLog(@"revertChanges %@",sqlStatement);
        [self performActionOnDB:sqlStatement];
    }
	
    sqlStatement = @"INSERT INTO Trad_Details VALUES (";	
    for (int i = 0; i< [dictBP count]; i++)
    {
        if(i == [dictBP count]-1)
        {
            sqlStatement = [NSString stringWithFormat:@"%@ '%@')",sqlStatement,[dictBP objectForKey:[NSString stringWithFormat:@"key%d",i]]];
        }
        else{
            sqlStatement = [NSString stringWithFormat:@"%@ '%@',",sqlStatement,[dictBP objectForKey:[NSString stringWithFormat:@"key%d",i]]];
            
        }
		
    }
    NSLog(@"revertChanges %@",sqlStatement); //poker face
    [self performActionOnDB:sqlStatement];
    
    //=====rider==================================
    for (int i =0; i< [arrTempRider count]; i++) {
        sqlStatement = @"INSERT INTO Trad_Rider_Details VALUES (";        
        dict = [arrTempRider objectAtIndex:i];
        
        for (int j = 0; j<[dict count]; j++) {
            
            if(j == [dict count]-1)
            {
                sqlStatement = [NSString stringWithFormat:@"%@ '%@')",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
            }
            else{
                sqlStatement = [NSString stringWithFormat:@"%@ '%@',",sqlStatement,[dict objectForKey:[NSString stringWithFormat:@"key%d",j]]];
                
            }
            
        }
        NSLog(@"revertChanges %@",sqlStatement);
        [self performActionOnDB:sqlStatement];
    }
}

-(BOOL)isNeedSaveChanges:(BOOL)saveChanges
{
    [self UpdateSIToInvalid];
    
    if (!saveChanges) {        
        NSLog(@"REVERT CHANGES");        
    }
    else{
        eAppCheckList*deleteOldPDF=[[eAppCheckList alloc] init];
        [deleteOldPDF deleteEAppCase:getSINo];
        deleteOldPDF = Nil;
        NSLog(@"delete eApp cases for sino %@", getSINo );        
        
        if([self validateSaveAllWithoutPrompt])
        {
            return YES;
            NSLog(@"update all successful");
        }
        else{
            return NO;
            NSLog(@"update all Fail");
			
        }
    }
    
    return YES;
}

#pragma mark - delegate source

-(void)LAIDPayor:(int)aaIdPayor andIDProfile:(int)aaIdProfile andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andOccpClass:(int)aaOccpClass andSex:(NSString *)aaSex andIndexNo:(int)aaIndexNo andCommDate:(NSString *)aaCommDate andSmoker:(NSString *)aaSmoker DiffClient:(BOOL)DiffClient bEDDCase:(BOOL)aaEDDCase
{
//    NSLog(@"::receive data LAIndex:%d, commDate:%@",aaIndexNo,aaCommDate);
    getAge = aaAge;
    getSex = aaSex;
    getSmoker = aaSmoker;
    getOccpClass = aaOccpClass;
    getOccpCode = aaOccpCode;
    getCommDate = aaCommDate;
    getIdPay = aaIdPayor;
    getIdProf = aaIdProfile;
    getLAIndexNo = aaIndexNo;
    getEDD = aaEDDCase;
    
    [self getLAName];
    [self.myTableView reloadData];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    if(DiffClient)
    {
        [self.SecondLAController deleteSecondLA];
        [self.PayorController deletePayor];
    }
}

-(void)PayorIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode
{
//    NSLog(@"::receive data PayorIndex:%d",aaIndexNo);
    getPayorIndexNo = aaIndexNo;
    getPaySmoker = aaSmoker;
    getPaySex = aaSex;
    getPayDOB = aaDOB;
    getPayAge = aaAge;
    getPayOccp = aaOccpCode;
    
    [self getPayorName];
    [self.myTableView reloadData];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void)payorSaved:(BOOL)aaTrue
{
    payorSaved = aaTrue;
}

-(void)PayorDeleted
{
//    NSLog(@"::receive data Payor deleted!");
    [self clearDataPayor];
    [self getPayorName];
    [self.myTableView reloadData];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    [self loadPayorPage];
}

-(void)LA2ndIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode
{
//    NSLog(@"::receive data 2ndLAIndex:%d",aaIndexNo);
    get2ndLAIndexNo = aaIndexNo;
    get2ndLASmoker = aaSmoker;
    get2ndLASex = aaSex;
    get2ndLADOB = aaDOB;
    get2ndLAAge = aaAge;
    get2ndLAOccp = aaOccpCode;
    
    [self get2ndLAName];
    [self.myTableView reloadData];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
}

-(void)saved:(BOOL)aaTrue
{
    saved = aaTrue;
}

-(void)secondLADelete
{
    
//    NSLog(@"::receive data 2ndLA deleted!");
    [self clearData2ndLA];
    [self get2ndLAName];
    [self.myTableView reloadData];
	
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    isSecondLaNeeded = NO;
}

-(void) getMHIMsgType
{
    MHI_MSG_TYPE = nil;
    
    if([getBasicPlan isEqualToString:@"L100"] || [getBasicPlan isEqualToString:@"S100"])
    {
        MHI_MSG_TYPE = SUM_MSG_L100;
    }else
    if([getBasicPlan isEqualToString:@"HLACP"] || [getBasicPlan isEqualToString:@"HLAWP"])
    {
        MHI_MSG_TYPE = SUM_MSG_HLACP;
    }
}

-(void)BasicSI:(NSString *)aaSINo andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andCovered:(int)aaCovered andBasicSA:(NSString *)aaBasicSA andBasicHL:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL andMOP:(int)aaMOP andPlanCode:(NSString *)aaPlanCode andAdvance:(int)aaAdvance andBasicPlan:(NSString *)aabasicPlan planName:(NSString *)planName
{
    //haha edwin
//    NSLog(@"::receive databasicSINo:%@, advance:%d, pentaCode:%@",aaSINo,aaAdvance,aaPlanCode);
    getSINo = aaSINo;
    getMOP = aaMOP;
    getTerm = aaCovered;
    getbasicSA = aaBasicSA;
    getbasicHL = aaBasicHL;
    getbasicTempHL = aaBasicTempHL;
    getPlanCode = aaPlanCode;
    getBasicPlan = aabasicPlan;
    getAdvance = aaAdvance;
    getPlanName = planName;
    
    [self getMHIMsgType];
        
    if (getbasicSA.length != 0)
    {
        PlanEmpty = NO;
    }
    
    [self checkingPayor];
    [self checking2ndLA];
    
    [self toogleView];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void)clearSecondLA
{
    [self.SecondLAController deleteSecondLA];
}

-(void)setNewPlan:(NSString*)planChoose
{
    //riderController
    self.RiderController.getPlanChoose = planChoose;
}

-(void)RiderAdded
{
//    NSLog(@"::receive data rider added!");
    [self toogleView];
    if (blocked) {
        [self.myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else {
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void)BasicSARevised:(NSString *)aabasicSA
{
//    NSLog(@"::receive databasicSA revised:%@",aabasicSA);
    getbasicSA = aabasicSA;
    //do something here
    
    AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
	if(delegate.bpMsgPrompt)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:delegate.bpMsgPrompt delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];		        
        [alert show];
        delegate.bpMsgPrompt = nil;
        
    }
}

-(void)SwitchToRiderTab{
        [self.myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:SIMENU_RIDER inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    if (!_RiderController) {        
        self.RiderController = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderView"];
        _RiderController.delegate = self;
        self.RiderController.requestAge = getAge;
        self.RiderController.requestSex = getSex;
        self.RiderController.requestOccpCode = getOccpCode;
        self.RiderController.requestOccpClass = getOccpClass;
        
        self.RiderController.requestSINo = getSINo;
        self.RiderController.requestPlanCode = getPlanCode;
        self.RiderController.requestPlanChoose = getBasicPlan;
        self.RiderController.requestCoverTerm = getTerm;
        self.RiderController.requestBasicSA = getbasicSA;
        self.RiderController.requestBasicHL = getbasicHL;
        self.RiderController.requestBasicTempHL = getbasicTempHL;
        self.RiderController.requestMOP = getMOP;
        self.RiderController.requestAdvance = getAdvance;
        self.RiderController.requesteEDD = getEDD;
        
        self.RiderController.EAPPorSI = [self.EAPPorSI description];
        
        [self addChildViewController:self.RiderController];
        [self.RightView addSubview:self.RiderController.view];        
        
    }
    else{
        self.RiderController.requestAge = getAge;
        self.RiderController.requestSex = getSex;
        self.RiderController.requestOccpCode = getOccpCode;
        self.RiderController.requestOccpClass = getOccpClass;
        
        self.RiderController.requestSINo = getSINo;
        self.RiderController.requestPlanCode = getPlanCode;
        self.RiderController.requestPlanChoose = getBasicPlan;
        self.RiderController.requestCoverTerm = getTerm;
        self.RiderController.requestBasicSA = getbasicSA;
        self.RiderController.requestBasicHL = getbasicHL;
        self.RiderController.requestBasicTempHL = getbasicTempHL;
        self.RiderController.requestMOP = getMOP;
        self.RiderController.requestAdvance = getAdvance;
        self.RiderController.requesteEDD = getEDD;
        
        self.RiderController.EAPPorSI = [self.EAPPorSI description];
        [self.RiderController loadRiderData];
        [self.RightView bringSubviewToFront:self.RiderController.view];
        
    }

    selectedPath = [NSIndexPath indexPathForRow:SIMENU_RIDER inSection:0];
    previousPath = selectedPath;
    [myTableView reloadData];
}

-(void)HLInsert:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL
{
    getbasicHL = aaBasicHL;
    getbasicTempHL = aaBasicTempHL;
}


-(NSString*)getRiderCode:(NSString *)rider
{
    NSString *riderName;
    
    if([[rider substringWithRange:NSMakeRange(0,3)] isEqualToString:@"WOP"]){
        riderName = [[rider componentsSeparatedByString:@") ("] objectAtIndex:0];
        riderName = [riderName stringByAppendingString:@")"];
    }
    else{
        riderName = [[rider componentsSeparatedByString:@" ("] objectAtIndex:0];
    }
    
    return [riderCode objectForKey:riderName];
}

#pragma mark - memory

- (void)viewDidUnload
{
    appDel = nil;
    [self resignFirstResponder];
    [self setMyTableView:nil];
    [self setRightView:nil];
    [self setGetSINo:nil];
    [self setGetOccpCode:nil];
    [self setPayorCustCode:nil];
    [self setPayorSINo:nil];
    [self setCustCode2:nil];
    [self setGetbasicSA:nil];
    [self setMenuBH:nil];
    [self setMenuPH:nil];
    [self setGetOccpCode:nil];
    [self setGetCommDate:nil];
    [self setGetPaySmoker:nil];
    [self setGetPaySex:nil];
    [self setGetPayDOB:nil];
    [self setGetPayOccp:nil];
    [self setGet2ndLASmoker:nil];
    [self setGet2ndLASex:nil];
    [self setGet2ndLADOB:nil];
    [self setGet2ndLAOccp:nil];
    [self setGetSINo:nil];
    [self setGetbasicSA:nil];
    [self setGetbasicHL:nil];
    [self setGetPlanCode:nil];
    [self setGetBasicPlan:nil];
    [super viewDidUnload];
}

-(void)clearDataLA
{
    _LAController = nil;
    getAge = 0;
    getSex = nil;
    getSmoker = nil;
    getOccpClass = 0;
    getOccpCode = nil;
    getCommDate = nil;
    getIdPay = 0;
    getIdProf = 0;
    getLAIndexNo = 0;
    NameLA = nil;
}

-(void)clearDataPayor
{
    _PayorController = nil;
    [self.PayorController resetField];
    getPayorIndexNo = 0;
    getPaySmoker = nil;
    getPaySex = nil;
    getPayDOB = nil;
    getPayAge = 0;
    getPayOccp = nil;
    NamePayor = nil;
    payorSINo = nil;
}

-(void)clearData2ndLA
{
    _SecondLAController = nil;
    [self.SecondLAController resetField];
	
    get2ndLAIndexNo = 0;
    get2ndLASmoker = nil;
    get2ndLASex = nil;
    get2ndLADOB = nil;
    get2ndLAAge = 0;
    get2ndLAOccp = nil;
    Name2ndLA = nil;
    CustCode2 = nil;
}

-(void)clearDataBasic
{
    _BasicController = nil;
    getSINo = nil;
    getMOP = 0;
    getTerm = 0;
    getbasicSA = nil;
    getbasicHL = nil;
    getbasicTempHL = nil;
    getPlanCode = nil;
    getBasicPlan = nil;
    getPlanName = nil;
    getAdvance = 0;
}

-(void)RemovePDS{
	ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Life Assured", @"   2nd Life Assured", @"   Payor", @"Basic Plan", nil];
}

-(void)setNewBasicSA :(NSString*)aaSA {
    _BasicController.yearlyIncomeField.text = aaSA;
}

@end
