//
//  RiderViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderViewController.h"
#import "BasicPlanViewController.h"
#import "NewLAViewController.h"
#import "ColorHexCode.h"
#import "AppDelegate.h"
#import "MainScreen.h"
#import "PremiumViewController.h"
#import "eAppCheckList.h"
#import "MasterMenuEApp.h"

@interface RiderViewController ()

@end
BOOL Edit = FALSE;
int RiderPopoverCount;

@implementation RiderViewController
@synthesize titleRidCode;
@synthesize titleSA;
@synthesize titleTerm;
@synthesize titleUnit;
@synthesize titleClass;
@synthesize titleLoad;
@synthesize titleHL1K;
@synthesize titleHL100;
@synthesize titleHLP;
@synthesize editBtn;
@synthesize deleteBtn;
@synthesize titleHLPTerm;
@synthesize myTableView;
@synthesize termLabel;
@synthesize sumLabel;
@synthesize planLabel;
@synthesize cpaLabel;
@synthesize cpaField;
@synthesize unitField;
@synthesize occpField;
@synthesize HLField;
@synthesize HLTField;
@synthesize unitLabel;
@synthesize occpLabel;
@synthesize HLLabel;
@synthesize HLTLabel;
@synthesize termField;
@synthesize sumField;
@synthesize planBtn;
@synthesize deducBtn;
@synthesize minDisplayLabel;
@synthesize maxDisplayLabel;
@synthesize btnPType,LTempRidHL1K,LTempRidHLTerm,LTypeTempRidHL1K,LTypeTempRidHLTerm;
@synthesize btnAddRider,tempHLField,tempHLTField,tempHLLabel,tempHLTLabel,myScrollView;
@synthesize requestPlanCode,requestSINo,requestAge,requestCoverTerm,requestBasicSA;
@synthesize pTypeCode,PTypeSeq,pTypeDesc,riderCode,riderDesc;
@synthesize FLabelCode,FLabelDesc,FRidName,FInputCode,FFieldName,FTbName,FCondition;
@synthesize expAge,minSATerm,maxSATerm,minTerm,maxTerm,maxRiderTerm,deductible,maxRiderSA;
@synthesize inputHL1KSA,inputHL1KSATerm,inputHL100SA,inputHL100SATerm,inputHLPercentage,inputHLPercentageTerm;
@synthesize LRiderCode,LSumAssured,LTerm,LUnits,atcRidCode,atcPlanChoice,existRidCode,GYI,requestMOP;
@synthesize occLoad,occClass,occCPA,riderBH,storedMaxTerm,basicRate,LSDRate;
@synthesize annualRiderPrem,halfRiderPrem,quarterRiderPrem,monthRiderPrem,LPlanOpt,pentaSQL,plnOptC,planOptHMM,LDeduct,deducHMM,LAge;
@synthesize planHSPII,planMGII,planMGIV,LSmoker,planCodeRider,LRidHL100,LRidHL1K,LRidHLP,riderRate;
@synthesize annualRiderSum,halfRiderSum,quarterRiderSum,monthRiderSum,medPlanCodeRider;
@synthesize annualMedRiderPrem,halfMedRiderPrem,quarterMedRiderPrem,monthMedRiderPrem,annualMedRiderSum,halfMedRiderSum,quarterMedRiderSum,monthMedRiderSum;
@synthesize riderPrem,medRiderPrem,medPentaSQL,OccpCat,CombNo,RBBenefit,RBLimit,RBGroup,medRiderCode;
@synthesize arrCombNo,AllCombNo,medPlanOpt,arrRBBenefit,pTypeOccp;
@synthesize dataInsert,LSex,sex,age,_maxRiderSA;
@synthesize waiverRiderAnn,waiverRiderAnn2,waiverRiderHalf,waiverRiderHalf2,waiverRiderMonth,waiverRiderMonth2,waiverRiderQuar,waiverRiderQuar2;
@synthesize basicPremAnn,basicPremHalf,basicPremMonth,basicPremQuar,incomeRiderGYI,incomeRiderSA,basicGYIRate,incomeRiderCSV;
@synthesize incomeRiderAnn,incomeRiderHalf,incomeRiderMonth,incomeRiderQuar,incomeRiderPrem,basicCSVRate,riderCSVRate,pTypeAge;
@synthesize inputSA,inputCSV,inputGYI,inputIncomeAnn,secondLARidCode,occCPA_PA;
@synthesize RiderList = _RiderList;
@synthesize RiderListPopover = _RiderListPopover;
@synthesize planPopover = _planPopover;
@synthesize deducPopover = _deducPopover;
@synthesize planList = _planList;
@synthesize deductList = _deductList;
@synthesize planCondition,deducCondition,incomeRiderCode,incomeRiderTerm, LRidHLTerm, LRidHLPTerm, LRidHL100Term,LOccpCode;
@synthesize occLoadRider,LTypeAge,LTypeDeduct,LTypeOccpCode,LTypePlanOpt,LTypeRiderCode,LTypeRidHL100,LTypeRidHL100Term,LTypeRidHL1K,LTypeRidHLP,LTypeRidHLPTerm,LTypeRidHLTerm,LTypeSex,LTypeSmoker,LTypeSumAssured,LTypeTerm,LTypeUnits;
@synthesize occLoadType,classField,payorRidCode,getSINo,getPlanCode,getAge,getTerm,getBasicSA,getMOP,requestAdvance,getAdvance;
@synthesize requestOccpClass,getOccpClass,requestPlanChoose,getPlanChoose,headerTitle, EAPPorSI, outletDone, outletSaveRider;
@synthesize delegate = _delegate;
@synthesize requestSex,getSex,requestOccpCode,getOccpCode,requestBasicHL,getBasicHL,requestBasicTempHL,getBasicTempHL,occPA,requesteProposalStatus, requesteEDD;
@synthesize outletEAPP, outletSpace;
@synthesize PTypeList = _PTypeList;
@synthesize pTypePopOver = _pTypePopOver;

#pragma mark - Cycle View

int maxGycc = 0;
- (void)viewDidLoad
{
    
    ridNotAffected = [NSArray arrayWithObjects: @"ACIR_MPP", @"CIR", @"ICR", @"LCPR", @"LCWP", @"PLCP", @"PTR", @"PR", @"SP_PRE",@"SP_STD" , nil];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
	
	appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
	
    //--------- edited by heng
	appDelegate.MhiMessage = @"";
    //-----------
    
	if ([requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"] || [requesteProposalStatus isEqualToString:@"Failed"]
        || [requesteProposalStatus isEqualToString:@"Created_View"]) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
	
    HLLabel.text = @"Health Loading (Per\n1k SA):";
    HLTLabel.text = @"Health Loading (Per\n1k SA) Term:";
    tempHLLabel.text = @"Temporary Health\nLoading (Per 1k SA):";
    tempHLTLabel.text = @"Temporary Health Loading\n(Per 1k SA)Term:";

    getSINo = [self.requestSINo description];
    getPlanCode = [self.requestPlanCode description];
    getPlanChoose = [self.requestPlanChoose description];
    getAge = self.requestAge;
    getSex = [self.requestSex description];
    
    if([getPlanChoose isEqualToString:@"HLAWP"])
    {
        getTerm = [self getWPTerm];
    }else
    {
        getTerm = self.requestCoverTerm;
    }
        
    getBasicSA = [[self.requestBasicSA description] doubleValue];
    getBasicHL = [[self.requestBasicHL description] doubleValue];
    getBasicTempHL = [[self.requestBasicTempHL description] doubleValue];
    getMOP = self.requestMOP;
    getAdvance = self.requestAdvance;
    getOccpClass = self.requestOccpClass;
    getOccpCode = [self.requestOccpCode description];
    NSLog(@"Rider-Sum:%.2f,Age:%d,covered:%d,SINo:%@, planCode:%@, planChoose:%@, MOP:%d, advance:%d, occpClass:%d", getBasicSA, getAge, getTerm, getSINo, getPlanCode, getPlanChoose, getMOP, getAdvance, getOccpClass);
    
    deducBtn.hidden = YES;
    planBtn.hidden = YES;
    deleteBtn.hidden = TRUE;
    deleteBtn.enabled = FALSE;
    incomeRider = NO;
    PtypeChange = NO;

    if (requestSINo) {
		[self setupPersonType];
    }
    _PTypeList = nil;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];

    CGRect frame=CGRectMake(53,454, 80, 50);
    [titleRidCode setFont:[UIFont systemFontOfSize:12]];
    titleRidCode.text = @"Rider";
    titleRidCode.frame = frame;
//    titleRidCode.textAlignment = UITextAlignmentCenter;
    titleRidCode.textAlignment = NSTextAlignmentCenter;
    titleRidCode.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleRidCode.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleRidCode.numberOfLines = 2;
    
    CGRect frame2=CGRectMake(133,454, 105, 50);
    [titleSA setFont:[UIFont systemFontOfSize:12]];
    titleSA.frame = frame2;
//    titleSA.textAlignment = UITextAlignmentCenter;
    titleSA.textAlignment = NSTextAlignmentCenter;
    titleSA.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleSA.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame3=CGRectMake(238,454, 52, 50);
    [titleTerm setFont:[UIFont systemFontOfSize:12]];
    titleTerm.frame = frame3;
//    titleTerm.textAlignment = UITextAlignmentCenter;
    titleTerm.textAlignment = NSTextAlignmentCenter;
    titleTerm.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleTerm.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame4=CGRectMake(frame3.origin.x + frame3.size.width,454, 45, 50);
    [titleUnit setFont:[UIFont systemFontOfSize:12]];
    titleUnit.frame = frame4;
//    titleUnit.textAlignment = UITextAlignmentCenter;
    titleUnit.textAlignment = NSTextAlignmentCenter;
    titleUnit.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleUnit.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame5=CGRectMake(frame4.origin.x + frame4.size.width,454, 45, 50);
    [titleClass setFont:[UIFont systemFontOfSize:12]];
    titleClass.text = @"Occ \nClass";
    titleClass.frame = frame5;
//    titleClass.textAlignment = UITextAlignmentCenter;
    titleClass.textAlignment = NSTextAlignmentCenter;
    titleClass.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleClass.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleClass.numberOfLines = 2;
    
    CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width,454, 45, 50);
    [titleLoad setFont:[UIFont systemFontOfSize:12]];
    titleLoad.text = @"Occ\nLoading";
    titleLoad.frame = frame6;
//    titleLoad.textAlignment = UITextAlignmentCenter;
    titleLoad.textAlignment = NSTextAlignmentCenter;
    titleLoad.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleLoad.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleLoad.numberOfLines = 2;
    
    CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,454, 78, 50);
    [titleHL1K setFont:[UIFont systemFontOfSize:12]];
    titleHL1K.numberOfLines = 2;
    titleHL1K.text = @"Health Load.\n(SA/%)";
    titleHL1K.frame = frame7;
//    titleHL1K.textAlignment = UITextAlignmentCenter;
    titleHL1K.textAlignment = NSTextAlignmentCenter;
    titleHL1K.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleHL1K.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,454, 78, 50);
    [titleHL100 setFont:[UIFont systemFontOfSize:12]];
    titleHL100.text = @"Health Load.\nTerm";
    titleHL100.frame = frame8;
//    titleHL100.textAlignment = UITextAlignmentCenter;
    titleHL100.textAlignment = NSTextAlignmentCenter;
    titleHL100.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleHL100.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleHL100.numberOfLines = 2;
    
    CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width,454, 78, 50);
    [titleHLP setFont:[UIFont systemFontOfSize:12]];
    titleHLP.text = @"Temp Health\nLoad. (SA/%)";
    titleHLP.frame = frame9;
//    titleHLP.textAlignment = UITextAlignmentCenter;
    titleHLP.textAlignment = NSTextAlignmentCenter;
    titleHLP.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleHLP.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleHLP.numberOfLines = 2;
    
    CGRect frame10=CGRectMake(frame9.origin.x + frame9.size.width,454, 78, 50);
    [titleHLPTerm setFont:[UIFont systemFontOfSize:12]];
    titleHLPTerm.text = @"Temp Health\nLoad. Term";
    titleHLPTerm.frame = frame10;
//    titleHLPTerm.textAlignment = UITextAlignmentCenter;
    titleHLPTerm.textAlignment = NSTextAlignmentCenter;
    titleHLPTerm.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    titleHLPTerm.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    titleHLPTerm.numberOfLines = 2;
    
    //[self getBasicPentaRate];
    [self getBasicSIRate:getAge toAge:getAge];
    [self getOccLoad];
    [self getCPAClassType];
    [self getOccpCatCode];
    [self getLSDRate];
//    NSLog(@"RVC basicRate:%f, lsdRate:%f, occpLoad:%d, cpa:%d, pa:%d",basicRate,LSDRate,occLoad,occCPA,occPA);
    
    [self getListingRiderByType];
    [self getListingRider];
    [self calculateBasicPremium];
    
    [self calculateRiderPrem];
    [self calculateWaiver];
    [self calculateMedRiderPrem];
    
    myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.opaque = NO;
    myTableView.backgroundView = nil;
    [self.view addSubview:myTableView];
    
    [editBtn setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editBtn.titleLabel.shadowColor = [UIColor lightGrayColor];
    editBtn.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [deleteBtn setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.shadowColor = [UIColor lightGrayColor];
    deleteBtn.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
    
	
	outletEAPP.width = 0.01;
    outletSpace.width = 666;
	
	if (Editable == NO) {
		[self DisableTextField:termField];
		[self DisableTextField:sumField];
		[self DisableTextField:cpaField];
		[self DisableTextField:unitField];
		[self DisableTextField:occpField];
		[self DisableTextField:HLField];
		[self DisableTextField:HLTField];
		[self DisableTextField:tempHLField];
		[self DisableTextField:tempHLTField];
        [self DisableTextField:classField];
		
		btnAddRider.enabled = FALSE;
		planBtn.enabled = FALSE;
		deducBtn.enabled = FALSE;
		classField.enabled = FALSE;
		editBtn.enabled = FALSE;
		deleteBtn.enabled = FALSE;
		btnAddRider.hidden = TRUE;
		outletSaveRider.enabled = FALSE;
        
		if([EAPPorSI isEqualToString:@"eAPP"]){
            outletSaveRider.backgroundColor = [UIColor lightGrayColor];
            [outletSaveRider setBackgroundColor:[UIColor lightGrayColor]];
			outletEAPP.width = 0;
			outletSpace.width = 564;
			outletDone.enabled = FALSE;
            
            self.planBtn.alpha = 0.5;
            self.deducBtn.alpha = 0.5;
            
		}
        
	}
    
    if([EAPPorSI isEqualToString:@"eAPP"]){
        [self disableFieldsForEapp];
    }
    
	
    [super viewDidLoad];
	
}

+(bool)containsWealthGYIRiders:(NSString*)rider
{
    //EDUWR, WB30R, WB50R, WBD10R30, WBI6R30
    if([rider isEqualToString:@"WB30R"] || [rider isEqualToString:@"WB50R"] || [rider isEqualToString:@"WBD10R30"] 
       || [rider isEqualToString:@"WBI6R30"] || [rider isEqualToString:@"EDUWR"])
    {
        return true;
    }else
    {
        return false;
    }
}

+(bool)containtsWealthRiders:(NSString*)rider
{
    //@"'EDUWR','WB30R','WB50R','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R'";
    if([rider isEqualToString:@"EDUWR"] || [rider isEqualToString:@"WB30R"] || [rider isEqualToString:@"WBI6R30"] 
       || [rider isEqualToString:@"WBD10R30"] || [rider isEqualToString:@"WP30R"] || [rider isEqualToString:@"WP30R"] ||
       [rider isEqualToString:@"WP50R"] || [rider isEqualToString:@"WPTPD30R"] || [rider isEqualToString:@"WPTPD50R"] )
    {
        return true;
    }else
    {
        return false;
    }
}

-(int) getWPTerm
{
    int toReturn = -1;
    
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat:@"Select policyTerm from trad_details where sino = \"%@\" ", getSINo];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        //        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                toReturn =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access trad_details");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return toReturn;
}

-(void) disableFieldsForEapp
{
    planBtn.enabled = FALSE;
    planBtn.backgroundColor = [UIColor lightGrayColor];
    
//    [planBtn setBackgroundColor:[UIColor redColor]];
    
    btnAddRider.enabled = NO;
    btnAddRider.backgroundColor = [UIColor lightGrayColor];
}

-(void)setupPersonType{
    self.PTypeList = [[RiderPTypeTbViewController alloc]initWithString:getSINo str:@"TRAD"];
    _PTypeList.delegate = self;
    pTypeCode = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedCode];
    PTypeSeq = [self.PTypeList.selectedSeqNo intValue];
    pTypeDesc = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedDesc];
    pTypeAge = [self.PTypeList.selectedAge intValue];
    pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
    [self.btnPType setTitle:pTypeDesc forState:UIControlStateNormal];   
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

-(void)DisableTextField :(UITextField *)aaTextField{
	aaTextField.backgroundColor = [UIColor lightGrayColor];
	aaTextField.textColor = [UIColor grayColor];
	aaTextField.enabled = FALSE;
}

-(void)loadRiderData
{
    //changed to clear rider instead, there aren't any needs to load rider: @Edwin 21-02-2014
    [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
    riderCode = @"";
    [self setupPersonType];
    [self.myTableView reloadData];
    [self getListingRiderByType];
    [self getCPAClassType ];
    getMOP = self.requestMOP;
    getAdvance = self.requestAdvance;
    getOccpClass = self.requestOccpClass;
    getOccpCode = [self.requestOccpCode description];
    getBasicSA = [self.requestBasicSA doubleValue];
    getAge = self.requestAge;
    age = getAge;
    getSex = [self.requestSex description];
    
    [self getOccpCatCode];
    
    if([getPlanChoose isEqualToString:@"HLAWP"])
    {
        getTerm = [self getWPTerm];
    }else
    {
        getTerm = self.requestCoverTerm;
    }
    
    _PTypeList = nil;
    _RiderList = Nil;
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
     self.headerTitle.frame = CGRectMake(320, -20, 128, 44);
     self.myToolBar.frame = CGRectMake(0, 0, 768, 44);
     self.view.frame = CGRectMake(0, 20, 768, 1004); */
    
    self.view.frame = CGRectMake(0, 0, 788, 1004);
    [super viewWillAppear:animated];
    getPlanChoose = [self.requestPlanChoose description];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - keyboard display

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
	Edit = TRUE;
    self.myScrollView.frame = CGRectMake(0, 44, 768, 453-100);
    self.myScrollView.contentSize = CGSizeMake(768, 413);
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    minDisplayLabel.text = @"";
    maxDisplayLabel.text = @"";
    
    self.myScrollView.frame = CGRectMake(0, 44, 768, 453);
}

-(void)textFieldDidChange:(UITextField*)textField
{
    if(btnAddRider.titleLabel.text.length != 0)
    {
        appDelegate.isNeedPromptSaveMsg = YES;
		
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self calculateSA];
    switch (textField.tag) {
        case 0:
            minDisplayLabel.text = @"";
            maxDisplayLabel.text = @"";
            break;
        case 1:
            if([riderCode isEqualToString:@"PTR"] || [riderCode isEqualToString:@"PLCP"] ){
				minDisplayLabel.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
                
				int TermToDisplay = 60 - age;
                if(TermToDisplay > 25){
                    TermToDisplay = 25;
                }
                
                maxRiderTerm = TermToDisplay;
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max Term: %.d",TermToDisplay];
				
            }
            else{
                minDisplayLabel.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max Term: %.f",maxRiderTerm];
            }
            
            break;
        case 2:
            /*
            if (incomeRider) {
                
                NSString *strMaxRiderSA = [NSString stringWithFormat:@"%.2f", maxRiderSA];
                NSRange rangeofDot = [ strMaxRiderSA rangeOfString:@"."];
                NSString *ValueToDisplay = @"";
                
                if (rangeofDot.location != NSNotFound) {
                    NSString *substring = [strMaxRiderSA substringFromIndex:rangeofDot.location ];
                    NSString *substring2 = [substring substringFromIndex:[substring length]-1];
                    
                    if (substring.length == 3 && [substring isEqualToString:@".00"]) {
                        ValueToDisplay = [strMaxRiderSA substringToIndex:rangeofDot.location ];
                    }
                    else if (substring.length == 3 && [substring2 isEqualToString:@"0"]) {
                        ValueToDisplay = [strMaxRiderSA substringToIndex:[strMaxRiderSA length]-1];
                    }
                    else {
                        ValueToDisplay = strMaxRiderSA;
                    }
                }
                else {
                    ValueToDisplay = strMaxRiderSA;
                }
                minDisplayLabel.text = [NSString stringWithFormat:@"Min GYI: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max GYI: %@",ValueToDisplay];
                
            }
            */
            if ([riderCode isEqualToString:@"ICR"] && [getPlanChoose isEqualToString:@"HLACP"])
            {
                if( getBasicSA < 5000 )
                {
                    minDisplayLabel.text = @"Please increase BSA to at least RM5,000";
                    maxDisplayLabel.text = @"";
                }
            }
			else if([riderCode isEqualToString:@"EDB"]){
				minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting"];
				
			}
            else if ([riderCode isEqualToString:@"TPDYLA"] && ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])) {
                /*
                if( [getPlanChoose isEqualToString:@"HLACP"] && getBasicSA < 2500 )
                {
                    minDisplayLabel.text = @"Min RSA for TPDYLA is RM 5,000. Please increase";
                    maxDisplayLabel.text = @"the Desired Yearly Income to a minimum of RM 2,500.";
                }else
                      if( [getPlanChoose isEqualToString:@"L100"] && getBasicSA < 50000 )
                      {
                      minDisplayLabel.text = @"Min RSA for TPDYLA is RM 5,000. Please increase";
                      maxDisplayLabel.text = @"the Desired Yearly Income to a minimum of RM 50,000.";
                      }
                      else*/
                if( maxRiderSA >= 5000 )
                {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                }
                else{
                    minDisplayLabel.text = @"Please increase BSA to at least RM5,000";
                    maxDisplayLabel.text = @"";
                }
            }
            else if ([riderCode isEqualToString:@"TPDYLA"] && [getPlanChoose isEqualToString:@"HLAWP"]) {

                if( maxRiderSA >= 5000 )
                {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                }
                else{
                    int tempToIncrease = ceil( 5000/(0.25 * getMOP * [self getBasicSAFactor]));
                    
                    minDisplayLabel.text = [NSString stringWithFormat:@"Please increase Desired Annual Premium"];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"to at least RM%d", tempToIncrease];
                }
            }
            else if([riderCode isEqualToString:@"EDUWR"])
            {
                if (requesteEDD == TRUE && maxRiderSA <= minSATerm) {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings"];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider."];
                    maxDisplayLabel.numberOfLines = 2;
                }
                else{
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min GCP: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max GCP: %.f",maxRiderSA];
                }
                
            }
            else if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WBI6R30"] )
            {
                if (requesteEDD == TRUE && maxRiderSA <= minSATerm) {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings"];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider."];
                    maxDisplayLabel.numberOfLines = 2;
                }
                else{
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min GYCC: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max GYCC: %.f",maxRiderSA];
                }
                
            }
            else if( [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"]  )
            {
                minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting "];
            }
            else if(  [riderCode isEqualToString:@"WPTPD30R"] || [riderCode isEqualToString:@"WPTPD50R"] )
            {
                minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                if (maxRiderSA > 0 && maxRiderSA >= minSATerm ) {
                    maxDisplayLabel.numberOfLines = 2;
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f(Subject to TPD Benefit Limit\nper Life of RM3.5mil)",maxRiderSA];
                }
                else{
                    int tempSA = 0;
                    if ([LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound) {
                        tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD50R"]] integerValue];
                    }
                    
                    if ([LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound) {
                        tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD30R"]] integerValue];
                    }
                    
                    if (tempSA >= 1000000) {
                        minDisplayLabel.text = @"Maximum Total RSA for Wealth TPD Protector Rider";
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"(30 and 50 years) is capped at RM 1mil per product limit.\nPlease revise the RSA of these rider(s)"];
                    }
                    else{
                        minDisplayLabel.text = @"";
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"TPD Limit per Life is capped at RM3.5mil.\nPlease revise the RSA of TPD related Rider(s)."];
                    }
                    
                }
                
            }
            else {
                if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
                {
                    if ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"CIR"] || [riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"LCPR"] || [riderCode isEqualToString:@"PLCP"] )
                    {
                        if (maxRiderSA > 0 && maxRiderSA >= minSATerm ) {
                            NSString *subject = @"(Subject to CI Ben. Limit per\nLife across industry of RM4mil)";
                            minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                            maxDisplayLabel.numberOfLines = 2;
                            maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f %@",maxRiderSA,subject];
                        }
                        else
                        {
                            minSATerm = 0;
                            minDisplayLabel.text = @"";
                            maxDisplayLabel.numberOfLines = 2;
                            maxDisplayLabel.text = [NSString stringWithFormat:@"CI Ben. Limit per Life across industry is capped at RM4mil.\nPlease revise the RSA of CI related rider(s)."];
                            maxRiderSA = -1;
                        }
                        
                    }else
                    {
                        minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                        maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                    }
                }
                else if([getPlanChoose isEqualToString:@"HLAWP"])
                {
                    if ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"CIR"]|| [riderCode isEqualToString:@"ICR"]|| [riderCode isEqualToString:@"LCPR"] ||[riderCode isEqualToString:@"PLCP"])
                    {
                        
                        if (maxRiderSA > 0) {
                            NSString *subject = @"(Subject to CI Ben. Limit per\nLife across industry of RM4mil)";
                            minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                            maxDisplayLabel.numberOfLines = 2;
                            maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f %@",maxRiderSA,subject];
                        }
                        else{
                            minSATerm = 0;
                            minDisplayLabel.text = @"";
                            maxDisplayLabel.numberOfLines = 2;
                            maxDisplayLabel.text = [NSString stringWithFormat:@"CI Ben. Limit per Life across industry is capped at RM4mil.\nPlease revise the RSA of CI related rider(s)."];
                        }
                        
                    }else
                    {
                        minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                        maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                    }
                }else
                {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                }
            }
            break;
            
        case 3:
            minDisplayLabel.text = @"Min Unit: 1";
            maxDisplayLabel.text = [NSString stringWithFormat:@"Max Unit: %.f",maxRiderSA];
            break;
            
        default:
            minDisplayLabel.text = @"";
            maxDisplayLabel.text = @"";
            break;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString     = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    
    if (([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"] ||
         [riderCode isEqualToString:@"SP_PRE"] || [riderCode isEqualToString:@"SP_STD"]))
    {
        if ([arrayOfString count] > 1) {
            return NO;
        } else if ([[arrayOfString objectAtIndex:0] length] > 3) {
            return NO;
        }
    }
    
    if ([arrayOfString count] > 2 )
    {
        return NO;
    }
    
    if ([arrayOfString count] > 1 && [[arrayOfString objectAtIndex:1] length] > 2) {
        return NO;
    }
    
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
        return NO;
    }
    
    return YES;
}

