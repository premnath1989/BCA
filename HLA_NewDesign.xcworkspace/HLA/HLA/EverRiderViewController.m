//
//  EverRiderViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 6/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EverRiderViewController.h"
#import "ColorHexCode.h"
#import "AppDelegate.h"
#import "RiderListTbViewController.h"

@interface EverRiderViewController ()

@end

double CurrentRiderPrem;

@implementation EverRiderViewController
@synthesize requestAge,requestBasicHL,requestBasicHLPct,requestBasicSA,requestCoverTerm,requestOccpClass;
@synthesize requestOccpCode,requestPlanCode,requestSex,requestSINo, getAge,getPlanCode,getBasicHL;
@synthesize getSINo,getBasicHLPct,getBasicSA,getOccpClass,getOccpCode,getSex,getTerm;
@synthesize pTypeAge,pTypeCode,pTypeDesc,pTypeOccp, PTypeSeq, riderCode, riderDesc;
@synthesize outletDeductible,outletPersonType,outletRider,outletRiderPlan;
@synthesize lbl1,lbl2,lbl3,lbl4,lbl5,lbl6,lbl7,lbl8,lblRegular1,lblRegular2,lblRegularTerm,lblRegularTerm2;
@synthesize lblTable1,lblTable2,lblTable3,lblTable4,lblTable5,lblTable6,lblTable7;
@synthesize lblTable8,lblTable9, myScrollView, myTableView, outletDelete, outletEdit;
@synthesize LAge,LDeduct,LOccpCode,LPlanOpt,LRiderCode,LRidHL100,LRidHL100Term,LRidHL1K,LRidHLP;
@synthesize LRidHLPTerm,LRidHLTerm,LSex,LSmoker,LSumAssured, LTerm,LTypeAge,LTypeDeduct,LTypeOccpCode;
@synthesize LTypePlanOpt,LTypeRiderCode,LTypeRidHL100,LTypeRidHL100Term,LTypeRidHL1K,LTypeRidHLP,LTypeRidHLPTerm;
@synthesize LTypeRidHLTerm,LTypeSex,LTypeSmoker,LTypeSumAssured, LTypeTerm, LTypePremium;
@synthesize LTypeUnits, occClass, occLoadType, OccpCat, occCPA, occCPA_PA, occLoad, occLoadRider, occPA;
@synthesize planOption, payorRidCode, pentaSQL, planCodeRider, planCondition, planHSPII, planMGII, planMGIV;
@synthesize planOptHMM, deducCondition, deducHMM, deductible, inputHL100SA, inputHL100SATerm, inputHL1KSA;
@synthesize inputHL1KSATerm,inputHLPercentage,inputHLPercentageTerm,inputSA, secondLARidCode, sex, storedMaxTerm;
@synthesize maxRiderSA,maxRiderTerm,maxSATerm,maxTerm, minSATerm, minTerm, LUnits, requestSmoker, getSmoker;
@synthesize request2ndSmoker,requestPayorSmoker,get2ndSmoker,getPayorSmoker, requestOccpCPA, getOccpCPA;
@synthesize FCondition,FFieldName,FInputCode,FLabelCode,FLabelDesc,FRidName,FTbName;
@synthesize txtGYIFrom,txtHL,txtHLTerm,txtOccpLoad,txtPaymentTerm,txtReinvestment,txtRiderPremium,txtRiderTerm;
@synthesize txtRRTUP,txtRRTUPTerm,txtSumAssured, expAge, existRidCode, lblMax, lblMin, LPremium, outletReinvest;
@synthesize LReinvest, LTypeReinvest, requestBumpMode, age, pTypeSex, riderRate, getBUMPMode, arrCombNo, arrRBBenefit;
@synthesize medRiderCode,medPlanCodeRider, medPlanOpt, CombNo, RBBenefit, AllCombNo, RBGroup, RBLimit;
@synthesize LPaymentTerm,LTypePaymentTerm, LTypeRRTUOFromYear, LTypeRRTUOYear, LRRTUOFromYear, LRRTUOYear;
@synthesize lblHLP,lblHLPTerm, txtHLP,txtHLPTerm;
@synthesize delegate = _delegate;
@synthesize RiderList = _RiderList;
@synthesize RiderListPopover = _RiderListPopover;
@synthesize planPopover = _planPopover;
@synthesize deducPopover = _deducPopover;
@synthesize planList = _planList;
@synthesize deductList = _deductList;
@synthesize PTypeList = _PTypeList;
@synthesize pTypePopOver = _pTypePopOver;




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
	
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    UL_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"UL_Rates.sqlite"]];
	
    
    //--------- edited by heng
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.MhiMessage = @"";
    //-----------
	
	
	getSINo = [self.requestSINo description];
    getPlanCode = [self.requestPlanCode description];
    getAge = self.requestAge;
    getSex = [self.requestSex description];
    getTerm = self.requestCoverTerm;
    getBasicSA = [[self.requestBasicSA description] doubleValue];
    getBasicHL = [[self.requestBasicHL description] doubleValue];
    getBasicHLPct = [[self.requestBasicHLPct description] doubleValue];
    getOccpClass = self.requestOccpClass;
    getOccpCode = [self.requestOccpCode description];
	getSmoker = [self.requestSmoker description];
	get2ndSmoker = [self.request2ndSmoker description];
	getPayorSmoker = [self.requestPayorSmoker description];
	getOccpCPA = [self.requestOccpCPA description];
	getBUMPMode = [self.requestBumpMode description];
	
	outletDeductible.hidden = YES;
	outletRiderPlan.hidden =YES;
	PtypeChange = NO;
	
	if (requestSINo) {
        self.PTypeList = [[RiderPTypeTbViewController alloc]initWithString:getSINo str:@"EVER"];
        _PTypeList.delegate = self;
        pTypeCode = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedCode];
        PTypeSeq = [self.PTypeList.selectedSeqNo intValue];
        pTypeDesc = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedDesc];
        pTypeAge = [self.PTypeList.selectedAge intValue];
        pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
        [self.outletPersonType setTitle:pTypeDesc forState:UIControlStateNormal];
    }
    _PTypeList = nil;
	
	txtRiderTerm.delegate = self;
	txtPaymentTerm.delegate = self;
	txtReinvestment.delegate = self;
	txtGYIFrom.delegate = self;	
	txtSumAssured.delegate = self;
	txtRRTUPTerm.delegate = self;
	txtRRTUP.delegate =self;
	txtHL.delegate = self;
	txtHLTerm.delegate = self;
	txtHLP.delegate = self;
	txtHLPTerm.delegate = self;
	
	txtRiderTerm.tag = 1;
	txtPaymentTerm.tag = 2;
	txtReinvestment.tag = 3;
	txtGYIFrom.tag = 4;
	txtSumAssured.tag = 5;
	txtRRTUPTerm.tag = 6;
	txtRRTUP.tag =7;
	txtHL.tag = 8;
	txtHLTerm.tag = 9;
	txtHLP.tag = 10;
	txtHLPTerm.tag = 11;
	
	UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
														   forKey:UITextAttributeFont];
	[outletReinvest setTitleTextAttributes:attributes
								 forState:UIControlStateNormal];
	
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	
	int y= 445;
	CGRect frame=CGRectMake(45,y, 80, 50);
	lblTable1.text = @"Rider";
	lblTable1.frame = frame;
	lblTable1.textAlignment = UITextAlignmentCenter;
	lblTable1.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable1.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
	lblTable1.numberOfLines = 2;
	
	CGRect frame2=CGRectMake(125,y, 95, 50); // premium
	lblTable2.frame = frame2;
	lblTable2.textAlignment = UITextAlignmentCenter;
	lblTable2.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable2.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame3=CGRectMake(220,y, 95, 50); // sum Assured
	lblTable3.frame = frame3;
	lblTable3.textAlignment = UITextAlignmentCenter;
	lblTable3.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable3.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame4=CGRectMake(315,y, 62, 50); //Term
	lblTable4.frame = frame4;
	lblTable4.textAlignment = UITextAlignmentCenter;
	lblTable4.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable4.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame5=CGRectMake(377,y, 62, 50);
	lblTable5.text = @"Units";
	lblTable5.frame = frame5;
	lblTable5.textAlignment = UITextAlignmentCenter;
	lblTable5.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable5.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
	lblTable5.numberOfLines = 2;
	
    CGRect frame6=CGRectMake(439, y, 62, 50);
	lblTable6.text = @"Occ \nClass";
	lblTable6.frame = frame6;
	lblTable6.textAlignment = UITextAlignmentCenter;
	lblTable6.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable6.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
	lblTable6.numberOfLines = 2;
    
    CGRect frame7=CGRectMake(501,y, 63, 50);
	lblTable7.text = @"Occp \nLoading";
	lblTable7.numberOfLines = 2;
	lblTable7.frame = frame7;
	lblTable7.textAlignment = UITextAlignmentCenter;
	lblTable7.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable7.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame8=CGRectMake(564,y, 63, 50);
	lblTable8.text = @"HL";
	lblTable8.frame = frame8;
	lblTable8.textAlignment = UITextAlignmentCenter;
	lblTable8.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable8.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
	lblTable8.numberOfLines = 2;
    
    CGRect frame9=CGRectMake(627, y, 80, 50);
	lblTable9.text = @"HL\nTerm";
	lblTable9.frame = frame9;
	lblTable9.textAlignment = UITextAlignmentCenter;
	lblTable9.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
	lblTable9.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];

    [self getOccLoad];
    [self getCPAClassType];
    [self getOccpCatCode];
    [self getLSDRate];
    //NSLog(@"basicRate:%d, lsdRate:%d, occpLoad:%d, cpa:%d, pa:%d",basicRate,LSDRate,occLoad,occCPA,occPA);
    
    [self getListingRiderByType];
    [self getListingRider];
	[self CalcTotalRiderPrem];
    //[self calculateBasicPremium];
    
    //[self calculateRiderPrem];
    //[self calculateWaiver];
    //[self calculateMedRiderPrem];
	
	myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.opaque = NO;
    myTableView.backgroundView = nil;
	myTableView.delegate = self;
	myTableView.dataSource = self;
    [self.view addSubview:myTableView];
	
	[outletEdit setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [outletEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    outletEdit.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletEdit.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [outletDelete setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	outletDelete.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletDelete.titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	[outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
	ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
	outletDelete.hidden = TRUE;
	outletReinvest.hidden = TRUE;
	 
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
    //minDisplayLabel.text = @"";
    //maxDisplayLabel.text = @"";
    
    self.myScrollView.frame = CGRectMake(0, 44, 768, 453);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	switch (textField.tag) {
		case 0:
			lblMax.text = @"";
			lblMin.text = @"";
            break;
		case 2: //payment term
			if ([riderCode isEqualToString:@"RRTUO"]) {
				lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
				lblMax.text = [NSString stringWithFormat:@"Max Term: %d", (getTerm - [txtRiderTerm.text intValue])];
			}
			break;
		case 1: // term
			lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
			lblMax.text = [NSString stringWithFormat:@"Max Term: %.f",maxRiderTerm];
			break;
		case 5: // sum assured or premium
			lblMin.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
			
			if ([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"ECAR"] ||
				[riderCode isEqualToString:@"ECAR6"] || [riderCode isEqualToString:@"ECAR55"] ) {
				lblMax.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting"];
			}
			else if ([riderCode isEqualToString:@"RRTUO"]){
				lblMax.text = @"";
				lblMin.text = @"";
			}
			else if ([riderCode isEqualToString:@"ACIR"]){
				lblMax.numberOfLines = 2;
				lblMax.text = [NSString stringWithFormat:@"Max SA: %.f(Subject to CI Benefit\nLimit per Life of RM1.5mil)",maxRiderSA];
			}
			else{
				lblMax.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
			}
		
			break;
		default:
			lblMin.text = @"";
			lblMax.text = @"";
            break;
			
	}
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	/*
	NSString *newString     = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    if ([arrayOfString count] > 2 )
    {
        return NO;
    }
    */
	
	if ([string length ] == 0) {
		return  YES;
	}
	
	if (textField.tag == 1 || textField.tag == 8 || textField.tag == 9 || textField.tag == 10 || textField.tag == 11) {
		NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
			return NO;
		}
		
		if (textField.tag != 8 && textField.text.length > 2) {
			return NO;
		}
	}
	else{
		if (ECAR55MonthlyIncome == TRUE || ECARYearlyIncome == TRUE || ECAR6YearlyIncome == TRUE ) {
			NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
			if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
				return NO;
			}
			
			NSRange rangeofDot = [textField.text rangeOfString:@"."];
			if (rangeofDot.location != NSNotFound ) {
				NSString *substring = [textField.text substringFromIndex:rangeofDot.location ];
				
				if ([string isEqualToString:@"."]) {
					return NO;
				}
				
				if (substring.length > 2 )
				{
					return NO;
				}
			}
		}
		else{
			NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
			if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
				return NO;
			}
		}
	}
	
	return  YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	
	if (textField.tag == 1) {
		if ([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"ACIR"] || [riderCode isEqualToString:@"DCA"] ||
			[riderCode isEqualToString:@"DHI"] ||  [riderCode isEqualToString:@"LCWP"]  || [riderCode isEqualToString:@"MR"] ||
			[riderCode isEqualToString:@"PA"] || [riderCode isEqualToString:@"PR"] || [riderCode isEqualToString:@"TPDWP"] ||
			[riderCode isEqualToString:@"WI"] || [riderCode isEqualToString:@"TPDMLA"]  ) {
			if (![txtRiderTerm.text isEqualToString:@"" ]) {
				txtPaymentTerm.text = txtRiderTerm.text;
			}
		}

	}
	
}

