//
//  BasicAccountViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 6/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "BasicAccountViewController.h"
#import "EverLAViewController.h"
#import "MainScreen.h"
#import "AppDelegate.h"
#import "EverLifeViewController.h"

@interface BasicAccountViewController ()

@end

const double Anually = 1.00, Semi = 0.50, quarterly = 0.25, Monthly = 0.083333;
double TotalRiderPremium, PremiumRequired;
BOOL TPExcess;
int PolicySustainYear = 0;
/*
const double PolicyFee = 5, IncreasePrem =0, CYFactor = 1, ExcessAllo = 0.95, RegularAllo =0.95;
int YearDiff2023, YearDiff2025, YearDiff2028, YearDiff2030, YearDiff2035, CommMonth;
int MonthDiff2023, MonthDiff2025, MonthDiff2028, MonthDiff2030, MonthDiff2035;
int FundTermPrev2023, FundTerm2023, FundTermPrev2025, FundTerm2025,FundTermPrev2028, FundTerm2028;
int FundTermPrev2030, FundTerm2030, FundTermPrev2035, FundTerm2035;
int VU2023Factor,VU2025Factor,VU2028Factor,VU2030Factor,VU2035Factor,VUCashFactor,VURetFactor,VURetOptFactor,VUCashOptFactor;
int RegWithdrawalStartYear, RegWithdrawalEndYear, RegWithdrawalIntYear;
double VU2023Fac,VU2025Fac,VU2028Fac,VU2030Fac,VU2035Fac,VUCashFac,VURetFac,VURetOptFac,VUCashOptFac;
double VUCash_FundAllo_Percen,VURet_FundAllo_Percen,VU2023_FundAllo_Percen,VU2025_FundAllo_Percen;
double VU2028_FundAllo_Percen,VU2030_FundAllo_Percen, VU2035_FundAllo_Percen, RegWithdrawalAmount;
double VU2023InstHigh, VU2023InstMedian, VU2023InstLow,VU2025InstHigh, VU2025InstMedian, VU2025InstLow;
double VU2028InstHigh, VU2028InstMedian, VU2028InstLow,VU2030InstHigh, VU2030InstMedian, VU2030InstLow;
double VU2035InstHigh, VU2035InstMedian, VU2035InstLow, NegativeValueOfMaxCashFundHigh,NegativeValueOfMaxCashFundMedian,NegativeValueOfMaxCashFundLow ;
double HSurrenderValue,MSurrenderValue,LSurrenderValue,HRiderSurrenderValue,MRiderSurrenderValue,LRiderSurrenderValue;

double VUCashValueHigh, VU2023ValueHigh,VU2025ValueHigh,VU2028ValueHigh,VU2030ValueHigh;
double VU2035ValueHigh,VURetValueHigh;
double VU2023PrevValuehigh, VU2025PrevValuehigh,VU2028PrevValuehigh, VU2030PrevValuehigh, VU2035PrevValuehigh,VUCashPrevValueHigh;
double VURetPrevValueHigh;
double MonthVU2023PrevValuehigh, MonthVU2025PrevValuehigh,MonthVU2028PrevValuehigh, MonthVU2030PrevValuehigh, MonthVU2035PrevValuehigh,MonthVUCashPrevValueHigh;
double MonthVURetPrevValueHigh;
double VUCashValueMedian, VU2023ValueMedian,VU2025ValueMedian,VU2028ValueMedian,VU2030ValueMedian,VU2035ValueMedian,VURetValueMedian;
double VUCashValueLow, VU2023ValueLow,VU2025ValueLow,VU2028ValueLow,VU2030ValueLow,VU2035ValueLow,VURetValueLow;
double VU2023PrevValueMedian, VU2025PrevValueMedian,VU2028PrevValueMedian, VU2030PrevValueMedian, VU2035PrevValueMedian,VUCashPrevValueMedian;
double VURetPrevValueMedian;
double VU2023PrevValueLow, VU2025PrevValueLow,VU2028PrevValueLow, VU2030PrevValueLow, VU2035PrevValueLow,VUCashPrevValueLow;
double VURetPrevValueLow;
double MonthVU2023PrevValueMedian, MonthVU2025PrevValueMedian,MonthVU2028PrevValueMedian, MonthVU2030PrevValueMedian;
double  MonthVU2035PrevValueMedian,MonthVUCashPrevValueMedian,MonthVURetPrevValueMedian;
double MonthVU2023PrevValueLow, MonthVU2025PrevValueLow,MonthVU2028PrevValueLow, MonthVU2030PrevValueLow;
double  MonthVU2035PrevValueLow,MonthVUCashPrevValueLow,MonthVURetPrevValueLow;
double Allo2023, Allo2025,Allo2028,Allo2030,Allo2035;
double Fund2023PartialReinvest, Fund2025PartialReinvest,Fund2028PartialReinvest,Fund2030PartialReinvest,Fund2035PartialReinvest;
double MonthFundMaturityValue2023_Bull, MonthFundMaturityValue2023_Flat,MonthFundMaturityValue2023_Bear;
double MonthFundMaturityValue2025_Bull, MonthFundMaturityValue2025_Flat,MonthFundMaturityValue2025_Bear;
double MonthFundMaturityValue2028_Bull, MonthFundMaturityValue2028_Flat,MonthFundMaturityValue2028_Bear;
double MonthFundMaturityValue2030_Bull, MonthFundMaturityValue2030_Flat,MonthFundMaturityValue2030_Bear;
double MonthFundMaturityValue2035_Bull, MonthFundMaturityValue2035_Flat,MonthFundMaturityValue2035_Bear;
double Fund2023ReinvestTo2025Fac,Fund2023ReinvestTo2028Fac,Fund2023ReinvestTo2030Fac,Fund2023ReinvestTo2035Fac,Fund2023ReinvestToCashFac,Fund2023ReinvestToRetFac ;
double Fund2025ReinvestTo2028Fac,Fund2025ReinvestTo2030Fac,Fund2025ReinvestTo2035Fac,Fund2025ReinvestToCashFac,Fund2025ReinvestToRetFac ;
double Fund2028ReinvestTo2030Fac,Fund2028ReinvestTo2035Fac,Fund2028ReinvestToCashFac,Fund2028ReinvestToRetFac;
double Fund2030ReinvestTo2035Fac,Fund2030ReinvestToCashFac,Fund2030ReinvestToRetFac;
double Fund2035ReinvestToCashFac,Fund2035ReinvestToRetFac;
double temp2023High, temp2023Median,temp2023Low,temp2025High, temp2025Median,temp2025Low,temp2028High, temp2028Median,temp2028Low;
double temp2030High, temp2030Median,temp2030Low, temp2035High, temp2035Median,temp2035Low;;
double FundValueOfTheYearValueTotalHigh,FundValueOfTheYearValueTotalMedian, FundValueOfTheYearValueTotalLow;
double MonthFundValueOfTheYearValueTotalHigh,MonthFundValueOfTheYearValueTotalMedian, MonthFundValueOfTheYearValueTotalLow;
double MonthVU2023ValueHigh,MonthVU2023ValueMedian,MonthVU2023ValueLow,MonthVU2025ValueHigh,MonthVU2025ValueMedian,MonthVU2025ValueLow;
double MonthVU2028ValueHigh,MonthVU2028ValueMedian,MonthVU2028ValueLow,MonthVU2030ValueHigh,MonthVU2030ValueMedian,MonthVU2030ValueLow;
double MonthVU2035ValueHigh,MonthVU2035ValueMedian,MonthVU2035ValueLow,MonthVURetValueHigh,MonthVURetValueMedian,MonthVURetValueLow;
BOOL VUCashValueNegative;
 */
NSString *OriginalBump;