-(void)displayedMinMax
{    
    if ([sumField isFirstResponder] == TRUE) {
        if ([riderCode isEqualToString:@"ICR"] && [getPlanChoose isEqualToString:@"HLACP"])
        {
            if( getBasicSA < 5000 )
            {
                minDisplayLabel.text = @"Please increase BSA to at least RM5,000";
                maxDisplayLabel.text = @"";
            }
        }
        else if([riderCode isEqualToString:@"EDB"]){
            minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
            maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting"];
            
        }
        else if ([riderCode isEqualToString:@"TPDYLA"] && ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])) {
            if( maxRiderSA >= 5000 )
            {
                minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
            }
            else{
                minDisplayLabel.text = @"Please increase BSA to at least RM5,000";
                maxDisplayLabel.text = @"";
            }
        }
        else if ([riderCode isEqualToString:@"TPDYLA"] && [getPlanChoose isEqualToString:@"HLAWP"]) {
            
            if( maxRiderSA >= 5000 )
            {
                minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
            }
            else{
                int tempToIncrease = ceil( 5000/(0.25 * getMOP * [self getBasicSAFactor]));
                
                minDisplayLabel.text = [NSString stringWithFormat:@"Please increase Desired Annual Premium"];
                maxDisplayLabel.text = [NSString stringWithFormat:@"to at least RM%d", tempToIncrease];
            }
        }
        else if([riderCode isEqualToString:@"EDUWR"])
        {
            if (requesteEDD == TRUE && maxRiderSA <= minSATerm) {
                minDisplayLabel.text = [NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings"];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider."];
                maxDisplayLabel.numberOfLines = 2;
            }
            else{
                minDisplayLabel.text = [NSString stringWithFormat:@"Min GCP: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max GCP: %.f",maxRiderSA];
            }
            
        }
        else if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WBI6R30"] )
        {
            if (requesteEDD == TRUE && maxRiderSA <= minSATerm) {
                minDisplayLabel.text = [NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings"];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider."];
                maxDisplayLabel.numberOfLines = 2;
            }
            else{
                minDisplayLabel.text = [NSString stringWithFormat:@"Min GYCC: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max GYCC: %.f",maxRiderSA];
            }
            
        }
        else if( [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"]  )
        {
            minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
            maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting "];
        }
        else if(  [riderCode isEqualToString:@"WPTPD30R"] || [riderCode isEqualToString:@"WPTPD50R"] )
        {
            minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
            if (maxRiderSA > 0 && maxRiderSA >= minSATerm ) {
                maxDisplayLabel.numberOfLines = 2;
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f(Subject to TPD Benefit Limit\nper Life of RM3.5mil)",maxRiderSA];
            }
            else{
                int tempSA = 0;
                if ([LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound) {
                    tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD50R"]] integerValue];
                }
                
                if ([LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound) {
                    tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD30R"]] integerValue];
                }
                
                if (tempSA >= 1000000) {
                    minDisplayLabel.text = @"Maximum Total RSA for Wealth TPD Protector Rider";
                    maxDisplayLabel.numberOfLines = 2;
                    maxDisplayLabel.text = [NSString stringWithFormat:@"(30 and 50 years) is capped at RM 1mil per product limit.\nPlease revise the RSA of these rider(s)"];
                }
                else{
                    minDisplayLabel.text = @"";
                    maxDisplayLabel.numberOfLines = 2;
                    maxDisplayLabel.text = [NSString stringWithFormat:@"TPD Limit per Life is capped at RM3.5mil.\nPlease revise the RSA of TPD related Rider(s)."];
                }
                
            }
            
        }
        else {
            if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
            {
                if ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"CIR"] || [riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"LCPR"] || [riderCode isEqualToString:@"PLCP"] )
                {
                    if (maxRiderSA > 0 && maxRiderSA >= minSATerm ) {
                        NSString *subject = @"(Subject to CI Ben. Limit per\nLife across industry of RM4mil)";
                        minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f %@",maxRiderSA,subject];
                    }
                    else
                    {
                        minSATerm = 0;
                        minDisplayLabel.text = @"";
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"CI Ben. Limit per Life across industry is capped at RM4mil.\nPlease revise the RSA of CI related rider(s)."];
                        maxRiderSA = -1;
                    }
                    
                }else
                {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                }
            }
            else if([getPlanChoose isEqualToString:@"HLAWP"])
            {
                if ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"CIR"]|| [riderCode isEqualToString:@"ICR"]|| [riderCode isEqualToString:@"LCPR"] ||[riderCode isEqualToString:@"PLCP"])
                {
                    
                    if (maxRiderSA > 0) {
                        NSString *subject = @"(Subject to CI Ben. Limit per\nLife across industry of RM4mil)";
                        minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f %@",maxRiderSA,subject];
                    }
                    else{
                        minSATerm = 0;
                        minDisplayLabel.text = @"";
                        maxDisplayLabel.numberOfLines = 2;
                        maxDisplayLabel.text = [NSString stringWithFormat:@"CI Ben. Limit per Life across industry is capped at RM4mil.\nPlease revise the RSA of CI related rider(s)."];
                    }
                    
                }else
                {
                    minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                    maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
                }
            }else
            {
                minDisplayLabel.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
                maxDisplayLabel.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
            }
        }
        
    }
    else if ([termField isFirstResponder] == TRUE) {
        minDisplayLabel.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
        maxDisplayLabel.text = [NSString stringWithFormat:@"Max Term: %.f",maxRiderTerm];
    }
    else if ([unitField isFirstResponder] == TRUE) {
        
        minDisplayLabel.text = @"Min Unit: 1";
        maxDisplayLabel.text = [NSString stringWithFormat:@"Max Unit: %.f",maxRiderSA];
    }
    else {
        minDisplayLabel.text = @"";
        maxDisplayLabel.text = @"";
    }
}


#pragma mark - logic cycle

-(void)toggleForm
{
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++) {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"RITM"]]) {
            termLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            term = YES;
        }
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"SUMA"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"SUAS"]]) {

            sumLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            
            sumA = YES;
        }
        
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"GYIRM"]]) {
            sumLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            sumA = YES;
            incomeRider = YES;
        }
        
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLOP"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLCH"]]) {
            planLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            plan = YES;
            
            planCondition = [FCondition objectAtIndex:i];
            
        }
        
        cpaLabel.textColor = [UIColor grayColor];
        cpaField.enabled = NO;
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"UNIT"]]) {
            unitLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            unit = YES;
        }
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"DEDUC"]]) {
            unitLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            deduc = YES;
            
            deducCondition = [FCondition objectAtIndex:i];
        }
        
        occpLabel.textColor = [UIColor grayColor];
        occpField.enabled = NO;
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
            HLLabel.text = [[NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]] stringByReplacingString:@"1 " withString:@" "];
            hload = YES;
        }
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1KT"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10T"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLPT"]]) {
            HLTLabel.text = [[NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]] stringByReplacingString:@"1 " withString:@" "];
            hloadterm = YES;
        }
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
            tempHLLabel.text = @"Temporary Health Loading (Per 1K SA) :";
            tempHLTLabel.text = @"Temporary Health Loading (Per 1K SA) Term :";
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10"]]) {
            tempHLLabel.text = @"Temporary Health Loading (Per 100 SA) :";
            tempHLTLabel.text = @"Temporary Health Loading (Per 100 SA) Term :";
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
            tempHLLabel.text = @"Temporary Health Loading (%) :";
            tempHLTLabel.text = @"Temporary Health Loading (%) Term :";
        }
    }
    [self replaceActive];
}

-(void)replaceActive
{
    if (term) {
        termLabel.textColor = [UIColor blackColor];
        termField.enabled = YES;
        termField.textColor = [UIColor blackColor];
        
    } else {
        termLabel.textColor = [UIColor grayColor];
        termField.enabled = NO;
    }
    
    if (sumA) {
 
        sumLabel.textColor = [UIColor blackColor];
        sumField.enabled = YES;
    } else {
        sumLabel.textColor = [UIColor grayColor];
        sumField.enabled = NO;
    }
    
    if (plan) {
        planLabel.textColor = [UIColor blackColor];
        if([EAPPorSI isEqualToString:@"eAPP"]){
            planBtn.enabled = NO;
        }else
        {
            planBtn.enabled = YES;
        }
        planBtn.hidden = NO;
        [self.planBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        classField.hidden = YES;
        
        NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
		self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"TRAD" getPlanChoose:getPlanChoose];
        _planList.delegate = self;
        planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
        planOptionDesc = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItem];
        [self setPlanBtnTitle:planOption];
        
    }
    else {
        planLabel.textColor = [UIColor grayColor];
        planLabel.text = @"PA Class :";
        planBtn.enabled = NO;
        planBtn.hidden = YES;
        classField.hidden = NO;
        classField.enabled = NO;
        
        NSString *msg = @"";
        if (occCPA == 0) {
            msg = @"D";
        } else {
            msg = [NSString stringWithFormat:@"%d",occCPA];
        }
        classField.text = msg;
        classField.textColor = [UIColor darkGrayColor];
    }
    
    if (unit) {
        unitLabel.textColor = [UIColor blackColor];
        unitField.textColor = [UIColor blackColor];
        unitField.hidden = NO;
        unitField.enabled = YES;
        deducBtn.hidden = YES;
    }
    
    if (deduc) {
        unitLabel.textColor = [UIColor blackColor];
        unitField.hidden = YES;
        deducBtn.hidden = NO;
        
        NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
        self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:planOption];
        _deductList.delegate = self;
        
        [self.deducBtn setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
        deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        NSLog(@"deduc:%@",deductible);
        
    }
    
    if (!unit && !deduc) {
        unitLabel.text = @"Units :";
        unitLabel.textColor = [UIColor grayColor];
        deducBtn.hidden = YES;
        unitField.hidden = NO;
        unitField.enabled = NO;
        unitField.text = @"0";
        unitField.textColor = [UIColor darkGrayColor];
    }
    
    if (hload) {
        HLLabel.textColor = [UIColor blackColor];
        HLField.enabled = YES;
    } else {
        HLLabel.textColor = [UIColor grayColor];
        HLField.enabled = NO;
    }
    
    if (hloadterm) {
        HLTLabel.textColor = [UIColor blackColor];
        HLTField.enabled = YES;
    } else {
        HLTLabel.textColor = [UIColor grayColor];
        HLTField.enabled = NO;
    }
    
    if (occCPA == 0) {
        cpaField.text = @"D";
    }
    else {
        cpaField.text = [NSString stringWithFormat:@"%d",occCPA];
    }
    cpaField.textColor = [UIColor darkGrayColor];
    
    if (occPA == 0) {
        classField.text = @"D";
    }
    else {
        classField.text = [NSString stringWithFormat:@"%d",occPA];
    }
    classField.textColor = [UIColor darkGrayColor];
    
    occpField.text = [NSString stringWithFormat:@"%@",occLoadType];
    occpField.textColor = [UIColor darkGrayColor];
}

-(void)validateRules
{
    [self getListingRider];
    
	NSString *currentSelectedRider = riderCode;
    BOOL dodelete = NO;
    BOOL deleteL100Rid = FALSE; //boolean to delete riders if ACIR_MPP sumassured = BasicSA
//    NSString *ReturnMsg;
    
    PremiumViewController *premView = [self.storyboard instantiateViewControllerWithIdentifier:@"premiumView"];
    premView.requestAge = getAge;
    premView.requestOccpClass = getOccpClass;
    premView.requestOccpCode = getOccpCode;
    premView.requestSINo = getSINo;
    premView.requestMOP = getMOP;
    premView.requestTerm = getTerm;
    premView.requestBasicSA = [NSString stringWithFormat:@"%f", getBasicSA ];
    premView.requestBasicHL = [NSString stringWithFormat:@"%f", getBasicHL ];
    premView.requestBasicTempHL = [NSString stringWithFormat:@"%f", getBasicTempHL ];
    premView.requestPlanCode = getPlanChoose;
    premView.requestBasicPlan = getPlanChoose;
    premView.sex = getSex;
    premView.EAPPorSI = [self.EAPPorSI description];
    premView.fromReport = FALSE;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 0, 0) ];
    [view addSubview:premView.view];
    
    dblGrossPrem = premView.ReturnGrossPrem;
    
    [view removeFromSuperview ];
    view = Nil;
    premView = Nil;
    
    if([self calculateCIBenefitValidateRules:@"First"] > 4000000){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. Please revise the RSA of CI related rider(s)."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    double riderSA;
    int riderUnit;
    int riderTerm;
    NSString *querySQL;
    for (int p=0; p<LRiderCode.count; p++) 
    {
        riderCode = [LRiderCode objectAtIndex:p];
        ridTermG = [LTerm objectAtIndex:p];
        [self getRiderTermRule];
        [self getRiderTermRuleGYCC:riderCode riderTerm:maxTerm];
        ridPAge = [[LAge objectAtIndex:p] intValue];
        isFromTable = FALSE;
        isFromDropDown = FALSE;
        [self calculateTerm];
        [self calculateSA];
        riderSA = [[LSumAssured objectAtIndex:p] doubleValue];
        riderUnit = [[LUnits objectAtIndex:p] intValue];
        riderTerm = [[LTerm objectAtIndex:p] intValue];
        
        if (riderSA > [RiderViewController getRoundedSA:maxRiderSA] && ![riderCode isEqualToString:@"WPTPD30R"] && ![riderCode isEqualToString:@"WPTPD50R"])
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"rider %@ delete!",riderCode);
                    } else {
                        NSLog(@"rider delete Failed!");
                    }
                    sqlite3_finalize(statement);
                }
                sqlite3_close(contactDB);
            }
        }
        
        if (riderUnit > [RiderViewController getRoundedSA:maxRiderSA] && ![riderCode isEqualToString:@"WPTPD30R"] && ![riderCode isEqualToString:@"WPTPD50R"])
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"rider %@ delete!",riderCode);
                    } else {
                        NSLog(@"rider delete Failed!");
                    }
                    sqlite3_finalize(statement);
                }
                sqlite3_close(contactDB);
            }
        }
        
        if (riderTerm > maxRiderTerm)
        {
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {			
				
				if([riderCode isEqualToString:@"LCWP" ]){
                    dodelete = YES;
                    querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            NSLog(@"rider %@ delete!",riderCode);
                        } else {
                            NSLog(@"rider delete Failed!");
                        }
                        sqlite3_finalize(statement);
                    }
                    
					querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"PLCP\"",requestSINo];					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_DONE)
						{
							NSLog(@"rider PLCP delete!");
						} else {
							NSLog(@"rider PLCP delete Failed!");
						}
						sqlite3_finalize(statement);
					}
				} else if([riderCode isEqualToString:@"PR" ]){
                    dodelete = YES;
                    querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            NSLog(@"rider %@ delete!",riderCode);
                        } else {
                            NSLog(@"rider delete Failed!");
                        }
                        sqlite3_finalize(statement);
                    }
                    
					querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"PTR\"",requestSINo];					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_DONE)
						{
							NSLog(@"rider PTR delete!");
						} else {
							NSLog(@"rider PTR delete Failed!");
						}
						sqlite3_finalize(statement);
					}
				} else if (![riderCode isEqualToString:@"PTR"] && ![riderCode isEqualToString:@"PLCP"]) {
                    dodelete = YES;
                    querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            NSLog(@"rider %@ delete!",riderCode);
                        } else {
                            NSLog(@"rider delete Failed!");
                        }
                        sqlite3_finalize(statement);
                    }
                }
                
				
                sqlite3_close(contactDB);
            }
        }
        
        if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {
            if( [riderCode isEqualToString:@"ACIR_MPP"] )
            {
                sqlite3_stmt *statement;
                double riderSumAssured = 0;
                
                if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                {
                    NSString *querySQL = [NSString stringWithFormat:
                                          @"SELECT sumAssured from trad_rider_details where SINO=\"%@\" and RiderCode=\"%@\"",requestSINo,riderCode];
                    const char *query_stmt = [querySQL UTF8String];
                    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_ROW)
                        {
                            riderSumAssured =  sqlite3_column_double(statement, 0);
                        } else {
                            NSLog(@"error access Trad_Sys_Rider_Prem");
                        }
                        sqlite3_finalize(statement);
                    }
                    sqlite3_close(contactDB);
                }
                
                if( getBasicSA == riderSumAssured )
                {
                    deleteL100Rid = TRUE;
                }
            }
        }
    }
    
    if(deleteL100Rid)
    {
        BOOL deletedAffectedRid = FALSE;
        
        for (int p=0; p<LRiderCode.count; p++) 
        {
            riderCode = [LRiderCode objectAtIndex:p];
            if(!deletedAffectedRid)
            {
                deletedAffectedRid = ![ridNotAffected containsObject:riderCode];
            }
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"delete from trad_rider_details where riderCode not in "
                                      "('ACIR_MPP', 'CIR', 'ICR', 'LCPR', 'LCWP', 'PLCP', 'PTR', 'PR', 'SP_PRE', 'SP_STD' ) AND "
                                      "SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"rider %@ delete!",riderCode);
                    } else {
                        NSLog(@"rider delete Failed!");
                    }
                    sqlite3_finalize(statement);
                }
                sqlite3_close(contactDB);
            }
        }
        dodelete = deletedAffectedRid;
    }
    
    
    if (dodelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1005];
        [alert show];
    }
    else {
        [self getListingRider];
        [self getListingRiderByType];
        
        [self calculateRiderPrem];
        [self calculateWaiver];
        [self calculateMedRiderPrem];
        
        [_delegate RiderAdded];
		
		riderCode = currentSelectedRider;
		[self getRiderTermRule];
        [self getRiderTermRuleGYCC:riderCode riderTerm:maxTerm];
        ridPAge = -1; //please set this as negative 1 everytime calling calculateTerm, unless if calculateTerm was called in a loop of riders, then set it "ridPAge = [[LAge objectAtIndex:p] intValue];"
        isFromTable = FALSE;
        isFromDropDown = FALSE;
        [self calculateTerm];
        [self calculateSA];
    }
}


#pragma mark - calculation

-(void)calculateTerm
{
    int minus = -1000;//exaggeration easier for debugging
    
    if(ridPAge==-1)
    {
        minus = pTypeAge;
    }else
    {
        minus = ridPAge;
    }
    
    int period = expAge - minus;
    int period2 = 80 - minus;
    double age1 = fmin(period2,60);
    
    if ([riderCode isEqualToString:@"CIWP"])
    {
        [self getMaxRiderTerm:riderCode];
        double maxRiderTerm1 = fmin(period,getTerm);
        double maxRiderTerm2 = fmax(getMOP,storedMaxTerm);
        
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
    }
    else if ([riderCode isEqualToString:@"LCWP"]||[riderCode isEqualToString:@"PR"]||[riderCode isEqualToString:@"PLCP"]||
             [riderCode isEqualToString:@"PTR"]||[riderCode isEqualToString:@"SP_STD"]||[riderCode isEqualToString:@"SP_PRE"])
    {
        [self getMaxRiderTerm:riderCode];
        double maxRiderTerm1 = fmin(getTerm,age1);
        double maxRiderTerm2 = fmax(getMOP,storedMaxTerm);
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
        
        if (maxRiderTerm < minTerm) {
            maxRiderTerm = maxTerm;
        } else  if (([riderCode isEqualToString:@"PLCP"] || [riderCode isEqualToString:@"PTR"]) && maxRiderTerm > maxTerm) {
            maxRiderTerm = maxTerm;
        }
    }
    else if ([riderCode isEqualToString:@"I20R"]||[riderCode isEqualToString:@"I30R"]||[riderCode isEqualToString:@"I40R"] || [riderCode isEqualToString:@"IE20R"] || [riderCode isEqualToString:@"IE30R"] ) //edited by heng
    {
        maxRiderTerm = maxTerm;
        if(isFromTable)
        {
            termField.text = [NSString stringWithFormat:@"%d",maxTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = [NSString stringWithFormat:@"%d",maxTerm];
                termField.textColor = [UIColor darkGrayColor];
            }
        }
    }
    else if ([riderCode isEqualToString:@"ED25R"])
    {
        maxRiderTerm = getTerm;
        if(isFromTable)
        {
            termField.text = [NSString stringWithFormat:@"%d",getTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = [NSString stringWithFormat:@"%d",getTerm];
                termField.textColor = [UIColor darkGrayColor];
            }
        }
    }
    else if ([riderCode isEqualToString:@"EE25R"])
    {
        maxRiderTerm = maxTerm;
        if(isFromTable)
        {
            termField.text = [NSString stringWithFormat:@"%d",maxTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = [NSString stringWithFormat:@"%d",maxTerm];
                termField.textColor = [UIColor darkGrayColor];
            }
        }
    }
    else if ([riderCode isEqualToString:@"ID20R"]||[riderCode isEqualToString:@"ID30R"]||[riderCode isEqualToString:@"ID40R"]||[riderCode isEqualToString:@"MG_II"]||[riderCode isEqualToString:@"MG_IV"]||[riderCode isEqualToString:@"HB"]||[riderCode isEqualToString:@"HSP_II"]||[riderCode isEqualToString:@"CPA"]||[riderCode isEqualToString:@"PA"]||[riderCode isEqualToString:@"HMM"])
    {
        
        if ([getPlanChoose isEqualToString:@"HLAWP"]) {
            if ([riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] ) {
                maxRiderTerm = MIN(getTerm, 70 - getAge);
            }
            else if ([riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HMM"] ) {
                maxRiderTerm = getTerm;
            }
            else if ([riderCode isEqualToString:@"CPA"]  ) {
                maxRiderTerm = MIN(getTerm, 65 - getAge);
            }
            else if ([riderCode isEqualToString:@"HB"]  ) {
                maxRiderTerm = MIN(getTerm, 60 - getAge);
            }
            else if ([riderCode isEqualToString:@"PA"]  ) {
                maxRiderTerm = MIN(getTerm, 75 - getAge);
            }

        }
        else if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"]){
            //maxRiderTerm = fmin(period,getTerm);
            if ([riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] ) {
                maxRiderTerm = MIN(getTerm, 70 - getAge);
            }
            else if ([riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HMM"] ) {
                maxRiderTerm = getTerm;
            }
            else if ([riderCode isEqualToString:@"CPA"]  ) {
                maxRiderTerm = MIN(getTerm, 65 - getAge);
            }
            else if ([riderCode isEqualToString:@"HB"]  ) {
                maxRiderTerm = MIN(getTerm, 60 - getAge);
            }
            else if ([riderCode isEqualToString:@"PA"]  ) {
                maxRiderTerm = MIN(getTerm, 75 - getAge);
            }
        }

        if(isFromTable)
        {
            termField.text = [NSString stringWithFormat:@"%.f",maxRiderTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = [NSString stringWithFormat:@"%.f",maxRiderTerm];
                termField.textColor = [UIColor darkGrayColor];
            }
        }
    }
    else if ([riderCode isEqualToString:@"EDB"]||[riderCode isEqualToString:@"ETPDB"])
    {
        maxRiderTerm = maxTerm;
        if(isFromTable)
        {
            termField.text = [NSString stringWithFormat:@"%d",maxTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = [NSString stringWithFormat:@"%d",maxTerm];
                termField.textColor = [UIColor darkGrayColor];
            }
        }
    }
    else {
        maxRiderTerm = fmin(period,getTerm);
        if(isFromTable)
        {
            termField.text = ridTermG;
            termField.textColor = [UIColor blackColor];
        }else
        {
            if(isFromDropDown)
            {
                termField.text = ridTermG;
                termField.textColor = [UIColor blackColor];
            }
        }
    }
    
    if([getPlanChoose isEqualToString:@"HLAWP"])
    {        
        if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBI6R30"]
           || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"]
           || [riderCode isEqualToString:@"WPTPD30R"] || [riderCode isEqualToString:@"WPTPD50R"] )
        {
            maxRiderTerm = maxTerm;
            termField.text = [NSString stringWithFormat:@"%d",maxTerm];
            termField.textColor = [UIColor darkGrayColor];
        }else
        if([riderCode isEqualToString:@"EDUWR"])
        {
            termField.text = [NSString stringWithFormat:@"%d",maxTerm-getAge];
            termField.textColor = [UIColor darkGrayColor];
        }
    }
    
    NSLog(@"expAge-alb:%d,covperiod:%d,maxRiderTerm:%.f,age1:%.f",period,getTerm,maxRiderTerm,age1);
}