#pragma mark - handle data

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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT LabelCode,LabelDesc,RiderName,InputCode,TableName,FieldName"
							  ",Condition FROM UL_Rider_Label WHERE RiderCode=\"%@\"",riderCode];
		
		//NSLog(@"%@", querySQL);
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
	LPremium = [[NSMutableArray alloc] init];
	LReinvest = [[NSMutableArray alloc] init];
	LPaymentTerm = [[NSMutableArray alloc] init];
	LRRTUOFromYear = [[NSMutableArray alloc] init];
	LRRTUOYear = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Deductible, a.HLoading, "
							  "a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							  "a.HLoadingTerm, a.HLoadingPctTerm, c.OccpCode, a.premium, a.units, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear FROM UL_Rider_Details a, "
							  "UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
							  "AND a.SINo=b.SINo AND a.SINo=\"%@\" ORDER by a.RiderCode asc",getSINo];
        
		//NSLog(@"%@", querySQL);
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
                
                const char *deduct2 = (const char *) sqlite3_column_text(statement, 4);
                [LDeduct addObject:deduct2 == NULL ? @"" :[[NSString alloc] initWithUTF8String:deduct2]];
                
				const char *ridHL = (const char *) sqlite3_column_text(statement, 5);
                [LRidHL1K addObject:ridHL == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHL]];

				const char *ridHLP = (const char *) sqlite3_column_text(statement, 6);
                [LRidHLP addObject:ridHLP == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHLP]];

                [LSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)]];
                [LSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)]];
                [LAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                
                const char *ridTerm = (const char *)sqlite3_column_text(statement, 10);
                [LRidHLTerm addObject:ridTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridTerm]]; //added by heng
                
                const char *ridPTerm = (const char *)sqlite3_column_text(statement, 11);
                [LRidHLPTerm addObject:ridPTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridPTerm]]; //added by heng
                
                [LOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)]];
                
				[LPremium addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)]];
				
				const char *ridunits = (const char *)sqlite3_column_text(statement, 14);
				[LUnits addObject:ridunits == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridunits]];
				
				[LReinvest addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)]];
				[LPaymentTerm addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 16)]];
				
				[LRRTUOFromYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 17)]];
				[LRRTUOYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)]];
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
                              @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%@\" AND ToSA >= \"%@\""
							  ,getPlanCode,sumAss,sumAss];
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //LSDRate =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getLSDRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
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
                
                NSLog(@"::OccpLoad:%@, cpa:%d, pa:%d, class:%d",occLoadType, occCPA,occPA,occClass);
            }
            else {
                NSLog(@"Error getOccLoadExist!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)toggleForm
{
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++) {
		
		// for rider term
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"RITM"]]) {
            lbl1.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            term = YES;
        }
		else if([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"CFPA"]]){
			lbl1.numberOfLines = 2;
			lbl1.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			term = YES;
		}
		
        //for sum assured/monthly income/ yearly income
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"SUMA"]]) {
            lbl5.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            sumA = YES;
        }
		else if([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"YINC"]]){
			lbl5.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			sumA = NO;
		}
		else if([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"MINC"]]){
			lbl5.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			sumA = NO;
		}
		else if([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PREM"]]){
			lbl5.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			RRTUOPrem = YES;
		}
		
        //for payment term/plan option
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLOP"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLCH"]]) {
            //planLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			lbl2.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            plan = YES;
            
            planCondition = [FCondition objectAtIndex:i];
            
        }
		else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"FORY"]]){
			lbl2.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
		}
		
		else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PAYT"]]){
			lbl2.text = [NSString stringWithFormat:@"Payment Term :"];
		}
		
        //for deductible/reinvest
		txtOccpLoad.textColor = [UIColor grayColor];
		txtOccpLoad.enabled = NO;
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"DEDUC"]]) {
			lbl3.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            deduc = YES;
            
            deducCondition = [FCondition objectAtIndex:i];
        }
		else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"REMI"]]) {
			lbl3.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            ECAR55MonthlyIncome = YES;
        }
		else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"REYI"]]) {
			lbl3.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            if ([riderCode isEqualToString:@"ECAR6" ]) {
				ECAR6YearlyIncome = YES;
			}
			else{
				ECARYearlyIncome = YES;
			}
			
        }
		/*
		else{
			lbl3.numberOfLines = 2;
			lbl3.text = [NSString stringWithFormat:@"Reinvestment of\nYearly Income :"];
		}
		 */
        //
		if ([[FRidName objectAtIndex:i] isEqualToString:@"EverCash 55 Rider"]) {
			lbl4.text = @"GMI Start From(Age) :";

        }
		/*
		else{
			lbl5.text = [NSString stringWithFormat:@"GYI Start From :"];
		}
		*/
		
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
			lbl7.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            hload = YES;
			lbl8.text = [NSString stringWithFormat:@"%@ Term :",[FLabelDesc objectAtIndex:i]];
			hloadterm = YES;
        }
		
		
		if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
			lblHLP.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            hloadPct = YES;
			lblHLPTerm.text = [NSString stringWithFormat:@"%@ Term :",[FLabelDesc objectAtIndex:i]];
			hloadtermPct = YES;
        }
        
        /*
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
            tempHLLabel.text = @"Health Loading 2 (Per 1K SA) :";
            tempHLTLabel.text = @"Health Loading 2 (Per 1K SA) Term :";
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL10"]]) {
            tempHLLabel.text = @"Health Loading 2 (Per 100 SA) :";
            tempHLTLabel.text = @"Health Loading 2 (Per 100 SA) Term :";
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
            tempHLLabel.text = @"Health Loading 2 (%) :";
            tempHLTLabel.text = @"Health Loading 2 (%) Term :";
        }
		 */
    }
    [self replaceActive];
}

-(void)replaceActive{
	
	if (term) {
		lbl1.textColor = [UIColor blackColor];
		txtRiderTerm.enabled = YES;
		txtRiderTerm.textColor = [UIColor blackColor];
		txtRiderTerm.backgroundColor = [UIColor whiteColor];
    } else {
		lbl1.textColor = [UIColor darkGrayColor];
		txtRiderTerm.enabled = NO;
		txtRiderTerm.backgroundColor = [UIColor lightGrayColor];
    }
	if ([riderCode isEqualToString:@"LSR"]) {
		txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
	}
	else if([riderCode isEqualToString:@"CIRD"]) {
		txtRiderTerm.text = [NSString stringWithFormat:@"10"];
	}

	//-----------
	if (sumA) {
		lbl5.textColor = [UIColor blackColor];
		txtSumAssured.textColor = [UIColor blackColor];
		txtSumAssured.enabled = YES;
		txtSumAssured.backgroundColor = [UIColor whiteColor];
    }
	else if (RRTUOPrem){
		lbl5.textColor = [UIColor blackColor];
		txtSumAssured.enabled = YES;
		txtSumAssured.backgroundColor = [UIColor whiteColor];
	}
	else if (ECAR55MonthlyIncome){
		lbl5.textColor = [UIColor blackColor];
		txtSumAssured.enabled = YES;
		txtSumAssured.backgroundColor = [UIColor whiteColor];
	}
	else if (ECAR6YearlyIncome){
		lbl5.textColor = [UIColor blackColor];
		txtSumAssured.enabled = YES;
		txtSumAssured.backgroundColor = [UIColor whiteColor];
	}
	else if (ECARYearlyIncome){
		lbl5.textColor = [UIColor blackColor];
		txtSumAssured.enabled = YES;
		txtSumAssured.backgroundColor = [UIColor whiteColor];
	}
	else{
		lbl5.textColor = [UIColor grayColor];
		lbl5.text = @"Sum Assured :";
		txtSumAssured.textColor = [UIColor darkGrayColor];
		txtSumAssured.enabled = NO;
		txtSumAssured.backgroundColor = [UIColor lightGrayColor];
	}
	//-------------------------
	if (ECAR55MonthlyIncome){
		lbl4.textColor = [UIColor blackColor];
		lbl4.numberOfLines = 2;
		lbl4.text = @"GMI Start From (Age)";
		txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm] ;
		txtPaymentTerm.text = [NSString stringWithFormat:@"%d",55 - getAge];
		txtGYIFrom.text = @"55";
		txtGYIFrom.enabled = NO;
		txtGYIFrom.backgroundColor = [UIColor lightGrayColor];
	}
	else if (ECAR6YearlyIncome){
		lbl4.textColor = [UIColor blackColor];
		lbl4.text = @"GYI Start From";
		txtPaymentTerm.text = @"6";
		txtGYIFrom.text = @"6";
		txtGYIFrom.enabled = NO;
		txtGYIFrom.backgroundColor = [UIColor lightGrayColor];
	}
	else if (ECARYearlyIncome){
		lbl4.textColor = [UIColor blackColor];
		lbl4.text = @"GYI Start From";
		txtPaymentTerm.text = @"6";
		txtGYIFrom.text = @"1";
		txtGYIFrom.enabled = NO;
		txtGYIFrom.backgroundColor = [UIColor lightGrayColor];
    }
	else{
		lbl4.textColor = [UIColor grayColor];
		txtGYIFrom.text = @"";
		txtGYIFrom.enabled = NO;
		txtGYIFrom.textColor = [UIColor darkGrayColor];
		txtGYIFrom.backgroundColor = [UIColor lightGrayColor];
	}
	//-------------------------------
	if (plan) {
		lbl2.textColor = [UIColor blackColor];
		outletRiderPlan.enabled = YES;
		outletRiderPlan.hidden = NO;
        [self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
        txtPaymentTerm.hidden = YES;
        
        NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
        self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"EVER"];
        _planList.delegate = self;
        
        [self.outletRiderPlan setTitle:_planList.selectedItemDesc forState:UIControlStateNormal];
        planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
		 
	}
	else if (RRTUOPrem){
		outletRiderPlan.enabled = NO;
		outletRiderPlan.hidden = YES;
		txtPaymentTerm.hidden = NO;
		txtPaymentTerm.enabled = YES;
		txtPaymentTerm.backgroundColor = [UIColor whiteColor];
	}
	else{
		lbl2.text = @"Payment Term :";   
		outletRiderPlan.enabled = NO;
		outletRiderPlan.hidden = YES;
		txtPaymentTerm.hidden = NO;
		txtPaymentTerm.enabled = NO;
		txtPaymentTerm.textColor = [UIColor darkGrayColor];
		txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
		if ([riderCode isEqualToString:@"LSR"]) {
			txtPaymentTerm.text = [NSString stringWithFormat:@"%d", getTerm];
		}
		else if([riderCode isEqualToString:@"CIRD"]) {
			txtPaymentTerm.text = [NSString stringWithFormat:@"10"];
		}
	}
	//-------------------------
	if (deduc) {
		lbl3.textColor = [UIColor blackColor];
		txtReinvestment.hidden = YES;
		outletDeductible.hidden = NO;
		outletReinvest.hidden = YES;
        
        NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
        self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:planOption];
		_deductList.delegate = self;
        
        [self.outletDeductible setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
        deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        NSLog(@"deduc:%@",deductible);
	}
	else if(ECAR55MonthlyIncome){
		lbl3.numberOfLines = 2;
		lbl3.text = @"Reinvestment of\nMonthly Income :";
		outletDeductible.hidden = YES;
		txtReinvestment.hidden = YES;
		//txtReinvestment.backgroundColor = [UIColor whiteColor];
		outletReinvest.hidden = FALSE;
		outletReinvest.selectedSegmentIndex = 1;
	}
	else if(ECAR6YearlyIncome){
		lbl3.numberOfLines = 2;
		lbl3.text = @"Reinvestment of\nYearly Income :";
		outletDeductible.hidden = YES;
		txtReinvestment.hidden = YES;
		//txtReinvestment.backgroundColor = [UIColor whiteColor];
		outletReinvest.hidden = FALSE;
		outletReinvest.selectedSegmentIndex = 1;
	}
	else if(ECARYearlyIncome){
		lbl3.numberOfLines = 2;
		lbl3.text = @"Reinvestment of\nYearly Income :";
		outletDeductible.hidden = YES;
		txtReinvestment.hidden = YES;
		//txtReinvestment.backgroundColor = [UIColor whiteColor];
		outletReinvest.hidden = FALSE;
		outletReinvest.selectedSegmentIndex = 1;
	}
	else{
		lbl3.numberOfLines = 2;
		lbl3.text = @"Reinvestment of\nYearly Income :";
		outletReinvest.hidden = YES;
		txtReinvestment.text = @"No";
		txtReinvestment.textColor = [UIColor darkGrayColor];
		outletDeductible.hidden = YES;
		txtReinvestment.hidden = NO;
		txtReinvestment.enabled = NO;
		txtReinvestment.backgroundColor = [UIColor lightGrayColor];
	}
	//-------------------------
	if (hloadterm == TRUE) {
		lbl7.textColor = [UIColor blackColor];
		txtHL.backgroundColor = [UIColor whiteColor];
		txtHL.enabled = TRUE;
		lbl8.textColor = [UIColor blackColor];
		txtHLTerm.backgroundColor = [UIColor whiteColor];
		txtHLTerm.enabled = TRUE;
	}
	else{
		lbl7.textColor = [UIColor grayColor];
		txtHL.backgroundColor = [UIColor lightGrayColor];
		txtHL.enabled = FALSE;
		lbl8.textColor = [UIColor grayColor];
		txtHLTerm.backgroundColor = [UIColor lightGrayColor];
		txtHLTerm.enabled = FALSE;
	}

	if (hloadtermPct == TRUE) {
		lblHLP.textColor = [UIColor blackColor];
		txtHLP.backgroundColor = [UIColor whiteColor];
		txtHLP.enabled = TRUE;
		lblHLPTerm.textColor = [UIColor blackColor];
		txtHLPTerm.backgroundColor = [UIColor whiteColor];
		txtHLPTerm.enabled = TRUE;
	}
	else{
		lblHLP.textColor = [UIColor grayColor];
		txtHLP.backgroundColor = [UIColor lightGrayColor];
		txtHLP.enabled = FALSE;
		lblHLPTerm.textColor = [UIColor grayColor];
		txtHLPTerm.backgroundColor = [UIColor lightGrayColor];
		txtHLPTerm.enabled = FALSE;
	}
	
	//--------------
	txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoadType];
	txtOccpLoad.textColor = [UIColor darkGrayColor];
}

