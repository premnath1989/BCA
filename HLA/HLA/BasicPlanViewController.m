//
//  BasicPlanViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "BasicPlanViewController.h"
#import "RiderViewController.h"
#import "NewLAViewController.h"
#import "PremiumViewController.h"
#import "SIMenuViewController.h"
#import "MainScreen.h"
#import "BasicPlanHandler.h"
#import "AppDelegate.h"
#import "SIObj.h"

@interface BasicPlanViewController ()

@end

@implementation BasicPlanViewController
@synthesize btnPlan;
@synthesize termField;
@synthesize yearlyIncomeField;
@synthesize minSALabel;
@synthesize maxSALabel;
@synthesize btnHealthLoading;
@synthesize healthLoadingView;
@synthesize MOPSegment;
@synthesize incomeSegment,cashDivSgmntCP;
@synthesize advanceIncomeSegment;
@synthesize cashDividendSegment;
@synthesize HLField;
@synthesize HLTermField;
@synthesize tempHLField,annualRiderSum,halfRiderSum,monthRiderSum,quarterRiderSum;
@synthesize tempHLTermField,basicPremAnn,basicPremHalf,basicPremQuar,basicPremMonth;
@synthesize myScrollView,labelThree,labelSix,labelSeven,labelFour,labelFive,annualMedRiderPrem,monthMedRiderPrem,quarterMedRiderPrem;
@synthesize ageClient,requestSINo,termCover,maxSA,minSA,halfMedRiderPrem;
@synthesize MOP,yearlyIncome,advanceYearlyIncome,basicRate,cashDividend;
@synthesize getSINo,getSumAssured,getPolicyTerm,getHL,getHLTerm,getTempHL,getTempHLTerm;
@synthesize planCode,requestOccpCode,dataInsert,basicBH,basicPH,basicLa2ndH;
@synthesize SINo,LACustCode,PYCustCode,SIDate,SILastNo,CustDate,CustLastNo;
@synthesize NamePP,DOBPP,OccpCodePP,GenderPP,secondLACustCode,IndexNo,PayorIndexNo,secondLAIndexNo;
@synthesize delegate = _delegate;
@synthesize requestAge,OccpCode,requestIDPay,requestIDProf,idPay,idProf,annualMedRiderSum,halfMedRiderSum,quarterMedRiderSum;
@synthesize requestAgePay,requestDOBPay,requestIndexPay,requestOccpPay,requestSexPay,requestSmokerPay,monthMedRiderSum;
@synthesize PayorAge,PayorDOB,PayorOccpCode,PayorSex,PayorSmoker,LPlanOpt,LDeduct,LAge,LSmoker;
@synthesize LTerm,age,sex,LSex,riderRate,LRidHL1K,LRidHL100,LRidHLP,LTempRidHL1K,LOccpCode;
@synthesize requestAge2ndLA,requestDOB2ndLA,requestIndex2ndLA,requestOccp2ndLA,requestSex2ndLA,requestSmoker2ndLA;
@synthesize secondLAAge,secondLADOB,secondLAOccpCode,secondLASex,secondLASmoker;
@synthesize LRiderCode,LSumAssured,expAge,minSATerm,maxSATerm,minTerm,maxTerm,riderCode,_maxRiderSA,maxRiderSA,GYI;
@synthesize requestOccpClass,OccpClass,MOPHLAIB,MOPHLACP,yearlyIncomeHLAIB,cashDividendHLAIB,cashDividendHLACP;
@synthesize advanceYearlyIncomeHLAIB,advanceYearlyIncomeHLACP,maxAge,labelAddHL,occLoad,LSDRate,LUnits,occCPA_PA;
@synthesize planList = _planList;
@synthesize planPopover = _planPopover;
@synthesize labelParAcc,labelParPayout,labelPercent1,labelPercent2,parAccField,parPayoutField,getParAcc,getParPayout;
@synthesize pTypeOccp,occLoadRider,riderPrem,waiverRiderAnn,medRiderPrem,headerTitle;
@synthesize waiverRiderAnn2,waiverRiderHalf,waiverRiderHalf2,waiverRiderMonth,waiverRiderMonth2,waiverRiderQuar,waiverRiderQuar2;
@synthesize quotationLang,requesteProposalStatus, EAPPorSI, outletDone, outletEAPP, outletSpace;
@synthesize labelPremiumPay, requestEDD;
@synthesize planChoose;
//@synthesize planData;


#pragma mark - Frequently used variables
NSString* const STR_S100 = @"S100";
NSString* const STR_HLACP = @"HLACP";
NSString* const STR_HLAWP = @"HLAWP";
//NSString* const STR_L100 = @"L100";
NSString* const STR_L100 = @"BCALH";
NSString* const STR_HLAIB = @"HLAIB";


const double annualRate = 1.0;
const double semiAnnualRate = 0.5125;
const double quarterlyRate = 0.2625;
const double monthlyRate = 0.0875;

#pragma mark - Cycle View

id temp;
bool WPTPD30RisDeleted = FALSE;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    self.healthLoadingView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
    
	if ([requesteProposalStatus isEqualToString:@"Failed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [requesteProposalStatus isEqualToString:@"Confirmed"] || [EAPPorSI isEqualToString:@"eAPP"]
        || [requesteProposalStatus isEqualToString:@"Created_View"]) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
	
    [self loadData];
    //--
    btnHealthLoading.hidden = YES;
    labelAddHL.hidden = YES;
    //--
    
    self.planList = [[PlanList alloc] init];
    _planList.delegate = self;
	self.planList.TradOrEver = @"TRAD";
    labelThree.text = @"Basic Sum Assured:";
    
    useExist = NO;
    termField.enabled = NO;
    healthLoadingView.alpha = 0;
    showHL = NO;
    _quotationLangSegment.hidden = TRUE;
    
    [self togglePlan];
    
    [self resetData];
    if (self.requestSINo) {
        [self checkingExisting];
        if (getSINo.length != 0) {
            [self getExistingBasic:true];
            [self togglePlan];
            [self toggleExistingField];
			
        }
    } else {
        ModeOfPayment = @"M";
        MOPHLAIB = 0;
        MOP = 5;
    }
    
    if (PayorIndexNo != 0) {
        IndexNo = PayorIndexNo;
        [self getProspectData];
    }
    
    if (secondLAIndexNo != 0) {
        IndexNo = secondLAIndexNo;
        [self getProspectData];
    }
    [parAccField setDelegate:self];
    [parPayoutField setDelegate:self];
    [termField setDelegate:self];
    [yearlyIncomeField setDelegate:self];
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
    _planList = nil;
	
	outletEAPP.width = 0.01;
    outletSpace.width = 666;
	
	if (Editable == NO) {
		[self DisableTextField:termField ];
		[self DisableTextField:yearlyIncomeField];
		[self DisableTextField:parAccField ];
		[self DisableTextField:parPayoutField ];
		
		MOPSegment.enabled = FALSE;
		incomeSegment.enabled = FALSE;
		btnPlan.enabled = FALSE;
		cashDividendSegment.enabled = FALSE;
		advanceIncomeSegment.enabled = FALSE;
		cashDivSgmntCP.enabled = FALSE;
		_quotationLangSegment.enabled = FALSE;
        _policyTermSeg.enabled = FALSE;
        
        
		if([EAPPorSI isEqualToString:@"eAPP"]){
			outletEAPP.width = 0;
			outletSpace.width = 564;
			outletDone.enabled = FALSE;
		}
		
	} else {
		if([requesteProposalStatus isEqualToString:@"Created"]){
			btnPlan.enabled = FALSE;
		}		
	}
    
    if([EAPPorSI isEqualToString:@"eAPP"]){
        [self disableFieldsForEapp];
    }
}

-(void) disableFieldsForEapp
{
    [btnPlan setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    _policyTermSeg.enabled = FALSE;
    
    yearlyIncomeField.enabled = NO;
    yearlyIncomeField.backgroundColor = [UIColor lightGrayColor];
    
    parAccField.enabled = NO;
    parAccField.backgroundColor = [UIColor lightGrayColor];
    
    parPayoutField.enabled = NO;
    parPayoutField.backgroundColor = [UIColor lightGrayColor];
}

-(void)resetData{
    cashDividendHLACP = @"";
    cashDividend = @"";
    quotationLang = @"English"; //default without selection is English
    policyTermSegInt = 30; //default policy term segment ; @Edwin 09/07/2014
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

-(void)loadData//pass data to local variable from other view controller
{
    //request LA details
    ageClient = requestAge;
    OccpCode = [self.requestOccpCode description];
    OccpClass = requestOccpClass;
    idPay = requestIDPay;
    idProf = requestIDProf;
    PayorIndexNo = requestIndexPay;
    PayorSmoker = [self.requestSmokerPay description];
    PayorSex = [self.requestSexPay description];
    PayorSex = [PremiumViewController getShortSex:PayorSex];
    PayorDOB = [self.requestDOBPay description];
    PayorAge = requestAgePay;
    PayorOccpCode = [self.requestOccpPay description];
    secondLAIndexNo = requestIndex2ndLA;
    secondLASmoker = [self.requestSmoker2ndLA description];
    secondLASex = [self.requestSex2ndLA description];
    secondLASex = [PremiumViewController getShortSex:secondLASex];
    secondLADOB = [self.requestDOB2ndLA description];
    secondLAAge = requestAge2ndLA;
    secondLAOccpCode = [self.requestOccp2ndLA description];
    SINo = [self.requestSINo description];
//    NSLog(@"loadData BASIC-SINo:%@, age:%d, job:%@",SINo,ageClient,OccpCode);
//    NSLog(@"loadData BASIC-idPayor:%d, idProfile:%d",idPay,idProf);
    
    [self getTermRule];
    
    if ([planChoose isEqualToString:STR_HLAWP])
    {
        if (requestAge > 45 ) {
            [_policyTermSeg setEnabled:NO forSegmentAtIndex:1];
            [[_policyTermSeg.subviews objectAtIndex:0] setAlpha:0.5];
        }
        else{
            [_policyTermSeg setEnabled:YES forSegmentAtIndex:1];;
            [[_policyTermSeg.subviews objectAtIndex:0] setAlpha:1];
        }        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{    
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

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 960-264);
    self.myScrollView.contentSize = CGSizeMake(768, 960);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    minSALabel.text = @"";
    maxSALabel.text = @"";    
    self.myScrollView.frame = CGRectMake(0, 44, 768, 960);
}

-(void)textFieldDidChange:(UITextField*)textField
{
    appDelegate.isNeedPromptSaveMsg = YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            minSALabel.text = @"";
            maxSALabel.text = @"";
            break;
			
        case 1:
            if( [planChoose isEqualToString:STR_HLACP] )
            {
                if (ageClient < 41) {
                    minSA = 1200;
                }
            }
            
            if(planChoose != nil)
            {
                minSALabel.text = [NSString stringWithFormat:@"Min: %d",minSA];
                maxSALabel.text = [NSString stringWithFormat:@"Max: %.0f",maxSA];
            }            
            break;
            
        default:
            minSALabel.text = @"";
            maxSALabel.text = @"";
            break;
    }
    activeField = textField;
	[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString     = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    if ([arrayOfString count] > 2 )
    {
        return NO;
    }
    

    if ([textField isEqual:parAccField] || [textField isEqual:parPayoutField]) {
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
            return NO;
        }
    }
    else{
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
        if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
            return NO;
        }
    }
    
    
    if ([textField isEqual:parAccField]) {
        if (parAccField.text.length > 2 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    
    if ([textField isEqual:parPayoutField]) {
        if (parPayoutField.text.length > 2 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Action

- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)btnPlanPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_planList == nil) {
        self.planList = [[PlanList alloc] init];
        self.planList.TradOrEver = @"TRAD";
        _planList.delegate = self;
        self.planPopover = [[UIPopoverController alloc] initWithContentViewController:_planList];
    }
    
    CGRect rect = [sender frame];
    rect.origin.y = [sender frame].origin.y + 30;
    
    [self.planPopover setPopoverContentSize:CGSizeMake(350.0f, 200.0f)];
    [self.planPopover presentPopoverFromRect:rect  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)policyTermSegPressed:(id)sender {
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if(_policyTermSeg.selectedSegmentIndex == 0)
    {
        policyTermSegInt = 30;
    }else
    if(_policyTermSeg.selectedSegmentIndex == 1)
    {
        policyTermSegInt = 50;
    }
    
    [self getTermRule];
}


- (IBAction)quotationLangSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if(_quotationLangSegment.selectedSegmentIndex == 0)
    {
        quotationLang = @"English";
    } else if(_quotationLangSegment.selectedSegmentIndex == 1) {
        quotationLang = @"Malay";
    }    
}

-(int)scanForNumbersFromString:(NSString*)strData {
    NSScanner *scanner = [NSScanner scannerWithString:strData];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *numberString; //intermediate
    
    //throw away characters before the first number
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    //collect numbers
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    //result
    
    int num;
    if ([strData isEqualToString:@"Single"]) {
        num = 1;
    }
    else{
        num = 5;
    }
    
    
    return num;
}

- (IBAction)MOPSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    int val = [self scanForNumbersFromString:[MOPSegment titleForSegmentAtIndex:MOPSegment.selectedSegmentIndex]];
    MOPHLAIB = val;
    appDelegate.isNeedPromptSaveMsg = YES;
    
    MOP = val;
}

- (IBAction)incomeSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (incomeSegment.selectedSegmentIndex == 0) {
        yearlyIncomeHLAIB = @"ACC";
    }
    else if (incomeSegment.selectedSegmentIndex == 1) {
        yearlyIncomeHLAIB = @"POF";
    }
    NSLog(@"yearlyIncome:%@",yearlyIncomeHLAIB);
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)cashDividendSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (cashDividendSegment.selectedSegmentIndex == 0) {
        cashDividendHLAIB = @"ACC";
    }
    else if (cashDividendSegment.selectedSegmentIndex == 1) {
        cashDividendHLAIB = @"POF";
    }
    NSLog(@"cashDiv:%@",cashDividendHLAIB);
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)advanceIncomeSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (advanceIncomeSegment.selectedSegmentIndex == 0) {
        advanceYearlyIncomeHLAIB = 60;
        ModeOfPayment = @"L";
    }
    else if (advanceIncomeSegment.selectedSegmentIndex == 1) {
        advanceYearlyIncomeHLAIB = 75;
        ModeOfPayment = @"Y";
    }
    else if (advanceIncomeSegment.selectedSegmentIndex == 2) {
        advanceYearlyIncomeHLAIB = 0;
        ModeOfPayment = @"M";
    }
    NSLog(@"advance:%d",advanceYearlyIncomeHLAIB);
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)cashDivSgmntCPPressed:(id)sender
{
    NSLog(@"plan choose = %@", planChoose);
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (cashDivSgmntCP.selectedSegmentIndex == 0) {
        cashDividendHLACP = @"ACC";
    }
    else if (cashDivSgmntCP.selectedSegmentIndex == 1) {
        cashDividendHLACP = @"POF";
    }
    NSLog(@"cashDivCP:%@",cashDividendHLACP);
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)btnShowHealthLoadingPressed:(id)sender
{
    if (showHL) {
        [self.btnHealthLoading setTitle:@"Show" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            healthLoadingView.alpha = 0;
        }];
        showHL = NO;
    }
    else {        
        [self.btnHealthLoading setTitle:@"Hide" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            healthLoadingView.alpha = 1;
        }];
        showHL = YES;
    }
}