-(void)calculateSA
{
    [self getBasicSARate];
    double dblPseudoBSA;
    double dblPseudoBSA2 ;
    double dblPseudoBSA3 ;
    double dblPseudoBSA4 ;
    
    if ([getPlanChoose isEqualToString:@"HLAWP"]) {
        dblPseudoBSA = getBasicSA * getMOP * [self getBasicSAFactor];
        dblPseudoBSA2 = dblPseudoBSA * 0.1;
        dblPseudoBSA3 = dblPseudoBSA * 5;
        dblPseudoBSA4 = dblPseudoBSA * 2;
    }
    else{
        dblPseudoBSA = getBasicSA / 0.05;
        dblPseudoBSA2 = dblPseudoBSA * 0.1;
        dblPseudoBSA3 = dblPseudoBSA * 5;
        dblPseudoBSA4 = dblPseudoBSA * 2;
    }
    
    double pseudoFactor = 0;
    if(getTerm == 30)
    {
        pseudoFactor = 1.5;
    }else
    if(getTerm == 50)
    {
        pseudoFactor = 2.5;
    }
    
    //double dblPseudoBSA_WP = getBasicSA * pseudoFactor * getMOP;
    
    int MaxUnit = 0;
    //    NSLog(@"dblPseudoBSA:%.f, dblPseudoBSA3:%.f",maxRiderSA,dblPseudoBSA3);
    
    if ([riderCode isEqualToString:@"ACIR_MPP"])
    {
        _maxRiderSA = fmin(getBasicSA ,4000000 - [self calculateCIBenefit:@"First"]);

        if (_maxRiderSA < 20000) {
            _maxRiderSA = -1;
        }
        
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
        

    }
    else if ([riderCode isEqualToString:@"CCTR"])
    {
        if([getPlanChoose isEqualToString:@"HLACP"])
        {
            _maxRiderSA = dblPseudoBSA3;
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
        else if([getPlanChoose isEqualToString:@"HLAWP"])
        {
            _maxRiderSA = dblPseudoBSA * 5;
            //_maxRiderSA = 3500000 - [self CalcTPDbenefit];
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
        else if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {    
            _maxRiderSA = getBasicSA;
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
            maxRiderSA = maxRiderSA * maxSAFactor;
        }
    }
    else if ([riderCode isEqualToString:@"TPDYLA"])
    {
        double minOf = -1;
        if ([getPlanChoose isEqualToString:@"HLACP"])
        {
            minOf = maxSAFactor*(getBasicSA / 0.05);
            _maxRiderSA = fmin(minOf, 200000);
        }
        else if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {
            //minOf = maxSAFactor*getBasicSA;
            //_maxRiderSA = fmin(minOf, 200000); wrong formula by edwin
            if ([OccpCat isEqualToString:@"UNEMP"] || [OccpCat isEqualToString:@"JUV"] || [OccpCat isEqualToString:@"STU"] || [OccpCat isEqualToString:@"HSEWIFE"] || [OccpCat isEqualToString:@"RET"] ) {
                _maxRiderSA = fmin(24000, floor(getBasicSA * maxSAFactor));
            }
            else{
                _maxRiderSA = fmin(200000, getBasicSA * maxSAFactor);
            }
        }
        else if ([getPlanChoose isEqualToString:@"HLAWP"])
        {
            if ([OccpCat isEqualToString:@"UNEMP"] || [OccpCat isEqualToString:@"JUV"] || [OccpCat isEqualToString:@"STU"] || [OccpCat isEqualToString:@"HSEWIFE"] || [OccpCat isEqualToString:@"RET"] ) {
                _maxRiderSA = fmin(24000, floor(dblPseudoBSA * maxSAFactor));
            }
            else{
                _maxRiderSA = fmin(200000, dblPseudoBSA * maxSAFactor);
            }
            
            
            
        }
        
//        _maxRiderSA = fmin(maxSAFactor*getBasicSA, 200000); L100
//        _maxRiderSA = fmin(dblPseudoBSA2,120000); hlacp
//        _maxRiderSA = fmin(minOf, 200000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
        
    }
    else if ([riderCode isEqualToString:@"I20R"]||[riderCode isEqualToString:@"I30R"]||[riderCode isEqualToString:@"I40R"]||[riderCode isEqualToString:@"ID20R"]||[riderCode isEqualToString:@"ID30R"]||[riderCode isEqualToString:@"ID40R"]||[riderCode isEqualToString:@"IE20R"]||[riderCode isEqualToString:@"IE30R"])
    {
        NSLog(@"enter gyi");
        [self getGYI];
        double BasicSA_GYI = getBasicSA * GYI;
        _maxRiderSA = fmin(BasicSA_GYI,9999999);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"CPA"])
    {
        if (getOccpClass == 1 || getOccpClass == 2) {
            if([getPlanChoose isEqualToString:@"HLACP"] || [getPlanChoose isEqualToString:@"HLAWP"])
            {
                if (dblPseudoBSA < 100000) {
                    _maxRiderSA = fmin(dblPseudoBSA3,200000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                }
                else if (dblPseudoBSA >= 100000) {
                    _maxRiderSA = fmin(dblPseudoBSA4,1000000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                }
            }
            else if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
            {
                    if (getBasicSA < 100000) {
                        _maxRiderSA = fmin(getBasicSA*5,200000);
                        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                        maxRiderSA = [a_maxRiderSA doubleValue];
                    }
                    else if (getBasicSA >= 100000) {
                        _maxRiderSA = fmin(getBasicSA*2,maxSATerm);
                        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                        maxRiderSA = [a_maxRiderSA doubleValue];
                    }
            }
        }
        else if (getOccpClass == 3 || getOccpClass == 4) {
            if([getPlanChoose isEqualToString:@"HLACP"] || [getPlanChoose isEqualToString:@"HLAWP"])
            {
                _maxRiderSA = fmin(dblPseudoBSA3,100000);
                NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                maxRiderSA = [a_maxRiderSA doubleValue];
            }
            else if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
            {
                    _maxRiderSA = fmin(getBasicSA*5,100000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
            }
        }
    }
    else if ([riderCode isEqualToString:@"PA"]) {
        if ([getPlanChoose isEqualToString:@"HLACP"] || [getPlanChoose isEqualToString:@"HLAWP"])
        {
            //_maxRiderSA = fmin(dblPseudoBSA3,1000000); again wrong formula by edwin
            _maxRiderSA = fmin(5 * dblPseudoBSA, 1000000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }else
            if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
            {
                _maxRiderSA = fmin(5*getBasicSA,maxSATerm);
                NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                maxRiderSA = [a_maxRiderSA doubleValue];
            }
    }
    else if ([riderCode isEqualToString:@"PTR"]) {
        if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"]) {
            _maxRiderSA = fmin(getBasicSA * 5, 500000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
        else if ([getPlanChoose isEqualToString:@"HLAWP"]){
            _maxRiderSA = fmin(5 * dblPseudoBSA,500000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
        else{
            
        }
        
    }
    else if ([riderCode isEqualToString:@"HB"]) {
        /*
        if (dblPseudoBSA >= 10000 && dblPseudoBSA <= 25000) {
            MaxUnit = 4;
        }
        else if (dblPseudoBSA >= 25001 && dblPseudoBSA <= 50000) {
            MaxUnit = 6;
        }
        else if (dblPseudoBSA >= 50001 && dblPseudoBSA <= 75000) {
            MaxUnit = 8;
        }
        else if (dblPseudoBSA > 75000) {
            MaxUnit = 10;
        }
        else {
            MaxUnit = 0;
        }
         */
        double tempPseudo = 0.00;
        if ([getPlanChoose isEqualToString:@"HLAWP"]) {
            tempPseudo = dblPseudoBSA;
        }
        else if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"]){
            tempPseudo = getBasicSA;
        }
        
        if (tempPseudo >= 10000 && tempPseudo <= 25000) {
            MaxUnit = 4;
        }
        else if (tempPseudo >= 25001 && tempPseudo <= 50000) {
            MaxUnit = 6;
        }
        else if (tempPseudo >= 50001 && tempPseudo <= 75000) {
            MaxUnit = 8;
        }
        else if (tempPseudo > 75000) {
            MaxUnit = 10;
        }
        else {
            MaxUnit = 0;
        }
        
        maxRiderSA = MaxUnit;
    }
    else if ([riderCode isEqualToString:@"ETPDB"]) {
        double max = basicPremAnn * 10;
        _maxRiderSA = fmin(max, maxSATerm);
        maxRiderSA = _maxRiderSA;
    }/*
    else if ([riderCode isEqualToString:@"ICR"]) {
        _maxRiderSA = fmin(120000, getBasicSA);
        maxRiderSA = _maxRiderSA;
    }*/
    else if ([riderCode isEqualToString:@"ICR"])
    {
        double minOf = -1;
        if ([getPlanChoose isEqualToString:@"HLACP"])
        {
            minOf = getBasicSA / 0.05;
            _maxRiderSA = fmin(minOf, 120000);
        }
        else if ([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {
                //minOf = maxSAFactor*getBasicSA;
            _maxRiderSA = fmin(getBasicSA, MIN(120000, (4000000 - [self calculateCIBenefit:@"First"])/10 ));
            
            if (_maxRiderSA < 5000) {
                _maxRiderSA = -1;
            }

        }
        else if ([getPlanChoose isEqualToString:@"HLAWP"])
        {
                
                //_maxRiderSA = fmin(15 * getBasicSA, 120000);
            _maxRiderSA = MIN(MIN(120000, (4000000 - [self calculateCIBenefit:@"First"])/10 ), dblPseudoBSA);

        }

//        _maxRiderSA = fmin(minOf, 120000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
        
    }
    else
    {
        if ([getPlanChoose isEqualToString:@"HLAWP"] || [getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {
            if ([riderCode isEqualToString:@"CIR"]||[riderCode isEqualToString:@"LCPR"])
            {
                _maxRiderSA = 4000000 - [self calculateCIBenefit:@"First"];
                
                if (_maxRiderSA < 25000) {
                    _maxRiderSA = -1;
                }
            }else
            {
                _maxRiderSA = maxSATerm;
            }
        }else
        {
            _maxRiderSA = maxSATerm;
        }
        
        if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WBI6R30"])
        {
            if (requesteEDD == TRUE) {
                _maxRiderSA = floor((15000 - getBasicSA)/maxGycc * 1000);
            }
            else{
                _maxRiderSA = MIN(floor(getBasicSA *  maxGycc/1000.00), 9999999) ;
            }
            
        }
        else if([riderCode isEqualToString:@"EDUWR"])
        {
            if (requesteEDD == TRUE) {
                _maxRiderSA = floor((15000 - getBasicSA)/maxGycc * 1000);
            }
            else{
                _maxRiderSA = getBasicSA * maxGycc/1000;
            }
            if (_maxRiderSA > 9999999) {
                _maxRiderSA = 9999999;
            }
        }
        else if([riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"] )
        {
            _maxRiderSA = 999999999;
        }
        else if([riderCode isEqualToString:@"WPTPD30R"] ){
            
            NSString *msg;
            double tempAll = 3500000 - [self CalcTPDbenefit : YES andMsg:&msg ];
            double temps;
            double tempGrossPrem = 0.00;
            
            if( [LTypeRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound){
                temps =  1000000 - [[LTypeSumAssured objectAtIndex:[LTypeRiderCode indexOfObject:@"WPTPD50R"]] doubleValue];
                tempGrossPrem = 60 * dblGrossPrem - [[LTypeSumAssured objectAtIndex:[LTypeRiderCode indexOfObject:@"WPTPD50R"]] doubleValue];
            }
            else{
                temps = 1000000;
                tempGrossPrem = 60 *  [self dblRoundToTwoDecimal:dblGrossPrem ];
            }
            
            _maxRiderSA = floor(MIN(tempGrossPrem, MIN(tempAll, temps)));
    
        }
        else if([riderCode isEqualToString:@"WPTPD50R"]){
            NSString *msg;
            double tempAll = 3500000 - [self CalcTPDbenefit : YES andMsg:&msg];
            double tempGrossPrem = 0.00;
            double temps;
            
            if( [LTypeRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound){
                temps = 1000000 - [[LTypeSumAssured objectAtIndex:[LTypeRiderCode indexOfObject:@"WPTPD30R"]] doubleValue];
                tempGrossPrem = 60 * dblGrossPrem - [[LTypeSumAssured objectAtIndex:[LTypeRiderCode indexOfObject:@"WPTPD30R"]] doubleValue];
            }
            else{
                temps = 1000000;
                tempGrossPrem = 60 * [self dblRoundToTwoDecimal:dblGrossPrem ];
            }
            
            _maxRiderSA = floor(MIN(tempGrossPrem, MIN(tempAll, temps)));
        }
        
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    //    NSLog(@"maxSA(%@):%.f",riderCode,maxRiderSA);
}

-(double)dblRoundToTwoDecimal:(double)value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    
    NSString *temp = [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
    
    return [temp doubleValue];
}

-(double)getBasicSAFactor{
    if (getTerm == 50) {
        return 2.5;
    }
    else if (getTerm == 30){
        return 1.5;
    }
    else{
        return 0.00;
    }
}

-(double)CalcTPDbenefit : (BOOL)excludeSelf andMsg : (NSString **)aaMsg{
    sqlite3_stmt *statement;
    double tempValue = 0.00;
    double tempPrem = 0;
    double tempPremWithoutLoading = 0;
    NSMutableDictionary *tempArray = [[NSMutableDictionary alloc] init];
    NSString *strRiders = @"";
    NSString *tempCode;
    int count = 1;
    
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
        
        
        if (excludeSelf == YES) {
            querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', ''),replace(PremiumWithoutHLoading, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'CCTR', 'EDUWR', 'LCPR', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30', 'WPTPD30R', 'WPTPD50R' ) AND SINO = '%@' AND TYPE <> '%@' ", getSINo, riderCode];
        }
        else{
            querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'CCTR', 'EDUWR', 'LCPR', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30', 'WPTPD30R', 'WPTPD50R' ) AND SINO = '%@' ", getSINo];
        }
        
        
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
    
    if (tempValue > 3500000 && count > 1) {
        *aaMsg = strRiders;
    }
    else{
        *aaMsg = @"";
    }
    
    return tempValue;
}
-(double)calculateCIBenefit: (NSString *)aaPersonType {

    sqlite3_stmt *statement;
    double CI = 0.00;
    NSMutableArray *ArrayCIRider = [[NSMutableArray alloc] init ];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    int tempRiderTerm;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *SelectSQL;

        if ([aaPersonType isEqualToString:@"First"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('ACIR_MPP', 'CIR', 'ICR', 'LCPR','CIWP') and sino = \"%@\" AND Ridercode <> '%@' ", getSINo, riderCode];
        }
        else if ([aaPersonType isEqualToString:@"Second"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('PLCP') and sino = \"%@\" AND Ridercode <> '%@' ", getSINo, riderCode];
        }
        else if ([aaPersonType isEqualToString:@"Payor"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('PLCP') and sino = \"%@\" AND Ridercode <> '%@' ", getSINo, riderCode];
        }
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"ACIR_MPP"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIR"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"PLCP"]){
                    CI = CI + sqlite3_column_double(statement, 1);
                }
                else if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"ICR"]){
                    CI = CI +  sqlite3_column_double(statement, 1) * 10;
                }
                else if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"] ||
                        [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"] ||
                        [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"SP_PRE"]){
                    
                    [temp setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]
                             forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                }
                
            }

            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:
                               @"select type, WaiverSAAnnual from SI_Store_Premium where Type in "
                               "('CIWP') and sino = \"%@\" AND Type <> '%@' ", getSINo, riderCode];
        
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
        sqlite3_close(contactDB);
    }
    
    temp = Nil;
    ArrayCIRider = Nil;
    return CI;
}

-(double)calculateCIBenefitValidateRules: (NSString *)aaPersonType {
    
    sqlite3_stmt *statement;
    double CI = 0.00;
    NSMutableArray *ArrayCIRider = [[NSMutableArray alloc] init ];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    int tempRiderTerm;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *SelectSQL;
        
        if ([aaPersonType isEqualToString:@"First"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('ACIR_MPP', 'CIR', 'ICR', 'LCPR','CIWP') and sino = \"%@\"  ", getSINo];
        }
        else if ([aaPersonType isEqualToString:@"Second"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('PLCP') and sino = \"%@\" AND Ridercode <> '%@' ", getSINo, riderCode];
        }
        else if ([aaPersonType isEqualToString:@"Payor"]) {
            SelectSQL = [NSString stringWithFormat:
                         @"select ridercode, sumAssured, riderterm from trad_rider_details where ridercode in "
                         "('PLCP') and sino = \"%@\" AND Ridercode <> '%@' ", getSINo, riderCode];
        }
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"ACIR_MPP"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIR"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCPR"] ||
                   [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"PLCP"]){
                    CI = CI + sqlite3_column_double(statement, 1);
                }
                else if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"ICR"]){
                    CI = CI +  sqlite3_column_double(statement, 1) * 10;
                }
                else if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"] ||
                        [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"] ||
                        [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"SP_PRE"]){
                    
                    [temp setObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]
                             forKey:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                }
                
            }
            
            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:
                     @"select type, WaiverSAAnnual from SI_Store_Premium where Type in ('CIWP') and sino = \"%@\"  ", getSINo];
        
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
        
        sqlite3_close(contactDB);
    }
    
    temp = Nil;
    ArrayCIRider = Nil;
    return CI;
}


-(void)calculateBasicPremium
{
    double BasicSA = getBasicSA;
    double PolicyTerm = getTerm;
    double BasicHLoad = getBasicHL;
    double BasicTempHLoad = getBasicTempHL;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //calculate basic premium
    double _BasicAnnually = basicRate * (BasicSA/1000) * 1;
    double _BasicHalfYear = basicRate * (BasicSA/1000) * 0.5125;
    double _BasicQuarterly = basicRate * (BasicSA/1000) * 0.2625;
    double _BasicMonthly = basicRate * (BasicSA/1000) * 0.0875;
    NSString *BasicAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicAnnually]];
    NSString *BasicHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicHalfYear]];
    NSString *BasicQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicQuarterly]];
    NSString *BasicMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicMonthly]];
    double BasicAnnually_ = [[BasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHalfYear_ = [[BasicHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicQuarterly_ = [[BasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicMonthly_ = [[BasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"Basic A:%.2f, S:%.2f, Q:%.2f, M:%.2f",BasicAnnually_,BasicHalfYear_,BasicQuarterly_,BasicMonthly_);
    
    //calculate occupationLoading
    double _OccpLoadA = 0;
    double _OccpLoadH = 0;
    double _OccpLoadQ = 0;
    double _OccpLoadM = 0;
    if ([getPlanChoose isEqualToString:@"HLAIB"]) {
        _OccpLoadA = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.0875;
    }
    else {
        _OccpLoadA = occLoad * 55 * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad * 55 * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad * 55 * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad * 55 * (BasicSA/1000) * 0.0875;
    }
    NSString *OccpLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadA]];
    NSString *OccpLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadH]];
    NSString *OccpLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadQ]];
    NSString *OccpLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadM]];
    double OccpLoadA_ = [[OccpLoadA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadH_ = [[OccpLoadH stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadQ_ = [[OccpLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadM_ = [[OccpLoadM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"OccpLoad A:%.2f, S:%.2f, Q:%.2f, M:%.2f",OccpLoadA_, OccpLoadH_, OccpLoadQ_, OccpLoadM_);
    
    //calculate basic health loading
    double _BasicHLAnnually = BasicHLoad * (BasicSA/1000) * 1;
    double _BasicHLHalfYear = BasicHLoad * (BasicSA/1000) * 0.5125;
    double _BasicHLQuarterly = BasicHLoad * (BasicSA/1000) * 0.2625;
    double _BasicHLMonthly = BasicHLoad * (BasicSA/1000) * 0.0875;
    //calculate basic temporary health loading
    double _BasicTempHLAnnually = BasicTempHLoad * (BasicSA/1000) * 1;
    double _BasicTempHLHalfYear = BasicTempHLoad * (BasicSA/1000) * 0.5125;
    double _BasicTempHLQuarterly = BasicTempHLoad * (BasicSA/1000) * 0.2625;
    double _BasicTempHLMonthly = BasicTempHLoad * (BasicSA/1000) * 0.0875;
    
    double _allBasicHLAnn = _BasicHLAnnually + _BasicTempHLAnnually;
    double _allBasicHLHalf = _BasicHLHalfYear + _BasicTempHLHalfYear;
    double _allBasicHLQuar = _BasicHLQuarterly + _BasicTempHLQuarterly;
    double _allBasicHLMonth = _BasicHLMonthly + _BasicTempHLMonthly;
    
    NSString *BasicHLAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLAnn]];
    NSString *BasicHLHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLHalf]];
    NSString *BasicHLQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLQuar]];
    NSString *BasicHLMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLMonth]];
    double BasicHLAnnually_ = [[BasicHLAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLHalfYear_ = [[BasicHLHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLQuarterly_ = [[BasicHLQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLMonthly_ = [[BasicHLMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicHL A:%.3f, S:%.3f, Q:%.3f, M:%.3f",BasicHLAnnually_, BasicHLHalfYear_, BasicHLQuarterly_, BasicHLMonthly_);
    
    //calculate LSD
    double _LSDAnnually = LSDRate * (BasicSA/1000) * 1;
    double _LSDHalfYear = LSDRate * (BasicSA/1000) * 0.5125;
    double _LSDQuarterly = LSDRate * (BasicSA/1000) * 0.2625;
    double _LSDMonthly = LSDRate * (BasicSA/1000) * 0.0875;
    NSString *LSDAnnually2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDAnnually]];
    NSString *LSDHalfYear2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDHalfYear]];
    NSString *LSDQuarterly2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDQuarterly]];
    NSString *LSDMonthly2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDMonthly]];
    //for negative value
    LSDAnnually2 = [LSDAnnually2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDHalfYear2 = [LSDHalfYear2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDQuarterly2 = [LSDQuarterly2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDMonthly2 = [LSDMonthly2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDAnnually2 = [LSDAnnually2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDHalfYear2 = [LSDHalfYear2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDQuarterly2 = [LSDQuarterly2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDMonthly2 = [LSDMonthly2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    double LSDAnnually_ = [[LSDAnnually2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDHalfYear_ = [[LSDHalfYear2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDQuarterly_ = [[LSDQuarterly2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDMonthly_ = [[LSDMonthly2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicLSD A:%.2f, S:%.2f, Q:%.2f, M:%.2f",LSDAnnually_, LSDHalfYear_, LSDQuarterly_, LSDMonthly_);
    
    
    //calculate Total basic premium
    double _basicTotalA = 0;
    double _basicTotalS = 0;
    double _basicTotalQ = 0;
    double _basicTotalM = 0;
    if (BasicSA < 1000) {
        _basicTotalA = BasicAnnually_ + OccpLoadA_ + BasicHLAnnually_ + LSDAnnually_;
        _basicTotalS = BasicHalfYear_ + OccpLoadH_ + BasicHLHalfYear_ + LSDHalfYear_;
        _basicTotalQ = BasicQuarterly_ + OccpLoadQ_ + BasicHLQuarterly_ + LSDQuarterly_;
        _basicTotalM = BasicMonthly_ + OccpLoadM_ + BasicHLMonthly_ + LSDMonthly_;
        
    } else {
        _basicTotalA = BasicAnnually_ + OccpLoadA_ + BasicHLAnnually_ - LSDAnnually_;
        _basicTotalS = BasicHalfYear_ + OccpLoadH_ + BasicHLHalfYear_ - LSDHalfYear_;
        _basicTotalQ = BasicQuarterly_ + OccpLoadQ_ + BasicHLQuarterly_ - LSDQuarterly_;
        _basicTotalM = BasicMonthly_ + OccpLoadM_ + BasicHLMonthly_ - LSDMonthly_;
    }
    
    NSString *basicTotalA = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalA]];
    NSString *basicTotalS = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalS]];
    NSString *basicTotalQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalQ]];
    NSString *basicTotalM = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalM]];
    
    basicPremAnn = [[basicTotalA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremHalf = [[basicTotalS stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremQuar = [[basicTotalQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremMonth = [[basicTotalM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
//    NSLog(@"TAP A:%.2f, S:%.2f, Q:%.2f, M:%.2f",basicPremAnn,basicPremHalf,basicPremQuar,basicPremMonth);
}

-(void)calculateRiderPrem
{
    annualRiderPrem = [[NSMutableArray alloc] init];
    halfRiderPrem = [[NSMutableArray alloc] init];
    quarterRiderPrem = [[NSMutableArray alloc] init];
    monthRiderPrem = [[NSMutableArray alloc] init];
    
    waiverRiderAnn = [[NSMutableArray alloc] init];
    waiverRiderHalf = [[NSMutableArray alloc] init];
    waiverRiderQuar = [[NSMutableArray alloc] init];
    waiverRiderMonth = [[NSMutableArray alloc] init];
    waiverRiderAnn2 = [[NSMutableArray alloc] init];
    waiverRiderHalf2 = [[NSMutableArray alloc] init];
    waiverRiderQuar2 = [[NSMutableArray alloc] init];
    waiverRiderMonth2 = [[NSMutableArray alloc] init];
    
    annualMedRiderPrem = [[NSMutableArray alloc] init];
    halfMedRiderPrem = [[NSMutableArray alloc] init];
    quarterMedRiderPrem = [[NSMutableArray alloc] init];
    monthMedRiderPrem = [[NSMutableArray alloc] init];
    
    incomeRiderCode = [[NSMutableArray alloc] init];
    incomeRiderTerm = [[NSMutableArray alloc] init];
    incomeRiderAnn = [[NSMutableArray alloc] init];
    incomeRiderHalf = [[NSMutableArray alloc] init];
    incomeRiderQuar = [[NSMutableArray alloc] init];
    incomeRiderMonth = [[NSMutableArray alloc] init];
    incomeRiderSA = [[NSMutableArray alloc] init];
    incomeRiderCSV = [[NSMutableArray alloc] init];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSUInteger i;
    NSString *RidCode;
    for (i=0; i<[LRiderCode count]; i++) {        
        RidCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:i]];
        
        //getpentacode
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if ([RidCode isEqualToString:@"C+"])
            {
                if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Level"]) {
                    plnOptC = @"L";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Increasing"]) {
                    plnOptC = @"I";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Level_NCB"]) {
                    plnOptC = @"B";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Increasing_NCB"]) {
                    plnOptC = @"N";
                }
                
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"C+\" AND PlanOption=\"%@\"",plnOptC];
            }
            else if ([RidCode isEqualToString:@"HMM"])
            {
                planOptHMM = [LPlanOpt objectAtIndex:i];
                deducHMM = [LDeduct objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HMM\" AND PlanOption=\"%@\" AND Deductible=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",planOptHMM,deducHMM,[LAge objectAtIndex:i],[LAge objectAtIndex:i]];
            }
            else if ([RidCode isEqualToString:@"HSP_II"])
            {
                if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Standard"]) {
                    planHSPII = @"S";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Deluxe"]) {
                    planHSPII = @"D";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Premier"]) {
                    planHSPII = @"P";
                }
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HSP_II\" AND PlanOption=\"%@\"",planHSPII];
            }
            else if ([RidCode isEqualToString:@"MG_II"])
            {
                planMGII = [LPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_II\" AND PlanOption=\"%@\"",planMGII];
            }
            else if ([RidCode isEqualToString:@"I20R"] || [RidCode isEqualToString:@"I30R"] || [RidCode isEqualToString:@"I40R"] || [RidCode isEqualToString:@"ID20R"] || [RidCode isEqualToString:@"ID30R"] || [RidCode isEqualToString:@"ID40R"] || [RidCode isEqualToString:@"IE20R"] || [RidCode isEqualToString:@"IE30R"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",[LRiderCode objectAtIndex:i],getMOP];
                
            }
            else if ([RidCode isEqualToString:@"ICR"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"ICR\" AND Smoker=\"%@\"",[LSmoker objectAtIndex:i]];
                
            } else if ([RidCode isEqualToString:@"MG_IV"])
            {
                planMGIV = [LPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_IV\" AND PlanOption=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",planMGIV,[LAge objectAtIndex:i],[LAge objectAtIndex:i]];
            }
            else if ([RidCode isEqualToString:@"EDB"]||[RidCode isEqualToString:@"ETPDB"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\"",RidCode];
            }
            else if ([RidCode isEqualToString:@"CIWP"]||[RidCode isEqualToString:@"LCWP"]||[RidCode isEqualToString:@"PR"]||[RidCode isEqualToString:@"SP_STD"]||[RidCode isEqualToString:@"SP_PRE"]) {
                sqlite3_close(contactDB);
                continue;
            }
            else {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"",RidCode];
            }
            
            const char *query_stmt = [pentaSQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    
                    
                } else {
//                    NSLog(@"error access PentaPlanCode");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        int ridTerm = [[LTerm objectAtIndex:i] intValue];
        age = [[LAge objectAtIndex:i] intValue];
        sex = [[NSString alloc] initWithFormat:@"%@",[LSex objectAtIndex:i]];
        //get rate
        
        if ([RidCode isEqualToString:@"C+"])
        {            
            plnOptC = [LPlanOpt objectAtIndex:i];            
            [self getRiderRateAgeSexCplus:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i] planOptC:plnOptC];
        } else if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"ID20R"]||[RidCode isEqualToString:@"ID30R"]||[RidCode isEqualToString:@"ID40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"]) {
            [self getRiderRateAge:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i] ];
        } else if ([RidCode isEqualToString:@"CPA"]) {
            [self getRiderRateClass:RidCode riderTerm:ridTerm ];
        } else if ([RidCode isEqualToString:@"HSP_II"]) {
            planHSPII = [LPlanOpt objectAtIndex:i];
            [self getRiderRateAgeClassHSP_II:RidCode riderTerm:ridTerm planHSPII:planHSPII fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]]; //fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]
        } else if([RidCode isEqualToString:@"PA"] ) {
            [self getRiderRateAgeClassPA:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]]; //fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]
        } else if ([RidCode isEqualToString:@"HB"]) {
            [self getRiderRateClass:RidCode riderTerm:ridTerm];
        } else if ([RidCode isEqualToString:@"MG_IV"]) {
            [self getRiderRateAgeSexClassMG_IV:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i] planOption:planMGIV];
        } else if ([RidCode isEqualToString:@"MG_II"]) {
            [self getRiderRateAgeSexClassMG_II:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i] planOption:planMGII];
        } else if ([RidCode isEqualToString:@"HMM"]) {
            [self getRiderRateAgeSexClassHMM:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i] planOption:planOptHMM hmm:[LDeduct objectAtIndex:i]];
        } else if ([RidCode isEqualToString:@"EDB"] ||[RidCode isEqualToString:@"ETPDB"]) {
            [self getRiderRateSex:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]];
        } else {
            [self getRiderRateAgeSex:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]];
        }
        
        double ridSA = [[LSumAssured objectAtIndex:i] doubleValue];
        double riderHLoad = 0;
        double riderTempHLoad = 0;
                
        if ([[LRidHL1K objectAtIndex:i] doubleValue] > 0) {
            
            riderHLoad = [[LRidHL1K objectAtIndex:i] doubleValue];
        }
        else if ([[LRidHL100 objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[LRidHL100 objectAtIndex:i] doubleValue];
        }
        else if ([[LRidHLP objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[LRidHLP objectAtIndex:i] doubleValue];
        }
        
        if ([[LTempRidHL1K objectAtIndex:i] doubleValue] > 0) {
            riderTempHLoad = [[LTempRidHL1K objectAtIndex:i] doubleValue];
        }
        NSLog(@"~riderRate(%@):%.2f, ridersum:%.3f, HL:%.3f, TempHL:%.3f",[LRiderCode objectAtIndex:i],riderRate,ridSA,riderHLoad, riderTempHLoad);
        
        double annFac;
        double halfFac;
        double quarterFac;
        double monthFac;
        if ([RidCode isEqualToString:@"HB"]) {
            annFac = 1;
            halfFac = 0.55;
            quarterFac = 0.3;		
            monthFac = 0.1;
        }
        else {
            annFac = 1;
            halfFac = 0.5125;
            quarterFac = 0.2625;
            monthFac = 0.0875;
        }
        
        //calculate occupationLoading
        pTypeOccp = [LOccpCode objectAtIndex:i];
        [self getOccLoadRider];
//        NSLog(@"occpLoadRateb(%@):%d",RidCode,occLoadRider);
        
        double annualRider = 0;
        double halfYearRider = 0;
        double quarterRider = 0;
        double monthlyRider = 0;
        if ([RidCode isEqualToString:@"TPDYLA"])
        {
            double _ann = (riderRate *ridSA /100 *annFac);
            double _half = (riderRate *ridSA /100 *halfFac);
            double _quar = (riderRate *ridSA /100 *quarterFac);
            double _month = (riderRate *ridSA /100 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad /10 *ridSA /100 *annFac);
            double _HLHalf = (riderHLoad /10 *ridSA /100 *halfFac);
            double _HLQuar = (riderHLoad /10 *ridSA /100 *quarterFac);
            double _HLMonth = (riderHLoad /10 *ridSA /100 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad /10 *ridSA /100 *annFac);
            double _TempHLHalf = (riderTempHLoad /10 *ridSA /100 *halfFac);
            double _TempHLQuar = (riderTempHLoad /10 *ridSA /100 *quarterFac);
            double _TempHLMonth = (riderTempHLoad /10 *ridSA /100 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end--
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm + 1))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ICR"])
        {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ID20R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 20))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ID30R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 30))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ID40R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 40))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"HSP_II"]||[RidCode isEqualToString:@"HMM"])
        {
            annualRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * annFac;
            halfYearRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * halfFac;
            quarterRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * quarterFac;
            monthlyRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * monthFac;
        }
        else if ([RidCode isEqualToString:@"HB"])
        {
            int selectUnit = [[LUnits objectAtIndex:i] intValue];
            annualRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * annFac;
            halfYearRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * halfFac;
            quarterRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * quarterFac;
            monthlyRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * monthFac;
        }
        else if ([RidCode isEqualToString:@"CIR"]||[RidCode isEqualToString:@"C+"])
        {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"EDB"] || [RidCode isEqualToString:@"ETPDB"]) {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double calLoadA = occLoadRider *3 *ridSA /1000 *annFac;
            double calLoadH = occLoadRider *3 *ridSA /1000 *halfFac;
            double calLoadQ = occLoadRider *3 *ridSA /1000 *quarterFac;
            double calLoadM = occLoadRider *3 *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + ([strLoadA doubleValue]) + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + ([strLoadH doubleValue]) + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + ([strLoadQ doubleValue]) + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + ([strLoadM doubleValue]) + _allRiderHLMonth;
        }
        else {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            double calLoadA = occLoadRider *ridSA /1000 *annFac;
            double calLoadH = occLoadRider *ridSA /1000 *halfFac;
            double calLoadQ = occLoadRider *ridSA /1000 *quarterFac;
            double calLoadM = occLoadRider *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            annualRider = [str_ann doubleValue] + ([strLoadA doubleValue]) + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + ([strLoadH doubleValue]) + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + ([strLoadQ doubleValue]) + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + ([strLoadM doubleValue]) + _allRiderHLMonth;
        }
        
        NSString *calRiderAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:annualRider]];
        NSString *calRiderHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:halfYearRider]];
        NSString *calRiderQuarter = [formatter stringFromNumber:[NSNumber numberWithDouble:quarterRider]];
        NSString *calRiderMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:monthlyRider]];
        calRiderAnn = [calRiderAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderHalf = [calRiderHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderQuarter = [calRiderQuarter stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderMonth = [calRiderMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
        [annualRiderPrem addObject:calRiderAnn];
        [halfRiderPrem addObject:calRiderHalf];
        [quarterRiderPrem addObject:calRiderQuarter];
        [monthRiderPrem addObject:calRiderMonth];
//        NSLog(@"RiderTotal(%@) A:%@, S:%@, Q:%@, M:%@",[LRiderCode objectAtIndex:i],calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        
        //for waiver CIWP
        if (!([RidCode isEqualToString:@"ACIR_MPP"]) && !([RidCode isEqualToString:@"LCPR"]) && !([RidCode isEqualToString:@"CIR"]) && !([RidCode isEqualToString:@"PR"]) && !([RidCode isEqualToString:@"LCWP"]) && !([RidCode isEqualToString:@"SP_STD"]) && !([RidCode isEqualToString:@"SP_PRE"]) && !([RidCode isEqualToString:@"CIWP"]) && !([RidCode isEqualToString:@"ICR"])) {
            
            [waiverRiderAnn addObject:calRiderAnn];
            [waiverRiderHalf addObject:calRiderHalf];
            [waiverRiderQuar addObject:calRiderQuarter];
            [waiverRiderMonth addObject:calRiderMonth];
            //            NSLog(@"waiver1 insert(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        }
        
        //for other waiver
        if (!([RidCode isEqualToString:@"PLCP"]) && !([RidCode isEqualToString:@"CIWP"]) && !([RidCode isEqualToString:@"LCWP"]) && !([RidCode isEqualToString:@"SP_STD"]) && !([RidCode isEqualToString:@"SP_PRE"]) && !([RidCode isEqualToString:@"PR"]) && !([RidCode isEqualToString:@"PTR"])) {
            
            [waiverRiderAnn2 addObject:calRiderAnn];
            [waiverRiderHalf2 addObject:calRiderHalf];
            [waiverRiderQuar2 addObject:calRiderQuarter];
            [waiverRiderMonth2 addObject:calRiderMonth];
            //            NSLog(@"waiver2 insert(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        }
        
        //for medical rider
        if ([RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"HSP_II"]||[RidCode isEqualToString:@"HMM"]||[RidCode isEqualToString:@"HB"]||[RidCode isEqualToString:@"CIR"]|| [RidCode isEqualToString:@"ACIR_MPP"]||[RidCode isEqualToString:@"C+"]) {
            [annualMedRiderPrem addObject:calRiderAnn];
            [halfMedRiderPrem addObject:calRiderHalf];
            [quarterMedRiderPrem addObject:calRiderQuarter];
            [monthMedRiderPrem addObject:calRiderMonth];
            //            NSLog(@"medical insert(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        }
        
        //for income rider
        if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"]||[RidCode isEqualToString:@"ID20R"]||[RidCode isEqualToString:@"ID30R"]||[RidCode isEqualToString:@"ID40R"]) {
            
            [incomeRiderCode addObject:RidCode];
            [incomeRiderTerm addObject:[NSString stringWithFormat:@"%d",ridTerm]];
            [incomeRiderSA addObject:[NSString stringWithFormat:@"%.2f",ridSA]];
            [incomeRiderAnn addObject:calRiderAnn];
            [incomeRiderHalf addObject:calRiderHalf];
            [incomeRiderQuar addObject:calRiderQuarter];
            [incomeRiderMonth addObject:calRiderMonth];
//            NSLog(@"income insert(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
            
            //get CSV rate
            [self getRiderCSV:RidCode];
            NSString *csv = [NSString stringWithFormat:@"%.2f",riderCSVRate];
            [incomeRiderCSV addObject:csv];
        }
    }
    
    annualRiderSum = 0;
    halfRiderSum = 0;
    quarterRiderSum = 0;
    monthRiderSum = 0;
    NSUInteger a;
    for (a=0; a<[annualRiderPrem count]; a++) {
        annualRiderSum = annualRiderSum + [[annualRiderPrem objectAtIndex:a] doubleValue];
        halfRiderSum = halfRiderSum + [[halfRiderPrem objectAtIndex:a] doubleValue];
        quarterRiderSum = quarterRiderSum + [[quarterRiderPrem objectAtIndex:a] doubleValue];
        monthRiderSum = monthRiderSum + [[monthRiderPrem objectAtIndex:a] doubleValue];
    }
    riderPrem = annualRiderSum;
    //    NSLog(@"RiderPrem:%.2f",riderPrem);
}

-(void)calculateWaiver
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    double waiverAnnSum = 0;
    double waiverHalfSum = 0;
    double waiverQuarSum = 0;
    double waiverMonthSum = 0;
    for (NSUInteger m=0; m<[waiverRiderAnn count]; m++) {
        waiverAnnSum = waiverAnnSum + [[waiverRiderAnn objectAtIndex:m] doubleValue];
        waiverHalfSum = waiverHalfSum + [[waiverRiderHalf objectAtIndex:m] doubleValue];
        waiverQuarSum = waiverQuarSum + [[waiverRiderQuar objectAtIndex:m] doubleValue];
        waiverMonthSum = waiverMonthSum + [[waiverRiderMonth objectAtIndex:m] doubleValue];
    }
    
    double waiverAnnSum2 = 0;
    double waiverHalfSum2 = 0;
    double waiverQuarSum2 = 0;
    double waiverMonthSum2 = 0;
    for (NSUInteger m=0; m<[waiverRiderAnn2 count]; m++) {
        waiverAnnSum2 = waiverAnnSum2 + [[waiverRiderAnn2 objectAtIndex:m] doubleValue];
        waiverHalfSum2 = waiverHalfSum2 + [[waiverRiderHalf2 objectAtIndex:m] doubleValue];
        waiverQuarSum2 = waiverQuarSum2 + [[waiverRiderQuar2 objectAtIndex:m] doubleValue];
        waiverMonthSum2 = waiverMonthSum2 + [[waiverRiderMonth2 objectAtIndex:m] doubleValue];
    }
    
    NSMutableArray *waiverRidAnnTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidHalfTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidQuarTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidMonthTol = [[NSMutableArray alloc] init];
    
    NSUInteger i;
    NSString *RidCode;
    for (i=0; i<[LRiderCode count]; i++) {
        
        RidCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:i]];
        
        //getpentacode
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            if ([RidCode isEqualToString:@"CIWP"]||[RidCode isEqualToString:@"LCWP"]||[RidCode isEqualToString:@"PR"]||[RidCode isEqualToString:@"SP_STD"]||[RidCode isEqualToString:@"SP_PRE"]) {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"",RidCode];
            }
            else {
                sqlite3_close(contactDB);
                continue;
            }
            
            if (sqlite3_prepare_v2(contactDB, [pentaSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                }
                else {
//                    NSLog(@"error access PentaPlanCode");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        else {
            sqlite3_close(contactDB);
        }
        
        int ridTerm = [[LTerm objectAtIndex:i] intValue];
        age = [[LAge objectAtIndex:i] intValue];
        sex = [[NSString alloc] initWithFormat:@"%@",[LSex objectAtIndex:i]];
        
        //get rate
        [self getRiderRateAgeSex:RidCode riderTerm:ridTerm fromAge:[LAge objectAtIndex:i] toAge:[LAge objectAtIndex:i]];
        
        double ridSA = [[LSumAssured objectAtIndex:i] doubleValue];
        double riderHLoad = 0;
        double riderTempHLoad = 0;
        
        if ([[LRidHL1K objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[LRidHL1K objectAtIndex:i] doubleValue];
        }
        else if ([[LRidHL100 objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[LRidHL100 objectAtIndex:i] doubleValue];
        }
        else if ([[LRidHLP objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[LRidHLP objectAtIndex:i] doubleValue];
        }
        
        if ([[LTempRidHL1K objectAtIndex:i] doubleValue] > 0) {
            riderTempHLoad = [[LTempRidHL1K objectAtIndex:i] doubleValue];
        }
//        NSLog(@"~waiverRate(%@):%.2f, waiverSum:%.3f, HL:%.3f, TempHL:%.3f",RidCode,riderRate,ridSA,riderHLoad,riderTempHLoad);
        
        double annFac = 1;
        double halfFac = 0.5125;
        double quarterFac = 0.2625;
        double monthFac = 0.0875;
        
        //calculate occupationLoading
        pTypeOccp = [LOccpCode objectAtIndex:i];
        [self getOccLoadRider];
//        NSLog(@"occpLoadRate:%d",occLoadRider);
        
        double annualRider;
        double halfYearRider;
        double quarterRider;
        double monthlyRider;
        if ([RidCode isEqualToString:@"CIWP"])
        {
            double waiverAnnPrem = ridSA/100 * (waiverAnnSum+basicPremAnn);
            double waiverHalfPrem = ridSA/100 * (waiverHalfSum+basicPremHalf) *2;
            double waiverQuarPrem = ridSA/100 * (waiverQuarSum+basicPremQuar) *4;
            double waiverMonthPrem = ridSA/100 * (waiverMonthSum+basicPremMonth) *12;
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverAnnPrem]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverHalfPrem]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverQuarPrem]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverMonthPrem]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
//            NSLog(@"waiverSA A:%@, S:%@, Q:%@, M:%@",str_ann,str_half,str_quar,str_month);
            
            double annualRider_ = [str_ann doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double halfYearRider_ = [str_half doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double quarterRider_ = [str_quar doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double monthlyRider_ = [str_month doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
//            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
            annualRider = annualRider_ * annFac;
            halfYearRider = halfYearRider_ * halfFac;
            quarterRider = quarterRider_ * quarterFac;
            monthlyRider = monthlyRider_ * monthFac;
        }
        else if ([RidCode isEqualToString:@"LCWP"]||[RidCode isEqualToString:@"PR"]||[RidCode isEqualToString:@"SP_STD"]||[RidCode isEqualToString:@"SP_PRE"])
        {
            double waiverAnnPrem = ridSA/100 * (waiverAnnSum2+basicPremAnn);
            double waiverHalfPrem = ridSA/100 * (waiverHalfSum2+basicPremHalf) *2;
            double waiverQuarPrem = ridSA/100 * (waiverQuarSum2+basicPremQuar) *4;
            double waiverMonthPrem = ridSA/100 * (waiverMonthSum2+basicPremMonth) *12;
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverAnnPrem]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverHalfPrem]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverQuarPrem]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverMonthPrem]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
//            NSLog(@"waiverSA A:%@, S:%@, Q:%@, M:%@",str_ann,str_half,str_quar,str_month);
            
            double annualRider_ = [str_ann doubleValue] * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double halfYearRider_ = [str_half doubleValue] * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double quarterRider_ = [str_quar doubleValue] * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double monthlyRider_ = [str_month doubleValue] * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
//            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
            annualRider = annualRider_ * annFac;
            halfYearRider = halfYearRider_ * halfFac;
            quarterRider = quarterRider_ * quarterFac;
            monthlyRider = monthlyRider_ * monthFac;
        }
        else {
            annualRider = 0;
            halfYearRider = 0;
            quarterRider = 0;
            monthlyRider = 0;
        }
        
        NSString *calRiderAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:annualRider]];
        NSString *calRiderHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:halfYearRider]];
        NSString *calRiderQuarter = [formatter stringFromNumber:[NSNumber numberWithDouble:quarterRider]];
        NSString *calRiderMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:monthlyRider]];
        calRiderAnn = [calRiderAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderHalf = [calRiderHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderQuarter = [calRiderQuarter stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderMonth = [calRiderMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        [waiverRidAnnTol addObject:calRiderAnn];
        [waiverRidHalfTol addObject:calRiderHalf];
        [waiverRidQuarTol addObject:calRiderQuarter];
        [waiverRidMonthTol addObject:calRiderMonth];
//        NSLog(@":waiverTotal(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
    }
    
    for (int i=0; i<[waiverRidAnnTol count]; i++) {        
        annualRiderSum = annualRiderSum + [[waiverRidAnnTol objectAtIndex:i] doubleValue];
        halfRiderSum = halfRiderSum + [[waiverRidHalfTol objectAtIndex:i] doubleValue];
        quarterRiderSum = quarterRiderSum + [[waiverRidQuarTol objectAtIndex:i] doubleValue];
        monthRiderSum = monthRiderSum + [[waiverRidMonthTol objectAtIndex:i] doubleValue];
        NSLog(@"allRiderSum A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRiderSum,halfRiderSum,quarterRiderSum,monthRiderSum);
    }
    riderPrem = annualRiderSum;
    double totalPrem = riderPrem + basicPremAnn;
    NSLog(@"RiderPrem:%.2f totalPrem:%.2f",riderPrem,totalPrem);
}

-(void)calculateMedRiderPrem
{
    if (annualMedRiderPrem.count != 0) {        
        annualMedRiderSum = 0;
        halfMedRiderSum = 0;
        quarterMedRiderSum = 0;
        monthMedRiderSum = 0;
        for (NSUInteger a=0; a<[annualMedRiderPrem count]; a++) {
            annualMedRiderSum = annualMedRiderSum + [[annualMedRiderPrem objectAtIndex:a] doubleValue];
            halfMedRiderSum = halfMedRiderSum + [[halfMedRiderPrem objectAtIndex:a] doubleValue];
            quarterMedRiderSum = quarterMedRiderSum + [[quarterMedRiderPrem objectAtIndex:a] doubleValue];
            monthMedRiderSum = monthMedRiderSum + [[monthMedRiderPrem objectAtIndex:a] doubleValue];
        }
        medRiderPrem = annualMedRiderSum;
//        NSLog(@"medPrem:%.2f",medRiderPrem);
    }
    else {
//        NSLog(@"non exist medical rider!");
        medRiderPrem = 0;
    }
}

-(void)calculateIncomeRider
{
    if (incomeRiderAnn.count > 0) {
        double sumIncomeAnn = 0;
        double sumIncomeHalf = 0;
        double sumIncomeQuart = 0;
        double sumIncomeMonth = 0;
        for (NSUInteger k=0; k<[incomeRiderAnn count]; k++) {
            sumIncomeAnn = sumIncomeAnn + [[incomeRiderAnn objectAtIndex:k] doubleValue];
            sumIncomeHalf = sumIncomeHalf + [[incomeRiderHalf objectAtIndex:k] doubleValue];
            sumIncomeQuart = sumIncomeQuart +[[incomeRiderQuar objectAtIndex:k] doubleValue];
            sumIncomeMonth = sumIncomeMonth + [[incomeRiderMonth objectAtIndex:k] doubleValue];
        }
        incomeRiderPrem = sumIncomeAnn;
        NSLog(@"incomeRiderPrem:%.2f",incomeRiderPrem);
    }
    else {
        NSLog(@"non exist income rider!");
        incomeRiderPrem = 0;
    }
}

-(void)calculateIncomeRiderInput
{    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //getpentacode
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",riderCode,getMOP];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
            } else {
                NSLog(@"error access PentaPlanCode");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    int ridTerm = [termField.text intValue];
    age = getAge;
    sex = getSex;
    
    //get rate
    NSString *ageStr = [NSString stringWithFormat:@"%d",age];
    [self getRiderRateAge:riderCode riderTerm:ridTerm fromAge:ageStr toAge:ageStr];
    
    //    double BasicSA = getBasicSA;
    double ridSA = [sumField.text doubleValue];
    double riderHLoad = [HLField.text doubleValue];
    double riderTempHLoad = [tempHLField.text doubleValue];
    
    double annFac = 1;
    double halfFac = 0.5125;
    double quarterFac = 0.2625;
    double monthFac = 0.0875;
    
    double annualRider;
    double halfYearRider;
    double quarterRider;
    double monthlyRider;
    if ([riderCode isEqualToString:@"I20R"]||[riderCode isEqualToString:@"I30R"]||[riderCode isEqualToString:@"I40R"]||[riderCode isEqualToString:@"IE20R"]||[riderCode isEqualToString:@"IE30R"])
    {
        //--Occp Load
        double occLoadFactorA = occLoadRider * (((double)(ridTerm + 1))/2);
        double occLoadFactorH = occLoadRider * (((double)(ridTerm + 1))/2);
        double occLoadFactorQ = occLoadRider * (((double)(ridTerm + 1))/2);
        double occLoadFactorM = occLoadRider * (((double)(ridTerm + 1))/2);
        
        double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
        double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
        double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
        double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
        NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
        NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
        NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
        NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
        strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
        //--end
        
        annualRider = (riderRate *ridSA /1000 *annFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *annFac) + (riderTempHLoad *ridSA /1000 *annFac);
        halfYearRider = (riderRate *ridSA /1000 *halfFac) + ([strLoadH doubleValue]) + (riderHLoad *ridSA /1000 *halfFac) + (riderTempHLoad *ridSA /1000 *halfFac);
        quarterRider = (riderRate *ridSA /1000 *quarterFac) + ([strLoadQ doubleValue]) + (riderHLoad *ridSA /1000 *quarterFac) + (riderTempHLoad *ridSA /1000 *quarterFac);
        monthlyRider = (riderRate *ridSA /1000 *monthFac) + ([strLoadM doubleValue]) + (riderHLoad *ridSA /1000 *monthFac) + (riderTempHLoad *ridSA /1000 *monthFac);
    }
    if ([riderCode isEqualToString:@"ID20R"])
    {
        double occLoadFactorA = occLoadRider * (((double)(ridTerm - 20))/2);
        double occLoadFactorH = occLoadRider * (((double)(ridTerm - 20))/2);
        double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 20))/2);
        double occLoadFactorM = occLoadRider * (((double)(ridTerm - 20))/2);
        
        double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
        double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
        double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
        double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
        NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
        NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
        NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
        NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
        strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        annualRider = (riderRate *ridSA /1000 *annFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *annFac) + (riderTempHLoad *ridSA /1000 *annFac);
        halfYearRider = (riderRate *ridSA /1000 *halfFac) + ([strLoadH doubleValue]) + (riderHLoad *ridSA /1000 *halfFac) + (riderTempHLoad *ridSA /1000 *halfFac);
        quarterRider = (riderRate *ridSA /1000 *quarterFac) + ([strLoadQ doubleValue]) + (riderHLoad *ridSA /1000 *quarterFac) + (riderTempHLoad *ridSA /1000 *quarterFac);
        monthlyRider = (riderRate *ridSA /1000 *monthFac) + ([strLoadM doubleValue]) + (riderHLoad *ridSA /1000 *monthFac) + (riderTempHLoad *ridSA /1000 *monthFac);
    }
    else if ([riderCode isEqualToString:@"ID30R"])
    {
        double occLoadFactorA = occLoadRider * (((double)(ridTerm - 30))/2);
        double occLoadFactorH = occLoadRider * (((double)(ridTerm - 30))/2);
        double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 30))/2);
        double occLoadFactorM = occLoadRider * (((double)(ridTerm - 30))/2);
        
        double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
        double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
        double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
        double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
        NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
        NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
        NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
        NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
        strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        annualRider = (riderRate *ridSA /1000 *annFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *annFac) + (riderTempHLoad *ridSA /1000 *annFac);
        halfYearRider = (riderRate *ridSA /1000 *halfFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *halfFac) + (riderTempHLoad *ridSA /1000 *halfFac);
        quarterRider = (riderRate *ridSA /1000 *quarterFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *quarterFac) + (riderTempHLoad *ridSA /1000 *quarterFac);
        monthlyRider = (riderRate *ridSA /1000 *monthFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *monthFac) + (riderTempHLoad *ridSA /1000 *monthFac);
    }
    else if ([riderCode isEqualToString:@"ID40R"])
    {
        double occLoadFactorA = occLoadRider * (((double)(ridTerm - 40))/2);
        double occLoadFactorH = occLoadRider * (((double)(ridTerm - 40))/2);
        double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 40))/2);
        double occLoadFactorM = occLoadRider * (((double)(ridTerm - 40))/2);
        
        double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
        double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
        double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
        double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
        NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
        NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
        NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
        NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
        strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
        strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        annualRider = (riderRate *ridSA /1000 *annFac) + ([strLoadA doubleValue]) + (riderHLoad *ridSA /1000 *annFac) + (riderTempHLoad *ridSA /1000 *annFac);
        halfYearRider = (riderRate *ridSA /1000 *halfFac) + ([strLoadH doubleValue]) + (riderHLoad *ridSA /1000 *halfFac) + (riderTempHLoad *ridSA /1000 *halfFac);
        quarterRider = (riderRate *ridSA /1000 *quarterFac) + ([strLoadQ doubleValue]) + (riderHLoad *ridSA /1000 *quarterFac) + (riderTempHLoad *ridSA /1000 *quarterFac);
        monthlyRider = (riderRate *ridSA /1000 *monthFac) + ([strLoadM doubleValue]) + (riderHLoad *ridSA /1000 *monthFac) + (riderTempHLoad *ridSA /1000 *monthFac);
    }
    
    //edited by heng to avoid negative yield
    [self getRiderCSV:riderCode];       //get CSV rate 
    inputCSV = riderCSVRate;
    
    NSString *calRiderAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:annualRider]];
    NSString *calRiderHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:halfYearRider]];
    NSString *calRiderQuarter = [formatter stringFromNumber:[NSNumber numberWithDouble:quarterRider]];
    NSString *calRiderMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:monthlyRider]];
    calRiderAnn = [calRiderAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
    calRiderHalf = [calRiderHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
    calRiderQuarter = [calRiderQuarter stringByReplacingOccurrencesOfString:@"," withString:@""];
    calRiderMonth = [calRiderMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
    inputIncomeAnn = [calRiderAnn doubleValue];
    NSLog(@"inputIncomeRiderTot(%@) A:%@, S:%@, Q:%@, M:%@",riderCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
}


#pragma mark - Action

- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)btnPTypePressed:(id)sender
{    
    if(_PTypeList == nil){
        self.PTypeList = [[RiderPTypeTbViewController alloc] initWithString:getSINo str:@"TRAD"];
        self.PTypeList.TradOrEver = @"TRAD";
        _PTypeList.delegate = self;
        self.pTypePopOver = [[UIPopoverController alloc] initWithContentViewController:_PTypeList];        
    }
    
    CGRect rect = [sender frame];
	rect.origin.y = [sender frame].origin.y + 30;
    
    [self.pTypePopOver setPopoverContentSize:CGSizeMake(350.0f, 400.0f)];
    [self.pTypePopOver presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    

}

- (IBAction)btnAddRiderPressed:(id)sender
{
    if ([occLoadType isEqualToString:@"D"]) {
        NSString *msg = nil;
        if ([pTypeCode isEqualToString:@"PY"]) {
            msg = @"Payor is not qualified to add any rider";
        }
        
        if (PTypeSeq == 2) {
            msg = @"2nd Life Assured is not qualified to add any rider";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else {
        Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
        [activeInstance performSelector:@selector(dismissKeyboard)];
        
        if(_RiderList == Nil){
            self.RiderList = [[RiderListTbViewController alloc] initWithStyle:UITableViewStylePlain];
            _RiderList.delegate = self;
            _RiderList.TradOrEver = @"TRAD";
            _RiderList.requestPtype = self.pTypeCode;
            _RiderList.requestPlan = getPlanChoose;
            _RiderList.requestSeq = self.PTypeSeq;
            _RiderList.requestOccpClass = self.requestOccpClass;
            _RiderList.requestAge = self.pTypeAge;
            _RiderList.requestOccpCat = self.OccpCat;
            _RiderList.requestCovPeriod = requestCoverTerm;
            _RiderList.requestOccpCPA = [NSString stringWithFormat:@"%d", occCPA ];
            if (requesteEDD == TRUE) {
                _RiderList.requestEDD = TRUE;
            } else {
               _RiderList.requestEDD = FALSE;
            }
            self.RiderListPopover = [[UIPopoverController alloc] initWithContentViewController:_RiderList];
        }
                
        if(_RiderList.isRiderListEmpty)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Unable to attach Rider" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            CGRect rect = [sender frame];
            rect.origin.y = [sender frame].origin.y + 30;
            
            [self.RiderListPopover setPopoverContentSize:CGSizeMake(600.0f, 400.0f)];
            [self.RiderListPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

- (IBAction)planBtnPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
    self.planList = [[RiderPlanTb alloc] initWithStyle:UITableViewStylePlain];
	
    if([getPlanChoose isEqualToString:@"HLACP"])
    {
        self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"TRAD" getPlanChoose:getPlanChoose];
    }
    else if([getPlanChoose isEqualToString:@"HLAWP"])
    {
        strSA = [NSString stringWithFormat:@"%.2f",getBasicSA * getMOP * [self getBasicSAFactor]];
        self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"TRAD" getPlanChoose:getPlanChoose];
    }
    else if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
    {
        NSString *strBasicSA = [NSString stringWithFormat:@"%g", getBasicSA];
        self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strBasicSA andOccpCat:OccpCat andTradOrEver:@"TRAD" getPlanChoose:getPlanChoose];
    }
    
    _planList.delegate = self;
    self.planPopover = [[UIPopoverController alloc] initWithContentViewController:_planList];
    
    CGRect rect = [sender frame];
	rect.origin.y = [sender frame].origin.y + 30;
    
    [self.planPopover setPopoverContentSize:CGSizeMake(350.0f, 400.0f)];
    [self.planPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)deducBtnPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
    self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:planOption];
    _deductList.delegate = self;
    self.deducPopover = [[UIPopoverController alloc] initWithContentViewController:_deductList];
    
    CGRect ww = [sender frame];
	ww.origin.y = [sender frame].origin.y + 30;
    
    [self.deducPopover setPopoverContentSize:CGSizeMake(350.0f, 400.0f)];
    [self.deducPopover presentPopoverFromRect:ww inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)doSaveRider:(id)sender
{
	[_delegate saveAll];
}

- (IBAction)editPressed:(id)sender
{
    [self resignFirstResponder];
    [self UpdateSIToInvalid];    
    if ([self.myTableView isEditing]) {
        [self.myTableView setEditing:NO animated:TRUE];
        deleteBtn.hidden = true;
        [editBtn setTitle:@"Edit" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        [self.myTableView setEditing:YES animated:TRUE];
        deleteBtn.hidden = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [editBtn setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
}

- (IBAction)deletePressed:(id)sender
{
    NSString *ridCode;
    int RecCount = 0;
    NSIndexPath *selectedIndexPath;
    for (UITableViewCell *cell in [myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            selectedIndexPath = [myTableView indexPathForCell:cell];
            if (RecCount == 0) {
                ridCode = [LTypeRiderCode objectAtIndex:selectedIndexPath.row];
            }
            
            RecCount = RecCount + 1;
            
            if (RecCount > 1) {
                break;
            }
        }
    }
    
    NSString *msg;
    if (RecCount == 1) {
        msg = [NSString stringWithFormat:@"Delete Rider:%@",ridCode];
    }
    else {
        msg = @"Are you sure want to delete these Rider(s)?";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1001];
    [alert show];
}

- (IBAction)btnSaveRiderPressed:(id)sender {
	if (Edit == TRUE ) {
        
        [self UpdateSIToInvalid];
		appDelegate.isNeedPromptSaveMsg = YES;
		
		[self resignFirstResponder];
		[self.view endEditing:YES];
		
		Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
		id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
		[activeInstance performSelector:@selector(dismissKeyboard)];
		
		[myTableView setEditing:FALSE];
		[self.myTableView setEditing:NO animated:TRUE];
		deleteBtn.hidden = true;
		[editBtn setTitle:@"Delete" forState:UIControlStateNormal ];
		
		for (int i=0; i<[FLabelCode count]; i++)
		{
			if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
				inputHL1KSA = [[NSString alloc]initWithFormat:@"%@",HLField.text];
			} else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10"]]) {
				inputHL100SA = [[NSString alloc]initWithFormat:@"%@",HLField.text];
			} else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
				inputHLPercentage = [[NSString alloc]initWithFormat:@"%@",HLField.text];
			}
			
			if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1KT"]]) {
				inputHL1KSATerm = [HLTField.text intValue];
			} else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10T"]]) {
				inputHL100SATerm = [HLTField.text intValue];
			} else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLPT"]]) {
				inputHLPercentageTerm = [HLTField.text intValue];
			}
		}
		
        [self getListingRider];
        
		if (riderCode.length == 0 || btnAddRider.titleLabel.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select a Rider." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		else if (term) {
			NSLog(@"validate - 1st term");
			[self validateTerm];
		}
		else if (sumA) {
			NSLog(@"validate - 2nd sum");
			[self validateSum];
		}
		else if (unit) {
			NSLog(@"validate - 3rd unit");
			[self validateUnit];
		}
		else {
			NSLog(@"validate - 4th save");
			[self validateSaver];
		}
        
        eAppCheckList*deleteOldPDF=[[eAppCheckList alloc] init];
        [deleteOldPDF deleteEAppCase:getSINo];
        deleteOldPDF = Nil;
    
        NSLog(@"delete eApp cases for sino %@", getSINo );
	}
}

//ACIR_MPP sum assured != BSA for L100
-(BOOL) isAllowedToAddRiderL100
{
    BOOL allowedToAdd = TRUE;
    NSString *choosenRid = riderCode;
    double riderSumAssured = 0;
    
    if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
    {        
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT sumAssured from trad_rider_details where SINO=\"%@\" and RiderCode=\"ACIR_MPP\"",requestSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    riderSumAssured =  sqlite3_column_double(statement, 0);
                }
                sqlite3_finalize(statement);
            }            
            
            sqlite3_close(contactDB);
        }
        
        if ([choosenRid isEqualToString:@"LCPR"] || [choosenRid isEqualToString:@"ICR"] || [choosenRid isEqualToString:@"ACIR_MPP"]  || [choosenRid isEqualToString:@"CIR"] || [choosenRid isEqualToString:@"SP_PRE"] || [choosenRid isEqualToString:@"SP_STD"] || [choosenRid isEqualToString:@"LCWP"] || [choosenRid isEqualToString:@"PLCP"] || [choosenRid isEqualToString:@"PR"] || [choosenRid isEqualToString:@"PTR"]   ) {
            allowedToAdd = TRUE;
        }
        else{
            if (getBasicSA == riderSumAssured) {
                allowedToAdd = FALSE;
            }
            else{
                allowedToAdd = TRUE;
            }
        }
        
        if(!allowedToAdd)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"This rider is not allowed as SA of ACIR is equivalent to BSA. Please reduce SA of ACIR or increase BSA to attach this rider." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if([getPlanChoose isEqualToString:@"HLACP"])
    {
        allowedToAdd = TRUE;
    }
    
    [self checkingRider];
    
    return allowedToAdd;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
        [self UpdateSIToInvalid];
		appDelegate.isNeedPromptSaveMsg = YES;
		
		Edit = TRUE;
        if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
        
        sqlite3_stmt *statement;
        NSArray *sorted = [[NSArray alloc] init ];
        sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
            return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
        }];
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            NSString *rider;
            NSString *querySQL;
            for(int a=0; a<sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;
                
                rider = [LTypeRiderCode objectAtIndex:value];
                querySQL = [NSString stringWithFormat:
                                      @"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,rider];
                
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"rider delete!");
						appDelegate.isNeedPromptSaveMsg = YES;
                    } else {
                        NSLog(@"rider delete Failed!");
                    }
                    sqlite3_finalize(statement);
                }
                
                [LTypeRiderCode removeObjectAtIndex:value];
                [LTypeSumAssured removeObjectAtIndex:value];
                [LTypeTerm removeObjectAtIndex:value];
                [LTypePlanOpt removeObjectAtIndex:value];
                [LTypeUnits removeObjectAtIndex:value];
                [LTypeDeduct removeObjectAtIndex:value];
                [LTypeRidHL1K removeObjectAtIndex:value];
                [LTypeRidHL100 removeObjectAtIndex:value];
                [LTypeRidHLP removeObjectAtIndex:value];
                [LTypeSmoker removeObjectAtIndex:value];
                [LTypeAge removeObjectAtIndex:value];
                
                if ([pTypeCode isEqualToString:@"PY"] && ([rider isEqualToString:@"LCWP"]||[rider isEqualToString:@"PR"])) {
                    [self checkPayorRider:rider];
                    
                    if (payorRidCode.length != 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert setTag:1007];
                        [alert show];
                    }
                }
            }
            sqlite3_close(contactDB);
        }
        
        [myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];        
        [self.myTableView reloadData];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
        
        [self validateRules];
        
        deleteBtn.enabled = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [_delegate RiderAdded];
		[self clearField];
		riderCode = @"";
		[self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
        
        eAppCheckList*deleteOldPDF=[[eAppCheckList alloc] init];
        [deleteOldPDF deleteEAppCase:getSINo];
        deleteOldPDF = Nil;
    
        NSLog(@"delete eApp cases for sino %@", getSINo );		
    }
    else if (alertView.tag == 1002 && buttonIndex == 0) //delete
    {
        [self deleteRider];
    }
    else if (alertView.tag == 1003 && buttonIndex == 0)
    {
        [self checkingRider];
        if (existRidCode.length == 0) {
            [self saveRider];
        } else {
            [self updateRider];
        }
    }
    else if (alertView.tag == 1004 && buttonIndex == 0)     //deleted 2nd LA rider
    {
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,secondLARidCode];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"rider %@ delete!",secondLARidCode);
                } else {
                    NSLog(@"rider delete Failed!");
                }
                sqlite3_finalize(statement);
            }
            
            NSString *querySQL2 = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"rider %@ delete!",riderCode);
                } else {
                    NSLog(@"rider delete Failed!");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        [self getListingRider];
        [self getListingRiderByType];
        [_delegate RiderAdded];
        secondLARidCode = nil;
    }
    else if (alertView.tag == 1005 && buttonIndex ==0)      //deleting due to business rule
    {
        [self getListingRiderByType];
        [self getListingRider];     
        
        [self calculateRiderPrem];
        [self calculateWaiver];
        [self calculateMedRiderPrem];
        
        [_delegate RiderAdded];
    }
    else if (alertView.tag == 1006 && buttonIndex == 0) //displayed label min/max
    {
        [self displayedMinMax];
    }
    else if (alertView.tag == 1007 && buttonIndex == 0) //deleted payor
    {
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,payorRidCode];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"rider delete!");
                } else {
                    NSLog(@"rider delete Failed!");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        [self validateRules];
    }
}