@implementation BasicAccountViewController
@synthesize outletBasic, txtBasicPremium, txtBasicSA,txtBUMP,txtCommFrom,txtFor;
@synthesize txtGrayRTUP,txtPolicyTerm,txtPremiumPayable,txtRTUP,txtTotalBAPremium;
@synthesize myScrollView, Label1, label2, labelComm, labelFor, segPremium;
@synthesize requestAge,requestAge2ndLA,requestAgePay,requestDOB2ndLA,requestDOBPay,requestIDPay,requestIDProf;
@synthesize requestIndex2ndLA,requestIndexPay,requestOccp2ndLA,requestOccpClass,requestOccpCode;
@synthesize requestOccpPay,requestSex2ndLA,requestSexPay,requestSINo,requestSmoker2ndLA,requestSmokerPay;
@synthesize ageClient,idPay,idProf,SINo,OccpClass, OccpCode, PayorAge, PayorDOB, PayorIndexNo;
@synthesize PayorOccpCode, PayorSex, PayorSmoker,secondLAAge,secondLADOB,secondLAIndexNo,secondLAOccpCode;
@synthesize secondLASex,secondLASmoker, minSA, minPremium, getPolicyTerm, getSINo, getSumAssured;
@synthesize GenderPP, SIDate, SILastNo, CustDate, CustLastNo, LACustCode, PYCustCode, planChoose, OccpCodePP, NamePP;
@synthesize DOBPP, IndexNo, termCover, secondLACustCode, getHL, getHLPct,getHLPctTerm,getHLTerm;
@synthesize getBumpMode, getBasicPrem, getPlanCode, getCommFrom, getFor,getRTUP, requestSexLA, getSexLA;
@synthesize requestSmokerLA, getSmokerLA, requestPlanCommDate, getPlanCommDate, requestDOB, getDOB;
@synthesize requestOccLoading,getOccLoading, getGrayRTUP;
@synthesize delegate = _delegate;
id AppsVersion;


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
	UL_databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"UL_Rates.sqlite"]];
	AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	
	self.planList = [[PlanList alloc] init];
    _planList.delegate = self;
	self.planList.TradOrEver = @"EVER";
	self.planPopover = [[UIPopoverController alloc] initWithContentViewController:_planList];
	
	UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
														   forKey:UITextAttributeFont];
	[segPremium setTitleTextAttributes:attributes
							   forState:UIControlStateNormal];
	
	//request LA, second LA and Payor details
	getSexLA = [self.requestSexLA description];
	ageClient = requestAge;
	OccpCode = [self.requestOccpCode description];
    OccpClass = requestOccpClass;
    idPay = requestIDPay;
    idProf = requestIDProf;
	getPlanCommDate = [self.requestPlanCommDate description];
	getSmokerLA = [self.requestSmokerLA description];
	getDOB = [self.requestDOB description];
	getOccLoading = [self.requestOccLoading description];
	
    PayorIndexNo = requestIndexPay;
    PayorSmoker = [self.requestSmokerPay description];
    PayorSex = [self.requestSexPay description];
    PayorDOB = [self.requestDOBPay description];
    PayorAge = requestAgePay;
    PayorOccpCode = [self.requestOccpPay description];
	
    secondLAIndexNo = requestIndex2ndLA;
    secondLASmoker = [self.requestSmoker2ndLA description];
    secondLASex = [self.requestSex2ndLA description];
    secondLADOB = [self.requestDOB2ndLA description];
    secondLAAge = requestAge2ndLA;
    secondLAOccpCode = [self.requestOccp2ndLA description];
	
    SINo = [self.requestSINo description];
	temp = outletBasic.titleLabel.text;
	
	[self togglePlan];
	if (self.requestSINo) {
		[self checkingExisting];
		if (getSINo.length != 0) {
			NSLog(@"view selected field");
			[self getExistingBasic];
			
			if ([getPlanCode isEqualToString:@"UV"]) {
                [self.outletBasic setTitle:@"HLA EverLife" forState:UIControlStateNormal];
                temp = outletBasic.titleLabel.text;
            }
			
			[self togglePlan];
			[self CalcTotalRiderPrem];
			[self toggleExistingField];
			
		}else {
			NSLog(@"create new");
        }
		
	} else {
        NSLog(@"SINo not exist!");
		getPlanCode = @"";
		/*
		if (ageClient > 70) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 70 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
		}
		else{
			//default plan
			[outletBasic setTitle:@"HLA EverLife" forState:UIControlStateNormal];
			txtPolicyTerm.text =  [NSString stringWithFormat:@"%d", (100 - requestAge)];
			getPlanCode = @"UV";
			// ---
		}
		*/
		
    }

	if (PayorIndexNo != 0) {
        NSLog(@"exist payor! Age:%d",PayorAge);
        IndexNo = PayorIndexNo;
        [self getProspectData];
    }
	
	
	if (secondLAIndexNo != 0) {
        NSLog(@"exist secondLA!");
        IndexNo = secondLAIndexNo;
        [self getProspectData];
        NSLog(@"2ndLAAge:%d",secondLAAge);
    }
	

	[txtBasicPremium addTarget:self action:@selector(BasicPremiumDidChanged) forControlEvents:UIControlEventAllEditingEvents];
	labelComm.hidden = YES;
	labelFor.hidden = YES;
	Label1.hidden = YES;
	label2.hidden = YES;
	txtBasicPremium.tag = 0;
	txtBasicPremium.delegate = self;
	txtBasicSA.delegate = self;
	txtBasicSA.tag = 1;
	txtCommFrom.tag = 2;
	txtFor.tag = 4;
	txtCommFrom.delegate = self;
	txtFor.delegate = self;
	txtRTUP.tag = 3;
	txtRTUP.delegate = self;
	txtBUMP.tag = 5;
	txtBUMP.delegate = self;
	myScrollView.delegate = self;
	_planList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    /*
	 self.headerTitle.frame = CGRectMake(310, -20, 149, 44);
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
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    //[formatter setCurrencySymbol:@""];
	
	if (self.requestSINo) {
		if (getSINo.length != 0){
			//txtBUMP.text = [NSString stringWithFormat:@"%.2f", [self CalculateBUMP]];
			//txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBUMP.text doubleValue]]];
			NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
			[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
			[formatter setCurrencySymbol:@""];
			[formatter setNegativeFormat:@"-"];
			[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
			
			txtTotalBAPremium.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBasicPremium.text doubleValue] + [txtGrayRTUP.text doubleValue]]];
			//txtTotalBAPremium.text = [NSString stringWithFormat:@"%.2f", [txtBasicPremium.text doubleValue ]];
			EverLifeViewController *rrr = [[EverLifeViewController alloc] init ];
			rrr.SimpleOrDetail = @"Simple";
			
			txtBUMP.text = [NSString stringWithFormat:@"%.2f", [rrr FromBasic:txtBasicPremium.text andGetHL:getHL andGetHLPct:getHLPct
																  andBumpMode:[self ReturnBumpMode] andBasicSA:txtBasicSA.text
																  andRTUPFrom:txtCommFrom.text andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
																  andSmokerLA:getSmokerLA andOccLoading:getOccLoading
															  andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
																	 andLAAge:ageClient andGrayRTUO:[txtGrayRTUP.text doubleValue ]]];
			txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBUMP.text doubleValue]]];
			//PremiumRequired = [rrr PremRequired];
			rrr = Nil;
		}
	}
	
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

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 960-264);
    self.myScrollView.contentSize = CGSizeMake(768, 960);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
	
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification{
	Label1.hidden = TRUE;
	label2.hidden = TRUE;
	self.myScrollView.frame = CGRectMake(0, 44, 768, 960);
}

#pragma mark - delegate

-(void)Planlisting:(PlanList *)inController didSelectCode:(NSString *)aaCode andDesc:(NSString *)aaDesc{
	if ([aaCode isEqualToString:@"UV"] && ageClient > 70) {
		[self.planPopover dismissPopoverAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 70 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
	else{
		[outletBasic setTitle:aaDesc forState:UIControlStateNormal ];
		[self.planPopover dismissPopoverAnimated:YES];
		txtPolicyTerm.text =  [NSString stringWithFormat:@"%d", (100 - requestAge)];
		getPlanCode = aaCode;
	}
	
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	switch (textField.tag) {
        case 0: //basic premium
			[self DisplayPremiumCondtion];
			break;
			
        case 1:
			
			[self DisplayBasicSACondtion];
            break;
			
		case 2: //txtCommFrom
			labelComm.hidden = NO;
			labelFor.hidden = NO;
			labelComm.text = [NSString stringWithFormat:@"Min: %d Max: %d", 1, 100- ageClient - 1];
			labelFor.text = [NSString stringWithFormat:@"Min: %d Max: %d", 1, 100- ageClient];
            break;
		case 3: //RTUP
			Label1.hidden = TRUE;
			label2.hidden = TRUE;
		case 4:
			labelFor.text = [NSString stringWithFormat:@"Min: %d Max: %d", 1,
							 [txtPolicyTerm.text intValue ] - [txtCommFrom.text intValue] ];
            break;
        default:
            
            break;
    }
	activeField = textField;
    return YES;
}

-(void)DisplayPremiumCondtion{
	
	Label1.hidden = FALSE;
	label2.hidden = FALSE;
	
	if (segPremium.selectedSegmentIndex == 0) {
		minPremium = 780 * Anually;
		Label1.text =  [NSString stringWithFormat:@"Min: %.0f", minPremium];
		label2.text =  [NSString stringWithFormat:@"Max: Subject to underwriting"];
	}
	else if (segPremium.selectedSegmentIndex == 1){
		minPremium= 780 * Semi;
		Label1.text =  [NSString stringWithFormat:@"Min: %.0f",  minPremium];
		label2.text=  [NSString stringWithFormat:@"Max: Subject to underwriting"];
	}
	
	else if (segPremium.selectedSegmentIndex == 2){
		minPremium = 780 * quarterly;
		Label1.text =  [NSString stringWithFormat:@"Min: %.0f",  minPremium];
		label2.text =  [NSString stringWithFormat:@"Max: Subject to underwriting"];
	}
	else if (segPremium.selectedSegmentIndex == 3){
		minPremium = 780 * Monthly;
		Label1.text =  [NSString stringWithFormat:@"Min: %.0f",  minPremium];
		label2.text =  [NSString stringWithFormat:@"Max: Subject to underwriting"];
	}
	
}

-(void)DisplayBasicSACondtion{
	Label1.hidden = FALSE;
	label2.hidden = FALSE;
	double SAFac = 0;
	
	if (requestAge < 17) {
		SAFac = 60;
	}
	else if (requestAge > 16 && requestAge < 26){ //17 - 25
		SAFac = 55;
	}
	else if (requestAge > 25 && requestAge < 36){ //26 - 35
		SAFac = 50;
	}
	else if (requestAge > 35 && requestAge < 46){ // 36 - 45
		SAFac = 35;
	}
	else if (requestAge > 45 && requestAge < 56){ //46 - 55
		SAFac = 25;
	}
	else if (requestAge > 55){
		SAFac = 15;
	}
	
	if (segPremium.selectedSegmentIndex == 1) {
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / Semi;
	}
	else if (segPremium.selectedSegmentIndex == 2){
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / quarterly;
	}
	else if (segPremium.selectedSegmentIndex == 3){
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / Monthly;
	}
	else{
		minSA =  SAFac * [txtBasicPremium.text doubleValue ];
	}
	
	//minSA = SAFac * [txtBasicPremium.text doubleValue ];
	
	Label1.text = [ NSString stringWithFormat:@"Min: %.0f", minSA];
	label2.text = @"Max: Subject to underwriting";
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
	[formatter setNegativeFormat:@"-"];
	[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
	
	EverLifeViewController *rrr = [[EverLifeViewController alloc] init ];
	rrr.SimpleOrDetail = @"Simple";
	
	if (textField.tag == 0 || textField.tag == 1 ) {
		if (![txtBasicPremium.text isEqualToString:@""] && ![txtBasicSA.text isEqualToString:@""] &&
			![txtBasicPremium.text isEqualToString:@"0"] && ![txtBasicSA.text isEqualToString:@"0"]) {
			txtBUMP.text = [NSString stringWithFormat:@"%.2f", [rrr FromBasic:txtBasicPremium.text andGetHL:getHL
																  andGetHLPct:getHLPct andBumpMode:[self ReturnBumpMode]
																   andBasicSA:txtBasicSA.text andRTUPFrom:txtCommFrom.text
																   andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
																andSmokerLA:getSmokerLA andOccLoading:getOccLoading
															  andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
																andLAAge:ageClient andGrayRTUO:[txtGrayRTUP.text doubleValue]]];
			txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBUMP.text doubleValue]]];
			PremiumRequired = [rrr PremRequired];
		}

	}
	else if (textField.tag == 2 || textField.tag == 4 || textField.tag == 3 ){
		if (![txtRTUP.text isEqualToString:@""] && ![txtCommFrom.text isEqualToString:@""] && ![txtFor.text isEqualToString:@""] &&
			![txtRTUP.text isEqualToString:@"0"] && ![txtCommFrom.text isEqualToString:@"0"] && ![txtFor.text isEqualToString:@"0"]) {
			txtBUMP.text = [NSString stringWithFormat:@"%.2f", [rrr FromBasic:txtBasicPremium.text andGetHL:getHL
																  andGetHLPct:getHLPct andBumpMode:[self ReturnBumpMode]
																   andBasicSA:txtBasicSA.text andRTUPFrom:txtCommFrom.text
																   andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
																  andSmokerLA:getSmokerLA andOccLoading:getOccLoading
															  andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
																andLAAge:ageClient andGrayRTUO:[txtGrayRTUP.text doubleValue ]]];
			txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBUMP.text doubleValue]]];
			PremiumRequired = [rrr PremRequired];
		}
	}
	
	rrr = Nil;
	
		double SAFac = 0;
	if (requestAge < 17) {
		SAFac = 60;
	}
	else if (requestAge > 16 && requestAge < 26){ //17 - 25
		SAFac = 55;
	}
	else if (requestAge > 25 && requestAge < 36){ //26 - 35
		SAFac = 50;
	}
	else if (requestAge > 35 && requestAge < 46){ // 36 - 45
		SAFac = 35;
	}
	else if (requestAge > 45 && requestAge < 56){ //46 - 55
		SAFac = 25;
	}
	else if (requestAge > 55){
		SAFac = 15;
	}
	
	if (segPremium.selectedSegmentIndex == 1) {
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / Semi;
	}
	else if (segPremium.selectedSegmentIndex == 2){
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / quarterly;
	}
	else if (segPremium.selectedSegmentIndex == 3){
		minSA = SAFac * [txtBasicPremium.text doubleValue ] / Monthly;
	}
	else{
		minSA =  SAFac * [txtBasicPremium.text doubleValue ];
	}
	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
	if ([string length ] == 0) {
		return  YES;
	}
	
	if (textField.tag == 0 || textField.tag == 3) {
		
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
		
		NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
		if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
			return NO;
		}
	}
	else{
		NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
			return NO;
		}
	}
    
	return  YES;
}

-(void)BasicPremiumDidChanged{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
	[formatter setNegativeFormat:@"-"];
	
	txtTotalBAPremium.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBasicPremium.text doubleValue] + [txtGrayRTUP.text doubleValue]]];

	//txtPremiumPayable.text = txtBasicPremium.text;
	//
	txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", [txtBasicPremium.text doubleValue ] + TotalRiderPremium];
	txtPremiumPayable.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtPremiumPayable.text doubleValue]]];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 1001 && buttonIndex == 0) {
        
	    EverLAViewController *EverLAPage  = [self.storyboard instantiateViewControllerWithIdentifier:@"EverLA"];
        MainScreen *MainScreenPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        MainScreenPage.IndexTab = 3;
		EverLAPage.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:MainScreenPage animated:YES completion:^(){
            [MainScreenPage presentModalViewController:EverLAPage animated:NO];
			EverLAPage.view.superview.bounds =  CGRectMake(-300, 0, 1024, 748);
        }];
    }
	else if (alertView.tag==1002 && buttonIndex == 0) {
        [self checkingSave];
    }
    else if (alertView.tag==1003 && buttonIndex == 0) {
        [self checkingSave];
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
		[self DisplayBasicSACondtion];
    }
	else if (alertView.tag==1007 && buttonIndex == 0) {
		[self Validation];
    }
	
}


#pragma mark - handle data

-(void)togglePlan
{
    NSLog(@"tooglePlan");
    [self getTermRule];
	
}

-(void)toggleExistingField{
	
	txtPolicyTerm.text = [NSString stringWithFormat:@"%d", 100 - requestAge];
	txtBasicSA.text = [NSString stringWithFormat:@"%.f", getSumAssured ];
	txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", getBasicPrem ];
	txtGrayRTUP.text = [NSString stringWithFormat:@"%.2f", getGrayRTUP ];
	
	if ([getBumpMode isEqualToString:@"A"]) {
		segPremium.selectedSegmentIndex = 0;
	}
	else if([getBumpMode isEqualToString:@"S"]) {
		segPremium.selectedSegmentIndex = 1;
	}
	else if([getBumpMode isEqualToString:@"Q"]) {
		segPremium.selectedSegmentIndex = 2;
	}
	else{
		segPremium.selectedSegmentIndex = 3;
	}
	
	if (TPExcess == TRUE) {
		txtRTUP.text = [NSString stringWithFormat:@"%.2f", [getRTUP doubleValue ]];
		txtCommFrom.text = [NSString stringWithFormat:@"%d", [getCommFrom intValue ] - 1];
		txtFor.text = [NSString stringWithFormat:@"%d", [getFor intValue ] + 1];
	}
	else{
		txtRTUP.text = @"";
		txtCommFrom.text = @"";
		txtFor.text = @"";
	}

	txtTotalBAPremium.text = [NSString stringWithFormat:@"%.2f", [txtBasicPremium.text doubleValue ] + [txtGrayRTUP.text doubleValue]];
	//txtPremiumPayable.text = txtBasicPremium.text;
	txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", [txtBasicPremium.text doubleValue ] + TotalRiderPremium + [txtGrayRTUP.text doubleValue]];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
	[formatter setNegativeFormat:@"-"];
	
	txtTotalBAPremium.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtTotalBAPremium.text doubleValue] + [txtGrayRTUP.text doubleValue]]];
	txtPremiumPayable.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtPremiumPayable.text doubleValue]]];
	
	[_delegate BasicSI:getSINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover
			andBasicSA:txtBasicSA.text andBasicHL:getHL andBasicHLTerm:getHLTerm
		 andBasicHLPct:getHLPct andBasicHLPctTerm:getHLPctTerm andPlanCode:getPlanCode andBumpMode:getBumpMode];
	
}

-(void) getTermRule
{
    termCover = 100 - ageClient;
}

-(void)getProspectData
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode FROM "
							  "prospect_profile WHERE IndexNo= \"%d\"",IndexNo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NamePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DOBPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                GenderPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                OccpCodePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
            } else {
                NSLog(@"error access prospect_profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


-(void)getExistingBasic
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT SINo, CovPeriod, BasicSA, "
							  "ATPrem, BUMPMode, ifnull(HLoading,'0'), HLoadingTerm, ifnull(HLoadingPct,'0'), HLoadingPctTerm, planCode, ATU FROM UL_Details"
							  " WHERE SINo=\"%@\"",SINo];

		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                getPolicyTerm = sqlite3_column_int(statement, 1);
                getSumAssured = sqlite3_column_double(statement, 2);
				getBasicPrem = sqlite3_column_double(statement, 3);
				getBumpMode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                const char *getHL2 = (const char*)sqlite3_column_text(statement, 5);
                getHL = getHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getHL2];
                getHLTerm = sqlite3_column_int(statement, 6);	
                const char *getTempHL2 = (const char*)sqlite3_column_text(statement, 7);
                getHLPct = getTempHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getTempHL2];
                getHLPctTerm = sqlite3_column_int(statement, 8);
				getPlanCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
				//                NSLog(@"basicPlan:%@",planChoose);
				getGrayRTUP = sqlite3_column_double(statement, 10);
                OriginalBump = getBumpMode;
				
				
            } else {
                NSLog(@"error access getExistingBasic");
            }
            sqlite3_finalize(statement);
        }
		
		
		querySQL = [NSString stringWithFormat:@"SELECT FromYear, YearInt, Amount, ForYear FROM UL_TPExcess WHERE SINo=\"%@\"",SINo];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				TPExcess = TRUE;
                getCommFrom = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] ;
                getRTUP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] ;
				getFor = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] ;
                
            } else {
				TPExcess = FALSE;
                getCommFrom = @"";
				getRTUP = @"";
				getFor = @"";
            }
            sqlite3_finalize(statement);
        }
		/*
		querySQL = [NSString stringWithFormat:@"SELECT fund, option, partial_withd_pct, EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund FROM UL_fund_maturity_option WHERE SINo=\"%@\"",SINo];
		
		Fund2023PartialReinvest = 100.00; //means fully withdraw
		Fund2025PartialReinvest = 100.00;
		Fund2028PartialReinvest = 100.00;
		Fund2030PartialReinvest = 100.00;
		Fund2035PartialReinvest = 100.00;
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
				if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2023"]) {
					if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
						Fund2023PartialReinvest = 0;
						Fund2023ReinvestTo2025Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue ] ;
						Fund2023ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
						Fund2023ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2023ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2023ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2023ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
						Fund2023PartialReinvest = 100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
						Fund2023ReinvestTo2025Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue ] ;
						Fund2023ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
						Fund2023ReinvestTo2030Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2023ReinvestTo2035Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2023ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2023ReinvestToRetFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else{
						Fund2023PartialReinvest = 100;
					}
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2025"]) {
					if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
						Fund2025PartialReinvest = 0;
						Fund2025ReinvestTo2028Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
						Fund2025ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2025ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2025ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2025ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
						Fund2025PartialReinvest = 100 -  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
						Fund2025ReinvestTo2028Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] doubleValue ] ;
						Fund2025ReinvestTo2030Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2025ReinvestTo2035Fac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2025ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2025ReinvestToRetFac =  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else{
						Fund2025PartialReinvest = 100;
					}
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2028"]) {
					if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
						Fund2028PartialReinvest = 0;
						Fund2028ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2028ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2028ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2028ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
						Fund2028PartialReinvest = 100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
						Fund2028ReinvestTo2030Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] doubleValue ] ;
						Fund2028ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2028ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2028ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else{
						Fund2028PartialReinvest = 100;
					}
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2030"]) {
					if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
						Fund2030PartialReinvest = 0;
						Fund2030ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2030ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2030ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
						Fund2030PartialReinvest = 100 -  [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
						Fund2030ReinvestTo2035Fac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] doubleValue ] ;
						Fund2030ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2030ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else{
						Fund2030PartialReinvest = 100;
					}
				}
				else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2035"]) {
					if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"ReInvest"]) {
						Fund2035PartialReinvest = 0;
						Fund2035ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2035ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
					}
					else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] isEqualToString:@"Partial"]) {
						Fund2035PartialReinvest =  100 - [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] doubleValue ] ;
						Fund2035ReinvestToCashFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] doubleValue ] ;
						Fund2035ReinvestToRetFac = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] doubleValue ] ;
						
					}
					else{
						Fund2035PartialReinvest = 100;
					}
				}
				
            }
            sqlite3_finalize(statement);
        }
*/
		
        sqlite3_close(contactDB);
    }
}


-(void)checkingSave
{
    if (useExist) {
        NSLog(@"will update");
        [self updateBasicPlan];
		if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
			//update UL_TPExcess
			if (TPExcess == TRUE) {
				[self UpdateTPExcess];
			}
			else{
				[self InsertIntoTPExcess];
			}
		}
		else{
			//delete
			if (TPExcess == TRUE) {
				[self DeleteTPExcess];
			}
		}
		
    }
	else {
        NSLog(@"will save");
        [self saveBasicPlan];
    }
}

