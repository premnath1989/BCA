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

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 15
#define CHARACTER_LIMIT_ACCNO 16
#define CHARACTER_LIMIT_ICNO 12
#define CHARACTER_LIMIT_EXP_DATE_M 2
#define CHARACTER_LIMIT_EXP_DATE_Y 4

@interface PolicyDetails () {
	DataClass *obj;
    bool isCompany;
}

@end

@implementation PolicyDetails
@synthesize DOBLbl,OtherIDLbl;
@synthesize SIDatePopover =_SIDatePopover;
@synthesize SIDate = _SIDate;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize IDTypeVC = _IDTypeVC;



- (void)viewDidLoad
{

    [super viewDidLoad];
    
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

    NSString *path = [docsDir stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results = Nil;
//	results = [database executeQuery:@"select * from Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	results = [database executeQuery:@"select * from Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	while ([results next]) {
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results stringForColumn:@"BasicSA"] forKey:@"SumAssured"];
	}
	
	results2 = Nil;
//	results2 = [database executeQuery:@"select count(*) as count from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Cash Promise"]) {
        results2 = [database executeQuery:@"select count(*) as count from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife"]) {
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
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Cash Promise"]) {
        results2 = [database executeQuery:@"select * from Trad_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife"]) {
        results2 = [database executeQuery:@"select * from UL_Rider_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    }
	

	while ([results2 next]) {
		type = [results2 stringForColumn:@"PTypeCode"];
		name = [results2 stringForColumn:@"RiderCode"];
		term = [results2 stringForColumn:@"RiderTerm"];
		sumAssured = [results2 stringForColumn:@"SumAssured"];
		[tempRPersonType addObject:type];
		[tempRName addObject:name];
		[tempRTerm addObject:term];
		[tempRSumAssured addObject:sumAssured];
//		[riderData addObject:tempRPersonType];
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife"]) {
            tempRMPAnnually = [[NSMutableArray alloc] init];
            tempRMPSemiAnnually = [[NSMutableArray alloc] init];
            tempRMPQuarterly = [[NSMutableArray alloc] init];
            tempRMPMonthly = [[NSMutableArray alloc] init];
            
            modalPremiumAnnually = [results2 stringForColumn:@"Premium"];
            modalPremiumSemiAnnually = [results2 stringForColumn:@"Premium"];
            modalPremiumQuarterly = [results2 stringForColumn:@"Premium"];
            modalPremiumMonthly = [results2 stringForColumn:@"Premium"];
            
            [tempRMPAnnually addObject:modalPremiumAnnually];
            [tempRMPSemiAnnually addObject:modalPremiumSemiAnnually];
            [tempRMPQuarterly addObject:modalPremiumQuarterly];
            [tempRMPMonthly addObject:modalPremiumMonthly];
            
            for (id modal in tempRMPMonthly) {
                NSLog(@"premium %@", modal);
            }
        }
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
	}
	
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Cash Promise"]) {
        tempRMPAnnually = [[NSMutableArray alloc] init];
        tempRMPSemiAnnually = [[NSMutableArray alloc] init];
        tempRMPQuarterly = [[NSMutableArray alloc] init];
        tempRMPMonthly = [[NSMutableArray alloc] init];
        NSString * strComma = [tempRName componentsJoinedByString:@"\", \""];
        NSString * sql = [NSString stringWithFormat:@"SELECT * FROM SI_Store_Premium WHERE SINo = '%@' and Type IN (\"%@\")", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], strComma];
        results2 = Nil;
        results2 = [database executeQuery:sql];
        while ([results2 next]) {
            modalPremiumAnnually = [results2 stringForColumn:@"Annually"];
            modalPremiumSemiAnnually = [results2 stringForColumn:@"SemiAnnually"];
            modalPremiumQuarterly = [results2 stringForColumn:@"Quarterly"];
            modalPremiumMonthly = [results2 stringForColumn:@"Monthly"];
            
            [tempRMPAnnually addObject:modalPremiumAnnually];
            [tempRMPSemiAnnually addObject:modalPremiumSemiAnnually];
            [tempRMPQuarterly addObject:modalPremiumQuarterly];
            [tempRMPMonthly addObject:modalPremiumMonthly];
            
            for (id modal in tempRMPMonthly) {
                NSLog(@"premium %@", modal);
            }
        }
    }
    
	results2 = Nil;
	results2 = [database executeQuery:@"select Annually as SA from SI_Store_Premium where Type != ? and Type != ? and Type != ? union select Annually as SA from SI_Store_Premium where Type = ? and FromAge is ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], @"B", @"BOriginal", @"HMM", @"HMM", @"", Nil];
	NSNumber *sum;

	while ([results2 next]) {
		sum = [NSNumber numberWithDouble:[results2 doubleForColumn:@"SA"]];
		NSLog(@"SUM IN: %@", sum);
		
	}
	NSLog(@"SUM OUT: %@", sum);
	
//	NSLog(@"bbb");
//	for (id gg in riderData) {
//		NSLog(@"type : %@", [gg objectAtIndex:0]);
//		NSLog(@"name : %@", [gg objectAtIndex:1]);
//		NSLog(@"term : %@", [gg objectAtIndex:2]);
//		NSLog(@"sumAssured : %@", [gg objectAtIndex:3]);
//		[[obj.eAppData objectForKey:@"SecB"] setValue:[gg objectAtIndex:0] forKey:@"RiderPersonType"];
//		[[obj.eAppData objectForKey:@"SecB"] setValue:[gg objectAtIndex:1] forKey:@"RiderName"];
//		[[obj.eAppData objectForKey:@"SecB"] setValue:[gg objectAtIndex:2] forKey:@"RiderTerm"];
//		[[obj.eAppData objectForKey:@"SecB"] setValue:[gg objectAtIndex:3] forKey:@"RiderSumAssured"];
//	}
//	NSLog(@"fffffff");
	
    //check POType whether if its Company or Personal
    results2 = nil;
    results2 = [database executeQuery:@"select POType from eProposal_LA_Details where PTypeCode = ? and eProposalNo = ?", @"PO", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
    while ([results2 next]) {
        if ([[results2 objectForColumnName:@"POType"] isEqualToString:@"C"]) {
            isCompany = TRUE;
        }
        else {
            isCompany = FALSE;
        }
    }
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Cash Promise"]) {
        _basicPlanLbl.text = @"HLA Cash Promise";
        _termLbl.text = @"25";
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife"]) {
        results2 = nil;
        results2 = [database executeQuery:@"select ReducedYear, Amount from UL_ReducedPaidUp where SINO = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
        while ([results2 next]) {
            [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 objectForColumnName:@"Amount"] forKey:@"RevisedAmount"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 objectForColumnName:@"ReducedYear"] forKey:@"PaidUpTerm"];
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
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA Cash Promise"]) {
        _basicPlanLbl.text = @"HLA Cash Promise";
        _termLbl.text = @"25";
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife"]) {
        _basicPlanLbl.text = @"HLA EverLife";
        _termLbl.text = @"49";
    }
		_sumAssuredLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SumAssured"];
//		_basicPremLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"];
		_totalPremLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalPremium"];
		_basicUnitAccLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicUnitAcc"];
		_riderUnitAccLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RiderUnitAcc"];
//	}
//	else {
//		_basicPlanLbl.text = @"Basic Plan";
//		_basicPlanLbl.textColor = [UIColor lightGrayColor];
//		_termLbl.text = @"Term";
//		_termLbl.textColor = [UIColor lightGrayColor];
//		_sumAssuredLbl.text = @"Sum Assured (RM)";
//		_sumAssuredLbl.textColor = [UIColor lightGrayColor];
//		_basicPremLbl.text = @"Basic Premium (RM)";
//		_basicPremLbl.textColor = [UIColor lightGrayColor];
//		_totalPremLbl.text = @"Total Premium (RM)";
//		_totalPremLbl.textColor = [UIColor lightGrayColor];
//		_basicUnitAccLbl.text = @"Basic Unit Account (RM)";
//		_basicUnitAccLbl.textColor = [UIColor lightGrayColor];
//		_riderUnitAccLbl.text = @"Rider Unit Account (RM)";
//		_riderUnitAccLbl.textColor = [UIColor lightGrayColor];
//	}

	
	
	
	//
	//regular top-up option
	
	
	//
	//source of payment
	_firstTimePaymentLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"];
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"Y"]) {
		_deductSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"] isEqualToString:@"N"]) {
		_deductSC.selectedSegmentIndex = 1;
	}
	_recurPaymentLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RecurringPayment"];
	//
	//credit card details
	_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"];
	_bankLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
	_cardTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
	_accNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"];
	_expiryDateTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MonthExpiryDate"];
	_expiryDateYearTF = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"YearExpiryDate"];
	_memberNameTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"];
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"M"]) {
		_memberSexSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"] isEqualToString:@"F"]) {
		_memberSexSC.selectedSegmentIndex = 1;
	}
	_memberDOBLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"];
	_memberIC.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"];
	_memberOtherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"];
	_memberOtherIDTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"];
	_memberContactNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"];
	_memberRelationshipLbl.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"];
	//
	//fully / reduced paid up
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
	}
	//
	//for shared case from same direct unit
	_agentCodeTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentCode"];
	_agentContactNoTF.text = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentContactNo"];
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
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"LIEN"] isEqualToString:@"Y"]) {
		[_btnLIEN setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"LIEN"] isEqualToString:@"N"]) {
		[_btnLIEN setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	//
	
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//		return [_ProposalNo count];
	if (section == 3) {
//		NSLog(@"ghj### %d", [tempRPersonType count]);
		return [tempRPersonType count];
//		return 1;
	}
	else if (section == 10) {
		return 1;
	}
	else if (section == 13) {
		return 1;
	}
	else {
		return [super tableView:tableView numberOfRowsInSection:section];
	}
}

- (IBAction)actionForModePayment:(id)sender {
    double totalModalPrem = 0.0;
	if (_paymentModeSC.selectedSegmentIndex == 0) {
		//		NSLog(@"###0 :%@", [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"] objectForKey:@"Annually"]);
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Annually"];
		NSLog(@"1");
		select = 1;
        for (NSString *modal in tempRMPAnnually) {
            totalModalPrem = [modal doubleValue] + totalModalPrem;
        }
	}
	else if (_paymentModeSC.selectedSegmentIndex == 1) {
		//		NSLog(@"###1");
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"SemiAnnually"];
		select = 2;
        for (NSString *modal in tempRMPSemiAnnually) {
            totalModalPrem = [modal doubleValue] + totalModalPrem;
        }
	}
	else if (_paymentModeSC.selectedSegmentIndex == 2) {
		//		NSLog(@"###2");
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Quarterly"];
		select = 3;
        for (NSString *modal in tempRMPQuarterly) {
            totalModalPrem = [modal doubleValue] + totalModalPrem;
        }
	}
	else if (_paymentModeSC.selectedSegmentIndex == 3) {
		//		NSLog(@"###3");
		_basicPremLbl.text = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PREMIUM"] objectForKey:@"Monthly"];
		select = 4;
        for (NSString *modal in tempRMPMonthly) {
            totalModalPrem = [modal doubleValue] + totalModalPrem;
        }
	}
    double basicPrem = [[_basicPremLbl.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    _totalPremLbl.text = [NSString stringWithFormat:@"%.2f", basicPrem + totalModalPrem];
    if (isCompany) {
        _srvTaxLbl.text = [NSString stringWithFormat:@"%.2f", (basicPrem + totalModalPrem)*0.06];
        _totalPremTaxLbl.text = [NSString stringWithFormat:@"%.2f", (basicPrem + totalModalPrem)*1.06];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
	if (indexPath.section == 3) {
//		if (indexPath.row == 1) {
			
//		cell = [tableView dequeueReusableCellWithIdentifier:@"DataCell" forIndexPath:indexPath];
		if ([tempRPersonType count] != 0) {
			
		
		[[cell.contentView viewWithTag:2001] removeFromSuperview ];
		[[cell.contentView viewWithTag:2002] removeFromSuperview ];
		[[cell.contentView viewWithTag:2003] removeFromSuperview ];
		[[cell.contentView viewWithTag:2004] removeFromSuperview ];
		[[cell.contentView viewWithTag:2005] removeFromSuperview ];
			[[cell.contentView viewWithTag:2006] removeFromSuperview ];
		
		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
		
		CGRect frame=CGRectMake(20,0, 100, 50);
		UILabel *label1=[[UILabel alloc]init];
		label1.frame=frame;
		label1.textAlignment = UITextAlignmentLeft;
		label1.tag = 2001;
		label1.backgroundColor = [UIColor clearColor];
		label1.font = [UIFont fontWithName:@"System" size:16];
		[cell.contentView addSubview:label1];
		
		CGRect frame2=CGRectMake(120,0, 100, 50);
		UILabel *label2=[[UILabel alloc]init];
		label2.frame=frame2;
		label2.textAlignment = UITextAlignmentLeft;
		label2.tag = 2002;
		label2.backgroundColor = [UIColor clearColor];
		label2.font = [UIFont fontWithName:@"System" size:16];
		[cell.contentView addSubview:label2];
		
		CGRect frame3=CGRectMake(220,0, 100, 50);
		UILabel *label3=[[UILabel alloc]init];
		label3.frame=frame3;
		//	NSLog(@"label 3: %@", label3.text);
		label3.textAlignment = UITextAlignmentLeft;
		label3.tag = 2003;
		label3.backgroundColor = [UIColor clearColor];
		label3.font = [UIFont fontWithName:@"System" size:16];
		[cell.contentView addSubview:label3];
		
		CGRect frame5=CGRectMake(320,0, 180, 50);
		UILabel *label5=[[UILabel alloc]init];
		label5.frame=frame5;
		label5.textAlignment = UITextAlignmentLeft;
		label5.tag = 2005;
		label5.backgroundColor = [UIColor clearColor];
		label5.font = [UIFont fontWithName:@"System" size:16];
		[cell.contentView addSubview:label5];
		
		CGRect frame6=CGRectMake(500,0, 100, 50);
		UILabel *label6=[[UILabel alloc]init];
		label6.frame=frame6;
		label6.textAlignment = UITextAlignmentCenter;
		label6.tag = 2006;
		label6.backgroundColor = [UIColor clearColor];
		label6.font = [UIFont fontWithName:@"System" size:16];
		[cell.contentView addSubview:label6];
		
		label1.text= [tempRPersonType objectAtIndex:indexPath.row];
		label2.text= [tempRName objectAtIndex:indexPath.row];
		label3.text= [tempRTerm objectAtIndex:indexPath.row];
		label5.text= [tempRSumAssured objectAtIndex:indexPath.row];
            label6.text = @"Modal";
			NSLog(@"select: %d",select);
//			label6.text = @"";
			if (select == 1) {
				NSLog(@"1");
				label6.text = [tempRMPAnnually objectAtIndex:indexPath.row];
			}
            else if (select == 2) {
                label6.text = [tempRMPSemiAnnually objectAtIndex:indexPath.row];
            }
            else if (select == 3) {
                label6.text = [tempRMPQuarterly objectAtIndex:indexPath.row];
            }
            else if (select == 4) {
                label6.text = [tempRMPMonthly objectAtIndex:indexPath.row];
            }
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
	}
	else if (indexPath.section == 10) {
		[[cell.contentView viewWithTag:2001] removeFromSuperview ];
		[[cell.contentView viewWithTag:2002] removeFromSuperview ];
		[[cell.contentView viewWithTag:2003] removeFromSuperview ];
		[[cell.contentView viewWithTag:2004] removeFromSuperview ];
		[[cell.contentView viewWithTag:2005] removeFromSuperview ];
		
		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
		
		
		CGRect frame=CGRectMake(20,0, 300, 50);
		UILabel *label1=[[UILabel alloc]init];
		label1.frame=frame;
		label1.textAlignment = UITextAlignmentLeft;
		label1.tag = 2001;
		label1.backgroundColor = [UIColor clearColor];
		label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label1];
		
		CGRect frame2=CGRectMake(300,0, 170, 50);
		UILabel *label2=[[UILabel alloc]init];
		label2.frame=frame2;
		label2.textAlignment = UITextAlignmentLeft;
		label2.tag = 2002;
		label2.backgroundColor = [UIColor clearColor];
		label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label2];
		
		CGRect frame3=CGRectMake(470,0, 190, 50);
		UILabel *label3=[[UILabel alloc]init];
		label3.frame=frame3;
		//	NSLog(@"label 3: %@", label3.text);
		label3.textAlignment = UITextAlignmentLeft;
		label3.tag = 2003;
		label3.backgroundColor = [UIColor clearColor];
		label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label3];
		
		CGRect frame5=CGRectMake(660,0, 180, 50);
		UILabel *label5=[[UILabel alloc]init];
		label5.frame=frame5;
		label5.textAlignment = UITextAlignmentLeft;
		label5.tag = 2005;
		label5.backgroundColor = [UIColor clearColor];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label5];
		
		CGRect frame6=CGRectMake(850,0, 100, 50);
		UILabel *label6=[[UILabel alloc]init];
		label6.frame=frame6;
		label6.textAlignment = UITextAlignmentCenter;
		label6.tag = 2006;
		label6.backgroundColor = [UIColor clearColor];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label6];
		
		//		label1.text= [_POName objectAtIndex:indexPath.row];
		//		label2.text= [_IDNo objectAtIndex:indexPath.row];
		//		label3.text= [_ProposalNo objectAtIndex:indexPath.row];
		//		label5.text=[_LastUpdated objectAtIndex:indexPath.row];
		//	    label6.text= [_Status objectAtIndex:indexPath.row];
		
		if (indexPath.row % 2 == 0) {
			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		}
		else {
			cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		}
		
		return cell;
	}
	else if (indexPath.section == 13) {
		[[cell.contentView viewWithTag:2001] removeFromSuperview ];
		[[cell.contentView viewWithTag:2002] removeFromSuperview ];
		[[cell.contentView viewWithTag:2003] removeFromSuperview ];
		[[cell.contentView viewWithTag:2004] removeFromSuperview ];
		[[cell.contentView viewWithTag:2005] removeFromSuperview ];
		
		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
		
		
		CGRect frame=CGRectMake(20,0, 300, 50);
		UILabel *label1=[[UILabel alloc]init];
		label1.frame=frame;
		label1.textAlignment = UITextAlignmentLeft;
		label1.tag = 2001;
		label1.backgroundColor = [UIColor clearColor];
		label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label1];
		
		CGRect frame2=CGRectMake(300,0, 170, 50);
		UILabel *label2=[[UILabel alloc]init];
		label2.frame=frame2;
		label2.textAlignment = UITextAlignmentLeft;
		label2.tag = 2002;
		label2.backgroundColor = [UIColor clearColor];
		label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label2];
		
		CGRect frame3=CGRectMake(470,0, 190, 50);
		UILabel *label3=[[UILabel alloc]init];
		label3.frame=frame3;
		//	NSLog(@"label 3: %@", label3.text);
		label3.textAlignment = UITextAlignmentLeft;
		label3.tag = 2003;
		label3.backgroundColor = [UIColor clearColor];
		label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label3];
		
		CGRect frame5=CGRectMake(660,0, 180, 50);
		UILabel *label5=[[UILabel alloc]init];
		label5.frame=frame5;
		label5.textAlignment = UITextAlignmentLeft;
		label5.tag = 2005;
		label5.backgroundColor = [UIColor clearColor];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label5];
		
		CGRect frame6=CGRectMake(850,0, 100, 50);
		UILabel *label6=[[UILabel alloc]init];
		label6.frame=frame6;
		label6.textAlignment = UITextAlignmentCenter;
		label6.tag = 2006;
		label6.backgroundColor = [UIColor clearColor];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
		[cell.contentView addSubview:label6];
		
		//		label1.text= [_POName objectAtIndex:indexPath.row];
		//		label2.text= [_IDNo objectAtIndex:indexPath.row];
		//		label3.text= [_ProposalNo objectAtIndex:indexPath.row];
		//		label5.text=[_LastUpdated objectAtIndex:indexPath.row];
		//	    label6.text= [_Status objectAtIndex:indexPath.row];
		
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
		//For Credit Card first time payment, please fill up CCOTP details in the Authorisation Form
		_alertFirstPaymentLbl.hidden = NO;
	}
	else {
		_alertFirstPaymentLbl.hidden = YES;
	}
    [self.FirstPaymentPopover dismissPopoverAnimated:YES];
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
	_recurPaymentLbl.text = selectedRecurPaymentType;
	_recurPaymentLbl.textColor = [UIColor blackColor];
	if ([_recurPaymentLbl.text isEqual:@"Credit Card Standing Instruction"]) {
		_btnPersonTypePO.enabled = YES;
		_btnBankPO.enabled = YES;
		_btnCardTypePO.enabled = YES;
		_accNoTF.enabled = YES;
		_expiryDateTF.enabled = YES;
		_expiryDateYearTF.enabled = YES;
		_ccsi = TRUE;
	}
	else {
		_btnPersonTypePO.enabled = NO;
		_btnBankPO.enabled = NO;
		_btnCardTypePO.enabled = NO;
		_accNoTF.enabled = NO;
		_expiryDateTF.enabled = NO;
		_expiryDateYearTF.enabled = NO;
		_ccsi = FALSE;
	}
    [self.RecurPaymentPopover dismissPopoverAnimated:YES];
}


