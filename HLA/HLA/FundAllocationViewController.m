//
//  FundAllocationViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//
//  VUVentureOptGrowth & VUVentureOptGrowth

#import "FundAllocationViewController.h"
#import "AppDelegate.h"

@interface FundAllocationViewController ()

@end

NSString *BasicTerm, *planCode;

@implementation FundAllocationViewController
@synthesize txt2023,txt2025,txt2028,txt2030,txt2035,txtAge,txtCashFund,txtExpireCashFund,txtExpireSecureFund;
@synthesize txtSecureFund, outletAge, outletReset,outletSustain, myScrollView;
@synthesize SINo,get2023,get2025,get2028,get2030,get2035,getCashFund,getExpiredCashFund,getExpiredSecureFund, outletDone;
@synthesize getSecureFund, getSustainAge, getAge, txtDanaFund, txtExpireDanaFund, getDanaFund, getExpiredDanaFund, requesteProposalStatus, EAPPorSI;
@synthesize outletEAPP, outletSpace, txtExpireVentureFlexi, txtVentureFlexi;
@synthesize delegate = _delegate;

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
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	// Do any additional setup after loading the view.
	
	if ([requesteProposalStatus isEqualToString:@"Created"] ||
		[requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"]) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
	
	txt2023.hidden = YES; //fund removed at version 3.9
	
	txt2023.delegate = self;
	txt2025.delegate = self;
	txt2028.delegate = self;
	txt2030.delegate = self;
	txt2035.delegate = self;
	txtSecureFund.delegate = self;
	txtCashFund.delegate = self;
	txtDanaFund.delegate = self;
	txtExpireCashFund.delegate = self;
	txtExpireSecureFund.delegate = self;
	txtExpireDanaFund.delegate = self;
	txtAge.tag = 1;
	txtAge.delegate = self;
	myScrollView.delegate = self;
	txtAge.enabled = FALSE;
    txtVentureFlexi.delegate = self;
    txtExpireVentureFlexi.delegate = self;
	
	if (SINo) {
		[self getExisting];
		[self toggle];
	}
	else{
		txtAge.enabled = NO;
		txtAge.backgroundColor = [UIColor lightGrayColor];
		outletAge.enabled = FALSE;
		txtExpireCashFund.enabled = FALSE;
		txtExpireSecureFund.enabled = FALSE;
		txtExpireDanaFund.enabled = FALSE;
		txtExpireCashFund.backgroundColor = [UIColor lightGrayColor];
		txtExpireSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtExpireDanaFund.backgroundColor = [UIColor lightGrayColor];
        txtExpireVentureFlexi.backgroundColor = [UIColor lightGrayColor];
        
	}

	outletEAPP.width = 0.01;
	outletSpace.width = 650;
	
	if (Editable == NO) {
		[self DisableTextField:txt2023];
		[self DisableTextField:txt2025];
		[self DisableTextField:txt2028];
		[self DisableTextField:txt2030];
		[self DisableTextField:txt2035];
		[self DisableTextField:txtAge];
		[self DisableTextField:txtCashFund];
		[self DisableTextField:txtDanaFund];
        [self DisableTextField:txtVentureFlexi];
        [self DisableTextField:txtSecureFund];
		[self DisableTextField:txtExpireCashFund];
		[self DisableTextField:txtExpireDanaFund];
		[self DisableTextField:txtExpireSecureFund];
        [self DisableTextField:txtExpireVentureFlexi];
		
        [self DisableTextField:self.txtVentureGrowth];///
        [self DisableTextField:self.txtVentureBlueChip];
        [self DisableTextField:self.txtVentureDana];
        [self DisableTextField:self.txtVentureManaged];
        [self DisableTextField:self.txtVentureIncome];
        [self DisableTextField:self.txtVenture6666];
        [self DisableTextField:self.txtVenture7777];
        [self DisableTextField:self.txtVenture8888];
        [self DisableTextField:self.txtVenture9999];
        [self DisableTextField:self.txtExpireVentureGrowth];
        [self DisableTextField:self.txtExpireVentureBlueChip];
        [self DisableTextField:self.txtExpireVentureDana];
        [self DisableTextField:self.txtExpireVentureManaged];
        [self DisableTextField:self.txtExpireVentureIncome];
        [self DisableTextField:self.txtExpireVenture6666];
        [self DisableTextField:self.txtExpireVenture7777];
        [self DisableTextField:self.txtExpireVenture8888];
        [self DisableTextField:self.txtExpireVenture9999];
        
        
		outletAge.enabled = FALSE;
		outletReset.hidden = TRUE;
		outletSustain.enabled = FALSE;
		
		if([EAPPorSI isEqualToString:@"eAPP"]){
			outletDone.enabled = FALSE;
			outletEAPP.width = 0;
			outletSpace.width = 564;
			
		}
		
	}

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
	
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

-(void)DisableTextField :(UITextField *)aaTextField{
	aaTextField.backgroundColor = [UIColor lightGrayColor];
	aaTextField.enabled = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
	 self.headerTitle.frame = CGRectMake(344, -20, 111, 44);
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

	self.myScrollView.frame = CGRectMake(0, 44, 768, 700);
    self.myScrollView.contentSize = CGSizeMake(768, 900);
	
	activeField = txtAge;
	
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];

    if ([self.txtExpireVentureFlexi isFirstResponder] || [self.txtExpireVentureGrowth isFirstResponder] || [self.txtExpireVentureBlueChip isFirstResponder] || [self.txtExpireVentureDana isFirstResponder] || [self.txtExpireDanaFund isFirstResponder] || [self.txtExpireVentureManaged isFirstResponder] || [self.txtExpireSecureFund isFirstResponder] || [self.txtExpireCashFund isFirstResponder] || [self.txtExpireVentureIncome isFirstResponder]) {
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
        
    }

}

-(void)keyboardDidHide:(NSNotificationCenter *)notification{
	self.myScrollView.frame = CGRectMake(0, 44, 768, 960);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	//appDel.isNeedPromptSaveMsg = YES;
}

-(void)InsertandUpdate{

	 sqlite3_stmt *statement;
	 if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	 {        
		 NSString *querySQL = [NSString stringWithFormat: @"UPDATE UL_DETAILS SET VU2023 = '%@', VU2025 = '%@', VU2028 = '%@', "
							   "VU2030 = '%@', VU2035 = '%@', VUCash = '%@', VURET = '%@', VUCashOpt='%@', VURetOpt='%@', "
							   "PolicySustainYear ='%@', VUDana = '%@', VUDanaOpt = '%@',VUSmart = '0', VUSmartOpt = '0', VUVenture = '%@', VUVentureOpt = '%@' , VUVentureGrowth = '%@' , VUVentureBlueChip = '%@' , VUVentureDana = '%@' , VUVentureManaged = '%@' , VUVentureIncome = '%@' , VUVentureOptGrowth = '%@' , VUVentureOptBlueChip = '%@' , VUVentureOptDana = '%@' , VUVentureOptManaged = '%@' , VUVentureOptIncome = '%@'  where sino = '%@' ",
							   txt2023.text, txt2025.text, txt2028.text, txt2030.text, txt2035.text, txtCashFund.text,
							   txtSecureFund.text, txtExpireCashFund.text, txtExpireSecureFund.text, [self ReturnSustainAge],
							   txtDanaFund.text, txtExpireDanaFund.text, txtVentureFlexi.text, txtExpireVentureFlexi.text, self.txtVentureGrowth.text, self.txtVentureBlueChip.text, self.txtVentureDana.text, self.txtVentureManaged.text, self.txtVentureIncome.text, self.txtExpireVentureGrowth.text, self.txtExpireVentureBlueChip.text, self.txtExpireVentureDana.text, self.txtExpireVentureManaged.text, self.txtExpireVentureIncome.text,SINo ];
	         
		 //NSLog(@"%@", querySQL);
		 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		 {
			 if (sqlite3_step(statement) == SQLITE_DONE)
			 {
                
			 } else {
				 //NSLog(@"error check tbl_Adm_TrnTypeNo");
                 
			 }
			 sqlite3_finalize(statement);
		 }
		 
		 NSString *ToBeDeleted = @"";
		 if ([txt2023.text isEqualToString:@"0"]) {
			 ToBeDeleted = @"'HLA EverGreen 2023'";
		 }
		 
		 if ([txt2025.text isEqualToString:@"0"]) {
			 if ([ToBeDeleted isEqualToString:@""]) {
				 ToBeDeleted = [ToBeDeleted stringByAppendingString:@"'HLA EverGreen 2025'"];
			 }
			 else{
				ToBeDeleted =[ToBeDeleted stringByAppendingString:@",'HLA EverGreen 2025'"];
			 }
		 }
		 
		 if ([txt2028.text isEqualToString:@"0"]) {
			 if ([ToBeDeleted isEqualToString:@""]) {
                 ToBeDeleted = [ToBeDeleted stringByAppendingString:@"'HLA EverGreen 2028'"];
			 }
			 else{
				 ToBeDeleted =				 [ToBeDeleted stringByAppendingString:@",'HLA EverGreen 2028'"];
			 }
		 }
		 
		 if ([txt2030.text isEqualToString:@"0"]) {
			 if ([ToBeDeleted isEqualToString:@""]) {
				 ToBeDeleted =				 [ToBeDeleted stringByAppendingString:@"'HLA EverGreen 2030'"];
			 }
			 else{
				 ToBeDeleted =				 [ToBeDeleted stringByAppendingString:@",'HLA EverGreen 2030'"];
			 }
		 }
		 
		 if ([txt2035.text isEqualToString:@"0"]) {
			 if ([ToBeDeleted isEqualToString:@""]) {
				 ToBeDeleted =				 [ToBeDeleted stringByAppendingString:@"'HLA EverGreen 2035'"];
			 }
			 else{
				 ToBeDeleted =				 [ToBeDeleted stringByAppendingString:@",'HLA EverGreen 2035'"];
			 }
		 }
		 

		 
		 querySQL = [NSString stringWithFormat: @"DELETE FROM UL_Fund_Maturity_Option where sino = '%@' and fund IN (%@) ",  SINo, ToBeDeleted ];
		 //NSLog(@"%@", querySQL);
		 
		 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		 {
			 if (sqlite3_step(statement) == SQLITE_DONE)
			 {
				 
			 } 
			 sqlite3_finalize(statement);
		 }

		 bool F2023 = FALSE;
		 bool F2025 = FALSE;
		 bool F2028 = FALSE;
		 bool F2030 = FALSE;
		 bool F2035 = FALSE;
		 
		 querySQL = [NSString stringWithFormat: @"Select Fund FROM UL_Fund_Maturity_Option where sino = '%@' ",  SINo];
		 //NSLog(@"%@", querySQL);
		 
		 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		 {
			 while (sqlite3_step(statement) == SQLITE_ROW)
			 {
				 if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2023"]){
					 F2023 = TRUE;
				 }
				 
				 if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2025"]){
					 F2025 = TRUE;
				 }
				 
				 if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2028"]){
					 F2028 = TRUE;
				 }
				 
				 if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2030"]){
					 F2030 = TRUE;
				 }
				 
				 if([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] isEqualToString:@"HLA EverGreen 2035"]){
					 F2035 = TRUE;
				 }

			 }
			 sqlite3_finalize(statement);
		 }
		 
		 /*
		 if (![txt2023.text isEqualToString:@"0"] && F2023 == FALSE) {
			 querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund ) VALUES ('%@', '%@', '%@', '%@', "
						 " '%@', '%@','%@','%@','%@','%@', '%@') ", SINo, @"HLA EverGreen 2023", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0"  ];
			 //NSLog(@"%@", querySQL);
			 
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			 {
				 if (sqlite3_step(statement) == SQLITE_DONE)
				 {
					 
				 }
				 sqlite3_finalize(statement);
			 }
		 }
		 */
		 
         //..
		 if (![txt2025.text isEqualToString:@"0"] && F2025 == FALSE) {
             /*
			 querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome,Venture6666,Venture7777,Venture8888,Venture9999 ) VALUES "
                         "('%@', '%@', '%@', '%@', '%@', '%@','%@','%@','%@','%@', '%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
                         SINo, @"HLA EverGreen 2025", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"  ];
              */
             
             querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome ) VALUES "
                         "('%@', '%@', '%@', '%@', '%@', '%@','%@','%@','%@','%@', '%@','%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
                         SINo, @"HLA EverGreen 2025", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"  ];
			 //NSLog(@"%@", querySQL);
			 
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			 {
				 if (sqlite3_step(statement) == SQLITE_DONE)
				 {
					 
				 }
				 sqlite3_finalize(statement);
			 }
		 }
		 
		 if (![txt2028.text isEqualToString:@"0"] && F2028 == FALSE) {
             /*
			 querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome,Venture6666,Venture7777,Venture8888,Venture9999 ) VALUES ('%@', '%@', '%@', '%@', "
						 " '%@', '%@','%@','%@','%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ", SINo, @"HLA EverGreen 2028", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"  ];
              */
             querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome ) VALUES ('%@', '%@', '%@', '%@', "
						 " '%@', '%@','%@','%@','%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
                         SINo, @"HLA EverGreen 2028", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0" ];
			 //NSLog(@"%@", querySQL);
			 
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			 {
				 if (sqlite3_step(statement) == SQLITE_DONE)
				 {
					 
				 }
				 sqlite3_finalize(statement);
			 }
		 }
		 
		 if (![txt2030.text isEqualToString:@"0"] && F2030 == FALSE) {
			 querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome) VALUES ('%@', '%@', '%@', '%@', "
						 " '%@', '%@','%@','%@','%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
                         SINo, @"HLA EverGreen 2030", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0"  ];
			 //NSLog(@"%@", querySQL);
			 
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			 {
				 if (sqlite3_step(statement) == SQLITE_DONE)
				 {
					 
				 }
				 sqlite3_finalize(statement);
			 }
		 }
		 
		 if (![txt2035.text isEqualToString:@"0"] && F2035 == FALSE) {
			 querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option (SINO, Fund, Option, Partial_Withd_Pct, "
						 "EverGreen2025, EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund,SmartFund, VentureFund,VentureGrowth,VentureBlueChip,VentureDana,VentureManaged,VentureIncome) VALUES ('%@', '%@', '%@', '%@', "
						 " '%@', '%@','%@','%@','%@','%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
                         SINo, @"HLA EverGreen 2035", @"ReInvest", @"0", @"0", @"0", @"0",@"0",@"100", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0" ];
			 //NSLog(@"%@", querySQL);
			 
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

-(void)getExisting{
	sqlite3_stmt *statement;
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
        //..
        /*
		NSString *querySQL = [NSString stringWithFormat: @"Select VU2023, VU2025, VU2028, "
							  "VU2030, VU2035, VUCash, VURET, VUCashOpt, VURetOpt, "
							  "ifnull(PolicySustainYear, 0), VUDana, VUDanaOpt, PlanCode, CovPeriod, ifnull(VUVenture, 0), ifnull(VUVentureOpt, 0), ifnull(VUSmart, 0), ifnull(VUSmartOpt, 0), ifnull(VUVentureGrowth, 0), ifnull(VUVentureOptGrowth, 0), ifnull(VUVentureBlueChip, 0), ifnull(VUVentureOptBlueChip, 0), ifnull(VUVentureDana, 0), ifnull(VUVentureOptDana, 0), ifnull(VUVentureManaged, 0), ifnull(VUVentureOptManaged, 0), ifnull(VUVentureIncome, 0), ifnull(VUVentureOptIncome, 0), ifnull(VUVenture6666, 0), ifnull(VUVentureOpt6666, 0), ifnull(VUVenture7777, 0), ifnull(VUVentureOpt7777, 0), ifnull(VUVenture8888, 0), ifnull(VUVentureOpt8888, 0), ifnull(VUVenture9999, 0), ifnull(VUVentureOpt9999, 0) FROM UL_Details where sino = '%@' ", SINo ];
         */
        NSString *querySQL = [NSString stringWithFormat: @"Select VU2023, VU2025, VU2028, "
							  "VU2030, VU2035, VUCash, VURET, VUCashOpt, VURetOpt, "
							  "ifnull(PolicySustainYear, 0), VUDana, VUDanaOpt, PlanCode, CovPeriod, ifnull(VUVenture, 0), ifnull(VUVentureOpt, 0), ifnull(VUSmart, 0), ifnull(VUSmartOpt, 0), ifnull(VUVentureGrowth, 0), ifnull(VUVentureOptGrowth, 0), ifnull(VUVentureBlueChip, 0), ifnull(VUVentureOptBlueChip, 0), ifnull(VUVentureDana, 0), ifnull(VUVentureOptDana, 0), ifnull(VUVentureManaged, 0), ifnull(VUVentureOptManaged, 0), ifnull(VUVentureIncome, 0), ifnull(VUVentureOptIncome, 0) FROM UL_Details where sino = '%@' ", SINo ];
        
		
		//NSLog(@"%@", querySQL);
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_ROW)
			{
					
				txt2023.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
				txt2025.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
				txt2028.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
				txt2030.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
				txt2035.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
				txtCashFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
				txtSecureFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
				txtExpireCashFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
				txtExpireSecureFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
				getSustainAge = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
				txtDanaFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)];
				txtExpireDanaFund.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)];
				planCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)];
				BasicTerm = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)];
                txtVentureFlexi.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)];
                txtExpireVentureFlexi.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)];

                ///
                self.txtVentureGrowth.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)];
                self.txtExpireVentureGrowth.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)];
                self.txtVentureBlueChip.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)];
                self.txtExpireVentureBlueChip.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 21)];
                self.txtVentureDana.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 22)];
                self.txtExpireVentureDana.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 23)];
                self.txtVentureManaged.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 24)];
                self.txtExpireVentureManaged.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 25)];
                self.txtVentureIncome.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 26)];
                self.txtExpireVentureIncome.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 27)];
                /*
                self.txtVenture6666.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 28)];
                self.txtExpireVenture6666.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 29)];
                self.txtVenture7777.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 30)];
                self.txtExpireVenture7777.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 31)];
                self.txtVenture8888.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 32)];
                self.txtExpireVenture8888.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 33)];
                self.txtVenture9999.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 34)];
                self.txtExpireVenture9999.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 35)];
                 */
                
			} else {
				//NSLog(@"error check tbl_Adm_TrnTypeNo");
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
}