-(void)updateBasicPlan
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE UL_Details SET CovPeriod = '%@', CovPeriod=\"%@\", BasicSA=\"%@\", "
							  "AtPrem = \"%@\", BumpMode = \"%@\", DateModified=%@, ComDate = '%@', SIVersion ='%@' "
							  " WHERE SINo=\"%@\"", txtPolicyTerm.text, txtPolicyTerm.text, txtBasicSA.text, txtBasicPremium.text,
							  [self ReturnBumpMode], @"datetime(\"now\", \"+8 hour\")", getPlanCommDate, AppsVersion, SINo];
        
        //NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"BasicPlan update!");
                //[self getPlanCodePenta];
                
				[_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:txtBasicSA.text
					andBasicHL:getHL andBasicHLTerm:getHLTerm andBasicHLPct:getHLPct andBasicHLPctTerm:getHLPctTerm
					   andPlanCode:getPlanCode andBumpMode:[self ReturnBumpMode]];
					
            }
            else {
                NSLog(@"BasicPlan update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
		
		
		NSString *SQLaddin;
		if ([OriginalBump  isEqualToString:@"A"]) {
			if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium * %f", Semi];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium * %f", quarterly];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"M"]) {
				SQLaddin = [NSString stringWithFormat: @"premium =  premium * %f", Monthly];
			}
			else{
				sqlite3_close(contactDB);
				return;
			}
		}
		else if ([OriginalBump  isEqualToString:@"S"]) {
			if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f", Semi];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", Semi, quarterly];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"M"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", Semi, Monthly];
			}
			else{
				sqlite3_close(contactDB);
				return;
			}
			
		}
		else if ([OriginalBump  isEqualToString:@"Q"]) {
			if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f", quarterly];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", quarterly, Semi];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"M"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", quarterly, Monthly];
			}
			else{
				sqlite3_close(contactDB);
				return;
			}
			
		}
		else if ([OriginalBump  isEqualToString:@"M"]) {
			if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f", Monthly];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", Monthly, Semi];
			}
			else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
				SQLaddin = [NSString stringWithFormat: @"premium = premium / %f * %f", Monthly, quarterly];
			}
			else{
				sqlite3_close(contactDB);
				return;
			}
		}
		
		querySQL = [NSString stringWithFormat:@"UPDATE UL_Rider_Details SET %@ WHERE SINo=\"%@\"", SQLaddin, SINo];
        
        //NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"BasicPlan update!");
                //[self getPlanCodePenta];
                
				[_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:txtBasicSA.text
						andBasicHL:getHL andBasicHLTerm:getHLTerm andBasicHLPct:getHLPct andBasicHLPctTerm:getHLPctTerm
					   andPlanCode:getPlanCode andBumpMode:[self ReturnBumpMode]];
				
            }
            else {
                NSLog(@"BasicPlan update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    [self validateExistingRider];
	
}

-(void)validateExistingRider{
	
}

-(void)saveBasicPlan
{
    [self getRunningSI];
    [self getRunningCustCode];
	
    //generate SINo || CustCode
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoSI = SILastNo + 1;
    int runningNoCust = CustLastNo + 1;
    
    NSString *fooSI = [NSString stringWithFormat:@"%04d", runningNoSI];
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
    
    SINo = [[NSString alloc] initWithFormat:@"SI%@-%@",currentdate,fooSI];
    LACustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    NSLog(@"SINo:%@, CustCode:%@",SINo,LACustCode);
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
							   @"INSERT INTO UL_Details (SINo,  PlanCode, CovTypeCode, ATPrem, BasicSA, CovPeriod, OccpCode, "
							   "BumpMode, VU2023, VU2025,VU2028,VU2030,VU2035,VURet,VUCash,VURetOpt,VUCashOpt, PolicySustainYear, "
							   "DateCreated, CreatedBy, DateModified, ModifiedBy,ComDate, VUDana, VUDanaOpt, ATU, SIStatus, SIVersion) VALUES "
							   "(\"%@\", \"UV\", \"IC\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", '0', '0', "
							   "'0','0','40','40','20','0','0','0', "
							   "datetime('now', '+8 hour'), 'HLA', datetime('now', '+8 hour'), 'HLA', '%@', '0', '0', '%@', '%@', '%@') ",
							   SINo, txtBasicPremium.text, txtBasicSA.text, termCover, OccpCode, [self ReturnBumpMode], getPlanCommDate, txtGrayRTUP.text, @"INVALID", AppsVersion];
		
		//NSLog(@"%@", insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Saved BasicPlan!");
				if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
						[self InsertIntoTPExcess]; // for Regular Top up premium
				}
				
                [self updateLA];
                
                if (PayorIndexNo != 0) {
                    [self savePayor];
                }
                
                if (secondLAIndexNo != 0) {
                    [self saveSecondLA];
                }
				
				[_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:txtBasicSA.text
						andBasicHL:getHL andBasicHLTerm:getHLTerm andBasicHLPct:getHLPct andBasicHLPctTerm:getHLPctTerm
						andPlanCode:getPlanCode andBumpMode:[self ReturnBumpMode]];

		
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.SICompleted = YES;
                
            }
            else {
                NSLog(@"Failed Save basicPlan!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
			
        }
		
		
		
        sqlite3_close(contactDB);
    }
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
					 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund ) VALUES ('%@', '%@', '%@', '%@', "
					 " '%@', '%@','%@','%@','%@','%@', '%@') ", SINo, @"HLA EverGreen 2035", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0"  ];
		//NSLog(@"%@", insertSQL);
		
		if (sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
			{
				
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
		
	
}
/*
-(double)CalculateBUMP{
	double FirstBasicMort = [self ReturnBasicMort:ageClient]/1000.00;
	double FirstSA = [txtBasicSA.text doubleValue ];
	double SecondBasicMort = [self ReturnBasicMort:ageClient + 1]/1000.00;
	double SecondSA = 0;
	double ThirdBasicMort = [self ReturnBasicMort:ageClient + 2]/1000.00;
	double BUMP1;
	double BUMP2;
	
	//NSLog(@"%f, %f, %f", FirstBasicMort, SecondBasicMort, ThirdBasicMort);
	
	//[self getExistingBasic]; //disable as it will change getbumpmode
	[self CalcInst:@""];
	[self GetRegWithdrawal];
	[self ReturnFundFactor]; // get factor for each fund
	[self CalcYearDiff]; //get the yearDiff
	[self SurrenderValue:2 andMonth:0 andLevel:0];
	SecondSA = [txtBasicSA.text doubleValue ] - HSurrenderValue;
			//NSLog(@"dasdas %f", HSurrenderValue);
	if ([getHL isEqualToString:@""]) {
		getHL = @"0";
	}
	
	if ([getHLPct isEqualToString:@""]) {
		getHLPct= @"0";
	}
	
	if ([getOccLoading isEqualToString:@"STD"]) {
		getOccLoading = @"0";
	}

	double MortDate = [self GetMortDate ];
	NSString *strBumpMode = [self ReturnBumpMode];
	double ModeRate = [self ReturnModeRate:strBumpMode];
	double divideMode = [self ReturnDivideMode];
	double PremAllocation = [self ReturnPremAllocation:1];
	double ExcessPrem =  [self ReturnExcessPrem:1];
	
	double FirstBasicSA =  (FirstSA * ((FirstBasicMort * MortDate + SecondBasicMort * (12 - MortDate))/12.00 * (1 + [getHLPct intValue]/100.00 ) +
							([getHL doubleValue] /1000.00) + ([getOccLoading doubleValue ]/1000.00)));

	double SecondBasicSA =  (SecondSA * ((SecondBasicMort * MortDate + ThirdBasicMort * (12 - MortDate))/12.00 * (1 + [getHLPct intValue]/100.00 ) +
									   ([getHL doubleValue] /1000.00) + ([getOccLoading doubleValue ]/1000.00)));
	
	//NSLog(@"%f %f %f", FirstBasicSA, SecondBasicSA, MortDate );
	BUMP1 = (ModeRate * (PremAllocation * ([txtBasicPremium.text doubleValue ] * divideMode) +
				(0.95 * (ExcessPrem + [txtGrayRTUP.text doubleValue ]))) -
			 (((PolicyFee * 12) + FirstBasicSA + 0) * 12.5/12.00))/divideMode;
	
	BUMP2 = (ModeRate * ([self ReturnPremAllocation:2] * ([txtBasicPremium.text doubleValue ] * divideMode) +
				(0.95 * ([self ReturnExcessPrem:2] + [txtGrayRTUP.text doubleValue ]))) -
			 (((PolicyFee * 12) + SecondBasicSA + 0) * 12.5/12.00))/divideMode;
	
	
	if (BUMP1 < 0.00) {
		PremReq = ((((0.01 * divideMode) + (((PolicyFee * 12) + FirstBasicSA + 0) * 12.5/12.00))/ModeRate -
					(0.95 * (ExcessPrem + [txtGrayRTUP.text doubleValue ])))/PremAllocation)/divideMode;
	}
	
	NSLog(@"bump1 = %f, bump2 = %f", BUMP1, BUMP2);
	NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
	[format setNumberStyle:NSNumberFormatterDecimalStyle];
	[format setRoundingMode:NSNumberFormatterRoundHalfUp];
	[format setMaximumFractionDigits:2];

	VUCashPrevValueHigh =0;
	VURetPrevValueHigh  =0;
	VU2023PrevValuehigh = 0;
	VU2025PrevValuehigh =0;
	VU2028PrevValuehigh =0;
	VU2030PrevValuehigh = 0;
	VU2035PrevValuehigh = 0;
	
	VUCashPrevValueMedian =0;
	VURetPrevValueMedian  =0;
	VU2023PrevValueMedian = 0;
	VU2025PrevValueMedian =0;
	VU2028PrevValueMedian =0;
	VU2030PrevValueMedian = 0;
	VU2035PrevValueMedian = 0;
	
	VUCashPrevValueLow =0;
	VURetPrevValueLow  =0;
	VU2023PrevValueLow = 0;
	VU2025PrevValueLow =0;
	VU2028PrevValueLow =0;
	VU2030PrevValueLow = 0;
	VU2035PrevValueLow = 0;
	
	MonthVUCashPrevValueHigh =0;
	MonthVURetPrevValueHigh  =0;
	MonthVU2023PrevValuehigh = 0;
	MonthVU2025PrevValuehigh =0;
	MonthVU2028PrevValuehigh =0;
	MonthVU2030PrevValuehigh = 0;
	MonthVU2035PrevValuehigh = 0;
	
	MonthVUCashPrevValueMedian =0;
	MonthVURetPrevValueMedian  =0;
	MonthVU2023PrevValueMedian = 0;
	MonthVU2025PrevValueMedian =0;
	MonthVU2028PrevValueMedian =0;
	MonthVU2030PrevValueMedian = 0;
	MonthVU2035PrevValueMedian = 0;
	
	MonthVUCashPrevValueLow =0;
	MonthVURetPrevValueLow  =0;
	MonthVU2023PrevValueLow = 0;
	MonthVU2025PrevValueLow =0;
	MonthVU2028PrevValueLow =0;
	MonthVU2030PrevValueLow = 0;
	MonthVU2035PrevValueLow = 0;
	
	temp2023High = 0;
	temp2023Median= 0;
	temp2023Low = 0;
	temp2025High = 0;
	temp2025Median = 0;
	temp2025Low = 0;
	temp2028High = 0;
	temp2028Median = 0;
	temp2028Low = 0;
	temp2030High = 0;
	temp2030Median = 0;
	temp2030Low = 0;
	temp2035High = 0;
	temp2035Median = 0;
	temp2035Low = 0;
	
	for (int i =1; i <= 30 ; i++) {
		
		VUCashValueNegative = false;
		if (i == YearDiff2023 || i == YearDiff2025 || i == YearDiff2028 || i == YearDiff2030 || i == YearDiff2035) {
			for (int m = 1; m <= 12; m++) {
				
				MonthFundValueOfTheYearValueTotalHigh = [self ReturnMonthFundValueOfTheYearValueTotalHigh:i andMonth:m];
					//NSLog(@"%d %f %f %f", m, MonthVURetValueHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
				[self SurrenderValue:i andMonth:m andLevel:1];
				
				
				MonthFundValueOfTheYearValueTotalMedian = [self ReturnMonthFundValueOfTheYearValueTotalMedian:i andMonth:m];
				[self SurrenderValue:i andMonth:m andLevel:2];
				
				
				MonthFundValueOfTheYearValueTotalLow = [self ReturnMonthFundValueOfTheYearValueTotalLow:i andMonth:m];
				//NSLog(@"%d %f %f %f", m, MonthVURetValueLow, MonthVU2035ValueLow, MonthFundValueOfTheYearValueTotalLow );
				[self SurrenderValue:i andMonth:m andLevel:3];
				
			}
			
		}
		else{
			VUCashValueNegative = false;
			FundValueOfTheYearValueTotalHigh = [self ReturnFundValueOfTheYearValueTotalHigh:i];
			FundValueOfTheYearValueTotalMedian = [self ReturnFundValueOfTheYearValueTotalMedian:i];
			FundValueOfTheYearValueTotalLow = [self ReturnFundValueOfTheYearValueTotalLow:i];
			[self SurrenderValue:i andMonth:0 andLevel:0];
		}
		
		

		NSLog(@"%d) %f, %f, %f",i, HSurrenderValue, MSurrenderValue, LSurrenderValue );
		NSLog(@"%d) %f,%f,%f,%f,%f,%f,%f", i, VUCashValueHigh,VURetValueHigh,VU2023ValueHigh, VU2025ValueHigh,VU2028ValueHigh, VU2030ValueHigh, VU2035ValueHigh);
		//NSLog(@"%d) %f,%f,%f,%f,%f,%f,%f", i, VUCashValueLow,VURetValueLow,VU2023ValueLow, VU2025ValueLow,VU2028ValueLow, VU2030ValueLow, VU2035ValueLow);
		
	}

	if (BUMP1 > BUMP2) {
		return [[NSString stringWithFormat:@"%@", [format stringFromNumber:[NSNumber numberWithFloat:BUMP2]]] doubleValue ];
	}
	else{
		//return [[NSString stringWithFormat:@"%.2f", BUMP1] doubleValue ];
		return [[NSString stringWithFormat:@"%@", [format stringFromNumber:[NSNumber numberWithFloat:BUMP1]]] doubleValue ];
	}
	
	
	
}

#pragma mark - Surrender Value Calculation
-(void)SurrenderValue :(int)aaPolicyYear andMonth:(int)aaMonth andLevel:(int)aaLevel{
	if (aaPolicyYear == YearDiff2023 || aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2028 || aaPolicyYear == YearDiff2030 ||
		aaPolicyYear == YearDiff2035) {
		//month
		if (aaLevel == 1) {
			HSurrenderValue = [self ReturnHSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
		}
		else if (aaLevel == 2){
			MSurrenderValue = [self ReturnMSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
		}
		else if (aaLevel == 3){
			LSurrenderValue = [self ReturnLSurrenderValue:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth ];
		}
		else{
			
		}
		
		HRiderSurrenderValue = 0;
		MRiderSurrenderValue = 0;
		LRiderSurrenderValue = 0;
		
	} else {
		//year
		HSurrenderValue = [self ReturnHSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		MSurrenderValue = [self ReturnMSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		LSurrenderValue = [self ReturnLSurrenderValue:aaPolicyYear andYearOrMonth:@"Y" andMonth:0 ];
		HRiderSurrenderValue = 0;
		MRiderSurrenderValue = 0;
		LRiderSurrenderValue = 0;
	}
	

}

-(double)ReturnHSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);

	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
			VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
			VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
			
		
		

	}
	else{
		VUCashValueHigh = [self ReturnVUCashValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
	}
	
	
	
	if (VUCashValueHigh == 1 && VU2023ValueHigh == 0 && VU2025ValueHigh == 0 && VU2028ValueHigh == 0 &&
		VU2030ValueHigh == 0 && VU2035ValueHigh == 0 && VURetValueHigh == 0) {
		return 0;
	} else {
		return VU2023ValueHigh + VU2025ValueHigh + VU2028ValueHigh + VU2030ValueHigh + VU2035ValueHigh +
				VUCashValueHigh + VURetValueHigh;
	}
	
}





-(double)ReturnMSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {

		VUCashValueMedian = [self ReturnVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		VURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];

	}
	else{
		VUCashValueMedian = [self ReturnVUCashValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];

	}
	
	
	
	if (VUCashValueMedian == 1 && VU2023ValueMedian == 0 && VU2025ValueMedian == 0 && VU2028ValueMedian == 0 &&
		VU2030ValueMedian == 0 && VU2035ValueMedian == 0 && VURetValueMedian == 0) {
		return 0;
	} else {
		//NSLog(@"%f,%f,%f,%f,%f,%f,%f", VUCashValueMedian,VURetValueMedian,VU2023ValueMedian, VU2025ValueMedian,VU2028ValueMedian, VU2030ValueMedian, VU2035ValueMedian);
		return VU2023ValueMedian + VU2025ValueMedian + VU2028ValueMedian + VU2030ValueMedian + VU2035ValueMedian +
				VUCashValueMedian + VURetValueMedian;
		
	}
	
}

-(double)ReturnLSurrenderValue :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth {
	//NSLog(@"%f", [self ReturnVUCashValueHigh:aaPolicyYear]);
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		VUCashValueLow = [self ReturnVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:aaMonth];
		VURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		VU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:aaMonth];
		
		
	}
	else{
		VUCashValueLow = [self ReturnVUCashValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andMonth:0];
		VURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		VU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:2 andMonth:0];
		
	}
	
	
	
	if (VUCashValueLow == 1 && VU2023ValueLow == 0 && VU2025ValueLow == 0 && VU2028ValueLow == 0 &&
		VU2030ValueLow == 0 && VU2035ValueLow == 0 && VURetValueLow == 0) {
		return 0;
	} else {
		return VU2023ValueLow + VU2025ValueLow + VU2028ValueLow + VU2030ValueLow + VU2035ValueLow +
		VUCashValueLow + VURetValueLow;
		
	}
	
}


-(void)ReturnFundFactor{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select VU2023,VU2025,VU2028,VU2030,VU2035,VUCash,VURet,VURetOpt, VUCashOpt From UL_Details "
					" WHERE sino = '%@'", SINo];	
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue];
				VU2025Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] intValue];
				VU2028Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] intValue];
				VU2030Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] intValue];
				VU2035Factor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)] intValue];
				VUCashFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)] intValue];
				VURetFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] intValue];
				VURetOptFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)] intValue];
				VUCashOptFactor = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)] intValue];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(void)GetRegWithdrawal{
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select FromAge, ToAge, YearInt, Amount From UL_RegWithdrawal WHERE sino = '%@'", SINo];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				RegWithdrawalStartYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue];
				RegWithdrawalEndYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)] intValue];
				RegWithdrawalIntYear = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)] intValue];
				RegWithdrawalAmount = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)] doubleValue];
			}
			else{
				RegWithdrawalStartYear = 0;
				RegWithdrawalEndYear = 0;
				RegWithdrawalAmount = 0;
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}



#pragma mark - Calculate Fund Surrender Value for Basic plan
-(double)ReturnVU2023ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)aaMonth{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		return 0.00;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			//month calculation

				
				if (aaMonth == 1) {
					MonthVU2023PrevValuehigh = VU2023PrevValuehigh;
				}
				
			if (aaMonth > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				MonthVU2023PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValuehigh;
			
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
					
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:aaMonth] ) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
									pow((1 + [self ReturnVU2023InstHigh:@"A" ]), (1.00/12.00)) + MonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear] * [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
									pow((1 + [self ReturnVU2023InstHigh:@"A" ]), 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
									(MonthVU2023ValueHigh/MonthFundValueOfTheYearValueTotalHigh);
					
				}
				else{
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:aaMonth]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
									pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00) + MonthVU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:aaMonth]/100.00)) *
									pow(1 + [self ReturnVU2023InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				if (aaMonth == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
					if (Fund2023PartialReinvest != 100) {
						MonthFundMaturityValue2023_Bull = MonthVU2023PrevValuehigh * (100 - Fund2023PartialReinvest)/100.00;
						
						temp2023High = currentValue * (100 - Fund2023PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2023_Bull = 0;
					}
					
					if (aaRound == 2) {
						MonthVU2023PrevValuehigh = 0;
					}
					else{
						MonthVU2023PrevValuehigh = tempPrev;
					}
				}
				else{
					if (aaRound == 2) {
						MonthVU2023PrevValuehigh = currentValue;
					}
					else{
						MonthVU2023PrevValuehigh = tempPrev;
					}
				}
				
			if (aaMonth == 12 && aaRound == 2) {
				VU2023PrevValuehigh = MonthVU2023PrevValuehigh;
			}
			
			return currentValue;
			// below part to be edit later
		}
		else{
			//year calculation
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
								(1 + VU2023InstHigh) + VU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"]) -
								([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
								(VU2023ValueHigh/FundValueOfTheYearValueTotalHigh);
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstHigh) + VU2023PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueHigh = currentValue;
				}
				else{
					currentValue = VU2023ValueHigh;
				}
				
			}
			
			if (aaRound == 2){
				VU2023PrevValuehigh = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}

-(double)ReturnVU2023ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		return 0.00;
	}
	else{

		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				
				if (i == 1) {
					MonthVU2023PrevValueMedian = VU2023PrevValueMedian;
				}
				
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				MonthVU2023PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValueMedian;
			
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
					
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + MonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
					(MonthVU2023ValueMedian/MonthFundValueOfTheYearValueTotalMedian);
					
				}
				else{
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) + MonthVU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2023InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
					if (Fund2023PartialReinvest != 100) {
						MonthFundMaturityValue2023_Flat = MonthVU2023PrevValueMedian * (100 - Fund2023PartialReinvest)/100.00;
						
						temp2023Median = currentValue * (100 - Fund2023PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2023_Flat = 0;
					}
					
					if (aaRound == 2) {
						MonthVU2023PrevValueMedian = 0;
					}
					else{
						MonthVU2023PrevValueMedian = tempPrev;
					}
				}
				else{
					if (aaRound == 2) {
						MonthVU2023PrevValueMedian = currentValue;
					}
					else{
						MonthVU2023PrevValueMedian = tempPrev;
					}
					
				}
				
			
				if (i == 12 && aaRound == 2) {
					VU2023PrevValueMedian = MonthVU2023PrevValueMedian;
				}
			
			return currentValue;
			// below part to be edit later
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				(1 + VU2023InstMedian) + VU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				(VU2023ValueMedian/FundValueOfTheYearValueTotalMedian);
				
			}
			else{
				if (aaRound == 1) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstMedian) + VU2023PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueMedian = currentValue;
				}
				else{
					currentValue = VU2023ValueMedian;
				}
				
			}
			
			if (aaRound == 2){
				VU2023PrevValueMedian = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}

-(double)ReturnVU2023ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	double currentValue;
	if (aaPolicyYear > YearDiff2023) {
		return 0.00;
	}
	else{
		
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				
				if (i == 1) {
					MonthVU2023PrevValueLow = VU2023PrevValueLow;
				}
				
			if (i > MonthDiff2023 && aaPolicyYear == YearDiff2023) {
				MonthVU2023PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2023PrevValueLow;
			
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
					
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + MonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVU2023ValueLow/MonthFundValueOfTheYearValueTotalLow);
					
				}
				else{
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2023Fac ] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) + MonthVU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2023InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2023 && aaPolicyYear == YearDiff2023) {
					if (Fund2023PartialReinvest != 100) {
						MonthFundMaturityValue2023_Bear = MonthVU2023PrevValueLow * (100 - Fund2023PartialReinvest)/100.00;
						
						temp2023Low = currentValue * (100 - Fund2023PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2023_Bear = 0;
					}
					if (aaRound == 2) {
						MonthVU2023PrevValueLow = 0;
					}
					else{
						MonthVU2023PrevValueLow = tempPrev;
					}
				}
				else{
					if (aaRound == 2) {
						MonthVU2023PrevValueLow = currentValue;
					}
					else{
						MonthVU2023PrevValueLow = tempPrev;
					}
				}
			
				if (i == 12 && aaRound == 2) {
					VU2023PrevValueLow = MonthVU2023PrevValueLow;
				}
			
			return currentValue;
			// below part to be edit later
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
				(1 + VU2023InstLow) + VU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				(VU2023ValueLow/FundValueOfTheYearValueTotalLow);
				
			}
			else{
				
				if (aaRound == 1) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2023Fac] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2023Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2023Factor * CYFactor) *
					(1 + VU2023InstLow) + VU2023PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2023InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2023ValueLow = currentValue ;
				}
				else{
					 currentValue = VU2023ValueLow;
				}
				
			}
			
			if (aaRound == 2){
				VU2023PrevValueLow = currentValue;
			}
			
			return currentValue;
			// below part to be edit later
		}
		
	}
}


-(double)ReturnVU2025ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{

	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {

				
				if (i == 1) {
					MonthVU2025PrevValuehigh = VU2025PrevValuehigh;
				}
			
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				MonthVU2025PrevValuehigh = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValuehigh;
				
				if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2025PrevValuehigh = MonthVU2025PrevValuehigh + (temp2023High * Fund2023ReinvestTo2025Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + MonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
					(MonthVU2025ValueHigh/MonthFundValueOfTheYearValueTotalHigh);
				}
				else{
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) + MonthVU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstHigh:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
					if (Fund2025PartialReinvest != 100) {
						MonthFundMaturityValue2025_Bull = MonthVU2025PrevValuehigh * (100 - Fund2025PartialReinvest)/100.00;
						
						temp2025High = currentValue * (100 - Fund2025PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2025_Bull = 0;
					}
					if (aaRound == 2){
						MonthVU2025PrevValuehigh = 0;
					}
					else{
						MonthVU2025PrevValuehigh = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2){
						MonthVU2025PrevValuehigh = currentValue;
					}
					else{
						MonthVU2025PrevValuehigh = tempPrev;
					}
					
				}
				

			if (aaRound == 2 && i == 12) {
				VU2025PrevValuehigh = MonthVU2025PrevValuehigh;
			}
			
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstHigh) + VU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
				(VU2025ValueHigh/FundValueOfTheYearValueTotalHigh);
				

			}
			else{
				
				if (aaRound == 1) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstHigh) + VU2025PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueHigh = currentValue;
				}
				else{
					currentValue = VU2025ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				VU2025PrevValuehigh = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2025ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
				
				if (i == 1) {
					MonthVU2025PrevValueMedian = VU2025PrevValueMedian;
				}
				
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				MonthVU2025PrevValueMedian = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValueMedian;
			
				if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2025PrevValueMedian = MonthVU2025PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2025Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + MonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
					(MonthVU2025ValueMedian/MonthFundValueOfTheYearValueTotalMedian);
				}
				else{
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) + MonthVU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstMedian:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
					if (Fund2025PartialReinvest != 100) {
						MonthFundMaturityValue2025_Flat = MonthVU2025PrevValueMedian * (100 - Fund2025PartialReinvest)/100.00;
						
						temp2025Median = currentValue * (100 - Fund2025PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2025_Flat = 0;
					}
					if (aaRound == 2){
						MonthVU2025PrevValueMedian = 0;
					}
					else{
						MonthVU2025PrevValueMedian = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2){
						MonthVU2025PrevValueMedian = currentValue;
					}
					else{
						MonthVU2025PrevValueMedian = tempPrev;
					}
					
				}
				

				if (aaRound == 2 && i == 12) {
					VU2025PrevValueMedian = MonthVU2025PrevValueMedian;
				}
			
			
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstMedian) + VU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				(VU2025ValueMedian/FundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstMedian) + VU2025PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueMedian = currentValue;
				}
				else{
					currentValue = VU2025ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
				VU2025PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}


-(double)ReturnVU2025ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2025) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
			
				
				if (i == 1) {
					MonthVU2025PrevValueLow = VU2025PrevValueLow;
				}
				
			if (i > MonthDiff2025 && aaPolicyYear == YearDiff2025) {
				MonthVU2025PrevValueLow = 0;
				return 0;
			}
			
			double tempPrev = MonthVU2025PrevValueLow;
			
				if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2025PrevValueLow = MonthVU2025PrevValueLow + (temp2023Low * Fund2023ReinvestTo2025Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
					currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + MonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVU2025ValueLow/MonthFundValueOfTheYearValueTotalLow);
				}
				else{
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) + MonthVU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2025InstLow:@"A" ], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2025 && aaPolicyYear == YearDiff2025) {
					if (Fund2025PartialReinvest != 100) {
						MonthFundMaturityValue2025_Bear = MonthVU2025PrevValueLow * (100 - Fund2025PartialReinvest)/100.00;
						
						temp2025Low = currentValue * (100 - Fund2025PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2025_Bear = 0;
					}
					if (aaRound == 2){
						MonthVU2025PrevValueLow = 0;
					}
					else{
						MonthVU2025PrevValueLow = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2){
						MonthVU2025PrevValueLow = currentValue;
					}
					else{
						MonthVU2025PrevValueLow = tempPrev;
					}
					
				}
				
				if (aaRound == 2 && i == 12) {
					VU2025PrevValueLow = MonthVU2025PrevValueLow;
				}
			
			
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				currentValue =((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
				(1 + VU2025InstLow) + VU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				(VU2025ValueLow/FundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2025Fac:aaPolicyYear] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2025Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2025Factor * CYFactor) *
					(1 + VU2025InstLow) + VU2025PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2025InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2025ValueLow = currentValue;
				}
				else{
					currentValue =VU2025ValueLow;
				}
			}
			
			if (aaRound == 2) {
				VU2025PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2028ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				
				if (i == 1) {
					MonthVU2028PrevValuehigh = VU2028PrevValuehigh;
				}
				
				if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					MonthVU2028PrevValuehigh = 0;
					return 0;
				}
			
				double tempPrev = MonthVU2028PrevValuehigh;
				if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2028PrevValuehigh = MonthVU2028PrevValuehigh + (temp2025High * Fund2025ReinvestTo2028Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2028PrevValuehigh = MonthVU2028PrevValuehigh + (temp2023High * Fund2023ReinvestTo2028Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00) + MonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
					(MonthVU2028ValueHigh/MonthFundValueOfTheYearValueTotalHigh);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstHigh:@"A" ], 1.00/12.00)+ MonthVU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					if (Fund2028PartialReinvest != 100) {
						MonthFundMaturityValue2028_Bull = MonthVU2028PrevValuehigh * (100 - Fund2028PartialReinvest)/100.00;
						
						temp2028High = currentValue * (100 - Fund2028PartialReinvest)/100.00;
						//NSLog(@"%f", temp2028High);
					}
					else{
						MonthFundMaturityValue2028_Bull = 0;
					}
					if (aaRound == 2) {
						MonthVU2028PrevValuehigh = 0;
					}
					else{
						MonthVU2028PrevValuehigh = tempPrev;
					}
				}
				else{
					if (aaRound == 2) {
						MonthVU2028PrevValuehigh = currentValue;
					}
					else{
						MonthVU2028PrevValuehigh = tempPrev;
					}
					
				}
			
			if (i == 12 && aaRound == 2) {
				VU2028PrevValuehigh = MonthVU2028PrevValuehigh;
			}

			return currentValue;

		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
								(1 + VU2028InstHigh) + VU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]) -
								([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
								(VU2028ValueHigh/FundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstHigh) + VU2028PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueHigh = currentValue;
				}
				else{
					currentValue = VU2028ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				VU2028PrevValuehigh = currentValue;			
			}

			return currentValue;

		}
		
	}
	
}

-(double)ReturnVU2028ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				
				if (i == 1) {
					MonthVU2028PrevValueMedian = VU2028PrevValueMedian;
				}
				
				if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					MonthVU2028PrevValueMedian = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2028PrevValueMedian;
				if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2028PrevValueMedian = MonthVU2028PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2028Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2028PrevValueMedian = MonthVU2028PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2028Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00) + MonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstMedian:@"A"],1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
					(MonthVU2028ValueMedian/MonthFundValueOfTheYearValueTotalMedian);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstMedian:@"A" ], 1.00/12.00)+ MonthVU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					if (Fund2028PartialReinvest != 100) {
						MonthFundMaturityValue2028_Flat = MonthVU2028PrevValueMedian * (100 - Fund2028PartialReinvest)/100.00;
						
						temp2028Median = currentValue * (100 - Fund2028PartialReinvest)/100.00;
						
					}
					else{
						MonthFundMaturityValue2028_Flat = 0;
					}
					
					if (aaRound == 2) {
						MonthVU2028PrevValueMedian = 0;
					}
					else{
						MonthVU2028PrevValueMedian = tempPrev;
					}
				}
				else{
					if (aaRound == 2) {
						MonthVU2028PrevValueMedian = currentValue;
					}
					else{
						MonthVU2028PrevValueMedian = tempPrev;
					}
					
				}
				
				if (i == 12 && aaRound == 2) {
					VU2028PrevValueMedian = MonthVU2028PrevValueMedian;		
				}
			
			
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				(1 + VU2028InstMedian) + VU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				(VU2028ValueMedian/FundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstMedian) + VU2028PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueMedian = currentValue;
				}
				else{
					currentValue = VU2028ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
					VU2028PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
}

-(double)ReturnVU2028ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2028) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
				
				if (i == 1) {
					MonthVU2028PrevValueLow = VU2028PrevValueLow;
				}
				
				if (i > MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					MonthVU2028PrevValueLow = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2028PrevValueLow;
				if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2028PrevValueLow = MonthVU2028PrevValueLow + (temp2025Low * Fund2025ReinvestTo2028Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2028PrevValueLow = MonthVU2028PrevValueLow + (temp2023Low * Fund2023ReinvestTo2028Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00) + MonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstLow:@"A"],1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVU2028ValueLow/MonthFundValueOfTheYearValueTotalLow);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					pow(1 + [self ReturnVU2028InstLow:@"A" ], 1.00/12.00)+ MonthVU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2028InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				if (i == MonthDiff2028 && aaPolicyYear == YearDiff2028) {
					if (Fund2028PartialReinvest != 100) {
						MonthFundMaturityValue2028_Bear = MonthVU2028PrevValueLow * (100 - Fund2028PartialReinvest)/100.00;
						
						temp2028Low = currentValue * (100 - Fund2028PartialReinvest)/100.00;
						
					}
					else{
						MonthFundMaturityValue2028_Bear = 0;
					}
					
					if (aaRound == 2) {
						MonthVU2028PrevValueLow = 0;
					}
					else{
						MonthVU2028PrevValueLow = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2) {
						MonthVU2028PrevValueLow = currentValue;
					}
					else{
						MonthVU2028PrevValueLow = tempPrev;
					}
					
				}
				
				if (i == 12 && aaRound == 2) {
					VU2028PrevValueLow = MonthVU2028PrevValueLow;
				}
			

			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
				(1 + VU2028InstLow) + VU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				(VU2028ValueLow/FundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2028Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2028Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2028Factor * CYFactor) *
					(1 + VU2028InstLow) + VU2028PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2028InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2028ValueLow = currentValue;
				}
				else{
					currentValue = VU2028ValueLow;
				}
				
			}
			
			if (aaRound == 2) {
					VU2028PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
	}
	
}

-(double)ReturnVU2030ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				if (i == 1) {
					MonthVU2030PrevValuehigh = VU2030PrevValuehigh;
				}
			
				if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					MonthVU2030PrevValuehigh = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2030PrevValuehigh;
				if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2028High * Fund2028ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2025High * Fund2025ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2030PrevValuehigh = MonthVU2030PrevValuehigh + (temp2023High * Fund2023ReinvestTo2030Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
									pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + MonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
									(MonthVU2030ValueHigh/MonthFundValueOfTheYearValueTotalHigh);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
									pow(1 + [self ReturnVU2030InstHigh:@"A" ], 1.00/12.00) + MonthVU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVU2030InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					if (Fund2030PartialReinvest != 100) {
						MonthFundMaturityValue2030_Bear = MonthVU2030PrevValuehigh * (100 - Fund2030PartialReinvest)/100.00;
						
						temp2030High = currentValue * (100 - Fund2030PartialReinvest)/100.00;
						
					}
					else{
						MonthFundMaturityValue2030_Bear = 0;
					}
					if (aaRound == 2) {
						MonthVU2030PrevValuehigh = 0;
					}
					
				}
				else{
					if (aaRound == 2) {
						MonthVU2030PrevValuehigh = currentValue;
					}
					else{
						MonthVU2030PrevValuehigh = tempPrev;
					}
					
				}
				
			if (aaRound == 2 && i == 12) {
				VU2030PrevValuehigh = MonthVU2030PrevValuehigh;
			}
			
			return currentValue;

		}
		else{
			
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
								(1 + VU2030InstHigh) + VU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]) -
								([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
								(VU2030ValueHigh/FundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstHigh) + VU2030PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstHigh:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueHigh = currentValue;
				}
				else{
					currentValue = VU2030ValueHigh;
				}
	
			}
			
			if (aaRound == 2) {
				VU2030PrevValuehigh = currentValue;
			}
			
			return currentValue;

		}
		
	}
	
			// below part to be edit later
}

-(double)ReturnVU2030ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				
				if (i == 1) {
					MonthVU2030PrevValueMedian = VU2030PrevValueMedian;
				}
			
				if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					MonthVU2030PrevValueMedian = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2030PrevValueMedian;
				if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2028Median * Fund2028ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2030PrevValueMedian = MonthVU2030PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2030Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative ==TRUE && MonthFundValueOfTheYearValueTotalMedian != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
									pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + MonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
									(MonthVU2030ValueMedian/MonthFundValueOfTheYearValueTotalMedian);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]* [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
									pow(1 + [self ReturnVU2030InstMedian:@"A" ], 1.00/12.00) + MonthVU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVU2030InstMedian:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					if (Fund2030PartialReinvest != 100) {
						MonthFundMaturityValue2030_Flat = MonthVU2030PrevValueMedian * (100 - Fund2030PartialReinvest)/100.00;
						temp2030Median = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					}
					else{
						MonthFundMaturityValue2030_Flat = 0;
					}
					if (aaRound == 2) {
							MonthVU2030PrevValueMedian = 0;
					}
					
				}
				else{
					if (aaRound == 2) {
							MonthVU2030PrevValueMedian = currentValue;
					}
					else{
						MonthVU2030PrevValueMedian = tempPrev;
					}
				}
			
				if (aaRound == 2 && i == 12) {
						VU2030PrevValueMedian = MonthVU2030PrevValueMedian;
				}
			
			
			return currentValue;

		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				(1 + VU2030InstMedian) + VU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				(VU2030ValueMedian/FundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstMedian) + VU2030PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstMedian:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueMedian = currentValue;
				}
				else{
					currentValue = VU2030ValueMedian;
				}
				
			}
			
			if (aaRound == 2) {
				VU2030PrevValueMedian = currentValue;
			}
			
			return currentValue;

		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2030ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2030) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {

				if (i == 1) {
					MonthVU2030PrevValueLow = VU2030PrevValueLow;
				}
				
				if (i > MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					MonthVU2030PrevValueLow = 0;
					return 0;
				}
			
				double tempPrev = MonthVU2030PrevValueLow;
				if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2028Low * Fund2028ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2025Low * Fund2025ReinvestTo2030Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2030PrevValueLow = MonthVU2030PrevValueLow + (temp2023Low * Fund2023ReinvestTo2030Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + MonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVU2030ValueLow/MonthFundValueOfTheYearValueTotalLow);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]* [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					pow(1 + [self ReturnVU2030InstLow:@"A" ], 1.00/12.00) + MonthVU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVU2030InstLow:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				if (i == MonthDiff2030 && aaPolicyYear == YearDiff2030) {
					if (Fund2030PartialReinvest != 100) {
						MonthFundMaturityValue2030_Bear = MonthVU2030PrevValueLow * (100 - Fund2030PartialReinvest)/100.00;
						temp2030Low = currentValue * (100 - Fund2030PartialReinvest)/100.00;
					}
					else{
						MonthFundMaturityValue2030_Bear = 0;
					}
					if (aaRound == 2) {
						MonthVU2030PrevValueLow = 0;
					}
					
				}
				else{
					if (aaRound == 2) {
						MonthVU2030PrevValueLow = currentValue;
					}
					else{
						MonthVU2030PrevValueLow = tempPrev;
					}
					
				}
				
				if (aaRound == 2 && i == 12) {
					VU2030PrevValueLow = MonthVU2030PrevValueLow;
				}
			
			
			return currentValue;
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0) {
				currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
							   [self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
							   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
				(1 + VU2030InstLow) + VU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				(VU2030ValueLow/FundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2030Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2030Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2030Factor * CYFactor) *
					(1 + VU2030InstLow) + VU2030PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2030InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2030ValueLow = currentValue;
				}
				else{
					currentValue = VU2030PrevValueLow;
				}
				
			}
			
			if (aaRound == 2) {
				VU2030PrevValueLow = currentValue;
			}
			
			return currentValue;
			
		}
		
	}
	
	// below part to be edit later
}

-(double)ReturnVU2035ValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{

	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {


					if (i == 1) {
						MonthVU2035PrevValuehigh = VU2035PrevValuehigh;
					}
					
					if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
						MonthVU2035PrevValuehigh = 0;
						return 0;
					}
			
					double tempPrev = MonthVU2035PrevValuehigh;
					if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
						MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2030High * Fund2030ReinvestTo2035Fac/100.00);
					}
					else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
						MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2028High * Fund2028ReinvestTo2035Fac/100.00);
					}
					else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
						MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2025High * Fund2025ReinvestTo2035Fac/100.00);
					}
					else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
						MonthVU2035PrevValuehigh = MonthVU2035PrevValuehigh + (temp2023High * Fund2023ReinvestTo2035Fac/100.00);
					}
					else{
						
					}
					
					if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
						
						currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
										[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
										[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
										pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + MonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
										pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
										(MonthVU2035ValueHigh/MonthFundValueOfTheYearValueTotalHigh);
						if (aaPolicyYear == 23) {
							//NSLog(@"%f %f %f", NegativeValueOfMaxCashFundHigh, MonthVU2035ValueHigh, MonthFundValueOfTheYearValueTotalHigh );
						}
					}
					else if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh == 0 ) {
						currentValue = 0;
					}
					else{
						currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
										[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
										[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
										pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) + MonthVU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
										pow(1 + [self ReturnVU2035InstHigh:@"A"], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					}
					
					if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
						if (Fund2035PartialReinvest != 100) {
							
							MonthFundMaturityValue2035_Bull = MonthVU2035PrevValuehigh * (100 - Fund2035PartialReinvest)/100.00;
							
							temp2035High = currentValue * (100 - Fund2035PartialReinvest)/100.00;
						}
						else{
							MonthFundMaturityValue2035_Bull = 0;
						}
						
						if (aaRound == 2) {
							MonthVU2035PrevValuehigh = 0;
						}
						else{
							MonthVU2035PrevValuehigh = tempPrev;
						}

					}

					else{
						
						if (aaRound == 2) {
							MonthVU2035PrevValuehigh = currentValue;
						}
						else{
							MonthVU2035PrevValuehigh = tempPrev;
						}
						
					}
					
					if (i == 12 && aaRound == 2) {
						VU2035PrevValuehigh = MonthVU2035PrevValuehigh;
					}
				

					//return MonthVU2035PrevValuehigh;
					return currentValue;
			
			
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
				
				currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
								(1 + VU2035InstHigh) + VU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]) -
								([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
								(VU2035ValueHigh/FundValueOfTheYearValueTotalHigh);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
									(1 + VU2035InstHigh) + VU2035PrevValuehigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstHigh:@"A"]) -
									([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					VU2035ValueHigh = currentValue;
				}
				else{
					currentValue = VU2035ValueHigh;
				}
				
			}
			
			if (aaRound == 2) {
				VU2035PrevValuehigh = currentValue;
			}
			
			
			return currentValue;
		}
		

	}
}

-(double)ReturnVU2035ValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{

	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {
			
				if (i == 1) {
					MonthVU2035PrevValueMedian = VU2035PrevValueMedian;
				}
			
				if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
					MonthVU2035PrevValueMedian = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2035PrevValueMedian;
				if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
					MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2030Median * Fund2030ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2028Median * Fund2028ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2025Median * Fund2025ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2035PrevValueMedian = MonthVU2035PrevValueMedian + (temp2023Median * Fund2023ReinvestTo2035Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
					
					currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
									pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) + MonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
									(MonthVU2035ValueMedian/MonthFundValueOfTheYearValueTotalMedian);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					pow((1 + [self ReturnVU2035InstMedian:@"A" ]), (1.00/12.00)) + MonthVU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow((1 + [self ReturnVU2035InstMedian:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				
				if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
					if (Fund2035PartialReinvest != 100) {
						MonthFundMaturityValue2035_Flat = MonthVU2035PrevValueMedian * (100 - Fund2035PartialReinvest)/100.00;
						temp2035Median = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					}
					else{
						MonthFundMaturityValue2035_Flat = 0;
					}
					if (aaRound == 2) {
						MonthVU2035PrevValueMedian = 0;
					}
					else{
						MonthVU2035PrevValueMedian = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2) {
						MonthVU2035PrevValueMedian = currentValue;
					}
					else{
						MonthVU2035PrevValueMedian = tempPrev;
					}
					
				}

			if (i == 12 && aaRound == 2) {
				VU2035PrevValueMedian = MonthVU2035PrevValueMedian;
			}
			
			//return MonthVU2035PrevValueMedian;
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
				
				currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				(1 + VU2035InstMedian) + VU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
				(VU2035ValueMedian/FundValueOfTheYearValueTotalMedian);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
									(1 + VU2035InstMedian) + VU2035PrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstMedian:@"A"]) -
									([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2035ValueMedian = currentValue;
				}
				else{
					currentValue = VU2035ValueMedian;
				}
			}
			
			if (aaRound == 2) {
				VU2035PrevValueMedian = currentValue;
			}
			
			return currentValue;
		}
		
		
	}
}

-(double)ReturnVU2035ValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	if (aaPolicyYear > YearDiff2035) {
		return 0;
	}
	else{
		if ([aaYearOrMonth isEqualToString:@"M"]) {

				if (i == 1) {
					MonthVU2035PrevValueLow = VU2035PrevValueLow;
				}
			
				if (i > MonthDiff2035 && aaPolicyYear == YearDiff2035) {
					MonthVU2035PrevValueLow = 0;
					return 0;
				}
				
				double tempPrev = MonthVU2035PrevValueLow;
				if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
					MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2030Low * Fund2030ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2028Low * Fund2028ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2025Low * Fund2025ReinvestTo2035Fac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVU2035PrevValueLow = MonthVU2035PrevValueLow + (temp2023Low * Fund2023ReinvestTo2035Fac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
					
					currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) + MonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVU2035ValueLow/MonthFundValueOfTheYearValueTotalLow);
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] *[self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					pow((1 + [self ReturnVU2035InstLow:@"A" ]), (1.00/12.00)) + MonthVU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow((1 + [self ReturnVU2035InstLow:@"A"]), (1.00/12.00)) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				}
				
				
				if (i == MonthDiff2035 && aaPolicyYear == YearDiff2035) {
					if (Fund2035PartialReinvest != 100) {
						MonthFundMaturityValue2035_Bear = MonthVU2035PrevValueLow * (100 - Fund2035PartialReinvest)/100.00;
						temp2035Low = currentValue * (100 - Fund2035PartialReinvest)/100.00;
					}
					else{
						MonthFundMaturityValue2035_Bear = 0;
					}
					
					if (aaRound == 2) {
						MonthVU2035PrevValueLow = 0;
					}
					else{
						MonthVU2035PrevValueLow = tempPrev;
					}
					
				}
				else{
					if (aaRound == 2) {
						MonthVU2035PrevValueLow = currentValue;
					}
					else{
						MonthVU2035PrevValueLow = tempPrev;
					}
				}
				
			if (aaRound == 2 && i == 12) {
				VU2035PrevValueLow = MonthVU2035PrevValueLow;
			}
				
			//return MonthVU2035PrevValueLow;
			return currentValue;
		}
		else{
			if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
				
				currentValue=  ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
				(1 + VU2035InstLow) + VU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
				(VU2035ValueLow/FundValueOfTheYearValueTotalLow);
			}
			else{
				if (aaRound == 1) {
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVU2035Fac:aaPolicyYear] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VU2035Factor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VU2035Factor * CYFactor) *
					(1 + VU2035InstLow) + VU2035PrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVU2035InstLow:@"A"]) -
					([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					VU2035ValueLow = currentValue;
				}
				else{
					currentValue = VU2035ValueLow;
				}
			}
			
			if (aaRound == 2) {
				VU2035PrevValueLow = currentValue;
			}
			
			return currentValue;
		}
		
		
	}
}


-(double)ReturnVUCashValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i {

	double tempValue = 0.00;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {

			if (i == 1) {
				MonthVUCashPrevValueHigh = VUCashPrevValueHigh;
			}
			
			if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {

				MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2035High * Fund2035ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2030High * Fund2030ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
							//NSLog(@"%f", temp2028High);
				MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2028High * Fund2028ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2025High * Fund2025ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVUCashPrevValueHigh = MonthVUCashPrevValueHigh + (temp2023High * Fund2023ReinvestToCashFac/100.00);
			}
			else{
				
			}
			
			tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
						pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) + MonthVUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
						pow((1 + [self ReturnVUCashInstHigh:@"A"]), (1.00/12.00)) - (PolicyFee + [self ReturnTotalBasicMortHigh:aaPolicyYear]) -
						([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
			
			MonthVUCashPrevValueHigh =  tempValue;
			//NSLog(@"%f", MonthVUCashPrevValueHigh);
		
		if (tempValue < 0) {
			MonthVUCashPrevValueHigh = 1.00;
		}
		else{
			MonthVUCashPrevValueHigh = tempValue;
		}
		
		if (i == 12) {
			VUCashPrevValueHigh = MonthVUCashPrevValueHigh;
		}
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalHigh != 0) {
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = TRUE;
			return MonthVUCashPrevValueHigh;
		} else {
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = FALSE;
			return MonthVUCashPrevValueHigh + 0; // to be edit later
		}
		
	}
	else
	{
		tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
		(1 + [self ReturnVUCashInstHigh:@""]) + VUCashPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstHigh:@"A"]) -
		(PolicyFee + [self ReturnTotalBasicMortHigh:aaPolicyYear]) * [self ReturnVUCashHigh] -
		([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		
		if (tempValue < 0) {
			VUCashPrevValueHigh = 1.00;
		}
		else{
			VUCashPrevValueHigh = tempValue;
		}
		
		
		//VUCashPrevValueHigh = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalHigh != 0) {
			//NegativeValueOfMaxCashFundHigh = tempValue;
			NegativeValueOfMaxCashFundHigh = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueHigh;
		} else {
			VUCashValueNegative = FALSE;
			NegativeValueOfMaxCashFundHigh = tempValue;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
	
}

-(double)ReturnVUCashValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {

			if (i == 1) {
				MonthVUCashPrevValueMedian = VUCashPrevValueMedian;
			}
			
			if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
				MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2035Median * Fund2035ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2030Median * Fund2030ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2028Median * Fund2028ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2025Median * Fund2025ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVUCashPrevValueMedian = MonthVUCashPrevValueMedian + (temp2023Median * Fund2023ReinvestToCashFac/100.00);
			}
			else{
				
			}
			
			tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
						pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) + MonthVUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
						pow(1 + [self ReturnVUCashInstMedian:@"A"], 1.00/12.00) - (PolicyFee + [self ReturnTotalBasicMortMedian:aaPolicyYear]) -
						([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
			
			MonthVUCashPrevValueMedian = tempValue;

		if (tempValue < 0) {
			MonthVUCashPrevValueMedian = 1.00;
		}
		else{
			MonthVUCashPrevValueMedian = tempValue;
		}
		
		if (i == 12) {
			VUCashPrevValueMedian = MonthVUCashPrevValueMedian;
		}
		
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalMedian != 0) {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = TRUE;
			return  MonthVUCashPrevValueMedian;
		} else {
			NegativeValueOfMaxCashFundMedian =  tempValue;
			VUCashValueNegative = FALSE;
			return  MonthVUCashPrevValueMedian + 0; // to be edit later
		}
		
		
		
		
	}
	else{
		tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
					(1 + [self ReturnVUCashInstMedian:@""]) + VUCashPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstMedian:@"A"]) -
					(PolicyFee + [self ReturnTotalBasicMortMedian:aaPolicyYear]) * [self ReturnVUCashMedian] -
					([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		
		if (tempValue < 0) {
			VUCashPrevValueMedian = 1.00;
		}
		else{
			VUCashPrevValueMedian = tempValue;
		}
		
		//VUCashPrevValueMedian = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalMedian != 0) {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueMedian;
			//return tempValue;
		} else {
			NegativeValueOfMaxCashFundMedian = tempValue;
			VUCashValueNegative = FALSE;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
}


-(double)ReturnVUCashValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)i{
	
	double tempValue = 0.00;
	if ([aaYearOrMonth isEqualToString:@"M"]) {

			if (i == 1) {
				MonthVUCashPrevValueLow = VUCashPrevValueLow;
			}
			
			if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
				MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2035Low * Fund2035ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
				MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2030Low * Fund2030ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
				MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2028Low * Fund2028ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
				MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2025Low * Fund2025ReinvestToCashFac/100.00);
			}
			else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
				MonthVUCashPrevValueLow = MonthVUCashPrevValueLow + (temp2023Low * Fund2023ReinvestToCashFac/100.00);
			}
			else{
				
			}
			
			tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor +
						 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear andMonth:i] * CYFactor) *
			pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) + MonthVUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
			pow(1 + [self ReturnVUCashInstLow:@"A"], 1.00/12.00) - (PolicyFee + [self ReturnTotalBasicMortLow:aaPolicyYear]) -
			([self ReturnRegWithdrawal:aaPolicyYear] * [self ReturnRegWithdrawalFactor:i]);
			
			
		
		if (tempValue < 0) {
			MonthVUCashPrevValueLow = 1.00;
		}
		else{
			MonthVUCashPrevValueLow = tempValue;
		}
		
		if (i == 12) {
			VUCashPrevValueLow = MonthVUCashPrevValueLow;
		}
		

		
		
		if (tempValue < 0 && MonthFundValueOfTheYearValueTotalLow != 0) {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = TRUE;
			return  MonthVUCashPrevValueLow;
		} else {
			NegativeValueOfMaxCashFundLow =  tempValue;
			VUCashValueNegative = FALSE;
			return  MonthVUCashPrevValueLow + 0; // to be edit later
		}
	}
	else{
		tempValue = ((( [txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] ) + IncreasePrem) * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnRegTopUpPrem] * RegularAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor +
					 [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * [self ReturnVUCashFac:aaPolicyYear] * CYFactor) *
		(1 + [self ReturnVUCashInstLow:@""]) + VUCashPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVUCashInstLow:@"A"]) -
		(PolicyFee + [self ReturnTotalBasicMortLow:aaPolicyYear]) * [self ReturnVUCashLow] -
		([self ReturnRegWithdrawal:aaPolicyYear] * 1);
		
		if (tempValue < 0) {
			VUCashPrevValueLow = 1.00;
		}
		else{
			VUCashPrevValueLow = tempValue;
		}
		
		//VUCashPrevValueLow = tempValue;
		if (tempValue < 0 && FundValueOfTheYearValueTotalLow != 0) {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = TRUE;
			return VUCashPrevValueLow;
			//return tempValue;
		} else {
			NegativeValueOfMaxCashFundLow = tempValue;
			VUCashValueNegative = FALSE;
			return tempValue + 0; // to be edit later
		}
	}
	
	
	
	
}


-(double)ReturnVURetValueHigh :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(NSInteger)i{

	double currentValue =0.0;
	if ([aaYearOrMonth isEqualToString:@"M"]) {


				if (i == 1) {
					MonthVURetPrevValueHigh = VURetPrevValueHigh ;
				}
				
				double tempPrev = MonthVURetPrevValueHigh;
		
				if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)) {
					MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2035High * Fund2035ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
					MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2030High * Fund2030ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2028High * Fund2028ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2025High * Fund2025ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVURetPrevValueHigh = MonthVURetPrevValueHigh + (temp2023High * Fund2023ReinvestToRetFac/100.00);
				}
				else{
					
				}
				
				//NSLog(@"%f", MonthVURetPrevValueHigh);
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalHigh != 0 ) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
									pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"],1.00/12.00) + MonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"], 1.00/12.00) -
									([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
									(MonthVURetValueHigh/MonthFundValueOfTheYearValueTotalHigh);

						//NSLog(@"%f %f %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh,MonthFundValueOfTheYearValueTotalHigh );
					
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
									pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]),(1.00/12.00)) + MonthVURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow((1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]), (1.00/12.00)) -
									([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
					
				}
				
			//NSLog(@"%f, %f, %f, %f",NegativeValueOfMaxCashFundHigh, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, currentValue);

			if (aaRound == 2) {
				MonthVURetPrevValueHigh = currentValue;
			}
			else{
				MonthVURetPrevValueHigh = tempPrev;
			}
			
			
			if (i == 12  && aaRound == 2) {
				VURetPrevValueHigh = MonthVURetPrevValueHigh;
			}
			
				//NSLog(@"%d %f %f, %d ", i, MonthVURetValueHigh, MonthFundValueOfTheYearValueTotalHigh, VUCashValueNegative);
			//return MonthVURetPrevValueHigh;
			return currentValue;
		
		
		
		
	}
	else{
		//if (VUCashValueHigh < 0 && [self ReturnFundValueOfTheYearValueTotalHigh:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalHigh != 0 ) {
			currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
							(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + VURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) -
							([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundHigh - 1) *
							(VURetValueHigh/FundValueOfTheYearValueTotalHigh);

		}
		else{
			if (aaRound == 1) {
				currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@""]) + VURetPrevValueHigh * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstHigh:aaPolicyYear andMOP:@"A"]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueHigh = currentValue;
			}
			else{
				currentValue = VURetValueHigh;
			}
			
		}
		
		if (aaRound == 2) {
			VURetPrevValueHigh = currentValue;
		}
		
		return currentValue;
	}
	

}

-(double)ReturnVURetValueMedian :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {


				if (i == 1) {
					MonthVURetPrevValueMedian = VURetPrevValueMedian ;
				}
				
				double tempPrev = MonthVURetPrevValueMedian;
				if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
					MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2035Median * Fund2035ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
					MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2030Median * Fund2030ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2028Median * Fund2028ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2025Median * Fund2025ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVURetPrevValueMedian = MonthVURetPrevValueMedian + (temp2023Median * Fund2023ReinvestToRetFac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalMedian != 0 ) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
									pow(1 + [self ReturnVURetInstMedian], 1.00/12.00) + MonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
									pow(1 + [self ReturnVURetInstMedian], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
									(MonthVURetValueMedian/MonthFundValueOfTheYearValueTotalMedian);
					
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
					pow(1 + [self ReturnVURetInstMedian], 1.00/12.00) + MonthVURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVURetInstMedian], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
				}
			
			if (aaRound == 2) {
				MonthVURetPrevValueMedian = currentValue;
			}
			else{
				MonthVURetPrevValueMedian = tempPrev;
			}
		
			if (i == 12  && aaRound == 2) {
				VURetPrevValueMedian = MonthVURetPrevValueMedian ;
			}
			
			
			//return MonthVURetPrevValueMedian;
			return currentValue;
		
	}
	else{
		//if (VUCashValueMedian < 0 && [self ReturnFundValueOfTheYearValueTotalMedian:aaPolicyYear] != 0 ) {
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalMedian != 0 ) {
			currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
							(1 + [self ReturnVURetInstMedian]) + VURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian]) -
							([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundMedian - 1) *
							(VURetValueMedian/FundValueOfTheYearValueTotalMedian);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstMedian]) + VURetPrevValueMedian * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstMedian]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueMedian = currentValue;	
			}
			else{
				currentValue = VURetValueMedian;
			}
		}
		
		if (aaRound == 2) {
			VURetPrevValueMedian = currentValue;
		}
		return currentValue;
	}
	
}

-(double)ReturnVURetValueLow :(int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andRound:(NSInteger)aaRound andMonth:(int)i{
	
	double currentValue;
	
	
	if ([aaYearOrMonth isEqualToString:@"M"]) {
		

				if (i == 1) {
					MonthVURetPrevValueLow = VURetPrevValueLow ;
				}
				
				double tempPrev = MonthVURetPrevValueLow;
				if ((i == MonthDiff2035 + 1 && aaPolicyYear == YearDiff2035)  ) {
					MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2035Low * Fund2035ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2030 + 1 && aaPolicyYear == YearDiff2030){
					MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2030Low * Fund2030ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2028 + 1 && aaPolicyYear == YearDiff2028){
					MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2028Low * Fund2028ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2025 + 1 && aaPolicyYear == YearDiff2025){
					MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2025Low * Fund2025ReinvestToRetFac/100.00);
				}
				else if(i == MonthDiff2023 + 1 && aaPolicyYear == YearDiff2023){
					MonthVURetPrevValueLow = MonthVURetPrevValueLow + (temp2023Low * Fund2023ReinvestToRetFac/100.00);
				}
				else{
					
				}
				
				if (VUCashValueNegative == TRUE && MonthFundValueOfTheYearValueTotalLow != 0 ) {
					currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
								   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
					pow(1 + [self ReturnVURetInstLow], 1.00/12.00) + MonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVURetInstLow], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
					(MonthVURetValueLow/MonthFundValueOfTheYearValueTotalLow);
					
				}
				else{
					currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear] * [self ReturnPremiumFactor:i]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear  andMonth:i] * CYFactor +
									[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
									[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
					pow(1 + [self ReturnVURetInstLow], 1.00/12.00) + MonthVURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]* [self ReturnLoyaltyBonusFactor:i]/100.00)) *
					pow(1 + [self ReturnVURetInstLow], 1.00/12.00) - ([self ReturnRegWithdrawal:aaPolicyYear] * 0);
					
				}
				
		
			if (aaRound == 2) {
				MonthVURetPrevValueLow = currentValue;
			}
			else{
				MonthVURetPrevValueLow = tempPrev;
			}
		
			if (i == 12  && aaRound == 2) {
				VURetPrevValueLow = MonthVURetPrevValueLow ;
			}
			
			//return MonthVURetPrevValueLow;
			return currentValue;
		
	}
	else{
		if (VUCashValueNegative == TRUE && FundValueOfTheYearValueTotalLow != 0 ) {
			currentValue= ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
						   [self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
						   [self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
							(1 + [self ReturnVURetInstLow]) + VURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow]) -
							([self ReturnRegWithdrawal:aaPolicyYear] * 0) + (NegativeValueOfMaxCashFundLow - 1) *
							(VURetValueLow/FundValueOfTheYearValueTotalLow);
			
		}
		else{
			if (aaRound == 1) {
				currentValue = ((([txtBasicPremium.text doubleValue ] * [self ReturnPremAllocation:aaPolicyYear]) + IncreasePrem) * [self ReturnVURetFac:aaPolicyYear] * CYFactor +
								[self ReturnRegTopUpPrem] * RegularAllo * VURetFactor * CYFactor +
								[self ReturnExcessPrem:aaPolicyYear] * ExcessAllo * VURetFactor * CYFactor) *
				(1 + [self ReturnVURetInstLow]) + VURetPrevValueLow * (1 + ([self ReturnLoyaltyBonus:aaPolicyYear]/100.00)) * (1 + [self ReturnVURetInstLow]) -
				([self ReturnRegWithdrawal:aaPolicyYear] * 0);
				VURetValueLow = currentValue;
			}
			else{
				currentValue = VURetValueLow;
			}
			
		}
		
		if (aaRound == 2) {
			VURetPrevValueLow = currentValue;
		}
		return currentValue;
	}
	
}


-(double)ReturnRegWithdrawal :(int)aaPolicyYear{
	if (aaPolicyYear >= RegWithdrawalStartYear) {
		if (aaPolicyYear <= RegWithdrawalEndYear) {
			if ((aaPolicyYear - RegWithdrawalStartYear) % RegWithdrawalIntYear == 0) {
				return RegWithdrawalAmount;
			}
			else{
				return 0;
			}
		}
		else{
			return 0;
		}
	}
	else{
		return 0;
	}
}

-(double)ReturnRegWithdrawalFactor :(int)aaMonth{
	if (aaMonth == 12) {
		return 1.00;
	}
	else{
		return 0;
	}
}
			
-(double)ReturnRegTopUpPrem{
	if (![txtGrayRTUP.text isEqualToString:@""]) {
		return [txtGrayRTUP.text doubleValue ];
	}
	else{
		return 0;
	}
}

#pragma mark - Calculate Fund Factor

#pragma mark - Calculate Yearly Fund Value

-(double)ReturnFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	
}



-(double)ReturnFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnMonthFundValueOfTheYearValueTotalHigh: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	[self ReturnMonthFundValueOfTheYearVURetValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2023ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2025ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2028ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2030ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
	[self ReturnMonthFundValueOfTheYearVU2035ValueHigh:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];
			

	return MonthVU2023ValueHigh + MonthVU2025ValueHigh + MonthVU2028ValueHigh + MonthVU2030ValueHigh + MonthVU2035ValueHigh + MonthVURetValueHigh;
	//return  0;
	
}

-(double)ReturnMonthFundValueOfTheYearVU2023ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueHigh = [self ReturnVU2023ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2023ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{

	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueHigh = [self ReturnVU2025ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2025ValueHigh;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueHigh = [self ReturnVU2028ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2028ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueHigh = [self ReturnVU2030ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2030ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueHigh = [self ReturnVU2035ValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2035ValueHigh;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueHigh: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	MonthVURetValueHigh = [self ReturnVURetValueHigh:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return MonthVURetValueHigh;
}

-(double)ReturnFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear{
	
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		
		return [self ReturnFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"Y"];
	}
	 
}


-(double)ReturnFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth {
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	//return VURetValueMedian;
	return [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}

-(double)ReturnMonthFundValueOfTheYearValueTotalMedian: (int)aaPolicyYear andMonth:(int)aaMonth{
	
	 return [self ReturnMonthFundValueOfTheYearVU2023ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2025ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2028ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2030ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2035ValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVURetValueMedian:aaPolicyYear andYearOrMonth:@"M" andMont:aaMonth];
	 
	
	
}


-(double)ReturnMonthFundValueOfTheYearVU2023ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueMedian = [self ReturnVU2023ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2023ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueMedian = [self ReturnVU2025ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	MonthVU2025ValueMedian;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueMedian = [self ReturnVU2028ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	MonthVU2028ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueMedian = [self ReturnVU2030ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	MonthVU2030ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueMedian = [self ReturnVU2035ValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return 	MonthVU2035ValueMedian;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueMedian: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMont:(int)aaMonth{
	MonthVURetValueMedian = [self ReturnVURetValueMedian:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return 	MonthVURetValueMedian;
}

-(double)ReturnFundValueOfTheYearValueTotalLow: (int)aaPolicyYear{
	if (aaPolicyYear == YearDiff2035 || aaPolicyYear == YearDiff2030 || aaPolicyYear == YearDiff2028
		|| aaPolicyYear == YearDiff2025 || aaPolicyYear == YearDiff2023) {
		return [self ReturnFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M"] +
		[self ReturnFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M"];
	}
	else{
		return [self ReturnFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"Y"] +
		[self ReturnFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"Y"];
	}
	
	

}


-(double)ReturnFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2023) {
		return [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2025) {
		return [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}


-(double)ReturnFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2028) {
		return [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2030) {
		return [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	if (aaPolicyYear <= YearDiff2035) {
		return [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
	} else {
		return 0;
	}
}

-(double)ReturnFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth{
	return [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:0];
}


-(double)ReturnMonthFundValueOfTheYearValueTotalLow: (int)aaPolicyYear andMonth:(int)aaMonth{

	 return [self ReturnMonthFundValueOfTheYearVU2023ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2025ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2028ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2030ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVU2035ValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth] +
	 [self ReturnMonthFundValueOfTheYearVURetValueLow:aaPolicyYear andYearOrMonth:@"M" andMonth:aaMonth];


}

-(double)ReturnMonthFundValueOfTheYearVU2023ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2023) {
		MonthVU2023ValueLow = [self ReturnVU2023ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2023ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2025ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2025) {
		MonthVU2025ValueLow = [self ReturnVU2025ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2025ValueLow;
	} else {
		return 0;
	}
}


-(double)ReturnMonthFundValueOfTheYearVU2028ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2028) {
		MonthVU2028ValueLow = [self ReturnVU2028ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2028ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2030ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2030) {
		MonthVU2030ValueLow = [self ReturnVU2030ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2030ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVU2035ValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	if (aaPolicyYear <= YearDiff2035) {
		MonthVU2035ValueLow = [self ReturnVU2035ValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
		return MonthVU2035ValueLow;
	} else {
		return 0;
	}
}

-(double)ReturnMonthFundValueOfTheYearVURetValueLow: (int)aaPolicyYear andYearOrMonth:(NSString *)aaYearOrMonth andMonth:(int)aaMonth{
	MonthVURetValueLow = [self ReturnVURetValueLow:aaPolicyYear andYearOrMonth:aaYearOrMonth andRound:1 andMonth:aaMonth];
	return MonthVURetValueLow;
}



#pragma mark - Others
-(double)ReturnVU2023Fac{
	return (double)VU2023Factor/100.00;
}

-(double)ReturnVU2025Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2025Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTerm2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear > FundTerm2025){
		return factor3/100.00;
	}
	else{
		return (double)VU2025Factor/100.00;
	}
}

-(double)ReturnVU2025Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2025Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025){
		return factor2/100.00;
	}
	else if (aaPolicyYear > FundTerm2025 && aaMonth > MonthDiff2025){
		return factor3/100.00;
	}
	else{
		return (double)VU2025Factor/100.00;
	}
}

-(double)ReturnVU2028Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2028Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTerm2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTerm2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear > FundTerm2028){
		return factor4/100.00;
	}
	else{
		return (double)VU2028Factor/100.00;
	}
}

-(double)ReturnVU2028Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2028Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025) {
		return factor3/100.00;
	}
	else if (aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear > FundTerm2028 && aaMonth > MonthDiff2028){
		return factor4/100.00;
	}
	else{
		return (double)VU2028Factor/100.00;
	}
}

-(double)ReturnVU2030Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2030Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);;
	double factor5 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTerm2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTerm2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTerm2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear > FundTerm2030){
		return factor5/100.00;
	}
	else{
		return (double)VU2030Factor/100.00;
	}
}

-(double)ReturnVU2030Fac :(int)aaPolicyYear andMonth:(int)aaMonth {
	double factor1 = (double)VU2030Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);;
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);;
	double factor5 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023) {
		return factor2/100.00;
	}
	else if (aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025) {
		return factor3/100.00;
	}
	else if (aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028) {
		return factor4/100.00;
	}
	else if (aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear > FundTerm2030 && aaMonth > MonthDiff2030) {
		return factor5/100.00;
	}
	else{
		return (double)VU2030Factor/100.00;
	}
}

-(double)ReturnVU2035Fac :(int)aaPolicyYear {
	double factor1 = (double)VU2035Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
	double factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
	double factor6 = 0.00;
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTerm2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTerm2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTerm2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTerm2035) {
		return factor5/100.00;
	}
	else if (aaPolicyYear > FundTerm2030){
		return factor6/100.00;
	}
	else{
		return (double)VU2035Factor/100.00;
	}
}

-(double)ReturnVU2035Fac :(int)aaPolicyYear andMonth:(int)aaMonth   {
	double factor1 = (double)VU2035Factor;
	double factor2 = factor1 + (double)VU2023Factor * (factor1/[self FactorGroup:2]);
	double factor3 = factor2 + (double)VU2025Factor * (factor2/[self FactorGroup:3]);
	double factor4 = factor3 + (double)VU2028Factor * (factor3/[self FactorGroup:4]);
	double factor5 = factor4 + (double)VU2030Factor * (factor4/[self FactorGroup:5]);
	double factor6 = 0.00;
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2025){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VU2035Factor/100.00;
	}
	
	
}


-(double)ReturnVUCashFac :(int)aaPolicyYear {
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if(VUCashOptFactor > 0 && [self FactorGroup:2] == 0){
		factor2 = (double)VUCashOptFactor;
	}
	else{
		factor2 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:3] == 0){
		factor3 = (double)VUCashOptFactor;
	}
	else{
		factor3 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:4] == 0){
		factor4 = (double)VUCashOptFactor;
	}
	else{
		factor4 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:5] == 0){
		factor5 = (double)VUCashOptFactor;
	}
	else{
		factor5 = (double)VUCashFactor;
	}
	
	if(VUCashOptFactor > 0 && [self FactorGroup:6] == 0){
		factor6 = (double)VUCashOptFactor;
	}
	else{
		factor6 = (double)VUCashFactor;
	}
	
	
		if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTerm2025){
			return factor2/100.00;
		}
		else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTerm2028){
			return factor3/100.00;
		}
		else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTerm2030){
			return factor4/100.00;
		}
		else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTerm2035){
			return factor5/100.00;
		}
		else if(aaPolicyYear > FundTerm2035){
			return factor6/100.00;
		}
		else{
			return (double)VUCashFactor/100.00;
		}
		
}

-(double)ReturnVUCashFac :(int)aaPolicyYear andMonth:(int)aaMonth  {
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if(VUCashOptFactor > 0 && [self FactorGroup:2] == 0){
		factor2 = (double)VUCashOptFactor;
	}
	else{
		factor2 = (double)VUCashFactor;
	}

	if(VUCashOptFactor > 0 && [self FactorGroup:3] == 0){
		factor3 = (double)VUCashOptFactor;
	}
	else{
		factor3 = (double)VUCashFactor;
	}

	if(VUCashOptFactor > 0 && [self FactorGroup:4] == 0){
		factor4 = (double)VUCashOptFactor;
	}
	else{
		factor4 = (double)VUCashFactor;
	}

	if(VUCashOptFactor > 0 && [self FactorGroup:5] == 0){
		factor5 = (double)VUCashOptFactor;
	}
	else{
		factor5 = (double)VUCashFactor;
	}

	if(VUCashOptFactor > 0 && [self FactorGroup:6] == 0){
		factor6 = (double)VUCashOptFactor;
	}
	else{
		factor6 = (double)VUCashFactor;
	}

		if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
			return factor2/100.00;
		}
		else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2023){
			return factor2/100.00;
		}
		else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
			return factor3/100.00;
		}
		else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
			return factor3/100.00;
		}
		else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
			return factor4/100.00;
		}
		else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
			return factor4/100.00;
		}
		else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
			return factor5/100.00;
		}
		else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
			return factor5/100.00;
		}
		else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
			return factor6/100.00;
		}
		else{
			return (double)VUCashFactor/100.00;
		}
	
}

-(double)ReturnVURetFac :(int)aaPolicyYear {
	double factor1;
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if (VURetFactor > 0) {
		factor1 =(double)VURetFactor;
		factor2 = factor1 + (double)VU2023Factor * (double)(factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (double)(factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (double)(factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (double)(factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (double)(factor5/[self FactorGroup:6]);
	}
	else if (VURetOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VURetOptFactor;
		}
		else{
			factor2 = 0.00;
		}
			
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VURetOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VURetOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VURetOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VURetOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	
	if (aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025) {
		return factor2/100.00;
	}
	else if (aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028) {
		return factor3/100.00;
	}
	else if (aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030) {
		return factor4/100.00;
	}
	else if (aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035) {
		return factor5/100.00;
	}
	else if (aaPolicyYear > FundTerm2025) {
		return factor6/100.00;
	}
	else{
		return (double)VURetFactor/100.00;
	}
}

-(double)ReturnVURetFac :(int)aaPolicyYear andMonth:(int) aaMonth {
	double factor1;
	double factor2;
	double factor3;
	double factor4;
	double factor5;
	double factor6;
	
	if (VURetFactor > 0) {
		factor1 =(double)VURetFactor;
		factor2 = factor1 + (double)VU2023Factor * (double)(factor1/[self FactorGroup:2]);
		factor3 = factor2 + (double)VU2025Factor * (double)(factor2/[self FactorGroup:3]);
		factor4 = factor3 + (double)VU2028Factor * (double)(factor3/[self FactorGroup:4]);
		factor5 = factor4 + (double)VU2030Factor * (double)(factor4/[self FactorGroup:5]);
		factor6 = factor5 + (double)VU2035Factor * (double)(factor5/[self FactorGroup:6]);
	}
	else if (VURetOptFactor > 0){
		if ([self FactorGroup:2] == 0) {
			factor2 = (double)VURetOptFactor;
		}
		else{
			factor2 = 0.00;
		}
		
		if ([self FactorGroup:3] == 0) {
			factor3 = (double)VURetOptFactor;
		}
		else{
			factor3 = 0.00;
		}
		
		if ([self FactorGroup:4] == 0) {
			factor4 = (double)VURetOptFactor;
		}
		else{
			factor4 = 0.00;
		}
		
		if ([self FactorGroup:5] == 0) {
			factor5 = (double)VURetOptFactor;
		}
		else{
			factor5 = 0.00;
		}
		
		if ([self FactorGroup:6] == 0) {
			factor6 = (double)VURetOptFactor;
		}
		else{
			factor6 = 0.00;
		}
	}
	
	if(aaPolicyYear >= FundTerm2023 && aaPolicyYear <= FundTermPrev2025 && aaMonth > MonthDiff2023 ){
		return factor2/100.00;
	}
	else if(aaPolicyYear == FundTerm2025 && aaMonth <= MonthDiff2023){
		return factor2/100.00;
	}
	else if(aaPolicyYear >= FundTerm2025 && aaPolicyYear <= FundTermPrev2028 && aaMonth > MonthDiff2025 ){
		return factor3/100.00;
	}
	else if(aaPolicyYear == FundTerm2028 && aaMonth <= MonthDiff2028){
		return factor3/100.00;
	}
	else if(aaPolicyYear >= FundTerm2028 && aaPolicyYear <= FundTermPrev2030 && aaMonth > MonthDiff2028 ){
		return factor4/100.00;
	}
	else if(aaPolicyYear == FundTerm2030 && aaMonth <= MonthDiff2030){
		return factor4/100.00;
	}
	else if(aaPolicyYear >= FundTerm2030 && aaPolicyYear <= FundTermPrev2035 && aaMonth > MonthDiff2030 ){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth <= MonthDiff2035){
		return factor5/100.00;
	}
	else if(aaPolicyYear > FundTermPrev2035 && aaMonth > MonthDiff2035){
		return factor6/100.00;
	}
	else{
		return (double)VURetFactor/100.00;
	}
}



-(double)FactorGroup : (uint)aaGroup{
	if (aaGroup == 1) {
		return VU2023Factor + VU2025Factor + VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor;
	}
	else if (aaGroup == 2) {
		return VU2025Factor + VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor;
	}
	else if (aaGroup == 3) {
		return VU2028Factor + VU2030Factor + VU2035Factor + VURetFactor;
	}
	else if (aaGroup == 4) {
		return VU2030Factor + VU2035Factor + VURetFactor;
	}
	else if (aaGroup == 5) {
		return VU2035Factor + VURetFactor;
	}
	else {
		return VURetFactor;
	}
}

-(double)ReturnTotalBasicMortHigh: (int)aaPolicyYear{
	return [txtBasicSA.text doubleValue ] * (([self ReturnBasicMort:ageClient + aaPolicyYear -1]/1000.00) * (1 + [getHLPct doubleValue ]/100.00) +
												  [getHL doubleValue] + [getOccLoading doubleValue ])/12.00;
}

-(double)ReturnTotalBasicMortMedian: (int)aaPolicyYear{
	return [txtBasicSA.text doubleValue ] * (([self ReturnBasicMort:ageClient + aaPolicyYear -1]/1000.00) * (1 + [getHLPct doubleValue ]/100.00) +
												  [getHL doubleValue] + [getOccLoading doubleValue ])/12.00;
}

-(double)ReturnTotalBasicMortLow: (int)aaPolicyYear{
	return [txtBasicSA.text doubleValue ] * (([self ReturnBasicMort:ageClient + aaPolicyYear -1]/1000.00) * (1 + [getHLPct doubleValue ]/100.00) +
												  [getHL doubleValue] + [getOccLoading doubleValue ])/12.00;
}

-(double)ReturnVUCashHigh{
	double VUCashHighS = pow((1.00 + [self ReturnVUCashInstHigh:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashHighS), 12.00) - 1.00)/(VUCashHighS / (1.00 + VUCashHighS));
}

-(double)ReturnVUCashMedian{
	double VUCashMedianS = pow((1.00 + [self ReturnVUCashInstMedian:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashMedianS), 12.00) - 1.00)/(VUCashMedianS / (1.00 + VUCashMedianS));
}

-(double)ReturnVUCashLow{
	double VUCashLowS = pow((1.00 + [self ReturnVUCashInstLow:@""]), 1.00/12.00) - 1.00 ;
	
	return (pow((1.00 + VUCashLowS), 12) - 1)/(VUCashLowS / (1.00 + VUCashLowS));
}

-(double)ReturnVU2023InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0532298;
	}
}

-(double)ReturnVU2025InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0588615;
	}
}

-(double)ReturnVU2028InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0739896;
	}
}

-(double)ReturnVU2030InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.077761;
	}
}

-(double)ReturnVU2035InstHigh: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0817997;
	}
}

-(double)ReturnVU2023InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0290813;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2025InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0340098;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2028InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0389747;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2030InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0413285;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2035InstMedian: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0439735;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2023InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0113432;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2025InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.01146;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2028InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0121202;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2030InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0121884;
	}
	else{
		return 0;
	}
}

-(double)ReturnVU2035InstLow: (NSString *)aaMOP{
	if ([aaMOP isEqualToString:@"A"]) {
		return 0.0122828;
	}
	else{
		return 0;
	}
}

-(void)CalcInst: (NSString *)aaMOP{
	sqlite3_stmt *statement;
	NSString *querySQL;
	NSString *MOP;
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = [self ReturnBumpMode];
	} else {
		MOP = aaMOP;
	}
	
	if (sqlite3_open([UL_databasePath UTF8String], &contactDB) == SQLITE_OK){
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
			  VU2023InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}

		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '13' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2023InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		//------------
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}

		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2025InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}

			if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW){
					VU2025InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
				}
				sqlite3_finalize(statement);
			}

		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '15' AND Fund_Year = '1'"];
		}
		
			if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_ROW){
					VU2025InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
				}
				sqlite3_finalize(statement);
			}
		
		//-----------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '18' AND Fund_Year = '1'"];
		}
		

		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2028InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		//--------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '20' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2030InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		// ----------
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bull_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstHigh = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Flat_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstMedian = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		if ([MOP isEqualToString:@"A"]) {
			querySQL = [NSString stringWithFormat:@"Select Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"S"]) {
			querySQL = [NSString stringWithFormat:@"Select Half_Year_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else if ([MOP isEqualToString:@"Q"]) {
			querySQL = [NSString stringWithFormat:@"Select Quarter_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		else {
			querySQL = [NSString stringWithFormat:@"Select Month_Bear_Rate From ES_Sys_Fund_Growth_Rate WHERE Fund_Term = '25' AND Fund_Year = '1'"];
		}
		
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				VU2035InstLow = [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] doubleValue ];
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
}

-(double)ReturnVUCashInstHigh :(NSString *)aaMOP{
	
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = [self ReturnBumpMode];
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0251;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0187861;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0156389;
	}
	else {
		return 0.0135443;
	}
}

-(double)ReturnVUCashInstMedian :(NSString *)aaMOP{
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = [self ReturnBumpMode];
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0228;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.0170679;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.0142098;
	}
	else {
		return 0.0123075;
	}
}

-(double)ReturnVUCashInstLow :(NSString *)aaMOP{
	NSString *MOP;
	if ([aaMOP isEqualToString:@""]) {
		MOP = [self ReturnBumpMode];
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		return 0.0205;
	}
	else if ([MOP isEqualToString:@"S"]) {
		return 0.015349;
	}
	else if ([MOP isEqualToString:@"Q"]) {
		return 0.01278;
	}
	else {
		return 0.0110697;
	}
}

-(double)ReturnVURetInstHigh :(int)aaPolicyYear  andMOP:(NSString *)aaMOP{
	NSString *MOP = [self ReturnBumpMode];
	
	if ([aaMOP isEqualToString:@""]) {
		MOP = [self ReturnBumpMode];
	}
	else{
		MOP = aaMOP;
	}
	
	if ([MOP isEqualToString:@"A"]) {
		if (aaPolicyYear <= 20) {
			return 0.05808;
		}
		else{
			return 0.03784;
		}
	}
	else if ([MOP isEqualToString:@"S"]) {
		if (aaPolicyYear <= 20) {
			return 0.0433551;
		}
		else{
			return 0.0282922;
		}
	}
	else if ([MOP isEqualToString:@"Q"]) {
		if (aaPolicyYear <= 20) {
			return 0.0360438;
		}
		else{
			return 0.0235402;
		}
	}
	else {
		if (aaPolicyYear <= 20) {
			return 0.0311887;
		}
		else{
			return 0.0203804;
		}
	}
}

-(double)ReturnVURetInstMedian{
	
	if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
		return 0.03324;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
		return 0.0248621;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
		return 0.0206901;
	}
	else {
		return 0.0179151;
	}
}

-(double)ReturnVURetInstLow{
	if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
		return 0.02312;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
		return 0.017307;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
		return 0.0144087;
	}
	else {
		return 0.0124796;
	}
}

-(double)ReturnLoyaltyBonus :(int)aaPolicyYear{
	if (aaPolicyYear == 7) {
		return 0.04;
	}
	else if (aaPolicyYear == 8){
		return 0.08;
	}
	else if (aaPolicyYear == 9){
		return 0.12;
	}
	else if (aaPolicyYear == 10){
		return 0.16;
	}
	else if (aaPolicyYear > 10){
		return 0.2;
	}
	else{
		return 0;
	}
}

-(int)ReturnLoyaltyBonusFactor: (int)aaMonth{
	if (aaMonth == 1) {
		return 1;
	}
	else{
		return 0;
	}
}

-(double)ReturnPremiumFactor: (int)aaMonth{
	NSString *MOP = [self ReturnBumpMode];
	
	if ([MOP isEqualToString:@"A" ]) {
		if (aaMonth == 1) {
			return 1.00;
		}
		else{
			return 0;
		}
	}
	else if([MOP isEqualToString:@"S" ]) {
		if (aaMonth == 1 || aaMonth == 7 ) {
			return 0.5;
		}
		else{
			return 0;
		}
	}
	else if([MOP isEqualToString:@"Q" ]) {
		if (aaMonth == 1 || aaMonth == 4 || aaMonth == 7 || aaMonth == 10 ) {
			return 0.25;
		}
		else{
			return 0;
		}
	}
	else {
		return 1.00/12.00;
	}

}

-(void)CalcYearDiff{
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* d = [df dateFromString:getPlanCommDate];
	NSDate* d2 = [df dateFromString:@"26/12/2023"];
	NSDate* d3 = [df dateFromString:@"26/12/2025"];
	NSDate* d4 = [df dateFromString:@"26/12/2028"];
	NSDate* d5 = [df dateFromString:@"26/12/2030"];
	NSDate* d6 = [df dateFromString:@"26/12/2035"];
	NSDate *fromDate;
    NSDate *toDate2;
	NSDate *toDate3;
	NSDate *toDate4;
	NSDate *toDate5;
	NSDate *toDate6;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:d];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate2
				 interval:NULL forDate:d2];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate3
				 interval:NULL forDate:d3];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate4
				 interval:NULL forDate:d4];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate5
				 interval:NULL forDate:d5];
	[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate6
				 interval:NULL forDate:d6];
	
    NSDateComponents *difference2 = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate toDate:toDate2 options:0];
    NSDateComponents *difference3 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate3 options:0];
    NSDateComponents *difference4 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate4 options:0];
    NSDateComponents *difference5 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate5 options:0];
    NSDateComponents *difference6 = [calendar components:NSDayCalendarUnit
												fromDate:fromDate toDate:toDate6 options:0];

	
	NSString *round2 = [NSString stringWithFormat:@"%.2f", [difference2 day]/365.25];
	NSString *round3 = [NSString stringWithFormat:@"%.2f", [difference3 day]/365.25];
	NSString *round4 = [NSString stringWithFormat:@"%.2f", [difference4 day]/365.25];
	NSString *round5 = [NSString stringWithFormat:@"%.2f", [difference5 day]/365.25];
	NSString *round6 = [NSString stringWithFormat:@"%.2f", [difference6 day]/365.25];
	

	//YearDiff2023 = round([round2 doubleValue]);
	//YearDiff2025 = round([round3 doubleValue]);
	//YearDiff2028 = round([round4 doubleValue]);
	//YearDiff2030 = round([round5 doubleValue]);
	//YearDiff2035 = round([round6 doubleValue]);

	YearDiff2023 = ceil([round2 doubleValue]);
	YearDiff2025 = ceil([round3 doubleValue]);
	YearDiff2028 = ceil([round4 doubleValue]);
	YearDiff2030 = ceil([round5 doubleValue]);
	YearDiff2035 = ceil([round6 doubleValue]);

	FundTermPrev2023 = YearDiff2023 - 1;
	FundTerm2023 = YearDiff2023;
	FundTermPrev2025 = YearDiff2025 - 1;
	FundTerm2025 = YearDiff2025;
	FundTermPrev2028 = YearDiff2028 - 1;
	FundTerm2028 = YearDiff2028;
	FundTermPrev2030 = YearDiff2030 - 1;
	FundTerm2030 = YearDiff2030;
	FundTermPrev2035 = YearDiff2035 - 1;
	FundTerm2035 = YearDiff2035;
	
	MonthDiff2023 = ceil(([round2 doubleValue ] - (YearDiff2023 - 1))/(1.00/12.00));
	MonthDiff2025 = ceil(([round3 doubleValue ] - (YearDiff2025 - 1))/(1.00/12.00));
	MonthDiff2028 = ceil(([round4 doubleValue ] - (YearDiff2028 - 1))/(1.00/12.00));
	MonthDiff2030 = ceil(([round5 doubleValue ] - (YearDiff2030 - 1))/(1.00/12.00));
	MonthDiff2035 = ceil(([round6 doubleValue ] - (YearDiff2035 - 1))/(1.00/12.00));
	
	NSLog(@"yeardiff2023:%d, yeardiff2025:%d, yeardiff2028:%d, yeardiff2030:%d,yeardiff2035:%d ", YearDiff2023,YearDiff2025,
		  YearDiff2028, YearDiff2030, YearDiff2035);

	
	if (MonthDiff2023 == 12) {
		Allo2023 = YearDiff2023 + 1;
	}
	else{
		Allo2023 = YearDiff2023;
	}
	
	if (MonthDiff2025 == 12) {
		Allo2025 = YearDiff2025 + 1;
	}
	else{
		Allo2025 = YearDiff2025;
	}
	
	if (MonthDiff2028 == 12) {
		Allo2028 = YearDiff2028 + 1;
	}
	else{
		Allo2028 = YearDiff2028;
	}
	
	if (MonthDiff2030 == 12) {
		Allo2030 = YearDiff2030 + 1;
	}
	else{
		Allo2030 = YearDiff2030;
	}
	
	if (MonthDiff2035 == 12) {
		Allo2035 = YearDiff2035 + 1;
	}
	else{
		Allo2035 = YearDiff2035;
	}
	 
	
	NSDate* aa = [df dateFromString:getPlanCommDate];
	NSDateComponents* components2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												fromDate:aa];
	CommMonth = [components2 month];
}

-(double)ReturnModeRate: (NSString *)MOP{
	if ([MOP isEqualToString:@"A"]) {
		return 0.85;
	}
	else if ([MOP isEqualToString:@"S"]){
		return 0.9;
	}
	else if ([MOP isEqualToString:@"Q"]){
		return 0.9;
	}
	else{
		return 0.95;
	}
}

-(double)ReturnExcessPrem: (int)aaPolicyYear{
	if ([txtRTUP.text isEqualToString:@""]) {
		return 0;
	}
	else {
		if (aaPolicyYear >= [txtCommFrom.text intValue ] && aaPolicyYear <= [txtCommFrom.text intValue] + [txtFor.text intValue] ) {
			return [txtRTUP.text doubleValue ];
		}
		else{
			return 0;
		}
	}
}

-(double)ReturnDivideMode{
	if ([[self ReturnBumpMode] isEqualToString:@"A"]) {
		return 1.00;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"S"]) {
		return 2.00;
	}
	else if ([[self ReturnBumpMode] isEqualToString:@"Q"]) {
		return 4.00;
	}
	else{
		return 12.00;
	}
}

-(double)ReturnPremAllocation: (int)aaPolYear{
	if (aaPolYear == 1) {
		if ([txtBasicPremium.text doubleValue ] >= 12000 && [txtBasicPremium.text doubleValue ] < 24000 ) {
			return 0.4 + 0.02;
		}
		else if ([txtBasicPremium.text doubleValue ] >= 24000){
			return 0.4 + 0.04;
		}
		else{
			return 0.4;
		}
	}
	else if (aaPolYear == 2){
		if ([txtBasicPremium.text doubleValue ] >= 12000 && [txtBasicPremium.text doubleValue ] < 24000 ) {
			return 0.52 + 0.02;
		}
		else if ([txtBasicPremium.text doubleValue ] >= 24000){
			return 0.52 + 0.04;
		}
		else{
			return 0.52;
		}
		
	}
	else if (aaPolYear == 3){
		return 0.785;
	}
	else if (aaPolYear == 4){
		return 0.835;
	}
	else if (aaPolYear >=5 && aaPolYear < 7){
		return 0.925;
	}
	else{
		return 1.00;
	}
}

-(double)ReturnBasicMort: (int)zzAge{
	NSString *MortRate;
	sqlite3_stmt *statement;
	NSString *querySQL;
	
	querySQL = [NSString stringWithFormat:@"Select Rate From ES_Sys_Basic_Mort WHERE PlanCode = '%@' AND Sex = '%@' AND Age='%d' AND Smoker ='%@' "
				 , getPlanCode, getSexLA, zzAge, getSmokerLA];
	
	//NSLog(@"%@", querySQL);
	if (sqlite3_open([UL_databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW){
				MortRate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	return [MortRate doubleValue];
}

-(int)GetMortDate{
	
	
	if (![getPlanCommDate isEqualToString:@""] && ![getDOB isEqualToString:@""]  ) {
		
		NSDateFormatter* df = [[NSDateFormatter alloc] init];
		[df setDateFormat:@"dd/MM/yyyy"];
     	NSDate* d = [df dateFromString:getDOB];
		NSDate* d2 = [df dateFromString:getPlanCommDate];
		
		NSCalendar* calendar = [NSCalendar currentCalendar];
		NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												   fromDate:d];
		NSDateComponents* components2 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
												   fromDate:d2];
		
		if ([components month] == [components2 month] && [components day] == [components2 day]) {
			return 12;
		}
		else{
			return 12 - ([self monthsBetweenDate:d andDate:d2])%12;

		}
	}
	else{
		NSLog(@"error, no DOB and plan Comm date");
		return -1;
	}
}

- (NSUInteger)monthsBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSLog(@"%@ %@", fromDateTime, toDateTime);
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:NSMonthCalendarUnit
											   fromDate:fromDate toDate:toDate options:0];

    return [difference month];
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate toDate:toDate options:0];
	
    return [difference day];
}
*/
-(void)InsertIntoTPExcess{
	sqlite3_stmt *statement;
	NSString *insertSQL;
	
	insertSQL = [NSString stringWithFormat:@"INSERT INTO UL_TPExcess (SINO, FromYear, YearInt, Amount, ForYear) VALUES ('%@', '%d','%@','%@','%d') "
				 , getSINo, 1 + [txtCommFrom.text intValue], @"1", txtRTUP.text,  [txtFor.text intValue ] - 1];
	
	//NSLog(@"%@", insertSQL);
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE){
				
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)UpdateTPExcess{
	sqlite3_stmt *statement;
	NSString *insertSQL;
	
	insertSQL = [NSString stringWithFormat:@"UPDATE UL_TPExcess set FromYear= '%d', YearInt='%@', Amount='%@', ForYear='%d' WHERE SINO = '%@' "
				 , 1 + [txtCommFrom.text intValue], @"1", txtRTUP.text, [txtFor.text intValue ] - 1, getSINo];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE){
				
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}

-(void)DeleteTPExcess{
	sqlite3_stmt *statement;
	NSString *insertSQL;
	
	insertSQL = [NSString stringWithFormat:@"DELETE FROM UL_TPExcess WHERE SINO = '%@' ", getSINo];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE){
				
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
}


-(void)updateLA
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Clt_Profile SET CustCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\" "
							  "WHERE id=\"%d\"",LACustCode,currentdate,idProf];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE){
                //save
            }
            else {
                //failed
            }
            sqlite3_finalize(statement);
        }
        
        NSString *querySQL2 = [NSString stringWithFormat:
							   @"UPDATE UL_LAPayor SET SINo=\"%@\", CustCode=\"%@\", DateModified=\"%@\", "
							   "ModifiedBy=\"hla\" WHERE rowid=\"%d\"",SINo,LACustCode,currentdate,idPay];
        
		//        NSLog(@"%@",querySQL2);
        if (sqlite3_prepare_v2(contactDB, [querySQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE){
                //save
            }
            else {
                //failed
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void)savePayor
{
    [self getRunningCustCode];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoCust = CustLastNo + 1;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
		
    PYCustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO UL_LAPayor (SINo, CustCode,PTypeCode,Seq,DateCreated,CreatedBy) VALUES "
							   "(\"%@\",\"%@\",\"PY\",\"1\",\"%@\",\"hla\")",SINo, PYCustCode,dateStr];
        
		//        NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA");
            } else {
                NSLog(@"Failed LA");
            }
            sqlite3_finalize(statement);
        }
        
        int ANB =PayorAge + 1;
        NSString *insertSQL2 = [NSString stringWithFormat:
                                @"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, "
								"CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",
								PYCustCode, NamePP, PayorSmoker, PayorSex, PayorDOB, PayorAge, ANB, PayorOccpCode, dateStr,PayorIndexNo];
		
		//        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                
            } else {
                NSLog(@"Failed LA2");
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)saveSecondLA
{
    [self getRunningCustCode];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoCust = CustLastNo + 1;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
	
    secondLACustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO UL_LAPayor (SINo, CustCode,PTypeCode,Seq,DateCreated,CreatedBy) VALUES "
							   "(\"%@\",\"%@\",\"LA\",\"2\",\"%@\",\"hla\")",SINo, secondLACustCode,dateStr];
        
		//        NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA");
            } else {
                NSLog(@"Failed LA");
            }
            sqlite3_finalize(statement);
        }
        
        int ANB = secondLAAge + 1;
        NSString *insertSQL2 = [NSString stringWithFormat:
								@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) "
								"VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",
								secondLACustCode, NamePP, secondLASmoker, secondLASex, secondLADOB, secondLAAge, ANB, secondLAOccpCode,
								dateStr,secondLAIndexNo];
        
		//        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                
            } else {
                NSLog(@"Failed LA2");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


-(NSString *)ReturnBumpMode{
	
	NSString *result;
	
	if (segPremium.selectedSegmentIndex == 0) {
		result = @"A";
	}
	else if (segPremium.selectedSegmentIndex == 1){
		result = @"S";
	}
	else if (segPremium.selectedSegmentIndex == 2){
		result = @"Q";
	}
	else if (segPremium.selectedSegmentIndex == 3){
		result = @"M";
	}
	
	return result;
}

-(void)getRunningSI
{
    sqlite3_stmt *statement;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"UL\" AND LastUpdated "
							  "like \"%%%@%%\"", dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                SILastNo = sqlite3_column_int(statement, 0);
                
                const char *lastDate = (const char *)sqlite3_column_text(statement, 1);
                SIDate = lastDate == NULL ? nil : [[NSString alloc] initWithUTF8String:lastDate];
                
                NSLog(@"LastSINo:%d SIDate:%@",SILastNo,SIDate);
                
            } else {
                SILastNo = 0;
                SIDate = dateString;
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
                              @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"CL\" AND "
							  "LastUpdated like \"%%%@%%\" ",dateString];
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
                              @"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated=\"%@\" WHERE TrnTypeCode=\"UL\"",
							  newLastNo, dateString];
        
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
                              @"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated= \"%@\" WHERE TrnTypeCode=\"CL\"",
							  newLastNo,dateString];
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