#pragma mark - validate

-(void)validateTerm
{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    BOOL HL1kTerm = NO;
    BOOL HL100kTerm = NO;
    BOOL HLPTerm = NO;
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++)
    {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1KT"]]) {
            HL1kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10T"]]) {
            HL100kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLPT"]]) {
            HLPTerm = YES;
        }
    }
    
    if (termField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [termField becomeFirstResponder];
    }
    else if ([termField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Rider Term must be numeric 0 to 9 only" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [termField becomeFirstResponder];
    }
    else if ([termField.text intValue] > maxRiderTerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Term must be less than or equal to %.f",maxRiderTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [termField becomeFirstResponder];
    }
    else if ([termField.text intValue] < minTerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Term must be greater than or equal to %d",minTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [termField becomeFirstResponder];
    }
    else if ([HLTField.text intValue] > [termField.text intValue]) {
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 100 SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) Term cannot be greater than %d",[termField.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if ([HLTField.text intValue] > getMOP && [self DifferentPaymentTerm:riderCode] == TRUE) { // for HLAWP Riders
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d", getMOP];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 100 SA) Term cannot be greater than %d",getMOP];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) Term cannot be greater than %d",getMOP];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if ([tempHLTField.text intValue] > [termField.text intValue] && [self DifferentPaymentTerm:riderCode] == FALSE ) {
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) Term cannot be greater than %d",[termField.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
    else if ([tempHLTField.text intValue] > getMOP && [self DifferentPaymentTerm:riderCode] == TRUE) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",getMOP];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) Term cannot be greater than %d",getMOP];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) Term cannot be greater than %d",getMOP];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
	else if ([HLField.text intValue] > 10000 && ![riderCode isEqualToString:@"HMM"] && ![riderCode isEqualToString:@"MG_IV"]
			 && ![riderCode isEqualToString:@"MG_II"] && ![riderCode isEqualToString:@"HSP_II"] && ![riderCode isEqualToString:@"HB"]) {
		
		NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) cannot be greater than 10000"];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 100 SA) cannot be greater than 10000"];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) cannot be greater than 500"];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
	}
	else if ([tempHLField.text intValue] > 10000 && ![riderCode isEqualToString:@"HMM"] && ![riderCode isEqualToString:@"MG_IV"]
			 && ![riderCode isEqualToString:@"MG_II"] && ![riderCode isEqualToString:@"HSP_II"] && ![riderCode isEqualToString:@"HB"]) {
		
		NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) cannot be greater than 10000"];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) cannot be greater than 10000"];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) cannot be greater than 500"];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ETPDB"] || [riderCode isEqualToString:@"EDB"]) && [termField.text intValue ] > 6 ) {
		NSString *msg;
		
		msg = @"Health Loading (per 1k SA) term cannot be greater than 6";
		
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
	}
    
	else if (sumA) {
        NSLog(@"validate - 1st sum");
        [self validateSum];
    } else if (unit) {
        NSLog(@"validate - 1st unit");
        
        [self validateUnit];
    } else {
        NSLog(@"validate - 1st save");
        [self validateSaver];
    }
}