-(void)getRiderTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,ExpiryAge,MinTerm,MaxTerm,MinSA,MaxSA"
							  " FROM UL_Rider_Mtn WHERE RiderCode=\"%@\"",riderCode];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                expAge =  sqlite3_column_int(statement, 2);
                minTerm =  sqlite3_column_int(statement, 3);
                maxTerm =  sqlite3_column_int(statement, 4);
                minSATerm = sqlite3_column_int(statement, 5);
                maxSATerm = sqlite3_column_int(statement, 6);
                NSLog(@"expiryAge(%@):%d,minTerm:%d,maxTerm:%d,minSA:%d,maxSA:%d",riderCode,expAge,minTerm,maxTerm,minSATerm,maxSATerm);
                
            } else {
                NSLog(@"error access UL_Rider_Mtn");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setOutletPersonType:nil];
	[self setOutletRider:nil];
	[self setTxtRiderTerm:nil];
	[self setOutletRiderPlan:nil];
	[self setActionRiderPlan:nil];
	[self setTxtPaymentTerm:nil];
	[self setOutletDeductible:nil];
	[self setTxtReinvestment:nil];
	[self setTxtRRTUP:nil];
	[self setTxtRRTUPTerm:nil];
	[self setTxtSumAssured:nil];
	[self setTxtGYIFrom:nil];
	[self setTxtOccpLoad:nil];
	[self setTxtHL:nil];
	[self setTxtHLTerm:nil];
	[self setTxtRiderPremium:nil];
	[self setLbl1:nil];
	[self setLbl2:nil];
	[self setLbl3:nil];
	[self setLbl4:nil];
	[self setLbl5:nil];
	[self setLbl6:nil];
	[self setLbl7:nil];
	[self setLbl8:nil];
	[self setLblRegular1:nil];
	[self setLblRegular2:nil];
	[self setLblRegularTerm:nil];
	[self setLblRegularTerm2:nil];
	[self setMyScrollView:nil];
	[self setMyTableView:nil];
	[self setLblTable1:nil];
	[self setLblTable2:nil];
	[self setLblTable3:nil];
	[self setLblTable4:nil];
	[self setLblTable5:nil];
	[self setLblTable6:nil];
	[self setLblTable7:nil];
	[self setLblTable8:nil];
	[self setLblTable9:nil];
	[self setOutletDelete:nil];
	[self setOutletEdit:nil];
	[self setOutletDelete:nil];
	[self setOutletEdit:nil];
	[self setLblMax:nil];
	[self setLblMin:nil];
	[self setOutletReinvest:nil];
	[self setOutletReinvest:nil];
	[self setLblHLP:nil];
	[self setTxtHLP:nil];
	[self setLblHLPTerm:nil];
	[self setTxtHLPTerm:nil];
	[super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return [LTypeRiderCode count];
	//return  1;
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
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
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
    int y = 0;
	int height = 50;
	
	CGRect frame=CGRectMake(0,y, 90, height); //ridercode
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"    %@",[LTypeRiderCode objectAtIndex:indexPath.row]];
    label1.textAlignment = UITextAlignmentCenter;
    label1.tag = 2001;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label1];
	
	CGRect frame2=CGRectMake(90,y, 95, height); //premium
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    NSString *num = [formatter stringFromNumber:[NSNumber numberWithDouble:[[LTypePremium objectAtIndex:indexPath.row] doubleValue]]];
	
    label2.text= [num stringByReplacingOccurrencesOfString:@"," withString:@""];
    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label2];
    
    CGRect frame3=CGRectMake(185,y, 90, height); //sum assured
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
	
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
	
    label3.text= SumToDisplay;
    label3.textAlignment = UITextAlignmentCenter;
    label3.tag = 2003;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label3];
	
	CGRect frame4=CGRectMake(275,y, 62, height); //term
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
    label4.text= [LTypeTerm objectAtIndex:indexPath.row];
    label4.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label4];
	
	CGRect frame5=CGRectMake(337,y, 63, height); //unit
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text= @"0";
    label5.textAlignment = UITextAlignmentCenter;
    label5.tag = 2005;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label5];
	//------------
	CGRect frame6=CGRectMake(400,y, 70, height); //class 
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
	
	if (occClass < 5) {
		label6.text= [NSString stringWithFormat:@"%d",occClass];
	}
	else{
		if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HMM" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MG_IV" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"PA" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ACIR" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"CIWP" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR6" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR55" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TPDWP" ]) {
			label6.text= [NSString stringWithFormat:@"D"];
		}
		else{
			label6.text= [NSString stringWithFormat:@"-"];
		}
	}
	
    label6.textAlignment = UITextAlignmentCenter;
    label6.tag = 2006;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label6];
	//---------------
	CGRect frame7=CGRectMake(470,y, 63, height); //occ loading
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    //label6.text= [NSString stringWithFormat:@"%@",occLoadType];
	if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR6" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR55" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LSR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TPDWP" ]) {
		label7.text= [NSString stringWithFormat:@"%@",occLoadType];
	}
	else{
		label7.text= [NSString stringWithFormat:@"-"];
	}
    label7.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label7];
	
	NSString *hl1k = [LTypeRidHL1K objectAtIndex:indexPath.row]; //health loading
    NSString *hlp = [LTypeRidHLP objectAtIndex:indexPath.row];
	CGRect frame8=CGRectMake(533,y, 63, height);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    NSString *hl1 = nil;
    if ([hl1k isEqualToString:@"(null)"] && [hlp isEqualToString:@"(null)"]) {
        hl1 = @"-";
    }
    else if (![hl1k isEqualToString:@"(null)"] && [hl1k intValue] > 0) {
        hl1 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hl1k doubleValue]]];
    }
    else if (![hlp isEqualToString:@"(null)"] && [hlp intValue] > 0) {
        hl1 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hlp doubleValue]]];
    }
    else {
        hl1 = @"-";
    }
    label8.text= hl1;
    label8.textAlignment = UITextAlignmentCenter;
    label8.tag = 2008;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label8];
	
	NSString *hl1kT = [LTypeRidHLTerm objectAtIndex:indexPath.row]; //health loading term
    NSString *hlpT = [LTypeRidHLPTerm objectAtIndex:indexPath.row];
    
    CGRect frame9=CGRectMake(596,y, 70, height);
    UILabel *label9=[[UILabel alloc]init];
    label9.frame=frame9;
    NSString *hl1T = nil;
    if ([hl1kT intValue] == 0 && [hlpT intValue] == 0) {
        hl1T = @"-";
    }
    else if([hl1kT intValue] !=0) {
        hl1T = hl1kT;
    }
    else if ([hlpT intValue] != 0) {
        hl1T = hlpT;
    }
    else {
        hl1T = @"-";
    }
    label9.text= hl1T;
    label9.textAlignment = UITextAlignmentCenter;
    label9.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label9];
	
	//--
    
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label7.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label8.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label9.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        
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
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        
    }
	
	
	
	
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
			outletDelete.enabled = FALSE;
        }
        else {
            [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			outletDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }
    else {
        
        RiderListTbViewController *zzz = [[RiderListTbViewController alloc] init ];
        [self RiderListController:zzz didSelectCode:[LTypeRiderCode objectAtIndex:indexPath.row]
							 desc:[self getRiderDesc:[LTypeRiderCode objectAtIndex:indexPath.row]]];
        
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
        
		if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ]) {
			txtSumAssured.text = [LTypePremium objectAtIndex:indexPath.row] ;
			txtRiderTerm.text = [LTypeRRTUOFromYear objectAtIndex:indexPath.row];
			//unitField.text = [LTypeUnits objectAtIndex:indexPath.row]
			txtPaymentTerm.text = [LTypeRRTUOYear objectAtIndex:indexPath.row];
		}
		else{
			txtSumAssured.text = SumToDisplay;
			txtRiderTerm.text = [LTypeTerm objectAtIndex:indexPath.row];
			//unitField.text = [LTypeUnits objectAtIndex:indexPath.row];
			txtPaymentTerm.text = [LTypePaymentTerm objectAtIndex:indexPath.row];
		}
		
		

		if ([[LTypeReinvest objectAtIndex:indexPath.row] isEqualToString:@"Yes" ]) {
			//outletReinvest.hidden = FALSE;
			outletReinvest.selectedSegmentIndex = 0;
			//outletDeductible.hidden = TRUE;
		}
		else{
			//outletReinvest.hidden = FALSE;
			outletReinvest.selectedSegmentIndex = 1;
		}
		
        if (  ![[LTypePlanOpt objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            [outletRiderPlan setTitle:[LTypePlanOpt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            planOption = [[NSString alloc] initWithFormat:@"%@",outletRiderPlan.titleLabel.text];
        }
        
        if (  ![[LTypeDeduct objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
            [outletDeductible setTitle:[LTypeDeduct objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",outletDeductible.titleLabel.text];
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
        }
        else {
            HLToDisplay = [LTypeRidHL1K objectAtIndex:indexPath.row];
        }
        
        if (![[LTypeRidHL1K objectAtIndex:indexPath.row] isEqualToString:@"(null)"] && ![HLToDisplay isEqualToString:@"0"]) {
			txtHL.text = HLToDisplay;
        }
        else {
			txtHL.text = @"";
        }

		if (![[LTypeRidHLP objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
			txtHLP.text = [LTypeRidHLP objectAtIndex:indexPath.row];
        }
        else {
			txtHLP.text = @"";
        }
		
        if (  ![[LTypeRidHLTerm objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
			txtHLTerm.text = [LTypeRidHLTerm objectAtIndex:indexPath.row];
        }
        
        if (  ![[LTypeRidHLPTerm objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
			txtHLPTerm.text = [LTypeRidHLPTerm objectAtIndex:indexPath.row];
        }
		
    }
}

-(NSString *)getRiderDesc:(NSString *) TempRiderCode
{
    sqlite3_stmt *statement;
    NSString *returnValue = @"";
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RiderDesc FROM UL_Rider_Profile WHERE RiderCode=\"%@\" ", TempRiderCode];
        
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


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
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
            [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
			outletDelete.enabled = FALSE;
        }
        else {
            [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			outletDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:zzz];
        [indexPaths removeObject:indexPath];
    }
}

#pragma mark - delegate



-(void)deductView:(RiderDeducTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc{
	Edit = TRUE;
    NSLog(@"selectDeduc:%@",itemdesc);
    [self.outletDeductible setTitle:itemdesc forState:UIControlStateNormal];
    deductible = [[NSString alloc] initWithFormat:@"%@",itemdesc];
    
	
    [self.deducPopover dismissPopoverAnimated:YES];
}

-(void)PlanView:(RiderPlanTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc{
	Edit = TRUE;
    NSLog(@"selectPlan:%@",itemdesc);

        
        if ([itemdesc isEqualToString:@"HMM_1000"]) {
            NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
            self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:itemdesc];
            _deductList.delegate = self;
            
            [self.outletDeductible setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        }
        if (![itemdesc isEqualToString:planOption] && [planOption isEqualToString:@"HMM_1000"]) {
            NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
            self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:itemdesc];
            _deductList.delegate = self;
            
            [self.outletDeductible setTitle:_deductList.selectedItemDesc forState:UIControlStateNormal];
            deductible = [[NSString alloc] initWithFormat:@"%@",_deductList.selectedItemDesc];
        }
        
        [self.outletRiderPlan setTitle:itemdesc forState:UIControlStateNormal];
        planOption = [[NSString alloc] initWithFormat:@"%@",itemdesc];

    [self.planPopover dismissPopoverAnimated:YES];
}

-(void)PTypeController:(RiderPTypeTbViewController *)inController didSelectCode:(NSString *)code seqNo:(NSString *)seq
				  desc:(NSString *)desc andAge:(NSString *)aage andOccp:(NSString *)aaOccp andSex:(NSString *)aaSex{
	if (riderCode != NULL) {
        [self.outletRider setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
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
	pTypeSex = [[NSString alloc] initWithFormat:@"%@",aaSex];
    
    [self getCPAClassType];
    
    [self.outletPersonType setTitle:pTypeDesc forState:UIControlStateNormal];
    [self.pTypePopOver dismissPopoverAnimated:YES];
    NSLog(@"RIDERVC pType:%@, seq:%d, desc:%@ sex:%@",pTypeCode,PTypeSeq,pTypeDesc, pTypeSex);
    [self getListingRiderByType];
	
	if ([code isEqualToString:@"PY"] || PTypeSeq == 2) {
		[self CheckWaiverRiderPrem];
		[self getListingRiderByType];
	}
    [myTableView reloadData];
}


-(void)RiderListController:(RiderListTbViewController *)inController didSelectCode:(NSString *)code desc:(NSString *)desc{
	//reset value existing
	Edit = TRUE;
	lblMax.text = @"";
	lblMin.text = @"";
	
    if (riderCode != NULL) {
        [self clearField];
    }
	
	riderCode = [[NSString alloc] initWithFormat:@"%@",code];
    riderDesc = [[NSString alloc] initWithFormat:@"%@",desc];
    [self.outletRider setTitle:riderDesc forState:UIControlStateNormal];
    [self.RiderListPopover dismissPopoverAnimated:YES];
	
	BOOL foundPayor = YES;
    BOOL foundLiving = YES;
    BOOL either = NO;
    //BOOL either2 = NO;
    if ([riderCode isEqualToString:@"PTR"]) { foundPayor = NO; }
    if ([riderCode isEqualToString:@"PLCP"]) { foundLiving = NO; }
	
	//validation part
	
	//----reset back pTypeOccp to first life assured occp code
	if (PTypeSeq == 1 && [pTypeCode isEqualToString:@"LA"]) {
		pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
	}
	//----
	
	
	
	//[self getOccpNotAttach];
	
	if ([LRiderCode count] != 0){
		NSUInteger i;
        for (i=0; i<[LRiderCode count]; i++) {
			NSLog(@"riderExist:%@, rider enter:%@",[LRiderCode objectAtIndex:i],riderCode);
            
			if (([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) ||
				([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"])) {
                either = YES;
            }
		}
		if (either) {
			if (PTypeSeq == 1 ) { //payor
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
																message:@"Please select only either one of LCWP or PR." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[self.outletRider setTitle:@"" forState:UIControlStateNormal];
			}
			else{ //2nd life assured
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
																message:@"Please select only either one of PR, LCWP" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[self.outletRider setTitle:@"" forState:UIControlStateNormal];
			}
		}
		else{
			[self getLabelForm];
			[self toggleForm];
			[self getRiderTermRule];
			[self calculateTerm];
			[self calculateSA];
		}
		
	}
	else{
		[self getLabelForm];
		[self toggleForm];
		[self getRiderTermRule];
		[self calculateTerm];
		[self calculateSA];
	}
		
	
	
}

#pragma mark - calculation


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
	LTypePremium = [[NSMutableArray alloc] init];
	LTypeReinvest = [[NSMutableArray alloc] init];
	LTypePaymentTerm = [[NSMutableArray alloc] init];
	LTypeRRTUOFromYear = [[NSMutableArray alloc] init];
	LTypeRRTUOYear = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"";
        if ([pTypeCode isEqualToString:@"PY"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
                        "a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
						"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear FROM UL_Rider_Details a, "
                        "UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
                        "AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'PY' ",getSINo];
        }
        else {
            if (PTypeSeq == 2) {
				querySQL = [NSString stringWithFormat:
							@"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
							"a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear FROM UL_Rider_Details a, "
							"UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
							"AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'LA' AND b.Seq = '2'  ",getSINo];
				
            }
            else {
                querySQL = [NSString stringWithFormat:
							@"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
							" a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear FROM UL_Rider_Details a, "
							"UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
							"AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'LA' AND b.Seq = '1'  ",getSINo];
				
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
                
                const char *ridHLP = (const char *)sqlite3_column_text(statement, 7);
                [LTypeRidHLP addObject:ridHLP == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridHLP]];
                
                [LTypeSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)]];
                [LTypeSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                [LTypeAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
                
				[LTypeOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
				
                const char *ridTerm = (const char *)sqlite3_column_text(statement, 12);
                [LTypeRidHLTerm addObject:ridTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridTerm]]; //added by heng
                
                const char *ridPTerm = (const char *)sqlite3_column_text(statement, 13);
                [LTypeRidHLPTerm addObject:ridPTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:ridPTerm]]; //added by heng
                
				[LTypePremium addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)]];
				
                [LTypeReinvest addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)]];
				[LTypePaymentTerm addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 16)]];
				[LTypeRRTUOFromYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 17)]];
				[LTypeRRTUOYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)]];
            }
            
            if ([LTypeRiderCode count] == 0) {
                myTableView.hidden = YES;
                lblTable1.hidden = YES;
                lblTable2.hidden = YES;
				lblTable3.hidden = YES;
				lblTable4.hidden = YES;
				lblTable5.hidden = YES;
				lblTable6.hidden = YES;
				lblTable7.hidden = YES;
				lblTable8.hidden = YES;
				lblTable9.hidden = YES;
                outletEdit.hidden = YES;
                outletDelete.hidden = true;
                
                [self.myTableView setEditing:NO animated:TRUE];
                [outletEdit setTitle:@"Delete" forState:UIControlStateNormal ];
            } else {
                myTableView.hidden = NO;
				lblTable1.hidden = NO;
				lblTable2.hidden = NO;
				lblTable3.hidden = NO;
				lblTable4.hidden = NO;
				lblTable5.hidden = NO;
				lblTable6.hidden = NO;
				lblTable7.hidden = NO;
				lblTable8.hidden = NO;
				lblTable9.hidden = NO;
                outletEdit.hidden = NO;
				
            }
            
            [self.myTableView reloadData];
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
}


-(void)calculateTerm
{
	if (expAge < 0) {
		expAge = (0 - expAge);
	}
	
	
    int period = expAge - self.pTypeAge;
    int period2 = 80 - self.pTypeAge;
    double age1 = fmin(period2,60);
	
	if ([riderCode isEqualToString:@"ACIR"] || [riderCode isEqualToString:@"DCA"] || [riderCode isEqualToString:@"DHI"] ||
		[riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"MG_IV"] ||
		[riderCode isEqualToString:@"MR"] || [riderCode isEqualToString:@"PA"] || [riderCode isEqualToString:@"TPDMLA"] ||
		[riderCode isEqualToString:@"WI"]	) {
		maxRiderTerm = expAge - self.pTypeAge;
	}
	else if([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"ECAR55"] || [riderCode isEqualToString:@"LCWP"] ||
			[riderCode isEqualToString:@"PR"] || [riderCode isEqualToString:@"TPDWP"]){
		maxRiderTerm = expAge - self.pTypeAge;
	}
	else if([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"]){
		minTerm = 20;
		maxRiderTerm = 25;
	}
	else if([riderCode isEqualToString:@"RRTUO"]){
		minTerm = 1;
		maxRiderTerm = expAge - self.pTypeAge - 1;
	}
	else if([riderCode isEqualToString:@"CIRD"]){
		minTerm = 10;
		maxRiderTerm = 10;
	}
	
/*
    if ([riderCode isEqualToString:@"CIWP"])
    {
        [self getMaxRiderTerm];
        double maxRiderTerm1 = fmin(period,getTerm);
        double maxRiderTerm2 = fmax(getMOP,storedMaxTerm);
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
    }
    else if ([riderCode isEqualToString:@"LCWP"]||[riderCode isEqualToString:@"PR"]||[riderCode isEqualToString:@"PLCP"]||
			 [riderCode isEqualToString:@"PTR"]||[riderCode isEqualToString:@"SP_STD"]||[riderCode isEqualToString:@"SP_PRE"])
    {
        [self getMaxRiderTerm];
        double maxRiderTerm1 = fmin(getTerm,age1);
        double maxRiderTerm2 = fmax(getMOP,storedMaxTerm);
		//        double maxRiderTerm2 = fmax(getTerm,storedMaxTerm);
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
        NSLog(@"maxTerm1:%.f, maxTerm2:%.f, maxTerm:%.f",maxRiderTerm1,maxRiderTerm2,maxRiderTerm);
        
        if (maxRiderTerm < minTerm) {
            maxRiderTerm = maxTerm;
        }
        
        if (([riderCode isEqualToString:@"PLCP"] || [riderCode isEqualToString:@"PTR"]) && maxRiderTerm > maxTerm) {
            maxRiderTerm = maxTerm;
        }
    }
    else {
        maxRiderTerm = fmin(period,getTerm);
    }
 */
    //maxRiderTerm = fmin(period,getTerm);
    NSLog(@"expAge-alb:%d,covperiod:%d,maxRiderTerm:%.f,age1:%.f",period,getTerm,maxRiderTerm,age1);
}

-(void)calculateSA
{

    if ([riderCode isEqualToString:@"ACIR"])
    {
		maxRiderSA = fmin(maxSATerm, getBasicSA);
    }
	else if([riderCode isEqualToString:@"CIRD"]){
		maxRiderSA = maxSATerm;
	}
	else if([riderCode isEqualToString:@"DCA"]){
		maxRiderSA = fmin(getBasicSA * 5, 1000000);
	}
    else if([riderCode isEqualToString:@"DHI"]){
		if ([OccpCat isEqualToString:@"EMP"]) {
			maxRiderSA = 800;
		}
		else if ([OccpCat isEqualToString:@"UNEMP"]) {
			maxRiderSA = 0;
		}
		else{
			maxRiderSA = 200;
		}
	}
	else if([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"] ||
			[riderCode isEqualToString:@"ECAR55"] || [riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"RRTUO"]) {
			maxRiderSA = 9999999990;
	}
	else if([riderCode isEqualToString:@"PA"]){
		maxRiderSA = getBasicSA * 5;
	}
	else if([riderCode isEqualToString:@"TPDMLA"] || [riderCode isEqualToString:@"WI"]){
		if ([OccpCat isEqualToString:@"UNEMP"]) {
			maxRiderSA = 0;
		}
		else{
			maxRiderSA = maxSATerm;
		}
	}
	else if([riderCode isEqualToString:@"MR"] ){
		maxRiderSA = maxSATerm;
	}
	
	NSLog(@"maxSA(%@):%.f",riderCode,maxRiderSA);
}

#pragma mark - validate

-(void)validateTerm
{
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    BOOL HL1kTerm = NO;
    BOOL HLPTerm = NO;
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++)
    {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
            HL1kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
            HLPTerm = YES;
        }
    }
		
    
    if (txtRiderTerm.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Rider Term must be numeric 0 to 9 only" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text intValue] > maxRiderTerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Rider Term must be less than or equal to %.f",maxRiderTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text intValue] < minTerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Rider Term must be greater than or equal to %d",minTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }

	
	else if ([riderCode isEqualToString:@"RRTUO"] && [txtPaymentTerm.text intValue ] > (getTerm - [txtRiderTerm.text intValue]) ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Rider Regular Top Up Option Year cannot be greater than %d",(getTerm - [txtRiderTerm.text intValue])]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtPaymentTerm becomeFirstResponder];
    }
	 
    else if ([txtHLTerm.text intValue] > [txtRiderTerm.text intValue]) {
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (per 1k SA) Term cannot be greater than %d",[txtRiderTerm.text intValue]];
        } 
		else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (%%) Term cannot be greater than %d",[txtRiderTerm.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
	/*
	else if ([txtHL.text intValue] > 10000 && ![riderCode isEqualToString:@"HMM"] && ![riderCode isEqualToString:@"MG_IV"]
			 && ![riderCode isEqualToString:@"HSP_II"]) {
		
		NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (per 1k SA) cannot be greater than 10000"];
        } else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (%%) cannot be greater than 500"];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
	}
	 */
	else if (sumA) {
        NSLog(@"validate - 1st sum");
        [self validateSum];
    } else {
        NSLog(@"validate - 1st save");
        [self validateSaver];
    }
}

-(void)validateSum
{
    NSLog(@"keyin SA:%.f,max:%.f",[txtSumAssured.text doubleValue],maxRiderSA);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSCharacterSet *setHLACP = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSRange rangeofDot = [txtSumAssured.text rangeOfString:@"."];
    NSString *substring = @"";
    
    if (rangeofDot.location != NSNotFound) {
        substring = [txtSumAssured.text substringFromIndex:rangeofDot.location ];
    }
    
    if (txtSumAssured.text.length <= 0) {
        if (incomeRider) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Guaranteed Yearly Income\n is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider Sum Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        }
        [txtSumAssured becomeFirstResponder];
    }
    else if ([txtSumAssured.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Input must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }
    //--
    else if ([txtSumAssured.text rangeOfCharacterFromSet:setHLACP].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Sum Assured does not allows decimal." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }//--
    else if ([txtSumAssured.text doubleValue] < minSATerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Rider Sum Assured must be greater than or equal to %d",minSATerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }
    else if ([txtSumAssured.text doubleValue] > maxRiderSA) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Rider Sum Assured must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }
    
     else {
        NSLog(@"validate - 2nd save");
        [self validateSaver];
    }
}

-(void)validateSaver
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSCharacterSet *setTerm = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSRange rangeofDot = [txtHL.text rangeOfString:@"."];
    NSString *substring = @"";
    if (rangeofDot.location != NSNotFound) {
        substring = [txtHL.text substringFromIndex:rangeofDot.location ];
    }
    
    double numHL = [txtHL.text doubleValue];
    double aaHL = numHL/25;
    int bbHL = aaHL;
    float ccHL = aaHL - bbHL;
    NSString *msg2 = [formatter stringFromNumber:[NSNumber numberWithFloat:ccHL]];
    NSLog(@"value:%.2f,devide:%.2f,int:%d, minus:%.2f,msg:%@",numHL,aaHL,bbHL,ccHL,msg2);
    
    BOOL HL1kTerm = NO;
    BOOL HLPTerm = NO;
    NSUInteger i;
    for (i=0; i<[FLabelCode count]; i++)
    {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1KT"]]) {
            HL1kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLPT"]]) {
            HLPTerm = YES;
        }
    }
    
    if (plan && planOption.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider Plan Option/Choice is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (deduc && deductible.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider Deductible is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //--
    else if (inputHLPercentage.length != 0 && [txtHL.text intValue] > 999) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading (%) cannot greater than 999%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
	
    else if (txtHL.text.length == 0 && [txtHLTerm.text intValue] != 0) {
		
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (per 1k SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading 1 (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if ([txtHL.text intValue] != 0 && txtHLTerm.text.length == 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (per 1k SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading 1 (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
	/*
    else if (inputHL1KSA.length != 0 && [txtHL.text intValue] > 10000) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading 1 (Per 1k SA) cannot greater than 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
	 */
    else if ([txtHL.text intValue] !=0 && substring.length > 3) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (Per 1k SA) only allow 2 decimal places.";
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if (inputHLPercentage.length != 0 && substring.length > 1) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading 1 (%) must not contains decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    
    else if ([txtHLTerm.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Health Loading 1 (per 1k SA) Term.";
        } else if (HLPTerm) {
            msg = @"Invalid input. Please enter numeric value (0-9) into Health Loading 1 (%) Term.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    else if ([txtHLTerm.text intValue] > [txtRiderTerm.text intValue]) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (per 1k SA) Term cannot be greater than %d",[txtRiderTerm.text intValue]];
        }
		else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (%%) Term cannot be greater than %d",[txtRiderTerm.text intValue]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    
    else if ([txtHLTerm.text intValue] == 0 && txtHL.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (per 1k SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading 1 (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if ([txtHLTerm.text intValue] == 0 && txtHL.text.length != 0) {
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (per 1k SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading 1 (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    //--
	else if ([riderCode isEqualToString:@"DHI"] && [txtSumAssured.text integerValue] % 50 != 0){
		NSString *msg = @"DHI Sum Assured Must be in multiple of 50";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"]) && [txtRiderTerm.text integerValue] % 5 != 0){
		NSString *msg = @"Rider Term must be 20 or 25 only.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"]) && [txtSumAssured.text intValue ] < minSATerm ){
		NSString *msg = [NSString stringWithFormat:@"Yearly Income must be greater than or equal to %d", minSATerm ];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
	else if ([riderCode isEqualToString:@"ECAR55"] && [txtSumAssured.text intValue ] < minSATerm ){
		NSString *msg = [NSString stringWithFormat:@"Monthly Income must be greater than or equal to %d", minSATerm ];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
	else if ([riderCode isEqualToString:@"RRTUO"]){
		bool unitization = false;
		for (int i = 0; i < LTypeRiderCode.count ; i++) {
			if ([[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MR"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"WI"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"DHI"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"TPDMLA"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"PA"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"DCA"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"CIRD"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"ACIR"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"HMM"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"]) {
				unitization = TRUE;
				break;
			}
		}
		
		if (unitization == FALSE) {
			NSString *msg = @"RRTUO is not allowed if no unitization rider is attached";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		else{
			Edit = FALSE;
			[self checkingRider];
			if (existRidCode.length == 0) {
				
				[self saveRider];
			} else {
				[self updateRider];
			}
		}
		

		
	}
    else if (([riderCode isEqualToString:@"HMM"] ||
              [riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HSP_II"]) && LRiderCode.count != 0) {
        NSLog(@"go RoomBoard!");
		Edit = FALSE;
        [self RoomBoard];
    }
    else {
		Edit = FALSE;
        [self checkingRider];
        if (existRidCode.length == 0) {
            
            [self saveRider];
        } else {
            [self updateRider];
        }
	
    }
}

-(void)RoomBoard{
	arrCombNo = [[NSMutableArray alloc] init];
    arrRBBenefit = [[NSMutableArray alloc] init];
	
    [self checkingRider];
    if (existRidCode.length == 0)       //validate as a new
    {
        //--1st stage only validate Major Medi/medGlobal
        
        for (NSUInteger i=0; i<LRiderCode.count; i++)
        {
            if (([[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"] && [riderCode isEqualToString:@"MG_II"]) ||
                ([[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"] && [riderCode isEqualToString:@"MG_IV"]))
            {
                medRiderCode = [LRiderCode objectAtIndex:i];
                medPlanOpt = [LPlanOpt objectAtIndex:i];
                
                [self getListCombNo];
                NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
                [arrCombNo addObject:tempCombNo];
                
                [self getListRBBenefit];
                NSString *tempBenefit = [NSString stringWithFormat:@"%d",RBBenefit];
                [arrRBBenefit addObject:tempBenefit];
                
                NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                
            } else {
                continue;
            }
        }
        
        //--calculate existing benefit
        double allBenefit = 0;
        for (NSUInteger x=0; x<arrRBBenefit.count; x++) {
            allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:x] doubleValue];
        }
        NSLog(@"total listBenefit:%.f",allBenefit);
        
        [self getCombNo];       //--get current CombNo
        NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
        [arrCombNo addObject:tempCombNo];
        
        NSSortDescriptor *aDesc = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];     //--sort combNo
        [arrCombNo sortUsingDescriptors:[NSArray arrayWithObjects:aDesc, nil]];
        
        NSString *newComb =[[NSString alloc] init];     //--combine all CombNo
        for ( NSUInteger y=0; y<arrCombNo.count; y++) {
            newComb = [newComb stringByAppendingString:[arrCombNo objectAtIndex:y]];
        }
        AllCombNo = [newComb intValue];
        NSLog(@"newComb:%@",newComb);
        
        [self getRBBenefit];        //--get selected RBBenefit and calculate all bnefit
        allBenefit = allBenefit + RBBenefit;
        NSLog(@"total allBenefit:%.f",allBenefit);
        
        //--get Limit,RBGroup
        [self getRBLimit];
        
        //--end 1st stage validate
        
        if (allBenefit > RBLimit) {
            if (RBGroup == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [self roomBoardDefaultPlanNew];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [self roomBoardDefaultPlanNew];
            }
        }
        
        //--2nd stage  validate combination of all MedGlobal, Major Medi and H&P
        else {
            
            
            arrCombNo = [[NSMutableArray alloc] init];
            arrRBBenefit = [[NSMutableArray alloc] init];
            
            for (NSUInteger i=0; i<LRiderCode.count; i++)
            {
                if ([[LRiderCode objectAtIndex:i] isEqualToString:@"HMM"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"HSP_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"])
                {
                    medRiderCode = [LRiderCode objectAtIndex:i];
                    medPlanOpt = [LPlanOpt objectAtIndex:i];
                    
                    [self getListCombNo];
                    NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
                    [arrCombNo addObject:tempCombNo];
                    
                    [self getListRBBenefit];
                    NSString *tempBenefit = [NSString stringWithFormat:@"%d",RBBenefit];
                    [arrRBBenefit addObject:tempBenefit];
                    
                    NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                    
                } else {
                    continue;
                }
            }
            
            //--calculate existing benefit
            double allBenefit = 0;
            for (NSUInteger x=0; x<arrRBBenefit.count; x++) {
                allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:x] doubleValue];
            }
            NSLog(@"total listBenefit:%.f",allBenefit);
            
            [self getCombNo];       //--get current CombNo
            NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
            [arrCombNo addObject:tempCombNo];
            
            NSSortDescriptor *aDesc = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];     //--sort combNo
            [arrCombNo sortUsingDescriptors:[NSArray arrayWithObjects:aDesc, nil]];
            
            NSString *newComb =[[NSString alloc] init];     //--combine all CombNo
            for ( NSUInteger y=0; y<arrCombNo.count; y++) {
                newComb = [newComb stringByAppendingString:[arrCombNo objectAtIndex:y]];
            }
            AllCombNo = [newComb intValue];
            NSLog(@"newComb:%@",newComb);
            
            [self getRBBenefit];        //--get selected RBBenefit and calculate all bnefit
            allBenefit = allBenefit + RBBenefit;
            NSLog(@"total allBenefit:%.f",allBenefit);
            
            //get Limit,RBGroup
            [self getRBLimit];
            
            //--end 2nd stage validation
            
            if (allBenefit > RBLimit) {
                if (RBGroup == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [self roomBoardDefaultPlanNew];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [self roomBoardDefaultPlanNew];
                }
            }
            else {
                NSLog(@"will continue save RB!");
                [self saveRider];
				
            }
        }
    }
    
    else      //validate as existing
    {
        //--1st stage only validate Major Medi/medGlobal
        
        BOOL medGlobalOnly = FALSE;
        double allBenefit = 0;
        for (NSUInteger i=0; i<LRiderCode.count; i++)
        {
            if ([[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"] || [[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"])
            {
                medRiderCode = [LRiderCode objectAtIndex:i];
                medPlanOpt = [LPlanOpt objectAtIndex:i];
                
                [self getListCombNo];
                NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
                [arrCombNo addObject:tempCombNo];
                
                [self getListRBBenefit];
                NSString *tempBenefit = [NSString stringWithFormat:@"%d",RBBenefit];
                [arrRBBenefit addObject:tempBenefit];
                NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                
            } else {
                continue;
            }
        }
        
        for (NSUInteger m=0; m<LRiderCode.count; m++)
        {
            if ([[LRiderCode objectAtIndex:m] isEqualToString:riderCode] && ([riderCode isEqualToString:@"MG_II"]||
																			 [riderCode isEqualToString:@"MG_IV"])) {
                
                medRiderCode = [LRiderCode objectAtIndex:m];
                medPlanOpt = [LPlanOpt objectAtIndex:m];
                [self getListRBBenefit];
                medGlobalOnly = TRUE;
                
            } else {
                continue;
            }
        }
        
        //total up all benefit
        for (NSUInteger z=0; z<arrRBBenefit.count; z++) {
            allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:z] doubleValue];
        }
        NSLog(@"currentBenefit:%.f",allBenefit);
        
        //minus benefit
        if (medGlobalOnly) {
            allBenefit = allBenefit - RBBenefit;
            NSLog(@"benefit:%d, newBenefit:%.f",RBBenefit,allBenefit);
        }
        
        //sort combNo
        NSSortDescriptor *aDesc = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
        [arrCombNo sortUsingDescriptors:[NSArray arrayWithObjects:aDesc, nil]];
        
        //combine all CombNo
        NSString *newComb =[[NSString alloc] init];
        for ( NSUInteger h=0; h<arrCombNo.count; h++) {
            newComb = [newComb stringByAppendingString:[arrCombNo objectAtIndex:h]];
        }
        AllCombNo = [newComb intValue];
        NSLog(@"newComb:%@",newComb);
        
        //get selected RBBenefit and calculate
        if (medGlobalOnly) {
            [self getRBBenefit];
            allBenefit = allBenefit + RBBenefit;
            NSLog(@"allBenefit:%.f",allBenefit);
        }
        
        //get Limit,RBGroup
        [self getRBLimit];
        
        //-- end 1st stage validate
        
        if (allBenefit > RBLimit) {
            if (RBGroup == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self roomBoardDefaultPlan];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self roomBoardDefaultPlan];
            }
        }
        
        //--2nd stage validate combination of all MedGlobal, Major Medi and H&P
        else {
			
            arrCombNo = [[NSMutableArray alloc] init];
            arrRBBenefit = [[NSMutableArray alloc] init];
            
            double allBenefit = 0;
            for (NSUInteger i=0; i<LRiderCode.count; i++)
            {
                if ([[LRiderCode objectAtIndex:i] isEqualToString:@"HMM"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"HSP_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_II"]||[[LRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"])
                {
                    medRiderCode = [LRiderCode objectAtIndex:i];
                    medPlanOpt = [LPlanOpt objectAtIndex:i];
                    
                    [self getListCombNo];
                    NSString *tempCombNo = [NSString stringWithFormat:@"%d",CombNo];
                    [arrCombNo addObject:tempCombNo];
                    
                    [self getListRBBenefit];
                    NSString *tempBenefit = [NSString stringWithFormat:@"%d",RBBenefit];
                    [arrRBBenefit addObject:tempBenefit];
                    NSLog(@"CombNo:%d, Benefit:%d Code:%@",CombNo,RBBenefit,[LRiderCode objectAtIndex:i]);
                    
                } else {
                    continue;
                }
            }
            
            for (NSUInteger m=0; m<LRiderCode.count; m++)
            {
                if ([[LRiderCode objectAtIndex:m] isEqualToString:riderCode]) {
                    
                    medRiderCode = [LRiderCode objectAtIndex:m];
                    medPlanOpt = [LPlanOpt objectAtIndex:m];
                    [self getListRBBenefit];
                    
                } else {
                    continue;
                }
            }
            
            //total up all benefit
            for (NSUInteger z=0; z<arrRBBenefit.count; z++) {
                allBenefit = allBenefit + [[arrRBBenefit objectAtIndex:z] doubleValue];
            }
            NSLog(@"currentBenefit:%.f",allBenefit);
            
            //minus benefit
            allBenefit = allBenefit - RBBenefit;
            NSLog(@"benefit:%d, newBenefit:%.f",RBBenefit,allBenefit);
            
            //sort combNo
            NSSortDescriptor *aDesc = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
            [arrCombNo sortUsingDescriptors:[NSArray arrayWithObjects:aDesc, nil]];
            
            //combine all CombNo
            NSString *newComb =[[NSString alloc] init];
            for ( NSUInteger h=0; h<arrCombNo.count; h++) {
                newComb = [newComb stringByAppendingString:[arrCombNo objectAtIndex:h]];
            }
            AllCombNo = [newComb intValue];
            NSLog(@"newComb:%@",newComb);
            
            //get selected RBBenefit and calculate
            [self getRBBenefit];
            allBenefit = allBenefit + RBBenefit;
            NSLog(@"allBenefit:%.f",allBenefit);
            
            //get Limit,RBGroup
            [self getRBLimit];
            
            if (allBenefit > RBLimit) {
                if (RBGroup == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self roomBoardDefaultPlan];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Traditional" message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self roomBoardDefaultPlan];
                }
            } else {
                NSLog(@"will update data");
                [self updateRider];
            }
        }
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

-(void)getListRBBenefit
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT RBBenefit from Trad_Sys_Medical_Benefit WHERE RiderCode=\"%@\" AND PlanChoice=\"%@\"",medRiderCode,medPlanOpt];
        
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
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT `Limit`, RBGroup from Trad_Sys_Medical_Comb WHERE OccpCode=\"%@\" AND Comb=\"%d\"",OccpCat,AllCombNo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RBLimit =  sqlite3_column_int(statement, 0);
                RBGroup =  sqlite3_column_int(statement, 1);
                NSLog(@"Limit:%d, group:%d",RBLimit,RBGroup);
                
            } else {
                NSLog(@"error access getRBLimit");
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
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                RBBenefit =  sqlite3_column_int(statement, 0);
				//                NSLog(@"Benefit:%d",RBBenefit);
                
            } else {
                NSLog(@"error access getRBBenefit");
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

-(void)roomBoardDefaultPlanNew
{
    if ([riderCode isEqualToString:@"HMM"]) {
        planOption = @"HMM_150";
        [self.outletRiderPlan setTitle:planOption forState:UIControlStateNormal];
    }
    else if ([riderCode isEqualToString:@"MG_IV"]) {
        planOption = @"MGIVP_150";
        [self.outletRiderPlan setTitle:planOption forState:UIControlStateNormal];
    }
}

-(void)roomBoardDefaultPlan
{
    if ([riderCode isEqualToString:@"HMM"]) {
		planOption = medPlanOpt;
        [self.outletRiderPlan setTitle:planOption forState:UIControlStateNormal];
    }
    else if ([riderCode isEqualToString:@"MG_IV"]) {
		//        planOption = @"MGIVP_150";
        planOption = medPlanOpt;
        [self.outletRiderPlan setTitle:planOption forState:UIControlStateNormal];
    }
}

-(NSString*)ReturnRiderDesc :(NSString *)aaRiderCode{

	NSString *value = riderDesc;
	
	if ([aaRiderCode isEqualToString:@"HMM"] ) {
		value = [value stringByAppendingFormat:@"(%@) Deductible(%@)", planOption, deductible ];
	}
	else if([aaRiderCode isEqualToString:@"MG_IV"]){
		value = [value stringByAppendingFormat:@"(%@)", planOption ];
	}
	
	return value;
}

-(void)saveRider
{
	sqlite3_stmt *statement;
	
    if (([pTypeCode isEqualToString:@"LA"]) && (PTypeSeq == 2)) {
        [self check2ndLARider];
    }

    inputSA = [txtSumAssured.text doubleValue];
	[self ReturnCurrentRiderPrem:0];
	
	NSString *FullRiderDesc = [self ReturnRiderDesc:riderCode];
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		NSString *insertSQL;
		if ([riderCode isEqualToString:@"ECAR"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem, txtPaymentTerm.text, [self ReturnReinvest],
						 @"1", @"0", @"0", FullRiderDesc];
		}
		if ([riderCode isEqualToString:@"ECAR6"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem, txtPaymentTerm.text, [self ReturnReinvest],
						 @"6", @"0", @"0", FullRiderDesc];
		}
		else if ([riderCode isEqualToString:@"ECAR55"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem , txtPaymentTerm.text, [self ReturnReinvest],
						 @"55", @"0", @"0", FullRiderDesc];
		}
		else if ([riderCode isEqualToString:@"RRTUO"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, @"0", @"0", planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem , @"15", @"No",
						 @"0", txtRiderTerm.text, txtPaymentTerm.text, FullRiderDesc];
		}
		else
		{
			insertSQL = [NSString stringWithFormat:
								   @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
								   "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
								   "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc ) VALUES"
								   "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
								   "\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@')",
								   getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
								   deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
									inputHLPercentageTerm, CurrentRiderPrem,
									[riderCode isEqualToString:@"HMM" ] || [riderCode isEqualToString:@"MG_IV" ] ? txtRiderTerm.text : txtPaymentTerm.text,
									[self ReturnReinvest], @"0", @"0", @"0", FullRiderDesc];
		}
		

        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Saved Rider!");
                [_delegate RiderAdded];
            } else {
                NSLog(@"Failed Save Rider!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
    if (secondLARidCode.length != 0) {
       
    }
    
	[self CheckWaiverRiderPrem];
    [self getListingRiderByType];
    [self getListingRider];
	[self CalcTotalRiderPrem];
	
	if (inputSA > maxRiderSA) {
        NSLog(@"will delete %@",riderCode);
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Rider Sum Assured must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert setTag:1002];
        [alert show];
    }
    else {
		/*
        [self calculateRiderPrem];
		[self calculateWaiver];
        [self calculateMedRiderPrem];
        
        if (medRiderPrem != 0) {
            [self MHIGuideLines];
        }
		 */
    }
    
   
}

-(void)ReturnCurrentRiderPrem: (int)WaiverRiderTerm{
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		int ridTerm = [txtRiderTerm.text intValue];
		age = pTypeAge;

		if ([pTypeCode isEqual:@"LA"] && PTypeSeq == 2) {
			sex = pTypeSex;
		}
		else if ([pTypeCode isEqual:@"PY"]) {
			sex = pTypeSex;
		}
		else{
			sex = getSex;
		}
		
	//NSLog(@"dasdas  %@ %@ %@ %d", pTypeSex, getSex, pTypeCode, PTypeSeq);
	
		sex = [sex substringToIndex:1];
		if ([riderCode isEqualToString:@"DCA"]||[riderCode isEqualToString:@"DHI"]||[riderCode isEqualToString:@"MR"]||
			[riderCode isEqualToString:@"PA"] || [riderCode isEqualToString:@"TPDMLA"]||[riderCode isEqualToString:@"WI"])
        {
            [self getRiderRateSexClassAge:riderCode Sex:sex Class:getOccpClass Age:age];
        }
        else if ([riderCode isEqualToString:@"ACIR"]) {
            [self getRiderRateSexTermAgeSmoker:riderCode Sex:sex Term:ridTerm Age:age Smoker:getSmoker];
        }
        else if ([riderCode isEqualToString:@"CIWP"]||[riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"] ||
				 [riderCode isEqualToString:@"TPDWP"] ) {
			if (WaiverRiderTerm == 0) {
				[self getRiderRateSexPremTermAge:riderCode Sex:sex Prem:txtPaymentTerm.text Term:ridTerm Age:age];
			}
			else{
				[self getRiderRateSexPremTermAge:riderCode Sex:sex Prem:[ NSString stringWithFormat:@"%d", WaiverRiderTerm ] Term:WaiverRiderTerm Age:age];
			}
    
        }
        else if ([riderCode isEqualToString:@"HMM"]) {
            [self getRiderRateTypeSexClassAgeDed:riderCode Type:outletRiderPlan.titleLabel.text
											 Sex:sex Class:getOccpClass Age:age Deduc:outletDeductible.titleLabel.text];
        }
        else if ([riderCode isEqualToString:@"MG_IV"]) {
            [self getRiderRateTypeAgeSexClass:riderCode Type:outletRiderPlan.titleLabel.text Sex:sex Class:getOccpClass Age:age];
        }
        else if ([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"CIRD"] ) {
            [self getRiderRateSexAge:riderCode Sex:sex Age:age];
        }
		else if ([riderCode isEqualToString:@"RRTUO"]) {
            riderRate = [txtSumAssured.text doubleValue ];
        }
        else if ([riderCode isEqualToString:@"ECAR55"]) {
            [self getRiderRatePremTermAge:riderCode Prem:txtPaymentTerm.text Term:ridTerm Age:age];
        }
		else if ([riderCode isEqualToString:@"ECAR"]) {
            [self getRiderRateGYITermAge:riderCode GYIStartFrom:txtGYIFrom.text Term:ridTerm Age:age];
        }
		else if ([riderCode isEqualToString:@"ECAR6"]){
			[self getRiderRateGYITermAge:riderCode GYIStartFrom:txtGYIFrom.text Term:ridTerm Age:age];
		}
		else{
			riderRate = 0.00;
		}
		
		double ridSA = [txtSumAssured.text doubleValue];
        double riderHLoad = 0;
		double riderHLoadPct = 0;
        //double riderHLoadPct = 0;
			 
        if ([txtHL.text doubleValue] > 0) {
            riderHLoad = [txtHL.text doubleValue];
        }
	
		if ([txtHLP.text doubleValue] > 0) {
			riderHLoadPct = [txtHLP.text doubleValue];
		}
    
        NSLog(@"~riderRate(%@):%.2f, ridersum:%.3f, HL:%.3f",riderCode,riderRate,ridSA,riderHLoad);
		
	if (riderRate == 0.00) {
		NSLog(@"No rates were found");
	}
	
		double annFac;
        double halfFac;
        double quarterFac;
        double monthFac;
		

            annFac = 1.00;
            halfFac = 0.50;
            quarterFac = 0.25;
            monthFac = 0.0833333;
		
		//calculate occupationLoading
        [self getOccLoadRider];
        NSLog(@"occpLoadRate(%@):%d",riderCode,occLoadRider);
		/*
		double annualRider = 0;
        double halfYearRider = 0;
        double quarterRider = 0;
        double monthlyRider = 0;
		*/
	double _ann = 0.00;
	double _half =0.00;
	double _quar = 0.00;
	double _month =0.00;
	double _annWithHL = 0.00; // for fund management calculation
	double _halfWithHL =0.00;
	double _quarWithHL = 0.00;
	double _monthWithHL =0.00;

		if ([riderCode isEqualToString:@"ACIR"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double RiderHLPremium = 0.00;
			
			if (riderHLoad == 0 && riderHLoadPct == 0 ) {
				RiderPremium = (riderRate * ridSA/1000.00) / annFac;
			}
			else{
				RiderPremium = (riderRate * ridSA/1000.00) / annFac;

				/*
				_ann = (riderRate * ((1 + riderHLoad /100.00) + occLoadRider) * ridSA/1000.00 / annFac);
				_half = (riderRate * ((1 + riderHLoad /100.00) + occLoadRider) *ridSA /1000.00 / halfFac);
				_quar = (riderRate * ((1 + riderHLoad /100.00) + occLoadRider) *ridSA /1000.00 / quarterFac);
				_month = (riderRate * ((1 + riderHLoad /100.00) + occLoadRider) *ridSA /1000.00 *monthFac);
				 */
				RiderHLPremium = (RiderPremium * riderHLoadPct/100.00) + (occLoadRider + riderHLoad) * ridSA /1000.00;
			}
			
			_ann = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * annFac) ]] doubleValue];
			_half = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * halfFac) ]] doubleValue];
			_quar = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * quarterFac) ]] doubleValue];
			_month = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * monthFac) ]] doubleValue];
			
			_annWithHL = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * annFac) ]] doubleValue] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * annFac) ]] doubleValue];
			_halfWithHL = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * halfFac) ]] doubleValue] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * halfFac) ]] doubleValue];
			_quarWithHL = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * quarterFac) ]] doubleValue] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * quarterFac) ]] doubleValue];
			_monthWithHL = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * monthFac) ]] doubleValue] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * monthFac) ]] doubleValue];
			
		}
		else if ([riderCode isEqualToString:@"CIRD"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double LSDPremium = 0.00;
			double RiderPremium = 0.00;
			
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/100.00) ;
				
			}
			else{
				RiderPremium = (riderRate * ridSA/100.00) ;
				
				/*
				_ann = (riderRate * ((1 + riderHLoad /100) + occLoadRider) * ridSA/1000 / annFac);
				_half = (riderRate * ((1 + riderHLoad /100) + occLoadRider) *ridSA /1000 / halfFac);
				_quar = (riderRate * ((1 + riderHLoad /100) + occLoadRider) *ridSA /1000 / quarterFac);
				_month = (riderRate * ((1 + riderHLoad /100) + occLoadRider) *ridSA /1000 *monthFac);
				 */
			}
			
			/*
			if (ridSA >= 20000 && ridSA < 30000) {
				_ann = _ann - (ridSA * (0/1000));
			}
			else if (ridSA >= 30000 && ridSA < 50000) {
				_ann = _ann - (ridSA * (1.5/1000.00));
			}
			else if (ridSA >= 50000 && ridSA < 75000) {
				_ann = _ann - (ridSA * (2.5/1000.00));
			}
			else if (ridSA >= 75000 && ridSA <= 100000) {
				_ann = _ann - (ridSA * (3/1000.00));
			}
			*/
			if (ridSA >= 20000 && ridSA < 30000) {
				LSDPremium = (ridSA * (0/1000));
			}
			else if (ridSA >= 30000 && ridSA < 50000) {
				LSDPremium = (ridSA * (1.5/1000.00));
			}
			else if (ridSA >= 50000 && ridSA < 75000) {
				LSDPremium = (ridSA * (2.5/1000.00));
			}
			else if (ridSA >= 75000 && ridSA <= 100000) {
				LSDPremium = (ridSA * (3/1000.00));
			}
			
			_ann = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * annFac) ]] doubleValue] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * annFac) ]] doubleValue];
			_half = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * halfFac) ]] doubleValue] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * halfFac) ]] doubleValue];
			_quar = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * quarterFac) ]] doubleValue] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * quarterFac) ]] doubleValue];
			_month = [[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderPremium * monthFac) ]] doubleValue] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * monthFac) ]] doubleValue];
			
			
		
		}
		else if ([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"] ){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double RiderHLoading = 0.00;
			
			sqlite3_stmt *statement;
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			{
				NSString *querySQL;
				
				if ([riderCode isEqualToString:@"CIWP"]) {
					querySQL = [NSString stringWithFormat:
								@"SELECT sum(round(premium, 2)) from( SELECT premium FROM ul_rider_details "
								"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ACIR') "
								"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				}
				else if([riderCode isEqualToString:@"LCWP"]){
					querySQL = [NSString stringWithFormat:
								@"SELECT sum(round(premium, 2)) from( SELECT premium FROM ul_rider_details "
								"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP') "
								"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				}
				else{
					querySQL = [NSString stringWithFormat:
								@"SELECT sum(round(premium, 2)) from( SELECT premium FROM ul_rider_details "
								"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP') "
								"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				}

				//NSLog(@"%@", querySQL);
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_ROW)
					{
						ridSA =  sqlite3_column_double(statement, 0);
					}
					sqlite3_finalize(statement);
				}
				sqlite3_close(contactDB);
			}
			
			if ([getBUMPMode isEqualToString:@"S"]) {
				txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA / halfFac];
			}
			else if ([getBUMPMode isEqualToString:@"Q"]){
				txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA / quarterFac];
			}
			else if ([getBUMPMode isEqualToString:@"M"]){
				txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA / monthFac];
			}
			else {
				txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA];
			}
			
			ridSA = [txtSumAssured.text doubleValue];
			
			//NSLog(@"%f * %f/100.00, %f", riderRate, ridSA, monthFac);
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/100.00);
				RiderHLoading = 0.00;

			}
			else{
				//RiderHLoading = ridSA * (riderRate * 0.01 + ridTerm/1000.00 * occLoadRider + riderHLoad/1000.00);
				RiderPremium = (riderRate * ridSA/100.00);
				RiderHLoading = RiderPremium * 0.00 + ridSA * (ridTerm * occLoadRider + riderHLoad)/1000.00;
			}
			
			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLoading * annFac)]] doubleValue];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLoading * halfFac)]] doubleValue];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLoading * quarterFac)]] doubleValue];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLoading * monthFac)]] doubleValue];
			
		}
		else if ([riderCode isEqualToString:@"DCA"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			//NSLog(@"%f", riderRate);
			double RiderPremium = 0.00;
			double LSDPremium = 0.00;
			double RiderHLPremium = 0.00;
			
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/100.00) ;
				
			}
			else{
				RiderPremium = (riderRate * ridSA/100.00) ;

				/*
				_ann = ridSA/100.00 * 1 * (riderRate * (1 + riderHLoad /100.00) + occLoadRider/10.00 + 0 );
				_half = ridSA/100.00 * 1 * (riderRate * (1 + riderHLoad /100.00) + occLoadRider/10.00 + 0 );
				_quar = ridSA/100.00 * 1 * (riderRate * (1 + riderHLoad /100.00) + occLoadRider/10.00 + 0 );
				_month = ridSA/100.00 * 1 * (riderRate * (1 + riderHLoad /100.00) + occLoadRider/10.00 + 0 );
				 */
				RiderHLPremium = RiderPremium * riderHLoadPct/100.00 + (occLoadRider + riderHLoad) * ridSA/1000.00;
			}
			
			if (ridSA >= 10000 && ridSA < 20000) {
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0/1000);
				}
				else{
					LSDPremium = (ridSA * 0/1000);
				}
			}
			else if(ridSA >= 20000 && ridSA < 30000){
				if (getOccpClass < 3) {
					LSDPremium =  (ridSA * 0.25/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium =  (ridSA * 0.36/1000);
				}
				else{
					LSDPremium = (ridSA * 0.41/1000);
				}
			}
			else if(ridSA >= 30000 && ridSA < 40000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.34/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.48/1000);
				}
				else{
					LSDPremium = (ridSA * 0.55/1000);
				}
				
			}
			else if(ridSA >= 40000 && ridSA < 50000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.38/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.54/1000);
				}
				else{
					LSDPremium = (ridSA * 0.62/1000);
				}
				
			}
			else if(ridSA >= 50000 && ridSA < 100000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.41/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.58/1000);
				}
				else{
					LSDPremium = (ridSA * 0.66/1000);
				}
				
			}
			else if(ridSA >= 100000 && ridSA < 150000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.46/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.65/1000);
				}
				else{
					LSDPremium = (ridSA * 0.74/1000);
				}
				
			}
			else if(ridSA >= 150000 && ridSA < 250000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.48/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.68/1000);
				}
				else{
					LSDPremium = (ridSA * 0.77/1000);
				}
				
			}
			else if(ridSA >= 250000 && ridSA < 500000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.49/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.7/1000);
				}
				else{
					LSDPremium = (ridSA * 0.79/1000);
				}
				
			}
			else if(ridSA >= 500000){
				if (getOccpClass < 3) {
					LSDPremium = (ridSA * 0.5/1000);
				}
				else if (getOccpClass == 3){
					LSDPremium = (ridSA * 0.71/1000);
				}
				else{
					LSDPremium = (ridSA * 0.81/1000);
				}
			}
			
			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * annFac)]] doubleValue];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * halfFac)]] doubleValue];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * quarterFac)]] doubleValue];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * monthFac)]] doubleValue];

			_annWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] -
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * annFac)]] doubleValue] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * annFac)]] doubleValue];
			_halfWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] -
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * halfFac)]] doubleValue] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * halfFac)]] doubleValue];
			_quarWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] -
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * quarterFac)]] doubleValue] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * quarterFac)]] doubleValue];
			_monthWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] -
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(LSDPremium * monthFac)]] doubleValue] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble:(RiderHLPremium * monthFac)]] doubleValue];
			
		}
		if ([riderCode isEqualToString:@"DHI"] || [riderCode isEqualToString:@"MR"] || [riderCode isEqualToString:@"PA"] ||
			[riderCode isEqualToString:@"TPDMLA"] || [riderCode isEqualToString:@"TPDWP"] || [riderCode isEqualToString:@"WI"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double RiderHL = 0.00;
			
			if ([riderCode isEqualToString:@"TPDWP"]) {
				sqlite3_stmt *statement;
				if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
				{
					NSString *querySQL;
					
					
					querySQL = [NSString stringWithFormat:
								@"SELECT sum(round(premium, 2)) from( SELECT premium FROM ul_rider_details "
								"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ECAR','ECAR6', 'ECAR55') "
								"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_ROW)
						{
							ridSA =  sqlite3_column_double(statement, 0);
						}
						sqlite3_finalize(statement);
					}
					sqlite3_close(contactDB);
				}
				
				if ([getBUMPMode isEqualToString:@"S"]) {
					txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA * halfFac];
				}
				else if ([getBUMPMode isEqualToString:@"Q"]){
					txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA * quarterFac];
				}
				else if ([getBUMPMode isEqualToString:@"M"]){
					txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA/monthFac];
				}
				else {
					txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA];
				}
				
				ridSA = [txtSumAssured.text doubleValue];
				
				//txtSumAssured.text = [NSString stringWithFormat:@"%.2f", ridSA ];
			}
			
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/100.00) ;
				
			}
			else{
				RiderPremium = (riderRate * ridSA/100.00) ;
				RiderHL = RiderPremium * 0.00 + ridSA * (ridTerm * occLoadRider + riderHLoad)/1000.00;
				
				/*
				_ann =  (ridSA * (riderRate * ((1 + riderHLoad /100.00)/100.00 ) + occLoadRider/1000.00 + 0/1000.00)) / annFac;
				_half = (ridSA * (riderRate * ((1 + riderHLoad /100.00)/100.00 ) + occLoadRider/1000.00 + 0/1000.00)) / halfFac;
				_quar = (ridSA * (riderRate * ((1 + riderHLoad /100.00)/100.00 ) + occLoadRider/1000.00 + 0/1000.00)) / quarterFac;
				_month = (ridSA * (riderRate * ((1 + riderHLoad /100.00)/100.00 ) + occLoadRider/1000.00 + 0/1000.00)) * monthFac;
				 */
			}	
			
			if([riderCode isEqualToString:@"TPDWP"]){
				_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * annFac)]] doubleValue ];
				_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * halfFac)]] doubleValue ];
				_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * quarterFac)]] doubleValue ];
				_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * monthFac)]] doubleValue ];
			}
			else
			{
				_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ];
				_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ];
				_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ];
				_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ];
				
				_annWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] +
								[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * annFac)]] doubleValue ];
				_halfWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] +
								[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * halfFac)]] doubleValue ];
				_quarWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] +
								[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * quarterFac)]] doubleValue ];
				_monthWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] +
								[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * monthFac)]] doubleValue ];
			}
			
		
			
		}
		else if ([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"] ){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double LSDPremium = 0.00;
			double RiderHLPrem = 0.00;
			
			if (riderHLoad == 0) {
				//_ann = (riderRate * ridSA/1000.00 );
				RiderPremium = (riderRate * ridSA/1000.00 );
				
			}
			else{
				RiderPremium = (riderRate * ridSA/1000.00 );
				RiderHLPrem = ((occLoadRider + riderHLoad) * ridSA/1000.00);
				
			}
			
			if (ridSA >= 450 && ridSA < 1200) {
				LSDPremium = (ridSA * (-330.00/1000.00));
			}
			else if (ridSA >= 1200 && ridSA < 2000) {
				LSDPremium = (ridSA * (0/1000.00));
			}
			else if (ridSA >= 2000 && ridSA < 3000) {
				LSDPremium = (ridSA * (10/1000.00));
			}
			else if (ridSA >= 3000 && ridSA < 4000) {
				LSDPremium = (ridSA * (30/1000.00));
			}
			else if (ridSA >= 4000 && ridSA < 5000) {
				LSDPremium = (ridSA * (40/1000.00));
			}
			else if (ridSA >= 5000 && ridSA < 7500) {
				LSDPremium = (ridSA * (50/1000.00));
			}
			else if (ridSA >= 7500 && ridSA < 10000) {
				LSDPremium = (ridSA * (60/1000.00));
			}
			else if (ridSA >= 10000) {
				LSDPremium = (ridSA * (70/1000.00));
			}
			
			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * annFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPrem * annFac)]] doubleValue ];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * halfFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPrem * halfFac)]] doubleValue ];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * quarterFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPrem * quarterFac)]] doubleValue ];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] -
					 [[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * monthFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPrem * monthFac)]] doubleValue ];


		}
		else if ([riderCode isEqualToString:@"ECAR55"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium =0.00;
			double LSDPremium =0.00;
			
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/100.00 );
			}
			else{
				RiderPremium = ((riderRate + occLoadRider/10 + riderHLoad/10.00) * ridSA/100.00 * 1);
			}
			
			if (ridSA >= 50 && ridSA < 100) {
				LSDPremium = (ridSA * (-140.00/100.00));
			}
			else if (ridSA >= 100 && ridSA < 150) {
				LSDPremium = (ridSA * (0/100.00));
			}
			else if (ridSA >= 150 && ridSA < 200) {
				LSDPremium = (ridSA * (25/100.00));
			}
			else if (ridSA >= 200 && ridSA < 300) {
				LSDPremium = (ridSA * (40/100.00));
			}
			else if (ridSA >= 300 && ridSA < 400) {
				LSDPremium = (ridSA * (55/100.00));
			}
			else if (ridSA >= 400 && ridSA < 500) {
				LSDPremium = (ridSA * (65/100.00));
			}
			else if (ridSA >= 500 && ridSA < 1000) {
				LSDPremium = (ridSA * (70/100.00));
			}
			else if (ridSA >= 1000) {
				LSDPremium = (ridSA * (75/100.00));
			}

			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * annFac)]] doubleValue ];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * halfFac)]] doubleValue ];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * quarterFac)]] doubleValue ];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] -
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * monthFac)]] doubleValue ];

		}
		else if ([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_IV"]){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double RiderHLPremium = 0.00;
			
			if (riderHLoad == 0) {
				RiderPremium = riderRate;

			}
			else{
				RiderPremium = riderRate ;

				/*
				_ann = (riderRate * (1 + riderHLoad/100.00)) / annFac;
				_half = (riderRate * (1 + riderHLoad/100.00)) / halfFac;
				_quar = (riderRate * (1 + riderHLoad/100.00)) / quarterFac;
				_month = (riderRate * (1 + riderHLoad/100.00)) * monthFac;
				 */
				RiderHLPremium = RiderPremium * (riderHLoadPct/100.00);
			}
			
			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ];
			
			_annWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPremium * annFac)]] doubleValue ];
			_halfWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPremium * halfFac)]] doubleValue ];
			_quarWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPremium * quarterFac)]] doubleValue ];
			_monthWithHL =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] +
							[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHLPremium * monthFac)]] doubleValue ];
			
		}
		else if ([riderCode isEqualToString:@"LSR"] ){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			double RiderPremium = 0.00;
			double RiderHL = 0.00;
			double LSDPremium = 0.00;
			
			if (riderHLoad == 0) {
				RiderPremium = (riderRate * ridSA/1000.00 );
				
			}
			else{
				RiderPremium = (riderRate * ridSA/1000.00 );
				RiderHL =  ( occLoadRider + riderHLoad) * (ridSA/1000.00) ;
				
			}
			
			if (ridSA >= 20000 && ridSA < 50000) {
				LSDPremium = (ridSA * (0.00/1000.00));
			}
			else if (ridSA >= 50000 && ridSA < 100000) {
				LSDPremium = (ridSA * (3.2/1000.00));
			}
			else if (ridSA >= 100000 && ridSA < 150000) {
				LSDPremium = (ridSA * (4.00/1000.00));
			}
			else if (ridSA >= 150000 && ridSA < 200000) {
				LSDPremium = (ridSA * (4.5/1000.00));
			}
			else if (ridSA >= 200000 && ridSA < 500000) {
				LSDPremium = (ridSA * (5.00/1000.00));
			}
			else if (ridSA >= 500000 && ridSA < 750000) {
				LSDPremium = (ridSA * (5.15/1000.00));
			}
			else if (ridSA >= 750000 && ridSA < 1500000) {
				LSDPremium = (ridSA * (5.25/1000.00));
			}
			else if (ridSA >= 1500000) {
				LSDPremium = (ridSA * (5.3/1000.00));
			}

			_ann =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * annFac)]] doubleValue ] -
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * annFac)]] doubleValue ] +
					[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * annFac)]] doubleValue ];
			_half =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * halfFac)]] doubleValue ] -
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * halfFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * halfFac)]] doubleValue ];
			_quar =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * quarterFac)]] doubleValue ] -
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * quarterFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * quarterFac)]] doubleValue ];
			_month =  [[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderPremium * monthFac)]] doubleValue ] -
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (LSDPremium * monthFac)]] doubleValue ] +
						[[formatter stringFromNumber:[NSNumber numberWithDouble: (RiderHL * monthFac)]] doubleValue ];
			
		}
		else if ([riderCode isEqualToString:@"RRTUO"] ){
			_ann = 0.00;
			_half =0.00;
			_quar = 0.00;
			_month =0.00;
			
			_ann = riderRate ;
			_half = _ann *halfFac;
			_quar = _ann * quarterFac;
			_month = _ann * monthFac;
			
		}
	/*
		NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
		NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
		NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
		NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
		str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
		str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
		str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
		str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
	
		annualRider = [str_ann doubleValue];
		halfYearRider = [str_half doubleValue];
		quarterRider = [str_quar doubleValue];
		monthlyRider = [str_month doubleValue];
*/
	
		if([getBUMPMode isEqualToString:@"A"]){
			//CurrentRiderPrem = annualRider;
			CurrentRiderPrem = _ann;
		}
		else if([getBUMPMode isEqualToString:@"S"]){
			//CurrentRiderPrem = halfYearRider;
			CurrentRiderPrem = _half;
		}
		else if([getBUMPMode isEqualToString:@"Q"]){
			//CurrentRiderPrem =quarterRider;
			CurrentRiderPrem = _quar;
		}
		else{
			//CurrentRiderPrem =monthlyRider;
			CurrentRiderPrem = _month;
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

-(void)getRiderRateSexClassAge:(NSString *)aaplan Sex:(NSString *)aaSex Class:(int)aaClass Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND sex=\"%@\" AND OccClass = '%d' "
							  " AND FromAge = '%d'",
							  aaplan, aaSex, aaClass, aaAge];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }

}

