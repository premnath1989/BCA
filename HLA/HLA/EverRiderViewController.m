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

double CurrentRiderPrem, CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderLoadingPremium2, CurrentRiderPrem3, CurrentRiderLoadingPremium3, LDYRBBB_Rate, LDYRPCB_Rate ;
NSString *FirstLAOccuCode;

@implementation EverRiderViewController
@synthesize requestAge,requestBasicHL,requestBasicHLPct,requestBasicSA,requestCoverTerm,requestOccpClass;
@synthesize requestOccpCode,requestPlanCode,requestSex,requestSINo, getAge,getPlanCode,getBasicHL;
@synthesize getSINo,getBasicHLPct,getBasicSA,getOccpClass,getOccpCode,getSex,getTerm;
@synthesize pTypeAge,pTypeCode,pTypeDesc,pTypeOccp, PTypeSeq, riderCode, riderDesc;
@synthesize outletDeductible,outletPersonType,outletRider,outletRiderPlan;
@synthesize lbl1,lbl2,lbl3,lbl4,lbl5,lbl6,lbl7,lbl8,lblRegular1,lblRegular2,lblRegularTerm,lblRegularTerm2;
@synthesize lblTable1,lblTable2,lblTable3,lblTable4,lblTable5,lblTable6,lblTable7;
@synthesize lblTable8,lblTable9, lblTable10, lblTable11, myScrollView, myTableView, outletDelete, outletEdit;
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
@synthesize LReinvest, LTypeReinvest, requestBumpMode, age, pTypeSex, riderRate, riderRate2, riderRate3, getBUMPMode, arrCombNo, arrRBBenefit;
@synthesize medRiderCode,medPlanCodeRider, medPlanOpt, CombNo, RBBenefit, AllCombNo, RBGroup, RBLimit;
@synthesize LPaymentTerm,LTypePaymentTerm, LTypeRRTUOFromYear, LTypeRRTUOYear, LRRTUOFromYear, LRRTUOYear;
@synthesize lblHLP,lblHLPTerm, txtHLP,txtHLPTerm, requesteProposalStatus, EAPPorSI, outletDone, OutletAddRider, outletEAPP, outletSpace, LPaymentChoice, LTypePaymentChoice, request2ndAge, requestPayorAge;
@synthesize SimpleOrDetail, LGYIYear, LTypeGYIYear, LRiderPType, LRiderPTypeSeq, outletSegBottomLeft, outletSegBottomRight, outletOccLoading, outletCheckBox1, outletCheckBox2;
@synthesize LPostDeductible,LPreDeductible, LTypePostDeductible, LTypePreDeductible;
@synthesize delegate = _delegate;
@synthesize RiderList = _RiderList;
@synthesize RiderListPopover = _RiderListPopover;
@synthesize deducRetirementPopover = _deducPostRetirementPopover;
@synthesize planPopover = _planPopover;
@synthesize deducPopover = _deducPopover;
@synthesize planList = _planList;
@synthesize deductList = _deductList;
@synthesize PTypeList = _PTypeList;
@synthesize pTypePopOver = _pTypePopOver;
@synthesize deductPostRetirement = _deductPostRetirement;




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
	
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
	}
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    UL_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"BCAUL_Rates.sqlite"]];
	
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
		
		//--------- edited by heng
		appDel.MhiMessage = @"";
		//-----------
		
		if ([requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
			[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"] || [requesteProposalStatus isEqualToString:@"Created"]) {
			Editable = NO;
		}
		else{
			Editable = YES;
		}
	}
	
	
	
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
	
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		if (requestSINo) {
			self.PTypeList = [[RiderPTypeTbViewController alloc]initWithString:getSINo str:@"EVER"];
			_PTypeList.delegate = self;
			pTypeCode = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedCode];
			PTypeSeq = [self.PTypeList.selectedSeqNo intValue];
			pTypeDesc = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedDesc];
			pTypeAge = [self.PTypeList.selectedAge intValue];
			pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
			FirstLAOccuCode = pTypeOccp;
			[self.outletPersonType setTitle:pTypeDesc forState:UIControlStateNormal];
		}
		_PTypeList = nil;
	}
	else{
		pTypeCode = @"LA";
		PTypeSeq = 1;
		pTypeAge = getAge;
		pTypeOccp = getOccpCode;
	}
	

    outletCheckBox1.hidden = YES;
    outletCheckBox2.hidden = YES;
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		
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
		txtRRTUP.tag = 12;
		txtRRTUPTerm.tag = 13;
		
        deductible = @"", strDeductiblePostRetirement = @"";
        
		UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
		NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
															   forKey:UITextAttributeFont];
		[outletReinvest setTitleTextAttributes:attributes
									  forState:UIControlStateNormal];
		
		
		ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
		
		int y= 445;
		int lblTableHeight = 50;
		CGRect frame=CGRectMake(45,y, 80, lblTableHeight);
		lblTable1.text = @"Rider";
		lblTable1.frame = frame;
		lblTable1.textAlignment = UITextAlignmentCenter;
		lblTable1.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable1.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable1.numberOfLines = 2;
		
		CGRect frame2=CGRectMake(frame.origin.x + frame.size.width, y, 90, lblTableHeight); // premium
		lblTable2.frame = frame2;
		lblTable2.textAlignment = UITextAlignmentCenter;
		lblTable2.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable2.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		
		CGRect frame3=CGRectMake(frame2.origin.x + frame2.size.width,y, 90, lblTableHeight); // sum Assured
		lblTable3.text = @"Sum\nAssured";
		lblTable3.frame = frame3;
		lblTable3.textAlignment = UITextAlignmentCenter;
		lblTable3.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable3.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		
		CGRect frame4=CGRectMake(frame3.origin.x + frame3.size.width,y, 50, lblTableHeight); //Term
		lblTable4.frame = frame4;
		lblTable4.textAlignment = UITextAlignmentCenter;
		lblTable4.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable4.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		
		CGRect frame5=CGRectMake(frame4.origin.x + frame4.size.width,y, 50, lblTableHeight);
		lblTable5.text = @"Units";
		lblTable5.frame = frame5;
		lblTable5.textAlignment = UITextAlignmentCenter;
		lblTable5.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable5.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable5.numberOfLines = 2;
		
		CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width, y, 50, lblTableHeight);
		lblTable6.text = @"Occ \nClass";
		lblTable6.frame = frame6;
		lblTable6.textAlignment = UITextAlignmentCenter;
		lblTable6.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable6.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable6.numberOfLines = 2;
		
		CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,y, 60, lblTableHeight);
		lblTable7.text = @"Occp \nLoading";
		lblTable7.numberOfLines = 2;
		lblTable7.frame = frame7;
		lblTable7.textAlignment = UITextAlignmentCenter;
		lblTable7.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable7.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		
		CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,y, 50, lblTableHeight);
		lblTable8.text = @"HL";
		lblTable8.frame = frame8;
		lblTable8.textAlignment = UITextAlignmentCenter;
		lblTable8.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable8.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable8.numberOfLines = 2;
		
		CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width, y, 50, lblTableHeight);
		lblTable9.text = @"HL\nTerm";
		lblTable9.frame = frame9;
		lblTable9.textAlignment = UITextAlignmentCenter;
		lblTable9.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable9.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable9.numberOfLines = 2;
		
		CGRect frame10=CGRectMake(frame9.origin.x + frame9.size.width,y, 50, lblTableHeight);
		lblTable10.text = @"HLP";
		lblTable10.frame = frame10;
		lblTable10.textAlignment = UITextAlignmentCenter;
		lblTable10.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable10.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable10.numberOfLines = 2;
		
		CGRect frame11=CGRectMake(frame10.origin.x + frame10.size.width, y, 53, lblTableHeight);
		lblTable11.text = @"Monthly \ncharges";
		lblTable11.frame = frame11;
		lblTable11.textAlignment = UITextAlignmentCenter;
		lblTable11.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
		lblTable11.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
		lblTable11.numberOfLines = 2;
	}
	
	

    [self getOccLoad];
    [self getCPAClassType];
    [self getOccpCatCode];
	//[self getLSDRate];
    //NSLog(@"basicRate:%d, lsdRate:%d, occpLoad:%d, cpa:%d, pa:%d",basicRate,LSDRate,occLoad,occCPA,occPA);
    
    [self getListingRiderByType];
    [self getListingRider];
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
		[self CalcTotalRiderPrem];
	}
	
    //[self calculateBasicPremium];
    
    //[self calculateRiderPrem];
    //[self calculateWaiver];
    //[self calculateMedRiderPrem];
	
	if ([SimpleOrDetail isEqualToString:@"Detail"]) {
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
		
		outletEAPP.width = 0.01;
		outletSpace.width = 650;
		
		if (Editable == FALSE) {
			outletRider.enabled = FALSE;
			outletDeductible.enabled = FALSE;
			outletDelete.enabled = FALSE;
			outletEdit.enabled = FALSE;
			outletReinvest.enabled= FALSE;
			outletRiderPlan.enabled = FALSE;
			txtGYIFrom.enabled = FALSE;
			txtHL.enabled = FALSE;
			txtHLP.enabled = FALSE;
			txtHLPTerm.enabled = FALSE;
			txtHLTerm.enabled = FALSE;
			txtOccpLoad.enabled = FALSE;
			txtPaymentTerm.enabled = FALSE;
			txtReinvestment.enabled = FALSE;
			txtRiderPremium.enabled = FALSE;
			txtRiderTerm.enabled = FALSE;
			txtRRTUP.enabled = FALSE;
			txtRRTUPTerm.enabled = FALSE;
			txtSumAssured.enabled = FALSE;
			OutletAddRider.enabled = FALSE;
            
            self.outletRider.alpha = 0.5;
			self.outletDeductible.alpha = 0.5;
			self.outletDelete.alpha = 0.5;
			self.outletEdit.alpha = 0.5;
			self.outletReinvest.alpha = 0.5;
			self.outletRiderPlan.alpha = 0.5;
            self.OutletAddRider.alpha = 0.5;
			
			if([EAPPorSI isEqualToString:@"eAPP"]){
				outletDone.enabled = FALSE;
				outletEAPP.width = 0;
				outletSpace.width = 564;
				
			}
		}
		
		[txtRiderTerm addTarget:self action:@selector(PaymentTerm) forControlEvents:UIControlEventAllEditingEvents];
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
									   initWithTarget:self
									   action:@selector(hideKeyboard)];
		tap.cancelsTouchesInView = NO;
		tap.numberOfTapsRequired = 1;
		
		[self.view addGestureRecognizer:tap];
	}
	else{
		[self updateAllRiders];
	}
	
	
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	appDel.isNeedPromptSaveMsg = YES;
}

-(void)PaymentTerm{

    if ([getPlanCode isEqualToString:@"UP"] && ([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"TPDWP"] ||
                                                [riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"])){
        if ([txtRiderTerm.text intValue] == getTerm) {
            outletRiderPlan.enabled = YES;
            outletRiderPlan.hidden = NO;
            [self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            txtPaymentTerm.hidden = YES;
            
            self.planList = [
                             [RiderPlanTb alloc] initWithString:riderCode andSumAss:[NSString stringWithFormat:@"%d", getTerm] andOccpCat:@"" andTradOrEver:@"EVER" getPlanChoose:@""];
            _planList.delegate = self;
            
            [self.outletRiderPlan setTitle:_planList.selectedItemDesc forState:UIControlStateNormal];
            planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
        }
        else{
            outletRiderPlan.enabled = NO;
            outletRiderPlan.hidden = YES;
            txtPaymentTerm.hidden = NO;
            txtPaymentTerm.enabled = NO;
            txtPaymentTerm.text = [NSString stringWithFormat:@"%@", txtRiderTerm.text];
            txtPaymentTerm.textColor = [UIColor darkGrayColor];
            txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
        }
        
    }
    else if ([riderCode isEqualToString:@"TSR"]){
        
            if (pTypeAge + [txtRiderTerm.text intValue] < 60 ) {
                outletRiderPlan.titleLabel.text = @"Whole Rider Term";
                txtReinvestment.text = txtRiderTerm.text;
            }
            else if ([outletRiderPlan.titleLabel.text isEqualToString:@"Whole Rider Term"]){
                txtReinvestment.text = txtRiderTerm.text;
            }
            else{
                //txtReinvestment.text = [NSString stringWithFormat:@"%d", 60 - pTypeAge];
            }
        
        
    }


}

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
			if ([riderCode isEqualToString:@"RRTUO"] ) {
				lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
				lblMax.text = [NSString stringWithFormat:@"Max Term: %d", (getTerm - [txtRiderTerm.text intValue])];
			}
            else if ([riderCode isEqualToString:@"HCIR"] ) {
				lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minSATerm];
				lblMax.text = [NSString stringWithFormat:@"Max Term: %d", maxSATerm];
			}
            else if ([riderCode isEqualToString:@"MCFR"]) {
				lblMin.text = [NSString stringWithFormat:@"Min Term: 1"];
				lblMax.text = [NSString stringWithFormat:@"Max Term: %d", (getTerm - [txtRiderTerm.text intValue])];
			}
			break;

		case 1: // term
            if ([riderCode isEqualToString:@"BLIFECIAC"] || [riderCode isEqualToString:@"BLIFECIAD"] || [riderCode isEqualToString:@"BLIFEWVRT"] ||
                [riderCode isEqualToString:@"BPW"] || [riderCode isEqualToString:@""] || [riderCode isEqualToString:@"BLIFEPYRD"]){
                
                    
                lblMin.text = [NSString stringWithFormat:@"Min Term: %d", minTerm ];
				lblMax.text = [NSString stringWithFormat:@"Max Term: %d", 85];

                
            }
            else if ([riderCode isEqualToString:@"BLIFEPAA1"] || [riderCode isEqualToString:@"BLIFEPAAB"] ){
                NSString *msg = @"Term: ";
                

                    
                    lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"55,65,70,75"]];
                    lblMax.text = @"";

                
            }
            else if ([riderCode isEqualToString:@"BPW"] || [riderCode isEqualToString:@"BLIFEPAAB"] ){
                NSString *msg = @"Term: ";
                
                
                
                lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"55,65,70,75"]];
                lblMax.text = @"";
                
                
            }
			else{

			}
			
			break;
		case 5: // sum assured or premium
			
			if ([riderCode isEqualToString:@"BLIFEHNS1"] ) {
                lblMin.text = [NSString stringWithFormat:@"200000,350000,500000,750000"];
				lblMax.text = [NSString stringWithFormat:@"1000000,1500000,2000000,2500000"];
			}
			else{
                lblMin.text = [NSString stringWithFormat:@"Min SA: %d",minSATerm];
				lblMax.text = [NSString stringWithFormat:@"Max SA: 99999999999"];
			}
        
			break;
            
        case 12 :
            if ([riderCode isEqualToString:@"LDYR"]) {
                lblMin.text = @"Min SA: 20000";
                lblMax.text = [NSString stringWithFormat:@"Max SA :%@ ", txtSumAssured.text ];
            }
            break;
        case 13 :
            if ([riderCode isEqualToString:@"LDYR"]) {
                lblMin.text = @"Min SA: 20000";
                lblMax.text = [NSString stringWithFormat:@"Max SA :%@ ", txtSumAssured.text ];
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
		if (ECAR60MonthlyIncome == TRUE || ECARYearlyIncome == TRUE || ECAR6YearlyIncome == TRUE ) {
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
		if ([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"ACIR"] || [riderCode isEqualToString:@"DCA"] || [riderCode isEqualToString:@"MDSR1"] ||
			[riderCode isEqualToString:@"DHI"] ||  [riderCode isEqualToString:@"LCWP"]  || [riderCode isEqualToString:@"MR"] || [riderCode isEqualToString:@"MDSR2"] ||
			[riderCode isEqualToString:@"PA"] || [riderCode isEqualToString:@"PR"] || [riderCode isEqualToString:@"TPDWP"] ||
			[riderCode isEqualToString:@"WI"] || [riderCode isEqualToString:@"TPDMLA"] || [riderCode isEqualToString:@"TPDYLA"]  ) {
			if (![txtRiderTerm.text isEqualToString:@"" ]) {
				txtPaymentTerm.text = txtRiderTerm.text;
			}
		}
        
	}
	
}