- (IBAction)doSavePlan:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    [_delegate saveAll];
}

-(BOOL)checkingSave:(NSString *)getSex
{
    if([getSex length]>0) {
        sex = getSex;
        sex = [PremiumViewController getShortSex:sex];
    }
    
    [self checkExistRider];
    if ([self isPlanChanged]) {
        if (arrExistRiderCode.count > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert setTag:1007];
            [alert show];
        }
    }
    if (useExist) {
        if([self updateBasicPlan]) //validate existing rider will be done here
        {
            return YES;
        }
    } else {
        [self saveBasicPlan];
        return YES;
    }
    [self checkingExisting];
    return NO;
}

-(BOOL)isPlanChanged
{
    if( [prevPlanChoose length]==0 ) {
        return false;
    } else {
        if( [prevPlanChoose isEqualToString:planChoose] ) {
            return false;
        } else {
            return true;
        }
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0) {
        
        NewLAViewController *NewLAPage  = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
        MainScreen *MainScreenPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        MainScreenPage.IndexTab = 3;
        NewLAPage.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentViewController:MainScreenPage animated:YES completion:^(){
//            [MainScreenPage presentModalViewController:NewLAPage animated:NO];
            [MainScreenPage presentViewController:NewLAPage animated:NO completion:nil];
            NewLAPage.view.superview.bounds =  CGRectMake(-300, 0, 1024, 748);
            
        }];
    }
    else if (alertView.tag==1002 && buttonIndex == 0) {
        [self checkingSave:@""];
    }
    else if (alertView.tag==1003 && buttonIndex == 0) {
        [self checkingSave:@""];
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
		//        [self closeScreen];
    }else if (alertView.tag == 1007 && buttonIndex == 0) {
        [self deleteRider];
    }
    else if (alertView.tag==1010){
        planChoose = nil;
        btnPlan.titleLabel.text = @"";
        [self togglePlan];
    }
    else if (alertView.tag==1011){
        planChoose = nil;
        btnPlan.titleLabel.text = @"";
        [self togglePlan];
    }
}

#pragma mark - Toogle view

-(void)toggleExistingField
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:getSumAssured]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
    if ([planChoose isEqualToString:prevPlanChoose]) {
        yearlyIncomeField.text = [[NSString alloc] initWithFormat:@"%@",sumAss];
    } else {
        yearlyIncomeField.text = @"";
    }
    
    if ([quotationLang isEqualToString:@"English"]) {
        _quotationLangSegment.selectedSegmentIndex = 0;
    }
    else if ([quotationLang isEqualToString:@"Malay"]) {
        _quotationLangSegment.selectedSegmentIndex = 1;
    }
    
    if ([planChoose isEqualToString:STR_HLAIB]) {
        
        MOPHLAIB = MOP;
        if (MOPHLAIB == 6) {
            MOPSegment.selectedSegmentIndex = 0;
        }
        else if (MOPHLAIB == 9) {
            MOPSegment.selectedSegmentIndex = 1;
        }
        else if (MOPHLAIB == 12) {
            MOPSegment.selectedSegmentIndex = 2;
        }
        
        yearlyIncomeHLAIB = yearlyIncome;
        if ([yearlyIncomeHLAIB isEqualToString:@"ACC"]) {
            incomeSegment.selectedSegmentIndex = 0;
        }
        else if ([yearlyIncomeHLAIB isEqualToString:@"POF"]) {
            incomeSegment.selectedSegmentIndex = 1;
        }
        
        cashDividendHLAIB = cashDividend;
        if ([cashDividendHLAIB isEqualToString:@"ACC"]) {
            cashDividendSegment.selectedSegmentIndex = 0;
        }
        else if ([cashDividendHLAIB isEqualToString:@"POF"]) {
            cashDividendSegment.selectedSegmentIndex = 1;
        }
        /*
        //--handle advance segment
        if (ageClient > 65) {
            if (advanceYearlyIncome != 0) {
                
                advanceYearlyIncome = 0;
                advanceIncomeSegment.selectedSegmentIndex = 2;
                sqlite3_stmt *statement;
                if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                {
                    NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET AdvanceYearlyIncome=\"%d\", UpdatedAt=%@ WHERE SINo=\"%@\"",advanceYearlyIncome,  @"datetime(\"now\", \"+8 hour\")", SINo];
                    
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            NSLog(@"BasicPlan update!");
                        }
                        else {
                            NSLog(@"BasicPlan update Failed!");
                        }
                        sqlite3_finalize(statement);
                    }
                    sqlite3_close(contactDB);
                }
            }
        }
        else if (ageClient > 50 && ageClient <=65)
        {
            if (advanceYearlyIncome == 60) {
                advanceYearlyIncome = 0;
                advanceIncomeSegment.selectedSegmentIndex = 2;
                
                sqlite3_stmt *statement;
                if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                {
                    NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET AdvanceYearlyIncome=\"%d\", UpdatedAt=%@ WHERE SINo=\"%@\"",advanceYearlyIncome,  @"datetime(\"now\", \"+8 hour\")", SINo];
                    
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            NSLog(@"BasicPlan update!");
                        }
                        else {
                            NSLog(@"BasicPlan update Failed!");
                        }
                        sqlite3_finalize(statement);
                    }
                    sqlite3_close(contactDB);
                }
            }
        }
        else {
            if (advanceYearlyIncome == 60) {
                advanceIncomeSegment.selectedSegmentIndex = 0;
            }
            else if (advanceYearlyIncome == 75) {
                advanceIncomeSegment.selectedSegmentIndex = 1;
            }
            else if (advanceYearlyIncome == 0) {
                advanceIncomeSegment.selectedSegmentIndex = 2;
            }
        }
        */

        if ([ModeOfPayment isEqualToString:@"L"]) {
            advanceIncomeSegment.selectedSegmentIndex = 0;
        }
        else if ([ModeOfPayment isEqualToString:@"Y"]) {
            advanceIncomeSegment.selectedSegmentIndex = 1;
        }
        else if ([ModeOfPayment isEqualToString:@"M"]) {
            advanceIncomeSegment.selectedSegmentIndex = 2;
        }
        
        //--end--
    }
    else if ([planChoose isEqualToString:STR_HLACP])
    {
        NSLog(@"ok HLACP, cashDividendHLACP=%@", cashDividendHLACP);
        parAccField.text = [NSString stringWithFormat:@"%d",getParAcc];
        parPayoutField.text = [NSString stringWithFormat:@"%d",getParPayout];
        
        if([cashDividend length]>0 && ![cashDividend isEqualToString:@"(null)"])
            cashDividendHLACP = cashDividend;
        if ([cashDividendHLACP isEqualToString:@"ACC"]) {
            cashDivSgmntCP.selectedSegmentIndex = 0;
        }
        else if ([cashDividendHLACP isEqualToString:@"POF"]) {
            cashDivSgmntCP.selectedSegmentIndex = 1;
        }
    } else if ([planChoose isEqualToString:STR_HLAWP]) {        
        MOPHLAIB = MOP;
        if (MOP == 6) {
            MOPSegment.selectedSegmentIndex = 0;
        }
        else if (MOP == 10) {
            MOPSegment.selectedSegmentIndex = 1;
        }
        
        parAccField.text = [NSString stringWithFormat:@"%d",getParAcc];
        parPayoutField.text = [NSString stringWithFormat:@"%d",getParPayout];
        
        if([cashDividend length]>0 && ![cashDividend isEqualToString:@"(null)"]) {
            cashDividendHLACP = cashDividend;
        }
        
        if ([cashDividendHLACP isEqualToString:@"ACC"]) {
            cashDivSgmntCP.selectedSegmentIndex = 0;
        } else if ([cashDividendHLACP isEqualToString:@"POF"]) {
            cashDivSgmntCP.selectedSegmentIndex = 1;
        }
    
        if (getPolicyTerm == 30) {
            policyTermSegInt = 30;
            _policyTermSeg.selectedSegmentIndex = 0;
        } else if (getPolicyTerm == 50) {
            policyTermSegInt = 50;
            _policyTermSeg.selectedSegmentIndex = 1;
        }
    
    } else if ([planChoose isEqualToString:STR_S100]) {
        MOPHLAIB = MOP;
        NSString *tempMOPStr = [NSString stringWithFormat:@"%d", MOP];
        int i=0;
        for (i=0;i < MOPSegment.numberOfSegments-1; i++) {
            if ([[MOPSegment titleForSegmentAtIndex:i] isEqualToString:tempMOPStr]) {
                break;
            }
        }
        MOPSegment.selectedSegmentIndex = i;
        
        
    }
    else if ([planChoose isEqualToString:STR_L100]) {
        if ([ModeOfPayment isEqualToString:@"L"]) {
            [advanceIncomeSegment setSelectedSegmentIndex:0];
        }
        else if ([ModeOfPayment isEqualToString:@"Y"]) {
            [advanceIncomeSegment setSelectedSegmentIndex:1];
        }
        else if ([ModeOfPayment isEqualToString:@"M"]) {
            [advanceIncomeSegment setSelectedSegmentIndex:2];
        }
        
    }
    
    if (getHL.length != 0) {
        NSRange rangeofDot = [getHL rangeOfString:@"."];
        NSString *valueToDisplay = @"";
        
        if (rangeofDot.location != NSNotFound) {
            NSString *substring = [getHL substringFromIndex:rangeofDot.location ];
            if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                valueToDisplay = [getHL substringToIndex:rangeofDot.location ];
            } else {
                valueToDisplay = getHL;
            }
        } else {
            valueToDisplay = getHL;
        }
        HLField.text = valueToDisplay;
    }
    
    if (getHLTerm != 0) {
        HLTermField.text = [NSString stringWithFormat:@"%d",getHLTerm];
    }
    
    if (getTempHL.length != 0) {
        NSRange rangeofDot = [getTempHL rangeOfString:@"."];
        NSString *valueToDisplay = @"";
        
        if (rangeofDot.location != NSNotFound) {
            NSString *substring = [getTempHL substringFromIndex:rangeofDot.location ];
            if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                valueToDisplay = [getTempHL substringToIndex:rangeofDot.location ];
            } else {
                valueToDisplay = getTempHL;
            }
        }
        else {
            valueToDisplay = getTempHL;
        }
        tempHLField.text = valueToDisplay;
    }
    
    if (getTempHLTerm != 0) {
        tempHLTermField.text = [NSString stringWithFormat:@"%d",getTempHLTerm];		
    }
    //[self getPlanCodePenta];
    [self getTermRule];
    [_delegate BasicSI:getSINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose planName:(NSString *)btnPlan.titleLabel.text];
}

