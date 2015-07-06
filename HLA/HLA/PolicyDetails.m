//
//  PolicyDetails.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PolicyDetails.h"
#import "ColorHexCode.h"
//#import "ExistingLifePolicies.h"
#import "DataClass.h"
#import "FullyReducePaidUpPopover.h"
#import "AppDelegate.h"
#import "textFields.h"
#import "eAppsListing.h"

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 15
#define CHARACTER_LIMIT_ACCNO 16
#define CHARACTER_LIMIT_ICNO 12
#define CHARACTER_LIMIT_EXP_DATE_M 2
#define CHARACTER_LIMIT_EXP_DATE_Y 4
#define CHARONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"
#define CHARACTER_LIMIT_CARD_NAME 50
#define CHARACTER_LIMIT_OTHERIDFT 30
#define CHARACTER_LIMIT_OTHERIDRP 30
#define CHARACTER_LIMIT_ExactDuties 40
#define CHARACTER_LIMIT_AGENTCODE 8

@interface PolicyDetails () {
	DataClass *obj;
    bool isCompany;
	bool la2Available;
	bool PYAvailable;
	bool POAvailable;
	BOOL isFTPayment;
    BOOL isDCPayment;
	int firstTime, firstTime2, firstTime3;
    NSString *str_plan;
    NSArray *fundsKeys;
    NSMutableArray *paidUpRiders;
    NSMutableArray *tempRDesc;
    NSMutableArray *aDesc;
	NSMutableArray *a2025;
	NSMutableArray *a2028;
	NSMutableArray *a2030;
	NSMutableArray *a2035;
	NSMutableArray *aDana;
	NSMutableArray *aRet;
	NSMutableArray *aCash;
	NSString *BAnual;
	NSString *BSemi;
	NSString *BQuater;
	NSString *BMonthly;
	NSString *BasicSA;
	NSString *BPolicyTerm;
 }

@end

@implementation PolicyDetails
@synthesize DOBLbl, OtherIDLbl;
@synthesize SIDatePopover =_SIDatePopover;
@synthesize SIDate = _SIDate;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize IDTypeVC = _IDTypeVC;

@synthesize memberNameTF = _memberNameTF;
@synthesize memberOtherIDTF = _memberOtherIDTF;
@synthesize agentCodeTF = _agentCodeTF;
@synthesize agentNameTF = _agentNameTF;
@synthesize IDTypeCodeSelected, FTIDTypeCodeSelected;
@synthesize srvTaxLbl = _srvTaxLbl;
@synthesize FTmemberContactNoPrefixCF = _FTmemberContactNoPrefixCF;
@synthesize TckbuttonPolicyBankDetails;
@synthesize DCBankName;
@synthesize DCBankNameBtn,DCAccountTypeBtn;
@synthesize DCAccountType;
@synthesize DCAccNo;
@synthesize PayeeType;
@synthesize DCNewIcNo;
@synthesize OtherIDTypeDc;

@synthesize OtherIDDC;
@synthesize emailDC;
@synthesize mobileNoPrefixDC;
@synthesize mobileNoDC,ChangeTick,ChangeTickMAsterMenu;
@synthesize  lbl;