-(int)ReturnMCFRMaxPrem{NSLog(@"cccc %@",self.outletDeductible.titleLabel.text);
    sqlite3_stmt *statement;
    double result = 0.00;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT sum(premium) from ul_rider_details where sino = '%@' AND ridercode in ('MDSR1', 'MDSR2', 'MDSR1-ALW', 'MDSR1-OT','MDSR2-ALW', 'MDSR2-OT')  ", getSINo];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {

                result = sqlite3_column_double(statement, 0);

            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return floor(result * 0.7);

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
	LPaymentChoice = [[NSMutableArray alloc] init];
	LGYIYear = [[NSMutableArray alloc] init];
    LRiderPType = [[NSMutableArray alloc] init];
	LRiderPTypeSeq = [[NSMutableArray alloc] init];
    LPreDeductible = [[NSMutableArray alloc] init];
	LPostDeductible = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Deductible, a.HLoading, "
							  "a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							  "a.HLoadingTerm, a.HLoadingPctTerm, c.OccpCode, a.premium, a.units, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, "
                              "a.RRTUOYear, ifnull(a.PaymentChoice, ''), ifnull(a.GYIYear, 0), a.PTypeCode, a.Seq, ifnull(a.PreDeductible, 0), ifnull(a.PostDeductible, 0) FROM UL_Rider_Details a, "
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
                [LPaymentChoice addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)]];
                [LGYIYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)]];
                [LRiderPType addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 21)]];
                [LRiderPTypeSeq addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 22)]];
                [LPreDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 23)]];
                [LPostDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 24)]];
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
                OccpCat = [OccpCat stringByReplacingOccurrencesOfString:@" "  withString:@""];
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
		
        //for payment term/plan option/unit
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLOP"]] ||
            [[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PLCH"]]) {
            //planLabel.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
			lbl2.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            plan = YES;
            
            planCondition = [FCondition objectAtIndex:i];
            
        }
        else if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"UNIT"]]){
            unit = YES;
            lbl2.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
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
            ECAR60MonthlyIncome = YES;
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
		if ([[FRidName objectAtIndex:i] isEqualToString:@"EverCash 60 Rider"]) {
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
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"ALW"]]) {
            lblRegular1.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            bOverseaTreatment = YES;
            
            bALW = YES;
        }

        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"OT"]]) {
            lblRegularTerm.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
        }
        
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"PCB"]]) {
            lblRegular1.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            bPCB = YES;
        }

        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"BBB"]]) {
            lblRegularTerm.text = [NSString stringWithFormat:@"%@ :",[FLabelDesc objectAtIndex:i]];
            bBBB = YES;
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
	
	if (Editable == TRUE) {
		if (term) {
			
			if (([getPlanCode isEqualToString:@"UP"] && [riderCode isEqualToString:@"ECAR"]) ||
				([getPlanCode isEqualToString:@"UP"] && [riderCode isEqualToString:@"ECAR6"])) {
				lbl1.textColor = [UIColor darkGrayColor];
				txtRiderTerm.enabled = NO;
				txtRiderTerm.backgroundColor = [UIColor lightGrayColor];
				txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
			}
			else{
				lbl1.textColor = [UIColor blackColor];
				txtRiderTerm.enabled = YES;
				txtRiderTerm.textColor = [UIColor blackColor];
				txtRiderTerm.backgroundColor = [UIColor whiteColor];
			}
			
		}else {

			txtRiderTerm.textColor = [UIColor darkGrayColor];
			txtRiderTerm.enabled = NO;
			txtRiderTerm.backgroundColor = [UIColor lightGrayColor];
            

            txtRiderTerm.text = [NSString stringWithFormat:@"75"];
            
            
		}
		

		
		
		//----- for label 5, sum assured------
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
		else if (ECAR60MonthlyIncome){
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
		//-----------for label 4 --------------
		if (ECAR60MonthlyIncome){
			lbl4.textColor = [UIColor blackColor];
			lbl4.numberOfLines = 2;
			lbl4.text = @"GMI Start From (Age)";
			txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm] ;
			txtPaymentTerm.text = [NSString stringWithFormat:@"%d",60 - getAge];
			txtGYIFrom.text = @"60";
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
		//------------ for label 2------------------
		if (plan) {
            //#EDD
            if([riderCode isEqualToString:@"ECRD"]){
                
                outletRiderPlan.hidden = YES;
                txtPaymentTerm.hidden = NO;
                txtPaymentTerm.enabled = NO;
                txtPaymentTerm.text = @"Deluxe";
                txtHL.enabled = YES;
                txtHLTerm.enabled = YES;
                hloadterm = TRUE;
                planOption = @"ECRD";//??
                
            }else if([riderCode isEqualToString:@"ECRP"]){
                
                outletRiderPlan.hidden = YES;
                txtPaymentTerm.hidden = NO;
                txtPaymentTerm.enabled = NO;
                txtPaymentTerm.text = @"Premier";
                hloadterm = TRUE;
                planOption = @"ECRP";//??
                
            }else if([riderCode isEqualToString:@"ECRS"]){
                
                outletRiderPlan.hidden = YES;
                txtPaymentTerm.hidden = NO;
                txtPaymentTerm.enabled = NO;
                txtPaymentTerm.text = @"Superior";
                txtHL.enabled = YES;
                txtHLTerm.enabled = YES;
                hloadterm = TRUE;
                planOption = @"ECRS";//??
                
            }else {
            
                lbl2.textColor = [UIColor blackColor];
                outletRiderPlan.enabled = YES;
                outletRiderPlan.hidden = NO;
                [self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
                txtPaymentTerm.hidden = YES;
                
                NSString *strSA = [NSString stringWithFormat:@"%.2f",getBasicSA];
                self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"EVER" getPlanChoose:@""];
                _planList.delegate = self;
                
                [self.outletRiderPlan setTitle:_planList.selectedItemDesc forState:UIControlStateNormal];
                planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
                

            }
            
						
		}
        else if (unit){
			outletRiderPlan.enabled = NO;
			outletRiderPlan.hidden = YES;
			txtPaymentTerm.hidden = NO;
			txtPaymentTerm.enabled = YES;
			txtPaymentTerm.backgroundColor = [UIColor whiteColor];
		}
		else if (RRTUOPrem){
			outletRiderPlan.enabled = NO;
			outletRiderPlan.hidden = YES;
			txtPaymentTerm.hidden = NO;
			txtPaymentTerm.enabled = YES;
			txtPaymentTerm.backgroundColor = [UIColor whiteColor];
		}
        else if (TSR){
            lbl2.text = @"Payment choice";
			outletRiderPlan.enabled = YES;
			outletRiderPlan.hidden = NO;
			[self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
			txtPaymentTerm.hidden = YES;
			
			self.planList = [[RiderPlanTb alloc] initWithString:@"TSR" andSumAss:[NSString stringWithFormat:@"%d", getAge] andOccpCat:OccpCat andTradOrEver:@"EVER" getPlanChoose:@""];
			_planList.delegate = self;
			
			[self.outletRiderPlan setTitle:_planList.selectedItemDesc forState:UIControlStateNormal];
			planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
		}
		else{
			lbl2.text = @"Payment Term :";
			
			if ([getPlanCode isEqualToString:@"UP"]) {
				if([riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"TPDWP"] ||
				   [riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"]){
					if (getTerm == [txtRiderTerm.text intValue] ) {
						outletRiderPlan.enabled = YES;
						outletRiderPlan.hidden = NO;
						[self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
						txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
						txtPaymentTerm.hidden = YES;
						
						self.planList = [[RiderPlanTb alloc] initWithString:riderCode andSumAss:[NSString stringWithFormat:@"%d", getTerm] andOccpCat:@"" andTradOrEver:@"EVER" getPlanChoose:@""];
						_planList.delegate = self;
						
						[self.outletRiderPlan setTitle:_planList.selectedItemDesc forState:UIControlStateNormal];
						planOption = [[NSString alloc] initWithFormat:@"%@",_planList.selectedItemDesc];
					}
					else{
                        outletRiderPlan.enabled = NO;
                        outletRiderPlan.hidden = YES;
                        txtPaymentTerm.hidden = NO;
                        txtPaymentTerm.enabled = NO;
                        txtPaymentTerm.textColor = [UIColor darkGrayColor];
                        txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
						txtPaymentTerm.text = [NSString stringWithFormat:@"%@", txtRiderTerm.text];
						
					}
					
				}
                else
                {
                    outletRiderPlan.enabled = NO;
                    outletRiderPlan.hidden = YES;
                    txtPaymentTerm.hidden = NO;
                    txtPaymentTerm.enabled = NO;
                    txtPaymentTerm.textColor = [UIColor darkGrayColor];
                    txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
                }
				
			}
            else{
                outletRiderPlan.enabled = NO;
                outletRiderPlan.hidden = YES;
                txtPaymentTerm.hidden = NO;
                txtPaymentTerm.enabled = NO;
                txtPaymentTerm.textColor = [UIColor darkGrayColor];
                txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
            }
        
            
            
            if ([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"MSR"] || [riderCode isEqualToString:@"LDYR"]) {
                txtPaymentTerm.text = [NSString stringWithFormat:@"%d", getTerm];
            }
            else if([riderCode isEqualToString:@"CIRD"]) {
                txtPaymentTerm.text = [NSString stringWithFormat:@"10"];
            }
            else if ([riderCode isEqualToString:@"TSER"]) {
                txtPaymentTerm.text = [NSString stringWithFormat:@"%d", 60 - pTypeAge ];
                
            }

		}
		//----------for label 3---------------
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
            
            if ([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"]) {
                if (requestAge >= 60) {
                    outletDeductible.enabled = FALSE;
                    outletDeductible.titleLabel.text = @"";
                    deductible = @"";
                }
                
                lbl3.text = @"Deductible:\nPre-retirement ";
                lbl3.numberOfLines = 2;
            }
            else{
                lbl3.text = @"Deductible :";
            }
		}
		else if(ECAR60MonthlyIncome){
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
		
		//------- label 6 -------
        
        if(bALW){ //for MDSR,
            lbl4.text = @"Retirement Age:";
            txtGYIFrom.text = @"60";
            txtRRTUP.hidden = YES;
            txtRRTUPTerm.hidden = YES;
            outletSegBottomLeft.hidden = NO;
            outletSegBottomRight.hidden = NO;
            outletCheckBox1.hidden = YES;
            outletCheckBox2.hidden = YES;
            outletOccLoading.hidden = NO;
            lbl6.text = @"Post Retirement";
            lblRegularTerm.numberOfLines = 2;
            
            if (age +  getTerm > 60) {
                    [outletOccLoading setTitle:@"0" forState:UIControlStateNormal];
            }
            else{
                    [outletOccLoading setTitle:@"" forState:UIControlStateNormal];
            }
            
            if (requestAge + [txtRiderTerm.text integerValue] <= 60) {
                outletOccLoading.enabled = FALSE;
                outletOccLoading.titleLabel.text = @"";
            }

        }
        else if(bPCB){
            //lbl4.text = @"Retirement Age:";
            //txtGYIFrom.text = @"55";
            txtRRTUP.hidden = NO;
            txtRRTUPTerm.hidden = NO;
            outletCheckBox1.hidden = NO;
            outletCheckBox2.hidden = NO;
            outletSegBottomLeft.hidden = YES;
            outletSegBottomRight.hidden = YES;
            outletOccLoading.hidden = YES;
            lbl6.text = @"Occp. Loading";
            
        }
        else{
            lblRegular1.text = @"Regular Top Up\n Premium(RM):";
			txtRRTUP.backgroundColor = [UIColor lightGrayColor];
			txtRRTUP.enabled = FALSE;
            lblRegularTerm.text = @"Regular Top Up Term:";
			txtRRTUPTerm.backgroundColor = [UIColor lightGrayColor];
			txtRRTUPTerm.enabled = FALSE;
            txtRRTUP.hidden = NO;
            txtRRTUPTerm.hidden = NO;
            outletSegBottomLeft.hidden = YES;
            outletSegBottomRight.hidden = YES;
            outletCheckBox1.hidden = YES;
            outletCheckBox2.hidden = YES;
            outletOccLoading.hidden = YES;
            lbl6.text = @"Occp. Loading";
        }

        
        
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoadType];
		txtOccpLoad.textColor = [UIColor darkGrayColor];
	}
	
	
}

-(void)getRiderTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,ExpiryAge,MinTerm,MaxTerm,MinSA,MaxSA"
							  " FROM UL_Rider_Mtn WHERE RiderCode=\"%@\" AND PlanCode = '%@'",riderCode, getPlanCode];
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                if (pTypeAge > 65 ) {
                    minTerm = 80;
                }
                else if (pTypeAge > 60 ) {
                    minTerm = 75;
                }
                else if (pTypeAge > 55 ) {
                    minTerm = 70;
                }
                else if (pTypeAge > 50 ) {
                    minTerm = 65;
                }
                else if (pTypeAge > 45 ) {
                    minTerm = 60;
                }
                else {
                    minTerm = 55;
                }

                expAge =  sqlite3_column_int(statement, 2);
                //minTerm =  sqlite3_column_int(statement, 3);
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
	[self setLblTable10:nil];
	[self setLblTable11:nil];
	[self setOutletDone:nil];
	[self setOutletAddRider:nil];
    [self setOutletEAPP:nil];
	[self setOutletSpace:nil];
    [self setOutletSegBottomLeft:nil];
    [self setOutletSegBottomRight:nil];
    [self setOutletOccLoading:nil];
    [self setOutletCheckBox1:nil];
    [self setOutletCheckBox2:nil];
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
	[[cell.contentView viewWithTag:2011] removeFromSuperview ];

    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    int y = 0;
	int height = 50;
	int FontSize = 15;
	
	CGRect frame=CGRectMake(0,y, 90, height); //ridercode
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"    %@",[LTypeRiderCode objectAtIndex:indexPath.row]];
    label1.textAlignment = UITextAlignmentCenter;
    label1.tag = 2001;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label1];
	
	CGRect frame2=CGRectMake(frame.origin.x + frame.size.width,y, 90, height); //premium
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    NSString *num = [formatter stringFromNumber:[NSNumber numberWithDouble:[[LTypePremium objectAtIndex:indexPath.row] doubleValue]]];
    label2.text= [num stringByReplacingOccurrencesOfString:@"," withString:@""];
    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label2];
    
    CGRect frame3=CGRectMake(frame2.origin.x + frame2.size.width,y, 80, height); //sum assured
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
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label3];
	
	CGRect frame4=CGRectMake(frame3.origin.x + frame3.size.width,y, 50, height); //term
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
    label4.text= [LTypeTerm objectAtIndex:indexPath.row];
    label4.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label4];
	
	CGRect frame5=CGRectMake(frame4.origin.x + frame4.size.width,y, 50, height); //unit
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text= [LTypeUnits objectAtIndex:indexPath.row];
    label5.textAlignment = UITextAlignmentCenter;
    label5.tag = 2005;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label5];
	//------------------
	CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width,y, 50, height); //class
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
            [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LCWP" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR6" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR60" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ] ||
            [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MCFR" ] ||
			[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TPDWP" ]) {
			label6.text= [NSString stringWithFormat:@"D"];
		}
		else{
			label6.text= [NSString stringWithFormat:@"-"];
		}
	}
    label6.textAlignment = UITextAlignmentCenter;
    label6.tag = 2006;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label6];
	//---------------
	CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,y, 55, height); //occ loading
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    //label6.text= [NSString stringWithFormat:@"%@",occLoadType];
	if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR6" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"ECAR60" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LSR" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TSR" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TSER" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MCFR" ] ||
        [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"LCWP" ] ||
		[[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TPDWP" ]) {
		label7.text= [NSString stringWithFormat:@"%@",occLoadType];
	}
	else{
		label7.text= [NSString stringWithFormat:@"-"];
	}
    label7.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label7];
	
	NSString *hl1k = [LTypeRidHL1K objectAtIndex:indexPath.row]; //health loading
    //NSString *hlp = [LTypeRidHLP objectAtIndex:indexPath.row];
	CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,y, 55, height);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    NSString *hl1 = nil;
    if ([hl1k isEqualToString:@"(null)"]) {
        hl1 = @"-";
    }
    else if (![hl1k isEqualToString:@"(null)"] && [hl1k intValue] > 0) {
        hl1 = [formatter stringFromNumber:[NSNumber numberWithDouble:[hl1k doubleValue]]];
    }
    else {
        hl1 = @"-";
    }
    label8.text= hl1;
    label8.textAlignment = UITextAlignmentCenter;
    label8.tag = 2008;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label8];
	
	NSString *hl1kT = [LTypeRidHLTerm objectAtIndex:indexPath.row]; //health loading term
    CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width,y, 55, height);
    UILabel *label9=[[UILabel alloc]init];
    label9.frame=frame9;
    NSString *hl1T = nil;
    if ([hl1kT intValue] == 0) {
        hl1T = @"-";
    }
    else if([hl1kT intValue] !=0) {
        hl1T = hl1kT;
    }
    else {
        hl1T = @"-";
    }
    label9.text= hl1T;
    label9.textAlignment = UITextAlignmentCenter;
    label9.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label9];
	
	//--
	
    NSString *hlp = [LTypeRidHLP objectAtIndex:indexPath.row];
	CGRect frame10=CGRectMake(frame9.origin.x + frame9.size.width,y, 50, height);
    UILabel *label10=[[UILabel alloc]init];
    label10.frame=frame10;
    NSString *temphlp = nil;
    if ([hlp isEqualToString:@"(null)"]) {
        temphlp = @"-";
    }
    else if (![hlp isEqualToString:@"(null)"] && [hlp intValue] > 0) {
        temphlp = [formatter stringFromNumber:[NSNumber numberWithDouble:[hlp doubleValue]]];
    }
    else {
        temphlp = @"-";
    }
    label10.text= temphlp;
    label10.textAlignment = UITextAlignmentCenter;
    label10.tag = 2010;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label10];
	
	//------
    NSString *hlpT = [LTypeRidHLPTerm objectAtIndex:indexPath.row];
    CGRect frame11=CGRectMake(frame10.origin.x + frame10.size.width,y, 55, height);
    UILabel *label11=[[UILabel alloc]init];
    label11.frame=frame11;
    NSString *temphlpT = nil;
    if ([hlpT intValue] == 0) {
        temphlpT = @"-";
    }
    else if([hlpT intValue] !=0) {
        temphlpT = hlpT;
    }
    else {
        temphlpT = @"-";
    }
    label11.text= temphlpT;
    label11.textAlignment = UITextAlignmentCenter;
    label11.tag = 2011;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label11];
	
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
        label10.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label11.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label11.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		
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
		label11.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label11.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
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
        
		if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"RRTUO" ] || [[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"MCFR" ] ) {
			txtSumAssured.text = [LTypePremium objectAtIndex:indexPath.row] ;
			txtRiderTerm.text = [LTypeRRTUOFromYear objectAtIndex:indexPath.row];
			//unitField.text = [LTypeUnits objectAtIndex:indexPath.row]
			txtPaymentTerm.text = [LTypeRRTUOYear objectAtIndex:indexPath.row];
		}
        else if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"TSR" ]) {
			txtSumAssured.text = SumToDisplay;
			txtRiderTerm.text = [LTypeTerm objectAtIndex:indexPath.row];
            txtReinvestment.text = [LTypePaymentTerm objectAtIndex:indexPath.row];
		}
        else if ([[LTypeRiderCode objectAtIndex:indexPath.row] isEqualToString:@"HCIR" ]) {
			txtSumAssured.text = SumToDisplay;
			txtRiderTerm.text = [LTypeTerm objectAtIndex:indexPath.row];
			txtPaymentTerm.text = [LTypeUnits objectAtIndex:indexPath.row];
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
		
		// *** plan option and payment term
		
		if ([getPlanCode isEqualToString:@"UP"]) {
			if ( [riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"TPDWP"] ||
				[riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"]) {
				if (getTerm == [txtRiderTerm.text intValue]) {
					
					outletRiderPlan.enabled = YES;
					outletRiderPlan.hidden = NO;
					[self.outletRiderPlan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
					txtRiderTerm.text = [NSString stringWithFormat:@"%d", getTerm];
					txtPaymentTerm.hidden = YES;
					
					[outletRiderPlan setTitle:[LPaymentTerm objectAtIndex:indexPath.row] forState:UIControlStateNormal];
					planOption = [[NSString alloc] initWithFormat:@"%@",outletRiderPlan.titleLabel.text];
					
				}
				else{
					outletRiderPlan.enabled = NO;
					outletRiderPlan.hidden = YES;
					txtPaymentTerm.hidden = NO;
					txtPaymentTerm.enabled = NO;
					txtPaymentTerm.text = [NSString stringWithFormat:@"%@", txtRiderTerm.text];
					txtPaymentTerm.textColor = [UIColor darkGrayColor];
					txtPaymentTerm.backgroundColor = [UIColor lightGrayColor];
					
				}
				
			}
            else if ([riderCode isEqualToString:@"TSR"]){
                [outletRiderPlan setTitle:[LTypePaymentChoice objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            }
			else{
                if ( ![[LTypePlanOpt objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
                    [outletRiderPlan setTitle:[LTypePlanOpt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    planOption = [[NSString alloc] initWithFormat:@"%@",outletRiderPlan.titleLabel.text];
                }
                
			}
		}
		else{
            if ([riderCode isEqualToString:@"TSR"]){
                [outletRiderPlan setTitle:[LTypePaymentChoice objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            }
            else{
                if (  ![[LTypePlanOpt objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
                    [outletRiderPlan setTitle:[LTypePlanOpt objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    planOption = [[NSString alloc] initWithFormat:@"%@",outletRiderPlan.titleLabel.text];
                }
            }
			
		}
		
		
		// *** deductible
        if ([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"] ) {
            if (  ![[LTypePreDeductible objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
                [outletDeductible setTitle:[LTypePreDeductible objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                deductible = [[NSString alloc] initWithFormat:@"%@",outletDeductible.titleLabel.text];
                
            }
            
            if (  ![[LTypePostDeductible objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
                
                [outletOccLoading setTitle:[LTypePostDeductible objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                strDeductiblePostRetirement = [[NSString alloc] initWithFormat:@"%@",outletOccLoading.titleLabel.text];
            }
            else{
                strDeductiblePostRetirement = @"";
            }
            
            
        }
        else{
            if (  ![[LTypeDeduct objectAtIndex:indexPath.row] isEqualToString:@"(null)"]) {
                [outletDeductible setTitle:[LTypeDeduct objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                deductible = [[NSString alloc] initWithFormat:@"%@",outletDeductible.titleLabel.text];
            }
        }
        
        
		
		// *** health loading part
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
        
        //Rider regular top up or optional benefit for MDSR1,MDSR2 and LDYR
        
        if ([riderCode isEqualToString:@"MDSR1"]) {
            if ([LTypeRiderCode indexOfObject:@"MDSR1-ALW"] != NSNotFound) {
                outletSegBottomLeft.selectedSegmentIndex = 0;
            }
            else{
                outletSegBottomLeft.selectedSegmentIndex = 1;
            }
            
            if ([LTypeRiderCode indexOfObject:@"MDSR1-OT"] != NSNotFound) {
                outletSegBottomRight.selectedSegmentIndex = 0;
            }
            else{
                outletSegBottomRight.selectedSegmentIndex = 1;
            }
        }
        else if ([riderCode isEqualToString:@"MDSR2"]) {
            if ([LTypeRiderCode indexOfObject:@"MDSR2-ALW"] != NSNotFound) {
                outletSegBottomLeft.selectedSegmentIndex = 0;
            }
            else{
                outletSegBottomLeft.selectedSegmentIndex = 1;
            }
            
            if ([LTypeRiderCode indexOfObject:@"MDSR2-OT"] != NSNotFound) {
                outletSegBottomRight.selectedSegmentIndex = 0;
            }
            else{
                outletSegBottomRight.selectedSegmentIndex = 1;
            }
        }
        else if ([riderCode isEqualToString:@"LDYR"]) {
            if ([LTypeRiderCode indexOfObject:@"LDYR-PCB"] != NSNotFound) {
                int temp = [LTypeRiderCode indexOfObject:@"LDYR-PCB"];
                int temp2 = [LTypeRiderCode indexOfObject:@"LDYR"];
                outletCheckBox1.selected = TRUE;
                [outletCheckBox1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
                txtRRTUP.enabled = TRUE;
                txtRRTUP.backgroundColor = [UIColor whiteColor];
                txtRRTUP.text = [NSString stringWithFormat:@"%.0f", [[LTypeSumAssured objectAtIndex:temp] doubleValue] ];
                txtSumAssured.text = [NSString stringWithFormat:@"%.0f", [[LTypeSumAssured objectAtIndex:temp2] doubleValue] ];
            }
            else{
                outletCheckBox1.selected = FALSE;
                [outletCheckBox1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
                txtRRTUP.enabled = FALSE;
                txtRRTUP.backgroundColor = [UIColor lightGrayColor];
                //txtRRTUP.text = @"";
            }
            
            if ([LTypeRiderCode indexOfObject:@"LDYR-BBB"] != NSNotFound) {
                int temp = [LTypeRiderCode indexOfObject:@"LDYR-BBB"];
                int temp2 = [LTypeRiderCode indexOfObject:@"LDYR"];
                outletCheckBox2.selected = TRUE;
                [outletCheckBox2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
                txtRRTUPTerm.enabled = TRUE;
                txtRRTUPTerm.backgroundColor = [UIColor whiteColor];
                txtRRTUPTerm.text = [NSString stringWithFormat:@"%.0f", [[LTypeSumAssured objectAtIndex:temp] doubleValue] ];
                txtSumAssured.text = [NSString stringWithFormat:@"%.0f", [[LTypeSumAssured objectAtIndex:temp2] doubleValue] ];
            }
            else{
                outletCheckBox2.selected = FALSE;
                [outletCheckBox2 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
                txtRRTUPTerm.enabled = FALSE;
                txtRRTUPTerm.backgroundColor = [UIColor lightGrayColor];
                //txtRRTUPTerm.text = @"";
            }
            
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


-(void)deductViewRetirement:(DeductiblePostRetirement *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc{
    Edit = TRUE;
    [self.outletOccLoading setTitle:itemdesc forState:UIControlStateNormal];
    strDeductiblePostRetirement = [[NSString alloc] initWithFormat:@"%@",itemdesc];
    
    [self.deducRetirementPopover dismissPopoverAnimated:YES];
}


-(void)deductView:(RiderDeducTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc{
	Edit = TRUE;
    NSLog(@"selectDeduc:%@",itemdesc);
    [self.outletDeductible setTitle:itemdesc forState:UIControlStateNormal];
    deductible = [[NSString alloc] initWithFormat:@"%@",itemdesc];
    
    if([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"] ){
        if (requestAge + [txtRiderTerm.text integerValue] > 60) {
                [self.outletOccLoading setTitle:@"0" forState:UIControlStateNormal];
        }
        else{
               [self.outletOccLoading setTitle:@"" forState:UIControlStateNormal];
        }
    
    }
	
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
    
    if (([riderCode isEqualToString:@"CIWP"] && [getPlanCode isEqualToString:@"UP"]) ||
        ([riderCode isEqualToString:@"TPDWP"] && [getPlanCode isEqualToString:@"UP"]) ||
        ([riderCode isEqualToString:@"LCWP"] && [getPlanCode isEqualToString:@"UP"]) ||
        ([riderCode isEqualToString:@"PR"] && [getPlanCode isEqualToString:@"UP"])) {
        txtPaymentTerm.text = itemdesc;
    }
	else if ([riderCode isEqualToString:@"TSR"]) {
        if ([itemdesc isEqualToString:@"Up to age 60"]) {
            txtReinvestment.text = [NSString stringWithFormat:@"%d", 60 - getAge];
            
        }
        else{
            txtReinvestment.text = txtRiderTerm.text;
        }
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
	FirstLAOccuCode = pTypeOccp;
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
	
    if ([code isEqualToString:@"MDSR1-ALW"] || [code isEqualToString:@"MDSR1-OT"] ) {
        code = @"MDSR1";
    }
    else if ([code isEqualToString:@"MDSR2-ALW"] || [code isEqualToString:@"MDSR2-OT"] ) {
        code = @"MDSR2";
    }
    else if ([code isEqualToString:@"LDYR-PCB"] || [code isEqualToString:@"LDYR-BBB"] ) {
        code = @"LDYR";
    }
    
	riderCode = [[NSString alloc] initWithFormat:@"%@",code];
    riderDesc = [[NSString alloc] initWithFormat:@"%@",desc];
    if ([code isEqualToString:@"MDSR1"]  ) {
        [self.outletRider setTitle:@"HLA MediShield Rider (1st Rider)" forState:UIControlStateNormal];
    }
    else if ( [code isEqualToString:@"MDSR2"] ) {
        [self.outletRider setTitle:@"HLA MediShield Rider (2nd Rider)" forState:UIControlStateNormal];
    }
    else{
        [self.outletRider setTitle:riderDesc forState:UIControlStateNormal];
    }
    
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
		//pTypeOccp = [[NSString alloc] initWithFormat:@"%@",self.PTypeList.selectedOccp];
		pTypeOccp = FirstLAOccuCode;
	}
	//----
	
	if ([code isEqualToString:@"TSR"]) {
        TSR = TRUE;
    }else{
        TSR = FALSE;
    }
    
	
	//[self getOccpNotAttach];
	
	if ([LRiderCode count] != 0){
                /*
		NSUInteger i;
                 
        for (i=0; i<[LRiderCode count]; i++) {
			NSLog(@"riderExist:%@, rider enter:%@",[LRiderCode objectAtIndex:i],riderCode);

			if (([riderCode isEqualToString:@"LCWP"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"PR"]) ||
				([riderCode isEqualToString:@"PR"] && [[LRiderCode objectAtIndex:i] isEqualToString:@"LCWP"])) {
                either = YES;
            }
             
            
            
		}
         */
        
        if (PTypeSeq == 2 ) {
            /*
            if ([LRiderCode indexOfObject:@"LCWP"] != NSNotFound && [riderCode isEqualToString:@"PR"]) {
                either = YES;
            }
            else if ([LRiderCode indexOfObject:@"PR"] != NSNotFound && [riderCode isEqualToString:@"LCWP"]) {
                either = YES;
            }
            else{
                either = NO;
            }
             */
            if ([LRiderPTypeSeq indexOfObject:@"2"] != NSNotFound){
                int temp = [LRiderPTypeSeq indexOfObject:@"2"];
                
                if ([[LRiderCode objectAtIndex:temp] isEqualToString:@"LCWP"] && [riderCode isEqualToString:@"PR"]) {
                    either = YES;
                }
                else if ([[LRiderCode objectAtIndex:temp] isEqualToString:@"PR"] && [riderCode isEqualToString:@"LCWP"]) {
                    either = YES;
                }
                else{
                    either = NO;
                }
            }
        
            
        }
        else if (PTypeSeq == 1 && [pTypeCode isEqualToString:@"PY"] ) {
            /*
            if ([LRiderCode indexOfObject:@"LCWP"] != NSNotFound && [riderCode isEqualToString:@"PR"]) {
                either = YES;
            }
            else if ([LRiderCode indexOfObject:@"PR"] != NSNotFound && [riderCode isEqualToString:@"LCWP"]) {
                either = YES;
            }
            else{
                either = NO;
            }
             */
            
            if ([LRiderPType indexOfObject:@"PY"] != NSNotFound){
                int temp = [LRiderPType indexOfObject:@"PY"];
                
                if ([[LRiderCode objectAtIndex:temp] isEqualToString:@"LCWP"] && [riderCode isEqualToString:@"PR"]) {
                    either = YES;
                }
                else if ([[LRiderCode objectAtIndex:temp] isEqualToString:@"PR"] && [riderCode isEqualToString:@"LCWP"]) {
                    either = YES;
                }
                else{
                    either = NO;
                }
            }
        }
        else
        {
            either = NO;
        }
        
		if (either) {
			if (PTypeSeq == 1 ) { //payor
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																message:@"Please select only either one of LCWP or PR." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[self.outletRider setTitle:@"" forState:UIControlStateNormal];
			}
			else{ //2nd life assured
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
    LTypePaymentChoice = [[NSMutableArray alloc] init];
    LTypeGYIYear = [[NSMutableArray alloc] init];
    LTypePreDeductible = [[NSMutableArray alloc] init];
    LTypePostDeductible = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"";
        if ([pTypeCode isEqualToString:@"PY"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
                        "a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
						"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear, ifnull(a.PaymentChoice, ''), ifnull(a.GYIYear,0), "
                        "ifnull(a.PreDeductible, '0'), ifnull(a.PostDeductible, '0') FROM UL_Rider_Details a, "
                        "UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
                        "AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'PY' ",getSINo];
        }
        else {
            if (PTypeSeq == 2) {
				querySQL = [NSString stringWithFormat:
							@"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
							"a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear, ifnull(a.PaymentChoice, ''), ifnull(a.GYIYear,0), "
                            "ifnull(a.PreDeductible, '0'), ifnull(a.PostDeductible, '0') FROM UL_Rider_Details a, "
							"UL_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq AND b.CustCode=c.CustCode "
							"AND a.SINo=b.SINo AND a.SINo=\"%@\" AND b.Ptypecode = 'LA' AND b.Seq = '2'  ",getSINo];
				
            }
            else {
                querySQL = [NSString stringWithFormat:
							@"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HLoading, "
							" a.HLoadingPct, c.Smoker,c.Sex, c.ALB, "
							"c.OccpCode, a.HLoadingTerm, a.HLoadingPctTerm, a.premium, a.ReinvestGYI, a.PaymentTerm, a.RRTUOFromYear, a.RRTUOYear, ifnull(a.PaymentChoice, ''), ifnull(a.GYIYear,0), "
                            "ifnull(a.PreDeductible, '0'), ifnull(a.PostDeductible, '0') FROM UL_Rider_Details a, "
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
                [LTypePaymentChoice addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)]];
                [LTypeGYIYear addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)]];
                [LTypePreDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 21)]];
                [LTypePostDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 22)]];

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
				lblTable10.hidden = YES;
				lblTable11.hidden = YES;
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
				lblTable10.hidden = NO;
				lblTable11.hidden = NO;
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
	
	
        maxRiderTerm = maxTerm;
        
        if (pTypeAge > 65 ) {
            minTerm = 80;
        }
        else if (pTypeAge > 60 ) {
            minTerm = 75;
        }
        else if (pTypeAge > 55 ) {
            minTerm = 70;
        }
        else if (pTypeAge > 50 ) {
            minTerm = 65;
        }
        else if (pTypeAge > 45 ) {
            minTerm = 60;
        }
        else {
            minTerm = 55;
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

    if ([riderCode isEqualToString:@"ACIR"] || [riderCode isEqualToString:@"LDYR"]  )
    {
		maxRiderSA = fmin(maxSATerm, getBasicSA);
    }
    else if ([riderCode isEqualToString:@"MSR"]   )
    {
		maxRiderSA = MAX(20000, getBasicSA);
    }
	else if([riderCode isEqualToString:@"CIRD"]){
		maxRiderSA = maxSATerm;
	}
	else if([riderCode isEqualToString:@"DCA"]){
		maxRiderSA = fmin(getBasicSA * 5, 1000000);
	}
    else if([riderCode isEqualToString:@"DHI"]){
		if ([[OccpCat stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"EMP"]) {
			maxRiderSA = 800;
		}
		else if ([OccpCat isEqualToString:@"UNEMP"]) {
			maxRiderSA = 0;
		}
		else{
			maxRiderSA = 200;
		}
	}
	else if([riderCode isEqualToString:@"LSR"] || [riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"] || [riderCode isEqualToString:@"LCWP"] ||
			[riderCode isEqualToString:@"ECAR60"] || [riderCode isEqualToString:@"CIWP"] || [riderCode isEqualToString:@"RRTUO"] || [riderCode isEqualToString:@"TSR"] || [riderCode isEqualToString:@"TSER"] ||
            [riderCode isEqualToString:@"TPDWP"]) {
			maxRiderSA = 9999999990;
	}
	else if([riderCode isEqualToString:@"PA"]){
		maxRiderSA = MIN(getBasicSA * 5, 1000000) ;
	}
	else if( [riderCode isEqualToString:@"WI"]){
		if ([OccpCat isEqualToString:@"UNEMP"]) {
			maxRiderSA = 0;
		}
		else{
			maxRiderSA = maxSATerm;
		}
	}
    else if([riderCode isEqualToString:@"TPDMLA"] ){
		if ([OccpCat isEqualToString:@"EMP"]) {
			maxRiderSA = maxSATerm;
		}
		else{
			maxRiderSA = 2000;
		}
	}
	else if([riderCode isEqualToString:@"MR"] ){
		maxRiderSA = maxSATerm;
	}
    else if([riderCode isEqualToString:@"CCR"]  ){
		maxRiderSA = (4000000 - [self ReturnMaxSA]) * 0.8;
	}
    else if( [riderCode isEqualToString:@"TCCR"]   ){
        maxRiderSA = 200000;
    }
    else if(  [riderCode isEqualToString:@"JCCR"]   ){
        maxRiderSA = 500000;
    }
    else if([riderCode isEqualToString:@"TPDYLA"] ){
		if ([OccpCat isEqualToString:@"EMP"]) {
            maxRiderSA = MIN(0.25 * getBasicSA, 200000);
        }
        else{
            maxRiderSA = MIN(0.25 * getBasicSA, 24000);
        }
	}
    else if([riderCode isEqualToString:@"MCFR"] ){
        //#medi
        //////maxRiderSA = 0.7 * [self ReturnMCFRMaxPrem];
        
        double amtMDSR1 = 0.0;
        double allowPercentageMDSR1 = 0.0;
        double amtMDSR2 = 0.0;
        double allowPercentageMDSR2 = 0.0;
        
        for (int i = 0; i< LTypeRiderCode.count; i++) {
            NSLog(@"#medi %@ - %@ - %@ - %@",[LTypeRiderCode objectAtIndex:i],[LTypePremium objectAtIndex:i],[LTypePreDeductible objectAtIndex:i],[LTypePostDeductible objectAtIndex:i]);
            
            NSString *tmpRiderCode = [LTypeRiderCode objectAtIndex:i];
            if ([tmpRiderCode rangeOfString:@"MDSR1"].location != NSNotFound) {
                amtMDSR1 += [[LTypePremium objectAtIndex:i] doubleValue];
                
                if ([[LTypePreDeductible objectAtIndex:i] doubleValue] > [[LTypePostDeductible objectAtIndex:i] doubleValue]) {
                    
                    if ([[LTypePostDeductible objectAtIndex:i] doubleValue] == 0.0 || [[LTypePostDeductible objectAtIndex:i] doubleValue] == 10000.0 || [[LTypePostDeductible objectAtIndex:i] doubleValue] == 20000.0) {
                        allowPercentageMDSR1 = 10.0;
                    }else {
                        allowPercentageMDSR1 = 1.0;
                    }
                    
                }else {
                    allowPercentageMDSR1 = 1.0;
                }
                
            }
            
            if ([tmpRiderCode rangeOfString:@"MDSR2"].location != NSNotFound) {
                amtMDSR2 += [[LTypePremium objectAtIndex:i] doubleValue];
                
                if ([[LTypePreDeductible objectAtIndex:i] doubleValue] > [[LTypePostDeductible objectAtIndex:i] doubleValue]) {
                    
                    if ([[LTypePostDeductible objectAtIndex:i] doubleValue] == 0.0 || [[LTypePostDeductible objectAtIndex:i] doubleValue] == 10000.0 || [[LTypePostDeductible objectAtIndex:i] doubleValue] == 20000.0) {
                        allowPercentageMDSR2 = 10.0;
                    }else {
                        allowPercentageMDSR2 = 1.0;
                    }
                    
                }else {
                    allowPercentageMDSR2 = 1.0;
                }
                
            }
            
            
            
        }
        
        NSLog(@"#2medi %.2f, %.f",amtMDSR1,allowPercentageMDSR1);
        maxRiderSA = (amtMDSR1 * allowPercentageMDSR1) + (amtMDSR2 * allowPercentageMDSR2);
        
        
        
        
	}
    else{
        maxRiderSA = 99999999999;
    }
    
	/*
	if (maxRiderSA > 1500000) {
		maxRiderSA = 1500000;
	}
	*/
	NSLog(@"maxSA(%@):%.f",riderCode,maxRiderSA);
}

-(double)ReturnMaxSA{
    sqlite3_stmt *statement;
    double tempValue = 0.00;
    int tempRiderTerm = 0;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
            
            querySQL = [NSString stringWithFormat:@"SELECT ridercode, SumAssured, riderterm  FROM UL_Rider_Details WHERE RiderCode in ('TCCR', 'JCCR', 'ACIR', 'LCWP', 'CIWP', 'MSR', 'LDYR' ) "
                        "ANd SINO = '%@' group by ridercode ", getSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    tempRiderTerm = sqlite3_column_double(statement, 2);
                    
                    if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"TCCR"]) {
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 1.25;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"JCCR"]) {
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 1.25;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"ACIR"]) {
                            tempValue = tempValue + sqlite3_column_double(statement, 1);
                    }
                    /*
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LCWP"]) {
                        if (tempRiderTerm <= 10) {
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 4;
                        }
                        else{
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 8;
                        }
                        
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"CIWP"]) {
                        if (tempRiderTerm <= 10) {
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 4;
                        }
                        else{
                            tempValue = tempValue + sqlite3_column_double(statement, 1) * 8;
                        }
                        
                    }
                     */
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"MSR"]) {
                        tempValue = tempValue + sqlite3_column_double(statement, 1) * 1.25;
                    }
                    else if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"LDYR"]) {
                        tempValue = tempValue + sqlite3_column_double(statement, 1) * 1.25;
                    }
                
                }
                
                sqlite3_finalize(statement);
            }
        
        
        sqlite3_close(contactDB);
    }
    
    return tempValue;

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
		
    int paymentTerm = 0;
    if ([riderCode isEqualToString:@"TSR"]) {
        paymentTerm = [txtReinvestment.text intValue];
    }
    else{
        paymentTerm = [txtPaymentTerm.text intValue];
    }
    
    if (txtRiderTerm.text.length <= 0 && ![riderCode isEqualToString:@"RRTUO"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if (txtRiderTerm.text.length <= 0 && ![riderCode isEqualToString:@"MCFR"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Rider Term must be numeric 0 to 9 only" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text intValue] > maxRiderTerm) {
        UIAlertView *alert;
        if ([riderCode isEqualToString:@"RRTUO"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Regular Topup Option Commencing Year must be less than or equal to %.f",maxRiderTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        }
        else if ([riderCode isEqualToString:@"MCFR"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"MCFR Commencing Year must be less than or equal to %.f",maxRiderTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
        }
        else{
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Term must be less than or equal to %.f",maxRiderTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

        }
        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }
    else if ([txtRiderTerm.text intValue] < minTerm) {
        UIAlertView *alert;
        if ([riderCode isEqualToString:@"RRTUO"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Regular Topup Option Commencing Year must be greater than or equal to %d",minTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];            
        }
        else if ([riderCode isEqualToString:@"MCFR"]) {
            
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"MCFR Commencing Year must be greater than or equal to %d",minTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }
        else{
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Term must be greater than or equal to %d",minTerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        }

        [alert setTag:1006];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
    }

	
	else if ([riderCode isEqualToString:@"RRTUO"] && [txtPaymentTerm.text intValue ] > (getTerm - [txtRiderTerm.text intValue]) ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Regular Top Up Option Year cannot be greater than %d",(getTerm - [txtRiderTerm.text intValue])]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtPaymentTerm becomeFirstResponder];
    }
    else if ([riderCode isEqualToString:@"MCFR"] && [txtPaymentTerm.text intValue ] > (getTerm - [txtRiderTerm.text intValue]) ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"MCFR Year cannot be greater than %d",(getTerm - [txtRiderTerm.text intValue])]
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtPaymentTerm becomeFirstResponder];
    }
    
    else if ([txtHLTerm.text intValue] > paymentTerm ) {
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d", paymentTerm];
        } 
		else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading (%%) Term cannot be greater than %d",paymentTerm];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    else if (([riderCode isEqualToString:@"BLIFECIAC"] || [riderCode isEqualToString:@"BLIFECIAD"] || [riderCode isEqualToString:@"BLIFEWVRT"] ||
              [riderCode isEqualToString:@"BPW"] || [riderCode isEqualToString:@"BPWD"] || [riderCode isEqualToString:@"BLIFEPYRD"]) &&
             [txtRiderTerm.text intValue]% 5 != 0) {
        NSString *msg = @"Rider term must be ";
        
        msg = [msg stringByAppendingString:[NSString stringWithFormat:@"55, 65, 70, 75, 85 only. "]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    else if ([riderCode isEqualToString:@"CCR"] && [txtRiderTerm.text intValue]% 5 != 0) {
        NSString *msg = @"Rider term must be ";

        if ([getPlanCode isEqualToString:@"UV"]) {
            for (int i = 5; i <= 35; i = i + 5) {
                if (i + pTypeAge < 100) {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                }
            }
            
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%.0f ", maxRiderTerm]];

        }
        else{
            for (int i = 5; i <= requestCoverTerm; i = i + 5) {
                
                msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                
            }
            
            msg = [msg substringToIndex:msg.length - 1];;
            
        }
        
        //msg = [msg substringToIndex:msg.length - 1];
        msg = [msg stringByAppendingString:[NSString stringWithFormat:@" only. "]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([riderCode isEqualToString:@"TCCR"] && [txtRiderTerm.text intValue]% 5 != 0) {
        NSString *msg = @"Rider term must be ";
        
        if ([getPlanCode isEqualToString:@"UV"]) {
            for (int i = 5; i <= 35; i = i + 5) {
                if (i + pTypeAge < 100) {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                }
            }
            
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%.0f ", maxRiderTerm]];
            
        }
        else{
            for (int i = 5; i <= requestCoverTerm; i = i + 5) {
                
                msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                
            }
            
            msg = [msg substringToIndex:msg.length - 1];;
            
        }
        
        //msg = [msg substringToIndex:msg.length - 1];
        msg = [msg stringByAppendingString:[NSString stringWithFormat:@" only. "]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([riderCode isEqualToString:@"HCIR"] && [txtRiderTerm.text intValue]% 5 != 0) {
        NSString *msg = @"Rider term must be ";
        
        if ([getPlanCode isEqualToString:@"UV"]) {
            for (int i = 5; i <= 35; i = i + 5) {
                if (i + pTypeAge < 70) {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                }
            }
            
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%.0f ", maxRiderTerm]];
            
        }
        else{
            for (int i = 5; i <= requestCoverTerm; i = i + 5) {
                
                msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                
            }
            
            msg = [msg substringToIndex:msg.length - 1];;
            
        }
        
        //msg = [msg substringToIndex:msg.length - 1];
        msg = [msg stringByAppendingString:[NSString stringWithFormat:@" only. "]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if ([self CheckJCCRTerm] == FALSE) {
       
        
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Guaranteed Yearly Income\n is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Sum Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert setTag:1006];
            [alert show];
        }
        [txtSumAssured becomeFirstResponder];
    }
    else if ([txtSumAssured.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Input must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }
    //--
    else if ([txtSumAssured.text rangeOfCharacterFromSet:setHLACP].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Sum Assured does not allows decimal." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }//--
    else if ([riderCode isEqualToString:@"TPDYLA"] && getBasicSA < 20000 ){
		NSString *msg = [NSString stringWithFormat:@"Min RSA for TPDYLA is RM5,000. Thus, please increase BSA to at least RM20,000."];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
	}
    else if ([txtSumAssured.text doubleValue] < minSATerm) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be greater than or equal to %d",minSATerm] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:1006];
        [alert show];
        [txtSumAssured becomeFirstResponder];
    }
    else if ([txtSumAssured.text doubleValue] > maxRiderSA) {
        UIAlertView *alert;
        
        if ([riderCode isEqualToString:@"MCFR"]) {
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Maximum Rider Premium must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
        }
        else  {
            alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Rider Sum Assured must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
        }
        
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
    
    int paymentTerm = 0;
    if ([riderCode isEqualToString:@"TSR"]) {
        paymentTerm = [txtReinvestment.text intValue];
    }
    else{
        paymentTerm = [txtPaymentTerm.text intValue];
    }
    
    for (i=0; i<[FLabelCode count]; i++)
    {
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HL1K"]]) {
            HL1kTerm = YES;
        }
        if ([[FLabelCode objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"HLP"]]) {
            HLPTerm = YES;
        }
    }
    
    if (plan && planOption.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Plan Option/Choice is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    /*
    else if (deduc && deductible.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider Deductible is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    */
    //--
    else if (inputHLPercentage.length != 0 && [txtHLP.text intValue] > 999) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (%) cannot greater than 999%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
	
    else if (txtHL.text.length == 0 && [txtHLTerm.text intValue] != 0) {
		
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if ([txtHL.text intValue] != 0 && txtHLTerm.text.length == 0) {
        
        NSString *msg = @"";
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    else if (txtHLP.text.length == 0 && [txtHLPTerm.text intValue] != 0) {
		
        NSString *msg;
            msg = @"Health Loading (%) is required.";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLP becomeFirstResponder];
    }
    else if ([txtHLP.text intValue] != 0 && txtHLPTerm.text.length == 0) {
        
        NSString *msg = @"";
            msg = @"Health Loading (%) Term is required.";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLPTerm becomeFirstResponder];
    }
	/*
    else if (inputHL1KSA.length != 0 && [txtHL.text intValue] > 10000) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading 1 (Per 1k SA) cannot greater than 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
	 */
    else if ([txtHL.text intValue] !=0 && substring.length > 3) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (Per 1k SA) only allow 2 decimal places.";
        }
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if (inputHLPercentage.length != 0 && substring.length > 1) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading 1 (%) must not contains decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    else if ([txtHLTerm.text intValue] > paymentTerm) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (per 1k SA) Term cannot be greater than %d", paymentTerm];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtHLTerm becomeFirstResponder];
        }
		else if (HLPTerm) {
            msg = [NSString stringWithFormat:@"Health Loading 1 (%%) Term cannot be greater than %d", paymentTerm];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtHLPTerm becomeFirstResponder];
        }
        
    }
    
    else if ([txtHLTerm.text intValue] == 0 && txtHL.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading 1 (per 1k SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading 1 (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    else if ([txtHLPTerm.text intValue] == 0 && txtHLP.text.length != 0) {
        
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHL becomeFirstResponder];
    }
    else if ([txtHLPTerm.text intValue] == 0 && txtHLP.text.length != 0) {
        NSString *msg;
        if (HL1kTerm) {
            msg = @"Health Loading (per 1k SA) Term is required.";
        } else if (HLPTerm) {
            msg = @"Health Loading (%) Term is required.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtHLTerm becomeFirstResponder];
    }
    //--
    else if ([riderCode isEqualToString:@"TPDYLA"] && getBasicSA < 20000 ){
		NSString *msg = [NSString stringWithFormat:@"Min RSA for TPDYLA is RM5,000. Thus, please increase BSA to at least RM20,000."];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
	}
    else if ([riderCode isEqualToString:@"MSR"] && getBasicSA < 20000 ){
		NSString *msg = [NSString stringWithFormat:@"Min RSA for MSR is RM20,000. Thus, please increase BSA to at least RM20,000."];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
	}
	else if ([riderCode isEqualToString:@"DHI"] && [txtSumAssured.text integerValue] % 50 != 0){
		NSString *msg = @"DHI Sum Assured Must be in multiple of 50";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"]) && [txtRiderTerm.text integerValue] % 5 != 0){
		NSString *msg = @"Rider Term must be 20 or 25 only.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtRiderTerm becomeFirstResponder];
	}
	else if (([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"]) && [txtSumAssured.text intValue ] < minSATerm ){
		NSString *msg = [NSString stringWithFormat:@"Amount Insured must be greater than or equal to %d", minSATerm];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
	else if ([riderCode isEqualToString:@"ECAR60"] && [txtSumAssured.text intValue ] < minSATerm ){
		NSString *msg = [NSString stringWithFormat:@"Monthly Income must be greater than or equal to %d", minSATerm ];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtSumAssured becomeFirstResponder];
	}
    else if ([self CheckDuplicateMDSR] == TRUE) {
        NSString *msg = [NSString stringWithFormat:@"Please revise the plan choice or the deductible option of the Rider as same combination of previous MediShield Rider is selected."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self CheckExceedMDSRlimit] == TRUE) {
        
        if ([self.OccpCat isEqualToString:@"EMP"]) {
        
            NSString *msg = [NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MediShield Rider must be less than or equal to RM500 for 1st LA"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else{
        
            NSString *msg = [NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MediShield Rider must be less than or equal to RM400 for 1st LA"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
	else if ([riderCode isEqualToString:@"RRTUO"]){
		bool unitization = false;
		for (int i = 0; i < LTypeRiderCode.count ; i++) {
			if ([[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MR"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"WI"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"DHI"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"TPDMLA"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"PA"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"DCA"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"CIRD"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"ACIR"] ||
				[[LTypeRiderCode objectAtIndex:i] isEqualToString:@"HMM"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MG_IV"] ||
                [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"TPDYLA"]) {
				unitization = TRUE;
				break;
			}
		}
		
		if (unitization == FALSE) {
			NSString *msg = @"RRTUO is not allowed if no unitization rider is attached";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		else{
            if ([txtSumAssured.text intValue] == 0) {
                NSString *msg = @"Premium cannot be blank. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtSumAssured becomeFirstResponder];
            }
            else if ([txtRiderTerm.text intValue] == 0) {
                NSString *msg = @"Please key in Rider Regular Top Up Start Year. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtPaymentTerm becomeFirstResponder];
            }
            else if ([txtPaymentTerm.text intValue] == 0) {
                NSString *msg = @"Please key in Rider Regular Top Up Year. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtPaymentTerm becomeFirstResponder];
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
		
		
	}
    else if ([self MCFRisValid] == FALSE){
        
    }
    else if ([self LDYROptionalBenefitIsValid] == FALSE){
        
    }
    else if ([riderCode isEqualToString:@"HMM"] && [planOption isEqualToString:@"HMM_1000"] && ![OccpCat isEqualToString:@"EMP"]) {
        NSString *msg = [NSString stringWithFormat:@"This category is not allowed to purchase this rider. " ];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HSP_II"]) && LRiderCode.count != 0) {
        
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

-(BOOL)CheckJCCRTerm{

    NSString *msg = @"Rider term must be ";
    BOOL temp = FALSE;
    
    if ([riderCode isEqualToString:@"JCCR"]) {
        if ([getPlanCode isEqualToString:@"UV"]) {
            
            if ([txtRiderTerm.text intValue] != 20 && [txtRiderTerm.text intValue] != 25 && [txtRiderTerm.text doubleValue] != maxRiderTerm )  {
                msg = [msg stringByAppendingString:[NSString stringWithFormat:@"20, 25 and %.0f ", maxRiderTerm]];
            }
            else{
                temp = TRUE;
            }
            
        }
        else{
            
            if (getTerm > 20) {
                if ([txtRiderTerm.text intValue] != 20 && [txtRiderTerm.text intValue] != 25  )  {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"20, 25"]];
                }
                else{
                    temp = TRUE;
                }
                
            }
            else{
                if ([txtRiderTerm.text intValue] != 20 && [txtRiderTerm.text intValue] != 25  )  {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"20"]];
                }
                else{
                    temp = TRUE;
                }
                
            }
            
        }
        
        if (temp == FALSE) {
            msg = [msg stringByAppendingString:[NSString stringWithFormat:@" only. "]];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return  FALSE;
        }
        else{
            return TRUE;
        }
    }
    else{
        return TRUE;
    }
    
    
}

-(BOOL)CheckDuplicateMDSR{
    sqlite3_stmt *statement;
    //NSString *returnValue = @"";
    NSString *tempValue = @"";
    NSString *tempValue1 = @"";
    NSString *tempValue2 = @"";
    NSString *tempValue3 = @"";
    
    if ([riderCode isEqualToString:@"MDSR1"]) {
        tempValue = @"MDSR2";
    }
    else{
        tempValue = @"MDSR1";
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT PlanOption, PreDeductible, PostDeductible FROM UL_Rider_Details WHERE RiderCode = '%@' ANd SINO = '%@' ", tempValue, getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempValue1 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                tempValue2 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                tempValue3 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if ([planOption isEqualToString:tempValue1] && [outletDeductible.titleLabel.text isEqualToString:tempValue2] && [outletOccLoading.titleLabel.text isEqualToString:tempValue3]) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}

-(BOOL)CheckExceedMDSRlimit{
    sqlite3_stmt *statement;
    NSString *tempValue1 = @"";
    double tempValue = 0;

    if ([riderCode isEqualToString:@"MDSR1"]) {
        tempValue1 = @"MDSR2";
    }
    else{
        tempValue1 = @"MDSR1";
    }
    

    if ([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"] ) {
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT sum(substr(planoption, 4)) FROM UL_Rider_Details WHERE RiderCode = '%@' ANd SINO = '%@' ", tempValue1,  getSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    tempValue = sqlite3_column_double(statement, 0);
                    
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        //lianshen
        if ([self.OccpCat isEqualToString:@"EMP"]) {
        
            if (tempValue + [[planOption substringFromIndex:3] intValue]  > 500) {
                return TRUE;
            }
            else{
                return FALSE;
            }
            
        }else{
        
            if (tempValue + [[planOption substringFromIndex:3] intValue]  > 400) {
                return TRUE;
            }
            else{
                return FALSE;
            }
        }
        
    }
    else{
        return FALSE;
    }

}

-(BOOL)MCFRisValid{
    if ([riderCode isEqualToString:@"MCFR"]) {
        bool AttachMDSR = false;
        for (int i = 0; i < LTypeRiderCode.count ; i++) {
            if ([[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MDSR1"] || [[LTypeRiderCode objectAtIndex:i] isEqualToString:@"MDSR2"]) {
                AttachMDSR = TRUE;
                break;
            }
        }
        
        if (AttachMDSR == FALSE) {
            NSString *msg = @"MCFR is not allowed if no MDSR is attached";
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];

            return FALSE;
        }
        else{
            if ([txtSumAssured.text intValue] == 0) {
                NSString *msg = @"Premium cannot be blank. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtSumAssured becomeFirstResponder];
                return FALSE;
            }
            
            else if (txtRiderTerm.text.length == 0) {
                NSString *msg = @"Please key in Top Up Start Year. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtRiderTerm becomeFirstResponder];
                return FALSE;
            }
             
            else if ([txtPaymentTerm.text intValue] == 0) {
                NSString *msg = @"Please key in Top Up Year. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtPaymentTerm becomeFirstResponder];
                return FALSE;
            }
            else if([txtSumAssured.text doubleValue] > maxRiderSA){ 
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Maximum Rider Premium must be less than or equal to %.f",maxRiderSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

                [alert show];
                [txtSumAssured becomeFirstResponder];
                return FALSE;
                
            }
                
            else{
                return TRUE;
            }
            
        }
    }
    else
    {
        return TRUE;
    }
   
}

-(BOOL)LDYROptionalBenefitIsValid{
    bool temp = FALSE;
    
    if ([riderCode isEqualToString:@"LDYR"]) {
        if (outletCheckBox2.selected == TRUE) {
            if ([txtSumAssured.text intValue] == 0) {
                NSString *msg = @"Rider Sum Assured is required. ";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtSumAssured becomeFirstResponder];
                temp = FALSE;
            }
            else if ([txtRRTUPTerm.text doubleValue] < 20000) {
                NSString *msg = [NSString stringWithFormat:@"Minimum Baby Bonus Benefit Sum Assured must be equal or greater than %d . ", [txtSumAssured.text integerValue]] ;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtRRTUPTerm becomeFirstResponder];
                temp = FALSE;
            }
            else if ([txtRRTUPTerm.text doubleValue] > [txtSumAssured.text doubleValue]) {
                NSString *msg = [NSString stringWithFormat:@"Maximum Baby Bonus Benefit Sum Assured must be equal or less than %d . ", [txtSumAssured.text integerValue]] ;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtRRTUPTerm becomeFirstResponder];
                temp = FALSE;
            }

            else{
                temp = TRUE;
            }
            
        }
        else{
            temp = TRUE;
        }
        
        if (temp == TRUE) {
            if (outletCheckBox1.selected == TRUE) {
                if ([txtSumAssured.text intValue] == 0) {
                    NSString *msg = @"Rider Sum Assured is required. ";
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtSumAssured becomeFirstResponder];
                    temp = FALSE;
                }
                else if ([txtRRTUP.text doubleValue] < 20000) {
                    NSString *msg = [NSString stringWithFormat:@"Minimum Pregnancy Care Benefit Sum Assured must be greater than or equal to %d. ", [txtSumAssured.text integerValue]] ;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtRRTUP becomeFirstResponder];
                    temp = FALSE;
                }
                else if ([txtRRTUP.text doubleValue] > [txtSumAssured.text doubleValue]) {
                    NSString *msg = [NSString stringWithFormat:@"Maximum Pregnancy Care Benefit Sum Assured must be less than or equal to %d. ", [txtSumAssured.text integerValue]] ;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtRRTUP becomeFirstResponder];
                    temp = FALSE;
                }
                else{
                    temp = TRUE;
                }
                
            }
            else{
                temp = TRUE;
            }
        }
        
        return temp;

    }
    else
    {
        return TRUE;
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [self roomBoardDefaultPlanNew];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [self roomBoardDefaultPlanNew];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [self roomBoardDefaultPlan];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self roomBoardDefaultPlan];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Daily Room & Board Benefit for combination of all MedGLOBAL, HSP II and Major Medi rider(s) must be less than or equal to RM%d for 1st LA.",RBLimit] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    NSString *insertSQL;    
	
    if (([pTypeCode isEqualToString:@"LA"]) && (PTypeSeq == 2)) {
        [self check2ndLARider];
    }

    inputSA = [txtSumAssured.text doubleValue];
	[self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:[txtSumAssured.text doubleValue] andPaymentTerm:txtPaymentTerm.text andRiderPlan:outletRiderPlan.titleLabel.text andRiderDeduc:outletDeductible.titleLabel.text andGYIFrom:txtGYIFrom.text andTSRPaymentTerm:txtReinvestment.text andTSRPaymentChoice:outletRiderPlan.titleLabel.text andHL:txtHL.text andHLP:txtHLP.text];
	
	NSString *FullRiderDesc = [self ReturnRiderDesc:riderCode];
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {

		if ([riderCode isEqualToString:@"ECAR"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, RiderLoadingPremium, paymentchoice) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%f', '')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem , txtPaymentTerm.text, [self ReturnReinvest],
						 @"1", @"0", @"0", FullRiderDesc, CurrentRiderLoadingPremium];
		}
		if ([riderCode isEqualToString:@"ECAR6"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, RiderLoadingPremium, paymentchoice ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%f', '')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem , txtPaymentTerm.text, [self ReturnReinvest],
						 @"6", @"0", @"0", FullRiderDesc, CurrentRiderLoadingPremium];
		}
		else if ([riderCode isEqualToString:@"ECAR60"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, paymentchoice, RiderLoadingPremium ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '', '%f')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem  , txtPaymentTerm.text, [self ReturnReinvest],
						 @"60", @"0", @"0", FullRiderDesc, CurrentRiderLoadingPremium];
		}
		else if ([riderCode isEqualToString:@"RRTUO"] || [riderCode isEqualToString:@"MCFR"]) {
			insertSQL = [NSString stringWithFormat:
						 @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
						 "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
						 "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, paymentchoice, RiderLoadingPremium ) VALUES"
						 "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
						 "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '', '%f')",
						 getSINo,riderCode, pTypeCode, PTypeSeq, @"0", @"0", planOption,
						 deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
						 inputHLPercentageTerm, CurrentRiderPrem  , @"15", @"No",
						 @"0", txtRiderTerm.text, txtPaymentTerm.text, FullRiderDesc, CurrentRiderLoadingPremium];
        
		}
        else if([riderCode isEqualToString:@"TSR"]) {
			insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
                         "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f')",
                         getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, @"",
                         deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , txtReinvestment.text, [self ReturnReinvest], @"0", @"0", @"0", FullRiderDesc,
                         outletRiderPlan.titleLabel.text, CurrentRiderLoadingPremium];
		}
        else if([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"]) {
			insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium, premium2, premium3 ) VALUES"
                         "(\"%@\", \"%@\", \"%@\" , \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" , \"%@\",  \"%d\", \"%@\", \"%d\", "
                         "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f', '%f', '%f');",
                         getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
                         deductible, strDeductiblePostRetirement,  inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , txtPaymentTerm.text, @"No", @"0", @"0", @"0", FullRiderDesc, @"", CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3];
            
            //NSLog(@"%@", insertSQL);
            
		}
        else if([riderCode isEqualToString:@"HCIR"]) {
			insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium, premium2, premium3, units ) VALUES"
                         "(\"%@\", \"%@\", \"%@\" , \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" , \"%@\",  \"%d\", \"%@\", \"%d\", "
                         "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f', '%f', '%f','%d');",
                         getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, @"",
                         @"", @"",  @"0", 0, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , txtRiderTerm.text, @"No", @"0", @"0", @"0", FullRiderDesc, @"", CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3, [txtPaymentTerm.text intValue]];

            
		}
		else
		{
			insertSQL = [NSString stringWithFormat:
								   @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
								   "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
								   "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, paymentchoice, RiderLoadingPremium, premium2, premium3 ) VALUES"
								   "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
								   "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '', '%f','%f' ,'%f')",
								   getSINo,riderCode, pTypeCode, PTypeSeq, txtRiderTerm.text, txtSumAssured.text, planOption,
								   deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
									inputHLPercentageTerm, CurrentRiderPrem ,
									([riderCode isEqualToString:@"HMM" ] || [riderCode isEqualToString:@"MG_IV" ]) ? txtRiderTerm.text : txtPaymentTerm.text,
									[self ReturnReinvest], @"0", @"0", @"0", FullRiderDesc, CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3];
		}
		

        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
				appDel.isNeedPromptSaveMsg = YES;
                NSLog(@"Saved Rider!");
                //[_delegate RiderAdded];
            } else {
                NSLog(@"Failed Save Rider!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        
       
        
        sqlite3_close(contactDB);
    }
    
    //[_delegate RiderAdded];
    
    //sub riders for HSR and LDYR
    if([riderCode isEqualToString:@"MDSR1"] ) {
    
        
        
        if(outletSegBottomLeft.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR1-ALW";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:planOption andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            insertSQL =[NSString stringWithFormat:
                        @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                        "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                        "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                        "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%d\", \"%@\", \"%d\", "
                        "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                        getSINo,@"MDSR1-ALW", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                        deductible, strDeductiblePostRetirement, inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , CurrentRiderPrem2 ,CurrentRiderPrem3 ,
                        txtRiderTerm.text, @"No", @"0", @"0", @"0", @"MDSR 1 Annual Limit Waiver", @"0", CurrentRiderLoadingPremium];
            
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR1-ALW", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                
                sqlite3_finalize(statement);

            }
            sqlite3_close(contactDB);
        }
        
        
        if(outletSegBottomRight.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR1-OT";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:planOption andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%d\", \"%@\", \"%d\", "
                         "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                         getSINo,@"MDSR1-OT", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                         deductible, strDeductiblePostRetirement, inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , CurrentRiderPrem2 ,CurrentRiderPrem3,
                         txtRiderTerm.text, @"No", @"0", @"0", @"0", @"Oversea Treatment for selected surgery", @"0", CurrentRiderLoadingPremium];
            
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR1-OT", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        riderCode = @"MDSR1";
        //[_delegate RiderAdded];
        
    }
    else if([riderCode isEqualToString:@"MDSR2"] ) {
        
        if(outletSegBottomLeft.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR2-ALW";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:planOption andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3,  "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%d\", \"%@\", \"%d\", "
                         "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                         getSINo,@"MDSR2-ALW", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                         deductible, strDeductiblePostRetirement, inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem , CurrentRiderPrem2 ,CurrentRiderPrem3,
                         txtRiderTerm.text, @"No", @"0", @"0", @"0", @"HSR 2 Annual Limit Waiver", @"0", CurrentRiderLoadingPremium];
            
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR2-ALW", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        
        
        
        if(outletSegBottomRight.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR2-OT";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:planOption andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%d\", \"%@\", \"%d\", "
                         "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                         getSINo,@"MDSR2-OT", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                         deductible, strDeductiblePostRetirement, inputHL1KSA, inputHL1KSATerm, inputHLPercentage, inputHLPercentageTerm, CurrentRiderPrem ,CurrentRiderPrem2 ,CurrentRiderPrem3,
                         txtRiderTerm.text, @"No", @"0", @"0", @"0", @"HSR 2 OT", @"0", CurrentRiderLoadingPremium];
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR2-OT", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        riderCode = @"MDSR2";
        //[_delegate RiderAdded];
    }
    else if([riderCode isEqualToString:@"LDYR"] ) {
        
        if(outletCheckBox1.selected == TRUE){
            riderCode = @"LDYR-PCB";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:[txtRRTUP.text doubleValue] andPaymentTerm:txtRRTUP.text andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text
                                  andHLP:txtHLP.text];
            
            
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", "
                         "\"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", \"%f\", \"%f\", \"%f\", "
                         "\"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                         getSINo,@"LDYR-PCB", pTypeCode, PTypeSeq, txtRiderTerm.text, txtRRTUP.text,
                         planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem ,CurrentRiderPrem2 ,CurrentRiderPrem3,
                         txtRiderTerm.text, @"No", @"0", @"0", @"0", @"LDYR PCB", @"0", 0.00];
            
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"LDYR-PCB", getSINo];
            
        }
        
        //NSLog(@"%@", insertSQL);
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        
        if(outletCheckBox2.selected == TRUE){
            riderCode = @"LDYR-BBB";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:45 - age andSA:[txtRRTUPTerm.text doubleValue] andPaymentTerm:txtRRTUPTerm.text andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:@""];
            
            insertSQL = [NSString stringWithFormat:
                         @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                         "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium,premium2, premium3, "
                         "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                         "(\"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                         "\"%f\", \"%f\", \"%f\", \"%d\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                         getSINo,@"LDYR-BBB", pTypeCode, PTypeSeq, 45 - age, txtRRTUPTerm.text, planOption,
                         deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem ,CurrentRiderPrem2 ,CurrentRiderPrem3,
                         1 , @"No", @"0", @"0", @"0", @"LDYR BBB", @"0", 0.00];
        }
        else{
            insertSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"LDYR-BBB", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        riderCode = @"LDYR";
        
        //[_delegate RiderAdded];
    }
	
    [_delegate RiderAdded];
    
    if (secondLARidCode.length != 0) {
       
    }
    
    [self CheckWaiverRiderPrem];
    [self getListingRiderByType];
    [self getListingRider];
	[self CalcTotalRiderPrem];
    
    
    //#save auto attached
    if (age < 60) {
    
        if([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"]) {
            
            //riderCode = @"MCFR";
            //planOption = @"";
            //FullRiderDesc = @"MediCare Funding Rider";
            //RRTUOFromYear = 0
            double forYears = 60 - age;//RRTUOYear
            double fullPremium = 0.0;//premium
            BOOL isMCFRExist = NO;
            for (int i = 0; i < LTypePremium.count; i++) {
                if ([[LRiderCode objectAtIndex:i] isEqualToString:@"MCFR"]) {
                    isMCFRExist = YES;
                }else{
                    fullPremium += [[LTypePremium objectAtIndex:i] doubleValue];
                    
                }
                
            }
            double percentagePremium = fullPremium * 0.20;
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:[NSString stringWithFormat:@"MediCare Funding Rider has been attached with additional annual premium of RM%.2f from 0 policy anniversary/1st year for %.0f years.",percentagePremium,forYears] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        
            if (isMCFRExist) {
                insertSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
                              @"UPDATE UL_Rider_Details SET RRTUOFromYear=\"%@\", RRTUOYear=\"%.2f\", PlanOption=\"%@\", "
                              "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
                              "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', PaymentChoice = '' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
                              "PTypeCode=\"%@\" AND Seq=\"%d\"", @"0", forYears, @"",
                              deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
                              inputHLPercentageTerm, [self ReturnReinvest], percentagePremium, @"MediCare Funding Rider", getSINo,
                              @"MCFR",pTypeCode, PTypeSeq];
                
            }else{
            
                insertSQL = [NSString stringWithFormat:
                             @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                             "PlanOption, Deductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, "
                             "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, paymentchoice, RiderLoadingPremium ) VALUES"
                             "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", "
                             "\"%.2f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%.2f\", '%@', '', '%f')",
                             getSINo,@"MCFR", pTypeCode, PTypeSeq, @"0", @"0", @"",
                             deductible, inputHL1KSA, inputHL1KSATerm, inputHLPercentage,
                             inputHLPercentageTerm, percentagePremium  , @"15", @"No",
                             @"0", txtRiderTerm.text,forYears, @"MediCare Funding Rider", CurrentRiderLoadingPremium];
            }
            
            
            
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        
                    }
                    
                    sqlite3_finalize(statement);
                    
                }
                sqlite3_close(contactDB);
            }
            
            [_delegate RiderAdded];
            
        }
            
        
        
    }
    

    
    
    [self getListingRiderByType];
    [self getListingRider];
    [self CalcTotalRiderPrem];
    //end auto attached
    
    if (inputSA > maxRiderSA) {
        NSLog(@"will delete %@",riderCode);
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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

-(void)ReturnOptionalBenefitPrem: (int)aaRiderCode
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    
    
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

-(void)ReturnCurrentRiderPrem: (int)WaiverRiderTerm ANDterm :(int)aaRiderTerm andSA :(double)aaRiderSA andPaymentTerm :(NSString *)aaPaymentTerm andRiderPlan :(NSString *)aaRiderPlan
                andRiderDeduc :(NSString *)aaRiderDeduc andGYIFrom :(NSString *)aaGYIFrom andTSRPaymentTerm :(NSString *)aaTSRPaymentTerm andTSRPaymentChoice :(NSString *)aaTSRPaymentChoice
                andHL :(NSString *)aaHL andHLP:(NSString *)aaHLP
{
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
		
	int ridTerm = 0;
    
    if (WaiverRiderTerm > 0 ) {
        ridTerm = aaRiderTerm;
    }
    else{ 
        ridTerm = [txtRiderTerm.text intValue] == 0 ? aaRiderTerm : [txtRiderTerm.text intValue];
    }
    
	age = pTypeAge;
	
	if ([SimpleOrDetail isEqualToString:@"Simple"]) {
		sex = getSex;
	}
	else{
		if ([pTypeCode isEqual:@"LA"] && PTypeSeq == 2) {
			sex = pTypeSex;
		}
		else if ([pTypeCode isEqual:@"PY"]) {
			sex = pTypeSex;
		}
		else{
			sex = getSex;
		}
	}
	
		
		
	//NSLog(@"dasdas  %@ %@ %@ %d", pTypeSex, getSex, pTypeCode, PTypeSeq);
	
	sex = [sex substringToIndex:1];
	if ([riderCode isEqualToString:@"BLIFECIAC"])
	{
        [self getPrem:@"BLIFE_CI_ACC" Query:[NSString stringWithFormat:@"Select MS, MNS, FS, FNS From BLIFE_CI_ACC where term = '%d' and age = '%d' ",  ridTerm, age]];
	}
    else if ([riderCode isEqualToString:@"BLIFECIAD"])
	{
        [self getPrem:@"BLIFE_CI_Add" Query:[NSString stringWithFormat:@"Select MS, MNS, FS, FNS From BLIFE_CI_Add where term = '%d' and age = '%d' ",  ridTerm, age]];
	}
    else if ([riderCode isEqualToString:@"BLIFEPAA1"])
	{
        [self getPrem:@"BLIFE_PA_Death" Query:[NSString stringWithFormat:@"Select premi From BLIFE_PA_Death where term = '%d' and class = '1' ",  ridTerm]];
	}
    else if ([riderCode isEqualToString:@"BLIFEPAAB"])
	{
        [self getPrem:@"BLIFE_PA_Death_Disable" Query:[NSString stringWithFormat:@"Select premi From BLIFE_PA_Death_Disable where term = '%d' and class = '1' ",  ridTerm]];
	}
    else if ([riderCode isEqualToString:@"BLIFEWVRT1"])
	{
        [self getPrem:@"BLIFE_Hospital_CashPlan" Query:[NSString stringWithFormat:@"Select Rupiah From BLIFE_Hospital_CashPlan where term = '%d' and age = '%d' ",  ridTerm, age]];
	}
    else if ([riderCode isEqualToString:@"BLIFEHNS1"])
	{
        if ([sex isEqualToString:@"MALE"]) {
                [self getPrem:@"BLIFE_Hosp_Sur_Male" Query:[NSString stringWithFormat:@"Select * From BLIFE_Hosp_Sur_Male where term = '%d' and age = '%d' ",  ridTerm, age]];
        }
        else{
                [self getPrem:@"BLIFE_Hosp_Sur_Female" Query:[NSString stringWithFormat:@"Select * From BLIFE_Hosp_Sur_Female where term = '%d' and age = '%d' ",  ridTerm, age]];
        }
	}
    else{
		riderRate = 0.00;
	}
	
	//double ridSA = [txtSumAssured.text doubleValue];
	double ridSA = aaRiderSA;
	double riderHLoad = 0;
	double riderHLoadPct = 0;
	//double riderHLoadPct = 0;
	
	if ([aaHL doubleValue] > 0 ) {
		riderHLoad = [aaHL doubleValue];
	}
	
	if ([aaHLP doubleValue] > 0 ) {
		riderHLoadPct = [aaHLP doubleValue];
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
	double _RiderLoadingPremiumAnn = 0.00;
	double _RiderLoadingPremiumHalf = 0.00;
	double _RiderLoadingPremiumQuar = 0.00;
	double _RiderLoadingPremiumMonth = 0.00;
    
    double _ann2 = 0.00;
	double _half2 =0.00;
	double _quar2 = 0.00;
	double _month2 =0.00;

	double _RiderLoadingPremiumAnn2 = 0.00;
	double _RiderLoadingPremiumHalf2 = 0.00;
	double _RiderLoadingPremiumQuar2 = 0.00;
	double _RiderLoadingPremiumMonth2 = 0.00;
    
    double _ann3 = 0.00;
	double _half3 =0.00;
	double _quar3 = 0.00;
	double _month3 =0.00;

	double _RiderLoadingPremiumAnn3 = 0.00;
	double _RiderLoadingPremiumHalf3 = 0.00;
	double _RiderLoadingPremiumQuar3 = 0.00;
	double _RiderLoadingPremiumMonth3 = 0.00;
	
	
    if ([riderCode isEqualToString:@"BLIFECIAC"] || [riderCode isEqualToString:@"BLIFECIAD"] || [riderCode isEqualToString:@"BLIFEPAA1"] || [riderCode isEqualToString:@"BLIFEPAAB"])
	{
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
    else if ([riderCode isEqualToString:@"BLIFEWVRT1"])
	{
        _ann = 0.00;
        _half =0.00;
        _quar = 0.00;
        _month =0.00;
        double RiderPremium = 0.00;
        double RiderHLPremium = 0.00;
        
        if (riderHLoad == 0 && riderHLoadPct == 0 ) {
            RiderPremium = (riderRate * [txtReinvestment.text intValue]) / annFac;
        }
        else{
            RiderPremium = (riderRate * [txtReinvestment.text intValue]) / annFac;
            
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
    else if ([riderCode isEqualToString:@"BLIFEHNS1"])
	{
        _ann = 0.00;
        _half =0.00;
        _quar = 0.00;
        _month =0.00;
        double RiderPremium = 0.00;
        double RiderHLPremium = 0.00;
        
        if (riderHLoad == 0 && riderHLoadPct == 0 ) {
            RiderPremium = (riderRate * 1000.00) / annFac;
        }
        else{
            RiderPremium = (riderRate * 1000.00) / annFac;
            
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
    else if ([riderCode isEqualToString:@"RRTUO"]   ){
        _ann = 0.00;
        _half =0.00;
        _quar = 0.00;
        _month =0.00;
        
        _ann = riderRate ;
        _half = _ann *halfFac;
        _quar = _ann * quarterFac;
        _month = _ann * monthFac;
        
    }
    else{
        double RiderPremium = random()/1000.00;
        double RiderHLPremium = 0.00;
        
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
        CurrentRiderLoadingPremium = _RiderLoadingPremiumAnn;
        CurrentRiderPrem2 = _ann2;
        CurrentRiderLoadingPremium2 = _RiderLoadingPremiumAnn2;
        CurrentRiderPrem3 = _ann3;
        CurrentRiderLoadingPremium3 = _RiderLoadingPremiumAnn3;
    }
    else if([getBUMPMode isEqualToString:@"S"]){
        //CurrentRiderPrem = halfYearRider;
        CurrentRiderPrem = _half;
        CurrentRiderLoadingPremium = _RiderLoadingPremiumHalf;
        CurrentRiderPrem2 = _half2;
        CurrentRiderLoadingPremium2 = _RiderLoadingPremiumHalf2;
        CurrentRiderPrem3 = _half3;
        CurrentRiderLoadingPremium3 = _RiderLoadingPremiumHalf3;
    }
    else if([getBUMPMode isEqualToString:@"Q"]){
        //CurrentRiderPrem =quarterRider;
        CurrentRiderPrem = _quar;
        CurrentRiderLoadingPremium = _RiderLoadingPremiumQuar;
        CurrentRiderPrem2 = _quar2;
        CurrentRiderLoadingPremium2 = _RiderLoadingPremiumQuar2;
        CurrentRiderPrem3 = _quar3;
        CurrentRiderLoadingPremium3 = _RiderLoadingPremiumQuar3;
    }
    else{
        //CurrentRiderPrem =monthlyRider;
        CurrentRiderPrem = _month;
        CurrentRiderLoadingPremium = _RiderLoadingPremiumMonth;
        CurrentRiderPrem2 = _month2;
        CurrentRiderLoadingPremium2 = _RiderLoadingPremiumMonth2;
        CurrentRiderPrem3 = _month3;
        CurrentRiderLoadingPremium3 = _RiderLoadingPremiumMonth3;
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
        else if ([aaType isEqualToString:@"HMM_1000"]) {
			Type = @"MM1000";
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
		
		ReportHMMRates = [[NSMutableArray alloc] init ];
		ReportFromAge = [[NSMutableArray alloc] init ];
		ReportToAge = [[NSMutableArray alloc] init ];
		querySQL = [NSString stringWithFormat:
					@"SELECT Rate, \"FromAge\", \"ToAge\" FROM ES_Sys_Rider_Prem WHERE PlanCode=\"%@\" AND "
					" Sex=\"%@\" AND occClass = \"%d\" AND Type = '%@' AND Deductible = '%@' AND FromAge >= '%d' ORDER BY fromage",
					aaplan,sex, getOccpClass, Type, aaDeduc, age];
		
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
				[ReportHMMRates addObject:[NSString stringWithFormat:@"%.3f", sqlite3_column_double(statement, 0)]];
				[ReportFromAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)]];
				[ReportToAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 2)]];
			}
			sqlite3_finalize(statement);
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
		else if ([aaType isEqualToString:@"MGIVP_300"]) {
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
			
			ReportHMMRates = [[NSMutableArray alloc] init ];
			ReportFromAge = [[NSMutableArray alloc] init ];
			ReportToAge = [[NSMutableArray alloc] init ];
			querySQL = [NSString stringWithFormat:
						@"SELECT Rate, \"FromAge\", \"ToAge\" FROM ES_Sys_Rider_Prem WHERE PlanCode=\"%@\" AND "
						" Sex=\"%@\" AND occClass = \"%d\" AND Type = '%@' AND FromAge >= '%d' ORDER BY fromage",
						aaplan,sex, getOccpClass, Type, age];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				while (sqlite3_step(statement) == SQLITE_ROW)
				{
					[ReportHMMRates addObject:[NSString stringWithFormat:@"%.3f", sqlite3_column_double(statement, 0)]];
					[ReportFromAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)]];
					[ReportToAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 2)]];
				}
				sqlite3_finalize(statement);
			}
			
			
			
			sqlite3_close(contactDB);
			
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

-(void)getTSRPrem:(int)aaAge PPTerm:(int)aaPPTerm Term:(int)aaTerm LimitedOrFullPay:(NSString *)aaLimitedOrFullPay Gender:(NSString *)aaGender {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
        if ([aaLimitedOrFullPay isEqualToString:@"Limited"]) {
            querySQL = [NSString stringWithFormat:@"SELECT prem FROM ES_TSR_Prem_LimitedPay WHERE RiderTerm = '%d' AND Age = '%d' AND PremiumPayingTerm ='%d' and gender = '%@'", aaTerm, aaAge, aaPPTerm, aaGender ];
        }
        else{
            querySQL = [NSString stringWithFormat:@"SELECT prem FROM ES_TSR_Prem_FullPay WHERE RiderTerm = '%d' AND Age = '%d' AND PremiumPayingTerm ='%d' and gender = '%@'", aaTerm, aaAge, aaPPTerm, aaGender ];
        }
		
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_TSR_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getTSERPrem:(int)aaAge PPTerm:(int)aaPPTerm Term:(int)aaTerm Gender:(NSString *)aaGender {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
            querySQL = [NSString stringWithFormat:@"SELECT prem FROM ES_TSER_Prem WHERE RiderTerm = '%d' AND Age = '%d' AND PremiumPayingTerm ='%d' and gender = '%@'", aaTerm, aaAge , aaPPTerm, aaGender];

		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_TSER_Prem");
            }
            sqlite3_finalize(statement);
        }


        sqlite3_close(contactDB);
    }

}

-(void)getTSROccScale:(int)aaAge PPTerm:(int)aaPPTerm Term:(int)aaTerm  {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
        querySQL = [NSString stringWithFormat:@"SELECT rate FROM ES_TSR_OccScale_LimitedPay WHERE RiderTerm = '%d' AND Age = '%d' AND PremiumPayingTerm ='%d' ", aaTerm, aaAge , aaPPTerm];
        
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                OccScale =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_TSR_OccScale");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getTSEROccScale:(int)aaAge PPTerm:(int)aaPPTerm Term:(int)aaTerm  {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {	NSString *querySQL;
		
        querySQL = [NSString stringWithFormat:@"SELECT rate FROM ES_TSER_OccScale WHERE RiderTerm = '%d' AND Age = '%d' AND PremiumPayingTerm ='%d' ", aaTerm, aaAge , aaPPTerm];
        
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                OccScale =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access ES_TSER_OccScale");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getPrem:(NSString *)aaridercode Query:(NSString *)aaQuery {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [aaQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                /*
                if ([aaridercode isEqualToString:@"LDYR-BBB"]) {
                    LDYRBBB_Rate = sqlite3_column_double(statement, 0);
                }
                else if ([aaridercode isEqualToString:@"LDYR-PCB"]) {
                    LDYRPCB_Rate = sqlite3_column_double(statement, 0);
                }
                else{
                    riderRate =  sqlite3_column_double(statement, 0);
                }
                 */
                if ([riderCode isEqualToString:@"BLIFEHNS1"]) {
                    if ([txtSumAssured.text isEqualToString:@"200000"]  ) {
                        riderRate =  sqlite3_column_double(statement, 1);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"350000"]) {
                        riderRate =  sqlite3_column_double(statement, 2);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"500000"]) {
                        riderRate =  sqlite3_column_double(statement, 3);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"750000"]) {
                        riderRate =  sqlite3_column_double(statement, 4);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"1000000"]) {
                        riderRate =  sqlite3_column_double(statement, 5);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"1500000"]) {
                        riderRate =  sqlite3_column_double(statement, 6);
                    }
                    else if ([txtSumAssured.text isEqualToString:@"2000000"]) {
                        riderRate =  sqlite3_column_double(statement, 7);
                    }
                    else  {
                        riderRate =  sqlite3_column_double(statement, 8);
                    }
                }
                else{
                    if ([sex isEqualToString:@"M"] && [getSmoker isEqualToString:@"Y"] ) {
                        riderRate =  sqlite3_column_double(statement, 0);
                    }
                    else if ([sex isEqualToString:@"M"] && [getSmoker isEqualToString:@"N"] ) {
                        riderRate =  sqlite3_column_double(statement, 1);
                    }
                    else if ([sex isEqualToString:@"F"] && [getSmoker isEqualToString:@"Y"] ) {
                        riderRate =  sqlite3_column_double(statement, 2);
                    }
                    else  {
                        riderRate =  sqlite3_column_double(statement, 3);
                    }
                }
                
                
                
                
            } else {
                NSLog(@"error access  ");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void)getPrem2:(NSString *)tablename Query:(NSString *)aaQuery {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [aaQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate2 =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access  ");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void)getPrem3:(NSString *)tablename Query:(NSString *)aaQuery {
	sqlite3_stmt *statement;
    if (sqlite3_open([UL_RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		//NSLog(@"%@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [aaQuery UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate3 =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"error access  ");
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
    NSString *updatetSQL;
	
	[self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:[txtSumAssured.text doubleValue] andPaymentTerm:txtPaymentTerm.text andRiderPlan:outletRiderPlan.titleLabel.text andRiderDeduc:outletDeductible.titleLabel.text andGYIFrom:txtGYIFrom.text andTSRPaymentTerm:txtReinvestment.text andTSRPaymentChoice:outletRiderPlan.titleLabel.text andHL:txtHL.text andHLP:txtHLP.text ];
    //sqlite3_stmt *statement;
	
	NSString *FullRiderDesc = [self ReturnRiderDesc:riderCode];
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        
		
		if ([riderCode isEqualToString:@"RRTUO"] || [riderCode isEqualToString:@"MCFR"] ) {
			updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
						  @"UPDATE UL_Rider_Details SET RRTUOFromYear=\"%@\", RRTUOYear=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', PaymentChoice = '' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\"", txtRiderTerm.text, txtPaymentTerm.text, planOption,
						  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc, getSINo,
						  riderCode,pTypeCode, PTypeSeq];
		}
        else if ([riderCode isEqualToString:@"TSR"]) {
			updatetSQL = [NSString stringWithFormat:
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', "
						  "paymentTerm ='%@',  RiderLoadingPremium = '%f', PaymentChoice = '%@' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\" ", txtRiderTerm.text, txtSumAssured.text, @"",
						  deductible,  inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc,
                          txtReinvestment.text, CurrentRiderLoadingPremium, outletRiderPlan.titleLabel.text, getSINo,
						  riderCode,pTypeCode, PTypeSeq];


		}
        else if ([riderCode isEqualToString:@"MDSR1"] || [riderCode isEqualToString:@"MDSR2"] ) {
			updatetSQL = [NSString stringWithFormat:
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", PlanOption=\"%@\", "
						  "PreDeductible=\"%@\",  PostDeductible = '%@', HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', "
						  "paymentTerm ='%@',  RiderLoadingPremium = '%f', Premium2 = '%.2f', Premium3 = '%.2f' WHERE SINo=\"%@\" AND RiderCode=\"%@\" ", txtRiderTerm.text, planOption,
						  deductible, strDeductiblePostRetirement, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc,
                          txtRiderTerm.text, CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3, getSINo, riderCode];
            
            
		}
        else if ([riderCode isEqualToString:@"HCIR"] ) {
			updatetSQL = [NSString stringWithFormat:
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", PlanOption=\"%@\", "
						  "PreDeductible=\"%@\",  PostDeductible = '%@', HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', "
						  "paymentTerm ='%@',  RiderLoadingPremium = '%f', Premium2 = '%.2f', Premium3 = '%.2f', units = '%d' WHERE SINo=\"%@\" AND RiderCode=\"%@\" ",
                          txtRiderTerm.text, @"", @"", @"", @"0", 0,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc,
                          txtRiderTerm.text, CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3, [txtPaymentTerm.text intValue], getSINo, riderCode];
            
            
		}
        else if ([riderCode isEqualToString:@"TCCR"] || [riderCode isEqualToString:@"CCR"] || [riderCode isEqualToString:@"JCCR"] || [riderCode isEqualToString:@"LDYR"] || [riderCode isEqualToString:@"MSR"]   ){
			updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', "
						  "paymentTerm ='%@',  RiderLoadingPremium = '%f', PaymentChoice = '', Premium2 = '%.2f', Premium3 = '%.2f' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\" ", txtRiderTerm.text, txtSumAssured.text, planOption,
						  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc,
						  txtPaymentTerm.text, CurrentRiderLoadingPremium, CurrentRiderPrem2, CurrentRiderPrem3, getSINo,
						  riderCode,pTypeCode, PTypeSeq];
		}
		else{
			updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
						  @"UPDATE UL_Rider_Details SET RiderTerm=\"%@\", SumAssured=\"%@\", PlanOption=\"%@\", "
						  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
						  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', "
						  "paymentTerm ='%@',  RiderLoadingPremium = '%f', PaymentChoice = '' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
						  "PTypeCode=\"%@\" AND Seq=\"%d\" ", txtRiderTerm.text, txtSumAssured.text, planOption,
						  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
						  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc,
						  txtPaymentTerm.text, CurrentRiderLoadingPremium, getSINo,
						  riderCode,pTypeCode, PTypeSeq];
		}
		
        if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
			    
            }
            
            sqlite3_finalize(statement);
            
        }
        
        
        sqlite3_close(contactDB);
    }
    
    if([riderCode isEqualToString:@"MDSR1"] ) {
        
        if(outletSegBottomLeft.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR1-ALW";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:planOption andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            if ([LTypeRiderCode indexOfObject:@"MDSR1-ALW"] == NSNotFound) {
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"MDSR1-ALW", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem , CurrentRiderPrem2 , CurrentRiderPrem3 ,
                              txtRiderTerm.text, @"No", @"0", @"0", @"0", @"- Annual Limit Waiver", @"0", CurrentRiderLoadingPremium];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%@' WHERE sino = '%@' AND ridercode = '%@'",
                              CurrentRiderPrem, CurrentRiderPrem2, CurrentRiderPrem3, planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderLoadingPremium,
                              txtRiderTerm.text, getSINo, @"MDSR1-ALW" ];
            }
            
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR1-ALW", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        
        
        if(outletSegBottomRight.selectedSegmentIndex == 0){
            //#autoMedi
            riderCode = @"MDSR1-OT";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            if ([LTypeRiderCode indexOfObject:@"MDSR1-OT"] == NSNotFound) {
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES "
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\", \"%f\", \"%f\",  \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"MDSR1-OT", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem , CurrentRiderPrem2 , CurrentRiderPrem3 ,
                              txtRiderTerm.text, @"No", @"0", @"0", @"0", @"- Oversea Treatment for selected surgery", @"0", CurrentRiderLoadingPremium];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', "
                              "HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%@' WHERE sino = '%@' AND ridercode = '%@'",
                              CurrentRiderPrem,CurrentRiderPrem2,CurrentRiderPrem3, planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderLoadingPremium,
                              txtRiderTerm.text, getSINo, @"MDSR1-OT" ];
            }
            
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR1-OT", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                   
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
         riderCode = @"MDSR1";
        
        [_delegate RiderAdded];
        
    }
    else if([riderCode isEqualToString:@"MDSR2"] ) {
        
        if(outletSegBottomLeft.selectedSegmentIndex == 0){
                
            riderCode = @"MDSR2-ALW";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            if ([LTypeRiderCode indexOfObject:@"MDSR2-ALW"] == NSNotFound) {
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"MDSR2-ALW", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem , CurrentRiderPrem2, CurrentRiderPrem3,
                              txtRiderTerm.text, @"No", @"0", @"0", @"0", @"- Annual Limit Waiver", @"0", CurrentRiderLoadingPremium];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', "
                              "HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%@' WHERE sino = '%@' AND ridercode = '%@'",
                              CurrentRiderPrem, CurrentRiderPrem2, CurrentRiderPrem3, planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderLoadingPremium,
                              txtRiderTerm.text, getSINo, @"MDSR2-ALW" ];
            }
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR2-ALW", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        if(outletSegBottomRight.selectedSegmentIndex == 0){
            
            riderCode = @"MDSR2-OT";            
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:0 andPaymentTerm:@"0" andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:txtHLP.text];
            
            
            if ([LTypeRiderCode indexOfObject:@"MDSR2-OT"] == NSNotFound) {
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium, premium2, premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\", \"%f\", \"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"MDSR2-OT", pTypeCode, PTypeSeq, txtRiderTerm.text, @"0", planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem , CurrentRiderPrem2 , CurrentRiderPrem3 ,
                              txtRiderTerm.text, @"No", @"0", @"0", @"0", @"- Oversea Treatment for selected surgery", @"0", CurrentRiderLoadingPremium];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', "
                              "HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%@' WHERE sino = '%@' AND ridercode = '%@'",
                              CurrentRiderPrem, CurrentRiderPrem2, CurrentRiderPrem3, planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderLoadingPremium,
                              txtRiderTerm.text, getSINo, @"MDSR2-OT " ];
            }
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"MDSR2-OT", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
             
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        riderCode = @"MDSR2";
        
        [_delegate RiderAdded];
    
    }
    else if([riderCode isEqualToString:@"LDYR"] ) {

        if(outletCheckBox1.selected == TRUE){
            riderCode = @"LDYR-PCB";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:[txtRiderTerm.text integerValue] andSA:[txtRRTUP.text doubleValue] andPaymentTerm:txtRRTUP.text andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text
                                  andHLP:txtHLP.text];
            
            if ([LTypeRiderCode indexOfObject:@"LDYR-PCB"] == NSNotFound) {
                
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium,premium2,premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\",\"%f\",\"%f\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"LDYR-PCB", pTypeCode, PTypeSeq, txtRiderTerm.text, txtRRTUP.text, planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem ,CurrentRiderPrem2 ,CurrentRiderPrem3 ,
                              txtRiderTerm.text, @"No", @"0", @"0", @"0", @" - Pregnancy Care Benefit", @"0", 0.00];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET SumAssured = '%@', premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', "
                              "HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%@' WHERE sino = '%@' AND ridercode = '%@'",
                              txtRRTUP.text, CurrentRiderPrem,CurrentRiderPrem2,CurrentRiderPrem3, planOption, deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderLoadingPremium,
                              txtRiderTerm.text, getSINo, @"LDYR-PCB" ];
            }
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"LDYR-PCB", getSINo];
            
        }
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);

        }
        
        
        
        if(outletCheckBox2.selected == TRUE){
            riderCode = @"LDYR-BBB";
            
            [self ReturnCurrentRiderPrem:0 ANDterm:45 - age andSA:[txtRRTUPTerm.text doubleValue] andPaymentTerm:txtRRTUPTerm.text andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"" andTSRPaymentTerm:@"" andTSRPaymentChoice:@"" andHL:txtHL.text andHLP:@""];
            
            if ([LTypeRiderCode indexOfObject:@"LDYR-BBB"] == NSNotFound) {
                
                
                updatetSQL = [NSString stringWithFormat:
                              @"INSERT INTO UL_Rider_Details (SINo,  RiderCode, PTypeCode, Seq, RiderTerm, SumAssured, "
                              "PlanOption, PreDeductible, PostDeductible, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, premium,premium2,premium3, "
                              "paymentTerm, ReinvestGYI, GYIYear, RRTUOFromYear, RRTUOYear, RiderDesc, PaymentChoice, RiderLoadingPremium) VALUES"
                              "(\"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", "
                              "\"%f\",\"%f\",\"%f\", \"%d\", \"%@\", \"%@\",\"%@\",\"%@\", '%@', '%@', '%f');",
                              getSINo,@"LDYR-BBB", pTypeCode, PTypeSeq, 45 - age, txtRRTUPTerm.text, planOption,
                              deductible, strDeductiblePostRetirement, txtHL.text, txtHLTerm.text, txtHLP.text, txtHLPTerm.text, CurrentRiderPrem , CurrentRiderPrem2, CurrentRiderPrem3,
                              1, @"No", @"0", @"0", @"0", @"- Baby Bonus Benefit", @"0", 0.00];
            }
            else{
                updatetSQL = [NSString stringWithFormat:
                              @"UPDATE UL_Rider_Details SET SumAssured = '%@',  premium = '%f', premium2 = '%f', premium3 = '%f', PlanOption = '%@', PreDeductible = '%@', PostDeductible = '%@', HLoading = '%@', HLoadingTerm = '%@', "
                              "HLoadingPct = '%@', HLoadingPctTerm = '%@', RiderLoadingPremium = '%f',  paymentTerm = '%d', RiderTerm = '%d' WHERE sino = '%@' AND ridercode = '%@'",
                              txtRRTUPTerm.text, CurrentRiderPrem, CurrentRiderPrem2, CurrentRiderPrem3,  planOption, deductible, strDeductiblePostRetirement, @"", @"", @"", @"", 0.00,
                              1, 45 - age, getSINo, @"LDYR-BBB" ];
            }
        }
        else{
            updatetSQL = [NSString stringWithFormat:@"Delete From UL_Rider_Details Where ridercode ='%@' AND sino = '%@' ", @"LDYR-BBB", getSINo];
            
        }
        
        riderCode = @"LDYR";
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
            
        [_delegate RiderAdded];        
    }
    

	
    [self CheckWaiverRiderPrem];
    [self validateRules];
	[self CalcTotalRiderPrem];
    
    
    //update auto attached
    if (age < 60 && ![riderCode isEqualToString:@"MCFR"]) {
        
        //riderCode = @"MCFR";
        //planOption = @"";
        //FullRiderDesc = @"MediCare Funding Rider";
        //RRTUOFromYear = 0
        double forYears = 60 - age;//RRTUOYear
        double fullPremium = 0.0;//premium
        BOOL isMCFRExist = NO;
        for (int i = 0; i < LTypePremium.count; i++) {
            if ([[LRiderCode objectAtIndex:i] isEqualToString:@"MCFR"]) {
                isMCFRExist = YES;
            }else{
                fullPremium += [[LTypePremium objectAtIndex:i] doubleValue];
                
            }
            
        }
        double percentagePremium = fullPremium * 0.20;
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:[NSString stringWithFormat:@"MediCare Funding Rider has been attached with additional annual premium of RM%.2f from 0 policy anniversary/1st year for %.0f years.",percentagePremium,forYears] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        updatetSQL = [NSString stringWithFormat: //changes in inputHLPercentageTerm by heng
                      @"UPDATE UL_Rider_Details SET RRTUOFromYear=\"%@\", RRTUOYear=\"%.2f\", PlanOption=\"%@\", "
                      "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
                      "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%.2f', RiderDesc = '%@', PaymentChoice = '' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
                      "PTypeCode=\"%@\" AND Seq=\"%d\"", @"0", forYears, @"",
                      deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
                      inputHLPercentageTerm, [self ReturnReinvest], percentagePremium, @"MediCare Funding Rider", getSINo,
                      @"MCFR",pTypeCode, PTypeSeq];
        
        
        
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                
                sqlite3_finalize(statement);
                
            }
            sqlite3_close(contactDB);
        }
        
        
        
        
        
    }
    
    
    [self getListingRiderByType];
    [self getListingRider];
    [self CalcTotalRiderPrem];
    //end update auto attached
	
	
}

-(void)updateAllRiders
{
	sqlite3_stmt *statement;
	NSString *FullRiderDesc;
	NSString *updatetSQL;
	
	for (int i = 0; i < LRiderCode.count; i++) {
		riderCode = [LRiderCode objectAtIndex:i];
		
		
		[self ReturnCurrentRiderPrem:0 ANDterm:[[LTerm objectAtIndex:i] integerValue] andSA:[[LSumAssured objectAtIndex:i] doubleValue] andPaymentTerm:[LPaymentTerm objectAtIndex:i ]
                        andRiderPlan:[LPlanOpt objectAtIndex:i] andRiderDeduc:[LDeduct objectAtIndex:i] andGYIFrom:[LGYIYear objectAtIndex:i] andTSRPaymentTerm:[LPaymentTerm objectAtIndex:i]
                        andTSRPaymentChoice:[LPaymentChoice objectAtIndex:i] andHL:[LRidHL1K objectAtIndex:i] andHLP:[LRidHLP objectAtIndex:i]];
		
		FullRiderDesc = [self ReturnRiderDesc:riderCode];
		
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		{
			
			if ([riderCode isEqualToString:@"RRTUO"] || [riderCode isEqualToString:@"MCFR"]) {
				updatetSQL = [NSString stringWithFormat:
							  @"UPDATE UL_Rider_Details SET RRTUOFromYear=\"%@\", RRTUOYear=\"%@\", PlanOption=\"%@\", "
							  "Deductible=\"%@\", HLoading=\"%@\", HLoadingTerm=\"%d\", "
							  "HLoadingPct=\"%@\", HLoadingPctTerm=\"%d\", ReinvestGYI = '%@', premium ='%f', RiderDesc = '%@' WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND "
							  "PTypeCode=\"%@\" AND Seq=\"%d\"", txtRiderTerm.text, txtPaymentTerm.text, planOption,
							  deductible, inputHL1KSA, inputHL1KSATerm,inputHLPercentage,
							  inputHLPercentageTerm, [self ReturnReinvest], CurrentRiderPrem, FullRiderDesc, getSINo,
							  riderCode,pTypeCode, PTypeSeq];
			}
			else{
				updatetSQL = [NSString stringWithFormat:
							  @"UPDATE UL_Rider_Details SET premium ='%f' WHERE SINo=\"%@\" AND RiderCode=\"%@\" ",
							  CurrentRiderPrem,  getSINo, riderCode];
			}
			
			if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_DONE)
				{
					//[self CheckWaiverRiderPrem];
					//[self validateRules];
					
				}
				sqlite3_finalize(statement);
			}
			sqlite3_close(contactDB);
		}
		

	}
    
    [self CheckWaiverRiderPrem];
	
	
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
	double half = 0.5, quarter = 0.25, month = 0.0833333;
    double SumAssured = 0.00;
    NSUInteger index = [LTypeRiderCode indexOfObject:@"CIWP"];
    
		if (index != NSNotFound) {
			
			riderCode = @"CIWP";
			RiderTerm = [[LTypeTerm objectAtIndex:index] intValue];
            SumAssured = [[LTypeSumAssured objectAtIndex:index] doubleValue];
			[self ReturnCurrentRiderPrem:RiderTerm ANDterm:RiderTerm andSA:SumAssured andPaymentTerm:[LPaymentTerm objectAtIndex:index]
             andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"0" andTSRPaymentTerm:@"0" andTSRPaymentChoice:@"" andHL:[LRidHL1K objectAtIndex:index] andHLP:[LRidHLP objectAtIndex:index]];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			 {
				 querySQL = [NSString stringWithFormat:
							 @"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							 "where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ACIR', 'RRTUO', 'CCR', 'TCCR', 'JCCR', 'LDYR', 'LDYR-BBB', 'LDYR-PCB') "
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
			[self ReturnCurrentRiderPrem:RiderTerm ANDterm:RiderTerm andSA:[[LTypeSumAssured objectAtIndex:index] doubleValue] andPaymentTerm:[LPaymentTerm objectAtIndex:index]
             andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"0" andTSRPaymentTerm:@"0" andTSRPaymentChoice:@"" andHL:[LRidHL1K objectAtIndex:index] andHLP:[LRidHLP objectAtIndex:index]];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			{
				querySQL = [NSString stringWithFormat:
							@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'RRTUO', 'LDYR-BBB', 'LDYR-PCB') "
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
            SumAssured = [[LTypeSumAssured objectAtIndex:index] doubleValue];
			[self ReturnCurrentRiderPrem:RiderTerm ANDterm:RiderTerm andSA:SumAssured andPaymentTerm:[LTypePaymentTerm objectAtIndex:index]
             andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"0" andTSRPaymentTerm:@"0" andTSRPaymentChoice:@"" andHL:[LTypeRidHL1K objectAtIndex:index] andHLP:[LTypeRidHLP objectAtIndex:index]];
			
			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
				querySQL = [NSString stringWithFormat:
							@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
							"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'RRTUO', 'LDYR-BBB', 'LDYR-PCB') "
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
        SumAssured = [[LTypeSumAssured objectAtIndex:index] doubleValue];
		[self ReturnCurrentRiderPrem:RiderTerm ANDterm:RiderTerm andSA:SumAssured andPaymentTerm:[LPaymentTerm objectAtIndex:index]
         andRiderPlan:@"" andRiderDeduc:@"" andGYIFrom:@"0" andTSRPaymentTerm:@"0" andTSRPaymentChoice:@"" andHL:[LRidHL1K objectAtIndex:index] andHLP:[LRidHLP objectAtIndex:index]];
		
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			querySQL = [NSString stringWithFormat:
						@"SELECT sum(round(premium,2)) from( SELECT premium FROM ul_rider_details "
						"where sino = '%@' and ridercode not in('CIWP', 'LCWP', 'PR', 'TPDWP', 'ECAR','ECAR6', 'ECAR60', 'LSR', 'TPDMLA', 'PA', 'TPDYLA', 'TSR', 'TSER', 'RRTUO', 'LDYR-BBB', 'LDYR-PCB' ) "
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
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
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
	else{

        if(_RiderList == Nil){
            self.RiderList = [[RiderListTbViewController alloc] initWithStyle:UITableViewStylePlain];
            _RiderList.delegate = self;
            _RiderList.TradOrEver = @"EVER";
            _RiderList.requestPtype = self.pTypeCode;
            _RiderList.requestPlan = getPlanCode;
            _RiderList.requestSeq = self.PTypeSeq;
            _RiderList.requestOccpClass = getOccpClass;
            _RiderList.requestAge = self.pTypeAge;
            _RiderList.requestOccpCat = self.OccpCat; //EMP
            _RiderList.requestOccpCPA = getOccpCPA;
            _RiderList.requestLASex = requestSex;
            _RiderList.requestOccpCode = getOccpCode;
            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            //#EDD
            
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"SELECT OtherIDType FROM prospect_profile WHERE IndexNo=%i",zzz.ProspectListingIndex];
                
                NSLog(@"%@", querySQL);
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    while(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSString *tmpValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                        if ([tmpValue isEqualToString:@"EDD"]) {
                            _RiderList.requestEDD = YES;
                        }
                    }
                    sqlite3_finalize(statement);
                }
                sqlite3_close(contactDB);
            }
            //end
            
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
            
		}
        
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
- (IBAction)ActionSegBottomLeft:(id)sender {
}

- (IBAction)ActionSegBottomRight:(id)sender {
}

- (IBAction)ActionOccLoading:(id)sender {
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];

    NSString *str;
    if (outletDeductible.enabled == FALSE) {
        str = @"50000";
    }
    else{
        str = outletDeductible.titleLabel.text;
    }
    
    
    self.deductPostRetirement = [[DeductiblePostRetirement alloc] initWithString:str andSumAss:@"" andOption:@""];
    _deductPostRetirement.delegate = self;
    self.deducRetirementPopover = [[UIPopoverController alloc] initWithContentViewController:_deductPostRetirement];
    
    [self.deducRetirementPopover setPopoverContentSize:CGSizeMake(350.0f, 250.0f)];
	
	CGRect dadas = [sender frame ];
	dadas.origin.y = dadas.origin.y + 25;
    [self.deducRetirementPopover presentPopoverFromRect:dadas inView:self.view
					 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)ActionCheckBox1:(id)sender {
    if ([txtSumAssured.text isEqualToString:@""]) {
        NSString *msg = @"Rider Sum Assured is required.";
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
        
        [txtSumAssured becomeFirstResponder];
    }
    else{
        outletCheckBox1.selected = !outletCheckBox1.selected;
        if (outletCheckBox1.selected == TRUE) {
            [outletCheckBox1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            txtRRTUP.enabled = TRUE;
            txtRRTUP.backgroundColor = [UIColor whiteColor];
            [txtRRTUP becomeFirstResponder];
            
        }
        else{
            [outletCheckBox1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            txtRRTUP.enabled = FALSE;
            txtRRTUP.backgroundColor = [UIColor lightGrayColor];
            txtRRTUP.text = @"";
        }
    }
    
    
}

- (IBAction)ActionCheckbox2:(id)sender {
    if ([txtSumAssured.text isEqualToString:@""]) {
        NSString *msg = @"Rider Sum Assured is required.";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
        
        [txtSumAssured becomeFirstResponder];
    }
    else{
        outletCheckBox2.selected = !outletCheckBox2.selected;
        if (outletCheckBox2.selected == TRUE) {
            [outletCheckBox2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            txtRRTUPTerm.enabled = TRUE;
            txtRRTUPTerm.backgroundColor = [UIColor whiteColor];
            [txtRRTUPTerm becomeFirstResponder];
            
        }
        else{
            [outletCheckBox2 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            txtRRTUPTerm.enabled = FALSE;
            txtRRTUPTerm.backgroundColor = [UIColor lightGrayColor];
            txtRRTUPTerm.text = @"";
            
        }

    }
}

- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
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
									  @"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\" AND PTypeCode = '%@'",requestSINo,rider, pTypeCode];
				
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
					
					
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                        NSLog(@"rider delete!");
						appDel.isNeedPromptSaveMsg = YES;
                    } else {
                        NSLog(@"rider delete Failed!");
                    }
                    sqlite3_finalize(statement);
                }
				
				
				if ([rider isEqualToString:@"HMM"] || [rider isEqualToString:@"MG_IV"] ) {
					querySQL = [NSString stringWithFormat: @"Delete From SI_Store_premium Where Sino = '%@' AND Type = '%@'", getSINo, rider];
					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_DONE)
						{
							
						}
						sqlite3_finalize(statement);
					}
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
            [riderCode isEqualToString:@"ECAR6"] || [riderCode isEqualToString:@"ECAR60"]  || [riderCode isEqualToString:@"TSR"] || [riderCode isEqualToString:@"TSER"] ) {
            lblMax.text = [NSString stringWithFormat:@"Max SA: Subject to underwriting"];
        }
        else if ([riderCode isEqualToString:@"RRTUO"] ){
            lblMax.text = @"";
            lblMin.text = @"";
        }
        else if ([riderCode isEqualToString:@"MCFR"]){
            
            lblMax.text = @"";
            lblMin.text = [NSString stringWithFormat:@"Max Premium: %.0f ", maxRiderSA];
        }
        else if ([riderCode isEqualToString:@"ACIR"] || [riderCode isEqualToString:@"CCR"] || [riderCode isEqualToString:@"JCCR"] || [riderCode isEqualToString:@"TCCR"] ){
            lblMax.numberOfLines = 2;
            lblMax.text = [NSString stringWithFormat:@"Max SA: %.f(Subject to CI Benefit Limit Per Life across industry of RM4mil)",maxRiderSA];
        }
        else if ([riderCode isEqualToString:@"MSR"] ){
            if(getBasicSA < 20000){
                lblMin.text = [NSString stringWithFormat:@"Min RSA for MSR is RM 20,000.Thus, "];
                lblMax.text = @"please increase BSA to at least RM20,000.";
                
            }
            else{
                lblMax.numberOfLines = 2;
                lblMax.text = [NSString stringWithFormat:@"Max SA:%.f(Subject to CI Benefit Limit Per Life across industry of RM4mil)",maxRiderSA];
            }
        }
        else if ([riderCode isEqualToString:@"TPDYLA"]){
            
            if(getBasicSA < 20000){
                lblMin.text = [NSString stringWithFormat:@"Min RSA for TPDYLA is RM5,000. Thus, "];
                lblMax.text = @"please increase BSA to at least RM20,000.";
                
            }
            else{
                lblMax.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
            }
            
        }
        else{
            lblMax.text = [NSString stringWithFormat:@"Max SA: %.f",maxRiderSA];
        }
        
    }
    else if ([txtRiderTerm isFirstResponder] == TRUE) {
		if ([riderCode isEqualToString:@"ECAR"] || [riderCode isEqualToString:@"ECAR6"] ) {
            lblMin.text = [NSString stringWithFormat:@"Term: %d, %.0f",  minTerm, maxRiderTerm];
            lblMax.text = @"";
        }
        else if ([riderCode isEqualToString:@"TSR"]){
            NSString *msg = @"Term: ";
            int tempMax = getTerm > 35 ? 35 : (getTerm/5) * 5;
            
            for (int i = 5; i <= tempMax; i = i + 5) {
                if (i + pTypeAge <= 80) {
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                }
            }
            
            msg = [msg substringToIndex:msg.length - 1];
            lblMin.text = msg;
            lblMax.text = @"";
            
        }
        else if ([riderCode isEqualToString:@"CCR"] || [riderCode isEqualToString:@"TCCR"]  ){
            NSString *msg = @"Term: ";
            
            if ([getPlanCode isEqualToString:@"UV"]) {
                for (int i = 5; i <= 35; i = i + 5) {
                    if (i + pTypeAge < 100) {
                        msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                    }
                }
                
                lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"%.0f ", maxRiderTerm]];
                lblMax.text = @"";
            }
            else{
                for (int i = 5; i <= requestCoverTerm; i = i + 5) {
                    
                    msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%d,", i]];
                    
                }
                
                lblMin.text = msg = [msg substringToIndex:msg.length - 1];;
                lblMax.text = @"";
            }
            
            
        }
        else if ([riderCode isEqualToString:@"JCCR"] ){
            NSString *msg = @"Term: ";
            
            if ([getPlanCode isEqualToString:@"UV"]) {
                
                lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"20,25,%.0f ", maxRiderTerm]];
                lblMax.text = @"";
            }
            else{
                if (maxRiderTerm > 20) {
                    lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"20,25" ]];
                    lblMax.text = @"";
                }
                else{
                    lblMin.text = [msg stringByAppendingString:[NSString stringWithFormat:@"20"]];
                    lblMax.text = @"";
                }
                
                
            }
            
            
        }
        else{
            lblMin.text = [NSString stringWithFormat:@"Min Term: %d",minTerm];
            lblMax.text = [NSString stringWithFormat:@"Max Term: %.f",maxRiderTerm];
        }
        
    }
    else if ([txtPaymentTerm isFirstResponder] == TRUE) {
		if ([getPlanCode isEqualToString:@"UP"]) {
			lblMin.text = @"6, 10, 20";
			lblMax.text = @"";
		}
		else{
			lblMin.text = @"";
			lblMax.text = @"";
		}
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
    sqlite3_stmt *statement;
    NSString *querySQL;
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
				
				if ([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_IV"] ) {
					querySQL = [NSString stringWithFormat: @"Delete From SI_Store_premium Where Sino = '%@' AND Type = '%@'", getSINo, riderCode];
					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_DONE)
						{
							
						}
						sqlite3_finalize(statement);
					}
				}
				
                sqlite3_close(contactDB);
            }
			
        }
			
		if (riderTerm > maxRiderTerm)
		{
			dodelete = YES;

			if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
			{
		
                querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
		
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
				
				if ([riderCode isEqualToString:@"HMM"] || [riderCode isEqualToString:@"MG_IV"] ) {
					querySQL = [NSString stringWithFormat: @"Delete From SI_Store_premium Where Sino = '%@' AND Type = '%@'", getSINo, riderCode];
					
					if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
					{
						if (sqlite3_step(statement) == SQLITE_DONE)
						{
                                
						}
						sqlite3_finalize(statement);
					}
				}
				
				sqlite3_close(contactDB);
			}
		}

	}
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if ([LRiderCode indexOfObject:@"MDSR1"] == NSNotFound) {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode in ('MDSR1-ALW', 'MDSR1-OT')",requestSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
        }
        
        if ([LRiderCode indexOfObject:@"MDSR2"] == NSNotFound) {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode in ('MDSR2-ALW', 'MDSR2-OT')",requestSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
        }
        
        if ([LRiderCode indexOfObject:@"LDYR"] == NSNotFound) {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND RiderCode in ('LDYR-PCB', 'LDYR-BBB')",requestSINo];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                }
                sqlite3_finalize(statement);
            }
        }
        
        sqlite3_close(contactDB);
    }
    
    
	

	
	