-(void)toggle{
    //TBD
    //[txtExpireCashFund.text isEqualToString:@"0"] && [txtExpireSecureFund.text isEqualToString:@"0"]
	if ([txtVentureFlexi.text isEqualToString:@"0"] && [self.txtVentureGrowth.text isEqualToString:@"0"] && [self.txtVentureBlueChip.text isEqualToString:@"0"]&& [self.txtVentureDana.text isEqualToString:@"0"] && [self.txtDanaFund.text isEqualToString:@"0"] && [self.txtVentureManaged.text isEqualToString:@"0"] && [self.txtSecureFund.text isEqualToString:@"0"] && [self.txtVentureIncome.text isEqualToString:@"0"] ) {
		
        
        if ([txtExpireCashFund.text isEqualToString:@"0"] && [txtExpireSecureFund.text isEqualToString:@"0"] && [txtExpireDanaFund.text isEqualToString:@"0"] && [txtExpireVentureFlexi.text isEqualToString:@"0"]&& [self.txtExpireVentureGrowth.text isEqualToString:@"0"] && [self.txtExpireVentureBlueChip.text isEqualToString:@"0"]&& [self.txtExpireVentureManaged.text isEqualToString:@"0"]&& [self.txtExpireVentureDana.text isEqualToString:@"0"]&& [self.txtExpireVentureIncome.text isEqualToString:@"0"]) {
            if ([getSustainAge intValue] < 56) {
                self.txtExpireCashFund.text = @"1";
                self.txtExpireVentureBlueChip.text = @"99";
                self.txtExpireVentureManaged.text = @"0";
            }else {
                self.txtExpireCashFund.text = @"1";
                self.txtExpireVentureBlueChip.text = @"0";
                self.txtExpireVentureManaged.text = @"99";
            }
        }
        
        
        txt2023.enabled = FALSE;
		txt2025.enabled = FALSE;
		txt2025.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtDanaFund.enabled = FALSE;
        txtVentureFlexi.enabled = FALSE;
		txtExpireCashFund.enabled = TRUE;
		txtExpireSecureFund.enabled = TRUE;
		txtExpireDanaFund.enabled = TRUE;
        txtExpireVentureFlexi.enabled = TRUE;
		txt2023.backgroundColor = [UIColor lightGrayColor];
		txt2025.backgroundColor = [UIColor lightGrayColor];
		txt2028.backgroundColor = [UIColor lightGrayColor];
		txt2030.backgroundColor = [UIColor lightGrayColor];
		txt2035.backgroundColor = [UIColor lightGrayColor];
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtDanaFund.backgroundColor = [UIColor lightGrayColor];
        txtVentureFlexi.backgroundColor = [UIColor lightGrayColor];
		txtExpireCashFund.backgroundColor = [UIColor whiteColor];
		txtExpireSecureFund.backgroundColor = [UIColor whiteColor];
		txtExpireDanaFund.backgroundColor = [UIColor whiteColor];
        txtExpireVentureFlexi.backgroundColor = [UIColor whiteColor];
        
        ///
        self.txtVentureGrowth.enabled = false;
        self.txtVentureBlueChip.enabled = false;
        self.txtVentureDana.enabled = false;
        self.txtVentureManaged.enabled = false;
        self.txtVentureIncome.enabled = false;
        /*
        self.txtVenture6666.enabled = false;
        self.txtVenture7777.enabled = false;
        self.txtVenture8888.enabled = false;
        self.txtVenture9999.enabled = false;
         */
        self.txtExpireVentureGrowth.enabled = true;
        self.txtExpireVentureBlueChip.enabled = true;
        self.txtExpireVentureDana.enabled = true;
        self.txtExpireVentureManaged.enabled = true;
        self.txtExpireVentureIncome.enabled = true;
        /*
        self.txtExpireVenture6666.enabled = true;
        self.txtExpireVenture7777.enabled = true;
        self.txtExpireVenture8888.enabled = true;
        self.txtExpireVenture9999.enabled = true;
         */
        self.txtVentureGrowth.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureDana.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureManaged.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureIncome.backgroundColor = [UIColor lightGrayColor];
        /*
        self.txtVenture6666.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture7777.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture8888.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture9999.backgroundColor = [UIColor lightGrayColor];
         */
        self.txtExpireVentureGrowth.backgroundColor = [UIColor whiteColor];
        self.txtExpireVentureBlueChip.backgroundColor = [UIColor whiteColor];
        self.txtExpireVentureDana.backgroundColor = [UIColor whiteColor];
        self.txtExpireVentureManaged.backgroundColor = [UIColor whiteColor];
        self.txtExpireVentureIncome.backgroundColor = [UIColor whiteColor];
        /*
        self.txtExpireVenture6666.backgroundColor = [UIColor whiteColor];
        self.txtExpireVenture7777.backgroundColor = [UIColor whiteColor];
        self.txtExpireVenture8888.backgroundColor = [UIColor whiteColor];
        self.txtExpireVenture9999.backgroundColor = [UIColor whiteColor];
        */
	}
	else{
		
        txt2023.enabled = true;
		txt2025.enabled = TRUE;
		txt2025.enabled = TRUE;
		txt2030.enabled = TRUE;
		txt2035.enabled = TRUE;
		txtCashFund.enabled = TRUE;
		txtSecureFund.enabled = TRUE;
		txtDanaFund.enabled = TRUE;
        txtVentureFlexi.enabled = TRUE;
		txtExpireCashFund.enabled = false;
		txtExpireSecureFund.enabled = false;
		txtExpireDanaFund.enabled = false;
        txtExpireVentureFlexi.enabled = FALSE;
		txt2023.backgroundColor = [UIColor whiteColor];
		txt2025.backgroundColor = [UIColor whiteColor];
		txt2028.backgroundColor = [UIColor whiteColor];
		txt2030.backgroundColor = [UIColor whiteColor];
		txt2035.backgroundColor = [UIColor whiteColor];
		txtCashFund.backgroundColor = [UIColor whiteColor];
		txtSecureFund.backgroundColor = [UIColor whiteColor];
		txtDanaFund.backgroundColor = [UIColor whiteColor];
        txtVentureFlexi.backgroundColor = [UIColor whiteColor];
		txtExpireCashFund.backgroundColor = [UIColor lightGrayColor];
		txtExpireSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtExpireDanaFund.backgroundColor = [UIColor lightGrayColor];
        txtExpireVentureFlexi.backgroundColor = [UIColor lightGrayColor];
        
        ///
        self.txtVentureGrowth.enabled = true;
        self.txtVentureBlueChip.enabled = true;
        self.txtVentureDana.enabled = true;
        self.txtVentureManaged.enabled = true;
        self.txtVentureIncome.enabled = true;
        /*
        self.txtVenture6666.enabled = true;
        self.txtVenture7777.enabled = true;
        self.txtVenture8888.enabled = true;
        self.txtVenture9999.enabled = true;
         */
        self.txtExpireVentureGrowth.enabled = false;
        self.txtExpireVentureBlueChip.enabled = false;
        self.txtExpireVentureDana.enabled = false;
        self.txtExpireVentureManaged.enabled = false;
        self.txtExpireVentureIncome.enabled = false;
        /*
        self.txtExpireVenture6666.enabled = false;
        self.txtExpireVenture7777.enabled = false;
        self.txtExpireVenture8888.enabled = false;
        self.txtExpireVenture9999.enabled = false;
         */
        self.txtVentureGrowth.backgroundColor = [UIColor whiteColor];
        self.txtVentureBlueChip.backgroundColor = [UIColor whiteColor];
        self.txtVentureDana.backgroundColor = [UIColor whiteColor];
        self.txtVentureManaged.backgroundColor = [UIColor whiteColor];
        self.txtVentureIncome.backgroundColor = [UIColor whiteColor];
        /*
        self.txtVenture6666.backgroundColor = [UIColor whiteColor];
        self.txtVenture7777.backgroundColor = [UIColor whiteColor];
        self.txtVenture8888.backgroundColor = [UIColor whiteColor];
        self.txtVenture9999.backgroundColor = [UIColor whiteColor];
         */
        self.txtExpireVentureGrowth.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureDana.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureManaged.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureIncome.backgroundColor = [UIColor lightGrayColor];
        /*
        self.txtExpireVenture6666.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture7777.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture8888.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture9999.backgroundColor = [UIColor lightGrayColor];
        */
	}
	
    //NSLog(@" dasdadas %@", getSustainAge);

	if ([getSustainAge intValue] != 0) {

		if ([getSustainAge isEqualToString:@"65"]) {
			outletSustain.selectedSegmentIndex = 0;
			outletAge.selectedSegmentIndex = 0;
			txtAge.enabled = FALSE;
			txtAge.text = @"";
			txtAge.backgroundColor = [UIColor lightGrayColor];
		}
		else if ([getSustainAge isEqualToString:@"85"]) {
			outletSustain.selectedSegmentIndex = 0;
			outletAge.selectedSegmentIndex = 1;
			txtAge.enabled = FALSE;
			txtAge.text = @"";
			txtAge.backgroundColor = [UIColor lightGrayColor];
		}
		else if ([getSustainAge isEqualToString:@"100"]) {
			outletSustain.selectedSegmentIndex = 0;
			outletAge.selectedSegmentIndex = 2;
			txtAge.enabled = FALSE;
			txtAge.text = @"";
			txtAge.backgroundColor = [UIColor lightGrayColor];
		}
		else{
			outletSustain.selectedSegmentIndex = 0;
			outletAge.selectedSegmentIndex = 3;
			txtAge.enabled = TRUE;
			txtAge.backgroundColor = [UIColor whiteColor];
			txtAge.text = getSustainAge;
		}
	}
	else{
		outletSustain.selectedSegmentIndex = 1;
		outletAge.enabled = FALSE;
		txtAge.enabled = FALSE;
		txtAge.backgroundColor = [UIColor lightGrayColor];
	}
	
	if([planCode isEqualToString:@"UP"] && [BasicTerm intValue] == 20  ){
		txt2035.text = @"0";
		[self DisableTextField:txt2035];
	}else if([planCode isEqualToString:@"UP"] && [BasicTerm intValue] == 25  ){
		txt2030.text = @"0";
		[self DisableTextField:txt2030];
	}

    
    
}