-(void)CalcTotalRiderPrem{
	
	sqlite3_stmt *statement;
	NSString *querySQL;
	//double half = 0.5, quarter = 0.25, month = 0.0833333;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:
					@"SELECT sum(round(premium, 2)) from ul_rider_details where sino = '%@' ",  getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW)
			{
				//txtRiderPremium.text =  [ NSString stringWithFormat:@"%.2f", sqlite3_column_double(statement, 0) ] ;
				TotalRiderPremium =  sqlite3_column_double(statement, 0);
			}
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
	
}


#pragma mark - memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
	[self setMyScrollView:nil];
	[self setOutletBasic:nil];
	[self setTxtPolicyTerm:nil];
	[self setSegPremium:nil];
	[self setTxtBasicPremium:nil];
	[self setTxtBasicSA:nil];
	[self setTxtGrayRTUP:nil];
	[self setTxtRTUP:nil];
	[self setTxtCommFrom:nil];
	[self setTxtFor:nil];
	[self setTxtBUMP:nil];
	[self setTxtTotalBAPremium:nil];
	[self setTxtPremiumPayable:nil];
	[self setLabel1:nil];
	[self setLabel2:nil];
	[self setLabelComm:nil];
	[self setLabelFor:nil];
	[super viewDidUnload];
}