-(void)validateSum
{
    NSLog(@"keyin SA:%.f,max:%.f",[sumField.text doubleValue],maxRiderSA);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSCharacterSet *setHLACP = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSRange rangeofDot = [sumField.text rangeOfString:@"."];
    NSString *substring = @"";
    
    double dSumField = -1;
    
    if (sumField.text.length <= 0) 
    {
        dSumField = -1;
    }else
    {
        dSumField = [sumField.text doubleValue];
    }
    
    NSString *msgGYI = nil;
    
    if([getPlanChoose isEqualToString:@"HLACP"])
    {
    
        msgGYI = @"Yearly Income";
    }
    else if([getPlanChoose isEqualToString:@"HLAWP"])
    {
        if ([riderCode isEqualToString:@"EDUWR"]) {
            msgGYI = @"Cash Payment";
        }
        else{
            msgGYI = @"Yearly Cash Coupons";
        }        
    }
    
    if (rangeofDot.location != NSNotFound) {
        substring = [sumField.text substringFromIndex:rangeofDot.location ];
    }
    
    if ([getPlanChoose isEqualToString:@"HLACP"] && [riderCode isEqualToString:@"TPDYLA"] && getBasicSA < 2500 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Min RSA for TPDYLA is RM 5,000. Please increase the Desired Annual Premium to a minimum of RM 2,500." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
    }
    else if ([getPlanChoose isEqualToString:@"HLAWP"] && [riderCode isEqualToString:@"TPDYLA"] && (getBasicSA * (0.25 * getMOP * [self getBasicSAFactor]) < 5000 )) {
        int tempToIncrease = ceil(5000/(0.25 * getMOP * [self getBasicSAFactor]));
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"The minimum Rider Sum Assured for TPD Yearly Living Allowance is RM 5,000. To attach the rider, please increase the Desired Annual Premium to at least RM%d.", tempToIncrease] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
    }
    else if ([getPlanChoose isEqualToString:@"HLACP"] && [riderCode isEqualToString:@"ICR"] && getBasicSA < 5000 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please increase BSA to at least RM5,000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
    }
    else if (sumField.text.length <= 0) {
        if (incomeRider) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Guaranteed %@\n is required.", msgGYI ] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Sum Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        }
        [sumField becomeFirstResponder];
    }
    else if ([sumField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Input must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }
    //--
    else if ([getPlanChoose isEqualToString:@"HLACP"] && [sumField.text rangeOfCharacterFromSet:setHLACP].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Sum Assured does not allows decimal." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }//--
    else if (incomeRider && substring.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Guaranteed Yearly Income only allow 2 decimal." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }
    else if (!(incomeRider) && substring.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Sum Assured only allow 2 decimal." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }
    else if (dSumField < minSATerm && !(incomeRider) && ![riderCode isEqualToString:@"WPTPD30R"] && ![riderCode isEqualToString:@"WPTPD50R"]) { // it is not wealth plan rider
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be greater than or equal to %d",minSATerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }
    else if (dSumField < minSATerm && incomeRider) {
        if (maxRiderSA < minSATerm) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider. "] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Guaranteed %@ must be greater than or equal to %d", msgGYI, minSATerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
            [sumField becomeFirstResponder];
        }
        
    }
    else if (dSumField > [RiderViewController getRoundedSA:maxRiderSA] && !(incomeRider) && maxRiderSA > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
    }
    else if (([riderCode isEqualToString:@"WPTPD50R"] || [riderCode isEqualToString:@"WPTPD30R"]) && [self ValidateWPTPDSumSA] == FALSE ) {
        //stop here
    }
    else if (maxRiderSA == -1 && (dSumField > [RiderViewController getRoundedSA:maxRiderSA]) && ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"LCPR"] || [riderCode isEqualToString:@"CIR"] || [riderCode isEqualToString:@"PLCP"])) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. Please revise the RSA of CI related rider(s)."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (dSumField > [RiderViewController getRoundedSA:maxRiderSA] && ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"LCPR"] ||
                                                                           [riderCode isEqualToString:@"CIR"] || [riderCode isEqualToString:@"PLCP"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"CI Benefit Limit per Life across industry is capped at RM4mil. Please revise the RSA of CI related rider(s) as the CI Benefit Limit per Life across industry for 1st Life Assured has exceeded RM4mil."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (dSumField > [RiderViewController getRoundedSA:maxRiderSA] && incomeRider) {        
        if (maxRiderSA < minSATerm) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Annual Premium allowed for Basic Plan & Wealth Savings Riders is RM15,000 only. Please revise the desired annual premium in order to attach this rider. "] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Guaranteed %@ must be less than or equal to %.f", msgGYI, maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        }
        
        [sumField becomeFirstResponder];
    }
    else if (unit) {
        NSLog(@"validate - 2nd unit");
        [self validateUnit];
    } else {
        NSLog(@"validate - 2nd save");
        [self validateSaver];
    }

}

-(BOOL)ValidateWPTPDSumSA{
    double dSumField = [sumField.text doubleValue];
    int tempSA = 0;
    
    if (dSumField > [RiderViewController getRoundedSA:maxRiderSA] || (dSumField <= 0 && maxRiderSA <= 0) ) {
        
        if ([LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound) {
            tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD50R"]] integerValue];
        }
        
        if ([LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound) {
            tempSA = [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD30R"]] integerValue];
        }
        
        if (tempSA >= 1000000 && maxRiderSA >= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Maximum Total RSA for Wealth TPD Protector Rider (30 and 50 years) is capped at RM 1mil per product limit. Please revise the RSA of these rider(s)"] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"TPD Limit per Life is capped at RM3.5mil.\nPlease revise the RSA of TPD related Rider(s)."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
        
        return  FALSE;
        
    }
    else if (dSumField < minSATerm && maxRiderSA > minSATerm ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be greater than or equal to %d",minSATerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [sumField becomeFirstResponder];
        
        return  FALSE;
        
    }
    else if (dSumField > 0 && maxRiderSA < minSATerm ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider not available - does not meet underwriting rules. "] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        return  FALSE;
        
    }
    
    return  TRUE;;
}

+(double)getRoundedSA:(double)saVal
{
//    NSLog(@"saVal :%f",saVal);
//    long intValue = (long)saVal;
//    NSLog(@"INT :%ld",intValue);
//    float fractional = fmodf(saVal, (float)intValue);
//    NSLog(@"fract :%f",fractional);
//    if(fractional >= .5f)
//        intValue++;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:0];
    [formatter setCurrencyGroupingSeparator:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:saVal]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    return [sumAss doubleValue];
}

-(void)validateUnit
{
    NSRange rangeofDot = [unitField.text rangeOfString:@"."];
    
    if (unitField.text.length == 0||[unitField.text intValue] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Unit is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [unitField becomeFirstResponder];
    }
    else if ([unitField.text intValue] > [RiderViewController getRoundedSA:maxRiderSA]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Unit must be in the\n range of 1 - %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [unitField becomeFirstResponder];
    }
    else if (rangeofDot.location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Unit must be in the\n range of 1 - %.f and no decimal allowed",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [unitField becomeFirstResponder];
    }
    else {
        NSLog(@"validate - 3rd save");
        [self validateSaver];
    }
}

-(void)validateSaver
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSCharacterSet *setTerm = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSRange rangeofDot = [HLField.text rangeOfString:@"."];
    NSString *substring = @"";
    if (rangeofDot.location != NSNotFound) {
        substring = [HLField.text substringFromIndex:rangeofDot.location ];
    }
    
    NSRange rangeofDotTemp = [tempHLField.text rangeOfString:@"."];
    NSString *substringTemp = @"";
    
    if (rangeofDotTemp.location != NSNotFound) {
        substringTemp = [tempHLField.text substringFromIndex:rangeofDotTemp.location ];
    }
    
    double numHL = [HLField.text doubleValue];
    double aaHL = numHL/25;
    int bbHL = aaHL;
    float ccHL = aaHL - bbHL;
    NSString *msg2 = [formatter stringFromNumber:[NSNumber numberWithFloat:ccHL]];
    NSLog(@"value:%.2f,devide:%.2f,int:%d, minus:%.2f,msg:%@",numHL,aaHL,bbHL,ccHL,msg2);
    
    double numHLTemp = [tempHLField.text doubleValue];
    double aaHLTemp = numHLTemp/25;
    int bbHLTemp = aaHLTemp;
    float ccHLTemp = aaHLTemp - bbHLTemp;
    NSString *msgTemp = [formatter stringFromNumber:[NSNumber numberWithFloat:ccHLTemp]];
    
    BOOL HL1kTerm = NO;
    BOOL HL100kTerm = NO;
    BOOL HLPTerm = NO;
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++)
    {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1KT"]]) {
            HL1kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10T"]]) {
            HL100kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLPT"]]) {
            HLPTerm = YES;
        }
    }
    
    if (plan && planOption.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Plan Option/Choice is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (deduc && deductible.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Deductible is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //--
    else if (inputHLPercentage.length != 0 && [HLField.text intValue] > 500) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (%) cannot greater than 500%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
	
    else if (HLField.text.length == 0 && [HLTField.text intValue] != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) is required.";
        } else if (HL100kTerm) {
            msg = @"Health Loading (per 100 SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLField.text intValue] != 0 && HLTField.text.length == 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) Term is required.";
        } else if (HL100kTerm) {
            msg = @"Health Loading (per 100 SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if (inputHL1KSA.length != 0 && [HLField.text intValue] > 10000) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (Per 1k SA) cannot greater than 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLField.text intValue] !=0 && substring.length > 3) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (Per 1k SA) only allow 2 decimal places.";
        }
        else if (HL100kTerm) {
            msg = @"Health Loading (Per 100k SA) only allow 2 decimal places.";
        } 
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if (inputHLPercentage.length != 0 && substring.length > 1) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (%) must not contains decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if (inputHLPercentage.length != 0 && msg2.length > 1) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (%) must be in multiple of 25 or 0." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLTField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Health Loading (per 1k SA) Term.";
        } else if (HL100kTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Health Loading (per 100k SA) Term.";
        } else if (HLPTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Health Loading (%) Term.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if ([HLTField.text intValue] > [termField.text intValue] && ![riderCode isEqualToString:@"ETPDB"] && ![riderCode isEqualToString:@"EDB"]) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 100 SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) Term cannot be greater than %d",[termField.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if ([HLTField.text intValue] > getMOP && [self DifferentPaymentTerm:riderCode] == TRUE) { // for HLAWP Riders
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d", getMOP];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 100 SA) Term cannot be greater than %d",getMOP];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) Term cannot be greater than %d",getMOP];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    else if (HLPTerm && [HLField.text intValue] > 500) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (%) cannot greater than 500%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([HLField.text doubleValue] == 0 && HLField.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) is required.";
        } else if (HL100kTerm) {
            msg = @"Health Loading (per 100 SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLTField.text intValue] == 0 && HLTField.text.length != 0) {
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) Term is required.";
        } else if (HL100kTerm) {
            msg = @"Health Loading (per 100 SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
    }
    //--
    
    else if (tempHLField.text.length == 0 && [tempHLTField.text intValue] != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Temporary Health Loading (per 1k SA) is required.";
        } else if (HL100kTerm) {
            msg = @"Temporary Health Loading (per 100 SA) is required.";
        } else if (HLPTerm) {
            msg = @"Temporary Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLField.text intValue] != 0 && tempHLTField.text.length == 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Temporary Health Loading (per 1k SA) Term is required.";
        } else if (HL100kTerm) {
            msg = @"Temporary Health Loading (per 100 SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Temporary Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
    else if (HL1kTerm && [tempHLField.text intValue] > 10000) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (Per 1k SA) cannot greater than 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLField.text intValue] !=0 && substringTemp.length > 3) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Temporary Health Loading (Per 1k SA) only allow 2 decimal places.";
        } else if (HL100kTerm) {
            msg = @"Temporary Health Loading (Per 100k SA) only allow 2 decimal places.";
        }
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if (HLPTerm && substring.length > 1) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (%) must not contains decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if (HLPTerm && msgTemp.length > 1) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (%) must be in multiple of 25 or 0." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLTField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Temporary Health Loading (per 1k SA) Term.";
        } else if (HL100kTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Temporary Health Loading (per 100k SA) Term.";
        } else if (HLPTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Temporary Health Loading (%) Term.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
    else if ([tempHLTField.text intValue] > [termField.text intValue] && ![riderCode isEqualToString:@"ETPDB"] && ![riderCode isEqualToString:@"EDB"]) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) Term cannot be greater than %d",[termField.text intValue]];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) Term cannot be greater than %d",[termField.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
    else if ([tempHLTField.text intValue] > getMOP && [self DifferentPaymentTerm:riderCode] == TRUE) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",getMOP];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) Term cannot be greater than %d",getMOP];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) Term cannot be greater than %d",getMOP];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
    else if ([tempHLField.text doubleValue] == 0 && tempHLField.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Temporary Health Loading (per 1k SA) is required.";
        } else if (HL100kTerm) {
            msg = @"Temporary Health Loading (per 100 SA) is required.";
        } else if (HLPTerm) {
            msg = @"Temporary Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLTField.text intValue] == 0 && tempHLTField.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Temporary Health Loading (per 1k SA) Term is required.";
        } else if (HL100kTerm) {
            msg = @"Temporary Health Loading (per 100 SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Temporary Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
    }
	else if ([tempHLField.text intValue] > 500 && ([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_IV"]
                                                   || [riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] || [riderCode isEqualToString:@"HB"])) {
		
		NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) cannot be greater than 10000"];
        } else if (HL100kTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (per 100 SA) cannot be greater than 10000"];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Temporary Health Loading (%%) cannot be greater than 500%%"];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ETPDB"] || [riderCode isEqualToString:@"EDB"]) && [HLTField.text intValue ] > 6 ) {
		NSString *msg;
		
		msg = @"Health Loading (per 1k SA) term cannot be greater than 6";
		
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTField becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ETPDB"] || [riderCode isEqualToString:@"EDB"]) && [tempHLTField.text intValue ] > 6 ) {
		NSString *msg;
		
		msg = @"Temporary Health Loading (per 1k SA) term cannot be greater than 6";
		
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTField becomeFirstResponder];
	}
    else if ([sumField.text doubleValue] > [RiderViewController getRoundedSA:maxRiderSA] && ([riderCode isEqualToString:@"ACIR_MPP"] || [riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"LCPR"] ||
                                                                           [riderCode isEqualToString:@"CIR"] || [riderCode isEqualToString:@"PLCP"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"CI Benefit Limit per Life is across industry capped at RM4mil. Please revise the RSA of CI related rider(s) as the CI Benefit Limit per Life across industry for 1st Life Assured has exceeded RM4mil."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    //--
    else  if( ![self isAllowedToAddRiderL100] )
    {
        Edit = TRUE;
    }
    else if (([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_II"] ||
              [riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HSP_II"]) && LRiderCode.count != 0) {
        NSLog(@"go RoomBoard!");
        Edit = FALSE;
        //[self RoomBoard]; skip the checking as the final checking will be at the global save
        if ([LRiderCode indexOfObject:riderCode] != NSNotFound) {
            [self updateRider];
        }
        else{
            [self saveRider];
        }
    }
    else if (([riderCode isEqualToString:@"I20R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"I30R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"I40R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"IE20R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"IE30R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"ID20R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"ID30R"] && LRiderCode.count != 0) || ([riderCode isEqualToString:@"ID40R"] && LRiderCode.count != 0)) {
        Edit = FALSE;
        NSLog(@"go Negative Yield!");
        [self calculateIncomeRider];        //calculate existing income rider
        [self calculateIncomeRiderInput];   //calculate entered income rider         
        [self NegativeYield];
    }
    else if (([riderCode isEqualToString:@"I20R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"I30R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"I40R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"IE20R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"IE30R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"ID20R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"ID30R"] && LRiderCode.count == 0) || ([riderCode isEqualToString:@"ID40R"] && LRiderCode.count == 0)) {
        Edit = FALSE;
        NSLog(@"go Negative Yield2 - empty listing!");
        [self calculateIncomeRider];
        [self calculateIncomeRiderInput];
        [self NegativeYield];
    }

    else
    {
		Edit = FALSE;
        
        [self checkingRider];
        if (existRidCode.length == 0) {
            
            [self saveRider];
        } else {
            
            [self updateRider];
        }
    }
}

-(BOOL)RoomBoard
{
    arrCombNo = [[NSMutableArray alloc] init];
    arrRBBenefit = [[NSMutableArray alloc] init];
    BOOL toReturn = FALSE;
    
    if (existRidCode.length == 0)       //validate as a new
    {
        //--  validate combination of all MedGlobal, Major Medi and H&P        
        arrCombNo = [[NSMutableArray alloc] init];
        arrRBBenefit = [[NSMutableArray alloc] init];
        for (NSUInteger i=0; i<LRiderCode.count; i++)
        {
            if (([[LRiderCode objectAtIndex:i] isEqualToString:@"HMM"] && ![[LPlanOpt objectAtIndex:i] isEqualToString:@"HMM_1000"]) ||
                [[LRiderCode objectAtIndex:i] isEqualToString:@"HSP_II"] || [[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"] || [[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"]) {
                
                medRiderCode = [LRiderCode objectAtIndex:i];
                medPlanOpt = [LPlanOpt objectAtIndex:i];
               
                [self getListRBBenefit];
                [arrRBBenefit addObject:[NSString stringWithFormat:@"%d",RBBenefit]];
                
//                NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                
            } else {
                continue;
            }
        }
        
        //--calculate existing benefit
        double allBenefit = 0;
        for (NSUInteger x=0; x<arrRBBenefit.count; x++) {
            allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:x] doubleValue];
        }
    
        [self getRBBenefit];        //--get selected RBBenefit and calculate all bnefit
        //allBenefit = allBenefit + RBBenefit; removed it since the checking will be at the global save
    
//        NSLog(@"total allBenefit:%.f   %@",allBenefit, arrRBBenefit);
        
        //get Limit,RBGroup
        [self getRBLimit];
        
        //--end 2nd stage validation        
        
        if ([LPlanOpt indexOfObject:@"HMM_1000"] !=  NSNotFound) {
            RBLimit = 600;
        }
        if (allBenefit > RBLimit) {
            NSMutableString *msgStr = [[NSMutableString alloc] init];
            [msgStr appendString:@"Total Daily Room & Board Benefit for combination of all "];
            BOOL found = false;
            // scan for MGII or MGIV
            if ([LRiderCode indexOfObject:@"MG_II"] != NSNotFound || [LRiderCode indexOfObject:@"MG_IV"] != NSNotFound) {
                found = true;
                [msgStr appendString:@"MedGLOBAL "];
            }
            
            // scan for HMM
            if ([LRiderCode indexOfObject:@"HMM"] != NSNotFound) {
                if (found) {
                    [msgStr appendString:@"and "];
                }
                
                [msgStr appendString:@"Major Medi "];
            }
            
            [msgStr appendFormat:@"rider(s) must be less than or equal to RM%d for 1st LA.", RBLimit];            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msgStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [self roomBoardDefaultPlanNew];
            toReturn = FALSE;
            
        } else {
//            NSLog(@"will continue save RB!");
            toReturn = TRUE;
        }
    } else {
        //-- validate combination of all MedGlobal, Major Medi and H&P
            
        arrCombNo = [[NSMutableArray alloc] init];
        arrRBBenefit = [[NSMutableArray alloc] init];
        
        double allBenefit = 0;
        for (NSUInteger i=0; i<LRiderCode.count; i++)
        {
            if (([[LRiderCode objectAtIndex:i] isEqualToString:@"HMM"] && ![[LPlanOpt objectAtIndex:i] isEqualToString:@"HMM_1000"])||[[LRiderCode objectAtIndex:i] isEqualToString:@"HSP_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"])
            {
                medRiderCode = [LRiderCode objectAtIndex:i];
                medPlanOpt = [LPlanOpt objectAtIndex:i];                
                [self getListRBBenefit];
                
                [arrRBBenefit addObject:[NSString stringWithFormat:@"%d",RBBenefit]];
                NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                
            } else {
                continue;
            }
        }        

        int indexOfRider = [LRiderCode indexOfObject:riderCode];
        
        if (indexOfRider !=  NSNotFound) {
            medRiderCode = [LRiderCode objectAtIndex:indexOfRider];
            medPlanOpt = [LPlanOpt objectAtIndex:indexOfRider];
            [self getListRBBenefit];
        }
        
        //total up all benefit
        for (NSUInteger z=0; z<arrRBBenefit.count; z++) {
            allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:z] doubleValue];
        }
        NSLog(@"currentBenefit:%.f",allBenefit);
        
        //minus benefit
        allBenefit = allBenefit - RBBenefit;
        NSLog(@"benefit:%d, newBenefit:%.f",RBBenefit,allBenefit);
        //get selected RBBenefit and calculate
        [self getRBBenefit];
        allBenefit = allBenefit + RBBenefit;
        NSLog(@"allBenefit:%.f",allBenefit);
        
        //get Limit,RBGroup
        [self getRBLimit];
        
        if ([riderCode isEqualToString:@"HMM"] && [planOption isEqualToString:@"HMM_1000"]){
            RBLimit = 600;
        } else {
            if ([LPlanOpt indexOfObject:@"HMM_1000"] !=  NSNotFound  ) {
                RBLimit = 600;
            }
        }
        
        if (allBenefit > RBLimit) {
            NSMutableString *msgStr = [[NSMutableString alloc] init];
            [msgStr appendString:@"bTotal Daily Room & Board Benefit for combination of all "];
            BOOL found = false;
            // scan for MGII or MGIV
            if ([LRiderCode indexOfObject:@"MG_II"] != NSNotFound || [LRiderCode indexOfObject:@"MG_IV"] != NSNotFound) {
                found = true;
                [msgStr appendString:@"MedGLOBAL "];
            }
            
            // scan for MGII or MGIV
            if ([LRiderCode indexOfObject:@"HMM"] != NSNotFound) {
                if (found) {
                    [msgStr appendString:@"and "];
                }
                
                [msgStr appendString:@"Major Medi "];
            }
            
            [msgStr appendFormat:@"rider(s) must be less than or equal to RM%d for 1st LA.", RBLimit];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msgStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [self roomBoardDefaultPlan];
            toReturn = FALSE;

        } else {
            NSLog(@"will update data");
            toReturn = TRUE;
        }        
    }
    
    return toReturn;
}
 
-(void)NegativeYield
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //--TPremiumPayable (basic+incomeRider)
    double TPremiumPayable = (basicPremAnn + incomeRiderPrem + inputIncomeAnn) * getMOP;
    NSLog(@"basicPrem:%.2f, existIncomePrem:%.2f, inputIncomePrem:%.2f",basicPremAnn,incomeRiderPrem,inputIncomeAnn);
    
    //--rider GYI & CSV
    incomeRiderGYI = [[NSMutableArray alloc] init];
    NSMutableArray *RiderGYI = [[NSMutableArray alloc] init];
    NSMutableArray *RiderCSV = [[NSMutableArray alloc] init];
    NSMutableArray *BasicGYI = [[NSMutableArray alloc] init];
    
    double _sumRiderGYI = 0;
    double _sumRiderCSV = 0;
    
    double GYIRate;
    double _GYI;
    NSString *strGYI;
    if (incomeRiderCode.count != 0) {
        int CovPrd;
        NSString *RidCode;
        double _riderSA;
        
        
        double _sumGYI;
        double _csv;
        double _riderCSV;
        NSString *strCalCSV;
        for (int m=0; m<incomeRiderCode.count; m++) {
            CovPrd = [[incomeRiderTerm objectAtIndex:m] intValue];
            RidCode = [incomeRiderCode objectAtIndex:m];
            _riderSA = [[incomeRiderSA objectAtIndex:m] doubleValue];
            
            for (int n=1; n<=CovPrd; n++) {     //get gyi value for each income rider
                if ([RidCode isEqualToString:@"ID20R"] ) {
                    if (CovPrd >= 21 && CovPrd < 91 ) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else if ([RidCode isEqualToString:@"ID30R"]) {
                    if (CovPrd >= 31 && CovPrd < 91 ) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else if ([RidCode isEqualToString:@"ID40R"]) {
                    if (CovPrd >= 41 && CovPrd < 91 ) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"IE20R"] ) {
                    if (CovPrd < 21) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else if ([RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"IE30R"]) {
                    if (CovPrd < 31) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else if ([RidCode isEqualToString:@"I40R"]) {
                    if (CovPrd < 41) {
                        GYIRate = 100.00;
                    } else {
                        GYIRate = 0.00;
                    }
                } else {
                    continue;
                }
                
                _GYI = _riderSA * (GYIRate/100);
                strGYI = [formatter stringFromNumber:[NSNumber numberWithDouble:_GYI]];
                strGYI = [strGYI stringByReplacingOccurrencesOfString:@"," withString:@""];
                [RiderGYI addObject:strGYI];
            }
            
            for (int j=0; j<RiderGYI.count; j++) {      //sum all gyi
                _sumGYI = _sumGYI + [[RiderGYI objectAtIndex:j] doubleValue];
            }
            
            strGYI = [formatter stringFromNumber:[NSNumber numberWithDouble:_sumGYI]];
            strGYI = [strGYI stringByReplacingOccurrencesOfString:@"," withString:@""];
            [incomeRiderGYI addObject:strGYI];
            
            _csv = [[incomeRiderCSV objectAtIndex:m] doubleValue];
            _riderCSV = _csv * _riderSA / 1000;
            strCalCSV = [formatter stringFromNumber:[NSNumber numberWithDouble:_riderCSV]];
            strCalCSV = [strCalCSV stringByReplacingOccurrencesOfString:@"," withString:@""];
            [RiderCSV addObject:strCalCSV];
        }
        
        for (int h=0; h<incomeRiderGYI.count; h++) {
            _sumRiderGYI = _sumRiderGYI + [[incomeRiderGYI objectAtIndex:h] doubleValue];
        }
        
        for (int n=0; n<RiderCSV.count; n++) {
            _sumRiderCSV = _sumRiderCSV + [[RiderCSV objectAtIndex:n] doubleValue];
        }
    }
    
    //input rider GYI and CSV
    NSMutableArray *InputRiderGYI = [[NSMutableArray alloc] init];
    int inputTerm = [termField.text intValue];
    double _inputSA = [sumField.text doubleValue];
    
    for (int n=1; n<=inputTerm; n++) {
        if ([riderCode isEqualToString:@"ID20R"] ) {
            if (inputTerm >= 21 && inputTerm < 91 ) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else if ([riderCode isEqualToString:@"ID30R"]) {
            if (inputTerm >= 31 && inputTerm < 91 ) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else if ([riderCode isEqualToString:@"ID40R"]) {
            if (inputTerm >= 41 && inputTerm < 91 ) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else if ([riderCode isEqualToString:@"I20R"]||[riderCode isEqualToString:@"IE20R"] ) {
            if (inputTerm < 21) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else if ([riderCode isEqualToString:@"I30R"]||[riderCode isEqualToString:@"IE30R"]) {
            if (inputTerm < 31) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else if ([riderCode isEqualToString:@"I40R"]) {
            if (inputTerm < 41) {
                GYIRate = 100.00;
            } else {
                GYIRate = 0.00;
            }
        } else {
            continue;
        }
        
        _GYI = _inputSA * (GYIRate/100);
        strGYI = [formatter stringFromNumber:[NSNumber numberWithDouble:_GYI]];
        strGYI = [strGYI stringByReplacingOccurrencesOfString:@"," withString:@""];
        [InputRiderGYI addObject:strGYI];
    }
    double _sumInputGYI= 0;
    for (int k=0; k<InputRiderGYI.count; k++) {
        _sumInputGYI = _sumInputGYI + [[InputRiderGYI objectAtIndex:k] doubleValue];
    }
    
    double _inputCSV = inputCSV * _inputSA / 1000;
    NSLog(@"sumRiderGYI:%.2f, inputRiderGYI:%.2f",_sumRiderGYI,_sumInputGYI);
    NSLog(@"sumRiderCSV:%.2f, inputRiderCSV:%.2f",_sumRiderCSV,_inputCSV);
    
    //--basic GYI
    int newAge;
    double _basicGYI;
    for (int k=1; k<=getTerm; k++) {
        newAge = k + getAge;
        [self getBasicGYI:newAge];      //get basicGYI rate
        _basicGYI = getBasicSA * (basicGYIRate/100);
        
        strGYI = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicGYI]];
        strGYI = [strGYI stringByReplacingOccurrencesOfString:@"," withString:@""];
        [BasicGYI addObject:strGYI];
    }
    
    double _sumBasicGYI = 0;
    for (int h=0; h<BasicGYI.count; h++) {
        _sumBasicGYI = _sumBasicGYI + [[BasicGYI objectAtIndex:h] doubleValue];
    }
    
    double totalGYI = _sumBasicGYI + _sumRiderGYI + _sumInputGYI;
    NSLog(@"totalGYI:%.2f",totalGYI);
    
    //--basic CSV
    [self getBasicCSV];         //get basciCSV rate
    double _basicCSV = basicCSVRate * (getBasicSA/1000);
    
    double totalCSV = _basicCSV + _sumRiderCSV + _inputCSV;
    NSLog(@"totalCSV:%.2f",totalCSV);
    
    double totalAll = totalCSV + totalGYI;
    NSLog(@"totalPlusGYI_CSV:%.2f, TPremiumPayable:%.2f",totalAll,TPremiumPayable);
    
    if (TPremiumPayable > totalAll) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please note that the Guaranteed Benefit payout for selected plan maybe lesser than total premium outlay.\nChoose OK to proceed.\nChoose CANCEL to select other plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
        [alert setTag:1003];
        [alert show];
    }
    else {
        [self checkingRider];
        if (existRidCode.length == 0) {
            
            [self saveRider];
        } else {
            
            [self updateRider];
        }
    }
}

-(void)roomBoardDefaultPlan
{
    if ([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"HSP_II"] || [riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"MG_IV"]) {
        planOption = medPlanOpt;
        [self setPlanBtnTitle:planOption];
    }
}

-(void)roomBoardDefaultPlanNew
{
    if ([riderCode isEqualToString:@"HMM"]) {
        planOption = @"HMM_150";
        [self setPlanBtnTitle:planOption];
    } else if ([riderCode isEqualToString:@"HSP_II"]) {
        planOption = @"Standard";
        [self setPlanBtnTitle:planOption];
    } else if ([riderCode isEqualToString:@"MG_II"]) {
        planOption = @"MG_II_100";
        [self setPlanBtnTitle:planOption];
    } else if ([riderCode isEqualToString:@"MG_IV"]) {
        planOption = @"MGIVP_150";
        [self setPlanBtnTitle:planOption];
    }
}

#pragma mark - DB handling

-(void)getBasicCSV
{
    sqlite3_stmt *statement;
    NSString *querySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (getAdvance > 0) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Basic_CSV WHERE Age=%d AND PolYear=%d AND PremPayOpt=%d AND AdvOption=\"%d\"",getAge,getTerm,getMOP,getAdvance];
        } else {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Basic_CSV WHERE Age=%d AND PolYear=%d AND PremPayOpt=%d AND AdvOption=\"N\"",getAge,getTerm,getMOP];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicCSVRate =  sqlite3_column_double(statement, 0);
                NSLog(@"basicCSVRate:%.2f",basicCSVRate);
                
            } else {
                NSLog(@"error access Trad_Sys_Basic_CSV");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getBasicSARate
{
    sqlite3_stmt *statement;
    NSString *querySQL = [NSString stringWithFormat:@"Select basicSA from trad_details where sino = \"%@\" ", getSINo];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getBasicSA =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access trad_details");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getBasicGYI:(int)aAge
{
    sqlite3_stmt *statement;
    NSString *querySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (getAdvance > 0) {
            querySQL = [NSString stringWithFormat:
                        @"Select rate from trad_sys_Basic_GYI WHERE FromAge<=%d AND ToAge>=%d AND advOption=\"%d\" AND PremPayOpt=%d",aAge,aAge,getAdvance,getMOP];
        } else {
            querySQL = [NSString stringWithFormat:
                        @"Select rate from trad_sys_Basic_GYI WHERE FromAge<=%d AND ToAge>=%d AND advOption=\"N\" AND PremPayOpt=%d",aAge,aAge,getMOP];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicGYIRate =  sqlite3_column_double(statement, 0);                
            } else {
                NSLog(@"error access trad_sys_Basic_GYI");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderCSV:(NSString *)code
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV"
                              " where PlanCode=\"%@\" AND PremPayOpt=%d AND Age=%d ORDER by PolYear desc",code,getMOP, age];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderCSVRate =  sqlite3_column_double(statement, 0);
                NSLog(@"riderCSVRate:%.2f",riderCSVRate);
                
            } else {
                NSLog(@"error access Trad_Sys_Rider_CSV");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getLabelForm
{
    FLabelCode = [[NSMutableArray alloc] init];
    FLabelDesc = [[NSMutableArray alloc] init];
    FRidName = [[NSMutableArray alloc] init];
    FInputCode = [[NSMutableArray alloc] init];
    FTbName = [[NSMutableArray alloc] init];
    FFieldName = [[NSMutableArray alloc] init];
    FCondition = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT LabelCode,LabelDesc,RiderName,InputCode,TableName,FieldName,Condition FROM Trad_Sys_Rider_Label WHERE RiderCode=\"%@\"",riderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                [FLabelCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [FLabelDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                [FRidName addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)]];
                [FInputCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)]];
                
                const char *tbname = (const char *)sqlite3_column_text(statement, 4);
                [FTbName addObject:tbname == NULL ? @"" : [[NSString alloc] initWithUTF8String:tbname]];
                
                const char *fieldname = (const char *)sqlite3_column_text(statement, 5);
                [FFieldName addObject:fieldname == NULL ? @"" :[[NSString alloc] initWithUTF8String:fieldname]];
                
                const char *condition = (const char *)sqlite3_column_text(statement, 6);
                [FCondition addObject:condition == NULL ? @"" :[[NSString alloc] initWithUTF8String:condition]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getRiderTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,ExpiryAge,MinTerm,MaxTerm,MinSA,MaxSA,MaxSAFactor FROM Trad_Sys_Rider_Mtn WHERE RiderCode=\"%@\"",riderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                expAge =  sqlite3_column_int(statement, 2);
                minTerm =  sqlite3_column_int(statement, 3);
                maxTerm =  sqlite3_column_int(statement, 4);
                minSATerm = sqlite3_column_int(statement, 5);
                maxSATerm = sqlite3_column_int(statement, 6);
                maxSAFactor = sqlite3_column_double(statement, 7);
                NSLog(@"expiryAge(%@):%d,minTerm:%d,maxTerm:%d,minSA:%d,maxSA:%d",riderCode,expAge,minTerm,maxTerm,minSATerm,maxSATerm);
                
            } else {
                NSLog(@"error access Trad_Mtn");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getRiderTermRuleGYCC:(NSString*)rider riderTerm:(int)riderTerm
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
        if (requesteEDD == TRUE) {
            querySQL = [NSString stringWithFormat: @"select gycc from SI_Trad_Rider_HLAWP_GYCC where planoption='%@' and PolTerm='%d' and premPayOpt='%d' and StartAge = \"%d\" AND EndAge = \"%d\"", rider,
                        [rider isEqualToString:@"EDUWR"] ? getTerm : riderTerm,
                        getMOP, -1, -1];
        }
        else{
            querySQL = [NSString stringWithFormat: @"select gycc from SI_Trad_Rider_HLAWP_GYCC where planoption='%@' and PolTerm='%d' and premPayOpt='%d' and StartAge <= \"%d\" AND EndAge >= \"%d\"", rider,
                        [rider isEqualToString:@"EDUWR"] ? getTerm : getTerm,
                        getMOP,getAge,getAge];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                maxGycc = sqlite3_column_int(statement, 0);             
            } else {
                NSLog(@"error access Trad_Mtn");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getGYI
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (getMOP == 6) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_6 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,getAge,getAge];
            
        } else if (getMOP == 9) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_9 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,getAge,getAge];
            
        } else if (getMOP == 12) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_12 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,getAge,getAge];
        }
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                GYI = sqlite3_column_int(statement, 0);
                NSLog(@"GYI:%d",GYI);
            } else {
                NSLog(@"error access Trad_Mtn");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)saveRider
{
	sqlite3_stmt *statement;
    if (([pTypeCode isEqualToString:@"LA"]) && (PTypeSeq == 2)) {
        [self check2ndLARider];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    inputSA = [sumField.text doubleValue];
    
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
		if ([riderCode isEqualToString:@"C+"] || [riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] ) {
			riderDesc = [riderDesc stringByAppendingString:[NSString stringWithFormat:@" (%@)", planOption]];
		}
		else if ([riderCode isEqualToString:@"HMM"] ) {
			riderDesc = [riderDesc stringByAppendingString:[NSString stringWithFormat:@" (%@) (Deductible %@)", planOption, deductible]];
		}
		
        NSString *insertSQL;
        if ([self DifferentPaymentTerm:riderCode] == TRUE) {
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO Trad_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, PlanOption, "
                         "Units, Deductible, HL1KSA, HL1KSATerm, HL100SA, HL100SATerm, HLPercentage, HLPercentageTerm, CreatedAt, "
                         "TempHL1KSA,TempHL1KSATerm, RiderDesc, PayingTerm) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
                         "\"%@\", \"%d\", \"%@\",\"%@\",\"%@\", '%@', '%d')",
                         getSINo,riderCode, pTypeCode, PTypeSeq, termField.text, sumField.text, [self getPlanOption], unitField.text,
                         deductible, inputHL1KSA, inputHL1KSATerm, inputHL100SA, inputHL100SATerm, inputHLPercentage,
                         inputHLPercentageTerm, dateString,tempHLField.text,tempHLTField.text, riderDesc, requestMOP];
        }
        else{
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO Trad_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, PlanOption, "
                         "Units, Deductible, HL1KSA, HL1KSATerm, HL100SA, HL100SATerm, HLPercentage, HLPercentageTerm, CreatedAt, "
                         "TempHL1KSA,TempHL1KSATerm, RiderDesc, PayingTerm) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
                         "\"%@\", \"%d\", \"%@\",\"%@\",\"%@\", '%@', '%@')",
                         getSINo,riderCode, pTypeCode, PTypeSeq, termField.text, sumField.text, [self getPlanOption], unitField.text,
                         deductible, inputHL1KSA, inputHL1KSATerm, inputHL100SA, inputHL100SATerm, inputHLPercentage,
                         inputHLPercentageTerm, dateString,tempHLField.text,tempHLTField.text, riderDesc, termField.text];
        }
        
        
        
        //NSLog(@"%@",insertSQL);f
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Saved Rider!");
                [_delegate RiderAdded];
            } else {
                NSLog(@"Failed Save Rider!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
//    if (secondLARidCode.length != 0) {
    
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert setTag:1004];
        //[alert show];
//    }
    
    [self getListingRiderByType];
    [self getListingRider];
    
    if (inputSA > [RiderViewController getRoundedSA:maxRiderSA]) {
//        NSLog(@"will delete %@",riderCode);
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert setTag:1002];
        [alert show];
    }
    else {
        [self calculateRiderPrem];
        [self calculateWaiver];
        [self calculateMedRiderPrem];
        
    }
}