-(BOOL)Validation{
	
	[self ValidateString];
    
	int total = [txt2023.text intValue] + [txt2025.text intValue] + [txt2028.text intValue] + [txt2030.text intValue] +
				[txt2035.text intValue] + [txtSecureFund.text intValue] + [txtCashFund.text intValue] + [txtDanaFund.text intValue] + [txtVentureFlexi.text intValue] + [self.txtVentureGrowth.text intValue] + [self.txtVentureBlueChip.text intValue] + [self.txtVentureDana.text intValue] + [self.txtVentureManaged.text intValue] + [self.txtVentureIncome.text intValue] + [self.txtVenture6666.text intValue] + [self.txtVenture7777.text intValue] + [self.txtVenture8888.text intValue] + [self.txtVenture9999.text intValue];
	
	if (total != 100){
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Fund Allocation is 100% allocated into HLA Cash Fund. You may want to consider allocating more premiums into other available funds for potential better return." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txt2023 becomeFirstResponder ];
		return FALSE;
	}
	else if ([txtCashFund.text isEqualToString:@"0"]) {
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Fund Allocation for HLA Cash Fund cannot be less than 1%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtCashFund becomeFirstResponder ];
		return FALSE;
	}
	else if (txtExpireCashFund.enabled == TRUE && [txtExpireCashFund.text intValue] + [txtExpireSecureFund.text intValue] + [txtExpireDanaFund.text intValue] + [txtExpireVentureFlexi.text intValue] + [self.txtExpireVentureGrowth.text intValue] + [self.txtExpireVentureBlueChip.text intValue] + [self.txtExpireVentureManaged.text intValue] + [self.txtExpireVentureDana.text intValue] + [self.txtExpireVentureIncome.text intValue] + [self.txtExpireVenture6666.text intValue] + [self.txtExpireVenture7777.text intValue] + [self.txtExpireVenture8888.text intValue] + [self.txtExpireVenture9999.text intValue]  != 100 ) {
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Total Fund Percentage must be 100%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtCashFund becomeFirstResponder ];
		return FALSE;
	}
	else if (outletSustain.selectedSegmentIndex == 0 && outletAge.selectedSegmentIndex == 3 && [txtAge.text intValue] > 100 && [planCode isEqualToString:@"UV"]) {
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Maximum Policy Sustainability (Age) is 100." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtAge becomeFirstResponder ];
		return FALSE;
	}
    else if (outletSustain.selectedSegmentIndex == 0 && outletAge.selectedSegmentIndex == 3 && ([txtAge.text intValue] > [BasicTerm intValue] + getAge) && [planCode isEqualToString:@"UP"]) {
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:[NSString stringWithFormat:@"Maximum Policy Sustainability (Age) is %d .", [BasicTerm intValue] + getAge] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtAge becomeFirstResponder ];
		return FALSE;
	}
	else if(outletSustain.selectedSegmentIndex == 0 && outletAge.selectedSegmentIndex == 3 && [txtAge.text intValue ] < getAge + 10){
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:[NSString stringWithFormat:@"Minimum Policy Sustainability (Age) is %d ", getAge + 10] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtAge becomeFirstResponder ];
		return FALSE;
	}
	else if ([txtSecureFund.text isEqualToString:@"0"] && [txtDanaFund.text isEqualToString:@"0"] && [txtVentureFlexi.text isEqualToString:@"0"] &&
			 [txtExpireCashFund.text isEqualToString:@"0"] && ![txtCashFund.text isEqualToString:@"100"] &&
			 [txtExpireSecureFund.text isEqualToString:@"0"] && [txtExpireDanaFund.text isEqualToString:@"0"] &&
             [txtExpireVentureFlexi.text isEqualToString:@"0"] && [self.txtVentureGrowth.text isEqualToString:@"0"] && [self.txtVentureBlueChip.text isEqualToString:@"0"] && [self.txtVentureDana.text isEqualToString:@"0"] && [self.txtVentureManaged.text isEqualToString:@"0"]&& [self.txtVentureIncome.text isEqualToString:@"0"]&& [self.txtVenture6666.text isEqualToString:@"0"]&& [self.txtVenture7777.text isEqualToString:@"0"]&& [self.txtVenture8888.text isEqualToString:@"0"]&& [self.txtVenture9999.text isEqualToString:@"0"] &&
			 [self.txtExpireVentureGrowth.text isEqualToString:@"0"]&&
			 [self.txtExpireVentureBlueChip.text isEqualToString:@"0"]&&
			 [self.txtExpireVentureDana.text isEqualToString:@"0"]&&
			 [self.txtExpireVentureManaged.text isEqualToString:@"0"]&&
			 [self.txtExpireVentureIncome.text isEqualToString:@"0"]&&
			 [self.txtExpireVenture6666.text isEqualToString:@"0"]&&
			 [self.txtExpireVenture7777.text isEqualToString:@"0"]&&
			 [self.txtExpireVenture8888.text isEqualToString:@"0"]&&
			 [self.txtExpireVenture9999.text isEqualToString:@"0"]) {
		NSString *msg;
		if (![txt2035.text isEqualToString:@"0"]) {
			msg = @"Please insert the fund allocation after 25/11/2035 which HLA EverGreen 2035 is closed for investment";
		}
		else if (![txt2030.text isEqualToString:@"0"]){
			msg = @"Please insert the fund allocation after 25/11/2030 which HLA EverGreen 2030 is closed for investment";
		}
		else if (![txt2028.text isEqualToString:@"0"]){
			msg = @"Please insert the fund allocation after 25/11/2028 which HLA EverGreen 2028 is closed for investment";
		}
		else if (![txt2025.text isEqualToString:@"0"]){
			msg = @"Please insert the fund allocation after 25/11/2025 which HLA EverGreen 2025 is closed for investment";
		}
		/*
		else if (![txt2023.text isEqualToString:@"0"]){
			msg = @"Please insert the fund allocation after 25/11/2023 which HLA EverGreen 2023 is closed for investment";
		}
		*/
		
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		failAlert.tag = 1;
		[failAlert show];
		return FALSE;
	}
	else if (![txtExpireSecureFund.text isEqualToString:@""] && [txtExpireCashFund.text isEqualToString:@"0"] && txtExpireCashFund.enabled == TRUE){
		UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
															message:[NSString stringWithFormat:@"Fund Allocation for HLA Cash Fund cannot be less than 1%%"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[failAlert show];
		[txtExpireCashFund becomeFirstResponder ];
		return FALSE;
	}
	else{
		return TRUE;
	}
	
}


