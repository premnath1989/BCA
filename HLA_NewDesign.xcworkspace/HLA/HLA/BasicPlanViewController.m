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
@synthesize myScrollView,labelSix,labelSeven,labelFour,labelFive,annualMedRiderPrem,monthMedRiderPrem,quarterMedRiderPrem;
@synthesize ageClient,requestSINo,termCover,planChoose,maxSA,minSA,halfMedRiderPrem;
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
@synthesize quotationLang;

#pragma mark - Cycle View

id temp;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    self.healthLoadingView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    [self loadData];
    //--
    btnHealthLoading.hidden = YES;
    labelAddHL.hidden = YES;
    //--
    
    self.planList = [[PlanList alloc] init];
    _planList.delegate = self;
	self.planList.TradOrEver = @"TRAD";
    //planChoose = [[NSString alloc] initWithFormat:@"%@",self.planList.selectedCode];
    //[self.btnPlan setTitle:self.planList.selectedDesc forState:UIControlStateNormal];
    //temp = btnPlan.titleLabel.text;
    
    planChoose = @"HLACP"; //harcoded as there's only one plan
    [self.btnPlan setTitle:@"HLA Cash Promise" forState:UIControlStateNormal];//harcoded as there's only one plan
    temp = btnPlan.titleLabel.text;
    
    useExist = NO;
    termField.enabled = NO;
    healthLoadingView.alpha = 0;
    showHL = NO;
    [self tooglePlan];
    quotationLang = @"English"; //default without selection is English
    
    if (self.requestSINo) {
        [self checkingExisting];
        if (getSINo.length != 0) {
            NSLog(@"view selected field");
            [self getExistingBasic];
            if ([planChoose isEqualToString:@"HLACP"]) {
                [self.btnPlan setTitle:@"HLA Cash Promise" forState:UIControlStateNormal];
                temp = btnPlan.titleLabel.text;
            }
            [self tooglePlan];
            [self toogleExistingField];
			
        } else {
            NSLog(@"create new");
        }
    } else {
        NSLog(@"SINo not exist!");
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
    [parAccField setDelegate:self];
    [parPayoutField setDelegate:self];
    [termField setDelegate:self];
    [yearlyIncomeField setDelegate:self];
    
    _planList = nil;
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
    NSLog(@"BASIC-SINo:%@, age:%d, job:%@",SINo,ageClient,OccpCode);
    NSLog(@"BASIC-idPayor:%d, idProfile:%d",idPay,idProf);
	
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
    /*
	 if (parAccField.text.length != 0||parPayoutField.text.length != 0) {
	 
	 NSRange rangeofDot = [parAccField.text rangeOfString:@"."];
	 NSString *substring = @"";
	 if (rangeofDot.location != NSNotFound) {
	 substring = [parAccField.text substringFromIndex:rangeofDot.location ];
	 }
	 
	 NSRange rangeofDot2 = [parPayoutField.text rangeOfString:@"."];
	 NSString *substring2 = @"";
	 if (rangeofDot2.location != NSNotFound) {
	 substring2 = [parPayoutField.text substringFromIndex:rangeofDot2.location ];
	 }
	 
	 int maxInc = 100;
	 int totalInc = 0;
	 int parAcc = 0;
	 int parPayout = 0;
	 
	 parAcc = [parAccField.text intValue];
	 parPayout = [parPayoutField.text intValue];
	 totalInc = parAcc + parPayout;
	 
	 if (totalInc > 100) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Yearly Income must equal to 100." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 }
	 
	 else if (substring.length > 1||substring2.length > 1) {
	 
	 UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Yearly Income must not contains decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	 [alert show];
	 }
	 else {
	 if (parAccField.text.length != 0 && parPayoutField.text.length == 0 && parAcc <=100) {
	 parPayout = maxInc - parAcc;
	 parPayoutField.text = [NSString stringWithFormat:@"%d",parPayout];
	 }
	 
	 if (parPayoutField.text.length != 0 && parAccField.text.length == 0 && parPayout <=100) {
	 parAcc = maxInc - parPayout;
	 parAccField.text = [NSString stringWithFormat:@"%d",parAcc];
	 }
	 }
	 } */
    
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
			
			if (ageClient < 41) {
				minSA = 1200;
			}
			
			minSALabel.text = [NSString stringWithFormat:@"Min: %d",minSA];
			maxSALabel.text = [NSString stringWithFormat:@"Max: %d",maxSA];
            
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
    
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
        return NO;
    }
    
    if ([textField isEqual:parAccField]) {
        
        int maxInc = 100;
        int parAcc = 0;
        int parPayout = 0;
        NSString *strAcc = [parAccField.text stringByReplacingCharactersInRange:range withString:string];
        
        parAcc = [strAcc intValue];
        parPayout = maxInc - parAcc;
        
        if (parAcc > 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Yearly Income must equal to 100." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            //parPayoutField.text = @"0";
        }
        else {
            //parPayoutField.text = [NSString stringWithFormat:@"%d",parPayout];
        }
    }
    
    if ([textField isEqual:parPayoutField]) {
        int maxInc = 100;
        int parAcc = 0;
        int parPayout = 0;
        NSString *strPayout = [parPayoutField.text stringByReplacingCharactersInRange:range withString:string];
        
        parPayout = [strPayout intValue];
        parAcc = maxInc - parPayout;
        
        if (parPayout > 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Yearly Income must equal to 100." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            //parAccField.text = @"0";
        }
        else {
            //parAccField.text = [NSString stringWithFormat:@"%d",parAcc];
        }
    }
    
    return YES;
}

#pragma mark - Action

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
	
    [self.planPopover setPopoverContentSize:CGSizeMake(350.0f, 200.0f)];
    [self.planPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    }else
        if(_quotationLangSegment.selectedSegmentIndex == 1)
        {
            quotationLang = @"Malay";
        }
    
    
    //NSLog(@"quotation language : %@", quotationLang);
    //NSLog(@"_quotationLangSegment.selectedSegmentIndex : %@", [NSString stringWithFormat:@"%d",_quotationLangSegment.selectedSegmentIndex]);
}


- (IBAction)MOPSegmentPressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([MOPSegment selectedSegmentIndex]==0) {
        MOPHLAIB = 6;
    }
    else if (MOPSegment.selectedSegmentIndex == 1){
        MOPHLAIB = 9;
    }
    else if (MOPSegment.selectedSegmentIndex == 2) {
        MOPHLAIB = 12;
    }
    NSLog(@"MOP:%d",MOPHLAIB);
    appDelegate.isNeedPromptSaveMsg = YES;
	
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
/*
- (IBAction)quotationLangSegmentPressed
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if(_quotationLangSegment.selectedSegmentIndex == 0)
    {
        quotationLang = @"English";
    }else
        if(_quotationLangSegment.selectedSegmentIndex == 1)
        {
            quotationLang = @"Malay";
        }
    
    
    NSLog(@"quotation language : %@", quotationLang);
    NSLog(@"_quotationLangSegment.selectedSegmentIndex : %@", [NSString stringWithFormat:@"%d",_quotationLangSegment.selectedSegmentIndex]);
}
*/
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
    }
    else if (advanceIncomeSegment.selectedSegmentIndex == 1) {
        advanceYearlyIncomeHLAIB = 75;
    }
    else if (advanceIncomeSegment.selectedSegmentIndex == 2) {
        advanceYearlyIncomeHLAIB = 0;
    }
    NSLog(@"advance:%d",advanceYearlyIncomeHLAIB);
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)cashDivSgmntCPPressed:(id)sender
{
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

-(BOOL)checkingSave
{
    if (useExist) {
        NSLog(@"will update");
        if([self updateBasicPlan])
        {
            return YES;
        }
    } else {
        NSLog(@"will save");
        [self saveBasicPlan];
        return YES;
    }
    [self checkingExisting];
    return NO;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0) {
        
        NewLAViewController *NewLAPage  = [self.storyboard instantiateViewControllerWithIdentifier:@"LAView"];
        MainScreen *MainScreenPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        MainScreenPage.IndexTab = 3;
        NewLAPage.modalPresentationStyle = UIModalPresentationPageSheet;
		//        NewLAPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:MainScreenPage animated:YES completion:^(){
            [MainScreenPage presentModalViewController:NewLAPage animated:NO];
			//            MainScreenPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            NewLAPage.view.superview.bounds =  CGRectMake(-300, 0, 1024, 748);
            
        }];
    }
    else if (alertView.tag==1002 && buttonIndex == 0) {
        [self checkingSave];
    }
    else if (alertView.tag==1003 && buttonIndex == 0) {
        [self checkingSave];
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
		//        [self closeScreen];
    }
}