-(NSString *) getPlanOption
{
    if([riderCode isEqualToString:@"C+"] || [riderCode isEqualToString:@"HSP_II"])
    {
        return [[NSString alloc] initWithFormat:@"%@",_planList.selectedItem];
    }else
    {
        return planOption;
    }
}

-(void)getListingRider
{
    LRiderCode = [[NSMutableArray alloc] init];
    LSumAssured = [[NSMutableArray alloc] init];
    LTerm = [[NSMutableArray alloc] init];
    LPlanOpt = [[NSMutableArray alloc] init];
    LUnits = [[NSMutableArray alloc] init];
    LDeduct = [[NSMutableArray alloc] init];
    LRidHL1K = [[NSMutableArray alloc] init];
    LRidHL100 = [[NSMutableArray alloc] init];
    LRidHLP = [[NSMutableArray alloc] init];
    LSmoker = [[NSMutableArray alloc] init];
    LSex = [[NSMutableArray alloc] init];
    LAge = [[NSMutableArray alloc] init];
    LRidHLTerm = [[NSMutableArray alloc] init ]; // added by heng
    LRidHLPTerm = [[NSMutableArray alloc] init ]; // added by heng
    LRidHL100Term = [[NSMutableArray alloc] init ]; // added by heng
    LOccpCode = [[NSMutableArray alloc] init];
    LTempRidHL1K = [[NSMutableArray alloc] init];
    LTempRidHLTerm = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, "
                              "a.HL100SA, a.HLPercentage, c.Smoker,c.Sex, c.ALB, a.HL1KSATerm, a.HLPercentageTerm, a.HL100SATerm, c.OccpCode, a.TempHL1KSA, a.TempHL1KSATerm FROM Trad_Rider_Details a, "
                              "Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode "
                              "AND a.SINo=b.SINo AND a.SINo=\"%@\" ORDER by  a.Seq asc, a.PTypeCode ASC, a.RiderCode asc",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [LRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                
                const char *aaRidSA = (const char *)sqlite3_column_text(statement, 1);
                [LSumAssured addObject:aaRidSA == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaRidSA]];
                
                const char *aaTerm = (const char *)sqlite3_column_text(statement, 2);
                [LTerm addObject:aaTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaTerm]];
                
                const char *zzplan = (const char *) sqlite3_column_text(statement, 3); 
                [LPlanOpt addObject:zzplan == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzplan]];
                
                const char *aaUnit = (const char *)sqlite3_column_text(statement, 4);
                [LUnits addObject:aaUnit == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaUnit]];
                
                const char *deduct2 = (const char *) sqlite3_column_text(statement, 5);
                [LDeduct addObject:deduct2 == NULL ? @"" :[[NSString alloc] initWithUTF8String:deduct2]];
                
                double ridHL = sqlite3_column_double(statement, 6);
                [LRidHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL]];
                
                double ridHL100 = sqlite3_column_double(statement, 7);
                [LRidHL100 addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL100]];
                
                double ridHLP = sqlite3_column_double(statement, 8);
                [LRidHLP addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHLP]];
                
                [LSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                [LSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
                [LAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
                
                const char *ridTerm = (const char *)sqlite3_column_text(statement, 12);
                [LRidHLTerm addObject:ridTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridTerm]]; //added by heng
                
                const char *ridPTerm = (const char *)sqlite3_column_text(statement, 13);
                [LRidHLPTerm addObject:ridPTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridPTerm]]; //added by heng
                
                const char *ridHL100Term = (const char *)sqlite3_column_text(statement, 14);
                [LRidHL100Term addObject:ridHL100Term == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHL100Term]]; //added by heng
                
                [LOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)]];
                
                double TempridHL = sqlite3_column_double(statement, 16);
                [LTempRidHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",TempridHL]];
                
                const char *TempridHLTerm = (const char *)sqlite3_column_text(statement, 17);
                [LTempRidHLTerm addObject:TempridHLTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:TempridHLTerm]];
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getListingRiderByType
{
    LTypeRiderCode = [[NSMutableArray alloc] init];
    LTypeSumAssured = [[NSMutableArray alloc] init];
    LTypeTerm = [[NSMutableArray alloc] init];
    LTypePlanOpt = [[NSMutableArray alloc] init];
    LTypeUnits = [[NSMutableArray alloc] init];
    LTypeDeduct = [[NSMutableArray alloc] init];
    LTypeRidHL1K = [[NSMutableArray alloc] init];
    LTypeRidHL100 = [[NSMutableArray alloc] init];
    LTypeRidHLP = [[NSMutableArray alloc] init];
    LTypeSmoker = [[NSMutableArray alloc] init];
    LTypeSex = [[NSMutableArray alloc] init];
    LTypeAge = [[NSMutableArray alloc] init];
    LTypeRidHLTerm = [[NSMutableArray alloc] init ]; // added by heng
    LTypeRidHLPTerm = [[NSMutableArray alloc] init ]; // added by heng
    LTypeRidHL100Term = [[NSMutableArray alloc] init ]; // added by heng
    LTypeOccpCode = [[NSMutableArray alloc] init];
    LTypeTempRidHL1K = [[NSMutableArray alloc] init];
    LTypeTempRidHLTerm = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"";
        if ([pTypeCode isEqualToString:@"PY"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, "
                        "a.HL100SA, a.HLPercentage, c.Smoker,c.Sex, c.ALB, a.HL1KSATerm, a.HLPercentageTerm, a.HL100SATerm, c.OccpCode, a.TempHL1KSA, a.TempHL1KSATerm FROM Trad_Rider_Details a, "
                        "Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode "
                        "AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'PY' ",getSINo];
        }
        else {
            if (PTypeSeq == 2) {
                querySQL = [NSString stringWithFormat:
                            @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, "
                            "a.HL100SA, a.HLPercentage, c.Smoker,c.Sex, c.ALB, a.HL1KSATerm, a.HLPercentageTerm, a.HL100SATerm, c.OccpCode, a.TempHL1KSA, a.TempHL1KSATerm FROM Trad_Rider_Details a, "
                            "Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode "
                            "AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'LA' AND  b.Sequence = '2' ",getSINo];
            }
            else {
                querySQL = [NSString stringWithFormat:
                            @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, "
                            "a.HL100SA, a.HLPercentage, c.Smoker,c.Sex, c.ALB, a.HL1KSATerm, a.HLPercentageTerm, a.HL100SATerm, c.OccpCode, a.TempHL1KSA, a.TempHL1KSATerm FROM Trad_Rider_Details a, "
                            "Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode "
                            "AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'LA' AND b.Sequence = '1' ",getSINo];
            }
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [LTypeRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                
                const char *aaRidSA = (const char *)sqlite3_column_text(statement, 1);
                [LTypeSumAssured addObject:aaRidSA == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaRidSA]];
                
                const char *aaTerm = (const char *)sqlite3_column_text(statement, 2);
                [LTypeTerm addObject:aaTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaTerm]];
                
                const char *zzplan = (const char *) sqlite3_column_text(statement, 3);
                [LTypePlanOpt addObject:zzplan == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzplan]];
                
                const char *aaUnit = (const char *)sqlite3_column_text(statement, 4);
                [LTypeUnits addObject:aaUnit == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaUnit]];
                
                const char *deduct2 = (const char *) sqlite3_column_text(statement, 5);
                [LTypeDeduct addObject:deduct2 == NULL ? @"" :[[NSString alloc] initWithUTF8String:deduct2]];
                
                const char *ridHL = (const char *)sqlite3_column_text(statement, 6);
                [LTypeRidHL1K addObject:ridHL == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHL]];
                
                const char *ridHL100 = (const char *)sqlite3_column_text(statement, 7);
                [LTypeRidHL100 addObject:ridHL100 == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHL100]];
                
                const char *ridHLP = (const char *)sqlite3_column_text(statement, 8);
                [LTypeRidHLP addObject:ridHLP == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHLP]];
                
                [LTypeSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                [LTypeSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
                [LTypeAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
                
                const char *ridTerm = (const char *)sqlite3_column_text(statement, 12);
                [LTypeRidHLTerm addObject:ridTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridTerm]]; //added by heng
                
                const char *ridPTerm = (const char *)sqlite3_column_text(statement, 13);
                [LTypeRidHLPTerm addObject:ridPTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridPTerm]]; //added by heng
                
                const char *ridHL100Term = (const char *)sqlite3_column_text(statement, 14);
                [LTypeRidHL100Term addObject:ridHL100Term == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHL100Term]]; //added by heng
                
                [LTypeOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)]];
                
                const char *TempridHL = (const char *)sqlite3_column_text(statement, 16);
                [LTypeTempRidHL1K addObject:TempridHL == NULL ? @"" :[[NSString alloc] initWithUTF8String:TempridHL]];
                
                const char *TempridHLTerm = (const char *)sqlite3_column_text(statement, 17);
                [LTypeTempRidHLTerm addObject:TempridHLTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:TempridHLTerm]];
            }
            
            if ([LTypeRiderCode count] == 0) {
                myTableView.hidden = YES;
                titleRidCode.hidden = YES;
                titleSA.hidden = YES;
                titleTerm.hidden = YES;
                titleUnit.hidden = YES;
                titleClass.hidden = YES;
                titleLoad.hidden = YES;
                titleHL1K.hidden = YES;
                titleHL100.hidden = YES;
                titleHLP.hidden = YES;
                editBtn.hidden = YES;
                deleteBtn.hidden = true;
                titleHLPTerm.hidden = YES;
                
                [self.myTableView setEditing:NO animated:TRUE];
                [editBtn setTitle:@"Delete" forState:UIControlStateNormal ];
            } else {
                myTableView.hidden = NO;
                titleRidCode.hidden = NO;
                titleSA.hidden = NO;
                titleTerm.hidden = NO;
                titleUnit.hidden = NO;
                titleClass.hidden = NO;
                titleLoad.hidden = NO;
                titleHL1K.hidden = NO;
                titleHL100.hidden = NO;
                titleHLP.hidden = NO;
                editBtn.hidden = NO;
                titleHLPTerm.hidden = NO;
            }
            
            [self.myTableView reloadData];
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getOccpNotAttach
{
    atcRidCode = [[NSMutableArray alloc] init];
    atcPlanChoice = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode,PlanChoice FROM Trad_Sys_Occp_NotAttach WHERE OccpCode=\"%@\"",pTypeOccp];
        
        //        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char *zzRidCode = (const char *)sqlite3_column_text(statement, 0);
                [atcRidCode addObject:zzRidCode == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzRidCode]];
                
                const char *zzPlan = (const char *)sqlite3_column_text(statement, 1);
                [atcPlanChoice addObject:zzPlan == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzPlan]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkingRider
{
    existRidCode = [[NSString alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND PTypeCode=\"%@\" AND Seq=\"%d\"",getSINo,riderCode,pTypeCode, PTypeSeq];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                existRidCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateRider
{
	sqlite3_stmt *statement;
    BOOL success = FALSE;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if ([riderCode isEqualToString:@"C+"] || [riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] ) {
			riderDesc = [riderDesc stringByAppendingString:[NSString stringWithFormat:@" (%@)", planOption]];
		}
		else if ([riderCode isEqualToString:@"HMM"] ) {
			riderDesc = [riderDesc stringByAppendingString:[NSString stringWithFormat:@" (%@) (Deductible %@)", planOption, deductible]];
		}
		
        NSString *updatetSQL;
        if ([self DifferentPaymentTerm:riderCode] == TRUE) {
            updatetSQL = [NSString stringWithFormat:
                          @"UPDATE Trad_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
                          "Units=\"%@\", Deductible=\"%@\", HL1KSA=\"%@\", HL1KSATerm=\"%d\", HL100SA=\"%@\", "
                          "HL100SATerm=\"%d\", HLPercentage=\"%@\", HLPercentageTerm=\"%d\", CreatedAt=\"%@\", "
                          "TempHL1KSA=\"%@\", TempHL1KSATerm=\"%@\", RiderDesc = '%@', PayingTerm =\"%d\" WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
                          "PTypeCode=\"%@\" AND Seq=\"%d\"  ",
                          termField.text, sumField.text, [self getPlanOption], unitField.text, deductible, inputHL1KSA,
                          inputHL1KSATerm, inputHL100SA, inputHL100SATerm, inputHLPercentage, inputHLPercentageTerm,
                          dateString,tempHLField.text,tempHLTField.text, riderDesc, requestMOP, getSINo,riderCode,pTypeCode, PTypeSeq];
        }
        else{
            updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
                                    @"UPDATE Trad_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
                                    "Units=\"%@\", Deductible=\"%@\", HL1KSA=\"%@\", HL1KSATerm=\"%d\", HL100SA=\"%@\", "
                                    "HL100SATerm=\"%d\", HLPercentage=\"%@\", HLPercentageTerm=\"%d\", CreatedAt=\"%@\", "
                                    "TempHL1KSA=\"%@\", TempHL1KSATerm=\"%@\", RiderDesc = '%@', PayingTerm =\"%@\" WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
                                    "PTypeCode=\"%@\" AND Seq=\"%d\" ",
                                    termField.text, sumField.text, [self getPlanOption], unitField.text, deductible, inputHL1KSA,
                                    inputHL1KSATerm, inputHL100SA, inputHL100SATerm, inputHLPercentage, inputHLPercentageTerm,
                                    dateString,tempHLField.text,tempHLTField.text, riderDesc , termField.text, getSINo,riderCode,pTypeCode, PTypeSeq];
        }
        
        if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                /*
                 UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider record sucessfully updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [SuccessAlert show];*/
                success = TRUE;
                
                
            } else {
                NSLog(@"Update Rider failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (success == TRUE) {
        [self validateRules];
    }
    
    //if ([requesteProposalStatus isEqualToString:@"Confirmed"]) { //removed @ 02012015 as adviced by Prem
        eAppCheckList*deleteOldPDF=[[eAppCheckList alloc] init];
        //[deleteOldPDF deleteOldPdfs];
    [deleteOldPDF deleteEAppCase:getSINo];
        deleteOldPDF = Nil;
   
        NSLog(@"delete eApp cases for sino %@", getSINo );
    //}
    
}

-(BOOL)DifferentPaymentTerm : (NSString *) aaRidercode{
    if ([aaRidercode isEqualToString:@"EDUWR"] || [aaRidercode isEqualToString:@"WB30R"]|| [aaRidercode isEqualToString:@"WB50R"]|| [aaRidercode isEqualToString:@"WBI6R30"] ||
        [aaRidercode isEqualToString:@"WBD10R30"] || [aaRidercode isEqualToString:@"WP30R"] || [aaRidercode isEqualToString:@"WP50R"]|| [aaRidercode isEqualToString:@"WPTPD30R"] ||
        [aaRidercode isEqualToString:@"WPTPD50R"])
    {
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(void)getOccLoad
{
    occCPA = 0;
    occLoad = 0;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT PA_CPA, OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",getOccpCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occCPA  = sqlite3_column_int(statement, 0);
                occLoad =  sqlite3_column_int(statement, 1);
                
            } else {
                NSLog(@"error access getOccLoad");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getOccLoadRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",pTypeOccp];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occLoadRider =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getOccLoadRider");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getCPAClassType
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT OccLoading, CPA, PA, Class FROM Adm_Occp_Loading WHERE OccpCode=\"%@\"",pTypeOccp];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                occLoadType =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                occCPA  = sqlite3_column_int(statement, 1);
                occPA  = sqlite3_column_int(statement, 2);
                occClass = sqlite3_column_int(statement, 3);
                
//                NSLog(@"::OccpLoad:%@, cpa:%d, pa:%d, class:%d",occLoadType, occCPA,occPA,occClass);
            }
            else {
                NSLog(@"Error getOccLoadExist!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getMaxRiderTerm:(NSString*)RiderCode {
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if ([riderCode isEqualToString:@"CIWP"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"ACIR_MPP\" AND RiderCode !=\"CIR\" AND RiderCode !=\"ICR\" AND RiderCode !=\"LCPR\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"PR\" AND RiderCode !=\"SP_PRE\" AND RiderCode !=\"SP_STD\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R')", getSINo ];
        } else if ([riderCode isEqualToString:@"LCWP"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"PLCP\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R')", getSINo ];
        } else if ([riderCode isEqualToString:@"PR"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"PR\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"PTR\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R')", getSINo ];
        } else if ([riderCode isEqualToString:@"SP_PRE"] || [riderCode isEqualToString:@"SP_STD"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"SP_STD\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"SP_PRE\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R')", getSINo ];
        } else {
            querySQL = [NSString stringWithFormat:
                              @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"I20R\" AND RiderCode !=\"I30R\" AND RiderCode !=\"I40R\" AND RiderCode !=\"ID20R\" AND RiderCode !=\"ID30R\" AND RiderCode !=\"ID40R\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"PR\" AND RiderCode !=\"PLCP\" AND RiderCode !=\"PTR\" AND RiderCode !=\"SP_STD\" AND RiderCode !=\"SP_PRE\" AND RiderCode !=\"IE20R\" AND RiderCode !=\"IE30R\" AND RiderCode !=\"EDB\" AND RiderCode !=\"ETPDB\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R') ",getSINo];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                storedMaxTerm = sqlite3_column_int(statement, 0);
                NSLog(@"Stored max rider term:%d",storedMaxTerm);
                
            } else {
                NSLog(@"error access getMaxRiderTerm");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

/*
 *
 @Deprecated
 */
-(void)getBasicPentaRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem WHERE PlanCode=\"%@\" AND FromTerm=\"%d\" AND FromMortality=0",getPlanCode,getTerm];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicRate =  sqlite3_column_int(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Basic_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getBasicSIRate:(int)fromAge toAge:(int)toAge
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = NULL;
        NSString *sexStr;
        
        if( [getSex isEqualToString:@"FEMALE"] )
        {
            sexStr = @"F";
        }else
        if( [getSex isEqualToString:@"MALE"] )
        {
            sexStr = @"M";
        }else
        {
            sexStr = getSex;
        }
        
        if([getPlanChoose isEqualToString:@"HLACP"])
        {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\"",getPlanChoose];
        }else if([getPlanChoose isEqualToString:@"L100"] || [getPlanChoose isEqualToString:@"S100"])
        {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND Sex=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" ",getPlanChoose,sexStr,fromAge,toAge];
        }else if([getPlanChoose isEqualToString:@"HLAWP"])
        {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" and FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND PremPayOpt=\"%d\" ",
                        getPlanChoose,fromAge,toAge,getTerm,getTerm,getMOP];
        }
        else if([getPlanChoose isEqualToString:@"BCALH"])
        {
            querySQL = [NSString stringWithFormat: @"SELECT Rates FROM Basic_Prem WHERE trim(Gender) = '%@' AND EntryAge = '%d' AND Premium_Term = '%d'  ", sexStr, fromAge, getMOP ];
        }
        
//        NSLog(@"Rider getBasicSIRate: %@",querySQL);
        if (querySQL == NULL) {
            NSString *msg = [NSString stringWithFormat:@"No rate data found for %@", getPlanChoose];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
            [alert show];
            
        } else if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access getBasicSIRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getLSDRate
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:getBasicSA]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%@\" AND ToSA >= \"%@\"",getPlanCode,sumAss,sumAss];
        //        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                LSDRate =  sqlite3_column_int(statement, 0);
                
//            } else {
//                NSLog(@"error access getLSDRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)check2ndLARider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode FROM Trad_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"%@\" AND Seq=\"%d\"",getSINo,pTypeCode, PTypeSeq];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                secondLARidCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkPayorRider:(NSString *)aaRider
{
    payorRidCode = [[NSString alloc] init];
    sqlite3_stmt *statement;
    NSString *ridPayor = @"";
    
    if ([aaRider isEqualToString:@"LCWP"]) {
        ridPayor = @"PLCP";
    }
    else {
        ridPayor = @"PTR";
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT RiderCode FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\" ",getSINo,ridPayor];
        
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                payorRidCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//---

-(void)getRiderRateSex:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\" AND Sex=\"%@\" ",RidCode,aaterm,fromAge,toAge,getMOP,sex];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

/*
 -(void)getRiderRateSex:(NSString *)aaplan
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromMortality=0 AND Sex=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,sex,age,age];
 
 NSLog(@"%@",querySQL);
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }
 */
-(void)getRiderRateAge:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        /*NSString *querySQL = [NSString stringWithFormat:
         @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\"",RidCode,aaterm,fromAge,toAge,getMOP];*/
        NSString *querySQL;
        if (aaterm == 0) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\"",RidCode,fromAge,toAge,getMOP];
        }else
        {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\"",RidCode,fromAge,toAge,getMOP];
        }
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
/*
 -(void)getRiderRateAge:(NSString *)aaplan riderTerm:(int)aaterm
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,aaterm,age,age];
 
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }*/