#pragma mark - handle data
-(void)checkingExisting
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SINo FROM UL_Details WHERE SINo=\"%@\"",SINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"error access Trad_Details");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (getSINo.length != 0) {
        useExist = YES;
    } else {
        useExist = NO;
    }
}


#pragma mark - button

- (IBAction)ACtionBasic:(id)sender {
	[self resignFirstResponder];
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
    if (_planList == nil) {
        self.planList = [[PlanList alloc] init];
        _planList.delegate = self;
		self.planList.TradOrEver = @"EVER";
        self.planPopover = [[UIPopoverController alloc] initWithContentViewController:_planList];
    }

	[self.planPopover setPopoverContentSize:CGSizeMake(350.0f, 200.0f)];
    [self.planPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}

-(BOOL)NewDone{
	if([self Validation] == TRUE){
		[self checkingExisting];
		[self checkingSave];
		return TRUE;
	}
	else{
		return FALSE;
	}
}

- (IBAction)ActionDone:(id)sender {
	[self resignFirstResponder];
    [self.view endEditing:YES];
	
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
		if([self Validation] == TRUE){
			[self checkingExisting];
			/*
			NSString *msg;
			if (useExist) {
				msg = @"Confirm changes?";
			} else {
				msg = @"Confirm creating new record?";
			}
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1003];
			[alert show];
			*/
			[self checkingSave];
			[_delegate BasicGlobalSave];
		}
		
	}
}