-(void)ValidateString{
	if ([txt2023.text isEqualToString:@""]) {
		txt2023.text = @"0";
	}
	if ([txt2025.text isEqualToString:@""]) {
		txt2025.text = @"0";
	}
	if ([txt2028.text isEqualToString:@""]) {
		txt2028.text = @"0";
	}
	if ([txt2030.text isEqualToString:@""]) {
		txt2030.text = @"0";
	}
	if ([txt2035.text isEqualToString:@""]) {
		txt2035.text = @"0";
	}
	if ([txtCashFund.text isEqualToString:@""]) {
		txtCashFund.text = @"0";
	}
	if ([txtSecureFund.text isEqualToString:@""]) {
		txtSecureFund.text = @"0";
	}
	if ([txtDanaFund.text isEqualToString:@""]) {
		txtDanaFund.text = @"0";
	}
	if ([txtExpireCashFund.text isEqualToString:@""]) {
		txtExpireCashFund.text = @"0";
	}
	if ([txtExpireSecureFund.text isEqualToString:@""]) {
		txtExpireSecureFund.text = @"0";
	}
	if ([txtExpireDanaFund.text isEqualToString:@""]) {
		txtExpireDanaFund.text = @"0";
	}
    if ([txtVentureFlexi.text isEqualToString:@""]) {
        txtVentureFlexi.text = @"0";
	}
    if ([txtExpireVentureFlexi.text isEqualToString:@""]) {
        txtExpireVentureFlexi.text = @"0";
	}
    
    ///
    if ([self.txtVentureGrowth.text isEqualToString:@""]) {
        self.txtVentureGrowth.text = @"0";
    }
    if ([self.txtExpireVentureGrowth.text isEqualToString:@""]) {
        self.txtExpireVentureGrowth.text = @"0";
    }
    if ([self.txtVentureBlueChip.text isEqualToString:@""]) {
        self.txtVentureBlueChip.text = @"0";
    }
    if ([self.txtExpireVentureBlueChip.text isEqualToString:@""]) {
        self.txtExpireVentureBlueChip.text = @"0";
    }
    if ([self.txtVentureDana.text isEqualToString:@""]) {
        self.txtVentureDana.text = @"0";
    }
    if ([self.txtExpireVentureDana.text isEqualToString:@""]) {
        self.txtExpireVentureDana.text = @"0";
    }
    if ([self.txtVentureManaged.text isEqualToString:@""]) {
        self.txtVentureManaged.text = @"0";
    }
    if ([self.txtExpireVentureManaged.text isEqualToString:@""]) {
        self.txtExpireVentureManaged.text = @"0";
    }
    if ([self.txtVentureIncome.text isEqualToString:@""]) {
        self.txtVentureIncome.text = @"0";
    }
    if ([self.txtExpireVentureIncome.text isEqualToString:@""]) {
        self.txtExpireVentureIncome.text = @"0";
    }
    if ([self.txtVenture6666.text isEqualToString:@""]) {
        self.txtVenture6666.text = @"0";
    }
    if ([self.txtExpireVenture6666.text isEqualToString:@""]) {
        self.txtExpireVenture6666.text = @"0";
    }
    if ([self.txtVenture7777.text isEqualToString:@""]) {
        self.txtVenture7777.text = @"0";
    }
    if ([self.txtExpireVenture7777.text isEqualToString:@""]) {
        self.txtExpireVenture7777.text = @"0";
    }
    if ([self.txtVenture8888.text isEqualToString:@""]) {
        self.txtVenture8888.text = @"0";
    }
    if ([self.txtExpireVenture8888.text isEqualToString:@""]) {
        self.txtExpireVenture8888.text = @"0";
    }
    if ([self.txtVenture9999.text isEqualToString:@""]) {
        self.txtVenture9999.text = @"0";
    }
    if ([self.txtExpireVenture9999.text isEqualToString:@""]) {
        self.txtExpireVenture9999.text = @"0";
    }
    
    
}