-(void)getRiderRateSexTermAgeSmoker:(NSString *)aaplan Sex:(NSString *)aaSex Term:(int)aaTerm
							   Age:(int)aaAge Smoker:(NSString *)aaSmoker{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND sex=\"%@\" AND term = '%d' "
							  " AND FromAge = '%d' AND smoker ='%@'",
							  aaplan, aaSex, aaTerm, aaAge, aaSmoker];
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateSexPremTermAge:(NSString *)aaplan Sex:(NSString *)aaSex Prem:(NSString *)aaPrem
								Term:(int)aaTerm Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND sex=\"%@\" AND prempayopt = '%@' "
							  " AND FromAge = '%d' AND term ='%d'",
							  aaplan, aaSex, aaPrem, aaAge, aaTerm];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateTypeSexClassAgeDed:(NSString *)aaplan Type:(NSString *)aaType Sex:(NSString *)aaSex
							 Class:(int)aaClass Age:(int)aaAge Deduc:(NSString *)aaDeduc{
	sqlite3_stmt *statement;
	
	
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		NSString *Type;
		if ([aaType isEqualToString:@"HMM_150"]) {
			Type = @"MM150";
		}
		else if ([aaType isEqualToString:@"HMM_200"]) {
			Type = @"MM200";
		}
		else if ([aaType isEqualToString:@"HMM_300"]) {
			Type = @"MM300";
		}
		else if ([aaType isEqualToString:@"HMM_400"]) {
			Type = @"MM400";
		}
		
		
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode =\"%@\" AND sex=\"%@\" AND OccClass = \"%d\" "
							  " AND FromAge = \"%d\" AND Type =\"%@\" AND deductible = \"%@\" ",
							  aaplan, aaSex, aaClass, aaAge, Type, aaDeduc];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
		else{
			NSLog(@"%s Prepare failure '%s' (%1d)", __FUNCTION__, sqlite3_errmsg(contactDB), sqlite3_errcode(contactDB));
			//NSLog(@"Statement problem, %@", querySQL);
		}
        sqlite3_close(contactDB);
    }
	else{
		NSLog(@"%@ got error", UL_RatesDatabasePath);
	}
	
}