#pragma mark - Toogle view

-(void)toogleExistingField
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:getSumAssured]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    yearlyIncomeField.text = [[NSString alloc] initWithFormat:@"%@",sumAss];
    
    if ([planChoose isEqualToString:@"HLAIB"]) {
        
        if ([quotationLang isEqualToString:@"English"]) {
            _quotationLangSegment.selectedSegmentIndex = 0;
        }
        else if ([quotationLang isEqualToString:@"Malay"]) {
            _quotationLangSegment.selectedSegmentIndex = 1;
        }
        
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
        //--end--
    }
    else {
        
        parAccField.text = [NSString stringWithFormat:@"%d",getParAcc];
        parPayoutField.text = [NSString stringWithFormat:@"%d",getParPayout];
        
        cashDividendHLACP = cashDividend;
        if ([cashDividendHLACP isEqualToString:@"ACC"]) {
            cashDivSgmntCP.selectedSegmentIndex = 0;
        }
        else if ([cashDividendHLACP isEqualToString:@"POF"]) {
            cashDivSgmntCP.selectedSegmentIndex = 1;
        }
        
        if ([quotationLang isEqualToString:@"English"]) {
            _quotationLangSegment.selectedSegmentIndex = 0;
        }
        else if ([quotationLang isEqualToString:@"Malay"]) {
            _quotationLangSegment.selectedSegmentIndex = 1;
        }
    }
    
    if (getHL.length != 0) {
        //HLField.text = getHL;
        NSRange rangeofDot = [getHL rangeOfString:@"."];
        NSString *valueToDisplay = @"";
        
        if (rangeofDot.location != NSNotFound) {
            NSString *substring = [getHL substringFromIndex:rangeofDot.location ];
            if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                valueToDisplay = [getHL substringToIndex:rangeofDot.location ];
            }
            else {
                valueToDisplay = getHL;
            }
        }
        else {
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
            }
            else {
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
    [self getPlanCodePenta];
    
    [_delegate BasicSI:getSINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose];
}

-(void)tooglePlan
{
    NSLog(@"tooglePlan");
    [self getTermRule];
    
    if ([planChoose isEqualToString:@"HLAIB"]) {
        
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
        }
        
        if (ageClient > 50 && ageClient <=65)
        {
            [advanceIncomeSegment setEnabled:NO forSegmentAtIndex:0];
            [[advanceIncomeSegment.subviews objectAtIndex:0] setAlpha:0.5];
        }
    }
    else {
        
		//        parPayoutField.enabled = NO;
        cashDivSgmntCP.hidden = NO;
        labelFour.text = @"Yearly Income* :";
        labelFive.text = @"Cash Dividend* :";
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
        [cashDivSgmntCP setSelectedSegmentIndex:UISegmentedControlNoSegment];
        
        MOPHLACP = 6;
        advanceYearlyIncomeHLACP = 0;
    }
}


#pragma mark - calculation