-(void)getRiderRateAgeSexCplus:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge planOptC:(NSString *) plnOptC2
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {       
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND RiderOpt=\"%@\" ",RidCode,aaterm,fromAge,toAge,sex, plnOptC2];
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSex:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        if (requesteEDD == TRUE) {
            querySQL = [NSString stringWithFormat:
                                  @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%@\" AND ToAge >=\"%@\" ",RidCode,aaterm,fromAge,toAge];
        }
        else{
            querySQL = [NSString stringWithFormat:
                                  @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" ",RidCode,aaterm,fromAge,toAge,[sex substringToIndex:1]];
        }
        
        
        //        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
/*
 -(void)getRiderRateAgeSex:(NSString *)aaplan riderTerm:(int)aaterm
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\"",aaplan,aaterm,age,age,sex];
 //        NSLog(@"%@",querySQL);
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }
 */

-(void)getRiderRateAgeSexClassMG_IV:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge planOption:(NSString *)planOption2
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString * entryAgeGrp;
        int ageNo = [fromAge intValue];
        if( ageNo > 60 )
        {
            entryAgeGrp = @"2";
        }else
        {
            entryAgeGrp = @"1";
        }
        int subClass;
        if(getOccpClass == 2)   
        {
            subClass = 1;
        }else
        {
            subClass = getOccpClass;
        }
        
        planOption2 = [planOption2 stringByReplacingOccurrencesOfString:@"IVP_" withString:@""];
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\" AND EntryAgeGroup=\"%@\"", RidCode,fromAge,toAge,sex, subClass, planOption2, entryAgeGrp];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSexClassMG_II:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge planOption:(NSString *)planOption2
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\"", RidCode,fromAge,toAge,sex, getOccpClass, planOption2];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSexClassHMM:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge planOption:(NSString *)planOption2 hmm:(NSString *)hmm
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString * entryAgeGrp;
        int ageNo = [fromAge intValue];
        if( ageNo > 60 )
        {
            entryAgeGrp = @"2";
        }else
        {
            entryAgeGrp = @"1";
        }
        int subClass;
        if(getOccpClass == 2)
        {
            subClass = 1;
        }else
        {
            subClass = getOccpClass;
        }
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\" AND Deductible=\"%@\" AND EntryAgeGroup=\"%@\"", RidCode,fromAge,toAge,sex, subClass, planOption2, hmm, entryAgeGrp];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

/*
 -(void)getRiderRateAgeSexClass:(NSString *)aaplan riderTerm:(int)aaterm
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND occpClass = \"%d\"", aaplan,aaterm,age,age,sex, getOccpClass];
 
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }*/

-(void)getRiderRateAgeClassPA:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE Term = \"%d\"  AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND occpClass = \"%d\"" AND PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND occpClass = \"%d\" ",RidCode,fromAge,toAge, getOccpClass ];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeClassHSP_II:(NSString *)RidCode riderTerm:(int)aaterm planHSPII:(NSString *)plans fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND occpClass = \"%d\" AND RiderOpt=\"%@\"",RidCode, fromAge,toAge, getOccpClass,plans ];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
/*
 -(void)getRiderRateAgeClass:(NSString *)aaplan riderTerm:(int)aaterm 
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND "
 " FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND occpClass = \"%d\"",
 aaplan,aaterm,age,age, getOccpClass];
 
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }*/

-(void)getRiderRateClass:(NSString *)RidCode riderTerm:(int)aaterm 
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE Term = \"%d\" AND "" FromMortality=0 AND occpClass = \"%d\""
        //AND PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" "
                              " AND occpClass = \"%d\" ",
                              RidCode, getOccpClass];
//        NSLog(@"%@",querySQL);
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
/*
 -(void)getRiderRateClass:(NSString *)aaplan riderTerm:(int)aaterm
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
 " FromMortality=0 AND occpClass = \"%d\"",
 aaplan,aaterm,aaterm, getOccpClass];
 
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 riderRate =  sqlite3_column_double(statement, 0);
 } else {
 NSLog(@"error access Trad_Sys_Rider_Prem");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }
 */
//----

-(void)getOccpCatCode
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT OccpCatCode FROM Adm_OccpCat_Occp WHERE OccpCode=\"%@\"",pTypeOccp];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                OccpCat = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                OccpCat = [OccpCat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                //                NSLog(@"occpCat:\"%@\"",OccpCat);
            } else {
                NSLog(@"error access getOccpCatCode");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getCombNo
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT CombNo FROM Trad_Sys_Medical_MST WHERE RiderCode=\"%@\"",riderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CombNo =  sqlite3_column_int(statement, 0);
                //                NSLog(@"CombNo:%d",CombNo);
            } else {
                NSLog(@"error access getCombNo");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getListCombNo
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT CombNo FROM Trad_Sys_Medical_MST WHERE RiderCode=\"%@\"",medRiderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CombNo =  sqlite3_column_int(statement, 0);
                //                NSLog(@"listCombNo:%d",CombNo);
            } else {
                NSLog(@"error access getListCombNo");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRBBenefit
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RBBenefit from Trad_Sys_Medical_Benefit WHERE RiderCode=\"%@\" AND PlanChoice=\"%@\"",riderCode,planOption];
        
//        NSLog(@"querySQL = %@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RBBenefit =  sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getListRBBenefit
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RBBenefit from Trad_Sys_Medical_Benefit WHERE RiderCode=\"%@\" AND PlanChoice=\"%@\"",medRiderCode,[RiderViewController getRiderDecFromValue:medPlanOpt]];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RBBenefit =  sqlite3_column_int(statement, 0);
                //                NSLog(@"Benefit:%d",RBBenefit);
                
            } else {
                NSLog(@"error access getListRBBenefit");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRBLimit
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        /*
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT `Limit`, RBGroup from Trad_Sys_Medical_Comb WHERE OccpCode=\"%@\" AND Comb=\"%d\"",OccpCat,AllCombNo];
         */
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT `Limit`, RBGroup from Trad_Sys_Medical_Comb WHERE OccpCode=\"%@\" ",OccpCat];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RBLimit =  sqlite3_column_int(statement, 0);
                RBGroup =  sqlite3_column_int(statement, 1);