- (void)viewDidLoad
{
	//    lbl=[[UILabel alloc]initWithFrame:CGRectMake(170, 2536, 250, 40)];
	//    [lbl setText:@"(Please  submit Special LIEN form for processing)"];
	//    [lbl setBackgroundColor:[UIColor clearColor]];
	//    [lbl setTextColor:[UIColor blackColor]];
	//    [self.view addSubview:lbl];
	//    lbl.hidden=YES;
    
    _lblSubmitSpecial.hidden =YES;
	
	
    firstTime = 1;
    firstTime2 = 1;
	firstTime3 = 1;
    
    
    
	//    NSString *str= [[NSUserDefaults standardUserDefaults]objectForKey:@"tickmark"];
	//    [[NSUserDefaults standardUserDefaults]synchronize];
	//
	//    if ([str isEqualToString:@"YES"])
	//    {
	//        lbl.hidden=NO;
	//        [_btnLIEN setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	//    }
	//    else{
	//        lbl.hidden=YES;
	//        [_btnLIEN setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	//    }
	//
    
	_memberNameTF.delegate = self;
	_memberOtherIDTF.delegate = self;
	
	_agentCodeTF.delegate = self;
	_agentNameTF.delegate = self;
    
    DCAccNo.delegate = self;
    mobileNoDC.delegate = self;
    mobileNoPrefixDC.delegate = self;
    emailDC.delegate = self;
    
	
	_btnLIEN.enabled =  FALSE;
    _btnLIEN.userInteractionEnabled = FALSE;
    
	_FTmemberOtherIDTF.delegate=self;
    _FTmemberContactNoPrefixCF.delegate = self;
    
    [super viewDidLoad];
    [self TckPolicyBankDetailsDC:Nil];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
	
	//db
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	dbpath = [databasePath UTF8String];
	//
	obj = [DataClass getInstance];
    
    //[[obj.eAppData objectForKey:@"EAPP"] setValue:@"UV" forKey:@"SIPlanName"];
	
//    if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife Plus"])
//        str_plan = @"HLA EverLife Plus";
//    
//    else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UP"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverGain Plus"])
//        str_plan = @"HLA EverGain Plus";
//    else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"L100"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"Life100"])
//        str_plan = @"Life100";
//    else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLAWP"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Wealth Plan"])
//        str_plan = @"HLA Wealth Plan";
//    else
//        str_plan = @"HLA Cash Promise";
	
	eAppsListing *eAppList = [[eAppsListing alloc]init];
	str_plan = [eAppList GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
	NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
	
	
    NSString *path = [docsDir stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results = Nil;
	//	results = [database executeQuery:@"select * from Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	results = [database executeQuery:@"select * from Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	while ([results next]) {
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"BasicSA"] forKey:@"SumAssured"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"PolicyTerm"] forKey:@"PolicyTerm"];
		
		BasicSA = [results stringForColumn:@"BasicSA"];
		BPolicyTerm = [results stringForColumn:@"PolicyTerm"];
		
		
	}
    
    if ([SIType isEqualToString:@"ES"]) {
        results = nil;
        results = [database executeQuery:@"select * from UL_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
        while ([results next]) {
            [[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"BasicSA"] forKey:@"SumAssured"];
            
            // for basic unit account
            [[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"ATU"] forKey:@"BasicUnitAcc"];
			//for payment mode ##ENS
			[[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"BUMPMODE"] forKey:@"PaymentModeE"];
        }
		
        // for rider unit account
        results = nil;
        results = [database executeQuery:@"select Units from UL_Rider_Details where SINO = ?", [[obj.eAppData objectForKey:@"EAPP"]     objectForKey:@"SINumber"], nil];
        while ([results next]) {
            [[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"Units"] forKey:@"RiderUnitAcc"];
        }
    }
    
	results2 = Nil;
	//	results2 = [database executeQuery:@"select count(*) as count from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	NSLog(@"SIPlanName: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]);
    if ([SIType isEqualToString:@"TRAD"]) {
        results2 = [database executeQuery:@"select count(*) as count from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
    else if ([SIType isEqualToString:@"ES"]) {
        results2 = [database executeQuery:@"select count(*) as count from UL_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
	
	
	int rider = 0;
	riderCount = 0;
	while ([results2 next]) {
		if ([results2 intForColumn:@"count"] > 0) {
			rider = 1;
			NSLog(@"count ####: %d", [results2 intForColumn:@"count"]);
			riderCount = [results2 intForColumn:@"count"];
		}
	}
	//	riderCount = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RiderCount"] intValue];
	NSLog(@"rider count: %d", riderCount);
	
	results2 = Nil;
	//	results2 = [database executeQuery:@"select * from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	tempRPersonType = [[NSMutableArray alloc] init];
	tempRName = [[NSMutableArray alloc] init];
	tempRTerm = [[NSMutableArray alloc] init];
	tempRSumAssured = [[NSMutableArray alloc] init];
	riderData = [[NSMutableArray alloc] init];
    tempRDesc = [NSMutableArray array];
    
    tempRSAAnnualy = [[NSMutableArray alloc] init];
    tempRSAQuarterly = [[NSMutableArray alloc] init];
    tempRSASemi = [[NSMutableArray alloc] init];
    tempRSAMonthly = [[NSMutableArray alloc] init];
    
    tempRMPAnnually = [[NSMutableArray alloc] init];
    tempRMPSemiAnnually = [[NSMutableArray alloc] init];
    tempRMPQuarterly = [[NSMutableArray alloc] init];
    tempRMPMonthly = [[NSMutableArray alloc] init];
	
	
	tempGST_Annual = [[NSMutableArray alloc] init];
    tempGST_Semi = [[NSMutableArray alloc] init];
    tempGST_Quarter = [[NSMutableArray alloc] init];
    tempGST_Month = [[NSMutableArray alloc] init];
	
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"]) {
        //results2 = [database executeQuery:@"select A.*, B.*, A.RiderDesc, C.RiderName from Trad_Rider_Details as A, SI_Store_Premium AS B, Trad_Sys_Rider_Label AS C  where B.SINo = A.SINo and A.RiderCode = C.RiderCode and A.SINo = ? GROUP BY IndexNo",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
        //changed to sort the order
        results2 = [database executeQuery:@"select A.*, B.*, A.RiderDesc, C.RiderName from Trad_Rider_Details as A, SI_Store_Premium AS B, Trad_Sys_Rider_Label AS C  where B.SINo = A.SINo and A.RiderCode = C.RiderCode and A.SINo = ? GROUP BY A.RiderCode",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        NSLog(@"SI NO: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
        results2 = [database executeQuery:@"select A.*, B.RiderName from UL_Rider_Details as A, UL_Rider_Label as B where SINo = ? and A.RiderCode = B.RiderCode Group By A.RiderCode",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
	
	while ([results2 next]) {
		type = [NSString stringWithFormat:@"%@%@",[results2 stringForColumn:@"PTypeCode"], [results2 stringForColumn:@"Seq"]];
		
        name = [results2 stringForColumn:@"RiderCode"];
		term = [results2 stringForColumn:@"RiderTerm"];
		sumAssured = [results2 stringForColumn:@"SumAssured"];
		
		
        
        if ([name isEqualToString:@"LCWP"] || [name isEqualToString:@"CIWP"] || [name isEqualToString:@"PR"] || [name isEqualToString:@"SP_PRE"] || [name isEqualToString:@"TPDWP"]) {
            
			FMResultSet *resultsGetWOP = Nil;
			resultsGetWOP = [database executeQuery:@"select * from SI_Store_Premium where SINo = ? And Type = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],name,Nil];
			while ([resultsGetWOP next]) {
				WOPAmount = [resultsGetWOP stringForColumn:@"WaiverSAAnnual"];
				sumAssured = WOPAmount;
			}
        }
        if ([sumAssured isEqualToString:@""]) {
            sumAssured = @"0.00";
        }
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setMaximumFractionDigits:2];
        [fmt setPositiveFormat:@"#,##0.00"];
        sumAssured = [fmt stringFromNumber:[fmt numberFromString:sumAssured]];
        
        NSString *type2 = [results2 stringForColumn:@"PTypeCode"];
		[tempRPersonType addObject:type];
		[tempRName addObject:name];
		//        [tempRDesc addObject:[results2 objectForColumnName:@"RiderName"]];
        
        if ([name isEqualToString:@"HB"]) {
            [tempRDesc addObject:[NSString stringWithFormat:@"%@             (%@ Unit(s))",[results2 stringForColumn:@"RiderDesc"],[results2 stringForColumn:@"Units"]]];
        }
        else
        {
            [tempRDesc addObject:[results2 objectForColumnName:@"RiderDesc"]];
			
        }
        
        if ([name isEqualToString:@"EDB"] || [name isEqualToString:@"ETPDB"]) {
            term = @"6";
        }
		[tempRTerm addObject:term];
        if ([type2 isEqualToString:@"LCWP"] || [type2 isEqualToString:@"CIWP"] || [type2 isEqualToString:@"PR"] || [type2 isEqualToString:@"SP_PRE"] || [type2 isEqualToString:@"SP_STD"]) {
            [tempRSAAnnualy addObject:[results2 stringForColumn:@"WaiverSAAnnual"]];
            [tempRSAQuarterly addObject:[results2 stringForColumn:@"WaiverSAQuarter"]];
            [tempRSAMonthly addObject:[results2 stringForColumn:@"WaiverSAMonth"]];
            [tempRSASemi addObject:[results2 stringForColumn:@"WaiverSASemi"]];
        }
        else {
            [tempRSAAnnualy addObject:sumAssured];
            [tempRSASemi addObject:sumAssured];
            [tempRSAMonthly addObject:sumAssured];
            [tempRSAQuarterly addObject:sumAssured];
        }
		//[tempRSumAssured addObject:sumAssured];
		//		[riderData addObject:tempRPersonType];
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
            NSLog(@"Ever Series");
            
            modalPremiumAnnually = [results2 stringForColumn:@"Premium"];
            modalPremiumSemiAnnually = [results2 stringForColumn:@"Premium"];
            modalPremiumQuarterly = [results2 stringForColumn:@"Premium"];
            modalPremiumMonthly = [results2 stringForColumn:@"Premium"];
            
            [tempRMPAnnually addObject:modalPremiumAnnually];
            [tempRMPSemiAnnually addObject:modalPremiumSemiAnnually];
            [tempRMPQuarterly addObject:modalPremiumQuarterly];
            [tempRMPMonthly addObject:modalPremiumMonthly];
            
            for (id modal in tempRMPAnnually) {
                NSLog(@"premium %@", modal);
            }
        }
	}
    
	
    // getting paidUpRiders
    results2 = nil;
    results2 = [database executeQuery:@"select RiderCode from eProposal_PaidUp_Riders"];
    paidUpRiders = [NSMutableArray array];
    while ([results2 next]) {
        [paidUpRiders addObject:[results2 stringForColumn:@"RiderCode"]];
    }
	
	results2 = Nil;
	results2 = [database executeQuery:@"select * from SI_Store_Premium where SINo = ? and Type = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], @"B",Nil];
	
    if (![[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"]) {
        [[obj.eAppData objectForKey:@"SecB"] setValue:[NSMutableDictionary dictionary] forKey:@"PREMIUM"];
    }
	while ([results2 next]) {
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"Annually"] forKey:@"Annually"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"SemiAnnually"] forKey:@"SemiAnnually"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"Quarterly"] forKey:@"Quarterly"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"Monthly"] forKey:@"Monthly"];
		NSLog(@"###8977896dafasf :%@", [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"]);
		
		BAnual = [results2 stringForColumn:@"Annually"];
		BSemi = [results2 stringForColumn:@"SemiAnnually"];
		BQuater = [results2 stringForColumn:@"Quarterly"];
		BMonthly = [results2 stringForColumn:@"Monthly"];
		
	}
    
    // need to add if statement to diff with ever series and traditional
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        results2 = nil;
        results2 = [database executeQuery:@"select * from UL_Details where SINo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]];
        while ([results2 next]) {
            [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"ATPrem"] forKey:@"Annually"];
            [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"ATPrem"] forKey:@"SemiAnnually"];
            [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"ATPrem"] forKey:@"Quarterly"];
            [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] setValue:[results2 stringForColumn:@"ATPrem"] forKey:@"Monthly"];
        }
    }
	
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"]) {
        NSLog(@"TRAD");
        tempRMPAnnually = [[NSMutableArray alloc] init];
        tempRMPSemiAnnually = [[NSMutableArray alloc] init];
        tempRMPQuarterly = [[NSMutableArray alloc] init];
        tempRMPMonthly = [[NSMutableArray alloc] init];
		
		tempGST_Annual = [[NSMutableArray alloc] init];
		tempGST_Semi = [[NSMutableArray alloc] init];
		tempGST_Quarter = [[NSMutableArray alloc] init];
		tempGST_Month = [[NSMutableArray alloc] init];
		
        NSString * strComma = [tempRName componentsJoinedByString:@"\", \""];
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM SI_Store_Premium WHERE SINo = '%@' and Type IN (\"%@\") and SemiAnnually IS NOT NULL Order by Type", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], strComma];
        results2 = Nil;
        results2 = [database executeQuery:sql];
        
        NSLog(@"sql: %@", [database lastErrorMessage]);
        //NSLog(@"result: %@", [results2 resultDictionary]);
        while ([results2 next]) {
            NSLog(@"modal");
            NSLog(@"result: %@", [results2 resultDictionary]);
            modalPremiumAnnually = [results2 stringForColumn:@"Annually"];
            modalPremiumSemiAnnually = [results2 stringForColumn:@"SemiAnnually"];
            modalPremiumQuarterly = [results2 stringForColumn:@"Quarterly"];
            modalPremiumMonthly = [results2 stringForColumn:@"Monthly"];
			
			//test for GST
			double GST_Annual = [results2 doubleForColumn:@"GST_Annual"];
			double GST_Semi = [results2 doubleForColumn:@"GST_Semi"];
			double GST_Quarter = [results2 doubleForColumn:@"GST_Quarter"];
			double GST_Month = [results2 doubleForColumn:@"GST_Month"];
			
			NSString *strGST_Annual = [NSString stringWithFormat:@"%.2lf", GST_Annual];
			NSString *strGST_Semi = [NSString stringWithFormat:@"%.2lf", GST_Semi];
			NSString *strGST_Quarter = [NSString stringWithFormat:@"%.2lf", GST_Quarter];
			NSString *strGST_Month = [NSString stringWithFormat:@"%.2lf", GST_Month];
			
			NSLog(@"###GST Value :%f, %f, %f, %f", GST_Annual, GST_Semi, GST_Quarter, GST_Month);
            
            [tempRMPAnnually addObject:modalPremiumAnnually];
            [tempRMPSemiAnnually addObject:modalPremiumSemiAnnually];
            [tempRMPQuarterly addObject:modalPremiumQuarterly];
            [tempRMPMonthly addObject:modalPremiumMonthly];
			
			[tempGST_Annual addObject:strGST_Annual];
			[tempGST_Semi addObject:strGST_Semi];
			[tempGST_Quarter addObject:strGST_Quarter];
			[tempGST_Month addObject:strGST_Month];
            
            for (id modal in tempRMPMonthly) {
                NSLog(@"premium %@", modal);
            }
        }
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        NSLog(@"UV");
    }
    
	results2 = Nil;
	results2 = [database executeQuery:@"select Annually as SA from SI_Store_Premium where Type != ? and Type != ? and Type != ? union select Annually as SA from SI_Store_Premium where Type = ? and FromAge is ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], @"B", @"BOriginal", @"HMM", @"HMM", @"", Nil];
	NSNumber *sum;
	
	while ([results2 next]) {
		sum = [NSNumber numberWithDouble:[results2 doubleForColumn:@"SA"]];
		//NSLog(@"SUM IN: %@", sum);
		
	}
	
    results2 = nil;
    results2 = [database executeQuery:@"select LAOtherIDType from eProposal_LA_Details where POFlag = ? and eProposalNo = ?", @"Y", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
    while ([results2 next]) {
        if (([[textFields trimWhiteSpaces:[results2 objectForColumnName:@"LAOtherIDType"]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[results2 objectForColumnName:@"LAOtherIDType"]] caseInsensitiveCompare:@"CR"] == NSOrderedSame)){
            isCompany = TRUE;
        }
        else {
            isCompany = FALSE;
        }
    }
    
//    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"]) {
//        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLACP"]) {
//            _basicPlanLbl.text = @"HLACP";
//            _termLbl.text = @"25";
//        }
//        else{
//			_basicPlanLbl.text = @"L100";
//			_termLbl.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PolicyTerm"];
//        }
//    }
    //else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"]) {
	_termLbl.text = @"49";
	results2 = nil;
	results2 = [database executeQuery:@"select ReducedYear, Amount from UL_ReducedPaidUp where SINO = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"Amount"] forKey:@"RevisedAmount"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"ReducedYear"] forKey:@"PaidUpTerm"];
	}
	
	// fund
	results2 = nil;
	results2 = [database executeQuery:@"select VU2023, VU2025, VU2028, VU2030, VU2035, VUCash, VURet from UL_Details where SINO = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
	while ([results2 next]) {
		if (![[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"]) {
			[[obj.eAppData objectForKey:@"SecB"] setValue:[NSMutableDictionary dictionary] forKey:@"funds"];
		}
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VU2023"] forKey:@"VU2023"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VU2025"] forKey:@"VU2025"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VU2028"] forKey:@"VU2028"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VU2030"] forKey:@"VU2030"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VU2035"] forKey:@"VU2035"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VUCash"] forKey:@"VUCash"];
		[[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] setValue:[results2 stringForColumn:@"VURet"] forKey:@"VURet"];
	}
	fundsKeys = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] allKeys];
    //}
	
	
	//ENS: Check if have LA2 or Payor
	results = nil;
	results2 = nil;
	
	results = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
    while ([results next]) {
        if ([results intForColumn:@"count"] > 0) {
            la2Available = TRUE;
            [[obj.eAppData objectForKey:@"SecE"] setValue:@"2" forKey:@"count"];
        }
        else {
            la2Available = FALSE;
            [[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
    }
	results2 = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
    while ([results2 next]) {
        if ([results2 intForColumn:@"count"] > 0) {
            PYAvailable = TRUE;
			NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
			if ([PYhasRider isEqualToString:@"Y"])
				[[obj.eAppData objectForKey:@"SecE"] setValue:@"3" forKey:@"count"];
			else
				[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
        else {
            PYAvailable = FALSE;
            [[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
    }
	
	results = nil;
	results = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PO", Nil];
    while ([results next]) {
        if ([results intForColumn:@"count"] > 0) {
            POAvailable = TRUE;
            [[obj.eAppData objectForKey:@"SecE"] setValue:@"4" forKey:@"count"];
        }
        else {
            POAvailable = FALSE;
            [[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
    }
	
	
	
	[results close];
	[results2 close];
	//	[results3 close];
	[database close];
	[_basicPlanRiderTblV reloadData];
    
	//	NSLog(@"###8977896 :%@", [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"Annually"]);
	
	//basic plan & rider
	//	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Annual"]) {
	//		_paymentModeSC.selectedSegmentIndex = 0;
	//		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"Annually"];
	//	}
	//	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"SemiAnnual"]) {
	//		_paymentModeSC.selectedSegmentIndex = 1;
	//		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"SemiAnnually"];
	//	}
	//	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Quarterly"]) {
	//		_paymentModeSC.selectedSegmentIndex = 2;
	//		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"Quarterly"];
	//	}
	//	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Monthly"]) {
	//		_paymentModeSC.selectedSegmentIndex = 3;
	//		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"Monthly"];
	//	}
	
	//	if ([[obj.eAppData objectForKey:@"SecB"] count] != 0) {
	//_basicPlanLbl.text = @"HLA Cash Promise";
	//		[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPlan"];
	//_termLbl.text = @"25";
	//		[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Term"];
	//	NSLog(@"sum assured basic: %@", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SumAssured"]);

	
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
//        _basicPlanLbl.text = @"HLA EverLife Plus";
//        _termLbl.text = @"49";
		
		_btnPremDeposit.enabled = TRUE;
		_btnFuturePrem.enabled = TRUE;
		_btnTopUp.enabled = TRUE;
    }
    
	_sumAssuredLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SumAssured"];
	//		_basicPremLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"];
	_totalPremLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalPremium"];
	_basicUnitAccLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicUnitAcc"];
	_riderUnitAccLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RiderUnitAcc"];
	
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,###.##"];
    _sumAssuredLbl.text = [formatter stringFromNumber:[formatter numberFromString:_sumAssuredLbl.text]];
	
	_basicUnitAccLbl.text = [formatter stringFromNumber:[formatter numberFromString:_basicUnitAccLbl.text]];
    _riderUnitAccLbl.text = [formatter stringFromNumber:[formatter numberFromString:_riderUnitAccLbl.text]];
	//	}
	//	else {
	
    // setting the color of the font to light grey
    
	_basicPlanLbl.textColor = [UIColor lightGrayColor];
	_termLbl.textColor = [UIColor lightGrayColor];
	_sumAssuredLbl.textColor = [UIColor lightGrayColor];
	_basicPremLbl.textColor = [UIColor lightGrayColor];
	_totalPremLbl.textColor = [UIColor lightGrayColor];
	_basicUnitAccLbl.textColor = [UIColor lightGrayColor];
	_riderUnitAccLbl.textColor = [UIColor lightGrayColor];
    
    _basicUnitLbl.textColor = [UIColor lightGrayColor];
    _riderUnitLbl.textColor = [UIColor lightGrayColor];
    _basicUnitCommToLbl.textColor = [UIColor lightGrayColor];
    _riderUnitCommToLbl.textColor =[UIColor lightGrayColor];
    _basicUnitCommFromLbl.textColor = [UIColor lightGrayColor];
    _riderUnitCommFromLbl.textColor = [UIColor lightGrayColor];
    
	//		_basicPlanLbl.text = @"Basic Plan";
	//		_termLbl.text = @"Term";
	//		_sumAssuredLbl.text = @"Sum Assured (RM)";
	//		_basicPremLbl.text = @"Basic Premium (RM)";
	//		_totalPremLbl.text = @"Total Premium (RM)";
	//		_basicUnitAccLbl.text = @"Basic Unit Account (RM)";
	//		_riderUnitAccLbl.text = @"Rider Unit Account (RM)";
	
	//	}
	
	
	
	
	//
	//regular top-up option
    _basicUnitAccLbl.text = @"0.00";
    _riderUnitAccLbl.text = @"0.00";
	_basicUnitLbl.text = @"0.00";
    _riderUnitLbl.text = @"0.00";
    _basicUnitCommToLbl.text = @"-";
    _riderUnitCommToLbl.text = @"-";
    _basicUnitCommFromLbl.text = @"-";
    _riderUnitCommFromLbl.text = @"-";
	//
	//source of payment
	_firstTimePaymentLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"];
	
	//NSLog(@"ENS: deductSC- %ld", (long)_deductSC.selectedSegmentIndex);
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"Yes"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"Y"]) {
		_deductSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"N"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"No"]) {
		_deductSC.selectedSegmentIndex = 1;
	}
    //EPP
    if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Yes"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Y"]) {
		_EPPSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"N"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"No"]) {
		_EPPSC.selectedSegmentIndex = 1;
	}
	
    
	_recurPaymentLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RecurringPayment"];
	//
	//credit card details
    //Added by Andy to save the CreditCard bank code and Card Type -START
    [database open];
	//    NSLog(@"%@",[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"]);
    NSString *selectedCreditCardBank = @"";
    NSString *selectedCreditCardBankCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
    FMResultSet *resultsBankName = [database executeQuery:@"select * from  eProposal_Credit_Card_Bank where CompanyCode = ?",selectedCreditCardBankCode,Nil];
	int a = 0;
    while ([resultsBankName next]) {
		a = a+1;
        selectedCreditCardBank = [resultsBankName stringForColumn:@"CompanyName"];
        NSLog(@"%@", selectedCreditCardBank);
	}
	if (a==0) {
		selectedCreditCardBank = selectedCreditCardBankCode;
	}
    
    NSLog(@"%@",[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"]);
    NSString *selectedCreditCardType = @"";
    NSString *selectedCreditCardTypeCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
    FMResultSet *resultsCardType = [database executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardCode = ?",selectedCreditCardTypeCode,Nil];
	int b = 0;
    while ([resultsCardType next]) {
		b = b + 1;
        selectedCreditCardType = [resultsCardType stringForColumn:@"CreditCardDesc"];
        NSLog(@"%@",selectedCreditCardType);
	}
    
	if (b == 0) {
		selectedCreditCardType = selectedCreditCardTypeCode;
	}
	
    //Added by Andy to save the CreditCard bank code -END
    
	_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"];
	isFTPayment = FALSE;
    [self selectedPersonType:_personTypeLbl.text];
    _bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
    _cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
    
    _bankLbl.text = selectedCreditCardBank;
    _cardTypeLbl.text = selectedCreditCardType;
    
	
	_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
	_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
	_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
	_memberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"];
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"M"]) {
		_memberSexSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"F"]) {
		_memberSexSC.selectedSegmentIndex = 1;
	}
    
	_memberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"];
	_memberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"];
	if (_memberIC.text.length == 12){
		_memberSexSC.enabled = FALSE;
		_btnMemberDOBPO.enabled = FALSE;
		_memberDOBLbl.textColor = [UIColor grayColor];
	}
	
	_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"]];
	if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"];
	
	_memberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"];
    
    if ([_personTypeLbl.text isEqualToString:@"Other Payor"]) {
		
		if (IDTypeCodeSelected.length==0 ) {
			_memberOtherIDTF.enabled=NO;
		}
		
		if ([_memberOtherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_memberOtherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_memberOtherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _memberOtherIDTypeLbl.text == NULL || [_memberOtherIDTypeLbl.text isEqualToString:@""] || [_memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
			//_nricLbl.text = @"";
			_memberIC.enabled = YES;
       	}
		else {
			_memberIC.text = @"";
			_memberIC.enabled = NO;
			
			
		}
    }
	
    NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"];
	if (![contact isEqualToString:@""]) {
		NSArray *ary = [contact componentsSeparatedByString:@" "];
		_memberContactNoTF.text = [ary objectAtIndex:1];
		_memberContactNoPrefixCF.text = [ary objectAtIndex:0];
	}
    
	_memberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"];
	
	
	//#### FT (ADDED BY EMI)
	
	[self EnableCreditCardFTP];
	if ([_firstTimePaymentLbl.text isEqualToString:@"Credit Card"]) {
		_FTpersonTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"];
		isFTPayment = TRUE;
		[self selectedPersonType:_FTpersonTypeLbl.text];
		
		NSString *FTselectedCreditCardBank = @"";
		NSString *FTselectedCreditCardBankCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"];
		FMResultSet *FTresultsBankName = [database executeQuery:@"select * from  eProposal_Credit_Card_Bank where CompanyCode = ?",FTselectedCreditCardBankCode,Nil];
		
		int j = 0;
		while ([FTresultsBankName next]) {
			j = j + 1;
			FTselectedCreditCardBank = [FTresultsBankName stringForColumn:@"CompanyName"];
			NSLog(@"%@", FTselectedCreditCardBank);
		}
		if (j==0) {
			FTselectedCreditCardBank = FTselectedCreditCardBankCode;
		}
		
		NSString *FTselectedCreditCardType = @"";
		NSString *FTselectedCreditCardTypeCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"];
		FMResultSet *FTresultsCardType = [database executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardCode = ?",FTselectedCreditCardTypeCode,Nil];
		int i = 0;
		while ([FTresultsCardType next]) {
			i = i + 1;
			FTselectedCreditCardType = [FTresultsCardType stringForColumn:@"CreditCardDesc"];
		}
		if (i == 0)
			FTselectedCreditCardType = FTselectedCreditCardTypeCode;
		
		_FTbankLbl.text = FTselectedCreditCardBank;
		_FTcardTypeLbl.text = FTselectedCreditCardType;
		
		_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
		_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
		_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
		_FTmemberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberName"];
		
		if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"M"]) {
			_FTmemberSexSC.selectedSegmentIndex = 0;
		}
		else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"F"]) {
			_FTmemberSexSC.selectedSegmentIndex = 1;
		}
		
		_FTmemberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberDOB"];
		_FTmemberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberIC"];
		if (_FTmemberIC.text.length == 12){
			_FTmemberSexSC.enabled = FALSE;
			_FTbtnMemberDOBPO.enabled = FALSE;
			_FTmemberDOBLbl.textColor = [UIColor grayColor];
		}
		
		
		_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"]];
		if (FTIDTypeCodeSelected == NULL)
			FTIDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"];
		
		_FTmemberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherID"];
		
		if ([_FTpersonTypeLbl.text isEqualToString:@"Other Payor"]) {
			
			if (FTIDTypeCodeSelected.length==0 ) {
				_FTmemberOtherIDTF.enabled=NO;
			}
			
			if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _FTmemberOtherIDTypeLbl.text == NULL || [_FTmemberOtherIDTypeLbl.text isEqualToString:@""] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
				_FTmemberIC.enabled = YES;
				
			}
			else {
				_FTmemberIC.text = @"";
				_FTmemberIC.enabled = NO;
				
				
			}
		}
		
		NSString *contact2 = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberContactNo"];
		if (![contact2 isEqualToString:@""]) {
			NSArray *ary2 = [contact2 componentsSeparatedByString:@" "];
			_FTmemberContactNoTF.text = [ary2 objectAtIndex:1];
			_FTmemberContactNoPrefixCF.text = [ary2 objectAtIndex:0];
		}
		_FTmemberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberRelationship"];
	}
	//FT END HERE
	
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SameAsFT"] isEqualToString:@"TRUE"]) {
		_isSameAsFT = TRUE;
		[_btnSameAsFT setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		
		_personTypeLbl.text = _FTpersonTypeLbl.text;
		_bankLbl.text = _FTbankLbl.text;
		_cardTypeLbl.text = _FTcardTypeLbl.text;
		_accNoTF.text = _FTaccNoTF.text;
		//_accNoTF.enabled = NO;
		_expiryDateTF.text = _FTexpiryDateTF.text;
		_expiryDateYearTF.text = _FTexpiryDateYearTF.text;
		
		_memberNameTF.text = _FTmemberNameTF.text;
		_memberSexSC.selectedSegmentIndex = _FTmemberSexSC.selectedSegmentIndex;
		_memberDOBLbl.text = _FTmemberDOBLbl.text ;
		_memberIC.text = _FTmemberIC.text;
		_memberOtherIDTypeLbl.text = _FTmemberOtherIDTypeLbl.text;
		_memberOtherIDTF.text = _FTmemberOtherIDTF.text;
		_memberContactNoTF.text = _FTmemberContactNoTF.text;
		_memberContactNoPrefixCF.text = _FTmemberContactNoPrefixCF.text;
		_memberRelationshipLbl.text = _FTmemberRelationshipLbl.text;
		
		_btnPersonTypePO.enabled = FALSE;
		_btnBankPO.enabled = FALSE;
		_btnCardTypePO.enabled = FALSE;
		_expiryDateTF.enabled = FALSE;
		_expiryDateYearTF.enabled = FALSE;
		
		_accNoTF.enabled = FALSE;
		_expiryDateTF.enabled = FALSE;
		_expiryDateYearTF.enabled = FALSE;
		_memberNameTF.enabled = FALSE;
		_memberSexSC.enabled = FALSE;
		_btnMemberDOBPO.enabled = FALSE;
		_memberIC.enabled = FALSE;
		_btnMemberOtherIDType.enabled = FALSE;
		_memberOtherIDTF.enabled = FALSE;
		_memberContactNoTF.enabled = FALSE;
		_memberContactNoPrefixCF.enabled = FALSE;
		_btnMemberRelationshipPO.enabled = FALSE;
		
		_personTypeLbl.textColor = [UIColor grayColor];
		_bankLbl.textColor = [UIColor grayColor];
		_cardTypeLbl.textColor = [UIColor grayColor];
		_accNoTF.textColor = [UIColor grayColor];
		_expiryDateTF.textColor = [UIColor grayColor];
		_expiryDateYearTF.textColor = [UIColor grayColor];
		
		_memberNameTF.textColor = [UIColor grayColor];
		_memberDOBLbl.textColor = [UIColor grayColor];
		_memberIC.textColor = [UIColor grayColor];
		_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
		_memberOtherIDTF.textColor = [UIColor grayColor];
		_memberContactNoTF.textColor = [UIColor grayColor];
		_memberContactNoPrefixCF.textColor = [UIColor grayColor];
		_memberRelationshipLbl.textColor = [UIColor grayColor];
	}
	else {
		_isSameAsFT = FALSE;
		[_btnSameAsFT setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	//fully / reduced paid up applicable for ever series only
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        
        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpOption"] isEqualToString:@"Y"]) {
            _paidUpOptionSC.selectedSegmentIndex = 0;
        }
        else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpOption"] isEqualToString:@"N"]) {
            _paidUpOptionSC.selectedSegmentIndex = 1;
        }
        
        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpTerm"] length] == 0) {
            _paidUpTermLbl.text = @"Paid Up Term";
            _paidUpTermLbl.textColor = [UIColor lightGrayColor];
        }
        else {
            _paidUpTermLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpTerm"];
        }
        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedSumAssured"] isEqualToString:@"Y"]) {
            _sumAssuredSC.selectedSegmentIndex = 0;
        }
        else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedSumAssured"] isEqualToString:@"N"]) {
            _sumAssuredSC.selectedSegmentIndex = 1;
        }
        
        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpTerm"] length] == 0) {
            _revisedAmountLbl.text = @"Amount";
            _revisedAmountLbl.textColor = [UIColor lightGrayColor];
        }
        else {
            _revisedAmountLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedAmount"];
            _paidUpOptionSC.selectedSegmentIndex = 0;
            _sumAssuredSC.selectedSegmentIndex = 0;
        }
    }
	//
	//for shared case from same direct unit
	_agentCodeTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentCode"];
    NSString *agentContact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentContactNo"];
    NSArray *contactArr = [agentContact componentsSeparatedByString:@" "];
    // For old data
    if ([contactArr count] == 1) {
        _agentContactNoTF.text = [contactArr objectAtIndex:0];
    }
    else {
        _agentContactNoPrefixTF.text = [contactArr objectAtIndex:0];
        _agentContactNoTF.text = [contactArr objectAtIndex:1];
    }
	//_agentContactNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentContactNo"];
	_agentNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentName"];
	//
	//for venture & perfect series only
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BenefitChoices"] isEqualToString:@"LevelFace"]) {
		[_btnLevelFace setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnFacePlus setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BenefitChoices"] isEqualToString:@"FacePlus"]) {
		[_btnLevelFace setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnFacePlus setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"ExcessPremium"] isEqualToString:@"PremiumDeposit"]) {
		[_btnPremDeposit setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnFuturePrem setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnTopUp setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"ExcessPremium"] isEqualToString:@"FuturePremium"]) {
		[_btnPremDeposit setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnFuturePrem setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnTopUp setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"ExcessPremium"] isEqualToString:@"TopUp"]) {
		[_btnPremDeposit setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnFuturePrem setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnTopUp setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	//
	//for perfect series only
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"InvestmentStrategy"] isEqualToString:@"VeryDynamic"]) {
		[_btnVeryDyn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnModDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnBalanced setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"InvestmentStrategy"] isEqualToString:@"ModDynamic"]) {
		[_btnVeryDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnModDyn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnBalanced setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"InvestmentStrategy"] isEqualToString:@"Dynamic"]) {
		[_btnVeryDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnModDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnDyn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnBalanced setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"InvestmentStrategy"] isEqualToString:@"Balanced"]) {
		[_btnVeryDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnModDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnDyn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnBalanced setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	_investmentPeriodLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"InvestmentPeriod"];
	//
	//for ever series only
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
			_btnLIEN.enabled = TRUE;
			_btnLIEN.userInteractionEnabled = YES;
			if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"LIEN"] isEqualToString:@"TRUE"]) {
				[_btnLIEN setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
				
				_lblSubmitSpecial.hidden =NO;
				isLIEN = FALSE;
			}
			else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"LIEN"] isEqualToString:@"FALSE"]) {
				_lblSubmitSpecial.hidden = YES;
				isLIEN = TRUE;
				[_btnLIEN setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			}
    }
	else {
		_btnLIEN.enabled = FALSE;
		_btnLIEN.userInteractionEnabled = FALSE;
	}
    
    // Auto set mode to annual
    [_paymentModeSC setSelectedSegmentIndex:0];
    [_paymentModeSC sendActionsForControlEvents:UIControlEventValueChanged];
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
		_paymentModeSC.enabled = FALSE;    
		if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentModeE"] isEqualToString:@"A"]) {
			_paymentModeSC.selectedSegmentIndex = 0;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentModeE"] isEqualToString:@"S"]) {
			_paymentModeSC.selectedSegmentIndex = 1;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentModeE"] isEqualToString:@"Q"]) {
			_paymentModeSC.selectedSegmentIndex = 2;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentModeE"] isEqualToString:@"M"]) {
			_paymentModeSC.selectedSegmentIndex = 3;
		}
		
        aDesc = [[NSMutableArray alloc] init];
        a2025 = [[NSMutableArray alloc] init];
        a2028 = [[NSMutableArray alloc] init];
        a2030 = [[NSMutableArray alloc] init];
        a2035 = [[NSMutableArray alloc] init];
        aDana = [[NSMutableArray alloc] init];
        aRet = [[NSMutableArray alloc] init];
        aCash = [[NSMutableArray alloc] init];
        [self dasd];
    }
	
	else {
		double totalModalPrem = 0.0;
		double totalGSTModalPrem = 0.0;
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
		[formatter setMaximumFractionDigits:2];
		[formatter setPositiveFormat:@"#,##0.00"];
		
		if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Annual"]) {
			_paymentModeSC.selectedSegmentIndex = 0;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"SemiAnnual"]) {
			_paymentModeSC.selectedSegmentIndex = 1;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Quarterly"]) {
			_paymentModeSC.selectedSegmentIndex = 2;
		}
		else if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"] isEqualToString:@"Monthly"]) {
			_paymentModeSC.selectedSegmentIndex = 3;
		}
		NSString *string;
		if (_paymentModeSC.selectedSegmentIndex == 0) {
			_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Annually"];
			string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Annually"];
			select = 1;
			for (NSString *modal in tempRMPAnnually) {
				totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
			}
			
			for (NSString *modal1 in tempGST_Annual) {
				totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
			}
			
		}
		else if (_paymentModeSC.selectedSegmentIndex == 1) {
			//		NSLog(@"###1");
			_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"];
			string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"];
			select = 2;
			for (NSString *modal in tempRMPSemiAnnually) {
				totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
			}
			
			for (NSString *modal1 in tempGST_Semi) {
				totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
			}
			
		}
		else if (_paymentModeSC.selectedSegmentIndex == 2)
		{
			
			_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Quarterly"];
			string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Quarterly"];
			select = 3;
			for (NSString *modal in tempRMPQuarterly) {
				totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
			}
			
			for (NSString *modal1 in tempGST_Quarter) {
				totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
			}
			
			
		}
		else if (_paymentModeSC.selectedSegmentIndex == 3)
		{
			
			_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Monthly"];
			string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Monthly"];
			select = 4;
			for (NSString *modal in tempRMPMonthly)
			{
				totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
			}
			
			for (NSString *modal1 in tempGST_Month) {
				totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
			}
			
		}
		
		double basicPlanAdd = [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        double basicPrem = [[_basicPremLbl.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        _totalPremLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd];
		//  if (isCompany) {
		
		
		
		_srvTaxLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalGSTModalPrem];
		
		
		//   _srvTaxLbl.text = [NSString stringWithFormat:@"%.2f", (basicPrem + totalModalPrem)*0.06];
	//	_totalPremTaxLbl.text = [NSString stringWithFormat:@"%.2f", (totalGSTModalPrem + totalModalPrem)];
		
		_totalPremTaxLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd + totalGSTModalPrem];
		
		NSString *totalpremTaxUserDefault = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd + totalGSTModalPrem];
		
		NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
		[prefs1 setObject:totalpremTaxUserDefault forKey:@"totalAllValue"];
		
		
		NSString *totalGSTValueXml =[NSString stringWithFormat:@"%.2f", totalGSTModalPrem];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		[prefs setObject:totalGSTValueXml forKey:@"totalGstValue"];
		
		
		//   }
		
        
		_sumAssuredLbl.text = [formatter stringFromNumber:[formatter numberFromString:_sumAssuredLbl.text]];
		
		_basicPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_basicPremLbl.text]];
		_totalPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremLbl.text]];
		_srvTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_srvTaxLbl.text]];
		_totalPremTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremTaxLbl.text]];
		
		_srvTaxLbl.textColor = [UIColor lightGrayColor];
		_totalPremTaxLbl.textColor = [UIColor lightGrayColor];
		
		[self.tableView reloadData];
		
	}
	
    [self selectedRecurPaymentType:_recurPaymentLbl.text];
    
    _agentContactNoPrefixTF.delegate = self;
    _agentContactNoTF.delegate = self;
    _memberContactNoTF.delegate = self;
    _memberContactNoPrefixCF.delegate = self;
	
	_expiryDateTF.keyboardType = UIKeyboardTypeNumberPad;
	_expiryDateYearTF.keyboardType = UIKeyboardTypeNumberPad;
	_accNoTF.keyboardType = UIKeyboardTypeNumberPad;
	_memberContactNoTF.keyboardType = UIKeyboardTypeNumberPad;
	_memberContactNoPrefixCF.keyboardType = UIKeyboardTypeNumberPad;
	_agentContactNoTF.keyboardType = UIKeyboardTypeNumberPad;
	_agentContactNoPrefixTF.keyboardType = UIKeyboardTypeNumberPad;
    
    
    _FTaccNoTF.keyboardType = UIKeyboardTypeNumberPad;
	_FTexpiryDateTF.keyboardType = UIKeyboardTypeNumberPad;
	_FTexpiryDateYearTF.keyboardType = UIKeyboardTypeNumberPad;
	_FTmemberContactNoTF.keyboardType = UIKeyboardTypeNumberPad;
	_FTmemberContactNoPrefixCF.keyboardType = UIKeyboardTypeNumberPad;
    
    _FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
    
    
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    
    NSString *payeeType;
    NSString *newICno;
    NSString *otherIDType;
    NSString *OtherID;
    NSString *Email;
    NSString *ContactNo;
    NSString *ContactNoPrefic;
    
    
    
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    
    
    NSString *selectPO = [NSString stringWithFormat:@"select PTypeCode, LANewICNo, LAOtherIDType, LAOtherID, MobilePhoneNo,MobilePhoneNoPrefix, EmailAddress FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",displayThis];
    
	
    
    _TickMArkValue =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"isDirectCredit"];
    if([_TickMArkValue isEqualToString:@"Y"])
    {
		ChangeTickMAsterMenu = @"Yes";
        ChangeTick =YES;
        
        DCBankNameBtn.enabled=TRUE;
        DCAccountTypeBtn.enabled=TRUE;
        [TckbuttonPolicyBankDetails setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        results = [db executeQuery:selectPO];
        while ([results next])
        {
            payeeType = [results objectForColumnName:@"PTypeCode"];
            newICno = [results objectForColumnName:@"LANewICNo"];
            otherIDType = [self getIDTypeDesc:[results objectForColumnName:@"LAOtherIDType"]];
            OtherID = [results objectForColumnName:@"LAOtherID"];
            Email = [results objectForColumnName:@"EmailAddress"];
            ContactNo = [results objectForColumnName:@"MobilePhoneNo"];
            ContactNoPrefic = [results objectForColumnName:@"MobilePhoneNoPrefix"];
			
        }
		
        
		DCBankName.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCBank"];
        DCAccountType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccountType"];
		DCAccNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccNo"];
		PayeeType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCPayeeType"];
        DCNewIcNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCNewICNo"];
        OtherIDTypeDc.text =[self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherIDType"]];
		OtherIDDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherID"];
        
        if([Email isEqualToString:@""])
        {
            emailDC.textColor =[UIColor blackColor];
            emailDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCEmail"];
            emailDC.enabled =YES;
        }
        else
        {
            emailDC.text =Email;
            emailDC.textColor =[UIColor grayColor];
        }
        
        if([ContactNo isEqualToString:@""])
        {
            mobileNoDC.textColor =[UIColor blackColor];
            mobileNoDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"];
            mobileNoDC.enabled =YES;
        }
        else
        {
            mobileNoDC.text =ContactNo;
            mobileNoDC.textColor =[UIColor grayColor];
        }
        
        if([ContactNoPrefic isEqualToString:@""])
        {
            mobileNoPrefixDC.textColor =[UIColor blackColor];
            mobileNoPrefixDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"];
            mobileNoPrefixDC.enabled =YES;
        }
        else
        {
            mobileNoPrefixDC.text =ContactNoPrefic;
            mobileNoPrefixDC.textColor =[UIColor grayColor];
        }
		
		
        
        
		mobileNoDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"];
        mobileNoPrefixDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"];
        
	}
    else
	{
		ChangeTickMAsterMenu = @"No";
		//ChangeTick =YES;
		DCBankNameBtn.enabled=FALSE;
		DCAccountTypeBtn.enabled=FALSE;
		[TckbuttonPolicyBankDetails setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		DCBankName.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCBank"];
		DCAccountType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccountType"];
		DCAccNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccNo"];
		PayeeType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCPayeeType"];
		DCNewIcNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCNewICNo"];
		OtherIDTypeDc.text =[self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherIDType"]];
		OtherIDDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherID"];
		emailDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCEmail"];
		mobileNoDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"];
		mobileNoPrefixDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"];
		
	}
    
    
	//    @synthesize TckbuttonPolicyBankDetails;
	//    @synthesize DCBankName;
	//    @synthesize DCAccountType;
	//    @synthesize DCAccNo;
	//    @synthesize PayeeType;
	//    @synthesize DCNewIcNo;
	//    @synthesize OtherIDTypeDc;
	//    @synthesize OtherIDDC;
	//    @synthesize emailDC;
	//    @synthesize mobileNoPrefixDC;
	//    @synthesize mobileNoDC,ChangeTick;
	
	
    
	//   NSString *tickDC = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"isDirectCredit"];
	//
	//    if ([tickDC isEqualToString:@"Y"])
	//    {
	//
	//    }
	//    DCBankName.text=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCBank"];
	//    DCAccountType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccountType"];
	//    DCAccNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccNo"];
	//    PayeeType.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCPayeeType"];
	//    DCNewIcNo.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCNewICNo"];
	//    OtherIDTypeDc.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherIDType"];
	//    OtherIDDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherID"];
	//    emailDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCEmail"];
	//    mobileNoDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"];
	//    mobileNoPrefixDC.text =[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"];
	
    
    
    
    
	
	
	
	
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
	
	obj=[DataClass getInstance];
	//	NSString *proposalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProposalStatus"];
	
	//	if ([proposalStatus isEqualToString:@"Confirmed"] || [proposalStatus isEqualToString:@"3"]) {
	//		[self disableAll];
	//	}
    
    
	
	//EMI: DETECT CHANGE:
	[_accNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_expiryDateTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_expiryDateYearTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberNameTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberIC addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberOtherIDTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberContactNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberContactNoPrefixCF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_memberContactNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_agentContactNoPrefixTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_agentContactNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
	
	[_FTaccNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTexpiryDateTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTexpiryDateYearTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberNameTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberIC addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberOtherIDTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberContactNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberContactNoPrefixCF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_FTmemberContactNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
    [DCAccNo addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[emailDC addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[mobileNoDC addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[mobileNoPrefixDC addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
    if ([_cardTypeLbl.text isEqualToString:@""])
    {
        
        _accNoTF.enabled =NO;
    }
    else
    {
        
        _accNoTF.enabled =YES;
        
    }
	
    if ([_personTypeLbl.text isEqualToString:@"Other Payor"]) {
		
		if ([_memberOtherIDTypeLbl.text isEqualToString:@""]||[_memberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _memberOtherIDTypeLbl.text==nil)
		{
			_memberOtherIDTF.enabled =NO;
		}
		else
		{
			_memberOtherIDTF.enabled =YES;
		}
    }
	
	//## TEMP REMARK 06032015 ##
	
	//	UILabel *label1=[[UILabel alloc]init];
	//	label1.frame=CGRectMake(50, 350, 100, 60);
	//	label1.textAlignment = UITextAlignmentLeft;
	//	label1.textColor =[UIColor redColor];
	//	label1.numberOfLines =3;
	//	label1.text =@"Basic/ Rider Plan";
	//	label1.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label1.backgroundColor = [UIColor clearColor];
	//	label1.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label1];
	//
	//	UILabel *label2=[[UILabel alloc]init];
	//	label2.frame=CGRectMake(185, 350, 100, 60);
	//	label2.textAlignment = UITextAlignmentLeft;
	//	label2.textColor =[UIColor redColor];
	//	label2.numberOfLines =3;
	//	label2.text =@"Type";
	//	label2.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label2.backgroundColor = [UIColor clearColor];
	//	label2.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label2];
	//
	//	UILabel *label3=[[UILabel alloc]init];
	//	label3.frame=CGRectMake(240, 350, 100, 60);
	//	label3.textAlignment = UITextAlignmentLeft;
	//	label3.textColor =[UIColor redColor];
	//	label3.numberOfLines =3;
	//	label3.text =@"Term";
	//	label3.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label3.backgroundColor = [UIColor clearColor];
	//	label3.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label3];
	//
	//	UILabel *label4=[[UILabel alloc]init];
	//	label4.frame=CGRectMake(290, 350, 60, 60);
	//	label4.textAlignment = UITextAlignmentLeft;
	//	label4.textColor =[UIColor redColor];
	//	label4.numberOfLines =3;
	//	label4.text =@"Sum Assured";
	//	label4.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label4.backgroundColor = [UIColor clearColor];
	//	label4.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label4];
	//
	//
	//	UILabel *label5=[[UILabel alloc]init];
	//	label5.frame=CGRectMake(370, 340, 150, 60);
	//	label5.textAlignment = UITextAlignmentLeft;
	//	label5.textColor =[UIColor redColor];
	//	label5.numberOfLines =3;
	//	label5.text =@"Basic/Rider Premium    GST Ammount         Net Payable";
	//	label5.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label5.backgroundColor = [UIColor clearColor];
	//	label5.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label5];
	//
	//	UILabel *label6=[[UILabel alloc]init];
	//	label6.frame=CGRectMake(550, 350, 130, 60);
	//	label6.textAlignment = UITextAlignmentLeft;
	//	label6.textColor =[UIColor redColor];
	//	label6.numberOfLines =3;
	//	label6.text =@"Rider RTUO   (Future Coverage)";
	//	label6.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label6.backgroundColor = [UIColor clearColor];
	//	label6.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label6];
	//
	//	UILabel *label7=[[UILabel alloc]init];
	//	label7.frame=CGRectMake(700, 340, 60, 60);
	//	label7.textAlignment = UITextAlignmentLeft;
	//	label7.textColor =[UIColor redColor];
	//	label7.numberOfLines =3;
	//	label7.text =@"Fully/  Reduce   Paid Up";
	//	label7.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	//	label7.backgroundColor = [UIColor clearColor];
	//	label7.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	//	[self.view addSubview:label7];
	
	
	// ## TEMP REMARK ##
	
	UILabel *label1=[[UILabel alloc]init];
	label1.frame=CGRectMake(50, 350, 230, 60);
	label1.textAlignment = UITextAlignmentLeft;
	label1.textColor =[UIColor redColor];
	label1.numberOfLines =3;
	label1.text =@"Basic/ Rider Plan";
	label1.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	label1.backgroundColor = [UIColor clearColor];
	label1.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	[self.view addSubview:label1];
	
	UILabel *label2=[[UILabel alloc]init];
	label2.frame=CGRectMake(295, 350, 80, 60);
	label2.textAlignment = UITextAlignmentLeft;
	label2.textColor =[UIColor redColor];
	label2.numberOfLines =3;
	label2.text =@"Type";
	label2.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	label2.backgroundColor = [UIColor clearColor];
	label2.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	[self.view addSubview:label2];
	
	UILabel *label3=[[UILabel alloc]init];
	label3.frame=CGRectMake(350, 350, 50, 60);
	label3.textAlignment = UITextAlignmentLeft;
	label3.textColor =[UIColor redColor];
	label3.numberOfLines =3;
	label3.text =@"Term";
	label3.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	label3.backgroundColor = [UIColor clearColor];
	label3.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	[self.view addSubview:label3];
	
	UILabel *label4=[[UILabel alloc]init];
	label4.frame=CGRectMake(425, 350, 100, 60);
	label4.textAlignment = UITextAlignmentLeft;
	label4.textColor =[UIColor redColor];
	label4.numberOfLines =3;
	label4.text =@"Sum Assured";
	label4.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	label4.backgroundColor = [UIColor clearColor];
	label4.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	[self.view addSubview:label4];
	
	
	UILabel *label5=[[UILabel alloc]init];
	label5.frame=CGRectMake(565, 340, 150, 60);
	label5.textAlignment = UITextAlignmentLeft;
	label5.textColor =[UIColor redColor];
	label5.numberOfLines =3;
	label5.text =@"Basic/Rider Premium    GST Amount          Net Payable";
	label5.textColor =[UIColor colorWithRed:99.0f/255.0f green:107.0f/255.0f blue:129.0f/255.0f alpha:1.0f];
	label5.backgroundColor = [UIColor clearColor];
	label5.font = [UIFont fontWithName:@"TreBuchet MS" size:15];
	[self.view addSubview:label5];
	
	[self DefaultPayment];

}

-(void) disableAll {
	
	_paymentModeSC.enabled = FALSE;
	_btnFirstPaymentPO.enabled = FALSE;
	_btnRecurPaymentPO.enabled = FALSE;
	
	_btnPersonTypePO.enabled = FALSE;
	_btnBankPO.enabled = FALSE;
	_btnCardTypePO.enabled = FALSE;
	_accNoTF.enabled = FALSE;
	_expiryDateTF.enabled = FALSE;
	_expiryDateYearTF.enabled = FALSE;
	_memberNameTF.enabled = FALSE;
	_memberSexSC.enabled = FALSE;
	_btnMemberDOBPO.enabled = FALSE;
	_memberIC.enabled = FALSE;
	_btnMemberOtherIDType.enabled = FALSE;
	_memberOtherIDTF.enabled = FALSE;
	_memberContactNoTF.enabled = FALSE;
	_memberContactNoPrefixCF.enabled = FALSE;
	_btnMemberRelationshipPO.enabled = FALSE;
	
	_agentContactNoPrefixTF.enabled = FALSE;
    _agentContactNoTF.enabled = FALSE;
    _memberContactNoTF.enabled = FALSE;
    _memberContactNoPrefixCF.enabled = FALSE;
	
	
	//EVERSERIES  (checkbox still unfinished - Emi 1/07/2014)
	_btnLIEN.enabled = FALSE;

}

-(void)DefaultPayment {
	
	//Set default value:
	_firstTimePaymentLbl.text = @"Cash / Cheque";
	_firstTimePaymentLbl.enabled = false;
	_btnFirstPaymentPO.enabled = false;
	
	_recurPaymentLbl.text = @"Cash / Cheque";
	_recurPaymentLbl.enabled = false;
	_btnRecurPaymentPO.enabled = false;
	
}


-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 2) {
        //NSLog(@"ghj### %d", [tempRPersonType count]);
        if (tempRPersonType.count)
			return ([tempRPersonType count]+1);
        else {
            return 1;
        }
    }//
	//	else if (section == 10) {
	//        //if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife Plus"])
	//            //return 7;
	//        //else
	//            return 0;
	//	}
	//changed 14 to 16 (added two table views in story board)
	else if (section == 16) {
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
            return 8;
        }
		return 0;
	}
	else {
		return [super tableView:tableView numberOfRowsInSection:section];
	}
}

- (IBAction)actionForModePayment:(id)sender {
	if (firstTime ==1)
		firstTime = firstTime + 1;
	else
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
	
	double totalModalPrem = 0.0;
	double totalGSTModalPrem = 0.0;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	
	NSString *string; 
	
	if (_paymentModeSC.selectedSegmentIndex == 0) {
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Annually"];
		string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Annually"];
		select = 1;
		for (NSString *modal in tempRMPAnnually) {
			totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
		}
		
		for (NSString *modal1 in tempGST_Annual) {
			totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
		}
		
	}
	else if (_paymentModeSC.selectedSegmentIndex == 1) {
		//		NSLog(@"###1");
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"];
		string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"];
		select = 2;
		for (NSString *modal in tempRMPSemiAnnually) {
			totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
		}
		
		for (NSString *modal1 in tempGST_Semi) {
			totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
		}
		
	}
	else if (_paymentModeSC.selectedSegmentIndex == 2)
	{
		
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Quarterly"];
		string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Quarterly"];
		select = 3;
		for (NSString *modal in tempRMPQuarterly) {
			totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
		}
		
		for (NSString *modal1 in tempGST_Quarter) {
			totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
		}
		
		
	}
	else if (_paymentModeSC.selectedSegmentIndex == 3)
	{
		
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Monthly"];
		string = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Monthly"];
		select = 4;
		for (NSString *modal in tempRMPMonthly)
		{
			totalModalPrem = [[modal stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalModalPrem;
		}
		
		for (NSString *modal1 in tempGST_Month) {
			totalGSTModalPrem = [[modal1 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue] + totalGSTModalPrem;
		}
		
	}
	
	
	
	double basicPlanAdd = [[string stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
	double basicPrem = [[_basicPremLbl.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
	_totalPremLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd];
	//  if (isCompany) {
	
	
	
	_srvTaxLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalGSTModalPrem];
	
	
	NSString *totalGSTValueXml =[NSString stringWithFormat:@"%.2f", totalGSTModalPrem];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:totalGSTValueXml forKey:@"totalGstValue"];
	
	
	

	
	
	//   _srvTaxLbl.text = [NSString stringWithFormat:@"%.2f", (basicPrem + totalModalPrem)*0.06];
	//	_totalPremTaxLbl.text = [NSString stringWithFormat:@"%.2f", (totalGSTModalPrem + totalModalPrem)];
	
	_totalPremTaxLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd + totalGSTModalPrem];
	
	NSString *totalpremTaxUserDefault = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem + basicPlanAdd + totalGSTModalPrem];
	
	NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
	[prefs1 setObject:totalpremTaxUserDefault forKey:@"totalAllValue"];
	
	
	//   }
	
	
	_sumAssuredLbl.text = [formatter stringFromNumber:[formatter numberFromString:_sumAssuredLbl.text]];
	
	_basicPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_basicPremLbl.text]];
	_totalPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremLbl.text]];
	_srvTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_srvTaxLbl.text]];
	_totalPremTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremTaxLbl.text]];
	
	
	

    
	//	_firstTimePaymentLbl.textColor = [UIColor blackColor];
	if ([_firstTimePaymentLbl.text isEqual:@"Credit Card"]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"Hi" forKey:@"tickmark"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		//For Credit Card first time payment, please fill up CCOTP details in the Authorisation Form
		//_alertFirstPaymentLbl.hidden = NO;
		// _EPPLbl.textColor = [UIColor blackColor];
        
        //EPP
		//        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Yes"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Y"]) {
		//            _EPPSC.selectedSegmentIndex = 0;
		//        }
		//        else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"N"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"No"]) {
		//            _EPPSC.selectedSegmentIndex = 1;
		//        }
        
        _EPPSC.enabled = TRUE;
        if ([_totalPremLbl.text intValue] > 10000) {
            _deductSC.enabled = TRUE;
        }
        if (isCompany && [_totalPremTaxLbl.text intValue] > 10000) {
            _deductSC.enabled = TRUE;
        }
	}
	else {
        [[NSUserDefaults standardUserDefaults]setValue:@"Hi" forKey:@"tickmark"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		//_alertFirstPaymentLbl.hidden = YES;
		// _EPPLbl.textColor = [UIColor grayColor];
        _EPPSC.selectedSegmentIndex = -1;
        _EPPSC.enabled = FALSE;
        
        _deductSC.selectedSegmentIndex = -1;
        _deductSC.enabled = FALSE;
        
        
	}
    
    
	
    _basicPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_basicPremLbl.text]];
    _totalPremLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremLbl.text]];
    _srvTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_srvTaxLbl.text]];
    _totalPremTaxLbl.text = [formatter stringFromNumber:[formatter numberFromString:_totalPremTaxLbl.text]];
	
    [self.tableView reloadData];
	
	//[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return 50.0;
    }
    //else if (indexPath.section == 14) {
    //    return 300.0;
    //}
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
	//    [super setEditing:NO animated:NO];
	//    [tableviewB setEditing:NO animated:NO];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
	if (indexPath.section == 2) {
		
		if (indexPath.row == 0)
		{
			
			CGRect frame=CGRectMake(10,0, 230, 65);
			UILabel *label1=[[UILabel alloc]init];
			label1.frame=frame;
			label1.textAlignment = UITextAlignmentLeft;
			label1.tag = 2001;
			label1.backgroundColor = [UIColor clearColor];
			label1.numberOfLines = 3;
			[label1 setFont:[UIFont systemFontOfSize:14]];
			[cell.contentView addSubview:label1];
			
//			if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife Plus"])
//				label1.text = @"HLA EverLife Plus";
//			
//			else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UP"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverGain Plus"])
//				label1.text = @"HLA EverGain Plus";
//			else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"L100"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"Life100"])
//				label1.text = @"Life100";
//			else  if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLAWP"]  || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Wealth Plan"])
//				label1.text = @"HLA Wealth Plan";
//			else
//				label1.text = @"HLA Cash Promise";
			
			eAppsListing *eAppList = [[eAppsListing alloc]init];
			str_plan = [eAppList GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
			
			label1.text = str_plan;
			

			CGRect frame2=CGRectMake(250,0, 80, 50);
			UILabel *label2=[[UILabel alloc]init];
			label2.frame=frame2;
			label2.textAlignment = UITextAlignmentLeft;
			label2.tag = 2002;
			label2.backgroundColor = [UIColor clearColor];
			label2.numberOfLines = 1;
			[label2 setFont:[UIFont systemFontOfSize:14]];
			[cell.contentView addSubview:label2];
			
			// Term
			CGRect frame3=CGRectMake(300 ,0, 50, 50);
			UILabel *label3=[[UILabel alloc]init];
			label3.frame=frame3;
			//	NSLog(@"label 3: %@", label3.text);
			label3.textAlignment = UITextAlignmentCenter;
			label3.tag = 2003;
			label3.backgroundColor = [UIColor clearColor];
			[label3 setFont:[UIFont systemFontOfSize:14]];
			[cell.contentView addSubview:label3];
			
			label3.text = BPolicyTerm;
			
			// Sum Assured
			CGRect frame5=CGRectMake(380 ,0, 100, 50);
			UILabel *label5=[[UILabel alloc]init];
			label5.frame=frame5;
			label5.textAlignment = UITextAlignmentLeft;
			label5.tag = 2005;
			label5.backgroundColor = [UIColor clearColor];
			[label5 setFont:[UIFont systemFontOfSize:14]];
			[cell.contentView addSubview:label5];
			
			NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
			[fmt setMaximumFractionDigits:2];
			[fmt setPositiveFormat:@"#,##0.00"];
			BasicSA = [fmt stringFromNumber:[fmt numberFromString:BasicSA]];
			
			label5.text = BasicSA;
			
			// Basic/Rider Premium, GST amount, Net payable
			CGRect frame6=CGRectMake(520,0, 240, 85);
			UILabel *label6=[[UILabel alloc]init];
			label6.frame=frame6;
			label6.textAlignment = UITextAlignmentLeft;
			label6.tag = 2006;
			label6.numberOfLines = 3;
			label6.backgroundColor = [UIColor clearColor];
			[label6 setFont:[UIFont systemFontOfSize:14]];
			[cell.contentView addSubview:label6];
			
			label6.text = @"Premium";
			
			if (select == 1) {
				label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: 0.00 \nNet Payable: %@", BAnual, BAnual];
			}
			else if (select == 2) {
				label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: 0.00 \nNet Payable: %@", BSemi, BSemi];
				
			}
			else if (select == 3) {
				label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: 0.00 \nNet Payable: %@", BQuater, BQuater];
			}
			else if (select == 4) {

				label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: 0.00 \nNet Payable: %@", BMonthly, BMonthly];
			}
			
			
			return cell;
			
		}
		
		else if (indexPath.row != 0)
		{
			
			
			
			//		cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell" forIndexPath:indexPath];
			if ([tempRPersonType count] > 0) {
				
				
				[[cell.contentView viewWithTag:2001] removeFromSuperview ];
				[[cell.contentView viewWithTag:2002] removeFromSuperview ];
				[[cell.contentView viewWithTag:2003] removeFromSuperview ];
				[[cell.contentView viewWithTag:2004] removeFromSuperview ];
				[[cell.contentView viewWithTag:2005] removeFromSuperview ];
				[[cell.contentView viewWithTag:2006] removeFromSuperview ];
				
				ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
				
				
				// ## TEMP REMARK 06032015 ##
				
				//        // Basic/Rider Plan
				//		CGRect frame=CGRectMake(10,0, 120, 65);
				//		UILabel *label1=[[UILabel alloc]init];
				//		label1.frame=frame;
				//		label1.textAlignment = UITextAlignmentLeft;
				//		label1.tag = 2001;
				//		label1.backgroundColor = [UIColor clearColor];
				//        label1.numberOfLines = 3;
				//        [label1 setFont:[UIFont systemFontOfSize:14]];
				//		[cell.contentView addSubview:label1];
				//
				//        // Type
				//		CGRect frame2=CGRectMake(140,0, 50, 50);
				//		UILabel *label2=[[UILabel alloc]init];
				//		label2.frame=frame2;
				//		label2.textAlignment = UITextAlignmentLeft;
				//		label2.tag = 2002;
				//		label2.backgroundColor = [UIColor clearColor];
				//        label2.numberOfLines = 1;
				//        [label2 setFont:[UIFont systemFontOfSize:14]];
				//		[cell.contentView addSubview:label2];
				//
				//        // Term
				//		CGRect frame3=CGRectMake(200 ,0, 30, 50);
				//		UILabel *label3=[[UILabel alloc]init];
				//		label3.frame=frame3;
				//		//	NSLog(@"label 3: %@", label3.text);
				//		label3.textAlignment = UITextAlignmentCenter;
				//		label3.tag = 2003;
				//		label3.backgroundColor = [UIColor clearColor];
				//		[label3 setFont:[UIFont systemFontOfSize:14]];
				//		[cell.contentView addSubview:label3];
				//
				//        // Sum Assured
				//		CGRect frame5=CGRectMake(245 ,0, 100, 50);
				//		UILabel *label5=[[UILabel alloc]init];
				//		label5.frame=frame5;
				//		label5.textAlignment = UITextAlignmentLeft;
				//		label5.tag = 2005;
				//		label5.backgroundColor = [UIColor clearColor];
				//		[label5 setFont:[UIFont systemFontOfSize:14]];
				//		[cell.contentView addSubview:label5];
				//
				//        // Basic/Rider Premium, GST amount, Net payable
				//		CGRect frame6=CGRectMake(330,0, 200, 85);
				//		UILabel *label6=[[UILabel alloc]init];
				//		label6.frame=frame6;
				//		label6.textAlignment = UITextAlignmentLeft;
				//		label6.tag = 2006;
				//		label6.numberOfLines = 3;
				//		label6.backgroundColor = [UIColor clearColor];
				//		[label6 setFont:[UIFont systemFontOfSize:14]];
				//		[cell.contentView addSubview:label6];
				//
				//			// Rider RTUO, Future Coverage
				//			CGRect frame7=CGRectMake(500,0, 150, 85);
				//			UILabel *label7=[[UILabel alloc]init];
				//			label7.frame=frame7;
				//			label7.textAlignment = UITextAlignmentLeft;
				//			label7.tag = 2006;
				//			label7.numberOfLines = 3;
				//			label7.backgroundColor = [UIColor clearColor];
				//			[label7 setFont:[UIFont systemFontOfSize:14]];
				//			[cell.contentView addSubview:label7];
				//
				//            //Edit Button
				//			CGRect frame8=CGRectMake(660, 25, 50, 30);
				//            UIButton *btn7 = [[UIButton alloc] init];
				//			btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
				//            btn7.frame = frame8;
				//            btn7.tag = 2007;
				//            [btn7 setTitle:@"Edit" forState:UIControlStateNormal];
				//            [btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
				//            [btn7 addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
				//            btn7.enabled = TRUE;
				//            [cell.contentView addSubview:btn7];
				
				
				// ## TEMP REMARK END ##
				
				// Basic/Rider Plan
				CGRect frame=CGRectMake(10,0, 230, 65);
				UILabel *label1=[[UILabel alloc]init];
				label1.frame=frame;
				label1.textAlignment = UITextAlignmentLeft;
				label1.tag = 2001;
				label1.backgroundColor = [UIColor clearColor];
				label1.numberOfLines = 3;
				[label1 setFont:[UIFont systemFontOfSize:14]];
				[cell.contentView addSubview:label1];
				
				// Type
				CGRect frame2=CGRectMake(250,0, 80, 50);
				UILabel *label2=[[UILabel alloc]init];
				label2.frame=frame2;
				label2.textAlignment = UITextAlignmentLeft;
				label2.tag = 2002;
				label2.backgroundColor = [UIColor clearColor];
				label2.numberOfLines = 1;
				[label2 setFont:[UIFont systemFontOfSize:14]];
				[cell.contentView addSubview:label2];
				
				// Term
				CGRect frame3=CGRectMake(300 ,0, 50, 50);
				UILabel *label3=[[UILabel alloc]init];
				label3.frame=frame3;
				//	NSLog(@"label 3: %@", label3.text);
				label3.textAlignment = UITextAlignmentCenter;
				label3.tag = 2003;
				label3.backgroundColor = [UIColor clearColor];
				[label3 setFont:[UIFont systemFontOfSize:14]];
				[cell.contentView addSubview:label3];
				
				// Sum Assured
				CGRect frame5=CGRectMake(380 ,0, 100, 50);
				UILabel *label5=[[UILabel alloc]init];
				label5.frame=frame5;
				label5.textAlignment = UITextAlignmentLeft;
				label5.tag = 2005;
				label5.backgroundColor = [UIColor clearColor];
				[label5 setFont:[UIFont systemFontOfSize:14]];
				[cell.contentView addSubview:label5];
				
				// Basic/Rider Premium, GST amount, Net payable
				CGRect frame6=CGRectMake(520,0, 240, 85);
				UILabel *label6=[[UILabel alloc]init];
				label6.frame=frame6;
				label6.textAlignment = UITextAlignmentLeft;
				label6.tag = 2006;
				label6.numberOfLines = 3;
				label6.backgroundColor = [UIColor clearColor];
				[label6 setFont:[UIFont systemFontOfSize:14]];
				[cell.contentView addSubview:label6];
				
				
				label1.text =@"";
				label2.text =@"";
				label3.text =@"";
				label5.text =@"";
				//			label6.text = @"test";
				label6.text = @"";
				//			label7.text =@"";
				
				
				
				label1.text = @"Comprehensive Personal Accident";
				//Original Remark start ##
				label1.text= [tempRDesc objectAtIndex:indexPath.row-1];
				if ([label1.text isEqualToString:@"Wealth Booster Rider (30 year term)"])
				{
					label1.text = @"Wealth Booster Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth Booster-d10 Rider (30 year term)"])
				{
					label1.text = @"Wealth Booster-d10 Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth Booster-i6 Rider (30 year term)"])
				{
					label1.text = @"Wealth Booster-i6 Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth Booster Rider (50 year term)"])
				{
					label1.text = @"Wealth Booster Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth Protector Rider (30 year term)"])
				{
					label1.text = @"Wealth Protector Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth Protector Rider (50 year term)"])
				{
					label1.text = @"Wealth Protector Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth TPD Protector Rider (30 year term)"])
				{
					label1.text = @"Wealth TPD Protector Rider";
				}
				
				else if ([label1.text isEqualToString:@"Wealth TPD Protector Rider (50 year term)"])
				{
					label1.text = @"Wealth TPD Protector Rider";
				}
				
				
				label2.text= [tempRPersonType objectAtIndex:indexPath.row-1];
				if ([label2.text isEqualToString:@"LA1"]) {
					label2.text = @"1st LA";
				}
				else if ([label2.text isEqualToString:@"LA2"]) {
					label2.text = @"2nd LA";
				}
				else if ([label2.text isEqualToString:@"PY1"]) {
					label2.text = @"PY";
				}
				
				label3.text= [tempRTerm objectAtIndex:indexPath.row-1];
				//			label5.text = @"1500.00";
				//			label6.text = @"test";
				//			label6.text = [NSString stringWithFormat:@"Premium: 1500.00 \nGST: 150.00 \nNet Payable: 1650.00"];
				//			label7.text = [NSString stringWithFormat:@"Commencing From: 1 \nCommencing To: 2 \nAmount: 25000.00"];
				
				//
				//
				//
				//
				//
				//
				//
				//
				//
				
				//		label5.text= [tempRSumAssured objectAtIndex:indexPath.row];
				label6.text = @"Modal";
				////			label6.text = @"";
				if (select == 1) {
					label5.text = [tempRSAAnnualy objectAtIndex:indexPath.row-1];
					
					
					NSString *string = [tempRMPAnnually objectAtIndex:indexPath.row-1];
					double valueRMPAnnual = [string doubleValue];
					NSString *stringGST = [tempGST_Annual objectAtIndex:indexPath.row-1];
					double valeuGSTAnnual = [stringGST doubleValue];
					double netPay = valueRMPAnnual + valeuGSTAnnual;
					NSString *GST_Annual_Net= [NSString stringWithFormat:@"%.2lf", netPay];
					
					
					label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: %@ \nNet Payable: %@",[tempRMPAnnually objectAtIndex:indexPath.row-1], [tempGST_Annual objectAtIndex:indexPath.row-1],GST_Annual_Net];
				}
				else if (select == 2) {
					label5.text = [tempRSASemi objectAtIndex:indexPath.row-1];
					//   label6.text = [tempRMPSemiAnnually objectAtIndex:indexPath.row];
					
					NSString *string = [tempRMPSemiAnnually objectAtIndex:indexPath.row-1];
					double valueRMPAnnual = [string doubleValue];
					NSString *stringGST = [tempGST_Semi objectAtIndex:indexPath.row-1];
					double valeuGSTAnnual = [stringGST doubleValue];
					double netPay = valueRMPAnnual + valeuGSTAnnual;
					NSString *GST_Annual_Net= [NSString stringWithFormat:@"%.2lf", netPay];
					
					label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: %@ \nNet Payable: %@",[tempRMPSemiAnnually objectAtIndex:indexPath.row-1], [tempGST_Semi objectAtIndex:indexPath.row-1],GST_Annual_Net];
					
				}
				else if (select == 3) {
					label5.text = [tempRSAQuarterly objectAtIndex:indexPath.row-1];
					//   label6.text = [tempRMPQuarterly objectAtIndex:indexPath.row];
					
					NSString *string = [tempRMPQuarterly objectAtIndex:indexPath.row-1];
					double valueRMPAnnual = [string doubleValue];
					NSString *stringGST = [tempGST_Quarter objectAtIndex:indexPath.row-1];
					double valeuGSTAnnual = [stringGST doubleValue];
					double netPay = valueRMPAnnual + valeuGSTAnnual;
					NSString *GST_Annual_Net= [NSString stringWithFormat:@"%.2lf", netPay];
					
					label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: %@ \nNet Payable: %@",[tempRMPQuarterly objectAtIndex:indexPath.row-1], [tempGST_Quarter objectAtIndex:indexPath.row-1],GST_Annual_Net];
				}
				else if (select == 4) {
					label5.text = [tempRSAMonthly objectAtIndex:indexPath.row-1];
					//    label6.text = [tempRMPMonthly objectAtIndex:indexPath.row];
					
					NSString *string = [tempRMPMonthly objectAtIndex:indexPath.row-1];
					double valueRMPAnnual = [string doubleValue];
					NSString *stringGST = [tempGST_Month objectAtIndex:indexPath.row-1];
					double valeuGSTAnnual = [stringGST doubleValue];
					double netPay = valueRMPAnnual + valeuGSTAnnual;
					NSString *GST_Annual_Net= [NSString stringWithFormat:@"%.2lf", netPay];
					
					label6.text = [NSString stringWithFormat:@"Premium: %@ \nGST: %@ \nNet Payable: %@",[tempRMPMonthly objectAtIndex:indexPath.row-1], [tempGST_Month objectAtIndex:indexPath.row-1],GST_Annual_Net];
				}
				//
				//            if ([paidUpRiders containsObject:[tempRName objectAtIndex:indexPath.row]]) {
				////                btn7.enabled = TRUE;
				//                /*if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] objectForKey:label2.text]) {
				//                    btn7.titleLabel.numberOfLines = 1;
				//                    btn7.titleLabel.adjustsFontSizeToFitWidth = YES;
				//                    btn7.titleLabel.lineBreakMode = NSLineBreakByClipping;
				//
				//                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
				//                    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
				//                    [formatter setMaximumFractionDigits:2];
				//                    [formatter setPositiveFormat:@"#,##0.00"];
				//
				//                    NSString *value = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] objectForKey:label2.text];
				//                    [btn7 setTitle:[formatter stringFromNumber:[formatter numberFromString:value]] forState:UIControlStateNormal];
				//                }*/
				//            }
				//			else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Mode"] isEqualToString:@"2"]) {
				//				label6.text = [tempRMPSemiAnnually objectAtIndex:indexPath.row];
				//			}
				//			else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Mode"] isEqualToString:@"3"]) {
				//				label6.text = [tempRMPQuarterly objectAtIndex:indexPath.row];
				//			}
				//			else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Mode"] isEqualToString:@"4"]) {
				//				label6.text = [tempRMPMonthly objectAtIndex:indexPath.row];
				//			}
				
				
				//	    label6.text= [_Status objectAtIndex:indexPath.row];
				
				if (indexPath.row % 2 == 0) {
					cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				}
				else {
					cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				}
				
				return cell;
				//		}
				
				
			}
			else
			{
				cell.textLabel.text= @"";
				cell.userInteractionEnabled=NO;
				return cell;
			}
		}
	}
	//
	//	 else if (indexPath.section == 10) {
	//		[[cell.contentView viewWithTag:2001] removeFromSuperview ];
	//		[[cell.contentView viewWithTag:2002] removeFromSuperview ];
	//		[[cell.contentView viewWithTag:2003] removeFromSuperview ];
	//		[[cell.contentView viewWithTag:2004] removeFromSuperview ];
	//		[[cell.contentView viewWithTag:2005] removeFromSuperview ];
	//
	//		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	//
	//
	//		CGRect frame=CGRectMake(10,0, 50, 50);
	//		UILabel *label1=[[UILabel alloc]init];
	//		label1.frame=frame;
	//		label1.textAlignment = UITextAlignmentLeft;
	//		label1.tag = 2001;
	//		label1.backgroundColor = [UIColor clearColor];
	//		label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	//		[cell.contentView addSubview:label1];
	//
	//		CGRect frame2=CGRectMake(60,0, 300, 50);
	//		UILabel *label2=[[UILabel alloc]init];
	//		label2.frame=frame2;
	//		label2.textAlignment = UITextAlignmentLeft;
	//		label2.tag = 2002;
	//		label2.backgroundColor = [UIColor clearColor];
	//		label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	//		[cell.contentView addSubview:label2];
	//
	//		CGRect frame3=CGRectMake(320,0, 190, 50);
	//		UILabel *label3=[[UILabel alloc]init];
	//		label3.frame=frame3;
	//		//	NSLog(@"label 3: %@", label3.text);
	//		label3.textAlignment = UITextAlignmentLeft;
	//		label3.tag = 2003;
	//		label3.backgroundColor = [UIColor clearColor];
	//		label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	//		[cell.contentView addSubview:label3];
	//
	//		CGRect frame5=CGRectMake(660,0, 180, 50);
	//		UILabel *label5=[[UILabel alloc]init];
	//		label5.frame=frame5;
	//		label5.textAlignment = UITextAlignmentLeft;
	//		label5.tag = 2005;
	//		label5.backgroundColor = [UIColor clearColor];
	//		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	//		[cell.contentView addSubview:label5];
	//
	//		CGRect frame6=CGRectMake(850,0, 100, 50);
	//		UILabel *label6=[[UILabel alloc]init];
	//		label6.frame=frame6;
	//		label6.textAlignment = UITextAlignmentCenter;
	//		label6.tag = 2006;
	//		label6.backgroundColor = [UIColor clearColor];
	//		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	//		[cell.contentView addSubview:label6];
	//
	//        label1.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
	//        label2.text= [fundsKeys objectAtIndex:indexPath.row];
	//        label3.text= [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"funds"] objectForKey:[fundsKeys objectAtIndex:indexPath.row]];
	//		//		label5.text=[_LastUpdated objectAtIndex:indexPath.row];
	//		//	    label6.text= [_Status objectAtIndex:indexPath.row];
	//
	//		if (indexPath.row % 2 == 0) {
	//			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
	//		}
	//		else {
	//			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
	//		}
	//
	//		return cell;
	//	}
    //changed 14 to 16 (added two table views in story board)
	
	
	//remark ORI END HERE
    
	else if (indexPath.section == 16) {
		[[cell.contentView viewWithTag:2001] removeFromSuperview ];
		[[cell.contentView viewWithTag:2002] removeFromSuperview ];
		[[cell.contentView viewWithTag:2003] removeFromSuperview ];
		[[cell.contentView viewWithTag:2004] removeFromSuperview ];
		[[cell.contentView viewWithTag:2005] removeFromSuperview ];
		
		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
		
		
		CGRect frame=CGRectMake(10,0, 250, 42);
		UILabel *label1=[[UILabel alloc]init];
		label1.frame=frame;
		label1.textAlignment = UITextAlignmentLeft;
		label1.tag = 2001;
		label1.backgroundColor = [UIColor clearColor];
		label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label1];
		
		CGRect frame2=CGRectMake(360,0, 100, 42);
		UILabel *label2=[[UILabel alloc]init];
		label2.frame=frame2;
		label2.textAlignment = UITextAlignmentLeft;
		label2.tag = 2002;
		label2.backgroundColor = [UIColor clearColor];
		label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label2];
		
		CGRect frame3=CGRectMake(570,0, 100, 42);
		UILabel *label3=[[UILabel alloc]init];
		label3.frame=frame3;
		label3.textAlignment = UITextAlignmentLeft;
		label3.tag = 2003;
		label3.backgroundColor = [UIColor clearColor];
		label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label3];
		
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        NSArray *fundNames = [[NSArray alloc] initWithObjects:@"HLA EverGreen 2025 Fund (%)", @"HLA EverGreen 2028 Fund (%)", @"HLA EverGreen 2030 Fund (%)", @"HLA EverGreen 2035 Fund (%)", @"HLA Dana Suria (%)", @"HLA Secure Fund (%)", @"HLA Cash Fund (%)", nil];
        NSArray *funds = [[NSArray alloc] initWithObjects:a2025, a2028, a2030, a2035, aDana, aRet, aCash, nil];
        [formatter setPositiveFormat:@"#,##0.00"];
        if (indexPath.row == 0) {
            
            CGRect frame2=CGRectMake(280,0, 200, 42);
            label2=[[UILabel alloc]init];
            label2.frame=frame2;
            label2.textAlignment = UITextAlignmentCenter;
            label2.tag = 2002;
            label2.backgroundColor = [UIColor clearColor];
            label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
            label2.numberOfLines = 2;
            [cell.contentView addSubview:label2];
            
            CGRect frame3=CGRectMake(490,0, 200, 42);
            label3=[[UILabel alloc]init];
            label3.frame=frame3;
            label3.textAlignment = UITextAlignmentCenter;
            label3.tag = 2003;
            label3.backgroundColor = [UIColor clearColor];
            label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
            label3.numberOfLines = 2;
            [cell.contentView addSubview:label3];
            
            label2.text = [aDesc objectAtIndex:0];
            label3.text = [aDesc objectAtIndex:1];
        }
        else {
            label1.text = [fundNames objectAtIndex:indexPath.row-1];
            label2.text = [[funds objectAtIndex:indexPath.row-1] objectAtIndex:0];
            label3.text = [[funds objectAtIndex:indexPath.row-1] objectAtIndex:1];
            label2.text = [formatter stringFromNumber:[formatter numberFromString:label2.text]];
            label3.text = [formatter stringFromNumber:[formatter numberFromString:label3.text]];
        }
        
		if (indexPath.row % 2 == 0) {
			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		}
		else {
			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		}
		
		return cell;
	}
	else {
        
        
        
		return [super tableView:tableView cellForRowAtIndexPath:indexPath];
	}
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //To Check if this is company case
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    while ([results_check_comcase next]) {
        //NSLog(@"Company case, CA and CFF will not be generated!");
        comcase = @"Yes";
        
        
    }
    
	//    if ([comcase isEqualToString:@"Yes"]) {
	////
	////
	if (indexPath.section==9 ) {
		UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
		
		updateCell.userInteractionEnabled=NO;
		// part10lbl.hidden=NO;
		
		updateCell.alpha=0.6;
		// updateCell.backgroundColor=[UIColor greenColor];
		
	}
	////
	//   }
	
    
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]){
        
		
        if (indexPath.section==2 || indexPath.section==3 || indexPath.section==4 || indexPath.section==10 || (indexPath.section==12 && (indexPath.row==0|| indexPath.row==1) ) || indexPath.section==15) {
			
			UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
			updateCell.userInteractionEnabled=NO;
			// updateCell.backgroundColor=[UIColor redColor];
			
			updateCell.alpha=0.6;
        }
        
    }
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"]) {
        
        if (indexPath.section==2 || indexPath.section==3 || indexPath.section==4 || indexPath.section==10 || indexPath.section==12 || indexPath.section==14) {
            
            UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
            updateCell.userInteractionEnabled=NO;
            // updateCell.backgroundColor=[UIColor redColor];
            
            updateCell.alpha=0.6;
        }
    }
    
    
}
-(IBAction)myAction:(UIButton *)sender {
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fully/Reduce Paid Up:" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	 [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
	 [alert textFieldAtIndex:0].delegate = self;
	 [alert textFieldAtIndex:0].tag = 1001;
	 alert.tag = indexPath.row;
	 [alert show];
	 alert = nil;*/
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:3]];
    UITextField *textField = (UITextField *)[cell viewWithTag:2002];
    NSString *riderName = textField.text;
    
    UIStoryboard *popover = [UIStoryboard storyboardWithName:@"FullyReducePaidUpPopover" bundle:nil];
    FullyReducePaidUpPopover *vc = [popover instantiateViewControllerWithIdentifier:@"FullyReducePaidUpPopover"];
    vc.riderCode = riderName;
    
    UINavigationController *nc = [[UINavigationController alloc] init];
    nc.viewControllers=[NSArray arrayWithObject:vc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:nc animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        
        
        
        NSString *text = [alertView textFieldAtIndex:0].text;
        NSString *riderName;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:alertView.tag inSection:3]];
        UITextField *textField = (UITextField *)[cell viewWithTag:2002];
		//        UIButton *btn7 = (UIButton *)[cell viewWithTag:2007];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setPositiveFormat:@"#,##0.00"];
		//        btn7.titleLabel.numberOfLines = 1;
		//        btn7.titleLabel.adjustsFontSizeToFitWidth = YES;
		//        btn7.titleLabel.lineBreakMode = NSLineBreakByClipping;
		//        [btn7 setTitle:[formatter stringFromNumber:[formatter numberFromString:text]] forState:UIControlStateNormal];
        riderName = textField.text;
        
        if (![[obj.eAppData  objectForKey:@"SecB"] objectForKey:@"Riders"]) {
            [[obj.eAppData objectForKey:@"SecB"] setValue:[NSMutableDictionary dictionary] forKey:@"Riders"];
        }
        [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] setValue:text forKey:riderName];
    }
    
    if (alertView.tag==1111 )
    {
        
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


#pragma mark - action

- (void)btnDone:(id)sender
{
    
    
}

- (IBAction)actionForFirstPaymentPO:(id)sender {
	if (_FirstPaymentVC == nil) {
        
        self.FirstPaymentVC = [[FirstPaymentPopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _FirstPaymentVC.delegate = self;
        self.FirstPaymentPopover = [[UIPopoverController alloc] initWithContentViewController:_FirstPaymentVC];
    }
    
    [self.FirstPaymentPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


-(void)selectedFirstPaymentType:(NSString *)selectedFirstPaymentType {
	
	_firstTimePaymentLbl.text = selectedFirstPaymentType;
	_firstTimePaymentLbl.textColor = [UIColor blackColor];
	if ([_firstTimePaymentLbl.text isEqual:@"Credit Card"]) {
        _FTccsi = TRUE;
        [[NSUserDefaults standardUserDefaults]setValue:@"Hi" forKey:@"tickmark"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		//For Credit Card first time payment, please fill up CCOTP details in the Authorisation Form
		//_alertFirstPaymentLbl.hidden = NO;
		
		
        //EPP
		//        if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Yes"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Y"]) {
		//            _EPPSC.selectedSegmentIndex = 0;
		//        }
		//        else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"N"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"No"]) {
		//            _EPPSC.selectedSegmentIndex = 1;
		//        }
        
        _EPPSC.enabled = TRUE;
		
        
		
	}
	else {
		_FTccsi = FALSE;
		
		if (_isSameAsFT)
			[self ActionForSameAsFT:nil];
		
        [[NSUserDefaults standardUserDefaults]setValue:@"Hi" forKey:@"tickmark"];
        [[NSUserDefaults standardUserDefaults] synchronize];
		//_alertFirstPaymentLbl.hidden = YES;
        //_EPPLbl.textColor=[UIColor grayColor];
		_EPPSC.selectedSegmentIndex = -1;
		_EPPSC.enabled = FALSE;
        _deductSC.selectedSegmentIndex = -1;
        _deductSC.enabled = FALSE;
		
		//CLEAR CREDIT CARD INFO
		_FTpersonTypeLbl.text = @"";
		_FTbankLbl.text = @"";
		_FTcardTypeLbl.text = @"";
		_FTaccNoTF.text = @"";
        _FTaccNoTF.enabled = NO;
		_FTexpiryDateTF.text = @"";
		_FTexpiryDateYearTF.text = @"";
		
		_FTmemberNameTF.text = @"";
		_FTmemberSexSC.selectedSegmentIndex = -1;
		_FTmemberDOBLbl.text = @"";
		_FTmemberIC.text = @"";
		_FTmemberOtherIDTypeLbl.text = @"";
		_FTmemberOtherIDTF.text = @"";
		_FTmemberContactNoTF.text = @"";
		_FTmemberContactNoPrefixCF.text = @"";
		_FTmemberRelationshipLbl.text = @"";
		
	}
	
	
	
	NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
	[myNumFormatter setLocale:[NSLocale currentLocale]];
	[myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *tempNum = [myNumFormatter numberFromString:_totalPremLbl.text];
	
//	NSLog(@"ENS: total premium '%@' gives NSNumber '%@' with decimalValue '%f'" ,_totalPremLbl.text, tempNum, [tempNum doubleValue]);
	
	if ([tempNum doubleValue] > 10000 && [_firstTimePaymentLbl.text isEqual:@"Credit Card"]) {
		_deductSC.enabled = TRUE;
	}
	else {
		_deductSC.enabled = FALSE;
	}
	
	[self EnableCreditCardFTP];
	
    [self.FirstPaymentPopover dismissPopoverAnimated:YES];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
}

- (IBAction)actionForRecurPaymentPO:(id)sender {
	if (_RecurPaymentVC == nil) {
		
		self.RecurPaymentVC = [[RecurPaymentPopoverVC alloc] initWithStyle:UITableViewStylePlain];
		_RecurPaymentVC.delegate = self;
		self.RecurPaymentPopover = [[UIPopoverController alloc] initWithContentViewController:_RecurPaymentVC];
	}
    
    [self.RecurPaymentPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedRecurPaymentType:(NSString *)selectedRecurPaymentType {
	
	if (firstTime2 ==1)
		firstTime2 = firstTime2 + 1;
	else
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
	_recurPaymentLbl.text = selectedRecurPaymentType;
	_recurPaymentLbl.textColor = [UIColor blackColor];
	if ([_recurPaymentLbl.text isEqual:@"Credit Card Standing Instruction"]) {
		_btnPersonTypePO.enabled = YES;
		_btnBankPO.enabled = YES;
		_btnCardTypePO.enabled = YES;
		//_accNoTF.enabled = YES;
		_expiryDateTF.enabled = YES;
		_expiryDateYearTF.enabled = YES;
		//_memberNameTF.enabled = YES;
		//_memberSexSC.enabled = YES;
		
		_ccsi = TRUE;
        if ([_firstTimePaymentLbl.text isEqual:@"Credit Card"] && [self ShoudEnableSameAsCdt]) {
            _btnSameAsFT.enabled = TRUE;
        }else
        {
            _btnSameAsFT.enabled = FALSE;
        }
	}
	else {
		_btnPersonTypePO.enabled = NO;
		_btnBankPO.enabled = NO;
		_btnCardTypePO.enabled = NO;
		//_accNoTF.enabled = NO;
		_expiryDateTF.enabled = NO;
		_expiryDateYearTF.enabled = NO;
		//_memberNameTF.enabled = NO;
		//_memberSexSC.enabled = NO;
        
        _memberSexSC.enabled = NO;
		// _memberDOBLbl.enabled=NO;
        _btnMemberDOBPO.enabled=NO;
        //_memberOtherIDTypeLbl.enabled=NO;
        _btnMemberOtherIDType.enabled=NO;
		_btnMemberRelationshipPO.enabled = NO;
		
		_ccsi = FALSE;
		_btnSameAsFT.enabled = FALSE;
        [self ClearCreditDetails];
        
	}
    [self.RecurPaymentPopover dismissPopoverAnimated:YES];
	
	//[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}


- (IBAction)actionForPersonTypePO:(id)sender {
	[self hideKeyboard];
	isFTPayment = FALSE;
	
	if (_PersonTypeVC == nil) {
		
		self.PersonTypeVC = [[PersonTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
		_PersonTypeVC.delegate = self;
        //		NSString *plan = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPlan"];
        //		NSLog(@"plan: %@", plan);
        //
        //		if (([plan isEqualToString:@"HLACP"]) || ([plan isEqualToString:@"L100"])){
        
        if(isCompany)
        {
            if (la2Available && PYAvailable) {
                NSLog(@"LA3");
                _PersonTypeVC.requestType = @"LA3";
            }
            else if (la2Available) {
                NSLog(@"LA2");
                _PersonTypeVC.requestType = @"LA2";
            }
            else if (PYAvailable) {
                NSLog(@"PY");
                _PersonTypeVC.requestType = @"PY1";
            }
            else if (POAvailable) {
                NSLog(@"PY");
                _PersonTypeVC.requestType = @"PO";
				
            }
            else {
                NSLog(@"LA");
                _PersonTypeVC.requestType = @"LA";
            }
			
            
        }
        else
        {
			if (la2Available && PYAvailable) {
				NSLog(@"LA3");
				_PersonTypeVC.requestType = @"LA3";
			}
			else if (la2Available) {
				NSLog(@"LA2");
				_PersonTypeVC.requestType = @"LA2";
			}
			else if (PYAvailable) {
				NSLog(@"PY");
				_PersonTypeVC.requestType = @"PY1";
			}
			else if (POAvailable) {
				NSLog(@"PY");
				_PersonTypeVC.requestType = @"PO";
			}
			else {
				NSLog(@"LA");
				_PersonTypeVC.requestType = @"LA";
			}
		}
		
		self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypeVC];
	}
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForPersonTypePO_FT:(id)sender {
	[self hideKeyboard];
	
	isFTPayment = TRUE;
	
	if (_PersonTypeVC == nil) {
		
		self.PersonTypeVC = [[PersonTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
		_PersonTypeVC.delegate = self;
        //		NSString *plan = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPlan"];
        //		NSLog(@"plan: %@", plan);
        //
        //		if (([plan isEqualToString:@"HLACP"]) || ([plan isEqualToString:@"L100"])){
        
        if(isCompany)
        {
            if (la2Available && PYAvailable) {
                NSLog(@"LA3");
                _PersonTypeVC.requestType = @"LA3";
            }
            else if (la2Available) {
                NSLog(@"LA2");
                _PersonTypeVC.requestType = @"LA2";
            }
            else if (PYAvailable) {
                NSLog(@"PY");
                _PersonTypeVC.requestType = @"PY1";
            }
            else if (POAvailable) {
                NSLog(@"PY");
                _PersonTypeVC.requestType = @"PO";
				
            }
            else {
                NSLog(@"LA");
                _PersonTypeVC.requestType = @"LA";
            }
			
            
        }
        else
        {
			if (la2Available && PYAvailable) {
				NSLog(@"LA3");
				_PersonTypeVC.requestType = @"LA3";
			}
			else if (la2Available) {
				NSLog(@"LA2");
				_PersonTypeVC.requestType = @"LA2";
			}
			else if (PYAvailable) {
				NSLog(@"PY");
				_PersonTypeVC.requestType = @"PY1";
			}
			else if (POAvailable) {
				NSLog(@"PY");
				_PersonTypeVC.requestType = @"PO";
			}
			else {
				NSLog(@"LA");
				_PersonTypeVC.requestType = @"LA";
			}
		}
		
		self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypeVC];
	}
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
	
}

-(void)selectedPersonType:(NSString *)selectedPersonType {
	
	if (firstTime3 ==1)
		firstTime3 = firstTime3 + 1;
	else
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
	[self hideKeyboard];
	
	
	//RECURRING PAYMENT
	if (!isFTPayment){
		_personTypeLbl.text = selectedPersonType;
		
		_btnBankPO.enabled = YES;
		_btnCardTypePO.enabled=YES;
		
		//	_personTypeLbl.textColor = [UIColor blackColor];
		if ([_personTypeLbl.text isEqual:@"Other Payor"]) {
			_memberNameTF.enabled = YES;
			_memberSexSC.enabled = YES;
			_btnMemberDOBPO.enabled = YES;
			_memberIC.enabled = YES;
			_btnMemberOtherIDType.enabled = YES;
			
			_btnBankPO.enabled=YES;
			_btnCardTypePO.enabled=YES;
			_expiryDateTF.enabled = YES;
			_expiryDateYearTF.enabled= YES;
			
			//_memberOtherIDTF.enabled = YES;
			
			_memberContactNoTF.enabled = YES;
			_memberContactNoPrefixCF.enabled = YES;
			_btnMemberRelationshipPO.enabled = YES;
			_op = TRUE;
			
			_memberNameTF.textColor = [UIColor blackColor];
			_memberDOBLbl.textColor = [UIColor blackColor];
			_memberIC.textColor = [UIColor blackColor];
			_memberOtherIDTypeLbl.textColor = [UIColor blackColor];
			_memberOtherIDTF.textColor = [UIColor blackColor];
			_memberContactNoPrefixCF.textColor = [UIColor blackColor];
			_memberContactNoTF.textColor = [UIColor blackColor];
			_memberRelationshipLbl.textColor = [UIColor blackColor];
			
			if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
				_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
				_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
				_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
				
				_memberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"];
				if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"M"]) {
					_memberSexSC.selectedSegmentIndex = 0;
				}
				else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"F"]) {
					_memberSexSC.selectedSegmentIndex = 1;
				}
				_memberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"];
				_memberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"];
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"]];
				
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"];
				
				_memberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"];
				
				
				if ([_memberOtherIDTypeLbl.text isEqualToString:@""]||[_memberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _memberOtherIDTypeLbl.text==nil)
				{
					_memberOtherIDTF.enabled =NO;
				}
				else
				{
					_memberOtherIDTF.enabled =YES;
				}
				
				if (_memberIC.text.length == 12) {
					_memberSexSC.enabled = NO;
					_btnMemberDOBPO.enabled = NO;
					_memberDOBLbl.textColor = [UIColor grayColor];
				}
				
				NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"];
				NSArray *ary = [contact componentsSeparatedByString:@" "];
				_memberContactNoTF.text = [ary objectAtIndex:1];
				_memberContactNoPrefixCF.text = [ary objectAtIndex:0];
				_memberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"];
			}
			else {
				_bankLbl.text = @"";
				_cardTypeLbl.text = @"";
				_accNoTF.text = @"";
				_expiryDateTF.text = @"";
				_expiryDateYearTF.text = @"";
				
				_memberNameTF.text = @"";
				_memberSexSC.selectedSegmentIndex = -1;
				_memberDOBLbl.text = @"";
				_memberIC.text = @"";
				_memberOtherIDTypeLbl.text = @"";
				_memberOtherIDTF.text = @"";
				_memberContactNoTF.text = @"";
				_memberContactNoPrefixCF.text = @"";
				_memberRelationshipLbl.text = @"";
			}
		}
		
		else {
			_bankLbl.text = @"";
			_cardTypeLbl.text = @"";
			_accNoTF.text = @"";
			_expiryDateTF.text = @"";
			_expiryDateYearTF.text = @"";
			
			_memberNameTF.enabled = NO;
			_memberSexSC.enabled = NO;
			_btnMemberDOBPO.enabled = NO;
			_memberIC.enabled = NO;
			_btnMemberOtherIDType.enabled = NO;
			//		_memberOtherIDTF.enabled = NO;
			_memberContactNoTF.enabled = NO;
			_memberContactNoPrefixCF.enabled = NO;
			_btnMemberRelationshipPO.enabled = NO;
			_op = FALSE;
		}
		
		if ([_personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
			
			_btnBankPO.enabled=YES;
			_btnCardTypePO.enabled=YES;
			_expiryDateTF.enabled = YES;
			_expiryDateYearTF.enabled= YES;
			_memberOtherIDTF.enabled =NO;
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA1", Nil];
			
			while ([results next]) {
				_memberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_memberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_memberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_memberSexSC setSelectedSegmentIndex:-1];
				}
				
				_memberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_memberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_memberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				//If LA1 is Policy Owner, then relationship = SELF
				
				if (!la2Available && !PYAvailable && !POAvailable) {
					_memberRelationshipLbl.text = @"SELF";
				}
				else {
					_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				}
				
				
				if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
					_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
					_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
					[self getCardAndBankType];
					_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
					_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
					_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
				}
				
				
				_memberNameTF.textColor = [UIColor grayColor];
				_memberDOBLbl.textColor = [UIColor grayColor];
				_memberIC.textColor = [UIColor grayColor];
				_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
				_memberOtherIDTF.textColor = [UIColor grayColor];
				_memberContactNoPrefixCF.textColor = [UIColor grayColor];
				_memberContactNoTF.textColor = [UIColor grayColor];
				_memberRelationshipLbl.textColor = [UIColor grayColor];
				
			}
		}
		else if ([_personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_memberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_memberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_memberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_memberSexSC setSelectedSegmentIndex:-1];
				}
				
				_memberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_memberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				_memberOtherIDTF.enabled =NO;
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_memberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				//_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				_memberRelationshipLbl.text = @"SELF";
				
			}
			if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
				_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
				_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
			}
			
			_memberNameTF.textColor = [UIColor grayColor];
			_memberDOBLbl.textColor = [UIColor grayColor];
			_memberIC.textColor = [UIColor grayColor];
			_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_memberOtherIDTF.textColor = [UIColor grayColor];
			_memberContactNoPrefixCF.textColor = [UIColor grayColor];
			_memberContactNoTF.textColor = [UIColor grayColor];
			_memberRelationshipLbl.textColor = [UIColor grayColor];
		}
		else if (isCompany && [_personTypeLbl.text isEqualToString:@"Policy Owner"]){
			
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Company can't be credit card payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1111;
			_memberNameTF.enabled = NO;
			_memberSexSC.enabled = NO;
			_btnMemberDOBPO.enabled = NO;
			_memberIC.enabled = NO;
			_btnMemberOtherIDType.enabled = NO;
			_memberOtherIDTF.enabled =NO;
			_btnBankPO.enabled=NO;
			_btnCardTypePO.enabled=NO;
			_accNoTF.enabled=NO;
			_expiryDateTF.enabled =NO;
			_expiryDateYearTF.enabled =NO;
			_memberContactNoTF.enabled = NO;
			_memberContactNoPrefixCF.enabled = NO;
			_btnMemberRelationshipPO.enabled = NO;
			
			if ([_memberOtherIDTypeLbl.text isEqualToString:@""]||[_memberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _memberOtherIDTypeLbl.text==nil)
			{
				_memberOtherIDTF.enabled =NO;
			}
			else
			{
				_memberOtherIDTF.enabled =YES;
			}
			
			
			_op = TRUE;
			
			_memberNameTF.textColor = [UIColor blackColor];
			_memberDOBLbl.textColor = [UIColor blackColor];
			_memberIC.textColor = [UIColor blackColor];
			_memberOtherIDTypeLbl.textColor = [UIColor blackColor];
			_memberOtherIDTF.textColor = [UIColor blackColor];
			_memberContactNoPrefixCF.textColor = [UIColor blackColor];
			_memberContactNoTF.textColor = [UIColor blackColor];
			_memberRelationshipLbl.textColor = [UIColor blackColor];
			
			if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
				_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
				_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
				
				_memberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"];
				if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"M"]) {
					_memberSexSC.selectedSegmentIndex = 0;
				}
				else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"F"]) {
					_memberSexSC.selectedSegmentIndex = 1;
				}
				_memberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"];
				_memberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"];
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"]];
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"];
				
				_memberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"];
				
				NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"];
				NSArray *ary = [contact componentsSeparatedByString:@" "];
				_memberContactNoTF.text = [ary objectAtIndex:1];
				_memberContactNoPrefixCF.text = [ary objectAtIndex:0];
				_memberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"];
			}
			else {
				_bankLbl.text = @"";
				_cardTypeLbl.text = @"";
				_accNoTF.text = @"";
				_expiryDateTF.text = @"";
				_expiryDateYearTF.text = @"";
				
				_memberNameTF.text = @"";
				_memberSexSC.selectedSegmentIndex = -1;
				_memberDOBLbl.text = @"";
				_memberIC.text = @"";
				_memberOtherIDTypeLbl.text = @"";
				_memberOtherIDTF.text = @"";
				_memberContactNoTF.text = @"";
				_memberContactNoPrefixCF.text = @"";
				_memberRelationshipLbl.text = @"";
			}
		}
		else if (!isCompany &&[_personTypeLbl.text isEqualToString:@"Policy Owner"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PO", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_memberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_memberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_memberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_memberSexSC setSelectedSegmentIndex:-1];
				}
				
				_memberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_memberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				_memberOtherIDTF.enabled =NO;
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_memberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				_memberRelationshipLbl.text = @"SELF";
				//_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				
			}
			if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
				_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
				_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
			}
			
			_memberNameTF.textColor = [UIColor grayColor];
			_memberDOBLbl.textColor = [UIColor grayColor];
			_memberIC.textColor = [UIColor grayColor];
			_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_memberOtherIDTF.textColor = [UIColor grayColor];
			_memberContactNoPrefixCF.textColor = [UIColor grayColor];
			_memberContactNoTF.textColor = [UIColor grayColor];
			_memberRelationshipLbl.textColor = [UIColor grayColor];
		}
		
		else if ([_personTypeLbl.text isEqualToString:@"Payor"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_memberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_memberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_memberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_memberSexSC setSelectedSegmentIndex:-1];
				}
				
				_memberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_memberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				if (IDTypeCodeSelected == NULL)
					IDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_memberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				_memberOtherIDTF.enabled =NO;
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_memberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_memberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				//_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				_memberRelationshipLbl.text = @"SELF";
				
			}
			if ([_personTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"]]) {
				_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
				_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
				_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
			}
			
			_memberNameTF.textColor = [UIColor grayColor];
			_memberDOBLbl.textColor = [UIColor grayColor];
			_memberIC.textColor = [UIColor grayColor];
			_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_memberOtherIDTF.textColor = [UIColor grayColor];
			_memberContactNoPrefixCF.textColor = [UIColor grayColor];
			_memberContactNoTF.textColor = [UIColor grayColor];
			_memberRelationshipLbl.textColor = [UIColor grayColor];
		}
	}
	
	else {
		//FIRST TIME PAYMENT
		
		_FTpersonTypeLbl.text = selectedPersonType;
		
		if (_isSameAsFT) {
			[self ActionForSameAsFT:nil];
		}
		
		_FTbtnBankPO.enabled = YES;
		_FTbtnCardTypePO.enabled=YES;
		
		//	_personTypeLbl.textColor = [UIColor blackColor];
		if ([_FTpersonTypeLbl.text isEqual:@"Other Payor"]) {
			_FTmemberNameTF.enabled = YES;
			_FTmemberSexSC.enabled = YES;
			_FTbtnMemberDOBPO.enabled = YES;
			_FTmemberIC.enabled = YES;
			_FTbtnMemberOtherIDType.enabled = YES;
			
			_FTbtnBankPO.enabled=YES;
			_FTbtnCardTypePO.enabled=YES;
			_FTexpiryDateTF.enabled = YES;
			_FTexpiryDateYearTF.enabled= YES;
			
			if ([_FTpersonTypeLbl.text isEqualToString:@"Other Payor"]) {
				
				if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@""]||[_FTmemberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _FTmemberOtherIDTypeLbl.text==nil)
				{
					_FTmemberOtherIDTF.enabled =NO;
					_FTmemberOtherIDTF.text =@"";
				}
				else
				{
					_FTmemberOtherIDTF.enabled =YES;
				}
				
			}
			
			_FTmemberContactNoTF.enabled = YES;
			_FTmemberContactNoPrefixCF.enabled = YES;
			_FTbtnMemberRelationshipPO.enabled = YES;
			_FTaccNoTF.enabled = YES;
			_FTop = TRUE;
			
			_FTmemberNameTF.textColor = [UIColor blackColor];
			_FTmemberDOBLbl.textColor = [UIColor blackColor];
			_FTmemberIC.textColor = [UIColor blackColor];
			_FTmemberOtherIDTypeLbl.textColor = [UIColor blackColor];
			_FTmemberOtherIDTF.textColor = [UIColor blackColor];
			_FTmemberContactNoPrefixCF.textColor = [UIColor blackColor];
			_FTmemberContactNoTF.textColor = [UIColor blackColor];
			_FTmemberRelationshipLbl.textColor = [UIColor blackColor];
			
			if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
				_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
				_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
				
				_FTmemberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberName"];
				if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"M"]) {
					_FTmemberSexSC.selectedSegmentIndex = 0;
				}
				else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"F"]) {
					_FTmemberSexSC.selectedSegmentIndex = 1;
				}
				_FTmemberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberDOB"];
				_FTmemberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberIC"];
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"]];
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"];
				
				_FTmemberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherID"];
				
				if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@""]||[_FTmemberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _FTmemberOtherIDTypeLbl.text==nil)
				{
					_FTmemberOtherIDTF.enabled =NO;
				}
				else
				{
					_FTmemberOtherIDTF.enabled =YES;
				}
				
				if (_FTmemberIC.text.length == 12) {
					_FTmemberSexSC.enabled = NO;
					_FTbtnMemberDOBPO.enabled = NO;
					_FTmemberDOBLbl.textColor = [UIColor grayColor];
				}
				
				
				NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberContactNo"];
				NSArray *ary = [contact componentsSeparatedByString:@" "];
				_FTmemberContactNoTF.text = [ary objectAtIndex:1];
				_FTmemberContactNoPrefixCF.text = [ary objectAtIndex:0];
				_FTmemberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberRelationship"];
			}
			else {
				_FTbankLbl.text = @"";
				_FTcardTypeLbl.text = @"";
				_FTaccNoTF.text = @"";
				_FTexpiryDateTF.text = @"";
				_FTexpiryDateYearTF.text = @"";
				
				_FTmemberNameTF.text = @"";
				_FTmemberSexSC.selectedSegmentIndex = -1;
				_FTmemberDOBLbl.text = @"";
				_FTmemberIC.text = @"";
				_FTmemberOtherIDTypeLbl.text = @"";
				_FTmemberOtherIDTF.text = @"";
				_FTmemberContactNoTF.text = @"";
				_FTmemberContactNoPrefixCF.text = @"";
				_FTmemberRelationshipLbl.text = @"";
			}
		}
		
		else {
			_FTbankLbl.text = @"";
			_FTcardTypeLbl.text = @"";
			_FTaccNoTF.text = @"";
			_FTexpiryDateTF.text = @"";
			_FTexpiryDateYearTF.text = @"";
			
			_FTmemberNameTF.enabled = NO;
			_FTmemberSexSC.enabled = NO;
			_FTbtnMemberDOBPO.enabled = NO;
			_FTmemberIC.enabled = NO;
			_FTbtnMemberOtherIDType.enabled = NO;
			//		_memberOtherIDTF.enabled = NO;
			_FTmemberContactNoTF.enabled = NO;
			_FTmemberContactNoPrefixCF.enabled = NO;
			_FTbtnMemberRelationshipPO.enabled = NO;
			_FTop = FALSE;
		}
		
		if ([_FTpersonTypeLbl.text isEqualToString:@"1st Life Assured"]) {
			
			_FTbtnBankPO.enabled=YES;
			_FTbtnCardTypePO.enabled=YES;
			_FTexpiryDateTF.enabled = YES;
			_FTexpiryDateYearTF.enabled= YES;
			_FTmemberOtherIDTF.enabled =NO;
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA1", Nil];
			
			while ([results next]) {
				_FTmemberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_FTmemberSexSC setSelectedSegmentIndex:-1];
				}
				
				_FTmemberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_FTmemberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_FTmemberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				//If LA1 is Policy Owner, then relationship = SELF
				
				if (!la2Available && !PYAvailable && !POAvailable) {
					_FTmemberRelationshipLbl.text = @"SELF";
				}
				else {
					_FTmemberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				}
				
				
				if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
					//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
					//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
					[self getCardAndBankType];
					_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
					_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
					_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
				}
				
				
				_FTmemberNameTF.textColor = [UIColor grayColor];
				_FTmemberDOBLbl.textColor = [UIColor grayColor];
				_FTmemberIC.textColor = [UIColor grayColor];
				_FTmemberOtherIDTypeLbl.textColor = [UIColor grayColor];
				_FTmemberOtherIDTF.textColor = [UIColor grayColor];
				_FTmemberContactNoPrefixCF.textColor = [UIColor grayColor];
				_FTmemberContactNoTF.textColor = [UIColor grayColor];
				_FTmemberRelationshipLbl.textColor = [UIColor grayColor];
				
			}
		}
		else if ([_FTpersonTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_FTmemberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_FTmemberSexSC setSelectedSegmentIndex:-1];
				}
				
				_FTmemberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_FTmemberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				_FTmemberOtherIDTF.enabled =NO;
				
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_FTmemberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				_FTmemberRelationshipLbl.text = @"SELF";
				
			}
			if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
				[self getCardAndBankType];
				_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
				_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
				_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
			}
			
			_FTmemberNameTF.textColor = [UIColor grayColor];
			_FTmemberDOBLbl.textColor = [UIColor grayColor];
			_FTmemberIC.textColor = [UIColor grayColor];
			_FTmemberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_FTmemberOtherIDTF.textColor = [UIColor grayColor];
			_FTmemberContactNoPrefixCF.textColor = [UIColor grayColor];
			_FTmemberContactNoTF.textColor = [UIColor grayColor];
			_FTmemberRelationshipLbl.textColor = [UIColor grayColor];
		}
		else if (isCompany && [_FTpersonTypeLbl.text isEqualToString:@"Policy Owner"]){
			
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Company can't be credit card payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert.tag = 1111;
			_FTmemberNameTF.enabled = NO;
			_FTmemberSexSC.enabled = NO;
			_FTbtnMemberDOBPO.enabled = NO;
			_FTmemberIC.enabled = NO;
			_FTbtnMemberOtherIDType.enabled = NO;
			_FTmemberOtherIDTF.enabled =NO;
			_FTbtnBankPO.enabled=NO;
			_FTbtnCardTypePO.enabled=NO;
			_FTaccNoTF.enabled=NO;
			_FTexpiryDateTF.enabled =NO;
			_FTexpiryDateYearTF.enabled =NO;
			_FTmemberContactNoTF.enabled = NO;
			_FTmemberContactNoPrefixCF.enabled = NO;
			_FTbtnMemberRelationshipPO.enabled = NO;
			
			if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@""]||[_FTmemberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _FTmemberOtherIDTypeLbl.text==nil)
			{
				_FTmemberOtherIDTF.enabled =NO;
			}
			else
			{
				_FTmemberOtherIDTF.enabled =YES;
			}
			
			
			_FTop = TRUE;
			
			_FTmemberNameTF.textColor = [UIColor blackColor];
			_FTmemberDOBLbl.textColor = [UIColor blackColor];
			_FTmemberIC.textColor = [UIColor blackColor];
			_FTmemberOtherIDTypeLbl.textColor = [UIColor blackColor];
			_FTmemberOtherIDTF.textColor = [UIColor blackColor];
			_FTmemberContactNoPrefixCF.textColor = [UIColor blackColor];
			_FTmemberContactNoTF.textColor = [UIColor blackColor];
			_FTmemberRelationshipLbl.textColor = [UIColor blackColor];
			
			if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
				_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
				_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
				
				_FTmemberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberName"];
				if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"M"]) {
					_FTmemberSexSC.selectedSegmentIndex = 0;
				}
				else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"] isEqualToString:@"F"]) {
					_FTmemberSexSC.selectedSegmentIndex = 1;
				}
				_FTmemberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberDOB"];
				_FTmemberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberIC"];
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"]];
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"];
				
				_FTmemberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherID"];
				
				NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberContactNo"];
				NSArray *ary = [contact componentsSeparatedByString:@" "];
				_FTmemberContactNoTF.text = [ary objectAtIndex:1];
				_FTmemberContactNoPrefixCF.text = [ary objectAtIndex:0];
				_FTmemberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberRelationship"];
			}
			else {
				_FTbankLbl.text = @"";
				_FTcardTypeLbl.text = @"";
				_FTaccNoTF.text = @"";
				_FTexpiryDateTF.text = @"";
				_FTexpiryDateYearTF.text = @"";
				
				_FTmemberNameTF.text = @"";
				_FTmemberSexSC.selectedSegmentIndex = -1;
				_FTmemberDOBLbl.text = @"";
				_FTmemberIC.text = @"";
				_FTmemberOtherIDTypeLbl.text = @"";
				_FTmemberOtherIDTF.text = @"";
				_FTmemberContactNoTF.text = @"";
				_FTmemberContactNoPrefixCF.text = @"";
				_FTmemberRelationshipLbl.text = @"";
			}
		}
		else if (!isCompany &&[_FTpersonTypeLbl.text isEqualToString:@"Policy Owner"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PO", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_FTmemberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_FTmemberSexSC setSelectedSegmentIndex:-1];
				}
				
				_FTmemberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_FTmemberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				_FTmemberOtherIDTF.enabled =NO;
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_FTmemberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				_FTmemberRelationshipLbl.text = @"SELF";
				//_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				
			}
			if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
				//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
				//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
				[self getCardAndBankType];
				_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
				_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
				_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
			}
			
			_FTmemberNameTF.textColor = [UIColor grayColor];
			_FTmemberDOBLbl.textColor = [UIColor grayColor];
			_FTmemberIC.textColor = [UIColor grayColor];
			_FTmemberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_FTmemberOtherIDTF.textColor = [UIColor grayColor];
			_FTmemberContactNoPrefixCF.textColor = [UIColor grayColor];
			_FTmemberContactNoTF.textColor = [UIColor grayColor];
			_FTmemberRelationshipLbl.textColor = [UIColor grayColor];
		}
		
		else if ([_FTpersonTypeLbl.text isEqualToString:@"Payor"]) {
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *docsPath = [paths objectAtIndex:0];
			NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase *db = [FMDatabase databaseWithPath:path];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
			
			NSInteger *count = 0;
			while ([results next]) {
				count = count + 1;
				_FTmemberNameTF.text = [results stringForColumn:@"LAName"] != NULL ? [results stringForColumn:@"LAName"] : @"";
				
				NSString *gender = [results stringForColumn:@"LASex"];
				if ([gender hasPrefix:@"M"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:0];
				}
				else if ([gender hasPrefix:@"F"]) {
					[_FTmemberSexSC setSelectedSegmentIndex:1];
				}
				else {
					[_FTmemberSexSC setSelectedSegmentIndex:-1];
				}
				
				_FTmemberDOBLbl.text = [results stringForColumn:@"LADOB"] != NULL ? [results stringForColumn:@"LADOB"] : @"";
				_FTmemberIC.text = [results stringForColumn:@"LANewICNo"] != NULL ? [results stringForColumn:@"LANewICNo"] : @"";
				_FTmemberOtherIDTypeLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @""];
				if (FTIDTypeCodeSelected == NULL)
					FTIDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"] != NULL ? [results stringForColumn:@"LAOtherIDType"] : @"";
				_FTmemberOtherIDTF.text = [results stringForColumn:@"LAOtherID"] != NULL ? [results stringForColumn:@"LAOtherID"] : @"";
				_FTmemberOtherIDTF.enabled =NO;
				
				if ([results stringForColumn:@"MobilePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"MobilePhoneNo"];
				}
				else if ([results stringForColumn:@"ResidencePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"ResidencePhoneNo"];
				}
				else if ([results stringForColumn:@"OfficePhoneNo"].length != 0) {
					_FTmemberContactNoPrefixCF.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
					_FTmemberContactNoTF.text = [results stringForColumn:@"OfficePhoneNo"];
				}
				
				//_memberRelationshipLbl.text = [results stringForColumn:@"LARelationship"] != NULL ? [results stringForColumn:@"LARelationship"] : @"";
				_FTmemberRelationshipLbl.text = @"SELF";
				
			}
			if ([_FTpersonTypeLbl.text isEqualToString:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"]]) {
				[self getCardAndBankType];
				//_FTaccNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"];
				//_FTexpiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMonthExpiryDate"];
				//_FTexpiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTYearExpiryDate"];
			}
			
			_FTmemberNameTF.textColor = [UIColor grayColor];
			_FTmemberDOBLbl.textColor = [UIColor grayColor];
			_FTmemberIC.textColor = [UIColor grayColor];
			_FTmemberOtherIDTypeLbl.textColor = [UIColor grayColor];
			_FTmemberOtherIDTF.textColor = [UIColor grayColor];
			_FTmemberContactNoPrefixCF.textColor = [UIColor grayColor];
			_FTmemberContactNoTF.textColor = [UIColor grayColor];
			_FTmemberRelationshipLbl.textColor = [UIColor grayColor];
		}
		
		else if ([_FTpersonTypeLbl.text isEqualToString:@"Other Payor"]) {
			
			if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@""]||[_FTmemberOtherIDTypeLbl.text isEqualToString:@"-SELECT-"] || _FTmemberOtherIDTypeLbl.text==nil)
			{
				_FTmemberOtherIDTF.enabled =NO;
			}
			else
			{
				_FTmemberOtherIDTF.enabled =YES;
			}
		}
		
		
	}
	
    [self.PersonTypePopover dismissPopoverAnimated:YES];
	//[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (IBAction)actionForBankPO:(id)sender {
	[self hideKeyboard];
	isFTPayment = FALSE;
    _WhatBAnktype =@"RC";
	if (_IssuingBankVC == nil) {
        
        self.IssuingBankVC = [[IssuingBankPopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _IssuingBankVC.delegate = self;
        self.IssuingBankPopover = [[UIPopoverController alloc] initWithContentViewController:_IssuingBankVC];
    }
    
    [self.IssuingBankPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForBankPO_FT:(id)sender{
	[self hideKeyboard];
    _WhatBAnktype =@"FT";
	isFTPayment = TRUE;
	
	if (_IssuingBankVC == nil) {
        
        self.IssuingBankVC = [[IssuingBankPopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _IssuingBankVC.delegate = self;
        self.IssuingBankPopover = [[UIPopoverController alloc] initWithContentViewController:_IssuingBankVC];
    }
    
    [self.IssuingBankPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedIssuingBank:(NSString *)selectedIssuingBank {
	[self hideKeyboard];
    
    if([_WhatBAnktype isEqualToString:@"FT"])
    {
        _FTbankLbl.text = selectedIssuingBank;
    }
    else if ([_WhatBAnktype isEqualToString:@"RC"])
    {
        _bankLbl.text = selectedIssuingBank;
    }
    else if ([_WhatBAnktype isEqualToString:@"DC"])
    {
        DCBankName.text =selectedIssuingBank;
    }
	
	//	if (isFTPayment == FALSE)
	//
	//		_bankLbl.text = selectedIssuingBank;
	//	else if (isFTPayment == TRUE)
	//		_FTbankLbl.text = selectedIssuingBank;
	//
	//    if(isDCPayment)
	//    {
	//        DCBankName.text =selectedIssuingBank;
	//    }
    
    
	
	//	_bankLbl.textColor = [UIColor blackColor];
    [self.IssuingBankPopover dismissPopoverAnimated:YES];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}


- (IBAction)actionForCardTypePO:(id)sender {
	[self hideKeyboard];
	isFTPayment = FALSE;
    _WhatAccountType =@"RC";
	if (_CardTypeVC == nil) {
        
        self.CardTypeVC = [[CardTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _CardTypeVC.delegate = self;
        self.CardTypePopover = [[UIPopoverController alloc] initWithContentViewController:_CardTypeVC];
    }
    
    [self.CardTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForCardTypePO_FT:(id)sender {
	[self hideKeyboard];
	_WhatAccountType =@"FT";
	isFTPayment = TRUE;
	if (_CardTypeVC == nil) {
        
        self.CardTypeVC = [[CardTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _CardTypeVC.delegate = self;
        self.CardTypePopover = [[UIPopoverController alloc] initWithContentViewController:_CardTypeVC];
    }
    
    [self.CardTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedCardType:(NSString *)selectedCardType {
	[self hideKeyboard];
    
    
    if([_WhatAccountType isEqualToString:@"FT"])
    {
        _FTcardTypeLbl.text = selectedCardType;
		if ([_FTcardTypeLbl.text isEqualToString:@""])
		{
			_FTaccNoTF.enabled =NO;
			
		}
		else
		{
			_FTaccNoTF.enabled =YES;
			
		}
		
    }
    else if ([_WhatAccountType isEqualToString:@"RC"])
    {
        _cardTypeLbl.text = selectedCardType;
		if ([_cardTypeLbl.text isEqualToString:@""])
		{
			_accNoTF.enabled =NO;
			
		}
		else
		{
			_accNoTF.enabled =YES;
			
		}
		
    }
    else if ([_WhatAccountType isEqualToString:@"DC"])
    {
        DCAccountType.text =selectedCardType;
    }
	
    
    
	//    if(isDCPayment)
	//    {
	//        DCAccountType.text =selectedCardType;
	//    }
	//
	//	if (!isFTPayment){
	//		_cardTypeLbl.text = selectedCardType;
	//		if ([_cardTypeLbl.text isEqualToString:@""])
	//		{
	//			_accNoTF.enabled =NO;
	//
	//		}
	//		else
	//		{
	//			_accNoTF.enabled =YES;
	//
	//		}
	//	}
	//	else {
	//		_FTcardTypeLbl.text = selectedCardType;
	//		if ([_FTcardTypeLbl.text isEqualToString:@""])
	//		{
	//			_FTaccNoTF.enabled =NO;
	//
	//		}
	//		else
	//		{
	//			_FTaccNoTF.enabled =YES;
	//
	//		}
	//	}
	
	//	_cardTypeLbl.textColor = [UIColor blackColor];
    [self.CardTypePopover dismissPopoverAnimated:YES];
    [self.CardTypePopoverDC dismissPopoverAnimated:YES];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}


- (IBAction)actionForMemberRelationshipPO:(id)sender {
	isFTPayment = FALSE;
	if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
		if ([_personTypeLbl.text isEqualToString:@"Other Payor"]) {
			_RelationshipVC.requestType = @"creditCard2";  //NO SELF relationship
		}
		else {
			_RelationshipVC.requestType = @"creditCard";
		}
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForMemberRelationshipPO_FT:(id)sender {
	isFTPayment = TRUE;
	if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        if ([_FTpersonTypeLbl.text isEqualToString:@"Other Payor"]) {
			_RelationshipVC.requestType = @"creditCard2"; //NO SELF relationship
		}
		else {
			_RelationshipVC.requestType = @"creditCard";
		}
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)editingDidEndIC:(id)sender {
	UITextField *tf = (UITextField *) sender;
	//	NSLog(@"view: %@", tf.text);
	
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *myNumber = [f numberFromString:tf.text];
	NSLog(@"view: %@", myNumber);
	
	//	NSNumber *myNumber = [f numberFromString:];
	
}

- (IBAction)actionForICNo:(UITextField *)textField{
	//UITextField *tf = (UITextField *) sender;
	
	NSString *ICno;
	NSString *gender;
	NSString *DOB;
	NSString *strDOB;
	NSString *strDOB2;
	BOOL invalidDob;
	
	if (textField == _memberIC) {
		ICno = _memberIC.text;
	}
	else if (textField == _FTmemberIC) {
		ICno = _FTmemberIC.text;
	}
	
	if (ICno.length == 12)
    {
		
		BOOL valid;
		invalidDob = TRUE;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[ICno stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
		
		if (valid) {
			NSString *last = [ICno substringFromIndex:[ICno length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                gender = @"MALE";
            } else {
                gender = @"FEMALE";
            }
			
			//get the DOB value from ic entered
            NSString *strDate = [ICno substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [ICno substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [ICno substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
            strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
			
			//determine day of february
            NSString *febStatus = nil;
            float devideYear = [strYear floatValue]/4;
            int devideYear2 = devideYear;
            float minus = devideYear - devideYear2;
            if (minus > 0) {
                febStatus = @"Normal";
            }
            else {
                febStatus = @"Jump";
            }
			
			//compare year is valid or not
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *d = [NSDate date];
            NSDate *d2 = [dateFormatter dateFromString:strDOB2];
            
            if ([d compare:d2] == NSOrderedAscending) {
                invalidDob = false;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                invalidDob = false;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                invalidDob = false;
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                invalidDob = false;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
				invalidDob = false;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
				invalidDob = false;
            }
            else {
				DOB = strDOB;
            }
            
            last = nil, oddSet = nil;
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;
	}
    
    
	
	
	if (textField == _memberIC) {
		if (ICno.length != 12){
			if (_memberSexSC.enabled == NO) {
				_memberSexSC.selectedSegmentIndex =-1;
				_memberDOBLbl.text =@"";
			}
			_memberSexSC.enabled = TRUE;
			_btnMemberDOBPO.enabled = TRUE;
			_memberDOBLbl.textColor = [UIColor blackColor];
		}
		if (ICno.length == 12){
			if (invalidDob) {
				_memberSexSC.enabled = FALSE;
				_btnMemberDOBPO.enabled = FALSE;
				
				if ([gender isEqualToString:@"MALE"])
					_memberSexSC.selectedSegmentIndex = 0;
				else if ([gender isEqualToString:@"FEMALE"])
					_memberSexSC.selectedSegmentIndex = 1;
				
				_memberDOBLbl.text = DOB;
				_memberDOBLbl.textColor = [UIColor grayColor];
			}
			
			else {
				_memberSexSC.enabled = TRUE;
				_btnMemberDOBPO.enabled = TRUE;
				_memberSexSC.selectedSegmentIndex =-1;
				_memberDOBLbl.text =@"";
				_memberDOBLbl.textColor = [UIColor blackColor];
			}
		}
	}
	
	else if (textField == _FTmemberIC) {
		if (ICno.length != 12){
			if (_FTmemberSexSC.enabled == NO) {
				_FTmemberSexSC.selectedSegmentIndex =-1;
				_FTmemberDOBLbl.text =@"";
			}
			_FTmemberSexSC.enabled = TRUE;
			_FTbtnMemberDOBPO.enabled = TRUE;
			_FTmemberDOBLbl.textColor = [UIColor blackColor];
		}
		
		if (ICno.length == 12){
			if (invalidDob) {
				_FTmemberSexSC.enabled = FALSE;
				_FTbtnMemberDOBPO.enabled = FALSE;
				
				if ([gender isEqualToString:@"MALE"])
					_FTmemberSexSC.selectedSegmentIndex = 0;
				else if ([gender isEqualToString:@"FEMALE"])
					_FTmemberSexSC.selectedSegmentIndex = 1;
				
				_FTmemberDOBLbl.text = DOB;
				_FTmemberDOBLbl.textColor = [UIColor grayColor];
			}
			else {
				_FTmemberSexSC.enabled = TRUE;
				_FTbtnMemberDOBPO.enabled = TRUE;
				_FTmemberSexSC.selectedSegmentIndex =-1;
				_FTmemberDOBLbl.text =@"";
				_FTmemberDOBLbl.textColor = [UIColor blackColor];
			}
		}
	}
	
	
}

-(void)selectedRelationship:(NSString *)theRelation {
	[self hideKeyboard];
	if (!isFTPayment)
		_memberRelationshipLbl.text = theRelation;
	else
		_FTmemberRelationshipLbl.text = theRelation;
	
	//	_memberRelationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (IBAction)ActionDOB:(id)sender
{
	[self hideKeyboard];
	isFTPayment= FALSE;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _memberDOBLbl.text = dateString;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (IBAction)ActionDOB_FT:(id)sender {
	[self hideKeyboard];
	isFTPayment = TRUE;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _memberDOBLbl.text = dateString;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (IBAction)ActionOtherID:(id)sender
{
	[self hideKeyboard];
	isFTPayment = FALSE;
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionOtherID_FT:(id)sender
{
	[self hideKeyboard];
	isFTPayment = TRUE;
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForDeathTPD:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    if (btnPressed.tag == 1) {
		
		[_btnLevelFace setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isLevelFace = YES;
		
		[_btnFacePlus setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isFacePlus = NO;
	}
	else if (btnPressed.tag == 2) {
		
		[_btnFacePlus setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isFacePlus = YES;
		
		[_btnLevelFace setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isLevelFace = NO;
	}
}

- (IBAction)actionForInvestStrategy:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
	if (btnPressed.tag == 1) {
		
		[_btnVeryDyn setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isVeryDynamic = YES;
		
		[_btnModDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isModDynamic = NO;
		
		[_btnDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isDynamic = NO;
		
		[_btnBalanced setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isBalanced = NO;
	}
	else if (btnPressed.tag == 2) {
		
		[_btnVeryDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isVeryDynamic = NO;
		
		[_btnModDyn setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isModDynamic = YES;
		
		[_btnDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isDynamic = NO;
		
		[_btnBalanced setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isBalanced = NO;
	}
	else if (btnPressed.tag == 3) {
		
		[_btnVeryDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isVeryDynamic = NO;
		
		[_btnModDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isModDynamic = NO;
		
		[_btnDyn setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isDynamic = YES;
		
		[_btnBalanced setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isBalanced = NO;
	}
	else if (btnPressed.tag == 4) {
		
		[_btnVeryDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isVeryDynamic = NO;
		
		[_btnModDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isModDynamic = NO;
		
		[_btnDyn setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isDynamic = NO;
		
		[_btnBalanced setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isBalanced = YES;
	}
}

- (IBAction)actionForLIEN:(id)sender
{
	
	isLIEN = !isLIEN;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	if(isLIEN)
    {
		[_btnLIEN setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecB"] setValue:@"TRUE" forKey:@"LIEN"];
        
        
        _lblSubmitSpecial.hidden = NO;
		lbl.hidden=NO;
        
		//    [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"tickmark"];
		//        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        
    }
	else
    {
		[_btnLIEN setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecB"] setValue:@"FALSE" forKey:@"LIEN"];
        
		_lblSubmitSpecial.hidden = YES;
        lbl.hidden=YES;
        
		//        [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"tickmark"];
		//        [[NSUserDefaults standardUserDefaults]synchronize];
	}
	
}

- (IBAction)actionForExcessPrem:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {
		isPremDeposit = !isPremDeposit;
		if (isPremDeposit) {
			[_btnPremDeposit setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			
			//uncheck other
			isFuturePrem = false;
			[_btnFuturePrem setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			isTopUp = false;
			[_btnTopUp setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnPremDeposit setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
	else if (btnPressed.tag == 2) {
		isFuturePrem = !isFuturePrem;
		if (isFuturePrem) {
			[_btnFuturePrem setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			
			isPremDeposit = false;
			[_btnPremDeposit setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			isTopUp = false;
			[_btnTopUp setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnFuturePrem setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
	else if (btnPressed.tag == 3) {
		isTopUp = !isTopUp;
		if (isTopUp) {
			[_btnTopUp setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			
			isPremDeposit = false;
			[_btnPremDeposit setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			isFuturePrem = false;
			[_btnFuturePrem setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnTopUp setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
}

-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityDesc FROM eProposal_identification WHERE IdentityCode = ?", IDtype];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"IdentityDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (IDtype.length > 0) {
			if ([IDtype isEqualToString:@"- SELECT -"] || [IDtype isEqualToString:@""]) {
				desc = @"";
			}
			else {
				desc = IDtype;
				[self getIDTypeCode:IDtype];
			}
		}
	}
    return desc;
}
-(void) getIDTypeCode : (NSString*)IDtype
{
    NSString *code;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityCode FROM eProposal_identification WHERE IdentityDesc = ?", IDtype];
    
    while ([result next]) {
        code =[result objectForColumnName:@"IdentityCode"];
    }
	
    [result close];
    [db close];
	
	IDTypeCodeSelected = code;
	
}

-(void) getCardAndBankType{
	
	
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	int count = 0;
	int count2 = 0;
	
	if (!isFTPayment){
		//IssuingBank
		
		NSString *selectedCreditCardBank = @"";
		NSString *selectedCreditCardBankCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
		
		FMResultSet *resultsBankName = [db executeQuery:@"select * from eProposal_Credit_Card_Bank where CompanyCode = ?",selectedCreditCardBankCode,Nil];
		while ([resultsBankName next]) {
			count = count + 1;
			selectedCreditCardBank = [resultsBankName stringForColumn:@"CompanyName"];
			NSLog(@"%@", selectedCreditCardBank);
		}
		
		//CardType
		NSLog(@"%@",[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"]);
		NSString *selectedCreditCardType = @"";
		NSString *selectedCreditCardTypeCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
		FMResultSet *resultsCardType = [db executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardCode = ?",selectedCreditCardTypeCode,Nil];
		while ([resultsCardType next]) {
			count2 = count2 + 1;
			selectedCreditCardType = [resultsCardType stringForColumn:@"CreditCardDesc"];
			NSLog(@"%@",selectedCreditCardType);
		}
		if (count == 0)
			_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
		else
			_bankLbl.text = selectedCreditCardBank;
		
		if (count2 == 0)
			_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
		
		else
			_cardTypeLbl.text = selectedCreditCardType;
		
	}
	else {
		//IssuingBank
		
		NSString *selectedCreditCardBank = @"";
		NSString *selectedCreditCardBankCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"];
		
		FMResultSet *resultsBankName = [db executeQuery:@"select * from eProposal_Credit_Card_Bank where CompanyCode = ?",selectedCreditCardBankCode,Nil];
		while ([resultsBankName next]) {
			count = count + 1;
			selectedCreditCardBank = [resultsBankName stringForColumn:@"CompanyName"];
			NSLog(@"%@", selectedCreditCardBank);
		}
		
		//CardType
		NSLog(@"%@",[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"]);
		NSString *selectedCreditCardType = @"";
		NSString *selectedCreditCardTypeCode=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"];
		FMResultSet *resultsCardType = [db executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardCode = ?",selectedCreditCardTypeCode,Nil];
		while ([resultsCardType next]) {
			count2 = count2 + 1;
			selectedCreditCardType = [resultsCardType stringForColumn:@"CreditCardDesc"];
			NSLog(@"%@",selectedCreditCardType);
		}
		if (count == 0)
			_FTbankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"];
		else
			_FTbankLbl.text = selectedCreditCardBank;
		
		if (count2 == 0)
			_FTcardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"];
		
		else
			_FTcardTypeLbl.text = selectedCreditCardType;
	}
    
    
}



-(void) ClearCreditDetails{
	
	//	if ([_recurPaymentLbl.text isEqual:@"Credit Card Standing Instruction"] && [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RecurringPayment"] isEqualToString:@"Credit Card Standing Instruction"]) {
	//		_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"];
	//		//_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
	//		//_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
	//		[self getCardAndBankType];
	//		_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
	//		_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
	//		_expiryDateYearTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
	//
	//		_memberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"];
	//		if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"M"]) {
	//			_memberSexSC.selectedSegmentIndex = 0;
	//		}
	//		else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"F"]) {
	//			_memberSexSC.selectedSegmentIndex = 1;
	//		}
	//		_memberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"];
	//		_memberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"];
	//		_memberOtherIDTypeLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"]];
	//		if (IDTypeCodeSelected == NULL)
	//			IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"];
	//
	//		_memberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"];
	//
	//		NSString *contact = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"];
	//		NSArray *ary = [contact componentsSeparatedByString:@" "];
	//		_memberContactNoTF.text = [ary objectAtIndex:1];
	//		_memberContactNoPrefixCF.text = [ary objectAtIndex:0];
	//		_memberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"];
	//	}
	//	else {
	_personTypeLbl.text = @"";
	_bankLbl.text = @"";
	_cardTypeLbl.text = @"";
	_accNoTF.text = @"";
	_accNoTF.enabled = NO;
	_expiryDateTF.text = @"";
	_expiryDateYearTF.text = @"";
	
	_memberNameTF.text = @"";
	_memberSexSC.selectedSegmentIndex = -1;
	_memberDOBLbl.text = @"";
	_memberIC.text = @"";
	_memberOtherIDTypeLbl.text = @"";
	_memberOtherIDTF.text = @"";
	_memberContactNoTF.text = @"";
	_memberContactNoPrefixCF.text = @"";
	_memberRelationshipLbl.text = @"";
	//	}
}

#pragma mark - Credit Card FTP

-(void) EnableCreditCardFTP {
	
	if ([_firstTimePaymentLbl.text isEqual:@"Credit Card"]) {
		_FTbtnPersonTypePO.enabled = YES;
		//		_FTbtnBankPO.enabled = YES;
		//		_FTbtnCardTypePO.enabled = YES;
		//		_FTexpiryDateTF.enabled = YES;
		//		_FTexpiryDateYearTF.enabled = YES;
		
		_FTaccNoTF.enabled = YES;
		_FTexpiryDateTF.enabled = YES;
		_FTexpiryDateYearTF.enabled = YES;
		//		_FTmemberNameTF.enabled = YES;
		//		_FTmemberSexSC.enabled = YES;
		//		_FTbtnMemberDOBPO.enabled = YES;
		//		_FTmemberIC.enabled = YES;
		//		_FTbtnMemberOtherIDType.enabled = YES;
		//		_FTmemberOtherIDTF.enabled = YES;
		//		_FTmemberContactNoTF.enabled = YES;
		//		_FTmemberContactNoPrefixCF.enabled = YES;
		_FTbtnMemberRelationshipPO.enabled = YES;
		_FTccsi = TRUE;
		if ([self ShoudEnableSameAsCdt]) {
			_btnSameAsFT.enabled = TRUE;
		}
	}
	else {
		_FTbtnPersonTypePO.enabled = NO;
		_FTbtnBankPO.enabled = NO;
		_FTbtnCardTypePO.enabled = NO;
		_FTexpiryDateTF.enabled = NO;
		_FTexpiryDateYearTF.enabled = NO;
		
		_FTaccNoTF.enabled = FALSE;
		_FTexpiryDateTF.enabled = FALSE;
		_FTexpiryDateYearTF.enabled = FALSE;
		_FTmemberNameTF.enabled = FALSE;
		_FTmemberSexSC.enabled = FALSE;
		_FTbtnMemberDOBPO.enabled = FALSE;
		_FTmemberIC.enabled = FALSE;
		_FTbtnMemberOtherIDType.enabled = FALSE;
		_FTmemberOtherIDTF.enabled = FALSE;
		_FTmemberContactNoTF.enabled = FALSE;
		_FTmemberContactNoPrefixCF.enabled = FALSE;
		_FTbtnMemberRelationshipPO.enabled = FALSE;
		
		_FTccsi = FALSE;
        _btnSameAsFT.enabled = FALSE;
	}
}

- (IBAction)TckPolicyBankDetailsDC:(id)sender;
{
	
    ChangeTick = !ChangeTick;
    if(ChangeTick)
    {
        
        ChangeTickMAsterMenu = @"Yes";
        _TickMArkValue =@"Y";
        
		
		[TckbuttonPolicyBankDetails setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        
        
        FMDatabase *db = [FMDatabase databaseWithPath:path];
        if (![db open]) {
            NSLog(@"Could not open db.");
            db = [FMDatabase databaseWithPath:path];
            
            [db open];
        }
        
        NSString *payeeType;
        NSString *newICno;
        NSString *otherIDType;
        NSString *OtherID;
        NSString *Email;
        NSString *ContactNo;
        NSString *ContactNoPrefic;
        
        NSString *displayThis = nil;
        displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
        if (displayThis ==nil) {
            displayThis = @"";
        }
        
        
        NSString *selectPO = [NSString stringWithFormat:@"select PTypeCode, LANewICNo, LAOtherIDType, LAOtherID, MobilePhoneNo,MobilePhoneNoPrefix, EmailAddress FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",displayThis];
        
        FMResultSet *results;
        results = [db executeQuery:selectPO];
        while ([results next])
        {
            payeeType = [results objectForColumnName:@"PTypeCode"];
            newICno = [results objectForColumnName:@"LANewICNo"];
            otherIDType = [self getIDTypeDesc:[results objectForColumnName:@"LAOtherIDType"]];
            OtherID = [results objectForColumnName:@"LAOtherID"];
            Email = [results objectForColumnName:@"EmailAddress"];
			//            ContactNo = [results objectForColumnName:@"ResidencePhoneNo"];
			//            ContactNoPrefic = [results objectForColumnName:@"ResidencePhoneNoPrefix"];
            
            ContactNo = [results objectForColumnName:@"MobilePhoneNo"];
            ContactNoPrefic = [results objectForColumnName:@"MobilePhoneNoPrefix"];
            
            
        }
        
        
        // @synthesize DCBankName;
        // @synthesize DCAccountType;
        // @synthesize DCAccNo;
        
        if ([payeeType isEqualToString: @"LA1"])
        {
            PayeeType.text =@"1st Life Assured";
        }
        
        if ([payeeType isEqualToString:@"LA2"])
        {
            PayeeType.text =@"2nd Life Assured";
        }
        
        if ([payeeType isEqualToString:@"PO"])
        {
            PayeeType.text =@"Policy Owner";
        }
        
        if ([payeeType isEqualToString:@"PY1"])
        {
            PayeeType.text =@"Payor";
        }
        
        PayeeType.textColor =[UIColor grayColor];
        PayeeType.enabled =NO;
        
        
        DCNewIcNo.text =newICno;
        DCNewIcNo.textColor =[UIColor grayColor];
        DCNewIcNo.enabled =NO;
        
        OtherIDTypeDc.text =otherIDType;
        OtherIDTypeDc.textColor =[UIColor grayColor];
        OtherIDTypeDc.enabled =NO;
        
        OtherIDDC.text =OtherID;
        OtherIDDC.textColor =[UIColor grayColor];
        OtherIDDC.enabled =NO;
        
		//        emailDC.text = Email;
		//        emailDC.textColor =[UIColor grayColor];
		//        emailDC.enabled =NO;
        
		//    mobileNoPrefixDC.text =@"";
		//    mobileNoPrefixDC.textColor =[UIColor blackColor];
		//   mobileNoPrefixDC.enabled =YES;
        
        
        if([Email isEqualToString:@""])
        {
            emailDC.text =@"";
            emailDC.textColor =[UIColor blackColor];
            emailDC.enabled =YES;
        }
        else
        {
            emailDC.text =Email;
            emailDC.textColor =[UIColor grayColor];
            emailDC.enabled =NO;
        }
        
        if([ContactNo isEqualToString:@""])
        {
            mobileNoDC.text =@"";
            mobileNoDC.textColor =[UIColor blackColor];
            mobileNoDC.enabled =YES;
        }
        else
        {
            mobileNoDC.text =ContactNo;
            mobileNoDC.textColor =[UIColor grayColor];
            mobileNoDC.enabled =NO;
        }
        if([ContactNoPrefic isEqualToString:@""])
        {
            mobileNoPrefixDC.text =@"";
            mobileNoPrefixDC.textColor =[UIColor blackColor];
            mobileNoPrefixDC.enabled =YES;
        }
        else
        {
            mobileNoPrefixDC.text =ContactNoPrefic;
            mobileNoPrefixDC.textColor =[UIColor grayColor];
            mobileNoPrefixDC.enabled =NO;
        }
		
		
		
        
		//        if(mobileNoDC.tag==1)
		//        {
		//            ContactNo =@"";
		//            ContactNoPrefic =@"";
		//
		//        }
		//
		//        if([ContactNo isEqualToString:@""])
		//        {
		//            mobileNoDC.text =ContactNo;
		//            mobileNoDC.textColor =[UIColor blackColor];
		//            mobileNoDC.enabled =YES;
		//        }
		//        else
		//        {
		//            mobileNoDC.text =ContactNo;
		//            mobileNoDC.textColor =[UIColor grayColor];
		//            mobileNoDC.enabled =NO;
		//        }
		//
		//        if([ContactNoPrefic isEqualToString:@""])
		//        {
		//            mobileNoPrefixDC.text =ContactNoPrefic;
		//            mobileNoPrefixDC.textColor =[UIColor blackColor];
		//            mobileNoPrefixDC.enabled =YES;
		//        }
		//        else
		//        {
		//            mobileNoPrefixDC.text =ContactNoPrefic;
		//            mobileNoPrefixDC.textColor =[UIColor grayColor];
		//            mobileNoPrefixDC.enabled =NO;
		//        }
		
        
        
		
        
        DCBankName.text =@"";
        DCBankName.enabled =YES;
        DCBankName.textColor =[UIColor blackColor];
        
        DCAccountType.text =@"";
        DCAccountType.enabled =YES;
        DCAccountType.textColor =[UIColor blackColor];
        
        
        DCAccNo.text =@"";
        DCAccNo.enabled =YES;
        DCAccNo.textColor =[UIColor blackColor];
        
        
        DCBankNameBtn.enabled=TRUE;
        DCAccountTypeBtn.enabled=TRUE;
		
    }
    else
    {
		[TckbuttonPolicyBankDetails setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        ChangeTickMAsterMenu =@"No";
		_TickMArkValue =@"N";
		
        
        DCBankName.text =@"";
        DCBankName.enabled =NO;
        DCAccountType.text =@"";
        DCAccountType.enabled =NO;
        DCAccNo.text =@"";
        DCAccNo.enabled =NO;
        PayeeType.text =@"";
        PayeeType.enabled =NO;
        DCNewIcNo.text =@"";
        DCNewIcNo.enabled =NO;
        OtherIDTypeDc.text =@"";
        OtherIDTypeDc.enabled =NO;
        OtherIDDC.text =@"";
        OtherIDDC.enabled =NO;
        emailDC.text =@"";
        emailDC.enabled =NO;
        mobileNoPrefixDC.text =NO;
        mobileNoPrefixDC.text =@"";
		mobileNoDC.text =NO;
        mobileNoDC.text =@"";
        mobileNoDC.tag =1;
        
        
        DCBankNameBtn.enabled=FALSE;
        DCAccountTypeBtn.enabled=FALSE;
		
		
    }
    
	//   if (ChangeTick ==YES)
	//    {
	//
	//
	//    }
	//
	//    else
	//    {
	//        [TckbuttonPolicyBankDetails setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	//
	//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//        NSString *documentsDirectory = [paths objectAtIndex:0];
	//        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	//
	//
	//        FMDatabase *db = [FMDatabase databaseWithPath:path];
	//        if (![db open]) {
	//            NSLog(@"Could not open db.");
	//            db = [FMDatabase databaseWithPath:path];
	//
	//            [db open];
	//        }
	//
	//        NSString *payeeType;
	//        NSString *newICno;
	//        NSString *otherIDType;
	//        NSString *OtherID;
	//        NSString *Email;
	//        NSString *ContactNo;
	//        NSString *ContactNoPrefic;
	//
	//        NSString *displayThis = nil;
	//        displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
	//        if (displayThis ==nil) {
	//            displayThis = @"";
	//        }
	//
	//
	//        NSString *selectPO = [NSString stringWithFormat:@"select PTypeCode, LANewICNo, LAOtherIDType, LAOtherID, ResidencePhoneNo,ResidencePhoneNoPrefix, EmailAddress FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",displayThis];
	//
	//        FMResultSet *results;
	//        results = [db executeQuery:selectPO];
	//        while ([results next])
	//        {
	//            payeeType = [results objectForColumnName:@"PTypeCode"];
	//            newICno = [results objectForColumnName:@"LANewICNo"];
	//            otherIDType = [results objectForColumnName:@"LAOtherIDType"];
	//            OtherID = [results objectForColumnName:@"LAOtherID"];
	//            Email = [results objectForColumnName:@"EmailAddress"];
	//            ContactNo = [results objectForColumnName:@"ResidencePhoneNo"];
	//            ContactNoPrefic = [results objectForColumnName:@"ResidencePhoneNoPrefix"];
	//        }
	//
	//
	//        // @synthesize DCBankName;
	//        // @synthesize DCAccountType;
	//        // @synthesize DCAccNo;
	//
	//        if ([payeeType isEqualToString: @"LA1"])
	//        {
	//            PayeeType.text =@"1st Life Assured";
	//        }
	//
	//        if ([payeeType isEqualToString:@"LA2"])
	//        {
	//            PayeeType.text =@"2nd Life Assured";
	//        }
	//
	//        if ([payeeType isEqualToString:@"PO"])
	//        {
	//            PayeeType.text =@"Policy Owner";
	//        }
	//
	//        if ([payeeType isEqualToString:@"PY1"])
	//        {
	//            PayeeType.text =@"Payor";
	//        }
	//
	//        DCNewIcNo.text =newICno;
	//        OtherIDTypeDc.text =otherIDType;
	//        OtherIDDC.text =OtherID;
	//        emailDC.text = Email;
	//        mobileNoPrefixDC.text =ContactNoPrefic;
	//        mobileNoDC.text =ContactNo;
	//
	//
	//
	//        //    results2 = [db executeQuery:@"select LAName from eProposal_LA_Details where POFlag = ? and eProposalNo = ?", @"Y", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
	//        //    while ([results2 next])
	//        //    {
	//        //
	//        //    isPOSign =[results2 stringForColumn:@"LANewICNo"];
	//        //    DatePOSign =[results2 stringForColumn:@"PTypeCode"];
	//        //    }
	//
	//
	//    }
    
}

- (IBAction)ActionForSameAsFT:(id)sender {
	
	_isSameAsFT = !_isSameAsFT;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
	if(_isSameAsFT)
    {
		[_btnSameAsFT setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecB"] setValue:@"TRUE" forKey:@"SameAsFT"];
		_personTypeLbl.text = _FTpersonTypeLbl.text;
		_bankLbl.text = _FTbankLbl.text;
		_cardTypeLbl.text = _FTcardTypeLbl.text;
		_accNoTF.text = _FTaccNoTF.text;
		//_accNoTF.enabled = NO;
		_expiryDateTF.text = _FTexpiryDateTF.text;
		_expiryDateYearTF.text = _FTexpiryDateYearTF.text;
		
		_memberNameTF.text = _FTmemberNameTF.text;
		_memberSexSC.selectedSegmentIndex = _FTmemberSexSC.selectedSegmentIndex;
		_memberDOBLbl.text = _FTmemberDOBLbl.text ;
		_memberIC.text = _FTmemberIC.text;
		_memberOtherIDTypeLbl.text = _FTmemberOtherIDTypeLbl.text;
		IDTypeCodeSelected = FTIDTypeCodeSelected;
		_memberOtherIDTF.text = _FTmemberOtherIDTF.text;
		_memberContactNoTF.text = _FTmemberContactNoTF.text;
		_memberContactNoPrefixCF.text = _FTmemberContactNoPrefixCF.text;
		_memberRelationshipLbl.text = _FTmemberRelationshipLbl.text;
		
		_btnPersonTypePO.enabled = FALSE;
		_btnBankPO.enabled = FALSE;
		_btnCardTypePO.enabled = FALSE;
		_expiryDateTF.enabled = FALSE;
		_expiryDateYearTF.enabled = FALSE;
		
		_accNoTF.enabled = FALSE;
		_expiryDateTF.enabled = FALSE;
		_expiryDateYearTF.enabled = FALSE;
		_memberNameTF.enabled = FALSE;
		_memberSexSC.enabled = FALSE;
		_btnMemberDOBPO.enabled = FALSE;
		_memberIC.enabled = FALSE;
		_btnMemberOtherIDType.enabled = FALSE;
		_memberOtherIDTF.enabled = FALSE;
		_memberContactNoTF.enabled = FALSE;
		_memberContactNoPrefixCF.enabled = FALSE;
		_btnMemberRelationshipPO.enabled = FALSE;
		
		_personTypeLbl.textColor = [UIColor grayColor];
		_bankLbl.textColor = [UIColor grayColor];
		_cardTypeLbl.textColor = [UIColor grayColor];
		_accNoTF.textColor = [UIColor grayColor];
		_expiryDateTF.textColor = [UIColor grayColor];
		_expiryDateYearTF.textColor = [UIColor grayColor];
		
		_memberNameTF.textColor = [UIColor grayColor];
		_memberDOBLbl.textColor = [UIColor grayColor];
		_memberIC.textColor = [UIColor grayColor];
		_memberOtherIDTypeLbl.textColor = [UIColor grayColor];
		_memberOtherIDTF.textColor = [UIColor grayColor];
		_memberContactNoTF.textColor = [UIColor grayColor];
		_memberContactNoPrefixCF.textColor = [UIColor grayColor];
		_memberRelationshipLbl.textColor = [UIColor grayColor];
		
	}
	else {
		
		[_btnSameAsFT setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecB"] setValue:@"FALSE" forKey:@"SameAsFT"];
		
		_personTypeLbl.text = @"";
		_bankLbl.text = @"";
		_cardTypeLbl.text = @"";
		_accNoTF.text = @"";
		//_accNoTF.enabled = NO;
		_expiryDateTF.text = @"";
		_expiryDateYearTF.text = @"";
		
		_memberNameTF.text = @"";
		_memberSexSC.selectedSegmentIndex = -1;
		_memberDOBLbl.text = @"";
		_memberIC.text = @"";
		_memberOtherIDTypeLbl.text = @"";
		_memberOtherIDTF.text = @"";
		_memberContactNoTF.text = @"";
		_memberContactNoPrefixCF.text = @"";
		_memberRelationshipLbl.text = @"";
		
		_btnPersonTypePO.enabled = YES;
		_accNoTF.enabled = YES;
		_expiryDateTF.enabled = YES;
		_expiryDateYearTF.enabled = YES;
		_btnMemberRelationshipPO.enabled = YES;
		
		_personTypeLbl.textColor = [UIColor blackColor];
		_personTypeLbl.textColor = [UIColor blackColor];
		_bankLbl.textColor = [UIColor blackColor];
		_cardTypeLbl.textColor = [UIColor blackColor];
		_accNoTF.textColor = [UIColor blackColor];
		_expiryDateTF.textColor = [UIColor blackColor];
		_expiryDateYearTF.textColor = [UIColor blackColor];
		
		_memberNameTF.textColor = [UIColor blackColor];
		_memberDOBLbl.textColor = [UIColor blackColor];
		_memberIC.textColor = [UIColor blackColor];
		_memberOtherIDTypeLbl.textColor = [UIColor blackColor];
		_memberOtherIDTF.textColor = [UIColor blackColor];
		_memberContactNoTF.textColor = [UIColor blackColor];
		_memberContactNoPrefixCF.textColor = [UIColor blackColor];
		_memberRelationshipLbl.textColor = [UIColor blackColor];
	}
}

-(BOOL)ShoudEnableSameAsCdt {
	
	BOOL personType = [_FTpersonTypeLbl.text isEqualToString:@""];
	BOOL bankLbl = [_FTbankLbl.text isEqualToString:@""];
	BOOL cardtype = [_FTcardTypeLbl.text isEqualToString:@""];
	BOOL cardAccNo = [_FTaccNoTF.text isEqualToString:@""];
	BOOL xpiredDtMonth = [_FTexpiryDateTF.text isEqualToString:@""];
	BOOL xpiredDtYear = [_FTexpiryDateYearTF.text isEqualToString:@""];
	BOOL nameTF = [_FTmemberNameTF.text isEqualToString:@""];
	BOOL gender = (_FTmemberSexSC.selectedSegmentIndex == -1);
	BOOL DOB = [_FTmemberDOBLbl.text isEqualToString:@""];
	BOOL NOIC = [_FTmemberIC.text isEqualToString:@""];
	//BOOL IdType = [_FTmemberOtherIDTypeLbl.text isEqualToString:@""];
	//BOOL OtherId = [_FTmemberOtherIDTF.text isEqualToString:@""];
	BOOL contNo = [_FTmemberContactNoTF.text isEqualToString:@""];
	BOOL PreficContNo = [_FTmemberContactNoPrefixCF.text isEqualToString:@""];
	BOOL relationship = [_FTmemberRelationshipLbl.text isEqualToString:@""];
	
	if (personType && bankLbl && cardtype && cardAccNo && xpiredDtMonth && xpiredDtYear && nameTF && gender && DOB && NOIC
		&& contNo && PreficContNo && relationship ) {
		NSLog(@"FTCard NOT complete");
		return FALSE;
	}
	else {
		NSLog(@"FTCard complete");
		return TRUE;
	}
}


#pragma mark - delegate

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	if (!isFTPayment)
		_memberDOBLbl.text = strDate;
	else
		_FTmemberDOBLbl.text = strDate;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
	if (!isFTPayment) {
		_memberOtherIDTypeLbl.text = selectedIDType;
		//	_memberOtherIDTypeLbl.textColor = [UIColor blackColor];
		[self.IDTypePopover dismissPopoverAnimated:YES];
		_memberOtherIDTF.enabled = YES;
		//_memberIC.text = @"";
		//_memberIC.enabled = NO;
		
		if ([_memberOtherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_memberOtherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_memberOtherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _memberOtherIDTypeLbl.text == NULL || [_memberOtherIDTypeLbl.text isEqualToString:@""] || [_memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
			//_nricLbl.text = @"";
			_memberIC.enabled = YES;
		}
		else {
            if (_memberSexSC.enabled  == NO) {
				_memberSexSC.selectedSegmentIndex = -1;
				_memberDOBLbl.text = @"";
            }
            
			_memberSexSC.enabled = YES;
            _memberDOBLbl.enabled=YES;
            _btnMemberDOBPO.enabled=YES;
			
			_memberDOBLbl.textColor = [UIColor blackColor];
			
            _memberIC.text = @"";
			_memberIC.enabled = NO;
			
			
		}
		
		if([_memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"])
		{
			_memberOtherIDTF.enabled =NO;
			_memberOtherIDTF.text =@"";
			NSLog(@"error");
		}
		
		if([_memberOtherIDTypeLbl.text isEqualToString:@""] || _memberOtherIDTypeLbl.text==nil)
		{
			_memberOtherIDTF.enabled =NO;
			NSLog(@"error1");
		}
	}
	else {
		_FTmemberOtherIDTypeLbl.text = selectedIDType;
		[self.IDTypePopover dismissPopoverAnimated:YES];
		_FTmemberOtherIDTF.enabled = YES;
		
		
		if ([_FTmemberOtherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _FTmemberOtherIDTypeLbl.text == NULL || [_FTmemberOtherIDTypeLbl.text isEqualToString:@""] || [_FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
			//_nricLbl.text = @"";
			_FTmemberIC.enabled = YES;
            
            
		}
		else {
            
            if (_FTmemberSexSC.enabled == NO) {
				_FTmemberSexSC.selectedSegmentIndex = -1;
				_FTmemberDOBLbl.text = @"";
            }
            _FTmemberSexSC.enabled = YES;
            _FTmemberDOBLbl.enabled=YES;
            _FTbtnMemberDOBPO.enabled=YES;
            
			_FTmemberDOBLbl.textColor = [UIColor blackColor];
			
            _FTmemberIC.text = @"";
			_FTmemberIC.enabled = NO;
            
            
            
			
		}
		
		if([_FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"])
		{
			_FTmemberOtherIDTF.enabled =NO;
			_FTmemberOtherIDTF.text =@"";
		}
		
		if([_FTmemberOtherIDTypeLbl.text isEqualToString:@""] || _FTmemberOtherIDTypeLbl.text==nil)
		{
			_FTmemberOtherIDTF.enabled =NO;
		}
	}
	
	
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	if (!isFTPayment)
		IDTypeCodeSelected = IDTypeCode;
	else
		FTIDTypeCodeSelected = IDTypeCode;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
	if (textField == _FTmemberContactNoPrefixCF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	if (textField == _accNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ACCNO));
	}
    else if (textField == _FTaccNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ACCNO));
	}
    
    else if (textField == DCAccNo) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 20));
	}
    
	else if (textField == _memberIC) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else if (textField == _expiryDateTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_EXP_DATE_M));
	}
	else if (textField == _expiryDateYearTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
	else if (textField == _memberContactNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
		//		&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
    else if (textField == _memberContactNoPrefixCF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _FTmemberIC) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else if (textField == _FTexpiryDateTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_EXP_DATE_M));
	}
	else if (textField == _FTexpiryDateYearTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
	else if (textField == _FTmemberContactNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
		//		&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
    else if (textField.tag == 1001) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 13));
    }
    else if (textField == _agentContactNoTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
    else if (textField == _agentContactNoPrefixTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	if (textField == _memberNameTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHARONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_CARD_NAME));
	}
	if (textField == _FTmemberNameTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHARONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_CARD_NAME));
	}
    
	NSUInteger newLength1 = [textField.text length] + [string length] - range.length;
	if (textField == _FTmemberOtherIDTF) {
        return ((newLength1 <= CHARACTER_LIMIT_OTHERIDFT));
    }
	
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField == _memberOtherIDTF) {
        return ((newLength <= CHARACTER_LIMIT_OTHERIDRP));
    }
	
	if (textField == _agentCodeTF){
		return ((newLength <= CHARACTER_LIMIT_AGENTCODE));
	}
	
	if (textField == _agentNameTF){
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHARONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 50));
	}
    
    else if (textField == emailDC) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        return ((newLength <= CHARACTER_LIMIT_ExactDuties));
		
	}
    
    else if (textField == mobileNoDC) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
        //		&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
    else if (textField == mobileNoPrefixDC) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	
	else return YES;
}

-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	UITextField *textField = (UITextField*)sender;
	if (_isSameAsFT) {
		if (textField == _FTaccNoTF)
			_accNoTF.text = _FTaccNoTF.text;
		else if (textField == _FTexpiryDateTF)
			_expiryDateTF.text = _FTexpiryDateTF.text;
		else if (textField == _FTexpiryDateYearTF)
			_expiryDateYearTF.text = _FTexpiryDateYearTF.text;
		else if (textField == _FTmemberNameTF)
			_memberNameTF.text = _FTmemberNameTF.text;
		else if (textField == _FTmemberIC){
			_memberIC.text = _FTmemberIC.text;
			[self actionForICNo:_memberIC];
		}
		else if (textField == _FTmemberOtherIDTF)
			_memberOtherIDTF.text = _FTmemberOtherIDTF.text;
		else if (textField == _FTmemberContactNoTF)
			_memberContactNoTF.text = _FTmemberContactNoTF.text;
		else if (textField == _FTmemberContactNoPrefixCF)
			_memberContactNoPrefixCF.text = _FTmemberContactNoPrefixCF.text;
	}
	
	if (textField == _memberIC) {
		if (_memberIC.text.length < 12) {
			if (_memberSexSC.enabled == FALSE) {
				_memberSexSC.selectedSegmentIndex = -1;
				_memberDOBLbl.text =@"";
				_memberDOBLbl.textColor = [UIColor blackColor];
			}
			_memberSexSC.enabled = TRUE;
			_btnMemberDOBPO.enabled = TRUE;
		}
		else if (_memberIC.text.length == 12) {
			_memberSexSC.enabled = NO;
			_btnMemberDOBPO.enabled = NO;
		}
	}
	if (textField == _FTmemberIC) {
		if (_FTmemberIC.text.length < 12) {
			if (_FTmemberSexSC.enabled == FALSE) {
				_FTmemberSexSC.selectedSegmentIndex =-1;
				_FTmemberDOBLbl.text =@"";
				_FTmemberDOBLbl.textColor = [UIColor blackColor];
			}
			_FTmemberSexSC.enabled = TRUE;
			_FTbtnMemberDOBPO.enabled = TRUE;
		}
		else if (_FTmemberIC.text.length == 12) {
			_FTmemberSexSC.enabled = NO;
			_FTbtnMemberDOBPO.enabled = NO;
		}
	}
}

#pragma mark - fund maturity

-(void)dasd{
	
	NSString *query = [NSString stringWithFormat:@"Select VU2023,VU2025,VU2028,VU2030,VU2035,VUCash,VUDana,VURet,VURetOpt, VUCashOpt,VUDanaOpt From UL_Details "
                       " WHERE sino = '%@'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]];
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
	NSString *F2025, *F2028, *F2030, *F2035, *FDana, *FRet, *FCash, *FDanaOpt, *FRetOpt, *FCashOpt;
	
	
    results = [database executeQuery:query];
    //if (results != Nil){
    while ([results next]) {
        F2025 =  [results stringForColumn:@"VU2025"];
        F2028 =  [results stringForColumn:@"VU2028"];
        F2030 = [results stringForColumn:@"VU2030"];
		F2035 =  [results stringForColumn:@"VU2035"];
		FDana =  [results stringForColumn:@"VUDana"];
        FRet =  [results stringForColumn:@"VURet"];
		FCash =  [results stringForColumn:@"VUCash"];
		FDanaOpt = [results stringForColumn:@"VUDanaOpt"];
        FRetOpt =  [results stringForColumn:@"VURetOpt"];
		FCashOpt = [results stringForColumn:@"VUCashOpt"];
    }
    //}
	
	
	if( [F2025 intValue] != 0){
		
        
		[aDesc addObject:@"Commencement Date to 25/11/2025"];
		[a2025 addObject:F2025];
		[a2028 addObject:F2028];
		[a2030 addObject:F2030];
		[a2035 addObject:F2035];
		[aDana addObject:FDana];
		[aRet addObject:FRet];
		[aCash addObject:FCash];
		
		
	}
	
	if( [F2028 intValue] != 0){
		if([F2025 intValue] == 0 ){
			
			[aDesc addObject:@"Commencement Date to 25/11/2028"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:F2028];
			[a2030 addObject:F2030];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
		}
		else {
			
			double tempTotal = [F2028 intValue] + [F2030 intValue] + [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2028 intValue] + ([F2028 intValue]/tempTotal * [F2025 intValue]);
			double tempB = [F2030 intValue] + ([F2030 intValue]/tempTotal * [F2025 intValue]);
			double tempC = [F2035 intValue] + ([F2035 intValue]/tempTotal * [F2025 intValue]);
			double tempD = [FDana intValue] + ([FDana intValue]/tempTotal * [F2025 intValue]);
			double tempE = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue]);
			double tempF = [FCash intValue];
			
			
			if(tempA + tempB + tempC + tempD + tempE + tempF != 100) {
				tempC = 100 - tempA - tempB - tempD - tempE - tempF;
				//tempC = round2Decimal(tempC);
			}
			
			[aDesc addObject:@"26/11/2025 to 25/11/2028"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[a2030 addObject:[NSString stringWithFormat:@"%f", tempB]];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempD]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempE]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempF]];
			
            
		}
	}
	
	if([F2030 intValue] != 0){
		if([F2025 intValue] == 0 && [F2028 intValue] == 0 ){
			
			[aDesc addObject:@"Commencement Date to 25/11/2030"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:F2030];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
		}
		else {
			double tempTotal = [F2030 intValue] + [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2030 intValue] + ([F2030 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]);
			double tempB = [F2035 intValue] + ([F2035 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]);
			double tempC = [FDana intValue] + ([FDana intValue]/tempTotal *	 [F2025 intValue] + [F2028 intValue]);
			double tempD = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]);
			double tempE = [FCash intValue];
			
			
			
			if(tempA + tempB + tempC + tempD + tempE != 100) {
				tempB = 100 - tempA - tempC - tempD - tempE;
				//tempB = round2Decimal(tempB);
			}
			
			[aDesc addObject:@"26/11/2028 to 25/11/2030"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempB]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempD]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempE]];
			
            
		}
	}
	
	if( [F2035 intValue] != 0){
		if([F2025 intValue] == 0 && [F2028 intValue] == 0 && [F2030 intValue] == 0 ){
			
			[aDesc addObject:@"Commencement Date to 25/11/2035"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:@"0.00"];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
            
		}
		else {
			double tempTotal = [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2035 intValue] + ([F2035 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempB = [FDana intValue] + ([FDana intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempC = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempD = [FCash intValue];
			
			if(tempA + tempB + tempC + tempD != 100) {
				tempA = 100 - tempB - tempC - tempD;
				//tempA = round2Decimal(tempA);
			}
			
			[aDesc addObject:@"26/11/2030 to 25/11/2035"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:@"0.00"];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempB]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempD]];
            
            
		}
	}
	
	if([FCashOpt intValue] != 0){
		NSString *tempFund;
		
		if([F2035 intValue] != 0){
			tempFund = @"26/11/2035 to Policy Maturity Date";
		}
		else if([F2030 intValue] != 0){
			tempFund = @"26/11/2030 to Policy Maturity Date";
		}
		else if([F2028 intValue] != 0){
			tempFund = @"26/11/2028 to Policy Maturity Date";
		}
		else if([F2025 intValue] != 0){
			tempFund = @"26/11/2025 to Policy Maturity Date";
		}
		
		
		
		[aDesc addObject:tempFund];
		[a2025 addObject:@"0.00"];
		[a2028 addObject:@"0.00"];
		[a2030 addObject:@"0.00"];
		[a2035 addObject:@"0.00"];
		[aDana addObject:FDanaOpt];
		[aRet addObject:FRetOpt];
		[aCash addObject:FCashOpt];
        
	}
	else{
		double tempTotal = [FRet intValue] + [FDana intValue];
        
		[aDesc addObject:@"26/11/2035 to Policy Maturity Date"];
		[a2025 addObject:@"0.00"];
		[a2028 addObject:@"0.00"];
		[a2030 addObject:@"0.00"];
		[a2035 addObject:@"0.00"];
		[aDana addObject:[NSString stringWithFormat:@"%f", [FDana intValue] + ([FDana intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue] + [F2030 intValue] + [F2035 intValue]) ]];
		[aRet addObject:[NSString stringWithFormat:@"%f", [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]+ [F2030 intValue] + [F2035 intValue])]];
		[aCash addObject:FCash];
	}
}

#pragma mark - memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setDOBLbl:nil];
    [self setPart3:nil];
	[self setBtnLevelFace:nil];
	[self setBtnFacePlus:nil];
	[self setBtnVeryDyn:nil];
	[self setBtnModDyn:nil];
	[self setBtnDyn:nil];
	[self setBtnBalanced:nil];
	[self setBtnLIEN:nil];
	[self setBtnPremDeposit:nil];
	[self setBtnFuturePrem:nil];
	[self setBtnTopUp:nil];
	[self setFirstTimePaymentLbl:nil];
	[self setRecurPaymentLbl:nil];
	[self setBtnFirstPaymentPO:nil];
	[self setBtnRecurPaymentPO:nil];
	[self setDeductSC:nil];
    [self setEPPSC:nil];
    [self setPersonTypeLbl:nil];
    [self setBtnPersonTypePO:nil];
    [self setBankLbl:nil];
    [self setBtnBankPO:nil];
    [self setCardTypeLbl:nil];
    [self setBtnCardTypePO:nil];
    [self setAccNoTF:nil];
    [self setExpiryDateTF:nil];
    [self setMemberNameTF:nil];
    [self setMemberSexSC:nil];
    [self setMemberDOBLbl:nil];
    [self setMemberIC:nil];
    [self setMemberOtherIDTypeLbl:nil];
    [self setBtnMemberOtherIDType:nil];
    [self setMemberOtherIDTF:nil];
    [self setMemberContactNoTF:nil];
    [self setMemberRelationshipLbl:nil];
    [self setBtnMemberRelationshipPO:nil];
	[self setAlertFirstPaymentLbl:nil];
	[self setBtnMemberDOBPO:nil];
	[self setPaymentModeSC:nil];
	[self setBasicPlanLbl:nil];
	[self setTermLbl:nil];
	[self setSumAssuredLbl:nil];
	[self setBasicPremLbl:nil];
	[self setTotalPremLbl:nil];
	[self setBasicUnitAccLbl:nil];
	[self setRiderUnitAccLbl:nil];
	[self setBasicPlanRiderTblV:nil];
	[self setPaidUpOptionSC:nil];
	[self setPaidUpTermLbl:nil];
	[self setSumAssuredSC:nil];
	[self setRevisedAmountLbl:nil];
	[self setAgentCodeTF:nil];
	[self setAgentContactNoTF:nil];
	[self setAgentNameTF:nil];
	[self setFundAllocTblV:nil];
	[self setLIENTblV:nil];
	[self setExpiryDateYearTF:nil];
	[self setInvestmentPeriodLbl:nil];
    [self setSrvTaxLbl:nil];
    [self setTotalPremTaxLbl:nil];
    [self setAgentContactNoPrefixTF:nil];
    [self setMemberContactNoPrefixCF:nil];
    [self setTckbuttonPolicyBankDetails:nil];
    [self setDCBankName:nil];
    [self setDCAccountType:nil];
    [self setDCAccNo:nil];
    [self setPayeeType:nil];
    [self setDCNewIcNo:nil];
    [self setOtherIDTypeDc:nil];
    [self setOtherIDDC:nil];
    [self setEmailDC:nil];
    [self setMobileNoPrefixDC:nil];
    [self setMobileNoDC:nil];
    [self setDCAccNo:nil];
    [super viewDidUnload];
}

- (IBAction)ActionOtherIdDC:(id)sender {
}

//- (IBAction)TckPolicyBankDetails:(id)sender {
//}

- (IBAction)ActionBankNameDC:(id)sender
{
    [self hideKeyboard];
	isDCPayment = TRUE;
    
	_WhatBAnktype =@"DC";
	
	if (_IssuingBankVC == nil) {
        
        self.IssuingBankVC = [[IssuingBankPopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _IssuingBankVC.delegate = self;
        self.IssuingBankPopover = [[UIPopoverController alloc] initWithContentViewController:_IssuingBankVC];
    }
    
    [self.IssuingBankPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}



- (IBAction)ActionAccountTypeDC:(id)sender {
    
    [self hideKeyboard];
	isDCPayment = TRUE;
    _WhatAccountType =@"DC";
	if (_CardTypeVCDC == nil) {
        
        self.CardTypeVCDC = [[CardTypePopoverVCDC alloc] initWithStyle:UITableViewStylePlain];
        _CardTypeVCDC.delegate = self;
        self.CardTypePopoverDC = [[UIPopoverController alloc] initWithContentViewController:_CardTypeVCDC];
    }
    
    [self.CardTypePopoverDC presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}
@end