-(void)getRiderRateTypeAgeSexClass:(NSString *)aaplan Type:(NSString *)aaType Sex:(NSString *)aaSex
								Class:(int)aaClass Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
		NSString *Type;
		if ([aaType isEqualToString:@"MGIVP_150"]) {
			Type = @"MGIV_150";
		}
		else if ([aaType isEqualToString:@"MGIVP_200"]) {
			Type = @"MGIV_200";
		}
		else if ([aaType isEqualToString:@"MGIVP__300"]) {
			Type = @"MGIV_300";
		}
		else if ([aaType isEqualToString:@"MGIVP_400"]) {
			Type = @"MGIV_400";
		}
		
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND sex=\"%@\" AND OccClass = '%d' "
							  " AND FromAge = '%d' AND Type ='%@'",
							  aaplan, aaSex, aaClass, aaAge, Type];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateSexAge:(NSString *)aaplan Sex:(NSString *)aaSex Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND sex=\"%@\" "
							  " AND FromAge = '%d' ",
							  aaplan, aaSex, aaAge];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
}

-(void)getRiderRateGYITermAge:(NSString *)aaplan GYIStartFrom:(NSString *)aaGYIStartFrom Term:(int)aaTerm Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
			querySQL = [NSString stringWithFormat:
								  @"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='ECAR' AND term = '%d' "
								  " AND FromAge <= '%d' AND toAge >= '%d' AND GYIStartFrom ='%@'",
								   aaTerm, aaAge, aaAge, aaGYIStartFrom];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRatePremTermAge:(NSString *)aaplan Prem:(NSString *)aaPrem Term:(int)aaTerm Age:(int)aaAge{
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
			querySQL = [NSString stringWithFormat:
						@"SELECT rate FROM ES_Sys_Rider_Prem WHERE plancode ='%@' AND term = '%d' "
						" AND FromAge = '%d' AND prempayopt ='%@'",
						aaplan, aaTerm, aaAge, aaPrem];
		
        
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_Sys_rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(NSString *)ReturnReinvest{
	NSString *returnvalue;
	
	if (outletReinvest.hidden == YES) {
		returnvalue = @"No";
	}
	else{
		if (outletReinvest.selectedSegmentIndex == 0) {
			returnvalue = @"Yes";
		}
		else{
			returnvalue = @"No";
		}
	}
	
	return returnvalue;
}

-(void)updateRider
{
	sqlite3_stmt *statement;
	
	[self ReturnCurrentRiderPrem:0];
    //sqlite3_stmt *statement;
	
	NSString *FullRiderDesc = [self ReturnRiderDesc:riderCode];
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *updatetSQL;
		
		if ([riderCode isEqualToString:@"RRTUO"]) {
			updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
						  @"UPDATE UL_Rider_Details SET RRTUOFromYear=\"%@\", RRTUOYear=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%f', RiderDesc = '%@' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\"", txtRiderTerm.text, txtPaymentTerm.text, planOption,
						  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc, getSINo,
						  riderCode,pTypeCode, PTypeSeq];
		}
		else{
			updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%f', RiderDesc = '%@', paymentTerm ='%@' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\"", txtRiderTerm.text, txtSumAssured.text, planOption,
						  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc, txtPaymentTerm.text, getSINo,
						  riderCode,pTypeCode, PTypeSeq];
		}
		
        if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
				[self CheckWaiverRiderPrem];
                [self validateRules];
	            
            } else {
                NSLog(@"Update Rider failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
	[self CalcTotalRiderPrem];
    
	
	
}



-(void)checkingRider
{
    existRidCode = [[NSString alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode FROM UL_Rider_Details WHERE SINo=\"%@\" "
							  "AND RiderCode=\"%@\" AND PTypeCode=\"%@\" AND Seq=\"%d\"",getSINo,riderCode,pTypeCode, PTypeSeq];
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

-(void)check2ndLARider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode FROM UL_Rider_Details WHERE SINo=\"%@\" AND "
							  "PTypeCode=\"%@\" AND Seq=\"%d\"",getSINo,pTypeCode, PTypeSeq];
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

-(void)CheckWaiverRiderPrem{
	if ([riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"PR"] ||
		[riderCode isEqualToString:@"TPDWP"]) {
		return;
	}
	
	sqlite3_stmt *statement;
	double ridSA = 0.00;
	NSString *tempSA = txtSumAssured.text;
	NSString *TempRiderCode = riderCode;
	int RiderTerm;
	NSString *querySQL;
	NSUInteger index = [LTypeRiderCode indexOfObject:@"CIWP"];
	double half = 0.5, quarter = 0.25, month = 0.0833333;
	
		if (index != NSNotFound) {
			
			riderCode = @"CIWP";
			RiderTerm = [[LTypeTerm objectAtIndex:index] intValue];
			[self ReturnCurrentRiderPrem:RiderTerm];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			 {
				 querySQL = [NSString stringWithFormat:
							 @"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							 "where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ACIR') "
							 "union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				 
				 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				 {
					 if (sqlite3_step(statement) == SQLITE_ROW)
					 {
						 if ([getBUMPMode isEqualToString:@"S"]) {
							 ridSA = sqlite3_column_double(statement, 0)/half  ;
						 }
						 else if ([getBUMPMode isEqualToString:@"Q"]){
							 ridSA = sqlite3_column_double(statement, 0)/quarter;
						 }
						 else if ([getBUMPMode isEqualToString:@"M"]){
							 ridSA = sqlite3_column_double(statement, 0)/month;
						 }
						 else{
							 ridSA = sqlite3_column_double(statement, 0);
						 }
					 }
					 sqlite3_finalize(statement);
				 }
				 
				 querySQL = [NSString stringWithFormat:
							 @"UPDATE UL_Rider_Details SET premium = '%f', SumAssured ='%.2f' WHERE sino = '%@' AND Ridercode = '%@'",
							 CurrentRiderPrem, ridSA, getSINo, @"CIWP"];
				 //NSLog(@"%@", querySQL);
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
		
		index = [LTypeRiderCode indexOfObject:@"LCWP"];
		if (index != NSNotFound) {
			riderCode = @"LCWP";
			RiderTerm = [[LTypeTerm objectAtIndex:index] intValue];
			[self ReturnCurrentRiderPrem:RiderTerm];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			{
				querySQL = [NSString stringWithFormat:
							@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP') "
							"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_ROW)
					{
						if ([getBUMPMode isEqualToString:@"S"]) {
							ridSA = sqlite3_column_double(statement, 0)/half  ;
						}
						else if ([getBUMPMode isEqualToString:@"Q"]){
							ridSA = sqlite3_column_double(statement, 0)/quarter;
						}
						else if ([getBUMPMode isEqualToString:@"M"]){
							ridSA = sqlite3_column_double(statement, 0)/month;
						}
						else{
							ridSA = sqlite3_column_double(statement, 0);
						}
					}
					sqlite3_finalize(statement);
				}
				
				querySQL = [NSString stringWithFormat:
							@"UPDATE UL_Rider_Details SET premium = '%f', SumAssured = '%.2f' WHERE sino = '%@' AND Ridercode = '%@'",
							CurrentRiderPrem, ridSA, getSINo, @"LCWP"];
				
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
		
		index = [LTypeRiderCode indexOfObject:@"PR"];
		if (index != NSNotFound) {
			riderCode = @"PR";
			RiderTerm = [[LTypeTerm objectAtIndex:index] intValue];
			[self ReturnCurrentRiderPrem:RiderTerm];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
				querySQL = [NSString stringWithFormat:
							@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP') "
							"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
				
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_ROW)
					{
						if ([getBUMPMode isEqualToString:@"S"]) {
							ridSA = sqlite3_column_double(statement, 0)/half  ;
						}
						else if ([getBUMPMode isEqualToString:@"Q"]){
							ridSA = sqlite3_column_double(statement, 0)/quarter;
						}
						else if ([getBUMPMode isEqualToString:@"M"]){
							ridSA = sqlite3_column_double(statement, 0)/month;
						}
						else{
							ridSA = sqlite3_column_double(statement, 0);
						}
					}
					sqlite3_finalize(statement);
				}
				
				
				querySQL = [NSString stringWithFormat:
							@"UPDATE UL_Rider_Details SET premium = '%f', SumAssured = '%.2f' WHERE sino = '%@' AND Ridercode = '%@'",
							CurrentRiderPrem, ridSA, getSINo, @"PR"];
				
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
	
	index = [LTypeRiderCode indexOfObject:@"TPDWP"];
	if (index != NSNotFound) {
		riderCode = @"TPDWP";
		RiderTerm = [[LTypeTerm objectAtIndex:index] intValue];
		[self ReturnCurrentRiderPrem:RiderTerm];
		
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			querySQL = [NSString stringWithFormat:
						@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
						"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ECAR55', 'ECAR', 'ECAR6') "
						"union SELECT atprem FROM ul_details  where  sino = '%@') as zzz", getSINo, getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					if ([getBUMPMode isEqualToString:@"S"]) {
						ridSA = sqlite3_column_double(statement, 0)/half  ;
					}
					else if ([getBUMPMode isEqualToString:@"Q"]){
						ridSA = sqlite3_column_double(statement, 0)/quarter;
					}
					else if ([getBUMPMode isEqualToString:@"M"]){
						ridSA = sqlite3_column_double(statement, 0)/month;
					}
					else{
						ridSA = sqlite3_column_double(statement, 0);
					}
					
				}
				sqlite3_finalize(statement);
			}
			
			
			querySQL = [NSString stringWithFormat:
						@"UPDATE UL_Rider_Details SET premium = '%f', SumAssured = '%.2f' WHERE sino = '%@' AND Ridercode = '%@'",
						CurrentRiderPrem, ridSA, getSINo, @"TPDWP"];
			
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
	
		
	riderCode = TempRiderCode;
	txtSumAssured.text = tempSA;
	
}

-(void)CalcTotalRiderPrem{
	
	sqlite3_stmt *statement;
	NSString *querySQL;
	//double half = 0.5, quarter = 0.25, month = 0.0833333;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];

	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		{
			querySQL = [NSString stringWithFormat:
						@"SELECT sum(round(premium, 2)) from ul_rider_details where sino = '%@' ",  getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					txtRiderPremium.text =  [ NSString stringWithFormat:@"%.2f", sqlite3_column_double(statement, 0) ] ;
					txtRiderPremium.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtRiderPremium.text doubleValue]]];
					
				}
				sqlite3_finalize(statement);
			}
			
			sqlite3_close(contactDB);
		}
		
}


#pragma mark- Button Action
- (IBAction)ActionPersonType:(id)sender {
	if(_PTypeList == nil){
        
		//self.PTypeList = [[RiderPTypeTbViewController alloc] initWithString:getSINo];
		self.PTypeList = [[RiderPTypeTbViewController alloc] initWithString:getSINo str:@"EVER"];
        _PTypeList.delegate = self;
        self.pTypePopOver = [[UIPopoverController alloc] initWithContentViewController:_PTypeList];
	}
	
	CGRect aa = [sender frame];
	aa.origin.y = [sender frame].origin.y + 30;
	
    [self.pTypePopOver setPopoverContentSize:CGSizeMake(350.0f, 400.0f)];
    [self.pTypePopOver presentPopoverFromRect:aa inView:self.view
					 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)ActionRider:(id)sender {
	if ([occLoadType isEqualToString:@"D"]) {
        NSString *msg = nil;
        if ([pTypeCode isEqualToString:@"PY"]) {
            msg = @"Payor is not qualified to add any rider";
        }
        
        if (PTypeSeq == 2) {
            msg = @"2nd Life Assured is not qualified to add any rider";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
	else{
		Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
        [activeInstance performSelector:@selector(dismissKeyboard)];
		
		self.RiderList = [[RiderListTbViewController alloc] initWithStyle:UITableViewStylePlain];
        _RiderList.delegate = self;
		_RiderList.TradOrEver = @"EVER";
        _RiderList.requestPtype = self.pTypeCode;
        _RiderList.requestPlan = getPlanCode;
        _RiderList.requestSeq = self.PTypeSeq;
        _RiderList.requestOccpClass = getOccpClass;
        _RiderList.requestAge = self.pTypeAge;
		_RiderList.requestOccpCat = self.OccpCat;
		_RiderList.requestOccpCPA = getOccpCPA;
		
		if ([pTypeCode isEqualToString:@"PY"]) {
			_RiderList.requestPayorSmoker = getPayorSmoker;
		}
		else if([pTypeCode isEqualToString:@"LA"] && PTypeSeq == 2)
		{
			_RiderList.request2ndSmoker = get2ndSmoker;
		}
		else{
			_RiderList.requestSmoker = getSmoker;
		}
		
		
		self.RiderListPopover = [[UIPopoverController alloc] initWithContentViewController:_RiderList];
        
		CGRect aa = [sender frame];
		aa.origin.y = [sender frame].origin.y + 30;
		
        [self.RiderListPopover setPopoverContentSize:CGSizeMake(600.0f, 400.0f)];
        [self.RiderListPopover presentPopoverFromRect:aa inView:self.view
							 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		
	}
}
- (IBAction)ActionDeductible:(id)sender {
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
    self.deductList = [[RiderDeducTb alloc] initWithString:deducCondition andSumAss:strSA andOption:planOption];
    _deductList.delegate = self;
    self.deducPopover = [[UIPopoverController alloc] initWithContentViewController:_deductList];
    
    [self.deducPopover setPopoverContentSize:CGSizeMake(350.0f, 250.0f)];
	
	CGRect dadas = [sender frame ];
	dadas.origin.y = dadas.origin.y + 25;
    [self.deducPopover presentPopoverFromRect:dadas inView:self.view
					 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)ActionDelete:(id)sender {
	NSString *ridCode;
    int RecCount = 0;
    for (UITableViewCell *cell in [myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [myTableView indexPathForCell:cell];
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1001];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag==1001 && buttonIndex == 0){ //delete
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
            for(int a=0; a<sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;
                
                NSString *rider = [LTypeRiderCode objectAtIndex:value];
                NSString *querySQL = [NSString stringWithFormat:
									  @"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,rider];
				
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
				
                [LTypeRiderCode removeObjectAtIndex:value];
                [LTypeSumAssured removeObjectAtIndex:value];
                [LTypeTerm removeObjectAtIndex:value];
                [LTypePlanOpt removeObjectAtIndex:value];
                [LTypeUnits removeObjectAtIndex:value];
                [LTypeDeduct removeObjectAtIndex:value];
                [LTypeRidHL1K removeObjectAtIndex:value];
                [LTypeRidHLP removeObjectAtIndex:value];
                [LTypeSmoker removeObjectAtIndex:value];
                [LTypeAge removeObjectAtIndex:value];
				[LTypePremium removeObjectAtIndex:value];
                
                
            }
            sqlite3_close(contactDB);
        }
		
		[myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.myTableView reloadData];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
        
		[self CheckWaiverRiderPrem];
        [self validateRules];
		[self CalcTotalRiderPrem];
        
		outletDelete.enabled = FALSE;
        [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [_delegate RiderAdded];
		[self clearField];
		riderCode = @"";
		[self.outletRider setTitle:@"" forState:UIControlStateNormal];

	}
	else if (alertView.tag == 1005 && buttonIndex ==0)      //deleting due to business rule
    {
        [self getListingRiderByType];
        [self getListingRider];
        
        //[self calculateRiderPrem];
        //[self calculateWaiver];
        //[self calculateMedRiderPrem];
        
        //if (medRiderPrem != 0) {
            //[self MHIGuideLines];
        //}
        [_delegate RiderAdded];
    }
	else if (alertView.tag == 1006 && buttonIndex == 0) //displayed label min/max
    {
        [self displayedMinMax];
    }
	else if (alertView.tag == 1007 && buttonIndex == 0)
    {
		[self Validation];
    }
}


-(void)displayedMinMax
{
    if ([txtSumAssured isFirstResponder] == TRUE) {
        
		lblMin.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
		
		if ([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"ECAR"] ||
			[riderCode isEqualToString:@"ECAR6"] || [riderCode isEqualToString:@"ECAR55"] ) {
			lblMax.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting"];
		}
		else if ([riderCode isEqualToString:@"RRTUO"]){
			lblMax.text = @"";
			lblMin.text = @"";
		}
		else if ([riderCode isEqualToString:@"ACIR"]){
			lblMax.numberOfLines = 2;
			lblMax.text = [NSString stringWithFormat:@"Max SA: %.f(Subject to CI Benefit\nLimit per Life of RM1.5mil)",maxRiderSA];
		}
		else{
			lblMax.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
		}
		
    }
    else if ([txtRiderTerm isFirstResponder] == TRUE) {
		lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
		lblMax.text = [NSString stringWithFormat:@"Max Term: %.f",maxRiderTerm];
    }
    
    else {
		lblMin.text = @"";
		lblMax.text = @"";
    }
}

-(void)validateRules{
	[self getListingRider];
    
	NSString *currentSelectedRider = riderCode;
    BOOL dodelete = NO;
	//BOOL unitization = NO;
	
	for (int p=0; p<LRiderCode.count; p++) {
		
		
		
		riderCode = [LRiderCode objectAtIndex:p]; //temporary set ridercode to ridercode in array
        [self getRiderTermRule];
        [self calculateTerm];
        [self calculateSA];
		double riderSA = [[LSumAssured objectAtIndex:p] doubleValue];
        //int riderUnit = [[LUnits objectAtIndex:p] intValue];
        int riderTerm = [[LTerm objectAtIndex:p] intValue];
		if (riderSA > maxRiderSA)
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND "
									  "RiderCode=\"%@\"",requestSINo,riderCode];
				
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"riderSA (%f) > maxRiderSA(%f), rider %@ delete!", riderSA, maxRiderSA, riderCode);
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
			dodelete = YES;
			sqlite3_stmt *statement;
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			{
		
				NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
		
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_DONE)
					{
						NSLog(@"riderTerm (%d) > maxRiderTerm(%f), rider %@ delete!", riderTerm, maxRiderTerm, riderCode);
					} else {
						NSLog(@"rider delete Failed!");
					}
					sqlite3_finalize(statement);
				}
		
				sqlite3_close(contactDB);
			}
		}

	}
	

	
	
/*
if (dodelete) {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[alert setTag:1005];
	[alert show];
}
else {
	[self getListingRider];
	[self getListingRiderByType];
	
	//[self calculateRiderPrem];
	//[self calculateWaiver];
	//[self calculateMedRiderPrem];
	
	//if (medRiderPrem != 0) {
		//[self MHIGuideLines];
	//}
	[_delegate RiderAdded];
	
	riderCode = currentSelectedRider;
	[self getRiderTermRule];
	[self calculateTerm];
	[self calculateSA];
}
 */
	[self getListingRider];
	[self getListingRiderByType];
	[_delegate RiderAdded];
	
	riderCode = currentSelectedRider;
	[self getRiderTermRule];
	[self calculateTerm];
	[self calculateSA];
}

- (IBAction)ActionEdit:(id)sender {
	[self resignFirstResponder];
    if ([self.myTableView isEditing]) {
        [self.myTableView setEditing:NO animated:TRUE];
		outletDelete.hidden = true;
        [outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        [self.myTableView setEditing:YES animated:TRUE];
		outletDelete.hidden = FALSE;
        [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [outletEdit setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
	
}

- (IBAction)ActionSave:(id)sender {
	/*
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	if (![zzz.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		[self Validation];
	}
	*/
	[_delegate RiderGlobalSave];
}

- (IBAction)ActionAddRider:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	if (![zzz.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		[self Validation];
	}
}

-(void)Validation{
	if (Edit == TRUE ) {
		[self resignFirstResponder];
		[self.view endEditing:YES];
		
		[myTableView setEditing:FALSE];
		[self.myTableView setEditing:NO animated:TRUE];
		outletDelete.hidden = true;
		[outletEdit setTitle:@"Delete" forState:UIControlStateNormal ];
		/*
		NSUInteger i;
		for (i=0; i<[FLabelCode count]; i++)
		{
			if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
				inputHL1KSA = [[NSString alloc]initWithFormat:@"%@",txtHL.text];
				inputHL1KSATerm = [txtHLTerm.text intValue];
			} else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
				inputHLPercentage = [[NSString alloc]initWithFormat:@"%@",txtHL.text];
				inputHLPercentageTerm = [txtHLTerm.text intValue];
			}
			 
			
		}
		*/
		inputHL1KSA = [[NSString alloc]initWithFormat:@"%@",txtHL.text];
		inputHL1KSATerm = [txtHLTerm.text intValue];
		
		inputHLPercentage = [[NSString alloc]initWithFormat:@"%@",txtHLP.text];
		inputHLPercentageTerm = [txtHLPTerm.text intValue];
		
		if (riderCode.length == 0 || outletRider.titleLabel.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Please select a Rider." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
		else {
			NSLog(@"validate - 4th save");
			[self validateSaver];
		}
		
	}
}

- (IBAction)ActionPlan:(id)sender {
	[self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
    //if (_planList == Nil) {
	NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
	self.planList = [[RiderPlanTb alloc] initWithStyle:UITableViewStylePlain];
	//self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andoccpCat:OccpCat];
	self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"EVER"];
	
    
    //}
	_planList.delegate = self;
	self.planPopover = [[UIPopoverController alloc] initWithContentViewController:_planList];
    
    [self.planPopover setPopoverContentSize:CGSizeMake(350.0f, 400.0f)];
    [self.planPopover presentPopoverFromRect:[sender frame] inView:self.view
					permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - clear textbox field
-(void)clearField
{
    term = NO;
    sumA = NO;
    plan = NO;
    unit = NO;
    deduc = NO;
	ECAR55MonthlyIncome = NO;
	ECARYearlyIncome = NO;
	ECAR6YearlyIncome = NO;
	RRTUOPrem = NO;
    hload = NO;
    hloadterm = NO;
	hloadPct = NO;
    hloadtermPct = NO;
    planOption = nil;
    deductible = nil;
    inputHL100SA = nil;
    inputHL1KSA = nil;
    inputHLPercentage = nil;
    inputHL1KSATerm = 0;
    inputHL100SATerm = 0;
    inputHLPercentageTerm = 0;
	txtRiderTerm.text = @"";
	txtReinvestment.text = @"";
	txtSumAssured.text = @"";
	txtPaymentTerm.text = @"";
	txtGYIFrom.text = @"";
	txtHL.text = @"";
	txtHLTerm.text = @"";
	txtHLP.text = @"";
	txtHLPTerm.text = @"";
	txtRRTUP.text = @"";
	txtRRTUPTerm.text = @"";
	inputSA = 0;
    secondLARidCode = nil;
	minTerm = 0;
    maxTerm = 0;
    minSATerm = 0;
    maxSATerm = 0;
    maxRiderSA = 0;
    storedMaxTerm = 0;
    
    [self.outletRiderPlan setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
    [self.outletDeductible setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
}

- (IBAction)ActionReinvest:(id)sender {
}

@end