-(void)updateHealthLoading {
    getHL = @"";
    HLField.text = @"";
    getHLTerm = 0;
    HLTermField.text = @"";
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Trad_Details SET HL1KSA=\"%@\", HL1KSATerm=\"%d\" WHERE SINo=\"%@\"",getHL, getHLTerm, SINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateCurrentHealthLoading {
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT HL1KSA, HL1KSATerm, TempHL1KSA, TempHL1KSATerm FROM Trad_Details WHERE SINo=\"%@\"",SINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                getHL = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                getHLTerm = sqlite3_column_int(statement, 1);
                getTempHL = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                getTempHLTerm = sqlite3_column_int(statement, 3);
                
                HLField.text = getHL;
                HLTermField.text = [NSString stringWithFormat:@"%d",getHLTerm];
                tempHLField.text = getTempHL;
                tempHLTermField.text = [NSString stringWithFormat:@"%d",getTempHLTerm];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateTemporaryHealthLoading {
    getTempHL = @"";
    tempHLField.text = @"";
    getTempHLTerm = 0;
    tempHLTermField.text = @"";
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Trad_Details SET TempHL1KSA=\"%@\", TempHL1KSATerm=\"%d\" WHERE SINo=\"%@\"",getTempHL, getTempHLTerm, SINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}

-(void)reloadPaymentOption
{
    if ([planChoose isEqualToString:STR_S100]) {
        // temporary hack
        MOPHLAIB = 100 - ageClient;
        MOP = MOPHLAIB;
    } else if ([planChoose isEqualToString:STR_HLAWP]) {
        MOPHLAIB = 0;
    }
}

-(void)togglePlan
{
    NSLog(@"togglePlan %@   prev:%@",planChoose, prevPlanChoose);
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    BOOL isDiffPlan = FALSE;
    if (planChoose != NULL && ![planChoose isEqualToString:prevPlanChoose]) {
        getSumAssured = 0;
        yearlyIncomeField.text = @"";
        isDiffPlan = TRUE;
    }
    
    if ([planChoose isEqualToString:STR_HLAIB]) {
        [self togglePlanHLAIB];
        
    } else if ([planChoose isEqualToString:STR_L100]) {
        [self togglePlanL100:zzz];
        
    } else if ([planChoose isEqualToString:STR_S100]) {
        [self togglePlanS100:zzz];
        if (isDiffPlan) {
            // temporary hack
            MOPHLAIB = 100 - ageClient;
            MOP = MOPHLAIB;
        }
        
    } else if ([planChoose isEqualToString:STR_HLACP]) {
        [self togglePlanHLACP:zzz];
        
    } else if ([planChoose isEqualToString:STR_HLAWP]) {
        [self togglePlanHLAWP:zzz];
        if (isDiffPlan) {
            MOPHLAIB = 0;
        }
        
    } else {
        labelPremiumPay.hidden = YES;
        cashDivSgmntCP.hidden = YES;
        labelFour.hidden = YES;
        labelFive.hidden = YES;
        labelSix.hidden = YES;
        labelSeven.hidden = YES;
        labelParAcc.hidden = YES;
        labelParPayout.hidden = YES;
        labelPercent1.hidden = YES;
        labelPercent2.hidden = YES;
        parPayoutField.hidden = YES;
        parAccField.hidden = YES;
        MOPSegment.hidden = YES;
        incomeSegment.hidden = YES;
        cashDividendSegment.hidden = YES;
        advanceIncomeSegment.hidden = YES;
        btnPlan.titleLabel.text = @"";
        planChoose = nil;
    }
    
//    NSLog(@"TOGGLE  MOP: %d   %d", MOP, MOPHLAIB);
    [self getTermRule];
    
}

-(void)togglePlanHLAIB {    
    _policyTermSeg.hidden = YES;
    cashDivSgmntCP.hidden = YES;
    labelFour.text = @"Premium Payment Option* :";
    labelFive.text = @"Yearly Income* :";
    labelSix.text = @"Cash Dividend* :";
    labelSeven.text = @"Advance Yearly Income (Age) :";
    labelParAcc.hidden = YES;
    labelParPayout.hidden = YES;
    labelPercent1.hidden = YES;
    labelPercent2.hidden = YES;
    parPayoutField.hidden = YES;
    parAccField.hidden = YES;
    MOPSegment.hidden = NO;
    incomeSegment.hidden = NO;
    cashDividendSegment.hidden = NO;
    advanceIncomeSegment.hidden = NO;
    
    [MOPSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [incomeSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [cashDividendSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    if (ageClient > 65) {
        advanceIncomeSegment.enabled = NO;
        
    } else if (ageClient > 50) {
        [advanceIncomeSegment setEnabled:NO forSegmentAtIndex:0];
        [[advanceIncomeSegment.subviews objectAtIndex:0] setAlpha:0.5];
    }

}

-(void)togglePlanL100:(AppDelegate*)zzz {    
    
    labelFour.hidden = YES;
    labelFive.hidden = YES;
    labelSeven.hidden = NO;
    labelSeven.text = @"Mode of Payment :";
    labelParAcc.hidden = YES;
    labelParPayout.hidden = YES;
    labelPercent1.hidden = YES;
    labelPercent2.hidden = YES;
    labelSix.hidden = YES;
    labelPremiumPay.hidden = NO;
    
    _policyTermSeg.hidden = YES;
    cashDivSgmntCP.hidden = YES;
    parPayoutField.hidden = YES;
    parAccField.hidden = YES;
    MOPSegment.hidden = NO;
    incomeSegment.hidden = YES;
    cashDividendSegment.hidden = YES;
    advanceIncomeSegment.hidden = NO;

    btnPlan.titleLabel.text = @"BCA Life Heritage";
    labelThree.text = @"Basic Sum Assured :";
    planChoose = STR_L100;
    zzz.planChoose = planChoose;
    termField.hidden = NO;
    termField.text = [NSString stringWithFormat:@"%d", 100 - ageClient];
    [self.btnPlan setTitle:@"BCA Life Heritage" forState:UIControlStateNormal];
    
    [MOPSegment setTitle:@"Single" forSegmentAtIndex:0];
    [MOPSegment setTitle:@"5" forSegmentAtIndex:1];
    
    [advanceIncomeSegment setTitle:@"Sekaligus" forSegmentAtIndex:0];
    [advanceIncomeSegment setTitle:@"Tahunan" forSegmentAtIndex:1];
    [advanceIncomeSegment setTitle:@"Bulanan" forSegmentAtIndex:2];

}

-(void)togglePlanS100:(AppDelegate *)zzz {
    _policyTermSeg.hidden = YES;
    cashDivSgmntCP.hidden = YES;
    labelFour.hidden = YES;
    labelFive.hidden = YES;
    labelSeven.hidden = YES;
    labelParAcc.hidden = YES;
    labelParPayout.hidden = YES;
    labelPercent1.hidden = YES;
    labelPercent2.hidden = YES;
    parPayoutField.hidden = YES;
    parAccField.hidden = YES;
    MOPSegment.hidden = NO;
    incomeSegment.hidden = YES;
    cashDividendSegment.hidden = YES;
    advanceIncomeSegment.hidden = YES;
    labelSix.hidden = YES;
    labelPremiumPay.hidden = NO;
    labelPremiumPay.text = @"Premium Payment Term";
    
    [self setS100MOPsegment];
    labelThree.text = @"Basic Sum Assured(RM)* :";    
    labelFour.text = @"Premium Payment Term* :";
    
    zzz.planChoose = planChoose;
    termField.hidden = NO;
    [self.btnPlan setTitle:@"Secure100" forState:UIControlStateNormal];
}

-(void)setS100MOPsegment {
    // clear segment
    [MOPSegment removeAllSegments];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = @"SELECT MaxTerm FROM Trad_Sys_mtn WHERE PlanCode=\"S100\"";
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            UILabel *label;
            CGRect frame;
            NSString *mopstr;
            NSString *temp;
            int count = 0;
            [MOPSegment setFrame:CGRectMake(374, 129, 354, 95)];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                mopstr = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                if ([mopstr isEqualToString:@"100"]) {
                    temp = @"Whole\nPolicy\nTerm";
                } else {
                    temp = [[NSString alloc] initWithFormat:@"Limited\n%@\nyears", mopstr];
                }
                [MOPSegment insertSegmentWithTitle:temp atIndex:count animated:NO];
                count++;
            }
//            UIFont *font = [UIFont boldSystemFontOfSize:10.0f];
            for (UIView *temp in [MOPSegment subviews]) {
                if ([NSStringFromClass(temp.class) isEqualToString:@"UISegment"]) {
                    for (UIView *labelView in [temp subviews]) {
                        if ([NSStringFromClass(labelView.class) isEqualToString:@"UISegmentLabel"]) {
                            label = (id)labelView;
                            label.numberOfLines = 3;
                            label.textAlignment = NSTextAlignmentCenter;
//                            label.font = font;
                            frame = CGRectMake(0, 0, label.frame.size.width, MOPSegment.frame.size.height); 
                            label.frame = frame;
                            break;
                        }
                    }
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }

}


-(int)getIntDataInDatabase:(NSString *)table forKey:(NSString *)key withValue:(NSString *)value whereKey:(NSString *)whereKey whereValue:(NSString *)whereValue{
    
    sqlite3_stmt *statement;
    NSString *resultStr;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@=\"%@\"", key, table, whereKey, whereValue];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                resultStr = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    NSLog(@"Resultstr  %@   %d", resultStr, termCover);
    return [resultStr integerValue];
}

-(void)setHLAWPMOPsegment {
    // clear segment
    [MOPSegment removeAllSegments];
    [MOPSegment setFrame:CGRectMake(374, 129, 287, 44)];
    [MOPSegment insertSegmentWithTitle:@"6 years" atIndex:0 animated:NO];
    [MOPSegment insertSegmentWithTitle:@"10 years" atIndex:1 animated:NO];
}

-(NSDictionary *)loadPlistWithName:(NSString *)name {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return data;
}

-(void)togglePlanHLACP:(AppDelegate *)del {
    termField.hidden = NO;
    _policyTermSeg.hidden = YES;
    yearlyIncomeField.text = @"1200";
    cashDivSgmntCP.hidden = NO;
    labelThree.text = @"Desired Yearly Income(RM)* :";
    labelFour.text = @"Yearly Income* :";
    labelFour.hidden = NO;
    labelFive.text = @"Cash Dividend* :";
    labelFive.hidden = NO;
    labelSix.text = @"";
    labelSeven.text = @"";
    labelParAcc.hidden = NO;
    labelParPayout.hidden = NO;
    labelPercent1.hidden = NO;
    labelPercent2.hidden = NO;
    parPayoutField.hidden = NO;
    parAccField.hidden = NO;
    MOPSegment.hidden = YES;
    incomeSegment.hidden = YES;
    cashDividendSegment.hidden = YES;
    advanceIncomeSegment.hidden = YES;
    labelPremiumPay.hidden = YES;
    [cashDivSgmntCP setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    MOPHLACP = 6;
    advanceYearlyIncomeHLACP = 0;
    btnPlan.titleLabel.text = @"HLA Cash Promise";
    planChoose = STR_HLACP;
    del.planChoose = planChoose;
    [self.btnPlan setTitle:@"HLA Cash Promise" forState:UIControlStateNormal];

}

-(void) togglePlanHLAWP:(AppDelegate *)del {
    _policyTermSeg.hidden = YES;
    cashDivSgmntCP.hidden = NO;
    labelPremiumPay.hidden = NO;
    labelPremiumPay.text = @"Premium Payment Option";
    labelThree.text = @"Desired Annual Premium(RM)* :";
    labelFour.numberOfLines = 3;
    labelFour.text = @"Yearly Cash Coupons/Cash Payments\n(Only applicable if Wealth Savings\nRider(s) is attached) :";
    labelFour.hidden = NO;
    labelFive.text = @"Cash Dividend :";
    labelFive.hidden = NO;
    labelSix.text = @"";
    labelSeven.text = @"";
    labelParAcc.hidden = NO;
    labelParPayout.hidden = NO;
    labelPercent1.hidden = NO;
    labelPercent2.hidden = NO;
    parPayoutField.hidden = NO;
    parAccField.hidden = NO;
    MOPSegment.hidden = NO;
    [self setHLAWPMOPsegment];
    incomeSegment.hidden = YES;
    cashDividendSegment.hidden = YES;
    advanceIncomeSegment.hidden = YES;
    [cashDivSgmntCP setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    MOPHLACP = 6;
    advanceYearlyIncomeHLACP = 0;
    btnPlan.titleLabel.text = @"BCA Life Heritage";
    planChoose = STR_HLAWP;
    termField.hidden = NO;
    termField.text = [NSString stringWithFormat:@"%d", 100 - age];
    del.planChoose = planChoose;
    
    [self.btnPlan setTitle:@"BCA Life Heritage" forState:UIControlStateNormal];
    

}

#pragma mark - calculation

-(double)getBasicSAFactor{
    if (termCover == 50) {
        return 2.5;
    }
    else if (termCover == 30){
        return 1.5;
    }
    else{
        return 0.00;
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
            } else {
                NSLog(@"error access getOccpCatCode");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}



-(void)calculateSA //exact copy of RiderViewController.m
{
    double dblPseudoBSA;
    double dblPseudoBSA2 ;
    double dblPseudoBSA3 ;
    double dblPseudoBSA4 ;
    NSString *str;    
    getSumAssured = [yearlyIncomeField.text doubleValue];    
    if ([planChoose isEqualToString:STR_HLAWP]) {
        dblPseudoBSA = getSumAssured * MOP * [self getBasicSAFactor];
        dblPseudoBSA2 = dblPseudoBSA * 0.1;
        dblPseudoBSA3 = dblPseudoBSA * 5;
        dblPseudoBSA4 = dblPseudoBSA * 2;
    } else {
        dblPseudoBSA = getSumAssured / 0.05;
        dblPseudoBSA2 = dblPseudoBSA * 0.1;
        dblPseudoBSA3 = dblPseudoBSA * 5;
        dblPseudoBSA4 = dblPseudoBSA * 2;
    }
    
    double pseudoFactor = 0;
    if(termCover == 30)
    {
        pseudoFactor = 1.5;
    } else if(termCover == 50) {
        pseudoFactor = 2.5;
    }
    
    int MaxUnit = 0;    
    if ([riderCode isEqualToString:@"ACIR_MPP"])
    {
        _maxRiderSA = fmin(getSumAssured,4000000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    } else if ([riderCode isEqualToString:@"CCTR"]) {
        if([planChoose isEqualToString:STR_HLACP])
        {
            _maxRiderSA = dblPseudoBSA3;
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        } else if([planChoose isEqualToString:STR_HLAWP]) {
            _maxRiderSA = dblPseudoBSA * 5;
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        } else if([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
            _maxRiderSA = getSumAssured;
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
            maxRiderSA = maxRiderSA * maxSAFactor;
        }
    } else if ([riderCode isEqualToString:@"TPDYLA"]) {
        double minOf = -1;
        if ([planChoose isEqualToString:STR_HLACP]) {
            minOf = maxSAFactor*(getSumAssured / 0.05);
            _maxRiderSA = fmin(minOf, 200000);
        } else if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
            //minOf = maxSAFactor*getBasicSA;
            //_maxRiderSA = fmin(minOf, 200000); wrong formula by edwin
            if ([OccpCat isEqualToString:@"UNEMP"] || [OccpCat isEqualToString:@"JUV"] || [OccpCat isEqualToString:@"STU"] || [OccpCat isEqualToString:@"HSEWIFE"] || [OccpCat isEqualToString:@"RET"] ) {
                _maxRiderSA = fmin(24000, floor(getSumAssured * maxSAFactor));
            } else {
                _maxRiderSA = fmin(200000, getSumAssured * maxSAFactor);
            }
        } else if ([planChoose isEqualToString:STR_HLAWP]) {
            if ([OccpCat isEqualToString:@"UNEMP"] || [OccpCat isEqualToString:@"JUV"] || [OccpCat isEqualToString:@"STU"] || [OccpCat isEqualToString:@"HSEWIFE"] || [OccpCat isEqualToString:@"RET"] ) {
                _maxRiderSA = fmin(24000, floor(dblPseudoBSA * maxSAFactor));
            } else {
                _maxRiderSA = fmin(200000, dblPseudoBSA * maxSAFactor);
            }            
        }
        
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
        
    } else if ([riderCode isEqualToString:@"CPA"]) {
        if (OccpClass == 1 || OccpClass == 2) {
            if([planChoose isEqualToString:STR_HLACP] || [planChoose isEqualToString:STR_HLAWP])
            {
                if (dblPseudoBSA < 100000) {
                    _maxRiderSA = fmin(dblPseudoBSA3,200000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                } else if (dblPseudoBSA >= 100000) {
                    _maxRiderSA = fmin(dblPseudoBSA4,1000000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                }
            } else if([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
                if (getSumAssured < 100000) {
                    _maxRiderSA = fmin(getSumAssured*5,200000);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                } else if (getSumAssured >= 100000) {
                    _maxRiderSA = fmin(getSumAssured*2,maxSATerm);
                    NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                    maxRiderSA = [a_maxRiderSA doubleValue];
                }
            }
        } else if (OccpClass == 3 || OccpClass == 4) {
            if([planChoose isEqualToString:STR_HLACP] || [planChoose isEqualToString:STR_HLAWP]) {
                _maxRiderSA = fmin(dblPseudoBSA3,100000);
                NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                maxRiderSA = [a_maxRiderSA doubleValue];
            } else if([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
                _maxRiderSA = fmin(getSumAssured *5,100000);
                NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
                maxRiderSA = [a_maxRiderSA doubleValue];
            }
        }
    } else if ([riderCode isEqualToString:@"PA"]) {
        if ([planChoose isEqualToString:STR_HLACP] || [planChoose isEqualToString:STR_HLAWP])
        {
            _maxRiderSA = fmin(5 * dblPseudoBSA,1000000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        } else if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
            _maxRiderSA = fmin(5* getSumAssured,maxSATerm);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
    } else if ([riderCode isEqualToString:@"PTR"]) {
        if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]) {
            _maxRiderSA = fmin(getSumAssured * 5, 500000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        } else {
            _maxRiderSA = fmin(5 * dblPseudoBSA, 500000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
    } else if ([riderCode isEqualToString:@"HB"]) {
               double tempPseudo = 0.00;
        if ([planChoose isEqualToString:STR_HLAWP]) {
            tempPseudo = dblPseudoBSA;
        } else if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100]){
            tempPseudo = getSumAssured;
        }
        
        if (tempPseudo >= 10000 && tempPseudo <= 25000) {
            MaxUnit = 4;
        } else if (tempPseudo >= 25001 && tempPseudo <= 50000) {
            MaxUnit = 6;
        } else if (tempPseudo >= 50001 && tempPseudo <= 75000) {
            MaxUnit = 8;
        } else if (tempPseudo > 75000) {
            MaxUnit = 10;
        } else {
            MaxUnit = 0;
        }
        
        maxRiderSA = MaxUnit;
    } else if ([riderCode isEqualToString:@"ETPDB"]) {
        double max = basicPremAnn * 10;
        _maxRiderSA = fmin(max, maxSATerm);
        maxRiderSA = _maxRiderSA;
    } else if ([riderCode isEqualToString:@"ICR"]) {
        double minOf = -1;
        if ([planChoose isEqualToString:STR_HLACP]) {
            minOf = getSumAssured / 0.05;
            _maxRiderSA = fmin(minOf, 120000);
            
        } else if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100] ) {
            minOf = getSumAssured;
            _maxRiderSA = fmin(minOf, 120000);
            
        } else if ([planChoose isEqualToString:STR_HLAWP]) {            
            _maxRiderSA = MIN(120000, dblPseudoBSA);
            
        }
        
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
        
    } else {
        if ([planChoose isEqualToString:STR_HLAWP] || [planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_S100] )
        {
            if ([riderCode isEqualToString:@"CIR"]||[riderCode isEqualToString:@"LCPR"])
            {
                _maxRiderSA = 4000000 ; // ignore for temp
            } else {
                _maxRiderSA = maxSATerm;
            }
        } else {
            _maxRiderSA = maxSATerm;
        }
        
        if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WBI6R30"]) {        
            if (requestEDD == TRUE) {
                _maxRiderSA = floor((15000 - getSumAssured)/maxGycc * 1000);
            } else {
                _maxRiderSA = MIN(floor(getSumAssured *  maxGycc/1000.00), 9999999) ;
            }
            
        } else if([riderCode isEqualToString:@"EDUWR"])
        {
            if (requestEDD == TRUE) {
                _maxRiderSA = floor((15000 - getSumAssured)/maxGycc * 1000);
            } else {
                _maxRiderSA = getSumAssured * maxGycc/1000;
            }
        } else if([riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"] ) {
            _maxRiderSA = 999999999;
        } else if([riderCode isEqualToString:@"WPTPD30R"] ) {
            double tempAll = 3500000 - [self CalcTPDbenefit : &str excludeSelf:TRUE];
            double tempGrossPrem = 0.00;
            double temps;
            
            if( [LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound){
                temps =  1000000 - [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD50R"]] doubleValue];
                tempGrossPrem = 60 * dblGrossPrem - [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD50R"]] doubleValue];
            } else {
                temps = 1000000;
                tempGrossPrem = 60 * dblGrossPrem;
            }
            
            _maxRiderSA = floor(MIN(tempGrossPrem, MIN(tempAll, temps)));
            
        } else if([riderCode isEqualToString:@"WPTPD50R"]){
            double tempAll = 3500000 - [self CalcTPDbenefit : &str excludeSelf:TRUE];
            double tempGrossPrem = 0.00;
            double temps;
            
            if( [LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound && WPTPD30RisDeleted == FALSE){
                temps = 1000000 - [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD30R"]] doubleValue];
                tempGrossPrem = 60 * dblGrossPrem - [[LSumAssured objectAtIndex:[LRiderCode indexOfObject:@"WPTPD30R"]] doubleValue];
            } else{
                temps = 1000000;
                tempGrossPrem = 60 * dblGrossPrem;
            }
            
            _maxRiderSA = floor(MIN(tempGrossPrem, MIN(tempAll, temps)));
        }
        
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
}

-(void)CalcPrem{        
    PremiumViewController *premView = [self.storyboard instantiateViewControllerWithIdentifier:@"premiumView"];
    premView.requestAge = ageClient;
    premView.requestOccpClass = requestOccpClass;
    premView.requestOccpCode = requestOccpCode;
    premView.requestSINo = getSINo;
    premView.requestMOP = MOP;
    premView.requestTerm = termCover;
    premView.requestBasicSA = yearlyIncomeField.text;
    premView.requestBasicHL = getHL;
    premView.requestBasicTempHL = getTempHL;
    premView.requestPlanCode = planChoose;
    premView.requestBasicPlan = planChoose;
    premView.sex = GenderPP;
    premView.EAPPorSI = [self.EAPPorSI description];
    premView.executeMHI = FALSE;

    premView.fromReport = FALSE;
    
    UIView *zzz = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 0, 0) ];
    [zzz addSubview:premView.view];

    dblGrossPrem = premView.ReturnGrossPrem;
  
    [zzz removeFromSuperview ];
    zzz = Nil;
    premView = Nil;
}

-(double)CalcTPDbenefit : (NSString **)aaMsg excludeSelf : (BOOL)aaExcludeSelf{
    sqlite3_stmt *statement;
    double tempValue = 0.00;
    double tempPrem = 0;
    double tempPremWithoutLoading = 0;
    int count = 1;
    NSMutableString *strRiders = [[NSMutableString alloc] initWithString: @""];
    NSMutableDictionary *tempArray = [[NSMutableDictionary alloc] init];
    NSString *tempCode;
    int getTerm = termCover;
    int getMOP = MOP;
    
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
        
        if (aaExcludeSelf == TRUE) {
            querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', ''),replace(PremiumWithoutHLoading, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'CCTR', 'EDUWR', 'LCPR', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30', 'WPTPD30R', 'WPTPD50R' ) AND SINO = '%@' AND TYPE <> '%@' ", getSINo, riderCode];
        } else {
            querySQL = [NSString stringWithFormat:@"SELECT Type, replace(Annually, ',', ''),replace(PremiumWithoutHLoading, ',', '') FROM SI_STORE_PREMIUM WHERE TYPE in ('B', 'CCTR', 'EDUWR', 'LCPR', 'WB30R', 'WB50R','WBI6R30', 'WBD10R30', 'WPTPD30R', 'WPTPD50R' ) AND SINO = '%@' ", getSINo];
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
                        [strRiders appendFormat:@"%d. %@\n", count, tempCode];
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

    
    return tempValue;
}

-(void) getRiderTermRuleGYCC:(NSString*)rider riderTerm:(int)riderTerm
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
        if (requestEDD == TRUE) {
            querySQL = [NSString stringWithFormat: @"select gycc from SI_Trad_Rider_HLAWP_GYCC where planoption='%@' and PolTerm='%d' and premPayOpt='%d' and StartAge = \"%d\" AND EndAge = \"%d\"", rider,
                        [rider isEqualToString:@"EDUWR"] ? termCover : riderTerm,
                        MOP, -1, -1];
        }
        else{
            querySQL = [NSString stringWithFormat: @"select gycc from SI_Trad_Rider_HLAWP_GYCC where planoption='%@' and PolTerm='%d' and premPayOpt='%d' and StartAge <= \"%d\" AND EndAge >= \"%d\"", rider,
                        [rider isEqualToString:@"EDUWR"] ? termCover : riderTerm,
                        MOP,ageClient,ageClient];
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

-(double)calculateBasic:(double)basicSA Rate:(double)rate withFormatter:(NSNumberFormatter *)formatter {
    double basic;
    if ([planChoose isEqualToString:STR_HLAWP])
    {
        basic = basicSA * rate;
    } else {        
        basic = basicRate * (basicSA/1000) * rate;
    }
    
    NSString *basicStr = [formatter stringFromNumber:[NSNumber numberWithDouble:basic]];
    double basicValue = [[basicStr stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    
    return basicValue;
}

-(double)calculateOccLoading:(double)basicSA Rate:(double)rate PolicyTerm:(int)policyTerm withFormatter:(NSNumberFormatter *)formatter {
    double occpl = 0;
    if ([planChoose isEqualToString:STR_HLAWP]) {
        double factor = 0;
        if(policyTerm == 30) {
            factor = 1.5;
        } else if(policyTerm == 50) {
            factor = 2.5;
        }
        
        occpl = occLoad *factor * basicSA * MOP * rate;
        
    } else if ([planChoose isEqualToString:STR_S100] || [planChoose isEqualToString:STR_L100]) {
        occpl = occLoad * (basicSA/1000) * rate;
        
    } else if ([planChoose isEqualToString:STR_HLAIB]) {
        occpl = occLoad * ((policyTerm + 1)/2) * (basicSA/1000) * rate;
        
    } else if ([planChoose isEqualToString:STR_HLACP]) {
        occpl = occLoad *55 * (basicSA/1000) * rate;
        
    }
    
    NSString *occplStr = [formatter stringFromNumber:[NSNumber numberWithDouble:occpl]];
    double occplValue = [[occplStr stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    return occplValue;
}

-(double)calculateHealthLoading:(double)basicSA Rate:(double)rate BasicHLoad:(double)basicHLoad BasicTempHLoad:(double)basicTempHLoad withFormatter:(NSNumberFormatter *)formatter {
    //calculate basic health loading
    double basicHL = basicHLoad * (basicSA/1000) * rate;
    
    //calculate basic temporary health loading
    double basicTempHL = basicTempHLoad * (basicSA/1000) * rate;
    
    double allHLoading = basicHL + basicTempHL;
    
    NSString *basicHStr = [formatter stringFromNumber:[NSNumber numberWithDouble:allHLoading]];
    double basicHLValue = [[basicHStr stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    
    return basicHLValue;
}

-(double)calculateLSD:(double)basicSA Rate:(double)rate withFormatter:(NSNumberFormatter *)formatter {
    
    double lsd = LSDRate * (basicSA/1000) * rate;
    NSString *lsdStr = [formatter stringFromNumber:[NSNumber numberWithDouble:lsd]];
    
    //for negative value
    lsdStr = [lsdStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
    lsdStr = [lsdStr stringByReplacingOccurrencesOfString:@")" withString:@""];
    double lsdValue = [[lsdStr stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    
    return lsdValue;
}

-(void)calculateBasicPremium
{
    [self getBasicSIRate:ageClient toAge:ageClient];
    NSString *basicTotalA = nil;
    NSString *basicTotalS = nil;
    NSString *basicTotalQ = nil;
    NSString *basicTotalM = nil;
    
    double BasicSA = [yearlyIncomeField.text doubleValue];
    double PolicyTerm = [[self getTerm] doubleValue];
    double BasicHLoad = [getHL doubleValue];
    double BasicTempHLoad = [getTempHL doubleValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //calculate basic premium    
    double BasicAnnually_ = [self calculateBasic:BasicSA Rate:annualRate withFormatter:formatter];
    double BasicHalfYear_ = [self calculateBasic:BasicSA Rate:semiAnnualRate withFormatter:formatter];
    double BasicQuarterly_ = [self calculateBasic:BasicSA Rate:quarterlyRate withFormatter:formatter];
    double BasicMonthly_ = [self calculateBasic:BasicSA Rate:monthlyRate withFormatter:formatter];    
    
    
    //calculate occupationLoading
    double OccpLoadA_ = [self calculateOccLoading:BasicSA Rate:annualRate PolicyTerm:PolicyTerm withFormatter:formatter];
    double OccpLoadH_ = [self calculateOccLoading:BasicSA Rate:semiAnnualRate PolicyTerm:PolicyTerm withFormatter:formatter];
    double OccpLoadQ_ = [self calculateOccLoading:BasicSA Rate:quarterlyRate PolicyTerm:PolicyTerm withFormatter:formatter];
    double OccpLoadM_ = [self calculateOccLoading:BasicSA Rate:monthlyRate PolicyTerm:PolicyTerm withFormatter:formatter];
    
    //calculate basic health loading
    double BasicHLAnnually_ = [self calculateHealthLoading:BasicSA Rate:annualRate BasicHLoad:BasicHLoad BasicTempHLoad:BasicTempHLoad withFormatter:formatter];
    double BasicHLHalfYear_ = [self calculateHealthLoading:BasicSA Rate:semiAnnualRate BasicHLoad:BasicHLoad BasicTempHLoad:BasicTempHLoad withFormatter:formatter];
    double BasicHLQuarterly_ = [self calculateHealthLoading:BasicSA Rate:quarterlyRate BasicHLoad:BasicHLoad BasicTempHLoad:BasicTempHLoad withFormatter:formatter];
    double BasicHLMonthly_ = [self calculateHealthLoading:BasicSA Rate:monthlyRate BasicHLoad:BasicHLoad BasicTempHLoad:BasicTempHLoad withFormatter:formatter];
    
    //calculate LSD
    double LSDAnnually_ = [self calculateLSD:BasicSA Rate:annualRate withFormatter:formatter];
    double LSDHalfYear_ = [self calculateLSD:BasicSA Rate:semiAnnualRate withFormatter:formatter];
    double LSDQuarterly_ = [self calculateLSD:BasicSA Rate:quarterlyRate withFormatter:formatter];
    double LSDMonthly_ = [self calculateLSD:BasicSA Rate:monthlyRate withFormatter:formatter];
    
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
    
    basicTotalA = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalA]];
    basicTotalS = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalS]];
    basicTotalQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalQ]];
    basicTotalM = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalM]];
    
    
    basicPremAnn = [[basicTotalA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremHalf = [[basicTotalS stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremQuar = [[basicTotalQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremMonth = [[basicTotalM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
//    NSLog(@"BBasicPrem:%.2f, S:%.2f, Q:%.2f, M:%.2f",basicPremAnn,basicPremHalf,basicPremQuar,basicPremMonth);
}

#pragma mark - Handle DB

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
                SIDate = lastDate == NULL ? nil : [[NSString alloc] initWithUTF8String:lastDate];
                
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
                              @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"CL\" AND LastUpdated like \"%%%@%%\" ",dateString];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustLastNo = sqlite3_column_int(statement, 0);
                
                const char *lastDate = (const char *)sqlite3_column_text(statement, 1);
                CustDate = lastDate == NULL ? nil : [[NSString alloc] initWithUTF8String:lastDate];                
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
            } else {
                NSLog(@"Failed to update SI.");
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
            } else {
                NSLog(@"Failed to update customer data.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,MinTerm,MaxTerm,MinSA,MaxSA,ExpiryAge FROM Trad_Sys_Mtn WHERE PlanCode=\"%@\"",planChoose];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int minAge =  sqlite3_column_int(statement, 0);
                maxAge =  sqlite3_column_int(statement, 1);
                int maxTermB  =  sqlite3_column_int(statement, 3);
                int expiryAge = sqlite3_column_int(statement, 6);
                
                if([planChoose isEqualToString:STR_HLAWP]) // @Edwin 14-7-2014 <-- totally wrong logic
                {
                    minSA = sqlite3_column_int(statement, 4);   
//                    termCover = maxTermB - ageClient;
                    
                    termCover = getPolicyTerm == 0 ? 30 : getPolicyTerm; //30 is the default term for HLAWP
                    if (getPolicyTerm == 0) {
                            MOPSegment.selectedSegmentIndex = 0; // default mop is 30 for HLAWP
                    }
                    
                    
                    if(_policyTermSeg.selectedSegmentIndex == 1)
                    {
                        maxAge = 45;
                        minSA = 1800;
                    }
                    else if(_policyTermSeg.selectedSegmentIndex == 0)
                    {
                        if(MOPSegment.selectedSegmentIndex == 0) // 6 
                        {
                            if(ageClient==63)
                            { 
                                minSA = 1500;
                            }
                            else if(ageClient==64)
                            {
                                minSA = 1600;
                            }
                            else if(ageClient==65)
                            {
                                minSA = 1700;
                            }
                        }
                        else if(MOPSegment.selectedSegmentIndex == 1)
                        {
                            minSA = 1500;
                        }
                    }
                }
				
				maxSA = sqlite3_column_int(statement, 5);
                
                if ([planChoose isEqualToString:STR_HLAIB])
                {
                    if (ageClient > 40) {
                        minSA = sqlite3_column_int(statement, 4);
                    }
                    else{
                        minSA = 1200;
                    }
                    termCover = maxTermB - ageClient;
                } else if ([planChoose isEqualToString:STR_HLACP])
                {
                    if (ageClient > 40) {
                        minSA = sqlite3_column_int(statement, 4);
                    }
                    else{
                        minSA = 1200;
                    }
                    termCover = maxTermB;
                } else if ([planChoose isEqualToString:STR_L100])
                {
                    minSA = sqlite3_column_int(statement, 4);
                    termCover = expiryAge - ageClient;
                    maxSA = sqlite3_column_double(statement, 5);
                    
                    if (MOP == 1) {
                        [MOPSegment setSelectedSegmentIndex:0];
                    }
                    else{
                        [MOPSegment setSelectedSegmentIndex:1];
                    }
                    
                } else if ([planChoose isEqualToString:STR_S100]) {
                    
                    minSA = sqlite3_column_int(statement, 4);
                    termCover = expiryAge - ageClient;
                    [MOPSegment setSelectedSegmentIndex:(MOPSegment.numberOfSegments)];
                    for (int i=MOPSegment.numberOfSegments-1; --i>=0; ) {
                        if ([[MOPSegment titleForSegmentAtIndex:i] rangeOfString:[NSString stringWithFormat:@"%d", MOP]].location != NSNotFound) {
                            [MOPSegment setSelectedSegmentIndex:i+1];
                            break;
                        }
                    }
                }
                
//                else
//                {
//                    termCover = 0;
//                }
                termField.text = [[NSString alloc] initWithFormat:@"%d",termCover];
                
                if (ageClient < minAge) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Age Last Birthday must be greater than or equal to %d for this product.",minAge] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    alert.tag = 1011;
                    [alert show];
                } else if (ageClient > maxAge) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Age Last Birthday must be less than or equal to %d for this product.",maxAge] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    alert.tag = 1010;
                    [alert show];
                }
                
//            } else {
//                NSLog(@"Error accessing term rules.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkingExisting
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SINo FROM Trad_Details WHERE SINo=\"%@\"",SINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
//            } else {
//                NSLog(@"error access Trad_Details");
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

-(void)getExistingBasic:(BOOL) fromViewLoad
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT SINo, PlanCode, PolicyTerm, BasicSA, PremiumPaymentOption, CashDividend, YearlyIncome, AdvanceYearlyIncome,HL1KSA, HL1KSATerm, TempHL1KSA, TempHL1KSATerm,PartialAcc,PartialPayout,QuotationLang FROM Trad_Details WHERE SINo=\"%@\"",SINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                if([planChoose length]==0)
                    planChoose = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                prevPlanChoose =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                getPolicyTerm = sqlite3_column_int(statement, 2);
                getSumAssured = sqlite3_column_double(statement, 3);
                MOP = sqlite3_column_int(statement, 4);
                if( [planChoose isEqualToString:STR_HLACP] || [planChoose isEqualToString:STR_HLAWP])
                {
                    if([cashDividend length]>0 && ![cashDividend isEqualToString:@"(null)"])
                    {
                        //do nothing
                    }else
                    {
                        cashDividend = [[NSString alloc ] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                    }
                }
                
                yearlyIncome = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                advanceYearlyIncome = sqlite3_column_int(statement, 7);
                ModeOfPayment = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                
                const char *getHL2 = (const char*)sqlite3_column_text(statement, 8);
                getHL = getHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getHL2];
                getHLTerm = sqlite3_column_int(statement, 9);
                
                const char *getTempHL2 = (const char*)sqlite3_column_text(statement, 10);
                getTempHL = getTempHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getTempHL2];
                getTempHLTerm = sqlite3_column_int(statement, 11);
                
                if( [planChoose isEqualToString:STR_HLACP] || [planChoose isEqualToString:STR_HLAWP])
                {
                    if( (![parAccField.text isEqualToString:@"0"] && ![parAccField.text isEqualToString:@""])
                       || (![parPayoutField.text isEqualToString:@"0"] && ![parPayoutField.text isEqualToString:@""]) )
                    {
                        getParAcc = [parAccField.text intValue];
                        getParPayout = [parPayoutField.text intValue];
                    }else
                    {
                        getParAcc = sqlite3_column_int(statement, 12);
                        getParPayout = sqlite3_column_int(statement, 13);
                    }
                }
				
                if(sqlite3_column_text(statement, 14) == NULL)
                {
                    quotationLang = nil;
                }else
                {
                    if(fromViewLoad)
                    {
                        quotationLang = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
                    }else
                    {
                        if(_quotationLangSegment.selectedSegmentIndex == 0)
                        {
                            quotationLang = @"English";
                        }else
                            if(_quotationLangSegment.selectedSegmentIndex == 1)
                            {
                                quotationLang = @"Malay";
                            }
                    }
                }
				
//                NSLog(@"basicPlan:%@",planChoose);
                
//            } else {
//                NSLog(@"Error accessing existing basic plan.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(NSString*) getTerm
{
    NSString *term = nil;
    if([planChoose isEqualToString:STR_HLAWP])
    {
        term = [NSString stringWithFormat:@"%d",policyTermSegInt];
    }else
    {
        term = termField.text;
    }
    return term;
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
//    NSLog(@"saveBasicPlan SINo:%@, CustCode:%@",SINo,LACustCode);
    
	NSString *AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Trad_Details (SINo,  PlanCode, PTypeCode, Seq, PolicyTerm, BasicSA, "
							   "PremiumPaymentOption, CashDividend, YearlyIncome, AdvanceYearlyIncome, HL1KSA, HL1KSATerm, "
							   "TempHL1KSA, TempHL1KSATerm, CreatedAt,UpdatedAt,PartialAcc,PartialPayout, QuotationLang, SIVersion, SIStatus) "
							   "VALUES (\"%@\", \"%@\", \"LA\", \"1\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", "
							   "\"%d\", \"%@\", \"%d\", %@ , %@,%d,%d, \"%@\", '%@', '%@')",
							   SINo, planChoose, [self getTerm], yearlyIncomeField.text, MOP, cashDividend, yearlyIncome,
							   ModeOfPayment, HLField.text, [HLTermField.text intValue], tempHLField.text,
							   [tempHLTermField.text intValue], @"datetime(\"now\", \"+8 hour\")",@"datetime(\"now\", \"+8 hour\")",
							   [parAccField.text intValue],[parPayoutField.text intValue], quotationLang, AppsVersion, @"INVALID"];
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self updateLA];
                
                //[self getPlanCodePenta];
				
                prevPlanChoose = planChoose;
                
                if (PayorIndexNo != 0) {
					IndexNo = PayorIndexNo;
					[self getProspectData];
                    [self savePayor];
                }
                
				
                if (secondLAIndexNo != 0) {
					IndexNo = secondLAIndexNo;
					[self getProspectData];
                    [self saveSecondLA]; 
                }
                
                [_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose planName:(NSString *)btnPlan.titleLabel.text];
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.SICompleted = YES;
                
            }
            else {
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    appDelegate.isSIExist = YES;
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
                               @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) "
							   "VALUES (\"%@\",\"%@\",\"PY\",\"1\",\"%@\",\"hla\")",SINo, PYCustCode,dateStr];
        
        //NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
            }
            sqlite3_finalize(statement);
        }
        
        int ANB =PayorAge + 1;
        NSString *insertSQL2 = [NSString stringWithFormat:
                                @"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) "
								"VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",
								PYCustCode, NamePP, PayorSmoker, PayorSex, PayorDOB, PayorAge, ANB, PayorOccpCode, dateStr,PayorIndexNo];
		
		//        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {                
            }
            sqlite3_finalize(statement);
        }
        
        
        sqlite3_close(contactDB);
    }
}

-(void) forceClean2ndLA:(NSString*)custCode //function developed by Edwin @ 26-03-2014 to forcefully clean the remnants of 2nd LA to be replaced
{
    NSString *sqlTradLApayor = [NSString stringWithFormat:@"delete from trad_laPayor where sino=\"%@\" and sequence='2'", SINo];
    NSString *sqlCltProf = [NSString stringWithFormat:@"delete from clt_profile where CustCode=\"%@\"", custCode];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [sqlTradLApayor UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {                
            } else {
                NSLog(@"Failed to delete second Life Assured.");
            }
            sqlite3_finalize(statement);
        }
        
        if (sqlite3_prepare_v2(contactDB, [sqlCltProf UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
            } else {
                NSLog(@"Failed to delete second Life Assured from client profile");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in deleting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}

-(NSString*) getCustCode:(NSString*)currentDate
{
    int runningNoCust = CustLastNo;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
	
    NSString *custcode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentDate,fooCust];
    
    return custcode;
}


-(void)saveSecondLA
{
    [self getRunningCustCode];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];

    [dateFormatter setDateFormat:@"yyyyMMdd"];    
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoCust = CustLastNo + 1;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
	
    secondLACustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    //[self forceClean2ndLA:[self getCustCode:currentdate]];

    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"LA\",\"2\",\"%@\",\"hla\")",SINo, secondLACustCode,dateStr];
        
        //NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
            }
            sqlite3_finalize(statement);
        }
        
        int ANB = secondLAAge + 1;
        NSString *insertSQL2 = [NSString stringWithFormat:
								@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) "
								"VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",
								secondLACustCode, NamePP, secondLASmoker, [secondLASex substringToIndex:1], secondLADOB, secondLAAge,
								ANB, secondLAOccpCode, dateStr,secondLAIndexNo];
        
        //NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
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
                              @"UPDATE Clt_Profile SET CustCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\" WHERE id=\"%d\"",LACustCode,currentdate,idProf];
        
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
							   @"UPDATE Trad_LAPayor SET SINo=\"%@\", CustCode=\"%@\", DateModified=\"%@\", "
							   "ModifiedBy=\"hla\" WHERE rowid=\"%d\"", SINo,LACustCode,currentdate,idPay];
        
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

-(int)ReturnPaymentTerm :(NSString *)aaPlanChosen {
    if ([aaPlanChosen isEqualToString:STR_L100]) {
        return MOPSegment.selectedSegmentIndex == 0 ? 1 : 5;
    } else if ([aaPlanChosen isEqualToString:STR_S100]) {
        return MOP;
    } else if ([aaPlanChosen isEqualToString:STR_HLAWP]) {
        return MOPSegment.selectedSegmentIndex == 0 ? 6 : 10;
    } else{
        return 0;
    }
}

-(BOOL)updateBasicPlan
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        
        //[self getTermRule];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET PlanCode=\"%@\", PolicyTerm=\"%@\", BasicSA=\"%@\", PremiumPaymentOption=\"%d\", CashDividend=\"%@\", YearlyIncome=\"%@\", AdvanceYearlyIncome=\"%@\", UpdatedAt=%@, PartialAcc=\"%d\", PartialPayout=\"%d\" , QuotationLang=\"%@\" WHERE SINo=\"%@\"", planChoose, [self getTerm], yearlyIncomeField.text, [self ReturnPaymentTerm:planChoose], cashDividend, yearlyIncome,ModeOfPayment, @"datetime(\"now\", \"+8 hour\")",[parAccField.text intValue],[parPayoutField.text intValue], quotationLang, SINo];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                prevPlanChoose = planChoose;
//                NSLog(@"BasicPlan update!  %@",querySQL);
                [self getPlanCodePenta];
                
                if([planChoose isEqualToString:STR_HLAWP]) {
                    termCover = policyTermSegInt;
                }
                
                [_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose planName:(NSString *)btnPlan.titleLabel.text];
                
                if ([planChoose isEqualToString:STR_L100] || [planChoose isEqualToString:STR_HLAWP] || [planChoose isEqualToString:STR_S100]) {
                    getSumAssured = [yearlyIncomeField.text doubleValue];
                }
            } else {
//                NSLog(@"BasicPlan update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                return NO;
            }
            sqlite3_finalize(statement);
            
        }

        sqlite3_close(contactDB);
    }
    
    if ([planChoose isEqualToString:STR_HLAWP]) {
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
            NSString *querySQL;
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET RiderTerm=\"%@\", payingTerm = '%@' WHERE SINo=\"%@\" AND RiderCode in ('HMM', 'MG_IV')", [self getTerm],[self getTerm], SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET RiderTerm=\"%d\", payingTerm = '%d' WHERE SINo=\"%@\" AND RiderCode = 'CPA'",
                        (65 - ageClient) > [[self getTerm] intValue] ? [[self getTerm] intValue]: (65 - ageClient) , MIN([[self getTerm] intValue], (65 - ageClient)), SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET RiderTerm=\"%d\", payingTerm = '%d' WHERE SINo=\"%@\" AND RiderCode = 'PA'",
                        MIN([[self getTerm] intValue], (75 - ageClient)) , MIN([[self getTerm] intValue], (75 - ageClient)), SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET RiderTerm=\"%d\", payingTerm = '%d' WHERE SINo=\"%@\" AND RiderCode in ('MG_II', 'HSP_II') ",
                        MIN((70 - ageClient), [[self getTerm] intValue]), MIN((70 - ageClient), [[self getTerm] intValue]),  SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET RiderTerm=\"%d\", payingTerm = '%d' WHERE SINo=\"%@\" AND RiderCode in ('HB') ",
                        MIN((60 - ageClient), [[self getTerm] intValue]), MIN((60 - ageClient), [[self getTerm] intValue]),  SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            
            querySQL = [NSString stringWithFormat:@"UPDATE Trad_Rider_Details SET payingTerm='%d' WHERE SINo=\"%@\" AND RiderCode in ('EDUWR','WB30R','WB50R','WBI6R30','WBD10R30') ", MOP, SINo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {                    
                }                
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
    }

    [self getListingRider];
    
    if ([LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound ||
        [LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound ||
        [LRiderCode indexOfObject:@"LCPR"] != NSNotFound ||
        [LRiderCode indexOfObject:@"PLCP"] != NSNotFound ||
        [LRiderCode indexOfObject:@"ACIR_MPP"] != NSNotFound ||
        [LRiderCode indexOfObject:@"CCTR"] != NSNotFound ||
        [LRiderCode indexOfObject:@"CIR"] != NSNotFound ||
        [LRiderCode indexOfObject:@"ICR"] != NSNotFound ) {
        [self CalcPrem];
    }
    
    NSString *strRiders = @"";
    BOOL onlyTPDRiders = FALSE;
    BOOL WBTPDRidersExist = FALSE;
    
    if ([LRiderCode indexOfObject:@"WPTPD30R"] != NSNotFound || [LRiderCode indexOfObject:@"WPTPD50R"] != NSNotFound) {        
        WBTPDRidersExist = TRUE;
        
        if ([LRiderCode indexOfObject:@"WB30R"] == NSNotFound &&
            [LRiderCode indexOfObject:@"WB50R"] == NSNotFound &&
            [LRiderCode indexOfObject:@"EDUWR"] == NSNotFound &&
            [LRiderCode indexOfObject:@"WBI6R30"] == NSNotFound &&
            [LRiderCode indexOfObject:@"WBD10R30"] == NSNotFound &&
            [LRiderCode indexOfObject:@"LCPR"] == NSNotFound &&
            [LRiderCode indexOfObject:@"CCTR"] == NSNotFound ) {
            onlyTPDRiders = TRUE;
        }        
    }    

    if (onlyTPDRiders == FALSE && WBTPDRidersExist == TRUE) {
        if ([self CalcTPDbenefit : &strRiders excludeSelf:FALSE] > 3500000) {
            NSString *msg = [NSString stringWithFormat:@"TPD Benefit Limit per Life for 1st Life Assured has exceeded RM3.5mil. "
                             "Please revise the RSA of Wealth TPD Protector or revise the RSA of the TPD related rider(s) below:\n %@", strRiders];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Basic"
                                                            message:msg delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
            [alert show ];
            [_delegate SwitchToRiderTab];
            return NO;
        }
    }
    
    if ([self validateExistingRider] == TRUE) {
        return YES;
    } else {
        return NO;
    }
}

-(void)checkExistRider
{
    arrExistRiderCode = [[NSMutableArray alloc] init];
    arrExistPlanChoice = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT RiderCode, PlanOption FROM Trad_Rider_Details WHERE SINo=\"%@\" and SEQ not in ('2')",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [arrExistRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                [arrExistPlanChoice addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)deleteRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" and SEQ not in ('2') ",getSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {                
            } else {
                NSLog(@"Failed to delete riders from SI:%@",SINo);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    [_delegate RiderAdded];
}

-(BOOL)validateExistingRider
{    
    BOOL dodelete = NO;
    int RTerm;
    
    double riderSA;
    int riderUnit;
    int HL1kTerm;
    int HL100Term;
    int HLPTerm;
    int HLTempTerm;
    
    int maxRiderTerm;
    if (LRiderCode.count > 0) {
        [self getLSDRate];
        [self getOccLoad];
        [self calculateBasicPremium];
    }
    
    int tempMaxRiderTerm = 0;
    for (int p=0; p<LRiderCode.count; p++) {
        riderCode = [LRiderCode objectAtIndex:p];
        tempMaxRiderTerm = [self calculateTerm];
        if (tempMaxRiderTerm > maxRiderTerm) {
            maxRiderTerm = tempMaxRiderTerm;
        }
    }
    
    for (int p=0; p<LRiderCode.count; p++) {
        riderCode = [LRiderCode objectAtIndex:p];
        RTerm = [[LTerm objectAtIndex:p] integerValue];
        
        if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WBI6R30"] || [riderCode isEqualToString:@"EDUWR"] )
        {
            [self getRiderTermRuleGYCC:riderCode riderTerm:RTerm];
        }
        
        [self getRiderTermRule];
        tempMaxRiderTerm = [self calculateTerm];
//        NSLog(@"rider: %@  RTerm: %d  MAXterm:%d   tempMaxRiderTerm:%d", riderCode, RTerm, maxRiderTerm, tempMaxRiderTerm);
        [self calculateSA];
        
        riderSA = [[LSumAssured objectAtIndex:p] doubleValue];
        riderUnit = [[LUnits objectAtIndex:p] intValue];
        HL1kTerm = [[LRidHL1KTerm objectAtIndex:p] intValue];
        HL100Term = [[LRidHL100Term objectAtIndex:p] intValue];
        HLPTerm = [[LRidHLPTerm objectAtIndex:p] intValue];
        HLTempTerm = [[LTempRidHL1KTerm objectAtIndex:p] intValue];
        
        if (RTerm > termCover) {
            dodelete = YES;
            [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
        } else if ([riderCode isEqualToString:@"LCWP"] || [riderCode isEqualToString:@"PR"] || [riderCode isEqualToString:@"SP_PRE"] || [riderCode isEqualToString:@"SP_STD"]) {
            if (RTerm > maxRiderTerm) {
                dodelete = YES;
                [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
            }
        } else if (RTerm > tempMaxRiderTerm && !([riderCode isEqualToString:@"PLCP"] || [riderCode isEqualToString:@"PTR"])) {
            dodelete = YES;
            [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
        }
        
        if ([planChoose isEqualToString:STR_HLAWP] &&
            ([riderCode isEqualToString:@"WB30R"] ||
             [riderCode isEqualToString:@"WB50R"] ||
             [riderCode isEqualToString:@"WBD10R30"] ||
             [riderCode isEqualToString:@"WBI6R30"] ||
             [riderCode isEqualToString:@"EDUWR"] ||
             [riderCode isEqualToString:@"WP30R"] ||
             [riderCode isEqualToString:@"WP50R"] ||
             [riderCode isEqualToString:@"WPTPD30R"] ||
             [riderCode isEqualToString:@"WPTPD50R"])) {
            if (HL1kTerm > 0) {
                if(HL1kTerm > MOP){
                    dodelete = YES;
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            }
            
            if (HLTempTerm > 0) {
                if(HLTempTerm > MOP){
                    dodelete = YES;
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            }
        
        } else { // not using MOP
            if (HL1kTerm > 0) {
                if(HL1kTerm > termCover) {
                    dodelete = YES;                    
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            } else if (HL100Term > 0) {
                if(HL100Term > termCover) {
                    dodelete = YES;
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            } else if (HLPTerm > 0) {
                if(HLPTerm > termCover) {
                    dodelete = YES;
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            }
            
            if (HLTempTerm > 0) {
                if(HLTempTerm > termCover) {
                    dodelete = YES;
                    [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
                }
            }
        }
        
        if (riderSA > [RiderViewController getRoundedSA:maxRiderSA]) {
            dodelete = YES;
            [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
            if ([riderCode isEqualToString:@"WPTPD30R"]) {
                WPTPD30RisDeleted = TRUE;
            }            
        }
        
        if (riderUnit > maxRiderSA) {
            dodelete = YES;
            [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
        }
        
        if( [planChoose isEqualToString:STR_S100] || [planChoose isEqualToString:STR_L100]) {
            if (getSumAssured < 500000 && [[LPlanOpt objectAtIndex:p] isEqualToString:@"HMM_1000"]) {
                dodelete = YES;
                [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];                
            }
            
            if( [[LRiderCode objectAtIndex:p] isEqualToString:@"ACIR_MPP"] && riderSA > [yearlyIncomeField.text doubleValue] ) {
                dodelete = YES;
                [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
            }
        } else if ( [planChoose isEqualToString:STR_HLAWP] && (getSumAssured * MOP * [self getBasicSAFactor]) < 500000 && [[LPlanOpt objectAtIndex:p] isEqualToString:@"HMM_1000"]) {
            dodelete = YES;
            [self deleteSpecificRider:requestSINo WithRiderCode:riderCode];
        }
        
    }
    
    if (dodelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_delegate RiderAdded];
        return FALSE;
    }
    
    return TRUE;
}

-(void)deleteSpecificRider:(NSString *)SiNo  WithRiderCode:(NSString *)triderCode {
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",SiNo,triderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
            } else {
                NSLog(@"Failed to delete rider:%@.",triderCode);
            }
            sqlite3_finalize(statement);
        }
        
        if ([triderCode isEqualToString:@"PR"]) {
            // remove PTR as well
            querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"PTR\"",SiNo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    NSLog(@"Successfully deleted rider:PTR.");
                }
                sqlite3_finalize(statement);
            }
        } else if ([triderCode isEqualToString:@"LCWP"]) {
            // remove PLCP as well
            querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"PLCP\"",SiNo];
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    NSLog(@"Successfully deleted rider:PLCP.");
                }
                sqlite3_finalize(statement);
            }
            
        }
        sqlite3_close(contactDB);
    }
}

-(void)getPlanCodePenta
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = nil;
        if ([planChoose isEqualToString:STR_HLAIB]) {
            querySQL = [NSString stringWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",planChoose, MOP];
        } else {
            querySQL = [NSString stringWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\"",planChoose];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW)  {
                planCode =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
//                NSLog(@"Error accessing Penta Plan Code.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getProspectData //to get name for payor or second LA from prospect_profile
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode FROM prospect_profile WHERE IndexNo= \"%d\"",IndexNo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NamePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DOBPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                GenderPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                OccpCodePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                
            } else {
                NSLog(@"Error accessing prospect profile.");
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
    LOccpCode = [[NSMutableArray alloc] init];
    LTempRidHL1K = [[NSMutableArray alloc] init];
    LRidHL1KTerm = [[NSMutableArray alloc] init];
    LRidHL100Term = [[NSMutableArray alloc] init];
    LRidHLPTerm = [[NSMutableArray alloc] init];
    LTempRidHL1KTerm = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, a.HL100SA, a.HLPercentage, c.Smoker, c.Sex, c.ALB, c.OccpCode, a.TempHL1KSA, a.HL1KSATerm, a.HL100SATerm, a.HLPercentageTerm, a.TempHL1KSATerm FROM Trad_Rider_Details a, Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode AND a.SINo=b.SINo AND a.SINo=\"%@\" ORDER by a.RiderCode asc",SINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            const char *aaRidCode;
            const char *aaRidSA;
            const char *aaTerm;
            const char *zzplan;
            const char *aaUnit;
            const char *deduct2;
            double ridHL;
            double ridHL100;
            double ridHLP;
            double TempridHL;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                aaRidCode = (const char *)sqlite3_column_text(statement, 0);
                [LRiderCode addObject:aaRidCode == NULL ? @"" : [[NSString alloc] initWithUTF8String:aaRidCode]];
                
                aaRidSA = (const char *)sqlite3_column_text(statement, 1);
                [LSumAssured addObject:aaRidSA == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaRidSA]];
                
                aaTerm = (const char *)sqlite3_column_text(statement, 2);
                [LTerm addObject:aaTerm == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaTerm]];
                
                zzplan = (const char *) sqlite3_column_text(statement, 3);
                [LPlanOpt addObject:zzplan == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzplan]];
                
                aaUnit = (const char *)sqlite3_column_text(statement, 4);
                [LUnits addObject:aaUnit == NULL ? @"" :[[NSString alloc] initWithUTF8String:aaUnit]];
                
                deduct2 = (const char *) sqlite3_column_text(statement, 5);
                [LDeduct addObject:deduct2 == NULL ? @"" :[[NSString alloc] initWithUTF8String:deduct2]];
                
                ridHL = sqlite3_column_double(statement, 6);
                [LRidHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL]];
                
                ridHL100 = sqlite3_column_double(statement, 7);
                [LRidHL100 addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL100]];
                
                ridHLP = sqlite3_column_double(statement, 8);
                [LRidHLP addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHLP]];
                
                [LSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
                [LSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
                [LAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
                [LOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)]];
                
                TempridHL = sqlite3_column_double(statement, 13);
                [LTempRidHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",TempridHL]];
                
                [LRidHL1KTerm addObject:[[NSString alloc] initWithFormat:@"%.2f", sqlite3_column_double(statement, 14)]];
                
                [LRidHL100Term addObject:[[NSString alloc] initWithFormat:@"%.2f",sqlite3_column_double(statement, 15)]];
                
                [LRidHLPTerm addObject:[[NSString alloc] initWithFormat:@"%.2f",sqlite3_column_double(statement, 16)]];
                
                [LTempRidHL1KTerm addObject:[[NSString alloc] initWithFormat:@"%.2f",sqlite3_column_double(statement, 17)]];
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getRiderTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,ExpiryAge,MinTerm,MaxTerm,MinSA,MaxSA,MaxSAFactor FROM Trad_Sys_Rider_Mtn WHERE RiderCode=\"%@\"",riderCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                expAge =  sqlite3_column_int(statement, 2);
                minTerm =  sqlite3_column_int(statement, 3);
                maxTerm =  sqlite3_column_int(statement, 4);
                minSATerm = sqlite3_column_int(statement, 5);
                maxSATerm = sqlite3_column_int(statement, 6);
                maxSAFactor = sqlite3_column_double(statement, 7);  
//                NSLog(@"expiryAge(%@):%d,minTerm:%d,maxTerm:%d,minSA:%d,maxSA:%d",riderCode,expAge,minTerm,maxTerm,minSATerm,maxSATerm);
                
            } else {
                NSLog(@"Error accessing Rider Term Rule.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(int) getMaxRiderTerm:(NSString*)RiderCode {
    int tempMaxTerm = 0;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL;
        if ([riderCode isEqualToString:@"CIWP"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"ACIR_MPP\" AND RiderCode !=\"CIR\" AND RiderCode !=\"ICR\" AND RiderCode !=\"LCPR\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"PR\" AND RiderCode !=\"SP_PRE\" AND RiderCode !=\"SP_STD\" AND RiderCode !=\"WB30R\" AND RiderCode !=\"WB50R\" AND RiderCode !=\"EDUWR\" AND RiderCode !=\"WBI6R30\" AND RiderCode !=\"WBD10R30\" AND RiderCode !=\"WP30R\" AND RiderCode !=\"WP50R\" AND RiderCode !=\"WPTPD30R\" AND RiderCode !=\"WPTPD50R\"", getSINo ];
            
        } else if ([riderCode isEqualToString:@"LCWP"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"PLCP\"", getSINo ];
        } else if ([riderCode isEqualToString:@"PR"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"PR\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"PTR\"", getSINo ];
        } else if ([riderCode isEqualToString:@"SP_PRE"] || [riderCode isEqualToString:@"SP_STD"]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"SP_STD\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"SP_PRE\"", getSINo ];
        } else {
            querySQL = [NSString stringWithFormat:
                        @"SELECT  max(RiderTerm) as term FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode !=\"I20R\" AND RiderCode !=\"I30R\" AND RiderCode !=\"I40R\" AND RiderCode !=\"ID20R\" AND RiderCode !=\"ID30R\" AND RiderCode !=\"ID40R\" AND RiderCode !=\"CIWP\" AND RiderCode !=\"LCWP\" AND RiderCode !=\"PR\" AND RiderCode !=\"PLCP\" AND RiderCode !=\"PTR\" AND RiderCode !=\"SP_STD\" AND RiderCode !=\"SP_PRE\" AND RiderCode !=\"IE20R\" AND RiderCode !=\"IE30R\" AND RiderCode !=\"EDB\" AND RiderCode !=\"ETPDB\" AND RiderCode not in ('WB30R','WB50R','EDUWR','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R') ",getSINo];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempMaxTerm = sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return tempMaxTerm;
    
}

-(int)calculateTerm
{
    int minus = -1000;//exaggeration easier for debugging
    
    minus = ageClient;
    int maxRiderTerm;
    
    int period = expAge - minus;
    int period2 = 80 - minus;
    double age1 = fmin(period2, 60);
    int storedMaxTerm = 0;
    
    if ([riderCode isEqualToString:@"CIWP"]) {
        
        storedMaxTerm = [self getMaxRiderTerm:riderCode];
        double maxRiderTerm1 = fmin(period, termCover);
        double maxRiderTerm2 = fmax(MOP,storedMaxTerm);
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
        
    } else if ([riderCode isEqualToString:@"LCWP"]||[riderCode isEqualToString:@"PR"]||[riderCode isEqualToString:@"PLCP"]||
             [riderCode isEqualToString:@"PTR"]||[riderCode isEqualToString:@"SP_STD"]||[riderCode isEqualToString:@"SP_PRE"]) {
        [self getMaxRiderTerm : riderCode];
        double maxRiderTerm1 = fmin(termCover,age1);
        double maxRiderTerm2 = fmax(MOP,storedMaxTerm);
        
        maxRiderTerm = fmin(maxRiderTerm1,maxRiderTerm2);
        if (maxRiderTerm < minTerm) {
            maxRiderTerm = maxTerm;
        }
        
        if (([riderCode isEqualToString:@"PLCP"] || [riderCode isEqualToString:@"PTR"]) && maxRiderTerm > maxTerm) {
            maxRiderTerm = maxTerm;
        }
    } else if ([riderCode isEqualToString:@"ID20R"]||[riderCode isEqualToString:@"ID30R"]||[riderCode isEqualToString:@"ID40R"]||[riderCode isEqualToString:@"MG_II"]||[riderCode isEqualToString:@"MG_IV"]||[riderCode isEqualToString:@"HB"]||[riderCode isEqualToString:@"HSP_II"]||[riderCode isEqualToString:@"CPA"]||[riderCode isEqualToString:@"PA"]||[riderCode isEqualToString:@"HMM"]) {
        int getTerm = termCover;
        
            if ([riderCode isEqualToString:@"MG_II"] || [riderCode isEqualToString:@"HSP_II"] ) {
                maxRiderTerm = MIN(getTerm, 70 - ageClient);
            } else if ([riderCode isEqualToString:@"MG_IV"] || [riderCode isEqualToString:@"HMM"] ) {
                maxRiderTerm = getTerm;
            } else if ([riderCode isEqualToString:@"CPA"]  ) {
                maxRiderTerm = MIN(getTerm, 65 - ageClient);
            } else if ([riderCode isEqualToString:@"HB"]  ) {
                maxRiderTerm = MIN(getTerm, 60 - ageClient);
            } else if ([riderCode isEqualToString:@"PA"]  ) {
                maxRiderTerm = MIN(getTerm, 75 - ageClient);
            } else {
                maxRiderTerm = fmin(period, termCover);
            }
        
    } else if([riderCode isEqualToString:@"WB30R"] || [riderCode isEqualToString:@"WB50R"] || [riderCode isEqualToString:@"WBI6R30"]
       || [riderCode isEqualToString:@"WBD10R30"] || [riderCode isEqualToString:@"WP30R"] || [riderCode isEqualToString:@"WP50R"]
       || [riderCode isEqualToString:@"WPTPD30R"] || [riderCode isEqualToString:@"WPTPD50R"] ) {
        maxRiderTerm = maxTerm;
    } else if ([riderCode isEqualToString:@"ICR"] || [riderCode isEqualToString:@"TPDYLA"] || [riderCode isEqualToString:@"CIR"]) {
        maxRiderTerm = fmax(period, termCover);
    } else {
        maxRiderTerm = fmin(period, termCover);
    }
    return maxRiderTerm;
}

-(void)getBasicSIRate:(int)fromAge toAge:(int)toAge
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        NSString *sexStr;
        
        if( [sex isEqualToString:@"FEMALE"] )
        {
            sexStr = @"F";
        } else if( [sex isEqualToString:@"MALE"] ) {
            sexStr = @"M";
        } else {
            sexStr = sex;
        }
        
        if([planChoose isEqualToString:STR_HLACP])
        {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\"",planChoose];
        } else if([planChoose isEqualToString:STR_L100]) {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND Sex=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" ",planChoose,sexStr,fromAge,toAge];
        } else if([planChoose isEqualToString:STR_S100]) {
            int premPayOpt = 100;
            if (MOP != 100 - ageClient) {
                premPayOpt = MOP;
            }
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND Sex=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" AND PremPayOpt=\"%d\" ",planChoose,sexStr,fromAge,toAge, premPayOpt];
        } else if([planChoose isEqualToString:STR_HLAWP]) {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" and FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND PremPayOpt=\"%d\" ",
                planChoose,fromAge,toAge,termCover,termCover,MOP];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Basic SI Rate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getOccLoad
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Class, PA_CPA, OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",OccpCode];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occCPA_PA  = sqlite3_column_int(statement, 0);
                occLoad =  sqlite3_column_int(statement, 1);
                
            } else {
                NSLog(@"Error accessing Occupational Loading.");
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
                NSLog(@"Error accessing Occupational Loading Rider.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getLSDRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%@\" AND ToSA >= \"%@\"",planChoose,yearlyIncomeField.text,yearlyIncomeField.text];
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                LSDRate =  sqlite3_column_double(statement, 0);
                
            } else {
                NSLog(@"Error accessing LSD Rate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//---

-(void)getHLAWPRiderRate:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\"",RidCode,aaterm,fromAge,toAge,MOP];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getHLAWPRiderRateNonGYI:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\" and sex='%@'",RidCode,aaterm,fromAge,toAge,MOP,sex];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing non GYI Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateSex:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND PremPayOpt=\"%d\" AND Sex=\"%@\" ",RidCode,aaterm,fromAge,toAge,MOP,sex];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(double) getFormattedRates:(NSString *) ratesStr
{
    NSString *newString = [ratesStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    double d = [newString doubleValue];   
    
    return d;
}

-(void)getRiderRateSex:(NSString *)aaplan
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromMortality=0 AND Sex=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,sex,age,age];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAge:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,aaterm,aaterm,age,age];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Rider rate.");
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
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" ",RidCode,aaterm,fromAge,toAge,sex];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

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
        } else {
            entryAgeGrp = @"1";
        }
        int subClass;
        if(OccpClass == 2)
        {
            subClass = 1;
        } else {
            subClass = OccpClass;
        }
        
        planOption2 = [planOption2 stringByReplacingOccurrencesOfString:@"IVP_" withString:@""];
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate, \"FromAge\", \"ToAge\" FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\" AND EntryAgeGroup=\"%@\"", RidCode,fromAge,toAge,sex, subClass, planOption2, entryAgeGrp];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
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
                              @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\"", RidCode,fromAge,toAge,sex, OccpClass, planOption2];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
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
        } else {
            entryAgeGrp = @"1";
        }
        int subClass;
        if(OccpClass == 2)
        {
            subClass = 1;
        } else {
            subClass = OccpClass;
        }
        
        planOption2 = [planOption2 stringByReplacingOccurrencesOfString:@"_" withString:@""];
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE "
                              "RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND occpClass = \"%d\" AND PlanOption=\"%@\" AND Deductible=\"%@\" AND EntryAgeGroup=\"%@\"", RidCode,fromAge,toAge,sex, subClass, planOption2, hmm, entryAgeGrp];
                
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeClassPA:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND occpClass = \"%d\" ",RidCode,fromAge,toAge, OccpClass ];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Rider rate.");
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
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND occpClass = \"%d\" AND RiderOpt=\"%@\"",RidCode, fromAge,toAge, OccpClass,plans ];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSexCplus:(NSString *)RidCode riderTerm:(int)aaterm fromAge:(NSString*)fromAge toAge:(NSString*)toAge planOptC:(NSString *) plnOptC2
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {       
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND Term = \"%d\"  AND FromAge<=\"%@\" AND ToAge >=\"%@\" AND Sex=\"%@\" AND RiderOpt=\"%@\" ",RidCode,aaterm,fromAge,toAge,sex, plnOptC2];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  [self getFormattedRates:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateClass:(NSString *)RidCode riderTerm:(int)aaterm 
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" "
                              " AND occpClass = \"%d\" ",
                              RidCode, OccpClass];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"Error accessing Rider rate.");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//----