//                NSLog(@"Limit:%d, group:%d",RBLimit,RBGroup);
                
            } else {
                NSLog(@"error access getRBLimit");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)deleteRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"rider delete!");
                [self clearField];
                
                [self validateRules];
                
            } else {
                NSLog(@"rider delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(NSString *)getRiderDesc:(NSString *) TempRiderCode
{
    sqlite3_stmt *statement;
    NSString *returnValue = @"";
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RiderDesc FROM Trad_Sys_Rider_Profile WHERE RiderCode=\"%@\" ", TempRiderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                returnValue = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];;
                
            } else {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return returnValue;
}

#pragma mark - Delegate

-(void)PTypeController:(RiderPTypeTbViewController *)inController didSelectCode:(NSString *)code seqNo:(NSString *)seq
				  desc:(NSString *)desc andAge:(NSString *)aage andOccp:(NSString *)aaOccp andSex:(NSString *)aaSex
{
    if (riderCode != NULL) {
        [self.btnAddRider setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
        riderCode = [[NSString alloc] init];
        [self clearField];
    }
    
    if ([code isEqualToString:@"PY"]) {
        NSString *dd = [desc substringWithRange:NSMakeRange(0, 5)];
        pTypeDesc = [[NSString alloc] initWithFormat:@"%@",dd];
    } else {
        pTypeDesc = [[NSString alloc] initWithFormat:@"%@",desc];
    }
    
    pTypeCode = [[NSString alloc] initWithFormat:@"%@",code];
    PTypeSeq = [seq intValue];
    pTypeAge = [aage intValue];
    pTypeOccp = [[NSString alloc] initWithFormat:@"%@",aaOccp];
	
    [self getCPAClassType];
    
    [self.btnPType setTitle:pTypeDesc forState:UIControlStateNormal];
    [self.pTypePopOver dismissPopoverAnimated:YES];
//    NSLog(@"dasdasdadas RIDERVC pType:%@, seq:%d, desc:%@",pTypeCode,PTypeSeq,pTypeDesc);
    [self getListingRiderByType];
    [myTableView reloadData];
    classField.text = @"";
    
    _RiderList = Nil;
}

-(void)resetVariables
{
    ridTermG = @"";
    LRiderCode = nil;
}

-(void)RiderListController:(RiderListTbViewController *)inController didSelectCode:(NSString *)code desc:(NSString *)desc
{
    //reset value existing
	Edit = TRUE;
    [self resetVariables];
	
    if (riderCode != NULL) {
        [self clearField];
    }
    
    riderCode = [[NSString alloc] initWithFormat:@"%@",code];
    riderDesc = [[NSString alloc] initWithFormat:@"%@",desc];
    
    NSRange temprange = [riderDesc rangeOfString:@"("]; // to hide (30 years term)
    
    if (temprange.location != NSNotFound) {
            [self.btnAddRider setTitle:[riderDesc substringToIndex:temprange.location] forState:UIControlStateNormal];
    }
    else{
        [self.btnAddRider setTitle:riderDesc forState:UIControlStateNormal];
    }
    
    [self.RiderListPopover dismissPopoverAnimated:YES];
    
    BOOL foundPayor = YES;
    BOOL foundLiving = YES;
    BOOL either = NO;
    BOOL SPRider = NO;
    //BOOL either2 = NO;
    if ([riderCode isEqualToString:@"PTR"]) { foundPayor = NO; }
    if ([riderCode isEqualToString:@"PLCP"]) { foundLiving = NO; }
    
    [self getListingRider];
    [LRiderCode count];
    //validation part
	
	//----reset back pTypeOccp to first life assured occp code
	if (PTypeSeq == 1 && [pTypeCode isEqualToString:@"LA"]) {
		pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
	}
	//----
	
    [self getOccpNotAttach];
    
    if ([atcRidCode count] != 0 && [riderCode isEqualToString:@"CPA"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider not available - does not meet underwriting rules" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
    }
    else if ([LRiderCode count] != 0)
    {
        NSUInteger i;
        for (i=0; i<[LRiderCode count]; i++) {
            NSLog(@"riderExist:%@, rider enter:%@",[LRiderCode objectAtIndex:i],riderCode);
            
            if ([riderCode isEqualToString:@"PTR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) {
                foundPayor = YES;
                NSLog(@"enterList-a");
            }
            if ([riderCode isEqualToString:@"PLCP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"]) {
                foundLiving = YES;
                NSLog(@"enterList-b");
            }
			/*
             if (([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) || ([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"])) {
             either = YES;
             }
             if (([riderCode isEqualToString:@"SP_PRE"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"]) || ([riderCode isEqualToString:@"SP_STD"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"])) {
             either2 = YES;
             }
			 */
			/*
             if (([[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"] || [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"] ||
             [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"] || [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"])
             && ([riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"] || [riderCode isEqualToString:@"SP_PRE"]
             || [riderCode isEqualToString:@"SP_STD"])) {
             either = YES;
             }
			 */
			if (([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) ||
				([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"]) ||
				([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"]) ||
				([riderCode isEqualToString:@"SP_PRE"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"]) ||
				([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"]) ||
				([riderCode isEqualToString:@"SP_STD"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"]) ||
				([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"]) ||
				([riderCode isEqualToString:@"SP_STD"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) ||
				([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"]) ||
				([riderCode isEqualToString:@"SP_PRE"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) ||
				([riderCode isEqualToString:@"SP_PRE"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"]) ||
				([riderCode isEqualToString:@"SP_STD"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"])) {
                either = YES;
                
                if (([riderCode isEqualToString:@"SP_PRE"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_STD"]) ||
                    ([riderCode isEqualToString:@"SP_STD"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"SP_PRE"])) {
                    SPRider = YES;
                }
                else{
                    SPRider = NO;
                }
            }
        }
        if (!(foundPayor)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Rider PR before PTR" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
            [alert show];
        }
        else if (!foundLiving) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Rider LCWP before PLCP." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
            [alert show];
        }
		/*
         else if (either) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select either PR or LCWP." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
         }
         else if(either2) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select either WOP_SP(Standard) or WOP_SP(Premier)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [alert show];
         [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
         }
		 */
		else if (either) {
			if (PTypeSeq == 1 ) { //payor
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select only either of LCWP or PR." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
			}
			else{ //2nd life assured
                UIAlertView *alert;
                
                if (RiderPopoverCount == 2) {
                    alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select only either of WOP_SP(Standard) or WOP_SP(Premier)." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                }
                else
                {
                    alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select only either of LCWP, PR, WOP_SP(Standard) or WOP_SP(Premier)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                }
                
                
				[alert show];
				[self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
			}
            
			
            
        }
        else {
            NSLog(@"enterList-2!");
            [self getLabelForm];
            [self toggleForm];
            [self getRiderTermRule];
            [self getRiderTermRuleGYCC:riderCode riderTerm:maxTerm];
            ridPAge = -1;
            isFromTable = FALSE;
            isFromDropDown = TRUE;
            [self calculateTerm];
            [self CalcPrem]; // for  CI rider only, in order to calculate CI benefit
            [self calculateSA];
            [self PopulateExistingRiderInfo];
        }
    }
    else if (!(foundPayor)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Rider PR before PTR" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
        [alert show];
    }
    else if (!foundLiving) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Rider LCWP before PLCP." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
        [alert show];
    }
//    else if( [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"] || [riderCode isEqualToString:@"WPTPD30R"] || [riderCode isEqualToString:@"WPTPD50R"] )
//    {
//        //Max entry age for Wealth Protector and wealth protector (TPD) for 50 year term is age 45. For 30 year term, it is age 65.
//        if( getTerm==50 )
//        {
//            if( getAge>45 )
//            {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Max age for this rider is 45." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [self.btnAddRider setTitle:@"" forState:UIControlStateNormal];
//                [alert show];
//            }
//        }
//    }
    else {
        NSLog(@"outList!");
        [self getLabelForm];
        [self toggleForm];
        [self getRiderTermRule];
        [self getRiderTermRuleGYCC:riderCode riderTerm:maxTerm];
        ridPAge = -1;
        isFromTable = TRUE;
        isFromDropDown = FALSE;
        [self calculateTerm];
        [self CalcPrem];
        [self calculateSA];
        
            
    }
    

    
    if ([riderCode isEqualToString: @"CIWP"]||[riderCode isEqualToString: @"LCWP"]||[riderCode isEqualToString: @"PR"]||[riderCode isEqualToString: @"SP_PRE"]||[riderCode isEqualToString: @"SP_STD"]) {
        sumLabel.text = @"Sum Assured (%)";
    }
    else if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBI6R30"]
       || [riderCode isEqualToString:@"WBD10R30"])
    {
        sumLabel.text = @"Guaranteed Yearly Cash Coupons (RM) :";
    }
    else if([riderCode isEqualToString:@"EDUWR"]) {
        sumLabel.text = @"Guaranteed Cash Payment (RM) :";
    }
    else
    {
        sumLabel.text = @"Sum Assured (RM)";
    }
    
    
    
    
}

-(void)RiderPopOverCount:(double)aaCount{
    RiderPopoverCount = aaCount;
}

-(void)PopulateExistingRiderInfo{
    if ([LTypeRiderCode indexOfObject:riderCode] != NSNotFound) { // added in at 2014 10 21
        int indexOfObject = [LTypeRiderCode indexOfObject:riderCode];
        
        NSRange rangeofDot = [[LTypeSumAssured objectAtIndex:indexOfObject ] rangeOfString:@"."];
        NSString *SumToDisplay = @"";
        if (rangeofDot.location != NSNotFound) {
            NSString *substring = [[LTypeSumAssured objectAtIndex:indexOfObject] substringFromIndex:rangeofDot.location ];
            if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                SumToDisplay = [[LTypeSumAssured objectAtIndex:indexOfObject] substringToIndex:rangeofDot.location ];
            }
            else {
                SumToDisplay = [LTypeSumAssured objectAtIndex:indexOfObject];
            }
        }
        else {
            SumToDisplay = [LTypeSumAssured objectAtIndex:indexOfObject];
        }
        
        sumField.text = SumToDisplay;
        
        if([riderCode isEqualToString:@"WBI6R30"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WB30R"]
           || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"] || [riderCode isEqualToString:@"WPTPD30R"]
           || [riderCode isEqualToString:@"WPTPD50R"] || [riderCode isEqualToString:@"EDUWR"])
        {
            
        }else
        {
            termField.text = [LTypeTerm objectAtIndex:indexOfObject];
        }
        
        unitField.text = [LTypeUnits objectAtIndex:indexOfObject];
        
        if (  ![[LTypePlanOpt objectAtIndex:indexOfObject] isEqualToString:@"(null)"]) {
            //            [planBtn setTitle:[LTypePlanOpt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self setPlanBtnTitle:[LTypePlanOpt objectAtIndex:indexOfObject]];
            planOption = [[NSString alloc] initWithFormat:@"%@",planBtn.titleLabel.text];
        }
        
        if (  ![[LTypeDeduct objectAtIndex:indexOfObject] isEqualToString:@"(null)"]) {
            [deducBtn setTitle:[LTypeDeduct objectAtIndex:indexOfObject] forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",deducBtn.titleLabel.text];
        }
        
        NSRange rangeofDotHL = [[LTypeRidHL1K objectAtIndex:indexOfObject ] rangeOfString:@"."];
        NSString *HLToDisplay = @"";
        if (rangeofDotHL.location != NSNotFound) {
            NSString *substringHL = [[LTypeRidHL1K objectAtIndex:indexOfObject] substringFromIndex:rangeofDotHL.location ];
            if (substringHL.length == 2 && [substringHL isEqualToString:@".0"]) {
                HLToDisplay = [[LTypeRidHL1K objectAtIndex:indexOfObject] substringToIndex:rangeofDotHL.location ];
            }
            else {
                HLToDisplay = [LTypeRidHL1K objectAtIndex:indexOfObject];
            }
        }
        else {
            HLToDisplay = [LTypeRidHL1K objectAtIndex:indexOfObject];
        }
        
        if (![[LTypeRidHL1K objectAtIndex:indexOfObject] isEqualToString:@"(null)"] && ![HLToDisplay isEqualToString:@"0"]) {
            HLField.text = HLToDisplay;
        }
        else {
            HLField.text = @"";
        }
        
        if (  ![[LTypeRidHLTerm objectAtIndex:indexOfObject] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHLTerm objectAtIndex:indexOfObject];
        }
        
        NSRange rangeofDotHL100 = [[LTypeRidHL100 objectAtIndex:indexOfObject ] rangeOfString:@"."];
        NSString *HL100ToDisplay = @"";
        if (rangeofDotHL100.location != NSNotFound) {
            NSString *substringHL100 = [[LTypeRidHL100 objectAtIndex:indexOfObject] substringFromIndex:rangeofDotHL100.location ];
            if (substringHL100.length == 2 && [substringHL100 isEqualToString:@".0"]) {
                HL100ToDisplay = [[LTypeRidHL100 objectAtIndex:indexOfObject] substringToIndex:rangeofDotHL100.location ];
            }
            else {
                HL100ToDisplay = [LTypeRidHL100 objectAtIndex:indexOfObject];
            }
        }
        else {
            HL100ToDisplay = [LTypeRidHL100 objectAtIndex:indexOfObject];
        }
        
        if (![[LTypeRidHL100 objectAtIndex:indexOfObject] isEqualToString:@"(null)"]) {
            HLField.text = HL100ToDisplay;
        }
        
        if (  ![[LTypeRidHL100Term objectAtIndex:indexOfObject] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHL100Term objectAtIndex:indexOfObject];
        }
        
        if (  ![[LTypeRidHLP objectAtIndex:indexOfObject] isEqualToString:@"(null)"]) {
            HLField.text = [LTypeRidHLP objectAtIndex:indexOfObject];
        }
        
        if (  ![[LTypeRidHLPTerm objectAtIndex:indexOfObject] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHLPTerm objectAtIndex:indexOfObject];
        }
        
        NSRange rangeofDotTempHL = [[LTypeTempRidHL1K objectAtIndex:indexOfObject ] rangeOfString:@"."];
        NSString *TempHLToDisplay = @"";
        if (rangeofDotTempHL.location != NSNotFound) {
            NSString *substringTempHL = [[LTypeTempRidHL1K objectAtIndex:indexOfObject] substringFromIndex:rangeofDotTempHL.location ];
            if (substringTempHL.length == 2 && [substringTempHL isEqualToString:@".0"]) {
                TempHLToDisplay = [[LTypeTempRidHL1K objectAtIndex:indexOfObject] substringToIndex:rangeofDotTempHL.location ];
            }
            else {
                TempHLToDisplay = [LTypeTempRidHL1K objectAtIndex:indexOfObject];
            }
        }
        else {
            TempHLToDisplay = [LTypeTempRidHL1K objectAtIndex:indexOfObject];
        }
        
        tempHLField.text = TempHLToDisplay;
        tempHLTField.text = [LTypeTempRidHLTerm objectAtIndex:indexOfObject];
    }
}

-(void)CalcPrem{
    if ([riderCode isEqualToString: @"WPTPD30R"]||[riderCode isEqualToString: @"WPTPD50R"] || [riderCode isEqualToString: @"LCPR"] || [riderCode isEqualToString: @"PLCP"] ||
        [riderCode isEqualToString: @"ACIR_MPP"]||[riderCode isEqualToString: @"CIR"] || [riderCode isEqualToString: @"ICR"]) {
        
        [self getBasicSARate]; // to get the latest basic SA because sometime MHI revise the SA but rider tab havent get the latest SA
        
        PremiumViewController *premView = [self.storyboard instantiateViewControllerWithIdentifier:@"premiumView"];
        premView.requestAge = getAge;
        premView.requestOccpClass = getOccpClass;
        premView.requestOccpCode = getOccpCode;
        premView.requestSINo = getSINo;
        premView.requestMOP = getMOP;
        premView.requestTerm = getTerm;
        premView.requestBasicSA = [NSString stringWithFormat:@"%f", getBasicSA ];
        premView.requestBasicHL = [NSString stringWithFormat:@"%f", getBasicHL ];
        premView.requestBasicTempHL = [NSString stringWithFormat:@"%f", getBasicTempHL ];
        premView.requestPlanCode = getPlanChoose;
        premView.requestBasicPlan = getPlanChoose;
        premView.sex = getSex;
        premView.EAPPorSI = [self.EAPPorSI description];
        premView.fromReport = FALSE;
        premView.executeMHI = FALSE;
        
        UIView *zzz = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 0, 0) ];
        [zzz addSubview:premView.view];
        //NSLog(@"%f", premView.ReturnGrossPrem) ;
        
        dblGrossPrem = premView.ReturnGrossPrem;
        
        //[self presentViewController:premView animated:NO completion:Nil];

        //[premView dismissViewControllerAnimated:NO completion:Nil];
        [zzz removeFromSuperview ];
        zzz = Nil;
        premView = Nil;
    }
}

-(void)PlanView:(RiderPlanTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc
{
	Edit = TRUE;
    NSLog(@"selectPlan:%@",itemdesc);
    if ([atcRidCode count] != 0)
    {
        NSUInteger k;
        for (k=0; k<[atcRidCode count]; k++) {
            if ([riderCode isEqualToString:@"HMM"] && [[atcPlanChoice objectAtIndex:k] isEqualToString:itemdesc]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider not available - does not meet underwriting rules." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                //                [self.planBtn setTitle:@"" forState:UIControlStateNormal];
                [self setPlanBtnTitle:@""];
                planOption = nil;
                
            } else {
                //                [self.planBtn setTitle:itemdesc forState:UIControlStateNormal];
                [self setPlanBtnTitle:itemdesc];
                planOption = [[NSString alloc] initWithFormat:@"%@",itemdesc];  
            }
        }
    } else {
        
        if ([itemdesc isEqualToString:@"HMM_1000"]) {
            NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
            self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:itemdesc];
            _deductList.delegate = self;
            
            [self.deducBtn setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        }
        if (![itemdesc isEqualToString:planOption] && [planOption isEqualToString:@"HMM_1000"]) {
            NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
            self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:itemdesc];
            _deductList.delegate = self;
            
            [self.deducBtn setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        }
        
        //        [self.planBtn setTitle:itemdesc forState:UIControlStateNormal];
        [self setPlanBtnTitle:itemdesc];
        planOption = [[NSString alloc] initWithFormat:@"%@",itemdesc];
        
        
    }
    [self.planPopover dismissPopoverAnimated:YES];
}

-(void)deductView:(RiderDeducTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc
{
	Edit = TRUE;
    NSLog(@"selectDeduc:%@",itemdesc);
    [self.deducBtn setTitle:itemdesc forState:UIControlStateNormal];
    deductible = [[NSString alloc] initWithFormat:@"%@",itemdesc];
    
    [self.deducPopover dismissPopoverAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return [LTypeRiderCode count];
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    
    [[cell.contentView viewWithTag:2001] removeFromSuperview ];
    [[cell.contentView viewWithTag:2002] removeFromSuperview ];
    [[cell.contentView viewWithTag:2003] removeFromSuperview ];
    [[cell.contentView viewWithTag:2004] removeFromSuperview ];
    [[cell.contentView viewWithTag:2005] removeFromSuperview ];
    [[cell.contentView viewWithTag:2006] removeFromSuperview ];
    [[cell.contentView viewWithTag:2007] removeFromSuperview ];
    [[cell.contentView viewWithTag:2008] removeFromSuperview ];
    [[cell.contentView viewWithTag:2009] removeFromSuperview ];
    [[cell.contentView viewWithTag:2010] removeFromSuperview ];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    CGRect frame=CGRectMake(-21,0, 111, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"    %@",[LTypeRiderCode objectAtIndex:indexPath.row]];
//    label1.textAlignment = UITextAlignmentCenter;
    label1.textAlignment = NSTextAlignmentCenter;
    label1.tag = 2001;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label1];
    
    CGRect frame2=CGRectMake(90,0, 105, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    NSString *num = [formatter stringFromNumber:[NSNumber numberWithDouble:[[LTypeSumAssured objectAtIndex:indexPath.row] doubleValue]]];
    label2.text= num;
//    label2.textAlignment = UITextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.tag = 2002;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label2];
    
    CGRect frame3=CGRectMake(195,0, 45, 50);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
    label3.text= [LTypeTerm objectAtIndex:indexPath.row];
//    label3.textAlignment = UITextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.tag = 2003;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label3];
    
    CGRect frame4=CGRectMake(frame3.origin.x + frame3.size.width,0, 50, 50);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
    if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HB" ]){
        label4.text= [LTypeUnits objectAtIndex:indexPath.row];
    }
    else{
        label4.text= @"-";
    }
    
//    label4.textAlignment = UITextAlignmentCenter;
    label4.textAlignment = NSTextAlignmentCenter;
    label4.tag = 2004;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label4];
    
    CGRect frame5=CGRectMake(frame4.origin.x + frame4.size.width,0, 50, 50);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
	if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"CPA" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HMM" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HSP_II"] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MG_II" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MG_IV" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"PA" ]) {
        label5.text= [NSString stringWithFormat:@"%d",occClass];
	}
	else{
        label5.text= [NSString stringWithFormat:@"-"];
	}
//    label5.textAlignment = UITextAlignmentCenter;
    label5.textAlignment = NSTextAlignmentCenter;
    label5.tag = 2005;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label5];
    
    CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width,0, 50, 50);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
	if (
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"CCTR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"EDB"] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TPDYLA"] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ETPDB" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ICR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LCPR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LCWP" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"PR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"PLCP" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"PTR" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WB30R" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WB50R" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"EDUWR" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WBI6R30" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WBD10R30" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WP30R" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WP50R" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WPTPD30R" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"WPTPD50R" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"SP_PRE" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"SP_STD" ]) {
		label6.text= [NSString stringWithFormat:@"%@",occLoadType];
	}
	else{
		label6.text= [NSString stringWithFormat:@"-"];
	}
//    label6.textAlignment = UITextAlignmentCenter;
    label6.textAlignment = NSTextAlignmentCenter;
    label6.tag = 2006;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label6];
    
    //---
    
    NSString *hl1k = [LTypeRidHL1K objectAtIndex:indexPath.row];
    NSString *hl100 = [LTypeRidHL100 objectAtIndex:indexPath.row];
    NSString *hlp = [LTypeRidHLP objectAtIndex:indexPath.row];
    //    NSLog(@"HL(%@)-1k:%@, 100k:%@, p:%@",[LTypeRiderCode objectAtIndex:indexPath.row],hl1k,hl100,hlp);
    
    CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,0, 70, 50);
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    NSString *hl1 = nil;
    if ([hl1k isEqualToString:@"(null)"] && [hl100 isEqualToString:@"(null)"] && [hlp isEqualToString:@"(null)"]) {
        hl1 = @"";
    }
    else if(![hl100 isEqualToString:@"(null)"] && ![hl100 isEqualToString:@""] ){
        hl1 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hl100 doubleValue]]];
    }
    else if (![hl1k isEqualToString:@"(null)"] && [hl1k doubleValue] > 0) {
        hl1 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hl1k doubleValue]]];
    }
    else if (![hlp isEqualToString:@"(null)"] && [hlp doubleValue] > 0) {
        hl1 = [[formatter stringFromNumber:[NSNumber numberWithDouble:[hlp doubleValue]]] stringByAppendingString:@"%"];
    }
    else {
        hl1 = @"";
    }
    label7.text= hl1;
//    label7.textAlignment = UITextAlignmentCenter;
    label7.textAlignment = NSTextAlignmentCenter;
    label7.tag = 2007;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label7];
    
    //---
    
    NSString *hl1kT = [LTypeRidHLTerm objectAtIndex:indexPath.row];
    NSString *hl100T = [LTypeRidHL100Term objectAtIndex:indexPath.row];
    NSString *hlpT = [LTypeRidHLPTerm objectAtIndex:indexPath.row];
    
    CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,0, 80, 50);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    NSString *hl1T = nil;
    if ([hl1kT intValue] == 0 && [hl100T intValue] == 0 && [hlpT intValue] == 0) {
        hl1T = @"";
    }
    else if([hl1kT intValue] !=0) {
        hl1T = hl1kT;
    }
    else if([hl100T intValue] !=0) {
        hl1T = hl100T;
    }
    else if ([hlpT intValue] != 0) {
        hl1T = hlpT;
    }
    else {
        hl1T = @"";
    }
    label8.text= hl1T;
//    label8.textAlignment = UITextAlignmentCenter;
    label8.textAlignment = NSTextAlignmentCenter;
    label8.tag = 2008;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label8];
    
    //--
    
    NSString *hlTemp = [LTypeTempRidHL1K objectAtIndex:indexPath.row];
    NSString *hlTempT = [LTypeTempRidHLTerm objectAtIndex:indexPath.row];
    
    CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width,0, 80, 50);
    UILabel *label9=[[UILabel alloc]init];
    label9.frame=frame9;
    NSString *hl2 = nil;
    if ([hlTemp isEqualToString:@"(null)"] ||hlTemp.length == 0) {
        hl2 = @"";
    } else {
        hl2 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hlTemp doubleValue]]];
        
        if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HMM"] ||
            [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HSP_II"] ||
            [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MG_IV"] ||
            [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MG_II"]) {
            label9.text= [hl2 stringByAppendingString:@"%"];
        }
        else{
            label9.text=hl2;
        }
    }
    
//    label9.textAlignment = UITextAlignmentCenter;
    label9.textAlignment = NSTextAlignmentCenter;
    label9.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label9];
    
    //--
    
    CGRect frame10=CGRectMake(frame9.origin.x + frame9.size.width,0, 70, 50);
    UILabel *label10=[[UILabel alloc]init];
    label10.frame=frame10;
    NSString *hl2T = nil;
    if ([hlTempT intValue] == 0 || hlTempT.length == 0) {
        hl2T = @"";
    } else {
        hl2T = [NSString stringWithFormat:@"    %@",hlTempT];
    }
    label10.text=hl2T;
//    label10.textAlignment = UITextAlignmentLeft;
    label10.textAlignment = NSTextAlignmentLeft;
    label10.tag = 2010;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label10];
    
    //--
    
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label7.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label8.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label9.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label10.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label7.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label8.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label9.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    else {
        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label5.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label7.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label8.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label9.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label10.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label7.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label8.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label9.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *zzz = [myTableView cellForRowAtIndexPath:indexPath];
    zzz.frame = CGRectMake(zzz.frame.origin.x,zzz.frame.origin.y,688,zzz.frame.size.height);

    
    if ([myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }
    else {
        
        RiderListTbViewController *zzz = [[RiderListTbViewController alloc] init ];
        [self RiderListController:zzz didSelectCode:[LTypeRiderCode objectAtIndex:indexPath.row] desc:[self getRiderDesc:[LTypeRiderCode objectAtIndex:indexPath.row]]];
        
        NSRange rangeofDot = [[LTypeSumAssured objectAtIndex:indexPath.row ] rangeOfString:@"."];
        NSString *SumToDisplay = @"";
        if (rangeofDot.location != NSNotFound) {
            NSString *substring = [[LTypeSumAssured objectAtIndex:indexPath.row] substringFromIndex:rangeofDot.location ];
            if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                SumToDisplay = [[LTypeSumAssured objectAtIndex:indexPath.row] substringToIndex:rangeofDot.location ];
            }
            else {
                SumToDisplay = [LTypeSumAssured objectAtIndex:indexPath.row];
            }
        }
        else {
            SumToDisplay = [LTypeSumAssured objectAtIndex:indexPath.row];
        }
        
        sumField.text = SumToDisplay;
        
        if([riderCode isEqualToString:@"WA30R"] || [riderCode isEqualToString:@"WA50R"] || [riderCode isEqualToString:@"WB30R"]
           || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WE30R"] || [riderCode isEqualToString:@"WE50R"]
           || [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"] || [riderCode isEqualToString:@"WPTPD30R"]
           || [riderCode isEqualToString:@"WPTPD50R"] || [riderCode isEqualToString:@"EDUWR"])
        {
            
        } else {
            termField.text = [LTypeTerm objectAtIndex:indexPath.row];
        }
        
        unitField.text = [LTypeUnits objectAtIndex:indexPath.row];
        
        if (  ![[LTypePlanOpt objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            [self setPlanBtnTitle:[LTypePlanOpt objectAtIndex:indexPath.row]];
            planOption = [[NSString alloc] initWithFormat:@"%@",planBtn.titleLabel.text];
        }
        
        if (  ![[LTypeDeduct objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            [deducBtn setTitle:[LTypeDeduct objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",deducBtn.titleLabel.text];
        }
        
        NSRange rangeofDotHL = [[LTypeRidHL1K objectAtIndex:indexPath.row ] rangeOfString:@"."];
        NSString *HLToDisplay = @"";
        if (rangeofDotHL.location != NSNotFound) {
            NSString *substringHL = [[LTypeRidHL1K objectAtIndex:indexPath.row] substringFromIndex:rangeofDotHL.location ];
            if (substringHL.length == 2 && [substringHL isEqualToString:@".0"]) {
                HLToDisplay = [[LTypeRidHL1K objectAtIndex:indexPath.row] substringToIndex:rangeofDotHL.location ];
            }
            else {
                HLToDisplay = [LTypeRidHL1K objectAtIndex:indexPath.row];
            }
        } else {
            HLToDisplay = [LTypeRidHL1K objectAtIndex:indexPath.row];
        }
        
        if (![[LTypeRidHL1K objectAtIndex:indexPath.row] isEqualToString:@"(null)"] && ![HLToDisplay isEqualToString:@"0"]) {
            HLField.text = HLToDisplay;
        } else {
            HLField.text = @"";
        }
        
        if (  ![[LTypeRidHLTerm objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHLTerm objectAtIndex:indexPath.row];
        }
        
        NSRange rangeofDotHL100 = [[LTypeRidHL100 objectAtIndex:indexPath.row ] rangeOfString:@"."];
        NSString *HL100ToDisplay = @"";
        if (rangeofDotHL100.location != NSNotFound) {
            NSString *substringHL100 = [[LTypeRidHL100 objectAtIndex:indexPath.row] substringFromIndex:rangeofDotHL100.location ];
            if (substringHL100.length == 2 && [substringHL100 isEqualToString:@".0"]) {
                HL100ToDisplay = [[LTypeRidHL100 objectAtIndex:indexPath.row] substringToIndex:rangeofDotHL100.location ];
            } else {
                HL100ToDisplay = [LTypeRidHL100 objectAtIndex:indexPath.row];
            }
        } else {
            HL100ToDisplay = [LTypeRidHL100 objectAtIndex:indexPath.row];
        }
        
        if (![[LTypeRidHL100 objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            HLField.text = HL100ToDisplay;
        }
        
        if (  ![[LTypeRidHL100Term objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHL100Term objectAtIndex:indexPath.row];
        }
        
        if (  ![[LTypeRidHLP objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            HLField.text = [LTypeRidHLP objectAtIndex:indexPath.row];
        }
        
        if (  ![[LTypeRidHLPTerm objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
            HLTField.text = [LTypeRidHLPTerm objectAtIndex:indexPath.row];
        }
        
        NSRange rangeofDotTempHL = [[LTypeTempRidHL1K objectAtIndex:indexPath.row ] rangeOfString:@"."];
        NSString *TempHLToDisplay = @"";
        if (rangeofDotTempHL.location != NSNotFound) {
            NSString *substringTempHL = [[LTypeTempRidHL1K objectAtIndex:indexPath.row] substringFromIndex:rangeofDotTempHL.location ];
            if (substringTempHL.length == 2 && [substringTempHL isEqualToString:@".0"]) {
                TempHLToDisplay = [[LTypeTempRidHL1K objectAtIndex:indexPath.row] substringToIndex:rangeofDotTempHL.location ];
            }
            else {
                TempHLToDisplay = [LTypeTempRidHL1K objectAtIndex:indexPath.row];
            }   
        }
        else {
            TempHLToDisplay = [LTypeTempRidHL1K objectAtIndex:indexPath.row];
        }
        
        tempHLField.text = TempHLToDisplay;
        tempHLTField.text = [LTypeTempRidHLTerm objectAtIndex:indexPath.row];
        
        if (Editable == NO) {
            [self DisableTextField:termField];
            [self DisableTextField:sumField];
            [self DisableTextField:cpaField];
            [self DisableTextField:unitField];
            [self DisableTextField:occpField];
            [self DisableTextField:HLField];
            [self DisableTextField:HLTField];
            [self DisableTextField:tempHLField];
            [self DisableTextField:tempHLTField];
            [self DisableTextField:classField];
            
            btnAddRider.enabled = FALSE;
            planBtn.enabled = FALSE;
            deducBtn.enabled = FALSE;
            classField.enabled = FALSE;
            editBtn.enabled = FALSE;
            deleteBtn.enabled = FALSE;
            btnAddRider.hidden = TRUE;
            outletSaveRider.enabled = FALSE;
            
            if([EAPPorSI isEqualToString:@"eAPP"]){
                outletSaveRider.backgroundColor = [UIColor lightGrayColor];
                [outletSaveRider setBackgroundColor:[UIColor lightGrayColor]];
                outletEAPP.width = 0;
                outletSpace.width = 564;
                outletDone.enabled = FALSE;
                
            }
            
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *cell in [myTableView visibleCells])
        {
            if (cell.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *str = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:str];
        [indexPaths removeObject:indexPath];
    }
}

#pragma mark - Memory Management

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.pTypePopOver = nil;
    self.RiderListPopover = nil;
    self.planPopover = nil;
    self.deducPopover = nil;
}

- (void)viewDidUnload
{
    [self resignFirstResponder];
    [self setTempHLField:nil];
    [self setTempHLTField:nil];
    [self setDataInsert:nil];
    [self setRiderList:nil];
    [self setPlanList:nil];
    [self setDeductList:nil];
    [self setDelegate:nil];
    [self setRequestSINo:nil];
    [self setRequestPlanCode:nil];
    [self setRequestSex:nil];
    [self setRequestOccpCode:nil];
    [self setRequestBasicSA:nil];
    [self setRequestBasicHL:nil];
    [self setRequestBasicTempHL:nil];
    [self setGetSINo:nil];
    [self setGetPlanCode:nil];
    [self setGetSex:nil];
    [self setGetOccpCode:nil];
    [self setRiderListPopover:nil];
    [self setPlanPopover:nil];
    [self setDeducPopover:nil];
    [self setPTypePopOver:nil];
    [self setBtnPType:nil];
    [self setBtnAddRider:nil];
    [self setTermLabel:nil];
    [self setSumLabel:nil];
    [self setPlanLabel:nil];
    [self setCpaLabel:nil];
    [self setUnitLabel:nil];
    [self setOccpLabel:nil];
    [self setHLLabel:nil];
    [self setHLTLabel:nil];
    [self setTermField:nil];
    [self setSumField:nil];
    [self setCpaField:nil];
    [self setUnitField:nil];
    [self setOccpField:nil];
    [self setHLField:nil];
    [self setHLTField:nil];
    [self setPlanBtn:nil];
    [self setDeducBtn:nil];
    [self setMinDisplayLabel:nil];
    [self setMaxDisplayLabel:nil];
    [self setClassField:nil];
    [self setMyToolBar:nil];
    [self setPTypeCode:nil];
    [self setPTypeDesc:nil];
    [self setPTypeOccp:nil];
    [self setRiderCode:nil];
    [self setRiderDesc:nil];
    [self setFLabelCode:nil];
    [self setFLabelDesc:nil];
    [self setFRidName:nil];
    [self setFTbName:nil];
    [self setFInputCode:nil];
    [self setFFieldName:nil];
    [self setFCondition:nil];
    [self setPlanCondition:nil];
    [self setDeducCondition:nil];
    [self setDeductible:nil];
    [self setInputHL1KSA:nil];
    [self setInputHL100SA:nil];
    [self setInputHLPercentage:nil];
    [self setAtcRidCode:nil];
    [self setAtcPlanChoice:nil];
    [self setExistRidCode:nil];
    [self setSecondLARidCode:nil];
    [self setPayorRidCode:nil];
    [self setMyTableView:nil];
    [self setTitleRidCode:nil];
    [self setTitleSA:nil];
    [self setTitleTerm:nil];
    [self setTitleUnit:nil];
    [self setTitleClass:nil];
    [self setTitleLoad:nil];
    [self setTitleHL1K:nil];
    [self setTitleHL100:nil];
    [self setTitleHLP:nil];
    [self setEditBtn:nil];
    [self setDeleteBtn:nil];
    [self setTitleHLPTerm:nil];
    [self setLRiderCode:nil];
    [self setLSumAssured:nil];
    [self setLTerm:nil];
    [self setLPlanOpt:nil];
    [self setLUnits:nil];
    [self setLDeduct:nil];
    [self setLOccpCode:nil];
    [self setLRidHL1K:nil];
    [self setLRidHLTerm:nil];
    [self setLRidHL100:nil];
    [self setLRidHL100Term:nil];
    [self setLRidHLP:nil];
    [self setLRidHLPTerm:nil];
    [self setLSmoker:nil];
    [self setLSex:nil];
    [self setLAge:nil];
    [self setLTypeRiderCode:nil];
    [self setLTypeSumAssured:nil];
    [self setLTypeTerm:nil];
    [self setLTypePlanOpt:nil];
    [self setLTypeUnits:nil];
    [self setLTypeDeduct:nil];
    [self setLTypeOccpCode:nil];
    [self setLTypeRidHL1K:nil];
    [self setLTypeRidHLTerm:nil];
    [self setLTypeRidHL100:nil];
    [self setLTypeRidHL100Term:nil];
    [self setLTypeRidHLP:nil];
    [self setLTypeRidHLPTerm:nil];
    [self setLTypeSmoker:nil];
    [self setLTypeSex:nil];
    [self setLTypeAge:nil];
    [self setSex:nil];
    [self setOccpCat:nil];
    [self setPentaSQL:nil];
    [self setMedPentaSQL:nil];
    [self setPlnOptC:nil];
    [self setPlanOptHMM:nil];
    [self setDeducHMM:nil];
    [self setPlanHSPII:nil];
    [self setPlanMGII:nil];
    [self setPlanMGIV:nil];
    [self setPlanCodeRider:nil];
    [self setMedPlanCodeRider:nil];
    [self setMedRiderCode:nil];
    [self setMedPlanOpt:nil];
    [self setAnnualRiderPrem:nil];
    [self setHalfRiderPrem:nil];
    [self setQuarterRiderPrem:nil];
    [self setMonthRiderPrem:nil];
    [self setArrCombNo:nil];
    [self setArrRBBenefit:nil];
    [self setAnnualMedRiderPrem:nil];
    [self setQuarterMedRiderPrem:nil];
    [self setHalfMedRiderPrem:nil];
    [self setMonthMedRiderPrem:nil];
    [self setWaiverRiderAnn:nil];
    [self setWaiverRiderAnn2:nil];
    [self setWaiverRiderHalf:nil];
    [self setWaiverRiderHalf2:nil];
    [self setWaiverRiderQuar:nil];
    [self setWaiverRiderQuar2:nil];
    [self setWaiverRiderMonth:nil];
    [self setWaiverRiderMonth2:nil];
    [self setIncomeRiderAnn:nil];
    [self setIncomeRiderHalf:nil];
    [self setIncomeRiderQuar:nil];
    [self setIncomeRiderMonth:nil];
    [self setIncomeRiderGYI:nil];
    [self setIncomeRiderCSV:nil];
    [self setIncomeRiderSA:nil];
    [self setIncomeRiderCode:nil];
    [self setIncomeRiderTerm:nil];
    [self setTempHLField:nil];
    [self setTempHLTField:nil];
    [self setTempHLLabel:nil];
    [self setTempHLTLabel:nil];
    [self setMyScrollView:nil];
    [self setOccLoadType:nil];
    [self setHeaderTitle:nil];
    [self setOutletDone:nil];
	[self setOutletSaveRider:nil];
    [self setOutletEAPP:nil];
    [self setOutletSpace:nil];
    [super viewDidUnload];
}

-(void)clearField
{
    term = NO;
    sumA = NO;
    plan = NO;
    unit = NO;
    deduc = NO;
    hload = NO;
    hloadterm = NO;
    planOption = nil;
    deductible = nil;
    inputHL100SA = nil;
    inputHL1KSA = nil;
    inputHLPercentage = nil;
    inputHL1KSATerm = 0;
    inputHL100SATerm = 0;
    inputHLPercentageTerm = 0;
    sumField.text = @"";
    termField.text = @"";
    HLField.text = @"";
    HLTField.text = @"";
    incomeRider = NO;
    unitField.text = @"";
    inputSA = 0;
    secondLARidCode = nil;
    cpaField.text = @"";
    occpField.text = @"";
    tempHLField.text = @"";
    tempHLTField.text = @"";
    minTerm = 0;
    maxTerm = 0;
    minSATerm = 0;
    maxSATerm = 0;
    maxRiderSA = 0;
    storedMaxTerm = 0;
    
    [self setPlanBtnTitle:@""];
    [self.deducBtn setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
}

//basically, to convert the short form to full value @ S = Standard. Temporarily hardcoded, best to be retrieved from trad_sys_other_value, but no time for now due to incredibly short timeline
//@ Edwin 27-03-2014
+(NSString*)getRiderDecFromValue:(NSString *)val
{
    NSString *temp = nil;
    
    if([val isEqualToString:@"S"])
    {
        temp = @"Standard";
    } else if([val isEqualToString:@"D"])
    {
        temp = @"Deluxe";
    } else if([val isEqualToString:@"P"])
    {
        temp = @"Premier";
    } else if([val isEqualToString:@"L"])
    {
        temp = @"Level";
    } else if([val isEqualToString:@"I"])
    {
        temp = @"Increasing";
    } else if([val isEqualToString:@"B"])
    {
        temp = @"Level_NCB";
    } else if([val isEqualToString:@"N"])
    {
        temp = @"Increasing_NCB";
    } else
    {
        temp = val;
    }
    
    return temp;
}

-(void)setPlanBtnTitle:(NSString *)title
{
    if([riderCode isEqualToString:@"C+"] || [riderCode isEqualToString:@"HSP_II"])
    {
        NSString *temp = [self getRiderValFrmDb:title];
        
        if( [temp length] > 0 )
        {
            title = temp;
        }
    }
    
    [planBtn setTitle:title forState:UIControlStateNormal];
}

-(NSString *)getRiderValFrmDb:(NSString *)value
{   
    sqlite3_stmt *statement;
    NSString *returnVal = @"";
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Desc FROM Trad_Sys_Other_Value WHERE Code=\"%@\" and Value=\"%@\"",planCondition,value];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                returnVal = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return returnVal;
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
}

@end