-(void)calculateSA
{
    double basicSA = [yearlyIncomeField.text doubleValue];
    double dblPseudoBSA = basicSA / 0.05;
    double dblPseudoBSA2 = dblPseudoBSA * 0.1;
    double dblPseudoBSA3 = dblPseudoBSA * 5;
    double dblPseudoBSA4 = dblPseudoBSA * 2;
    int MaxUnit = 0;
    //    NSLog(@"dblPseudoBSA:%.f, dblPseudoBSA3:%.f",maxRiderSA,dblPseudoBSA3);
    
    if ([riderCode isEqualToString:@"CCTR"])
    {
        _maxRiderSA = dblPseudoBSA3;
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"ETPD"])
    {
        _maxRiderSA = fmin(dblPseudoBSA2,120000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"I20R"]||[riderCode isEqualToString:@"I30R"]||[riderCode isEqualToString:@"I40R"]||[riderCode isEqualToString:@"ID20R"]||[riderCode isEqualToString:@"ID30R"]||[riderCode isEqualToString:@"ID40R"]||[riderCode isEqualToString:@"IE20R"]||[riderCode isEqualToString:@"IE30R"])
    {
        NSLog(@"enter gyi");
        [self getGYI];
        double BasicSA_GYI = basicSA * GYI;
        _maxRiderSA = fmin(BasicSA_GYI,9999999);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"CPA"])
    {
        if (OccpClass == 1 || OccpClass == 2) {
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
        else if (OccpClass == 3 || OccpClass == 4) {
            _maxRiderSA = fmin(dblPseudoBSA3,100000);
            NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
            maxRiderSA = [a_maxRiderSA doubleValue];
        }
    }
    else if ([riderCode isEqualToString:@"PA"]) {
        _maxRiderSA = fmin(dblPseudoBSA3,1000000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"PTR"]) {
        _maxRiderSA = fmin(dblPseudoBSA3,500000);
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    else if ([riderCode isEqualToString:@"HB"]) {
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
        maxRiderSA = MaxUnit;
    }
    else if ([riderCode isEqualToString:@"ETPDB"]) {
        double max = basicPremAnn * 10;
        _maxRiderSA = fmin(max, maxSATerm);
        maxRiderSA = _maxRiderSA;
    }
    else {
        _maxRiderSA = maxSATerm;
        NSString *a_maxRiderSA = [NSString stringWithFormat:@"%.2f",_maxRiderSA];
        maxRiderSA = [a_maxRiderSA doubleValue];
    }
    NSLog(@"maxSA(%@):%.f",riderCode,maxRiderSA);
}

-(void)calculateBasicPremium
{
    NSString *BasicAnnually = nil;
    NSString *BasicHalfYear = nil;
    NSString *BasicQuarterly = nil;
    NSString *BasicMonthly = nil;
    NSString *OccpLoadA = nil;
    NSString *OccpLoadH = nil;
    NSString *OccpLoadQ = nil;
    NSString *OccpLoadM = nil;
    NSString *BasicHLAnnually = nil;
    NSString *BasicHLHalfYear = nil;
    NSString *BasicHLQuarterly = nil;
    NSString *BasicHLMonthly = nil;
    NSString *LSDAnnually = nil;
    NSString *LSDHalfYear = nil;
    NSString *LSDQuarterly = nil;
    NSString *LSDMonthly = nil;
    NSString *basicTotalA = nil;
    NSString *basicTotalS = nil;
    NSString *basicTotalQ = nil;
    NSString *basicTotalM = nil;
    
    double BasicSA = [yearlyIncomeField.text doubleValue];
    double PolicyTerm = [termField.text doubleValue];
    double BasicHLoad = [getHL doubleValue];
    double BasicTempHLoad = [getTempHL doubleValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //calculate basic premium
    double _BasicAnnually = basicRate * (BasicSA/1000) * 1;
    double _BasicHalfYear = basicRate * (BasicSA/1000) * 0.5125;
    double _BasicQuarterly = basicRate * (BasicSA/1000) * 0.2625;
    double _BasicMonthly = basicRate * (BasicSA/1000) * 0.0875;
    BasicAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicAnnually]];
    BasicHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicHalfYear]];
    BasicQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicQuarterly]];
    BasicMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicMonthly]];
    double BasicAnnually_ = [[BasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHalfYear_ = [[BasicHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicQuarterly_ = [[BasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicMonthly_ = [[BasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
	//    NSLog(@"Basic A:%.2f, S:%.2f, Q:%.2f, M:%.2f",BasicAnnually_,BasicHalfYear_,BasicQuarterly_,BasicMonthly_);
    
    //calculate occupationLoading
    double _OccpLoadA = 0;
    double _OccpLoadH = 0;
    double _OccpLoadQ = 0;
    double _OccpLoadM = 0;
    if ([planChoose isEqualToString:@"HLAIB"]) {
        _OccpLoadA = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.0875;
    }
    else {
        _OccpLoadA = occLoad *55 * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad *55 * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad *55 * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad *55 * (BasicSA/1000) * 0.0875;
    }
    OccpLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadA]];
    OccpLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadH]];
    OccpLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadQ]];
    OccpLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadM]];
    double OccpLoadA_ = [[OccpLoadA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadH_ = [[OccpLoadH stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadQ_ = [[OccpLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadM_ = [[OccpLoadM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
	//    NSLog(@"OccpLoad A:%.2f, S:%.2f, Q:%.2f, M:%.2f",OccpLoadA_, OccpLoadH_, OccpLoadQ_, OccpLoadM_);
    
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
    
    BasicHLAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLAnn]];
    BasicHLHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLHalf]];
    BasicHLQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLQuar]];
    BasicHLMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLMonth]];
    double BasicHLAnnually_ = [[BasicHLAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLHalfYear_ = [[BasicHLHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLQuarterly_ = [[BasicHLQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLMonthly_ = [[BasicHLMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
	//    NSLog(@"BasicHL A:%.3f, S:%.3f, Q:%.3f, M:%.3f",BasicHLAnnually_, BasicHLHalfYear_, BasicHLQuarterly_, BasicHLMonthly_);
    
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
	//    NSLog(@"BasicLSD A:%.2f, S:%.2f, Q:%.2f, M:%.2f",LSDAnnually_, LSDHalfYear_, LSDQuarterly_, LSDMonthly_);
    
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
    }
    else {
        _basicTotalA = BasicAnnually_ + OccpLoadA_ + BasicHLAnnually_ - LSDAnnually_;
        _basicTotalS = BasicHalfYear_ + OccpLoadH_ + BasicHLHalfYear_ - LSDHalfYear_;
        _basicTotalQ = BasicQuarterly_ + OccpLoadQ_ + BasicHLQuarterly_ - LSDQuarterly_;
        _basicTotalM = BasicMonthly_ + OccpLoadM_ + BasicHLMonthly_ - LSDMonthly_;
    }
    
    LSDAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDAnnually_]];
    LSDHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDHalfYear_]];
    LSDQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDQuarterly_]];
    LSDMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDMonthly_]];
    
    basicTotalA = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalA]];
    basicTotalS = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalS]];
    basicTotalQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalQ]];
    basicTotalM = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalM]];
    
    
    basicPremAnn = [[basicTotalA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremHalf = [[basicTotalS stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremQuar = [[basicTotalQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremMonth = [[basicTotalM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicPrem:%.2f, S:%.2f, Q:%.2f, M:%.2f",basicPremAnn,basicPremHalf,basicPremQuar,basicPremMonth);
}

-(void)calculateRiderPrem
{
    NSMutableArray *annualRiderPrem = [[NSMutableArray alloc] init];
    NSMutableArray *halfRiderPrem = [[NSMutableArray alloc] init];
    NSMutableArray *quarterRiderPrem = [[NSMutableArray alloc] init];
    NSMutableArray *monthRiderPrem = [[NSMutableArray alloc] init];
    
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
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSUInteger i;
    for (i=0; i<[LRiderCode count]; i++) {
        
        NSString *RidCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:i]];
        
        //getpentacode
        NSString *plan = nil;
        NSString *pentaSQL = nil;
        NSString *deduct = nil;
        NSString *planCodeRider = nil;
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if ([RidCode isEqualToString:@"C+"])
            {
                if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Level"]) {
                    plan = @"L";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Increasing"]) {
                    plan = @"I";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Level_NCB"]) {
                    plan = @"B";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Increasing_NCB"]) {
                    plan = @"N";
                }
                
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"C+\" AND PlanOption=\"%@\"",plan];
            }
            else if ([RidCode isEqualToString:@"HMM"])
            {
                plan = [LPlanOpt objectAtIndex:i];
                deduct = [LDeduct objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HMM\" AND PlanOption=\"%@\" AND Deductible=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",plan,deduct,[LAge objectAtIndex:i],[LAge objectAtIndex:i]];
            }
            else if ([RidCode isEqualToString:@"HSP_II"])
            {
                if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Standard"]) {
                    plan = @"S";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Deluxe"]) {
                    plan = @"D";
                } else if ([[LPlanOpt objectAtIndex:i] isEqualToString:@"Premier"]) {
                    plan = @"P";
                }
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HSP_II\" AND PlanOption=\"%@\"",plan];
            }
            else if ([RidCode isEqualToString:@"MG_II"])
            {
                plan = [LPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_II\" AND PlanOption=\"%@\"",plan];
            }
            else if ([RidCode isEqualToString:@"I20R"] || [RidCode isEqualToString:@"I30R"] || [RidCode isEqualToString:@"I40R"] || [RidCode isEqualToString:@"ID20R"] || [RidCode isEqualToString:@"ID30R"] || [RidCode isEqualToString:@"ID40R"] || [RidCode isEqualToString:@"IE20R"] || [RidCode isEqualToString:@"IE30R"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",[LRiderCode objectAtIndex:i],MOP];
                
            }
            else if ([RidCode isEqualToString:@"ICR"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"ICR\" AND Smoker=\"%@\"",[LSmoker objectAtIndex:i]];
                
            } else if ([RidCode isEqualToString:@"MG_IV"])
            {
                plan = [LPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_IV\" AND PlanOption=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",plan,[LAge objectAtIndex:i],[LAge objectAtIndex:i]];
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
                    NSLog(@"error access PentaPlanCode");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        int ridTerm = [[LTerm objectAtIndex:i] intValue];
        age = [[LAge objectAtIndex:i] intValue];
        sex = [[NSString alloc] initWithFormat:@"%@",[LSex objectAtIndex:i]];
        //get rate
        if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"ID20R"]||[RidCode isEqualToString:@"ID30R"]||[RidCode isEqualToString:@"ID40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"])
        {
            [self getRiderRateAge:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"CPA"]) {
            [self getRiderRateClass:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"PA"]||[RidCode isEqualToString:@"HSP_II"]) {
            [self getRiderRateAgeClass:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"HB"]) {
            [self getRiderRateSex:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"HMM"]) {
            [self getRiderRateAgeSexClass:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"EDB"] ||[RidCode isEqualToString:@"ETPDB"]) {
            [self getRiderRateSex:planCodeRider];
        }
        else {
            [self getRiderRateAgeSex:planCodeRider riderTerm:ridTerm];
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
        NSLog(@"occpLoadRate(%@):%d",RidCode,occLoadRider);
        
        double annualRider = 0;
        double halfYearRider = 0;
        double quarterRider = 0;
        double monthlyRider = 0;
        
        if ([RidCode isEqualToString:@"ETPD"])
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
        NSLog(@"RiderTotal(%@) A:%@, S:%@, Q:%@, M:%@",[LRiderCode objectAtIndex:i],calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        
        //for waiver CIWP
        if (!([RidCode isEqualToString:@"LCPR"]) && !([RidCode isEqualToString:@"CIR"]) && !([RidCode isEqualToString:@"PR"]) && !([RidCode isEqualToString:@"LCWP"]) && !([RidCode isEqualToString:@"SP_STD"]) && !([RidCode isEqualToString:@"SP_PRE"]) && !([RidCode isEqualToString:@"CIWP"]) && !([RidCode isEqualToString:@"ICR"])) {
            
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
        if ([RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"HSP_II"]||[RidCode isEqualToString:@"HMM"]||[RidCode isEqualToString:@"HB"]||[RidCode isEqualToString:@"CIR"]||[RidCode isEqualToString:@"C+"]) {
            [annualMedRiderPrem addObject:calRiderAnn];
            [halfMedRiderPrem addObject:calRiderHalf];
            [quarterMedRiderPrem addObject:calRiderQuarter];
            [monthMedRiderPrem addObject:calRiderMonth];
			//            NSLog(@"medical insert(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
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
    NSLog(@"RiderPrem:%.2f",riderPrem);
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
	//    NSLog(@"AccRiderPrem1 A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnSum,waiverHalfSum,waiverQuarSum,waiverMonthSum);
    
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
	//    NSLog(@"AccRiderPrem2 A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnSum2,waiverHalfSum2,waiverQuarSum2,waiverMonthSum2);
    
    NSMutableArray *waiverRidAnnTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidHalfTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidQuarTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidMonthTol = [[NSMutableArray alloc] init];
    
    NSUInteger i;
    for (i=0; i<[LRiderCode count]; i++) {
        
        NSString *RidCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:i]];
        
        //getpentacode
        NSString *pentaSQL = nil;
        NSString *planCodeRider = nil;
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if ([RidCode isEqualToString:@"CIWP"]||[RidCode isEqualToString:@"LCWP"]||[RidCode isEqualToString:@"PR"]||[RidCode isEqualToString:@"SP_STD"]||[RidCode isEqualToString:@"SP_PRE"]) {
                
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"",RidCode];
            }
            else {
                sqlite3_close(contactDB);
                continue;
            }
            
            const char *query_stmt = [pentaSQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                }
                else {
                    NSLog(@"error access PentaPlanCode");
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
        [self getRiderRateAgeSex:planCodeRider riderTerm:ridTerm];
        
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
        NSLog(@"~waiverRate(%@):%.2f, waiverSum:%.3f, HL:%.3f, TempHL:%.3f",RidCode,riderRate,ridSA,riderHLoad,riderTempHLoad);
        
        double annFac = 1;
        double halfFac = 0.5125;
        double quarterFac = 0.2625;
        double monthFac = 0.0875;
        
        //calculate occupationLoading
        pTypeOccp = [LOccpCode objectAtIndex:i];
        [self getOccLoadRider];
        NSLog(@"occpLoadRate:%d",occLoadRider);
        
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
            NSLog(@"waiverSA A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnPrem,waiverHalfPrem,waiverQuarPrem,waiverMonthPrem);
            
            double annualRider_ = waiverAnnPrem * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double halfYearRider_ = waiverHalfPrem * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double quarterRider_ = waiverQuarPrem * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            double monthlyRider_ = waiverMonthPrem * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
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
            NSLog(@"waiverSA A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnPrem,waiverHalfPrem,waiverQuarPrem,waiverMonthPrem);
            
            double annualRider_ = waiverAnnPrem * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double halfYearRider_ = waiverHalfPrem * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double quarterRider_ = waiverQuarPrem * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            double monthlyRider_ = waiverMonthPrem * (riderRate/100 + (double)ridTerm/1000 * occLoadRider + (riderHLoad+riderTempHLoad)/100);
            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
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
        NSLog(@":waiverTotal(%@) A:%@, S:%@, Q:%@, M:%@",RidCode,calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
    }
    
    NSUInteger a;
    for (a=0; a<[waiverRidAnnTol count]; a++) {
        
        annualRiderSum = annualRiderSum + [[waiverRidAnnTol objectAtIndex:a] doubleValue];
        halfRiderSum = halfRiderSum + [[waiverRidHalfTol objectAtIndex:a] doubleValue];
        quarterRiderSum = quarterRiderSum + [[waiverRidQuarTol objectAtIndex:a] doubleValue];
        monthRiderSum = monthRiderSum + [[waiverRidMonthTol objectAtIndex:a] doubleValue];
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
        NSLog(@"medPrem:%.2f",medRiderPrem);
    }
    else {
        NSLog(@"non exist medical rider!");
        medRiderPrem = 0;
    }
}

-(void)MHIGuideLines
{
    double totalPrem = 0;
    double medicDouble = 0;
    double minus = 0;
    double varSA = 0;
    double riderSA = 0;
    double RiderSA = 0;
    double basicSA = 0;
    bool pop = false;
    
    totalPrem = basicPremAnn + riderPrem;
    medicDouble = medRiderPrem * 2;
    NSLog(@"~totalPrem:%.2f, medicalPrem:%.2f, medicDouble:%.2f",totalPrem,medRiderPrem,medicDouble);
    
    if (medicDouble > totalPrem) {
        minus = totalPrem - medRiderPrem;
        NSLog(@"minus:%.2f",minus);
        
        basicSA = [yearlyIncomeField.text doubleValue];
        if (minus > 0) {
            
            varSA = medRiderPrem/minus *basicSA + 0.5;
            NSString *newBasicSA = [NSString stringWithFormat:@"%.f",varSA];
            NSLog(@":1-UPDATE newBasicSA:%.f",varSA);
            
            basicSA = [newBasicSA doubleValue];
            yearlyIncomeField.text = newBasicSA;
            /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Desirable yearly Income has been revise to RM %@",newBasicSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];*/
            appDelegate.bpMsgPrompt = [NSString stringWithFormat:@"Desirable yearly Income has been revise to RM %@",newBasicSA];
            
            [self getLSDRate];
            pop = true;
            
            //update basicSA to varSA
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
                NSString *querySQL = [NSString stringWithFormat:
                                      @"UPDATE Trad_Details SET BasicSA=\"%@\" WHERE SINo=\"%@\"",newBasicSA, SINo];
                
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                        NSLog(@"BasicSA update Success!");
                        
                    } else {
                        NSLog(@"BasicSA update Failed!");
                    }
                    sqlite3_finalize(statement);
                }
                sqlite3_close(contactDB);
            }
            
            //update riderSA
            for (NSUInteger u=0; u<[LRiderCode count]; u++)
            {
                NSString *ridCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:u]];
                
                if (!([ridCode isEqualToString:@"C+"]) && !([ridCode isEqualToString:@"CIR"]) && !([ridCode isEqualToString:@"MG_II"]) && !([ridCode isEqualToString:@"MG_IV"]) && !([ridCode isEqualToString:@"HB"]) && !([ridCode isEqualToString:@"HSP_II"]) && !([ridCode isEqualToString:@"HMM"]) && !([ridCode isEqualToString:@"CIWP"]) && !([ridCode isEqualToString:@"LCWP"]) && !([ridCode isEqualToString:@"PR"]) && !([ridCode isEqualToString:@"SP_STD"]) && !([ridCode isEqualToString:@"SP_PRE"]))
                {
                    riderCode = [LRiderCode objectAtIndex:u];
                    [self getRiderTermRule];
                    riderSA = [[LSumAssured objectAtIndex:u] doubleValue];
                    
                    if (riderSA > 0)
                    {
                        RiderSA = (medRiderPrem/minus) * riderSA;
                        NSLog(@"1-newRiderSA(%@):%.2f, oldRiderSA:%.2f, maxSA:%d",riderCode,RiderSA,riderSA,maxSATerm);
                        
                        double newSA = 0;
                        if (RiderSA > maxSATerm) {
                            newSA = maxSATerm;
                        }
                        else {
                            newSA = RiderSA;
                        }
                        
                        NSLog(@":1-UPDATE newRiderSA(%@):%.2f",riderCode,newSA);
                        sqlite3_stmt *statement;
                        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                        {
                            NSString *updatetSQL = [NSString stringWithFormat:
													@"UPDATE Trad_Rider_Details SET SumAssured=\"%.f\" WHERE SINo=\"%@\" AND RiderCode=\"%@\"",newSA,SINo,riderCode];
                            
                            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                if (sqlite3_step(statement) == SQLITE_DONE) {
                                    NSLog(@"Update RiderSA success!");
                                }
                                else {
                                    NSLog(@"Update RiderSA failed!");
                                }
                                sqlite3_finalize(statement);
                            }
                            sqlite3_close(contactDB);
                        }
                    }
                }
                else {
                    continue;
                }
            }
            
            [self calculateBasicPremium];
            [self getListingRider];
            [self calculateRiderPrem];
            [self calculateWaiver];
            [self calculateMedRiderPrem];
            
            //--second cycle--//
            
            totalPrem = basicPremAnn + riderPrem;
            medicDouble = medRiderPrem * 2;
            NSLog(@"~newTotalPrem:%.2f, newMedicalPrem:%.2f, newMedicDouble:%.2f",totalPrem,medRiderPrem,medicDouble);
            
            if (medicDouble > totalPrem) {
                minus = totalPrem - medRiderPrem;
                
                if (minus > 0) {
                    
                    varSA = medRiderPrem/minus * basicSA + 0.5;
                    newBasicSA = [NSString stringWithFormat:@"%.f",varSA];
                    NSLog(@":2-UPDATE newBasicSA:%.f",varSA);
                    basicSA = [newBasicSA doubleValue];
                    yearlyIncomeField.text = newBasicSA;
                    [self getLSDRate];
                    pop = true;
                    
                    //update basicSA to varSA
                    sqlite3_stmt *statement;
                    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
                        NSString *querySQL = [NSString stringWithFormat:
                                              @"UPDATE Trad_Details SET BasicSA=\"%@\" WHERE SINo=\"%@\"",newBasicSA, SINo];
                        
                        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement) == SQLITE_DONE) {
                                
                                NSLog(@"BasicSA update Success!");
                                
                            } else {
                                NSLog(@"BasicSA update Failed!");
                            }
                            sqlite3_finalize(statement);
                        }
                        sqlite3_close(contactDB);
                    }
                    
                    //update riderSA
                    for (NSUInteger u=0; u<[LRiderCode count]; u++)
                    {
                        NSString *ridCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:u]];
                        
                        if (!([ridCode isEqualToString:@"C+"]) && !([ridCode isEqualToString:@"CIR"]) && !([ridCode isEqualToString:@"MG_II"]) && !([ridCode isEqualToString:@"MG_IV"]) && !([ridCode isEqualToString:@"HB"]) && !([ridCode isEqualToString:@"HSP_II"]) && !([ridCode isEqualToString:@"HMM"]) && !([ridCode isEqualToString:@"CIWP"]) && !([ridCode isEqualToString:@"LCWP"]) && !([ridCode isEqualToString:@"PR"]) && !([ridCode isEqualToString:@"SP_STD"]) && !([ridCode isEqualToString:@"SP_PRE"]))
                        {
                            riderCode = [LRiderCode objectAtIndex:u];
                            [self getRiderTermRule];
                            riderSA = [[LSumAssured objectAtIndex:u] doubleValue];
                            
                            if (riderSA > 0)
                            {
                                RiderSA = (medRiderPrem/minus) * riderSA;
                                NSLog(@"2-newRiderSA(%@):%.2f, oldRiderSA:%.2f, maxSA:%d",riderCode,RiderSA,riderSA,maxSATerm);
                                
                                double newSA = 0;
                                if (RiderSA > maxSATerm)
                                {
                                    newSA = maxSATerm;
                                } else {
                                    newSA = RiderSA;
                                }
                                
                                NSLog(@":2-UPDATE newRiderSA(%@):%.2f",riderCode,newSA);
                                //update riderSA
                                sqlite3_stmt *statement;
                                if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                                {
                                    NSString *updatetSQL = [NSString stringWithFormat:
															@"UPDATE Trad_Rider_Details SET SumAssured=\"%.f\" WHERE SINo=\"%@\" AND RiderCode=\"%@\"",newSA,SINo,riderCode];
                                    
                                    if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                        if (sqlite3_step(statement) == SQLITE_DONE) {
                                            NSLog(@"Update RiderSA success!");
                                        }
                                        else {
                                            NSLog(@"Update RiderSA failed!");
                                        }
                                        sqlite3_finalize(statement);
                                    }
                                    sqlite3_close(contactDB);
                                }
                                
                            }
                        }
                        else {
                            continue;
                        }
                    }
                    
                    [self calculateBasicPremium];
                    [self getListingRider];
                    [self calculateRiderPrem];
                    [self calculateWaiver];
                    [self calculateMedRiderPrem];
                    
                    //--third cycle--//
                    
                    totalPrem = basicPremAnn + riderPrem;
                    medicDouble = medRiderPrem * 2;
                    NSLog(@"~newTotalPrem:%.2f, newMedicalPrem:%.2f, newMedicDouble:%.2f",totalPrem,medRiderPrem,medicDouble);
                    
                    if (medicDouble > totalPrem) {
                        minus = totalPrem - medRiderPrem;
                        if (minus > 0) {
                            
                            varSA = medRiderPrem/minus * basicSA + 0.5;
                            newBasicSA = [NSString stringWithFormat:@"%.f",varSA];
                            NSLog(@":3-UPDATE newBasicSA:%.f",varSA);
                            basicSA = [newBasicSA doubleValue];
                            yearlyIncomeField.text = newBasicSA;
                            [self getLSDRate];
                            pop = true;
                            
                            //update basicSA to varSA
                            sqlite3_stmt *statement;
                            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
                                NSString *querySQL = [NSString stringWithFormat:
                                                      @"UPDATE Trad_Details SET BasicSA=\"%@\" WHERE SINo=\"%@\"",newBasicSA, SINo];
                                
                                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                    if (sqlite3_step(statement) == SQLITE_DONE) {
                                        
                                        NSLog(@"BasicSA update Success!");
                                        
                                    } else {
                                        NSLog(@"BasicSA update Failed!");
                                    }
                                    sqlite3_finalize(statement);
                                }
                                sqlite3_close(contactDB);
                            }
                            
                            //update riderSA
                            for (NSUInteger u=0; u<[LRiderCode count]; u++)
                            {
                                NSString *ridCode = [[NSString alloc] initWithFormat:@"%@",[LRiderCode objectAtIndex:u]];
                                
                                if (!([ridCode isEqualToString:@"C+"]) && !([ridCode isEqualToString:@"CIR"]) && !([ridCode isEqualToString:@"MG_II"]) && !([ridCode isEqualToString:@"MG_IV"]) && !([ridCode isEqualToString:@"HB"]) && !([ridCode isEqualToString:@"HSP_II"]) && !([ridCode isEqualToString:@"HMM"]) && !([ridCode isEqualToString:@"CIWP"]) && !([ridCode isEqualToString:@"LCWP"]) && !([ridCode isEqualToString:@"PR"]) && !([ridCode isEqualToString:@"SP_STD"]) && !([ridCode isEqualToString:@"SP_PRE"]))
                                {
                                    riderCode = [LRiderCode objectAtIndex:u];
                                    [self getRiderTermRule];
                                    riderSA = [[LSumAssured objectAtIndex:u] doubleValue];
                                    
                                    if (riderSA > 0)
                                    {
                                        RiderSA = (medRiderPrem/minus) * riderSA;
                                        NSLog(@"2-newRiderSA(%@):%.2f, oldRiderSA:%.2f, maxSA:%d",riderCode,RiderSA,riderSA,maxSATerm);
                                        
                                        double newSA = 0;
                                        if (RiderSA > maxSATerm)
                                        {
                                            newSA = maxSATerm;
                                        } else {
                                            newSA = RiderSA;
                                        }
                                        
                                        NSLog(@":3-UPDATE newRiderSA(%@):%.2f",riderCode,newSA);
                                        //update riderSA
                                        sqlite3_stmt *statement;
                                        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
                                        {
                                            NSString *updatetSQL = [NSString stringWithFormat:
																	@"UPDATE Trad_Rider_Details SET SumAssured=\"%.f\" WHERE SINo=\"%@\" AND RiderCode=\"%@\"",newSA,SINo,riderCode];
                                            
                                            if(sqlite3_prepare_v2(contactDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                                if (sqlite3_step(statement) == SQLITE_DONE) {
                                                    NSLog(@"Update RiderSA success!");
                                                }
                                                else {
                                                    NSLog(@"Update RiderSA failed!");
                                                }
                                                sqlite3_finalize(statement);
                                            }
                                            sqlite3_close(contactDB);
                                        }
                                        
                                    }
                                }
                                else {
                                    continue;
                                }
                            }
                            
                            [self calculateBasicPremium];
                            [self getListingRider];
                            [self calculateRiderPrem];
                            [self calculateWaiver];
                            [self calculateMedRiderPrem];
                            
                            //--forth cycle--//
                            
                            totalPrem = basicPremAnn + riderPrem;
                            medicDouble = medRiderPrem * 2;
                            NSLog(@"~newTotalPrem:%.2f, newMedicalPrem:%.2f, newMedicDouble:%.2f",totalPrem,medRiderPrem,medicDouble);
                            
                            if (medicDouble > totalPrem) {
                                NSLog(@"need 4th cycly!");
                            }
                        }
                    }
                }
            }
            
            if (pop) {
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.MhiMessage = newBasicSA;
                
                [_delegate BasicSARevised:newBasicSA];
            }
            else {
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.MhiMessage = @"";
            }
        }
        else {
            NSLog(@"value minus not greater than 0");
        }
    }
    else {
        NSLog(@"value medicDouble less than totalPrem");
    }
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