/*
if (dodelete) {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		[self Validation];
	}
	*/
	
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	[_delegate RiderGlobalSave];
}

- (IBAction)ActionAddRider:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
    /*
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	if (![zzz.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		[self Validation];
	}
     */
    [self Validation];
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
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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

	if ([riderCode isEqualToString:@"TSR"]) {
		self.planList = [[RiderPlanTb alloc] initWithString:@"TSR" andSumAss:[NSString stringWithFormat:@"%d", pTypeAge] andOccpCat:txtRiderTerm.text andTradOrEver:@"EVER" getPlanChoose:@""];
	}
    else{
        if ([getPlanCode isEqualToString:@"UV"]) {
            self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:strSA andOccpCat:OccpCat andTradOrEver:@"EVER" getPlanChoose:@""];
        }
        else{
            self.planList = [[RiderPlanTb alloc] initWithString:planCondition andSumAss:[NSString stringWithFormat:@"%d", getTerm] andOccpCat:OccpCat andTradOrEver:@"EVER" getPlanChoose:@""];
        }
    }
	
	
    
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
	ECAR60MonthlyIncome = NO;
	ECARYearlyIncome = NO;
	ECAR6YearlyIncome = NO;
	RRTUOPrem = NO;
    hload = NO;
    hloadterm = NO;
	hloadPct = NO;
    hloadtermPct = NO;
    bALW = NO;
    bBBB = NO;
    bPCB = NO;
    bOverseaTreatment = NO;
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