-(void)CheckBump{
	
}

-(BOOL)Validation{
	
	NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSCharacterSet *setTerm = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    //NSRange rangeofDotSA = [txtBasicSA.text rangeOfString:@"."];
	
	if (OccpCode.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1001];
        [alert show];
		return FALSE;
    }
	else if ([getPlanCode isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Please select plan."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if (ageClient > 70 && [getPlanCode isEqualToString:@"UV"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Age Last Birthday must be less than or equal to 70 for this product."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if ([txtBasicPremium.text isEqualToString:@"" ]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:@"Basic Premium is required." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		txtBasicPremium.text = @"";
        [txtBasicPremium becomeFirstResponder];
		return FALSE;
    }
    else if ([txtBasicPremium.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:@"Invalid input format. Basic Premium must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		txtBasicPremium.text = @"";
        [txtBasicPremium becomeFirstResponder];
		return FALSE;
    }
	else if ([txtBasicPremium.text doubleValue] < round(minPremium)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Basic Annual Premium must be at least %.0f",minPremium] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtBasicPremium becomeFirstResponder];
		return FALSE;
    }
	else if ([txtBasicSA.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Basic Sum Assured is required"] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
		[txtBasicSA becomeFirstResponder];
		return FALSE;
    }
    else if ([txtBasicSA.text intValue] < floor(minSA)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Basic Sum Assured must be greater or equal to %.0f", minSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1004;
		[alert show];
		[txtBasicSA becomeFirstResponder];
		//txtBasicSA.text = [NSString stringWithFormat:@"%.0f", minSA];
		return FALSE;
        
    }
	else if ([txtBasicSA.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:@"Invalid input format. Basic Sum Assured must be numeric 0 to 9 only" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		txtBasicSA.text = @"";
        [txtBasicSA becomeFirstResponder];
		return FALSE;
    }
	else if ([[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 ![[txtCommFrom.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtRTUP becomeFirstResponder ];
		return FALSE;
	}
	else if ([[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"0"] &&
			 ![[txtCommFrom.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtRTUP becomeFirstResponder ];
		return FALSE;
	}
	else if ([[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 ![[txtFor.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtFor becomeFirstResponder ];
		return FALSE;
	}
	else if ([[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"0"] &&
			 ![[txtFor.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtFor becomeFirstResponder ];
		return FALSE;
	}
	else if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 [[txtCommFrom.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"0"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium Commnencement Year is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtCommFrom becomeFirstResponder ];
		return FALSE;
	}
	else if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 [[txtFor.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"0"] ){
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"The number of year for Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtFor becomeFirstResponder ];
		return FALSE;
	}
	
	else if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 [[txtCommFrom.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up Premium Commnencement Year is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtCommFrom becomeFirstResponder ];
		return FALSE;
	}
	else if (![[txtRTUP.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] &&
			 [[txtFor.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""] ){
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"The number of year for Regular Top Up Premium is required"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtFor becomeFirstResponder ];
		return FALSE;
	}
	else if ([txtCommFrom.text intValue ] > 100 - ageClient - 1){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up must commence before %dth policy anniversary.", 100-ageClient-1] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtCommFrom becomeFirstResponder ];
		return FALSE;
	}
	else if ([txtFor.text intValue ] > [txtPolicyTerm.text intValue] - [txtCommFrom.text intValue ]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:[NSString stringWithFormat:@"Regular Top Up years must be less than or equal to %d year(s).", [txtPolicyTerm.text intValue] - [txtCommFrom.text intValue ]]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[txtFor becomeFirstResponder ];
		return FALSE;
	}
	/*
	else if ([txtBUMP.text doubleValue ] < 0) {

		if ([txtBasicSA.text doubleValue] <= minSA) {
			
			double modeRate = 0.00;
			int RTUOPremium = 0.00;
			
			if(getBumpMode.length == 0){
				getBumpMode = @"A";
			}
			
			if ([getBumpMode isEqualToString:@"A"]) {
				modeRate = 1.00;
			}
			else if ([getBumpMode isEqualToString:@"S"]) {
				modeRate = 0.9;
			}
			else if ([getBumpMode isEqualToString:@"Q"]) {
				modeRate = 0.9;
			}
			else {
				modeRate = 0.8;
			}
			
			NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
			[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
			[formatter setCurrencySymbol:@""];
			[formatter setNegativeFormat:@"-"];
			[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
			
			if (![getOccLoading isEqualToString:@"STD"] || getHLTerm  != 0 || getHLPctTerm != 0) {
				if ([getSmokerLA isEqualToString:@"N"] ) {
					if (ageClient > 66) {
						//special case
					}
					else{
						//not allow to generate quotation, msg A
					}
				}
				else{
					if (ageClient > 64) {
						//special case
					}
					else{
						//not allow to generate quotation, msg A
					}
				}
			}
			else{
				//special case
				[self GetSustain];
				
				if ([self GetWithdrawal] == FALSE) {
					if(PolicySustainYear  > 0) {
						
					}
					else{
						
						int tempRTUO = ceil(ABS([txtBUMP.text doubleValue]/(0.85 * 0.95)) * modeRate);
						RTUOPremium = 10 * (tempRTUO % 10 > 0 ? ceil(tempRTUO/10.00) : tempRTUO/10 );
						EverLifeViewController *rrr = [[EverLifeViewController alloc] init ];
						rrr.SimpleOrDetail = @"Simple";
						
						double newBump = [rrr FromBasic:txtBasicPremium.text andGetHL:getHL andGetHLPct:getHLPct
																			  andBumpMode:[self ReturnBumpMode] andBasicSA:txtBasicSA.text
																			  andRTUPFrom:txtCommFrom.text andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
																			  andSmokerLA:getSmokerLA andOccLoading:getOccLoading
																		  andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
																				 andLAAge:ageClient andGrayRTUO:RTUOPremium];
						
						if (newBump > 0 ) {
							txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:newBump]];
							txtGrayRTUP.text = [NSString stringWithFormat:@"%d", RTUOPremium];
						}
						else{
							for (int i = 0; i < 5; i++) {
								
								tempRTUO = ceil(ABS(newBump/(0.85 * 0.95)) * modeRate);
								RTUOPremium = 10 * (tempRTUO % 10 > 0 ? ceil(tempRTUO/10.00) : tempRTUO/10 );
								
								newBump = [rrr FromBasic:txtBasicPremium.text andGetHL:getHL andGetHLPct:getHLPct
													andBumpMode:[self ReturnBumpMode] andBasicSA:txtBasicSA.text
													andRTUPFrom:txtCommFrom.text andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
													andSmokerLA:getSmokerLA andOccLoading:getOccLoading
												andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
													   andLAAge:ageClient andGrayRTUO:RTUOPremium];
								
								if (newBump > 0) {
									txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:newBump]];
									txtGrayRTUP.text = [NSString stringWithFormat:@"%d", RTUOPremium];
									break;
								}
							}
						}
						
						//NSLog(@"%@", [self ErrorMsg:@"R0" andInput1:[NSString stringWithFormat:@"%d", RTUOPremium ] andInput2:@"" andInput3:@""]);
							
					}
				}
				else{
					if (PolicySustainYear > 0) {
						
					}
					else{
						
					}
				}
			}
			
			return TRUE;
		}
		else{
			if (PremiumRequired < 2 * [txtBasicPremium.text doubleValue ]) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
																message:[NSString stringWithFormat:@"Please increase basic premium to %.2f", PremiumRequired]
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[txtBasicPremium becomeFirstResponder ];
				return FALSE;
			}
			else{
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
																message:[NSString stringWithFormat:@"Please reduce Basic Sum Assured"]
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[txtBasicSA becomeFirstResponder ];
				return FALSE;
			}
		}
		
		
	}
	 */
	/*
	 else if (rangeofDotSA.location != NSNotFound) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
	 message:[NSString stringWithFormat:@"Decimal place is not allow for Basic Sum Assured"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 [txtBasicSA becomeFirstResponder];
	 }*/
	else {
		return TRUE;
		
		
	}
	
}

-(void)GetSustain{
	NSString *querySQL;
	sqlite3_stmt *statement;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"SELECT PolicySustainYear FROM UL_Details where sino = '%@' ", getSINo];
		
		//NSLog(@"%@",querySQL);
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW) {
				PolicySustainYear = sqlite3_column_int(statement, 0);
	
			}
			
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
	
	
}

-(BOOL)GetWithdrawal{

	NSString *querySQL;
	sqlite3_stmt *statement;
	bool bResult = FALSE;
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		querySQL = [NSString stringWithFormat:@"SELECT * FROM UL_RegWithdrawal where sino = '%@' ", getSINo];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW) {
				bResult = TRUE;
			}
			else{
				bResult = FALSE;
			}
			
			sqlite3_finalize(statement);
		}
		
		sqlite3_close(contactDB);
	}
	
	return bResult;
}

- (IBAction)ActionPremium:(id)sender {
	
	double tempBasicPrem = [txtBasicPremium.text doubleValue ];
	double tempBasicSA = [txtBasicSA.text doubleValue ];
	double tempPremiumPayable = [txtPremiumPayable.text doubleValue ];
	
	if ([txtBasicPremium isFirstResponder ]) {
		[self DisplayPremiumCondtion];
	}

	if(getBumpMode.length == 0){
		getBumpMode = @"A";
	}
	
	if (tempBasicPrem > 0 && tempBasicSA > 0) {
		if (segPremium.selectedSegmentIndex == 0) {
			if (![txtBasicPremium.text isEqualToString:@""]) {
				
				if ([getBumpMode isEqualToString:@"S"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem /Semi   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA /Semi   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable /Semi   ];
					
				}
				else if ([getBumpMode isEqualToString:@"Q"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem /quarterly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA /quarterly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable /quarterly   ];
				}
				else if ([getBumpMode isEqualToString:@"M"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem/Monthly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA/Monthly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable/Monthly   ];
				}
				
			}
			getBumpMode	= @"A";
		}
		else if (segPremium.selectedSegmentIndex == 1) {
			if (![txtBasicPremium.text isEqualToString:@""]) {
				if ([getBumpMode isEqualToString:@"A"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem * Semi   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA * Semi   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable * Semi   ];
				}
				else if ([getBumpMode isEqualToString:@"Q"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem/quarterly) * Semi   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA/quarterly) * Semi   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable/quarterly) * Semi   ];
				}
				else if ([getBumpMode isEqualToString:@"M"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem /Monthly) * Semi   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA /Monthly) * Semi   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable /Monthly) * Semi   ];
				}
				
			}
			getBumpMode = @"S";
			
		}
		else if (segPremium.selectedSegmentIndex == 2) {
			if (![txtBasicPremium.text isEqualToString:@""]) {
				if ([getBumpMode isEqualToString:@"A"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem * quarterly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA * quarterly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable * quarterly   ];
				}
				else if ([getBumpMode isEqualToString:@"S"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem/Semi) * quarterly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA/Semi) * quarterly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable/Semi) * quarterly   ];
					
				}
				else if ([getBumpMode isEqualToString:@"M"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem /Monthly) * quarterly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA /Monthly) * quarterly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable /Monthly) * quarterly   ];
				}
				
			}
			getBumpMode = @"Q";
			
		}
		else if (segPremium.selectedSegmentIndex == 3) {
			if (![txtBasicPremium.text isEqualToString:@""]) {
				if ([getBumpMode isEqualToString:@"A"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", tempBasicPrem * Monthly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", tempBasicSA * Monthly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", tempPremiumPayable * Monthly   ];
				}
				else if ([getBumpMode isEqualToString:@"S"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem /Semi) * Monthly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA /Semi) * Monthly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable /Semi) * Monthly   ];
					
				}
				else if ([getBumpMode isEqualToString:@"Q"]) {
					txtBasicPremium.text = [NSString stringWithFormat:@"%.2f", (tempBasicPrem /quarterly) * Monthly   ];
					//txtBasicSA.text = [NSString stringWithFormat:@"%.2f", (tempBasicSA /quarterly) * Monthly   ];
					txtPremiumPayable.text = [NSString stringWithFormat:@"%.2f", (tempPremiumPayable /quarterly) * Monthly   ];
				}
				
			}
			getBumpMode = @"M";
			
		}
		
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[formatter setCurrencySymbol:@""];
		[formatter setNegativeFormat:@"-"];
		[formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
		txtTotalBAPremium.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBasicPremium.text doubleValue]+ [txtGrayRTUP.text doubleValue]]];
		//txtTotalBAPremium.text = [NSString stringWithFormat:@"%.2f", [txtBasicPremium.text doubleValue ]];
		EverLifeViewController *rrr = [[EverLifeViewController alloc] init ];
		rrr.SimpleOrDetail = @"Simple";
		
		txtBUMP.text = [NSString stringWithFormat:@"%.2f", [rrr FromBasic:txtBasicPremium.text andGetHL:getHL andGetHLPct:getHLPct
															  andBumpMode:[self ReturnBumpMode] andBasicSA:txtBasicSA.text
															  andRTUPFrom:txtCommFrom.text andRTUPFor:txtFor.text andRTUPAmount:txtRTUP.text
															  andSmokerLA:getSmokerLA andOccLoading:getOccLoading
														  andPlanCommDate:getPlanCommDate andDOB:getDOB andSexLA:getSexLA andSino:getSINo
																 andLAAge:ageClient andGrayRTUO:[txtGrayRTUP.text doubleValue ]]];
		txtBUMP.text = [formatter stringFromNumber:[NSNumber numberWithDouble:[txtBUMP.text doubleValue]]];
		PremiumRequired = [rrr PremRequired];
		rrr = Nil;
	}
	
	
}