-(void) getTermRule
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT MinAge,MaxAge,MinTerm,MaxTerm,MinSA,MaxSA FROM Trad_Sys_Mtn WHERE PlanCode=\"%@\"",planChoose];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int minAge =  sqlite3_column_int(statement, 0);
                maxAge =  sqlite3_column_int(statement, 1);
                int maxTermB  =  sqlite3_column_int(statement, 3);
                
                if (ageClient > 40) {
					minSA = sqlite3_column_int(statement, 4);
				}
				else{
					minSA = 1200;
				}
				
				maxSA = sqlite3_column_int(statement, 5);
                
                if ([planChoose isEqualToString:@"HLAIB"]) {
                    termCover = maxTermB - ageClient;
                }
                else {
                    termCover = maxTermB;
                }
                termField.text = [[NSString alloc] initWithFormat:@"%d",termCover];
                
                
                if (ageClient < minAge) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Age Last Birthday must be greater than or equal to %d for this product.",minAge] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                } else if (ageClient > maxAge) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Age Last Birthday must be less than or equal to %d for this product.",maxAge] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                }
            } else {
                NSLog(@"error access getTermRule");
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

-(void)getExistingBasic
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
                planChoose = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                getPolicyTerm = sqlite3_column_int(statement, 2);
                getSumAssured = sqlite3_column_double(statement, 3);
                MOP = sqlite3_column_int(statement, 4);
                cashDividend = [[NSString alloc ] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                yearlyIncome = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                advanceYearlyIncome = sqlite3_column_int(statement, 7);
                
                const char *getHL2 = (const char*)sqlite3_column_text(statement, 8);
                getHL = getHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getHL2];
                getHLTerm = sqlite3_column_int(statement, 9);
                
                const char *getTempHL2 = (const char*)sqlite3_column_text(statement, 10);
                getTempHL = getTempHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getTempHL2];
                getTempHLTerm = sqlite3_column_int(statement, 11);
                getParAcc = sqlite3_column_int(statement, 12);
                getParPayout = sqlite3_column_int(statement, 13);
				
                if(sqlite3_column_text(statement, 14) == NULL)
                {
                    quotationLang = nil;
                }else
                {
                    quotationLang = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
                }
				
                NSLog(@"basicPlan:%@",planChoose);
                
            } else {
                NSLog(@"error access getExistingBasic");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
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
                               @"INSERT INTO Trad_Details (SINo,  PlanCode, PTypeCode, Seq, PolicyTerm, BasicSA, PremiumPaymentOption, CashDividend, YearlyIncome, AdvanceYearlyIncome, HL1KSA, HL1KSATerm, TempHL1KSA, TempHL1KSATerm, CreatedAt,UpdatedAt,PartialAcc,PartialPayout, QuotationLang) VALUES (\"%@\", \"%@\", \"LA\", \"1\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%d\", \"%@\", \"%d\", \"%@\", \"%d\", %@ , %@,%d,%d, \"%@\")", SINo, planChoose, termField.text, yearlyIncomeField.text, MOP, cashDividend, yearlyIncome, advanceYearlyIncome, HLField.text, [HLTermField.text intValue], tempHLField.text, [tempHLTermField.text intValue], @"datetime(\"now\", \"+8 hour\")",@"datetime(\"now\", \"+8 hour\")",[parAccField.text intValue],[parPayoutField.text intValue], quotationLang];
		
		/*  NSString *insertSQL = [NSString stringWithFormat:
		 @"INSERT INTO Trad_Details (SINo,  PlanCode, PTypeCode, Seq, PolicyTerm, BasicSA, PremiumPaymentOption, CashDividend, YearlyIncome, AdvanceYearlyIncome, CreatedAt,UpdatedAt,PartialAcc,PartialPayout) VALUES (\"%@\", \"%@\", \"LA\", \"1\", \"%@\", \"%@\", \"%d\", \"%@\", \"%@\", \"%d\" %@ , %@,%d,%d)", SINo, planChoose, termField.text, yearlyIncomeField.text, MOP, cashDividend, yearlyIncome, advanceYearlyIncome, @"datetime(\"now\", \"+8 hour\")",@"datetime(\"now\", \"+8 hour\")",[parAccField.text intValue],[parPayoutField.text intValue]];*/
        NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Saved BasicPlan!");
                [self updateLA];
                
                [self getPlanCodePenta];
                
                if (PayorIndexNo != 0) {
                    [self savePayor];
                }
                
                if (secondLAIndexNo != 0) {
                    [self saveSecondLA];
                }
                
                [_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose];
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
                               @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"PY\",\"1\",\"%@\",\"hla\")",SINo, PYCustCode,dateStr];
        
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
                                @"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")", PYCustCode, NamePP, PayorSmoker, PayorSex, PayorDOB, PayorAge, ANB, PayorOccpCode, dateStr,PayorIndexNo];
		
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
                               @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"LA\",\"2\",\"%@\",\"hla\")",SINo, secondLACustCode,dateStr];
        
        NSLog(@"%@",insertSQL);
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
								@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")", secondLACustCode, NamePP, secondLASmoker, secondLASex, secondLADOB, secondLAAge, ANB, secondLAOccpCode, dateStr,secondLAIndexNo];
        
        NSLog(@"%@",insertSQL2);
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
							   @"UPDATE Trad_LAPayor SET SINo=\"%@\", CustCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\" WHERE rowid=\"%d\"",SINo,LACustCode,currentdate,idPay];
        
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