#pragma mark - VALIDATION

-(int)validateSave//basic plan validation checking before save
{
    [_delegate isSaveBasicPlan:YES];//condition of life assured not matching hence cannot be save : @Edwin 3-10-2013:changed to NO as switching to Riders will increase the counter by 1, emptying the riders when switching tab to Basic and goes back to Rider
	
    int validatePasses = 100;
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSCharacterSet *setTerm = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    NSRange rangeofDotSUM = [yearlyIncomeField.text rangeOfString:@"."];
    NSString *substringSUM = @"";
    NSRange rangeofDotHL = [HLField.text rangeOfString:@"."];
    NSString *substringHL = @"";
    NSRange rangeofDotTempHL = [tempHLField.text rangeOfString:@"."];
    NSString *substringTempHL = @"";
    NSRange rangeofDotAcc = [parAccField.text rangeOfString:@"."];
    NSString *substringAcc = @"";
    NSRange rangeofDotPayout = [parPayoutField.text rangeOfString:@"."];
    NSString *substringPayout = @"";
    
    if (rangeofDotSUM.location != NSNotFound) {
        substringSUM = [yearlyIncomeField.text substringFromIndex:rangeofDotSUM.location ];
    }
    if (rangeofDotHL.location != NSNotFound) {
        substringHL = [HLField.text substringFromIndex:rangeofDotHL.location ];
    }
    if (rangeofDotTempHL.location != NSNotFound) {
        substringTempHL = [tempHLField.text substringFromIndex:rangeofDotTempHL.location ];
    }
    if (rangeofDotAcc.location != NSNotFound) {
        substringAcc = [parAccField.text substringFromIndex:rangeofDotAcc.location ];
    }
    if (rangeofDotPayout.location != NSNotFound) {
        substringPayout = [parPayoutField.text substringFromIndex:rangeofDotPayout.location ];
    }
    int maxParIncome = 0;
    NSString *msgType = nil;
    NSString *msgGYI = nil;
    if ([planChoose isEqualToString:STR_HLAWP]) {
        if (MOPHLAIB == 0) {
            MOPHLAIB = 6;
        }
        MOP = MOPHLAIB;
        cashDividend = cashDividendHLACP;
        advanceYearlyIncome = advanceYearlyIncomeHLACP;
        
        maxParIncome = [parAccField.text intValue] + [parPayoutField.text intValue];
        if ([parAccField.text intValue] == 0) {
            yearlyIncome = @"POF";
        }
        else {
            yearlyIncome = @"ACC";
        }
        
        if ([parAccField.text intValue] == 100 && parPayoutField.text.length == 0) {
            parPayoutField.text = @"0";
        }
        if ([parPayoutField.text intValue] == 100 && parAccField.text.length == 0) {
            parAccField.text = @"0";
        }
        msgType = @"Desired Annual Premium";
        msgGYI = @"Yearly Cash Coupons/ Cash Payments";
    } else if ([planChoose isEqualToString:STR_S100]) {
        if (MOPHLAIB != 0) {
            MOP = MOPHLAIB; // get value from ui segment selection
        } else {
            MOP = 100 - ageClient;
        }
        msgType = @"Basic Sum Assured";
    }
    else if ([planChoose isEqualToString:STR_HLAIB]) {
        MOP = MOPHLAIB;
        yearlyIncome = yearlyIncomeHLAIB;
        cashDividend = cashDividendHLAIB;
        advanceYearlyIncome = advanceYearlyIncomeHLAIB;
    }
    else if ([planChoose isEqualToString:STR_HLACP])
    {
        if (MOPHLAIB == 0) {
            MOPHLAIB = 6;
        }
        MOP = MOPHLACP;
        cashDividend = cashDividendHLACP;
        advanceYearlyIncome = advanceYearlyIncomeHLACP;
        
        maxParIncome = [parAccField.text intValue] + [parPayoutField.text intValue];
        if ([parAccField.text intValue] == 0) {
            yearlyIncome = @"POF";
        }
        else {
            yearlyIncome = @"ACC";
        }
        
        if ([parAccField.text intValue] == 100 && parPayoutField.text.length == 0) {
            parPayoutField.text = @"0";
        }
        if ([parPayoutField.text intValue] == 100 && parAccField.text.length == 0) {
            parAccField.text = @"0";
        }
        msgType = @"Desired Yearly Income";
        msgGYI = @"Yearly Income";
    }
    else if ([planChoose isEqualToString:STR_L100])
    {
        if (requestEDD == TRUE) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 30 days." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil,nil];
            [alert show];
            return FALSE;
        }
        else{
            MOP = [self scanForNumbersFromString:[MOPSegment titleForSegmentAtIndex:MOPSegment.selectedSegmentIndex]];
        }
        msgType = @"Basic Sum Assured";
        
    }
    