- (IBAction)actionForPersonTypePO:(id)sender {
	if (_PersonTypeVC == nil) {
		
		self.PersonTypeVC = [[PersonTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
		_PersonTypeVC.delegate = self;
		self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypeVC];
	}
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedPersonType:(NSString *)selectedPersonType {
	_personTypeLbl.text = selectedPersonType;
//	_personTypeLbl.textColor = [UIColor blackColor];
	if ([_personTypeLbl.text isEqual:@"Other Payor"]) {
		_memberNameTF.enabled = YES;
		_memberSexSC.enabled = YES;
		_btnMemberDOBPO.enabled = YES;
		_memberIC.enabled = YES;
		_btnMemberOtherIDType.enabled = YES;
//		_memberOtherIDTF.enabled = YES;
		_memberContactNoTF.enabled = YES;
		_btnMemberRelationshipPO.enabled = YES;
		_op = TRUE;
	}
	else {
		_memberNameTF.enabled = NO;
		_memberSexSC.enabled = NO;
		_btnMemberDOBPO.enabled = NO;
		_memberIC.enabled = NO;
		_btnMemberOtherIDType.enabled = NO;
//		_memberOtherIDTF.enabled = NO;
		_memberContactNoTF.enabled = NO;
		_btnMemberRelationshipPO.enabled = NO;
		_op = FALSE;
	}
    [self.PersonTypePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForBankPO:(id)sender {
	if (_IssuingBankVC == nil) {
        
        self.IssuingBankVC = [[IssuingBankPopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _IssuingBankVC.delegate = self;
        self.IssuingBankPopover = [[UIPopoverController alloc] initWithContentViewController:_IssuingBankVC];
    }
    
    [self.IssuingBankPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedIssuingBank:(NSString *)selectedIssuingBank {
	_bankLbl.text = selectedIssuingBank;
//	_bankLbl.textColor = [UIColor blackColor];
    [self.IssuingBankPopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForCardTypePO:(id)sender {
	if (_CardTypeVC == nil) {
        
        self.CardTypeVC = [[CardTypePopoverVC alloc] initWithStyle:UITableViewStylePlain];
        _CardTypeVC.delegate = self;
        self.CardTypePopover = [[UIPopoverController alloc] initWithContentViewController:_CardTypeVC];
    }
    
    [self.CardTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedCardType:(NSString *)selectedCardType {
	_cardTypeLbl.text = selectedCardType;
//	_cardTypeLbl.textColor = [UIColor blackColor];
    [self.CardTypePopover dismissPopoverAnimated:YES];
}


- (IBAction)actionForMemberRelationshipPO:(id)sender {
	if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
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

-(void)selectedRelationship:(NSString *)theRelation {
	_memberRelationshipLbl.text = theRelation;
//	_memberRelationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

- (IBAction)ActionDOB:(id)sender
{
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
}

- (IBAction)ActionOtherID:(id)sender
{
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForDeathTPD:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
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

- (IBAction)actionForLIEN:(id)sender {
	isLIEN = !isLIEN;
	if(isLIEN) {
		[_btnLIEN setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else {
		[_btnLIEN setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}

}

- (IBAction)actionForExcessPrem:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {
		isPremDeposit = !isPremDeposit;
		if (isPremDeposit) {
			[_btnPremDeposit setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnPremDeposit setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
	else if (btnPressed.tag == 2) {
		isFuturePrem = !isFuturePrem;
		if (isFuturePrem) {
			[_btnFuturePrem setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnFuturePrem setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
	else if (btnPressed.tag == 3) {
		isTopUp = !isTopUp;
		if (isTopUp) {
			[_btnTopUp setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		}
		else {
			[_btnTopUp setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
	}
}


#pragma mark - delegate

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _memberDOBLbl.text = strDate;
//	_memberDOBLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    _memberOtherIDTypeLbl.text = selectedIDType;
//	_memberOtherIDTypeLbl.textColor = [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_memberOtherIDTF.enabled = YES;
	_memberIC.text = @"";
	_memberIC.enabled = NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	if (textField == _accNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ACCNO));
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
	else if (textField == _memberContactNoTF || textField == _agentContactNoTF) {
//		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered]));
//		&&(newLength <= CHARACTER_LIMIT_EXP_DATE_Y));
	}
	
	else return YES;
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
    [super viewDidUnload];
}

@end