-(BOOL)updateBasicPlan
{
    [self storeData];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		// NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET PolicyTerm=\"%@\", BasicSA=\"%@\", PremiumPaymentOption=\"%d\", CashDividend=\"%@\", YearlyIncome=\"%@\", AdvanceYearlyIncome=\"%d\", HL1KSA=\"%@\", HL1KSATerm=\"%d\", TempHL1KSA=\"%@\", TempHL1KSATerm=\"%d\", UpdatedAt=%@, PartialAcc=\"%d\", PartialPayout=\"%d\" WHERE SINo=\"%@\"",termField.text, yearlyIncomeField.text, MOP, cashDividend, yearlyIncome,advanceYearlyIncome, HLField.text, [HLTermField.text intValue], tempHLField.text, [tempHLTermField.text intValue], @"datetime(\"now\", \"+8 hour\")",[parAccField.text intValue],[parPayoutField.text intValue], SINo];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET PolicyTerm=\"%@\", BasicSA=\"%@\", PremiumPaymentOption=\"%d\", CashDividend=\"%@\", YearlyIncome=\"%@\", AdvanceYearlyIncome=\"%d\", HL1KSA=\"%@\", HL1KSATerm=\"%d\", TempHL1KSA=\"%@\", TempHL1KSATerm=\"%d\", UpdatedAt=%@, PartialAcc=\"%d\", PartialPayout=\"%d\" , QuotationLang=\"%@\" WHERE SINo=\"%@\"",termField.text, yearlyIncomeField.text, MOP, cashDividend, yearlyIncome,advanceYearlyIncome, HLField.text, [HLTermField.text intValue], tempHLField.text, [tempHLTermField.text intValue], @"datetime(\"now\", \"+8 hour\")",[parAccField.text intValue],[parPayoutField.text intValue], quotationLang, SINo];
		
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"BasicPlan update!");
                [self getPlanCodePenta];
                
                [_delegate BasicSI:SINo andAge:ageClient andOccpCode:OccpCode andCovered:termCover andBasicSA:yearlyIncomeField.text andBasicHL:HLField.text andBasicTempHL:tempHLField.text andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose];
            }
            else {
                NSLog(@"BasicPlan update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                return NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    [self validateExistingRider];
    return YES;
}

-(void)validateExistingRider
{
    [self getBasicPentaRate];
    [self getLSDRate];
    [self getOccLoad];
    NSLog(@"basicRate:%d,lsdRate:%d,occload:%d, pa_cpa:%d",basicRate,LSDRate,occLoad,occCPA_PA);
    [self calculateBasicPremium];
    
    [self getListingRider];
    
    for (int i=0; i<LRiderCode.count; i++) {
        NSLog(@"rider:%@, unit:%@",[LRiderCode objectAtIndex:i],[LUnits objectAtIndex:i]);
    }
    BOOL dodelete = NO;
    for (int p=0; p<LRiderCode.count; p++) {
        
        riderCode = [LRiderCode objectAtIndex:p];
        [self getRiderTermRule];
        [self calculateSA];
        double riderSA = [[LSumAssured objectAtIndex:p] doubleValue];
        int riderUnit = [[LUnits objectAtIndex:p] intValue];
        
        if (riderSA > maxRiderSA)
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",SINo,riderCode];
                
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
        
        if (riderUnit > maxRiderSA)
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                
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
        
        if ([yearlyIncomeField.text doubleValue] < 25000 && [[LPlanOpt objectAtIndex:p] isEqualToString:@"HMM_1000"])
        {
            dodelete = YES;
            sqlite3_stmt *statement;
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",requestSINo,riderCode];
                
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
        
    }
    if (dodelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [_delegate RiderAdded];
    }
    
    [self calculateRiderPrem];
    [self calculateWaiver];
    [self calculateMedRiderPrem];
    if (medRiderPrem != 0) {
        [self MHIGuideLines];
    }
}

-(void)getPlanCodePenta
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = nil;
        if ([planChoose isEqualToString:@"HLAIB"]) {
            querySQL = [NSString stringWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",planChoose, MOP];
        }
        else {
            querySQL = [NSString stringWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\"",planChoose];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                planCode =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"error access getPlanCodePenta");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getProspectData
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode FROM prospect_profile WHERE IndexNo= \"%d\"",IndexNo];
        
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
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.RiderCode, a.SumAssured, a.RiderTerm, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, a.HL100SA, a.HLPercentage, c.Smoker, c.Sex, c.ALB, c.OccpCode, a.TempHL1KSA FROM Trad_Rider_Details a, Trad_LAPayor b, Clt_Profile c WHERE a.PTypeCode=b.PTypeCode AND a.Seq=b.Sequence AND b.CustCode=c.CustCode AND a.SINo=b.SINo AND a.SINo=\"%@\" ORDER by a.RiderCode asc",SINo];
        
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char *aaRidCode = (const char *)sqlite3_column_text(statement, 0);
                [LRiderCode addObject:aaRidCode == NULL ? @"" : [[NSString alloc] initWithUTF8String:aaRidCode]];
                
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
                [LOccpCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)]];
                
                double TempridHL = sqlite3_column_double(statement, 13);
                [LTempRidHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",TempridHL]];
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
                NSLog(@"expiryAge(%@):%d,minTerm:%d,maxTerm:%d,minSA:%d,maxSA:%d",riderCode,expAge,minTerm,maxTerm,minSATerm,maxSATerm);
                
            } else {
                NSLog(@"error access getRiderTermRule");
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
        if (MOP == 6) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_6 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,ageClient,ageClient];
            
        } else if (MOP == 9) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_9 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,ageClient,ageClient];
            
        } else if (MOP == 12) {
            querySQL = [[NSString alloc] initWithFormat:
                        @"SELECT PremPayOpt_12 FROM Trad_Sys_Rider_GYI WHERE PlanCode=\"%@\" AND FromAge <=\"%d\" AND ToAge >= \"%d\"",riderCode,ageClient,ageClient];
        }
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                GYI = sqlite3_column_int(statement, 0);
                NSLog(@"GYI:%d",GYI);
            }
            else {
                NSLog(@"error access getGYI");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getBasicPentaRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem WHERE PlanCode=\"%@\" AND FromTerm=\"%@\" AND FromMortality=0",planCode,termField.text];
        
        //        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicRate =  sqlite3_column_int(statement, 0);
            } else {
                NSLog(@"error access getBasicPentaRate");
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
                              @"SELECT PA_CPA, OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",OccpCode];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occCPA_PA  = sqlite3_column_int(statement, 0);
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