//    NSLog(@"Validatesave PLAN:%@ MOP:%d, MOPHLAIB:%d  yearlyIncome:%@, cashDividend:%@, advanceYearlyIncome:%d, hl:%@, hlterm:%d",planChoose, MOP,MOPHLAIB,yearlyIncome,cashDividend,advanceYearlyIncome, getHL, getHLTerm);
    
    if (![planChoose isEqualToString:prevPlanChoose]) {
        [self updateHealthLoading];
        [self updateTemporaryHealthLoading];
    }
    
    [self updateCurrentHealthLoading];
    if (msgType == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select a basic plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (yearlyIncomeField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ is required.", msgType] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if (substringSUM.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ only allow 2 decimal places.", msgType] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Invalid input format. %@ must be numeric 0 to 9 or dot(.)", msgType] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        yearlyIncomeField.text = @"";
        [yearlyIncomeField becomeFirstResponder];
    }
    else if (requestEDD == TRUE && [yearlyIncomeField.text intValue] > 15000 && [planChoose isEqualToString:STR_HLAWP] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"The Maximum allowable total annual premium (inclusive of Wealth Booster, Wealth Booster-i6, Wealth Booster -d10 and EduWealth Riders) for an unborn Child allowable is RM15,000."] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text intValue] < minSA) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ must be greater than or equal to %d",msgType,minSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text intValue] > maxSA) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"%@ must be less than or equal to %d",msgType,maxSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if (!(MOP)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Premium Payment option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ( [planChoose isEqualToString:STR_HLACP] && yearlyIncome.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Yearly Income Option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //----------
	
	else if (([planChoose isEqualToString:STR_HLACP] ||[planChoose isEqualToString:STR_HLAWP]) && parAccField.text.length==0 && parPayoutField.text.length==0  ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Please key in the Percentage of %@ Option.", msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && parAccField.text.length==0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Percentage of %@ Option must be 100%%",msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && parPayoutField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Percentage of %@ Option must be 100%%",msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && [parAccField.text intValue] > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Percentage of %@ Option must be 100%%",msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && [parPayoutField.text intValue] > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Percentage of %@ Option must be 100%%",msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && substringAcc.length > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Yearly Income Option must not contains decimal places."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && substringPayout.length > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Yearly Income Option must not contains decimal places."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && maxParIncome != 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Total Percentage of %@ Option must be 100%%", msgGYI] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
    }
    //--------------
    
    else if (([planChoose isEqualToString:STR_HLACP]||[planChoose isEqualToString:STR_HLAWP]) && cashDividend.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Cash Dividend option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    //-------HL
    else if ([HLField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input. Please enter numeric value (0-9) or dot(.) into Health input for (per 1k SA)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if (substringHL.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (Per 1k SA) only allow 2 decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([HLField.text intValue] >= 10000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (Per 1k SA) cannot greater than or equal to 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([HLField.text intValue] > 0 && HLTermField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (per 1k SA) Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTermField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([HLTermField.text intValue] > 0 && HLField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Health Loading (per 1k SA) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([HLTermField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input. Please enter numeric value (0-9) into Health input for (per 1k SA) Term." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLTermField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([HLTermField.text intValue] > MOP) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d",MOP] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTermField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([tempHLField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input. Please enter numeric value (0-9) or dot(.) into Temporary Health input for (per 1k SA)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if (substringTempHL.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (Per 1k SA) only allow 2 decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([tempHLTermField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input. Please enter numeric value (0-9) into Temporary Health input for (per 1k SA) Term." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLField.text intValue] >= 10000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (Per 1k SA) cannot greater than 10000" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
        
    }
    else if ([tempHLField.text intValue] > 0 && tempHLTermField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (per 1k SA) Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
        
    }
    else if ([tempHLTermField.text intValue] > 0 && tempHLField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Temporary Health Loading (per 1k SA) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([tempHLTermField.text intValue] > MOP) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:[NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",MOP] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
        validatePasses = SIMENU_HEALTH_LOADING;
    }
    else if ([planChoose isEqualToString:STR_S100] && OccpClass == 99) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"This plan is not applicable for that Occupational Class." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    //--end HL
	
    else {
        
        float num = [yearlyIncomeField.text floatValue];
        int basicSumA = num;
        
        if ((MOP == 9 && basicSumA < 1000 && ageClient >= 66 && ageClient <= 70)||
            (MOP == 9 && basicSumA >= 1000 && ageClient >= 68 && ageClient <= 70)||
            (MOP == 12 && basicSumA < 1000 && ageClient >= 59 && ageClient <= 70)||
            (MOP == 12 && basicSumA >= 1000 && ageClient >= 61 && ageClient <= 70))
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please note that the Guaranteed Benefit payout for selected plan maybe lesser than total premium outlay.\nChoose OK to proceed.\nChoose CANCEL to select other plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
            [alert setTag:1002];
            [alert show];
            
        } else {
            validatePasses = 0;
        }
    }
    return validatePasses;
}
-(BOOL)isBasicPlanSelected
{
    if([btnPlan.titleLabel.text isEqualToString:@""] || btnPlan.titleLabel.text == nil)
    {
        return NO;
    }
    
    return YES;
}
#pragma mark - STORE BASIC PLAN BEFORE SAVE INTO DATABASE
-(void)storeData
{
	
    if (!basicPlanSIObj) {
        basicPlanSIObj = [[SIObj alloc]init];
    }
    basicPlanSIObj.policyTerm = [self getTerm];
    basicPlanSIObj.basicSA = yearlyIncomeField.text;
    basicPlanSIObj.prePayOption = [NSString stringWithFormat:@"%d",MOP];
    basicPlanSIObj.cashDivident = cashDividend;
    basicPlanSIObj.yearlyIncome = yearlyIncome;
    basicPlanSIObj.advanceYearlyIncome = [NSString stringWithFormat:@"%d",advanceYearlyIncome];
    basicPlanSIObj.hl1kSA = HLField.text;
    basicPlanSIObj.hl1kSATerm = HLTermField.text;
    basicPlanSIObj.tempHL1kSA = tempHLField.text;
    basicPlanSIObj.temHL1KSAterm = tempHLTermField.text;
    basicPlanSIObj.updatedAt = @"datetime(\"now\", \"+8 hour\")";
    basicPlanSIObj.partialAcc = parAccField.text;
    basicPlanSIObj.partialPayout = parPayoutField.text;
    basicPlanSIObj.siNO = SINo;
    
}
#pragma mark - delegate

-(void)Planlisting:(PlanList *)inController didSelectCode:(NSString *)aaCode andDesc:(NSString *)aaDesc
{
 
    if (([aaCode isEqualToString:STR_L100] || [aaCode isEqualToString:STR_S100]) && requestEDD == TRUE) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 30 days." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil,nil];
        [self.planPopover dismissPopoverAnimated:YES];
        [alert show];
        return;
    }
    
    if ([planChoose isEqualToString:STR_HLAWP]) {
            yearlyIncomeField.text = @"";
    }
    
    if (![aaCode isEqualToString:planChoose] && prevPlanChoose.length != 0) {
        MOPHLAIB = 0;
        MOPHLACP = 0;
        yearlyIncomeHLAIB = nil;
        cashDividendHLAIB = nil;
        cashDividendHLACP = nil;
        advanceYearlyIncomeHLAIB = 0;
        advanceYearlyIncomeHLACP = 0;
        
        [self checkExistRider];
        
        if (arrExistRiderCode.count > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert setTag:1007];
            [alert show];
        }
    }
    
    
    if (aaCode == NULL) {
        [btnPlan setTitle:temp forState:UIControlStateNormal];
    }
    else {
        [self.btnPlan setTitle:aaDesc forState:UIControlStateNormal];
        planChoose = [[NSString alloc] initWithFormat:@"%@",aaCode];
    }
    

    
    if( [self isPlanChanged] )
    {
        [_delegate clearSecondLA];
        [_delegate setNewPlan:planChoose];
    }
    
    [self togglePlan];
    [self loadBasic];
        
    [self.planPopover dismissPopoverAnimated:YES];
}

-(void)setDefaultSA
{
    if ([planChoose isEqualToString:STR_HLACP])
    {
        yearlyIncomeField.text = @"1200";
    } else {
        yearlyIncomeField.text = [NSString stringWithFormat:@"%d",minSA];
    }
}

-(void)loadBasic
{
//    if (getSumAssured != 0) {
//    if (planChoose != NULL && ![planChoose isEqualToString:prevPlanChoose]) {
        [self getExistingBasic:false];
        [self toggleExistingField];
//    }
}

#pragma mark - Memory Management
- (void)viewDidUnload
{
    basicPlanSIObj = nil;
    
    [self resignFirstResponder];
    [self setPlanPopover:nil];
    [self setPlanList:nil];
    [self setDelegate:nil];
    [self setRequestOccpCode:nil];
    [self setRequestSINo:nil];
    [self setRequestSmokerPay:nil];
    [self setRequestSexPay:nil];
    [self setRequestDOBPay:nil];
    [self setRequestOccpPay:nil];
    [self setRequestSmoker2ndLA:nil];
    [self setRequestSex2ndLA:nil];
    [self setRequestDOB2ndLA:nil];
    [self setRequestOccp2ndLA:nil];
    [self setOccpCode:nil];
    [self setSINo:nil];
    [self setPayorSmoker:nil];
    [self setPayorSex:nil];
    [self setPayorDOB:nil];
    [self setPayorOccpCode:nil];
    [self setSecondLASmoker:nil];
    [self setSecondLASex:nil];
    [self setSecondLADOB:nil];
    [self setSecondLAOccpCode:nil];
    [self setBtnPlan:nil];
    [self setTermField:nil];
    [self setYearlyIncomeField:nil];
    [self setMinSALabel:nil];
    [self setMaxSALabel:nil];
    [self setBtnHealthLoading:nil];
    [self setHealthLoadingView:nil];
    [self setMOPSegment:nil];
    [self setIncomeSegment:nil];
    [self setAdvanceIncomeSegment:nil];
    [self setCashDividendSegment:nil];
    [self setHLField:nil];
    [self setHLTermField:nil];
    [self setTempHLField:nil];
    [self setTempHLTermField:nil];
    [self setMyScrollView:nil];
    [self setMyToolBar:nil];
    [self setSIDate:nil];
    [self setCustDate:nil];
    [self setLACustCode:nil];
    [self setPYCustCode:nil];
    [self setSecondLACustCode:nil];
    [self setNamePP:nil];
    [self setDOBPP:nil];
    [self setGenderPP:nil];
    [self setOccpCodePP:nil];
    [self setYearlyIncome:nil];
    [self setCashDividend:nil];
    [self setPlanCode:nil];
    [self setGetSINo:nil];
    [self setGetHL:nil];
    [self setGetTempHL:nil];
    [self setLRiderCode:nil];
    [self setLSumAssured:nil];
    [self setRiderCode:nil];
    [self setLabelFive:nil];
    [self setCashDivSgmntCP:nil];
    [self setLabelFour:nil];
    [self setLabelSix:nil];
    [self setLabelSeven:nil];
    [self setLabelFive:nil];
    [self setLabelSix:nil];
    [self setLabelSeven:nil];
    [self setLabelParAcc:nil];
    [self setLabelParPayout:nil];
    [self setLabelPercent1:nil];
    [self setLabelPercent2:nil];
    [self setParAccField:nil];
    [self setParPayoutField:nil];
    [self setLabelAddHL:nil];
    [self setHeaderTitle:nil];
	[self setQuotationLangSegment:nil];
	[self setOutletDone:nil];
	[self setOutletEAPP:nil];
	[self setOutletSpace:nil];
    [self setLabelThree:nil];
    [self setLabelPremiumPay:nil];
    [self setPolicyTermSeg:nil];
    [super viewDidUnload];
}

@end