-(NSString *)ReturnSustainAge{
	NSString *returnValue;
	
	if (outletSustain.selectedSegmentIndex == 0) {
		if ([txtAge.text isEqualToString:@""]) {
			returnValue = getSustainAge;
		}
		else{
			returnValue = txtAge.text;
		}
	}
	else{
		returnValue = @"0";
	}
	
	return returnValue;
}

- (void)viewDidUnload {
	[self setTxt2023:nil];
	[self setTxt2025:nil];
	[self setTxt2028:nil];
	[self setTxt2030:nil];
	[self setTxt2035:nil];
	[self setTxtSecureFund:nil];
	[self setTxtCashFund:nil];
	[self setTxtExpireSecureFund:nil];
	[self setTxtExpireCashFund:nil];
	[self setOutletReset:nil];
	[self setOutletSustain:nil];
	[self setOutletAge:nil];
	[self setTxtAge:nil];
	[self setMyScrollView:nil];
	[self setTxtDanaFund:nil];
	[self setTxtExpireDanaFund:nil];
	[self setTxtDanaFund:nil];
	[self setTxtExpireDanaFund:nil];
    [self setOutletDone:nil];
    [self setOutletEAPP:nil];
	[self setOutletSpace:nil];
    [self setTxtVentureFlexi:nil];
    [self setTxtExpireVentureFlexi:nil];
    
    
    
	[super viewDidUnload];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

	if ([textField.text isEqualToString:@"0" ]) {
		//textField.text = @"";
	}

	activeField = textField;
	return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (string.length == 0) {
		return  YES;
	}

	if (textField.text.length > 2) {
		return NO;
	}
	
	NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
	if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
		return NO;
	}
	
    return YES;
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	NSLog(@"alertView.tag %i",alertView.tag);
	if (alertView.tag == 1001 && buttonIndex == 0) {
		
		[self InsertandUpdate];
	}
	else if (alertView.tag == 1) {
		txt2023.enabled = NO;
		txt2025.enabled = NO;
		txt2028.enabled = NO;
		txt2030.enabled = NO;
		txt2035.enabled = NO;
		txtCashFund.enabled = NO;
		txtSecureFund.enabled = NO;
		txtDanaFund.enabled = NO;
        txtVentureFlexi.enabled = NO;
		txt2023.backgroundColor = [UIColor lightGrayColor];
		txt2025.backgroundColor = [UIColor lightGrayColor];
		txt2028.backgroundColor = [UIColor lightGrayColor];
		txt2030.backgroundColor = [UIColor lightGrayColor];
		txt2035.backgroundColor = [UIColor lightGrayColor];
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtDanaFund.backgroundColor = [UIColor lightGrayColor];
		txtVentureFlexi.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureGrowth.enabled = NO;
        self.txtVentureBlueChip.enabled = NO;
        self.txtVentureDana.enabled = NO;
        self.txtVentureManaged.enabled = NO;
        self.txtVentureIncome.enabled = NO;
        self.txtVenture6666.enabled = NO;
        self.txtVenture7777.enabled = NO;
        self.txtVenture8888.enabled = NO;
        self.txtVenture9999.enabled = NO;
        self.txtVentureGrowth.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureDana.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureManaged.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureIncome.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture6666.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture7777.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture8888.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture9999.backgroundColor = [UIColor lightGrayColor];
        
        txtExpireCashFund.enabled = TRUE;
		txtExpireSecureFund.enabled = TRUE;
		txtExpireDanaFund.enabled = TRUE;
        txtExpireVentureFlexi.enabled = TRUE;
		txtExpireCashFund.backgroundColor = [UIColor whiteColor];
		txtExpireSecureFund.backgroundColor = [UIColor whiteColor];
		txtExpireDanaFund.backgroundColor = [UIColor whiteColor];
        txtExpireVentureFlexi.backgroundColor = [UIColor whiteColor];
		txtExpireCashFund.text = @"1";
		txtExpireSecureFund.text = @"0";
		txtExpireDanaFund.text = @"0";
        txtExpireVentureFlexi.text = @"0";
        
        //..
		if (getAge < 56) {
            self.txtExpireVentureBlueChip.text = @"99";
            self.txtExpireVentureManaged.text = @"0";
        }else{
            self.txtExpireVentureBlueChip.text = @"0";
            self.txtExpireVentureManaged.text = @"99";
        }
        
        self.txtExpireVentureGrowth.enabled = TRUE;
        self.txtExpireVentureBlueChip.enabled = TRUE;
        self.txtExpireVentureDana.enabled = TRUE;
        self.txtExpireVentureManaged.enabled = TRUE;
        self.txtExpireVentureIncome.enabled = TRUE;
        self.txtExpireVenture6666.enabled = TRUE;
        self.txtExpireVenture7777.enabled = TRUE;
        self.txtExpireVenture8888.enabled = TRUE;
        self.txtExpireVenture9999.enabled = TRUE;
        self.txtExpireVentureGrowth.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureDana.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureManaged.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVentureIncome.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture6666.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture7777.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture8888.backgroundColor = [UIColor lightGrayColor];
        self.txtExpireVenture9999.backgroundColor = [UIColor lightGrayColor];
        
        
	}
	else if (alertView.tag == 2 && buttonIndex == 0) {
		[txtExpireSecureFund becomeFirstResponder];
	}
	else if (alertView.tag == 2 && buttonIndex == 1) {
		[self InsertandUpdate];
	}
	else if (alertView.tag == 3 && buttonIndex == 0) {
		[txtExpireSecureFund becomeFirstResponder];
	}
	else if (alertView.tag == 3 && buttonIndex == 1) {
		[self InsertandUpdate];
		[_delegate FundAllocationGlobalSave];
	}
	else if (alertView.tag == 1007){
		if ([self Validation]  == TRUE) {
			/*
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			 */
			[self InsertandUpdate];
			[_delegate FundAllocationGlobalSave];
		}
	}
	
}