-(void)getLSDRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%@\" AND ToSA >= \"%@\"",planCode,yearlyIncomeField.text,yearlyIncomeField.text];
        //        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                LSDRate =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getLSDRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//---

-(void)getRiderRateSex:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND Sex=\"%@\"",aaplan,aaterm,aaterm,sex];
        
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

-(void)getRiderRateSex:(NSString *)aaplan
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromMortality=0 AND Sex=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,sex,age,age];
        
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

-(void)getRiderRateAge:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
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
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSex:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\"",aaplan,aaterm,aaterm,age,age,sex];
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

-(void)getRiderRateAgeSexClass:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND occpClass = \"%d\"", aaplan,aaterm,aaterm,age,age,sex, OccpClass];
        
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

-(void)getRiderRateAgeClass:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                              " FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND occpClass = \"%d\"",
                              aaplan,aaterm,aaterm,age,age, OccpClass];
        
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

-(void)getRiderRateClass:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                              " FromMortality=0 AND occpClass = \"%d\"",
                              aaplan,aaterm,aaterm, OccpClass];
        
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

//----

#pragma mark - VALIDATION


-(BOOL)validateSave//basic plan validation checking before save
{
    [_delegate isSaveBasicPlan:YES];//condition of life assured not matching hence cannot be save : @Edwin 3-10-2013:changed to NO as switching to Riders will increase the counter by 1, emptying the riders when switching tab to Basic and goes back to Rider
	
    
    BOOL validatePasses = NO;
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
    if ([planChoose isEqualToString:@"HLAIB"]) {
        MOP = MOPHLAIB;
        yearlyIncome = yearlyIncomeHLAIB;
        cashDividend = cashDividendHLAIB;
        advanceYearlyIncome = advanceYearlyIncomeHLAIB;
    }
    else {
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
    }
    NSLog(@"MOP:%d, yearlyIncome:%@, cashDividend:%@, advanceYearlyIncome:%d",MOP,yearlyIncome,cashDividend,advanceYearlyIncome);
    
    /*if (OccpCode.length == 0) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert setTag:1001];
	 [alert show];
	 }
	 else*/ /*if (ageClient > maxAge) {
			 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Age Last Birthday must be less than or equal to %d for this product.",maxAge] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			 [alert show];
			 [_delegate isSaveBasicPlan:NO];
			 // validatePasses = YES;
			 }*/
	if (yearlyIncomeField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Desired Yearly Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if (substringSUM.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Desired Yearly Income only allow 2 decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Desired Yearly Income must be numeric 0 to 9 or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        yearlyIncomeField.text = @"";
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text intValue] < minSA) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Desired Yearly Income must be greater than or equal to %d",minSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if ([yearlyIncomeField.text intValue] > maxSA) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Desired Yearly Income must be less than or equal to %d",maxSA] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [yearlyIncomeField becomeFirstResponder];
    }
    else if (!(MOP)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select Premium Payment option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (yearlyIncome.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select Yearly Income Option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //----------
	
	else if ([planChoose isEqualToString:@"HLACP"] && parAccField.text.length==0 && parPayoutField.text.length==0  ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please key in the Percentage of Yearly Income Option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && parAccField.text.length==0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Percentage of Yearly Income Option must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && parPayoutField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Percentage of Yearly Income Option must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && [parAccField.text intValue] > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Percentage of Yearly Income Option must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && [parPayoutField.text intValue] > 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Percentage of Yearly Income Option must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && substringAcc.length > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Yearly Income Option must not contains decimal places." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parAccField becomeFirstResponder];
    }
    else if ([planChoose isEqualToString:@"HLACP"] && substringPayout.length > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Yearly Income Option must not contains decimal places." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [parPayoutField becomeFirstResponder];
    }
    else if (maxParIncome != 100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Total Percentage of Yearly Income Option must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
    }
    //--------------
    
    else if (cashDividend.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select Cash Dividend option." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    //-------HL
    else if ([HLField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input. Please enter numeric value (0-9) or dot(.) into Health input for (per 1k SA)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if (substringHL.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading (Per 1k SA) only allow 2 decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLField.text intValue] >= 10000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading (Per 1k SA) cannot greater than or equal to 10000." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLField.text intValue] > 0 && HLTermField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading (per 1k SA) Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTermField becomeFirstResponder];
    }
    else if ([HLTermField.text intValue] > 0 && HLField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Health Loading (per 1k SA) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLField becomeFirstResponder];
    }
    else if ([HLTermField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input. Please enter numeric value (0-9) into Health input for (per 1k SA) Term." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [HLTermField becomeFirstResponder];
    }
    else if ([HLTermField.text intValue] > termCover) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Health Loading (per 1k SA) Term cannot be greater than %d",termCover] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [HLTermField becomeFirstResponder];
    }
    else if ([tempHLField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input. Please enter numeric value (0-9) or dot(.) into Temporary Health input for (per 1k SA)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if (substringTempHL.length > 3) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Temporary Health Loading (Per 1k SA) only allow 2 decimal places." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLTermField.text rangeOfCharacterFromSet:setTerm].location != NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input. Please enter numeric value (0-9) into Temporary Health input for (per 1k SA) Term." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLField.text intValue] >= 10000) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Temporary Health Loading (Per 1k SA) cannot greater than 10000" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLField.text intValue] > 0 && tempHLTermField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Temporary Health Loading (per 1k SA) Term is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
    }
    else if ([tempHLTermField.text intValue] > 0 && tempHLField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Temporary Health Loading (per 1k SA) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLField becomeFirstResponder];
    }
    else if ([tempHLTermField.text intValue] > termCover) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Temporary Health Loading (per 1k SA) Term cannot be greater than %d",termCover] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [tempHLTermField becomeFirstResponder];
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please note that the Guaranteed Benefit payout for selected plan maybe lesser than total premium outlay.\nChoose OK to proceed.\nChoose CANCEL to select other plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
            [alert setTag:1002];
            [alert show];
            
        }
        else{
            validatePasses = YES;
        }
        /*else {
		 
		 NSString *msg;
		 [self checkingExisting];
		 if (useExist) {
		 msg = @"Confirm changes?";
		 } else {
		 msg = @"Confirm creating new record?";
		 }
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
		 [alert setTag:1003];
		 [alert show];
		 }*/
    }
    return validatePasses;
}
-(BOOL)isBasicPlanSelected
{
    NSLog(@"%@",btnPlan.titleLabel.text);
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
    basicPlanSIObj.policyTerm = termField.text;
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
    
    if (aaCode == NULL) {
        [btnPlan setTitle:temp forState:UIControlStateNormal];
    }
    else {
        [self.btnPlan setTitle:aaDesc forState:UIControlStateNormal];
        planChoose = [[NSString alloc] initWithFormat:@"%@",aaCode];
    }
    
    if (![aaCode isEqualToString:planChoose]) {
        MOPHLAIB = 0;
        MOPHLACP = 0;
        yearlyIncomeHLAIB = nil;
        cashDividendHLAIB = nil;
        cashDividendHLACP = nil;
        advanceYearlyIncomeHLAIB = 0;
        advanceYearlyIncomeHLACP = 0;
    }
    
    [self tooglePlan];
    if (getSumAssured != 0) {
        [self toogleExistingField];
    }
    
    [self.planPopover dismissPopoverAnimated:YES];
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
    [self setPlanChoose:nil];
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
    [super viewDidUnload];
}

@end