-(NSString *)ErrorMsg :(NSString *)aaCode andInput1:(NSString *)aaInput1 andInput2:(NSString *)aaInput2 andInput3:(NSString *)aaInput3 {

	if([aaCode isEqual:@"Z1"]){
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@. However, the Basic Unit Account and Rider Unit Account are projected to be able to "
				 "sustain up to %@th and %@th policy year only respectively, based on BULL scenario. Generation of SI & PDS is not allowed if either "
				 "Basic Unit Account or Rider Unit Account lapse before 10th policy year. You may increase your Basic Unit Account or Rider Unit Account sustainability year by:\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you opted for regular withdrawal\n."
				 "3. Reducing your BSA if the BSA is higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan/ Rider Regular Top Up.",aaCode, aaInput1, aaInput2, aaInput3];
	}
	else if([aaCode isEqual:@"Z2"]){
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@. However, the Basic Unit Account and Rider Unit Account are projected to be able to "
				 "sustain up to %@th and %@th policy year only respectively, based on BULL scenario. You may increase your Basic Unit Account or Rider Unit Account sustainability year by:\n"
				 "Reducing withdrawal amount of matured fund (option at fund maturity) and/or regular withdrawal if you opt for any withdrawal.\n"
				 "1. Reinvesting your matured fund value fully/partially (option at fund maturity).\n"
				 "2. Reducing regular withdrawal if you opted for regular withdrawal\n."
				 "3. Reducing your BSA if the BSA higher than minimum allowable BSA.\n"
				 "4. Adding Basic Plan/ Rider Regular Top Up.",aaCode, aaInput1, aaInput2, aaInput3];
	}
	else{
		return  [NSString stringWithFormat:@"%@Regular Top Up Premium will be revised to RM%@",aaCode,aaInput1 ];
	}
}

@end