#pragma mark - Button action

-(BOOL)NewDone{
	
	if ([self Validation]  == TRUE) {
        NSLog(@"0");
			[self InsertandUpdate];
			return TRUE;
		
	}
	else{
		return FALSE;
	}
	
}

- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)ActionDone:(id)sender {
	
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
		if ([self Validation]  == TRUE) {
			/*
			if ([txtExpireCashFund.text isEqualToString:@"100"] && PromptOnce == 0){
				NSString *msg;
				if (![txt2035.text isEqualToString:@"0"]) {
					msg = @"Fund Allocation after 25/11/2035 which HLA EverGreen 2035 is closed for investment is 100% allocation into HLA Cash Fund.\n"
					"You may want to consider allocating more premiums into HLA Dana Suria and/or HLA Secure Fund for potential better return.\n\n"
					"Click 'OK' to revise allocation OR 'Cancel' to proceed and do not remind me again.";
				}
				else if (![txt2030.text isEqualToString:@"0"]){
					msg = @"Fund Allocation after 25/11/2030 which HLA EverGreen 2030 is closed for investment is 100% allocation into HLA Cash Fund.\n"
					"You may want to consider allocating more premiums into HLA Dana Suria and/or HLA Secure Fund for potential better return.\n\n"
					"Click 'OK' to revise allocation OR 'Cancel' to proceed and do not remind me again.";
				}
				else if (![txt2028.text isEqualToString:@"0"]){
					msg = @"Fund Allocation after 25/11/2028 which HLA EverGreen 2028 is closed for investment is 100% allocation into HLA Cash Fund.\n"
					"You may want to consider allocating more premiums into HLA Dana Suria and/or HLA Secure Fund for potential better return.\n\n"
					"Click 'OK' to revise allocation OR 'Cancel' to proceed and do not remind me again.";
				}
				else if (![txt2025.text isEqualToString:@"0"]){
					msg = @"Fund Allocation after 25/11/2025 which HLA EverGreen 2025 is closed for investment is 100% allocation into HLA Cash Fund.\n"
					"You may want to consider allocating more premiums into HLA Dana Suria and/or HLA Secure Fund for potential better return.\n\n"
					"Click 'OK' to revise allocation OR 'Cancel' to proceed and do not remind me again.";
				}
				
				else if (![txt2023.text isEqualToString:@"0"]){
					msg = @"Fund Allocation after 25/11/2023 which HLA EverGreen 2023 is closed for investment is 100% allocation into HLA Cash Fund.\n"
					"You may want to consider allocating more premiums into HLA Dana Suria and/or HLA Secure Fund for potential better return.\n\n"
					"Click 'OK' to revise allocation OR 'Cancel' to proceed and do not remind me again.";
				}
				
				PromptOnce = 1;
				UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" "
																	message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", Nil];
				
				failAlert.tag = 3;
				[failAlert show];
				
				
			}
			 */
			
				[self InsertandUpdate];
				[_delegate FundAllocationGlobalSave];
            [self getExisting];
            [self toggle];

			
			/*
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			 */
			
		}
	}
	
	
	
}


- (IBAction)ActionReset:(id)sender {
	txt2023.text = @"0";
	txt2025.text = @"0";
	txt2028.text = @"0";
	txt2030.text = @"0";
    txt2035.text = @"0";
	txtCashFund.text = @"0";
	txtSecureFund.text = @"0";
	txtDanaFund.text = @"0";
    txtVentureFlexi.text = @"0";
	txtExpireCashFund.text = @"0";
	txtExpireSecureFund.text = @"0";
	txtExpireDanaFund.text = @"0";
    txtExpireVentureFlexi.text = @"0";
	///
    self.txtVentureGrowth.text = @"0";
    self.txtVentureBlueChip.text = @"0";
    self.txtVentureDana.text = @"0";
    self.txtVentureManaged.text = @"0";
    self.txtVentureIncome.text = @"0";
    self.txtVenture6666.text = @"0";
    self.txtVenture7777.text = @"0";
    self.txtVenture8888.text = @"0";
    self.txtVenture9999.text = @"0";
    self.txtExpireVentureGrowth.text = @"0";
    self.txtExpireVentureBlueChip.text = @"0";
    self.txtExpireVentureDana.text = @"0";
    self.txtExpireVentureManaged.text = @"0";
    self.txtExpireVentureIncome.text = @"0";
    self.txtExpireVenture6666.text = @"0";
    self.txtExpireVenture7777.text = @"0";
    self.txtExpireVenture8888.text = @"0";
    self.txtExpireVenture9999.text = @"0";
    
	txt2023.enabled = TRUE;
	txt2025.enabled = TRUE;
	txt2025.enabled = TRUE;
	txt2030.enabled = TRUE;
	txt2035.enabled = TRUE;
	txtCashFund.enabled = TRUE;
	txtSecureFund.enabled = TRUE;
	txtDanaFund.enabled = TRUE;
    txtVentureFlexi.enabled = TRUE;
	txtExpireCashFund.enabled = false;
	txtExpireSecureFund.enabled = false;
	txtExpireDanaFund.enabled = false;
    txtExpireVentureFlexi.enabled = false;
	txt2023.backgroundColor = [UIColor whiteColor];
	txt2025.backgroundColor = [UIColor whiteColor];
	txt2028.backgroundColor = [UIColor whiteColor];
	txt2030.backgroundColor = [UIColor whiteColor];
	txt2035.backgroundColor = [UIColor whiteColor];
	txtCashFund.backgroundColor = [UIColor whiteColor];
	txtSecureFund.backgroundColor = [UIColor whiteColor];
	txtDanaFund.backgroundColor = [UIColor whiteColor];
    txtVentureFlexi.backgroundColor = [UIColor whiteColor];
	txtExpireCashFund.backgroundColor = [UIColor lightGrayColor];
	txtExpireSecureFund.backgroundColor = [UIColor lightGrayColor];
	txtExpireDanaFund.backgroundColor = [UIColor lightGrayColor];
    txtExpireVentureFlexi.backgroundColor = [UIColor lightGrayColor];
    
    ///
    self.txtVentureGrowth.enabled = true;
    self.txtVentureBlueChip.enabled = true;
    self.txtVentureDana.enabled = true;
    self.txtVentureManaged.enabled = true;
    self.txtVentureIncome.enabled = true;
    self.txtVenture6666.enabled = true;
    self.txtVenture7777.enabled = true;
    self.txtVenture8888.enabled = true;
    self.txtVenture9999.enabled = true;
    self.txtExpireVentureGrowth.enabled = false;
    self.txtExpireVentureBlueChip.enabled = false;
    self.txtExpireVentureDana.enabled = false;
    self.txtExpireVentureManaged.enabled = false;
    self.txtExpireVentureIncome.enabled = false;
    self.txtExpireVenture6666.enabled = false;
    self.txtExpireVenture7777.enabled = false;
    self.txtExpireVenture8888.enabled = false;
    self.txtExpireVenture9999.enabled = false;
    self.txtVentureGrowth.backgroundColor = [UIColor whiteColor];
    self.txtVentureBlueChip.backgroundColor = [UIColor whiteColor];
    self.txtVentureDana.backgroundColor = [UIColor whiteColor];
    self.txtVentureManaged.backgroundColor = [UIColor whiteColor];
    self.txtVentureIncome.backgroundColor = [UIColor whiteColor];
    self.txtVenture6666.backgroundColor = [UIColor whiteColor];
    self.txtVenture7777.backgroundColor = [UIColor whiteColor];
    self.txtVenture8888.backgroundColor = [UIColor whiteColor];
    self.txtVenture9999.backgroundColor = [UIColor whiteColor];
    self.txtExpireVentureGrowth.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVentureDana.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVentureManaged.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVentureIncome.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVenture6666.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVenture7777.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVenture8888.backgroundColor = [UIColor lightGrayColor];
    self.txtExpireVenture9999.backgroundColor = [UIColor lightGrayColor];
    
    
    ///revise busines logic
    if([planCode isEqualToString:@"UP"] && [BasicTerm intValue] == 20  ){
		txt2035.text = @"0";
		[self DisableTextField:txt2035];
	}else if([planCode isEqualToString:@"UP"] && [BasicTerm intValue] == 25  ){
		txt2030.text = @"0";
		[self DisableTextField:txt2030];
	}
    
    self.txtCashFund.text = @"1";
    if ([getSustainAge intValue] < 56) {
        
        self.txtVentureBlueChip.text = @"49";
        self.txtVentureManaged.text = @"0";
        if ([BasicTerm intValue] == 20) {
            txt2030.text = @"50";
            txt2035.text = @"0";
        }else if ([BasicTerm intValue] == 25){
            txt2030.text = @"0";
            txt2035.text = @"50";
        }
        
    }else{
        
        self.txtVentureBlueChip.text = @"0";
        self.txtVentureManaged.text = @"49";
        if ([BasicTerm intValue] == 20) {
            txt2030.text = @"50";
            txt2035.text = @"0";
        }else if ([BasicTerm intValue] == 25){
            txt2030.text = @"0";
            txt2035.text = @"50";
        }
    }
    ///
    
}

- (IBAction)ActionSustain:(id)sender {
	if (outletSustain.selectedSegmentIndex == 0) {
		outletAge.enabled = TRUE;
		
		if ([planCode isEqualToString:@"UV"]) {
            if (getAge > 55) {
                [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];
                
            }
            else if (getAge > 75){
                [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                [outletAge setEnabled:NO forSegmentAtIndex:1 ];
                [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];
                [[outletAge.subviews objectAtIndex:2] setAlpha:0.5];
            }
            else if (getAge > 90){
                [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                [outletAge setEnabled:NO forSegmentAtIndex:1 ];
                [outletAge setEnabled:NO forSegmentAtIndex:2 ];
                [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];
                [[outletAge.subviews objectAtIndex:2] setAlpha:0.5];
                [[outletAge.subviews objectAtIndex:1] setAlpha:0.5];
            }
            else{
                [outletAge setEnabled:YES forSegmentAtIndex:0 ];
                [outletAge setEnabled:YES forSegmentAtIndex:1 ];
                [outletAge setEnabled:YES forSegmentAtIndex:2 ];
                [[outletAge.subviews objectAtIndex:3] setAlpha:1];
                [[outletAge.subviews objectAtIndex:2] setAlpha:1];
                [[outletAge.subviews objectAtIndex:1] setAlpha:1];
            }
        }
		else{

            
            if (getAge + [BasicTerm intValue] < 65 ){
                [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                [outletAge setEnabled:NO forSegmentAtIndex:1 ];
                [outletAge setEnabled:NO forSegmentAtIndex:2 ];
                [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];
                [[outletAge.subviews objectAtIndex:2] setAlpha:0.5];
                [[outletAge.subviews objectAtIndex:1] setAlpha:0.5];
            }
            else{

                if (getAge + [BasicTerm intValue] >= 100){
                    [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                    [outletAge setEnabled:NO forSegmentAtIndex:1 ];
                    [[outletAge.subviews objectAtIndex:2] setAlpha:0.5];
                    [[outletAge.subviews objectAtIndex:1] setAlpha:0.5];
                }
                else if (getAge + [BasicTerm intValue] >= 85){
                    [outletAge setEnabled:NO forSegmentAtIndex:0 ];
                    [outletAge setEnabled:NO forSegmentAtIndex:2 ];
                    [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];
                    [[outletAge.subviews objectAtIndex:1] setAlpha:0.5];
                }
                else if (getAge + [BasicTerm intValue] >= 65) {

                    [outletAge setEnabled:NO forSegmentAtIndex:1 ];
                    [outletAge setEnabled:NO forSegmentAtIndex:2 ];
                    [[outletAge.subviews objectAtIndex:2] setAlpha:0.5];
                    [[outletAge.subviews objectAtIndex:3] setAlpha:0.5];

                }
            


            }
            
        }
		
	}
	else{
		outletAge.enabled = NO;
		outletAge.selectedSegmentIndex = -1;
		txtAge.enabled = FALSE;
		txtAge.text = @"";
		txtAge.backgroundColor = [UIColor lightGrayColor];
        
        [[outletAge.subviews objectAtIndex:3] setAlpha:1.0];
        [[outletAge.subviews objectAtIndex:2] setAlpha:1.0];
        [[outletAge.subviews objectAtIndex:1] setAlpha:1.0];
	}

}
- (IBAction)ActionAge:(id)sender {
	if (outletAge.selectedSegmentIndex == 0) {
		getSustainAge = @"60";
		txtAge.text = @"";
		txtAge.enabled = NO;
		txtAge.backgroundColor = [UIColor lightGrayColor];
	}
	else if (outletAge.selectedSegmentIndex == 1){
		getSustainAge = @"85";
		txtAge.text = @"";
		txtAge.enabled = NO;
		txtAge.backgroundColor = [UIColor lightGrayColor];
	}
	else if (outletAge.selectedSegmentIndex == 2){
		getSustainAge = @"100";
		txtAge.text = @"";
		txtAge.enabled = NO;
		txtAge.backgroundColor = [UIColor lightGrayColor];
	}
	else if (outletAge.selectedSegmentIndex == 3){
		txtAge.enabled = YES;
		txtAge.backgroundColor = [UIColor whiteColor];
	}
	
}



@end
